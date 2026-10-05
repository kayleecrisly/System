/* Minimal experiment harness. The official UART test, CHECK macros, DIF,
 * device_sim_dv constants and assembly runtime remain unmodified. */
#include <stdbool.h>
#include <stdint.h>
#include "sw/device/lib/arch/device.h"
#include "sw/device/lib/runtime/log.h"
#include "sw/device/lib/testing/test_framework/status.h"

extern bool test_main(void);
volatile uint32_t experiment_failure_line;
volatile uint32_t experiment_trap_cause;
volatile uint32_t experiment_trap_pc;
volatile uint32_t experiment_trap_value;

void test_status_set(test_status_t status) {
  *(volatile uint32_t *)device_test_status_address() = (uint32_t)status;
  if (status == kTestStatusPassed || status == kTestStatusFailed) {
    for (;;) {
      __asm__ volatile("wfi");
    }
  }
}

/* Preserve failure metadata without using the UART under test for logging. */
void base_log_internal_dv(const log_fields_t *log, uint32_t nargs, ...) {
  (void)nargs;
  experiment_failure_line = log->line;
  *(volatile uint32_t *)device_log_bypass_uart_address() = (uintptr_t)log;
}
void base_log_internal_core(const log_fields_t *log, ...) {
  experiment_failure_line = log->line;
}

void _ottf_main(void) {
  test_status_set(kTestStatusInTest);
  bool success = test_main();
  test_status_set(success ? kTestStatusPassed : kTestStatusFailed);
}

__attribute__((noreturn)) void experiment_trap(void) {
  __asm__ volatile("csrr %0, mcause" : "=r"(experiment_trap_cause));
  __asm__ volatile("csrr %0, mepc" : "=r"(experiment_trap_pc));
  __asm__ volatile("csrr %0, mtval" : "=r"(experiment_trap_value));
  test_status_set(kTestStatusFailed);
  __builtin_unreachable();
}

__attribute__((noreturn)) void __assert_fail(const char *expr, const char *file,
                                           unsigned line, const char *function) {
  (void)expr; (void)file; (void)function;
  experiment_failure_line = line;
  test_status_set(kTestStatusFailed);
  __builtin_unreachable();
}
