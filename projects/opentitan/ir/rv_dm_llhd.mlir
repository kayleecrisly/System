module {
  hw.module private @prim_and2(in %in0_i : i109, in %in1_i : i109, out out_o : i109) {
    %0 = comb.and %in0_i, %in1_i : i109
    hw.output %0 : i109
  }
  hw.module private @prim_and2_19(in %in0_i : i66, in %in1_i : i66, out out_o : i66) {
    %0 = comb.and %in0_i, %in1_i : i66
    hw.output %0 : i66
  }
  hw.module private @prim_buf(in %in_i : i1, out out_o : i1) {
    hw.output %in_i : i1
  }
  hw.module private @prim_buf_12(in %in_i : i3, out out_o : i3) {
    hw.output %in_i : i3
  }
  hw.module private @prim_buf_15(in %in_i : i2, out out_o : i2) {
    hw.output %in_i : i2
  }
  hw.module private @prim_clock_inv(in %clk_i : i1, in %scanmode_i : i1, out clk_no : i1) {
    %true = hw.constant true
    %0 = comb.xor %clk_i, %true : i1
    %gen_scan.i_dft_tck_mux.clk_o = hw.instance "gen_scan.i_dft_tck_mux" @prim_clock_mux2(clk0_i: %0: i1, clk1_i: %clk_i: i1, sel_i: %scanmode_i: i1) -> (clk_o: i1)
    hw.output %gen_scan.i_dft_tck_mux.clk_o : i1
  }
  hw.module private @prim_clock_mux2(in %clk0_i : i1, in %clk1_i : i1, in %sel_i : i1, out clk_o : i1) {
    %true = hw.constant true
    %0 = comb.and %sel_i, %clk1_i : i1
    %1 = comb.xor %sel_i, %true : i1
    %2 = comb.and %1, %clk0_i : i1
    %3 = comb.or %0, %2 : i1
    hw.output %3 : i1
  }
  hw.module private @prim_flop_2sync(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %d_i_0 = llhd.sig name "d_i" %false : i1
    %d_o = llhd.sig %false : i1
    %1 = llhd.prb %d_o : i1
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i1) -> (q_o: i1) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i1) -> (q_o: i1)
    %2 = llhd.prb %d_i_0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %3 = llhd.prb %d_i_0 : i1
      llhd.drv %d_o, %3 after %0 : i1
      llhd.wait (%2, %1 : i1, i1), ^bb1
    }
    llhd.drv %d_i_0, %d_i after %0 : i1
    hw.output %u_sync_2.q_o : i1
  }
  hw.module private @prim_flop_2sync_1(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %d_i_0 = llhd.sig name "d_i" %false : i1
    %d_o = llhd.sig %false : i1
    %1 = llhd.prb %d_o : i1
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_8(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i1) -> (q_o: i1) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_8(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i1) -> (q_o: i1)
    %2 = llhd.prb %d_i_0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %3 = llhd.prb %d_i_0 : i1
      llhd.drv %d_o, %3 after %0 : i1
      llhd.wait (%2, %1 : i1, i1), ^bb1
    }
    llhd.drv %d_i_0, %d_i after %0 : i1
    hw.output %u_sync_2.q_o : i1
  }
  hw.module private @prim_flop_2sync_6(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %d_i_0 = llhd.sig name "d_i" %c0_i4 : i4
    %d_o = llhd.sig %c0_i4 : i4
    %1 = llhd.prb %d_o : i4
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_17(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i4) -> (q_o: i4) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_17(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i4) -> (q_o: i4)
    %2 = llhd.prb %d_i_0 : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %3 = llhd.prb %d_i_0 : i4
      llhd.drv %d_o, %3 after %0 : i4
      llhd.wait (%2, %1 : i4, i4), ^bb1
    }
    llhd.drv %d_i_0, %d_i after %0 : i4
    hw.output %u_sync_2.q_o : i4
  }
  hw.module private @prim_flop_2sync_7(in %clk_i : i1, in %rst_ni : i1, in %d_i : i8, out q_o : i8) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i8 = hw.constant 0 : i8
    %d_i_0 = llhd.sig name "d_i" %c0_i8 : i8
    %d_o = llhd.sig %c0_i8 : i8
    %1 = llhd.prb %d_o : i8
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_18(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i8) -> (q_o: i8) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_18(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i8) -> (q_o: i8)
    %2 = llhd.prb %d_i_0 : i8
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %3 = llhd.prb %d_i_0 : i8
      llhd.drv %d_o, %3 after %0 : i8
      llhd.wait (%2, %1 : i8, i8), ^bb1
    }
    llhd.drv %d_i_0, %d_i after %0 : i8
    hw.output %u_sync_2.q_o : i8
  }
  hw.module private @prim_flop(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %d_i_2 = llhd.sig name "d_i" %false : i1
    %q_o = llhd.sig %false : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %5 = llhd.prb %clk_i_0 : i1
      %6 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %7 = llhd.prb %clk_i_0 : i1
      %8 = comb.xor bin %5, %true : i1
      %9 = comb.and bin %8, %7 : i1
      %10 = llhd.prb %rst_ni_1 : i1
      %11 = comb.xor bin %10, %true : i1
      %12 = comb.and bin %6, %11 : i1
      %13 = comb.or bin %9, %12 : i1
      cf.cond_br %13, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %14 = llhd.prb %rst_ni_1 : i1
      %15 = comb.xor %14, %true : i1
      cf.cond_br %15, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %q_o, %true after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %16 = llhd.prb %d_i_2 : i1
      llhd.drv %q_o, %16 after %1 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %d_i_2, %d_i after %0 : i1
    %4 = llhd.prb %q_o : i1
    hw.output %4 : i1
  }
  hw.module private @prim_flop_8(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %d_i_2 = llhd.sig name "d_i" %false : i1
    %q_o = llhd.sig %false : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %5 = llhd.prb %clk_i_0 : i1
      %6 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %7 = llhd.prb %clk_i_0 : i1
      %8 = comb.xor bin %5, %true : i1
      %9 = comb.and bin %8, %7 : i1
      %10 = llhd.prb %rst_ni_1 : i1
      %11 = comb.xor bin %10, %true : i1
      %12 = comb.and bin %6, %11 : i1
      %13 = comb.or bin %9, %12 : i1
      cf.cond_br %13, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %14 = llhd.prb %rst_ni_1 : i1
      %15 = comb.xor %14, %true : i1
      cf.cond_br %15, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %q_o, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %16 = llhd.prb %d_i_2 : i1
      llhd.drv %q_o, %16 after %1 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %d_i_2, %d_i after %0 : i1
    %4 = llhd.prb %q_o : i1
    hw.output %4 : i1
  }
  hw.module private @prim_flop_16(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_o : i2) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i2 = hw.constant 0 : i2
    %c-2_i2 = hw.constant -2 : i2
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %d_i_2 = llhd.sig name "d_i" %c0_i2 : i2
    %q_o = llhd.sig %c0_i2 : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %5 = llhd.prb %clk_i_0 : i1
      %6 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %7 = llhd.prb %clk_i_0 : i1
      %8 = comb.xor bin %5, %true : i1
      %9 = comb.and bin %8, %7 : i1
      %10 = llhd.prb %rst_ni_1 : i1
      %11 = comb.xor bin %10, %true : i1
      %12 = comb.and bin %6, %11 : i1
      %13 = comb.or bin %9, %12 : i1
      cf.cond_br %13, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %14 = llhd.prb %rst_ni_1 : i1
      %15 = comb.xor %14, %true : i1
      cf.cond_br %15, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %q_o, %c-2_i2 after %1 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %16 = llhd.prb %d_i_2 : i2
      llhd.drv %q_o, %16 after %1 : i2
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %d_i_2, %d_i after %0 : i2
    %4 = llhd.prb %q_o : i2
    hw.output %4 : i2
  }
  hw.module private @prim_flop_17(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i4 = hw.constant 0 : i4
    %c-6_i4 = hw.constant -6 : i4
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %d_i_2 = llhd.sig name "d_i" %c0_i4 : i4
    %q_o = llhd.sig %c0_i4 : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %5 = llhd.prb %clk_i_0 : i1
      %6 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %7 = llhd.prb %clk_i_0 : i1
      %8 = comb.xor bin %5, %true : i1
      %9 = comb.and bin %8, %7 : i1
      %10 = llhd.prb %rst_ni_1 : i1
      %11 = comb.xor bin %10, %true : i1
      %12 = comb.and bin %6, %11 : i1
      %13 = comb.or bin %9, %12 : i1
      cf.cond_br %13, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %14 = llhd.prb %rst_ni_1 : i1
      %15 = comb.xor %14, %true : i1
      cf.cond_br %15, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %q_o, %c-6_i4 after %1 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %16 = llhd.prb %d_i_2 : i4
      llhd.drv %q_o, %16 after %1 : i4
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %d_i_2, %d_i after %0 : i4
    %4 = llhd.prb %q_o : i4
    hw.output %4 : i4
  }
  hw.module private @prim_flop_18(in %clk_i : i1, in %rst_ni : i1, in %d_i : i8, out q_o : i8) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i8 = hw.constant 0 : i8
    %c105_i8 = hw.constant 105 : i8
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %d_i_2 = llhd.sig name "d_i" %c0_i8 : i8
    %q_o = llhd.sig %c0_i8 : i8
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %5 = llhd.prb %clk_i_0 : i1
      %6 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %7 = llhd.prb %clk_i_0 : i1
      %8 = comb.xor bin %5, %true : i1
      %9 = comb.and bin %8, %7 : i1
      %10 = llhd.prb %rst_ni_1 : i1
      %11 = comb.xor bin %10, %true : i1
      %12 = comb.and bin %6, %11 : i1
      %13 = comb.or bin %9, %12 : i1
      cf.cond_br %13, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %14 = llhd.prb %rst_ni_1 : i1
      %15 = comb.xor %14, %true : i1
      cf.cond_br %15, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %q_o, %c105_i8 after %1 : i8
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %16 = llhd.prb %d_i_2 : i8
      llhd.drv %q_o, %16 after %1 : i8
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %d_i_2, %d_i after %0 : i8
    %4 = llhd.prb %q_o : i8
    hw.output %4 : i8
  }
  hw.module private @prim_flop_20(in %clk_i : i1, in %rst_ni : i1, in %d_i : i9, out q_o : i9) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i9 = hw.constant 0 : i9
    %c186_i9 = hw.constant 186 : i9
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %d_i_2 = llhd.sig name "d_i" %c0_i9 : i9
    %q_o = llhd.sig %c0_i9 : i9
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %5 = llhd.prb %clk_i_0 : i1
      %6 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %7 = llhd.prb %clk_i_0 : i1
      %8 = comb.xor bin %5, %true : i1
      %9 = comb.and bin %8, %7 : i1
      %10 = llhd.prb %rst_ni_1 : i1
      %11 = comb.xor bin %10, %true : i1
      %12 = comb.and bin %6, %11 : i1
      %13 = comb.or bin %9, %12 : i1
      cf.cond_br %13, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %14 = llhd.prb %rst_ni_1 : i1
      %15 = comb.xor %14, %true : i1
      cf.cond_br %15, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %q_o, %c186_i9 after %1 : i9
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %16 = llhd.prb %d_i_2 : i9
      llhd.drv %q_o, %16 after %1 : i9
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %d_i_2, %d_i after %0 : i9
    %4 = llhd.prb %q_o : i9
    hw.output %4 : i9
  }
  hw.module private @prim_alert_sender(in %clk_i : i1, in %rst_ni : i1, in %alert_test_i : i1, in %alert_req_i : i1, out alert_ack_o : i1, out alert_state_o : i1, in %alert_rx_i : !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>, out alert_tx_o : !hw.struct<alert_p: i1, alert_n: i1>) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [false, false] : !hw.struct<alert_p: i1, alert_n: i1>
    %c-2_i3 = hw.constant -2 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c-3_i3 = hw.constant -3 : i3
    %c2_i3 = hw.constant 2 : i3
    %c3_i3 = hw.constant 3 : i3
    %c1_i3 = hw.constant 1 : i3
    %c0_i3 = hw.constant 0 : i3
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %alert_tx_o = llhd.sig %2 : !hw.struct<alert_p: i1, alert_n: i1>
    %ack_level = llhd.sig %false : i1
    %state_d = llhd.sig %c0_i3 : i3
    %state_q = llhd.sig %c0_i3 : i3
    %alert_pd = llhd.sig %false : i1
    %alert_nd = llhd.sig %false : i1
    %sigint_detected = llhd.sig %false : i1
    %alert_set_d = llhd.sig %false : i1
    %alert_set_q = llhd.sig %false : i1
    %alert_clr = llhd.sig %false : i1
    %alert_test_set_d = llhd.sig %false : i1
    %alert_test_set_q = llhd.sig %false : i1
    %ping_set_d = llhd.sig %false : i1
    %ping_set_q = llhd.sig %false : i1
    %ping_clr = llhd.sig %false : i1
    %alert_test_trigger = llhd.sig %false : i1
    %ping_trigger = llhd.sig %false : i1
    %alert_trigger = llhd.sig %false : i1
    %ping_n = hw.struct_extract %alert_rx_i["ping_n"] : !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>
    %ping_p = hw.struct_extract %alert_rx_i["ping_p"] : !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>
    %5 = comb.concat %ping_n, %ping_p : i1, i1
    %u_prim_buf_ping.out_o = hw.instance "u_prim_buf_ping" @prim_sec_anchor_buf(in_i: %5: i2) -> (out_o: i2)
    %6 = comb.extract %u_prim_buf_ping.out_o from 1 {sv.namehint = "ping_n"} : (i2) -> i1
    %7 = comb.extract %u_prim_buf_ping.out_o from 0 {sv.namehint = "ping_p"} : (i2) -> i1
    %u_decode_ping.level_o, %u_decode_ping.rise_o, %u_decode_ping.fall_o, %u_decode_ping.event_o, %u_decode_ping.sigint_o = hw.instance "u_decode_ping" @prim_diff_decode(clk_i: %3: i1, rst_ni: %4: i1, diff_pi: %7: i1, diff_ni: %6: i1) -> (level_o: i1, rise_o: i1, fall_o: i1, event_o: i1, sigint_o: i1) {sv.namehint = "ping_event"}
    %ack_n = hw.struct_extract %alert_rx_i["ack_n"] : !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>
    %ack_p = hw.struct_extract %alert_rx_i["ack_p"] : !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>
    %8 = comb.concat %ack_n, %ack_p : i1, i1
    %u_prim_buf_ack.out_o = hw.instance "u_prim_buf_ack" @prim_sec_anchor_buf(in_i: %8: i2) -> (out_o: i2)
    %9 = comb.extract %u_prim_buf_ack.out_o from 1 {sv.namehint = "ack_n"} : (i2) -> i1
    %10 = comb.extract %u_prim_buf_ack.out_o from 0 {sv.namehint = "ack_p"} : (i2) -> i1
    %u_decode_ack.level_o, %u_decode_ack.rise_o, %u_decode_ack.fall_o, %u_decode_ack.event_o, %u_decode_ack.sigint_o = hw.instance "u_decode_ack" @prim_diff_decode(clk_i: %3: i1, rst_ni: %4: i1, diff_pi: %10: i1, diff_ni: %9: i1) -> (level_o: i1, rise_o: i1, fall_o: i1, event_o: i1, sigint_o: i1) {sv.namehint = "ack_sigint"}
    llhd.drv %ack_level, %u_decode_ack.level_o after %1 : i1
    %u_prim_buf_in_req.out_o = hw.instance "u_prim_buf_in_req" @prim_sec_anchor_buf_5(in_i: %alert_req_i: i1) -> (out_o: i1) {sv.namehint = "alert_req"}
    %11 = llhd.prb %alert_nd : i1
    %12 = llhd.prb %alert_pd : i1
    %13 = comb.concat %11, %12 : i1, i1
    %u_prim_flop_alert.q_o = hw.instance "u_prim_flop_alert" @prim_sec_anchor_flop(clk_i: %3: i1, rst_ni: %4: i1, d_i: %13: i2) -> (q_o: i2)
    %14 = comb.extract %u_prim_flop_alert.q_o from 1 {sv.namehint = "alert_nq"} : (i2) -> i1
    %15 = comb.extract %u_prim_flop_alert.q_o from 0 {sv.namehint = "alert_pq"} : (i2) -> i1
    %16 = comb.or %u_decode_ack.sigint_o, %u_decode_ping.sigint_o : i1
    llhd.drv %sigint_detected, %16 after %1 : i1
    %17 = llhd.sig.struct_extract %alert_tx_o["alert_p"] : <!hw.struct<alert_p: i1, alert_n: i1>>
    llhd.drv %17, %15 after %1 : i1
    %18 = llhd.sig.struct_extract %alert_tx_o["alert_n"] : <!hw.struct<alert_p: i1, alert_n: i1>>
    llhd.drv %18, %14 after %1 : i1
    %19 = llhd.prb %alert_set_q : i1
    %20 = comb.or %u_prim_buf_in_req.out_o, %19 {sv.namehint = "alert_req_trigger"} : i1
    llhd.drv %alert_set_d, %20 after %1 : i1
    %21 = llhd.prb %alert_test_set_q : i1
    %22 = comb.or %alert_test_i, %21 : i1
    llhd.drv %alert_test_trigger, %22 after %1 : i1
    %23 = llhd.prb %alert_clr : i1
    %24 = llhd.prb %alert_test_trigger : i1
    %25 = comb.xor %23, %true : i1
    %26 = comb.and %25, %24 : i1
    llhd.drv %alert_test_set_d, %26 after %1 : i1
    %27 = comb.or %20, %24 : i1
    llhd.drv %alert_trigger, %27 after %1 : i1
    %28 = llhd.prb %ping_set_q : i1
    %29 = comb.or %28, %u_decode_ping.event_o : i1
    llhd.drv %ping_trigger, %29 after %1 : i1
    %30 = llhd.prb %ping_clr : i1
    %31 = llhd.prb %ping_trigger : i1
    %32 = comb.xor %30, %true : i1
    %33 = comb.and %32, %31 : i1
    llhd.drv %ping_set_d, %33 after %1 : i1
    %34 = comb.and %23, %19 : i1
    %35 = llhd.prb %state_q : i3
    %36 = llhd.prb %state_d : i3
    %37 = llhd.prb %alert_trigger : i1
    %38 = llhd.prb %sigint_detected : i1
    %39 = llhd.prb %ack_level : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb25
      %41 = llhd.prb %state_q : i3
      llhd.drv %state_d, %41 after %1 : i3
      llhd.drv %alert_pd, %false after %1 : i1
      llhd.drv %alert_nd, %true after %1 : i1
      llhd.drv %ping_clr, %false after %1 : i1
      llhd.drv %alert_clr, %false after %1 : i1
      %42 = llhd.prb %state_q : i3
      %43 = comb.icmp ceq %42, %c0_i3 : i3
      cf.cond_br %43, ^bb2, ^bb4
    ^bb2:  // pred: ^bb1
      %44 = llhd.prb %alert_trigger : i1
      %45 = llhd.prb %ping_trigger : i1
      %46 = comb.or %44, %45 : i1
      cf.cond_br %46, ^bb3, ^bb23
    ^bb3:  // pred: ^bb2
      %47 = llhd.prb %alert_trigger : i1
      %48 = comb.xor %47, %true : i1
      %49 = comb.concat %false, %48, %true : i1, i1, i1
      llhd.drv %state_d, %49 after %1 : i3
      llhd.drv %alert_pd, %true after %1 : i1
      llhd.drv %alert_nd, %false after %1 : i1
      cf.br ^bb23
    ^bb4:  // pred: ^bb1
      %50 = comb.icmp ceq %42, %c1_i3 : i3
      cf.cond_br %50, ^bb5, ^bb8
    ^bb5:  // pred: ^bb4
      %51 = llhd.prb %ack_level : i1
      cf.cond_br %51, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %state_d, %c2_i3 after %1 : i3
      cf.br ^bb23
    ^bb7:  // pred: ^bb5
      llhd.drv %alert_pd, %true after %1 : i1
      llhd.drv %alert_nd, %false after %1 : i1
      cf.br ^bb23
    ^bb8:  // pred: ^bb4
      %52 = comb.icmp ceq %42, %c2_i3 : i3
      cf.cond_br %52, ^bb9, ^bb11
    ^bb9:  // pred: ^bb8
      %53 = llhd.prb %ack_level : i1
      %54 = comb.xor %53, %true : i1
      cf.cond_br %54, ^bb10, ^bb23
    ^bb10:  // pred: ^bb9
      llhd.drv %state_d, %c-3_i3 after %1 : i3
      llhd.drv %alert_clr, %true after %1 : i1
      cf.br ^bb23
    ^bb11:  // pred: ^bb8
      %55 = comb.icmp ceq %42, %c3_i3 : i3
      cf.cond_br %55, ^bb12, ^bb15
    ^bb12:  // pred: ^bb11
      %56 = llhd.prb %ack_level : i1
      cf.cond_br %56, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      llhd.drv %state_d, %c-4_i3 after %1 : i3
      cf.br ^bb23
    ^bb14:  // pred: ^bb12
      llhd.drv %alert_pd, %true after %1 : i1
      llhd.drv %alert_nd, %false after %1 : i1
      cf.br ^bb23
    ^bb15:  // pred: ^bb11
      %57 = comb.icmp ceq %42, %c-4_i3 : i3
      cf.cond_br %57, ^bb16, ^bb18
    ^bb16:  // pred: ^bb15
      %58 = llhd.prb %ack_level : i1
      %59 = comb.xor %58, %true : i1
      cf.cond_br %59, ^bb17, ^bb23
    ^bb17:  // pred: ^bb16
      llhd.drv %ping_clr, %true after %1 : i1
      llhd.drv %state_d, %c-3_i3 after %1 : i3
      cf.br ^bb23
    ^bb18:  // pred: ^bb15
      %60 = comb.icmp ceq %42, %c-3_i3 : i3
      cf.cond_br %60, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      llhd.drv %state_d, %c-2_i3 after %1 : i3
      cf.br ^bb23
    ^bb20:  // pred: ^bb18
      %61 = comb.icmp ceq %42, %c-2_i3 : i3
      cf.cond_br %61, ^bb21, ^bb22
    ^bb21:  // pred: ^bb20
      llhd.drv %state_d, %c0_i3 after %1 : i3
      cf.br ^bb23
    ^bb22:  // pred: ^bb20
      llhd.drv %state_d, %c0_i3 after %1 : i3
      cf.br ^bb23
    ^bb23:  // 13 preds: ^bb2, ^bb3, ^bb6, ^bb7, ^bb9, ^bb10, ^bb13, ^bb14, ^bb16, ^bb17, ^bb19, ^bb21, ^bb22
      %62 = llhd.prb %sigint_detected : i1
      cf.cond_br %62, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      llhd.drv %state_d, %c0_i3 after %1 : i3
      llhd.drv %alert_pd, %false after %1 : i1
      llhd.drv %alert_nd, %false after %1 : i1
      llhd.drv %ping_clr, %true after %1 : i1
      llhd.drv %alert_clr, %false after %1 : i1
      cf.br ^bb25
    ^bb25:  // 2 preds: ^bb23, ^bb24
      llhd.wait (%35, %36, %12, %11, %30, %23, %37, %31, %38, %39 : i3, i3, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %41 = llhd.prb %clk_i_0 : i1
      %42 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %43 = llhd.prb %clk_i_0 : i1
      %44 = comb.xor bin %41, %true : i1
      %45 = comb.and bin %44, %43 : i1
      %46 = llhd.prb %rst_ni_1 : i1
      %47 = comb.xor bin %46, %true : i1
      %48 = comb.and bin %42, %47 : i1
      %49 = comb.or bin %45, %48 : i1
      cf.cond_br %49, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %50 = llhd.prb %rst_ni_1 : i1
      %51 = comb.xor %50, %true : i1
      cf.cond_br %51, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %state_q, %c0_i3 after %0 : i3
      llhd.drv %alert_set_q, %false after %0 : i1
      llhd.drv %alert_test_set_q, %false after %0 : i1
      llhd.drv %ping_set_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %52 = llhd.prb %state_d : i3
      llhd.drv %state_q, %52 after %0 : i3
      %53 = llhd.prb %alert_set_d : i1
      llhd.drv %alert_set_q, %53 after %0 : i1
      %54 = llhd.prb %alert_test_set_d : i1
      llhd.drv %alert_test_set_q, %54 after %0 : i1
      %55 = llhd.prb %ping_set_d : i1
      llhd.drv %ping_set_q, %55 after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    %40 = llhd.prb %alert_tx_o : !hw.struct<alert_p: i1, alert_n: i1>
    hw.output %34, %19, %40 : i1, i1, !hw.struct<alert_p: i1, alert_n: i1>
  }
  hw.module private @prim_blanker(in %in_i : i109, in %en_i : i1, out out_o : i109) {
    %0 = comb.replicate %en_i : (i1) -> i109
    %u_blank_and.out_o = hw.instance "u_blank_and" @prim_and2(in0_i: %in_i: i109, in1_i: %0: i109) -> (out_o: i109)
    hw.output %u_blank_and.out_o : i109
  }
  hw.module private @prim_blanker_10(in %in_i : i66, in %en_i : i1, out out_o : i66) {
    %0 = comb.replicate %en_i : (i1) -> i66
    %u_blank_and.out_o = hw.instance "u_blank_and" @prim_and2_19(in0_i: %in_i: i66, in1_i: %0: i66) -> (out_o: i66)
    hw.output %u_blank_and.out_o : i66
  }
  hw.module private @prim_diff_decode(in %clk_i : i1, in %rst_ni : i1, in %diff_pi : i1, in %diff_ni : i1, out level_o : i1, out rise_o : i1, out fall_o : i1, out event_o : i1, out sigint_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c1_i2 = hw.constant 1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %true = hw.constant true
    %c0_i2 = hw.constant 0 : i2
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %rise_o = llhd.sig %false : i1
    %fall_o = llhd.sig %false : i1
    %sigint_o = llhd.sig %false : i1
    %level_d = llhd.sig %false : i1
    %level_q = llhd.sig %false : i1
    %gen_async.state_d = llhd.sig %c0_i2 : i2
    %gen_async.state_q = llhd.sig %c0_i2 : i2
    %gen_async.diff_p_edge = llhd.sig %false : i1
    %gen_async.diff_n_edge = llhd.sig %false : i1
    %gen_async.diff_check_ok = llhd.sig %false : i1
    %gen_async.level = llhd.sig %false : i1
    %gen_async.diff_pq = llhd.sig %false : i1
    %gen_async.diff_nq = llhd.sig %false : i1
    %gen_async.diff_pd = llhd.sig %false : i1
    %gen_async.diff_nd = llhd.sig %false : i1
    %gen_async.skew_cnt_d = llhd.sig %false : i1
    %gen_async.skew_cnt_q = llhd.sig %false : i1
    %gen_async.i_sync_p.q_o = hw.instance "gen_async.i_sync_p" @prim_flop_2sync_1(clk_i: %2: i1, rst_ni: %3: i1, d_i: %diff_pi: i1) -> (q_o: i1)
    llhd.drv %gen_async.diff_pd, %gen_async.i_sync_p.q_o after %1 : i1
    %gen_async.i_sync_n.q_o = hw.instance "gen_async.i_sync_n" @prim_flop_2sync(clk_i: %2: i1, rst_ni: %3: i1, d_i: %diff_ni: i1) -> (q_o: i1)
    llhd.drv %gen_async.diff_nd, %gen_async.i_sync_n.q_o after %1 : i1
    %4 = llhd.prb %gen_async.diff_pq : i1
    %5 = llhd.prb %gen_async.diff_pd : i1
    %6 = comb.xor %4, %5 : i1
    llhd.drv %gen_async.diff_p_edge, %6 after %1 : i1
    %7 = llhd.prb %gen_async.diff_nq : i1
    %8 = llhd.prb %gen_async.diff_nd : i1
    %9 = comb.xor %7, %8 : i1
    llhd.drv %gen_async.diff_n_edge, %9 after %1 : i1
    %10 = comb.xor %5, %8 : i1
    llhd.drv %gen_async.diff_check_ok, %10 after %1 : i1
    llhd.drv %gen_async.level, %5 after %1 : i1
    %11 = llhd.prb %level_d : i1
    %12 = llhd.prb %rise_o : i1
    %13 = llhd.prb %fall_o : i1
    %14 = comb.or %12, %13 : i1
    %15 = llhd.prb %gen_async.state_q : i2
    %16 = llhd.prb %gen_async.state_d : i2
    %17 = llhd.prb %level_q : i1
    %18 = llhd.prb %gen_async.skew_cnt_q : i1
    %19 = llhd.prb %gen_async.skew_cnt_d : i1
    %20 = llhd.prb %sigint_o : i1
    %21 = llhd.prb %gen_async.diff_check_ok : i1
    %22 = llhd.prb %gen_async.level : i1
    %23 = llhd.prb %gen_async.diff_p_edge : i1
    %24 = llhd.prb %gen_async.diff_n_edge : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb21
      %25 = llhd.prb %gen_async.state_q : i2
      llhd.drv %gen_async.state_d, %25 after %1 : i2
      %26 = llhd.prb %level_q : i1
      llhd.drv %level_d, %26 after %1 : i1
      %27 = llhd.prb %gen_async.skew_cnt_q : i1
      llhd.drv %gen_async.skew_cnt_d, %27 after %1 : i1
      llhd.drv %rise_o, %false after %1 : i1
      llhd.drv %fall_o, %false after %1 : i1
      llhd.drv %sigint_o, %false after %1 : i1
      %28 = llhd.prb %gen_async.state_q : i2
      %29 = comb.icmp ceq %28, %c0_i2 : i2
      cf.cond_br %29, ^bb2, ^bb8
    ^bb2:  // pred: ^bb1
      %30 = llhd.prb %gen_async.diff_check_ok : i1
      cf.cond_br %30, ^bb3, ^bb7
    ^bb3:  // pred: ^bb2
      %31 = llhd.prb %gen_async.level : i1
      llhd.drv %level_d, %31 after %1 : i1
      %32 = llhd.prb %gen_async.diff_p_edge : i1
      %33 = llhd.prb %gen_async.diff_n_edge : i1
      %34 = comb.and %32, %33 : i1
      cf.cond_br %34, ^bb4, ^bb21
    ^bb4:  // pred: ^bb3
      %35 = llhd.prb %gen_async.level : i1
      cf.cond_br %35, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      llhd.drv %rise_o, %true after %1 : i1
      cf.br ^bb21
    ^bb6:  // pred: ^bb4
      llhd.drv %fall_o, %true after %1 : i1
      cf.br ^bb21
    ^bb7:  // pred: ^bb2
      llhd.drv %gen_async.state_d, %c1_i2 after %1 : i2
      llhd.drv %gen_async.skew_cnt_d, %true after %1 : i1
      cf.br ^bb21
    ^bb8:  // pred: ^bb1
      %36 = comb.icmp ceq %28, %c1_i2 : i2
      cf.cond_br %36, ^bb9, ^bb16
    ^bb9:  // pred: ^bb8
      %37 = llhd.prb %gen_async.diff_check_ok : i1
      cf.cond_br %37, ^bb10, ^bb13
    ^bb10:  // pred: ^bb9
      llhd.drv %gen_async.state_d, %c0_i2 after %1 : i2
      %38 = llhd.prb %gen_async.level : i1
      llhd.drv %level_d, %38 after %1 : i1
      llhd.drv %gen_async.skew_cnt_d, %false after %1 : i1
      %39 = llhd.prb %gen_async.level : i1
      cf.cond_br %39, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      llhd.drv %rise_o, %true after %1 : i1
      cf.br ^bb21
    ^bb12:  // pred: ^bb10
      llhd.drv %fall_o, %true after %1 : i1
      cf.br ^bb21
    ^bb13:  // pred: ^bb9
      %40 = llhd.prb %gen_async.skew_cnt_q : i1
      %41 = comb.xor %40, %true : i1
      cf.cond_br %41, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %42 = llhd.prb %gen_async.skew_cnt_q : i1
      %43 = comb.add %42, %true : i1
      llhd.drv %gen_async.skew_cnt_d, %43 after %1 : i1
      cf.br ^bb21
    ^bb15:  // pred: ^bb13
      llhd.drv %gen_async.state_d, %c-2_i2 after %1 : i2
      llhd.drv %sigint_o, %true after %1 : i1
      llhd.drv %gen_async.skew_cnt_d, %false after %1 : i1
      cf.br ^bb21
    ^bb16:  // pred: ^bb8
      %44 = comb.icmp ceq %28, %c-2_i2 : i2
      cf.cond_br %44, ^bb17, ^bb21
    ^bb17:  // pred: ^bb16
      llhd.drv %sigint_o, %true after %1 : i1
      %45 = llhd.prb %gen_async.diff_check_ok : i1
      cf.cond_br %45, ^bb18, ^bb21
    ^bb18:  // pred: ^bb17
      llhd.drv %gen_async.state_d, %c0_i2 after %1 : i2
      llhd.drv %sigint_o, %false after %1 : i1
      %46 = llhd.prb %gen_async.level : i1
      llhd.drv %level_d, %46 after %1 : i1
      %47 = llhd.prb %gen_async.level : i1
      cf.cond_br %47, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      llhd.drv %rise_o, %true after %1 : i1
      cf.br ^bb21
    ^bb20:  // pred: ^bb18
      llhd.drv %fall_o, %true after %1 : i1
      cf.br ^bb21
    ^bb21:  // 12 preds: ^bb3, ^bb5, ^bb6, ^bb7, ^bb11, ^bb12, ^bb14, ^bb15, ^bb16, ^bb17, ^bb19, ^bb20
      llhd.wait (%15, %16, %17, %11, %18, %19, %12, %13, %20, %21, %22, %23, %24 : i2, i2, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %25 = llhd.prb %clk_i_0 : i1
      %26 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %27 = llhd.prb %clk_i_0 : i1
      %28 = comb.xor bin %25, %true : i1
      %29 = comb.and bin %28, %27 : i1
      %30 = llhd.prb %rst_ni_1 : i1
      %31 = comb.xor bin %30, %true : i1
      %32 = comb.and bin %26, %31 : i1
      %33 = comb.or bin %29, %32 : i1
      cf.cond_br %33, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %34 = llhd.prb %rst_ni_1 : i1
      %35 = comb.xor %34, %true : i1
      cf.cond_br %35, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_async.state_q, %c0_i2 after %0 : i2
      llhd.drv %gen_async.diff_pq, %false after %0 : i1
      llhd.drv %gen_async.diff_nq, %true after %0 : i1
      llhd.drv %level_q, %false after %0 : i1
      llhd.drv %gen_async.skew_cnt_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %36 = llhd.prb %gen_async.state_d : i2
      llhd.drv %gen_async.state_q, %36 after %0 : i2
      %37 = llhd.prb %gen_async.diff_pd : i1
      llhd.drv %gen_async.diff_pq, %37 after %0 : i1
      %38 = llhd.prb %gen_async.diff_nd : i1
      llhd.drv %gen_async.diff_nq, %38 after %0 : i1
      %39 = llhd.prb %level_d : i1
      llhd.drv %level_q, %39 after %0 : i1
      %40 = llhd.prb %gen_async.skew_cnt_d : i1
      llhd.drv %gen_async.skew_cnt_q, %40 after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    hw.output %11, %12, %13, %14, %20 : i1, i1, i1, i1, i1
  }
  hw.module private @prim_fifo_sync_cnt(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %incr_wptr_i : i1, in %incr_rptr_i : i1, out wptr_o : i1, out rptr_o : i1, out full_o : i1, out empty_o : i1, out depth_o : i2, out err_o : i1) {
    %c1_i2 = hw.constant 1 : i2
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %false = hw.constant false
    %c-2_i2 = hw.constant -2 : i2
    %true = hw.constant true
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %clr_i_2 = llhd.sig name "clr_i" %false : i1
    %incr_wptr_i_3 = llhd.sig name "incr_wptr_i" %false : i1
    %incr_rptr_i_4 = llhd.sig name "incr_rptr_i" %false : i1
    %wptr_o = llhd.sig %false : i1
    %rptr_o = llhd.sig %false : i1
    %wptr_wrap_cnt_q = llhd.sig %c0_i2 : i2
    %wptr_wrap_set_cnt = llhd.sig %c0_i2 : i2
    %rptr_wrap_cnt_q = llhd.sig %c0_i2 : i2
    %rptr_wrap_set_cnt = llhd.sig %c0_i2 : i2
    %wptr_wrap_msb = llhd.sig %false : i1
    %rptr_wrap_msb = llhd.sig %false : i1
    %wptr_wrap_set = llhd.sig %false : i1
    %rptr_wrap_set = llhd.sig %false : i1
    %4 = llhd.prb %wptr_wrap_cnt_q : i2
    %5 = comb.extract %4 from 0 : (i2) -> i1
    llhd.drv %wptr_o, %5 after %1 : i1
    %6 = llhd.prb %rptr_wrap_cnt_q : i2
    %7 = comb.extract %6 from 0 : (i2) -> i1
    llhd.drv %rptr_o, %7 after %1 : i1
    %8 = comb.extract %4 from 1 : (i2) -> i1
    llhd.drv %wptr_wrap_msb, %8 after %1 : i1
    %9 = comb.extract %6 from 1 : (i2) -> i1
    llhd.drv %rptr_wrap_msb, %9 after %1 : i1
    %10 = llhd.prb %incr_wptr_i_3 : i1
    %11 = llhd.prb %wptr_o : i1
    %12 = comb.and %10, %11 : i1
    llhd.drv %wptr_wrap_set, %12 after %1 : i1
    %13 = llhd.prb %incr_rptr_i_4 : i1
    %14 = llhd.prb %rptr_o : i1
    %15 = comb.and %13, %14 : i1
    llhd.drv %rptr_wrap_set, %15 after %1 : i1
    %16 = llhd.prb %wptr_wrap_msb : i1
    %17 = comb.xor %16, %true : i1
    %18 = comb.concat %17, %false : i1, i1
    llhd.drv %wptr_wrap_set_cnt, %18 after %1 : i2
    %19 = llhd.prb %rptr_wrap_msb : i1
    %20 = comb.xor %19, %true : i1
    %21 = comb.concat %20, %false : i1, i1
    llhd.drv %rptr_wrap_set_cnt, %21 after %1 : i2
    %22 = comb.xor %6, %c-2_i2 : i2
    %23 = comb.icmp eq %4, %22 : i2
    %24 = comb.icmp eq %4, %6 : i2
    %25 = comb.icmp eq %16, %19 : i1
    %26 = comb.concat %false, %11 : i1, i1
    %27 = comb.concat %false, %14 : i1, i1
    %28 = comb.sub %26, %27 : i2
    %29 = comb.sub %c-2_i2, %27 : i2
    %30 = comb.add %29, %26 : i2
    %31 = comb.mux %25, %28, %30 : i2
    %32 = comb.mux %23, %c-2_i2, %31 : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      %33 = llhd.prb %clk_i_0 : i1
      %34 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %35 = llhd.prb %clk_i_0 : i1
      %36 = comb.xor bin %33, %true : i1
      %37 = comb.and bin %36, %35 : i1
      %38 = llhd.prb %rst_ni_1 : i1
      %39 = comb.xor bin %38, %true : i1
      %40 = comb.and bin %34, %39 : i1
      %41 = comb.or bin %37, %40 : i1
      cf.cond_br %41, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %42 = llhd.prb %rst_ni_1 : i1
      %43 = comb.xor %42, %true : i1
      cf.cond_br %43, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %wptr_wrap_cnt_q, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %44 = llhd.prb %clr_i_2 : i1
      cf.cond_br %44, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %wptr_wrap_cnt_q, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %45 = llhd.prb %wptr_wrap_set : i1
      cf.cond_br %45, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %46 = llhd.prb %wptr_wrap_set_cnt : i2
      llhd.drv %wptr_wrap_cnt_q, %46 after %0 : i2
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %47 = llhd.prb %incr_wptr_i_3 : i1
      cf.cond_br %47, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      %48 = llhd.prb %wptr_wrap_cnt_q : i2
      %49 = comb.add %48, %c1_i2 : i2
      llhd.drv %wptr_wrap_cnt_q, %49 after %0 : i2
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      %33 = llhd.prb %clk_i_0 : i1
      %34 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %35 = llhd.prb %clk_i_0 : i1
      %36 = comb.xor bin %33, %true : i1
      %37 = comb.and bin %36, %35 : i1
      %38 = llhd.prb %rst_ni_1 : i1
      %39 = comb.xor bin %38, %true : i1
      %40 = comb.and bin %34, %39 : i1
      %41 = comb.or bin %37, %40 : i1
      cf.cond_br %41, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %42 = llhd.prb %rst_ni_1 : i1
      %43 = comb.xor %42, %true : i1
      cf.cond_br %43, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %rptr_wrap_cnt_q, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %44 = llhd.prb %clr_i_2 : i1
      cf.cond_br %44, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %rptr_wrap_cnt_q, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %45 = llhd.prb %rptr_wrap_set : i1
      cf.cond_br %45, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %46 = llhd.prb %rptr_wrap_set_cnt : i2
      llhd.drv %rptr_wrap_cnt_q, %46 after %0 : i2
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %47 = llhd.prb %incr_rptr_i_4 : i1
      cf.cond_br %47, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      %48 = llhd.prb %rptr_wrap_cnt_q : i2
      %49 = comb.add %48, %c1_i2 : i2
      llhd.drv %rptr_wrap_cnt_q, %49 after %0 : i2
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %clr_i_2, %clr_i after %1 : i1
    llhd.drv %incr_wptr_i_3, %incr_wptr_i after %1 : i1
    llhd.drv %incr_rptr_i_4, %incr_rptr_i after %1 : i1
    hw.output %11, %14, %23, %24, %32, %false : i1, i1, i1, i1, i2, i1
  }
  hw.module private @prim_fifo_sync(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, out wready_o : i1, in %wdata_i : i34, out rvalid_o : i1, in %rready_i : i1, out rdata_o : i34, out full_o : i1, out depth_o : i2, out err_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [0 : i34, 0 : i34] : !hw.array<2xi34>
    %c0_i34 = hw.constant 0 : i34
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %wdata_i_2 = llhd.sig name "wdata_i" %c0_i34 : i34
    %gen_normal_fifo.fifo_wptr = llhd.sig %false : i1
    %gen_normal_fifo.fifo_incr_wptr = llhd.sig %false : i1
    %gen_normal_fifo.under_rst = llhd.sig %false : i1
    %gen_normal_fifo.storage = llhd.sig %2 : !hw.array<2xi34>
    %gen_normal_fifo.rdata_int = llhd.sig %c0_i34 : i34
    %5 = llhd.prb %gen_normal_fifo.fifo_incr_wptr : i1
    %gen_normal_fifo.u_fifo_cnt.wptr_o, %gen_normal_fifo.u_fifo_cnt.rptr_o, %gen_normal_fifo.u_fifo_cnt.full_o, %gen_normal_fifo.u_fifo_cnt.empty_o, %gen_normal_fifo.u_fifo_cnt.depth_o, %gen_normal_fifo.u_fifo_cnt.err_o = hw.instance "gen_normal_fifo.u_fifo_cnt" @prim_fifo_sync_cnt(clk_i: %3: i1, rst_ni: %4: i1, clr_i: %clr_i: i1, incr_wptr_i: %5: i1, incr_rptr_i: %11: i1) -> (wptr_o: i1, rptr_o: i1, full_o: i1, empty_o: i1, depth_o: i2, err_o: i1) {sv.namehint = "gen_normal_fifo.empty"}
    llhd.drv %gen_normal_fifo.fifo_wptr, %gen_normal_fifo.u_fifo_cnt.wptr_o after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %17 = llhd.prb %clk_i_0 : i1
      %18 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %19 = llhd.prb %clk_i_0 : i1
      %20 = comb.xor bin %17, %true : i1
      %21 = comb.and bin %20, %19 : i1
      %22 = llhd.prb %rst_ni_1 : i1
      %23 = comb.xor bin %22, %true : i1
      %24 = comb.and bin %18, %23 : i1
      %25 = comb.or bin %21, %24 : i1
      cf.cond_br %25, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %26 = llhd.prb %rst_ni_1 : i1
      %27 = comb.xor %26, %true : i1
      cf.cond_br %27, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_normal_fifo.under_rst, %true after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %28 = llhd.prb %gen_normal_fifo.under_rst : i1
      cf.cond_br %28, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %29 = llhd.prb %gen_normal_fifo.under_rst : i1
      %30 = comb.xor %29, %true : i1
      llhd.drv %gen_normal_fifo.under_rst, %30 after %0 : i1
      cf.br ^bb1
    }
    %6 = comb.xor %gen_normal_fifo.u_fifo_cnt.full_o, %true : i1
    %7 = llhd.prb %gen_normal_fifo.under_rst : i1
    %8 = comb.xor %7, %true : i1
    %9 = comb.and %6, %8 : i1
    %10 = comb.and %wvalid_i, %9 : i1
    llhd.drv %gen_normal_fifo.fifo_incr_wptr, %10 after %1 : i1
    %11 = comb.and %14, %rready_i, %8 {sv.namehint = "gen_normal_fifo.fifo_incr_rptr"} : i1
    %12 = llhd.prb %gen_normal_fifo.storage : !hw.array<2xi34>
    %13 = hw.array_get %12[%gen_normal_fifo.u_fifo_cnt.rptr_o] {sv.namehint = "gen_normal_fifo.storage_rdata"} : !hw.array<2xi34>, i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
      %17 = llhd.prb %clk_i_0 : i1
      llhd.wait (%3 : i1), ^bb2
    ^bb2:  // pred: ^bb1
      %18 = llhd.prb %clk_i_0 : i1
      %19 = comb.xor bin %17, %true : i1
      %20 = comb.and bin %19, %18 : i1
      cf.cond_br %20, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %21 = llhd.prb %gen_normal_fifo.fifo_incr_wptr : i1
      cf.cond_br %21, ^bb4, ^bb1
    ^bb4:  // pred: ^bb3
      %22 = llhd.prb %gen_normal_fifo.fifo_wptr : i1
      %23 = llhd.sig.array_get %gen_normal_fifo.storage[%22] : <!hw.array<2xi34>>
      %24 = llhd.prb %wdata_i_2 : i34
      llhd.drv %23, %24 after %0 : i34
      cf.br ^bb1
    }
    llhd.drv %gen_normal_fifo.rdata_int, %13 after %1 : i34
    %14 = comb.xor %gen_normal_fifo.u_fifo_cnt.empty_o, %true : i1
    %15 = llhd.prb %gen_normal_fifo.rdata_int : i34
    %16 = comb.mux %gen_normal_fifo.u_fifo_cnt.empty_o, %c0_i34, %15 : i34
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %wdata_i_2, %wdata_i after %1 : i34
    hw.output %9, %14, %16, %gen_normal_fifo.u_fifo_cnt.full_o, %gen_normal_fifo.u_fifo_cnt.depth_o, %gen_normal_fifo.u_fifo_cnt.err_o : i1, i1, i34, i1, i2, i1
  }
  func.func private @"prim_mubi_pkg::mubi4_test_invalid"(%arg0: i4) -> i1 {
    %true = hw.constant true
    %c-7_i4 = hw.constant -7 : i4
    %c6_i4 = hw.constant 6 : i4
    %0 = comb.icmp weq %arg0, %c6_i4 : i4
    %1 = comb.icmp weq %arg0, %c-7_i4 : i4
    %2 = comb.or %0, %1 : i1
    %3 = comb.xor %2, %true : i1
    return %3 : i1
  }
  func.func private @"prim_mubi_pkg::mubi4_test_true_strict"(%arg0: i4) -> i1 {
    %c6_i4 = hw.constant 6 : i4
    %0 = comb.icmp eq %arg0, %c6_i4 : i4
    return %0 : i1
  }
  func.func private @"prim_mubi_pkg::mubi4_test_false_loose"(%arg0: i4) -> i1 {
    %c6_i4 = hw.constant 6 : i4
    %0 = comb.icmp ne %arg0, %c6_i4 : i4
    return %0 : i1
  }
  func.func private @"prim_mubi_pkg::mubi8_test_true_strict"(%arg0: i8) -> i1 {
    %c-106_i8 = hw.constant -106 : i8
    %0 = comb.icmp eq %arg0, %c-106_i8 : i8
    return %0 : i1
  }
  func.func private @"prim_mubi_pkg::mubi32_test_true_strict"(%arg0: i32) -> i1 {
    %c-1768515946_i32 = hw.constant -1768515946 : i32
    %0 = comb.icmp eq %arg0, %c-1768515946_i32 : i32
    return %0 : i1
  }
  hw.module private @prim_onehot_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i3, in %addr_i : i2, in %en_i : i1, out err_o : i1) {
    %c-2_i3 = hw.constant -2 : i3
    %c-3_i3 = hw.constant -3 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c3_i3 = hw.constant 3 : i3
    %c2_i3 = hw.constant 2 : i3
    %c1_i3 = hw.constant 1 : i3
    %true = hw.constant true
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i3 = hw.constant 0 : i3
    %false = hw.constant false {sv.namehint = "addr_err"}
    %c0_i7 = hw.constant 0 : i7
    %or_tree = llhd.sig %c0_i7 : i7
    %and_tree = llhd.sig %c0_i7 : i7
    %err_tree = llhd.sig %c0_i7 : i7
    %1 = llhd.sig.extract %or_tree from %c0_i3 : <i7> -> <i1>
    %2 = llhd.prb %or_tree : i7
    %3 = comb.extract %2 from 1 : (i7) -> i1
    %4 = comb.extract %2 from 2 : (i7) -> i1
    %5 = comb.or %3, %4 : i1
    llhd.drv %1, %5 after %0 : i1
    %6 = llhd.sig.extract %and_tree from %c0_i3 : <i7> -> <i1>
    %7 = comb.extract %addr_i from 1 : (i2) -> i1
    %8 = comb.xor %7, %true : i1
    %9 = llhd.prb %and_tree : i7
    %10 = comb.extract %9 from 1 : (i7) -> i1
    %11 = comb.and %8, %10 : i1
    %12 = comb.extract %9 from 2 : (i7) -> i1
    %13 = comb.and %7, %12 : i1
    %14 = comb.or %11, %13 : i1
    llhd.drv %6, %14 after %0 : i1
    %15 = llhd.sig.extract %err_tree from %c0_i3 : <i7> -> <i1>
    %16 = comb.and %3, %4 : i1
    %17 = llhd.prb %err_tree : i7
    %18 = comb.extract %17 from 1 : (i7) -> i1
    %19 = comb.extract %17 from 2 : (i7) -> i1
    %20 = comb.or %16, %18, %19 : i1
    llhd.drv %15, %20 after %0 : i1
    %21 = llhd.sig.extract %or_tree from %c1_i3 : <i7> -> <i1>
    %22 = comb.extract %2 from 3 : (i7) -> i1
    %23 = comb.extract %2 from 4 : (i7) -> i1
    %24 = comb.or %22, %23 : i1
    llhd.drv %21, %24 after %0 : i1
    %25 = llhd.sig.extract %and_tree from %c1_i3 : <i7> -> <i1>
    %26 = comb.extract %addr_i from 0 : (i2) -> i1
    %27 = comb.xor %26, %true : i1
    %28 = comb.extract %9 from 3 : (i7) -> i1
    %29 = comb.and %27, %28 : i1
    %30 = comb.extract %9 from 4 : (i7) -> i1
    %31 = comb.and %26, %30 : i1
    %32 = comb.or %29, %31 : i1
    llhd.drv %25, %32 after %0 : i1
    %33 = llhd.sig.extract %err_tree from %c1_i3 : <i7> -> <i1>
    %34 = comb.and %22, %23 : i1
    %35 = comb.extract %17 from 3 : (i7) -> i1
    %36 = comb.extract %17 from 4 : (i7) -> i1
    %37 = comb.or %34, %35, %36 : i1
    llhd.drv %33, %37 after %0 : i1
    %38 = llhd.sig.extract %or_tree from %c2_i3 : <i7> -> <i1>
    %39 = comb.extract %2 from 5 : (i7) -> i1
    %40 = comb.extract %2 from 6 : (i7) -> i1
    %41 = comb.or %39, %40 : i1
    llhd.drv %38, %41 after %0 : i1
    %42 = llhd.sig.extract %and_tree from %c2_i3 : <i7> -> <i1>
    %43 = comb.extract %9 from 5 : (i7) -> i1
    %44 = comb.and %27, %43 : i1
    %45 = comb.extract %9 from 6 : (i7) -> i1
    %46 = comb.and %26, %45 : i1
    %47 = comb.or %44, %46 : i1
    llhd.drv %42, %47 after %0 : i1
    %48 = llhd.sig.extract %err_tree from %c2_i3 : <i7> -> <i1>
    %49 = comb.and %39, %40 : i1
    %50 = comb.extract %17 from 5 : (i7) -> i1
    %51 = comb.extract %17 from 6 : (i7) -> i1
    %52 = comb.or %49, %50, %51 : i1
    llhd.drv %48, %52 after %0 : i1
    %53 = llhd.sig.extract %or_tree from %c3_i3 : <i7> -> <i1>
    %54 = comb.extract %oh_i from 0 : (i3) -> i1
    llhd.drv %53, %54 after %0 : i1
    %55 = llhd.sig.extract %and_tree from %c3_i3 : <i7> -> <i1>
    llhd.drv %55, %54 after %0 : i1
    %56 = llhd.sig.extract %err_tree from %c3_i3 : <i7> -> <i1>
    llhd.drv %56, %false after %0 : i1
    %57 = llhd.sig.extract %or_tree from %c-4_i3 : <i7> -> <i1>
    %58 = comb.extract %oh_i from 1 : (i3) -> i1
    llhd.drv %57, %58 after %0 : i1
    %59 = llhd.sig.extract %and_tree from %c-4_i3 : <i7> -> <i1>
    llhd.drv %59, %58 after %0 : i1
    %60 = llhd.sig.extract %err_tree from %c-4_i3 : <i7> -> <i1>
    llhd.drv %60, %false after %0 : i1
    %61 = llhd.sig.extract %or_tree from %c-3_i3 : <i7> -> <i1>
    %62 = comb.extract %oh_i from 2 : (i3) -> i1
    llhd.drv %61, %62 after %0 : i1
    %63 = llhd.sig.extract %and_tree from %c-3_i3 : <i7> -> <i1>
    llhd.drv %63, %62 after %0 : i1
    %64 = llhd.sig.extract %err_tree from %c-3_i3 : <i7> -> <i1>
    llhd.drv %64, %false after %0 : i1
    %65 = llhd.sig.extract %or_tree from %c-2_i3 : <i7> -> <i1>
    llhd.drv %65, %false after %0 : i1
    %66 = llhd.sig.extract %and_tree from %c-2_i3 : <i7> -> <i1>
    llhd.drv %66, %false after %0 : i1
    %67 = llhd.sig.extract %err_tree from %c-2_i3 : <i7> -> <i1>
    llhd.drv %67, %false after %0 : i1
    %68 = comb.or %69, %72 : i1
    %69 = comb.extract %17 from 0 {sv.namehint = "oh0_err"} : (i7) -> i1
    %70 = comb.xor %en_i, %true : i1
    %71 = comb.extract %2 from 0 : (i7) -> i1
    %72 = comb.and %70, %71 {sv.namehint = "enable_err"} : i1
    hw.output %68 : i1
  }
  hw.module private @prim_reg_we_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i3, in %en_i : i1, out err_o : i1) {
    %c0_i2 = hw.constant 0 : i2
    %u_prim_buf.out_o = hw.instance "u_prim_buf" @prim_buf_12(in_i: %oh_i: i3) -> (out_o: i3) {sv.namehint = "oh_buf"}
    %u_prim_onehot_check.err_o = hw.instance "u_prim_onehot_check" @prim_onehot_check(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, oh_i: %u_prim_buf.out_o: i3, addr_i: %c0_i2: i2, en_i: %en_i: i1) -> (err_o: i1)
    hw.output %u_prim_onehot_check.err_o : i1
  }
  hw.module private @prim_sec_anchor_buf(in %in_i : i2, out out_o : i2) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf_15(in_i: %in_i: i2) -> (out_o: i2)
    hw.output %u_secure_anchor_buf.out_o : i2
  }
  hw.module private @prim_sec_anchor_buf_5(in %in_i : i1, out out_o : i1) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf(in_i: %in_i: i1) -> (out_o: i1)
    hw.output %u_secure_anchor_buf.out_o : i1
  }
  hw.module private @prim_sec_anchor_flop(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_o : i2) {
    %u_secure_anchor_flop.q_o = hw.instance "u_secure_anchor_flop" @prim_flop_16(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %d_i: i2) -> (q_o: i2)
    hw.output %u_secure_anchor_flop.q_o : i2
  }
  hw.module private @prim_secded_inv_39_32_dec(in %data_i : i39, out data_o : i32, out syndrome_o : i7, out err_o : i2) {
    %c-136161252669_i38 = hw.constant -136161252669 : i38
    %c90194313216_i38 = hw.constant 90194313216 : i38
    %c-34167646061_i36 = hw.constant -34167646061 : i36
    %c-23622320128_i36 = hw.constant -23622320128 : i36
    %c-65452035525_i37 = hw.constant -65452035525 : i37
    %c42949672960_i37 = hw.constant 42949672960 : i37
    %c-33535340847_i36 = hw.constant -33535340847 : i36
    %c-25769803776_i36 = hw.constant -25769803776 : i36
    %c-8042658603_i34 = hw.constant -8042658603 : i34
    %c4294967296_i34 = hw.constant 4294967296 : i34
    %c0_i4 = hw.constant 0 : i4
    %c-303323131_i30 = hw.constant -303323131 : i30
    %c-536870912_i30 = hw.constant -536870912 : i30
    %c-3656991451_i33 = hw.constant -3656991451 : i33
    %true = hw.constant true
    %false = hw.constant false
    %c-1_i5 = hw.constant -1 : i5
    %c-2_i5 = hw.constant -2 : i5
    %c-3_i5 = hw.constant -3 : i5
    %c-4_i5 = hw.constant -4 : i5
    %c-5_i5 = hw.constant -5 : i5
    %c-6_i5 = hw.constant -6 : i5
    %c-7_i5 = hw.constant -7 : i5
    %c-8_i5 = hw.constant -8 : i5
    %c-9_i5 = hw.constant -9 : i5
    %c-10_i5 = hw.constant -10 : i5
    %c-11_i5 = hw.constant -11 : i5
    %c-12_i5 = hw.constant -12 : i5
    %c-13_i5 = hw.constant -13 : i5
    %c-14_i5 = hw.constant -14 : i5
    %c-15_i5 = hw.constant -15 : i5
    %c-16_i5 = hw.constant -16 : i5
    %c15_i5 = hw.constant 15 : i5
    %c14_i5 = hw.constant 14 : i5
    %c13_i5 = hw.constant 13 : i5
    %c12_i5 = hw.constant 12 : i5
    %c11_i5 = hw.constant 11 : i5
    %c10_i5 = hw.constant 10 : i5
    %c9_i5 = hw.constant 9 : i5
    %c8_i5 = hw.constant 8 : i5
    %c7_i5 = hw.constant 7 : i5
    %c6_i5 = hw.constant 6 : i5
    %c5_i5 = hw.constant 5 : i5
    %c4_i5 = hw.constant 4 : i5
    %c3_i5 = hw.constant 3 : i5
    %c2_i5 = hw.constant 2 : i5
    %c1_i5 = hw.constant 1 : i5
    %c0_i5 = hw.constant 0 : i5
    %c-2_i3 = hw.constant -2 : i3
    %c-3_i3 = hw.constant -3 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c3_i3 = hw.constant 3 : i3
    %c2_i3 = hw.constant 2 : i3
    %c1_i3 = hw.constant 1 : i3
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i3 = hw.constant 0 : i3
    %c0_i2 = hw.constant 0 : i2
    %c0_i7 = hw.constant 0 : i7
    %c0_i32 = hw.constant 0 : i32
    %c-46_i7 = hw.constant -46 : i7
    %c22_i7 = hw.constant 22 : i7
    %c41_i7 = hw.constant 41 : i7
    %c-54_i7 = hw.constant -54 : i7
    %c-30_i7 = hw.constant -30 : i7
    %c35_i7 = hw.constant 35 : i7
    %c19_i7 = hw.constant 19 : i7
    %c44_i7 = hw.constant 44 : i7
    %c50_i7 = hw.constant 50 : i7
    %c-16_i7 = hw.constant -16 : i7
    %c14_i7 = hw.constant 14 : i7
    %c-58_i7 = hw.constant -58 : i7
    %c38_i7 = hw.constant 38 : i7
    %c37_i7 = hw.constant 37 : i7
    %c11_i7 = hw.constant 11 : i7
    %c28_i7 = hw.constant 28 : i7
    %c7_i7 = hw.constant 7 : i7
    %c-24_i7 = hw.constant -24 : i7
    %c49_i7 = hw.constant 49 : i7
    %c-47_i7 = hw.constant -47 : i7
    %c13_i7 = hw.constant 13 : i7
    %c-55_i7 = hw.constant -55 : i7
    %c56_i7 = hw.constant 56 : i7
    %c-59_i7 = hw.constant -59 : i7
    %c-52_i7 = hw.constant -52 : i7
    %c42_i7 = hw.constant 42 : i7
    %c21_i7 = hw.constant 21 : i7
    %c26_i7 = hw.constant 26 : i7
    %c52_i7 = hw.constant 52 : i7
    %c-31_i7 = hw.constant -31 : i7
    %c-44_i7 = hw.constant -44 : i7
    %c25_i7 = hw.constant 25 : i7
    %c0_i39 = hw.constant 0 : i39
    %data_i_0 = llhd.sig name "data_i" %c0_i39 : i39
    %data_o = llhd.sig %c0_i32 : i32
    %syndrome_o = llhd.sig %c0_i7 : i7
    %err_o = llhd.sig %c0_i2 : i2
    %1 = llhd.prb %syndrome_o : i7
    %2 = llhd.prb %data_i_0 : i39
    %3 = llhd.prb %data_o : i32
    %4 = llhd.prb %err_o : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %5 = llhd.sig.extract %syndrome_o from %c0_i3 : <i7> -> <i1>
      %6 = llhd.prb %data_i_0 : i39
      %7 = comb.extract %6 from 0 : (i39) -> i33
      %8 = comb.and %7, %c-3656991451_i33 : i33
      %9 = comb.parity %8 : i33
      llhd.drv %5, %9 after %0 : i1
      %10 = llhd.sig.extract %syndrome_o from %c1_i3 : <i7> -> <i1>
      %11 = llhd.prb %data_i_0 : i39
      %12 = comb.extract %11 from 4 : (i39) -> i30
      %13 = comb.xor %12, %c-536870912_i30 : i30
      %14 = comb.and %13, %c-303323131_i30 : i30
      %15 = comb.concat %c0_i5, %14, %c0_i4 : i5, i30, i4
      %16 = comb.parity %15 : i39
      llhd.drv %10, %16 after %0 : i1
      %17 = llhd.sig.extract %syndrome_o from %c2_i3 : <i7> -> <i1>
      %18 = llhd.prb %data_i_0 : i39
      %19 = comb.extract %18 from 1 : (i39) -> i34
      %20 = comb.xor %19, %c4294967296_i34 : i34
      %21 = comb.and %20, %c-8042658603_i34 : i34
      %22 = comb.concat %c0_i4, %21, %false : i4, i34, i1
      %23 = comb.parity %22 : i39
      llhd.drv %17, %23 after %0 : i1
      %24 = llhd.sig.extract %syndrome_o from %c3_i3 : <i7> -> <i1>
      %25 = llhd.prb %data_i_0 : i39
      %26 = comb.extract %25 from 0 : (i39) -> i36
      %27 = comb.xor %26, %c-25769803776_i36 : i36
      %28 = comb.and %27, %c-33535340847_i36 : i36
      %29 = comb.parity %28 : i36
      llhd.drv %24, %29 after %0 : i1
      %30 = llhd.sig.extract %syndrome_o from %c-4_i3 : <i7> -> <i1>
      %31 = llhd.prb %data_i_0 : i39
      %32 = comb.extract %31 from 0 : (i39) -> i37
      %33 = comb.xor %32, %c42949672960_i37 : i37
      %34 = comb.and %33, %c-65452035525_i37 : i37
      %35 = comb.parity %34 : i37
      llhd.drv %30, %35 after %0 : i1
      %36 = llhd.sig.extract %syndrome_o from %c-3_i3 : <i7> -> <i1>
      %37 = llhd.prb %data_i_0 : i39
      %38 = comb.extract %37 from 2 : (i39) -> i36
      %39 = comb.xor %38, %c-23622320128_i36 : i36
      %40 = comb.and %39, %c-34167646061_i36 : i36
      %41 = comb.concat %false, %40, %c0_i2 : i1, i36, i2
      %42 = comb.parity %41 : i39
      llhd.drv %36, %42 after %0 : i1
      %43 = llhd.sig.extract %syndrome_o from %c-2_i3 : <i7> -> <i1>
      %44 = llhd.prb %data_i_0 : i39
      %45 = comb.extract %44 from 1 : (i39) -> i38
      %46 = comb.xor %45, %c90194313216_i38 : i38
      %47 = comb.and %46, %c-136161252669_i38 : i38
      %48 = comb.parity %47 : i38
      llhd.drv %43, %48 after %0 : i1
      %49 = llhd.sig.extract %data_o from %c0_i5 : <i32> -> <i1>
      %50 = llhd.prb %syndrome_o : i7
      %51 = comb.icmp eq %50, %c25_i7 : i7
      %52 = llhd.prb %data_i_0 : i39
      %53 = comb.extract %52 from 0 : (i39) -> i1
      %54 = comb.xor %51, %53 : i1
      llhd.drv %49, %54 after %0 : i1
      %55 = llhd.sig.extract %data_o from %c1_i5 : <i32> -> <i1>
      %56 = llhd.prb %syndrome_o : i7
      %57 = comb.icmp eq %56, %c-44_i7 : i7
      %58 = llhd.prb %data_i_0 : i39
      %59 = comb.extract %58 from 1 : (i39) -> i1
      %60 = comb.xor %57, %59 : i1
      llhd.drv %55, %60 after %0 : i1
      %61 = llhd.sig.extract %data_o from %c2_i5 : <i32> -> <i1>
      %62 = llhd.prb %syndrome_o : i7
      %63 = comb.icmp eq %62, %c-31_i7 : i7
      %64 = llhd.prb %data_i_0 : i39
      %65 = comb.extract %64 from 2 : (i39) -> i1
      %66 = comb.xor %63, %65 : i1
      llhd.drv %61, %66 after %0 : i1
      %67 = llhd.sig.extract %data_o from %c3_i5 : <i32> -> <i1>
      %68 = llhd.prb %syndrome_o : i7
      %69 = comb.icmp eq %68, %c52_i7 : i7
      %70 = llhd.prb %data_i_0 : i39
      %71 = comb.extract %70 from 3 : (i39) -> i1
      %72 = comb.xor %69, %71 : i1
      llhd.drv %67, %72 after %0 : i1
      %73 = llhd.sig.extract %data_o from %c4_i5 : <i32> -> <i1>
      %74 = llhd.prb %syndrome_o : i7
      %75 = comb.icmp eq %74, %c26_i7 : i7
      %76 = llhd.prb %data_i_0 : i39
      %77 = comb.extract %76 from 4 : (i39) -> i1
      %78 = comb.xor %75, %77 : i1
      llhd.drv %73, %78 after %0 : i1
      %79 = llhd.sig.extract %data_o from %c5_i5 : <i32> -> <i1>
      %80 = llhd.prb %syndrome_o : i7
      %81 = comb.icmp eq %80, %c21_i7 : i7
      %82 = llhd.prb %data_i_0 : i39
      %83 = comb.extract %82 from 5 : (i39) -> i1
      %84 = comb.xor %81, %83 : i1
      llhd.drv %79, %84 after %0 : i1
      %85 = llhd.sig.extract %data_o from %c6_i5 : <i32> -> <i1>
      %86 = llhd.prb %syndrome_o : i7
      %87 = comb.icmp eq %86, %c42_i7 : i7
      %88 = llhd.prb %data_i_0 : i39
      %89 = comb.extract %88 from 6 : (i39) -> i1
      %90 = comb.xor %87, %89 : i1
      llhd.drv %85, %90 after %0 : i1
      %91 = llhd.sig.extract %data_o from %c7_i5 : <i32> -> <i1>
      %92 = llhd.prb %syndrome_o : i7
      %93 = comb.icmp eq %92, %c-52_i7 : i7
      %94 = llhd.prb %data_i_0 : i39
      %95 = comb.extract %94 from 7 : (i39) -> i1
      %96 = comb.xor %93, %95 : i1
      llhd.drv %91, %96 after %0 : i1
      %97 = llhd.sig.extract %data_o from %c8_i5 : <i32> -> <i1>
      %98 = llhd.prb %syndrome_o : i7
      %99 = comb.icmp eq %98, %c-59_i7 : i7
      %100 = llhd.prb %data_i_0 : i39
      %101 = comb.extract %100 from 8 : (i39) -> i1
      %102 = comb.xor %99, %101 : i1
      llhd.drv %97, %102 after %0 : i1
      %103 = llhd.sig.extract %data_o from %c9_i5 : <i32> -> <i1>
      %104 = llhd.prb %syndrome_o : i7
      %105 = comb.icmp eq %104, %c56_i7 : i7
      %106 = llhd.prb %data_i_0 : i39
      %107 = comb.extract %106 from 9 : (i39) -> i1
      %108 = comb.xor %105, %107 : i1
      llhd.drv %103, %108 after %0 : i1
      %109 = llhd.sig.extract %data_o from %c10_i5 : <i32> -> <i1>
      %110 = llhd.prb %syndrome_o : i7
      %111 = comb.icmp eq %110, %c-55_i7 : i7
      %112 = llhd.prb %data_i_0 : i39
      %113 = comb.extract %112 from 10 : (i39) -> i1
      %114 = comb.xor %111, %113 : i1
      llhd.drv %109, %114 after %0 : i1
      %115 = llhd.sig.extract %data_o from %c11_i5 : <i32> -> <i1>
      %116 = llhd.prb %syndrome_o : i7
      %117 = comb.icmp eq %116, %c13_i7 : i7
      %118 = llhd.prb %data_i_0 : i39
      %119 = comb.extract %118 from 11 : (i39) -> i1
      %120 = comb.xor %117, %119 : i1
      llhd.drv %115, %120 after %0 : i1
      %121 = llhd.sig.extract %data_o from %c12_i5 : <i32> -> <i1>
      %122 = llhd.prb %syndrome_o : i7
      %123 = comb.icmp eq %122, %c-47_i7 : i7
      %124 = llhd.prb %data_i_0 : i39
      %125 = comb.extract %124 from 12 : (i39) -> i1
      %126 = comb.xor %123, %125 : i1
      llhd.drv %121, %126 after %0 : i1
      %127 = llhd.sig.extract %data_o from %c13_i5 : <i32> -> <i1>
      %128 = llhd.prb %syndrome_o : i7
      %129 = comb.icmp eq %128, %c49_i7 : i7
      %130 = llhd.prb %data_i_0 : i39
      %131 = comb.extract %130 from 13 : (i39) -> i1
      %132 = comb.xor %129, %131 : i1
      llhd.drv %127, %132 after %0 : i1
      %133 = llhd.sig.extract %data_o from %c14_i5 : <i32> -> <i1>
      %134 = llhd.prb %syndrome_o : i7
      %135 = comb.icmp eq %134, %c-24_i7 : i7
      %136 = llhd.prb %data_i_0 : i39
      %137 = comb.extract %136 from 14 : (i39) -> i1
      %138 = comb.xor %135, %137 : i1
      llhd.drv %133, %138 after %0 : i1
      %139 = llhd.sig.extract %data_o from %c15_i5 : <i32> -> <i1>
      %140 = llhd.prb %syndrome_o : i7
      %141 = comb.icmp eq %140, %c7_i7 : i7
      %142 = llhd.prb %data_i_0 : i39
      %143 = comb.extract %142 from 15 : (i39) -> i1
      %144 = comb.xor %141, %143 : i1
      llhd.drv %139, %144 after %0 : i1
      %145 = llhd.sig.extract %data_o from %c-16_i5 : <i32> -> <i1>
      %146 = llhd.prb %syndrome_o : i7
      %147 = comb.icmp eq %146, %c28_i7 : i7
      %148 = llhd.prb %data_i_0 : i39
      %149 = comb.extract %148 from 16 : (i39) -> i1
      %150 = comb.xor %147, %149 : i1
      llhd.drv %145, %150 after %0 : i1
      %151 = llhd.sig.extract %data_o from %c-15_i5 : <i32> -> <i1>
      %152 = llhd.prb %syndrome_o : i7
      %153 = comb.icmp eq %152, %c11_i7 : i7
      %154 = llhd.prb %data_i_0 : i39
      %155 = comb.extract %154 from 17 : (i39) -> i1
      %156 = comb.xor %153, %155 : i1
      llhd.drv %151, %156 after %0 : i1
      %157 = llhd.sig.extract %data_o from %c-14_i5 : <i32> -> <i1>
      %158 = llhd.prb %syndrome_o : i7
      %159 = comb.icmp eq %158, %c37_i7 : i7
      %160 = llhd.prb %data_i_0 : i39
      %161 = comb.extract %160 from 18 : (i39) -> i1
      %162 = comb.xor %159, %161 : i1
      llhd.drv %157, %162 after %0 : i1
      %163 = llhd.sig.extract %data_o from %c-13_i5 : <i32> -> <i1>
      %164 = llhd.prb %syndrome_o : i7
      %165 = comb.icmp eq %164, %c38_i7 : i7
      %166 = llhd.prb %data_i_0 : i39
      %167 = comb.extract %166 from 19 : (i39) -> i1
      %168 = comb.xor %165, %167 : i1
      llhd.drv %163, %168 after %0 : i1
      %169 = llhd.sig.extract %data_o from %c-12_i5 : <i32> -> <i1>
      %170 = llhd.prb %syndrome_o : i7
      %171 = comb.icmp eq %170, %c-58_i7 : i7
      %172 = llhd.prb %data_i_0 : i39
      %173 = comb.extract %172 from 20 : (i39) -> i1
      %174 = comb.xor %171, %173 : i1
      llhd.drv %169, %174 after %0 : i1
      %175 = llhd.sig.extract %data_o from %c-11_i5 : <i32> -> <i1>
      %176 = llhd.prb %syndrome_o : i7
      %177 = comb.icmp eq %176, %c14_i7 : i7
      %178 = llhd.prb %data_i_0 : i39
      %179 = comb.extract %178 from 21 : (i39) -> i1
      %180 = comb.xor %177, %179 : i1
      llhd.drv %175, %180 after %0 : i1
      %181 = llhd.sig.extract %data_o from %c-10_i5 : <i32> -> <i1>
      %182 = llhd.prb %syndrome_o : i7
      %183 = comb.icmp eq %182, %c-16_i7 : i7
      %184 = llhd.prb %data_i_0 : i39
      %185 = comb.extract %184 from 22 : (i39) -> i1
      %186 = comb.xor %183, %185 : i1
      llhd.drv %181, %186 after %0 : i1
      %187 = llhd.sig.extract %data_o from %c-9_i5 : <i32> -> <i1>
      %188 = llhd.prb %syndrome_o : i7
      %189 = comb.icmp eq %188, %c50_i7 : i7
      %190 = llhd.prb %data_i_0 : i39
      %191 = comb.extract %190 from 23 : (i39) -> i1
      %192 = comb.xor %189, %191 : i1
      llhd.drv %187, %192 after %0 : i1
      %193 = llhd.sig.extract %data_o from %c-8_i5 : <i32> -> <i1>
      %194 = llhd.prb %syndrome_o : i7
      %195 = comb.icmp eq %194, %c44_i7 : i7
      %196 = llhd.prb %data_i_0 : i39
      %197 = comb.extract %196 from 24 : (i39) -> i1
      %198 = comb.xor %195, %197 : i1
      llhd.drv %193, %198 after %0 : i1
      %199 = llhd.sig.extract %data_o from %c-7_i5 : <i32> -> <i1>
      %200 = llhd.prb %syndrome_o : i7
      %201 = comb.icmp eq %200, %c19_i7 : i7
      %202 = llhd.prb %data_i_0 : i39
      %203 = comb.extract %202 from 25 : (i39) -> i1
      %204 = comb.xor %201, %203 : i1
      llhd.drv %199, %204 after %0 : i1
      %205 = llhd.sig.extract %data_o from %c-6_i5 : <i32> -> <i1>
      %206 = llhd.prb %syndrome_o : i7
      %207 = comb.icmp eq %206, %c35_i7 : i7
      %208 = llhd.prb %data_i_0 : i39
      %209 = comb.extract %208 from 26 : (i39) -> i1
      %210 = comb.xor %207, %209 : i1
      llhd.drv %205, %210 after %0 : i1
      %211 = llhd.sig.extract %data_o from %c-5_i5 : <i32> -> <i1>
      %212 = llhd.prb %syndrome_o : i7
      %213 = comb.icmp eq %212, %c-30_i7 : i7
      %214 = llhd.prb %data_i_0 : i39
      %215 = comb.extract %214 from 27 : (i39) -> i1
      %216 = comb.xor %213, %215 : i1
      llhd.drv %211, %216 after %0 : i1
      %217 = llhd.sig.extract %data_o from %c-4_i5 : <i32> -> <i1>
      %218 = llhd.prb %syndrome_o : i7
      %219 = comb.icmp eq %218, %c-54_i7 : i7
      %220 = llhd.prb %data_i_0 : i39
      %221 = comb.extract %220 from 28 : (i39) -> i1
      %222 = comb.xor %219, %221 : i1
      llhd.drv %217, %222 after %0 : i1
      %223 = llhd.sig.extract %data_o from %c-3_i5 : <i32> -> <i1>
      %224 = llhd.prb %syndrome_o : i7
      %225 = comb.icmp eq %224, %c41_i7 : i7
      %226 = llhd.prb %data_i_0 : i39
      %227 = comb.extract %226 from 29 : (i39) -> i1
      %228 = comb.xor %225, %227 : i1
      llhd.drv %223, %228 after %0 : i1
      %229 = llhd.sig.extract %data_o from %c-2_i5 : <i32> -> <i1>
      %230 = llhd.prb %syndrome_o : i7
      %231 = comb.icmp eq %230, %c22_i7 : i7
      %232 = llhd.prb %data_i_0 : i39
      %233 = comb.extract %232 from 30 : (i39) -> i1
      %234 = comb.xor %231, %233 : i1
      llhd.drv %229, %234 after %0 : i1
      %235 = llhd.sig.extract %data_o from %c-1_i5 : <i32> -> <i1>
      %236 = llhd.prb %syndrome_o : i7
      %237 = comb.icmp eq %236, %c-46_i7 : i7
      %238 = llhd.prb %data_i_0 : i39
      %239 = comb.extract %238 from 31 : (i39) -> i1
      %240 = comb.xor %237, %239 : i1
      llhd.drv %235, %240 after %0 : i1
      %241 = llhd.sig.extract %err_o from %false : <i2> -> <i1>
      %242 = llhd.prb %syndrome_o : i7
      %243 = comb.parity %242 : i7
      llhd.drv %241, %243 after %0 : i1
      %244 = llhd.sig.extract %err_o from %true : <i2> -> <i1>
      %245 = llhd.prb %err_o : i2
      %246 = comb.extract %245 from 0 : (i2) -> i1
      %247 = comb.xor %246, %true : i1
      %248 = llhd.prb %syndrome_o : i7
      %249 = comb.icmp ne %248, %c0_i7 : i7
      %250 = comb.and %247, %249 : i1
      llhd.drv %244, %250 after %0 : i1
      llhd.wait (%1, %2, %3, %4 : i7, i39, i32, i2), ^bb1
    }
    llhd.drv %data_i_0, %data_i after %0 : i39
    hw.output %3, %1, %4 : i32, i7, i2
  }
  hw.module private @prim_secded_inv_39_32_enc(in %data_i : i32, out data_o : i39) {
    %c-869782845_i31 = hw.constant -869782845 : i31
    %c0_i2 = hw.constant 0 : i2
    %c0_i9 = hw.constant 0 : i9
    %c-76343149_i28 = hw.constant -76343149 : i28
    %c-1027526085_i32 = hw.constant -1027526085 : i32
    %c-249344303_i30 = hw.constant -249344303 : i30
    %false = hw.constant false
    %c0_i8 = hw.constant 0 : i8
    %c-526465835_i30 = hw.constant -526465835 : i30
    %c0_i4 = hw.constant 0 : i4
    %c-34887675_i28 = hw.constant -34887675 : i28
    %c-435765979_i30 = hw.constant -435765979 : i30
    %c-26_i6 = hw.constant -26 : i6
    %c-27_i6 = hw.constant -27 : i6
    %c-28_i6 = hw.constant -28 : i6
    %c-29_i6 = hw.constant -29 : i6
    %c-30_i6 = hw.constant -30 : i6
    %c-31_i6 = hw.constant -31 : i6
    %c-32_i6 = hw.constant -32 : i6
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i7 = hw.constant 0 : i7
    %c0_i39 = hw.constant 0 : i39
    %c180388626432_i39 = hw.constant 180388626432 : i39
    %c0_i32 = hw.constant 0 : i32
    %data_i_0 = llhd.sig name "data_i" %c0_i32 : i32
    %data_o = llhd.sig %c0_i39 : i39
    %1 = llhd.prb %data_i_0 : i32
    %2 = llhd.prb %data_o : i39
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %3 = llhd.prb %data_i_0 : i32
      %4 = comb.concat %c0_i7, %3 : i7, i32
      llhd.drv %data_o, %4 after %0 : i39
      %5 = llhd.sig.extract %data_o from %c-32_i6 : <i39> -> <i1>
      %6 = llhd.prb %data_o : i39
      %7 = comb.extract %6 from 0 : (i39) -> i30
      %8 = comb.and %7, %c-435765979_i30 : i30
      %9 = comb.parity %8 : i30
      llhd.drv %5, %9 after %0 : i1
      %10 = llhd.sig.extract %data_o from %c-31_i6 : <i39> -> <i1>
      %11 = llhd.prb %data_o : i39
      %12 = comb.extract %11 from 4 : (i39) -> i28
      %13 = comb.and %12, %c-34887675_i28 : i28
      %14 = comb.concat %c0_i7, %13, %c0_i4 : i7, i28, i4
      %15 = comb.parity %14 : i39
      llhd.drv %10, %15 after %0 : i1
      %16 = llhd.sig.extract %data_o from %c-30_i6 : <i39> -> <i1>
      %17 = llhd.prb %data_o : i39
      %18 = comb.extract %17 from 1 : (i39) -> i30
      %19 = comb.and %18, %c-526465835_i30 : i30
      %20 = comb.concat %c0_i8, %19, %false : i8, i30, i1
      %21 = comb.parity %20 : i39
      llhd.drv %16, %21 after %0 : i1
      %22 = llhd.sig.extract %data_o from %c-29_i6 : <i39> -> <i1>
      %23 = llhd.prb %data_o : i39
      %24 = comb.extract %23 from 0 : (i39) -> i30
      %25 = comb.and %24, %c-249344303_i30 : i30
      %26 = comb.parity %25 : i30
      llhd.drv %22, %26 after %0 : i1
      %27 = llhd.sig.extract %data_o from %c-28_i6 : <i39> -> <i1>
      %28 = llhd.prb %data_o : i39
      %29 = comb.extract %28 from 0 : (i39) -> i32
      %30 = comb.and %29, %c-1027526085_i32 : i32
      %31 = comb.parity %30 : i32
      llhd.drv %27, %31 after %0 : i1
      %32 = llhd.sig.extract %data_o from %c-27_i6 : <i39> -> <i1>
      %33 = llhd.prb %data_o : i39
      %34 = comb.extract %33 from 2 : (i39) -> i28
      %35 = comb.and %34, %c-76343149_i28 : i28
      %36 = comb.concat %c0_i9, %35, %c0_i2 : i9, i28, i2
      %37 = comb.parity %36 : i39
      llhd.drv %32, %37 after %0 : i1
      %38 = llhd.sig.extract %data_o from %c-26_i6 : <i39> -> <i1>
      %39 = llhd.prb %data_o : i39
      %40 = comb.extract %39 from 1 : (i39) -> i31
      %41 = comb.and %40, %c-869782845_i31 : i31
      %42 = comb.concat %c0_i7, %41, %false : i7, i31, i1
      %43 = comb.parity %42 : i39
      llhd.drv %38, %43 after %0 : i1
      %44 = llhd.prb %data_o : i39
      %45 = comb.xor %44, %c180388626432_i39 : i39
      llhd.drv %data_o, %45 after %0 : i39
      llhd.wait (%1, %2 : i32, i39), ^bb1
    }
    llhd.drv %data_i_0, %data_i after %0 : i32
    hw.output %2 : i39
  }
  hw.module private @prim_secded_inv_64_57_dec(in %data_i : i64, out data_o : i57, out syndrome_o : i7, out err_o : i2) {
    %c-567526282035050863_i60 = hw.constant -567526282035050863 : i60
    %c378302368699121664_i60 = hw.constant 378302368699121664 : i60
    %c-558737265440175471_i60 = hw.constant -558737265440175471 : i60
    %c-396316767208603648_i60 = hw.constant -396316767208603648 : i60
    %c-541595567475503983_i60 = hw.constant -541595567475503983 : i60
    %c360287970189639680_i60 = hw.constant 360287970189639680 : i60
    %c-509057263091300591_i60 = hw.constant -509057263091300591 : i60
    %c-432345564227567616_i60 = hw.constant -432345564227567616 : i60
    %c-450955930284621343_i60 = hw.constant -450955930284621343 : i60
    %c288230376151711744_i60 = hw.constant 288230376151711744 : i60
    %c-181234734955790305_i59 = hw.constant -181234734955790305 : i59
    %c-288230376151711744_i59 = hw.constant -288230376151711744 : i59
    %c-70931728490790913_i58 = hw.constant -70931728490790913 : i58
    %true = hw.constant true
    %false = hw.constant false
    %c-8_i6 = hw.constant -8 : i6
    %c-9_i6 = hw.constant -9 : i6
    %c-10_i6 = hw.constant -10 : i6
    %c-11_i6 = hw.constant -11 : i6
    %c-12_i6 = hw.constant -12 : i6
    %c-13_i6 = hw.constant -13 : i6
    %c-14_i6 = hw.constant -14 : i6
    %c-15_i6 = hw.constant -15 : i6
    %c-16_i6 = hw.constant -16 : i6
    %c-17_i6 = hw.constant -17 : i6
    %c-18_i6 = hw.constant -18 : i6
    %c-19_i6 = hw.constant -19 : i6
    %c-20_i6 = hw.constant -20 : i6
    %c-21_i6 = hw.constant -21 : i6
    %c-22_i6 = hw.constant -22 : i6
    %c-23_i6 = hw.constant -23 : i6
    %c-24_i6 = hw.constant -24 : i6
    %c-25_i6 = hw.constant -25 : i6
    %c-26_i6 = hw.constant -26 : i6
    %c-27_i6 = hw.constant -27 : i6
    %c-28_i6 = hw.constant -28 : i6
    %c-29_i6 = hw.constant -29 : i6
    %c-30_i6 = hw.constant -30 : i6
    %c-31_i6 = hw.constant -31 : i6
    %c-32_i6 = hw.constant -32 : i6
    %c31_i6 = hw.constant 31 : i6
    %c30_i6 = hw.constant 30 : i6
    %c29_i6 = hw.constant 29 : i6
    %c28_i6 = hw.constant 28 : i6
    %c27_i6 = hw.constant 27 : i6
    %c26_i6 = hw.constant 26 : i6
    %c25_i6 = hw.constant 25 : i6
    %c24_i6 = hw.constant 24 : i6
    %c23_i6 = hw.constant 23 : i6
    %c22_i6 = hw.constant 22 : i6
    %c21_i6 = hw.constant 21 : i6
    %c20_i6 = hw.constant 20 : i6
    %c19_i6 = hw.constant 19 : i6
    %c18_i6 = hw.constant 18 : i6
    %c17_i6 = hw.constant 17 : i6
    %c16_i6 = hw.constant 16 : i6
    %c15_i6 = hw.constant 15 : i6
    %c14_i6 = hw.constant 14 : i6
    %c13_i6 = hw.constant 13 : i6
    %c12_i6 = hw.constant 12 : i6
    %c11_i6 = hw.constant 11 : i6
    %c10_i6 = hw.constant 10 : i6
    %c9_i6 = hw.constant 9 : i6
    %c8_i6 = hw.constant 8 : i6
    %c7_i6 = hw.constant 7 : i6
    %c6_i6 = hw.constant 6 : i6
    %c5_i6 = hw.constant 5 : i6
    %c4_i6 = hw.constant 4 : i6
    %c3_i6 = hw.constant 3 : i6
    %c2_i6 = hw.constant 2 : i6
    %c1_i6 = hw.constant 1 : i6
    %c0_i6 = hw.constant 0 : i6
    %c-2_i3 = hw.constant -2 : i3
    %c-3_i3 = hw.constant -3 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c3_i3 = hw.constant 3 : i3
    %c2_i3 = hw.constant 2 : i3
    %c1_i3 = hw.constant 1 : i3
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i3 = hw.constant 0 : i3
    %c0_i2 = hw.constant 0 : i2
    %c0_i7 = hw.constant 0 : i7
    %c0_i57 = hw.constant 0 : i57
    %c-1_i7 = hw.constant -1 : i7
    %c-4_i7 = hw.constant -4 : i7
    %c-6_i7 = hw.constant -6 : i7
    %c-10_i7 = hw.constant -10 : i7
    %c-18_i7 = hw.constant -18 : i7
    %c-34_i7 = hw.constant -34 : i7
    %c62_i7 = hw.constant 62 : i7
    %c-7_i7 = hw.constant -7 : i7
    %c-11_i7 = hw.constant -11 : i7
    %c-19_i7 = hw.constant -19 : i7
    %c-35_i7 = hw.constant -35 : i7
    %c61_i7 = hw.constant 61 : i7
    %c-13_i7 = hw.constant -13 : i7
    %c-21_i7 = hw.constant -21 : i7
    %c-37_i7 = hw.constant -37 : i7
    %c59_i7 = hw.constant 59 : i7
    %c-25_i7 = hw.constant -25 : i7
    %c-41_i7 = hw.constant -41 : i7
    %c55_i7 = hw.constant 55 : i7
    %c-49_i7 = hw.constant -49 : i7
    %c47_i7 = hw.constant 47 : i7
    %c31_i7 = hw.constant 31 : i7
    %c-16_i7 = hw.constant -16 : i7
    %c-24_i7 = hw.constant -24 : i7
    %c-40_i7 = hw.constant -40 : i7
    %c56_i7 = hw.constant 56 : i7
    %c-28_i7 = hw.constant -28 : i7
    %c-44_i7 = hw.constant -44 : i7
    %c52_i7 = hw.constant 52 : i7
    %c-52_i7 = hw.constant -52 : i7
    %c44_i7 = hw.constant 44 : i7
    %c28_i7 = hw.constant 28 : i7
    %c-30_i7 = hw.constant -30 : i7
    %c-46_i7 = hw.constant -46 : i7
    %c50_i7 = hw.constant 50 : i7
    %c-54_i7 = hw.constant -54 : i7
    %c42_i7 = hw.constant 42 : i7
    %c26_i7 = hw.constant 26 : i7
    %c-58_i7 = hw.constant -58 : i7
    %c38_i7 = hw.constant 38 : i7
    %c22_i7 = hw.constant 22 : i7
    %c14_i7 = hw.constant 14 : i7
    %c-31_i7 = hw.constant -31 : i7
    %c-47_i7 = hw.constant -47 : i7
    %c49_i7 = hw.constant 49 : i7
    %c-55_i7 = hw.constant -55 : i7
    %c41_i7 = hw.constant 41 : i7
    %c25_i7 = hw.constant 25 : i7
    %c-59_i7 = hw.constant -59 : i7
    %c37_i7 = hw.constant 37 : i7
    %c21_i7 = hw.constant 21 : i7
    %c13_i7 = hw.constant 13 : i7
    %c-61_i7 = hw.constant -61 : i7
    %c35_i7 = hw.constant 35 : i7
    %c19_i7 = hw.constant 19 : i7
    %c11_i7 = hw.constant 11 : i7
    %c7_i7 = hw.constant 7 : i7
    %c0_i64 = hw.constant 0 : i64
    %data_i_0 = llhd.sig name "data_i" %c0_i64 : i64
    %data_o = llhd.sig %c0_i57 : i57
    %syndrome_o = llhd.sig %c0_i7 : i7
    %err_o = llhd.sig %c0_i2 : i2
    %1 = llhd.prb %syndrome_o : i7
    %2 = llhd.prb %data_i_0 : i64
    %3 = llhd.prb %data_o : i57
    %4 = llhd.prb %err_o : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %5 = llhd.sig.extract %syndrome_o from %c0_i3 : <i7> -> <i1>
      %6 = llhd.prb %data_i_0 : i64
      %7 = comb.extract %6 from 0 : (i64) -> i58
      %8 = comb.and %7, %c-70931728490790913_i58 : i58
      %9 = comb.parity %8 : i58
      llhd.drv %5, %9 after %0 : i1
      %10 = llhd.sig.extract %syndrome_o from %c1_i3 : <i7> -> <i1>
      %11 = llhd.prb %data_i_0 : i64
      %12 = comb.extract %11 from 0 : (i64) -> i59
      %13 = comb.xor %12, %c-288230376151711744_i59 : i59
      %14 = comb.and %13, %c-181234734955790305_i59 : i59
      %15 = comb.parity %14 : i59
      llhd.drv %10, %15 after %0 : i1
      %16 = llhd.sig.extract %syndrome_o from %c2_i3 : <i7> -> <i1>
      %17 = llhd.prb %data_i_0 : i64
      %18 = comb.extract %17 from 0 : (i64) -> i60
      %19 = comb.xor %18, %c288230376151711744_i60 : i60
      %20 = comb.and %19, %c-450955930284621343_i60 : i60
      %21 = comb.parity %20 : i60
      llhd.drv %16, %21 after %0 : i1
      %22 = llhd.sig.extract %syndrome_o from %c3_i3 : <i7> -> <i1>
      %23 = llhd.prb %data_i_0 : i64
      %24 = comb.extract %23 from 1 : (i64) -> i60
      %25 = comb.xor %24, %c-432345564227567616_i60 : i60
      %26 = comb.and %25, %c-509057263091300591_i60 : i60
      %27 = comb.concat %c0_i3, %26, %false : i3, i60, i1
      %28 = comb.parity %27 : i64
      llhd.drv %22, %28 after %0 : i1
      %29 = llhd.sig.extract %syndrome_o from %c-4_i3 : <i7> -> <i1>
      %30 = llhd.prb %data_i_0 : i64
      %31 = comb.extract %30 from 2 : (i64) -> i60
      %32 = comb.xor %31, %c360287970189639680_i60 : i60
      %33 = comb.and %32, %c-541595567475503983_i60 : i60
      %34 = comb.concat %c0_i2, %33, %c0_i2 : i2, i60, i2
      %35 = comb.parity %34 : i64
      llhd.drv %29, %35 after %0 : i1
      %36 = llhd.sig.extract %syndrome_o from %c-3_i3 : <i7> -> <i1>
      %37 = llhd.prb %data_i_0 : i64
      %38 = comb.extract %37 from 3 : (i64) -> i60
      %39 = comb.xor %38, %c-396316767208603648_i60 : i60
      %40 = comb.and %39, %c-558737265440175471_i60 : i60
      %41 = comb.concat %false, %40, %c0_i3 : i1, i60, i3
      %42 = comb.parity %41 : i64
      llhd.drv %36, %42 after %0 : i1
      %43 = llhd.sig.extract %syndrome_o from %c-2_i3 : <i7> -> <i1>
      %44 = llhd.prb %data_i_0 : i64
      %45 = comb.extract %44 from 4 : (i64) -> i60
      %46 = comb.xor %45, %c378302368699121664_i60 : i60
      %47 = comb.and %46, %c-567526282035050863_i60 : i60
      %48 = comb.parity %47 : i60
      llhd.drv %43, %48 after %0 : i1
      %49 = llhd.sig.extract %data_o from %c0_i6 : <i57> -> <i1>
      %50 = llhd.prb %syndrome_o : i7
      %51 = comb.icmp eq %50, %c7_i7 : i7
      %52 = llhd.prb %data_i_0 : i64
      %53 = comb.extract %52 from 0 : (i64) -> i1
      %54 = comb.xor %51, %53 : i1
      llhd.drv %49, %54 after %0 : i1
      %55 = llhd.sig.extract %data_o from %c1_i6 : <i57> -> <i1>
      %56 = llhd.prb %syndrome_o : i7
      %57 = comb.icmp eq %56, %c11_i7 : i7
      %58 = llhd.prb %data_i_0 : i64
      %59 = comb.extract %58 from 1 : (i64) -> i1
      %60 = comb.xor %57, %59 : i1
      llhd.drv %55, %60 after %0 : i1
      %61 = llhd.sig.extract %data_o from %c2_i6 : <i57> -> <i1>
      %62 = llhd.prb %syndrome_o : i7
      %63 = comb.icmp eq %62, %c19_i7 : i7
      %64 = llhd.prb %data_i_0 : i64
      %65 = comb.extract %64 from 2 : (i64) -> i1
      %66 = comb.xor %63, %65 : i1
      llhd.drv %61, %66 after %0 : i1
      %67 = llhd.sig.extract %data_o from %c3_i6 : <i57> -> <i1>
      %68 = llhd.prb %syndrome_o : i7
      %69 = comb.icmp eq %68, %c35_i7 : i7
      %70 = llhd.prb %data_i_0 : i64
      %71 = comb.extract %70 from 3 : (i64) -> i1
      %72 = comb.xor %69, %71 : i1
      llhd.drv %67, %72 after %0 : i1
      %73 = llhd.sig.extract %data_o from %c4_i6 : <i57> -> <i1>
      %74 = llhd.prb %syndrome_o : i7
      %75 = comb.icmp eq %74, %c-61_i7 : i7
      %76 = llhd.prb %data_i_0 : i64
      %77 = comb.extract %76 from 4 : (i64) -> i1
      %78 = comb.xor %75, %77 : i1
      llhd.drv %73, %78 after %0 : i1
      %79 = llhd.sig.extract %data_o from %c5_i6 : <i57> -> <i1>
      %80 = llhd.prb %syndrome_o : i7
      %81 = comb.icmp eq %80, %c13_i7 : i7
      %82 = llhd.prb %data_i_0 : i64
      %83 = comb.extract %82 from 5 : (i64) -> i1
      %84 = comb.xor %81, %83 : i1
      llhd.drv %79, %84 after %0 : i1
      %85 = llhd.sig.extract %data_o from %c6_i6 : <i57> -> <i1>
      %86 = llhd.prb %syndrome_o : i7
      %87 = comb.icmp eq %86, %c21_i7 : i7
      %88 = llhd.prb %data_i_0 : i64
      %89 = comb.extract %88 from 6 : (i64) -> i1
      %90 = comb.xor %87, %89 : i1
      llhd.drv %85, %90 after %0 : i1
      %91 = llhd.sig.extract %data_o from %c7_i6 : <i57> -> <i1>
      %92 = llhd.prb %syndrome_o : i7
      %93 = comb.icmp eq %92, %c37_i7 : i7
      %94 = llhd.prb %data_i_0 : i64
      %95 = comb.extract %94 from 7 : (i64) -> i1
      %96 = comb.xor %93, %95 : i1
      llhd.drv %91, %96 after %0 : i1
      %97 = llhd.sig.extract %data_o from %c8_i6 : <i57> -> <i1>
      %98 = llhd.prb %syndrome_o : i7
      %99 = comb.icmp eq %98, %c-59_i7 : i7
      %100 = llhd.prb %data_i_0 : i64
      %101 = comb.extract %100 from 8 : (i64) -> i1
      %102 = comb.xor %99, %101 : i1
      llhd.drv %97, %102 after %0 : i1
      %103 = llhd.sig.extract %data_o from %c9_i6 : <i57> -> <i1>
      %104 = llhd.prb %syndrome_o : i7
      %105 = comb.icmp eq %104, %c25_i7 : i7
      %106 = llhd.prb %data_i_0 : i64
      %107 = comb.extract %106 from 9 : (i64) -> i1
      %108 = comb.xor %105, %107 : i1
      llhd.drv %103, %108 after %0 : i1
      %109 = llhd.sig.extract %data_o from %c10_i6 : <i57> -> <i1>
      %110 = llhd.prb %syndrome_o : i7
      %111 = comb.icmp eq %110, %c41_i7 : i7
      %112 = llhd.prb %data_i_0 : i64
      %113 = comb.extract %112 from 10 : (i64) -> i1
      %114 = comb.xor %111, %113 : i1
      llhd.drv %109, %114 after %0 : i1
      %115 = llhd.sig.extract %data_o from %c11_i6 : <i57> -> <i1>
      %116 = llhd.prb %syndrome_o : i7
      %117 = comb.icmp eq %116, %c-55_i7 : i7
      %118 = llhd.prb %data_i_0 : i64
      %119 = comb.extract %118 from 11 : (i64) -> i1
      %120 = comb.xor %117, %119 : i1
      llhd.drv %115, %120 after %0 : i1
      %121 = llhd.sig.extract %data_o from %c12_i6 : <i57> -> <i1>
      %122 = llhd.prb %syndrome_o : i7
      %123 = comb.icmp eq %122, %c49_i7 : i7
      %124 = llhd.prb %data_i_0 : i64
      %125 = comb.extract %124 from 12 : (i64) -> i1
      %126 = comb.xor %123, %125 : i1
      llhd.drv %121, %126 after %0 : i1
      %127 = llhd.sig.extract %data_o from %c13_i6 : <i57> -> <i1>
      %128 = llhd.prb %syndrome_o : i7
      %129 = comb.icmp eq %128, %c-47_i7 : i7
      %130 = llhd.prb %data_i_0 : i64
      %131 = comb.extract %130 from 13 : (i64) -> i1
      %132 = comb.xor %129, %131 : i1
      llhd.drv %127, %132 after %0 : i1
      %133 = llhd.sig.extract %data_o from %c14_i6 : <i57> -> <i1>
      %134 = llhd.prb %syndrome_o : i7
      %135 = comb.icmp eq %134, %c-31_i7 : i7
      %136 = llhd.prb %data_i_0 : i64
      %137 = comb.extract %136 from 14 : (i64) -> i1
      %138 = comb.xor %135, %137 : i1
      llhd.drv %133, %138 after %0 : i1
      %139 = llhd.sig.extract %data_o from %c15_i6 : <i57> -> <i1>
      %140 = llhd.prb %syndrome_o : i7
      %141 = comb.icmp eq %140, %c14_i7 : i7
      %142 = llhd.prb %data_i_0 : i64
      %143 = comb.extract %142 from 15 : (i64) -> i1
      %144 = comb.xor %141, %143 : i1
      llhd.drv %139, %144 after %0 : i1
      %145 = llhd.sig.extract %data_o from %c16_i6 : <i57> -> <i1>
      %146 = llhd.prb %syndrome_o : i7
      %147 = comb.icmp eq %146, %c22_i7 : i7
      %148 = llhd.prb %data_i_0 : i64
      %149 = comb.extract %148 from 16 : (i64) -> i1
      %150 = comb.xor %147, %149 : i1
      llhd.drv %145, %150 after %0 : i1
      %151 = llhd.sig.extract %data_o from %c17_i6 : <i57> -> <i1>
      %152 = llhd.prb %syndrome_o : i7
      %153 = comb.icmp eq %152, %c38_i7 : i7
      %154 = llhd.prb %data_i_0 : i64
      %155 = comb.extract %154 from 17 : (i64) -> i1
      %156 = comb.xor %153, %155 : i1
      llhd.drv %151, %156 after %0 : i1
      %157 = llhd.sig.extract %data_o from %c18_i6 : <i57> -> <i1>
      %158 = llhd.prb %syndrome_o : i7
      %159 = comb.icmp eq %158, %c-58_i7 : i7
      %160 = llhd.prb %data_i_0 : i64
      %161 = comb.extract %160 from 18 : (i64) -> i1
      %162 = comb.xor %159, %161 : i1
      llhd.drv %157, %162 after %0 : i1
      %163 = llhd.sig.extract %data_o from %c19_i6 : <i57> -> <i1>
      %164 = llhd.prb %syndrome_o : i7
      %165 = comb.icmp eq %164, %c26_i7 : i7
      %166 = llhd.prb %data_i_0 : i64
      %167 = comb.extract %166 from 19 : (i64) -> i1
      %168 = comb.xor %165, %167 : i1
      llhd.drv %163, %168 after %0 : i1
      %169 = llhd.sig.extract %data_o from %c20_i6 : <i57> -> <i1>
      %170 = llhd.prb %syndrome_o : i7
      %171 = comb.icmp eq %170, %c42_i7 : i7
      %172 = llhd.prb %data_i_0 : i64
      %173 = comb.extract %172 from 20 : (i64) -> i1
      %174 = comb.xor %171, %173 : i1
      llhd.drv %169, %174 after %0 : i1
      %175 = llhd.sig.extract %data_o from %c21_i6 : <i57> -> <i1>
      %176 = llhd.prb %syndrome_o : i7
      %177 = comb.icmp eq %176, %c-54_i7 : i7
      %178 = llhd.prb %data_i_0 : i64
      %179 = comb.extract %178 from 21 : (i64) -> i1
      %180 = comb.xor %177, %179 : i1
      llhd.drv %175, %180 after %0 : i1
      %181 = llhd.sig.extract %data_o from %c22_i6 : <i57> -> <i1>
      %182 = llhd.prb %syndrome_o : i7
      %183 = comb.icmp eq %182, %c50_i7 : i7
      %184 = llhd.prb %data_i_0 : i64
      %185 = comb.extract %184 from 22 : (i64) -> i1
      %186 = comb.xor %183, %185 : i1
      llhd.drv %181, %186 after %0 : i1
      %187 = llhd.sig.extract %data_o from %c23_i6 : <i57> -> <i1>
      %188 = llhd.prb %syndrome_o : i7
      %189 = comb.icmp eq %188, %c-46_i7 : i7
      %190 = llhd.prb %data_i_0 : i64
      %191 = comb.extract %190 from 23 : (i64) -> i1
      %192 = comb.xor %189, %191 : i1
      llhd.drv %187, %192 after %0 : i1
      %193 = llhd.sig.extract %data_o from %c24_i6 : <i57> -> <i1>
      %194 = llhd.prb %syndrome_o : i7
      %195 = comb.icmp eq %194, %c-30_i7 : i7
      %196 = llhd.prb %data_i_0 : i64
      %197 = comb.extract %196 from 24 : (i64) -> i1
      %198 = comb.xor %195, %197 : i1
      llhd.drv %193, %198 after %0 : i1
      %199 = llhd.sig.extract %data_o from %c25_i6 : <i57> -> <i1>
      %200 = llhd.prb %syndrome_o : i7
      %201 = comb.icmp eq %200, %c28_i7 : i7
      %202 = llhd.prb %data_i_0 : i64
      %203 = comb.extract %202 from 25 : (i64) -> i1
      %204 = comb.xor %201, %203 : i1
      llhd.drv %199, %204 after %0 : i1
      %205 = llhd.sig.extract %data_o from %c26_i6 : <i57> -> <i1>
      %206 = llhd.prb %syndrome_o : i7
      %207 = comb.icmp eq %206, %c44_i7 : i7
      %208 = llhd.prb %data_i_0 : i64
      %209 = comb.extract %208 from 26 : (i64) -> i1
      %210 = comb.xor %207, %209 : i1
      llhd.drv %205, %210 after %0 : i1
      %211 = llhd.sig.extract %data_o from %c27_i6 : <i57> -> <i1>
      %212 = llhd.prb %syndrome_o : i7
      %213 = comb.icmp eq %212, %c-52_i7 : i7
      %214 = llhd.prb %data_i_0 : i64
      %215 = comb.extract %214 from 27 : (i64) -> i1
      %216 = comb.xor %213, %215 : i1
      llhd.drv %211, %216 after %0 : i1
      %217 = llhd.sig.extract %data_o from %c28_i6 : <i57> -> <i1>
      %218 = llhd.prb %syndrome_o : i7
      %219 = comb.icmp eq %218, %c52_i7 : i7
      %220 = llhd.prb %data_i_0 : i64
      %221 = comb.extract %220 from 28 : (i64) -> i1
      %222 = comb.xor %219, %221 : i1
      llhd.drv %217, %222 after %0 : i1
      %223 = llhd.sig.extract %data_o from %c29_i6 : <i57> -> <i1>
      %224 = llhd.prb %syndrome_o : i7
      %225 = comb.icmp eq %224, %c-44_i7 : i7
      %226 = llhd.prb %data_i_0 : i64
      %227 = comb.extract %226 from 29 : (i64) -> i1
      %228 = comb.xor %225, %227 : i1
      llhd.drv %223, %228 after %0 : i1
      %229 = llhd.sig.extract %data_o from %c30_i6 : <i57> -> <i1>
      %230 = llhd.prb %syndrome_o : i7
      %231 = comb.icmp eq %230, %c-28_i7 : i7
      %232 = llhd.prb %data_i_0 : i64
      %233 = comb.extract %232 from 30 : (i64) -> i1
      %234 = comb.xor %231, %233 : i1
      llhd.drv %229, %234 after %0 : i1
      %235 = llhd.sig.extract %data_o from %c31_i6 : <i57> -> <i1>
      %236 = llhd.prb %syndrome_o : i7
      %237 = comb.icmp eq %236, %c56_i7 : i7
      %238 = llhd.prb %data_i_0 : i64
      %239 = comb.extract %238 from 31 : (i64) -> i1
      %240 = comb.xor %237, %239 : i1
      llhd.drv %235, %240 after %0 : i1
      %241 = llhd.sig.extract %data_o from %c-32_i6 : <i57> -> <i1>
      %242 = llhd.prb %syndrome_o : i7
      %243 = comb.icmp eq %242, %c-40_i7 : i7
      %244 = llhd.prb %data_i_0 : i64
      %245 = comb.extract %244 from 32 : (i64) -> i1
      %246 = comb.xor %243, %245 : i1
      llhd.drv %241, %246 after %0 : i1
      %247 = llhd.sig.extract %data_o from %c-31_i6 : <i57> -> <i1>
      %248 = llhd.prb %syndrome_o : i7
      %249 = comb.icmp eq %248, %c-24_i7 : i7
      %250 = llhd.prb %data_i_0 : i64
      %251 = comb.extract %250 from 33 : (i64) -> i1
      %252 = comb.xor %249, %251 : i1
      llhd.drv %247, %252 after %0 : i1
      %253 = llhd.sig.extract %data_o from %c-30_i6 : <i57> -> <i1>
      %254 = llhd.prb %syndrome_o : i7
      %255 = comb.icmp eq %254, %c-16_i7 : i7
      %256 = llhd.prb %data_i_0 : i64
      %257 = comb.extract %256 from 34 : (i64) -> i1
      %258 = comb.xor %255, %257 : i1
      llhd.drv %253, %258 after %0 : i1
      %259 = llhd.sig.extract %data_o from %c-29_i6 : <i57> -> <i1>
      %260 = llhd.prb %syndrome_o : i7
      %261 = comb.icmp eq %260, %c31_i7 : i7
      %262 = llhd.prb %data_i_0 : i64
      %263 = comb.extract %262 from 35 : (i64) -> i1
      %264 = comb.xor %261, %263 : i1
      llhd.drv %259, %264 after %0 : i1
      %265 = llhd.sig.extract %data_o from %c-28_i6 : <i57> -> <i1>
      %266 = llhd.prb %syndrome_o : i7
      %267 = comb.icmp eq %266, %c47_i7 : i7
      %268 = llhd.prb %data_i_0 : i64
      %269 = comb.extract %268 from 36 : (i64) -> i1
      %270 = comb.xor %267, %269 : i1
      llhd.drv %265, %270 after %0 : i1
      %271 = llhd.sig.extract %data_o from %c-27_i6 : <i57> -> <i1>
      %272 = llhd.prb %syndrome_o : i7
      %273 = comb.icmp eq %272, %c-49_i7 : i7
      %274 = llhd.prb %data_i_0 : i64
      %275 = comb.extract %274 from 37 : (i64) -> i1
      %276 = comb.xor %273, %275 : i1
      llhd.drv %271, %276 after %0 : i1
      %277 = llhd.sig.extract %data_o from %c-26_i6 : <i57> -> <i1>
      %278 = llhd.prb %syndrome_o : i7
      %279 = comb.icmp eq %278, %c55_i7 : i7
      %280 = llhd.prb %data_i_0 : i64
      %281 = comb.extract %280 from 38 : (i64) -> i1
      %282 = comb.xor %279, %281 : i1
      llhd.drv %277, %282 after %0 : i1
      %283 = llhd.sig.extract %data_o from %c-25_i6 : <i57> -> <i1>
      %284 = llhd.prb %syndrome_o : i7
      %285 = comb.icmp eq %284, %c-41_i7 : i7
      %286 = llhd.prb %data_i_0 : i64
      %287 = comb.extract %286 from 39 : (i64) -> i1
      %288 = comb.xor %285, %287 : i1
      llhd.drv %283, %288 after %0 : i1
      %289 = llhd.sig.extract %data_o from %c-24_i6 : <i57> -> <i1>
      %290 = llhd.prb %syndrome_o : i7
      %291 = comb.icmp eq %290, %c-25_i7 : i7
      %292 = llhd.prb %data_i_0 : i64
      %293 = comb.extract %292 from 40 : (i64) -> i1
      %294 = comb.xor %291, %293 : i1
      llhd.drv %289, %294 after %0 : i1
      %295 = llhd.sig.extract %data_o from %c-23_i6 : <i57> -> <i1>
      %296 = llhd.prb %syndrome_o : i7
      %297 = comb.icmp eq %296, %c59_i7 : i7
      %298 = llhd.prb %data_i_0 : i64
      %299 = comb.extract %298 from 41 : (i64) -> i1
      %300 = comb.xor %297, %299 : i1
      llhd.drv %295, %300 after %0 : i1
      %301 = llhd.sig.extract %data_o from %c-22_i6 : <i57> -> <i1>
      %302 = llhd.prb %syndrome_o : i7
      %303 = comb.icmp eq %302, %c-37_i7 : i7
      %304 = llhd.prb %data_i_0 : i64
      %305 = comb.extract %304 from 42 : (i64) -> i1
      %306 = comb.xor %303, %305 : i1
      llhd.drv %301, %306 after %0 : i1
      %307 = llhd.sig.extract %data_o from %c-21_i6 : <i57> -> <i1>
      %308 = llhd.prb %syndrome_o : i7
      %309 = comb.icmp eq %308, %c-21_i7 : i7
      %310 = llhd.prb %data_i_0 : i64
      %311 = comb.extract %310 from 43 : (i64) -> i1
      %312 = comb.xor %309, %311 : i1
      llhd.drv %307, %312 after %0 : i1
      %313 = llhd.sig.extract %data_o from %c-20_i6 : <i57> -> <i1>
      %314 = llhd.prb %syndrome_o : i7
      %315 = comb.icmp eq %314, %c-13_i7 : i7
      %316 = llhd.prb %data_i_0 : i64
      %317 = comb.extract %316 from 44 : (i64) -> i1
      %318 = comb.xor %315, %317 : i1
      llhd.drv %313, %318 after %0 : i1
      %319 = llhd.sig.extract %data_o from %c-19_i6 : <i57> -> <i1>
      %320 = llhd.prb %syndrome_o : i7
      %321 = comb.icmp eq %320, %c61_i7 : i7
      %322 = llhd.prb %data_i_0 : i64
      %323 = comb.extract %322 from 45 : (i64) -> i1
      %324 = comb.xor %321, %323 : i1
      llhd.drv %319, %324 after %0 : i1
      %325 = llhd.sig.extract %data_o from %c-18_i6 : <i57> -> <i1>
      %326 = llhd.prb %syndrome_o : i7
      %327 = comb.icmp eq %326, %c-35_i7 : i7
      %328 = llhd.prb %data_i_0 : i64
      %329 = comb.extract %328 from 46 : (i64) -> i1
      %330 = comb.xor %327, %329 : i1
      llhd.drv %325, %330 after %0 : i1
      %331 = llhd.sig.extract %data_o from %c-17_i6 : <i57> -> <i1>
      %332 = llhd.prb %syndrome_o : i7
      %333 = comb.icmp eq %332, %c-19_i7 : i7
      %334 = llhd.prb %data_i_0 : i64
      %335 = comb.extract %334 from 47 : (i64) -> i1
      %336 = comb.xor %333, %335 : i1
      llhd.drv %331, %336 after %0 : i1
      %337 = llhd.sig.extract %data_o from %c-16_i6 : <i57> -> <i1>
      %338 = llhd.prb %syndrome_o : i7
      %339 = comb.icmp eq %338, %c-11_i7 : i7
      %340 = llhd.prb %data_i_0 : i64
      %341 = comb.extract %340 from 48 : (i64) -> i1
      %342 = comb.xor %339, %341 : i1
      llhd.drv %337, %342 after %0 : i1
      %343 = llhd.sig.extract %data_o from %c-15_i6 : <i57> -> <i1>
      %344 = llhd.prb %syndrome_o : i7
      %345 = comb.icmp eq %344, %c-7_i7 : i7
      %346 = llhd.prb %data_i_0 : i64
      %347 = comb.extract %346 from 49 : (i64) -> i1
      %348 = comb.xor %345, %347 : i1
      llhd.drv %343, %348 after %0 : i1
      %349 = llhd.sig.extract %data_o from %c-14_i6 : <i57> -> <i1>
      %350 = llhd.prb %syndrome_o : i7
      %351 = comb.icmp eq %350, %c62_i7 : i7
      %352 = llhd.prb %data_i_0 : i64
      %353 = comb.extract %352 from 50 : (i64) -> i1
      %354 = comb.xor %351, %353 : i1
      llhd.drv %349, %354 after %0 : i1
      %355 = llhd.sig.extract %data_o from %c-13_i6 : <i57> -> <i1>
      %356 = llhd.prb %syndrome_o : i7
      %357 = comb.icmp eq %356, %c-34_i7 : i7
      %358 = llhd.prb %data_i_0 : i64
      %359 = comb.extract %358 from 51 : (i64) -> i1
      %360 = comb.xor %357, %359 : i1
      llhd.drv %355, %360 after %0 : i1
      %361 = llhd.sig.extract %data_o from %c-12_i6 : <i57> -> <i1>
      %362 = llhd.prb %syndrome_o : i7
      %363 = comb.icmp eq %362, %c-18_i7 : i7
      %364 = llhd.prb %data_i_0 : i64
      %365 = comb.extract %364 from 52 : (i64) -> i1
      %366 = comb.xor %363, %365 : i1
      llhd.drv %361, %366 after %0 : i1
      %367 = llhd.sig.extract %data_o from %c-11_i6 : <i57> -> <i1>
      %368 = llhd.prb %syndrome_o : i7
      %369 = comb.icmp eq %368, %c-10_i7 : i7
      %370 = llhd.prb %data_i_0 : i64
      %371 = comb.extract %370 from 53 : (i64) -> i1
      %372 = comb.xor %369, %371 : i1
      llhd.drv %367, %372 after %0 : i1
      %373 = llhd.sig.extract %data_o from %c-10_i6 : <i57> -> <i1>
      %374 = llhd.prb %syndrome_o : i7
      %375 = comb.icmp eq %374, %c-6_i7 : i7
      %376 = llhd.prb %data_i_0 : i64
      %377 = comb.extract %376 from 54 : (i64) -> i1
      %378 = comb.xor %375, %377 : i1
      llhd.drv %373, %378 after %0 : i1
      %379 = llhd.sig.extract %data_o from %c-9_i6 : <i57> -> <i1>
      %380 = llhd.prb %syndrome_o : i7
      %381 = comb.icmp eq %380, %c-4_i7 : i7
      %382 = llhd.prb %data_i_0 : i64
      %383 = comb.extract %382 from 55 : (i64) -> i1
      %384 = comb.xor %381, %383 : i1
      llhd.drv %379, %384 after %0 : i1
      %385 = llhd.sig.extract %data_o from %c-8_i6 : <i57> -> <i1>
      %386 = llhd.prb %syndrome_o : i7
      %387 = comb.icmp eq %386, %c-1_i7 : i7
      %388 = llhd.prb %data_i_0 : i64
      %389 = comb.extract %388 from 56 : (i64) -> i1
      %390 = comb.xor %387, %389 : i1
      llhd.drv %385, %390 after %0 : i1
      %391 = llhd.sig.extract %err_o from %false : <i2> -> <i1>
      %392 = llhd.prb %syndrome_o : i7
      %393 = comb.parity %392 : i7
      llhd.drv %391, %393 after %0 : i1
      %394 = llhd.sig.extract %err_o from %true : <i2> -> <i1>
      %395 = llhd.prb %err_o : i2
      %396 = comb.extract %395 from 0 : (i2) -> i1
      %397 = comb.xor %396, %true : i1
      %398 = llhd.prb %syndrome_o : i7
      %399 = comb.icmp ne %398, %c0_i7 : i7
      %400 = comb.and %397, %399 : i1
      llhd.drv %394, %400 after %0 : i1
      llhd.wait (%1, %2, %3, %4 : i7, i64, i57, i2), ^bb1
    }
    llhd.drv %data_i_0, %data_i after %0 : i64
    hw.output %3, %1, %4 : i57, i7, i2
  }
  hw.module private @prim_secded_inv_64_57_enc(in %data_i : i57, out data_o : i64) {
    %c0_i4 = hw.constant 0 : i4
    %c-72728986368367_i53 = hw.constant -72728986368367 : i53
    %c0_i3 = hw.constant 0 : i3
    %c-290911646233967_i54 = hw.constant -290911646233967 : i54
    %c0_i2 = hw.constant 0 : i2
    %c-1163612191044463_i55 = hw.constant -1163612191044463 : i55
    %false = hw.constant false
    %c-4654104825805039_i56 = hw.constant -4654104825805039 : i56
    %c-18610366057053727_i57 = hw.constant -18610366057053727 : i57
    %c-37119546879934433_i57 = hw.constant -37119546879934433 : i57
    %c-70931728490790913_i57 = hw.constant -70931728490790913 : i57
    %c-1_i6 = hw.constant -1 : i6
    %c-2_i6 = hw.constant -2 : i6
    %c-3_i6 = hw.constant -3 : i6
    %c-4_i6 = hw.constant -4 : i6
    %c-5_i6 = hw.constant -5 : i6
    %c-6_i6 = hw.constant -6 : i6
    %c-7_i6 = hw.constant -7 : i6
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i7 = hw.constant 0 : i7
    %c0_i64 = hw.constant 0 : i64
    %c6052837899185946624_i64 = hw.constant 6052837899185946624 : i64
    %c0_i57 = hw.constant 0 : i57
    %data_i_0 = llhd.sig name "data_i" %c0_i57 : i57
    %data_o = llhd.sig %c0_i64 : i64
    %1 = llhd.prb %data_i_0 : i57
    %2 = llhd.prb %data_o : i64
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %3 = llhd.prb %data_i_0 : i57
      %4 = comb.concat %c0_i7, %3 : i7, i57
      llhd.drv %data_o, %4 after %0 : i64
      %5 = llhd.sig.extract %data_o from %c-7_i6 : <i64> -> <i1>
      %6 = llhd.prb %data_o : i64
      %7 = comb.extract %6 from 0 : (i64) -> i57
      %8 = comb.and %7, %c-70931728490790913_i57 : i57
      %9 = comb.parity %8 : i57
      llhd.drv %5, %9 after %0 : i1
      %10 = llhd.sig.extract %data_o from %c-6_i6 : <i64> -> <i1>
      %11 = llhd.prb %data_o : i64
      %12 = comb.extract %11 from 0 : (i64) -> i57
      %13 = comb.and %12, %c-37119546879934433_i57 : i57
      %14 = comb.parity %13 : i57
      llhd.drv %10, %14 after %0 : i1
      %15 = llhd.sig.extract %data_o from %c-5_i6 : <i64> -> <i1>
      %16 = llhd.prb %data_o : i64
      %17 = comb.extract %16 from 0 : (i64) -> i57
      %18 = comb.and %17, %c-18610366057053727_i57 : i57
      %19 = comb.parity %18 : i57
      llhd.drv %15, %19 after %0 : i1
      %20 = llhd.sig.extract %data_o from %c-4_i6 : <i64> -> <i1>
      %21 = llhd.prb %data_o : i64
      %22 = comb.extract %21 from 1 : (i64) -> i56
      %23 = comb.and %22, %c-4654104825805039_i56 : i56
      %24 = comb.concat %c0_i7, %23, %false : i7, i56, i1
      %25 = comb.parity %24 : i64
      llhd.drv %20, %25 after %0 : i1
      %26 = llhd.sig.extract %data_o from %c-3_i6 : <i64> -> <i1>
      %27 = llhd.prb %data_o : i64
      %28 = comb.extract %27 from 2 : (i64) -> i55
      %29 = comb.and %28, %c-1163612191044463_i55 : i55
      %30 = comb.concat %c0_i7, %29, %c0_i2 : i7, i55, i2
      %31 = comb.parity %30 : i64
      llhd.drv %26, %31 after %0 : i1
      %32 = llhd.sig.extract %data_o from %c-2_i6 : <i64> -> <i1>
      %33 = llhd.prb %data_o : i64
      %34 = comb.extract %33 from 3 : (i64) -> i54
      %35 = comb.and %34, %c-290911646233967_i54 : i54
      %36 = comb.concat %c0_i7, %35, %c0_i3 : i7, i54, i3
      %37 = comb.parity %36 : i64
      llhd.drv %32, %37 after %0 : i1
      %38 = llhd.sig.extract %data_o from %c-1_i6 : <i64> -> <i1>
      %39 = llhd.prb %data_o : i64
      %40 = comb.extract %39 from 4 : (i64) -> i53
      %41 = comb.and %40, %c-72728986368367_i53 : i53
      %42 = comb.concat %c0_i7, %41, %c0_i4 : i7, i53, i4
      %43 = comb.parity %42 : i64
      llhd.drv %38, %43 after %0 : i1
      %44 = llhd.prb %data_o : i64
      %45 = comb.xor %44, %c6052837899185946624_i64 : i64
      llhd.drv %data_o, %45 after %0 : i64
      llhd.wait (%1, %2 : i57, i64), ^bb1
    }
    llhd.drv %data_i_0, %data_i after %0 : i57
    hw.output %2 : i64
  }
  hw.module private @prim_sparse_fsm_flop(in %clk_i : i1, in %rst_ni : i1, in %state_i : i9, out state_o : i9) {
    %u_state_flop.q_o = hw.instance "u_state_flop" @prim_flop_20(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %state_i: i9) -> (q_o: i9) {sv.namehint = "state_raw"}
    hw.output %u_state_flop.q_o : i9
  }
  hw.module private @prim_subreg_arb(in %we : i1, in %wd : i1, in %de : i1, in %d : i1, in %q : i1, out wr_en : i1, out wr_data : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %true = hw.constant true
    %false = hw.constant false
    %wd_0 = llhd.sig name "wd" %false : i1
    %d_1 = llhd.sig name "d" %false : i1
    %q_2 = llhd.sig name "q" %false : i1
    %1 = comb.or %we, %de : i1
    %2 = llhd.prb %d_1 : i1
    %3 = llhd.prb %q_2 : i1
    %4 = comb.mux %de, %2, %3 : i1
    %5 = llhd.prb %wd_0 : i1
    %6 = comb.xor %we, %true : i1
    %7 = comb.or %6, %5 : i1
    %8 = comb.and %4, %7 : i1
    llhd.drv %wd_0, %wd after %0 : i1
    llhd.drv %d_1, %d after %0 : i1
    llhd.drv %q_2, %q after %0 : i1
    hw.output %1, %8 : i1, i1
  }
  hw.module private @prim_subreg_arb_14(in %we : i1, in %wd : i32, in %de : i1, in %d : i32, in %q : i32, out wr_en : i1, out wr_data : i32) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %wd_0 = llhd.sig name "wd" %c0_i32 : i32
    %d_1 = llhd.sig name "d" %c0_i32 : i32
    %1 = comb.or %we, %de : i1
    %2 = llhd.prb %wd_0 : i32
    %3 = llhd.prb %d_1 : i32
    %4 = comb.mux %we, %2, %3 : i32
    llhd.drv %wd_0, %wd after %0 : i32
    llhd.drv %d_1, %d after %0 : i32
    hw.output %1, %4 : i1, i32
  }
  hw.module private @prim_subreg_ext(in %re : i1, in %we : i1, in %wd : i1, in %d : i1, out qe : i1, out qre : i1, out q : i1, out ds : i1, out qs : i1) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i1, i1, i1
  }
  hw.module private @prim_subreg(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i1, in %de : i1, in %d : i1, out qe : i1, out q : i1, out ds : i1, out qs : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %q = llhd.sig %false : i1
    %qs = llhd.sig %false : i1
    %wr_en = llhd.sig %false : i1
    %wr_data = llhd.sig %false : i1
    %4 = llhd.prb %q : i1
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb(we: %we: i1, wd: %wd: i1, de: %de: i1, d: %d: i1, q: %4: i1) -> (wr_en: i1, wr_data: i1)
    llhd.drv %wr_en, %wr_en_data_arb.wr_en after %1 : i1
    llhd.drv %wr_data, %wr_en_data_arb.wr_data after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %9 = llhd.prb %clk_i_0 : i1
      %10 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %11 = llhd.prb %clk_i_0 : i1
      %12 = comb.xor bin %9, %true : i1
      %13 = comb.and bin %12, %11 : i1
      %14 = llhd.prb %rst_ni_1 : i1
      %15 = comb.xor bin %14, %true : i1
      %16 = comb.and bin %10, %15 : i1
      %17 = comb.or bin %13, %16 : i1
      cf.cond_br %17, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %18 = llhd.prb %rst_ni_1 : i1
      %19 = comb.xor %18, %true : i1
      cf.cond_br %19, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %q, %true after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %20 = llhd.prb %wr_en : i1
      cf.cond_br %20, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %21 = llhd.prb %wr_data : i1
      llhd.drv %q, %21 after %0 : i1
      cf.br ^bb1
    }
    %5 = llhd.prb %wr_en : i1
    %6 = llhd.prb %wr_data : i1
    %7 = llhd.prb %qs : i1
    %8 = comb.mux %5, %6, %7 : i1
    llhd.drv %qs, %4 after %1 : i1
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    hw.output %we, %4, %8, %7 : i1, i1, i1, i1
  }
  hw.module private @prim_subreg_4(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c1768515945_i32 = hw.constant 1768515945 : i32
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %q = llhd.sig %c0_i32 : i32
    %qs = llhd.sig %c0_i32 : i32
    %wr_en = llhd.sig %false : i1
    %wr_data = llhd.sig %c0_i32 : i32
    %4 = llhd.prb %q : i32
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_14(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
    llhd.drv %wr_en, %wr_en_data_arb.wr_en after %1 : i1
    llhd.drv %wr_data, %wr_en_data_arb.wr_data after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %9 = llhd.prb %clk_i_0 : i1
      %10 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %11 = llhd.prb %clk_i_0 : i1
      %12 = comb.xor bin %9, %true : i1
      %13 = comb.and bin %12, %11 : i1
      %14 = llhd.prb %rst_ni_1 : i1
      %15 = comb.xor bin %14, %true : i1
      %16 = comb.and bin %10, %15 : i1
      %17 = comb.or bin %13, %16 : i1
      cf.cond_br %17, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %18 = llhd.prb %rst_ni_1 : i1
      %19 = comb.xor %18, %true : i1
      cf.cond_br %19, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %q, %c1768515945_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %20 = llhd.prb %wr_en : i1
      cf.cond_br %20, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %21 = llhd.prb %wr_data : i32
      llhd.drv %q, %21 after %0 : i32
      cf.br ^bb1
    }
    %5 = llhd.prb %wr_en : i1
    %6 = llhd.prb %wr_data : i32
    %7 = llhd.prb %qs : i32
    %8 = comb.mux %5, %6, %7 : i32
    llhd.drv %qs, %4 after %1 : i32
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    hw.output %we, %4, %8, %7 : i1, i32, i32, i32
  }
  hw.module private @prim_sync_reqack(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, in %req_chk_i : i1, in %src_req_i : i1, out src_ack_o : i1, out dst_req_o : i1, in %dst_ack_i : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %true = hw.constant true
    %false = hw.constant false
    %clk_src_i_0 = llhd.sig name "clk_src_i" %false : i1
    %2 = llhd.prb %clk_src_i_0 : i1
    %rst_src_ni_1 = llhd.sig name "rst_src_ni" %false : i1
    %3 = llhd.prb %rst_src_ni_1 : i1
    %clk_dst_i_2 = llhd.sig name "clk_dst_i" %false : i1
    %4 = llhd.prb %clk_dst_i_2 : i1
    %rst_dst_ni_3 = llhd.sig name "rst_dst_ni" %false : i1
    %5 = llhd.prb %rst_dst_ni_3 : i1
    %src_req_i_4 = llhd.sig name "src_req_i" %false : i1
    %src_ack_o = llhd.sig %false : i1
    %dst_req_o = llhd.sig %false : i1
    %dst_ack_i_5 = llhd.sig name "dst_ack_i" %false : i1
    %gen_rz_hs_protocol.src_fsm_d = llhd.sig %false : i1
    %gen_rz_hs_protocol.src_fsm_q = llhd.sig %false : i1
    %gen_rz_hs_protocol.dst_fsm_d = llhd.sig %false : i1
    %gen_rz_hs_protocol.dst_fsm_q = llhd.sig %false : i1
    %gen_rz_hs_protocol.src_ack = llhd.sig %false : i1
    %gen_rz_hs_protocol.dst_ack = llhd.sig %false : i1
    %gen_rz_hs_protocol.src_req = llhd.sig %false : i1
    %gen_rz_hs_protocol.dst_req = llhd.sig %false : i1
    %6 = llhd.prb %gen_rz_hs_protocol.dst_ack : i1
    %gen_rz_hs_protocol.ack_sync.q_o = hw.instance "gen_rz_hs_protocol.ack_sync" @prim_flop_2sync_1(clk_i: %2: i1, rst_ni: %3: i1, d_i: %6: i1) -> (q_o: i1)
    llhd.drv %gen_rz_hs_protocol.src_ack, %gen_rz_hs_protocol.ack_sync.q_o after %1 : i1
    %7 = llhd.prb %gen_rz_hs_protocol.src_req : i1
    %gen_rz_hs_protocol.req_sync.q_o = hw.instance "gen_rz_hs_protocol.req_sync" @prim_flop_2sync_1(clk_i: %4: i1, rst_ni: %5: i1, d_i: %7: i1) -> (q_o: i1)
    llhd.drv %gen_rz_hs_protocol.dst_req, %gen_rz_hs_protocol.req_sync.q_o after %1 : i1
    %8 = llhd.prb %gen_rz_hs_protocol.src_fsm_q : i1
    %9 = llhd.prb %gen_rz_hs_protocol.src_fsm_d : i1
    %10 = llhd.prb %src_ack_o : i1
    %11 = llhd.prb %gen_rz_hs_protocol.src_ack : i1
    %12 = llhd.prb %src_req_i_4 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      %18 = llhd.prb %gen_rz_hs_protocol.src_fsm_q : i1
      llhd.drv %gen_rz_hs_protocol.src_fsm_d, %18 after %1 : i1
      llhd.drv %src_ack_o, %false after %1 : i1
      llhd.drv %gen_rz_hs_protocol.src_req, %false after %1 : i1
      %19 = llhd.prb %gen_rz_hs_protocol.src_fsm_q : i1
      %20 = comb.icmp ceq %19, %false : i1
      cf.cond_br %20, ^bb2, ^bb4
    ^bb2:  // pred: ^bb1
      %21 = llhd.prb %gen_rz_hs_protocol.src_ack : i1
      %22 = comb.xor %21, %true : i1
      %23 = llhd.prb %src_req_i_4 : i1
      %24 = comb.and %22, %23 : i1
      cf.cond_br %24, ^bb3, ^bb6
    ^bb3:  // pred: ^bb2
      llhd.drv %gen_rz_hs_protocol.src_fsm_d, %true after %1 : i1
      cf.br ^bb6
    ^bb4:  // pred: ^bb1
      llhd.drv %gen_rz_hs_protocol.src_req, %true after %1 : i1
      %25 = llhd.prb %gen_rz_hs_protocol.src_ack : i1
      llhd.drv %src_ack_o, %25 after %1 : i1
      %26 = llhd.prb %src_req_i_4 : i1
      %27 = comb.xor %26, %true : i1
      %28 = llhd.prb %gen_rz_hs_protocol.src_ack : i1
      %29 = comb.or %27, %28 : i1
      cf.cond_br %29, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      llhd.drv %gen_rz_hs_protocol.src_fsm_d, %false after %1 : i1
      cf.br ^bb6
    ^bb6:  // 4 preds: ^bb2, ^bb3, ^bb4, ^bb5
      llhd.wait (%8, %9, %10, %7, %11, %12 : i1, i1, i1, i1, i1, i1), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %18 = llhd.prb %clk_src_i_0 : i1
      %19 = llhd.prb %rst_src_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %20 = llhd.prb %clk_src_i_0 : i1
      %21 = comb.xor bin %18, %true : i1
      %22 = comb.and bin %21, %20 : i1
      %23 = llhd.prb %rst_src_ni_1 : i1
      %24 = comb.xor bin %23, %true : i1
      %25 = comb.and bin %19, %24 : i1
      %26 = comb.or bin %22, %25 : i1
      cf.cond_br %26, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %27 = llhd.prb %rst_src_ni_1 : i1
      %28 = comb.xor %27, %true : i1
      cf.cond_br %28, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_rz_hs_protocol.src_fsm_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %29 = llhd.prb %gen_rz_hs_protocol.src_fsm_d : i1
      llhd.drv %gen_rz_hs_protocol.src_fsm_q, %29 after %0 : i1
      cf.br ^bb1
    }
    %13 = llhd.prb %gen_rz_hs_protocol.dst_fsm_q : i1
    %14 = llhd.prb %gen_rz_hs_protocol.dst_fsm_d : i1
    %15 = llhd.prb %dst_req_o : i1
    %16 = llhd.prb %gen_rz_hs_protocol.dst_req : i1
    %17 = llhd.prb %dst_ack_i_5 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb7
      %18 = llhd.prb %gen_rz_hs_protocol.dst_fsm_q : i1
      llhd.drv %gen_rz_hs_protocol.dst_fsm_d, %18 after %1 : i1
      llhd.drv %dst_req_o, %false after %1 : i1
      llhd.drv %gen_rz_hs_protocol.dst_ack, %false after %1 : i1
      %19 = llhd.prb %gen_rz_hs_protocol.dst_fsm_q : i1
      %20 = comb.icmp ceq %19, %false : i1
      cf.cond_br %20, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      %21 = llhd.prb %gen_rz_hs_protocol.dst_req : i1
      cf.cond_br %21, ^bb3, ^bb7
    ^bb3:  // pred: ^bb2
      llhd.drv %dst_req_o, %true after %1 : i1
      %22 = llhd.prb %dst_ack_i_5 : i1
      cf.cond_br %22, ^bb4, ^bb7
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_rz_hs_protocol.dst_fsm_d, %true after %1 : i1
      cf.br ^bb7
    ^bb5:  // pred: ^bb1
      llhd.drv %gen_rz_hs_protocol.dst_ack, %true after %1 : i1
      %23 = llhd.prb %gen_rz_hs_protocol.dst_req : i1
      %24 = comb.xor %23, %true : i1
      cf.cond_br %24, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %gen_rz_hs_protocol.dst_fsm_d, %false after %1 : i1
      cf.br ^bb7
    ^bb7:  // 5 preds: ^bb2, ^bb3, ^bb4, ^bb5, ^bb6
      llhd.wait (%13, %14, %15, %6, %16, %17 : i1, i1, i1, i1, i1, i1), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %18 = llhd.prb %clk_dst_i_2 : i1
      %19 = llhd.prb %rst_dst_ni_3 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %20 = llhd.prb %clk_dst_i_2 : i1
      %21 = comb.xor bin %18, %true : i1
      %22 = comb.and bin %21, %20 : i1
      %23 = llhd.prb %rst_dst_ni_3 : i1
      %24 = comb.xor bin %23, %true : i1
      %25 = comb.and bin %19, %24 : i1
      %26 = comb.or bin %22, %25 : i1
      cf.cond_br %26, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %27 = llhd.prb %rst_dst_ni_3 : i1
      %28 = comb.xor %27, %true : i1
      cf.cond_br %28, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_rz_hs_protocol.dst_fsm_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %29 = llhd.prb %gen_rz_hs_protocol.dst_fsm_d : i1
      llhd.drv %gen_rz_hs_protocol.dst_fsm_q, %29 after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_src_i_0, %clk_src_i after %1 : i1
    llhd.drv %rst_src_ni_1, %rst_src_ni after %1 : i1
    llhd.drv %clk_dst_i_2, %clk_dst_i after %1 : i1
    llhd.drv %rst_dst_ni_3, %rst_dst_ni after %1 : i1
    llhd.drv %src_req_i_4, %src_req_i after %1 : i1
    llhd.drv %dst_ack_i_5, %dst_ack_i after %1 : i1
    hw.output %10, %15 : i1, i1
  }
  hw.module private @tlul_adapter_host(in %clk_i : i1, in %rst_ni : i1, in %req_i : i1, out gnt_o : i1, in %addr_i : i32, in %we_i : i1, in %wdata_i : i32, in %wdata_intg_i : i7, in %be_i : i4, in %instr_type_i : i4, in %user_rsvd_i : i5, out valid_o : i1, out rdata_o : i32, out rdata_intg_o : i7, out err_o : i1, out intg_err_o : i1, out tl_o : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, in %tl_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) {
    %c0_i2 = hw.constant 0 : i2
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i4 = hw.constant -1 : i4
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %false = hw.constant false
    %true = hw.constant true
    %c0_i7 = hw.constant 0 : i7
    %c-2_i2 = hw.constant -2 : i2
    %c0_i3 = hw.constant 0 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c0_i8 = hw.constant 0 : i8 {sv.namehint = "tl_source"}
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %be_i_2 = llhd.sig name "be_i" %c0_i4 : i4
    %intg_err = llhd.sig %false : i1
    %intg_err_q = llhd.sig %false : i1
    %u_cmd_intg_gen.tl_o = hw.instance "u_cmd_intg_gen" @tlul_cmd_intg_gen(tl_i: %13: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> (tl_o: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>)
    %u_rsp_chk.err_o = hw.instance "u_rsp_chk" @tlul_rsp_intg_chk(tl_i: %tl_i: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (err_o: i1)
    llhd.drv %intg_err, %u_rsp_chk.err_o after %1 : i1
    %4 = comb.xor %we_i, %true : i1
    %5 = llhd.prb %be_i_2 : i4
    %6 = comb.mux %4, %c-1_i4, %5 {sv.namehint = "tl_be"} : i4
    %7 = comb.icmp ne %5, %c-1_i4 : i4
    %8 = comb.concat %c0_i2, %7 : i2, i1
    %9 = comb.mux %4, %c-4_i3, %8 : i3
    %10 = comb.extract %addr_i from 2 : (i32) -> i30
    %11 = comb.concat %10, %c0_i2 : i30, i2
    %12 = hw.struct_create (%user_rsvd_i, %instr_type_i, %c0_i7, %wdata_intg_i) : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %13 = hw.struct_create (%req_i, %9, %c0_i3, %c-2_i2, %c0_i8, %11, %6, %wdata_i, %12, %true) {sv.namehint = "tl_out"} : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_ready = hw.struct_extract %tl_i["a_ready"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %d_valid = hw.struct_extract %tl_i["d_valid"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %d_data = hw.struct_extract %tl_i["d_data"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %d_user = hw.struct_extract %tl_i["d_user"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %data_intg = hw.struct_extract %d_user["data_intg"] : !hw.struct<rsp_intg: i7, data_intg: i7>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %18 = llhd.prb %clk_i_0 : i1
      %19 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %20 = llhd.prb %clk_i_0 : i1
      %21 = comb.xor bin %18, %true : i1
      %22 = comb.and bin %21, %20 : i1
      %23 = llhd.prb %rst_ni_1 : i1
      %24 = comb.xor bin %23, %true : i1
      %25 = comb.and bin %19, %24 : i1
      %26 = comb.or bin %22, %25 : i1
      cf.cond_br %26, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %27 = llhd.prb %rst_ni_1 : i1
      %28 = comb.xor %27, %true : i1
      cf.cond_br %28, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %intg_err_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %29 = llhd.prb %intg_err : i1
      cf.cond_br %29, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %intg_err_q, %true after %0 : i1
      cf.br ^bb1
    }
    %d_error = hw.struct_extract %tl_i["d_error"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %14 = llhd.prb %intg_err : i1
    %15 = comb.or %d_error, %14 : i1
    %16 = llhd.prb %intg_err_q : i1
    %17 = comb.or %16, %14 : i1
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %be_i_2, %be_i after %1 : i4
    hw.output %a_ready, %d_valid, %d_data, %data_intg, %15, %17, %u_cmd_intg_gen.tl_o : i1, i1, i32, i7, i1, i1, !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
  }
  hw.module private @tlul_adapter_reg(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %en_ifetch_i : i4, out intg_error_o : i1, out re_o : i1, out we_o : i1, out addr_o : i12, out wdata_o : i32, out be_o : i4, in %busy_i : i1, in %rdata_i : i32, in %error_i : i1) {
    %0 = hw.aggregate_constant [0 : i7, 0 : i7] : !hw.struct<rsp_intg: i7, data_intg: i7>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %2 = llhd.constant_time <0ns, 0d, 1e>
    %3 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %c-1_i32 = hw.constant -1 : i32
    %c0_i32 = hw.constant 0 : i32
    %c0_i2 = hw.constant 0 : i2
    %c0_i8 = hw.constant 0 : i8
    %true = hw.constant true
    %false = hw.constant false
    %c-4_i3 = hw.constant -4 : i3
    %c1_i3 = hw.constant 1 : i3
    %c0_i3 = hw.constant 0 : i3
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %4 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %5 = llhd.prb %rst_ni_1 : i1
    %tl_i_2 = llhd.sig name "tl_i" %3 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %rdata_i_3 = llhd.sig name "rdata_i" %c0_i32 : i32
    %error_i_4 = llhd.sig name "error_i" %false : i1
    %outstanding_q = llhd.sig %false : i1
    %a_ack = llhd.sig %false : i1
    %d_ack = llhd.sig %false : i1
    %rdata = llhd.sig %c0_i32 : i32
    %rdata_q = llhd.sig %c0_i32 : i32
    %error_q = llhd.sig %false : i1
    %error = llhd.sig %false : i1
    %err_internal = llhd.sig %false : i1
    %intg_error = llhd.sig %false : i1
    %addr_align_err = llhd.sig %false : i1
    %reqid_q = llhd.sig %c0_i8 : i8
    %reqsz_q = llhd.sig %c0_i2 : i2
    %rspop_q = llhd.sig %c0_i3 : i3
    %rd_req = llhd.sig %false : i1
    %wr_req = llhd.sig %false : i1
    %gen_access_latency1.a_ack_q = llhd.sig %false : i1
    %gen_access_latency1.err_internal_q = llhd.sig %false : i1
    %gen_access_latency1.wr_req_q = llhd.sig %false : i1
    %gen_cmd_intg_check.intg_error_q = llhd.sig %false : i1
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen_11(tl_i: %39: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
    %6 = llhd.prb %tl_i_2 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %gen_cmd_intg_check.u_cmd_intg_chk.err_o = hw.instance "gen_cmd_intg_check.u_cmd_intg_chk" @tlul_cmd_intg_chk(tl_i: %6: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> (err_o: i1)
    llhd.drv %intg_error, %gen_cmd_intg_check.u_cmd_intg_chk.err_o after %2 : i1
    %u_err.err_o = hw.instance "u_err" @tlul_err(clk_i: %4: i1, rst_ni: %5: i1, tl_i: %6: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> (err_o: i1) {sv.namehint = "tl_err"}
    %a_valid = hw.struct_extract %6["a_valid"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_ready = hw.struct_extract %u_rsp_intg_gen.tl_o["a_ready"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %7 = comb.and %a_valid, %a_ready : i1
    llhd.drv %a_ack, %7 after %2 : i1
    %d_valid = hw.struct_extract %u_rsp_intg_gen.tl_o["d_valid"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %d_ready = hw.struct_extract %6["d_ready"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %8 = comb.and %d_valid, %d_ready : i1
    llhd.drv %d_ack, %8 after %2 : i1
    %9 = llhd.prb %a_ack : i1
    %a_opcode = hw.struct_extract %6["a_opcode"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %10 = comb.icmp eq %a_opcode, %c0_i3 : i3
    %11 = comb.icmp eq %a_opcode, %c1_i3 : i3
    %12 = comb.or %10, %11 : i1
    %13 = comb.and %9, %12 : i1
    llhd.drv %wr_req, %13 after %2 : i1
    %14 = comb.icmp eq %a_opcode, %c-4_i3 : i3
    %15 = comb.and %9, %14 : i1
    llhd.drv %rd_req, %15 after %2 : i1
    %16 = llhd.prb %wr_req : i1
    %17 = llhd.prb %err_internal : i1
    %18 = comb.xor %17, %true : i1
    %19 = comb.and %16, %18 : i1
    %20 = llhd.prb %rd_req : i1
    %21 = comb.and %20, %18 : i1
    %a_data = hw.struct_extract %6["a_data"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_mask = hw.struct_extract %6["a_mask"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_address = hw.struct_extract %6["a_address"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %22 = comb.extract %a_address from 2 : (i32) -> i10
    %23 = comb.concat %22, %c0_i2 : i10, i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %47 = llhd.prb %clk_i_0 : i1
      %48 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %49 = llhd.prb %clk_i_0 : i1
      %50 = comb.xor bin %47, %true : i1
      %51 = comb.and bin %50, %49 : i1
      %52 = llhd.prb %rst_ni_1 : i1
      %53 = comb.xor bin %52, %true : i1
      %54 = comb.and bin %48, %53 : i1
      %55 = comb.or bin %51, %54 : i1
      cf.cond_br %55, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %56 = llhd.prb %rst_ni_1 : i1
      %57 = comb.xor %56, %true : i1
      cf.cond_br %57, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %outstanding_q, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %58 = llhd.prb %a_ack : i1
      cf.cond_br %58, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %outstanding_q, %true after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %59 = llhd.prb %d_ack : i1
      cf.cond_br %59, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %outstanding_q, %false after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %47 = llhd.prb %clk_i_0 : i1
      %48 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %49 = llhd.prb %clk_i_0 : i1
      %50 = comb.xor bin %47, %true : i1
      %51 = comb.and bin %50, %49 : i1
      %52 = llhd.prb %rst_ni_1 : i1
      %53 = comb.xor bin %52, %true : i1
      %54 = comb.and bin %48, %53 : i1
      %55 = comb.or bin %51, %54 : i1
      cf.cond_br %55, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %56 = llhd.prb %rst_ni_1 : i1
      %57 = comb.xor %56, %true : i1
      cf.cond_br %57, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %reqid_q, %c0_i8 after %1 : i8
      llhd.drv %reqsz_q, %c0_i2 after %1 : i2
      llhd.drv %rspop_q, %c0_i3 after %1 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %58 = llhd.prb %a_ack : i1
      cf.cond_br %58, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %59 = llhd.prb %tl_i_2 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_source = hw.struct_extract %59["a_source"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      llhd.drv %reqid_q, %a_source after %1 : i8
      %60 = llhd.prb %tl_i_2 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_size = hw.struct_extract %60["a_size"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      llhd.drv %reqsz_q, %a_size after %1 : i2
      %61 = llhd.prb %rd_req : i1
      %62 = comb.concat %c0_i2, %61 : i2, i1
      llhd.drv %rspop_q, %62 after %1 : i3
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %47 = llhd.prb %clk_i_0 : i1
      %48 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %49 = llhd.prb %clk_i_0 : i1
      %50 = comb.xor bin %47, %true : i1
      %51 = comb.and bin %50, %49 : i1
      %52 = llhd.prb %rst_ni_1 : i1
      %53 = comb.xor bin %52, %true : i1
      %54 = comb.and bin %48, %53 : i1
      %55 = comb.or bin %51, %54 : i1
      cf.cond_br %55, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %56 = llhd.prb %rst_ni_1 : i1
      %57 = comb.xor %56, %true : i1
      cf.cond_br %57, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_access_latency1.a_ack_q, %false after %1 : i1
      llhd.drv %gen_access_latency1.err_internal_q, %false after %1 : i1
      llhd.drv %gen_access_latency1.wr_req_q, %false after %1 : i1
      llhd.drv %rdata_q, %c0_i32 after %1 : i32
      llhd.drv %error_q, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %58 = llhd.prb %a_ack : i1
      llhd.drv %gen_access_latency1.a_ack_q, %58 after %1 : i1
      %59 = llhd.prb %err_internal : i1
      llhd.drv %gen_access_latency1.err_internal_q, %59 after %1 : i1
      %60 = llhd.prb %wr_req : i1
      llhd.drv %gen_access_latency1.wr_req_q, %60 after %1 : i1
      %61 = llhd.prb %rdata : i32
      llhd.drv %rdata_q, %61 after %1 : i32
      %62 = llhd.prb %error : i1
      llhd.drv %error_q, %62 after %1 : i1
      cf.br ^bb1
    }
    %24 = llhd.prb %gen_access_latency1.a_ack_q : i1
    %25 = llhd.prb %error_i_4 : i1
    %26 = llhd.prb %gen_access_latency1.err_internal_q : i1
    %27 = llhd.prb %gen_access_latency1.wr_req_q : i1
    %28 = llhd.prb %rdata_i_3 : i32
    %29 = llhd.prb %rdata : i32
    %30 = llhd.prb %error : i1
    %31 = llhd.prb %rdata_q : i32
    %32 = llhd.prb %error_q : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb4
      %47 = llhd.prb %gen_access_latency1.a_ack_q : i1
      cf.cond_br %47, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %48 = llhd.prb %error_i_4 : i1
      %49 = llhd.prb %gen_access_latency1.err_internal_q : i1
      %50 = llhd.prb %gen_access_latency1.wr_req_q : i1
      %51 = comb.or %48, %49, %50 : i1
      %52 = llhd.prb %rdata_i_3 : i32
      %53 = comb.mux %51, %c-1_i32, %52 : i32
      llhd.drv %rdata, %53 after %2 : i32
      %54 = llhd.prb %error_i_4 : i1
      %55 = llhd.prb %gen_access_latency1.err_internal_q : i1
      %56 = comb.or %54, %55 : i1
      llhd.drv %error, %56 after %2 : i1
      cf.br ^bb4
    ^bb3:  // pred: ^bb1
      %57 = llhd.prb %rdata_q : i32
      llhd.drv %rdata, %57 after %2 : i32
      %58 = llhd.prb %error_q : i1
      llhd.drv %error, %58 after %2 : i1
      cf.br ^bb4
    ^bb4:  // 2 preds: ^bb2, ^bb3
      llhd.wait (%24, %25, %26, %27, %28, %29, %30, %31, %32 : i1, i1, i1, i1, i32, i32, i1, i32, i1), ^bb1
    }
    %33 = llhd.prb %outstanding_q : i1
    %34 = llhd.prb %rspop_q : i3
    %35 = llhd.prb %reqsz_q : i2
    %36 = llhd.prb %reqid_q : i8
    %37 = comb.or %33, %busy_i : i1
    %38 = comb.xor %37, %true : i1
    %39 = hw.struct_create (%33, %34, %c0_i3, %35, %36, %false, %29, %0, %30, %38) {sv.namehint = "tl_o_pre"} : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %47 = llhd.prb %clk_i_0 : i1
      %48 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %49 = llhd.prb %clk_i_0 : i1
      %50 = comb.xor bin %47, %true : i1
      %51 = comb.and bin %50, %49 : i1
      %52 = llhd.prb %rst_ni_1 : i1
      %53 = comb.xor bin %52, %true : i1
      %54 = comb.and bin %48, %53 : i1
      %55 = comb.or bin %51, %54 : i1
      cf.cond_br %55, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %56 = llhd.prb %rst_ni_1 : i1
      %57 = comb.xor %56, %true : i1
      cf.cond_br %57, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_cmd_intg_check.intg_error_q, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %58 = llhd.prb %intg_error : i1
      cf.cond_br %58, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %gen_cmd_intg_check.intg_error_q, %true after %1 : i1
      cf.br ^bb1
    }
    %40 = llhd.prb %gen_cmd_intg_check.intg_error_q : i1
    %a_user = hw.struct_extract %6["a_user"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %instr_type = hw.struct_extract %a_user["instr_type"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %41 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%instr_type) : (i4) -> i1
    %42 = func.call @"prim_mubi_pkg::mubi4_test_false_loose"(%en_ifetch_i) : (i4) -> i1
    %43 = comb.and %41, %42 {sv.namehint = "instr_error"} : i1
    %44 = llhd.prb %addr_align_err : i1
    %45 = llhd.prb %intg_error : i1
    %46 = comb.or %44, %u_err.err_o, %43, %45 : i1
    llhd.drv %err_internal, %46 after %2 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb4
      %47 = llhd.prb %wr_req : i1
      cf.cond_br %47, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %48 = llhd.prb %tl_i_2 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_address_5 = hw.struct_extract %48["a_address"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %49 = comb.extract %a_address_5 from 0 : (i32) -> i2
      %50 = comb.icmp ne %49, %c0_i2 : i2
      llhd.drv %addr_align_err, %50 after %2 : i1
      cf.br ^bb4
    ^bb3:  // pred: ^bb1
      llhd.drv %addr_align_err, %false after %2 : i1
      cf.br ^bb4
    ^bb4:  // 2 preds: ^bb2, ^bb3
      llhd.wait (%16, %6, %44 : i1, !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, i1), ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %2 : i1
    llhd.drv %rst_ni_1, %rst_ni after %2 : i1
    llhd.drv %tl_i_2, %tl_i after %2 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    llhd.drv %rdata_i_3, %rdata_i after %2 : i32
    llhd.drv %error_i_4, %error_i after %2 : i1
    hw.output %u_rsp_intg_gen.tl_o, %40, %21, %19, %23, %a_data, %a_mask : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, i1, i1, i1, i12, i32, i4
  }
  hw.module private @tlul_adapter_reg_3(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %en_ifetch_i : i4, out intg_error_o : i1, out re_o : i1, out we_o : i1, out addr_o : i4, out wdata_o : i32, out be_o : i4, in %busy_i : i1, in %rdata_i : i32, in %error_i : i1) {
    %0 = hw.aggregate_constant [0 : i7, 0 : i7] : !hw.struct<rsp_intg: i7, data_intg: i7>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %2 = llhd.constant_time <0ns, 0d, 1e>
    %3 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %c-1_i32 = hw.constant -1 : i32
    %c0_i32 = hw.constant 0 : i32
    %c0_i2 = hw.constant 0 : i2
    %c0_i8 = hw.constant 0 : i8
    %true = hw.constant true
    %false = hw.constant false {sv.namehint = "intg_error"}
    %c-4_i3 = hw.constant -4 : i3
    %c1_i3 = hw.constant 1 : i3
    %c0_i3 = hw.constant 0 : i3
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %4 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %5 = llhd.prb %rst_ni_1 : i1
    %tl_i_2 = llhd.sig name "tl_i" %3 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %rdata_i_3 = llhd.sig name "rdata_i" %c0_i32 : i32
    %error_i_4 = llhd.sig name "error_i" %false : i1
    %outstanding_q = llhd.sig %false : i1
    %a_ack = llhd.sig %false : i1
    %d_ack = llhd.sig %false : i1
    %rdata_q = llhd.sig %c0_i32 : i32
    %error_q = llhd.sig %false : i1
    %err_internal = llhd.sig %false : i1
    %addr_align_err = llhd.sig %false : i1
    %reqid_q = llhd.sig %c0_i8 : i8
    %reqsz_q = llhd.sig %c0_i2 : i2
    %rspop_q = llhd.sig %c0_i3 : i3
    %rd_req = llhd.sig %false : i1
    %wr_req = llhd.sig %false : i1
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen_13(tl_i: %32: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
    %6 = llhd.prb %tl_i_2 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %u_err.err_o = hw.instance "u_err" @tlul_err(clk_i: %4: i1, rst_ni: %5: i1, tl_i: %6: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> (err_o: i1) {sv.namehint = "tl_err"}
    %a_valid = hw.struct_extract %6["a_valid"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_ready = hw.struct_extract %u_rsp_intg_gen.tl_o["a_ready"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %7 = comb.and %a_valid, %a_ready : i1
    llhd.drv %a_ack, %7 after %2 : i1
    %d_valid = hw.struct_extract %u_rsp_intg_gen.tl_o["d_valid"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %d_ready = hw.struct_extract %6["d_ready"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %8 = comb.and %d_valid, %d_ready : i1
    llhd.drv %d_ack, %8 after %2 : i1
    %9 = llhd.prb %a_ack : i1
    %a_opcode = hw.struct_extract %6["a_opcode"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %10 = comb.icmp eq %a_opcode, %c0_i3 : i3
    %11 = comb.icmp eq %a_opcode, %c1_i3 : i3
    %12 = comb.or %10, %11 : i1
    %13 = comb.and %9, %12 : i1
    llhd.drv %wr_req, %13 after %2 : i1
    %14 = comb.icmp eq %a_opcode, %c-4_i3 : i3
    %15 = comb.and %9, %14 : i1
    llhd.drv %rd_req, %15 after %2 : i1
    %16 = llhd.prb %wr_req : i1
    %17 = llhd.prb %err_internal : i1
    %18 = comb.xor %17, %true : i1
    %19 = comb.and %16, %18 : i1
    %20 = llhd.prb %rd_req : i1
    %21 = comb.and %20, %18 : i1
    %a_data = hw.struct_extract %6["a_data"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_mask = hw.struct_extract %6["a_mask"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_address = hw.struct_extract %6["a_address"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %22 = comb.extract %a_address from 2 : (i32) -> i2
    %23 = comb.concat %22, %c0_i2 : i2, i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %38 = llhd.prb %clk_i_0 : i1
      %39 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %40 = llhd.prb %clk_i_0 : i1
      %41 = comb.xor bin %38, %true : i1
      %42 = comb.and bin %41, %40 : i1
      %43 = llhd.prb %rst_ni_1 : i1
      %44 = comb.xor bin %43, %true : i1
      %45 = comb.and bin %39, %44 : i1
      %46 = comb.or bin %42, %45 : i1
      cf.cond_br %46, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %47 = llhd.prb %rst_ni_1 : i1
      %48 = comb.xor %47, %true : i1
      cf.cond_br %48, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %outstanding_q, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %49 = llhd.prb %a_ack : i1
      cf.cond_br %49, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %outstanding_q, %true after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %50 = llhd.prb %d_ack : i1
      cf.cond_br %50, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %outstanding_q, %false after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %38 = llhd.prb %clk_i_0 : i1
      %39 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %40 = llhd.prb %clk_i_0 : i1
      %41 = comb.xor bin %38, %true : i1
      %42 = comb.and bin %41, %40 : i1
      %43 = llhd.prb %rst_ni_1 : i1
      %44 = comb.xor bin %43, %true : i1
      %45 = comb.and bin %39, %44 : i1
      %46 = comb.or bin %42, %45 : i1
      cf.cond_br %46, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %47 = llhd.prb %rst_ni_1 : i1
      %48 = comb.xor %47, %true : i1
      cf.cond_br %48, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %reqid_q, %c0_i8 after %1 : i8
      llhd.drv %reqsz_q, %c0_i2 after %1 : i2
      llhd.drv %rspop_q, %c0_i3 after %1 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %49 = llhd.prb %a_ack : i1
      cf.cond_br %49, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %50 = llhd.prb %tl_i_2 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_source = hw.struct_extract %50["a_source"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      llhd.drv %reqid_q, %a_source after %1 : i8
      %51 = llhd.prb %tl_i_2 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_size = hw.struct_extract %51["a_size"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      llhd.drv %reqsz_q, %a_size after %1 : i2
      %52 = llhd.prb %rd_req : i1
      %53 = comb.concat %c0_i2, %52 : i2, i1
      llhd.drv %rspop_q, %53 after %1 : i3
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %38 = llhd.prb %clk_i_0 : i1
      %39 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %40 = llhd.prb %clk_i_0 : i1
      %41 = comb.xor bin %38, %true : i1
      %42 = comb.and bin %41, %40 : i1
      %43 = llhd.prb %rst_ni_1 : i1
      %44 = comb.xor bin %43, %true : i1
      %45 = comb.and bin %39, %44 : i1
      %46 = comb.or bin %42, %45 : i1
      cf.cond_br %46, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %47 = llhd.prb %rst_ni_1 : i1
      %48 = comb.xor %47, %true : i1
      cf.cond_br %48, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %rdata_q, %c0_i32 after %1 : i32
      llhd.drv %error_q, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %49 = llhd.prb %a_ack : i1
      cf.cond_br %49, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %50 = llhd.prb %error_i_4 : i1
      %51 = llhd.prb %err_internal : i1
      %52 = llhd.prb %wr_req : i1
      %53 = comb.or %50, %51, %52 : i1
      %54 = llhd.prb %rdata_i_3 : i32
      %55 = comb.mux %53, %c-1_i32, %54 : i32
      llhd.drv %rdata_q, %55 after %1 : i32
      %56 = llhd.prb %error_i_4 : i1
      %57 = llhd.prb %err_internal : i1
      %58 = comb.or %56, %57 : i1
      llhd.drv %error_q, %58 after %1 : i1
      cf.br ^bb1
    }
    %24 = llhd.prb %rdata_q {sv.namehint = "rdata"} : i32
    %25 = llhd.prb %error_q {sv.namehint = "error"} : i1
    %26 = llhd.prb %outstanding_q : i1
    %27 = llhd.prb %rspop_q : i3
    %28 = llhd.prb %reqsz_q : i2
    %29 = llhd.prb %reqid_q : i8
    %30 = comb.or %26, %busy_i : i1
    %31 = comb.xor %30, %true : i1
    %32 = hw.struct_create (%26, %27, %c0_i3, %28, %29, %false, %24, %0, %25, %31) {sv.namehint = "tl_o_pre"} : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %a_user = hw.struct_extract %6["a_user"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %instr_type = hw.struct_extract %a_user["instr_type"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %33 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%instr_type) : (i4) -> i1
    %34 = func.call @"prim_mubi_pkg::mubi4_test_false_loose"(%en_ifetch_i) : (i4) -> i1
    %35 = comb.and %33, %34 {sv.namehint = "instr_error"} : i1
    %36 = llhd.prb %addr_align_err : i1
    %37 = comb.or %36, %u_err.err_o, %35 : i1
    llhd.drv %err_internal, %37 after %2 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb4
      %38 = llhd.prb %wr_req : i1
      cf.cond_br %38, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %39 = llhd.prb %tl_i_2 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_address_5 = hw.struct_extract %39["a_address"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %40 = comb.extract %a_address_5 from 0 : (i32) -> i2
      %41 = comb.icmp ne %40, %c0_i2 : i2
      llhd.drv %addr_align_err, %41 after %2 : i1
      cf.br ^bb4
    ^bb3:  // pred: ^bb1
      llhd.drv %addr_align_err, %false after %2 : i1
      cf.br ^bb4
    ^bb4:  // 2 preds: ^bb2, ^bb3
      llhd.wait (%16, %6, %36 : i1, !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, i1), ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %2 : i1
    llhd.drv %rst_ni_1, %rst_ni after %2 : i1
    llhd.drv %tl_i_2, %tl_i after %2 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    llhd.drv %rdata_i_3, %rdata_i after %2 : i32
    llhd.drv %error_i_4, %error_i after %2 : i1
    hw.output %u_rsp_intg_gen.tl_o, %false, %21, %19, %23, %a_data, %a_mask : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, i1, i1, i1, i4, i32, i4
  }
  hw.module private @tlul_cmd_intg_chk(in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out err_o : i1) {
    %c0_i2 = hw.constant 0 : i2
    %c0_i14 = hw.constant 0 : i14
    %a_user = hw.struct_extract %tl_i["a_user"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %cmd_intg = hw.struct_extract %a_user["cmd_intg"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %0 = hw.bitcast %3 : (!hw.struct<instr_type: i4, addr: i32, opcode: i3, mask: i4>) -> i43
    %1 = comb.concat %cmd_intg, %c0_i14, %0 : i7, i14, i43
    %u_chk.data_o, %u_chk.syndrome_o, %u_chk.err_o = hw.instance "u_chk" @prim_secded_inv_64_57_dec(data_i: %1: i64) -> (data_o: i57, syndrome_o: i7, err_o: i2) {sv.namehint = "err"}
    %data_intg = hw.struct_extract %a_user["data_intg"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %a_data = hw.struct_extract %tl_i["a_data"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %2 = comb.concat %data_intg, %a_data : i7, i32
    %u_tlul_data_integ_dec.data_err_o = hw.instance "u_tlul_data_integ_dec" @tlul_data_integ_dec(data_intg_i: %2: i39) -> (data_err_o: i1) {sv.namehint = "data_err"}
    %3 = func.call @"tlul_pkg::extract_h2d_cmd_intg"(%tl_i) {sv.namehint = "cmd"} : (!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> !hw.struct<instr_type: i4, addr: i32, opcode: i3, mask: i4>
    %a_valid = hw.struct_extract %tl_i["a_valid"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %4 = comb.icmp ne %u_chk.err_o, %c0_i2 : i2
    %5 = comb.or %4, %u_tlul_data_integ_dec.data_err_o : i1
    %6 = comb.and %a_valid, %5 : i1
    hw.output %6 : i1
  }
  hw.module private @tlul_cmd_intg_gen(in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i14 = hw.constant 0 : i14
    %c0_i32 = hw.constant 0 : i32
    %c0_i7 = hw.constant 0 : i7
    %1 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %tl_i_0 = llhd.sig name "tl_i" %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %tl_o = llhd.sig %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %cmd_intg = llhd.sig %c0_i7 : i7
    %data_final = llhd.sig %c0_i32 : i32
    %data_intg = llhd.sig %c0_i7 : i7
    %2 = hw.bitcast %8 : (!hw.struct<instr_type: i4, addr: i32, opcode: i3, mask: i4>) -> i43
    %3 = comb.concat %c0_i14, %2 : i14, i43
    %u_cmd_gen.data_o = hw.instance "u_cmd_gen" @prim_secded_inv_64_57_enc(data_i: %3: i57) -> (data_o: i64)
    %4 = comb.extract %u_cmd_gen.data_o from 57 : (i64) -> i7
    llhd.drv %cmd_intg, %4 after %0 : i7
    %5 = llhd.prb %data_final : i32
    %gen_data_intg.u_data_gen.data_o = hw.instance "gen_data_intg.u_data_gen" @prim_secded_inv_39_32_enc(data_i: %5: i32) -> (data_o: i39)
    %6 = comb.extract %gen_data_intg.u_data_gen.data_o from 32 : (i39) -> i7
    llhd.drv %data_intg, %6 after %0 : i7
    %7 = llhd.prb %tl_i_0 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %8 = func.call @"tlul_pkg::extract_h2d_cmd_intg"(%7) {sv.namehint = "cmd"} : (!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> !hw.struct<instr_type: i4, addr: i32, opcode: i3, mask: i4>
    %a_data = hw.struct_extract %7["a_data"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    llhd.drv %data_final, %a_data after %0 : i32
    %9 = llhd.prb %tl_o : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %10 = llhd.prb %cmd_intg : i7
    %11 = llhd.prb %data_intg : i7
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %12 = llhd.prb %tl_i_0 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      llhd.drv %tl_o, %12 after %0 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %13 = llhd.sig.struct_extract %tl_o["a_data"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
      %14 = llhd.prb %data_final : i32
      llhd.drv %13, %14 after %0 : i32
      %15 = llhd.sig.struct_extract %tl_o["a_user"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
      %16 = llhd.sig.struct_extract %15["cmd_intg"] : <!hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>>
      %17 = llhd.prb %cmd_intg : i7
      llhd.drv %16, %17 after %0 : i7
      %18 = llhd.sig.struct_extract %15["data_intg"] : <!hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>>
      %19 = llhd.prb %data_intg : i7
      llhd.drv %18, %19 after %0 : i7
      llhd.wait (%7, %9, %5, %10, %11 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, i32, i7, i7), ^bb1
    }
    llhd.drv %tl_i_0, %tl_i after %0 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    hw.output %9 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
  }
  hw.module private @tlul_data_integ_dec(in %data_intg_i : i39, out data_err_o : i1) {
    %c0_i2 = hw.constant 0 : i2
    %u_data_chk.data_o, %u_data_chk.syndrome_o, %u_data_chk.err_o = hw.instance "u_data_chk" @prim_secded_inv_39_32_dec(data_i: %data_intg_i: i39) -> (data_o: i32, syndrome_o: i7, err_o: i2) {sv.namehint = "data_err"}
    %0 = comb.icmp ne %u_data_chk.err_o, %c0_i2 : i2
    hw.output %0 : i1
  }
  hw.module private @tlul_data_integ_enc(in %data_i : i32, out data_intg_o : i39) {
    %u_data_gen.data_o = hw.instance "u_data_gen" @prim_secded_inv_39_32_enc(data_i: %data_i: i32) -> (data_o: i39)
    hw.output %u_data_gen.data_o : i39
  }
  hw.module private @tlul_err_resp(in %clk_i : i1, in %rst_ni : i1, in %tl_h_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_h_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) {
    %0 = hw.aggregate_constant [0 : i7, 0 : i7] : !hw.struct<rsp_intg: i7, data_intg: i7>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = llhd.constant_time <0ns, 1d, 0e>
    %3 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %c0_i4 = hw.constant 0 : i4
    %c0_i8 = hw.constant 0 : i8
    %4 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %c0_i3 = hw.constant 0 : i3
    %c-1_i32 = hw.constant -1 : i32
    %c0_i32 = hw.constant 0 : i32
    %true = hw.constant true
    %c-7_i4 = hw.constant -7 : i4
    %c0_i2 = hw.constant 0 : i2
    %c-4_i3 = hw.constant -4 : i3
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %5 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %6 = llhd.prb %rst_ni_1 : i1
    %tl_h_i_2 = llhd.sig name "tl_h_i" %4 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %err_opcode = llhd.sig %c0_i3 : i3
    %err_source = llhd.sig %c0_i8 : i8
    %err_size = llhd.sig %c0_i2 : i2
    %err_rsp_pending = llhd.sig %false : i1
    %err_instr_type = llhd.sig %c0_i4 : i4
    %tl_h_o_int = llhd.sig %3 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %7 = llhd.prb %tl_h_o_int : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %u_intg_gen.tl_o = hw.instance "u_intg_gen" @tlul_rsp_intg_gen(tl_i: %7: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %28 = llhd.prb %clk_i_0 : i1
      %29 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%5, %6 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %30 = llhd.prb %clk_i_0 : i1
      %31 = comb.xor bin %28, %true : i1
      %32 = comb.and bin %31, %30 : i1
      %33 = llhd.prb %rst_ni_1 : i1
      %34 = comb.xor bin %33, %true : i1
      %35 = comb.and bin %29, %34 : i1
      %36 = comb.or bin %32, %35 : i1
      cf.cond_br %36, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %37 = llhd.prb %rst_ni_1 : i1
      %38 = comb.xor %37, %true : i1
      cf.cond_br %38, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %err_rsp_pending, %false after %2 : i1
      llhd.drv %err_source, %c0_i8 after %2 : i8
      llhd.drv %err_opcode, %c-4_i3 after %2 : i3
      llhd.drv %err_size, %c0_i2 after %2 : i2
      llhd.drv %err_instr_type, %c-7_i4 after %2 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %39 = llhd.prb %err_rsp_pending : i1
      %40 = llhd.prb %tl_h_i_2 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %d_ready = hw.struct_extract %40["d_ready"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %41 = comb.and %39, %d_ready : i1
      cf.cond_br %41, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %err_rsp_pending, %false after %2 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %42 = llhd.prb %tl_h_i_2 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_valid = hw.struct_extract %42["a_valid"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %43 = llhd.prb %tl_h_o_int : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      %a_ready = hw.struct_extract %43["a_ready"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      %44 = comb.and %a_valid, %a_ready : i1
      cf.cond_br %44, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %err_rsp_pending, %true after %2 : i1
      %45 = llhd.prb %tl_h_i_2 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_source = hw.struct_extract %45["a_source"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      llhd.drv %err_source, %a_source after %2 : i8
      %46 = llhd.prb %tl_h_i_2 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_opcode = hw.struct_extract %46["a_opcode"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      llhd.drv %err_opcode, %a_opcode after %2 : i3
      %47 = llhd.prb %tl_h_i_2 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_size = hw.struct_extract %47["a_size"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      llhd.drv %err_size, %a_size after %2 : i2
      %48 = llhd.prb %tl_h_i_2 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_user = hw.struct_extract %48["a_user"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %instr_type = hw.struct_extract %a_user["instr_type"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
      llhd.drv %err_instr_type, %instr_type after %2 : i4
      cf.br ^bb1
    }
    %8 = llhd.sig.struct_extract %tl_h_o_int["a_ready"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %9 = llhd.prb %err_rsp_pending : i1
    %10 = comb.xor %9, %true : i1
    llhd.drv %8, %10 after %1 : i1
    %11 = llhd.sig.struct_extract %tl_h_o_int["d_valid"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    llhd.drv %11, %9 after %1 : i1
    %12 = llhd.sig.struct_extract %tl_h_o_int["d_data"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %13 = llhd.prb %err_instr_type : i4
    %14 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%13) : (i4) -> i1
    %15 = comb.mux %14, %c0_i32, %c-1_i32 : i32
    llhd.drv %12, %15 after %1 : i32
    %16 = llhd.sig.struct_extract %tl_h_o_int["d_source"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %17 = llhd.prb %err_source : i8
    llhd.drv %16, %17 after %1 : i8
    %18 = llhd.sig.struct_extract %tl_h_o_int["d_sink"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    llhd.drv %18, %false after %1 : i1
    %19 = llhd.sig.struct_extract %tl_h_o_int["d_param"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    llhd.drv %19, %c0_i3 after %1 : i3
    %20 = llhd.sig.struct_extract %tl_h_o_int["d_size"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %21 = llhd.prb %err_size : i2
    llhd.drv %20, %21 after %1 : i2
    %22 = llhd.sig.struct_extract %tl_h_o_int["d_opcode"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %23 = llhd.prb %err_opcode : i3
    %24 = comb.icmp eq %23, %c-4_i3 : i3
    %25 = comb.concat %c0_i2, %24 : i2, i1
    llhd.drv %22, %25 after %1 : i3
    %26 = llhd.sig.struct_extract %tl_h_o_int["d_user"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    llhd.drv %26, %0 after %1 : !hw.struct<rsp_intg: i7, data_intg: i7>
    %27 = llhd.sig.struct_extract %tl_h_o_int["d_error"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    llhd.drv %27, %true after %1 : i1
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %tl_h_i_2, %tl_h_i after %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    hw.output %u_intg_gen.tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
  }
  hw.module private @tlul_err(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out err_o : i1) {
    %c-1_i2 = hw.constant -1 : i2
    %c-1_i4 = hw.constant -1 : i4
    %c0_i30 = hw.constant 0 : i30
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %c0_i4 = hw.constant 0 : i4
    %c2_i32 = hw.constant 2 : i32
    %c1_i32 = hw.constant 1 : i32
    %true = hw.constant true
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false
    %c1_i4 = hw.constant 1 : i4
    %c-4_i3 = hw.constant -4 : i3
    %c1_i3 = hw.constant 1 : i3
    %c0_i3 = hw.constant 0 : i3
    %1 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %tl_i_0 = llhd.sig name "tl_i" %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %addr_sz_chk = llhd.sig %false : i1
    %mask_chk = llhd.sig %false : i1
    %fulldata_chk = llhd.sig %false : i1
    %mask = llhd.sig %c0_i4 : i4
    %2 = llhd.prb %tl_i_0 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_opcode = hw.struct_extract %2["a_opcode"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %3 = comb.icmp eq %a_opcode, %c0_i3 {sv.namehint = "op_full"} : i3
    %4 = comb.icmp eq %a_opcode, %c1_i3 {sv.namehint = "op_partial"} : i3
    %5 = comb.icmp eq %a_opcode, %c-4_i3 {sv.namehint = "op_get"} : i3
    %a_user = hw.struct_extract %2["a_user"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %instr_type = hw.struct_extract %a_user["instr_type"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %6 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%instr_type) : (i4) -> i1
    %7 = comb.or %3, %4 : i1
    %8 = comb.and %6, %7 {sv.namehint = "instr_wr_err"} : i1
    %9 = func.call @"prim_mubi_pkg::mubi4_test_invalid"(%instr_type) {sv.namehint = "instr_type_err"} : (i4) -> i1
    %10 = comb.and %13, %17, %18, %21 : i1
    %11 = comb.xor %10, %true : i1
    %12 = comb.or %11, %8, %9 : i1
    %13 = comb.or %3, %4, %5 {sv.namehint = "opcode_allowed"} : i1
    %a_address = hw.struct_extract %2["a_address"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %14 = comb.extract %a_address from 0 : (i32) -> i2
    %15 = comb.concat %c0_i2, %14 : i2, i2
    %16 = comb.shl %c1_i4, %15 : i4
    llhd.drv %mask, %16 after %0 : i4
    %17 = llhd.prb %addr_sz_chk : i1
    %18 = llhd.prb %mask_chk : i1
    %19 = llhd.prb %fulldata_chk : i1
    %20 = llhd.prb %mask : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb9
      llhd.drv %addr_sz_chk, %false after %0 : i1
      llhd.drv %mask_chk, %false after %0 : i1
      llhd.drv %fulldata_chk, %false after %0 : i1
      %22 = llhd.prb %tl_i_0 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_valid = hw.struct_extract %22["a_valid"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      cf.cond_br %a_valid, ^bb2, ^bb9
    ^bb2:  // pred: ^bb1
      %23 = llhd.prb %tl_i_0 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_size = hw.struct_extract %23["a_size"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %24 = comb.concat %c0_i30, %a_size : i30, i2
      %25 = comb.icmp ceq %24, %c0_i32 : i32
      cf.cond_br %25, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %addr_sz_chk, %true after %0 : i1
      %26 = llhd.prb %tl_i_0 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_mask = hw.struct_extract %26["a_mask"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %27 = llhd.prb %mask : i4
      %28 = comb.xor %27, %c-1_i4 : i4
      %29 = comb.and %a_mask, %28 : i4
      %30 = comb.icmp eq %29, %c0_i4 : i4
      llhd.drv %mask_chk, %30 after %0 : i1
      %31 = llhd.prb %tl_i_0 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_mask_1 = hw.struct_extract %31["a_mask"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %32 = llhd.prb %mask : i4
      %33 = comb.and %a_mask_1, %32 : i4
      %34 = comb.icmp ne %33, %c0_i4 : i4
      llhd.drv %fulldata_chk, %34 after %0 : i1
      cf.br ^bb9
    ^bb4:  // pred: ^bb2
      %35 = comb.icmp ceq %24, %c1_i32 : i32
      cf.cond_br %35, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      %36 = llhd.prb %tl_i_0 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_address_2 = hw.struct_extract %36["a_address"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %37 = comb.extract %a_address_2 from 0 : (i32) -> i1
      %38 = comb.xor %37, %true : i1
      llhd.drv %addr_sz_chk, %38 after %0 : i1
      %39 = llhd.prb %tl_i_0 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_address_3 = hw.struct_extract %39["a_address"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %40 = comb.extract %a_address_3 from 1 : (i32) -> i1
      %a_mask_4 = hw.struct_extract %39["a_mask"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %41 = comb.extract %a_mask_4 from 0 : (i4) -> i2
      %42 = comb.icmp eq %41, %c0_i2 : i2
      %43 = comb.extract %a_mask_4 from 2 : (i4) -> i2
      %44 = comb.icmp eq %43, %c0_i2 : i2
      %45 = comb.mux %40, %42, %44 : i1
      llhd.drv %mask_chk, %45 after %0 : i1
      %46 = llhd.prb %tl_i_0 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_address_5 = hw.struct_extract %46["a_address"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %47 = comb.extract %a_address_5 from 1 : (i32) -> i1
      %a_mask_6 = hw.struct_extract %46["a_mask"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %48 = comb.extract %a_mask_6 from 2 : (i4) -> i2
      %49 = comb.icmp eq %48, %c-1_i2 : i2
      %50 = comb.extract %a_mask_6 from 0 : (i4) -> i2
      %51 = comb.icmp eq %50, %c-1_i2 : i2
      %52 = comb.mux %47, %49, %51 : i1
      llhd.drv %fulldata_chk, %52 after %0 : i1
      cf.br ^bb9
    ^bb6:  // pred: ^bb4
      %53 = comb.icmp ceq %24, %c2_i32 : i32
      cf.cond_br %53, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %54 = llhd.prb %tl_i_0 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_address_7 = hw.struct_extract %54["a_address"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %55 = comb.extract %a_address_7 from 0 : (i32) -> i2
      %56 = comb.icmp eq %55, %c0_i2 : i2
      llhd.drv %addr_sz_chk, %56 after %0 : i1
      llhd.drv %mask_chk, %true after %0 : i1
      %57 = llhd.prb %tl_i_0 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_mask_8 = hw.struct_extract %57["a_mask"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %58 = comb.icmp eq %a_mask_8, %c-1_i4 : i4
      llhd.drv %fulldata_chk, %58 after %0 : i1
      cf.br ^bb9
    ^bb8:  // pred: ^bb6
      llhd.drv %addr_sz_chk, %false after %0 : i1
      llhd.drv %mask_chk, %false after %0 : i1
      llhd.drv %fulldata_chk, %false after %0 : i1
      cf.br ^bb9
    ^bb9:  // 5 preds: ^bb1, ^bb3, ^bb5, ^bb7, ^bb8
      llhd.wait (%17, %18, %19, %2, %20 : i1, i1, i1, !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, i4), ^bb1
    }
    %21 = comb.or %5, %4, %19 : i1
    llhd.drv %tl_i_0, %tl_i after %0 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    hw.output %12 : i1
  }
  func.func private @"tlul_pkg::extract_h2d_cmd_intg"(%arg0: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> !hw.struct<instr_type: i4, addr: i32, opcode: i3, mask: i4> {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = hw.aggregate_constant [0 : i4, 0 : i32, 0 : i3, 0 : i4] : !hw.struct<instr_type: i4, addr: i32, opcode: i3, mask: i4>
    %payload = llhd.sig %1 : !hw.struct<instr_type: i4, addr: i32, opcode: i3, mask: i4>
    %2 = llhd.sig.struct_extract %payload["addr"] : <!hw.struct<instr_type: i4, addr: i32, opcode: i3, mask: i4>>
    %a_address = hw.struct_extract %arg0["a_address"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    llhd.drv %2, %a_address after %0 : i32
    %3 = llhd.sig.struct_extract %payload["opcode"] : <!hw.struct<instr_type: i4, addr: i32, opcode: i3, mask: i4>>
    %a_opcode = hw.struct_extract %arg0["a_opcode"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    llhd.drv %3, %a_opcode after %0 : i3
    %4 = llhd.sig.struct_extract %payload["mask"] : <!hw.struct<instr_type: i4, addr: i32, opcode: i3, mask: i4>>
    %a_mask = hw.struct_extract %arg0["a_mask"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    llhd.drv %4, %a_mask after %0 : i4
    %5 = llhd.sig.struct_extract %payload["instr_type"] : <!hw.struct<instr_type: i4, addr: i32, opcode: i3, mask: i4>>
    %a_user = hw.struct_extract %arg0["a_user"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %instr_type = hw.struct_extract %a_user["instr_type"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    llhd.drv %5, %instr_type after %0 : i4
    %6 = llhd.prb %payload : !hw.struct<instr_type: i4, addr: i32, opcode: i3, mask: i4>
    return %6 : !hw.struct<instr_type: i4, addr: i32, opcode: i3, mask: i4>
  }
  func.func private @"tlul_pkg::extract_d2h_rsp_intg"(%arg0: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> !hw.struct<opcode: i3, size: i2, error: i1> {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = hw.aggregate_constant [0 : i3, 0 : i2, false] : !hw.struct<opcode: i3, size: i2, error: i1>
    %payload = llhd.sig %1 : !hw.struct<opcode: i3, size: i2, error: i1>
    %2 = llhd.sig.struct_extract %payload["opcode"] : <!hw.struct<opcode: i3, size: i2, error: i1>>
    %d_opcode = hw.struct_extract %arg0["d_opcode"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %2, %d_opcode after %0 : i3
    %3 = llhd.sig.struct_extract %payload["size"] : <!hw.struct<opcode: i3, size: i2, error: i1>>
    %d_size = hw.struct_extract %arg0["d_size"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %3, %d_size after %0 : i2
    %4 = llhd.sig.struct_extract %payload["error"] : <!hw.struct<opcode: i3, size: i2, error: i1>>
    %d_error = hw.struct_extract %arg0["d_error"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %4, %d_error after %0 : i1
    %5 = llhd.prb %payload : !hw.struct<opcode: i3, size: i2, error: i1>
    return %5 : !hw.struct<opcode: i3, size: i2, error: i1>
  }
  hw.module private @tlul_rsp_intg_chk(in %tl_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out err_o : i1) {
    %c0_i2 = hw.constant 0 : i2
    %c0_i51 = hw.constant 0 : i51
    %d_user = hw.struct_extract %tl_i["d_user"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %rsp_intg = hw.struct_extract %d_user["rsp_intg"] : !hw.struct<rsp_intg: i7, data_intg: i7>
    %0 = hw.bitcast %3 : (!hw.struct<opcode: i3, size: i2, error: i1>) -> i6
    %1 = comb.concat %rsp_intg, %c0_i51, %0 : i7, i51, i6
    %u_chk.data_o, %u_chk.syndrome_o, %u_chk.err_o = hw.instance "u_chk" @prim_secded_inv_64_57_dec(data_i: %1: i64) -> (data_o: i57, syndrome_o: i7, err_o: i2) {sv.namehint = "rsp_err"}
    %data_intg = hw.struct_extract %d_user["data_intg"] : !hw.struct<rsp_intg: i7, data_intg: i7>
    %d_data = hw.struct_extract %tl_i["d_data"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %2 = comb.concat %data_intg, %d_data : i7, i32
    %gen_rsp_data_intg_check.u_tlul_data_integ_dec.data_err_o = hw.instance "gen_rsp_data_intg_check.u_tlul_data_integ_dec" @tlul_data_integ_dec(data_intg_i: %2: i39) -> (data_err_o: i1) {sv.namehint = "rsp_data_err"}
    %3 = func.call @"tlul_pkg::extract_d2h_rsp_intg"(%tl_i) {sv.namehint = "rsp"} : (!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> !hw.struct<opcode: i3, size: i2, error: i1>
    %d_valid = hw.struct_extract %tl_i["d_valid"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %4 = comb.icmp ne %u_chk.err_o, %c0_i2 : i2
    %5 = comb.or %4, %gen_rsp_data_intg_check.u_tlul_data_integ_dec.data_err_o : i1
    %6 = comb.and %d_valid, %5 : i1
    hw.output %6 : i1
  }
  hw.module private @tlul_rsp_intg_gen(in %tl_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i51 = hw.constant 0 : i51
    %c0_i7 = hw.constant 0 : i7
    %1 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %tl_i_0 = llhd.sig name "tl_i" %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %tl_o = llhd.sig %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %rsp_intg = llhd.sig %c0_i7 : i7
    %data_intg = llhd.sig %c0_i7 : i7
    %2 = hw.bitcast %7 : (!hw.struct<opcode: i3, size: i2, error: i1>) -> i6
    %3 = comb.concat %c0_i51, %2 : i51, i6
    %gen_rsp_intg.u_rsp_gen.data_o = hw.instance "gen_rsp_intg.u_rsp_gen" @prim_secded_inv_64_57_enc(data_i: %3: i57) -> (data_o: i64)
    %4 = comb.extract %gen_rsp_intg.u_rsp_gen.data_o from 57 : (i64) -> i7
    llhd.drv %rsp_intg, %4 after %0 : i7
    %5 = llhd.prb %tl_i_0 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %d_data = hw.struct_extract %5["d_data"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %gen_data_intg.u_tlul_data_integ_enc.data_intg_o = hw.instance "gen_data_intg.u_tlul_data_integ_enc" @tlul_data_integ_enc(data_i: %d_data: i32) -> (data_intg_o: i39)
    %6 = comb.extract %gen_data_intg.u_tlul_data_integ_enc.data_intg_o from 32 : (i39) -> i7
    llhd.drv %data_intg, %6 after %0 : i7
    %7 = func.call @"tlul_pkg::extract_d2h_rsp_intg"(%5) {sv.namehint = "gen_rsp_intg.rsp"} : (!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> !hw.struct<opcode: i3, size: i2, error: i1>
    %8 = llhd.prb %tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %9 = llhd.prb %rsp_intg : i7
    %10 = llhd.prb %data_intg : i7
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %11 = llhd.prb %tl_i_0 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      llhd.drv %tl_o, %11 after %0 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      %12 = llhd.sig.struct_extract %tl_o["d_user"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
      %13 = llhd.sig.struct_extract %12["rsp_intg"] : <!hw.struct<rsp_intg: i7, data_intg: i7>>
      %14 = llhd.prb %rsp_intg : i7
      llhd.drv %13, %14 after %0 : i7
      %15 = llhd.sig.struct_extract %12["data_intg"] : <!hw.struct<rsp_intg: i7, data_intg: i7>>
      %16 = llhd.prb %data_intg : i7
      llhd.drv %15, %16 after %0 : i7
      llhd.wait (%5, %8, %9, %10 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, i7, i7), ^bb1
    }
    llhd.drv %tl_i_0, %tl_i after %0 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    hw.output %8 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
  }
  hw.module private @tlul_rsp_intg_gen_11(in %tl_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i51 = hw.constant 0 : i51
    %c0_i7 = hw.constant 0 : i7
    %1 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %tl_i_0 = llhd.sig name "tl_i" %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %tl_o = llhd.sig %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %rsp_intg = llhd.sig %c0_i7 : i7
    %data_intg = llhd.sig %c0_i7 : i7
    %2 = hw.bitcast %7 : (!hw.struct<opcode: i3, size: i2, error: i1>) -> i6
    %3 = comb.concat %c0_i51, %2 : i51, i6
    %gen_rsp_intg.u_rsp_gen.data_o = hw.instance "gen_rsp_intg.u_rsp_gen" @prim_secded_inv_64_57_enc(data_i: %3: i57) -> (data_o: i64)
    %4 = comb.extract %gen_rsp_intg.u_rsp_gen.data_o from 57 : (i64) -> i7
    llhd.drv %rsp_intg, %4 after %0 : i7
    %5 = llhd.prb %tl_i_0 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %d_data = hw.struct_extract %5["d_data"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %gen_data_intg.u_tlul_data_integ_enc.data_intg_o = hw.instance "gen_data_intg.u_tlul_data_integ_enc" @tlul_data_integ_enc(data_i: %d_data: i32) -> (data_intg_o: i39)
    %6 = comb.extract %gen_data_intg.u_tlul_data_integ_enc.data_intg_o from 32 : (i39) -> i7
    llhd.drv %data_intg, %6 after %0 : i7
    %7 = func.call @"tlul_pkg::extract_d2h_rsp_intg"(%5) {sv.namehint = "gen_rsp_intg.rsp"} : (!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> !hw.struct<opcode: i3, size: i2, error: i1>
    %8 = llhd.prb %tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %9 = llhd.prb %rsp_intg : i7
    %10 = llhd.prb %data_intg : i7
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %11 = llhd.prb %tl_i_0 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      llhd.drv %tl_o, %11 after %0 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      %12 = llhd.sig.struct_extract %tl_o["d_user"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
      %13 = llhd.sig.struct_extract %12["rsp_intg"] : <!hw.struct<rsp_intg: i7, data_intg: i7>>
      %14 = llhd.prb %rsp_intg : i7
      llhd.drv %13, %14 after %0 : i7
      %15 = llhd.sig.struct_extract %12["data_intg"] : <!hw.struct<rsp_intg: i7, data_intg: i7>>
      %16 = llhd.prb %data_intg : i7
      llhd.drv %15, %16 after %0 : i7
      llhd.wait (%5, %8, %9, %10 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, i7, i7), ^bb1
    }
    llhd.drv %tl_i_0, %tl_i after %0 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    hw.output %8 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
  }
  hw.module private @tlul_rsp_intg_gen_13(in %tl_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i7 = hw.constant 0 : i7
    %1 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %tl_i_0 = llhd.sig name "tl_i" %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %tl_o = llhd.sig %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %rsp_intg = llhd.sig %c0_i7 : i7
    %data_intg = llhd.sig %c0_i7 : i7
    llhd.drv %rsp_intg, %c0_i7 after %0 : i7
    llhd.drv %data_intg, %c0_i7 after %0 : i7
    %2 = llhd.prb %tl_i_0 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %3 = llhd.prb %tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %4 = llhd.prb %rsp_intg : i7
    %5 = llhd.prb %data_intg : i7
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %6 = llhd.prb %tl_i_0 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      llhd.drv %tl_o, %6 after %0 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      %7 = llhd.sig.struct_extract %tl_o["d_user"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
      %8 = llhd.sig.struct_extract %7["rsp_intg"] : <!hw.struct<rsp_intg: i7, data_intg: i7>>
      %9 = llhd.prb %rsp_intg : i7
      llhd.drv %8, %9 after %0 : i7
      %10 = llhd.sig.struct_extract %7["data_intg"] : <!hw.struct<rsp_intg: i7, data_intg: i7>>
      %11 = llhd.prb %data_intg : i7
      llhd.drv %10, %11 after %0 : i7
      llhd.wait (%2, %3, %4, %5 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, i7, i7), ^bb1
    }
    llhd.drv %tl_i_0, %tl_i after %0 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    hw.output %3 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
  }
  hw.module private @prim_mubi8_sync(in %clk_i : i1, in %rst_ni : i1, in %mubi_i : i8, out mubi_o : !hw.array<4xi8>) {
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %c0_i2 = hw.constant 0 : i2
    %c-1_i3 = hw.constant -1 : i3
    %c-2_i3 = hw.constant -2 : i3
    %c-3_i3 = hw.constant -3 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c3_i3 = hw.constant 3 : i3
    %c2_i3 = hw.constant 2 : i3
    %c1_i3 = hw.constant 1 : i3
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i3 = hw.constant 0 : i3
    %c0_i8 = hw.constant 0 : i8
    %1 = hw.aggregate_constant [0 : i8, 0 : i8, 0 : i8, 0 : i8] : !hw.array<4xi8>
    %mubi_o = llhd.sig %1 : !hw.array<4xi8>
    %gen_buffs_0.mubi_out = llhd.sig %c0_i8 : i8
    %gen_buffs_1.mubi_out = llhd.sig %c0_i8 : i8
    %gen_buffs_2.mubi_out = llhd.sig %c0_i8 : i8
    %gen_buffs_3.mubi_out = llhd.sig %c0_i8 : i8
    %gen_flops.u_prim_flop_2sync.q_o = hw.instance "gen_flops.u_prim_flop_2sync" @prim_flop_2sync_7(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %mubi_i: i8) -> (q_o: i8) {sv.namehint = "gen_flops.mubi_sync"}
    %2 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 0 : (i8) -> i1
    %3 = llhd.sig.extract %gen_buffs_0.mubi_out from %c0_i3 : <i8> -> <i1>
    %gen_buffs_0.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_0.u_prim_buf" @prim_buf(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %3, %gen_buffs_0.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %4 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 1 : (i8) -> i1
    %5 = llhd.sig.extract %gen_buffs_0.mubi_out from %c1_i3 : <i8> -> <i1>
    %gen_buffs_0.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_1.u_prim_buf" @prim_buf(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %5, %gen_buffs_0.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %6 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 2 : (i8) -> i1
    %7 = llhd.sig.extract %gen_buffs_0.mubi_out from %c2_i3 : <i8> -> <i1>
    %gen_buffs_0.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_2.u_prim_buf" @prim_buf(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %7, %gen_buffs_0.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %8 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 3 : (i8) -> i1
    %9 = llhd.sig.extract %gen_buffs_0.mubi_out from %c3_i3 : <i8> -> <i1>
    %gen_buffs_0.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_3.u_prim_buf" @prim_buf(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %9, %gen_buffs_0.gen_bits_3.u_prim_buf.out_o after %0 : i1
    %10 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 4 : (i8) -> i1
    %11 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-4_i3 : <i8> -> <i1>
    %gen_buffs_0.gen_bits_4.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_4.u_prim_buf" @prim_buf(in_i: %10: i1) -> (out_o: i1)
    llhd.drv %11, %gen_buffs_0.gen_bits_4.u_prim_buf.out_o after %0 : i1
    %12 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 5 : (i8) -> i1
    %13 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-3_i3 : <i8> -> <i1>
    %gen_buffs_0.gen_bits_5.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_5.u_prim_buf" @prim_buf(in_i: %12: i1) -> (out_o: i1)
    llhd.drv %13, %gen_buffs_0.gen_bits_5.u_prim_buf.out_o after %0 : i1
    %14 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 6 : (i8) -> i1
    %15 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-2_i3 : <i8> -> <i1>
    %gen_buffs_0.gen_bits_6.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_6.u_prim_buf" @prim_buf(in_i: %14: i1) -> (out_o: i1)
    llhd.drv %15, %gen_buffs_0.gen_bits_6.u_prim_buf.out_o after %0 : i1
    %16 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 7 : (i8) -> i1
    %17 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-1_i3 : <i8> -> <i1>
    %gen_buffs_0.gen_bits_7.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_7.u_prim_buf" @prim_buf(in_i: %16: i1) -> (out_o: i1)
    llhd.drv %17, %gen_buffs_0.gen_bits_7.u_prim_buf.out_o after %0 : i1
    %18 = llhd.sig.extract %gen_buffs_1.mubi_out from %c0_i3 : <i8> -> <i1>
    %gen_buffs_1.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_0.u_prim_buf" @prim_buf(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %18, %gen_buffs_1.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %19 = llhd.sig.extract %gen_buffs_1.mubi_out from %c1_i3 : <i8> -> <i1>
    %gen_buffs_1.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_1.u_prim_buf" @prim_buf(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %19, %gen_buffs_1.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %20 = llhd.sig.extract %gen_buffs_1.mubi_out from %c2_i3 : <i8> -> <i1>
    %gen_buffs_1.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_2.u_prim_buf" @prim_buf(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %20, %gen_buffs_1.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %21 = llhd.sig.extract %gen_buffs_1.mubi_out from %c3_i3 : <i8> -> <i1>
    %gen_buffs_1.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_3.u_prim_buf" @prim_buf(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %21, %gen_buffs_1.gen_bits_3.u_prim_buf.out_o after %0 : i1
    %22 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-4_i3 : <i8> -> <i1>
    %gen_buffs_1.gen_bits_4.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_4.u_prim_buf" @prim_buf(in_i: %10: i1) -> (out_o: i1)
    llhd.drv %22, %gen_buffs_1.gen_bits_4.u_prim_buf.out_o after %0 : i1
    %23 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-3_i3 : <i8> -> <i1>
    %gen_buffs_1.gen_bits_5.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_5.u_prim_buf" @prim_buf(in_i: %12: i1) -> (out_o: i1)
    llhd.drv %23, %gen_buffs_1.gen_bits_5.u_prim_buf.out_o after %0 : i1
    %24 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-2_i3 : <i8> -> <i1>
    %gen_buffs_1.gen_bits_6.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_6.u_prim_buf" @prim_buf(in_i: %14: i1) -> (out_o: i1)
    llhd.drv %24, %gen_buffs_1.gen_bits_6.u_prim_buf.out_o after %0 : i1
    %25 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-1_i3 : <i8> -> <i1>
    %gen_buffs_1.gen_bits_7.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_7.u_prim_buf" @prim_buf(in_i: %16: i1) -> (out_o: i1)
    llhd.drv %25, %gen_buffs_1.gen_bits_7.u_prim_buf.out_o after %0 : i1
    %26 = llhd.sig.extract %gen_buffs_2.mubi_out from %c0_i3 : <i8> -> <i1>
    %gen_buffs_2.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_0.u_prim_buf" @prim_buf(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %26, %gen_buffs_2.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %27 = llhd.sig.extract %gen_buffs_2.mubi_out from %c1_i3 : <i8> -> <i1>
    %gen_buffs_2.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_1.u_prim_buf" @prim_buf(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %27, %gen_buffs_2.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %28 = llhd.sig.extract %gen_buffs_2.mubi_out from %c2_i3 : <i8> -> <i1>
    %gen_buffs_2.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_2.u_prim_buf" @prim_buf(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %28, %gen_buffs_2.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %29 = llhd.sig.extract %gen_buffs_2.mubi_out from %c3_i3 : <i8> -> <i1>
    %gen_buffs_2.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_3.u_prim_buf" @prim_buf(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %29, %gen_buffs_2.gen_bits_3.u_prim_buf.out_o after %0 : i1
    %30 = llhd.sig.extract %gen_buffs_2.mubi_out from %c-4_i3 : <i8> -> <i1>
    %gen_buffs_2.gen_bits_4.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_4.u_prim_buf" @prim_buf(in_i: %10: i1) -> (out_o: i1)
    llhd.drv %30, %gen_buffs_2.gen_bits_4.u_prim_buf.out_o after %0 : i1
    %31 = llhd.sig.extract %gen_buffs_2.mubi_out from %c-3_i3 : <i8> -> <i1>
    %gen_buffs_2.gen_bits_5.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_5.u_prim_buf" @prim_buf(in_i: %12: i1) -> (out_o: i1)
    llhd.drv %31, %gen_buffs_2.gen_bits_5.u_prim_buf.out_o after %0 : i1
    %32 = llhd.sig.extract %gen_buffs_2.mubi_out from %c-2_i3 : <i8> -> <i1>
    %gen_buffs_2.gen_bits_6.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_6.u_prim_buf" @prim_buf(in_i: %14: i1) -> (out_o: i1)
    llhd.drv %32, %gen_buffs_2.gen_bits_6.u_prim_buf.out_o after %0 : i1
    %33 = llhd.sig.extract %gen_buffs_2.mubi_out from %c-1_i3 : <i8> -> <i1>
    %gen_buffs_2.gen_bits_7.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_7.u_prim_buf" @prim_buf(in_i: %16: i1) -> (out_o: i1)
    llhd.drv %33, %gen_buffs_2.gen_bits_7.u_prim_buf.out_o after %0 : i1
    %34 = llhd.sig.extract %gen_buffs_3.mubi_out from %c0_i3 : <i8> -> <i1>
    %gen_buffs_3.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_0.u_prim_buf" @prim_buf(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %34, %gen_buffs_3.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %35 = llhd.sig.extract %gen_buffs_3.mubi_out from %c1_i3 : <i8> -> <i1>
    %gen_buffs_3.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_1.u_prim_buf" @prim_buf(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %35, %gen_buffs_3.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %36 = llhd.sig.extract %gen_buffs_3.mubi_out from %c2_i3 : <i8> -> <i1>
    %gen_buffs_3.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_2.u_prim_buf" @prim_buf(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %36, %gen_buffs_3.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %37 = llhd.sig.extract %gen_buffs_3.mubi_out from %c3_i3 : <i8> -> <i1>
    %gen_buffs_3.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_3.u_prim_buf" @prim_buf(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %37, %gen_buffs_3.gen_bits_3.u_prim_buf.out_o after %0 : i1
    %38 = llhd.sig.extract %gen_buffs_3.mubi_out from %c-4_i3 : <i8> -> <i1>
    %gen_buffs_3.gen_bits_4.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_4.u_prim_buf" @prim_buf(in_i: %10: i1) -> (out_o: i1)
    llhd.drv %38, %gen_buffs_3.gen_bits_4.u_prim_buf.out_o after %0 : i1
    %39 = llhd.sig.extract %gen_buffs_3.mubi_out from %c-3_i3 : <i8> -> <i1>
    %gen_buffs_3.gen_bits_5.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_5.u_prim_buf" @prim_buf(in_i: %12: i1) -> (out_o: i1)
    llhd.drv %39, %gen_buffs_3.gen_bits_5.u_prim_buf.out_o after %0 : i1
    %40 = llhd.sig.extract %gen_buffs_3.mubi_out from %c-2_i3 : <i8> -> <i1>
    %gen_buffs_3.gen_bits_6.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_6.u_prim_buf" @prim_buf(in_i: %14: i1) -> (out_o: i1)
    llhd.drv %40, %gen_buffs_3.gen_bits_6.u_prim_buf.out_o after %0 : i1
    %41 = llhd.sig.extract %gen_buffs_3.mubi_out from %c-1_i3 : <i8> -> <i1>
    %gen_buffs_3.gen_bits_7.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_7.u_prim_buf" @prim_buf(in_i: %16: i1) -> (out_o: i1)
    llhd.drv %41, %gen_buffs_3.gen_bits_7.u_prim_buf.out_o after %0 : i1
    %42 = llhd.sig.array_get %mubi_o[%c0_i2] : <!hw.array<4xi8>>
    %43 = llhd.prb %gen_buffs_0.mubi_out : i8
    llhd.drv %42, %43 after %0 : i8
    %44 = llhd.sig.array_get %mubi_o[%c1_i2] : <!hw.array<4xi8>>
    %45 = llhd.prb %gen_buffs_1.mubi_out : i8
    llhd.drv %44, %45 after %0 : i8
    %46 = llhd.sig.array_get %mubi_o[%c-2_i2] : <!hw.array<4xi8>>
    %47 = llhd.prb %gen_buffs_2.mubi_out : i8
    llhd.drv %46, %47 after %0 : i8
    %48 = llhd.sig.array_get %mubi_o[%c-1_i2] : <!hw.array<4xi8>>
    %49 = llhd.prb %gen_buffs_3.mubi_out : i8
    llhd.drv %48, %49 after %0 : i8
    %50 = llhd.prb %mubi_o : !hw.array<4xi8>
    hw.output %50 : !hw.array<4xi8>
  }
  hw.module private @prim_mubi32_sync(in %clk_i : i1, in %rst_ni : i1, in %mubi_i : i32, out mubi_o : !hw.array<4xi32>) {
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %c0_i2 = hw.constant 0 : i2
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c-1_i5 = hw.constant -1 : i5
    %c-2_i5 = hw.constant -2 : i5
    %c-3_i5 = hw.constant -3 : i5
    %c-4_i5 = hw.constant -4 : i5
    %c-5_i5 = hw.constant -5 : i5
    %c-6_i5 = hw.constant -6 : i5
    %c-7_i5 = hw.constant -7 : i5
    %c-8_i5 = hw.constant -8 : i5
    %c-9_i5 = hw.constant -9 : i5
    %c-10_i5 = hw.constant -10 : i5
    %c-11_i5 = hw.constant -11 : i5
    %c-12_i5 = hw.constant -12 : i5
    %c-13_i5 = hw.constant -13 : i5
    %c-14_i5 = hw.constant -14 : i5
    %c-15_i5 = hw.constant -15 : i5
    %c-16_i5 = hw.constant -16 : i5
    %c15_i5 = hw.constant 15 : i5
    %c14_i5 = hw.constant 14 : i5
    %c13_i5 = hw.constant 13 : i5
    %c12_i5 = hw.constant 12 : i5
    %c11_i5 = hw.constant 11 : i5
    %c10_i5 = hw.constant 10 : i5
    %c9_i5 = hw.constant 9 : i5
    %c8_i5 = hw.constant 8 : i5
    %c7_i5 = hw.constant 7 : i5
    %c6_i5 = hw.constant 6 : i5
    %c5_i5 = hw.constant 5 : i5
    %c4_i5 = hw.constant 4 : i5
    %c3_i5 = hw.constant 3 : i5
    %c2_i5 = hw.constant 2 : i5
    %c1_i5 = hw.constant 1 : i5
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i5 = hw.constant 0 : i5
    %2 = hw.aggregate_constant [0 : i32, 0 : i32, 0 : i32, 0 : i32] : !hw.array<4xi32>
    %c0_i32 = hw.constant 0 : i32
    %c1768515945_i32 = hw.constant 1768515945 : i32
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %mubi_i_2 = llhd.sig name "mubi_i" %c0_i32 : i32
    %mubi_o = llhd.sig %2 : !hw.array<4xi32>
    %gen_no_flops.unused_logic = llhd.sig %c0_i32 : i32
    %gen_buffs_0.mubi_out = llhd.sig %c0_i32 : i32
    %gen_buffs_1.mubi_out = llhd.sig %c0_i32 : i32
    %gen_buffs_2.mubi_out = llhd.sig %c0_i32 : i32
    %gen_buffs_3.mubi_out = llhd.sig %c0_i32 : i32
    %5 = comb.extract %165 from 0 : (i32) -> i1
    %6 = llhd.sig.extract %gen_buffs_0.mubi_out from %c0_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_0.u_prim_buf" @prim_buf(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %6, %gen_buffs_0.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %7 = comb.extract %165 from 1 : (i32) -> i1
    %8 = llhd.sig.extract %gen_buffs_0.mubi_out from %c1_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_1.u_prim_buf" @prim_buf(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %8, %gen_buffs_0.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %9 = comb.extract %165 from 2 : (i32) -> i1
    %10 = llhd.sig.extract %gen_buffs_0.mubi_out from %c2_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_2.u_prim_buf" @prim_buf(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %10, %gen_buffs_0.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %11 = comb.extract %165 from 3 : (i32) -> i1
    %12 = llhd.sig.extract %gen_buffs_0.mubi_out from %c3_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_3.u_prim_buf" @prim_buf(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %12, %gen_buffs_0.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %13 = comb.extract %165 from 4 : (i32) -> i1
    %14 = llhd.sig.extract %gen_buffs_0.mubi_out from %c4_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_4.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_4.u_prim_buf" @prim_buf(in_i: %13: i1) -> (out_o: i1)
    llhd.drv %14, %gen_buffs_0.gen_bits_4.u_prim_buf.out_o after %1 : i1
    %15 = comb.extract %165 from 5 : (i32) -> i1
    %16 = llhd.sig.extract %gen_buffs_0.mubi_out from %c5_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_5.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_5.u_prim_buf" @prim_buf(in_i: %15: i1) -> (out_o: i1)
    llhd.drv %16, %gen_buffs_0.gen_bits_5.u_prim_buf.out_o after %1 : i1
    %17 = comb.extract %165 from 6 : (i32) -> i1
    %18 = llhd.sig.extract %gen_buffs_0.mubi_out from %c6_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_6.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_6.u_prim_buf" @prim_buf(in_i: %17: i1) -> (out_o: i1)
    llhd.drv %18, %gen_buffs_0.gen_bits_6.u_prim_buf.out_o after %1 : i1
    %19 = comb.extract %165 from 7 : (i32) -> i1
    %20 = llhd.sig.extract %gen_buffs_0.mubi_out from %c7_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_7.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_7.u_prim_buf" @prim_buf(in_i: %19: i1) -> (out_o: i1)
    llhd.drv %20, %gen_buffs_0.gen_bits_7.u_prim_buf.out_o after %1 : i1
    %21 = comb.extract %165 from 8 : (i32) -> i1
    %22 = llhd.sig.extract %gen_buffs_0.mubi_out from %c8_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_8.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_8.u_prim_buf" @prim_buf(in_i: %21: i1) -> (out_o: i1)
    llhd.drv %22, %gen_buffs_0.gen_bits_8.u_prim_buf.out_o after %1 : i1
    %23 = comb.extract %165 from 9 : (i32) -> i1
    %24 = llhd.sig.extract %gen_buffs_0.mubi_out from %c9_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_9.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_9.u_prim_buf" @prim_buf(in_i: %23: i1) -> (out_o: i1)
    llhd.drv %24, %gen_buffs_0.gen_bits_9.u_prim_buf.out_o after %1 : i1
    %25 = comb.extract %165 from 10 : (i32) -> i1
    %26 = llhd.sig.extract %gen_buffs_0.mubi_out from %c10_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_10.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_10.u_prim_buf" @prim_buf(in_i: %25: i1) -> (out_o: i1)
    llhd.drv %26, %gen_buffs_0.gen_bits_10.u_prim_buf.out_o after %1 : i1
    %27 = comb.extract %165 from 11 : (i32) -> i1
    %28 = llhd.sig.extract %gen_buffs_0.mubi_out from %c11_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_11.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_11.u_prim_buf" @prim_buf(in_i: %27: i1) -> (out_o: i1)
    llhd.drv %28, %gen_buffs_0.gen_bits_11.u_prim_buf.out_o after %1 : i1
    %29 = comb.extract %165 from 12 : (i32) -> i1
    %30 = llhd.sig.extract %gen_buffs_0.mubi_out from %c12_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_12.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_12.u_prim_buf" @prim_buf(in_i: %29: i1) -> (out_o: i1)
    llhd.drv %30, %gen_buffs_0.gen_bits_12.u_prim_buf.out_o after %1 : i1
    %31 = comb.extract %165 from 13 : (i32) -> i1
    %32 = llhd.sig.extract %gen_buffs_0.mubi_out from %c13_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_13.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_13.u_prim_buf" @prim_buf(in_i: %31: i1) -> (out_o: i1)
    llhd.drv %32, %gen_buffs_0.gen_bits_13.u_prim_buf.out_o after %1 : i1
    %33 = comb.extract %165 from 14 : (i32) -> i1
    %34 = llhd.sig.extract %gen_buffs_0.mubi_out from %c14_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_14.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_14.u_prim_buf" @prim_buf(in_i: %33: i1) -> (out_o: i1)
    llhd.drv %34, %gen_buffs_0.gen_bits_14.u_prim_buf.out_o after %1 : i1
    %35 = comb.extract %165 from 15 : (i32) -> i1
    %36 = llhd.sig.extract %gen_buffs_0.mubi_out from %c15_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_15.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_15.u_prim_buf" @prim_buf(in_i: %35: i1) -> (out_o: i1)
    llhd.drv %36, %gen_buffs_0.gen_bits_15.u_prim_buf.out_o after %1 : i1
    %37 = comb.extract %165 from 16 : (i32) -> i1
    %38 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-16_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_16.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_16.u_prim_buf" @prim_buf(in_i: %37: i1) -> (out_o: i1)
    llhd.drv %38, %gen_buffs_0.gen_bits_16.u_prim_buf.out_o after %1 : i1
    %39 = comb.extract %165 from 17 : (i32) -> i1
    %40 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-15_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_17.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_17.u_prim_buf" @prim_buf(in_i: %39: i1) -> (out_o: i1)
    llhd.drv %40, %gen_buffs_0.gen_bits_17.u_prim_buf.out_o after %1 : i1
    %41 = comb.extract %165 from 18 : (i32) -> i1
    %42 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-14_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_18.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_18.u_prim_buf" @prim_buf(in_i: %41: i1) -> (out_o: i1)
    llhd.drv %42, %gen_buffs_0.gen_bits_18.u_prim_buf.out_o after %1 : i1
    %43 = comb.extract %165 from 19 : (i32) -> i1
    %44 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-13_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_19.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_19.u_prim_buf" @prim_buf(in_i: %43: i1) -> (out_o: i1)
    llhd.drv %44, %gen_buffs_0.gen_bits_19.u_prim_buf.out_o after %1 : i1
    %45 = comb.extract %165 from 20 : (i32) -> i1
    %46 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-12_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_20.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_20.u_prim_buf" @prim_buf(in_i: %45: i1) -> (out_o: i1)
    llhd.drv %46, %gen_buffs_0.gen_bits_20.u_prim_buf.out_o after %1 : i1
    %47 = comb.extract %165 from 21 : (i32) -> i1
    %48 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-11_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_21.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_21.u_prim_buf" @prim_buf(in_i: %47: i1) -> (out_o: i1)
    llhd.drv %48, %gen_buffs_0.gen_bits_21.u_prim_buf.out_o after %1 : i1
    %49 = comb.extract %165 from 22 : (i32) -> i1
    %50 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-10_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_22.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_22.u_prim_buf" @prim_buf(in_i: %49: i1) -> (out_o: i1)
    llhd.drv %50, %gen_buffs_0.gen_bits_22.u_prim_buf.out_o after %1 : i1
    %51 = comb.extract %165 from 23 : (i32) -> i1
    %52 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-9_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_23.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_23.u_prim_buf" @prim_buf(in_i: %51: i1) -> (out_o: i1)
    llhd.drv %52, %gen_buffs_0.gen_bits_23.u_prim_buf.out_o after %1 : i1
    %53 = comb.extract %165 from 24 : (i32) -> i1
    %54 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-8_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_24.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_24.u_prim_buf" @prim_buf(in_i: %53: i1) -> (out_o: i1)
    llhd.drv %54, %gen_buffs_0.gen_bits_24.u_prim_buf.out_o after %1 : i1
    %55 = comb.extract %165 from 25 : (i32) -> i1
    %56 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-7_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_25.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_25.u_prim_buf" @prim_buf(in_i: %55: i1) -> (out_o: i1)
    llhd.drv %56, %gen_buffs_0.gen_bits_25.u_prim_buf.out_o after %1 : i1
    %57 = comb.extract %165 from 26 : (i32) -> i1
    %58 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-6_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_26.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_26.u_prim_buf" @prim_buf(in_i: %57: i1) -> (out_o: i1)
    llhd.drv %58, %gen_buffs_0.gen_bits_26.u_prim_buf.out_o after %1 : i1
    %59 = comb.extract %165 from 27 : (i32) -> i1
    %60 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-5_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_27.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_27.u_prim_buf" @prim_buf(in_i: %59: i1) -> (out_o: i1)
    llhd.drv %60, %gen_buffs_0.gen_bits_27.u_prim_buf.out_o after %1 : i1
    %61 = comb.extract %165 from 28 : (i32) -> i1
    %62 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-4_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_28.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_28.u_prim_buf" @prim_buf(in_i: %61: i1) -> (out_o: i1)
    llhd.drv %62, %gen_buffs_0.gen_bits_28.u_prim_buf.out_o after %1 : i1
    %63 = comb.extract %165 from 29 : (i32) -> i1
    %64 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-3_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_29.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_29.u_prim_buf" @prim_buf(in_i: %63: i1) -> (out_o: i1)
    llhd.drv %64, %gen_buffs_0.gen_bits_29.u_prim_buf.out_o after %1 : i1
    %65 = comb.extract %165 from 30 : (i32) -> i1
    %66 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-2_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_30.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_30.u_prim_buf" @prim_buf(in_i: %65: i1) -> (out_o: i1)
    llhd.drv %66, %gen_buffs_0.gen_bits_30.u_prim_buf.out_o after %1 : i1
    %67 = comb.extract %165 from 31 : (i32) -> i1
    %68 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-1_i5 : <i32> -> <i1>
    %gen_buffs_0.gen_bits_31.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_31.u_prim_buf" @prim_buf(in_i: %67: i1) -> (out_o: i1)
    llhd.drv %68, %gen_buffs_0.gen_bits_31.u_prim_buf.out_o after %1 : i1
    %69 = llhd.sig.extract %gen_buffs_1.mubi_out from %c0_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_0.u_prim_buf" @prim_buf(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %69, %gen_buffs_1.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %70 = llhd.sig.extract %gen_buffs_1.mubi_out from %c1_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_1.u_prim_buf" @prim_buf(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %70, %gen_buffs_1.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %71 = llhd.sig.extract %gen_buffs_1.mubi_out from %c2_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_2.u_prim_buf" @prim_buf(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %71, %gen_buffs_1.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %72 = llhd.sig.extract %gen_buffs_1.mubi_out from %c3_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_3.u_prim_buf" @prim_buf(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %72, %gen_buffs_1.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %73 = llhd.sig.extract %gen_buffs_1.mubi_out from %c4_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_4.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_4.u_prim_buf" @prim_buf(in_i: %13: i1) -> (out_o: i1)
    llhd.drv %73, %gen_buffs_1.gen_bits_4.u_prim_buf.out_o after %1 : i1
    %74 = llhd.sig.extract %gen_buffs_1.mubi_out from %c5_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_5.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_5.u_prim_buf" @prim_buf(in_i: %15: i1) -> (out_o: i1)
    llhd.drv %74, %gen_buffs_1.gen_bits_5.u_prim_buf.out_o after %1 : i1
    %75 = llhd.sig.extract %gen_buffs_1.mubi_out from %c6_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_6.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_6.u_prim_buf" @prim_buf(in_i: %17: i1) -> (out_o: i1)
    llhd.drv %75, %gen_buffs_1.gen_bits_6.u_prim_buf.out_o after %1 : i1
    %76 = llhd.sig.extract %gen_buffs_1.mubi_out from %c7_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_7.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_7.u_prim_buf" @prim_buf(in_i: %19: i1) -> (out_o: i1)
    llhd.drv %76, %gen_buffs_1.gen_bits_7.u_prim_buf.out_o after %1 : i1
    %77 = llhd.sig.extract %gen_buffs_1.mubi_out from %c8_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_8.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_8.u_prim_buf" @prim_buf(in_i: %21: i1) -> (out_o: i1)
    llhd.drv %77, %gen_buffs_1.gen_bits_8.u_prim_buf.out_o after %1 : i1
    %78 = llhd.sig.extract %gen_buffs_1.mubi_out from %c9_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_9.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_9.u_prim_buf" @prim_buf(in_i: %23: i1) -> (out_o: i1)
    llhd.drv %78, %gen_buffs_1.gen_bits_9.u_prim_buf.out_o after %1 : i1
    %79 = llhd.sig.extract %gen_buffs_1.mubi_out from %c10_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_10.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_10.u_prim_buf" @prim_buf(in_i: %25: i1) -> (out_o: i1)
    llhd.drv %79, %gen_buffs_1.gen_bits_10.u_prim_buf.out_o after %1 : i1
    %80 = llhd.sig.extract %gen_buffs_1.mubi_out from %c11_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_11.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_11.u_prim_buf" @prim_buf(in_i: %27: i1) -> (out_o: i1)
    llhd.drv %80, %gen_buffs_1.gen_bits_11.u_prim_buf.out_o after %1 : i1
    %81 = llhd.sig.extract %gen_buffs_1.mubi_out from %c12_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_12.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_12.u_prim_buf" @prim_buf(in_i: %29: i1) -> (out_o: i1)
    llhd.drv %81, %gen_buffs_1.gen_bits_12.u_prim_buf.out_o after %1 : i1
    %82 = llhd.sig.extract %gen_buffs_1.mubi_out from %c13_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_13.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_13.u_prim_buf" @prim_buf(in_i: %31: i1) -> (out_o: i1)
    llhd.drv %82, %gen_buffs_1.gen_bits_13.u_prim_buf.out_o after %1 : i1
    %83 = llhd.sig.extract %gen_buffs_1.mubi_out from %c14_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_14.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_14.u_prim_buf" @prim_buf(in_i: %33: i1) -> (out_o: i1)
    llhd.drv %83, %gen_buffs_1.gen_bits_14.u_prim_buf.out_o after %1 : i1
    %84 = llhd.sig.extract %gen_buffs_1.mubi_out from %c15_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_15.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_15.u_prim_buf" @prim_buf(in_i: %35: i1) -> (out_o: i1)
    llhd.drv %84, %gen_buffs_1.gen_bits_15.u_prim_buf.out_o after %1 : i1
    %85 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-16_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_16.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_16.u_prim_buf" @prim_buf(in_i: %37: i1) -> (out_o: i1)
    llhd.drv %85, %gen_buffs_1.gen_bits_16.u_prim_buf.out_o after %1 : i1
    %86 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-15_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_17.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_17.u_prim_buf" @prim_buf(in_i: %39: i1) -> (out_o: i1)
    llhd.drv %86, %gen_buffs_1.gen_bits_17.u_prim_buf.out_o after %1 : i1
    %87 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-14_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_18.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_18.u_prim_buf" @prim_buf(in_i: %41: i1) -> (out_o: i1)
    llhd.drv %87, %gen_buffs_1.gen_bits_18.u_prim_buf.out_o after %1 : i1
    %88 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-13_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_19.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_19.u_prim_buf" @prim_buf(in_i: %43: i1) -> (out_o: i1)
    llhd.drv %88, %gen_buffs_1.gen_bits_19.u_prim_buf.out_o after %1 : i1
    %89 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-12_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_20.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_20.u_prim_buf" @prim_buf(in_i: %45: i1) -> (out_o: i1)
    llhd.drv %89, %gen_buffs_1.gen_bits_20.u_prim_buf.out_o after %1 : i1
    %90 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-11_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_21.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_21.u_prim_buf" @prim_buf(in_i: %47: i1) -> (out_o: i1)
    llhd.drv %90, %gen_buffs_1.gen_bits_21.u_prim_buf.out_o after %1 : i1
    %91 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-10_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_22.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_22.u_prim_buf" @prim_buf(in_i: %49: i1) -> (out_o: i1)
    llhd.drv %91, %gen_buffs_1.gen_bits_22.u_prim_buf.out_o after %1 : i1
    %92 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-9_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_23.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_23.u_prim_buf" @prim_buf(in_i: %51: i1) -> (out_o: i1)
    llhd.drv %92, %gen_buffs_1.gen_bits_23.u_prim_buf.out_o after %1 : i1
    %93 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-8_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_24.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_24.u_prim_buf" @prim_buf(in_i: %53: i1) -> (out_o: i1)
    llhd.drv %93, %gen_buffs_1.gen_bits_24.u_prim_buf.out_o after %1 : i1
    %94 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-7_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_25.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_25.u_prim_buf" @prim_buf(in_i: %55: i1) -> (out_o: i1)
    llhd.drv %94, %gen_buffs_1.gen_bits_25.u_prim_buf.out_o after %1 : i1
    %95 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-6_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_26.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_26.u_prim_buf" @prim_buf(in_i: %57: i1) -> (out_o: i1)
    llhd.drv %95, %gen_buffs_1.gen_bits_26.u_prim_buf.out_o after %1 : i1
    %96 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-5_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_27.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_27.u_prim_buf" @prim_buf(in_i: %59: i1) -> (out_o: i1)
    llhd.drv %96, %gen_buffs_1.gen_bits_27.u_prim_buf.out_o after %1 : i1
    %97 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-4_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_28.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_28.u_prim_buf" @prim_buf(in_i: %61: i1) -> (out_o: i1)
    llhd.drv %97, %gen_buffs_1.gen_bits_28.u_prim_buf.out_o after %1 : i1
    %98 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-3_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_29.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_29.u_prim_buf" @prim_buf(in_i: %63: i1) -> (out_o: i1)
    llhd.drv %98, %gen_buffs_1.gen_bits_29.u_prim_buf.out_o after %1 : i1
    %99 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-2_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_30.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_30.u_prim_buf" @prim_buf(in_i: %65: i1) -> (out_o: i1)
    llhd.drv %99, %gen_buffs_1.gen_bits_30.u_prim_buf.out_o after %1 : i1
    %100 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-1_i5 : <i32> -> <i1>
    %gen_buffs_1.gen_bits_31.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_31.u_prim_buf" @prim_buf(in_i: %67: i1) -> (out_o: i1)
    llhd.drv %100, %gen_buffs_1.gen_bits_31.u_prim_buf.out_o after %1 : i1
    %101 = llhd.sig.extract %gen_buffs_2.mubi_out from %c0_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_0.u_prim_buf" @prim_buf(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %101, %gen_buffs_2.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %102 = llhd.sig.extract %gen_buffs_2.mubi_out from %c1_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_1.u_prim_buf" @prim_buf(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %102, %gen_buffs_2.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %103 = llhd.sig.extract %gen_buffs_2.mubi_out from %c2_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_2.u_prim_buf" @prim_buf(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %103, %gen_buffs_2.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %104 = llhd.sig.extract %gen_buffs_2.mubi_out from %c3_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_3.u_prim_buf" @prim_buf(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %104, %gen_buffs_2.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %105 = llhd.sig.extract %gen_buffs_2.mubi_out from %c4_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_4.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_4.u_prim_buf" @prim_buf(in_i: %13: i1) -> (out_o: i1)
    llhd.drv %105, %gen_buffs_2.gen_bits_4.u_prim_buf.out_o after %1 : i1
    %106 = llhd.sig.extract %gen_buffs_2.mubi_out from %c5_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_5.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_5.u_prim_buf" @prim_buf(in_i: %15: i1) -> (out_o: i1)
    llhd.drv %106, %gen_buffs_2.gen_bits_5.u_prim_buf.out_o after %1 : i1
    %107 = llhd.sig.extract %gen_buffs_2.mubi_out from %c6_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_6.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_6.u_prim_buf" @prim_buf(in_i: %17: i1) -> (out_o: i1)
    llhd.drv %107, %gen_buffs_2.gen_bits_6.u_prim_buf.out_o after %1 : i1
    %108 = llhd.sig.extract %gen_buffs_2.mubi_out from %c7_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_7.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_7.u_prim_buf" @prim_buf(in_i: %19: i1) -> (out_o: i1)
    llhd.drv %108, %gen_buffs_2.gen_bits_7.u_prim_buf.out_o after %1 : i1
    %109 = llhd.sig.extract %gen_buffs_2.mubi_out from %c8_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_8.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_8.u_prim_buf" @prim_buf(in_i: %21: i1) -> (out_o: i1)
    llhd.drv %109, %gen_buffs_2.gen_bits_8.u_prim_buf.out_o after %1 : i1
    %110 = llhd.sig.extract %gen_buffs_2.mubi_out from %c9_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_9.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_9.u_prim_buf" @prim_buf(in_i: %23: i1) -> (out_o: i1)
    llhd.drv %110, %gen_buffs_2.gen_bits_9.u_prim_buf.out_o after %1 : i1
    %111 = llhd.sig.extract %gen_buffs_2.mubi_out from %c10_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_10.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_10.u_prim_buf" @prim_buf(in_i: %25: i1) -> (out_o: i1)
    llhd.drv %111, %gen_buffs_2.gen_bits_10.u_prim_buf.out_o after %1 : i1
    %112 = llhd.sig.extract %gen_buffs_2.mubi_out from %c11_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_11.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_11.u_prim_buf" @prim_buf(in_i: %27: i1) -> (out_o: i1)
    llhd.drv %112, %gen_buffs_2.gen_bits_11.u_prim_buf.out_o after %1 : i1
    %113 = llhd.sig.extract %gen_buffs_2.mubi_out from %c12_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_12.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_12.u_prim_buf" @prim_buf(in_i: %29: i1) -> (out_o: i1)
    llhd.drv %113, %gen_buffs_2.gen_bits_12.u_prim_buf.out_o after %1 : i1
    %114 = llhd.sig.extract %gen_buffs_2.mubi_out from %c13_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_13.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_13.u_prim_buf" @prim_buf(in_i: %31: i1) -> (out_o: i1)
    llhd.drv %114, %gen_buffs_2.gen_bits_13.u_prim_buf.out_o after %1 : i1
    %115 = llhd.sig.extract %gen_buffs_2.mubi_out from %c14_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_14.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_14.u_prim_buf" @prim_buf(in_i: %33: i1) -> (out_o: i1)
    llhd.drv %115, %gen_buffs_2.gen_bits_14.u_prim_buf.out_o after %1 : i1
    %116 = llhd.sig.extract %gen_buffs_2.mubi_out from %c15_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_15.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_15.u_prim_buf" @prim_buf(in_i: %35: i1) -> (out_o: i1)
    llhd.drv %116, %gen_buffs_2.gen_bits_15.u_prim_buf.out_o after %1 : i1
    %117 = llhd.sig.extract %gen_buffs_2.mubi_out from %c-16_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_16.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_16.u_prim_buf" @prim_buf(in_i: %37: i1) -> (out_o: i1)
    llhd.drv %117, %gen_buffs_2.gen_bits_16.u_prim_buf.out_o after %1 : i1
    %118 = llhd.sig.extract %gen_buffs_2.mubi_out from %c-15_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_17.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_17.u_prim_buf" @prim_buf(in_i: %39: i1) -> (out_o: i1)
    llhd.drv %118, %gen_buffs_2.gen_bits_17.u_prim_buf.out_o after %1 : i1
    %119 = llhd.sig.extract %gen_buffs_2.mubi_out from %c-14_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_18.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_18.u_prim_buf" @prim_buf(in_i: %41: i1) -> (out_o: i1)
    llhd.drv %119, %gen_buffs_2.gen_bits_18.u_prim_buf.out_o after %1 : i1
    %120 = llhd.sig.extract %gen_buffs_2.mubi_out from %c-13_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_19.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_19.u_prim_buf" @prim_buf(in_i: %43: i1) -> (out_o: i1)
    llhd.drv %120, %gen_buffs_2.gen_bits_19.u_prim_buf.out_o after %1 : i1
    %121 = llhd.sig.extract %gen_buffs_2.mubi_out from %c-12_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_20.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_20.u_prim_buf" @prim_buf(in_i: %45: i1) -> (out_o: i1)
    llhd.drv %121, %gen_buffs_2.gen_bits_20.u_prim_buf.out_o after %1 : i1
    %122 = llhd.sig.extract %gen_buffs_2.mubi_out from %c-11_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_21.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_21.u_prim_buf" @prim_buf(in_i: %47: i1) -> (out_o: i1)
    llhd.drv %122, %gen_buffs_2.gen_bits_21.u_prim_buf.out_o after %1 : i1
    %123 = llhd.sig.extract %gen_buffs_2.mubi_out from %c-10_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_22.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_22.u_prim_buf" @prim_buf(in_i: %49: i1) -> (out_o: i1)
    llhd.drv %123, %gen_buffs_2.gen_bits_22.u_prim_buf.out_o after %1 : i1
    %124 = llhd.sig.extract %gen_buffs_2.mubi_out from %c-9_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_23.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_23.u_prim_buf" @prim_buf(in_i: %51: i1) -> (out_o: i1)
    llhd.drv %124, %gen_buffs_2.gen_bits_23.u_prim_buf.out_o after %1 : i1
    %125 = llhd.sig.extract %gen_buffs_2.mubi_out from %c-8_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_24.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_24.u_prim_buf" @prim_buf(in_i: %53: i1) -> (out_o: i1)
    llhd.drv %125, %gen_buffs_2.gen_bits_24.u_prim_buf.out_o after %1 : i1
    %126 = llhd.sig.extract %gen_buffs_2.mubi_out from %c-7_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_25.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_25.u_prim_buf" @prim_buf(in_i: %55: i1) -> (out_o: i1)
    llhd.drv %126, %gen_buffs_2.gen_bits_25.u_prim_buf.out_o after %1 : i1
    %127 = llhd.sig.extract %gen_buffs_2.mubi_out from %c-6_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_26.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_26.u_prim_buf" @prim_buf(in_i: %57: i1) -> (out_o: i1)
    llhd.drv %127, %gen_buffs_2.gen_bits_26.u_prim_buf.out_o after %1 : i1
    %128 = llhd.sig.extract %gen_buffs_2.mubi_out from %c-5_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_27.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_27.u_prim_buf" @prim_buf(in_i: %59: i1) -> (out_o: i1)
    llhd.drv %128, %gen_buffs_2.gen_bits_27.u_prim_buf.out_o after %1 : i1
    %129 = llhd.sig.extract %gen_buffs_2.mubi_out from %c-4_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_28.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_28.u_prim_buf" @prim_buf(in_i: %61: i1) -> (out_o: i1)
    llhd.drv %129, %gen_buffs_2.gen_bits_28.u_prim_buf.out_o after %1 : i1
    %130 = llhd.sig.extract %gen_buffs_2.mubi_out from %c-3_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_29.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_29.u_prim_buf" @prim_buf(in_i: %63: i1) -> (out_o: i1)
    llhd.drv %130, %gen_buffs_2.gen_bits_29.u_prim_buf.out_o after %1 : i1
    %131 = llhd.sig.extract %gen_buffs_2.mubi_out from %c-2_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_30.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_30.u_prim_buf" @prim_buf(in_i: %65: i1) -> (out_o: i1)
    llhd.drv %131, %gen_buffs_2.gen_bits_30.u_prim_buf.out_o after %1 : i1
    %132 = llhd.sig.extract %gen_buffs_2.mubi_out from %c-1_i5 : <i32> -> <i1>
    %gen_buffs_2.gen_bits_31.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_31.u_prim_buf" @prim_buf(in_i: %67: i1) -> (out_o: i1)
    llhd.drv %132, %gen_buffs_2.gen_bits_31.u_prim_buf.out_o after %1 : i1
    %133 = llhd.sig.extract %gen_buffs_3.mubi_out from %c0_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_0.u_prim_buf" @prim_buf(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %133, %gen_buffs_3.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %134 = llhd.sig.extract %gen_buffs_3.mubi_out from %c1_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_1.u_prim_buf" @prim_buf(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %134, %gen_buffs_3.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %135 = llhd.sig.extract %gen_buffs_3.mubi_out from %c2_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_2.u_prim_buf" @prim_buf(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %135, %gen_buffs_3.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %136 = llhd.sig.extract %gen_buffs_3.mubi_out from %c3_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_3.u_prim_buf" @prim_buf(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %136, %gen_buffs_3.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %137 = llhd.sig.extract %gen_buffs_3.mubi_out from %c4_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_4.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_4.u_prim_buf" @prim_buf(in_i: %13: i1) -> (out_o: i1)
    llhd.drv %137, %gen_buffs_3.gen_bits_4.u_prim_buf.out_o after %1 : i1
    %138 = llhd.sig.extract %gen_buffs_3.mubi_out from %c5_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_5.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_5.u_prim_buf" @prim_buf(in_i: %15: i1) -> (out_o: i1)
    llhd.drv %138, %gen_buffs_3.gen_bits_5.u_prim_buf.out_o after %1 : i1
    %139 = llhd.sig.extract %gen_buffs_3.mubi_out from %c6_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_6.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_6.u_prim_buf" @prim_buf(in_i: %17: i1) -> (out_o: i1)
    llhd.drv %139, %gen_buffs_3.gen_bits_6.u_prim_buf.out_o after %1 : i1
    %140 = llhd.sig.extract %gen_buffs_3.mubi_out from %c7_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_7.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_7.u_prim_buf" @prim_buf(in_i: %19: i1) -> (out_o: i1)
    llhd.drv %140, %gen_buffs_3.gen_bits_7.u_prim_buf.out_o after %1 : i1
    %141 = llhd.sig.extract %gen_buffs_3.mubi_out from %c8_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_8.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_8.u_prim_buf" @prim_buf(in_i: %21: i1) -> (out_o: i1)
    llhd.drv %141, %gen_buffs_3.gen_bits_8.u_prim_buf.out_o after %1 : i1
    %142 = llhd.sig.extract %gen_buffs_3.mubi_out from %c9_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_9.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_9.u_prim_buf" @prim_buf(in_i: %23: i1) -> (out_o: i1)
    llhd.drv %142, %gen_buffs_3.gen_bits_9.u_prim_buf.out_o after %1 : i1
    %143 = llhd.sig.extract %gen_buffs_3.mubi_out from %c10_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_10.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_10.u_prim_buf" @prim_buf(in_i: %25: i1) -> (out_o: i1)
    llhd.drv %143, %gen_buffs_3.gen_bits_10.u_prim_buf.out_o after %1 : i1
    %144 = llhd.sig.extract %gen_buffs_3.mubi_out from %c11_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_11.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_11.u_prim_buf" @prim_buf(in_i: %27: i1) -> (out_o: i1)
    llhd.drv %144, %gen_buffs_3.gen_bits_11.u_prim_buf.out_o after %1 : i1
    %145 = llhd.sig.extract %gen_buffs_3.mubi_out from %c12_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_12.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_12.u_prim_buf" @prim_buf(in_i: %29: i1) -> (out_o: i1)
    llhd.drv %145, %gen_buffs_3.gen_bits_12.u_prim_buf.out_o after %1 : i1
    %146 = llhd.sig.extract %gen_buffs_3.mubi_out from %c13_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_13.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_13.u_prim_buf" @prim_buf(in_i: %31: i1) -> (out_o: i1)
    llhd.drv %146, %gen_buffs_3.gen_bits_13.u_prim_buf.out_o after %1 : i1
    %147 = llhd.sig.extract %gen_buffs_3.mubi_out from %c14_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_14.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_14.u_prim_buf" @prim_buf(in_i: %33: i1) -> (out_o: i1)
    llhd.drv %147, %gen_buffs_3.gen_bits_14.u_prim_buf.out_o after %1 : i1
    %148 = llhd.sig.extract %gen_buffs_3.mubi_out from %c15_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_15.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_15.u_prim_buf" @prim_buf(in_i: %35: i1) -> (out_o: i1)
    llhd.drv %148, %gen_buffs_3.gen_bits_15.u_prim_buf.out_o after %1 : i1
    %149 = llhd.sig.extract %gen_buffs_3.mubi_out from %c-16_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_16.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_16.u_prim_buf" @prim_buf(in_i: %37: i1) -> (out_o: i1)
    llhd.drv %149, %gen_buffs_3.gen_bits_16.u_prim_buf.out_o after %1 : i1
    %150 = llhd.sig.extract %gen_buffs_3.mubi_out from %c-15_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_17.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_17.u_prim_buf" @prim_buf(in_i: %39: i1) -> (out_o: i1)
    llhd.drv %150, %gen_buffs_3.gen_bits_17.u_prim_buf.out_o after %1 : i1
    %151 = llhd.sig.extract %gen_buffs_3.mubi_out from %c-14_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_18.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_18.u_prim_buf" @prim_buf(in_i: %41: i1) -> (out_o: i1)
    llhd.drv %151, %gen_buffs_3.gen_bits_18.u_prim_buf.out_o after %1 : i1
    %152 = llhd.sig.extract %gen_buffs_3.mubi_out from %c-13_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_19.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_19.u_prim_buf" @prim_buf(in_i: %43: i1) -> (out_o: i1)
    llhd.drv %152, %gen_buffs_3.gen_bits_19.u_prim_buf.out_o after %1 : i1
    %153 = llhd.sig.extract %gen_buffs_3.mubi_out from %c-12_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_20.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_20.u_prim_buf" @prim_buf(in_i: %45: i1) -> (out_o: i1)
    llhd.drv %153, %gen_buffs_3.gen_bits_20.u_prim_buf.out_o after %1 : i1
    %154 = llhd.sig.extract %gen_buffs_3.mubi_out from %c-11_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_21.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_21.u_prim_buf" @prim_buf(in_i: %47: i1) -> (out_o: i1)
    llhd.drv %154, %gen_buffs_3.gen_bits_21.u_prim_buf.out_o after %1 : i1
    %155 = llhd.sig.extract %gen_buffs_3.mubi_out from %c-10_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_22.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_22.u_prim_buf" @prim_buf(in_i: %49: i1) -> (out_o: i1)
    llhd.drv %155, %gen_buffs_3.gen_bits_22.u_prim_buf.out_o after %1 : i1
    %156 = llhd.sig.extract %gen_buffs_3.mubi_out from %c-9_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_23.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_23.u_prim_buf" @prim_buf(in_i: %51: i1) -> (out_o: i1)
    llhd.drv %156, %gen_buffs_3.gen_bits_23.u_prim_buf.out_o after %1 : i1
    %157 = llhd.sig.extract %gen_buffs_3.mubi_out from %c-8_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_24.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_24.u_prim_buf" @prim_buf(in_i: %53: i1) -> (out_o: i1)
    llhd.drv %157, %gen_buffs_3.gen_bits_24.u_prim_buf.out_o after %1 : i1
    %158 = llhd.sig.extract %gen_buffs_3.mubi_out from %c-7_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_25.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_25.u_prim_buf" @prim_buf(in_i: %55: i1) -> (out_o: i1)
    llhd.drv %158, %gen_buffs_3.gen_bits_25.u_prim_buf.out_o after %1 : i1
    %159 = llhd.sig.extract %gen_buffs_3.mubi_out from %c-6_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_26.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_26.u_prim_buf" @prim_buf(in_i: %57: i1) -> (out_o: i1)
    llhd.drv %159, %gen_buffs_3.gen_bits_26.u_prim_buf.out_o after %1 : i1
    %160 = llhd.sig.extract %gen_buffs_3.mubi_out from %c-5_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_27.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_27.u_prim_buf" @prim_buf(in_i: %59: i1) -> (out_o: i1)
    llhd.drv %160, %gen_buffs_3.gen_bits_27.u_prim_buf.out_o after %1 : i1
    %161 = llhd.sig.extract %gen_buffs_3.mubi_out from %c-4_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_28.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_28.u_prim_buf" @prim_buf(in_i: %61: i1) -> (out_o: i1)
    llhd.drv %161, %gen_buffs_3.gen_bits_28.u_prim_buf.out_o after %1 : i1
    %162 = llhd.sig.extract %gen_buffs_3.mubi_out from %c-3_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_29.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_29.u_prim_buf" @prim_buf(in_i: %63: i1) -> (out_o: i1)
    llhd.drv %162, %gen_buffs_3.gen_bits_29.u_prim_buf.out_o after %1 : i1
    %163 = llhd.sig.extract %gen_buffs_3.mubi_out from %c-2_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_30.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_30.u_prim_buf" @prim_buf(in_i: %65: i1) -> (out_o: i1)
    llhd.drv %163, %gen_buffs_3.gen_bits_30.u_prim_buf.out_o after %1 : i1
    %164 = llhd.sig.extract %gen_buffs_3.mubi_out from %c-1_i5 : <i32> -> <i1>
    %gen_buffs_3.gen_bits_31.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_31.u_prim_buf" @prim_buf(in_i: %67: i1) -> (out_o: i1)
    llhd.drv %164, %gen_buffs_3.gen_bits_31.u_prim_buf.out_o after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %175 = llhd.prb %clk_i_0 : i1
      %176 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %177 = llhd.prb %clk_i_0 : i1
      %178 = comb.xor bin %175, %true : i1
      %179 = comb.and bin %178, %177 : i1
      %180 = llhd.prb %rst_ni_1 : i1
      %181 = comb.xor bin %180, %true : i1
      %182 = comb.and bin %176, %181 : i1
      %183 = comb.or bin %179, %182 : i1
      cf.cond_br %183, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %184 = llhd.prb %rst_ni_1 : i1
      %185 = comb.xor %184, %true : i1
      cf.cond_br %185, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_no_flops.unused_logic, %c1768515945_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %186 = llhd.prb %mubi_i_2 : i32
      llhd.drv %gen_no_flops.unused_logic, %186 after %0 : i32
      cf.br ^bb1
    }
    %165 = llhd.prb %mubi_i_2 {sv.namehint = "mubi"} : i32
    %166 = llhd.sig.array_get %mubi_o[%c0_i2] : <!hw.array<4xi32>>
    %167 = llhd.prb %gen_buffs_0.mubi_out : i32
    llhd.drv %166, %167 after %1 : i32
    %168 = llhd.sig.array_get %mubi_o[%c1_i2] : <!hw.array<4xi32>>
    %169 = llhd.prb %gen_buffs_1.mubi_out : i32
    llhd.drv %168, %169 after %1 : i32
    %170 = llhd.sig.array_get %mubi_o[%c-2_i2] : <!hw.array<4xi32>>
    %171 = llhd.prb %gen_buffs_2.mubi_out : i32
    llhd.drv %170, %171 after %1 : i32
    %172 = llhd.sig.array_get %mubi_o[%c-1_i2] : <!hw.array<4xi32>>
    %173 = llhd.prb %gen_buffs_3.mubi_out : i32
    llhd.drv %172, %173 after %1 : i32
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %mubi_i_2, %mubi_i after %1 : i32
    %174 = llhd.prb %mubi_o : !hw.array<4xi32>
    hw.output %174 : !hw.array<4xi32>
  }
  func.func private @"lc_ctrl_pkg::lc_to_mubi4"(%arg0: i4) -> i4 {
    %c3_i4 = hw.constant 3 : i4
    %0 = comb.xor %arg0, %c3_i4 : i4
    return %0 : i4
  }
  func.func private @"lc_ctrl_pkg::lc_tx_test_true_strict"(%arg0: i4) -> i1 {
    %c5_i4 = hw.constant 5 : i4
    %0 = comb.icmp eq %arg0, %c5_i4 : i4
    return %0 : i1
  }
  func.func private @"lc_ctrl_pkg::lc_tx_test_false_strict"(%arg0: i4) -> i1 {
    %c-6_i4 = hw.constant -6 : i4
    %0 = comb.icmp eq %arg0, %c-6_i4 : i4
    return %0 : i1
  }
  func.func private @"lc_ctrl_pkg::lc_tx_test_true_loose"(%arg0: i4) -> i1 {
    %c-6_i4 = hw.constant -6 : i4
    %0 = comb.icmp ne %arg0, %c-6_i4 : i4
    return %0 : i1
  }
  func.func private @"lc_ctrl_pkg::lc_tx_test_false_loose"(%arg0: i4) -> i1 {
    %c5_i4 = hw.constant 5 : i4
    %0 = comb.icmp ne %arg0, %c5_i4 : i4
    return %0 : i1
  }
  func.func private @"lc_ctrl_pkg::lc_tx_or"(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c-1_i2 = hw.constant -1 : i2
    %c0_i30 = hw.constant 0 : i30
    %c-1_i4 = hw.constant -1 : i4
    %c0_i28 = hw.constant 0 : i28
    %c1_i32 = hw.constant 1 : i32
    %c4_i32 = hw.constant 4 : i32
    %c0_i32 = hw.constant 0 : i32
    %c0_i4 = hw.constant 0 : i4
    %out = llhd.sig %c0_i4 : i4
    cf.br ^bb1(%c0_i32 : i32)
  ^bb1(%1: i32):  // 2 preds: ^bb0, ^bb5
    %2 = comb.icmp slt %1, %c4_i32 : i32
    cf.cond_br %2, ^bb2, ^bb6
  ^bb2:  // pred: ^bb1
    %3 = comb.extract %1 from 4 : (i32) -> i28
    %4 = comb.icmp eq %3, %c0_i28 : i28
    %5 = comb.extract %1 from 0 : (i32) -> i4
    %6 = comb.mux %4, %5, %c-1_i4 : i4
    %7 = comb.shru %arg2, %6 : i4
    %8 = comb.extract %7 from 0 : (i4) -> i1
    cf.cond_br %8, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    %9 = comb.extract %1 from 2 : (i32) -> i30
    %10 = comb.icmp eq %9, %c0_i30 : i30
    %11 = comb.extract %1 from 0 : (i32) -> i2
    %12 = comb.mux %10, %11, %c-1_i2 : i2
    %13 = llhd.sig.extract %out from %12 : <i4> -> <i1>
    %14 = comb.shru %arg0, %6 : i4
    %15 = comb.extract %14 from 0 : (i4) -> i1
    %16 = comb.shru %arg1, %6 : i4
    %17 = comb.extract %16 from 0 : (i4) -> i1
    %18 = comb.or %15, %17 : i1
    llhd.drv %13, %18 after %0 : i1
    cf.br ^bb5
  ^bb4:  // pred: ^bb2
    %19 = comb.extract %1 from 2 : (i32) -> i30
    %20 = comb.icmp eq %19, %c0_i30 : i30
    %21 = comb.extract %1 from 0 : (i32) -> i2
    %22 = comb.mux %20, %21, %c-1_i2 : i2
    %23 = llhd.sig.extract %out from %22 : <i4> -> <i1>
    %24 = comb.shru %arg0, %6 : i4
    %25 = comb.extract %24 from 0 : (i4) -> i1
    %26 = comb.shru %arg1, %6 : i4
    %27 = comb.extract %26 from 0 : (i4) -> i1
    %28 = comb.and %25, %27 : i1
    llhd.drv %23, %28 after %0 : i1
    cf.br ^bb5
  ^bb5:  // 2 preds: ^bb3, ^bb4
    %29 = comb.add %1, %c1_i32 : i32
    cf.br ^bb1(%29 : i32)
  ^bb6:  // pred: ^bb1
    %30 = llhd.prb %out : i4
    return %30 : i4
  }
  func.func private @"lc_ctrl_pkg::lc_tx_or_hi"(%arg0: i4, %arg1: i4) -> i4 {
    %c5_i4 = hw.constant 5 : i4
    %0 = call @"lc_ctrl_pkg::lc_tx_or"(%arg0, %arg1, %c5_i4) : (i4, i4, i4) -> i4
    return %0 : i4
  }
  hw.module private @prim_lc_sync(in %clk_i : i1, in %rst_ni : i1, in %lc_en_i : i4, out lc_en_o : !hw.array<1xi4>) {
    %c0_i0 = hw.constant 0 : i0
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %c0_i4 = hw.constant 0 : i4
    %1 = hw.aggregate_constant [0 : i4] : !hw.array<1xi4>
    %lc_en_o = llhd.sig %1 : !hw.array<1xi4>
    %gen_buffs_0.lc_en_out = llhd.sig %c0_i4 : i4
    %gen_flops.u_prim_flop_2sync.q_o = hw.instance "gen_flops.u_prim_flop_2sync" @prim_flop_2sync_6(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %lc_en_i: i4) -> (q_o: i4) {sv.namehint = "lc_en"}
    %2 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 0 : (i4) -> i1
    %3 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %3, %gen_buffs_0.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %4 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 1 : (i4) -> i1
    %5 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %5, %gen_buffs_0.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %6 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 2 : (i4) -> i1
    %7 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %7, %gen_buffs_0.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %8 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 3 : (i4) -> i1
    %9 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %9, %gen_buffs_0.gen_bits_3.u_prim_buf.out_o after %0 : i1
    %10 = llhd.sig.array_get %lc_en_o[%c0_i0] : <!hw.array<1xi4>>
    %11 = llhd.prb %gen_buffs_0.lc_en_out : i4
    llhd.drv %10, %11 after %0 : i4
    %12 = llhd.prb %lc_en_o : !hw.array<1xi4>
    hw.output %12 : !hw.array<1xi4>
  }
  hw.module private @prim_lc_sync_0(in %clk_i : i1, in %rst_ni : i1, in %lc_en_i : i4, out lc_en_o : !hw.array<5xi4>) {
    %c-4_i3 = hw.constant -4 : i3
    %c3_i3 = hw.constant 3 : i3
    %c2_i3 = hw.constant 2 : i3
    %c1_i3 = hw.constant 1 : i3
    %c0_i3 = hw.constant 0 : i3
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %2 = hw.aggregate_constant [0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4] : !hw.array<5xi4>
    %c0_i4 = hw.constant 0 : i4
    %c-6_i4 = hw.constant -6 : i4
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %lc_en_i_2 = llhd.sig name "lc_en_i" %c0_i4 : i4
    %lc_en_o = llhd.sig %2 : !hw.array<5xi4>
    %gen_no_flops.unused_logic = llhd.sig %c0_i4 : i4
    %gen_buffs_0.lc_en_out = llhd.sig %c0_i4 : i4
    %gen_buffs_1.lc_en_out = llhd.sig %c0_i4 : i4
    %gen_buffs_2.lc_en_out = llhd.sig %c0_i4 : i4
    %gen_buffs_3.lc_en_out = llhd.sig %c0_i4 : i4
    %gen_buffs_4.lc_en_out = llhd.sig %c0_i4 : i4
    %5 = comb.extract %29 from 0 : (i4) -> i1
    %6 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %6, %gen_buffs_0.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %7 = comb.extract %29 from 1 : (i4) -> i1
    %8 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %8, %gen_buffs_0.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %9 = comb.extract %29 from 2 : (i4) -> i1
    %10 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %10, %gen_buffs_0.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %11 = comb.extract %29 from 3 : (i4) -> i1
    %12 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %12, %gen_buffs_0.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %13 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %13, %gen_buffs_1.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %14 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %14, %gen_buffs_1.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %15 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %15, %gen_buffs_1.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %16 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %16, %gen_buffs_1.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %17 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %17, %gen_buffs_2.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %18 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %18, %gen_buffs_2.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %19 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %19, %gen_buffs_2.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %20 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %20, %gen_buffs_2.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %21 = llhd.sig.extract %gen_buffs_3.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %21, %gen_buffs_3.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %22 = llhd.sig.extract %gen_buffs_3.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %22, %gen_buffs_3.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %23 = llhd.sig.extract %gen_buffs_3.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %23, %gen_buffs_3.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %24 = llhd.sig.extract %gen_buffs_3.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %24, %gen_buffs_3.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %25 = llhd.sig.extract %gen_buffs_4.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_4.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_4.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %25, %gen_buffs_4.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %26 = llhd.sig.extract %gen_buffs_4.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_4.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_4.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %26, %gen_buffs_4.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %27 = llhd.sig.extract %gen_buffs_4.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_4.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_4.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %27, %gen_buffs_4.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %28 = llhd.sig.extract %gen_buffs_4.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_4.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_4.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %28, %gen_buffs_4.gen_bits_3.u_prim_buf.out_o after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %41 = llhd.prb %clk_i_0 : i1
      %42 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %43 = llhd.prb %clk_i_0 : i1
      %44 = comb.xor bin %41, %true : i1
      %45 = comb.and bin %44, %43 : i1
      %46 = llhd.prb %rst_ni_1 : i1
      %47 = comb.xor bin %46, %true : i1
      %48 = comb.and bin %42, %47 : i1
      %49 = comb.or bin %45, %48 : i1
      cf.cond_br %49, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %50 = llhd.prb %rst_ni_1 : i1
      %51 = comb.xor %50, %true : i1
      cf.cond_br %51, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_no_flops.unused_logic, %c-6_i4 after %0 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %52 = llhd.prb %lc_en_i_2 : i4
      llhd.drv %gen_no_flops.unused_logic, %52 after %0 : i4
      cf.br ^bb1
    }
    %29 = llhd.prb %lc_en_i_2 {sv.namehint = "lc_en"} : i4
    %30 = llhd.sig.array_get %lc_en_o[%c0_i3] : <!hw.array<5xi4>>
    %31 = llhd.prb %gen_buffs_0.lc_en_out : i4
    llhd.drv %30, %31 after %1 : i4
    %32 = llhd.sig.array_get %lc_en_o[%c1_i3] : <!hw.array<5xi4>>
    %33 = llhd.prb %gen_buffs_1.lc_en_out : i4
    llhd.drv %32, %33 after %1 : i4
    %34 = llhd.sig.array_get %lc_en_o[%c2_i3] : <!hw.array<5xi4>>
    %35 = llhd.prb %gen_buffs_2.lc_en_out : i4
    llhd.drv %34, %35 after %1 : i4
    %36 = llhd.sig.array_get %lc_en_o[%c3_i3] : <!hw.array<5xi4>>
    %37 = llhd.prb %gen_buffs_3.lc_en_out : i4
    llhd.drv %36, %37 after %1 : i4
    %38 = llhd.sig.array_get %lc_en_o[%c-4_i3] : <!hw.array<5xi4>>
    %39 = llhd.prb %gen_buffs_4.lc_en_out : i4
    llhd.drv %38, %39 after %1 : i4
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %lc_en_i_2, %lc_en_i after %1 : i4
    %40 = llhd.prb %lc_en_o : !hw.array<5xi4>
    hw.output %40 : !hw.array<5xi4>
  }
  hw.module private @prim_lc_sync_2(in %clk_i : i1, in %rst_ni : i1, in %lc_en_i : i4, out lc_en_o : !hw.array<3xi4>) {
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %c0_i4 = hw.constant 0 : i4
    %1 = hw.aggregate_constant [0 : i4, 0 : i4, 0 : i4] : !hw.array<3xi4>
    %lc_en_o = llhd.sig %1 : !hw.array<3xi4>
    %gen_buffs_0.lc_en_out = llhd.sig %c0_i4 : i4
    %gen_buffs_1.lc_en_out = llhd.sig %c0_i4 : i4
    %gen_buffs_2.lc_en_out = llhd.sig %c0_i4 : i4
    %gen_flops.u_prim_flop_2sync.q_o = hw.instance "gen_flops.u_prim_flop_2sync" @prim_flop_2sync_6(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %lc_en_i: i4) -> (q_o: i4) {sv.namehint = "lc_en"}
    %2 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 0 : (i4) -> i1
    %3 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %3, %gen_buffs_0.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %4 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 1 : (i4) -> i1
    %5 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %5, %gen_buffs_0.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %6 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 2 : (i4) -> i1
    %7 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %7, %gen_buffs_0.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %8 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 3 : (i4) -> i1
    %9 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %9, %gen_buffs_0.gen_bits_3.u_prim_buf.out_o after %0 : i1
    %10 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %10, %gen_buffs_1.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %11 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %11, %gen_buffs_1.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %12 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %12, %gen_buffs_1.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %13 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %13, %gen_buffs_1.gen_bits_3.u_prim_buf.out_o after %0 : i1
    %14 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %14, %gen_buffs_2.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %15 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %15, %gen_buffs_2.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %16 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %16, %gen_buffs_2.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %17 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %17, %gen_buffs_2.gen_bits_3.u_prim_buf.out_o after %0 : i1
    %18 = llhd.sig.array_get %lc_en_o[%c0_i2] : <!hw.array<3xi4>>
    %19 = llhd.prb %gen_buffs_0.lc_en_out : i4
    llhd.drv %18, %19 after %0 : i4
    %20 = llhd.sig.array_get %lc_en_o[%c1_i2] : <!hw.array<3xi4>>
    %21 = llhd.prb %gen_buffs_1.lc_en_out : i4
    llhd.drv %20, %21 after %0 : i4
    %22 = llhd.sig.array_get %lc_en_o[%c-2_i2] : <!hw.array<3xi4>>
    %23 = llhd.prb %gen_buffs_2.lc_en_out : i4
    llhd.drv %22, %23 after %0 : i4
    %24 = llhd.prb %lc_en_o : !hw.array<3xi4>
    hw.output %24 : !hw.array<3xi4>
  }
  hw.module private @prim_lc_sync_9(in %clk_i : i1, in %rst_ni : i1, in %lc_en_i : i4, out lc_en_o : !hw.array<2xi4>) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %2 = hw.aggregate_constant [0 : i4, 0 : i4] : !hw.array<2xi4>
    %c0_i4 = hw.constant 0 : i4
    %c-6_i4 = hw.constant -6 : i4
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %lc_en_i_2 = llhd.sig name "lc_en_i" %c0_i4 : i4
    %lc_en_o = llhd.sig %2 : !hw.array<2xi4>
    %gen_no_flops.unused_logic = llhd.sig %c0_i4 : i4
    %gen_buffs_0.lc_en_out = llhd.sig %c0_i4 : i4
    %gen_buffs_1.lc_en_out = llhd.sig %c0_i4 : i4
    %5 = comb.extract %17 from 0 : (i4) -> i1
    %6 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %6, %gen_buffs_0.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %7 = comb.extract %17 from 1 : (i4) -> i1
    %8 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %8, %gen_buffs_0.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %9 = comb.extract %17 from 2 : (i4) -> i1
    %10 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %10, %gen_buffs_0.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %11 = comb.extract %17 from 3 : (i4) -> i1
    %12 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %12, %gen_buffs_0.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %13 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %13, %gen_buffs_1.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %14 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %14, %gen_buffs_1.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %15 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %15, %gen_buffs_1.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %16 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf_5(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %16, %gen_buffs_1.gen_bits_3.u_prim_buf.out_o after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %23 = llhd.prb %clk_i_0 : i1
      %24 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %25 = llhd.prb %clk_i_0 : i1
      %26 = comb.xor bin %23, %true : i1
      %27 = comb.and bin %26, %25 : i1
      %28 = llhd.prb %rst_ni_1 : i1
      %29 = comb.xor bin %28, %true : i1
      %30 = comb.and bin %24, %29 : i1
      %31 = comb.or bin %27, %30 : i1
      cf.cond_br %31, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %32 = llhd.prb %rst_ni_1 : i1
      %33 = comb.xor %32, %true : i1
      cf.cond_br %33, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_no_flops.unused_logic, %c-6_i4 after %0 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %34 = llhd.prb %lc_en_i_2 : i4
      llhd.drv %gen_no_flops.unused_logic, %34 after %0 : i4
      cf.br ^bb1
    }
    %17 = llhd.prb %lc_en_i_2 {sv.namehint = "lc_en"} : i4
    %18 = llhd.sig.array_get %lc_en_o[%false] : <!hw.array<2xi4>>
    %19 = llhd.prb %gen_buffs_0.lc_en_out : i4
    llhd.drv %18, %19 after %1 : i4
    %20 = llhd.sig.array_get %lc_en_o[%true] : <!hw.array<2xi4>>
    %21 = llhd.prb %gen_buffs_1.lc_en_out : i4
    llhd.drv %20, %21 after %1 : i4
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %lc_en_i_2, %lc_en_i after %1 : i4
    %22 = llhd.prb %lc_en_o : !hw.array<2xi4>
    hw.output %22 : !hw.array<2xi4>
  }
  hw.module private @prim_fifo_async_simple(in %clk_wr_i : i1, in %rst_wr_ni : i1, in %wvalid_i : i1, out wready_o : i1, in %wdata_i : i66, in %clk_rd_i : i1, in %rst_rd_ni : i1, out rvalid_o : i1, in %rready_i : i1, out rdata_o : i66) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i66 = hw.constant 0 : i66
    %true = hw.constant true
    %false = hw.constant false
    %clk_wr_i_0 = llhd.sig name "clk_wr_i" %false : i1
    %2 = llhd.prb %clk_wr_i_0 : i1
    %rst_wr_ni_1 = llhd.sig name "rst_wr_ni" %false : i1
    %3 = llhd.prb %rst_wr_ni_1 : i1
    %wdata_i_2 = llhd.sig name "wdata_i" %c0_i66 : i66
    %wr_en = llhd.sig %false : i1
    %pending_d = llhd.sig %false : i1
    %pending_q = llhd.sig %false : i1
    %not_in_reset_q = llhd.sig %false : i1
    %data_q = llhd.sig %c0_i66 : i66
    %u_prim_sync_reqack.src_ack_o, %u_prim_sync_reqack.dst_req_o = hw.instance "u_prim_sync_reqack" @prim_sync_reqack(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_rd_i: i1, rst_dst_ni: %rst_rd_ni: i1, req_chk_i: %false: i1, src_req_i: %9: i1, dst_ack_i: %14: i1) -> (src_ack_o: i1, dst_req_o: i1) {sv.namehint = "dst_req"}
    %4 = llhd.prb %pending_q : i1
    %5 = comb.xor %4, %true : i1
    %6 = llhd.prb %not_in_reset_q : i1
    %7 = comb.and %5, %6 : i1
    %8 = comb.and %wvalid_i, %7 : i1
    llhd.drv %wr_en, %8 after %1 : i1
    %9 = comb.or %4, %wvalid_i {sv.namehint = "src_req"} : i1
    %10 = llhd.prb %wr_en : i1
    %11 = comb.or %10, %4 : i1
    %12 = comb.xor %u_prim_sync_reqack.src_ack_o, %true : i1
    %13 = comb.and %12, %11 : i1
    llhd.drv %pending_d, %13 after %1 : i1
    %14 = comb.and %u_prim_sync_reqack.dst_req_o, %rready_i {sv.namehint = "dst_ack"} : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %16 = llhd.prb %clk_wr_i_0 : i1
      %17 = llhd.prb %rst_wr_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %18 = llhd.prb %clk_wr_i_0 : i1
      %19 = comb.xor bin %16, %true : i1
      %20 = comb.and bin %19, %18 : i1
      %21 = llhd.prb %rst_wr_ni_1 : i1
      %22 = comb.xor bin %21, %true : i1
      %23 = comb.and bin %17, %22 : i1
      %24 = comb.or bin %20, %23 : i1
      cf.cond_br %24, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %25 = llhd.prb %rst_wr_ni_1 : i1
      %26 = comb.xor %25, %true : i1
      cf.cond_br %26, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %pending_q, %false after %0 : i1
      llhd.drv %not_in_reset_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %27 = llhd.prb %pending_d : i1
      llhd.drv %pending_q, %27 after %0 : i1
      llhd.drv %not_in_reset_q, %true after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
      %16 = llhd.prb %clk_wr_i_0 : i1
      llhd.wait (%2 : i1), ^bb2
    ^bb2:  // pred: ^bb1
      %17 = llhd.prb %clk_wr_i_0 : i1
      %18 = comb.xor bin %16, %true : i1
      %19 = comb.and bin %18, %17 : i1
      cf.cond_br %19, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %20 = llhd.prb %wr_en : i1
      cf.cond_br %20, ^bb4, ^bb1
    ^bb4:  // pred: ^bb3
      %21 = llhd.prb %wdata_i_2 : i66
      llhd.drv %data_q, %21 after %0 : i66
      cf.br ^bb1
    }
    %15 = llhd.prb %data_q : i66
    llhd.drv %clk_wr_i_0, %clk_wr_i after %1 : i1
    llhd.drv %rst_wr_ni_1, %rst_wr_ni after %1 : i1
    llhd.drv %wdata_i_2, %wdata_i after %1 : i66
    hw.output %7, %u_prim_sync_reqack.dst_req_o, %15 : i1, i1, i66
  }
  hw.module private @prim_fifo_async_simple_21(in %clk_wr_i : i1, in %rst_wr_ni : i1, in %wvalid_i : i1, out wready_o : i1, in %wdata_i : i34, in %clk_rd_i : i1, in %rst_rd_ni : i1, out rvalid_o : i1, in %rready_i : i1, out rdata_o : i34) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i34 = hw.constant 0 : i34
    %true = hw.constant true
    %false = hw.constant false
    %clk_wr_i_0 = llhd.sig name "clk_wr_i" %false : i1
    %2 = llhd.prb %clk_wr_i_0 : i1
    %rst_wr_ni_1 = llhd.sig name "rst_wr_ni" %false : i1
    %3 = llhd.prb %rst_wr_ni_1 : i1
    %wdata_i_2 = llhd.sig name "wdata_i" %c0_i34 : i34
    %wr_en = llhd.sig %false : i1
    %pending_d = llhd.sig %false : i1
    %pending_q = llhd.sig %false : i1
    %not_in_reset_q = llhd.sig %false : i1
    %data_q = llhd.sig %c0_i34 : i34
    %u_prim_sync_reqack.src_ack_o, %u_prim_sync_reqack.dst_req_o = hw.instance "u_prim_sync_reqack" @prim_sync_reqack(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_rd_i: i1, rst_dst_ni: %rst_rd_ni: i1, req_chk_i: %false: i1, src_req_i: %9: i1, dst_ack_i: %14: i1) -> (src_ack_o: i1, dst_req_o: i1) {sv.namehint = "dst_req"}
    %4 = llhd.prb %pending_q : i1
    %5 = comb.xor %4, %true : i1
    %6 = llhd.prb %not_in_reset_q : i1
    %7 = comb.and %5, %6 : i1
    %8 = comb.and %wvalid_i, %7 : i1
    llhd.drv %wr_en, %8 after %1 : i1
    %9 = comb.or %4, %wvalid_i {sv.namehint = "src_req"} : i1
    %10 = llhd.prb %wr_en : i1
    %11 = comb.or %10, %4 : i1
    %12 = comb.xor %u_prim_sync_reqack.src_ack_o, %true : i1
    %13 = comb.and %12, %11 : i1
    llhd.drv %pending_d, %13 after %1 : i1
    %14 = comb.and %u_prim_sync_reqack.dst_req_o, %rready_i {sv.namehint = "dst_ack"} : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %16 = llhd.prb %clk_wr_i_0 : i1
      %17 = llhd.prb %rst_wr_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %18 = llhd.prb %clk_wr_i_0 : i1
      %19 = comb.xor bin %16, %true : i1
      %20 = comb.and bin %19, %18 : i1
      %21 = llhd.prb %rst_wr_ni_1 : i1
      %22 = comb.xor bin %21, %true : i1
      %23 = comb.and bin %17, %22 : i1
      %24 = comb.or bin %20, %23 : i1
      cf.cond_br %24, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %25 = llhd.prb %rst_wr_ni_1 : i1
      %26 = comb.xor %25, %true : i1
      cf.cond_br %26, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %pending_q, %false after %0 : i1
      llhd.drv %not_in_reset_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %27 = llhd.prb %pending_d : i1
      llhd.drv %pending_q, %27 after %0 : i1
      llhd.drv %not_in_reset_q, %true after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
      %16 = llhd.prb %clk_wr_i_0 : i1
      llhd.wait (%2 : i1), ^bb2
    ^bb2:  // pred: ^bb1
      %17 = llhd.prb %clk_wr_i_0 : i1
      %18 = comb.xor bin %16, %true : i1
      %19 = comb.and bin %18, %17 : i1
      cf.cond_br %19, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %20 = llhd.prb %wr_en : i1
      cf.cond_br %20, ^bb4, ^bb1
    ^bb4:  // pred: ^bb3
      %21 = llhd.prb %wdata_i_2 : i34
      llhd.drv %data_q, %21 after %0 : i34
      cf.br ^bb1
    }
    %15 = llhd.prb %data_q : i34
    llhd.drv %clk_wr_i_0, %clk_wr_i after %1 : i1
    llhd.drv %rst_wr_ni_1, %rst_wr_ni after %1 : i1
    llhd.drv %wdata_i_2, %wdata_i after %1 : i34
    hw.output %7, %u_prim_sync_reqack.dst_req_o, %15 : i1, i1, i34
  }
  func.func private @"dm::load"(%arg0: i3, %arg1: i5, %arg2: i5, %arg3: i12) -> i32 {
    %c3_i7 = hw.constant 3 : i7
    %0 = comb.concat %arg3, %arg2, %arg0, %arg1, %c3_i7 : i12, i5, i3, i5, i7
    return %0 : i32
  }
  func.func private @"dm::store"(%arg0: i3, %arg1: i5, %arg2: i5, %arg3: i12) -> i32 {
    %c35_i7 = hw.constant 35 : i7
    %0 = comb.extract %arg3 from 5 : (i12) -> i7
    %1 = comb.extract %arg3 from 0 : (i12) -> i5
    %2 = comb.concat %0, %arg1, %arg2, %arg0, %1, %c35_i7 : i7, i5, i5, i3, i5, i7
    return %2 : i32
  }
  func.func private @"dm::float_load"(%arg0: i3, %arg1: i5, %arg2: i5, %arg3: i12) -> i32 {
    %c7_i7 = hw.constant 7 : i7
    %0 = comb.concat %arg3, %arg2, %arg0, %arg1, %c7_i7 : i12, i5, i3, i5, i7
    return %0 : i32
  }
  func.func private @"dm::float_store"(%arg0: i3, %arg1: i5, %arg2: i5, %arg3: i12) -> i32 {
    %c39_i7 = hw.constant 39 : i7
    %0 = comb.extract %arg3 from 5 : (i12) -> i7
    %1 = comb.extract %arg3 from 0 : (i12) -> i5
    %2 = comb.concat %0, %arg1, %arg2, %arg0, %1, %c39_i7 : i7, i5, i5, i3, i5, i7
    return %2 : i32
  }
  func.func private @"dm::csrw"(%arg0: i12, %arg1: i5) -> i32 {
    %c4211_i15 = hw.constant 4211 : i15
    %0 = comb.concat %arg0, %arg1, %c4211_i15 : i12, i5, i15
    return %0 : i32
  }
  func.func private @"dm::csrr"(%arg0: i12, %arg1: i5) -> i32 {
    %c-13_i7 = hw.constant -13 : i7
    %c2_i8 = hw.constant 2 : i8
    %0 = comb.concat %arg0, %c2_i8, %arg1, %c-13_i7 : i12, i8, i5, i7
    return %0 : i32
  }
  hw.module private @dm_top(in %clk_i : i1, in %rst_ni : i1, in %next_dm_addr_i : i32, in %testmode_i : i1, out ndmreset_o : i1, in %ndmreset_ack_i : i1, out dmactive_o : i1, out debug_req_o : i1, in %unavailable_i : i1, in %hartinfo_i : !hw.array<1xstruct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>>, in %slave_req_i : i1, in %slave_we_i : i1, in %slave_addr_i : i32, in %slave_be_i : i4, in %slave_wdata_i : i32, out slave_rdata_o : i32, out slave_err_o : i1, out master_req_o : i1, out master_add_o : i32, out master_we_o : i1, out master_wdata_o : i32, out master_be_o : i4, in %master_gnt_i : i1, in %master_r_valid_i : i1, in %master_r_err_i : i1, in %master_r_other_err_i : i1, in %master_r_rdata_i : i32, in %dmi_rst_ni : i1, in %dmi_req_valid_i : i1, out dmi_req_ready_o : i1, in %dmi_req_i : !hw.struct<addr: i32, op: i2, data: i32>, out dmi_resp_valid_o : i1, in %dmi_resp_ready_i : i1, out dmi_resp_o : !hw.struct<data: i32, resp: i2>) {
    %i_dm_csrs.dmi_req_ready_o, %i_dm_csrs.dmi_resp_valid_o, %i_dm_csrs.dmi_resp_o, %i_dm_csrs.ndmreset_o, %i_dm_csrs.dmactive_o, %i_dm_csrs.hartsel_o, %i_dm_csrs.haltreq_o, %i_dm_csrs.resumereq_o, %i_dm_csrs.clear_resumeack_o, %i_dm_csrs.cmd_valid_o, %i_dm_csrs.cmd_o, %i_dm_csrs.progbuf_o, %i_dm_csrs.data_o, %i_dm_csrs.sbaddress_o, %i_dm_csrs.sbaddress_write_valid_o, %i_dm_csrs.sbreadonaddr_o, %i_dm_csrs.sbautoincrement_o, %i_dm_csrs.sbaccess_o, %i_dm_csrs.sbreadondata_o, %i_dm_csrs.sbdata_o, %i_dm_csrs.sbdata_read_valid_o, %i_dm_csrs.sbdata_write_valid_o = hw.instance "i_dm_csrs" @dm_csrs(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, next_dm_addr_i: %next_dm_addr_i: i32, testmode_i: %testmode_i: i1, dmi_rst_ni: %dmi_rst_ni: i1, dmi_req_valid_i: %dmi_req_valid_i: i1, dmi_req_i: %dmi_req_i: !hw.struct<addr: i32, op: i2, data: i32>, dmi_resp_ready_i: %dmi_resp_ready_i: i1, ndmreset_ack_i: %ndmreset_ack_i: i1, hartinfo_i: %hartinfo_i: !hw.array<1xstruct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>>, halted_i: %i_dm_mem.halted_o: i1, unavailable_i: %unavailable_i: i1, resumeack_i: %i_dm_mem.resuming_o: i1, cmderror_valid_i: %i_dm_mem.cmderror_valid_o: i1, cmderror_i: %i_dm_mem.cmderror_o: i3, cmdbusy_i: %i_dm_mem.cmdbusy_o: i1, data_i: %i_dm_mem.data_o: !hw.array<2xi32>, data_valid_i: %i_dm_mem.data_valid_o: i1, sbaddress_i: %i_dm_sba.sbaddress_o: i32, sbdata_i: %i_dm_sba.sbdata_o: i32, sbdata_valid_i: %i_dm_sba.sbdata_valid_o: i1, sbbusy_i: %i_dm_sba.sbbusy_o: i1, sberror_valid_i: %i_dm_sba.sberror_valid_o: i1, sberror_i: %i_dm_sba.sberror_o: i3) -> (dmi_req_ready_o: i1, dmi_resp_valid_o: i1, dmi_resp_o: !hw.struct<data: i32, resp: i2>, ndmreset_o: i1, dmactive_o: i1, hartsel_o: i20, haltreq_o: i1, resumereq_o: i1, clear_resumeack_o: i1, cmd_valid_o: i1, cmd_o: !hw.struct<cmdtype: i8, control: i24>, progbuf_o: !hw.array<8xi32>, data_o: !hw.array<2xi32>, sbaddress_o: i32, sbaddress_write_valid_o: i1, sbreadonaddr_o: i1, sbautoincrement_o: i1, sbaccess_o: i3, sbreadondata_o: i1, sbdata_o: i32, sbdata_read_valid_o: i1, sbdata_write_valid_o: i1) {sv.namehint = "cmd"}
    %i_dm_sba.master_req_o, %i_dm_sba.master_add_o, %i_dm_sba.master_we_o, %i_dm_sba.master_wdata_o, %i_dm_sba.master_be_o, %i_dm_sba.sbaddress_o, %i_dm_sba.sbdata_o, %i_dm_sba.sbdata_valid_o, %i_dm_sba.sbbusy_o, %i_dm_sba.sberror_valid_o, %i_dm_sba.sberror_o = hw.instance "i_dm_sba" @dm_sba(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, dmactive_i: %i_dm_csrs.dmactive_o: i1, master_gnt_i: %master_gnt_i: i1, master_r_valid_i: %master_r_valid_i: i1, master_r_err_i: %master_r_err_i: i1, master_r_other_err_i: %master_r_other_err_i: i1, master_r_rdata_i: %master_r_rdata_i: i32, sbaddress_i: %i_dm_csrs.sbaddress_o: i32, sbaddress_write_valid_i: %i_dm_csrs.sbaddress_write_valid_o: i1, sbreadonaddr_i: %i_dm_csrs.sbreadonaddr_o: i1, sbautoincrement_i: %i_dm_csrs.sbautoincrement_o: i1, sbaccess_i: %i_dm_csrs.sbaccess_o: i3, sbreadondata_i: %i_dm_csrs.sbreadondata_o: i1, sbdata_i: %i_dm_csrs.sbdata_o: i32, sbdata_read_valid_i: %i_dm_csrs.sbdata_read_valid_o: i1, sbdata_write_valid_i: %i_dm_csrs.sbdata_write_valid_o: i1) -> (master_req_o: i1, master_add_o: i32, master_we_o: i1, master_wdata_o: i32, master_be_o: i4, sbaddress_o: i32, sbdata_o: i32, sbdata_valid_o: i1, sbbusy_o: i1, sberror_valid_o: i1, sberror_o: i3) {sv.namehint = "sbbusy"}
    %i_dm_mem.debug_req_o, %i_dm_mem.halted_o, %i_dm_mem.resuming_o, %i_dm_mem.data_o, %i_dm_mem.data_valid_o, %i_dm_mem.cmderror_valid_o, %i_dm_mem.cmderror_o, %i_dm_mem.cmdbusy_o, %i_dm_mem.rdata_o, %i_dm_mem.err_o = hw.instance "i_dm_mem" @dm_mem(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, ndmreset_i: %i_dm_csrs.ndmreset_o: i1, hartsel_i: %i_dm_csrs.hartsel_o: i20, haltreq_i: %i_dm_csrs.haltreq_o: i1, resumereq_i: %i_dm_csrs.resumereq_o: i1, clear_resumeack_i: %i_dm_csrs.clear_resumeack_o: i1, progbuf_i: %i_dm_csrs.progbuf_o: !hw.array<8xi32>, data_i: %i_dm_csrs.data_o: !hw.array<2xi32>, cmd_valid_i: %i_dm_csrs.cmd_valid_o: i1, cmd_i: %i_dm_csrs.cmd_o: !hw.struct<cmdtype: i8, control: i24>, req_i: %slave_req_i: i1, we_i: %slave_we_i: i1, addr_i: %slave_addr_i: i32, wdata_i: %slave_wdata_i: i32, be_i: %slave_be_i: i4) -> (debug_req_o: i1, halted_o: i1, resuming_o: i1, data_o: !hw.array<2xi32>, data_valid_o: i1, cmderror_valid_o: i1, cmderror_o: i3, cmdbusy_o: i1, rdata_o: i32, err_o: i1) {sv.namehint = "halted"}
    hw.output %i_dm_csrs.ndmreset_o, %i_dm_csrs.dmactive_o, %i_dm_mem.debug_req_o, %i_dm_mem.rdata_o, %i_dm_mem.err_o, %i_dm_sba.master_req_o, %i_dm_sba.master_add_o, %i_dm_sba.master_we_o, %i_dm_sba.master_wdata_o, %i_dm_sba.master_be_o, %i_dm_csrs.dmi_req_ready_o, %i_dm_csrs.dmi_resp_valid_o, %i_dm_csrs.dmi_resp_o : i1, i1, i1, i32, i1, i1, i32, i1, i32, i4, i1, i1, !hw.struct<data: i32, resp: i2>
  }
  hw.module private @dm_csrs(in %clk_i : i1, in %rst_ni : i1, in %next_dm_addr_i : i32, in %testmode_i : i1, in %dmi_rst_ni : i1, in %dmi_req_valid_i : i1, out dmi_req_ready_o : i1, in %dmi_req_i : !hw.struct<addr: i32, op: i2, data: i32>, out dmi_resp_valid_o : i1, in %dmi_resp_ready_i : i1, out dmi_resp_o : !hw.struct<data: i32, resp: i2>, out ndmreset_o : i1, in %ndmreset_ack_i : i1, out dmactive_o : i1, in %hartinfo_i : !hw.array<1xstruct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>>, in %halted_i : i1, in %unavailable_i : i1, in %resumeack_i : i1, out hartsel_o : i20, out haltreq_o : i1, out resumereq_o : i1, out clear_resumeack_o : i1, out cmd_valid_o : i1, out cmd_o : !hw.struct<cmdtype: i8, control: i24>, in %cmderror_valid_i : i1, in %cmderror_i : i3, in %cmdbusy_i : i1, out progbuf_o : !hw.array<8xi32>, out data_o : !hw.array<2xi32>, in %data_i : !hw.array<2xi32>, in %data_valid_i : i1, out sbaddress_o : i32, in %sbaddress_i : i32, out sbaddress_write_valid_o : i1, out sbreadonaddr_o : i1, out sbautoincrement_o : i1, out sbaccess_o : i3, out sbreadondata_o : i1, out sbdata_o : i32, out sbdata_read_valid_o : i1, out sbdata_write_valid_o : i1, in %sbdata_i : i32, in %sbdata_valid_i : i1, in %sbbusy_i : i1, in %sberror_valid_i : i1, in %sberror_i : i3) {
    %0 = hw.aggregate_constant [0 : i3, 0 : i6, false, false, false, 2 : i3, false, false, 0 : i3, 0 : i7, false, false, false, false, false] : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
    %c-16_i5 = hw.constant -16 : i5
    %c40_i8 = hw.constant 40 : i8
    %c6_i8 = hw.constant 6 : i8
    %c-4_i4 = hw.constant -4 : i4
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %c-32_i6 = hw.constant -32 : i6
    %c-1_i3 = hw.constant -1 : i3
    %c0_i11 = hw.constant 0 : i11
    %c-1_i5 = hw.constant -1 : i5
    %c0_i27 = hw.constant 0 : i27
    %c0_i0 = hw.constant 0 : i0
    %2 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i8 = hw.constant 0 : i8
    %3 = hw.aggregate_constant [[0 : i8, 0 : i4, 0 : i3, false, 0 : i4, 0 : i12], [0 : i8, 0 : i4, 0 : i3, false, 0 : i4, 0 : i12]] : !hw.array<2xstruct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>>
    %4 = hw.aggregate_constant [0 : i32, 0 : i2] : !hw.struct<data: i32, resp: i2>
    %5 = hw.aggregate_constant [0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32] : !hw.array<8xi32>
    %6 = hw.aggregate_constant [0 : i3, 0 : i6, false, false, false, 0 : i3, false, false, 0 : i3, 0 : i7, false, false, false, false, false] : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
    %7 = hw.aggregate_constant [0 : i16, 0 : i4, 0 : i12] : !hw.struct<autoexecprogbuf: i16, zero0: i4, autoexecdata: i12>
    %8 = hw.aggregate_constant [0 : i8, 0 : i24] : !hw.struct<cmdtype: i8, control: i24>
    %9 = hw.aggregate_constant [0 : i3, 0 : i5, 0 : i11, false, false, 0 : i3, 0 : i4, 0 : i4] : !hw.struct<zero3: i3, progbufsize: i5, zero2: i11, busy: i1, zero1: i1, cmderr: i3, zero0: i4, datacount: i4>
    %10 = hw.aggregate_constant [false, false, false, false, false, false, 0 : i10, 0 : i10, 0 : i2, false, false, false, false] : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
    %11 = hw.aggregate_constant [0 : i9, false, 0 : i2, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, 0 : i4] : !hw.struct<zero1: i9, impebreak: i1, zero0: i2, allhavereset: i1, anyhavereset: i1, allresumeack: i1, anyresumeack: i1, allnonexistent: i1, anynonexistent: i1, allunavail: i1, anyunavail: i1, allrunning: i1, anyrunning: i1, allhalted: i1, anyhalted: i1, authenticated: i1, authbusy: i1, hasresethaltreq: i1, devtreevalid: i1, version: i4>
    %c0_i5 = hw.constant 0 : i5
    %c0_i15 = hw.constant 0 : i15
    %12 = hw.aggregate_constant [0 : i32] : !hw.array<1xi32>
    %13 = hw.aggregate_constant [0 : i32, 0 : i32] : !hw.array<2xi32>
    %c0_i20 = hw.constant 0 : i20
    %14 = hw.aggregate_constant [[0 : i8, 0 : i4, 0 : i3, false, 0 : i4, 0 : i12]] : !hw.array<1xstruct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>>
    %15 = hw.aggregate_constant [0 : i32, 0 : i2, 0 : i32] : !hw.struct<addr: i32, op: i2, data: i32>
    %c0_i10 = hw.constant 0 : i10
    %c0_i6 = hw.constant 0 : i6
    %c32_i7 = hw.constant 32 : i7
    %c-2_i2 = hw.constant -2 : i2
    %c61_i8 = hw.constant 61 : i8
    %c60_i8 = hw.constant 60 : i8
    %c58_i8 = hw.constant 58 : i8
    %c57_i8 = hw.constant 57 : i8
    %c56_i8 = hw.constant 56 : i8
    %c53_i8 = hw.constant 53 : i8
    %c52_i8 = hw.constant 52 : i8
    %c19_i8 = hw.constant 19 : i8
    %c64_i8 = hw.constant 64 : i8
    %true = hw.constant true
    %c29_i8 = hw.constant 29 : i8
    %c23_i8 = hw.constant 23 : i8
    %c24_i8 = hw.constant 24 : i8
    %c22_i8 = hw.constant 22 : i8
    %c18_i8 = hw.constant 18 : i8
    %c17_i8 = hw.constant 17 : i8
    %c16_i8 = hw.constant 16 : i8
    %c1_i3 = hw.constant 1 : i3
    %c0_i3 = hw.constant 0 : i3
    %c-1_i2 = hw.constant -1 : i2
    %c1_i2 = hw.constant 1 : i2
    %c0_i2 = hw.constant 0 : i2
    %c0_i4 = hw.constant 0 : i4
    %c8_i5 = hw.constant 8 : i5
    %c2_i4 = hw.constant 2 : i4
    %false = hw.constant false
    %c0_i64 = hw.constant 0 : i64
    %c1_i32 = hw.constant 1 : i32
    %c0_i32 = hw.constant 0 : i32
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %16 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %17 = llhd.prb %rst_ni_1 : i1
    %next_dm_addr_i_2 = llhd.sig name "next_dm_addr_i" %c0_i32 : i32
    %dmi_req_valid_i_3 = llhd.sig name "dmi_req_valid_i" %false : i1
    %dmi_req_ready_o = llhd.sig %false : i1
    %dmi_req_i_4 = llhd.sig name "dmi_req_i" %15 : !hw.struct<addr: i32, op: i2, data: i32>
    %ndmreset_ack_i_5 = llhd.sig name "ndmreset_ack_i" %false : i1
    %hartinfo_i_6 = llhd.sig name "hartinfo_i" %14 : !hw.array<1xstruct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>>
    %halted_i_7 = llhd.sig name "halted_i" %false : i1
    %resumeack_i_8 = llhd.sig name "resumeack_i" %false : i1
    %hartsel_o = llhd.sig %c0_i20 : i20
    %haltreq_o = llhd.sig %false : i1
    %resumereq_o = llhd.sig %false : i1
    %clear_resumeack_o = llhd.sig %false : i1
    %cmderror_valid_i_9 = llhd.sig name "cmderror_valid_i" %false : i1
    %cmderror_i_10 = llhd.sig name "cmderror_i" %c0_i3 : i3
    %cmdbusy_i_11 = llhd.sig name "cmdbusy_i" %false : i1
    %data_i_12 = llhd.sig name "data_i" %13 : !hw.array<2xi32>
    %data_valid_i_13 = llhd.sig name "data_valid_i" %false : i1
    %sbaddress_i_14 = llhd.sig name "sbaddress_i" %c0_i32 : i32
    %sbaddress_write_valid_o = llhd.sig %false : i1
    %sbdata_read_valid_o = llhd.sig %false : i1
    %sbdata_write_valid_o = llhd.sig %false : i1
    %sbdata_i_15 = llhd.sig name "sbdata_i" %c0_i32 : i32
    %sbdata_valid_i_16 = llhd.sig name "sbdata_valid_i" %false : i1
    %sbbusy_i_17 = llhd.sig name "sbbusy_i" %false : i1
    %sberror_valid_i_18 = llhd.sig name "sberror_valid_i" %false : i1
    %sberror_i_19 = llhd.sig name "sberror_i" %c0_i3 : i3
    %dtm_op = llhd.sig %c0_i2 : i2
    %haltsum0 = llhd.sig %c0_i32 : i32
    %haltsum1 = llhd.sig %c0_i32 : i32
    %haltsum2 = llhd.sig %c0_i32 : i32
    %haltsum3 = llhd.sig %c0_i32 : i32
    %halted = llhd.sig %c0_i32 : i32
    %halted_reshaped0 = llhd.sig %12 : !hw.array<1xi32>
    %halted_reshaped1 = llhd.sig %12 : !hw.array<1xi32>
    %halted_reshaped2 = llhd.sig %12 : !hw.array<1xi32>
    %halted_flat1 = llhd.sig %c0_i32 : i32
    %halted_flat2 = llhd.sig %c0_i32 : i32
    %halted_flat3 = llhd.sig %c0_i32 : i32
    %hartsel_idx0 = llhd.sig %c0_i15 : i15
    %hartsel_idx1 = llhd.sig %c0_i10 : i10
    %hartsel_idx2 = llhd.sig %c0_i5 : i5
    %dmstatus = llhd.sig %11 : !hw.struct<zero1: i9, impebreak: i1, zero0: i2, allhavereset: i1, anyhavereset: i1, allresumeack: i1, anyresumeack: i1, allnonexistent: i1, anynonexistent: i1, allunavail: i1, anyunavail: i1, allrunning: i1, anyrunning: i1, allhalted: i1, anyhalted: i1, authenticated: i1, authbusy: i1, hasresethaltreq: i1, devtreevalid: i1, version: i4>
    %dmcontrol_d = llhd.sig %10 : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
    %dmcontrol_q = llhd.sig %10 : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
    %hartsel_qp = llhd.sig %c0_i20 : i20
    %abstractcs = llhd.sig %9 : !hw.struct<zero3: i3, progbufsize: i5, zero2: i11, busy: i1, zero1: i1, cmderr: i3, zero0: i4, datacount: i4>
    %cmderr_d = llhd.sig %c0_i3 : i3
    %cmderr_q = llhd.sig %c0_i3 : i3
    %command_d = llhd.sig %8 : !hw.struct<cmdtype: i8, control: i24>
    %command_q = llhd.sig %8 : !hw.struct<cmdtype: i8, control: i24>
    %cmd_valid_d = llhd.sig %false : i1
    %cmd_valid_q = llhd.sig %false : i1
    %abstractauto_d = llhd.sig %7 : !hw.struct<autoexecprogbuf: i16, zero0: i4, autoexecdata: i12>
    %abstractauto_q = llhd.sig %7 : !hw.struct<autoexecprogbuf: i16, zero0: i4, autoexecdata: i12>
    %sbcs_d = llhd.sig %6 : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
    %sbcs_q = llhd.sig %6 : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
    %sbaddr_d = llhd.sig %c0_i64 : i64
    %sbaddr_q = llhd.sig %c0_i64 : i64
    %sbdata_d = llhd.sig %c0_i64 : i64
    %sbdata_q = llhd.sig %c0_i64 : i64
    %havereset_d = llhd.sig %false : i1
    %havereset_q = llhd.sig %false : i1
    %progbuf_d = llhd.sig %5 : !hw.array<8xi32>
    %progbuf_q = llhd.sig %5 : !hw.array<8xi32>
    %data_d = llhd.sig %13 : !hw.array<2xi32>
    %data_q = llhd.sig %13 : !hw.array<2xi32>
    %selected_hart = llhd.sig %false : i1
    %resp_queue_inp = llhd.sig %4 : !hw.struct<data: i32, resp: i2>
    %havereset_d_aligned = llhd.sig %c0_i2 : i2
    %havereset_q_aligned = llhd.sig %c0_i2 : i2
    %resumeack_aligned = llhd.sig %c0_i2 : i2
    %unavailable_aligned = llhd.sig %c0_i2 : i2
    %halted_aligned = llhd.sig %c0_i2 : i2
    %hartinfo_aligned = llhd.sig %3 : !hw.array<2xstruct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>>
    %dm_csr_addr = llhd.sig %c0_i8 : i8
    %sbcs = llhd.sig %6 : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
    %a_abstractcs = llhd.sig %9 : !hw.struct<zero3: i3, progbufsize: i5, zero2: i11, busy: i1, zero1: i1, cmderr: i3, zero0: i4, datacount: i4>
    %autoexecdata_idx = llhd.sig %c0_i4 : i4
    %18 = llhd.prb %dmi_req_valid_i_3 : i1
    %19 = llhd.prb %resp_queue_inp : !hw.struct<data: i32, resp: i2>
    %20 = hw.bitcast %19 : (!hw.struct<data: i32, resp: i2>) -> i34
    %i_fifo.wready_o, %i_fifo.rvalid_o, %i_fifo.rdata_o, %i_fifo.full_o, %i_fifo.depth_o, %i_fifo.err_o = hw.instance "i_fifo" @prim_fifo_sync(clk_i: %16: i1, rst_ni: %dmi_rst_ni: i1, clr_i: %false: i1, wvalid_i: %18: i1, wdata_i: %20: i34, rready_i: %dmi_resp_ready_i: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i34, full_o: i1, depth_o: i2, err_o: i1)
    llhd.drv %dmi_req_ready_o, %i_fifo.wready_o after %2 : i1
    %21 = hw.bitcast %i_fifo.rdata_o : (i34) -> !hw.struct<data: i32, resp: i2>
    %22 = llhd.prb %dmi_req_i_4 : !hw.struct<addr: i32, op: i2, data: i32>
    %op = hw.struct_extract %22["op"] : !hw.struct<addr: i32, op: i2, data: i32>
    llhd.drv %dtm_op, %op after %2 : i2
    %23 = llhd.prb %halted : i32
    %24 = llhd.prb %haltsum0 : i32
    %25 = llhd.prb %hartsel_o : i20
    %26 = llhd.prb %hartsel_idx0 : i15
    %27 = llhd.prb %halted_i_7 : i1
    %28 = llhd.prb %halted_reshaped0 : !hw.array<1xi32>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb3
      llhd.drv %halted, %c0_i32 after %2 : i32
      llhd.drv %haltsum0, %c0_i32 after %2 : i32
      %108 = llhd.prb %hartsel_o : i20
      %109 = comb.extract %108 from 5 : (i20) -> i15
      llhd.drv %hartsel_idx0, %109 after %2 : i15
      %110 = llhd.sig.extract %halted from %c0_i5 : <i32> -> <i1>
      %111 = llhd.prb %halted_i_7 : i1
      llhd.drv %110, %111 after %2 : i1
      %112 = llhd.prb %halted : i32
      %113 = hw.bitcast %112 : (i32) -> !hw.array<1xi32>
      llhd.drv %halted_reshaped0, %113 after %2 : !hw.array<1xi32>
      %114 = llhd.prb %hartsel_idx0 : i15
      %115 = comb.icmp eq %114, %c0_i15 : i15
      cf.cond_br %115, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %116 = llhd.prb %halted_reshaped0 : !hw.array<1xi32>
      %117 = llhd.prb %hartsel_idx0 : i15
      %118 = comb.icmp eq %117, %c0_i15 : i15
      %119 = comb.extract %117 from 0 : (i15) -> i0
      %120 = comb.mux %118, %119, %c0_i0 : i0
      %121 = hw.array_get %116[%120] : !hw.array<1xi32>, i0
      llhd.drv %haltsum0, %121 after %2 : i32
      cf.br ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      llhd.wait (%23, %24, %25, %26, %27, %28 : i32, i32, i20, i15, i1, !hw.array<1xi32>), ^bb1
    }
    %29 = llhd.prb %halted_flat1 : i32
    %30 = llhd.prb %haltsum1 : i32
    %31 = llhd.prb %hartsel_idx1 : i10
    %32 = llhd.prb %halted_reshaped1 : !hw.array<1xi32>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      llhd.drv %halted_flat1, %c0_i32 after %2 : i32
      llhd.drv %haltsum1, %c0_i32 after %2 : i32
      %108 = llhd.prb %hartsel_o : i20
      %109 = comb.extract %108 from 10 : (i20) -> i10
      llhd.drv %hartsel_idx1, %109 after %2 : i10
      cf.br ^bb2(%c0_i32 : i32)
    ^bb2(%110: i32):  // 2 preds: ^bb1, ^bb3
      %111 = comb.icmp eq %110, %c0_i32 : i32
      cf.cond_br %111, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %112 = comb.extract %110 from 5 : (i32) -> i27
      %113 = comb.icmp eq %112, %c0_i27 : i27
      %114 = comb.extract %110 from 0 : (i32) -> i5
      %115 = comb.mux %113, %114, %c-1_i5 : i5
      %116 = llhd.sig.extract %halted_flat1 from %115 : <i32> -> <i1>
      %117 = llhd.prb %halted_reshaped0 : !hw.array<1xi32>
      %118 = comb.icmp eq %110, %c0_i32 : i32
      %119 = comb.extract %110 from 0 : (i32) -> i0
      %120 = comb.mux %118, %119, %c0_i0 : i0
      %121 = hw.array_get %117[%120] : !hw.array<1xi32>, i0
      %122 = comb.icmp ne %121, %c0_i32 : i32
      llhd.drv %116, %122 after %2 : i1
      %123 = comb.add %110, %c1_i32 : i32
      cf.br ^bb2(%123 : i32)
    ^bb4:  // pred: ^bb2
      %124 = llhd.prb %halted_flat1 : i32
      %125 = hw.bitcast %124 : (i32) -> !hw.array<1xi32>
      llhd.drv %halted_reshaped1, %125 after %2 : !hw.array<1xi32>
      %126 = llhd.prb %hartsel_idx1 : i10
      %127 = comb.icmp eq %126, %c0_i10 : i10
      cf.cond_br %127, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      %128 = llhd.prb %halted_reshaped1 : !hw.array<1xi32>
      %129 = llhd.prb %hartsel_idx1 : i10
      %130 = comb.icmp eq %129, %c0_i10 : i10
      %131 = comb.extract %129 from 0 : (i10) -> i0
      %132 = comb.mux %130, %131, %c0_i0 : i0
      %133 = hw.array_get %128[%132] : !hw.array<1xi32>, i0
      llhd.drv %haltsum1, %133 after %2 : i32
      cf.br ^bb6
    ^bb6:  // 2 preds: ^bb4, ^bb5
      llhd.wait (%29, %30, %25, %31, %28, %32 : i32, i32, i20, i10, !hw.array<1xi32>, !hw.array<1xi32>), ^bb1
    }
    %33 = llhd.prb %halted_flat2 : i32
    %34 = llhd.prb %haltsum2 : i32
    %35 = llhd.prb %hartsel_idx2 : i5
    %36 = llhd.prb %halted_reshaped2 : !hw.array<1xi32>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      llhd.drv %halted_flat2, %c0_i32 after %2 : i32
      llhd.drv %haltsum2, %c0_i32 after %2 : i32
      %108 = llhd.prb %hartsel_o : i20
      %109 = comb.extract %108 from 15 : (i20) -> i5
      llhd.drv %hartsel_idx2, %109 after %2 : i5
      cf.br ^bb2(%c0_i32 : i32)
    ^bb2(%110: i32):  // 2 preds: ^bb1, ^bb3
      %111 = comb.icmp eq %110, %c0_i32 : i32
      cf.cond_br %111, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %112 = comb.extract %110 from 5 : (i32) -> i27
      %113 = comb.icmp eq %112, %c0_i27 : i27
      %114 = comb.extract %110 from 0 : (i32) -> i5
      %115 = comb.mux %113, %114, %c-1_i5 : i5
      %116 = llhd.sig.extract %halted_flat2 from %115 : <i32> -> <i1>
      %117 = llhd.prb %halted_reshaped1 : !hw.array<1xi32>
      %118 = comb.icmp eq %110, %c0_i32 : i32
      %119 = comb.extract %110 from 0 : (i32) -> i0
      %120 = comb.mux %118, %119, %c0_i0 : i0
      %121 = hw.array_get %117[%120] : !hw.array<1xi32>, i0
      %122 = comb.icmp ne %121, %c0_i32 : i32
      llhd.drv %116, %122 after %2 : i1
      %123 = comb.add %110, %c1_i32 : i32
      cf.br ^bb2(%123 : i32)
    ^bb4:  // pred: ^bb2
      %124 = llhd.prb %halted_flat2 : i32
      %125 = hw.bitcast %124 : (i32) -> !hw.array<1xi32>
      llhd.drv %halted_reshaped2, %125 after %2 : !hw.array<1xi32>
      %126 = llhd.prb %hartsel_idx2 : i5
      %127 = comb.icmp eq %126, %c0_i5 : i5
      cf.cond_br %127, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      %128 = llhd.prb %halted_reshaped2 : !hw.array<1xi32>
      %129 = llhd.prb %hartsel_idx2 : i5
      %130 = comb.icmp eq %129, %c0_i5 : i5
      %131 = comb.extract %129 from 0 : (i5) -> i0
      %132 = comb.mux %130, %131, %c0_i0 : i0
      %133 = hw.array_get %128[%132] : !hw.array<1xi32>, i0
      llhd.drv %haltsum2, %133 after %2 : i32
      cf.br ^bb6
    ^bb6:  // 2 preds: ^bb4, ^bb5
      llhd.wait (%33, %34, %25, %35, %32, %36 : i32, i32, i20, i5, !hw.array<1xi32>, !hw.array<1xi32>), ^bb1
    }
    %37 = llhd.prb %halted_flat3 : i32
    %38 = llhd.prb %haltsum3 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb4
      llhd.drv %halted_flat3, %c0_i32 after %2 : i32
      cf.br ^bb2(%c0_i32 : i32)
    ^bb2(%108: i32):  // 2 preds: ^bb1, ^bb3
      %109 = comb.icmp eq %108, %c0_i32 : i32
      cf.cond_br %109, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %110 = comb.extract %108 from 5 : (i32) -> i27
      %111 = comb.icmp eq %110, %c0_i27 : i27
      %112 = comb.extract %108 from 0 : (i32) -> i5
      %113 = comb.mux %111, %112, %c-1_i5 : i5
      %114 = llhd.sig.extract %halted_flat3 from %113 : <i32> -> <i1>
      %115 = llhd.prb %halted_reshaped2 : !hw.array<1xi32>
      %116 = comb.icmp eq %108, %c0_i32 : i32
      %117 = comb.extract %108 from 0 : (i32) -> i0
      %118 = comb.mux %116, %117, %c0_i0 : i0
      %119 = hw.array_get %115[%118] : !hw.array<1xi32>, i0
      %120 = comb.icmp ne %119, %c0_i32 : i32
      llhd.drv %114, %120 after %2 : i1
      %121 = comb.add %108, %c1_i32 : i32
      cf.br ^bb2(%121 : i32)
    ^bb4:  // pred: ^bb2
      %122 = llhd.prb %halted_flat3 : i32
      llhd.drv %haltsum3, %122 after %2 : i32
      llhd.wait (%37, %36, %38 : i32, !hw.array<1xi32>, i32), ^bb1
    }
    %39 = llhd.prb %sbcs_q : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
    %sbautoincrement = hw.struct_extract %39["sbautoincrement"] : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
    %sbreadonaddr = hw.struct_extract %39["sbreadonaddr"] : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
    %sbreadondata = hw.struct_extract %39["sbreadondata"] : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
    %sbaccess = hw.struct_extract %39["sbaccess"] : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
    %40 = llhd.prb %sbdata_q : i64
    %41 = comb.extract %40 from 0 : (i64) -> i32
    %42 = llhd.prb %sbaddr_q : i64
    %43 = comb.extract %42 from 0 : (i64) -> i32
    %44 = llhd.prb %dmcontrol_q : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
    %hartselhi = hw.struct_extract %44["hartselhi"] : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
    %hartsello = hw.struct_extract %44["hartsello"] : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
    %45 = comb.concat %hartselhi, %hartsello : i10, i10
    llhd.drv %hartsel_o, %45 after %2 : i20
    %46 = llhd.prb %resumeack_i_8 : i1
    %47 = comb.concat %false, %46 : i1, i1
    llhd.drv %resumeack_aligned, %47 after %2 : i2
    %48 = comb.concat %false, %unavailable_i : i1, i1
    llhd.drv %unavailable_aligned, %48 after %2 : i2
    %49 = comb.concat %false, %27 : i1, i1
    llhd.drv %halted_aligned, %49 after %2 : i2
    %50 = llhd.prb %havereset_d_aligned : i2
    %51 = comb.extract %50 from 0 : (i2) -> i1
    llhd.drv %havereset_d, %51 after %2 : i1
    %52 = llhd.prb %havereset_q : i1
    %53 = comb.concat %false, %52 : i1, i1
    llhd.drv %havereset_q_aligned, %53 after %2 : i2
    %54 = llhd.prb %hartinfo_aligned : !hw.array<2xstruct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>>
    %55 = llhd.prb %hartinfo_i_6 : !hw.array<1xstruct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %hartinfo_aligned, %3 after %2 : !hw.array<2xstruct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>>
      %108 = llhd.sig.array_slice %hartinfo_aligned at %false : <!hw.array<2xstruct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>>> -> <!hw.array<1xstruct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>>>
      %109 = llhd.prb %hartinfo_i_6 : !hw.array<1xstruct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>>
      llhd.drv %108, %109 after %2 : !hw.array<1xstruct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>>
      llhd.wait (%54, %55 : !hw.array<2xstruct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>>, !hw.array<1xstruct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>>), ^bb1
    }
    %addr = hw.struct_extract %22["addr"] : !hw.struct<addr: i32, op: i2, data: i32>
    %56 = comb.extract %addr from 0 : (i32) -> i8
    llhd.drv %dm_csr_addr, %56 after %2 : i8
    %57 = llhd.prb %dm_csr_addr : i8
    %58 = comb.extract %57 from 0 : (i8) -> i4
    %59 = comb.add %58, %c-4_i4 : i4
    llhd.drv %autoexecdata_idx, %59 after %2 : i4
    %60 = llhd.prb %dmstatus : !hw.struct<zero1: i9, impebreak: i1, zero0: i2, allhavereset: i1, anyhavereset: i1, allresumeack: i1, anyresumeack: i1, allnonexistent: i1, anynonexistent: i1, allunavail: i1, anyunavail: i1, allrunning: i1, anyrunning: i1, allhalted: i1, anyhalted: i1, authenticated: i1, authbusy: i1, hasresethaltreq: i1, devtreevalid: i1, version: i4>
    %61 = llhd.prb %havereset_q_aligned : i2
    %62 = llhd.prb %selected_hart : i1
    %63 = llhd.prb %resumeack_aligned : i2
    %64 = llhd.prb %unavailable_aligned : i2
    %65 = llhd.prb %halted_aligned : i2
    %66 = llhd.prb %abstractcs : !hw.struct<zero3: i3, progbufsize: i5, zero2: i11, busy: i1, zero1: i1, cmderr: i3, zero0: i4, datacount: i4>
    %67 = llhd.prb %cmdbusy_i_11 : i1
    %68 = llhd.prb %cmderr_q : i3
    %69 = llhd.prb %abstractauto_q : !hw.struct<autoexecprogbuf: i16, zero0: i4, autoexecdata: i12>
    %70 = llhd.prb %abstractauto_d : !hw.struct<autoexecprogbuf: i16, zero0: i4, autoexecdata: i12>
    %71 = llhd.prb %dmcontrol_d : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
    %72 = llhd.prb %cmderr_d : i3
    %73 = llhd.prb %command_q : !hw.struct<cmdtype: i8, control: i24>
    %74 = llhd.prb %command_d : !hw.struct<cmdtype: i8, control: i24>
    %75 = llhd.prb %progbuf_q : !hw.array<8xi32>
    %76 = llhd.prb %progbuf_d : !hw.array<8xi32>
    %77 = llhd.prb %data_q : !hw.array<2xi32>
    %78 = llhd.prb %data_d : !hw.array<2xi32>
    %79 = llhd.prb %sbcs_d : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
    %80 = llhd.prb %sbaddress_i_14 : i32
    %81 = llhd.prb %sbaddr_d : i64
    %82 = llhd.prb %sbdata_d : i64
    %83 = llhd.prb %cmd_valid_d : i1
    %84 = llhd.prb %sbaddress_write_valid_o : i1
    %85 = llhd.prb %sbdata_read_valid_o : i1
    %86 = llhd.prb %sbdata_write_valid_o : i1
    %87 = llhd.prb %clear_resumeack_o : i1
    %88 = llhd.prb %sbcs : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
    %89 = llhd.prb %a_abstractcs : !hw.struct<zero3: i3, progbufsize: i5, zero2: i11, busy: i1, zero1: i1, cmderr: i3, zero0: i4, datacount: i4>
    %90 = llhd.prb %dmi_req_ready_o : i1
    %91 = llhd.prb %dtm_op : i2
    %92 = llhd.prb %autoexecdata_idx : i4
    %93 = llhd.prb %cmderror_valid_i_9 : i1
    %94 = llhd.prb %cmderror_i_10 : i3
    %95 = llhd.prb %data_valid_i_13 : i1
    %96 = llhd.prb %data_i_12 : !hw.array<2xi32>
    %97 = llhd.prb %ndmreset_ack_i_5 : i1
    %98 = llhd.prb %sberror_valid_i_18 : i1
    %99 = llhd.prb %sberror_i_19 : i3
    %100 = llhd.prb %sbdata_valid_i_16 : i1
    %101 = llhd.prb %sbdata_i_15 : i32
    %102 = llhd.prb %hartsel_qp : i20
    %103 = llhd.prb %sbbusy_i_17 : i1
    %104 = llhd.prb %next_dm_addr_i_2 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb114
      llhd.drv %dmstatus, %11 after %2 : !hw.struct<zero1: i9, impebreak: i1, zero0: i2, allhavereset: i1, anyhavereset: i1, allresumeack: i1, anyresumeack: i1, allnonexistent: i1, anynonexistent: i1, allunavail: i1, anyunavail: i1, allrunning: i1, anyrunning: i1, allhalted: i1, anyhalted: i1, authenticated: i1, authbusy: i1, hasresethaltreq: i1, devtreevalid: i1, version: i4>
      %108 = llhd.sig.struct_extract %dmstatus["version"] : <!hw.struct<zero1: i9, impebreak: i1, zero0: i2, allhavereset: i1, anyhavereset: i1, allresumeack: i1, anyresumeack: i1, allnonexistent: i1, anynonexistent: i1, allunavail: i1, anyunavail: i1, allrunning: i1, anyrunning: i1, allhalted: i1, anyhalted: i1, authenticated: i1, authbusy: i1, hasresethaltreq: i1, devtreevalid: i1, version: i4>>
      llhd.drv %108, %c2_i4 after %2 : i4
      %109 = llhd.sig.struct_extract %dmstatus["authenticated"] : <!hw.struct<zero1: i9, impebreak: i1, zero0: i2, allhavereset: i1, anyhavereset: i1, allresumeack: i1, anyresumeack: i1, allnonexistent: i1, anynonexistent: i1, allunavail: i1, anyunavail: i1, allrunning: i1, anyrunning: i1, allhalted: i1, anyhalted: i1, authenticated: i1, authbusy: i1, hasresethaltreq: i1, devtreevalid: i1, version: i4>>
      llhd.drv %109, %true after %2 : i1
      %110 = llhd.sig.struct_extract %dmstatus["hasresethaltreq"] : <!hw.struct<zero1: i9, impebreak: i1, zero0: i2, allhavereset: i1, anyhavereset: i1, allresumeack: i1, anyresumeack: i1, allnonexistent: i1, anynonexistent: i1, allunavail: i1, anyunavail: i1, allrunning: i1, anyrunning: i1, allhalted: i1, anyhalted: i1, authenticated: i1, authbusy: i1, hasresethaltreq: i1, devtreevalid: i1, version: i4>>
      llhd.drv %110, %false after %2 : i1
      %111 = llhd.sig.struct_extract %dmstatus["allhavereset"] : <!hw.struct<zero1: i9, impebreak: i1, zero0: i2, allhavereset: i1, anyhavereset: i1, allresumeack: i1, anyresumeack: i1, allnonexistent: i1, anynonexistent: i1, allunavail: i1, anyunavail: i1, allrunning: i1, anyrunning: i1, allhalted: i1, anyhalted: i1, authenticated: i1, authbusy: i1, hasresethaltreq: i1, devtreevalid: i1, version: i4>>
      %112 = llhd.prb %havereset_q_aligned : i2
      %113 = llhd.prb %selected_hart : i1
      %114 = comb.concat %false, %113 : i1, i1
      %115 = comb.shru %112, %114 : i2
      %116 = comb.extract %115 from 0 : (i2) -> i1
      llhd.drv %111, %116 after %2 : i1
      %117 = llhd.sig.struct_extract %dmstatus["anyhavereset"] : <!hw.struct<zero1: i9, impebreak: i1, zero0: i2, allhavereset: i1, anyhavereset: i1, allresumeack: i1, anyresumeack: i1, allnonexistent: i1, anynonexistent: i1, allunavail: i1, anyunavail: i1, allrunning: i1, anyrunning: i1, allhalted: i1, anyhalted: i1, authenticated: i1, authbusy: i1, hasresethaltreq: i1, devtreevalid: i1, version: i4>>
      %118 = llhd.prb %havereset_q_aligned : i2
      %119 = llhd.prb %selected_hart : i1
      %120 = comb.concat %false, %119 : i1, i1
      %121 = comb.shru %118, %120 : i2
      %122 = comb.extract %121 from 0 : (i2) -> i1
      llhd.drv %117, %122 after %2 : i1
      %123 = llhd.sig.struct_extract %dmstatus["allresumeack"] : <!hw.struct<zero1: i9, impebreak: i1, zero0: i2, allhavereset: i1, anyhavereset: i1, allresumeack: i1, anyresumeack: i1, allnonexistent: i1, anynonexistent: i1, allunavail: i1, anyunavail: i1, allrunning: i1, anyrunning: i1, allhalted: i1, anyhalted: i1, authenticated: i1, authbusy: i1, hasresethaltreq: i1, devtreevalid: i1, version: i4>>
      %124 = llhd.prb %resumeack_aligned : i2
      %125 = llhd.prb %selected_hart : i1
      %126 = comb.concat %false, %125 : i1, i1
      %127 = comb.shru %124, %126 : i2
      %128 = comb.extract %127 from 0 : (i2) -> i1
      llhd.drv %123, %128 after %2 : i1
      %129 = llhd.sig.struct_extract %dmstatus["anyresumeack"] : <!hw.struct<zero1: i9, impebreak: i1, zero0: i2, allhavereset: i1, anyhavereset: i1, allresumeack: i1, anyresumeack: i1, allnonexistent: i1, anynonexistent: i1, allunavail: i1, anyunavail: i1, allrunning: i1, anyrunning: i1, allhalted: i1, anyhalted: i1, authenticated: i1, authbusy: i1, hasresethaltreq: i1, devtreevalid: i1, version: i4>>
      %130 = llhd.prb %resumeack_aligned : i2
      %131 = llhd.prb %selected_hart : i1
      %132 = comb.concat %false, %131 : i1, i1
      %133 = comb.shru %130, %132 : i2
      %134 = comb.extract %133 from 0 : (i2) -> i1
      llhd.drv %129, %134 after %2 : i1
      %135 = llhd.sig.struct_extract %dmstatus["allunavail"] : <!hw.struct<zero1: i9, impebreak: i1, zero0: i2, allhavereset: i1, anyhavereset: i1, allresumeack: i1, anyresumeack: i1, allnonexistent: i1, anynonexistent: i1, allunavail: i1, anyunavail: i1, allrunning: i1, anyrunning: i1, allhalted: i1, anyhalted: i1, authenticated: i1, authbusy: i1, hasresethaltreq: i1, devtreevalid: i1, version: i4>>
      %136 = llhd.prb %unavailable_aligned : i2
      %137 = llhd.prb %selected_hart : i1
      %138 = comb.concat %false, %137 : i1, i1
      %139 = comb.shru %136, %138 : i2
      %140 = comb.extract %139 from 0 : (i2) -> i1
      llhd.drv %135, %140 after %2 : i1
      %141 = llhd.sig.struct_extract %dmstatus["anyunavail"] : <!hw.struct<zero1: i9, impebreak: i1, zero0: i2, allhavereset: i1, anyhavereset: i1, allresumeack: i1, anyresumeack: i1, allnonexistent: i1, anynonexistent: i1, allunavail: i1, anyunavail: i1, allrunning: i1, anyrunning: i1, allhalted: i1, anyhalted: i1, authenticated: i1, authbusy: i1, hasresethaltreq: i1, devtreevalid: i1, version: i4>>
      %142 = llhd.prb %unavailable_aligned : i2
      %143 = llhd.prb %selected_hart : i1
      %144 = comb.concat %false, %143 : i1, i1
      %145 = comb.shru %142, %144 : i2
      %146 = comb.extract %145 from 0 : (i2) -> i1
      llhd.drv %141, %146 after %2 : i1
      %147 = llhd.sig.struct_extract %dmstatus["allnonexistent"] : <!hw.struct<zero1: i9, impebreak: i1, zero0: i2, allhavereset: i1, anyhavereset: i1, allresumeack: i1, anyresumeack: i1, allnonexistent: i1, anynonexistent: i1, allunavail: i1, anyunavail: i1, allrunning: i1, anyrunning: i1, allhalted: i1, anyhalted: i1, authenticated: i1, authbusy: i1, hasresethaltreq: i1, devtreevalid: i1, version: i4>>
      %148 = llhd.prb %hartsel_o : i20
      %149 = comb.icmp ne %148, %c0_i20 : i20
      llhd.drv %147, %149 after %2 : i1
      %150 = llhd.sig.struct_extract %dmstatus["anynonexistent"] : <!hw.struct<zero1: i9, impebreak: i1, zero0: i2, allhavereset: i1, anyhavereset: i1, allresumeack: i1, anyresumeack: i1, allnonexistent: i1, anynonexistent: i1, allunavail: i1, anyunavail: i1, allrunning: i1, anyrunning: i1, allhalted: i1, anyhalted: i1, authenticated: i1, authbusy: i1, hasresethaltreq: i1, devtreevalid: i1, version: i4>>
      %151 = llhd.prb %hartsel_o : i20
      %152 = comb.icmp ne %151, %c0_i20 : i20
      llhd.drv %150, %152 after %2 : i1
      %153 = llhd.sig.struct_extract %dmstatus["allhalted"] : <!hw.struct<zero1: i9, impebreak: i1, zero0: i2, allhavereset: i1, anyhavereset: i1, allresumeack: i1, anyresumeack: i1, allnonexistent: i1, anynonexistent: i1, allunavail: i1, anyunavail: i1, allrunning: i1, anyrunning: i1, allhalted: i1, anyhalted: i1, authenticated: i1, authbusy: i1, hasresethaltreq: i1, devtreevalid: i1, version: i4>>
      %154 = llhd.prb %halted_aligned : i2
      %155 = llhd.prb %selected_hart : i1
      %156 = comb.concat %false, %155 : i1, i1
      %157 = comb.shru %154, %156 : i2
      %158 = comb.extract %157 from 0 : (i2) -> i1
      %159 = llhd.prb %unavailable_aligned : i2
      %160 = comb.shru %159, %156 : i2
      %161 = comb.extract %160 from 0 : (i2) -> i1
      %162 = comb.xor %161, %true : i1
      %163 = comb.and %158, %162 : i1
      llhd.drv %153, %163 after %2 : i1
      %164 = llhd.sig.struct_extract %dmstatus["anyhalted"] : <!hw.struct<zero1: i9, impebreak: i1, zero0: i2, allhavereset: i1, anyhavereset: i1, allresumeack: i1, anyresumeack: i1, allnonexistent: i1, anynonexistent: i1, allunavail: i1, anyunavail: i1, allrunning: i1, anyrunning: i1, allhalted: i1, anyhalted: i1, authenticated: i1, authbusy: i1, hasresethaltreq: i1, devtreevalid: i1, version: i4>>
      %165 = llhd.prb %halted_aligned : i2
      %166 = llhd.prb %selected_hart : i1
      %167 = comb.concat %false, %166 : i1, i1
      %168 = comb.shru %165, %167 : i2
      %169 = comb.extract %168 from 0 : (i2) -> i1
      %170 = llhd.prb %unavailable_aligned : i2
      %171 = comb.shru %170, %167 : i2
      %172 = comb.extract %171 from 0 : (i2) -> i1
      %173 = comb.xor %172, %true : i1
      %174 = comb.and %169, %173 : i1
      llhd.drv %164, %174 after %2 : i1
      %175 = llhd.sig.struct_extract %dmstatus["allrunning"] : <!hw.struct<zero1: i9, impebreak: i1, zero0: i2, allhavereset: i1, anyhavereset: i1, allresumeack: i1, anyresumeack: i1, allnonexistent: i1, anynonexistent: i1, allunavail: i1, anyunavail: i1, allrunning: i1, anyrunning: i1, allhalted: i1, anyhalted: i1, authenticated: i1, authbusy: i1, hasresethaltreq: i1, devtreevalid: i1, version: i4>>
      %176 = llhd.prb %halted_aligned : i2
      %177 = llhd.prb %selected_hart : i1
      %178 = comb.concat %false, %177 : i1, i1
      %179 = comb.shru %176, %178 : i2
      %180 = comb.extract %179 from 0 : (i2) -> i1
      %181 = comb.xor %180, %true : i1
      %182 = llhd.prb %unavailable_aligned : i2
      %183 = comb.shru %182, %178 : i2
      %184 = comb.extract %183 from 0 : (i2) -> i1
      %185 = comb.xor %184, %true : i1
      %186 = comb.and %181, %185 : i1
      llhd.drv %175, %186 after %2 : i1
      %187 = llhd.sig.struct_extract %dmstatus["anyrunning"] : <!hw.struct<zero1: i9, impebreak: i1, zero0: i2, allhavereset: i1, anyhavereset: i1, allresumeack: i1, anyresumeack: i1, allnonexistent: i1, anynonexistent: i1, allunavail: i1, anyunavail: i1, allrunning: i1, anyrunning: i1, allhalted: i1, anyhalted: i1, authenticated: i1, authbusy: i1, hasresethaltreq: i1, devtreevalid: i1, version: i4>>
      %188 = llhd.prb %halted_aligned : i2
      %189 = llhd.prb %selected_hart : i1
      %190 = comb.concat %false, %189 : i1, i1
      %191 = comb.shru %188, %190 : i2
      %192 = comb.extract %191 from 0 : (i2) -> i1
      %193 = comb.xor %192, %true : i1
      %194 = llhd.prb %unavailable_aligned : i2
      %195 = comb.shru %194, %190 : i2
      %196 = comb.extract %195 from 0 : (i2) -> i1
      %197 = comb.xor %196, %true : i1
      %198 = comb.and %193, %197 : i1
      llhd.drv %187, %198 after %2 : i1
      llhd.drv %abstractcs, %9 after %2 : !hw.struct<zero3: i3, progbufsize: i5, zero2: i11, busy: i1, zero1: i1, cmderr: i3, zero0: i4, datacount: i4>
      %199 = llhd.sig.struct_extract %abstractcs["datacount"] : <!hw.struct<zero3: i3, progbufsize: i5, zero2: i11, busy: i1, zero1: i1, cmderr: i3, zero0: i4, datacount: i4>>
      llhd.drv %199, %c2_i4 after %2 : i4
      %200 = llhd.sig.struct_extract %abstractcs["progbufsize"] : <!hw.struct<zero3: i3, progbufsize: i5, zero2: i11, busy: i1, zero1: i1, cmderr: i3, zero0: i4, datacount: i4>>
      llhd.drv %200, %c8_i5 after %2 : i5
      %201 = llhd.sig.struct_extract %abstractcs["busy"] : <!hw.struct<zero3: i3, progbufsize: i5, zero2: i11, busy: i1, zero1: i1, cmderr: i3, zero0: i4, datacount: i4>>
      %202 = llhd.prb %cmdbusy_i_11 : i1
      llhd.drv %201, %202 after %2 : i1
      %203 = llhd.sig.struct_extract %abstractcs["cmderr"] : <!hw.struct<zero3: i3, progbufsize: i5, zero2: i11, busy: i1, zero1: i1, cmderr: i3, zero0: i4, datacount: i4>>
      %204 = llhd.prb %cmderr_q : i3
      llhd.drv %203, %204 after %2 : i3
      %205 = llhd.prb %abstractauto_q : !hw.struct<autoexecprogbuf: i16, zero0: i4, autoexecdata: i12>
      llhd.drv %abstractauto_d, %205 after %2 : !hw.struct<autoexecprogbuf: i16, zero0: i4, autoexecdata: i12>
      %206 = llhd.sig.struct_extract %abstractauto_d["zero0"] : <!hw.struct<autoexecprogbuf: i16, zero0: i4, autoexecdata: i12>>
      llhd.drv %206, %c0_i4 after %2 : i4
      %207 = llhd.prb %havereset_q : i1
      %208 = comb.concat %false, %207 : i1, i1
      llhd.drv %havereset_d_aligned, %208 after %2 : i2
      %209 = llhd.prb %dmcontrol_q : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
      llhd.drv %dmcontrol_d, %209 after %2 : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
      %210 = llhd.prb %cmderr_q : i3
      llhd.drv %cmderr_d, %210 after %2 : i3
      %211 = llhd.prb %command_q : !hw.struct<cmdtype: i8, control: i24>
      llhd.drv %command_d, %211 after %2 : !hw.struct<cmdtype: i8, control: i24>
      %212 = llhd.prb %progbuf_q : !hw.array<8xi32>
      llhd.drv %progbuf_d, %212 after %2 : !hw.array<8xi32>
      %213 = llhd.prb %data_q : !hw.array<2xi32>
      llhd.drv %data_d, %213 after %2 : !hw.array<2xi32>
      %214 = llhd.prb %sbcs_q : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      llhd.drv %sbcs_d, %214 after %2 : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %215 = llhd.prb %sbaddress_i_14 : i32
      %216 = comb.concat %c0_i32, %215 : i32, i32
      llhd.drv %sbaddr_d, %216 after %2 : i64
      %217 = llhd.prb %sbdata_q : i64
      llhd.drv %sbdata_d, %217 after %2 : i64
      %218 = llhd.sig.struct_extract %resp_queue_inp["data"] : <!hw.struct<data: i32, resp: i2>>
      llhd.drv %218, %c0_i32 after %2 : i32
      %219 = llhd.sig.struct_extract %resp_queue_inp["resp"] : <!hw.struct<data: i32, resp: i2>>
      llhd.drv %219, %c0_i2 after %2 : i2
      llhd.drv %cmd_valid_d, %false after %2 : i1
      llhd.drv %sbaddress_write_valid_o, %false after %2 : i1
      llhd.drv %sbdata_read_valid_o, %false after %2 : i1
      llhd.drv %sbdata_write_valid_o, %false after %2 : i1
      llhd.drv %clear_resumeack_o, %false after %2 : i1
      llhd.drv %sbcs, %6 after %2 : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      llhd.drv %a_abstractcs, %9 after %2 : !hw.struct<zero3: i3, progbufsize: i5, zero2: i11, busy: i1, zero1: i1, cmderr: i3, zero0: i4, datacount: i4>
      %220 = llhd.prb %dmi_req_ready_o : i1
      %221 = llhd.prb %dmi_req_valid_i_3 : i1
      %222 = llhd.prb %dtm_op : i2
      %223 = comb.icmp eq %222, %c1_i2 : i2
      %224 = comb.and %220, %221, %223 : i1
      cf.cond_br %224, ^bb2, ^bb48
    ^bb2:  // pred: ^bb1
      %225 = llhd.prb %dm_csr_addr : i8
      %226 = comb.extract %225 from 2 : (i8) -> i6
      %227 = comb.icmp ne %226, %c0_i6 : i6
      %228 = comb.icmp ult %225, %c6_i8 : i8
      %229 = comb.and %227, %228 : i1
      cf.cond_br %229, ^bb3, ^bb7
    ^bb3:  // pred: ^bb2
      %230 = llhd.prb %data_q : !hw.array<2xi32>
      %231 = llhd.prb %autoexecdata_idx : i4
      %232 = comb.extract %231 from 0 : (i4) -> i1
      %233 = hw.array_get %230[%232] : !hw.array<2xi32>, i1
      llhd.drv %218, %233 after %2 : i32
      %234 = llhd.prb %cmdbusy_i_11 : i1
      %235 = comb.xor %234, %true : i1
      cf.cond_br %235, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %236 = llhd.prb %abstractauto_q : !hw.struct<autoexecprogbuf: i16, zero0: i4, autoexecdata: i12>
      %autoexecdata = hw.struct_extract %236["autoexecdata"] : !hw.struct<autoexecprogbuf: i16, zero0: i4, autoexecdata: i12>
      %237 = llhd.prb %autoexecdata_idx : i4
      %238 = comb.concat %c0_i8, %237 : i8, i4
      %239 = comb.shru %autoexecdata, %238 : i12
      %240 = comb.extract %239 from 0 : (i12) -> i1
      llhd.drv %cmd_valid_d, %240 after %2 : i1
      cf.br ^bb48
    ^bb5:  // pred: ^bb3
      llhd.drv %219, %c-1_i2 after %2 : i2
      %241 = llhd.prb %cmderr_q : i3
      %242 = comb.icmp eq %241, %c0_i3 : i3
      cf.cond_br %242, ^bb6, ^bb48
    ^bb6:  // pred: ^bb5
      llhd.drv %cmderr_d, %c1_i3 after %2 : i3
      cf.br ^bb48
    ^bb7:  // pred: ^bb2
      %243 = comb.icmp weq %225, %c16_i8 : i8
      cf.cond_br %243, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %244 = llhd.prb %dmcontrol_q : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
      %245 = hw.bitcast %244 : (!hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>) -> i32
      llhd.drv %218, %245 after %2 : i32
      cf.br ^bb48
    ^bb9:  // pred: ^bb7
      %246 = comb.icmp weq %225, %c17_i8 : i8
      cf.cond_br %246, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %247 = llhd.prb %dmstatus : !hw.struct<zero1: i9, impebreak: i1, zero0: i2, allhavereset: i1, anyhavereset: i1, allresumeack: i1, anyresumeack: i1, allnonexistent: i1, anynonexistent: i1, allunavail: i1, anyunavail: i1, allrunning: i1, anyrunning: i1, allhalted: i1, anyhalted: i1, authenticated: i1, authbusy: i1, hasresethaltreq: i1, devtreevalid: i1, version: i4>
      %248 = hw.bitcast %247 : (!hw.struct<zero1: i9, impebreak: i1, zero0: i2, allhavereset: i1, anyhavereset: i1, allresumeack: i1, anyresumeack: i1, allnonexistent: i1, anynonexistent: i1, allunavail: i1, anyunavail: i1, allrunning: i1, anyrunning: i1, allhalted: i1, anyhalted: i1, authenticated: i1, authbusy: i1, hasresethaltreq: i1, devtreevalid: i1, version: i4>) -> i32
      llhd.drv %218, %248 after %2 : i32
      cf.br ^bb48
    ^bb11:  // pred: ^bb9
      %249 = comb.icmp weq %225, %c18_i8 : i8
      cf.cond_br %249, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %250 = llhd.prb %hartinfo_aligned : !hw.array<2xstruct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>>
      %251 = llhd.prb %selected_hart : i1
      %252 = hw.array_get %250[%251] : !hw.array<2xstruct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>>, i1
      %253 = hw.bitcast %252 : (!hw.struct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>) -> i32
      llhd.drv %218, %253 after %2 : i32
      cf.br ^bb48
    ^bb13:  // pred: ^bb11
      %254 = comb.icmp weq %225, %c22_i8 : i8
      cf.cond_br %254, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %255 = llhd.prb %abstractcs : !hw.struct<zero3: i3, progbufsize: i5, zero2: i11, busy: i1, zero1: i1, cmderr: i3, zero0: i4, datacount: i4>
      %256 = hw.bitcast %255 : (!hw.struct<zero3: i3, progbufsize: i5, zero2: i11, busy: i1, zero1: i1, cmderr: i3, zero0: i4, datacount: i4>) -> i32
      llhd.drv %218, %256 after %2 : i32
      cf.br ^bb48
    ^bb15:  // pred: ^bb13
      %257 = comb.icmp weq %225, %c24_i8 : i8
      cf.cond_br %257, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      %258 = llhd.prb %abstractauto_q : !hw.struct<autoexecprogbuf: i16, zero0: i4, autoexecdata: i12>
      %259 = hw.bitcast %258 : (!hw.struct<autoexecprogbuf: i16, zero0: i4, autoexecdata: i12>) -> i32
      llhd.drv %218, %259 after %2 : i32
      cf.br ^bb48
    ^bb17:  // pred: ^bb15
      %260 = comb.icmp weq %225, %c23_i8 : i8
      cf.cond_br %260, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      llhd.drv %218, %c0_i32 after %2 : i32
      cf.br ^bb48
    ^bb19:  // pred: ^bb17
      %261 = comb.icmp weq %225, %c29_i8 : i8
      cf.cond_br %261, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      %262 = llhd.prb %next_dm_addr_i_2 : i32
      llhd.drv %218, %262 after %2 : i32
      cf.br ^bb48
    ^bb21:  // pred: ^bb19
      %263 = comb.extract %225 from 5 : (i8) -> i3
      %264 = comb.icmp ne %263, %c0_i3 : i3
      %265 = comb.icmp ult %225, %c40_i8 : i8
      %266 = comb.and %264, %265 : i1
      cf.cond_br %266, ^bb22, ^bb26
    ^bb22:  // pred: ^bb21
      %267 = llhd.prb %progbuf_q : !hw.array<8xi32>
      %268 = llhd.prb %dmi_req_i_4 : !hw.struct<addr: i32, op: i2, data: i32>
      %addr_20 = hw.struct_extract %268["addr"] : !hw.struct<addr: i32, op: i2, data: i32>
      %269 = comb.extract %addr_20 from 0 : (i32) -> i3
      %270 = hw.array_get %267[%269] : !hw.array<8xi32>, i3
      llhd.drv %218, %270 after %2 : i32
      %271 = llhd.prb %cmdbusy_i_11 : i1
      %272 = comb.xor %271, %true : i1
      cf.cond_br %272, ^bb23, ^bb24
    ^bb23:  // pred: ^bb22
      %273 = llhd.prb %abstractauto_q : !hw.struct<autoexecprogbuf: i16, zero0: i4, autoexecdata: i12>
      %autoexecprogbuf = hw.struct_extract %273["autoexecprogbuf"] : !hw.struct<autoexecprogbuf: i16, zero0: i4, autoexecdata: i12>
      %274 = llhd.prb %dmi_req_i_4 : !hw.struct<addr: i32, op: i2, data: i32>
      %addr_21 = hw.struct_extract %274["addr"] : !hw.struct<addr: i32, op: i2, data: i32>
      %275 = comb.extract %addr_21 from 0 : (i32) -> i4
      %276 = comb.concat %true, %275 : i1, i4
      %277 = comb.add %276, %c-16_i5 : i5
      %278 = comb.concat %c0_i11, %277 : i11, i5
      %279 = comb.shru %autoexecprogbuf, %278 : i16
      %280 = comb.extract %279 from 0 : (i16) -> i1
      llhd.drv %cmd_valid_d, %280 after %2 : i1
      cf.br ^bb48
    ^bb24:  // pred: ^bb22
      llhd.drv %219, %c-1_i2 after %2 : i2
      %281 = llhd.prb %cmderr_q : i3
      %282 = comb.icmp eq %281, %c0_i3 : i3
      cf.cond_br %282, ^bb25, ^bb48
    ^bb25:  // pred: ^bb24
      llhd.drv %cmderr_d, %c1_i3 after %2 : i3
      cf.br ^bb48
    ^bb26:  // pred: ^bb21
      %283 = comb.icmp weq %225, %c64_i8 : i8
      cf.cond_br %283, ^bb27, ^bb28
    ^bb27:  // pred: ^bb26
      %284 = llhd.prb %haltsum0 : i32
      llhd.drv %218, %284 after %2 : i32
      cf.br ^bb48
    ^bb28:  // pred: ^bb26
      %285 = comb.icmp weq %225, %c19_i8 : i8
      cf.cond_br %285, ^bb29, ^bb30
    ^bb29:  // pred: ^bb28
      %286 = llhd.prb %haltsum1 : i32
      llhd.drv %218, %286 after %2 : i32
      cf.br ^bb48
    ^bb30:  // pred: ^bb28
      %287 = comb.icmp weq %225, %c52_i8 : i8
      cf.cond_br %287, ^bb31, ^bb32
    ^bb31:  // pred: ^bb30
      %288 = llhd.prb %haltsum2 : i32
      llhd.drv %218, %288 after %2 : i32
      cf.br ^bb48
    ^bb32:  // pred: ^bb30
      %289 = comb.icmp weq %225, %c53_i8 : i8
      cf.cond_br %289, ^bb33, ^bb34
    ^bb33:  // pred: ^bb32
      %290 = llhd.prb %haltsum3 : i32
      llhd.drv %218, %290 after %2 : i32
      cf.br ^bb48
    ^bb34:  // pred: ^bb32
      %291 = comb.icmp weq %225, %c56_i8 : i8
      cf.cond_br %291, ^bb35, ^bb36
    ^bb35:  // pred: ^bb34
      %292 = llhd.prb %sbcs_q : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %293 = hw.bitcast %292 : (!hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>) -> i32
      llhd.drv %218, %293 after %2 : i32
      cf.br ^bb48
    ^bb36:  // pred: ^bb34
      %294 = comb.icmp weq %225, %c57_i8 : i8
      cf.cond_br %294, ^bb37, ^bb38
    ^bb37:  // pred: ^bb36
      %295 = llhd.prb %sbaddr_q : i64
      %296 = comb.extract %295 from 0 : (i64) -> i32
      llhd.drv %218, %296 after %2 : i32
      cf.br ^bb48
    ^bb38:  // pred: ^bb36
      %297 = comb.icmp weq %225, %c58_i8 : i8
      cf.cond_br %297, ^bb39, ^bb40
    ^bb39:  // pred: ^bb38
      %298 = llhd.prb %sbaddr_q : i64
      %299 = comb.extract %298 from 32 : (i64) -> i32
      llhd.drv %218, %299 after %2 : i32
      cf.br ^bb48
    ^bb40:  // pred: ^bb38
      %300 = comb.icmp weq %225, %c60_i8 : i8
      cf.cond_br %300, ^bb41, ^bb44
    ^bb41:  // pred: ^bb40
      %301 = llhd.prb %sbbusy_i_17 : i1
      %302 = llhd.prb %sbcs_q : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %sbbusyerror = hw.struct_extract %302["sbbusyerror"] : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %303 = comb.or %301, %sbbusyerror : i1
      cf.cond_br %303, ^bb42, ^bb43
    ^bb42:  // pred: ^bb41
      %304 = llhd.sig.struct_extract %sbcs_d["sbbusyerror"] : <!hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>>
      llhd.drv %304, %true after %2 : i1
      llhd.drv %219, %c-1_i2 after %2 : i2
      cf.br ^bb48
    ^bb43:  // pred: ^bb41
      %305 = llhd.prb %sbcs_q : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %sberror = hw.struct_extract %305["sberror"] : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %306 = comb.icmp eq %sberror, %c0_i3 : i3
      llhd.drv %sbdata_read_valid_o, %306 after %2 : i1
      %307 = llhd.prb %sbdata_q : i64
      %308 = comb.extract %307 from 0 : (i64) -> i32
      llhd.drv %218, %308 after %2 : i32
      cf.br ^bb48
    ^bb44:  // pred: ^bb40
      %309 = comb.icmp weq %225, %c61_i8 : i8
      cf.cond_br %309, ^bb45, ^bb48
    ^bb45:  // pred: ^bb44
      %310 = llhd.prb %sbbusy_i_17 : i1
      %311 = llhd.prb %sbcs_q : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %sbbusyerror_22 = hw.struct_extract %311["sbbusyerror"] : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %312 = comb.or %310, %sbbusyerror_22 : i1
      cf.cond_br %312, ^bb46, ^bb47
    ^bb46:  // pred: ^bb45
      %313 = llhd.sig.struct_extract %sbcs_d["sbbusyerror"] : <!hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>>
      llhd.drv %313, %true after %2 : i1
      llhd.drv %219, %c-1_i2 after %2 : i2
      cf.br ^bb48
    ^bb47:  // pred: ^bb45
      %314 = llhd.prb %sbdata_q : i64
      %315 = comb.extract %314 from 32 : (i64) -> i32
      llhd.drv %218, %315 after %2 : i32
      cf.br ^bb48
    ^bb48:  // 26 preds: ^bb1, ^bb4, ^bb5, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb18, ^bb20, ^bb23, ^bb24, ^bb25, ^bb27, ^bb29, ^bb31, ^bb33, ^bb35, ^bb37, ^bb39, ^bb42, ^bb43, ^bb44, ^bb46, ^bb47
      %316 = llhd.prb %dmi_req_ready_o : i1
      %317 = llhd.prb %dmi_req_valid_i_3 : i1
      %318 = llhd.prb %dtm_op : i2
      %319 = comb.icmp eq %318, %c-2_i2 : i2
      %320 = comb.and %316, %317, %319 : i1
      cf.cond_br %320, ^bb49, ^bb100
    ^bb49:  // pred: ^bb48
      %321 = llhd.prb %dm_csr_addr : i8
      %322 = comb.extract %321 from 2 : (i8) -> i6
      %323 = comb.icmp ne %322, %c0_i6 : i6
      %324 = comb.icmp ult %321, %c6_i8 : i8
      %325 = comb.and %323, %324 : i1
      cf.cond_br %325, ^bb50, ^bb54
    ^bb50:  // pred: ^bb49
      %326 = llhd.prb %cmdbusy_i_11 : i1
      %327 = comb.xor %326, %true : i1
      cf.cond_br %327, ^bb51, ^bb52
    ^bb51:  // pred: ^bb50
      %328 = llhd.prb %dmi_req_i_4 : !hw.struct<addr: i32, op: i2, data: i32>
      %addr_23 = hw.struct_extract %328["addr"] : !hw.struct<addr: i32, op: i2, data: i32>
      %329 = comb.extract %addr_23 from 0 : (i32) -> i1
      %330 = llhd.sig.array_get %data_d[%329] : <!hw.array<2xi32>>
      %data = hw.struct_extract %328["data"] : !hw.struct<addr: i32, op: i2, data: i32>
      llhd.drv %330, %data after %2 : i32
      %331 = llhd.prb %abstractauto_q : !hw.struct<autoexecprogbuf: i16, zero0: i4, autoexecdata: i12>
      %autoexecdata_24 = hw.struct_extract %331["autoexecdata"] : !hw.struct<autoexecprogbuf: i16, zero0: i4, autoexecdata: i12>
      %332 = llhd.prb %autoexecdata_idx : i4
      %333 = comb.concat %c0_i8, %332 : i8, i4
      %334 = comb.shru %autoexecdata_24, %333 : i12
      %335 = comb.extract %334 from 0 : (i12) -> i1
      llhd.drv %cmd_valid_d, %335 after %2 : i1
      cf.br ^bb100
    ^bb52:  // pred: ^bb50
      llhd.drv %219, %c-1_i2 after %2 : i2
      %336 = llhd.prb %cmderr_q : i3
      %337 = comb.icmp eq %336, %c0_i3 : i3
      cf.cond_br %337, ^bb53, ^bb100
    ^bb53:  // pred: ^bb52
      llhd.drv %cmderr_d, %c1_i3 after %2 : i3
      cf.br ^bb100
    ^bb54:  // pred: ^bb49
      %338 = comb.icmp weq %321, %c16_i8 : i8
      cf.cond_br %338, ^bb55, ^bb57
    ^bb55:  // pred: ^bb54
      %339 = llhd.prb %dmi_req_i_4 : !hw.struct<addr: i32, op: i2, data: i32>
      %data_25 = hw.struct_extract %339["data"] : !hw.struct<addr: i32, op: i2, data: i32>
      %340 = hw.bitcast %data_25 : (i32) -> !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
      llhd.drv %dmcontrol_d, %340 after %2 : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
      %341 = llhd.prb %dmcontrol_d : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
      %ackhavereset = hw.struct_extract %341["ackhavereset"] : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
      cf.cond_br %ackhavereset, ^bb56, ^bb100
    ^bb56:  // pred: ^bb55
      %342 = llhd.prb %selected_hart : i1
      %343 = llhd.sig.extract %havereset_d_aligned from %342 : <i2> -> <i1>
      llhd.drv %343, %false after %2 : i1
      cf.br ^bb100
    ^bb57:  // pred: ^bb54
      %344 = comb.icmp weq %321, %c17_i8 : i8
      cf.cond_br %344, ^bb100, ^bb58
    ^bb58:  // pred: ^bb57
      %345 = comb.icmp weq %321, %c18_i8 : i8
      cf.cond_br %345, ^bb100, ^bb59
    ^bb59:  // pred: ^bb58
      %346 = comb.icmp weq %321, %c22_i8 : i8
      cf.cond_br %346, ^bb60, ^bb64
    ^bb60:  // pred: ^bb59
      %347 = llhd.prb %dmi_req_i_4 : !hw.struct<addr: i32, op: i2, data: i32>
      %data_26 = hw.struct_extract %347["data"] : !hw.struct<addr: i32, op: i2, data: i32>
      %348 = hw.bitcast %data_26 : (i32) -> !hw.struct<zero3: i3, progbufsize: i5, zero2: i11, busy: i1, zero1: i1, cmderr: i3, zero0: i4, datacount: i4>
      llhd.drv %a_abstractcs, %348 after %2 : !hw.struct<zero3: i3, progbufsize: i5, zero2: i11, busy: i1, zero1: i1, cmderr: i3, zero0: i4, datacount: i4>
      %349 = llhd.prb %cmdbusy_i_11 : i1
      %350 = comb.xor %349, %true : i1
      cf.cond_br %350, ^bb61, ^bb62
    ^bb61:  // pred: ^bb60
      %351 = llhd.prb %a_abstractcs : !hw.struct<zero3: i3, progbufsize: i5, zero2: i11, busy: i1, zero1: i1, cmderr: i3, zero0: i4, datacount: i4>
      %cmderr = hw.struct_extract %351["cmderr"] : !hw.struct<zero3: i3, progbufsize: i5, zero2: i11, busy: i1, zero1: i1, cmderr: i3, zero0: i4, datacount: i4>
      %352 = comb.xor %cmderr, %c-1_i3 : i3
      %353 = llhd.prb %cmderr_q : i3
      %354 = comb.and %352, %353 : i3
      llhd.drv %cmderr_d, %354 after %2 : i3
      cf.br ^bb100
    ^bb62:  // pred: ^bb60
      llhd.drv %219, %c-1_i2 after %2 : i2
      %355 = llhd.prb %cmderr_q : i3
      %356 = comb.icmp eq %355, %c0_i3 : i3
      cf.cond_br %356, ^bb63, ^bb100
    ^bb63:  // pred: ^bb62
      llhd.drv %cmderr_d, %c1_i3 after %2 : i3
      cf.br ^bb100
    ^bb64:  // pred: ^bb59
      %357 = comb.icmp weq %321, %c23_i8 : i8
      cf.cond_br %357, ^bb65, ^bb69
    ^bb65:  // pred: ^bb64
      %358 = llhd.prb %cmdbusy_i_11 : i1
      %359 = comb.xor %358, %true : i1
      cf.cond_br %359, ^bb66, ^bb67
    ^bb66:  // pred: ^bb65
      llhd.drv %cmd_valid_d, %true after %2 : i1
      %360 = llhd.prb %dmi_req_i_4 : !hw.struct<addr: i32, op: i2, data: i32>
      %data_27 = hw.struct_extract %360["data"] : !hw.struct<addr: i32, op: i2, data: i32>
      %361 = hw.bitcast %data_27 : (i32) -> !hw.struct<cmdtype: i8, control: i24>
      llhd.drv %command_d, %361 after %2 : !hw.struct<cmdtype: i8, control: i24>
      cf.br ^bb100
    ^bb67:  // pred: ^bb65
      llhd.drv %219, %c-1_i2 after %2 : i2
      %362 = llhd.prb %cmderr_q : i3
      %363 = comb.icmp eq %362, %c0_i3 : i3
      cf.cond_br %363, ^bb68, ^bb100
    ^bb68:  // pred: ^bb67
      llhd.drv %cmderr_d, %c1_i3 after %2 : i3
      cf.br ^bb100
    ^bb69:  // pred: ^bb64
      %364 = comb.icmp weq %321, %c29_i8 : i8
      cf.cond_br %364, ^bb100, ^bb70
    ^bb70:  // pred: ^bb69
      %365 = comb.icmp weq %321, %c24_i8 : i8
      cf.cond_br %365, ^bb71, ^bb75
    ^bb71:  // pred: ^bb70
      %366 = llhd.prb %cmdbusy_i_11 : i1
      %367 = comb.xor %366, %true : i1
      cf.cond_br %367, ^bb72, ^bb73
    ^bb72:  // pred: ^bb71
      llhd.drv %abstractauto_d, %7 after %2 : !hw.struct<autoexecprogbuf: i16, zero0: i4, autoexecdata: i12>
      %368 = llhd.sig.struct_extract %abstractauto_d["autoexecdata"] : <!hw.struct<autoexecprogbuf: i16, zero0: i4, autoexecdata: i12>>
      %369 = llhd.prb %dmi_req_i_4 : !hw.struct<addr: i32, op: i2, data: i32>
      %data_28 = hw.struct_extract %369["data"] : !hw.struct<addr: i32, op: i2, data: i32>
      %370 = comb.extract %data_28 from 0 : (i32) -> i2
      %371 = comb.concat %c0_i10, %370 : i10, i2
      llhd.drv %368, %371 after %2 : i12
      %372 = llhd.sig.struct_extract %abstractauto_d["autoexecprogbuf"] : <!hw.struct<autoexecprogbuf: i16, zero0: i4, autoexecdata: i12>>
      %373 = llhd.prb %dmi_req_i_4 : !hw.struct<addr: i32, op: i2, data: i32>
      %data_29 = hw.struct_extract %373["data"] : !hw.struct<addr: i32, op: i2, data: i32>
      %374 = comb.extract %data_29 from 16 : (i32) -> i8
      %375 = comb.concat %c0_i8, %374 : i8, i8
      llhd.drv %372, %375 after %2 : i16
      cf.br ^bb100
    ^bb73:  // pred: ^bb71
      llhd.drv %219, %c-1_i2 after %2 : i2
      %376 = llhd.prb %cmderr_q : i3
      %377 = comb.icmp eq %376, %c0_i3 : i3
      cf.cond_br %377, ^bb74, ^bb100
    ^bb74:  // pred: ^bb73
      llhd.drv %cmderr_d, %c1_i3 after %2 : i3
      cf.br ^bb100
    ^bb75:  // pred: ^bb70
      %378 = comb.extract %321 from 5 : (i8) -> i3
      %379 = comb.icmp ne %378, %c0_i3 : i3
      %380 = comb.icmp ult %321, %c40_i8 : i8
      %381 = comb.and %379, %380 : i1
      cf.cond_br %381, ^bb76, ^bb80
    ^bb76:  // pred: ^bb75
      %382 = llhd.prb %cmdbusy_i_11 : i1
      %383 = comb.xor %382, %true : i1
      cf.cond_br %383, ^bb77, ^bb78
    ^bb77:  // pred: ^bb76
      %384 = llhd.prb %dmi_req_i_4 : !hw.struct<addr: i32, op: i2, data: i32>
      %addr_30 = hw.struct_extract %384["addr"] : !hw.struct<addr: i32, op: i2, data: i32>
      %385 = comb.extract %addr_30 from 0 : (i32) -> i3
      %386 = llhd.sig.array_get %progbuf_d[%385] : <!hw.array<8xi32>>
      %data_31 = hw.struct_extract %384["data"] : !hw.struct<addr: i32, op: i2, data: i32>
      llhd.drv %386, %data_31 after %2 : i32
      %387 = llhd.prb %abstractauto_q : !hw.struct<autoexecprogbuf: i16, zero0: i4, autoexecdata: i12>
      %autoexecprogbuf_32 = hw.struct_extract %387["autoexecprogbuf"] : !hw.struct<autoexecprogbuf: i16, zero0: i4, autoexecdata: i12>
      %388 = llhd.prb %dmi_req_i_4 : !hw.struct<addr: i32, op: i2, data: i32>
      %addr_33 = hw.struct_extract %388["addr"] : !hw.struct<addr: i32, op: i2, data: i32>
      %389 = comb.extract %addr_33 from 0 : (i32) -> i4
      %390 = comb.concat %true, %389 : i1, i4
      %391 = comb.add %390, %c-16_i5 : i5
      %392 = comb.concat %c0_i11, %391 : i11, i5
      %393 = comb.shru %autoexecprogbuf_32, %392 : i16
      %394 = comb.extract %393 from 0 : (i16) -> i1
      llhd.drv %cmd_valid_d, %394 after %2 : i1
      cf.br ^bb100
    ^bb78:  // pred: ^bb76
      llhd.drv %219, %c-1_i2 after %2 : i2
      %395 = llhd.prb %cmderr_q : i3
      %396 = comb.icmp eq %395, %c0_i3 : i3
      cf.cond_br %396, ^bb79, ^bb100
    ^bb79:  // pred: ^bb78
      llhd.drv %cmderr_d, %c1_i3 after %2 : i3
      cf.br ^bb100
    ^bb80:  // pred: ^bb75
      %397 = comb.icmp weq %321, %c56_i8 : i8
      cf.cond_br %397, ^bb81, ^bb84
    ^bb81:  // pred: ^bb80
      %398 = llhd.prb %sbbusy_i_17 : i1
      cf.cond_br %398, ^bb82, ^bb83
    ^bb82:  // pred: ^bb81
      %399 = llhd.sig.struct_extract %sbcs_d["sbbusyerror"] : <!hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>>
      llhd.drv %399, %true after %2 : i1
      llhd.drv %219, %c-1_i2 after %2 : i2
      cf.br ^bb100
    ^bb83:  // pred: ^bb81
      %400 = llhd.prb %dmi_req_i_4 : !hw.struct<addr: i32, op: i2, data: i32>
      %data_34 = hw.struct_extract %400["data"] : !hw.struct<addr: i32, op: i2, data: i32>
      %401 = hw.bitcast %data_34 : (i32) -> !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      llhd.drv %sbcs, %401 after %2 : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %402 = llhd.prb %sbcs : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      llhd.drv %sbcs_d, %402 after %2 : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %403 = llhd.sig.struct_extract %sbcs_d["sbbusyerror"] : <!hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>>
      %404 = llhd.prb %sbcs_q : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %sbbusyerror_35 = hw.struct_extract %404["sbbusyerror"] : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %405 = llhd.prb %sbcs : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %sbbusyerror_36 = hw.struct_extract %405["sbbusyerror"] : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %406 = comb.xor %sbbusyerror_36, %true : i1
      %407 = comb.and %sbbusyerror_35, %406 : i1
      llhd.drv %403, %407 after %2 : i1
      %408 = llhd.sig.struct_extract %sbcs_d["sberror"] : <!hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>>
      %409 = llhd.prb %sbcs : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %sberror_37 = hw.struct_extract %409["sberror"] : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %410 = comb.icmp ne %sberror_37, %c0_i3 : i3
      %411 = llhd.prb %sbcs_q : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %sberror_38 = hw.struct_extract %411["sberror"] : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %412 = comb.mux %410, %c0_i3, %sberror_38 : i3
      llhd.drv %408, %412 after %2 : i3
      cf.br ^bb100
    ^bb84:  // pred: ^bb80
      %413 = comb.icmp weq %321, %c57_i8 : i8
      cf.cond_br %413, ^bb85, ^bb88
    ^bb85:  // pred: ^bb84
      %414 = llhd.prb %sbbusy_i_17 : i1
      %415 = llhd.prb %sbcs_q : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %sbbusyerror_39 = hw.struct_extract %415["sbbusyerror"] : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %416 = comb.or %414, %sbbusyerror_39 : i1
      cf.cond_br %416, ^bb86, ^bb87
    ^bb86:  // pred: ^bb85
      %417 = llhd.sig.struct_extract %sbcs_d["sbbusyerror"] : <!hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>>
      llhd.drv %417, %true after %2 : i1
      llhd.drv %219, %c-1_i2 after %2 : i2
      cf.br ^bb100
    ^bb87:  // pred: ^bb85
      %418 = llhd.sig.extract %sbaddr_d from %c0_i6 : <i64> -> <i32>
      %419 = llhd.prb %dmi_req_i_4 : !hw.struct<addr: i32, op: i2, data: i32>
      %data_40 = hw.struct_extract %419["data"] : !hw.struct<addr: i32, op: i2, data: i32>
      llhd.drv %418, %data_40 after %2 : i32
      %420 = llhd.prb %sbcs_q : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %sberror_41 = hw.struct_extract %420["sberror"] : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %421 = comb.icmp eq %sberror_41, %c0_i3 : i3
      llhd.drv %sbaddress_write_valid_o, %421 after %2 : i1
      cf.br ^bb100
    ^bb88:  // pred: ^bb84
      %422 = comb.icmp weq %321, %c58_i8 : i8
      cf.cond_br %422, ^bb89, ^bb92
    ^bb89:  // pred: ^bb88
      %423 = llhd.prb %sbbusy_i_17 : i1
      %424 = llhd.prb %sbcs_q : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %sbbusyerror_42 = hw.struct_extract %424["sbbusyerror"] : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %425 = comb.or %423, %sbbusyerror_42 : i1
      cf.cond_br %425, ^bb90, ^bb91
    ^bb90:  // pred: ^bb89
      %426 = llhd.sig.struct_extract %sbcs_d["sbbusyerror"] : <!hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>>
      llhd.drv %426, %true after %2 : i1
      llhd.drv %219, %c-1_i2 after %2 : i2
      cf.br ^bb100
    ^bb91:  // pred: ^bb89
      %427 = llhd.sig.extract %sbaddr_d from %c-32_i6 : <i64> -> <i32>
      %428 = llhd.prb %dmi_req_i_4 : !hw.struct<addr: i32, op: i2, data: i32>
      %data_43 = hw.struct_extract %428["data"] : !hw.struct<addr: i32, op: i2, data: i32>
      llhd.drv %427, %data_43 after %2 : i32
      cf.br ^bb100
    ^bb92:  // pred: ^bb88
      %429 = comb.icmp weq %321, %c60_i8 : i8
      cf.cond_br %429, ^bb93, ^bb96
    ^bb93:  // pred: ^bb92
      %430 = llhd.prb %sbbusy_i_17 : i1
      %431 = llhd.prb %sbcs_q : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %sbbusyerror_44 = hw.struct_extract %431["sbbusyerror"] : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %432 = comb.or %430, %sbbusyerror_44 : i1
      cf.cond_br %432, ^bb94, ^bb95
    ^bb94:  // pred: ^bb93
      %433 = llhd.sig.struct_extract %sbcs_d["sbbusyerror"] : <!hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>>
      llhd.drv %433, %true after %2 : i1
      llhd.drv %219, %c-1_i2 after %2 : i2
      cf.br ^bb100
    ^bb95:  // pred: ^bb93
      %434 = llhd.sig.extract %sbdata_d from %c0_i6 : <i64> -> <i32>
      %435 = llhd.prb %dmi_req_i_4 : !hw.struct<addr: i32, op: i2, data: i32>
      %data_45 = hw.struct_extract %435["data"] : !hw.struct<addr: i32, op: i2, data: i32>
      llhd.drv %434, %data_45 after %2 : i32
      %436 = llhd.prb %sbcs_q : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %sberror_46 = hw.struct_extract %436["sberror"] : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %437 = comb.icmp eq %sberror_46, %c0_i3 : i3
      llhd.drv %sbdata_write_valid_o, %437 after %2 : i1
      cf.br ^bb100
    ^bb96:  // pred: ^bb92
      %438 = comb.icmp weq %321, %c61_i8 : i8
      cf.cond_br %438, ^bb97, ^bb100
    ^bb97:  // pred: ^bb96
      %439 = llhd.prb %sbbusy_i_17 : i1
      %440 = llhd.prb %sbcs_q : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %sbbusyerror_47 = hw.struct_extract %440["sbbusyerror"] : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %441 = comb.or %439, %sbbusyerror_47 : i1
      cf.cond_br %441, ^bb98, ^bb99
    ^bb98:  // pred: ^bb97
      %442 = llhd.sig.struct_extract %sbcs_d["sbbusyerror"] : <!hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>>
      llhd.drv %442, %true after %2 : i1
      llhd.drv %219, %c-1_i2 after %2 : i2
      cf.br ^bb100
    ^bb99:  // pred: ^bb97
      %443 = llhd.sig.extract %sbdata_d from %c-32_i6 : <i64> -> <i32>
      %444 = llhd.prb %dmi_req_i_4 : !hw.struct<addr: i32, op: i2, data: i32>
      %data_48 = hw.struct_extract %444["data"] : !hw.struct<addr: i32, op: i2, data: i32>
      llhd.drv %443, %data_48 after %2 : i32
      cf.br ^bb100
    ^bb100:  // 32 preds: ^bb48, ^bb51, ^bb52, ^bb53, ^bb55, ^bb56, ^bb57, ^bb58, ^bb61, ^bb62, ^bb63, ^bb66, ^bb67, ^bb68, ^bb69, ^bb72, ^bb73, ^bb74, ^bb77, ^bb78, ^bb79, ^bb82, ^bb83, ^bb86, ^bb87, ^bb90, ^bb91, ^bb94, ^bb95, ^bb96, ^bb98, ^bb99
      %445 = llhd.prb %cmderror_valid_i_9 : i1
      cf.cond_br %445, ^bb101, ^bb102
    ^bb101:  // pred: ^bb100
      %446 = llhd.prb %cmderror_i_10 : i3
      llhd.drv %cmderr_d, %446 after %2 : i3
      cf.br ^bb102
    ^bb102:  // 2 preds: ^bb100, ^bb101
      %447 = llhd.prb %data_valid_i_13 : i1
      cf.cond_br %447, ^bb103, ^bb104
    ^bb103:  // pred: ^bb102
      %448 = llhd.prb %data_i_12 : !hw.array<2xi32>
      llhd.drv %data_d, %448 after %2 : !hw.array<2xi32>
      cf.br ^bb104
    ^bb104:  // 2 preds: ^bb102, ^bb103
      %449 = llhd.prb %ndmreset_ack_i_5 : i1
      cf.cond_br %449, ^bb105, ^bb106
    ^bb105:  // pred: ^bb104
      %450 = llhd.sig.extract %havereset_d_aligned from %false : <i2> -> <i1>
      llhd.drv %450, %true after %2 : i1
      cf.br ^bb106
    ^bb106:  // 2 preds: ^bb104, ^bb105
      %451 = llhd.prb %sberror_valid_i_18 : i1
      cf.cond_br %451, ^bb107, ^bb108
    ^bb107:  // pred: ^bb106
      %452 = llhd.sig.struct_extract %sbcs_d["sberror"] : <!hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>>
      %453 = llhd.prb %sberror_i_19 : i3
      llhd.drv %452, %453 after %2 : i3
      cf.br ^bb108
    ^bb108:  // 2 preds: ^bb106, ^bb107
      %454 = llhd.prb %sbdata_valid_i_16 : i1
      cf.cond_br %454, ^bb109, ^bb110
    ^bb109:  // pred: ^bb108
      %455 = llhd.prb %sbdata_i_15 : i32
      %456 = comb.concat %c0_i32, %455 : i32, i32
      llhd.drv %sbdata_d, %456 after %2 : i64
      cf.br ^bb110
    ^bb110:  // 2 preds: ^bb108, ^bb109
      %457 = llhd.sig.struct_extract %dmcontrol_d["hasel"] : <!hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>>
      llhd.drv %457, %false after %2 : i1
      %458 = llhd.sig.struct_extract %dmcontrol_d["hartreset"] : <!hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>>
      llhd.drv %458, %false after %2 : i1
      %459 = llhd.sig.struct_extract %dmcontrol_d["setresethaltreq"] : <!hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>>
      llhd.drv %459, %false after %2 : i1
      %460 = llhd.sig.struct_extract %dmcontrol_d["clrresethaltreq"] : <!hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>>
      llhd.drv %460, %false after %2 : i1
      %461 = llhd.sig.struct_extract %dmcontrol_d["zero1"] : <!hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>>
      llhd.drv %461, %false after %2 : i1
      %462 = llhd.sig.struct_extract %dmcontrol_d["zero0"] : <!hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>>
      llhd.drv %462, %c0_i2 after %2 : i2
      %463 = llhd.sig.struct_extract %dmcontrol_d["ackhavereset"] : <!hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>>
      llhd.drv %463, %false after %2 : i1
      %464 = llhd.prb %dmcontrol_q : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
      %resumereq = hw.struct_extract %464["resumereq"] : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
      %465 = comb.xor %resumereq, %true : i1
      %466 = llhd.prb %dmcontrol_d : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
      %resumereq_49 = hw.struct_extract %466["resumereq"] : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
      %467 = comb.and %465, %resumereq_49 : i1
      cf.cond_br %467, ^bb111, ^bb112
    ^bb111:  // pred: ^bb110
      llhd.drv %clear_resumeack_o, %true after %2 : i1
      cf.br ^bb112
    ^bb112:  // 2 preds: ^bb110, ^bb111
      %468 = llhd.prb %dmcontrol_q : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
      %resumereq_50 = hw.struct_extract %468["resumereq"] : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
      %469 = llhd.prb %resumeack_i_8 : i1
      %470 = comb.and %resumereq_50, %469 : i1
      cf.cond_br %470, ^bb113, ^bb114
    ^bb113:  // pred: ^bb112
      %471 = llhd.sig.struct_extract %dmcontrol_d["resumereq"] : <!hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>>
      llhd.drv %471, %false after %2 : i1
      cf.br ^bb114
    ^bb114:  // 2 preds: ^bb112, ^bb113
      llhd.drv %hartsel_qp, %c0_i20 after %2 : i20
      %472 = llhd.sig.struct_extract %dmcontrol_d["hartselhi"] : <!hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>>
      %473 = llhd.prb %hartsel_qp : i20
      %474 = comb.extract %473 from 10 : (i20) -> i10
      llhd.drv %472, %474 after %2 : i10
      %475 = llhd.sig.struct_extract %dmcontrol_d["hartsello"] : <!hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>>
      %476 = llhd.prb %hartsel_qp : i20
      %477 = comb.extract %476 from 0 : (i20) -> i10
      llhd.drv %475, %477 after %2 : i10
      %478 = llhd.sig.struct_extract %sbcs_d["sbversion"] : <!hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>>
      llhd.drv %478, %c1_i3 after %2 : i3
      %479 = llhd.sig.struct_extract %sbcs_d["sbbusy"] : <!hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>>
      %480 = llhd.prb %sbbusy_i_17 : i1
      llhd.drv %479, %480 after %2 : i1
      %481 = llhd.sig.struct_extract %sbcs_d["sbasize"] : <!hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>>
      llhd.drv %481, %c32_i7 after %2 : i7
      %482 = llhd.sig.struct_extract %sbcs_d["sbaccess128"] : <!hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>>
      llhd.drv %482, %false after %2 : i1
      %483 = llhd.sig.struct_extract %sbcs_d["sbaccess64"] : <!hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>>
      llhd.drv %483, %false after %2 : i1
      %484 = llhd.sig.struct_extract %sbcs_d["sbaccess32"] : <!hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>>
      llhd.drv %484, %true after %2 : i1
      %485 = llhd.sig.struct_extract %sbcs_d["sbaccess16"] : <!hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>>
      llhd.drv %485, %true after %2 : i1
      %486 = llhd.sig.struct_extract %sbcs_d["sbaccess8"] : <!hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>>
      llhd.drv %486, %true after %2 : i1
      llhd.wait (%60, %61, %62, %63, %64, %25, %65, %66, %67, %68, %69, %70, %52, %50, %44, %71, %72, %73, %74, %75, %76, %77, %78, %39, %79, %80, %81, %40, %82, %19, %83, %84, %85, %86, %87, %88, %89, %90, %18, %91, %57, %92, %22, %93, %94, %95, %96, %97, %98, %99, %100, %101, %46, %102, %103, %54, %104, %24, %30, %34, %38, %42 : !hw.struct<zero1: i9, impebreak: i1, zero0: i2, allhavereset: i1, anyhavereset: i1, allresumeack: i1, anyresumeack: i1, allnonexistent: i1, anynonexistent: i1, allunavail: i1, anyunavail: i1, allrunning: i1, anyrunning: i1, allhalted: i1, anyhalted: i1, authenticated: i1, authbusy: i1, hasresethaltreq: i1, devtreevalid: i1, version: i4>, i2, i1, i2, i2, i20, i2, !hw.struct<zero3: i3, progbufsize: i5, zero2: i11, busy: i1, zero1: i1, cmderr: i3, zero0: i4, datacount: i4>, i1, i3, !hw.struct<autoexecprogbuf: i16, zero0: i4, autoexecdata: i12>, !hw.struct<autoexecprogbuf: i16, zero0: i4, autoexecdata: i12>, i1, i2, !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>, !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>, i3, !hw.struct<cmdtype: i8, control: i24>, !hw.struct<cmdtype: i8, control: i24>, !hw.array<8xi32>, !hw.array<8xi32>, !hw.array<2xi32>, !hw.array<2xi32>, !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>, !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>, i32, i64, i64, i64, !hw.struct<data: i32, resp: i2>, i1, i1, i1, i1, i1, !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>, !hw.struct<zero3: i3, progbufsize: i5, zero2: i11, busy: i1, zero1: i1, cmderr: i3, zero0: i4, datacount: i4>, i1, i1, i2, i8, i4, !hw.struct<addr: i32, op: i2, data: i32>, i1, i3, i1, !hw.array<2xi32>, i1, i1, i3, i1, i32, i1, i20, i1, !hw.array<2xstruct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>>, i32, i32, i32, i32, i32, i64), ^bb1
    }
    %105 = llhd.prb %haltreq_o : i1
    %106 = llhd.prb %resumereq_o : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb3
      %108 = llhd.prb %hartsel_o : i20
      %109 = comb.extract %108 from 0 : (i20) -> i1
      llhd.drv %selected_hart, %109 after %2 : i1
      llhd.drv %haltreq_o, %false after %2 : i1
      llhd.drv %resumereq_o, %false after %2 : i1
      %110 = llhd.prb %selected_hart : i1
      %111 = comb.xor %110, %true : i1
      cf.cond_br %111, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %112 = llhd.prb %selected_hart : i1
      %113 = comb.xor %112, %true : i1
      %114 = comb.extract %112 from 0 : (i1) -> i0
      %115 = comb.mux %113, %114, %c0_i0 : i0
      %116 = llhd.sig.extract %haltreq_o from %115 : <i1> -> <i1>
      %117 = llhd.prb %dmcontrol_q : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
      %haltreq = hw.struct_extract %117["haltreq"] : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
      llhd.drv %116, %haltreq after %2 : i1
      %118 = llhd.prb %selected_hart : i1
      %119 = comb.xor %118, %true : i1
      %120 = comb.extract %118 from 0 : (i1) -> i0
      %121 = comb.mux %119, %120, %c0_i0 : i0
      %122 = llhd.sig.extract %resumereq_o from %121 : <i1> -> <i1>
      %123 = llhd.prb %dmcontrol_q : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
      %resumereq = hw.struct_extract %123["resumereq"] : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
      llhd.drv %122, %resumereq after %2 : i1
      cf.br ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      llhd.wait (%25, %62, %105, %106, %44 : i20, i1, i1, i1, !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>), ^bb1
    }
    %dmactive = hw.struct_extract %44["dmactive"] : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
    %107 = llhd.prb %cmd_valid_q : i1
    %ndmreset = hw.struct_extract %44["ndmreset"] : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %108 = llhd.prb %clk_i_0 : i1
      %109 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%16, %17 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %110 = llhd.prb %clk_i_0 : i1
      %111 = comb.xor bin %108, %true : i1
      %112 = comb.and bin %111, %110 : i1
      %113 = llhd.prb %rst_ni_1 : i1
      %114 = comb.xor bin %113, %true : i1
      %115 = comb.and bin %109, %114 : i1
      %116 = comb.or bin %112, %115 : i1
      cf.cond_br %116, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %117 = llhd.prb %rst_ni_1 : i1
      %118 = comb.xor %117, %true : i1
      cf.cond_br %118, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %dmcontrol_q, %10 after %1 : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
      llhd.drv %cmderr_q, %c0_i3 after %1 : i3
      llhd.drv %command_q, %8 after %1 : !hw.struct<cmdtype: i8, control: i24>
      llhd.drv %cmd_valid_q, %false after %1 : i1
      llhd.drv %abstractauto_q, %7 after %1 : !hw.struct<autoexecprogbuf: i16, zero0: i4, autoexecdata: i12>
      llhd.drv %progbuf_q, %5 after %1 : !hw.array<8xi32>
      llhd.drv %data_q, %13 after %1 : !hw.array<2xi32>
      llhd.drv %sbcs_q, %0 after %1 : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      llhd.drv %sbaddr_q, %c0_i64 after %1 : i64
      llhd.drv %sbdata_q, %c0_i64 after %1 : i64
      llhd.drv %havereset_q, %true after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %119 = llhd.prb %havereset_d : i1
      llhd.drv %havereset_q, %119 after %1 : i1
      %120 = llhd.prb %dmcontrol_q : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
      %dmactive_20 = hw.struct_extract %120["dmactive"] : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
      %121 = comb.xor %dmactive_20, %true : i1
      cf.cond_br %121, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %122 = llhd.sig.struct_extract %dmcontrol_q["haltreq"] : <!hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>>
      llhd.drv %122, %false after %1 : i1
      %123 = llhd.sig.struct_extract %dmcontrol_q["resumereq"] : <!hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>>
      llhd.drv %123, %false after %1 : i1
      %124 = llhd.sig.struct_extract %dmcontrol_q["hartreset"] : <!hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>>
      llhd.drv %124, %false after %1 : i1
      %125 = llhd.sig.struct_extract %dmcontrol_q["ackhavereset"] : <!hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>>
      llhd.drv %125, %false after %1 : i1
      %126 = llhd.sig.struct_extract %dmcontrol_q["zero1"] : <!hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>>
      llhd.drv %126, %false after %1 : i1
      %127 = llhd.sig.struct_extract %dmcontrol_q["hasel"] : <!hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>>
      llhd.drv %127, %false after %1 : i1
      %128 = llhd.sig.struct_extract %dmcontrol_q["hartsello"] : <!hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>>
      llhd.drv %128, %c0_i10 after %1 : i10
      %129 = llhd.sig.struct_extract %dmcontrol_q["hartselhi"] : <!hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>>
      llhd.drv %129, %c0_i10 after %1 : i10
      %130 = llhd.sig.struct_extract %dmcontrol_q["zero0"] : <!hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>>
      llhd.drv %130, %c0_i2 after %1 : i2
      %131 = llhd.sig.struct_extract %dmcontrol_q["setresethaltreq"] : <!hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>>
      llhd.drv %131, %false after %1 : i1
      %132 = llhd.sig.struct_extract %dmcontrol_q["clrresethaltreq"] : <!hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>>
      llhd.drv %132, %false after %1 : i1
      %133 = llhd.sig.struct_extract %dmcontrol_q["ndmreset"] : <!hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>>
      llhd.drv %133, %false after %1 : i1
      %134 = llhd.sig.struct_extract %dmcontrol_q["dmactive"] : <!hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>>
      %135 = llhd.prb %dmcontrol_d : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
      %dmactive_21 = hw.struct_extract %135["dmactive"] : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
      llhd.drv %134, %dmactive_21 after %1 : i1
      llhd.drv %cmderr_q, %c0_i3 after %1 : i3
      llhd.drv %command_q, %8 after %1 : !hw.struct<cmdtype: i8, control: i24>
      llhd.drv %cmd_valid_q, %false after %1 : i1
      llhd.drv %abstractauto_q, %7 after %1 : !hw.struct<autoexecprogbuf: i16, zero0: i4, autoexecdata: i12>
      llhd.drv %progbuf_q, %5 after %1 : !hw.array<8xi32>
      llhd.drv %data_q, %13 after %1 : !hw.array<2xi32>
      llhd.drv %sbcs_q, %0 after %1 : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      llhd.drv %sbaddr_q, %c0_i64 after %1 : i64
      llhd.drv %sbdata_q, %c0_i64 after %1 : i64
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %136 = llhd.prb %dmcontrol_d : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
      llhd.drv %dmcontrol_q, %136 after %1 : !hw.struct<haltreq: i1, resumereq: i1, hartreset: i1, ackhavereset: i1, zero1: i1, hasel: i1, hartsello: i10, hartselhi: i10, zero0: i2, setresethaltreq: i1, clrresethaltreq: i1, ndmreset: i1, dmactive: i1>
      %137 = llhd.prb %cmderr_d : i3
      llhd.drv %cmderr_q, %137 after %1 : i3
      %138 = llhd.prb %command_d : !hw.struct<cmdtype: i8, control: i24>
      llhd.drv %command_q, %138 after %1 : !hw.struct<cmdtype: i8, control: i24>
      %139 = llhd.prb %cmd_valid_d : i1
      llhd.drv %cmd_valid_q, %139 after %1 : i1
      %140 = llhd.prb %abstractauto_d : !hw.struct<autoexecprogbuf: i16, zero0: i4, autoexecdata: i12>
      llhd.drv %abstractauto_q, %140 after %1 : !hw.struct<autoexecprogbuf: i16, zero0: i4, autoexecdata: i12>
      %141 = llhd.prb %progbuf_d : !hw.array<8xi32>
      llhd.drv %progbuf_q, %141 after %1 : !hw.array<8xi32>
      %142 = llhd.prb %data_d : !hw.array<2xi32>
      llhd.drv %data_q, %142 after %1 : !hw.array<2xi32>
      %143 = llhd.prb %sbcs_d : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      llhd.drv %sbcs_q, %143 after %1 : !hw.struct<sbversion: i3, zero0: i6, sbbusyerror: i1, sbbusy: i1, sbreadonaddr: i1, sbaccess: i3, sbautoincrement: i1, sbreadondata: i1, sberror: i3, sbasize: i7, sbaccess128: i1, sbaccess64: i1, sbaccess32: i1, sbaccess16: i1, sbaccess8: i1>
      %144 = llhd.prb %sbaddr_d : i64
      llhd.drv %sbaddr_q, %144 after %1 : i64
      %145 = llhd.prb %sbdata_d : i64
      llhd.drv %sbdata_q, %145 after %1 : i64
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %2 : i1
    llhd.drv %rst_ni_1, %rst_ni after %2 : i1
    llhd.drv %next_dm_addr_i_2, %next_dm_addr_i after %2 : i32
    llhd.drv %dmi_req_valid_i_3, %dmi_req_valid_i after %2 : i1
    llhd.drv %dmi_req_i_4, %dmi_req_i after %2 : !hw.struct<addr: i32, op: i2, data: i32>
    llhd.drv %ndmreset_ack_i_5, %ndmreset_ack_i after %2 : i1
    llhd.drv %hartinfo_i_6, %hartinfo_i after %2 : !hw.array<1xstruct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>>
    llhd.drv %halted_i_7, %halted_i after %2 : i1
    llhd.drv %resumeack_i_8, %resumeack_i after %2 : i1
    llhd.drv %cmderror_valid_i_9, %cmderror_valid_i after %2 : i1
    llhd.drv %cmderror_i_10, %cmderror_i after %2 : i3
    llhd.drv %cmdbusy_i_11, %cmdbusy_i after %2 : i1
    llhd.drv %data_i_12, %data_i after %2 : !hw.array<2xi32>
    llhd.drv %data_valid_i_13, %data_valid_i after %2 : i1
    llhd.drv %sbaddress_i_14, %sbaddress_i after %2 : i32
    llhd.drv %sbdata_i_15, %sbdata_i after %2 : i32
    llhd.drv %sbdata_valid_i_16, %sbdata_valid_i after %2 : i1
    llhd.drv %sbbusy_i_17, %sbbusy_i after %2 : i1
    llhd.drv %sberror_valid_i_18, %sberror_valid_i after %2 : i1
    llhd.drv %sberror_i_19, %sberror_i after %2 : i3
    hw.output %90, %i_fifo.rvalid_o, %21, %ndmreset, %dmactive, %25, %105, %106, %87, %107, %73, %75, %77, %43, %84, %sbreadonaddr, %sbautoincrement, %sbaccess, %sbreadondata, %41, %85, %86 : i1, i1, !hw.struct<data: i32, resp: i2>, i1, i1, i20, i1, i1, i1, i1, !hw.struct<cmdtype: i8, control: i24>, !hw.array<8xi32>, !hw.array<2xi32>, i32, i1, i1, i1, i3, i1, i32, i1, i1
  }
  hw.module private @dm_mem(in %clk_i : i1, in %rst_ni : i1, out debug_req_o : i1, in %ndmreset_i : i1, in %hartsel_i : i20, in %haltreq_i : i1, in %resumereq_i : i1, in %clear_resumeack_i : i1, out halted_o : i1, out resuming_o : i1, in %progbuf_i : !hw.array<8xi32>, in %data_i : !hw.array<2xi32>, out data_o : !hw.array<2xi32>, out data_valid_o : i1, in %cmd_valid_i : i1, in %cmd_i : !hw.struct<cmdtype: i8, control: i24>, out cmderror_valid_o : i1, out cmderror_o : i3, out cmdbusy_o : i1, in %req_i : i1, in %we_i : i1, in %addr_i : i32, in %wdata_i : i32, in %be_i : i4, out rdata_o : i32, out err_o : i1) {
    %0 = hw.aggregate_constant [0, 0, 0] : !hw.array<3xi64>
    %c0_i12 = hw.constant 0 : i12
    %c-1024_i12 = hw.constant -1024 : i12
    %c864_i12 = hw.constant 864 : i12
    %c823_i12 = hw.constant 823 : i12
    %c863_i12 = hw.constant 863 : i12
    %c58720367_i64 = hw.constant 58720367 : i64
    %c100663407_i64 = hw.constant 100663407 : i64
    %c1350565999_i64 = hw.constant 1350565999 : i64
    %c-4_i29 = hw.constant -4 : i29
    %c0_i30 = hw.constant 0 : i30
    %c-224_i32 = hw.constant -224 : i32
    %c904_i12 = hw.constant 904 : i12
    %c895_i12 = hw.constant 895 : i12
    %c0_i29 = hw.constant 0 : i29
    %c-3_i3 = hw.constant -3 : i3
    %c1_i3 = hw.constant 1 : i3
    %c-32_i6 = hw.constant -32 : i6
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i5 = hw.constant -1 : i5
    %c0_i27 = hw.constant 0 : i27
    %c0_i31 = hw.constant 0 : i31
    %c0_i28 = hw.constant 0 : i28
    %c0_i22 = hw.constant 0 : i22
    %2 = llhd.constant_time <0ns, 0d, 1e>
    %3 = hw.aggregate_constant [0 : i8, 0 : i8, 0 : i8, 0 : i8, 0 : i8, 0 : i8, 0 : i8, 0 : i8] : !hw.array<8xi8>
    %4 = hw.aggregate_constant [false, 0 : i3, false, false, false, false, 0 : i16] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
    %5 = hw.aggregate_constant [0, 0, 0, 0, 0, 0, 0, 0] : !hw.array<8xi64>
    %6 = hw.aggregate_constant [0, 0, 0, 0] : !hw.array<4xi64>
    %c0_i4 = hw.constant 0 : i4
    %7 = hw.aggregate_constant [0 : i8, 0 : i24] : !hw.struct<cmdtype: i8, control: i24>
    %8 = hw.aggregate_constant [0 : i32, 0 : i32] : !hw.array<2xi32>
    %c2066752627_i32 = hw.constant 2066752627 : i32
    %c2065704051_i32 = hw.constant 2065704051 : i32
    %c2067009651_i32 = hw.constant 2067009651 : i32
    %c8_i5 = hw.constant 8 : i5
    %c2065961075_i32 = hw.constant 2065961075 : i32
    %c10_i5 = hw.constant 10 : i5
    %c2067075187_i32 = hw.constant 2067075187 : i32
    %c3_i32 = hw.constant 3 : i32
    %c1048691_i32 = hw.constant 1048691 : i32
    %c2066752883_i32 = hw.constant 2066752883 : i32
    %c12915987_i32 = hw.constant 12915987 : i32
    %c12932371_i32 = hw.constant 12932371 : i32
    %c19_i32 = hw.constant 19 : i32
    %c1303_i32 = hw.constant 1303 : i32
    %c0_i32 = hw.constant 0 : i32
    %c1_i4 = hw.constant 1 : i4
    %c-1_i4 = hw.constant -1 : i4
    %c0_i6 = hw.constant 0 : i6
    %true = hw.constant true
    %c0_i3 = hw.constant 0 : i3
    %c0_i8 = hw.constant 0 : i8
    %c768_i12 = hw.constant 768 : i12
    %c4_i32 = hw.constant 4 : i32
    %c1_i32 = hw.constant 1 : i32
    %c2_i32 = hw.constant 2 : i32
    %c896_i12 = hw.constant 896 : i12
    %c280_i12 = hw.constant 280 : i12
    %c272_i12 = hw.constant 272 : i12
    %c264_i12 = hw.constant 264 : i12
    %c256_i12 = hw.constant 256 : i12
    %c0_i64 = hw.constant 0 : i64
    %c3_i3 = hw.constant 3 : i3
    %c2_i3 = hw.constant 2 : i3
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c-4_i3 = hw.constant -4 : i3
    %c1_i2 = hw.constant 1 : i2
    %c0_i2 = hw.constant 0 : i2
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %9 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %10 = llhd.prb %rst_ni_1 : i1
    %ndmreset_i_2 = llhd.sig name "ndmreset_i" %false : i1
    %clear_resumeack_i_3 = llhd.sig name "clear_resumeack_i" %false : i1
    %data_i_4 = llhd.sig name "data_i" %8 : !hw.array<2xi32>
    %data_o = llhd.sig %8 : !hw.array<2xi32>
    %data_valid_o = llhd.sig %false : i1
    %cmd_valid_i_5 = llhd.sig name "cmd_valid_i" %false : i1
    %cmd_i_6 = llhd.sig name "cmd_i" %7 : !hw.struct<cmdtype: i8, control: i24>
    %cmderror_valid_o = llhd.sig %false : i1
    %cmderror_o = llhd.sig %c0_i3 : i3
    %cmdbusy_o = llhd.sig %false : i1
    %req_i_7 = llhd.sig name "req_i" %false : i1
    %we_i_8 = llhd.sig name "we_i" %false : i1
    %addr_i_9 = llhd.sig name "addr_i" %c0_i32 : i32
    %wdata_i_10 = llhd.sig name "wdata_i" %c0_i32 : i32
    %be_i_11 = llhd.sig name "be_i" %c0_i4 : i4
    %progbuf = llhd.sig %6 : !hw.array<4xi64>
    %abstract_cmd = llhd.sig %5 : !hw.array<8xi64>
    %halted_d = llhd.sig %false : i1
    %halted_q = llhd.sig %false : i1
    %resuming_d = llhd.sig %false : i1
    %resuming_q = llhd.sig %false : i1
    %resume = llhd.sig %false : i1
    %go = llhd.sig %false : i1
    %going = llhd.sig %false : i1
    %exception = llhd.sig %false : i1
    %unsupported_command = llhd.sig %false : i1
    %rom_rdata = llhd.sig %c0_i64 : i64
    %rdata_d = llhd.sig %c0_i64 : i64
    %rdata_q = llhd.sig %c0_i64 : i64
    %word_enable32_q = llhd.sig %false : i1
    %hartsel = llhd.sig %false : i1
    %wdata_hartsel = llhd.sig %false : i1
    %resumereq_aligned = llhd.sig %c0_i2 : i2
    %haltreq_aligned = llhd.sig %c0_i2 : i2
    %halted_d_aligned = llhd.sig %c0_i2 : i2
    %halted_q_aligned = llhd.sig %c0_i2 : i2
    %halted_aligned = llhd.sig %c0_i2 : i2
    %resumereq_wdata_aligned = llhd.sig %c0_i2 : i2
    %resuming_d_aligned = llhd.sig %c0_i2 : i2
    %resuming_q_aligned = llhd.sig %c0_i2 : i2
    %fwd_rom_d = llhd.sig %false : i1
    %fwd_rom_q = llhd.sig %false : i1
    %ac_ar = llhd.sig %4 : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
    %state_d = llhd.sig %c0_i2 : i2
    %state_q = llhd.sig %c0_i2 : i2
    %word_mux = llhd.sig %c0_i64 : i64
    %data_bits = llhd.sig %8 : !hw.array<2xi32>
    %rdata = llhd.sig %3 : !hw.array<8xi8>
    %err_d = llhd.sig %false : i1
    %err_q = llhd.sig %false : i1
    %11 = llhd.prb %req_i_7 : i1
    %gen_rom_snd_scratch.i_debug_rom.rdata_o = hw.instance "gen_rom_snd_scratch.i_debug_rom" @debug_rom(clk_i: %9: i1, rst_ni: %10: i1, req_i: %11: i1, addr_i: %73: i64) -> (rdata_o: i64)
    llhd.drv %rom_rdata, %gen_rom_snd_scratch.i_debug_rom.rdata_o after %2 : i64
    %12 = comb.extract %hartsel_i from 0 : (i20) -> i1
    llhd.drv %hartsel, %12 after %2 : i1
    %13 = llhd.prb %wdata_i_10 : i32
    %14 = comb.extract %13 from 0 : (i32) -> i1
    llhd.drv %wdata_hartsel, %14 after %2 : i1
    %15 = comb.concat %false, %resumereq_i : i1, i1
    llhd.drv %resumereq_aligned, %15 after %2 : i2
    %16 = comb.concat %false, %haltreq_i : i1, i1
    llhd.drv %haltreq_aligned, %16 after %2 : i2
    llhd.drv %resumereq_wdata_aligned, %15 after %2 : i2
    %17 = llhd.prb %halted_q : i1
    %18 = comb.concat %false, %17 : i1, i1
    llhd.drv %halted_q_aligned, %18 after %2 : i2
    %19 = llhd.prb %halted_d_aligned : i2
    %20 = comb.extract %19 from 0 : (i2) -> i1
    llhd.drv %halted_d, %20 after %2 : i1
    %21 = llhd.prb %resuming_q : i1
    %22 = comb.concat %false, %21 : i1, i1
    llhd.drv %resuming_q_aligned, %22 after %2 : i2
    %23 = llhd.prb %resuming_d_aligned : i2
    %24 = comb.extract %23 from 0 : (i2) -> i1
    llhd.drv %resuming_d, %24 after %2 : i1
    %25 = llhd.prb %cmd_i_6 : !hw.struct<cmdtype: i8, control: i24>
    %control = hw.struct_extract %25["control"] : !hw.struct<cmdtype: i8, control: i24>
    %26 = hw.bitcast %control : (i24) -> !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
    llhd.drv %ac_ar, %26 after %2 : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
    %27 = hw.bitcast %progbuf_i : (!hw.array<8xi32>) -> !hw.array<4xi64>
    llhd.drv %progbuf, %27 after %2 : !hw.array<4xi64>
    %28 = llhd.prb %cmderror_valid_o : i1
    %29 = llhd.prb %cmderror_o : i3
    %30 = llhd.prb %state_q : i2
    %31 = llhd.prb %state_d : i2
    %32 = llhd.prb %go : i1
    %33 = llhd.prb %resume : i1
    %34 = llhd.prb %cmdbusy_o : i1
    %35 = llhd.prb %cmd_valid_i_5 : i1
    %36 = llhd.prb %halted_q_aligned : i2
    %37 = llhd.prb %hartsel : i1
    %38 = llhd.prb %unsupported_command : i1
    %39 = llhd.prb %resumereq_aligned : i2
    %40 = llhd.prb %resuming_q_aligned : i2
    %41 = llhd.prb %haltreq_aligned : i2
    %42 = llhd.prb %exception : i1
    %43 = llhd.prb %ndmreset_i_2 : i1
    %44 = llhd.prb %going : i1
    %45 = llhd.prb %halted_aligned : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb22
      llhd.drv %cmderror_valid_o, %false after %2 : i1
      llhd.drv %cmderror_o, %c0_i3 after %2 : i3
      %74 = llhd.prb %state_q : i2
      llhd.drv %state_d, %74 after %2 : i2
      llhd.drv %go, %false after %2 : i1
      llhd.drv %resume, %false after %2 : i1
      llhd.drv %cmdbusy_o, %true after %2 : i1
      %75 = llhd.prb %state_q : i2
      %76 = comb.icmp ceq %75, %c0_i2 : i2
      cf.cond_br %76, ^bb2, ^bb8
    ^bb2:  // pred: ^bb1
      llhd.drv %cmdbusy_o, %false after %2 : i1
      %77 = llhd.prb %cmd_valid_i_5 : i1
      %78 = llhd.prb %halted_q_aligned : i2
      %79 = llhd.prb %hartsel : i1
      %80 = comb.concat %false, %79 : i1, i1
      %81 = comb.shru %78, %80 : i2
      %82 = comb.extract %81 from 0 : (i2) -> i1
      %83 = llhd.prb %unsupported_command : i1
      %84 = comb.xor %83, %true : i1
      %85 = comb.and %77, %82, %84 : i1
      cf.cond_br %85, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %state_d, %c1_i2 after %2 : i2
      cf.br ^bb6
    ^bb4:  // pred: ^bb2
      %86 = llhd.prb %cmd_valid_i_5 : i1
      cf.cond_br %86, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      llhd.drv %cmderror_valid_o, %true after %2 : i1
      llhd.drv %cmderror_o, %c-4_i3 after %2 : i3
      cf.br ^bb6
    ^bb6:  // 3 preds: ^bb3, ^bb4, ^bb5
      %87 = llhd.prb %resumereq_aligned : i2
      %88 = llhd.prb %hartsel : i1
      %89 = comb.concat %false, %88 : i1, i1
      %90 = comb.shru %87, %89 : i2
      %91 = comb.extract %90 from 0 : (i2) -> i1
      %92 = llhd.prb %resuming_q_aligned : i2
      %93 = comb.shru %92, %89 : i2
      %94 = comb.extract %93 from 0 : (i2) -> i1
      %95 = comb.xor %94, %true : i1
      %96 = llhd.prb %haltreq_aligned : i2
      %97 = comb.shru %96, %89 : i2
      %98 = comb.extract %97 from 0 : (i2) -> i1
      %99 = comb.xor %98, %true : i1
      %100 = llhd.prb %halted_q_aligned : i2
      %101 = comb.shru %100, %89 : i2
      %102 = comb.extract %101 from 0 : (i2) -> i1
      %103 = comb.and %91, %95, %99, %102 : i1
      cf.cond_br %103, ^bb7, ^bb16
    ^bb7:  // pred: ^bb6
      llhd.drv %state_d, %c-2_i2 after %2 : i2
      cf.br ^bb16
    ^bb8:  // pred: ^bb1
      %104 = comb.icmp ceq %75, %c1_i2 : i2
      cf.cond_br %104, ^bb9, ^bb11
    ^bb9:  // pred: ^bb8
      llhd.drv %cmdbusy_o, %true after %2 : i1
      llhd.drv %go, %true after %2 : i1
      %105 = llhd.prb %going : i1
      cf.cond_br %105, ^bb10, ^bb16
    ^bb10:  // pred: ^bb9
      llhd.drv %state_d, %c-1_i2 after %2 : i2
      cf.br ^bb16
    ^bb11:  // pred: ^bb8
      %106 = comb.icmp ceq %75, %c-2_i2 : i2
      cf.cond_br %106, ^bb12, ^bb14
    ^bb12:  // pred: ^bb11
      llhd.drv %cmdbusy_o, %true after %2 : i1
      llhd.drv %resume, %true after %2 : i1
      %107 = llhd.prb %resuming_q_aligned : i2
      %108 = llhd.prb %hartsel : i1
      %109 = comb.concat %false, %108 : i1, i1
      %110 = comb.shru %107, %109 : i2
      %111 = comb.extract %110 from 0 : (i2) -> i1
      cf.cond_br %111, ^bb13, ^bb16
    ^bb13:  // pred: ^bb12
      llhd.drv %state_d, %c0_i2 after %2 : i2
      cf.br ^bb16
    ^bb14:  // pred: ^bb11
      llhd.drv %cmdbusy_o, %true after %2 : i1
      llhd.drv %go, %false after %2 : i1
      %112 = llhd.prb %halted_aligned : i2
      %113 = llhd.prb %hartsel : i1
      %114 = comb.concat %false, %113 : i1, i1
      %115 = comb.shru %112, %114 : i2
      %116 = comb.extract %115 from 0 : (i2) -> i1
      cf.cond_br %116, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      llhd.drv %state_d, %c0_i2 after %2 : i2
      cf.br ^bb16
    ^bb16:  // 8 preds: ^bb6, ^bb7, ^bb9, ^bb10, ^bb12, ^bb13, ^bb14, ^bb15
      %117 = llhd.prb %unsupported_command : i1
      %118 = llhd.prb %cmd_valid_i_5 : i1
      %119 = comb.and %117, %118 : i1
      cf.cond_br %119, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      llhd.drv %cmderror_valid_o, %true after %2 : i1
      llhd.drv %cmderror_o, %c2_i3 after %2 : i3
      cf.br ^bb18
    ^bb18:  // 2 preds: ^bb16, ^bb17
      %120 = llhd.prb %exception : i1
      cf.cond_br %120, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      llhd.drv %cmderror_valid_o, %true after %2 : i1
      llhd.drv %cmderror_o, %c3_i3 after %2 : i3
      cf.br ^bb20
    ^bb20:  // 2 preds: ^bb18, ^bb19
      %121 = llhd.prb %ndmreset_i_2 : i1
      cf.cond_br %121, ^bb21, ^bb22
    ^bb21:  // pred: ^bb20
      llhd.drv %state_d, %c0_i2 after %2 : i2
      llhd.drv %go, %false after %2 : i1
      llhd.drv %resume, %false after %2 : i1
      cf.br ^bb22
    ^bb22:  // 2 preds: ^bb20, ^bb21
      llhd.wait (%28, %29, %30, %31, %32, %33, %34, %35, %36, %37, %38, %39, %40, %41, %42, %43, %44, %45 : i1, i3, i2, i2, i1, i1, i1, i1, i2, i1, i1, i2, i2, i2, i1, i1, i1, i2), ^bb1
    }
    %46 = llhd.prb %fwd_rom_q : i1
    %47 = llhd.prb %rom_rdata : i64
    %48 = llhd.prb %rdata_q : i64
    %49 = comb.mux %46, %47, %48 : i64
    llhd.drv %word_mux, %49 after %2 : i64
    %50 = llhd.prb %word_enable32_q : i1
    %51 = llhd.prb %word_mux : i64
    %52 = comb.extract %51 from 32 : (i64) -> i32
    %53 = comb.extract %51 from 0 : (i64) -> i32
    %54 = comb.mux %50, %52, %53 : i32
    %55 = llhd.prb %rdata_d : i64
    %56 = llhd.prb %data_i_4 : !hw.array<2xi32>
    %57 = llhd.prb %data_bits : !hw.array<2xi32>
    %58 = llhd.prb %rdata : !hw.array<8xi8>
    %59 = llhd.prb %fwd_rom_d : i1
    %60 = llhd.prb %data_valid_o : i1
    %61 = llhd.prb %clear_resumeack_i_3 : i1
    %62 = llhd.prb %we_i_8 : i1
    %63 = llhd.prb %addr_i_9 : i32
    %64 = llhd.prb %wdata_hartsel : i1
    %65 = llhd.prb %data_o : !hw.array<2xi32>
    %66 = llhd.prb %be_i_11 : i4
    %67 = llhd.prb %resumereq_wdata_aligned : i2
    %68 = llhd.prb %ac_ar : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
    %69 = llhd.prb %progbuf : !hw.array<4xi64>
    %70 = llhd.prb %abstract_cmd : !hw.array<8xi64>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb46
      %74 = llhd.prb %halted_q : i1
      %75 = comb.concat %false, %74 : i1, i1
      llhd.drv %halted_d_aligned, %75 after %2 : i2
      %76 = llhd.prb %resuming_q : i1
      %77 = comb.concat %false, %76 : i1, i1
      llhd.drv %resuming_d_aligned, %77 after %2 : i2
      %78 = llhd.prb %rdata_q : i64
      llhd.drv %rdata_d, %78 after %2 : i64
      %79 = llhd.prb %data_i_4 : !hw.array<2xi32>
      llhd.drv %data_bits, %79 after %2 : !hw.array<2xi32>
      llhd.drv %rdata, %3 after %2 : !hw.array<8xi8>
      llhd.drv %fwd_rom_d, %false after %2 : i1
      llhd.drv %data_valid_o, %false after %2 : i1
      llhd.drv %exception, %false after %2 : i1
      llhd.drv %halted_aligned, %c0_i2 after %2 : i2
      llhd.drv %going, %false after %2 : i1
      %80 = llhd.prb %clear_resumeack_i_3 : i1
      cf.cond_br %80, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %81 = llhd.prb %hartsel : i1
      %82 = llhd.sig.extract %resuming_d_aligned from %81 : <i2> -> <i1>
      llhd.drv %82, %false after %2 : i1
      cf.br ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      %83 = llhd.prb %req_i_7 : i1
      cf.cond_br %83, ^bb4, ^bb44
    ^bb4:  // pred: ^bb3
      %84 = llhd.prb %we_i_8 : i1
      cf.cond_br %84, ^bb5, ^bb25
    ^bb5:  // pred: ^bb4
      %85 = llhd.prb %addr_i_9 : i32
      %86 = comb.extract %85 from 0 : (i32) -> i12
      %87 = comb.icmp weq %86, %c256_i12 : i12
      cf.cond_br %87, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %88 = llhd.prb %wdata_hartsel : i1
      %89 = llhd.sig.extract %halted_aligned from %88 : <i2> -> <i1>
      llhd.drv %89, %true after %2 : i1
      %90 = llhd.prb %wdata_hartsel : i1
      %91 = llhd.sig.extract %halted_d_aligned from %90 : <i2> -> <i1>
      llhd.drv %91, %true after %2 : i1
      cf.br ^bb44
    ^bb7:  // pred: ^bb5
      %92 = comb.icmp weq %86, %c264_i12 : i12
      cf.cond_br %92, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %going, %true after %2 : i1
      cf.br ^bb44
    ^bb9:  // pred: ^bb7
      %93 = comb.icmp weq %86, %c272_i12 : i12
      cf.cond_br %93, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %94 = llhd.prb %wdata_hartsel : i1
      %95 = llhd.sig.extract %halted_d_aligned from %94 : <i2> -> <i1>
      llhd.drv %95, %false after %2 : i1
      %96 = llhd.prb %wdata_hartsel : i1
      %97 = llhd.sig.extract %resuming_d_aligned from %96 : <i2> -> <i1>
      llhd.drv %97, %true after %2 : i1
      cf.br ^bb44
    ^bb11:  // pred: ^bb9
      %98 = comb.icmp weq %86, %c280_i12 : i12
      cf.cond_br %98, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      llhd.drv %exception, %true after %2 : i1
      cf.br ^bb44
    ^bb13:  // pred: ^bb11
      %99 = comb.icmp ugt %86, %c895_i12 : i12
      %100 = comb.icmp ult %86, %c904_i12 : i12
      %101 = comb.and %99, %100 : i1
      cf.cond_br %101, ^bb14, ^bb44
    ^bb14:  // pred: ^bb13
      llhd.drv %data_valid_o, %true after %2 : i1
      cf.br ^bb15(%c0_i32 : i32)
    ^bb15(%102: i32):  // 2 preds: ^bb14, ^bb24
      %103 = comb.icmp ult %102, %c2_i32 : i32
      cf.cond_br %103, ^bb16, ^bb44
    ^bb16:  // pred: ^bb15
      %104 = llhd.prb %addr_i_9 : i32
      %105 = comb.extract %104 from 2 : (i32) -> i10
      %106 = comb.concat %c0_i22, %105 : i22, i10
      %107 = comb.add %106, %c-224_i32 : i32
      %108 = comb.icmp eq %107, %102 : i32
      cf.cond_br %108, ^bb17(%c0_i32 : i32), ^bb24
    ^bb17(%109: i32):  // 2 preds: ^bb16, ^bb23
      %110 = comb.icmp ult %109, %c4_i32 : i32
      cf.cond_br %110, ^bb18, ^bb24
    ^bb18:  // pred: ^bb17
      %111 = llhd.prb %be_i_11 : i4
      %112 = comb.extract %109 from 4 : (i32) -> i28
      %113 = comb.icmp eq %112, %c0_i28 : i28
      %114 = comb.extract %109 from 0 : (i32) -> i4
      %115 = comb.mux %113, %114, %c-1_i4 : i4
      %116 = comb.shru %111, %115 : i4
      %117 = comb.extract %116 from 0 : (i4) -> i1
      cf.cond_br %117, ^bb19, ^bb23
    ^bb19:  // pred: ^bb18
      %118 = comb.extract %109 from 2 : (i32) -> i30
      %119 = comb.icmp ne %118, %c0_i30 : i30
      cf.cond_br %119, ^bb20, ^bb22
    ^bb20:  // pred: ^bb19
      %120 = comb.icmp eq %102, %c0_i32 : i32
      cf.cond_br %120, ^bb21, ^bb23
    ^bb21:  // pred: ^bb20
      %121 = comb.add %102, %c1_i32 : i32
      %122 = comb.extract %121 from 1 : (i32) -> i31
      %123 = comb.extract %121 from 0 : (i32) -> i1
      %124 = comb.icmp ne %122, %c0_i31 : i31
      %125 = comb.or %124, %123 : i1
      %126 = llhd.sig.array_get %data_bits[%125] : <!hw.array<2xi32>>
      %127 = comb.extract %109 from 0 : (i32) -> i29
      %128 = comb.add %127, %c-4_i29 : i29
      %129 = comb.extract %128 from 2 : (i29) -> i27
      %130 = comb.icmp eq %129, %c0_i27 : i27
      %131 = comb.extract %128 from 0 : (i29) -> i2
      %132 = comb.concat %131, %c0_i3 : i2, i3
      %133 = comb.mux %130, %132, %c-1_i5 : i5
      %134 = llhd.sig.extract %126 from %133 : <i32> -> <i8>
      %135 = llhd.prb %wdata_i_10 : i32
      %136 = comb.extract %109 from 0 : (i32) -> i29
      %137 = comb.concat %136, %c0_i3 : i29, i3
      %138 = comb.shru %135, %137 : i32
      %139 = comb.extract %138 from 0 : (i32) -> i8
      llhd.drv %134, %139 after %2 : i8
      cf.br ^bb23
    ^bb22:  // pred: ^bb19
      %140 = comb.extract %102 from 1 : (i32) -> i31
      %141 = comb.extract %102 from 0 : (i32) -> i1
      %142 = comb.icmp ne %140, %c0_i31 : i31
      %143 = comb.or %142, %141 : i1
      %144 = llhd.sig.array_get %data_bits[%143] : <!hw.array<2xi32>>
      %145 = comb.extract %109 from 0 : (i32) -> i29
      %146 = comb.concat %145, %c0_i3 : i29, i3
      %147 = comb.extract %109 from 2 : (i32) -> i27
      %148 = comb.icmp eq %147, %c0_i27 : i27
      %149 = comb.extract %109 from 0 : (i32) -> i2
      %150 = comb.concat %149, %c0_i3 : i2, i3
      %151 = comb.mux %148, %150, %c-1_i5 : i5
      %152 = llhd.sig.extract %144 from %151 : <i32> -> <i8>
      %153 = llhd.prb %wdata_i_10 : i32
      %154 = comb.shru %153, %146 : i32
      %155 = comb.extract %154 from 0 : (i32) -> i8
      llhd.drv %152, %155 after %2 : i8
      cf.br ^bb23
    ^bb23:  // 4 preds: ^bb18, ^bb20, ^bb21, ^bb22
      %156 = comb.add %109, %c1_i32 : i32
      cf.br ^bb17(%156 : i32)
    ^bb24:  // 2 preds: ^bb16, ^bb17
      %157 = comb.add %102, %c1_i32 : i32
      cf.br ^bb15(%157 : i32)
    ^bb25:  // pred: ^bb4
      %158 = llhd.prb %addr_i_9 : i32
      %159 = comb.extract %158 from 0 : (i32) -> i12
      %160 = comb.icmp weq %159, %c768_i12 : i12
      cf.cond_br %160, ^bb26, ^bb32
    ^bb26:  // pred: ^bb25
      %161 = llhd.prb %resumereq_wdata_aligned : i2
      %162 = llhd.prb %wdata_hartsel : i1
      %163 = comb.concat %false, %162 : i1, i1
      %164 = comb.shru %161, %163 : i2
      %165 = comb.extract %164 from 0 : (i2) -> i1
      cf.cond_br %165, ^bb27, ^bb28
    ^bb27:  // pred: ^bb26
      llhd.drv %rdata_d, %c1350565999_i64 after %2 : i64
      cf.br ^bb28
    ^bb28:  // 2 preds: ^bb26, ^bb27
      %166 = llhd.prb %cmdbusy_o : i1
      cf.cond_br %166, ^bb29, ^bb44
    ^bb29:  // pred: ^bb28
      %167 = llhd.prb %cmd_i_6 : !hw.struct<cmdtype: i8, control: i24>
      %cmdtype = hw.struct_extract %167["cmdtype"] : !hw.struct<cmdtype: i8, control: i24>
      %168 = comb.icmp eq %cmdtype, %c0_i8 : i8
      %169 = llhd.prb %ac_ar : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %transfer = hw.struct_extract %169["transfer"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %170 = comb.xor %transfer, %true : i1
      %postexec = hw.struct_extract %169["postexec"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %171 = comb.and %168, %170, %postexec : i1
      cf.cond_br %171, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      llhd.drv %rdata_d, %c100663407_i64 after %2 : i64
      cf.br ^bb44
    ^bb31:  // pred: ^bb29
      llhd.drv %rdata_d, %c58720367_i64 after %2 : i64
      cf.br ^bb44
    ^bb32:  // pred: ^bb25
      %172 = comb.icmp ugt %159, %c895_i12 : i12
      %173 = comb.icmp ult %159, %c904_i12 : i12
      %174 = comb.and %172, %173 : i1
      cf.cond_br %174, ^bb33, ^bb34
    ^bb33:  // pred: ^bb32
      %175 = llhd.prb %data_i_4 : !hw.array<2xi32>
      %176 = hw.bitcast %175 : (!hw.array<2xi32>) -> i64
      llhd.drv %rdata_d, %176 after %2 : i64
      cf.br ^bb44
    ^bb34:  // pred: ^bb32
      %177 = comb.icmp ugt %159, %c863_i12 : i12
      %178 = comb.icmp ult %159, %c896_i12 : i12
      %179 = comb.and %177, %178 : i1
      cf.cond_br %179, ^bb35, ^bb36
    ^bb35:  // pred: ^bb34
      %180 = llhd.prb %progbuf : !hw.array<4xi64>
      %181 = llhd.prb %addr_i_9 : i32
      %182 = comb.extract %181 from 3 : (i32) -> i2
      %183 = hw.array_get %180[%182] : !hw.array<4xi64>, i2
      llhd.drv %rdata_d, %183 after %2 : i64
      cf.br ^bb44
    ^bb36:  // pred: ^bb34
      %184 = comb.icmp ugt %159, %c823_i12 : i12
      %185 = comb.icmp ult %159, %c864_i12 : i12
      %186 = comb.and %184, %185 : i1
      cf.cond_br %186, ^bb37, ^bb38
    ^bb37:  // pred: ^bb36
      %187 = llhd.prb %abstract_cmd : !hw.array<8xi64>
      %188 = llhd.prb %addr_i_9 : i32
      %189 = comb.extract %188 from 3 : (i32) -> i3
      %190 = comb.add %189, %c1_i3 : i3
      %191 = hw.array_get %187[%190] : !hw.array<8xi64>, i3
      llhd.drv %rdata_d, %191 after %2 : i64
      cf.br ^bb44
    ^bb38:  // pred: ^bb36
      %192 = comb.extract %158 from 10 : (i32) -> i2
      %193 = comb.icmp ne %192, %c0_i2 : i2
      %194 = comb.extract %158 from 11 : (i32) -> i1
      %195 = comb.xor %194, %true : i1
      %196 = comb.and %193, %195 : i1
      cf.cond_br %196, ^bb39, ^bb42
    ^bb39:  // pred: ^bb38
      %197 = llhd.prb %addr_i_9 : i32
      %198 = comb.extract %197 from 3 : (i32) -> i9
      %199 = comb.concat %198, %c0_i3 : i9, i3
      %200 = comb.add %199, %c-1024_i12 : i12
      %201 = comb.icmp eq %200, %c0_i12 : i12
      cf.cond_br %201, ^bb40, ^bb41
    ^bb40:  // pred: ^bb39
      %202 = llhd.prb %hartsel : i1
      %203 = comb.concat %c0_i2, %202 : i2, i1
      %204 = llhd.sig.array_get %rdata[%203] : <!hw.array<8xi8>>
      %205 = llhd.prb %resume : i1
      %206 = llhd.prb %go : i1
      %207 = comb.concat %c0_i6, %205, %206 : i6, i1, i1
      llhd.drv %204, %207 after %2 : i8
      cf.br ^bb41
    ^bb41:  // 2 preds: ^bb39, ^bb40
      %208 = llhd.prb %rdata : !hw.array<8xi8>
      %209 = hw.bitcast %208 : (!hw.array<8xi8>) -> i64
      llhd.drv %rdata_d, %209 after %2 : i64
      cf.br ^bb44
    ^bb42:  // pred: ^bb38
      %210 = comb.extract %158 from 11 : (i32) -> i1
      cf.cond_br %210, ^bb43, ^bb44
    ^bb43:  // pred: ^bb42
      llhd.drv %fwd_rom_d, %true after %2 : i1
      cf.br ^bb44
    ^bb44:  // 16 preds: ^bb3, ^bb6, ^bb8, ^bb10, ^bb12, ^bb13, ^bb15, ^bb28, ^bb30, ^bb31, ^bb33, ^bb35, ^bb37, ^bb41, ^bb42, ^bb43
      %211 = llhd.prb %ndmreset_i_2 : i1
      cf.cond_br %211, ^bb45, ^bb46
    ^bb45:  // pred: ^bb44
      llhd.drv %halted_d_aligned, %c0_i2 after %2 : i2
      llhd.drv %resuming_d_aligned, %c0_i2 after %2 : i2
      cf.br ^bb46
    ^bb46:  // 2 preds: ^bb44, ^bb45
      %212 = llhd.prb %data_bits : !hw.array<2xi32>
      llhd.drv %data_o, %212 after %2 : !hw.array<2xi32>
      llhd.wait (%17, %19, %21, %23, %48, %55, %56, %57, %58, %59, %60, %42, %45, %44, %61, %37, %11, %62, %63, %64, %43, %65, %66, %13, %67, %34, %25, %68, %69, %70, %33, %32 : i1, i2, i1, i2, i64, i64, !hw.array<2xi32>, !hw.array<2xi32>, !hw.array<8xi8>, i1, i1, i1, i2, i1, i1, i1, i1, i1, i32, i1, i1, !hw.array<2xi32>, i4, i32, i2, i1, !hw.struct<cmdtype: i8, control: i24>, !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>, !hw.array<4xi64>, !hw.array<8xi64>, i1, i1), ^bb1
    }
    %71 = llhd.prb %err_d : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb25
      llhd.drv %err_d, %false after %2 : i1
      %74 = llhd.prb %req_i_7 : i1
      cf.cond_br %74, ^bb2, ^bb25
    ^bb2:  // pred: ^bb1
      %75 = llhd.prb %addr_i_9 : i32
      %76 = comb.extract %75 from 0 : (i32) -> i12
      %77 = comb.icmp weq %76, %c768_i12 : i12
      cf.cond_br %77, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %78 = llhd.prb %we_i_8 : i1
      %79 = llhd.prb %be_i_11 : i4
      %80 = func.call @gen_wr_err(%78, %79, %c-1_i4) : (i1, i4, i4) -> i1
      llhd.drv %err_d, %80 after %2 : i1
      cf.br ^bb23
    ^bb4:  // pred: ^bb2
      %81 = comb.icmp weq %76, %c256_i12 : i12
      cf.cond_br %81, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      %82 = llhd.prb %we_i_8 : i1
      %83 = llhd.prb %be_i_11 : i4
      %84 = func.call @gen_wr_err(%82, %83, %c1_i4) : (i1, i4, i4) -> i1
      llhd.drv %err_d, %84 after %2 : i1
      cf.br ^bb23
    ^bb6:  // pred: ^bb4
      %85 = comb.icmp weq %76, %c264_i12 : i12
      cf.cond_br %85, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %86 = llhd.prb %we_i_8 : i1
      %87 = llhd.prb %be_i_11 : i4
      %88 = func.call @gen_wr_err(%86, %87, %c1_i4) : (i1, i4, i4) -> i1
      llhd.drv %err_d, %88 after %2 : i1
      cf.br ^bb23
    ^bb8:  // pred: ^bb6
      %89 = comb.icmp weq %76, %c272_i12 : i12
      cf.cond_br %89, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      %90 = llhd.prb %we_i_8 : i1
      %91 = llhd.prb %be_i_11 : i4
      %92 = func.call @gen_wr_err(%90, %91, %c1_i4) : (i1, i4, i4) -> i1
      llhd.drv %err_d, %92 after %2 : i1
      cf.br ^bb23
    ^bb10:  // pred: ^bb8
      %93 = comb.icmp weq %76, %c280_i12 : i12
      cf.cond_br %93, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      %94 = llhd.prb %we_i_8 : i1
      %95 = llhd.prb %be_i_11 : i4
      %96 = func.call @gen_wr_err(%94, %95, %c1_i4) : (i1, i4, i4) -> i1
      llhd.drv %err_d, %96 after %2 : i1
      cf.br ^bb23
    ^bb12:  // pred: ^bb10
      %97 = comb.icmp ugt %76, %c895_i12 : i12
      %98 = comb.icmp ult %76, %c904_i12 : i12
      %99 = comb.and %97, %98 : i1
      cf.cond_br %99, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      %100 = llhd.prb %we_i_8 : i1
      %101 = llhd.prb %be_i_11 : i4
      %102 = func.call @gen_wr_err(%100, %101, %c-1_i4) : (i1, i4, i4) -> i1
      llhd.drv %err_d, %102 after %2 : i1
      cf.br ^bb23
    ^bb14:  // pred: ^bb12
      %103 = comb.icmp ugt %76, %c863_i12 : i12
      %104 = comb.icmp ult %76, %c896_i12 : i12
      %105 = comb.and %103, %104 : i1
      cf.cond_br %105, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      %106 = llhd.prb %we_i_8 : i1
      %107 = llhd.prb %be_i_11 : i4
      %108 = func.call @gen_wr_err(%106, %107, %c-1_i4) : (i1, i4, i4) -> i1
      llhd.drv %err_d, %108 after %2 : i1
      cf.br ^bb23
    ^bb16:  // pred: ^bb14
      %109 = comb.icmp ugt %76, %c823_i12 : i12
      %110 = comb.icmp ult %76, %c864_i12 : i12
      %111 = comb.and %109, %110 : i1
      cf.cond_br %111, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      %112 = llhd.prb %we_i_8 : i1
      %113 = llhd.prb %be_i_11 : i4
      %114 = func.call @gen_wr_err(%112, %113, %c-1_i4) : (i1, i4, i4) -> i1
      llhd.drv %err_d, %114 after %2 : i1
      cf.br ^bb23
    ^bb18:  // pred: ^bb16
      %115 = comb.extract %75 from 10 : (i32) -> i2
      %116 = comb.icmp ne %115, %c0_i2 : i2
      %117 = comb.extract %75 from 11 : (i32) -> i1
      %118 = comb.xor %117, %true : i1
      %119 = comb.and %116, %118 : i1
      cf.cond_br %119, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      %120 = llhd.prb %we_i_8 : i1
      %121 = llhd.prb %be_i_11 : i4
      %122 = func.call @gen_wr_err(%120, %121, %c-1_i4) : (i1, i4, i4) -> i1
      llhd.drv %err_d, %122 after %2 : i1
      cf.br ^bb23
    ^bb20:  // pred: ^bb18
      %123 = comb.extract %75 from 11 : (i32) -> i1
      cf.cond_br %123, ^bb21, ^bb22
    ^bb21:  // pred: ^bb20
      %124 = llhd.prb %we_i_8 : i1
      llhd.drv %err_d, %124 after %2 : i1
      cf.br ^bb23
    ^bb22:  // pred: ^bb20
      llhd.drv %err_d, %true after %2 : i1
      cf.br ^bb23
    ^bb23:  // 11 preds: ^bb3, ^bb5, ^bb7, ^bb9, ^bb11, ^bb13, ^bb15, ^bb17, ^bb19, ^bb21, ^bb22
      %125 = llhd.prb %addr_i_9 : i32
      %126 = comb.extract %125 from 0 : (i32) -> i2
      %127 = comb.icmp ne %126, %c0_i2 : i2
      cf.cond_br %127, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      llhd.drv %err_d, %true after %2 : i1
      cf.br ^bb25
    ^bb25:  // 3 preds: ^bb1, ^bb23, ^bb24
      llhd.wait (%71, %11, %63, %62, %66 : i1, i1, i32, i1, i4), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %74 = llhd.prb %clk_i_0 : i1
      %75 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%9, %10 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %76 = llhd.prb %clk_i_0 : i1
      %77 = comb.xor bin %74, %true : i1
      %78 = comb.and bin %77, %76 : i1
      %79 = llhd.prb %rst_ni_1 : i1
      %80 = comb.xor bin %79, %true : i1
      %81 = comb.and bin %75, %80 : i1
      %82 = comb.or bin %78, %81 : i1
      cf.cond_br %82, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %83 = llhd.prb %rst_ni_1 : i1
      %84 = comb.xor %83, %true : i1
      cf.cond_br %84, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %err_q, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %85 = llhd.prb %err_d : i1
      llhd.drv %err_q, %85 after %1 : i1
      cf.br ^bb1
    }
    %72 = llhd.prb %err_q : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb27
      llhd.drv %unsupported_command, %false after %2 : i1
      %74 = llhd.sig.array_get %abstract_cmd[%c0_i3] : <!hw.array<8xi64>>
      %75 = llhd.sig.extract %74 from %c0_i6 : <i64> -> <i32>
      llhd.drv %75, %c0_i32 after %2 : i32
      %76 = llhd.sig.extract %74 from %c-32_i6 : <i64> -> <i32>
      llhd.drv %76, %c1303_i32 after %2 : i32
      %77 = llhd.sig.array_get %abstract_cmd[%c1_i3] : <!hw.array<8xi64>>
      %78 = llhd.sig.extract %77 from %c0_i6 : <i64> -> <i32>
      llhd.drv %78, %c12932371_i32 after %2 : i32
      %79 = llhd.sig.extract %77 from %c-32_i6 : <i64> -> <i32>
      llhd.drv %79, %c12915987_i32 after %2 : i32
      %80 = llhd.sig.array_get %abstract_cmd[%c2_i3] : <!hw.array<8xi64>>
      %81 = llhd.sig.extract %80 from %c0_i6 : <i64> -> <i32>
      llhd.drv %81, %c19_i32 after %2 : i32
      %82 = llhd.sig.extract %80 from %c-32_i6 : <i64> -> <i32>
      llhd.drv %82, %c19_i32 after %2 : i32
      %83 = llhd.sig.array_get %abstract_cmd[%c3_i3] : <!hw.array<8xi64>>
      %84 = llhd.sig.extract %83 from %c0_i6 : <i64> -> <i32>
      llhd.drv %84, %c19_i32 after %2 : i32
      %85 = llhd.sig.extract %83 from %c-32_i6 : <i64> -> <i32>
      llhd.drv %85, %c19_i32 after %2 : i32
      %86 = llhd.sig.array_get %abstract_cmd[%c-4_i3] : <!hw.array<8xi64>>
      %87 = llhd.sig.extract %86 from %c0_i6 : <i64> -> <i32>
      llhd.drv %87, %c2066752883_i32 after %2 : i32
      %88 = llhd.sig.extract %86 from %c-32_i6 : <i64> -> <i32>
      llhd.drv %88, %c1048691_i32 after %2 : i32
      %89 = llhd.sig.array_slice %abstract_cmd at %c-3_i3 : <!hw.array<8xi64>> -> <!hw.array<3xi64>>
      llhd.drv %89, %0 after %2 : !hw.array<3xi64>
      %90 = llhd.prb %cmd_i_6 : !hw.struct<cmdtype: i8, control: i24>
      %cmdtype = hw.struct_extract %90["cmdtype"] : !hw.struct<cmdtype: i8, control: i24>
      %91 = comb.icmp ceq %cmdtype, %c0_i8 : i8
      cf.cond_br %91, ^bb2, ^bb26
    ^bb2:  // pred: ^bb1
      %92 = llhd.prb %ac_ar : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %aarsize = hw.struct_extract %92["aarsize"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %93 = comb.concat %c0_i29, %aarsize : i29, i3
      %94 = comb.icmp ult %93, %c3_i32 : i32
      %transfer = hw.struct_extract %92["transfer"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %write = hw.struct_extract %92["write"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %95 = comb.and %94, %transfer, %write : i1
      cf.cond_br %95, ^bb3, ^bb12
    ^bb3:  // pred: ^bb2
      llhd.drv %75, %c2067075187_i32 after %2 : i32
      %96 = llhd.prb %ac_ar : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %regno = hw.struct_extract %96["regno"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %97 = comb.extract %regno from 14 : (i16) -> i2
      %98 = comb.icmp ne %97, %c0_i2 : i2
      cf.cond_br %98, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %75, %c1048691_i32 after %2 : i32
      llhd.drv %unsupported_command, %true after %2 : i1
      cf.br ^bb24
    ^bb5:  // pred: ^bb3
      %99 = llhd.prb %ac_ar : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %regno_12 = hw.struct_extract %99["regno"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %100 = comb.extract %regno_12 from 12 : (i16) -> i1
      %101 = comb.extract %regno_12 from 5 : (i16) -> i1
      %102 = comb.xor %101, %true : i1
      %103 = comb.extract %regno_12 from 0 : (i16) -> i5
      %104 = comb.icmp eq %103, %c10_i5 : i5
      %105 = comb.and %100, %102, %104 : i1
      cf.cond_br %105, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %81, %c2065961075_i32 after %2 : i32
      %106 = llhd.prb %ac_ar : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %aarsize_13 = hw.struct_extract %106["aarsize"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %107 = func.call @"dm::load"(%aarsize_13, %c8_i5, %c10_i5, %c896_i12) : (i3, i5, i5, i12) -> i32
      llhd.drv %82, %107 after %2 : i32
      llhd.drv %84, %c2067009651_i32 after %2 : i32
      llhd.drv %85, %c2065704051_i32 after %2 : i32
      cf.br ^bb24
    ^bb7:  // pred: ^bb5
      %108 = llhd.prb %ac_ar : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %regno_14 = hw.struct_extract %108["regno"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %109 = comb.extract %regno_14 from 12 : (i16) -> i1
      cf.cond_br %109, ^bb8, ^bb11
    ^bb8:  // pred: ^bb7
      %110 = llhd.prb %ac_ar : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %regno_15 = hw.struct_extract %110["regno"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %111 = comb.extract %regno_15 from 5 : (i16) -> i1
      cf.cond_br %111, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      %112 = llhd.prb %ac_ar : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %aarsize_16 = hw.struct_extract %112["aarsize"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %regno_17 = hw.struct_extract %112["regno"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %113 = comb.extract %regno_17 from 0 : (i16) -> i5
      %114 = func.call @"dm::float_load"(%aarsize_16, %113, %c10_i5, %c896_i12) : (i3, i5, i5, i12) -> i32
      llhd.drv %81, %114 after %2 : i32
      cf.br ^bb24
    ^bb10:  // pred: ^bb8
      %115 = llhd.prb %ac_ar : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %aarsize_18 = hw.struct_extract %115["aarsize"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %regno_19 = hw.struct_extract %115["regno"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %116 = comb.extract %regno_19 from 0 : (i16) -> i5
      %117 = func.call @"dm::load"(%aarsize_18, %116, %c10_i5, %c896_i12) : (i3, i5, i5, i12) -> i32
      llhd.drv %81, %117 after %2 : i32
      cf.br ^bb24
    ^bb11:  // pred: ^bb7
      llhd.drv %81, %c2065961075_i32 after %2 : i32
      %118 = llhd.prb %ac_ar : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %aarsize_20 = hw.struct_extract %118["aarsize"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %119 = func.call @"dm::load"(%aarsize_20, %c8_i5, %c10_i5, %c896_i12) : (i3, i5, i5, i12) -> i32
      llhd.drv %82, %119 after %2 : i32
      %120 = llhd.prb %ac_ar : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %regno_21 = hw.struct_extract %120["regno"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %121 = comb.extract %regno_21 from 0 : (i16) -> i12
      %122 = func.call @"dm::csrw"(%121, %c8_i5) : (i12, i5) -> i32
      llhd.drv %84, %122 after %2 : i32
      llhd.drv %85, %c2065704051_i32 after %2 : i32
      cf.br ^bb24
    ^bb12:  // pred: ^bb2
      %123 = llhd.prb %ac_ar : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %aarsize_22 = hw.struct_extract %123["aarsize"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %124 = comb.concat %c0_i29, %aarsize_22 : i29, i3
      %125 = comb.icmp ult %124, %c3_i32 : i32
      %transfer_23 = hw.struct_extract %123["transfer"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %write_24 = hw.struct_extract %123["write"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %126 = comb.xor %write_24, %true : i1
      %127 = comb.and %125, %transfer_23, %126 : i1
      cf.cond_br %127, ^bb13, ^bb22
    ^bb13:  // pred: ^bb12
      llhd.drv %75, %c2067075187_i32 after %2 : i32
      %128 = llhd.prb %ac_ar : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %regno_25 = hw.struct_extract %128["regno"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %129 = comb.extract %regno_25 from 14 : (i16) -> i2
      %130 = comb.icmp ne %129, %c0_i2 : i2
      cf.cond_br %130, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      llhd.drv %75, %c1048691_i32 after %2 : i32
      llhd.drv %unsupported_command, %true after %2 : i1
      cf.br ^bb24
    ^bb15:  // pred: ^bb13
      %131 = llhd.prb %ac_ar : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %regno_26 = hw.struct_extract %131["regno"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %132 = comb.extract %regno_26 from 12 : (i16) -> i1
      %133 = comb.extract %regno_26 from 5 : (i16) -> i1
      %134 = comb.xor %133, %true : i1
      %135 = comb.extract %regno_26 from 0 : (i16) -> i5
      %136 = comb.icmp eq %135, %c10_i5 : i5
      %137 = comb.and %132, %134, %136 : i1
      cf.cond_br %137, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      llhd.drv %81, %c2065961075_i32 after %2 : i32
      llhd.drv %82, %c2066752627_i32 after %2 : i32
      %138 = llhd.prb %ac_ar : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %aarsize_27 = hw.struct_extract %138["aarsize"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %139 = func.call @"dm::store"(%aarsize_27, %c8_i5, %c10_i5, %c896_i12) : (i3, i5, i5, i12) -> i32
      llhd.drv %84, %139 after %2 : i32
      llhd.drv %85, %c2065704051_i32 after %2 : i32
      cf.br ^bb24
    ^bb17:  // pred: ^bb15
      %140 = llhd.prb %ac_ar : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %regno_28 = hw.struct_extract %140["regno"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %141 = comb.extract %regno_28 from 12 : (i16) -> i1
      cf.cond_br %141, ^bb18, ^bb21
    ^bb18:  // pred: ^bb17
      %142 = llhd.prb %ac_ar : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %regno_29 = hw.struct_extract %142["regno"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %143 = comb.extract %regno_29 from 5 : (i16) -> i1
      cf.cond_br %143, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      %144 = llhd.prb %ac_ar : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %aarsize_30 = hw.struct_extract %144["aarsize"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %regno_31 = hw.struct_extract %144["regno"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %145 = comb.extract %regno_31 from 0 : (i16) -> i5
      %146 = func.call @"dm::float_store"(%aarsize_30, %145, %c10_i5, %c896_i12) : (i3, i5, i5, i12) -> i32
      llhd.drv %81, %146 after %2 : i32
      cf.br ^bb24
    ^bb20:  // pred: ^bb18
      %147 = llhd.prb %ac_ar : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %aarsize_32 = hw.struct_extract %147["aarsize"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %regno_33 = hw.struct_extract %147["regno"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %148 = comb.extract %regno_33 from 0 : (i16) -> i5
      %149 = func.call @"dm::store"(%aarsize_32, %148, %c10_i5, %c896_i12) : (i3, i5, i5, i12) -> i32
      llhd.drv %81, %149 after %2 : i32
      cf.br ^bb24
    ^bb21:  // pred: ^bb17
      llhd.drv %81, %c2065961075_i32 after %2 : i32
      %150 = llhd.prb %ac_ar : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %regno_34 = hw.struct_extract %150["regno"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %151 = comb.extract %regno_34 from 0 : (i16) -> i12
      %152 = func.call @"dm::csrr"(%151, %c8_i5) : (i12, i5) -> i32
      llhd.drv %82, %152 after %2 : i32
      %153 = llhd.prb %ac_ar : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %aarsize_35 = hw.struct_extract %153["aarsize"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %154 = func.call @"dm::store"(%aarsize_35, %c8_i5, %c10_i5, %c896_i12) : (i3, i5, i5, i12) -> i32
      llhd.drv %84, %154 after %2 : i32
      llhd.drv %85, %c2065704051_i32 after %2 : i32
      cf.br ^bb24
    ^bb22:  // pred: ^bb12
      %155 = llhd.prb %ac_ar : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %aarsize_36 = hw.struct_extract %155["aarsize"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %156 = comb.concat %c0_i29, %aarsize_36 : i29, i3
      %157 = comb.icmp ugt %156, %c2_i32 : i32
      %aarpostincrement = hw.struct_extract %155["aarpostincrement"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %158 = comb.or %157, %aarpostincrement : i1
      cf.cond_br %158, ^bb23, ^bb24
    ^bb23:  // pred: ^bb22
      llhd.drv %75, %c1048691_i32 after %2 : i32
      llhd.drv %unsupported_command, %true after %2 : i1
      cf.br ^bb24
    ^bb24:  // 12 preds: ^bb4, ^bb6, ^bb9, ^bb10, ^bb11, ^bb14, ^bb16, ^bb19, ^bb20, ^bb21, ^bb22, ^bb23
      %159 = llhd.prb %ac_ar : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %postexec = hw.struct_extract %159["postexec"] : !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>
      %160 = llhd.prb %unsupported_command : i1
      %161 = comb.xor %160, %true : i1
      %162 = comb.and %postexec, %161 : i1
      cf.cond_br %162, ^bb25, ^bb27
    ^bb25:  // pred: ^bb24
      llhd.drv %88, %c19_i32 after %2 : i32
      cf.br ^bb27
    ^bb26:  // pred: ^bb1
      llhd.drv %75, %c1048691_i32 after %2 : i32
      llhd.drv %unsupported_command, %true after %2 : i1
      cf.br ^bb27
    ^bb27:  // 3 preds: ^bb24, ^bb25, ^bb26
      llhd.wait (%38, %70, %25, %68 : i1, !hw.array<8xi64>, !hw.struct<cmdtype: i8, control: i24>, !hw.struct<zero1: i1, aarsize: i3, aarpostincrement: i1, postexec: i1, transfer: i1, write: i1, regno: i16>), ^bb1
    }
    %73 = comb.concat %c0_i32, %63 {sv.namehint = "rom_addr"} : i32, i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %74 = llhd.prb %clk_i_0 : i1
      %75 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%9, %10 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %76 = llhd.prb %clk_i_0 : i1
      %77 = comb.xor bin %74, %true : i1
      %78 = comb.and bin %77, %76 : i1
      %79 = llhd.prb %rst_ni_1 : i1
      %80 = comb.xor bin %79, %true : i1
      %81 = comb.and bin %75, %80 : i1
      %82 = comb.or bin %78, %81 : i1
      cf.cond_br %82, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %83 = llhd.prb %rst_ni_1 : i1
      %84 = comb.xor %83, %true : i1
      cf.cond_br %84, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %fwd_rom_q, %false after %1 : i1
      llhd.drv %rdata_q, %c0_i64 after %1 : i64
      llhd.drv %state_q, %c0_i2 after %1 : i2
      llhd.drv %word_enable32_q, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %85 = llhd.prb %fwd_rom_d : i1
      llhd.drv %fwd_rom_q, %85 after %1 : i1
      %86 = llhd.prb %rdata_d : i64
      llhd.drv %rdata_q, %86 after %1 : i64
      %87 = llhd.prb %state_d : i2
      llhd.drv %state_q, %87 after %1 : i2
      %88 = llhd.prb %addr_i_9 : i32
      %89 = comb.extract %88 from 2 : (i32) -> i1
      llhd.drv %word_enable32_q, %89 after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %74 = llhd.prb %clk_i_0 : i1
      %75 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%9, %10 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %76 = llhd.prb %clk_i_0 : i1
      %77 = comb.xor bin %74, %true : i1
      %78 = comb.and bin %77, %76 : i1
      %79 = llhd.prb %rst_ni_1 : i1
      %80 = comb.xor bin %79, %true : i1
      %81 = comb.and bin %75, %80 : i1
      %82 = comb.or bin %78, %81 : i1
      cf.cond_br %82, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %83 = llhd.prb %rst_ni_1 : i1
      %84 = comb.xor %83, %true : i1
      cf.cond_br %84, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %halted_q, %false after %1 : i1
      llhd.drv %resuming_q, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %85 = llhd.prb %halted_d : i1
      llhd.drv %halted_q, %85 after %1 : i1
      %86 = llhd.prb %resuming_d : i1
      llhd.drv %resuming_q, %86 after %1 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %2 : i1
    llhd.drv %rst_ni_1, %rst_ni after %2 : i1
    llhd.drv %ndmreset_i_2, %ndmreset_i after %2 : i1
    llhd.drv %clear_resumeack_i_3, %clear_resumeack_i after %2 : i1
    llhd.drv %data_i_4, %data_i after %2 : !hw.array<2xi32>
    llhd.drv %cmd_valid_i_5, %cmd_valid_i after %2 : i1
    llhd.drv %cmd_i_6, %cmd_i after %2 : !hw.struct<cmdtype: i8, control: i24>
    llhd.drv %req_i_7, %req_i after %2 : i1
    llhd.drv %we_i_8, %we_i after %2 : i1
    llhd.drv %addr_i_9, %addr_i after %2 : i32
    llhd.drv %wdata_i_10, %wdata_i after %2 : i32
    llhd.drv %be_i_11, %be_i after %2 : i4
    hw.output %haltreq_i, %17, %21, %65, %60, %28, %29, %34, %54, %72 : i1, i1, i1, !hw.array<2xi32>, i1, i1, i3, i1, i32, i1
  }
  func.func private @gen_wr_err(%arg0: i1, %arg1: i4, %arg2: i4) -> i1 {
    %c0_i4 = hw.constant 0 : i4
    %c-1_i4 = hw.constant -1 : i4
    %0 = comb.xor %arg1, %c-1_i4 : i4
    %1 = comb.and %0, %arg2 : i4
    %2 = comb.icmp ne %1, %c0_i4 : i4
    %3 = comb.and %arg0, %2 : i1
    return %3 : i1
  }
  hw.module private @dm_sba(in %clk_i : i1, in %rst_ni : i1, in %dmactive_i : i1, out master_req_o : i1, out master_add_o : i32, out master_we_o : i1, out master_wdata_o : i32, out master_be_o : i4, in %master_gnt_i : i1, in %master_r_valid_i : i1, in %master_r_err_i : i1, in %master_r_other_err_i : i1, in %master_r_rdata_i : i32, in %sbaddress_i : i32, in %sbaddress_write_valid_i : i1, in %sbreadonaddr_i : i1, out sbaddress_o : i32, in %sbautoincrement_i : i1, in %sbaccess_i : i3, in %sbreadondata_i : i1, in %sbdata_i : i32, in %sbdata_read_valid_i : i1, in %sbdata_write_valid_i : i1, out sbdata_o : i32, out sbdata_valid_o : i1, out sbbusy_o : i1, out sberror_valid_o : i1, out sberror_o : i3) {
    %c0_i27 = hw.constant 0 : i27
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i32 = hw.constant -1 : i32
    %c0_i29 = hw.constant 0 : i29
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c2_i32 = hw.constant 2 : i32
    %c-1_i3 = hw.constant -1 : i3
    %c-4_i3 = hw.constant -4 : i3
    %false = hw.constant false
    %c0_i32 = hw.constant 0 : i32
    %true = hw.constant true
    %c3_i3 = hw.constant 3 : i3
    %c-1_i4 = hw.constant -1 : i4
    %c0_i2 = hw.constant 0 : i2
    %c1_i32 = hw.constant 1 : i32
    %c2_i3 = hw.constant 2 : i3
    %c-1_i2 = hw.constant -1 : i2
    %c1_i3 = hw.constant 1 : i3
    %c0_i4 = hw.constant 0 : i4
    %c0_i3 = hw.constant 0 : i3
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %master_r_err_i_2 = llhd.sig name "master_r_err_i" %false : i1
    %master_r_other_err_i_3 = llhd.sig name "master_r_other_err_i" %false : i1
    %sbaddress_i_4 = llhd.sig name "sbaddress_i" %c0_i32 : i32
    %sbaddress_write_valid_i_5 = llhd.sig name "sbaddress_write_valid_i" %false : i1
    %sbreadonaddr_i_6 = llhd.sig name "sbreadonaddr_i" %false : i1
    %sbautoincrement_i_7 = llhd.sig name "sbautoincrement_i" %false : i1
    %sbaccess_i_8 = llhd.sig name "sbaccess_i" %c0_i3 : i3
    %sbreadondata_i_9 = llhd.sig name "sbreadondata_i" %false : i1
    %sbdata_read_valid_i_10 = llhd.sig name "sbdata_read_valid_i" %false : i1
    %sbdata_write_valid_i_11 = llhd.sig name "sbdata_write_valid_i" %false : i1
    %sbdata_valid_o = llhd.sig %false : i1
    %sberror_valid_o = llhd.sig %false : i1
    %sberror_o = llhd.sig %c0_i3 : i3
    %state_d = llhd.sig %c0_i3 : i3
    %state_q = llhd.sig %c0_i3 : i3
    %address = llhd.sig %c0_i32 : i32
    %req = llhd.sig %false : i1
    %gnt = llhd.sig %false : i1
    %we = llhd.sig %false : i1
    %be = llhd.sig %c0_i4 : i4
    %be_mask = llhd.sig %c0_i4 : i4
    %be_idx = llhd.sig %c0_i2 : i2
    %sbaccess_mask = llhd.sig %c0_i32 : i32
    %addr_incr_en = llhd.sig %false : i1
    %4 = llhd.prb %state_q : i3
    %5 = comb.icmp ne %4, %c0_i3 : i3
    %6 = llhd.prb %be_mask : i4
    %7 = llhd.prb %sbaccess_i_8 : i3
    %8 = llhd.prb %be_idx : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb9
      llhd.drv %be_mask, %c0_i4 after %1 : i4
      %39 = llhd.prb %sbaccess_i_8 : i3
      %40 = comb.icmp ceq %39, %c0_i3 : i3
      cf.cond_br %40, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %41 = llhd.prb %be_idx : i2
      %42 = llhd.sig.extract %be_mask from %41 : <i4> -> <i1>
      llhd.drv %42, %true after %1 : i1
      cf.br ^bb9
    ^bb3:  // pred: ^bb1
      %43 = comb.icmp ceq %39, %c1_i3 : i3
      cf.cond_br %43, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %44 = llhd.prb %be_idx : i2
      %45 = comb.extract %44 from 1 : (i2) -> i1
      %46 = comb.concat %45, %false : i1, i1
      %47 = llhd.sig.extract %be_mask from %46 : <i4> -> <i2>
      llhd.drv %47, %c-1_i2 after %1 : i2
      cf.br ^bb9
    ^bb5:  // pred: ^bb3
      %48 = comb.icmp ceq %39, %c2_i3 : i3
      cf.cond_br %48, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %be_mask, %c-1_i4 after %1 : i4
      cf.br ^bb9
    ^bb7:  // pred: ^bb5
      %49 = comb.icmp ceq %39, %c3_i3 : i3
      cf.cond_br %49, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %be_mask, %c-1_i4 after %1 : i4
      cf.br ^bb9
    ^bb9:  // 5 preds: ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      llhd.wait (%6, %7, %8 : i4, i3, i2), ^bb1
    }
    %9 = comb.concat %c0_i29, %7 : i29, i3
    %10 = comb.shl %c-1_i32, %9 : i32
    llhd.drv %sbaccess_mask, %10 after %1 : i32
    %11 = llhd.prb %addr_incr_en : i1
    %12 = comb.shl %c1_i32, %9 : i32
    %13 = comb.mux %11, %12, %c0_i32 {sv.namehint = "addr_incr"} : i32
    %14 = llhd.prb %sbaddress_i_4 : i32
    %15 = comb.add %14, %13 : i32
    %16 = llhd.prb %req : i1
    %17 = llhd.prb %address : i32
    %18 = llhd.prb %we : i1
    %19 = llhd.prb %be : i4
    %20 = llhd.prb %sberror_o : i3
    %21 = llhd.prb %sberror_valid_o : i1
    %22 = llhd.prb %state_d : i3
    %23 = llhd.prb %sbaddress_write_valid_i_5 : i1
    %24 = llhd.prb %sbreadonaddr_i_6 : i1
    %25 = llhd.prb %sbdata_write_valid_i_11 : i1
    %26 = llhd.prb %sbdata_read_valid_i_10 : i1
    %27 = llhd.prb %sbreadondata_i_9 : i1
    %28 = llhd.prb %sbaccess_mask : i32
    %29 = llhd.prb %gnt : i1
    %30 = llhd.prb %sbdata_valid_o : i1
    %31 = llhd.prb %sbautoincrement_i_7 : i1
    %32 = llhd.prb %master_r_other_err_i_3 : i1
    %33 = llhd.prb %master_r_err_i_2 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb31
      llhd.drv %req, %false after %1 : i1
      %39 = llhd.prb %sbaddress_i_4 : i32
      llhd.drv %address, %39 after %1 : i32
      llhd.drv %we, %false after %1 : i1
      llhd.drv %be, %c0_i4 after %1 : i4
      %40 = llhd.prb %sbaddress_i_4 : i32
      %41 = comb.extract %40 from 0 : (i32) -> i2
      llhd.drv %be_idx, %41 after %1 : i2
      llhd.drv %sberror_o, %c0_i3 after %1 : i3
      llhd.drv %sberror_valid_o, %false after %1 : i1
      llhd.drv %addr_incr_en, %false after %1 : i1
      %42 = llhd.prb %state_q : i3
      llhd.drv %state_d, %42 after %1 : i3
      %43 = llhd.prb %state_q : i3
      %44 = comb.icmp ceq %43, %c0_i3 : i3
      cf.cond_br %44, ^bb2, ^bb8
    ^bb2:  // pred: ^bb1
      %45 = llhd.prb %sbaddress_write_valid_i_5 : i1
      %46 = llhd.prb %sbreadonaddr_i_6 : i1
      %47 = comb.and %45, %46 : i1
      cf.cond_br %47, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %state_d, %c1_i3 after %1 : i3
      cf.br ^bb4
    ^bb4:  // 2 preds: ^bb2, ^bb3
      %48 = llhd.prb %sbdata_write_valid_i_11 : i1
      cf.cond_br %48, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      llhd.drv %state_d, %c2_i3 after %1 : i3
      cf.br ^bb6
    ^bb6:  // 2 preds: ^bb4, ^bb5
      %49 = llhd.prb %sbdata_read_valid_i_10 : i1
      %50 = llhd.prb %sbreadondata_i_9 : i1
      %51 = comb.and %49, %50 : i1
      cf.cond_br %51, ^bb7, ^bb27
    ^bb7:  // pred: ^bb6
      llhd.drv %state_d, %c1_i3 after %1 : i3
      cf.br ^bb27
    ^bb8:  // pred: ^bb1
      %52 = comb.icmp ceq %43, %c1_i3 : i3
      cf.cond_br %52, ^bb9, ^bb11
    ^bb9:  // pred: ^bb8
      llhd.drv %req, %true after %1 : i1
      %53 = llhd.prb %be_mask : i4
      llhd.drv %be, %53 after %1 : i4
      %54 = llhd.prb %gnt : i1
      cf.cond_br %54, ^bb10, ^bb27
    ^bb10:  // pred: ^bb9
      llhd.drv %state_d, %c3_i3 after %1 : i3
      cf.br ^bb27
    ^bb11:  // pred: ^bb8
      %55 = comb.icmp ceq %43, %c2_i3 : i3
      cf.cond_br %55, ^bb12, ^bb14
    ^bb12:  // pred: ^bb11
      llhd.drv %req, %true after %1 : i1
      llhd.drv %we, %true after %1 : i1
      %56 = llhd.prb %be_mask : i4
      llhd.drv %be, %56 after %1 : i4
      %57 = llhd.prb %gnt : i1
      cf.cond_br %57, ^bb13, ^bb27
    ^bb13:  // pred: ^bb12
      llhd.drv %state_d, %c-4_i3 after %1 : i3
      cf.br ^bb27
    ^bb14:  // pred: ^bb11
      %58 = comb.icmp ceq %43, %c3_i3 : i3
      cf.cond_br %58, ^bb15, ^bb20
    ^bb15:  // pred: ^bb14
      %59 = llhd.prb %sbdata_valid_o : i1
      cf.cond_br %59, ^bb16, ^bb27
    ^bb16:  // pred: ^bb15
      llhd.drv %state_d, %c0_i3 after %1 : i3
      %60 = llhd.prb %sbautoincrement_i_7 : i1
      llhd.drv %addr_incr_en, %60 after %1 : i1
      %61 = llhd.prb %master_r_other_err_i_3 : i1
      cf.cond_br %61, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      llhd.drv %sberror_valid_o, %true after %1 : i1
      llhd.drv %sberror_o, %c-1_i3 after %1 : i3
      cf.br ^bb27
    ^bb18:  // pred: ^bb16
      %62 = llhd.prb %master_r_err_i_2 : i1
      cf.cond_br %62, ^bb19, ^bb27
    ^bb19:  // pred: ^bb18
      llhd.drv %sberror_valid_o, %true after %1 : i1
      llhd.drv %sberror_o, %c2_i3 after %1 : i3
      cf.br ^bb27
    ^bb20:  // pred: ^bb14
      %63 = comb.icmp ceq %43, %c-4_i3 : i3
      cf.cond_br %63, ^bb21, ^bb26
    ^bb21:  // pred: ^bb20
      %64 = llhd.prb %sbdata_valid_o : i1
      cf.cond_br %64, ^bb22, ^bb27
    ^bb22:  // pred: ^bb21
      llhd.drv %state_d, %c0_i3 after %1 : i3
      %65 = llhd.prb %sbautoincrement_i_7 : i1
      llhd.drv %addr_incr_en, %65 after %1 : i1
      %66 = llhd.prb %master_r_other_err_i_3 : i1
      cf.cond_br %66, ^bb23, ^bb24
    ^bb23:  // pred: ^bb22
      llhd.drv %sberror_valid_o, %true after %1 : i1
      llhd.drv %sberror_o, %c-1_i3 after %1 : i3
      cf.br ^bb27
    ^bb24:  // pred: ^bb22
      %67 = llhd.prb %master_r_err_i_2 : i1
      cf.cond_br %67, ^bb25, ^bb27
    ^bb25:  // pred: ^bb24
      llhd.drv %sberror_valid_o, %true after %1 : i1
      llhd.drv %sberror_o, %c2_i3 after %1 : i3
      cf.br ^bb27
    ^bb26:  // pred: ^bb20
      llhd.drv %state_d, %c0_i3 after %1 : i3
      cf.br ^bb27
    ^bb27:  // 15 preds: ^bb6, ^bb7, ^bb9, ^bb10, ^bb12, ^bb13, ^bb15, ^bb17, ^bb18, ^bb19, ^bb21, ^bb23, ^bb24, ^bb25, ^bb26
      %68 = llhd.prb %sbaccess_i_8 : i3
      %69 = comb.concat %c0_i29, %68 : i29, i3
      %70 = comb.icmp ugt %69, %c2_i32 : i32
      %71 = llhd.prb %state_q : i3
      %72 = comb.icmp ne %71, %c0_i3 : i3
      %73 = comb.and %70, %72 : i1
      cf.cond_br %73, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      llhd.drv %req, %false after %1 : i1
      llhd.drv %state_d, %c0_i3 after %1 : i3
      llhd.drv %sberror_valid_o, %true after %1 : i1
      llhd.drv %sberror_o, %c-4_i3 after %1 : i3
      cf.br ^bb29
    ^bb29:  // 2 preds: ^bb27, ^bb28
      %74 = llhd.prb %sbaddress_i_4 : i32
      %75 = llhd.prb %sbaccess_mask : i32
      %76 = comb.xor %75, %c-1_i32 : i32
      %77 = comb.and %74, %76 : i32
      %78 = comb.icmp ne %77, %c0_i32 : i32
      %79 = llhd.prb %state_q : i3
      %80 = comb.icmp ne %79, %c0_i3 : i3
      %81 = comb.and %78, %80 : i1
      cf.cond_br %81, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      llhd.drv %req, %false after %1 : i1
      llhd.drv %state_d, %c0_i3 after %1 : i3
      llhd.drv %sberror_valid_o, %true after %1 : i1
      llhd.drv %sberror_o, %c3_i3 after %1 : i3
      cf.br ^bb31
    ^bb31:  // 2 preds: ^bb29, ^bb30
      llhd.wait (%16, %14, %17, %18, %19, %8, %20, %21, %11, %4, %22, %23, %24, %25, %26, %27, %7, %28, %6, %29, %30, %31, %32, %33 : i1, i32, i32, i1, i4, i2, i3, i1, i1, i3, i3, i1, i1, i1, i1, i1, i3, i32, i4, i1, i1, i1, i1, i1), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %39 = llhd.prb %clk_i_0 : i1
      %40 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %41 = llhd.prb %clk_i_0 : i1
      %42 = comb.xor bin %39, %true : i1
      %43 = comb.and bin %42, %41 : i1
      %44 = llhd.prb %rst_ni_1 : i1
      %45 = comb.xor bin %44, %true : i1
      %46 = comb.and bin %40, %45 : i1
      %47 = comb.or bin %43, %46 : i1
      cf.cond_br %47, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %48 = llhd.prb %rst_ni_1 : i1
      %49 = comb.xor %48, %true : i1
      cf.cond_br %49, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %state_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %50 = llhd.prb %state_d : i3
      llhd.drv %state_q, %50 after %0 : i3
      cf.br ^bb1
    }
    %34 = comb.extract %28 from 0 : (i32) -> i2
    %35 = comb.and %8, %34 {sv.namehint = "be_idx_masked"} : i2
    %36 = comb.concat %c0_i27, %35, %c0_i3 : i27, i2, i3
    %37 = comb.shl %sbdata_i, %36 : i32
    llhd.drv %gnt, %master_gnt_i after %1 : i1
    llhd.drv %sbdata_valid_o, %master_r_valid_i after %1 : i1
    %38 = comb.shru %master_r_rdata_i, %36 : i32
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %master_r_err_i_2, %master_r_err_i after %1 : i1
    llhd.drv %master_r_other_err_i_3, %master_r_other_err_i after %1 : i1
    llhd.drv %sbaddress_i_4, %sbaddress_i after %1 : i32
    llhd.drv %sbaddress_write_valid_i_5, %sbaddress_write_valid_i after %1 : i1
    llhd.drv %sbreadonaddr_i_6, %sbreadonaddr_i after %1 : i1
    llhd.drv %sbautoincrement_i_7, %sbautoincrement_i after %1 : i1
    llhd.drv %sbaccess_i_8, %sbaccess_i after %1 : i3
    llhd.drv %sbreadondata_i_9, %sbreadondata_i after %1 : i1
    llhd.drv %sbdata_read_valid_i_10, %sbdata_read_valid_i after %1 : i1
    llhd.drv %sbdata_write_valid_i_11, %sbdata_write_valid_i after %1 : i1
    hw.output %16, %17, %18, %37, %19, %15, %38, %30, %5, %21, %20 : i1, i32, i1, i32, i4, i32, i32, i1, i1, i1, i3
  }
  hw.module private @dmi_jtag(in %clk_i : i1, in %rst_ni : i1, in %testmode_i : i1, in %test_rst_ni : i1, out dmi_rst_no : i1, out dmi_req_o : !hw.struct<addr: i32, op: i2, data: i32>, out dmi_req_valid_o : i1, in %dmi_req_ready_i : i1, in %dmi_resp_i : !hw.struct<data: i32, resp: i2>, out dmi_resp_ready_o : i1, in %dmi_resp_valid_i : i1, in %tck_i : i1, in %tms_i : i1, in %trst_ni : i1, in %td_i : i1, out td_o : i1, out tdo_oe_o : i1) {
    %c0_i25 = hw.constant 0 : i25
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [0 : i7, 0 : i32, 0 : i2] : !hw.struct<address: i7, data: i32, op: i2>
    %3 = hw.aggregate_constant [0 : i32, 0 : i2] : !hw.struct<data: i32, resp: i2>
    %4 = hw.aggregate_constant [0 : i32, 0 : i2, 0 : i32] : !hw.struct<addr: i32, op: i2, data: i32>
    %5 = hw.aggregate_constant [0 : i14, false, false, false, 0 : i3, 0 : i2, 0 : i6, 0 : i4] : !hw.struct<zero1: i14, dmihardreset: i1, dmireset: i1, zero0: i1, idle: i3, dmistat: i2, abits: i6, version: i4>
    %c0_i41 = hw.constant 0 : i41
    %c-4_i3 = hw.constant -4 : i3
    %c-1163018018_i32 = hw.constant -1163018018 : i32
    %c-1336823727_i32 = hw.constant -1336823727 : i32
    %c-1_i2 = hw.constant -1 : i2
    %c-559038737_i32 = hw.constant -559038737 : i32
    %c2_i3 = hw.constant 2 : i3
    %c0_i7 = hw.constant 0 : i7
    %c0_i2 = hw.constant 0 : i2
    %c0_i3 = hw.constant 0 : i3
    %true = hw.constant true {sv.namehint = "dmi_resp_ready"}
    %c1_i2 = hw.constant 1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c3_i3 = hw.constant 3 : i3
    %c0_i32 = hw.constant 0 : i32
    %c1_i4 = hw.constant 1 : i4
    %c7_i6 = hw.constant 7 : i6
    %c1_i3 = hw.constant 1 : i3
    %false = hw.constant false
    %c0_i14 = hw.constant 0 : i14
    %trst_ni_0 = llhd.sig name "trst_ni" %false : i1
    %6 = llhd.prb %trst_ni_0 : i1
    %error_d = llhd.sig %c0_i2 : i2
    %error_q = llhd.sig %c0_i2 : i2
    %tck = llhd.sig %false : i1
    %7 = llhd.prb %tck : i1
    %dmi_clear = llhd.sig %false : i1
    %update = llhd.sig %false : i1
    %capture = llhd.sig %false : i1
    %shift = llhd.sig %false : i1
    %tdi = llhd.sig %false : i1
    %dtmcs_select = llhd.sig %false : i1
    %dtmcs_d = llhd.sig %5 : !hw.struct<zero1: i14, dmihardreset: i1, dmireset: i1, zero0: i1, idle: i3, dmistat: i2, abits: i6, version: i4>
    %dtmcs_q = llhd.sig %5 : !hw.struct<zero1: i14, dmihardreset: i1, dmireset: i1, zero0: i1, idle: i3, dmistat: i2, abits: i6, version: i4>
    %dmi_select = llhd.sig %false : i1
    %dmi_req = llhd.sig %4 : !hw.struct<addr: i32, op: i2, data: i32>
    %dmi_req_ready = llhd.sig %false : i1
    %dmi_req_valid = llhd.sig %false : i1
    %dmi_resp = llhd.sig %3 : !hw.struct<data: i32, resp: i2>
    %dmi_resp_valid = llhd.sig %false : i1
    %state_d = llhd.sig %c0_i3 : i3
    %state_q = llhd.sig %c0_i3 : i3
    %dr_d = llhd.sig %c0_i41 : i41
    %dr_q = llhd.sig %c0_i41 : i41
    %address_d = llhd.sig %c0_i7 : i7
    %address_q = llhd.sig %c0_i7 : i7
    %data_d = llhd.sig %c0_i32 : i32
    %data_q = llhd.sig %c0_i32 : i32
    %dmi = llhd.sig %2 : !hw.struct<address: i7, data: i32, op: i2>
    %error_dmi_busy = llhd.sig %false : i1
    %error_dmi_op_failed = llhd.sig %false : i1
    %8 = llhd.prb %dtmcs_q : !hw.struct<zero1: i14, dmihardreset: i1, dmireset: i1, zero0: i1, idle: i3, dmistat: i2, abits: i6, version: i4>
    %9 = hw.bitcast %8 : (!hw.struct<zero1: i14, dmihardreset: i1, dmireset: i1, zero0: i1, idle: i3, dmistat: i2, abits: i6, version: i4>) -> i32
    %10 = comb.extract %9 from 0 : (i32) -> i1
    %i_dmi_jtag_tap.td_o, %i_dmi_jtag_tap.tdo_oe_o, %i_dmi_jtag_tap.tck_o, %i_dmi_jtag_tap.dmi_clear_o, %i_dmi_jtag_tap.update_o, %i_dmi_jtag_tap.capture_o, %i_dmi_jtag_tap.shift_o, %i_dmi_jtag_tap.tdi_o, %i_dmi_jtag_tap.dtmcs_select_o, %i_dmi_jtag_tap.dmi_select_o = hw.instance "i_dmi_jtag_tap" @dmi_jtag_tap(tck_i: %tck_i: i1, tms_i: %tms_i: i1, trst_ni: %6: i1, td_i: %td_i: i1, testmode_i: %testmode_i: i1, dtmcs_tdo_i: %10: i1, dmi_tdo_i: %45: i1) -> (td_o: i1, tdo_oe_o: i1, tck_o: i1, dmi_clear_o: i1, update_o: i1, capture_o: i1, shift_o: i1, tdi_o: i1, dtmcs_select_o: i1, dmi_select_o: i1) {sv.namehint = "jtag_dmi_clear"}
    llhd.drv %tck, %i_dmi_jtag_tap.tck_o after %1 : i1
    llhd.drv %update, %i_dmi_jtag_tap.update_o after %1 : i1
    llhd.drv %capture, %i_dmi_jtag_tap.capture_o after %1 : i1
    llhd.drv %shift, %i_dmi_jtag_tap.shift_o after %1 : i1
    llhd.drv %tdi, %i_dmi_jtag_tap.tdi_o after %1 : i1
    llhd.drv %dtmcs_select, %i_dmi_jtag_tap.dtmcs_select_o after %1 : i1
    llhd.drv %dmi_select, %i_dmi_jtag_tap.dmi_select_o after %1 : i1
    %11 = llhd.prb %dmi_req : !hw.struct<addr: i32, op: i2, data: i32>
    %12 = llhd.prb %dmi_req_valid : i1
    %13 = llhd.prb %dmi_clear : i1
    %i_dmi_cdc.jtag_dmi_ready_o, %i_dmi_cdc.jtag_dmi_resp_o, %i_dmi_cdc.jtag_dmi_valid_o, %i_dmi_cdc.core_dmi_rst_no, %i_dmi_cdc.core_dmi_req_o, %i_dmi_cdc.core_dmi_valid_o, %i_dmi_cdc.core_dmi_ready_o = hw.instance "i_dmi_cdc" @dmi_cdc(testmode_i: %testmode_i: i1, test_rst_ni: %test_rst_ni: i1, tck_i: %7: i1, trst_ni: %6: i1, jtag_dmi_req_i: %11: !hw.struct<addr: i32, op: i2, data: i32>, jtag_dmi_valid_i: %12: i1, jtag_dmi_cdc_clear_i: %13: i1, jtag_dmi_ready_i: %true: i1, clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, core_dmi_ready_i: %dmi_req_ready_i: i1, core_dmi_resp_i: %dmi_resp_i: !hw.struct<data: i32, resp: i2>, core_dmi_valid_i: %dmi_resp_valid_i: i1) -> (jtag_dmi_ready_o: i1, jtag_dmi_resp_o: !hw.struct<data: i32, resp: i2>, jtag_dmi_valid_o: i1, core_dmi_rst_no: i1, core_dmi_req_o: !hw.struct<addr: i32, op: i2, data: i32>, core_dmi_valid_o: i1, core_dmi_ready_o: i1)
    llhd.drv %dmi_req_ready, %i_dmi_cdc.jtag_dmi_ready_o after %1 : i1
    llhd.drv %dmi_resp, %i_dmi_cdc.jtag_dmi_resp_o after %1 : !hw.struct<data: i32, resp: i2>
    llhd.drv %dmi_resp_valid, %i_dmi_cdc.jtag_dmi_valid_o after %1 : i1
    %14 = llhd.prb %dtmcs_select : i1
    %15 = llhd.prb %update : i1
    %dmihardreset = hw.struct_extract %8["dmihardreset"] : !hw.struct<zero1: i14, dmihardreset: i1, dmireset: i1, zero0: i1, idle: i3, dmistat: i2, abits: i6, version: i4>
    %16 = comb.and %14, %15, %dmihardreset : i1
    %17 = comb.or %i_dmi_jtag_tap.dmi_clear_o, %16 : i1
    llhd.drv %dmi_clear, %17 after %1 : i1
    %18 = llhd.prb %dtmcs_d : !hw.struct<zero1: i14, dmihardreset: i1, dmireset: i1, zero0: i1, idle: i3, dmistat: i2, abits: i6, version: i4>
    %19 = llhd.prb %capture : i1
    %20 = llhd.prb %error_q : i2
    %21 = llhd.prb %shift : i1
    %22 = llhd.prb %tdi : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb7
      %47 = llhd.prb %dtmcs_q : !hw.struct<zero1: i14, dmihardreset: i1, dmireset: i1, zero0: i1, idle: i3, dmistat: i2, abits: i6, version: i4>
      llhd.drv %dtmcs_d, %47 after %1 : !hw.struct<zero1: i14, dmihardreset: i1, dmireset: i1, zero0: i1, idle: i3, dmistat: i2, abits: i6, version: i4>
      %48 = llhd.prb %capture : i1
      cf.cond_br %48, ^bb2, ^bb4
    ^bb2:  // pred: ^bb1
      %49 = llhd.prb %dtmcs_select : i1
      cf.cond_br %49, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %50 = llhd.prb %error_q : i2
      %51 = hw.struct_create (%c0_i14, %false, %false, %false, %c1_i3, %50, %c7_i6, %c1_i4) : !hw.struct<zero1: i14, dmihardreset: i1, dmireset: i1, zero0: i1, idle: i3, dmistat: i2, abits: i6, version: i4>
      llhd.drv %dtmcs_d, %51 after %1 : !hw.struct<zero1: i14, dmihardreset: i1, dmireset: i1, zero0: i1, idle: i3, dmistat: i2, abits: i6, version: i4>
      cf.br ^bb4
    ^bb4:  // 3 preds: ^bb1, ^bb2, ^bb3
      %52 = llhd.prb %shift : i1
      cf.cond_br %52, ^bb5, ^bb7
    ^bb5:  // pred: ^bb4
      %53 = llhd.prb %dtmcs_select : i1
      cf.cond_br %53, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %54 = llhd.prb %tdi : i1
      %55 = llhd.prb %dtmcs_q : !hw.struct<zero1: i14, dmihardreset: i1, dmireset: i1, zero0: i1, idle: i3, dmistat: i2, abits: i6, version: i4>
      %56 = hw.bitcast %55 : (!hw.struct<zero1: i14, dmihardreset: i1, dmireset: i1, zero0: i1, idle: i3, dmistat: i2, abits: i6, version: i4>) -> i32
      %57 = comb.extract %56 from 1 : (i32) -> i31
      %58 = comb.concat %54, %57 : i1, i31
      %59 = hw.bitcast %58 : (i32) -> !hw.struct<zero1: i14, dmihardreset: i1, dmireset: i1, zero0: i1, idle: i3, dmistat: i2, abits: i6, version: i4>
      llhd.drv %dtmcs_d, %59 after %1 : !hw.struct<zero1: i14, dmihardreset: i1, dmireset: i1, zero0: i1, idle: i3, dmistat: i2, abits: i6, version: i4>
      cf.br ^bb7
    ^bb7:  // 3 preds: ^bb4, ^bb5, ^bb6
      llhd.wait (%8, %18, %19, %14, %20, %21, %22 : !hw.struct<zero1: i14, dmihardreset: i1, dmireset: i1, zero0: i1, idle: i3, dmistat: i2, abits: i6, version: i4>, !hw.struct<zero1: i14, dmihardreset: i1, dmireset: i1, zero0: i1, idle: i3, dmistat: i2, abits: i6, version: i4>, i1, i1, i2, i1, i1), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %47 = llhd.prb %tck : i1
      %48 = llhd.prb %trst_ni_0 : i1
      llhd.wait (%7, %6 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %49 = llhd.prb %tck : i1
      %50 = comb.xor bin %47, %true : i1
      %51 = comb.and bin %50, %49 : i1
      %52 = llhd.prb %trst_ni_0 : i1
      %53 = comb.xor bin %52, %true : i1
      %54 = comb.and bin %48, %53 : i1
      %55 = comb.or bin %51, %54 : i1
      cf.cond_br %55, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %56 = llhd.prb %trst_ni_0 : i1
      %57 = comb.xor %56, %true : i1
      cf.cond_br %57, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %dtmcs_q, %5 after %0 : !hw.struct<zero1: i14, dmihardreset: i1, dmireset: i1, zero0: i1, idle: i3, dmistat: i2, abits: i6, version: i4>
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %58 = llhd.prb %dtmcs_d : !hw.struct<zero1: i14, dmihardreset: i1, dmireset: i1, zero0: i1, idle: i3, dmistat: i2, abits: i6, version: i4>
      llhd.drv %dtmcs_q, %58 after %0 : !hw.struct<zero1: i14, dmihardreset: i1, dmireset: i1, zero0: i1, idle: i3, dmistat: i2, abits: i6, version: i4>
      cf.br ^bb1
    }
    %23 = llhd.prb %dr_q : i41
    %24 = hw.bitcast %23 : (i41) -> !hw.struct<address: i7, data: i32, op: i2>
    llhd.drv %dmi, %24 after %1 : !hw.struct<address: i7, data: i32, op: i2>
    %25 = llhd.sig.struct_extract %dmi_req["addr"] : <!hw.struct<addr: i32, op: i2, data: i32>>
    %26 = llhd.prb %address_q : i7
    %27 = comb.concat %c0_i25, %26 : i25, i7
    llhd.drv %25, %27 after %1 : i32
    %28 = llhd.sig.struct_extract %dmi_req["data"] : <!hw.struct<addr: i32, op: i2, data: i32>>
    %29 = llhd.prb %data_q : i32
    llhd.drv %28, %29 after %1 : i32
    %30 = llhd.sig.struct_extract %dmi_req["op"] : <!hw.struct<addr: i32, op: i2, data: i32>>
    %31 = llhd.prb %state_q : i3
    %32 = comb.icmp eq %31, %c3_i3 : i3
    %33 = comb.mux %32, %c-2_i2, %c1_i2 : i2
    llhd.drv %30, %33 after %1 : i2
    %34 = llhd.prb %error_dmi_busy : i1
    %35 = llhd.prb %error_dmi_op_failed : i1
    %36 = llhd.prb %state_d : i3
    %37 = llhd.prb %address_d : i7
    %38 = llhd.prb %data_d : i32
    %39 = llhd.prb %error_d : i2
    %40 = llhd.prb %dmi_select : i1
    %41 = llhd.prb %dmi : !hw.struct<address: i7, data: i32, op: i2>
    %42 = llhd.prb %dmi_req_ready : i1
    %43 = llhd.prb %dmi_resp_valid : i1
    %44 = llhd.prb %dmi_resp : !hw.struct<data: i32, resp: i2>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb44
      llhd.drv %error_dmi_busy, %false after %1 : i1
      llhd.drv %error_dmi_op_failed, %false after %1 : i1
      %47 = llhd.prb %state_q : i3
      llhd.drv %state_d, %47 after %1 : i3
      %48 = llhd.prb %address_q : i7
      llhd.drv %address_d, %48 after %1 : i7
      %49 = llhd.prb %data_q : i32
      llhd.drv %data_d, %49 after %1 : i32
      %50 = llhd.prb %error_q : i2
      llhd.drv %error_d, %50 after %1 : i2
      llhd.drv %dmi_req_valid, %false after %1 : i1
      %51 = llhd.prb %dmi_clear : i1
      cf.cond_br %51, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      llhd.drv %state_d, %c0_i3 after %1 : i3
      llhd.drv %data_d, %c0_i32 after %1 : i32
      llhd.drv %error_d, %c0_i2 after %1 : i2
      llhd.drv %address_d, %c0_i7 after %1 : i7
      cf.br ^bb44
    ^bb3:  // pred: ^bb1
      %52 = llhd.prb %state_q : i3
      %53 = comb.icmp ceq %52, %c0_i3 : i3
      cf.cond_br %53, ^bb4, ^bb9
    ^bb4:  // pred: ^bb3
      %54 = llhd.prb %dmi_select : i1
      %55 = llhd.prb %update : i1
      %56 = llhd.prb %error_q : i2
      %57 = comb.icmp eq %56, %c0_i2 : i2
      %58 = comb.and %54, %55, %57 : i1
      cf.cond_br %58, ^bb5, ^bb34
    ^bb5:  // pred: ^bb4
      %59 = llhd.prb %dmi : !hw.struct<address: i7, data: i32, op: i2>
      %address = hw.struct_extract %59["address"] : !hw.struct<address: i7, data: i32, op: i2>
      llhd.drv %address_d, %address after %1 : i7
      %60 = llhd.prb %dmi : !hw.struct<address: i7, data: i32, op: i2>
      %data = hw.struct_extract %60["data"] : !hw.struct<address: i7, data: i32, op: i2>
      llhd.drv %data_d, %data after %1 : i32
      %61 = llhd.prb %dmi : !hw.struct<address: i7, data: i32, op: i2>
      %op = hw.struct_extract %61["op"] : !hw.struct<address: i7, data: i32, op: i2>
      %62 = comb.icmp eq %op, %c1_i2 : i2
      cf.cond_br %62, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %state_d, %c1_i3 after %1 : i3
      cf.br ^bb34
    ^bb7:  // pred: ^bb5
      %63 = llhd.prb %dmi : !hw.struct<address: i7, data: i32, op: i2>
      %op_1 = hw.struct_extract %63["op"] : !hw.struct<address: i7, data: i32, op: i2>
      %64 = comb.icmp eq %op_1, %c-2_i2 : i2
      cf.cond_br %64, ^bb8, ^bb34
    ^bb8:  // pred: ^bb7
      llhd.drv %state_d, %c3_i3 after %1 : i3
      cf.br ^bb34
    ^bb9:  // pred: ^bb3
      %65 = comb.icmp ceq %52, %c1_i3 : i3
      cf.cond_br %65, ^bb10, ^bb12
    ^bb10:  // pred: ^bb9
      llhd.drv %dmi_req_valid, %true after %1 : i1
      %66 = llhd.prb %dmi_req_ready : i1
      cf.cond_br %66, ^bb11, ^bb34
    ^bb11:  // pred: ^bb10
      llhd.drv %state_d, %c2_i3 after %1 : i3
      cf.br ^bb34
    ^bb12:  // pred: ^bb9
      %67 = comb.icmp ceq %52, %c2_i3 : i3
      cf.cond_br %67, ^bb13, ^bb22
    ^bb13:  // pred: ^bb12
      %68 = llhd.prb %dmi_resp_valid : i1
      cf.cond_br %68, ^bb14, ^bb34
    ^bb14:  // pred: ^bb13
      %69 = llhd.prb %dmi_resp : !hw.struct<data: i32, resp: i2>
      %resp = hw.struct_extract %69["resp"] : !hw.struct<data: i32, resp: i2>
      %70 = comb.icmp ceq %resp, %c0_i2 : i2
      cf.cond_br %70, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      %71 = llhd.prb %dmi_resp : !hw.struct<data: i32, resp: i2>
      %data_2 = hw.struct_extract %71["data"] : !hw.struct<data: i32, resp: i2>
      llhd.drv %data_d, %data_2 after %1 : i32
      cf.br ^bb21
    ^bb16:  // pred: ^bb14
      %72 = comb.icmp ceq %resp, %c-2_i2 : i2
      cf.cond_br %72, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      llhd.drv %data_d, %c-559038737_i32 after %1 : i32
      llhd.drv %error_dmi_op_failed, %true after %1 : i1
      cf.br ^bb21
    ^bb18:  // pred: ^bb16
      %73 = comb.icmp ceq %resp, %c-1_i2 : i2
      cf.cond_br %73, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      llhd.drv %data_d, %c-1336823727_i32 after %1 : i32
      llhd.drv %error_dmi_busy, %true after %1 : i1
      cf.br ^bb21
    ^bb20:  // pred: ^bb18
      llhd.drv %data_d, %c-1163018018_i32 after %1 : i32
      cf.br ^bb21
    ^bb21:  // 4 preds: ^bb15, ^bb17, ^bb19, ^bb20
      llhd.drv %state_d, %c0_i3 after %1 : i3
      cf.br ^bb34
    ^bb22:  // pred: ^bb12
      %74 = comb.icmp ceq %52, %c3_i3 : i3
      cf.cond_br %74, ^bb23, ^bb25
    ^bb23:  // pred: ^bb22
      llhd.drv %dmi_req_valid, %true after %1 : i1
      %75 = llhd.prb %dmi_req_ready : i1
      cf.cond_br %75, ^bb24, ^bb34
    ^bb24:  // pred: ^bb23
      llhd.drv %state_d, %c-4_i3 after %1 : i3
      cf.br ^bb34
    ^bb25:  // pred: ^bb22
      %76 = comb.icmp ceq %52, %c-4_i3 : i3
      cf.cond_br %76, ^bb26, ^bb32
    ^bb26:  // pred: ^bb25
      %77 = llhd.prb %dmi_resp_valid : i1
      cf.cond_br %77, ^bb27, ^bb34
    ^bb27:  // pred: ^bb26
      %78 = llhd.prb %dmi_resp : !hw.struct<data: i32, resp: i2>
      %resp_3 = hw.struct_extract %78["resp"] : !hw.struct<data: i32, resp: i2>
      %79 = comb.icmp ceq %resp_3, %c-2_i2 : i2
      cf.cond_br %79, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      llhd.drv %error_dmi_op_failed, %true after %1 : i1
      cf.br ^bb31
    ^bb29:  // pred: ^bb27
      %80 = comb.icmp ceq %resp_3, %c-1_i2 : i2
      cf.cond_br %80, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      llhd.drv %error_dmi_busy, %true after %1 : i1
      cf.br ^bb31
    ^bb31:  // 3 preds: ^bb28, ^bb29, ^bb30
      llhd.drv %state_d, %c0_i3 after %1 : i3
      cf.br ^bb34
    ^bb32:  // pred: ^bb25
      %81 = llhd.prb %dmi_resp_valid : i1
      cf.cond_br %81, ^bb33, ^bb34
    ^bb33:  // pred: ^bb32
      llhd.drv %state_d, %c0_i3 after %1 : i3
      cf.br ^bb34
    ^bb34:  // 14 preds: ^bb4, ^bb6, ^bb7, ^bb8, ^bb10, ^bb11, ^bb13, ^bb21, ^bb23, ^bb24, ^bb26, ^bb31, ^bb32, ^bb33
      %82 = llhd.prb %update : i1
      %83 = llhd.prb %state_q : i3
      %84 = comb.icmp ne %83, %c0_i3 : i3
      %85 = comb.and %82, %84 : i1
      cf.cond_br %85, ^bb35, ^bb36
    ^bb35:  // pred: ^bb34
      llhd.drv %error_dmi_busy, %true after %1 : i1
      cf.br ^bb36
    ^bb36:  // 2 preds: ^bb34, ^bb35
      %86 = llhd.prb %capture : i1
      %87 = llhd.prb %state_q : i3
      %88 = comb.icmp weq %87, %c1_i3 : i3
      %89 = comb.icmp weq %87, %c2_i3 : i3
      %90 = comb.or %88, %89 : i1
      %91 = comb.and %86, %90 : i1
      cf.cond_br %91, ^bb37, ^bb38
    ^bb37:  // pred: ^bb36
      llhd.drv %error_dmi_busy, %true after %1 : i1
      cf.br ^bb38
    ^bb38:  // 2 preds: ^bb36, ^bb37
      %92 = llhd.prb %error_dmi_busy : i1
      %93 = llhd.prb %error_q : i2
      %94 = comb.icmp eq %93, %c0_i2 : i2
      %95 = comb.and %92, %94 : i1
      cf.cond_br %95, ^bb39, ^bb40
    ^bb39:  // pred: ^bb38
      llhd.drv %error_d, %c-1_i2 after %1 : i2
      cf.br ^bb40
    ^bb40:  // 2 preds: ^bb38, ^bb39
      %96 = llhd.prb %error_dmi_op_failed : i1
      %97 = llhd.prb %error_q : i2
      %98 = comb.icmp eq %97, %c0_i2 : i2
      %99 = comb.and %96, %98 : i1
      cf.cond_br %99, ^bb41, ^bb42
    ^bb41:  // pred: ^bb40
      llhd.drv %error_d, %c-2_i2 after %1 : i2
      cf.br ^bb42
    ^bb42:  // 2 preds: ^bb40, ^bb41
      %100 = llhd.prb %update : i1
      %101 = llhd.prb %dtmcs_q : !hw.struct<zero1: i14, dmihardreset: i1, dmireset: i1, zero0: i1, idle: i3, dmistat: i2, abits: i6, version: i4>
      %dmireset = hw.struct_extract %101["dmireset"] : !hw.struct<zero1: i14, dmihardreset: i1, dmireset: i1, zero0: i1, idle: i3, dmistat: i2, abits: i6, version: i4>
      %102 = llhd.prb %dtmcs_select : i1
      %103 = comb.and %100, %dmireset, %102 : i1
      cf.cond_br %103, ^bb43, ^bb44
    ^bb43:  // pred: ^bb42
      llhd.drv %error_d, %c0_i2 after %1 : i2
      cf.br ^bb44
    ^bb44:  // 3 preds: ^bb2, ^bb42, ^bb43
      llhd.wait (%34, %35, %31, %36, %26, %37, %29, %38, %20, %39, %12, %13, %40, %15, %41, %19, %8, %14, %42, %43, %44 : i1, i1, i3, i3, i7, i7, i32, i32, i2, i2, i1, i1, i1, i1, !hw.struct<address: i7, data: i32, op: i2>, i1, !hw.struct<zero1: i14, dmihardreset: i1, dmireset: i1, zero0: i1, idle: i3, dmistat: i2, abits: i6, version: i4>, i1, i1, i1, !hw.struct<data: i32, resp: i2>), ^bb1
    }
    %45 = comb.extract %23 from 0 {sv.namehint = "dmi_tdo"} : (i41) -> i1
    %46 = llhd.prb %dr_d : i41
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb12
      %47 = llhd.prb %dr_q : i41
      llhd.drv %dr_d, %47 after %1 : i41
      %48 = llhd.prb %dmi_clear : i1
      cf.cond_br %48, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      llhd.drv %dr_d, %c0_i41 after %1 : i41
      cf.br ^bb12
    ^bb3:  // pred: ^bb1
      %49 = llhd.prb %capture : i1
      cf.cond_br %49, ^bb4, ^bb9
    ^bb4:  // pred: ^bb3
      %50 = llhd.prb %dmi_select : i1
      cf.cond_br %50, ^bb5, ^bb9
    ^bb5:  // pred: ^bb4
      %51 = llhd.prb %error_q : i2
      %52 = comb.icmp eq %51, %c0_i2 : i2
      %53 = llhd.prb %error_dmi_busy : i1
      %54 = comb.xor %53, %true : i1
      %55 = comb.and %52, %54 : i1
      cf.cond_br %55, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %56 = llhd.prb %address_q : i7
      %57 = llhd.prb %data_q : i32
      %58 = comb.concat %56, %57, %c0_i2 : i7, i32, i2
      llhd.drv %dr_d, %58 after %1 : i41
      cf.br ^bb9
    ^bb7:  // pred: ^bb5
      %59 = llhd.prb %error_q : i2
      %60 = comb.icmp eq %59, %c-1_i2 : i2
      %61 = llhd.prb %error_dmi_busy : i1
      %62 = comb.or %60, %61 : i1
      cf.cond_br %62, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %63 = llhd.prb %address_q : i7
      %64 = llhd.prb %data_q : i32
      %65 = comb.concat %63, %64, %c-1_i2 : i7, i32, i2
      llhd.drv %dr_d, %65 after %1 : i41
      cf.br ^bb9
    ^bb9:  // 5 preds: ^bb3, ^bb4, ^bb6, ^bb7, ^bb8
      %66 = llhd.prb %shift : i1
      cf.cond_br %66, ^bb10, ^bb12
    ^bb10:  // pred: ^bb9
      %67 = llhd.prb %dmi_select : i1
      cf.cond_br %67, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      %68 = llhd.prb %tdi : i1
      %69 = llhd.prb %dr_q : i41
      %70 = comb.extract %69 from 1 : (i41) -> i40
      %71 = comb.concat %68, %70 : i1, i40
      llhd.drv %dr_d, %71 after %1 : i41
      cf.br ^bb12
    ^bb12:  // 4 preds: ^bb2, ^bb9, ^bb10, ^bb11
      llhd.wait (%23, %46, %13, %19, %40, %20, %34, %26, %29, %21, %22 : i41, i41, i1, i1, i1, i2, i1, i7, i32, i1, i1), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %47 = llhd.prb %tck : i1
      %48 = llhd.prb %trst_ni_0 : i1
      llhd.wait (%7, %6 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %49 = llhd.prb %tck : i1
      %50 = comb.xor bin %47, %true : i1
      %51 = comb.and bin %50, %49 : i1
      %52 = llhd.prb %trst_ni_0 : i1
      %53 = comb.xor bin %52, %true : i1
      %54 = comb.and bin %48, %53 : i1
      %55 = comb.or bin %51, %54 : i1
      cf.cond_br %55, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %56 = llhd.prb %trst_ni_0 : i1
      %57 = comb.xor %56, %true : i1
      cf.cond_br %57, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %dr_q, %c0_i41 after %0 : i41
      llhd.drv %state_q, %c0_i3 after %0 : i3
      llhd.drv %address_q, %c0_i7 after %0 : i7
      llhd.drv %data_q, %c0_i32 after %0 : i32
      llhd.drv %error_q, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %58 = llhd.prb %dr_d : i41
      llhd.drv %dr_q, %58 after %0 : i41
      %59 = llhd.prb %state_d : i3
      llhd.drv %state_q, %59 after %0 : i3
      %60 = llhd.prb %address_d : i7
      llhd.drv %address_q, %60 after %0 : i7
      %61 = llhd.prb %data_d : i32
      llhd.drv %data_q, %61 after %0 : i32
      %62 = llhd.prb %error_d : i2
      llhd.drv %error_q, %62 after %0 : i2
      cf.br ^bb1
    }
    llhd.drv %trst_ni_0, %trst_ni after %1 : i1
    hw.output %i_dmi_cdc.core_dmi_rst_no, %i_dmi_cdc.core_dmi_req_o, %i_dmi_cdc.core_dmi_valid_o, %i_dmi_cdc.core_dmi_ready_o, %i_dmi_jtag_tap.td_o, %i_dmi_jtag_tap.tdo_oe_o : i1, !hw.struct<addr: i32, op: i2, data: i32>, i1, i1, i1, i1
  }
  hw.module private @dmi_jtag_tap(in %tck_i : i1, in %tms_i : i1, in %trst_ni : i1, in %td_i : i1, out td_o : i1, out tdo_oe_o : i1, in %testmode_i : i1, out tck_o : i1, out dmi_clear_o : i1, out update_o : i1, out capture_o : i1, out shift_o : i1, out tdi_o : i1, out dtmcs_select_o : i1, in %dtmcs_tdo_i : i1, out dmi_select_o : i1, in %dmi_tdo_i : i1) {
    %c-1_i2 = hw.constant -1 : i2
    %c3_i3 = hw.constant 3 : i3
    %c2_i3 = hw.constant 2 : i3
    %c0_i3 = hw.constant 0 : i3
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c-2_i4 = hw.constant -2 : i4
    %c-3_i4 = hw.constant -3 : i4
    %c-5_i4 = hw.constant -5 : i4
    %c-4_i4 = hw.constant -4 : i4
    %c-6_i4 = hw.constant -6 : i4
    %c7_i4 = hw.constant 7 : i4
    %c6_i4 = hw.constant 6 : i4
    %c-8_i4 = hw.constant -8 : i4
    %c4_i4 = hw.constant 4 : i4
    %c5_i4 = hw.constant 5 : i4
    %c3_i4 = hw.constant 3 : i4
    %c-7_i4 = hw.constant -7 : i4
    %c2_i4 = hw.constant 2 : i4
    %c1_i4 = hw.constant 1 : i4
    %c0_i4 = hw.constant 0 : i4
    %c-1_i5 = hw.constant -1 : i5
    %c-15_i5 = hw.constant -15 : i5
    %c-16_i5 = hw.constant -16 : i5
    %true = hw.constant true
    %c1_i32 = hw.constant 1 : i32
    %false = hw.constant false
    %c1_i5 = hw.constant 1 : i5
    %c0_i5 = hw.constant 0 : i5
    %c5_i5 = hw.constant 5 : i5
    %tck_i_0 = llhd.sig name "tck_i" %false : i1
    %2 = llhd.prb %tck_i_0 : i1
    %tms_i_1 = llhd.sig name "tms_i" %false : i1
    %trst_ni_2 = llhd.sig name "trst_ni" %false : i1
    %3 = llhd.prb %trst_ni_2 : i1
    %td_i_3 = llhd.sig name "td_i" %false : i1
    %td_o = llhd.sig %false : i1
    %tdo_oe_o = llhd.sig %false : i1
    %dtmcs_select_o = llhd.sig %false : i1
    %dtmcs_tdo_i_4 = llhd.sig name "dtmcs_tdo_i" %false : i1
    %dmi_select_o = llhd.sig %false : i1
    %dmi_tdo_i_5 = llhd.sig name "dmi_tdo_i" %false : i1
    %tap_state_q = llhd.sig %c0_i4 : i4
    %tap_state_d = llhd.sig %c0_i4 : i4
    %update_dr = llhd.sig %false : i1
    %shift_dr = llhd.sig %false : i1
    %capture_dr = llhd.sig %false : i1
    %jtag_ir_shift_d = llhd.sig %c0_i5 : i5
    %jtag_ir_shift_q = llhd.sig %c0_i5 : i5
    %jtag_ir_d = llhd.sig %c0_i5 : i5
    %jtag_ir_q = llhd.sig %c0_i5 : i5
    %capture_ir = llhd.sig %false : i1
    %shift_ir = llhd.sig %false : i1
    %update_ir = llhd.sig %false : i1
    %test_logic_reset = llhd.sig %false : i1
    %idcode_d = llhd.sig %c0_i32 : i32
    %idcode_q = llhd.sig %c0_i32 : i32
    %idcode_select = llhd.sig %false : i1
    %bypass_select = llhd.sig %false : i1
    %bypass_d = llhd.sig %false : i1
    %bypass_q = llhd.sig %false : i1
    %tdo_mux = llhd.sig %false : i1
    %tck_n = llhd.sig %false : i1
    %4 = llhd.prb %tck_n : i1
    %i_tck_inv.clk_no = hw.instance "i_tck_inv" @prim_clock_inv(clk_i: %2: i1, scanmode_i: %testmode_i: i1) -> (clk_no: i1)
    llhd.drv %tck_n, %i_tck_inv.clk_no after %1 : i1
    %5 = llhd.prb %jtag_ir_shift_q : i5
    %6 = llhd.prb %jtag_ir_shift_d : i5
    %7 = llhd.prb %jtag_ir_q : i5
    %8 = llhd.prb %jtag_ir_d : i5
    %9 = llhd.prb %shift_ir : i1
    %10 = llhd.prb %td_i_3 : i1
    %11 = llhd.prb %capture_ir : i1
    %12 = llhd.prb %update_ir : i1
    %13 = llhd.prb %test_logic_reset : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb9
      %33 = llhd.prb %jtag_ir_shift_q : i5
      llhd.drv %jtag_ir_shift_d, %33 after %1 : i5
      %34 = llhd.prb %jtag_ir_q : i5
      llhd.drv %jtag_ir_d, %34 after %1 : i5
      %35 = llhd.prb %shift_ir : i1
      cf.cond_br %35, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %36 = llhd.prb %td_i_3 : i1
      %37 = llhd.prb %jtag_ir_shift_q : i5
      %38 = comb.extract %37 from 1 : (i5) -> i4
      %39 = comb.concat %36, %38 : i1, i4
      llhd.drv %jtag_ir_shift_d, %39 after %1 : i5
      cf.br ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      %40 = llhd.prb %capture_ir : i1
      cf.cond_br %40, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %jtag_ir_shift_d, %c5_i5 after %1 : i5
      cf.br ^bb5
    ^bb5:  // 2 preds: ^bb3, ^bb4
      %41 = llhd.prb %update_ir : i1
      cf.cond_br %41, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %42 = llhd.prb %jtag_ir_shift_q : i5
      llhd.drv %jtag_ir_d, %42 after %1 : i5
      cf.br ^bb7
    ^bb7:  // 2 preds: ^bb5, ^bb6
      %43 = llhd.prb %test_logic_reset : i1
      cf.cond_br %43, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %jtag_ir_shift_d, %c0_i5 after %1 : i5
      llhd.drv %jtag_ir_d, %c1_i5 after %1 : i5
      cf.br ^bb9
    ^bb9:  // 2 preds: ^bb7, ^bb8
      llhd.wait (%5, %6, %7, %8, %9, %10, %11, %12, %13 : i5, i5, i5, i5, i1, i1, i1, i1, i1), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %33 = llhd.prb %tck_i_0 : i1
      %34 = llhd.prb %trst_ni_2 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %35 = llhd.prb %tck_i_0 : i1
      %36 = comb.xor bin %33, %true : i1
      %37 = comb.and bin %36, %35 : i1
      %38 = llhd.prb %trst_ni_2 : i1
      %39 = comb.xor bin %38, %true : i1
      %40 = comb.and bin %34, %39 : i1
      %41 = comb.or bin %37, %40 : i1
      cf.cond_br %41, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %42 = llhd.prb %trst_ni_2 : i1
      %43 = comb.xor %42, %true : i1
      cf.cond_br %43, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %jtag_ir_shift_q, %c0_i5 after %0 : i5
      llhd.drv %jtag_ir_q, %c1_i5 after %0 : i5
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %44 = llhd.prb %jtag_ir_shift_d : i5
      llhd.drv %jtag_ir_shift_q, %44 after %0 : i5
      %45 = llhd.prb %jtag_ir_d : i5
      llhd.drv %jtag_ir_q, %45 after %0 : i5
      cf.br ^bb1
    }
    %14 = llhd.prb %idcode_q : i32
    %15 = llhd.prb %idcode_d : i32
    %16 = llhd.prb %bypass_q : i1
    %17 = llhd.prb %bypass_d : i1
    %18 = llhd.prb %capture_dr : i1
    %19 = llhd.prb %idcode_select : i1
    %20 = llhd.prb %bypass_select : i1
    %21 = llhd.prb %shift_dr : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb13
      %33 = llhd.prb %idcode_q : i32
      llhd.drv %idcode_d, %33 after %1 : i32
      %34 = llhd.prb %bypass_q : i1
      llhd.drv %bypass_d, %34 after %1 : i1
      %35 = llhd.prb %capture_dr : i1
      cf.cond_br %35, ^bb2, ^bb6
    ^bb2:  // pred: ^bb1
      %36 = llhd.prb %idcode_select : i1
      cf.cond_br %36, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %idcode_d, %c1_i32 after %1 : i32
      cf.br ^bb4
    ^bb4:  // 2 preds: ^bb2, ^bb3
      %37 = llhd.prb %bypass_select : i1
      cf.cond_br %37, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      llhd.drv %bypass_d, %false after %1 : i1
      cf.br ^bb6
    ^bb6:  // 3 preds: ^bb1, ^bb4, ^bb5
      %38 = llhd.prb %shift_dr : i1
      cf.cond_br %38, ^bb7, ^bb11
    ^bb7:  // pred: ^bb6
      %39 = llhd.prb %idcode_select : i1
      cf.cond_br %39, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %40 = llhd.prb %td_i_3 : i1
      %41 = llhd.prb %idcode_q : i32
      %42 = comb.extract %41 from 1 : (i32) -> i31
      %43 = comb.concat %40, %42 : i1, i31
      llhd.drv %idcode_d, %43 after %1 : i32
      cf.br ^bb9
    ^bb9:  // 2 preds: ^bb7, ^bb8
      %44 = llhd.prb %bypass_select : i1
      cf.cond_br %44, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %45 = llhd.prb %td_i_3 : i1
      llhd.drv %bypass_d, %45 after %1 : i1
      cf.br ^bb11
    ^bb11:  // 3 preds: ^bb6, ^bb9, ^bb10
      %46 = llhd.prb %test_logic_reset : i1
      cf.cond_br %46, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      llhd.drv %idcode_d, %c1_i32 after %1 : i32
      llhd.drv %bypass_d, %false after %1 : i1
      cf.br ^bb13
    ^bb13:  // 2 preds: ^bb11, ^bb12
      llhd.wait (%14, %15, %16, %17, %18, %19, %20, %21, %10, %13 : i32, i32, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    %22 = llhd.prb %dmi_select_o : i1
    %23 = llhd.prb %dtmcs_select_o : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb12
      llhd.drv %dmi_select_o, %false after %1 : i1
      llhd.drv %dtmcs_select_o, %false after %1 : i1
      llhd.drv %idcode_select, %false after %1 : i1
      llhd.drv %bypass_select, %false after %1 : i1
      %33 = llhd.prb %jtag_ir_q : i5
      %34 = comb.icmp ceq %33, %c0_i5 : i5
      cf.cond_br %34, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      llhd.drv %bypass_select, %true after %1 : i1
      cf.br ^bb12
    ^bb3:  // pred: ^bb1
      %35 = comb.icmp ceq %33, %c1_i5 : i5
      cf.cond_br %35, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %idcode_select, %true after %1 : i1
      cf.br ^bb12
    ^bb5:  // pred: ^bb3
      %36 = comb.icmp ceq %33, %c-16_i5 : i5
      cf.cond_br %36, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %dtmcs_select_o, %true after %1 : i1
      cf.br ^bb12
    ^bb7:  // pred: ^bb5
      %37 = comb.icmp ceq %33, %c-15_i5 : i5
      cf.cond_br %37, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %dmi_select_o, %true after %1 : i1
      cf.br ^bb12
    ^bb9:  // pred: ^bb7
      %38 = comb.icmp ceq %33, %c-1_i5 : i5
      cf.cond_br %38, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      llhd.drv %bypass_select, %true after %1 : i1
      cf.br ^bb12
    ^bb11:  // pred: ^bb9
      llhd.drv %bypass_select, %true after %1 : i1
      cf.br ^bb12
    ^bb12:  // 6 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb11
      llhd.wait (%22, %23, %19, %20, %7 : i1, i1, i1, i1, i5), ^bb1
    }
    %24 = llhd.prb %tdo_mux : i1
    %25 = llhd.prb %dtmcs_tdo_i_4 : i1
    %26 = llhd.prb %dmi_tdo_i_5 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb10
      %33 = llhd.prb %shift_ir : i1
      cf.cond_br %33, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %34 = llhd.prb %jtag_ir_shift_q : i5
      %35 = comb.extract %34 from 0 : (i5) -> i1
      llhd.drv %tdo_mux, %35 after %1 : i1
      cf.br ^bb10
    ^bb3:  // pred: ^bb1
      %36 = llhd.prb %jtag_ir_q : i5
      %37 = comb.icmp ceq %36, %c1_i5 : i5
      cf.cond_br %37, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %38 = llhd.prb %idcode_q : i32
      %39 = comb.extract %38 from 0 : (i32) -> i1
      llhd.drv %tdo_mux, %39 after %1 : i1
      cf.br ^bb10
    ^bb5:  // pred: ^bb3
      %40 = comb.icmp ceq %36, %c-16_i5 : i5
      cf.cond_br %40, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %41 = llhd.prb %dtmcs_tdo_i_4 : i1
      llhd.drv %tdo_mux, %41 after %1 : i1
      cf.br ^bb10
    ^bb7:  // pred: ^bb5
      %42 = comb.icmp ceq %36, %c-15_i5 : i5
      cf.cond_br %42, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %43 = llhd.prb %dmi_tdo_i_5 : i1
      llhd.drv %tdo_mux, %43 after %1 : i1
      cf.br ^bb10
    ^bb9:  // pred: ^bb7
      %44 = llhd.prb %bypass_q : i1
      llhd.drv %tdo_mux, %44 after %1 : i1
      cf.br ^bb10
    ^bb10:  // 5 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb9
      llhd.wait (%9, %5, %24, %7, %14, %25, %26, %16 : i1, i5, i1, i5, i32, i1, i1, i1), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %33 = llhd.prb %tck_n : i1
      %34 = llhd.prb %trst_ni_2 : i1
      llhd.wait (%4, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %35 = llhd.prb %tck_n : i1
      %36 = comb.xor bin %33, %true : i1
      %37 = comb.and bin %36, %35 : i1
      %38 = llhd.prb %trst_ni_2 : i1
      %39 = comb.xor bin %38, %true : i1
      %40 = comb.and bin %34, %39 : i1
      %41 = comb.or bin %37, %40 : i1
      cf.cond_br %41, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %42 = llhd.prb %trst_ni_2 : i1
      %43 = comb.xor %42, %true : i1
      cf.cond_br %43, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %td_o, %false after %0 : i1
      llhd.drv %tdo_oe_o, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %44 = llhd.prb %tdo_mux : i1
      llhd.drv %td_o, %44 after %0 : i1
      %45 = llhd.prb %shift_ir : i1
      %46 = llhd.prb %shift_dr : i1
      %47 = comb.or %45, %46 : i1
      llhd.drv %tdo_oe_o, %47 after %0 : i1
      cf.br ^bb1
    }
    %27 = llhd.prb %update_dr : i1
    %28 = llhd.prb %tap_state_q : i4
    %29 = llhd.prb %tms_i_1 : i1
    %30 = llhd.prb %tap_state_d : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb32
      llhd.drv %test_logic_reset, %false after %1 : i1
      llhd.drv %capture_dr, %false after %1 : i1
      llhd.drv %shift_dr, %false after %1 : i1
      llhd.drv %update_dr, %false after %1 : i1
      llhd.drv %capture_ir, %false after %1 : i1
      llhd.drv %shift_ir, %false after %1 : i1
      llhd.drv %update_ir, %false after %1 : i1
      %33 = llhd.prb %tap_state_q : i4
      %34 = comb.icmp ceq %33, %c0_i4 : i4
      cf.cond_br %34, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %35 = llhd.prb %tms_i_1 : i1
      %36 = comb.xor %35, %true : i1
      %37 = comb.concat %c0_i3, %36 : i3, i1
      llhd.drv %tap_state_d, %37 after %1 : i4
      llhd.drv %test_logic_reset, %true after %1 : i1
      cf.br ^bb32
    ^bb3:  // pred: ^bb1
      %38 = comb.icmp ceq %33, %c1_i4 : i4
      cf.cond_br %38, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %39 = llhd.prb %tms_i_1 : i1
      %40 = comb.mux %39, %c2_i4, %c1_i4 : i4
      llhd.drv %tap_state_d, %40 after %1 : i4
      cf.br ^bb32
    ^bb5:  // pred: ^bb3
      %41 = comb.icmp ceq %33, %c2_i4 : i4
      cf.cond_br %41, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %42 = llhd.prb %tms_i_1 : i1
      %43 = comb.mux %42, %c-7_i4, %c3_i4 : i4
      llhd.drv %tap_state_d, %43 after %1 : i4
      cf.br ^bb32
    ^bb7:  // pred: ^bb5
      %44 = comb.icmp ceq %33, %c3_i4 : i4
      cf.cond_br %44, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %capture_dr, %true after %1 : i1
      %45 = llhd.prb %tms_i_1 : i1
      %46 = comb.concat %c2_i3, %45 : i3, i1
      llhd.drv %tap_state_d, %46 after %1 : i4
      cf.br ^bb32
    ^bb9:  // pred: ^bb7
      %47 = comb.icmp ceq %33, %c4_i4 : i4
      cf.cond_br %47, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      llhd.drv %shift_dr, %true after %1 : i1
      %48 = llhd.prb %tms_i_1 : i1
      %49 = comb.concat %c2_i3, %48 : i3, i1
      llhd.drv %tap_state_d, %49 after %1 : i4
      cf.br ^bb32
    ^bb11:  // pred: ^bb9
      %50 = comb.icmp ceq %33, %c5_i4 : i4
      cf.cond_br %50, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %51 = llhd.prb %tms_i_1 : i1
      %52 = comb.mux %51, %c-8_i4, %c6_i4 : i4
      llhd.drv %tap_state_d, %52 after %1 : i4
      cf.br ^bb32
    ^bb13:  // pred: ^bb11
      %53 = comb.icmp ceq %33, %c6_i4 : i4
      cf.cond_br %53, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %54 = llhd.prb %tms_i_1 : i1
      %55 = comb.concat %c3_i3, %54 : i3, i1
      llhd.drv %tap_state_d, %55 after %1 : i4
      cf.br ^bb32
    ^bb15:  // pred: ^bb13
      %56 = comb.icmp ceq %33, %c7_i4 : i4
      cf.cond_br %56, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      %57 = llhd.prb %tms_i_1 : i1
      %58 = comb.mux %57, %c-8_i4, %c4_i4 : i4
      llhd.drv %tap_state_d, %58 after %1 : i4
      cf.br ^bb32
    ^bb17:  // pred: ^bb15
      %59 = comb.icmp ceq %33, %c-8_i4 : i4
      cf.cond_br %59, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      llhd.drv %update_dr, %true after %1 : i1
      %60 = llhd.prb %tms_i_1 : i1
      %61 = comb.mux %60, %c2_i4, %c1_i4 : i4
      llhd.drv %tap_state_d, %61 after %1 : i4
      cf.br ^bb32
    ^bb19:  // pred: ^bb17
      %62 = comb.icmp ceq %33, %c-7_i4 : i4
      cf.cond_br %62, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      %63 = llhd.prb %tms_i_1 : i1
      %64 = comb.mux %63, %c0_i4, %c-6_i4 : i4
      llhd.drv %tap_state_d, %64 after %1 : i4
      cf.br ^bb32
    ^bb21:  // pred: ^bb19
      %65 = comb.icmp ceq %33, %c-6_i4 : i4
      cf.cond_br %65, ^bb22, ^bb23
    ^bb22:  // pred: ^bb21
      llhd.drv %capture_ir, %true after %1 : i1
      %66 = llhd.prb %tms_i_1 : i1
      %67 = comb.mux %66, %c-4_i4, %c-5_i4 : i4
      llhd.drv %tap_state_d, %67 after %1 : i4
      cf.br ^bb32
    ^bb23:  // pred: ^bb21
      %68 = comb.icmp ceq %33, %c-5_i4 : i4
      cf.cond_br %68, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      llhd.drv %shift_ir, %true after %1 : i1
      %69 = llhd.prb %tms_i_1 : i1
      %70 = comb.mux %69, %c-4_i4, %c-5_i4 : i4
      llhd.drv %tap_state_d, %70 after %1 : i4
      cf.br ^bb32
    ^bb25:  // pred: ^bb23
      %71 = comb.icmp ceq %33, %c-4_i4 : i4
      cf.cond_br %71, ^bb26, ^bb27
    ^bb26:  // pred: ^bb25
      %72 = llhd.prb %tms_i_1 : i1
      %73 = comb.concat %c-1_i2, %72, %true : i2, i1, i1
      llhd.drv %tap_state_d, %73 after %1 : i4
      cf.br ^bb32
    ^bb27:  // pred: ^bb25
      %74 = comb.icmp ceq %33, %c-3_i4 : i4
      cf.cond_br %74, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      %75 = llhd.prb %tms_i_1 : i1
      %76 = comb.mux %75, %c-2_i4, %c-3_i4 : i4
      llhd.drv %tap_state_d, %76 after %1 : i4
      cf.br ^bb32
    ^bb29:  // pred: ^bb27
      %77 = comb.icmp ceq %33, %c-2_i4 : i4
      cf.cond_br %77, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      %78 = llhd.prb %tms_i_1 : i1
      %79 = comb.concat %true, %78, %c-1_i2 : i1, i1, i2
      llhd.drv %tap_state_d, %79 after %1 : i4
      cf.br ^bb32
    ^bb31:  // pred: ^bb29
      llhd.drv %update_ir, %true after %1 : i1
      %80 = llhd.prb %tms_i_1 : i1
      %81 = comb.mux %80, %c2_i4, %c1_i4 : i4
      llhd.drv %tap_state_d, %81 after %1 : i4
      cf.br ^bb32
    ^bb32:  // 16 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb18, ^bb20, ^bb22, ^bb24, ^bb26, ^bb28, ^bb30, ^bb31
      llhd.wait (%13, %18, %21, %27, %11, %9, %12, %28, %29, %30 : i1, i1, i1, i1, i1, i1, i1, i4, i1, i4), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %33 = llhd.prb %tck_i_0 : i1
      %34 = llhd.prb %trst_ni_2 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %35 = llhd.prb %tck_i_0 : i1
      %36 = comb.xor bin %33, %true : i1
      %37 = comb.and bin %36, %35 : i1
      %38 = llhd.prb %trst_ni_2 : i1
      %39 = comb.xor bin %38, %true : i1
      %40 = comb.and bin %34, %39 : i1
      %41 = comb.or bin %37, %40 : i1
      cf.cond_br %41, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %42 = llhd.prb %trst_ni_2 : i1
      %43 = comb.xor %42, %true : i1
      cf.cond_br %43, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %tap_state_q, %c0_i4 after %0 : i4
      llhd.drv %idcode_q, %c1_i32 after %0 : i32
      llhd.drv %bypass_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %44 = llhd.prb %tap_state_d : i4
      llhd.drv %tap_state_q, %44 after %0 : i4
      %45 = llhd.prb %idcode_d : i32
      llhd.drv %idcode_q, %45 after %0 : i32
      %46 = llhd.prb %bypass_d : i1
      llhd.drv %bypass_q, %46 after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %tck_i_0, %tck_i after %1 : i1
    llhd.drv %tms_i_1, %tms_i after %1 : i1
    llhd.drv %trst_ni_2, %trst_ni after %1 : i1
    llhd.drv %td_i_3, %td_i after %1 : i1
    %31 = llhd.prb %td_o : i1
    %32 = llhd.prb %tdo_oe_o : i1
    llhd.drv %dtmcs_tdo_i_4, %dtmcs_tdo_i after %1 : i1
    llhd.drv %dmi_tdo_i_5, %dmi_tdo_i after %1 : i1
    hw.output %31, %32, %2, %13, %27, %18, %21, %10, %23, %22 : i1, i1, i1, i1, i1, i1, i1, i1, i1, i1
  }
  hw.module private @dmi_cdc(in %testmode_i : i1, in %test_rst_ni : i1, in %tck_i : i1, in %trst_ni : i1, in %jtag_dmi_req_i : !hw.struct<addr: i32, op: i2, data: i32>, out jtag_dmi_ready_o : i1, in %jtag_dmi_valid_i : i1, in %jtag_dmi_cdc_clear_i : i1, out jtag_dmi_resp_o : !hw.struct<data: i32, resp: i2>, out jtag_dmi_valid_o : i1, in %jtag_dmi_ready_i : i1, in %clk_i : i1, in %rst_ni : i1, out core_dmi_rst_no : i1, out core_dmi_req_o : !hw.struct<addr: i32, op: i2, data: i32>, out core_dmi_valid_o : i1, in %core_dmi_ready_i : i1, in %core_dmi_resp_i : !hw.struct<data: i32, resp: i2>, out core_dmi_ready_o : i1, in %core_dmi_valid_i : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %false = hw.constant false
    %tck_i_0 = llhd.sig name "tck_i" %false : i1
    %2 = llhd.prb %tck_i_0 : i1
    %trst_ni_1 = llhd.sig name "trst_ni" %false : i1
    %3 = llhd.prb %trst_ni_1 : i1
    %jtag_dmi_cdc_clear_i_2 = llhd.sig name "jtag_dmi_cdc_clear_i" %false : i1
    %jtag_combined_rstn = llhd.sig %false : i1
    %4 = llhd.prb %jtag_combined_rstn : i1
    %u_combined_rstn_sync.q_o = hw.instance "u_combined_rstn_sync" @prim_flop_2sync_1(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %4: i1) -> (q_o: i1) {sv.namehint = "combined_rstn_premux"}
    %u_rst_mux.clk_o = hw.instance "u_rst_mux" @prim_clock_mux2(clk0_i: %u_combined_rstn_sync.q_o: i1, clk1_i: %test_rst_ni: i1, sel_i: %testmode_i: i1) -> (clk_o: i1) {sv.namehint = "combined_rstn"}
    %5 = hw.bitcast %jtag_dmi_req_i : (!hw.struct<addr: i32, op: i2, data: i32>) -> i66
    %i_cdc_req.wready_o, %i_cdc_req.rvalid_o, %i_cdc_req.rdata_o = hw.instance "i_cdc_req" @prim_fifo_async_simple(clk_wr_i: %2: i1, rst_wr_ni: %3: i1, wvalid_i: %jtag_dmi_valid_i: i1, wdata_i: %5: i66, clk_rd_i: %clk_i: i1, rst_rd_ni: %u_rst_mux.clk_o: i1, rready_i: %core_dmi_ready_i: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i66)
    %6 = hw.bitcast %i_cdc_req.rdata_o : (i66) -> !hw.struct<addr: i32, op: i2, data: i32>
    %7 = hw.bitcast %core_dmi_resp_i : (!hw.struct<data: i32, resp: i2>) -> i34
    %i_cdc_resp.wready_o, %i_cdc_resp.rvalid_o, %i_cdc_resp.rdata_o = hw.instance "i_cdc_resp" @prim_fifo_async_simple_21(clk_wr_i: %clk_i: i1, rst_wr_ni: %u_rst_mux.clk_o: i1, wvalid_i: %core_dmi_valid_i: i1, wdata_i: %7: i34, clk_rd_i: %2: i1, rst_rd_ni: %3: i1, rready_i: %jtag_dmi_ready_i: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i34)
    %8 = hw.bitcast %i_cdc_resp.rdata_o : (i34) -> !hw.struct<data: i32, resp: i2>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %9 = llhd.prb %tck_i_0 : i1
      %10 = llhd.prb %trst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %11 = llhd.prb %tck_i_0 : i1
      %12 = comb.xor bin %9, %true : i1
      %13 = comb.and bin %12, %11 : i1
      %14 = llhd.prb %trst_ni_1 : i1
      %15 = comb.xor bin %14, %true : i1
      %16 = comb.and bin %10, %15 : i1
      %17 = comb.or bin %13, %16 : i1
      cf.cond_br %17, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %18 = llhd.prb %trst_ni_1 : i1
      %19 = comb.xor %18, %true : i1
      cf.cond_br %19, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %jtag_combined_rstn, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %20 = llhd.prb %jtag_dmi_cdc_clear_i_2 : i1
      cf.cond_br %20, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %jtag_combined_rstn, %false after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      llhd.drv %jtag_combined_rstn, %true after %1 : i1
      cf.br ^bb1
    }
    llhd.drv %tck_i_0, %tck_i after %0 : i1
    llhd.drv %trst_ni_1, %trst_ni after %0 : i1
    llhd.drv %jtag_dmi_cdc_clear_i_2, %jtag_dmi_cdc_clear_i after %0 : i1
    hw.output %i_cdc_req.wready_o, %8, %i_cdc_resp.rvalid_o, %u_rst_mux.clk_o, %6, %i_cdc_req.rvalid_o, %i_cdc_resp.wready_o : i1, !hw.struct<data: i32, resp: i2>, i1, i1, !hw.struct<addr: i32, op: i2, data: i32>, i1, i1
  }
  hw.module private @debug_rom(in %clk_i : i1, in %rst_ni : i1, in %req_i : i1, in %addr_i : i64, out rdata_o : i64) {
    %0 = hw.aggregate_constant [8872091761906820211, 8876636041675876387, -1062809432907321233, 8872131344326468979, 1154368612233904243, 8872131344326468979, 1154377408338793747, 55544110504740119, -189168295599662877, 10260725188805635, 46166517317903475, 145272299511378963, 4612886698020570163, 1190393015252821107, 55473741773493523, 5598409461875, 8873235252201390095, 81688264815, 81742790767, 81629544559] : !hw.array<20xi64>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %2 = llhd.constant_time <0ns, 0d, 1e>
    %3 = hw.aggregate_constant [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : !hw.array<20xi64>
    %c-12_i5 = hw.constant -12 : i5
    %c0_i64 = hw.constant 0 : i64
    %c0_i5 = hw.constant 0 : i5
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %4 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %5 = llhd.prb %rst_ni_1 : i1
    %addr_i_2 = llhd.sig name "addr_i" %c0_i64 : i64
    %rdata_o = llhd.sig %c0_i64 : i64
    %mem = llhd.sig %3 : !hw.array<20xi64>
    %addr_d = llhd.sig %c0_i5 : i5
    %addr_q = llhd.sig %c0_i5 : i5
    llhd.drv %mem, %0 after %2 : !hw.array<20xi64>
    %6 = llhd.prb %addr_i_2 : i64
    %7 = comb.extract %6 from 3 : (i64) -> i5
    %8 = llhd.prb %addr_q : i5
    %9 = comb.mux %req_i, %7, %8 : i5
    llhd.drv %addr_d, %9 after %2 : i5
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %12 = llhd.prb %clk_i_0 : i1
      %13 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %14 = llhd.prb %clk_i_0 : i1
      %15 = comb.xor bin %12, %true : i1
      %16 = comb.and bin %15, %14 : i1
      %17 = llhd.prb %rst_ni_1 : i1
      %18 = comb.xor bin %17, %true : i1
      %19 = comb.and bin %13, %18 : i1
      %20 = comb.or bin %16, %19 : i1
      cf.cond_br %20, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %21 = llhd.prb %rst_ni_1 : i1
      %22 = comb.xor %21, %true : i1
      cf.cond_br %22, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %addr_q, %c0_i5 after %1 : i5
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %23 = llhd.prb %addr_d : i5
      llhd.drv %addr_q, %23 after %1 : i5
      cf.br ^bb1
    }
    %10 = llhd.prb %rdata_o : i64
    %11 = llhd.prb %mem : !hw.array<20xi64>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb3
      llhd.drv %rdata_o, %c0_i64 after %2 : i64
      %12 = llhd.prb %addr_q : i5
      %13 = comb.icmp ult %12, %c-12_i5 : i5
      cf.cond_br %13, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %14 = llhd.prb %mem : !hw.array<20xi64>
      %15 = llhd.prb %addr_q : i5
      %16 = hw.array_get %14[%15] : !hw.array<20xi64>, i5
      llhd.drv %rdata_o, %16 after %2 : i64
      cf.br ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      llhd.wait (%10, %8, %11 : i64, i5, !hw.array<20xi64>), ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %2 : i1
    llhd.drv %rst_ni_1, %rst_ni after %2 : i1
    llhd.drv %addr_i_2, %addr_i after %2 : i64
    hw.output %10 : i64
  }
  hw.module private @tlul_lc_gate(in %clk_i : i1, in %rst_ni : i1, in %tl_h2d_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_d2h_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_h2d_o : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, in %tl_d2h_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %flush_req_i : i1, out flush_ack_o : i1, out resp_pending_o : i1, in %lc_en_i : i4, out err_o : i1) {
    %c-1_i2 = hw.constant -1 : i2
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c-2_i2 = hw.constant -2 : i2
    %c0_i9 = hw.constant 0 : i9
    %2 = hw.aggregate_constant [[false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false], [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false], [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false]] : !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %3 = hw.aggregate_constant [[false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false], [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false], [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false]] : !hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %c0_i4 = hw.constant 0 : i4
    %4 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %5 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %c-234_i9 = hw.constant -234 : i9
    %c5_i4 = hw.constant 5 : i4
    %c76_i9 = hw.constant 76 : i9
    %c186_i9 = hw.constant 186 : i9
    %true = hw.constant true
    %c231_i9 = hw.constant 231 : i9
    %c-223_i9 = hw.constant -223 : i9
    %c-6_i4 = hw.constant -6 : i4
    %false = hw.constant false
    %c1_i2 = hw.constant 1 : i2
    %c0_i2 = hw.constant 0 : i2
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %6 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %7 = llhd.prb %rst_ni_1 : i1
    %tl_h2d_i_2 = llhd.sig name "tl_h2d_i" %5 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %tl_d2h_o = llhd.sig %4 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %flush_req_i_3 = llhd.sig name "flush_req_i" %false : i1
    %flush_ack_o = llhd.sig %false : i1
    %resp_pending_o = llhd.sig %false : i1
    %lc_en_i_4 = llhd.sig name "lc_en_i" %c0_i4 : i4
    %err_o = llhd.sig %false : i1
    %err_en = llhd.sig %c0_i4 : i4
    %tl_h2d_int = llhd.sig %3 : !hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %tl_d2h_int = llhd.sig %2 : !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %state_d = llhd.sig %c0_i9 : i9
    %state_q = llhd.sig %c0_i9 : i9
    %outstanding_txn = llhd.sig %c0_i2 : i2
    %a_ack = llhd.sig %false : i1
    %d_ack = llhd.sig %false : i1
    %block_cmd = llhd.sig %false : i1
    %tl_h2d_error = llhd.sig %5 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %tl_d2h_error = llhd.sig %4 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %8 = llhd.prb %err_en : i4
    %u_err_en_sync.lc_en_o = hw.instance "u_err_en_sync" @prim_lc_sync_9(clk_i: %6: i1, rst_ni: %7: i1, lc_en_i: %8: i4) -> (lc_en_o: !hw.array<2xi4>) {sv.namehint = "err_en_buf"}
    %9 = llhd.prb %tl_h2d_int : !hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %10 = hw.array_get %9[%c-2_i2] : !hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>, i2
    %11 = hw.array_get %u_err_en_sync.lc_en_o[%false] : !hw.array<2xi4>, i1
    %12 = func.call @"lc_ctrl_pkg::lc_tx_test_false_strict"(%11) : (i4) -> i1
    %13 = llhd.sig.array_get %tl_h2d_int[%c1_i2] : <!hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>>
    %14 = hw.bitcast %10 : (!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> i109
    %gen_lc_gating_muxes_0.u_prim_blanker_h2d.out_o = hw.instance "gen_lc_gating_muxes_0.u_prim_blanker_h2d" @prim_blanker(in_i: %14: i109, en_i: %12: i1) -> (out_o: i109)
    %15 = hw.bitcast %gen_lc_gating_muxes_0.u_prim_blanker_h2d.out_o : (i109) -> !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    llhd.drv %13, %15 after %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %16 = llhd.prb %tl_d2h_int : !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %17 = hw.array_get %16[%c1_i2] : !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, i2
    %18 = func.call @"lc_ctrl_pkg::lc_tx_test_false_strict"(%11) : (i4) -> i1
    %19 = llhd.sig.array_get %tl_d2h_int[%c-2_i2] : <!hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>>
    %20 = hw.bitcast %17 : (!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> i66
    %gen_lc_gating_muxes_0.u_prim_blanker_d2h.out_o = hw.instance "gen_lc_gating_muxes_0.u_prim_blanker_d2h" @prim_blanker_10(in_i: %20: i66, en_i: %18: i1) -> (out_o: i66)
    %21 = hw.bitcast %gen_lc_gating_muxes_0.u_prim_blanker_d2h.out_o : (i66) -> !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %19, %21 after %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %22 = hw.array_get %9[%c1_i2] : !hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>, i2
    %23 = hw.array_get %u_err_en_sync.lc_en_o[%true] : !hw.array<2xi4>, i1
    %24 = func.call @"lc_ctrl_pkg::lc_tx_test_false_strict"(%23) : (i4) -> i1
    %25 = llhd.sig.array_get %tl_h2d_int[%c0_i2] : <!hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>>
    %26 = hw.bitcast %22 : (!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> i109
    %gen_lc_gating_muxes_1.u_prim_blanker_h2d.out_o = hw.instance "gen_lc_gating_muxes_1.u_prim_blanker_h2d" @prim_blanker(in_i: %26: i109, en_i: %24: i1) -> (out_o: i109)
    %27 = hw.bitcast %gen_lc_gating_muxes_1.u_prim_blanker_h2d.out_o : (i109) -> !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    llhd.drv %25, %27 after %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %28 = hw.array_get %16[%c0_i2] : !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, i2
    %29 = func.call @"lc_ctrl_pkg::lc_tx_test_false_strict"(%23) : (i4) -> i1
    %30 = llhd.sig.array_get %tl_d2h_int[%c1_i2] : <!hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>>
    %31 = hw.bitcast %28 : (!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> i66
    %gen_lc_gating_muxes_1.u_prim_blanker_d2h.out_o = hw.instance "gen_lc_gating_muxes_1.u_prim_blanker_d2h" @prim_blanker_10(in_i: %31: i66, en_i: %29: i1) -> (out_o: i66)
    %32 = hw.bitcast %gen_lc_gating_muxes_1.u_prim_blanker_d2h.out_o : (i66) -> !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %30, %32 after %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %33 = llhd.prb %state_d : i9
    %u_state_regs.state_o = hw.instance "u_state_regs" @prim_sparse_fsm_flop(clk_i: %6: i1, rst_ni: %7: i1, state_i: %33: i9) -> (state_o: i9)
    llhd.drv %state_q, %u_state_regs.state_o after %1 : i9
    %34 = llhd.prb %tl_h2d_error : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %u_tlul_err_resp.tl_h_o = hw.instance "u_tlul_err_resp" @tlul_err_resp(clk_i: %6: i1, rst_ni: %7: i1, tl_h_i: %34: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> (tl_h_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
    llhd.drv %tl_d2h_error, %u_tlul_err_resp.tl_h_o after %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %35 = hw.array_get %9[%c0_i2] : !hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>, i2
    %36 = llhd.sig.array_get %tl_d2h_int[%c0_i2] : <!hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>>
    llhd.drv %36, %tl_d2h_i after %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %37 = llhd.prb %tl_h2d_i_2 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_valid = hw.struct_extract %37["a_valid"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %38 = llhd.prb %tl_d2h_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %a_ready = hw.struct_extract %38["a_ready"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %39 = comb.and %a_valid, %a_ready : i1
    llhd.drv %a_ack, %39 after %1 : i1
    %d_ready = hw.struct_extract %37["d_ready"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %d_valid = hw.struct_extract %38["d_valid"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %40 = comb.and %d_ready, %d_valid : i1
    llhd.drv %d_ack, %40 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %50 = llhd.prb %clk_i_0 : i1
      %51 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%6, %7 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %52 = llhd.prb %clk_i_0 : i1
      %53 = comb.xor bin %50, %true : i1
      %54 = comb.and bin %53, %52 : i1
      %55 = llhd.prb %rst_ni_1 : i1
      %56 = comb.xor bin %55, %true : i1
      %57 = comb.and bin %51, %56 : i1
      %58 = comb.or bin %54, %57 : i1
      cf.cond_br %58, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %59 = llhd.prb %rst_ni_1 : i1
      %60 = comb.xor %59, %true : i1
      cf.cond_br %60, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %outstanding_txn, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %61 = llhd.prb %a_ack : i1
      %62 = llhd.prb %d_ack : i1
      %63 = comb.xor %62, %true : i1
      %64 = comb.and %61, %63 : i1
      cf.cond_br %64, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %65 = llhd.prb %outstanding_txn : i2
      %66 = comb.add %65, %c1_i2 : i2
      llhd.drv %outstanding_txn, %66 after %0 : i2
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %67 = llhd.prb %d_ack : i1
      %68 = llhd.prb %a_ack : i1
      %69 = comb.xor %68, %true : i1
      %70 = comb.and %67, %69 : i1
      cf.cond_br %70, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %71 = llhd.prb %outstanding_txn : i2
      %72 = comb.add %71, %c-1_i2 : i2
      llhd.drv %outstanding_txn, %72 after %0 : i2
      cf.br ^bb1
    }
    %41 = llhd.prb %block_cmd : i1
    %42 = llhd.prb %state_q : i9
    %43 = llhd.prb %err_o : i1
    %44 = llhd.prb %flush_ack_o : i1
    %45 = llhd.prb %resp_pending_o : i1
    %46 = llhd.prb %lc_en_i_4 : i4
    %47 = llhd.prb %flush_req_i_3 : i1
    %48 = llhd.prb %outstanding_txn : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb22
      llhd.drv %block_cmd, %false after %1 : i1
      %50 = llhd.prb %state_q : i9
      llhd.drv %state_d, %50 after %1 : i9
      llhd.drv %err_en, %c-6_i4 after %1 : i4
      llhd.drv %err_o, %false after %1 : i1
      llhd.drv %flush_ack_o, %false after %1 : i1
      llhd.drv %resp_pending_o, %false after %1 : i1
      %51 = llhd.prb %state_q : i9
      %52 = comb.icmp ceq %51, %c-223_i9 : i9
      cf.cond_br %52, ^bb2, ^bb6
    ^bb2:  // pred: ^bb1
      %53 = llhd.prb %lc_en_i_4 : i4
      %54 = func.call @"lc_ctrl_pkg::lc_tx_test_false_loose"(%53) : (i4) -> i1
      %55 = llhd.prb %flush_req_i_3 : i1
      %56 = comb.or %54, %55 : i1
      cf.cond_br %56, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %state_d, %c231_i9 after %1 : i9
      cf.br ^bb4
    ^bb4:  // 2 preds: ^bb2, ^bb3
      %57 = llhd.prb %outstanding_txn : i2
      %58 = comb.icmp ne %57, %c0_i2 : i2
      cf.cond_br %58, ^bb5, ^bb22
    ^bb5:  // pred: ^bb4
      llhd.drv %resp_pending_o, %true after %1 : i1
      cf.br ^bb22
    ^bb6:  // pred: ^bb1
      %59 = comb.icmp ceq %51, %c231_i9 : i9
      cf.cond_br %59, ^bb7, ^bb10
    ^bb7:  // pred: ^bb6
      llhd.drv %block_cmd, %true after %1 : i1
      %60 = llhd.prb %outstanding_txn : i2
      %61 = comb.icmp eq %60, %c0_i2 : i2
      cf.cond_br %61, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %62 = llhd.prb %lc_en_i_4 : i4
      %63 = func.call @"lc_ctrl_pkg::lc_tx_test_false_loose"(%62) : (i4) -> i1
      %64 = comb.mux %63, %c186_i9, %c76_i9 : i9
      llhd.drv %state_d, %64 after %1 : i9
      cf.br ^bb22
    ^bb9:  // pred: ^bb7
      llhd.drv %resp_pending_o, %true after %1 : i1
      cf.br ^bb22
    ^bb10:  // pred: ^bb6
      %65 = comb.icmp ceq %51, %c76_i9 : i9
      cf.cond_br %65, ^bb11, ^bb15
    ^bb11:  // pred: ^bb10
      llhd.drv %block_cmd, %true after %1 : i1
      llhd.drv %flush_ack_o, %true after %1 : i1
      %66 = llhd.prb %lc_en_i_4 : i4
      %67 = func.call @"lc_ctrl_pkg::lc_tx_test_false_loose"(%66) : (i4) -> i1
      cf.cond_br %67, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      llhd.drv %state_d, %c186_i9 after %1 : i9
      cf.br ^bb22
    ^bb13:  // pred: ^bb11
      %68 = llhd.prb %flush_req_i_3 : i1
      %69 = comb.xor %68, %true : i1
      cf.cond_br %69, ^bb14, ^bb22
    ^bb14:  // pred: ^bb13
      llhd.drv %state_d, %c-223_i9 after %1 : i9
      cf.br ^bb22
    ^bb15:  // pred: ^bb10
      %70 = comb.icmp ceq %51, %c186_i9 : i9
      cf.cond_br %70, ^bb16, ^bb18
    ^bb16:  // pred: ^bb15
      llhd.drv %err_en, %c5_i4 after %1 : i4
      %71 = llhd.prb %lc_en_i_4 : i4
      %72 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%71) : (i4) -> i1
      cf.cond_br %72, ^bb17, ^bb22
    ^bb17:  // pred: ^bb16
      llhd.drv %state_d, %c-234_i9 after %1 : i9
      cf.br ^bb22
    ^bb18:  // pred: ^bb15
      %73 = comb.icmp ceq %51, %c-234_i9 : i9
      cf.cond_br %73, ^bb19, ^bb21
    ^bb19:  // pred: ^bb18
      llhd.drv %err_en, %c5_i4 after %1 : i4
      llhd.drv %block_cmd, %true after %1 : i1
      %74 = llhd.prb %outstanding_txn : i2
      %75 = comb.icmp eq %74, %c0_i2 : i2
      cf.cond_br %75, ^bb20, ^bb22
    ^bb20:  // pred: ^bb19
      llhd.drv %state_d, %c-223_i9 after %1 : i9
      cf.br ^bb22
    ^bb21:  // pred: ^bb18
      llhd.drv %err_o, %true after %1 : i1
      llhd.drv %err_en, %c5_i4 after %1 : i4
      cf.br ^bb22
    ^bb22:  // 12 preds: ^bb4, ^bb5, ^bb8, ^bb9, ^bb12, ^bb13, ^bb14, ^bb16, ^bb17, ^bb19, ^bb20, ^bb21
      llhd.wait (%41, %42, %33, %8, %43, %44, %45, %46, %47, %48 : i1, i9, i9, i4, i1, i1, i1, i4, i1, i2), ^bb1
    }
    %49 = llhd.prb %tl_d2h_error : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb5
      %50 = llhd.sig.array_get %tl_h2d_int[%c-2_i2] : <!hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>>
      %51 = llhd.prb %tl_h2d_i_2 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      llhd.drv %50, %51 after %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %52 = llhd.prb %tl_d2h_int : !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
      %53 = hw.array_get %52[%c-2_i2] : !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, i2
      llhd.drv %tl_d2h_o, %53 after %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      llhd.drv %tl_h2d_error, %5 after %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %54 = llhd.prb %err_en : i4
      %55 = func.call @"lc_ctrl_pkg::lc_tx_test_true_loose"(%54) : (i4) -> i1
      cf.cond_br %55, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %56 = llhd.prb %tl_h2d_i_2 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      llhd.drv %tl_h2d_error, %56 after %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %57 = llhd.prb %tl_d2h_error : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      llhd.drv %tl_d2h_o, %57 after %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      cf.br ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      %58 = llhd.prb %block_cmd : i1
      cf.cond_br %58, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %59 = llhd.sig.struct_extract %tl_d2h_o["a_ready"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
      llhd.drv %59, %false after %1 : i1
      %60 = llhd.sig.struct_extract %50["a_valid"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
      llhd.drv %60, %false after %1 : i1
      %61 = llhd.sig.struct_extract %tl_h2d_error["a_valid"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
      llhd.drv %61, %false after %1 : i1
      cf.br ^bb5
    ^bb5:  // 2 preds: ^bb3, ^bb4
      llhd.wait (%9, %37, %16, %38, %34, %8, %49, %41 : !hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>, !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, i4, !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, i1), ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %tl_h2d_i_2, %tl_h2d_i after %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    llhd.drv %flush_req_i_3, %flush_req_i after %1 : i1
    llhd.drv %lc_en_i_4, %lc_en_i after %1 : i4
    hw.output %38, %35, %44, %45, %43 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, i1, i1, i1
  }
  hw.module private @rv_dm_regs_reg_top(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out reg2hw : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, late_debug_enable: !hw.struct<q: i32>>, in %racl_policies_i : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, out racl_error_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, out intg_err_o : i1) {
    %c-1_i4 = hw.constant -1 : i4
    %c0_i5 = hw.constant 0 : i5
    %c0_i28 = hw.constant 0 : i28
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [false, false, false, false, false, 0 : i32] : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %3 = hw.aggregate_constant [[0 : i2, 0 : i2]] : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    %4 = hw.aggregate_constant [[false, false], [0 : i32]] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, late_debug_enable: !hw.struct<q: i32>>
    %c-1_i32 = hw.constant -1 : i32
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false {sv.namehint = "racl_role"}
    %c-8_i4 = hw.constant -8 : i4
    %c4_i4 = hw.constant 4 : i4
    %c0_i4 = hw.constant 0 : i4
    %c0_i3 = hw.constant 0 : i3
    %c0_i2 = hw.constant 0 : i2
    %true = hw.constant true
    %c-7_i4 = hw.constant -7 : i4
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %5 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %6 = llhd.prb %rst_ni_1 : i1
    %reg2hw = llhd.sig %4 : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, late_debug_enable: !hw.struct<q: i32>>
    %racl_policies_i_2 = llhd.sig name "racl_policies_i" %3 : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    %racl_error_o = llhd.sig %2 : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %reg_we = llhd.sig %false : i1
    %reg_addr = llhd.sig %c0_i4 : i4
    %reg_be = llhd.sig %c0_i4 : i4
    %wr_err = llhd.sig %false : i1
    %reg_rdata_next = llhd.sig %c0_i32 : i32
    %intg_err = llhd.sig %false : i1
    %reg_we_err = llhd.sig %false : i1
    %reg_we_check = llhd.sig %c0_i3 : i3
    %err_q = llhd.sig %false : i1
    %alert_test_we = llhd.sig %false : i1
    %late_debug_enable_regwen_we = llhd.sig %false : i1
    %late_debug_enable_regwen_qs = llhd.sig %false : i1
    %late_debug_enable_qs = llhd.sig %c0_i32 : i32
    %alert_test_flds_we = llhd.sig %false : i1
    %late_debug_enable_gated_we = llhd.sig %false : i1
    %addr_hit = llhd.sig %c0_i3 : i3
    %racl_role_vec = llhd.sig %c0_i2 : i2
    %racl_addr_hit_read = llhd.sig %c0_i3 : i3
    %racl_addr_hit_write = llhd.sig %c0_i3 : i3
    %u_chk.err_o = hw.instance "u_chk" @tlul_cmd_intg_chk(tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> (err_o: i1)
    llhd.drv %intg_err, %u_chk.err_o after %1 : i1
    %7 = llhd.prb %reg_we_check : i3
    %8 = llhd.prb %reg_we : i1
    %9 = comb.xor %39, %true : i1
    %10 = comb.and %8, %9 : i1
    %u_prim_reg_we_check.err_o = hw.instance "u_prim_reg_we_check" @prim_reg_we_check(clk_i: %5: i1, rst_ni: %6: i1, oh_i: %7: i3, en_i: %10: i1) -> (err_o: i1)
    llhd.drv %reg_we_err, %u_prim_reg_we_check.err_o after %1 : i1
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen(tl_i: %u_reg_if.tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
    %11 = llhd.prb %racl_error_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %u_reg_if.tl_o, %u_reg_if.intg_error_o, %u_reg_if.re_o, %u_reg_if.we_o, %u_reg_if.addr_o, %u_reg_if.wdata_o, %u_reg_if.be_o = hw.instance "u_reg_if" @tlul_adapter_reg_3(clk_i: %5: i1, rst_ni: %6: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, en_ifetch_i: %c-7_i4: i4, busy_i: %false: i1, rdata_i: %23: i32, error_i: %25: i1) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, intg_error_o: i1, re_o: i1, we_o: i1, addr_o: i4, wdata_o: i32, be_o: i4) {sv.namehint = "reg_re"}
    llhd.drv %reg_we, %u_reg_if.we_o after %1 : i1
    llhd.drv %reg_addr, %u_reg_if.addr_o after %1 : i4
    llhd.drv %reg_be, %u_reg_if.be_o after %1 : i4
    %12 = llhd.prb %alert_test_we : i1
    %13 = llhd.sig.struct_extract %reg2hw["alert_test"] : <!hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, late_debug_enable: !hw.struct<q: i32>>>
    %14 = llhd.sig.struct_extract %13["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_alert_test.qe, %u_alert_test.qre, %u_alert_test.q, %u_alert_test.ds, %u_alert_test.qs = hw.instance "u_alert_test" @prim_subreg_ext(re: %false: i1, we: %12: i1, wd: %57: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %alert_test_flds_we, %u_alert_test.qe after %1 : i1
    llhd.drv %14, %u_alert_test.q after %1 : i1
    %15 = llhd.prb %late_debug_enable_regwen_we : i1
    %u_late_debug_enable_regwen.qe, %u_late_debug_enable_regwen.q, %u_late_debug_enable_regwen.ds, %u_late_debug_enable_regwen.qs = hw.instance "u_late_debug_enable_regwen" @prim_subreg(clk_i: %5: i1, rst_ni: %6: i1, we: %15: i1, wd: %57: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %late_debug_enable_regwen_qs, %u_late_debug_enable_regwen.qs after %1 : i1
    %16 = llhd.prb %late_debug_enable_gated_we : i1
    %17 = llhd.sig.struct_extract %reg2hw["late_debug_enable"] : <!hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, late_debug_enable: !hw.struct<q: i32>>>
    %18 = llhd.sig.struct_extract %17["q"] : <!hw.struct<q: i32>>
    %u_late_debug_enable.qe, %u_late_debug_enable.q, %u_late_debug_enable.ds, %u_late_debug_enable.qs = hw.instance "u_late_debug_enable" @prim_subreg_4(clk_i: %5: i1, rst_ni: %6: i1, we: %16: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %18, %u_late_debug_enable.q after %1 : i32
    llhd.drv %late_debug_enable_qs, %u_late_debug_enable.qs after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %63 = llhd.prb %clk_i_0 : i1
      %64 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%5, %6 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %65 = llhd.prb %clk_i_0 : i1
      %66 = comb.xor bin %63, %true : i1
      %67 = comb.and bin %66, %65 : i1
      %68 = llhd.prb %rst_ni_1 : i1
      %69 = comb.xor bin %68, %true : i1
      %70 = comb.and bin %64, %69 : i1
      %71 = comb.or bin %67, %70 : i1
      cf.cond_br %71, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %72 = llhd.prb %rst_ni_1 : i1
      %73 = comb.xor %72, %true : i1
      cf.cond_br %73, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %err_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %74 = llhd.prb %intg_err : i1
      %75 = llhd.prb %reg_we_err : i1
      %76 = comb.or %74, %75 : i1
      cf.cond_br %76, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %err_q, %true after %0 : i1
      cf.br ^bb1
    }
    %19 = llhd.prb %err_q : i1
    %20 = llhd.prb %intg_err : i1
    %21 = llhd.prb %reg_we_err : i1
    %22 = comb.or %19, %20, %21 : i1
    %23 = llhd.prb %reg_rdata_next {sv.namehint = "reg_rdata"} : i32
    %24 = llhd.prb %wr_err : i1
    %25 = comb.or %39, %24, %20 {sv.namehint = "reg_error"} : i1
    %26 = llhd.prb %alert_test_flds_we {sv.namehint = "alert_test_qe"} : i1
    %27 = llhd.sig.struct_extract %13["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %27, %26 after %1 : i1
    %28 = llhd.prb %late_debug_enable_regwen_qs : i1
    %29 = comb.and %60, %8, %55, %28 : i1
    llhd.drv %late_debug_enable_gated_we, %29 after %1 : i1
    llhd.drv %racl_role_vec, %c0_i2 after %1 : i2
    %30 = llhd.prb %racl_addr_hit_read : i3
    %31 = llhd.prb %racl_addr_hit_write : i3
    %32 = llhd.prb %addr_hit : i3
    %33 = llhd.prb %reg_addr : i4
    %34 = llhd.prb %racl_policies_i_2 : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    %35 = llhd.prb %racl_role_vec : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %racl_addr_hit_read, %c0_i3 after %1 : i3
      llhd.drv %racl_addr_hit_write, %c0_i3 after %1 : i3
      %63 = llhd.sig.extract %addr_hit from %c0_i2 : <i3> -> <i1>
      %64 = llhd.prb %reg_addr : i4
      %65 = comb.icmp eq %64, %c0_i4 : i4
      llhd.drv %63, %65 after %1 : i1
      %66 = llhd.sig.extract %addr_hit from %c1_i2 : <i3> -> <i1>
      %67 = llhd.prb %reg_addr : i4
      %68 = comb.icmp eq %67, %c4_i4 : i4
      llhd.drv %66, %68 after %1 : i1
      %69 = llhd.sig.extract %addr_hit from %c-2_i2 : <i3> -> <i1>
      %70 = llhd.prb %reg_addr : i4
      %71 = comb.icmp eq %70, %c-8_i4 : i4
      llhd.drv %69, %71 after %1 : i1
      %72 = llhd.prb %addr_hit : i3
      llhd.drv %racl_addr_hit_read, %72 after %1 : i3
      %73 = llhd.prb %addr_hit : i3
      llhd.drv %racl_addr_hit_write, %73 after %1 : i3
      llhd.wait (%30, %31, %32, %33, %34, %35 : i3, i3, i3, i4, !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, i2), ^bb1
    }
    %36 = comb.or %u_reg_if.re_o, %8 : i1
    %37 = comb.icmp ne %32, %c0_i3 : i3
    %38 = comb.xor %37, %true : i1
    %39 = comb.and %36, %38 {sv.namehint = "addrmiss"} : i1
    %40 = llhd.sig.struct_extract %racl_error_o["valid"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    %41 = comb.icmp eq %30, %c0_i3 : i3
    %42 = comb.and %u_reg_if.re_o, %41 : i1
    %43 = comb.icmp eq %31, %c0_i3 : i3
    %44 = comb.and %8, %43 : i1
    %45 = comb.or %42, %44 : i1
    %46 = comb.and %37, %45 : i1
    llhd.drv %40, %46 after %1 : i1
    %47 = llhd.sig.struct_extract %racl_error_o["request_address"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    %48 = comb.concat %c0_i28, %33 : i28, i4
    llhd.drv %47, %48 after %1 : i32
    %49 = llhd.sig.struct_extract %racl_error_o["racl_role"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %49, %false after %1 : i1
    %50 = llhd.sig.struct_extract %racl_error_o["overflow"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %50, %false after %1 : i1
    %51 = llhd.sig.struct_extract %racl_error_o["ctn_uid"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %51, %false after %1 : i1
    %52 = llhd.sig.struct_extract %racl_error_o["read_access"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %52, %false after %1 : i1
    %53 = llhd.prb %reg_be : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %63 = llhd.prb %reg_we : i1
      %64 = llhd.prb %racl_addr_hit_write : i3
      %65 = comb.extract %64 from 0 : (i3) -> i1
      %66 = llhd.prb %reg_be : i4
      %67 = comb.extract %66 from 0 : (i4) -> i1
      %68 = comb.xor %67, %true : i1
      %69 = comb.and %65, %68 : i1
      %70 = comb.extract %64 from 1 : (i3) -> i1
      %71 = comb.and %70, %68 : i1
      %72 = comb.extract %64 from 2 : (i3) -> i1
      %73 = comb.icmp ne %66, %c-1_i4 : i4
      %74 = comb.and %72, %73 : i1
      %75 = comb.or %69, %71, %74 : i1
      %76 = comb.and %63, %75 : i1
      llhd.drv %wr_err, %76 after %1 : i1
      llhd.wait (%8, %31, %53, %24 : i1, i3, i4, i1), ^bb1
    }
    %54 = comb.extract %31 from 0 : (i3) -> i1
    %55 = comb.xor %25, %true : i1
    %56 = comb.and %54, %8, %55 : i1
    llhd.drv %alert_test_we, %56 after %1 : i1
    %57 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "alert_test_wd"} : (i32) -> i1
    %58 = comb.extract %31 from 1 : (i3) -> i1
    %59 = comb.and %58, %8, %55 : i1
    llhd.drv %late_debug_enable_regwen_we, %59 after %1 : i1
    %60 = comb.extract %31 from 2 : (i3) -> i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %63 = llhd.sig.extract %reg_we_check from %c0_i2 : <i3> -> <i1>
      %64 = llhd.prb %alert_test_we : i1
      llhd.drv %63, %64 after %1 : i1
      %65 = llhd.sig.extract %reg_we_check from %c1_i2 : <i3> -> <i1>
      %66 = llhd.prb %late_debug_enable_regwen_we : i1
      llhd.drv %65, %66 after %1 : i1
      %67 = llhd.sig.extract %reg_we_check from %c-2_i2 : <i3> -> <i1>
      %68 = llhd.prb %late_debug_enable_gated_we : i1
      llhd.drv %67, %68 after %1 : i1
      llhd.wait (%7, %12, %15, %16 : i3, i1, i1, i1), ^bb1
    }
    %61 = llhd.prb %late_debug_enable_qs : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb8
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      %63 = llhd.prb %racl_addr_hit_read : i3
      %64 = comb.extract %63 from 0 : (i3) -> i1
      %65 = comb.icmp ceq %64, %true : i1
      cf.cond_br %65, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %66 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      llhd.drv %66, %false after %1 : i1
      cf.br ^bb8
    ^bb3:  // pred: ^bb1
      %67 = llhd.prb %racl_addr_hit_read : i3
      %68 = comb.extract %67 from 1 : (i3) -> i1
      %69 = comb.icmp ceq %68, %true : i1
      cf.cond_br %69, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %70 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %71 = llhd.prb %late_debug_enable_regwen_qs : i1
      llhd.drv %70, %71 after %1 : i1
      cf.br ^bb8
    ^bb5:  // pred: ^bb3
      %72 = llhd.prb %racl_addr_hit_read : i3
      %73 = comb.extract %72 from 2 : (i3) -> i1
      %74 = comb.icmp ceq %73, %true : i1
      cf.cond_br %74, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %75 = llhd.prb %late_debug_enable_qs : i32
      llhd.drv %reg_rdata_next, %75 after %1 : i32
      cf.br ^bb8
    ^bb7:  // pred: ^bb5
      llhd.drv %reg_rdata_next, %c-1_i32 after %1 : i32
      cf.br ^bb8
    ^bb8:  // 4 preds: ^bb2, ^bb4, ^bb6, ^bb7
      llhd.wait (%23, %30, %28, %61 : i32, i3, i1, i32), ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    %62 = llhd.prb %reg2hw : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, late_debug_enable: !hw.struct<q: i32>>
    llhd.drv %racl_policies_i_2, %racl_policies_i after %1 : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    hw.output %u_rsp_intg_gen.tl_o, %62, %11, %22 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, late_debug_enable: !hw.struct<q: i32>>, !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, i1
  }
  hw.module @rv_dm(in %clk_i : i1, in %clk_lc_i : i1, in %rst_ni : i1, in %rst_lc_ni : i1, in %next_dm_addr_i : i32, in %lc_hw_debug_clr_i : i4, in %lc_hw_debug_en_i : i4, in %lc_dft_en_i : i4, in %pinmux_hw_debug_en_i : i4, in %lc_check_byp_en_i : i4, in %lc_escalate_en_i : i4, in %lc_init_done_i : i4, in %strap_en_i : i1, in %strap_en_override_i : i1, in %otp_dis_rv_dm_late_debug_i : i8, in %scanmode_i : i4, in %scan_rst_ni : i1, out ndmreset_req_o : i1, out dmactive_o : i1, out debug_req_o : i1, in %unavailable_i : i1, in %regs_tl_d_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out regs_tl_d_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %mem_tl_d_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out mem_tl_d_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out sba_tl_h_o : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, in %sba_tl_h_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %alert_rx_i : !hw.array<1xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, out alert_tx_o : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>, in %racl_policies_i : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, out racl_error_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, in %jtag_i : !hw.struct<tck: i1, tms: i1, trst_n: i1, tdi: i1>, out jtag_o : !hw.struct<tdo: i1, tdo_oe: i1>, in %dbg_tl_d_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out dbg_tl_d_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) {
    %0 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [-1 : i7, -1 : i7], false, true] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %1 = hw.aggregate_constant [0 : i8, 2 : i4, 0 : i3, true, 2 : i4, 896 : i12] : !hw.struct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>
    %c0_i20 = hw.constant 0 : i20
    %c3_i3 = hw.constant 3 : i3
    %c0_i3 = hw.constant 0 : i3
    %2 = llhd.constant_time <0ns, 1d, 0e>
    %c-4_i3 = hw.constant -4 : i3
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %c1_i3 = hw.constant 1 : i3
    %c2_i3 = hw.constant 2 : i3
    %3 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i0 = hw.constant 0 : i0
    %4 = hw.aggregate_constant [false, false] : !hw.struct<tdo: i1, tdo_oe: i1>
    %5 = hw.aggregate_constant [0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4] : !hw.array<5xi4>
    %6 = hw.aggregate_constant [[0 : i8, 0 : i4, 0 : i3, false, 0 : i4, 0 : i12]] : !hw.array<1xstruct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>>
    %7 = hw.aggregate_constant [false, false, false, false] : !hw.struct<tck: i1, tms: i1, trst_n: i1, tdi: i1>
    %8 = hw.aggregate_constant [[false, false]] : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    %c0_i2 = hw.constant 0 : i2
    %c0_i4 = hw.constant 0 : i4
    %true = hw.constant true
    %c-6_i4 = hw.constant -6 : i4
    %c0_i5 = hw.constant 0 : i5
    %c-7_i4 = hw.constant -7 : i4
    %c0_i7 = hw.constant 0 : i7
    %false = hw.constant false {sv.namehint = "dbg_intg_error"}
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %9 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %10 = llhd.prb %rst_ni_1 : i1
    %alert_tx_o = llhd.sig %8 : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    %jtag_i_2 = llhd.sig name "jtag_i" %7 : !hw.struct<tck: i1, tms: i1, trst_n: i1, tdi: i1>
    %hartinfo = llhd.sig %6 : !hw.array<1xstruct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>>
    %alerts = llhd.sig %false : i1
    %lc_hw_debug_en = llhd.sig %c0_i4 : i4
    %lc_hw_debug_en_raw = llhd.sig %c0_i4 : i4
    %lc_dft_en_raw = llhd.sig %c0_i4 : i4
    %lc_hw_debug_en_gated_raw = llhd.sig %c0_i4 : i4
    %lc_hw_debug_en_gated = llhd.sig %5 : !hw.array<5xi4>
    %lc_hw_debug_en_latched_q = llhd.sig %c0_i4 : i4
    %lc_init_done_sync = llhd.sig %c0_i4 : i4
    %lc_hw_debug_en_gated_ndm = llhd.sig %5 : !hw.array<5xi4>
    %ndmreset_req = llhd.sig %false : i1
    %ndmreset_ack = llhd.sig %false : i1
    %lc_rst_asserted = llhd.sig %false : i1
    %ndmreset_pending_q = llhd.sig %false : i1
    %lc_rst_pending_q = llhd.sig %false : i1
    %debug_req_en = llhd.sig %false : i1
    %gen_jtag_gating.jtag_out_int = llhd.sig %4 : !hw.struct<tdo: i1, tdo_oe: i1>
    %u_reg_regs.tl_o, %u_reg_regs.reg2hw, %u_reg_regs.racl_error_o, %u_reg_regs.intg_err_o = hw.instance "u_reg_regs" @rv_dm_regs_reg_top(clk_i: %9: i1, rst_ni: %10: i1, tl_i: %regs_tl_d_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, racl_policies_i: %racl_policies_i: !hw.array<1xstruct<write_perm: i2, read_perm: i2>>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, reg2hw: !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, late_debug_enable: !hw.struct<q: i32>>, racl_error_o: !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, intg_err_o: i1) {sv.namehint = "regs_reg2hw"}
    %11 = llhd.prb %alerts : i1
    %12 = hw.array_get %alert_rx_i[%c0_i0] : !hw.array<1xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, i0
    %13 = llhd.sig.array_get %alert_tx_o[%c0_i0] : <!hw.array<1xstruct<alert_p: i1, alert_n: i1>>>
    %gen_alert_tx_0.u_prim_alert_sender.alert_ack_o, %gen_alert_tx_0.u_prim_alert_sender.alert_state_o, %gen_alert_tx_0.u_prim_alert_sender.alert_tx_o = hw.instance "gen_alert_tx_0.u_prim_alert_sender" @prim_alert_sender(clk_i: %9: i1, rst_ni: %10: i1, alert_test_i: %31: i1, alert_req_i: %11: i1, alert_rx_i: %12: !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>) -> (alert_ack_o: i1, alert_state_o: i1, alert_tx_o: !hw.struct<alert_p: i1, alert_n: i1>)
    llhd.drv %13, %gen_alert_tx_0.u_prim_alert_sender.alert_tx_o after %3 : !hw.struct<alert_p: i1, alert_n: i1>
    %u_prim_lc_sync_lc_hw_debug_en.lc_en_o = hw.instance "u_prim_lc_sync_lc_hw_debug_en" @prim_lc_sync(clk_i: %9: i1, rst_ni: %10: i1, lc_en_i: %lc_hw_debug_en_i: i4) -> (lc_en_o: !hw.array<1xi4>)
    %14 = hw.bitcast %u_prim_lc_sync_lc_hw_debug_en.lc_en_o : (!hw.array<1xi4>) -> i4
    llhd.drv %lc_hw_debug_en, %14 after %3 : i4
    %u_prim_lc_sync_lc_dft_en.lc_en_o = hw.instance "u_prim_lc_sync_lc_dft_en" @prim_lc_sync(clk_i: %9: i1, rst_ni: %10: i1, lc_en_i: %lc_dft_en_i: i4) -> (lc_en_o: !hw.array<1xi4>)
    %15 = hw.bitcast %u_prim_lc_sync_lc_dft_en.lc_en_o {sv.namehint = "lc_dft_en"} : (!hw.array<1xi4>) -> i4
    %u_prim_mubi8_sync_otp_dis_rv_dm_late_debug.mubi_o = hw.instance "u_prim_mubi8_sync_otp_dis_rv_dm_late_debug" @prim_mubi8_sync(clk_i: %9: i1, rst_ni: %10: i1, mubi_i: %otp_dis_rv_dm_late_debug_i: i8) -> (mubi_o: !hw.array<4xi8>) {sv.namehint = "otp_dis_rv_dm_late_debug"}
    %late_debug_enable = hw.struct_extract %u_reg_regs.reg2hw["late_debug_enable"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, late_debug_enable: !hw.struct<q: i32>>
    %16 = hw.bitcast %late_debug_enable : (!hw.struct<q: i32>) -> i32
    %u_prim_mubi32_sync_late_debug_enable.mubi_o = hw.instance "u_prim_mubi32_sync_late_debug_enable" @prim_mubi32_sync(clk_i: %9: i1, rst_ni: %10: i1, mubi_i: %16: i32) -> (mubi_o: !hw.array<4xi32>) {sv.namehint = "late_debug_enable"}
    %17 = llhd.prb %lc_hw_debug_en_gated_raw : i4
    %u_lc_en_sync_copies.lc_en_o = hw.instance "u_lc_en_sync_copies" @prim_lc_sync_0(clk_i: %9: i1, rst_ni: %10: i1, lc_en_i: %17: i4) -> (lc_en_o: !hw.array<5xi4>)
    llhd.drv %lc_hw_debug_en_gated, %u_lc_en_sync_copies.lc_en_o after %3 : !hw.array<5xi4>
    %u_lc_init_done_sync.lc_en_o = hw.instance "u_lc_init_done_sync" @prim_lc_sync(clk_i: %9: i1, rst_ni: %10: i1, lc_en_i: %lc_init_done_i: i4) -> (lc_en_o: !hw.array<1xi4>)
    %18 = hw.bitcast %u_lc_init_done_sync.lc_en_o : (!hw.array<1xi4>) -> i4
    llhd.drv %lc_init_done_sync, %18 after %3 : i4
    %u_prim_flop_2sync_lc_rst_assert.q_o = hw.instance "u_prim_flop_2sync_lc_rst_assert" @prim_flop_2sync(clk_i: %9: i1, rst_ni: %rst_lc_ni: i1, d_i: %false: i1) -> (q_o: i1) {sv.namehint = "lc_rst_asserted_async"}
    %u_prim_flop_2sync_lc_rst_sync.q_o = hw.instance "u_prim_flop_2sync_lc_rst_sync" @prim_flop_2sync_1(clk_i: %9: i1, rst_ni: %10: i1, d_i: %u_prim_flop_2sync_lc_rst_assert.q_o: i1) -> (q_o: i1)
    llhd.drv %lc_rst_asserted, %u_prim_flop_2sync_lc_rst_sync.q_o after %3 : i1
    %19 = llhd.prb %lc_hw_debug_en_gated_ndm : !hw.array<5xi4>
    %20 = hw.array_get %19[%c2_i3] : !hw.array<5xi4>, i3
    %u_tlul_lc_gate_sba.tl_d2h_o, %u_tlul_lc_gate_sba.tl_h2d_o, %u_tlul_lc_gate_sba.flush_ack_o, %u_tlul_lc_gate_sba.resp_pending_o, %u_tlul_lc_gate_sba.err_o = hw.instance "u_tlul_lc_gate_sba" @tlul_lc_gate(clk_i: %9: i1, rst_ni: %10: i1, tl_h2d_i: %tl_adapter_host_sba.tl_o: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, tl_d2h_i: %sba_tl_h_i: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, flush_req_i: %false: i1, lc_en_i: %20: i4) -> (tl_d2h_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, tl_h2d_o: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, flush_ack_o: i1, resp_pending_o: i1, err_o: i1) {sv.namehint = "sba_gate_intg_error"}
    %tl_adapter_host_sba.gnt_o, %tl_adapter_host_sba.valid_o, %tl_adapter_host_sba.rdata_o, %tl_adapter_host_sba.rdata_intg_o, %tl_adapter_host_sba.err_o, %tl_adapter_host_sba.intg_err_o, %tl_adapter_host_sba.tl_o = hw.instance "tl_adapter_host_sba" @tlul_adapter_host(clk_i: %9: i1, rst_ni: %10: i1, req_i: %u_dm_top.master_req_o: i1, addr_i: %u_dm_top.master_add_o: i32, we_i: %u_dm_top.master_we_o: i1, wdata_i: %u_dm_top.master_wdata_o: i32, wdata_intg_i: %c0_i7: i7, be_i: %u_dm_top.master_be_o: i4, instr_type_i: %c-7_i4: i4, user_rsvd_i: %c0_i5: i5, tl_i: %u_tlul_lc_gate_sba.tl_d2h_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (gnt_o: i1, valid_o: i1, rdata_o: i32, rdata_intg_o: i7, err_o: i1, intg_err_o: i1, tl_o: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) {sv.namehint = "host_gnt"}
    %gen_jtag_gating.u_pm_en_sync.lc_en_o = hw.instance "gen_jtag_gating.u_pm_en_sync" @prim_lc_sync_2(clk_i: %9: i1, rst_ni: %10: i1, lc_en_i: %pinmux_hw_debug_en_i: i4) -> (lc_en_o: !hw.array<3xi4>) {sv.namehint = "gen_jtag_gating.pinmux_hw_debug_en"}
    %tck = hw.struct_extract %101["tck"] : !hw.struct<tck: i1, tms: i1, trst_n: i1, tdi: i1>
    %gen_jtag_gating.u_prim_clock_mux2.clk_o = hw.instance "gen_jtag_gating.u_prim_clock_mux2" @prim_clock_mux2(clk0_i: %tck: i1, clk1_i: %9: i1, sel_i: %32: i1) -> (clk_o: i1) {sv.namehint = "gen_jtag_gating.tck_muxed"}
    %trst_n = hw.struct_extract %101["trst_n"] : !hw.struct<tck: i1, tms: i1, trst_n: i1, tdi: i1>
    %gen_jtag_gating.u_prim_rst_n_mux2.clk_o = hw.instance "gen_jtag_gating.u_prim_rst_n_mux2" @prim_clock_mux2(clk0_i: %trst_n: i1, clk1_i: %scan_rst_ni: i1, sel_i: %32: i1) -> (clk_o: i1) {sv.namehint = "gen_jtag_gating.trst_n_muxed"}
    %21 = comb.and %u_dm_top.dmi_req_ready_o, %109 : i1
    %22 = comb.and %u_dm_top.dmi_resp_valid_o, %109 : i1
    %tms = hw.struct_extract %101["tms"] : !hw.struct<tck: i1, tms: i1, trst_n: i1, tdi: i1>
    %tdi = hw.struct_extract %101["tdi"] : !hw.struct<tck: i1, tms: i1, trst_n: i1, tdi: i1>
    %23 = llhd.sig.struct_extract %gen_jtag_gating.jtag_out_int["tdo"] : <!hw.struct<tdo: i1, tdo_oe: i1>>
    %24 = llhd.sig.struct_extract %gen_jtag_gating.jtag_out_int["tdo_oe"] : <!hw.struct<tdo: i1, tdo_oe: i1>>
    %gen_jtag_gating.dap.dmi_rst_no, %gen_jtag_gating.dap.dmi_req_o, %gen_jtag_gating.dap.dmi_req_valid_o, %gen_jtag_gating.dap.dmi_resp_ready_o, %gen_jtag_gating.dap.td_o, %gen_jtag_gating.dap.tdo_oe_o = hw.instance "gen_jtag_gating.dap" @dmi_jtag(clk_i: %9: i1, rst_ni: %10: i1, testmode_i: %32: i1, test_rst_ni: %scan_rst_ni: i1, dmi_req_ready_i: %21: i1, dmi_resp_i: %u_dm_top.dmi_resp_o: !hw.struct<data: i32, resp: i2>, dmi_resp_valid_i: %22: i1, tck_i: %gen_jtag_gating.u_prim_clock_mux2.clk_o: i1, tms_i: %tms: i1, trst_ni: %gen_jtag_gating.u_prim_rst_n_mux2.clk_o: i1, td_i: %tdi: i1) -> (dmi_rst_no: i1, dmi_req_o: !hw.struct<addr: i32, op: i2, data: i32>, dmi_req_valid_o: i1, dmi_resp_ready_o: i1, td_o: i1, tdo_oe_o: i1) {sv.namehint = "dmi_req"}
    llhd.drv %23, %gen_jtag_gating.dap.td_o after %3 : i1
    llhd.drv %24, %gen_jtag_gating.dap.tdo_oe_o after %3 : i1
    %25 = llhd.prb %ndmreset_req : i1
    %26 = hw.array_get %19[%c1_i3] : !hw.array<5xi4>, i3
    %u_tlul_lc_gate_rom.tl_d2h_o, %u_tlul_lc_gate_rom.tl_h2d_o, %u_tlul_lc_gate_rom.flush_ack_o, %u_tlul_lc_gate_rom.resp_pending_o, %u_tlul_lc_gate_rom.err_o = hw.instance "u_tlul_lc_gate_rom" @tlul_lc_gate(clk_i: %9: i1, rst_ni: %10: i1, tl_h2d_i: %mem_tl_d_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, tl_d2h_i: %i_tlul_adapter_reg.tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, flush_req_i: %25: i1, lc_en_i: %26: i4) -> (tl_d2h_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, tl_h2d_o: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, flush_ack_o: i1, resp_pending_o: i1, err_o: i1) {sv.namehint = "ndmreset_req_qual"}
    %i_tlul_adapter_reg.tl_o, %i_tlul_adapter_reg.intg_error_o, %i_tlul_adapter_reg.re_o, %i_tlul_adapter_reg.we_o, %i_tlul_adapter_reg.addr_o, %i_tlul_adapter_reg.wdata_o, %i_tlul_adapter_reg.be_o = hw.instance "i_tlul_adapter_reg" @tlul_adapter_reg(clk_i: %9: i1, rst_ni: %10: i1, tl_i: %u_tlul_lc_gate_rom.tl_h2d_o: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, en_ifetch_i: %113: i4, busy_i: %false: i1, rdata_i: %u_dm_top.slave_rdata_o: i32, error_i: %u_dm_top.slave_err_o: i1) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, intg_error_o: i1, re_o: i1, we_o: i1, addr_o: i12, wdata_o: i32, be_o: i4) {sv.namehint = "device_be"}
    %27 = llhd.prb %ndmreset_ack : i1
    %28 = llhd.prb %hartinfo : !hw.array<1xstruct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>>
    %u_dm_top.ndmreset_o, %u_dm_top.dmactive_o, %u_dm_top.debug_req_o, %u_dm_top.slave_rdata_o, %u_dm_top.slave_err_o, %u_dm_top.master_req_o, %u_dm_top.master_add_o, %u_dm_top.master_we_o, %u_dm_top.master_wdata_o, %u_dm_top.master_be_o, %u_dm_top.dmi_req_ready_o, %u_dm_top.dmi_resp_valid_o, %u_dm_top.dmi_resp_o = hw.instance "u_dm_top" @dm_top(clk_i: %9: i1, rst_ni: %10: i1, next_dm_addr_i: %next_dm_addr_i: i32, testmode_i: %32: i1, ndmreset_ack_i: %27: i1, unavailable_i: %unavailable_i: i1, hartinfo_i: %28: !hw.array<1xstruct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>>, slave_req_i: %114: i1, slave_we_i: %i_tlul_adapter_reg.we_o: i1, slave_addr_i: %91: i32, slave_be_i: %i_tlul_adapter_reg.be_o: i4, slave_wdata_i: %i_tlul_adapter_reg.wdata_o: i32, master_gnt_i: %tl_adapter_host_sba.gnt_o: i1, master_r_valid_i: %tl_adapter_host_sba.valid_o: i1, master_r_err_i: %tl_adapter_host_sba.err_o: i1, master_r_other_err_i: %tl_adapter_host_sba.intg_err_o: i1, master_r_rdata_i: %tl_adapter_host_sba.rdata_o: i32, dmi_rst_ni: %gen_jtag_gating.dap.dmi_rst_no: i1, dmi_req_valid_i: %110: i1, dmi_req_i: %gen_jtag_gating.dap.dmi_req_o: !hw.struct<addr: i32, op: i2, data: i32>, dmi_resp_ready_i: %111: i1) -> (ndmreset_o: i1, dmactive_o: i1, debug_req_o: i1, slave_rdata_o: i32, slave_err_o: i1, master_req_o: i1, master_add_o: i32, master_we_o: i1, master_wdata_o: i32, master_be_o: i4, dmi_req_ready_o: i1, dmi_resp_valid_o: i1, dmi_resp_o: !hw.struct<data: i32, resp: i2>) {sv.namehint = "host_be"}
    llhd.drv %ndmreset_req, %u_dm_top.ndmreset_o after %3 : i1
    %29 = llhd.sig.array_get %hartinfo[%c0_i0] : <!hw.array<1xstruct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>>>
    llhd.drv %29, %1 after %3 : !hw.struct<zero1: i8, nscratch: i4, zero0: i3, dataaccess: i1, datasize: i4, dataaddr: i12>
    %30 = comb.or %u_reg_regs.intg_err_o, %i_tlul_adapter_reg.intg_error_o, %u_tlul_lc_gate_sba.err_o, %u_tlul_lc_gate_rom.err_o : i1
    llhd.drv %alerts, %30 after %3 : i1
    %alert_test = hw.struct_extract %u_reg_regs.reg2hw["alert_test"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, late_debug_enable: !hw.struct<q: i32>>
    %q = hw.struct_extract %alert_test["q"] : !hw.struct<q: i1, qe: i1>
    %qe = hw.struct_extract %alert_test["qe"] : !hw.struct<q: i1, qe: i1>
    %31 = comb.and %q, %qe : i1
    %32 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%scanmode_i) {sv.namehint = "testmode"} : (i4) -> i1
    %33 = llhd.prb %lc_hw_debug_en : i4
    llhd.drv %lc_hw_debug_en_raw, %33 after %3 : i4
    llhd.drv %lc_dft_en_raw, %15 after %3 : i4
    %34 = llhd.sig.extract %lc_hw_debug_en_gated_raw from %c0_i2 : <i4> -> <i1>
    %35 = hw.array_get %u_prim_mubi8_sync_otp_dis_rv_dm_late_debug.mubi_o[%c0_i2] : !hw.array<4xi8>, i2
    %36 = func.call @"prim_mubi_pkg::mubi8_test_true_strict"(%35) : (i8) -> i1
    %37 = hw.array_get %u_prim_mubi32_sync_late_debug_enable.mubi_o[%c0_i2] : !hw.array<4xi32>, i2
    %38 = func.call @"prim_mubi_pkg::mubi32_test_true_strict"(%37) : (i32) -> i1
    %39 = comb.or %36, %38 : i1
    %40 = llhd.prb %lc_hw_debug_en_raw : i4
    %41 = comb.extract %40 from 0 : (i4) -> i1
    %42 = llhd.prb %lc_dft_en_raw : i4
    %43 = comb.extract %42 from 0 : (i4) -> i1
    %44 = comb.mux %39, %41, %43 : i1
    llhd.drv %34, %44 after %3 : i1
    %45 = llhd.sig.extract %lc_hw_debug_en_gated_raw from %c1_i2 : <i4> -> <i1>
    %46 = hw.array_get %u_prim_mubi8_sync_otp_dis_rv_dm_late_debug.mubi_o[%c1_i2] : !hw.array<4xi8>, i2
    %47 = func.call @"prim_mubi_pkg::mubi8_test_true_strict"(%46) : (i8) -> i1
    %48 = hw.array_get %u_prim_mubi32_sync_late_debug_enable.mubi_o[%c1_i2] : !hw.array<4xi32>, i2
    %49 = func.call @"prim_mubi_pkg::mubi32_test_true_strict"(%48) : (i32) -> i1
    %50 = comb.or %47, %49 : i1
    %51 = comb.extract %40 from 1 : (i4) -> i1
    %52 = comb.extract %42 from 1 : (i4) -> i1
    %53 = comb.mux %50, %51, %52 : i1
    llhd.drv %45, %53 after %3 : i1
    %54 = llhd.sig.extract %lc_hw_debug_en_gated_raw from %c-2_i2 : <i4> -> <i1>
    %55 = hw.array_get %u_prim_mubi8_sync_otp_dis_rv_dm_late_debug.mubi_o[%c-2_i2] : !hw.array<4xi8>, i2
    %56 = func.call @"prim_mubi_pkg::mubi8_test_true_strict"(%55) : (i8) -> i1
    %57 = hw.array_get %u_prim_mubi32_sync_late_debug_enable.mubi_o[%c-2_i2] : !hw.array<4xi32>, i2
    %58 = func.call @"prim_mubi_pkg::mubi32_test_true_strict"(%57) : (i32) -> i1
    %59 = comb.or %56, %58 : i1
    %60 = comb.extract %40 from 2 : (i4) -> i1
    %61 = comb.extract %42 from 2 : (i4) -> i1
    %62 = comb.mux %59, %60, %61 : i1
    llhd.drv %54, %62 after %3 : i1
    %63 = llhd.sig.extract %lc_hw_debug_en_gated_raw from %c-1_i2 : <i4> -> <i1>
    %64 = hw.array_get %u_prim_mubi8_sync_otp_dis_rv_dm_late_debug.mubi_o[%c-1_i2] : !hw.array<4xi8>, i2
    %65 = func.call @"prim_mubi_pkg::mubi8_test_true_strict"(%64) : (i8) -> i1
    %66 = hw.array_get %u_prim_mubi32_sync_late_debug_enable.mubi_o[%c-1_i2] : !hw.array<4xi32>, i2
    %67 = func.call @"prim_mubi_pkg::mubi32_test_true_strict"(%66) : (i32) -> i1
    %68 = comb.or %65, %67 : i1
    %69 = comb.extract %40 from 3 : (i4) -> i1
    %70 = comb.extract %42 from 3 : (i4) -> i1
    %71 = comb.mux %68, %69, %70 : i1
    llhd.drv %63, %71 after %3 : i1
    %72 = hw.array_get %19[%c-4_i3] : !hw.array<5xi4>, i3
    %73 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%72) {sv.namehint = "reset_req_en"} : (i4) -> i1
    %74 = comb.and %u_tlul_lc_gate_rom.flush_ack_o, %73 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb13, ^bb14
      %116 = llhd.prb %clk_i_0 : i1
      %117 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%9, %10 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %118 = llhd.prb %clk_i_0 : i1
      %119 = comb.xor bin %116, %true : i1
      %120 = comb.and bin %119, %118 : i1
      %121 = llhd.prb %rst_ni_1 : i1
      %122 = comb.xor bin %121, %true : i1
      %123 = comb.and bin %117, %122 : i1
      %124 = comb.or bin %120, %123 : i1
      cf.cond_br %124, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %125 = llhd.prb %rst_ni_1 : i1
      %126 = comb.xor %125, %true : i1
      cf.cond_br %126, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %ndmreset_pending_q, %false after %2 : i1
      llhd.drv %lc_rst_pending_q, %false after %2 : i1
      llhd.drv %lc_hw_debug_en_latched_q, %c-6_i4 after %2 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %127 = llhd.prb %ndmreset_req : i1
      %128 = llhd.prb %ndmreset_pending_q : i1
      %129 = comb.xor %128, %true : i1
      %130 = comb.and %127, %129 : i1
      cf.cond_br %130, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %ndmreset_pending_q, %true after %2 : i1
      %131 = llhd.prb %lc_hw_debug_en : i4
      llhd.drv %lc_hw_debug_en_latched_q, %131 after %2 : i4
      cf.br ^bb9
    ^bb7:  // pred: ^bb5
      %132 = llhd.prb %ndmreset_ack : i1
      %133 = llhd.prb %ndmreset_pending_q : i1
      %134 = comb.and %132, %133 : i1
      cf.cond_br %134, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %ndmreset_pending_q, %false after %2 : i1
      cf.br ^bb9
    ^bb9:  // 3 preds: ^bb6, ^bb7, ^bb8
      %135 = llhd.prb %ndmreset_pending_q : i1
      %136 = llhd.prb %lc_rst_asserted : i1
      %137 = comb.and %135, %136 : i1
      cf.cond_br %137, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      llhd.drv %lc_rst_pending_q, %true after %2 : i1
      cf.br ^bb13
    ^bb11:  // pred: ^bb9
      %138 = llhd.prb %ndmreset_ack : i1
      %139 = llhd.prb %lc_rst_pending_q : i1
      %140 = comb.and %138, %139 : i1
      cf.cond_br %140, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      llhd.drv %lc_rst_pending_q, %false after %2 : i1
      cf.br ^bb13
    ^bb13:  // 3 preds: ^bb10, ^bb11, ^bb12
      %141 = llhd.prb %lc_init_done_sync : i4
      %142 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%141) : (i4) -> i1
      cf.cond_br %142, ^bb14, ^bb1
    ^bb14:  // pred: ^bb13
      llhd.drv %lc_hw_debug_en_latched_q, %c-6_i4 after %2 : i4
      cf.br ^bb1
    }
    %75 = llhd.prb %ndmreset_pending_q : i1
    %76 = llhd.prb %lc_rst_pending_q : i1
    %77 = comb.xor %25, %true : i1
    %78 = llhd.prb %lc_rst_asserted : i1
    %79 = comb.xor %78, %true : i1
    %80 = comb.and %75, %76, %77, %79, %73 : i1
    llhd.drv %ndmreset_ack, %80 after %3 : i1
    %81 = llhd.sig.array_get %lc_hw_debug_en_gated_ndm[%c0_i3] : <!hw.array<5xi4>>
    %82 = scf.if %75 -> (i4) {
      %116 = llhd.prb %lc_hw_debug_en_gated : !hw.array<5xi4>
      %117 = hw.array_get %116[%c0_i3] : !hw.array<5xi4>, i3
      %118 = llhd.prb %lc_hw_debug_en_latched_q : i4
      %119 = func.call @"lc_ctrl_pkg::lc_tx_or_hi"(%117, %118) : (i4, i4) -> i4
      scf.yield %119 : i4
    } else {
      %116 = llhd.prb %lc_hw_debug_en_gated : !hw.array<5xi4>
      %117 = hw.array_get %116[%c0_i3] : !hw.array<5xi4>, i3
      scf.yield %117 : i4
    }
    llhd.drv %81, %82 after %3 : i4
    %83 = llhd.sig.array_get %lc_hw_debug_en_gated_ndm[%c1_i3] : <!hw.array<5xi4>>
    %84 = scf.if %75 -> (i4) {
      %116 = llhd.prb %lc_hw_debug_en_gated : !hw.array<5xi4>
      %117 = hw.array_get %116[%c1_i3] : !hw.array<5xi4>, i3
      %118 = llhd.prb %lc_hw_debug_en_latched_q : i4
      %119 = func.call @"lc_ctrl_pkg::lc_tx_or_hi"(%117, %118) : (i4, i4) -> i4
      scf.yield %119 : i4
    } else {
      %116 = llhd.prb %lc_hw_debug_en_gated : !hw.array<5xi4>
      %117 = hw.array_get %116[%c1_i3] : !hw.array<5xi4>, i3
      scf.yield %117 : i4
    }
    llhd.drv %83, %84 after %3 : i4
    %85 = llhd.sig.array_get %lc_hw_debug_en_gated_ndm[%c2_i3] : <!hw.array<5xi4>>
    %86 = scf.if %75 -> (i4) {
      %116 = llhd.prb %lc_hw_debug_en_gated : !hw.array<5xi4>
      %117 = hw.array_get %116[%c2_i3] : !hw.array<5xi4>, i3
      %118 = llhd.prb %lc_hw_debug_en_latched_q : i4
      %119 = func.call @"lc_ctrl_pkg::lc_tx_or_hi"(%117, %118) : (i4, i4) -> i4
      scf.yield %119 : i4
    } else {
      %116 = llhd.prb %lc_hw_debug_en_gated : !hw.array<5xi4>
      %117 = hw.array_get %116[%c2_i3] : !hw.array<5xi4>, i3
      scf.yield %117 : i4
    }
    llhd.drv %85, %86 after %3 : i4
    %87 = llhd.sig.array_get %lc_hw_debug_en_gated_ndm[%c3_i3] : <!hw.array<5xi4>>
    %88 = scf.if %75 -> (i4) {
      %116 = llhd.prb %lc_hw_debug_en_gated : !hw.array<5xi4>
      %117 = hw.array_get %116[%c3_i3] : !hw.array<5xi4>, i3
      %118 = llhd.prb %lc_hw_debug_en_latched_q : i4
      %119 = func.call @"lc_ctrl_pkg::lc_tx_or_hi"(%117, %118) : (i4, i4) -> i4
      scf.yield %119 : i4
    } else {
      %116 = llhd.prb %lc_hw_debug_en_gated : !hw.array<5xi4>
      %117 = hw.array_get %116[%c3_i3] : !hw.array<5xi4>, i3
      scf.yield %117 : i4
    }
    llhd.drv %87, %88 after %3 : i4
    %89 = llhd.sig.array_get %lc_hw_debug_en_gated_ndm[%c-4_i3] : <!hw.array<5xi4>>
    %90 = scf.if %75 -> (i4) {
      %116 = llhd.prb %lc_hw_debug_en_gated : !hw.array<5xi4>
      %117 = hw.array_get %116[%c-4_i3] : !hw.array<5xi4>, i3
      %118 = llhd.prb %lc_hw_debug_en_latched_q : i4
      %119 = func.call @"lc_ctrl_pkg::lc_tx_or_hi"(%117, %118) : (i4, i4) -> i4
      scf.yield %119 : i4
    } else {
      %116 = llhd.prb %lc_hw_debug_en_gated : !hw.array<5xi4>
      %117 = hw.array_get %116[%c-4_i3] : !hw.array<5xi4>, i3
      scf.yield %117 : i4
    }
    llhd.drv %89, %90 after %3 : i4
    %91 = comb.concat %c0_i20, %i_tlul_adapter_reg.addr_o {sv.namehint = "device_addr_aligned"} : i20, i12
    %92 = hw.array_get %19[%c3_i3] : !hw.array<5xi4>, i3
    %93 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%92) : (i4) -> i1
    llhd.drv %debug_req_en, %93 after %3 : i1
    %94 = llhd.prb %debug_req_en : i1
    %95 = comb.and %u_dm_top.debug_req_o, %94 : i1
    %96 = hw.array_get %gen_jtag_gating.u_pm_en_sync.lc_en_o[%c1_i2] : !hw.array<3xi4>, i2
    %97 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%96) : (i4) -> i1
    %98 = llhd.prb %jtag_i_2 : !hw.struct<tck: i1, tms: i1, trst_n: i1, tdi: i1>
    %99 = hw.bitcast %98 : (!hw.struct<tck: i1, tms: i1, trst_n: i1, tdi: i1>) -> i4
    %100 = comb.mux %97, %99, %c0_i4 : i4
    %101 = hw.bitcast %100 {sv.namehint = "gen_jtag_gating.jtag_in_int"} : (i4) -> !hw.struct<tck: i1, tms: i1, trst_n: i1, tdi: i1>
    %102 = hw.array_get %gen_jtag_gating.u_pm_en_sync.lc_en_o[%c-2_i2] : !hw.array<3xi4>, i2
    %103 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%102) : (i4) -> i1
    %104 = llhd.prb %gen_jtag_gating.jtag_out_int : !hw.struct<tdo: i1, tdo_oe: i1>
    %105 = hw.bitcast %104 : (!hw.struct<tdo: i1, tdo_oe: i1>) -> i2
    %106 = comb.mux %103, %105, %c0_i2 : i2
    %107 = hw.bitcast %106 : (i2) -> !hw.struct<tdo: i1, tdo_oe: i1>
    %108 = hw.array_get %gen_jtag_gating.u_pm_en_sync.lc_en_o[%c0_i2] : !hw.array<3xi4>, i2
    %109 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%108) {sv.namehint = "gen_jtag_gating.dmi_en"} : (i4) -> i1
    %110 = comb.and %gen_jtag_gating.dap.dmi_req_valid_o, %109 {sv.namehint = "dmi_req_valid"} : i1
    %111 = comb.and %gen_jtag_gating.dap.dmi_resp_ready_o, %109 {sv.namehint = "dmi_rsp_ready"} : i1
    %112 = hw.array_get %19[%c0_i3] : !hw.array<5xi4>, i3
    %113 = func.call @"lc_ctrl_pkg::lc_to_mubi4"(%112) {sv.namehint = "en_ifetch"} : (i4) -> i4
    %114 = comb.or %i_tlul_adapter_reg.we_o, %i_tlul_adapter_reg.re_o {sv.namehint = "device_req"} : i1
    llhd.drv %clk_i_0, %clk_i after %3 : i1
    llhd.drv %rst_ni_1, %rst_ni after %3 : i1
    %115 = llhd.prb %alert_tx_o : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    llhd.drv %jtag_i_2, %jtag_i after %3 : !hw.struct<tck: i1, tms: i1, trst_n: i1, tdi: i1>
    hw.output %74, %u_dm_top.dmactive_o, %95, %u_reg_regs.tl_o, %u_tlul_lc_gate_rom.tl_d2h_o, %u_tlul_lc_gate_sba.tl_h2d_o, %115, %u_reg_regs.racl_error_o, %107, %0 : i1, i1, i1, !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, !hw.array<1xstruct<alert_p: i1, alert_n: i1>>, !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, !hw.struct<tdo: i1, tdo_oe: i1>, !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
  }
}
