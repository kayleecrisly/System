// Synthetic integration fixture; the output deliberately carries an error-like
// input name without giving it any vendor-specific semantics.
module example_prim_reg_we_check(input logic [31:0] ecc_err_i,
                                 output logic [31:0] value);
  assign value = ecc_err_i;
endmodule
module demo(input logic [31:0] addr, wdata, x_a_address,
            input logic wr, x_a_valid, rst_diagnostic_ni,
            output logic [31:0] rdata);
  example_prim_reg_we_check u(.ecc_err_i(wdata), .value(rdata));
endmodule
