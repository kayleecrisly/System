/* Earl Grey platform input, matching top_earlgrey_memory.h. */
#ifndef OPENTITAN_EXPERIMENT_DT_UART_H_
#define OPENTITAN_EXPERIMENT_DT_UART_H_
#include <stdint.h>
typedef enum dt_uart { kDtUart0, kDtUart1, kDtUart2, kDtUart3, kDtUartCount } dt_uart_t;
typedef enum dt_uart_irq {
  kDtUartIrqTxWatermark, kDtUartIrqRxWatermark, kDtUartIrqTxDone,
  kDtUartIrqRxOverflow, kDtUartIrqRxFrameErr, kDtUartIrqRxBreakErr,
  kDtUartIrqRxTimeout, kDtUartIrqRxParityErr, kDtUartIrqTxEmpty,
  kDtUartIrqCount,
} dt_uart_irq_t;
static inline uintptr_t dt_uart_primary_reg_block(dt_uart_t dt) {
  return (uintptr_t)0x40000000u + (uintptr_t)dt * 0x10000u;
}
#endif
