module {
  hw.module private @prim_buf(in %in_i : i2, out out_o : i2) {
    hw.output %in_i : i2
  }
  hw.module private @prim_buf_12(in %in_i : i11, out out_o : i11) {
    hw.output %in_i : i11
  }
  hw.module private @prim_buf_15(in %in_i : i29, out out_o : i29) {
    hw.output %in_i : i29
  }
  hw.module private @prim_buf_24(in %in_i : i1, out out_o : i1) {
    hw.output %in_i : i1
  }
  hw.module private @prim_flop_2sync(in %clk_i : i1, in %rst_ni : i1, in %d_i : i11, out q_o : i11) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i11 = hw.constant 0 : i11
    %d_i_0 = llhd.sig name "d_i" %c0_i11 : i11
    %d_o = llhd.sig %c0_i11 : i11
    %1 = llhd.prb %d_o : i11
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i11) -> (q_o: i11) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i11) -> (q_o: i11)
    %2 = llhd.prb %d_i_0 : i11
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %3 = llhd.prb %d_i_0 : i11
      llhd.drv %d_o, %3 after %0 : i11
      llhd.wait (%2, %1 : i11, i11), ^bb1
    }
    llhd.drv %d_i_0, %d_i after %0 : i11
    hw.output %u_sync_2.q_o : i11
  }
  hw.module private @prim_flop_2sync_0(in %clk_i : i1, in %rst_ni : i1, in %d_i : i11, out q_o : i11) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i11 = hw.constant 0 : i11
    %d_i_0 = llhd.sig name "d_i" %c0_i11 : i11
    %d_o = llhd.sig %c0_i11 : i11
    %1 = llhd.prb %d_o : i11
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_5(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i11) -> (q_o: i11) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_5(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i11) -> (q_o: i11)
    %2 = llhd.prb %d_i_0 : i11
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %3 = llhd.prb %d_i_0 : i11
      llhd.drv %d_o, %3 after %0 : i11
      llhd.wait (%2, %1 : i11, i11), ^bb1
    }
    llhd.drv %d_i_0, %d_i after %0 : i11
    hw.output %u_sync_2.q_o : i11
  }
  hw.module private @prim_flop_2sync_4(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %d_i_0 = llhd.sig name "d_i" %false : i1
    %d_o = llhd.sig %false : i1
    %1 = llhd.prb %d_o : i1
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_14(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i1) -> (q_o: i1) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_14(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i1) -> (q_o: i1)
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
  hw.module private @prim_flop_2sync_11(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_o : i2) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %d_i_0 = llhd.sig name "d_i" %c0_i2 : i2
    %d_o = llhd.sig %c0_i2 : i2
    %1 = llhd.prb %d_o : i2
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_22(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i2) -> (q_o: i2) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_22(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i2) -> (q_o: i2)
    %2 = llhd.prb %d_i_0 : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %3 = llhd.prb %d_i_0 : i2
      llhd.drv %d_o, %3 after %0 : i2
      llhd.wait (%2, %1 : i2, i2), ^bb1
    }
    llhd.drv %d_i_0, %d_i after %0 : i2
    hw.output %u_sync_2.q_o : i2
  }
  hw.module private @prim_flop_2sync_23(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %d_i_0 = llhd.sig name "d_i" %false : i1
    %d_o = llhd.sig %false : i1
    %1 = llhd.prb %d_o : i1
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_26(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i1) -> (q_o: i1) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_26(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i1) -> (q_o: i1)
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
  hw.module private @prim_flop(in %clk_i : i1, in %rst_ni : i1, in %d_i : i11, out q_o : i11) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i11 = hw.constant 0 : i11
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %d_i_2 = llhd.sig name "d_i" %c0_i11 : i11
    %q_o = llhd.sig %c0_i11 : i11
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
      llhd.drv %q_o, %c0_i11 after %1 : i11
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %16 = llhd.prb %d_i_2 : i11
      llhd.drv %q_o, %16 after %1 : i11
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %d_i_2, %d_i after %0 : i11
    %4 = llhd.prb %q_o : i11
    hw.output %4 : i11
  }
  hw.module private @prim_flop_5(in %clk_i : i1, in %rst_ni : i1, in %d_i : i11, out q_o : i11) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i11 = hw.constant 0 : i11
    %c-1_i11 = hw.constant -1 : i11
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %d_i_2 = llhd.sig name "d_i" %c0_i11 : i11
    %q_o = llhd.sig %c0_i11 : i11
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
      llhd.drv %q_o, %c-1_i11 after %1 : i11
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %16 = llhd.prb %d_i_2 : i11
      llhd.drv %q_o, %16 after %1 : i11
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %d_i_2, %d_i after %0 : i11
    %4 = llhd.prb %q_o : i11
    hw.output %4 : i11
  }
  hw.module private @prim_flop_14(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
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
  hw.module private @prim_flop_22(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_o : i2) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i2 = hw.constant 0 : i2
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
      llhd.drv %q_o, %c0_i2 after %1 : i2
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
  hw.module private @prim_flop_25(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_o : i2) {
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
  hw.module private @prim_flop_26(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
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
    %alert_req_trigger = llhd.sig %false : i1
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
    %u_prim_buf_in_req.out_o = hw.instance "u_prim_buf_in_req" @prim_sec_anchor_buf_13(in_i: %alert_req_i: i1) -> (out_o: i1) {sv.namehint = "alert_req"}
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
    %20 = comb.or %u_prim_buf_in_req.out_o, %19 : i1
    llhd.drv %alert_req_trigger, %20 after %1 : i1
    %21 = llhd.prb %alert_clr : i1
    %22 = llhd.prb %alert_req_trigger : i1
    %23 = comb.xor %21, %true : i1
    %24 = comb.and %23, %22 : i1
    llhd.drv %alert_set_d, %24 after %1 : i1
    %25 = llhd.prb %alert_test_set_q : i1
    %26 = comb.or %alert_test_i, %25 : i1
    llhd.drv %alert_test_trigger, %26 after %1 : i1
    %27 = llhd.prb %alert_test_trigger : i1
    %28 = comb.xor %21, %true : i1
    %29 = comb.and %28, %27 : i1
    llhd.drv %alert_test_set_d, %29 after %1 : i1
    %30 = comb.or %22, %27 : i1
    llhd.drv %alert_trigger, %30 after %1 : i1
    %31 = llhd.prb %ping_set_q : i1
    %32 = comb.or %31, %u_decode_ping.event_o : i1
    llhd.drv %ping_trigger, %32 after %1 : i1
    %33 = llhd.prb %ping_clr : i1
    %34 = llhd.prb %ping_trigger : i1
    %35 = comb.xor %33, %true : i1
    %36 = comb.and %35, %34 : i1
    llhd.drv %ping_set_d, %36 after %1 : i1
    %37 = comb.and %21, %19 : i1
    %38 = llhd.prb %state_q : i3
    %39 = llhd.prb %state_d : i3
    %40 = llhd.prb %alert_trigger : i1
    %41 = llhd.prb %sigint_detected : i1
    %42 = llhd.prb %ack_level : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb25
      %44 = llhd.prb %state_q : i3
      llhd.drv %state_d, %44 after %1 : i3
      llhd.drv %alert_pd, %false after %1 : i1
      llhd.drv %alert_nd, %true after %1 : i1
      llhd.drv %ping_clr, %false after %1 : i1
      llhd.drv %alert_clr, %false after %1 : i1
      %45 = llhd.prb %state_q : i3
      %46 = comb.icmp ceq %45, %c0_i3 : i3
      cf.cond_br %46, ^bb2, ^bb4
    ^bb2:  // pred: ^bb1
      %47 = llhd.prb %alert_trigger : i1
      %48 = llhd.prb %ping_trigger : i1
      %49 = comb.or %47, %48 : i1
      cf.cond_br %49, ^bb3, ^bb23
    ^bb3:  // pred: ^bb2
      %50 = llhd.prb %alert_trigger : i1
      %51 = comb.xor %50, %true : i1
      %52 = comb.concat %false, %51, %true : i1, i1, i1
      llhd.drv %state_d, %52 after %1 : i3
      llhd.drv %alert_pd, %true after %1 : i1
      llhd.drv %alert_nd, %false after %1 : i1
      cf.br ^bb23
    ^bb4:  // pred: ^bb1
      %53 = comb.icmp ceq %45, %c1_i3 : i3
      cf.cond_br %53, ^bb5, ^bb8
    ^bb5:  // pred: ^bb4
      %54 = llhd.prb %ack_level : i1
      cf.cond_br %54, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %state_d, %c2_i3 after %1 : i3
      cf.br ^bb23
    ^bb7:  // pred: ^bb5
      llhd.drv %alert_pd, %true after %1 : i1
      llhd.drv %alert_nd, %false after %1 : i1
      cf.br ^bb23
    ^bb8:  // pred: ^bb4
      %55 = comb.icmp ceq %45, %c2_i3 : i3
      cf.cond_br %55, ^bb9, ^bb11
    ^bb9:  // pred: ^bb8
      %56 = llhd.prb %ack_level : i1
      %57 = comb.xor %56, %true : i1
      cf.cond_br %57, ^bb10, ^bb23
    ^bb10:  // pred: ^bb9
      llhd.drv %state_d, %c-3_i3 after %1 : i3
      llhd.drv %alert_clr, %true after %1 : i1
      cf.br ^bb23
    ^bb11:  // pred: ^bb8
      %58 = comb.icmp ceq %45, %c3_i3 : i3
      cf.cond_br %58, ^bb12, ^bb15
    ^bb12:  // pred: ^bb11
      %59 = llhd.prb %ack_level : i1
      cf.cond_br %59, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      llhd.drv %state_d, %c-4_i3 after %1 : i3
      cf.br ^bb23
    ^bb14:  // pred: ^bb12
      llhd.drv %alert_pd, %true after %1 : i1
      llhd.drv %alert_nd, %false after %1 : i1
      cf.br ^bb23
    ^bb15:  // pred: ^bb11
      %60 = comb.icmp ceq %45, %c-4_i3 : i3
      cf.cond_br %60, ^bb16, ^bb18
    ^bb16:  // pred: ^bb15
      %61 = llhd.prb %ack_level : i1
      %62 = comb.xor %61, %true : i1
      cf.cond_br %62, ^bb17, ^bb23
    ^bb17:  // pred: ^bb16
      llhd.drv %ping_clr, %true after %1 : i1
      llhd.drv %state_d, %c-3_i3 after %1 : i3
      cf.br ^bb23
    ^bb18:  // pred: ^bb15
      %63 = comb.icmp ceq %45, %c-3_i3 : i3
      cf.cond_br %63, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      llhd.drv %state_d, %c-2_i3 after %1 : i3
      cf.br ^bb23
    ^bb20:  // pred: ^bb18
      %64 = comb.icmp ceq %45, %c-2_i3 : i3
      cf.cond_br %64, ^bb21, ^bb22
    ^bb21:  // pred: ^bb20
      llhd.drv %state_d, %c0_i3 after %1 : i3
      cf.br ^bb23
    ^bb22:  // pred: ^bb20
      llhd.drv %state_d, %c0_i3 after %1 : i3
      cf.br ^bb23
    ^bb23:  // 13 preds: ^bb2, ^bb3, ^bb6, ^bb7, ^bb9, ^bb10, ^bb13, ^bb14, ^bb16, ^bb17, ^bb19, ^bb21, ^bb22
      %65 = llhd.prb %sigint_detected : i1
      cf.cond_br %65, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      llhd.drv %state_d, %c0_i3 after %1 : i3
      llhd.drv %alert_pd, %false after %1 : i1
      llhd.drv %alert_nd, %false after %1 : i1
      llhd.drv %ping_clr, %true after %1 : i1
      llhd.drv %alert_clr, %false after %1 : i1
      cf.br ^bb25
    ^bb25:  // 2 preds: ^bb23, ^bb24
      llhd.wait (%38, %39, %12, %11, %33, %21, %40, %34, %41, %42 : i3, i3, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %44 = llhd.prb %clk_i_0 : i1
      %45 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %46 = llhd.prb %clk_i_0 : i1
      %47 = comb.xor bin %44, %true : i1
      %48 = comb.and bin %47, %46 : i1
      %49 = llhd.prb %rst_ni_1 : i1
      %50 = comb.xor bin %49, %true : i1
      %51 = comb.and bin %45, %50 : i1
      %52 = comb.or bin %48, %51 : i1
      cf.cond_br %52, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %53 = llhd.prb %rst_ni_1 : i1
      %54 = comb.xor %53, %true : i1
      cf.cond_br %54, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %state_q, %c0_i3 after %0 : i3
      llhd.drv %alert_set_q, %false after %0 : i1
      llhd.drv %alert_test_set_q, %false after %0 : i1
      llhd.drv %ping_set_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %55 = llhd.prb %state_d : i3
      llhd.drv %state_q, %55 after %0 : i3
      %56 = llhd.prb %alert_set_d : i1
      llhd.drv %alert_set_q, %56 after %0 : i1
      %57 = llhd.prb %alert_test_set_d : i1
      llhd.drv %alert_test_set_q, %57 after %0 : i1
      %58 = llhd.prb %ping_set_d : i1
      llhd.drv %ping_set_q, %58 after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    %43 = llhd.prb %alert_tx_o : !hw.struct<alert_p: i1, alert_n: i1>
    hw.output %37, %19, %43 : i1, i1, !hw.struct<alert_p: i1, alert_n: i1>
  }
  hw.module private @prim_alert_sender_3(in %clk_i : i1, in %rst_ni : i1, in %alert_test_i : i1, in %alert_req_i : i1, out alert_ack_o : i1, out alert_state_o : i1, in %alert_rx_i : !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>, out alert_tx_o : !hw.struct<alert_p: i1, alert_n: i1>) {
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
    %u_prim_buf_in_req.out_o = hw.instance "u_prim_buf_in_req" @prim_sec_anchor_buf_13(in_i: %alert_req_i: i1) -> (out_o: i1) {sv.namehint = "alert_req"}
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
    %gen_async.i_sync_p.q_o = hw.instance "gen_async.i_sync_p" @prim_flop_2sync_4(clk_i: %2: i1, rst_ni: %3: i1, d_i: %diff_pi: i1) -> (q_o: i1)
    llhd.drv %gen_async.diff_pd, %gen_async.i_sync_p.q_o after %1 : i1
    %gen_async.i_sync_n.q_o = hw.instance "gen_async.i_sync_n" @prim_flop_2sync_23(clk_i: %2: i1, rst_ni: %3: i1, d_i: %diff_ni: i1) -> (q_o: i1)
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
  hw.module private @prim_edge_detector(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_sync_o : i2, out q_posedge_pulse_o : i2, out q_negedge_pulse_o : i2) {
    %c-1_i2 = hw.constant -1 : i2
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %q_sync_d = llhd.sig %c0_i2 : i2
    %q_sync_q = llhd.sig %c0_i2 : i2
    %g_sync.u_sync.q_o = hw.instance "g_sync.u_sync" @prim_flop_2sync_11(clk_i: %2: i1, rst_ni: %3: i1, d_i: %d_i: i2) -> (q_o: i2)
    llhd.drv %q_sync_d, %g_sync.u_sync.q_o after %1 : i2
    %4 = llhd.prb %q_sync_d : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %10 = llhd.prb %clk_i_0 : i1
      %11 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %12 = llhd.prb %clk_i_0 : i1
      %13 = comb.xor bin %10, %true : i1
      %14 = comb.and bin %13, %12 : i1
      %15 = llhd.prb %rst_ni_1 : i1
      %16 = comb.xor bin %15, %true : i1
      %17 = comb.and bin %11, %16 : i1
      %18 = comb.or bin %14, %17 : i1
      cf.cond_br %18, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %19 = llhd.prb %rst_ni_1 : i1
      %20 = comb.xor %19, %true : i1
      cf.cond_br %20, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %q_sync_q, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %21 = llhd.prb %q_sync_d : i2
      llhd.drv %q_sync_q, %21 after %0 : i2
      cf.br ^bb1
    }
    %5 = llhd.prb %q_sync_q : i2
    %6 = comb.xor %5, %c-1_i2 : i2
    %7 = comb.and %4, %6 : i2
    %8 = comb.xor %4, %c-1_i2 : i2
    %9 = comb.and %8, %5 : i2
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    hw.output %4, %7, %9 : i2, i2, i2
  }
  hw.module private @prim_edge_detector_1(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_sync_o : i1, out q_posedge_pulse_o : i1, out q_negedge_pulse_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %q_sync_d = llhd.sig %false : i1
    %q_sync_q = llhd.sig %false : i1
    %g_sync.u_sync.q_o = hw.instance "g_sync.u_sync" @prim_flop_2sync_4(clk_i: %2: i1, rst_ni: %3: i1, d_i: %d_i: i1) -> (q_o: i1)
    llhd.drv %q_sync_d, %g_sync.u_sync.q_o after %1 : i1
    %4 = llhd.prb %q_sync_d : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %10 = llhd.prb %clk_i_0 : i1
      %11 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %12 = llhd.prb %clk_i_0 : i1
      %13 = comb.xor bin %10, %true : i1
      %14 = comb.and bin %13, %12 : i1
      %15 = llhd.prb %rst_ni_1 : i1
      %16 = comb.xor bin %15, %true : i1
      %17 = comb.and bin %11, %16 : i1
      %18 = comb.or bin %14, %17 : i1
      cf.cond_br %18, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %19 = llhd.prb %rst_ni_1 : i1
      %20 = comb.xor %19, %true : i1
      cf.cond_br %20, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %q_sync_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %21 = llhd.prb %q_sync_d : i1
      llhd.drv %q_sync_q, %21 after %0 : i1
      cf.br ^bb1
    }
    %5 = llhd.prb %q_sync_q : i1
    %6 = comb.xor %5, %true : i1
    %7 = comb.and %4, %6 : i1
    %8 = comb.xor %4, %true : i1
    %9 = comb.and %8, %5 : i1
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    hw.output %4, %7, %9 : i1, i1, i1
  }
  hw.module private @prim_intr_hw(in %clk_i : i1, in %rst_ni : i1, in %event_intr_i : i1, in %reg2hw_intr_enable_q_i : i1, in %reg2hw_intr_test_q_i : i1, in %reg2hw_intr_test_qe_i : i1, in %reg2hw_intr_state_q_i : i1, out hw2reg_intr_state_de_o : i1, out hw2reg_intr_state_d_o : i1, out intr_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %reg2hw_intr_enable_q_i_2 = llhd.sig name "reg2hw_intr_enable_q_i" %false : i1
    %intr_o = llhd.sig %false : i1
    %status = llhd.sig %false : i1
    %4 = comb.and %reg2hw_intr_test_qe_i, %reg2hw_intr_test_q_i : i1
    %5 = comb.or %4, %event_intr_i {sv.namehint = "g_intr_event.new_event"} : i1
    %6 = comb.or %5, %reg2hw_intr_state_q_i : i1
    llhd.drv %status, %reg2hw_intr_state_q_i after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %8 = llhd.prb %clk_i_0 : i1
      %9 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %10 = llhd.prb %clk_i_0 : i1
      %11 = comb.xor bin %8, %true : i1
      %12 = comb.and bin %11, %10 : i1
      %13 = llhd.prb %rst_ni_1 : i1
      %14 = comb.xor bin %13, %true : i1
      %15 = comb.and bin %9, %14 : i1
      %16 = comb.or bin %12, %15 : i1
      cf.cond_br %16, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %17 = llhd.prb %rst_ni_1 : i1
      %18 = comb.xor %17, %true : i1
      cf.cond_br %18, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %intr_o, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %19 = llhd.prb %status : i1
      %20 = llhd.prb %reg2hw_intr_enable_q_i_2 : i1
      %21 = comb.and %19, %20 : i1
      llhd.drv %intr_o, %21 after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %reg2hw_intr_enable_q_i_2, %reg2hw_intr_enable_q_i after %1 : i1
    %7 = llhd.prb %intr_o : i1
    hw.output %5, %6, %7 : i1, i1, i1
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
  func.func private @"prim_mubi_pkg::mubi4_test_true_loose"(%arg0: i4) -> i1 {
    %c-7_i4 = hw.constant -7 : i4
    %0 = comb.icmp ne %arg0, %c-7_i4 : i4
    return %0 : i1
  }
  func.func private @"prim_mubi_pkg::mubi4_test_false_loose"(%arg0: i4) -> i1 {
    %c6_i4 = hw.constant 6 : i4
    %0 = comb.icmp ne %arg0, %c6_i4 : i4
    return %0 : i1
  }
  hw.module private @prim_onehot_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i29, in %addr_i : i5, in %en_i : i1, out err_o : i1) {
    %c-2_i6 = hw.constant -2 : i6
    %c-3_i6 = hw.constant -3 : i6
    %c-4_i6 = hw.constant -4 : i6
    %c-5_i6 = hw.constant -5 : i6
    %c-6_i6 = hw.constant -6 : i6
    %c-7_i6 = hw.constant -7 : i6
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
    %true = hw.constant true
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i6 = hw.constant 0 : i6
    %false = hw.constant false {sv.namehint = "addr_err"}
    %c0_i63 = hw.constant 0 : i63
    %or_tree = llhd.sig %c0_i63 : i63
    %and_tree = llhd.sig %c0_i63 : i63
    %err_tree = llhd.sig %c0_i63 : i63
    %1 = llhd.sig.extract %or_tree from %c0_i6 : <i63> -> <i1>
    %2 = llhd.prb %or_tree : i63
    %3 = comb.extract %2 from 1 : (i63) -> i1
    %4 = comb.extract %2 from 2 : (i63) -> i1
    %5 = comb.or %3, %4 : i1
    llhd.drv %1, %5 after %0 : i1
    %6 = llhd.sig.extract %and_tree from %c0_i6 : <i63> -> <i1>
    %7 = comb.extract %addr_i from 4 : (i5) -> i1
    %8 = comb.xor %7, %true : i1
    %9 = llhd.prb %and_tree : i63
    %10 = comb.extract %9 from 1 : (i63) -> i1
    %11 = comb.and %8, %10 : i1
    %12 = comb.extract %9 from 2 : (i63) -> i1
    %13 = comb.and %7, %12 : i1
    %14 = comb.or %11, %13 : i1
    llhd.drv %6, %14 after %0 : i1
    %15 = llhd.sig.extract %err_tree from %c0_i6 : <i63> -> <i1>
    %16 = comb.and %3, %4 : i1
    %17 = llhd.prb %err_tree : i63
    %18 = comb.extract %17 from 1 : (i63) -> i1
    %19 = comb.extract %17 from 2 : (i63) -> i1
    %20 = comb.or %16, %18, %19 : i1
    llhd.drv %15, %20 after %0 : i1
    %21 = llhd.sig.extract %or_tree from %c1_i6 : <i63> -> <i1>
    %22 = comb.extract %2 from 3 : (i63) -> i1
    %23 = comb.extract %2 from 4 : (i63) -> i1
    %24 = comb.or %22, %23 : i1
    llhd.drv %21, %24 after %0 : i1
    %25 = llhd.sig.extract %and_tree from %c1_i6 : <i63> -> <i1>
    %26 = comb.extract %addr_i from 3 : (i5) -> i1
    %27 = comb.xor %26, %true : i1
    %28 = comb.extract %9 from 3 : (i63) -> i1
    %29 = comb.and %27, %28 : i1
    %30 = comb.extract %9 from 4 : (i63) -> i1
    %31 = comb.and %26, %30 : i1
    %32 = comb.or %29, %31 : i1
    llhd.drv %25, %32 after %0 : i1
    %33 = llhd.sig.extract %err_tree from %c1_i6 : <i63> -> <i1>
    %34 = comb.and %22, %23 : i1
    %35 = comb.extract %17 from 3 : (i63) -> i1
    %36 = comb.extract %17 from 4 : (i63) -> i1
    %37 = comb.or %34, %35, %36 : i1
    llhd.drv %33, %37 after %0 : i1
    %38 = llhd.sig.extract %or_tree from %c2_i6 : <i63> -> <i1>
    %39 = comb.extract %2 from 5 : (i63) -> i1
    %40 = comb.extract %2 from 6 : (i63) -> i1
    %41 = comb.or %39, %40 : i1
    llhd.drv %38, %41 after %0 : i1
    %42 = llhd.sig.extract %and_tree from %c2_i6 : <i63> -> <i1>
    %43 = comb.extract %9 from 5 : (i63) -> i1
    %44 = comb.and %27, %43 : i1
    %45 = comb.extract %9 from 6 : (i63) -> i1
    %46 = comb.and %26, %45 : i1
    %47 = comb.or %44, %46 : i1
    llhd.drv %42, %47 after %0 : i1
    %48 = llhd.sig.extract %err_tree from %c2_i6 : <i63> -> <i1>
    %49 = comb.and %39, %40 : i1
    %50 = comb.extract %17 from 5 : (i63) -> i1
    %51 = comb.extract %17 from 6 : (i63) -> i1
    %52 = comb.or %49, %50, %51 : i1
    llhd.drv %48, %52 after %0 : i1
    %53 = llhd.sig.extract %or_tree from %c3_i6 : <i63> -> <i1>
    %54 = comb.extract %2 from 7 : (i63) -> i1
    %55 = comb.extract %2 from 8 : (i63) -> i1
    %56 = comb.or %54, %55 : i1
    llhd.drv %53, %56 after %0 : i1
    %57 = llhd.sig.extract %and_tree from %c3_i6 : <i63> -> <i1>
    %58 = comb.extract %addr_i from 2 : (i5) -> i1
    %59 = comb.xor %58, %true : i1
    %60 = comb.extract %9 from 7 : (i63) -> i1
    %61 = comb.and %59, %60 : i1
    %62 = comb.extract %9 from 8 : (i63) -> i1
    %63 = comb.and %58, %62 : i1
    %64 = comb.or %61, %63 : i1
    llhd.drv %57, %64 after %0 : i1
    %65 = llhd.sig.extract %err_tree from %c3_i6 : <i63> -> <i1>
    %66 = comb.and %54, %55 : i1
    %67 = comb.extract %17 from 7 : (i63) -> i1
    %68 = comb.extract %17 from 8 : (i63) -> i1
    %69 = comb.or %66, %67, %68 : i1
    llhd.drv %65, %69 after %0 : i1
    %70 = llhd.sig.extract %or_tree from %c4_i6 : <i63> -> <i1>
    %71 = comb.extract %2 from 9 : (i63) -> i1
    %72 = comb.extract %2 from 10 : (i63) -> i1
    %73 = comb.or %71, %72 : i1
    llhd.drv %70, %73 after %0 : i1
    %74 = llhd.sig.extract %and_tree from %c4_i6 : <i63> -> <i1>
    %75 = comb.extract %9 from 9 : (i63) -> i1
    %76 = comb.and %59, %75 : i1
    %77 = comb.extract %9 from 10 : (i63) -> i1
    %78 = comb.and %58, %77 : i1
    %79 = comb.or %76, %78 : i1
    llhd.drv %74, %79 after %0 : i1
    %80 = llhd.sig.extract %err_tree from %c4_i6 : <i63> -> <i1>
    %81 = comb.and %71, %72 : i1
    %82 = comb.extract %17 from 9 : (i63) -> i1
    %83 = comb.extract %17 from 10 : (i63) -> i1
    %84 = comb.or %81, %82, %83 : i1
    llhd.drv %80, %84 after %0 : i1
    %85 = llhd.sig.extract %or_tree from %c5_i6 : <i63> -> <i1>
    %86 = comb.extract %2 from 11 : (i63) -> i1
    %87 = comb.extract %2 from 12 : (i63) -> i1
    %88 = comb.or %86, %87 : i1
    llhd.drv %85, %88 after %0 : i1
    %89 = llhd.sig.extract %and_tree from %c5_i6 : <i63> -> <i1>
    %90 = comb.extract %9 from 11 : (i63) -> i1
    %91 = comb.and %59, %90 : i1
    %92 = comb.extract %9 from 12 : (i63) -> i1
    %93 = comb.and %58, %92 : i1
    %94 = comb.or %91, %93 : i1
    llhd.drv %89, %94 after %0 : i1
    %95 = llhd.sig.extract %err_tree from %c5_i6 : <i63> -> <i1>
    %96 = comb.and %86, %87 : i1
    %97 = comb.extract %17 from 11 : (i63) -> i1
    %98 = comb.extract %17 from 12 : (i63) -> i1
    %99 = comb.or %96, %97, %98 : i1
    llhd.drv %95, %99 after %0 : i1
    %100 = llhd.sig.extract %or_tree from %c6_i6 : <i63> -> <i1>
    %101 = comb.extract %2 from 13 : (i63) -> i1
    %102 = comb.extract %2 from 14 : (i63) -> i1
    %103 = comb.or %101, %102 : i1
    llhd.drv %100, %103 after %0 : i1
    %104 = llhd.sig.extract %and_tree from %c6_i6 : <i63> -> <i1>
    %105 = comb.extract %9 from 13 : (i63) -> i1
    %106 = comb.and %59, %105 : i1
    %107 = comb.extract %9 from 14 : (i63) -> i1
    %108 = comb.and %58, %107 : i1
    %109 = comb.or %106, %108 : i1
    llhd.drv %104, %109 after %0 : i1
    %110 = llhd.sig.extract %err_tree from %c6_i6 : <i63> -> <i1>
    %111 = comb.and %101, %102 : i1
    %112 = comb.extract %17 from 13 : (i63) -> i1
    %113 = comb.extract %17 from 14 : (i63) -> i1
    %114 = comb.or %111, %112, %113 : i1
    llhd.drv %110, %114 after %0 : i1
    %115 = llhd.sig.extract %or_tree from %c7_i6 : <i63> -> <i1>
    %116 = comb.extract %2 from 15 : (i63) -> i1
    %117 = comb.extract %2 from 16 : (i63) -> i1
    %118 = comb.or %116, %117 : i1
    llhd.drv %115, %118 after %0 : i1
    %119 = llhd.sig.extract %and_tree from %c7_i6 : <i63> -> <i1>
    %120 = comb.extract %addr_i from 1 : (i5) -> i1
    %121 = comb.xor %120, %true : i1
    %122 = comb.extract %9 from 15 : (i63) -> i1
    %123 = comb.and %121, %122 : i1
    %124 = comb.extract %9 from 16 : (i63) -> i1
    %125 = comb.and %120, %124 : i1
    %126 = comb.or %123, %125 : i1
    llhd.drv %119, %126 after %0 : i1
    %127 = llhd.sig.extract %err_tree from %c7_i6 : <i63> -> <i1>
    %128 = comb.and %116, %117 : i1
    %129 = comb.extract %17 from 15 : (i63) -> i1
    %130 = comb.extract %17 from 16 : (i63) -> i1
    %131 = comb.or %128, %129, %130 : i1
    llhd.drv %127, %131 after %0 : i1
    %132 = llhd.sig.extract %or_tree from %c8_i6 : <i63> -> <i1>
    %133 = comb.extract %2 from 17 : (i63) -> i1
    %134 = comb.extract %2 from 18 : (i63) -> i1
    %135 = comb.or %133, %134 : i1
    llhd.drv %132, %135 after %0 : i1
    %136 = llhd.sig.extract %and_tree from %c8_i6 : <i63> -> <i1>
    %137 = comb.extract %9 from 17 : (i63) -> i1
    %138 = comb.and %121, %137 : i1
    %139 = comb.extract %9 from 18 : (i63) -> i1
    %140 = comb.and %120, %139 : i1
    %141 = comb.or %138, %140 : i1
    llhd.drv %136, %141 after %0 : i1
    %142 = llhd.sig.extract %err_tree from %c8_i6 : <i63> -> <i1>
    %143 = comb.and %133, %134 : i1
    %144 = comb.extract %17 from 17 : (i63) -> i1
    %145 = comb.extract %17 from 18 : (i63) -> i1
    %146 = comb.or %143, %144, %145 : i1
    llhd.drv %142, %146 after %0 : i1
    %147 = llhd.sig.extract %or_tree from %c9_i6 : <i63> -> <i1>
    %148 = comb.extract %2 from 19 : (i63) -> i1
    %149 = comb.extract %2 from 20 : (i63) -> i1
    %150 = comb.or %148, %149 : i1
    llhd.drv %147, %150 after %0 : i1
    %151 = llhd.sig.extract %and_tree from %c9_i6 : <i63> -> <i1>
    %152 = comb.extract %9 from 19 : (i63) -> i1
    %153 = comb.and %121, %152 : i1
    %154 = comb.extract %9 from 20 : (i63) -> i1
    %155 = comb.and %120, %154 : i1
    %156 = comb.or %153, %155 : i1
    llhd.drv %151, %156 after %0 : i1
    %157 = llhd.sig.extract %err_tree from %c9_i6 : <i63> -> <i1>
    %158 = comb.and %148, %149 : i1
    %159 = comb.extract %17 from 19 : (i63) -> i1
    %160 = comb.extract %17 from 20 : (i63) -> i1
    %161 = comb.or %158, %159, %160 : i1
    llhd.drv %157, %161 after %0 : i1
    %162 = llhd.sig.extract %or_tree from %c10_i6 : <i63> -> <i1>
    %163 = comb.extract %2 from 21 : (i63) -> i1
    %164 = comb.extract %2 from 22 : (i63) -> i1
    %165 = comb.or %163, %164 : i1
    llhd.drv %162, %165 after %0 : i1
    %166 = llhd.sig.extract %and_tree from %c10_i6 : <i63> -> <i1>
    %167 = comb.extract %9 from 21 : (i63) -> i1
    %168 = comb.and %121, %167 : i1
    %169 = comb.extract %9 from 22 : (i63) -> i1
    %170 = comb.and %120, %169 : i1
    %171 = comb.or %168, %170 : i1
    llhd.drv %166, %171 after %0 : i1
    %172 = llhd.sig.extract %err_tree from %c10_i6 : <i63> -> <i1>
    %173 = comb.and %163, %164 : i1
    %174 = comb.extract %17 from 21 : (i63) -> i1
    %175 = comb.extract %17 from 22 : (i63) -> i1
    %176 = comb.or %173, %174, %175 : i1
    llhd.drv %172, %176 after %0 : i1
    %177 = llhd.sig.extract %or_tree from %c11_i6 : <i63> -> <i1>
    %178 = comb.extract %2 from 23 : (i63) -> i1
    %179 = comb.extract %2 from 24 : (i63) -> i1
    %180 = comb.or %178, %179 : i1
    llhd.drv %177, %180 after %0 : i1
    %181 = llhd.sig.extract %and_tree from %c11_i6 : <i63> -> <i1>
    %182 = comb.extract %9 from 23 : (i63) -> i1
    %183 = comb.and %121, %182 : i1
    %184 = comb.extract %9 from 24 : (i63) -> i1
    %185 = comb.and %120, %184 : i1
    %186 = comb.or %183, %185 : i1
    llhd.drv %181, %186 after %0 : i1
    %187 = llhd.sig.extract %err_tree from %c11_i6 : <i63> -> <i1>
    %188 = comb.and %178, %179 : i1
    %189 = comb.extract %17 from 23 : (i63) -> i1
    %190 = comb.extract %17 from 24 : (i63) -> i1
    %191 = comb.or %188, %189, %190 : i1
    llhd.drv %187, %191 after %0 : i1
    %192 = llhd.sig.extract %or_tree from %c12_i6 : <i63> -> <i1>
    %193 = comb.extract %2 from 25 : (i63) -> i1
    %194 = comb.extract %2 from 26 : (i63) -> i1
    %195 = comb.or %193, %194 : i1
    llhd.drv %192, %195 after %0 : i1
    %196 = llhd.sig.extract %and_tree from %c12_i6 : <i63> -> <i1>
    %197 = comb.extract %9 from 25 : (i63) -> i1
    %198 = comb.and %121, %197 : i1
    %199 = comb.extract %9 from 26 : (i63) -> i1
    %200 = comb.and %120, %199 : i1
    %201 = comb.or %198, %200 : i1
    llhd.drv %196, %201 after %0 : i1
    %202 = llhd.sig.extract %err_tree from %c12_i6 : <i63> -> <i1>
    %203 = comb.and %193, %194 : i1
    %204 = comb.extract %17 from 25 : (i63) -> i1
    %205 = comb.extract %17 from 26 : (i63) -> i1
    %206 = comb.or %203, %204, %205 : i1
    llhd.drv %202, %206 after %0 : i1
    %207 = llhd.sig.extract %or_tree from %c13_i6 : <i63> -> <i1>
    %208 = comb.extract %2 from 27 : (i63) -> i1
    %209 = comb.extract %2 from 28 : (i63) -> i1
    %210 = comb.or %208, %209 : i1
    llhd.drv %207, %210 after %0 : i1
    %211 = llhd.sig.extract %and_tree from %c13_i6 : <i63> -> <i1>
    %212 = comb.extract %9 from 27 : (i63) -> i1
    %213 = comb.and %121, %212 : i1
    %214 = comb.extract %9 from 28 : (i63) -> i1
    %215 = comb.and %120, %214 : i1
    %216 = comb.or %213, %215 : i1
    llhd.drv %211, %216 after %0 : i1
    %217 = llhd.sig.extract %err_tree from %c13_i6 : <i63> -> <i1>
    %218 = comb.and %208, %209 : i1
    %219 = comb.extract %17 from 27 : (i63) -> i1
    %220 = comb.extract %17 from 28 : (i63) -> i1
    %221 = comb.or %218, %219, %220 : i1
    llhd.drv %217, %221 after %0 : i1
    %222 = llhd.sig.extract %or_tree from %c14_i6 : <i63> -> <i1>
    %223 = comb.extract %2 from 29 : (i63) -> i1
    %224 = comb.extract %2 from 30 : (i63) -> i1
    %225 = comb.or %223, %224 : i1
    llhd.drv %222, %225 after %0 : i1
    %226 = llhd.sig.extract %and_tree from %c14_i6 : <i63> -> <i1>
    %227 = comb.extract %9 from 29 : (i63) -> i1
    %228 = comb.and %121, %227 : i1
    %229 = comb.extract %9 from 30 : (i63) -> i1
    %230 = comb.and %120, %229 : i1
    %231 = comb.or %228, %230 : i1
    llhd.drv %226, %231 after %0 : i1
    %232 = llhd.sig.extract %err_tree from %c14_i6 : <i63> -> <i1>
    %233 = comb.and %223, %224 : i1
    %234 = comb.extract %17 from 29 : (i63) -> i1
    %235 = comb.extract %17 from 30 : (i63) -> i1
    %236 = comb.or %233, %234, %235 : i1
    llhd.drv %232, %236 after %0 : i1
    %237 = llhd.sig.extract %or_tree from %c15_i6 : <i63> -> <i1>
    %238 = comb.extract %2 from 31 : (i63) -> i1
    %239 = comb.extract %2 from 32 : (i63) -> i1
    %240 = comb.or %238, %239 : i1
    llhd.drv %237, %240 after %0 : i1
    %241 = llhd.sig.extract %and_tree from %c15_i6 : <i63> -> <i1>
    %242 = comb.extract %addr_i from 0 : (i5) -> i1
    %243 = comb.xor %242, %true : i1
    %244 = comb.extract %9 from 31 : (i63) -> i1
    %245 = comb.and %243, %244 : i1
    %246 = comb.extract %9 from 32 : (i63) -> i1
    %247 = comb.and %242, %246 : i1
    %248 = comb.or %245, %247 : i1
    llhd.drv %241, %248 after %0 : i1
    %249 = llhd.sig.extract %err_tree from %c15_i6 : <i63> -> <i1>
    %250 = comb.and %238, %239 : i1
    %251 = comb.extract %17 from 31 : (i63) -> i1
    %252 = comb.extract %17 from 32 : (i63) -> i1
    %253 = comb.or %250, %251, %252 : i1
    llhd.drv %249, %253 after %0 : i1
    %254 = llhd.sig.extract %or_tree from %c16_i6 : <i63> -> <i1>
    %255 = comb.extract %2 from 33 : (i63) -> i1
    %256 = comb.extract %2 from 34 : (i63) -> i1
    %257 = comb.or %255, %256 : i1
    llhd.drv %254, %257 after %0 : i1
    %258 = llhd.sig.extract %and_tree from %c16_i6 : <i63> -> <i1>
    %259 = comb.extract %9 from 33 : (i63) -> i1
    %260 = comb.and %243, %259 : i1
    %261 = comb.extract %9 from 34 : (i63) -> i1
    %262 = comb.and %242, %261 : i1
    %263 = comb.or %260, %262 : i1
    llhd.drv %258, %263 after %0 : i1
    %264 = llhd.sig.extract %err_tree from %c16_i6 : <i63> -> <i1>
    %265 = comb.and %255, %256 : i1
    %266 = comb.extract %17 from 33 : (i63) -> i1
    %267 = comb.extract %17 from 34 : (i63) -> i1
    %268 = comb.or %265, %266, %267 : i1
    llhd.drv %264, %268 after %0 : i1
    %269 = llhd.sig.extract %or_tree from %c17_i6 : <i63> -> <i1>
    %270 = comb.extract %2 from 35 : (i63) -> i1
    %271 = comb.extract %2 from 36 : (i63) -> i1
    %272 = comb.or %270, %271 : i1
    llhd.drv %269, %272 after %0 : i1
    %273 = llhd.sig.extract %and_tree from %c17_i6 : <i63> -> <i1>
    %274 = comb.extract %9 from 35 : (i63) -> i1
    %275 = comb.and %243, %274 : i1
    %276 = comb.extract %9 from 36 : (i63) -> i1
    %277 = comb.and %242, %276 : i1
    %278 = comb.or %275, %277 : i1
    llhd.drv %273, %278 after %0 : i1
    %279 = llhd.sig.extract %err_tree from %c17_i6 : <i63> -> <i1>
    %280 = comb.and %270, %271 : i1
    %281 = comb.extract %17 from 35 : (i63) -> i1
    %282 = comb.extract %17 from 36 : (i63) -> i1
    %283 = comb.or %280, %281, %282 : i1
    llhd.drv %279, %283 after %0 : i1
    %284 = llhd.sig.extract %or_tree from %c18_i6 : <i63> -> <i1>
    %285 = comb.extract %2 from 37 : (i63) -> i1
    %286 = comb.extract %2 from 38 : (i63) -> i1
    %287 = comb.or %285, %286 : i1
    llhd.drv %284, %287 after %0 : i1
    %288 = llhd.sig.extract %and_tree from %c18_i6 : <i63> -> <i1>
    %289 = comb.extract %9 from 37 : (i63) -> i1
    %290 = comb.and %243, %289 : i1
    %291 = comb.extract %9 from 38 : (i63) -> i1
    %292 = comb.and %242, %291 : i1
    %293 = comb.or %290, %292 : i1
    llhd.drv %288, %293 after %0 : i1
    %294 = llhd.sig.extract %err_tree from %c18_i6 : <i63> -> <i1>
    %295 = comb.and %285, %286 : i1
    %296 = comb.extract %17 from 37 : (i63) -> i1
    %297 = comb.extract %17 from 38 : (i63) -> i1
    %298 = comb.or %295, %296, %297 : i1
    llhd.drv %294, %298 after %0 : i1
    %299 = llhd.sig.extract %or_tree from %c19_i6 : <i63> -> <i1>
    %300 = comb.extract %2 from 39 : (i63) -> i1
    %301 = comb.extract %2 from 40 : (i63) -> i1
    %302 = comb.or %300, %301 : i1
    llhd.drv %299, %302 after %0 : i1
    %303 = llhd.sig.extract %and_tree from %c19_i6 : <i63> -> <i1>
    %304 = comb.extract %9 from 39 : (i63) -> i1
    %305 = comb.and %243, %304 : i1
    %306 = comb.extract %9 from 40 : (i63) -> i1
    %307 = comb.and %242, %306 : i1
    %308 = comb.or %305, %307 : i1
    llhd.drv %303, %308 after %0 : i1
    %309 = llhd.sig.extract %err_tree from %c19_i6 : <i63> -> <i1>
    %310 = comb.and %300, %301 : i1
    %311 = comb.extract %17 from 39 : (i63) -> i1
    %312 = comb.extract %17 from 40 : (i63) -> i1
    %313 = comb.or %310, %311, %312 : i1
    llhd.drv %309, %313 after %0 : i1
    %314 = llhd.sig.extract %or_tree from %c20_i6 : <i63> -> <i1>
    %315 = comb.extract %2 from 41 : (i63) -> i1
    %316 = comb.extract %2 from 42 : (i63) -> i1
    %317 = comb.or %315, %316 : i1
    llhd.drv %314, %317 after %0 : i1
    %318 = llhd.sig.extract %and_tree from %c20_i6 : <i63> -> <i1>
    %319 = comb.extract %9 from 41 : (i63) -> i1
    %320 = comb.and %243, %319 : i1
    %321 = comb.extract %9 from 42 : (i63) -> i1
    %322 = comb.and %242, %321 : i1
    %323 = comb.or %320, %322 : i1
    llhd.drv %318, %323 after %0 : i1
    %324 = llhd.sig.extract %err_tree from %c20_i6 : <i63> -> <i1>
    %325 = comb.and %315, %316 : i1
    %326 = comb.extract %17 from 41 : (i63) -> i1
    %327 = comb.extract %17 from 42 : (i63) -> i1
    %328 = comb.or %325, %326, %327 : i1
    llhd.drv %324, %328 after %0 : i1
    %329 = llhd.sig.extract %or_tree from %c21_i6 : <i63> -> <i1>
    %330 = comb.extract %2 from 43 : (i63) -> i1
    %331 = comb.extract %2 from 44 : (i63) -> i1
    %332 = comb.or %330, %331 : i1
    llhd.drv %329, %332 after %0 : i1
    %333 = llhd.sig.extract %and_tree from %c21_i6 : <i63> -> <i1>
    %334 = comb.extract %9 from 43 : (i63) -> i1
    %335 = comb.and %243, %334 : i1
    %336 = comb.extract %9 from 44 : (i63) -> i1
    %337 = comb.and %242, %336 : i1
    %338 = comb.or %335, %337 : i1
    llhd.drv %333, %338 after %0 : i1
    %339 = llhd.sig.extract %err_tree from %c21_i6 : <i63> -> <i1>
    %340 = comb.and %330, %331 : i1
    %341 = comb.extract %17 from 43 : (i63) -> i1
    %342 = comb.extract %17 from 44 : (i63) -> i1
    %343 = comb.or %340, %341, %342 : i1
    llhd.drv %339, %343 after %0 : i1
    %344 = llhd.sig.extract %or_tree from %c22_i6 : <i63> -> <i1>
    %345 = comb.extract %2 from 45 : (i63) -> i1
    %346 = comb.extract %2 from 46 : (i63) -> i1
    %347 = comb.or %345, %346 : i1
    llhd.drv %344, %347 after %0 : i1
    %348 = llhd.sig.extract %and_tree from %c22_i6 : <i63> -> <i1>
    %349 = comb.extract %9 from 45 : (i63) -> i1
    %350 = comb.and %243, %349 : i1
    %351 = comb.extract %9 from 46 : (i63) -> i1
    %352 = comb.and %242, %351 : i1
    %353 = comb.or %350, %352 : i1
    llhd.drv %348, %353 after %0 : i1
    %354 = llhd.sig.extract %err_tree from %c22_i6 : <i63> -> <i1>
    %355 = comb.and %345, %346 : i1
    %356 = comb.extract %17 from 45 : (i63) -> i1
    %357 = comb.extract %17 from 46 : (i63) -> i1
    %358 = comb.or %355, %356, %357 : i1
    llhd.drv %354, %358 after %0 : i1
    %359 = llhd.sig.extract %or_tree from %c23_i6 : <i63> -> <i1>
    %360 = comb.extract %2 from 47 : (i63) -> i1
    %361 = comb.extract %2 from 48 : (i63) -> i1
    %362 = comb.or %360, %361 : i1
    llhd.drv %359, %362 after %0 : i1
    %363 = llhd.sig.extract %and_tree from %c23_i6 : <i63> -> <i1>
    %364 = comb.extract %9 from 47 : (i63) -> i1
    %365 = comb.and %243, %364 : i1
    %366 = comb.extract %9 from 48 : (i63) -> i1
    %367 = comb.and %242, %366 : i1
    %368 = comb.or %365, %367 : i1
    llhd.drv %363, %368 after %0 : i1
    %369 = llhd.sig.extract %err_tree from %c23_i6 : <i63> -> <i1>
    %370 = comb.and %360, %361 : i1
    %371 = comb.extract %17 from 47 : (i63) -> i1
    %372 = comb.extract %17 from 48 : (i63) -> i1
    %373 = comb.or %370, %371, %372 : i1
    llhd.drv %369, %373 after %0 : i1
    %374 = llhd.sig.extract %or_tree from %c24_i6 : <i63> -> <i1>
    %375 = comb.extract %2 from 49 : (i63) -> i1
    %376 = comb.extract %2 from 50 : (i63) -> i1
    %377 = comb.or %375, %376 : i1
    llhd.drv %374, %377 after %0 : i1
    %378 = llhd.sig.extract %and_tree from %c24_i6 : <i63> -> <i1>
    %379 = comb.extract %9 from 49 : (i63) -> i1
    %380 = comb.and %243, %379 : i1
    %381 = comb.extract %9 from 50 : (i63) -> i1
    %382 = comb.and %242, %381 : i1
    %383 = comb.or %380, %382 : i1
    llhd.drv %378, %383 after %0 : i1
    %384 = llhd.sig.extract %err_tree from %c24_i6 : <i63> -> <i1>
    %385 = comb.and %375, %376 : i1
    %386 = comb.extract %17 from 49 : (i63) -> i1
    %387 = comb.extract %17 from 50 : (i63) -> i1
    %388 = comb.or %385, %386, %387 : i1
    llhd.drv %384, %388 after %0 : i1
    %389 = llhd.sig.extract %or_tree from %c25_i6 : <i63> -> <i1>
    %390 = comb.extract %2 from 51 : (i63) -> i1
    %391 = comb.extract %2 from 52 : (i63) -> i1
    %392 = comb.or %390, %391 : i1
    llhd.drv %389, %392 after %0 : i1
    %393 = llhd.sig.extract %and_tree from %c25_i6 : <i63> -> <i1>
    %394 = comb.extract %9 from 51 : (i63) -> i1
    %395 = comb.and %243, %394 : i1
    %396 = comb.extract %9 from 52 : (i63) -> i1
    %397 = comb.and %242, %396 : i1
    %398 = comb.or %395, %397 : i1
    llhd.drv %393, %398 after %0 : i1
    %399 = llhd.sig.extract %err_tree from %c25_i6 : <i63> -> <i1>
    %400 = comb.and %390, %391 : i1
    %401 = comb.extract %17 from 51 : (i63) -> i1
    %402 = comb.extract %17 from 52 : (i63) -> i1
    %403 = comb.or %400, %401, %402 : i1
    llhd.drv %399, %403 after %0 : i1
    %404 = llhd.sig.extract %or_tree from %c26_i6 : <i63> -> <i1>
    %405 = comb.extract %2 from 53 : (i63) -> i1
    %406 = comb.extract %2 from 54 : (i63) -> i1
    %407 = comb.or %405, %406 : i1
    llhd.drv %404, %407 after %0 : i1
    %408 = llhd.sig.extract %and_tree from %c26_i6 : <i63> -> <i1>
    %409 = comb.extract %9 from 53 : (i63) -> i1
    %410 = comb.and %243, %409 : i1
    %411 = comb.extract %9 from 54 : (i63) -> i1
    %412 = comb.and %242, %411 : i1
    %413 = comb.or %410, %412 : i1
    llhd.drv %408, %413 after %0 : i1
    %414 = llhd.sig.extract %err_tree from %c26_i6 : <i63> -> <i1>
    %415 = comb.and %405, %406 : i1
    %416 = comb.extract %17 from 53 : (i63) -> i1
    %417 = comb.extract %17 from 54 : (i63) -> i1
    %418 = comb.or %415, %416, %417 : i1
    llhd.drv %414, %418 after %0 : i1
    %419 = llhd.sig.extract %or_tree from %c27_i6 : <i63> -> <i1>
    %420 = comb.extract %2 from 55 : (i63) -> i1
    %421 = comb.extract %2 from 56 : (i63) -> i1
    %422 = comb.or %420, %421 : i1
    llhd.drv %419, %422 after %0 : i1
    %423 = llhd.sig.extract %and_tree from %c27_i6 : <i63> -> <i1>
    %424 = comb.extract %9 from 55 : (i63) -> i1
    %425 = comb.and %243, %424 : i1
    %426 = comb.extract %9 from 56 : (i63) -> i1
    %427 = comb.and %242, %426 : i1
    %428 = comb.or %425, %427 : i1
    llhd.drv %423, %428 after %0 : i1
    %429 = llhd.sig.extract %err_tree from %c27_i6 : <i63> -> <i1>
    %430 = comb.and %420, %421 : i1
    %431 = comb.extract %17 from 55 : (i63) -> i1
    %432 = comb.extract %17 from 56 : (i63) -> i1
    %433 = comb.or %430, %431, %432 : i1
    llhd.drv %429, %433 after %0 : i1
    %434 = llhd.sig.extract %or_tree from %c28_i6 : <i63> -> <i1>
    %435 = comb.extract %2 from 57 : (i63) -> i1
    %436 = comb.extract %2 from 58 : (i63) -> i1
    %437 = comb.or %435, %436 : i1
    llhd.drv %434, %437 after %0 : i1
    %438 = llhd.sig.extract %and_tree from %c28_i6 : <i63> -> <i1>
    %439 = comb.extract %9 from 57 : (i63) -> i1
    %440 = comb.and %243, %439 : i1
    %441 = comb.extract %9 from 58 : (i63) -> i1
    %442 = comb.and %242, %441 : i1
    %443 = comb.or %440, %442 : i1
    llhd.drv %438, %443 after %0 : i1
    %444 = llhd.sig.extract %err_tree from %c28_i6 : <i63> -> <i1>
    %445 = comb.and %435, %436 : i1
    %446 = comb.extract %17 from 57 : (i63) -> i1
    %447 = comb.extract %17 from 58 : (i63) -> i1
    %448 = comb.or %445, %446, %447 : i1
    llhd.drv %444, %448 after %0 : i1
    %449 = llhd.sig.extract %or_tree from %c29_i6 : <i63> -> <i1>
    %450 = comb.extract %2 from 59 : (i63) -> i1
    %451 = comb.extract %2 from 60 : (i63) -> i1
    %452 = comb.or %450, %451 : i1
    llhd.drv %449, %452 after %0 : i1
    %453 = llhd.sig.extract %and_tree from %c29_i6 : <i63> -> <i1>
    %454 = comb.extract %9 from 59 : (i63) -> i1
    %455 = comb.and %243, %454 : i1
    %456 = comb.extract %9 from 60 : (i63) -> i1
    %457 = comb.and %242, %456 : i1
    %458 = comb.or %455, %457 : i1
    llhd.drv %453, %458 after %0 : i1
    %459 = llhd.sig.extract %err_tree from %c29_i6 : <i63> -> <i1>
    %460 = comb.and %450, %451 : i1
    %461 = comb.extract %17 from 59 : (i63) -> i1
    %462 = comb.extract %17 from 60 : (i63) -> i1
    %463 = comb.or %460, %461, %462 : i1
    llhd.drv %459, %463 after %0 : i1
    %464 = llhd.sig.extract %or_tree from %c30_i6 : <i63> -> <i1>
    %465 = comb.extract %2 from 61 : (i63) -> i1
    %466 = comb.extract %2 from 62 : (i63) -> i1
    %467 = comb.or %465, %466 : i1
    llhd.drv %464, %467 after %0 : i1
    %468 = llhd.sig.extract %and_tree from %c30_i6 : <i63> -> <i1>
    %469 = comb.extract %9 from 61 : (i63) -> i1
    %470 = comb.and %243, %469 : i1
    %471 = comb.extract %9 from 62 : (i63) -> i1
    %472 = comb.and %242, %471 : i1
    %473 = comb.or %470, %472 : i1
    llhd.drv %468, %473 after %0 : i1
    %474 = llhd.sig.extract %err_tree from %c30_i6 : <i63> -> <i1>
    %475 = comb.and %465, %466 : i1
    %476 = comb.extract %17 from 61 : (i63) -> i1
    %477 = comb.extract %17 from 62 : (i63) -> i1
    %478 = comb.or %475, %476, %477 : i1
    llhd.drv %474, %478 after %0 : i1
    %479 = llhd.sig.extract %or_tree from %c31_i6 : <i63> -> <i1>
    %480 = comb.extract %oh_i from 0 : (i29) -> i1
    llhd.drv %479, %480 after %0 : i1
    %481 = llhd.sig.extract %and_tree from %c31_i6 : <i63> -> <i1>
    llhd.drv %481, %480 after %0 : i1
    %482 = llhd.sig.extract %err_tree from %c31_i6 : <i63> -> <i1>
    llhd.drv %482, %false after %0 : i1
    %483 = llhd.sig.extract %or_tree from %c-32_i6 : <i63> -> <i1>
    %484 = comb.extract %oh_i from 1 : (i29) -> i1
    llhd.drv %483, %484 after %0 : i1
    %485 = llhd.sig.extract %and_tree from %c-32_i6 : <i63> -> <i1>
    llhd.drv %485, %484 after %0 : i1
    %486 = llhd.sig.extract %err_tree from %c-32_i6 : <i63> -> <i1>
    llhd.drv %486, %false after %0 : i1
    %487 = llhd.sig.extract %or_tree from %c-31_i6 : <i63> -> <i1>
    %488 = comb.extract %oh_i from 2 : (i29) -> i1
    llhd.drv %487, %488 after %0 : i1
    %489 = llhd.sig.extract %and_tree from %c-31_i6 : <i63> -> <i1>
    llhd.drv %489, %488 after %0 : i1
    %490 = llhd.sig.extract %err_tree from %c-31_i6 : <i63> -> <i1>
    llhd.drv %490, %false after %0 : i1
    %491 = llhd.sig.extract %or_tree from %c-30_i6 : <i63> -> <i1>
    %492 = comb.extract %oh_i from 3 : (i29) -> i1
    llhd.drv %491, %492 after %0 : i1
    %493 = llhd.sig.extract %and_tree from %c-30_i6 : <i63> -> <i1>
    llhd.drv %493, %492 after %0 : i1
    %494 = llhd.sig.extract %err_tree from %c-30_i6 : <i63> -> <i1>
    llhd.drv %494, %false after %0 : i1
    %495 = llhd.sig.extract %or_tree from %c-29_i6 : <i63> -> <i1>
    %496 = comb.extract %oh_i from 4 : (i29) -> i1
    llhd.drv %495, %496 after %0 : i1
    %497 = llhd.sig.extract %and_tree from %c-29_i6 : <i63> -> <i1>
    llhd.drv %497, %496 after %0 : i1
    %498 = llhd.sig.extract %err_tree from %c-29_i6 : <i63> -> <i1>
    llhd.drv %498, %false after %0 : i1
    %499 = llhd.sig.extract %or_tree from %c-28_i6 : <i63> -> <i1>
    %500 = comb.extract %oh_i from 5 : (i29) -> i1
    llhd.drv %499, %500 after %0 : i1
    %501 = llhd.sig.extract %and_tree from %c-28_i6 : <i63> -> <i1>
    llhd.drv %501, %500 after %0 : i1
    %502 = llhd.sig.extract %err_tree from %c-28_i6 : <i63> -> <i1>
    llhd.drv %502, %false after %0 : i1
    %503 = llhd.sig.extract %or_tree from %c-27_i6 : <i63> -> <i1>
    %504 = comb.extract %oh_i from 6 : (i29) -> i1
    llhd.drv %503, %504 after %0 : i1
    %505 = llhd.sig.extract %and_tree from %c-27_i6 : <i63> -> <i1>
    llhd.drv %505, %504 after %0 : i1
    %506 = llhd.sig.extract %err_tree from %c-27_i6 : <i63> -> <i1>
    llhd.drv %506, %false after %0 : i1
    %507 = llhd.sig.extract %or_tree from %c-26_i6 : <i63> -> <i1>
    %508 = comb.extract %oh_i from 7 : (i29) -> i1
    llhd.drv %507, %508 after %0 : i1
    %509 = llhd.sig.extract %and_tree from %c-26_i6 : <i63> -> <i1>
    llhd.drv %509, %508 after %0 : i1
    %510 = llhd.sig.extract %err_tree from %c-26_i6 : <i63> -> <i1>
    llhd.drv %510, %false after %0 : i1
    %511 = llhd.sig.extract %or_tree from %c-25_i6 : <i63> -> <i1>
    %512 = comb.extract %oh_i from 8 : (i29) -> i1
    llhd.drv %511, %512 after %0 : i1
    %513 = llhd.sig.extract %and_tree from %c-25_i6 : <i63> -> <i1>
    llhd.drv %513, %512 after %0 : i1
    %514 = llhd.sig.extract %err_tree from %c-25_i6 : <i63> -> <i1>
    llhd.drv %514, %false after %0 : i1
    %515 = llhd.sig.extract %or_tree from %c-24_i6 : <i63> -> <i1>
    %516 = comb.extract %oh_i from 9 : (i29) -> i1
    llhd.drv %515, %516 after %0 : i1
    %517 = llhd.sig.extract %and_tree from %c-24_i6 : <i63> -> <i1>
    llhd.drv %517, %516 after %0 : i1
    %518 = llhd.sig.extract %err_tree from %c-24_i6 : <i63> -> <i1>
    llhd.drv %518, %false after %0 : i1
    %519 = llhd.sig.extract %or_tree from %c-23_i6 : <i63> -> <i1>
    %520 = comb.extract %oh_i from 10 : (i29) -> i1
    llhd.drv %519, %520 after %0 : i1
    %521 = llhd.sig.extract %and_tree from %c-23_i6 : <i63> -> <i1>
    llhd.drv %521, %520 after %0 : i1
    %522 = llhd.sig.extract %err_tree from %c-23_i6 : <i63> -> <i1>
    llhd.drv %522, %false after %0 : i1
    %523 = llhd.sig.extract %or_tree from %c-22_i6 : <i63> -> <i1>
    %524 = comb.extract %oh_i from 11 : (i29) -> i1
    llhd.drv %523, %524 after %0 : i1
    %525 = llhd.sig.extract %and_tree from %c-22_i6 : <i63> -> <i1>
    llhd.drv %525, %524 after %0 : i1
    %526 = llhd.sig.extract %err_tree from %c-22_i6 : <i63> -> <i1>
    llhd.drv %526, %false after %0 : i1
    %527 = llhd.sig.extract %or_tree from %c-21_i6 : <i63> -> <i1>
    %528 = comb.extract %oh_i from 12 : (i29) -> i1
    llhd.drv %527, %528 after %0 : i1
    %529 = llhd.sig.extract %and_tree from %c-21_i6 : <i63> -> <i1>
    llhd.drv %529, %528 after %0 : i1
    %530 = llhd.sig.extract %err_tree from %c-21_i6 : <i63> -> <i1>
    llhd.drv %530, %false after %0 : i1
    %531 = llhd.sig.extract %or_tree from %c-20_i6 : <i63> -> <i1>
    %532 = comb.extract %oh_i from 13 : (i29) -> i1
    llhd.drv %531, %532 after %0 : i1
    %533 = llhd.sig.extract %and_tree from %c-20_i6 : <i63> -> <i1>
    llhd.drv %533, %532 after %0 : i1
    %534 = llhd.sig.extract %err_tree from %c-20_i6 : <i63> -> <i1>
    llhd.drv %534, %false after %0 : i1
    %535 = llhd.sig.extract %or_tree from %c-19_i6 : <i63> -> <i1>
    %536 = comb.extract %oh_i from 14 : (i29) -> i1
    llhd.drv %535, %536 after %0 : i1
    %537 = llhd.sig.extract %and_tree from %c-19_i6 : <i63> -> <i1>
    llhd.drv %537, %536 after %0 : i1
    %538 = llhd.sig.extract %err_tree from %c-19_i6 : <i63> -> <i1>
    llhd.drv %538, %false after %0 : i1
    %539 = llhd.sig.extract %or_tree from %c-18_i6 : <i63> -> <i1>
    %540 = comb.extract %oh_i from 15 : (i29) -> i1
    llhd.drv %539, %540 after %0 : i1
    %541 = llhd.sig.extract %and_tree from %c-18_i6 : <i63> -> <i1>
    llhd.drv %541, %540 after %0 : i1
    %542 = llhd.sig.extract %err_tree from %c-18_i6 : <i63> -> <i1>
    llhd.drv %542, %false after %0 : i1
    %543 = llhd.sig.extract %or_tree from %c-17_i6 : <i63> -> <i1>
    %544 = comb.extract %oh_i from 16 : (i29) -> i1
    llhd.drv %543, %544 after %0 : i1
    %545 = llhd.sig.extract %and_tree from %c-17_i6 : <i63> -> <i1>
    llhd.drv %545, %544 after %0 : i1
    %546 = llhd.sig.extract %err_tree from %c-17_i6 : <i63> -> <i1>
    llhd.drv %546, %false after %0 : i1
    %547 = llhd.sig.extract %or_tree from %c-16_i6 : <i63> -> <i1>
    %548 = comb.extract %oh_i from 17 : (i29) -> i1
    llhd.drv %547, %548 after %0 : i1
    %549 = llhd.sig.extract %and_tree from %c-16_i6 : <i63> -> <i1>
    llhd.drv %549, %548 after %0 : i1
    %550 = llhd.sig.extract %err_tree from %c-16_i6 : <i63> -> <i1>
    llhd.drv %550, %false after %0 : i1
    %551 = llhd.sig.extract %or_tree from %c-15_i6 : <i63> -> <i1>
    %552 = comb.extract %oh_i from 18 : (i29) -> i1
    llhd.drv %551, %552 after %0 : i1
    %553 = llhd.sig.extract %and_tree from %c-15_i6 : <i63> -> <i1>
    llhd.drv %553, %552 after %0 : i1
    %554 = llhd.sig.extract %err_tree from %c-15_i6 : <i63> -> <i1>
    llhd.drv %554, %false after %0 : i1
    %555 = llhd.sig.extract %or_tree from %c-14_i6 : <i63> -> <i1>
    %556 = comb.extract %oh_i from 19 : (i29) -> i1
    llhd.drv %555, %556 after %0 : i1
    %557 = llhd.sig.extract %and_tree from %c-14_i6 : <i63> -> <i1>
    llhd.drv %557, %556 after %0 : i1
    %558 = llhd.sig.extract %err_tree from %c-14_i6 : <i63> -> <i1>
    llhd.drv %558, %false after %0 : i1
    %559 = llhd.sig.extract %or_tree from %c-13_i6 : <i63> -> <i1>
    %560 = comb.extract %oh_i from 20 : (i29) -> i1
    llhd.drv %559, %560 after %0 : i1
    %561 = llhd.sig.extract %and_tree from %c-13_i6 : <i63> -> <i1>
    llhd.drv %561, %560 after %0 : i1
    %562 = llhd.sig.extract %err_tree from %c-13_i6 : <i63> -> <i1>
    llhd.drv %562, %false after %0 : i1
    %563 = llhd.sig.extract %or_tree from %c-12_i6 : <i63> -> <i1>
    %564 = comb.extract %oh_i from 21 : (i29) -> i1
    llhd.drv %563, %564 after %0 : i1
    %565 = llhd.sig.extract %and_tree from %c-12_i6 : <i63> -> <i1>
    llhd.drv %565, %564 after %0 : i1
    %566 = llhd.sig.extract %err_tree from %c-12_i6 : <i63> -> <i1>
    llhd.drv %566, %false after %0 : i1
    %567 = llhd.sig.extract %or_tree from %c-11_i6 : <i63> -> <i1>
    %568 = comb.extract %oh_i from 22 : (i29) -> i1
    llhd.drv %567, %568 after %0 : i1
    %569 = llhd.sig.extract %and_tree from %c-11_i6 : <i63> -> <i1>
    llhd.drv %569, %568 after %0 : i1
    %570 = llhd.sig.extract %err_tree from %c-11_i6 : <i63> -> <i1>
    llhd.drv %570, %false after %0 : i1
    %571 = llhd.sig.extract %or_tree from %c-10_i6 : <i63> -> <i1>
    %572 = comb.extract %oh_i from 23 : (i29) -> i1
    llhd.drv %571, %572 after %0 : i1
    %573 = llhd.sig.extract %and_tree from %c-10_i6 : <i63> -> <i1>
    llhd.drv %573, %572 after %0 : i1
    %574 = llhd.sig.extract %err_tree from %c-10_i6 : <i63> -> <i1>
    llhd.drv %574, %false after %0 : i1
    %575 = llhd.sig.extract %or_tree from %c-9_i6 : <i63> -> <i1>
    %576 = comb.extract %oh_i from 24 : (i29) -> i1
    llhd.drv %575, %576 after %0 : i1
    %577 = llhd.sig.extract %and_tree from %c-9_i6 : <i63> -> <i1>
    llhd.drv %577, %576 after %0 : i1
    %578 = llhd.sig.extract %err_tree from %c-9_i6 : <i63> -> <i1>
    llhd.drv %578, %false after %0 : i1
    %579 = llhd.sig.extract %or_tree from %c-8_i6 : <i63> -> <i1>
    %580 = comb.extract %oh_i from 25 : (i29) -> i1
    llhd.drv %579, %580 after %0 : i1
    %581 = llhd.sig.extract %and_tree from %c-8_i6 : <i63> -> <i1>
    llhd.drv %581, %580 after %0 : i1
    %582 = llhd.sig.extract %err_tree from %c-8_i6 : <i63> -> <i1>
    llhd.drv %582, %false after %0 : i1
    %583 = llhd.sig.extract %or_tree from %c-7_i6 : <i63> -> <i1>
    %584 = comb.extract %oh_i from 26 : (i29) -> i1
    llhd.drv %583, %584 after %0 : i1
    %585 = llhd.sig.extract %and_tree from %c-7_i6 : <i63> -> <i1>
    llhd.drv %585, %584 after %0 : i1
    %586 = llhd.sig.extract %err_tree from %c-7_i6 : <i63> -> <i1>
    llhd.drv %586, %false after %0 : i1
    %587 = llhd.sig.extract %or_tree from %c-6_i6 : <i63> -> <i1>
    %588 = comb.extract %oh_i from 27 : (i29) -> i1
    llhd.drv %587, %588 after %0 : i1
    %589 = llhd.sig.extract %and_tree from %c-6_i6 : <i63> -> <i1>
    llhd.drv %589, %588 after %0 : i1
    %590 = llhd.sig.extract %err_tree from %c-6_i6 : <i63> -> <i1>
    llhd.drv %590, %false after %0 : i1
    %591 = llhd.sig.extract %or_tree from %c-5_i6 : <i63> -> <i1>
    %592 = comb.extract %oh_i from 28 : (i29) -> i1
    llhd.drv %591, %592 after %0 : i1
    %593 = llhd.sig.extract %and_tree from %c-5_i6 : <i63> -> <i1>
    llhd.drv %593, %592 after %0 : i1
    %594 = llhd.sig.extract %err_tree from %c-5_i6 : <i63> -> <i1>
    llhd.drv %594, %false after %0 : i1
    %595 = llhd.sig.extract %or_tree from %c-4_i6 : <i63> -> <i1>
    llhd.drv %595, %false after %0 : i1
    %596 = llhd.sig.extract %and_tree from %c-4_i6 : <i63> -> <i1>
    llhd.drv %596, %false after %0 : i1
    %597 = llhd.sig.extract %err_tree from %c-4_i6 : <i63> -> <i1>
    llhd.drv %597, %false after %0 : i1
    %598 = llhd.sig.extract %or_tree from %c-3_i6 : <i63> -> <i1>
    llhd.drv %598, %false after %0 : i1
    %599 = llhd.sig.extract %and_tree from %c-3_i6 : <i63> -> <i1>
    llhd.drv %599, %false after %0 : i1
    %600 = llhd.sig.extract %err_tree from %c-3_i6 : <i63> -> <i1>
    llhd.drv %600, %false after %0 : i1
    %601 = llhd.sig.extract %or_tree from %c-2_i6 : <i63> -> <i1>
    llhd.drv %601, %false after %0 : i1
    %602 = llhd.sig.extract %and_tree from %c-2_i6 : <i63> -> <i1>
    llhd.drv %602, %false after %0 : i1
    %603 = llhd.sig.extract %err_tree from %c-2_i6 : <i63> -> <i1>
    llhd.drv %603, %false after %0 : i1
    %604 = comb.or %605, %608 : i1
    %605 = comb.extract %17 from 0 {sv.namehint = "oh0_err"} : (i63) -> i1
    %606 = comb.xor %en_i, %true : i1
    %607 = comb.extract %2 from 0 : (i63) -> i1
    %608 = comb.and %606, %607 {sv.namehint = "enable_err"} : i1
    hw.output %604 : i1
  }
  hw.module private @prim_reg_we_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i29, in %en_i : i1, out err_o : i1) {
    %c0_i5 = hw.constant 0 : i5
    %u_prim_buf.out_o = hw.instance "u_prim_buf" @prim_buf_15(in_i: %oh_i: i29) -> (out_o: i29) {sv.namehint = "oh_buf"}
    %u_prim_onehot_check.err_o = hw.instance "u_prim_onehot_check" @prim_onehot_check(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, oh_i: %u_prim_buf.out_o: i29, addr_i: %c0_i5: i5, en_i: %en_i: i1) -> (err_o: i1)
    hw.output %u_prim_onehot_check.err_o : i1
  }
  hw.module private @prim_sec_anchor_buf(in %in_i : i2, out out_o : i2) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf(in_i: %in_i: i2) -> (out_o: i2)
    hw.output %u_secure_anchor_buf.out_o : i2
  }
  hw.module private @prim_sec_anchor_buf_2(in %in_i : i11, out out_o : i11) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf_12(in_i: %in_i: i11) -> (out_o: i11)
    hw.output %u_secure_anchor_buf.out_o : i11
  }
  hw.module private @prim_sec_anchor_buf_13(in %in_i : i1, out out_o : i1) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf_24(in_i: %in_i: i1) -> (out_o: i1)
    hw.output %u_secure_anchor_buf.out_o : i1
  }
  hw.module private @prim_sec_anchor_flop(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_o : i2) {
    %u_secure_anchor_flop.q_o = hw.instance "u_secure_anchor_flop" @prim_flop_25(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %d_i: i2) -> (q_o: i2)
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
    %6 = comb.xor %5, %true : i1
    %7 = comb.xor %we, %true : i1
    %8 = comb.or %7, %6 : i1
    %9 = comb.and %4, %8 : i1
    llhd.drv %wd_0, %wd after %0 : i1
    llhd.drv %d_1, %d after %0 : i1
    llhd.drv %q_2, %q after %0 : i1
    hw.output %1, %9 : i1, i1
  }
  hw.module private @prim_subreg_arb_17(in %we : i1, in %wd : i1, in %de : i1, in %d : i1, in %q : i1, out wr_en : i1, out wr_data : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %wd_0 = llhd.sig name "wd" %false : i1
    %d_1 = llhd.sig name "d" %false : i1
    %1 = comb.or %we, %de : i1
    %2 = llhd.prb %wd_0 : i1
    %3 = llhd.prb %d_1 : i1
    %4 = comb.mux %we, %2, %3 : i1
    llhd.drv %wd_0, %wd after %0 : i1
    llhd.drv %d_1, %d after %0 : i1
    hw.output %1, %4 : i1, i1
  }
  hw.module private @prim_subreg_arb_18(in %we : i1, in %wd : i1, in %de : i1, in %d : i1, in %q : i1, out wr_en : i1, out wr_data : i1) {
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
  hw.module private @prim_subreg_arb_19(in %we : i1, in %wd : i4, in %de : i1, in %d : i4, in %q : i4, out wr_en : i1, out wr_data : i4) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %wd_0 = llhd.sig name "wd" %c0_i4 : i4
    %d_1 = llhd.sig name "d" %c0_i4 : i4
    %1 = comb.or %we, %de : i1
    %2 = llhd.prb %wd_0 : i4
    %3 = llhd.prb %d_1 : i4
    %4 = comb.mux %we, %2, %3 : i4
    llhd.drv %wd_0, %wd after %0 : i4
    llhd.drv %d_1, %d after %0 : i4
    hw.output %1, %4 : i1, i4
  }
  hw.module private @prim_subreg_arb_20(in %we : i1, in %wd : i1, in %de : i1, in %d : i1, in %q : i1, out wr_en : i1, out wr_data : i1) {
    hw.output %de, %d : i1, i1
  }
  hw.module private @prim_subreg_arb_21(in %we : i1, in %wd : i2, in %de : i1, in %d : i2, in %q : i2, out wr_en : i1, out wr_data : i2) {
    hw.output %de, %d : i1, i2
  }
  hw.module private @prim_subreg_ext(in %re : i1, in %we : i1, in %wd : i1, in %d : i1, out qe : i1, out qre : i1, out q : i1, out ds : i1, out qs : i1) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i1, i1, i1
  }
  hw.module private @prim_subreg(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i1, in %de : i1, in %d : i1, out qe : i1, out q : i1, out ds : i1, out qs : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
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
      llhd.drv %q, %false after %0 : i1
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
  hw.module private @prim_subreg_6(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i1, in %de : i1, in %d : i1, out qe : i1, out q : i1, out ds : i1, out qs : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_17(we: %we: i1, wd: %wd: i1, de: %de: i1, d: %d: i1, q: %4: i1) -> (wr_en: i1, wr_data: i1)
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
      llhd.drv %q, %false after %0 : i1
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
  hw.module private @prim_subreg_7(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i1, in %de : i1, in %d : i1, out qe : i1, out q : i1, out ds : i1, out qs : i1) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_18(we: %we: i1, wd: %wd: i1, de: %de: i1, d: %d: i1, q: %4: i1) -> (wr_en: i1, wr_data: i1)
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
  hw.module private @prim_subreg_8(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i4, in %de : i1, in %d : i4, out qe : i1, out q : i4, out ds : i4, out qs : i4) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %c6_i4 = hw.constant 6 : i4
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %q = llhd.sig %c0_i4 : i4
    %qs = llhd.sig %c0_i4 : i4
    %wr_en = llhd.sig %false : i1
    %wr_data = llhd.sig %c0_i4 : i4
    %4 = llhd.prb %q : i4
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_19(we: %we: i1, wd: %wd: i4, de: %de: i1, d: %d: i4, q: %4: i4) -> (wr_en: i1, wr_data: i4)
    llhd.drv %wr_en, %wr_en_data_arb.wr_en after %1 : i1
    llhd.drv %wr_data, %wr_en_data_arb.wr_data after %1 : i4
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
      llhd.drv %q, %c6_i4 after %0 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %20 = llhd.prb %wr_en : i1
      cf.cond_br %20, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %21 = llhd.prb %wr_data : i4
      llhd.drv %q, %21 after %0 : i4
      cf.br ^bb1
    }
    %5 = llhd.prb %wr_en : i1
    %6 = llhd.prb %wr_data : i4
    %7 = llhd.prb %qs : i4
    %8 = comb.mux %5, %6, %7 : i4
    llhd.drv %qs, %4 after %1 : i4
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    hw.output %we, %4, %8, %7 : i1, i4, i4, i4
  }
  hw.module private @prim_subreg_9(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i1, in %de : i1, in %d : i1, out qe : i1, out q : i1, out ds : i1, out qs : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_20(we: %we: i1, wd: %wd: i1, de: %de: i1, d: %d: i1, q: %4: i1) -> (wr_en: i1, wr_data: i1)
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
      llhd.drv %q, %false after %0 : i1
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
  hw.module private @prim_subreg_10(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i2, in %de : i1, in %d : i2, out qe : i1, out q : i2, out ds : i2, out qs : i2) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %q = llhd.sig %c0_i2 : i2
    %qs = llhd.sig %c0_i2 : i2
    %wr_en = llhd.sig %false : i1
    %wr_data = llhd.sig %c0_i2 : i2
    %4 = llhd.prb %q : i2
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_21(we: %we: i1, wd: %wd: i2, de: %de: i1, d: %d: i2, q: %4: i2) -> (wr_en: i1, wr_data: i2)
    llhd.drv %wr_en, %wr_en_data_arb.wr_en after %1 : i1
    llhd.drv %wr_data, %wr_en_data_arb.wr_data after %1 : i2
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
      llhd.drv %q, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %20 = llhd.prb %wr_en : i1
      cf.cond_br %20, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %21 = llhd.prb %wr_data : i2
      llhd.drv %q, %21 after %0 : i2
      cf.br ^bb1
    }
    %5 = llhd.prb %wr_en : i1
    %6 = llhd.prb %wr_data : i2
    %7 = llhd.prb %qs : i2
    %8 = comb.mux %5, %6, %7 : i2
    llhd.drv %qs, %4 after %1 : i2
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    hw.output %we, %4, %8, %7 : i1, i2, i2, i2
  }
  hw.module private @tlul_adapter_reg(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %en_ifetch_i : i4, out intg_error_o : i1, out re_o : i1, out we_o : i1, out addr_o : i7, out wdata_o : i32, out be_o : i4, in %busy_i : i1, in %rdata_i : i32, in %error_i : i1) {
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
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen_16(tl_i: %32: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
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
    %22 = comb.extract %a_address from 2 : (i32) -> i5
    %23 = comb.concat %22, %c0_i2 : i5, i2
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
    hw.output %u_rsp_intg_gen.tl_o, %false, %21, %19, %23, %a_data, %a_mask : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, i1, i1, i1, i7, i32, i4
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
  hw.module private @tlul_rsp_intg_gen_16(in %tl_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) {
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
  hw.module private @sensor_ctrl_reg_top(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out reg2hw : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>, in %hw2reg : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<d: i1, de: i1>, io_status_change: !hw.struct<d: i1, de: i1>>, recov_alert: !hw.array<11xstruct<d: i1, de: i1>>, fatal_alert: !hw.array<12xstruct<d: i1, de: i1>>, status: !hw.struct<io_pok: !hw.struct<d: i2, de: i1>, ast_init_done: !hw.struct<d: i1, de: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>>, out intg_err_o : i1) {
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
    %c-1_i3 = hw.constant -1 : i3
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %c-5_i4 = hw.constant -5 : i4
    %c-6_i4 = hw.constant -6 : i4
    %c-8_i4 = hw.constant -8 : i4
    %c7_i4 = hw.constant 7 : i4
    %c6_i4 = hw.constant 6 : i4
    %c5_i4 = hw.constant 5 : i4
    %c4_i4 = hw.constant 4 : i4
    %c2_i4 = hw.constant 2 : i4
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i3 = hw.constant 0 : i3
    %c0_i29 = hw.constant 0 : i29
    %2 = hw.aggregate_constant [[[false], [false]], [[false], [false]], [[false, false], [false, false]], [[false, false], [false, false]], [[false], [false], [false], [false], [false], [false], [false], [false], [false], [false], [false]], [[0 : i4], [0 : i4], [0 : i4], [0 : i4], [0 : i4], [0 : i4], [0 : i4], [0 : i4], [0 : i4], [0 : i4], [0 : i4]], [[false], [false], [false], [false], [false], [false], [false], [false], [false], [false], [false]], [[false], [false], [false], [false], [false], [false], [false], [false], [false], [false], [false]], [[false], [false], [false], [false], [false], [false], [false], [false], [false], [false], [false], [false]], [[[false, false], [false, false], [false, false]], [[false, false], [false, false], [false, false]], [[false, false], [false, false], [false, false]], [[false, false], [false, false], [false, false]]]] : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
    %c-1_i32 = hw.constant -1 : i32
    %c0_i32 = hw.constant 0 : i32
    %c3_i4 = hw.constant 3 : i4
    %c1_i4 = hw.constant 1 : i4
    %c-16_i7 = hw.constant -16 : i7
    %c-20_i7 = hw.constant -20 : i7
    %c-24_i7 = hw.constant -24 : i7
    %c-28_i7 = hw.constant -28 : i7
    %c-32_i7 = hw.constant -32 : i7
    %c-36_i7 = hw.constant -36 : i7
    %c-40_i7 = hw.constant -40 : i7
    %c-44_i7 = hw.constant -44 : i7
    %c-48_i7 = hw.constant -48 : i7
    %c-52_i7 = hw.constant -52 : i7
    %c-56_i7 = hw.constant -56 : i7
    %c-60_i7 = hw.constant -60 : i7
    %c-64_i7 = hw.constant -64 : i7
    %c60_i7 = hw.constant 60 : i7
    %c56_i7 = hw.constant 56 : i7
    %c52_i7 = hw.constant 52 : i7
    %c48_i7 = hw.constant 48 : i7
    %c44_i7 = hw.constant 44 : i7
    %c40_i7 = hw.constant 40 : i7
    %c36_i7 = hw.constant 36 : i7
    %c32_i7 = hw.constant 32 : i7
    %c28_i7 = hw.constant 28 : i7
    %c24_i7 = hw.constant 24 : i7
    %c20_i7 = hw.constant 20 : i7
    %c16_i7 = hw.constant 16 : i7
    %c12_i7 = hw.constant 12 : i7
    %c8_i7 = hw.constant 8 : i7
    %c4_i7 = hw.constant 4 : i7
    %c0_i7 = hw.constant 0 : i7
    %true = hw.constant true
    %c0_i2 = hw.constant 0 : i2
    %c0_i4 = hw.constant 0 : i4
    %false = hw.constant false {sv.namehint = "shadow_busy"}
    %c-7_i4 = hw.constant -7 : i4
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %reg2hw = llhd.sig %2 : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
    %reg_we = llhd.sig %false : i1
    %reg_addr = llhd.sig %c0_i7 : i7
    %reg_be = llhd.sig %c0_i4 : i4
    %wr_err = llhd.sig %false : i1
    %reg_rdata_next = llhd.sig %c0_i32 : i32
    %intg_err = llhd.sig %false : i1
    %reg_we_err = llhd.sig %false : i1
    %reg_we_check = llhd.sig %c0_i29 : i29
    %err_q = llhd.sig %false : i1
    %intr_state_we = llhd.sig %false : i1
    %intr_state_io_status_change_qs = llhd.sig %false : i1
    %intr_state_init_status_change_qs = llhd.sig %false : i1
    %intr_enable_we = llhd.sig %false : i1
    %intr_enable_io_status_change_qs = llhd.sig %false : i1
    %intr_enable_init_status_change_qs = llhd.sig %false : i1
    %intr_test_we = llhd.sig %false : i1
    %alert_test_we = llhd.sig %false : i1
    %cfg_regwen_we = llhd.sig %false : i1
    %cfg_regwen_qs = llhd.sig %false : i1
    %alert_trig_we = llhd.sig %false : i1
    %alert_trig_val_0_qs = llhd.sig %false : i1
    %alert_trig_val_1_qs = llhd.sig %false : i1
    %alert_trig_val_2_qs = llhd.sig %false : i1
    %alert_trig_val_3_qs = llhd.sig %false : i1
    %alert_trig_val_4_qs = llhd.sig %false : i1
    %alert_trig_val_5_qs = llhd.sig %false : i1
    %alert_trig_val_6_qs = llhd.sig %false : i1
    %alert_trig_val_7_qs = llhd.sig %false : i1
    %alert_trig_val_8_qs = llhd.sig %false : i1
    %alert_trig_val_9_qs = llhd.sig %false : i1
    %alert_trig_val_10_qs = llhd.sig %false : i1
    %alert_en_0_qs = llhd.sig %c0_i4 : i4
    %alert_en_1_qs = llhd.sig %c0_i4 : i4
    %alert_en_2_qs = llhd.sig %c0_i4 : i4
    %alert_en_3_qs = llhd.sig %c0_i4 : i4
    %alert_en_4_qs = llhd.sig %c0_i4 : i4
    %alert_en_5_qs = llhd.sig %c0_i4 : i4
    %alert_en_6_qs = llhd.sig %c0_i4 : i4
    %alert_en_7_qs = llhd.sig %c0_i4 : i4
    %alert_en_8_qs = llhd.sig %c0_i4 : i4
    %alert_en_9_qs = llhd.sig %c0_i4 : i4
    %alert_en_10_qs = llhd.sig %c0_i4 : i4
    %fatal_alert_en_val_0_qs = llhd.sig %false : i1
    %fatal_alert_en_val_1_qs = llhd.sig %false : i1
    %fatal_alert_en_val_2_qs = llhd.sig %false : i1
    %fatal_alert_en_val_3_qs = llhd.sig %false : i1
    %fatal_alert_en_val_4_qs = llhd.sig %false : i1
    %fatal_alert_en_val_5_qs = llhd.sig %false : i1
    %fatal_alert_en_val_6_qs = llhd.sig %false : i1
    %fatal_alert_en_val_7_qs = llhd.sig %false : i1
    %fatal_alert_en_val_8_qs = llhd.sig %false : i1
    %fatal_alert_en_val_9_qs = llhd.sig %false : i1
    %fatal_alert_en_val_10_qs = llhd.sig %false : i1
    %recov_alert_we = llhd.sig %false : i1
    %recov_alert_val_0_qs = llhd.sig %false : i1
    %recov_alert_val_1_qs = llhd.sig %false : i1
    %recov_alert_val_2_qs = llhd.sig %false : i1
    %recov_alert_val_3_qs = llhd.sig %false : i1
    %recov_alert_val_4_qs = llhd.sig %false : i1
    %recov_alert_val_5_qs = llhd.sig %false : i1
    %recov_alert_val_6_qs = llhd.sig %false : i1
    %recov_alert_val_7_qs = llhd.sig %false : i1
    %recov_alert_val_8_qs = llhd.sig %false : i1
    %recov_alert_val_9_qs = llhd.sig %false : i1
    %recov_alert_val_10_qs = llhd.sig %false : i1
    %fatal_alert_val_0_qs = llhd.sig %false : i1
    %fatal_alert_val_1_qs = llhd.sig %false : i1
    %fatal_alert_val_2_qs = llhd.sig %false : i1
    %fatal_alert_val_3_qs = llhd.sig %false : i1
    %fatal_alert_val_4_qs = llhd.sig %false : i1
    %fatal_alert_val_5_qs = llhd.sig %false : i1
    %fatal_alert_val_6_qs = llhd.sig %false : i1
    %fatal_alert_val_7_qs = llhd.sig %false : i1
    %fatal_alert_val_8_qs = llhd.sig %false : i1
    %fatal_alert_val_9_qs = llhd.sig %false : i1
    %fatal_alert_val_10_qs = llhd.sig %false : i1
    %fatal_alert_val_11_qs = llhd.sig %false : i1
    %status_ast_init_done_qs = llhd.sig %false : i1
    %status_io_pok_qs = llhd.sig %c0_i2 : i2
    %manual_pad_attr_regwen_0_we = llhd.sig %false : i1
    %manual_pad_attr_regwen_0_qs = llhd.sig %false : i1
    %manual_pad_attr_regwen_1_we = llhd.sig %false : i1
    %manual_pad_attr_regwen_1_qs = llhd.sig %false : i1
    %manual_pad_attr_regwen_2_we = llhd.sig %false : i1
    %manual_pad_attr_regwen_2_qs = llhd.sig %false : i1
    %manual_pad_attr_regwen_3_we = llhd.sig %false : i1
    %manual_pad_attr_regwen_3_qs = llhd.sig %false : i1
    %manual_pad_attr_0_pull_en_0_qs = llhd.sig %false : i1
    %manual_pad_attr_0_pull_select_0_qs = llhd.sig %false : i1
    %manual_pad_attr_0_input_disable_0_qs = llhd.sig %false : i1
    %manual_pad_attr_1_pull_en_1_qs = llhd.sig %false : i1
    %manual_pad_attr_1_pull_select_1_qs = llhd.sig %false : i1
    %manual_pad_attr_1_input_disable_1_qs = llhd.sig %false : i1
    %manual_pad_attr_2_pull_en_2_qs = llhd.sig %false : i1
    %manual_pad_attr_2_pull_select_2_qs = llhd.sig %false : i1
    %manual_pad_attr_2_input_disable_2_qs = llhd.sig %false : i1
    %manual_pad_attr_3_pull_en_3_qs = llhd.sig %false : i1
    %manual_pad_attr_3_pull_select_3_qs = llhd.sig %false : i1
    %manual_pad_attr_3_input_disable_3_qs = llhd.sig %false : i1
    %intr_test_flds_we = llhd.sig %c0_i2 : i2
    %alert_test_flds_we = llhd.sig %c0_i2 : i2
    %alert_en_0_gated_we = llhd.sig %false : i1
    %alert_en_1_gated_we = llhd.sig %false : i1
    %alert_en_2_gated_we = llhd.sig %false : i1
    %alert_en_3_gated_we = llhd.sig %false : i1
    %alert_en_4_gated_we = llhd.sig %false : i1
    %alert_en_5_gated_we = llhd.sig %false : i1
    %alert_en_6_gated_we = llhd.sig %false : i1
    %alert_en_7_gated_we = llhd.sig %false : i1
    %alert_en_8_gated_we = llhd.sig %false : i1
    %alert_en_9_gated_we = llhd.sig %false : i1
    %alert_en_10_gated_we = llhd.sig %false : i1
    %fatal_alert_en_gated_we = llhd.sig %false : i1
    %manual_pad_attr_0_flds_we = llhd.sig %c0_i3 : i3
    %manual_pad_attr_0_gated_we = llhd.sig %false : i1
    %manual_pad_attr_1_flds_we = llhd.sig %c0_i3 : i3
    %manual_pad_attr_1_gated_we = llhd.sig %false : i1
    %manual_pad_attr_2_flds_we = llhd.sig %c0_i3 : i3
    %manual_pad_attr_2_gated_we = llhd.sig %false : i1
    %manual_pad_attr_3_flds_we = llhd.sig %c0_i3 : i3
    %manual_pad_attr_3_gated_we = llhd.sig %false : i1
    %addr_hit = llhd.sig %c0_i29 : i29
    %u_chk.err_o = hw.instance "u_chk" @tlul_cmd_intg_chk(tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> (err_o: i1)
    llhd.drv %intg_err, %u_chk.err_o after %1 : i1
    %5 = llhd.prb %reg_we_check : i29
    %6 = llhd.prb %reg_we : i1
    %7 = comb.xor %305, %true : i1
    %8 = comb.and %6, %7 : i1
    %u_prim_reg_we_check.err_o = hw.instance "u_prim_reg_we_check" @prim_reg_we_check(clk_i: %3: i1, rst_ni: %4: i1, oh_i: %5: i29, en_i: %8: i1) -> (err_o: i1)
    llhd.drv %reg_we_err, %u_prim_reg_we_check.err_o after %1 : i1
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen(tl_i: %u_reg_if.tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
    %u_reg_if.tl_o, %u_reg_if.intg_error_o, %u_reg_if.re_o, %u_reg_if.we_o, %u_reg_if.addr_o, %u_reg_if.wdata_o, %u_reg_if.be_o = hw.instance "u_reg_if" @tlul_adapter_reg(clk_i: %3: i1, rst_ni: %4: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, en_ifetch_i: %c-7_i4: i4, busy_i: %false: i1, rdata_i: %249: i32, error_i: %251: i1) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, intg_error_o: i1, re_o: i1, we_o: i1, addr_o: i7, wdata_o: i32, be_o: i4) {sv.namehint = "reg_re"}
    llhd.drv %reg_we, %u_reg_if.we_o after %1 : i1
    llhd.drv %reg_addr, %u_reg_if.addr_o after %1 : i7
    llhd.drv %reg_be, %u_reg_if.be_o after %1 : i4
    %9 = llhd.prb %intr_state_we : i1
    %intr_state = hw.struct_extract %hw2reg["intr_state"] : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<d: i1, de: i1>, io_status_change: !hw.struct<d: i1, de: i1>>, recov_alert: !hw.array<11xstruct<d: i1, de: i1>>, fatal_alert: !hw.array<12xstruct<d: i1, de: i1>>, status: !hw.struct<io_pok: !hw.struct<d: i2, de: i1>, ast_init_done: !hw.struct<d: i1, de: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>>
    %io_status_change = hw.struct_extract %intr_state["io_status_change"] : !hw.struct<init_status_change: !hw.struct<d: i1, de: i1>, io_status_change: !hw.struct<d: i1, de: i1>>
    %de = hw.struct_extract %io_status_change["de"] : !hw.struct<d: i1, de: i1>
    %d = hw.struct_extract %io_status_change["d"] : !hw.struct<d: i1, de: i1>
    %10 = llhd.sig.struct_extract %reg2hw["intr_state"] : <!hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>>
    %11 = llhd.sig.struct_extract %10["io_status_change"] : <!hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>>
    %12 = llhd.sig.struct_extract %11["q"] : <!hw.struct<q: i1>>
    %u_intr_state_io_status_change.qe, %u_intr_state_io_status_change.q, %u_intr_state_io_status_change.ds, %u_intr_state_io_status_change.qs = hw.instance "u_intr_state_io_status_change" @prim_subreg(clk_i: %3: i1, rst_ni: %4: i1, we: %9: i1, wd: %310: i1, de: %de: i1, d: %d: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %12, %u_intr_state_io_status_change.q after %1 : i1
    llhd.drv %intr_state_io_status_change_qs, %u_intr_state_io_status_change.qs after %1 : i1
    %init_status_change = hw.struct_extract %intr_state["init_status_change"] : !hw.struct<init_status_change: !hw.struct<d: i1, de: i1>, io_status_change: !hw.struct<d: i1, de: i1>>
    %de_2 = hw.struct_extract %init_status_change["de"] : !hw.struct<d: i1, de: i1>
    %d_3 = hw.struct_extract %init_status_change["d"] : !hw.struct<d: i1, de: i1>
    %13 = llhd.sig.struct_extract %10["init_status_change"] : <!hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>>
    %14 = llhd.sig.struct_extract %13["q"] : <!hw.struct<q: i1>>
    %u_intr_state_init_status_change.qe, %u_intr_state_init_status_change.q, %u_intr_state_init_status_change.ds, %u_intr_state_init_status_change.qs = hw.instance "u_intr_state_init_status_change" @prim_subreg(clk_i: %3: i1, rst_ni: %4: i1, we: %9: i1, wd: %311: i1, de: %de_2: i1, d: %d_3: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %14, %u_intr_state_init_status_change.q after %1 : i1
    llhd.drv %intr_state_init_status_change_qs, %u_intr_state_init_status_change.qs after %1 : i1
    %15 = llhd.prb %intr_enable_we : i1
    %16 = llhd.sig.struct_extract %reg2hw["intr_enable"] : <!hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>>
    %17 = llhd.sig.struct_extract %16["io_status_change"] : <!hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>>
    %18 = llhd.sig.struct_extract %17["q"] : <!hw.struct<q: i1>>
    %u_intr_enable_io_status_change.qe, %u_intr_enable_io_status_change.q, %u_intr_enable_io_status_change.ds, %u_intr_enable_io_status_change.qs = hw.instance "u_intr_enable_io_status_change" @prim_subreg_6(clk_i: %3: i1, rst_ni: %4: i1, we: %15: i1, wd: %310: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %18, %u_intr_enable_io_status_change.q after %1 : i1
    llhd.drv %intr_enable_io_status_change_qs, %u_intr_enable_io_status_change.qs after %1 : i1
    %19 = llhd.sig.struct_extract %16["init_status_change"] : <!hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>>
    %20 = llhd.sig.struct_extract %19["q"] : <!hw.struct<q: i1>>
    %u_intr_enable_init_status_change.qe, %u_intr_enable_init_status_change.q, %u_intr_enable_init_status_change.ds, %u_intr_enable_init_status_change.qs = hw.instance "u_intr_enable_init_status_change" @prim_subreg_6(clk_i: %3: i1, rst_ni: %4: i1, we: %15: i1, wd: %311: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %20, %u_intr_enable_init_status_change.q after %1 : i1
    llhd.drv %intr_enable_init_status_change_qs, %u_intr_enable_init_status_change.qs after %1 : i1
    %21 = llhd.prb %intr_test_we : i1
    %22 = llhd.sig.extract %intr_test_flds_we from %false : <i2> -> <i1>
    %23 = llhd.sig.struct_extract %reg2hw["intr_test"] : <!hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>>
    %24 = llhd.sig.struct_extract %23["io_status_change"] : <!hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>>
    %25 = llhd.sig.struct_extract %24["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_intr_test_io_status_change.qe, %u_intr_test_io_status_change.qre, %u_intr_test_io_status_change.q, %u_intr_test_io_status_change.ds, %u_intr_test_io_status_change.qs = hw.instance "u_intr_test_io_status_change" @prim_subreg_ext(re: %false: i1, we: %21: i1, wd: %310: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %22, %u_intr_test_io_status_change.qe after %1 : i1
    llhd.drv %25, %u_intr_test_io_status_change.q after %1 : i1
    %26 = llhd.sig.extract %intr_test_flds_we from %true : <i2> -> <i1>
    %27 = llhd.sig.struct_extract %23["init_status_change"] : <!hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>>
    %28 = llhd.sig.struct_extract %27["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_intr_test_init_status_change.qe, %u_intr_test_init_status_change.qre, %u_intr_test_init_status_change.q, %u_intr_test_init_status_change.ds, %u_intr_test_init_status_change.qs = hw.instance "u_intr_test_init_status_change" @prim_subreg_ext(re: %false: i1, we: %21: i1, wd: %311: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %26, %u_intr_test_init_status_change.qe after %1 : i1
    llhd.drv %28, %u_intr_test_init_status_change.q after %1 : i1
    %29 = llhd.prb %alert_test_we : i1
    %30 = llhd.sig.extract %alert_test_flds_we from %false : <i2> -> <i1>
    %31 = llhd.sig.struct_extract %reg2hw["alert_test"] : <!hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>>
    %32 = llhd.sig.struct_extract %31["recov_alert"] : <!hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>>
    %33 = llhd.sig.struct_extract %32["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_alert_test_recov_alert.qe, %u_alert_test_recov_alert.qre, %u_alert_test_recov_alert.q, %u_alert_test_recov_alert.ds, %u_alert_test_recov_alert.qs = hw.instance "u_alert_test_recov_alert" @prim_subreg_ext(re: %false: i1, we: %29: i1, wd: %310: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %30, %u_alert_test_recov_alert.qe after %1 : i1
    llhd.drv %33, %u_alert_test_recov_alert.q after %1 : i1
    %34 = llhd.sig.extract %alert_test_flds_we from %true : <i2> -> <i1>
    %35 = llhd.sig.struct_extract %31["fatal_alert"] : <!hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>>
    %36 = llhd.sig.struct_extract %35["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_alert_test_fatal_alert.qe, %u_alert_test_fatal_alert.qre, %u_alert_test_fatal_alert.q, %u_alert_test_fatal_alert.ds, %u_alert_test_fatal_alert.qs = hw.instance "u_alert_test_fatal_alert" @prim_subreg_ext(re: %false: i1, we: %29: i1, wd: %311: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %34, %u_alert_test_fatal_alert.qe after %1 : i1
    llhd.drv %36, %u_alert_test_fatal_alert.q after %1 : i1
    %37 = llhd.prb %cfg_regwen_we : i1
    %u_cfg_regwen.qe, %u_cfg_regwen.q, %u_cfg_regwen.ds, %u_cfg_regwen.qs = hw.instance "u_cfg_regwen" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %37: i1, wd: %310: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %cfg_regwen_qs, %u_cfg_regwen.qs after %1 : i1
    %38 = llhd.prb %alert_trig_we : i1
    %39 = llhd.sig.struct_extract %reg2hw["alert_trig"] : <!hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>>
    %40 = llhd.sig.array_get %39[%c0_i4] : <!hw.array<11xstruct<q: i1>>>
    %41 = llhd.sig.struct_extract %40["q"] : <!hw.struct<q: i1>>
    %u_alert_trig_val_0.qe, %u_alert_trig_val_0.q, %u_alert_trig_val_0.ds, %u_alert_trig_val_0.qs = hw.instance "u_alert_trig_val_0" @prim_subreg_6(clk_i: %3: i1, rst_ni: %4: i1, we: %38: i1, wd: %310: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %41, %u_alert_trig_val_0.q after %1 : i1
    llhd.drv %alert_trig_val_0_qs, %u_alert_trig_val_0.qs after %1 : i1
    %42 = llhd.sig.array_get %39[%c1_i4] : <!hw.array<11xstruct<q: i1>>>
    %43 = llhd.sig.struct_extract %42["q"] : <!hw.struct<q: i1>>
    %u_alert_trig_val_1.qe, %u_alert_trig_val_1.q, %u_alert_trig_val_1.ds, %u_alert_trig_val_1.qs = hw.instance "u_alert_trig_val_1" @prim_subreg_6(clk_i: %3: i1, rst_ni: %4: i1, we: %38: i1, wd: %311: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %43, %u_alert_trig_val_1.q after %1 : i1
    llhd.drv %alert_trig_val_1_qs, %u_alert_trig_val_1.qs after %1 : i1
    %44 = llhd.sig.array_get %39[%c2_i4] : <!hw.array<11xstruct<q: i1>>>
    %45 = llhd.sig.struct_extract %44["q"] : <!hw.struct<q: i1>>
    %u_alert_trig_val_2.qe, %u_alert_trig_val_2.q, %u_alert_trig_val_2.ds, %u_alert_trig_val_2.qs = hw.instance "u_alert_trig_val_2" @prim_subreg_6(clk_i: %3: i1, rst_ni: %4: i1, we: %38: i1, wd: %322: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %45, %u_alert_trig_val_2.q after %1 : i1
    llhd.drv %alert_trig_val_2_qs, %u_alert_trig_val_2.qs after %1 : i1
    %46 = llhd.sig.array_get %39[%c3_i4] : <!hw.array<11xstruct<q: i1>>>
    %47 = llhd.sig.struct_extract %46["q"] : <!hw.struct<q: i1>>
    %u_alert_trig_val_3.qe, %u_alert_trig_val_3.q, %u_alert_trig_val_3.ds, %u_alert_trig_val_3.qs = hw.instance "u_alert_trig_val_3" @prim_subreg_6(clk_i: %3: i1, rst_ni: %4: i1, we: %38: i1, wd: %323: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %47, %u_alert_trig_val_3.q after %1 : i1
    llhd.drv %alert_trig_val_3_qs, %u_alert_trig_val_3.qs after %1 : i1
    %48 = llhd.sig.array_get %39[%c4_i4] : <!hw.array<11xstruct<q: i1>>>
    %49 = llhd.sig.struct_extract %48["q"] : <!hw.struct<q: i1>>
    %u_alert_trig_val_4.qe, %u_alert_trig_val_4.q, %u_alert_trig_val_4.ds, %u_alert_trig_val_4.qs = hw.instance "u_alert_trig_val_4" @prim_subreg_6(clk_i: %3: i1, rst_ni: %4: i1, we: %38: i1, wd: %324: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %49, %u_alert_trig_val_4.q after %1 : i1
    llhd.drv %alert_trig_val_4_qs, %u_alert_trig_val_4.qs after %1 : i1
    %50 = llhd.sig.array_get %39[%c5_i4] : <!hw.array<11xstruct<q: i1>>>
    %51 = llhd.sig.struct_extract %50["q"] : <!hw.struct<q: i1>>
    %u_alert_trig_val_5.qe, %u_alert_trig_val_5.q, %u_alert_trig_val_5.ds, %u_alert_trig_val_5.qs = hw.instance "u_alert_trig_val_5" @prim_subreg_6(clk_i: %3: i1, rst_ni: %4: i1, we: %38: i1, wd: %325: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %51, %u_alert_trig_val_5.q after %1 : i1
    llhd.drv %alert_trig_val_5_qs, %u_alert_trig_val_5.qs after %1 : i1
    %52 = llhd.sig.array_get %39[%c6_i4] : <!hw.array<11xstruct<q: i1>>>
    %53 = llhd.sig.struct_extract %52["q"] : <!hw.struct<q: i1>>
    %u_alert_trig_val_6.qe, %u_alert_trig_val_6.q, %u_alert_trig_val_6.ds, %u_alert_trig_val_6.qs = hw.instance "u_alert_trig_val_6" @prim_subreg_6(clk_i: %3: i1, rst_ni: %4: i1, we: %38: i1, wd: %326: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %53, %u_alert_trig_val_6.q after %1 : i1
    llhd.drv %alert_trig_val_6_qs, %u_alert_trig_val_6.qs after %1 : i1
    %54 = llhd.sig.array_get %39[%c7_i4] : <!hw.array<11xstruct<q: i1>>>
    %55 = llhd.sig.struct_extract %54["q"] : <!hw.struct<q: i1>>
    %u_alert_trig_val_7.qe, %u_alert_trig_val_7.q, %u_alert_trig_val_7.ds, %u_alert_trig_val_7.qs = hw.instance "u_alert_trig_val_7" @prim_subreg_6(clk_i: %3: i1, rst_ni: %4: i1, we: %38: i1, wd: %327: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %55, %u_alert_trig_val_7.q after %1 : i1
    llhd.drv %alert_trig_val_7_qs, %u_alert_trig_val_7.qs after %1 : i1
    %56 = llhd.sig.array_get %39[%c-8_i4] : <!hw.array<11xstruct<q: i1>>>
    %57 = llhd.sig.struct_extract %56["q"] : <!hw.struct<q: i1>>
    %u_alert_trig_val_8.qe, %u_alert_trig_val_8.q, %u_alert_trig_val_8.ds, %u_alert_trig_val_8.qs = hw.instance "u_alert_trig_val_8" @prim_subreg_6(clk_i: %3: i1, rst_ni: %4: i1, we: %38: i1, wd: %328: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %57, %u_alert_trig_val_8.q after %1 : i1
    llhd.drv %alert_trig_val_8_qs, %u_alert_trig_val_8.qs after %1 : i1
    %58 = llhd.sig.array_get %39[%c-7_i4] : <!hw.array<11xstruct<q: i1>>>
    %59 = llhd.sig.struct_extract %58["q"] : <!hw.struct<q: i1>>
    %u_alert_trig_val_9.qe, %u_alert_trig_val_9.q, %u_alert_trig_val_9.ds, %u_alert_trig_val_9.qs = hw.instance "u_alert_trig_val_9" @prim_subreg_6(clk_i: %3: i1, rst_ni: %4: i1, we: %38: i1, wd: %329: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %59, %u_alert_trig_val_9.q after %1 : i1
    llhd.drv %alert_trig_val_9_qs, %u_alert_trig_val_9.qs after %1 : i1
    %60 = llhd.sig.array_get %39[%c-6_i4] : <!hw.array<11xstruct<q: i1>>>
    %61 = llhd.sig.struct_extract %60["q"] : <!hw.struct<q: i1>>
    %u_alert_trig_val_10.qe, %u_alert_trig_val_10.q, %u_alert_trig_val_10.ds, %u_alert_trig_val_10.qs = hw.instance "u_alert_trig_val_10" @prim_subreg_6(clk_i: %3: i1, rst_ni: %4: i1, we: %38: i1, wd: %330: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %61, %u_alert_trig_val_10.q after %1 : i1
    llhd.drv %alert_trig_val_10_qs, %u_alert_trig_val_10.qs after %1 : i1
    %62 = llhd.prb %alert_en_0_gated_we : i1
    %63 = llhd.sig.struct_extract %reg2hw["alert_en"] : <!hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>>
    %64 = llhd.sig.array_get %63[%c0_i4] : <!hw.array<11xstruct<q: i4>>>
    %65 = llhd.sig.struct_extract %64["q"] : <!hw.struct<q: i4>>
    %u_alert_en_0.qe, %u_alert_en_0.q, %u_alert_en_0.ds, %u_alert_en_0.qs = hw.instance "u_alert_en_0" @prim_subreg_8(clk_i: %3: i1, rst_ni: %4: i1, we: %62: i1, wd: %332: i4, de: %false: i1, d: %c0_i4: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %65, %u_alert_en_0.q after %1 : i4
    llhd.drv %alert_en_0_qs, %u_alert_en_0.qs after %1 : i4
    %66 = llhd.prb %alert_en_1_gated_we : i1
    %67 = llhd.sig.array_get %63[%c1_i4] : <!hw.array<11xstruct<q: i4>>>
    %68 = llhd.sig.struct_extract %67["q"] : <!hw.struct<q: i4>>
    %u_alert_en_1.qe, %u_alert_en_1.q, %u_alert_en_1.ds, %u_alert_en_1.qs = hw.instance "u_alert_en_1" @prim_subreg_8(clk_i: %3: i1, rst_ni: %4: i1, we: %66: i1, wd: %332: i4, de: %false: i1, d: %c0_i4: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %68, %u_alert_en_1.q after %1 : i4
    llhd.drv %alert_en_1_qs, %u_alert_en_1.qs after %1 : i4
    %69 = llhd.prb %alert_en_2_gated_we : i1
    %70 = llhd.sig.array_get %63[%c2_i4] : <!hw.array<11xstruct<q: i4>>>
    %71 = llhd.sig.struct_extract %70["q"] : <!hw.struct<q: i4>>
    %u_alert_en_2.qe, %u_alert_en_2.q, %u_alert_en_2.ds, %u_alert_en_2.qs = hw.instance "u_alert_en_2" @prim_subreg_8(clk_i: %3: i1, rst_ni: %4: i1, we: %69: i1, wd: %332: i4, de: %false: i1, d: %c0_i4: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %71, %u_alert_en_2.q after %1 : i4
    llhd.drv %alert_en_2_qs, %u_alert_en_2.qs after %1 : i4
    %72 = llhd.prb %alert_en_3_gated_we : i1
    %73 = llhd.sig.array_get %63[%c3_i4] : <!hw.array<11xstruct<q: i4>>>
    %74 = llhd.sig.struct_extract %73["q"] : <!hw.struct<q: i4>>
    %u_alert_en_3.qe, %u_alert_en_3.q, %u_alert_en_3.ds, %u_alert_en_3.qs = hw.instance "u_alert_en_3" @prim_subreg_8(clk_i: %3: i1, rst_ni: %4: i1, we: %72: i1, wd: %332: i4, de: %false: i1, d: %c0_i4: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %74, %u_alert_en_3.q after %1 : i4
    llhd.drv %alert_en_3_qs, %u_alert_en_3.qs after %1 : i4
    %75 = llhd.prb %alert_en_4_gated_we : i1
    %76 = llhd.sig.array_get %63[%c4_i4] : <!hw.array<11xstruct<q: i4>>>
    %77 = llhd.sig.struct_extract %76["q"] : <!hw.struct<q: i4>>
    %u_alert_en_4.qe, %u_alert_en_4.q, %u_alert_en_4.ds, %u_alert_en_4.qs = hw.instance "u_alert_en_4" @prim_subreg_8(clk_i: %3: i1, rst_ni: %4: i1, we: %75: i1, wd: %332: i4, de: %false: i1, d: %c0_i4: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %77, %u_alert_en_4.q after %1 : i4
    llhd.drv %alert_en_4_qs, %u_alert_en_4.qs after %1 : i4
    %78 = llhd.prb %alert_en_5_gated_we : i1
    %79 = llhd.sig.array_get %63[%c5_i4] : <!hw.array<11xstruct<q: i4>>>
    %80 = llhd.sig.struct_extract %79["q"] : <!hw.struct<q: i4>>
    %u_alert_en_5.qe, %u_alert_en_5.q, %u_alert_en_5.ds, %u_alert_en_5.qs = hw.instance "u_alert_en_5" @prim_subreg_8(clk_i: %3: i1, rst_ni: %4: i1, we: %78: i1, wd: %332: i4, de: %false: i1, d: %c0_i4: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %80, %u_alert_en_5.q after %1 : i4
    llhd.drv %alert_en_5_qs, %u_alert_en_5.qs after %1 : i4
    %81 = llhd.prb %alert_en_6_gated_we : i1
    %82 = llhd.sig.array_get %63[%c6_i4] : <!hw.array<11xstruct<q: i4>>>
    %83 = llhd.sig.struct_extract %82["q"] : <!hw.struct<q: i4>>
    %u_alert_en_6.qe, %u_alert_en_6.q, %u_alert_en_6.ds, %u_alert_en_6.qs = hw.instance "u_alert_en_6" @prim_subreg_8(clk_i: %3: i1, rst_ni: %4: i1, we: %81: i1, wd: %332: i4, de: %false: i1, d: %c0_i4: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %83, %u_alert_en_6.q after %1 : i4
    llhd.drv %alert_en_6_qs, %u_alert_en_6.qs after %1 : i4
    %84 = llhd.prb %alert_en_7_gated_we : i1
    %85 = llhd.sig.array_get %63[%c7_i4] : <!hw.array<11xstruct<q: i4>>>
    %86 = llhd.sig.struct_extract %85["q"] : <!hw.struct<q: i4>>
    %u_alert_en_7.qe, %u_alert_en_7.q, %u_alert_en_7.ds, %u_alert_en_7.qs = hw.instance "u_alert_en_7" @prim_subreg_8(clk_i: %3: i1, rst_ni: %4: i1, we: %84: i1, wd: %332: i4, de: %false: i1, d: %c0_i4: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %86, %u_alert_en_7.q after %1 : i4
    llhd.drv %alert_en_7_qs, %u_alert_en_7.qs after %1 : i4
    %87 = llhd.prb %alert_en_8_gated_we : i1
    %88 = llhd.sig.array_get %63[%c-8_i4] : <!hw.array<11xstruct<q: i4>>>
    %89 = llhd.sig.struct_extract %88["q"] : <!hw.struct<q: i4>>
    %u_alert_en_8.qe, %u_alert_en_8.q, %u_alert_en_8.ds, %u_alert_en_8.qs = hw.instance "u_alert_en_8" @prim_subreg_8(clk_i: %3: i1, rst_ni: %4: i1, we: %87: i1, wd: %332: i4, de: %false: i1, d: %c0_i4: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %89, %u_alert_en_8.q after %1 : i4
    llhd.drv %alert_en_8_qs, %u_alert_en_8.qs after %1 : i4
    %90 = llhd.prb %alert_en_9_gated_we : i1
    %91 = llhd.sig.array_get %63[%c-7_i4] : <!hw.array<11xstruct<q: i4>>>
    %92 = llhd.sig.struct_extract %91["q"] : <!hw.struct<q: i4>>
    %u_alert_en_9.qe, %u_alert_en_9.q, %u_alert_en_9.ds, %u_alert_en_9.qs = hw.instance "u_alert_en_9" @prim_subreg_8(clk_i: %3: i1, rst_ni: %4: i1, we: %90: i1, wd: %332: i4, de: %false: i1, d: %c0_i4: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %92, %u_alert_en_9.q after %1 : i4
    llhd.drv %alert_en_9_qs, %u_alert_en_9.qs after %1 : i4
    %93 = llhd.prb %alert_en_10_gated_we : i1
    %94 = llhd.sig.array_get %63[%c-6_i4] : <!hw.array<11xstruct<q: i4>>>
    %95 = llhd.sig.struct_extract %94["q"] : <!hw.struct<q: i4>>
    %u_alert_en_10.qe, %u_alert_en_10.q, %u_alert_en_10.ds, %u_alert_en_10.qs = hw.instance "u_alert_en_10" @prim_subreg_8(clk_i: %3: i1, rst_ni: %4: i1, we: %93: i1, wd: %332: i4, de: %false: i1, d: %c0_i4: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %95, %u_alert_en_10.q after %1 : i4
    llhd.drv %alert_en_10_qs, %u_alert_en_10.qs after %1 : i4
    %96 = llhd.prb %fatal_alert_en_gated_we : i1
    %97 = llhd.sig.struct_extract %reg2hw["fatal_alert_en"] : <!hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>>
    %98 = llhd.sig.array_get %97[%c0_i4] : <!hw.array<11xstruct<q: i1>>>
    %99 = llhd.sig.struct_extract %98["q"] : <!hw.struct<q: i1>>
    %u_fatal_alert_en_val_0.qe, %u_fatal_alert_en_val_0.q, %u_fatal_alert_en_val_0.ds, %u_fatal_alert_en_val_0.qs = hw.instance "u_fatal_alert_en_val_0" @prim_subreg_6(clk_i: %3: i1, rst_ni: %4: i1, we: %96: i1, wd: %310: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %99, %u_fatal_alert_en_val_0.q after %1 : i1
    llhd.drv %fatal_alert_en_val_0_qs, %u_fatal_alert_en_val_0.qs after %1 : i1
    %100 = llhd.sig.array_get %97[%c1_i4] : <!hw.array<11xstruct<q: i1>>>
    %101 = llhd.sig.struct_extract %100["q"] : <!hw.struct<q: i1>>
    %u_fatal_alert_en_val_1.qe, %u_fatal_alert_en_val_1.q, %u_fatal_alert_en_val_1.ds, %u_fatal_alert_en_val_1.qs = hw.instance "u_fatal_alert_en_val_1" @prim_subreg_6(clk_i: %3: i1, rst_ni: %4: i1, we: %96: i1, wd: %311: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %101, %u_fatal_alert_en_val_1.q after %1 : i1
    llhd.drv %fatal_alert_en_val_1_qs, %u_fatal_alert_en_val_1.qs after %1 : i1
    %102 = llhd.sig.array_get %97[%c2_i4] : <!hw.array<11xstruct<q: i1>>>
    %103 = llhd.sig.struct_extract %102["q"] : <!hw.struct<q: i1>>
    %u_fatal_alert_en_val_2.qe, %u_fatal_alert_en_val_2.q, %u_fatal_alert_en_val_2.ds, %u_fatal_alert_en_val_2.qs = hw.instance "u_fatal_alert_en_val_2" @prim_subreg_6(clk_i: %3: i1, rst_ni: %4: i1, we: %96: i1, wd: %322: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %103, %u_fatal_alert_en_val_2.q after %1 : i1
    llhd.drv %fatal_alert_en_val_2_qs, %u_fatal_alert_en_val_2.qs after %1 : i1
    %104 = llhd.sig.array_get %97[%c3_i4] : <!hw.array<11xstruct<q: i1>>>
    %105 = llhd.sig.struct_extract %104["q"] : <!hw.struct<q: i1>>
    %u_fatal_alert_en_val_3.qe, %u_fatal_alert_en_val_3.q, %u_fatal_alert_en_val_3.ds, %u_fatal_alert_en_val_3.qs = hw.instance "u_fatal_alert_en_val_3" @prim_subreg_6(clk_i: %3: i1, rst_ni: %4: i1, we: %96: i1, wd: %323: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %105, %u_fatal_alert_en_val_3.q after %1 : i1
    llhd.drv %fatal_alert_en_val_3_qs, %u_fatal_alert_en_val_3.qs after %1 : i1
    %106 = llhd.sig.array_get %97[%c4_i4] : <!hw.array<11xstruct<q: i1>>>
    %107 = llhd.sig.struct_extract %106["q"] : <!hw.struct<q: i1>>
    %u_fatal_alert_en_val_4.qe, %u_fatal_alert_en_val_4.q, %u_fatal_alert_en_val_4.ds, %u_fatal_alert_en_val_4.qs = hw.instance "u_fatal_alert_en_val_4" @prim_subreg_6(clk_i: %3: i1, rst_ni: %4: i1, we: %96: i1, wd: %324: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %107, %u_fatal_alert_en_val_4.q after %1 : i1
    llhd.drv %fatal_alert_en_val_4_qs, %u_fatal_alert_en_val_4.qs after %1 : i1
    %108 = llhd.sig.array_get %97[%c5_i4] : <!hw.array<11xstruct<q: i1>>>
    %109 = llhd.sig.struct_extract %108["q"] : <!hw.struct<q: i1>>
    %u_fatal_alert_en_val_5.qe, %u_fatal_alert_en_val_5.q, %u_fatal_alert_en_val_5.ds, %u_fatal_alert_en_val_5.qs = hw.instance "u_fatal_alert_en_val_5" @prim_subreg_6(clk_i: %3: i1, rst_ni: %4: i1, we: %96: i1, wd: %325: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %109, %u_fatal_alert_en_val_5.q after %1 : i1
    llhd.drv %fatal_alert_en_val_5_qs, %u_fatal_alert_en_val_5.qs after %1 : i1
    %110 = llhd.sig.array_get %97[%c6_i4] : <!hw.array<11xstruct<q: i1>>>
    %111 = llhd.sig.struct_extract %110["q"] : <!hw.struct<q: i1>>
    %u_fatal_alert_en_val_6.qe, %u_fatal_alert_en_val_6.q, %u_fatal_alert_en_val_6.ds, %u_fatal_alert_en_val_6.qs = hw.instance "u_fatal_alert_en_val_6" @prim_subreg_6(clk_i: %3: i1, rst_ni: %4: i1, we: %96: i1, wd: %326: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %111, %u_fatal_alert_en_val_6.q after %1 : i1
    llhd.drv %fatal_alert_en_val_6_qs, %u_fatal_alert_en_val_6.qs after %1 : i1
    %112 = llhd.sig.array_get %97[%c7_i4] : <!hw.array<11xstruct<q: i1>>>
    %113 = llhd.sig.struct_extract %112["q"] : <!hw.struct<q: i1>>
    %u_fatal_alert_en_val_7.qe, %u_fatal_alert_en_val_7.q, %u_fatal_alert_en_val_7.ds, %u_fatal_alert_en_val_7.qs = hw.instance "u_fatal_alert_en_val_7" @prim_subreg_6(clk_i: %3: i1, rst_ni: %4: i1, we: %96: i1, wd: %327: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %113, %u_fatal_alert_en_val_7.q after %1 : i1
    llhd.drv %fatal_alert_en_val_7_qs, %u_fatal_alert_en_val_7.qs after %1 : i1
    %114 = llhd.sig.array_get %97[%c-8_i4] : <!hw.array<11xstruct<q: i1>>>
    %115 = llhd.sig.struct_extract %114["q"] : <!hw.struct<q: i1>>
    %u_fatal_alert_en_val_8.qe, %u_fatal_alert_en_val_8.q, %u_fatal_alert_en_val_8.ds, %u_fatal_alert_en_val_8.qs = hw.instance "u_fatal_alert_en_val_8" @prim_subreg_6(clk_i: %3: i1, rst_ni: %4: i1, we: %96: i1, wd: %328: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %115, %u_fatal_alert_en_val_8.q after %1 : i1
    llhd.drv %fatal_alert_en_val_8_qs, %u_fatal_alert_en_val_8.qs after %1 : i1
    %116 = llhd.sig.array_get %97[%c-7_i4] : <!hw.array<11xstruct<q: i1>>>
    %117 = llhd.sig.struct_extract %116["q"] : <!hw.struct<q: i1>>
    %u_fatal_alert_en_val_9.qe, %u_fatal_alert_en_val_9.q, %u_fatal_alert_en_val_9.ds, %u_fatal_alert_en_val_9.qs = hw.instance "u_fatal_alert_en_val_9" @prim_subreg_6(clk_i: %3: i1, rst_ni: %4: i1, we: %96: i1, wd: %329: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %117, %u_fatal_alert_en_val_9.q after %1 : i1
    llhd.drv %fatal_alert_en_val_9_qs, %u_fatal_alert_en_val_9.qs after %1 : i1
    %118 = llhd.sig.array_get %97[%c-6_i4] : <!hw.array<11xstruct<q: i1>>>
    %119 = llhd.sig.struct_extract %118["q"] : <!hw.struct<q: i1>>
    %u_fatal_alert_en_val_10.qe, %u_fatal_alert_en_val_10.q, %u_fatal_alert_en_val_10.ds, %u_fatal_alert_en_val_10.qs = hw.instance "u_fatal_alert_en_val_10" @prim_subreg_6(clk_i: %3: i1, rst_ni: %4: i1, we: %96: i1, wd: %330: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %119, %u_fatal_alert_en_val_10.q after %1 : i1
    llhd.drv %fatal_alert_en_val_10_qs, %u_fatal_alert_en_val_10.qs after %1 : i1
    %120 = llhd.prb %recov_alert_we : i1
    %recov_alert = hw.struct_extract %hw2reg["recov_alert"] : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<d: i1, de: i1>, io_status_change: !hw.struct<d: i1, de: i1>>, recov_alert: !hw.array<11xstruct<d: i1, de: i1>>, fatal_alert: !hw.array<12xstruct<d: i1, de: i1>>, status: !hw.struct<io_pok: !hw.struct<d: i2, de: i1>, ast_init_done: !hw.struct<d: i1, de: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>>
    %121 = hw.array_get %recov_alert[%c0_i4] : !hw.array<11xstruct<d: i1, de: i1>>, i4
    %de_4 = hw.struct_extract %121["de"] : !hw.struct<d: i1, de: i1>
    %d_5 = hw.struct_extract %121["d"] : !hw.struct<d: i1, de: i1>
    %122 = llhd.sig.struct_extract %reg2hw["recov_alert"] : <!hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>>
    %123 = llhd.sig.array_get %122[%c0_i4] : <!hw.array<11xstruct<q: i1>>>
    %124 = llhd.sig.struct_extract %123["q"] : <!hw.struct<q: i1>>
    %u_recov_alert_val_0.qe, %u_recov_alert_val_0.q, %u_recov_alert_val_0.ds, %u_recov_alert_val_0.qs = hw.instance "u_recov_alert_val_0" @prim_subreg(clk_i: %3: i1, rst_ni: %4: i1, we: %120: i1, wd: %310: i1, de: %de_4: i1, d: %d_5: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %124, %u_recov_alert_val_0.q after %1 : i1
    llhd.drv %recov_alert_val_0_qs, %u_recov_alert_val_0.qs after %1 : i1
    %125 = hw.array_get %recov_alert[%c1_i4] : !hw.array<11xstruct<d: i1, de: i1>>, i4
    %de_6 = hw.struct_extract %125["de"] : !hw.struct<d: i1, de: i1>
    %d_7 = hw.struct_extract %125["d"] : !hw.struct<d: i1, de: i1>
    %126 = llhd.sig.array_get %122[%c1_i4] : <!hw.array<11xstruct<q: i1>>>
    %127 = llhd.sig.struct_extract %126["q"] : <!hw.struct<q: i1>>
    %u_recov_alert_val_1.qe, %u_recov_alert_val_1.q, %u_recov_alert_val_1.ds, %u_recov_alert_val_1.qs = hw.instance "u_recov_alert_val_1" @prim_subreg(clk_i: %3: i1, rst_ni: %4: i1, we: %120: i1, wd: %311: i1, de: %de_6: i1, d: %d_7: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %127, %u_recov_alert_val_1.q after %1 : i1
    llhd.drv %recov_alert_val_1_qs, %u_recov_alert_val_1.qs after %1 : i1
    %128 = hw.array_get %recov_alert[%c2_i4] : !hw.array<11xstruct<d: i1, de: i1>>, i4
    %de_8 = hw.struct_extract %128["de"] : !hw.struct<d: i1, de: i1>
    %d_9 = hw.struct_extract %128["d"] : !hw.struct<d: i1, de: i1>
    %129 = llhd.sig.array_get %122[%c2_i4] : <!hw.array<11xstruct<q: i1>>>
    %130 = llhd.sig.struct_extract %129["q"] : <!hw.struct<q: i1>>
    %u_recov_alert_val_2.qe, %u_recov_alert_val_2.q, %u_recov_alert_val_2.ds, %u_recov_alert_val_2.qs = hw.instance "u_recov_alert_val_2" @prim_subreg(clk_i: %3: i1, rst_ni: %4: i1, we: %120: i1, wd: %322: i1, de: %de_8: i1, d: %d_9: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %130, %u_recov_alert_val_2.q after %1 : i1
    llhd.drv %recov_alert_val_2_qs, %u_recov_alert_val_2.qs after %1 : i1
    %131 = hw.array_get %recov_alert[%c3_i4] : !hw.array<11xstruct<d: i1, de: i1>>, i4
    %de_10 = hw.struct_extract %131["de"] : !hw.struct<d: i1, de: i1>
    %d_11 = hw.struct_extract %131["d"] : !hw.struct<d: i1, de: i1>
    %132 = llhd.sig.array_get %122[%c3_i4] : <!hw.array<11xstruct<q: i1>>>
    %133 = llhd.sig.struct_extract %132["q"] : <!hw.struct<q: i1>>
    %u_recov_alert_val_3.qe, %u_recov_alert_val_3.q, %u_recov_alert_val_3.ds, %u_recov_alert_val_3.qs = hw.instance "u_recov_alert_val_3" @prim_subreg(clk_i: %3: i1, rst_ni: %4: i1, we: %120: i1, wd: %323: i1, de: %de_10: i1, d: %d_11: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %133, %u_recov_alert_val_3.q after %1 : i1
    llhd.drv %recov_alert_val_3_qs, %u_recov_alert_val_3.qs after %1 : i1
    %134 = hw.array_get %recov_alert[%c4_i4] : !hw.array<11xstruct<d: i1, de: i1>>, i4
    %de_12 = hw.struct_extract %134["de"] : !hw.struct<d: i1, de: i1>
    %d_13 = hw.struct_extract %134["d"] : !hw.struct<d: i1, de: i1>
    %135 = llhd.sig.array_get %122[%c4_i4] : <!hw.array<11xstruct<q: i1>>>
    %136 = llhd.sig.struct_extract %135["q"] : <!hw.struct<q: i1>>
    %u_recov_alert_val_4.qe, %u_recov_alert_val_4.q, %u_recov_alert_val_4.ds, %u_recov_alert_val_4.qs = hw.instance "u_recov_alert_val_4" @prim_subreg(clk_i: %3: i1, rst_ni: %4: i1, we: %120: i1, wd: %324: i1, de: %de_12: i1, d: %d_13: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %136, %u_recov_alert_val_4.q after %1 : i1
    llhd.drv %recov_alert_val_4_qs, %u_recov_alert_val_4.qs after %1 : i1
    %137 = hw.array_get %recov_alert[%c5_i4] : !hw.array<11xstruct<d: i1, de: i1>>, i4
    %de_14 = hw.struct_extract %137["de"] : !hw.struct<d: i1, de: i1>
    %d_15 = hw.struct_extract %137["d"] : !hw.struct<d: i1, de: i1>
    %138 = llhd.sig.array_get %122[%c5_i4] : <!hw.array<11xstruct<q: i1>>>
    %139 = llhd.sig.struct_extract %138["q"] : <!hw.struct<q: i1>>
    %u_recov_alert_val_5.qe, %u_recov_alert_val_5.q, %u_recov_alert_val_5.ds, %u_recov_alert_val_5.qs = hw.instance "u_recov_alert_val_5" @prim_subreg(clk_i: %3: i1, rst_ni: %4: i1, we: %120: i1, wd: %325: i1, de: %de_14: i1, d: %d_15: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %139, %u_recov_alert_val_5.q after %1 : i1
    llhd.drv %recov_alert_val_5_qs, %u_recov_alert_val_5.qs after %1 : i1
    %140 = hw.array_get %recov_alert[%c6_i4] : !hw.array<11xstruct<d: i1, de: i1>>, i4
    %de_16 = hw.struct_extract %140["de"] : !hw.struct<d: i1, de: i1>
    %d_17 = hw.struct_extract %140["d"] : !hw.struct<d: i1, de: i1>
    %141 = llhd.sig.array_get %122[%c6_i4] : <!hw.array<11xstruct<q: i1>>>
    %142 = llhd.sig.struct_extract %141["q"] : <!hw.struct<q: i1>>
    %u_recov_alert_val_6.qe, %u_recov_alert_val_6.q, %u_recov_alert_val_6.ds, %u_recov_alert_val_6.qs = hw.instance "u_recov_alert_val_6" @prim_subreg(clk_i: %3: i1, rst_ni: %4: i1, we: %120: i1, wd: %326: i1, de: %de_16: i1, d: %d_17: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %142, %u_recov_alert_val_6.q after %1 : i1
    llhd.drv %recov_alert_val_6_qs, %u_recov_alert_val_6.qs after %1 : i1
    %143 = hw.array_get %recov_alert[%c7_i4] : !hw.array<11xstruct<d: i1, de: i1>>, i4
    %de_18 = hw.struct_extract %143["de"] : !hw.struct<d: i1, de: i1>
    %d_19 = hw.struct_extract %143["d"] : !hw.struct<d: i1, de: i1>
    %144 = llhd.sig.array_get %122[%c7_i4] : <!hw.array<11xstruct<q: i1>>>
    %145 = llhd.sig.struct_extract %144["q"] : <!hw.struct<q: i1>>
    %u_recov_alert_val_7.qe, %u_recov_alert_val_7.q, %u_recov_alert_val_7.ds, %u_recov_alert_val_7.qs = hw.instance "u_recov_alert_val_7" @prim_subreg(clk_i: %3: i1, rst_ni: %4: i1, we: %120: i1, wd: %327: i1, de: %de_18: i1, d: %d_19: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %145, %u_recov_alert_val_7.q after %1 : i1
    llhd.drv %recov_alert_val_7_qs, %u_recov_alert_val_7.qs after %1 : i1
    %146 = hw.array_get %recov_alert[%c-8_i4] : !hw.array<11xstruct<d: i1, de: i1>>, i4
    %de_20 = hw.struct_extract %146["de"] : !hw.struct<d: i1, de: i1>
    %d_21 = hw.struct_extract %146["d"] : !hw.struct<d: i1, de: i1>
    %147 = llhd.sig.array_get %122[%c-8_i4] : <!hw.array<11xstruct<q: i1>>>
    %148 = llhd.sig.struct_extract %147["q"] : <!hw.struct<q: i1>>
    %u_recov_alert_val_8.qe, %u_recov_alert_val_8.q, %u_recov_alert_val_8.ds, %u_recov_alert_val_8.qs = hw.instance "u_recov_alert_val_8" @prim_subreg(clk_i: %3: i1, rst_ni: %4: i1, we: %120: i1, wd: %328: i1, de: %de_20: i1, d: %d_21: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %148, %u_recov_alert_val_8.q after %1 : i1
    llhd.drv %recov_alert_val_8_qs, %u_recov_alert_val_8.qs after %1 : i1
    %149 = hw.array_get %recov_alert[%c-7_i4] : !hw.array<11xstruct<d: i1, de: i1>>, i4
    %de_22 = hw.struct_extract %149["de"] : !hw.struct<d: i1, de: i1>
    %d_23 = hw.struct_extract %149["d"] : !hw.struct<d: i1, de: i1>
    %150 = llhd.sig.array_get %122[%c-7_i4] : <!hw.array<11xstruct<q: i1>>>
    %151 = llhd.sig.struct_extract %150["q"] : <!hw.struct<q: i1>>
    %u_recov_alert_val_9.qe, %u_recov_alert_val_9.q, %u_recov_alert_val_9.ds, %u_recov_alert_val_9.qs = hw.instance "u_recov_alert_val_9" @prim_subreg(clk_i: %3: i1, rst_ni: %4: i1, we: %120: i1, wd: %329: i1, de: %de_22: i1, d: %d_23: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %151, %u_recov_alert_val_9.q after %1 : i1
    llhd.drv %recov_alert_val_9_qs, %u_recov_alert_val_9.qs after %1 : i1
    %152 = hw.array_get %recov_alert[%c-6_i4] : !hw.array<11xstruct<d: i1, de: i1>>, i4
    %de_24 = hw.struct_extract %152["de"] : !hw.struct<d: i1, de: i1>
    %d_25 = hw.struct_extract %152["d"] : !hw.struct<d: i1, de: i1>
    %153 = llhd.sig.array_get %122[%c-6_i4] : <!hw.array<11xstruct<q: i1>>>
    %154 = llhd.sig.struct_extract %153["q"] : <!hw.struct<q: i1>>
    %u_recov_alert_val_10.qe, %u_recov_alert_val_10.q, %u_recov_alert_val_10.ds, %u_recov_alert_val_10.qs = hw.instance "u_recov_alert_val_10" @prim_subreg(clk_i: %3: i1, rst_ni: %4: i1, we: %120: i1, wd: %330: i1, de: %de_24: i1, d: %d_25: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %154, %u_recov_alert_val_10.q after %1 : i1
    llhd.drv %recov_alert_val_10_qs, %u_recov_alert_val_10.qs after %1 : i1
    %fatal_alert = hw.struct_extract %hw2reg["fatal_alert"] : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<d: i1, de: i1>, io_status_change: !hw.struct<d: i1, de: i1>>, recov_alert: !hw.array<11xstruct<d: i1, de: i1>>, fatal_alert: !hw.array<12xstruct<d: i1, de: i1>>, status: !hw.struct<io_pok: !hw.struct<d: i2, de: i1>, ast_init_done: !hw.struct<d: i1, de: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>>
    %155 = hw.array_get %fatal_alert[%c0_i4] : !hw.array<12xstruct<d: i1, de: i1>>, i4
    %de_26 = hw.struct_extract %155["de"] : !hw.struct<d: i1, de: i1>
    %d_27 = hw.struct_extract %155["d"] : !hw.struct<d: i1, de: i1>
    %156 = llhd.sig.struct_extract %reg2hw["fatal_alert"] : <!hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>>
    %157 = llhd.sig.array_get %156[%c0_i4] : <!hw.array<12xstruct<q: i1>>>
    %158 = llhd.sig.struct_extract %157["q"] : <!hw.struct<q: i1>>
    %u_fatal_alert_val_0.qe, %u_fatal_alert_val_0.q, %u_fatal_alert_val_0.ds, %u_fatal_alert_val_0.qs = hw.instance "u_fatal_alert_val_0" @prim_subreg_9(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_26: i1, d: %d_27: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %158, %u_fatal_alert_val_0.q after %1 : i1
    llhd.drv %fatal_alert_val_0_qs, %u_fatal_alert_val_0.qs after %1 : i1
    %159 = hw.array_get %fatal_alert[%c1_i4] : !hw.array<12xstruct<d: i1, de: i1>>, i4
    %de_28 = hw.struct_extract %159["de"] : !hw.struct<d: i1, de: i1>
    %d_29 = hw.struct_extract %159["d"] : !hw.struct<d: i1, de: i1>
    %160 = llhd.sig.array_get %156[%c1_i4] : <!hw.array<12xstruct<q: i1>>>
    %161 = llhd.sig.struct_extract %160["q"] : <!hw.struct<q: i1>>
    %u_fatal_alert_val_1.qe, %u_fatal_alert_val_1.q, %u_fatal_alert_val_1.ds, %u_fatal_alert_val_1.qs = hw.instance "u_fatal_alert_val_1" @prim_subreg_9(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_28: i1, d: %d_29: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %161, %u_fatal_alert_val_1.q after %1 : i1
    llhd.drv %fatal_alert_val_1_qs, %u_fatal_alert_val_1.qs after %1 : i1
    %162 = hw.array_get %fatal_alert[%c2_i4] : !hw.array<12xstruct<d: i1, de: i1>>, i4
    %de_30 = hw.struct_extract %162["de"] : !hw.struct<d: i1, de: i1>
    %d_31 = hw.struct_extract %162["d"] : !hw.struct<d: i1, de: i1>
    %163 = llhd.sig.array_get %156[%c2_i4] : <!hw.array<12xstruct<q: i1>>>
    %164 = llhd.sig.struct_extract %163["q"] : <!hw.struct<q: i1>>
    %u_fatal_alert_val_2.qe, %u_fatal_alert_val_2.q, %u_fatal_alert_val_2.ds, %u_fatal_alert_val_2.qs = hw.instance "u_fatal_alert_val_2" @prim_subreg_9(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_30: i1, d: %d_31: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %164, %u_fatal_alert_val_2.q after %1 : i1
    llhd.drv %fatal_alert_val_2_qs, %u_fatal_alert_val_2.qs after %1 : i1
    %165 = hw.array_get %fatal_alert[%c3_i4] : !hw.array<12xstruct<d: i1, de: i1>>, i4
    %de_32 = hw.struct_extract %165["de"] : !hw.struct<d: i1, de: i1>
    %d_33 = hw.struct_extract %165["d"] : !hw.struct<d: i1, de: i1>
    %166 = llhd.sig.array_get %156[%c3_i4] : <!hw.array<12xstruct<q: i1>>>
    %167 = llhd.sig.struct_extract %166["q"] : <!hw.struct<q: i1>>
    %u_fatal_alert_val_3.qe, %u_fatal_alert_val_3.q, %u_fatal_alert_val_3.ds, %u_fatal_alert_val_3.qs = hw.instance "u_fatal_alert_val_3" @prim_subreg_9(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_32: i1, d: %d_33: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %167, %u_fatal_alert_val_3.q after %1 : i1
    llhd.drv %fatal_alert_val_3_qs, %u_fatal_alert_val_3.qs after %1 : i1
    %168 = hw.array_get %fatal_alert[%c4_i4] : !hw.array<12xstruct<d: i1, de: i1>>, i4
    %de_34 = hw.struct_extract %168["de"] : !hw.struct<d: i1, de: i1>
    %d_35 = hw.struct_extract %168["d"] : !hw.struct<d: i1, de: i1>
    %169 = llhd.sig.array_get %156[%c4_i4] : <!hw.array<12xstruct<q: i1>>>
    %170 = llhd.sig.struct_extract %169["q"] : <!hw.struct<q: i1>>
    %u_fatal_alert_val_4.qe, %u_fatal_alert_val_4.q, %u_fatal_alert_val_4.ds, %u_fatal_alert_val_4.qs = hw.instance "u_fatal_alert_val_4" @prim_subreg_9(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_34: i1, d: %d_35: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %170, %u_fatal_alert_val_4.q after %1 : i1
    llhd.drv %fatal_alert_val_4_qs, %u_fatal_alert_val_4.qs after %1 : i1
    %171 = hw.array_get %fatal_alert[%c5_i4] : !hw.array<12xstruct<d: i1, de: i1>>, i4
    %de_36 = hw.struct_extract %171["de"] : !hw.struct<d: i1, de: i1>
    %d_37 = hw.struct_extract %171["d"] : !hw.struct<d: i1, de: i1>
    %172 = llhd.sig.array_get %156[%c5_i4] : <!hw.array<12xstruct<q: i1>>>
    %173 = llhd.sig.struct_extract %172["q"] : <!hw.struct<q: i1>>
    %u_fatal_alert_val_5.qe, %u_fatal_alert_val_5.q, %u_fatal_alert_val_5.ds, %u_fatal_alert_val_5.qs = hw.instance "u_fatal_alert_val_5" @prim_subreg_9(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_36: i1, d: %d_37: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %173, %u_fatal_alert_val_5.q after %1 : i1
    llhd.drv %fatal_alert_val_5_qs, %u_fatal_alert_val_5.qs after %1 : i1
    %174 = hw.array_get %fatal_alert[%c6_i4] : !hw.array<12xstruct<d: i1, de: i1>>, i4
    %de_38 = hw.struct_extract %174["de"] : !hw.struct<d: i1, de: i1>
    %d_39 = hw.struct_extract %174["d"] : !hw.struct<d: i1, de: i1>
    %175 = llhd.sig.array_get %156[%c6_i4] : <!hw.array<12xstruct<q: i1>>>
    %176 = llhd.sig.struct_extract %175["q"] : <!hw.struct<q: i1>>
    %u_fatal_alert_val_6.qe, %u_fatal_alert_val_6.q, %u_fatal_alert_val_6.ds, %u_fatal_alert_val_6.qs = hw.instance "u_fatal_alert_val_6" @prim_subreg_9(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_38: i1, d: %d_39: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %176, %u_fatal_alert_val_6.q after %1 : i1
    llhd.drv %fatal_alert_val_6_qs, %u_fatal_alert_val_6.qs after %1 : i1
    %177 = hw.array_get %fatal_alert[%c7_i4] : !hw.array<12xstruct<d: i1, de: i1>>, i4
    %de_40 = hw.struct_extract %177["de"] : !hw.struct<d: i1, de: i1>
    %d_41 = hw.struct_extract %177["d"] : !hw.struct<d: i1, de: i1>
    %178 = llhd.sig.array_get %156[%c7_i4] : <!hw.array<12xstruct<q: i1>>>
    %179 = llhd.sig.struct_extract %178["q"] : <!hw.struct<q: i1>>
    %u_fatal_alert_val_7.qe, %u_fatal_alert_val_7.q, %u_fatal_alert_val_7.ds, %u_fatal_alert_val_7.qs = hw.instance "u_fatal_alert_val_7" @prim_subreg_9(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_40: i1, d: %d_41: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %179, %u_fatal_alert_val_7.q after %1 : i1
    llhd.drv %fatal_alert_val_7_qs, %u_fatal_alert_val_7.qs after %1 : i1
    %180 = hw.array_get %fatal_alert[%c-8_i4] : !hw.array<12xstruct<d: i1, de: i1>>, i4
    %de_42 = hw.struct_extract %180["de"] : !hw.struct<d: i1, de: i1>
    %d_43 = hw.struct_extract %180["d"] : !hw.struct<d: i1, de: i1>
    %181 = llhd.sig.array_get %156[%c-8_i4] : <!hw.array<12xstruct<q: i1>>>
    %182 = llhd.sig.struct_extract %181["q"] : <!hw.struct<q: i1>>
    %u_fatal_alert_val_8.qe, %u_fatal_alert_val_8.q, %u_fatal_alert_val_8.ds, %u_fatal_alert_val_8.qs = hw.instance "u_fatal_alert_val_8" @prim_subreg_9(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_42: i1, d: %d_43: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %182, %u_fatal_alert_val_8.q after %1 : i1
    llhd.drv %fatal_alert_val_8_qs, %u_fatal_alert_val_8.qs after %1 : i1
    %183 = hw.array_get %fatal_alert[%c-7_i4] : !hw.array<12xstruct<d: i1, de: i1>>, i4
    %de_44 = hw.struct_extract %183["de"] : !hw.struct<d: i1, de: i1>
    %d_45 = hw.struct_extract %183["d"] : !hw.struct<d: i1, de: i1>
    %184 = llhd.sig.array_get %156[%c-7_i4] : <!hw.array<12xstruct<q: i1>>>
    %185 = llhd.sig.struct_extract %184["q"] : <!hw.struct<q: i1>>
    %u_fatal_alert_val_9.qe, %u_fatal_alert_val_9.q, %u_fatal_alert_val_9.ds, %u_fatal_alert_val_9.qs = hw.instance "u_fatal_alert_val_9" @prim_subreg_9(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_44: i1, d: %d_45: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %185, %u_fatal_alert_val_9.q after %1 : i1
    llhd.drv %fatal_alert_val_9_qs, %u_fatal_alert_val_9.qs after %1 : i1
    %186 = hw.array_get %fatal_alert[%c-6_i4] : !hw.array<12xstruct<d: i1, de: i1>>, i4
    %de_46 = hw.struct_extract %186["de"] : !hw.struct<d: i1, de: i1>
    %d_47 = hw.struct_extract %186["d"] : !hw.struct<d: i1, de: i1>
    %187 = llhd.sig.array_get %156[%c-6_i4] : <!hw.array<12xstruct<q: i1>>>
    %188 = llhd.sig.struct_extract %187["q"] : <!hw.struct<q: i1>>
    %u_fatal_alert_val_10.qe, %u_fatal_alert_val_10.q, %u_fatal_alert_val_10.ds, %u_fatal_alert_val_10.qs = hw.instance "u_fatal_alert_val_10" @prim_subreg_9(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_46: i1, d: %d_47: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %188, %u_fatal_alert_val_10.q after %1 : i1
    llhd.drv %fatal_alert_val_10_qs, %u_fatal_alert_val_10.qs after %1 : i1
    %189 = hw.array_get %fatal_alert[%c-5_i4] : !hw.array<12xstruct<d: i1, de: i1>>, i4
    %de_48 = hw.struct_extract %189["de"] : !hw.struct<d: i1, de: i1>
    %d_49 = hw.struct_extract %189["d"] : !hw.struct<d: i1, de: i1>
    %190 = llhd.sig.array_get %156[%c-5_i4] : <!hw.array<12xstruct<q: i1>>>
    %191 = llhd.sig.struct_extract %190["q"] : <!hw.struct<q: i1>>
    %u_fatal_alert_val_11.qe, %u_fatal_alert_val_11.q, %u_fatal_alert_val_11.ds, %u_fatal_alert_val_11.qs = hw.instance "u_fatal_alert_val_11" @prim_subreg_9(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_48: i1, d: %d_49: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %191, %u_fatal_alert_val_11.q after %1 : i1
    llhd.drv %fatal_alert_val_11_qs, %u_fatal_alert_val_11.qs after %1 : i1
    %status = hw.struct_extract %hw2reg["status"] : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<d: i1, de: i1>, io_status_change: !hw.struct<d: i1, de: i1>>, recov_alert: !hw.array<11xstruct<d: i1, de: i1>>, fatal_alert: !hw.array<12xstruct<d: i1, de: i1>>, status: !hw.struct<io_pok: !hw.struct<d: i2, de: i1>, ast_init_done: !hw.struct<d: i1, de: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>>
    %ast_init_done = hw.struct_extract %status["ast_init_done"] : !hw.struct<io_pok: !hw.struct<d: i2, de: i1>, ast_init_done: !hw.struct<d: i1, de: i1>>
    %de_50 = hw.struct_extract %ast_init_done["de"] : !hw.struct<d: i1, de: i1>
    %d_51 = hw.struct_extract %ast_init_done["d"] : !hw.struct<d: i1, de: i1>
    %u_status_ast_init_done.qe, %u_status_ast_init_done.q, %u_status_ast_init_done.ds, %u_status_ast_init_done.qs = hw.instance "u_status_ast_init_done" @prim_subreg_9(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_50: i1, d: %d_51: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_ast_init_done_qs, %u_status_ast_init_done.qs after %1 : i1
    %io_pok = hw.struct_extract %status["io_pok"] : !hw.struct<io_pok: !hw.struct<d: i2, de: i1>, ast_init_done: !hw.struct<d: i1, de: i1>>
    %de_52 = hw.struct_extract %io_pok["de"] : !hw.struct<d: i2, de: i1>
    %d_53 = hw.struct_extract %io_pok["d"] : !hw.struct<d: i2, de: i1>
    %u_status_io_pok.qe, %u_status_io_pok.q, %u_status_io_pok.ds, %u_status_io_pok.qs = hw.instance "u_status_io_pok" @prim_subreg_10(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %c0_i2: i2, de: %de_52: i1, d: %d_53: i2) -> (qe: i1, q: i2, ds: i2, qs: i2)
    llhd.drv %status_io_pok_qs, %u_status_io_pok.qs after %1 : i2
    %192 = llhd.prb %manual_pad_attr_regwen_0_we : i1
    %u_manual_pad_attr_regwen_0.qe, %u_manual_pad_attr_regwen_0.q, %u_manual_pad_attr_regwen_0.ds, %u_manual_pad_attr_regwen_0.qs = hw.instance "u_manual_pad_attr_regwen_0" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %192: i1, wd: %310: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %manual_pad_attr_regwen_0_qs, %u_manual_pad_attr_regwen_0.qs after %1 : i1
    %193 = llhd.prb %manual_pad_attr_regwen_1_we : i1
    %u_manual_pad_attr_regwen_1.qe, %u_manual_pad_attr_regwen_1.q, %u_manual_pad_attr_regwen_1.ds, %u_manual_pad_attr_regwen_1.qs = hw.instance "u_manual_pad_attr_regwen_1" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %193: i1, wd: %310: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %manual_pad_attr_regwen_1_qs, %u_manual_pad_attr_regwen_1.qs after %1 : i1
    %194 = llhd.prb %manual_pad_attr_regwen_2_we : i1
    %u_manual_pad_attr_regwen_2.qe, %u_manual_pad_attr_regwen_2.q, %u_manual_pad_attr_regwen_2.ds, %u_manual_pad_attr_regwen_2.qs = hw.instance "u_manual_pad_attr_regwen_2" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %194: i1, wd: %310: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %manual_pad_attr_regwen_2_qs, %u_manual_pad_attr_regwen_2.qs after %1 : i1
    %195 = llhd.prb %manual_pad_attr_regwen_3_we : i1
    %u_manual_pad_attr_regwen_3.qe, %u_manual_pad_attr_regwen_3.q, %u_manual_pad_attr_regwen_3.ds, %u_manual_pad_attr_regwen_3.qs = hw.instance "u_manual_pad_attr_regwen_3" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %195: i1, wd: %310: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %manual_pad_attr_regwen_3_qs, %u_manual_pad_attr_regwen_3.qs after %1 : i1
    %196 = llhd.prb %manual_pad_attr_0_gated_we : i1
    %manual_pad_attr = hw.struct_extract %hw2reg["manual_pad_attr"] : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<d: i1, de: i1>, io_status_change: !hw.struct<d: i1, de: i1>>, recov_alert: !hw.array<11xstruct<d: i1, de: i1>>, fatal_alert: !hw.array<12xstruct<d: i1, de: i1>>, status: !hw.struct<io_pok: !hw.struct<d: i2, de: i1>, ast_init_done: !hw.struct<d: i1, de: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>>
    %197 = hw.array_get %manual_pad_attr[%c0_i2] : !hw.array<4xstruct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>, i2
    %pull_en = hw.struct_extract %197["pull_en"] : !hw.struct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>
    %d_54 = hw.struct_extract %pull_en["d"] : !hw.struct<d: i1>
    %198 = llhd.sig.extract %manual_pad_attr_0_flds_we from %c0_i2 : <i3> -> <i1>
    %199 = llhd.sig.struct_extract %reg2hw["manual_pad_attr"] : <!hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>>
    %200 = llhd.sig.array_get %199[%c0_i2] : <!hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
    %201 = llhd.sig.struct_extract %200["pull_en"] : <!hw.struct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>
    %202 = llhd.sig.struct_extract %201["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_manual_pad_attr_0_pull_en_0.qe, %u_manual_pad_attr_0_pull_en_0.qre, %u_manual_pad_attr_0_pull_en_0.q, %u_manual_pad_attr_0_pull_en_0.ds, %u_manual_pad_attr_0_pull_en_0.qs = hw.instance "u_manual_pad_attr_0_pull_en_0" @prim_subreg_ext(re: %355: i1, we: %196: i1, wd: %322: i1, d: %d_54: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %198, %u_manual_pad_attr_0_pull_en_0.qe after %1 : i1
    llhd.drv %202, %u_manual_pad_attr_0_pull_en_0.q after %1 : i1
    llhd.drv %manual_pad_attr_0_pull_en_0_qs, %u_manual_pad_attr_0_pull_en_0.qs after %1 : i1
    %pull_select = hw.struct_extract %197["pull_select"] : !hw.struct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>
    %d_55 = hw.struct_extract %pull_select["d"] : !hw.struct<d: i1>
    %203 = llhd.sig.extract %manual_pad_attr_0_flds_we from %c1_i2 : <i3> -> <i1>
    %204 = llhd.sig.struct_extract %200["pull_select"] : <!hw.struct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>
    %205 = llhd.sig.struct_extract %204["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_manual_pad_attr_0_pull_select_0.qe, %u_manual_pad_attr_0_pull_select_0.qre, %u_manual_pad_attr_0_pull_select_0.q, %u_manual_pad_attr_0_pull_select_0.ds, %u_manual_pad_attr_0_pull_select_0.qs = hw.instance "u_manual_pad_attr_0_pull_select_0" @prim_subreg_ext(re: %355: i1, we: %196: i1, wd: %323: i1, d: %d_55: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %203, %u_manual_pad_attr_0_pull_select_0.qe after %1 : i1
    llhd.drv %205, %u_manual_pad_attr_0_pull_select_0.q after %1 : i1
    llhd.drv %manual_pad_attr_0_pull_select_0_qs, %u_manual_pad_attr_0_pull_select_0.qs after %1 : i1
    %input_disable = hw.struct_extract %197["input_disable"] : !hw.struct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>
    %d_56 = hw.struct_extract %input_disable["d"] : !hw.struct<d: i1>
    %206 = llhd.sig.extract %manual_pad_attr_0_flds_we from %c-2_i2 : <i3> -> <i1>
    %207 = llhd.sig.struct_extract %200["input_disable"] : <!hw.struct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>
    %208 = llhd.sig.struct_extract %207["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_manual_pad_attr_0_input_disable_0.qe, %u_manual_pad_attr_0_input_disable_0.qre, %u_manual_pad_attr_0_input_disable_0.q, %u_manual_pad_attr_0_input_disable_0.ds, %u_manual_pad_attr_0_input_disable_0.qs = hw.instance "u_manual_pad_attr_0_input_disable_0" @prim_subreg_ext(re: %355: i1, we: %196: i1, wd: %327: i1, d: %d_56: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %206, %u_manual_pad_attr_0_input_disable_0.qe after %1 : i1
    llhd.drv %208, %u_manual_pad_attr_0_input_disable_0.q after %1 : i1
    llhd.drv %manual_pad_attr_0_input_disable_0_qs, %u_manual_pad_attr_0_input_disable_0.qs after %1 : i1
    %209 = llhd.prb %manual_pad_attr_1_gated_we : i1
    %210 = hw.array_get %manual_pad_attr[%c1_i2] : !hw.array<4xstruct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>, i2
    %pull_en_57 = hw.struct_extract %210["pull_en"] : !hw.struct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>
    %d_58 = hw.struct_extract %pull_en_57["d"] : !hw.struct<d: i1>
    %211 = llhd.sig.extract %manual_pad_attr_1_flds_we from %c0_i2 : <i3> -> <i1>
    %212 = llhd.sig.array_get %199[%c1_i2] : <!hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
    %213 = llhd.sig.struct_extract %212["pull_en"] : <!hw.struct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>
    %214 = llhd.sig.struct_extract %213["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_manual_pad_attr_1_pull_en_1.qe, %u_manual_pad_attr_1_pull_en_1.qre, %u_manual_pad_attr_1_pull_en_1.q, %u_manual_pad_attr_1_pull_en_1.ds, %u_manual_pad_attr_1_pull_en_1.qs = hw.instance "u_manual_pad_attr_1_pull_en_1" @prim_subreg_ext(re: %357: i1, we: %209: i1, wd: %322: i1, d: %d_58: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %211, %u_manual_pad_attr_1_pull_en_1.qe after %1 : i1
    llhd.drv %214, %u_manual_pad_attr_1_pull_en_1.q after %1 : i1
    llhd.drv %manual_pad_attr_1_pull_en_1_qs, %u_manual_pad_attr_1_pull_en_1.qs after %1 : i1
    %pull_select_59 = hw.struct_extract %210["pull_select"] : !hw.struct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>
    %d_60 = hw.struct_extract %pull_select_59["d"] : !hw.struct<d: i1>
    %215 = llhd.sig.extract %manual_pad_attr_1_flds_we from %c1_i2 : <i3> -> <i1>
    %216 = llhd.sig.struct_extract %212["pull_select"] : <!hw.struct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>
    %217 = llhd.sig.struct_extract %216["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_manual_pad_attr_1_pull_select_1.qe, %u_manual_pad_attr_1_pull_select_1.qre, %u_manual_pad_attr_1_pull_select_1.q, %u_manual_pad_attr_1_pull_select_1.ds, %u_manual_pad_attr_1_pull_select_1.qs = hw.instance "u_manual_pad_attr_1_pull_select_1" @prim_subreg_ext(re: %357: i1, we: %209: i1, wd: %323: i1, d: %d_60: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %215, %u_manual_pad_attr_1_pull_select_1.qe after %1 : i1
    llhd.drv %217, %u_manual_pad_attr_1_pull_select_1.q after %1 : i1
    llhd.drv %manual_pad_attr_1_pull_select_1_qs, %u_manual_pad_attr_1_pull_select_1.qs after %1 : i1
    %input_disable_61 = hw.struct_extract %210["input_disable"] : !hw.struct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>
    %d_62 = hw.struct_extract %input_disable_61["d"] : !hw.struct<d: i1>
    %218 = llhd.sig.extract %manual_pad_attr_1_flds_we from %c-2_i2 : <i3> -> <i1>
    %219 = llhd.sig.struct_extract %212["input_disable"] : <!hw.struct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>
    %220 = llhd.sig.struct_extract %219["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_manual_pad_attr_1_input_disable_1.qe, %u_manual_pad_attr_1_input_disable_1.qre, %u_manual_pad_attr_1_input_disable_1.q, %u_manual_pad_attr_1_input_disable_1.ds, %u_manual_pad_attr_1_input_disable_1.qs = hw.instance "u_manual_pad_attr_1_input_disable_1" @prim_subreg_ext(re: %357: i1, we: %209: i1, wd: %327: i1, d: %d_62: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %218, %u_manual_pad_attr_1_input_disable_1.qe after %1 : i1
    llhd.drv %220, %u_manual_pad_attr_1_input_disable_1.q after %1 : i1
    llhd.drv %manual_pad_attr_1_input_disable_1_qs, %u_manual_pad_attr_1_input_disable_1.qs after %1 : i1
    %221 = llhd.prb %manual_pad_attr_2_gated_we : i1
    %222 = hw.array_get %manual_pad_attr[%c-2_i2] : !hw.array<4xstruct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>, i2
    %pull_en_63 = hw.struct_extract %222["pull_en"] : !hw.struct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>
    %d_64 = hw.struct_extract %pull_en_63["d"] : !hw.struct<d: i1>
    %223 = llhd.sig.extract %manual_pad_attr_2_flds_we from %c0_i2 : <i3> -> <i1>
    %224 = llhd.sig.array_get %199[%c-2_i2] : <!hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
    %225 = llhd.sig.struct_extract %224["pull_en"] : <!hw.struct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>
    %226 = llhd.sig.struct_extract %225["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_manual_pad_attr_2_pull_en_2.qe, %u_manual_pad_attr_2_pull_en_2.qre, %u_manual_pad_attr_2_pull_en_2.q, %u_manual_pad_attr_2_pull_en_2.ds, %u_manual_pad_attr_2_pull_en_2.qs = hw.instance "u_manual_pad_attr_2_pull_en_2" @prim_subreg_ext(re: %359: i1, we: %221: i1, wd: %322: i1, d: %d_64: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %223, %u_manual_pad_attr_2_pull_en_2.qe after %1 : i1
    llhd.drv %226, %u_manual_pad_attr_2_pull_en_2.q after %1 : i1
    llhd.drv %manual_pad_attr_2_pull_en_2_qs, %u_manual_pad_attr_2_pull_en_2.qs after %1 : i1
    %pull_select_65 = hw.struct_extract %222["pull_select"] : !hw.struct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>
    %d_66 = hw.struct_extract %pull_select_65["d"] : !hw.struct<d: i1>
    %227 = llhd.sig.extract %manual_pad_attr_2_flds_we from %c1_i2 : <i3> -> <i1>
    %228 = llhd.sig.struct_extract %224["pull_select"] : <!hw.struct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>
    %229 = llhd.sig.struct_extract %228["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_manual_pad_attr_2_pull_select_2.qe, %u_manual_pad_attr_2_pull_select_2.qre, %u_manual_pad_attr_2_pull_select_2.q, %u_manual_pad_attr_2_pull_select_2.ds, %u_manual_pad_attr_2_pull_select_2.qs = hw.instance "u_manual_pad_attr_2_pull_select_2" @prim_subreg_ext(re: %359: i1, we: %221: i1, wd: %323: i1, d: %d_66: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %227, %u_manual_pad_attr_2_pull_select_2.qe after %1 : i1
    llhd.drv %229, %u_manual_pad_attr_2_pull_select_2.q after %1 : i1
    llhd.drv %manual_pad_attr_2_pull_select_2_qs, %u_manual_pad_attr_2_pull_select_2.qs after %1 : i1
    %input_disable_67 = hw.struct_extract %222["input_disable"] : !hw.struct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>
    %d_68 = hw.struct_extract %input_disable_67["d"] : !hw.struct<d: i1>
    %230 = llhd.sig.extract %manual_pad_attr_2_flds_we from %c-2_i2 : <i3> -> <i1>
    %231 = llhd.sig.struct_extract %224["input_disable"] : <!hw.struct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>
    %232 = llhd.sig.struct_extract %231["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_manual_pad_attr_2_input_disable_2.qe, %u_manual_pad_attr_2_input_disable_2.qre, %u_manual_pad_attr_2_input_disable_2.q, %u_manual_pad_attr_2_input_disable_2.ds, %u_manual_pad_attr_2_input_disable_2.qs = hw.instance "u_manual_pad_attr_2_input_disable_2" @prim_subreg_ext(re: %359: i1, we: %221: i1, wd: %327: i1, d: %d_68: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %230, %u_manual_pad_attr_2_input_disable_2.qe after %1 : i1
    llhd.drv %232, %u_manual_pad_attr_2_input_disable_2.q after %1 : i1
    llhd.drv %manual_pad_attr_2_input_disable_2_qs, %u_manual_pad_attr_2_input_disable_2.qs after %1 : i1
    %233 = llhd.prb %manual_pad_attr_3_gated_we : i1
    %234 = hw.array_get %manual_pad_attr[%c-1_i2] : !hw.array<4xstruct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>, i2
    %pull_en_69 = hw.struct_extract %234["pull_en"] : !hw.struct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>
    %d_70 = hw.struct_extract %pull_en_69["d"] : !hw.struct<d: i1>
    %235 = llhd.sig.extract %manual_pad_attr_3_flds_we from %c0_i2 : <i3> -> <i1>
    %236 = llhd.sig.array_get %199[%c-1_i2] : <!hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
    %237 = llhd.sig.struct_extract %236["pull_en"] : <!hw.struct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>
    %238 = llhd.sig.struct_extract %237["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_manual_pad_attr_3_pull_en_3.qe, %u_manual_pad_attr_3_pull_en_3.qre, %u_manual_pad_attr_3_pull_en_3.q, %u_manual_pad_attr_3_pull_en_3.ds, %u_manual_pad_attr_3_pull_en_3.qs = hw.instance "u_manual_pad_attr_3_pull_en_3" @prim_subreg_ext(re: %361: i1, we: %233: i1, wd: %322: i1, d: %d_70: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %235, %u_manual_pad_attr_3_pull_en_3.qe after %1 : i1
    llhd.drv %238, %u_manual_pad_attr_3_pull_en_3.q after %1 : i1
    llhd.drv %manual_pad_attr_3_pull_en_3_qs, %u_manual_pad_attr_3_pull_en_3.qs after %1 : i1
    %pull_select_71 = hw.struct_extract %234["pull_select"] : !hw.struct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>
    %d_72 = hw.struct_extract %pull_select_71["d"] : !hw.struct<d: i1>
    %239 = llhd.sig.extract %manual_pad_attr_3_flds_we from %c1_i2 : <i3> -> <i1>
    %240 = llhd.sig.struct_extract %236["pull_select"] : <!hw.struct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>
    %241 = llhd.sig.struct_extract %240["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_manual_pad_attr_3_pull_select_3.qe, %u_manual_pad_attr_3_pull_select_3.qre, %u_manual_pad_attr_3_pull_select_3.q, %u_manual_pad_attr_3_pull_select_3.ds, %u_manual_pad_attr_3_pull_select_3.qs = hw.instance "u_manual_pad_attr_3_pull_select_3" @prim_subreg_ext(re: %361: i1, we: %233: i1, wd: %323: i1, d: %d_72: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %239, %u_manual_pad_attr_3_pull_select_3.qe after %1 : i1
    llhd.drv %241, %u_manual_pad_attr_3_pull_select_3.q after %1 : i1
    llhd.drv %manual_pad_attr_3_pull_select_3_qs, %u_manual_pad_attr_3_pull_select_3.qs after %1 : i1
    %input_disable_73 = hw.struct_extract %234["input_disable"] : !hw.struct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>
    %d_74 = hw.struct_extract %input_disable_73["d"] : !hw.struct<d: i1>
    %242 = llhd.sig.extract %manual_pad_attr_3_flds_we from %c-2_i2 : <i3> -> <i1>
    %243 = llhd.sig.struct_extract %236["input_disable"] : <!hw.struct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>
    %244 = llhd.sig.struct_extract %243["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_manual_pad_attr_3_input_disable_3.qe, %u_manual_pad_attr_3_input_disable_3.qre, %u_manual_pad_attr_3_input_disable_3.q, %u_manual_pad_attr_3_input_disable_3.ds, %u_manual_pad_attr_3_input_disable_3.qs = hw.instance "u_manual_pad_attr_3_input_disable_3" @prim_subreg_ext(re: %361: i1, we: %233: i1, wd: %327: i1, d: %d_74: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %242, %u_manual_pad_attr_3_input_disable_3.qe after %1 : i1
    llhd.drv %244, %u_manual_pad_attr_3_input_disable_3.q after %1 : i1
    llhd.drv %manual_pad_attr_3_input_disable_3_qs, %u_manual_pad_attr_3_input_disable_3.qs after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %437 = llhd.prb %clk_i_0 : i1
      %438 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %439 = llhd.prb %clk_i_0 : i1
      %440 = comb.xor bin %437, %true : i1
      %441 = comb.and bin %440, %439 : i1
      %442 = llhd.prb %rst_ni_1 : i1
      %443 = comb.xor bin %442, %true : i1
      %444 = comb.and bin %438, %443 : i1
      %445 = comb.or bin %441, %444 : i1
      cf.cond_br %445, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %446 = llhd.prb %rst_ni_1 : i1
      %447 = comb.xor %446, %true : i1
      cf.cond_br %447, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %err_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %448 = llhd.prb %intg_err : i1
      %449 = llhd.prb %reg_we_err : i1
      %450 = comb.or %448, %449 : i1
      cf.cond_br %450, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %err_q, %true after %0 : i1
      cf.br ^bb1
    }
    %245 = llhd.prb %err_q : i1
    %246 = llhd.prb %intg_err : i1
    %247 = llhd.prb %reg_we_err : i1
    %248 = comb.or %245, %246, %247 : i1
    %249 = llhd.prb %reg_rdata_next {sv.namehint = "reg_rdata"} : i32
    %250 = llhd.prb %wr_err : i1
    %251 = comb.or %305, %250, %246 {sv.namehint = "reg_error"} : i1
    %252 = llhd.prb %intr_test_flds_we : i2
    %253 = comb.icmp eq %252, %c-1_i2 {sv.namehint = "intr_test_qe"} : i2
    %254 = llhd.sig.struct_extract %24["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %254, %253 after %1 : i1
    %255 = llhd.sig.struct_extract %27["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %255, %253 after %1 : i1
    %256 = llhd.prb %alert_test_flds_we : i2
    %257 = comb.icmp eq %256, %c-1_i2 {sv.namehint = "alert_test_qe"} : i2
    %258 = llhd.sig.struct_extract %32["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %258, %257 after %1 : i1
    %259 = llhd.sig.struct_extract %35["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %259, %257 after %1 : i1
    %260 = llhd.prb %cfg_regwen_qs : i1
    %261 = comb.and %331, %6, %308, %260 : i1
    llhd.drv %alert_en_0_gated_we, %261 after %1 : i1
    %262 = comb.and %333, %6, %308, %260 : i1
    llhd.drv %alert_en_1_gated_we, %262 after %1 : i1
    %263 = comb.and %334, %6, %308, %260 : i1
    llhd.drv %alert_en_2_gated_we, %263 after %1 : i1
    %264 = comb.and %335, %6, %308, %260 : i1
    llhd.drv %alert_en_3_gated_we, %264 after %1 : i1
    %265 = comb.and %336, %6, %308, %260 : i1
    llhd.drv %alert_en_4_gated_we, %265 after %1 : i1
    %266 = comb.and %337, %6, %308, %260 : i1
    llhd.drv %alert_en_5_gated_we, %266 after %1 : i1
    %267 = comb.and %338, %6, %308, %260 : i1
    llhd.drv %alert_en_6_gated_we, %267 after %1 : i1
    %268 = comb.and %339, %6, %308, %260 : i1
    llhd.drv %alert_en_7_gated_we, %268 after %1 : i1
    %269 = comb.and %340, %6, %308, %260 : i1
    llhd.drv %alert_en_8_gated_we, %269 after %1 : i1
    %270 = comb.and %341, %6, %308, %260 : i1
    llhd.drv %alert_en_9_gated_we, %270 after %1 : i1
    %271 = comb.and %342, %6, %308, %260 : i1
    llhd.drv %alert_en_10_gated_we, %271 after %1 : i1
    %272 = comb.and %343, %6, %308, %260 : i1
    llhd.drv %fatal_alert_en_gated_we, %272 after %1 : i1
    %273 = llhd.prb %manual_pad_attr_0_flds_we : i3
    %274 = comb.icmp eq %273, %c-1_i3 {sv.namehint = "manual_pad_attr_0_qe"} : i3
    %275 = llhd.prb %manual_pad_attr_regwen_0_qs : i1
    %276 = comb.and %354, %6, %308, %275 : i1
    llhd.drv %manual_pad_attr_0_gated_we, %276 after %1 : i1
    %277 = llhd.sig.struct_extract %201["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %277, %274 after %1 : i1
    %278 = llhd.sig.struct_extract %204["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %278, %274 after %1 : i1
    %279 = llhd.sig.struct_extract %207["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %279, %274 after %1 : i1
    %280 = llhd.prb %manual_pad_attr_1_flds_we : i3
    %281 = comb.icmp eq %280, %c-1_i3 {sv.namehint = "manual_pad_attr_1_qe"} : i3
    %282 = llhd.prb %manual_pad_attr_regwen_1_qs : i1
    %283 = comb.and %356, %6, %308, %282 : i1
    llhd.drv %manual_pad_attr_1_gated_we, %283 after %1 : i1
    %284 = llhd.sig.struct_extract %213["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %284, %281 after %1 : i1
    %285 = llhd.sig.struct_extract %216["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %285, %281 after %1 : i1
    %286 = llhd.sig.struct_extract %219["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %286, %281 after %1 : i1
    %287 = llhd.prb %manual_pad_attr_2_flds_we : i3
    %288 = comb.icmp eq %287, %c-1_i3 {sv.namehint = "manual_pad_attr_2_qe"} : i3
    %289 = llhd.prb %manual_pad_attr_regwen_2_qs : i1
    %290 = comb.and %358, %6, %308, %289 : i1
    llhd.drv %manual_pad_attr_2_gated_we, %290 after %1 : i1
    %291 = llhd.sig.struct_extract %225["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %291, %288 after %1 : i1
    %292 = llhd.sig.struct_extract %228["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %292, %288 after %1 : i1
    %293 = llhd.sig.struct_extract %231["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %293, %288 after %1 : i1
    %294 = llhd.prb %manual_pad_attr_3_flds_we : i3
    %295 = comb.icmp eq %294, %c-1_i3 {sv.namehint = "manual_pad_attr_3_qe"} : i3
    %296 = llhd.prb %manual_pad_attr_regwen_3_qs : i1
    %297 = comb.and %360, %6, %308, %296 : i1
    llhd.drv %manual_pad_attr_3_gated_we, %297 after %1 : i1
    %298 = llhd.sig.struct_extract %237["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %298, %295 after %1 : i1
    %299 = llhd.sig.struct_extract %240["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %299, %295 after %1 : i1
    %300 = llhd.sig.struct_extract %243["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %300, %295 after %1 : i1
    %301 = llhd.prb %addr_hit : i29
    %302 = llhd.prb %reg_addr : i7
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %437 = llhd.sig.extract %addr_hit from %c0_i5 : <i29> -> <i1>
      %438 = llhd.prb %reg_addr : i7
      %439 = comb.icmp eq %438, %c0_i7 : i7
      llhd.drv %437, %439 after %1 : i1
      %440 = llhd.sig.extract %addr_hit from %c1_i5 : <i29> -> <i1>
      %441 = llhd.prb %reg_addr : i7
      %442 = comb.icmp eq %441, %c4_i7 : i7
      llhd.drv %440, %442 after %1 : i1
      %443 = llhd.sig.extract %addr_hit from %c2_i5 : <i29> -> <i1>
      %444 = llhd.prb %reg_addr : i7
      %445 = comb.icmp eq %444, %c8_i7 : i7
      llhd.drv %443, %445 after %1 : i1
      %446 = llhd.sig.extract %addr_hit from %c3_i5 : <i29> -> <i1>
      %447 = llhd.prb %reg_addr : i7
      %448 = comb.icmp eq %447, %c12_i7 : i7
      llhd.drv %446, %448 after %1 : i1
      %449 = llhd.sig.extract %addr_hit from %c4_i5 : <i29> -> <i1>
      %450 = llhd.prb %reg_addr : i7
      %451 = comb.icmp eq %450, %c16_i7 : i7
      llhd.drv %449, %451 after %1 : i1
      %452 = llhd.sig.extract %addr_hit from %c5_i5 : <i29> -> <i1>
      %453 = llhd.prb %reg_addr : i7
      %454 = comb.icmp eq %453, %c20_i7 : i7
      llhd.drv %452, %454 after %1 : i1
      %455 = llhd.sig.extract %addr_hit from %c6_i5 : <i29> -> <i1>
      %456 = llhd.prb %reg_addr : i7
      %457 = comb.icmp eq %456, %c24_i7 : i7
      llhd.drv %455, %457 after %1 : i1
      %458 = llhd.sig.extract %addr_hit from %c7_i5 : <i29> -> <i1>
      %459 = llhd.prb %reg_addr : i7
      %460 = comb.icmp eq %459, %c28_i7 : i7
      llhd.drv %458, %460 after %1 : i1
      %461 = llhd.sig.extract %addr_hit from %c8_i5 : <i29> -> <i1>
      %462 = llhd.prb %reg_addr : i7
      %463 = comb.icmp eq %462, %c32_i7 : i7
      llhd.drv %461, %463 after %1 : i1
      %464 = llhd.sig.extract %addr_hit from %c9_i5 : <i29> -> <i1>
      %465 = llhd.prb %reg_addr : i7
      %466 = comb.icmp eq %465, %c36_i7 : i7
      llhd.drv %464, %466 after %1 : i1
      %467 = llhd.sig.extract %addr_hit from %c10_i5 : <i29> -> <i1>
      %468 = llhd.prb %reg_addr : i7
      %469 = comb.icmp eq %468, %c40_i7 : i7
      llhd.drv %467, %469 after %1 : i1
      %470 = llhd.sig.extract %addr_hit from %c11_i5 : <i29> -> <i1>
      %471 = llhd.prb %reg_addr : i7
      %472 = comb.icmp eq %471, %c44_i7 : i7
      llhd.drv %470, %472 after %1 : i1
      %473 = llhd.sig.extract %addr_hit from %c12_i5 : <i29> -> <i1>
      %474 = llhd.prb %reg_addr : i7
      %475 = comb.icmp eq %474, %c48_i7 : i7
      llhd.drv %473, %475 after %1 : i1
      %476 = llhd.sig.extract %addr_hit from %c13_i5 : <i29> -> <i1>
      %477 = llhd.prb %reg_addr : i7
      %478 = comb.icmp eq %477, %c52_i7 : i7
      llhd.drv %476, %478 after %1 : i1
      %479 = llhd.sig.extract %addr_hit from %c14_i5 : <i29> -> <i1>
      %480 = llhd.prb %reg_addr : i7
      %481 = comb.icmp eq %480, %c56_i7 : i7
      llhd.drv %479, %481 after %1 : i1
      %482 = llhd.sig.extract %addr_hit from %c15_i5 : <i29> -> <i1>
      %483 = llhd.prb %reg_addr : i7
      %484 = comb.icmp eq %483, %c60_i7 : i7
      llhd.drv %482, %484 after %1 : i1
      %485 = llhd.sig.extract %addr_hit from %c-16_i5 : <i29> -> <i1>
      %486 = llhd.prb %reg_addr : i7
      %487 = comb.icmp eq %486, %c-64_i7 : i7
      llhd.drv %485, %487 after %1 : i1
      %488 = llhd.sig.extract %addr_hit from %c-15_i5 : <i29> -> <i1>
      %489 = llhd.prb %reg_addr : i7
      %490 = comb.icmp eq %489, %c-60_i7 : i7
      llhd.drv %488, %490 after %1 : i1
      %491 = llhd.sig.extract %addr_hit from %c-14_i5 : <i29> -> <i1>
      %492 = llhd.prb %reg_addr : i7
      %493 = comb.icmp eq %492, %c-56_i7 : i7
      llhd.drv %491, %493 after %1 : i1
      %494 = llhd.sig.extract %addr_hit from %c-13_i5 : <i29> -> <i1>
      %495 = llhd.prb %reg_addr : i7
      %496 = comb.icmp eq %495, %c-52_i7 : i7
      llhd.drv %494, %496 after %1 : i1
      %497 = llhd.sig.extract %addr_hit from %c-12_i5 : <i29> -> <i1>
      %498 = llhd.prb %reg_addr : i7
      %499 = comb.icmp eq %498, %c-48_i7 : i7
      llhd.drv %497, %499 after %1 : i1
      %500 = llhd.sig.extract %addr_hit from %c-11_i5 : <i29> -> <i1>
      %501 = llhd.prb %reg_addr : i7
      %502 = comb.icmp eq %501, %c-44_i7 : i7
      llhd.drv %500, %502 after %1 : i1
      %503 = llhd.sig.extract %addr_hit from %c-10_i5 : <i29> -> <i1>
      %504 = llhd.prb %reg_addr : i7
      %505 = comb.icmp eq %504, %c-40_i7 : i7
      llhd.drv %503, %505 after %1 : i1
      %506 = llhd.sig.extract %addr_hit from %c-9_i5 : <i29> -> <i1>
      %507 = llhd.prb %reg_addr : i7
      %508 = comb.icmp eq %507, %c-36_i7 : i7
      llhd.drv %506, %508 after %1 : i1
      %509 = llhd.sig.extract %addr_hit from %c-8_i5 : <i29> -> <i1>
      %510 = llhd.prb %reg_addr : i7
      %511 = comb.icmp eq %510, %c-32_i7 : i7
      llhd.drv %509, %511 after %1 : i1
      %512 = llhd.sig.extract %addr_hit from %c-7_i5 : <i29> -> <i1>
      %513 = llhd.prb %reg_addr : i7
      %514 = comb.icmp eq %513, %c-28_i7 : i7
      llhd.drv %512, %514 after %1 : i1
      %515 = llhd.sig.extract %addr_hit from %c-6_i5 : <i29> -> <i1>
      %516 = llhd.prb %reg_addr : i7
      %517 = comb.icmp eq %516, %c-24_i7 : i7
      llhd.drv %515, %517 after %1 : i1
      %518 = llhd.sig.extract %addr_hit from %c-5_i5 : <i29> -> <i1>
      %519 = llhd.prb %reg_addr : i7
      %520 = comb.icmp eq %519, %c-20_i7 : i7
      llhd.drv %518, %520 after %1 : i1
      %521 = llhd.sig.extract %addr_hit from %c-4_i5 : <i29> -> <i1>
      %522 = llhd.prb %reg_addr : i7
      %523 = comb.icmp eq %522, %c-16_i7 : i7
      llhd.drv %521, %523 after %1 : i1
      llhd.wait (%301, %302 : i29, i7), ^bb1
    }
    %303 = comb.or %u_reg_if.re_o, %6 : i1
    %304 = comb.icmp eq %301, %c0_i29 : i29
    %305 = comb.and %303, %304 {sv.namehint = "addrmiss"} : i1
    %306 = llhd.prb %reg_be : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %437 = llhd.prb %reg_we : i1
      %438 = llhd.prb %addr_hit : i29
      %439 = comb.extract %438 from 0 : (i29) -> i1
      %440 = llhd.prb %reg_be : i4
      %441 = comb.extract %440 from 0 : (i4) -> i2
      %442 = comb.extract %440 from 0 : (i4) -> i1
      %443 = comb.xor %442, %true : i1
      %444 = comb.and %439, %443 : i1
      %445 = comb.extract %438 from 1 : (i29) -> i1
      %446 = comb.and %445, %443 : i1
      %447 = comb.extract %438 from 2 : (i29) -> i1
      %448 = comb.and %447, %443 : i1
      %449 = comb.extract %438 from 3 : (i29) -> i1
      %450 = comb.and %449, %443 : i1
      %451 = comb.extract %438 from 4 : (i29) -> i1
      %452 = comb.and %451, %443 : i1
      %453 = comb.extract %438 from 5 : (i29) -> i1
      %454 = comb.icmp ne %441, %c-1_i2 : i2
      %455 = comb.and %453, %454 : i1
      %456 = comb.extract %438 from 6 : (i29) -> i1
      %457 = comb.and %456, %443 : i1
      %458 = comb.extract %438 from 7 : (i29) -> i1
      %459 = comb.and %458, %443 : i1
      %460 = comb.extract %438 from 8 : (i29) -> i1
      %461 = comb.and %460, %443 : i1
      %462 = comb.extract %438 from 9 : (i29) -> i1
      %463 = comb.and %462, %443 : i1
      %464 = comb.extract %438 from 10 : (i29) -> i1
      %465 = comb.and %464, %443 : i1
      %466 = comb.extract %438 from 11 : (i29) -> i1
      %467 = comb.and %466, %443 : i1
      %468 = comb.extract %438 from 12 : (i29) -> i1
      %469 = comb.and %468, %443 : i1
      %470 = comb.extract %438 from 13 : (i29) -> i1
      %471 = comb.and %470, %443 : i1
      %472 = comb.extract %438 from 14 : (i29) -> i1
      %473 = comb.and %472, %443 : i1
      %474 = comb.extract %438 from 15 : (i29) -> i1
      %475 = comb.and %474, %443 : i1
      %476 = comb.extract %438 from 16 : (i29) -> i1
      %477 = comb.and %476, %443 : i1
      %478 = comb.extract %438 from 17 : (i29) -> i1
      %479 = comb.icmp ne %441, %c-1_i2 : i2
      %480 = comb.and %478, %479 : i1
      %481 = comb.extract %438 from 18 : (i29) -> i1
      %482 = comb.icmp ne %441, %c-1_i2 : i2
      %483 = comb.and %481, %482 : i1
      %484 = comb.extract %438 from 19 : (i29) -> i1
      %485 = comb.icmp ne %441, %c-1_i2 : i2
      %486 = comb.and %484, %485 : i1
      %487 = comb.extract %438 from 20 : (i29) -> i1
      %488 = comb.and %487, %443 : i1
      %489 = comb.extract %438 from 21 : (i29) -> i1
      %490 = comb.and %489, %443 : i1
      %491 = comb.extract %438 from 22 : (i29) -> i1
      %492 = comb.and %491, %443 : i1
      %493 = comb.extract %438 from 23 : (i29) -> i1
      %494 = comb.and %493, %443 : i1
      %495 = comb.extract %438 from 24 : (i29) -> i1
      %496 = comb.and %495, %443 : i1
      %497 = comb.extract %438 from 25 : (i29) -> i1
      %498 = comb.and %497, %443 : i1
      %499 = comb.extract %438 from 26 : (i29) -> i1
      %500 = comb.and %499, %443 : i1
      %501 = comb.extract %438 from 27 : (i29) -> i1
      %502 = comb.and %501, %443 : i1
      %503 = comb.extract %438 from 28 : (i29) -> i1
      %504 = comb.and %503, %443 : i1
      %505 = comb.or %444, %446, %448, %450, %452, %455, %457, %459, %461, %463, %465, %467, %469, %471, %473, %475, %477, %480, %483, %486, %488, %490, %492, %494, %496, %498, %500, %502, %504 : i1
      %506 = comb.and %437, %505 : i1
      llhd.drv %wr_err, %506 after %1 : i1
      llhd.wait (%6, %301, %306, %250 : i1, i29, i4, i1), ^bb1
    }
    %307 = comb.extract %301 from 0 : (i29) -> i1
    %308 = comb.xor %251, %true : i1
    %309 = comb.and %307, %6, %308 : i1
    llhd.drv %intr_state_we, %309 after %1 : i1
    %310 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "cfg_regwen_wd"} : (i32) -> i1
    %311 = comb.extract %u_reg_if.wdata_o from 1 {sv.namehint = "alert_trig_val_1_wd"} : (i32) -> i1
    %312 = comb.extract %301 from 1 : (i29) -> i1
    %313 = comb.and %312, %6, %308 : i1
    llhd.drv %intr_enable_we, %313 after %1 : i1
    %314 = comb.extract %301 from 2 : (i29) -> i1
    %315 = comb.and %314, %6, %308 : i1
    llhd.drv %intr_test_we, %315 after %1 : i1
    %316 = comb.extract %301 from 3 : (i29) -> i1
    %317 = comb.and %316, %6, %308 : i1
    llhd.drv %alert_test_we, %317 after %1 : i1
    %318 = comb.extract %301 from 4 : (i29) -> i1
    %319 = comb.and %318, %6, %308 : i1
    llhd.drv %cfg_regwen_we, %319 after %1 : i1
    %320 = comb.extract %301 from 5 : (i29) -> i1
    %321 = comb.and %320, %6, %308 : i1
    llhd.drv %alert_trig_we, %321 after %1 : i1
    %322 = comb.extract %u_reg_if.wdata_o from 2 {sv.namehint = "alert_trig_val_2_wd"} : (i32) -> i1
    %323 = comb.extract %u_reg_if.wdata_o from 3 {sv.namehint = "alert_trig_val_3_wd"} : (i32) -> i1
    %324 = comb.extract %u_reg_if.wdata_o from 4 {sv.namehint = "alert_trig_val_4_wd"} : (i32) -> i1
    %325 = comb.extract %u_reg_if.wdata_o from 5 {sv.namehint = "alert_trig_val_5_wd"} : (i32) -> i1
    %326 = comb.extract %u_reg_if.wdata_o from 6 {sv.namehint = "alert_trig_val_6_wd"} : (i32) -> i1
    %327 = comb.extract %u_reg_if.wdata_o from 7 {sv.namehint = "alert_trig_val_7_wd"} : (i32) -> i1
    %328 = comb.extract %u_reg_if.wdata_o from 8 {sv.namehint = "alert_trig_val_8_wd"} : (i32) -> i1
    %329 = comb.extract %u_reg_if.wdata_o from 9 {sv.namehint = "alert_trig_val_9_wd"} : (i32) -> i1
    %330 = comb.extract %u_reg_if.wdata_o from 10 {sv.namehint = "alert_trig_val_10_wd"} : (i32) -> i1
    %331 = comb.extract %301 from 6 : (i29) -> i1
    %332 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "alert_en_9_wd"} : (i32) -> i4
    %333 = comb.extract %301 from 7 : (i29) -> i1
    %334 = comb.extract %301 from 8 : (i29) -> i1
    %335 = comb.extract %301 from 9 : (i29) -> i1
    %336 = comb.extract %301 from 10 : (i29) -> i1
    %337 = comb.extract %301 from 11 : (i29) -> i1
    %338 = comb.extract %301 from 12 : (i29) -> i1
    %339 = comb.extract %301 from 13 : (i29) -> i1
    %340 = comb.extract %301 from 14 : (i29) -> i1
    %341 = comb.extract %301 from 15 : (i29) -> i1
    %342 = comb.extract %301 from 16 : (i29) -> i1
    %343 = comb.extract %301 from 17 : (i29) -> i1
    %344 = comb.extract %301 from 18 : (i29) -> i1
    %345 = comb.and %344, %6, %308 : i1
    llhd.drv %recov_alert_we, %345 after %1 : i1
    %346 = comb.extract %301 from 21 : (i29) -> i1
    %347 = comb.and %346, %6, %308 : i1
    llhd.drv %manual_pad_attr_regwen_0_we, %347 after %1 : i1
    %348 = comb.extract %301 from 22 : (i29) -> i1
    %349 = comb.and %348, %6, %308 : i1
    llhd.drv %manual_pad_attr_regwen_1_we, %349 after %1 : i1
    %350 = comb.extract %301 from 23 : (i29) -> i1
    %351 = comb.and %350, %6, %308 : i1
    llhd.drv %manual_pad_attr_regwen_2_we, %351 after %1 : i1
    %352 = comb.extract %301 from 24 : (i29) -> i1
    %353 = comb.and %352, %6, %308 : i1
    llhd.drv %manual_pad_attr_regwen_3_we, %353 after %1 : i1
    %354 = comb.extract %301 from 25 : (i29) -> i1
    %355 = comb.and %354, %u_reg_if.re_o, %308 {sv.namehint = "manual_pad_attr_0_re"} : i1
    %356 = comb.extract %301 from 26 : (i29) -> i1
    %357 = comb.and %356, %u_reg_if.re_o, %308 {sv.namehint = "manual_pad_attr_1_re"} : i1
    %358 = comb.extract %301 from 27 : (i29) -> i1
    %359 = comb.and %358, %u_reg_if.re_o, %308 {sv.namehint = "manual_pad_attr_2_re"} : i1
    %360 = comb.extract %301 from 28 : (i29) -> i1
    %361 = comb.and %360, %u_reg_if.re_o, %308 {sv.namehint = "manual_pad_attr_3_re"} : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %437 = llhd.sig.extract %reg_we_check from %c0_i5 : <i29> -> <i1>
      %438 = llhd.prb %intr_state_we : i1
      llhd.drv %437, %438 after %1 : i1
      %439 = llhd.sig.extract %reg_we_check from %c1_i5 : <i29> -> <i1>
      %440 = llhd.prb %intr_enable_we : i1
      llhd.drv %439, %440 after %1 : i1
      %441 = llhd.sig.extract %reg_we_check from %c2_i5 : <i29> -> <i1>
      %442 = llhd.prb %intr_test_we : i1
      llhd.drv %441, %442 after %1 : i1
      %443 = llhd.sig.extract %reg_we_check from %c3_i5 : <i29> -> <i1>
      %444 = llhd.prb %alert_test_we : i1
      llhd.drv %443, %444 after %1 : i1
      %445 = llhd.sig.extract %reg_we_check from %c4_i5 : <i29> -> <i1>
      %446 = llhd.prb %cfg_regwen_we : i1
      llhd.drv %445, %446 after %1 : i1
      %447 = llhd.sig.extract %reg_we_check from %c5_i5 : <i29> -> <i1>
      %448 = llhd.prb %alert_trig_we : i1
      llhd.drv %447, %448 after %1 : i1
      %449 = llhd.sig.extract %reg_we_check from %c6_i5 : <i29> -> <i1>
      %450 = llhd.prb %alert_en_0_gated_we : i1
      llhd.drv %449, %450 after %1 : i1
      %451 = llhd.sig.extract %reg_we_check from %c7_i5 : <i29> -> <i1>
      %452 = llhd.prb %alert_en_1_gated_we : i1
      llhd.drv %451, %452 after %1 : i1
      %453 = llhd.sig.extract %reg_we_check from %c8_i5 : <i29> -> <i1>
      %454 = llhd.prb %alert_en_2_gated_we : i1
      llhd.drv %453, %454 after %1 : i1
      %455 = llhd.sig.extract %reg_we_check from %c9_i5 : <i29> -> <i1>
      %456 = llhd.prb %alert_en_3_gated_we : i1
      llhd.drv %455, %456 after %1 : i1
      %457 = llhd.sig.extract %reg_we_check from %c10_i5 : <i29> -> <i1>
      %458 = llhd.prb %alert_en_4_gated_we : i1
      llhd.drv %457, %458 after %1 : i1
      %459 = llhd.sig.extract %reg_we_check from %c11_i5 : <i29> -> <i1>
      %460 = llhd.prb %alert_en_5_gated_we : i1
      llhd.drv %459, %460 after %1 : i1
      %461 = llhd.sig.extract %reg_we_check from %c12_i5 : <i29> -> <i1>
      %462 = llhd.prb %alert_en_6_gated_we : i1
      llhd.drv %461, %462 after %1 : i1
      %463 = llhd.sig.extract %reg_we_check from %c13_i5 : <i29> -> <i1>
      %464 = llhd.prb %alert_en_7_gated_we : i1
      llhd.drv %463, %464 after %1 : i1
      %465 = llhd.sig.extract %reg_we_check from %c14_i5 : <i29> -> <i1>
      %466 = llhd.prb %alert_en_8_gated_we : i1
      llhd.drv %465, %466 after %1 : i1
      %467 = llhd.sig.extract %reg_we_check from %c15_i5 : <i29> -> <i1>
      %468 = llhd.prb %alert_en_9_gated_we : i1
      llhd.drv %467, %468 after %1 : i1
      %469 = llhd.sig.extract %reg_we_check from %c-16_i5 : <i29> -> <i1>
      %470 = llhd.prb %alert_en_10_gated_we : i1
      llhd.drv %469, %470 after %1 : i1
      %471 = llhd.sig.extract %reg_we_check from %c-15_i5 : <i29> -> <i1>
      %472 = llhd.prb %fatal_alert_en_gated_we : i1
      llhd.drv %471, %472 after %1 : i1
      %473 = llhd.sig.extract %reg_we_check from %c-14_i5 : <i29> -> <i1>
      %474 = llhd.prb %recov_alert_we : i1
      llhd.drv %473, %474 after %1 : i1
      %475 = llhd.sig.extract %reg_we_check from %c-13_i5 : <i29> -> <i1>
      llhd.drv %475, %false after %1 : i1
      %476 = llhd.sig.extract %reg_we_check from %c-12_i5 : <i29> -> <i1>
      llhd.drv %476, %false after %1 : i1
      %477 = llhd.sig.extract %reg_we_check from %c-11_i5 : <i29> -> <i1>
      %478 = llhd.prb %manual_pad_attr_regwen_0_we : i1
      llhd.drv %477, %478 after %1 : i1
      %479 = llhd.sig.extract %reg_we_check from %c-10_i5 : <i29> -> <i1>
      %480 = llhd.prb %manual_pad_attr_regwen_1_we : i1
      llhd.drv %479, %480 after %1 : i1
      %481 = llhd.sig.extract %reg_we_check from %c-9_i5 : <i29> -> <i1>
      %482 = llhd.prb %manual_pad_attr_regwen_2_we : i1
      llhd.drv %481, %482 after %1 : i1
      %483 = llhd.sig.extract %reg_we_check from %c-8_i5 : <i29> -> <i1>
      %484 = llhd.prb %manual_pad_attr_regwen_3_we : i1
      llhd.drv %483, %484 after %1 : i1
      %485 = llhd.sig.extract %reg_we_check from %c-7_i5 : <i29> -> <i1>
      %486 = llhd.prb %manual_pad_attr_0_gated_we : i1
      llhd.drv %485, %486 after %1 : i1
      %487 = llhd.sig.extract %reg_we_check from %c-6_i5 : <i29> -> <i1>
      %488 = llhd.prb %manual_pad_attr_1_gated_we : i1
      llhd.drv %487, %488 after %1 : i1
      %489 = llhd.sig.extract %reg_we_check from %c-5_i5 : <i29> -> <i1>
      %490 = llhd.prb %manual_pad_attr_2_gated_we : i1
      llhd.drv %489, %490 after %1 : i1
      %491 = llhd.sig.extract %reg_we_check from %c-4_i5 : <i29> -> <i1>
      %492 = llhd.prb %manual_pad_attr_3_gated_we : i1
      llhd.drv %491, %492 after %1 : i1
      llhd.wait (%5, %9, %15, %21, %29, %37, %38, %62, %66, %69, %72, %75, %78, %81, %84, %87, %90, %93, %96, %120, %192, %193, %194, %195, %196, %209, %221, %233 : i29, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    %362 = llhd.prb %intr_state_io_status_change_qs : i1
    %363 = llhd.prb %intr_state_init_status_change_qs : i1
    %364 = llhd.prb %intr_enable_io_status_change_qs : i1
    %365 = llhd.prb %intr_enable_init_status_change_qs : i1
    %366 = llhd.prb %alert_trig_val_0_qs : i1
    %367 = llhd.prb %alert_trig_val_1_qs : i1
    %368 = llhd.prb %alert_trig_val_2_qs : i1
    %369 = llhd.prb %alert_trig_val_3_qs : i1
    %370 = llhd.prb %alert_trig_val_4_qs : i1
    %371 = llhd.prb %alert_trig_val_5_qs : i1
    %372 = llhd.prb %alert_trig_val_6_qs : i1
    %373 = llhd.prb %alert_trig_val_7_qs : i1
    %374 = llhd.prb %alert_trig_val_8_qs : i1
    %375 = llhd.prb %alert_trig_val_9_qs : i1
    %376 = llhd.prb %alert_trig_val_10_qs : i1
    %377 = llhd.prb %alert_en_0_qs : i4
    %378 = llhd.prb %alert_en_1_qs : i4
    %379 = llhd.prb %alert_en_2_qs : i4
    %380 = llhd.prb %alert_en_3_qs : i4
    %381 = llhd.prb %alert_en_4_qs : i4
    %382 = llhd.prb %alert_en_5_qs : i4
    %383 = llhd.prb %alert_en_6_qs : i4
    %384 = llhd.prb %alert_en_7_qs : i4
    %385 = llhd.prb %alert_en_8_qs : i4
    %386 = llhd.prb %alert_en_9_qs : i4
    %387 = llhd.prb %alert_en_10_qs : i4
    %388 = llhd.prb %fatal_alert_en_val_0_qs : i1
    %389 = llhd.prb %fatal_alert_en_val_1_qs : i1
    %390 = llhd.prb %fatal_alert_en_val_2_qs : i1
    %391 = llhd.prb %fatal_alert_en_val_3_qs : i1
    %392 = llhd.prb %fatal_alert_en_val_4_qs : i1
    %393 = llhd.prb %fatal_alert_en_val_5_qs : i1
    %394 = llhd.prb %fatal_alert_en_val_6_qs : i1
    %395 = llhd.prb %fatal_alert_en_val_7_qs : i1
    %396 = llhd.prb %fatal_alert_en_val_8_qs : i1
    %397 = llhd.prb %fatal_alert_en_val_9_qs : i1
    %398 = llhd.prb %fatal_alert_en_val_10_qs : i1
    %399 = llhd.prb %recov_alert_val_0_qs : i1
    %400 = llhd.prb %recov_alert_val_1_qs : i1
    %401 = llhd.prb %recov_alert_val_2_qs : i1
    %402 = llhd.prb %recov_alert_val_3_qs : i1
    %403 = llhd.prb %recov_alert_val_4_qs : i1
    %404 = llhd.prb %recov_alert_val_5_qs : i1
    %405 = llhd.prb %recov_alert_val_6_qs : i1
    %406 = llhd.prb %recov_alert_val_7_qs : i1
    %407 = llhd.prb %recov_alert_val_8_qs : i1
    %408 = llhd.prb %recov_alert_val_9_qs : i1
    %409 = llhd.prb %recov_alert_val_10_qs : i1
    %410 = llhd.prb %fatal_alert_val_0_qs : i1
    %411 = llhd.prb %fatal_alert_val_1_qs : i1
    %412 = llhd.prb %fatal_alert_val_2_qs : i1
    %413 = llhd.prb %fatal_alert_val_3_qs : i1
    %414 = llhd.prb %fatal_alert_val_4_qs : i1
    %415 = llhd.prb %fatal_alert_val_5_qs : i1
    %416 = llhd.prb %fatal_alert_val_6_qs : i1
    %417 = llhd.prb %fatal_alert_val_7_qs : i1
    %418 = llhd.prb %fatal_alert_val_8_qs : i1
    %419 = llhd.prb %fatal_alert_val_9_qs : i1
    %420 = llhd.prb %fatal_alert_val_10_qs : i1
    %421 = llhd.prb %fatal_alert_val_11_qs : i1
    %422 = llhd.prb %status_ast_init_done_qs : i1
    %423 = llhd.prb %status_io_pok_qs : i2
    %424 = llhd.prb %manual_pad_attr_0_pull_en_0_qs : i1
    %425 = llhd.prb %manual_pad_attr_0_pull_select_0_qs : i1
    %426 = llhd.prb %manual_pad_attr_0_input_disable_0_qs : i1
    %427 = llhd.prb %manual_pad_attr_1_pull_en_1_qs : i1
    %428 = llhd.prb %manual_pad_attr_1_pull_select_1_qs : i1
    %429 = llhd.prb %manual_pad_attr_1_input_disable_1_qs : i1
    %430 = llhd.prb %manual_pad_attr_2_pull_en_2_qs : i1
    %431 = llhd.prb %manual_pad_attr_2_pull_select_2_qs : i1
    %432 = llhd.prb %manual_pad_attr_2_input_disable_2_qs : i1
    %433 = llhd.prb %manual_pad_attr_3_pull_en_3_qs : i1
    %434 = llhd.prb %manual_pad_attr_3_pull_select_3_qs : i1
    %435 = llhd.prb %manual_pad_attr_3_input_disable_3_qs : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb60
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      %437 = llhd.prb %addr_hit : i29
      %438 = comb.extract %437 from 0 : (i29) -> i1
      %439 = comb.icmp ceq %438, %true : i1
      cf.cond_br %439, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %440 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %441 = llhd.prb %intr_state_io_status_change_qs : i1
      llhd.drv %440, %441 after %1 : i1
      %442 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %443 = llhd.prb %intr_state_init_status_change_qs : i1
      llhd.drv %442, %443 after %1 : i1
      cf.br ^bb60
    ^bb3:  // pred: ^bb1
      %444 = llhd.prb %addr_hit : i29
      %445 = comb.extract %444 from 1 : (i29) -> i1
      %446 = comb.icmp ceq %445, %true : i1
      cf.cond_br %446, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %447 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %448 = llhd.prb %intr_enable_io_status_change_qs : i1
      llhd.drv %447, %448 after %1 : i1
      %449 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %450 = llhd.prb %intr_enable_init_status_change_qs : i1
      llhd.drv %449, %450 after %1 : i1
      cf.br ^bb60
    ^bb5:  // pred: ^bb3
      %451 = llhd.prb %addr_hit : i29
      %452 = comb.extract %451 from 2 : (i29) -> i1
      %453 = comb.icmp ceq %452, %true : i1
      cf.cond_br %453, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %454 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      llhd.drv %454, %false after %1 : i1
      %455 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      llhd.drv %455, %false after %1 : i1
      cf.br ^bb60
    ^bb7:  // pred: ^bb5
      %456 = llhd.prb %addr_hit : i29
      %457 = comb.extract %456 from 3 : (i29) -> i1
      %458 = comb.icmp ceq %457, %true : i1
      cf.cond_br %458, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %459 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      llhd.drv %459, %false after %1 : i1
      %460 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      llhd.drv %460, %false after %1 : i1
      cf.br ^bb60
    ^bb9:  // pred: ^bb7
      %461 = llhd.prb %addr_hit : i29
      %462 = comb.extract %461 from 4 : (i29) -> i1
      %463 = comb.icmp ceq %462, %true : i1
      cf.cond_br %463, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %464 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %465 = llhd.prb %cfg_regwen_qs : i1
      llhd.drv %464, %465 after %1 : i1
      cf.br ^bb60
    ^bb11:  // pred: ^bb9
      %466 = llhd.prb %addr_hit : i29
      %467 = comb.extract %466 from 5 : (i29) -> i1
      %468 = comb.icmp ceq %467, %true : i1
      cf.cond_br %468, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %469 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %470 = llhd.prb %alert_trig_val_0_qs : i1
      llhd.drv %469, %470 after %1 : i1
      %471 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %472 = llhd.prb %alert_trig_val_1_qs : i1
      llhd.drv %471, %472 after %1 : i1
      %473 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %474 = llhd.prb %alert_trig_val_2_qs : i1
      llhd.drv %473, %474 after %1 : i1
      %475 = llhd.sig.extract %reg_rdata_next from %c3_i5 : <i32> -> <i1>
      %476 = llhd.prb %alert_trig_val_3_qs : i1
      llhd.drv %475, %476 after %1 : i1
      %477 = llhd.sig.extract %reg_rdata_next from %c4_i5 : <i32> -> <i1>
      %478 = llhd.prb %alert_trig_val_4_qs : i1
      llhd.drv %477, %478 after %1 : i1
      %479 = llhd.sig.extract %reg_rdata_next from %c5_i5 : <i32> -> <i1>
      %480 = llhd.prb %alert_trig_val_5_qs : i1
      llhd.drv %479, %480 after %1 : i1
      %481 = llhd.sig.extract %reg_rdata_next from %c6_i5 : <i32> -> <i1>
      %482 = llhd.prb %alert_trig_val_6_qs : i1
      llhd.drv %481, %482 after %1 : i1
      %483 = llhd.sig.extract %reg_rdata_next from %c7_i5 : <i32> -> <i1>
      %484 = llhd.prb %alert_trig_val_7_qs : i1
      llhd.drv %483, %484 after %1 : i1
      %485 = llhd.sig.extract %reg_rdata_next from %c8_i5 : <i32> -> <i1>
      %486 = llhd.prb %alert_trig_val_8_qs : i1
      llhd.drv %485, %486 after %1 : i1
      %487 = llhd.sig.extract %reg_rdata_next from %c9_i5 : <i32> -> <i1>
      %488 = llhd.prb %alert_trig_val_9_qs : i1
      llhd.drv %487, %488 after %1 : i1
      %489 = llhd.sig.extract %reg_rdata_next from %c10_i5 : <i32> -> <i1>
      %490 = llhd.prb %alert_trig_val_10_qs : i1
      llhd.drv %489, %490 after %1 : i1
      cf.br ^bb60
    ^bb13:  // pred: ^bb11
      %491 = llhd.prb %addr_hit : i29
      %492 = comb.extract %491 from 6 : (i29) -> i1
      %493 = comb.icmp ceq %492, %true : i1
      cf.cond_br %493, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %494 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i4>
      %495 = llhd.prb %alert_en_0_qs : i4
      llhd.drv %494, %495 after %1 : i4
      cf.br ^bb60
    ^bb15:  // pred: ^bb13
      %496 = llhd.prb %addr_hit : i29
      %497 = comb.extract %496 from 7 : (i29) -> i1
      %498 = comb.icmp ceq %497, %true : i1
      cf.cond_br %498, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      %499 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i4>
      %500 = llhd.prb %alert_en_1_qs : i4
      llhd.drv %499, %500 after %1 : i4
      cf.br ^bb60
    ^bb17:  // pred: ^bb15
      %501 = llhd.prb %addr_hit : i29
      %502 = comb.extract %501 from 8 : (i29) -> i1
      %503 = comb.icmp ceq %502, %true : i1
      cf.cond_br %503, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      %504 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i4>
      %505 = llhd.prb %alert_en_2_qs : i4
      llhd.drv %504, %505 after %1 : i4
      cf.br ^bb60
    ^bb19:  // pred: ^bb17
      %506 = llhd.prb %addr_hit : i29
      %507 = comb.extract %506 from 9 : (i29) -> i1
      %508 = comb.icmp ceq %507, %true : i1
      cf.cond_br %508, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      %509 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i4>
      %510 = llhd.prb %alert_en_3_qs : i4
      llhd.drv %509, %510 after %1 : i4
      cf.br ^bb60
    ^bb21:  // pred: ^bb19
      %511 = llhd.prb %addr_hit : i29
      %512 = comb.extract %511 from 10 : (i29) -> i1
      %513 = comb.icmp ceq %512, %true : i1
      cf.cond_br %513, ^bb22, ^bb23
    ^bb22:  // pred: ^bb21
      %514 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i4>
      %515 = llhd.prb %alert_en_4_qs : i4
      llhd.drv %514, %515 after %1 : i4
      cf.br ^bb60
    ^bb23:  // pred: ^bb21
      %516 = llhd.prb %addr_hit : i29
      %517 = comb.extract %516 from 11 : (i29) -> i1
      %518 = comb.icmp ceq %517, %true : i1
      cf.cond_br %518, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      %519 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i4>
      %520 = llhd.prb %alert_en_5_qs : i4
      llhd.drv %519, %520 after %1 : i4
      cf.br ^bb60
    ^bb25:  // pred: ^bb23
      %521 = llhd.prb %addr_hit : i29
      %522 = comb.extract %521 from 12 : (i29) -> i1
      %523 = comb.icmp ceq %522, %true : i1
      cf.cond_br %523, ^bb26, ^bb27
    ^bb26:  // pred: ^bb25
      %524 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i4>
      %525 = llhd.prb %alert_en_6_qs : i4
      llhd.drv %524, %525 after %1 : i4
      cf.br ^bb60
    ^bb27:  // pred: ^bb25
      %526 = llhd.prb %addr_hit : i29
      %527 = comb.extract %526 from 13 : (i29) -> i1
      %528 = comb.icmp ceq %527, %true : i1
      cf.cond_br %528, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      %529 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i4>
      %530 = llhd.prb %alert_en_7_qs : i4
      llhd.drv %529, %530 after %1 : i4
      cf.br ^bb60
    ^bb29:  // pred: ^bb27
      %531 = llhd.prb %addr_hit : i29
      %532 = comb.extract %531 from 14 : (i29) -> i1
      %533 = comb.icmp ceq %532, %true : i1
      cf.cond_br %533, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      %534 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i4>
      %535 = llhd.prb %alert_en_8_qs : i4
      llhd.drv %534, %535 after %1 : i4
      cf.br ^bb60
    ^bb31:  // pred: ^bb29
      %536 = llhd.prb %addr_hit : i29
      %537 = comb.extract %536 from 15 : (i29) -> i1
      %538 = comb.icmp ceq %537, %true : i1
      cf.cond_br %538, ^bb32, ^bb33
    ^bb32:  // pred: ^bb31
      %539 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i4>
      %540 = llhd.prb %alert_en_9_qs : i4
      llhd.drv %539, %540 after %1 : i4
      cf.br ^bb60
    ^bb33:  // pred: ^bb31
      %541 = llhd.prb %addr_hit : i29
      %542 = comb.extract %541 from 16 : (i29) -> i1
      %543 = comb.icmp ceq %542, %true : i1
      cf.cond_br %543, ^bb34, ^bb35
    ^bb34:  // pred: ^bb33
      %544 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i4>
      %545 = llhd.prb %alert_en_10_qs : i4
      llhd.drv %544, %545 after %1 : i4
      cf.br ^bb60
    ^bb35:  // pred: ^bb33
      %546 = llhd.prb %addr_hit : i29
      %547 = comb.extract %546 from 17 : (i29) -> i1
      %548 = comb.icmp ceq %547, %true : i1
      cf.cond_br %548, ^bb36, ^bb37
    ^bb36:  // pred: ^bb35
      %549 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %550 = llhd.prb %fatal_alert_en_val_0_qs : i1
      llhd.drv %549, %550 after %1 : i1
      %551 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %552 = llhd.prb %fatal_alert_en_val_1_qs : i1
      llhd.drv %551, %552 after %1 : i1
      %553 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %554 = llhd.prb %fatal_alert_en_val_2_qs : i1
      llhd.drv %553, %554 after %1 : i1
      %555 = llhd.sig.extract %reg_rdata_next from %c3_i5 : <i32> -> <i1>
      %556 = llhd.prb %fatal_alert_en_val_3_qs : i1
      llhd.drv %555, %556 after %1 : i1
      %557 = llhd.sig.extract %reg_rdata_next from %c4_i5 : <i32> -> <i1>
      %558 = llhd.prb %fatal_alert_en_val_4_qs : i1
      llhd.drv %557, %558 after %1 : i1
      %559 = llhd.sig.extract %reg_rdata_next from %c5_i5 : <i32> -> <i1>
      %560 = llhd.prb %fatal_alert_en_val_5_qs : i1
      llhd.drv %559, %560 after %1 : i1
      %561 = llhd.sig.extract %reg_rdata_next from %c6_i5 : <i32> -> <i1>
      %562 = llhd.prb %fatal_alert_en_val_6_qs : i1
      llhd.drv %561, %562 after %1 : i1
      %563 = llhd.sig.extract %reg_rdata_next from %c7_i5 : <i32> -> <i1>
      %564 = llhd.prb %fatal_alert_en_val_7_qs : i1
      llhd.drv %563, %564 after %1 : i1
      %565 = llhd.sig.extract %reg_rdata_next from %c8_i5 : <i32> -> <i1>
      %566 = llhd.prb %fatal_alert_en_val_8_qs : i1
      llhd.drv %565, %566 after %1 : i1
      %567 = llhd.sig.extract %reg_rdata_next from %c9_i5 : <i32> -> <i1>
      %568 = llhd.prb %fatal_alert_en_val_9_qs : i1
      llhd.drv %567, %568 after %1 : i1
      %569 = llhd.sig.extract %reg_rdata_next from %c10_i5 : <i32> -> <i1>
      %570 = llhd.prb %fatal_alert_en_val_10_qs : i1
      llhd.drv %569, %570 after %1 : i1
      cf.br ^bb60
    ^bb37:  // pred: ^bb35
      %571 = llhd.prb %addr_hit : i29
      %572 = comb.extract %571 from 18 : (i29) -> i1
      %573 = comb.icmp ceq %572, %true : i1
      cf.cond_br %573, ^bb38, ^bb39
    ^bb38:  // pred: ^bb37
      %574 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %575 = llhd.prb %recov_alert_val_0_qs : i1
      llhd.drv %574, %575 after %1 : i1
      %576 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %577 = llhd.prb %recov_alert_val_1_qs : i1
      llhd.drv %576, %577 after %1 : i1
      %578 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %579 = llhd.prb %recov_alert_val_2_qs : i1
      llhd.drv %578, %579 after %1 : i1
      %580 = llhd.sig.extract %reg_rdata_next from %c3_i5 : <i32> -> <i1>
      %581 = llhd.prb %recov_alert_val_3_qs : i1
      llhd.drv %580, %581 after %1 : i1
      %582 = llhd.sig.extract %reg_rdata_next from %c4_i5 : <i32> -> <i1>
      %583 = llhd.prb %recov_alert_val_4_qs : i1
      llhd.drv %582, %583 after %1 : i1
      %584 = llhd.sig.extract %reg_rdata_next from %c5_i5 : <i32> -> <i1>
      %585 = llhd.prb %recov_alert_val_5_qs : i1
      llhd.drv %584, %585 after %1 : i1
      %586 = llhd.sig.extract %reg_rdata_next from %c6_i5 : <i32> -> <i1>
      %587 = llhd.prb %recov_alert_val_6_qs : i1
      llhd.drv %586, %587 after %1 : i1
      %588 = llhd.sig.extract %reg_rdata_next from %c7_i5 : <i32> -> <i1>
      %589 = llhd.prb %recov_alert_val_7_qs : i1
      llhd.drv %588, %589 after %1 : i1
      %590 = llhd.sig.extract %reg_rdata_next from %c8_i5 : <i32> -> <i1>
      %591 = llhd.prb %recov_alert_val_8_qs : i1
      llhd.drv %590, %591 after %1 : i1
      %592 = llhd.sig.extract %reg_rdata_next from %c9_i5 : <i32> -> <i1>
      %593 = llhd.prb %recov_alert_val_9_qs : i1
      llhd.drv %592, %593 after %1 : i1
      %594 = llhd.sig.extract %reg_rdata_next from %c10_i5 : <i32> -> <i1>
      %595 = llhd.prb %recov_alert_val_10_qs : i1
      llhd.drv %594, %595 after %1 : i1
      cf.br ^bb60
    ^bb39:  // pred: ^bb37
      %596 = llhd.prb %addr_hit : i29
      %597 = comb.extract %596 from 19 : (i29) -> i1
      %598 = comb.icmp ceq %597, %true : i1
      cf.cond_br %598, ^bb40, ^bb41
    ^bb40:  // pred: ^bb39
      %599 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %600 = llhd.prb %fatal_alert_val_0_qs : i1
      llhd.drv %599, %600 after %1 : i1
      %601 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %602 = llhd.prb %fatal_alert_val_1_qs : i1
      llhd.drv %601, %602 after %1 : i1
      %603 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %604 = llhd.prb %fatal_alert_val_2_qs : i1
      llhd.drv %603, %604 after %1 : i1
      %605 = llhd.sig.extract %reg_rdata_next from %c3_i5 : <i32> -> <i1>
      %606 = llhd.prb %fatal_alert_val_3_qs : i1
      llhd.drv %605, %606 after %1 : i1
      %607 = llhd.sig.extract %reg_rdata_next from %c4_i5 : <i32> -> <i1>
      %608 = llhd.prb %fatal_alert_val_4_qs : i1
      llhd.drv %607, %608 after %1 : i1
      %609 = llhd.sig.extract %reg_rdata_next from %c5_i5 : <i32> -> <i1>
      %610 = llhd.prb %fatal_alert_val_5_qs : i1
      llhd.drv %609, %610 after %1 : i1
      %611 = llhd.sig.extract %reg_rdata_next from %c6_i5 : <i32> -> <i1>
      %612 = llhd.prb %fatal_alert_val_6_qs : i1
      llhd.drv %611, %612 after %1 : i1
      %613 = llhd.sig.extract %reg_rdata_next from %c7_i5 : <i32> -> <i1>
      %614 = llhd.prb %fatal_alert_val_7_qs : i1
      llhd.drv %613, %614 after %1 : i1
      %615 = llhd.sig.extract %reg_rdata_next from %c8_i5 : <i32> -> <i1>
      %616 = llhd.prb %fatal_alert_val_8_qs : i1
      llhd.drv %615, %616 after %1 : i1
      %617 = llhd.sig.extract %reg_rdata_next from %c9_i5 : <i32> -> <i1>
      %618 = llhd.prb %fatal_alert_val_9_qs : i1
      llhd.drv %617, %618 after %1 : i1
      %619 = llhd.sig.extract %reg_rdata_next from %c10_i5 : <i32> -> <i1>
      %620 = llhd.prb %fatal_alert_val_10_qs : i1
      llhd.drv %619, %620 after %1 : i1
      %621 = llhd.sig.extract %reg_rdata_next from %c11_i5 : <i32> -> <i1>
      %622 = llhd.prb %fatal_alert_val_11_qs : i1
      llhd.drv %621, %622 after %1 : i1
      cf.br ^bb60
    ^bb41:  // pred: ^bb39
      %623 = llhd.prb %addr_hit : i29
      %624 = comb.extract %623 from 20 : (i29) -> i1
      %625 = comb.icmp ceq %624, %true : i1
      cf.cond_br %625, ^bb42, ^bb43
    ^bb42:  // pred: ^bb41
      %626 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %627 = llhd.prb %status_ast_init_done_qs : i1
      llhd.drv %626, %627 after %1 : i1
      %628 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i2>
      %629 = llhd.prb %status_io_pok_qs : i2
      llhd.drv %628, %629 after %1 : i2
      cf.br ^bb60
    ^bb43:  // pred: ^bb41
      %630 = llhd.prb %addr_hit : i29
      %631 = comb.extract %630 from 21 : (i29) -> i1
      %632 = comb.icmp ceq %631, %true : i1
      cf.cond_br %632, ^bb44, ^bb45
    ^bb44:  // pred: ^bb43
      %633 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %634 = llhd.prb %manual_pad_attr_regwen_0_qs : i1
      llhd.drv %633, %634 after %1 : i1
      cf.br ^bb60
    ^bb45:  // pred: ^bb43
      %635 = llhd.prb %addr_hit : i29
      %636 = comb.extract %635 from 22 : (i29) -> i1
      %637 = comb.icmp ceq %636, %true : i1
      cf.cond_br %637, ^bb46, ^bb47
    ^bb46:  // pred: ^bb45
      %638 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %639 = llhd.prb %manual_pad_attr_regwen_1_qs : i1
      llhd.drv %638, %639 after %1 : i1
      cf.br ^bb60
    ^bb47:  // pred: ^bb45
      %640 = llhd.prb %addr_hit : i29
      %641 = comb.extract %640 from 23 : (i29) -> i1
      %642 = comb.icmp ceq %641, %true : i1
      cf.cond_br %642, ^bb48, ^bb49
    ^bb48:  // pred: ^bb47
      %643 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %644 = llhd.prb %manual_pad_attr_regwen_2_qs : i1
      llhd.drv %643, %644 after %1 : i1
      cf.br ^bb60
    ^bb49:  // pred: ^bb47
      %645 = llhd.prb %addr_hit : i29
      %646 = comb.extract %645 from 24 : (i29) -> i1
      %647 = comb.icmp ceq %646, %true : i1
      cf.cond_br %647, ^bb50, ^bb51
    ^bb50:  // pred: ^bb49
      %648 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %649 = llhd.prb %manual_pad_attr_regwen_3_qs : i1
      llhd.drv %648, %649 after %1 : i1
      cf.br ^bb60
    ^bb51:  // pred: ^bb49
      %650 = llhd.prb %addr_hit : i29
      %651 = comb.extract %650 from 25 : (i29) -> i1
      %652 = comb.icmp ceq %651, %true : i1
      cf.cond_br %652, ^bb52, ^bb53
    ^bb52:  // pred: ^bb51
      %653 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %654 = llhd.prb %manual_pad_attr_0_pull_en_0_qs : i1
      llhd.drv %653, %654 after %1 : i1
      %655 = llhd.sig.extract %reg_rdata_next from %c3_i5 : <i32> -> <i1>
      %656 = llhd.prb %manual_pad_attr_0_pull_select_0_qs : i1
      llhd.drv %655, %656 after %1 : i1
      %657 = llhd.sig.extract %reg_rdata_next from %c7_i5 : <i32> -> <i1>
      %658 = llhd.prb %manual_pad_attr_0_input_disable_0_qs : i1
      llhd.drv %657, %658 after %1 : i1
      cf.br ^bb60
    ^bb53:  // pred: ^bb51
      %659 = llhd.prb %addr_hit : i29
      %660 = comb.extract %659 from 26 : (i29) -> i1
      %661 = comb.icmp ceq %660, %true : i1
      cf.cond_br %661, ^bb54, ^bb55
    ^bb54:  // pred: ^bb53
      %662 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %663 = llhd.prb %manual_pad_attr_1_pull_en_1_qs : i1
      llhd.drv %662, %663 after %1 : i1
      %664 = llhd.sig.extract %reg_rdata_next from %c3_i5 : <i32> -> <i1>
      %665 = llhd.prb %manual_pad_attr_1_pull_select_1_qs : i1
      llhd.drv %664, %665 after %1 : i1
      %666 = llhd.sig.extract %reg_rdata_next from %c7_i5 : <i32> -> <i1>
      %667 = llhd.prb %manual_pad_attr_1_input_disable_1_qs : i1
      llhd.drv %666, %667 after %1 : i1
      cf.br ^bb60
    ^bb55:  // pred: ^bb53
      %668 = llhd.prb %addr_hit : i29
      %669 = comb.extract %668 from 27 : (i29) -> i1
      %670 = comb.icmp ceq %669, %true : i1
      cf.cond_br %670, ^bb56, ^bb57
    ^bb56:  // pred: ^bb55
      %671 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %672 = llhd.prb %manual_pad_attr_2_pull_en_2_qs : i1
      llhd.drv %671, %672 after %1 : i1
      %673 = llhd.sig.extract %reg_rdata_next from %c3_i5 : <i32> -> <i1>
      %674 = llhd.prb %manual_pad_attr_2_pull_select_2_qs : i1
      llhd.drv %673, %674 after %1 : i1
      %675 = llhd.sig.extract %reg_rdata_next from %c7_i5 : <i32> -> <i1>
      %676 = llhd.prb %manual_pad_attr_2_input_disable_2_qs : i1
      llhd.drv %675, %676 after %1 : i1
      cf.br ^bb60
    ^bb57:  // pred: ^bb55
      %677 = llhd.prb %addr_hit : i29
      %678 = comb.extract %677 from 28 : (i29) -> i1
      %679 = comb.icmp ceq %678, %true : i1
      cf.cond_br %679, ^bb58, ^bb59
    ^bb58:  // pred: ^bb57
      %680 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %681 = llhd.prb %manual_pad_attr_3_pull_en_3_qs : i1
      llhd.drv %680, %681 after %1 : i1
      %682 = llhd.sig.extract %reg_rdata_next from %c3_i5 : <i32> -> <i1>
      %683 = llhd.prb %manual_pad_attr_3_pull_select_3_qs : i1
      llhd.drv %682, %683 after %1 : i1
      %684 = llhd.sig.extract %reg_rdata_next from %c7_i5 : <i32> -> <i1>
      %685 = llhd.prb %manual_pad_attr_3_input_disable_3_qs : i1
      llhd.drv %684, %685 after %1 : i1
      cf.br ^bb60
    ^bb59:  // pred: ^bb57
      llhd.drv %reg_rdata_next, %c-1_i32 after %1 : i32
      cf.br ^bb60
    ^bb60:  // 30 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb18, ^bb20, ^bb22, ^bb24, ^bb26, ^bb28, ^bb30, ^bb32, ^bb34, ^bb36, ^bb38, ^bb40, ^bb42, ^bb44, ^bb46, ^bb48, ^bb50, ^bb52, ^bb54, ^bb56, ^bb58, ^bb59
      llhd.wait (%249, %301, %362, %363, %364, %365, %260, %366, %367, %368, %369, %370, %371, %372, %373, %374, %375, %376, %377, %378, %379, %380, %381, %382, %383, %384, %385, %386, %387, %388, %389, %390, %391, %392, %393, %394, %395, %396, %397, %398, %399, %400, %401, %402, %403, %404, %405, %406, %407, %408, %409, %410, %411, %412, %413, %414, %415, %416, %417, %418, %419, %420, %421, %422, %423, %275, %282, %289, %296, %424, %425, %426, %427, %428, %429, %430, %431, %432, %433, %434, %435 : i32, i29, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i2, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    %436 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
    hw.output %u_rsp_intg_gen.tl_o, %436, %248 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>, i1
  }
  hw.module @sensor_ctrl(in %clk_i : i1, in %rst_ni : i1, in %clk_aon_i : i1, in %rst_aon_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %ast_alert_i : !hw.struct<alerts: !hw.array<11xstruct<p: i1, n: i1>>>, out ast_alert_o : !hw.struct<alerts_ack: !hw.array<11xstruct<p: i1, n: i1>>, alerts_trig: !hw.array<11xstruct<p: i1, n: i1>>>, in %ast_status_i : !hw.struct<io_pok: i2>, in %ast2pinmux_i : i9, in %ast_init_done_i : i4, out cio_ast_debug_out_o : i9, out cio_ast_debug_out_en_o : i9, out intr_io_status_change_o : i1, out intr_init_status_change_o : i1, in %alert_rx_i : !hw.array<2xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, out alert_tx_o : !hw.array<2xstruct<alert_p: i1, alert_n: i1>>, out wkup_req_o : i1, out manual_pad_attr_o : !hw.array<4xstruct<drive_strength: i4, slew_rate: i2, input_disable: i1, od_en: i1, schmitt_en: i1, keep_en: i1, pull_select: i1, pull_en: i1, virt_od_en: i1, invert: i1>>) {
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %c-1_i2 = hw.constant -1 : i2
    %c0_i30 = hw.constant 0 : i30
    %c-1_i3 = hw.constant -1 : i3
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-5_i4 = hw.constant -5 : i4
    %c-1_i11 = hw.constant -1 : i11
    %c0_i21 = hw.constant 0 : i21
    %c-1_i4 = hw.constant -1 : i4
    %c0_i28 = hw.constant 0 : i28
    %c0_i12 = hw.constant 0 : i12
    %c-6_i4 = hw.constant -6 : i4
    %c-7_i4 = hw.constant -7 : i4
    %c-8_i4 = hw.constant -8 : i4
    %c7_i4 = hw.constant 7 : i4
    %c6_i4 = hw.constant 6 : i4
    %c5_i4 = hw.constant 5 : i4
    %c4_i4 = hw.constant 4 : i4
    %c3_i4 = hw.constant 3 : i4
    %c2_i4 = hw.constant 2 : i4
    %c1_i4 = hw.constant 1 : i4
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [[[false, false], [false, false]], [[false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false]], [[false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false]], [[0 : i2, false], [false, false]], [[[false], [false], [false]], [[false], [false], [false]], [[false], [false], [false]], [[false], [false], [false]]]] : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<d: i1, de: i1>, io_status_change: !hw.struct<d: i1, de: i1>>, recov_alert: !hw.array<11xstruct<d: i1, de: i1>>, fatal_alert: !hw.array<12xstruct<d: i1, de: i1>>, status: !hw.struct<io_pok: !hw.struct<d: i2, de: i1>, ast_init_done: !hw.struct<d: i1, de: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>>
    %3 = hw.aggregate_constant [[[false], [false]], [[false], [false]], [[false, false], [false, false]], [[false, false], [false, false]], [[false], [false], [false], [false], [false], [false], [false], [false], [false], [false], [false]], [[0 : i4], [0 : i4], [0 : i4], [0 : i4], [0 : i4], [0 : i4], [0 : i4], [0 : i4], [0 : i4], [0 : i4], [0 : i4]], [[false], [false], [false], [false], [false], [false], [false], [false], [false], [false], [false]], [[false], [false], [false], [false], [false], [false], [false], [false], [false], [false], [false]], [[false], [false], [false], [false], [false], [false], [false], [false], [false], [false], [false], [false]], [[[false, false], [false, false], [false, false]], [[false, false], [false, false], [false, false]], [[false, false], [false, false], [false, false]], [[false, false], [false, false], [false, false]]]] : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
    %c0_i11 = hw.constant 0 : i11
    %4 = hw.aggregate_constant [[0 : i4, 0 : i2, false, false, false, false, false, false, false, false], [0 : i4, 0 : i2, false, false, false, false, false, false, false, false], [0 : i4, 0 : i2, false, false, false, false, false, false, false, false], [0 : i4, 0 : i2, false, false, false, false, false, false, false, false]] : !hw.array<4xstruct<drive_strength: i4, slew_rate: i2, input_disable: i1, od_en: i1, schmitt_en: i1, keep_en: i1, pull_select: i1, pull_en: i1, virt_od_en: i1, invert: i1>>
    %5 = hw.aggregate_constant [[false, false], [false, false]] : !hw.array<2xstruct<alert_p: i1, alert_n: i1>>
    %6 = hw.aggregate_constant [[[false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false]], [[false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false]]] : !hw.struct<alerts_ack: !hw.array<11xstruct<p: i1, n: i1>>, alerts_trig: !hw.array<11xstruct<p: i1, n: i1>>>
    %c-1_i9 = hw.constant -1 : i9
    %c0_i2 = hw.constant 0 : i2
    %c4_i32 = hw.constant 4 : i32
    %c0_i4 = hw.constant 0 : i4
    %false = hw.constant false
    %c0_i3 = hw.constant 0 : i3
    %c1_i32 = hw.constant 1 : i32
    %c11_i32 = hw.constant 11 : i32
    %c0_i32 = hw.constant 0 : i32
    %true = hw.constant true
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %7 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %8 = llhd.prb %rst_ni_1 : i1
    %clk_aon_i_2 = llhd.sig name "clk_aon_i" %false : i1
    %9 = llhd.prb %clk_aon_i_2 : i1
    %rst_aon_ni_3 = llhd.sig name "rst_aon_ni" %false : i1
    %10 = llhd.prb %rst_aon_ni_3 : i1
    %ast_alert_o = llhd.sig %6 : !hw.struct<alerts_ack: !hw.array<11xstruct<p: i1, n: i1>>, alerts_trig: !hw.array<11xstruct<p: i1, n: i1>>>
    %alert_tx_o = llhd.sig %5 : !hw.array<2xstruct<alert_p: i1, alert_n: i1>>
    %wkup_req_o = llhd.sig %false : i1
    %manual_pad_attr_o = llhd.sig %4 : !hw.array<4xstruct<drive_strength: i4, slew_rate: i2, input_disable: i1, od_en: i1, schmitt_en: i1, keep_en: i1, pull_select: i1, pull_en: i1, virt_od_en: i1, invert: i1>>
    %async_alert_event_p = llhd.sig %c0_i11 : i11
    %alert_event_p = llhd.sig %c0_i11 : i11
    %async_alert_event_n = llhd.sig %c0_i11 : i11
    %alert_event_n = llhd.sig %c0_i11 : i11
    %reg2hw = llhd.sig %3 : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
    %hw2reg = llhd.sig %2 : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<d: i1, de: i1>, io_status_change: !hw.struct<d: i1, de: i1>>, recov_alert: !hw.array<11xstruct<d: i1, de: i1>>, fatal_alert: !hw.array<12xstruct<d: i1, de: i1>>, status: !hw.struct<io_pok: !hw.struct<d: i2, de: i1>, ast_init_done: !hw.struct<d: i1, de: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>>
    %event_vld = llhd.sig %c0_i11 : i11
    %event_clr = llhd.sig %c0_i11 : i11
    %alert_en = llhd.sig %c0_i11 : i11
    %recov_event = llhd.sig %c0_i11 : i11
    %fatal_event = llhd.sig %c0_i11 : i11
    %alert_test = llhd.sig %c0_i2 : i2
    %unstable_wake_req = llhd.sig %false : i1
    %wake_req_filter = llhd.sig %c0_i3 : i3
    %manual_pad_pull_en_q = llhd.sig %c0_i4 : i4
    %manual_pad_pull_select_q = llhd.sig %c0_i4 : i4
    %manual_pad_input_disable_q = llhd.sig %c0_i4 : i4
    %alerts = hw.struct_extract %ast_alert_i["alerts"] : !hw.struct<alerts: !hw.array<11xstruct<p: i1, n: i1>>>
    %11 = hw.array_get %alerts[%c0_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %p = hw.struct_extract %11["p"] : !hw.struct<p: i1, n: i1>
    %n = hw.struct_extract %11["n"] : !hw.struct<p: i1, n: i1>
    %12 = comb.concat %p, %n : i1, i1
    %13 = llhd.sig.extract %async_alert_event_p from %c0_i4 : <i11> -> <i1>
    %14 = llhd.sig.extract %async_alert_event_n from %c0_i4 : <i11> -> <i1>
    %gen_alert_sync_assign_0.u_alert_in_buf.out_o = hw.instance "gen_alert_sync_assign_0.u_alert_in_buf" @prim_sec_anchor_buf(in_i: %12: i2) -> (out_o: i2)
    %15 = comb.extract %gen_alert_sync_assign_0.u_alert_in_buf.out_o from 1 : (i2) -> i1
    llhd.drv %13, %15 after %1 : i1
    %16 = comb.extract %gen_alert_sync_assign_0.u_alert_in_buf.out_o from 0 : (i2) -> i1
    llhd.drv %14, %16 after %1 : i1
    %17 = hw.array_get %alerts[%c1_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %p_4 = hw.struct_extract %17["p"] : !hw.struct<p: i1, n: i1>
    %n_5 = hw.struct_extract %17["n"] : !hw.struct<p: i1, n: i1>
    %18 = comb.concat %p_4, %n_5 : i1, i1
    %19 = llhd.sig.extract %async_alert_event_p from %c1_i4 : <i11> -> <i1>
    %20 = llhd.sig.extract %async_alert_event_n from %c1_i4 : <i11> -> <i1>
    %gen_alert_sync_assign_1.u_alert_in_buf.out_o = hw.instance "gen_alert_sync_assign_1.u_alert_in_buf" @prim_sec_anchor_buf(in_i: %18: i2) -> (out_o: i2)
    %21 = comb.extract %gen_alert_sync_assign_1.u_alert_in_buf.out_o from 1 : (i2) -> i1
    llhd.drv %19, %21 after %1 : i1
    %22 = comb.extract %gen_alert_sync_assign_1.u_alert_in_buf.out_o from 0 : (i2) -> i1
    llhd.drv %20, %22 after %1 : i1
    %23 = hw.array_get %alerts[%c2_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %p_6 = hw.struct_extract %23["p"] : !hw.struct<p: i1, n: i1>
    %n_7 = hw.struct_extract %23["n"] : !hw.struct<p: i1, n: i1>
    %24 = comb.concat %p_6, %n_7 : i1, i1
    %25 = llhd.sig.extract %async_alert_event_p from %c2_i4 : <i11> -> <i1>
    %26 = llhd.sig.extract %async_alert_event_n from %c2_i4 : <i11> -> <i1>
    %gen_alert_sync_assign_2.u_alert_in_buf.out_o = hw.instance "gen_alert_sync_assign_2.u_alert_in_buf" @prim_sec_anchor_buf(in_i: %24: i2) -> (out_o: i2)
    %27 = comb.extract %gen_alert_sync_assign_2.u_alert_in_buf.out_o from 1 : (i2) -> i1
    llhd.drv %25, %27 after %1 : i1
    %28 = comb.extract %gen_alert_sync_assign_2.u_alert_in_buf.out_o from 0 : (i2) -> i1
    llhd.drv %26, %28 after %1 : i1
    %29 = hw.array_get %alerts[%c3_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %p_8 = hw.struct_extract %29["p"] : !hw.struct<p: i1, n: i1>
    %n_9 = hw.struct_extract %29["n"] : !hw.struct<p: i1, n: i1>
    %30 = comb.concat %p_8, %n_9 : i1, i1
    %31 = llhd.sig.extract %async_alert_event_p from %c3_i4 : <i11> -> <i1>
    %32 = llhd.sig.extract %async_alert_event_n from %c3_i4 : <i11> -> <i1>
    %gen_alert_sync_assign_3.u_alert_in_buf.out_o = hw.instance "gen_alert_sync_assign_3.u_alert_in_buf" @prim_sec_anchor_buf(in_i: %30: i2) -> (out_o: i2)
    %33 = comb.extract %gen_alert_sync_assign_3.u_alert_in_buf.out_o from 1 : (i2) -> i1
    llhd.drv %31, %33 after %1 : i1
    %34 = comb.extract %gen_alert_sync_assign_3.u_alert_in_buf.out_o from 0 : (i2) -> i1
    llhd.drv %32, %34 after %1 : i1
    %35 = hw.array_get %alerts[%c4_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %p_10 = hw.struct_extract %35["p"] : !hw.struct<p: i1, n: i1>
    %n_11 = hw.struct_extract %35["n"] : !hw.struct<p: i1, n: i1>
    %36 = comb.concat %p_10, %n_11 : i1, i1
    %37 = llhd.sig.extract %async_alert_event_p from %c4_i4 : <i11> -> <i1>
    %38 = llhd.sig.extract %async_alert_event_n from %c4_i4 : <i11> -> <i1>
    %gen_alert_sync_assign_4.u_alert_in_buf.out_o = hw.instance "gen_alert_sync_assign_4.u_alert_in_buf" @prim_sec_anchor_buf(in_i: %36: i2) -> (out_o: i2)
    %39 = comb.extract %gen_alert_sync_assign_4.u_alert_in_buf.out_o from 1 : (i2) -> i1
    llhd.drv %37, %39 after %1 : i1
    %40 = comb.extract %gen_alert_sync_assign_4.u_alert_in_buf.out_o from 0 : (i2) -> i1
    llhd.drv %38, %40 after %1 : i1
    %41 = hw.array_get %alerts[%c5_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %p_12 = hw.struct_extract %41["p"] : !hw.struct<p: i1, n: i1>
    %n_13 = hw.struct_extract %41["n"] : !hw.struct<p: i1, n: i1>
    %42 = comb.concat %p_12, %n_13 : i1, i1
    %43 = llhd.sig.extract %async_alert_event_p from %c5_i4 : <i11> -> <i1>
    %44 = llhd.sig.extract %async_alert_event_n from %c5_i4 : <i11> -> <i1>
    %gen_alert_sync_assign_5.u_alert_in_buf.out_o = hw.instance "gen_alert_sync_assign_5.u_alert_in_buf" @prim_sec_anchor_buf(in_i: %42: i2) -> (out_o: i2)
    %45 = comb.extract %gen_alert_sync_assign_5.u_alert_in_buf.out_o from 1 : (i2) -> i1
    llhd.drv %43, %45 after %1 : i1
    %46 = comb.extract %gen_alert_sync_assign_5.u_alert_in_buf.out_o from 0 : (i2) -> i1
    llhd.drv %44, %46 after %1 : i1
    %47 = hw.array_get %alerts[%c6_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %p_14 = hw.struct_extract %47["p"] : !hw.struct<p: i1, n: i1>
    %n_15 = hw.struct_extract %47["n"] : !hw.struct<p: i1, n: i1>
    %48 = comb.concat %p_14, %n_15 : i1, i1
    %49 = llhd.sig.extract %async_alert_event_p from %c6_i4 : <i11> -> <i1>
    %50 = llhd.sig.extract %async_alert_event_n from %c6_i4 : <i11> -> <i1>
    %gen_alert_sync_assign_6.u_alert_in_buf.out_o = hw.instance "gen_alert_sync_assign_6.u_alert_in_buf" @prim_sec_anchor_buf(in_i: %48: i2) -> (out_o: i2)
    %51 = comb.extract %gen_alert_sync_assign_6.u_alert_in_buf.out_o from 1 : (i2) -> i1
    llhd.drv %49, %51 after %1 : i1
    %52 = comb.extract %gen_alert_sync_assign_6.u_alert_in_buf.out_o from 0 : (i2) -> i1
    llhd.drv %50, %52 after %1 : i1
    %53 = hw.array_get %alerts[%c7_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %p_16 = hw.struct_extract %53["p"] : !hw.struct<p: i1, n: i1>
    %n_17 = hw.struct_extract %53["n"] : !hw.struct<p: i1, n: i1>
    %54 = comb.concat %p_16, %n_17 : i1, i1
    %55 = llhd.sig.extract %async_alert_event_p from %c7_i4 : <i11> -> <i1>
    %56 = llhd.sig.extract %async_alert_event_n from %c7_i4 : <i11> -> <i1>
    %gen_alert_sync_assign_7.u_alert_in_buf.out_o = hw.instance "gen_alert_sync_assign_7.u_alert_in_buf" @prim_sec_anchor_buf(in_i: %54: i2) -> (out_o: i2)
    %57 = comb.extract %gen_alert_sync_assign_7.u_alert_in_buf.out_o from 1 : (i2) -> i1
    llhd.drv %55, %57 after %1 : i1
    %58 = comb.extract %gen_alert_sync_assign_7.u_alert_in_buf.out_o from 0 : (i2) -> i1
    llhd.drv %56, %58 after %1 : i1
    %59 = hw.array_get %alerts[%c-8_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %p_18 = hw.struct_extract %59["p"] : !hw.struct<p: i1, n: i1>
    %n_19 = hw.struct_extract %59["n"] : !hw.struct<p: i1, n: i1>
    %60 = comb.concat %p_18, %n_19 : i1, i1
    %61 = llhd.sig.extract %async_alert_event_p from %c-8_i4 : <i11> -> <i1>
    %62 = llhd.sig.extract %async_alert_event_n from %c-8_i4 : <i11> -> <i1>
    %gen_alert_sync_assign_8.u_alert_in_buf.out_o = hw.instance "gen_alert_sync_assign_8.u_alert_in_buf" @prim_sec_anchor_buf(in_i: %60: i2) -> (out_o: i2)
    %63 = comb.extract %gen_alert_sync_assign_8.u_alert_in_buf.out_o from 1 : (i2) -> i1
    llhd.drv %61, %63 after %1 : i1
    %64 = comb.extract %gen_alert_sync_assign_8.u_alert_in_buf.out_o from 0 : (i2) -> i1
    llhd.drv %62, %64 after %1 : i1
    %65 = hw.array_get %alerts[%c-7_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %p_20 = hw.struct_extract %65["p"] : !hw.struct<p: i1, n: i1>
    %n_21 = hw.struct_extract %65["n"] : !hw.struct<p: i1, n: i1>
    %66 = comb.concat %p_20, %n_21 : i1, i1
    %67 = llhd.sig.extract %async_alert_event_p from %c-7_i4 : <i11> -> <i1>
    %68 = llhd.sig.extract %async_alert_event_n from %c-7_i4 : <i11> -> <i1>
    %gen_alert_sync_assign_9.u_alert_in_buf.out_o = hw.instance "gen_alert_sync_assign_9.u_alert_in_buf" @prim_sec_anchor_buf(in_i: %66: i2) -> (out_o: i2)
    %69 = comb.extract %gen_alert_sync_assign_9.u_alert_in_buf.out_o from 1 : (i2) -> i1
    llhd.drv %67, %69 after %1 : i1
    %70 = comb.extract %gen_alert_sync_assign_9.u_alert_in_buf.out_o from 0 : (i2) -> i1
    llhd.drv %68, %70 after %1 : i1
    %71 = hw.array_get %alerts[%c-6_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %p_22 = hw.struct_extract %71["p"] : !hw.struct<p: i1, n: i1>
    %n_23 = hw.struct_extract %71["n"] : !hw.struct<p: i1, n: i1>
    %72 = comb.concat %p_22, %n_23 : i1, i1
    %73 = llhd.sig.extract %async_alert_event_p from %c-6_i4 : <i11> -> <i1>
    %74 = llhd.sig.extract %async_alert_event_n from %c-6_i4 : <i11> -> <i1>
    %gen_alert_sync_assign_10.u_alert_in_buf.out_o = hw.instance "gen_alert_sync_assign_10.u_alert_in_buf" @prim_sec_anchor_buf(in_i: %72: i2) -> (out_o: i2)
    %75 = comb.extract %gen_alert_sync_assign_10.u_alert_in_buf.out_o from 1 : (i2) -> i1
    llhd.drv %73, %75 after %1 : i1
    %76 = comb.extract %gen_alert_sync_assign_10.u_alert_in_buf.out_o from 0 : (i2) -> i1
    llhd.drv %74, %76 after %1 : i1
    %77 = llhd.prb %async_alert_event_p : i11
    %u_alert_p_sync.q_o = hw.instance "u_alert_p_sync" @prim_flop_2sync(clk_i: %7: i1, rst_ni: %8: i1, d_i: %77: i11) -> (q_o: i11)
    llhd.drv %alert_event_p, %u_alert_p_sync.q_o after %1 : i11
    %78 = llhd.prb %async_alert_event_n : i11
    %u_alert_n_sync.q_o = hw.instance "u_alert_n_sync" @prim_flop_2sync_0(clk_i: %7: i1, rst_ni: %8: i1, d_i: %78: i11) -> (q_o: i11)
    llhd.drv %alert_event_n, %u_alert_n_sync.q_o after %1 : i11
    %79 = llhd.prb %hw2reg : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<d: i1, de: i1>, io_status_change: !hw.struct<d: i1, de: i1>>, recov_alert: !hw.array<11xstruct<d: i1, de: i1>>, fatal_alert: !hw.array<12xstruct<d: i1, de: i1>>, status: !hw.struct<io_pok: !hw.struct<d: i2, de: i1>, ast_init_done: !hw.struct<d: i1, de: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>>
    %u_reg.tl_o, %u_reg.reg2hw, %u_reg.intg_err_o = hw.instance "u_reg" @sensor_ctrl_reg_top(clk_i: %7: i1, rst_ni: %8: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, hw2reg: %79: !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<d: i1, de: i1>, io_status_change: !hw.struct<d: i1, de: i1>>, recov_alert: !hw.array<11xstruct<d: i1, de: i1>>, fatal_alert: !hw.array<12xstruct<d: i1, de: i1>>, status: !hw.struct<io_pok: !hw.struct<d: i2, de: i1>, ast_init_done: !hw.struct<d: i1, de: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, reg2hw: !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>, intg_err_o: i1) {sv.namehint = "intg_err"}
    llhd.drv %reg2hw, %u_reg.reg2hw after %1 : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
    %io_pok = hw.struct_extract %ast_status_i["io_pok"] : !hw.struct<io_pok: i2>
    %80 = llhd.sig.struct_extract %hw2reg["status"] : <!hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<d: i1, de: i1>, io_status_change: !hw.struct<d: i1, de: i1>>, recov_alert: !hw.array<11xstruct<d: i1, de: i1>>, fatal_alert: !hw.array<12xstruct<d: i1, de: i1>>, status: !hw.struct<io_pok: !hw.struct<d: i2, de: i1>, ast_init_done: !hw.struct<d: i1, de: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>>>
    %81 = llhd.sig.struct_extract %80["io_pok"] : <!hw.struct<io_pok: !hw.struct<d: i2, de: i1>, ast_init_done: !hw.struct<d: i1, de: i1>>>
    %82 = llhd.sig.struct_extract %81["d"] : <!hw.struct<d: i2, de: i1>>
    %u_io_status_chg.q_sync_o, %u_io_status_chg.q_posedge_pulse_o, %u_io_status_chg.q_negedge_pulse_o = hw.instance "u_io_status_chg" @prim_edge_detector(clk_i: %7: i1, rst_ni: %8: i1, d_i: %io_pok: i2) -> (q_sync_o: i2, q_posedge_pulse_o: i2, q_negedge_pulse_o: i2) {sv.namehint = "io_fall"}
    llhd.drv %82, %u_io_status_chg.q_sync_o after %1 : i2
    %83 = comb.concat %u_io_status_chg.q_posedge_pulse_o, %u_io_status_chg.q_negedge_pulse_o : i2, i2
    %84 = comb.icmp ne %83, %c0_i4 : i4
    %85 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
    %intr_enable = hw.struct_extract %85["intr_enable"] : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
    %io_status_change = hw.struct_extract %intr_enable["io_status_change"] : !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>
    %q = hw.struct_extract %io_status_change["q"] : !hw.struct<q: i1>
    %intr_test = hw.struct_extract %85["intr_test"] : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
    %io_status_change_24 = hw.struct_extract %intr_test["io_status_change"] : !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>
    %q_25 = hw.struct_extract %io_status_change_24["q"] : !hw.struct<q: i1, qe: i1>
    %qe = hw.struct_extract %io_status_change_24["qe"] : !hw.struct<q: i1, qe: i1>
    %intr_state = hw.struct_extract %85["intr_state"] : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
    %io_status_change_26 = hw.struct_extract %intr_state["io_status_change"] : !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>
    %q_27 = hw.struct_extract %io_status_change_26["q"] : !hw.struct<q: i1>
    %86 = llhd.sig.struct_extract %hw2reg["intr_state"] : <!hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<d: i1, de: i1>, io_status_change: !hw.struct<d: i1, de: i1>>, recov_alert: !hw.array<11xstruct<d: i1, de: i1>>, fatal_alert: !hw.array<12xstruct<d: i1, de: i1>>, status: !hw.struct<io_pok: !hw.struct<d: i2, de: i1>, ast_init_done: !hw.struct<d: i1, de: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>>>
    %87 = llhd.sig.struct_extract %86["io_status_change"] : <!hw.struct<init_status_change: !hw.struct<d: i1, de: i1>, io_status_change: !hw.struct<d: i1, de: i1>>>
    %88 = llhd.sig.struct_extract %87["de"] : <!hw.struct<d: i1, de: i1>>
    %89 = llhd.sig.struct_extract %87["d"] : <!hw.struct<d: i1, de: i1>>
    %u_io_intr.hw2reg_intr_state_de_o, %u_io_intr.hw2reg_intr_state_d_o, %u_io_intr.intr_o = hw.instance "u_io_intr" @prim_intr_hw(clk_i: %7: i1, rst_ni: %8: i1, event_intr_i: %84: i1, reg2hw_intr_enable_q_i: %q: i1, reg2hw_intr_test_q_i: %q_25: i1, reg2hw_intr_test_qe_i: %qe: i1, reg2hw_intr_state_q_i: %q_27: i1) -> (hw2reg_intr_state_de_o: i1, hw2reg_intr_state_d_o: i1, intr_o: i1)
    llhd.drv %88, %u_io_intr.hw2reg_intr_state_de_o after %1 : i1
    llhd.drv %89, %u_io_intr.hw2reg_intr_state_d_o after %1 : i1
    %90 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%ast_init_done_i) : (i4) -> i1
    %91 = llhd.sig.struct_extract %80["ast_init_done"] : <!hw.struct<io_pok: !hw.struct<d: i2, de: i1>, ast_init_done: !hw.struct<d: i1, de: i1>>>
    %92 = llhd.sig.struct_extract %91["d"] : <!hw.struct<d: i1, de: i1>>
    %u_init_chg.q_sync_o, %u_init_chg.q_posedge_pulse_o, %u_init_chg.q_negedge_pulse_o = hw.instance "u_init_chg" @prim_edge_detector_1(clk_i: %7: i1, rst_ni: %8: i1, d_i: %90: i1) -> (q_sync_o: i1, q_posedge_pulse_o: i1, q_negedge_pulse_o: i1) {sv.namehint = "init_fall"}
    llhd.drv %92, %u_init_chg.q_sync_o after %1 : i1
    %93 = comb.concat %u_init_chg.q_posedge_pulse_o, %u_init_chg.q_negedge_pulse_o : i1, i1
    %94 = comb.icmp ne %93, %c0_i2 : i2
    %init_status_change = hw.struct_extract %intr_enable["init_status_change"] : !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>
    %q_28 = hw.struct_extract %init_status_change["q"] : !hw.struct<q: i1>
    %init_status_change_29 = hw.struct_extract %intr_test["init_status_change"] : !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>
    %q_30 = hw.struct_extract %init_status_change_29["q"] : !hw.struct<q: i1, qe: i1>
    %qe_31 = hw.struct_extract %init_status_change_29["qe"] : !hw.struct<q: i1, qe: i1>
    %init_status_change_32 = hw.struct_extract %intr_state["init_status_change"] : !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>
    %q_33 = hw.struct_extract %init_status_change_32["q"] : !hw.struct<q: i1>
    %95 = llhd.sig.struct_extract %86["init_status_change"] : <!hw.struct<init_status_change: !hw.struct<d: i1, de: i1>, io_status_change: !hw.struct<d: i1, de: i1>>>
    %96 = llhd.sig.struct_extract %95["de"] : <!hw.struct<d: i1, de: i1>>
    %97 = llhd.sig.struct_extract %95["d"] : <!hw.struct<d: i1, de: i1>>
    %u_init_intr.hw2reg_intr_state_de_o, %u_init_intr.hw2reg_intr_state_d_o, %u_init_intr.intr_o = hw.instance "u_init_intr" @prim_intr_hw(clk_i: %7: i1, rst_ni: %8: i1, event_intr_i: %94: i1, reg2hw_intr_enable_q_i: %q_28: i1, reg2hw_intr_test_q_i: %q_30: i1, reg2hw_intr_test_qe_i: %qe_31: i1, reg2hw_intr_state_q_i: %q_33: i1) -> (hw2reg_intr_state_de_o: i1, hw2reg_intr_state_d_o: i1, intr_o: i1)
    llhd.drv %96, %u_init_intr.hw2reg_intr_state_de_o after %1 : i1
    llhd.drv %97, %u_init_intr.hw2reg_intr_state_d_o after %1 : i1
    %98 = llhd.prb %alert_en : i11
    %u_prim_sec_anchor_buf.out_o = hw.instance "u_prim_sec_anchor_buf" @prim_sec_anchor_buf_2(in_i: %98: i11) -> (out_o: i11) {sv.namehint = "alert_en_buf"}
    %99 = llhd.prb %alert_test : i2
    %100 = comb.extract %99 from 0 : (i2) -> i1
    %101 = llhd.prb %recov_event : i11
    %102 = comb.icmp ne %101, %c0_i11 : i11
    %103 = hw.array_get %alert_rx_i[%false] : !hw.array<2xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, i1
    %104 = llhd.sig.array_get %alert_tx_o[%false] : <!hw.array<2xstruct<alert_p: i1, alert_n: i1>>>
    %u_prim_recov_alert_sender.alert_ack_o, %u_prim_recov_alert_sender.alert_state_o, %u_prim_recov_alert_sender.alert_tx_o = hw.instance "u_prim_recov_alert_sender" @prim_alert_sender(clk_i: %7: i1, rst_ni: %8: i1, alert_test_i: %100: i1, alert_req_i: %102: i1, alert_rx_i: %103: !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>) -> (alert_ack_o: i1, alert_state_o: i1, alert_tx_o: !hw.struct<alert_p: i1, alert_n: i1>)
    llhd.drv %104, %u_prim_recov_alert_sender.alert_tx_o after %1 : !hw.struct<alert_p: i1, alert_n: i1>
    %105 = comb.extract %99 from 1 : (i2) -> i1
    %fatal_alert = hw.struct_extract %85["fatal_alert"] : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
    %106 = hw.bitcast %fatal_alert : (!hw.array<12xstruct<q: i1>>) -> i12
    %107 = comb.icmp ne %106, %c0_i12 : i12
    %108 = hw.array_get %alert_rx_i[%true] : !hw.array<2xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, i1
    %109 = llhd.sig.array_get %alert_tx_o[%true] : <!hw.array<2xstruct<alert_p: i1, alert_n: i1>>>
    %u_prim_fatal_alert_sender.alert_ack_o, %u_prim_fatal_alert_sender.alert_state_o, %u_prim_fatal_alert_sender.alert_tx_o = hw.instance "u_prim_fatal_alert_sender" @prim_alert_sender_3(clk_i: %7: i1, rst_ni: %8: i1, alert_test_i: %105: i1, alert_req_i: %107: i1, alert_rx_i: %108: !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>) -> (alert_ack_o: i1, alert_state_o: i1, alert_tx_o: !hw.struct<alert_p: i1, alert_n: i1>)
    llhd.drv %109, %u_prim_fatal_alert_sender.alert_tx_o after %1 : !hw.struct<alert_p: i1, alert_n: i1>
    %u_wake_sync.q_o = hw.instance "u_wake_sync" @prim_flop_2sync_4(clk_i: %9: i1, rst_ni: %10: i1, d_i: %409: i1) -> (q_o: i1)
    llhd.drv %unstable_wake_req, %u_wake_sync.q_o after %1 : i1
    %110 = llhd.sig.struct_extract %81["de"] : <!hw.struct<d: i2, de: i1>>
    llhd.drv %110, %true after %1 : i1
    %111 = llhd.sig.struct_extract %91["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %111, %true after %1 : i1
    %112 = llhd.prb %event_vld : i11
    %113 = llhd.prb %alert_event_p : i11
    %114 = llhd.prb %alert_event_n : i11
    llhd.process {
      cf.br ^bb2(%c0_i32 : i32)
    ^bb1:  // pred: ^bb4
      cf.br ^bb2(%c0_i32 : i32)
    ^bb2(%465: i32):  // 3 preds: ^bb0, ^bb1, ^bb3
      %466 = comb.icmp slt %465, %c11_i32 : i32
      cf.cond_br %466, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %467 = comb.extract %465 from 4 : (i32) -> i28
      %468 = comb.icmp eq %467, %c0_i28 : i28
      %469 = comb.extract %465 from 0 : (i32) -> i4
      %470 = comb.mux %468, %469, %c-1_i4 : i4
      %471 = llhd.sig.extract %event_vld from %470 : <i11> -> <i1>
      %472 = llhd.prb %alert_event_p : i11
      %473 = comb.extract %465 from 11 : (i32) -> i21
      %474 = comb.icmp eq %473, %c0_i21 : i21
      %475 = comb.extract %465 from 0 : (i32) -> i11
      %476 = comb.mux %474, %475, %c-1_i11 : i11
      %477 = comb.shru %472, %476 : i11
      %478 = comb.extract %477 from 0 : (i11) -> i1
      %479 = llhd.prb %alert_event_n : i11
      %480 = comb.shru %479, %476 : i11
      %481 = comb.extract %480 from 0 : (i11) -> i1
      %482 = comb.xor %481, %true : i1
      %483 = comb.or %478, %482 : i1
      llhd.drv %471, %483 after %1 : i1
      %484 = comb.add %465, %c1_i32 : i32
      cf.br ^bb2(%484 : i32)
    ^bb4:  // pred: ^bb2
      llhd.wait (%112, %113, %114 : i11, i11, i11), ^bb1
    }
    %115 = llhd.sig.extract %alert_en from %c0_i4 : <i11> -> <i1>
    %alert_en_34 = hw.struct_extract %85["alert_en"] : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
    %116 = hw.array_get %alert_en_34[%c0_i4] : !hw.array<11xstruct<q: i4>>, i4
    %117 = hw.bitcast %116 : (!hw.struct<q: i4>) -> i4
    %118 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%117) : (i4) -> i1
    llhd.drv %115, %118 after %1 : i1
    %119 = llhd.sig.extract %recov_event from %c0_i4 : <i11> -> <i1>
    %120 = comb.extract %u_prim_sec_anchor_buf.out_o from 0 : (i11) -> i1
    %121 = comb.extract %112 from 0 : (i11) -> i1
    %122 = comb.and %120, %121 : i1
    %fatal_alert_en = hw.struct_extract %85["fatal_alert_en"] : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
    %123 = hw.array_get %fatal_alert_en[%c0_i4] : !hw.array<11xstruct<q: i1>>, i4
    %124 = hw.bitcast %123 : (!hw.struct<q: i1>) -> i1
    %125 = comb.xor %124, %true : i1
    %126 = comb.and %122, %125 : i1
    llhd.drv %119, %126 after %1 : i1
    %127 = llhd.sig.extract %fatal_event from %c0_i4 : <i11> -> <i1>
    %128 = comb.and %122, %124 : i1
    llhd.drv %127, %128 after %1 : i1
    %129 = llhd.sig.struct_extract %hw2reg["recov_alert"] : <!hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<d: i1, de: i1>, io_status_change: !hw.struct<d: i1, de: i1>>, recov_alert: !hw.array<11xstruct<d: i1, de: i1>>, fatal_alert: !hw.array<12xstruct<d: i1, de: i1>>, status: !hw.struct<io_pok: !hw.struct<d: i2, de: i1>, ast_init_done: !hw.struct<d: i1, de: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>>>
    %130 = llhd.sig.array_get %129[%c0_i4] : <!hw.array<11xstruct<d: i1, de: i1>>>
    %131 = llhd.sig.struct_extract %130["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %131, %true after %1 : i1
    %132 = llhd.sig.struct_extract %130["de"] : <!hw.struct<d: i1, de: i1>>
    %133 = comb.extract %101 from 0 : (i11) -> i1
    llhd.drv %132, %133 after %1 : i1
    %134 = llhd.sig.struct_extract %hw2reg["fatal_alert"] : <!hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<d: i1, de: i1>, io_status_change: !hw.struct<d: i1, de: i1>>, recov_alert: !hw.array<11xstruct<d: i1, de: i1>>, fatal_alert: !hw.array<12xstruct<d: i1, de: i1>>, status: !hw.struct<io_pok: !hw.struct<d: i2, de: i1>, ast_init_done: !hw.struct<d: i1, de: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>>>
    %135 = llhd.sig.array_get %134[%c0_i4] : <!hw.array<12xstruct<d: i1, de: i1>>>
    %136 = llhd.sig.struct_extract %135["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %136, %true after %1 : i1
    %137 = llhd.sig.struct_extract %135["de"] : <!hw.struct<d: i1, de: i1>>
    %138 = llhd.prb %fatal_event : i11
    %139 = comb.extract %138 from 0 : (i11) -> i1
    llhd.drv %137, %139 after %1 : i1
    %140 = llhd.sig.extract %event_clr from %c0_i4 : <i11> -> <i1>
    %recov_alert = hw.struct_extract %85["recov_alert"] : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
    %141 = hw.array_get %recov_alert[%c0_i4] : !hw.array<11xstruct<q: i1>>, i4
    %q_35 = hw.struct_extract %141["q"] : !hw.struct<q: i1>
    %142 = comb.and %133, %q_35 : i1
    llhd.drv %140, %142 after %1 : i1
    %143 = llhd.sig.extract %alert_en from %c1_i4 : <i11> -> <i1>
    %144 = hw.array_get %alert_en_34[%c1_i4] : !hw.array<11xstruct<q: i4>>, i4
    %145 = hw.bitcast %144 : (!hw.struct<q: i4>) -> i4
    %146 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%145) : (i4) -> i1
    llhd.drv %143, %146 after %1 : i1
    %147 = llhd.sig.extract %recov_event from %c1_i4 : <i11> -> <i1>
    %148 = comb.extract %u_prim_sec_anchor_buf.out_o from 1 : (i11) -> i1
    %149 = comb.extract %112 from 1 : (i11) -> i1
    %150 = comb.and %148, %149 : i1
    %151 = hw.array_get %fatal_alert_en[%c1_i4] : !hw.array<11xstruct<q: i1>>, i4
    %152 = hw.bitcast %151 : (!hw.struct<q: i1>) -> i1
    %153 = comb.xor %152, %true : i1
    %154 = comb.and %150, %153 : i1
    llhd.drv %147, %154 after %1 : i1
    %155 = llhd.sig.extract %fatal_event from %c1_i4 : <i11> -> <i1>
    %156 = comb.and %150, %152 : i1
    llhd.drv %155, %156 after %1 : i1
    %157 = llhd.sig.array_get %129[%c1_i4] : <!hw.array<11xstruct<d: i1, de: i1>>>
    %158 = llhd.sig.struct_extract %157["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %158, %true after %1 : i1
    %159 = llhd.sig.struct_extract %157["de"] : <!hw.struct<d: i1, de: i1>>
    %160 = comb.extract %101 from 1 : (i11) -> i1
    llhd.drv %159, %160 after %1 : i1
    %161 = llhd.sig.array_get %134[%c1_i4] : <!hw.array<12xstruct<d: i1, de: i1>>>
    %162 = llhd.sig.struct_extract %161["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %162, %true after %1 : i1
    %163 = llhd.sig.struct_extract %161["de"] : <!hw.struct<d: i1, de: i1>>
    %164 = comb.extract %138 from 1 : (i11) -> i1
    llhd.drv %163, %164 after %1 : i1
    %165 = llhd.sig.extract %event_clr from %c1_i4 : <i11> -> <i1>
    %166 = hw.array_get %recov_alert[%c1_i4] : !hw.array<11xstruct<q: i1>>, i4
    %q_36 = hw.struct_extract %166["q"] : !hw.struct<q: i1>
    %167 = comb.and %160, %q_36 : i1
    llhd.drv %165, %167 after %1 : i1
    %168 = llhd.sig.extract %alert_en from %c2_i4 : <i11> -> <i1>
    %169 = hw.array_get %alert_en_34[%c2_i4] : !hw.array<11xstruct<q: i4>>, i4
    %170 = hw.bitcast %169 : (!hw.struct<q: i4>) -> i4
    %171 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%170) : (i4) -> i1
    llhd.drv %168, %171 after %1 : i1
    %172 = llhd.sig.extract %recov_event from %c2_i4 : <i11> -> <i1>
    %173 = comb.extract %u_prim_sec_anchor_buf.out_o from 2 : (i11) -> i1
    %174 = comb.extract %112 from 2 : (i11) -> i1
    %175 = comb.and %173, %174 : i1
    %176 = hw.array_get %fatal_alert_en[%c2_i4] : !hw.array<11xstruct<q: i1>>, i4
    %177 = hw.bitcast %176 : (!hw.struct<q: i1>) -> i1
    %178 = comb.xor %177, %true : i1
    %179 = comb.and %175, %178 : i1
    llhd.drv %172, %179 after %1 : i1
    %180 = llhd.sig.extract %fatal_event from %c2_i4 : <i11> -> <i1>
    %181 = comb.and %175, %177 : i1
    llhd.drv %180, %181 after %1 : i1
    %182 = llhd.sig.array_get %129[%c2_i4] : <!hw.array<11xstruct<d: i1, de: i1>>>
    %183 = llhd.sig.struct_extract %182["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %183, %true after %1 : i1
    %184 = llhd.sig.struct_extract %182["de"] : <!hw.struct<d: i1, de: i1>>
    %185 = comb.extract %101 from 2 : (i11) -> i1
    llhd.drv %184, %185 after %1 : i1
    %186 = llhd.sig.array_get %134[%c2_i4] : <!hw.array<12xstruct<d: i1, de: i1>>>
    %187 = llhd.sig.struct_extract %186["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %187, %true after %1 : i1
    %188 = llhd.sig.struct_extract %186["de"] : <!hw.struct<d: i1, de: i1>>
    %189 = comb.extract %138 from 2 : (i11) -> i1
    llhd.drv %188, %189 after %1 : i1
    %190 = llhd.sig.extract %event_clr from %c2_i4 : <i11> -> <i1>
    %191 = hw.array_get %recov_alert[%c2_i4] : !hw.array<11xstruct<q: i1>>, i4
    %q_37 = hw.struct_extract %191["q"] : !hw.struct<q: i1>
    %192 = comb.and %185, %q_37 : i1
    llhd.drv %190, %192 after %1 : i1
    %193 = llhd.sig.extract %alert_en from %c3_i4 : <i11> -> <i1>
    %194 = hw.array_get %alert_en_34[%c3_i4] : !hw.array<11xstruct<q: i4>>, i4
    %195 = hw.bitcast %194 : (!hw.struct<q: i4>) -> i4
    %196 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%195) : (i4) -> i1
    llhd.drv %193, %196 after %1 : i1
    %197 = llhd.sig.extract %recov_event from %c3_i4 : <i11> -> <i1>
    %198 = comb.extract %u_prim_sec_anchor_buf.out_o from 3 : (i11) -> i1
    %199 = comb.extract %112 from 3 : (i11) -> i1
    %200 = comb.and %198, %199 : i1
    %201 = hw.array_get %fatal_alert_en[%c3_i4] : !hw.array<11xstruct<q: i1>>, i4
    %202 = hw.bitcast %201 : (!hw.struct<q: i1>) -> i1
    %203 = comb.xor %202, %true : i1
    %204 = comb.and %200, %203 : i1
    llhd.drv %197, %204 after %1 : i1
    %205 = llhd.sig.extract %fatal_event from %c3_i4 : <i11> -> <i1>
    %206 = comb.and %200, %202 : i1
    llhd.drv %205, %206 after %1 : i1
    %207 = llhd.sig.array_get %129[%c3_i4] : <!hw.array<11xstruct<d: i1, de: i1>>>
    %208 = llhd.sig.struct_extract %207["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %208, %true after %1 : i1
    %209 = llhd.sig.struct_extract %207["de"] : <!hw.struct<d: i1, de: i1>>
    %210 = comb.extract %101 from 3 : (i11) -> i1
    llhd.drv %209, %210 after %1 : i1
    %211 = llhd.sig.array_get %134[%c3_i4] : <!hw.array<12xstruct<d: i1, de: i1>>>
    %212 = llhd.sig.struct_extract %211["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %212, %true after %1 : i1
    %213 = llhd.sig.struct_extract %211["de"] : <!hw.struct<d: i1, de: i1>>
    %214 = comb.extract %138 from 3 : (i11) -> i1
    llhd.drv %213, %214 after %1 : i1
    %215 = llhd.sig.extract %event_clr from %c3_i4 : <i11> -> <i1>
    %216 = hw.array_get %recov_alert[%c3_i4] : !hw.array<11xstruct<q: i1>>, i4
    %q_38 = hw.struct_extract %216["q"] : !hw.struct<q: i1>
    %217 = comb.and %210, %q_38 : i1
    llhd.drv %215, %217 after %1 : i1
    %218 = llhd.sig.extract %alert_en from %c4_i4 : <i11> -> <i1>
    %219 = hw.array_get %alert_en_34[%c4_i4] : !hw.array<11xstruct<q: i4>>, i4
    %220 = hw.bitcast %219 : (!hw.struct<q: i4>) -> i4
    %221 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%220) : (i4) -> i1
    llhd.drv %218, %221 after %1 : i1
    %222 = llhd.sig.extract %recov_event from %c4_i4 : <i11> -> <i1>
    %223 = comb.extract %u_prim_sec_anchor_buf.out_o from 4 : (i11) -> i1
    %224 = comb.extract %112 from 4 : (i11) -> i1
    %225 = comb.and %223, %224 : i1
    %226 = hw.array_get %fatal_alert_en[%c4_i4] : !hw.array<11xstruct<q: i1>>, i4
    %227 = hw.bitcast %226 : (!hw.struct<q: i1>) -> i1
    %228 = comb.xor %227, %true : i1
    %229 = comb.and %225, %228 : i1
    llhd.drv %222, %229 after %1 : i1
    %230 = llhd.sig.extract %fatal_event from %c4_i4 : <i11> -> <i1>
    %231 = comb.and %225, %227 : i1
    llhd.drv %230, %231 after %1 : i1
    %232 = llhd.sig.array_get %129[%c4_i4] : <!hw.array<11xstruct<d: i1, de: i1>>>
    %233 = llhd.sig.struct_extract %232["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %233, %true after %1 : i1
    %234 = llhd.sig.struct_extract %232["de"] : <!hw.struct<d: i1, de: i1>>
    %235 = comb.extract %101 from 4 : (i11) -> i1
    llhd.drv %234, %235 after %1 : i1
    %236 = llhd.sig.array_get %134[%c4_i4] : <!hw.array<12xstruct<d: i1, de: i1>>>
    %237 = llhd.sig.struct_extract %236["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %237, %true after %1 : i1
    %238 = llhd.sig.struct_extract %236["de"] : <!hw.struct<d: i1, de: i1>>
    %239 = comb.extract %138 from 4 : (i11) -> i1
    llhd.drv %238, %239 after %1 : i1
    %240 = llhd.sig.extract %event_clr from %c4_i4 : <i11> -> <i1>
    %241 = hw.array_get %recov_alert[%c4_i4] : !hw.array<11xstruct<q: i1>>, i4
    %q_39 = hw.struct_extract %241["q"] : !hw.struct<q: i1>
    %242 = comb.and %235, %q_39 : i1
    llhd.drv %240, %242 after %1 : i1
    %243 = llhd.sig.extract %alert_en from %c5_i4 : <i11> -> <i1>
    %244 = hw.array_get %alert_en_34[%c5_i4] : !hw.array<11xstruct<q: i4>>, i4
    %245 = hw.bitcast %244 : (!hw.struct<q: i4>) -> i4
    %246 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%245) : (i4) -> i1
    llhd.drv %243, %246 after %1 : i1
    %247 = llhd.sig.extract %recov_event from %c5_i4 : <i11> -> <i1>
    %248 = comb.extract %u_prim_sec_anchor_buf.out_o from 5 : (i11) -> i1
    %249 = comb.extract %112 from 5 : (i11) -> i1
    %250 = comb.and %248, %249 : i1
    %251 = hw.array_get %fatal_alert_en[%c5_i4] : !hw.array<11xstruct<q: i1>>, i4
    %252 = hw.bitcast %251 : (!hw.struct<q: i1>) -> i1
    %253 = comb.xor %252, %true : i1
    %254 = comb.and %250, %253 : i1
    llhd.drv %247, %254 after %1 : i1
    %255 = llhd.sig.extract %fatal_event from %c5_i4 : <i11> -> <i1>
    %256 = comb.and %250, %252 : i1
    llhd.drv %255, %256 after %1 : i1
    %257 = llhd.sig.array_get %129[%c5_i4] : <!hw.array<11xstruct<d: i1, de: i1>>>
    %258 = llhd.sig.struct_extract %257["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %258, %true after %1 : i1
    %259 = llhd.sig.struct_extract %257["de"] : <!hw.struct<d: i1, de: i1>>
    %260 = comb.extract %101 from 5 : (i11) -> i1
    llhd.drv %259, %260 after %1 : i1
    %261 = llhd.sig.array_get %134[%c5_i4] : <!hw.array<12xstruct<d: i1, de: i1>>>
    %262 = llhd.sig.struct_extract %261["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %262, %true after %1 : i1
    %263 = llhd.sig.struct_extract %261["de"] : <!hw.struct<d: i1, de: i1>>
    %264 = comb.extract %138 from 5 : (i11) -> i1
    llhd.drv %263, %264 after %1 : i1
    %265 = llhd.sig.extract %event_clr from %c5_i4 : <i11> -> <i1>
    %266 = hw.array_get %recov_alert[%c5_i4] : !hw.array<11xstruct<q: i1>>, i4
    %q_40 = hw.struct_extract %266["q"] : !hw.struct<q: i1>
    %267 = comb.and %260, %q_40 : i1
    llhd.drv %265, %267 after %1 : i1
    %268 = llhd.sig.extract %alert_en from %c6_i4 : <i11> -> <i1>
    %269 = hw.array_get %alert_en_34[%c6_i4] : !hw.array<11xstruct<q: i4>>, i4
    %270 = hw.bitcast %269 : (!hw.struct<q: i4>) -> i4
    %271 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%270) : (i4) -> i1
    llhd.drv %268, %271 after %1 : i1
    %272 = llhd.sig.extract %recov_event from %c6_i4 : <i11> -> <i1>
    %273 = comb.extract %u_prim_sec_anchor_buf.out_o from 6 : (i11) -> i1
    %274 = comb.extract %112 from 6 : (i11) -> i1
    %275 = comb.and %273, %274 : i1
    %276 = hw.array_get %fatal_alert_en[%c6_i4] : !hw.array<11xstruct<q: i1>>, i4
    %277 = hw.bitcast %276 : (!hw.struct<q: i1>) -> i1
    %278 = comb.xor %277, %true : i1
    %279 = comb.and %275, %278 : i1
    llhd.drv %272, %279 after %1 : i1
    %280 = llhd.sig.extract %fatal_event from %c6_i4 : <i11> -> <i1>
    %281 = comb.and %275, %277 : i1
    llhd.drv %280, %281 after %1 : i1
    %282 = llhd.sig.array_get %129[%c6_i4] : <!hw.array<11xstruct<d: i1, de: i1>>>
    %283 = llhd.sig.struct_extract %282["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %283, %true after %1 : i1
    %284 = llhd.sig.struct_extract %282["de"] : <!hw.struct<d: i1, de: i1>>
    %285 = comb.extract %101 from 6 : (i11) -> i1
    llhd.drv %284, %285 after %1 : i1
    %286 = llhd.sig.array_get %134[%c6_i4] : <!hw.array<12xstruct<d: i1, de: i1>>>
    %287 = llhd.sig.struct_extract %286["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %287, %true after %1 : i1
    %288 = llhd.sig.struct_extract %286["de"] : <!hw.struct<d: i1, de: i1>>
    %289 = comb.extract %138 from 6 : (i11) -> i1
    llhd.drv %288, %289 after %1 : i1
    %290 = llhd.sig.extract %event_clr from %c6_i4 : <i11> -> <i1>
    %291 = hw.array_get %recov_alert[%c6_i4] : !hw.array<11xstruct<q: i1>>, i4
    %q_41 = hw.struct_extract %291["q"] : !hw.struct<q: i1>
    %292 = comb.and %285, %q_41 : i1
    llhd.drv %290, %292 after %1 : i1
    %293 = llhd.sig.extract %alert_en from %c7_i4 : <i11> -> <i1>
    %294 = hw.array_get %alert_en_34[%c7_i4] : !hw.array<11xstruct<q: i4>>, i4
    %295 = hw.bitcast %294 : (!hw.struct<q: i4>) -> i4
    %296 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%295) : (i4) -> i1
    llhd.drv %293, %296 after %1 : i1
    %297 = llhd.sig.extract %recov_event from %c7_i4 : <i11> -> <i1>
    %298 = comb.extract %u_prim_sec_anchor_buf.out_o from 7 : (i11) -> i1
    %299 = comb.extract %112 from 7 : (i11) -> i1
    %300 = comb.and %298, %299 : i1
    %301 = hw.array_get %fatal_alert_en[%c7_i4] : !hw.array<11xstruct<q: i1>>, i4
    %302 = hw.bitcast %301 : (!hw.struct<q: i1>) -> i1
    %303 = comb.xor %302, %true : i1
    %304 = comb.and %300, %303 : i1
    llhd.drv %297, %304 after %1 : i1
    %305 = llhd.sig.extract %fatal_event from %c7_i4 : <i11> -> <i1>
    %306 = comb.and %300, %302 : i1
    llhd.drv %305, %306 after %1 : i1
    %307 = llhd.sig.array_get %129[%c7_i4] : <!hw.array<11xstruct<d: i1, de: i1>>>
    %308 = llhd.sig.struct_extract %307["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %308, %true after %1 : i1
    %309 = llhd.sig.struct_extract %307["de"] : <!hw.struct<d: i1, de: i1>>
    %310 = comb.extract %101 from 7 : (i11) -> i1
    llhd.drv %309, %310 after %1 : i1
    %311 = llhd.sig.array_get %134[%c7_i4] : <!hw.array<12xstruct<d: i1, de: i1>>>
    %312 = llhd.sig.struct_extract %311["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %312, %true after %1 : i1
    %313 = llhd.sig.struct_extract %311["de"] : <!hw.struct<d: i1, de: i1>>
    %314 = comb.extract %138 from 7 : (i11) -> i1
    llhd.drv %313, %314 after %1 : i1
    %315 = llhd.sig.extract %event_clr from %c7_i4 : <i11> -> <i1>
    %316 = hw.array_get %recov_alert[%c7_i4] : !hw.array<11xstruct<q: i1>>, i4
    %q_42 = hw.struct_extract %316["q"] : !hw.struct<q: i1>
    %317 = comb.and %310, %q_42 : i1
    llhd.drv %315, %317 after %1 : i1
    %318 = llhd.sig.extract %alert_en from %c-8_i4 : <i11> -> <i1>
    %319 = hw.array_get %alert_en_34[%c-8_i4] : !hw.array<11xstruct<q: i4>>, i4
    %320 = hw.bitcast %319 : (!hw.struct<q: i4>) -> i4
    %321 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%320) : (i4) -> i1
    llhd.drv %318, %321 after %1 : i1
    %322 = llhd.sig.extract %recov_event from %c-8_i4 : <i11> -> <i1>
    %323 = comb.extract %u_prim_sec_anchor_buf.out_o from 8 : (i11) -> i1
    %324 = comb.extract %112 from 8 : (i11) -> i1
    %325 = comb.and %323, %324 : i1
    %326 = hw.array_get %fatal_alert_en[%c-8_i4] : !hw.array<11xstruct<q: i1>>, i4
    %327 = hw.bitcast %326 : (!hw.struct<q: i1>) -> i1
    %328 = comb.xor %327, %true : i1
    %329 = comb.and %325, %328 : i1
    llhd.drv %322, %329 after %1 : i1
    %330 = llhd.sig.extract %fatal_event from %c-8_i4 : <i11> -> <i1>
    %331 = comb.and %325, %327 : i1
    llhd.drv %330, %331 after %1 : i1
    %332 = llhd.sig.array_get %129[%c-8_i4] : <!hw.array<11xstruct<d: i1, de: i1>>>
    %333 = llhd.sig.struct_extract %332["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %333, %true after %1 : i1
    %334 = llhd.sig.struct_extract %332["de"] : <!hw.struct<d: i1, de: i1>>
    %335 = comb.extract %101 from 8 : (i11) -> i1
    llhd.drv %334, %335 after %1 : i1
    %336 = llhd.sig.array_get %134[%c-8_i4] : <!hw.array<12xstruct<d: i1, de: i1>>>
    %337 = llhd.sig.struct_extract %336["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %337, %true after %1 : i1
    %338 = llhd.sig.struct_extract %336["de"] : <!hw.struct<d: i1, de: i1>>
    %339 = comb.extract %138 from 8 : (i11) -> i1
    llhd.drv %338, %339 after %1 : i1
    %340 = llhd.sig.extract %event_clr from %c-8_i4 : <i11> -> <i1>
    %341 = hw.array_get %recov_alert[%c-8_i4] : !hw.array<11xstruct<q: i1>>, i4
    %q_43 = hw.struct_extract %341["q"] : !hw.struct<q: i1>
    %342 = comb.and %335, %q_43 : i1
    llhd.drv %340, %342 after %1 : i1
    %343 = llhd.sig.extract %alert_en from %c-7_i4 : <i11> -> <i1>
    %344 = hw.array_get %alert_en_34[%c-7_i4] : !hw.array<11xstruct<q: i4>>, i4
    %345 = hw.bitcast %344 : (!hw.struct<q: i4>) -> i4
    %346 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%345) : (i4) -> i1
    llhd.drv %343, %346 after %1 : i1
    %347 = llhd.sig.extract %recov_event from %c-7_i4 : <i11> -> <i1>
    %348 = comb.extract %u_prim_sec_anchor_buf.out_o from 9 : (i11) -> i1
    %349 = comb.extract %112 from 9 : (i11) -> i1
    %350 = comb.and %348, %349 : i1
    %351 = hw.array_get %fatal_alert_en[%c-7_i4] : !hw.array<11xstruct<q: i1>>, i4
    %352 = hw.bitcast %351 : (!hw.struct<q: i1>) -> i1
    %353 = comb.xor %352, %true : i1
    %354 = comb.and %350, %353 : i1
    llhd.drv %347, %354 after %1 : i1
    %355 = llhd.sig.extract %fatal_event from %c-7_i4 : <i11> -> <i1>
    %356 = comb.and %350, %352 : i1
    llhd.drv %355, %356 after %1 : i1
    %357 = llhd.sig.array_get %129[%c-7_i4] : <!hw.array<11xstruct<d: i1, de: i1>>>
    %358 = llhd.sig.struct_extract %357["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %358, %true after %1 : i1
    %359 = llhd.sig.struct_extract %357["de"] : <!hw.struct<d: i1, de: i1>>
    %360 = comb.extract %101 from 9 : (i11) -> i1
    llhd.drv %359, %360 after %1 : i1
    %361 = llhd.sig.array_get %134[%c-7_i4] : <!hw.array<12xstruct<d: i1, de: i1>>>
    %362 = llhd.sig.struct_extract %361["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %362, %true after %1 : i1
    %363 = llhd.sig.struct_extract %361["de"] : <!hw.struct<d: i1, de: i1>>
    %364 = comb.extract %138 from 9 : (i11) -> i1
    llhd.drv %363, %364 after %1 : i1
    %365 = llhd.sig.extract %event_clr from %c-7_i4 : <i11> -> <i1>
    %366 = hw.array_get %recov_alert[%c-7_i4] : !hw.array<11xstruct<q: i1>>, i4
    %q_44 = hw.struct_extract %366["q"] : !hw.struct<q: i1>
    %367 = comb.and %360, %q_44 : i1
    llhd.drv %365, %367 after %1 : i1
    %368 = llhd.sig.extract %alert_en from %c-6_i4 : <i11> -> <i1>
    %369 = hw.array_get %alert_en_34[%c-6_i4] : !hw.array<11xstruct<q: i4>>, i4
    %370 = hw.bitcast %369 : (!hw.struct<q: i4>) -> i4
    %371 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%370) : (i4) -> i1
    llhd.drv %368, %371 after %1 : i1
    %372 = llhd.sig.extract %recov_event from %c-6_i4 : <i11> -> <i1>
    %373 = comb.extract %u_prim_sec_anchor_buf.out_o from 10 : (i11) -> i1
    %374 = comb.extract %112 from 10 : (i11) -> i1
    %375 = comb.and %373, %374 : i1
    %376 = hw.array_get %fatal_alert_en[%c-6_i4] : !hw.array<11xstruct<q: i1>>, i4
    %377 = hw.bitcast %376 : (!hw.struct<q: i1>) -> i1
    %378 = comb.xor %377, %true : i1
    %379 = comb.and %375, %378 : i1
    llhd.drv %372, %379 after %1 : i1
    %380 = llhd.sig.extract %fatal_event from %c-6_i4 : <i11> -> <i1>
    %381 = comb.and %375, %377 : i1
    llhd.drv %380, %381 after %1 : i1
    %382 = llhd.sig.array_get %129[%c-6_i4] : <!hw.array<11xstruct<d: i1, de: i1>>>
    %383 = llhd.sig.struct_extract %382["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %383, %true after %1 : i1
    %384 = llhd.sig.struct_extract %382["de"] : <!hw.struct<d: i1, de: i1>>
    %385 = comb.extract %101 from 10 : (i11) -> i1
    llhd.drv %384, %385 after %1 : i1
    %386 = llhd.sig.array_get %134[%c-6_i4] : <!hw.array<12xstruct<d: i1, de: i1>>>
    %387 = llhd.sig.struct_extract %386["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %387, %true after %1 : i1
    %388 = llhd.sig.struct_extract %386["de"] : <!hw.struct<d: i1, de: i1>>
    %389 = comb.extract %138 from 10 : (i11) -> i1
    llhd.drv %388, %389 after %1 : i1
    %390 = llhd.sig.extract %event_clr from %c-6_i4 : <i11> -> <i1>
    %391 = hw.array_get %recov_alert[%c-6_i4] : !hw.array<11xstruct<q: i1>>, i4
    %q_45 = hw.struct_extract %391["q"] : !hw.struct<q: i1>
    %392 = comb.and %385, %q_45 : i1
    llhd.drv %390, %392 after %1 : i1
    %393 = llhd.sig.array_get %134[%c-5_i4] : <!hw.array<12xstruct<d: i1, de: i1>>>
    %394 = llhd.sig.struct_extract %393["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %394, %true after %1 : i1
    %395 = llhd.sig.struct_extract %393["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %395, %u_reg.intg_err_o after %1 : i1
    %396 = llhd.prb %ast_alert_o : !hw.struct<alerts_ack: !hw.array<11xstruct<p: i1, n: i1>>, alerts_trig: !hw.array<11xstruct<p: i1, n: i1>>>
    %397 = llhd.prb %event_clr : i11
    llhd.process {
      cf.br ^bb2(%c0_i32 : i32)
    ^bb1:  // pred: ^bb4
      cf.br ^bb2(%c0_i32 : i32)
    ^bb2(%465: i32):  // 3 preds: ^bb0, ^bb1, ^bb3
      %466 = comb.icmp slt %465, %c11_i32 : i32
      cf.cond_br %466, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %467 = llhd.sig.struct_extract %ast_alert_o["alerts_ack"] : <!hw.struct<alerts_ack: !hw.array<11xstruct<p: i1, n: i1>>, alerts_trig: !hw.array<11xstruct<p: i1, n: i1>>>>
      %468 = comb.extract %465 from 4 : (i32) -> i28
      %469 = comb.icmp eq %468, %c0_i28 : i28
      %470 = comb.extract %465 from 0 : (i32) -> i4
      %471 = comb.mux %469, %470, %c-1_i4 : i4
      %472 = llhd.sig.array_get %467[%471] : <!hw.array<11xstruct<p: i1, n: i1>>>
      %473 = llhd.sig.struct_extract %472["p"] : <!hw.struct<p: i1, n: i1>>
      %474 = llhd.prb %alert_event_p : i11
      %475 = comb.extract %465 from 11 : (i32) -> i21
      %476 = comb.icmp eq %475, %c0_i21 : i21
      %477 = comb.extract %465 from 0 : (i32) -> i11
      %478 = comb.mux %476, %477, %c-1_i11 : i11
      %479 = comb.shru %474, %478 : i11
      %480 = comb.extract %479 from 0 : (i11) -> i1
      %481 = llhd.prb %event_clr : i11
      %482 = comb.shru %481, %478 : i11
      %483 = comb.extract %482 from 0 : (i11) -> i1
      %484 = comb.and %480, %483 : i1
      llhd.drv %473, %484 after %1 : i1
      %485 = llhd.sig.struct_extract %472["n"] : <!hw.struct<p: i1, n: i1>>
      %486 = llhd.prb %alert_event_n : i11
      %487 = comb.shru %486, %478 : i11
      %488 = comb.extract %487 from 0 : (i11) -> i1
      %489 = comb.xor %488, %true : i1
      %490 = llhd.prb %event_clr : i11
      %491 = comb.shru %490, %478 : i11
      %492 = comb.extract %491 from 0 : (i11) -> i1
      %493 = comb.and %489, %492 : i1
      %494 = comb.xor %493, %true : i1
      llhd.drv %485, %494 after %1 : i1
      %495 = comb.add %465, %c1_i32 : i32
      cf.br ^bb2(%495 : i32)
    ^bb4:  // pred: ^bb2
      llhd.wait (%396, %113, %397, %114 : !hw.struct<alerts_ack: !hw.array<11xstruct<p: i1, n: i1>>, alerts_trig: !hw.array<11xstruct<p: i1, n: i1>>>, i11, i11, i11), ^bb1
    }
    llhd.process {
      cf.br ^bb2(%c0_i32 : i32)
    ^bb1:  // pred: ^bb4
      cf.br ^bb2(%c0_i32 : i32)
    ^bb2(%465: i32):  // 3 preds: ^bb0, ^bb1, ^bb3
      %466 = comb.icmp slt %465, %c11_i32 : i32
      cf.cond_br %466, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %467 = llhd.sig.struct_extract %ast_alert_o["alerts_trig"] : <!hw.struct<alerts_ack: !hw.array<11xstruct<p: i1, n: i1>>, alerts_trig: !hw.array<11xstruct<p: i1, n: i1>>>>
      %468 = comb.extract %465 from 4 : (i32) -> i28
      %469 = comb.icmp eq %468, %c0_i28 : i28
      %470 = comb.extract %465 from 0 : (i32) -> i4
      %471 = comb.mux %469, %470, %c-1_i4 : i4
      %472 = llhd.sig.array_get %467[%471] : <!hw.array<11xstruct<p: i1, n: i1>>>
      %473 = llhd.sig.struct_extract %472["p"] : <!hw.struct<p: i1, n: i1>>
      %474 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
      %alert_trig = hw.struct_extract %474["alert_trig"] : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
      %475 = hw.array_get %alert_trig[%471] : !hw.array<11xstruct<q: i1>>, i4
      %476 = hw.bitcast %475 : (!hw.struct<q: i1>) -> i1
      llhd.drv %473, %476 after %1 : i1
      %477 = llhd.sig.struct_extract %472["n"] : <!hw.struct<p: i1, n: i1>>
      %478 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
      %alert_trig_53 = hw.struct_extract %478["alert_trig"] : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
      %479 = hw.array_get %alert_trig_53[%471] : !hw.array<11xstruct<q: i1>>, i4
      %480 = hw.bitcast %479 : (!hw.struct<q: i1>) -> i1
      %481 = comb.xor %480, %true : i1
      llhd.drv %477, %481 after %1 : i1
      %482 = comb.add %465, %c1_i32 : i32
      cf.br ^bb2(%482 : i32)
    ^bb4:  // pred: ^bb2
      llhd.wait (%396, %85 : !hw.struct<alerts_ack: !hw.array<11xstruct<p: i1, n: i1>>, alerts_trig: !hw.array<11xstruct<p: i1, n: i1>>>, !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>), ^bb1
    }
    %398 = llhd.sig.extract %alert_test from %false : <i2> -> <i1>
    %alert_test_46 = hw.struct_extract %85["alert_test"] : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
    %recov_alert_47 = hw.struct_extract %alert_test_46["recov_alert"] : !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>
    %qe_48 = hw.struct_extract %recov_alert_47["qe"] : !hw.struct<q: i1, qe: i1>
    %q_49 = hw.struct_extract %recov_alert_47["q"] : !hw.struct<q: i1, qe: i1>
    %399 = comb.and %qe_48, %q_49 : i1
    llhd.drv %398, %399 after %1 : i1
    %400 = llhd.sig.extract %alert_test from %true : <i2> -> <i1>
    %fatal_alert_50 = hw.struct_extract %alert_test_46["fatal_alert"] : !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>
    %qe_51 = hw.struct_extract %fatal_alert_50["qe"] : !hw.struct<q: i1, qe: i1>
    %q_52 = hw.struct_extract %fatal_alert_50["q"] : !hw.struct<q: i1, qe: i1>
    %401 = comb.and %qe_51, %q_52 : i1
    llhd.drv %400, %401 after %1 : i1
    %402 = comb.and %77, %u_prim_sec_anchor_buf.out_o : i11
    %403 = comb.icmp ne %402, %c0_i11 : i11
    %404 = comb.xor %u_prim_sec_anchor_buf.out_o, %c-1_i11 : i11
    %405 = comb.or %78, %404 : i11
    %406 = comb.icmp ne %405, %c-1_i11 : i11
    %407 = hw.bitcast %recov_alert : (!hw.array<11xstruct<q: i1>>) -> i11
    %408 = comb.icmp ne %407, %c0_i11 : i11
    %409 = comb.or %403, %406, %408 {sv.namehint = "async_wake"} : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %465 = llhd.prb %clk_aon_i_2 : i1
      %466 = llhd.prb %rst_aon_ni_3 : i1
      llhd.wait (%9, %10 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %467 = llhd.prb %clk_aon_i_2 : i1
      %468 = comb.xor bin %465, %true : i1
      %469 = comb.and bin %468, %467 : i1
      %470 = llhd.prb %rst_aon_ni_3 : i1
      %471 = comb.xor bin %470, %true : i1
      %472 = comb.and bin %466, %471 : i1
      %473 = comb.or bin %469, %472 : i1
      cf.cond_br %473, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %474 = llhd.prb %rst_aon_ni_3 : i1
      %475 = comb.xor %474, %true : i1
      cf.cond_br %475, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %wake_req_filter, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %476 = llhd.prb %wake_req_filter : i3
      %477 = comb.extract %476 from 0 : (i3) -> i2
      %478 = llhd.prb %unstable_wake_req : i1
      %479 = comb.concat %477, %478 : i2, i1
      llhd.drv %wake_req_filter, %479 after %0 : i3
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %465 = llhd.prb %clk_aon_i_2 : i1
      %466 = llhd.prb %rst_aon_ni_3 : i1
      llhd.wait (%9, %10 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %467 = llhd.prb %clk_aon_i_2 : i1
      %468 = comb.xor bin %465, %true : i1
      %469 = comb.and bin %468, %467 : i1
      %470 = llhd.prb %rst_aon_ni_3 : i1
      %471 = comb.xor bin %470, %true : i1
      %472 = comb.and bin %466, %471 : i1
      %473 = comb.or bin %469, %472 : i1
      cf.cond_br %473, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %474 = llhd.prb %rst_aon_ni_3 : i1
      %475 = comb.xor %474, %true : i1
      cf.cond_br %475, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %wkup_req_o, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %476 = llhd.prb %wake_req_filter : i3
      %477 = comb.icmp eq %476, %c-1_i3 : i3
      llhd.drv %wkup_req_o, %477 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %465 = llhd.prb %clk_i_0 : i1
      %466 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%7, %8 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %467 = llhd.prb %clk_i_0 : i1
      %468 = comb.xor bin %465, %true : i1
      %469 = comb.and bin %468, %467 : i1
      %470 = llhd.prb %rst_ni_1 : i1
      %471 = comb.xor bin %470, %true : i1
      %472 = comb.and bin %466, %471 : i1
      %473 = comb.or bin %469, %472 : i1
      cf.cond_br %473, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %474 = llhd.prb %rst_ni_1 : i1
      %475 = comb.xor %474, %true : i1
      cf.cond_br %475, ^bb4, ^bb5(%c0_i32 : i32)
    ^bb4:  // pred: ^bb3
      llhd.drv %manual_pad_pull_en_q, %c0_i4 after %0 : i4
      llhd.drv %manual_pad_pull_select_q, %c0_i4 after %0 : i4
      llhd.drv %manual_pad_input_disable_q, %c0_i4 after %0 : i4
      cf.br ^bb1
    ^bb5(%476: i32):  // 2 preds: ^bb3, ^bb12
      %477 = comb.icmp slt %476, %c4_i32 : i32
      cf.cond_br %477, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %478 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
      %manual_pad_attr = hw.struct_extract %478["manual_pad_attr"] : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
      %479 = comb.extract %476 from 2 : (i32) -> i30
      %480 = comb.icmp eq %479, %c0_i30 : i30
      %481 = comb.extract %476 from 0 : (i32) -> i2
      %482 = comb.mux %480, %481, %c-1_i2 : i2
      %483 = hw.array_get %manual_pad_attr[%482] : !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>, i2
      %pull_en = hw.struct_extract %483["pull_en"] : !hw.struct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>
      %qe_53 = hw.struct_extract %pull_en["qe"] : !hw.struct<q: i1, qe: i1>
      cf.cond_br %qe_53, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %484 = llhd.sig.extract %manual_pad_pull_en_q from %482 : <i4> -> <i1>
      %485 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
      %manual_pad_attr_54 = hw.struct_extract %485["manual_pad_attr"] : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
      %486 = hw.array_get %manual_pad_attr_54[%482] : !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>, i2
      %pull_en_55 = hw.struct_extract %486["pull_en"] : !hw.struct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>
      %q_56 = hw.struct_extract %pull_en_55["q"] : !hw.struct<q: i1, qe: i1>
      llhd.drv %484, %q_56 after %0 : i1
      cf.br ^bb8
    ^bb8:  // 2 preds: ^bb6, ^bb7
      %487 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
      %manual_pad_attr_57 = hw.struct_extract %487["manual_pad_attr"] : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
      %488 = hw.array_get %manual_pad_attr_57[%482] : !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>, i2
      %pull_select = hw.struct_extract %488["pull_select"] : !hw.struct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>
      %qe_58 = hw.struct_extract %pull_select["qe"] : !hw.struct<q: i1, qe: i1>
      cf.cond_br %qe_58, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      %489 = llhd.sig.extract %manual_pad_pull_select_q from %482 : <i4> -> <i1>
      %490 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
      %manual_pad_attr_59 = hw.struct_extract %490["manual_pad_attr"] : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
      %491 = hw.array_get %manual_pad_attr_59[%482] : !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>, i2
      %pull_select_60 = hw.struct_extract %491["pull_select"] : !hw.struct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>
      %q_61 = hw.struct_extract %pull_select_60["q"] : !hw.struct<q: i1, qe: i1>
      llhd.drv %489, %q_61 after %0 : i1
      cf.br ^bb10
    ^bb10:  // 2 preds: ^bb8, ^bb9
      %492 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
      %manual_pad_attr_62 = hw.struct_extract %492["manual_pad_attr"] : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
      %493 = hw.array_get %manual_pad_attr_62[%482] : !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>, i2
      %input_disable = hw.struct_extract %493["input_disable"] : !hw.struct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>
      %qe_63 = hw.struct_extract %input_disable["qe"] : !hw.struct<q: i1, qe: i1>
      cf.cond_br %qe_63, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      %494 = llhd.sig.extract %manual_pad_input_disable_q from %482 : <i4> -> <i1>
      %495 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
      %manual_pad_attr_64 = hw.struct_extract %495["manual_pad_attr"] : !hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_enable: !hw.struct<init_status_change: !hw.struct<q: i1>, io_status_change: !hw.struct<q: i1>>, intr_test: !hw.struct<init_status_change: !hw.struct<q: i1, qe: i1>, io_status_change: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, alert_trig: !hw.array<11xstruct<q: i1>>, alert_en: !hw.array<11xstruct<q: i4>>, fatal_alert_en: !hw.array<11xstruct<q: i1>>, recov_alert: !hw.array<11xstruct<q: i1>>, fatal_alert: !hw.array<12xstruct<q: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>>
      %496 = hw.array_get %manual_pad_attr_64[%482] : !hw.array<4xstruct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>>, i2
      %input_disable_65 = hw.struct_extract %496["input_disable"] : !hw.struct<input_disable: !hw.struct<q: i1, qe: i1>, pull_select: !hw.struct<q: i1, qe: i1>, pull_en: !hw.struct<q: i1, qe: i1>>
      %q_66 = hw.struct_extract %input_disable_65["q"] : !hw.struct<q: i1, qe: i1>
      llhd.drv %494, %q_66 after %0 : i1
      cf.br ^bb12
    ^bb12:  // 2 preds: ^bb10, ^bb11
      %497 = comb.add %476, %c1_i32 : i32
      cf.br ^bb5(%497 : i32)
    }
    %410 = llhd.sig.struct_extract %hw2reg["manual_pad_attr"] : <!hw.struct<intr_state: !hw.struct<init_status_change: !hw.struct<d: i1, de: i1>, io_status_change: !hw.struct<d: i1, de: i1>>, recov_alert: !hw.array<11xstruct<d: i1, de: i1>>, fatal_alert: !hw.array<12xstruct<d: i1, de: i1>>, status: !hw.struct<io_pok: !hw.struct<d: i2, de: i1>, ast_init_done: !hw.struct<d: i1, de: i1>>, manual_pad_attr: !hw.array<4xstruct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>>>
    %411 = llhd.sig.array_get %410[%c0_i2] : <!hw.array<4xstruct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>>
    %412 = llhd.sig.struct_extract %411["pull_en"] : <!hw.struct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>
    %413 = llhd.sig.struct_extract %412["d"] : <!hw.struct<d: i1>>
    %414 = llhd.prb %manual_pad_pull_en_q : i4
    %415 = comb.extract %414 from 0 : (i4) -> i1
    llhd.drv %413, %415 after %1 : i1
    %416 = llhd.sig.struct_extract %411["pull_select"] : <!hw.struct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>
    %417 = llhd.sig.struct_extract %416["d"] : <!hw.struct<d: i1>>
    %418 = llhd.prb %manual_pad_pull_select_q : i4
    %419 = comb.extract %418 from 0 : (i4) -> i1
    llhd.drv %417, %419 after %1 : i1
    %420 = llhd.sig.struct_extract %411["input_disable"] : <!hw.struct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>
    %421 = llhd.sig.struct_extract %420["d"] : <!hw.struct<d: i1>>
    %422 = llhd.prb %manual_pad_input_disable_q : i4
    %423 = comb.extract %422 from 0 : (i4) -> i1
    llhd.drv %421, %423 after %1 : i1
    %424 = llhd.sig.array_get %manual_pad_attr_o[%c0_i2] : <!hw.array<4xstruct<drive_strength: i4, slew_rate: i2, input_disable: i1, od_en: i1, schmitt_en: i1, keep_en: i1, pull_select: i1, pull_en: i1, virt_od_en: i1, invert: i1>>>
    %425 = hw.struct_create (%c0_i4, %c0_i2, %423, %false, %false, %false, %419, %415, %false, %false) : !hw.struct<drive_strength: i4, slew_rate: i2, input_disable: i1, od_en: i1, schmitt_en: i1, keep_en: i1, pull_select: i1, pull_en: i1, virt_od_en: i1, invert: i1>
    llhd.drv %424, %425 after %1 : !hw.struct<drive_strength: i4, slew_rate: i2, input_disable: i1, od_en: i1, schmitt_en: i1, keep_en: i1, pull_select: i1, pull_en: i1, virt_od_en: i1, invert: i1>
    %426 = llhd.sig.array_get %410[%c1_i2] : <!hw.array<4xstruct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>>
    %427 = llhd.sig.struct_extract %426["pull_en"] : <!hw.struct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>
    %428 = llhd.sig.struct_extract %427["d"] : <!hw.struct<d: i1>>
    %429 = comb.extract %414 from 1 : (i4) -> i1
    llhd.drv %428, %429 after %1 : i1
    %430 = llhd.sig.struct_extract %426["pull_select"] : <!hw.struct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>
    %431 = llhd.sig.struct_extract %430["d"] : <!hw.struct<d: i1>>
    %432 = comb.extract %418 from 1 : (i4) -> i1
    llhd.drv %431, %432 after %1 : i1
    %433 = llhd.sig.struct_extract %426["input_disable"] : <!hw.struct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>
    %434 = llhd.sig.struct_extract %433["d"] : <!hw.struct<d: i1>>
    %435 = comb.extract %422 from 1 : (i4) -> i1
    llhd.drv %434, %435 after %1 : i1
    %436 = llhd.sig.array_get %manual_pad_attr_o[%c1_i2] : <!hw.array<4xstruct<drive_strength: i4, slew_rate: i2, input_disable: i1, od_en: i1, schmitt_en: i1, keep_en: i1, pull_select: i1, pull_en: i1, virt_od_en: i1, invert: i1>>>
    %437 = hw.struct_create (%c0_i4, %c0_i2, %435, %false, %false, %false, %432, %429, %false, %false) : !hw.struct<drive_strength: i4, slew_rate: i2, input_disable: i1, od_en: i1, schmitt_en: i1, keep_en: i1, pull_select: i1, pull_en: i1, virt_od_en: i1, invert: i1>
    llhd.drv %436, %437 after %1 : !hw.struct<drive_strength: i4, slew_rate: i2, input_disable: i1, od_en: i1, schmitt_en: i1, keep_en: i1, pull_select: i1, pull_en: i1, virt_od_en: i1, invert: i1>
    %438 = llhd.sig.array_get %410[%c-2_i2] : <!hw.array<4xstruct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>>
    %439 = llhd.sig.struct_extract %438["pull_en"] : <!hw.struct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>
    %440 = llhd.sig.struct_extract %439["d"] : <!hw.struct<d: i1>>
    %441 = comb.extract %414 from 2 : (i4) -> i1
    llhd.drv %440, %441 after %1 : i1
    %442 = llhd.sig.struct_extract %438["pull_select"] : <!hw.struct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>
    %443 = llhd.sig.struct_extract %442["d"] : <!hw.struct<d: i1>>
    %444 = comb.extract %418 from 2 : (i4) -> i1
    llhd.drv %443, %444 after %1 : i1
    %445 = llhd.sig.struct_extract %438["input_disable"] : <!hw.struct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>
    %446 = llhd.sig.struct_extract %445["d"] : <!hw.struct<d: i1>>
    %447 = comb.extract %422 from 2 : (i4) -> i1
    llhd.drv %446, %447 after %1 : i1
    %448 = llhd.sig.array_get %manual_pad_attr_o[%c-2_i2] : <!hw.array<4xstruct<drive_strength: i4, slew_rate: i2, input_disable: i1, od_en: i1, schmitt_en: i1, keep_en: i1, pull_select: i1, pull_en: i1, virt_od_en: i1, invert: i1>>>
    %449 = hw.struct_create (%c0_i4, %c0_i2, %447, %false, %false, %false, %444, %441, %false, %false) : !hw.struct<drive_strength: i4, slew_rate: i2, input_disable: i1, od_en: i1, schmitt_en: i1, keep_en: i1, pull_select: i1, pull_en: i1, virt_od_en: i1, invert: i1>
    llhd.drv %448, %449 after %1 : !hw.struct<drive_strength: i4, slew_rate: i2, input_disable: i1, od_en: i1, schmitt_en: i1, keep_en: i1, pull_select: i1, pull_en: i1, virt_od_en: i1, invert: i1>
    %450 = llhd.sig.array_get %410[%c-1_i2] : <!hw.array<4xstruct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>>
    %451 = llhd.sig.struct_extract %450["pull_en"] : <!hw.struct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>
    %452 = llhd.sig.struct_extract %451["d"] : <!hw.struct<d: i1>>
    %453 = comb.extract %414 from 3 : (i4) -> i1
    llhd.drv %452, %453 after %1 : i1
    %454 = llhd.sig.struct_extract %450["pull_select"] : <!hw.struct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>
    %455 = llhd.sig.struct_extract %454["d"] : <!hw.struct<d: i1>>
    %456 = comb.extract %418 from 3 : (i4) -> i1
    llhd.drv %455, %456 after %1 : i1
    %457 = llhd.sig.struct_extract %450["input_disable"] : <!hw.struct<input_disable: !hw.struct<d: i1>, pull_select: !hw.struct<d: i1>, pull_en: !hw.struct<d: i1>>>
    %458 = llhd.sig.struct_extract %457["d"] : <!hw.struct<d: i1>>
    %459 = comb.extract %422 from 3 : (i4) -> i1
    llhd.drv %458, %459 after %1 : i1
    %460 = llhd.sig.array_get %manual_pad_attr_o[%c-1_i2] : <!hw.array<4xstruct<drive_strength: i4, slew_rate: i2, input_disable: i1, od_en: i1, schmitt_en: i1, keep_en: i1, pull_select: i1, pull_en: i1, virt_od_en: i1, invert: i1>>>
    %461 = hw.struct_create (%c0_i4, %c0_i2, %459, %false, %false, %false, %456, %453, %false, %false) : !hw.struct<drive_strength: i4, slew_rate: i2, input_disable: i1, od_en: i1, schmitt_en: i1, keep_en: i1, pull_select: i1, pull_en: i1, virt_od_en: i1, invert: i1>
    llhd.drv %460, %461 after %1 : !hw.struct<drive_strength: i4, slew_rate: i2, input_disable: i1, od_en: i1, schmitt_en: i1, keep_en: i1, pull_select: i1, pull_en: i1, virt_od_en: i1, invert: i1>
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %clk_aon_i_2, %clk_aon_i after %1 : i1
    llhd.drv %rst_aon_ni_3, %rst_aon_ni after %1 : i1
    %462 = llhd.prb %alert_tx_o : !hw.array<2xstruct<alert_p: i1, alert_n: i1>>
    %463 = llhd.prb %wkup_req_o : i1
    %464 = llhd.prb %manual_pad_attr_o : !hw.array<4xstruct<drive_strength: i4, slew_rate: i2, input_disable: i1, od_en: i1, schmitt_en: i1, keep_en: i1, pull_select: i1, pull_en: i1, virt_od_en: i1, invert: i1>>
    hw.output %u_reg.tl_o, %396, %ast2pinmux_i, %c-1_i9, %u_io_intr.intr_o, %u_init_intr.intr_o, %462, %463, %464 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<alerts_ack: !hw.array<11xstruct<p: i1, n: i1>>, alerts_trig: !hw.array<11xstruct<p: i1, n: i1>>>, i9, i9, i1, i1, !hw.array<2xstruct<alert_p: i1, alert_n: i1>>, i1, !hw.array<4xstruct<drive_strength: i4, slew_rate: i2, input_disable: i1, od_en: i1, schmitt_en: i1, keep_en: i1, pull_select: i1, pull_en: i1, virt_od_en: i1, invert: i1>>
  }
}
