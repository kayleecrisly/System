/* Diagnostic only: exercise generated core APIs before CPU integration.
 * No QEMU wrapper-side byte FIFO or direct model-state completion writes.
 */
#include "uart.h"
#include <stdio.h>

int main(void)
{
    static uart_state s;
    s.cio_rx_i = 1;
    uart_reset(&s);
    printf("reset STATUS=%08llx\n", (unsigned long long)uart_read(&s, 0x14, 4));
    uart_write(&s, 0x10, 0x10000013, 4); /* NCO, TX/RX, system loopback */
    uart_write(&s, 0x20, 3, 4); /* reset both FIFOs */
    printf("configured CTRL=%08llx STATUS=%08llx\n",
           (unsigned long long)uart_read(&s, 0x10, 4),
           (unsigned long long)uart_read(&s, 0x14, 4));
    uart_write(&s, 0x1c, 0x53, 4);
    for (unsigned i = 0; i < 20000; ++i) {
        uart_step(&s);
        if (i % 16 == 0) {
            unsigned status = uart_read(&s, 0x14, 4);
            if (!(status & (1u << 5))) {
                unsigned byte = uart_read(&s, 0x18, 4) & 0xffu;
                printf("received=%02x step=%u STATUS=%08x\n", byte, i, status);
                return byte == 0x53 ? 0 : 1;
            }
        }
    }
    printf("timeout STATUS=%08llx\n", (unsigned long long)uart_read(&s, 0x14, 4));
    return 2;
}
