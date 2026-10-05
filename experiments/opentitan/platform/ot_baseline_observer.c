/* Experiment-only observation of the official OpenTitan DV test status.
 * This is a testbench endpoint, not a generated SoC peripheral model.
 * No UART or boot behavior is implemented here.
 */
#include "qemu/osdep.h"
#include "qemu/log.h"
#include "qemu/module.h"
#include "hw/sysbus.h"
#include "hw/qdev-properties.h"
#include "system/runstate.h"

#define TYPE_OT_BASELINE_OBSERVER "ot-baseline-observer"
OBJECT_DECLARE_SIMPLE_TYPE(OtBaselineObserverState, OT_BASELINE_OBSERVER)

struct OtBaselineObserverState {
    SysBusDevice parent_obj;
    MemoryRegion mmio;
    uint32_t status_offset;
    uint32_t status;
    uint64_t log_words;
};

static uint64_t observer_read(void *opaque, hwaddr addr, unsigned size)
{
    OtBaselineObserverState *s = opaque;
    if (addr == s->status_offset && size == 4) {
        return s->status;
    }
    fprintf(stderr, "OT_OBSERVER_UNSUPPORTED_READ offset=0x%" HWADDR_PRIx
            " size=%u\n", addr, size);
    qemu_system_shutdown_request_with_code(SHUTDOWN_CAUSE_HOST_ERROR, 3);
    return 0;
}

static void observer_write(void *opaque, hwaddr addr, uint64_t value,
                           unsigned size)
{
    OtBaselineObserverState *s = opaque;
    if (size == 4 && addr == s->status_offset) {
        s->status = value;
        fprintf(stderr, "OT_TEST_STATUS value=0x%08x log_words=%" PRIu64 "\n",
                s->status, s->log_words);
        if ((s->status & 0xffffu) == 0x900du) {
            qemu_system_shutdown_request_with_code(
                SHUTDOWN_CAUSE_GUEST_SHUTDOWN, 0);
        } else if ((s->status & 0xffffu) == 0xbaadu) {
            qemu_system_shutdown_request_with_code(
                SHUTDOWN_CAUSE_GUEST_SHUTDOWN, 1);
        }
    } else if (size == 4 && addr == s->status_offset + 4) {
        /* Preserve raw DV logging writes. No UART output is synthesized. */
        s->log_words++;
        fprintf(stderr, "OT_DV_LOG_WORD value=0x%08x\n", (uint32_t)value);
    } else {
        fprintf(stderr, "OT_OBSERVER_UNSUPPORTED_WRITE offset=0x%" HWADDR_PRIx
                " size=%u value=0x%08x\n", addr, size, (uint32_t)value);
        qemu_system_shutdown_request_with_code(SHUTDOWN_CAUSE_HOST_ERROR, 3);
    }
}

static const MemoryRegionOps observer_ops = {
    .read = observer_read,
    .write = observer_write,
    .endianness = DEVICE_LITTLE_ENDIAN,
    .valid.min_access_size = 4,
    .valid.max_access_size = 4,
};

static const Property observer_properties[] = {
    DEFINE_PROP_UINT32("status-offset", OtBaselineObserverState, status_offset,
                      0x80),
};

static void observer_init(Object *obj)
{
    OtBaselineObserverState *s = OT_BASELINE_OBSERVER(obj);
    memory_region_init_io(&s->mmio, obj, &observer_ops, s,
                          TYPE_OT_BASELINE_OBSERVER, 0x100);
    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
}

static void observer_class_init(ObjectClass *oc, const void *data)
{
    DeviceClass *dc = DEVICE_CLASS(oc);
    device_class_set_props(dc, observer_properties);
}

static const TypeInfo observer_type_info = {
    .name = TYPE_OT_BASELINE_OBSERVER,
    .parent = TYPE_SYS_BUS_DEVICE,
    .instance_size = sizeof(OtBaselineObserverState),
    .instance_init = observer_init,
    .class_init = observer_class_init,
};

static void observer_register_types(void)
{
    type_register_static(&observer_type_info);
}

type_init(observer_register_types)
