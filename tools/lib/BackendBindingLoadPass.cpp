#include "RTLAdapter.h"
//===- BackendBindingLoadPass.cpp - Declarative backend role binding ------===//
//
// Loads a <peripheral>.binding.json (path via --binding-path) that DECLARES the
// backend roles (chardev TX/RX FIFOs + MMIO pivots, interrupt register offsets)
// instead of pattern-matching OpenTitan primitive names.  This is the generic /
// AI-fillable counterpart to BackendCharDevDetectPass: an AI (or a human) reads
// an IR digest + the role schema and produces this JSON; this pass validates it
// against the IR and attaches the SAME qemu.chardev_blueprint / qemu.irq_blueprint
// attributes the detector emits (via the shared builders in BackendBlueprint.h),
// so the emission side (generateQpShim) is byte-for-byte unchanged.
//
// Schema: see bindings/SCHEMA.md and bindings/uart.binding.json.
//
//===----------------------------------------------------------------------===//

#include "BackendBlueprint.h"
#include "mlir/IR/BuiltinAttributes.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/Pass/Pass.h"

#include "circt/Dialect/HW/HWOps.h"

#include "llvm/ADT/DenseSet.h"
#include "llvm/Support/JSON.h"
#include "llvm/Support/MemoryBuffer.h"
#include "llvm/Support/raw_ostream.h"

#define GEN_PASS_DECL_BACKENDBINDINGLOAD
#define GEN_PASS_DEF_BACKENDBINDINGLOAD
#include "Passes.h.inc"

using namespace mlir;
using namespace circt;

namespace {

struct BackendBindingLoadPass
    : public ::impl::BackendBindingLoadBase<BackendBindingLoadPass> {
  using ::impl::BackendBindingLoadBase<BackendBindingLoadPass>::BackendBindingLoadBase;

  void runOnOperation() override {
    ModuleOp mod = getOperation();
    MLIRContext *ctx = mod.getContext();

    if (bindingPath.empty()) {
      mod.emitError("backend-binding-load: --binding-path=<*.binding.json> "
                    "is required");
      return signalPassFailure();
    }

    // ---- read + parse ----
    auto bufOrErr = llvm::MemoryBuffer::getFile(bindingPath);
    if (!bufOrErr) {
      mod.emitError() << "backend-binding-load: cannot open " << bindingPath
                      << ": " << bufOrErr.getError().message();
      return signalPassFailure();
    }
    auto parsed = llvm::json::parse((*bufOrErr)->getBuffer());
    if (!parsed) {
      mod.emitError() << "backend-binding-load: JSON parse error in "
                      << bindingPath << ": "
                      << llvm::toString(parsed.takeError());
      return signalPassFailure();
    }
    const auto *root = parsed->getAsObject();
    if (!root) {
      mod.emitError() << "backend-binding-load: " << bindingPath
                      << ": top-level JSON must be an object";
      return signalPassFailure();
    }
    auto ver = root->getInteger("$schema_version");
    if (!ver || *ver != 1) {
      mod.emitError() << "backend-binding-load: " << bindingPath
                      << ": missing/unsupported $schema_version (expected 1)";
      return signalPassFailure();
    }

    // ---- design.top_module ----
    const auto *design = root->getObject("design");
    auto topModuleOpt = design ? design->getString("top_module") : std::nullopt;
    if (!topModuleOpt) {
      mod.emitError() << "backend-binding-load: " << bindingPath
                      << ": missing design.top_module";
      return signalPassFailure();
    }
    StringRef topModule = *topModuleOpt;
    hw::HWModuleOp topMod;
    mod.walk([&](hw::HWModuleOp m) {
      if (m.getName() == topModule) {
        topMod = m;
        return WalkResult::interrupt();
      }
      return WalkResult::advance();
    });
    if (!topMod) {
      mod.emitError() << "backend-binding-load: " << bindingPath
                      << ": design.top_module @" << topModule
                      << " not found in IR";
      return signalPassFailure();
    }

    if (!qemu_passes::usesOpenTitanRTLAdapter(mod)) {
      for (auto key : {"chardev", "irq", "spi_slave", "spi_master", "bus_master", "alert_in"})
        if (root->get(key)) {
          mod.emitError() << "backend-binding-load: '" << key
                          << "' requires an implemented protocol adapter; legacy binding requires --rtl-adapter=opentitan";
          return signalPassFailure();
        }
    }

    // Validate that a named instance exists and is a prim_fifo_sync.  This is
    // the most fragile coupling: emission's resolveFifoPtrs substring-matches
    // the fifo instance against the flattened registry, so a wrong/typo'd name
    // would silently yield broken occupancy.  Reject it up front.
    auto fifoInstanceExists = [&](StringRef inst) -> bool {
      bool ok = false;
      mod.walk([&](hw::InstanceOp i) {
        if (i.getInstanceName() == inst &&
            i.getModuleName().contains("prim_fifo_sync")) {
          ok = true;
          return WalkResult::interrupt();
        }
        return WalkResult::advance();
      });
      return ok;
    };

    bool failed = false;
    auto parseFifo = [&](const llvm::json::Object *f, bool isTx,
                         std::string &topPortOut)
        -> std::optional<qemu_passes::FifoInfo> {
      qemu_passes::FifoInfo fi;
      auto inst = f->getString("fifo_instance");
      if (!inst) {
        mod.emitError() << "backend-binding-load: chardev."
                        << (isTx ? "tx" : "rx") << " missing 'fifo_instance'";
        failed = true;
        return std::nullopt;
      }
      fi.fifoInstance = inst->str();
      if (!fifoInstanceExists(*inst)) {
        mod.emitError() << "backend-binding-load: chardev."
                        << (isTx ? "tx" : "rx") << ".fifo_instance '" << *inst
                        << "' is not a prim_fifo_sync instance in the IR";
        failed = true;
        return std::nullopt;
      }
      if (auto s = f->getString("parent_module"))
        fi.parentModule = s->str();
      if (auto s = f->getString("wvalid_source"))
        fi.wvalidSource = s->str();
      if (auto s = f->getString("namehint"))
        fi.nameHint = s->str();
      if (auto s = f->getString("strobe_reg_name"))
        fi.strobeRegName = s->str();
      auto off = f->getInteger(isTx ? "trigger_offset" : "pop_offset");
      if (!off) {
        mod.emitError() << "backend-binding-load: chardev."
                        << (isTx ? "tx" : "rx") << " missing '"
                        << (isTx ? "trigger_offset" : "pop_offset") << "'";
        failed = true;
        return std::nullopt;
      }
      fi.strobeMatched = true;
      fi.strobeOffset = (uint64_t)*off;
      if (auto s = f->getString(isTx ? "drain_top_port" : "source_top_port"))
        topPortOut = s->str();
      return fi;
    };

    // ---- chardev ----
    qemu_passes::DeviceBlueprint bp;
    bp.topMod = topMod;
    if (const auto *cd = root->getObject("chardev")) {
      if (const auto *tx = cd->getObject("tx"))
        bp.tx = parseFifo(tx, /*isTx=*/true, bp.drainTopPort);
      if (const auto *rx = cd->getObject("rx"))
        bp.rx = parseFifo(rx, /*isTx=*/false, bp.sourceTopPort);
      // OPTIONAL system-loopback role: the flattened model state-struct field
      // that gates internal TX->RX routing.  We can only syntactically check it
      // here (the flattened signal namespace doesn't exist at IR-pass time); the
      // authoritative existence check runs at emission time in QEMUEmitCPass,
      // where the FlatSignalRegistry resolves it.
      if (auto lb = cd->getString("loopback_field")) {
        llvm::StringRef s = *lb;
        auto isIdentChar = [](char c) {
          return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') ||
                 (c >= '0' && c <= '9') || c == '_';
        };
        bool isIdent = !s.empty() && !(s[0] >= '0' && s[0] <= '9');
        for (char c : s)
          if (!isIdentChar(c))
            isIdent = false;
        if (!isIdent) {
          mod.emitError() << "backend-binding-load: chardev.loopback_field '" << s
                          << "' is not a C-identifier-shaped state-field name";
          failed = true;
        } else {
          bp.loopbackField = s.str();
        }
      }
    }
    if (failed)
      return signalPassFailure();
    if (bp.tx || bp.rx) {
      topMod->setAttr("qemu.chardev_blueprint",
                      qemu_passes::buildChardevBlueprintAttr(ctx, bp));
      llvm::outs() << "[backend-binding] chardev_blueprint attached on @"
                   << topModule << "\n";
    }

    // ---- irq ----
    if (const auto *irq = root->getObject("irq")) {
      auto isOff = irq->getInteger("intr_state_offset");
      auto ieOff = irq->getInteger("intr_enable_offset");
      auto atOff = irq->getInteger("alert_test_offset");
      auto cnt = irq->getInteger("irq_count");
      // intr_enable_offset is OPTIONAL (e.g. aon_timer has no INTR_ENABLE reg).
      if (!isOff || !cnt) {
        mod.emitError() << "backend-binding-load: irq requires "
                           "intr_state_offset and irq_count "
                           "(intr_enable_offset optional)";
        return signalPassFailure();
      }
      if (*cnt <= 0) {
        mod.emitError() << "backend-binding-load: irq.irq_count must be > 0";
        return signalPassFailure();
      }
      topMod->setAttr("qemu.irq_blueprint",
                      qemu_passes::buildIrqBlueprintAttr(
                          ctx, *isOff, ieOff ? *ieOff : -1, atOff ? *atOff : -1,
                          (unsigned)*cnt));
      llvm::outs() << "[backend-binding] irq_blueprint attached on @"
                   << topModule << " (irqs=" << *cnt << ")\n";
    }

    // ---- pin_io ----  (generic data-pin bus: data_out / output_enable /
    // data_in roles; each optional).  Validate each declared port exists on the
    // top module with the right direction + integer type, then attach.
    auto findPort = [&](StringRef name, hw::ModulePort::Direction dir,
                        unsigned &widthOut) -> bool {
      for (auto p : topMod.getPortList()) {
        if (p.getName() != name)
          continue;
        if (p.dir != dir)
          return false;
        auto it = dyn_cast<IntegerType>(p.type);
        if (!it)
          return false;
        widthOut = it.getWidth();
        return true;
      }
      return false;
    };

    // Explicit IRQ sources are model outputs, not register readbacks. In
    // particular, observing a read-to-clear register must not acknowledge it.
    if (root->get("reset")) {
      auto *r = root->getObject("reset");
      auto port = r ? r->getString("port") : std::nullopt;
      auto level = r ? r->getInteger("active_level") : std::nullopt;
      unsigned width = 0;
      if (!port || !level || (*level != 0 && *level != 1) ||
          !findPort(*port, hw::ModulePort::Direction::Input, width) || width != 1) {
        mod.emitError("backend-binding-load: reset requires a 1-bit input port and active_level 0 or 1");
        return signalPassFailure();
      }
      for (auto &kv : *r)
        if (kv.first != "port" && kv.first != "active_level") {
          mod.emitError("backend-binding-load: unknown reset field");
          return signalPassFailure();
        }
      topMod->setAttr("qemu.model_reset", DictionaryAttr::get(ctx, {
          NamedAttribute(StringAttr::get(ctx, "port"), StringAttr::get(ctx, *port)),
          NamedAttribute(StringAttr::get(ctx, "active_level"),
                        IntegerAttr::get(IntegerType::get(ctx, 1), *level))}));
    }
    if (root->get("bus_controls")) {
      auto *controls = root->getObject("bus_controls");
      if (!controls || controls->size() != 3) {
        mod.emitError("backend-binding-load: bus_controls requires read/write/idle input values");
        return signalPassFailure();
      }
      SmallVector<NamedAttribute> phases;
      llvm::DenseSet<StringRef> referencePorts;
      for (StringRef phase : {"read", "write", "idle"}) {
        auto *values = controls->getObject(phase);
        if (!values) {
          mod.emitError("backend-binding-load: missing bus_controls phase");
          return signalPassFailure();
        }
        SmallVector<NamedAttribute> signals;
        for (auto &kv : *values) {
          unsigned width = 0;
          auto value = kv.second.getAsInteger();
          if (!value || *value < 0 ||
              !findPort(kv.first, hw::ModulePort::Direction::Input, width) ||
              width > 63 || (uint64_t)*value >= (uint64_t(1) << width)) {
            mod.emitError("backend-binding-load: bus_controls must name input ports with in-range unsigned values");
            return signalPassFailure();
          }
          if (phase == "read") referencePorts.insert(kv.first);
          else if (!referencePorts.contains(kv.first)) {
            mod.emitError("backend-binding-load: bus_controls phases must name the same ports");
            return signalPassFailure();
          }
          signals.emplace_back(StringAttr::get(ctx, StringRef(kv.first)),
              IntegerAttr::get(IntegerType::get(ctx, 64), *value));
        }
        if (signals.size() != referencePorts.size()) {
          mod.emitError("backend-binding-load: bus_controls phases must name the same ports");
          return signalPassFailure();
        }
        phases.emplace_back(StringAttr::get(ctx, phase), DictionaryAttr::get(ctx, signals));
      }
      topMod->setAttr("qemu.bus_controls", DictionaryAttr::get(ctx, phases));
    }
    if (root->get("irq_outputs")) {
      auto *outputs = root->getArray("irq_outputs");
      if (!outputs || outputs->size() > 32) {
        mod.emitError("backend-binding-load: irq_outputs must be an array of at most 32 entries");
        return signalPassFailure();
      }
      if (root->get("irq") || root->get("out_lines")) {
        mod.emitError("backend-binding-load: irq_outputs cannot be combined with irq or out_lines");
        return signalPassFailure();
      }
      SmallVector<Attribute> entries(outputs->size());
      llvm::DenseSet<std::pair<StringRef, unsigned>> usedSources;
      for (const auto &v : *outputs) {
        auto *entry = v.getAsObject();
        auto index = entry ? entry->getInteger("index") : std::nullopt;
        auto *src = entry ? entry->getObject("source") : nullptr;
        auto kind = src ? src->getString("kind") : std::nullopt;
        auto port = src ? src->getString("name") : std::nullopt;
        auto bit = src ? src->getInteger("bit") : std::nullopt;
        unsigned width = 0;
        if (!index || *index < 0 || (uint64_t)*index >= outputs->size() ||
            entries[*index] || !kind || *kind != "port" || !port || !bit ||
            *bit < 0 || !findPort(*port, hw::ModulePort::Direction::Output, width) ||
            (uint64_t)*bit >= width || width > 64) {
          mod.emitError("backend-binding-load: invalid irq_outputs: require unique contiguous indices and an existing integer output port (<=64 bits) with an in-range bit");
          return signalPassFailure();
        }
        for (auto &kv : *entry)
          if (kv.first != "index" && kv.first != "source") {
            mod.emitError("backend-binding-load: unknown irq_outputs entry field");
            return signalPassFailure();
          }
        for (auto &kv : *src)
          if (kv.first != "kind" && kv.first != "name" && kv.first != "bit") {
            mod.emitError("backend-binding-load: unknown irq_outputs source field");
            return signalPassFailure();
          }
        if (!usedSources.insert({*port, (unsigned)*bit}).second) {
          mod.emitError("backend-binding-load: duplicate irq_outputs source bit");
          return signalPassFailure();
        }
        auto str = [&](StringRef x) { return StringAttr::get(ctx, x); };
        entries[*index] = DictionaryAttr::get(ctx, {
            NamedAttribute(str("port"), str(*port)),
            NamedAttribute(str("bit"), IntegerAttr::get(IntegerType::get(ctx, 32), *bit))});
      }
      topMod->setAttr("qemu.irq_outputs", ArrayAttr::get(ctx, entries));
      // Explicit port mappings supersede register-bank auto-detection.
      topMod->setAttr("qemu.irq_blueprint",
          DictionaryAttr::get(ctx, {NamedAttribute(StringAttr::get(ctx, "irq_count"),
              IntegerAttr::get(IntegerType::get(ctx, 32), entries.size()))}));
    }

    if (const auto *pio = root->getObject("pin_io")) {
      qemu_passes::PinIoInfo pin;
      bool any = false;
      bool pinFailed = false;
      auto role = [&](const char *key, hw::ModulePort::Direction dir,
                      std::string &portOut, unsigned &wOut) {
        const auto *r = pio->getObject(key);
        if (!r)
          return; // role absent: fine
        auto port = r->getString("port");
        if (!port) {
          mod.emitError() << "backend-binding-load: pin_io." << key
                          << " missing 'port'";
          pinFailed = true;
          return;
        }
        unsigned w = 0;
        if (!findPort(*port, dir, w)) {
          mod.emitError()
              << "backend-binding-load: pin_io." << key << ".port '" << *port
              << "' is not a "
              << (dir == hw::ModulePort::Direction::Output ? "output" : "input")
              << " integer port on @" << topModule;
          pinFailed = true;
          return;
        }
        if (auto requested = r->get("width")) {
          auto width = requested->getAsInteger();
          if (!width || *width != w || w > 64) {
            mod.emitError("backend-binding-load: pin_io width differs from the top port or exceeds 64 bits");
            pinFailed = true;
            return;
          }
        }
        portOut = port->str();
        wOut = w;
        any = true;
      };
      role("data_out", hw::ModulePort::Direction::Output, pin.dataOutPort,
           pin.dataOutWidth);
      role("output_enable", hw::ModulePort::Direction::Output, pin.oePort,
           pin.oeWidth);
      role("data_in", hw::ModulePort::Direction::Input, pin.dataInPort,
           pin.dataInWidth);
      if (pinFailed)
        return signalPassFailure();
      if (any) {
        topMod->setAttr("qemu.pin_io_blueprint",
                        qemu_passes::buildPinIoBlueprintAttr(ctx, pin));
        llvm::outs() << "[backend-binding] pin_io_blueprint attached on @"
                     << topModule << "\n";
      }
    }

    // ---- aux_pin_groups ----  Additional NAMED qdev pin buses beyond the
    // single primary pin_io group.  Role-based and declarative: each entry
    // names an optional integer output port (exported as "<name>-out" qdev
    // lines), an optional integer input port (a "<name>-in" qdev input
    // array feeding the generated setter), and an optional list of input
    // ports to tie all-ones at realize (constant enables such as a
    // peripheral-side output-enable bus).  First user: pinmux's
    // peripheral-side interface (mio_to_periph_o / periph_to_mio_i /
    // periph_to_mio_oe_i) for the pin-group closed loop.
    if (const auto *aux = root->getArray("aux_pin_groups")) {
      SmallVector<Attribute> groups;
      bool auxFailed = false;
      for (const auto &entryVal : *aux) {
        const auto *e = entryVal.getAsObject();
        if (!e) {
          mod.emitError() << "backend-binding-load: aux_pin_groups entry is "
                             "not an object";
          auxFailed = true;
          break;
        }
        auto name = e->getString("name");
        if (!name || name->empty()) {
          mod.emitError()
              << "backend-binding-load: aux_pin_groups entry missing 'name'";
          auxFailed = true;
          break;
        }
        SmallVector<NamedAttribute> fields;
        Builder b(ctx);
        fields.push_back(b.getNamedAttr("name", b.getStringAttr(*name)));
        if (auto op = e->getString("out_port")) {
          unsigned w = 0;
          if (!findPort(*op, hw::ModulePort::Direction::Output, w)) {
            mod.emitError() << "backend-binding-load: aux_pin_groups '"
                            << *name << "' out_port '" << *op
                            << "' is not an output integer port on @"
                            << topModule;
            auxFailed = true;
            break;
          }
          fields.push_back(b.getNamedAttr("out_port", b.getStringAttr(*op)));
          fields.push_back(b.getNamedAttr("out_width", b.getI32IntegerAttr((int32_t)w)));
        }
        if (auto ip = e->getString("in_port")) {
          unsigned w = 0;
          if (!findPort(*ip, hw::ModulePort::Direction::Input, w)) {
            mod.emitError() << "backend-binding-load: aux_pin_groups '"
                            << *name << "' in_port '" << *ip
                            << "' is not an input integer port on @"
                            << topModule;
            auxFailed = true;
            break;
          }
          fields.push_back(b.getNamedAttr("in_port", b.getStringAttr(*ip)));
          fields.push_back(b.getNamedAttr("in_width", b.getI32IntegerAttr((int32_t)w)));
        }
        if (const auto *ties = e->getArray("in_tie_ones")) {
          SmallVector<Attribute> tiePorts;
          for (const auto &tv : *ties) {
            auto tp = tv.getAsString();
            unsigned w = 0;
            if (!tp || !findPort(*tp, hw::ModulePort::Direction::Input, w)) {
              mod.emitError() << "backend-binding-load: aux_pin_groups '"
                              << *name << "' in_tie_ones port invalid";
              auxFailed = true;
              break;
            }
            SmallVector<NamedAttribute> tf;
            tf.push_back(b.getNamedAttr("port", b.getStringAttr(*tp)));
            tf.push_back(b.getNamedAttr("width", b.getI32IntegerAttr((int32_t)w)));
            tiePorts.push_back(b.getDictionaryAttr(tf));
          }
          if (auxFailed)
            break;
          fields.push_back(b.getNamedAttr("tie_ones", b.getArrayAttr(tiePorts)));
        }
        groups.push_back(Builder(ctx).getDictionaryAttr(fields));
      }
      if (auxFailed)
        return signalPassFailure();
      if (!groups.empty()) {
        topMod->setAttr("qemu.aux_pin_groups",
                        ArrayAttr::get(ctx, groups));
        llvm::outs() << "[backend-binding] aux_pin_groups attached on @"
                     << topModule << " (" << groups.size() << " group(s))\n";
      }
    }

    // ---- i2c_wire ----  A two-wire open-drain transport declaration.  This
    // names roles only; neither the loader nor the emitted bridge knows an IP
    // vendor's port spelling.  The emitter consumes this blueprint to attach
    // a generic I2C wire adapter to QEMU's I2CBus.
    if (const auto *iw = root->getObject("i2c_wire")) {
      bool bad = false;
      auto portOf = [&](const char *key, hw::ModulePort::Direction dir,
                        std::string &out) {
        auto v = iw->getString(key);
        if (!v) {
          mod.emitError() << "backend-binding-load: i2c_wire." << key
                          << " missing";
          bad = true;
          return;
        }
        unsigned width = 0;
        if (!findPort(*v, dir, width) || width != 1) {
          mod.emitError() << "backend-binding-load: i2c_wire." << key << " '"
                          << *v << "' is not a 1-bit "
                          << (dir == hw::ModulePort::Direction::Output ? "output" : "input")
                          << " port on @" << topModule;
          bad = true;
          return;
        }
        out = v->str();
      };
      std::string sclIn, sclOe, sclOut, sdaIn, sdaOe, sdaOut;
      portOf("scl_in", hw::ModulePort::Direction::Input, sclIn);
      portOf("scl_oe", hw::ModulePort::Direction::Output, sclOe);
      portOf("scl_out", hw::ModulePort::Direction::Output, sclOut);
      portOf("sda_in", hw::ModulePort::Direction::Input, sdaIn);
      portOf("sda_oe", hw::ModulePort::Direction::Output, sdaOe);
      portOf("sda_out", hw::ModulePort::Direction::Output, sdaOut);
      if (bad)
        return signalPassFailure();
      NamedAttrList d;
      d.append("scl_in_port", StringAttr::get(ctx, sclIn));
      d.append("scl_oe_port", StringAttr::get(ctx, sclOe));
      d.append("scl_out_port", StringAttr::get(ctx, sclOut));
      d.append("sda_in_port", StringAttr::get(ctx, sdaIn));
      d.append("sda_oe_port", StringAttr::get(ctx, sdaOe));
      d.append("sda_out_port", StringAttr::get(ctx, sdaOut));
      d.append("open_drain", BoolAttr::get(ctx,
                                             iw->getBoolean("open_drain").value_or(true)));
      if (const auto *writes = iw->getArray("reset_writes")) {
        SmallVector<Attribute, 8> writeAttrs;
        for (const auto &wv : *writes) {
          const auto *wo = wv.getAsObject();
          auto offset = wo ? wo->getInteger("offset") : std::nullopt;
          auto value = wo ? wo->getInteger("value") : std::nullopt;
          if (!offset || !value || *offset < 0 || (*offset & 3) != 0 ||
              *value < 0 || static_cast<uint64_t>(*value) > UINT32_MAX) {
            mod.emitError() << "backend-binding-load: i2c_wire.reset_writes "
                               "entries require an aligned non-negative "
                               "offset and a 32-bit non-negative value";
            return signalPassFailure();
          }
          NamedAttrList wd;
          wd.append("offset", IntegerAttr::get(IntegerType::get(ctx, 64),
                                                *offset));
          wd.append("value", IntegerAttr::get(IntegerType::get(ctx, 64),
                                               *value));
          writeAttrs.push_back(DictionaryAttr::get(ctx, wd));
        }
        d.append("reset_writes", ArrayAttr::get(ctx, writeAttrs));
      }
      topMod->setAttr("qemu.i2c_wire_blueprint", DictionaryAttr::get(ctx, d));
      llvm::outs() << "[backend-binding] i2c_wire_blueprint attached on @"
                   << topModule << "\n";
    }

    // ---- spi_slave (SPI-slave transport organ) ----  Declares which top ports
    // are the serial clock / chip-select / data-in / data-out lines and which
    // bit lanes carry MOSI/MISO.  The shim (QEMUEmitC) then accepts bytes +
    // chip-select from QEMU (lowRISC spidev framing on a chardev) and pumps
    // them as sck edges into the model.  Mechanism generic; roles are data.
    if (const auto *sp = root->getObject("spi_slave")) {
      bool bad = false;
      auto portOf = [&](const char *key, hw::ModulePort::Direction dir,
                        std::string &out, unsigned &w) {
        auto v = sp->getString(key);
        if (!v) { mod.emitError() << "backend-binding-load: spi_slave." << key << " missing"; bad = true; return; }
        if (!findPort(*v, dir, w)) {
          mod.emitError() << "backend-binding-load: spi_slave." << key << " '" << *v
                          << "' is not a" << (dir == hw::ModulePort::Direction::Output ? "n output" : "n input")
                          << " integer port on @" << topModule;
          bad = true; return;
        }
        out = v->str();
      };
      std::string sck, csb, sdIn, sdOut; unsigned wSck = 0, wCsb = 0, wIn = 0, wOut = 0;
      portOf("sck", hw::ModulePort::Direction::Input, sck, wSck);
      portOf("csb", hw::ModulePort::Direction::Input, csb, wCsb);
      portOf("sd_in", hw::ModulePort::Direction::Input, sdIn, wIn);
      portOf("sd_out", hw::ModulePort::Direction::Output, sdOut, wOut);
      int64_t mosi = sp->getInteger("mosi_bit").value_or(0);
      int64_t miso = sp->getInteger("miso_bit").value_or(1);
      if (!bad && (wSck != 1 || wCsb != 1)) {
        mod.emitError() << "backend-binding-load: spi_slave sck/csb must be 1-bit ports";
        bad = true;
      }
      if (!bad && ((unsigned)mosi >= wIn || (unsigned)miso >= wOut)) {
        mod.emitError() << "backend-binding-load: spi_slave mosi_bit/miso_bit out of range";
        bad = true;
      }
      if (bad) return signalPassFailure();
      // sck/csb should be declared event clocks (clocks block) — otherwise the
      // sck-domain logic runs every settle tick and the pump has no effect.
      if (const auto *clocks = root->getObject("clocks")) {
        for (const auto &nm : {sck, csb}) {
          auto k = clocks->getString(nm);
          if (!k || *k != "event")
            llvm::errs() << "[backend-binding] WARNING: spi_slave port '" << nm
                         << "' is not declared as an event clock in `clocks`\n";
        }
      }
      NamedAttrList d;
      d.append("sck_port", StringAttr::get(ctx, sck));
      d.append("csb_port", StringAttr::get(ctx, csb));
      d.append("sd_in_port", StringAttr::get(ctx, sdIn));
      d.append("sd_out_port", StringAttr::get(ctx, sdOut));
      d.append("sd_in_width", IntegerAttr::get(IntegerType::get(ctx, 32), wIn));
      d.append("sd_out_width", IntegerAttr::get(IntegerType::get(ctx, 32), wOut));
      d.append("mosi_bit", IntegerAttr::get(IntegerType::get(ctx, 32), mosi));
      d.append("miso_bit", IntegerAttr::get(IntegerType::get(ctx, 32), miso));
      topMod->setAttr("qemu.spi_slave_blueprint", DictionaryAttr::get(ctx, d));
      llvm::outs() << "[backend-binding] spi_slave_blueprint attached on @" << topModule
                   << " (sck=" << sck << " csb=" << csb << " mosi=" << sdIn << "[" << mosi
                   << "] miso=" << sdOut << "[" << miso << "])\n";
    }

    // ---- spi_master (SPI-master bridge organ) ----  The model DRIVES the
    // serial clock / chip-select(s) / data lanes; the shim watches every model
    // clock (per-tick observer hook) and bridges the bit stream to a QEMU SSI
    // bus (byte-level, m25p80-class peripherals attach on `spi<bus-num>`).
    // Roles are data; mechanism generic.
    if (const auto *sp = root->getObject("spi_master")) {
      bool bad = false;
      auto portOf = [&](const char *key, hw::ModulePort::Direction dir,
                        std::string &out, unsigned &w) {
        auto v = sp->getString(key);
        if (!v) { mod.emitError() << "backend-binding-load: spi_master." << key << " missing"; bad = true; return; }
        if (!findPort(*v, dir, w)) {
          mod.emitError() << "backend-binding-load: spi_master." << key << " '" << *v
                          << "' is not a" << (dir == hw::ModulePort::Direction::Output ? "n output" : "n input")
                          << " integer port on @" << topModule;
          bad = true; return;
        }
        out = v->str();
      };
      std::string sck, csb, sdOut, sdOe, sdIn; unsigned wSck = 0, wCsb = 0, wOut = 0, wOe = 0, wIn = 0;
      portOf("sck", hw::ModulePort::Direction::Output, sck, wSck);
      portOf("csb", hw::ModulePort::Direction::Output, csb, wCsb);
      portOf("sd_out", hw::ModulePort::Direction::Output, sdOut, wOut);
      portOf("sd_oe", hw::ModulePort::Direction::Output, sdOe, wOe);
      portOf("sd_in", hw::ModulePort::Direction::Input, sdIn, wIn);
      int64_t mosi = sp->getInteger("mosi_bit").value_or(0);
      int64_t miso = sp->getInteger("miso_bit").value_or(1);
      if (!bad && wSck != 1) {
        mod.emitError() << "backend-binding-load: spi_master sck must be a 1-bit port";
        bad = true;
      }
      if (!bad && wOe != wOut) {
        mod.emitError() << "backend-binding-load: spi_master sd_oe/sd_out widths differ";
        bad = true;
      }
      if (!bad && ((unsigned)mosi >= wOut || (unsigned)miso >= wIn)) {
        mod.emitError() << "backend-binding-load: spi_master mosi_bit/miso_bit out of range";
        bad = true;
      }
      if (bad) return signalPassFailure();
      NamedAttrList d;
      d.append("sck_port", StringAttr::get(ctx, sck));
      d.append("csb_port", StringAttr::get(ctx, csb));
      d.append("csb_width", IntegerAttr::get(IntegerType::get(ctx, 32), wCsb));
      d.append("sd_out_port", StringAttr::get(ctx, sdOut));
      d.append("sd_oe_port", StringAttr::get(ctx, sdOe));
      d.append("sd_in_port", StringAttr::get(ctx, sdIn));
      d.append("sd_out_width", IntegerAttr::get(IntegerType::get(ctx, 32), wOut));
      d.append("sd_in_width", IntegerAttr::get(IntegerType::get(ctx, 32), wIn));
      d.append("mosi_bit", IntegerAttr::get(IntegerType::get(ctx, 32), mosi));
      d.append("miso_bit", IntegerAttr::get(IntegerType::get(ctx, 32), miso));
      topMod->setAttr("qemu.spi_master_blueprint", DictionaryAttr::get(ctx, d));
      llvm::outs() << "[backend-binding] spi_master_blueprint attached on @" << topModule
                   << " (sck=" << sck << " csb=" << csb << "(" << wCsb << ") mosi=" << sdOut << "[" << mosi
                   << "] oe=" << sdOe << " miso=" << sdIn << "[" << miso << "])\n";
    }

    // ---- bus_master (memory-bus host-port bridge organ) ----  The model
    // DRIVES one or more bus request ports (a DMA engine's host ports); the
    // shim watches every model clock and bridges request beats to a QEMU
    // AddressSpace, feeding responses back.  Roles are data; mechanism generic.
    if (const auto *bm = root->getArray("bus_master")) {
      SmallVector<Attribute, 2> entries;
      for (const auto &ev : *bm) {
        const auto *e = ev.getAsObject();
        if (!e) { mod.emitError() << "backend-binding-load: bus_master entries must be objects"; return signalPassFailure(); }
        auto req = e->getString("req_port");
        auto rsp = e->getString("rsp_port");
        auto asName = e->getString("address_space");
        auto proto = e->getString("protocol");
        if (!req || !rsp) { mod.emitError() << "backend-binding-load: bus_master.req_port/rsp_port missing"; return signalPassFailure(); }
        if (proto && *proto != "tlul") { mod.emitError() << "backend-binding-load: bus_master.protocol '" << *proto << "' not supported (tlul only)"; return signalPassFailure(); }
        // req = OUTPUT port whose struct carries a_valid; rsp = INPUT port with d_valid.
        bool reqOk = false, rspOk = false;
        for (auto pinfo : topMod.getPortList()) {
          auto st = dyn_cast<hw::StructType>(pinfo.type);
          if (!st) continue;
          bool hasAV = false, hasDV = false;
          for (auto &f : st.getElements()) {
            if (f.name.getValue() == "a_valid") hasAV = true;
            if (f.name.getValue() == "d_valid") hasDV = true;
          }
          if (pinfo.getName() == *req && pinfo.dir == hw::ModulePort::Direction::Output && hasAV) reqOk = true;
          if (pinfo.getName() == *rsp && pinfo.dir == hw::ModulePort::Direction::Input && hasDV) rspOk = true;
        }
        if (!reqOk) { mod.emitError() << "backend-binding-load: bus_master.req_port '" << *req << "' is not a bus-request (a_valid) struct output on @" << topModule; return signalPassFailure(); }
        if (!rspOk) { mod.emitError() << "backend-binding-load: bus_master.rsp_port '" << *rsp << "' is not a bus-response (d_valid) struct input on @" << topModule; return signalPassFailure(); }
        NamedAttrList d;
        d.append("req_port", StringAttr::get(ctx, *req));
        d.append("rsp_port", StringAttr::get(ctx, *rsp));
        d.append("address_space", StringAttr::get(ctx, asName.value_or("sys")));
        entries.push_back(DictionaryAttr::get(ctx, d));
        llvm::outs() << "[backend-binding] bus_master: req=" << *req << " rsp=" << *rsp
                     << " as=" << asName.value_or("sys") << "\n";
      }
      topMod->setAttr("qemu.bus_master_blueprint", ArrayAttr::get(ctx, entries));
      llvm::outs() << "[backend-binding] bus_master_blueprint attached on @" << topModule
                   << " (" << entries.size() << " port(s))\n";
    }

    // ---- out_lines (declared 1-bit output lines) ----  Model output ports
    // exported as qemu_irq lines (sysbus IRQs, declaration order) — for
    // devices whose outward-facing interrupts are NOT an INTR_STATE register
    // bank (a PLIC's irq/msip to the CPU, an alert handler's escalation
    // lines).  Mechanism generic; which ports are lines is data.
    if (const auto *ol = root->getArray("out_lines")) {
      SmallVector<Attribute, 4> lines;
      for (const auto &lv : *ol) {
        auto name = lv.getAsString();
        if (!name) { mod.emitError() << "backend-binding-load: out_lines entries must be port-name strings"; return signalPassFailure(); }
        unsigned w = 0;
        if (!findPort(*name, hw::ModulePort::Direction::Output, w) || w != 1) {
          mod.emitError() << "backend-binding-load: out_lines '" << *name
                          << "' is not a 1-bit output port on @" << topModule;
          return signalPassFailure();
        }
        lines.push_back(StringAttr::get(ctx, *name));
      }
      topMod->setAttr("qemu.out_lines_blueprint", ArrayAttr::get(ctx, lines));
      llvm::outs() << "[backend-binding] out_lines_blueprint attached on @" << topModule
                   << " (" << lines.size() << " line(s))\n";
    }

    // ---- live_ring_modules (event-driven counter declaration) ----
    // Names hw.modules whose accumulate-ring counters are clocked by
    // EXTERNAL EVENTS (a FIFO pointer stepping on incr_wptr_i, a socket's
    // outstanding-request tracker) rather than free-running time.  Those
    // rings stay LIVE in the settle loop instead of being pump-gated.
    // The pulse-vs-level nature of an enable is a protocol fact the IR
    // cannot prove (a prescaler's level `active` and a FIFO's pulse `incr`
    // look identical statically — every shape heuristic we tried dragged
    // in a free-running counter or dropped a FIFO), so it is DECLARED
    // here, per device: uart leaves its FIFOs pump-gated by simply not
    // declaring them.  Mechanism generic; which modules are event-driven
    // is data.
    if (const auto *lr = root->getArray("live_ring_modules")) {
      SmallVector<Attribute, 4> mods;
      for (const auto &mv : *lr) {
        auto name = mv.getAsString();
        if (!name) { mod.emitError() << "backend-binding-load: live_ring_modules entries must be module-name strings"; return signalPassFailure(); }
        mods.push_back(StringAttr::get(ctx, *name));
      }
      topMod->setAttr("qemu.live_ring_modules", ArrayAttr::get(ctx, mods));
      llvm::outs() << "[backend-binding] live_ring_modules attached on @" << topModule
                   << " (" << mods.size() << " module(s))\n";
    }

    // ---- alert_in (differential alert-source inputs) ----  The device is
    // an alert COLLECTOR: N upstream peripherals each drive one diff pair
    // (<prefix>_K__alert_p/n after struct explosion).  The shim exposes N
    // named qdev gpio-ins (OT_DEVICE_ALERT) so existing SoC alert wiring
    // lands unchanged.  Port spelling is data; the organ is generic.
    if (const auto *ai = root->getObject("alert_in")) {
      auto cnt = ai->getInteger("count");
      auto pfx = ai->getString("port_prefix");
      if (!cnt || !pfx || *cnt <= 0) {
        mod.emitError() << "backend-binding-load: alert_in needs count>0 and port_prefix";
        return signalPassFailure();
      }
      SmallVector<NamedAttribute, 2> f;
      f.push_back(NamedAttribute(StringAttr::get(ctx, "count"),
          IntegerAttr::get(IntegerType::get(ctx, 32), *cnt)));
      f.push_back(NamedAttribute(StringAttr::get(ctx, "port_prefix"),
          StringAttr::get(ctx, *pfx)));
      topMod->setAttr("qemu.alert_in_blueprint", DictionaryAttr::get(ctx, f));
      llvm::outs() << "[backend-binding] alert_in_blueprint attached on @" << topModule
                   << " (" << *cnt << " source(s))\n";
    }

    // ---- input_ties (constant-driven dangling inputs) ----  Some top-level
    // inputs come from SoC blocks the model does not integrate (EDN entropy
    // buses, life-cycle signals).  Left at 0 they can deadlock a state
    // machine that waits for a handshake (aes's PRNG reseed waits on
    // edn_ack and never reaches IDLE).  The binding declares the flat port
    // field names (post-explosion spelling, matching the generated setters)
    // with the constant each should be tied to; the shim applies them once
    // after reset.  Declarative and device-agnostic.
    if (const auto *ties = root->getObject("input_ties")) {
      SmallVector<NamedAttribute, 4> f;
      for (const auto &kv : *ties) {
        auto v = kv.getSecond().getAsInteger();
        if (!v) {
          mod.emitError() << "backend-binding-load: input_ties values must be integers";
          return signalPassFailure();
        }
        f.push_back(NamedAttribute(
            StringAttr::get(ctx, kv.getFirst().str()),
            IntegerAttr::get(IntegerType::get(ctx, 64), *v)));
      }
      if (!f.empty()) {
        topMod->setAttr("qemu.input_ties", DictionaryAttr::get(ctx, f));
        llvm::outs() << "[backend-binding] input_ties attached on @" << topModule
                     << " (" << f.size() << " port(s))\n";
      }
    }

    // ---- timer (virtual-time pump opt-in) ----  A device is a free-running
    // timer that must keep time autonomously ONLY by declaration — it is not
    // structurally inferable (i2c's timeout counters look identical).  When the
    // binding has a `timer` block we mark qemu.timer_pump; QEMUEmitC's shim then
    // emits a periodic ptimer -> <dev>_advance_tick -> update_irqs.  Optional
    // `pump_hz` is advisory (the emitter uses a fixed functional rate).
    if (const auto *tmr = root->getObject("timer")) {
      int64_t hz = 0;
      if (auto h = tmr->getInteger("pump_hz"))
        hz = *h;
      topMod->setAttr("qemu.timer_pump",
                      IntegerAttr::get(IntegerType::get(ctx, 64), hz));
      llvm::outs() << "[backend-binding] timer pump opt-in on @" << topModule
                   << (hz ? " (pump_hz=" + std::to_string(hz) + ")" : "") << "\n";
    }

    // ---- clocks (beat vs event clock declaration) ----  Consumed EARLY by
    // ClockSignalDetection (it reads only this block, before ClockDrvRemoval);
    // here we only re-check the format + that each key is a top input port +
    // (when the detector left its root table) that it is a clock root, so a
    // typo is reported from the loader too.  The verdict/mechanics live in
    // Passes.cpp (qemu.clock_kind on sigs, <sig>_prev materialization).
    if (const auto *clocks = root->getObject("clocks")) {
      llvm::DenseSet<StringRef> inputPorts;
      for (const auto &p : topMod.getPortList())
        if (p.dir == hw::ModulePort::Direction::Input)
          inputPorts.insert(p.getName());
      llvm::DenseSet<StringRef> roots;
      bool haveRoots = false;
      if (auto arr = topMod->getAttrOfType<ArrayAttr>("qemu.clock_roots")) {
        haveRoots = true;
        for (Attribute a : arr)
          if (auto d = dyn_cast<DictionaryAttr>(a))
            if (auto pn = d.getAs<StringAttr>("port"))
              roots.insert(pn.getValue());
      }
      for (const auto &kv : *clocks) {
        StringRef portName = kv.first;
        auto kind = kv.second.getAsString();
        if (!kind || (*kind != "beat" && *kind != "event")) {
          topMod.emitError() << "backend-binding-load: clocks." << portName
                             << " must be \"beat\" or \"event\"";
          return signalPassFailure();
        }
        if (!inputPorts.contains(portName)) {
          topMod.emitError() << "backend-binding-load: clocks." << portName
                             << " is not an input port of @" << topModule;
          return signalPassFailure();
        }
        if (haveRoots && !roots.contains(portName)) {
          topMod.emitError() << "backend-binding-load: clocks." << portName
                             << " is not the root of any detected clock "
                                "(see digest clock_roots)";
          return signalPassFailure();
        }
        llvm::outs() << "[backend-binding] clock " << portName << " = " << *kind
                     << "\n";
      }
    }

    // ---- input_resets (declared benign reset values for undriven top
    // inputs) ----  Some functional behavior is gated by lifecycle / strap
    // inputs that, in real silicon, are driven by another block (e.g. lc_ctrl
    // drives aon_timer's lc_escalate_en_i to the lifecycle "Off" encoding).  In
    // a standalone functional model those top inputs are undriven (zero), which
    // can wrongly disable the device.  This block declares their benign value;
    // QEMUEmitC writes `s-><port> = <value>;` at the top of <dev>_reset() and
    // the settle loop propagates it (through any CDC sync) to the consuming
    // logic.  The value is data (AI/human-fillable from the IP spec); the
    // mechanism is generic — no device names, no per-device C.
    if (const auto *resets = root->getObject("input_resets")) {
      llvm::DenseSet<StringRef> inputPorts;
      for (const auto &p : topMod.getPortList())
        if (p.dir == hw::ModulePort::Direction::Input)
          inputPorts.insert(p.getName());
      SmallVector<NamedAttribute> entries;
      for (const auto &kv : *resets) {
        StringRef portName = kv.first;
        auto valOpt = kv.second.getAsInteger();
        if (!valOpt) {
          topMod.emitError() << "backend-binding-load: input_resets."
                             << portName << " must be an integer";
          return signalPassFailure();
        }
        if (!inputPorts.contains(portName)) {
          topMod.emitError() << "backend-binding-load: input_resets."
                             << portName << " is not an input port of @"
                             << topModule;
          return signalPassFailure();
        }
        entries.emplace_back(
            StringAttr::get(ctx, portName),
            IntegerAttr::get(IntegerType::get(ctx, 64), *valOpt));
      }
      if (!entries.empty()) {
        topMod->setAttr("qemu.input_resets", DictionaryAttr::get(ctx, entries));
        llvm::outs() << "[backend-binding] input_resets on @" << topModule
                     << " (" << entries.size() << " port(s))\n";
      }
    }
  }
};

} // namespace
