module {
  hw.module private @prim_buf(in %in_i : i1, out out_o : i1) {
    hw.output %in_i : i1
  }
  hw.module private @prim_buf_0(in %in_i : i2, out out_o : i2) {
    hw.output %in_i : i2
  }
  hw.module private @prim_buf_17(in %in_i : i17, out out_o : i17) {
    hw.output %in_i : i17
  }
  hw.module private @prim_buf_33(in %in_i : i4, out out_o : i4) {
    hw.output %in_i : i4
  }
  hw.module private @prim_clock_buf(in %clk_i : i1, out clk_o : i1) {
    hw.output %clk_i : i1
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
  hw.module private @prim_flop_2sync_8(in %clk_i : i1, in %rst_ni : i1, in %d_i : i12, out q_o : i12) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i12 = hw.constant 0 : i12
    %d_i_0 = llhd.sig name "d_i" %c0_i12 : i12
    %d_o = llhd.sig %c0_i12 : i12
    %1 = llhd.prb %d_o : i12
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_22(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i12) -> (q_o: i12) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_22(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i12) -> (q_o: i12)
    %2 = llhd.prb %d_i_0 : i12
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %3 = llhd.prb %d_i_0 : i12
      llhd.drv %d_o, %3 after %0 : i12
      llhd.wait (%2, %1 : i12, i12), ^bb1
    }
    llhd.drv %d_i_0, %d_i after %0 : i12
    hw.output %u_sync_2.q_o : i12
  }
  hw.module private @prim_flop_2sync_9(in %clk_i : i1, in %rst_ni : i1, in %d_i : i5, out q_o : i5) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i5 = hw.constant 0 : i5
    %d_i_0 = llhd.sig name "d_i" %c0_i5 : i5
    %d_o = llhd.sig %c0_i5 : i5
    %1 = llhd.prb %d_o : i5
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_23(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i5) -> (q_o: i5) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_23(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i5) -> (q_o: i5)
    %2 = llhd.prb %d_i_0 : i5
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %3 = llhd.prb %d_i_0 : i5
      llhd.drv %d_o, %3 after %0 : i5
      llhd.wait (%2, %1 : i5, i5), ^bb1
    }
    llhd.drv %d_i_0, %d_i after %0 : i5
    hw.output %u_sync_2.q_o : i5
  }
  hw.module private @prim_flop_2sync_10(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %d_i_0 = llhd.sig name "d_i" %false : i1
    %d_o = llhd.sig %false : i1
    %1 = llhd.prb %d_o : i1
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_24(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i1) -> (q_o: i1) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_24(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i1) -> (q_o: i1)
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
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_25(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i2) -> (q_o: i2) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_25(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i2) -> (q_o: i2)
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
  hw.module private @prim_flop_2sync_12(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %d_i_0 = llhd.sig name "d_i" %c0_i4 : i4
    %d_o = llhd.sig %c0_i4 : i4
    %1 = llhd.prb %d_o : i4
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_30(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i4) -> (q_o: i4) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_30(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i4) -> (q_o: i4)
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
  hw.module private @prim_flop_2sync_26(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %d_i_0 = llhd.sig name "d_i" %c0_i4 : i4
    %d_o = llhd.sig %c0_i4 : i4
    %1 = llhd.prb %d_o : i4
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_27(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i4) -> (q_o: i4) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_27(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i4) -> (q_o: i4)
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
  hw.module private @prim_flop_14(in %clk_i : i1, in %rst_ni : i1, in %d_i : i22, out q_o : i22) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i22 = hw.constant 0 : i22
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %d_i_2 = llhd.sig name "d_i" %c0_i22 : i22
    %q_o = llhd.sig %c0_i22 : i22
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
      llhd.drv %q_o, %c0_i22 after %1 : i22
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %16 = llhd.prb %d_i_2 : i22
      llhd.drv %q_o, %16 after %1 : i22
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %d_i_2, %d_i after %0 : i22
    %4 = llhd.prb %q_o : i22
    hw.output %4 : i22
  }
  hw.module private @prim_flop_15(in %clk_i : i1, in %rst_ni : i1, in %d_i : i22, out q_o : i22) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i22 = hw.constant 0 : i22
    %c-1_i22 = hw.constant -1 : i22
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %d_i_2 = llhd.sig name "d_i" %c0_i22 : i22
    %q_o = llhd.sig %c0_i22 : i22
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
      llhd.drv %q_o, %c-1_i22 after %1 : i22
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %16 = llhd.prb %d_i_2 : i22
      llhd.drv %q_o, %16 after %1 : i22
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %d_i_2, %d_i after %0 : i22
    %4 = llhd.prb %q_o : i22
    hw.output %4 : i22
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
  hw.module private @prim_flop_22(in %clk_i : i1, in %rst_ni : i1, in %d_i : i12, out q_o : i12) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i12 = hw.constant 0 : i12
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %d_i_2 = llhd.sig name "d_i" %c0_i12 : i12
    %q_o = llhd.sig %c0_i12 : i12
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
      llhd.drv %q_o, %c0_i12 after %1 : i12
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %16 = llhd.prb %d_i_2 : i12
      llhd.drv %q_o, %16 after %1 : i12
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %d_i_2, %d_i after %0 : i12
    %4 = llhd.prb %q_o : i12
    hw.output %4 : i12
  }
  hw.module private @prim_flop_23(in %clk_i : i1, in %rst_ni : i1, in %d_i : i5, out q_o : i5) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i5 = hw.constant 0 : i5
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %d_i_2 = llhd.sig name "d_i" %c0_i5 : i5
    %q_o = llhd.sig %c0_i5 : i5
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
      llhd.drv %q_o, %c0_i5 after %1 : i5
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %16 = llhd.prb %d_i_2 : i5
      llhd.drv %q_o, %16 after %1 : i5
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %d_i_2, %d_i after %0 : i5
    %4 = llhd.prb %q_o : i5
    hw.output %4 : i5
  }
  hw.module private @prim_flop_24(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
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
  hw.module private @prim_flop_25(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_o : i2) {
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
  hw.module private @prim_flop_27(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i4 = hw.constant 0 : i4
    %c-7_i4 = hw.constant -7 : i4
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
      llhd.drv %q_o, %c-7_i4 after %1 : i4
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
  hw.module private @prim_flop_29(in %clk_i : i1, in %rst_ni : i1, in %d_i : i10, out q_o : i10) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i10 = hw.constant 0 : i10
    %c34_i10 = hw.constant 34 : i10
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %d_i_2 = llhd.sig name "d_i" %c0_i10 : i10
    %q_o = llhd.sig %c0_i10 : i10
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
      llhd.drv %q_o, %c34_i10 after %1 : i10
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %16 = llhd.prb %d_i_2 : i10
      llhd.drv %q_o, %16 after %1 : i10
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %d_i_2, %d_i after %0 : i10
    %4 = llhd.prb %q_o : i10
    hw.output %4 : i10
  }
  hw.module private @prim_flop_30(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
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
  hw.module private @prim_flop_31(in %clk_i : i1, in %rst_ni : i1, in %d_i : i12, out q_o : i12) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i12 = hw.constant 0 : i12
    %c55_i12 = hw.constant 55 : i12
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %d_i_2 = llhd.sig name "d_i" %c0_i12 : i12
    %q_o = llhd.sig %c0_i12 : i12
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
      llhd.drv %q_o, %c55_i12 after %1 : i12
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %16 = llhd.prb %d_i_2 : i12
      llhd.drv %q_o, %16 after %1 : i12
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %d_i_2, %d_i after %0 : i12
    %4 = llhd.prb %q_o : i12
    hw.output %4 : i12
  }
  hw.module private @prim_xnor2(in %in0_i : i1, in %in1_i : i1, out out_o : i1) {
    %true = hw.constant true
    %0 = comb.xor %in0_i, %in1_i, %true : i1
    hw.output %0 : i1
  }
  hw.module private @prim_xor2(in %in0_i : i4, in %in1_i : i4, out out_o : i4) {
    %0 = comb.xor %in0_i, %in1_i : i4
    hw.output %0 : i4
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
    %u_prim_buf_ping.out_o = hw.instance "u_prim_buf_ping" @prim_sec_anchor_buf_6(in_i: %5: i2) -> (out_o: i2)
    %6 = comb.extract %u_prim_buf_ping.out_o from 1 {sv.namehint = "ping_n"} : (i2) -> i1
    %7 = comb.extract %u_prim_buf_ping.out_o from 0 {sv.namehint = "ping_p"} : (i2) -> i1
    %u_decode_ping.level_o, %u_decode_ping.rise_o, %u_decode_ping.fall_o, %u_decode_ping.event_o, %u_decode_ping.sigint_o = hw.instance "u_decode_ping" @prim_diff_decode_7(clk_i: %3: i1, rst_ni: %4: i1, diff_pi: %7: i1, diff_ni: %6: i1) -> (level_o: i1, rise_o: i1, fall_o: i1, event_o: i1, sigint_o: i1) {sv.namehint = "ping_event"}
    %ack_n = hw.struct_extract %alert_rx_i["ack_n"] : !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>
    %ack_p = hw.struct_extract %alert_rx_i["ack_p"] : !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>
    %8 = comb.concat %ack_n, %ack_p : i1, i1
    %u_prim_buf_ack.out_o = hw.instance "u_prim_buf_ack" @prim_sec_anchor_buf_6(in_i: %8: i2) -> (out_o: i2)
    %9 = comb.extract %u_prim_buf_ack.out_o from 1 {sv.namehint = "ack_n"} : (i2) -> i1
    %10 = comb.extract %u_prim_buf_ack.out_o from 0 {sv.namehint = "ack_p"} : (i2) -> i1
    %u_decode_ack.level_o, %u_decode_ack.rise_o, %u_decode_ack.fall_o, %u_decode_ack.event_o, %u_decode_ack.sigint_o = hw.instance "u_decode_ack" @prim_diff_decode_7(clk_i: %3: i1, rst_ni: %4: i1, diff_pi: %10: i1, diff_ni: %9: i1) -> (level_o: i1, rise_o: i1, fall_o: i1, event_o: i1, sigint_o: i1) {sv.namehint = "ack_sigint"}
    llhd.drv %ack_level, %u_decode_ack.level_o after %1 : i1
    %u_prim_buf_in_req.out_o = hw.instance "u_prim_buf_in_req" @prim_sec_anchor_buf(in_i: %alert_req_i: i1) -> (out_o: i1) {sv.namehint = "alert_req"}
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
  hw.module private @prim_clock_timeout(in %clk_chk_i : i1, in %rst_chk_ni : i1, in %clk_i : i1, in %rst_ni : i1, in %en_i : i1, out timeout_o : i1) {
    %c-1_i8 = hw.constant -1 : i8
    %c127_i32 = hw.constant 127 : i32
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c0_i24 = hw.constant 0 : i24
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c1_i8 = hw.constant 1 : i8
    %c0_i8 = hw.constant 0 : i8
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %en_i_2 = llhd.sig name "en_i" %false : i1
    %cnt = llhd.sig %c0_i8 : i8
    %ack = llhd.sig %false : i1
    %timeout = llhd.sig %false : i1
    %u_ref_timeout.src_ack_o, %u_ref_timeout.dst_req_o = hw.instance "u_ref_timeout" @prim_sync_reqack(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_chk_i: i1, rst_dst_ni: %rst_chk_ni: i1, req_chk_i: %false: i1, src_req_i: %true: i1, dst_ack_i: %u_ref_timeout.dst_req_o: i1) -> (src_ack_o: i1, dst_req_o: i1) {sv.namehint = "chk_req"}
    llhd.drv %ack, %u_ref_timeout.src_ack_o after %1 : i1
    %4 = llhd.prb %timeout : i1
    %u_out.q_o = hw.instance "u_out" @prim_flop(clk_i: %2: i1, rst_ni: %3: i1, d_i: %4: i1) -> (q_o: i1)
    %5 = llhd.prb %cnt : i8
    %6 = comb.concat %c0_i24, %5 : i24, i8
    %7 = comb.icmp sgt %6, %c127_i32 : i32
    llhd.drv %timeout, %7 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
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
      llhd.drv %cnt, %c0_i8 after %0 : i8
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %19 = llhd.prb %ack : i1
      %20 = llhd.prb %en_i_2 : i1
      %21 = comb.xor %20, %true : i1
      %22 = comb.or %19, %21 : i1
      cf.cond_br %22, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %cnt, %c0_i8 after %0 : i8
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %23 = llhd.prb %timeout : i1
      cf.cond_br %23, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %cnt, %c-1_i8 after %0 : i8
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %24 = llhd.prb %en_i_2 : i1
      cf.cond_br %24, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      %25 = llhd.prb %cnt : i8
      %26 = comb.add %25, %c1_i8 : i8
      llhd.drv %cnt, %26 after %0 : i8
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %en_i_2, %en_i after %1 : i1
    hw.output %u_out.q_o : i1
  }
  hw.module private @prim_count(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %set_i : i1, in %set_cnt_i : i22, in %incr_en_i : i1, in %decr_en_i : i1, in %step_i : i22, in %commit_i : i1, out cnt_o : i22, out cnt_after_commit_o : i22, out err_o : i1) {
    %c4194303_i23 = hw.constant 4194303 : i23
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i22 = hw.constant -1 : i22
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i23 = hw.constant 0 : i23
    %2 = hw.aggregate_constant [0 : i22, 0 : i22] : !hw.array<2xi22>
    %false = hw.constant false
    %true = hw.constant true
    %c0_i22 = hw.constant 0 : i22
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %set_i_2 = llhd.sig name "set_i" %false : i1
    %step_i_3 = llhd.sig name "step_i" %c0_i22 : i22
    %cnt_d = llhd.sig %2 : !hw.array<2xi22>
    %cnt_d_committed = llhd.sig %2 : !hw.array<2xi22>
    %cnt_q = llhd.sig %2 : !hw.array<2xi22>
    %gen_cnts_0.incr_en = llhd.sig %false : i1
    %gen_cnts_0.set_val = llhd.sig %c0_i22 : i22
    %gen_cnts_0.ext_cnt = llhd.sig %c0_i23 : i23
    %gen_cnts_0.oflow = llhd.sig %false : i1
    %gen_cnts_0.cnt_sat = llhd.sig %c0_i22 : i22
    %gen_cnts_0.cnt_en = llhd.sig %false : i1
    %gen_cnts_1.incr_en = llhd.sig %false : i1
    %gen_cnts_1.set_val = llhd.sig %c0_i22 : i22
    %gen_cnts_1.ext_cnt = llhd.sig %c0_i23 : i23
    %gen_cnts_1.oflow = llhd.sig %false : i1
    %gen_cnts_1.cnt_sat = llhd.sig %c0_i22 : i22
    %gen_cnts_1.cnt_en = llhd.sig %false : i1
    %err_d = llhd.sig %false : i1
    %err_q = llhd.sig %false : i1
    %5 = llhd.prb %cnt_d_committed : !hw.array<2xi22>
    %6 = hw.array_get %5[%false] : !hw.array<2xi22>, i1
    %gen_cnts_0.u_cnt_flop.q_o = hw.instance "gen_cnts_0.u_cnt_flop" @prim_flop_14(clk_i: %3: i1, rst_ni: %4: i1, d_i: %6: i22) -> (q_o: i22) {sv.namehint = "gen_cnts_0.cnt_unforced_q"}
    %7 = hw.array_get %5[%true] : !hw.array<2xi22>, i1
    %gen_cnts_1.u_cnt_flop.q_o = hw.instance "gen_cnts_1.u_cnt_flop" @prim_flop_15(clk_i: %3: i1, rst_ni: %4: i1, d_i: %7: i22) -> (q_o: i22) {sv.namehint = "gen_cnts_1.cnt_unforced_q"}
    llhd.drv %gen_cnts_0.incr_en, %incr_en_i after %1 : i1
    llhd.drv %gen_cnts_0.set_val, %set_cnt_i after %1 : i22
    %8 = llhd.prb %cnt_q : !hw.array<2xi22>
    %9 = hw.array_get %8[%false] : !hw.array<2xi22>, i1
    %10 = comb.concat %false, %9 : i1, i22
    %11 = llhd.prb %step_i_3 : i22
    %12 = comb.concat %false, %11 : i1, i22
    %13 = comb.sub %10, %12 : i23
    %14 = llhd.prb %gen_cnts_0.incr_en : i1
    %15 = comb.add %10, %12 : i23
    %16 = comb.mux %14, %15, %10 : i23
    %17 = comb.mux %decr_en_i, %13, %16 : i23
    llhd.drv %gen_cnts_0.ext_cnt, %17 after %1 : i23
    %18 = llhd.prb %gen_cnts_0.ext_cnt : i23
    %19 = comb.extract %18 from 22 : (i23) -> i1
    %20 = comb.and %14, %19 : i1
    llhd.drv %gen_cnts_0.oflow, %20 after %1 : i1
    %21 = comb.and %decr_en_i, %19 {sv.namehint = "gen_cnts_0.uflow"} : i1
    %22 = llhd.prb %gen_cnts_0.oflow : i1
    %23 = comb.extract %18 from 0 : (i23) -> i22
    %24 = comb.mux %22, %c-1_i22, %23 : i22
    %25 = comb.mux %21, %c0_i22, %24 : i22
    llhd.drv %gen_cnts_0.cnt_sat, %25 after %1 : i22
    %26 = comb.xor %14, %decr_en_i : i1
    %27 = comb.icmp ne %9, %c-1_i22 : i22
    %28 = comb.and %14, %27 : i1
    %29 = comb.icmp ne %9, %c0_i22 : i22
    %30 = comb.and %decr_en_i, %29 : i1
    %31 = comb.or %28, %30 : i1
    %32 = comb.and %26, %31 : i1
    llhd.drv %gen_cnts_0.cnt_en, %32 after %1 : i1
    %33 = llhd.sig.array_get %cnt_d[%false] : <!hw.array<2xi22>>
    %34 = llhd.prb %set_i_2 : i1
    %35 = llhd.prb %gen_cnts_0.set_val : i22
    %36 = llhd.prb %gen_cnts_0.cnt_en : i1
    %37 = llhd.prb %gen_cnts_0.cnt_sat : i22
    %38 = comb.mux %36, %37, %9 : i22
    %39 = comb.mux %34, %35, %38 : i22
    %40 = comb.mux %clr_i, %c0_i22, %39 : i22
    llhd.drv %33, %40 after %1 : i22
    %41 = llhd.sig.array_get %cnt_d_committed[%false] : <!hw.array<2xi22>>
    %42 = llhd.prb %cnt_d : !hw.array<2xi22>
    %43 = hw.array_get %42[%false] : !hw.array<2xi22>, i1
    %44 = comb.mux %commit_i, %43, %9 : i22
    llhd.drv %41, %44 after %1 : i22
    %45 = llhd.sig.array_get %cnt_q[%false] : <!hw.array<2xi22>>
    llhd.drv %45, %gen_cnts_0.u_cnt_flop.q_o after %1 : i22
    llhd.drv %gen_cnts_1.incr_en, %decr_en_i after %1 : i1
    %46 = comb.sub %c-1_i22, %set_cnt_i : i22
    llhd.drv %gen_cnts_1.set_val, %46 after %1 : i22
    %47 = hw.array_get %8[%true] : !hw.array<2xi22>, i1
    %48 = comb.concat %false, %47 : i1, i22
    %49 = comb.sub %48, %12 : i23
    %50 = llhd.prb %gen_cnts_1.incr_en : i1
    %51 = comb.add %48, %12 : i23
    %52 = comb.mux %50, %51, %48 : i23
    %53 = comb.mux %incr_en_i, %49, %52 : i23
    llhd.drv %gen_cnts_1.ext_cnt, %53 after %1 : i23
    %54 = llhd.prb %gen_cnts_1.ext_cnt : i23
    %55 = comb.extract %54 from 22 : (i23) -> i1
    %56 = comb.and %50, %55 : i1
    llhd.drv %gen_cnts_1.oflow, %56 after %1 : i1
    %57 = comb.and %incr_en_i, %55 {sv.namehint = "gen_cnts_1.uflow"} : i1
    %58 = llhd.prb %gen_cnts_1.oflow : i1
    %59 = comb.extract %54 from 0 : (i23) -> i22
    %60 = comb.mux %58, %c-1_i22, %59 : i22
    %61 = comb.mux %57, %c0_i22, %60 : i22
    llhd.drv %gen_cnts_1.cnt_sat, %61 after %1 : i22
    %62 = comb.xor %50, %incr_en_i : i1
    %63 = comb.icmp ne %47, %c-1_i22 : i22
    %64 = comb.and %50, %63 : i1
    %65 = comb.icmp ne %47, %c0_i22 : i22
    %66 = comb.and %incr_en_i, %65 : i1
    %67 = comb.or %64, %66 : i1
    %68 = comb.and %62, %67 : i1
    llhd.drv %gen_cnts_1.cnt_en, %68 after %1 : i1
    %69 = llhd.sig.array_get %cnt_d[%true] : <!hw.array<2xi22>>
    %70 = llhd.prb %gen_cnts_1.set_val : i22
    %71 = llhd.prb %gen_cnts_1.cnt_en : i1
    %72 = llhd.prb %gen_cnts_1.cnt_sat : i22
    %73 = comb.mux %71, %72, %47 : i22
    %74 = comb.mux %34, %70, %73 : i22
    %75 = comb.mux %clr_i, %c-1_i22, %74 : i22
    llhd.drv %69, %75 after %1 : i22
    %76 = llhd.sig.array_get %cnt_d_committed[%true] : <!hw.array<2xi22>>
    %77 = hw.array_get %42[%true] : !hw.array<2xi22>, i1
    %78 = comb.mux %commit_i, %77, %47 : i22
    llhd.drv %76, %78 after %1 : i22
    %79 = llhd.sig.array_get %cnt_q[%true] : <!hw.array<2xi22>>
    llhd.drv %79, %gen_cnts_1.u_cnt_flop.q_o after %1 : i22
    %80 = comb.add %10, %48 {sv.namehint = "sum"} : i23
    %81 = comb.icmp ne %80, %c4194303_i23 : i23
    llhd.drv %err_d, %81 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %83 = llhd.prb %clk_i_0 : i1
      %84 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %85 = llhd.prb %clk_i_0 : i1
      %86 = comb.xor bin %83, %true : i1
      %87 = comb.and bin %86, %85 : i1
      %88 = llhd.prb %rst_ni_1 : i1
      %89 = comb.xor bin %88, %true : i1
      %90 = comb.and bin %84, %89 : i1
      %91 = comb.or bin %87, %90 : i1
      cf.cond_br %91, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %92 = llhd.prb %rst_ni_1 : i1
      %93 = comb.xor %92, %true : i1
      cf.cond_br %93, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %err_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %94 = llhd.prb %err_d : i1
      llhd.drv %err_q, %94 after %0 : i1
      cf.br ^bb1
    }
    %82 = llhd.prb %err_q : i1
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %set_i_2, %set_i after %1 : i1
    llhd.drv %step_i_3, %step_i after %1 : i22
    hw.output %9, %43, %82 : i22, i22, i1
  }
  hw.module private @prim_diff_decode(in %clk_i : i1, in %rst_ni : i1, in %diff_pi : i1, in %diff_ni : i1, out level_o : i1, out rise_o : i1, out fall_o : i1, out event_o : i1, out sigint_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %diff_pi_2 = llhd.sig name "diff_pi" %false : i1
    %level_d = llhd.sig %false : i1
    %level_q = llhd.sig %false : i1
    %gen_no_async.diff_pq = llhd.sig %false : i1
    %gen_no_async.diff_pd = llhd.sig %false : i1
    %4 = llhd.prb %diff_pi_2 : i1
    %gen_no_async.u_xnor2_sigint.out_o = hw.instance "gen_no_async.u_xnor2_sigint" @prim_xnor2(in0_i: %4: i1, in1_i: %diff_ni: i1) -> (out_o: i1)
    llhd.drv %gen_no_async.diff_pd, %4 after %1 : i1
    %5 = llhd.prb %level_q : i1
    %6 = comb.mux %gen_no_async.u_xnor2_sigint.out_o, %5, %4 : i1
    llhd.drv %level_d, %6 after %1 : i1
    %7 = llhd.prb %gen_no_async.diff_pq : i1
    %8 = comb.xor %7, %true : i1
    %9 = comb.xor %gen_no_async.u_xnor2_sigint.out_o, %true : i1
    %10 = comb.and %8, %4, %9 : i1
    %11 = comb.xor %4, %true : i1
    %12 = comb.and %7, %11, %9 : i1
    %13 = comb.or %10, %12 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %14 = llhd.prb %clk_i_0 : i1
      %15 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %16 = llhd.prb %clk_i_0 : i1
      %17 = comb.xor bin %14, %true : i1
      %18 = comb.and bin %17, %16 : i1
      %19 = llhd.prb %rst_ni_1 : i1
      %20 = comb.xor bin %19, %true : i1
      %21 = comb.and bin %15, %20 : i1
      %22 = comb.or bin %18, %21 : i1
      cf.cond_br %22, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %23 = llhd.prb %rst_ni_1 : i1
      %24 = comb.xor %23, %true : i1
      cf.cond_br %24, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_no_async.diff_pq, %false after %0 : i1
      llhd.drv %level_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %25 = llhd.prb %gen_no_async.diff_pd : i1
      llhd.drv %gen_no_async.diff_pq, %25 after %0 : i1
      %26 = llhd.prb %level_d : i1
      llhd.drv %level_q, %26 after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %diff_pi_2, %diff_pi after %1 : i1
    hw.output %6, %10, %12, %13, %gen_no_async.u_xnor2_sigint.out_o : i1, i1, i1, i1, i1
  }
  hw.module private @prim_diff_decode_7(in %clk_i : i1, in %rst_ni : i1, in %diff_pi : i1, in %diff_ni : i1, out level_o : i1, out rise_o : i1, out fall_o : i1, out event_o : i1, out sigint_o : i1) {
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
    %gen_async.i_sync_p.q_o = hw.instance "gen_async.i_sync_p" @prim_flop_2sync(clk_i: %2: i1, rst_ni: %3: i1, d_i: %diff_pi: i1) -> (q_o: i1)
    llhd.drv %gen_async.diff_pd, %gen_async.i_sync_p.q_o after %1 : i1
    %gen_async.i_sync_n.q_o = hw.instance "gen_async.i_sync_n" @prim_flop_2sync_10(clk_i: %2: i1, rst_ni: %3: i1, d_i: %diff_ni: i1) -> (q_o: i1)
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
  hw.module private @prim_esc_receiver(in %clk_i : i1, in %rst_ni : i1, out esc_req_o : i1, out esc_rx_o : !hw.struct<resp_p: i1, resp_n: i1>, in %esc_tx_i : !hw.struct<esc_p: i1, esc_n: i1>) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i22 = hw.constant -1 : i22
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [false, false] : !hw.struct<resp_p: i1, resp_n: i1>
    %c-4_i3 = hw.constant -4 : i3
    %c3_i3 = hw.constant 3 : i3
    %c2_i3 = hw.constant 2 : i3
    %c1_i3 = hw.constant 1 : i3
    %c0_i3 = hw.constant 0 : i3
    %c0_i22 = hw.constant 0 : i22
    %true = hw.constant true
    %c1_i22 = hw.constant 1 : i22
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %esc_rx_o = llhd.sig %2 : !hw.struct<resp_p: i1, resp_n: i1>
    %esc_level = llhd.sig %false : i1
    %sigint_detected = llhd.sig %false : i1
    %ping_en = llhd.sig %false : i1
    %esc_req = llhd.sig %false : i1
    %esc_req_d = llhd.sig %false : i1
    %esc_req_q = llhd.sig %false : i1
    %state_d = llhd.sig %c0_i3 : i3
    %state_q = llhd.sig %c0_i3 : i3
    %resp_pd = llhd.sig %false : i1
    %resp_pq = llhd.sig %false : i1
    %resp_nd = llhd.sig %false : i1
    %esc_n = hw.struct_extract %esc_tx_i["esc_n"] : !hw.struct<esc_p: i1, esc_n: i1>
    %esc_p = hw.struct_extract %esc_tx_i["esc_p"] : !hw.struct<esc_p: i1, esc_n: i1>
    %5 = comb.concat %esc_n, %esc_p : i1, i1
    %u_prim_buf_esc.out_o = hw.instance "u_prim_buf_esc" @prim_buf_0(in_i: %5: i2) -> (out_o: i2)
    %6 = comb.extract %u_prim_buf_esc.out_o from 1 {sv.namehint = "esc_n"} : (i2) -> i1
    %7 = comb.extract %u_prim_buf_esc.out_o from 0 {sv.namehint = "esc_p"} : (i2) -> i1
    %u_decode_esc.level_o, %u_decode_esc.rise_o, %u_decode_esc.fall_o, %u_decode_esc.event_o, %u_decode_esc.sigint_o = hw.instance "u_decode_esc" @prim_diff_decode(clk_i: %3: i1, rst_ni: %4: i1, diff_pi: %7: i1, diff_ni: %6: i1) -> (level_o: i1, rise_o: i1, fall_o: i1, event_o: i1, sigint_o: i1)
    llhd.drv %esc_level, %u_decode_esc.level_o after %1 : i1
    llhd.drv %sigint_detected, %u_decode_esc.sigint_o after %1 : i1
    %u_prim_count.cnt_o, %u_prim_count.cnt_after_commit_o, %u_prim_count.err_o = hw.instance "u_prim_count" @prim_count(clk_i: %3: i1, rst_ni: %4: i1, clr_i: %false: i1, set_i: %17: i1, set_cnt_i: %c1_i22: i22, incr_en_i: %18: i1, decr_en_i: %false: i1, step_i: %c1_i22: i22, commit_i: %true: i1) -> (cnt_o: i22, cnt_after_commit_o: i22, err_o: i1) {sv.namehint = "timeout_cnt"}
    %8 = llhd.prb %esc_req_q : i1
    %u_prim_buf_esc_req.out_o = hw.instance "u_prim_buf_esc_req" @prim_sec_anchor_buf(in_i: %8: i1) -> (out_o: i1)
    %9 = llhd.prb %resp_nd : i1
    %10 = llhd.prb %resp_pd : i1
    %11 = comb.concat %9, %10 : i1, i1
    %u_prim_flop_esc.q_o = hw.instance "u_prim_flop_esc" @prim_sec_anchor_flop(clk_i: %3: i1, rst_ni: %4: i1, d_i: %11: i2) -> (q_o: i2)
    %12 = comb.extract %u_prim_flop_esc.q_o from 1 {sv.namehint = "resp_nq"} : (i2) -> i1
    %13 = comb.extract %u_prim_flop_esc.q_o from 0 : (i2) -> i1
    llhd.drv %resp_pq, %13 after %1 : i1
    %14 = llhd.prb %ping_en : i1
    %15 = comb.icmp eq %u_prim_count.cnt_o, %c-1_i22 : i22
    %16 = comb.xor %15, %true : i1
    %17 = comb.and %14, %16 {sv.namehint = "timeout_cnt_set"} : i1
    %18 = comb.icmp ne %u_prim_count.cnt_o, %c0_i22 {sv.namehint = "timeout_cnt_en"} : i22
    %19 = llhd.prb %esc_req : i1
    %20 = comb.or %19, %15, %u_prim_count.err_o : i1
    llhd.drv %esc_req_d, %20 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %29 = llhd.prb %clk_i_0 : i1
      %30 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %31 = llhd.prb %clk_i_0 : i1
      %32 = comb.xor bin %29, %true : i1
      %33 = comb.and bin %32, %31 : i1
      %34 = llhd.prb %rst_ni_1 : i1
      %35 = comb.xor bin %34, %true : i1
      %36 = comb.and bin %30, %35 : i1
      %37 = comb.or bin %33, %36 : i1
      cf.cond_br %37, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %38 = llhd.prb %rst_ni_1 : i1
      %39 = comb.xor %38, %true : i1
      cf.cond_br %39, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %esc_req_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %40 = llhd.prb %esc_req_d : i1
      llhd.drv %esc_req_q, %40 after %0 : i1
      cf.br ^bb1
    }
    %21 = llhd.sig.struct_extract %esc_rx_o["resp_p"] : <!hw.struct<resp_p: i1, resp_n: i1>>
    %22 = llhd.prb %resp_pq : i1
    llhd.drv %21, %22 after %1 : i1
    %23 = llhd.sig.struct_extract %esc_rx_o["resp_n"] : <!hw.struct<resp_p: i1, resp_n: i1>>
    llhd.drv %23, %12 after %1 : i1
    %24 = llhd.prb %state_q : i3
    %25 = llhd.prb %state_d : i3
    %26 = llhd.prb %esc_level : i1
    %27 = llhd.prb %sigint_detected : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb19
      %29 = llhd.prb %state_q : i3
      llhd.drv %state_d, %29 after %1 : i3
      llhd.drv %resp_pd, %false after %1 : i1
      llhd.drv %resp_nd, %true after %1 : i1
      llhd.drv %esc_req, %false after %1 : i1
      llhd.drv %ping_en, %false after %1 : i1
      %30 = llhd.prb %state_q : i3
      %31 = comb.icmp ceq %30, %c0_i3 : i3
      cf.cond_br %31, ^bb2, ^bb4
    ^bb2:  // pred: ^bb1
      %32 = llhd.prb %esc_level : i1
      cf.cond_br %32, ^bb3, ^bb17
    ^bb3:  // pred: ^bb2
      llhd.drv %state_d, %c1_i3 after %1 : i3
      %33 = llhd.prb %resp_pq : i1
      %34 = comb.xor %33, %true : i1
      llhd.drv %resp_pd, %34 after %1 : i1
      %35 = llhd.prb %resp_pq : i1
      llhd.drv %resp_nd, %35 after %1 : i1
      cf.br ^bb17
    ^bb4:  // pred: ^bb1
      %36 = comb.icmp ceq %30, %c1_i3 : i3
      cf.cond_br %36, ^bb5, ^bb7
    ^bb5:  // pred: ^bb4
      llhd.drv %state_d, %c2_i3 after %1 : i3
      %37 = llhd.prb %resp_pq : i1
      %38 = comb.xor %37, %true : i1
      llhd.drv %resp_pd, %38 after %1 : i1
      %39 = llhd.prb %resp_pq : i1
      llhd.drv %resp_nd, %39 after %1 : i1
      %40 = llhd.prb %esc_level : i1
      cf.cond_br %40, ^bb6, ^bb17
    ^bb6:  // pred: ^bb5
      llhd.drv %state_d, %c3_i3 after %1 : i3
      llhd.drv %esc_req, %true after %1 : i1
      cf.br ^bb17
    ^bb7:  // pred: ^bb4
      %41 = comb.icmp ceq %30, %c2_i3 : i3
      cf.cond_br %41, ^bb8, ^bb10
    ^bb8:  // pred: ^bb7
      llhd.drv %state_d, %c0_i3 after %1 : i3
      %42 = llhd.prb %resp_pq : i1
      %43 = comb.xor %42, %true : i1
      llhd.drv %resp_pd, %43 after %1 : i1
      %44 = llhd.prb %resp_pq : i1
      llhd.drv %resp_nd, %44 after %1 : i1
      llhd.drv %ping_en, %true after %1 : i1
      %45 = llhd.prb %esc_level : i1
      cf.cond_br %45, ^bb9, ^bb17
    ^bb9:  // pred: ^bb8
      llhd.drv %state_d, %c3_i3 after %1 : i3
      llhd.drv %esc_req, %true after %1 : i1
      cf.br ^bb17
    ^bb10:  // pred: ^bb7
      %46 = comb.icmp ceq %30, %c3_i3 : i3
      cf.cond_br %46, ^bb11, ^bb13
    ^bb11:  // pred: ^bb10
      llhd.drv %state_d, %c0_i3 after %1 : i3
      %47 = llhd.prb %esc_level : i1
      cf.cond_br %47, ^bb12, ^bb17
    ^bb12:  // pred: ^bb11
      llhd.drv %state_d, %c3_i3 after %1 : i3
      %48 = llhd.prb %resp_pq : i1
      %49 = comb.xor %48, %true : i1
      llhd.drv %resp_pd, %49 after %1 : i1
      %50 = llhd.prb %resp_pq : i1
      llhd.drv %resp_nd, %50 after %1 : i1
      llhd.drv %esc_req, %true after %1 : i1
      cf.br ^bb17
    ^bb13:  // pred: ^bb10
      %51 = comb.icmp ceq %30, %c-4_i3 : i3
      cf.cond_br %51, ^bb14, ^bb16
    ^bb14:  // pred: ^bb13
      llhd.drv %state_d, %c0_i3 after %1 : i3
      llhd.drv %esc_req, %true after %1 : i1
      %52 = llhd.prb %sigint_detected : i1
      cf.cond_br %52, ^bb15, ^bb17
    ^bb15:  // pred: ^bb14
      llhd.drv %state_d, %c-4_i3 after %1 : i3
      %53 = llhd.prb %resp_pq : i1
      %54 = comb.xor %53, %true : i1
      llhd.drv %resp_pd, %54 after %1 : i1
      %55 = llhd.prb %resp_pq : i1
      %56 = comb.xor %55, %true : i1
      llhd.drv %resp_nd, %56 after %1 : i1
      cf.br ^bb17
    ^bb16:  // pred: ^bb13
      llhd.drv %state_d, %c0_i3 after %1 : i3
      cf.br ^bb17
    ^bb17:  // 11 preds: ^bb2, ^bb3, ^bb5, ^bb6, ^bb8, ^bb9, ^bb11, ^bb12, ^bb14, ^bb15, ^bb16
      %57 = llhd.prb %sigint_detected : i1
      %58 = llhd.prb %state_q : i3
      %59 = comb.icmp ne %58, %c-4_i3 : i3
      %60 = comb.and %57, %59 : i1
      cf.cond_br %60, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      llhd.drv %state_d, %c-4_i3 after %1 : i3
      llhd.drv %resp_pd, %false after %1 : i1
      llhd.drv %resp_nd, %false after %1 : i1
      cf.br ^bb19
    ^bb19:  // 2 preds: ^bb17, ^bb18
      llhd.wait (%24, %25, %10, %9, %19, %14, %26, %22, %27 : i3, i3, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %29 = llhd.prb %clk_i_0 : i1
      %30 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %31 = llhd.prb %clk_i_0 : i1
      %32 = comb.xor bin %29, %true : i1
      %33 = comb.and bin %32, %31 : i1
      %34 = llhd.prb %rst_ni_1 : i1
      %35 = comb.xor bin %34, %true : i1
      %36 = comb.and bin %30, %35 : i1
      %37 = comb.or bin %33, %36 : i1
      cf.cond_br %37, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %38 = llhd.prb %rst_ni_1 : i1
      %39 = comb.xor %38, %true : i1
      cf.cond_br %39, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %state_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %40 = llhd.prb %state_d : i3
      llhd.drv %state_q, %40 after %0 : i3
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    %28 = llhd.prb %esc_rx_o : !hw.struct<resp_p: i1, resp_n: i1>
    hw.output %u_prim_buf_esc_req.out_o, %28 : i1, !hw.struct<resp_p: i1, resp_n: i1>
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
  func.func private @"prim_mubi_pkg::mubi4_test_false_loose"(%arg0: i4) -> i1 {
    %c6_i4 = hw.constant 6 : i4
    %0 = comb.icmp ne %arg0, %c6_i4 : i4
    return %0 : i1
  }
  func.func private @"prim_mubi_pkg::mubi4_or"(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
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
  func.func private @"prim_mubi_pkg::mubi4_and"(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
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
    %18 = comb.and %15, %17 : i1
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
    %28 = comb.or %25, %27 : i1
    llhd.drv %23, %28 after %0 : i1
    cf.br ^bb5
  ^bb5:  // 2 preds: ^bb3, ^bb4
    %29 = comb.add %1, %c1_i32 : i32
    cf.br ^bb1(%29 : i32)
  ^bb6:  // pred: ^bb1
    %30 = llhd.prb %out : i4
    return %30 : i4
  }
  func.func private @"prim_mubi_pkg::mubi4_or_hi"(%arg0: i4, %arg1: i4) -> i4 {
    %c6_i4 = hw.constant 6 : i4
    %0 = call @"prim_mubi_pkg::mubi4_or"(%arg0, %arg1, %c6_i4) : (i4, i4, i4) -> i4
    return %0 : i4
  }
  func.func private @"prim_mubi_pkg::mubi4_and_hi"(%arg0: i4, %arg1: i4) -> i4 {
    %c6_i4 = hw.constant 6 : i4
    %0 = call @"prim_mubi_pkg::mubi4_and"(%arg0, %arg1, %c6_i4) : (i4, i4, i4) -> i4
    return %0 : i4
  }
  hw.module private @prim_onehot_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i17, in %addr_i : i5, in %en_i : i1, out err_o : i1) {
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
    %480 = comb.extract %oh_i from 0 : (i17) -> i1
    llhd.drv %479, %480 after %0 : i1
    %481 = llhd.sig.extract %and_tree from %c31_i6 : <i63> -> <i1>
    llhd.drv %481, %480 after %0 : i1
    %482 = llhd.sig.extract %err_tree from %c31_i6 : <i63> -> <i1>
    llhd.drv %482, %false after %0 : i1
    %483 = llhd.sig.extract %or_tree from %c-32_i6 : <i63> -> <i1>
    %484 = comb.extract %oh_i from 1 : (i17) -> i1
    llhd.drv %483, %484 after %0 : i1
    %485 = llhd.sig.extract %and_tree from %c-32_i6 : <i63> -> <i1>
    llhd.drv %485, %484 after %0 : i1
    %486 = llhd.sig.extract %err_tree from %c-32_i6 : <i63> -> <i1>
    llhd.drv %486, %false after %0 : i1
    %487 = llhd.sig.extract %or_tree from %c-31_i6 : <i63> -> <i1>
    %488 = comb.extract %oh_i from 2 : (i17) -> i1
    llhd.drv %487, %488 after %0 : i1
    %489 = llhd.sig.extract %and_tree from %c-31_i6 : <i63> -> <i1>
    llhd.drv %489, %488 after %0 : i1
    %490 = llhd.sig.extract %err_tree from %c-31_i6 : <i63> -> <i1>
    llhd.drv %490, %false after %0 : i1
    %491 = llhd.sig.extract %or_tree from %c-30_i6 : <i63> -> <i1>
    %492 = comb.extract %oh_i from 3 : (i17) -> i1
    llhd.drv %491, %492 after %0 : i1
    %493 = llhd.sig.extract %and_tree from %c-30_i6 : <i63> -> <i1>
    llhd.drv %493, %492 after %0 : i1
    %494 = llhd.sig.extract %err_tree from %c-30_i6 : <i63> -> <i1>
    llhd.drv %494, %false after %0 : i1
    %495 = llhd.sig.extract %or_tree from %c-29_i6 : <i63> -> <i1>
    %496 = comb.extract %oh_i from 4 : (i17) -> i1
    llhd.drv %495, %496 after %0 : i1
    %497 = llhd.sig.extract %and_tree from %c-29_i6 : <i63> -> <i1>
    llhd.drv %497, %496 after %0 : i1
    %498 = llhd.sig.extract %err_tree from %c-29_i6 : <i63> -> <i1>
    llhd.drv %498, %false after %0 : i1
    %499 = llhd.sig.extract %or_tree from %c-28_i6 : <i63> -> <i1>
    %500 = comb.extract %oh_i from 5 : (i17) -> i1
    llhd.drv %499, %500 after %0 : i1
    %501 = llhd.sig.extract %and_tree from %c-28_i6 : <i63> -> <i1>
    llhd.drv %501, %500 after %0 : i1
    %502 = llhd.sig.extract %err_tree from %c-28_i6 : <i63> -> <i1>
    llhd.drv %502, %false after %0 : i1
    %503 = llhd.sig.extract %or_tree from %c-27_i6 : <i63> -> <i1>
    %504 = comb.extract %oh_i from 6 : (i17) -> i1
    llhd.drv %503, %504 after %0 : i1
    %505 = llhd.sig.extract %and_tree from %c-27_i6 : <i63> -> <i1>
    llhd.drv %505, %504 after %0 : i1
    %506 = llhd.sig.extract %err_tree from %c-27_i6 : <i63> -> <i1>
    llhd.drv %506, %false after %0 : i1
    %507 = llhd.sig.extract %or_tree from %c-26_i6 : <i63> -> <i1>
    %508 = comb.extract %oh_i from 7 : (i17) -> i1
    llhd.drv %507, %508 after %0 : i1
    %509 = llhd.sig.extract %and_tree from %c-26_i6 : <i63> -> <i1>
    llhd.drv %509, %508 after %0 : i1
    %510 = llhd.sig.extract %err_tree from %c-26_i6 : <i63> -> <i1>
    llhd.drv %510, %false after %0 : i1
    %511 = llhd.sig.extract %or_tree from %c-25_i6 : <i63> -> <i1>
    %512 = comb.extract %oh_i from 8 : (i17) -> i1
    llhd.drv %511, %512 after %0 : i1
    %513 = llhd.sig.extract %and_tree from %c-25_i6 : <i63> -> <i1>
    llhd.drv %513, %512 after %0 : i1
    %514 = llhd.sig.extract %err_tree from %c-25_i6 : <i63> -> <i1>
    llhd.drv %514, %false after %0 : i1
    %515 = llhd.sig.extract %or_tree from %c-24_i6 : <i63> -> <i1>
    %516 = comb.extract %oh_i from 9 : (i17) -> i1
    llhd.drv %515, %516 after %0 : i1
    %517 = llhd.sig.extract %and_tree from %c-24_i6 : <i63> -> <i1>
    llhd.drv %517, %516 after %0 : i1
    %518 = llhd.sig.extract %err_tree from %c-24_i6 : <i63> -> <i1>
    llhd.drv %518, %false after %0 : i1
    %519 = llhd.sig.extract %or_tree from %c-23_i6 : <i63> -> <i1>
    %520 = comb.extract %oh_i from 10 : (i17) -> i1
    llhd.drv %519, %520 after %0 : i1
    %521 = llhd.sig.extract %and_tree from %c-23_i6 : <i63> -> <i1>
    llhd.drv %521, %520 after %0 : i1
    %522 = llhd.sig.extract %err_tree from %c-23_i6 : <i63> -> <i1>
    llhd.drv %522, %false after %0 : i1
    %523 = llhd.sig.extract %or_tree from %c-22_i6 : <i63> -> <i1>
    %524 = comb.extract %oh_i from 11 : (i17) -> i1
    llhd.drv %523, %524 after %0 : i1
    %525 = llhd.sig.extract %and_tree from %c-22_i6 : <i63> -> <i1>
    llhd.drv %525, %524 after %0 : i1
    %526 = llhd.sig.extract %err_tree from %c-22_i6 : <i63> -> <i1>
    llhd.drv %526, %false after %0 : i1
    %527 = llhd.sig.extract %or_tree from %c-21_i6 : <i63> -> <i1>
    %528 = comb.extract %oh_i from 12 : (i17) -> i1
    llhd.drv %527, %528 after %0 : i1
    %529 = llhd.sig.extract %and_tree from %c-21_i6 : <i63> -> <i1>
    llhd.drv %529, %528 after %0 : i1
    %530 = llhd.sig.extract %err_tree from %c-21_i6 : <i63> -> <i1>
    llhd.drv %530, %false after %0 : i1
    %531 = llhd.sig.extract %or_tree from %c-20_i6 : <i63> -> <i1>
    %532 = comb.extract %oh_i from 13 : (i17) -> i1
    llhd.drv %531, %532 after %0 : i1
    %533 = llhd.sig.extract %and_tree from %c-20_i6 : <i63> -> <i1>
    llhd.drv %533, %532 after %0 : i1
    %534 = llhd.sig.extract %err_tree from %c-20_i6 : <i63> -> <i1>
    llhd.drv %534, %false after %0 : i1
    %535 = llhd.sig.extract %or_tree from %c-19_i6 : <i63> -> <i1>
    %536 = comb.extract %oh_i from 14 : (i17) -> i1
    llhd.drv %535, %536 after %0 : i1
    %537 = llhd.sig.extract %and_tree from %c-19_i6 : <i63> -> <i1>
    llhd.drv %537, %536 after %0 : i1
    %538 = llhd.sig.extract %err_tree from %c-19_i6 : <i63> -> <i1>
    llhd.drv %538, %false after %0 : i1
    %539 = llhd.sig.extract %or_tree from %c-18_i6 : <i63> -> <i1>
    %540 = comb.extract %oh_i from 15 : (i17) -> i1
    llhd.drv %539, %540 after %0 : i1
    %541 = llhd.sig.extract %and_tree from %c-18_i6 : <i63> -> <i1>
    llhd.drv %541, %540 after %0 : i1
    %542 = llhd.sig.extract %err_tree from %c-18_i6 : <i63> -> <i1>
    llhd.drv %542, %false after %0 : i1
    %543 = llhd.sig.extract %or_tree from %c-17_i6 : <i63> -> <i1>
    %544 = comb.extract %oh_i from 16 : (i17) -> i1
    llhd.drv %543, %544 after %0 : i1
    %545 = llhd.sig.extract %and_tree from %c-17_i6 : <i63> -> <i1>
    llhd.drv %545, %544 after %0 : i1
    %546 = llhd.sig.extract %err_tree from %c-17_i6 : <i63> -> <i1>
    llhd.drv %546, %false after %0 : i1
    %547 = llhd.sig.extract %or_tree from %c-16_i6 : <i63> -> <i1>
    llhd.drv %547, %false after %0 : i1
    %548 = llhd.sig.extract %and_tree from %c-16_i6 : <i63> -> <i1>
    llhd.drv %548, %false after %0 : i1
    %549 = llhd.sig.extract %err_tree from %c-16_i6 : <i63> -> <i1>
    llhd.drv %549, %false after %0 : i1
    %550 = llhd.sig.extract %or_tree from %c-15_i6 : <i63> -> <i1>
    llhd.drv %550, %false after %0 : i1
    %551 = llhd.sig.extract %and_tree from %c-15_i6 : <i63> -> <i1>
    llhd.drv %551, %false after %0 : i1
    %552 = llhd.sig.extract %err_tree from %c-15_i6 : <i63> -> <i1>
    llhd.drv %552, %false after %0 : i1
    %553 = llhd.sig.extract %or_tree from %c-14_i6 : <i63> -> <i1>
    llhd.drv %553, %false after %0 : i1
    %554 = llhd.sig.extract %and_tree from %c-14_i6 : <i63> -> <i1>
    llhd.drv %554, %false after %0 : i1
    %555 = llhd.sig.extract %err_tree from %c-14_i6 : <i63> -> <i1>
    llhd.drv %555, %false after %0 : i1
    %556 = llhd.sig.extract %or_tree from %c-13_i6 : <i63> -> <i1>
    llhd.drv %556, %false after %0 : i1
    %557 = llhd.sig.extract %and_tree from %c-13_i6 : <i63> -> <i1>
    llhd.drv %557, %false after %0 : i1
    %558 = llhd.sig.extract %err_tree from %c-13_i6 : <i63> -> <i1>
    llhd.drv %558, %false after %0 : i1
    %559 = llhd.sig.extract %or_tree from %c-12_i6 : <i63> -> <i1>
    llhd.drv %559, %false after %0 : i1
    %560 = llhd.sig.extract %and_tree from %c-12_i6 : <i63> -> <i1>
    llhd.drv %560, %false after %0 : i1
    %561 = llhd.sig.extract %err_tree from %c-12_i6 : <i63> -> <i1>
    llhd.drv %561, %false after %0 : i1
    %562 = llhd.sig.extract %or_tree from %c-11_i6 : <i63> -> <i1>
    llhd.drv %562, %false after %0 : i1
    %563 = llhd.sig.extract %and_tree from %c-11_i6 : <i63> -> <i1>
    llhd.drv %563, %false after %0 : i1
    %564 = llhd.sig.extract %err_tree from %c-11_i6 : <i63> -> <i1>
    llhd.drv %564, %false after %0 : i1
    %565 = llhd.sig.extract %or_tree from %c-10_i6 : <i63> -> <i1>
    llhd.drv %565, %false after %0 : i1
    %566 = llhd.sig.extract %and_tree from %c-10_i6 : <i63> -> <i1>
    llhd.drv %566, %false after %0 : i1
    %567 = llhd.sig.extract %err_tree from %c-10_i6 : <i63> -> <i1>
    llhd.drv %567, %false after %0 : i1
    %568 = llhd.sig.extract %or_tree from %c-9_i6 : <i63> -> <i1>
    llhd.drv %568, %false after %0 : i1
    %569 = llhd.sig.extract %and_tree from %c-9_i6 : <i63> -> <i1>
    llhd.drv %569, %false after %0 : i1
    %570 = llhd.sig.extract %err_tree from %c-9_i6 : <i63> -> <i1>
    llhd.drv %570, %false after %0 : i1
    %571 = llhd.sig.extract %or_tree from %c-8_i6 : <i63> -> <i1>
    llhd.drv %571, %false after %0 : i1
    %572 = llhd.sig.extract %and_tree from %c-8_i6 : <i63> -> <i1>
    llhd.drv %572, %false after %0 : i1
    %573 = llhd.sig.extract %err_tree from %c-8_i6 : <i63> -> <i1>
    llhd.drv %573, %false after %0 : i1
    %574 = llhd.sig.extract %or_tree from %c-7_i6 : <i63> -> <i1>
    llhd.drv %574, %false after %0 : i1
    %575 = llhd.sig.extract %and_tree from %c-7_i6 : <i63> -> <i1>
    llhd.drv %575, %false after %0 : i1
    %576 = llhd.sig.extract %err_tree from %c-7_i6 : <i63> -> <i1>
    llhd.drv %576, %false after %0 : i1
    %577 = llhd.sig.extract %or_tree from %c-6_i6 : <i63> -> <i1>
    llhd.drv %577, %false after %0 : i1
    %578 = llhd.sig.extract %and_tree from %c-6_i6 : <i63> -> <i1>
    llhd.drv %578, %false after %0 : i1
    %579 = llhd.sig.extract %err_tree from %c-6_i6 : <i63> -> <i1>
    llhd.drv %579, %false after %0 : i1
    %580 = llhd.sig.extract %or_tree from %c-5_i6 : <i63> -> <i1>
    llhd.drv %580, %false after %0 : i1
    %581 = llhd.sig.extract %and_tree from %c-5_i6 : <i63> -> <i1>
    llhd.drv %581, %false after %0 : i1
    %582 = llhd.sig.extract %err_tree from %c-5_i6 : <i63> -> <i1>
    llhd.drv %582, %false after %0 : i1
    %583 = llhd.sig.extract %or_tree from %c-4_i6 : <i63> -> <i1>
    llhd.drv %583, %false after %0 : i1
    %584 = llhd.sig.extract %and_tree from %c-4_i6 : <i63> -> <i1>
    llhd.drv %584, %false after %0 : i1
    %585 = llhd.sig.extract %err_tree from %c-4_i6 : <i63> -> <i1>
    llhd.drv %585, %false after %0 : i1
    %586 = llhd.sig.extract %or_tree from %c-3_i6 : <i63> -> <i1>
    llhd.drv %586, %false after %0 : i1
    %587 = llhd.sig.extract %and_tree from %c-3_i6 : <i63> -> <i1>
    llhd.drv %587, %false after %0 : i1
    %588 = llhd.sig.extract %err_tree from %c-3_i6 : <i63> -> <i1>
    llhd.drv %588, %false after %0 : i1
    %589 = llhd.sig.extract %or_tree from %c-2_i6 : <i63> -> <i1>
    llhd.drv %589, %false after %0 : i1
    %590 = llhd.sig.extract %and_tree from %c-2_i6 : <i63> -> <i1>
    llhd.drv %590, %false after %0 : i1
    %591 = llhd.sig.extract %err_tree from %c-2_i6 : <i63> -> <i1>
    llhd.drv %591, %false after %0 : i1
    %592 = comb.or %593, %596 : i1
    %593 = comb.extract %17 from 0 {sv.namehint = "oh0_err"} : (i63) -> i1
    %594 = comb.xor %en_i, %true : i1
    %595 = comb.extract %2 from 0 : (i63) -> i1
    %596 = comb.and %594, %595 {sv.namehint = "enable_err"} : i1
    hw.output %592 : i1
  }
  hw.module private @prim_pulse_sync(in %clk_src_i : i1, in %rst_src_ni : i1, in %src_pulse_i : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, out dst_pulse_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %clk_src_i_0 = llhd.sig name "clk_src_i" %false : i1
    %2 = llhd.prb %clk_src_i_0 : i1
    %rst_src_ni_1 = llhd.sig name "rst_src_ni" %false : i1
    %3 = llhd.prb %rst_src_ni_1 : i1
    %src_pulse_i_2 = llhd.sig name "src_pulse_i" %false : i1
    %clk_dst_i_3 = llhd.sig name "clk_dst_i" %false : i1
    %4 = llhd.prb %clk_dst_i_3 : i1
    %rst_dst_ni_4 = llhd.sig name "rst_dst_ni" %false : i1
    %5 = llhd.prb %rst_dst_ni_4 : i1
    %src_level = llhd.sig %false : i1
    %dst_level = llhd.sig %false : i1
    %dst_level_q = llhd.sig %false : i1
    %6 = llhd.prb %src_level : i1
    %prim_flop_2sync.q_o = hw.instance "prim_flop_2sync" @prim_flop_2sync(clk_i: %4: i1, rst_ni: %5: i1, d_i: %6: i1) -> (q_o: i1)
    llhd.drv %dst_level, %prim_flop_2sync.q_o after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %10 = llhd.prb %clk_src_i_0 : i1
      %11 = llhd.prb %rst_src_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %12 = llhd.prb %clk_src_i_0 : i1
      %13 = comb.xor bin %10, %true : i1
      %14 = comb.and bin %13, %12 : i1
      %15 = llhd.prb %rst_src_ni_1 : i1
      %16 = comb.xor bin %15, %true : i1
      %17 = comb.and bin %11, %16 : i1
      %18 = comb.or bin %14, %17 : i1
      cf.cond_br %18, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %19 = llhd.prb %rst_src_ni_1 : i1
      %20 = comb.xor %19, %true : i1
      cf.cond_br %20, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %src_level, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %21 = llhd.prb %src_level : i1
      %22 = llhd.prb %src_pulse_i_2 : i1
      %23 = comb.xor %21, %22 : i1
      llhd.drv %src_level, %23 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %10 = llhd.prb %clk_dst_i_3 : i1
      %11 = llhd.prb %rst_dst_ni_4 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %12 = llhd.prb %clk_dst_i_3 : i1
      %13 = comb.xor bin %10, %true : i1
      %14 = comb.and bin %13, %12 : i1
      %15 = llhd.prb %rst_dst_ni_4 : i1
      %16 = comb.xor bin %15, %true : i1
      %17 = comb.and bin %11, %16 : i1
      %18 = comb.or bin %14, %17 : i1
      cf.cond_br %18, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %19 = llhd.prb %rst_dst_ni_4 : i1
      %20 = comb.xor %19, %true : i1
      cf.cond_br %20, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %dst_level_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %21 = llhd.prb %dst_level : i1
      llhd.drv %dst_level_q, %21 after %0 : i1
      cf.br ^bb1
    }
    %7 = llhd.prb %dst_level_q : i1
    %8 = llhd.prb %dst_level : i1
    %9 = comb.xor %7, %8 : i1
    llhd.drv %clk_src_i_0, %clk_src_i after %1 : i1
    llhd.drv %rst_src_ni_1, %rst_src_ni after %1 : i1
    llhd.drv %src_pulse_i_2, %src_pulse_i after %1 : i1
    llhd.drv %clk_dst_i_3, %clk_dst_i after %1 : i1
    llhd.drv %rst_dst_ni_4, %rst_dst_ni after %1 : i1
    hw.output %9 : i1
  }
  hw.module private @prim_reg_we_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i17, in %en_i : i1, out err_o : i1) {
    %c0_i5 = hw.constant 0 : i5
    %u_prim_buf.out_o = hw.instance "u_prim_buf" @prim_buf_17(in_i: %oh_i: i17) -> (out_o: i17) {sv.namehint = "oh_buf"}
    %u_prim_onehot_check.err_o = hw.instance "u_prim_onehot_check" @prim_onehot_check(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, oh_i: %u_prim_buf.out_o: i17, addr_i: %c0_i5: i5, en_i: %en_i: i1) -> (err_o: i1)
    hw.output %u_prim_onehot_check.err_o : i1
  }
  hw.module private @prim_sec_anchor_buf(in %in_i : i1, out out_o : i1) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf(in_i: %in_i: i1) -> (out_o: i1)
    hw.output %u_secure_anchor_buf.out_o : i1
  }
  hw.module private @prim_sec_anchor_buf_6(in %in_i : i2, out out_o : i2) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf_0(in_i: %in_i: i2) -> (out_o: i2)
    hw.output %u_secure_anchor_buf.out_o : i2
  }
  hw.module private @prim_sec_anchor_buf_28(in %in_i : i4, out out_o : i4) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf_33(in_i: %in_i: i4) -> (out_o: i4)
    hw.output %u_secure_anchor_buf.out_o : i4
  }
  hw.module private @prim_sec_anchor_flop(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_o : i2) {
    %u_secure_anchor_flop.q_o = hw.instance "u_secure_anchor_flop" @prim_flop_16(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %d_i: i2) -> (q_o: i2)
    hw.output %u_secure_anchor_flop.q_o : i2
  }
  hw.module private @prim_sec_anchor_flop_32(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
    %u_secure_anchor_flop.q_o = hw.instance "u_secure_anchor_flop" @prim_flop_30(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %d_i: i4) -> (q_o: i4)
    hw.output %u_secure_anchor_flop.q_o : i4
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
  hw.module private @prim_sparse_fsm_flop(in %clk_i : i1, in %rst_ni : i1, in %state_i : i10, out state_o : i10) {
    %u_state_flop.q_o = hw.instance "u_state_flop" @prim_flop_29(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %state_i: i10) -> (q_o: i10) {sv.namehint = "state_raw"}
    hw.output %u_state_flop.q_o : i10
  }
  hw.module private @prim_sparse_fsm_flop_13(in %clk_i : i1, in %rst_ni : i1, in %state_i : i12, out state_o : i12) {
    %u_state_flop.q_o = hw.instance "u_state_flop" @prim_flop_31(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %state_i: i12) -> (q_o: i12) {sv.namehint = "state_raw"}
    hw.output %u_state_flop.q_o : i12
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
  hw.module private @prim_subreg_arb_19(in %we : i1, in %wd : i1, in %de : i1, in %d : i1, in %q : i1, out wr_en : i1, out wr_data : i1) {
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
  hw.module private @prim_subreg_arb_20(in %we : i1, in %wd : i1, in %de : i1, in %d : i1, in %q : i1, out wr_en : i1, out wr_data : i1) {
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
  hw.module private @prim_subreg_arb_21(in %we : i1, in %wd : i1, in %de : i1, in %d : i1, in %q : i1, out wr_en : i1, out wr_data : i1) {
    hw.output %de, %d : i1, i1
  }
  hw.module private @prim_subreg_ext(in %re : i1, in %we : i1, in %wd : i1, in %d : i1, out qe : i1, out qre : i1, out q : i1, out ds : i1, out qs : i1) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i1, i1, i1
  }
  hw.module private @prim_subreg_ext_5(in %re : i1, in %we : i1, in %wd : i6, in %d : i6, out qe : i1, out qre : i1, out q : i6, out ds : i6, out qs : i6) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i6, i6, i6
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
  hw.module private @prim_subreg_1(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i1, in %de : i1, in %d : i1, out qe : i1, out q : i1, out ds : i1, out qs : i1) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_19(we: %we: i1, wd: %wd: i1, de: %de: i1, d: %d: i1, q: %4: i1) -> (wr_en: i1, wr_data: i1)
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
  hw.module private @prim_subreg_2(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i1, in %de : i1, in %d : i1, out qe : i1, out q : i1, out ds : i1, out qs : i1) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_19(we: %we: i1, wd: %wd: i1, de: %de: i1, d: %d: i1, q: %4: i1) -> (wr_en: i1, wr_data: i1)
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
  hw.module private @prim_subreg_3(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i1, in %de : i1, in %d : i1, out qe : i1, out q : i1, out ds : i1, out qs : i1) {
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
  hw.module private @prim_subreg_4(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i1, in %de : i1, in %d : i1, out qe : i1, out q : i1, out ds : i1, out qs : i1) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_21(we: %we: i1, wd: %wd: i1, de: %de: i1, d: %d: i1, q: %4: i1) -> (wr_en: i1, wr_data: i1)
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
    %gen_nrz_hs_protocol.src_fsm_ns = llhd.sig %false : i1
    %gen_nrz_hs_protocol.src_fsm_cs = llhd.sig %false : i1
    %gen_nrz_hs_protocol.dst_fsm_ns = llhd.sig %false : i1
    %gen_nrz_hs_protocol.dst_fsm_cs = llhd.sig %false : i1
    %gen_nrz_hs_protocol.src_req_d = llhd.sig %false : i1
    %gen_nrz_hs_protocol.src_req_q = llhd.sig %false : i1
    %gen_nrz_hs_protocol.src_ack = llhd.sig %false : i1
    %gen_nrz_hs_protocol.dst_ack_d = llhd.sig %false : i1
    %gen_nrz_hs_protocol.dst_ack_q = llhd.sig %false : i1
    %gen_nrz_hs_protocol.dst_req = llhd.sig %false : i1
    %gen_nrz_hs_protocol.src_handshake = llhd.sig %false : i1
    %gen_nrz_hs_protocol.dst_handshake = llhd.sig %false : i1
    %6 = llhd.prb %gen_nrz_hs_protocol.src_req_q : i1
    %gen_nrz_hs_protocol.req_sync.q_o = hw.instance "gen_nrz_hs_protocol.req_sync" @prim_flop_2sync(clk_i: %4: i1, rst_ni: %5: i1, d_i: %6: i1) -> (q_o: i1)
    llhd.drv %gen_nrz_hs_protocol.dst_req, %gen_nrz_hs_protocol.req_sync.q_o after %1 : i1
    %7 = llhd.prb %gen_nrz_hs_protocol.dst_ack_q : i1
    %gen_nrz_hs_protocol.ack_sync.q_o = hw.instance "gen_nrz_hs_protocol.ack_sync" @prim_flop_2sync(clk_i: %2: i1, rst_ni: %3: i1, d_i: %7: i1) -> (q_o: i1)
    llhd.drv %gen_nrz_hs_protocol.src_ack, %gen_nrz_hs_protocol.ack_sync.q_o after %1 : i1
    %8 = llhd.prb %src_req_i_4 : i1
    %9 = llhd.prb %src_ack_o : i1
    %10 = comb.and %8, %9 : i1
    llhd.drv %gen_nrz_hs_protocol.src_handshake, %10 after %1 : i1
    %11 = llhd.prb %dst_req_o : i1
    %12 = llhd.prb %dst_ack_i_5 : i1
    %13 = comb.and %11, %12 : i1
    llhd.drv %gen_nrz_hs_protocol.dst_handshake, %13 after %1 : i1
    %14 = llhd.prb %gen_nrz_hs_protocol.src_fsm_cs : i1
    %15 = llhd.prb %gen_nrz_hs_protocol.src_fsm_ns : i1
    %16 = llhd.prb %gen_nrz_hs_protocol.src_req_d : i1
    %17 = llhd.prb %gen_nrz_hs_protocol.src_ack : i1
    %18 = llhd.prb %gen_nrz_hs_protocol.src_handshake : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      %24 = llhd.prb %gen_nrz_hs_protocol.src_fsm_cs : i1
      llhd.drv %gen_nrz_hs_protocol.src_fsm_ns, %24 after %1 : i1
      %25 = llhd.prb %gen_nrz_hs_protocol.src_req_q : i1
      llhd.drv %gen_nrz_hs_protocol.src_req_d, %25 after %1 : i1
      llhd.drv %src_ack_o, %false after %1 : i1
      %26 = llhd.prb %gen_nrz_hs_protocol.src_fsm_cs : i1
      %27 = comb.icmp ceq %26, %false : i1
      cf.cond_br %27, ^bb2, ^bb4
    ^bb2:  // pred: ^bb1
      %28 = llhd.prb %src_req_i_4 : i1
      llhd.drv %gen_nrz_hs_protocol.src_req_d, %28 after %1 : i1
      %29 = llhd.prb %gen_nrz_hs_protocol.src_ack : i1
      llhd.drv %src_ack_o, %29 after %1 : i1
      %30 = llhd.prb %gen_nrz_hs_protocol.src_handshake : i1
      cf.cond_br %30, ^bb3, ^bb6
    ^bb3:  // pred: ^bb2
      llhd.drv %gen_nrz_hs_protocol.src_fsm_ns, %true after %1 : i1
      cf.br ^bb6
    ^bb4:  // pred: ^bb1
      %31 = llhd.prb %src_req_i_4 : i1
      %32 = comb.xor %31, %true : i1
      llhd.drv %gen_nrz_hs_protocol.src_req_d, %32 after %1 : i1
      %33 = llhd.prb %gen_nrz_hs_protocol.src_ack : i1
      %34 = comb.xor %33, %true : i1
      llhd.drv %src_ack_o, %34 after %1 : i1
      %35 = llhd.prb %gen_nrz_hs_protocol.src_handshake : i1
      cf.cond_br %35, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      llhd.drv %gen_nrz_hs_protocol.src_fsm_ns, %false after %1 : i1
      cf.br ^bb6
    ^bb6:  // 4 preds: ^bb2, ^bb3, ^bb4, ^bb5
      llhd.wait (%14, %15, %6, %16, %9, %8, %17, %18 : i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    %19 = llhd.prb %gen_nrz_hs_protocol.dst_fsm_cs : i1
    %20 = llhd.prb %gen_nrz_hs_protocol.dst_fsm_ns : i1
    %21 = llhd.prb %gen_nrz_hs_protocol.dst_ack_d : i1
    %22 = llhd.prb %gen_nrz_hs_protocol.dst_req : i1
    %23 = llhd.prb %gen_nrz_hs_protocol.dst_handshake : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      %24 = llhd.prb %gen_nrz_hs_protocol.dst_fsm_cs : i1
      llhd.drv %gen_nrz_hs_protocol.dst_fsm_ns, %24 after %1 : i1
      llhd.drv %dst_req_o, %false after %1 : i1
      %25 = llhd.prb %gen_nrz_hs_protocol.dst_ack_q : i1
      llhd.drv %gen_nrz_hs_protocol.dst_ack_d, %25 after %1 : i1
      %26 = llhd.prb %gen_nrz_hs_protocol.dst_fsm_cs : i1
      %27 = comb.icmp ceq %26, %false : i1
      cf.cond_br %27, ^bb2, ^bb4
    ^bb2:  // pred: ^bb1
      %28 = llhd.prb %gen_nrz_hs_protocol.dst_req : i1
      llhd.drv %dst_req_o, %28 after %1 : i1
      %29 = llhd.prb %dst_ack_i_5 : i1
      llhd.drv %gen_nrz_hs_protocol.dst_ack_d, %29 after %1 : i1
      %30 = llhd.prb %gen_nrz_hs_protocol.dst_handshake : i1
      cf.cond_br %30, ^bb3, ^bb6
    ^bb3:  // pred: ^bb2
      llhd.drv %gen_nrz_hs_protocol.dst_fsm_ns, %true after %1 : i1
      cf.br ^bb6
    ^bb4:  // pred: ^bb1
      %31 = llhd.prb %gen_nrz_hs_protocol.dst_req : i1
      %32 = comb.xor %31, %true : i1
      llhd.drv %dst_req_o, %32 after %1 : i1
      %33 = llhd.prb %dst_ack_i_5 : i1
      %34 = comb.xor %33, %true : i1
      llhd.drv %gen_nrz_hs_protocol.dst_ack_d, %34 after %1 : i1
      %35 = llhd.prb %gen_nrz_hs_protocol.dst_handshake : i1
      cf.cond_br %35, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      llhd.drv %gen_nrz_hs_protocol.dst_fsm_ns, %false after %1 : i1
      cf.br ^bb6
    ^bb6:  // 4 preds: ^bb2, ^bb3, ^bb4, ^bb5
      llhd.wait (%19, %20, %11, %7, %21, %22, %12, %23 : i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %24 = llhd.prb %clk_src_i_0 : i1
      %25 = llhd.prb %rst_src_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %26 = llhd.prb %clk_src_i_0 : i1
      %27 = comb.xor bin %24, %true : i1
      %28 = comb.and bin %27, %26 : i1
      %29 = llhd.prb %rst_src_ni_1 : i1
      %30 = comb.xor bin %29, %true : i1
      %31 = comb.and bin %25, %30 : i1
      %32 = comb.or bin %28, %31 : i1
      cf.cond_br %32, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %33 = llhd.prb %rst_src_ni_1 : i1
      %34 = comb.xor %33, %true : i1
      cf.cond_br %34, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_nrz_hs_protocol.src_fsm_cs, %false after %0 : i1
      llhd.drv %gen_nrz_hs_protocol.src_req_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %35 = llhd.prb %gen_nrz_hs_protocol.src_fsm_ns : i1
      llhd.drv %gen_nrz_hs_protocol.src_fsm_cs, %35 after %0 : i1
      %36 = llhd.prb %gen_nrz_hs_protocol.src_req_d : i1
      llhd.drv %gen_nrz_hs_protocol.src_req_q, %36 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %24 = llhd.prb %clk_dst_i_2 : i1
      %25 = llhd.prb %rst_dst_ni_3 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %26 = llhd.prb %clk_dst_i_2 : i1
      %27 = comb.xor bin %24, %true : i1
      %28 = comb.and bin %27, %26 : i1
      %29 = llhd.prb %rst_dst_ni_3 : i1
      %30 = comb.xor bin %29, %true : i1
      %31 = comb.and bin %25, %30 : i1
      %32 = comb.or bin %28, %31 : i1
      cf.cond_br %32, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %33 = llhd.prb %rst_dst_ni_3 : i1
      %34 = comb.xor %33, %true : i1
      cf.cond_br %34, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_nrz_hs_protocol.dst_fsm_cs, %false after %0 : i1
      llhd.drv %gen_nrz_hs_protocol.dst_ack_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %35 = llhd.prb %gen_nrz_hs_protocol.dst_fsm_ns : i1
      llhd.drv %gen_nrz_hs_protocol.dst_fsm_cs, %35 after %0 : i1
      %36 = llhd.prb %gen_nrz_hs_protocol.dst_ack_d : i1
      llhd.drv %gen_nrz_hs_protocol.dst_ack_q, %36 after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_src_i_0, %clk_src_i after %1 : i1
    llhd.drv %rst_src_ni_1, %rst_src_ni after %1 : i1
    llhd.drv %clk_dst_i_2, %clk_dst_i after %1 : i1
    llhd.drv %rst_dst_ni_3, %rst_dst_ni after %1 : i1
    llhd.drv %src_req_i_4, %src_req_i after %1 : i1
    llhd.drv %dst_ack_i_5, %dst_ack_i after %1 : i1
    hw.output %9, %11 : i1, i1
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
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen_18(tl_i: %32: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
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
  hw.module private @tlul_rsp_intg_gen_18(in %tl_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) {
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
  hw.module private @prim_mubi4_sync(in %clk_i : i1, in %rst_ni : i1, in %mubi_i : i4, out mubi_o : !hw.array<1xi4>) {
    %c0_i0 = hw.constant 0 : i0
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %c0_i2 = hw.constant 0 : i2
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %c-7_i4 = hw.constant -7 : i4
    %1 = hw.aggregate_constant [0 : i4] : !hw.array<1xi4>
    %mubi_o = llhd.sig %1 : !hw.array<1xi4>
    %mubi = llhd.sig %c0_i4 : i4
    %gen_flops.gen_stable_chks.mubi_q = llhd.sig %c0_i4 : i4
    %gen_flops.gen_stable_chks.reset_value = llhd.sig %c0_i4 : i4
    %gen_buffs_0.mubi_out = llhd.sig %c0_i4 : i4
    %gen_flops.u_prim_flop_2sync.q_o = hw.instance "gen_flops.u_prim_flop_2sync" @prim_flop_2sync_26(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %mubi_i: i4) -> (q_o: i4) {sv.namehint = "gen_flops.mubi_sync"}
    %gen_flops.gen_stable_chks.u_prim_flop_3rd_stage.q_o = hw.instance "gen_flops.gen_stable_chks.u_prim_flop_3rd_stage" @prim_flop_27(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %gen_flops.u_prim_flop_2sync.q_o: i4) -> (q_o: i4)
    llhd.drv %gen_flops.gen_stable_chks.mubi_q, %gen_flops.gen_stable_chks.u_prim_flop_3rd_stage.q_o after %0 : i4
    %2 = llhd.prb %gen_flops.gen_stable_chks.mubi_q : i4
    %gen_flops.gen_stable_chks.u_mubi_xor.out_o = hw.instance "gen_flops.gen_stable_chks.u_mubi_xor" @prim_xor2(in0_i: %gen_flops.u_prim_flop_2sync.q_o: i4, in1_i: %2: i4) -> (out_o: i4) {sv.namehint = "gen_flops.gen_stable_chks.sig_unstable"}
    %gen_flops.gen_stable_chks.gen_bufs_muxes_0.u_sig_unstable_buf.out_o = hw.instance "gen_flops.gen_stable_chks.gen_bufs_muxes_0.u_sig_unstable_buf" @prim_sec_anchor_buf_28(in_i: %gen_flops.gen_stable_chks.u_mubi_xor.out_o: i4) -> (out_o: i4) {sv.namehint = "gen_flops.gen_stable_chks.gen_bufs_muxes_0.sig_unstable_buf"}
    %gen_flops.gen_stable_chks.gen_bufs_muxes_1.u_sig_unstable_buf.out_o = hw.instance "gen_flops.gen_stable_chks.gen_bufs_muxes_1.u_sig_unstable_buf" @prim_sec_anchor_buf_28(in_i: %gen_flops.gen_stable_chks.u_mubi_xor.out_o: i4) -> (out_o: i4) {sv.namehint = "gen_flops.gen_stable_chks.gen_bufs_muxes_1.sig_unstable_buf"}
    %gen_flops.gen_stable_chks.gen_bufs_muxes_2.u_sig_unstable_buf.out_o = hw.instance "gen_flops.gen_stable_chks.gen_bufs_muxes_2.u_sig_unstable_buf" @prim_sec_anchor_buf_28(in_i: %gen_flops.gen_stable_chks.u_mubi_xor.out_o: i4) -> (out_o: i4) {sv.namehint = "gen_flops.gen_stable_chks.gen_bufs_muxes_2.sig_unstable_buf"}
    %gen_flops.gen_stable_chks.gen_bufs_muxes_3.u_sig_unstable_buf.out_o = hw.instance "gen_flops.gen_stable_chks.gen_bufs_muxes_3.u_sig_unstable_buf" @prim_sec_anchor_buf_28(in_i: %gen_flops.gen_stable_chks.u_mubi_xor.out_o: i4) -> (out_o: i4) {sv.namehint = "gen_flops.gen_stable_chks.gen_bufs_muxes_3.sig_unstable_buf"}
    %3 = llhd.prb %mubi : i4
    %4 = comb.extract %3 from 0 : (i4) -> i1
    %5 = llhd.sig.extract %gen_buffs_0.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_0.u_prim_buf" @prim_buf(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %5, %gen_buffs_0.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %6 = comb.extract %3 from 1 : (i4) -> i1
    %7 = llhd.sig.extract %gen_buffs_0.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_1.u_prim_buf" @prim_buf(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %7, %gen_buffs_0.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %8 = comb.extract %3 from 2 : (i4) -> i1
    %9 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_2.u_prim_buf" @prim_buf(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %9, %gen_buffs_0.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %10 = comb.extract %3 from 3 : (i4) -> i1
    %11 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_3.u_prim_buf" @prim_buf(in_i: %10: i1) -> (out_o: i1)
    llhd.drv %11, %gen_buffs_0.gen_bits_3.u_prim_buf.out_o after %0 : i1
    llhd.drv %gen_flops.gen_stable_chks.reset_value, %c-7_i4 after %0 : i4
    %12 = llhd.sig.extract %mubi from %c0_i2 : <i4> -> <i1>
    %13 = comb.icmp ne %gen_flops.gen_stable_chks.gen_bufs_muxes_0.u_sig_unstable_buf.out_o, %c0_i4 : i4
    %14 = llhd.prb %gen_flops.gen_stable_chks.reset_value : i4
    %15 = comb.extract %14 from 0 : (i4) -> i1
    %16 = comb.extract %2 from 0 : (i4) -> i1
    %17 = comb.mux %13, %15, %16 : i1
    llhd.drv %12, %17 after %0 : i1
    %18 = llhd.sig.extract %mubi from %c1_i2 : <i4> -> <i1>
    %19 = comb.icmp ne %gen_flops.gen_stable_chks.gen_bufs_muxes_1.u_sig_unstable_buf.out_o, %c0_i4 : i4
    %20 = comb.extract %14 from 1 : (i4) -> i1
    %21 = comb.extract %2 from 1 : (i4) -> i1
    %22 = comb.mux %19, %20, %21 : i1
    llhd.drv %18, %22 after %0 : i1
    %23 = llhd.sig.extract %mubi from %c-2_i2 : <i4> -> <i1>
    %24 = comb.icmp ne %gen_flops.gen_stable_chks.gen_bufs_muxes_2.u_sig_unstable_buf.out_o, %c0_i4 : i4
    %25 = comb.extract %14 from 2 : (i4) -> i1
    %26 = comb.extract %2 from 2 : (i4) -> i1
    %27 = comb.mux %24, %25, %26 : i1
    llhd.drv %23, %27 after %0 : i1
    %28 = llhd.sig.extract %mubi from %c-1_i2 : <i4> -> <i1>
    %29 = comb.icmp ne %gen_flops.gen_stable_chks.gen_bufs_muxes_3.u_sig_unstable_buf.out_o, %c0_i4 : i4
    %30 = comb.extract %14 from 3 : (i4) -> i1
    %31 = comb.extract %2 from 3 : (i4) -> i1
    %32 = comb.mux %29, %30, %31 : i1
    llhd.drv %28, %32 after %0 : i1
    %33 = llhd.sig.array_get %mubi_o[%c0_i0] : <!hw.array<1xi4>>
    %34 = llhd.prb %gen_buffs_0.mubi_out : i4
    llhd.drv %33, %34 after %0 : i4
    %35 = llhd.prb %mubi_o : !hw.array<1xi4>
    hw.output %35 : !hw.array<1xi4>
  }
  func.func private @"lc_ctrl_pkg::lc_tx_test_true_strict"(%arg0: i4) -> i1 {
    %c5_i4 = hw.constant 5 : i4
    %0 = comb.icmp eq %arg0, %c5_i4 : i4
    return %0 : i1
  }
  func.func private @"lc_ctrl_pkg::lc_tx_test_false_loose"(%arg0: i4) -> i1 {
    %c5_i4 = hw.constant 5 : i4
    %0 = comb.icmp ne %arg0, %c5_i4 : i4
    return %0 : i1
  }
  func.func private @"lc_ctrl_pkg::lc_tx_and"(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
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
    %18 = comb.and %15, %17 : i1
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
    %28 = comb.or %25, %27 : i1
    llhd.drv %23, %28 after %0 : i1
    cf.br ^bb5
  ^bb5:  // 2 preds: ^bb3, ^bb4
    %29 = comb.add %1, %c1_i32 : i32
    cf.br ^bb1(%29 : i32)
  ^bb6:  // pred: ^bb1
    %30 = llhd.prb %out : i4
    return %30 : i4
  }
  func.func private @"lc_ctrl_pkg::lc_tx_and_hi"(%arg0: i4, %arg1: i4) -> i4 {
    %c5_i4 = hw.constant 5 : i4
    %0 = call @"lc_ctrl_pkg::lc_tx_and"(%arg0, %arg1, %c5_i4) : (i4, i4, i4) -> i4
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
    %gen_flops.u_prim_flop_2sync.q_o = hw.instance "gen_flops.u_prim_flop_2sync" @prim_flop_2sync_12(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %lc_en_i: i4) -> (q_o: i4) {sv.namehint = "lc_en"}
    %2 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 0 : (i4) -> i1
    %3 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %3, %gen_buffs_0.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %4 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 1 : (i4) -> i1
    %5 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %5, %gen_buffs_0.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %6 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 2 : (i4) -> i1
    %7 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %7, %gen_buffs_0.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %8 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 3 : (i4) -> i1
    %9 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %9, %gen_buffs_0.gen_bits_3.u_prim_buf.out_o after %0 : i1
    %10 = llhd.sig.array_get %lc_en_o[%c0_i0] : <!hw.array<1xi4>>
    %11 = llhd.prb %gen_buffs_0.lc_en_out : i4
    llhd.drv %10, %11 after %0 : i4
    %12 = llhd.prb %lc_en_o : !hw.array<1xi4>
    hw.output %12 : !hw.array<1xi4>
  }
  hw.module private @prim_lc_sender(in %clk_i : i1, in %rst_ni : i1, in %lc_en_i : i4, out lc_en_o : i4) {
    %gen_flops.u_prim_flop.q_o = hw.instance "gen_flops.u_prim_flop" @prim_sec_anchor_flop_32(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %lc_en_i: i4) -> (q_o: i4) {sv.namehint = "lc_en_out"}
    hw.output %gen_flops.u_prim_flop.q_o : i4
  }
  hw.module private @pwrmgr_cdc(in %clk_slow_i : i1, in %clk_i : i1, in %rst_slow_ni : i1, in %rst_ni : i1, in %slow_req_pwrup_i : i1, in %slow_ack_pwrdn_i : i1, in %slow_fsm_invalid_i : i1, in %slow_pwrup_cause_toggle_i : i1, in %slow_pwrup_cause_i : i2, out slow_wakeup_en_o : i6, out slow_reset_en_o : i2, out slow_main_pd_no : i1, out slow_main_clk_en_o : i1, out slow_io_clk_en_o : i1, out slow_usb_clk_en_lp_o : i1, out slow_usb_clk_en_active_o : i1, out slow_req_pwrdn_o : i1, out slow_ack_pwrup_o : i1, out slow_ast_o : !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>, out slow_peri_reqs_o : !hw.struct<wakeups: i6, rstreqs: i6>, in %slow_peri_reqs_masked_i : !hw.struct<wakeups: i6, rstreqs: i6>, out slow_clr_req_o : i1, in %slow_usb_ip_clk_en_i : i1, out slow_usb_ip_clk_status_o : i1, in %req_pwrdn_i : i1, in %ack_pwrup_i : i1, in %cfg_cdc_sync_i : i1, in %wakeup_en_i : i6, in %reset_en_i : i2, in %main_pd_ni : i1, in %main_clk_en_i : i1, in %io_clk_en_i : i1, in %usb_clk_en_lp_i : i1, in %usb_clk_en_active_i : i1, out ack_pwrdn_o : i1, out fsm_invalid_o : i1, out req_pwrup_o : i1, out pwrup_cause_o : i2, out peri_reqs_o : !hw.struct<wakeups: i6, rstreqs: i6>, out cdc_sync_done_o : i1, in %clr_slow_req_i : i1, out usb_ip_clk_en_o : i1, in %usb_ip_clk_status_i : i1, in %peri_i : !hw.struct<wakeups: i6, rstreqs: i6>, in %nvm_i : !hw.struct<nvm_idle: i1>, out nvm_o : !hw.struct<nvm_idle: i1>, in %otp_i : !hw.struct<otp_done: i1, otp_idle: i1>, out otp_o : !hw.struct<otp_done: i1, otp_idle: i1>, in %ast_i : !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>, in %rom_ctrl_done_i : !hw.array<1xi4>, out rom_ctrl_done_o : !hw.array<1xi4>, in %core_sleeping_i : i1, out core_sleeping_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c0_i0 = hw.constant 0 : i0
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [0 : i4] : !hw.array<1xi4>
    %3 = hw.aggregate_constant [false] : !hw.struct<nvm_idle: i1>
    %4 = hw.aggregate_constant [false, false, false, false, false] : !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>
    %false = hw.constant false
    %true = hw.constant true
    %c0_i2 = hw.constant 0 : i2
    %c0_i6 = hw.constant 0 : i6
    %clk_slow_i_0 = llhd.sig name "clk_slow_i" %false : i1
    %5 = llhd.prb %clk_slow_i_0 : i1
    %clk_i_1 = llhd.sig name "clk_i" %false : i1
    %6 = llhd.prb %clk_i_1 : i1
    %rst_slow_ni_2 = llhd.sig name "rst_slow_ni" %false : i1
    %7 = llhd.prb %rst_slow_ni_2 : i1
    %rst_ni_3 = llhd.sig name "rst_ni" %false : i1
    %8 = llhd.prb %rst_ni_3 : i1
    %slow_pwrup_cause_i_4 = llhd.sig name "slow_pwrup_cause_i" %c0_i2 : i2
    %slow_wakeup_en_o = llhd.sig %c0_i6 : i6
    %slow_reset_en_o = llhd.sig %c0_i2 : i2
    %slow_main_pd_no = llhd.sig %false : i1
    %slow_main_clk_en_o = llhd.sig %false : i1
    %slow_io_clk_en_o = llhd.sig %false : i1
    %slow_usb_clk_en_lp_o = llhd.sig %false : i1
    %slow_usb_clk_en_active_o = llhd.sig %false : i1
    %slow_ast_o = llhd.sig %4 : !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>
    %wakeup_en_i_5 = llhd.sig name "wakeup_en_i" %c0_i6 : i6
    %reset_en_i_6 = llhd.sig name "reset_en_i" %c0_i2 : i2
    %main_pd_ni_7 = llhd.sig name "main_pd_ni" %false : i1
    %main_clk_en_i_8 = llhd.sig name "main_clk_en_i" %false : i1
    %io_clk_en_i_9 = llhd.sig name "io_clk_en_i" %false : i1
    %usb_clk_en_lp_i_10 = llhd.sig name "usb_clk_en_lp_i" %false : i1
    %usb_clk_en_active_i_11 = llhd.sig name "usb_clk_en_active_i" %false : i1
    %pwrup_cause_o = llhd.sig %c0_i2 : i2
    %nvm_o = llhd.sig %3 : !hw.struct<nvm_idle: i1>
    %rom_ctrl_done_o = llhd.sig %2 : !hw.array<1xi4>
    %slow_cdc_sync = llhd.sig %false : i1
    %slow_ast_q = llhd.sig %4 : !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>
    %slow_ast_q2 = llhd.sig %4 : !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>
    %pwrup_cause_toggle_q = llhd.sig %false : i1
    %pwrup_cause_toggle_q2 = llhd.sig %false : i1
    %pwrup_cause_chg = llhd.sig %false : i1
    %u_req_pwrdn_sync.q_o = hw.instance "u_req_pwrdn_sync" @prim_flop_2sync(clk_i: %5: i1, rst_ni: %7: i1, d_i: %req_pwrdn_i: i1) -> (q_o: i1)
    %u_ack_pwrup_sync.q_o = hw.instance "u_ack_pwrup_sync" @prim_flop_2sync(clk_i: %5: i1, rst_ni: %7: i1, d_i: %ack_pwrup_i: i1) -> (q_o: i1)
    %u_slow_cdc_sync.dst_pulse_o = hw.instance "u_slow_cdc_sync" @prim_pulse_sync(clk_src_i: %6: i1, rst_src_ni: %8: i1, src_pulse_i: %cfg_cdc_sync_i: i1, clk_dst_i: %5: i1, rst_dst_ni: %7: i1) -> (dst_pulse_o: i1)
    llhd.drv %slow_cdc_sync, %u_slow_cdc_sync.dst_pulse_o after %1 : i1
    %9 = hw.bitcast %peri_i : (!hw.struct<wakeups: i6, rstreqs: i6>) -> i12
    %u_slow_ext_req_sync.q_o = hw.instance "u_slow_ext_req_sync" @prim_flop_2sync_8(clk_i: %5: i1, rst_ni: %7: i1, d_i: %9: i12) -> (q_o: i12)
    %10 = hw.bitcast %u_slow_ext_req_sync.q_o : (i12) -> !hw.struct<wakeups: i6, rstreqs: i6>
    %u_ip_clk_status_sync.q_o = hw.instance "u_ip_clk_status_sync" @prim_flop_2sync(clk_i: %5: i1, rst_ni: %7: i1, d_i: %usb_ip_clk_status_i: i1) -> (q_o: i1)
    %11 = hw.bitcast %ast_i : (!hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>) -> i5
    %u_ast_sync.q_o = hw.instance "u_ast_sync" @prim_flop_2sync_9(clk_i: %5: i1, rst_ni: %7: i1, d_i: %11: i5) -> (q_o: i5)
    %12 = hw.bitcast %u_ast_sync.q_o : (i5) -> !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>
    llhd.drv %slow_ast_q, %12 after %1 : !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>
    %u_req_pwrup_sync.q_o = hw.instance "u_req_pwrup_sync" @prim_flop_2sync(clk_i: %6: i1, rst_ni: %8: i1, d_i: %slow_req_pwrup_i: i1) -> (q_o: i1)
    %u_ack_pwrdn_sync.q_o = hw.instance "u_ack_pwrdn_sync" @prim_flop_2sync(clk_i: %6: i1, rst_ni: %8: i1, d_i: %slow_ack_pwrdn_i: i1) -> (q_o: i1)
    %u_int_fsm_invalid_sync.q_o = hw.instance "u_int_fsm_invalid_sync" @prim_flop_2sync(clk_i: %6: i1, rst_ni: %8: i1, d_i: %slow_fsm_invalid_i: i1) -> (q_o: i1)
    %u_pwrup_chg_sync.q_o = hw.instance "u_pwrup_chg_sync" @prim_flop_2sync(clk_i: %6: i1, rst_ni: %8: i1, d_i: %slow_pwrup_cause_toggle_i: i1) -> (q_o: i1)
    llhd.drv %pwrup_cause_toggle_q, %u_pwrup_chg_sync.q_o after %1 : i1
    %u_ip_clk_en_sync.q_o = hw.instance "u_ip_clk_en_sync" @prim_flop_2sync(clk_i: %6: i1, rst_ni: %8: i1, d_i: %slow_usb_ip_clk_en_i: i1) -> (q_o: i1)
    %u_sleeping_sync.q_o = hw.instance "u_sleeping_sync" @prim_flop_2sync(clk_i: %6: i1, rst_ni: %8: i1, d_i: %core_sleeping_i: i1) -> (q_o: i1)
    %13 = llhd.prb %slow_cdc_sync : i1
    %u_scdc_sync.dst_pulse_o = hw.instance "u_scdc_sync" @prim_pulse_sync(clk_src_i: %5: i1, rst_src_ni: %7: i1, src_pulse_i: %13: i1, clk_dst_i: %6: i1, rst_dst_ni: %8: i1) -> (dst_pulse_o: i1)
    %14 = hw.bitcast %slow_peri_reqs_masked_i : (!hw.struct<wakeups: i6, rstreqs: i6>) -> i12
    %u_ext_req_sync.q_o = hw.instance "u_ext_req_sync" @prim_flop_2sync_8(clk_i: %6: i1, rst_ni: %8: i1, d_i: %14: i12) -> (q_o: i12)
    %15 = hw.bitcast %u_ext_req_sync.q_o : (i12) -> !hw.struct<wakeups: i6, rstreqs: i6>
    %nvm_idle = hw.struct_extract %nvm_i["nvm_idle"] : !hw.struct<nvm_idle: i1>
    %16 = llhd.sig.struct_extract %nvm_o["nvm_idle"] : <!hw.struct<nvm_idle: i1>>
    %u_sync_nvm_idle.q_o = hw.instance "u_sync_nvm_idle" @prim_flop_2sync_10(clk_i: %6: i1, rst_ni: %8: i1, d_i: %nvm_idle: i1) -> (q_o: i1)
    llhd.drv %16, %u_sync_nvm_idle.q_o after %1 : i1
    %17 = hw.bitcast %otp_i : (!hw.struct<otp_done: i1, otp_idle: i1>) -> i2
    %u_sync_otp.q_o = hw.instance "u_sync_otp" @prim_flop_2sync_11(clk_i: %6: i1, rst_ni: %8: i1, d_i: %17: i2) -> (q_o: i2)
    %18 = hw.bitcast %u_sync_otp.q_o : (i2) -> !hw.struct<otp_done: i1, otp_idle: i1>
    %19 = hw.array_get %rom_ctrl_done_i[%c0_i0] : !hw.array<1xi4>, i0
    %20 = llhd.sig.array_get %rom_ctrl_done_o[%c0_i0] : <!hw.array<1xi4>>
    %gen_rom_inputs_0.u_sync_rom_ctrl.mubi_o = hw.instance "gen_rom_inputs_0.u_sync_rom_ctrl" @prim_mubi4_sync(clk_i: %6: i1, rst_ni: %8: i1, mubi_i: %19: i4) -> (mubi_o: !hw.array<1xi4>)
    %21 = hw.bitcast %gen_rom_inputs_0.u_sync_rom_ctrl.mubi_o : (!hw.array<1xi4>) -> i4
    llhd.drv %20, %21 after %1 : i4
    %u_clr_req_sync.q_o = hw.instance "u_clr_req_sync" @prim_flop_2sync(clk_i: %5: i1, rst_ni: %7: i1, d_i: %clr_slow_req_i: i1) -> (q_o: i1)
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %36 = llhd.prb %clk_slow_i_0 : i1
      %37 = llhd.prb %rst_slow_ni_2 : i1
      llhd.wait (%5, %7 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %38 = llhd.prb %clk_slow_i_0 : i1
      %39 = comb.xor bin %36, %true : i1
      %40 = comb.and bin %39, %38 : i1
      %41 = llhd.prb %rst_slow_ni_2 : i1
      %42 = comb.xor bin %41, %true : i1
      %43 = comb.and bin %37, %42 : i1
      %44 = comb.or bin %40, %43 : i1
      cf.cond_br %44, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %45 = llhd.prb %rst_slow_ni_2 : i1
      %46 = comb.xor %45, %true : i1
      cf.cond_br %46, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %slow_ast_q2, %4 after %0 : !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %47 = llhd.prb %slow_ast_q : !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>
      llhd.drv %slow_ast_q2, %47 after %0 : !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %36 = llhd.prb %clk_slow_i_0 : i1
      %37 = llhd.prb %rst_slow_ni_2 : i1
      llhd.wait (%5, %7 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %38 = llhd.prb %clk_slow_i_0 : i1
      %39 = comb.xor bin %36, %true : i1
      %40 = comb.and bin %39, %38 : i1
      %41 = llhd.prb %rst_slow_ni_2 : i1
      %42 = comb.xor bin %41, %true : i1
      %43 = comb.and bin %37, %42 : i1
      %44 = comb.or bin %40, %43 : i1
      cf.cond_br %44, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %45 = llhd.prb %rst_slow_ni_2 : i1
      %46 = comb.xor %45, %true : i1
      cf.cond_br %46, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %slow_ast_o, %4 after %0 : !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %47 = llhd.prb %slow_ast_q2 : !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>
      %48 = llhd.prb %slow_ast_q : !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>
      %49 = hw.bitcast %47 : (!hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>) -> i5
      %50 = hw.bitcast %48 : (!hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>) -> i5
      %51 = comb.icmp eq %49, %50 : i5
      cf.cond_br %51, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %52 = llhd.prb %slow_ast_q2 : !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>
      llhd.drv %slow_ast_o, %52 after %0 : !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %36 = llhd.prb %clk_slow_i_0 : i1
      %37 = llhd.prb %rst_slow_ni_2 : i1
      llhd.wait (%5, %7 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %38 = llhd.prb %clk_slow_i_0 : i1
      %39 = comb.xor bin %36, %true : i1
      %40 = comb.and bin %39, %38 : i1
      %41 = llhd.prb %rst_slow_ni_2 : i1
      %42 = comb.xor bin %41, %true : i1
      %43 = comb.and bin %37, %42 : i1
      %44 = comb.or bin %40, %43 : i1
      cf.cond_br %44, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %45 = llhd.prb %rst_slow_ni_2 : i1
      %46 = comb.xor %45, %true : i1
      cf.cond_br %46, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %slow_wakeup_en_o, %c0_i6 after %0 : i6
      llhd.drv %slow_reset_en_o, %c0_i2 after %0 : i2
      llhd.drv %slow_main_pd_no, %true after %0 : i1
      llhd.drv %slow_main_clk_en_o, %false after %0 : i1
      llhd.drv %slow_io_clk_en_o, %false after %0 : i1
      llhd.drv %slow_usb_clk_en_lp_o, %false after %0 : i1
      llhd.drv %slow_usb_clk_en_active_o, %true after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %47 = llhd.prb %slow_cdc_sync : i1
      cf.cond_br %47, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %48 = llhd.prb %wakeup_en_i_5 : i6
      llhd.drv %slow_wakeup_en_o, %48 after %0 : i6
      %49 = llhd.prb %reset_en_i_6 : i2
      llhd.drv %slow_reset_en_o, %49 after %0 : i2
      %50 = llhd.prb %main_pd_ni_7 : i1
      llhd.drv %slow_main_pd_no, %50 after %0 : i1
      %51 = llhd.prb %main_clk_en_i_8 : i1
      llhd.drv %slow_main_clk_en_o, %51 after %0 : i1
      %52 = llhd.prb %io_clk_en_i_9 : i1
      llhd.drv %slow_io_clk_en_o, %52 after %0 : i1
      %53 = llhd.prb %usb_clk_en_lp_i_10 : i1
      llhd.drv %slow_usb_clk_en_lp_o, %53 after %0 : i1
      %54 = llhd.prb %usb_clk_en_active_i_11 : i1
      llhd.drv %slow_usb_clk_en_active_o, %54 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %36 = llhd.prb %clk_i_1 : i1
      %37 = llhd.prb %rst_ni_3 : i1
      llhd.wait (%6, %8 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %38 = llhd.prb %clk_i_1 : i1
      %39 = comb.xor bin %36, %true : i1
      %40 = comb.and bin %39, %38 : i1
      %41 = llhd.prb %rst_ni_3 : i1
      %42 = comb.xor bin %41, %true : i1
      %43 = comb.and bin %37, %42 : i1
      %44 = comb.or bin %40, %43 : i1
      cf.cond_br %44, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %45 = llhd.prb %rst_ni_3 : i1
      %46 = comb.xor %45, %true : i1
      cf.cond_br %46, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %pwrup_cause_toggle_q2, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %47 = llhd.prb %pwrup_cause_toggle_q : i1
      llhd.drv %pwrup_cause_toggle_q2, %47 after %0 : i1
      cf.br ^bb1
    }
    %22 = llhd.prb %pwrup_cause_toggle_q2 : i1
    %23 = llhd.prb %pwrup_cause_toggle_q : i1
    %24 = comb.xor %22, %23 : i1
    llhd.drv %pwrup_cause_chg, %24 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %36 = llhd.prb %clk_i_1 : i1
      %37 = llhd.prb %rst_ni_3 : i1
      llhd.wait (%6, %8 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %38 = llhd.prb %clk_i_1 : i1
      %39 = comb.xor bin %36, %true : i1
      %40 = comb.and bin %39, %38 : i1
      %41 = llhd.prb %rst_ni_3 : i1
      %42 = comb.xor bin %41, %true : i1
      %43 = comb.and bin %37, %42 : i1
      %44 = comb.or bin %40, %43 : i1
      cf.cond_br %44, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %45 = llhd.prb %rst_ni_3 : i1
      %46 = comb.xor %45, %true : i1
      cf.cond_br %46, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %pwrup_cause_o, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %47 = llhd.prb %pwrup_cause_chg : i1
      cf.cond_br %47, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %48 = llhd.prb %slow_pwrup_cause_i_4 : i2
      llhd.drv %pwrup_cause_o, %48 after %0 : i2
      cf.br ^bb1
    }
    llhd.drv %clk_slow_i_0, %clk_slow_i after %1 : i1
    llhd.drv %clk_i_1, %clk_i after %1 : i1
    llhd.drv %rst_slow_ni_2, %rst_slow_ni after %1 : i1
    llhd.drv %rst_ni_3, %rst_ni after %1 : i1
    llhd.drv %slow_pwrup_cause_i_4, %slow_pwrup_cause_i after %1 : i2
    %25 = llhd.prb %slow_wakeup_en_o : i6
    %26 = llhd.prb %slow_reset_en_o : i2
    %27 = llhd.prb %slow_main_pd_no : i1
    %28 = llhd.prb %slow_main_clk_en_o : i1
    %29 = llhd.prb %slow_io_clk_en_o : i1
    %30 = llhd.prb %slow_usb_clk_en_lp_o : i1
    %31 = llhd.prb %slow_usb_clk_en_active_o : i1
    %32 = llhd.prb %slow_ast_o : !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>
    llhd.drv %wakeup_en_i_5, %wakeup_en_i after %1 : i6
    llhd.drv %reset_en_i_6, %reset_en_i after %1 : i2
    llhd.drv %main_pd_ni_7, %main_pd_ni after %1 : i1
    llhd.drv %main_clk_en_i_8, %main_clk_en_i after %1 : i1
    llhd.drv %io_clk_en_i_9, %io_clk_en_i after %1 : i1
    llhd.drv %usb_clk_en_lp_i_10, %usb_clk_en_lp_i after %1 : i1
    llhd.drv %usb_clk_en_active_i_11, %usb_clk_en_active_i after %1 : i1
    %33 = llhd.prb %pwrup_cause_o : i2
    %34 = llhd.prb %nvm_o : !hw.struct<nvm_idle: i1>
    %35 = llhd.prb %rom_ctrl_done_o : !hw.array<1xi4>
    hw.output %25, %26, %27, %28, %29, %30, %31, %u_req_pwrdn_sync.q_o, %u_ack_pwrup_sync.q_o, %32, %10, %u_clr_req_sync.q_o, %u_ip_clk_status_sync.q_o, %u_ack_pwrdn_sync.q_o, %u_int_fsm_invalid_sync.q_o, %u_req_pwrup_sync.q_o, %33, %15, %u_scdc_sync.dst_pulse_o, %u_ip_clk_en_sync.q_o, %34, %18, %35, %u_sleeping_sync.q_o : i6, i2, i1, i1, i1, i1, i1, i1, i1, !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>, !hw.struct<wakeups: i6, rstreqs: i6>, i1, i1, i1, i1, i1, i2, !hw.struct<wakeups: i6, rstreqs: i6>, i1, i1, !hw.struct<nvm_idle: i1>, !hw.struct<otp_done: i1, otp_idle: i1>, !hw.array<1xi4>, i1
  }
  hw.module private @pwrmgr_fsm(in %clk_i : i1, in %rst_ni : i1, in %clk_slow_i : i1, in %rst_slow_ni : i1, in %req_pwrup_i : i1, in %pwrup_cause_i : i2, out ack_pwrup_o : i1, out req_pwrdn_o : i1, in %ack_pwrdn_i : i1, in %low_power_entry_i : i1, in %main_pd_ni : i1, in %reset_reqs_i : i6, in %fsm_invalid_i : i1, out clr_slow_req_o : i1, in %usb_ip_clk_en_i : i1, out usb_ip_clk_status_o : i1, out wkup_o : i1, out fall_through_o : i1, out abort_o : i1, out clr_hint_o : i1, out clr_cfg_lock_o : i1, out pwr_rst_o : !hw.struct<rst_lc_req: i2, rst_sys_req: i2, rstreqs: i5, reset_cause: i2>, in %pwr_rst_i : !hw.struct<rst_lc_src_n: i2, rst_sys_src_n: i2>, out ips_clk_en_o : !hw.struct<main_ip_clk_en: i1, io_ip_clk_en: i1, usb_ip_clk_en: i1>, in %clk_en_status_i : !hw.struct<main_status: i1, io_status: i1, usb_status: i1>, out otp_init_o : i1, in %otp_done_i : i1, in %otp_idle_i : i1, out lc_init_o : i1, in %lc_done_i : i1, in %lc_idle_i : i1, in %lc_dft_en_i : i4, in %lc_hw_debug_en_i : i4, in %nvm_idle_i : i1, in %rom_ctrl_done_i : i4, in %rom_ctrl_good_i : i4, out strap_o : i1, out strap_sampled_o : i1, out low_power_o : i1, out fetch_en_o : i4) {
    %c0_i31 = hw.constant 0 : i31
    %c-1_i3 = hw.constant -1 : i3
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i12 = hw.constant 0 : i12
    %c0_i4 = hw.constant 0 : i4
    %2 = hw.aggregate_constant [false, false, false] : !hw.struct<main_ip_clk_en: i1, io_ip_clk_en: i1, usb_ip_clk_en: i1>
    %3 = hw.aggregate_constant [0 : i2, 0 : i2] : !hw.struct<rst_lc_src_n: i2, rst_sys_src_n: i2>
    %4 = hw.aggregate_constant [0 : i2, 0 : i2, 0 : i5, 0 : i2] : !hw.struct<rst_lc_req: i2, rst_sys_req: i2, rstreqs: i5, reset_cause: i2>
    %c0_i6 = hw.constant 0 : i6
    %c-682_i12 = hw.constant -682 : i12
    %c-4_i12 = hw.constant -4 : i12
    %c1647_i12 = hw.constant 1647 : i12
    %c-375_i12 = hw.constant -375 : i12
    %c2_i32 = hw.constant 2 : i32
    %c1_i32 = hw.constant 1 : i32
    %c1423_i12 = hw.constant 1423 : i12
    %c-1671_i12 = hw.constant -1671 : i12
    %c1744_i12 = hw.constant 1744 : i12
    %c778_i12 = hw.constant 778 : i12
    %c917_i12 = hw.constant 917 : i12
    %c-6_i4 = hw.constant -6 : i4
    %c5_i4 = hw.constant 5 : i4
    %c868_i12 = hw.constant 868 : i12
    %c1028_i12 = hw.constant 1028 : i12
    %c1523_i12 = hw.constant 1523 : i12
    %c-966_i12 = hw.constant -966 : i12
    %c168_i12 = hw.constant 168 : i12
    %c-1453_i12 = hw.constant -1453 : i12
    %c-94_i12 = hw.constant -94 : i12
    %c0_i2 = hw.constant 0 : i2
    %c-1600_i12 = hw.constant -1600 : i12
    %c-1330_i12 = hw.constant -1330 : i12
    %c55_i12 = hw.constant 55 : i12
    %c-7_i4 = hw.constant -7 : i4
    %c6_i4 = hw.constant 6 : i4
    %true = hw.constant true
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %5 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %6 = llhd.prb %rst_ni_1 : i1
    %req_pwrup_i_2 = llhd.sig name "req_pwrup_i" %false : i1
    %pwrup_cause_i_3 = llhd.sig name "pwrup_cause_i" %c0_i2 : i2
    %ack_pwrdn_i_4 = llhd.sig name "ack_pwrdn_i" %false : i1
    %low_power_entry_i_5 = llhd.sig name "low_power_entry_i" %false : i1
    %main_pd_ni_6 = llhd.sig name "main_pd_ni" %false : i1
    %reset_reqs_i_7 = llhd.sig name "reset_reqs_i" %c0_i6 : i6
    %fsm_invalid_i_8 = llhd.sig name "fsm_invalid_i" %false : i1
    %clr_slow_req_o = llhd.sig %false : i1
    %wkup_o = llhd.sig %false : i1
    %fall_through_o = llhd.sig %false : i1
    %abort_o = llhd.sig %false : i1
    %clr_hint_o = llhd.sig %false : i1
    %clr_cfg_lock_o = llhd.sig %false : i1
    %pwr_rst_o = llhd.sig %4 : !hw.struct<rst_lc_req: i2, rst_sys_req: i2, rstreqs: i5, reset_cause: i2>
    %pwr_rst_i_9 = llhd.sig name "pwr_rst_i" %3 : !hw.struct<rst_lc_src_n: i2, rst_sys_src_n: i2>
    %ips_clk_en_o = llhd.sig %2 : !hw.struct<main_ip_clk_en: i1, io_ip_clk_en: i1, usb_ip_clk_en: i1>
    %otp_done_i_10 = llhd.sig name "otp_done_i" %false : i1
    %otp_idle_i_11 = llhd.sig name "otp_idle_i" %false : i1
    %lc_idle_i_12 = llhd.sig name "lc_idle_i" %false : i1
    %lc_hw_debug_en_i_13 = llhd.sig name "lc_hw_debug_en_i" %c0_i4 : i4
    %nvm_idle_i_14 = llhd.sig name "nvm_idle_i" %false : i1
    %strap_o = llhd.sig %false : i1
    %strap_sampled_o = llhd.sig %false : i1
    %pd_n_rsts_asserted = llhd.sig %false : i1
    %all_rsts_asserted = llhd.sig %false : i1
    %reset_valid = llhd.sig %false : i1
    %reset_cause_q = llhd.sig %c0_i2 : i2
    %reset_cause_d = llhd.sig %c0_i2 : i2
    %reset_req = llhd.sig %false : i1
    %direct_rst_req = llhd.sig %false : i1
    %ndmreset_req = llhd.sig %false : i1
    %hw_rst_req = llhd.sig %false : i1
    %sw_rst_req = llhd.sig %false : i1
    %fetch_en_q = llhd.sig %c0_i4 : i4
    %fetch_en_d = llhd.sig %c0_i4 : i4
    %state_d = llhd.sig %c0_i12 : i12
    %state_q = llhd.sig %c0_i12 : i12
    %reset_ongoing_q = llhd.sig %false : i1
    %reset_ongoing_d = llhd.sig %false : i1
    %req_pwrdn_q = llhd.sig %false : i1
    %req_pwrdn_d = llhd.sig %false : i1
    %ack_pwrup_q = llhd.sig %false : i1
    %ack_pwrup_d = llhd.sig %false : i1
    %ip_clk_en_q = llhd.sig %false : i1
    %ip_clk_en_d = llhd.sig %false : i1
    %rst_lc_req_q = llhd.sig %c0_i2 : i2
    %rst_sys_req_q = llhd.sig %c0_i2 : i2
    %rst_lc_req_d = llhd.sig %c0_i2 : i2
    %rst_sys_req_d = llhd.sig %c0_i2 : i2
    %otp_init = llhd.sig %false : i1
    %lc_init = llhd.sig %false : i1
    %low_power_q = llhd.sig %false : i1
    %low_power_d = llhd.sig %false : i1
    %lc_done = llhd.sig %false : i1
    %clks_enabled = llhd.sig %false : i1
    %clks_disabled = llhd.sig %false : i1
    %rom_intg_chk_done = llhd.sig %c0_i4 : i4
    %rom_intg_chk_good = llhd.sig %c0_i4 : i4
    %7 = llhd.prb %state_d : i12
    %u_state_regs.state_o = hw.instance "u_state_regs" @prim_sparse_fsm_flop_13(clk_i: %5: i1, rst_ni: %6: i1, state_i: %7: i12) -> (state_o: i12)
    llhd.drv %state_q, %u_state_regs.state_o after %1 : i12
    %8 = llhd.prb %fetch_en_d : i4
    %u_fetch_en.lc_en_o = hw.instance "u_fetch_en" @prim_lc_sender(clk_i: %5: i1, rst_ni: %6: i1, lc_en_i: %8: i4) -> (lc_en_o: i4)
    llhd.drv %fetch_en_q, %u_fetch_en.lc_en_o after %1 : i4
    %u_slow_sync_lc_done.q_o = hw.instance "u_slow_sync_lc_done" @prim_flop_2sync(clk_i: %clk_slow_i: i1, rst_ni: %rst_slow_ni: i1, d_i: %lc_done_i: i1) -> (q_o: i1) {sv.namehint = "slow_lc_done"}
    %u_sync_lc_done.q_o = hw.instance "u_sync_lc_done" @prim_flop_2sync(clk_i: %5: i1, rst_ni: %6: i1, d_i: %u_slow_sync_lc_done.q_o: i1) -> (q_o: i1)
    llhd.drv %lc_done, %u_sync_lc_done.q_o after %1 : i1
    %9 = llhd.prb %ip_clk_en_d : i1
    %10 = comb.and %9, %usb_ip_clk_en_i : i1
    %11 = llhd.sig.struct_extract %ips_clk_en_o["usb_ip_clk_en"] : <!hw.struct<main_ip_clk_en: i1, io_ip_clk_en: i1, usb_ip_clk_en: i1>>
    %u_usb_ip_clk_en.q_o = hw.instance "u_usb_ip_clk_en" @prim_flop(clk_i: %5: i1, rst_ni: %6: i1, d_i: %10: i1) -> (q_o: i1)
    llhd.drv %11, %u_usb_ip_clk_en.q_o after %1 : i1
    %12 = llhd.prb %otp_init : i1
    %u_reg_otp_init.q_o = hw.instance "u_reg_otp_init" @prim_flop(clk_i: %5: i1, rst_ni: %6: i1, d_i: %12: i1) -> (q_o: i1)
    %13 = llhd.prb %lc_init : i1
    %u_reg_lc_init.q_o = hw.instance "u_reg_lc_init" @prim_flop(clk_i: %5: i1, rst_ni: %6: i1, d_i: %13: i1) -> (q_o: i1)
    %14 = llhd.prb %pwr_rst_i_9 : !hw.struct<rst_lc_src_n: i2, rst_sys_src_n: i2>
    %rst_lc_src_n = hw.struct_extract %14["rst_lc_src_n"] : !hw.struct<rst_lc_src_n: i2, rst_sys_src_n: i2>
    %15 = comb.extract %rst_lc_src_n from 1 : (i2) -> i1
    %16 = comb.xor %15, %true : i1
    %rst_sys_src_n = hw.struct_extract %14["rst_sys_src_n"] : !hw.struct<rst_lc_src_n: i2, rst_sys_src_n: i2>
    %17 = comb.extract %rst_sys_src_n from 1 : (i2) -> i1
    %18 = comb.xor %17, %true : i1
    %19 = comb.and %16, %18 : i1
    llhd.drv %pd_n_rsts_asserted, %19 after %1 : i1
    %20 = llhd.prb %rst_lc_req_q : i2
    %21 = comb.xor %rst_lc_src_n, %c-1_i2 : i2
    %22 = comb.and %20, %21 : i2
    %23 = comb.xor %20, %c-1_i2 : i2
    %24 = comb.and %23, %rst_lc_src_n : i2
    %25 = comb.or %22, %24 : i2
    %26 = comb.icmp eq %25, %c-1_i2 {sv.namehint = "lc_rsts_valid"} : i2
    %27 = llhd.prb %rst_sys_req_q : i2
    %28 = comb.xor %rst_sys_src_n, %c-1_i2 : i2
    %29 = comb.and %27, %28 : i2
    %30 = comb.xor %27, %c-1_i2 : i2
    %31 = comb.and %30, %rst_sys_src_n : i2
    %32 = comb.or %29, %31 : i2
    %33 = comb.icmp eq %32, %c-1_i2 {sv.namehint = "sys_rsts_valid"} : i2
    %34 = comb.and %26, %33 : i1
    llhd.drv %all_rsts_asserted, %34 after %1 : i1
    %35 = llhd.prb %reset_reqs_i_7 : i6
    %36 = comb.icmp ne %35, %c0_i6 : i6
    llhd.drv %reset_req, %36 after %1 : i1
    %37 = comb.extract %35 from 0 : (i6) -> i2
    %38 = comb.icmp ne %37, %c0_i2 : i2
    llhd.drv %hw_rst_req, %38 after %1 : i1
    %39 = comb.extract %35 from 3 : (i6) -> i1
    %40 = comb.extract %35 from 2 : (i6) -> i1
    %41 = comb.or %39, %40 : i1
    llhd.drv %direct_rst_req, %41 after %1 : i1
    %42 = comb.extract %35 from 4 : (i6) -> i1
    llhd.drv %ndmreset_req, %42 after %1 : i1
    %43 = comb.extract %35 from 5 : (i6) -> i1
    llhd.drv %sw_rst_req, %43 after %1 : i1
    %44 = llhd.prb %reset_cause_q : i2
    %45 = comb.icmp eq %44, %c1_i2 : i2
    %46 = llhd.prb %main_pd_ni_6 : i1
    %47 = llhd.prb %pd_n_rsts_asserted : i1
    %48 = comb.or %46, %47 : i1
    %49 = comb.icmp eq %44, %c-2_i2 : i2
    %50 = llhd.prb %all_rsts_asserted : i1
    %51 = comb.and %49, %50 : i1
    %52 = comb.mux %45, %48, %51 : i1
    llhd.drv %reset_valid, %52 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %122 = llhd.prb %clk_i_0 : i1
      %123 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%5, %6 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %124 = llhd.prb %clk_i_0 : i1
      %125 = comb.xor bin %122, %true : i1
      %126 = comb.and bin %125, %124 : i1
      %127 = llhd.prb %rst_ni_1 : i1
      %128 = comb.xor bin %127, %true : i1
      %129 = comb.and bin %123, %128 : i1
      %130 = comb.or bin %126, %129 : i1
      cf.cond_br %130, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %131 = llhd.prb %rst_ni_1 : i1
      %132 = comb.xor %131, %true : i1
      cf.cond_br %132, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %ack_pwrup_q, %false after %0 : i1
      llhd.drv %req_pwrdn_q, %false after %0 : i1
      llhd.drv %reset_ongoing_q, %false after %0 : i1
      llhd.drv %ip_clk_en_q, %false after %0 : i1
      llhd.drv %rst_lc_req_q, %c-1_i2 after %0 : i2
      llhd.drv %rst_sys_req_q, %c-1_i2 after %0 : i2
      llhd.drv %reset_cause_q, %c-1_i2 after %0 : i2
      llhd.drv %low_power_q, %true after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %133 = llhd.prb %ack_pwrup_d : i1
      llhd.drv %ack_pwrup_q, %133 after %0 : i1
      %134 = llhd.prb %req_pwrdn_d : i1
      llhd.drv %req_pwrdn_q, %134 after %0 : i1
      %135 = llhd.prb %reset_ongoing_d : i1
      llhd.drv %reset_ongoing_q, %135 after %0 : i1
      %136 = llhd.prb %ip_clk_en_d : i1
      llhd.drv %ip_clk_en_q, %136 after %0 : i1
      %137 = llhd.prb %rst_lc_req_d : i2
      llhd.drv %rst_lc_req_q, %137 after %0 : i2
      %138 = llhd.prb %rst_sys_req_d : i2
      llhd.drv %rst_sys_req_q, %138 after %0 : i2
      %139 = llhd.prb %reset_cause_d : i2
      llhd.drv %reset_cause_q, %139 after %0 : i2
      %140 = llhd.prb %low_power_d : i1
      llhd.drv %low_power_q, %140 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %122 = llhd.prb %clk_i_0 : i1
      %123 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%5, %6 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %124 = llhd.prb %clk_i_0 : i1
      %125 = comb.xor bin %122, %true : i1
      %126 = comb.and bin %125, %124 : i1
      %127 = llhd.prb %rst_ni_1 : i1
      %128 = comb.xor bin %127, %true : i1
      %129 = comb.and bin %123, %128 : i1
      %130 = comb.or bin %126, %129 : i1
      cf.cond_br %130, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %131 = llhd.prb %rst_ni_1 : i1
      %132 = comb.xor %131, %true : i1
      cf.cond_br %132, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %strap_sampled_o, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %133 = llhd.prb %rst_sys_req_q : i2
      %134 = comb.icmp eq %133, %c-1_i2 : i2
      cf.cond_br %134, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %strap_sampled_o, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %135 = llhd.prb %strap_o : i1
      cf.cond_br %135, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %strap_sampled_o, %true after %0 : i1
      cf.br ^bb1
    }
    %53 = llhd.prb %fetch_en_q : i4
    %54 = llhd.prb %ip_clk_en_q : i1
    %55 = llhd.prb %ips_clk_en_o : !hw.struct<main_ip_clk_en: i1, io_ip_clk_en: i1, usb_ip_clk_en: i1>
    %56 = hw.bitcast %55 : (!hw.struct<main_ip_clk_en: i1, io_ip_clk_en: i1, usb_ip_clk_en: i1>) -> i3
    %57 = hw.bitcast %clk_en_status_i : (!hw.struct<main_status: i1, io_status: i1, usb_status: i1>) -> i3
    %58 = comb.and %56, %57 : i3
    %59 = comb.xor %56, %c-1_i3 : i3
    %60 = comb.or %58, %59 : i3
    %61 = comb.icmp eq %60, %c-1_i3 : i3
    %62 = comb.and %54, %61 : i1
    llhd.drv %clks_enabled, %62 after %1 : i1
    %63 = comb.xor %54, %true : i1
    %64 = comb.xor %57, %c-1_i3 : i3
    %65 = comb.and %59, %64 : i3
    %66 = comb.or %65, %56 : i3
    %67 = comb.icmp eq %66, %c-1_i3 : i3
    %68 = comb.and %63, %67 : i1
    llhd.drv %clks_disabled, %68 after %1 : i1
    %69 = llhd.prb %lc_hw_debug_en_i_13 : i4
    %70 = func.call @"lc_ctrl_pkg::lc_tx_and_hi"(%lc_dft_en_i, %69) : (i4, i4) -> i4
    %71 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%70) : (i4) -> i1
    %72 = comb.mux %71, %c6_i4, %c-7_i4 {sv.namehint = "rom_intg_chk_dis"} : i4
    llhd.drv %rom_intg_chk_done, %rom_ctrl_done_i after %1 : i4
    %73 = func.call @"prim_mubi_pkg::mubi4_or_hi"(%72, %rom_ctrl_good_i) : (i4, i4) -> i4
    llhd.drv %rom_intg_chk_good, %73 after %1 : i4
    %74 = llhd.prb %wkup_o : i1
    %75 = llhd.prb %fall_through_o : i1
    %76 = llhd.prb %abort_o : i1
    %77 = llhd.prb %clr_hint_o : i1
    %78 = llhd.prb %clr_cfg_lock_o : i1
    %79 = llhd.prb %strap_o : i1
    %80 = llhd.prb %clr_slow_req_o : i1
    %81 = llhd.prb %state_q : i12
    %82 = llhd.prb %ack_pwrup_q : i1
    %83 = llhd.prb %ack_pwrup_d : i1
    %84 = llhd.prb %req_pwrdn_q : i1
    %85 = llhd.prb %req_pwrdn_d : i1
    %86 = llhd.prb %reset_ongoing_q : i1
    %87 = llhd.prb %reset_ongoing_d : i1
    %88 = llhd.prb %rst_lc_req_d : i2
    %89 = llhd.prb %rst_sys_req_d : i2
    %90 = llhd.prb %reset_cause_d : i2
    %91 = llhd.prb %low_power_q : i1
    %92 = llhd.prb %low_power_d : i1
    %93 = llhd.prb %req_pwrup_i_2 : i1
    %94 = llhd.prb %fsm_invalid_i_8 : i1
    %95 = llhd.prb %clks_enabled : i1
    %96 = llhd.prb %otp_done_i_10 : i1
    %97 = llhd.prb %lc_done : i1
    %98 = llhd.prb %pwrup_cause_i_3 : i2
    %99 = llhd.prb %strap_sampled_o : i1
    %100 = llhd.prb %rom_intg_chk_done : i4
    %101 = llhd.prb %rom_intg_chk_good : i4
    %102 = llhd.prb %reset_req : i1
    %103 = llhd.prb %low_power_entry_i_5 : i1
    %104 = llhd.prb %clks_disabled : i1
    %105 = llhd.prb %direct_rst_req : i1
    %106 = llhd.prb %otp_idle_i_11 : i1
    %107 = llhd.prb %lc_idle_i_12 : i1
    %108 = llhd.prb %nvm_idle_i_14 : i1
    %109 = llhd.prb %reset_valid : i1
    %110 = llhd.prb %ack_pwrdn_i_4 : i1
    %111 = llhd.prb %hw_rst_req : i1
    %112 = llhd.prb %sw_rst_req : i1
    %113 = llhd.prb %ndmreset_req : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb61
      llhd.drv %otp_init, %false after %1 : i1
      llhd.drv %lc_init, %false after %1 : i1
      llhd.drv %wkup_o, %false after %1 : i1
      llhd.drv %fall_through_o, %false after %1 : i1
      llhd.drv %abort_o, %false after %1 : i1
      llhd.drv %clr_hint_o, %false after %1 : i1
      llhd.drv %clr_cfg_lock_o, %false after %1 : i1
      llhd.drv %strap_o, %false after %1 : i1
      llhd.drv %clr_slow_req_o, %false after %1 : i1
      %122 = llhd.prb %state_q : i12
      llhd.drv %state_d, %122 after %1 : i12
      %123 = llhd.prb %ack_pwrup_q : i1
      llhd.drv %ack_pwrup_d, %123 after %1 : i1
      %124 = llhd.prb %req_pwrdn_q : i1
      llhd.drv %req_pwrdn_d, %124 after %1 : i1
      %125 = llhd.prb %reset_ongoing_q : i1
      llhd.drv %reset_ongoing_d, %125 after %1 : i1
      %126 = llhd.prb %ip_clk_en_q : i1
      llhd.drv %ip_clk_en_d, %126 after %1 : i1
      %127 = llhd.prb %rst_lc_req_q : i2
      llhd.drv %rst_lc_req_d, %127 after %1 : i2
      %128 = llhd.prb %rst_sys_req_q : i2
      llhd.drv %rst_sys_req_d, %128 after %1 : i2
      %129 = llhd.prb %reset_cause_q : i2
      llhd.drv %reset_cause_d, %129 after %1 : i2
      %130 = llhd.prb %low_power_q : i1
      llhd.drv %low_power_d, %130 after %1 : i1
      %131 = llhd.prb %fetch_en_q : i4
      llhd.drv %fetch_en_d, %131 after %1 : i4
      %132 = llhd.prb %state_q : i12
      %133 = comb.icmp ceq %132, %c55_i12 : i12
      cf.cond_br %133, ^bb2, ^bb4
    ^bb2:  // pred: ^bb1
      %134 = llhd.prb %req_pwrup_i_2 : i1
      %135 = llhd.prb %reset_ongoing_q : i1
      %136 = comb.or %134, %135 : i1
      cf.cond_br %136, ^bb3, ^bb59
    ^bb3:  // pred: ^bb2
      llhd.drv %state_d, %c-1330_i12 after %1 : i12
      cf.br ^bb59
    ^bb4:  // pred: ^bb1
      %137 = comb.icmp ceq %132, %c-1330_i12 : i12
      cf.cond_br %137, ^bb5, ^bb7
    ^bb5:  // pred: ^bb4
      llhd.drv %ip_clk_en_d, %true after %1 : i1
      %138 = llhd.prb %clks_enabled : i1
      cf.cond_br %138, ^bb6, ^bb59
    ^bb6:  // pred: ^bb5
      llhd.drv %state_d, %c-1600_i12 after %1 : i12
      cf.br ^bb59
    ^bb7:  // pred: ^bb4
      %139 = comb.icmp ceq %132, %c-1600_i12 : i12
      cf.cond_br %139, ^bb8, ^bb10
    ^bb8:  // pred: ^bb7
      llhd.drv %rst_lc_req_d, %c0_i2 after %1 : i2
      llhd.drv %rst_sys_req_d, %c0_i2 after %1 : i2
      %140 = llhd.prb %pwr_rst_i_9 : !hw.struct<rst_lc_src_n: i2, rst_sys_src_n: i2>
      %rst_lc_src_n_15 = hw.struct_extract %140["rst_lc_src_n"] : !hw.struct<rst_lc_src_n: i2, rst_sys_src_n: i2>
      %141 = comb.icmp eq %rst_lc_src_n_15, %c-1_i2 : i2
      cf.cond_br %141, ^bb9, ^bb59
    ^bb9:  // pred: ^bb8
      llhd.drv %state_d, %c-94_i12 after %1 : i12
      cf.br ^bb59
    ^bb10:  // pred: ^bb7
      %142 = comb.icmp ceq %132, %c-94_i12 : i12
      cf.cond_br %142, ^bb11, ^bb13
    ^bb11:  // pred: ^bb10
      llhd.drv %otp_init, %true after %1 : i1
      %143 = llhd.prb %otp_done_i_10 : i1
      cf.cond_br %143, ^bb12, ^bb59
    ^bb12:  // pred: ^bb11
      llhd.drv %state_d, %c-1453_i12 after %1 : i12
      cf.br ^bb59
    ^bb13:  // pred: ^bb10
      %144 = comb.icmp ceq %132, %c-1453_i12 : i12
      cf.cond_br %144, ^bb14, ^bb16
    ^bb14:  // pred: ^bb13
      llhd.drv %lc_init, %true after %1 : i1
      %145 = llhd.prb %lc_done : i1
      cf.cond_br %145, ^bb15, ^bb59
    ^bb15:  // pred: ^bb14
      llhd.drv %state_d, %c168_i12 after %1 : i12
      cf.br ^bb59
    ^bb16:  // pred: ^bb13
      %146 = comb.icmp ceq %132, %c168_i12 : i12
      cf.cond_br %146, ^bb17, ^bb19
    ^bb17:  // pred: ^bb16
      %147 = llhd.prb %reset_ongoing_q : i1
      %148 = comb.xor %147, %true : i1
      llhd.drv %ack_pwrup_d, %148 after %1 : i1
      %149 = llhd.prb %req_pwrup_i_2 : i1
      %150 = comb.xor %149, %true : i1
      %151 = llhd.prb %reset_ongoing_q : i1
      %152 = comb.or %150, %151 : i1
      cf.cond_br %152, ^bb18, ^bb59
    ^bb18:  // pred: ^bb17
      llhd.drv %ack_pwrup_d, %false after %1 : i1
      llhd.drv %clr_cfg_lock_o, %true after %1 : i1
      %153 = llhd.prb %pwrup_cause_i_3 : i2
      %154 = comb.icmp eq %153, %c1_i2 : i2
      %155 = llhd.prb %reset_cause_q : i2
      %156 = comb.icmp eq %155, %c1_i2 : i2
      %157 = comb.and %154, %156 : i1
      llhd.drv %wkup_o, %157 after %1 : i1
      llhd.drv %reset_ongoing_d, %false after %1 : i1
      llhd.drv %state_d, %c-966_i12 after %1 : i12
      cf.br ^bb59
    ^bb19:  // pred: ^bb16
      %158 = comb.icmp ceq %132, %c-966_i12 : i12
      cf.cond_br %158, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      %159 = llhd.prb %strap_sampled_o : i1
      %160 = comb.xor %159, %true : i1
      llhd.drv %strap_o, %160 after %1 : i1
      llhd.drv %state_d, %c1523_i12 after %1 : i12
      cf.br ^bb59
    ^bb21:  // pred: ^bb19
      %161 = comb.icmp ceq %132, %c1523_i12 : i12
      cf.cond_br %161, ^bb22, ^bb24
    ^bb22:  // pred: ^bb21
      llhd.drv %low_power_d, %false after %1 : i1
      llhd.drv %reset_cause_d, %c0_i2 after %1 : i2
      %162 = llhd.prb %rom_intg_chk_done : i4
      %163 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%162) : (i4) -> i1
      cf.cond_br %163, ^bb23, ^bb59
    ^bb23:  // pred: ^bb22
      llhd.drv %state_d, %c1028_i12 after %1 : i12
      cf.br ^bb59
    ^bb24:  // pred: ^bb21
      %164 = comb.icmp ceq %132, %c1028_i12 : i12
      cf.cond_br %164, ^bb25, ^bb27
    ^bb25:  // pred: ^bb24
      %165 = llhd.prb %rom_intg_chk_good : i4
      %166 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%165) : (i4) -> i1
      cf.cond_br %166, ^bb26, ^bb59
    ^bb26:  // pred: ^bb25
      llhd.drv %state_d, %c868_i12 after %1 : i12
      cf.br ^bb59
    ^bb27:  // pred: ^bb24
      %167 = comb.icmp ceq %132, %c868_i12 : i12
      cf.cond_br %167, ^bb28, ^bb30
    ^bb28:  // pred: ^bb27
      llhd.drv %fetch_en_d, %c5_i4 after %1 : i4
      %168 = llhd.prb %reset_req : i1
      %169 = llhd.prb %low_power_entry_i_5 : i1
      %170 = comb.or %168, %169 : i1
      cf.cond_br %170, ^bb29, ^bb59
    ^bb29:  // pred: ^bb28
      llhd.drv %fetch_en_d, %c-6_i4 after %1 : i4
      llhd.drv %reset_cause_d, %c-1_i2 after %1 : i2
      llhd.drv %state_d, %c917_i12 after %1 : i12
      cf.br ^bb59
    ^bb30:  // pred: ^bb27
      %171 = comb.icmp ceq %132, %c917_i12 : i12
      cf.cond_br %171, ^bb31, ^bb34
    ^bb31:  // pred: ^bb30
      llhd.drv %ip_clk_en_d, %false after %1 : i1
      %172 = llhd.prb %clks_disabled : i1
      cf.cond_br %172, ^bb32, ^bb33
    ^bb32:  // pred: ^bb31
      %173 = llhd.prb %reset_req : i1
      %174 = comb.mux %173, %c778_i12, %c1744_i12 : i12
      llhd.drv %state_d, %174 after %1 : i12
      %175 = llhd.prb %reset_req : i1
      %176 = comb.xor %175, %true : i1
      llhd.drv %low_power_d, %176 after %1 : i1
      cf.br ^bb59
    ^bb33:  // pred: ^bb31
      %177 = llhd.prb %direct_rst_req : i1
      %178 = llhd.prb %state_q : i12
      %179 = comb.mux %177, %c778_i12, %178 : i12
      llhd.drv %state_d, %179 after %1 : i12
      %180 = llhd.prb %reset_req : i1
      %181 = comb.xor %180, %true : i1
      llhd.drv %low_power_d, %181 after %1 : i1
      cf.br ^bb59
    ^bb34:  // pred: ^bb30
      %182 = comb.icmp ceq %132, %c1744_i12 : i12
      cf.cond_br %182, ^bb35, ^bb38
    ^bb35:  // pred: ^bb34
      llhd.drv %clr_hint_o, %true after %1 : i1
      %183 = llhd.prb %low_power_entry_i_5 : i1
      %184 = comb.xor %183, %true : i1
      cf.cond_br %184, ^bb36, ^bb37
    ^bb36:  // pred: ^bb35
      llhd.drv %ip_clk_en_d, %true after %1 : i1
      llhd.drv %wkup_o, %true after %1 : i1
      llhd.drv %fall_through_o, %true after %1 : i1
      llhd.drv %state_d, %c1523_i12 after %1 : i12
      cf.br ^bb59
    ^bb37:  // pred: ^bb35
      llhd.drv %state_d, %c-1671_i12 after %1 : i12
      cf.br ^bb59
    ^bb38:  // pred: ^bb34
      %185 = comb.icmp ceq %132, %c-1671_i12 : i12
      cf.cond_br %185, ^bb39, ^bb42
    ^bb39:  // pred: ^bb38
      %186 = llhd.prb %otp_idle_i_11 : i1
      %187 = llhd.prb %lc_idle_i_12 : i1
      %188 = llhd.prb %nvm_idle_i_14 : i1
      %189 = comb.and %186, %187, %188 : i1
      cf.cond_br %189, ^bb40, ^bb41
    ^bb40:  // pred: ^bb39
      llhd.drv %state_d, %c1423_i12 after %1 : i12
      cf.br ^bb59
    ^bb41:  // pred: ^bb39
      llhd.drv %ip_clk_en_d, %true after %1 : i1
      llhd.drv %wkup_o, %true after %1 : i1
      llhd.drv %abort_o, %true after %1 : i1
      llhd.drv %state_d, %c1523_i12 after %1 : i12
      cf.br ^bb59
    ^bb42:  // pred: ^bb38
      %190 = comb.icmp ceq %132, %c1423_i12 : i12
      cf.cond_br %190, ^bb43, ^bb48
    ^bb43:  // pred: ^bb42
      llhd.drv %reset_cause_d, %c1_i2 after %1 : i2
      cf.br ^bb44(%c1_i32 : i32)
    ^bb44(%191: i32):  // 2 preds: ^bb43, ^bb45
      %192 = comb.icmp slt %191, %c2_i32 : i32
      cf.cond_br %192, ^bb45, ^bb46
    ^bb45:  // pred: ^bb44
      %193 = comb.extract %191 from 1 : (i32) -> i31
      %194 = comb.extract %191 from 0 : (i32) -> i1
      %195 = comb.icmp ne %193, %c0_i31 : i31
      %196 = comb.or %195, %194 : i1
      %197 = llhd.sig.extract %rst_lc_req_d from %196 : <i2> -> <i1>
      %198 = llhd.prb %main_pd_ni_6 : i1
      %199 = comb.xor %198, %true : i1
      llhd.drv %197, %199 after %1 : i1
      %200 = llhd.sig.extract %rst_sys_req_d from %196 : <i2> -> <i1>
      %201 = llhd.prb %main_pd_ni_6 : i1
      %202 = comb.xor %201, %true : i1
      llhd.drv %200, %202 after %1 : i1
      %203 = comb.add %191, %c1_i32 : i32
      cf.br ^bb44(%203 : i32)
    ^bb46:  // pred: ^bb44
      %204 = llhd.prb %reset_valid : i1
      cf.cond_br %204, ^bb47, ^bb59
    ^bb47:  // pred: ^bb46
      llhd.drv %state_d, %c-375_i12 after %1 : i12
      cf.br ^bb59
    ^bb48:  // pred: ^bb42
      %205 = comb.icmp ceq %132, %c-375_i12 : i12
      cf.cond_br %205, ^bb49, ^bb51
    ^bb49:  // pred: ^bb48
      llhd.drv %req_pwrdn_d, %true after %1 : i1
      %206 = llhd.prb %ack_pwrdn_i_4 : i1
      cf.cond_br %206, ^bb50, ^bb59
    ^bb50:  // pred: ^bb49
      llhd.drv %req_pwrdn_d, %false after %1 : i1
      llhd.drv %state_d, %c55_i12 after %1 : i12
      cf.br ^bb59
    ^bb51:  // pred: ^bb48
      %207 = comb.icmp ceq %132, %c778_i12 : i12
      cf.cond_br %207, ^bb52, ^bb53
    ^bb52:  // pred: ^bb51
      llhd.drv %clr_hint_o, %true after %1 : i1
      llhd.drv %reset_ongoing_d, %true after %1 : i1
      llhd.drv %state_d, %c1647_i12 after %1 : i12
      cf.br ^bb59
    ^bb53:  // pred: ^bb51
      %208 = comb.icmp ceq %132, %c1647_i12 : i12
      cf.cond_br %208, ^bb54, ^bb55
    ^bb54:  // pred: ^bb53
      llhd.drv %reset_cause_d, %c-2_i2 after %1 : i2
      llhd.drv %rst_lc_req_d, %c-1_i2 after %1 : i2
      %209 = llhd.prb %hw_rst_req : i1
      %210 = llhd.prb %direct_rst_req : i1
      %211 = llhd.prb %sw_rst_req : i1
      %212 = llhd.prb %ndmreset_req : i1
      %213 = llhd.prb %lc_hw_debug_en_i_13 : i4
      %214 = func.call @"lc_ctrl_pkg::lc_tx_test_false_loose"(%213) : (i4) -> i1
      %215 = comb.and %212, %214 : i1
      %216 = comb.or %209, %210, %211, %215 : i1
      %217 = comb.replicate %216 : (i1) -> i2
      llhd.drv %rst_sys_req_d, %217 after %1 : i2
      llhd.drv %state_d, %c-4_i12 after %1 : i12
      cf.br ^bb59
    ^bb55:  // pred: ^bb53
      %218 = comb.icmp ceq %132, %c-4_i12 : i12
      cf.cond_br %218, ^bb56, ^bb58
    ^bb56:  // pred: ^bb55
      llhd.drv %rst_lc_req_d, %c-1_i2 after %1 : i2
      %219 = llhd.prb %reset_reqs_i_7 : i6
      %220 = comb.extract %219 from 2 : (i6) -> i1
      llhd.drv %clr_slow_req_o, %220 after %1 : i1
      %221 = llhd.prb %reset_valid : i1
      %222 = llhd.prb %reset_reqs_i_7 : i6
      %223 = comb.extract %222 from 2 : (i6) -> i1
      %224 = comb.xor %223, %true : i1
      %225 = comb.and %221, %224 : i1
      cf.cond_br %225, ^bb57, ^bb59
    ^bb57:  // pred: ^bb56
      llhd.drv %state_d, %c55_i12 after %1 : i12
      cf.br ^bb59
    ^bb58:  // pred: ^bb55
      llhd.drv %rst_lc_req_d, %c-1_i2 after %1 : i2
      llhd.drv %rst_sys_req_d, %c-1_i2 after %1 : i2
      llhd.drv %ip_clk_en_d, %false after %1 : i1
      cf.br ^bb59
    ^bb59:  // 34 preds: ^bb2, ^bb3, ^bb5, ^bb6, ^bb8, ^bb9, ^bb11, ^bb12, ^bb14, ^bb15, ^bb17, ^bb18, ^bb20, ^bb22, ^bb23, ^bb25, ^bb26, ^bb28, ^bb29, ^bb32, ^bb33, ^bb36, ^bb37, ^bb40, ^bb41, ^bb46, ^bb47, ^bb49, ^bb50, ^bb52, ^bb54, ^bb56, ^bb57, ^bb58
      %226 = llhd.prb %fsm_invalid_i_8 : i1
      cf.cond_br %226, ^bb60, ^bb61
    ^bb60:  // pred: ^bb59
      llhd.drv %state_d, %c-682_i12 after %1 : i12
      cf.br ^bb61
    ^bb61:  // 2 preds: ^bb59, ^bb60
      llhd.wait (%12, %13, %74, %75, %76, %77, %78, %79, %80, %81, %7, %82, %83, %84, %85, %86, %87, %54, %9, %20, %88, %27, %89, %44, %90, %91, %92, %53, %8, %93, %94, %95, %14, %96, %97, %98, %99, %100, %101, %102, %103, %104, %105, %106, %107, %108, %46, %109, %110, %c-1_i2, %111, %112, %113, %69, %35 : i1, i1, i1, i1, i1, i1, i1, i1, i1, i12, i12, i1, i1, i1, i1, i1, i1, i1, i1, i2, i2, i2, i2, i2, i2, i1, i1, i4, i4, i1, i1, i1, !hw.struct<rst_lc_src_n: i2, rst_sys_src_n: i2>, i1, i1, i2, i1, i4, i4, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i2, i1, i1, i1, i4, i6), ^bb1
    }
    %114 = llhd.sig.struct_extract %pwr_rst_o["rst_lc_req"] : <!hw.struct<rst_lc_req: i2, rst_sys_req: i2, rstreqs: i5, reset_cause: i2>>
    llhd.drv %114, %20 after %1 : i2
    %115 = llhd.sig.struct_extract %pwr_rst_o["rst_sys_req"] : <!hw.struct<rst_lc_req: i2, rst_sys_req: i2, rstreqs: i5, reset_cause: i2>>
    llhd.drv %115, %27 after %1 : i2
    %116 = llhd.sig.struct_extract %pwr_rst_o["reset_cause"] : <!hw.struct<rst_lc_req: i2, rst_sys_req: i2, rstreqs: i5, reset_cause: i2>>
    llhd.drv %116, %44 after %1 : i2
    %117 = llhd.sig.struct_extract %pwr_rst_o["rstreqs"] : <!hw.struct<rst_lc_req: i2, rst_sys_req: i2, rstreqs: i5, reset_cause: i2>>
    %118 = comb.extract %35 from 0 : (i6) -> i5
    llhd.drv %117, %118 after %1 : i5
    %119 = llhd.sig.struct_extract %ips_clk_en_o["main_ip_clk_en"] : <!hw.struct<main_ip_clk_en: i1, io_ip_clk_en: i1, usb_ip_clk_en: i1>>
    llhd.drv %119, %54 after %1 : i1
    %120 = llhd.sig.struct_extract %ips_clk_en_o["io_ip_clk_en"] : <!hw.struct<main_ip_clk_en: i1, io_ip_clk_en: i1, usb_ip_clk_en: i1>>
    llhd.drv %120, %54 after %1 : i1
    %usb_status = hw.struct_extract %clk_en_status_i["usb_status"] : !hw.struct<main_status: i1, io_status: i1, usb_status: i1>
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %req_pwrup_i_2, %req_pwrup_i after %1 : i1
    llhd.drv %pwrup_cause_i_3, %pwrup_cause_i after %1 : i2
    llhd.drv %ack_pwrdn_i_4, %ack_pwrdn_i after %1 : i1
    llhd.drv %low_power_entry_i_5, %low_power_entry_i after %1 : i1
    llhd.drv %main_pd_ni_6, %main_pd_ni after %1 : i1
    llhd.drv %reset_reqs_i_7, %reset_reqs_i after %1 : i6
    llhd.drv %fsm_invalid_i_8, %fsm_invalid_i after %1 : i1
    %121 = llhd.prb %pwr_rst_o : !hw.struct<rst_lc_req: i2, rst_sys_req: i2, rstreqs: i5, reset_cause: i2>
    llhd.drv %pwr_rst_i_9, %pwr_rst_i after %1 : !hw.struct<rst_lc_src_n: i2, rst_sys_src_n: i2>
    llhd.drv %otp_done_i_10, %otp_done_i after %1 : i1
    llhd.drv %otp_idle_i_11, %otp_idle_i after %1 : i1
    llhd.drv %lc_idle_i_12, %lc_idle_i after %1 : i1
    llhd.drv %lc_hw_debug_en_i_13, %lc_hw_debug_en_i after %1 : i4
    llhd.drv %nvm_idle_i_14, %nvm_idle_i after %1 : i1
    hw.output %82, %84, %80, %usb_status, %74, %75, %76, %77, %78, %121, %55, %u_reg_otp_init.q_o, %u_reg_lc_init.q_o, %79, %99, %91, %53 : i1, i1, i1, i1, i1, i1, i1, i1, i1, !hw.struct<rst_lc_req: i2, rst_sys_req: i2, rstreqs: i5, reset_cause: i2>, !hw.struct<main_ip_clk_en: i1, io_ip_clk_en: i1, usb_ip_clk_en: i1>, i1, i1, i1, i1, i1, i4
  }
  hw.module private @pwrmgr_reg_top(in %clk_i : i1, in %rst_ni : i1, in %clk_lc_i : i1, in %rst_lc_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out reg2hw : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>, in %hw2reg : !hw.struct<intr_state: !hw.struct<d: i1, de: i1>, ctrl_cfg_regwen: !hw.struct<d: i1>, control: !hw.struct<low_power_hint: !hw.struct<d: i1, de: i1>>, cfg_cdc_sync: !hw.struct<d: i1, de: i1>, wake_status: !hw.array<6xstruct<d: i1, de: i1>>, reset_status: !hw.array<2xstruct<d: i1, de: i1>>, escalate_reset_status: !hw.struct<d: i1, de: i1>, wake_info: !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>, out intg_err_o : i1) {
    %c-1_i2 = hw.constant -1 : i2
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
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %c0_i2 = hw.constant 0 : i2
    %c-3_i3 = hw.constant -3 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c3_i3 = hw.constant 3 : i3
    %c2_i3 = hw.constant 2 : i3
    %c1_i3 = hw.constant 1 : i3
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i3 = hw.constant 0 : i3
    %c0_i6 = hw.constant 0 : i6
    %c0_i17 = hw.constant 0 : i17
    %c0_i4 = hw.constant 0 : i4
    %2 = hw.aggregate_constant [[false], [false], [false, false], [false, false], [[false], [false], [false], [false], [false], [false]], [false, false], [[false], [false], [false], [false], [false], [false]], [[false], [false]], [false], [[false, false], [false, false], [0 : i6, false]], [[false], [false], [false]]] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %c-1_i32 = hw.constant -1 : i32
    %c0_i32 = hw.constant 0 : i32
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
    %false = hw.constant false {sv.namehint = "shadow_busy"}
    %c-7_i4 = hw.constant -7 : i4
    %clk_lc_i_0 = llhd.sig name "clk_lc_i" %false : i1
    %3 = llhd.prb %clk_lc_i_0 : i1
    %rst_lc_ni_1 = llhd.sig name "rst_lc_ni" %false : i1
    %4 = llhd.prb %rst_lc_ni_1 : i1
    %reg2hw = llhd.sig %2 : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %reg_we = llhd.sig %false : i1
    %reg_addr = llhd.sig %c0_i7 : i7
    %reg_be = llhd.sig %c0_i4 : i4
    %wr_err = llhd.sig %false : i1
    %reg_rdata_next = llhd.sig %c0_i32 : i32
    %intg_err = llhd.sig %false : i1
    %reg_we_err = llhd.sig %false : i1
    %reg_we_check = llhd.sig %c0_i17 : i17
    %err_q = llhd.sig %false : i1
    %intr_state_we = llhd.sig %false : i1
    %intr_state_qs = llhd.sig %false : i1
    %intr_enable_we = llhd.sig %false : i1
    %intr_enable_qs = llhd.sig %false : i1
    %intr_test_we = llhd.sig %false : i1
    %alert_test_we = llhd.sig %false : i1
    %ctrl_cfg_regwen_qs = llhd.sig %false : i1
    %control_low_power_hint_qs = llhd.sig %false : i1
    %control_core_clk_en_qs = llhd.sig %false : i1
    %control_io_clk_en_qs = llhd.sig %false : i1
    %control_usb_clk_en_lp_qs = llhd.sig %false : i1
    %control_usb_clk_en_active_qs = llhd.sig %false : i1
    %control_main_pd_n_qs = llhd.sig %false : i1
    %cfg_cdc_sync_we = llhd.sig %false : i1
    %cfg_cdc_sync_qs = llhd.sig %false : i1
    %wakeup_en_regwen_we = llhd.sig %false : i1
    %wakeup_en_regwen_qs = llhd.sig %false : i1
    %wakeup_en_en_0_qs = llhd.sig %false : i1
    %wakeup_en_en_1_qs = llhd.sig %false : i1
    %wakeup_en_en_2_qs = llhd.sig %false : i1
    %wakeup_en_en_3_qs = llhd.sig %false : i1
    %wakeup_en_en_4_qs = llhd.sig %false : i1
    %wakeup_en_en_5_qs = llhd.sig %false : i1
    %wake_status_val_0_qs = llhd.sig %false : i1
    %wake_status_val_1_qs = llhd.sig %false : i1
    %wake_status_val_2_qs = llhd.sig %false : i1
    %wake_status_val_3_qs = llhd.sig %false : i1
    %wake_status_val_4_qs = llhd.sig %false : i1
    %wake_status_val_5_qs = llhd.sig %false : i1
    %reset_en_regwen_we = llhd.sig %false : i1
    %reset_en_regwen_qs = llhd.sig %false : i1
    %reset_en_en_0_qs = llhd.sig %false : i1
    %reset_en_en_1_qs = llhd.sig %false : i1
    %reset_status_val_0_qs = llhd.sig %false : i1
    %reset_status_val_1_qs = llhd.sig %false : i1
    %escalate_reset_status_qs = llhd.sig %false : i1
    %wake_info_capture_dis_we = llhd.sig %false : i1
    %wake_info_capture_dis_qs = llhd.sig %false : i1
    %wake_info_we = llhd.sig %false : i1
    %wake_info_reasons_qs = llhd.sig %c0_i6 : i6
    %wake_info_fall_through_qs = llhd.sig %false : i1
    %wake_info_abort_qs = llhd.sig %false : i1
    %fault_status_reg_intg_err_qs = llhd.sig %false : i1
    %fault_status_esc_timeout_qs = llhd.sig %false : i1
    %fault_status_main_pd_glitch_qs = llhd.sig %false : i1
    %intr_test_flds_we = llhd.sig %false : i1
    %alert_test_flds_we = llhd.sig %false : i1
    %control_gated_we = llhd.sig %false : i1
    %cfg_cdc_sync_flds_we = llhd.sig %false : i1
    %wakeup_en_gated_we = llhd.sig %false : i1
    %reset_en_gated_we = llhd.sig %false : i1
    %wake_info_flds_we = llhd.sig %c0_i3 : i3
    %addr_hit = llhd.sig %c0_i17 : i17
    %u_chk.err_o = hw.instance "u_chk" @tlul_cmd_intg_chk(tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> (err_o: i1)
    llhd.drv %intg_err, %u_chk.err_o after %1 : i1
    %5 = llhd.prb %reg_we_check : i17
    %6 = llhd.prb %reg_we : i1
    %7 = comb.xor %117, %true : i1
    %8 = comb.and %6, %7 : i1
    %u_prim_reg_we_check.err_o = hw.instance "u_prim_reg_we_check" @prim_reg_we_check(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, oh_i: %5: i17, en_i: %8: i1) -> (err_o: i1)
    llhd.drv %reg_we_err, %u_prim_reg_we_check.err_o after %1 : i1
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen(tl_i: %u_reg_if.tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
    %u_reg_if.tl_o, %u_reg_if.intg_error_o, %u_reg_if.re_o, %u_reg_if.we_o, %u_reg_if.addr_o, %u_reg_if.wdata_o, %u_reg_if.be_o = hw.instance "u_reg_if" @tlul_adapter_reg(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, en_ifetch_i: %c-7_i4: i4, busy_i: %false: i1, rdata_i: %94: i32, error_i: %96: i1) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, intg_error_o: i1, re_o: i1, we_o: i1, addr_o: i7, wdata_o: i32, be_o: i4) {sv.namehint = "reg_re"}
    llhd.drv %reg_we, %u_reg_if.we_o after %1 : i1
    llhd.drv %reg_addr, %u_reg_if.addr_o after %1 : i7
    llhd.drv %reg_be, %u_reg_if.be_o after %1 : i4
    %9 = llhd.prb %intr_state_we : i1
    %intr_state = hw.struct_extract %hw2reg["intr_state"] : !hw.struct<intr_state: !hw.struct<d: i1, de: i1>, ctrl_cfg_regwen: !hw.struct<d: i1>, control: !hw.struct<low_power_hint: !hw.struct<d: i1, de: i1>>, cfg_cdc_sync: !hw.struct<d: i1, de: i1>, wake_status: !hw.array<6xstruct<d: i1, de: i1>>, reset_status: !hw.array<2xstruct<d: i1, de: i1>>, escalate_reset_status: !hw.struct<d: i1, de: i1>, wake_info: !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %de = hw.struct_extract %intr_state["de"] : !hw.struct<d: i1, de: i1>
    %d = hw.struct_extract %intr_state["d"] : !hw.struct<d: i1, de: i1>
    %10 = llhd.sig.struct_extract %reg2hw["intr_state"] : <!hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>>
    %11 = llhd.sig.struct_extract %10["q"] : <!hw.struct<q: i1>>
    %u_intr_state.qe, %u_intr_state.q, %u_intr_state.ds, %u_intr_state.qs = hw.instance "u_intr_state" @prim_subreg(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %9: i1, wd: %122: i1, de: %de: i1, d: %d: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %11, %u_intr_state.q after %1 : i1
    llhd.drv %intr_state_qs, %u_intr_state.qs after %1 : i1
    %12 = llhd.prb %intr_enable_we : i1
    %13 = llhd.sig.struct_extract %reg2hw["intr_enable"] : <!hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>>
    %14 = llhd.sig.struct_extract %13["q"] : <!hw.struct<q: i1>>
    %u_intr_enable.qe, %u_intr_enable.q, %u_intr_enable.ds, %u_intr_enable.qs = hw.instance "u_intr_enable" @prim_subreg_1(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %12: i1, wd: %122: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %14, %u_intr_enable.q after %1 : i1
    llhd.drv %intr_enable_qs, %u_intr_enable.qs after %1 : i1
    %15 = llhd.prb %intr_test_we : i1
    %16 = llhd.sig.struct_extract %reg2hw["intr_test"] : <!hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>>
    %17 = llhd.sig.struct_extract %16["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_intr_test.qe, %u_intr_test.qre, %u_intr_test.q, %u_intr_test.ds, %u_intr_test.qs = hw.instance "u_intr_test" @prim_subreg_ext(re: %false: i1, we: %15: i1, wd: %122: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %intr_test_flds_we, %u_intr_test.qe after %1 : i1
    llhd.drv %17, %u_intr_test.q after %1 : i1
    %18 = llhd.prb %alert_test_we : i1
    %19 = llhd.sig.struct_extract %reg2hw["alert_test"] : <!hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>>
    %20 = llhd.sig.struct_extract %19["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_alert_test.qe, %u_alert_test.qre, %u_alert_test.q, %u_alert_test.ds, %u_alert_test.qs = hw.instance "u_alert_test" @prim_subreg_ext(re: %false: i1, we: %18: i1, wd: %122: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %alert_test_flds_we, %u_alert_test.qe after %1 : i1
    llhd.drv %20, %u_alert_test.q after %1 : i1
    %ctrl_cfg_regwen = hw.struct_extract %hw2reg["ctrl_cfg_regwen"] : !hw.struct<intr_state: !hw.struct<d: i1, de: i1>, ctrl_cfg_regwen: !hw.struct<d: i1>, control: !hw.struct<low_power_hint: !hw.struct<d: i1, de: i1>>, cfg_cdc_sync: !hw.struct<d: i1, de: i1>, wake_status: !hw.array<6xstruct<d: i1, de: i1>>, reset_status: !hw.array<2xstruct<d: i1, de: i1>>, escalate_reset_status: !hw.struct<d: i1, de: i1>, wake_info: !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %d_2 = hw.struct_extract %ctrl_cfg_regwen["d"] : !hw.struct<d: i1>
    %u_ctrl_cfg_regwen.qe, %u_ctrl_cfg_regwen.qre, %u_ctrl_cfg_regwen.q, %u_ctrl_cfg_regwen.ds, %u_ctrl_cfg_regwen.qs = hw.instance "u_ctrl_cfg_regwen" @prim_subreg_ext(re: %130: i1, we: %false: i1, wd: %false: i1, d: %d_2: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %ctrl_cfg_regwen_qs, %u_ctrl_cfg_regwen.qs after %1 : i1
    %21 = llhd.prb %control_gated_we : i1
    %control = hw.struct_extract %hw2reg["control"] : !hw.struct<intr_state: !hw.struct<d: i1, de: i1>, ctrl_cfg_regwen: !hw.struct<d: i1>, control: !hw.struct<low_power_hint: !hw.struct<d: i1, de: i1>>, cfg_cdc_sync: !hw.struct<d: i1, de: i1>, wake_status: !hw.array<6xstruct<d: i1, de: i1>>, reset_status: !hw.array<2xstruct<d: i1, de: i1>>, escalate_reset_status: !hw.struct<d: i1, de: i1>, wake_info: !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %low_power_hint = hw.struct_extract %control["low_power_hint"] : !hw.struct<low_power_hint: !hw.struct<d: i1, de: i1>>
    %de_3 = hw.struct_extract %low_power_hint["de"] : !hw.struct<d: i1, de: i1>
    %d_4 = hw.struct_extract %low_power_hint["d"] : !hw.struct<d: i1, de: i1>
    %22 = llhd.sig.struct_extract %reg2hw["control"] : <!hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>>
    %23 = llhd.sig.struct_extract %22["low_power_hint"] : <!hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>>
    %24 = llhd.sig.struct_extract %23["q"] : <!hw.struct<q: i1>>
    %u_control_low_power_hint.qe, %u_control_low_power_hint.q, %u_control_low_power_hint.ds, %u_control_low_power_hint.qs = hw.instance "u_control_low_power_hint" @prim_subreg_1(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %21: i1, wd: %122: i1, de: %de_3: i1, d: %d_4: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %24, %u_control_low_power_hint.q after %1 : i1
    llhd.drv %control_low_power_hint_qs, %u_control_low_power_hint.qs after %1 : i1
    %25 = llhd.sig.struct_extract %22["core_clk_en"] : <!hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>>
    %26 = llhd.sig.struct_extract %25["q"] : <!hw.struct<q: i1>>
    %u_control_core_clk_en.qe, %u_control_core_clk_en.q, %u_control_core_clk_en.ds, %u_control_core_clk_en.qs = hw.instance "u_control_core_clk_en" @prim_subreg_1(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %21: i1, wd: %132: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %26, %u_control_core_clk_en.q after %1 : i1
    llhd.drv %control_core_clk_en_qs, %u_control_core_clk_en.qs after %1 : i1
    %27 = llhd.sig.struct_extract %22["io_clk_en"] : <!hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>>
    %28 = llhd.sig.struct_extract %27["q"] : <!hw.struct<q: i1>>
    %u_control_io_clk_en.qe, %u_control_io_clk_en.q, %u_control_io_clk_en.ds, %u_control_io_clk_en.qs = hw.instance "u_control_io_clk_en" @prim_subreg_1(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %21: i1, wd: %133: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %28, %u_control_io_clk_en.q after %1 : i1
    llhd.drv %control_io_clk_en_qs, %u_control_io_clk_en.qs after %1 : i1
    %29 = llhd.sig.struct_extract %22["usb_clk_en_lp"] : <!hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>>
    %30 = llhd.sig.struct_extract %29["q"] : <!hw.struct<q: i1>>
    %u_control_usb_clk_en_lp.qe, %u_control_usb_clk_en_lp.q, %u_control_usb_clk_en_lp.ds, %u_control_usb_clk_en_lp.qs = hw.instance "u_control_usb_clk_en_lp" @prim_subreg_1(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %21: i1, wd: %134: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %30, %u_control_usb_clk_en_lp.q after %1 : i1
    llhd.drv %control_usb_clk_en_lp_qs, %u_control_usb_clk_en_lp.qs after %1 : i1
    %31 = llhd.sig.struct_extract %22["usb_clk_en_active"] : <!hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>>
    %32 = llhd.sig.struct_extract %31["q"] : <!hw.struct<q: i1>>
    %u_control_usb_clk_en_active.qe, %u_control_usb_clk_en_active.q, %u_control_usb_clk_en_active.ds, %u_control_usb_clk_en_active.qs = hw.instance "u_control_usb_clk_en_active" @prim_subreg_2(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %21: i1, wd: %135: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %32, %u_control_usb_clk_en_active.q after %1 : i1
    llhd.drv %control_usb_clk_en_active_qs, %u_control_usb_clk_en_active.qs after %1 : i1
    %33 = llhd.sig.struct_extract %22["main_pd_n"] : <!hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>>
    %34 = llhd.sig.struct_extract %33["q"] : <!hw.struct<q: i1>>
    %u_control_main_pd_n.qe, %u_control_main_pd_n.q, %u_control_main_pd_n.ds, %u_control_main_pd_n.qs = hw.instance "u_control_main_pd_n" @prim_subreg_2(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %21: i1, wd: %136: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %34, %u_control_main_pd_n.q after %1 : i1
    llhd.drv %control_main_pd_n_qs, %u_control_main_pd_n.qs after %1 : i1
    %35 = llhd.prb %cfg_cdc_sync_flds_we : i1
    %u_cfg_cdc_sync0_qe.q_o = hw.instance "u_cfg_cdc_sync0_qe" @prim_flop(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %35: i1) -> (q_o: i1) {sv.namehint = "cfg_cdc_sync_qe"}
    %36 = llhd.prb %cfg_cdc_sync_we : i1
    %cfg_cdc_sync = hw.struct_extract %hw2reg["cfg_cdc_sync"] : !hw.struct<intr_state: !hw.struct<d: i1, de: i1>, ctrl_cfg_regwen: !hw.struct<d: i1>, control: !hw.struct<low_power_hint: !hw.struct<d: i1, de: i1>>, cfg_cdc_sync: !hw.struct<d: i1, de: i1>, wake_status: !hw.array<6xstruct<d: i1, de: i1>>, reset_status: !hw.array<2xstruct<d: i1, de: i1>>, escalate_reset_status: !hw.struct<d: i1, de: i1>, wake_info: !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %de_5 = hw.struct_extract %cfg_cdc_sync["de"] : !hw.struct<d: i1, de: i1>
    %d_6 = hw.struct_extract %cfg_cdc_sync["d"] : !hw.struct<d: i1, de: i1>
    %37 = llhd.sig.struct_extract %reg2hw["cfg_cdc_sync"] : <!hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>>
    %38 = llhd.sig.struct_extract %37["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_cfg_cdc_sync.qe, %u_cfg_cdc_sync.q, %u_cfg_cdc_sync.ds, %u_cfg_cdc_sync.qs = hw.instance "u_cfg_cdc_sync" @prim_subreg_1(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %36: i1, wd: %122: i1, de: %de_5: i1, d: %d_6: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %cfg_cdc_sync_flds_we, %u_cfg_cdc_sync.qe after %1 : i1
    llhd.drv %38, %u_cfg_cdc_sync.q after %1 : i1
    llhd.drv %cfg_cdc_sync_qs, %u_cfg_cdc_sync.qs after %1 : i1
    %39 = llhd.prb %wakeup_en_regwen_we : i1
    %u_wakeup_en_regwen.qe, %u_wakeup_en_regwen.q, %u_wakeup_en_regwen.ds, %u_wakeup_en_regwen.qs = hw.instance "u_wakeup_en_regwen" @prim_subreg_3(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %39: i1, wd: %122: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %wakeup_en_regwen_qs, %u_wakeup_en_regwen.qs after %1 : i1
    %40 = llhd.prb %wakeup_en_gated_we : i1
    %41 = llhd.sig.struct_extract %reg2hw["wakeup_en"] : <!hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>>
    %42 = llhd.sig.array_get %41[%c0_i3] : <!hw.array<6xstruct<q: i1>>>
    %43 = llhd.sig.struct_extract %42["q"] : <!hw.struct<q: i1>>
    %u_wakeup_en_en_0.qe, %u_wakeup_en_en_0.q, %u_wakeup_en_en_0.ds, %u_wakeup_en_en_0.qs = hw.instance "u_wakeup_en_en_0" @prim_subreg_1(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %40: i1, wd: %122: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %43, %u_wakeup_en_en_0.q after %1 : i1
    llhd.drv %wakeup_en_en_0_qs, %u_wakeup_en_en_0.qs after %1 : i1
    %44 = llhd.sig.array_get %41[%c1_i3] : <!hw.array<6xstruct<q: i1>>>
    %45 = llhd.sig.struct_extract %44["q"] : <!hw.struct<q: i1>>
    %u_wakeup_en_en_1.qe, %u_wakeup_en_en_1.q, %u_wakeup_en_en_1.ds, %u_wakeup_en_en_1.qs = hw.instance "u_wakeup_en_en_1" @prim_subreg_1(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %40: i1, wd: %142: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %45, %u_wakeup_en_en_1.q after %1 : i1
    llhd.drv %wakeup_en_en_1_qs, %u_wakeup_en_en_1.qs after %1 : i1
    %46 = llhd.sig.array_get %41[%c2_i3] : <!hw.array<6xstruct<q: i1>>>
    %47 = llhd.sig.struct_extract %46["q"] : <!hw.struct<q: i1>>
    %u_wakeup_en_en_2.qe, %u_wakeup_en_en_2.q, %u_wakeup_en_en_2.ds, %u_wakeup_en_en_2.qs = hw.instance "u_wakeup_en_en_2" @prim_subreg_1(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %40: i1, wd: %143: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %47, %u_wakeup_en_en_2.q after %1 : i1
    llhd.drv %wakeup_en_en_2_qs, %u_wakeup_en_en_2.qs after %1 : i1
    %48 = llhd.sig.array_get %41[%c3_i3] : <!hw.array<6xstruct<q: i1>>>
    %49 = llhd.sig.struct_extract %48["q"] : <!hw.struct<q: i1>>
    %u_wakeup_en_en_3.qe, %u_wakeup_en_en_3.q, %u_wakeup_en_en_3.ds, %u_wakeup_en_en_3.qs = hw.instance "u_wakeup_en_en_3" @prim_subreg_1(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %40: i1, wd: %144: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %49, %u_wakeup_en_en_3.q after %1 : i1
    llhd.drv %wakeup_en_en_3_qs, %u_wakeup_en_en_3.qs after %1 : i1
    %50 = llhd.sig.array_get %41[%c-4_i3] : <!hw.array<6xstruct<q: i1>>>
    %51 = llhd.sig.struct_extract %50["q"] : <!hw.struct<q: i1>>
    %u_wakeup_en_en_4.qe, %u_wakeup_en_en_4.q, %u_wakeup_en_en_4.ds, %u_wakeup_en_en_4.qs = hw.instance "u_wakeup_en_en_4" @prim_subreg_1(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %40: i1, wd: %132: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %51, %u_wakeup_en_en_4.q after %1 : i1
    llhd.drv %wakeup_en_en_4_qs, %u_wakeup_en_en_4.qs after %1 : i1
    %52 = llhd.sig.array_get %41[%c-3_i3] : <!hw.array<6xstruct<q: i1>>>
    %53 = llhd.sig.struct_extract %52["q"] : <!hw.struct<q: i1>>
    %u_wakeup_en_en_5.qe, %u_wakeup_en_en_5.q, %u_wakeup_en_en_5.ds, %u_wakeup_en_en_5.qs = hw.instance "u_wakeup_en_en_5" @prim_subreg_1(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %40: i1, wd: %133: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %53, %u_wakeup_en_en_5.q after %1 : i1
    llhd.drv %wakeup_en_en_5_qs, %u_wakeup_en_en_5.qs after %1 : i1
    %wake_status = hw.struct_extract %hw2reg["wake_status"] : !hw.struct<intr_state: !hw.struct<d: i1, de: i1>, ctrl_cfg_regwen: !hw.struct<d: i1>, control: !hw.struct<low_power_hint: !hw.struct<d: i1, de: i1>>, cfg_cdc_sync: !hw.struct<d: i1, de: i1>, wake_status: !hw.array<6xstruct<d: i1, de: i1>>, reset_status: !hw.array<2xstruct<d: i1, de: i1>>, escalate_reset_status: !hw.struct<d: i1, de: i1>, wake_info: !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %54 = hw.array_get %wake_status[%c0_i3] : !hw.array<6xstruct<d: i1, de: i1>>, i3
    %de_7 = hw.struct_extract %54["de"] : !hw.struct<d: i1, de: i1>
    %d_8 = hw.struct_extract %54["d"] : !hw.struct<d: i1, de: i1>
    %u_wake_status_val_0.qe, %u_wake_status_val_0.q, %u_wake_status_val_0.ds, %u_wake_status_val_0.qs = hw.instance "u_wake_status_val_0" @prim_subreg_4(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %false: i1, wd: %false: i1, de: %de_7: i1, d: %d_8: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %wake_status_val_0_qs, %u_wake_status_val_0.qs after %1 : i1
    %55 = hw.array_get %wake_status[%c1_i3] : !hw.array<6xstruct<d: i1, de: i1>>, i3
    %de_9 = hw.struct_extract %55["de"] : !hw.struct<d: i1, de: i1>
    %d_10 = hw.struct_extract %55["d"] : !hw.struct<d: i1, de: i1>
    %u_wake_status_val_1.qe, %u_wake_status_val_1.q, %u_wake_status_val_1.ds, %u_wake_status_val_1.qs = hw.instance "u_wake_status_val_1" @prim_subreg_4(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %false: i1, wd: %false: i1, de: %de_9: i1, d: %d_10: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %wake_status_val_1_qs, %u_wake_status_val_1.qs after %1 : i1
    %56 = hw.array_get %wake_status[%c2_i3] : !hw.array<6xstruct<d: i1, de: i1>>, i3
    %de_11 = hw.struct_extract %56["de"] : !hw.struct<d: i1, de: i1>
    %d_12 = hw.struct_extract %56["d"] : !hw.struct<d: i1, de: i1>
    %u_wake_status_val_2.qe, %u_wake_status_val_2.q, %u_wake_status_val_2.ds, %u_wake_status_val_2.qs = hw.instance "u_wake_status_val_2" @prim_subreg_4(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %false: i1, wd: %false: i1, de: %de_11: i1, d: %d_12: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %wake_status_val_2_qs, %u_wake_status_val_2.qs after %1 : i1
    %57 = hw.array_get %wake_status[%c3_i3] : !hw.array<6xstruct<d: i1, de: i1>>, i3
    %de_13 = hw.struct_extract %57["de"] : !hw.struct<d: i1, de: i1>
    %d_14 = hw.struct_extract %57["d"] : !hw.struct<d: i1, de: i1>
    %u_wake_status_val_3.qe, %u_wake_status_val_3.q, %u_wake_status_val_3.ds, %u_wake_status_val_3.qs = hw.instance "u_wake_status_val_3" @prim_subreg_4(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %false: i1, wd: %false: i1, de: %de_13: i1, d: %d_14: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %wake_status_val_3_qs, %u_wake_status_val_3.qs after %1 : i1
    %58 = hw.array_get %wake_status[%c-4_i3] : !hw.array<6xstruct<d: i1, de: i1>>, i3
    %de_15 = hw.struct_extract %58["de"] : !hw.struct<d: i1, de: i1>
    %d_16 = hw.struct_extract %58["d"] : !hw.struct<d: i1, de: i1>
    %u_wake_status_val_4.qe, %u_wake_status_val_4.q, %u_wake_status_val_4.ds, %u_wake_status_val_4.qs = hw.instance "u_wake_status_val_4" @prim_subreg_4(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %false: i1, wd: %false: i1, de: %de_15: i1, d: %d_16: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %wake_status_val_4_qs, %u_wake_status_val_4.qs after %1 : i1
    %59 = hw.array_get %wake_status[%c-3_i3] : !hw.array<6xstruct<d: i1, de: i1>>, i3
    %de_17 = hw.struct_extract %59["de"] : !hw.struct<d: i1, de: i1>
    %d_18 = hw.struct_extract %59["d"] : !hw.struct<d: i1, de: i1>
    %u_wake_status_val_5.qe, %u_wake_status_val_5.q, %u_wake_status_val_5.ds, %u_wake_status_val_5.qs = hw.instance "u_wake_status_val_5" @prim_subreg_4(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %false: i1, wd: %false: i1, de: %de_17: i1, d: %d_18: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %wake_status_val_5_qs, %u_wake_status_val_5.qs after %1 : i1
    %60 = llhd.prb %reset_en_regwen_we : i1
    %u_reset_en_regwen.qe, %u_reset_en_regwen.q, %u_reset_en_regwen.ds, %u_reset_en_regwen.qs = hw.instance "u_reset_en_regwen" @prim_subreg_3(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %60: i1, wd: %122: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %reset_en_regwen_qs, %u_reset_en_regwen.qs after %1 : i1
    %61 = llhd.prb %reset_en_gated_we : i1
    %62 = llhd.sig.struct_extract %reg2hw["reset_en"] : <!hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>>
    %63 = llhd.sig.struct_extract %62["en_0"] : <!hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>>
    %64 = llhd.sig.struct_extract %63["q"] : <!hw.struct<q: i1>>
    %u_reset_en_en_0.qe, %u_reset_en_en_0.q, %u_reset_en_en_0.ds, %u_reset_en_en_0.qs = hw.instance "u_reset_en_en_0" @prim_subreg_1(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %61: i1, wd: %122: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %64, %u_reset_en_en_0.q after %1 : i1
    llhd.drv %reset_en_en_0_qs, %u_reset_en_en_0.qs after %1 : i1
    %65 = llhd.sig.struct_extract %62["en_1"] : <!hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>>
    %66 = llhd.sig.struct_extract %65["q"] : <!hw.struct<q: i1>>
    %u_reset_en_en_1.qe, %u_reset_en_en_1.q, %u_reset_en_en_1.ds, %u_reset_en_en_1.qs = hw.instance "u_reset_en_en_1" @prim_subreg_1(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %61: i1, wd: %142: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %66, %u_reset_en_en_1.q after %1 : i1
    llhd.drv %reset_en_en_1_qs, %u_reset_en_en_1.qs after %1 : i1
    %reset_status = hw.struct_extract %hw2reg["reset_status"] : !hw.struct<intr_state: !hw.struct<d: i1, de: i1>, ctrl_cfg_regwen: !hw.struct<d: i1>, control: !hw.struct<low_power_hint: !hw.struct<d: i1, de: i1>>, cfg_cdc_sync: !hw.struct<d: i1, de: i1>, wake_status: !hw.array<6xstruct<d: i1, de: i1>>, reset_status: !hw.array<2xstruct<d: i1, de: i1>>, escalate_reset_status: !hw.struct<d: i1, de: i1>, wake_info: !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %67 = hw.array_get %reset_status[%false] : !hw.array<2xstruct<d: i1, de: i1>>, i1
    %de_19 = hw.struct_extract %67["de"] : !hw.struct<d: i1, de: i1>
    %d_20 = hw.struct_extract %67["d"] : !hw.struct<d: i1, de: i1>
    %u_reset_status_val_0.qe, %u_reset_status_val_0.q, %u_reset_status_val_0.ds, %u_reset_status_val_0.qs = hw.instance "u_reset_status_val_0" @prim_subreg_4(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %false: i1, wd: %false: i1, de: %de_19: i1, d: %d_20: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %reset_status_val_0_qs, %u_reset_status_val_0.qs after %1 : i1
    %68 = hw.array_get %reset_status[%true] : !hw.array<2xstruct<d: i1, de: i1>>, i1
    %de_21 = hw.struct_extract %68["de"] : !hw.struct<d: i1, de: i1>
    %d_22 = hw.struct_extract %68["d"] : !hw.struct<d: i1, de: i1>
    %u_reset_status_val_1.qe, %u_reset_status_val_1.q, %u_reset_status_val_1.ds, %u_reset_status_val_1.qs = hw.instance "u_reset_status_val_1" @prim_subreg_4(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %false: i1, wd: %false: i1, de: %de_21: i1, d: %d_22: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %reset_status_val_1_qs, %u_reset_status_val_1.qs after %1 : i1
    %escalate_reset_status = hw.struct_extract %hw2reg["escalate_reset_status"] : !hw.struct<intr_state: !hw.struct<d: i1, de: i1>, ctrl_cfg_regwen: !hw.struct<d: i1>, control: !hw.struct<low_power_hint: !hw.struct<d: i1, de: i1>>, cfg_cdc_sync: !hw.struct<d: i1, de: i1>, wake_status: !hw.array<6xstruct<d: i1, de: i1>>, reset_status: !hw.array<2xstruct<d: i1, de: i1>>, escalate_reset_status: !hw.struct<d: i1, de: i1>, wake_info: !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %de_23 = hw.struct_extract %escalate_reset_status["de"] : !hw.struct<d: i1, de: i1>
    %d_24 = hw.struct_extract %escalate_reset_status["d"] : !hw.struct<d: i1, de: i1>
    %u_escalate_reset_status.qe, %u_escalate_reset_status.q, %u_escalate_reset_status.ds, %u_escalate_reset_status.qs = hw.instance "u_escalate_reset_status" @prim_subreg_4(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %false: i1, wd: %false: i1, de: %de_23: i1, d: %d_24: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %escalate_reset_status_qs, %u_escalate_reset_status.qs after %1 : i1
    %69 = llhd.prb %wake_info_capture_dis_we : i1
    %70 = llhd.sig.struct_extract %reg2hw["wake_info_capture_dis"] : <!hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>>
    %71 = llhd.sig.struct_extract %70["q"] : <!hw.struct<q: i1>>
    %u_wake_info_capture_dis.qe, %u_wake_info_capture_dis.q, %u_wake_info_capture_dis.ds, %u_wake_info_capture_dis.qs = hw.instance "u_wake_info_capture_dis" @prim_subreg_1(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, we: %69: i1, wd: %122: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %71, %u_wake_info_capture_dis.q after %1 : i1
    llhd.drv %wake_info_capture_dis_qs, %u_wake_info_capture_dis.qs after %1 : i1
    %72 = llhd.prb %wake_info_we : i1
    %wake_info = hw.struct_extract %hw2reg["wake_info"] : !hw.struct<intr_state: !hw.struct<d: i1, de: i1>, ctrl_cfg_regwen: !hw.struct<d: i1>, control: !hw.struct<low_power_hint: !hw.struct<d: i1, de: i1>>, cfg_cdc_sync: !hw.struct<d: i1, de: i1>, wake_status: !hw.array<6xstruct<d: i1, de: i1>>, reset_status: !hw.array<2xstruct<d: i1, de: i1>>, escalate_reset_status: !hw.struct<d: i1, de: i1>, wake_info: !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %reasons = hw.struct_extract %wake_info["reasons"] : !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>
    %d_25 = hw.struct_extract %reasons["d"] : !hw.struct<d: i6>
    %73 = llhd.sig.extract %wake_info_flds_we from %c0_i2 : <i3> -> <i1>
    %74 = llhd.sig.struct_extract %reg2hw["wake_info"] : <!hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>>
    %75 = llhd.sig.struct_extract %74["reasons"] : <!hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>>
    %76 = llhd.sig.struct_extract %75["q"] : <!hw.struct<q: i6, qe: i1>>
    %u_wake_info_reasons.qe, %u_wake_info_reasons.qre, %u_wake_info_reasons.q, %u_wake_info_reasons.ds, %u_wake_info_reasons.qs = hw.instance "u_wake_info_reasons" @prim_subreg_ext_5(re: %151: i1, we: %72: i1, wd: %153: i6, d: %d_25: i6) -> (qe: i1, qre: i1, q: i6, ds: i6, qs: i6)
    llhd.drv %73, %u_wake_info_reasons.qe after %1 : i1
    llhd.drv %76, %u_wake_info_reasons.q after %1 : i6
    llhd.drv %wake_info_reasons_qs, %u_wake_info_reasons.qs after %1 : i6
    %fall_through = hw.struct_extract %wake_info["fall_through"] : !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>
    %d_26 = hw.struct_extract %fall_through["d"] : !hw.struct<d: i1>
    %77 = llhd.sig.extract %wake_info_flds_we from %c1_i2 : <i3> -> <i1>
    %78 = llhd.sig.struct_extract %74["fall_through"] : <!hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>>
    %79 = llhd.sig.struct_extract %78["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_wake_info_fall_through.qe, %u_wake_info_fall_through.qre, %u_wake_info_fall_through.q, %u_wake_info_fall_through.ds, %u_wake_info_fall_through.qs = hw.instance "u_wake_info_fall_through" @prim_subreg_ext(re: %151: i1, we: %72: i1, wd: %134: i1, d: %d_26: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %77, %u_wake_info_fall_through.qe after %1 : i1
    llhd.drv %79, %u_wake_info_fall_through.q after %1 : i1
    llhd.drv %wake_info_fall_through_qs, %u_wake_info_fall_through.qs after %1 : i1
    %abort = hw.struct_extract %wake_info["abort"] : !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>
    %d_27 = hw.struct_extract %abort["d"] : !hw.struct<d: i1>
    %80 = llhd.sig.extract %wake_info_flds_we from %c-2_i2 : <i3> -> <i1>
    %81 = llhd.sig.struct_extract %74["abort"] : <!hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>>
    %82 = llhd.sig.struct_extract %81["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_wake_info_abort.qe, %u_wake_info_abort.qre, %u_wake_info_abort.q, %u_wake_info_abort.ds, %u_wake_info_abort.qs = hw.instance "u_wake_info_abort" @prim_subreg_ext(re: %151: i1, we: %72: i1, wd: %135: i1, d: %d_27: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %80, %u_wake_info_abort.qe after %1 : i1
    llhd.drv %82, %u_wake_info_abort.q after %1 : i1
    llhd.drv %wake_info_abort_qs, %u_wake_info_abort.qs after %1 : i1
    %fault_status = hw.struct_extract %hw2reg["fault_status"] : !hw.struct<intr_state: !hw.struct<d: i1, de: i1>, ctrl_cfg_regwen: !hw.struct<d: i1>, control: !hw.struct<low_power_hint: !hw.struct<d: i1, de: i1>>, cfg_cdc_sync: !hw.struct<d: i1, de: i1>, wake_status: !hw.array<6xstruct<d: i1, de: i1>>, reset_status: !hw.array<2xstruct<d: i1, de: i1>>, escalate_reset_status: !hw.struct<d: i1, de: i1>, wake_info: !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %reg_intg_err = hw.struct_extract %fault_status["reg_intg_err"] : !hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>
    %de_28 = hw.struct_extract %reg_intg_err["de"] : !hw.struct<d: i1, de: i1>
    %d_29 = hw.struct_extract %reg_intg_err["d"] : !hw.struct<d: i1, de: i1>
    %83 = llhd.sig.struct_extract %reg2hw["fault_status"] : <!hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>>
    %84 = llhd.sig.struct_extract %83["reg_intg_err"] : <!hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %85 = llhd.sig.struct_extract %84["q"] : <!hw.struct<q: i1>>
    %u_fault_status_reg_intg_err.qe, %u_fault_status_reg_intg_err.q, %u_fault_status_reg_intg_err.ds, %u_fault_status_reg_intg_err.qs = hw.instance "u_fault_status_reg_intg_err" @prim_subreg_4(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_28: i1, d: %d_29: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %85, %u_fault_status_reg_intg_err.q after %1 : i1
    llhd.drv %fault_status_reg_intg_err_qs, %u_fault_status_reg_intg_err.qs after %1 : i1
    %esc_timeout = hw.struct_extract %fault_status["esc_timeout"] : !hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>
    %de_30 = hw.struct_extract %esc_timeout["de"] : !hw.struct<d: i1, de: i1>
    %d_31 = hw.struct_extract %esc_timeout["d"] : !hw.struct<d: i1, de: i1>
    %86 = llhd.sig.struct_extract %83["esc_timeout"] : <!hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %87 = llhd.sig.struct_extract %86["q"] : <!hw.struct<q: i1>>
    %u_fault_status_esc_timeout.qe, %u_fault_status_esc_timeout.q, %u_fault_status_esc_timeout.ds, %u_fault_status_esc_timeout.qs = hw.instance "u_fault_status_esc_timeout" @prim_subreg_4(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_30: i1, d: %d_31: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %87, %u_fault_status_esc_timeout.q after %1 : i1
    llhd.drv %fault_status_esc_timeout_qs, %u_fault_status_esc_timeout.qs after %1 : i1
    %main_pd_glitch = hw.struct_extract %fault_status["main_pd_glitch"] : !hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>
    %de_32 = hw.struct_extract %main_pd_glitch["de"] : !hw.struct<d: i1, de: i1>
    %d_33 = hw.struct_extract %main_pd_glitch["d"] : !hw.struct<d: i1, de: i1>
    %88 = llhd.sig.struct_extract %83["main_pd_glitch"] : <!hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %89 = llhd.sig.struct_extract %88["q"] : <!hw.struct<q: i1>>
    %u_fault_status_main_pd_glitch.qe, %u_fault_status_main_pd_glitch.q, %u_fault_status_main_pd_glitch.ds, %u_fault_status_main_pd_glitch.qs = hw.instance "u_fault_status_main_pd_glitch" @prim_subreg_4(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_32: i1, d: %d_33: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %89, %u_fault_status_main_pd_glitch.q after %1 : i1
    llhd.drv %fault_status_main_pd_glitch_qs, %u_fault_status_main_pd_glitch.qs after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %188 = llhd.prb %clk_lc_i_0 : i1
      %189 = llhd.prb %rst_lc_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %190 = llhd.prb %clk_lc_i_0 : i1
      %191 = comb.xor bin %188, %true : i1
      %192 = comb.and bin %191, %190 : i1
      %193 = llhd.prb %rst_lc_ni_1 : i1
      %194 = comb.xor bin %193, %true : i1
      %195 = comb.and bin %189, %194 : i1
      %196 = comb.or bin %192, %195 : i1
      cf.cond_br %196, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %197 = llhd.prb %rst_lc_ni_1 : i1
      %198 = comb.xor %197, %true : i1
      cf.cond_br %198, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %err_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %199 = llhd.prb %intg_err : i1
      %200 = llhd.prb %reg_we_err : i1
      %201 = comb.or %199, %200 : i1
      cf.cond_br %201, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %err_q, %true after %0 : i1
      cf.br ^bb1
    }
    %90 = llhd.prb %err_q : i1
    %91 = llhd.prb %intg_err : i1
    %92 = llhd.prb %reg_we_err : i1
    %93 = comb.or %90, %91, %92 : i1
    %94 = llhd.prb %reg_rdata_next {sv.namehint = "reg_rdata"} : i32
    %95 = llhd.prb %wr_err : i1
    %96 = comb.or %117, %95, %91 {sv.namehint = "reg_error"} : i1
    %97 = llhd.prb %intr_test_flds_we {sv.namehint = "intr_test_qe"} : i1
    %98 = llhd.sig.struct_extract %16["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %98, %97 after %1 : i1
    %99 = llhd.prb %alert_test_flds_we {sv.namehint = "alert_test_qe"} : i1
    %100 = llhd.sig.struct_extract %19["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %100, %99 after %1 : i1
    %101 = llhd.prb %ctrl_cfg_regwen_qs : i1
    %102 = comb.and %131, %6, %120, %101 : i1
    llhd.drv %control_gated_we, %102 after %1 : i1
    %103 = llhd.sig.struct_extract %37["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %103, %u_cfg_cdc_sync0_qe.q_o after %1 : i1
    %104 = llhd.prb %wakeup_en_regwen_qs : i1
    %105 = comb.and %141, %6, %120, %104 : i1
    llhd.drv %wakeup_en_gated_we, %105 after %1 : i1
    %106 = llhd.prb %reset_en_regwen_qs : i1
    %107 = comb.and %147, %6, %120, %106 : i1
    llhd.drv %reset_en_gated_we, %107 after %1 : i1
    %108 = llhd.prb %wake_info_flds_we : i3
    %109 = comb.icmp eq %108, %c-1_i3 {sv.namehint = "wake_info_qe"} : i3
    %110 = llhd.sig.struct_extract %75["qe"] : <!hw.struct<q: i6, qe: i1>>
    llhd.drv %110, %109 after %1 : i1
    %111 = llhd.sig.struct_extract %78["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %111, %109 after %1 : i1
    %112 = llhd.sig.struct_extract %81["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %112, %109 after %1 : i1
    %113 = llhd.prb %addr_hit : i17
    %114 = llhd.prb %reg_addr : i7
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %188 = llhd.sig.extract %addr_hit from %c0_i5 : <i17> -> <i1>
      %189 = llhd.prb %reg_addr : i7
      %190 = comb.icmp eq %189, %c0_i7 : i7
      llhd.drv %188, %190 after %1 : i1
      %191 = llhd.sig.extract %addr_hit from %c1_i5 : <i17> -> <i1>
      %192 = llhd.prb %reg_addr : i7
      %193 = comb.icmp eq %192, %c4_i7 : i7
      llhd.drv %191, %193 after %1 : i1
      %194 = llhd.sig.extract %addr_hit from %c2_i5 : <i17> -> <i1>
      %195 = llhd.prb %reg_addr : i7
      %196 = comb.icmp eq %195, %c8_i7 : i7
      llhd.drv %194, %196 after %1 : i1
      %197 = llhd.sig.extract %addr_hit from %c3_i5 : <i17> -> <i1>
      %198 = llhd.prb %reg_addr : i7
      %199 = comb.icmp eq %198, %c12_i7 : i7
      llhd.drv %197, %199 after %1 : i1
      %200 = llhd.sig.extract %addr_hit from %c4_i5 : <i17> -> <i1>
      %201 = llhd.prb %reg_addr : i7
      %202 = comb.icmp eq %201, %c16_i7 : i7
      llhd.drv %200, %202 after %1 : i1
      %203 = llhd.sig.extract %addr_hit from %c5_i5 : <i17> -> <i1>
      %204 = llhd.prb %reg_addr : i7
      %205 = comb.icmp eq %204, %c20_i7 : i7
      llhd.drv %203, %205 after %1 : i1
      %206 = llhd.sig.extract %addr_hit from %c6_i5 : <i17> -> <i1>
      %207 = llhd.prb %reg_addr : i7
      %208 = comb.icmp eq %207, %c24_i7 : i7
      llhd.drv %206, %208 after %1 : i1
      %209 = llhd.sig.extract %addr_hit from %c7_i5 : <i17> -> <i1>
      %210 = llhd.prb %reg_addr : i7
      %211 = comb.icmp eq %210, %c28_i7 : i7
      llhd.drv %209, %211 after %1 : i1
      %212 = llhd.sig.extract %addr_hit from %c8_i5 : <i17> -> <i1>
      %213 = llhd.prb %reg_addr : i7
      %214 = comb.icmp eq %213, %c32_i7 : i7
      llhd.drv %212, %214 after %1 : i1
      %215 = llhd.sig.extract %addr_hit from %c9_i5 : <i17> -> <i1>
      %216 = llhd.prb %reg_addr : i7
      %217 = comb.icmp eq %216, %c36_i7 : i7
      llhd.drv %215, %217 after %1 : i1
      %218 = llhd.sig.extract %addr_hit from %c10_i5 : <i17> -> <i1>
      %219 = llhd.prb %reg_addr : i7
      %220 = comb.icmp eq %219, %c40_i7 : i7
      llhd.drv %218, %220 after %1 : i1
      %221 = llhd.sig.extract %addr_hit from %c11_i5 : <i17> -> <i1>
      %222 = llhd.prb %reg_addr : i7
      %223 = comb.icmp eq %222, %c44_i7 : i7
      llhd.drv %221, %223 after %1 : i1
      %224 = llhd.sig.extract %addr_hit from %c12_i5 : <i17> -> <i1>
      %225 = llhd.prb %reg_addr : i7
      %226 = comb.icmp eq %225, %c48_i7 : i7
      llhd.drv %224, %226 after %1 : i1
      %227 = llhd.sig.extract %addr_hit from %c13_i5 : <i17> -> <i1>
      %228 = llhd.prb %reg_addr : i7
      %229 = comb.icmp eq %228, %c52_i7 : i7
      llhd.drv %227, %229 after %1 : i1
      %230 = llhd.sig.extract %addr_hit from %c14_i5 : <i17> -> <i1>
      %231 = llhd.prb %reg_addr : i7
      %232 = comb.icmp eq %231, %c56_i7 : i7
      llhd.drv %230, %232 after %1 : i1
      %233 = llhd.sig.extract %addr_hit from %c15_i5 : <i17> -> <i1>
      %234 = llhd.prb %reg_addr : i7
      %235 = comb.icmp eq %234, %c60_i7 : i7
      llhd.drv %233, %235 after %1 : i1
      %236 = llhd.sig.extract %addr_hit from %c-16_i5 : <i17> -> <i1>
      %237 = llhd.prb %reg_addr : i7
      %238 = comb.icmp eq %237, %c-64_i7 : i7
      llhd.drv %236, %238 after %1 : i1
      llhd.wait (%113, %114 : i17, i7), ^bb1
    }
    %115 = comb.or %u_reg_if.re_o, %6 : i1
    %116 = comb.icmp eq %113, %c0_i17 : i17
    %117 = comb.and %115, %116 {sv.namehint = "addrmiss"} : i1
    %118 = llhd.prb %reg_be : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %188 = llhd.prb %reg_we : i1
      %189 = llhd.prb %addr_hit : i17
      %190 = comb.extract %189 from 0 : (i17) -> i1
      %191 = llhd.prb %reg_be : i4
      %192 = comb.extract %191 from 0 : (i4) -> i2
      %193 = comb.extract %191 from 0 : (i4) -> i1
      %194 = comb.xor %193, %true : i1
      %195 = comb.and %190, %194 : i1
      %196 = comb.extract %189 from 1 : (i17) -> i1
      %197 = comb.and %196, %194 : i1
      %198 = comb.extract %189 from 2 : (i17) -> i1
      %199 = comb.and %198, %194 : i1
      %200 = comb.extract %189 from 3 : (i17) -> i1
      %201 = comb.and %200, %194 : i1
      %202 = comb.extract %189 from 4 : (i17) -> i1
      %203 = comb.and %202, %194 : i1
      %204 = comb.extract %189 from 5 : (i17) -> i1
      %205 = comb.icmp ne %192, %c-1_i2 : i2
      %206 = comb.and %204, %205 : i1
      %207 = comb.extract %189 from 6 : (i17) -> i1
      %208 = comb.and %207, %194 : i1
      %209 = comb.extract %189 from 7 : (i17) -> i1
      %210 = comb.and %209, %194 : i1
      %211 = comb.extract %189 from 8 : (i17) -> i1
      %212 = comb.and %211, %194 : i1
      %213 = comb.extract %189 from 9 : (i17) -> i1
      %214 = comb.and %213, %194 : i1
      %215 = comb.extract %189 from 10 : (i17) -> i1
      %216 = comb.and %215, %194 : i1
      %217 = comb.extract %189 from 11 : (i17) -> i1
      %218 = comb.and %217, %194 : i1
      %219 = comb.extract %189 from 12 : (i17) -> i1
      %220 = comb.and %219, %194 : i1
      %221 = comb.extract %189 from 13 : (i17) -> i1
      %222 = comb.and %221, %194 : i1
      %223 = comb.extract %189 from 14 : (i17) -> i1
      %224 = comb.and %223, %194 : i1
      %225 = comb.extract %189 from 15 : (i17) -> i1
      %226 = comb.and %225, %194 : i1
      %227 = comb.extract %189 from 16 : (i17) -> i1
      %228 = comb.and %227, %194 : i1
      %229 = comb.or %195, %197, %199, %201, %203, %206, %208, %210, %212, %214, %216, %218, %220, %222, %224, %226, %228 : i1
      %230 = comb.and %188, %229 : i1
      llhd.drv %wr_err, %230 after %1 : i1
      llhd.wait (%6, %113, %118, %95 : i1, i17, i4, i1), ^bb1
    }
    %119 = comb.extract %113 from 0 : (i17) -> i1
    %120 = comb.xor %96, %true : i1
    %121 = comb.and %119, %6, %120 : i1
    llhd.drv %intr_state_we, %121 after %1 : i1
    %122 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "intr_test_wd"} : (i32) -> i1
    %123 = comb.extract %113 from 1 : (i17) -> i1
    %124 = comb.and %123, %6, %120 : i1
    llhd.drv %intr_enable_we, %124 after %1 : i1
    %125 = comb.extract %113 from 2 : (i17) -> i1
    %126 = comb.and %125, %6, %120 : i1
    llhd.drv %intr_test_we, %126 after %1 : i1
    %127 = comb.extract %113 from 3 : (i17) -> i1
    %128 = comb.and %127, %6, %120 : i1
    llhd.drv %alert_test_we, %128 after %1 : i1
    %129 = comb.extract %113 from 4 : (i17) -> i1
    %130 = comb.and %129, %u_reg_if.re_o, %120 {sv.namehint = "ctrl_cfg_regwen_re"} : i1
    %131 = comb.extract %113 from 5 : (i17) -> i1
    %132 = comb.extract %u_reg_if.wdata_o from 4 {sv.namehint = "wakeup_en_en_4_wd"} : (i32) -> i1
    %133 = comb.extract %u_reg_if.wdata_o from 5 {sv.namehint = "wakeup_en_en_5_wd"} : (i32) -> i1
    %134 = comb.extract %u_reg_if.wdata_o from 6 {sv.namehint = "wake_info_fall_through_wd"} : (i32) -> i1
    %135 = comb.extract %u_reg_if.wdata_o from 7 {sv.namehint = "wake_info_abort_wd"} : (i32) -> i1
    %136 = comb.extract %u_reg_if.wdata_o from 8 {sv.namehint = "control_main_pd_n_wd"} : (i32) -> i1
    %137 = comb.extract %113 from 6 : (i17) -> i1
    %138 = comb.and %137, %6, %120 : i1
    llhd.drv %cfg_cdc_sync_we, %138 after %1 : i1
    %139 = comb.extract %113 from 7 : (i17) -> i1
    %140 = comb.and %139, %6, %120 : i1
    llhd.drv %wakeup_en_regwen_we, %140 after %1 : i1
    %141 = comb.extract %113 from 8 : (i17) -> i1
    %142 = comb.extract %u_reg_if.wdata_o from 1 {sv.namehint = "reset_en_en_1_wd"} : (i32) -> i1
    %143 = comb.extract %u_reg_if.wdata_o from 2 {sv.namehint = "wakeup_en_en_2_wd"} : (i32) -> i1
    %144 = comb.extract %u_reg_if.wdata_o from 3 {sv.namehint = "wakeup_en_en_3_wd"} : (i32) -> i1
    %145 = comb.extract %113 from 10 : (i17) -> i1
    %146 = comb.and %145, %6, %120 : i1
    llhd.drv %reset_en_regwen_we, %146 after %1 : i1
    %147 = comb.extract %113 from 11 : (i17) -> i1
    %148 = comb.extract %113 from 14 : (i17) -> i1
    %149 = comb.and %148, %6, %120 : i1
    llhd.drv %wake_info_capture_dis_we, %149 after %1 : i1
    %150 = comb.extract %113 from 15 : (i17) -> i1
    %151 = comb.and %150, %u_reg_if.re_o, %120 {sv.namehint = "wake_info_re"} : i1
    %152 = comb.and %150, %6, %120 : i1
    llhd.drv %wake_info_we, %152 after %1 : i1
    %153 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "wake_info_reasons_wd"} : (i32) -> i6
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %188 = llhd.sig.extract %reg_we_check from %c0_i5 : <i17> -> <i1>
      %189 = llhd.prb %intr_state_we : i1
      llhd.drv %188, %189 after %1 : i1
      %190 = llhd.sig.extract %reg_we_check from %c1_i5 : <i17> -> <i1>
      %191 = llhd.prb %intr_enable_we : i1
      llhd.drv %190, %191 after %1 : i1
      %192 = llhd.sig.extract %reg_we_check from %c2_i5 : <i17> -> <i1>
      %193 = llhd.prb %intr_test_we : i1
      llhd.drv %192, %193 after %1 : i1
      %194 = llhd.sig.extract %reg_we_check from %c3_i5 : <i17> -> <i1>
      %195 = llhd.prb %alert_test_we : i1
      llhd.drv %194, %195 after %1 : i1
      %196 = llhd.sig.extract %reg_we_check from %c4_i5 : <i17> -> <i1>
      llhd.drv %196, %false after %1 : i1
      %197 = llhd.sig.extract %reg_we_check from %c5_i5 : <i17> -> <i1>
      %198 = llhd.prb %control_gated_we : i1
      llhd.drv %197, %198 after %1 : i1
      %199 = llhd.sig.extract %reg_we_check from %c6_i5 : <i17> -> <i1>
      %200 = llhd.prb %cfg_cdc_sync_we : i1
      llhd.drv %199, %200 after %1 : i1
      %201 = llhd.sig.extract %reg_we_check from %c7_i5 : <i17> -> <i1>
      %202 = llhd.prb %wakeup_en_regwen_we : i1
      llhd.drv %201, %202 after %1 : i1
      %203 = llhd.sig.extract %reg_we_check from %c8_i5 : <i17> -> <i1>
      %204 = llhd.prb %wakeup_en_gated_we : i1
      llhd.drv %203, %204 after %1 : i1
      %205 = llhd.sig.extract %reg_we_check from %c9_i5 : <i17> -> <i1>
      llhd.drv %205, %false after %1 : i1
      %206 = llhd.sig.extract %reg_we_check from %c10_i5 : <i17> -> <i1>
      %207 = llhd.prb %reset_en_regwen_we : i1
      llhd.drv %206, %207 after %1 : i1
      %208 = llhd.sig.extract %reg_we_check from %c11_i5 : <i17> -> <i1>
      %209 = llhd.prb %reset_en_gated_we : i1
      llhd.drv %208, %209 after %1 : i1
      %210 = llhd.sig.extract %reg_we_check from %c12_i5 : <i17> -> <i1>
      llhd.drv %210, %false after %1 : i1
      %211 = llhd.sig.extract %reg_we_check from %c13_i5 : <i17> -> <i1>
      llhd.drv %211, %false after %1 : i1
      %212 = llhd.sig.extract %reg_we_check from %c14_i5 : <i17> -> <i1>
      %213 = llhd.prb %wake_info_capture_dis_we : i1
      llhd.drv %212, %213 after %1 : i1
      %214 = llhd.sig.extract %reg_we_check from %c15_i5 : <i17> -> <i1>
      %215 = llhd.prb %wake_info_we : i1
      llhd.drv %214, %215 after %1 : i1
      %216 = llhd.sig.extract %reg_we_check from %c-16_i5 : <i17> -> <i1>
      llhd.drv %216, %false after %1 : i1
      llhd.wait (%5, %9, %12, %15, %18, %21, %36, %39, %40, %60, %61, %69, %72 : i17, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    %154 = llhd.prb %intr_state_qs : i1
    %155 = llhd.prb %intr_enable_qs : i1
    %156 = llhd.prb %control_low_power_hint_qs : i1
    %157 = llhd.prb %control_core_clk_en_qs : i1
    %158 = llhd.prb %control_io_clk_en_qs : i1
    %159 = llhd.prb %control_usb_clk_en_lp_qs : i1
    %160 = llhd.prb %control_usb_clk_en_active_qs : i1
    %161 = llhd.prb %control_main_pd_n_qs : i1
    %162 = llhd.prb %cfg_cdc_sync_qs : i1
    %163 = llhd.prb %wakeup_en_en_0_qs : i1
    %164 = llhd.prb %wakeup_en_en_1_qs : i1
    %165 = llhd.prb %wakeup_en_en_2_qs : i1
    %166 = llhd.prb %wakeup_en_en_3_qs : i1
    %167 = llhd.prb %wakeup_en_en_4_qs : i1
    %168 = llhd.prb %wakeup_en_en_5_qs : i1
    %169 = llhd.prb %wake_status_val_0_qs : i1
    %170 = llhd.prb %wake_status_val_1_qs : i1
    %171 = llhd.prb %wake_status_val_2_qs : i1
    %172 = llhd.prb %wake_status_val_3_qs : i1
    %173 = llhd.prb %wake_status_val_4_qs : i1
    %174 = llhd.prb %wake_status_val_5_qs : i1
    %175 = llhd.prb %reset_en_en_0_qs : i1
    %176 = llhd.prb %reset_en_en_1_qs : i1
    %177 = llhd.prb %reset_status_val_0_qs : i1
    %178 = llhd.prb %reset_status_val_1_qs : i1
    %179 = llhd.prb %escalate_reset_status_qs : i1
    %180 = llhd.prb %wake_info_capture_dis_qs : i1
    %181 = llhd.prb %wake_info_reasons_qs : i6
    %182 = llhd.prb %wake_info_fall_through_qs : i1
    %183 = llhd.prb %wake_info_abort_qs : i1
    %184 = llhd.prb %fault_status_reg_intg_err_qs : i1
    %185 = llhd.prb %fault_status_esc_timeout_qs : i1
    %186 = llhd.prb %fault_status_main_pd_glitch_qs : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb36
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      %188 = llhd.prb %addr_hit : i17
      %189 = comb.extract %188 from 0 : (i17) -> i1
      %190 = comb.icmp ceq %189, %true : i1
      cf.cond_br %190, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %191 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %192 = llhd.prb %intr_state_qs : i1
      llhd.drv %191, %192 after %1 : i1
      cf.br ^bb36
    ^bb3:  // pred: ^bb1
      %193 = llhd.prb %addr_hit : i17
      %194 = comb.extract %193 from 1 : (i17) -> i1
      %195 = comb.icmp ceq %194, %true : i1
      cf.cond_br %195, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %196 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %197 = llhd.prb %intr_enable_qs : i1
      llhd.drv %196, %197 after %1 : i1
      cf.br ^bb36
    ^bb5:  // pred: ^bb3
      %198 = llhd.prb %addr_hit : i17
      %199 = comb.extract %198 from 2 : (i17) -> i1
      %200 = comb.icmp ceq %199, %true : i1
      cf.cond_br %200, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %201 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      llhd.drv %201, %false after %1 : i1
      cf.br ^bb36
    ^bb7:  // pred: ^bb5
      %202 = llhd.prb %addr_hit : i17
      %203 = comb.extract %202 from 3 : (i17) -> i1
      %204 = comb.icmp ceq %203, %true : i1
      cf.cond_br %204, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %205 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      llhd.drv %205, %false after %1 : i1
      cf.br ^bb36
    ^bb9:  // pred: ^bb7
      %206 = llhd.prb %addr_hit : i17
      %207 = comb.extract %206 from 4 : (i17) -> i1
      %208 = comb.icmp ceq %207, %true : i1
      cf.cond_br %208, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %209 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %210 = llhd.prb %ctrl_cfg_regwen_qs : i1
      llhd.drv %209, %210 after %1 : i1
      cf.br ^bb36
    ^bb11:  // pred: ^bb9
      %211 = llhd.prb %addr_hit : i17
      %212 = comb.extract %211 from 5 : (i17) -> i1
      %213 = comb.icmp ceq %212, %true : i1
      cf.cond_br %213, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %214 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %215 = llhd.prb %control_low_power_hint_qs : i1
      llhd.drv %214, %215 after %1 : i1
      %216 = llhd.sig.extract %reg_rdata_next from %c4_i5 : <i32> -> <i1>
      %217 = llhd.prb %control_core_clk_en_qs : i1
      llhd.drv %216, %217 after %1 : i1
      %218 = llhd.sig.extract %reg_rdata_next from %c5_i5 : <i32> -> <i1>
      %219 = llhd.prb %control_io_clk_en_qs : i1
      llhd.drv %218, %219 after %1 : i1
      %220 = llhd.sig.extract %reg_rdata_next from %c6_i5 : <i32> -> <i1>
      %221 = llhd.prb %control_usb_clk_en_lp_qs : i1
      llhd.drv %220, %221 after %1 : i1
      %222 = llhd.sig.extract %reg_rdata_next from %c7_i5 : <i32> -> <i1>
      %223 = llhd.prb %control_usb_clk_en_active_qs : i1
      llhd.drv %222, %223 after %1 : i1
      %224 = llhd.sig.extract %reg_rdata_next from %c8_i5 : <i32> -> <i1>
      %225 = llhd.prb %control_main_pd_n_qs : i1
      llhd.drv %224, %225 after %1 : i1
      cf.br ^bb36
    ^bb13:  // pred: ^bb11
      %226 = llhd.prb %addr_hit : i17
      %227 = comb.extract %226 from 6 : (i17) -> i1
      %228 = comb.icmp ceq %227, %true : i1
      cf.cond_br %228, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %229 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %230 = llhd.prb %cfg_cdc_sync_qs : i1
      llhd.drv %229, %230 after %1 : i1
      cf.br ^bb36
    ^bb15:  // pred: ^bb13
      %231 = llhd.prb %addr_hit : i17
      %232 = comb.extract %231 from 7 : (i17) -> i1
      %233 = comb.icmp ceq %232, %true : i1
      cf.cond_br %233, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      %234 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %235 = llhd.prb %wakeup_en_regwen_qs : i1
      llhd.drv %234, %235 after %1 : i1
      cf.br ^bb36
    ^bb17:  // pred: ^bb15
      %236 = llhd.prb %addr_hit : i17
      %237 = comb.extract %236 from 8 : (i17) -> i1
      %238 = comb.icmp ceq %237, %true : i1
      cf.cond_br %238, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      %239 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %240 = llhd.prb %wakeup_en_en_0_qs : i1
      llhd.drv %239, %240 after %1 : i1
      %241 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %242 = llhd.prb %wakeup_en_en_1_qs : i1
      llhd.drv %241, %242 after %1 : i1
      %243 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %244 = llhd.prb %wakeup_en_en_2_qs : i1
      llhd.drv %243, %244 after %1 : i1
      %245 = llhd.sig.extract %reg_rdata_next from %c3_i5 : <i32> -> <i1>
      %246 = llhd.prb %wakeup_en_en_3_qs : i1
      llhd.drv %245, %246 after %1 : i1
      %247 = llhd.sig.extract %reg_rdata_next from %c4_i5 : <i32> -> <i1>
      %248 = llhd.prb %wakeup_en_en_4_qs : i1
      llhd.drv %247, %248 after %1 : i1
      %249 = llhd.sig.extract %reg_rdata_next from %c5_i5 : <i32> -> <i1>
      %250 = llhd.prb %wakeup_en_en_5_qs : i1
      llhd.drv %249, %250 after %1 : i1
      cf.br ^bb36
    ^bb19:  // pred: ^bb17
      %251 = llhd.prb %addr_hit : i17
      %252 = comb.extract %251 from 9 : (i17) -> i1
      %253 = comb.icmp ceq %252, %true : i1
      cf.cond_br %253, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      %254 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %255 = llhd.prb %wake_status_val_0_qs : i1
      llhd.drv %254, %255 after %1 : i1
      %256 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %257 = llhd.prb %wake_status_val_1_qs : i1
      llhd.drv %256, %257 after %1 : i1
      %258 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %259 = llhd.prb %wake_status_val_2_qs : i1
      llhd.drv %258, %259 after %1 : i1
      %260 = llhd.sig.extract %reg_rdata_next from %c3_i5 : <i32> -> <i1>
      %261 = llhd.prb %wake_status_val_3_qs : i1
      llhd.drv %260, %261 after %1 : i1
      %262 = llhd.sig.extract %reg_rdata_next from %c4_i5 : <i32> -> <i1>
      %263 = llhd.prb %wake_status_val_4_qs : i1
      llhd.drv %262, %263 after %1 : i1
      %264 = llhd.sig.extract %reg_rdata_next from %c5_i5 : <i32> -> <i1>
      %265 = llhd.prb %wake_status_val_5_qs : i1
      llhd.drv %264, %265 after %1 : i1
      cf.br ^bb36
    ^bb21:  // pred: ^bb19
      %266 = llhd.prb %addr_hit : i17
      %267 = comb.extract %266 from 10 : (i17) -> i1
      %268 = comb.icmp ceq %267, %true : i1
      cf.cond_br %268, ^bb22, ^bb23
    ^bb22:  // pred: ^bb21
      %269 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %270 = llhd.prb %reset_en_regwen_qs : i1
      llhd.drv %269, %270 after %1 : i1
      cf.br ^bb36
    ^bb23:  // pred: ^bb21
      %271 = llhd.prb %addr_hit : i17
      %272 = comb.extract %271 from 11 : (i17) -> i1
      %273 = comb.icmp ceq %272, %true : i1
      cf.cond_br %273, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      %274 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %275 = llhd.prb %reset_en_en_0_qs : i1
      llhd.drv %274, %275 after %1 : i1
      %276 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %277 = llhd.prb %reset_en_en_1_qs : i1
      llhd.drv %276, %277 after %1 : i1
      cf.br ^bb36
    ^bb25:  // pred: ^bb23
      %278 = llhd.prb %addr_hit : i17
      %279 = comb.extract %278 from 12 : (i17) -> i1
      %280 = comb.icmp ceq %279, %true : i1
      cf.cond_br %280, ^bb26, ^bb27
    ^bb26:  // pred: ^bb25
      %281 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %282 = llhd.prb %reset_status_val_0_qs : i1
      llhd.drv %281, %282 after %1 : i1
      %283 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %284 = llhd.prb %reset_status_val_1_qs : i1
      llhd.drv %283, %284 after %1 : i1
      cf.br ^bb36
    ^bb27:  // pred: ^bb25
      %285 = llhd.prb %addr_hit : i17
      %286 = comb.extract %285 from 13 : (i17) -> i1
      %287 = comb.icmp ceq %286, %true : i1
      cf.cond_br %287, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      %288 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %289 = llhd.prb %escalate_reset_status_qs : i1
      llhd.drv %288, %289 after %1 : i1
      cf.br ^bb36
    ^bb29:  // pred: ^bb27
      %290 = llhd.prb %addr_hit : i17
      %291 = comb.extract %290 from 14 : (i17) -> i1
      %292 = comb.icmp ceq %291, %true : i1
      cf.cond_br %292, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      %293 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %294 = llhd.prb %wake_info_capture_dis_qs : i1
      llhd.drv %293, %294 after %1 : i1
      cf.br ^bb36
    ^bb31:  // pred: ^bb29
      %295 = llhd.prb %addr_hit : i17
      %296 = comb.extract %295 from 15 : (i17) -> i1
      %297 = comb.icmp ceq %296, %true : i1
      cf.cond_br %297, ^bb32, ^bb33
    ^bb32:  // pred: ^bb31
      %298 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i6>
      %299 = llhd.prb %wake_info_reasons_qs : i6
      llhd.drv %298, %299 after %1 : i6
      %300 = llhd.sig.extract %reg_rdata_next from %c6_i5 : <i32> -> <i1>
      %301 = llhd.prb %wake_info_fall_through_qs : i1
      llhd.drv %300, %301 after %1 : i1
      %302 = llhd.sig.extract %reg_rdata_next from %c7_i5 : <i32> -> <i1>
      %303 = llhd.prb %wake_info_abort_qs : i1
      llhd.drv %302, %303 after %1 : i1
      cf.br ^bb36
    ^bb33:  // pred: ^bb31
      %304 = llhd.prb %addr_hit : i17
      %305 = comb.extract %304 from 16 : (i17) -> i1
      %306 = comb.icmp ceq %305, %true : i1
      cf.cond_br %306, ^bb34, ^bb35
    ^bb34:  // pred: ^bb33
      %307 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %308 = llhd.prb %fault_status_reg_intg_err_qs : i1
      llhd.drv %307, %308 after %1 : i1
      %309 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %310 = llhd.prb %fault_status_esc_timeout_qs : i1
      llhd.drv %309, %310 after %1 : i1
      %311 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %312 = llhd.prb %fault_status_main_pd_glitch_qs : i1
      llhd.drv %311, %312 after %1 : i1
      cf.br ^bb36
    ^bb35:  // pred: ^bb33
      llhd.drv %reg_rdata_next, %c-1_i32 after %1 : i32
      cf.br ^bb36
    ^bb36:  // 18 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb18, ^bb20, ^bb22, ^bb24, ^bb26, ^bb28, ^bb30, ^bb32, ^bb34, ^bb35
      llhd.wait (%94, %113, %154, %155, %101, %156, %157, %158, %159, %160, %161, %162, %104, %163, %164, %165, %166, %167, %168, %169, %170, %171, %172, %173, %174, %106, %175, %176, %177, %178, %179, %180, %181, %182, %183, %184, %185, %186 : i32, i17, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i6, i1, i1, i1, i1, i1), ^bb1
    }
    llhd.drv %clk_lc_i_0, %clk_lc_i after %1 : i1
    llhd.drv %rst_lc_ni_1, %rst_lc_ni after %1 : i1
    %187 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    hw.output %u_rsp_intg_gen.tl_o, %187, %93 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>, i1
  }
  hw.module private @pwrmgr_slow_fsm(in %clk_i : i1, in %rst_ni : i1, in %rst_main_ni : i1, in %wakeup_i : i1, in %reset_req_i : i1, out req_pwrup_o : i1, out pwrup_cause_toggle_o : i1, out pwrup_cause_o : i2, in %ack_pwrup_i : i1, in %req_pwrdn_i : i1, out ack_pwrdn_o : i1, out rst_req_o : i1, out fsm_invalid_o : i1, in %clr_req_i : i1, out usb_ip_clk_en_o : i1, in %usb_ip_clk_status_i : i1, in %main_pd_ni : i1, in %main_clk_en_i : i1, in %io_clk_en_i : i1, in %usb_clk_en_lp_i : i1, in %usb_clk_en_active_i : i1, in %ast_i : !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>, out ast_o : !hw.struct<main_pd_n: i1, pwr_clamp_env: i1, pwr_clamp: i1, slow_clk_en: i1, core_clk_en: i1, io_clk_en: i1, usb_clk_en: i1>) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i10 = hw.constant 0 : i10
    %2 = hw.aggregate_constant [false, false, false, false, false, false, false] : !hw.struct<main_pd_n: i1, pwr_clamp_env: i1, pwr_clamp: i1, slow_clk_en: i1, core_clk_en: i1, io_clk_en: i1, usb_clk_en: i1>
    %3 = hw.aggregate_constant [false, false, false, false, false] : !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>
    %c-503_i10 = hw.constant -503 : i10
    %c332_i10 = hw.constant 332 : i10
    %c-133_i10 = hw.constant -133 : i10
    %c117_i10 = hw.constant 117 : i10
    %c-32_i10 = hw.constant -32 : i10
    %c218_i10 = hw.constant 218 : i10
    %c-324_i10 = hw.constant -324 : i10
    %c401_i10 = hw.constant 401 : i10
    %c1_i2 = hw.constant 1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c-313_i10 = hw.constant -313 : i10
    %c431_i10 = hw.constant 431 : i10
    %c34_i10 = hw.constant 34 : i10
    %true = hw.constant true
    %false = hw.constant false
    %c0_i2 = hw.constant 0 : i2
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %4 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %5 = llhd.prb %rst_ni_1 : i1
    %rst_main_ni_2 = llhd.sig name "rst_main_ni" %false : i1
    %6 = llhd.prb %rst_main_ni_2 : i1
    %wakeup_i_3 = llhd.sig name "wakeup_i" %false : i1
    %reset_req_i_4 = llhd.sig name "reset_req_i" %false : i1
    %ack_pwrup_i_5 = llhd.sig name "ack_pwrup_i" %false : i1
    %req_pwrdn_i_6 = llhd.sig name "req_pwrdn_i" %false : i1
    %rst_req_o = llhd.sig %false : i1
    %clr_req_i_7 = llhd.sig name "clr_req_i" %false : i1
    %main_pd_ni_8 = llhd.sig name "main_pd_ni" %false : i1
    %usb_clk_en_active_i_9 = llhd.sig name "usb_clk_en_active_i" %false : i1
    %ast_i_10 = llhd.sig name "ast_i" %3 : !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>
    %ast_o = llhd.sig %2 : !hw.struct<main_pd_n: i1, pwr_clamp_env: i1, pwr_clamp: i1, slow_clk_en: i1, core_clk_en: i1, io_clk_en: i1, usb_clk_en: i1>
    %state_q = llhd.sig %c0_i10 : i10
    %state_d = llhd.sig %c0_i10 : i10
    %cause_q = llhd.sig %c0_i2 : i2
    %cause_d = llhd.sig %c0_i2 : i2
    %cause_toggle_q = llhd.sig %false : i1
    %cause_toggle_d = llhd.sig %false : i1
    %req_pwrup_q = llhd.sig %false : i1
    %req_pwrup_d = llhd.sig %false : i1
    %ack_pwrdn_q = llhd.sig %false : i1
    %ack_pwrdn_d = llhd.sig %false : i1
    %clk_active = llhd.sig %false : i1
    %pd_nq = llhd.sig %false : i1
    %pd_nd = llhd.sig %false : i1
    %pwr_clamp_q = llhd.sig %false : i1
    %pwr_clamp_d = llhd.sig %false : i1
    %pwr_clamp_env_q = llhd.sig %false : i1
    %pwr_clamp_env_d = llhd.sig %false : i1
    %main_clk_en_q = llhd.sig %false : i1
    %main_clk_en_d = llhd.sig %false : i1
    %io_clk_en_q = llhd.sig %false : i1
    %io_clk_en_d = llhd.sig %false : i1
    %usb_clk_en_q = llhd.sig %false : i1
    %usb_clk_en_d = llhd.sig %false : i1
    %fsm_invalid_q = llhd.sig %false : i1
    %fsm_invalid_d = llhd.sig %false : i1
    %all_clks_valid = llhd.sig %false : i1
    %all_clks_invalid = llhd.sig %false : i1
    %mon_main_pok = llhd.sig %false : i1
    %set_main_pok = llhd.sig %false : i1
    %async_main_pok_st = llhd.sig %false : i1
    %main_pok_st = llhd.sig %false : i1
    %usb_clk_en_lp = llhd.sig %false : i1
    %pwr_rst_req = llhd.sig %false : i1
    %7 = llhd.prb %state_d : i10
    %u_state_regs.state_o = hw.instance "u_state_regs" @prim_sparse_fsm_flop(clk_i: %4: i1, rst_ni: %5: i1, state_i: %7: i10) -> (state_o: i10)
    llhd.drv %state_q, %u_state_regs.state_o after %1 : i10
    %8 = llhd.prb %async_main_pok_st : i1
    %u_main_pok_sync.q_o = hw.instance "u_main_pok_sync" @prim_flop_2sync(clk_i: %4: i1, rst_ni: %5: i1, d_i: %8: i1) -> (q_o: i1)
    llhd.drv %main_pok_st, %u_main_pok_sync.q_o after %1 : i1
    %9 = llhd.prb %usb_clk_en_q : i1
    %10 = comb.or %9, %usb_ip_clk_status_i : i1
    %11 = llhd.sig.struct_extract %ast_o["usb_clk_en"] : <!hw.struct<main_pd_n: i1, pwr_clamp_env: i1, pwr_clamp: i1, slow_clk_en: i1, core_clk_en: i1, io_clk_en: i1, usb_clk_en: i1>>
    %u_usb_clk_en.q_o = hw.instance "u_usb_clk_en" @prim_flop(clk_i: %4: i1, rst_ni: %5: i1, d_i: %10: i1) -> (q_o: i1)
    llhd.drv %11, %u_usb_clk_en.q_o after %1 : i1
    %12 = llhd.prb %ast_i_10 : !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>
    %core_clk_val = hw.struct_extract %12["core_clk_val"] : !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>
    %io_clk_val = hw.struct_extract %12["io_clk_val"] : !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>
    %13 = llhd.prb %usb_clk_en_active_i_9 : i1
    %14 = comb.xor %13, %true : i1
    %usb_clk_val = hw.struct_extract %12["usb_clk_val"] : !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>
    %15 = comb.or %14, %usb_clk_val : i1
    %16 = comb.and %core_clk_val, %io_clk_val, %15 : i1
    llhd.drv %all_clks_valid, %16 after %1 : i1
    %17 = llhd.prb %main_pd_ni_8 : i1
    %18 = comb.and %17, %main_clk_en_i {sv.namehint = "main_clk_en"} : i1
    %19 = comb.and %17, %io_clk_en_i {sv.namehint = "io_clk_en"} : i1
    %20 = comb.and %17, %usb_clk_en_lp_i : i1
    llhd.drv %usb_clk_en_lp, %20 after %1 : i1
    %21 = comb.xor %core_clk_val, %true : i1
    %22 = comb.or %18, %21 : i1
    %23 = comb.xor %io_clk_val, %true : i1
    %24 = comb.or %19, %23 : i1
    %25 = llhd.prb %usb_clk_en_lp : i1
    %26 = comb.xor %usb_clk_val, %true : i1
    %27 = comb.or %25, %26 : i1
    %28 = comb.and %22, %24, %27 : i1
    llhd.drv %all_clks_invalid, %28 after %1 : i1
    %29 = llhd.prb %fsm_invalid_q : i1
    %30 = llhd.prb %clk_active : i1
    %31 = comb.or %29, %30, %18 : i1
    llhd.drv %main_clk_en_d, %31 after %1 : i1
    %32 = comb.or %29, %30, %19 : i1
    llhd.drv %io_clk_en_d, %32 after %1 : i1
    %33 = comb.mux %30, %13, %25 : i1
    %34 = comb.or %29, %33 : i1
    llhd.drv %usb_clk_en_d, %34 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %72 = llhd.prb %clk_i_0 : i1
      %73 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_i_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_ni_1 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_ni_1 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %cause_q, %c0_i2 after %0 : i2
      llhd.drv %cause_toggle_q, %false after %0 : i1
      llhd.drv %pd_nq, %true after %0 : i1
      llhd.drv %pwr_clamp_q, %true after %0 : i1
      llhd.drv %pwr_clamp_env_q, %true after %0 : i1
      llhd.drv %main_clk_en_q, %false after %0 : i1
      llhd.drv %io_clk_en_q, %false after %0 : i1
      llhd.drv %usb_clk_en_q, %false after %0 : i1
      llhd.drv %req_pwrup_q, %false after %0 : i1
      llhd.drv %ack_pwrdn_q, %false after %0 : i1
      llhd.drv %fsm_invalid_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %cause_d : i2
      llhd.drv %cause_q, %83 after %0 : i2
      %84 = llhd.prb %cause_toggle_d : i1
      llhd.drv %cause_toggle_q, %84 after %0 : i1
      %85 = llhd.prb %pd_nd : i1
      llhd.drv %pd_nq, %85 after %0 : i1
      %86 = llhd.prb %pwr_clamp_d : i1
      llhd.drv %pwr_clamp_q, %86 after %0 : i1
      %87 = llhd.prb %pwr_clamp_env_d : i1
      llhd.drv %pwr_clamp_env_q, %87 after %0 : i1
      %88 = llhd.prb %main_clk_en_d : i1
      llhd.drv %main_clk_en_q, %88 after %0 : i1
      %89 = llhd.prb %io_clk_en_d : i1
      llhd.drv %io_clk_en_q, %89 after %0 : i1
      %90 = llhd.prb %usb_clk_en_d : i1
      llhd.drv %usb_clk_en_q, %90 after %0 : i1
      %91 = llhd.prb %req_pwrup_d : i1
      llhd.drv %req_pwrup_q, %91 after %0 : i1
      %92 = llhd.prb %ack_pwrdn_d : i1
      llhd.drv %ack_pwrdn_q, %92 after %0 : i1
      %93 = llhd.prb %fsm_invalid_d : i1
      llhd.drv %fsm_invalid_q, %93 after %0 : i1
      cf.br ^bb1
    }
    %35 = llhd.prb %state_q : i10
    %36 = llhd.prb %cause_q : i2
    %37 = llhd.prb %cause_d : i2
    %38 = llhd.prb %pd_nq : i1
    %39 = llhd.prb %pd_nd : i1
    %40 = llhd.prb %cause_toggle_q : i1
    %41 = llhd.prb %cause_toggle_d : i1
    %42 = llhd.prb %pwr_clamp_q : i1
    %43 = llhd.prb %pwr_clamp_d : i1
    %44 = llhd.prb %pwr_clamp_env_q : i1
    %45 = llhd.prb %pwr_clamp_env_d : i1
    %46 = llhd.prb %req_pwrup_q : i1
    %47 = llhd.prb %req_pwrup_d : i1
    %48 = llhd.prb %ack_pwrdn_q : i1
    %49 = llhd.prb %ack_pwrdn_d : i1
    %50 = llhd.prb %fsm_invalid_d : i1
    %51 = llhd.prb %set_main_pok : i1
    %52 = llhd.prb %wakeup_i_3 : i1
    %53 = llhd.prb %reset_req_i_4 : i1
    %54 = llhd.prb %main_pok_st : i1
    %55 = llhd.prb %all_clks_valid : i1
    %56 = llhd.prb %ack_pwrup_i_5 : i1
    %57 = llhd.prb %req_pwrdn_i_6 : i1
    %58 = llhd.prb %all_clks_invalid : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb32
      %72 = llhd.prb %state_q : i10
      llhd.drv %state_d, %72 after %1 : i10
      %73 = llhd.prb %cause_q : i2
      llhd.drv %cause_d, %73 after %1 : i2
      %74 = llhd.prb %pd_nq : i1
      llhd.drv %pd_nd, %74 after %1 : i1
      %75 = llhd.prb %cause_toggle_q : i1
      llhd.drv %cause_toggle_d, %75 after %1 : i1
      %76 = llhd.prb %pwr_clamp_q : i1
      llhd.drv %pwr_clamp_d, %76 after %1 : i1
      %77 = llhd.prb %pwr_clamp_env_q : i1
      llhd.drv %pwr_clamp_env_d, %77 after %1 : i1
      %78 = llhd.prb %req_pwrup_q : i1
      llhd.drv %req_pwrup_d, %78 after %1 : i1
      %79 = llhd.prb %ack_pwrdn_q : i1
      llhd.drv %ack_pwrdn_d, %79 after %1 : i1
      %80 = llhd.prb %fsm_invalid_q : i1
      llhd.drv %fsm_invalid_d, %80 after %1 : i1
      llhd.drv %set_main_pok, %false after %1 : i1
      llhd.drv %clk_active, %false after %1 : i1
      %81 = llhd.prb %state_q : i10
      %82 = comb.icmp ceq %81, %c34_i10 : i10
      cf.cond_br %82, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      llhd.drv %state_d, %c431_i10 after %1 : i10
      llhd.drv %cause_d, %c0_i2 after %1 : i2
      cf.br ^bb32
    ^bb3:  // pred: ^bb1
      %83 = comb.icmp ceq %81, %c-313_i10 : i10
      cf.cond_br %83, ^bb4, ^bb6
    ^bb4:  // pred: ^bb3
      %84 = llhd.prb %wakeup_i_3 : i1
      %85 = llhd.prb %reset_req_i_4 : i1
      %86 = comb.or %84, %85 : i1
      cf.cond_br %86, ^bb5, ^bb32
    ^bb5:  // pred: ^bb4
      llhd.drv %state_d, %c431_i10 after %1 : i10
      %87 = llhd.prb %cause_toggle_q : i1
      %88 = comb.xor %87, %true : i1
      llhd.drv %cause_toggle_d, %88 after %1 : i1
      %89 = llhd.prb %reset_req_i_4 : i1
      %90 = comb.mux %89, %c-2_i2, %c1_i2 : i2
      llhd.drv %cause_d, %90 after %1 : i2
      cf.br ^bb32
    ^bb6:  // pred: ^bb3
      %91 = comb.icmp ceq %81, %c431_i10 : i10
      cf.cond_br %91, ^bb7, ^bb9
    ^bb7:  // pred: ^bb6
      llhd.drv %pd_nd, %true after %1 : i1
      %92 = llhd.prb %main_pok_st : i1
      cf.cond_br %92, ^bb8, ^bb32
    ^bb8:  // pred: ^bb7
      llhd.drv %set_main_pok, %true after %1 : i1
      llhd.drv %pwr_clamp_env_d, %false after %1 : i1
      llhd.drv %state_d, %c401_i10 after %1 : i10
      cf.br ^bb32
    ^bb9:  // pred: ^bb6
      %93 = comb.icmp ceq %81, %c401_i10 : i10
      cf.cond_br %93, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      llhd.drv %pwr_clamp_d, %false after %1 : i1
      llhd.drv %state_d, %c-324_i10 after %1 : i10
      cf.br ^bb32
    ^bb11:  // pred: ^bb9
      %94 = comb.icmp ceq %81, %c-324_i10 : i10
      cf.cond_br %94, ^bb12, ^bb14
    ^bb12:  // pred: ^bb11
      llhd.drv %clk_active, %true after %1 : i1
      %95 = llhd.prb %all_clks_valid : i1
      cf.cond_br %95, ^bb13, ^bb32
    ^bb13:  // pred: ^bb12
      llhd.drv %state_d, %c218_i10 after %1 : i10
      cf.br ^bb32
    ^bb14:  // pred: ^bb11
      %96 = comb.icmp ceq %81, %c218_i10 : i10
      cf.cond_br %96, ^bb15, ^bb17
    ^bb15:  // pred: ^bb14
      llhd.drv %clk_active, %true after %1 : i1
      llhd.drv %req_pwrup_d, %true after %1 : i1
      %97 = llhd.prb %ack_pwrup_i_5 : i1
      %98 = llhd.prb %req_pwrdn_i_6 : i1
      %99 = comb.xor %98, %true : i1
      %100 = comb.and %97, %99 : i1
      cf.cond_br %100, ^bb16, ^bb32
    ^bb16:  // pred: ^bb15
      llhd.drv %req_pwrup_d, %false after %1 : i1
      llhd.drv %state_d, %c-32_i10 after %1 : i10
      cf.br ^bb32
    ^bb17:  // pred: ^bb14
      %101 = comb.icmp ceq %81, %c-32_i10 : i10
      cf.cond_br %101, ^bb18, ^bb20
    ^bb18:  // pred: ^bb17
      llhd.drv %clk_active, %true after %1 : i1
      %102 = llhd.prb %req_pwrdn_i_6 : i1
      %103 = llhd.prb %ack_pwrup_i_5 : i1
      %104 = comb.xor %103, %true : i1
      %105 = comb.and %102, %104 : i1
      cf.cond_br %105, ^bb19, ^bb32
    ^bb19:  // pred: ^bb18
      llhd.drv %state_d, %c117_i10 after %1 : i10
      cf.br ^bb32
    ^bb20:  // pred: ^bb17
      %106 = comb.icmp ceq %81, %c117_i10 : i10
      cf.cond_br %106, ^bb21, ^bb23
    ^bb21:  // pred: ^bb20
      llhd.drv %clk_active, %true after %1 : i1
      llhd.drv %ack_pwrdn_d, %true after %1 : i1
      %107 = llhd.prb %req_pwrdn_i_6 : i1
      %108 = comb.xor %107, %true : i1
      cf.cond_br %108, ^bb22, ^bb32
    ^bb22:  // pred: ^bb21
      llhd.drv %ack_pwrdn_d, %false after %1 : i1
      llhd.drv %state_d, %c-133_i10 after %1 : i10
      cf.br ^bb32
    ^bb23:  // pred: ^bb20
      %109 = comb.icmp ceq %81, %c-133_i10 : i10
      cf.cond_br %109, ^bb24, ^bb26
    ^bb24:  // pred: ^bb23
      %110 = llhd.prb %all_clks_invalid : i1
      cf.cond_br %110, ^bb25, ^bb32
    ^bb25:  // pred: ^bb24
      %111 = llhd.prb %main_pd_ni_8 : i1
      %112 = comb.xor %111, %true : i1
      llhd.drv %pwr_clamp_env_d, %112 after %1 : i1
      llhd.drv %state_d, %c332_i10 after %1 : i10
      cf.br ^bb32
    ^bb26:  // pred: ^bb23
      %113 = comb.icmp ceq %81, %c332_i10 : i10
      cf.cond_br %113, ^bb27, ^bb28
    ^bb27:  // pred: ^bb26
      %114 = llhd.prb %pwr_clamp_env_q : i1
      llhd.drv %pwr_clamp_d, %114 after %1 : i1
      llhd.drv %state_d, %c-503_i10 after %1 : i10
      cf.br ^bb32
    ^bb28:  // pred: ^bb26
      %115 = comb.icmp ceq %81, %c-503_i10 : i10
      cf.cond_br %115, ^bb29, ^bb31
    ^bb29:  // pred: ^bb28
      %116 = llhd.prb %main_pd_ni_8 : i1
      llhd.drv %pd_nd, %116 after %1 : i1
      %117 = llhd.prb %main_pok_st : i1
      %118 = comb.xor %117, %true : i1
      %119 = llhd.prb %main_pd_ni_8 : i1
      %120 = comb.or %118, %119 : i1
      cf.cond_br %120, ^bb30, ^bb32
    ^bb30:  // pred: ^bb29
      llhd.drv %state_d, %c-313_i10 after %1 : i10
      cf.br ^bb32
    ^bb31:  // pred: ^bb28
      llhd.drv %fsm_invalid_d, %true after %1 : i1
      llhd.drv %pd_nd, %false after %1 : i1
      llhd.drv %pwr_clamp_d, %true after %1 : i1
      cf.br ^bb32
    ^bb32:  // 20 preds: ^bb2, ^bb4, ^bb5, ^bb7, ^bb8, ^bb10, ^bb12, ^bb13, ^bb15, ^bb16, ^bb18, ^bb19, ^bb21, ^bb22, ^bb24, ^bb25, ^bb27, ^bb29, ^bb30, ^bb31
      llhd.wait (%35, %7, %36, %37, %38, %39, %40, %41, %42, %43, %44, %45, %46, %47, %48, %49, %29, %50, %51, %30, %52, %53, %54, %55, %56, %57, %58, %17 : i10, i10, i2, i2, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %72 = llhd.prb %clk_i_0 : i1
      %73 = llhd.prb %rst_main_ni_2 : i1
      llhd.wait (%4, %6 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_i_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_main_ni_2 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_main_ni_2 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %async_main_pok_st, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %ast_i_10 : !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>
      %main_pok = hw.struct_extract %83["main_pok"] : !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>
      llhd.drv %async_main_pok_st, %main_pok after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %72 = llhd.prb %clk_i_0 : i1
      %73 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_i_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_ni_1 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_ni_1 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %mon_main_pok, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %pd_nd : i1
      %84 = comb.xor %83, %true : i1
      %85 = llhd.prb %mon_main_pok : i1
      %86 = comb.and %84, %85 : i1
      cf.cond_br %86, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %mon_main_pok, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %87 = llhd.prb %set_main_pok : i1
      cf.cond_br %87, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %mon_main_pok, %true after %0 : i1
      cf.br ^bb1
    }
    %59 = llhd.prb %mon_main_pok : i1
    %60 = comb.xor %54, %true : i1
    %61 = comb.and %59, %60 : i1
    llhd.drv %pwr_rst_req, %61 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %72 = llhd.prb %clk_i_0 : i1
      %73 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %74 = llhd.prb %clk_i_0 : i1
      %75 = comb.xor bin %72, %true : i1
      %76 = comb.and bin %75, %74 : i1
      %77 = llhd.prb %rst_ni_1 : i1
      %78 = comb.xor bin %77, %true : i1
      %79 = comb.and bin %73, %78 : i1
      %80 = comb.or bin %76, %79 : i1
      cf.cond_br %80, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %rst_ni_1 : i1
      %82 = comb.xor %81, %true : i1
      cf.cond_br %82, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %rst_req_o, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %83 = llhd.prb %clr_req_i_7 : i1
      cf.cond_br %83, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %rst_req_o, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %84 = llhd.prb %rst_req_o : i1
      %85 = llhd.prb %pwr_rst_req : i1
      %86 = comb.or %84, %85 : i1
      llhd.drv %rst_req_o, %86 after %0 : i1
      cf.br ^bb1
    }
    %62 = llhd.sig.struct_extract %ast_o["core_clk_en"] : <!hw.struct<main_pd_n: i1, pwr_clamp_env: i1, pwr_clamp: i1, slow_clk_en: i1, core_clk_en: i1, io_clk_en: i1, usb_clk_en: i1>>
    %63 = llhd.prb %main_clk_en_q : i1
    llhd.drv %62, %63 after %1 : i1
    %64 = llhd.sig.struct_extract %ast_o["io_clk_en"] : <!hw.struct<main_pd_n: i1, pwr_clamp_env: i1, pwr_clamp: i1, slow_clk_en: i1, core_clk_en: i1, io_clk_en: i1, usb_clk_en: i1>>
    %65 = llhd.prb %io_clk_en_q : i1
    llhd.drv %64, %65 after %1 : i1
    %66 = llhd.sig.struct_extract %ast_o["main_pd_n"] : <!hw.struct<main_pd_n: i1, pwr_clamp_env: i1, pwr_clamp: i1, slow_clk_en: i1, core_clk_en: i1, io_clk_en: i1, usb_clk_en: i1>>
    llhd.drv %66, %38 after %1 : i1
    %67 = llhd.sig.struct_extract %ast_o["pwr_clamp_env"] : <!hw.struct<main_pd_n: i1, pwr_clamp_env: i1, pwr_clamp: i1, slow_clk_en: i1, core_clk_en: i1, io_clk_en: i1, usb_clk_en: i1>>
    llhd.drv %67, %44 after %1 : i1
    %68 = llhd.sig.struct_extract %ast_o["pwr_clamp"] : <!hw.struct<main_pd_n: i1, pwr_clamp_env: i1, pwr_clamp: i1, slow_clk_en: i1, core_clk_en: i1, io_clk_en: i1, usb_clk_en: i1>>
    llhd.drv %68, %42 after %1 : i1
    %69 = llhd.sig.struct_extract %ast_o["slow_clk_en"] : <!hw.struct<main_pd_n: i1, pwr_clamp_env: i1, pwr_clamp: i1, slow_clk_en: i1, core_clk_en: i1, io_clk_en: i1, usb_clk_en: i1>>
    llhd.drv %69, %true after %1 : i1
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %rst_main_ni_2, %rst_main_ni after %1 : i1
    llhd.drv %wakeup_i_3, %wakeup_i after %1 : i1
    llhd.drv %reset_req_i_4, %reset_req_i after %1 : i1
    llhd.drv %ack_pwrup_i_5, %ack_pwrup_i after %1 : i1
    llhd.drv %req_pwrdn_i_6, %req_pwrdn_i after %1 : i1
    %70 = llhd.prb %rst_req_o : i1
    llhd.drv %clr_req_i_7, %clr_req_i after %1 : i1
    llhd.drv %main_pd_ni_8, %main_pd_ni after %1 : i1
    llhd.drv %usb_clk_en_active_i_9, %usb_clk_en_active_i after %1 : i1
    llhd.drv %ast_i_10, %ast_i after %1 : !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>
    %71 = llhd.prb %ast_o : !hw.struct<main_pd_n: i1, pwr_clamp_env: i1, pwr_clamp: i1, slow_clk_en: i1, core_clk_en: i1, io_clk_en: i1, usb_clk_en: i1>
    hw.output %46, %40, %36, %48, %70, %29, %9, %71 : i1, i1, i2, i1, i1, i1, i1, !hw.struct<main_pd_n: i1, pwr_clamp_env: i1, pwr_clamp: i1, slow_clk_en: i1, core_clk_en: i1, io_clk_en: i1, usb_clk_en: i1>
  }
  hw.module @pwrmgr(in %clk_slow_i : i1, in %clk_i : i1, in %rst_slow_ni : i1, in %rst_ni : i1, in %rst_main_ni : i1, in %clk_lc_i : i1, in %rst_lc_ni : i1, in %clk_esc_i : i1, in %rst_esc_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %alert_rx_i : !hw.array<1xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, out alert_tx_o : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>, in %pwr_ast_i : !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>, out pwr_ast_o : !hw.struct<main_pd_n: i1, pwr_clamp_env: i1, pwr_clamp: i1, slow_clk_en: i1, core_clk_en: i1, io_clk_en: i1, usb_clk_en: i1>, in %pwr_rst_i : !hw.struct<rst_lc_src_n: i2, rst_sys_src_n: i2>, out pwr_rst_o : !hw.struct<rst_lc_req: i2, rst_sys_req: i2, rstreqs: i5, reset_cause: i2>, out pwr_clk_o : !hw.struct<main_ip_clk_en: i1, io_ip_clk_en: i1, usb_ip_clk_en: i1>, in %pwr_clk_i : !hw.struct<main_status: i1, io_status: i1, usb_status: i1>, in %pwr_otp_i : !hw.struct<otp_done: i1, otp_idle: i1>, out pwr_otp_o : !hw.struct<otp_init: i1>, in %pwr_lc_i : !hw.struct<lc_done: i1, lc_idle: i1>, out pwr_lc_o : !hw.struct<lc_init: i1>, in %pwr_nvm_i : !hw.struct<nvm_idle: i1>, in %pwr_cpu_i : !hw.struct<core_sleeping: i1>, out fetch_en_o : i4, in %lc_hw_debug_en_i : i4, in %lc_dft_en_i : i4, in %wakeups_i : i6, in %rstreqs_i : i2, in %ndmreset_req_i : i1, out strap_o : i1, out low_power_o : i1, in %rom_ctrl_i : !hw.array<1xstruct<done: i4, good: i4>>, in %sw_rst_req_i : i4, in %esc_rst_tx_i : !hw.struct<esc_p: i1, esc_n: i1>, out esc_rst_rx_o : !hw.struct<resp_p: i1, resp_n: i1>, out intr_wakeup_o : i1) {
    %c-1_i4 = hw.constant -1 : i4
    %c1_i3 = hw.constant 1 : i3
    %c-3_i3 = hw.constant -3 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c3_i3 = hw.constant 3 : i3
    %c2_i3 = hw.constant 2 : i3
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c0_i6 = hw.constant 0 : i6
    %c0_i0 = hw.constant 0 : i0
    %c0_i3 = hw.constant 0 : i3
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %2 = hw.aggregate_constant [0 : i4] : !hw.array<1xi4>
    %3 = hw.aggregate_constant [[false, false], [false], [[false, false]], [false, false], [[false, false], [false, false], [false, false], [false, false], [false, false], [false, false]], [[false, false], [false, false]], [false, false], [[false], [false], [0 : i6]], [[false, false], [false, false], [false, false]]] : !hw.struct<intr_state: !hw.struct<d: i1, de: i1>, ctrl_cfg_regwen: !hw.struct<d: i1>, control: !hw.struct<low_power_hint: !hw.struct<d: i1, de: i1>>, cfg_cdc_sync: !hw.struct<d: i1, de: i1>, wake_status: !hw.array<6xstruct<d: i1, de: i1>>, reset_status: !hw.array<2xstruct<d: i1, de: i1>>, escalate_reset_status: !hw.struct<d: i1, de: i1>, wake_info: !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %4 = hw.aggregate_constant [0 : i6, 0 : i6] : !hw.struct<wakeups: i6, rstreqs: i6>
    %5 = hw.aggregate_constant [[0 : i4, 0 : i4]] : !hw.array<1xstruct<done: i4, good: i4>>
    %6 = hw.aggregate_constant [false] : !hw.struct<lc_init: i1>
    %7 = hw.aggregate_constant [false] : !hw.struct<otp_init: i1>
    %8 = hw.aggregate_constant [[false, false]] : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    %true = hw.constant true
    %c1_i32 = hw.constant 1 : i32
    %c0_i32 = hw.constant 0 : i32
    %c6_i4 = hw.constant 6 : i4
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %9 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %10 = llhd.prb %rst_ni_1 : i1
    %alert_tx_o = llhd.sig %8 : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    %pwr_otp_o = llhd.sig %7 : !hw.struct<otp_init: i1>
    %pwr_lc_o = llhd.sig %6 : !hw.struct<lc_init: i1>
    %rom_ctrl_i_2 = llhd.sig name "rom_ctrl_i" %5 : !hw.array<1xstruct<done: i4, good: i4>>
    %clk_lc = llhd.sig %false : i1
    %11 = llhd.prb %clk_lc : i1
    %rst_lc_n = llhd.sig %false : i1
    %12 = llhd.prb %rst_lc_n : i1
    %esc_rst_req_d = llhd.sig %false : i1
    %esc_rst_req_q = llhd.sig %false : i1
    %esc_timeout_lc_d = llhd.sig %false : i1
    %esc_timeout_lc_q = llhd.sig %false : i1
    %peri_reqs_raw = llhd.sig %4 : !hw.struct<wakeups: i6, rstreqs: i6>
    %hw2reg = llhd.sig %3 : !hw.struct<intr_state: !hw.struct<d: i1, de: i1>, ctrl_cfg_regwen: !hw.struct<d: i1>, control: !hw.struct<low_power_hint: !hw.struct<d: i1, de: i1>>, cfg_cdc_sync: !hw.struct<d: i1, de: i1>, wake_status: !hw.array<6xstruct<d: i1, de: i1>>, reset_status: !hw.array<2xstruct<d: i1, de: i1>>, escalate_reset_status: !hw.struct<d: i1, de: i1>, wake_info: !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %rom_ctrl_done_async = llhd.sig %2 : !hw.array<1xi4>
    %rom_ctrl_done = llhd.sig %2 : !hw.array<1xi4>
    %rom_ctrl_done_combined = llhd.sig %c0_i4 : i4
    %rom_ctrl_good_combined = llhd.sig %c0_i4 : i4
    %low_power_entry = llhd.sig %false : i1
    %slow_peri_reqs_masked = llhd.sig %4 : !hw.struct<wakeups: i6, rstreqs: i6>
    %alerts = llhd.sig %false : i1
    %lowpwr_cfg_wen = llhd.sig %false : i1
    %wkup = llhd.sig %false : i1
    %clr_cfg_lock = llhd.sig %false : i1
    %u_ndm_sync.q_o = hw.instance "u_ndm_sync" @prim_flop_2sync(clk_i: %9: i1, rst_ni: %10: i1, d_i: %ndmreset_req_i: i1) -> (q_o: i1) {sv.namehint = "ndm_req_valid"}
    %u_esc_clk_buf.clk_o = hw.instance "u_esc_clk_buf" @prim_clock_buf(clk_i: %clk_esc_i: i1) -> (clk_o: i1) {sv.namehint = "clk_esc"}
    %u_esc_rst_buf.clk_o = hw.instance "u_esc_rst_buf" @prim_clock_buf(clk_i: %rst_esc_ni: i1) -> (clk_o: i1) {sv.namehint = "rst_esc_n"}
    %u_esc_rx.esc_req_o, %u_esc_rx.esc_rx_o = hw.instance "u_esc_rx" @prim_esc_receiver(clk_i: %u_esc_clk_buf.clk_o: i1, rst_ni: %u_esc_rst_buf.clk_o: i1, esc_tx_i: %esc_rst_tx_i: !hw.struct<esc_p: i1, esc_n: i1>) -> (esc_req_o: i1, esc_rx_o: !hw.struct<resp_p: i1, resp_n: i1>)
    llhd.drv %esc_rst_req_d, %u_esc_rx.esc_req_o after %1 : i1
    %13 = hw.bitcast %u_fsm.ips_clk_en_o : (!hw.struct<main_ip_clk_en: i1, io_ip_clk_en: i1, usb_ip_clk_en: i1>) -> i3
    %14 = comb.icmp ne %13, %c0_i3 : i3
    %u_esc_timeout.timeout_o = hw.instance "u_esc_timeout" @prim_clock_timeout(clk_chk_i: %u_esc_clk_buf.clk_o: i1, rst_chk_ni: %u_esc_rst_buf.clk_o: i1, clk_i: %9: i1, rst_ni: %10: i1, en_i: %14: i1) -> (timeout_o: i1) {sv.namehint = "esc_timeout"}
    %u_esc_timeout_sync.q_o = hw.instance "u_esc_timeout_sync" @prim_flop_2sync(clk_i: %11: i1, rst_ni: %12: i1, d_i: %u_esc_timeout.timeout_o: i1) -> (q_o: i1)
    llhd.drv %esc_timeout_lc_d, %u_esc_timeout_sync.q_o after %1 : i1
    %15 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%sw_rst_req_i) : (i4) -> i1
    %u_sw_req_buf.out_o = hw.instance "u_sw_req_buf" @prim_buf(in_i: %15: i1) -> (out_o: i1) {sv.namehint = "sw_rst_req"}
    %16 = llhd.prb %hw2reg : !hw.struct<intr_state: !hw.struct<d: i1, de: i1>, ctrl_cfg_regwen: !hw.struct<d: i1>, control: !hw.struct<low_power_hint: !hw.struct<d: i1, de: i1>>, cfg_cdc_sync: !hw.struct<d: i1, de: i1>, wake_status: !hw.array<6xstruct<d: i1, de: i1>>, reset_status: !hw.array<2xstruct<d: i1, de: i1>>, escalate_reset_status: !hw.struct<d: i1, de: i1>, wake_info: !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %u_reg.tl_o, %u_reg.reg2hw, %u_reg.intg_err_o = hw.instance "u_reg" @pwrmgr_reg_top(clk_i: %9: i1, rst_ni: %10: i1, clk_lc_i: %11: i1, rst_lc_ni: %12: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, hw2reg: %16: !hw.struct<intr_state: !hw.struct<d: i1, de: i1>, ctrl_cfg_regwen: !hw.struct<d: i1>, control: !hw.struct<low_power_hint: !hw.struct<d: i1, de: i1>>, cfg_cdc_sync: !hw.struct<d: i1, de: i1>, wake_status: !hw.array<6xstruct<d: i1, de: i1>>, reset_status: !hw.array<2xstruct<d: i1, de: i1>>, escalate_reset_status: !hw.struct<d: i1, de: i1>, wake_info: !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, reg2hw: !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>, intg_err_o: i1) {sv.namehint = "reg2hw"}
    %17 = llhd.prb %alerts : i1
    %18 = hw.array_get %alert_rx_i[%c0_i0] : !hw.array<1xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, i0
    %19 = llhd.sig.array_get %alert_tx_o[%c0_i0] : <!hw.array<1xstruct<alert_p: i1, alert_n: i1>>>
    %gen_alert_tx_0.u_prim_alert_sender.alert_ack_o, %gen_alert_tx_0.u_prim_alert_sender.alert_state_o, %gen_alert_tx_0.u_prim_alert_sender.alert_tx_o = hw.instance "gen_alert_tx_0.u_prim_alert_sender" @prim_alert_sender(clk_i: %11: i1, rst_ni: %12: i1, alert_test_i: %71: i1, alert_req_i: %17: i1, alert_rx_i: %18: !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>) -> (alert_ack_o: i1, alert_state_o: i1, alert_tx_o: !hw.struct<alert_p: i1, alert_n: i1>)
    llhd.drv %19, %gen_alert_tx_0.u_prim_alert_sender.alert_tx_o after %1 : !hw.struct<alert_p: i1, alert_n: i1>
    %20 = llhd.prb %slow_peri_reqs_masked : !hw.struct<wakeups: i6, rstreqs: i6>
    %cfg_cdc_sync = hw.struct_extract %u_reg.reg2hw["cfg_cdc_sync"] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %qe = hw.struct_extract %cfg_cdc_sync["qe"] : !hw.struct<q: i1, qe: i1>
    %q = hw.struct_extract %cfg_cdc_sync["q"] : !hw.struct<q: i1, qe: i1>
    %21 = comb.and %qe, %q : i1
    %wakeup_en = hw.struct_extract %u_reg.reg2hw["wakeup_en"] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %reset_en = hw.struct_extract %u_reg.reg2hw["reset_en"] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %control = hw.struct_extract %u_reg.reg2hw["control"] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %main_pd_n = hw.struct_extract %control["main_pd_n"] : !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>
    %q_3 = hw.struct_extract %main_pd_n["q"] : !hw.struct<q: i1>
    %core_clk_en = hw.struct_extract %control["core_clk_en"] : !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>
    %q_4 = hw.struct_extract %core_clk_en["q"] : !hw.struct<q: i1>
    %io_clk_en = hw.struct_extract %control["io_clk_en"] : !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>
    %q_5 = hw.struct_extract %io_clk_en["q"] : !hw.struct<q: i1>
    %usb_clk_en_lp = hw.struct_extract %control["usb_clk_en_lp"] : !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>
    %q_6 = hw.struct_extract %usb_clk_en_lp["q"] : !hw.struct<q: i1>
    %usb_clk_en_active = hw.struct_extract %control["usb_clk_en_active"] : !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>
    %q_7 = hw.struct_extract %usb_clk_en_active["q"] : !hw.struct<q: i1>
    %22 = llhd.sig.struct_extract %hw2reg["cfg_cdc_sync"] : <!hw.struct<intr_state: !hw.struct<d: i1, de: i1>, ctrl_cfg_regwen: !hw.struct<d: i1>, control: !hw.struct<low_power_hint: !hw.struct<d: i1, de: i1>>, cfg_cdc_sync: !hw.struct<d: i1, de: i1>, wake_status: !hw.array<6xstruct<d: i1, de: i1>>, reset_status: !hw.array<2xstruct<d: i1, de: i1>>, escalate_reset_status: !hw.struct<d: i1, de: i1>, wake_info: !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>>
    %23 = llhd.sig.struct_extract %22["de"] : <!hw.struct<d: i1, de: i1>>
    %24 = llhd.prb %peri_reqs_raw : !hw.struct<wakeups: i6, rstreqs: i6>
    %25 = llhd.prb %rom_ctrl_done_async : !hw.array<1xi4>
    %core_sleeping = hw.struct_extract %pwr_cpu_i["core_sleeping"] : !hw.struct<core_sleeping: i1>
    %26 = hw.bitcast %wakeup_en : (!hw.array<6xstruct<q: i1>>) -> i6
    %27 = hw.bitcast %reset_en : (!hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>) -> i2
    %u_cdc.slow_wakeup_en_o, %u_cdc.slow_reset_en_o, %u_cdc.slow_main_pd_no, %u_cdc.slow_main_clk_en_o, %u_cdc.slow_io_clk_en_o, %u_cdc.slow_usb_clk_en_lp_o, %u_cdc.slow_usb_clk_en_active_o, %u_cdc.slow_req_pwrdn_o, %u_cdc.slow_ack_pwrup_o, %u_cdc.slow_ast_o, %u_cdc.slow_peri_reqs_o, %u_cdc.slow_clr_req_o, %u_cdc.slow_usb_ip_clk_status_o, %u_cdc.ack_pwrdn_o, %u_cdc.fsm_invalid_o, %u_cdc.req_pwrup_o, %u_cdc.pwrup_cause_o, %u_cdc.peri_reqs_o, %u_cdc.cdc_sync_done_o, %u_cdc.usb_ip_clk_en_o, %u_cdc.nvm_o, %u_cdc.otp_o, %u_cdc.rom_ctrl_done_o, %u_cdc.core_sleeping_o = hw.instance "u_cdc" @pwrmgr_cdc(clk_slow_i: %clk_slow_i: i1, clk_i: %9: i1, rst_slow_ni: %rst_slow_ni: i1, rst_ni: %10: i1, slow_req_pwrup_i: %u_slow_fsm.req_pwrup_o: i1, slow_ack_pwrdn_i: %u_slow_fsm.ack_pwrdn_o: i1, slow_fsm_invalid_i: %u_slow_fsm.fsm_invalid_o: i1, slow_pwrup_cause_toggle_i: %u_slow_fsm.pwrup_cause_toggle_o: i1, slow_pwrup_cause_i: %u_slow_fsm.pwrup_cause_o: i2, slow_peri_reqs_masked_i: %20: !hw.struct<wakeups: i6, rstreqs: i6>, slow_usb_ip_clk_en_i: %u_slow_fsm.usb_ip_clk_en_o: i1, req_pwrdn_i: %u_fsm.req_pwrdn_o: i1, ack_pwrup_i: %u_fsm.ack_pwrup_o: i1, cfg_cdc_sync_i: %21: i1, wakeup_en_i: %26: i6, reset_en_i: %27: i2, main_pd_ni: %q_3: i1, main_clk_en_i: %q_4: i1, io_clk_en_i: %q_5: i1, usb_clk_en_lp_i: %q_6: i1, usb_clk_en_active_i: %q_7: i1, clr_slow_req_i: %u_fsm.clr_slow_req_o: i1, usb_ip_clk_status_i: %u_fsm.usb_ip_clk_status_o: i1, peri_i: %24: !hw.struct<wakeups: i6, rstreqs: i6>, nvm_i: %pwr_nvm_i: !hw.struct<nvm_idle: i1>, otp_i: %pwr_otp_i: !hw.struct<otp_done: i1, otp_idle: i1>, ast_i: %pwr_ast_i: !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>, rom_ctrl_done_i: %25: !hw.array<1xi4>, core_sleeping_i: %core_sleeping: i1) -> (slow_wakeup_en_o: i6, slow_reset_en_o: i2, slow_main_pd_no: i1, slow_main_clk_en_o: i1, slow_io_clk_en_o: i1, slow_usb_clk_en_lp_o: i1, slow_usb_clk_en_active_o: i1, slow_req_pwrdn_o: i1, slow_ack_pwrup_o: i1, slow_ast_o: !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>, slow_peri_reqs_o: !hw.struct<wakeups: i6, rstreqs: i6>, slow_clr_req_o: i1, slow_usb_ip_clk_status_o: i1, ack_pwrdn_o: i1, fsm_invalid_o: i1, req_pwrup_o: i1, pwrup_cause_o: i2, peri_reqs_o: !hw.struct<wakeups: i6, rstreqs: i6>, cdc_sync_done_o: i1, usb_ip_clk_en_o: i1, nvm_o: !hw.struct<nvm_idle: i1>, otp_o: !hw.struct<otp_done: i1, otp_idle: i1>, rom_ctrl_done_o: !hw.array<1xi4>, core_sleeping_o: i1) {sv.namehint = "otp_rsp"}
    llhd.drv %23, %u_cdc.cdc_sync_done_o after %1 : i1
    llhd.drv %rom_ctrl_done, %u_cdc.rom_ctrl_done_o after %1 : !hw.array<1xi4>
    %wakeups = hw.struct_extract %20["wakeups"] : !hw.struct<wakeups: i6, rstreqs: i6>
    %28 = comb.icmp ne %wakeups, %c0_i6 : i6
    %rstreqs = hw.struct_extract %20["rstreqs"] : !hw.struct<wakeups: i6, rstreqs: i6>
    %29 = comb.icmp ne %rstreqs, %c0_i6 : i6
    %u_slow_fsm.req_pwrup_o, %u_slow_fsm.pwrup_cause_toggle_o, %u_slow_fsm.pwrup_cause_o, %u_slow_fsm.ack_pwrdn_o, %u_slow_fsm.rst_req_o, %u_slow_fsm.fsm_invalid_o, %u_slow_fsm.usb_ip_clk_en_o, %u_slow_fsm.ast_o = hw.instance "u_slow_fsm" @pwrmgr_slow_fsm(clk_i: %clk_slow_i: i1, rst_ni: %rst_slow_ni: i1, rst_main_ni: %rst_main_ni: i1, wakeup_i: %28: i1, reset_req_i: %29: i1, ack_pwrup_i: %u_cdc.slow_ack_pwrup_o: i1, req_pwrdn_i: %u_cdc.slow_req_pwrdn_o: i1, clr_req_i: %u_cdc.slow_clr_req_o: i1, usb_ip_clk_status_i: %u_cdc.slow_usb_ip_clk_status_o: i1, main_pd_ni: %u_cdc.slow_main_pd_no: i1, main_clk_en_i: %u_cdc.slow_main_clk_en_o: i1, io_clk_en_i: %u_cdc.slow_io_clk_en_o: i1, usb_clk_en_lp_i: %u_cdc.slow_usb_clk_en_lp_o: i1, usb_clk_en_active_i: %u_cdc.slow_usb_clk_en_active_o: i1, ast_i: %u_cdc.slow_ast_o: !hw.struct<slow_clk_val: i1, core_clk_val: i1, io_clk_val: i1, usb_clk_val: i1, main_pok: i1>) -> (req_pwrup_o: i1, pwrup_cause_toggle_o: i1, pwrup_cause_o: i2, ack_pwrdn_o: i1, rst_req_o: i1, fsm_invalid_o: i1, usb_ip_clk_en_o: i1, ast_o: !hw.struct<main_pd_n: i1, pwr_clamp_env: i1, pwr_clamp: i1, slow_clk_en: i1, core_clk_en: i1, io_clk_en: i1, usb_clk_en: i1>) {sv.namehint = "slow_rst_req"}
    %u_prim_lc_sync_dft_en.lc_en_o = hw.instance "u_prim_lc_sync_dft_en" @prim_lc_sync(clk_i: %9: i1, rst_ni: %10: i1, lc_en_i: %lc_dft_en_i: i4) -> (lc_en_o: !hw.array<1xi4>)
    %30 = hw.bitcast %u_prim_lc_sync_dft_en.lc_en_o {sv.namehint = "lc_dft_en"} : (!hw.array<1xi4>) -> i4
    %u_prim_lc_sync_hw_debug_en.lc_en_o = hw.instance "u_prim_lc_sync_hw_debug_en" @prim_lc_sync(clk_i: %9: i1, rst_ni: %10: i1, lc_en_i: %lc_hw_debug_en_i: i4) -> (lc_en_o: !hw.array<1xi4>)
    %31 = hw.bitcast %u_prim_lc_sync_hw_debug_en.lc_en_o {sv.namehint = "lc_hw_debug_en"} : (!hw.array<1xi4>) -> i4
    %32 = llhd.prb %low_power_entry : i1
    %rstreqs_8 = hw.struct_extract %u_cdc.peri_reqs_o["rstreqs"] : !hw.struct<wakeups: i6, rstreqs: i6>
    %33 = llhd.sig.struct_extract %pwr_otp_o["otp_init"] : <!hw.struct<otp_init: i1>>
    %otp_done = hw.struct_extract %u_cdc.otp_o["otp_done"] : !hw.struct<otp_done: i1, otp_idle: i1>
    %otp_idle = hw.struct_extract %u_cdc.otp_o["otp_idle"] : !hw.struct<otp_done: i1, otp_idle: i1>
    %34 = llhd.sig.struct_extract %pwr_lc_o["lc_init"] : <!hw.struct<lc_init: i1>>
    %lc_done = hw.struct_extract %pwr_lc_i["lc_done"] : !hw.struct<lc_done: i1, lc_idle: i1>
    %lc_idle = hw.struct_extract %pwr_lc_i["lc_idle"] : !hw.struct<lc_done: i1, lc_idle: i1>
    %nvm_idle = hw.struct_extract %u_cdc.nvm_o["nvm_idle"] : !hw.struct<nvm_idle: i1>
    %35 = llhd.prb %rom_ctrl_done_combined : i4
    %36 = llhd.prb %rom_ctrl_good_combined : i4
    %u_fsm.ack_pwrup_o, %u_fsm.req_pwrdn_o, %u_fsm.clr_slow_req_o, %u_fsm.usb_ip_clk_status_o, %u_fsm.wkup_o, %u_fsm.fall_through_o, %u_fsm.abort_o, %u_fsm.clr_hint_o, %u_fsm.clr_cfg_lock_o, %u_fsm.pwr_rst_o, %u_fsm.ips_clk_en_o, %u_fsm.otp_init_o, %u_fsm.lc_init_o, %u_fsm.strap_o, %u_fsm.strap_sampled_o, %u_fsm.low_power_o, %u_fsm.fetch_en_o = hw.instance "u_fsm" @pwrmgr_fsm(clk_i: %9: i1, rst_ni: %10: i1, clk_slow_i: %clk_slow_i: i1, rst_slow_ni: %rst_slow_ni: i1, req_pwrup_i: %u_cdc.req_pwrup_o: i1, pwrup_cause_i: %u_cdc.pwrup_cause_o: i2, ack_pwrdn_i: %u_cdc.ack_pwrdn_o: i1, low_power_entry_i: %32: i1, main_pd_ni: %q_3: i1, reset_reqs_i: %rstreqs_8: i6, fsm_invalid_i: %u_cdc.fsm_invalid_o: i1, usb_ip_clk_en_i: %u_cdc.usb_ip_clk_en_o: i1, pwr_rst_i: %pwr_rst_i: !hw.struct<rst_lc_src_n: i2, rst_sys_src_n: i2>, clk_en_status_i: %pwr_clk_i: !hw.struct<main_status: i1, io_status: i1, usb_status: i1>, otp_done_i: %otp_done: i1, otp_idle_i: %otp_idle: i1, lc_done_i: %lc_done: i1, lc_idle_i: %lc_idle: i1, lc_dft_en_i: %30: i4, lc_hw_debug_en_i: %31: i4, nvm_idle_i: %nvm_idle: i1, rom_ctrl_done_i: %35: i4, rom_ctrl_good_i: %36: i4) -> (ack_pwrup_o: i1, req_pwrdn_o: i1, clr_slow_req_o: i1, usb_ip_clk_status_o: i1, wkup_o: i1, fall_through_o: i1, abort_o: i1, clr_hint_o: i1, clr_cfg_lock_o: i1, pwr_rst_o: !hw.struct<rst_lc_req: i2, rst_sys_req: i2, rstreqs: i5, reset_cause: i2>, ips_clk_en_o: !hw.struct<main_ip_clk_en: i1, io_ip_clk_en: i1, usb_ip_clk_en: i1>, otp_init_o: i1, lc_init_o: i1, strap_o: i1, strap_sampled_o: i1, low_power_o: i1, fetch_en_o: i4) {sv.namehint = "clr_hint"}
    llhd.drv %wkup, %u_fsm.wkup_o after %1 : i1
    llhd.drv %clr_cfg_lock, %u_fsm.clr_cfg_lock_o after %1 : i1
    llhd.drv %33, %u_fsm.otp_init_o after %1 : i1
    llhd.drv %34, %u_fsm.lc_init_o after %1 : i1
    %wake_info_capture_dis = hw.struct_extract %u_reg.reg2hw["wake_info_capture_dis"] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %q_9 = hw.struct_extract %wake_info_capture_dis["q"] : !hw.struct<q: i1>
    %wakeups_10 = hw.struct_extract %u_cdc.peri_reqs_o["wakeups"] : !hw.struct<wakeups: i6, rstreqs: i6>
    %37 = llhd.sig.struct_extract %hw2reg["wake_info"] : <!hw.struct<intr_state: !hw.struct<d: i1, de: i1>, ctrl_cfg_regwen: !hw.struct<d: i1>, control: !hw.struct<low_power_hint: !hw.struct<d: i1, de: i1>>, cfg_cdc_sync: !hw.struct<d: i1, de: i1>, wake_status: !hw.array<6xstruct<d: i1, de: i1>>, reset_status: !hw.array<2xstruct<d: i1, de: i1>>, escalate_reset_status: !hw.struct<d: i1, de: i1>, wake_info: !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>>
    %i_wake_info.info_o = hw.instance "i_wake_info" @pwrmgr_wake_info(clk_i: %9: i1, rst_ni: %10: i1, wr_i: %121: i1, data_i: %122: i8, start_capture_i: %u_fsm.low_power_o: i1, record_dis_i: %q_9: i1, wakeups_i: %wakeups_10: i6, fall_through_i: %u_fsm.fall_through_o: i1, abort_i: %u_fsm.abort_o: i1) -> (info_o: !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>)
    llhd.drv %37, %i_wake_info.info_o after %1 : !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>
    %38 = llhd.prb %wkup : i1
    %intr_enable = hw.struct_extract %u_reg.reg2hw["intr_enable"] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %q_11 = hw.struct_extract %intr_enable["q"] : !hw.struct<q: i1>
    %intr_test = hw.struct_extract %u_reg.reg2hw["intr_test"] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %q_12 = hw.struct_extract %intr_test["q"] : !hw.struct<q: i1, qe: i1>
    %qe_13 = hw.struct_extract %intr_test["qe"] : !hw.struct<q: i1, qe: i1>
    %intr_state = hw.struct_extract %u_reg.reg2hw["intr_state"] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %q_14 = hw.struct_extract %intr_state["q"] : !hw.struct<q: i1>
    %39 = llhd.sig.struct_extract %hw2reg["intr_state"] : <!hw.struct<intr_state: !hw.struct<d: i1, de: i1>, ctrl_cfg_regwen: !hw.struct<d: i1>, control: !hw.struct<low_power_hint: !hw.struct<d: i1, de: i1>>, cfg_cdc_sync: !hw.struct<d: i1, de: i1>, wake_status: !hw.array<6xstruct<d: i1, de: i1>>, reset_status: !hw.array<2xstruct<d: i1, de: i1>>, escalate_reset_status: !hw.struct<d: i1, de: i1>, wake_info: !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>>
    %40 = llhd.sig.struct_extract %39["de"] : <!hw.struct<d: i1, de: i1>>
    %41 = llhd.sig.struct_extract %39["d"] : <!hw.struct<d: i1, de: i1>>
    %intr_wakeup.hw2reg_intr_state_de_o, %intr_wakeup.hw2reg_intr_state_d_o, %intr_wakeup.intr_o = hw.instance "intr_wakeup" @prim_intr_hw(clk_i: %9: i1, rst_ni: %10: i1, event_intr_i: %38: i1, reg2hw_intr_enable_q_i: %q_11: i1, reg2hw_intr_test_q_i: %q_12: i1, reg2hw_intr_test_qe_i: %qe_13: i1, reg2hw_intr_state_q_i: %q_14: i1) -> (hw2reg_intr_state_de_o: i1, hw2reg_intr_state_d_o: i1, intr_o: i1)
    llhd.drv %40, %intr_wakeup.hw2reg_intr_state_de_o after %1 : i1
    llhd.drv %41, %intr_wakeup.hw2reg_intr_state_d_o after %1 : i1
    llhd.drv %clk_lc, %clk_lc_i after %1 : i1
    llhd.drv %rst_lc_n, %rst_lc_ni after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %126 = llhd.prb %clk_lc : i1
      %127 = llhd.prb %rst_lc_n : i1
      llhd.wait (%11, %12 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %128 = llhd.prb %clk_lc : i1
      %129 = comb.xor bin %126, %true : i1
      %130 = comb.and bin %129, %128 : i1
      %131 = llhd.prb %rst_lc_n : i1
      %132 = comb.xor bin %131, %true : i1
      %133 = comb.and bin %127, %132 : i1
      %134 = comb.or bin %130, %133 : i1
      cf.cond_br %134, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %135 = llhd.prb %rst_lc_n : i1
      %136 = comb.xor %135, %true : i1
      cf.cond_br %136, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %esc_rst_req_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %137 = llhd.prb %esc_rst_req_d : i1
      cf.cond_br %137, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %esc_rst_req_q, %true after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %126 = llhd.prb %clk_lc : i1
      %127 = llhd.prb %rst_lc_n : i1
      llhd.wait (%11, %12 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %128 = llhd.prb %clk_lc : i1
      %129 = comb.xor bin %126, %true : i1
      %130 = comb.and bin %129, %128 : i1
      %131 = llhd.prb %rst_lc_n : i1
      %132 = comb.xor bin %131, %true : i1
      %133 = comb.and bin %127, %132 : i1
      %134 = comb.or bin %130, %133 : i1
      cf.cond_br %134, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %135 = llhd.prb %rst_lc_n : i1
      %136 = comb.xor %135, %true : i1
      cf.cond_br %136, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %esc_timeout_lc_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %137 = llhd.prb %esc_timeout_lc_d : i1
      cf.cond_br %137, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %esc_timeout_lc_q, %true after %0 : i1
      cf.br ^bb1
    }
    %42 = llhd.sig.struct_extract %peri_reqs_raw["wakeups"] : <!hw.struct<wakeups: i6, rstreqs: i6>>
    llhd.drv %42, %wakeups_i after %1 : i6
    %43 = llhd.sig.struct_extract %peri_reqs_raw["rstreqs"] : <!hw.struct<wakeups: i6, rstreqs: i6>>
    %44 = llhd.sig.extract %43 from %c0_i3 : <i6> -> <i2>
    llhd.drv %44, %rstreqs_i after %1 : i2
    %45 = llhd.sig.extract %43 from %c2_i3 : <i6> -> <i1>
    llhd.drv %45, %u_slow_fsm.rst_req_o after %1 : i1
    %46 = llhd.sig.extract %43 from %c3_i3 : <i6> -> <i1>
    %47 = llhd.prb %esc_rst_req_q : i1
    %48 = llhd.prb %esc_timeout_lc_q : i1
    %49 = comb.or %47, %48 : i1
    llhd.drv %46, %49 after %1 : i1
    %50 = llhd.sig.extract %43 from %c-4_i3 : <i6> -> <i1>
    llhd.drv %50, %u_ndm_sync.q_o after %1 : i1
    %51 = llhd.sig.extract %43 from %c-3_i3 : <i6> -> <i1>
    llhd.drv %51, %u_sw_req_buf.out_o after %1 : i1
    %52 = llhd.sig.struct_extract %hw2reg["control"] : <!hw.struct<intr_state: !hw.struct<d: i1, de: i1>, ctrl_cfg_regwen: !hw.struct<d: i1>, control: !hw.struct<low_power_hint: !hw.struct<d: i1, de: i1>>, cfg_cdc_sync: !hw.struct<d: i1, de: i1>, wake_status: !hw.array<6xstruct<d: i1, de: i1>>, reset_status: !hw.array<2xstruct<d: i1, de: i1>>, escalate_reset_status: !hw.struct<d: i1, de: i1>, wake_info: !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>>
    %53 = llhd.sig.struct_extract %52["low_power_hint"] : <!hw.struct<low_power_hint: !hw.struct<d: i1, de: i1>>>
    %54 = llhd.sig.struct_extract %53["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %54, %false after %1 : i1
    %55 = llhd.sig.struct_extract %53["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %55, %u_fsm.clr_hint_o after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %126 = llhd.prb %clk_i_0 : i1
      %127 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%9, %10 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %128 = llhd.prb %clk_i_0 : i1
      %129 = comb.xor bin %126, %true : i1
      %130 = comb.and bin %129, %128 : i1
      %131 = llhd.prb %rst_ni_1 : i1
      %132 = comb.xor bin %131, %true : i1
      %133 = comb.and bin %127, %132 : i1
      %134 = comb.or bin %130, %133 : i1
      cf.cond_br %134, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %135 = llhd.prb %rst_ni_1 : i1
      %136 = comb.xor %135, %true : i1
      cf.cond_br %136, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %lowpwr_cfg_wen, %true after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %137 = llhd.prb %lowpwr_cfg_wen : i1
      %138 = comb.xor %137, %true : i1
      %139 = llhd.prb %clr_cfg_lock : i1
      %140 = llhd.prb %wkup : i1
      %141 = comb.or %139, %140 : i1
      %142 = comb.and %138, %141 : i1
      cf.cond_br %142, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %lowpwr_cfg_wen, %true after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %143 = llhd.prb %low_power_entry : i1
      cf.cond_br %143, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %lowpwr_cfg_wen, %false after %0 : i1
      cf.br ^bb1
    }
    %56 = llhd.sig.struct_extract %hw2reg["ctrl_cfg_regwen"] : <!hw.struct<intr_state: !hw.struct<d: i1, de: i1>, ctrl_cfg_regwen: !hw.struct<d: i1>, control: !hw.struct<low_power_hint: !hw.struct<d: i1, de: i1>>, cfg_cdc_sync: !hw.struct<d: i1, de: i1>, wake_status: !hw.array<6xstruct<d: i1, de: i1>>, reset_status: !hw.array<2xstruct<d: i1, de: i1>>, escalate_reset_status: !hw.struct<d: i1, de: i1>, wake_info: !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>>
    %57 = llhd.sig.struct_extract %56["d"] : <!hw.struct<d: i1>>
    %58 = llhd.prb %lowpwr_cfg_wen : i1
    llhd.drv %57, %58 after %1 : i1
    %59 = llhd.sig.struct_extract %hw2reg["fault_status"] : <!hw.struct<intr_state: !hw.struct<d: i1, de: i1>, ctrl_cfg_regwen: !hw.struct<d: i1>, control: !hw.struct<low_power_hint: !hw.struct<d: i1, de: i1>>, cfg_cdc_sync: !hw.struct<d: i1, de: i1>, wake_status: !hw.array<6xstruct<d: i1, de: i1>>, reset_status: !hw.array<2xstruct<d: i1, de: i1>>, escalate_reset_status: !hw.struct<d: i1, de: i1>, wake_info: !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>>
    %60 = llhd.sig.struct_extract %59["reg_intg_err"] : <!hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %61 = llhd.sig.struct_extract %60["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %61, %u_reg.intg_err_o after %1 : i1
    %62 = llhd.sig.struct_extract %60["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %62, %true after %1 : i1
    %63 = llhd.sig.struct_extract %59["esc_timeout"] : <!hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %64 = llhd.sig.struct_extract %63["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %64, %48 after %1 : i1
    %65 = llhd.sig.struct_extract %63["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %65, %true after %1 : i1
    %66 = llhd.sig.struct_extract %59["main_pd_glitch"] : <!hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %67 = llhd.sig.struct_extract %66["de"] : <!hw.struct<d: i1, de: i1>>
    %main_ip_clk_en = hw.struct_extract %u_fsm.ips_clk_en_o["main_ip_clk_en"] : !hw.struct<main_ip_clk_en: i1, io_ip_clk_en: i1, usb_ip_clk_en: i1>
    llhd.drv %67, %main_ip_clk_en after %1 : i1
    %68 = llhd.sig.struct_extract %66["d"] : <!hw.struct<d: i1, de: i1>>
    %69 = comb.extract %rstreqs_8 from 2 : (i6) -> i1
    %fault_status = hw.struct_extract %u_reg.reg2hw["fault_status"] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %main_pd_glitch = hw.struct_extract %fault_status["main_pd_glitch"] : !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>
    %q_15 = hw.struct_extract %main_pd_glitch["q"] : !hw.struct<q: i1>
    %70 = comb.or %69, %q_15 : i1
    llhd.drv %68, %70 after %1 : i1
    %alert_test = hw.struct_extract %u_reg.reg2hw["alert_test"] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %q_16 = hw.struct_extract %alert_test["q"] : !hw.struct<q: i1, qe: i1>
    %qe_17 = hw.struct_extract %alert_test["qe"] : !hw.struct<q: i1, qe: i1>
    %71 = comb.and %q_16, %qe_17 : i1
    %reg_intg_err = hw.struct_extract %fault_status["reg_intg_err"] : !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>
    %q_18 = hw.struct_extract %reg_intg_err["q"] : !hw.struct<q: i1>
    %esc_timeout = hw.struct_extract %fault_status["esc_timeout"] : !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>
    %q_19 = hw.struct_extract %esc_timeout["q"] : !hw.struct<q: i1>
    %72 = comb.or %q_18, %q_19, %q_15 : i1
    llhd.drv %alerts, %72 after %1 : i1
    %73 = llhd.sig.array_get %rom_ctrl_done_async[%c0_i0] : <!hw.array<1xi4>>
    %74 = llhd.prb %rom_ctrl_i_2 : !hw.array<1xstruct<done: i4, good: i4>>
    %75 = hw.array_get %74[%c0_i0] : !hw.array<1xstruct<done: i4, good: i4>>, i0
    %done = hw.struct_extract %75["done"] : !hw.struct<done: i4, good: i4>
    llhd.drv %73, %done after %1 : i4
    %76 = llhd.prb %rom_ctrl_done : !hw.array<1xi4>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb4
      llhd.drv %rom_ctrl_done_combined, %c6_i4 after %1 : i4
      llhd.drv %rom_ctrl_good_combined, %c6_i4 after %1 : i4
      cf.br ^bb2(%c0_i32 : i32)
    ^bb2(%126: i32):  // 2 preds: ^bb1, ^bb3
      %127 = comb.icmp slt %126, %c1_i32 : i32
      cf.cond_br %127, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %128 = llhd.prb %rom_ctrl_done_combined : i4
      %129 = llhd.prb %rom_ctrl_done : !hw.array<1xi4>
      %130 = comb.icmp eq %126, %c0_i32 : i32
      %131 = comb.extract %126 from 0 : (i32) -> i0
      %132 = comb.mux %130, %131, %c0_i0 : i0
      %133 = hw.array_get %129[%132] : !hw.array<1xi4>, i0
      %134 = func.call @"prim_mubi_pkg::mubi4_and_hi"(%128, %133) : (i4, i4) -> i4
      llhd.drv %rom_ctrl_done_combined, %134 after %1 : i4
      %135 = llhd.prb %rom_ctrl_good_combined : i4
      %136 = llhd.prb %rom_ctrl_i_2 : !hw.array<1xstruct<done: i4, good: i4>>
      %137 = hw.array_get %136[%132] : !hw.array<1xstruct<done: i4, good: i4>>, i0
      %good = hw.struct_extract %137["good"] : !hw.struct<done: i4, good: i4>
      %138 = func.call @"prim_mubi_pkg::mubi4_and_hi"(%135, %good) : (i4, i4) -> i4
      llhd.drv %rom_ctrl_good_combined, %138 after %1 : i4
      %139 = comb.add %126, %c1_i32 : i32
      cf.br ^bb2(%139 : i32)
    ^bb4:  // pred: ^bb2
      llhd.wait (%35, %36, %76, %74 : i4, i4, !hw.array<1xi4>, !hw.array<1xstruct<done: i4, good: i4>>), ^bb1
    }
    %77 = llhd.sig.struct_extract %22["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %77, %false after %1 : i1
    %78 = llhd.sig.struct_extract %slow_peri_reqs_masked["wakeups"] : <!hw.struct<wakeups: i6, rstreqs: i6>>
    %wakeups_20 = hw.struct_extract %u_cdc.slow_peri_reqs_o["wakeups"] : !hw.struct<wakeups: i6, rstreqs: i6>
    %79 = comb.and %wakeups_20, %u_cdc.slow_wakeup_en_o : i6
    llhd.drv %78, %79 after %1 : i6
    %80 = llhd.sig.struct_extract %slow_peri_reqs_masked["rstreqs"] : <!hw.struct<wakeups: i6, rstreqs: i6>>
    %rstreqs_21 = hw.struct_extract %u_cdc.slow_peri_reqs_o["rstreqs"] : !hw.struct<wakeups: i6, rstreqs: i6>
    %81 = comb.concat %c-1_i4, %u_cdc.slow_reset_en_o : i4, i2
    %82 = comb.and %rstreqs_21, %81 : i6
    llhd.drv %80, %82 after %1 : i6
    %83 = llhd.sig.struct_extract %hw2reg["wake_status"] : <!hw.struct<intr_state: !hw.struct<d: i1, de: i1>, ctrl_cfg_regwen: !hw.struct<d: i1>, control: !hw.struct<low_power_hint: !hw.struct<d: i1, de: i1>>, cfg_cdc_sync: !hw.struct<d: i1, de: i1>, wake_status: !hw.array<6xstruct<d: i1, de: i1>>, reset_status: !hw.array<2xstruct<d: i1, de: i1>>, escalate_reset_status: !hw.struct<d: i1, de: i1>, wake_info: !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>>
    %84 = llhd.sig.array_get %83[%c0_i3] : <!hw.array<6xstruct<d: i1, de: i1>>>
    %85 = llhd.sig.struct_extract %84["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %85, %true after %1 : i1
    %86 = llhd.sig.struct_extract %84["d"] : <!hw.struct<d: i1, de: i1>>
    %87 = comb.extract %wakeups_10 from 0 : (i6) -> i1
    llhd.drv %86, %87 after %1 : i1
    %88 = llhd.sig.array_get %83[%c1_i3] : <!hw.array<6xstruct<d: i1, de: i1>>>
    %89 = llhd.sig.struct_extract %88["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %89, %true after %1 : i1
    %90 = llhd.sig.struct_extract %88["d"] : <!hw.struct<d: i1, de: i1>>
    %91 = comb.extract %wakeups_10 from 1 : (i6) -> i1
    llhd.drv %90, %91 after %1 : i1
    %92 = llhd.sig.array_get %83[%c2_i3] : <!hw.array<6xstruct<d: i1, de: i1>>>
    %93 = llhd.sig.struct_extract %92["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %93, %true after %1 : i1
    %94 = llhd.sig.struct_extract %92["d"] : <!hw.struct<d: i1, de: i1>>
    %95 = comb.extract %wakeups_10 from 2 : (i6) -> i1
    llhd.drv %94, %95 after %1 : i1
    %96 = llhd.sig.array_get %83[%c3_i3] : <!hw.array<6xstruct<d: i1, de: i1>>>
    %97 = llhd.sig.struct_extract %96["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %97, %true after %1 : i1
    %98 = llhd.sig.struct_extract %96["d"] : <!hw.struct<d: i1, de: i1>>
    %99 = comb.extract %wakeups_10 from 3 : (i6) -> i1
    llhd.drv %98, %99 after %1 : i1
    %100 = llhd.sig.array_get %83[%c-4_i3] : <!hw.array<6xstruct<d: i1, de: i1>>>
    %101 = llhd.sig.struct_extract %100["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %101, %true after %1 : i1
    %102 = llhd.sig.struct_extract %100["d"] : <!hw.struct<d: i1, de: i1>>
    %103 = comb.extract %wakeups_10 from 4 : (i6) -> i1
    llhd.drv %102, %103 after %1 : i1
    %104 = llhd.sig.array_get %83[%c-3_i3] : <!hw.array<6xstruct<d: i1, de: i1>>>
    %105 = llhd.sig.struct_extract %104["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %105, %true after %1 : i1
    %106 = llhd.sig.struct_extract %104["d"] : <!hw.struct<d: i1, de: i1>>
    %107 = comb.extract %wakeups_10 from 5 : (i6) -> i1
    llhd.drv %106, %107 after %1 : i1
    %108 = llhd.sig.struct_extract %hw2reg["reset_status"] : <!hw.struct<intr_state: !hw.struct<d: i1, de: i1>, ctrl_cfg_regwen: !hw.struct<d: i1>, control: !hw.struct<low_power_hint: !hw.struct<d: i1, de: i1>>, cfg_cdc_sync: !hw.struct<d: i1, de: i1>, wake_status: !hw.array<6xstruct<d: i1, de: i1>>, reset_status: !hw.array<2xstruct<d: i1, de: i1>>, escalate_reset_status: !hw.struct<d: i1, de: i1>, wake_info: !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>>
    %109 = llhd.sig.array_get %108[%false] : <!hw.array<2xstruct<d: i1, de: i1>>>
    %110 = llhd.sig.struct_extract %109["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %110, %true after %1 : i1
    %111 = llhd.sig.struct_extract %109["d"] : <!hw.struct<d: i1, de: i1>>
    %112 = comb.extract %rstreqs_8 from 0 : (i6) -> i1
    llhd.drv %111, %112 after %1 : i1
    %113 = llhd.sig.array_get %108[%true] : <!hw.array<2xstruct<d: i1, de: i1>>>
    %114 = llhd.sig.struct_extract %113["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %114, %true after %1 : i1
    %115 = llhd.sig.struct_extract %113["d"] : <!hw.struct<d: i1, de: i1>>
    %116 = comb.extract %rstreqs_8 from 1 : (i6) -> i1
    llhd.drv %115, %116 after %1 : i1
    %117 = llhd.sig.struct_extract %hw2reg["escalate_reset_status"] : <!hw.struct<intr_state: !hw.struct<d: i1, de: i1>, ctrl_cfg_regwen: !hw.struct<d: i1>, control: !hw.struct<low_power_hint: !hw.struct<d: i1, de: i1>>, cfg_cdc_sync: !hw.struct<d: i1, de: i1>, wake_status: !hw.array<6xstruct<d: i1, de: i1>>, reset_status: !hw.array<2xstruct<d: i1, de: i1>>, escalate_reset_status: !hw.struct<d: i1, de: i1>, wake_info: !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<d: i1, de: i1>, esc_timeout: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>>
    %118 = llhd.sig.struct_extract %117["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %118, %true after %1 : i1
    %119 = llhd.sig.struct_extract %117["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %119, %69 after %1 : i1
    %low_power_hint = hw.struct_extract %control["low_power_hint"] : !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>
    %q_22 = hw.struct_extract %low_power_hint["q"] {sv.namehint = "low_power_hint"} : !hw.struct<q: i1>
    %120 = comb.and %u_cdc.core_sleeping_o, %q_22 : i1
    llhd.drv %low_power_entry, %120 after %1 : i1
    %wake_info = hw.struct_extract %u_reg.reg2hw["wake_info"] : !hw.struct<intr_state: !hw.struct<q: i1>, intr_enable: !hw.struct<q: i1>, intr_test: !hw.struct<q: i1, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<main_pd_n: !hw.struct<q: i1>, usb_clk_en_active: !hw.struct<q: i1>, usb_clk_en_lp: !hw.struct<q: i1>, io_clk_en: !hw.struct<q: i1>, core_clk_en: !hw.struct<q: i1>, low_power_hint: !hw.struct<q: i1>>, cfg_cdc_sync: !hw.struct<q: i1, qe: i1>, wakeup_en: !hw.array<6xstruct<q: i1>>, reset_en: !hw.struct<en_1: !hw.struct<q: i1>, en_0: !hw.struct<q: i1>>, wake_info_capture_dis: !hw.struct<q: i1>, wake_info: !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>, fault_status: !hw.struct<main_pd_glitch: !hw.struct<q: i1>, esc_timeout: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %abort = hw.struct_extract %wake_info["abort"] : !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>
    %qe_23 = hw.struct_extract %abort["qe"] : !hw.struct<q: i1, qe: i1>
    %fall_through = hw.struct_extract %wake_info["fall_through"] : !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>
    %qe_24 = hw.struct_extract %fall_through["qe"] : !hw.struct<q: i1, qe: i1>
    %reasons = hw.struct_extract %wake_info["reasons"] : !hw.struct<abort: !hw.struct<q: i1, qe: i1>, fall_through: !hw.struct<q: i1, qe: i1>, reasons: !hw.struct<q: i6, qe: i1>>
    %qe_25 = hw.struct_extract %reasons["qe"] : !hw.struct<q: i6, qe: i1>
    %121 = comb.or %qe_23, %qe_24, %qe_25 {sv.namehint = "wake_info_wen"} : i1
    %q_26 = hw.struct_extract %abort["q"] : !hw.struct<q: i1, qe: i1>
    %q_27 = hw.struct_extract %fall_through["q"] : !hw.struct<q: i1, qe: i1>
    %q_28 = hw.struct_extract %reasons["q"] : !hw.struct<q: i6, qe: i1>
    %122 = comb.concat %q_26, %q_27, %q_28 {sv.namehint = "wake_info_data"} : i1, i1, i6
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    %123 = llhd.prb %alert_tx_o : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    %124 = llhd.prb %pwr_otp_o : !hw.struct<otp_init: i1>
    %125 = llhd.prb %pwr_lc_o : !hw.struct<lc_init: i1>
    llhd.drv %rom_ctrl_i_2, %rom_ctrl_i after %1 : !hw.array<1xstruct<done: i4, good: i4>>
    hw.output %u_reg.tl_o, %123, %u_slow_fsm.ast_o, %u_fsm.pwr_rst_o, %u_fsm.ips_clk_en_o, %124, %125, %u_fsm.fetch_en_o, %u_fsm.strap_o, %u_fsm.low_power_o, %u_esc_rx.esc_rx_o, %intr_wakeup.intr_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.array<1xstruct<alert_p: i1, alert_n: i1>>, !hw.struct<main_pd_n: i1, pwr_clamp_env: i1, pwr_clamp: i1, slow_clk_en: i1, core_clk_en: i1, io_clk_en: i1, usb_clk_en: i1>, !hw.struct<rst_lc_req: i2, rst_sys_req: i2, rstreqs: i5, reset_cause: i2>, !hw.struct<main_ip_clk_en: i1, io_ip_clk_en: i1, usb_ip_clk_en: i1>, !hw.struct<otp_init: i1>, !hw.struct<lc_init: i1>, i4, i1, i1, !hw.struct<resp_p: i1, resp_n: i1>, i1
  }
  hw.module private @pwrmgr_wake_info(in %clk_i : i1, in %rst_ni : i1, in %wr_i : i1, in %data_i : i8, in %start_capture_i : i1, in %record_dis_i : i1, in %wakeups_i : i6, in %fall_through_i : i1, in %abort_i : i1, out info_o : !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>) {
    %c-2_i3 = hw.constant -2 : i3
    %c0_i3 = hw.constant 0 : i3
    %c-1_i8 = hw.constant -1 : i8
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %2 = hw.aggregate_constant [[false], [false], [0 : i6]] : !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>
    %c0_i6 = hw.constant 0 : i6
    %c0_i8 = hw.constant 0 : i8
    %false = hw.constant false
    %true = hw.constant true
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %wr_i_2 = llhd.sig name "wr_i" %false : i1
    %data_i_3 = llhd.sig name "data_i" %c0_i8 : i8
    %start_capture_i_4 = llhd.sig name "start_capture_i" %false : i1
    %record_dis_i_5 = llhd.sig name "record_dis_i" %false : i1
    %wakeups_i_6 = llhd.sig name "wakeups_i" %c0_i6 : i6
    %fall_through_i_7 = llhd.sig name "fall_through_i" %false : i1
    %abort_i_8 = llhd.sig name "abort_i" %false : i1
    %info_o = llhd.sig %2 : !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>
    %record_en = llhd.sig %false : i1
    %start_capture_q1 = llhd.sig %false : i1
    %start_capture = llhd.sig %false : i1
    %info = llhd.sig %c0_i8 : i8
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %20 = llhd.prb %clk_i_0 : i1
      %21 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %22 = llhd.prb %clk_i_0 : i1
      %23 = comb.xor bin %20, %true : i1
      %24 = comb.and bin %23, %22 : i1
      %25 = llhd.prb %rst_ni_1 : i1
      %26 = comb.xor bin %25, %true : i1
      %27 = comb.and bin %21, %26 : i1
      %28 = comb.or bin %24, %27 : i1
      cf.cond_br %28, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %29 = llhd.prb %rst_ni_1 : i1
      %30 = comb.xor %29, %true : i1
      cf.cond_br %30, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %start_capture_q1, %true after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %31 = llhd.prb %start_capture_i_4 : i1
      llhd.drv %start_capture_q1, %31 after %1 : i1
      cf.br ^bb1
    }
    %5 = llhd.prb %start_capture_i_4 : i1
    %6 = llhd.prb %start_capture_q1 : i1
    %7 = comb.xor %6, %true : i1
    %8 = comb.and %5, %7 : i1
    llhd.drv %start_capture, %8 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %20 = llhd.prb %clk_i_0 : i1
      %21 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %22 = llhd.prb %clk_i_0 : i1
      %23 = comb.xor bin %20, %true : i1
      %24 = comb.and bin %23, %22 : i1
      %25 = llhd.prb %rst_ni_1 : i1
      %26 = comb.xor bin %25, %true : i1
      %27 = comb.and bin %21, %26 : i1
      %28 = comb.or bin %24, %27 : i1
      cf.cond_br %28, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %29 = llhd.prb %rst_ni_1 : i1
      %30 = comb.xor %29, %true : i1
      cf.cond_br %30, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %record_en, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %31 = llhd.prb %start_capture : i1
      %32 = llhd.prb %record_dis_i_5 : i1
      %33 = comb.xor %32, %true : i1
      %34 = comb.and %31, %33 : i1
      cf.cond_br %34, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %record_en, %true after %1 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %35 = llhd.prb %record_dis_i_5 : i1
      %36 = llhd.prb %record_en : i1
      %37 = comb.and %35, %36 : i1
      cf.cond_br %37, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %record_en, %false after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %20 = llhd.prb %clk_i_0 : i1
      %21 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %22 = llhd.prb %clk_i_0 : i1
      %23 = comb.xor bin %20, %true : i1
      %24 = comb.and bin %23, %22 : i1
      %25 = llhd.prb %rst_ni_1 : i1
      %26 = comb.xor bin %25, %true : i1
      %27 = comb.and bin %21, %26 : i1
      %28 = comb.or bin %24, %27 : i1
      cf.cond_br %28, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %29 = llhd.prb %rst_ni_1 : i1
      %30 = comb.xor %29, %true : i1
      cf.cond_br %30, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %info, %c0_i8 after %1 : i8
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %31 = llhd.prb %wr_i_2 : i1
      cf.cond_br %31, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %32 = llhd.prb %info : i8
      %33 = llhd.prb %data_i_3 : i8
      %34 = comb.xor %33, %c-1_i8 : i8
      %35 = comb.and %32, %34 : i8
      llhd.drv %info, %35 after %1 : i8
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %36 = llhd.prb %record_en : i1
      cf.cond_br %36, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %37 = llhd.sig.extract %info from %c0_i3 : <i8> -> <i6>
      %38 = llhd.prb %info : i8
      %39 = comb.extract %38 from 0 : (i8) -> i6
      %40 = llhd.prb %wakeups_i_6 : i6
      %41 = comb.or %39, %40 : i6
      llhd.drv %37, %41 after %1 : i6
      %42 = llhd.sig.extract %info from %c-2_i3 : <i8> -> <i2>
      %43 = llhd.prb %info : i8
      %44 = comb.extract %43 from 6 : (i8) -> i2
      %45 = llhd.prb %abort_i_8 : i1
      %46 = llhd.prb %fall_through_i_7 : i1
      %47 = comb.concat %45, %46 : i1, i1
      %48 = comb.or %44, %47 : i2
      llhd.drv %42, %48 after %1 : i2
      cf.br ^bb1
    }
    %9 = llhd.sig.struct_extract %info_o["abort"] : <!hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>>
    %10 = llhd.sig.struct_extract %9["d"] : <!hw.struct<d: i1>>
    %11 = llhd.prb %info : i8
    %12 = comb.extract %11 from 7 : (i8) -> i1
    llhd.drv %10, %12 after %0 : i1
    %13 = llhd.sig.struct_extract %info_o["fall_through"] : <!hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>>
    %14 = llhd.sig.struct_extract %13["d"] : <!hw.struct<d: i1>>
    %15 = comb.extract %11 from 6 : (i8) -> i1
    llhd.drv %14, %15 after %0 : i1
    %16 = llhd.sig.struct_extract %info_o["reasons"] : <!hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>>
    %17 = comb.extract %11 from 0 : (i8) -> i6
    %18 = hw.bitcast %17 : (i6) -> !hw.struct<d: i6>
    llhd.drv %16, %18 after %0 : !hw.struct<d: i6>
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %wr_i_2, %wr_i after %0 : i1
    llhd.drv %data_i_3, %data_i after %0 : i8
    llhd.drv %start_capture_i_4, %start_capture_i after %0 : i1
    llhd.drv %record_dis_i_5, %record_dis_i after %0 : i1
    llhd.drv %wakeups_i_6, %wakeups_i after %0 : i6
    llhd.drv %fall_through_i_7, %fall_through_i after %0 : i1
    llhd.drv %abort_i_8, %abort_i after %0 : i1
    %19 = llhd.prb %info_o : !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>
    hw.output %19 : !hw.struct<abort: !hw.struct<d: i1>, fall_through: !hw.struct<d: i1>, reasons: !hw.struct<d: i6>>
  }
}
