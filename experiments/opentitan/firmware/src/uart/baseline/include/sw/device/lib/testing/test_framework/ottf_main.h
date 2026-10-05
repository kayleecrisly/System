/* Experiment adapter: the official test body/config are retained; no RTOS. */
#ifndef OPENTITAN_EXPERIMENT_OTTF_MAIN_H_
#define OPENTITAN_EXPERIMENT_OTTF_MAIN_H_
#include <stdbool.h>
#include "sw/device/lib/testing/test_framework/ottf_test_config.h"
extern bool test_main(void);
#endif
