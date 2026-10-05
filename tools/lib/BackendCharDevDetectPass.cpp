#include "RTLAdapter.h"
//===----------------------------------------------------------------------===//
// BackendCharDevDetectPass.cpp - Chardev topology inference (UART pilot)
//
// Walks the IR, identifies prim_fifo_sync instances inside character-device
// peripherals (uart / i2c / spi_*), classifies them as TX or RX based on
// what feeds their wvalid_i port, cross-validates with cio_*_o / cio_*_i
// top-level ports, and (in later sub-phases) maps the TX trigger back to a
// reg_top MMIO offset.  Emits the result as a `qemu.chardev_blueprint`
// module attribute consumed by QEMUEmitCPass to inject a chardev hookup
// into the auto-generated `<dev>_qp_shim.c`.
//
// v1 (this commit):
//   - Filter parent modules (skip prim_*, tlul_*, *sram_adapter*) so we
//     don't classify the prim_fifo_sync_cnt counter sub-instance or the
//     TL-UL bus internal FIFOs as chardev candidates.
//   - Reverse-trace wvalid_i through llhd.prb / hw.struct_extract /
//     comb.* to its origin signal, classify TX (origin = `*.qe`) vs
//     RX (origin = `cio_*_i` BlockArgument).
//   - Still no IR mutation, no attribute emit — that's v2/v3 (Phases A.4 / A.5).
//===----------------------------------------------------------------------===//

#include "BackendBlueprint.h"
#include "PassReports.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/SymbolTable.h"
#include "mlir/Pass/Pass.h"
#include "circt/Dialect/HW/HWOps.h"
#include "circt/Dialect/Comb/CombOps.h"
#include "circt/Dialect/LLHD/LLHDOps.h"
#include "llvm/ADT/DenseMap.h"
#include "llvm/Support/Format.h"
#include "llvm/Support/FormatVariadic.h"
#include "llvm/Support/JSON.h"
#include "llvm/Support/raw_ostream.h"
#include <optional>
#include <functional>
#include <set>
#include <utility>

#define GEN_PASS_DECL_BACKENDCHARDEVDETECT
#define GEN_PASS_DEF_BACKENDCHARDEVDETECT
#include "Passes.h.inc"

using namespace mlir;
using namespace circt;

namespace {

//===----------------------------------------------------------------------===//
// SignalNameTracer — local copy adapted from TLULControlInferencePass.cpp.
//
// Walks back through the SSA def-use chain to give a value its original
// signal name.  Examples for UART:
//   - `wvalid_i` of u_uart_txfifo  →  hw.struct_extract %wdata["qe"]
//                                     →  llhd.sig "wdata"  →  "wdata.qe"
//   - `wvalid_i` of u_uart_rxfifo  →  comb.and(...prb cio_rx_i...)
//                                     →  hits a BlockArgument named "cio_rx_i"
//                                     →  "cio_rx_i"
//
// Identical signature to the TLUL pass version (kept inline-private here
// to avoid premature header extraction; refactor when a third pass needs it).
//===----------------------------------------------------------------------===//
class SignalNameTracer {
public:
  std::string traceSignalName(Value val) {
    if (auto blockArg = dyn_cast<BlockArgument>(val)) {
      if (auto *parentOp = blockArg.getOwner()->getParentOp()) {
        if (auto hwMod = dyn_cast<hw::HWModuleOp>(parentOp)) {
          unsigned argNum = blockArg.getArgNumber();
          auto ports = hwMod.getPortList();
          if (argNum < ports.size()) {
            return ports[argNum].getName().str();
          }
        }
      }
      return "arg" + std::to_string(blockArg.getArgNumber());
    }

    Operation *defOp = val.getDefiningOp();
    if (!defOp) return "unknown";

    if (auto prbOp = dyn_cast<llhd::ProbeOp>(defOp))
      return traceSignalName(prbOp.getSignal());
    if (auto sigOp = dyn_cast<llhd::SignalOp>(defOp)) {
      if (auto nameAttr = sigOp.getNameAttr())
        return nameAttr.getValue().str();
    }
    if (auto extractOp = dyn_cast<hw::StructExtractOp>(defOp)) {
      std::string baseName = traceSignalName(extractOp.getInput());
      std::string fieldName = extractOp.getFieldNameAttr().getValue().str();
      return baseName + "." + fieldName;
    }
    if (auto extractOp = dyn_cast<comb::ExtractOp>(defOp)) {
      std::string baseName = traceSignalName(extractOp.getInput());
      return baseName + "[" + std::to_string(extractOp.getLowBit()) + "]";
    }
    // hw.instance result — name as "<inst>.<port>".  The RX FIFO's
    // wvalid_i comes from `comb.and(uart_rx.rx_valid, ...)` — without
    // this branch we'd return "expr" for `uart_rx.rx_valid`.
    if (auto instOp = dyn_cast<hw::InstanceOp>(defOp)) {
      if (auto opResult = dyn_cast<OpResult>(val)) {
        unsigned idx = opResult.getResultNumber();
        auto names = instOp.getResultNames();
        if (idx < names.size()) {
          if (auto strAttr = dyn_cast<StringAttr>(names[idx]))
            return instOp.getInstanceName().str() + "." + strAttr.str();
        }
      }
    }
    return "expr";
  }

  // For comb.and/or-rooted RX wvalid that combines multiple guards,
  // walk into the operands and return the first input that resolves to
  // a non-"expr" name.  Stops the walk at depth 6 (typical chain ≤ 4).
  std::string traceThroughCombGuards(Value val, int depth = 6) {
    if (depth == 0) return "expr";

    // Direct trace first — handles the simple cases.
    std::string direct = traceSignalName(val);
    if (direct != "expr" && direct != "unknown") return direct;

    Operation *defOp = val.getDefiningOp();
    if (!defOp) return direct;

    // Through n-ary AND / OR / XOR.
    if (isa<comb::AndOp, comb::OrOp, comb::XorOp>(defOp)) {
      // Prefer operands that resolve to a BlockArgument — that's where
      // cio_rx_i lives.  Fall back to the first interesting name.
      for (Value operand : defOp->getOperands()) {
        // Recursively probe; favor BlockArg roots.
        if (auto bArg = dyn_cast<BlockArgument>(operand)) {
          (void)bArg;
          std::string name = traceSignalName(operand);
          StringRef nameRef(name);
          if (nameRef.starts_with("cio_") || nameRef.starts_with("rx") ||
              nameRef.starts_with("tx"))
            return name;
        }
      }
      // Otherwise recurse into each operand.
      for (Value operand : defOp->getOperands()) {
        std::string nested = traceThroughCombGuards(operand, depth - 1);
        if (nested != "expr" && nested != "unknown") return nested;
      }
    }
    return direct;
  }
};

//===----------------------------------------------------------------------===//
// Helpers
//===----------------------------------------------------------------------===//

/// True if `parentName` is a generic helper module that we should NOT
/// associate with chardev (prim_*, tlul_*, *sram_adapter*).  These modules'
/// FIFO instances are bus-internal or counter sub-modules, not the
/// peripheral's TX/RX data path.
static bool isHelperParent(StringRef parentName) {
  return parentName.starts_with("prim_") ||
         parentName.starts_with("tlul_") ||
         parentName.contains("sram_adapter");
}

/// Structurally recognize a device's data-pin I/O roles — GENERICALLY, with no
/// device names.  A "data pin bus" of width W (>=2) is a same-width triple:
/// an input integer port (data_in) + EXACTLY two output integer ports of that
/// width, one being the output-enable (name tiebreak: contains "_en"/"oe") and
/// the other the data-output.  Picks the widest such triple.  Returns nullopt
/// when no clean triple exists (register-only or scalar-cio peripherals get no
/// pin_io blueprint, so their shim is unchanged).
static std::optional<qemu_passes::PinIoInfo>
recognizePinIo(hw::HWModuleOp topMod) {
  struct P { std::string name; unsigned width; };
  llvm::SmallVector<P> outs, ins;
  for (auto p : topMod.getPortList()) {
    auto it = dyn_cast<IntegerType>(p.type);
    if (!it)
      continue;
    unsigned w = it.getWidth();
    if (w < 2 || w > 64)
      continue; // scalar pins aren't a data bus; >64 exceeds the shim's u64 path
    if (p.dir == hw::ModulePort::Direction::Output) {
      StringRef n = p.getName();
      // Interrupt outputs are a separate role (already classified for the irq
      // blueprint); exclude them so a wide intr_*_o bus doesn't masquerade as
      // a data-output bus.
      if (n.starts_with("intr_") && n.ends_with("_o"))
        continue;
      outs.push_back({n.str(), w});
    } else if (p.dir == hw::ModulePort::Direction::Input)
      ins.push_back({p.getName().str(), w});
  }
  auto looksEnable = [](StringRef n) {
    std::string l = n.lower();
    return StringRef(l).contains("_en") || StringRef(l).contains("oe");
  };
  std::optional<qemu_passes::PinIoInfo> best;
  for (const auto &in : ins) {
    const P *oe = nullptr, *data = nullptr;
    unsigned nEn = 0, nData = 0;
    for (const auto &o : outs) {
      if (o.width != in.width)
        continue;
      if (looksEnable(o.name)) { ++nEn; oe = &o; }
      else                     { ++nData; data = &o; }
    }
    if (nEn != 1 || nData != 1) // require a clean data+enable pair
      continue;
    if (best && in.width <= best->dataInWidth)
      continue; // keep the widest triple
    qemu_passes::PinIoInfo info;
    info.dataOutPort = data->name; info.dataOutWidth = data->width;
    info.oePort = oe->name;        info.oeWidth = oe->width;
    info.dataInPort = in.name;     info.dataInWidth = in.width;
    best = info;
  }
  return best;
}

/// Find the index of an input port by name on the referenced module.
/// Returns -1 if not found.  Used to pick `wvalid_i` operand from
/// `inst.getOperand(idx)` without hardcoding a numeric position.
static int findInputPortIndex(hw::HWModuleOp refMod, StringRef portName) {
  int inputIdx = 0;
  for (auto port : refMod.getPortList()) {
    if (port.dir != hw::ModulePort::Direction::Input)
      continue;
    if (port.getName() == portName)
      return inputIdx;
    ++inputIdx;
  }
  return -1;
}

/// Walk a reg_top hw.module body and build addr_hit_bit -> mmio_offset map
/// by recognizing the pattern:
///
///   %bit_sig = llhd.sig.extract %addr_hit from %c<N>_i<W>
///   %addr   = llhd.prb %reg_addr
///   %eq     = comb.icmp eq %addr, %c<OFFSET>_i<W>
///   llhd.drv %bit_sig, %eq
///
/// For each `llhd.drv` whose target is a sig.extract from a sig named
/// "addr_hit" and whose source value chains to `comb.icmp eq <reg_addr>,
/// <const>`, record (bit_idx, offset).  Returns map indexed by bit number.
static llvm::DenseMap<unsigned, uint64_t>
buildAddrHitBitToOffset(hw::HWModuleOp regTopMod) {
  llvm::DenseMap<unsigned, uint64_t> bitToOffset;

  regTopMod.walk([&](llhd::DriveOp drv) {
    // Target must be a sig.extract from `%addr_hit`
    auto sigExt = drv.getSignal().getDefiningOp<llhd::SigExtractOp>();
    if (!sigExt) return;
    auto baseSig = sigExt.getInput().getDefiningOp<llhd::SignalOp>();
    if (!baseSig) return;
    auto sigName = baseSig.getName();
    if (!sigName || *sigName != "addr_hit") return;

    // Bit index is sig.extract's offset operand (a constant).
    auto bitIdxConst = sigExt.getLowBit().getDefiningOp<hw::ConstantOp>();
    if (!bitIdxConst) return;
    unsigned bitIdx = bitIdxConst.getValue().getZExtValue();

    // Source value should be a comb.icmp eq <reg_addr_prb>, <const>
    auto cmp = drv.getValue().getDefiningOp<comb::ICmpOp>();
    if (!cmp || cmp.getPredicate() != comb::ICmpPredicate::eq) return;

    // RHS should be a hw.constant — that's the offset.
    auto rhsConst = cmp.getRhs().getDefiningOp<hw::ConstantOp>();
    if (!rhsConst) return;
    uint64_t offset = rhsConst.getValue().getZExtValue();

    // Optional sanity: LHS should probe a sig named "reg_addr" — but
    // the prior icmp == const pattern is a strong-enough match without it.
    bitToOffset[bitIdx] = offset;
  });

  return bitToOffset;
}

/// Walk a reg_top hw.module and recover the (regname → bit_idx) mapping
/// by inspecting prim_subreg* instance ports.  In OpenTitan reg_top, each
/// register is an instance "u_<regname>" of type prim_subreg* / prim_subreg_ext.
/// Its `we` operand traces (through llhd.prb of an unnamed sig, then drv
/// from comb.and) to a `comb.extract %prb_addr_hit, N` — N is the addr_hit
/// bit gating writes to that register.
///
/// Returns RegStrobe entries with regname (instance name with "u_" stripped),
/// bit_idx, and kind ("we" or "re" — from the prim_subreg port name).
struct RegStrobe {
  std::string regName;
  unsigned bitIdx;
  std::string kind;  // "we" (prim_subreg write-enable) or "re" (prim_subreg_ext read-enable)
};

/// Look at a comb expression and return the addr_hit bit index it tests
/// (via `comb.extract %prb_addr_hit, N`) anywhere in its operand tree.
/// Accepts addr_hit, racl_addr_hit_read, racl_addr_hit_write.  Returns
/// -1 if no such pattern is found.
static int findAddrHitBitInExpr(Value v) {
  SmallVector<Value> candidates;
  if (auto andOp = v.getDefiningOp<comb::AndOp>())
    for (Value op : andOp.getOperands()) candidates.push_back(op);
  else if (auto orOp = v.getDefiningOp<comb::OrOp>())
    for (Value op : orOp.getOperands()) candidates.push_back(op);
  else
    candidates.push_back(v);

  for (Value cand : candidates) {
    auto ext = cand.getDefiningOp<comb::ExtractOp>();
    if (!ext) continue;
    auto innerPrb = ext.getInput().getDefiningOp<llhd::ProbeOp>();
    if (!innerPrb) continue;
    auto base = innerPrb.getSignal().getDefiningOp<llhd::SignalOp>();
    if (!base) continue;
    auto baseName = base.getName();
    if (!baseName) continue;
    if (*baseName != "addr_hit" &&
        *baseName != "racl_addr_hit_read" &&
        *baseName != "racl_addr_hit_write")
      continue;
    return (int)ext.getLowBit();
  }
  return -1;
}

/// Walk back from a we/re prim_subreg port to find which addr_hit bit
/// gates it.  Two shapes:
///   A. prim_subreg.we  ← llhd.prb %<reg>_we; %<reg>_we ← drv comb.and(...)
///   B. prim_subreg_ext.re ← comb.and(...) directly (no intermediate sig)
static int traceStrobeBitIdx(Value strobeVal) {
  // Shape B
  if (!strobeVal.getDefiningOp<llhd::ProbeOp>())
    return findAddrHitBitInExpr(strobeVal);

  // Shape A
  auto prb = strobeVal.getDefiningOp<llhd::ProbeOp>();
  Value sig = prb.getSignal();
  for (Operation *user : sig.getUsers()) {
    auto drv = dyn_cast<llhd::DriveOp>(user);
    if (!drv || drv.getSignal() != sig) continue;
    int bit = findAddrHitBitInExpr(drv.getValue());
    if (bit >= 0) return bit;
  }
  return -1;
}

static SmallVector<RegStrobe>
buildRegStrobes(hw::HWModuleOp regTopMod) {
  SmallVector<RegStrobe> out;
  std::set<std::pair<std::string, std::string>> seen;

  regTopMod.walk([&](hw::InstanceOp inst) {
    StringRef modName = inst.getModuleName();
    if (!modName.starts_with("prim_subreg")) return;

    StringRef instName = inst.getInstanceName();
    if (!instName.starts_with("u_")) return;
    StringRef regName = instName.drop_front(2);  // strip "u_"

    // Lookup referenced module to find we / re port indices.
    auto refMod = inst->getParentOfType<ModuleOp>();
    if (!refMod) return;
    SymbolTable st(refMod);
    auto refHw = dyn_cast_or_null<hw::HWModuleOp>(st.lookup(modName));
    if (!refHw) return;

    int weIdx = findInputPortIndex(refHw, "we");
    int reIdx = findInputPortIndex(refHw, "re");

    if (weIdx >= 0 && (size_t)weIdx < inst.getNumOperands()) {
      int bitIdx = traceStrobeBitIdx(inst.getOperand(weIdx));
      if (bitIdx >= 0) {
        auto key = std::make_pair(regName.str(), std::string("we"));
        if (seen.insert(key).second)
          out.push_back({regName.str(), (unsigned)bitIdx, "we"});
      }
    }
    if (reIdx >= 0 && (size_t)reIdx < inst.getNumOperands()) {
      int bitIdx = traceStrobeBitIdx(inst.getOperand(reIdx));
      if (bitIdx >= 0) {
        auto key = std::make_pair(regName.str(), std::string("re"));
        if (seen.insert(key).second)
          out.push_back({regName.str(), (unsigned)bitIdx, "re"});
      }
    }
  });

  return out;
}

/// Find every register block reachable from a public device module.
///
/// Simple peripherals instantiate `<dev>_reg_top` directly, but composite
/// peripherals may place several register banks below interface submodules
/// (for example top -> hostif/sysif -> *_reg_top).  Traverse the instance
/// graph rather than assuming one direct register block.  The visited set
/// also makes this safe for shared helper modules and accidental cycles.
static SmallVector<hw::HWModuleOp>
findRegTopsForDevice(hw::HWModuleOp topMod, SymbolTable &symTable) {
  SmallVector<hw::HWModuleOp> result;
  std::set<std::string> visited;

  std::function<void(hw::HWModuleOp)> visit = [&](hw::HWModuleOp current) {
    if (!visited.insert(current.getSymName().str()).second)
      return;

    SmallVector<hw::HWModuleOp> children;
    current.walk([&](hw::InstanceOp inst) {
      auto child = dyn_cast_or_null<hw::HWModuleOp>(
          symTable.lookup(inst.getModuleName()));
      if (!child)
        return;
      if (inst.getModuleName().ends_with("_reg_top"))
        result.push_back(child);
      else
        children.push_back(child);
    });
    for (auto child : children)
      visit(child);
  };

  visit(topMod);
  return result;
}

/// Look up a top-level public hw.module port by name fragment.
/// Returns the actual port name if found (e.g. lookup "cio_tx_o" returns
/// "cio_tx_o" exactly), empty string otherwise.
static std::string findTopPort(hw::HWModuleOp topMod, StringRef nameFrag) {
  for (auto port : topMod.getPortList()) {
    if (port.getName() == nameFrag)
      return port.getName().str();
  }
  return "";
}

//===----------------------------------------------------------------------===//
// Per-device discovery aggregator
//===----------------------------------------------------------------------===//

// FifoInfo / DeviceBlueprint moved to BackendBlueprint.h (shared with the
// declarative BackendBindingLoadPass so the emitted attr shape can't drift).
using qemu_passes::DeviceBlueprint;
using qemu_passes::FifoInfo;

//===----------------------------------------------------------------------===//
// Pass
//===----------------------------------------------------------------------===//

struct BackendCharDevDetectPass
    : public ::impl::BackendCharDevDetectBase<BackendCharDevDetectPass> {

  void runOnOperation() override {
    ModuleOp mod = getOperation();
    if (!qemu_passes::usesOpenTitanRTLAdapter(mod)) return;
    MLIRContext *ctx = mod.getContext();
    SymbolTable symTable(mod);
    SignalNameTracer tracer;

    llvm::outs() << "========================================\n";
    llvm::outs() << "Pass: Backend Char-Dev Detection (v3)\n";
    llvm::outs() << "========================================\n\n";

    unsigned txFound = 0, rxFound = 0, unknownFound = 0;
    unsigned skippedHelper = 0;

    // Phase 1: per public top-level module, build addr_hit bit→offset
    // table + regname→strobe map (from prim_subreg* instances).
    struct ResolvedRegStrobe {
      RegStrobe strobe;
      uint64_t offset;
    };
    struct DeviceTables {
      unsigned addrHitCount = 0;
      SmallVector<ResolvedRegStrobe> regStrobes;
    };
    llvm::DenseMap<StringAttr, DeviceTables> deviceTables;
    SmallVector<hw::HWModuleOp> publicTops;

    for (auto topMod : mod.getOps<hw::HWModuleOp>()) {
      if (topMod.isPrivate()) continue;
      publicTops.push_back(topMod);
      DeviceTables tab;
      auto regTops = findRegTopsForDevice(topMod, symTable);
      for (auto regTop : regTops) {
        auto bitToOffset = buildAddrHitBitToOffset(regTop);
        auto strobes = buildRegStrobes(regTop);
        tab.addrHitCount += bitToOffset.size();
        for (auto &strobe : strobes) {
          auto it = bitToOffset.find(strobe.bitIdx);
          if (it != bitToOffset.end())
            tab.regStrobes.push_back({strobe, it->second});
        }
        llvm::outs() << "[chardev] device @" << topMod.getSymName()
                     << " reg_top=@" << regTop.getSymName()
                     << " #addrhit_bits=" << bitToOffset.size()
                     << " #strobes=" << strobes.size() << "\n";
      }
      if (regTops.empty())
        continue;
      deviceTables[topMod.getSymNameAttr()] = std::move(tab);

      auto &t = deviceTables[topMod.getSymNameAttr()];
      llvm::outs() << "[chardev] device @" << topMod.getSymName()
                   << " #reg_tops=" << regTops.size()
                   << " #addrhit_bits=" << t.addrHitCount
                   << " #resolved_strobes=" << t.regStrobes.size() << "\n";
    }

    // Phase 2: walk the IR for prim_fifo_sync instances, classify
    // TX/RX, look up offset via strobe map, and accumulate into the
    // single DeviceBlueprint.  IR is single-device per file, so just
    // pick the first public top.
    DeviceBlueprint blueprint;
    if (!publicTops.empty()) {
      blueprint.topMod = publicTops.front();
      blueprint.drainTopPort  = findTopPort(blueprint.topMod, "cio_tx_o");
      blueprint.sourceTopPort = findTopPort(blueprint.topMod, "cio_rx_i");
    }
    const DeviceTables *deviceTab = nullptr;
    if (blueprint.topMod &&
        deviceTables.count(blueprint.topMod.getSymNameAttr()))
      deviceTab = &deviceTables[blueprint.topMod.getSymNameAttr()];

    for (auto hwMod : mod.getOps<hw::HWModuleOp>()) {
      StringRef parentName = hwMod.getSymName();

      hwMod.walk([&](hw::InstanceOp inst) {
        StringRef modName = inst.getModuleName();
        if (!modName.contains("prim_fifo_sync")) return;
        if (isHelperParent(parentName)) { ++skippedHelper; return; }

        auto refMod = dyn_cast_or_null<hw::HWModuleOp>(
            symTable.lookup(modName));
        if (!refMod) return;
        int wvalidIdx = findInputPortIndex(refMod, "wvalid_i");
        if (wvalidIdx < 0 ||
            (size_t)wvalidIdx >= inst.getNumOperands()) return;

        Value wvalidVal = inst.getOperand(wvalidIdx);
        std::string source = tracer.traceThroughCombGuards(wvalidVal);

        std::string nameHint;
        if (auto *defOp = wvalidVal.getDefiningOp())
          if (auto attr = defOp->getAttrOfType<StringAttr>("sv.namehint"))
            nameHint = attr.str();

        StringRef sourceRef(source);
        StringRef hintRef(nameHint);
        StringRef instRef = inst.getInstanceName();
        bool nameSaysTx = hintRef.contains("tx") || instRef.contains("tx");
        bool nameSaysRx = hintRef.contains("rx") || instRef.contains("rx") ||
                          sourceRef.contains("rx");

        StringRef classify;
        bool isTx = false, isRx = false;
        if (sourceRef.ends_with(".qe")) {
          classify = "TX"; isTx = true; ++txFound;
        } else if (sourceRef.starts_with("cio_") &&
                   sourceRef.ends_with("_i")) {
          classify = "RX"; isRx = true; ++rxFound;
        } else if (nameSaysTx && !nameSaysRx) {
          classify = "TX?"; isTx = true; ++txFound;
        } else if (nameSaysRx && !nameSaysTx) {
          classify = "RX?"; isRx = true; ++rxFound;
        } else {
          classify = "UNKNOWN"; ++unknownFound;
        }

        // Strobe match
        std::string strobeKind = isTx ? "we" : "re";
        std::string regNameHint;
        if (sourceRef.contains(".qe")) {
          auto dot = source.find('.');
          if (dot != std::string::npos) {
            auto rest = source.substr(dot + 1);
            auto end = rest.find('.');
            if (end != std::string::npos)
              regNameHint = rest.substr(0, end);
          }
        }
        const ResolvedRegStrobe *matchedStrobe = nullptr;
        if (deviceTab && (isTx || isRx)) {
          for (auto &s : deviceTab->regStrobes) {
            if (s.strobe.kind != strobeKind) continue;
            if (!regNameHint.empty()) {
              if (s.strobe.regName == regNameHint) {
                matchedStrobe = &s;
                break;
              }
            } else {
              if (s.strobe.regName == "rdata" ||
                  s.strobe.regName == "fdata" ||
                  s.strobe.regName == "rxdata") {
                matchedStrobe = &s;
                break;
              }
            }
          }
        }

        // Build FifoInfo and stash into blueprint (only first TX, first RX).
        FifoInfo info;
        info.fifoInstance = inst.getInstanceName().str();
        info.parentModule = parentName.str();
        info.wvalidSource = source;
        info.nameHint = nameHint;
        if (matchedStrobe) {
          info.strobeRegName = matchedStrobe->strobe.regName;
          info.strobeBitIdx  = matchedStrobe->strobe.bitIdx;
          info.strobeOffset  = matchedStrobe->offset;
          info.strobeMatched = true;
        }
        if (isTx && !blueprint.tx.has_value()) blueprint.tx = std::move(info);
        else if (isRx && !blueprint.rx.has_value()) blueprint.rx = std::move(info);

        // Diagnostic line
        llvm::outs() << "[chardev] " << classify
                     << " in @" << parentName
                     << " inst=\"" << inst.getInstanceName()
                     << "\" wvalid_i <- " << source;
        if (!nameHint.empty())
          llvm::outs() << " (namehint=" << nameHint << ")";
        if (matchedStrobe)
          llvm::outs() << "  -->  strobe=" << matchedStrobe->strobe.regName
                       << "_" << matchedStrobe->strobe.kind << " offset=0x"
                       << llvm::format_hex_no_prefix(matchedStrobe->offset, 1);
        llvm::outs() << "\n";
      });
    }

    llvm::outs() << "\n[chardev] summary: TX=" << txFound
                 << " RX=" << rxFound
                 << " unknown=" << unknownFound
                 << " skipped(helper)=" << skippedHelper << "\n";

    // Phase 3: emit qemu.chardev_blueprint attribute on the public top
    // if we identified at least one of TX/RX.
    if (blueprint.topMod && (blueprint.tx || blueprint.rx)) {
      auto bpAttr = qemu_passes::buildChardevBlueprintAttr(ctx, blueprint);
      if (!blueprint.topMod->getAttr("qemu.chardev_blueprint"))
        blueprint.topMod->setAttr("qemu.chardev_blueprint", bpAttr);
      llvm::outs() << "[chardev] emitted qemu.chardev_blueprint attribute on @"
                   << blueprint.topMod.getSymName() << "\n";
    } else {
      llvm::outs() << "[chardev] no chardev topology found, no attribute emitted\n";
    }

    // Phase 4: emit qemu.irq_blueprint — derive the MMIO offsets of the
    // INTR_STATE / INTR_ENABLE / ALERT_TEST registers from the addr_hit map
    // so the QP shim can drive PLIC lines + the alert generically, with NO
    // per-device signal names OR offsets baked in.  The shim reads back
    // (INTR_STATE & INTR_ENABLE) and sets irqs[i] = bit i (the register read
    // mux already packs bits in PLIC source order), and pulses the alert on
    // writes to ALERT_TEST.  Works for any layout (uart 0x0, aon_timer 0x2c,
    // rv_timer 0x104) because the offset comes from the IR addr decode.
    if (blueprint.topMod && deviceTab) {
      // Offset of the register whose prim_subreg field name starts with
      // `prefix` (all fields of one register share an addr_hit bit/offset).
      auto offsetOf = [&](StringRef prefix) -> int64_t {
        for (const auto &s : deviceTab->regStrobes) {
          if (s.strobe.kind != "we") continue;
          if (!StringRef(s.strobe.regName).starts_with(prefix)) continue;
          return (int64_t)s.offset;
        }
        return -1;
      };
      // Count top-level intr_*_o output ports (the interrupt set).
      unsigned irqCount = 0;
      for (auto port : blueprint.topMod.getPortList()) {
        if (port.dir != hw::ModulePort::Direction::Output) continue;
        StringRef n = port.getName();
        if (n.starts_with("intr_") && n.ends_with("_o")) ++irqCount;
      }

      int64_t isOff = offsetOf("intr_state");
      int64_t ieOff = offsetOf("intr_enable");
      int64_t atOff = offsetOf("alert_test");

      // intr_enable is OPTIONAL (aon_timer has none); gate on intr_state only.
      if (blueprint.topMod->getAttr("qemu.irq_blueprint")) {
        // A binding DECLARED it; declaration wins over derivation.
      } else if (irqCount > 0 && isOff >= 0) {
        blueprint.topMod->setAttr(
            "qemu.irq_blueprint",
            qemu_passes::buildIrqBlueprintAttr(ctx, isOff, ieOff, atOff,
                                               irqCount));
        llvm::outs() << "[irq] emitted qemu.irq_blueprint on @"
                     << blueprint.topMod.getSymName() << " intr_state=0x"
                     << llvm::format_hex_no_prefix(isOff, 1);
        if (ieOff >= 0)
          llvm::outs() << " intr_enable=0x"
                       << llvm::format_hex_no_prefix(ieOff, 1);
        else
          llvm::outs() << " intr_enable=<none>";
        if (atOff >= 0)
          llvm::outs() << " alert_test=0x"
                       << llvm::format_hex_no_prefix(atOff, 1);
        llvm::outs() << " irqs=" << irqCount << "\n";
      } else {
        llvm::outs() << "[irq] no INTR_STATE resolved (irqCount=" << irqCount
                     << " intr_state=0x" << llvm::format_hex_no_prefix(isOff, 1)
                     << "), no irq_blueprint emitted\n";
      }
    }

    // Phase 5: emit qemu.pin_io_blueprint — recognize a generic data-pin bus
    // (data_out / output_enable / data_in roles) purely by IR structure, with
    // NO device names.  Any peripheral exposing such a triple gets uniform
    // qdev_init_gpio_in/out wiring downstream (gpio first; pinmux/spi free).
    if (blueprint.topMod) {
      if (auto pin = recognizePinIo(blueprint.topMod)) {
        if (!blueprint.topMod->getAttr("qemu.pin_io_blueprint"))
        blueprint.topMod->setAttr(
            "qemu.pin_io_blueprint",
            qemu_passes::buildPinIoBlueprintAttr(blueprint.topMod.getContext(),
                                                 *pin));
        llvm::outs() << "[pin_io] emitted qemu.pin_io_blueprint on @"
                     << blueprint.topMod.getSymName()
                     << " data_out=" << pin->dataOutPort << "(" << pin->dataOutWidth
                     << ") oe=" << pin->oePort << " data_in=" << pin->dataInPort
                     << "\n";
      }
    }
  }

};

} // anonymous namespace

//===----------------------------------------------------------------------===//
// IR digest emitter — the AI's input for producing a binding JSON.  Defined
// here (not in the pass) so it can reuse the file-local IR helpers above
// (findRegTopsForDevice / buildAddrHitBitToOffset / buildRegStrobes /
// isHelperParent / findInputPortIndex / SignalNameTracer) directly.  Exposes
// raw structure (ports, prim_fifo_sync instances + wvalid trace, addr-decode
// offsets) WITHOUT the OT-naming classification — a producer reasons over it.
//===----------------------------------------------------------------------===//
namespace qemu_passes {

/// Largest register offset in the device's address decode (the same
/// addr-hit -> offset analysis the IR digest publishes).  0 when no reg_top
/// is found.  Used by the emitter to size the MMIO region: a block like
/// rv_plic decodes registers at 0x200000 / 0x4000000 with narrow extract
/// widths, so the extract-width heuristic alone under-sizes the window.
uint64_t maxAddrDecodeOffset(ModuleOp mod) {
  if (!usesOpenTitanRTLAdapter(mod)) return 0;
  SymbolTable symTable(mod);
  hw::HWModuleOp topMod;
  for (auto m : mod.getOps<hw::HWModuleOp>())
    if (!m.isPrivate()) { topMod = m; break; }
  if (!topMod)
    return 0;
  uint64_t mx = 0;
  for (auto regTop : findRegTopsForDevice(topMod, symTable))
    for (auto &kv : buildAddrHitBitToOffset(regTop))
      mx = std::max(mx, (uint64_t)kv.second);
  return mx;
}


static void dumpGenericIrDigest(ModuleOp mod, llvm::StringRef path) {
  llvm::json::Object root;
  root["$schema_version"] = 1;
  root["kind"] = "generic-ir-digest";
  llvm::json::Array modules;
  for (auto hwMod : mod.getOps<hw::HWModuleOp>()) {
    llvm::json::Object module;
    module["name"] = hwMod.getName().str();
    module["public"] = !hwMod.isPrivate();
    if (!hwMod.isPrivate() && !root.get("top_module"))
      root["top_module"] = hwMod.getName().str();
    llvm::json::Array ports, signals, instances;
    for (auto p : hwMod.getPortList()) {
      std::string type;
      llvm::raw_string_ostream os(type);
      p.type.print(os);
      llvm::json::Object port;
      port["name"] = p.getName().str();
      port["direction"] = p.dir == hw::ModulePort::Direction::Input ? "input" :
                          p.dir == hw::ModulePort::Direction::Output ? "output" : "inout";
      port["type"] = type;
      if (auto integer = dyn_cast<IntegerType>(p.type))
        port["width"] = (int64_t)integer.getWidth();
      ports.push_back(std::move(port));
    }
    hwMod.walk([&](llhd::SignalOp sig) {
      if (!sig.getName()) return;
      std::string type;
      llvm::raw_string_ostream os(type);
      Type(sig.getType()).print(os);
      signals.push_back(llvm::json::Object{{"name", sig.getName()->str()}, {"type", type}});
    });
    hwMod.walk([&](hw::InstanceOp inst) {
      llvm::json::Object entry;
      entry["name"] = inst.getInstanceName().str();
      entry["module"] = inst.getModuleName().str();
      // SSA spelling is evidence for following connections, never an inferred role.
      std::string operation;
      llvm::raw_string_ostream os(operation);
      inst->print(os);
      entry["operation"] = operation;
      instances.push_back(std::move(entry));
    });
    module["ports"] = std::move(ports);
    module["signals"] = std::move(signals);
    module["instances"] = std::move(instances);
    modules.push_back(std::move(module));
  }
  root["modules"] = std::move(modules);
  std::error_code ec;
  llvm::raw_fd_ostream os(path, ec);
  if (ec) {
    llvm::errs() << "dump-ir-digest: cannot write " << path << ": " << ec.message() << "\n";
    return;
  }
  os << llvm::formatv("{0:2}", llvm::json::Value(std::move(root))) << "\n";
}

void dumpIrDigest(ModuleOp mod, llvm::StringRef path) {
  if (!usesOpenTitanRTLAdapter(mod)) {
    dumpGenericIrDigest(mod, path);
    return;
  }
  SymbolTable symTable(mod);
  SignalNameTracer tracer;

  // Public top module (single-device-per-file convention).
  hw::HWModuleOp topMod;
  for (auto m : mod.getOps<hw::HWModuleOp>()) {
    if (!m.isPrivate()) {
      topMod = m;
      break;
    }
  }
  llvm::json::Object root;
  if (!topMod) {
    root["error"] = "no public top module";
  } else {
    root["top_module"] = topMod.getSymName().str();

    // Ports (+ interrupt outputs flagged).
    llvm::json::Array ports, interrupts;
    for (auto p : topMod.getPortList()) {
      llvm::json::Object po;
      po["name"] = p.getName().str();
      po["dir"] = (p.dir == hw::ModulePort::Direction::Input) ? "in"
                  : (p.dir == hw::ModulePort::Direction::Output) ? "out"
                                                                 : "inout";
      unsigned w = 0;
      if (auto it = dyn_cast<IntegerType>(p.type))
        w = it.getWidth();
      po["width"] = (int64_t)w;
      ports.push_back(std::move(po));
      StringRef n = p.getName();
      if (p.dir == hw::ModulePort::Direction::Output &&
          n.starts_with("intr_") && n.ends_with("_o"))
        interrupts.push_back(n.str());
    }
    root["ports"] = std::move(ports);
    int64_t irqCount = (int64_t)interrupts.size();
    root["interrupts"] = std::move(interrupts);

    // Addr-decode: regname -> MMIO offset (the offset vocabulary).
    llvm::json::Array addrDecode;
    // Deterministic best-effort IRQ register resolution: the offset of the
    // *_we strobe whose reg name starts with the prefix — the SAME offsetOf
    // gate the detector uses (Phase 4).  Emitted below as `irq_suggestion`, a
    // hint the producer copies when present.  It removes the recurring
    // intr_test-vs-alert_test ambiguity that trips weak models; for non-OT
    // naming it is absent/partial and the AI must infer from addr_decode.
    int64_t isOff = -1, ieOff = -1, atOff = -1;
    for (auto regTop : findRegTopsForDevice(topMod, symTable)) {
      auto bitToOffset = buildAddrHitBitToOffset(regTop);
      auto strobes = buildRegStrobes(regTop);
      for (auto &s : strobes) {
        auto it = bitToOffset.find(s.bitIdx);
        if (it == bitToOffset.end())
          continue;
        llvm::json::Object e;
        e["reg_top"] = regTop.getSymName().str();
        e["reg"] = s.regName;
        e["offset"] = (int64_t)it->second;
        e["kind"] = s.kind;
        addrDecode.push_back(std::move(e));
      }
      auto offsetOf = [&](StringRef prefix) -> int64_t {
        for (auto &s : strobes) {
          if (s.kind != "we" || !StringRef(s.regName).starts_with(prefix))
            continue;
          auto it = bitToOffset.find(s.bitIdx);
          if (it != bitToOffset.end())
            return (int64_t)it->second;
        }
        return -1;
      };
      if (isOff < 0)
        isOff = offsetOf("intr_state");
      if (ieOff < 0)
        ieOff = offsetOf("intr_enable");
      if (atOff < 0)
        atOff = offsetOf("alert_test");
    }
    root["addr_decode"] = std::move(addrDecode);

    // irq_suggestion: deterministic hint mirroring the detector's emit gate
    // (irqCount>0 && intr_state>=0; intr_enable OPTIONAL).  The producer should
    // copy these offsets verbatim into the binding's `irq` block when present.
    if (irqCount > 0 && isOff >= 0) {
      llvm::json::Object irqSug;
      irqSug["intr_state_offset"] = isOff;
      if (ieOff >= 0)
        irqSug["intr_enable_offset"] = ieOff;
      if (atOff >= 0)
        irqSug["alert_test_offset"] = atOff;
      irqSug["irq_count"] = irqCount;
      root["irq_suggestion"] = std::move(irqSug);
    }

    // pin_io_suggestion: deterministic hint — the data-pin bus roles recognized
    // by IR structure (same shared recognizer the detector uses).  A producer
    // copies it verbatim into the binding's `pin_io` block; absent for devices
    // without a data-pin triple.  Roles, not device names.
    if (auto pin = recognizePinIo(topMod)) {
      llvm::json::Object pinSug;
      if (!pin->dataOutPort.empty()) {
        pinSug["data_out_port"] = pin->dataOutPort;
        pinSug["data_out_width"] = (int64_t)pin->dataOutWidth;
      }
      if (!pin->oePort.empty()) {
        pinSug["output_enable_port"] = pin->oePort;
        pinSug["output_enable_width"] = (int64_t)pin->oeWidth;
      }
      if (!pin->dataInPort.empty()) {
        pinSug["data_in_port"] = pin->dataInPort;
        pinSug["data_in_width"] = (int64_t)pin->dataInWidth;
      }
      root["pin_io_suggestion"] = std::move(pinSug);
    }

    // prim_fifo_sync instances + traced wvalid source (TX/RX cue, unlabeled).
    llvm::json::Array fifos;
    for (auto hwMod : mod.getOps<hw::HWModuleOp>()) {
      StringRef parentName = hwMod.getSymName();
      if (isHelperParent(parentName))
        continue;
      hwMod.walk([&](hw::InstanceOp inst) {
        StringRef modName = inst.getModuleName();
        if (!modName.contains("prim_fifo_sync"))
          return;
        std::string source;
        if (auto refMod =
                dyn_cast_or_null<hw::HWModuleOp>(symTable.lookup(modName))) {
          int wvalidIdx = findInputPortIndex(refMod, "wvalid_i");
          if (wvalidIdx >= 0 && (size_t)wvalidIdx < inst.getNumOperands())
            source = tracer.traceThroughCombGuards(inst.getOperand(wvalidIdx));
        }
        llvm::json::Object f;
        f["instance"] = inst.getInstanceName().str();
        f["module"] = modName.str();
        f["parent"] = parentName.str();
        f["wvalid_source"] = source;
        fifos.push_back(std::move(f));
      });
    }
    root["fifo_instances"] = std::move(fifos);

    // clock_roots: the third clock verdict's decision table (see SCHEMA.md
    // `clocks`).  Filled by ClockSignalDetection as qemu.clock_roots on the
    // top module: every top input port that roots a detected clock, with how
    // many clock sigs / processes resolve to it and whether it is the PRIMARY
    // (bus) clock.  Every non-primary root is a beat|event decision for the
    // producer; the IR alone cannot make it (SoC knowledge: clkmgr vs pad).
    if (auto arr = topMod->getAttrOfType<ArrayAttr>("qemu.clock_roots")) {
      llvm::json::Array roots;
      for (Attribute a : arr) {
        auto d = dyn_cast<DictionaryAttr>(a);
        if (!d) continue;
        llvm::json::Object r;
        if (auto v = d.getAs<StringAttr>("port")) r["port"] = v.getValue().str();
        if (auto v = d.getAs<IntegerAttr>("clock_sigs")) r["clock_sigs"] = v.getInt();
        if (auto v = d.getAs<IntegerAttr>("processes")) r["processes"] = v.getInt();
        if (auto v = d.getAs<BoolAttr>("primary")) r["primary"] = v.getValue();
        if (auto v = d.getAs<StringAttr>("kind")) r["kind"] = v.getValue().str();
        bool primary = d.getAs<BoolAttr>("primary") && d.getAs<BoolAttr>("primary").getValue();
        r["decision"] = primary
            ? "beat (primary/bus clock; cannot be event)"
            : "declare in binding.clocks: \"event\" if its edges carry data/events "
              "(bus clock or chip-select from a pad), \"beat\" or omit if free-running";
        roots.push_back(std::move(r));
      }
      root["clock_roots"] = std::move(roots);
    }
  }

  std::error_code ec;
  llvm::raw_fd_ostream os(path, ec);
  if (ec) {
    llvm::errs() << "dump-ir-digest: cannot write " << path << ": "
                 << ec.message() << "\n";
    return;
  }
  os << llvm::formatv("{0:2}", llvm::json::Value(std::move(root))) << "\n";
  llvm::outs() << "[digest] wrote " << path << "\n";
}

} // namespace qemu_passes
