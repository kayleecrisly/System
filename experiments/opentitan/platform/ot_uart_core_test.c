/* Experiment-private SysBus glue around the unmodified RTL-generated core.
 * The generated core owns all MMIO behavior, FIFOs and internal loopback.
 * No byte backend, data-register override or FIFO-state manipulation.
 */
#include "qemu/osdep.h"
#include "qemu/module.h"
#include "hw/sysbus.h"
#include "../opentitan/qemu_passes/uart.h"

#define TYPE_OT_UART_CORE_TEST "ot-uart-core-test"
OBJECT_DECLARE_SIMPLE_TYPE(OtUartCoreTestState, OT_UART_CORE_TEST)

struct OtUartCoreTestState {
    SysBusDevice parent_obj;
    MemoryRegion mmio;
    uart_state core;
    uint64_t reads;
    uint64_t writes;
    hwaddr last_read_addr;
    uint64_t last_read_value;
};

static uint64_t core_read(void *opaque, hwaddr addr, unsigned size)
{
    OtUartCoreTestState *s = opaque;
    uint64_t value = uart_read(&s->core, addr, size);
    if (!s->reads || addr != s->last_read_addr || value != s->last_read_value) {
        fprintf(stderr, "OT_UART_READ offset=0x%" HWADDR_PRIx
                " size=%u value=0x%08x count=%" PRIu64 "\n",
                addr, size, (uint32_t)value, s->reads + 1);
    }
    s->reads++;
    s->last_read_addr = addr;
    s->last_read_value = value;
    return value;
}

static void core_write(void *opaque, hwaddr addr, uint64_t value, unsigned size)
{
    OtUartCoreTestState *s = opaque;
    s->writes++;
    fprintf(stderr, "OT_UART_WRITE offset=0x%" HWADDR_PRIx
            " size=%u value=0x%08x count=%" PRIu64 "\n",
            addr, size, (uint32_t)value, s->writes);
    uart_write(&s->core, addr, value, size);
}

static const MemoryRegionOps core_ops = {
    .read = core_read,
    .write = core_write,
    .endianness = DEVICE_LITTLE_ENDIAN,
    .valid.min_access_size = 1,
    .valid.max_access_size = 4,
};

static void core_init(Object *obj)
{
    OtUartCoreTestState *s = OT_UART_CORE_TEST(obj);
    memory_region_init_io(&s->mmio, obj, &core_ops, s,
                          TYPE_OT_UART_CORE_TEST, 0x40);
    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
    uart_reset(&s->core);
    uart_set_cio_rx_i(&s->core, 1); /* Unconnected receive pin is idle high. */
}

static const TypeInfo core_type_info = {
    .name = TYPE_OT_UART_CORE_TEST,
    .parent = TYPE_SYS_BUS_DEVICE,
    .instance_size = sizeof(OtUartCoreTestState),
    .instance_init = core_init,
};

static void core_register_types(void)
{
    type_register_static(&core_type_info);
}

type_init(core_register_types)
