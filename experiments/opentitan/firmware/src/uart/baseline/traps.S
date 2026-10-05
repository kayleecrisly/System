/* All unexpected exceptions/interrupts terminate this polling experiment. */
.section .text.traps, "ax", @progbits
.balign 4
.global handler_exception, handler_irq_software, handler_irq_timer
.global handler_irq_external, handler_irq_internal
handler_exception:
handler_irq_software:
handler_irq_timer:
handler_irq_external:
handler_irq_internal:
  tail experiment_trap
