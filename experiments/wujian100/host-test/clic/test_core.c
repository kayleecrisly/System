/* Host-only check of the generated RTL core. No CPU/firmware execution.
 * Drives the original TCIP signals, not the generic SysBus wrapper.
 * Reference: E902_20191018.v cr_clic_reg_if/cr_clic_kid/cr_clic_arb.
 * The board fixes pad_clic_int_cfg=0 (level-sensitive inputs).
 */
#include "cr_clic_top.h"
#include <inttypes.h>

static cr_clic_top_state s;
static unsigned checks, failures;

static void check(const char *name, uint64_t got, uint64_t expected)
{
    ++checks;
    failures += got != expected;
    printf("%s %s got=0x%" PRIx64 " expected=0x%" PRIx64 "\n",
           got == expected ? "PASS" : "FAIL", name, got, expected);
}

static void clocks(unsigned n)
{
    while (n--) cr_clic_top_step(&s);
}

/* size is the TCIP log2 transfer size; write data uses addressed lanes.
 * Four clocks allow output pipeline registers to propagate. Holding a
 * register write for four cycles is idempotent for the registers tested.
 */
static void write_reg(uint16_t addr, uint32_t value, unsigned size)
{
    s.tcipif_clic_addr = addr;
    s.tcipif_clic_size = size;
    s.tcipif_clic_wdata = value << (8 * (addr & 3));
    s.tcipif_clic_write = 1;
    s.tcipif_clic_sel = 1;
    clocks(4);
    s.tcipif_clic_sel = 0;
    s.tcipif_clic_write = 0;
    clocks(4);
}

static uint32_t read_reg(uint16_t addr, unsigned size)
{
    s.tcipif_clic_addr = addr;
    s.tcipif_clic_size = size;
    s.tcipif_clic_write = 0;
    s.tcipif_clic_sel = 1;
    clocks(4);
    uint32_t value = s.clic_tcipif_rdata >> (8 * (addr & 3));
    s.tcipif_clic_sel = 0;
    clocks(4);
    return value & (size == 0 ? 0xffu : size == 1 ? 0xffffu : 0xffffffffu);
}

static void inputs(uint64_t mask)
{
    s.pad_clic_int_vld = mask;
    clocks(8);
}

int main(void)
{
    s.pad_clic_int_cfg = 0;
    cr_clic_top_reset(&s);
    clocks(8);
    check("reset.CLICCFG", read_reg(0xec00, 0), 0);
    check("reset.IE17", read_reg(0xe511, 0), 0);
    check("reset.CFG17", read_reg(0xe911, 0), 0x1f);
    check("reset.interrupt_level", s.clic_pad_int_il, 0);
    write_reg(0xec00, 4, 0);
    check("CLICCFG.nlbits2", read_reg(0xec00, 0), 4);
    write_reg(0xe511, 1, 0);
    check("byte.IE17", read_reg(0xe511, 0), 1);
    check("byte.IE16_unchanged", read_reg(0xe510, 0), 0);
    check("byte.IE18_unchanged", read_reg(0xe512, 0), 0);
    inputs(UINT64_C(1) << 17);
    check("assert.IP17", read_reg(0xe111, 0), 1);
    check("assert.IRQ17.id", s.clic_pad_int_id, 17);
    check("assert.IRQ17.level", s.clic_pad_int_il, 0x3f);
    check("assert.IRQ17.priv", s.clic_pad_int_priv, 3);
    check("assert.IRQ17.hv", s.clic_pad_int_hv, 0);
    write_reg(0xe111, 0, 0);
    check("level.software_clear_cannot_override_input", read_reg(0xe111, 0), 1);
    inputs(0);
    check("deassert.IP17", read_reg(0xe111, 0), 0);
    check("deassert.interrupt_level", s.clic_pad_int_il, 0);
    write_reg(0xe512, 1, 0);
    inputs((UINT64_C(1) << 17) | (UINT64_C(1) << 18));
    check("tie.higher_id", s.clic_pad_int_id, 18);
    write_reg(0xe911, 0x80, 0);
    check("priority.CFG17", read_reg(0xe911, 0), 0x9f);
    check("priority.higher_priority_id", s.clic_pad_int_id, 17);
    check("priority.level", s.clic_pad_int_il, 0xbf);
    /* Deassert first: RTL retains already latched outputs when the
     * threshold is raised. CLICTH occupies word[31:24], byte EC07. */
    inputs(0);
    write_reg(0xec07, 0xff, 0);
    check("threshold.readback", read_reg(0xec07, 0), 0xff);
    inputs(UINT64_C(1) << 17);
    check("threshold.suppresses_interrupt", s.clic_pad_int_il, 0);
    write_reg(0xec08, 17, 1);
    check("threshold.return_id", read_reg(0xec08, 1), 17);
    s.cpu_clic_curid = 18;
    s.cpu_clic_int_exit = 1;
    clocks(4);
    s.cpu_clic_int_exit = 0;
    check("return.wrong_id_preserves_threshold", read_reg(0xec07, 0), 0xff);
    s.cpu_clic_curid = 17;
    s.cpu_clic_int_exit = 1;
    clocks(4);
    s.cpu_clic_int_exit = 0;
    check("return.match_clears_threshold", read_reg(0xec07, 0), 0);
    check("return.interrupt_restored", s.clic_pad_int_il, 0xbf);
    inputs(0);
    write_reg(0xe510, 0x01010101, 2);
    check("word.IE16_19", read_reg(0xe510, 2), 0x01010101);
    write_reg(0xe512, 0, 1);
    check("halfword.IE18_19_only", read_reg(0xe510, 2), 0x00000101);
    printf("RESULT checks=%u failures=%u firmware_executed=false\n", checks, failures);
    return failures ? 1 : 0;
}
