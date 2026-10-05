//===- Passes.cpp - QEMU conversion passes implementation -----------------===//
//
// Implementation of three passes for LLHD to QEMU conversion:
// 1. ClockSignalDetectionPass - Detect and mark clock signals (two-level)
// 2. DrvClassificationPass - Classify drv operations
// 3. ClockDrvRemovalPass - Remove filterable clock topology
//    (aligned with old framework SignalTracing.h)
//
//===----------------------------------------------------------------------===//

#include "ClockAnalysis.h"
#include "RTLAdapter.h"
#include "PassReports.h"
#include "mlir/Pass/Pass.h"
#include "llvm/ADT/ScopeExit.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/Attributes.h"
#include "mlir/Dialect/ControlFlow/IR/ControlFlowOps.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Interfaces/SideEffectInterfaces.h"
#include "circt/Dialect/HW/HWOps.h"
#include "circt/Dialect/Comb/CombOps.h"
#include "circt/Dialect/LLHD/LLHDOps.h"
#include "llvm/ADT/DenseSet.h"
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/ADT/ScopeExit.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/JSON.h"
#include "llvm/Support/MemoryBuffer.h"
#include "mlir/IR/SymbolTable.h"

// TableGen 生成的 Pass 声明
#define GEN_PASS_DECL_CLOCKSIGNALDETECTION
#define GEN_PASS_DEF_CLOCKSIGNALDETECTION
#define GEN_PASS_DECL_DRVCLASSIFICATION
#define GEN_PASS_DEF_DRVCLASSIFICATION
#define GEN_PASS_DECL_CLOCKDRVREMOVAL
#define GEN_PASS_DEF_CLOCKDRVREMOVAL
#define GEN_PASS_DECL_ACCUMULATERINGDETECT
#define GEN_PASS_DEF_ACCUMULATERINGDETECT
#include "Passes.h.inc"

using namespace mlir;
using namespace circt;
using namespace clock_analysis;

namespace {

//===----------------------------------------------------------------------===//
// Pass 1: ClockSignalDetectionPass
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// 第三档判决:时钟根归并 + 节拍/事件(beat / event)
//
// 判"是不是时钟"(L1/L2)之后,还要判"哪一种时钟":
//   · beat(节拍时钟,如 clk_i):只负责打拍子,不携带信息。settle 语义下拆掉
//     沿、让触发器每拍执行,正是它的本意。
//   · event(事件时钟,如 SPI 的 sck/csb):每个沿本身就是信息(搬一位数据 /
//     标记一次事件)。拆掉沿等于把信息扔了(spid_csb_sync 的握手对在 tick 里
//     以周期 4 振荡、片选脉冲假发——见 BACKEND_CONFLICTS.md)。
// 结构上两者在 IP 自己的 IR 里长得一样(都是 i1 顶层输入端口 + 一群进程 +
// 2sync 到主时钟域),差别是 SoC 知识(clkmgr 来的 vs 焊盘来的)。所以:
//   (1) 纯结构:把每个模块内的时钟 sig 归到顶层根端口(穿透实例端口、sig 驱动、
//       clock buffer/inverter/mux 这类 comb);
//   (2) 结构可定的一条:驱动最多进程的根 = PRIMARY,必为 beat,不可声明为 event;
//   (3) 其余根默认 beat(零回归),由 binding `clocks` 块声明 event;digest 输出
//       根表(qemu.clock_roots)供 AI/人填表。
//===----------------------------------------------------------------------===//

struct ClockRootResolver {
  ModuleOp mod;
  SymbolTable symTable;
  hw::HWModuleOp top;
  using Roots = llvm::SmallVector<StringRef, 2>;
  // 一条实例路径上的上下文:该模块 (input-port, bit) → 根
  using Ctx = llvm::DenseMap<std::pair<unsigned, unsigned>, Roots>;

  // 结果:每个时钟 sig 在各条实例路径上的根集合(按路径累积)
  llvm::DenseMap<Value, llvm::SmallVector<Roots, 2>> sigRootsByPath;
  // 每条路径上时钟触发进程的根 → 计数
  llvm::StringMap<int> rootProcCount, rootSigCount;
  unsigned pathsVisited = 0;
  // 每次 visit(模块+上下文)内的记忆化:实例→子上下文;(值,位)→根
  struct VisitCache {
    llvm::DenseMap<Operation *, Ctx> childCtx;
    llvm::DenseMap<std::pair<void *, unsigned>, Roots> valueRoots;
    llvm::DenseSet<std::pair<void *, unsigned>> inProgress;
  };

  explicit ClockRootResolver(ModuleOp m) : mod(m), symTable(m) {
    for (auto hm : mod.getOps<hw::HWModuleOp>())
      if (!hm.isPrivate()) { top = hm; break; }
  }

  static unsigned widthOf(Value v) {
    if (auto it = dyn_cast<IntegerType>(v.getType())) return it.getWidth();
    if (auto io = dyn_cast<llhd::RefType>(v.getType()))
      if (auto it = dyn_cast<IntegerType>(io.getNestedType())) return it.getWidth();
    return 0;
  }
  static std::optional<unsigned> constIndex(Value v) {
    if (auto c = v.getDefiningOp<hw::ConstantOp>()) return (unsigned)c.getValue().getZExtValue();
    return std::nullopt;
  }
  static void addAll(Roots &dst, llvm::ArrayRef<StringRef> src) {
    for (StringRef r : src)
      if (!llvm::is_contained(dst, r)) dst.push_back(r);
  }
  hw::HWModuleOp refMod(hw::InstanceOp inst) {
    return dyn_cast_or_null<hw::HWModuleOp>(symTable.lookup(inst.getModuleName()));
  }
  static hw::OutputOp outputOf(hw::HWModuleOp N) {
    for (auto &op : N.getBodyBlock()->getOperations())
      if (auto o = dyn_cast<hw::OutputOp>(op)) return o;
    return nullptr;
  }

  /// 在模块 P(上下文 ctx)内把值 v 的第 bit 位解析到根集合(记忆化)。
  /// 注意缓存按 (P, ctx) 的 VisitCache 隔离;进子模块时用子模块自己的缓存。
  void resolve(hw::HWModuleOp P, const Ctx &ctx, VisitCache &cache, Value v, unsigned bit,
               Roots &out, unsigned depth) {
    if (depth == 0 || !v) return;
    std::pair<void *, unsigned> key{v.getAsOpaquePointer(), bit};
    auto hit = cache.valueRoots.find(key);
    if (hit != cache.valueRoots.end()) { addAll(out, hit->second); return; }
    if (!cache.inProgress.insert(key).second) return;   // 环
    Roots local;
    resolveImpl(P, ctx, cache, v, bit, local, depth);
    cache.inProgress.erase(key);
    cache.valueRoots[key] = local;
    addAll(out, local);
  }

  void resolveImpl(hw::HWModuleOp P, const Ctx &ctx, VisitCache &cache, Value v, unsigned bit,
                   Roots &out, unsigned depth) {
    if (auto arg = dyn_cast<BlockArgument>(v)) {
      auto it = ctx.find({arg.getArgNumber(), bit});
      if (it != ctx.end()) addAll(out, it->second);
      return;
    }
    Operation *def = v.getDefiningOp();
    if (!def) return;
    if (auto prb = dyn_cast<llhd::ProbeOp>(def)) {
      resolveSigBit(P, ctx, cache, prb.getSignal(), bit, out, depth - 1);
      return;
    }
    if (auto inst = dyn_cast<hw::InstanceOp>(def)) {
      // 实例结果:进子模块,子模块上下文由本实例的实参在当前上下文里解析得到
      auto N = refMod(inst); if (!N) return;
      hw::OutputOp outOp = outputOf(N);
      unsigned resIdx = cast<OpResult>(v).getResultNumber();
      if (!outOp || resIdx >= outOp.getNumOperands()) return;
      const Ctx &childCtx = childContextCached(P, ctx, cache, inst, depth - 1);
      // 子模块用独立缓存(不同上下文的同一模块值不能共用缓存);为避免每次
      // 新建,把子缓存挂在父缓存里按实例存放
      VisitCache &childCache = childCaches[inst.getOperation()][&cache];
      resolve(N, childCtx, childCache, outOp.getOperand(resIdx), bit, out, depth - 1);
      return;
    }
    if (isa<hw::ConstantOp>(def)) return;
    if (auto ex = dyn_cast<comb::ExtractOp>(def)) {
      resolve(P, ctx, cache, ex.getInput(), bit + ex.getLowBit(), out, depth - 1);
      return;
    }
    if (auto cc = dyn_cast<comb::ConcatOp>(def)) {   // operands[0] 是最高位段
      unsigned acc = 0;
      for (int i = (int)cc.getNumOperands() - 1; i >= 0; --i) {
        Value o = cc.getOperand(i); unsigned w = widthOf(o);
        if (bit < acc + w) { resolve(P, ctx, cache, o, bit - acc, out, depth - 1); return; }
        acc += w;
      }
      return;
    }
    if (auto rep = dyn_cast<comb::ReplicateOp>(def)) {
      unsigned w = widthOf(rep.getInput());
      if (w) resolve(P, ctx, cache, rep.getInput(), bit % w, out, depth - 1);
      return;
    }
    if (auto mux = dyn_cast<comb::MuxOp>(def)) {   // 只看数据臂
      resolve(P, ctx, cache, mux.getTrueValue(), bit, out, depth - 1);
      resolve(P, ctx, cache, mux.getFalseValue(), bit, out, depth - 1);
      return;
    }
    if (isa<comb::XorOp, comb::AndOp, comb::OrOp>(def)) {  // 按位运算:同位
      for (Value opnd : def->getOperands())
        resolve(P, ctx, cache, opnd, bit, out, depth - 1);
      return;
    }
    // 其它(icmp / 算术 / 结构体…):不是时钟树,停。
  }

  void resolveSigBit(hw::HWModuleOp P, const Ctx &ctx, VisitCache &cache, Value sigOrEx, unsigned bit,
                     Roots &out, unsigned depth) {
    unsigned off = 0; Value sig = sigOrEx;
    while (auto ex = sig.getDefiningOp<llhd::SigExtractOp>()) {
      auto lo = constIndex(ex.getLowBit()); if (!lo) return;
      off += *lo; sig = ex.getInput();
    }
    unsigned b = bit + off;
    for (Operation *user : sig.getUsers()) {
      if (auto drv = dyn_cast<llhd::DriveOp>(user)) {
        if (drv.getSignal() == sig) resolve(P, ctx, cache, drv.getValue(), b, out, depth);
      } else if (auto ex = dyn_cast<llhd::SigExtractOp>(user)) {
        auto lo = constIndex(ex.getLowBit()); if (!lo) continue;
        unsigned w = widthOf(ex.getResult());
        if (b < *lo || b >= *lo + w) continue;
        for (Operation *u2 : ex.getResult().getUsers())
          if (auto drv2 = dyn_cast<llhd::DriveOp>(u2))
            if (drv2.getSignal() == ex.getResult())
              resolve(P, ctx, cache, drv2.getValue(), b - *lo, out, depth);
      }
    }
  }

  // 子缓存:实例 → (父缓存 → 子缓存)。用 unique_ptr 保证引用稳定。
  llvm::DenseMap<Operation *, llvm::DenseMap<VisitCache *, VisitCache>> childCaches;

  /// 实例 inst(在 P/ctx 里)的子模块上下文:逐实参逐位解析(记忆化)。
  const Ctx &childContextCached(hw::HWModuleOp P, const Ctx &ctx, VisitCache &cache,
                                hw::InstanceOp inst, unsigned depth) {
    auto it = cache.childCtx.find(inst.getOperation());
    if (it != cache.childCtx.end()) return it->second;
    Ctx child;
    for (unsigned k = 0; k < inst.getNumOperands(); ++k) {
      unsigned w = widthOf(inst.getOperand(k));
      if (w == 0 || w > 64) continue;   // 只跟标量总线;结构体不是时钟
      for (unsigned b = 0; b < w; ++b) {
        Roots roots;
        resolve(P, ctx, cache, inst.getOperand(k), b, roots, depth);
        if (!roots.empty()) child[{k, b}] = roots;
      }
    }
    return cache.childCtx[inst.getOperation()] = std::move(child);
  }

  /// 沿实例路径 DFS:每到一个模块,登记其时钟 sig 的根 & 时钟进程的根。
  void visit(hw::HWModuleOp M, const Ctx &ctx, unsigned depth) {
    if (depth == 0) {
      // A SILENT RETURN HERE ABANDONS A WHOLE SUBTREE — every register under
      // it stops being recognised as clocked.  hw.module cannot recurse, so
      // the instance graph is a DAG and its depth is a measurable property of
      // the design: the deepest of all 37 example IRs is 8 (csrng; aes and
      // flash_ctrl 7, the rest 6 or less).  32 is therefore 4x the measured
      // worst case rather than a guess — but if a design ever reaches it, it
      // must say so instead of quietly dropping the subtree.
      llvm::errs() << "  [HIER DEPTH] instance path exceeded 32 levels; the "
                      "subtree below @" << M.getName()
                   << " was NOT analysed for clocks\n";
      return;
    }
    pathsVisited++;
    VisitCache cache;
    llvm::DenseMap<Value, Roots> localSigRoots;
    M.walk([&](llhd::SignalOp sigOp) {
      if (!sigOp->hasAttr("qemu.is_clock")) return;
      Roots roots;
      resolveSigBit(M, ctx, cache, sigOp.getResult(), 0, roots, 64);
      localSigRoots[sigOp.getResult()] = roots;
      sigRootsByPath[sigOp.getResult()].push_back(roots);
      for (StringRef r : roots) rootSigCount[r]++;
    });
    M.walk([&](llhd::ProcessOp proc) {
      if (!proc->hasAttr("qemu.clock_triggered")) return;
      Roots procRoots;
      proc.walk([&](llhd::WaitOp w) {
        for (Value obs : w.getObserved())
          if (auto prb = obs.getDefiningOp<llhd::ProbeOp>()) {
            auto it = localSigRoots.find(prb.getSignal());
            if (it != localSigRoots.end()) addAll(procRoots, it->second);
          }
      });
      for (StringRef r : procRoots) rootProcCount[r]++;
    });
    M.walk([&](hw::InstanceOp inst) {
      auto N = refMod(inst); if (!N) return;
      Ctx child = childContextCached(M, ctx, cache, inst, 64);
      visit(N, child, depth - 1);
    });
    childCaches.clear();   // 子缓存只在本 visit 内有效
  }

  void run() {
    if (!top) return;
    Ctx ctx;
    for (auto arg : top.getBodyBlock()->getArguments()) {
      unsigned i = arg.getArgNumber(), w = widthOf(arg);
      for (unsigned b = 0; b < w; ++b) ctx[{i, b}] = {top.getInputName(i)};
    }
    visit(top, ctx, 32);
  }
};

struct ClockSignalDetectionPass
    : public ::impl::ClockSignalDetectionBase<ClockSignalDetectionPass> {
  using ClockSignalDetectionBase::ClockSignalDetectionBase;

  /// 读 binding JSON 的 `clocks` 块:{ "<top input port>": "beat" | "event" }。
  /// 只读这一块;其余块由 BackendBindingLoad 负责。文件不存在/无 clocks 块 → 空表。
  LogicalResult readClockDecls(ModuleOp mod, llvm::StringMap<StringRef> &decls) {
    if (bindingPath.empty()) return success();
    auto bufOrErr = llvm::MemoryBuffer::getFile(bindingPath);
    if (!bufOrErr) {
      mod.emitError() << "clock-signal-detection: cannot read binding "
                      << bindingPath;
      return failure();
    }
    auto parsed = llvm::json::parse((*bufOrErr)->getBuffer());
    if (!parsed) {
      mod.emitError() << "clock-signal-detection: binding is not valid JSON: "
                      << bindingPath;
      return failure();
    }
    const auto *root = parsed->getAsObject();
    const auto *clocks = root ? root->getObject("clocks") : nullptr;
    if (!clocks) return success();
    for (const auto &kv : *clocks) {
      auto kind = kv.second.getAsString();
      if (!kind || (*kind != "beat" && *kind != "event")) {
        mod.emitError() << "clock-signal-detection: binding clocks."
                        << StringRef(kv.first) << " must be \"beat\" or \"event\"";
        return failure();
      }
      decls[StringRef(kv.first)] = *kind == "event" ? "event" : "beat";
    }
    return success();
  }

  LogicalResult assignClockKinds(ModuleOp mod, int &eventClockSigs,
                                 llvm::SmallVectorImpl<std::string> &report) {
    MLIRContext *ctx = mod.getContext();
    llvm::StringMap<StringRef> decls;
    if (failed(readClockDecls(mod, decls))) return failure();

    ClockRootResolver rr(mod);
    if (!rr.top) return success();
    rr.run();
    llvm::outs() << "  [CLOCK-KIND] instance paths visited: " << rr.pathsVisited << "\n";
    llvm::StringMap<int> &rootSigCount = rr.rootSigCount;
    llvm::StringMap<int> &rootProcCount = rr.rootProcCount;

    // PRIMARY = 驱动最多进程的根
    StringRef primary; int best = -1;
    for (auto arg : rr.top.getBodyBlock()->getArguments()) {
      StringRef n = rr.top.getInputName(arg.getArgNumber());
      auto it = rootProcCount.find(n);
      int c = it == rootProcCount.end() ? 0 : it->second;
      if (c > best) { best = c; primary = n; }
    }

    // 校验声明:必须是顶层输入端口 & 是某处时钟的根;primary 不可声明 event
    llvm::StringSet<> eventRoots;
    for (auto &kv : decls) {
      StringRef port = kv.getKey();
      bool isInput = false;
      for (auto arg : rr.top.getBodyBlock()->getArguments())
        if (rr.top.getInputName(arg.getArgNumber()) == port) isInput = true;
      if (!isInput) {
        mod.emitError() << "clock-signal-detection: binding clocks." << port
                        << " is not an input port of @" << rr.top.getName();
        return failure();
      }
      if (!rootSigCount.count(port)) {
        mod.emitError() << "clock-signal-detection: binding clocks." << port
                        << " is not the root of any detected clock signal";
        return failure();
      }
      if (kv.getValue() == "event") {
        if (port == primary) {
          mod.emitError() << "clock-signal-detection: binding clocks." << port
                          << " is the PRIMARY clock (most processes) and "
                             "cannot be declared \"event\"";
          return failure();
        }
        eventRoots.insert(port);
      }
    }

    // 标记 kind:一个模块级 sig 被所有实例路径共享,只有当"每条路径都
    // 只落在 event 根上(且不含 primary)"才打 event;路径之间不一致(共享原语
    // 同时被两个时钟域使用)→ 保守 beat,并报 MIXED(需要按时钟域特化模块)。
    // 每条路径的判定:含 event 根、不含 primary、不含声明为 beat 的根 → event。
    // 未声明的根(scan_clk_i / mbist_en_i 这类经 DFT mux/门控混进来的)中性,
    // 不阻止 event——它们是解析器"宁多勿漏"的副产物,不是真实时钟域。
    int mixed = 0;
    for (auto &kv : rr.sigRootsByPath) {
      Value sig = kv.first;
      bool allEvent = !kv.second.empty(), anyEvent = false;
      for (auto &roots : kv.second) {
        bool hasEvent = false, hasBlock = false;
        for (StringRef r : roots) {
          if (eventRoots.count(r)) hasEvent = true;
          else if (r == primary || decls.count(r)) hasBlock = true;
        }
        if (hasEvent) anyEvent = true;
        if (!(hasEvent && !hasBlock)) allEvent = false;
      }
      bool isEvent = allEvent;
      sig.getDefiningOp()->setAttr("qemu.clock_kind",
                                   StringAttr::get(ctx, isEvent ? "event" : "beat"));
      if (isEvent) {
        eventClockSigs++;
        llvm::outs() << "  [CLOCK-KIND] event: " << getSignalName(sig)
                     << " (paths=" << kv.second.size() << ")\n";
      } else if (anyEvent) {
        mixed++;
        llvm::outs() << "  [CLOCK-KIND] MIXED (kept beat; module shared across "
                        "clock domains, needs specialization): "
                     << getSignalName(sig) << " paths=" << kv.second.size() << "\n";
      }
    }
    if (mixed)
      llvm::outs() << "  [CLOCK-KIND] " << mixed
                   << " clock sig(s) mixed across paths — kept beat\n";

    // 根表 → 顶层模块属性(digest 用)
    llvm::SmallVector<Attribute, 4> rootAttrs;
    llvm::outs() << "\n  Clock roots (top @" << rr.top.getName() << "):\n";
    for (auto arg : rr.top.getBodyBlock()->getArguments()) {
      StringRef n = rr.top.getInputName(arg.getArgNumber());
      if (!rootSigCount.count(n)) continue;
      int procs = rootProcCount.lookup(n);
      StringRef kind = (n == primary) ? "beat(primary)"
                       : eventRoots.count(n) ? "event"
                       : decls.count(n) ? "beat(declared)" : "beat(default)";
      llvm::outs() << "    " << n << ": clock_sigs=" << rootSigCount[n]
                   << " processes=" << procs << " kind=" << kind << "\n";
      report.push_back((n + ": clock_sigs=" + std::to_string(rootSigCount[n]) +
                        " processes=" + std::to_string(procs) + " kind=" + kind).str());
      NamedAttrList d;
      d.append("port", StringAttr::get(ctx, n));
      d.append("clock_sigs", IntegerAttr::get(IntegerType::get(ctx, 32), rootSigCount[n]));
      d.append("processes", IntegerAttr::get(IntegerType::get(ctx, 32), procs));
      d.append("primary", BoolAttr::get(ctx, n == primary));
      d.append("kind", StringAttr::get(ctx, eventRoots.count(n) ? "event" : "beat"));
      d.append("declared", BoolAttr::get(ctx, decls.count(n) > 0));
      rootAttrs.push_back(DictionaryAttr::get(ctx, d));
    }
    rr.top->setAttr("qemu.clock_roots", ArrayAttr::get(ctx, rootAttrs));
    return success();
  }

  void runOnOperation() override {
    ModuleOp mod = getOperation();
    MLIRContext *ctx = mod.getContext();

    // 匿名 sig 起唯一名。LLHD 降下来的临时网(always_comb 的中间量)没有 name,
    // getSignalName 对它们全部返回 "unnamed" → 发射器把一个模块里所有匿名 sig
    // 折成同一个状态字段 `unnamed`,互相覆盖(spi_device 顶层 internal_sd_en_out
    // 读到别的匿名量;passthrough 十几条 `unnamed =`)。这是全流水线的第一个
    // pass,在这里按模块编号命名 anon_<n>,后面所有 pass 看到的都是有名 sig。
    {
      int renamed = 0;
      mod.walk([&](hw::HWModuleOp hm) {
        int n = 0;
        hm.walk([&](llhd::SignalOp sigOp) {
          if (sigOp.getName().has_value() && !sigOp.getName()->empty()) return;
          sigOp.setNameAttr(StringAttr::get(ctx, "anon_" + std::to_string(n++)));
          renamed++;
        });
      });
      if (renamed)
        llvm::outs() << "[clock-signal-detection] named " << renamed
                     << " anonymous llhd.sig(s) (anon_<n> per module)\n";
    }
    // 通过"选中的信号引用"写:`llhd.drv (arith.select c, %a, %b), v` (SV 里
    // `if (c) a = v; else b = v;` / 对 net 的三目赋值降下来的形状)。翻译层只认
    // 具名 sig 目标,这种目标会变成 "unnamed"。改写成两条带使能的 drv:
    //   drv %a, v if c      drv %b, v if !c
    // 读侧的 prb(select) 由 CombTranslator 直接展开成三目,不需要改 IR。
    {
      int rewritten = 0;
      llvm::SmallVector<llhd::DriveOp, 16> todo;
      mod.walk([&](llhd::DriveOp drv) {
        if (drv.getSignal().getDefiningOp<arith::SelectOp>()) todo.push_back(drv);
      });
      for (llhd::DriveOp drv : todo) {
        // 只处理一层 select(嵌套的下一轮不会再出现;足够覆盖 OT 的用法)
        auto sel = drv.getSignal().getDefiningOp<arith::SelectOp>();
        OpBuilder b(drv);
        Location loc = drv.getLoc();
        Value c = sel.getCondition();
        Value notC = b.create<comb::XorOp>(loc, c, b.create<hw::ConstantOp>(loc, b.getI1Type(), 1));
        Value enA = drv.getEnable() ? (Value)b.create<comb::AndOp>(loc, drv.getEnable(), c) : c;
        Value enB = drv.getEnable() ? (Value)b.create<comb::AndOp>(loc, drv.getEnable(), notC) : notC;
        auto dA = b.create<llhd::DriveOp>(loc, sel.getTrueValue(), drv.getValue(), drv.getTime(), enA);
        auto dB = b.create<llhd::DriveOp>(loc, sel.getFalseValue(), drv.getValue(), drv.getTime(), enB);
        for (auto attr : drv->getAttrs()) { dA->setAttr(attr.getName(), attr.getValue()); dB->setAttr(attr.getName(), attr.getValue()); }
        drv.erase();
        rewritten++;
      }
      if (rewritten)
        llvm::outs() << "[clock-signal-detection] rewrote " << rewritten
                     << " drv-through-selected-signal into enabled drv pairs\n";
    }

    llvm::outs() << "========================================\n";
    llvm::outs() << "Pass 1: Clock Signal Detection\n";
    llvm::outs() << "========================================\n\n";

    int clockSignalsFound = 0;
    int clockTriggeredProcesses = 0;
    SmallVector<std::string, 16> clockSigNames;
    SmallVector<std::string, 16> clockProcLocs;

    mod.walk([&](hw::HWModuleOp hwMod) {
      llvm::outs() << "Module: @" << hwMod.getName() << "\n";

      // 收集所有信号
      llvm::DenseMap<Value, llhd::SignalOp> signals;
      hwMod.walk([&](llhd::SignalOp sigOp) {
        signals[sigOp.getResult()] = sigOp;
      });

      // 对每个 process 分析时钟信号
      hwMod.walk([&](llhd::ProcessOp proc) {
        bool isClockTriggered = false;
        Value clockSignal = nullptr;

        // 检查 wait 的观察信号
        proc.walk([&](llhd::WaitOp waitOp) {
          for (Value observed : waitOp.getObserved()) {
            if (auto prbOp = observed.getDefiningOp<llhd::ProbeOp>()) {
              Value sig = prbOp.getSignal();
              std::string sigName = getSignalName(sig);

              // 第一级检测
              bool passedLevel1 = isClockSignalByUsagePattern(sig, proc);

              // 第二级检测
              bool passedLevel2 = false;
              if (passedLevel1) {
                passedLevel2 = isClockByTriggerEffect(sig, proc);
                if (!passedLevel2) {
                  // 调试：为什么第二级检测失败
                  llvm::outs() << "  [DEBUG] " << sigName
                               << " passed level 1 but failed level 2 (has state modification)\n";
                }
              }

              // 两级检测
              if (passedLevel1 && passedLevel2) {
                // 标记信号为时钟
                if (auto sigOp = sig.getDefiningOp<llhd::SignalOp>()) {
                  if (!sigOp->hasAttr("qemu.is_clock")) {
                    sigOp->setAttr("qemu.is_clock", UnitAttr::get(ctx));
                    clockSignalsFound++;
                    clockSigNames.push_back(
                        (hwMod.getName() + "::" + sigName).str());
                    llvm::outs() << "  [CLOCK] Signal: " << sigName << "\n";
                  }
                }
                isClockTriggered = true;
                clockSignal = sig;
              }
            }
          }
        });

        // 标记 process 为时钟触发
        if (isClockTriggered) {
          proc->setAttr("qemu.clock_triggered", UnitAttr::get(ctx));
          clockTriggeredProcesses++;
          std::string locStr;
          llvm::raw_string_ostream locOs(locStr);
          proc.getLoc().print(locOs);
          locOs.flush();
          clockProcLocs.push_back(
              (hwMod.getName() + "::" + locStr).str());
          llvm::outs() << "  [CLOCK-TRIGGERED] Process at " << proc.getLoc() << "\n";
        }
      });
    });

    //=== 第三档判决:时钟根 + beat/event ===//
    int eventClockSigs = 0;
    llvm::SmallVector<std::string, 8> rootReport;
    if (failed(assignClockKinds(mod, eventClockSigs, rootReport)))
      return signalPassFailure();

    llvm::outs() << "\n----------------------------------------\n";
    llvm::outs() << "Summary:\n";
    llvm::outs() << "  Clock signals found: " << clockSignalsFound << "\n";
    llvm::outs() << "  Clock-triggered processes: " << clockTriggeredProcesses << "\n";
    llvm::outs() << "  Event-clock sigs (kind=event): " << eventClockSigs << "\n";
    llvm::outs() << "========================================\n\n";

    qemu_passes::writePassReport(
        "clock_signal_detection",
        [&](llvm::raw_ostream &os) {
          os << "Clock Signal Detection — summary\n";
          os << "================================\n";
          os << "Clock signals found:         " << clockSignalsFound << "\n";
          os << "Clock-triggered processes:   " << clockTriggeredProcesses
             << "\n\n";
          os << "-- Clock signals (<module>::<signal>) --\n";
          for (const auto &n : clockSigNames) os << "  " << n << "\n";
          os << "\n-- Clock-triggered processes (<module>::<loc>) --\n";
          for (const auto &n : clockProcLocs) os << "  " << n << "\n";
        });
  }
};

//===----------------------------------------------------------------------===//
// Pass 2: DrvClassificationPass
//===----------------------------------------------------------------------===//

struct DrvClassificationPass
    : public ::impl::DrvClassificationBase<DrvClassificationPass> {

  void runOnOperation() override {
    ModuleOp mod = getOperation();
    MLIRContext *ctx = mod.getContext();

    llvm::outs() << "========================================\n";
    llvm::outs() << "Pass 2: Drv Classification\n";
    llvm::outs() << "========================================\n\n";

    int unchangedCount = 0;
    int accumulateCount = 0;
    int loopIterCount = 0;
    int complexCount = 0;

    mod.walk([&](hw::HWModuleOp hwMod) {
      llvm::outs() << "Module: @" << hwMod.getName() << "\n";

      hwMod.walk([&](llhd::ProcessOp proc) {
        // 收集 wait blocks
        llvm::DenseSet<Block*> waitBlocks;
        proc.walk([&](llhd::WaitOp wait) {
          waitBlocks.insert(wait->getBlock());
        });

        // 事件域判定:进程的 wait 观察了 clock_kind=event 的时钟 sig。
        // 事件域里的 ACCUMULATE 计数器(SPI s2p/p2s 位计数、TPM bitcnt…)
        // 是"每个沿加一"的事件计数器,不是自由跑的定时器:必须留在 tick 里、
        // 由沿守卫驱动;走 ptimer 会把它的加减步骤整个丢掉(u_s2p_cnt 的
        // 减一在 tick 里变成空操作,8 个 sck 沿也拼不出一个字节)。这条规则
        // 由时钟种类推出,不看名字。ClockDrvRemoval 后事件时钟仍留在观察表
        // 里,所以分类的两次运行判定一致。
        bool eventDomain = false;
        proc.walk([&](llhd::WaitOp wait) {
          for (Value obs : wait.getObserved())
            if (auto prb = obs.getDefiningOp<llhd::ProbeOp>())
              if (auto sigOp = prb.getSignal().getDefiningOp<llhd::SignalOp>())
                if (auto k = sigOp->getAttrOfType<StringAttr>("qemu.clock_kind"))
                  if (k.getValue() == "event") eventDomain = true;
        });

        // 分类每个 drv
        proc.walk([&](llhd::DriveOp drv) {
          DrvClassResult result = classifyDrv(drv, waitBlocks);

          if (result.classification == DrvClass::ACCUMULATE && eventDomain) {
            llvm::outs() << "  [EVENT-DOMAIN] " << getSignalName(drv.getSignal())
                         << ": ACCUMULATE -> COMPLEX (event counter stays in tick)\n";
            result.classification = DrvClass::COMPLEX;
            result.stepValue = 0;
          }

          // Bus-FSM bit/byte ITERATORS (bit_index/byte_index/bit_idx) are
          // classified ACCUMULATE (q-1) and routed to a ptimer, so they don't
          // advance inside the bounded MMIO settle — the i2c/spi controller FSM
          // can't sequence its 8 bits per byte and the transaction stalls.
          // Unlike free-running TIMERS (rv_timer prescaler, aon count — kept on
          // ptimer + driven by the timer pump) and TIMEOUT counters (*_cnt:
          // stretch/nak/bus, which must NOT free-run in the settle or they fire
          // spuriously), these are transaction-internal loop iterators gated by
          // the FSM state.  Reclassify COMPLEX so their (gated) drive stays in
          // tick() and advances per settle round.  Scoped to the "_index"/"_idx"
          // naming (i2c controller/target FSM only; timers/spi use other names),
          // so no cross-device regression.
          if (result.classification == DrvClass::ACCUMULATE) {
            std::string sn = getSignalName(drv.getSignal());
            if (sn.find("_index") != std::string::npos ||
                sn.find("_idx") != std::string::npos) {
              result.classification = DrvClass::COMPLEX;
              result.stepValue = 0;
            }
          }

          // 添加分类属性
          StringAttr classAttr = StringAttr::get(ctx, drvClassToString(result.classification));
          drv->setAttr("qemu.drv_class", classAttr);

          // 对于 ACCUMULATE，添加步进值
          if (result.classification == DrvClass::ACCUMULATE) {
            drv->setAttr("qemu.step", IntegerAttr::get(
                IntegerType::get(ctx, 32), result.stepValue));
          }

          // 统计
          std::string sigName = getSignalName(drv.getSignal());
          switch (result.classification) {
            case DrvClass::UNCHANGED:
              unchangedCount++;
              llvm::outs() << "  [UNCHANGED] " << sigName << "\n";
              break;
            case DrvClass::ACCUMULATE:
              accumulateCount++;
              llvm::outs() << "  [ACCUMULATE] " << sigName
                           << " (step=" << result.stepValue << ")\n";
              break;
            case DrvClass::LOOP_ITER:
              loopIterCount++;
              llvm::outs() << "  [LOOP_ITER] " << sigName << "\n";
              break;
            case DrvClass::COMPLEX:
              complexCount++;
              llvm::outs() << "  [COMPLEX] " << sigName << "\n";
              break;
          }
        });
      });

      // 处理 process 外部的 drv（组合逻辑）
      hwMod.walk([&](llhd::DriveOp drv) {
        Operation *parent = drv->getParentOp();
        while (parent && !isa<llhd::ProcessOp>(parent) &&
               !isa<hw::HWModuleOp>(parent)) {
          parent = parent->getParentOp();
        }
        if (isa<llhd::ProcessOp>(parent))
          return;  // 已处理（in-process drv counted by the walk above）

        // Default newly seen comb drvs to UNCHANGED (don't overwrite an
        // existing classification — e.g. one that survived from a prior
        // pass run, or was seeded externally).
        bool freshDefault = false;
        if (!drv->hasAttr("qemu.drv_class")) {
          drv->setAttr("qemu.drv_class",
                       StringAttr::get(ctx, "UNCHANGED"));
          freshDefault = true;
        }

        // Always count for the summary, regardless of who set the attr.
        // Without this the summary report goes silently to all-zeros on
        // inputs that already carry `qemu.drv_class` from an earlier run.
        if (auto classAttr = drv->getAttrOfType<StringAttr>("qemu.drv_class")) {
          StringRef cls = classAttr.getValue();
          if      (cls == "UNCHANGED")  unchangedCount++;
          else if (cls == "ACCUMULATE") accumulateCount++;
          else if (cls == "LOOP_ITER")  loopIterCount++;
          else if (cls == "COMPLEX")    complexCount++;
        }

        if (freshDefault) {
          std::string sigName = getSignalName(drv.getSignal());
          llvm::outs() << "  [UNCHANGED] (comb) " << sigName << "\n";
        }
      });
    });

    llvm::outs() << "\n----------------------------------------\n";
    llvm::outs() << "Summary:\n";
    llvm::outs() << "  UNCHANGED:  " << unchangedCount << "\n";
    llvm::outs() << "  ACCUMULATE: " << accumulateCount << "\n";
    llvm::outs() << "  LOOP_ITER:  " << loopIterCount << "\n";
    llvm::outs() << "  COMPLEX:    " << complexCount << "\n";
    llvm::outs() << "========================================\n\n";

    qemu_passes::writePassReport(
        "drv_classification",
        [&](llvm::raw_ostream &os) {
          os << "Drv Classification — summary\n";
          os << "============================\n";
          os << "UNCHANGED:  " << unchangedCount << "\n";
          os << "ACCUMULATE: " << accumulateCount << "\n";
          os << "LOOP_ITER:  " << loopIterCount << "\n";
          os << "COMPLEX:    " << complexCount << "\n";
          os << "Total:      "
             << (unchangedCount + accumulateCount + loopIterCount +
                 complexCount)
             << "\n";
        });
  }
};

//===----------------------------------------------------------------------===//
// Pass 3: ClockDrvRemovalPass
// 完整删除时钟信号相关的 LLHD 拓扑链（对齐旧框架 SignalTracing.h）：
// 1. 收集时钟信号（qemu.is_clock 属性）
// 2. 对每个 clock-triggered process：
//    a. 收集 waitBlocks（旧框架同款）
//    b. 从 trigger OR 中剔除 clock edge term（最小改写，不误伤 enable guard）
//    c. 从 wait observed 中移除 clock probe（防止空 wait）
// 3. DCE：删除死代码（需要 isMemoryEffectFree）
// 4. 删除时钟的端口连接 drv（仅 BlockArgument 驱动值）
// 5. 删除时钟的 sig 定义
//===----------------------------------------------------------------------===//

struct ClockDrvRemovalPass
    : public ::impl::ClockDrvRemovalBase<ClockDrvRemovalPass> {

  //=== Step 0: 统一的 base signal 工具（对齐 ClockAnalysis.h 的 unwrap 思路）===//

  /// 获取信号的 base signal（穿透 SigExtract）
  static Value getBaseSignal(Value sig) {
    while (auto ex = sig.getDefiningOp<llhd::SigExtractOp>())
      sig = ex.getInput();
    return sig;
  }

  /// 检查信号是否是时钟信号（使用 base signal 比较）
  static bool isClockBaseSignal(Value sigOrExtract,
                                const llvm::DenseSet<Value> &clockSignals) {
    return clockSignals.count(getBaseSignal(sigOrExtract));
  }

  //=== Step 3.1: 拍平 OR 操作 ===//

  /// 将 OR 操作递归拍平为 terms 列表
  static void flattenOr(Value v, llvm::SmallVectorImpl<Value> &terms) {
    if (auto orOp = v.getDefiningOp<comb::OrOp>()) {
      for (auto opnd : orOp.getOperands())
        flattenOr(opnd, terms);
      return;
    }
    terms.push_back(v);
  }

  //=== Step 3.2: 严格的边沿检测 term 识别 ===//

  /// 边沿检测 term 结构：包含 base signal 信息
  struct EdgeTermInfo {
    bool isEdgeTerm = false;
    Value baseSignal;  // 边沿检测的信号
    llhd::ProbeOp directPrbOp;    // 直接 prb(sig)
    llhd::ProbeOp invertedPrbOp;  // xor(prb(sig), true) 里的 prb
  };

  /// 检查一个 term 是否是边沿检测模式，返回其 base signal
  /// 边沿检测模式：comb.and(prb(sig), xor(prb(sig), true))
  /// 必须同时有 direct prb 和 inverted prb，且指向同一 base signal
  EdgeTermInfo analyzeEdgeTerm(Value term) {
    EdgeTermInfo info;

    auto andOp = term.getDefiningOp<comb::AndOp>();
    if (!andOp)
      return info;

    Value directPrbSignal;
    Value invertedPrbSignal;

    for (Value operand : andOp.getOperands()) {
      // 检查直接的 prb
      if (auto prbOp = operand.getDefiningOp<llhd::ProbeOp>()) {
        directPrbSignal = getBaseSignal(prbOp.getSignal());
        info.directPrbOp = prbOp;
      }
      // 检查 xor(prb signal, true) - 取反
      if (auto xorOp = operand.getDefiningOp<comb::XorOp>()) {
        bool hasConstTrue = false;
        Value prbSig;
        for (Value xorOperand : xorOp.getOperands()) {
          if (auto constOp = xorOperand.getDefiningOp<hw::ConstantOp>()) {
            if (constOp.getValue().isAllOnes()) {
              hasConstTrue = true;
            }
          }
          if (auto prbOp = xorOperand.getDefiningOp<llhd::ProbeOp>()) {
            prbSig = getBaseSignal(prbOp.getSignal());
            info.invertedPrbOp = prbOp;
          }
        }
        if (hasConstTrue && prbSig) {
          invertedPrbSignal = prbSig;
        }
      }
    }

    // 边沿检测必须同时有直接 prb 和取反 prb，且指向同一 base signal
    if (directPrbSignal && invertedPrbSignal &&
        directPrbSignal == invertedPrbSignal) {
      info.isEdgeTerm = true;
      info.baseSignal = directPrbSignal;
    }

    return info;
  }

  //=== Step 3.3: 从 trigger 中剔除 clock edge terms 并重建条件 ===//

  /// 重建 OR 操作（从 terms 列表）
  Value rebuildOrChain(OpBuilder &builder, Location loc,
                       ArrayRef<Value> terms) {
    if (terms.empty())
      return nullptr;
    if (terms.size() == 1)
      return terms[0];

    // 递归构建二叉 OR 树
    Value result = terms[0];
    for (size_t i = 1; i < terms.size(); ++i) {
      result = builder.create<comb::OrOp>(loc, result, terms[i]);
    }
    return result;
  }

  //=== Step 4: 安全的 DCE（使用 MLIR MemoryEffect 接口 + 显式白名单）===//

  /// 检查操作是否没有内存副作用（对齐旧框架边界）
  /// 使用 MLIR 的 MemoryEffectOpInterface 优先，加上显式白名单
  static bool isOpMemoryEffectFree(Operation *op) {
    // 显式排除有副作用的 LLHD 操作（不可删除）
    if (isa<llhd::DriveOp, llhd::WaitOp, llhd::SignalOp>(op))
      return false;
    // 跳过 terminator
    if (op->hasTrait<OpTrait::IsTerminator>())
      return false;
    // 跳过容器操作
    if (isa<hw::HWModuleOp, llhd::ProcessOp>(op))
      return false;

    // 显式白名单：这些操作可以安全删除
    // llhd.sig.extract - 信号切片，纯函数，必须支持以解除 clock sig 的引用
    if (isa<llhd::SigExtractOp>(op))
      return true;
    // llhd.prb 是只读操作，可以安全删除
    if (isa<llhd::ProbeOp>(op))
      return true;
    // llhd.constant_time 是纯常量
    if (isa<llhd::ConstantTimeOp>(op))
      return true;
    // hw::ConstantOp
    if (isa<hw::ConstantOp>(op))
      return true;
    // comb 操作都是纯函数，无副作用
    if (op->getDialect() &&
        op->getDialect()->getNamespace() == "comb")
      return true;

    // 使用 MLIR MemoryEffect 接口作为兜底
    // 注意：某些 LLHD 操作可能没有正确实现此接口，所以显式白名单优先
    if (mlir::isMemoryEffectFree(op))
      return true;

    return false;
  }

  /// 运行安全的 DCE：只删除无副作用且无使用者的操作
  void runSafeDCE(hw::HWModuleOp hwMod, int &removedOps) {
    bool changed = true;
    int iterations = 0;
    const int maxIterations = 20;

    while (changed && iterations < maxIterations) {
      changed = false;
      iterations++;

      // 使用 post-order 收集所有操作
      llvm::SmallVector<Operation*, 64> allOps;
      hwMod.walk<WalkOrder::PostOrder>([&](Operation *op) {
        allOps.push_back(op);
      });

      for (Operation *op : allOps) {
        // 跳过不能删除的操作
        if (!isOpMemoryEffectFree(op))
          continue;

        // 检查结果是否都没有使用者
        bool hasLiveUsers = false;
        for (Value result : op->getResults()) {
          if (!result.use_empty()) {
            hasLiveUsers = true;
            break;
          }
        }

        if (!hasLiveUsers) {
          op->erase();
          removedOps++;
          changed = true;
        }
      }
    }
  }

  void runOnOperation() override {
    ModuleOp mod = getOperation();

    llvm::outs() << "========================================\n";
    llvm::outs() << "Pass 3: Clock Signal Removal (Fixed)\n";
    llvm::outs() << "(Aligned with old framework SignalTracing.h)\n";
    llvm::outs() << "========================================\n\n";

    int removedFromWait = 0;
    int rewrittenBranches = 0;
    int removedClockTerms = 0;
    int removedDCE = 0;
    int removedDrvs = 0;
    int removedSignals = 0;
    int removedProcesses = 0;

    //=== Step 1: 收集所有时钟信号（使用 base signal）===//
    // beat(节拍)时钟进 clockSignals,按下面 2b/2c/4/5 拆沿、删拓扑;
    // event(事件)时钟不进 clockSignals —— 它就是一根普通信号,只是要把它的
    // "上一拍值"物化出来、让沿检测作为数据守卫留在 tick 里(Step 2e)。
    llvm::DenseSet<Value> clockSignals;
    llvm::DenseSet<Value> eventClockSignals;
    int eventEdgeGuards = 0;
    int eventPrevSigs = 0;
    mod.walk([&](llhd::SignalOp sigOp) {
      if (!sigOp->hasAttr("qemu.is_clock")) return;
      auto kind = sigOp->getAttrOfType<StringAttr>("qemu.clock_kind");
      if (kind && kind.getValue() == "event") {
        eventClockSignals.insert(sigOp.getResult());
        llvm::outs() << "[STEP 1] Event clock (edge kept as data): "
                     << getSignalName(sigOp.getResult()) << "\n";
        return;
      }
      clockSignals.insert(sigOp.getResult());
      llvm::outs() << "[STEP 1] Clock signal: "
                   << getSignalName(sigOp.getResult()) << "\n";
    });

    if (clockSignals.empty() && eventClockSignals.empty()) {
      llvm::outs() << "No clock signals found. Nothing to remove.\n";
      return;
    }

    mod.walk([&](hw::HWModuleOp hwMod) {
      llvm::outs() << "\nModule: @" << hwMod.getName() << "\n";

      // 收集需要删除的 process（纯时钟触发的 process）
      // 使用 SmallPtrSet 去重，避免 double erase
      llvm::SmallPtrSet<Operation*, 8> processesToRemove;

      //=== Step 2e: 事件时钟——把沿检测从进程壳搬进数据 ===//
      // CombLogicExtract 把"wait 之后的触发门"一律当成恒真(每拍进身体),
      // 所以沿条件留在触发门里等于没有。做法:
      //   · 为事件时钟 sig 合成 <sig>_prev(普通记忆位:每拍 prev ⇐ sig,
      //     与 gpio data_in_q 同款,已证明在两相 tick 下给出正确逐拍语义);
      //   · 在触发门和身体之间插一个守卫块:
      //       guard = OR( 事件沿(posedge: ~prev & sig / negedge: prev & ~sig),
      //                   其它沿项的"wait 之后电平分量"(复位 negedge → ~rst),
      //                   非沿项原样 )
      //     守卫块的前驱是触发门(不是 wait),CombLogicExtract 会把它当真条件。
      //   · 复位保持电平语义(!rst 时无条件进身体走复位支路),事件沿只在
      //     沿到达那一拍成立一次,随后 prev 追平 → settle 静止。
      if (!eventClockSignals.empty()) {
        llvm::DenseMap<Value, Value> prevSigOf;  // event sig → prev sig
        auto getOrCreatePrev = [&](Value evSig) -> Value {
          auto it = prevSigOf.find(evSig);
          if (it != prevSigOf.end()) return it->second;
          auto sigOp = evSig.getDefiningOp<llhd::SignalOp>();
          OpBuilder b(sigOp);
          b.setInsertionPointAfter(sigOp);
          Location loc = sigOp.getLoc();
          std::string prevName = getSignalName(evSig) + "_prev";
          Value f = b.create<hw::ConstantOp>(loc, b.getI1Type(), 0);
          auto prevSig = b.create<llhd::SignalOp>(loc, b.getStringAttr(prevName), f);
          // 记忆位进程:每拍 prev ⇐ sig(放在模块末尾,单相 tick 引擎下也保证
          // 守卫先读到旧 prev)
          Operation *outOp = hwMod.getBodyBlock()->getTerminator();
          OpBuilder pb(outOp);
          auto tOp = pb.create<llhd::ConstantTimeOp>(loc, 0, "ns", 1, 0);
          auto proc = pb.create<llhd::ProcessOp>(loc, TypeRange{});
          proc->setAttr("qemu.clock_triggered", UnitAttr::get(hwMod.getContext()));
          proc->setAttr("qemu.synth_prev", UnitAttr::get(hwMod.getContext()));
          Region &r = proc.getBody();
          Block *entry = new Block(); r.push_back(entry);
          Block *waitB = new Block(); r.push_back(waitB);
          Block *bodyB = new Block(); r.push_back(bodyB);
          OpBuilder eb = OpBuilder::atBlockEnd(entry);
          eb.create<cf::BranchOp>(loc, waitB);
          OpBuilder wb = OpBuilder::atBlockEnd(waitB);
          Value obs = wb.create<llhd::ProbeOp>(loc, evSig);
          wb.create<llhd::WaitOp>(loc, ValueRange{}, Value(), ValueRange{obs},
                                  ValueRange{}, bodyB);
          OpBuilder bb = OpBuilder::atBlockEnd(bodyB);
          Value cur = bb.create<llhd::ProbeOp>(loc, evSig);
          bb.create<llhd::DriveOp>(loc, prevSig.getResult(), cur, tOp.getResult(), Value());
          bb.create<cf::BranchOp>(loc, waitB);
          eventPrevSigs++;
          llvm::outs() << "  [STEP 2e] Materialized " << prevName << "\n";
          prevSigOf[evSig] = prevSig.getResult();
          return prevSig.getResult();
        };

        llvm::SmallVector<llhd::ProcessOp, 16> procs;
        hwMod.walk([&](llhd::ProcessOp p) {
          if (p->hasAttr("qemu.clock_triggered") && !p->hasAttr("qemu.synth_prev"))
            procs.push_back(p);
        });
        for (llhd::ProcessOp proc : procs) {
          llvm::SmallPtrSet<Block*, 8> waitBlocks;
          proc.walk([&](llhd::WaitOp w) { waitBlocks.insert(w->getBlock()); });
          llvm::SmallVector<cf::CondBranchOp, 8> gates;
          proc.walk([&](cf::CondBranchOp cb) { gates.push_back(cb); });
          for (cf::CondBranchOp condBr : gates) {
            bool trueIsWait = waitBlocks.count(condBr.getTrueDest()) > 0;
            bool falseIsWait = waitBlocks.count(condBr.getFalseDest()) > 0;
            if (trueIsWait == falseIsWait) continue;  // 不是触发门
            llvm::SmallVector<Value, 4> terms;
            flattenOr(condBr.getCondition(), terms);
            bool hasEvent = false;
            for (Value t : terms) {
              EdgeTermInfo info = analyzeEdgeTerm(t);
              if (info.isEdgeTerm && eventClockSignals.count(info.baseSignal))
                hasEvent = true;
            }
            if (!hasEvent) continue;

            Block *idleBlock = trueIsWait ? condBr.getTrueDest() : condBr.getFalseDest();
            Block *bodyBlock = trueIsWait ? condBr.getFalseDest() : condBr.getTrueDest();
            llvm::SmallVector<Value, 4> idleArgs(
                trueIsWait ? condBr.getTrueDestOperands() : condBr.getFalseDestOperands());
            llvm::SmallVector<Value, 4> bodyArgs(
                trueIsWait ? condBr.getFalseDestOperands() : condBr.getTrueDestOperands());
            Location loc = condBr.getLoc();

            // 守卫块:插在触发门所在块之后
            Region *region = condBr->getBlock()->getParent();
            Block *guardB = new Block();
            region->getBlocks().insertAfter(condBr->getBlock()->getIterator(), guardB);
            OpBuilder gb = OpBuilder::atBlockEnd(guardB);
            Value tru = gb.create<hw::ConstantOp>(loc, gb.getI1Type(), 1);

            llvm::SmallVector<Value, 4> guardTerms;
            for (Value t : terms) {
              EdgeTermInfo info = analyzeEdgeTerm(t);
              if (!info.isEdgeTerm) { guardTerms.push_back(t); continue; }
              // 哪个 prb 是"wait 之前的旧值":定义在 wait 块里的那个
              bool directIsOld = info.directPrbOp &&
                                 waitBlocks.count(info.directPrbOp->getBlock());
              llhd::ProbeOp newPrb = directIsOld ? info.invertedPrbOp : info.directPrbOp;
              llhd::ProbeOp oldPrb = directIsOld ? info.directPrbOp : info.invertedPrbOp;
              if (!newPrb || !oldPrb) { guardTerms.push_back(t); continue; }
              // posedge = ~old & new  ⇔ 取反的是旧值
              bool posedge = (oldPrb == info.invertedPrbOp);
              Value newVal = newPrb.getResult();
              if (eventClockSignals.count(info.baseSignal)) {
                Value prevSig = getOrCreatePrev(info.baseSignal);
                Value prevVal = gb.create<llhd::ProbeOp>(loc, prevSig);
                Value edge;
                if (posedge) {
                  Value nPrev = gb.create<comb::XorOp>(loc, prevVal, tru);
                  edge = gb.create<comb::AndOp>(loc, nPrev, newVal);
                } else {
                  Value nNew = gb.create<comb::XorOp>(loc, newVal, tru);
                  edge = gb.create<comb::AndOp>(loc, prevVal, nNew);
                }
                guardTerms.push_back(edge);
                eventEdgeGuards++;
                llvm::outs() << "  [STEP 2e] Event edge guard ("
                             << (posedge ? "posedge" : "negedge") << ") on "
                             << getSignalName(info.baseSignal) << "\n";
              } else if (isClockBaseSignal(info.baseSignal, clockSignals)) {
                // 节拍时钟沿:交给 2b 剥掉,这里不进守卫
                continue;
              } else {
                // 复位等其它沿:取 wait 之后的电平分量(negedge rst → ~rst)
                Value lvl = posedge ? newVal
                                    : gb.create<comb::XorOp>(loc, newVal, tru).getResult();
                guardTerms.push_back(lvl);
              }
            }
            Value guard = rebuildOrChain(gb, loc, guardTerms);
            if (!guard) guard = tru;
            gb.create<cf::CondBranchOp>(loc, guard, bodyBlock, bodyArgs, idleBlock, idleArgs);

            // 触发门:身体边改指守卫块
            OpBuilder tb(condBr);
            if (trueIsWait)
              tb.create<cf::CondBranchOp>(loc, condBr.getCondition(),
                                          idleBlock, idleArgs, guardB, ValueRange{});
            else
              tb.create<cf::CondBranchOp>(loc, condBr.getCondition(),
                                          guardB, ValueRange{}, idleBlock, idleArgs);
            condBr.erase();
          }
        }
      }

      //=== 对每个 clock-triggered process 进行处理 ===//
      hwMod.walk([&](llhd::ProcessOp proc) {
        // 只处理标记为 clock_triggered 的 process
        if (!proc->hasAttr("qemu.clock_triggered"))
          return;

        llvm::outs() << "  Processing clock-triggered process at "
                     << proc.getLoc() << "\n";

        //=== Step 2a: 收集 waitBlocks（旧框架同款）===//
        llvm::SmallPtrSet<Block*, 8> waitBlocks;
        proc.walk([&](llhd::WaitOp waitOp) {
          waitBlocks.insert(waitOp->getBlock());
        });

        bool processModified = false;
        bool allConditionsRemoved = true;  // 是否所有触发条件都被移除

        // 内容轴预判：体内是否存在非自拷贝的真驱动。决定两处极性：
        // (1) Step 2b 剥光触发条件后，唤醒边接 body（有真驱动，每次唤醒必
        //     执行）还是接 idle（全自拷贝，身体本来就无内容）；
        // (2) Step 2c 纯时钟敏感表时，保进程还是整删。
        bool procHasRealDrv = false;
        proc.walk([&](llhd::DriveOp bodyDrv) {
          if (!isDrvHoldPattern(bodyDrv))
            procHasRealDrv = true;
        });

        //=== Step 2b: 对触发门 cond_br 做最小化改写 ===//
        llvm::SmallVector<cf::CondBranchOp, 8> condBrsToProcess;
        proc.walk([&](cf::CondBranchOp condBr) {
          condBrsToProcess.push_back(condBr);
        });

        for (cf::CondBranchOp condBr : condBrsToProcess) {
          Value cond = condBr.getCondition();

          // 使用 waitBlocks 判断 idle/body 分支
          Block *trueDest = condBr.getTrueDest();
          Block *falseDest = condBr.getFalseDest();

          bool trueIsWait = waitBlocks.count(trueDest) > 0;
          bool falseIsWait = waitBlocks.count(falseDest) > 0;

          // 不是标准触发门（两边都在或都不在 waitBlocks）：不处理
          if (trueIsWait == falseIsWait) {
            allConditionsRemoved = false;
            continue;
          }

          Block *idleBlock = trueIsWait ? trueDest : falseDest;
          Block *bodyBlock = trueIsWait ? falseDest : trueDest;
          OperandRange idleArgs = trueIsWait ? condBr.getTrueDestOperands()
                                             : condBr.getFalseDestOperands();
          OperandRange bodyArgs = trueIsWait ? condBr.getFalseDestOperands()
                                             : condBr.getTrueDestOperands();

          // 拍平 OR 条件
          llvm::SmallVector<Value, 4> terms;
          flattenOr(cond, terms);

          // 分析每个 term，剔除 clock edge terms
          llvm::SmallVector<Value, 4> remainingTerms;
          bool removedAnyClockTerm = false;

          for (Value term : terms) {
            EdgeTermInfo info = analyzeEdgeTerm(term);
            if (info.isEdgeTerm && isClockBaseSignal(info.baseSignal, clockSignals)) {
              // 这是 clock edge term，剔除
              llvm::outs() << "    [STEP 2b] Remove clock edge term for: "
                           << getSignalName(info.baseSignal) << "\n";
              removedAnyClockTerm = true;
              removedClockTerms++;
            } else {
              // 保留（例如 reset edge term 或 enable guard）
              remainingTerms.push_back(term);
            }
          }

          if (!removedAnyClockTerm) {
            // 没有移除任何 clock term，不改写（避免误伤 enable gating）
            allConditionsRemoved = false;
            continue;
          }

          processModified = true;

          if (remainingTerms.empty()) {
            // 所有 terms 都被移除：这个触发门只由 clock 触发。
            // 极性按内容轴决定："拆闹钟，不拆日程"——
            //  · 有真驱动：唤醒边接 body，时钟沿退化为"每次唤醒必执行"
            //    （settle/tick 语义下即每拍执行一次，正是 always_ff 的本意）。
            //    接 idle 会把身体块变成孤儿，CombLogicExtract 只走可达路径，
            //    drv 随之蒸发（gpio data_in_q 采样器之死，探针 R=5）。
            //  · 全是自拷贝：身体无内容，接 idle 即可（2c 随后整删进程）。
            OpBuilder builder(condBr);
            if (procHasRealDrv) {
              llvm::outs() << "    [STEP 2b] All terms removed, real drvs"
                              " present -> jump to body (run on every wake)\n";
              llvm::SmallVector<Value, 4> bodyArgsVec(bodyArgs.begin(), bodyArgs.end());
              builder.create<cf::BranchOp>(condBr.getLoc(), bodyBlock, bodyArgsVec);
            } else {
              llvm::outs() << "    [STEP 2b] All terms removed, jump to idle\n";
              llvm::SmallVector<Value, 4> idleArgsVec(idleArgs.begin(), idleArgs.end());
              builder.create<cf::BranchOp>(condBr.getLoc(), idleBlock, idleArgsVec);
            }
            condBr.erase();
            rewrittenBranches++;
          } else {
            // 重建条件（只保留非 clock terms）
            allConditionsRemoved = false;
            OpBuilder builder(condBr);
            Value newCond = rebuildOrChain(builder, condBr.getLoc(), remainingTerms);

            // 创建新的 cond_br
            llvm::SmallVector<Value, 4> trueArgsVec, falseArgsVec;
            if (trueIsWait) {
              trueArgsVec.assign(idleArgs.begin(), idleArgs.end());
              falseArgsVec.assign(bodyArgs.begin(), bodyArgs.end());
            } else {
              trueArgsVec.assign(bodyArgs.begin(), bodyArgs.end());
              falseArgsVec.assign(idleArgs.begin(), idleArgs.end());
            }

            builder.create<cf::CondBranchOp>(
                condBr.getLoc(), newCond,
                trueDest, trueArgsVec,
                falseDest, falseArgsVec);
            condBr.erase();
            rewrittenBranches++;
            llvm::outs() << "    [STEP 2b] Rebuilt trigger condition\n";
          }
        }

        //=== Step 2c: 从 wait observed 中移除 clock probe ===//
        if (processModified) {
          // 检查是否已经被标记为要删除的 process
          if (processesToRemove.contains(proc.getOperation()))
            return;  // 已标记删除，跳过

          proc.walk([&](llhd::WaitOp waitOp) -> WalkResult {
            // 如果 process 已被标记删除，中断 walk
            if (processesToRemove.contains(proc.getOperation()))
              return WalkResult::interrupt();

            llvm::SmallVector<unsigned, 4> indicesToRemove;
            auto observed = waitOp.getObserved();
            unsigned nonClockCount = 0;

            for (unsigned i = 0; i < observed.size(); ++i) {
              Value obs = observed[i];
              if (auto prbOp = obs.getDefiningOp<llhd::ProbeOp>()) {
                if (isClockBaseSignal(prbOp.getSignal(), clockSignals)) {
                  indicesToRemove.push_back(i);
                } else {
                  nonClockCount++;
                }
              } else {
                nonClockCount++;
              }
            }

            // 防止空 wait：如果移除后 observed 为空
            if (nonClockCount == 0 && !indicesToRemove.empty()) {
              // 这个 process 只由 clock 触发
              if (allConditionsRemoved) {
                // 内容检查（触发轴 ≠ 内容轴）：敏感表纯时钟只说明"由谁唤醒"，
                // 不说明"体内有没有真状态更新"。settle/tick 语义下进程壳（wait/
                // 沿检测）本来就会在发射时丢弃，要保的是 drv。无复位 flop
                // （always_ff @(posedge clk) q <= d，如 gpio 边沿检测的 data_in_q
                // 采样器）恰好落在这条路径上——整删会把"上一拍记忆"连壳带瓤
                // 删掉（下降沿中断永不触发、上升沿退化电平；探针 R=5 实证）。
                // 仅当体内所有 drv 都是字面自拷贝（isDrvHoldPattern，真无内容）
                // 才允许整删；否则保留进程（保一个 clock observed 防空 wait），
                // 让 drv 以无守卫驱动进入 tick——"拆闹钟，不拆日程"。
                if (!procHasRealDrv) {
                  // 触发条件全被移除且体内无真驱动：可以删除整个 process
                  llvm::outs() << "    [STEP 2c] Process is pure clock-only, mark for removal\n";
                  processesToRemove.insert(proc.getOperation());
                  return WalkResult::interrupt();  // 中断 walk，不继续处理此 process
                }
                llvm::outs() << "    [STEP 2c] Pure clock-only but has real drvs"
                                " — keep process, retain one clock observed\n";
                indicesToRemove.pop_back();
              } else {
                // 保留至少一个 clock observed（不产生空 wait）
                llvm::outs() << "    [STEP 2c] Keep one clock observed to avoid empty wait\n";
                indicesToRemove.pop_back();
              }
            }

            // 逆序移除
            auto mutableObserved = waitOp.getObservedMutable();
            for (auto it = indicesToRemove.rbegin(); it != indicesToRemove.rend(); ++it) {
              std::string sigName = "unknown";
              if (auto prbOp = observed[*it].getDefiningOp<llhd::ProbeOp>()) {
                sigName = getSignalName(prbOp.getSignal());
              }
              llvm::outs() << "    [STEP 2c] Remove from wait: " << sigName << "\n";
              mutableObserved.erase(*it);
              removedFromWait++;
            }
            return WalkResult::advance();
          });
        }
      });

      // 删除纯时钟触发的 process（使用 SmallPtrSet 已去重）
      for (Operation *op : processesToRemove) {
        llvm::outs() << "  [REMOVE PROCESS] Pure clock-only process\n";
        op->erase();
        removedProcesses++;
      }

      //=== Step 3: DCE - 安全删除死代码 ===//
      llvm::outs() << "  [STEP 3] Running safe DCE...\n";
      runSafeDCE(hwMod, removedDCE);

      //=== Step 4: 删除时钟的端口连接 drv（仅 BlockArgument 驱动值）===//
      llvm::SmallVector<llhd::DriveOp, 16> drvsToRemove;
      hwMod.walk([&](llhd::DriveOp drv) {
        if (isClockBaseSignal(drv.getSignal(), clockSignals)) {
          // 按旧框架边界：只删除端口连接 drv（驱动值是 BlockArgument）
          if (isa<BlockArgument>(drv.getValue())) {
            drvsToRemove.push_back(drv);
          } else {
            std::string sigName = getSignalName(drv.getSignal());
            llvm::outs() << "  [STEP 4] Keep logic drv (not port connection): "
                         << sigName << "\n";
          }
        }
      });

      for (llhd::DriveOp drv : drvsToRemove) {
        std::string sigName = getSignalName(drv.getSignal());
        llvm::outs() << "  [STEP 4] Remove port drv: " << sigName << "\n";
        drv.erase();
        removedDrvs++;
      }
    });

    //=== Step 5: 删除时钟的 sig 定义（base signal 维度）===//
    llvm::SmallVector<llhd::SignalOp, 8> sigsToRemove;
    mod.walk([&](llhd::SignalOp sigOp) {
      if (sigOp->hasAttr("qemu.is_clock")) {
        if (eventClockSignals.count(sigOp.getResult()))
          return;  // 事件时钟是活信号(prev 记忆位 + 沿守卫都在读它)
        if (sigOp.getResult().use_empty()) {
          sigsToRemove.push_back(sigOp);
        } else {
          std::string sigName = getSignalName(sigOp.getResult());
          llvm::outs() << "[STEP 5] Cannot remove sig (has users): "
                       << sigName << "\n";
        }
      }
    });

    for (llhd::SignalOp sigOp : sigsToRemove) {
      std::string sigName = getSignalName(sigOp.getResult());
      llvm::outs() << "[STEP 5] Remove sig: " << sigName << "\n";
      sigOp.erase();
      removedSignals++;
    }

    llvm::outs() << "\n----------------------------------------\n";
    llvm::outs() << "Summary:\n";
    llvm::outs() << "  Removed clock terms:   " << removedClockTerms << "\n";
    llvm::outs() << "  Rewritten branches:    " << rewrittenBranches << "\n";
    llvm::outs() << "  Removed from wait:     " << removedFromWait << "\n";
    llvm::outs() << "  DCE removed ops:       " << removedDCE << "\n";
    llvm::outs() << "  Removed port drvs:     " << removedDrvs << "\n";
    llvm::outs() << "  Removed signals:       " << removedSignals << "\n";
    llvm::outs() << "  Removed processes:     " << removedProcesses << "\n";
    llvm::outs() << "  Event prev sigs:       " << eventPrevSigs << "\n";
    llvm::outs() << "  Event edge guards:     " << eventEdgeGuards << "\n";
    llvm::outs() << "========================================\n\n";

    qemu_passes::writePassReport(
        "clock_drv_removal",
        [&](llvm::raw_ostream &os) {
          os << "Clock Drv Removal — summary\n";
          os << "===========================\n";
          os << "Removed clock terms:   " << removedClockTerms << "\n";
          os << "Rewritten branches:    " << rewrittenBranches << "\n";
          os << "Removed from wait:     " << removedFromWait << "\n";
          os << "DCE removed ops:       " << removedDCE << "\n";
          os << "Removed port drvs:     " << removedDrvs << "\n";
          os << "Removed signals:       " << removedSignals << "\n";
          os << "Removed processes:     " << removedProcesses << "\n";
        });
  }
};


//===----------------------------------------------------------------------===//
// Pass: AccumulateRingDetect
// 跨模块累加环:q → (+step) → 经端口/寄存器堆 → 写回 q。classifyDrv 只看一条
// drv,看不到另一半;留在 tick 里的这种计数器每个 settle 拍都加一(aon count、
// rv_timer mtime:一次 MMIO +256)。这里沿实例路径反向追数据流,找到环上的
// add/sub,打 qemu.pump_acc_operand(累加器那一侧的操作数下标);翻译时把另一侧
// 用泵脉冲门控:acc + (_qp_pump ? step : 0)。寄存器 drv 本身不动——SW 写、
// 复位、回绕臂全部保留。
//===----------------------------------------------------------------------===//

struct AccRingTracer {
  ModuleOp mod;
  SymbolTable symTable;
  hw::HWModuleOp top;
  using Path = llvm::SmallVector<Operation *, 8>;   // 实例链(从顶层往下)
  int marked = 0, ringsFound = 0, visitsBudgetHits = 0, migratedAcc = 0;
  bool timerPump = false;
  llvm::DenseSet<Operation *> markedOps;

  explicit AccRingTracer(ModuleOp m) : mod(m), symTable(m) {
    for (auto hm : mod.getOps<hw::HWModuleOp>())
      if (!hm.isPrivate()) { top = hm; break; }
  }
  hw::HWModuleOp refMod(hw::InstanceOp inst) {
    return dyn_cast_or_null<hw::HWModuleOp>(symTable.lookup(inst.getModuleName()));
  }
  static Value baseSig(Value v) {
    while (auto ex = v.getDefiningOp<llhd::SigExtractOp>()) v = ex.getInput();
    return v;
  }
  static bool isSeqDrv(llhd::DriveOp d) {
    Operation *p = d->getParentOp();
    while (p && !isa<llhd::ProcessOp>(p) && !isa<hw::HWModuleOp>(p)) p = p->getParentOp();
    return isa_and_nonnull<llhd::ProcessOp>(p);
  }
  static hw::OutputOp outputOf(hw::HWModuleOp N) {
    for (auto &op : N.getBodyBlock()->getOperations())
      if (auto o = dyn_cast<hw::OutputOp>(op)) return o;
    return nullptr;
  }

  /// drv inside a clock-triggered process (a real register); drvs in plain
  /// always_comb processes are combinational for the bus-reach analyses.
  static bool isClockedDrv(llhd::DriveOp d) {
    auto proc = d->getParentOfType<llhd::ProcessOp>();
    return proc && proc->hasAttr("qemu.clock_triggered");
  }
  struct Search {
    Value target;                 // 起点寄存器 sig(base)
    Path targetPath;
    llvm::SmallVector<std::pair<Operation *, unsigned>, 4> route;  // 当前路线上的 add/sub + 累加侧操作数下标
    llvm::DenseSet<std::pair<void *, size_t>> onRoute;   // (value, path-hash) 防环
    llvm::SmallVector<StringRef, 6> fieldStack;   // 结构体字段栈:extract 压、create 弹
    unsigned visits = 0;
    bool found = false;
    unsigned boundaryDepth = 0;   // 当前路线穿过了几层实例边界(0 = 模块内环)
    bool foundCrossed = false;    // 命中时是否跨过边界
  };
  static size_t fieldsHash(llvm::ArrayRef<StringRef> fs) {
    size_t h = 0x9e3779b97f4a7c15ull;
    for (StringRef f : fs) h = (h * 1099511628211ull) ^ llvm::hash_value(f);
    return h;
  }
  static size_t pathHash(const Path &p) {
    size_t h = 1469598103934665603ull;
    for (Operation *o : p) h = (h ^ (size_t)o) * 1099511628211ull;
    return h;
  }

  /// 在路径 P 上反向追 v;命中 target 则把 route 上的 add/sub 标记。
  void trace(hw::HWModuleOp M, Path &P, Value v, Search &S, unsigned depth) {
    if (S.found || depth == 0 || !v) return;
    // ABANDONING THIS SEARCH IS A WRONG ANSWER, NOT A SLOWER ONE.  When the
    // trace gives up, valueUsesStep reports false, the step arm is skipped,
    // allInhibited holds on fewer arms, the ring is judged bus-driven and left
    // free-running — so a self-timed counter runs its full span inside a
    // single MMIO settle.  aon_timer and rv_timer are exactly the devices
    // whose entire correctness IS a free-running counter, and this fired 29
    // and 57 times on them.
    //
    // Termination does not need a visit count: `S.onRoute` below is a
    // path-keyed set that refuses re-entry, and `depth` bounds the walk.  The
    // budget was belt-and-braces that silently changed the answer, so it is
    // now a tripwire that says so instead of a limit that hides.
    if (++S.visits > 3000) {
      if (visitsBudgetHits == 0)
        llvm::errs() << "  [ACC-RING TRACE BUDGET] a step search exceeded "
                        "3000 visits; the ring verdict for this counter is "
                        "made on an incomplete search\n";
      visitsBudgetHits++;
    }
    auto key = std::make_pair(v.getAsOpaquePointer(),
                              pathHash(P) ^ fieldsHash(S.fieldStack));
    if (!S.onRoute.insert(key).second) return;
    llvm::scope_exit leave([&] { S.onRoute.erase(key); });

    if (auto arg = dyn_cast<BlockArgument>(v)) {
      // 模块输入端口 → 父实例的实参
      if (P.empty()) return;
      auto inst = cast<hw::InstanceOp>(P.back());
      Operation *instOp = P.pop_back_val();
      auto parentMod = inst->getParentOfType<hw::HWModuleOp>();
      S.boundaryDepth++;
      if (arg.getArgNumber() < inst.getNumOperands())
        trace(parentMod, P, inst.getOperand(arg.getArgNumber()), S, depth - 1);
      if (!S.found) S.boundaryDepth--;
      P.push_back(instOp);
      return;
    }
    Operation *def = v.getDefiningOp();
    if (!def) return;
    if (auto prb = dyn_cast<llhd::ProbeOp>(def)) {
      Value sig = baseSig(prb.getSignal());
      if (sig == S.target && pathHash(P) == pathHash(S.targetPath) && !S.route.empty()) {
        S.found = true;
        S.foundCrossed = (S.boundaryDepth > 0);
        return;
      }
      // 只穿组合驱动;遇到别的时序 drv 就停(那是另一个寄存器)
      for (Operation *user : sig.getUsers()) {
        llhd::DriveOp drv;
        if (auto d = dyn_cast<llhd::DriveOp>(user)) { if (d.getSignal() == sig) drv = d; }
        else if (auto ex = dyn_cast<llhd::SigExtractOp>(user)) {
          for (Operation *u2 : ex.getResult().getUsers())
            if (auto d2 = dyn_cast<llhd::DriveOp>(u2)) if (d2.getSignal() == ex.getResult()) {
              if (!isSeqDrv(d2)) trace(M, P, d2.getValue(), S, depth - 1);
            }
          continue;
        }
        if (drv && !isSeqDrv(drv)) trace(M, P, drv.getValue(), S, depth - 1);
        if (S.found) return;
      }
      return;
    }
    if (auto inst = dyn_cast<hw::InstanceOp>(def)) {
      auto N = refMod(inst); if (!N) return;
      hw::OutputOp out = outputOf(N);
      unsigned r = cast<OpResult>(v).getResultNumber();
      if (!out || r >= out.getNumOperands()) return;
      P.push_back(inst.getOperation());
      S.boundaryDepth++;
      trace(N, P, out.getOperand(r), S, depth - 1);
      if (!S.found) S.boundaryDepth--;
      P.pop_back();
      return;
    }
    if (isa<hw::ConstantOp>(def)) return;
    // 结构体端口:子模块 struct_extract(arg)["f"] ← 父模块 struct_create(...)
    if (auto sx = dyn_cast<hw::StructExtractOp>(def)) {
      S.fieldStack.push_back(sx.getFieldName());
      trace(M, P, sx.getInput(), S, depth - 1);
      if (!S.found) S.fieldStack.pop_back();
      return;
    }
    if (auto sc = dyn_cast<hw::StructCreateOp>(def)) {
      if (S.fieldStack.empty()) return;
      StringRef f = S.fieldStack.back();
      auto st = dyn_cast<hw::StructType>(sc.getResult().getType());
      if (!st) return;
      auto elems = st.getElements();
      for (unsigned i = 0; i < elems.size(); ++i) {
        if (elems[i].name.getValue() != f) continue;
        S.fieldStack.pop_back();
        trace(M, P, sc.getOperand(i), S, depth - 1);
        if (!S.found) S.fieldStack.push_back(f);
        return;
      }
      return;
    }
    if (auto add = dyn_cast<comb::AddOp>(def)) {
      // 逐个操作数试作"累加侧";找到环则该下标就是累加器
      for (unsigned i = 0; i < add.getNumOperands() && !S.found; ++i) {
        if (add.getOperand(i).getDefiningOp<hw::ConstantOp>()) continue;
        S.route.push_back({def, i});
        trace(M, P, add.getOperand(i), S, depth - 1);
        if (!S.found) S.route.pop_back();
      }
      return;
    }
    if (auto sub = dyn_cast<comb::SubOp>(def)) {
      S.route.push_back({def, 0});
      trace(M, P, sub.getLhs(), S, depth - 1);
      if (!S.found) S.route.pop_back();
      return;
    }
    if (auto mux = dyn_cast<comb::MuxOp>(def)) {
      trace(M, P, mux.getTrueValue(), S, depth - 1);
      if (!S.found) trace(M, P, mux.getFalseValue(), S, depth - 1);
      return;
    }
    if (isa<comb::ConcatOp, comb::ExtractOp, comb::ReplicateOp, comb::XorOp,
            comb::AndOp, comb::OrOp>(def)) {
      for (Value o : def->getOperands()) { trace(M, P, o, S, depth - 1); if (S.found) return; }
      return;
    }
    // icmp / shifts / 其它:不是累加数据通路,停。
  }

  /// Is `port` (a top-level input) the bus REQUEST port?  Protocol-level
  /// convention (same class as TLULControlInference's field list): a struct
  /// port carrying an `a_valid` field.
  static bool isBusRequestPortType(Type t) {
    auto st = dyn_cast<hw::StructType>(t);
    if (!st) return false;
    for (auto &e : st.getElements())
      if (e.name.getValue() == "a_valid") return true;
    return false;
  }

  /// Backward comb cone of `v` (through comb ops, comb-driven sigs, instance
  /// ports upward along P) reaches a top-level bus request port?  Registers
  /// (seq drvs) are boundaries.  Used to classify a local accumulate ring's
  /// step enable as BUS-STROBE-driven (FIFO pointers: push/pop from a bus
  /// write/read strobe — one clock per access now that the bus entry presents
  /// the request for exactly one tick) vs level/internal-driven (timeout
  /// counters, prescalers — must NOT free-run in the settle).
  struct ReachState {
    hw::HWModuleOp M;
    llvm::SmallVector<Operation *, 8> P;
    Value v;
    llvm::SmallVector<StringRef, 6> fs;
  };
  /// Is `sig` a pure pipeline flop?  True iff every clocked drv of `sig` lives
  /// in ONE clock-triggered process that drives `sig` on EVERY path of the
  /// clock body (no implicit hold) AND its next value does not depend on itself
  /// (no comb hold path).  prim_flop: yes.  prim_subreg (`if (we) q <= wd`),
  /// FSM state (`state_q <= state_d`, state_d = f(state_q)): no.
  /// The wait block's immediate successor may carry a leftover edge guard
  /// (cond referencing a prb sampled in the wait block); its wait-head branch
  /// is skipped, not treated as a hold path.
  llvm::DenseMap<std::pair<void *, size_t>, bool> exhaustiveMemo;
  /// Does the comb next-value cone of the clocked drvs of `sig` (module M,
  /// instance path P) reach a prb of `sig` itself (same instance path)?
  /// Crosses instance boundaries; comb-driven intermediates are followed;
  /// other clocked sigs stop.
  bool nextValueDependsOnSelf(hw::HWModuleOp M, llvm::ArrayRef<Operation *> P, Value sig) {
    llvm::SmallVector<ReachState, 32> wl;
    llvm::DenseSet<std::pair<void *, size_t>> seen;
    for (Operation *u : sig.getUsers())
      if (auto dd = dyn_cast<llhd::DriveOp>(u))
        if (dd.getSignal() == sig && isClockedDrv(dd))
          wl.push_back({M, llvm::SmallVector<Operation *, 8>(P.begin(), P.end()), dd.getValue(), {}});
    unsigned nodes = 0;
    auto key = [](const ReachState &st) {
      size_t fh = 0x9e3779b97f4a7c15ull;
      for (StringRef f : st.fs) fh = (fh * 1099511628211ull) ^ llvm::hash_value(f);
      for (Operation *o : st.P) fh = (fh * 1099511628211ull) ^ (size_t)o;
      return std::make_pair(st.v.getAsOpaquePointer(), fh);
    };
    auto push = [&](const ReachState &base, Value nv) {
      if (!nv) return;
      ReachState n = base; n.v = nv; wl.push_back(std::move(n));
    };
    while (!wl.empty()) {
      if (++nodes > 20000) return true;   // budget: conservative = "depends on self"
      ReachState st = wl.pop_back_val();
      if (!seen.insert(key(st)).second) continue;
      Value cv = st.v;
      if (auto arg = dyn_cast<BlockArgument>(cv)) {
        if (st.P.empty()) continue;
        auto inst = cast<hw::InstanceOp>(st.P.back());
        if (arg.getArgNumber() >= inst.getNumOperands()) continue;
        ReachState n = st; n.P.pop_back();
        n.M = inst->getParentOfType<hw::HWModuleOp>();
        n.v = inst.getOperand(arg.getArgNumber());
        wl.push_back(std::move(n));
        continue;
      }
      Operation *def = cv.getDefiningOp();
      if (!def) continue;
      if (auto prb = dyn_cast<llhd::ProbeOp>(def)) {
        Value s2 = baseSig(prb.getSignal());
        if (s2 == sig && st.P.size() == P.size() &&
            std::equal(st.P.begin(), st.P.end(), P.begin()))
          return true;
        for (Operation *user : s2.getUsers()) {
          if (auto dd = dyn_cast<llhd::DriveOp>(user)) {
            if (dd.getSignal() == s2 && !isClockedDrv(dd)) push(st, dd.getValue());
          } else if (auto ex = dyn_cast<llhd::SigExtractOp>(user)) {
            for (Operation *u2 : ex.getResult().getUsers())
              if (auto d2 = dyn_cast<llhd::DriveOp>(u2))
                if (!isClockedDrv(d2)) push(st, d2.getValue());
          }
        }
        continue;
      }
      if (auto inst = dyn_cast<hw::InstanceOp>(def)) {
        auto N = refMod(inst); if (!N) continue;
        hw::OutputOp out = outputOf(N);
        unsigned r = cast<OpResult>(cv).getResultNumber();
        if (!out || r >= out.getNumOperands()) continue;
        ReachState n = st; n.P.push_back(inst.getOperation()); n.M = N; n.v = out.getOperand(r);
        wl.push_back(std::move(n));
        continue;
      }
      if (isa<hw::ConstantOp>(def)) continue;
      if (auto sx = dyn_cast<hw::StructExtractOp>(def)) {
        ReachState n = st; n.fs.push_back(sx.getFieldName()); n.v = sx.getInput();
        wl.push_back(std::move(n));
        continue;
      }
      if (auto sc = dyn_cast<hw::StructCreateOp>(def)) {
        if (st.fs.empty()) { for (Value o : sc.getOperands()) push(st, o); continue; }
        StringRef f = st.fs.back();
        auto stt = dyn_cast<hw::StructType>(sc.getResult().getType());
        if (!stt) continue;
        auto elems = stt.getElements();
        for (unsigned i = 0; i < elems.size(); ++i)
          if (elems[i].name.getValue() == f) {
            ReachState n = st; n.fs.pop_back(); n.v = sc.getOperand(i);
            wl.push_back(std::move(n));
            break;
          }
        continue;
      }
      for (Value o : def->getOperands()) push(st, o);
    }
    return false;
  }
  bool isPipelineFlop(hw::HWModuleOp M, llvm::ArrayRef<Operation *> P, Value sig) {
    size_t ph = 0x9e3779b97f4a7c15ull;
    for (Operation *o : P) ph = (ph * 1099511628211ull) ^ (size_t)o;
    auto mk = std::make_pair(sig.getAsOpaquePointer(), ph);
    auto it = exhaustiveMemo.find(mk);
    if (it != exhaustiveMemo.end()) return it->second;
    bool result = false;
    llvm::SmallPtrSet<Operation *, 4> procs;
    for (Operation *u : sig.getUsers()) {
      llhd::DriveOp d;
      if (auto dd = dyn_cast<llhd::DriveOp>(u)) { if (dd.getSignal() == sig) d = dd; }
      if (!d || !isClockedDrv(d)) continue;
      auto proc = d->getParentOfType<llhd::ProcessOp>();
      if (!proc) { procs.clear(); break; }
      procs.insert(proc.getOperation());
    }
    if (procs.size() == 1) {
      auto proc = cast<llhd::ProcessOp>(*procs.begin());
      Block *waitBlk = nullptr; llhd::WaitOp waitOp;
      for (Block &b : proc.getBody())
        if (auto w = dyn_cast<llhd::WaitOp>(b.getTerminator())) {
          if (waitBlk) { waitBlk = nullptr; break; }   // multiple waits: give up
          waitBlk = &b; waitOp = w;
        }
      if (waitBlk && waitOp && waitOp.getDest()) {
        auto drivesHere = [&](Block *b) {
          for (Operation &o : *b)
            if (auto dd = dyn_cast<llhd::DriveOp>(&o))
              if (dd.getSignal() == sig) return true;
          return false;
        };
        auto usesWaitBlockPrb = [&](Value c) {
          llvm::SmallVector<Value, 8> wl{c}; llvm::SmallPtrSet<void *, 16> seen; unsigned budget = 64;
          while (!wl.empty() && budget--) {
            Value x = wl.pop_back_val();
            if (!seen.insert(x.getAsOpaquePointer()).second) continue;
            Operation *dop = x.getDefiningOp();
            if (!dop) continue;
            if (isa<llhd::ProbeOp>(dop)) { if (dop->getBlock() == waitBlk) return true; continue; }
            for (Value o : dop->getOperands()) wl.push_back(o);
          }
          return false;
        };
        llvm::DenseMap<Block *, bool> memo;
        llvm::SmallPtrSet<Block *, 16> onStack;
        std::function<bool(Block *, bool)> allDrive = [&](Block *b, bool first) -> bool {
          if (b == waitBlk) return false;                 // reached the loop head without a drv: hold path
          if (drivesHere(b)) return true;
          auto m = memo.find(b); if (m != memo.end()) return m->second;
          if (!onStack.insert(b).second) return false;    // cycle: conservative
          bool r = false;
          Operation *t = b->getTerminator();
          if (auto cb = dyn_cast<cf::CondBranchOp>(t)) {
            Block *T = cb.getTrueDest(), *F = cb.getFalseDest();
            if (first && (T == waitBlk || F == waitBlk) && usesWaitBlockPrb(cb.getCondition()))
              r = allDrive(T == waitBlk ? F : T, false);   // leftover edge guard
            else
              r = allDrive(T, false) && allDrive(F, false);
          } else if (auto br = dyn_cast<cf::BranchOp>(t)) {
            r = allDrive(br.getDest(), false);
          } else {
            r = false;   // halt / other terminator without a drv
          }
          onStack.erase(b);
          memo[b] = r;
          return r;
        };
        result = allDrive(waitOp.getDest(), true);
      }
    }
    if (result && nextValueDependsOnSelf(M, P, sig)) result = false;   // has a comb hold path
    exhaustiveMemo[mk] = result;
    return result;
  }

  /// Three-valued evaluation of a 1-bit control value with the top-level bus
  /// request de-asserted (`a_valid := 0`); every other leaf (registers, pins,
  /// data) is unknown.  F0/F1 = forced 0/1 regardless of the unknowns.
  /// Walks comb ops, struct/array plumbing, instance boundaries and pure
  /// pipeline flops (isPipelineFlop); holding registers are unknown.
  enum TV : uint8_t { TV_U = 0, TV_F0 = 1, TV_F1 = 2 };
  struct EvalCtx {
    llvm::DenseMap<std::pair<void *, size_t>, TV> memo;
    bool touchedBus = false;
    unsigned nodes = 0;
    // root instance context (module + path hash): sigs of THIS context that the
    // evaluation touched — used to couple rings that read each other (FIFO
    // wptr/rptr through full/empty).
    Operation *rootMod = nullptr;
    size_t rootPathHash = 0;
    llvm::SmallPtrSet<void *, 8> touchedSigs;
  };
  static size_t pathFieldHash(llvm::ArrayRef<Operation *> P, llvm::ArrayRef<StringRef> fs) {
    size_t h = 0x9e3779b97f4a7c15ull;
    for (Operation *o : P) h = (h * 1099511628211ull) ^ (size_t)o;
    for (StringRef f : fs) h = (h * 1099511628211ull) ^ llvm::hash_value(f);
    return h;
  }
  static TV tvNot(TV t) { return t == TV_F0 ? TV_F1 : t == TV_F1 ? TV_F0 : TV_U; }
  static TV tvAnd(TV a, TV b) {
    if (a == TV_F0 || b == TV_F0) return TV_F0;
    if (a == TV_F1 && b == TV_F1) return TV_F1;
    return TV_U;
  }
  static TV tvOr(TV a, TV b) { return tvNot(tvAnd(tvNot(a), tvNot(b))); }
  static TV tvXor(TV a, TV b) {
    if (a == TV_U || b == TV_U) return TV_U;
    return a == b ? TV_F0 : TV_F1;
  }
  static bool isI1(Value v) { auto t = dyn_cast<IntegerType>(v.getType()); return t && t.getWidth() == 1; }

  /// Value driving bit `k` of multi-bit sig `sig` (bit-assembled control
  /// vectors: 1-bit sig.extract slices, or a whole-width concat/constant).
  /// Returns null if not uniquely determined.
  static Value bitDrvValue(Value sig, unsigned k, unsigned &constBit, bool &isConst) {
    Value found; isConst = false;
    for (Operation *u : sig.getUsers()) {
      if (auto ex = dyn_cast<llhd::SigExtractOp>(u)) {
        auto it = dyn_cast<llhd::RefType>(ex.getResult().getType());
        if (!it) continue;
        auto et = dyn_cast<IntegerType>(it.getNestedType());
        if (!et || et.getWidth() != 1) continue;
        auto lo = ex.getLowBit().getDefiningOp<hw::ConstantOp>();
        if (!lo || lo.getValue().getZExtValue() != k) continue;
        for (Operation *u2 : ex.getResult().getUsers())
          if (auto d = dyn_cast<llhd::DriveOp>(u2)) {
            if (isClockedDrv(d)) return Value();
            if (found) return Value();
            found = d.getValue();
          }
      } else if (auto d = dyn_cast<llhd::DriveOp>(u)) {
        if (d.getSignal() != sig) continue;
        if (isClockedDrv(d)) return Value();
        Value val = d.getValue();
        if (auto c = val.getDefiningOp<hw::ConstantOp>()) {
          if (found) return Value();
          isConst = true; constBit = c.getValue()[k]; found = val;   // sentinel non-null
        } else if (auto cc = val.getDefiningOp<comb::ConcatOp>()) {
          // operands MSB-first
          unsigned hi = cc.getType().getIntOrFloatBitWidth();
          for (Value o : cc.getOperands()) {
            unsigned w = o.getType().getIntOrFloatBitWidth();
            unsigned lo = hi - w;
            if (k >= lo && k < hi) {
              if (w != 1) return Value();
              if (found) return Value();
              found = o; break;
            }
            hi = lo;
          }
        } else return Value();
      }
    }
    return found;
  }

  /// Bit range of the field path `fs` (top of stack = outermost field) inside
  /// struct type `st`, using hw.bitcast packing (first field = MSB).  Consumes
  /// as many trailing entries of `fs` as are field names; returns consumed count.
  static bool fieldRange(hw::StructType st, llvm::ArrayRef<StringRef> fs, unsigned &lo, unsigned &width, unsigned &consumed) {
    consumed = 0; lo = 0;
    Type cur = st;
    width = hw::getBitWidth(st);
    while (!fs.empty()) {
      auto cst = dyn_cast<hw::StructType>(cur);
      if (!cst) break;
      StringRef f = fs.back();
      if (f.starts_with("#")) break;
      auto elems = cst.getElements();
      unsigned total = hw::getBitWidth(cst);
      unsigned off = total; bool found = false;
      for (auto &e : elems) {
        unsigned w = hw::getBitWidth(e.type);
        off -= w;
        if (e.name.getValue() == f) { lo += off; width = w; cur = e.type; found = true; break; }
      }
      if (!found) return false;
      fs = fs.drop_back();
      ++consumed;
    }
    return consumed > 0;
  }

  /// Record (root context only) the sigs probed by `def`'s direct operands —
  /// even when the op itself evaluates to "unknown" (multi-bit compares such
  /// as `wptr == rptr`), so ring coupling sees them.
  void noteOperandSigs(EvalCtx &C, hw::HWModuleOp M, llvm::SmallVectorImpl<Operation *> &P, Operation *def) {
    if (C.rootMod != M.getOperation() || pathFieldHash(P, {}) != C.rootPathHash) return;
    for (Value o : def->getOperands()) {
      Operation *od = o.getDefiningOp();
      if (!od) continue;
      if (auto prb = dyn_cast<llhd::ProbeOp>(od)) {
        C.touchedSigs.insert(baseSig(prb.getSignal()).getAsOpaquePointer());
      } else if (isa<comb::ExtractOp, comb::ConcatOp>(od)) {
        for (Value o2 : od->getOperands())
          if (auto prb2 = o2.getDefiningOp<llhd::ProbeOp>())
            C.touchedSigs.insert(baseSig(prb2.getSignal()).getAsOpaquePointer());
      }
    }
  }
  llvm::DenseMap<std::pair<void *, size_t>, TV> bitMemo;
  /// Three-valued value of bit `bit` of a multi-bit value `v`.
  TV evalBitOf(EvalCtx &C, hw::HWModuleOp M, llvm::SmallVectorImpl<Operation *> &P, Value v, unsigned bit) {
    if (!v) return TV_U;
    if (isI1(v)) { llvm::SmallVector<StringRef, 6> fs; return bit == 0 ? evalNoBus(C, M, P, v, fs) : TV_U; }
    if (++C.nodes > 60000) return TV_U;
    size_t h = pathFieldHash(P, {}) ^ ((size_t)bit * 0x9E3779B97F4A7C15ull);
    auto key = std::make_pair(v.getAsOpaquePointer(), h);
    auto it = C.memo.find(key);
    if (it != C.memo.end()) return it->second;
    C.memo[key] = TV_U;
    TV r = evalBitOfImpl(C, M, P, v, bit);
    C.memo[key] = r;
    return r;
  }
  TV evalBitOfImpl(EvalCtx &C, hw::HWModuleOp M, llvm::SmallVectorImpl<Operation *> &P, Value v, unsigned bit) {
    if (auto arg = dyn_cast<BlockArgument>(v)) {
      if (P.empty()) return TV_U;
      auto inst = cast<hw::InstanceOp>(P.back());
      if (arg.getArgNumber() >= inst.getNumOperands()) return TV_U;
      Operation *instOp = P.pop_back_val();
      auto parentMod = inst->getParentOfType<hw::HWModuleOp>();
      TV r = evalBitOf(C, parentMod, P, inst.getOperand(arg.getArgNumber()), bit);
      P.push_back(instOp);
      return r;
    }
    Operation *def = v.getDefiningOp();
    if (!def) return TV_U;
    noteOperandSigs(C, M, P, def);
    if (auto c = dyn_cast<hw::ConstantOp>(def)) {
      if (bit >= c.getValue().getBitWidth()) return TV_U;
      return c.getValue()[bit] ? TV_F1 : TV_F0;
    }
    if (auto cc = dyn_cast<comb::ConcatOp>(def)) {
      unsigned hi = cc.getType().getIntOrFloatBitWidth();
      for (Value o : cc.getOperands()) {
        unsigned w = o.getType().getIntOrFloatBitWidth(); unsigned lo = hi - w;
        if (bit >= lo && bit < hi) return evalBitOf(C, M, P, o, bit - lo);
        hi = lo;
      }
      return TV_U;
    }
    if (auto ex = dyn_cast<comb::ExtractOp>(def)) return evalBitOf(C, M, P, ex.getInput(), ex.getLowBit() + bit);
    if (auto prb = dyn_cast<llhd::ProbeOp>(def)) {
      Value sig = baseSig(prb.getSignal());
      if (C.rootMod == M.getOperation() && pathFieldHash(P, {}) == C.rootPathHash)
        C.touchedSigs.insert(sig.getAsOpaquePointer());
      unsigned cb = 0; bool ic = false;
      Value bv = bitDrvValue(sig, bit, cb, ic);
      if (bv) { if (ic) return cb ? TV_F1 : TV_F0; return evalBitOf(C, M, P, bv, 0); }
      // whole-sig comb drvs of a multi-bit value: bit of each, must agree
      llvm::SmallVector<Value, 4> combVals;
      for (Operation *u : sig.getUsers())
        if (auto d = dyn_cast<llhd::DriveOp>(u)) {
          if (d.getSignal() != sig) continue;
          if (isClockedDrv(d)) return TV_U;
          combVals.push_back(d.getValue());
        }
      if (combVals.empty()) return TV_U;
      TV acc = TV_U; bool first = true;
      for (Value cv : combVals) {
        TV t = evalBitOf(C, M, P, cv, bit);
        if (first) { acc = t; first = false; } else if (t != acc) return TV_U;
      }
      return acc;
    }
    if (auto inst = dyn_cast<hw::InstanceOp>(def)) {
      auto N = refMod(inst); if (!N) return TV_U;
      hw::OutputOp out = outputOf(N);
      unsigned r = cast<OpResult>(v).getResultNumber();
      if (!out || r >= out.getNumOperands()) return TV_U;
      P.push_back(inst.getOperation());
      TV t = evalBitOf(C, N, P, out.getOperand(r), bit);
      P.pop_back();
      return t;
    }
    if (auto bc = dyn_cast<hw::BitcastOp>(def)) {
      // struct -> int : find the field holding `bit`
      if (auto st = dyn_cast<hw::StructType>(bc.getInput().getType())) {
        llvm::SmallVector<StringRef, 6> fs;
        Type cur = st; unsigned off = 0; unsigned rem = bit;
        // descend into nested structs until a 1-bit leaf
        while (auto cst = dyn_cast<hw::StructType>(cur)) {
          unsigned total = hw::getBitWidth(cst); unsigned o2 = total; bool found = false;
          for (auto &e : cst.getElements()) {
            unsigned w = hw::getBitWidth(e.type); o2 -= w;
            if (rem >= o2 && rem < o2 + w) { fs.insert(fs.begin(), e.name.getValue()); rem -= o2; cur = e.type; found = true; break; }
          }
          if (!found) return TV_U;
        }
        (void)off;
        if (auto it2 = dyn_cast<IntegerType>(cur); it2 && it2.getWidth() == 1)
          return evalNoBus(C, M, P, bc.getInput(), fs);
        return TV_U;
      }
      // int -> int / array<int> -> int etc.: same bit
      if (isa<IntegerType>(bc.getInput().getType())) return evalBitOf(C, M, P, bc.getInput(), bit);
      return TV_U;
    }
    if (auto op = dyn_cast<comb::MuxOp>(def)) {
      llvm::SmallVector<StringRef, 6> fs;
      TV s = evalNoBus(C, M, P, op.getCond(), fs);
      if (s == TV_F1) return evalBitOf(C, M, P, op.getTrueValue(), bit);
      if (s == TV_F0) return evalBitOf(C, M, P, op.getFalseValue(), bit);
      TV a = evalBitOf(C, M, P, op.getTrueValue(), bit), b = evalBitOf(C, M, P, op.getFalseValue(), bit);
      return a == b ? a : TV_U;
    }
    if (auto op = dyn_cast<comb::AndOp>(def)) {
      TV acc = TV_F1;
      for (Value o : op.getOperands()) { acc = tvAnd(acc, evalBitOf(C, M, P, o, bit)); if (acc == TV_F0) return TV_F0; }
      return acc;
    }
    if (auto op = dyn_cast<comb::OrOp>(def)) {
      TV acc = TV_F0;
      for (Value o : op.getOperands()) { acc = tvOr(acc, evalBitOf(C, M, P, o, bit)); if (acc == TV_F1) return TV_F1; }
      return acc;
    }
    if (auto op = dyn_cast<comb::XorOp>(def)) {
      TV acc = TV_F0;
      for (Value o : op.getOperands()) { acc = tvXor(acc, evalBitOf(C, M, P, o, bit)); if (acc == TV_U) return TV_U; }
      return acc;
    }
    if (auto ag = dyn_cast<hw::ArrayGetOp>(def)) {
      if (auto ci = ag.getIndex().getDefiningOp<hw::ConstantOp>())
        if (auto ac = ag.getInput().getDefiningOp<hw::ArrayCreateOp>()) {
          unsigned n = ac.getNumOperands(), k = ci.getValue().getZExtValue();
          if (k < n) return evalBitOf(C, M, P, ac.getOperand(n - 1 - k), bit);
        }
      return TV_U;
    }
    return TV_U;
  }

  TV evalNoBus(EvalCtx &C, hw::HWModuleOp M, llvm::SmallVectorImpl<Operation *> &P, Value v,
               llvm::SmallVectorImpl<StringRef> &fs) {
    if (!v) return TV_U;
    if (++C.nodes > 60000) return TV_U;
    auto key = std::make_pair(v.getAsOpaquePointer(), pathFieldHash(P, fs));
    auto it = C.memo.find(key);
    if (it != C.memo.end()) return it->second;
    C.memo[key] = TV_U;   // cycle guard
    TV r = evalNoBusImpl(C, M, P, v, fs);
    C.memo[key] = r;
    if (const char *e = getenv("QP_DEBUG_BUS"); e && e[0] == '2') {
      llvm::errs() << "        eval @" << M.getName() << " P=" << P.size() << " fs=" << fs.size() << " ";
      if (Operation *d = v.getDefiningOp()) { std::string tmp; llvm::raw_string_ostream os(tmp); d->print(os); llvm::errs() << StringRef(os.str()).take_front(110); }
      else llvm::errs() << "arg#" << cast<BlockArgument>(v).getArgNumber();
      llvm::errs() << " -> " << (r == TV_F0 ? "F0" : r == TV_F1 ? "F1" : "U") << "\n";
    }
    return r;
  }
  TV evalNoBusImpl(EvalCtx &C, hw::HWModuleOp M, llvm::SmallVectorImpl<Operation *> &P, Value v,
                   llvm::SmallVectorImpl<StringRef> &fs) {
    if (auto arg = dyn_cast<BlockArgument>(v)) {
      if (P.empty()) {
        if (isBusRequestPortType(arg.getType()) && fs.size() == 1 && fs.back() == "a_valid") {
          C.touchedBus = true;
          return TV_F0;
        }
        return TV_U;
      }
      auto inst = cast<hw::InstanceOp>(P.back());
      if (arg.getArgNumber() >= inst.getNumOperands()) return TV_U;
      Operation *instOp = P.pop_back_val();
      auto parentMod = inst->getParentOfType<hw::HWModuleOp>();
      TV r = evalNoBus(C, parentMod, P, inst.getOperand(arg.getArgNumber()), fs);
      P.push_back(instOp);
      return r;
    }
    Operation *def = v.getDefiningOp();
    if (!def) return TV_U;
    noteOperandSigs(C, M, P, def);
    if (auto c = dyn_cast<hw::ConstantOp>(def)) {
      if (!fs.empty()) return TV_U;
      if (c.getValue().getBitWidth() != 1) return TV_U;
      return c.getValue().isZero() ? TV_F0 : TV_F1;
    }
    if (auto prb = dyn_cast<llhd::ProbeOp>(def)) {
      Value sig = baseSig(prb.getSignal());
      if (C.rootMod == M.getOperation() && pathFieldHash(P, {}) == C.rootPathHash)
        C.touchedSigs.insert(sig.getAsOpaquePointer());
      // struct-typed sig with field context: follow the drvs with fs intact
      llvm::SmallVector<Value, 4> combVals, clkVals;
      for (Operation *u : sig.getUsers()) {
        if (auto d = dyn_cast<llhd::DriveOp>(u)) {
          if (d.getSignal() != sig) continue;
          (isClockedDrv(d) ? clkVals : combVals).push_back(d.getValue());
        }
      }
      if (!combVals.empty() && clkVals.empty()) {
        TV acc = TV_U; bool first = true;
        for (Value cv : combVals) {
          TV t = evalNoBus(C, M, P, cv, fs);
          if (first) { acc = t; first = false; }
          else if (t != acc) return TV_U;
        }
        return acc;
      }
      if (combVals.empty() && !clkVals.empty() && fs.empty() && isI1(v) && isPipelineFlop(M, P, sig)) {
        Value nonConst; unsigned n = 0;
        for (Value cv : clkVals) if (!cv.getDefiningOp<hw::ConstantOp>()) { nonConst = cv; ++n; }
        if (n == 1) return evalNoBus(C, M, P, nonConst, fs);
      }
      return TV_U;
    }
    if (auto inst = dyn_cast<hw::InstanceOp>(def)) {
      auto N = refMod(inst); if (!N) return TV_U;
      hw::OutputOp out = outputOf(N);
      unsigned r = cast<OpResult>(v).getResultNumber();
      if (!out || r >= out.getNumOperands()) return TV_U;
      P.push_back(inst.getOperation());
      TV t = evalNoBus(C, N, P, out.getOperand(r), fs);
      P.pop_back();
      return t;
    }
    if (auto sx = dyn_cast<hw::StructExtractOp>(def)) {
      fs.push_back(sx.getFieldName());
      TV t = evalNoBus(C, M, P, sx.getInput(), fs);
      fs.pop_back();
      return t;
    }
    if (auto sc = dyn_cast<hw::StructCreateOp>(def)) {
      if (fs.empty()) return TV_U;
      StringRef f = fs.back();
      auto st = dyn_cast<hw::StructType>(sc.getResult().getType());
      if (!st) return TV_U;
      auto elems = st.getElements();
      for (unsigned i = 0; i < elems.size(); ++i)
        if (elems[i].name.getValue() == f) {
          fs.pop_back();
          TV t = evalNoBus(C, M, P, sc.getOperand(i), fs);
          fs.push_back(f);
          return t;
        }
      return TV_U;
    }
    if (auto ag = dyn_cast<hw::ArrayGetOp>(def)) {
      if (auto ci = ag.getIndex().getDefiningOp<hw::ConstantOp>()) {
        std::string tag = ("#" + std::to_string(ci.getValue().getZExtValue()));
        // keep the string alive for the duration of the recursion
        llvm::SmallString<16> tagStr(tag);
        fs.push_back(StringRef(tagStr));
        TV t = evalNoBus(C, M, P, ag.getInput(), fs);
        fs.pop_back();
        return t;
      }
      // dynamic index: all elements must agree
      if (auto ac = ag.getInput().getDefiningOp<hw::ArrayCreateOp>()) {
        TV acc = TV_U; bool first = true;
        for (Value o : ac.getOperands()) {
          TV t = evalNoBus(C, M, P, o, fs);
          if (first) { acc = t; first = false; } else if (t != acc) return TV_U;
        }
        return acc;
      }
      return TV_U;
    }
    if (auto ac = dyn_cast<hw::ArrayCreateOp>(def)) {
      if (fs.empty() || !fs.back().starts_with("#")) return TV_U;
      unsigned k = 0;
      if (fs.back().drop_front(1).getAsInteger(10, k)) return TV_U;
      unsigned n = ac.getNumOperands();
      if (k >= n) return TV_U;
      StringRef tag = fs.pop_back_val();
      TV t = evalNoBus(C, M, P, ac.getOperand(n - 1 - k), fs);   // operands MSB-first
      fs.push_back(tag);
      return t;
    }
    if (auto bc = dyn_cast<hw::BitcastOp>(def)) {
      // packed int -> struct : field path -> bit range of the packed int
      if (auto st = dyn_cast<hw::StructType>(bc.getType())) {
        if (fs.empty()) return TV_U;
        unsigned lo, w, n;
        if (!fieldRange(st, fs, lo, w, n) || w != 1) return TV_U;
        if (n != fs.size()) return TV_U;
        return evalBitOf(C, M, P, bc.getInput(), lo);
      }
      // array<int> -> array<struct> : "#k" then field path
      if (auto at = dyn_cast<hw::ArrayType>(bc.getType())) {
        auto est = dyn_cast<hw::StructType>(at.getElementType());
        auto iat = dyn_cast<hw::ArrayType>(bc.getInput().getType());
        if (!est || !iat || fs.empty() || !fs.back().starts_with("#")) return TV_U;
        unsigned k = 0;
        if (fs.back().drop_front(1).getAsInteger(10, k)) return TV_U;
        auto ac = bc.getInput().getDefiningOp<hw::ArrayCreateOp>();
        if (!ac || k >= ac.getNumOperands()) return TV_U;
        Value elem = ac.getOperand(ac.getNumOperands() - 1 - k);
        llvm::ArrayRef<StringRef> rest(fs.begin(), fs.end() - 1);
        unsigned lo, w, n;
        if (!fieldRange(est, rest, lo, w, n) || w != 1 || n != rest.size()) return TV_U;
        return evalBitOf(C, M, P, elem, lo);
      }
      return TV_U;
    }
    if (!fs.empty()) return TV_U;   // field context but not a struct/array producer
    if (auto op = dyn_cast<comb::AndOp>(def)) {
      if (!isI1(v)) return TV_U;
      TV acc = TV_F1;
      for (Value o : op.getOperands()) { acc = tvAnd(acc, evalNoBus(C, M, P, o, fs)); if (acc == TV_F0) return TV_F0; }
      return acc;
    }
    if (auto op = dyn_cast<comb::OrOp>(def)) {
      if (!isI1(v)) return TV_U;
      TV acc = TV_F0;
      for (Value o : op.getOperands()) { acc = tvOr(acc, evalNoBus(C, M, P, o, fs)); if (acc == TV_F1) return TV_F1; }
      return acc;
    }
    if (auto op = dyn_cast<comb::XorOp>(def)) {
      if (!isI1(v)) return TV_U;
      TV acc = TV_F0;
      for (Value o : op.getOperands()) { acc = tvXor(acc, evalNoBus(C, M, P, o, fs)); if (acc == TV_U) return TV_U; }
      return acc;
    }
    if (auto op = dyn_cast<comb::MuxOp>(def)) {
      if (!isI1(v)) return TV_U;
      TV s = evalNoBus(C, M, P, op.getCond(), fs);
      if (s == TV_F1) return evalNoBus(C, M, P, op.getTrueValue(), fs);
      if (s == TV_F0) return evalNoBus(C, M, P, op.getFalseValue(), fs);
      TV a = evalNoBus(C, M, P, op.getTrueValue(), fs);
      TV b = evalNoBus(C, M, P, op.getFalseValue(), fs);
      return a == b ? a : TV_U;
    }
    if (auto op = dyn_cast<comb::ExtractOp>(def)) {
      if (!isI1(v)) return TV_U;
      return evalBitOf(C, M, P, op.getInput(), op.getLowBit());
    }
    if (auto op = dyn_cast<comb::ICmpOp>(def)) {
      auto pred = op.getPredicate();
      Value l = op.getLhs(), rr = op.getRhs();
      if (isI1(l)) {
        if (pred != comb::ICmpPredicate::eq && pred != comb::ICmpPredicate::ne) return TV_U;
        TV a = evalNoBus(C, M, P, l, fs), b = evalNoBus(C, M, P, rr, fs);
        if (a == TV_U || b == TV_U) return TV_U;
        bool eq = (a == b);
        return (pred == comb::ICmpPredicate::eq) == eq ? TV_F1 : TV_F0;
      }
      // reductions over control vectors: (v != 0) = OR, (v == 0) = NOR,
      // (v == -1) = AND, (v != -1) = NAND
      auto rc = rr.getDefiningOp<hw::ConstantOp>();
      if (!rc || (pred != comb::ICmpPredicate::eq && pred != comb::ICmpPredicate::ne)) return TV_U;
      bool allOnes = rc.getValue().isAllOnes(), zero = rc.getValue().isZero();
      if (!allOnes && !zero) return TV_U;
      unsigned w = l.getType().getIntOrFloatBitWidth();
      if (w > 64) return TV_U;
      llvm::SmallVector<TV, 32> bits;
      for (unsigned k = 0; k < w; ++k) bits.push_back(evalBitOf(C, M, P, l, k));
      TV acc;
      if (zero) { acc = TV_F0; for (TV t : bits) acc = tvOr(acc, t); }        // OR-reduce
      else      { acc = TV_F1; for (TV t : bits) acc = tvAnd(acc, t); }       // AND-reduce
      // (v != 0) = OR;  (v == 0) = NOT OR;  (v == -1) = AND;  (v != -1) = NOT AND
      bool isNe = pred == comb::ICmpPredicate::ne;
      if (zero) return isNe ? acc : tvNot(acc);
      return isNe ? tvNot(acc) : acc;
    }
    return TV_U;
  }

  /// Guard conds of `d` with polarity (true = branch taken when cond is 1).
  static void collectGuardCondsPol(llhd::DriveOp d, llvm::SmallVectorImpl<std::pair<Value, bool>> &out) {
    Block *bb = d->getBlock();
    // NO ARBITRARY DEPTH.  The walk already stops at the first join
    // (npred != 1); the 8 only truncated deeply nested guards, and
    // silently.  `seenBlocks` is the termination proof.
    llvm::SmallPtrSet<Block *, 16> seenBlocks;
    while (bb && seenBlocks.insert(bb).second) {
      Block *pred = nullptr; int npred = 0;
      for (Block *p2 : bb->getPredecessors()) { pred = p2; npred++; }
      if (npred != 1) return;
      if (auto cbr = dyn_cast<cf::CondBranchOp>(pred->getTerminator())) {
        if (cbr.getTrueDest() == bb && cbr.getFalseDest() != bb) out.push_back({cbr.getCondition(), true});
        else if (cbr.getFalseDest() == bb && cbr.getTrueDest() != bb) out.push_back({cbr.getCondition(), false});
      }
      bb = pred;
    }
  }

  /// Is the local ring `S` (in module M, instance path P, process `proc`) a
  /// bus-strobe-stepped counter in THIS instance context?
  bool isBusStrobeRing(hw::HWModuleOp M, Path &P, llhd::ProcessOp proc, Search &S,
                       llvm::SmallPtrSetImpl<void *> *touchedOut = nullptr) {
          bool busDriven = false;
          // Only the STEP arm(s) count — a clear-on-read arm's guard also
          // touches the bus, but that does not make the counter bus-stepped
          // (i2c's timeout counters have such arms).  A drv is a step arm when
          // its value's comb cone contains one of the ring's add/sub ops.
          llvm::SmallPtrSet<Operation *, 4> stepOps;
          for (auto &[op, idx] : S.route) stepOps.insert(op);
          auto valueUsesStep = [&](Value v) -> bool {
            // No budget: `seen` is the termination proof, and the counter was
            // consumed by REPEATED POPS of already-seen values, so it bounded
            // something other than the search.  Its firing direction is the
            // dangerous one — a false "does not use step" leaves a
            // self-timed counter free-running.
            llvm::SmallVector<Value, 16> wl{v};
            llvm::SmallPtrSet<void *, 32> seen;
            while (!wl.empty()) {
              Value x = wl.pop_back_val();
              if (!seen.insert(x.getAsOpaquePointer()).second) continue;
              Operation *d = x.getDefiningOp();
              if (!d) continue;
              if (stepOps.count(d)) return true;
              if (isa<llhd::ProbeOp>(d)) {
                Value sg = baseSig(cast<llhd::ProbeOp>(d).getSignal());
                for (Operation *u : sg.getUsers())
                  if (auto dd = dyn_cast<llhd::DriveOp>(u))
                    if (dd.getSignal() == sg && !isSeqDrv(dd)) wl.push_back(dd.getValue());
                continue;
              }
              if (isa<hw::InstanceOp>(d)) continue;
              for (Value o : d->getOperands()) wl.push_back(o);
            }
            return false;
          };
          // Bus-strobe test: with the top-level bus request de-asserted, EVERY
          // step arm of this ring must be inhibited (its guard forced false),
          // and at least one inhibition must come from the bus itself.
          bool anyStep = false, allInhibited = true, anyBus = false;
          proc.walk([&](llhd::DriveOp d2) {
            if (baseSig(d2.getSignal()) != S.target) return;
            if (!valueUsesStep(d2.getValue())) return;
            anyStep = true;
            llvm::SmallVector<std::pair<Value, bool>, 8> conds;
            collectGuardCondsPol(d2, conds);
            bool inhibited = false;
            for (auto &cp : conds) {
              EvalCtx C;
              C.rootMod = M.getOperation();
              C.rootPathHash = pathFieldHash(P, {});
              llvm::SmallVector<Operation *, 8> Pv(P.begin(), P.end());
              llvm::SmallVector<StringRef, 6> fs;
              TV t = evalNoBus(C, M, Pv, cp.first, fs);
              if (touchedOut) for (void *sg : C.touchedSigs) touchedOut->insert(sg);
              if (getenv("QP_DEBUG_BUS")) {
                llvm::errs() << "    [bus-guard?] " << getSignalName(S.target) << " @" << M.getName()
                             << (cp.second ? " if " : " if !") << "(";
                if (Operation *cd = cp.first.getDefiningOp()) { std::string tmp; llvm::raw_string_ostream os(tmp); cd->print(os); llvm::errs() << StringRef(os.str()).take_front(100); }
                llvm::errs() << ") -> " << (t == TV_F0 ? "F0" : t == TV_F1 ? "F1" : "U")
                             << (C.touchedBus ? " [bus]" : "") << " nodes=" << C.nodes << "\n";
              }
              if ((cp.second && t == TV_F0) || (!cp.second && t == TV_F1)) {
                inhibited = true;
                if (C.touchedBus) anyBus = true;
                break;
              }
            }
            if (!inhibited) allInhibited = false;
          });
          busDriven = anyStep && allInhibited && anyBus;
          return busDriven;
  }

  /// (module, ring target sig) -> {instance contexts seen, contexts that are bus-strobe}.
  /// A shared module gets ONE classification, so it is bus-strobe only if every
  /// instance context agrees.
  llvm::DenseMap<std::pair<Operation *, void *>, std::pair<unsigned, unsigned>> busStrobeStats;
  llvm::DenseSet<std::pair<void *, size_t>> busStrobeSeenCtx;
  struct RingRec {
    Operation *mod; size_t pathHash; void *target; bool bus;
    llvm::SmallPtrSet<void *, 8> touched;   // sigs of the same context read by the step guards
  };
  std::vector<RingRec> ringRecs;
  void collectBusStrobe(hw::HWModuleOp M, Path &P, unsigned depth) {
    if (depth == 0) {
      llvm::errs() << "  [HIER DEPTH] instance path exceeded 32 levels; the "
                      "subtree below @" << M.getName()
                   << " was NOT scanned for bus-strobe rings, so every "
                      "counter in it stays free-running\n";
      return;
    }
    if (!timerPump) {
      size_t ph = pathFieldHash(P, {});
      M.walk([&](llhd::DriveOp drv) {
        if (!isSeqDrv(drv)) return;
        auto proc = drv->getParentOfType<llhd::ProcessOp>();
        if (proc->hasAttr("qemu.synth_prev")) return;
        auto cls0 = drv->getAttrOfType<StringAttr>("qemu.drv_class");
        if (!(cls0 && cls0.getValue() == "ACCUMULATE")) return;
        Value target = baseSig(drv.getSignal());
        if (!busStrobeSeenCtx.insert({target.getAsOpaquePointer(), ph}).second) return;
        Search S; S.target = target; S.targetPath = P;
        trace(M, P, drv.getValue(), S, 40);
        if (!S.found || S.foundCrossed) return;
        RingRec R; R.mod = M.getOperation(); R.pathHash = ph; R.target = target.getAsOpaquePointer();
        R.bus = isBusStrobeRing(M, P, proc, S, &R.touched);
        ringRecs.push_back(std::move(R));
      });
    }
    M.walk([&](hw::InstanceOp inst) {
      auto N = refMod(inst); if (!N) return;
      P.push_back(inst.getOperation());
      collectBusStrobe(N, P, depth - 1);
      P.pop_back();
    });
  }
  /// Two rings of the same instance context are COUPLED when one's step
  /// guards read the other (FIFO wptr/rptr through full/empty): they must be
  /// classified together — a bus-strobe ring drags its coupled rings live
  /// (else one pointer freezes while the other moves and the FIFO desyncs).
  void precomputeBusStrobe(hw::HWModuleOp M, Path &P, unsigned depth) {
    collectBusStrobe(M, P, depth);
    bool changed = true;
    unsigned rounds = 0;
    while (changed && rounds++ < 8) {
      changed = false;
      for (auto &A : ringRecs) {
        if (!A.bus) continue;
        for (auto &B : ringRecs) {
          if (B.bus || B.mod != A.mod || B.pathHash != A.pathHash) continue;
          if (A.touched.count(B.target) || B.touched.count(A.target)) {
            B.bus = true; changed = true;
            if (getenv("QP_DEBUG_BUS"))
              llvm::errs() << "    [bus-strobe coupled] " << getSignalName(Value::getFromOpaquePointer(B.target))
                           << " @" << cast<hw::HWModuleOp>(B.mod).getName() << " <- "
                           << getSignalName(Value::getFromOpaquePointer(A.target)) << "\n";
          }
        }
      }
    }
    for (auto &R : ringRecs) {
      auto &st = busStrobeStats[{R.mod, R.target}];
      st.first++; if (R.bus) st.second++;
    }
  }

  void visit(hw::HWModuleOp M, Path &P, unsigned depth) {
    if (depth == 0) return;
    M.walk([&](llhd::DriveOp drv) {
      if (!isSeqDrv(drv)) return;
      auto proc = drv->getParentOfType<llhd::ProcessOp>();
      if (proc->hasAttr("qemu.synth_prev")) return;
      // 策略(数据驱动,来自 binding 的 timer 块):
      //  · 声明了 pump 的设备:所有累加环归泵——每 pump 一步,settle 保持。
      //  · 没有 pump 的设备:只把本来就是 ACCUMULATE(旧机制下已冻结)的直接
      //    形状换成泵门控(仍冻结,但复位/回绕臂回到 tick);其它环保持原状,
      //    否则原来在 settle 里推进的位迭代器/超时计数会被冻住而倒退。
      auto cls0 = drv->getAttrOfType<StringAttr>("qemu.drv_class");
      bool wasAcc = cls0 && cls0.getValue() == "ACCUMULATE";
      if (!timerPump && !wasAcc) return;
      // 事件域(sck/csb 这类事件时钟触发)的计数器按沿真步进,不归泵管
      bool eventDomain = false;
      proc.walk([&](llhd::WaitOp w) {
        for (Value obs : w.getObserved())
          if (auto prb = obs.getDefiningOp<llhd::ProbeOp>())
            if (auto sigOp = prb.getSignal().getDefiningOp<llhd::SignalOp>())
              if (auto k = sigOp->getAttrOfType<StringAttr>("qemu.clock_kind"))
                if (k.getValue() == "event") eventDomain = true;
      });
      if (eventDomain) return;
      Search S; S.target = baseSig(drv.getSignal()); S.targetPath = P;
      trace(M, P, drv.getValue(), S, 40);
      if (S.found) {
        ringsFound++;
        if (!S.foundCrossed && !timerPump) {
          // Bus-strobe-driven local ring (FIFO pointers): with the bus request
          // de-asserted every step arm is inhibited (isBusStrobeRing, three-
          // valued forced analysis; coupled rings — the other FIFO pointer —
          // follow; a shared module needs every instance context to agree).
          // With one-clock bus requests such counters step exactly once per
          // access — leave them LIVE (no pump gate); level/self-timed rings
          // (timeouts, prescalers) stay pump-gated.
          bool busDriven = false;
          {
            auto it = busStrobeStats.find({M.getOperation(), S.target.getAsOpaquePointer()});
            if (it != busStrobeStats.end() && it->second.first > 0 &&
                it->second.first == it->second.second)
              busDriven = true;
            else if (it != busStrobeStats.end() && it->second.second > 0 && getenv("QP_DEBUG_BUS"))
              llvm::errs() << "    [bus-strobe mixed] " << getSignalName(S.target) << " @" << M.getName()
                           << " " << it->second.second << "/" << it->second.first
                           << " contexts bus-strobe -> stays pump-gated\n";
          }
          if (busDriven) {
            bool announced = false;
            proc.walk([&](llhd::DriveOp d2) {
              if (baseSig(d2.getSignal()) != S.target) return;
              if (auto cls = d2->getAttrOfType<StringAttr>("qemu.drv_class"))
                if (cls.getValue() == "ACCUMULATE") {
                  d2->setAttr("qemu.drv_class", StringAttr::get(d2->getContext(), "COMPLEX"));
                  d2->removeAttr("qemu.step");
                  migratedAcc++;
                }
              if (!announced) {
                llvm::outs() << "  [ACC-RING bus-strobe] " << getSignalName(S.target) << " @"
                             << M.getName() << " -> live (steps once per one-clock access)\n";
                announced = true;
              }
            });
            return;
          }
        }
        if (!S.foundCrossed && qemu_passes::usesOpenTitanRTLAdapter(M)) {
          // EXTERNALLY-ENABLED ring: if any non-reset arm of this ring is
          // gated by a MODULE INPUT (a BlockArgument reaching the branch
          // condition or the drv enable — e.g. prim_fifo_sync_cnt's
          // wptr/rptr advance only under incr_wptr_i/incr_rptr_i), the
          // counter is event-driven, not free-running: settle clocks step
          // it only while the enable is presented, which is exactly the
          // RTL behaviour.  Pump-gating such a ring freezes FIFO pointers
          // (hmac's msg_fifo went permanently empty; same mechanism behind
          // uart's RDATA readback oddity).  A free-running prescaler's arm
          // conditions contain only clock/reset/its own wrap compare —
          // never a module input — so those stay pump-gated.
          {
            bool extEnabled = false;
            // Event-driven ring exemption is DECLARED, not inferred: the
            // binding's live_ring_modules lists the hw.modules whose
            // counters step on external events (FIFO pointers, socket
            // outstanding trackers).  Pulse-vs-level enables are
            // statically indistinguishable (a prescaler's `active` and a
            // FIFO's `incr` look the same in IR) - every shape heuristic
            // tried here either put a free-running counter LIVE (aon
            // prescaler hung aon-timer-full; rv_timer's tick_count was a
            // 256x perf regression) or pump-gated a FIFO (hmac's
            // msg_fifo stayed empty).  Declaration is per-device: uart
            // keeps its FIFOs pump-gated by not declaring them.
            {
              StringRef curName = M.getName();
              ModuleOp rootMod = M->getParentOfType<ModuleOp>();
              if (rootMod) {
                rootMod.walk([&](hw::HWModuleOp m2) {
                  if (extEnabled)
                    return;
                  auto lst =
                      m2->getAttrOfType<ArrayAttr>("qemu.live_ring_modules");
                  if (!lst)
                    return;
                  for (Attribute a : lst) {
                    auto s2 = dyn_cast<StringAttr>(a);
                    if (!s2)
                      continue;
                    StringRef base = s2.getValue();
                    if (curName == base ||
                        (curName.starts_with(base) &&
                         curName.size() > base.size() &&
                         curName[base.size()] == '_' &&
                         curName.drop_front(base.size() + 1)
                             .find_first_not_of("0123456789") ==
                             StringRef::npos))
                      extEnabled = true;
                  }
                });
              }
            }
            if (extEnabled) {
              // The ring stays LIVE (no pump gate) — but any arm classified
              // ACCUMULATE would be emitted on the advance_tick pump path
              // and vanish for pumpless devices; migrate it back to a
              // plain SEQ drv.
              proc.walk([&](llhd::DriveOp d2) {
                if (baseSig(d2.getSignal()) != S.target) return;
                if (auto cls = d2->getAttrOfType<StringAttr>("qemu.drv_class"))
                  if (cls.getValue() == "ACCUMULATE") {
                    d2->setAttr("qemu.drv_class",
                                StringAttr::get(d2->getContext(), "COMPLEX"));
                    d2->removeAttr("qemu.step");
                    migratedAcc++;
                  }
              });
              llvm::outs() << "  [ACC-RING input-enable] " << getSignalName(S.target)
                           << " @" << M.getName()
                           << " -> live (steps only under a module-input enable)\n";
              return;
            }
          }
          // 模块内环(寄存器 + 步进 + 回绕都在本模块,drv 实例专属):使能门控——
          // 该寄存器在本进程里的**所有** drv(步进臂、回绕臂、清零臂……RTL 的
          // if-else 链在 IR 里是各自独立的分支块)条件 && _qp_pump,settle 拍
          // 整体保持,pump 拍走真实 next,与 RTL 同拍。只放过复位臂(观察表里
          // 非时钟信号——rst——取反那一支),复位仍在 settle 里生效。
          llvm::SmallPtrSet<Value, 4> resetSigs;   // 观察表里的非时钟信号 = 复位
          proc.walk([&](llhd::WaitOp w) {
            for (Value obs : w.getObserved())
              if (auto prb = obs.getDefiningOp<llhd::ProbeOp>())
                if (auto sigOp = prb.getSignal().getDefiningOp<llhd::SignalOp>())
                  if (!sigOp->hasAttr("qemu.is_clock")) resetSigs.insert(sigOp.getResult());
          });
          auto isResetArm = [&](llhd::DriveOp d2) -> bool {
            // 向上最多 8 层单前驱:遇到 cond_br(!R) 且我们在 true 侧 → 复位臂
            Block *bb = d2->getBlock();
            // NO ARBITRARY DEPTH.  The walk already stops at the first join
            // (npred != 1); the 8 only truncated deeply nested guards, and
            // silently.  `seenBlocks` is the termination proof.
            llvm::SmallPtrSet<Block *, 16> seenBlocks;
            while (bb && seenBlocks.insert(bb).second) {
              Block *pred = nullptr; int npred = 0;
              for (Block *p2 : bb->getPredecessors()) { pred = p2; npred++; }
              if (npred != 1) return false;
              if (auto cbr = dyn_cast<cf::CondBranchOp>(pred->getTerminator())) {
                Value c = cbr.getCondition();
                Value probed;
                if (auto x = c.getDefiningOp<comb::XorOp>()) {
                  for (Value o : x.getOperands())
                    if (auto prb = o.getDefiningOp<llhd::ProbeOp>()) probed = prb.getSignal();
                } else if (auto ic = c.getDefiningOp<comb::ICmpOp>()) {
                  if (ic.getPredicate() == comb::ICmpPredicate::eq)
                    if (auto prb = ic.getLhs().getDefiningOp<llhd::ProbeOp>()) probed = prb.getSignal();
                }
                if (probed && resetSigs.count(baseSig(probed)) && cbr.getTrueDest() == bb)
                  return true;
              }
              bb = pred;
            }
            return false;
          };
          bool announced = false;
          proc.walk([&](llhd::DriveOp d2) {
            if (baseSig(d2.getSignal()) != S.target) return;
            if (isResetArm(d2) || d2->hasAttr("qemu.pump_gate")) return;
            d2->setAttr("qemu.pump_gate", UnitAttr::get(d2->getContext()));
            // 曾被 classifyDrv 判成 ACCUMULATE(直接形状 q<=q±c)的,统一改走泵门控:
            // 留在 tick、回绕/复位臂保留、不再建 ptimer / advance_tick "+= step"
            if (auto cls = d2->getAttrOfType<StringAttr>("qemu.drv_class"))
              if (cls.getValue() == "ACCUMULATE") {
                d2->setAttr("qemu.drv_class", StringAttr::get(d2->getContext(), "COMPLEX"));
                d2->removeAttr("qemu.step");
                migratedAcc++;
              }
            marked++;
            if (!announced) {
              llvm::outs() << "  [ACC-RING local] " << getSignalName(S.target) << " @"
                           << M.getName() << " -> drvs pump-gated\n";
              announced = true;
            }
          });
        } else {
          if (!qemu_passes::usesOpenTitanRTLAdapter(M)) {
            proc.walk([&](llhd::DriveOp d2) {
              if (baseSig(d2.getSignal()) != S.target) return;
              if (auto cls = d2->getAttrOfType<StringAttr>("qemu.drv_class"))
                if (cls.getValue() == "ACCUMULATE") {
                  d2->setAttr("qemu.drv_class", StringAttr::get(d2->getContext(), "COMPLEX"));
                  d2->removeAttr("qemu.step");
                  migratedAcc++;
                }
            });
          }
          // Generic rings gate arithmetic only: software load/reset arms must
          // remain live during settling, otherwise a transient load is lost
          // before the next virtual-time pump. The explicit legacy adapter
          // retains its whole-register gating policy.
          // 跨实例边界的环(+step 在别的模块、经端口/寄存器堆写回,寄存器 drv 是
          // 共享原语):数据门控——步进侧 && _qp_pump;SW 写路径不受影响。
          for (auto &[op, idx] : S.route) {
            if (markedOps.insert(op).second) {
              op->setAttr("qemu.pump_acc_operand",
                          IntegerAttr::get(IntegerType::get(op->getContext(), 32), idx));
              marked++;
              llvm::outs() << "  [ACC-RING cross] " << getSignalName(S.target) << " @"
                           << M.getName() << " <- step at "
                           << op->getParentOfType<hw::HWModuleOp>().getName() << "\n";
            }
          }
        }
      }
    });
    M.walk([&](hw::InstanceOp inst) {
      auto N = refMod(inst); if (!N) return;
      P.push_back(inst.getOperation());
      visit(N, P, depth - 1);
      P.pop_back();
    });
  }
};

struct AccumulateRingDetectPass
    : public ::impl::AccumulateRingDetectBase<AccumulateRingDetectPass> {
  void runOnOperation() override {
    ModuleOp mod = getOperation();
    llvm::outs() << "========================================\n";
    llvm::outs() << "Pass: Accumulate Ring Detect\n";
    llvm::outs() << "========================================\n";
    if (getenv("QP_NO_ACCRING")) { llvm::outs() << "  (skipped: QP_NO_ACCRING)\n"; return; }
    AccRingTracer t(mod);
    if (!t.top) return;
    t.timerPump = t.top->hasAttr("qemu.timer_pump");
    llvm::outs() << "  device pump: " << (t.timerPump ? "yes (all rings pump-gated)"
                                          : "no (only former ACCUMULATE counters)") << "\n";
    AccRingTracer::Path P;
    t.precomputeBusStrobe(t.top, P, 32);
    t.visit(t.top, P, 32);
    llvm::outs() << "  rings found: " << t.ringsFound << "  marked: " << t.marked
                 << "  ACCUMULATE->pump-gated: " << t.migratedAcc
                 << "  budget hits: " << t.visitsBudgetHits << "\n\n";
  }
};

} // namespace
