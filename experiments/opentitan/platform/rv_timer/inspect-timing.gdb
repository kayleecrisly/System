set pagination off
set confirm off
set print thread-events off
set breakpoint pending off
python
import gdb
import json

# Read-only host-side observations. No inferior calls or state writes.
device = None
pump_calls = 0
active_pump_calls = 0
last_count = None

def emit(event, **fields):
    print("RV_TIMER_AUDIT " + json.dumps(dict(event=event, **fields), sort_keys=True))

def state():
    core = device["core"]
    timer = device["qp_pump"].dereference()
    return dict(
        count=(int(core["u_reg_u_timer_v_upper0_q"]) << 32) |
              int(core["u_reg_u_timer_v_lower0_q"]),
        comparator=(int(core["u_reg_u_compare_upper0_0_q"]) << 32) |
                   int(core["u_reg_u_compare_lower0_0_q"]),
        prescale=int(core["u_reg_u_cfg0_prescale_q"]),
        step=int(core["u_reg_u_cfg0_step_q"]),
        active=int(core["u_reg_u_ctrl_q"]),
        intr_state=int(core["u_reg_u_intr_state0_q"]),
        intr_enable=int(core["u_reg_u_intr_enable0_q"]),
        prescaler_count=int(core["gen_harts_0_u_core_tick_count"]),
        pump_period_ns=int(timer["period"]),
        pump_last_event_ns=int(timer["last_event"]),
        pump_next_event_ns=int(timer["next_event"]),
        pump_calls=pump_calls,
        active_pump_calls=active_pump_calls,
    )

class Pump(gdb.Breakpoint):
    def stop(self):
        global device, pump_calls, active_pump_calls, last_count
        device = gdb.parse_and_eval("(OtRvTimerQpState *)opaque").dereference()
        pump_calls += 1
        snapshot = state()
        if snapshot["active"]:
            active_pump_calls += 1
        snapshot["active_pump_calls"] = active_pump_calls
        if snapshot["active"] and active_pump_calls == 1:
            emit("first_active_pump", **snapshot)
        if snapshot["count"] != last_count:
            if snapshot["count"] in (0, 1, 2, 98, 99, 100):
                emit("before_pump", **snapshot)
            last_count = snapshot["count"]
        return False

class MmioWrite(gdb.Breakpoint):
    def stop(self):
        global device
        device = gdb.parse_and_eval("(OtRvTimerQpState *)opaque").dereference()
        emit("before_mmio_write", offset=int(gdb.parse_and_eval("addr")),
             value=int(gdb.parse_and_eval("value")), **state())
        return False

class CpuIrq(gdb.Breakpoint):
    def stop(self):
        irq = int(gdb.parse_and_eval("irq"))
        if irq == 7 and device is not None:
            emit("cpu_mtip", level=int(gdb.parse_and_eval("level")), **state())
        return False

Pump("ot_rv_timer_qp_pump")
MmioWrite("ot_rv_timer_qp_write")
CpuIrq("riscv_cpu_set_irq")
end
run
