module {
 hw.module private @example_prim_reg_we_check(in %ecc_err_i : i32, out value : i32) {
   hw.output %ecc_err_i : i32
 }
 hw.module @demo(in %addr : i32, in %wdata : i32, in %wr : i1,
                 in %x_a_address : i32, in %x_a_valid : i1,
                 in %rst_diagnostic_ni : i1, out rdata : i32) {
   %v = hw.instance "u" @example_prim_reg_we_check(ecc_err_i: %wdata: i32) -> (value: i32)
   hw.output %v : i32
 }
}
