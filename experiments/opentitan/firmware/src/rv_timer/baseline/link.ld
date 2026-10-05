OUTPUT_ARCH(riscv)
ENTRY(_ottf_start)
/* Preserve official DV log metadata for the experiment observer. */
_dv_log_offset = 0;
MEMORY {
  flash (rx) : ORIGIN = 0x20000000, LENGTH = 0x100000
  sram (rwx) : ORIGIN = 0x10000000, LENGTH = 0x20000
}
SECTIONS {
  .vectors : ALIGN(256) { KEEP(*(.vectors)) } > flash
  .crt : ALIGN(4) { KEEP(*(.crt)) } > flash
  .text : ALIGN(4) {
    _text_start = .;
    *(.text .text.*)
    _text_end = .;
  } > flash
  .rodata : ALIGN(4) { *(.rodata .rodata.*) *(.srodata .srodata.*) } > flash
  .logs.fields : ALIGN(4) { *(.logs.fields) } > flash
  .data : ALIGN(4) {
    _data_start = .;
    __global_pointer$ = . + 0x800;
    *(.data .data.* .sdata .sdata.*)
    . = ALIGN(4);
    _data_end = .;
  } > sram AT > flash
  _data_init_start = LOADADDR(.data);
  .bss (NOLOAD) : ALIGN(4) {
    _bss_start = .;
    *(.bss .bss.* .sbss .sbss.* COMMON)
    . = ALIGN(4);
    _bss_end = .;
  } > sram
  _stack_end = ORIGIN(sram) + LENGTH(sram);
  /DISCARD/ : { *(.comment) *(.eh_frame*) }
  ASSERT(_bss_end + 0x2000 <= _stack_end, "Insufficient stack")
}
