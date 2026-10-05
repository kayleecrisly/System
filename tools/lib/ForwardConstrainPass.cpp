#include "RTLAdapter.h"
#include "BusProfileQuery.h"
#include "PassReports.h"
#include "mlir/Pass/Pass.h"
#include "circt/Dialect/Comb/CombOps.h"
#include "circt/Dialect/HW/HWOpInterfaces.h"
#include "circt/Dialect/HW/HWOps.h"
#include "circt/Dialect/LLHD/LLHDOps.h"
#include "mlir/Dialect/ControlFlow/IR/ControlFlowOps.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/Operation.h"
#include "mlir/Support/LLVM.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"
#include "llvm/ADT/DenseMap.h"
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/ADT/SmallSet.h"
#include "llvm/ADT/StringExtras.h"
#include "llvm/ADT/StringMap.h"
#include "llvm/ADT/StringSet.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/FormatVariadic.h"

// Generate Pass Declarations
#define GEN_PASS_DECL_FORWARDCONSTRAIN
#define GEN_PASS_DEF_FORWARDCONSTRAIN
#include "Passes.h.inc"

#define DEBUG_TYPE "forward-constrain"

using namespace mlir;
using namespace circt;

namespace {

/// Represents the state of a single path tracing execution.
struct TraceContext {
  /// The operations visited along this specific path
  SmallVector<Operation *, 8> paths;

  /// The required constants for other signals to sensitize this path
  /// Map of Value -> Required Constant (0 or 1)
  DenseMap<Value, int> constraints;

  /// The expected polarity of the main traced signal at this point.
  /// Starts at targetActiveValue. Flips if passing through a NOT gate.
  int expectedPolarity;

  /// When the traced signal has been packed into an hw.struct, this records
  /// which field name it corresponds to. Reset to std::nullopt once the
  /// field is extracted again via hw.struct_extract.
  std::optional<std::string> trackedFieldName;

  /// The original signal that this trace started from.
  /// Used by traceIntoBlock to determine value vs control-flow influence.
  Value rootValue;

  /// True when the root signal is wider than 1 bit.
  /// In this case expectedPolarity carries no semantic meaning and is
  /// suppressed in output.
  bool isMultiBit = false;

  TraceContext(int initialPolarity) : expectedPolarity(initialPolarity) {}

  /// Clone constructor for branching
  TraceContext(const TraceContext &other)
    : paths(other.paths),
      constraints(other.constraints),
      expectedPolarity(other.expectedPolarity),
      trackedFieldName(other.trackedFieldName),
      rootValue(other.rootValue),
      isMultiBit(other.isMultiBit) {}
};

/// Represents one complete traced path from root signal to a register/wire
/// drive endpoint.  Collected during Phase 1 (analysis) and consumed by
/// Phase 3 (constant replacement).
///
/// The key insight: `constraints` already tells us, for every side-input on
/// this path, what constant value it must hold for the path to be sensitized.
/// When the user later marks a signal name as "irrelevant bus signal", we look
/// up that name in the resolved constraints across all PathRecords and know
/// exactly what constant to substitute — per path, automatically.
struct PathRecord {
  /// Human-readable name of the target register/wire that this path drives.
  std::string targetRegister;

  /// The terminator operation (llhd.drv / cf.cond_br) at the path endpoint.
  Operation *endpoint = nullptr;

  /// Raw constraint map: SSA Value -> required constant value.
  /// This is the *original* Value-level map from TraceContext, preserved so
  /// that Phase 3 can locate the exact SSA Value to replace.
  DenseMap<Value, int> constraints;

  /// Same constraints resolved to human-readable form: signal name -> value.
  /// Built once at collection time so Phase 3 can match user-provided signal
  /// names without re-running backward resolution.
  SmallVector<std::pair<std::string, int>, 8> resolvedConstraints;

  /// The operations along this path (for scope/location context).
  SmallVector<Operation *, 8> path;

  /// Expected polarity of the traced signal at the endpoint.
  int expectedPolarity = 1;

  /// Whether the driven value is NOT data-dependent on the traced signal
  /// (i.e. control-flow-only influence).
  bool isControlFlowOnly = false;

  /// Whether polarity is meaningful (false for multi-bit signals).
  bool isMultiBit = false;

  /// Unique path index, assigned at collection time.
  unsigned pathIndex = 0;
};

struct ForwardConstrainPass : public ::impl::ForwardConstrainBase<ForwardConstrainPass> {
  using ForwardConstrainBase::ForwardConstrainBase; // Inherit constructors

  void runOnOperation() override;

private:
  void findTracingRoots(hw::HWModuleOp module, StringRef targetName);
  void processTracingRoot(Value rootValue);
  void propagateConstraint(Value currentVal, TraceContext ctx);
  void traceIntoBlock(Block *block, TraceContext ctx,
                      SmallPtrSet<Block *, 8> &visitedBlocks);
  void resolveConstraintNames(const DenseMap<Value, int> &constraints, llvm::raw_string_ostream &os);
  void reportPathSatisfiability(Operation *terminator, const TraceContext &ctx);
  void reportControlFlowInfluencedDrive(Operation *drvOp, const TraceContext &ctx);

  /// Build a PathRecord from a TraceContext at a path endpoint and store it
  /// in collectedPaths.  Returns a reference to the newly added record.
  PathRecord &collectPath(Operation *endpoint, const TraceContext &ctx,
                          bool controlFlowOnly);

  /// After all paths are collected, print a structured summary that the user
  /// can inspect to decide which signals are irrelevant bus signals.
  void printCollectedPaths();

  // --- Phase 3: Constant replacement ---

  /// Main entry point for Phase 3.  Parses the replaceSignals option and
  /// performs constant substitution for each specified bus signal.
  void performReplacements();

  /// Look up the replacement constant for `signalName` from the collected
  /// path constraints.  Returns std::nullopt if the signal is not found or
  /// has conflicting values across paths.
  std::optional<int> determineReplacementValue(StringRef signalName);

  /// Find all SSA Values corresponding to `signalName` in `module`
  /// (port BlockArguments, llhd.sig+prb, struct_extract, wire).
  SmallVector<Value, 4> findSignalValues(hw::HWModuleOp module,
                                          StringRef signalName);

  /// Replace a single signal in a module with the given constant value.
  void replaceSignalInModule(hw::HWModuleOp module, StringRef signalName,
                             int constValue);

  /// Run MLIR built-in canonicalization patterns to fold constants and
  /// eliminate dead code after replacement.
  void runCanonicalization();

  // Helper for tracking visited nodes to prevent infinite loops in combinational cycles
  SmallPtrSet<Operation *, 16> globalVisited;

  // Tracks root Values already being traced to avoid duplicate tracing when the
  // same signal appears as a port in multiple modules (e.g. after cross-module
  // propagation via hw.instance).
  DenseSet<Value> tracedRoots;

  /// All paths collected during Phase 1 analysis.  Indexed by pathIndex.
  /// This is the persistent data store that Phase 3 will consume.
  SmallVector<PathRecord, 32> collectedPaths;
};

// ============================================================================
// IR-attribute auto-discovery (route B)
//
// When invoked from --all-passes, ForwardConstrain runs without explicit
// CLI flags.  The passes upstream of it leave two IR attributes on
// hw.module ops that we use as defaults:
//
//   qemu.functional_txns   — written by FunctionalBusTxnInferPass.
//                            ArrayAttr<DictAttr>, each dict carries
//                            "rdata_signal" StringAttr (and others).
//                            We pick the first non-empty rdata as the
//                            target signal to trace from.
//
//   qemu.protocol_constraints — written by TLULControlInferencePass.
//                            ArrayAttr<StringAttr>, each name is a bus
//                            signal whose value should be folded as a
//                            constant before DCE.  Currently only fires
//                            when TLUL recognises a TL-UL transaction;
//                            for inputs where TLUL stays silent the
//                            tool_main fallback supplies a default list.
// ============================================================================

/// Walk the top module's hw.module ops and pick a target signal for FC's
/// forward-tracing.  The right target is an INPUT-side bus signal whose
/// downstream sensitization conditions we want to capture (opcode/mask
/// checks on the address decode path), NOT a state register.
///
/// Priority:
///   1. addr_signal — the address bus.  Forward-tracing from it walks
///      through the address-decode mux tree, which is exactly where
///      opcode/mask sensitization conditions live.
///   2. wdata_signal — second-best when addr is unavailable.
///   3. rdata_signal — last resort.  This is a register-like endpoint;
///      tracing forward from it captures downstream consumers, not the
///      protocol decode upstream of it.
///
/// Returns "" if no functional_txns attribute exists.
static std::string extractRdataSignalFromIR(ModuleOp topModule) {
  std::string result;
  // Skip synthetic fallback names produced by FunctionalBusTxnInfer's
  // deriveSignalName when it can't resolve the SSA value to a real name.
  auto isUsable = [](StringRef s) {
    return !s.empty() && !s.starts_with("unnamed_");
  };

  // First pass: try addr_signal (best for sensitization analysis).
  topModule.walk([&](hw::HWModuleOp hwMod) {
    if (!result.empty())
      return;
    auto txns = hwMod->getAttrOfType<ArrayAttr>("qemu.functional_txns");
    if (!txns)
      return;
    for (Attribute elem : txns) {
      auto dict = dyn_cast<DictionaryAttr>(elem);
      if (!dict)
        continue;
      if (auto sig = dict.getAs<StringAttr>("addr_signal")) {
        if (isUsable(sig.getValue())) {
          result = sig.getValue().str();
          return;
        }
      }
    }
  });
  if (!result.empty())
    return result;
  // Fall back to wdata_signal, then rdata_signal.
  for (StringRef key : {"wdata_signal", "rdata_signal"}) {
    topModule.walk([&](hw::HWModuleOp hwMod) {
      if (!result.empty())
        return;
      auto txns = hwMod->getAttrOfType<ArrayAttr>("qemu.functional_txns");
      if (!txns)
        return;
      for (Attribute elem : txns) {
        auto dict = dyn_cast<DictionaryAttr>(elem);
        if (!dict)
          continue;
        if (auto sig = dict.getAs<StringAttr>(key)) {
          if (isUsable(sig.getValue())) {
            result = sig.getValue().str();
            return;
          }
        }
      }
    });
    if (!result.empty())
      return result;
  }
  return result;
}

/// Collect every name listed under qemu.protocol_constraints across all
/// hw.module ops (deduplicated, comma-separated, suitable for the existing
/// busSignals string-splitter at performReplacements()).
static std::string collectProtocolConstraintsFromIR(ModuleOp topModule) {
  llvm::SmallVector<std::string, 8> names;
  llvm::StringSet<> seen;
  topModule.walk([&](hw::HWModuleOp hwMod) {
    auto cs = hwMod->getAttrOfType<ArrayAttr>("qemu.protocol_constraints");
    if (!cs)
      return;
    for (Attribute elem : cs) {
      auto s = dyn_cast<StringAttr>(elem);
      if (!s)
        continue;
      auto v = s.getValue();
      if (v.empty() || seen.contains(v))
        continue;
      seen.insert(v);
      names.push_back(v.str());
    }
  });
  return llvm::join(names, ",");
}

void ForwardConstrainPass::runOnOperation() {
  ModuleOp topModule = getOperation();

  // ---- Tier 1 (highest priority): qemu.bus_profile from user-supplied bus.json ----
  // BusProfileLoadPass attaches qemu.bus_profile to the top ModuleOp when
  // --bus-profile-load --binding-path=... was run.  When present, the
  // declared roles override CLI flag values; CLI / auto-discover below
  // remain available as escape hatches for designs without a bus.json.
  const bool declaredProfile = topModule->hasAttr("qemu.bus_profile");
  if (auto profile = qemu_passes::BusProfileQuery::fromModule(topModule)) {
    if (auto wr = profile->getSignalName("wr_enable")) {
      this->targetSignal = wr->str();
      llvm::errs() << "[ForwardConstrain] target signal '"
                   << this->targetSignal << "' from qemu.bus_profile\n";
    }
    if (applyConstraints) {
      std::string bus = profile->getNoiseSignalsJoined();
      {
        this->busSignals = bus;
        llvm::errs() << "[ForwardConstrain] noise signals '"
                     << this->busSignals << "' from qemu.bus_profile\n";
      }
    }
  }

  // ---- Tier 2: auto-discover from IR attributes when CLI options are empty ----
  // Order matters: do this BEFORE we capture targetName so the local
  // variable below picks up the discovered value.  CLI always wins.
  if (targetSignal.empty()) {
    std::string discovered = extractRdataSignalFromIR(topModule);
    if (!discovered.empty()) {
      this->targetSignal = discovered;
      llvm::errs() << "[ForwardConstrain] auto-discovered target signal '"
                   << discovered << "' from qemu.functional_txns\n";
    }
  }
  if (applyConstraints && busSignals.empty() && !declaredProfile) {
    std::string discovered = collectProtocolConstraintsFromIR(topModule);
    if (!discovered.empty()) {
      this->busSignals = discovered;
      llvm::errs() << "[ForwardConstrain] auto-discovered bus signals '"
                   << discovered << "' from qemu.protocol_constraints\n";
    } else if (qemu_passes::usesOpenTitanRTLAdapter(topModule)) {
      // Explicit compatibility fallback — OpenTitan TL-UL protocol-noise field names,
      // in BOTH the raw form (matches struct_extract field names before
      // ExplodeStructSigs) AND the post-explode flat form (matches
      // llhd.sig names after ExplodeStructSigs sanitises `tl_i.a_opcode`
      // → `tl_i_a_opcode`).  We list both so this works regardless of
      // pipeline ordering.  Not OT-aware?  Override via CLI flag
      // --fc-bus-signals=...
      this->busSignals =
          "a_opcode,a_param,a_size,a_mask,a_user,"
          "tl_i_a_opcode,tl_i_a_param,tl_i_a_size,tl_i_a_mask,tl_i_a_user";
      llvm::errs() << "[ForwardConstrain] using built-in OpenTitan TL-UL "
                      "default bus signals: " << this->busSignals << "\n";
    }
  }

  StringRef targetName = targetSignal;

  LLVM_DEBUG(llvm::dbgs() << "Starting ForwardConstrainPass targeting signal: "
                          << targetName << "\n");

  // Reset all per-run state
  globalVisited.clear();
  tracedRoots.clear();
  collectedPaths.clear();

  // Phase 1: trace all paths from the target signal and collect constraints
  for (auto hwModule : topModule.getOps<hw::HWModuleOp>()) {
    findTracingRoots(hwModule, targetName);
  }

  // Print structured summary for user inspection (Phase 2 input)
  printCollectedPaths();

  // Enhancement: suggest noise_signals candidates based on Phase 1
  // constraint statistics.  A signal is a strong candidate when it appears
  // with a single consistent value across ≥90% of paths.  Informational
  // only — does NOT change Phase 2 output.
  if (!collectedPaths.empty()) {
    llvm::StringMap<llvm::DenseMap<int, unsigned>> stats;
    for (const auto &record : collectedPaths) {
      llvm::StringSet<> seenInThisPath;
      for (const auto &c : record.resolvedConstraints) {
        if (!seenInThisPath.insert(c.first).second)
          continue;
        stats[c.first][c.second]++;
      }
    }
    const unsigned totalPaths = (unsigned)collectedPaths.size();
    const unsigned threshold = (totalPaths * 9 + 9) / 10; // ceil(90%)

    struct Candidate { StringRef name; int value; unsigned count; };
    SmallVector<Candidate, 8> candidates;
    for (const auto &kv : stats) {
      if (kv.first() == targetSignal)
        continue;
      if (kv.second.size() != 1)
        continue;
      auto [val, count] = *kv.second.begin();
      if (count >= threshold)
        candidates.push_back({kv.first(), val, count});
    }
    if (!candidates.empty()) {
      llvm::sort(candidates, [](const Candidate &a, const Candidate &b) {
        if (a.count != b.count) return a.count > b.count;
        return a.name < b.name;
      });
      llvm::outs() << "\n[ForwardConstrain] Noise candidates (constant value "
                   << "in >=" << threshold << "/" << totalPaths
                   << " paths):\n";
      for (const auto &c : candidates) {
        llvm::outs() << "  - " << c.name << " = " << c.value
                     << "  (" << c.count << "/" << totalPaths << " paths)\n";
      }
      llvm::outs() << "\n  Suggested addition to bus.json noise_signals:\n";
      llvm::outs() << "    \"noise_signals\": [";
      bool first = true;
      for (const auto &c : candidates) {
        if (!first) llvm::outs() << ", ";
        llvm::outs() << "\"" << c.name << "\"";
        first = false;
      }
      llvm::outs() << "]\n";
      llvm::outs() << "  (effect: simplifies IR for downstream passes; does "
                      "NOT change the Phase 2 output above)\n\n";
    }
  }

  // Phase 3: if the user enabled constant replacement via --fc-apply-constraints
  // and specified bus signals (via bus_profile noise_signals or CLI), perform
  // substitution.
  if (applyConstraints)
    performReplacements();

  qemu_passes::writePassReport(
      "forward_constrain",
      [&](llvm::raw_ostream &os) {
        os << "Forward Constraint — summary\n";
        os << "============================\n";
        os << "Target signal: "
           << (targetName.empty() ? StringRef("(none)") : targetName) << "\n";
        os << "Paths collected: " << collectedPaths.size() << "\n";
        os << "Apply-constraints: " << (applyConstraints ? "yes" : "no")
           << "\n";
        StringRef busSigView(busSignals);
        os << "Bus signals to fold: "
           << (busSigView.empty() ? StringRef("(none)") : busSigView) << "\n";
        if (!collectedPaths.empty()) {
          os << "\n-- Per-path targets --\n";
          for (const auto &r : collectedPaths)
            os << "  #" << r.pathIndex << " -> " << r.targetRegister
               << (r.isControlFlowOnly ? " [ctrl-flow]" : "") << "\n";
        }
      });
}

/// Normalise a signal name for tolerant matching.  Different stages of the
/// pipeline use different separators (`.` for struct field paths, `_` after
/// sanitisation for QEMUEmitC).  Reduce both forms to underscores so a
/// target like "reg2hw_rdata_q" matches an llhd.sig named "reg2hw.rdata.q".
static std::string normaliseSigName(StringRef name) {
  std::string out;
  out.reserve(name.size());
  for (char c : name)
    out.push_back(c == '.' ? '_' : c);
  return out;
}

static bool sigNameMatches(StringRef sigName, StringRef targetName) {
  if (sigName == targetName)
    return true;
  return normaliseSigName(sigName) == normaliseSigName(targetName);
}

void ForwardConstrainPass::findTracingRoots(hw::HWModuleOp module, StringRef targetName) {
  // 1. Search module input ports (BlockArguments)
  for (unsigned i = 0, e = module.getNumInputPorts(); i < e; ++i) {
    if (sigNameMatches(module.getInputNameAttr(i).getValue(), targetName)) {
      Value portVal = module.getBodyBlock()->getArgument(i);
      LLVM_DEBUG(llvm::dbgs() << "Found Root [Port]: " << targetName << " in module " << module.getName() << "\n");
      processTracingRoot(portVal);
    }
  }

  // 2. Search internal operations (llhd.sig and hw.struct_extract)
  module.walk([&](Operation *op) {
    if (auto sigOp = dyn_cast<llhd::SignalOp>(op)) {
      auto sigName = sigOp.getName();
      if (sigName && sigNameMatches(*sigName, targetName)) {
        LLVM_DEBUG(llvm::dbgs() << "Found Root [SignalOp]: " << targetName << " in module " << module.getName() << "\n");
        // For llhd.sig, the actual value used in logic is the result of llhd.prb
        for (Operation *user : sigOp.getResult().getUsers()) {
          if (auto prbOp = dyn_cast<llhd::ProbeOp>(user)) {
            processTracingRoot(prbOp.getResult());
          }
        }
      }
    } else if (auto extractOp = dyn_cast<hw::StructExtractOp>(op)) {
      if (sigNameMatches(extractOp.getFieldNameAttr().getValue(), targetName)) {
        LLVM_DEBUG(llvm::dbgs() << "Found Root [StructExtract]: " << targetName << " in module " << module.getName() << "\n");
        processTracingRoot(extractOp.getResult());
      }
    } else if (auto unionExtractOp = dyn_cast<hw::UnionExtractOp>(op)) {
      if (sigNameMatches(unionExtractOp.getFieldNameAttr().getValue(), targetName)) {
        LLVM_DEBUG(llvm::dbgs() << "Found Root [UnionExtract]: " << targetName << " in module " << module.getName() << "\n");
        processTracingRoot(unionExtractOp.getResult());
      }
    } else if (auto wireOp = dyn_cast<hw::WireOp>(op)) {
      auto wireName = wireOp.getName();
      if (wireName && sigNameMatches(*wireName, targetName)) {
        LLVM_DEBUG(llvm::dbgs() << "Found Root [WireOp]: " << targetName << " in module " << module.getName() << "\n");
        processTracingRoot(wireOp.getResult());
      }
    }
  });
}

void ForwardConstrainPass::processTracingRoot(Value rootValue) {
  // Deduplicate: skip if this Value is already being traced (happens when the
  // same port appears in multiple modules and hw.instance cross-propagation
  // would cause the inner module port to be re-traced independently).
  if (!tracedRoots.insert(rootValue).second)
    return;

  // Initial polarity is 1 (active-high). For multi-bit signals polarity is
  // not meaningful but is kept for uniform handling through 1-bit gate logic.
  TraceContext initialCtx(1);
  initialCtx.rootValue = rootValue;

  // Mark multi-bit signals so polarity output is suppressed.
  if (auto intType = dyn_cast<IntegerType>(rootValue.getType()))
    initialCtx.isMultiBit = (intType.getWidth() > 1);

  propagateConstraint(rootValue, initialCtx);
}

// Forward declaration (defined below alongside resolveConstraintsBackward)
static std::string findNamedSignalBackward(Value val);

/// Backward def-use reachability: can we trace from `target` back to `source`?
/// Correctly follows SSA block arguments (phi nodes) through predecessor
/// terminators, so values threaded via cf.cond_br block args are handled.
static bool isDefUseReachable(Value target, Value source,
                               SmallPtrSet<Value, 16> &visited) {
  if (target == source) return true;
  if (!visited.insert(target).second) return false;

  // Handle SSA block arguments (phi nodes): trace each predecessor's
  // corresponding operand. This covers values passed through cf.br /
  // cf.cond_br block argument lists rather than computed by an op.
  if (auto blockArg = dyn_cast<BlockArgument>(target)) {
    Block *block = blockArg.getOwner();
    unsigned argIdx = blockArg.getArgNumber();
    for (Block *pred : block->getPredecessors()) {
      Operation *term = pred->getTerminator();
      if (auto brOp = dyn_cast<cf::BranchOp>(term)) {
        if (argIdx < brOp.getDestOperands().size())
          if (isDefUseReachable(brOp.getDestOperands()[argIdx], source, visited))
            return true;
      } else if (auto condBrOp = dyn_cast<cf::CondBranchOp>(term)) {
        if (condBrOp.getTrueDest() == block &&
            argIdx < condBrOp.getTrueDestOperands().size())
          if (isDefUseReachable(condBrOp.getTrueDestOperands()[argIdx], source, visited))
            return true;
        if (condBrOp.getFalseDest() == block &&
            argIdx < condBrOp.getFalseDestOperands().size())
          if (isDefUseReachable(condBrOp.getFalseDestOperands()[argIdx], source, visited))
            return true;
      }
    }
    return false;
  }

  Operation *defOp = target.getDefiningOp();
  if (!defOp) return false;

  for (Value operand : defOp->getOperands())
    if (isDefUseReachable(operand, source, visited))
      return true;

  return false;
}

void ForwardConstrainPass::reportControlFlowInfluencedDrive(
    Operation *drvOp, const TraceContext &ctx) {
  // Collect the path into persistent storage for Phase 3.
  PathRecord &record = collectPath(drvOp, ctx, /*controlFlowOnly=*/true);

  // Also print the legacy per-path output for backward compatibility.
  std::string constraintsStr;
  llvm::raw_string_ostream os(constraintsStr);
  resolveConstraintNames(ctx.constraints, os);

  std::string sigName = findNamedSignalBackward(
      cast<llhd::DriveOp>(drvOp).getSignal());

  if (ctx.isMultiBit)
    llvm::outs() << "Path -> Hits register/wire drive [ctrl-flow]: " << sigName << "\n";
  else
    llvm::outs() << "Path sensitized to polarity " << ctx.expectedPolarity
                 << " -> Hits register/wire drive [ctrl-flow]: " << sigName << "\n";
  if (!constraintsStr.empty())
    llvm::outs() << "  Requires Constraints: [" << constraintsStr << "]\n";
  else
    llvm::outs() << "  No additional constraints required.\n";
  llvm::outs() << "  Note: driven value does not depend on traced signal\n";
}

void ForwardConstrainPass::traceIntoBlock(
    Block *block, TraceContext ctx,
    SmallPtrSet<Block *, 8> &visitedBlocks) {
  if (!visitedBlocks.insert(block).second) return;

  for (Operation &op : *block) {
    if (auto drvOp = dyn_cast<llhd::DriveOp>(&op)) {
      Value drivenVal = drvOp.getValue();
      SmallPtrSet<Value, 16> reachVisited;
      bool valueFromRoot =
          ctx.rootValue && isDefUseReachable(drivenVal, ctx.rootValue, reachVisited);

      if (valueFromRoot) {
        // Driven value directly depends on the traced signal: real causal write.
        reportPathSatisfiability(drvOp, ctx);
      } else {
        // Driven value does NOT depend on the traced signal.
        // Determine whether the driven value is a zero/false constant:
        // such drives are "register reset to default" appearing in false branches
        // of inactive conditions and carry no information about the traced path.
        bool isZeroConst = false;
        if (auto constOp =
                dyn_cast_or_null<hw::ConstantOp>(drivenVal.getDefiningOp()))
          isZeroConst = constOp.getValue().isZero();

        if (!isZeroConst) {
          // Non-zero ctrl-flow drive: the traced signal controls WHETHER this
          // register is written (even though the data doesn't come from it).
          reportControlFlowInfluencedDrive(drvOp, ctx);

          // Two-phase write-enable pattern: when the traced signal asserts a 1-bit
          // write-enable wire to constant-true, follow its probes into the
          // downstream register-update process.
          auto inoutTy = dyn_cast<llhd::RefType>(drvOp.getSignal().getType());
          bool isConstTrue = false;
          if (auto constOp =
                  dyn_cast_or_null<hw::ConstantOp>(drivenVal.getDefiningOp()))
            isConstTrue = constOp.getValue().isAllOnes();
          if (inoutTy && inoutTy.getNestedType().isInteger(1) && isConstTrue) {
            Value sigVal = drvOp.getSignal();
            for (Operation *sigUser : sigVal.getUsers()) {
              if (auto prbOp = dyn_cast<llhd::ProbeOp>(sigUser))
                propagateConstraint(prbOp.getResult(), ctx);
            }
          }
        }
      }

    } else if (auto brOp = dyn_cast<cf::BranchOp>(&op)) {
      // Unconditional branch: follow into successor
      traceIntoBlock(brOp.getDest(), ctx, visitedBlocks);

    } else if (auto innerCondBr = dyn_cast<cf::CondBranchOp>(&op)) {
      SmallPtrSet<Value, 16> visited;
      if (ctx.rootValue &&
          isDefUseReachable(innerCondBr.getCondition(), ctx.rootValue, visited)) {
        // Nested branch also controlled by rootValue: split polarity
        TraceContext falseCtx = ctx;
        falseCtx.expectedPolarity = 1 - falseCtx.expectedPolarity;
        traceIntoBlock(innerCondBr.getTrueDest(),  ctx,      visitedBlocks);
        traceIntoBlock(innerCondBr.getFalseDest(), falseCtx, visitedBlocks);
      } else {
        // Nested branch whose condition is NOT derived from the traced signal
        traceIntoBlock(innerCondBr.getTrueDest(),  ctx, visitedBlocks);
        traceIntoBlock(innerCondBr.getFalseDest(), ctx, visitedBlocks);
      }
    }
    // llhd.wait and other terminators: do not follow (prevents loop-header re-entry)
  }
}

void ForwardConstrainPass::propagateConstraint(Value currentVal, TraceContext ctx) {
  // Trace through all users of the current value
  for (Operation *user : currentVal.getUsers()) {
    // Basic cycle detection to prevent infinite loops in combinational cycles
    if (std::find(ctx.paths.begin(), ctx.paths.end(), user) != ctx.paths.end())
      continue;

    TraceContext nextCtx = ctx;
    nextCtx.paths.push_back(user);

    if (auto extractOp = dyn_cast<hw::StructExtractOp>(user)) {
      if (ctx.trackedFieldName &&
          extractOp.getFieldNameAttr().getValue() != *ctx.trackedFieldName)
        continue;
      TraceContext extractCtx = nextCtx;
      extractCtx.trackedFieldName = std::nullopt;
      propagateConstraint(extractOp.getResult(), extractCtx);
    } else if (auto structCreateOp = dyn_cast<hw::StructCreateOp>(user)) {
      if (auto structType =
              dyn_cast<hw::StructType>(structCreateOp.getResult().getType())) {
        auto elements = structType.getElements();
        for (unsigned i = 0; i < (unsigned)structCreateOp.getNumOperands() &&
                             i < (unsigned)elements.size(); ++i) {
          if (structCreateOp.getOperand(i) == currentVal) {
            TraceContext fieldCtx = nextCtx;
            fieldCtx.trackedFieldName = elements[i].name.str();
            propagateConstraint(structCreateOp.getResult(), fieldCtx);
            break;
          }
        }
      }
    } else if (auto unionExtractOp = dyn_cast<hw::UnionExtractOp>(user)) {
      propagateConstraint(unionExtractOp.getResult(), nextCtx);
    } else if (auto unionCreateOp = dyn_cast<hw::UnionCreateOp>(user)) {
      propagateConstraint(unionCreateOp.getResult(), nextCtx);
    } else if (auto sigExtractOp = dyn_cast<llhd::SigExtractOp>(user)) {
      propagateConstraint(sigExtractOp.getResult(), nextCtx);
    } else if (auto andOp = dyn_cast<comb::AndOp>(user)) {
      for (Value opnd : andOp.getOperands()) {
        if (opnd != currentVal) {
          auto intType = dyn_cast<IntegerType>(opnd.getType());
          nextCtx.constraints[opnd] =
              (intType && intType.getWidth() == 1) ? 1 : -1;
        }
      }
      propagateConstraint(andOp.getResult(), nextCtx);
    } else if (auto orOp = dyn_cast<comb::OrOp>(user)) {
      for (Value opnd : orOp.getOperands()) {
        if (opnd != currentVal) {
          nextCtx.constraints[opnd] = 0;
        }
      }
      propagateConstraint(orOp.getResult(), nextCtx);
    } else if (auto xorOp = dyn_cast<comb::XorOp>(user)) {
      bool isOneBit = currentVal.getType().isInteger(1);
      bool hasConstAllOnes = false;
      for (Value opnd : xorOp.getOperands()) {
        if (opnd != currentVal) {
          if (auto constOp = dyn_cast_or_null<hw::ConstantOp>(opnd.getDefiningOp())) {
            if (constOp.getValue().isAllOnes()) hasConstAllOnes = true;
          } else {
            nextCtx.constraints[opnd] = 0;
          }
        }
      }
      if (isOneBit && hasConstAllOnes)
        nextCtx.expectedPolarity = 1 - nextCtx.expectedPolarity;
      propagateConstraint(xorOp.getResult(), nextCtx);
    } else if (auto muxOp = dyn_cast<comb::MuxOp>(user)) {
      if (currentVal == muxOp.getCond()) {
        propagateConstraint(muxOp.getResult(), nextCtx);
      } else if (currentVal == muxOp.getTrueValue()) {
        nextCtx.constraints[muxOp.getCond()] = 1;
        propagateConstraint(muxOp.getResult(), nextCtx);
      } else if (currentVal == muxOp.getFalseValue()) {
        nextCtx.constraints[muxOp.getCond()] = 0;
        propagateConstraint(muxOp.getResult(), nextCtx);
      }
    } else if (auto icmpOp = dyn_cast<comb::ICmpOp>(user)) {
      if (icmpOp.getPredicate() == comb::ICmpPredicate::eq ||
          icmpOp.getPredicate() == comb::ICmpPredicate::ceq ||
          icmpOp.getPredicate() == comb::ICmpPredicate::weq) {
        for (Value opnd : icmpOp.getOperands()) {
          if (opnd != currentVal) {
            if (auto constOp = dyn_cast_or_null<hw::ConstantOp>(opnd.getDefiningOp())) {
              int64_t constVal = constOp.getValue().getSExtValue();
              if (constOp.getValue().isZero())
                nextCtx.expectedPolarity = 1 - nextCtx.expectedPolarity;
              nextCtx.constraints[currentVal] = constVal;
            }
          }
        }
      } else if (icmpOp.getPredicate() == comb::ICmpPredicate::ne ||
                 icmpOp.getPredicate() == comb::ICmpPredicate::cne ||
                 icmpOp.getPredicate() == comb::ICmpPredicate::wne) {
        for (Value opnd : icmpOp.getOperands()) {
          if (opnd != currentVal) {
            if (auto constOp = dyn_cast_or_null<hw::ConstantOp>(opnd.getDefiningOp())) {
              if (constOp.getValue().isAllOnes())
                nextCtx.expectedPolarity = 1 - nextCtx.expectedPolarity;
            }
          }
        }
      }
      propagateConstraint(icmpOp.getResult(), nextCtx);
    } else if (auto drvOp = dyn_cast<llhd::DriveOp>(user)) {
      Value drivenVal = drvOp.getValue();
      SmallPtrSet<Value, 16> reachVisited;
      bool valueFromRoot =
          nextCtx.rootValue &&
          isDefUseReachable(drivenVal, nextCtx.rootValue, reachVisited);

      if (valueFromRoot) {
        reportPathSatisfiability(drvOp, nextCtx);
        // Direct data-flow drive: always follow probes so the signal's value
        // can continue flowing through the rest of the design.
        Value sigVal = drvOp.getSignal();
        for (Operation *sigUser : sigVal.getUsers()) {
          if (auto prbOp = dyn_cast<llhd::ProbeOp>(sigUser)) {
            tracedRoots.insert(prbOp.getResult());
            propagateConstraint(prbOp.getResult(), nextCtx);
          }
        }
      } else {
        bool isZeroConst = false;
        if (auto constOp =
                dyn_cast_or_null<hw::ConstantOp>(drivenVal.getDefiningOp()))
          isZeroConst = constOp.getValue().isZero();

        if (!isZeroConst) {
          reportControlFlowInfluencedDrive(drvOp, nextCtx);
          // Two-phase write-enable: only follow probes when the signal is a
          // 1-bit write-enable being driven with constant true.
          auto inoutTy = dyn_cast<llhd::RefType>(drvOp.getSignal().getType());
          bool isConstTrue = false;
          if (auto constOp =
                  dyn_cast_or_null<hw::ConstantOp>(drivenVal.getDefiningOp()))
            isConstTrue = constOp.getValue().isAllOnes();
          if (inoutTy && inoutTy.getNestedType().isInteger(1) && isConstTrue) {
            Value sigVal = drvOp.getSignal();
            for (Operation *sigUser : sigVal.getUsers()) {
              if (auto prbOp = dyn_cast<llhd::ProbeOp>(sigUser)) {
                tracedRoots.insert(prbOp.getResult());
                propagateConstraint(prbOp.getResult(), nextCtx);
              }
            }
          }
        }
      }
    } else if (auto condBrOp = dyn_cast<cf::CondBranchOp>(user)) {
      if (currentVal == condBrOp.getCondition()) {
        SmallPtrSet<Block *, 8> visitedBlocks;
        TraceContext falseCtx = nextCtx;
        falseCtx.expectedPolarity = 1 - falseCtx.expectedPolarity;
        traceIntoBlock(condBrOp.getTrueDest(),  nextCtx,  visitedBlocks);
        traceIntoBlock(condBrOp.getFalseDest(), falseCtx, visitedBlocks);
      } else {
        auto trueOps  = condBrOp.getTrueDestOperands();
        auto falseOps = condBrOp.getFalseDestOperands();

        for (unsigned i = 0; i < trueOps.size(); ++i)
          if (trueOps[i] == currentVal)
            propagateConstraint(condBrOp.getTrueDest()->getArgument(i), nextCtx);

        for (unsigned i = 0; i < falseOps.size(); ++i)
          if (falseOps[i] == currentVal)
            propagateConstraint(condBrOp.getFalseDest()->getArgument(i), nextCtx);
      }
    } else if (auto extractOp = dyn_cast<comb::ExtractOp>(user)) {
      TraceContext extractCtx = nextCtx;
      if (auto resultType = dyn_cast<IntegerType>(extractOp.getResult().getType()))
        extractCtx.isMultiBit = (resultType.getWidth() > 1);
      propagateConstraint(extractOp.getResult(), extractCtx);
    } else if (auto concatOp = dyn_cast<comb::ConcatOp>(user)) {
      TraceContext concatCtx = nextCtx;
      if (auto resultType = dyn_cast<IntegerType>(concatOp.getResult().getType()))
        concatCtx.isMultiBit = (resultType.getWidth() > 1);
      propagateConstraint(concatOp.getResult(), concatCtx);
    } else if (auto instOp = dyn_cast<hw::InstanceOp>(user)) {
      // Inbound boundary crossing (caller → callee).
      // currentVal is an operand of an instance call; propagate into the
      // callee's body starting from the corresponding input BlockArgument.
      for (unsigned i = 0; i < instOp.getNumOperands(); ++i) {
        if (instOp.getOperand(i) == currentVal) {
          auto targetMod = dyn_cast_or_null<hw::HWModuleOp>(
              SymbolTable::lookupNearestSymbolFrom(instOp, instOp.getModuleNameAttr()));
          if (targetMod) {
            Value portVal = targetMod.getBodyBlock()->getArgument(i);
            if (!tracedRoots.insert(portVal).second)
              continue;
            TraceContext innerCtx = nextCtx;
            innerCtx.rootValue = portVal;
            propagateConstraint(portVal, innerCtx);
          }
        }
      }
    } else if (auto outOp = dyn_cast<hw::OutputOp>(user)) {
      // Outbound boundary crossing (callee → caller).
      // currentVal is an operand of a hw.output (i.e., it leaves this
      // module via output port i).  In every parent that instantiates
      // this module, the i-th instance result represents this same value.
      // Continue tracing from that result in each caller's context.
      auto callee = dyn_cast_or_null<hw::HWModuleOp>(outOp->getParentOp());
      if (!callee)
        continue;
      ModuleOp topMod = callee->getParentOfType<ModuleOp>();
      if (!topMod)
        continue;
      StringRef calleeName = callee.getName();
      for (unsigned i = 0; i < outOp.getNumOperands(); ++i) {
        if (outOp.getOperand(i) != currentVal)
          continue;
        unsigned outIdx = i;
        topMod.walk([&](hw::InstanceOp callerInst) {
          if (callerInst.getModuleName() != calleeName)
            return;
          if (outIdx >= callerInst.getNumResults())
            return;
          Value ascended = callerInst.getResult(outIdx);
          if (!tracedRoots.insert(ascended).second)
            return;
          TraceContext outerCtx = nextCtx;
          outerCtx.rootValue = ascended;
          propagateConstraint(ascended, outerCtx);
        });
      }
    } else {
      // Fallback: passively propagate through other elements (e.g. llhd.prb, etc.)
      for (Value res : user->getResults()) {
        propagateConstraint(res, nextCtx);
      }
    }
  }
}

static std::string getSSAValueName(Value val) {
  if (!val) return "";
  if (auto opResult = dyn_cast<OpResult>(val)) {
    Operation *defOp = opResult.getDefiningOp();
    if (!defOp) return "";
    std::string opStr;
    llvm::raw_string_ostream os(opStr);
    defOp->print(os, OpPrintingFlags().useLocalScope());
    os.flush();
    if (defOp->getNumResults() == 1) {
      size_t eqPos = opStr.find(" = ");
      if (eqPos != std::string::npos && opStr.length() > 1 && opStr[0] == '%') {
        std::string name = opStr.substr(1, eqPos - 1);
        if (!name.empty() && !std::all_of(name.begin(), name.end(), ::isdigit)) {
          return name;
        }
      }
    }
  }
  return "";
}

static void resolveConstraintsBackward(Value val, int reqVal, SmallVectorImpl<std::pair<std::string, int>> &result) {
  if (!val) return;

  if (auto arg = dyn_cast<BlockArgument>(val)) {
    if (auto hwMod = dyn_cast<hw::HWModuleOp>(arg.getParentRegion()->getParentOp())) {
      if (arg.getArgNumber() < hwMod.getNumInputPorts()) {
        result.push_back({hwMod.getInputNameAttr(arg.getArgNumber()).getValue().str(), reqVal});
        return;
      }
    }
  }

  Operation *defOp = val.getDefiningOp();
  if (!defOp) {
    result.push_back({"anonymous", reqVal});
    return;
  }

  if (auto wireOp = dyn_cast<hw::WireOp>(defOp)) {
    if (auto name = wireOp.getName()) {
      result.push_back({name->str(), reqVal});
      return;
    }
  }
  if (auto sigOp = dyn_cast<llhd::SignalOp>(defOp)) {
    if (auto name = sigOp.getName()) {
      result.push_back({name->str(), reqVal});
      return;
    }
  }
  if (auto prbOp = dyn_cast<llhd::ProbeOp>(defOp)) {
    resolveConstraintsBackward(prbOp.getSignal(), reqVal, result);
    return;
  }
  if (auto extractOp = dyn_cast<hw::StructExtractOp>(defOp)) {
    result.push_back({extractOp.getFieldNameAttr().getValue().str(), reqVal});
    return;
  }
  if (auto unionExtractOp = dyn_cast<hw::UnionExtractOp>(defOp)) {
    result.push_back({unionExtractOp.getFieldNameAttr().getValue().str(), reqVal});
    return;
  }
  if (auto unionCreateOp = dyn_cast<hw::UnionCreateOp>(defOp)) {
    resolveConstraintsBackward(unionCreateOp.getInput(), reqVal, result);
    return;
  }
  if (auto ex = dyn_cast<llhd::SigExtractOp>(defOp)) {
    resolveConstraintsBackward(ex.getInput(), reqVal, result);
    return;
  }

  // --- Recursive Combinational Logic Expansion ---
  if (auto andOp = dyn_cast<comb::AndOp>(defOp)) {
    if (reqVal == 1) {
      for (Value opnd : andOp.getOperands()) {
        resolveConstraintsBackward(opnd, 1, result);
      }
      return;
    }
  }
  if (auto orOp = dyn_cast<comb::OrOp>(defOp)) {
    if (reqVal == 0) {
      for (Value opnd : orOp.getOperands()) {
        resolveConstraintsBackward(opnd, 0, result);
      }
      return;
    }
  }
  if (auto icmpOp = dyn_cast<comb::ICmpOp>(defOp)) {
    Value lhs = icmpOp.getLhs();
    Value rhs = icmpOp.getRhs();

    auto lhsConst = dyn_cast_or_null<hw::ConstantOp>(lhs.getDefiningOp());
    auto rhsConst = dyn_cast_or_null<hw::ConstantOp>(rhs.getDefiningOp());

    if (lhsConst || rhsConst) {
      Value varOpnd = lhsConst ? rhs : lhs;
      hw::ConstantOp constOp = lhsConst ? lhsConst : rhsConst;

      int targetVal = constOp.getValue().getSExtValue();

      if (reqVal == 1) {
        switch (icmpOp.getPredicate()) {
          case comb::ICmpPredicate::eq:
          case comb::ICmpPredicate::ceq:
          case comb::ICmpPredicate::weq:
            resolveConstraintsBackward(varOpnd, targetVal, result);
            return;
          case comb::ICmpPredicate::ne:
          case comb::ICmpPredicate::cne:
          case comb::ICmpPredicate::wne:
            break;
          default:
            break;
        }
      } else if (reqVal == 0) {
        switch (icmpOp.getPredicate()) {
          case comb::ICmpPredicate::eq:
          case comb::ICmpPredicate::ceq:
          case comb::ICmpPredicate::weq: {
            SmallVector<std::pair<std::string, int>, 1> dummy;
            resolveConstraintsBackward(varOpnd, targetVal, dummy);
            if (!dummy.empty()) {
              result.push_back({dummy[0].first + "_neq", targetVal});
              return;
            }
            break;
          }
          default:
            break;
        }
      }
    }
  }
  if (auto xorOp = dyn_cast<comb::XorOp>(defOp)) {
    Value otherOpnd = nullptr;
    bool isNot = false;
    for (Value opnd : xorOp.getOperands()) {
      if (auto constOp = dyn_cast_or_null<hw::ConstantOp>(opnd.getDefiningOp())) {
        if (constOp.getValue().isAllOnes()) {
          isNot = true;
          continue;
        }
      }
      otherOpnd = opnd;
    }
    if (isNot && otherOpnd) {
      resolveConstraintsBackward(otherOpnd, 1 - reqVal, result);
      return;
    }
  }

  std::string parsedName = getSSAValueName(val);
  if (!parsedName.empty()) {
    result.push_back({parsedName, reqVal});
    return;
  }

  LLVM_DEBUG(llvm::dbgs() << "Failed to resolve name for: " << val << "\n");
  result.push_back({"anonymous", reqVal});
}

static std::string findNamedSignalBackward(Value val) {
  SmallVector<std::pair<std::string, int>, 1> dummy;
  resolveConstraintsBackward(val, 0, dummy);
  if (!dummy.empty()) return dummy[0].first;
  return "anonymous";
}

void ForwardConstrainPass::resolveConstraintNames(const DenseMap<Value, int> &constraints, llvm::raw_string_ostream &os) {
  SmallVector<std::pair<std::string, int>, 8> flattened;
  for (const auto &pair : constraints) {
    resolveConstraintsBackward(pair.first, pair.second, flattened);
  }

  // Collect positive constraints (name -> value) for redundancy elimination.
  llvm::StringMap<int> positiveConstraints;
  for (const auto &item : flattened) {
    if (item.first.find("_neq") == std::string::npos)
      positiveConstraints[item.first] = item.second;
  }

  // Deduplicate and filter redundant _neq entries.
  llvm::StringSet<> seen;
  bool first = true;
  for (const auto &item : flattened) {
    const std::string &name = item.first;
    int val = item.second;

    if (name.size() > 4 && name.substr(name.size() - 4) == "_neq") {
      std::string baseName = name.substr(0, name.size() - 4);
      auto it = positiveConstraints.find(baseName);
      if (it != positiveConstraints.end() && it->second != val)
        continue;
    }

    std::string key = name + "=" + std::to_string(val);
    if (seen.insert(key).second) {
      if (!first) os << ", ";
      os << name << " = " << val;
      first = false;
    }
  }
}

// ---------------------------------------------------------------------------
// PathRecord collection: bridges Phase 1 analysis to Phase 3 replacement
// ---------------------------------------------------------------------------

PathRecord &ForwardConstrainPass::collectPath(
    Operation *endpoint, const TraceContext &ctx, bool controlFlowOnly) {
  PathRecord record;
  record.pathIndex = collectedPaths.size();
  record.endpoint = endpoint;
  record.expectedPolarity = ctx.expectedPolarity;
  record.isControlFlowOnly = controlFlowOnly;
  record.isMultiBit = ctx.isMultiBit;
  record.path = ctx.paths;

  // Preserve the raw Value-level constraints for Phase 3 IR rewriting.
  record.constraints = ctx.constraints;

  // Resolve target register name.
  if (auto drvOp = dyn_cast<llhd::DriveOp>(endpoint))
    record.targetRegister = findNamedSignalBackward(drvOp.getSignal());
  else if (auto condBrOp = dyn_cast<cf::CondBranchOp>(endpoint))
    record.targetRegister =
        "cf_branch@" +
        condBrOp->getBlock()->getParentOp()->getName().getStringRef().str();
  else
    record.targetRegister = "unknown";

  // Build the resolved (name, value) pairs once, so Phase 3 can match
  // user-provided signal names by string comparison.
  for (const auto &pair : ctx.constraints)
    resolveConstraintsBackward(pair.first, pair.second,
                               record.resolvedConstraints);

  // Deduplicate resolved constraints (same logic as resolveConstraintNames).
  {
    llvm::StringMap<int> positiveConstraints;
    for (const auto &item : record.resolvedConstraints)
      if (item.first.find("_neq") == std::string::npos)
        positiveConstraints[item.first] = item.second;

    SmallVector<std::pair<std::string, int>, 8> deduped;
    llvm::StringSet<> seen;
    for (const auto &item : record.resolvedConstraints) {
      const std::string &name = item.first;
      int val = item.second;

      if (name.size() > 4 && name.substr(name.size() - 4) == "_neq") {
        std::string baseName = name.substr(0, name.size() - 4);
        auto it = positiveConstraints.find(baseName);
        if (it != positiveConstraints.end() && it->second != val)
          continue;
      }

      std::string key = name + "=" + std::to_string(val);
      if (seen.insert(key).second)
        deduped.push_back({name, val});
    }
    record.resolvedConstraints = std::move(deduped);
  }

  collectedPaths.push_back(std::move(record));
  return collectedPaths.back();
}

void ForwardConstrainPass::printCollectedPaths() {
  if (collectedPaths.empty()) {
    llvm::outs() << "No paths found for target signal.\n";
    return;
  }

  llvm::outs() << "\n";
  llvm::outs() << "====== Forward Constrain Analysis Results ======\n";
  llvm::outs() << "Total paths collected: " << collectedPaths.size() << "\n";
  llvm::outs() << "\n";

  for (const auto &record : collectedPaths) {
    llvm::outs() << "--- Path #" << record.pathIndex << " ---\n";

    // Target and type
    llvm::outs() << "  Target: " << record.targetRegister;
    if (record.isControlFlowOnly)
      llvm::outs() << " [ctrl-flow]";
    llvm::outs() << "\n";

    // Polarity (only meaningful for 1-bit signals)
    if (!record.isMultiBit)
      llvm::outs() << "  Polarity: " << record.expectedPolarity << "\n";

    // Constraints
    if (record.resolvedConstraints.empty()) {
      llvm::outs() << "  Constraints: (none)\n";
    } else {
      llvm::outs() << "  Constraints:\n";
      for (const auto &c : record.resolvedConstraints) {
        llvm::outs() << "    " << c.first << " = " << c.second << "\n";
      }
    }

    if (record.isControlFlowOnly)
      llvm::outs() << "  Note: driven value does not depend on traced signal\n";

    llvm::outs() << "\n";
  }

  // Print signal summary: all unique signal names appearing across all paths
  // with the set of values they take.  This is the view the user needs to
  // decide which signals are irrelevant bus signals.
  llvm::outs() << "====== Signal Constraint Summary ======\n";
  llvm::StringMap<llvm::SmallSet<int, 4>> signalValues;
  llvm::StringMap<unsigned> signalPathCount;
  for (const auto &record : collectedPaths) {
    for (const auto &c : record.resolvedConstraints) {
      signalValues[c.first].insert(c.second);
      signalPathCount[c.first]++;
    }
  }
  for (const auto &entry : signalValues) {
    llvm::outs() << "  " << entry.first() << ": appears in "
                 << signalPathCount[entry.first()] << " path(s), values = {";
    bool first = true;
    for (int v : entry.second) {
      if (!first) llvm::outs() << ", ";
      llvm::outs() << v;
      first = false;
    }
    llvm::outs() << "}\n";
  }
  llvm::outs() << "================================================\n\n";
}

void ForwardConstrainPass::reportPathSatisfiability(Operation *terminator, const TraceContext &ctx) {
  // Collect the path into persistent storage for Phase 3.
  PathRecord &record = collectPath(terminator, ctx, /*controlFlowOnly=*/false);

  // Also print the legacy per-path output for backward compatibility.
  std::string constraintsStr;
  llvm::raw_string_ostream os(constraintsStr);
  resolveConstraintNames(ctx.constraints, os);

  std::string targetMsg;
  if (auto drvOp = dyn_cast<llhd::DriveOp>(terminator)) {
    targetMsg = "Hits register/wire drive: " + findNamedSignalBackward(drvOp.getSignal());
  } else if (auto condBrOp = dyn_cast<cf::CondBranchOp>(terminator)) {
    targetMsg = "Hits control flow branch at " + condBrOp->getBlock()->getParentOp()->getName().getStringRef().str();
  } else {
    targetMsg = "Hits unknown endpoint";
  }

  if (ctx.isMultiBit)
    llvm::outs() << "Path -> " << targetMsg << "\n";
  else
    llvm::outs() << "Path sensitized to polarity " << ctx.expectedPolarity << " -> " << targetMsg << "\n";
  if (!constraintsStr.empty()) {
    llvm::outs() << "  Requires Constraints: [" << constraintsStr << "]\n";
  } else {
    llvm::outs() << "  No additional constraints required.\n";
  }
}

// ===========================================================================
// Phase 3: Constant replacement engine
// ===========================================================================

void ForwardConstrainPass::performReplacements() {
  if (busSignals.empty()) {
    llvm::outs() << "\n--fc-apply-constraints is set but --fc-bus-signals is "
                    "empty. Nothing to replace.\n";
    return;
  }

  ModuleOp topModule = getOperation();

  // Parse comma-separated signal names.
  SmallVector<StringRef, 8> signalNames;
  StringRef(busSignals).split(signalNames, ',', /*MaxSplit=*/-1,
                               /*KeepEmpty=*/false);

  llvm::outs() << "\n====== Phase 3: Constant Replacement ======\n";

  bool anyReplaced = false;
  for (StringRef sigName : signalNames) {
    sigName = sigName.trim();
    if (sigName.empty())
      continue;

    // Step 1: determine what constant this signal should be replaced with
    //         (derived from Phase 1 collected constraints).
    auto replValue = determineReplacementValue(sigName);
    if (!replValue)
      continue;

    // Step 2: find and replace in every HW module.
    for (auto hwModule : topModule.getOps<hw::HWModuleOp>()) {
      replaceSignalInModule(hwModule, sigName, *replValue);
    }
    anyReplaced = true;
  }

  // Step 3: run canonicalization + DCE to fold constants and remove dead code.
  if (anyReplaced) {
    llvm::outs() << "\nRunning canonicalization and dead code elimination...\n";
    runCanonicalization();
    llvm::outs() << "Canonicalization complete.\n";
  }

  llvm::outs() << "================================================\n\n";
}

std::optional<int>
ForwardConstrainPass::determineReplacementValue(StringRef signalName) {
  llvm::SmallSet<int, 4> values;
  unsigned pathCount = 0;

  // Tolerant matching: collected constraint names are in their original
  // form (often dotted, e.g. "tl_i.a_opcode"), while bus signal lists may
  // come from sanitised QEMUEmitC output (underscored, "tl_i_a_opcode").
  // Normalise both sides before comparison.
  std::string targetNorm = normaliseSigName(signalName);

  for (const auto &record : collectedPaths) {
    for (const auto &c : record.resolvedConstraints) {
      if (normaliseSigName(c.first) == targetNorm) {
        values.insert(c.second);
        pathCount++;
      }
    }
  }

  if (pathCount == 0) {
    llvm::outs() << "Warning: signal '" << signalName
                 << "' not found in any path constraints. Skipping.\n";
    return std::nullopt;
  }

  if (values.size() > 1) {
    llvm::outs() << "Warning: signal '" << signalName
                 << "' requires different values across paths: {";
    bool first = true;
    for (int v : values) {
      if (!first)
        llvm::outs() << ", ";
      llvm::outs() << v;
      first = false;
    }
    llvm::outs() << "}. This signal may not be truly irrelevant. Skipping.\n";
    return std::nullopt;
  }

  int constVal = *values.begin();
  llvm::outs() << "Signal '" << signalName << "': uniform value " << constVal
               << " across " << pathCount << " path(s).\n";
  return constVal;
}

SmallVector<Value, 4>
ForwardConstrainPass::findSignalValues(hw::HWModuleOp module,
                                        StringRef signalName) {
  SmallVector<Value, 4> results;

  // Use tolerant name matching (normalises "." vs "_") so a bus-signal
  // list referring to "tl_i_a_opcode" matches an llhd.sig named
  // "tl_i.a_opcode" left over by ExplodeStructSigs.

  // 1. Module input ports (BlockArguments) — the most common case for bus
  //    signals like psel, penable, etc.
  for (unsigned i = 0, e = module.getNumInputPorts(); i < e; ++i) {
    if (sigNameMatches(module.getInputNameAttr(i).getValue(), signalName)) {
      results.push_back(module.getBodyBlock()->getArgument(i));
    }
  }

  // 2. Internal named signals and extractions.
  module.walk([&](Operation *op) {
    if (auto sigOp = dyn_cast<llhd::SignalOp>(op)) {
      auto sigName = sigOp.getName();
      if (sigName && sigNameMatches(*sigName, signalName)) {
        // For llhd.sig the logic-side value is the result of llhd.prb.
        for (Operation *user : sigOp.getResult().getUsers()) {
          if (auto prbOp = dyn_cast<llhd::ProbeOp>(user))
            results.push_back(prbOp.getResult());
        }
      }
    } else if (auto extractOp = dyn_cast<hw::StructExtractOp>(op)) {
      if (sigNameMatches(extractOp.getFieldNameAttr().getValue(), signalName))
        results.push_back(extractOp.getResult());
    } else if (auto unionExtractOp = dyn_cast<hw::UnionExtractOp>(op)) {
      if (sigNameMatches(unionExtractOp.getFieldNameAttr().getValue(), signalName))
        results.push_back(unionExtractOp.getResult());
    } else if (auto wireOp = dyn_cast<hw::WireOp>(op)) {
      auto wireName = wireOp.getName();
      if (wireName && sigNameMatches(*wireName, signalName))
        results.push_back(wireOp.getResult());
    }
  });

  return results;
}

void ForwardConstrainPass::replaceSignalInModule(hw::HWModuleOp module,
                                                  StringRef signalName,
                                                  int constValue) {
  SmallVector<Value, 4> signalValues = findSignalValues(module, signalName);
  if (signalValues.empty())
    return;

  OpBuilder builder(module.getContext());

  for (Value val : signalValues) {
    // We can only replace integer-typed values with hw.constant.
    // InOutType values (llhd signals) cannot be directly replaced — we
    // replace their llhd.prb results instead (handled by findSignalValues).
    auto intType = dyn_cast<IntegerType>(val.getType());
    if (!intType) {
      LLVM_DEBUG(llvm::dbgs()
                 << "Skipping non-integer-typed signal: " << signalName
                 << " (type: " << val.getType() << ")\n");
      continue;
    }

    // Skip values with no uses to avoid creating dead constants.
    if (val.use_empty())
      continue;

    // Create the replacement constant at the beginning of the module body
    // so it dominates all uses.
    builder.setInsertionPointToStart(module.getBodyBlock());
    APInt constAPInt(intType.getWidth(),
                     static_cast<uint64_t>(constValue),
                     /*isSigned=*/constValue < 0);
    auto constOp = builder.create<hw::ConstantOp>(module.getLoc(), constAPInt);

    // Replace ALL uses of this signal value with the constant.
    val.replaceAllUsesWith(constOp.getResult());

    llvm::outs() << "  Replaced '" << signalName << "' (i"
                 << intType.getWidth() << ") with constant " << constValue
                 << " in module " << module.getName() << "\n";
  }
}

void ForwardConstrainPass::runCanonicalization() {
  MLIRContext *ctx = &getContext();
  RewritePatternSet patterns(ctx);

  // Collect canonicalization patterns from all loaded dialects.
  // This covers comb, hw, llhd, cf, and any other dialect in the IR.
  // After constant replacement, typical folds include:
  //   comb.and(1, x) -> x
  //   comb.or(0, x)  -> x
  //   comb.icmp eq(const, const) -> const bool
  //   cf.cond_br(true, ...) -> cf.br(...)
  //   dead block elimination
  for (auto *dialect : ctx->getLoadedDialects())
    dialect->getCanonicalizationPatterns(patterns);

  // Also collect patterns registered on individual operations.
  for (RegisteredOperationName op : ctx->getRegisteredOperations())
    op.getCanonicalizationPatterns(patterns, ctx);

  GreedyRewriteConfig config;

  if (failed(applyPatternsGreedily(getOperation(), std::move(patterns),
                                    config))) {
    llvm::outs() << "Warning: canonicalization did not converge.\n";
  }
}

} // end anonymous namespace