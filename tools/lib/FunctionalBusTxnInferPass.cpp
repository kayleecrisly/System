/*
 * FunctionalBusTxnInferPass.cpp - 功能/结构总线事务推断（不依赖字段名）
 *
 * Phase 2 改进:
 * - rdata 提取（从输出反向追踪）
 * - evidence_paths 分组（enable/addr/wdata/mask/rdata/opcode）
 * - opcode predicate 跨边界关联
 * - bus_like_module 白名单（避免误杀 tlul_adapter_reg）
 */

#include "PassReports.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/BuiltinTypes.h"
#include "mlir/IR/Visitors.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Support/LLVM.h"

#include "circt/Dialect/HW/HWOps.h"
#include "circt/Dialect/Comb/CombOps.h"
#include "circt/Dialect/LLHD/LLHDOps.h"

#include "llvm/ADT/StringSet.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/JSON.h"
#include "llvm/Support/Format.h"

#include <map>
#include <set>
#include <optional>
#include <queue>

#define GEN_PASS_DECL_FUNCTIONALBUSTXNINFER
#define GEN_PASS_DEF_FUNCTIONALBUSTXNINFER
#include "Passes.h.inc"

using namespace mlir;
using namespace circt;

namespace {

//===----------------------------------------------------------------------===//
// Known rdata-side signal name patterns (OT TL-UL / AHB / APB conventions).
//
// Used by:
//   - findRdataCandidates (Fallback 3) to seed an rdata candidate when
//     data-flow tracing fails.
//   - traceWDataCandidates (Bug B fix) to refuse BFS into a sig whose
//     name marks it as the rdata path — preventing wdata trace from
//     landing on a rdata sig and producing wdata_signal == rdata_signal
//     emit-c collisions.
//===----------------------------------------------------------------------===//
static constexpr llvm::StringLiteral kRdataSigPatterns[] = {
    "reg_rdata_next", "reg_rdata", "tl_o_d_data",
    "rdata_next",     "rdata",     "d_data",
    "read_data",      "prdata",
};

static bool sigNameMatchesRdataPattern(StringRef name) {
  for (auto pattern : kRdataSigPatterns) {
    if (name == pattern || name.contains(pattern))
      return true;
  }
  return false;
}

//===----------------------------------------------------------------------===//
// Data Structures
//===----------------------------------------------------------------------===//

struct EvidencePathsGrouped {
  SmallVector<std::string, 2> enable;
  SmallVector<std::string, 2> addr;
  SmallVector<std::string, 4> wdata;
  SmallVector<std::string, 2> mask;
  SmallVector<std::string, 4> rdata;
  SmallVector<std::string, 2> opcode;

  llvm::json::Object toJSON() const {
    llvm::json::Object obj;
    if (!enable.empty()) {
      llvm::json::Array arr;
      for (auto &s : enable) arr.push_back(s);
      obj["enable"] = std::move(arr);
    }
    if (!addr.empty()) {
      llvm::json::Array arr;
      for (auto &s : addr) arr.push_back(s);
      obj["addr"] = std::move(arr);
    }
    if (!wdata.empty()) {
      llvm::json::Array arr;
      for (auto &s : wdata) arr.push_back(s);
      obj["wdata"] = std::move(arr);
    }
    if (!mask.empty()) {
      llvm::json::Array arr;
      for (auto &s : mask) arr.push_back(s);
      obj["mask"] = std::move(arr);
    }
    if (!rdata.empty()) {
      llvm::json::Array arr;
      for (auto &s : rdata) arr.push_back(s);
      obj["rdata"] = std::move(arr);
    }
    if (!opcode.empty()) {
      llvm::json::Array arr;
      for (auto &s : opcode) arr.push_back(s);
      obj["opcode"] = std::move(arr);
    }
    return obj;
  }

  bool isEmpty() const {
    return enable.empty() && addr.empty() && wdata.empty() &&
           mask.empty() && rdata.empty() && opcode.empty();
  }
};

struct BusTxnCandidate {
  enum Kind { READ, WRITE, UNKNOWN };

  Kind kind = UNKNOWN;
  Value enableCond;
  Value addrValue;
  Value wdataValue;
  Value maskValue;
  Value rdataValue;
  // Stage A — opcode SSA value, captured when an OpcodePredicate is
  // associated with this txn's enable condition.  Used by writeAttributesToIR
  // to derive a real signal name for qemu.protocol_constraints (rather
  // than dumping path-trace breadcrumbs that no downstream pass can match).
  Value opcodeValue;

  double confidence = 0.0;
  bool weak = false;
  bool isBusLike = false;     // true → is_bus_write=true in JSON
  bool isInternalWrite = false; // true → kind 输出为 "INTERNAL_WRITE"
  // v6: TL-UL anchor — true if wdata is proven to depend on TL-UL a_data
  // (either directly via struct_extract[a_data] or via hw.instance with TLUL input)
  bool wdataAnchoredToTLUL = false;

  // v7: computed signature string used for deduplication and JSON id
  std::string signature;

  struct Evidence {
    int registersControlled = 0;
    int addrIcmpCount = 0;
    int wdataPathDepth = 0;   // true BFS depth of chosen wdata (not score)
    int wdataScore = 0;       // v6: Stage B score of chosen wdata candidate
    int rdataPathDepth = 0;
    std::string reason;
    std::string wdataSourceKind;  // "struct_field", "port_arg", "computed", "constant", "unknown"
    std::string wdataAnchorKind;  // v6: "" / "direct_a_data" / "instance_tlul_wdata_o" / "unanchored"
    // v7: how the address was discovered — "icmp" | "struct_field" | "derived"
    std::string addrSourceKind;
    SmallVector<std::string, 4> wdataAlt;  // fallback candidates for TLUL without a_data
    SmallVector<std::string, 2> debugSnippet;
    EvidencePathsGrouped paths;
  } evidence;

  std::optional<Location> site;

  llvm::json::Object toJSON() const {
    llvm::json::Object obj;

    // kind: INTERNAL_WRITE 优先，否则沿用 WRITE/READ/UNKNOWN
    if (isInternalWrite)
      obj["kind"] = std::string("INTERNAL_WRITE");
    else
      obj["kind"] = (kind == READ ? "READ" : (kind == WRITE ? "WRITE" : "UNKNOWN"));

    obj["confidence"] = confidence;
    obj["weak"] = weak;
    obj["is_bus_write"] = isBusLike;
    obj["has_enable"] = enableCond ? true : false;
    obj["has_addr"] = addrValue ? true : false;
    obj["has_wdata"] = wdataValue ? true : false;
    obj["has_rdata"] = rdataValue ? true : false;

    llvm::json::Object evidenceObj{
      {"registers_controlled", evidence.registersControlled},
      {"addr_icmp_count", evidence.addrIcmpCount},
      {"wdata_path_depth", evidence.wdataPathDepth},
      {"wdata_score", evidence.wdataScore},
      {"rdata_path_depth", evidence.rdataPathDepth},
      {"reason", evidence.reason}
    };

    if (!evidence.wdataSourceKind.empty())
      evidenceObj["wdata_source_kind"] = evidence.wdataSourceKind;
    if (!evidence.wdataAnchorKind.empty())
      evidenceObj["wdata_anchor_kind"] = evidence.wdataAnchorKind;
    if (!evidence.addrSourceKind.empty())
      evidenceObj["addr_source_kind"] = evidence.addrSourceKind;

    obj["evidence"] = std::move(evidenceObj);

    // v7: signature for deduplication / debugging
    if (!signature.empty())
      obj["txn_id"] = signature;

    // 构建 evidence_paths（强制输出，只要有 wdata）
    auto pathsObj = evidence.paths.toJSON();

    // (3) 强制输出 evidence_paths.wdata（v6: 包含 anchor/depth/score 信息）
    if (wdataValue && evidence.paths.wdata.empty()) {
      llvm::json::Array fallback;
      // 尽量给出可解释信息
      std::string desc = evidence.wdataSourceKind.empty() ? "unknown" : evidence.wdataSourceKind;
      if (!evidence.wdataAnchorKind.empty())
        desc += "(" + evidence.wdataAnchorKind + ")";
      desc += ",depth=" + std::to_string(evidence.wdataPathDepth);
      desc += ",score=" + std::to_string(evidence.wdataScore);
      fallback.push_back(desc);
      pathsObj["wdata"] = std::move(fallback);
    }

    // 强制输出 evidence_paths.addr（v7: 使用 addrSourceKind 区分来源）
    if (addrValue && evidence.paths.addr.empty()) {
      llvm::json::Array addrFallback;
      if (evidence.addrSourceKind == "struct_field")
        addrFallback.push_back("struct_extract[a_address](icmp=0)");
      else
        addrFallback.push_back("icmp_count=" + std::to_string(evidence.addrIcmpCount));
      pathsObj["addr"] = std::move(addrFallback);
    }

    // wdata_alt（TLUL 找不到 a_data 时输出备选）
    if (!evidence.wdataAlt.empty()) {
      llvm::json::Array alt;
      for (auto &s : evidence.wdataAlt)
        alt.push_back(s);
      pathsObj["wdata_alt"] = std::move(alt);
    }

    if (!pathsObj.empty())
      obj["evidence_paths"] = std::move(pathsObj);

    // debug_snippet（可选）
    if (!evidence.debugSnippet.empty()) {
      llvm::json::Array ds;
      for (auto &s : evidence.debugSnippet)
        ds.push_back(s);
      obj["debug_snippet"] = std::move(ds);
    }

    return obj;
  }
};

//===----------------------------------------------------------------------===//
// Pass Implementation
//===----------------------------------------------------------------------===//

struct FunctionalBusTxnInferPass
    : public ::impl::FunctionalBusTxnInferBase<FunctionalBusTxnInferPass> {

  void runOnOperation() override;

private:
  DenseMap<Operation*, SmallVector<BusTxnCandidate, 4>> moduleTxns;

  //==========================================================================
  // Helper: 路径格式化
  //==========================================================================

  std::string formatPath(Value val, const SmallVector<std::string, 4> &trace) {
    // 如果 trace 不为空且包含 struct_extract，格式化为 port.<field>
    if (!trace.empty()) {
      // 尝试找到根端口名
      if (auto arg = mlir::dyn_cast<BlockArgument>(val)) {
        std::string portName = "arg" + std::to_string(arg.getArgNumber());
        std::string path = portName;
        for (const auto &t : trace) {
          if (t.find("struct_extract[") != std::string::npos) {
            // 提取字段名
            size_t start = t.find('[') + 1;
            size_t end = t.find(']');
            if (start != std::string::npos && end != std::string::npos) {
              path += "." + t.substr(start, end - start);
            }
          }
        }
        return path;
      }
    }

    // Fallback: 返回简单描述
    if (trace.empty()) {
      return "direct_value";
    }
    return trace[0];
  }

  //==========================================================================
  // Stage 1: 识别寄存器集合
  //==========================================================================

  SmallVector<Value, 32> collectRegisters(hw::HWModuleOp module) {
    SmallVector<Value, 32> result;
    llvm::DenseSet<Value> seen;

    module.walk([&](llhd::ProcessOp proc) {
      proc.walk([&](llhd::DriveOp drv) {
        Value target = drv.getSignal();

        Operation *defOp = target.getDefiningOp();
        if (!defOp || defOp->getName().getStringRef() != "llhd.sig")
          return;

        Type resultType = defOp->getResult(0).getType();
        if (auto intType = mlir::dyn_cast<IntegerType>(resultType)) {
          if (intType.getWidth() <= 1)
            return;
        }

        if (!seen.contains(target)) {
          seen.insert(target);
          result.push_back(target);
        }
      });
    });

    return result;
  }

  //==========================================================================
  // Stage 2: 反推写使能条件 + opcode predicate 收集
  //==========================================================================

  struct WriteEnableCandidate {
    Value cond;
    int regsCovered = 0;
  };

  struct OpcodePredicate {
    Value icmpResult;
    Value opcodeOperand;
    int64_t constantValue = -1;
    SmallVector<std::string, 2> pathTrace;
  };

  // 收集 opcode predicates（跨 process）
  SmallVector<OpcodePredicate, 4> collectOpcodePredicates(hw::HWModuleOp module) {
    SmallVector<OpcodePredicate, 4> result;

    module.walk([&](comb::ICmpOp icmp) {
      for (Value operand : icmp->getOperands()) {
        if (operand.getDefiningOp<hw::ConstantOp>())
          continue;

        // 追踪是否来自 struct_extract
        TraceResult trace = traceToBestInput(operand, 5);
        bool isOpcodeRelated = false;

        for (const auto &pathStr : trace.pathTrace) {
          if (pathStr.find("opcode") != std::string::npos ||
              pathStr.find("a_opcode") != std::string::npos) {
            isOpcodeRelated = true;
            break;
          }
        }

        if (isOpcodeRelated || trace.pathTrace.size() > 0) {
          OpcodePredicate pred;
          pred.icmpResult = icmp.getResult();
          pred.opcodeOperand = operand;
          pred.pathTrace.assign(trace.pathTrace.begin(), trace.pathTrace.end());

          // 提取常量值
          for (Value op : icmp->getOperands()) {
            if (auto constOp = op.getDefiningOp<hw::ConstantOp>()) {
              pred.constantValue = constOp.getValue().getSExtValue();
            }
          }

          result.push_back(pred);
        }
      }
    });

    return result;
  }

  SmallVector<WriteEnableCandidate, 16> findWriteEnables(
      hw::HWModuleOp module, ArrayRef<Value> regSigs) {

    llvm::DenseSet<Value> regSigSet(regSigs.begin(), regSigs.end());
    DenseMap<Value, int> condCounts;

    module.walk([&](llhd::DriveOp drv) {
      if (!regSigSet.contains(drv.getSignal()))
        return;

      Value cond = extractCondition(drv.getValue());
      if (cond)
        condCounts[cond]++;
    });

    SmallVector<WriteEnableCandidate, 16> result;
    for (auto &pair : condCounts) {
      WriteEnableCandidate we;
      we.cond = pair.first;
      we.regsCovered = pair.second;
      result.push_back(we);
    }

    llvm::sort(result, [&](const WriteEnableCandidate &a,
                           const WriteEnableCandidate &b) {
      if (a.regsCovered != b.regsCovered)
        return a.regsCovered > b.regsCovered;
      std::string an = deriveSignalName(module, a.cond, "enable", 0);
      std::string bn = deriveSignalName(module, b.cond, "enable", 0);
      if (an != bn)
        return an < bn;
      return programOrderKey(module, a.cond) < programOrderKey(module, b.cond);
    });

    return result;
  }

  Value extractCondition(Value val) {
    Operation *defOp = val.getDefiningOp();
    if (!defOp)
      return nullptr;

    if (auto muxOp = dyn_cast<comb::MuxOp>(defOp))
      return muxOp.getCond();

    if (auto andOp = dyn_cast<comb::AndOp>(defOp)) {
      for (Value operand : andOp.getOperands()) {
        if (auto intType = mlir::dyn_cast<IntegerType>(operand.getType())) {
          if (intType.getWidth() == 1)
            return operand;
        }
      }
    }

    return nullptr;
  }

  //==========================================================================
  // Stage 3: 识别地址信号
  //==========================================================================

  struct AddressCandidate {
    Value val;
    int icmpCount = 0;
    unsigned bitwidth = 0;
    std::string sourceKind;  // v7: "icmp" | "struct_field" | "derived"
    SmallVector<std::string, 2> pathTrace;
  };

  SmallVector<AddressCandidate, 16> findAddressSignals(hw::HWModuleOp module) {
    DenseMap<Value, AddressCandidate> addrMap;

    module.walk([&](comb::ICmpOp icmp) {
      for (Value operand : icmp->getOperands()) {
        if (operand.getDefiningOp<hw::ConstantOp>())
          continue;

        auto type = mlir::dyn_cast<IntegerType>(operand.getType());
        if (!type)
          continue;

        unsigned width = type.getWidth();
        if (width < 4 || width > 64)
          continue;

        auto &entry = addrMap[operand];
        entry.val = operand;
        entry.icmpCount++;
        entry.bitwidth = width;
        entry.sourceKind = "icmp";  // v7

        if (entry.pathTrace.empty()) {
          TraceResult trace = traceToBestInput(operand, 5);
          entry.pathTrace.assign(trace.pathTrace.begin(), trace.pathTrace.end());
        }
      }
    });

    SmallVector<AddressCandidate, 16> result;
    for (auto &pair : addrMap) {
      if (pair.second.icmpCount >= 2) {
        result.push_back(pair.second);
      }
    }

    llvm::sort(result, [&](const AddressCandidate &a, const AddressCandidate &b) {
      if (a.icmpCount != b.icmpCount)
        return a.icmpCount > b.icmpCount;
      if (a.bitwidth != b.bitwidth)
        return a.bitwidth > b.bitwidth;
      std::string an = deriveSignalName(module, a.val, "addr", 0);
      std::string bn = deriveSignalName(module, b.val, "addr", 0);
      if (an != bn)
        return an < bn;
      return programOrderKey(module, a.val) < programOrderKey(module, b.val);
    });

    return result;
  }

  //==========================================================================
  // v7: findTLULAddrFromStruct — 从 struct_extract 或端口 struct 字段找 addr 候选
  //==========================================================================

  SmallVector<AddressCandidate, 4> findTLULAddrFromStruct(hw::HWModuleOp module) {
    SmallVector<AddressCandidate, 4> result;
    llvm::DenseSet<Value> seen;

    // Method 1: 扫描模块体内所有 hw::StructExtractOp，字段名匹配 addr 关键词
    module.walk([&](hw::StructExtractOp extractOp) {
      StringRef fn = extractOp.getFieldNameAttr().getValue();
      bool isAddrField = (fn == "a_address" || fn == "address" ||
                          fn == "addr"       || fn == "reg_addr");
      if (!isAddrField) return;

      Value extracted = extractOp.getResult();
      if (seen.contains(extracted)) return;
      seen.insert(extracted);

      auto intType = mlir::dyn_cast<IntegerType>(extracted.getType());
      if (!intType || intType.getWidth() < 4) return;

      AddressCandidate cand;
      cand.val = extracted;
      cand.icmpCount = 0;
      cand.bitwidth = intType.getWidth();
      cand.sourceKind = "struct_field";
      cand.pathTrace.push_back("struct_extract[" + fn.str() + "]");
      result.push_back(cand);
    });

    // Method 2: 端口级 fallback — 模块不直接 extract（如 uart_reg_top 把 tl_i 透传）
    // 扫描 block argument struct 类型字段，生成虚拟候选（val = struct port arg）
    if (result.empty()) {
      for (auto portArg : module.getBodyBlock()->getArguments()) {
        auto structType = mlir::dyn_cast<hw::StructType>(portArg.getType());
        if (!structType) continue;
        for (auto &field : structType.getElements()) {
          StringRef fn = field.name.getValue();
          if (fn == "a_address" || fn == "address" || fn == "addr") {
            AddressCandidate cand;
            cand.val = portArg;  // struct port arg 作为地址代理
            cand.icmpCount = 0;
            cand.bitwidth = 32;  // TL-UL 地址典型宽度
            cand.sourceKind = "struct_field";
            cand.pathTrace.push_back("port_struct[" + fn.str() + "]");
            result.push_back(cand);
            break;
          }
        }
        if (!result.empty()) break;
      }
    }

    return result;
  }

  //==========================================================================
  // Improved Tracing: traceToBestInput
  //==========================================================================

  struct TraceResult {
    Value root;
    int depth = 0;
    int score = 0;
    SmallVector<std::string, 4> pathTrace;

    TraceResult() = default;
    TraceResult(Value v, int d, int s, SmallVector<std::string, 4> p)
        : root(v), depth(d), score(s), pathTrace(std::move(p)) {}
  };

  TraceResult traceToBestInput(Value startVal, int maxDepth = 10) {
    llvm::DenseSet<Value> visited;
    std::queue<std::tuple<Value, int, SmallVector<std::string, 4>>> queue;

    queue.push(std::make_tuple(startVal, 0, SmallVector<std::string, 4>{}));
    visited.insert(startVal);

    TraceResult best;
    best.root = startVal;
    best.score = computeValueScore(startVal);

    while (!queue.empty()) {
      auto [val, depth, path] = queue.front();
      queue.pop();

      if (depth >= maxDepth)
        continue;

      if (auto arg = mlir::dyn_cast<BlockArgument>(val)) {
        int score = computeValueScore(val) + 1000;
        if (score > best.score || (score == best.score && depth < best.depth)) {
          best.root = val;
          best.depth = depth;
          best.score = score;
          best.pathTrace = path;
        }
        continue;
      }

      Operation *defOp = val.getDefiningOp();
      if (!defOp)
        continue;

      int score = computeValueScore(val);
      if (score > best.score || (score == best.score && depth < best.depth)) {
        best.root = val;
        best.depth = depth;
        best.score = score;
        best.pathTrace = path;
      }

      SmallVector<Value, 4> nextValues;

      if (auto structExtract = dyn_cast<hw::StructExtractOp>(defOp)) {
        auto newPath = path;
        newPath.push_back("struct_extract[" + structExtract.getFieldNameAttr().str() + "]");
        nextValues.push_back(structExtract.getInput());

        for (Value next : nextValues) {
          if (!visited.contains(next)) {
            visited.insert(next);
            queue.push(std::make_tuple(next, depth + 1, newPath));
          }
        }
        continue;
      }

      if (auto prb = dyn_cast<llhd::ProbeOp>(defOp)) {
        auto newPath = path;
        newPath.push_back("prb");
        nextValues.push_back(prb.getSignal());
      } else if (auto mux = dyn_cast<comb::MuxOp>(defOp)) {
        nextValues.push_back(mux.getTrueValue());
        nextValues.push_back(mux.getFalseValue());
      } else if (auto concat = dyn_cast<comb::ConcatOp>(defOp)) {
        for (Value operand : concat.getInputs())
          nextValues.push_back(operand);
      } else if (auto extract = dyn_cast<comb::ExtractOp>(defOp)) {
        nextValues.push_back(extract.getInput());
      } else {
        for (Value operand : defOp->getOperands()) {
          nextValues.push_back(operand);
        }
      }

      for (Value next : nextValues) {
        if (!visited.contains(next)) {
          visited.insert(next);
          queue.push(std::make_tuple(next, depth + 1, path));
        }
      }
    }

    return best;
  }

  int computeValueScore(Value val) {
    int score = 0;

    if (mlir::dyn_cast<BlockArgument>(val)) {
      // 🔴 Fix: 只有 integer 类型的 block arg 才得高分
      // struct 类型的 block arg 不能作为 wdata 的 root（类型检查会失败）
      if (mlir::dyn_cast<IntegerType>(val.getType()))
        return 1000;
      else
        return 0;  // struct/other block args: 不作为 wdata root
    }

    if (auto intType = mlir::dyn_cast<IntegerType>(val.getType())) {
      score += intType.getWidth();
    }

    int useCount = 0;
    for (auto user : val.getUsers())
      useCount++;
    score += useCount * 2;

    return score;
  }

  //==========================================================================
  // Two-Stage WData: dedicated BFS that captures struct_extract integer fields
  //==========================================================================

  struct WDataTrace {
    Value val;
    std::string fieldName;   // non-empty if came from struct_extract
    std::string sourceKind;  // struct_field / port_arg / computed / constant
    unsigned width = 0;
    int depth = 0;   // true BFS depth (hops from start value to this value)
    int score = 0;   // Stage B computed score — NEVER mixed with depth
    bool dependsOnAData = false;  // proven: this value's data flow originates from a_data
    SmallVector<std::string, 4> paths;  // path entries (e.g. "struct_extract[a_data]")

    bool isAData() const {
      // Only match direct struct_extract[a_data] — don't match dependency strings
      // that merely mention "a_data" (e.g. "inst_result[wdata_o]->depends(a_data)")
      return fieldName == "a_data";
    }
    bool isBadField() const {
      // TL-UL 非数据字段：强拒绝（无论评分多高）
      return fieldName == "a_mask"    || fieldName == "a_address" ||
             fieldName == "a_opcode" || fieldName == "a_size"    ||
             fieldName == "a_valid"  || fieldName == "a_ready";
    }
  };

  // 专用 BFS：从 drv RHS 开始，收集所有 integer 候选，正确记录 struct_extract 字段名
  SmallVector<WDataTrace, 8> traceWDataCandidates(Value startVal, int maxDepth = 14) {
    struct Entry {
      Value val;
      int depth;
      SmallVector<std::string, 4> path;
      std::string lastField;  // field name if parent was struct_extract
    };

    llvm::DenseMap<Value, WDataTrace> found;
    llvm::DenseSet<Value> visited;
    std::queue<Entry> q;
    q.push({startVal, 0, {}, ""});
    visited.insert(startVal);

    while (!q.empty()) {
      auto entry = q.front();
      q.pop();
      Value val = entry.val;

      if (entry.depth > maxDepth)
        continue;

      // Bug B fix: if val is a prb of a sig whose name marks it as the rdata
      // path, refuse to record it as a wdata candidate.  Without this guard,
      // even a single visit during BFS would emit a wdata_signal name from
      // a known rdata sig.
      bool valIsRdataPathPrb = false;
      if (auto prbOp = val.getDefiningOp<llhd::ProbeOp>()) {
        if (auto sigDef = prbOp.getSignal().getDefiningOp<llhd::SignalOp>()) {
          if (auto nameAttr = sigDef.getName())
            valIsRdataPathPrb = sigNameMatchesRdataPattern(*nameAttr);
        }
      }

      // Record integer-typed values as candidates (unless they're rdata-path probes)
      if (!valIsRdataPathPrb)
      if (auto intType = mlir::dyn_cast<IntegerType>(val.getType())) {
        if (intType.getWidth() >= 8) {
          auto &cand = found[val];
          if (!cand.val) {
            cand.val = val;
            cand.fieldName = entry.lastField;
            cand.width = intType.getWidth();
            cand.depth = entry.depth;
            cand.paths = entry.path;

            if (auto blockArg = mlir::dyn_cast<BlockArgument>(val))
              cand.sourceKind = "port_arg";
            else if (val.getDefiningOp<hw::ConstantOp>())
              cand.sourceKind = "constant";
            else if (!entry.lastField.empty())
              cand.sourceKind = "struct_field";
            else
              cand.sourceKind = "computed";
          }
        }
      }

      // Continue BFS regardless of type
      Operation *defOp = val.getDefiningOp();
      if (!defOp)
        continue;  // block argument: no further traversal

      if (auto se = dyn_cast<hw::StructExtractOp>(defOp)) {
        std::string fn = se.getFieldNameAttr().str();
        auto newPath = entry.path;
        newPath.push_back("struct_extract[" + fn + "]");
        Value inp = se.getInput();
        if (!visited.contains(inp)) {
          visited.insert(inp);
          q.push({inp, entry.depth + 1, newPath, fn});
        }
      } else if (auto prb = dyn_cast<llhd::ProbeOp>(defOp)) {
        Value sig = prb.getSignal();
        // Bug B fix: refuse to chain through a sig whose name marks it as
        // the rdata path.  Without this guard, wdata trace on OT GPIO's
        // gpio_reg_top followed a mux feeding `reg_rdata_next` (an rdata
        // sig) and reported wdata_signal = "reg_rdata_next" — the same
        // name as rdata_signal.  We still allow the candidate already
        // recorded for `val` itself; we just stop expanding through this
        // particular branch.
        bool sigIsRdataPath = false;
        if (auto sigDef = sig.getDefiningOp<llhd::SignalOp>()) {
          if (auto nameAttr = sigDef.getName())
            sigIsRdataPath = sigNameMatchesRdataPattern(*nameAttr);
        }
        if (!sigIsRdataPath && !visited.contains(sig)) {
          visited.insert(sig);
          q.push({sig, entry.depth + 1, entry.path, entry.lastField});
        }
      } else if (auto mux = dyn_cast<comb::MuxOp>(defOp)) {
        for (Value v : {mux.getTrueValue(), mux.getFalseValue()}) {
          if (!visited.contains(v)) {
            visited.insert(v);
            q.push({v, entry.depth + 1, entry.path, ""});
          }
        }
      } else if (auto concat = dyn_cast<comb::ConcatOp>(defOp)) {
        for (Value v : concat.getInputs()) {
          if (!visited.contains(v)) {
            visited.insert(v);
            q.push({v, entry.depth + 1, entry.path, ""});
          }
        }
      } else if (auto ext = dyn_cast<comb::ExtractOp>(defOp)) {
        Value v = ext.getInput();
        if (!visited.contains(v)) {
          visited.insert(v);
          q.push({v, entry.depth + 1, entry.path, ""});
        }
      } else {
        // Generic: follow operands (comb.and/or/xor, bitcast, etc.)
        for (Value v : defOp->getOperands()) {
          if (!visited.contains(v)) {
            visited.insert(v);
            q.push({v, entry.depth + 1, entry.path, ""});
          }
        }
      }
    }

    SmallVector<WDataTrace, 8> result;
    for (auto &p : found)
      result.push_back(p.second);
    return result;
  }

  //==========================================================================
  // v7: dependsOnTLULField — 反向 BFS 验证 value 数据流是否源自 TLUL 字段
  //==========================================================================

  // 从 v 开始反向追踪数据依赖链，判断是否到达 hw::StructExtractOp(fieldName)
  // 或经过 hw::InstanceOp 且该实例接收含 fieldName 的 struct 输入
  bool dependsOnTLULField(Value v, StringRef fieldName, int maxDepth = 16) {
    llvm::DenseSet<Value> visited;
    std::queue<std::pair<Value, int>> q;
    q.push({v, 0});
    visited.insert(v);

    while (!q.empty()) {
      auto [val, depth] = q.front();
      q.pop();

      if (depth >= maxDepth) continue;

      Operation *defOp = val.getDefiningOp();
      if (!defOp) continue;  // block argument: no further traversal

      if (auto se = dyn_cast<hw::StructExtractOp>(defOp)) {
        // 直接命中字段名 → 证明依赖
        if (se.getFieldNameAttr().getValue() == fieldName)
          return true;
        // 否则继续追踪 struct 输入
        Value inp = se.getInput();
        if (!visited.contains(inp)) {
          visited.insert(inp);
          q.push({inp, depth + 1});
        }
      } else if (auto inst = dyn_cast<hw::InstanceOp>(defOp)) {
        // 检查 instance 的 operand 是否有含 fieldName 字段的 struct 类型
        for (Value operand : inst.getOperands()) {
          auto structType = mlir::dyn_cast<hw::StructType>(operand.getType());
          if (!structType) continue;
          for (auto &field : structType.getElements()) {
            if (field.name.getValue() == fieldName)
              return true;
          }
        }
        // 不进入 instance 内部（边界停止）
      } else if (auto prb = dyn_cast<llhd::ProbeOp>(defOp)) {
        Value sig = prb.getSignal();
        if (!visited.contains(sig)) {
          visited.insert(sig);
          q.push({sig, depth + 1});
        }
      } else if (auto mux = dyn_cast<comb::MuxOp>(defOp)) {
        for (Value v2 : {mux.getTrueValue(), mux.getFalseValue()}) {
          if (!visited.contains(v2)) {
            visited.insert(v2);
            q.push({v2, depth + 1});
          }
        }
      } else {
        for (Value operand : defOp->getOperands()) {
          if (!visited.contains(operand)) {
            visited.insert(operand);
            q.push({operand, depth + 1});
          }
        }
      }
    }

    return false;
  }

  //==========================================================================
  // Stage 4: READ/WRITE 分类
  //==========================================================================

  BusTxnCandidate::Kind classifyTransaction(
      hw::HWModuleOp module, Value enableCond, ArrayRef<Value> regSigs) {

    if (!enableCond)
      return BusTxnCandidate::UNKNOWN;

    llvm::DenseSet<Value> regSigSet(regSigs.begin(), regSigs.end());

    bool hasRegWrite = false;
    bool hasOutputPath = false;

    module.walk([&](llhd::DriveOp drv) {
      if (regSigSet.contains(drv.getSignal())) {
        if (usesValue(drv.getValue(), enableCond)) {
          hasRegWrite = true;
        }
      }
    });

    if (auto outputOp = module.getBodyBlock()->getTerminator()) {
      for (Value result : outputOp->getOperands()) {
        if (usesValue(result, enableCond)) {
          hasOutputPath = true;
          break;
        }
      }
    }

    if (hasRegWrite && !hasOutputPath)
      return BusTxnCandidate::WRITE;
    if (!hasRegWrite && hasOutputPath)
      return BusTxnCandidate::READ;
    if (hasRegWrite && hasOutputPath)
      return BusTxnCandidate::WRITE;

    return BusTxnCandidate::UNKNOWN;
  }

  bool usesValue(Value root, Value target) {
    if (root == target)
      return true;

    llvm::DenseSet<Value> visited;
    std::queue<Value> queue;
    queue.push(root);
    visited.insert(root);

    while (!queue.empty()) {
      Value current = queue.front();
      queue.pop();

      if (current == target)
        return true;

      Operation *defOp = current.getDefiningOp();
      if (!defOp)
        continue;

      for (Value operand : defOp->getOperands()) {
        if (!visited.contains(operand)) {
          visited.insert(operand);
          queue.push(operand);
        }
      }
    }

    return false;
  }

  //==========================================================================
  // Stage 5: 抽取 wdata/mask/rdata（改进版）
  //==========================================================================

  Value extractWData(hw::HWModuleOp module, Value enableCond, ArrayRef<Value> regSigs) {
    if (!enableCond)
      return nullptr;

    llvm::DenseSet<Value> regSigSet(regSigs.begin(), regSigs.end());

    struct WDataCandidate {
      Value val;
      int score = 0;
      int depth = 0;
      SmallVector<std::string, 4> paths;
    };

    SmallVector<WDataCandidate, 4> candidates;

    module.walk([&](llhd::DriveOp drv) {
      if (!regSigSet.contains(drv.getSignal()))
        return;
      if (!usesValue(drv.getValue(), enableCond))
        return;

      TraceResult trace = traceToBestInput(drv.getValue());
      if (trace.root) {
        WDataCandidate cand;
        cand.val = trace.root;
        cand.score = trace.score;
        cand.depth = trace.depth;
        cand.paths = trace.pathTrace;
        candidates.push_back(cand);
      }
    });

    if (candidates.empty())
      return nullptr;

    llvm::stable_sort(candidates, [](const WDataCandidate &a, const WDataCandidate &b) {
      return a.score > b.score;
    });

    return candidates[0].val;
  }

  Value extractMask(hw::HWModuleOp module, Value wdataValue) {
    if (!wdataValue)
      return nullptr;

    for (Operation *user : wdataValue.getUsers()) {
      if (auto andOp = dyn_cast<comb::AndOp>(user)) {
        for (Value operand : andOp.getOperands()) {
          if (operand != wdataValue) {
            auto type = mlir::dyn_cast<IntegerType>(operand.getType());
            if (type && type.getWidth() >= 4 && type.getWidth() <= 8) {
              return operand;
            }
          }
        }
      }
    }

    return nullptr;
  }

  // **改进的 rdata 提取**：从输出反向追踪受控的数据路径
  Value extractRData(hw::HWModuleOp module, Value enableCond, Value addrValue,
                     SmallVectorImpl<std::string> *outPaths = nullptr, int *outDepth = nullptr) {
    StringRef moduleName = module.getName();
    bool isTargetModule = moduleName.contains("tlul_adapter_reg") ||
                          moduleName.contains("uart_reg_top") ||
                          moduleName.contains("tlul_err");

    auto outputOp = module.getBodyBlock()->getTerminator();
    if (!outputOp) {
      if (isTargetModule) {
        llvm::errs() << "[DEBUG_RDATA] No output terminator found\n";
      }
      return nullptr;
    }

    if (isTargetModule) {
      llvm::errs() << "[DEBUG_RDATA] Extracting rdata for: " << moduleName << "\n";
      llvm::errs() << "[DEBUG_RDATA]   Output operands: " << outputOp->getNumOperands() << "\n";
      llvm::errs() << "[DEBUG_RDATA]   Has enableCond: " << (enableCond ? "yes" : "no") << "\n";
      llvm::errs() << "[DEBUG_RDATA]   Has addrValue: " << (addrValue ? "yes" : "no") << "\n";
    }

    struct RDataCandidate {
      Value val;
      int score = 0;
      int depth = 0;
      SmallVector<std::string, 4> paths;
    };

    SmallVector<RDataCandidate, 4> candidates;

    // 从每个输出 operand 反向追踪
    int opIdx = 0;
    for (Value outputOperand : outputOp->getOperands()) {
      // 方法1: 检查是否受 enableCond 影响
      bool controlled = false;
      bool method1 = false, method2 = false, method3 = false;

      if (enableCond && usesValue(outputOperand, enableCond)) {
        controlled = true;
        method1 = true;
      }

      // 方法2: 检查是否受 addrValue 影响（地址译码）
      if (addrValue && usesValue(outputOperand, addrValue)) {
        controlled = true;
        method2 = true;
      }

      // 方法3: 检查是否包含 mux 且受 addr 相关的 icmp 控制
      if (auto mux = outputOperand.getDefiningOp<comb::MuxOp>()) {
        Value selector = mux.getCond();
        // 追踪 selector 是否来自地址比较
        TraceResult selectorTrace = traceToBestInput(selector, 5);
        for (const auto &pathStr : selectorTrace.pathTrace) {
          if (pathStr.find("address") != std::string::npos ||
              pathStr.find("a_address") != std::string::npos) {
            controlled = true;
            method3 = true;
            break;
          }
        }
      }

      if (isTargetModule) {
        llvm::errs() << "[DEBUG_RDATA]   Operand " << opIdx << ": controlled=" << controlled
                     << " (m1=" << method1 << " m2=" << method2 << " m3=" << method3 << ")\n";
      }

      if (controlled) {
        TraceResult trace = traceToBestInput(outputOperand, 8);
        if (trace.root) {
          auto type = mlir::dyn_cast<IntegerType>(trace.root.getType());
          if (type && type.getWidth() >= 8) {  // 优先宽向量
            // 🔴 修复2：拒绝来自输入通道（a_*）的字段作为 rdata
            // TL-UL: a_* 是主机→设备（输入），d_* 是设备→主机（输出）
            bool isInputChannel = false;
            bool isOutputChannel = false;
            for (const auto &pathStr : trace.pathTrace) {
              // 检查是否来自输入通道
              if (pathStr.find("a_data") != std::string::npos ||
                  pathStr.find("a_mask") != std::string::npos ||
                  pathStr.find("a_address") != std::string::npos ||
                  pathStr.find("a_source") != std::string::npos ||
                  pathStr.find("a_size") != std::string::npos) {
                isInputChannel = true;
                break;
              }
              // 检查是否来自输出通道（d_*）
              if (pathStr.find("d_data") != std::string::npos) {
                isOutputChannel = true;
              }
            }

            if (isInputChannel) {
              if (isTargetModule) {
                llvm::errs() << "[DEBUG_RDATA]     -> Rejected: comes from input channel (a_*), not output\n";
              }
            } else {
              RDataCandidate cand;
              cand.val = trace.root;
              cand.score = trace.score + (type.getWidth() >= 32 ? 100 : 0);
              cand.depth = trace.depth;
              cand.paths = trace.pathTrace;

              // 如果来自输出通道（d_data），大幅加分
              if (isOutputChannel) {
                cand.score += 200;
                if (isTargetModule) {
                  llvm::errs() << "[DEBUG_RDATA]     -> Bonus: from output channel d_data (+200)\n";
                }
              }

              candidates.push_back(cand);

              if (isTargetModule) {
                llvm::errs() << "[DEBUG_RDATA]     -> Added candidate: width=" << type.getWidth()
                             << " score=" << cand.score << " depth=" << cand.depth << "\n";
              }
            }
          } else if (isTargetModule) {
            if (type) {
              llvm::errs() << "[DEBUG_RDATA]     -> Rejected: width=" << type.getWidth() << " < 8\n";
            } else {
              llvm::errs() << "[DEBUG_RDATA]     -> Rejected: not integer type\n";
            }
          }
        } else if (isTargetModule) {
          llvm::errs() << "[DEBUG_RDATA]     -> No trace root found\n";
        }
      }
      opIdx++;
    }

    // Fallback: 如果没有找到 controlled 的输出，尝试从 struct_create 中提取 d_data 字段
    if (candidates.empty() && isTargetModule) {
      llvm::errs() << "[DEBUG_RDATA]   Trying fallback: struct field extraction\n";
    }

    if (candidates.empty()) {
      int scIdx = 0;
      for (Value outputOperand : outputOp->getOperands()) {
        if (isTargetModule) {
          llvm::errs() << "[DEBUG_RDATA]   Checking output " << scIdx << " for struct_create\n";
        }

        if (auto structCreate = outputOperand.getDefiningOp<hw::StructCreateOp>()) {
          if (isTargetModule) {
            llvm::errs() << "[DEBUG_RDATA]     Found struct_create!\n";
          }

          auto structType = mlir::dyn_cast<hw::StructType>(structCreate.getType());
          if (!structType) {
            if (isTargetModule) {
              llvm::errs() << "[DEBUG_RDATA]     Not a struct type?\n";
            }
            continue;
          }

          auto fields = structType.getElements();
          if (isTargetModule) {
            llvm::errs() << "[DEBUG_RDATA]     Struct has " << fields.size() << " fields\n";
          }

          for (size_t i = 0; i < fields.size() && i < structCreate.getInput().size(); i++) {
            StringRef fieldName = fields[i].name.getValue();

            if (isTargetModule) {
              llvm::errs() << "[DEBUG_RDATA]       Field " << i << ": " << fieldName << "\n";
            }

            // 寻找常见的 read data 字段名
            if (fieldName.contains("d_data") || fieldName.contains("rdata") ||
                fieldName.contains("read_data") || fieldName == "data") {

              Value fieldValue = structCreate.getInput()[i];
              TraceResult trace = traceToBestInput(fieldValue, 8);

              if (trace.root) {
                auto type = mlir::dyn_cast<IntegerType>(trace.root.getType());
                if (type && type.getWidth() >= 8) {
                  RDataCandidate cand;
                  cand.val = trace.root;
                  cand.score = trace.score + (type.getWidth() >= 32 ? 100 : 0);
                  cand.depth = trace.depth;
                  cand.paths = trace.pathTrace;
                  candidates.push_back(cand);

                  if (isTargetModule) {
                    llvm::errs() << "[DEBUG_RDATA]     -> Fallback: found field '" << fieldName
                                 << "' width=" << type.getWidth() << " score=" << cand.score << "\n";
                  }
                }
              }
            }
          }
        } else if (isTargetModule) {
          // Check what type it is if not struct_create
          if (auto *defOp = outputOperand.getDefiningOp()) {
            llvm::errs() << "[DEBUG_RDATA]     Not struct_create, op is: " << defOp->getName() << "\n";
          } else {
            llvm::errs() << "[DEBUG_RDATA]     No defining op (block argument?)\n";
          }
        }
        scIdx++;
      }
    }

    // Fallback 2: 如果还是没找到，直接检查宽输出（>=32 bit integer）
    if (candidates.empty() && isTargetModule) {
      llvm::errs() << "[DEBUG_RDATA]   Trying fallback 2: wide integer outputs\n";
    }

    if (candidates.empty()) {
      for (Value outputOperand : outputOp->getOperands()) {
        auto type = mlir::dyn_cast<IntegerType>(outputOperand.getType());
        if (type && type.getWidth() >= 32) {
          TraceResult trace = traceToBestInput(outputOperand, 8);
          if (trace.root) {
            RDataCandidate cand;
            cand.val = trace.root;
            cand.score = trace.score + 50;  // Moderate confidence for wide outputs
            cand.depth = trace.depth;
            cand.paths = trace.pathTrace;
            candidates.push_back(cand);

            if (isTargetModule) {
              llvm::errs() << "[DEBUG_RDATA]     -> Fallback2: found wide output width="
                           << type.getWidth() << " score=" << cand.score << "\n";
            }
          }
        }
      }
    }

    // Fallback 3: Heuristic name scan — scan llhd.sig ops for rdata-like names.
    // This catches cases where data-flow tracing fails (e.g. output is a
    // struct-typed hw.instance result) but the module body contains a clearly
    // named rdata signal like reg_rdata_next or tl_o_d_data.
    if (candidates.empty()) {
      if (isTargetModule) {
        llvm::errs() << "[DEBUG_RDATA]   Trying fallback 3: heuristic name scan (llhd.sig)\n";
      }

      // Known rdata signal name patterns (most specific first)
      const StringRef rdataPatterns[] = {
        "reg_rdata_next", "reg_rdata", "tl_o_d_data",
        "rdata_next", "rdata", "d_data", "read_data", "prdata"
      };

      for (auto &op : *module.getBodyBlock()) {
        if (!candidates.empty()) break;  // Stop after first good match

        auto sigOp = dyn_cast<llhd::SignalOp>(&op);
        if (!sigOp) continue;

        // Get signal name
        auto nameAttr = sigOp.getName();
        if (!nameAttr) continue;
        std::string sigNameStr = nameAttr->str();
        StringRef sigName(sigNameStr);

        // Check if name matches any known rdata pattern
        bool matched = false;
        for (const auto &pattern : rdataPatterns) {
          if (sigName == pattern || sigName.contains(pattern)) {
            matched = true;
            break;
          }
        }
        if (!matched) continue;

        if (isTargetModule) {
          llvm::errs() << "[DEBUG_RDATA]     Heuristic match: llhd.sig '" << sigName << "'\n";
        }

        // Prefer a ProbeOp user (gives i32, not !hw.inout<i32>)
        Value sigResult = sigOp.getResult();
        bool foundPrb = false;
        for (auto *user : sigResult.getUsers()) {
          if (auto prbOp = dyn_cast<llhd::ProbeOp>(user)) {
            Value prbResult = prbOp.getResult();
            auto intType = mlir::dyn_cast<IntegerType>(prbResult.getType());
            if (intType && intType.getWidth() >= 8) {
              RDataCandidate cand;
              cand.val = prbResult;
              cand.score = 300;  // High confidence for heuristic name match
              cand.depth = 0;
              cand.paths.push_back("heuristic_name:" + sigNameStr);
              candidates.push_back(cand);
              foundPrb = true;

              if (isTargetModule) {
                llvm::errs() << "[DEBUG_RDATA]     -> Found prb user: width="
                             << intType.getWidth() << " score=300\n";
              }
              break;
            }
          }
        }

        // Fallback: if no ProbeOp, use signal directly
        if (!foundPrb) {
          if (auto inoutType = mlir::dyn_cast<llhd::RefType>(sigResult.getType())) {
            if (auto intType = mlir::dyn_cast<IntegerType>(inoutType.getNestedType())) {
              if (intType.getWidth() >= 8) {
                RDataCandidate cand;
                cand.val = sigResult;
                cand.score = 250;
                cand.depth = 0;
                cand.paths.push_back("heuristic_name_sig:" + sigNameStr);
                candidates.push_back(cand);

                if (isTargetModule) {
                  llvm::errs() << "[DEBUG_RDATA]     -> Using signal directly: width="
                               << intType.getWidth() << " score=250\n";
                }
              }
            }
          }
        }
      }
    }

    if (isTargetModule) {
      llvm::errs() << "[DEBUG_RDATA]   Total candidates found (after all fallbacks): " << candidates.size() << "\n";
    }

    if (candidates.empty())
      return nullptr;

    llvm::stable_sort(candidates, [](const RDataCandidate &a, const RDataCandidate &b) {
      return a.score > b.score;
    });

    // Populate output parameters if provided
    if (outPaths) {
      outPaths->assign(candidates[0].paths.begin(), candidates[0].paths.end());
    }
    if (outDepth) {
      *outDepth = candidates[0].depth;
    }

    return candidates[0].val;
  }

  //==========================================================================
  // Stage 6: 计算置信度
  //==========================================================================

  double computeConfidence(const BusTxnCandidate &txn) {
    double score = 0.0;

    if (txn.evidence.registersControlled >= 5)
      score += 0.4;
    else if (txn.evidence.registersControlled >= 3)
      score += 0.3;
    else if (txn.evidence.registersControlled >= 2)
      score += 0.2;
    else if (txn.evidence.registersControlled >= 1)
      score += 0.1;

    if (txn.evidence.addrIcmpCount >= 10)
      score += 0.3;
    else if (txn.evidence.addrIcmpCount >= 5)
      score += 0.2;
    else if (txn.evidence.addrIcmpCount >= 3)
      score += 0.15;
    else if (txn.evidence.addrIcmpCount >= 2)
      score += 0.1;

    if (txn.enableCond && txn.addrValue)
      score += 0.1;
    if (txn.wdataValue || txn.rdataValue)
      score += 0.2;

    if (!txn.evidence.paths.isEmpty())
      score += 0.05;

    return std::min(score, 1.0);
  }

  //==========================================================================
  // TLUL-like Module Detection
  //==========================================================================

  struct TLULSignature {
    bool hasAAddress = false;
    bool hasAData = false;
    bool hasAMask = false;
    bool hasASource = false;
    bool hasAOpcode = false;
    bool hasASize = false;
    int tlulFieldCount = 0;

    bool isTLULLike() const {
      // 至少出现 2 个 TL-UL 特征字段
      return tlulFieldCount >= 2;
    }
  };

  TLULSignature detectTLULSignature(hw::HWModuleOp module) {
    TLULSignature sig;

    // 方法1: 从模块内 struct_extract ops 检测（直接使用字段）
    module.walk([&](hw::StructExtractOp extractOp) {
      StringRef fieldName = extractOp.getFieldNameAttr().getValue();
      if (fieldName == "a_address") { sig.hasAAddress = true; sig.tlulFieldCount++; }
      else if (fieldName == "a_data") { sig.hasAData = true; sig.tlulFieldCount++; }
      else if (fieldName == "a_mask") { sig.hasAMask = true; sig.tlulFieldCount++; }
      else if (fieldName == "a_source") { sig.hasASource = true; sig.tlulFieldCount++; }
      else if (fieldName == "a_opcode") { sig.hasAOpcode = true; sig.tlulFieldCount++; }
      else if (fieldName == "a_size") { sig.hasASize = true; sig.tlulFieldCount++; }
    });

    // 方法2: 检查输入端口的 struct 类型字段名（即使模块内不直接 extract）
    // uart_reg_top 把 tl_i 传给子模块而不在顶层 extract，用这个方法检测
    if (!sig.isTLULLike()) {
      for (auto portArg : module.getBodyBlock()->getArguments()) {
        auto structType = mlir::dyn_cast<hw::StructType>(portArg.getType());
        if (!structType) continue;

        int portTLULCount = 0;
        for (auto &field : structType.getElements()) {
          StringRef fn = field.name.getValue();
          if (fn == "a_address") { sig.hasAAddress = true; portTLULCount++; }
          else if (fn == "a_data") { sig.hasAData = true; portTLULCount++; }
          else if (fn == "a_mask") { sig.hasAMask = true; portTLULCount++; }
          else if (fn == "a_source") { sig.hasASource = true; portTLULCount++; }
          else if (fn == "a_opcode") { sig.hasAOpcode = true; portTLULCount++; }
          else if (fn == "a_size") { sig.hasASize = true; portTLULCount++; }
        }
        if (portTLULCount >= 2) {
          sig.tlulFieldCount += portTLULCount;  // 端口级检测通过
          break;
        }
      }
    }

    return sig;
  }

  //==========================================================================
  // Bus-like Module Detection
  //==========================================================================

  bool isBusLikeModule(hw::HWModuleOp module) {
    StringRef moduleName = module.getName();
    bool isTargetModule = moduleName.contains("tlul_adapter_reg") ||
                          moduleName.contains("uart_reg_top") ||
                          moduleName.contains("tlul_err");

    int structExtractCount = 0;
    bool hasWideInput = false;
    bool hasStructInput = false;

    // 检查是否有 struct 类型输入且被多次 extract
    for (auto arg : module.getBodyBlock()->getArguments()) {
      if (auto structType = mlir::dyn_cast<hw::StructType>(arg.getType())) {
        hasStructInput = true;
        for (auto user : arg.getUsers()) {
          if (isa<hw::StructExtractOp>(user)) {
            structExtractCount++;
          }
        }
      }

      // 检查是否有宽数据输入（>=32 bit）
      if (auto intType = mlir::dyn_cast<IntegerType>(arg.getType())) {
        if (intType.getWidth() >= 32) {
          hasWideInput = true;
        }
      }
    }

    // Bus-like 特征：
    // 1. struct 被多次 extract（>=3），或
    // 2. 有 struct 输入且至少 1 次 extract 且有宽输入，或
    // 3. 有 struct 输入且有宽输入（即使 extract count==0，可能直接使用）
    bool result = structExtractCount >= 3 ||
                  (structExtractCount >= 1 && hasWideInput) ||
                  (hasStructInput && hasWideInput);

    if (isTargetModule) {
      llvm::errs() << "[DEBUG_BUSLIKE] Module: " << moduleName << "\n";
      llvm::errs() << "[DEBUG_BUSLIKE]   hasStructInput: " << hasStructInput << "\n";
      llvm::errs() << "[DEBUG_BUSLIKE]   structExtractCount: " << structExtractCount << "\n";
      llvm::errs() << "[DEBUG_BUSLIKE]   hasWideInput: " << hasWideInput << "\n";
      llvm::errs() << "[DEBUG_BUSLIKE]   result: " << result << "\n";
    }

    return result;
  }

  //==========================================================================
  // Main Analysis
  //==========================================================================

  void analyzeModule(hw::HWModuleOp module) {
    StringRef moduleName = module.getName();
    bool isTargetModule = moduleName.contains("tlul_adapter_reg") ||
                          moduleName.contains("uart_reg_top") ||
                          moduleName.contains("tlul_err");

    if (isTargetModule) {
      llvm::errs() << "[DEBUG] Analyzing module: " << moduleName << "\n";
    }

    SmallVector<Value, 32> regSigs = collectRegisters(module);
    if (regSigs.empty()) {
      if (isTargetModule) {
        llvm::errs() << "[DEBUG]   -> No registers found, skipping\n";
      }
      return;
    }

    if (isTargetModule) {
      llvm::errs() << "[DEBUG]   -> Found " << regSigs.size() << " registers\n";
    }

    SmallVector<WriteEnableCandidate, 16> writeEnables = findWriteEnables(module, regSigs);
    if (writeEnables.empty()) {
      if (isTargetModule) {
        llvm::errs() << "[DEBUG]   -> No write enables found, skipping\n";
      }
      return;
    }

    if (isTargetModule) {
      llvm::errs() << "[DEBUG]   -> Found " << writeEnables.size() << " write enable candidates\n";
    }

    SmallVector<AddressCandidate, 16> addrCandidates = findAddressSignals(module);
    SmallVector<OpcodePredicate, 4> opcodePredicates = collectOpcodePredicates(module);

    bool isBusLike = isBusLikeModule(module);

    // 🔴 改进2：TLUL-like 模式检测
    TLULSignature tlulSig = detectTLULSignature(module);
    bool isTLULLike = tlulSig.isTLULLike();

    // v7: TLUL-like 模块额外扫描 struct_extract / 端口 struct 的 addr 字段候选
    if (isTLULLike) {
      auto structAddrCands = findTLULAddrFromStruct(module);
      for (auto &c : structAddrCands) {
        // 合并：避免重复 (按 val 去重)
        bool dup = false;
        for (auto &existing : addrCandidates)
          if (existing.val == c.val) { dup = true; break; }
        if (!dup)
          addrCandidates.push_back(c);
      }
      if (isTargetModule && !structAddrCands.empty()) {
        llvm::errs() << "[ADDR_STRUCT] Added " << structAddrCands.size()
                     << " struct-based addr candidates for TLUL-like module\n";
      }
    }

    // 🔴 改进3：适配器/错误层模块检测
    bool isAdapterModule = moduleName.contains("tlul_err") ||
                           moduleName.contains("tlul_adapter") ||
                           moduleName.contains("adapter_reg");

    if (isTargetModule) {
      llvm::errs() << "[DEBUG]   -> Address candidates: " << addrCandidates.size() << "\n";
      llvm::errs() << "[DEBUG]   -> Opcode predicates: " << opcodePredicates.size() << "\n";
      llvm::errs() << "[DEBUG]   -> Is bus-like: " << (isBusLike ? "YES" : "NO") << "\n";
      llvm::errs() << "[DEBUG]   -> Is TLUL-like: " << (isTLULLike ? "YES" : "NO");
      if (isTLULLike) {
        llvm::errs() << " (fields: ";
        if (tlulSig.hasAAddress) llvm::errs() << "a_address ";
        if (tlulSig.hasAData) llvm::errs() << "a_data ";
        if (tlulSig.hasAMask) llvm::errs() << "a_mask ";
        if (tlulSig.hasASource) llvm::errs() << "a_source ";
        llvm::errs() << ")";
      }
      llvm::errs() << "\n";
      llvm::errs() << "[DEBUG]   -> Is adapter module: " << (isAdapterModule ? "YES" : "NO") << "\n";
    }

    SmallVector<BusTxnCandidate, 4> txns;

    for (auto &weCandidate : writeEnables) {
      BusTxnCandidate txn;
      txn.enableCond = weCandidate.cond;
      txn.evidence.registersControlled = weCandidate.regsCovered;
      txn.site = module.getLoc();

      // 匹配地址候选
      // 🔴 改进4：放宽地址验证 - 允许 icmp>=2 但要求 trace 到 a_address
      if (!addrCandidates.empty()) {
        bool foundValidAddr = false;
        for (const auto &addrCand : addrCandidates) {
          // 检查路径中是否包含地址字段标识
          bool hasAddrField = false;
          for (const auto &pathStr : addrCand.pathTrace) {
            if (pathStr.find("a_address") != std::string::npos ||
                pathStr.find("address") != std::string::npos ||
                pathStr.find("addr") != std::string::npos) {
              hasAddrField = true;
              break;
            }
          }

          // 接受条件（优先级递减）：
          // 1. icmp>=3 → 无条件接受（高置信度）
          // 2. icmp>=2 && hasAddrField → 接受（中置信度，但需字段验证）
          // 3. TLUL-like 模块 && hasAddrField → 接受（协议特征明确）
          bool accept = false;
          std::string acceptReason;

          if (addrCand.icmpCount >= 3) {
            accept = true;
            acceptReason = "icmp_count>=3";
          } else if (addrCand.icmpCount >= 2 && hasAddrField) {
            accept = true;
            acceptReason = "icmp>=2_with_addr_field";
          } else if (isTLULLike && hasAddrField) {
            accept = true;
            acceptReason = "tlul_like_with_addr_field";
          }

          if (accept) {
            txn.addrValue = addrCand.val;
            txn.evidence.addrIcmpCount = addrCand.icmpCount;
            txn.evidence.addrSourceKind = addrCand.sourceKind;  // v7
            txn.evidence.paths.addr.assign(addrCand.pathTrace.begin(),
                                            addrCand.pathTrace.end());
            foundValidAddr = true;

            if (isTargetModule) {
              llvm::errs() << "[DEBUG]   -> Accepted addr: " << acceptReason
                           << " (hasAddrField=" << hasAddrField
                           << ", icmpCount=" << addrCand.icmpCount << ")\n";
            }
            break;
          } else if (isTargetModule) {
            llvm::errs() << "[DEBUG]   -> Rejected addr: hasAddrField=" << hasAddrField
                         << ", icmpCount=" << addrCand.icmpCount << " (insufficient)\n";
          }
        }

        if (!foundValidAddr && isTargetModule) {
          llvm::errs() << "[DEBUG]   -> No valid address candidate found\n";
        }
      }

      // 分类 READ/WRITE
      txn.kind = classifyTransaction(module, txn.enableCond, regSigs);

      // 抽取数据路径
      if (txn.kind == BusTxnCandidate::WRITE) {
        llvm::DenseSet<Value> regSigSet(regSigs.begin(), regSigs.end());

        // ====================================================================
        // Stage A: 语义候选收集（协议无关）
        // 从所有受 enableCond 控制的 drv 出发，用专用 BFS 收集 integer 候选
        // ====================================================================
        llvm::DenseMap<Value, WDataTrace> allCandMap;

        module.walk([&](llhd::DriveOp drv) {
          if (!regSigSet.contains(drv.getSignal()))
            return;

          // TLUL-like 模块：放宽约束，收集所有寄存器写入候选
          // 非 TLUL：要求 usesValue（避免收集无关的 reset/init 写）
          bool drvControlledByEnable = usesValue(drv.getValue(), txn.enableCond);
          if (!isTLULLike && !drvControlledByEnable)
            return;

          Value drvValue = drv.getValue();
          Value dataValue = drvValue;

          // 优先取 mux true branch（new data 分支）
          if (auto mux = drvValue.getDefiningOp<comb::MuxOp>()) {
            Value cond = mux.getCond();
            if (txn.enableCond && (cond == txn.enableCond || usesValue(cond, txn.enableCond)))
              dataValue = mux.getTrueValue();
          }

          if (isTargetModule) {
            std::string sigName = "?sig";
            if (auto *sigDef = drv.getSignal().getDefiningOp())
              sigName = sigDef->getName().getStringRef().str();
            llvm::errs() << "[STAGE_A]   drv signal=" << sigName
                         << " enable_controlled=" << drvControlledByEnable
                         << " dataType=";
            dataValue.getType().print(llvm::errs());
            llvm::errs() << "\n";
          }

          auto cands = traceWDataCandidates(dataValue, 14);

          for (auto &c : cands) {
            auto &existing = allCandMap[c.val];
            if (!existing.val) {
              existing = c;
            }
          }
        });

        // Stage A Extra: TLUL-like 模块 → 额外扫描 hw.instance 的 wdata_o 输出
        // uart_reg_top 把 wdata_o 直接传给 prim_subreg_6，不存在 drv 驱动
        // v6: 检查 instance 是否接收含 a_data 的 TLUL struct → 证明依赖关系
        if (isTLULLike) {
          module.walk([&](hw::InstanceOp inst) {
            // (B1) 检查该 instance 的输入中是否有含 "a_data" 字段的 struct 类型
            bool instReceivesTLULStruct = false;
            for (Value operand : inst.getOperands()) {
              auto structType = mlir::dyn_cast<hw::StructType>(operand.getType());
              if (!structType) continue;
              for (auto &field : structType.getElements()) {
                if (field.name.getValue() == "a_data") {
                  instReceivesTLULStruct = true;
                  break;
                }
              }
              if (instReceivesTLULStruct) break;
            }

            // (B2) 查找输出中名为 *wdata* 的 port
            auto resultNames = inst.getResultNames();
            for (unsigned i = 0; i < inst.getNumResults(); ++i) {
              StringRef portNameStr;
              if (i < resultNames.size()) {
                if (auto strAttr = mlir::dyn_cast<StringAttr>(resultNames[i]))
                  portNameStr = strAttr.getValue();
              }
              if (portNameStr.empty()) continue;
              if (portNameStr.contains("wdata") ||
                  portNameStr.contains("wd_o") ||
                  portNameStr.contains("wdata_o")) {
                Value instResult = inst.getResult(i);
                auto cands = traceWDataCandidates(instResult, 14);
                for (auto &c : cands) {
                  if (c.fieldName.empty()) c.fieldName = portNameStr.str();
                  // v6: mark dependsOnAData if instance receives TLUL struct
                  if (instReceivesTLULStruct) {
                    c.dependsOnAData = true;
                    // Annotate path for evidence output
                    if (c.paths.empty())
                      c.paths.push_back("inst_result[" + portNameStr.str() + "]->depends(a_data)");
                  }
                  auto &existing = allCandMap[c.val];
                  if (!existing.val) {
                    existing = c;
                  } else if (c.dependsOnAData && !existing.dependsOnAData) {
                    // Upgrade existing entry if we now have dependency proof
                    existing.dependsOnAData = true;
                    if (existing.paths.empty())
                      existing.paths.push_back("inst_result[" + portNameStr.str() + "]->depends(a_data)");
                  }
                }
                if (isTargetModule) {
                  llvm::errs() << "[STAGE_A_INST] Found wdata port: "
                               << inst.getModuleName() << "." << portNameStr
                               << " instReceivesTLUL=" << instReceivesTLULStruct << "\n";
                }
              }
            }
          });
        }

        // ====================================================================
        // Stage B: TL-UL 语义选择
        // 评分 + 优先 a_data，拒绝 a_mask/a_address/a_opcode
        // ====================================================================

        // ====================================================================
        // Stage B: 评分（写入 c.score，depth 保持真实 BFS 深度不变）
        // ====================================================================
        SmallVector<WDataTrace, 8> sortedCands;
        for (auto &p : allCandMap)
          sortedCands.push_back(p.second);

        for (auto &c : sortedCands) {
          int sc = 0;
          // 位宽权重
          sc += c.width >= 32 ? 100 : (c.width >= 16 ? 50 : 20);
          // 深度权重（depth > 0 说明真正追溯到了字段，而不是直接取 drv.value）
          sc += c.depth * 3;

          // TL-UL 字段加/减分
          if (c.fieldName == "a_data")       sc += 500;  // 直接 a_data：最高优先
          if (c.dependsOnAData)              sc += 400;  // 经实例证明依赖 a_data
          if (c.isBadField())                sc -= 1000; // 强拒绝（协议非数据字段）
          if (c.fieldName == "a_source")     sc -= 100;  // 轻度降权
          if (c.sourceKind == "constant")    sc -= 200;  // 常量降权

          c.score = sc;  // 写入专用 score 字段，depth 不变
        }
        llvm::sort(sortedCands, [&](const WDataTrace &a, const WDataTrace &b) {
          if (a.score != b.score)
            return a.score > b.score;  // score first; the rest is a canonical
          std::string an = deriveSignalName(module, a.val, "wdata", 0);
          std::string bn = deriveSignalName(module, b.val, "wdata", 0);
          if (an != bn)
            return an < bn;
          if (a.fieldName != b.fieldName)
            return a.fieldName < b.fieldName;
          if (a.sourceKind != b.sourceKind)
            return a.sourceKind < b.sourceKind;
          return programOrderKey(module, a.val) < programOrderKey(module, b.val);
        });

        if (isTargetModule) {
          llvm::errs() << "[STAGE_B]   Total candidates: " << sortedCands.size() << "\n";
          for (size_t i = 0; i < sortedCands.size() && i < 6; ++i) {
            auto &c = sortedCands[i];
            llvm::errs() << "[STAGE_B]     [" << i << "] field=" << c.fieldName
                         << " source=" << c.sourceKind
                         << " width=" << c.width
                         << " depth=" << c.depth   // true BFS depth
                         << " score=" << c.score   // Stage B score
                         << " dep_a_data=" << c.dependsOnAData
                         << " paths=[";
            for (auto &p : c.paths) llvm::errs() << p << ";";
            llvm::errs() << "]\n";
          }
        }

        // Stage B 选择：
        // (B1) 若 TLUL-like 且有 a_data 候选，强制选 a_data
        // (B2) 否则选得分最高的非坏字段候选
        WDataTrace *chosen = nullptr;

        if (isTLULLike && tlulSig.hasAData) {
          // 寻找 a_data 候选
          for (auto &c : sortedCands) {
            if (c.fieldName == "a_data") {
              chosen = &c;
              break;
            }
          }
          if (!chosen) {
            // TLUL 有 a_data 字段但 trace 没命中 → fallback
            txn.weak = true;
            txn.evidence.reason = "tlul_like_missing_a_data_fallback";
            // 记录 top3 唯一候选到 wdata_alt（供调试，去重）
            for (size_t i = 0; i < sortedCands.size() && txn.evidence.wdataAlt.size() < 3; ++i) {
              auto &c = sortedCands[i];
              std::string alt = c.fieldName.empty() ? c.sourceKind : "struct_extract[" + c.fieldName + "]";
              if (!c.paths.empty()) alt += "+" + c.paths[0];
              // 去重
              bool dup = false;
              for (auto &existing : txn.evidence.wdataAlt)
                if (existing == alt) { dup = true; break; }
              if (!dup)
                txn.evidence.wdataAlt.push_back(alt);
            }
            // 在没有 a_data 的情况下，尝试选最好的非坏字段候选
            for (auto &c : sortedCands) {
              if (!c.isBadField() && c.sourceKind != "constant") {
                chosen = &c;
                break;
              }
            }
            if (isTargetModule) {
              llvm::errs() << "[STAGE_B] WARN: TLUL-like but no a_data trace found! Using fallback.\n";
            }
          }
        } else {
          // 非 TLUL-like：选最好的非坏字段候选
          for (auto &c : sortedCands) {
            if (!c.isBadField()) {
              chosen = &c;
              break;
            }
          }
        }

        // 注意：如果 chosen 仍然是 nullptr（全部拒绝），has_wdata=false

        if (chosen) {
          txn.wdataValue = chosen->val;
          txn.evidence.wdataPathDepth = chosen->depth;  // v6: 真实 BFS 深度
          txn.evidence.wdataScore = chosen->score;       // v6: Stage B 评分
          txn.evidence.wdataSourceKind = chosen->sourceKind;

          // v6: 设置 TL-UL anchor 状态（dependsOnAData 优先于 isAData 以避免路径字符串误判）
          if (chosen->dependsOnAData && chosen->fieldName != "a_data") {
            // 经实例证明依赖 a_data（uart_reg_top -> tlul_adapter_reg.wdata_o 情形）
            txn.wdataAnchoredToTLUL = true;
            txn.evidence.wdataAnchorKind = "instance_tlul_wdata_o";
          } else if (chosen->isAData() || chosen->dependsOnAData) {
            // 直接 struct_extract[a_data] 或 fieldName == a_data
            txn.wdataAnchoredToTLUL = true;
            txn.evidence.wdataAnchorKind = "direct_a_data";
          } else if (isTLULLike) {
            txn.wdataAnchoredToTLUL = false;
            txn.evidence.wdataAnchorKind = "unanchored";
          }

          // 构建 evidence_paths.wdata
          // 优先级：dependsOnAData 路径 > fieldName > paths > sourceKind fallback
          if (chosen->dependsOnAData && !chosen->paths.empty()) {
            // 特殊路径：inst_result[wdata_o]->depends(a_data)
            for (auto &p : chosen->paths)
              txn.evidence.paths.wdata.push_back(p);
          } else if (!chosen->fieldName.empty()) {
            txn.evidence.paths.wdata.push_back("struct_extract[" + chosen->fieldName + "]");
          } else if (!chosen->paths.empty()) {
            for (auto &p : chosen->paths)
              txn.evidence.paths.wdata.push_back(p);
          } else if (chosen->sourceKind == "constant") {
            std::string constStr = "constant";
            if (auto constOp = chosen->val.getDefiningOp<hw::ConstantOp>()) {
              llvm::SmallString<32> buf;
              constOp.getValue().toString(buf, 16, false);
              constStr = "constant(0x" + std::string(buf.begin(), buf.end()) + ")";
            }
            txn.evidence.paths.wdata.push_back(constStr);
          } else if (chosen->sourceKind == "port_arg") {
            if (auto blockArg = mlir::dyn_cast<BlockArgument>(chosen->val)) {
              txn.evidence.paths.wdata.push_back(
                "port_arg[%" + std::to_string(blockArg.getArgNumber()) + "]");
            } else {
              txn.evidence.paths.wdata.push_back("port_arg");
            }
          } else {
            // Fallback: show source+kind+depth+score for debuggability
            txn.evidence.paths.wdata.push_back(
              chosen->sourceKind + "(depth=" + std::to_string(chosen->depth) +
              ",score=" + std::to_string(chosen->score) + ")");
          }

          if (isTargetModule) {
            llvm::errs() << "[STAGE_B] Selected wdata: field=" << chosen->fieldName
                         << " source=" << chosen->sourceKind
                         << " width=" << chosen->width
                         << " depth=" << chosen->depth
                         << " score=" << chosen->score
                         << " dep_a_data=" << chosen->dependsOnAData
                         << " paths=[";
            for (auto &p : txn.evidence.paths.wdata) llvm::errs() << p << ";";
            llvm::errs() << "]\n";
          }

          // debug_snippet
          {
            std::string snip = "wdata: " + txn.evidence.wdataAnchorKind +
              " src=" + chosen->sourceKind +
              " depth=" + std::to_string(chosen->depth) +
              " score=" + std::to_string(chosen->score);
            if (!chosen->fieldName.empty()) snip += " field=" + chosen->fieldName;
            txn.evidence.debugSnippet.push_back(snip);
          }
        } else if (isTargetModule) {
          llvm::errs() << "[STAGE_B] No valid wdata candidate found\n";
        }

        txn.maskValue = extractMask(module, txn.wdataValue);
        if (txn.maskValue) {
          TraceResult maskTrace = traceToBestInput(txn.maskValue, 5);
          txn.evidence.paths.mask.assign(maskTrace.pathTrace.begin(), maskTrace.pathTrace.end());
        }

        // FIX Bug 2: 恢复 rdata 反向追踪 — WRITE 事务也可能有读回路径
        // 从 hw.module 输出端（如 d_data）反向 BFS 查找受地址/使能控制的数据路径
        {
          SmallVector<std::string, 4> rdataPaths;
          int rdataDepth = 0;
          Value rdata = extractRData(module, txn.enableCond, txn.addrValue,
                                     &rdataPaths, &rdataDepth);
          if (rdata) {
            txn.rdataValue = rdata;
            txn.evidence.rdataPathDepth = rdataDepth;
            txn.evidence.paths.rdata.assign(rdataPaths.begin(), rdataPaths.end());
            if (isTargetModule) {
              llvm::errs() << "[RDATA] Found rdata for WRITE txn: depth="
                           << rdataDepth << " paths=[";
              for (auto &p : rdataPaths) llvm::errs() << p << ";";
              llvm::errs() << "]\n";
            }
          }
        }

        txn.evidence.reason = "Register writes controlled by enable condition";

      } else if (txn.kind == BusTxnCandidate::READ) {
        // FIX Bug 2: 恢复 READ 分支的 rdata 提取
        // 从输出端口反向追踪，找到受 enableCond/addrValue 控制的读数据路径
        {
          SmallVector<std::string, 4> rdataPaths;
          int rdataDepth = 0;
          Value rdata = extractRData(module, txn.enableCond, txn.addrValue,
                                     &rdataPaths, &rdataDepth);
          if (rdata) {
            txn.rdataValue = rdata;
            txn.evidence.rdataPathDepth = rdataDepth;
            txn.evidence.paths.rdata.assign(rdataPaths.begin(), rdataPaths.end());
            if (isTargetModule) {
              llvm::errs() << "[RDATA] Found rdata for READ txn: depth="
                           << rdataDepth << " paths=[";
              for (auto &p : rdataPaths) llvm::errs() << p << ";";
              llvm::errs() << "]\n";
            }
          }
        }

        txn.evidence.reason = "Output path updates controlled by enable condition";

      } else {
        // UNKNOWN 分支：尝试提取 wdata
        txn.wdataValue = extractWData(module, txn.enableCond, regSigs);

        if (txn.wdataValue) {
          TraceResult trace = traceToBestInput(txn.wdataValue);
          txn.evidence.wdataPathDepth = trace.depth;
          txn.evidence.paths.wdata.assign(trace.pathTrace.begin(), trace.pathTrace.end());
        }

        txn.evidence.reason = "Unable to determine READ/WRITE definitively";
      }

      // 关联 opcode predicate
      if (txn.enableCond) {
        for (const auto &pred : opcodePredicates) {
          if (usesValue(txn.enableCond, pred.icmpResult)) {
            txn.evidence.paths.opcode.assign(pred.pathTrace.begin(), pred.pathTrace.end());
            // Stage A — also capture the SSA value so writeAttributesToIR
            // can derive a real signal name for qemu.protocol_constraints.
            txn.opcodeValue = pred.opcodeOperand;
            break;
          }
        }
      }

      // 计算置信度
      txn.confidence = computeConfidence(txn);

      // (1) BUS_WRITE vs INTERNAL_WRITE 分类（v6 更严格）
      {
        bool isConstantWdata = (txn.evidence.wdataSourceKind == "constant");

        if (txn.wdataValue && isConstantWdata && !txn.addrValue) {
          // 常量写 + 无地址 → INTERNAL_WRITE（复位写/初始化写）
          txn.isInternalWrite = true;
          txn.weak = true;
          if (txn.evidence.reason.empty())
            txn.evidence.reason = "internal_constant_write";

        } else if (txn.enableCond && txn.wdataValue && !isConstantWdata) {
          if (isTLULLike) {
            // v7: 若 Stage A/B 未标记 anchor，尝试 dependsOnTLULField() 作为补充验证
            if (!txn.wdataAnchoredToTLUL && txn.wdataValue &&
                dependsOnTLULField(txn.wdataValue, "a_data")) {
              txn.wdataAnchoredToTLUL = true;
              txn.evidence.wdataAnchorKind = "direct_a_data";
              if (isTargetModule)
                llvm::errs() << "[BUS_WRITE] dependsOnTLULField: upgraded wdata anchor to direct_a_data\n";
            }

            // v6: TLUL-like 模块 BUS_WRITE 的必要条件：
            //   wdata 必须有 anchor（direct_a_data 或 instance_tlul_wdata_o）
            // 仅有 addr（icmp 计数）不够：addr 可来自协议内部地址比较
            if (txn.wdataAnchoredToTLUL) {
              txn.isBusLike = true;
            } else {
              // wdata 是 computed 但无法证明来自 a_data → 不算 BUS_WRITE
              txn.isBusLike = false;
              txn.weak = true;
              if (txn.evidence.reason.empty() ||
                  txn.evidence.reason.find("tlul") != std::string::npos)
                txn.evidence.reason = "wdata_unanchored_no_adata_proof";
            }
          } else {
            // 非 TLUL-like：有 addr → BUS_WRITE
            if (txn.addrValue) {
              txn.isBusLike = true;
            }
          }
        }
      }

      // (5) 适配器模块弱化
      if (isAdapterModule) {
        txn.weak = true;
        if (isTargetModule) {
          llvm::errs() << "[DEBUG]   -> Adapter module: marked as weak\n";
        }
      }

      // 过滤逻辑：先检查强制拒绝条件（去噪）
      bool shouldInclude = false;
      std::string filterReason;

      // === 强制拒绝规则（优先级最高，去除内部模块噪声）===

      // 拒绝 -1：INTERNAL_WRITE（常量写 + 无地址）默认过滤（保守模式）
      // 如需输出 INTERNAL_WRITE，可将此规则注释掉
      if (txn.isInternalWrite && !txn.addrValue) {
        shouldInclude = false;
        filterReason = "internal_constant_write_filtered";
      }
      // 拒绝 0：适配器模块无特征（减少总线内部状态干扰）
      else if (isAdapterModule &&
               !txn.addrValue &&
               !txn.wdataValue &&
               !txn.rdataValue) {
        shouldInclude = false;
        filterReason = "adapter_module_no_features";
      }
      // 拒绝 0b：tlul_adapter 系列模块 → 总线内部协议桥接，不是 MMIO entry point
      // v7: 不再要求 !txn.addrValue，struct_field addr 也不代表是 MMIO entry point
      else if ((moduleName.contains("tlul_adapter") || moduleName.contains("adapter_reg")) && isTLULLike) {
        shouldInclude = false;
        filterReason = "tlul_adapter_filtered";
      }
      // 拒绝 1：完全无特征的内部模块（典型：prim_intr_hw*, uart_rx）
      else if (txn.evidence.registersControlled <= 1 &&
               txn.evidence.addrIcmpCount == 0 &&
               !txn.wdataValue &&
               !txn.rdataValue) {
        shouldInclude = false;
        filterReason = "no_features_internal_module";
      }
      // 拒绝 2：单寄存器 + 无地址 + 无数据路径（非 bus-like）
      else if (!isBusLike &&
               txn.evidence.registersControlled == 1 &&
               txn.evidence.addrIcmpCount == 0 &&
               txn.evidence.paths.isEmpty()) {
        shouldInclude = false;
        filterReason = "strong_reject_low_quality";
      }
      // 拒绝 3：confidence 过低且无关键特征
      else if (txn.confidence < 0.15 &&
               !txn.addrValue &&
               !txn.wdataValue &&
               !txn.rdataValue) {
        shouldInclude = false;
        filterReason = "confidence_too_low";
      }

      // === 正常过滤规则（在未被强制拒绝的情况下）===
      else {
        // 高质量：有地址且有数据
        if (txn.addrValue && (txn.wdataValue || txn.rdataValue)) {
          shouldInclude = true;
          filterReason = "has_addr_and_data";
        }
        // 中高质量：有地址且 confidence 足够
        else if (txn.addrValue && txn.confidence >= 0.35) {
          shouldInclude = true;
          filterReason = "has_addr_high_confidence";
        }
        // Bus-like module: 放宽条件
        else if (isBusLike) {
          if ((txn.wdataValue || txn.rdataValue) && txn.confidence >= 0.25) {
            shouldInclude = true;
            txn.weak = true;  // 标记为弱候选
            filterReason = "buslike_has_data";
          } else if (!txn.evidence.paths.isEmpty() && txn.confidence >= 0.2) {
            shouldInclude = true;
            txn.weak = true;
            filterReason = "buslike_has_paths";
          } else {
            filterReason = "buslike_but_low_quality";
          }
        }
        // 中等质量：有数据且有 evidence paths
        else if ((txn.wdataValue || txn.rdataValue) &&
                 !txn.evidence.paths.isEmpty() &&
                 txn.confidence >= 0.3) {
          shouldInclude = true;
          filterReason = "medium_quality";
        } else {
          filterReason = "no_matching_criteria";
        }
      }

      if (isTargetModule) {
        llvm::errs() << "[DEBUG]   -> Transaction candidate:\n";
        llvm::errs() << "[DEBUG]       - Kind: " << (txn.kind == BusTxnCandidate::WRITE ? "WRITE" :
                                                     txn.kind == BusTxnCandidate::READ ? "READ" : "UNKNOWN") << "\n";
        llvm::errs() << "[DEBUG]       - Confidence: " << txn.confidence << "\n";
        llvm::errs() << "[DEBUG]       - Has addr: " << (txn.addrValue ? "yes" : "no") << "\n";
        llvm::errs() << "[DEBUG]       - Has wdata: " << (txn.wdataValue ? "yes" : "no") << "\n";
        llvm::errs() << "[DEBUG]       - Has rdata: " << (txn.rdataValue ? "yes" : "no") << "\n";
        llvm::errs() << "[DEBUG]       - Regs controlled: " << txn.evidence.registersControlled << "\n";
        llvm::errs() << "[DEBUG]       - Addr icmp count: " << txn.evidence.addrIcmpCount << "\n";
        llvm::errs() << "[DEBUG]       - Paths empty: " << (txn.evidence.paths.isEmpty() ? "yes" : "no") << "\n";
        llvm::errs() << "[DEBUG]       - Filter decision: " << (shouldInclude ? "INCLUDE" : "REJECT") << "\n";
        llvm::errs() << "[DEBUG]       - Filter reason: " << filterReason << "\n";
      }

      if (shouldInclude) {
        txns.push_back(txn);
      }
    }

    if (!txns.empty()) {
      // v7: 去重 — 计算签名并过滤完全相同的候选（消除 tlul_err 双 TXN 等问题）
      SmallVector<BusTxnCandidate, 4> dedupedTxns;
      std::set<std::string> sigSet;
      for (auto &txn : txns) {
        // 签名 = kind + addrIcmpCount + wdataAnchorKind + wdataSourceKind + paths
        std::string sig;
        sig += std::to_string((int)txn.kind);
        sig += "_ic" + std::to_string(txn.evidence.addrIcmpCount);
        sig += "_ak" + txn.evidence.wdataAnchorKind;
        sig += "_sk" + txn.evidence.wdataSourceKind;
        sig += "_rc" + std::to_string(txn.evidence.registersControlled);
        for (auto &p : txn.evidence.paths.wdata) sig += "_w" + p;
        for (auto &p : txn.evidence.paths.addr)  sig += "_a" + p;
        txn.signature = sig;

        if (!sigSet.count(sig)) {
          sigSet.insert(sig);
          dedupedTxns.push_back(txn);
        } else if (isTargetModule) {
          llvm::errs() << "[DEDUP] Removed duplicate txn with sig: " << sig << "\n";
        }
      }
      txns = std::move(dedupedTxns);

      moduleTxns[module] = std::move(txns);
      writeAttributesToIR(module, moduleTxns[module]);
    }
  }

  //==========================================================================
  // IR Attribute Output (Protocol-Decoupled)
  //
  // Key design: We extract SANITIZED signal names from the SSA Values
  // (addrValue, wdataValue, rdataValue) and embed them as StringAttr in the
  // DictionaryAttr.  This allows Phase 2 (QEMUEmitCPass) to directly map
  // QEMU's hwaddr/value onto the correct flattened state-struct fields,
  // WITHOUT knowing whether the original bus protocol was TL-UL, APB, or AXI.
  //
  // The signal name derivation follows this priority:
  //   1. If Value comes from hw::StructExtractOp -> use "<port>_<field>"
  //   2. If Value is a BlockArgument -> use the hw.module port name
  //   3. If Value comes from llhd::SignalOp -> use its IR name
  //   4. Fallback: "unnamed_<role>_<idx>"
  //
  // All names are sanitized to valid C identifiers (dots/brackets -> '_').
  //==========================================================================

  /// Sanitize a raw name to a valid C identifier (same convention as
  /// QEMUEmitCPass::sanitizeName).  This ensures Phase 1 and Phase 2 agree
  /// on the same flattened name string.
  static std::string sanitizeForC(llvm::StringRef raw) {
    std::string result = raw.str();
    for (char &c : result) {
      if (c == '.' || c == '[' || c == ']' || c == '-' ||
          c == ' ' || c == ':')
        c = '_';
    }
    if (!result.empty() &&
        std::isdigit(static_cast<unsigned char>(result[0])))
      result = "_" + result;
    return result;
  }

  /// Clamp a synthesised composite name to a reasonable C-identifier length.
  /// When the original would exceed `maxLen`, keep a leading prefix and
  /// append a short hash so structurally distinct expressions don't collide
  /// Canonical total order on IR values: block-arg number, else the
  /// operation's index in a module walk.  Used ONLY to break ties between
  /// candidates that score equally and whose derived names also tie, so the
  /// emitted artifact is identical whichever one wins.  Without it, four of
  /// the sorts below are seeded by DenseMap<Value,...> iteration (pointer
  /// order), which made the SAME BINARY on the SAME INPUT emit different C
  /// between runs — measured: three distinct lc_ctrl.c in six runs.
  size_t programOrderKey(hw::HWModuleOp module, Value v) {
    if (!v)
      return 0;
    if (auto arg = mlir::dyn_cast<BlockArgument>(v))
      return arg.getArgNumber();
    Operation *def = v.getDefiningOp();
    if (!def)
      return 0;
    if (poCacheModule != module.getOperation()) {
      poCacheModule = module.getOperation();
      poCache.clear();
      size_t i = 0;
      module.walk([&](Operation *op) { poCache[op] = ++i; });
    }
    auto it = poCache.find(def);
    size_t base = (it == poCache.end()) ? 0 : it->second;
    return base * 64 + mlir::cast<OpResult>(v).getResultNumber() + (1u << 20);
  }
  Operation *poCacheModule = nullptr;
  DenseMap<Operation *, size_t> poCache;

  /// after truncation.  Used by Item 1's comb-op handlers in deriveSignalName.
  static std::string clampNameLen(std::string s, size_t maxLen = 64) {
    if (s.size() <= maxLen)
      return s;
    // 8-hex-digit hash of the full name keeps post-truncation collisions
    // astronomically unlikely (2^-32 per pair).
    std::hash<std::string> hasher;
    size_t h = hasher(s);
    char buf[16];
    std::snprintf(buf, sizeof(buf), "_%08x", static_cast<unsigned>(h & 0xFFFFFFFF));
    // Reserve room for the hash suffix.
    size_t prefixLen = (maxLen > 9) ? (maxLen - 9) : (maxLen / 2);
    std::string truncated = s.substr(0, prefixLen);
    truncated += buf;
    return truncated;
  }

  /// Derive a human-readable, C-safe signal name from an SSA Value.
  /// This is the core of the protocol-decoupling: no matter what bus
  /// struct the Value was extracted from, we produce a flat name.
  std::string deriveSignalName(hw::HWModuleOp module, Value val,
                               StringRef role, int idx) {
    if (!val)
      return "";

    // --- Priority 1: hw::StructExtractOp ---
    // e.g.  %addr = hw.struct_extract %tl_i["a_address"]
    //       -> "tl_i_a_address"
    // This naturally flattens the struct layer.
    if (Operation *defOp = val.getDefiningOp()) {
      if (auto se = dyn_cast<hw::StructExtractOp>(defOp)) {
        std::string fieldName = se.getFieldNameAttr().getValue().str();
        // Try to get the struct source name
        Value structSrc = se.getInput();
        std::string prefix = deriveSignalName(module, structSrc, role, idx);
        if (!prefix.empty())
          return sanitizeForC(prefix + "_" + fieldName);
        return sanitizeForC(fieldName);
      }

      // --- Priority 2b: llhd::ProbeOp -> follow to underlying signal ---
      if (auto prb = dyn_cast<llhd::ProbeOp>(defOp)) {
        return deriveSignalName(module, prb.getSignal(), role, idx);
      }

      // --- Priority 2c: llhd::SignalOp -> use IR signal name ---
      if (auto sigOp = dyn_cast<llhd::SignalOp>(defOp)) {
        if (auto nameAttr = sigOp.getName()) {
          return sanitizeForC(nameAttr->str());
        }
      }

      // --- Priority 2.5: comb.icmp / comb.and / comb.or / comb.xor result ---
      // Item 1: synthesise a readable composite name from operand names.
      // Examples:
      //   comb.icmp eq %a_opcode, 4  -> "a_opcode_eq_4"
      //   comb.and  %a_valid, %a_ready -> "a_valid_and_a_ready"
      // Long expressions are clamped to keep state-struct field names
      // bounded; clampNameLen appends a short hash when truncating so
      // structurally distinct expressions don't collide.
      if (auto icmp = dyn_cast<comb::ICmpOp>(defOp)) {
        std::string lhs = deriveSignalName(module, icmp.getLhs(), role, idx);
        std::string rhs;
        if (auto c = icmp.getRhs().getDefiningOp<hw::ConstantOp>()) {
          rhs = std::to_string(c.getValue().getZExtValue());
        } else {
          rhs = deriveSignalName(module, icmp.getRhs(), role, idx);
        }
        StringRef predName = comb::stringifyICmpPredicate(icmp.getPredicate());
        return clampNameLen(sanitizeForC(lhs + "_" + predName.str() + "_" + rhs));
      }
      auto joinOperandNames = [&](Operation *op, StringRef sep) -> std::string {
        std::string acc;
        for (unsigned i = 0; i < op->getNumOperands(); ++i) {
          std::string nm = deriveSignalName(module, op->getOperand(i), role, idx);
          if (i > 0) acc += sep.str();
          acc += nm;
        }
        return sanitizeForC(acc);
      };
      if (auto andOp = dyn_cast<comb::AndOp>(defOp))
        return clampNameLen(joinOperandNames(andOp, "_and_"));
      if (auto orOp = dyn_cast<comb::OrOp>(defOp))
        return clampNameLen(joinOperandNames(orOp, "_or_"));
      if (auto xorOp = dyn_cast<comb::XorOp>(defOp))
        return clampNameLen(joinOperandNames(xorOp, "_xor_"));

      // --- Priority 2d: hw::InstanceOp result -> "<inst_name>_<output_port_name>" ---
      // Bug A fix: when a trace BFS lands on an instance result (an output
      // port of a sub-instance), neither sig name nor struct_extract source
      // is available, so we previously fell through to the "unnamed_<role>_<idx>"
      // fallback.  Use the syntactic instance.port path instead — this gives
      // emit-c a real, addressable state-field name like "u_reg_if_wdata_o".
      if (auto inst = dyn_cast<hw::InstanceOp>(defOp)) {
        if (auto opResult = mlir::dyn_cast<mlir::OpResult>(val)) {
          unsigned resIdx = opResult.getResultNumber();
          auto resultNames = inst.getResultNames();
          if (resIdx < resultNames.size()) {
            if (auto strAttr = mlir::dyn_cast<StringAttr>(resultNames[resIdx])) {
              std::string instName = inst.getInstanceName().str();
              std::string portName = strAttr.getValue().str();
              if (!instName.empty() && !portName.empty())
                return sanitizeForC(instName + "_" + portName);
            }
          }
        }
      }
    }

    // --- Priority 2: BlockArgument -> hw.module port name ---
    if (auto arg = mlir::dyn_cast<BlockArgument>(val)) {
      auto portList = module.getPortList();
      unsigned argIdx = arg.getArgNumber();
      std::string baseName;
      if (argIdx < portList.size()) {
        baseName = sanitizeForC(portList[argIdx].getName());
      } else {
        baseName = sanitizeForC("port_" + std::to_string(argIdx));
      }

      // FIX Bug 1: 修复结构体覆盖陷阱 — 当 Value 是 struct 类型的端口时，
      // 根据 role 自动追加正确的字段名，防止生成 s->tl_i = (uint32_t)addr
      // 这样的代码，用标量覆盖整个协议结构体。
      // 例如：role="addr" + struct{a_address,...} → "tl_i_a_address"
      if (auto structType = mlir::dyn_cast<hw::StructType>(arg.getType())) {
        // Role → 候选字段名映射（按优先级排列，兼容 TL-UL / APB / AXI）
        SmallVector<StringRef, 5> targetFields;
        if (role == "addr")
          targetFields = {"a_address", "address", "addr", "paddr", "reg_addr"};
        else if (role == "wdata")
          targetFields = {"a_data", "wdata", "pwdata", "data"};
        else if (role == "rdata")
          targetFields = {"d_data", "rdata", "prdata"};
        else if (role == "mask")
          targetFields = {"a_mask", "mask", "strb", "pstrb"};

        for (auto &targetField : targetFields) {
          for (auto &field : structType.getElements()) {
            if (field.name.getValue() == targetField) {
              return sanitizeForC(baseName + "_" + targetField.str());
            }
          }
        }
      }

      return baseName;
    }

    // --- Priority 3: fallback ---
    return sanitizeForC("unnamed_" + role.str() + "_" + std::to_string(idx));
  }

  /// Determine the bit width of a Value (returns 0 if not integer).
  /// FIX: For struct-typed values used as addr/wdata, try to find the
  /// relevant field width (e.g., a_address is 32-bit inside tl_i struct).
  static unsigned getValueBitWidth(Value val) {
    if (!val) return 0;
    if (auto intTy = mlir::dyn_cast<IntegerType>(val.getType()))
      return intTy.getWidth();
    // For struct types: return 32 as typical bus address/data width
    // (the struct itself is wider, but the generated C code uses
    //  the individual field, not the whole struct)
    if (mlir::isa<hw::StructType>(val.getType()))
      return 32;
    // Handle !hw.inout<iN> from llhd.sig
    if (auto inoutTy = mlir::dyn_cast<llhd::RefType>(val.getType()))
      if (auto innerInt = mlir::dyn_cast<IntegerType>(inoutTy.getNestedType()))
        return innerInt.getWidth();
    return 0;
  }

  void writeAttributesToIR(hw::HWModuleOp module, ArrayRef<BusTxnCandidate> txns) {
    // Declaration overrides derivation.  BusProfileLoadPass has already
    // materialised an emitter-compatible mapping for this module; inferred
    // candidates may still be collected for diagnostics, but must not replace
    // the user's explicit bus contract.
    if (module->hasAttr("qemu.bus_profile_declared")) {
      llvm::errs() << "[FBTI] Preserving declared bus profile on @"
                   << module.getName() << "\n";
      return;
    }
    auto *ctx = module.getContext();
    SmallVector<Attribute> txnAttrs;

    for (int idx = 0; idx < (int)txns.size(); ++idx) {
      const auto &txn = txns[idx];
      SmallVector<NamedAttribute> fields;

      // ---- Basic metadata (same as before) ----
      fields.push_back(NamedAttribute(
        StringAttr::get(ctx, "kind"),
        StringAttr::get(ctx, txn.kind == BusTxnCandidate::READ ? "READ" :
                              txn.kind == BusTxnCandidate::WRITE ? "WRITE" : "UNKNOWN")));
      fields.push_back(NamedAttribute(
        StringAttr::get(ctx, "confidence"),
        FloatAttr::get(Float64Type::get(ctx), txn.confidence)));
      fields.push_back(NamedAttribute(
        StringAttr::get(ctx, "weak"),
        BoolAttr::get(ctx, txn.weak)));
      fields.push_back(NamedAttribute(
        StringAttr::get(ctx, "is_bus_write"),
        BoolAttr::get(ctx, txn.isBusLike)));
      fields.push_back(NamedAttribute(
        StringAttr::get(ctx, "registers_controlled"),
        IntegerAttr::get(IntegerType::get(ctx, 64), txn.evidence.registersControlled)));
      fields.push_back(NamedAttribute(
        StringAttr::get(ctx, "addr_icmp_count"),
        IntegerAttr::get(IntegerType::get(ctx, 64), txn.evidence.addrIcmpCount)));

      // ---- NEW: Protocol-decoupled signal name bindings ----
      // These StringAttr entries are the bridge between Phase 1 analysis
      // and Phase 2 code generation.  Phase 2 reads these to know which
      // flattened state-struct fields correspond to addr/wdata/rdata,
      // making the generated QEMU code completely bus-protocol agnostic.

      if (txn.addrValue) {
        std::string addrName = deriveSignalName(module, txn.addrValue, "addr", idx);
        fields.push_back(NamedAttribute(
          StringAttr::get(ctx, "addr_signal"),
          StringAttr::get(ctx, addrName)));
        // Also record addr bit width for MMIO sizing
        unsigned addrWidth = getValueBitWidth(txn.addrValue);
        if (addrWidth > 0)
          fields.push_back(NamedAttribute(
            StringAttr::get(ctx, "addr_width"),
            IntegerAttr::get(IntegerType::get(ctx, 64), addrWidth)));
      }

      if (txn.wdataValue) {
        std::string wdataName = deriveSignalName(module, txn.wdataValue, "wdata", idx);
        // Sanity check: if wdata and rdata derived to the same name, the
        // emit-c output would write and read the same state field — wrong
        // semantically.  This shouldn't happen after Bug B's fix, but if
        // some unexpected RTL shape slips through, rename wdata to a
        // disambiguated form so emit-c still produces distinct fields.
        if (txn.rdataValue) {
          std::string rdataNameCheck = deriveSignalName(module, txn.rdataValue, "rdata", idx);
          if (!wdataName.empty() && wdataName == rdataNameCheck) {
            llvm::errs() << "[FBTI WARN] wdata_signal == rdata_signal == '"
                         << wdataName << "' in module @" << module.getName()
                         << "; renaming wdata to '" << wdataName << "_wdata' "
                            "to avoid emit-c collision\n";
            wdataName = wdataName + "_wdata";
          }
        }
        fields.push_back(NamedAttribute(
          StringAttr::get(ctx, "wdata_signal"),
          StringAttr::get(ctx, wdataName)));
        unsigned wdataWidth = getValueBitWidth(txn.wdataValue);
        if (wdataWidth > 0)
          fields.push_back(NamedAttribute(
            StringAttr::get(ctx, "wdata_width"),
            IntegerAttr::get(IntegerType::get(ctx, 64), wdataWidth)));
      }

      if (txn.rdataValue) {
        std::string rdataName = deriveSignalName(module, txn.rdataValue, "rdata", idx);
        fields.push_back(NamedAttribute(
          StringAttr::get(ctx, "rdata_signal"),
          StringAttr::get(ctx, rdataName)));
        unsigned rdataWidth = getValueBitWidth(txn.rdataValue);
        if (rdataWidth > 0)
          fields.push_back(NamedAttribute(
            StringAttr::get(ctx, "rdata_width"),
            IntegerAttr::get(IntegerType::get(ctx, 64), rdataWidth)));
      }

      if (txn.enableCond) {
        std::string enableName = deriveSignalName(module, txn.enableCond, "enable", idx);
        fields.push_back(NamedAttribute(
          StringAttr::get(ctx, "enable_signal"),
          StringAttr::get(ctx, enableName)));
      }

      if (txn.maskValue) {
        std::string maskName = deriveSignalName(module, txn.maskValue, "mask", idx);
        fields.push_back(NamedAttribute(
          StringAttr::get(ctx, "mask_signal"),
          StringAttr::get(ctx, maskName)));
      }

      // Optional: txn_id for cross-referencing with JSON debug output
      if (!txn.signature.empty()) {
        fields.push_back(NamedAttribute(
          StringAttr::get(ctx, "txn_id"),
          StringAttr::get(ctx, txn.signature)));
      }

      auto dict = DictionaryAttr::get(ctx, fields);
      txnAttrs.push_back(dict);
    }

    module->setAttr("qemu.functional_txns", ArrayAttr::get(ctx, txnAttrs));

    // -----------------------------------------------------------------
    // Stage A — feed ForwardConstrain's auto-discover.
    //
    // For every txn whose inference captured an opcode SSA value or a
    // mask SSA value, derive a real signal name (via the same
    // deriveSignalName helper used for addr/wdata/rdata above) and
    // union them into a per-module qemu.protocol_constraints attribute.
    // ForwardConstrain reads this list as the bus-noise signals to
    // constant-fold for sensitization-based DCE.
    //
    // We strictly include opcode + mask only — NOT enable/addr/wdata/rdata.
    // Those are the main data path; folding them away would destroy
    // semantics.  opcode (Get/Put encoding) and mask (byte enable) are
    // the protocol-noise signals that take a fixed value during a
    // normal MMIO sensitization.
    //
    // If TLULControlInferencePass (running earlier in the pipeline) has
    // already attached its own qemu.protocol_constraints with TL-UL-aware
    // names, we MERGE rather than overwrite.  Both sets are safe to union.
    {
      llvm::SmallVector<Attribute, 16> noiseAttrs;
      llvm::StringSet<> seen;

      // Pre-seed with anything TLUL (or any earlier pass) already wrote.
      if (auto existing =
              module->getAttrOfType<ArrayAttr>("qemu.protocol_constraints")) {
        for (Attribute a : existing) {
          if (auto s = dyn_cast<StringAttr>(a)) {
            auto v = s.getValue();
            if (!v.empty() && seen.insert(v).second)
              noiseAttrs.push_back(s);
          }
        }
      }

      auto addName = [&](const std::string &name) {
        if (name.empty())
          return;
        if (seen.insert(name).second)
          noiseAttrs.push_back(StringAttr::get(ctx, name));
      };

      for (int idx = 0; idx < (int)txns.size(); ++idx) {
        const auto &txn = txns[idx];
        if (txn.opcodeValue)
          addName(deriveSignalName(module, txn.opcodeValue, "opcode", idx));
        if (txn.maskValue)
          addName(deriveSignalName(module, txn.maskValue, "mask", idx));
      }

      if (!noiseAttrs.empty()) {
        module->setAttr("qemu.protocol_constraints",
                        ArrayAttr::get(ctx, noiseAttrs));
      }
    }
  }

  //==========================================================================
  // Results Output
  //==========================================================================

  void dumpResults() {
    llvm::errs() << "\n========================================\n";
    llvm::errs() << "Functional Bus Transaction Inference\n";
    llvm::errs() << "========================================\n\n";

    int totalCandidates = 0;
    int weakCandidates = 0;
    llvm::json::Array modulesArray;

    for (auto &pair : moduleTxns) {
      auto module = dyn_cast<hw::HWModuleOp>(pair.first);
      if (!module)
        continue;

      llvm::json::Object moduleObj;
      moduleObj["name"] = module.getName().str();
      llvm::json::Array txnsArray;

      llvm::errs() << "Module: @" << module.getName() << "\n";

      for (size_t i = 0; i < pair.second.size(); ++i) {
        const auto &txn = pair.second[i];
        totalCandidates++;
        if (txn.weak) weakCandidates++;

        llvm::errs() << "  [TXN " << i << "] "
                     << (txn.kind == BusTxnCandidate::READ ? "READ" :
                         txn.kind == BusTxnCandidate::WRITE ? "WRITE" : "UNKNOWN")
                     << " (confidence=" << llvm::format("%.2f", txn.confidence) << ")";
        if (txn.weak) llvm::errs() << " [WEAK]";
        llvm::errs() << "\n";

        llvm::errs() << "    - Registers controlled: " << txn.evidence.registersControlled << "\n";
        llvm::errs() << "    - Addr icmp count: " << txn.evidence.addrIcmpCount << "\n";
        llvm::errs() << "    - Reason: " << txn.evidence.reason << "\n";
        llvm::errs() << "    - Has enable: " << (txn.enableCond ? "yes" : "no") << "\n";
        llvm::errs() << "    - Has addr: " << (txn.addrValue ? "yes" : "no") << "\n";
        llvm::errs() << "    - Has wdata: " << (txn.wdataValue ? "yes" : "no") << "\n";
        llvm::errs() << "    - Has rdata: " << (txn.rdataValue ? "yes" : "no") << "\n";

        if (!txn.evidence.paths.isEmpty()) {
          llvm::errs() << "    - Evidence paths (grouped):\n";
          if (!txn.evidence.paths.wdata.empty()) {
            llvm::errs() << "        wdata: ";
            for (const auto &p : txn.evidence.paths.wdata) llvm::errs() << p << " ";
            llvm::errs() << "\n";
          }
          if (!txn.evidence.paths.addr.empty()) {
            llvm::errs() << "        addr: ";
            for (const auto &p : txn.evidence.paths.addr) llvm::errs() << p << " ";
            llvm::errs() << "\n";
          }
          if (!txn.evidence.paths.mask.empty()) {
            llvm::errs() << "        mask: ";
            for (const auto &p : txn.evidence.paths.mask) llvm::errs() << p << " ";
            llvm::errs() << "\n";
          }
          if (!txn.evidence.paths.rdata.empty()) {
            llvm::errs() << "        rdata: ";
            for (const auto &p : txn.evidence.paths.rdata) llvm::errs() << p << " ";
            llvm::errs() << "\n";
          }
          if (!txn.evidence.paths.opcode.empty()) {
            llvm::errs() << "        opcode: ";
            for (const auto &p : txn.evidence.paths.opcode) llvm::errs() << p << " ";
            llvm::errs() << "\n";
          }
        }

        txnsArray.push_back(txn.toJSON());
      }

      moduleObj["transactions"] = std::move(txnsArray);
      modulesArray.push_back(std::move(moduleObj));

      llvm::errs() << "\n";
    }

    llvm::errs() << "========================================\n";
    llvm::errs() << "Summary:\n";
    llvm::errs() << "  Total modules analyzed: " << moduleTxns.size() << "\n";
    llvm::errs() << "  Total transaction candidates: " << totalCandidates << "\n";
    llvm::errs() << "  Weak candidates: " << weakCandidates << "\n";
    llvm::errs() << "========================================\n\n";

    qemu_passes::writePassReport(
        "functional_bus_txn_infer",
        [&](llvm::raw_ostream &os) {
          os << "Functional Bus Transaction Inference — summary\n";
          os << "==============================================\n";
          os << "Modules analyzed:     " << moduleTxns.size() << "\n";
          os << "Total candidates:     " << totalCandidates << "\n";
          os << "Weak candidates:      " << weakCandidates << "\n";
        });

    // The legacy transaction report under results/common/default/generation/ is only written
    // when reports are enabled.  (Historical reason: this file lives in the
    // outputs tree, separately from the checked-in sample MLIR.)
    if (qemu_passes::g_reportsEnabled) {
      std::string dumpPath = "results/common/default/generation/functional_txn_results.json";
      std::error_code ec;
      llvm::raw_fd_ostream outFile(dumpPath, ec);
      if (!ec) {
        llvm::json::Object root;
        root["modules"] = std::move(modulesArray);
        outFile << llvm::formatv("{0:2}", llvm::json::Value(std::move(root)))
                << "\n";
        llvm::errs() << "Results dumped to: " << dumpPath << "\n";
      }
    }
  }
};

void FunctionalBusTxnInferPass::runOnOperation() {
  ModuleOp module = getOperation();

  // 版本标识：确认运行的是修复后的版本
  llvm::errs() << "========================================\n";
  llvm::errs() << "FunctionalBusTxnInferPass [Build: 2026-02-17-ADDR-DEDUP-v7]\n";
  llvm::errs() << "  - Fix A: WDataTrace.score separate from depth (no more depth=score hack)\n";
  llvm::errs() << "  - Fix B: Instance TLUL struct input detection -> dependsOnAData flag\n";
  llvm::errs() << "  - Fix C: Stage B scores written to c.score, sorted by score, depth unchanged\n";
  llvm::errs() << "  - Fix D: BUS_WRITE requires wdataAnchoredToTLUL for TLUL-like modules\n";
  llvm::errs() << "  - Fix E: evidence_paths fallback includes anchor/depth/score info\n";
  llvm::errs() << "  - New fields: wdata_anchor_kind, wdata_score in evidence JSON\n";
  llvm::errs() << "========================================\n\n";

  for (auto hwModule : module.getOps<hw::HWModuleOp>()) {
    analyzeModule(hwModule);
  }

  dumpResults();
}

} // namespace
