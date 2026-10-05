/* stub: minimal QEMU surface so a generated model compiles standalone for model-level tests */
#pragma once
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
typedef uint64_t hwaddr;
typedef struct DeviceState DeviceState;
typedef struct Object Object;
typedef struct MemoryRegion { int _; } MemoryRegion;
typedef struct IRQState *qemu_irq;
static inline void qemu_irq_raise(qemu_irq irq) { (void)irq; }
static inline void qemu_irq_lower(qemu_irq irq) { (void)irq; }
static inline void qemu_set_irq(qemu_irq irq, int level) { (void)irq; (void)level; }
/* ptimer stub with QEMU-like LEGACY oneshot semantics: after ptimer_run the count
 * decrements at `freq` per second of WALL time (QEMU virtual clock tracks wall clock);
 * ptimer_get_count returns the live remaining count (0 once expired). */
#include <time.h>
typedef struct ptimer_state { uint64_t count; uint32_t freq; int running; double t0; } ptimer_state;
#define PTIMER_POLICY_LEGACY 0
static inline double qp_stub_now_s(void){ struct timespec t; clock_gettime(CLOCK_MONOTONIC,&t); return t.tv_sec + t.tv_nsec*1e-9; }
static inline ptimer_state *ptimer_init(void (*cb)(void *), void *opaque, int policy) { (void)cb;(void)opaque;(void)policy; return (ptimer_state *)calloc(1, sizeof(ptimer_state)); }
static inline void ptimer_set_freq(ptimer_state *p, uint32_t f) { p->freq = f; }
static inline void ptimer_set_count(ptimer_state *p, uint64_t c) { p->count = c; p->t0 = qp_stub_now_s(); }
static inline uint64_t ptimer_get_count(ptimer_state *p) {
    if (!p->running || !p->freq) return p->count;
    double el = (qp_stub_now_s() - p->t0) * p->freq;
    return el >= (double)p->count ? 0 : p->count - (uint64_t)el;
}
static inline void ptimer_run(ptimer_state *p, int oneshot) { (void)oneshot; p->running = 1; p->t0 = qp_stub_now_s(); }
static inline void ptimer_stop(ptimer_state *p) { (void)p; }
static inline void ptimer_transaction_begin(ptimer_state *p) { (void)p; }
static inline void ptimer_transaction_commit(ptimer_state *p) { (void)p; }
#define qemu_log_mask(...) do {} while (0)
#define LOG_GUEST_ERROR 0
#define LOG_UNIMP 0
/* QOM / sysbus / memory-region boilerplate stubs (realize/type_init are never called in harness) */
typedef struct SysBusDevice { int _; } SysBusDevice;
typedef struct Error Error;
typedef struct ObjectClass ObjectClass;
typedef struct DeviceClass { void (*realize)(DeviceState *, Error **); } DeviceClass;
typedef struct MemoryRegionOps {
    uint64_t (*read)(void *opaque, hwaddr addr, unsigned size);
    void (*write)(void *opaque, hwaddr addr, uint64_t data, unsigned size);
    int endianness;
    struct { unsigned min_access_size, max_access_size; } impl;
} MemoryRegionOps;
#define DEVICE_LITTLE_ENDIAN 0
#define DEVICE_NATIVE_ENDIAN 0
static inline void memory_region_init_io(MemoryRegion *mr, Object *o, const MemoryRegionOps *ops, void *opaque, const char *name, uint64_t size) { (void)mr;(void)o;(void)ops;(void)opaque;(void)name;(void)size; }
#define OBJECT(x) ((Object *)(x))
#define SYS_BUS_DEVICE(x) ((SysBusDevice *)(x))
#define DEVICE_CLASS(x) ((DeviceClass *)(x))
#define OBJECT_CHECK(type, obj, name) ((type *)(obj))
static inline void sysbus_init_mmio(SysBusDevice *d, MemoryRegion *mr) { (void)d;(void)mr; }
static inline void sysbus_init_irq(SysBusDevice *d, qemu_irq *irq) { (void)d;(void)irq; }
typedef struct TypeInfo { const char *name, *parent; size_t instance_size; void (*class_init)(ObjectClass *, const void *); } TypeInfo;
#define TYPE_SYS_BUS_DEVICE "sys-bus-device"
static inline void type_register_static(const TypeInfo *t) { (void)t; }
#define type_init(fn) static void __attribute__((constructor)) fn##_ctor(void) { fn(); }
