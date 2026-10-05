#include "RTLAdapter.h"
//===----------------------------------------------------------------------===//
// TLULControlInferencePass.cpp - TileLink-UL Transaction Inference
//
// Identifies TL-UL bus transactions (READ/WRITE) by analyzing handshake
// signals and opcode conditions in OpenTitan peripherals.
//
// Key constraints:
// - Multi-bit opcode values (0/1/4) are NOT booleans
// - OR conditions require conservative "uncertain" marking
// - Does NOT modify IR (analysis-only in Phase 1)
//===----------------------------------------------------------------------===//

#include "PassReports.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Dialect/ControlFlow/IR/ControlFlowOps.h"
#include "circt/Dialect/HW/HWOps.h"
#include "circt/Dialect/Comb/CombOps.h"
#include "circt/Dialect/LLHD/LLHDOps.h"
#include "mlir/IR/Dominance.h"
#include "llvm/ADT/StringMap.h"
#include "llvm/Support/raw_ostream.h"

#define GEN_PASS_DECL_TLULCONTROLINFERENCE
#define GEN_PASS_DEF_TLULCONTROLINFERENCE
#include "Passes.h.inc"

using namespace mlir;
using namespace circt;

namespace {

//===----------------------------------------------------------------------===//
// TL-UL Transaction Analysis Structures
//===----------------------------------------------------------------------===//

struct TLULCondition {
  std::string signalName;
  uint64_t expectedValue;
  bool isPresent;

  TLULCondition() : expectedValue(0), isPresent(false) {}
  TLULCondition(std::string name, uint64_t val)
    : signalName(name), expectedValue(val), isPresent(true) {}
};

struct TLULTransaction {
  Location site;
  std::string moduleName;

  // Handshake signals
  TLULCondition aValid;    // a_valid == 1
  TLULCondition aReady;    // a_ready == 1

  // Opcode
  TLULCondition opcode;    // a_opcode == 0/1/4

  // Extracted fields (optional)
  std::string addrSignal;
  std::string dataSignal;
  std::string maskSignal;

  // Analysis metadata
  bool hasAlternatives;    // Contains OR logic
  int unknownOpsCount;
  std::string uncertainty;

  TLULTransaction(MLIRContext *ctx = nullptr)
    : site(UnknownLoc::get(ctx)), hasAlternatives(false), unknownOpsCount(0) {}

  std::string getTransactionType() const {
    if (!opcode.isPresent) return "UNKNOWN";
    if (opcode.expectedValue == 4) return "READ";
    if (opcode.expectedValue == 0 || opcode.expectedValue == 1) return "WRITE";
    return "UNKNOWN";
  }

  std::string getConfidence() const {
    if (hasAlternatives) return "uncertain(or)";
    if (!aValid.isPresent || !aReady.isPresent || !opcode.isPresent)
      return "missing_fields";
    return "definite";
  }
};

//===----------------------------------------------------------------------===//
// Signal Name Tracer
//===----------------------------------------------------------------------===//

class SignalNameTracer {
public:
  // Trace a value back to its signal name
  std::string traceSignalName(Value val) {
    if (auto blockArg = dyn_cast<BlockArgument>(val)) {
      // Try to get the argument name from parent module
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

    // llhd.prb - probe signal
    if (auto prbOp = dyn_cast<llhd::ProbeOp>(defOp)) {
      return traceSignalName(prbOp.getSignal());
    }

    // llhd.sig - signal declaration
    if (auto sigOp = dyn_cast<llhd::SignalOp>(defOp)) {
      if (auto nameAttr = sigOp.getNameAttr()) {
        return nameAttr.getValue().str();
      }
    }

    // hw.struct_extract - field access (e.g., tl_i.a_valid)
    if (auto extractOp = dyn_cast<hw::StructExtractOp>(defOp)) {
      std::string baseName = traceSignalName(extractOp.getInput());
      std::string fieldName = extractOp.getFieldNameAttr().getValue().str();
      return baseName + "." + fieldName;
    }

    // comb.extract - bit slice
    if (auto extractOp = dyn_cast<comb::ExtractOp>(defOp)) {
      std::string baseName = traceSignalName(extractOp.getInput());
      return baseName + "[" + std::to_string(extractOp.getLowBit()) + "]";
    }

    return "expr";
  }
};

//===----------------------------------------------------------------------===//
// OpenTitan TL-UL protocol-noise field names
//
// These are bus-protocol fields that QEMU MMIO firmware never exercises
// non-trivially (mask/size/param are fixed by the protocol; opcode collapses
// once we know the access direction).  ForwardConstrain reads this list via
// the qemu.protocol_constraints attribute and substitutes each name with its
// sensitization-required constant, then DCEs the dead mux branches.
//
// The list is per-protocol knowledge, hardcoded for OpenTitan TL-UL.  When
// the toolchain extends to other bus protocols (APB/AXI/...) this list
// should move to a per-protocol config.
//===----------------------------------------------------------------------===//
static constexpr const char *kTLULNoiseFields[] = {
    "a_opcode",  // Get/PutFullData/PutPartialData — sensitization picks one
    "a_param",   // always 0 in standard MMIO
    "a_size",    // always 2 (4-byte access)
    "a_mask",    // always 0xF (full byte enable)
    "a_user",    // any user-extension field (parity / integrity tags)
};

//===----------------------------------------------------------------------===//
// Condition Tree Analyzer
//===----------------------------------------------------------------------===//

class ConditionAnalyzer {
public:
  ConditionAnalyzer() : tracer(), foundAValid(false), foundAReady(false),
                        foundOpcode(false), hasOR(false), unknownOps(0) {}

  // Analyze condition from cf.cond_br or llhd.drv
  TLULTransaction analyzeCondition(Value condition, Location loc,
                                   StringRef moduleName, MLIRContext *ctx) {
    TLULTransaction txn(ctx);
    txn.site = loc;
    txn.moduleName = moduleName.str();

    // Reset state
    foundAValid = false;
    foundAReady = false;
    foundOpcode = false;
    hasOR = false;
    unknownOps = 0;

    // Recursively analyze condition tree
    analyzeValue(condition);

    // Populate transaction struct
    if (foundAValid) {
      txn.aValid = TLULCondition("a_valid", 1);
    }
    if (foundAReady) {
      txn.aReady = TLULCondition("a_ready", 1);
    }
    if (foundOpcode) {
      txn.opcode = opcodeCondition;
    }

    txn.hasAlternatives = hasOR;
    txn.unknownOpsCount = unknownOps;

    if (hasOR) {
      txn.uncertainty = "contains OR - not all branches verified";
    } else if (unknownOps > 0) {
      txn.uncertainty = "contains " + std::to_string(unknownOps) +
                        " unknown operations";
    }

    return txn;
  }

private:
  SignalNameTracer tracer;
  bool foundAValid;
  bool foundAReady;
  bool foundOpcode;
  bool hasOR;
  int unknownOps;
  TLULCondition opcodeCondition;

  void analyzeValue(Value val) {
    Operation *defOp = val.getDefiningOp();
    if (!defOp) return;

    // AND - all conditions must hold
    if (auto andOp = dyn_cast<comb::AndOp>(defOp)) {
      for (Value operand : andOp.getOperands()) {
        analyzeValue(operand);
      }
      return;
    }

    // OR - mark as alternative path (conservative)
    if (auto orOp = dyn_cast<comb::OrOp>(defOp)) {
      hasOR = true;
      // Still analyze first branch for informational purposes
      if (orOp.getNumOperands() > 0) {
        analyzeValue(orOp.getOperand(0));
      }
      return;
    }

    // XOR - check if it's a NOT operation (xor with all-ones)
    if (auto xorOp = dyn_cast<comb::XorOp>(defOp)) {
      if (xorOp.getNumOperands() == 2) {
        // Check if one operand is all-ones constant (NOT pattern)
        bool isNot = false;
        Value target;
        for (int i = 0; i < 2; i++) {
          if (auto constOp = xorOp.getOperand(i).getDefiningOp<hw::ConstantOp>()) {
            APInt value = constOp.getValue();
            if (value.isAllOnes()) {
              isNot = true;
              target = xorOp.getOperand(1 - i);
              break;
            }
          }
        }
        if (isNot) {
          // This is a NOT - recursively analyze the negated value
          analyzeValue(target);
          return;
        }
      }
      unknownOps++;
      return;
    }

    // ICMP eq - check for signal == constant
    if (auto icmpOp = dyn_cast<comb::ICmpOp>(defOp)) {
      if (icmpOp.getPredicate() == comb::ICmpPredicate::eq) {
        analyzeICmpEq(icmpOp);
        return;
      }
    }

    // Direct signal probe (assumes ==1)
    if (isa<llhd::ProbeOp>(defOp)) {
      std::string sigName = tracer.traceSignalName(val);
      if (sigName.find("a_valid") != std::string::npos) {
        foundAValid = true;
      } else if (sigName.find("a_ready") != std::string::npos) {
        foundAReady = true;
      }
      return;
    }

    // Unknown operation
    unknownOps++;
  }

  void analyzeICmpEq(comb::ICmpOp icmpOp) {
    Value lhs = icmpOp.getLhs();
    Value rhs = icmpOp.getRhs();

    // Try to extract: signal == constant
    std::string sigName;
    uint64_t constValue = 0;
    bool found = false;

    // Check lhs = signal, rhs = constant
    if (auto constOp = rhs.getDefiningOp<hw::ConstantOp>()) {
      sigName = tracer.traceSignalName(lhs);
      constValue = constOp.getValue().getZExtValue();
      found = true;
    }
    // Check lhs = constant, rhs = signal
    else if (auto constOp = lhs.getDefiningOp<hw::ConstantOp>()) {
      sigName = tracer.traceSignalName(rhs);
      constValue = constOp.getValue().getZExtValue();
      found = true;
    }

    if (!found) return;

    // Identify TL-UL signals by name pattern (flexible matching)
    // Matches: a_valid, tl_a_valid, tl_i.a_valid, etc.
    if ((sigName.find("a_valid") != std::string::npos ||
         sigName.find("_valid") != std::string::npos) && constValue == 1) {
      foundAValid = true;
    }
    else if ((sigName.find("a_ready") != std::string::npos ||
              sigName.find("_ready") != std::string::npos) && constValue == 1) {
      foundAReady = true;
    }
    else if (sigName.find("opcode") != std::string::npos) {
      // CRITICAL: Multi-bit opcode comparison
      // 0 = PutFullData (Write)
      // 1 = PutPartialData (Write)
      // 4 = Get (Read)
      if (constValue == 0 || constValue == 1 || constValue == 4) {
        foundOpcode = true;
        opcodeCondition = TLULCondition(sigName, constValue);
      }
    }
  }
};

//===----------------------------------------------------------------------===//
// TLULControlInferencePass Implementation
//===----------------------------------------------------------------------===//

struct TLULControlInferencePass
    : public ::impl::TLULControlInferenceBase<TLULControlInferencePass> {
  using TLULControlInferenceBase::TLULControlInferenceBase;

  void runOnOperation() override {
    ModuleOp mod = getOperation();
    if (!qemu_passes::usesOpenTitanRTLAdapter(mod)) return;
    MLIRContext *ctx = mod.getContext();

    llvm::errs() << "\n";
    llvm::errs() << "========================================\n";
    llvm::errs() << "TL-UL Control Signal Inference Pass\n";
    llvm::errs() << "========================================\n";

    ConditionAnalyzer analyzer;
    unsigned totalTransactions = 0;
    unsigned definiteTransactions = 0;
    unsigned uncertainTransactions = 0;

    // Walk all hw.module operations
    mod.walk([&](hw::HWModuleOp hwMod) {
      std::string moduleName = hwMod.getName().str();
      llvm::errs() << "\nModule: @" << moduleName << "\n";

      unsigned moduleDefinite = 0;

      // Analyze conditional branches (state machine transitions)
      hwMod.walk([&](mlir::cf::CondBranchOp condBr) {
        Value condition = condBr.getCondition();
        Location loc = condBr.getLoc();

        TLULTransaction txn = analyzer.analyzeCondition(condition, loc, moduleName, ctx);

        // Only report if we found at least handshake or opcode
        if (txn.aValid.isPresent || txn.aReady.isPresent || txn.opcode.isPresent) {
          totalTransactions++;
          if (txn.getConfidence() == "definite") {
            definiteTransactions++;
            moduleDefinite++;
          } else {
            uncertainTransactions++;
          }

          printTransaction(txn);
        }
      });

      // Also scan llhd.drv for write-enable patterns (supplementary)
      hwMod.walk([&](llhd::DriveOp drvOp) {
        if (drvOp.getNumOperands() >= 3) {
          Value enable = drvOp.getEnable();
          if (enable) {
            Location loc = drvOp.getLoc();
            TLULTransaction txn = analyzer.analyzeCondition(enable, loc, moduleName, ctx);

            if (txn.aValid.isPresent || txn.aReady.isPresent || txn.opcode.isPresent) {
              totalTransactions++;
              if (txn.getConfidence() == "definite") {
                definiteTransactions++;
                moduleDefinite++;
              } else {
                uncertainTransactions++;
              }

              printTransaction(txn);
            }
          }
        }
      });

      // Attach qemu.protocol_constraints to modules that have at least one
      // definite TL-UL transaction.  Downstream ForwardConstrain reads this
      // attribute to auto-discover which signal names to fold as constants.
      if (moduleDefinite > 0 && !hwMod->hasAttr("qemu.bus_profile_declared")) {
        SmallVector<Attribute, 8> nameAttrs;
        for (const char *name : kTLULNoiseFields)
          nameAttrs.push_back(StringAttr::get(ctx, name));
        hwMod->setAttr("qemu.protocol_constraints",
                       ArrayAttr::get(ctx, nameAttrs));
      }
    });

    llvm::errs() << "\n========================================\n";
    llvm::errs() << "Summary:\n";
    llvm::errs() << "  Total TL-UL transaction sites: " << totalTransactions << "\n";
    llvm::errs() << "  Definite transactions: " << definiteTransactions << "\n";
    llvm::errs() << "  Uncertain transactions: " << uncertainTransactions << "\n";
    llvm::errs() << "========================================\n";

    qemu_passes::writePassReport(
        "tlul_control_inference",
        [&](llvm::raw_ostream &os) {
          os << "TL-UL Control Inference — summary\n";
          os << "=================================\n";
          os << "Total transaction sites: " << totalTransactions << "\n";
          os << "Definite:                " << definiteTransactions << "\n";
          os << "Uncertain:               " << uncertainTransactions << "\n";
        });
  }

private:
  void printTransaction(const TLULTransaction& txn) {
    llvm::errs() << "\n[TLUL] module=@" << txn.moduleName
                 << " site=" << txn.site << "\n";

    // Handshake
    llvm::errs() << "[TLUL] handshake: ";
    if (txn.aValid.isPresent) {
      llvm::errs() << "a_valid=" << txn.aValid.signalName << "==1 ";
    } else {
      llvm::errs() << "a_valid=missing ";
    }
    if (txn.aReady.isPresent) {
      llvm::errs() << "a_ready=" << txn.aReady.signalName << "==1";
    } else {
      llvm::errs() << "a_ready=missing";
    }
    llvm::errs() << "\n";

    // Opcode
    llvm::errs() << "[TLUL] opcode: ";
    if (txn.opcode.isPresent) {
      llvm::errs() << txn.opcode.signalName << "==" << txn.opcode.expectedValue
                   << " => type=" << txn.getTransactionType();
    } else {
      llvm::errs() << "missing => type=UNKNOWN";
    }
    llvm::errs() << "\n";

    // Confidence
    llvm::errs() << "[TLUL] confidence: " << txn.getConfidence() << "\n";

    // Extracted fields (placeholder for future)
    llvm::errs() << "[TLUL] extracted: addr="
                 << (txn.addrSignal.empty() ? "?" : txn.addrSignal)
                 << " data="
                 << (txn.dataSignal.empty() ? "?" : txn.dataSignal)
                 << " mask="
                 << (txn.maskSignal.empty() ? "?" : txn.maskSignal)
                 << "\n";

    // Notes
    llvm::errs() << "[TLUL] notes: unknown_ops=" << txn.unknownOpsCount
                 << ", hasAlternatives=" << (txn.hasAlternatives ? "true" : "false");
    if (!txn.uncertainty.empty()) {
      llvm::errs() << ", " << txn.uncertainty;
    }
    llvm::errs() << "\n";
  }
};

} // anonymous namespace
