/* Earl Grey platform input, matching top_earlgrey_memory.h. */
#ifndef OPENTITAN_EXPERIMENT_DT_IBEX_H_
#define OPENTITAN_EXPERIMENT_DT_IBEX_H_
#include <stdint.h>
typedef enum dt_rv_core_ibex { kDtRvCoreIbex0, kDtRvCoreIbexCount } dt_rv_core_ibex_t;
static inline uintptr_t dt_rv_core_ibex_primary_reg_block(dt_rv_core_ibex_t dt) {
  (void)dt;
  return (uintptr_t)0x411f0000u;
}
#endif
