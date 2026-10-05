module {
  hw.module private @prim_and2(in %in0_i : i109, in %in1_i : i109, out out_o : i109) {
    %0 = comb.and %in0_i, %in1_i : i109
    hw.output %0 : i109
  }
  hw.module private @prim_and2_29(in %in0_i : i66, in %in1_i : i66, out out_o : i66) {
    %0 = comb.and %in0_i, %in1_i : i66
    hw.output %0 : i66
  }
  hw.module private @prim_buf(in %in_i : i256, out out_o : i256) {
    hw.output %in_i : i256
  }
  hw.module private @prim_buf_10(in %in_i : i1, out out_o : i1) {
    hw.output %in_i : i1
  }
  hw.module private @prim_buf_13(in %in_i : i4, out out_o : i4) {
    hw.output %in_i : i4
  }
  hw.module private @prim_buf_17(in %in_i : i9, out out_o : i9) {
    hw.output %in_i : i9
  }
  hw.module private @prim_buf_23(in %in_i : i2, out out_o : i2) {
    hw.output %in_i : i2
  }
  hw.module private @prim_flop_2sync(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
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
  hw.module private @prim_flop_2sync_9(in %clk_i : i1, in %rst_ni : i1, in %d_i : i8, out q_o : i8) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i8 = hw.constant 0 : i8
    %d_i_0 = llhd.sig name "d_i" %c0_i8 : i8
    %d_o = llhd.sig %c0_i8 : i8
    %1 = llhd.prb %d_o : i8
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_28(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i8) -> (q_o: i8) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_28(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i8) -> (q_o: i8)
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
  hw.module private @prim_flop_2sync_24(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
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
  hw.module private @prim_flop_2sync_25(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %d_i_0 = llhd.sig name "d_i" %false : i1
    %d_o = llhd.sig %false : i1
    %1 = llhd.prb %d_o : i1
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_34(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i1) -> (q_o: i1) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_34(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i1) -> (q_o: i1)
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
  hw.module private @prim_flop_7(in %clk_i : i1, in %rst_ni : i1, in %d_i : i10, out q_o : i10) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i10 = hw.constant 0 : i10
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
      llhd.drv %q_o, %c0_i10 after %1 : i10
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
  hw.module private @prim_flop_8(in %clk_i : i1, in %rst_ni : i1, in %d_i : i10, out q_o : i10) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i10 = hw.constant 0 : i10
    %c-1_i10 = hw.constant -1 : i10
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
      llhd.drv %q_o, %c-1_i10 after %1 : i10
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
  hw.module private @prim_flop_16(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
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
  hw.module private @prim_flop_26(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_o : i2) {
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
  hw.module private @prim_flop_27(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
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
  hw.module private @prim_flop_28(in %clk_i : i1, in %rst_ni : i1, in %d_i : i8, out q_o : i8) {
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
  hw.module private @prim_flop_30(in %clk_i : i1, in %rst_ni : i1, in %d_i : i9, out q_o : i9) {
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
  hw.module private @prim_flop_34(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
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
  hw.module private @prim_flop_35(in %clk_i : i1, in %rst_ni : i1, in %d_i : i32, out q_o : i32) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %d_i_2 = llhd.sig name "d_i" %c0_i32 : i32
    %q_o = llhd.sig %c0_i32 : i32
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
      llhd.drv %q_o, %c0_i32 after %1 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %16 = llhd.prb %d_i_2 : i32
      llhd.drv %q_o, %16 after %1 : i32
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %d_i_2, %d_i after %0 : i32
    %4 = llhd.prb %q_o : i32
    hw.output %4 : i32
  }
  hw.module private @prim_flop_36(in %clk_i : i1, in %rst_ni : i1, in %d_i : i7, out q_o : i7) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i7 = hw.constant 0 : i7
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %d_i_2 = llhd.sig name "d_i" %c0_i7 : i7
    %q_o = llhd.sig %c0_i7 : i7
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
      llhd.drv %q_o, %c0_i7 after %1 : i7
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %16 = llhd.prb %d_i_2 : i7
      llhd.drv %q_o, %16 after %1 : i7
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %d_i_2, %d_i after %0 : i7
    %4 = llhd.prb %q_o : i7
    hw.output %4 : i7
  }
  hw.module private @prim_flop_42(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_o : i2) {
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
  hw.module private @prim_flop_43(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_o : i2) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i2 = hw.constant 0 : i2
    %c-1_i2 = hw.constant -1 : i2
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
      llhd.drv %q_o, %c-1_i2 after %1 : i2
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
    %u_prim_buf_ping.out_o = hw.instance "u_prim_buf_ping" @prim_sec_anchor_buf_5(in_i: %5: i2) -> (out_o: i2)
    %6 = comb.extract %u_prim_buf_ping.out_o from 1 {sv.namehint = "ping_n"} : (i2) -> i1
    %7 = comb.extract %u_prim_buf_ping.out_o from 0 {sv.namehint = "ping_p"} : (i2) -> i1
    %u_decode_ping.level_o, %u_decode_ping.rise_o, %u_decode_ping.fall_o, %u_decode_ping.event_o, %u_decode_ping.sigint_o = hw.instance "u_decode_ping" @prim_diff_decode(clk_i: %3: i1, rst_ni: %4: i1, diff_pi: %7: i1, diff_ni: %6: i1) -> (level_o: i1, rise_o: i1, fall_o: i1, event_o: i1, sigint_o: i1) {sv.namehint = "ping_event"}
    %ack_n = hw.struct_extract %alert_rx_i["ack_n"] : !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>
    %ack_p = hw.struct_extract %alert_rx_i["ack_p"] : !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>
    %8 = comb.concat %ack_n, %ack_p : i1, i1
    %u_prim_buf_ack.out_o = hw.instance "u_prim_buf_ack" @prim_sec_anchor_buf_5(in_i: %8: i2) -> (out_o: i2)
    %9 = comb.extract %u_prim_buf_ack.out_o from 1 {sv.namehint = "ack_n"} : (i2) -> i1
    %10 = comb.extract %u_prim_buf_ack.out_o from 0 {sv.namehint = "ack_p"} : (i2) -> i1
    %u_decode_ack.level_o, %u_decode_ack.rise_o, %u_decode_ack.fall_o, %u_decode_ack.event_o, %u_decode_ack.sigint_o = hw.instance "u_decode_ack" @prim_diff_decode(clk_i: %3: i1, rst_ni: %4: i1, diff_pi: %10: i1, diff_ni: %9: i1) -> (level_o: i1, rise_o: i1, fall_o: i1, event_o: i1, sigint_o: i1) {sv.namehint = "ack_sigint"}
    llhd.drv %ack_level, %u_decode_ack.level_o after %1 : i1
    %u_prim_buf_in_req.out_o = hw.instance "u_prim_buf_in_req" @prim_sec_anchor_buf_6(in_i: %alert_req_i: i1) -> (out_o: i1) {sv.namehint = "alert_req"}
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
  hw.module private @prim_blanker_12(in %in_i : i66, in %en_i : i1, out out_o : i66) {
    %0 = comb.replicate %en_i : (i1) -> i66
    %u_blank_and.out_o = hw.instance "u_blank_and" @prim_and2_29(in0_i: %in_i: i66, in1_i: %0: i66) -> (out_o: i66)
    hw.output %u_blank_and.out_o : i66
  }
  hw.module private @prim_count(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %set_i : i1, in %set_cnt_i : i10, in %incr_en_i : i1, in %decr_en_i : i1, in %step_i : i10, in %commit_i : i1, out cnt_o : i10, out cnt_after_commit_o : i10, out err_o : i1) {
    %c1023_i11 = hw.constant 1023 : i11
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i10 = hw.constant -1 : i10
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i11 = hw.constant 0 : i11
    %2 = hw.aggregate_constant [0 : i10, 0 : i10] : !hw.array<2xi10>
    %false = hw.constant false
    %true = hw.constant true
    %c0_i10 = hw.constant 0 : i10
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %set_i_2 = llhd.sig name "set_i" %false : i1
    %step_i_3 = llhd.sig name "step_i" %c0_i10 : i10
    %cnt_d = llhd.sig %2 : !hw.array<2xi10>
    %cnt_d_committed = llhd.sig %2 : !hw.array<2xi10>
    %cnt_q = llhd.sig %2 : !hw.array<2xi10>
    %gen_cnts_0.incr_en = llhd.sig %false : i1
    %gen_cnts_0.set_val = llhd.sig %c0_i10 : i10
    %gen_cnts_0.ext_cnt = llhd.sig %c0_i11 : i11
    %gen_cnts_0.oflow = llhd.sig %false : i1
    %gen_cnts_0.cnt_sat = llhd.sig %c0_i10 : i10
    %gen_cnts_0.cnt_en = llhd.sig %false : i1
    %gen_cnts_1.incr_en = llhd.sig %false : i1
    %gen_cnts_1.set_val = llhd.sig %c0_i10 : i10
    %gen_cnts_1.ext_cnt = llhd.sig %c0_i11 : i11
    %gen_cnts_1.oflow = llhd.sig %false : i1
    %gen_cnts_1.cnt_sat = llhd.sig %c0_i10 : i10
    %gen_cnts_1.cnt_en = llhd.sig %false : i1
    %err_d = llhd.sig %false : i1
    %err_q = llhd.sig %false : i1
    %5 = llhd.prb %cnt_d_committed : !hw.array<2xi10>
    %6 = hw.array_get %5[%false] : !hw.array<2xi10>, i1
    %gen_cnts_0.u_cnt_flop.q_o = hw.instance "gen_cnts_0.u_cnt_flop" @prim_flop_7(clk_i: %3: i1, rst_ni: %4: i1, d_i: %6: i10) -> (q_o: i10) {sv.namehint = "gen_cnts_0.cnt_unforced_q"}
    %7 = hw.array_get %5[%true] : !hw.array<2xi10>, i1
    %gen_cnts_1.u_cnt_flop.q_o = hw.instance "gen_cnts_1.u_cnt_flop" @prim_flop_8(clk_i: %3: i1, rst_ni: %4: i1, d_i: %7: i10) -> (q_o: i10) {sv.namehint = "gen_cnts_1.cnt_unforced_q"}
    llhd.drv %gen_cnts_0.incr_en, %incr_en_i after %1 : i1
    llhd.drv %gen_cnts_0.set_val, %set_cnt_i after %1 : i10
    %8 = llhd.prb %cnt_q : !hw.array<2xi10>
    %9 = hw.array_get %8[%false] : !hw.array<2xi10>, i1
    %10 = comb.concat %false, %9 : i1, i10
    %11 = llhd.prb %step_i_3 : i10
    %12 = comb.concat %false, %11 : i1, i10
    %13 = comb.sub %10, %12 : i11
    %14 = llhd.prb %gen_cnts_0.incr_en : i1
    %15 = comb.add %10, %12 : i11
    %16 = comb.mux %14, %15, %10 : i11
    %17 = comb.mux %decr_en_i, %13, %16 : i11
    llhd.drv %gen_cnts_0.ext_cnt, %17 after %1 : i11
    %18 = llhd.prb %gen_cnts_0.ext_cnt : i11
    %19 = comb.extract %18 from 10 : (i11) -> i1
    %20 = comb.and %14, %19 : i1
    llhd.drv %gen_cnts_0.oflow, %20 after %1 : i1
    %21 = comb.and %decr_en_i, %19 {sv.namehint = "gen_cnts_0.uflow"} : i1
    %22 = llhd.prb %gen_cnts_0.oflow : i1
    %23 = comb.extract %18 from 0 : (i11) -> i10
    %24 = comb.mux %22, %c-1_i10, %23 : i10
    %25 = comb.mux %21, %c0_i10, %24 : i10
    llhd.drv %gen_cnts_0.cnt_sat, %25 after %1 : i10
    %26 = comb.xor %14, %decr_en_i : i1
    %27 = comb.icmp ne %9, %c-1_i10 : i10
    %28 = comb.and %14, %27 : i1
    %29 = comb.icmp ne %9, %c0_i10 : i10
    %30 = comb.and %decr_en_i, %29 : i1
    %31 = comb.or %28, %30 : i1
    %32 = comb.and %26, %31 : i1
    llhd.drv %gen_cnts_0.cnt_en, %32 after %1 : i1
    %33 = llhd.sig.array_get %cnt_d[%false] : <!hw.array<2xi10>>
    %34 = llhd.prb %set_i_2 : i1
    %35 = llhd.prb %gen_cnts_0.set_val : i10
    %36 = llhd.prb %gen_cnts_0.cnt_en : i1
    %37 = llhd.prb %gen_cnts_0.cnt_sat : i10
    %38 = comb.mux %36, %37, %9 : i10
    %39 = comb.mux %34, %35, %38 : i10
    %40 = comb.mux %clr_i, %c0_i10, %39 : i10
    llhd.drv %33, %40 after %1 : i10
    %41 = llhd.sig.array_get %cnt_d_committed[%false] : <!hw.array<2xi10>>
    %42 = llhd.prb %cnt_d : !hw.array<2xi10>
    %43 = hw.array_get %42[%false] : !hw.array<2xi10>, i1
    %44 = comb.mux %commit_i, %43, %9 : i10
    llhd.drv %41, %44 after %1 : i10
    %45 = llhd.sig.array_get %cnt_q[%false] : <!hw.array<2xi10>>
    llhd.drv %45, %gen_cnts_0.u_cnt_flop.q_o after %1 : i10
    llhd.drv %gen_cnts_1.incr_en, %decr_en_i after %1 : i1
    %46 = comb.sub %c-1_i10, %set_cnt_i : i10
    llhd.drv %gen_cnts_1.set_val, %46 after %1 : i10
    %47 = hw.array_get %8[%true] : !hw.array<2xi10>, i1
    %48 = comb.concat %false, %47 : i1, i10
    %49 = comb.sub %48, %12 : i11
    %50 = llhd.prb %gen_cnts_1.incr_en : i1
    %51 = comb.add %48, %12 : i11
    %52 = comb.mux %50, %51, %48 : i11
    %53 = comb.mux %incr_en_i, %49, %52 : i11
    llhd.drv %gen_cnts_1.ext_cnt, %53 after %1 : i11
    %54 = llhd.prb %gen_cnts_1.ext_cnt : i11
    %55 = comb.extract %54 from 10 : (i11) -> i1
    %56 = comb.and %50, %55 : i1
    llhd.drv %gen_cnts_1.oflow, %56 after %1 : i1
    %57 = comb.and %incr_en_i, %55 {sv.namehint = "gen_cnts_1.uflow"} : i1
    %58 = llhd.prb %gen_cnts_1.oflow : i1
    %59 = comb.extract %54 from 0 : (i11) -> i10
    %60 = comb.mux %58, %c-1_i10, %59 : i10
    %61 = comb.mux %57, %c0_i10, %60 : i10
    llhd.drv %gen_cnts_1.cnt_sat, %61 after %1 : i10
    %62 = comb.xor %50, %incr_en_i : i1
    %63 = comb.icmp ne %47, %c-1_i10 : i10
    %64 = comb.and %50, %63 : i1
    %65 = comb.icmp ne %47, %c0_i10 : i10
    %66 = comb.and %incr_en_i, %65 : i1
    %67 = comb.or %64, %66 : i1
    %68 = comb.and %62, %67 : i1
    llhd.drv %gen_cnts_1.cnt_en, %68 after %1 : i1
    %69 = llhd.sig.array_get %cnt_d[%true] : <!hw.array<2xi10>>
    %70 = llhd.prb %gen_cnts_1.set_val : i10
    %71 = llhd.prb %gen_cnts_1.cnt_en : i1
    %72 = llhd.prb %gen_cnts_1.cnt_sat : i10
    %73 = comb.mux %71, %72, %47 : i10
    %74 = comb.mux %34, %70, %73 : i10
    %75 = comb.mux %clr_i, %c-1_i10, %74 : i10
    llhd.drv %69, %75 after %1 : i10
    %76 = llhd.sig.array_get %cnt_d_committed[%true] : <!hw.array<2xi10>>
    %77 = hw.array_get %42[%true] : !hw.array<2xi10>, i1
    %78 = comb.mux %commit_i, %77, %47 : i10
    llhd.drv %76, %78 after %1 : i10
    %79 = llhd.sig.array_get %cnt_q[%true] : <!hw.array<2xi10>>
    llhd.drv %79, %gen_cnts_1.u_cnt_flop.q_o after %1 : i10
    %80 = comb.add %10, %48 {sv.namehint = "sum"} : i11
    %81 = comb.icmp ne %80, %c1023_i11 : i11
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
    llhd.drv %step_i_3, %step_i after %1 : i10
    hw.output %9, %43, %82 : i10, i10, i1
  }
  hw.module private @prim_count_41(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %set_i : i1, in %set_cnt_i : i2, in %incr_en_i : i1, in %decr_en_i : i1, in %step_i : i2, in %commit_i : i1, out cnt_o : i2, out cnt_after_commit_o : i2, out err_o : i1) {
    %c3_i3 = hw.constant 3 : i3
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i2 = hw.constant -1 : i2
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i3 = hw.constant 0 : i3
    %2 = hw.aggregate_constant [0 : i2, 0 : i2] : !hw.array<2xi2>
    %false = hw.constant false
    %true = hw.constant true
    %c0_i2 = hw.constant 0 : i2
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %set_i_2 = llhd.sig name "set_i" %false : i1
    %step_i_3 = llhd.sig name "step_i" %c0_i2 : i2
    %cnt_d = llhd.sig %2 : !hw.array<2xi2>
    %cnt_d_committed = llhd.sig %2 : !hw.array<2xi2>
    %cnt_q = llhd.sig %2 : !hw.array<2xi2>
    %gen_cnts_0.incr_en = llhd.sig %false : i1
    %gen_cnts_0.set_val = llhd.sig %c0_i2 : i2
    %gen_cnts_0.ext_cnt = llhd.sig %c0_i3 : i3
    %gen_cnts_0.oflow = llhd.sig %false : i1
    %gen_cnts_0.cnt_sat = llhd.sig %c0_i2 : i2
    %gen_cnts_0.cnt_en = llhd.sig %false : i1
    %gen_cnts_1.incr_en = llhd.sig %false : i1
    %gen_cnts_1.set_val = llhd.sig %c0_i2 : i2
    %gen_cnts_1.ext_cnt = llhd.sig %c0_i3 : i3
    %gen_cnts_1.oflow = llhd.sig %false : i1
    %gen_cnts_1.cnt_sat = llhd.sig %c0_i2 : i2
    %gen_cnts_1.cnt_en = llhd.sig %false : i1
    %err_d = llhd.sig %false : i1
    %err_q = llhd.sig %false : i1
    %5 = llhd.prb %cnt_d_committed : !hw.array<2xi2>
    %6 = hw.array_get %5[%false] : !hw.array<2xi2>, i1
    %gen_cnts_0.u_cnt_flop.q_o = hw.instance "gen_cnts_0.u_cnt_flop" @prim_flop_42(clk_i: %3: i1, rst_ni: %4: i1, d_i: %6: i2) -> (q_o: i2) {sv.namehint = "gen_cnts_0.cnt_unforced_q"}
    %7 = hw.array_get %5[%true] : !hw.array<2xi2>, i1
    %gen_cnts_1.u_cnt_flop.q_o = hw.instance "gen_cnts_1.u_cnt_flop" @prim_flop_43(clk_i: %3: i1, rst_ni: %4: i1, d_i: %7: i2) -> (q_o: i2) {sv.namehint = "gen_cnts_1.cnt_unforced_q"}
    llhd.drv %gen_cnts_0.incr_en, %incr_en_i after %1 : i1
    llhd.drv %gen_cnts_0.set_val, %set_cnt_i after %1 : i2
    %8 = llhd.prb %cnt_q : !hw.array<2xi2>
    %9 = hw.array_get %8[%false] : !hw.array<2xi2>, i1
    %10 = comb.concat %false, %9 : i1, i2
    %11 = llhd.prb %step_i_3 : i2
    %12 = comb.concat %false, %11 : i1, i2
    %13 = comb.sub %10, %12 : i3
    %14 = llhd.prb %gen_cnts_0.incr_en : i1
    %15 = comb.add %10, %12 : i3
    %16 = comb.mux %14, %15, %10 : i3
    %17 = comb.mux %decr_en_i, %13, %16 : i3
    llhd.drv %gen_cnts_0.ext_cnt, %17 after %1 : i3
    %18 = llhd.prb %gen_cnts_0.ext_cnt : i3
    %19 = comb.extract %18 from 2 : (i3) -> i1
    %20 = comb.and %14, %19 : i1
    llhd.drv %gen_cnts_0.oflow, %20 after %1 : i1
    %21 = comb.and %decr_en_i, %19 {sv.namehint = "gen_cnts_0.uflow"} : i1
    %22 = llhd.prb %gen_cnts_0.oflow : i1
    %23 = comb.extract %18 from 0 : (i3) -> i2
    %24 = comb.mux %22, %c-1_i2, %23 : i2
    %25 = comb.mux %21, %c0_i2, %24 : i2
    llhd.drv %gen_cnts_0.cnt_sat, %25 after %1 : i2
    %26 = comb.xor %14, %decr_en_i : i1
    %27 = comb.icmp ne %9, %c-1_i2 : i2
    %28 = comb.and %14, %27 : i1
    %29 = comb.icmp ne %9, %c0_i2 : i2
    %30 = comb.and %decr_en_i, %29 : i1
    %31 = comb.or %28, %30 : i1
    %32 = comb.and %26, %31 : i1
    llhd.drv %gen_cnts_0.cnt_en, %32 after %1 : i1
    %33 = llhd.sig.array_get %cnt_d[%false] : <!hw.array<2xi2>>
    %34 = llhd.prb %set_i_2 : i1
    %35 = llhd.prb %gen_cnts_0.set_val : i2
    %36 = llhd.prb %gen_cnts_0.cnt_en : i1
    %37 = llhd.prb %gen_cnts_0.cnt_sat : i2
    %38 = comb.mux %36, %37, %9 : i2
    %39 = comb.mux %34, %35, %38 : i2
    %40 = comb.mux %clr_i, %c0_i2, %39 : i2
    llhd.drv %33, %40 after %1 : i2
    %41 = llhd.sig.array_get %cnt_d_committed[%false] : <!hw.array<2xi2>>
    %42 = llhd.prb %cnt_d : !hw.array<2xi2>
    %43 = hw.array_get %42[%false] : !hw.array<2xi2>, i1
    %44 = comb.mux %commit_i, %43, %9 : i2
    llhd.drv %41, %44 after %1 : i2
    %45 = llhd.sig.array_get %cnt_q[%false] : <!hw.array<2xi2>>
    llhd.drv %45, %gen_cnts_0.u_cnt_flop.q_o after %1 : i2
    llhd.drv %gen_cnts_1.incr_en, %decr_en_i after %1 : i1
    %46 = comb.sub %c-1_i2, %set_cnt_i : i2
    llhd.drv %gen_cnts_1.set_val, %46 after %1 : i2
    %47 = hw.array_get %8[%true] : !hw.array<2xi2>, i1
    %48 = comb.concat %false, %47 : i1, i2
    %49 = comb.sub %48, %12 : i3
    %50 = llhd.prb %gen_cnts_1.incr_en : i1
    %51 = comb.add %48, %12 : i3
    %52 = comb.mux %50, %51, %48 : i3
    %53 = comb.mux %incr_en_i, %49, %52 : i3
    llhd.drv %gen_cnts_1.ext_cnt, %53 after %1 : i3
    %54 = llhd.prb %gen_cnts_1.ext_cnt : i3
    %55 = comb.extract %54 from 2 : (i3) -> i1
    %56 = comb.and %50, %55 : i1
    llhd.drv %gen_cnts_1.oflow, %56 after %1 : i1
    %57 = comb.and %incr_en_i, %55 {sv.namehint = "gen_cnts_1.uflow"} : i1
    %58 = llhd.prb %gen_cnts_1.oflow : i1
    %59 = comb.extract %54 from 0 : (i3) -> i2
    %60 = comb.mux %58, %c-1_i2, %59 : i2
    %61 = comb.mux %57, %c0_i2, %60 : i2
    llhd.drv %gen_cnts_1.cnt_sat, %61 after %1 : i2
    %62 = comb.xor %50, %incr_en_i : i1
    %63 = comb.icmp ne %47, %c-1_i2 : i2
    %64 = comb.and %50, %63 : i1
    %65 = comb.icmp ne %47, %c0_i2 : i2
    %66 = comb.and %incr_en_i, %65 : i1
    %67 = comb.or %64, %66 : i1
    %68 = comb.and %62, %67 : i1
    llhd.drv %gen_cnts_1.cnt_en, %68 after %1 : i1
    %69 = llhd.sig.array_get %cnt_d[%true] : <!hw.array<2xi2>>
    %70 = llhd.prb %gen_cnts_1.set_val : i2
    %71 = llhd.prb %gen_cnts_1.cnt_en : i1
    %72 = llhd.prb %gen_cnts_1.cnt_sat : i2
    %73 = comb.mux %71, %72, %47 : i2
    %74 = comb.mux %34, %70, %73 : i2
    %75 = comb.mux %clr_i, %c-1_i2, %74 : i2
    llhd.drv %69, %75 after %1 : i2
    %76 = llhd.sig.array_get %cnt_d_committed[%true] : <!hw.array<2xi2>>
    %77 = hw.array_get %42[%true] : !hw.array<2xi2>, i1
    %78 = comb.mux %commit_i, %77, %47 : i2
    llhd.drv %76, %78 after %1 : i2
    %79 = llhd.sig.array_get %cnt_q[%true] : <!hw.array<2xi2>>
    llhd.drv %79, %gen_cnts_1.u_cnt_flop.q_o after %1 : i2
    %80 = comb.add %10, %48 {sv.namehint = "sum"} : i3
    %81 = comb.icmp ne %80, %c3_i3 : i3
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
    llhd.drv %step_i_3, %step_i after %1 : i2
    hw.output %9, %43, %82 : i2, i2, i1
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
    %gen_async.i_sync_p.q_o = hw.instance "gen_async.i_sync_p" @prim_flop_2sync_24(clk_i: %2: i1, rst_ni: %3: i1, d_i: %diff_pi: i1) -> (q_o: i1)
    llhd.drv %gen_async.diff_pd, %gen_async.i_sync_p.q_o after %1 : i1
    %gen_async.i_sync_n.q_o = hw.instance "gen_async.i_sync_n" @prim_flop_2sync_25(clk_i: %2: i1, rst_ni: %3: i1, d_i: %diff_ni: i1) -> (q_o: i1)
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
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c-2_i2 = hw.constant -2 : i2
    %true = hw.constant true
    %false = hw.constant false
    %c1_i2 = hw.constant 1 : i2
    %wptr_o = llhd.sig %false : i1
    %rptr_o = llhd.sig %false : i1
    %wptr_wrap_msb = llhd.sig %false : i1
    %rptr_wrap_msb = llhd.sig %false : i1
    %gen_secure_ptrs.u_wptr.cnt_o, %gen_secure_ptrs.u_wptr.cnt_after_commit_o, %gen_secure_ptrs.u_wptr.err_o = hw.instance "gen_secure_ptrs.u_wptr" @prim_count_41(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clr_i: %clr_i: i1, set_i: %6: i1, set_cnt_i: %11: i2, incr_en_i: %incr_wptr_i: i1, decr_en_i: %false: i1, step_i: %c1_i2: i2, commit_i: %true: i1) -> (cnt_o: i2, cnt_after_commit_o: i2, err_o: i1) {sv.namehint = "wptr_wrap_cnt_q"}
    %gen_secure_ptrs.u_rptr.cnt_o, %gen_secure_ptrs.u_rptr.cnt_after_commit_o, %gen_secure_ptrs.u_rptr.err_o = hw.instance "gen_secure_ptrs.u_rptr" @prim_count_41(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clr_i: %clr_i: i1, set_i: %8: i1, set_cnt_i: %14: i2, incr_en_i: %incr_rptr_i: i1, decr_en_i: %false: i1, step_i: %c1_i2: i2, commit_i: %true: i1) -> (cnt_o: i2, cnt_after_commit_o: i2, err_o: i1) {sv.namehint = "rptr_wrap_cnt_q"}
    %1 = comb.extract %gen_secure_ptrs.u_wptr.cnt_o from 0 : (i2) -> i1
    llhd.drv %wptr_o, %1 after %0 : i1
    %2 = comb.extract %gen_secure_ptrs.u_rptr.cnt_o from 0 : (i2) -> i1
    llhd.drv %rptr_o, %2 after %0 : i1
    %3 = comb.extract %gen_secure_ptrs.u_wptr.cnt_o from 1 : (i2) -> i1
    llhd.drv %wptr_wrap_msb, %3 after %0 : i1
    %4 = comb.extract %gen_secure_ptrs.u_rptr.cnt_o from 1 : (i2) -> i1
    llhd.drv %rptr_wrap_msb, %4 after %0 : i1
    %5 = llhd.prb %wptr_o : i1
    %6 = comb.and %incr_wptr_i, %5 {sv.namehint = "wptr_wrap_set"} : i1
    %7 = llhd.prb %rptr_o : i1
    %8 = comb.and %incr_rptr_i, %7 {sv.namehint = "rptr_wrap_set"} : i1
    %9 = llhd.prb %wptr_wrap_msb : i1
    %10 = comb.xor %9, %true : i1
    %11 = comb.concat %10, %false {sv.namehint = "wptr_wrap_set_cnt"} : i1, i1
    %12 = llhd.prb %rptr_wrap_msb : i1
    %13 = comb.xor %12, %true : i1
    %14 = comb.concat %13, %false {sv.namehint = "rptr_wrap_set_cnt"} : i1, i1
    %15 = comb.xor %gen_secure_ptrs.u_rptr.cnt_o, %c-2_i2 : i2
    %16 = comb.icmp eq %gen_secure_ptrs.u_wptr.cnt_o, %15 : i2
    %17 = comb.icmp eq %gen_secure_ptrs.u_wptr.cnt_o, %gen_secure_ptrs.u_rptr.cnt_o : i2
    %18 = comb.icmp eq %9, %12 : i1
    %19 = comb.concat %false, %5 : i1, i1
    %20 = comb.concat %false, %7 : i1, i1
    %21 = comb.sub %19, %20 : i2
    %22 = comb.sub %c-2_i2, %20 : i2
    %23 = comb.add %22, %19 : i2
    %24 = comb.mux %18, %21, %23 : i2
    %25 = comb.mux %16, %c-2_i2, %24 : i2
    %26 = comb.or %gen_secure_ptrs.u_wptr.err_o, %gen_secure_ptrs.u_rptr.err_o : i1
    hw.output %5, %7, %16, %17, %25, %26 : i1, i1, i1, i1, i2, i1
  }
  hw.module private @prim_fifo_sync_cnt_40(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %incr_wptr_i : i1, in %incr_rptr_i : i1, out wptr_o : i1, out rptr_o : i1, out full_o : i1, out empty_o : i1, out depth_o : i2, out err_o : i1) {
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
  hw.module private @prim_fifo_sync(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, out wready_o : i1, in %wdata_i : i16, out rvalid_o : i1, in %rready_i : i1, out rdata_o : i16, out full_o : i1, out depth_o : i2, out err_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [0 : i16, 0 : i16] : !hw.array<2xi16>
    %c0_i16 = hw.constant 0 : i16
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %wdata_i_2 = llhd.sig name "wdata_i" %c0_i16 : i16
    %gen_normal_fifo.fifo_wptr = llhd.sig %false : i1
    %gen_normal_fifo.fifo_incr_wptr = llhd.sig %false : i1
    %gen_normal_fifo.under_rst = llhd.sig %false : i1
    %gen_normal_fifo.storage = llhd.sig %2 : !hw.array<2xi16>
    %gen_normal_fifo.rdata_int = llhd.sig %c0_i16 : i16
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
    %12 = llhd.prb %gen_normal_fifo.storage : !hw.array<2xi16>
    %13 = hw.array_get %12[%gen_normal_fifo.u_fifo_cnt.rptr_o] {sv.namehint = "gen_normal_fifo.storage_rdata"} : !hw.array<2xi16>, i1
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
      %23 = llhd.sig.array_get %gen_normal_fifo.storage[%22] : <!hw.array<2xi16>>
      %24 = llhd.prb %wdata_i_2 : i16
      llhd.drv %23, %24 after %0 : i16
      cf.br ^bb1
    }
    llhd.drv %gen_normal_fifo.rdata_int, %13 after %1 : i16
    %14 = comb.xor %gen_normal_fifo.u_fifo_cnt.empty_o, %true : i1
    %15 = llhd.prb %gen_normal_fifo.rdata_int : i16
    %16 = comb.mux %gen_normal_fifo.u_fifo_cnt.empty_o, %c0_i16, %15 : i16
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %wdata_i_2, %wdata_i after %1 : i16
    hw.output %9, %14, %16, %gen_normal_fifo.u_fifo_cnt.full_o, %gen_normal_fifo.u_fifo_cnt.depth_o, %gen_normal_fifo.u_fifo_cnt.err_o : i1, i1, i16, i1, i2, i1
  }
  hw.module private @prim_fifo_sync_32(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, out wready_o : i1, in %wdata_i : i5, out rvalid_o : i1, in %rready_i : i1, out rdata_o : i5, out full_o : i1, out depth_o : i2, out err_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [0 : i5, 0 : i5] : !hw.array<2xi5>
    %c0_i5 = hw.constant 0 : i5
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %wdata_i_2 = llhd.sig name "wdata_i" %c0_i5 : i5
    %gen_normal_fifo.fifo_wptr = llhd.sig %false : i1
    %gen_normal_fifo.fifo_incr_wptr = llhd.sig %false : i1
    %gen_normal_fifo.under_rst = llhd.sig %false : i1
    %gen_normal_fifo.storage = llhd.sig %2 : !hw.array<2xi5>
    %gen_normal_fifo.rdata_int = llhd.sig %c0_i5 : i5
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
    %12 = llhd.prb %gen_normal_fifo.storage : !hw.array<2xi5>
    %13 = hw.array_get %12[%gen_normal_fifo.u_fifo_cnt.rptr_o] {sv.namehint = "gen_normal_fifo.storage_rdata"} : !hw.array<2xi5>, i1
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
      %23 = llhd.sig.array_get %gen_normal_fifo.storage[%22] : <!hw.array<2xi5>>
      %24 = llhd.prb %wdata_i_2 : i5
      llhd.drv %23, %24 after %0 : i5
      cf.br ^bb1
    }
    llhd.drv %gen_normal_fifo.rdata_int, %13 after %1 : i5
    %14 = comb.xor %gen_normal_fifo.u_fifo_cnt.empty_o, %true : i1
    %15 = llhd.prb %gen_normal_fifo.rdata_int : i5
    %16 = comb.mux %gen_normal_fifo.u_fifo_cnt.empty_o, %c0_i5, %15 : i5
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %wdata_i_2, %wdata_i after %1 : i5
    hw.output %9, %14, %16, %gen_normal_fifo.u_fifo_cnt.full_o, %gen_normal_fifo.u_fifo_cnt.depth_o, %gen_normal_fifo.u_fifo_cnt.err_o : i1, i1, i5, i1, i2, i1
  }
  hw.module private @prim_fifo_sync_33(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, out wready_o : i1, in %wdata_i : i40, out rvalid_o : i1, in %rready_i : i1, out rdata_o : i40, out full_o : i1, out depth_o : i2, out err_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [0 : i40, 0 : i40] : !hw.array<2xi40>
    %c0_i40 = hw.constant 0 : i40
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %wdata_i_2 = llhd.sig name "wdata_i" %c0_i40 : i40
    %gen_normal_fifo.fifo_wptr = llhd.sig %false : i1
    %gen_normal_fifo.fifo_incr_wptr = llhd.sig %false : i1
    %gen_normal_fifo.under_rst = llhd.sig %false : i1
    %gen_normal_fifo.storage = llhd.sig %2 : !hw.array<2xi40>
    %gen_normal_fifo.storage_rdata = llhd.sig %c0_i40 : i40
    %gen_normal_fifo.rdata_int = llhd.sig %c0_i40 : i40
    %5 = llhd.prb %gen_normal_fifo.fifo_incr_wptr : i1
    %gen_normal_fifo.u_fifo_cnt.wptr_o, %gen_normal_fifo.u_fifo_cnt.rptr_o, %gen_normal_fifo.u_fifo_cnt.full_o, %gen_normal_fifo.u_fifo_cnt.empty_o, %gen_normal_fifo.u_fifo_cnt.depth_o, %gen_normal_fifo.u_fifo_cnt.err_o = hw.instance "gen_normal_fifo.u_fifo_cnt" @prim_fifo_sync_cnt(clk_i: %3: i1, rst_ni: %4: i1, clr_i: %clr_i: i1, incr_wptr_i: %5: i1, incr_rptr_i: %11: i1) -> (wptr_o: i1, rptr_o: i1, full_o: i1, empty_o: i1, depth_o: i2, err_o: i1) {sv.namehint = "gen_normal_fifo.fifo_rptr"}
    llhd.drv %gen_normal_fifo.fifo_wptr, %gen_normal_fifo.u_fifo_cnt.wptr_o after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %24 = llhd.prb %clk_i_0 : i1
      %25 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %26 = llhd.prb %clk_i_0 : i1
      %27 = comb.xor bin %24, %true : i1
      %28 = comb.and bin %27, %26 : i1
      %29 = llhd.prb %rst_ni_1 : i1
      %30 = comb.xor bin %29, %true : i1
      %31 = comb.and bin %25, %30 : i1
      %32 = comb.or bin %28, %31 : i1
      cf.cond_br %32, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %33 = llhd.prb %rst_ni_1 : i1
      %34 = comb.xor %33, %true : i1
      cf.cond_br %34, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_normal_fifo.under_rst, %true after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %35 = llhd.prb %gen_normal_fifo.under_rst : i1
      cf.cond_br %35, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %36 = llhd.prb %gen_normal_fifo.under_rst : i1
      %37 = comb.xor %36, %true : i1
      llhd.drv %gen_normal_fifo.under_rst, %37 after %0 : i1
      cf.br ^bb1
    }
    %6 = comb.xor %gen_normal_fifo.u_fifo_cnt.full_o, %true : i1
    %7 = llhd.prb %gen_normal_fifo.under_rst : i1
    %8 = comb.xor %7, %true : i1
    %9 = comb.and %6, %8 : i1
    %10 = comb.and %wvalid_i, %9 : i1
    llhd.drv %gen_normal_fifo.fifo_incr_wptr, %10 after %1 : i1
    %11 = comb.and %21, %rready_i {sv.namehint = "gen_normal_fifo.fifo_incr_rptr"} : i1
    %12 = llhd.prb %gen_normal_fifo.storage : !hw.array<2xi40>
    %13 = hw.array_get %12[%gen_normal_fifo.u_fifo_cnt.rptr_o] : !hw.array<2xi40>, i1
    llhd.drv %gen_normal_fifo.storage_rdata, %13 after %1 : i40
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
      %24 = llhd.prb %clk_i_0 : i1
      llhd.wait (%3 : i1), ^bb2
    ^bb2:  // pred: ^bb1
      %25 = llhd.prb %clk_i_0 : i1
      %26 = comb.xor bin %24, %true : i1
      %27 = comb.and bin %26, %25 : i1
      cf.cond_br %27, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %28 = llhd.prb %gen_normal_fifo.fifo_incr_wptr : i1
      cf.cond_br %28, ^bb4, ^bb1
    ^bb4:  // pred: ^bb3
      %29 = llhd.prb %gen_normal_fifo.fifo_wptr : i1
      %30 = llhd.sig.array_get %gen_normal_fifo.storage[%29] : <!hw.array<2xi40>>
      %31 = llhd.prb %wdata_i_2 : i40
      llhd.drv %30, %31 after %0 : i40
      cf.br ^bb1
    }
    %14 = comb.and %gen_normal_fifo.u_fifo_cnt.empty_o, %wvalid_i : i1
    %15 = llhd.prb %wdata_i_2 : i40
    %16 = llhd.prb %gen_normal_fifo.storage_rdata : i40
    %17 = comb.mux %14, %15, %16 : i40
    llhd.drv %gen_normal_fifo.rdata_int, %17 after %1 : i40
    %18 = comb.xor %wvalid_i, %true : i1
    %19 = comb.and %gen_normal_fifo.u_fifo_cnt.empty_o, %18 {sv.namehint = "gen_normal_fifo.empty"} : i1
    %20 = comb.xor %19, %true : i1
    %21 = comb.and %20, %8 : i1
    %22 = llhd.prb %gen_normal_fifo.rdata_int : i40
    %23 = comb.mux %19, %c0_i40, %22 : i40
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %wdata_i_2, %wdata_i after %1 : i40
    hw.output %9, %21, %23, %gen_normal_fifo.u_fifo_cnt.full_o, %gen_normal_fifo.u_fifo_cnt.depth_o, %gen_normal_fifo.u_fifo_cnt.err_o : i1, i1, i40, i1, i2, i1
  }
  hw.module private @prim_fifo_sync_37(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, out wready_o : i1, in %wdata_i : i93, out rvalid_o : i1, in %rready_i : i1, out rdata_o : i93, out full_o : i1, out depth_o : i1, out err_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %true = hw.constant true
    %c0_i93 = hw.constant 0 : i93
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %wvalid_i_2 = llhd.sig name "wvalid_i" %false : i1
    %wready_o = llhd.sig %false : i1
    %wdata_i_3 = llhd.sig name "wdata_i" %c0_i93 : i93
    %rready_i_4 = llhd.sig name "rready_i" %false : i1
    %gen_singleton_fifo.full_d = llhd.sig %false : i1
    %gen_singleton_fifo.full_q = llhd.sig %false : i1
    %gen_singleton_fifo.storage = llhd.sig %c0_i93 : i93
    %gen_singleton_fifo.rdata_int = llhd.sig %c0_i93 : i93
    %4 = llhd.prb %gen_singleton_fifo.full_q : i1
    %5 = comb.xor %4, %true : i1
    llhd.drv %wready_o, %5 after %1 : i1
    %6 = llhd.prb %wvalid_i_2 : i1
    %7 = llhd.prb %rready_i_4 : i1
    %8 = comb.xor %7, %true : i1
    %9 = comb.mux %4, %8, %6 : i1
    %10 = comb.xor %clr_i, %true : i1
    %11 = comb.and %9, %10 : i1
    llhd.drv %gen_singleton_fifo.full_d, %11 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %15 = llhd.prb %clk_i_0 : i1
      %16 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %17 = llhd.prb %clk_i_0 : i1
      %18 = comb.xor bin %15, %true : i1
      %19 = comb.and bin %18, %17 : i1
      %20 = llhd.prb %rst_ni_1 : i1
      %21 = comb.xor bin %20, %true : i1
      %22 = comb.and bin %16, %21 : i1
      %23 = comb.or bin %19, %22 : i1
      cf.cond_br %23, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %24 = llhd.prb %rst_ni_1 : i1
      %25 = comb.xor %24, %true : i1
      cf.cond_br %25, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_singleton_fifo.full_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %26 = llhd.prb %gen_singleton_fifo.full_d : i1
      llhd.drv %gen_singleton_fifo.full_q, %26 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
      %15 = llhd.prb %clk_i_0 : i1
      llhd.wait (%2 : i1), ^bb2
    ^bb2:  // pred: ^bb1
      %16 = llhd.prb %clk_i_0 : i1
      %17 = comb.xor bin %15, %true : i1
      %18 = comb.and bin %17, %16 : i1
      cf.cond_br %18, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %19 = llhd.prb %wvalid_i_2 : i1
      %20 = llhd.prb %wready_o : i1
      %21 = comb.and %19, %20 : i1
      cf.cond_br %21, ^bb4, ^bb1
    ^bb4:  // pred: ^bb3
      %22 = llhd.prb %wdata_i_3 : i93
      llhd.drv %gen_singleton_fifo.storage, %22 after %0 : i93
      cf.br ^bb1
    }
    %12 = llhd.prb %gen_singleton_fifo.storage : i93
    llhd.drv %gen_singleton_fifo.rdata_int, %12 after %1 : i93
    %13 = llhd.prb %gen_singleton_fifo.rdata_int : i93
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %wvalid_i_2, %wvalid_i after %1 : i1
    %14 = llhd.prb %wready_o : i1
    llhd.drv %wdata_i_3, %wdata_i after %1 : i93
    llhd.drv %rready_i_4, %rready_i after %1 : i1
    hw.output %14, %4, %13, %4, %4, %false : i1, i1, i93, i1, i1, i1
  }
  hw.module private @prim_fifo_sync_38(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, out wready_o : i1, in %wdata_i : i14, out rvalid_o : i1, in %rready_i : i1, out rdata_o : i14, out full_o : i1, out depth_o : i1, out err_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %true = hw.constant true
    %c0_i14 = hw.constant 0 : i14
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %wvalid_i_2 = llhd.sig name "wvalid_i" %false : i1
    %wready_o = llhd.sig %false : i1
    %wdata_i_3 = llhd.sig name "wdata_i" %c0_i14 : i14
    %rready_i_4 = llhd.sig name "rready_i" %false : i1
    %gen_singleton_fifo.full_d = llhd.sig %false : i1
    %gen_singleton_fifo.full_q = llhd.sig %false : i1
    %gen_singleton_fifo.storage = llhd.sig %c0_i14 : i14
    %gen_singleton_fifo.rdata_int = llhd.sig %c0_i14 : i14
    %4 = llhd.prb %gen_singleton_fifo.full_q : i1
    %5 = comb.xor %4, %true : i1
    llhd.drv %wready_o, %5 after %1 : i1
    %6 = llhd.prb %wvalid_i_2 : i1
    %7 = llhd.prb %rready_i_4 : i1
    %8 = comb.xor %7, %true : i1
    %9 = comb.mux %4, %8, %6 : i1
    %10 = comb.xor %clr_i, %true : i1
    %11 = comb.and %9, %10 : i1
    llhd.drv %gen_singleton_fifo.full_d, %11 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %15 = llhd.prb %clk_i_0 : i1
      %16 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %17 = llhd.prb %clk_i_0 : i1
      %18 = comb.xor bin %15, %true : i1
      %19 = comb.and bin %18, %17 : i1
      %20 = llhd.prb %rst_ni_1 : i1
      %21 = comb.xor bin %20, %true : i1
      %22 = comb.and bin %16, %21 : i1
      %23 = comb.or bin %19, %22 : i1
      cf.cond_br %23, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %24 = llhd.prb %rst_ni_1 : i1
      %25 = comb.xor %24, %true : i1
      cf.cond_br %25, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_singleton_fifo.full_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %26 = llhd.prb %gen_singleton_fifo.full_d : i1
      llhd.drv %gen_singleton_fifo.full_q, %26 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
      %15 = llhd.prb %clk_i_0 : i1
      llhd.wait (%2 : i1), ^bb2
    ^bb2:  // pred: ^bb1
      %16 = llhd.prb %clk_i_0 : i1
      %17 = comb.xor bin %15, %true : i1
      %18 = comb.and bin %17, %16 : i1
      cf.cond_br %18, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %19 = llhd.prb %wvalid_i_2 : i1
      %20 = llhd.prb %wready_o : i1
      %21 = comb.and %19, %20 : i1
      cf.cond_br %21, ^bb4, ^bb1
    ^bb4:  // pred: ^bb3
      %22 = llhd.prb %wdata_i_3 : i14
      llhd.drv %gen_singleton_fifo.storage, %22 after %0 : i14
      cf.br ^bb1
    }
    %12 = llhd.prb %gen_singleton_fifo.storage : i14
    llhd.drv %gen_singleton_fifo.rdata_int, %12 after %1 : i14
    %13 = llhd.prb %gen_singleton_fifo.rdata_int : i14
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %wvalid_i_2, %wvalid_i after %1 : i1
    %14 = llhd.prb %wready_o : i1
    llhd.drv %wdata_i_3, %wdata_i after %1 : i14
    llhd.drv %rready_i_4, %rready_i after %1 : i1
    hw.output %14, %4, %13, %4, %4, %false : i1, i1, i14, i1, i1, i1
  }
  hw.module private @prim_fifo_sync_39(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, out wready_o : i1, in %wdata_i : i2, out rvalid_o : i1, in %rready_i : i1, out rdata_o : i2, out full_o : i1, out depth_o : i2, out err_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [0 : i2, 0 : i2] : !hw.array<2xi2>
    %c0_i2 = hw.constant 0 : i2
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %wdata_i_2 = llhd.sig name "wdata_i" %c0_i2 : i2
    %gen_normal_fifo.fifo_wptr = llhd.sig %false : i1
    %gen_normal_fifo.fifo_incr_wptr = llhd.sig %false : i1
    %gen_normal_fifo.under_rst = llhd.sig %false : i1
    %gen_normal_fifo.storage = llhd.sig %2 : !hw.array<2xi2>
    %gen_normal_fifo.rdata_int = llhd.sig %c0_i2 : i2
    %5 = llhd.prb %gen_normal_fifo.fifo_incr_wptr : i1
    %gen_normal_fifo.u_fifo_cnt.wptr_o, %gen_normal_fifo.u_fifo_cnt.rptr_o, %gen_normal_fifo.u_fifo_cnt.full_o, %gen_normal_fifo.u_fifo_cnt.empty_o, %gen_normal_fifo.u_fifo_cnt.depth_o, %gen_normal_fifo.u_fifo_cnt.err_o = hw.instance "gen_normal_fifo.u_fifo_cnt" @prim_fifo_sync_cnt_40(clk_i: %3: i1, rst_ni: %4: i1, clr_i: %clr_i: i1, incr_wptr_i: %5: i1, incr_rptr_i: %11: i1) -> (wptr_o: i1, rptr_o: i1, full_o: i1, empty_o: i1, depth_o: i2, err_o: i1) {sv.namehint = "gen_normal_fifo.empty"}
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
    %12 = llhd.prb %gen_normal_fifo.storage : !hw.array<2xi2>
    %13 = hw.array_get %12[%gen_normal_fifo.u_fifo_cnt.rptr_o] {sv.namehint = "gen_normal_fifo.storage_rdata"} : !hw.array<2xi2>, i1
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
      %23 = llhd.sig.array_get %gen_normal_fifo.storage[%22] : <!hw.array<2xi2>>
      %24 = llhd.prb %wdata_i_2 : i2
      llhd.drv %23, %24 after %0 : i2
      cf.br ^bb1
    }
    llhd.drv %gen_normal_fifo.rdata_int, %13 after %1 : i2
    %14 = comb.xor %gen_normal_fifo.u_fifo_cnt.empty_o, %true : i1
    %15 = llhd.prb %gen_normal_fifo.rdata_int : i2
    %16 = comb.mux %gen_normal_fifo.u_fifo_cnt.empty_o, %c0_i2, %15 : i2
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %wdata_i_2, %wdata_i after %1 : i2
    hw.output %9, %14, %16, %gen_normal_fifo.u_fifo_cnt.full_o, %gen_normal_fifo.u_fifo_cnt.depth_o, %gen_normal_fifo.u_fifo_cnt.err_o : i1, i1, i2, i1, i2, i1
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
  func.func private @"prim_mubi_pkg::mubi4_bool_to_mubi"(%arg0: i1) -> i4 {
    %c-7_i4 = hw.constant -7 : i4
    %c6_i4 = hw.constant 6 : i4
    %0 = comb.mux %arg0, %c6_i4, %c-7_i4 : i4
    return %0 : i4
  }
  func.func private @"prim_mubi_pkg::mubi4_test_true_strict"(%arg0: i4) -> i1 {
    %c6_i4 = hw.constant 6 : i4
    %0 = comb.icmp eq %arg0, %c6_i4 : i4
    return %0 : i1
  }
  func.func private @"prim_mubi_pkg::mubi4_test_false_strict"(%arg0: i4) -> i1 {
    %c-7_i4 = hw.constant -7 : i4
    %0 = comb.icmp eq %arg0, %c-7_i4 : i4
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
  func.func private @"prim_mubi_pkg::mubi8_test_true_strict"(%arg0: i8) -> i1 {
    %c-106_i8 = hw.constant -106 : i8
    %0 = comb.icmp eq %arg0, %c-106_i8 : i8
    return %0 : i1
  }
  hw.module private @prim_onehot_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i9, in %addr_i : i4, in %en_i : i1, out err_o : i1) {
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
    %true = hw.constant true
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i5 = hw.constant 0 : i5
    %false = hw.constant false {sv.namehint = "addr_err"}
    %c0_i31 = hw.constant 0 : i31
    %or_tree = llhd.sig %c0_i31 : i31
    %and_tree = llhd.sig %c0_i31 : i31
    %err_tree = llhd.sig %c0_i31 : i31
    %1 = llhd.sig.extract %or_tree from %c0_i5 : <i31> -> <i1>
    %2 = llhd.prb %or_tree : i31
    %3 = comb.extract %2 from 1 : (i31) -> i1
    %4 = comb.extract %2 from 2 : (i31) -> i1
    %5 = comb.or %3, %4 : i1
    llhd.drv %1, %5 after %0 : i1
    %6 = llhd.sig.extract %and_tree from %c0_i5 : <i31> -> <i1>
    %7 = comb.extract %addr_i from 3 : (i4) -> i1
    %8 = comb.xor %7, %true : i1
    %9 = llhd.prb %and_tree : i31
    %10 = comb.extract %9 from 1 : (i31) -> i1
    %11 = comb.and %8, %10 : i1
    %12 = comb.extract %9 from 2 : (i31) -> i1
    %13 = comb.and %7, %12 : i1
    %14 = comb.or %11, %13 : i1
    llhd.drv %6, %14 after %0 : i1
    %15 = llhd.sig.extract %err_tree from %c0_i5 : <i31> -> <i1>
    %16 = comb.and %3, %4 : i1
    %17 = llhd.prb %err_tree : i31
    %18 = comb.extract %17 from 1 : (i31) -> i1
    %19 = comb.extract %17 from 2 : (i31) -> i1
    %20 = comb.or %16, %18, %19 : i1
    llhd.drv %15, %20 after %0 : i1
    %21 = llhd.sig.extract %or_tree from %c1_i5 : <i31> -> <i1>
    %22 = comb.extract %2 from 3 : (i31) -> i1
    %23 = comb.extract %2 from 4 : (i31) -> i1
    %24 = comb.or %22, %23 : i1
    llhd.drv %21, %24 after %0 : i1
    %25 = llhd.sig.extract %and_tree from %c1_i5 : <i31> -> <i1>
    %26 = comb.extract %addr_i from 2 : (i4) -> i1
    %27 = comb.xor %26, %true : i1
    %28 = comb.extract %9 from 3 : (i31) -> i1
    %29 = comb.and %27, %28 : i1
    %30 = comb.extract %9 from 4 : (i31) -> i1
    %31 = comb.and %26, %30 : i1
    %32 = comb.or %29, %31 : i1
    llhd.drv %25, %32 after %0 : i1
    %33 = llhd.sig.extract %err_tree from %c1_i5 : <i31> -> <i1>
    %34 = comb.and %22, %23 : i1
    %35 = comb.extract %17 from 3 : (i31) -> i1
    %36 = comb.extract %17 from 4 : (i31) -> i1
    %37 = comb.or %34, %35, %36 : i1
    llhd.drv %33, %37 after %0 : i1
    %38 = llhd.sig.extract %or_tree from %c2_i5 : <i31> -> <i1>
    %39 = comb.extract %2 from 5 : (i31) -> i1
    %40 = comb.extract %2 from 6 : (i31) -> i1
    %41 = comb.or %39, %40 : i1
    llhd.drv %38, %41 after %0 : i1
    %42 = llhd.sig.extract %and_tree from %c2_i5 : <i31> -> <i1>
    %43 = comb.extract %9 from 5 : (i31) -> i1
    %44 = comb.and %27, %43 : i1
    %45 = comb.extract %9 from 6 : (i31) -> i1
    %46 = comb.and %26, %45 : i1
    %47 = comb.or %44, %46 : i1
    llhd.drv %42, %47 after %0 : i1
    %48 = llhd.sig.extract %err_tree from %c2_i5 : <i31> -> <i1>
    %49 = comb.and %39, %40 : i1
    %50 = comb.extract %17 from 5 : (i31) -> i1
    %51 = comb.extract %17 from 6 : (i31) -> i1
    %52 = comb.or %49, %50, %51 : i1
    llhd.drv %48, %52 after %0 : i1
    %53 = llhd.sig.extract %or_tree from %c3_i5 : <i31> -> <i1>
    %54 = comb.extract %2 from 7 : (i31) -> i1
    %55 = comb.extract %2 from 8 : (i31) -> i1
    %56 = comb.or %54, %55 : i1
    llhd.drv %53, %56 after %0 : i1
    %57 = llhd.sig.extract %and_tree from %c3_i5 : <i31> -> <i1>
    %58 = comb.extract %addr_i from 1 : (i4) -> i1
    %59 = comb.xor %58, %true : i1
    %60 = comb.extract %9 from 7 : (i31) -> i1
    %61 = comb.and %59, %60 : i1
    %62 = comb.extract %9 from 8 : (i31) -> i1
    %63 = comb.and %58, %62 : i1
    %64 = comb.or %61, %63 : i1
    llhd.drv %57, %64 after %0 : i1
    %65 = llhd.sig.extract %err_tree from %c3_i5 : <i31> -> <i1>
    %66 = comb.and %54, %55 : i1
    %67 = comb.extract %17 from 7 : (i31) -> i1
    %68 = comb.extract %17 from 8 : (i31) -> i1
    %69 = comb.or %66, %67, %68 : i1
    llhd.drv %65, %69 after %0 : i1
    %70 = llhd.sig.extract %or_tree from %c4_i5 : <i31> -> <i1>
    %71 = comb.extract %2 from 9 : (i31) -> i1
    %72 = comb.extract %2 from 10 : (i31) -> i1
    %73 = comb.or %71, %72 : i1
    llhd.drv %70, %73 after %0 : i1
    %74 = llhd.sig.extract %and_tree from %c4_i5 : <i31> -> <i1>
    %75 = comb.extract %9 from 9 : (i31) -> i1
    %76 = comb.and %59, %75 : i1
    %77 = comb.extract %9 from 10 : (i31) -> i1
    %78 = comb.and %58, %77 : i1
    %79 = comb.or %76, %78 : i1
    llhd.drv %74, %79 after %0 : i1
    %80 = llhd.sig.extract %err_tree from %c4_i5 : <i31> -> <i1>
    %81 = comb.and %71, %72 : i1
    %82 = comb.extract %17 from 9 : (i31) -> i1
    %83 = comb.extract %17 from 10 : (i31) -> i1
    %84 = comb.or %81, %82, %83 : i1
    llhd.drv %80, %84 after %0 : i1
    %85 = llhd.sig.extract %or_tree from %c5_i5 : <i31> -> <i1>
    %86 = comb.extract %2 from 11 : (i31) -> i1
    %87 = comb.extract %2 from 12 : (i31) -> i1
    %88 = comb.or %86, %87 : i1
    llhd.drv %85, %88 after %0 : i1
    %89 = llhd.sig.extract %and_tree from %c5_i5 : <i31> -> <i1>
    %90 = comb.extract %9 from 11 : (i31) -> i1
    %91 = comb.and %59, %90 : i1
    %92 = comb.extract %9 from 12 : (i31) -> i1
    %93 = comb.and %58, %92 : i1
    %94 = comb.or %91, %93 : i1
    llhd.drv %89, %94 after %0 : i1
    %95 = llhd.sig.extract %err_tree from %c5_i5 : <i31> -> <i1>
    %96 = comb.and %86, %87 : i1
    %97 = comb.extract %17 from 11 : (i31) -> i1
    %98 = comb.extract %17 from 12 : (i31) -> i1
    %99 = comb.or %96, %97, %98 : i1
    llhd.drv %95, %99 after %0 : i1
    %100 = llhd.sig.extract %or_tree from %c6_i5 : <i31> -> <i1>
    %101 = comb.extract %2 from 13 : (i31) -> i1
    %102 = comb.extract %2 from 14 : (i31) -> i1
    %103 = comb.or %101, %102 : i1
    llhd.drv %100, %103 after %0 : i1
    %104 = llhd.sig.extract %and_tree from %c6_i5 : <i31> -> <i1>
    %105 = comb.extract %9 from 13 : (i31) -> i1
    %106 = comb.and %59, %105 : i1
    %107 = comb.extract %9 from 14 : (i31) -> i1
    %108 = comb.and %58, %107 : i1
    %109 = comb.or %106, %108 : i1
    llhd.drv %104, %109 after %0 : i1
    %110 = llhd.sig.extract %err_tree from %c6_i5 : <i31> -> <i1>
    %111 = comb.and %101, %102 : i1
    %112 = comb.extract %17 from 13 : (i31) -> i1
    %113 = comb.extract %17 from 14 : (i31) -> i1
    %114 = comb.or %111, %112, %113 : i1
    llhd.drv %110, %114 after %0 : i1
    %115 = llhd.sig.extract %or_tree from %c7_i5 : <i31> -> <i1>
    %116 = comb.extract %2 from 15 : (i31) -> i1
    %117 = comb.extract %2 from 16 : (i31) -> i1
    %118 = comb.or %116, %117 : i1
    llhd.drv %115, %118 after %0 : i1
    %119 = llhd.sig.extract %and_tree from %c7_i5 : <i31> -> <i1>
    %120 = comb.extract %addr_i from 0 : (i4) -> i1
    %121 = comb.xor %120, %true : i1
    %122 = comb.extract %9 from 15 : (i31) -> i1
    %123 = comb.and %121, %122 : i1
    %124 = comb.extract %9 from 16 : (i31) -> i1
    %125 = comb.and %120, %124 : i1
    %126 = comb.or %123, %125 : i1
    llhd.drv %119, %126 after %0 : i1
    %127 = llhd.sig.extract %err_tree from %c7_i5 : <i31> -> <i1>
    %128 = comb.and %116, %117 : i1
    %129 = comb.extract %17 from 15 : (i31) -> i1
    %130 = comb.extract %17 from 16 : (i31) -> i1
    %131 = comb.or %128, %129, %130 : i1
    llhd.drv %127, %131 after %0 : i1
    %132 = llhd.sig.extract %or_tree from %c8_i5 : <i31> -> <i1>
    %133 = comb.extract %2 from 17 : (i31) -> i1
    %134 = comb.extract %2 from 18 : (i31) -> i1
    %135 = comb.or %133, %134 : i1
    llhd.drv %132, %135 after %0 : i1
    %136 = llhd.sig.extract %and_tree from %c8_i5 : <i31> -> <i1>
    %137 = comb.extract %9 from 17 : (i31) -> i1
    %138 = comb.and %121, %137 : i1
    %139 = comb.extract %9 from 18 : (i31) -> i1
    %140 = comb.and %120, %139 : i1
    %141 = comb.or %138, %140 : i1
    llhd.drv %136, %141 after %0 : i1
    %142 = llhd.sig.extract %err_tree from %c8_i5 : <i31> -> <i1>
    %143 = comb.and %133, %134 : i1
    %144 = comb.extract %17 from 17 : (i31) -> i1
    %145 = comb.extract %17 from 18 : (i31) -> i1
    %146 = comb.or %143, %144, %145 : i1
    llhd.drv %142, %146 after %0 : i1
    %147 = llhd.sig.extract %or_tree from %c9_i5 : <i31> -> <i1>
    %148 = comb.extract %2 from 19 : (i31) -> i1
    %149 = comb.extract %2 from 20 : (i31) -> i1
    %150 = comb.or %148, %149 : i1
    llhd.drv %147, %150 after %0 : i1
    %151 = llhd.sig.extract %and_tree from %c9_i5 : <i31> -> <i1>
    %152 = comb.extract %9 from 19 : (i31) -> i1
    %153 = comb.and %121, %152 : i1
    %154 = comb.extract %9 from 20 : (i31) -> i1
    %155 = comb.and %120, %154 : i1
    %156 = comb.or %153, %155 : i1
    llhd.drv %151, %156 after %0 : i1
    %157 = llhd.sig.extract %err_tree from %c9_i5 : <i31> -> <i1>
    %158 = comb.and %148, %149 : i1
    %159 = comb.extract %17 from 19 : (i31) -> i1
    %160 = comb.extract %17 from 20 : (i31) -> i1
    %161 = comb.or %158, %159, %160 : i1
    llhd.drv %157, %161 after %0 : i1
    %162 = llhd.sig.extract %or_tree from %c10_i5 : <i31> -> <i1>
    %163 = comb.extract %2 from 21 : (i31) -> i1
    %164 = comb.extract %2 from 22 : (i31) -> i1
    %165 = comb.or %163, %164 : i1
    llhd.drv %162, %165 after %0 : i1
    %166 = llhd.sig.extract %and_tree from %c10_i5 : <i31> -> <i1>
    %167 = comb.extract %9 from 21 : (i31) -> i1
    %168 = comb.and %121, %167 : i1
    %169 = comb.extract %9 from 22 : (i31) -> i1
    %170 = comb.and %120, %169 : i1
    %171 = comb.or %168, %170 : i1
    llhd.drv %166, %171 after %0 : i1
    %172 = llhd.sig.extract %err_tree from %c10_i5 : <i31> -> <i1>
    %173 = comb.and %163, %164 : i1
    %174 = comb.extract %17 from 21 : (i31) -> i1
    %175 = comb.extract %17 from 22 : (i31) -> i1
    %176 = comb.or %173, %174, %175 : i1
    llhd.drv %172, %176 after %0 : i1
    %177 = llhd.sig.extract %or_tree from %c11_i5 : <i31> -> <i1>
    %178 = comb.extract %2 from 23 : (i31) -> i1
    %179 = comb.extract %2 from 24 : (i31) -> i1
    %180 = comb.or %178, %179 : i1
    llhd.drv %177, %180 after %0 : i1
    %181 = llhd.sig.extract %and_tree from %c11_i5 : <i31> -> <i1>
    %182 = comb.extract %9 from 23 : (i31) -> i1
    %183 = comb.and %121, %182 : i1
    %184 = comb.extract %9 from 24 : (i31) -> i1
    %185 = comb.and %120, %184 : i1
    %186 = comb.or %183, %185 : i1
    llhd.drv %181, %186 after %0 : i1
    %187 = llhd.sig.extract %err_tree from %c11_i5 : <i31> -> <i1>
    %188 = comb.and %178, %179 : i1
    %189 = comb.extract %17 from 23 : (i31) -> i1
    %190 = comb.extract %17 from 24 : (i31) -> i1
    %191 = comb.or %188, %189, %190 : i1
    llhd.drv %187, %191 after %0 : i1
    %192 = llhd.sig.extract %or_tree from %c12_i5 : <i31> -> <i1>
    %193 = comb.extract %2 from 25 : (i31) -> i1
    %194 = comb.extract %2 from 26 : (i31) -> i1
    %195 = comb.or %193, %194 : i1
    llhd.drv %192, %195 after %0 : i1
    %196 = llhd.sig.extract %and_tree from %c12_i5 : <i31> -> <i1>
    %197 = comb.extract %9 from 25 : (i31) -> i1
    %198 = comb.and %121, %197 : i1
    %199 = comb.extract %9 from 26 : (i31) -> i1
    %200 = comb.and %120, %199 : i1
    %201 = comb.or %198, %200 : i1
    llhd.drv %196, %201 after %0 : i1
    %202 = llhd.sig.extract %err_tree from %c12_i5 : <i31> -> <i1>
    %203 = comb.and %193, %194 : i1
    %204 = comb.extract %17 from 25 : (i31) -> i1
    %205 = comb.extract %17 from 26 : (i31) -> i1
    %206 = comb.or %203, %204, %205 : i1
    llhd.drv %202, %206 after %0 : i1
    %207 = llhd.sig.extract %or_tree from %c13_i5 : <i31> -> <i1>
    %208 = comb.extract %2 from 27 : (i31) -> i1
    %209 = comb.extract %2 from 28 : (i31) -> i1
    %210 = comb.or %208, %209 : i1
    llhd.drv %207, %210 after %0 : i1
    %211 = llhd.sig.extract %and_tree from %c13_i5 : <i31> -> <i1>
    %212 = comb.extract %9 from 27 : (i31) -> i1
    %213 = comb.and %121, %212 : i1
    %214 = comb.extract %9 from 28 : (i31) -> i1
    %215 = comb.and %120, %214 : i1
    %216 = comb.or %213, %215 : i1
    llhd.drv %211, %216 after %0 : i1
    %217 = llhd.sig.extract %err_tree from %c13_i5 : <i31> -> <i1>
    %218 = comb.and %208, %209 : i1
    %219 = comb.extract %17 from 27 : (i31) -> i1
    %220 = comb.extract %17 from 28 : (i31) -> i1
    %221 = comb.or %218, %219, %220 : i1
    llhd.drv %217, %221 after %0 : i1
    %222 = llhd.sig.extract %or_tree from %c14_i5 : <i31> -> <i1>
    %223 = comb.extract %2 from 29 : (i31) -> i1
    %224 = comb.extract %2 from 30 : (i31) -> i1
    %225 = comb.or %223, %224 : i1
    llhd.drv %222, %225 after %0 : i1
    %226 = llhd.sig.extract %and_tree from %c14_i5 : <i31> -> <i1>
    %227 = comb.extract %9 from 29 : (i31) -> i1
    %228 = comb.and %121, %227 : i1
    %229 = comb.extract %9 from 30 : (i31) -> i1
    %230 = comb.and %120, %229 : i1
    %231 = comb.or %228, %230 : i1
    llhd.drv %226, %231 after %0 : i1
    %232 = llhd.sig.extract %err_tree from %c14_i5 : <i31> -> <i1>
    %233 = comb.and %223, %224 : i1
    %234 = comb.extract %17 from 29 : (i31) -> i1
    %235 = comb.extract %17 from 30 : (i31) -> i1
    %236 = comb.or %233, %234, %235 : i1
    llhd.drv %232, %236 after %0 : i1
    %237 = llhd.sig.extract %or_tree from %c15_i5 : <i31> -> <i1>
    %238 = comb.extract %oh_i from 0 : (i9) -> i1
    llhd.drv %237, %238 after %0 : i1
    %239 = llhd.sig.extract %and_tree from %c15_i5 : <i31> -> <i1>
    llhd.drv %239, %238 after %0 : i1
    %240 = llhd.sig.extract %err_tree from %c15_i5 : <i31> -> <i1>
    llhd.drv %240, %false after %0 : i1
    %241 = llhd.sig.extract %or_tree from %c-16_i5 : <i31> -> <i1>
    %242 = comb.extract %oh_i from 1 : (i9) -> i1
    llhd.drv %241, %242 after %0 : i1
    %243 = llhd.sig.extract %and_tree from %c-16_i5 : <i31> -> <i1>
    llhd.drv %243, %242 after %0 : i1
    %244 = llhd.sig.extract %err_tree from %c-16_i5 : <i31> -> <i1>
    llhd.drv %244, %false after %0 : i1
    %245 = llhd.sig.extract %or_tree from %c-15_i5 : <i31> -> <i1>
    %246 = comb.extract %oh_i from 2 : (i9) -> i1
    llhd.drv %245, %246 after %0 : i1
    %247 = llhd.sig.extract %and_tree from %c-15_i5 : <i31> -> <i1>
    llhd.drv %247, %246 after %0 : i1
    %248 = llhd.sig.extract %err_tree from %c-15_i5 : <i31> -> <i1>
    llhd.drv %248, %false after %0 : i1
    %249 = llhd.sig.extract %or_tree from %c-14_i5 : <i31> -> <i1>
    %250 = comb.extract %oh_i from 3 : (i9) -> i1
    llhd.drv %249, %250 after %0 : i1
    %251 = llhd.sig.extract %and_tree from %c-14_i5 : <i31> -> <i1>
    llhd.drv %251, %250 after %0 : i1
    %252 = llhd.sig.extract %err_tree from %c-14_i5 : <i31> -> <i1>
    llhd.drv %252, %false after %0 : i1
    %253 = llhd.sig.extract %or_tree from %c-13_i5 : <i31> -> <i1>
    %254 = comb.extract %oh_i from 4 : (i9) -> i1
    llhd.drv %253, %254 after %0 : i1
    %255 = llhd.sig.extract %and_tree from %c-13_i5 : <i31> -> <i1>
    llhd.drv %255, %254 after %0 : i1
    %256 = llhd.sig.extract %err_tree from %c-13_i5 : <i31> -> <i1>
    llhd.drv %256, %false after %0 : i1
    %257 = llhd.sig.extract %or_tree from %c-12_i5 : <i31> -> <i1>
    %258 = comb.extract %oh_i from 5 : (i9) -> i1
    llhd.drv %257, %258 after %0 : i1
    %259 = llhd.sig.extract %and_tree from %c-12_i5 : <i31> -> <i1>
    llhd.drv %259, %258 after %0 : i1
    %260 = llhd.sig.extract %err_tree from %c-12_i5 : <i31> -> <i1>
    llhd.drv %260, %false after %0 : i1
    %261 = llhd.sig.extract %or_tree from %c-11_i5 : <i31> -> <i1>
    %262 = comb.extract %oh_i from 6 : (i9) -> i1
    llhd.drv %261, %262 after %0 : i1
    %263 = llhd.sig.extract %and_tree from %c-11_i5 : <i31> -> <i1>
    llhd.drv %263, %262 after %0 : i1
    %264 = llhd.sig.extract %err_tree from %c-11_i5 : <i31> -> <i1>
    llhd.drv %264, %false after %0 : i1
    %265 = llhd.sig.extract %or_tree from %c-10_i5 : <i31> -> <i1>
    %266 = comb.extract %oh_i from 7 : (i9) -> i1
    llhd.drv %265, %266 after %0 : i1
    %267 = llhd.sig.extract %and_tree from %c-10_i5 : <i31> -> <i1>
    llhd.drv %267, %266 after %0 : i1
    %268 = llhd.sig.extract %err_tree from %c-10_i5 : <i31> -> <i1>
    llhd.drv %268, %false after %0 : i1
    %269 = llhd.sig.extract %or_tree from %c-9_i5 : <i31> -> <i1>
    %270 = comb.extract %oh_i from 8 : (i9) -> i1
    llhd.drv %269, %270 after %0 : i1
    %271 = llhd.sig.extract %and_tree from %c-9_i5 : <i31> -> <i1>
    llhd.drv %271, %270 after %0 : i1
    %272 = llhd.sig.extract %err_tree from %c-9_i5 : <i31> -> <i1>
    llhd.drv %272, %false after %0 : i1
    %273 = llhd.sig.extract %or_tree from %c-8_i5 : <i31> -> <i1>
    llhd.drv %273, %false after %0 : i1
    %274 = llhd.sig.extract %and_tree from %c-8_i5 : <i31> -> <i1>
    llhd.drv %274, %false after %0 : i1
    %275 = llhd.sig.extract %err_tree from %c-8_i5 : <i31> -> <i1>
    llhd.drv %275, %false after %0 : i1
    %276 = llhd.sig.extract %or_tree from %c-7_i5 : <i31> -> <i1>
    llhd.drv %276, %false after %0 : i1
    %277 = llhd.sig.extract %and_tree from %c-7_i5 : <i31> -> <i1>
    llhd.drv %277, %false after %0 : i1
    %278 = llhd.sig.extract %err_tree from %c-7_i5 : <i31> -> <i1>
    llhd.drv %278, %false after %0 : i1
    %279 = llhd.sig.extract %or_tree from %c-6_i5 : <i31> -> <i1>
    llhd.drv %279, %false after %0 : i1
    %280 = llhd.sig.extract %and_tree from %c-6_i5 : <i31> -> <i1>
    llhd.drv %280, %false after %0 : i1
    %281 = llhd.sig.extract %err_tree from %c-6_i5 : <i31> -> <i1>
    llhd.drv %281, %false after %0 : i1
    %282 = llhd.sig.extract %or_tree from %c-5_i5 : <i31> -> <i1>
    llhd.drv %282, %false after %0 : i1
    %283 = llhd.sig.extract %and_tree from %c-5_i5 : <i31> -> <i1>
    llhd.drv %283, %false after %0 : i1
    %284 = llhd.sig.extract %err_tree from %c-5_i5 : <i31> -> <i1>
    llhd.drv %284, %false after %0 : i1
    %285 = llhd.sig.extract %or_tree from %c-4_i5 : <i31> -> <i1>
    llhd.drv %285, %false after %0 : i1
    %286 = llhd.sig.extract %and_tree from %c-4_i5 : <i31> -> <i1>
    llhd.drv %286, %false after %0 : i1
    %287 = llhd.sig.extract %err_tree from %c-4_i5 : <i31> -> <i1>
    llhd.drv %287, %false after %0 : i1
    %288 = llhd.sig.extract %or_tree from %c-3_i5 : <i31> -> <i1>
    llhd.drv %288, %false after %0 : i1
    %289 = llhd.sig.extract %and_tree from %c-3_i5 : <i31> -> <i1>
    llhd.drv %289, %false after %0 : i1
    %290 = llhd.sig.extract %err_tree from %c-3_i5 : <i31> -> <i1>
    llhd.drv %290, %false after %0 : i1
    %291 = llhd.sig.extract %or_tree from %c-2_i5 : <i31> -> <i1>
    llhd.drv %291, %false after %0 : i1
    %292 = llhd.sig.extract %and_tree from %c-2_i5 : <i31> -> <i1>
    llhd.drv %292, %false after %0 : i1
    %293 = llhd.sig.extract %err_tree from %c-2_i5 : <i31> -> <i1>
    llhd.drv %293, %false after %0 : i1
    %294 = comb.or %295, %298 : i1
    %295 = comb.extract %17 from 0 {sv.namehint = "oh0_err"} : (i31) -> i1
    %296 = comb.xor %en_i, %true : i1
    %297 = comb.extract %2 from 0 : (i31) -> i1
    %298 = comb.and %296, %297 {sv.namehint = "enable_err"} : i1
    hw.output %294 : i1
  }
  hw.module private @prim_reg_we_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i9, in %en_i : i1, out err_o : i1) {
    %c0_i4 = hw.constant 0 : i4
    %u_prim_buf.out_o = hw.instance "u_prim_buf" @prim_buf_17(in_i: %oh_i: i9) -> (out_o: i9) {sv.namehint = "oh_buf"}
    %u_prim_onehot_check.err_o = hw.instance "u_prim_onehot_check" @prim_onehot_check(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, oh_i: %u_prim_buf.out_o: i9, addr_i: %c0_i4: i4, en_i: %en_i: i1) -> (err_o: i1)
    hw.output %u_prim_onehot_check.err_o : i1
  }
  hw.module private @prim_sec_anchor_buf(in %in_i : i256, out out_o : i256) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf(in_i: %in_i: i256) -> (out_o: i256)
    hw.output %u_secure_anchor_buf.out_o : i256
  }
  hw.module private @prim_sec_anchor_buf_5(in %in_i : i2, out out_o : i2) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf_23(in_i: %in_i: i2) -> (out_o: i2)
    hw.output %u_secure_anchor_buf.out_o : i2
  }
  hw.module private @prim_sec_anchor_buf_6(in %in_i : i1, out out_o : i1) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf_10(in_i: %in_i: i1) -> (out_o: i1)
    hw.output %u_secure_anchor_buf.out_o : i1
  }
  hw.module private @prim_sec_anchor_flop(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_o : i2) {
    %u_secure_anchor_flop.q_o = hw.instance "u_secure_anchor_flop" @prim_flop_26(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %d_i: i2) -> (q_o: i2)
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
    %u_state_flop.q_o = hw.instance "u_state_flop" @prim_flop_30(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %state_i: i9) -> (q_o: i9) {sv.namehint = "state_raw"}
    hw.output %u_state_flop.q_o : i9
  }
  hw.module private @prim_subreg_arb(in %we : i1, in %wd : i1, in %de : i1, in %d : i1, in %q : i1, out wr_en : i1, out wr_data : i1) {
    hw.output %de, %d : i1, i1
  }
  hw.module private @prim_subreg_arb_19(in %we : i1, in %wd : i1, in %de : i1, in %d : i1, in %q : i1, out wr_en : i1, out wr_data : i1) {
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
  hw.module private @prim_subreg_arb_20(in %we : i1, in %wd : i4, in %de : i1, in %d : i4, in %q : i4, out wr_en : i1, out wr_data : i4) {
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
  hw.module private @prim_subreg_arb_21(in %we : i1, in %wd : i1, in %de : i1, in %d : i1, in %q : i1, out wr_en : i1, out wr_data : i1) {
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
  hw.module private @prim_subreg_arb_22(in %we : i1, in %wd : i4, in %de : i1, in %d : i4, in %q : i4, out wr_en : i1, out wr_data : i4) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c-1_i4 = hw.constant -1 : i4
    %c6_i4 = hw.constant 6 : i4
    %c0_i4 = hw.constant 0 : i4
    %wd_0 = llhd.sig name "wd" %c0_i4 : i4
    %d_1 = llhd.sig name "d" %c0_i4 : i4
    %q_2 = llhd.sig name "q" %c0_i4 : i4
    %1 = comb.or %we, %de : i1
    %2 = llhd.prb %d_1 : i4
    %3 = llhd.prb %q_2 : i4
    %4 = comb.mux %de, %2, %3 : i4
    %5 = llhd.prb %wd_0 : i4
    %6 = comb.xor %5, %c-1_i4 : i4
    %7 = comb.mux %we, %6, %c6_i4 : i4
    %8 = func.call @"prim_mubi_pkg::mubi4_and_hi"(%4, %7) : (i4, i4) -> i4
    llhd.drv %wd_0, %wd after %0 : i4
    llhd.drv %d_1, %d after %0 : i4
    llhd.drv %q_2, %q after %0 : i4
    hw.output %1, %8 : i1, i4
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
  hw.module private @prim_subreg_1(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i1, in %de : i1, in %d : i1, out qe : i1, out q : i1, out ds : i1, out qs : i1) {
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
  hw.module private @prim_subreg_2(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i4, in %de : i1, in %d : i4, out qe : i1, out q : i4, out ds : i4, out qs : i4) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %c-7_i4 = hw.constant -7 : i4
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_20(we: %we: i1, wd: %wd: i4, de: %de: i1, d: %d: i4, q: %4: i4) -> (wr_en: i1, wr_data: i4)
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
      llhd.drv %q, %c-7_i4 after %0 : i4
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
  hw.module private @prim_subreg_3(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i1, in %de : i1, in %d : i1, out qe : i1, out q : i1, out ds : i1, out qs : i1) {
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
  hw.module private @prim_subreg_4(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i4, in %de : i1, in %d : i4, out qe : i1, out q : i4, out ds : i4, out qs : i4) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %c-7_i4 = hw.constant -7 : i4
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_22(we: %we: i1, wd: %wd: i4, de: %de: i1, d: %d: i4, q: %4: i4) -> (wr_en: i1, wr_data: i4)
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
      llhd.drv %q, %c-7_i4 after %0 : i4
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
  hw.module private @prim_subst_perm(in %data_i : i10, in %key_i : i10, out data_o : i10) {
    %false = hw.constant false
    %c9_i32 = hw.constant 9 : i32
    %0 = hw.aggregate_constant [2 : i4, 1 : i4, 7 : i4, 4 : i4, -8 : i4, -1 : i4, -2 : i4, 3 : i4, -3 : i4, -6 : i4, 0 : i4, -7 : i4, -5 : i4, 6 : i4, 5 : i4, -4 : i4] : !hw.array<16xi4>
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %c-1_i10 = hw.constant -1 : i10
    %c0_i22 = hw.constant 0 : i22
    %c-1_i4 = hw.constant -1 : i4
    %c0_i28 = hw.constant 0 : i28
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %2 = hw.aggregate_constant [0 : i10, 0 : i10, 0 : i10] : !hw.array<3xi10>
    %c5_i32 = hw.constant 5 : i32
    %c2_i32 = hw.constant 2 : i32
    %c10_i32 = hw.constant 10 : i32
    %c1_i32 = hw.constant 1 : i32
    %c0_i32 = hw.constant 0 : i32
    %c0_i10 = hw.constant 0 : i10
    %key_i_0 = llhd.sig name "key_i" %c0_i10 : i10
    %data_state = llhd.sig %2 : !hw.array<3xi10>
    %gen_round_0.data_state_sbox = llhd.sig %c0_i10 : i10
    %gen_round_0.data_state_flipped = llhd.sig %c0_i10 : i10
    %gen_round_1.data_state_sbox = llhd.sig %c0_i10 : i10
    %gen_round_1.data_state_flipped = llhd.sig %c0_i10 : i10
    %3 = llhd.sig.array_get %data_state[%c0_i2] : <!hw.array<3xi10>>
    llhd.drv %3, %data_i after %1 : i10
    %4 = llhd.prb %data_state : !hw.array<3xi10>
    %5 = llhd.prb %key_i_0 : i10
    %6 = llhd.prb %gen_round_0.data_state_sbox : i10
    %7 = llhd.prb %gen_round_0.data_state_flipped : i10
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb9
      %12 = llhd.prb %data_state : !hw.array<3xi10>
      %13 = hw.array_get %12[%c0_i2] : !hw.array<3xi10>, i2
      %14 = llhd.prb %key_i_0 : i10
      %15 = comb.xor %13, %14 : i10
      llhd.drv %gen_round_0.data_state_sbox, %15 after %1 : i10
      cf.br ^bb2(%c0_i32 : i32)
    ^bb2(%16: i32):  // 2 preds: ^bb1, ^bb3
      %17 = comb.icmp slt %16, %c2_i32 : i32
      cf.cond_br %17, ^bb3, ^bb4(%c0_i32 : i32)
    ^bb3:  // pred: ^bb2
      %18 = comb.extract %16 from 2 : (i32) -> i28
      %19 = comb.icmp eq %18, %c0_i28 : i28
      %20 = comb.extract %16 from 0 : (i32) -> i2
      %21 = comb.concat %20, %c0_i2 : i2, i2
      %22 = comb.mux %19, %21, %c-1_i4 : i4
      %23 = llhd.sig.extract %gen_round_0.data_state_sbox from %22 : <i10> -> <i4>
      %24 = llhd.prb %gen_round_0.data_state_sbox : i10
      %25 = comb.extract %16 from 8 : (i32) -> i22
      %26 = comb.icmp eq %25, %c0_i22 : i22
      %27 = comb.extract %16 from 0 : (i32) -> i8
      %28 = comb.concat %27, %c0_i2 : i8, i2
      %29 = comb.mux %26, %28, %c-1_i10 : i10
      %30 = comb.shru %24, %29 : i10
      %31 = comb.extract %30 from 0 : (i10) -> i4
      %32 = hw.array_get %0[%31] : !hw.array<16xi4>, i4
      llhd.drv %23, %32 after %1 : i4
      %33 = comb.add %16, %c1_i32 : i32
      cf.br ^bb2(%33 : i32)
    ^bb4(%34: i32):  // 2 preds: ^bb2, ^bb5
      %35 = comb.icmp slt %34, %c10_i32 : i32
      cf.cond_br %35, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      %36 = comb.sub %c9_i32, %34 : i32
      %37 = comb.extract %36 from 4 : (i32) -> i28
      %38 = comb.icmp eq %37, %c0_i28 : i28
      %39 = comb.extract %36 from 0 : (i32) -> i4
      %40 = comb.mux %38, %39, %c-1_i4 : i4
      %41 = llhd.sig.extract %gen_round_0.data_state_flipped from %40 : <i10> -> <i1>
      %42 = llhd.prb %gen_round_0.data_state_sbox : i10
      %43 = comb.extract %34 from 10 : (i32) -> i22
      %44 = comb.icmp eq %43, %c0_i22 : i22
      %45 = comb.extract %34 from 0 : (i32) -> i10
      %46 = comb.mux %44, %45, %c-1_i10 : i10
      %47 = comb.shru %42, %46 : i10
      %48 = comb.extract %47 from 0 : (i10) -> i1
      llhd.drv %41, %48 after %1 : i1
      %49 = comb.add %34, %c1_i32 : i32
      cf.br ^bb4(%49 : i32)
    ^bb6:  // pred: ^bb4
      %50 = llhd.prb %gen_round_0.data_state_flipped : i10
      llhd.drv %gen_round_0.data_state_sbox, %50 after %1 : i10
      cf.br ^bb7(%c0_i32 : i32)
    ^bb7(%51: i32):  // 2 preds: ^bb6, ^bb8
      %52 = comb.icmp slt %51, %c5_i32 : i32
      cf.cond_br %52, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %53 = comb.extract %51 from 4 : (i32) -> i28
      %54 = comb.icmp eq %53, %c0_i28 : i28
      %55 = comb.extract %51 from 0 : (i32) -> i4
      %56 = comb.mux %54, %55, %c-1_i4 : i4
      %57 = llhd.sig.extract %gen_round_0.data_state_sbox from %56 : <i10> -> <i1>
      %58 = llhd.prb %gen_round_0.data_state_flipped : i10
      %59 = comb.extract %51 from 0 : (i32) -> i31
      %60 = comb.concat %59, %false : i31, i1
      %61 = comb.extract %51 from 9 : (i32) -> i22
      %62 = comb.icmp eq %61, %c0_i22 : i22
      %63 = comb.extract %51 from 0 : (i32) -> i9
      %64 = comb.concat %63, %false : i9, i1
      %65 = comb.mux %62, %64, %c-1_i10 : i10
      %66 = comb.shru %58, %65 : i10
      %67 = comb.extract %66 from 0 : (i10) -> i1
      llhd.drv %57, %67 after %1 : i1
      %68 = comb.add %51, %c5_i32 : i32
      %69 = comb.extract %68 from 4 : (i32) -> i28
      %70 = comb.icmp eq %69, %c0_i28 : i28
      %71 = comb.extract %68 from 0 : (i32) -> i4
      %72 = comb.mux %70, %71, %c-1_i4 : i4
      %73 = llhd.sig.extract %gen_round_0.data_state_sbox from %72 : <i10> -> <i1>
      %74 = llhd.prb %gen_round_0.data_state_flipped : i10
      %75 = comb.add %60, %c1_i32 : i32
      %76 = comb.extract %75 from 10 : (i32) -> i22
      %77 = comb.icmp eq %76, %c0_i22 : i22
      %78 = comb.extract %75 from 0 : (i32) -> i10
      %79 = comb.mux %77, %78, %c-1_i10 : i10
      %80 = comb.shru %74, %79 : i10
      %81 = comb.extract %80 from 0 : (i10) -> i1
      llhd.drv %73, %81 after %1 : i1
      %82 = comb.add %51, %c1_i32 : i32
      cf.br ^bb7(%82 : i32)
    ^bb9:  // pred: ^bb7
      %83 = llhd.sig.array_get %data_state[%c1_i2] : <!hw.array<3xi10>>
      %84 = llhd.prb %gen_round_0.data_state_sbox : i10
      llhd.drv %83, %84 after %1 : i10
      llhd.wait (%4, %5, %6, %7 : !hw.array<3xi10>, i10, i10, i10), ^bb1
    }
    %8 = llhd.prb %gen_round_1.data_state_sbox : i10
    %9 = llhd.prb %gen_round_1.data_state_flipped : i10
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb9
      %12 = llhd.prb %data_state : !hw.array<3xi10>
      %13 = hw.array_get %12[%c1_i2] : !hw.array<3xi10>, i2
      %14 = llhd.prb %key_i_0 : i10
      %15 = comb.xor %13, %14 : i10
      llhd.drv %gen_round_1.data_state_sbox, %15 after %1 : i10
      cf.br ^bb2(%c0_i32 : i32)
    ^bb2(%16: i32):  // 2 preds: ^bb1, ^bb3
      %17 = comb.icmp slt %16, %c2_i32 : i32
      cf.cond_br %17, ^bb3, ^bb4(%c0_i32 : i32)
    ^bb3:  // pred: ^bb2
      %18 = comb.extract %16 from 2 : (i32) -> i28
      %19 = comb.icmp eq %18, %c0_i28 : i28
      %20 = comb.extract %16 from 0 : (i32) -> i2
      %21 = comb.concat %20, %c0_i2 : i2, i2
      %22 = comb.mux %19, %21, %c-1_i4 : i4
      %23 = llhd.sig.extract %gen_round_1.data_state_sbox from %22 : <i10> -> <i4>
      %24 = llhd.prb %gen_round_1.data_state_sbox : i10
      %25 = comb.extract %16 from 8 : (i32) -> i22
      %26 = comb.icmp eq %25, %c0_i22 : i22
      %27 = comb.extract %16 from 0 : (i32) -> i8
      %28 = comb.concat %27, %c0_i2 : i8, i2
      %29 = comb.mux %26, %28, %c-1_i10 : i10
      %30 = comb.shru %24, %29 : i10
      %31 = comb.extract %30 from 0 : (i10) -> i4
      %32 = hw.array_get %0[%31] : !hw.array<16xi4>, i4
      llhd.drv %23, %32 after %1 : i4
      %33 = comb.add %16, %c1_i32 : i32
      cf.br ^bb2(%33 : i32)
    ^bb4(%34: i32):  // 2 preds: ^bb2, ^bb5
      %35 = comb.icmp slt %34, %c10_i32 : i32
      cf.cond_br %35, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      %36 = comb.sub %c9_i32, %34 : i32
      %37 = comb.extract %36 from 4 : (i32) -> i28
      %38 = comb.icmp eq %37, %c0_i28 : i28
      %39 = comb.extract %36 from 0 : (i32) -> i4
      %40 = comb.mux %38, %39, %c-1_i4 : i4
      %41 = llhd.sig.extract %gen_round_1.data_state_flipped from %40 : <i10> -> <i1>
      %42 = llhd.prb %gen_round_1.data_state_sbox : i10
      %43 = comb.extract %34 from 10 : (i32) -> i22
      %44 = comb.icmp eq %43, %c0_i22 : i22
      %45 = comb.extract %34 from 0 : (i32) -> i10
      %46 = comb.mux %44, %45, %c-1_i10 : i10
      %47 = comb.shru %42, %46 : i10
      %48 = comb.extract %47 from 0 : (i10) -> i1
      llhd.drv %41, %48 after %1 : i1
      %49 = comb.add %34, %c1_i32 : i32
      cf.br ^bb4(%49 : i32)
    ^bb6:  // pred: ^bb4
      %50 = llhd.prb %gen_round_1.data_state_flipped : i10
      llhd.drv %gen_round_1.data_state_sbox, %50 after %1 : i10
      cf.br ^bb7(%c0_i32 : i32)
    ^bb7(%51: i32):  // 2 preds: ^bb6, ^bb8
      %52 = comb.icmp slt %51, %c5_i32 : i32
      cf.cond_br %52, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %53 = comb.extract %51 from 4 : (i32) -> i28
      %54 = comb.icmp eq %53, %c0_i28 : i28
      %55 = comb.extract %51 from 0 : (i32) -> i4
      %56 = comb.mux %54, %55, %c-1_i4 : i4
      %57 = llhd.sig.extract %gen_round_1.data_state_sbox from %56 : <i10> -> <i1>
      %58 = llhd.prb %gen_round_1.data_state_flipped : i10
      %59 = comb.extract %51 from 0 : (i32) -> i31
      %60 = comb.concat %59, %false : i31, i1
      %61 = comb.extract %51 from 9 : (i32) -> i22
      %62 = comb.icmp eq %61, %c0_i22 : i22
      %63 = comb.extract %51 from 0 : (i32) -> i9
      %64 = comb.concat %63, %false : i9, i1
      %65 = comb.mux %62, %64, %c-1_i10 : i10
      %66 = comb.shru %58, %65 : i10
      %67 = comb.extract %66 from 0 : (i10) -> i1
      llhd.drv %57, %67 after %1 : i1
      %68 = comb.add %51, %c5_i32 : i32
      %69 = comb.extract %68 from 4 : (i32) -> i28
      %70 = comb.icmp eq %69, %c0_i28 : i28
      %71 = comb.extract %68 from 0 : (i32) -> i4
      %72 = comb.mux %70, %71, %c-1_i4 : i4
      %73 = llhd.sig.extract %gen_round_1.data_state_sbox from %72 : <i10> -> <i1>
      %74 = llhd.prb %gen_round_1.data_state_flipped : i10
      %75 = comb.add %60, %c1_i32 : i32
      %76 = comb.extract %75 from 10 : (i32) -> i22
      %77 = comb.icmp eq %76, %c0_i22 : i22
      %78 = comb.extract %75 from 0 : (i32) -> i10
      %79 = comb.mux %77, %78, %c-1_i10 : i10
      %80 = comb.shru %74, %79 : i10
      %81 = comb.extract %80 from 0 : (i10) -> i1
      llhd.drv %73, %81 after %1 : i1
      %82 = comb.add %51, %c1_i32 : i32
      cf.br ^bb7(%82 : i32)
    ^bb9:  // pred: ^bb7
      %83 = llhd.sig.array_get %data_state[%c-2_i2] : <!hw.array<3xi10>>
      %84 = llhd.prb %gen_round_1.data_state_sbox : i10
      llhd.drv %83, %84 after %1 : i10
      llhd.wait (%4, %5, %8, %9 : !hw.array<3xi10>, i10, i10, i10), ^bb1
    }
    %10 = hw.array_get %4[%c-2_i2] : !hw.array<3xi10>, i2
    %11 = comb.xor %10, %5 : i10
    llhd.drv %key_i_0, %key_i after %1 : i10
    hw.output %11 : i10
  }
  hw.module private @prim_subst_perm_14(in %data_i : i39, in %key_i : i39, out data_o : i39) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i0 = hw.constant 0 : i0
    %1 = hw.aggregate_constant [0 : i39] : !hw.array<1xi39>
    %data_state = llhd.sig %1 : !hw.array<1xi39>
    %2 = llhd.sig.array_get %data_state[%c0_i0] : <!hw.array<1xi39>>
    llhd.drv %2, %data_i after %0 : i39
    %3 = llhd.prb %data_state : !hw.array<1xi39>
    %4 = hw.array_get %3[%c0_i0] : !hw.array<1xi39>, i0
    %5 = comb.xor %4, %key_i : i39
    hw.output %5 : i39
  }
  hw.module private @prim_subst_perm_15(in %data_i : i39, in %key_i : i39, out data_o : i39) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i0 = hw.constant 0 : i0
    %1 = hw.aggregate_constant [0 : i39] : !hw.array<1xi39>
    %data_state = llhd.sig %1 : !hw.array<1xi39>
    %2 = llhd.sig.array_get %data_state[%c0_i0] : <!hw.array<1xi39>>
    llhd.drv %2, %data_i after %0 : i39
    %3 = llhd.prb %data_state : !hw.array<1xi39>
    %4 = hw.array_get %3[%c0_i0] : !hw.array<1xi39>, i0
    %5 = comb.xor %4, %key_i : i39
    hw.output %5 : i39
  }
  hw.module private @prim_sync_reqack_data(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, in %req_chk_i : i1, in %src_req_i : i1, out src_ack_o : i1, out dst_req_o : i1, in %dst_ack_i : i1, in %data_i : i257, out data_o : i257) {
    %u_prim_sync_reqack.src_ack_o, %u_prim_sync_reqack.dst_req_o = hw.instance "u_prim_sync_reqack" @prim_sync_reqack(clk_src_i: %clk_src_i: i1, rst_src_ni: %rst_src_ni: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1, req_chk_i: %req_chk_i: i1, src_req_i: %src_req_i: i1, dst_ack_i: %dst_ack_i: i1) -> (src_ack_o: i1, dst_req_o: i1)
    hw.output %u_prim_sync_reqack.src_ack_o, %u_prim_sync_reqack.dst_req_o, %data_i : i1, i1, i257
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
    %gen_nrz_hs_protocol.req_sync.q_o = hw.instance "gen_nrz_hs_protocol.req_sync" @prim_flop_2sync_24(clk_i: %4: i1, rst_ni: %5: i1, d_i: %6: i1) -> (q_o: i1)
    llhd.drv %gen_nrz_hs_protocol.dst_req, %gen_nrz_hs_protocol.req_sync.q_o after %1 : i1
    %7 = llhd.prb %gen_nrz_hs_protocol.dst_ack_q : i1
    %gen_nrz_hs_protocol.ack_sync.q_o = hw.instance "gen_nrz_hs_protocol.ack_sync" @prim_flop_2sync_24(clk_i: %2: i1, rst_ni: %3: i1, d_i: %7: i1) -> (q_o: i1)
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
  hw.module private @tlul_adapter_racl(in %clk_i : i1, in %rst_ni : i1, in %tl_h2d_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_d2h_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_filtered_h2d_o : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, in %tl_filtered_d2h_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %racl_policies_i : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, out racl_error_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, in %racl_policy_sel_ranges_i : !hw.array<1xstruct<base: i32, limit: i32, policy_sel: i1, enable: i1>>) {
    %0 = hw.aggregate_constant [false, false, false, false, false, 0 : i32] : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    hw.output %tl_filtered_d2h_i, %tl_h2d_i, %0 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
  }
  hw.module private @tlul_adapter_reg(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %en_ifetch_i : i4, out intg_error_o : i1, out re_o : i1, out we_o : i1, out addr_o : i6, out wdata_o : i32, out be_o : i4, in %busy_i : i1, in %rdata_i : i32, in %error_i : i1) {
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
    %22 = comb.extract %a_address from 2 : (i32) -> i4
    %23 = comb.concat %22, %c0_i2 : i4, i2
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
    hw.output %u_rsp_intg_gen.tl_o, %false, %21, %19, %23, %a_data, %a_mask : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, i1, i1, i1, i6, i32, i4
  }
  hw.module private @tlul_adapter_sram_racl(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %en_ifetch_i : i4, out req_o : i1, out req_type_o : i4, in %gnt_i : i1, out we_o : i1, out addr_o : i10, out wdata_o : i39, out wmask_o : i39, out intg_error_o : i1, out user_rsvd_o : i5, in %rdata_i : i39, in %rvalid_i : i1, in %rerror_i : i2, out compound_txn_in_progress_o : i1, in %readback_en_i : i4, out readback_error_o : i1, in %wr_collision_i : i1, in %write_pending_i : i1, in %racl_policies_i : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, out racl_error_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, in %racl_policy_sel_ranges_i : !hw.array<1xstruct<base: i32, limit: i32, policy_sel: i1, enable: i1>>) {
    %tlul_adapter_racl.tl_d2h_o, %tlul_adapter_racl.tl_filtered_h2d_o, %tlul_adapter_racl.racl_error_o = hw.instance "tlul_adapter_racl" @tlul_adapter_racl(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, tl_h2d_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, tl_filtered_d2h_i: %tlul_adapter_sram.tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, racl_policies_i: %racl_policies_i: !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, racl_policy_sel_ranges_i: %racl_policy_sel_ranges_i: !hw.array<1xstruct<base: i32, limit: i32, policy_sel: i1, enable: i1>>) -> (tl_d2h_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, tl_filtered_h2d_o: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, racl_error_o: !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>) {sv.namehint = "tl_h2d_filtered"}
    %tlul_adapter_sram.tl_o, %tlul_adapter_sram.req_o, %tlul_adapter_sram.req_type_o, %tlul_adapter_sram.we_o, %tlul_adapter_sram.addr_o, %tlul_adapter_sram.wdata_o, %tlul_adapter_sram.wmask_o, %tlul_adapter_sram.intg_error_o, %tlul_adapter_sram.user_rsvd_o, %tlul_adapter_sram.compound_txn_in_progress_o, %tlul_adapter_sram.readback_error_o = hw.instance "tlul_adapter_sram" @tlul_adapter_sram(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, tl_i: %tlul_adapter_racl.tl_filtered_h2d_o: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, en_ifetch_i: %en_ifetch_i: i4, gnt_i: %gnt_i: i1, rdata_i: %rdata_i: i39, rvalid_i: %rvalid_i: i1, rerror_i: %rerror_i: i2, readback_en_i: %readback_en_i: i4, wr_collision_i: %wr_collision_i: i1, write_pending_i: %write_pending_i: i1) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, req_o: i1, req_type_o: i4, we_o: i1, addr_o: i10, wdata_o: i39, wmask_o: i39, intg_error_o: i1, user_rsvd_o: i5, compound_txn_in_progress_o: i1, readback_error_o: i1) {sv.namehint = "tl_d2h_filtered"}
    hw.output %tlul_adapter_racl.tl_d2h_o, %tlul_adapter_sram.req_o, %tlul_adapter_sram.req_type_o, %tlul_adapter_sram.we_o, %tlul_adapter_sram.addr_o, %tlul_adapter_sram.wdata_o, %tlul_adapter_sram.wmask_o, %tlul_adapter_sram.intg_error_o, %tlul_adapter_sram.user_rsvd_o, %tlul_adapter_sram.compound_txn_in_progress_o, %tlul_adapter_sram.readback_error_o, %tlul_adapter_racl.racl_error_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, i1, i4, i1, i10, i39, i39, i1, i5, i1, i1, !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
  }
  hw.module private @tlul_adapter_sram(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %en_ifetch_i : i4, out req_o : i1, out req_type_o : i4, in %gnt_i : i1, out we_o : i1, out addr_o : i10, out wdata_o : i39, out wmask_o : i39, out intg_error_o : i1, out user_rsvd_o : i5, in %rdata_i : i39, in %rvalid_i : i1, in %rerror_i : i2, out compound_txn_in_progress_o : i1, in %readback_en_i : i4, out readback_error_o : i1, in %wr_collision_i : i1, in %write_pending_i : i1) {
    %c-1_i7 = hw.constant -1 : i7
    %c0_i4 = hw.constant 0 : i4
    %c0_i28 = hw.constant 0 : i28
    %c-1_i5 = hw.constant -1 : i5
    %c0_i27 = hw.constant 0 : i27
    %c0_i0 = hw.constant 0 : i0
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i39 = hw.constant 0 : i39
    %2 = hw.aggregate_constant [0 : i7] : !hw.array<1xi7>
    %3 = hw.aggregate_constant [0 : i32] : !hw.array<1xi32>
    %4 = hw.aggregate_constant [0 : i39] : !hw.array<1xi39>
    %5 = hw.aggregate_constant [0 : i32, 0 : i7, false] : !hw.struct<data: i32, data_intg: i7, error: i1>
    %6 = hw.aggregate_constant [0 : i4, false] : !hw.struct<mask: i4, woffset: i1>
    %7 = hw.aggregate_constant [false, false, 0 : i4, 0 : i2, 0 : i8] : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
    %8 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %c4_i32 = hw.constant 4 : i32
    %false = hw.constant false {sv.namehint = "rd_vld_error"}
    %c180388626432_i39 = hw.constant 180388626432 : i39
    %c-4_i3 = hw.constant -4 : i3
    %true = hw.constant true
    %c0_i5 = hw.constant 0 : i5
    %c0_i10 = hw.constant 0 : i10
    %c0_i7 = hw.constant 0 : i7
    %c0_i8 = hw.constant 0 : i8
    %c0_i2 = hw.constant 0 : i2
    %c42_i7 = hw.constant 42 : i7
    %c0_i12 = hw.constant 0 : i12
    %c-1_i4 = hw.constant -1 : i4
    %c1_i3 = hw.constant 1 : i3
    %c0_i3 = hw.constant 0 : i3
    %c0_i32 = hw.constant 0 : i32
    %c1_i32 = hw.constant 1 : i32
    %c-1_i32 = hw.constant -1 : i32
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %9 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %10 = llhd.prb %rst_ni_1 : i1
    %we_o = llhd.sig %false : i1
    %rsp_fifo_error = llhd.sig %false : i1
    %sramreqfifo_error = llhd.sig %false : i1
    %reqfifo_error = llhd.sig %false : i1
    %intg_error = llhd.sig %false : i1
    %readback_error = llhd.sig %false : i1
    %readback_error_q = llhd.sig %false : i1
    %intg_error_q = llhd.sig %false : i1
    %tl_i_int = llhd.sig %8 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %reqfifo_rvalid = llhd.sig %false : i1
    %reqfifo_rdata = llhd.sig %7 : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
    %sram_req_rdata = llhd.sig %6 : !hw.struct<mask: i4, woffset: i1>
    %sram_addr_rdata = llhd.sig %c0_i12 : i12
    %rspfifo_rvalid = llhd.sig %false : i1
    %rspfifo_rdata = llhd.sig %5 : !hw.struct<data: i32, data_intg: i7, error: i1>
    %d_valid = llhd.sig %false : i1
    %d_error = llhd.sig %false : i1
    %vld_rd_rsp = llhd.sig %false : i1
    %error_blanking_data = llhd.sig %c0_i32 : i32
    %error_instr_integ = llhd.sig %c0_i7 : i7
    %error_data_integ = llhd.sig %c0_i7 : i7
    %error_blanking_integ = llhd.sig %c0_i7 : i7
    %missed_err_gnt_d = llhd.sig %false : i1
    %missed_err_gnt_q = llhd.sig %false : i1
    %woffset = llhd.sig %false : i1
    %wmask_combined = llhd.sig %4 : !hw.array<1xi39>
    %wdata_combined = llhd.sig %4 : !hw.array<1xi39>
    %wmask_int = llhd.sig %3 : !hw.array<1xi32>
    %wdata_int = llhd.sig %3 : !hw.array<1xi32>
    %wmask_intg = llhd.sig %2 : !hw.array<1xi7>
    %wdata_intg = llhd.sig %2 : !hw.array<1xi7>
    %rdata_reshaped = llhd.sig %4 : !hw.array<1xi39>
    %rdata_tlword = llhd.sig %c0_i39 : i39
    %gen_cmd_intg_check.u_cmd_intg_chk.err_o = hw.instance "gen_cmd_intg_check.u_cmd_intg_chk" @tlul_cmd_intg_chk(tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> (err_o: i1)
    llhd.drv %intg_error, %gen_cmd_intg_check.u_cmd_intg_chk.err_o after %1 : i1
    %u_err.err_o = hw.instance "u_err" @tlul_err(clk_i: %9: i1, rst_ni: %10: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> (err_o: i1) {sv.namehint = "tlul_error"}
    %u_rsp_gen.tl_o = hw.instance "u_rsp_gen" @tlul_rsp_intg_gen_31(tl_i: %u_sram_byte.tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
    %u_sram_byte.tl_o, %u_sram_byte.tl_sram_o, %u_sram_byte.error_o, %u_sram_byte.alert_o, %u_sram_byte.compound_txn_in_progress_o = hw.instance "u_sram_byte" @tlul_sram_byte(clk_i: %9: i1, rst_ni: %10: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, tl_sram_i: %70: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, error_i: %30: i1, readback_en_i: %readback_en_i: i4, wr_collision_i: %wr_collision_i: i1, write_pending_i: %write_pending_i: i1) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, tl_sram_o: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, error_o: i1, alert_o: i1, compound_txn_in_progress_o: i1) {sv.namehint = "tl_out"}
    llhd.drv %tl_i_int, %u_sram_byte.tl_sram_o after %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %u_tlul_data_integ_enc_instr.data_intg_o = hw.instance "u_tlul_data_integ_enc_instr" @tlul_data_integ_enc(data_i: %c0_i32: i32) -> (data_intg_o: i39)
    %11 = comb.extract %u_tlul_data_integ_enc_instr.data_intg_o from 32 : (i39) -> i7
    llhd.drv %error_instr_integ, %11 after %1 : i7
    %u_tlul_data_integ_enc_data.data_intg_o = hw.instance "u_tlul_data_integ_enc_data" @tlul_data_integ_enc(data_i: %c-1_i32: i32) -> (data_intg_o: i39)
    %12 = comb.extract %u_tlul_data_integ_enc_data.data_intg_o from 32 : (i39) -> i7
    llhd.drv %error_data_integ, %12 after %1 : i7
    %13 = hw.bitcast %99 : (!hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>) -> i16
    %u_reqfifo.wready_o, %u_reqfifo.rvalid_o, %u_reqfifo.rdata_o, %u_reqfifo.full_o, %u_reqfifo.depth_o, %u_reqfifo.err_o = hw.instance "u_reqfifo" @prim_fifo_sync(clk_i: %9: i1, rst_ni: %10: i1, clr_i: %false: i1, wvalid_i: %34: i1, wdata_i: %13: i16, rready_i: %35: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i16, full_o: i1, depth_o: i2, err_o: i1) {sv.namehint = "reqfifo_wready"}
    llhd.drv %reqfifo_rvalid, %u_reqfifo.rvalid_o after %1 : i1
    %14 = hw.bitcast %u_reqfifo.rdata_o : (i16) -> !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
    llhd.drv %reqfifo_rdata, %14 after %1 : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
    llhd.drv %reqfifo_error, %u_reqfifo.err_o after %1 : i1
    %u_sramreqfifo.wready_o, %u_sramreqfifo.rvalid_o, %u_sramreqfifo.rdata_o, %u_sramreqfifo.full_o, %u_sramreqfifo.depth_o, %u_sramreqfifo.err_o = hw.instance "u_sramreqfifo" @prim_fifo_sync_32(clk_i: %9: i1, rst_ni: %10: i1, clr_i: %false: i1, wvalid_i: %102: i1, wdata_i: %32: i5, rready_i: %103: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i5, full_o: i1, depth_o: i2, err_o: i1) {sv.namehint = "sramreqfifo_rdata"}
    llhd.drv %sramreqfifo_error, %u_sramreqfifo.err_o after %1 : i1
    %15 = hw.bitcast %112 : (!hw.struct<data: i32, data_intg: i7, error: i1>) -> i40
    %u_rspfifo.wready_o, %u_rspfifo.rvalid_o, %u_rspfifo.rdata_o, %u_rspfifo.full_o, %u_rspfifo.depth_o, %u_rspfifo.err_o = hw.instance "u_rspfifo" @prim_fifo_sync_33(clk_i: %9: i1, rst_ni: %10: i1, clr_i: %false: i1, wvalid_i: %103: i1, wdata_i: %15: i40, rready_i: %114: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i40, full_o: i1, depth_o: i2, err_o: i1) {sv.namehint = "rspfifo_wready"}
    llhd.drv %rspfifo_rvalid, %u_rspfifo.rvalid_o after %1 : i1
    %16 = hw.bitcast %u_rspfifo.rdata_o : (i40) -> !hw.struct<data: i32, data_intg: i7, error: i1>
    llhd.drv %rspfifo_rdata, %16 after %1 : !hw.struct<data: i32, data_intg: i7, error: i1>
    llhd.drv %rsp_fifo_error, %u_rspfifo.err_o after %1 : i1
    llhd.drv %readback_error, %u_sram_byte.alert_o after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %115 = llhd.prb %clk_i_0 : i1
      %116 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%9, %10 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %117 = llhd.prb %clk_i_0 : i1
      %118 = comb.xor bin %115, %true : i1
      %119 = comb.and bin %118, %117 : i1
      %120 = llhd.prb %rst_ni_1 : i1
      %121 = comb.xor bin %120, %true : i1
      %122 = comb.and bin %116, %121 : i1
      %123 = comb.or bin %119, %122 : i1
      cf.cond_br %123, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %124 = llhd.prb %rst_ni_1 : i1
      %125 = comb.xor %124, %true : i1
      cf.cond_br %125, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %readback_error_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %126 = llhd.prb %readback_error : i1
      cf.cond_br %126, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %readback_error_q, %true after %0 : i1
      cf.br ^bb1
    }
    %17 = llhd.prb %readback_error : i1
    %18 = llhd.prb %readback_error_q : i1
    %19 = comb.or %17, %18 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %115 = llhd.prb %clk_i_0 : i1
      %116 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%9, %10 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %117 = llhd.prb %clk_i_0 : i1
      %118 = comb.xor bin %115, %true : i1
      %119 = comb.and bin %118, %117 : i1
      %120 = llhd.prb %rst_ni_1 : i1
      %121 = comb.xor bin %120, %true : i1
      %122 = comb.and bin %116, %121 : i1
      %123 = comb.or bin %119, %122 : i1
      cf.cond_br %123, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %124 = llhd.prb %rst_ni_1 : i1
      %125 = comb.xor %124, %true : i1
      cf.cond_br %125, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %intg_error_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %126 = llhd.prb %intg_error : i1
      %127 = llhd.prb %rsp_fifo_error : i1
      %128 = llhd.prb %sramreqfifo_error : i1
      %129 = llhd.prb %reqfifo_error : i1
      %130 = comb.or %126, %127, %128, %129 : i1
      cf.cond_br %130, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %intg_error_q, %true after %0 : i1
      cf.br ^bb1
    }
    %20 = llhd.prb %intg_error : i1
    %21 = llhd.prb %rsp_fifo_error : i1
    %22 = llhd.prb %sramreqfifo_error : i1
    %23 = llhd.prb %reqfifo_error : i1
    %24 = llhd.prb %intg_error_q : i1
    %25 = comb.or %20, %21, %22, %23, %24 : i1
    %a_user = hw.struct_extract %tl_i["a_user"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %instr_type = hw.struct_extract %a_user["instr_type"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %26 = func.call @"prim_mubi_pkg::mubi4_test_invalid"(%instr_type) : (i4) -> i1
    %27 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%instr_type) : (i4) -> i1
    %28 = func.call @"prim_mubi_pkg::mubi4_test_false_loose"(%en_ifetch_i) : (i4) -> i1
    %29 = comb.and %27, %28 : i1
    %30 = comb.or %26, %29, %u_err.err_o, %20 {sv.namehint = "error_det"} : i1
    %31 = llhd.prb %tl_i_int : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %32 = hw.bitcast %100 {sv.namehint = "sramreqfifo_wdata"} : (!hw.struct<mask: i4, woffset: i1>) -> i5
    llhd.drv %sram_addr_rdata, %c0_i12 after %1 : i12
    %33 = hw.bitcast %u_sramreqfifo.rdata_o : (i5) -> !hw.struct<mask: i4, woffset: i1>
    llhd.drv %sram_req_rdata, %33 after %1 : !hw.struct<mask: i4, woffset: i1>
    %a_valid = hw.struct_extract %31["a_valid"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %34 = comb.and %a_valid, %69 {sv.namehint = "a_ack"} : i1
    %d_ready = hw.struct_extract %31["d_ready"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %35 = comb.and %36, %d_ready {sv.namehint = "d_ack"} : i1
    %36 = llhd.prb %d_valid : i1
    %37 = llhd.prb %reqfifo_rvalid : i1
    %38 = llhd.prb %reqfifo_rdata : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
    %39 = llhd.prb %rspfifo_rvalid : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb8
      llhd.drv %d_valid, %false after %1 : i1
      %115 = llhd.prb %reqfifo_rvalid : i1
      cf.cond_br %115, ^bb2, ^bb7
    ^bb2:  // pred: ^bb1
      %116 = llhd.prb %reqfifo_rdata : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
      %error_5 = hw.struct_extract %116["error"] : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
      cf.cond_br %error_5, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %d_valid, %true after %1 : i1
      cf.br ^bb8
    ^bb4:  // pred: ^bb2
      %117 = llhd.prb %reqfifo_rdata : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
      %is_read_6 = hw.struct_extract %117["is_read"] : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
      cf.cond_br %is_read_6, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      %118 = llhd.prb %rspfifo_rvalid : i1
      llhd.drv %d_valid, %118 after %1 : i1
      cf.br ^bb8
    ^bb6:  // pred: ^bb4
      llhd.drv %d_valid, %true after %1 : i1
      cf.br ^bb8
    ^bb7:  // pred: ^bb1
      llhd.drv %d_valid, %false after %1 : i1
      cf.br ^bb8
    ^bb8:  // 4 preds: ^bb3, ^bb5, ^bb6, ^bb7
      llhd.wait (%36, %37, %38, %39 : i1, i1, !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>, i1), ^bb1
    }
    %40 = llhd.prb %d_error : i1
    %41 = llhd.prb %rspfifo_rdata : !hw.struct<data: i32, data_intg: i7, error: i1>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      llhd.drv %d_error, %false after %1 : i1
      %115 = llhd.prb %reqfifo_rvalid : i1
      cf.cond_br %115, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      %116 = llhd.prb %reqfifo_rdata : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
      %is_read_5 = hw.struct_extract %116["is_read"] : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
      cf.cond_br %is_read_5, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %117 = llhd.prb %rspfifo_rdata : !hw.struct<data: i32, data_intg: i7, error: i1>
      %error_6 = hw.struct_extract %117["error"] : !hw.struct<data: i32, data_intg: i7, error: i1>
      %118 = llhd.prb %reqfifo_rdata : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
      %error_7 = hw.struct_extract %118["error"] : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
      %119 = comb.or %error_6, %error_7 : i1
      llhd.drv %d_error, %119 after %1 : i1
      cf.br ^bb6
    ^bb4:  // pred: ^bb2
      %120 = llhd.prb %reqfifo_rdata : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
      %error_8 = hw.struct_extract %120["error"] : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
      llhd.drv %d_error, %error_8 after %1 : i1
      cf.br ^bb6
    ^bb5:  // pred: ^bb1
      llhd.drv %d_error, %false after %1 : i1
      cf.br ^bb6
    ^bb6:  // 3 preds: ^bb3, ^bb4, ^bb5
      llhd.wait (%40, %37, %38, %41 : i1, i1, !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>, !hw.struct<data: i32, data_intg: i7, error: i1>), ^bb1
    }
    %is_read = hw.struct_extract %38["is_read"] : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
    %42 = comb.and %36, %39, %is_read : i1
    llhd.drv %vld_rd_rsp, %42 after %1 : i1
    %instr_type_2 = hw.struct_extract %38["instr_type"] : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
    %43 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%instr_type_2) : (i4) -> i1
    %44 = comb.mux %43, %c0_i32, %c-1_i32 : i32
    llhd.drv %error_blanking_data, %44 after %1 : i32
    %45 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%instr_type_2) : (i4) -> i1
    %46 = llhd.prb %error_instr_integ : i7
    %47 = llhd.prb %error_data_integ : i7
    %48 = comb.mux %45, %46, %47 : i7
    llhd.drv %error_blanking_integ, %48 after %1 : i7
    %49 = llhd.prb %vld_rd_rsp : i1
    %50 = comb.xor %40, %true : i1
    %51 = comb.and %49, %50 : i1
    %data = hw.struct_extract %41["data"] : !hw.struct<data: i32, data_intg: i7, error: i1>
    %52 = llhd.prb %error_blanking_data : i32
    %53 = comb.mux %51, %data, %52 {sv.namehint = "d_data"} : i32
    %error = hw.struct_extract %38["error"] : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
    %54 = llhd.prb %error_blanking_integ : i7
    %data_intg = hw.struct_extract %41["data_intg"] : !hw.struct<data: i32, data_intg: i7, error: i1>
    %55 = comb.mux %49, %data_intg, %c42_i7 : i7
    %56 = comb.mux %error, %54, %55 {sv.namehint = "data_intg"} : i7
    %57 = comb.xor %69, %true : i1
    %58 = comb.and %u_sram_byte.error_o, %a_valid, %57 : i1
    llhd.drv %missed_err_gnt_d, %58 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %115 = llhd.prb %clk_i_0 : i1
      %116 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%9, %10 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %117 = llhd.prb %clk_i_0 : i1
      %118 = comb.xor bin %115, %true : i1
      %119 = comb.and bin %118, %117 : i1
      %120 = llhd.prb %rst_ni_1 : i1
      %121 = comb.xor bin %120, %true : i1
      %122 = comb.and bin %116, %121 : i1
      %123 = comb.or bin %119, %122 : i1
      cf.cond_br %123, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %124 = llhd.prb %rst_ni_1 : i1
      %125 = comb.xor %124, %true : i1
      cf.cond_br %125, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %missed_err_gnt_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %126 = llhd.prb %missed_err_gnt_d : i1
      llhd.drv %missed_err_gnt_q, %126 after %0 : i1
      cf.br ^bb1
    }
    %59 = comb.xor %is_read, %true : i1
    %60 = comb.and %36, %59 : i1
    %61 = comb.xor %60, %true : i1
    %62 = comb.concat %c0_i2, %61 : i2, i1
    %size = hw.struct_extract %38["size"] : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
    %63 = comb.mux %36, %size, %c0_i2 : i2
    %source = hw.struct_extract %38["source"] : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
    %64 = comb.mux %36, %source, %c0_i8 : i8
    %65 = hw.struct_create (%c0_i7, %56) : !hw.struct<rsp_intg: i7, data_intg: i7>
    %66 = comb.and %36, %40 : i1
    %67 = llhd.prb %missed_err_gnt_q : i1
    %68 = comb.or %gnt_i, %67 : i1
    %69 = comb.and %68, %u_reqfifo.wready_o, %u_sramreqfifo.wready_o : i1
    %70 = hw.struct_create (%36, %62, %c0_i3, %63, %64, %false, %53, %65, %66, %69) {sv.namehint = "tl_o_int"} : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %71 = comb.xor %u_sram_byte.error_o, %true : i1
    %72 = comb.and %a_valid, %u_reqfifo.wready_o, %71 : i1
    %a_user_3 = hw.struct_extract %31["a_user"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %instr_type_4 = hw.struct_extract %a_user_3["instr_type"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %a_opcode = hw.struct_extract %31["a_opcode"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %73 = comb.icmp weq %a_opcode, %c0_i3 : i3
    %74 = comb.icmp weq %a_opcode, %c1_i3 : i3
    %75 = comb.or %73, %74 : i1
    %76 = comb.and %a_valid, %75 : i1
    llhd.drv %we_o, %76 after %1 : i1
    %a_address = hw.struct_extract %31["a_address"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %77 = comb.extract %a_address from 2 : (i32) -> i10
    %78 = comb.mux %a_valid, %77, %c0_i10 : i10
    %rsvd = hw.struct_extract %a_user_3["rsvd"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %79 = comb.mux %a_valid, %rsvd, %c0_i5 : i5
    llhd.drv %woffset, %false after %1 : i1
    %80 = llhd.prb %wmask_int : !hw.array<1xi32>
    %81 = llhd.prb %wdata_int : !hw.array<1xi32>
    %82 = llhd.prb %woffset : i1
    %83 = llhd.prb %we_o : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb5
      llhd.drv %wmask_int, %3 after %1 : !hw.array<1xi32>
      llhd.drv %wdata_int, %3 after %1 : !hw.array<1xi32>
      %115 = llhd.prb %tl_i_int : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_valid_5 = hw.struct_extract %115["a_valid"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      cf.cond_br %a_valid_5, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      %i = llhd.sig %c0_i32 : i32
      llhd.drv %i, %c0_i32 after %1 : i32
      cf.br ^bb3
    ^bb3:  // 2 preds: ^bb2, ^bb4
      %116 = llhd.prb %i : i32
      %117 = comb.icmp slt %116, %c4_i32 : i32
      cf.cond_br %117, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %118 = llhd.prb %woffset : i1
      %119 = comb.xor %118, %true : i1
      %120 = comb.extract %118 from 0 : (i1) -> i0
      %121 = comb.mux %119, %120, %c0_i0 : i0
      %122 = llhd.sig.array_get %wmask_int[%121] : <!hw.array<1xi32>>
      %123 = llhd.prb %i : i32
      %124 = comb.extract %123 from 2 : (i32) -> i27
      %125 = comb.icmp eq %124, %c0_i27 : i27
      %126 = comb.extract %123 from 0 : (i32) -> i2
      %127 = comb.concat %126, %c0_i3 : i2, i3
      %128 = comb.mux %125, %127, %c-1_i5 : i5
      %129 = llhd.sig.extract %122 from %128 : <i32> -> <i8>
      %130 = llhd.prb %tl_i_int : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_mask_6 = hw.struct_extract %130["a_mask"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %131 = comb.extract %123 from 4 : (i32) -> i28
      %132 = comb.icmp eq %131, %c0_i28 : i28
      %133 = comb.extract %123 from 0 : (i32) -> i4
      %134 = comb.mux %132, %133, %c-1_i4 : i4
      %135 = comb.shru %a_mask_6, %134 : i4
      %136 = comb.extract %135 from 0 : (i4) -> i1
      %137 = comb.replicate %136 : (i1) -> i8
      llhd.drv %129, %137 after %1 : i8
      %138 = llhd.prb %woffset : i1
      %139 = comb.xor %138, %true : i1
      %140 = comb.extract %138 from 0 : (i1) -> i0
      %141 = comb.mux %139, %140, %c0_i0 : i0
      %142 = llhd.sig.array_get %wdata_int[%141] : <!hw.array<1xi32>>
      %143 = llhd.prb %i : i32
      %144 = comb.extract %143 from 0 : (i32) -> i29
      %145 = comb.concat %144, %c0_i3 : i29, i3
      %146 = comb.extract %143 from 2 : (i32) -> i27
      %147 = comb.icmp eq %146, %c0_i27 : i27
      %148 = comb.extract %143 from 0 : (i32) -> i2
      %149 = comb.concat %148, %c0_i3 : i2, i3
      %150 = comb.mux %147, %149, %c-1_i5 : i5
      %151 = llhd.sig.extract %142 from %150 : <i32> -> <i8>
      %152 = llhd.prb %tl_i_int : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_mask_7 = hw.struct_extract %152["a_mask"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %153 = comb.extract %143 from 4 : (i32) -> i28
      %154 = comb.icmp eq %153, %c0_i28 : i28
      %155 = comb.extract %143 from 0 : (i32) -> i4
      %156 = comb.mux %154, %155, %c-1_i4 : i4
      %157 = comb.shru %a_mask_7, %156 : i4
      %158 = comb.extract %157 from 0 : (i4) -> i1
      %159 = llhd.prb %we_o : i1
      %160 = comb.and %158, %159 : i1
      %a_data = hw.struct_extract %152["a_data"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %161 = comb.shru %a_data, %145 : i32
      %162 = comb.extract %161 from 0 : (i32) -> i8
      %163 = comb.mux %160, %162, %c0_i8 : i8
      llhd.drv %151, %163 after %1 : i8
      %164 = llhd.prb %i : i32
      %165 = comb.add %164, %c1_i32 : i32
      llhd.drv %i, %165 after %1 : i32
      cf.br ^bb3
    ^bb5:  // 2 preds: ^bb1, ^bb3
      llhd.wait (%80, %81, %31, %82, %83 : !hw.array<1xi32>, !hw.array<1xi32>, !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, i1, i1), ^bb1
    }
    %84 = llhd.prb %wmask_intg : !hw.array<1xi7>
    %85 = llhd.prb %wdata_intg : !hw.array<1xi7>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb3
      llhd.drv %wmask_intg, %2 after %1 : !hw.array<1xi7>
      llhd.drv %wdata_intg, %2 after %1 : !hw.array<1xi7>
      %115 = llhd.prb %tl_i_int : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_valid_5 = hw.struct_extract %115["a_valid"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      cf.cond_br %a_valid_5, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %116 = llhd.prb %woffset : i1
      %117 = comb.xor %116, %true : i1
      %118 = comb.extract %116 from 0 : (i1) -> i0
      %119 = comb.mux %117, %118, %c0_i0 : i0
      %120 = llhd.sig.array_get %wmask_intg[%119] : <!hw.array<1xi7>>
      llhd.drv %120, %c-1_i7 after %1 : i7
      %121 = llhd.prb %woffset : i1
      %122 = comb.xor %121, %true : i1
      %123 = comb.extract %121 from 0 : (i1) -> i0
      %124 = comb.mux %122, %123, %c0_i0 : i0
      %125 = llhd.sig.array_get %wdata_intg[%124] : <!hw.array<1xi7>>
      %126 = llhd.prb %tl_i_int : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_user_6 = hw.struct_extract %126["a_user"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %data_intg_7 = hw.struct_extract %a_user_6["data_intg"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
      llhd.drv %125, %data_intg_7 after %1 : i7
      cf.br ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      llhd.wait (%84, %85, %31, %82 : !hw.array<1xi7>, !hw.array<1xi7>, !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, i1), ^bb1
    }
    %86 = llhd.sig.array_get %wmask_combined[%c0_i0] : <!hw.array<1xi39>>
    %87 = hw.array_get %84[%c0_i0] : !hw.array<1xi7>, i0
    %88 = hw.array_get %80[%c0_i0] : !hw.array<1xi32>, i0
    %89 = comb.concat %87, %88 : i7, i32
    llhd.drv %86, %89 after %1 : i39
    %90 = llhd.sig.array_get %wdata_combined[%c0_i0] : <!hw.array<1xi39>>
    %91 = hw.array_get %85[%c0_i0] : !hw.array<1xi7>, i0
    %92 = hw.array_get %81[%c0_i0] : !hw.array<1xi32>, i0
    %93 = comb.concat %91, %92 : i7, i32
    llhd.drv %90, %93 after %1 : i39
    %94 = llhd.prb %wmask_combined : !hw.array<1xi39>
    %95 = hw.bitcast %94 : (!hw.array<1xi39>) -> i39
    %96 = llhd.prb %wdata_combined : !hw.array<1xi39>
    %97 = hw.bitcast %96 : (!hw.array<1xi39>) -> i39
    %98 = comb.icmp eq %a_opcode, %c-4_i3 : i3
    %a_size = hw.struct_extract %31["a_size"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_source = hw.struct_extract %31["a_source"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %99 = hw.struct_create (%98, %u_sram_byte.error_o, %instr_type_4, %a_size, %a_source) {sv.namehint = "reqfifo_wdata"} : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
    %a_mask = hw.struct_extract %31["a_mask"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %100 = hw.struct_create (%a_mask, %82) {sv.namehint = "sram_req_wdata"} : !hw.struct<mask: i4, woffset: i1>
    %101 = comb.xor %83, %true : i1
    %102 = comb.and %72, %gnt_i, %101 {sv.namehint = "sramreqfifo_wvalid"} : i1
    %103 = comb.and %rvalid_i, %37 {sv.namehint = "rspfifo_wvalid"} : i1
    %104 = hw.bitcast %rdata_i : (i39) -> !hw.array<1xi39>
    llhd.drv %rdata_reshaped, %104 after %1 : !hw.array<1xi39>
    %105 = llhd.prb %rdata_tlword : i39
    %106 = llhd.prb %sram_req_rdata : !hw.struct<mask: i4, woffset: i1>
    %107 = llhd.prb %rdata_reshaped : !hw.array<1xi39>
    %108 = llhd.prb %sram_addr_rdata : i12
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb3
      llhd.drv %rdata_tlword, %c180388626432_i39 after %1 : i39
      %115 = llhd.prb %sram_req_rdata : !hw.struct<mask: i4, woffset: i1>
      %mask = hw.struct_extract %115["mask"] : !hw.struct<mask: i4, woffset: i1>
      %116 = comb.icmp ne %mask, %c0_i4 : i4
      cf.cond_br %116, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %117 = llhd.prb %rdata_reshaped : !hw.array<1xi39>
      %118 = llhd.prb %sram_req_rdata : !hw.struct<mask: i4, woffset: i1>
      %woffset_5 = hw.struct_extract %118["woffset"] : !hw.struct<mask: i4, woffset: i1>
      %119 = comb.xor %woffset_5, %true : i1
      %120 = comb.extract %woffset_5 from 0 : (i1) -> i0
      %121 = comb.mux %119, %120, %c0_i0 : i0
      %122 = hw.array_get %117[%121] : !hw.array<1xi39>, i0
      llhd.drv %rdata_tlword, %122 after %1 : i39
      cf.br ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      llhd.wait (%105, %106, %107, %108 : i39, !hw.struct<mask: i4, woffset: i1>, !hw.array<1xi39>, i12), ^bb1
    }
    %109 = comb.extract %105 from 0 : (i39) -> i32
    %110 = comb.extract %105 from 32 : (i39) -> i7
    %111 = comb.extract %rerror_i from 1 : (i2) -> i1
    %112 = hw.struct_create (%109, %110, %111) {sv.namehint = "rspfifo_wdata"} : !hw.struct<data: i32, data_intg: i7, error: i1>
    %113 = comb.xor %error, %true : i1
    %114 = comb.and %is_read, %113, %35 {sv.namehint = "rspfifo_rready"} : i1
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    hw.output %u_rsp_gen.tl_o, %72, %instr_type_4, %83, %78, %97, %95, %25, %79, %u_sram_byte.compound_txn_in_progress_o, %19 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, i1, i4, i1, i10, i39, i39, i1, i5, i1, i1
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
  hw.module private @tlul_rsp_intg_gen_31(in %tl_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i51 = hw.constant 0 : i51
    %c0_i7 = hw.constant 0 : i7
    %1 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %tl_i_0 = llhd.sig name "tl_i" %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %tl_o = llhd.sig %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %rsp_intg = llhd.sig %c0_i7 : i7
    %data_intg = llhd.sig %c0_i7 : i7
    %2 = hw.bitcast %6 : (!hw.struct<opcode: i3, size: i2, error: i1>) -> i6
    %3 = comb.concat %c0_i51, %2 : i51, i6
    %gen_rsp_intg.u_rsp_gen.data_o = hw.instance "gen_rsp_intg.u_rsp_gen" @prim_secded_inv_64_57_enc(data_i: %3: i57) -> (data_o: i64)
    %4 = comb.extract %gen_rsp_intg.u_rsp_gen.data_o from 57 : (i64) -> i7
    llhd.drv %rsp_intg, %4 after %0 : i7
    %5 = llhd.prb %tl_i_0 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %6 = func.call @"tlul_pkg::extract_d2h_rsp_intg"(%5) {sv.namehint = "gen_rsp_intg.rsp"} : (!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> !hw.struct<opcode: i3, size: i2, error: i1>
    %d_user = hw.struct_extract %5["d_user"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %data_intg_1 = hw.struct_extract %d_user["data_intg"] : !hw.struct<rsp_intg: i7, data_intg: i7>
    llhd.drv %data_intg, %data_intg_1 after %0 : i7
    %7 = llhd.prb %tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %8 = llhd.prb %rsp_intg : i7
    %9 = llhd.prb %data_intg : i7
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %10 = llhd.prb %tl_i_0 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      llhd.drv %tl_o, %10 after %0 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      %11 = llhd.sig.struct_extract %tl_o["d_user"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
      %12 = llhd.sig.struct_extract %11["rsp_intg"] : <!hw.struct<rsp_intg: i7, data_intg: i7>>
      %13 = llhd.prb %rsp_intg : i7
      llhd.drv %12, %13 after %0 : i7
      %14 = llhd.sig.struct_extract %11["data_intg"] : <!hw.struct<rsp_intg: i7, data_intg: i7>>
      %15 = llhd.prb %data_intg : i7
      llhd.drv %14, %15 after %0 : i7
      llhd.wait (%5, %7, %8, %9 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, i7, i7), ^bb1
    }
    llhd.drv %tl_i_0, %tl_i after %0 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    hw.output %7 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
  }
  hw.module private @tlul_sram_byte(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_sram_o : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, in %tl_sram_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %error_i : i1, out error_o : i1, out alert_o : i1, out compound_txn_in_progress_o : i1, in %readback_en_i : i4, in %wr_collision_i : i1, in %write_pending_i : i1) {
    %c0_i5 = hw.constant 0 : i5
    %c0_i28 = hw.constant 0 : i28
    %c-1_i5 = hw.constant -1 : i5
    %c0_i27 = hw.constant 0 : i27
    %c-1_i4 = hw.constant -1 : i4
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [0 : i5, 0 : i4, 0 : i7, 0 : i7] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %c0_i7 = hw.constant 0 : i7
    %3 = hw.aggregate_constant [0 : i2, 0 : i2, false] : !hw.struct<pending_txn_cnt: i2, a_size: i2, size_fifo_rdy: i1>
    %4 = hw.aggregate_constant [0 : i7, 0 : i7] : !hw.struct<a_user_cmd_intg: i7, a_user_data_intg: i7>
    %5 = hw.aggregate_constant [0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, 0 : i5, 0 : i4] : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
    %c0_i8 = hw.constant 0 : i8
    %c0_i4 = hw.constant 0 : i4
    %6 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %7 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %c0_i23 = hw.constant 0 : i23
    %c0_i32 = hw.constant 0 : i32
    %c0_i2 = hw.constant 0 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c-4_i3 = hw.constant -4 : i3
    %c4_i32 = hw.constant 4 : i32
    %c-64_i8 = hw.constant -64 : i8
    %c-1_i8 = hw.constant -1 : i8
    %c-25_i8 = hw.constant -25 : i8
    %c48_i8 = hw.constant 48 : i8
    %c15_i8 = hw.constant 15 : i8
    %c1_i32 = hw.constant 1 : i32
    %c6_i4 = hw.constant 6 : i4
    %c87_i8 = hw.constant 87 : i8
    %c-15_i8 = hw.constant -15 : i8
    %c1_i2 = hw.constant 1 : i2
    %c-84_i8 = hw.constant -84 : i8
    %c-103_i8 = hw.constant -103 : i8
    %c2_i8 = hw.constant 2 : i8
    %c-7_i4 = hw.constant -7 : i4
    %true = hw.constant true
    %c1_i3 = hw.constant 1 : i3
    %c0_i3 = hw.constant 0 : i3
    %c126_i8 = hw.constant 126 : i8
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %8 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %9 = llhd.prb %rst_ni_1 : i1
    %tl_i_2 = llhd.sig name "tl_i" %7 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %tl_o = llhd.sig %6 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %tl_sram_o = llhd.sig %7 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %tl_sram_i_3 = llhd.sig name "tl_sram_i" %6 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %error_i_4 = llhd.sig name "error_i" %false : i1
    %readback_en_i_5 = llhd.sig name "readback_en_i" %c0_i4 : i4
    %gen_integ_handling.stall_host = llhd.sig %false : i1
    %gen_integ_handling.wait_phase = llhd.sig %false : i1
    %gen_integ_handling.rd_phase = llhd.sig %false : i1
    %gen_integ_handling.rd_wait = llhd.sig %false : i1
    %gen_integ_handling.wr_phase = llhd.sig %false : i1
    %gen_integ_handling.rdback_phase = llhd.sig %false : i1
    %gen_integ_handling.rdback_phase_wrreadback = llhd.sig %false : i1
    %gen_integ_handling.rdback_wait = llhd.sig %false : i1
    %gen_integ_handling.readback_err = llhd.sig %false : i1
    %gen_integ_handling.state_d = llhd.sig %c0_i8 : i8
    %gen_integ_handling.state_q = llhd.sig %c0_i8 : i8
    %gen_integ_handling.a_ack = llhd.sig %false : i1
    %gen_integ_handling.d_ack = llhd.sig %false : i1
    %gen_integ_handling.sram_a_ack = llhd.sig %false : i1
    %gen_integ_handling.sram_d_ack = llhd.sig %false : i1
    %gen_integ_handling.wr_txn = llhd.sig %false : i1
    %gen_integ_handling.byte_wr_txn = llhd.sig %false : i1
    %gen_integ_handling.byte_req_ack = llhd.sig %false : i1
    %gen_integ_handling.hold_tx_data = llhd.sig %false : i1
    %gen_integ_handling.held_data = llhd.sig %5 : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
    %gen_integ_handling.held_intg = llhd.sig %4 : !hw.struct<a_user_cmd_intg: i7, a_user_data_intg: i7>
    %gen_integ_handling.sync_fifo_a_size_outputs = llhd.sig %3 : !hw.struct<pending_txn_cnt: i2, a_size: i2, size_fifo_rdy: i1>
    %gen_integ_handling.sync_fifo_a_size_shadow_outputs = llhd.sig %3 : !hw.struct<pending_txn_cnt: i2, a_size: i2, size_fifo_rdy: i1>
    %gen_integ_handling.rdback_chk_ok = llhd.sig %false : i1
    %gen_integ_handling.rdback_check_q = llhd.sig %c0_i4 : i4
    %gen_integ_handling.rdback_check_d = llhd.sig %c0_i4 : i4
    %gen_integ_handling.rdback_en_q = llhd.sig %c0_i4 : i4
    %gen_integ_handling.rdback_en_d = llhd.sig %c0_i4 : i4
    %gen_integ_handling.rdback_data_exp_q = llhd.sig %c0_i32 : i32
    %gen_integ_handling.rdback_data_exp_d = llhd.sig %c0_i32 : i32
    %gen_integ_handling.rdback_data_exp_intg_q = llhd.sig %c0_i7 : i7
    %gen_integ_handling.rdback_data_exp_intg_d = llhd.sig %c0_i7 : i7
    %gen_integ_handling.fifo_rdy_data = llhd.sig %false : i1
    %gen_integ_handling.txn_data_intg_wr = llhd.sig %false : i1
    %gen_integ_handling.enable_intg_check_cmp_q = llhd.sig %false : i1
    %gen_integ_handling.rsp_data = llhd.sig %c0_i32 : i32
    %gen_integ_handling.combined_data = llhd.sig %c0_i32 : i32
    %gen_integ_handling.data_intg = llhd.sig %c0_i7 : i7
    %gen_integ_handling.combined_user = llhd.sig %2 : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %gen_integ_handling.gen_readback_logic.u_rdback_chk_ok_buf.out_o = hw.instance "gen_integ_handling.gen_readback_logic.u_rdback_chk_ok_buf" @prim_sec_anchor_buf_6(in_i: %51: i1) -> (out_o: i1)
    llhd.drv %gen_integ_handling.rdback_chk_ok, %gen_integ_handling.gen_readback_logic.u_rdback_chk_ok_buf.out_o after %1 : i1
    %10 = llhd.prb %gen_integ_handling.rdback_check_d : i4
    %gen_integ_handling.gen_readback_logic.u_rdback_check_flop.q_o = hw.instance "gen_integ_handling.gen_readback_logic.u_rdback_check_flop" @prim_flop_16(clk_i: %8: i1, rst_ni: %9: i1, d_i: %10: i4) -> (q_o: i4)
    llhd.drv %gen_integ_handling.rdback_check_q, %gen_integ_handling.gen_readback_logic.u_rdback_check_flop.q_o after %1 : i4
    %11 = llhd.prb %gen_integ_handling.rdback_en_d : i4
    %gen_integ_handling.gen_readback_logic.u_rdback_en_flop.q_o = hw.instance "gen_integ_handling.gen_readback_logic.u_rdback_en_flop" @prim_flop_16(clk_i: %8: i1, rst_ni: %9: i1, d_i: %11: i4) -> (q_o: i4)
    llhd.drv %gen_integ_handling.rdback_en_q, %gen_integ_handling.gen_readback_logic.u_rdback_en_flop.q_o after %1 : i4
    %12 = llhd.prb %gen_integ_handling.rdback_data_exp_d : i32
    %gen_integ_handling.gen_readback_logic.u_rdback_data_exp.q_o = hw.instance "gen_integ_handling.gen_readback_logic.u_rdback_data_exp" @prim_flop_35(clk_i: %8: i1, rst_ni: %9: i1, d_i: %12: i32) -> (q_o: i32)
    llhd.drv %gen_integ_handling.rdback_data_exp_q, %gen_integ_handling.gen_readback_logic.u_rdback_data_exp.q_o after %1 : i32
    %13 = llhd.prb %gen_integ_handling.rdback_data_exp_intg_d : i7
    %gen_integ_handling.gen_readback_logic.u_rdback_data_exp_intg.q_o = hw.instance "gen_integ_handling.gen_readback_logic.u_rdback_data_exp_intg" @prim_flop_36(clk_i: %8: i1, rst_ni: %9: i1, d_i: %13: i7) -> (q_o: i7)
    llhd.drv %gen_integ_handling.rdback_data_exp_intg_q, %gen_integ_handling.gen_readback_logic.u_rdback_data_exp_intg.q_o after %1 : i7
    %14 = llhd.prb %gen_integ_handling.txn_data_intg_wr : i1
    %15 = llhd.prb %gen_integ_handling.sram_a_ack : i1
    %16 = hw.bitcast %73 : (!hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>) -> i93
    %gen_integ_handling.u_sync_fifo_data.wready_o, %gen_integ_handling.u_sync_fifo_data.rvalid_o, %gen_integ_handling.u_sync_fifo_data.rdata_o, %gen_integ_handling.u_sync_fifo_data.full_o, %gen_integ_handling.u_sync_fifo_data.depth_o, %gen_integ_handling.u_sync_fifo_data.err_o = hw.instance "gen_integ_handling.u_sync_fifo_data" @prim_fifo_sync_37(clk_i: %8: i1, rst_ni: %9: i1, clr_i: %false: i1, wvalid_i: %14: i1, wdata_i: %16: i93, rready_i: %15: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i93, full_o: i1, depth_o: i1, err_o: i1)
    llhd.drv %gen_integ_handling.fifo_rdy_data, %gen_integ_handling.u_sync_fifo_data.wready_o after %1 : i1
    %17 = hw.bitcast %gen_integ_handling.u_sync_fifo_data.rdata_o : (i93) -> !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
    llhd.drv %gen_integ_handling.held_data, %17 after %1 : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
    %gen_integ_handling.u_sync_fifo_intg_prim_buf.out_o = hw.instance "gen_integ_handling.u_sync_fifo_intg_prim_buf" @prim_buf_23(in_i: %76: i2) -> (out_o: i2) {sv.namehint = "gen_integ_handling.buf_sync_fifo_intg_out"}
    %18 = hw.bitcast %74 : (!hw.struct<a_user_cmd_intg: i7, a_user_data_intg: i7>) -> i14
    %gen_integ_handling.u_sync_fifo_intg.wready_o, %gen_integ_handling.u_sync_fifo_intg.rvalid_o, %gen_integ_handling.u_sync_fifo_intg.rdata_o, %gen_integ_handling.u_sync_fifo_intg.full_o, %gen_integ_handling.u_sync_fifo_intg.depth_o, %gen_integ_handling.u_sync_fifo_intg.err_o = hw.instance "gen_integ_handling.u_sync_fifo_intg" @prim_fifo_sync_38(clk_i: %8: i1, rst_ni: %9: i1, clr_i: %false: i1, wvalid_i: %77: i1, wdata_i: %18: i14, rready_i: %78: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i14, full_o: i1, depth_o: i1, err_o: i1) {sv.namehint = "gen_integ_handling.fifo_rdy_intg"}
    %19 = hw.bitcast %gen_integ_handling.u_sync_fifo_intg.rdata_o : (i14) -> !hw.struct<a_user_cmd_intg: i7, a_user_data_intg: i7>
    llhd.drv %gen_integ_handling.held_intg, %19 after %1 : !hw.struct<a_user_cmd_intg: i7, a_user_data_intg: i7>
    %gen_integ_handling.u_cmd_intg_chk.err_o = hw.instance "gen_integ_handling.u_cmd_intg_chk" @tlul_cmd_intg_chk(tl_i: %82: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> (err_o: i1) {sv.namehint = "gen_integ_handling.tl_i_fifo_intg_err"}
    %20 = llhd.prb %gen_integ_handling.combined_data : i32
    %gen_integ_handling.u_tlul_data_integ_enc.data_intg_o = hw.instance "gen_integ_handling.u_tlul_data_integ_enc" @tlul_data_integ_enc(data_i: %20: i32) -> (data_intg_o: i39)
    %21 = comb.extract %gen_integ_handling.u_tlul_data_integ_enc.data_intg_o from 32 : (i39) -> i7
    llhd.drv %gen_integ_handling.data_intg, %21 after %1 : i7
    %22 = llhd.prb %gen_integ_handling.a_ack : i1
    %23 = llhd.sig.struct_extract %gen_integ_handling.sync_fifo_a_size_outputs["size_fifo_rdy"] : <!hw.struct<pending_txn_cnt: i2, a_size: i2, size_fifo_rdy: i1>>
    %24 = llhd.prb %tl_i_2 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_size = hw.struct_extract %24["a_size"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %25 = llhd.prb %gen_integ_handling.d_ack : i1
    %26 = llhd.sig.struct_extract %gen_integ_handling.sync_fifo_a_size_outputs["a_size"] : <!hw.struct<pending_txn_cnt: i2, a_size: i2, size_fifo_rdy: i1>>
    %27 = llhd.sig.struct_extract %gen_integ_handling.sync_fifo_a_size_outputs["pending_txn_cnt"] : <!hw.struct<pending_txn_cnt: i2, a_size: i2, size_fifo_rdy: i1>>
    %gen_integ_handling.u_sync_fifo_a_size.wready_o, %gen_integ_handling.u_sync_fifo_a_size.rvalid_o, %gen_integ_handling.u_sync_fifo_a_size.rdata_o, %gen_integ_handling.u_sync_fifo_a_size.full_o, %gen_integ_handling.u_sync_fifo_a_size.depth_o, %gen_integ_handling.u_sync_fifo_a_size.err_o = hw.instance "gen_integ_handling.u_sync_fifo_a_size" @prim_fifo_sync_39(clk_i: %8: i1, rst_ni: %9: i1, clr_i: %false: i1, wvalid_i: %22: i1, wdata_i: %a_size: i2, rready_i: %25: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i2, full_o: i1, depth_o: i2, err_o: i1)
    llhd.drv %23, %gen_integ_handling.u_sync_fifo_a_size.wready_o after %1 : i1
    llhd.drv %26, %gen_integ_handling.u_sync_fifo_a_size.rdata_o after %1 : i2
    llhd.drv %27, %gen_integ_handling.u_sync_fifo_a_size.depth_o after %1 : i2
    %gen_integ_handling.u_sync_fifo_a_size_prim_buf.out_o = hw.instance "gen_integ_handling.u_sync_fifo_a_size_prim_buf" @prim_buf_13(in_i: %90: i4) -> (out_o: i4) {sv.namehint = "gen_integ_handling.buf_sync_fifo_a_size_out"}
    %28 = llhd.sig.struct_extract %gen_integ_handling.sync_fifo_a_size_shadow_outputs["size_fifo_rdy"] : <!hw.struct<pending_txn_cnt: i2, a_size: i2, size_fifo_rdy: i1>>
    %29 = llhd.sig.struct_extract %gen_integ_handling.sync_fifo_a_size_shadow_outputs["a_size"] : <!hw.struct<pending_txn_cnt: i2, a_size: i2, size_fifo_rdy: i1>>
    %30 = llhd.sig.struct_extract %gen_integ_handling.sync_fifo_a_size_shadow_outputs["pending_txn_cnt"] : <!hw.struct<pending_txn_cnt: i2, a_size: i2, size_fifo_rdy: i1>>
    %gen_integ_handling.u_sync_fifo_a_size_shadow.wready_o, %gen_integ_handling.u_sync_fifo_a_size_shadow.rvalid_o, %gen_integ_handling.u_sync_fifo_a_size_shadow.rdata_o, %gen_integ_handling.u_sync_fifo_a_size_shadow.full_o, %gen_integ_handling.u_sync_fifo_a_size_shadow.depth_o, %gen_integ_handling.u_sync_fifo_a_size_shadow.err_o = hw.instance "gen_integ_handling.u_sync_fifo_a_size_shadow" @prim_fifo_sync_39(clk_i: %8: i1, rst_ni: %9: i1, clr_i: %false: i1, wvalid_i: %91: i1, wdata_i: %92: i2, rready_i: %93: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i2, full_o: i1, depth_o: i2, err_o: i1)
    llhd.drv %28, %gen_integ_handling.u_sync_fifo_a_size_shadow.wready_o after %1 : i1
    llhd.drv %29, %gen_integ_handling.u_sync_fifo_a_size_shadow.rdata_o after %1 : i2
    llhd.drv %30, %gen_integ_handling.u_sync_fifo_a_size_shadow.depth_o after %1 : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %99 = llhd.prb %clk_i_0 : i1
      %100 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%8, %9 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %101 = llhd.prb %clk_i_0 : i1
      %102 = comb.xor bin %99, %true : i1
      %103 = comb.and bin %102, %101 : i1
      %104 = llhd.prb %rst_ni_1 : i1
      %105 = comb.xor bin %104, %true : i1
      %106 = comb.and bin %100, %105 : i1
      %107 = comb.or bin %103, %106 : i1
      cf.cond_br %107, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %108 = llhd.prb %rst_ni_1 : i1
      %109 = comb.xor %108, %true : i1
      cf.cond_br %109, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_integ_handling.state_q, %c126_i8 after %0 : i8
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %110 = llhd.prb %gen_integ_handling.state_d : i8
      llhd.drv %gen_integ_handling.state_q, %110 after %0 : i8
      cf.br ^bb1
    }
    %a_valid = hw.struct_extract %24["a_valid"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %31 = llhd.prb %tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %a_ready = hw.struct_extract %31["a_ready"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %32 = comb.and %a_valid, %a_ready : i1
    llhd.drv %gen_integ_handling.a_ack, %32 after %1 : i1
    %d_valid = hw.struct_extract %31["d_valid"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %d_ready = hw.struct_extract %24["d_ready"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %33 = comb.and %d_valid, %d_ready : i1
    llhd.drv %gen_integ_handling.d_ack, %33 after %1 : i1
    %34 = llhd.prb %tl_sram_o : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_valid_6 = hw.struct_extract %34["a_valid"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %35 = llhd.prb %tl_sram_i_3 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %a_ready_7 = hw.struct_extract %35["a_ready"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %36 = comb.and %a_valid_6, %a_ready_7 : i1
    llhd.drv %gen_integ_handling.sram_a_ack, %36 after %1 : i1
    %d_valid_8 = hw.struct_extract %35["d_valid"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %d_ready_9 = hw.struct_extract %34["d_ready"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %37 = comb.and %d_valid_8, %d_ready_9 : i1
    llhd.drv %gen_integ_handling.sram_d_ack, %37 after %1 : i1
    %a_opcode = hw.struct_extract %24["a_opcode"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %38 = comb.icmp eq %a_opcode, %c0_i3 : i3
    %39 = comb.icmp eq %a_opcode, %c1_i3 : i3
    %40 = comb.or %38, %39 : i1
    llhd.drv %gen_integ_handling.wr_txn, %40 after %1 : i1
    %41 = llhd.prb %gen_integ_handling.byte_wr_txn : i1
    %42 = llhd.prb %error_i_4 : i1
    %43 = comb.xor %42, %true : i1
    %44 = comb.and %41, %22, %43 : i1
    llhd.drv %gen_integ_handling.byte_req_ack, %44 after %1 : i1
    %a_mask = hw.struct_extract %24["a_mask"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %45 = comb.icmp ne %a_mask, %c-1_i4 : i4
    %46 = llhd.prb %gen_integ_handling.wr_txn : i1
    %47 = comb.and %a_valid, %45, %46 : i1
    llhd.drv %gen_integ_handling.byte_wr_txn, %47 after %1 : i1
    %48 = llhd.prb %gen_integ_handling.readback_err : i1
    %49 = comb.or %48, %97, %80, %84 : i1
    %50 = llhd.prb %gen_integ_handling.rdback_data_exp_q : i32
    %d_data = hw.struct_extract %35["d_data"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %51 = comb.icmp eq %50, %d_data {sv.namehint = "gen_integ_handling.gen_readback_logic.rdback_chk_ok_unbuf"} : i32
    %52 = llhd.prb %gen_integ_handling.rd_wait : i1
    %53 = llhd.prb %gen_integ_handling.wait_phase : i1
    %54 = llhd.prb %gen_integ_handling.stall_host : i1
    %55 = llhd.prb %gen_integ_handling.wr_phase : i1
    %56 = llhd.prb %gen_integ_handling.rd_phase : i1
    %57 = llhd.prb %gen_integ_handling.rdback_phase : i1
    %58 = llhd.prb %gen_integ_handling.rdback_phase_wrreadback : i1
    %59 = llhd.prb %gen_integ_handling.rdback_wait : i1
    %60 = llhd.prb %gen_integ_handling.state_q : i8
    %61 = llhd.prb %gen_integ_handling.state_d : i8
    %62 = llhd.prb %gen_integ_handling.hold_tx_data : i1
    %63 = llhd.prb %gen_integ_handling.rdback_check_q : i4
    %64 = llhd.prb %gen_integ_handling.rdback_en_q : i4
    %65 = llhd.prb %gen_integ_handling.rdback_data_exp_intg_q : i7
    %66 = llhd.prb %gen_integ_handling.rdback_chk_ok : i1
    %67 = llhd.prb %gen_integ_handling.byte_req_ack : i1
    %68 = llhd.prb %readback_en_i_5 : i4
    %69 = llhd.prb %gen_integ_handling.sync_fifo_a_size_outputs : !hw.struct<pending_txn_cnt: i2, a_size: i2, size_fifo_rdy: i1>
    %70 = llhd.prb %gen_integ_handling.sram_d_ack : i1
    %71 = llhd.prb %gen_integ_handling.held_data : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
    %72 = llhd.prb %gen_integ_handling.held_intg : !hw.struct<a_user_cmd_intg: i7, a_user_data_intg: i7>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb47
      llhd.drv %gen_integ_handling.rd_wait, %false after %1 : i1
      llhd.drv %gen_integ_handling.wait_phase, %false after %1 : i1
      llhd.drv %gen_integ_handling.stall_host, %false after %1 : i1
      llhd.drv %gen_integ_handling.wr_phase, %false after %1 : i1
      llhd.drv %gen_integ_handling.rd_phase, %false after %1 : i1
      llhd.drv %gen_integ_handling.rdback_phase, %false after %1 : i1
      llhd.drv %gen_integ_handling.rdback_phase_wrreadback, %false after %1 : i1
      llhd.drv %gen_integ_handling.rdback_wait, %false after %1 : i1
      %99 = llhd.prb %gen_integ_handling.state_q : i8
      llhd.drv %gen_integ_handling.state_d, %99 after %1 : i8
      llhd.drv %gen_integ_handling.hold_tx_data, %false after %1 : i1
      llhd.drv %gen_integ_handling.readback_err, %false after %1 : i1
      %100 = llhd.prb %gen_integ_handling.rdback_check_q : i4
      llhd.drv %gen_integ_handling.rdback_check_d, %100 after %1 : i4
      %101 = llhd.prb %gen_integ_handling.rdback_en_q : i4
      llhd.drv %gen_integ_handling.rdback_en_d, %101 after %1 : i4
      %102 = llhd.prb %gen_integ_handling.rdback_data_exp_q : i32
      llhd.drv %gen_integ_handling.rdback_data_exp_d, %102 after %1 : i32
      %103 = llhd.prb %gen_integ_handling.rdback_data_exp_intg_q : i7
      llhd.drv %gen_integ_handling.rdback_data_exp_intg_d, %103 after %1 : i7
      %104 = llhd.prb %gen_integ_handling.state_q : i8
      %105 = comb.icmp ceq %104, %c126_i8 : i8
      cf.cond_br %105, ^bb2, ^bb12
    ^bb2:  // pred: ^bb1
      %106 = llhd.prb %gen_integ_handling.rdback_en_q : i4
      %107 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%106) : (i4) -> i1
      %108 = llhd.prb %gen_integ_handling.rdback_check_q : i4
      %109 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%108) : (i4) -> i1
      %110 = comb.and %107, %109 : i1
      cf.cond_br %110, ^bb3, ^bb5
    ^bb3:  // pred: ^bb2
      llhd.drv %gen_integ_handling.rdback_wait, %true after %1 : i1
      llhd.drv %gen_integ_handling.rdback_check_d, %c-7_i4 after %1 : i4
      %111 = llhd.prb %gen_integ_handling.rdback_chk_ok : i1
      %112 = comb.xor %111, %true : i1
      cf.cond_br %112, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_integ_handling.readback_err, %true after %1 : i1
      cf.br ^bb5
    ^bb5:  // 3 preds: ^bb2, ^bb3, ^bb4
      %113 = llhd.prb %gen_integ_handling.byte_wr_txn : i1
      cf.cond_br %113, ^bb6, ^bb8
    ^bb6:  // pred: ^bb5
      llhd.drv %gen_integ_handling.rd_phase, %true after %1 : i1
      %114 = llhd.prb %gen_integ_handling.byte_req_ack : i1
      cf.cond_br %114, ^bb7, ^bb10
    ^bb7:  // pred: ^bb6
      llhd.drv %gen_integ_handling.state_d, %c2_i8 after %1 : i8
      cf.br ^bb10
    ^bb8:  // pred: ^bb5
      %115 = llhd.prb %gen_integ_handling.a_ack : i1
      %116 = llhd.prb %gen_integ_handling.rdback_en_q : i4
      %117 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%116) : (i4) -> i1
      %118 = llhd.prb %error_i_4 : i1
      %119 = comb.xor %118, %true : i1
      %120 = comb.and %115, %117, %119 : i1
      cf.cond_br %120, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      llhd.drv %gen_integ_handling.hold_tx_data, %true after %1 : i1
      %121 = llhd.prb %gen_integ_handling.wr_txn : i1
      %122 = comb.mux %121, %c-103_i8, %c-84_i8 : i8
      llhd.drv %gen_integ_handling.state_d, %122 after %1 : i8
      cf.br ^bb10
    ^bb10:  // 4 preds: ^bb6, ^bb7, ^bb8, ^bb9
      %123 = llhd.prb %tl_sram_o : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_valid_17 = hw.struct_extract %123["a_valid"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %124 = comb.xor %a_valid_17, %true : i1
      %125 = llhd.prb %tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      %d_valid_18 = hw.struct_extract %125["d_valid"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      %126 = comb.xor %d_valid_18, %true : i1
      %127 = llhd.prb %gen_integ_handling.rdback_check_q : i4
      %128 = func.call @"prim_mubi_pkg::mubi4_test_false_strict"(%127) : (i4) -> i1
      %129 = comb.and %124, %126, %128 : i1
      cf.cond_br %129, ^bb11, ^bb47
    ^bb11:  // pred: ^bb10
      %130 = llhd.prb %readback_en_i_5 : i4
      llhd.drv %gen_integ_handling.rdback_en_d, %130 after %1 : i4
      cf.br ^bb47
    ^bb12:  // pred: ^bb1
      %131 = comb.icmp ceq %104, %c2_i8 : i8
      cf.cond_br %131, ^bb13, ^bb16
    ^bb13:  // pred: ^bb12
      llhd.drv %gen_integ_handling.rd_phase, %true after %1 : i1
      llhd.drv %gen_integ_handling.stall_host, %true after %1 : i1
      %132 = llhd.prb %gen_integ_handling.sync_fifo_a_size_outputs : !hw.struct<pending_txn_cnt: i2, a_size: i2, size_fifo_rdy: i1>
      %pending_txn_cnt = hw.struct_extract %132["pending_txn_cnt"] : !hw.struct<pending_txn_cnt: i2, a_size: i2, size_fifo_rdy: i1>
      %133 = comb.icmp eq %pending_txn_cnt, %c1_i2 : i2
      cf.cond_br %133, ^bb14, ^bb47
    ^bb14:  // pred: ^bb13
      llhd.drv %gen_integ_handling.rd_wait, %true after %1 : i1
      %134 = llhd.prb %gen_integ_handling.sram_d_ack : i1
      cf.cond_br %134, ^bb15, ^bb47
    ^bb15:  // pred: ^bb14
      llhd.drv %gen_integ_handling.state_d, %c-15_i8 after %1 : i8
      cf.br ^bb47
    ^bb16:  // pred: ^bb12
      %135 = comb.icmp ceq %104, %c-15_i8 : i8
      cf.cond_br %135, ^bb17, ^bb19
    ^bb17:  // pred: ^bb16
      llhd.drv %gen_integ_handling.stall_host, %true after %1 : i1
      llhd.drv %gen_integ_handling.wr_phase, %true after %1 : i1
      %136 = llhd.prb %gen_integ_handling.sram_a_ack : i1
      cf.cond_br %136, ^bb18, ^bb47
    ^bb18:  // pred: ^bb17
      %137 = llhd.prb %gen_integ_handling.rdback_en_q : i4
      %138 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%137) : (i4) -> i1
      %139 = comb.mux %138, %c87_i8, %c126_i8 : i8
      llhd.drv %gen_integ_handling.state_d, %139 after %1 : i8
      %140 = llhd.prb %gen_integ_handling.rdback_en_q : i4
      %141 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%140) : (i4) -> i1
      %142 = comb.mux %141, %c6_i4, %c-7_i4 : i4
      llhd.drv %gen_integ_handling.rdback_check_d, %142 after %1 : i4
      %143 = llhd.prb %tl_sram_o : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_data_19 = hw.struct_extract %143["a_data"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      llhd.drv %gen_integ_handling.rdback_data_exp_d, %a_data_19 after %1 : i32
      %144 = llhd.prb %tl_sram_o : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_user_20 = hw.struct_extract %144["a_user"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %data_intg_21 = hw.struct_extract %a_user_20["data_intg"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
      llhd.drv %gen_integ_handling.rdback_data_exp_intg_d, %data_intg_21 after %1 : i7
      cf.br ^bb47
    ^bb19:  // pred: ^bb16
      %145 = comb.icmp ceq %104, %c-103_i8 : i8
      cf.cond_br %145, ^bb20, ^bb24
    ^bb20:  // pred: ^bb19
      llhd.drv %gen_integ_handling.stall_host, %true after %1 : i1
      %146 = llhd.prb %gen_integ_handling.sync_fifo_a_size_outputs : !hw.struct<pending_txn_cnt: i2, a_size: i2, size_fifo_rdy: i1>
      %pending_txn_cnt_22 = hw.struct_extract %146["pending_txn_cnt"] : !hw.struct<pending_txn_cnt: i2, a_size: i2, size_fifo_rdy: i1>
      %147 = comb.icmp eq %pending_txn_cnt_22, %c1_i2 : i2
      cf.cond_br %147, ^bb21, ^bb47
    ^bb21:  // pred: ^bb20
      llhd.drv %gen_integ_handling.wait_phase, %true after %1 : i1
      %148 = llhd.prb %gen_integ_handling.rdback_en_q : i4
      %149 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%148) : (i4) -> i1
      %150 = comb.mux %149, %c6_i4, %c-7_i4 : i4
      llhd.drv %gen_integ_handling.rdback_check_d, %150 after %1 : i4
      %151 = llhd.prb %gen_integ_handling.held_data : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
      %a_data_23 = hw.struct_extract %151["a_data"] : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
      llhd.drv %gen_integ_handling.rdback_data_exp_d, %a_data_23 after %1 : i32
      %152 = llhd.prb %gen_integ_handling.held_intg : !hw.struct<a_user_cmd_intg: i7, a_user_data_intg: i7>
      %a_user_data_intg_24 = hw.struct_extract %152["a_user_data_intg"] : !hw.struct<a_user_cmd_intg: i7, a_user_data_intg: i7>
      llhd.drv %gen_integ_handling.rdback_data_exp_intg_d, %a_user_data_intg_24 after %1 : i7
      %153 = llhd.prb %gen_integ_handling.d_ack : i1
      cf.cond_br %153, ^bb22, ^bb23
    ^bb22:  // pred: ^bb21
      llhd.drv %gen_integ_handling.state_d, %c15_i8 after %1 : i8
      cf.br ^bb47
    ^bb23:  // pred: ^bb21
      llhd.drv %gen_integ_handling.state_d, %c48_i8 after %1 : i8
      cf.br ^bb47
    ^bb24:  // pred: ^bb19
      %154 = comb.icmp ceq %104, %c15_i8 : i8
      cf.cond_br %154, ^bb25, ^bb26
    ^bb25:  // pred: ^bb24
      llhd.drv %gen_integ_handling.stall_host, %true after %1 : i1
      llhd.drv %gen_integ_handling.rdback_phase, %true after %1 : i1
      llhd.drv %gen_integ_handling.state_d, %c126_i8 after %1 : i8
      cf.br ^bb47
    ^bb26:  // pred: ^bb24
      %155 = comb.icmp ceq %104, %c48_i8 : i8
      cf.cond_br %155, ^bb27, ^bb29
    ^bb27:  // pred: ^bb26
      llhd.drv %gen_integ_handling.wait_phase, %true after %1 : i1
      llhd.drv %gen_integ_handling.stall_host, %true after %1 : i1
      %156 = llhd.prb %gen_integ_handling.d_ack : i1
      cf.cond_br %156, ^bb28, ^bb47
    ^bb28:  // pred: ^bb27
      llhd.drv %gen_integ_handling.state_d, %c15_i8 after %1 : i8
      cf.br ^bb47
    ^bb29:  // pred: ^bb26
      %157 = comb.icmp ceq %104, %c87_i8 : i8
      cf.cond_br %157, ^bb30, ^bb33
    ^bb30:  // pred: ^bb29
      llhd.drv %gen_integ_handling.stall_host, %true after %1 : i1
      llhd.drv %gen_integ_handling.wait_phase, %true after %1 : i1
      %158 = llhd.prb %gen_integ_handling.d_ack : i1
      cf.cond_br %158, ^bb31, ^bb32
    ^bb31:  // pred: ^bb30
      llhd.drv %gen_integ_handling.state_d, %c-25_i8 after %1 : i8
      cf.br ^bb47
    ^bb32:  // pred: ^bb30
      llhd.drv %gen_integ_handling.state_d, %c-1_i8 after %1 : i8
      cf.br ^bb47
    ^bb33:  // pred: ^bb29
      %159 = comb.icmp ceq %104, %c-25_i8 : i8
      cf.cond_br %159, ^bb34, ^bb35
    ^bb34:  // pred: ^bb33
      llhd.drv %gen_integ_handling.stall_host, %true after %1 : i1
      llhd.drv %gen_integ_handling.rdback_phase_wrreadback, %true after %1 : i1
      llhd.drv %gen_integ_handling.state_d, %c126_i8 after %1 : i8
      cf.br ^bb47
    ^bb35:  // pred: ^bb33
      %160 = comb.icmp ceq %104, %c-1_i8 : i8
      cf.cond_br %160, ^bb36, ^bb38
    ^bb36:  // pred: ^bb35
      llhd.drv %gen_integ_handling.stall_host, %true after %1 : i1
      llhd.drv %gen_integ_handling.wait_phase, %true after %1 : i1
      %161 = llhd.prb %gen_integ_handling.d_ack : i1
      cf.cond_br %161, ^bb37, ^bb47
    ^bb37:  // pred: ^bb36
      llhd.drv %gen_integ_handling.state_d, %c-25_i8 after %1 : i8
      cf.br ^bb47
    ^bb38:  // pred: ^bb35
      %162 = comb.icmp ceq %104, %c-84_i8 : i8
      cf.cond_br %162, ^bb39, ^bb43
    ^bb39:  // pred: ^bb38
      llhd.drv %gen_integ_handling.stall_host, %true after %1 : i1
      %163 = llhd.prb %gen_integ_handling.sync_fifo_a_size_outputs : !hw.struct<pending_txn_cnt: i2, a_size: i2, size_fifo_rdy: i1>
      %pending_txn_cnt_25 = hw.struct_extract %163["pending_txn_cnt"] : !hw.struct<pending_txn_cnt: i2, a_size: i2, size_fifo_rdy: i1>
      %164 = comb.icmp eq %pending_txn_cnt_25, %c1_i2 : i2
      cf.cond_br %164, ^bb40, ^bb47
    ^bb40:  // pred: ^bb39
      llhd.drv %gen_integ_handling.rdback_phase, %true after %1 : i1
      %165 = llhd.prb %gen_integ_handling.d_ack : i1
      cf.cond_br %165, ^bb41, ^bb42
    ^bb41:  // pred: ^bb40
      llhd.drv %gen_integ_handling.state_d, %c126_i8 after %1 : i8
      %166 = llhd.prb %gen_integ_handling.rdback_en_q : i4
      %167 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%166) : (i4) -> i1
      %168 = comb.mux %167, %c6_i4, %c-7_i4 : i4
      llhd.drv %gen_integ_handling.rdback_check_d, %168 after %1 : i4
      %169 = llhd.prb %tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      %d_data_26 = hw.struct_extract %169["d_data"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      llhd.drv %gen_integ_handling.rdback_data_exp_d, %d_data_26 after %1 : i32
      %170 = llhd.prb %tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      %d_user = hw.struct_extract %170["d_user"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      %data_intg_27 = hw.struct_extract %d_user["data_intg"] : !hw.struct<rsp_intg: i7, data_intg: i7>
      llhd.drv %gen_integ_handling.rdback_data_exp_intg_d, %data_intg_27 after %1 : i7
      cf.br ^bb47
    ^bb42:  // pred: ^bb40
      llhd.drv %gen_integ_handling.state_d, %c-64_i8 after %1 : i8
      cf.br ^bb47
    ^bb43:  // pred: ^bb38
      %171 = comb.icmp ceq %104, %c-64_i8 : i8
      cf.cond_br %171, ^bb44, ^bb46
    ^bb44:  // pred: ^bb43
      llhd.drv %gen_integ_handling.stall_host, %true after %1 : i1
      %172 = llhd.prb %gen_integ_handling.d_ack : i1
      cf.cond_br %172, ^bb45, ^bb47
    ^bb45:  // pred: ^bb44
      llhd.drv %gen_integ_handling.state_d, %c126_i8 after %1 : i8
      %173 = llhd.prb %gen_integ_handling.rdback_en_q : i4
      %174 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%173) : (i4) -> i1
      %175 = comb.mux %174, %c6_i4, %c-7_i4 : i4
      llhd.drv %gen_integ_handling.rdback_check_d, %175 after %1 : i4
      %176 = llhd.prb %tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      %d_data_28 = hw.struct_extract %176["d_data"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      llhd.drv %gen_integ_handling.rdback_data_exp_d, %d_data_28 after %1 : i32
      %177 = llhd.prb %tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      %d_user_29 = hw.struct_extract %177["d_user"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      %data_intg_30 = hw.struct_extract %d_user_29["data_intg"] : !hw.struct<rsp_intg: i7, data_intg: i7>
      llhd.drv %gen_integ_handling.rdback_data_exp_intg_d, %data_intg_30 after %1 : i7
      cf.br ^bb47
    ^bb46:  // pred: ^bb43
      llhd.drv %gen_integ_handling.readback_err, %true after %1 : i1
      cf.br ^bb47
    ^bb47:  // 24 preds: ^bb10, ^bb11, ^bb13, ^bb14, ^bb15, ^bb17, ^bb18, ^bb20, ^bb22, ^bb23, ^bb25, ^bb27, ^bb28, ^bb31, ^bb32, ^bb34, ^bb36, ^bb37, ^bb39, ^bb41, ^bb42, ^bb44, ^bb45, ^bb46
      llhd.wait (%52, %53, %54, %55, %56, %57, %58, %59, %60, %61, %62, %48, %63, %10, %64, %11, %50, %12, %65, %13, %66, %41, %67, %34, %31, %68, %22, %42, %46, %69, %70, %15, %71, %72, %25 : i1, i1, i1, i1, i1, i1, i1, i1, i8, i8, i1, i1, i4, i4, i4, i4, i32, i32, i7, i7, i1, i1, i1, !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, i4, i1, i1, i1, !hw.struct<pending_txn_cnt: i2, a_size: i2, size_fifo_rdy: i1>, i1, i1, !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>, !hw.struct<a_user_cmd_intg: i7, a_user_data_intg: i7>, i1), ^bb1
    }
    %a_param = hw.struct_extract %24["a_param"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_source = hw.struct_extract %24["a_source"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_address = hw.struct_extract %24["a_address"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_data = hw.struct_extract %24["a_data"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_user = hw.struct_extract %24["a_user"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %rsvd = hw.struct_extract %a_user["rsvd"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %instr_type = hw.struct_extract %a_user["instr_type"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %73 = hw.struct_create (%a_opcode, %a_param, %a_size, %a_source, %a_address, %a_mask, %a_data, %rsvd, %instr_type) {sv.namehint = "gen_integ_handling.txn_data"} : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
    %cmd_intg = hw.struct_extract %a_user["cmd_intg"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %data_intg = hw.struct_extract %a_user["data_intg"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %74 = hw.struct_create (%cmd_intg, %data_intg) {sv.namehint = "gen_integ_handling.txn_intg"} : !hw.struct<a_user_cmd_intg: i7, a_user_data_intg: i7>
    %75 = comb.or %62, %67 : i1
    llhd.drv %gen_integ_handling.txn_data_intg_wr, %75 after %1 : i1
    %76 = comb.concat %14, %15 {sv.namehint = "gen_integ_handling.buf_sync_fifo_intg_in"} : i1, i1
    %77 = comb.extract %gen_integ_handling.u_sync_fifo_intg_prim_buf.out_o from 1 {sv.namehint = "gen_integ_handling.txn_data_intg_wr_buf"} : (i2) -> i1
    %78 = comb.extract %gen_integ_handling.u_sync_fifo_intg_prim_buf.out_o from 0 {sv.namehint = "gen_integ_handling.sram_a_ack_buf"} : (i2) -> i1
    %79 = llhd.prb %gen_integ_handling.fifo_rdy_data : i1
    %80 = comb.icmp ne %79, %gen_integ_handling.u_sync_fifo_intg.wready_o {sv.namehint = "gen_integ_handling.sync_fifo_outputs_mismatch"} : i1
    %a_user_rsvd = hw.struct_extract %71["a_user_rsvd"] : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
    %a_user_instr_type = hw.struct_extract %71["a_user_instr_type"] : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
    %a_user_cmd_intg = hw.struct_extract %72["a_user_cmd_intg"] : !hw.struct<a_user_cmd_intg: i7, a_user_data_intg: i7>
    %a_user_data_intg = hw.struct_extract %72["a_user_data_intg"] : !hw.struct<a_user_cmd_intg: i7, a_user_data_intg: i7>
    %81 = hw.struct_create (%a_user_rsvd, %a_user_instr_type, %a_user_cmd_intg, %a_user_data_intg) {sv.namehint = "gen_integ_handling.tl_i_fifo_a_user"} : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %a_opcode_10 = hw.struct_extract %71["a_opcode"] : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
    %a_param_11 = hw.struct_extract %71["a_param"] : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
    %a_size_12 = hw.struct_extract %71["a_size"] : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
    %a_source_13 = hw.struct_extract %71["a_source"] : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
    %a_address_14 = hw.struct_extract %71["a_address"] : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
    %a_mask_15 = hw.struct_extract %71["a_mask"] : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
    %a_data_16 = hw.struct_extract %71["a_data"] : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
    %82 = hw.struct_create (%15, %a_opcode_10, %a_param_11, %a_size_12, %a_source_13, %a_address_14, %a_mask_15, %a_data_16, %81, %true) {sv.namehint = "gen_integ_handling.tl_i_fifo"} : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %99 = llhd.prb %clk_i_0 : i1
      %100 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%8, %9 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %101 = llhd.prb %clk_i_0 : i1
      %102 = comb.xor bin %99, %true : i1
      %103 = comb.and bin %102, %101 : i1
      %104 = llhd.prb %rst_ni_1 : i1
      %105 = comb.xor bin %104, %true : i1
      %106 = comb.and bin %100, %105 : i1
      %107 = comb.or bin %103, %106 : i1
      cf.cond_br %107, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %108 = llhd.prb %rst_ni_1 : i1
      %109 = comb.xor %108, %true : i1
      cf.cond_br %109, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_integ_handling.enable_intg_check_cmp_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %110 = llhd.prb %gen_integ_handling.txn_data_intg_wr : i1
      cf.cond_br %110, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %gen_integ_handling.enable_intg_check_cmp_q, %true after %0 : i1
      cf.br ^bb1
    }
    %83 = llhd.prb %gen_integ_handling.enable_intg_check_cmp_q : i1
    %84 = comb.and %83, %gen_integ_handling.u_cmd_intg_chk.err_o {sv.namehint = "gen_integ_handling.tl_intg_err"} : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
      %99 = llhd.prb %clk_i_0 : i1
      llhd.wait (%8 : i1), ^bb2
    ^bb2:  // pred: ^bb1
      %100 = llhd.prb %clk_i_0 : i1
      %101 = comb.xor bin %99, %true : i1
      %102 = comb.and bin %101, %100 : i1
      cf.cond_br %102, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %103 = llhd.prb %gen_integ_handling.sram_d_ack : i1
      %104 = llhd.prb %gen_integ_handling.rd_wait : i1
      %105 = comb.and %103, %104 : i1
      cf.cond_br %105, ^bb4, ^bb1
    ^bb4:  // pred: ^bb3
      %106 = llhd.prb %tl_sram_i_3 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      %d_data_17 = hw.struct_extract %106["d_data"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      llhd.drv %gen_integ_handling.rsp_data, %d_data_17 after %0 : i32
      cf.br ^bb1
    }
    %85 = llhd.prb %gen_integ_handling.rsp_data : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb4
      %i = llhd.sig %c0_i32 : i32
      llhd.drv %i, %c0_i32 after %1 : i32
      cf.br ^bb2
    ^bb2:  // 2 preds: ^bb1, ^bb3
      %99 = llhd.prb %i : i32
      %100 = comb.icmp slt %99, %c4_i32 : i32
      cf.cond_br %100, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %101 = llhd.prb %i : i32
      %102 = comb.extract %101 from 0 : (i32) -> i29
      %103 = comb.concat %102, %c0_i3 : i29, i3
      %104 = comb.extract %101 from 2 : (i32) -> i27
      %105 = comb.icmp eq %104, %c0_i27 : i27
      %106 = comb.extract %101 from 0 : (i32) -> i2
      %107 = comb.concat %106, %c0_i3 : i2, i3
      %108 = comb.mux %105, %107, %c-1_i5 : i5
      %109 = llhd.sig.extract %gen_integ_handling.combined_data from %108 : <i32> -> <i8>
      %110 = llhd.prb %gen_integ_handling.held_data : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
      %a_mask_17 = hw.struct_extract %110["a_mask"] : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
      %111 = comb.extract %101 from 4 : (i32) -> i28
      %112 = comb.icmp eq %111, %c0_i28 : i28
      %113 = comb.extract %101 from 0 : (i32) -> i4
      %114 = comb.mux %112, %113, %c-1_i4 : i4
      %115 = comb.shru %a_mask_17, %114 : i4
      %116 = comb.extract %115 from 0 : (i4) -> i1
      %a_data_18 = hw.struct_extract %110["a_data"] : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
      %117 = comb.shru %a_data_18, %103 : i32
      %118 = comb.extract %117 from 0 : (i32) -> i8
      %119 = llhd.prb %gen_integ_handling.rsp_data : i32
      %120 = comb.shru %119, %103 : i32
      %121 = comb.extract %120 from 0 : (i32) -> i8
      %122 = comb.mux %116, %118, %121 : i8
      llhd.drv %109, %122 after %1 : i8
      %123 = llhd.prb %i : i32
      %124 = comb.add %123, %c1_i32 : i32
      llhd.drv %i, %124 after %1 : i32
      cf.br ^bb2
    ^bb4:  // pred: ^bb2
      llhd.wait (%20, %71, %85 : i32, !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>, i32), ^bb1
    }
    %86 = llhd.prb %gen_integ_handling.combined_user : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %87 = llhd.prb %gen_integ_handling.data_intg : i7
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %99 = llhd.sig.struct_extract %gen_integ_handling.combined_user["cmd_intg"] : <!hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>>
      %100 = llhd.prb %gen_integ_handling.held_intg : !hw.struct<a_user_cmd_intg: i7, a_user_data_intg: i7>
      %a_user_cmd_intg_17 = hw.struct_extract %100["a_user_cmd_intg"] : !hw.struct<a_user_cmd_intg: i7, a_user_data_intg: i7>
      llhd.drv %99, %a_user_cmd_intg_17 after %1 : i7
      %101 = llhd.sig.struct_extract %gen_integ_handling.combined_user["data_intg"] : <!hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>>
      %102 = llhd.prb %gen_integ_handling.data_intg : i7
      llhd.drv %101, %102 after %1 : i7
      %103 = llhd.sig.struct_extract %gen_integ_handling.combined_user["rsvd"] : <!hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>>
      %104 = llhd.prb %gen_integ_handling.held_data : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
      %a_user_rsvd_18 = hw.struct_extract %104["a_user_rsvd"] : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
      llhd.drv %103, %a_user_rsvd_18 after %1 : i5
      %105 = llhd.sig.struct_extract %gen_integ_handling.combined_user["instr_type"] : <!hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>>
      %106 = llhd.prb %gen_integ_handling.held_data : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
      %a_user_instr_type_19 = hw.struct_extract %106["a_user_instr_type"] : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
      llhd.drv %105, %a_user_instr_type_19 after %1 : i4
      llhd.wait (%86, %72, %87, %71 : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, !hw.struct<a_user_cmd_intg: i7, a_user_data_intg: i7>, i7, !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb8
      %99 = llhd.prb %tl_i_2 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      llhd.drv %tl_sram_o, %99 after %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %100 = llhd.sig.struct_extract %tl_sram_o["d_ready"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
      %101 = llhd.prb %tl_i_2 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %d_ready_17 = hw.struct_extract %101["d_ready"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %102 = llhd.prb %gen_integ_handling.rd_wait : i1
      %103 = llhd.prb %gen_integ_handling.rdback_wait : i1
      %104 = comb.or %d_ready_17, %102, %103 : i1
      llhd.drv %100, %104 after %1 : i1
      %105 = llhd.prb %gen_integ_handling.wr_phase : i1
      %106 = llhd.prb %gen_integ_handling.rdback_phase : i1
      %107 = llhd.prb %gen_integ_handling.rdback_phase_wrreadback : i1
      %108 = comb.or %105, %106, %107 : i1
      cf.cond_br %108, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %109 = llhd.sig.struct_extract %tl_sram_o["a_valid"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
      llhd.drv %109, %true after %1 : i1
      %110 = llhd.sig.struct_extract %tl_sram_o["a_opcode"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
      %111 = llhd.prb %gen_integ_handling.wr_phase : i1
      %112 = comb.xor %111, %true : i1
      %113 = comb.concat %112, %c0_i2 : i1, i2
      llhd.drv %110, %113 after %1 : i3
      %114 = llhd.sig.struct_extract %tl_sram_o["a_size"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
      %115 = llhd.prb %gen_integ_handling.wr_phase : i1
      %116 = llhd.prb %gen_integ_handling.rdback_phase_wrreadback : i1
      %117 = comb.or %115, %116 : i1
      %118 = llhd.prb %gen_integ_handling.held_data : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
      %a_size_18 = hw.struct_extract %118["a_size"] : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
      %119 = comb.mux %117, %c-2_i2, %a_size_18 : i2
      llhd.drv %114, %119 after %1 : i2
      %120 = llhd.sig.struct_extract %tl_sram_o["a_mask"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
      %121 = llhd.prb %gen_integ_handling.wr_phase : i1
      %122 = llhd.prb %gen_integ_handling.rdback_phase_wrreadback : i1
      %123 = comb.or %121, %122 : i1
      %124 = llhd.prb %gen_integ_handling.held_data : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
      %a_mask_19 = hw.struct_extract %124["a_mask"] : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
      %125 = comb.mux %123, %c-1_i4, %a_mask_19 : i4
      llhd.drv %120, %125 after %1 : i4
      %126 = llhd.sig.struct_extract %tl_sram_o["a_address"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
      %127 = llhd.prb %gen_integ_handling.held_data : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
      %a_address_20 = hw.struct_extract %127["a_address"] : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
      llhd.drv %126, %a_address_20 after %1 : i32
      %128 = llhd.sig.extract %126 from %c0_i5 : <i32> -> <i2>
      %129 = llhd.prb %gen_integ_handling.wr_phase : i1
      %130 = llhd.prb %gen_integ_handling.rdback_phase_wrreadback : i1
      %131 = comb.or %129, %130 : i1
      %132 = llhd.prb %gen_integ_handling.held_data : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
      %a_address_21 = hw.struct_extract %132["a_address"] : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
      %133 = comb.extract %a_address_21 from 0 : (i32) -> i2
      %134 = comb.mux %131, %c0_i2, %133 : i2
      llhd.drv %128, %134 after %1 : i2
      %135 = llhd.sig.struct_extract %tl_sram_o["a_source"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
      %136 = llhd.prb %gen_integ_handling.held_data : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
      %a_source_22 = hw.struct_extract %136["a_source"] : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
      llhd.drv %135, %a_source_22 after %1 : i8
      %137 = llhd.sig.struct_extract %tl_sram_o["a_param"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
      %138 = llhd.prb %gen_integ_handling.held_data : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
      %a_param_23 = hw.struct_extract %138["a_param"] : !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>
      llhd.drv %137, %a_param_23 after %1 : i3
      %139 = llhd.sig.struct_extract %tl_sram_o["a_data"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
      %140 = llhd.prb %gen_integ_handling.wr_phase : i1
      %141 = llhd.prb %gen_integ_handling.combined_data : i32
      %142 = comb.mux %140, %141, %c0_i32 : i32
      llhd.drv %139, %142 after %1 : i32
      %143 = llhd.sig.struct_extract %tl_sram_o["a_user"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
      %144 = llhd.prb %gen_integ_handling.wr_phase : i1
      %145 = llhd.prb %gen_integ_handling.combined_user : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
      %146 = hw.bitcast %145 : (!hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>) -> i23
      %147 = comb.mux %144, %146, %c0_i23 : i23
      %148 = hw.bitcast %147 : (i23) -> !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
      llhd.drv %143, %148 after %1 : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
      cf.br ^bb8
    ^bb3:  // pred: ^bb1
      %149 = llhd.prb %gen_integ_handling.rd_phase : i1
      cf.cond_br %149, ^bb4, ^bb6
    ^bb4:  // pred: ^bb3
      %150 = llhd.sig.struct_extract %tl_sram_o["a_address"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
      %151 = llhd.sig.extract %150 from %c0_i5 : <i32> -> <i2>
      llhd.drv %151, %c0_i2 after %1 : i2
      %152 = llhd.prb %error_i_4 : i1
      %153 = comb.xor %152, %true : i1
      %154 = llhd.prb %gen_integ_handling.stall_host : i1
      %155 = comb.or %153, %154 : i1
      cf.cond_br %155, ^bb5, ^bb8
    ^bb5:  // pred: ^bb4
      %156 = llhd.sig.struct_extract %tl_sram_o["a_size"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
      llhd.drv %156, %c-2_i2 after %1 : i2
      %157 = llhd.sig.struct_extract %tl_sram_o["a_mask"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
      llhd.drv %157, %c-1_i4 after %1 : i4
      %158 = llhd.sig.struct_extract %tl_sram_o["a_valid"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
      %159 = llhd.prb %tl_i_2 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_valid_24 = hw.struct_extract %159["a_valid"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %160 = llhd.prb %gen_integ_handling.stall_host : i1
      %161 = comb.xor %160, %true : i1
      %162 = comb.and %a_valid_24, %161 : i1
      llhd.drv %158, %162 after %1 : i1
      %163 = llhd.sig.struct_extract %tl_sram_o["a_opcode"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
      llhd.drv %163, %c-4_i3 after %1 : i3
      cf.br ^bb8
    ^bb6:  // pred: ^bb3
      %164 = llhd.prb %gen_integ_handling.wait_phase : i1
      cf.cond_br %164, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %165 = llhd.sig.struct_extract %tl_sram_o["a_valid"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
      llhd.drv %165, %false after %1 : i1
      cf.br ^bb8
    ^bb8:  // 5 preds: ^bb2, ^bb4, ^bb5, ^bb6, ^bb7
      llhd.wait (%24, %34, %52, %59, %55, %57, %58, %71, %20, %86, %56, %42, %54, %53 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, i1, i1, i1, i1, i1, !hw.struct<a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user_rsvd: i5, a_user_instr_type: i4>, i32, !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, i1, i1, i1, i1), ^bb1
    }
    %88 = comb.xor %54, %true : i1
    %89 = comb.and %42, %88 : i1
    %90 = comb.concat %22, %a_size, %25 {sv.namehint = "gen_integ_handling.buf_sync_fifo_a_size_in"} : i1, i2, i1
    %91 = comb.extract %gen_integ_handling.u_sync_fifo_a_size_prim_buf.out_o from 3 {sv.namehint = "gen_integ_handling.a_ack_buf"} : (i4) -> i1
    %92 = comb.extract %gen_integ_handling.u_sync_fifo_a_size_prim_buf.out_o from 1 {sv.namehint = "gen_integ_handling.a_size_buf"} : (i4) -> i2
    %93 = comb.extract %gen_integ_handling.u_sync_fifo_a_size_prim_buf.out_o from 0 {sv.namehint = "gen_integ_handling.d_ack_buf"} : (i4) -> i1
    %94 = llhd.prb %gen_integ_handling.sync_fifo_a_size_shadow_outputs : !hw.struct<pending_txn_cnt: i2, a_size: i2, size_fifo_rdy: i1>
    %95 = hw.bitcast %94 : (!hw.struct<pending_txn_cnt: i2, a_size: i2, size_fifo_rdy: i1>) -> i5
    %96 = hw.bitcast %69 : (!hw.struct<pending_txn_cnt: i2, a_size: i2, size_fifo_rdy: i1>) -> i5
    %97 = comb.icmp ne %95, %96 {sv.namehint = "gen_integ_handling.sync_fifo_a_size_outputs_mismatch"} : i5
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %99 = llhd.prb %tl_sram_i_3 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      llhd.drv %tl_o, %99 after %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      %100 = llhd.sig.struct_extract %tl_o["a_ready"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
      %101 = llhd.prb %tl_sram_i_3 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      %a_ready_17 = hw.struct_extract %101["a_ready"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      %102 = llhd.prb %gen_integ_handling.stall_host : i1
      %103 = comb.xor %102, %true : i1
      %104 = llhd.prb %gen_integ_handling.fifo_rdy_data : i1
      %105 = llhd.prb %gen_integ_handling.sync_fifo_a_size_outputs : !hw.struct<pending_txn_cnt: i2, a_size: i2, size_fifo_rdy: i1>
      %size_fifo_rdy = hw.struct_extract %105["size_fifo_rdy"] : !hw.struct<pending_txn_cnt: i2, a_size: i2, size_fifo_rdy: i1>
      %106 = comb.and %a_ready_17, %103, %104, %size_fifo_rdy : i1
      llhd.drv %100, %106 after %1 : i1
      %107 = llhd.sig.struct_extract %tl_o["d_valid"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
      %108 = llhd.prb %tl_sram_i_3 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      %d_valid_18 = hw.struct_extract %108["d_valid"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      %109 = llhd.prb %gen_integ_handling.rd_wait : i1
      %110 = comb.xor %109, %true : i1
      %111 = llhd.prb %gen_integ_handling.rdback_wait : i1
      %112 = comb.xor %111, %true : i1
      %113 = comb.and %d_valid_18, %110, %112 : i1
      llhd.drv %107, %113 after %1 : i1
      %114 = llhd.sig.struct_extract %tl_o["d_size"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
      %115 = llhd.prb %gen_integ_handling.sync_fifo_a_size_outputs : !hw.struct<pending_txn_cnt: i2, a_size: i2, size_fifo_rdy: i1>
      %a_size_19 = hw.struct_extract %115["a_size"] : !hw.struct<pending_txn_cnt: i2, a_size: i2, size_fifo_rdy: i1>
      llhd.drv %114, %a_size_19 after %1 : i2
      llhd.wait (%35, %31, %54, %79, %69, %52, %59 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, i1, i1, !hw.struct<pending_txn_cnt: i2, a_size: i2, size_fifo_rdy: i1>, i1, i1), ^bb1
    }
    %98 = comb.or %55, %57, %58 : i1
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %tl_i_2, %tl_i after %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    llhd.drv %tl_sram_i_3, %tl_sram_i after %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %error_i_4, %error_i after %1 : i1
    llhd.drv %readback_en_i_5, %readback_en_i after %1 : i4
    hw.output %31, %34, %89, %49, %98 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, i1, i1, i1
  }
  hw.module private @prim_mubi8_sync(in %clk_i : i1, in %rst_ni : i1, in %mubi_i : i8, out mubi_o : !hw.array<1xi8>) {
    %c0_i0 = hw.constant 0 : i0
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
    %1 = hw.aggregate_constant [0 : i8] : !hw.array<1xi8>
    %mubi_o = llhd.sig %1 : !hw.array<1xi8>
    %gen_buffs_0.mubi_out = llhd.sig %c0_i8 : i8
    %gen_flops.u_prim_flop_2sync.q_o = hw.instance "gen_flops.u_prim_flop_2sync" @prim_flop_2sync_9(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %mubi_i: i8) -> (q_o: i8) {sv.namehint = "gen_flops.mubi_sync"}
    %2 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 0 : (i8) -> i1
    %3 = llhd.sig.extract %gen_buffs_0.mubi_out from %c0_i3 : <i8> -> <i1>
    %gen_buffs_0.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_0.u_prim_buf" @prim_buf_10(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %3, %gen_buffs_0.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %4 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 1 : (i8) -> i1
    %5 = llhd.sig.extract %gen_buffs_0.mubi_out from %c1_i3 : <i8> -> <i1>
    %gen_buffs_0.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_1.u_prim_buf" @prim_buf_10(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %5, %gen_buffs_0.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %6 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 2 : (i8) -> i1
    %7 = llhd.sig.extract %gen_buffs_0.mubi_out from %c2_i3 : <i8> -> <i1>
    %gen_buffs_0.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_2.u_prim_buf" @prim_buf_10(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %7, %gen_buffs_0.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %8 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 3 : (i8) -> i1
    %9 = llhd.sig.extract %gen_buffs_0.mubi_out from %c3_i3 : <i8> -> <i1>
    %gen_buffs_0.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_3.u_prim_buf" @prim_buf_10(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %9, %gen_buffs_0.gen_bits_3.u_prim_buf.out_o after %0 : i1
    %10 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 4 : (i8) -> i1
    %11 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-4_i3 : <i8> -> <i1>
    %gen_buffs_0.gen_bits_4.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_4.u_prim_buf" @prim_buf_10(in_i: %10: i1) -> (out_o: i1)
    llhd.drv %11, %gen_buffs_0.gen_bits_4.u_prim_buf.out_o after %0 : i1
    %12 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 5 : (i8) -> i1
    %13 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-3_i3 : <i8> -> <i1>
    %gen_buffs_0.gen_bits_5.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_5.u_prim_buf" @prim_buf_10(in_i: %12: i1) -> (out_o: i1)
    llhd.drv %13, %gen_buffs_0.gen_bits_5.u_prim_buf.out_o after %0 : i1
    %14 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 6 : (i8) -> i1
    %15 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-2_i3 : <i8> -> <i1>
    %gen_buffs_0.gen_bits_6.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_6.u_prim_buf" @prim_buf_10(in_i: %14: i1) -> (out_o: i1)
    llhd.drv %15, %gen_buffs_0.gen_bits_6.u_prim_buf.out_o after %0 : i1
    %16 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 7 : (i8) -> i1
    %17 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-1_i3 : <i8> -> <i1>
    %gen_buffs_0.gen_bits_7.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_7.u_prim_buf" @prim_buf_10(in_i: %16: i1) -> (out_o: i1)
    llhd.drv %17, %gen_buffs_0.gen_bits_7.u_prim_buf.out_o after %0 : i1
    %18 = llhd.sig.array_get %mubi_o[%c0_i0] : <!hw.array<1xi8>>
    %19 = llhd.prb %gen_buffs_0.mubi_out : i8
    llhd.drv %18, %19 after %0 : i8
    %20 = llhd.prb %mubi_o : !hw.array<1xi8>
    hw.output %20 : !hw.array<1xi8>
  }
  func.func private @"lc_ctrl_pkg::lc_to_mubi4"(%arg0: i4) -> i4 {
    %c3_i4 = hw.constant 3 : i4
    %0 = comb.xor %arg0, %c3_i4 : i4
    return %0 : i4
  }
  func.func private @"lc_ctrl_pkg::lc_tx_bool_to_lc_tx"(%arg0: i1) -> i4 {
    %c-6_i4 = hw.constant -6 : i4
    %c5_i4 = hw.constant 5 : i4
    %0 = comb.mux %arg0, %c5_i4, %c-6_i4 : i4
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
  func.func private @"lc_ctrl_pkg::lc_tx_inv"(%arg0: i4) -> i4 {
    %c-1_i4 = hw.constant -1 : i4
    %0 = comb.xor %arg0, %c-1_i4 : i4
    return %0 : i4
  }
  hw.module private @prim_lc_sync(in %clk_i : i1, in %rst_ni : i1, in %lc_en_i : i4, out lc_en_o : !hw.array<2xi4>) {
    %true = hw.constant true
    %false = hw.constant false
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %c0_i4 = hw.constant 0 : i4
    %1 = hw.aggregate_constant [0 : i4, 0 : i4] : !hw.array<2xi4>
    %lc_en_o = llhd.sig %1 : !hw.array<2xi4>
    %gen_buffs_0.lc_en_out = llhd.sig %c0_i4 : i4
    %gen_buffs_1.lc_en_out = llhd.sig %c0_i4 : i4
    %gen_flops.u_prim_flop_2sync.q_o = hw.instance "gen_flops.u_prim_flop_2sync" @prim_flop_2sync(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %lc_en_i: i4) -> (q_o: i4) {sv.namehint = "lc_en"}
    %2 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 0 : (i4) -> i1
    %3 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf_6(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %3, %gen_buffs_0.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %4 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 1 : (i4) -> i1
    %5 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf_6(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %5, %gen_buffs_0.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %6 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 2 : (i4) -> i1
    %7 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf_6(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %7, %gen_buffs_0.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %8 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 3 : (i4) -> i1
    %9 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf_6(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %9, %gen_buffs_0.gen_bits_3.u_prim_buf.out_o after %0 : i1
    %10 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf_6(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %10, %gen_buffs_1.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %11 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf_6(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %11, %gen_buffs_1.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %12 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf_6(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %12, %gen_buffs_1.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %13 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf_6(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %13, %gen_buffs_1.gen_bits_3.u_prim_buf.out_o after %0 : i1
    %14 = llhd.sig.array_get %lc_en_o[%false] : <!hw.array<2xi4>>
    %15 = llhd.prb %gen_buffs_0.lc_en_out : i4
    llhd.drv %14, %15 after %0 : i4
    %16 = llhd.sig.array_get %lc_en_o[%true] : <!hw.array<2xi4>>
    %17 = llhd.prb %gen_buffs_1.lc_en_out : i4
    llhd.drv %16, %17 after %0 : i4
    %18 = llhd.prb %lc_en_o : !hw.array<2xi4>
    hw.output %18 : !hw.array<2xi4>
  }
  hw.module private @prim_lc_sync_0(in %clk_i : i1, in %rst_ni : i1, in %lc_en_i : i4, out lc_en_o : !hw.array<1xi4>) {
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
    %gen_flops.u_prim_flop_2sync.q_o = hw.instance "gen_flops.u_prim_flop_2sync" @prim_flop_2sync(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %lc_en_i: i4) -> (q_o: i4) {sv.namehint = "lc_en"}
    %2 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 0 : (i4) -> i1
    %3 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf_6(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %3, %gen_buffs_0.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %4 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 1 : (i4) -> i1
    %5 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf_6(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %5, %gen_buffs_0.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %6 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 2 : (i4) -> i1
    %7 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf_6(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %7, %gen_buffs_0.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %8 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 3 : (i4) -> i1
    %9 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf_6(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %9, %gen_buffs_0.gen_bits_3.u_prim_buf.out_o after %0 : i1
    %10 = llhd.sig.array_get %lc_en_o[%c0_i0] : <!hw.array<1xi4>>
    %11 = llhd.prb %gen_buffs_0.lc_en_out : i4
    llhd.drv %10, %11 after %0 : i4
    %12 = llhd.prb %lc_en_o : !hw.array<1xi4>
    hw.output %12 : !hw.array<1xi4>
  }
  hw.module private @prim_lc_sync_11(in %clk_i : i1, in %rst_ni : i1, in %lc_en_i : i4, out lc_en_o : !hw.array<2xi4>) {
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
    %gen_buffs_0.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf_6(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %6, %gen_buffs_0.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %7 = comb.extract %17 from 1 : (i4) -> i1
    %8 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf_6(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %8, %gen_buffs_0.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %9 = comb.extract %17 from 2 : (i4) -> i1
    %10 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf_6(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %10, %gen_buffs_0.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %11 = comb.extract %17 from 3 : (i4) -> i1
    %12 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf_6(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %12, %gen_buffs_0.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %13 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf_6(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %13, %gen_buffs_1.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %14 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf_6(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %14, %gen_buffs_1.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %15 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf_6(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %15, %gen_buffs_1.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %16 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf_6(in_i: %11: i1) -> (out_o: i1)
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
  func.func private @"prim_cipher_pkg::prince_shiftrows_64bit"(%arg0: i64, %arg1: !hw.array<16xi4>) -> i64 {
    %c0_i58 = hw.constant 0 : i58
    %c0_i2 = hw.constant 0 : i2
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c-1_i4 = hw.constant -1 : i4
    %c0_i28 = hw.constant 0 : i28
    %c-1_i6 = hw.constant -1 : i6
    %c0_i26 = hw.constant 0 : i26
    %c16_i32 = hw.constant 16 : i32
    %c1_i32 = hw.constant 1 : i32
    %c0_i32 = hw.constant 0 : i32
    %c0_i64 = hw.constant 0 : i64
    %state_out = llhd.sig %c0_i64 : i64
    cf.br ^bb1(%c0_i32 : i32)
  ^bb1(%1: i32):  // 2 preds: ^bb0, ^bb2
    %2 = comb.icmp slt %1, %c16_i32 : i32
    cf.cond_br %2, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %3 = comb.extract %1 from 4 : (i32) -> i26
    %4 = comb.icmp eq %3, %c0_i26 : i26
    %5 = comb.extract %1 from 0 : (i32) -> i4
    %6 = comb.concat %5, %c0_i2 : i4, i2
    %7 = comb.mux %4, %6, %c-1_i6 : i6
    %8 = llhd.sig.extract %state_out from %7 : <i64> -> <i4>
    %9 = comb.extract %1 from 4 : (i32) -> i28
    %10 = comb.icmp eq %9, %c0_i28 : i28
    %11 = comb.extract %1 from 0 : (i32) -> i4
    %12 = comb.mux %10, %11, %c-1_i4 : i4
    %13 = hw.array_get %arg1[%12] : !hw.array<16xi4>, i4
    %14 = comb.concat %c0_i58, %13, %c0_i2 : i58, i4, i2
    %15 = comb.shru %arg0, %14 : i64
    %16 = comb.extract %15 from 0 : (i64) -> i4
    llhd.drv %8, %16 after %0 : i4
    %17 = comb.add %1, %c1_i32 : i32
    cf.br ^bb1(%17 : i32)
  ^bb3:  // pred: ^bb1
    %18 = llhd.prb %state_out : i64
    return %18 : i64
  }
  func.func private @"prim_cipher_pkg::prince_nibble_red16"(%arg0: i16) -> i4 {
    %0 = comb.extract %arg0 from 0 : (i16) -> i4
    %1 = comb.extract %arg0 from 4 : (i16) -> i4
    %2 = comb.extract %arg0 from 8 : (i16) -> i4
    %3 = comb.extract %arg0 from 12 : (i16) -> i4
    %4 = comb.xor %0, %1, %2, %3 : i4
    return %4 : i4
  }
  func.func private @"prim_cipher_pkg::prince_mult_prime_64bit"(%arg0: i64) -> i64 {
    %false = hw.constant false
    %c-529_i14 = hw.constant -529 : i14
    %c-4_i6 = hw.constant -4 : i6
    %c-8_i6 = hw.constant -8 : i6
    %c-12_i6 = hw.constant -12 : i6
    %c-16_i6 = hw.constant -16 : i6
    %c-20_i6 = hw.constant -20 : i6
    %c-24_i6 = hw.constant -24 : i6
    %c-28_i6 = hw.constant -28 : i6
    %c-32_i6 = hw.constant -32 : i6
    %c28_i6 = hw.constant 28 : i6
    %c24_i6 = hw.constant 24 : i6
    %c20_i6 = hw.constant 20 : i6
    %c16_i6 = hw.constant 16 : i6
    %c12_i6 = hw.constant 12 : i6
    %c8_i6 = hw.constant 8 : i6
    %c4_i6 = hw.constant 4 : i6
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i6 = hw.constant 0 : i6
    %c-16921_i16 = hw.constant -16921 : i16
    %c-8581_i16 = hw.constant -8581 : i16
    %c-6211_i16 = hw.constant -6211 : i16
    %c0_i64 = hw.constant 0 : i64
    %state_out = llhd.sig %c0_i64 : i64
    %1 = llhd.sig.extract %state_out from %c0_i6 : <i64> -> <i4>
    %2 = comb.extract %arg0 from 0 : (i64) -> i16
    %3 = comb.and %2, %c-6211_i16 : i16
    %4 = call @"prim_cipher_pkg::prince_nibble_red16"(%3) : (i16) -> i4
    llhd.drv %1, %4 after %0 : i4
    %5 = llhd.sig.extract %state_out from %c4_i6 : <i64> -> <i4>
    %6 = comb.and %2, %c-8581_i16 : i16
    %7 = call @"prim_cipher_pkg::prince_nibble_red16"(%6) : (i16) -> i4
    llhd.drv %5, %7 after %0 : i4
    %8 = llhd.sig.extract %state_out from %c8_i6 : <i64> -> <i4>
    %9 = comb.and %2, %c-16921_i16 : i16
    %10 = call @"prim_cipher_pkg::prince_nibble_red16"(%9) : (i16) -> i4
    llhd.drv %8, %10 after %0 : i4
    %11 = llhd.sig.extract %state_out from %c12_i6 : <i64> -> <i4>
    %12 = comb.extract %arg0 from 1 : (i64) -> i14
    %13 = comb.and %12, %c-529_i14 : i14
    %14 = comb.concat %false, %13, %false : i1, i14, i1
    %15 = call @"prim_cipher_pkg::prince_nibble_red16"(%14) : (i16) -> i4
    llhd.drv %11, %15 after %0 : i4
    %16 = llhd.sig.extract %state_out from %c16_i6 : <i64> -> <i4>
    %17 = comb.extract %arg0 from 16 : (i64) -> i16
    %18 = comb.extract %arg0 from 17 : (i64) -> i14
    %19 = comb.and %18, %c-529_i14 : i14
    %20 = comb.concat %false, %19, %false : i1, i14, i1
    %21 = call @"prim_cipher_pkg::prince_nibble_red16"(%20) : (i16) -> i4
    llhd.drv %16, %21 after %0 : i4
    %22 = llhd.sig.extract %state_out from %c20_i6 : <i64> -> <i4>
    %23 = comb.and %17, %c-6211_i16 : i16
    %24 = call @"prim_cipher_pkg::prince_nibble_red16"(%23) : (i16) -> i4
    llhd.drv %22, %24 after %0 : i4
    %25 = llhd.sig.extract %state_out from %c24_i6 : <i64> -> <i4>
    %26 = comb.and %17, %c-8581_i16 : i16
    %27 = call @"prim_cipher_pkg::prince_nibble_red16"(%26) : (i16) -> i4
    llhd.drv %25, %27 after %0 : i4
    %28 = llhd.sig.extract %state_out from %c28_i6 : <i64> -> <i4>
    %29 = comb.and %17, %c-16921_i16 : i16
    %30 = call @"prim_cipher_pkg::prince_nibble_red16"(%29) : (i16) -> i4
    llhd.drv %28, %30 after %0 : i4
    %31 = llhd.sig.extract %state_out from %c-32_i6 : <i64> -> <i4>
    %32 = comb.extract %arg0 from 32 : (i64) -> i16
    %33 = comb.extract %arg0 from 33 : (i64) -> i14
    %34 = comb.and %33, %c-529_i14 : i14
    %35 = comb.concat %false, %34, %false : i1, i14, i1
    %36 = call @"prim_cipher_pkg::prince_nibble_red16"(%35) : (i16) -> i4
    llhd.drv %31, %36 after %0 : i4
    %37 = llhd.sig.extract %state_out from %c-28_i6 : <i64> -> <i4>
    %38 = comb.and %32, %c-6211_i16 : i16
    %39 = call @"prim_cipher_pkg::prince_nibble_red16"(%38) : (i16) -> i4
    llhd.drv %37, %39 after %0 : i4
    %40 = llhd.sig.extract %state_out from %c-24_i6 : <i64> -> <i4>
    %41 = comb.and %32, %c-8581_i16 : i16
    %42 = call @"prim_cipher_pkg::prince_nibble_red16"(%41) : (i16) -> i4
    llhd.drv %40, %42 after %0 : i4
    %43 = llhd.sig.extract %state_out from %c-20_i6 : <i64> -> <i4>
    %44 = comb.and %32, %c-16921_i16 : i16
    %45 = call @"prim_cipher_pkg::prince_nibble_red16"(%44) : (i16) -> i4
    llhd.drv %43, %45 after %0 : i4
    %46 = llhd.sig.extract %state_out from %c-16_i6 : <i64> -> <i4>
    %47 = comb.extract %arg0 from 48 : (i64) -> i16
    %48 = comb.and %47, %c-6211_i16 : i16
    %49 = call @"prim_cipher_pkg::prince_nibble_red16"(%48) : (i16) -> i4
    llhd.drv %46, %49 after %0 : i4
    %50 = llhd.sig.extract %state_out from %c-12_i6 : <i64> -> <i4>
    %51 = comb.and %47, %c-8581_i16 : i16
    %52 = call @"prim_cipher_pkg::prince_nibble_red16"(%51) : (i16) -> i4
    llhd.drv %50, %52 after %0 : i4
    %53 = llhd.sig.extract %state_out from %c-8_i6 : <i64> -> <i4>
    %54 = comb.and %47, %c-16921_i16 : i16
    %55 = call @"prim_cipher_pkg::prince_nibble_red16"(%54) : (i16) -> i4
    llhd.drv %53, %55 after %0 : i4
    %56 = llhd.sig.extract %state_out from %c-4_i6 : <i64> -> <i4>
    %57 = comb.extract %arg0 from 49 : (i64) -> i14
    %58 = comb.and %57, %c-529_i14 : i14
    %59 = comb.concat %false, %58, %false : i1, i14, i1
    %60 = call @"prim_cipher_pkg::prince_nibble_red16"(%59) : (i16) -> i4
    llhd.drv %56, %60 after %0 : i4
    %61 = llhd.prb %state_out : i64
    return %61 : i64
  }
  func.func private @"prim_cipher_pkg::sbox4_8bit"(%arg0: i8, %arg1: !hw.array<16xi4>) -> i8 {
    %c0_i2 = hw.constant 0 : i2
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c-1_i8 = hw.constant -1 : i8
    %c0_i24 = hw.constant 0 : i24
    %c-1_i3 = hw.constant -1 : i3
    %c0_i29 = hw.constant 0 : i29
    %c2_i32 = hw.constant 2 : i32
    %c1_i32 = hw.constant 1 : i32
    %c0_i32 = hw.constant 0 : i32
    %c0_i8 = hw.constant 0 : i8
    %state_out = llhd.sig %c0_i8 : i8
    cf.br ^bb1(%c0_i32 : i32)
  ^bb1(%1: i32):  // 2 preds: ^bb0, ^bb2
    %2 = comb.icmp slt %1, %c2_i32 : i32
    cf.cond_br %2, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %3 = comb.extract %1 from 1 : (i32) -> i29
    %4 = comb.icmp eq %3, %c0_i29 : i29
    %5 = comb.extract %1 from 0 : (i32) -> i1
    %6 = comb.concat %5, %c0_i2 : i1, i2
    %7 = comb.mux %4, %6, %c-1_i3 : i3
    %8 = llhd.sig.extract %state_out from %7 : <i8> -> <i4>
    %9 = comb.extract %1 from 6 : (i32) -> i24
    %10 = comb.icmp eq %9, %c0_i24 : i24
    %11 = comb.extract %1 from 0 : (i32) -> i6
    %12 = comb.concat %11, %c0_i2 : i6, i2
    %13 = comb.mux %10, %12, %c-1_i8 : i8
    %14 = comb.shru %arg0, %13 : i8
    %15 = comb.extract %14 from 0 : (i8) -> i4
    %16 = hw.array_get %arg1[%15] : !hw.array<16xi4>, i4
    llhd.drv %8, %16 after %0 : i4
    %17 = comb.add %1, %c1_i32 : i32
    cf.br ^bb1(%17 : i32)
  ^bb3:  // pred: ^bb1
    %18 = llhd.prb %state_out : i8
    return %18 : i8
  }
  func.func private @"prim_cipher_pkg::sbox4_64bit"(%arg0: i64, %arg1: !hw.array<16xi4>) -> i64 {
    %c0_i3 = hw.constant 0 : i3
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c-1_i6 = hw.constant -1 : i6
    %c0_i26 = hw.constant 0 : i26
    %c1_i32 = hw.constant 1 : i32
    %c8_i32 = hw.constant 8 : i32
    %c0_i32 = hw.constant 0 : i32
    %c0_i64 = hw.constant 0 : i64
    %state_out = llhd.sig %c0_i64 : i64
    cf.br ^bb1(%c0_i32 : i32)
  ^bb1(%1: i32):  // 2 preds: ^bb0, ^bb2
    %2 = comb.icmp slt %1, %c8_i32 : i32
    cf.cond_br %2, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %3 = comb.extract %1 from 0 : (i32) -> i29
    %4 = comb.extract %1 from 3 : (i32) -> i26
    %5 = comb.icmp eq %4, %c0_i26 : i26
    %6 = comb.extract %1 from 0 : (i32) -> i3
    %7 = comb.concat %6, %c0_i3 : i3, i3
    %8 = comb.mux %5, %7, %c-1_i6 : i6
    %9 = llhd.sig.extract %state_out from %8 : <i64> -> <i8>
    %10 = comb.concat %c0_i32, %3, %c0_i3 : i32, i29, i3
    %11 = comb.shru %arg0, %10 : i64
    %12 = comb.extract %11 from 0 : (i64) -> i8
    %13 = call @"prim_cipher_pkg::sbox4_8bit"(%12, %arg1) : (i8, !hw.array<16xi4>) -> i8
    llhd.drv %9, %13 after %0 : i8
    %14 = comb.add %1, %c1_i32 : i32
    cf.br ^bb1(%14 : i32)
  ^bb3:  // pred: ^bb1
    %15 = llhd.prb %state_out : i64
    return %15 : i64
  }
  hw.module private @prim_prince(in %clk_i : i1, in %rst_ni : i1, in %valid_i : i1, in %data_i : i64, in %key_i : i128, in %dec_i : i1, out valid_o : i1, out data_o : i64) {
    %c-3191464880007011431_i64 = hw.constant -3191464880007011431 : i64
    %c7252222110370849037_i64 = hw.constant 7252222110370849037 : i64
    %0 = hw.aggregate_constant [-1 : i4, 2 : i4, 5 : i4, -8 : i4, -5 : i4, -2 : i4, 1 : i4, 4 : i4, 7 : i4, -6 : i4, -3 : i4, 0 : i4, 3 : i4, 6 : i4, -7 : i4, -4 : i4] : !hw.array<16xi4>
    %c-3998401319710606252_i64 = hw.constant -3998401319710606252 : i64
    %1 = hw.aggregate_constant [1 : i4, -4 : i4, -2 : i4, 5 : i4, 0 : i4, 4 : i4, 6 : i4, -6 : i4, -7 : i4, -8 : i4, -3 : i4, -1 : i4, 2 : i4, 3 : i4, 7 : i4, -5 : i4] : !hw.array<16xi4>
    %c589684135938649225_i64 = hw.constant 589684135938649225 : i64
    %c-6626703657320631856_i64 = hw.constant -6626703657320631856 : i64
    %c1376283091369227076_i64 = hw.constant 1376283091369227076 : i64
    %2 = hw.aggregate_constant [-4563226453097033507, -3191464880007011431, 7252222110370849037, -3998401319710606252, -8825920221699357782, 9149150024072256689, -4732044268327596948, 4983270260364809079, 589684135938649225, -6626703657320631856, 1376283091369227076, 0] : !hw.array<12xi64>
    %3 = hw.aggregate_constant [-1 : i4, -6 : i4, 5 : i4, 0 : i4, -5 : i4, 6 : i4, 1 : i4, -4 : i4, 7 : i4, 2 : i4, -3 : i4, -8 : i4, 3 : i4, -2 : i4, -7 : i4, 4 : i4] : !hw.array<16xi4>
    %4 = hw.aggregate_constant [4 : i4, -3 : i4, 5 : i4, -2 : i4, 0 : i4, -8 : i4, 7 : i4, 6 : i4, 1 : i4, -7 : i4, -4 : i4, -6 : i4, 2 : i4, 3 : i4, -1 : i4, -5 : i4] : !hw.array<16xi4>
    %5 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %c0_i2 = hw.constant 0 : i2
    %6 = llhd.constant_time <0ns, 0d, 1e>
    %7 = hw.aggregate_constant [0, 0, 0, 0] : !hw.array<4xi64>
    %c0_i128 = hw.constant 0 : i128
    %c0_i64 = hw.constant 0 : i64
    %false = hw.constant false
    %c-4563226453097033507_i64 = hw.constant -4563226453097033507 : i64
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %8 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %9 = llhd.prb %rst_ni_1 : i1
    %valid_i_2 = llhd.sig name "valid_i" %false : i1
    %data_i_3 = llhd.sig name "data_i" %c0_i64 : i64
    %key_i_4 = llhd.sig name "key_i" %c0_i128 : i128
    %dec_i_5 = llhd.sig name "dec_i" %false : i1
    %data_o = llhd.sig %c0_i64 : i64
    %k0 = llhd.sig %c0_i64 : i64
    %k0_prime_d = llhd.sig %c0_i64 : i64
    %k1_d = llhd.sig %c0_i64 : i64
    %k0_new_d = llhd.sig %c0_i64 : i64
    %k0_prime_q = llhd.sig %c0_i64 : i64
    %k1_q = llhd.sig %c0_i64 : i64
    %data_state_lo = llhd.sig %7 : !hw.array<4xi64>
    %data_state_hi = llhd.sig %7 : !hw.array<4xi64>
    %gen_fwd_pass_1.data_state_round = llhd.sig %c0_i64 : i64
    %gen_fwd_pass_2.data_state_round = llhd.sig %c0_i64 : i64
    %gen_fwd_pass_3.data_state_round = llhd.sig %c0_i64 : i64
    %data_state_middle_d = llhd.sig %c0_i64 : i64
    %data_state_middle_q = llhd.sig %c0_i64 : i64
    %data_state_middle = llhd.sig %c0_i64 : i64
    %gen_data_reg.valid_q = llhd.sig %false : i1
    %gen_bwd_pass_1.data_state_xor1 = llhd.sig %c0_i64 : i64
    %gen_bwd_pass_1.data_state_bwd = llhd.sig %c0_i64 : i64
    %gen_bwd_pass_2.data_state_xor1 = llhd.sig %c0_i64 : i64
    %gen_bwd_pass_2.data_state_bwd = llhd.sig %c0_i64 : i64
    %gen_bwd_pass_3.data_state_xor1 = llhd.sig %c0_i64 : i64
    %gen_bwd_pass_3.data_state_bwd = llhd.sig %c0_i64 : i64
    %10 = llhd.prb %key_i_4 : i128
    %11 = llhd.prb %k0 : i64
    %12 = llhd.prb %k0_prime_d : i64
    %13 = llhd.prb %k1_d : i64
    %14 = llhd.prb %dec_i_5 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb3
      %48 = llhd.prb %key_i_4 : i128
      %49 = comb.extract %48 from 64 : (i128) -> i64
      llhd.drv %k0, %49 after %6 : i64
      %50 = llhd.prb %k0 : i64
      %51 = comb.extract %50 from 0 : (i64) -> i1
      %52 = comb.extract %50 from 2 : (i64) -> i62
      %53 = comb.extract %50 from 63 : (i64) -> i1
      %54 = comb.extract %50 from 1 : (i64) -> i1
      %55 = comb.xor %53, %54 : i1
      %56 = comb.concat %51, %52, %55 : i1, i62, i1
      llhd.drv %k0_prime_d, %56 after %6 : i64
      %57 = llhd.prb %key_i_4 : i128
      %58 = comb.extract %57 from 0 : (i128) -> i64
      llhd.drv %k1_d, %58 after %6 : i64
      %59 = llhd.prb %dec_i_5 : i1
      cf.cond_br %59, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %60 = llhd.prb %k0_prime_d : i64
      llhd.drv %k0, %60 after %6 : i64
      %61 = llhd.prb %key_i_4 : i128
      %62 = comb.extract %61 from 64 : (i128) -> i64
      llhd.drv %k0_prime_d, %62 after %6 : i64
      %63 = llhd.prb %k1_d : i64
      %64 = comb.xor %63, %c-4563226453097033507_i64 : i64
      llhd.drv %k1_d, %64 after %6 : i64
      cf.br ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      llhd.wait (%10, %11, %12, %13, %14 : i128, i64, i64, i64, i1), ^bb1
    }
    %15 = llhd.prb %k0_new_d {sv.namehint = "k0_new_q"} : i64
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb3
      %48 = llhd.prb %key_i_4 : i128
      %49 = comb.extract %48 from 64 : (i128) -> i64
      llhd.drv %k0_new_d, %49 after %6 : i64
      %50 = llhd.prb %dec_i_5 : i1
      cf.cond_br %50, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %51 = llhd.prb %k0_new_d : i64
      %52 = comb.xor %51, %c-4563226453097033507_i64 : i64
      llhd.drv %k0_new_d, %52 after %6 : i64
      cf.br ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      llhd.wait (%10, %15, %14 : i128, i64, i1), ^bb1
    }
    llhd.drv %k1_q, %13 after %6 : i64
    llhd.drv %k0_prime_q, %12 after %6 : i64
    %16 = llhd.prb %data_state_lo : !hw.array<4xi64>
    %17 = llhd.prb %data_i_3 : i64
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %48 = llhd.sig.array_get %data_state_lo[%c0_i2] : <!hw.array<4xi64>>
      %49 = llhd.prb %data_i_3 : i64
      %50 = llhd.prb %k0 : i64
      %51 = comb.xor %49, %50 : i64
      llhd.drv %48, %51 after %6 : i64
      %52 = llhd.prb %48 : i64
      %53 = llhd.prb %k1_d : i64
      %54 = comb.xor %52, %53 : i64
      llhd.drv %48, %54 after %6 : i64
      %55 = llhd.prb %48 : i64
      llhd.drv %48, %55 after %6 : i64
      llhd.wait (%16, %17, %11, %13 : !hw.array<4xi64>, i64, i64, i64), ^bb1
    }
    %18 = llhd.prb %gen_fwd_pass_1.data_state_round : i64
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %48 = llhd.prb %data_state_lo : !hw.array<4xi64>
      %49 = hw.array_get %48[%c0_i2] : !hw.array<4xi64>, i2
      %50 = func.call @"prim_cipher_pkg::sbox4_64bit"(%49, %4) : (i64, !hw.array<16xi4>) -> i64
      llhd.drv %gen_fwd_pass_1.data_state_round, %50 after %6 : i64
      %51 = llhd.prb %gen_fwd_pass_1.data_state_round : i64
      %52 = func.call @"prim_cipher_pkg::prince_mult_prime_64bit"(%51) : (i64) -> i64
      llhd.drv %gen_fwd_pass_1.data_state_round, %52 after %6 : i64
      %53 = llhd.prb %gen_fwd_pass_1.data_state_round : i64
      %54 = func.call @"prim_cipher_pkg::prince_shiftrows_64bit"(%53, %3) : (i64, !hw.array<16xi4>) -> i64
      llhd.drv %gen_fwd_pass_1.data_state_round, %54 after %6 : i64
      llhd.wait (%16, %18 : !hw.array<4xi64>, i64), ^bb1
    }
    %19 = llhd.sig.array_get %data_state_lo[%c1_i2] : <!hw.array<4xi64>>
    %20 = comb.xor %18, %15, %c1376283091369227076_i64 : i64
    llhd.drv %19, %20 after %6 : i64
    %21 = llhd.prb %gen_fwd_pass_2.data_state_round : i64
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %48 = llhd.prb %data_state_lo : !hw.array<4xi64>
      %49 = hw.array_get %48[%c1_i2] : !hw.array<4xi64>, i2
      %50 = func.call @"prim_cipher_pkg::sbox4_64bit"(%49, %4) : (i64, !hw.array<16xi4>) -> i64
      llhd.drv %gen_fwd_pass_2.data_state_round, %50 after %6 : i64
      %51 = llhd.prb %gen_fwd_pass_2.data_state_round : i64
      %52 = func.call @"prim_cipher_pkg::prince_mult_prime_64bit"(%51) : (i64) -> i64
      llhd.drv %gen_fwd_pass_2.data_state_round, %52 after %6 : i64
      %53 = llhd.prb %gen_fwd_pass_2.data_state_round : i64
      %54 = func.call @"prim_cipher_pkg::prince_shiftrows_64bit"(%53, %3) : (i64, !hw.array<16xi4>) -> i64
      llhd.drv %gen_fwd_pass_2.data_state_round, %54 after %6 : i64
      llhd.wait (%16, %21 : !hw.array<4xi64>, i64), ^bb1
    }
    %22 = llhd.sig.array_get %data_state_lo[%c-2_i2] : <!hw.array<4xi64>>
    %23 = comb.xor %21, %13, %c-6626703657320631856_i64 : i64
    llhd.drv %22, %23 after %6 : i64
    %24 = llhd.prb %gen_fwd_pass_3.data_state_round : i64
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %48 = llhd.prb %data_state_lo : !hw.array<4xi64>
      %49 = hw.array_get %48[%c-2_i2] : !hw.array<4xi64>, i2
      %50 = func.call @"prim_cipher_pkg::sbox4_64bit"(%49, %4) : (i64, !hw.array<16xi4>) -> i64
      llhd.drv %gen_fwd_pass_3.data_state_round, %50 after %6 : i64
      %51 = llhd.prb %gen_fwd_pass_3.data_state_round : i64
      %52 = func.call @"prim_cipher_pkg::prince_mult_prime_64bit"(%51) : (i64) -> i64
      llhd.drv %gen_fwd_pass_3.data_state_round, %52 after %6 : i64
      %53 = llhd.prb %gen_fwd_pass_3.data_state_round : i64
      %54 = func.call @"prim_cipher_pkg::prince_shiftrows_64bit"(%53, %3) : (i64, !hw.array<16xi4>) -> i64
      llhd.drv %gen_fwd_pass_3.data_state_round, %54 after %6 : i64
      llhd.wait (%16, %24 : !hw.array<4xi64>, i64), ^bb1
    }
    %25 = llhd.sig.array_get %data_state_lo[%c-1_i2] : <!hw.array<4xi64>>
    %26 = comb.xor %24, %15, %c589684135938649225_i64 : i64
    llhd.drv %25, %26 after %6 : i64
    %27 = llhd.prb %data_state_middle_d : i64
    %28 = llhd.prb %data_state_middle_q : i64
    %29 = llhd.prb %data_state_middle : i64
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %48 = llhd.prb %data_state_lo : !hw.array<4xi64>
      %49 = hw.array_get %48[%c-1_i2] : !hw.array<4xi64>, i2
      %50 = func.call @"prim_cipher_pkg::sbox4_64bit"(%49, %4) : (i64, !hw.array<16xi4>) -> i64
      llhd.drv %data_state_middle_d, %50 after %6 : i64
      %51 = llhd.prb %data_state_middle_q : i64
      %52 = func.call @"prim_cipher_pkg::prince_mult_prime_64bit"(%51) : (i64) -> i64
      llhd.drv %data_state_middle, %52 after %6 : i64
      %53 = llhd.prb %data_state_middle : i64
      %54 = func.call @"prim_cipher_pkg::sbox4_64bit"(%53, %1) : (i64, !hw.array<16xi4>) -> i64
      llhd.drv %data_state_middle, %54 after %6 : i64
      llhd.wait (%16, %27, %28, %29 : !hw.array<4xi64>, i64, i64, i64), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %48 = llhd.prb %clk_i_0 : i1
      %49 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%8, %9 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %50 = llhd.prb %clk_i_0 : i1
      %51 = comb.xor bin %48, %true : i1
      %52 = comb.and bin %51, %50 : i1
      %53 = llhd.prb %rst_ni_1 : i1
      %54 = comb.xor bin %53, %true : i1
      %55 = comb.and bin %49, %54 : i1
      %56 = comb.or bin %52, %55 : i1
      cf.cond_br %56, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %57 = llhd.prb %rst_ni_1 : i1
      %58 = comb.xor %57, %true : i1
      cf.cond_br %58, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_data_reg.valid_q, %false after %5 : i1
      llhd.drv %data_state_middle_q, %c0_i64 after %5 : i64
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %59 = llhd.prb %valid_i_2 : i1
      llhd.drv %gen_data_reg.valid_q, %59 after %5 : i1
      %60 = llhd.prb %valid_i_2 : i1
      cf.cond_br %60, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %61 = llhd.prb %data_state_middle_d : i64
      llhd.drv %data_state_middle_q, %61 after %5 : i64
      cf.br ^bb1
    }
    %30 = llhd.prb %gen_data_reg.valid_q : i1
    %31 = llhd.sig.array_get %data_state_hi[%c0_i2] : <!hw.array<4xi64>>
    llhd.drv %31, %29 after %6 : i64
    %32 = llhd.prb %data_state_hi : !hw.array<4xi64>
    %33 = hw.array_get %32[%c0_i2] : !hw.array<4xi64>, i2
    %34 = comb.xor %33, %15, %c-3998401319710606252_i64 : i64
    llhd.drv %gen_bwd_pass_1.data_state_xor1, %34 after %6 : i64
    %35 = llhd.prb %gen_bwd_pass_1.data_state_xor1 : i64
    %36 = llhd.prb %gen_bwd_pass_1.data_state_bwd : i64
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %48 = llhd.prb %gen_bwd_pass_1.data_state_xor1 : i64
      %49 = func.call @"prim_cipher_pkg::prince_shiftrows_64bit"(%48, %0) : (i64, !hw.array<16xi4>) -> i64
      llhd.drv %gen_bwd_pass_1.data_state_bwd, %49 after %6 : i64
      %50 = llhd.prb %gen_bwd_pass_1.data_state_bwd : i64
      %51 = func.call @"prim_cipher_pkg::prince_mult_prime_64bit"(%50) : (i64) -> i64
      llhd.drv %gen_bwd_pass_1.data_state_bwd, %51 after %6 : i64
      %52 = llhd.sig.array_get %data_state_hi[%c1_i2] : <!hw.array<4xi64>>
      %53 = llhd.prb %gen_bwd_pass_1.data_state_bwd : i64
      %54 = func.call @"prim_cipher_pkg::sbox4_64bit"(%53, %1) : (i64, !hw.array<16xi4>) -> i64
      llhd.drv %52, %54 after %6 : i64
      llhd.wait (%35, %36, %32 : i64, i64, !hw.array<4xi64>), ^bb1
    }
    %37 = hw.array_get %32[%c1_i2] : !hw.array<4xi64>, i2
    %38 = llhd.prb %k1_q : i64
    %39 = comb.xor %37, %38, %c7252222110370849037_i64 : i64
    llhd.drv %gen_bwd_pass_2.data_state_xor1, %39 after %6 : i64
    %40 = llhd.prb %gen_bwd_pass_2.data_state_xor1 : i64
    %41 = llhd.prb %gen_bwd_pass_2.data_state_bwd : i64
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %48 = llhd.prb %gen_bwd_pass_2.data_state_xor1 : i64
      %49 = func.call @"prim_cipher_pkg::prince_shiftrows_64bit"(%48, %0) : (i64, !hw.array<16xi4>) -> i64
      llhd.drv %gen_bwd_pass_2.data_state_bwd, %49 after %6 : i64
      %50 = llhd.prb %gen_bwd_pass_2.data_state_bwd : i64
      %51 = func.call @"prim_cipher_pkg::prince_mult_prime_64bit"(%50) : (i64) -> i64
      llhd.drv %gen_bwd_pass_2.data_state_bwd, %51 after %6 : i64
      %52 = llhd.sig.array_get %data_state_hi[%c-2_i2] : <!hw.array<4xi64>>
      %53 = llhd.prb %gen_bwd_pass_2.data_state_bwd : i64
      %54 = func.call @"prim_cipher_pkg::sbox4_64bit"(%53, %1) : (i64, !hw.array<16xi4>) -> i64
      llhd.drv %52, %54 after %6 : i64
      llhd.wait (%40, %41, %32 : i64, i64, !hw.array<4xi64>), ^bb1
    }
    %42 = hw.array_get %32[%c-2_i2] : !hw.array<4xi64>, i2
    %43 = comb.xor %42, %15, %c-3191464880007011431_i64 : i64
    llhd.drv %gen_bwd_pass_3.data_state_xor1, %43 after %6 : i64
    %44 = llhd.prb %gen_bwd_pass_3.data_state_xor1 : i64
    %45 = llhd.prb %gen_bwd_pass_3.data_state_bwd : i64
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %48 = llhd.prb %gen_bwd_pass_3.data_state_xor1 : i64
      %49 = func.call @"prim_cipher_pkg::prince_shiftrows_64bit"(%48, %0) : (i64, !hw.array<16xi4>) -> i64
      llhd.drv %gen_bwd_pass_3.data_state_bwd, %49 after %6 : i64
      %50 = llhd.prb %gen_bwd_pass_3.data_state_bwd : i64
      %51 = func.call @"prim_cipher_pkg::prince_mult_prime_64bit"(%50) : (i64) -> i64
      llhd.drv %gen_bwd_pass_3.data_state_bwd, %51 after %6 : i64
      %52 = llhd.sig.array_get %data_state_hi[%c-1_i2] : <!hw.array<4xi64>>
      %53 = llhd.prb %gen_bwd_pass_3.data_state_bwd : i64
      %54 = func.call @"prim_cipher_pkg::sbox4_64bit"(%53, %1) : (i64, !hw.array<16xi4>) -> i64
      llhd.drv %52, %54 after %6 : i64
      llhd.wait (%44, %45, %32 : i64, i64, !hw.array<4xi64>), ^bb1
    }
    %46 = llhd.prb %data_o : i64
    %47 = llhd.prb %k0_prime_q : i64
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %48 = llhd.prb %data_state_hi : !hw.array<4xi64>
      %49 = hw.array_get %48[%c-1_i2] : !hw.array<4xi64>, i2
      %50 = comb.xor %49, %c-4563226453097033507_i64 : i64
      llhd.drv %data_o, %50 after %6 : i64
      %51 = llhd.prb %data_o : i64
      %52 = llhd.prb %k1_q : i64
      %53 = comb.xor %51, %52 : i64
      llhd.drv %data_o, %53 after %6 : i64
      %54 = llhd.prb %data_o : i64
      %55 = llhd.prb %k0_prime_q : i64
      %56 = comb.xor %54, %55 : i64
      llhd.drv %data_o, %56 after %6 : i64
      llhd.wait (%32, %2, %46, %38, %47 : !hw.array<4xi64>, !hw.array<12xi64>, i64, i64, i64), ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %6 : i1
    llhd.drv %rst_ni_1, %rst_ni after %6 : i1
    llhd.drv %valid_i_2, %valid_i after %6 : i1
    llhd.drv %data_i_3, %data_i after %6 : i64
    llhd.drv %key_i_4, %key_i after %6 : i128
    llhd.drv %dec_i_5, %dec_i after %6 : i1
    hw.output %30, %46 : i1, i64
  }
  hw.module private @prim_lfsr(in %clk_i : i1, in %rst_ni : i1, in %seed_en_i : i1, in %seed_i : i64, in %lfsr_en_i : i1, in %entropy_i : i64, out state_o : i32) {
    %c0_i59 = hw.constant 0 : i59
    %0 = llhd.constant_time <0ns, 1d, 0e>
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
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c0_i64 = hw.constant 0 : i64
    %c-5434120054299418971_i64 = hw.constant -5434120054299418971 : i64
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %seed_i_2 = llhd.sig name "seed_i" %c0_i64 : i64
    %lfsr_en_i_3 = llhd.sig name "lfsr_en_i" %false : i1
    %state_o = llhd.sig %c0_i32 : i32
    %lockup = llhd.sig %false : i1
    %lfsr_d = llhd.sig %c0_i64 : i64
    %lfsr_q = llhd.sig %c0_i64 : i64
    %next_lfsr_state = llhd.sig %c0_i64 : i64
    %4 = llhd.prb %lfsr_q {sv.namehint = "sbox_out"} : i64
    %5 = comb.extract %4 from 0 : (i64) -> i1
    %6 = comb.replicate %5 : (i1) -> i5
    %7 = comb.and %6, %c-5_i5 : i5
    %8 = comb.concat %7, %c0_i59 : i5, i59
    %9 = comb.extract %4 from 1 : (i64) -> i63
    %10 = comb.concat %false, %9 : i1, i63
    %11 = comb.xor %entropy_i, %8, %10 : i64
    llhd.drv %next_lfsr_state, %11 after %1 : i64
    %12 = comb.icmp eq %4, %c0_i64 : i64
    llhd.drv %lockup, %12 after %1 : i1
    %13 = llhd.prb %seed_i_2 : i64
    %14 = llhd.prb %lfsr_en_i_3 : i1
    %15 = llhd.prb %lockup : i1
    %16 = comb.and %14, %15 : i1
    %17 = llhd.prb %next_lfsr_state : i64
    %18 = comb.mux %14, %17, %4 : i64
    %19 = comb.mux %16, %c-5434120054299418971_i64, %18 : i64
    %20 = comb.mux %seed_en_i, %13, %19 : i64
    llhd.drv %lfsr_d, %20 after %1 : i64
    %21 = llhd.sig.extract %state_o from %c0_i5 : <i32> -> <i1>
    %22 = comb.extract %4 from 37 : (i64) -> i1
    llhd.drv %21, %22 after %1 : i1
    %23 = llhd.sig.extract %state_o from %c1_i5 : <i32> -> <i1>
    %24 = comb.extract %4 from 58 : (i64) -> i1
    llhd.drv %23, %24 after %1 : i1
    %25 = llhd.sig.extract %state_o from %c2_i5 : <i32> -> <i1>
    %26 = comb.extract %4 from 43 : (i64) -> i1
    llhd.drv %25, %26 after %1 : i1
    %27 = llhd.sig.extract %state_o from %c3_i5 : <i32> -> <i1>
    %28 = comb.extract %4 from 50 : (i64) -> i1
    llhd.drv %27, %28 after %1 : i1
    %29 = llhd.sig.extract %state_o from %c4_i5 : <i32> -> <i1>
    %30 = comb.extract %4 from 14 : (i64) -> i1
    llhd.drv %29, %30 after %1 : i1
    %31 = llhd.sig.extract %state_o from %c5_i5 : <i32> -> <i1>
    %32 = comb.extract %4 from 52 : (i64) -> i1
    llhd.drv %31, %32 after %1 : i1
    %33 = llhd.sig.extract %state_o from %c6_i5 : <i32> -> <i1>
    %34 = comb.extract %4 from 62 : (i64) -> i1
    llhd.drv %33, %34 after %1 : i1
    %35 = llhd.sig.extract %state_o from %c7_i5 : <i32> -> <i1>
    %36 = comb.extract %4 from 10 : (i64) -> i1
    llhd.drv %35, %36 after %1 : i1
    %37 = llhd.sig.extract %state_o from %c8_i5 : <i32> -> <i1>
    %38 = comb.extract %4 from 54 : (i64) -> i1
    llhd.drv %37, %38 after %1 : i1
    %39 = llhd.sig.extract %state_o from %c9_i5 : <i32> -> <i1>
    %40 = comb.extract %4 from 13 : (i64) -> i1
    llhd.drv %39, %40 after %1 : i1
    %41 = llhd.sig.extract %state_o from %c10_i5 : <i32> -> <i1>
    %42 = comb.extract %4 from 4 : (i64) -> i1
    llhd.drv %41, %42 after %1 : i1
    %43 = llhd.sig.extract %state_o from %c11_i5 : <i32> -> <i1>
    %44 = comb.extract %4 from 18 : (i64) -> i1
    llhd.drv %43, %44 after %1 : i1
    %45 = llhd.sig.extract %state_o from %c12_i5 : <i32> -> <i1>
    %46 = comb.extract %4 from 32 : (i64) -> i1
    llhd.drv %45, %46 after %1 : i1
    %47 = llhd.sig.extract %state_o from %c13_i5 : <i32> -> <i1>
    %48 = comb.extract %4 from 42 : (i64) -> i1
    llhd.drv %47, %48 after %1 : i1
    %49 = llhd.sig.extract %state_o from %c14_i5 : <i32> -> <i1>
    %50 = comb.extract %4 from 51 : (i64) -> i1
    llhd.drv %49, %50 after %1 : i1
    %51 = llhd.sig.extract %state_o from %c15_i5 : <i32> -> <i1>
    %52 = comb.extract %4 from 40 : (i64) -> i1
    llhd.drv %51, %52 after %1 : i1
    %53 = llhd.sig.extract %state_o from %c-16_i5 : <i32> -> <i1>
    %54 = comb.extract %4 from 2 : (i64) -> i1
    llhd.drv %53, %54 after %1 : i1
    %55 = llhd.sig.extract %state_o from %c-15_i5 : <i32> -> <i1>
    %56 = comb.extract %4 from 27 : (i64) -> i1
    llhd.drv %55, %56 after %1 : i1
    %57 = llhd.sig.extract %state_o from %c-14_i5 : <i32> -> <i1>
    %58 = comb.extract %4 from 20 : (i64) -> i1
    llhd.drv %57, %58 after %1 : i1
    %59 = llhd.sig.extract %state_o from %c-13_i5 : <i32> -> <i1>
    %60 = comb.extract %4 from 12 : (i64) -> i1
    llhd.drv %59, %60 after %1 : i1
    %61 = llhd.sig.extract %state_o from %c-12_i5 : <i32> -> <i1>
    %62 = comb.extract %4 from 41 : (i64) -> i1
    llhd.drv %61, %62 after %1 : i1
    %63 = llhd.sig.extract %state_o from %c-11_i5 : <i32> -> <i1>
    %64 = comb.extract %4 from 9 : (i64) -> i1
    llhd.drv %63, %64 after %1 : i1
    %65 = llhd.sig.extract %state_o from %c-10_i5 : <i32> -> <i1>
    %66 = comb.extract %4 from 8 : (i64) -> i1
    llhd.drv %65, %66 after %1 : i1
    %67 = llhd.sig.extract %state_o from %c-9_i5 : <i32> -> <i1>
    %68 = comb.extract %4 from 46 : (i64) -> i1
    llhd.drv %67, %68 after %1 : i1
    %69 = llhd.sig.extract %state_o from %c-8_i5 : <i32> -> <i1>
    %70 = comb.extract %4 from 29 : (i64) -> i1
    llhd.drv %69, %70 after %1 : i1
    %71 = llhd.sig.extract %state_o from %c-7_i5 : <i32> -> <i1>
    %72 = comb.extract %4 from 48 : (i64) -> i1
    llhd.drv %71, %72 after %1 : i1
    %73 = llhd.sig.extract %state_o from %c-6_i5 : <i32> -> <i1>
    %74 = comb.extract %4 from 17 : (i64) -> i1
    llhd.drv %73, %74 after %1 : i1
    %75 = llhd.sig.extract %state_o from %c-5_i5 : <i32> -> <i1>
    %76 = comb.extract %4 from 23 : (i64) -> i1
    llhd.drv %75, %76 after %1 : i1
    %77 = llhd.sig.extract %state_o from %c-4_i5 : <i32> -> <i1>
    %78 = comb.extract %4 from 22 : (i64) -> i1
    llhd.drv %77, %78 after %1 : i1
    %79 = llhd.sig.extract %state_o from %c-3_i5 : <i32> -> <i1>
    %80 = comb.extract %4 from 28 : (i64) -> i1
    llhd.drv %79, %80 after %1 : i1
    %81 = llhd.sig.extract %state_o from %c-2_i5 : <i32> -> <i1>
    %82 = comb.extract %4 from 26 : (i64) -> i1
    llhd.drv %81, %82 after %1 : i1
    %83 = llhd.sig.extract %state_o from %c-1_i5 : <i32> -> <i1>
    %84 = comb.extract %4 from 11 : (i64) -> i1
    llhd.drv %83, %84 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %86 = llhd.prb %clk_i_0 : i1
      %87 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %88 = llhd.prb %clk_i_0 : i1
      %89 = comb.xor bin %86, %true : i1
      %90 = comb.and bin %89, %88 : i1
      %91 = llhd.prb %rst_ni_1 : i1
      %92 = comb.xor bin %91, %true : i1
      %93 = comb.and bin %87, %92 : i1
      %94 = comb.or bin %90, %93 : i1
      cf.cond_br %94, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %95 = llhd.prb %rst_ni_1 : i1
      %96 = comb.xor %95, %true : i1
      cf.cond_br %96, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %lfsr_q, %c-5434120054299418971_i64 after %0 : i64
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %97 = llhd.prb %lfsr_d : i64
      llhd.drv %lfsr_q, %97 after %0 : i64
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %seed_i_2, %seed_i after %1 : i64
    llhd.drv %lfsr_en_i_3, %lfsr_en_i after %1 : i1
    %85 = llhd.prb %state_o : i32
    hw.output %85 : i32
  }
  hw.module private @prim_ram_1p_adv(in %clk_i : i1, in %rst_ni : i1, in %req_i : i1, in %write_i : i1, in %addr_i : i10, in %wdata_i : i39, in %wmask_i : i39, out rdata_o : i39, out rvalid_o : i1, out rerror_o : i2, in %cfg_i : !hw.array<1xstruct<ram_cfg: !hw.struct<test: i1, cfg_en: i1, cfg: i4>, rf_cfg: !hw.struct<test: i1, cfg_en: i1, cfg: i4>>>, out cfg_rsp_o : !hw.array<1xstruct<done: i1>>, out alert_o : i1) {
    %0 = hw.aggregate_constant [[false]] : !hw.array<1xstruct<done: i1>>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c-1_i39 = hw.constant -1 : i39
    %2 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %3 = hw.aggregate_constant [0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39, 0 : i39] : !hw.array<1024xi39>
    %c0_i10 = hw.constant 0 : i10
    %c0_i2 = hw.constant 0 : i2
    %c-1_i10 = hw.constant -1 : i10
    %false = hw.constant false
    %c0_i39 = hw.constant 0 : i39
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %4 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %5 = llhd.prb %rst_ni_1 : i1
    %req_i_2 = llhd.sig name "req_i" %false : i1
    %write_i_3 = llhd.sig name "write_i" %false : i1
    %addr_i_4 = llhd.sig name "addr_i" %c0_i10 : i10
    %wdata_i_5 = llhd.sig name "wdata_i" %c0_i39 : i39
    %wmask_i_6 = llhd.sig name "wmask_i" %c0_i39 : i39
    %rdata_o = llhd.sig %c0_i39 : i39
    %rvalid_o = llhd.sig %false : i1
    %mem = llhd.sig %3 : !hw.array<1024xi39>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb7, ^bb8
      %8 = llhd.prb %clk_i_0 : i1
      %9 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
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
      llhd.drv %rdata_o, %c0_i39 after %2 : i39
      llhd.drv %rvalid_o, %false after %2 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %19 = llhd.prb %req_i_2 : i1
      %20 = llhd.prb %write_i_3 : i1
      %21 = comb.xor %20, %true : i1
      %22 = comb.and %19, %21 : i1
      llhd.drv %rvalid_o, %22 after %2 : i1
      %23 = llhd.prb %req_i_2 : i1
      cf.cond_br %23, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %24 = llhd.prb %write_i_3 : i1
      cf.cond_br %24, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %25 = llhd.prb %addr_i_4 : i10
      %26 = comb.sub %c-1_i10, %25 : i10
      %27 = llhd.sig.array_get %mem[%26] : <!hw.array<1024xi39>>
      %28 = llhd.prb %mem : !hw.array<1024xi39>
      %29 = hw.array_get %28[%26] : !hw.array<1024xi39>, i10
      %30 = llhd.prb %wmask_i_6 : i39
      %31 = comb.xor %30, %c-1_i39 : i39
      %32 = comb.and %29, %31 : i39
      %33 = llhd.prb %wdata_i_5 : i39
      %34 = comb.and %33, %30 : i39
      %35 = comb.or %32, %34 : i39
      llhd.drv %27, %35 after %2 : i39
      cf.br ^bb1
    ^bb8:  // pred: ^bb6
      %36 = llhd.prb %mem : !hw.array<1024xi39>
      %37 = llhd.prb %addr_i_4 : i10
      %38 = comb.sub %c-1_i10, %37 : i10
      %39 = hw.array_get %36[%38] : !hw.array<1024xi39>, i10
      llhd.drv %rdata_o, %39 after %2 : i39
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %req_i_2, %req_i after %1 : i1
    llhd.drv %write_i_3, %write_i after %1 : i1
    llhd.drv %addr_i_4, %addr_i after %1 : i10
    llhd.drv %wdata_i_5, %wdata_i after %1 : i39
    llhd.drv %wmask_i_6, %wmask_i after %1 : i39
    %6 = llhd.prb %rdata_o : i39
    %7 = llhd.prb %rvalid_o : i1
    hw.output %6, %7, %c0_i2, %0, %false : i39, i1, i2, !hw.array<1xstruct<done: i1>>, i1
  }
  hw.module private @prim_ram_1p_scr(in %clk_i : i1, in %rst_ni : i1, in %key_valid_i : i1, in %key_i : i128, in %nonce_i : i64, in %req_i : i1, out gnt_o : i1, in %write_i : i1, in %addr_i : i10, in %wdata_i : i39, in %wmask_i : i39, in %intg_error_i : i1, out rdata_o : i39, out rvalid_o : i1, out rerror_o : i2, out raddr_o : i10, in %cfg_i : !hw.array<1xstruct<ram_cfg: !hw.struct<test: i1, cfg_en: i1, cfg: i4>, rf_cfg: !hw.struct<test: i1, cfg_en: i1, cfg: i4>>>, out cfg_rsp_o : !hw.array<1xstruct<done: i1>>, out wr_collision_o : i1, out write_pending_o : i1, out alert_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i6 = hw.constant -1 : i6
    %c0_i26 = hw.constant 0 : i26
    %c0_i7 = hw.constant 0 : i7
    %c0_i0 = hw.constant 0 : i0
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [0 : i54] : !hw.array<1xi54>
    %c0_i64 = hw.constant 0 : i64
    %c0_i4 = hw.constant 0 : i4
    %c0_i10 = hw.constant 0 : i10
    %c1_i32 = hw.constant 1 : i32
    %c39_i32 = hw.constant 39 : i32
    %c0_i32 = hw.constant 0 : i32
    %true = hw.constant true
    %c-7_i4 = hw.constant -7 : i4
    %c6_i4 = hw.constant 6 : i4
    %c0_i39 = hw.constant 0 : i39
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %addr_i_2 = llhd.sig name "addr_i" %c0_i10 : i10
    %wdata_i_3 = llhd.sig name "wdata_i" %c0_i39 : i39
    %wmask_i_4 = llhd.sig name "wmask_i" %c0_i39 : i39
    %rdata_o = llhd.sig %c0_i39 : i39
    %rvalid_o = llhd.sig %false : i1
    %read_en_b = llhd.sig %false : i1
    %write_en_b = llhd.sig %false : i1
    %write_pending_q = llhd.sig %c0_i4 : i4
    %addr_collision_q = llhd.sig %c0_i4 : i4
    %addr_scr = llhd.sig %c0_i10 : i10
    %waddr_scr_q = llhd.sig %c0_i10 : i10
    %intg_error_buf = llhd.sig %false : i1
    %intg_error_w_q = llhd.sig %false : i1
    %rw_collision = llhd.sig %false : i1
    %raddr_q = llhd.sig %c0_i10 : i10
    %keystream = llhd.sig %c0_i64 : i64
    %data_scr_nonce = llhd.sig %2 : !hw.array<1xi54>
    %rdata = llhd.sig %c0_i39 : i39
    %wdata_scr_d = llhd.sig %c0_i39 : i39
    %wdata_scr_q = llhd.sig %c0_i39 : i39
    %wdata_q = llhd.sig %c0_i39 : i39
    %rvalid_q = llhd.sig %c0_i4 : i4
    %intg_error_r_q = llhd.sig %false : i1
    %wmask_q = llhd.sig %c0_i39 : i39
    %u_read_en_buf.out_o = hw.instance "u_read_en_buf" @prim_buf_13(in_i: %13: i4) -> (out_o: i4) {sv.namehint = "read_en_b_buf"}
    %u_write_en_d_buf.out_o = hw.instance "u_write_en_d_buf" @prim_buf_13(in_i: %15: i4) -> (out_o: i4) {sv.namehint = "write_en_buf_b_d"}
    %u_addr_match_buf.out_o = hw.instance "u_addr_match_buf" @prim_buf_13(in_i: %19: i4) -> (out_o: i4) {sv.namehint = "addr_match_buf"}
    %u_intg_error.out_o = hw.instance "u_intg_error" @prim_buf_10(in_i: %intg_error_i: i1) -> (out_o: i1)
    llhd.drv %intg_error_buf, %u_intg_error.out_o after %1 : i1
    %5 = llhd.prb %addr_i_2 : i10
    %gen_addr_scr.u_prim_subst_perm.data_o = hw.instance "gen_addr_scr.u_prim_subst_perm" @prim_subst_perm(data_i: %5: i10, key_i: %45: i10) -> (data_o: i10)
    llhd.drv %addr_scr, %gen_addr_scr.u_prim_subst_perm.data_o after %1 : i10
    %6 = llhd.prb %data_scr_nonce : !hw.array<1xi54>
    %7 = hw.array_get %6[%c0_i0] : !hw.array<1xi54>, i0
    %8 = comb.concat %7, %5 : i54, i10
    %gen_par_scr_0.u_prim_prince.valid_o, %gen_par_scr_0.u_prim_prince.data_o = hw.instance "gen_par_scr_0.u_prim_prince" @prim_prince(clk_i: %3: i1, rst_ni: %4: i1, valid_i: %10: i1, data_i: %8: i64, key_i: %key_i: i128, dec_i: %false: i1) -> (valid_o: i1, data_o: i64)
    llhd.drv %keystream, %gen_par_scr_0.u_prim_prince.data_o after %1 : i64
    %gen_diffuse_data_0.u_prim_subst_perm_enc.data_o = hw.instance "gen_diffuse_data_0.u_prim_subst_perm_enc" @prim_subst_perm_14(data_i: %52: i39, key_i: %c0_i39: i39) -> (data_o: i39)
    llhd.drv %wdata_scr_d, %gen_diffuse_data_0.u_prim_subst_perm_enc.data_o after %1 : i39
    %gen_diffuse_data_0.u_prim_subst_perm_dec.data_o = hw.instance "gen_diffuse_data_0.u_prim_subst_perm_dec" @prim_subst_perm_15(data_i: %u_prim_ram_1p_adv.rdata_o: i39, key_i: %c0_i39: i39) -> (data_o: i39) {sv.namehint = "gen_diffuse_data_0.rdata_xor"}
    %u_write_en_flop.q_o = hw.instance "u_write_en_flop" @prim_flop_16(clk_i: %3: i1, rst_ni: %4: i1, d_i: %u_write_en_d_buf.out_o: i4) -> (q_o: i4) {sv.namehint = "write_en_q"}
    %u_addr_collision_flop.q_o = hw.instance "u_addr_collision_flop" @prim_flop_16(clk_i: %3: i1, rst_ni: %4: i1, d_i: %23: i4) -> (q_o: i4)
    llhd.drv %addr_collision_q, %u_addr_collision_flop.q_o after %1 : i4
    %u_write_pending_flop.q_o = hw.instance "u_write_pending_flop" @prim_flop_16(clk_i: %3: i1, rst_ni: %4: i1, d_i: %56: i4) -> (q_o: i4)
    llhd.drv %write_pending_q, %u_write_pending_flop.q_o after %1 : i4
    %u_rvalid_flop.q_o = hw.instance "u_rvalid_flop" @prim_flop_16(clk_i: %3: i1, rst_ni: %4: i1, d_i: %u_read_en_buf.out_o: i4) -> (q_o: i4)
    llhd.drv %rvalid_q, %u_rvalid_flop.q_o after %1 : i4
    %9 = llhd.prb %wmask_q : i39
    %u_prim_ram_1p_adv.rdata_o, %u_prim_ram_1p_adv.rvalid_o, %u_prim_ram_1p_adv.rerror_o, %u_prim_ram_1p_adv.cfg_rsp_o, %u_prim_ram_1p_adv.alert_o = hw.instance "u_prim_ram_1p_adv" @prim_ram_1p_adv(clk_i: %3: i1, rst_ni: %4: i1, req_i: %31: i1, write_i: %36: i1, addr_i: %44: i10, wdata_i: %60: i39, wmask_i: %9: i39, cfg_i: %cfg_i: !hw.array<1xstruct<ram_cfg: !hw.struct<test: i1, cfg_en: i1, cfg: i4>, rf_cfg: !hw.struct<test: i1, cfg_en: i1, cfg: i4>>>) -> (rdata_o: i39, rvalid_o: i1, rerror_o: i2, cfg_rsp_o: !hw.array<1xstruct<done: i1>>, alert_o: i1) {sv.namehint = "ram_alert"}
    %10 = comb.and %req_i, %key_valid_i : i1
    %11 = comb.xor %write_i, %true : i1
    %12 = comb.and %10, %11 : i1
    %13 = func.call @"prim_mubi_pkg::mubi4_bool_to_mubi"(%12) {sv.namehint = "read_en"} : (i1) -> i4
    %14 = comb.and %10, %write_i : i1
    %15 = func.call @"prim_mubi_pkg::mubi4_bool_to_mubi"(%14) {sv.namehint = "write_en_d"} : (i1) -> i4
    %16 = llhd.prb %addr_scr : i10
    %17 = llhd.prb %waddr_scr_q : i10
    %18 = comb.icmp eq %16, %17 : i10
    %19 = comb.mux %18, %c6_i4, %c-7_i4 {sv.namehint = "addr_match"} : i4
    %20 = llhd.prb %write_pending_q : i4
    %21 = func.call @"prim_mubi_pkg::mubi4_or_hi"(%u_write_en_flop.q_o, %20) : (i4, i4) -> i4
    %22 = func.call @"prim_mubi_pkg::mubi4_and_hi"(%21, %u_read_en_buf.out_o) : (i4, i4) -> i4
    %23 = func.call @"prim_mubi_pkg::mubi4_and_hi"(%22, %u_addr_match_buf.out_o) {sv.namehint = "addr_collision_d"} : (i4, i4) -> i4
    %24 = llhd.prb %intg_error_w_q : i1
    %25 = comb.xor %24, %true : i1
    %26 = llhd.prb %intg_error_buf : i1
    %27 = comb.xor %26, %true : i1
    %28 = func.call @"prim_mubi_pkg::mubi4_or_hi"(%u_read_en_buf.out_o, %u_write_en_flop.q_o) : (i4, i4) -> i4
    %29 = func.call @"prim_mubi_pkg::mubi4_or_hi"(%28, %20) : (i4, i4) -> i4
    %30 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%29) : (i4) -> i1
    %31 = comb.and %25, %27, %30 {sv.namehint = "macro_req"} : i1
    %32 = func.call @"prim_mubi_pkg::mubi4_or_hi"(%u_write_en_flop.q_o, %20) : (i4, i4) -> i4
    %33 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%32) : (i4) -> i1
    %34 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%u_read_en_buf.out_o) : (i4) -> i1
    %35 = comb.xor %34, %true : i1
    %36 = comb.and %33, %35, %25 {sv.namehint = "macro_write"} : i1
    %37 = func.call @"prim_mubi_pkg::mubi4_and_hi"(%u_write_en_flop.q_o, %u_read_en_buf.out_o) : (i4, i4) -> i4
    %38 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%37) : (i4) -> i1
    llhd.drv %rw_collision, %38 after %1 : i1
    %39 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%u_write_en_d_buf.out_o) : (i4) -> i1
    %40 = comb.or %36, %39 : i1
    %41 = llhd.prb %addr_collision_q : i4
    %42 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%41) : (i4) -> i1
    %43 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%u_read_en_buf.out_o) : (i4) -> i1
    %44 = comb.mux %43, %16, %17 {sv.namehint = "addr_mux"} : i10
    %45 = comb.extract %nonce_i from 54 {sv.namehint = "gen_addr_scr.addr_scr_nonce"} : (i64) -> i10
    %46 = llhd.prb %raddr_q : i10
    %47 = llhd.sig.array_get %data_scr_nonce[%c0_i0] : <!hw.array<1xi54>>
    %48 = comb.extract %nonce_i from 0 : (i64) -> i54
    llhd.drv %47, %48 after %1 : i54
    %49 = llhd.prb %keystream : i64
    %50 = comb.extract %49 from 0 {sv.namehint = "keystream_repl"} : (i64) -> i39
    %51 = llhd.prb %wdata_q : i39
    %52 = comb.xor %51, %50 {sv.namehint = "gen_diffuse_data_0.wdata_xor"} : i39
    %53 = comb.xor %gen_diffuse_data_0.u_prim_subst_perm_dec.data_o, %50 : i39
    llhd.drv %rdata, %53 after %1 : i39
    %54 = llhd.prb %rw_collision : i1
    %55 = comb.mux %54, %c6_i4, %20 : i4
    %56 = comb.mux %36, %c-7_i4, %55 {sv.namehint = "write_scr_pending_d"} : i4
    %57 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%20) : (i4) -> i1
    %58 = llhd.prb %wdata_scr_q : i39
    %59 = llhd.prb %wdata_scr_d : i39
    %60 = comb.mux %57, %58, %59 {sv.namehint = "wdata_scr"} : i39
    %61 = llhd.prb %rdata_o : i39
    %62 = llhd.prb %rvalid_o : i1
    %63 = llhd.prb %intg_error_r_q : i1
    %64 = llhd.prb %rvalid_q : i4
    %65 = llhd.prb %rdata : i39
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb9
      llhd.drv %rdata_o, %c0_i39 after %1 : i39
      llhd.drv %rvalid_o, %false after %1 : i1
      %73 = llhd.prb %intg_error_r_q : i1
      %74 = comb.xor %73, %true : i1
      %75 = llhd.prb %rvalid_q : i4
      %76 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%75) : (i4) -> i1
      %77 = comb.and %74, %76 : i1
      cf.cond_br %77, ^bb2, ^bb9
    ^bb2:  // pred: ^bb1
      llhd.drv %rvalid_o, %true after %1 : i1
      %78 = llhd.prb %addr_collision_q : i4
      %79 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%78) : (i4) -> i1
      cf.cond_br %79, ^bb3(%c0_i32 : i32), ^bb8
    ^bb3(%80: i32):  // 2 preds: ^bb2, ^bb7
      %81 = comb.icmp slt %80, %c39_i32 : i32
      cf.cond_br %81, ^bb4, ^bb9
    ^bb4:  // pred: ^bb3
      %82 = llhd.prb %wmask_q : i39
      %83 = comb.concat %c0_i7, %80 : i7, i32
      %84 = comb.shru %82, %83 : i39
      %85 = comb.extract %84 from 0 : (i39) -> i1
      cf.cond_br %85, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      %86 = comb.extract %80 from 6 : (i32) -> i26
      %87 = comb.icmp eq %86, %c0_i26 : i26
      %88 = comb.extract %80 from 0 : (i32) -> i6
      %89 = comb.mux %87, %88, %c-1_i6 : i6
      %90 = llhd.sig.extract %rdata_o from %89 : <i39> -> <i1>
      %91 = llhd.prb %wdata_q : i39
      %92 = comb.shru %91, %83 : i39
      %93 = comb.extract %92 from 0 : (i39) -> i1
      llhd.drv %90, %93 after %1 : i1
      cf.br ^bb7
    ^bb6:  // pred: ^bb4
      %94 = comb.extract %80 from 6 : (i32) -> i26
      %95 = comb.icmp eq %94, %c0_i26 : i26
      %96 = comb.extract %80 from 0 : (i32) -> i6
      %97 = comb.mux %95, %96, %c-1_i6 : i6
      %98 = llhd.sig.extract %rdata_o from %97 : <i39> -> <i1>
      %99 = llhd.prb %rdata : i39
      %100 = comb.shru %99, %83 : i39
      %101 = comb.extract %100 from 0 : (i39) -> i1
      llhd.drv %98, %101 after %1 : i1
      cf.br ^bb7
    ^bb7:  // 2 preds: ^bb5, ^bb6
      %102 = comb.add %80, %c1_i32 : i32
      cf.br ^bb3(%102 : i32)
    ^bb8:  // pred: ^bb2
      %103 = llhd.prb %rdata : i39
      llhd.drv %rdata_o, %103 after %1 : i39
      cf.br ^bb9
    ^bb9:  // 3 preds: ^bb1, ^bb3, ^bb8
      llhd.wait (%61, %62, %63, %64, %41, %9, %51, %65 : i39, i1, i1, i4, i4, i39, i39, i39), ^bb1
    }
    %66 = func.call @"prim_mubi_pkg::mubi4_test_invalid"(%u_write_en_flop.q_o) : (i4) -> i1
    %67 = func.call @"prim_mubi_pkg::mubi4_test_invalid"(%41) : (i4) -> i1
    %68 = func.call @"prim_mubi_pkg::mubi4_test_invalid"(%20) : (i4) -> i1
    %69 = func.call @"prim_mubi_pkg::mubi4_test_invalid"(%64) : (i4) -> i1
    %70 = comb.or %66, %67, %68, %69, %u_prim_ram_1p_adv.alert_o : i1
    %71 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%u_read_en_buf.out_o) : (i4) -> i1
    llhd.drv %read_en_b, %71 after %1 : i1
    %72 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%u_write_en_d_buf.out_o) : (i4) -> i1
    llhd.drv %write_en_b, %72 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb9, ^bb10
      %73 = llhd.prb %clk_i_0 : i1
      %74 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %75 = llhd.prb %clk_i_0 : i1
      %76 = comb.xor bin %73, %true : i1
      %77 = comb.and bin %76, %75 : i1
      %78 = llhd.prb %rst_ni_1 : i1
      %79 = comb.xor bin %78, %true : i1
      %80 = comb.and bin %74, %79 : i1
      %81 = comb.or bin %77, %80 : i1
      cf.cond_br %81, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %82 = llhd.prb %rst_ni_1 : i1
      %83 = comb.xor %82, %true : i1
      cf.cond_br %83, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %intg_error_r_q, %false after %0 : i1
      llhd.drv %intg_error_w_q, %false after %0 : i1
      llhd.drv %raddr_q, %c0_i10 after %0 : i10
      llhd.drv %waddr_scr_q, %c0_i10 after %0 : i10
      llhd.drv %wmask_q, %c0_i39 after %0 : i39
      llhd.drv %wdata_q, %c0_i39 after %0 : i39
      llhd.drv %wdata_scr_q, %c0_i39 after %0 : i39
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %84 = llhd.prb %intg_error_buf : i1
      llhd.drv %intg_error_r_q, %84 after %0 : i1
      %85 = llhd.prb %read_en_b : i1
      cf.cond_br %85, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %86 = llhd.prb %addr_i_2 : i10
      llhd.drv %raddr_q, %86 after %0 : i10
      cf.br ^bb7
    ^bb7:  // 2 preds: ^bb5, ^bb6
      %87 = llhd.prb %write_en_b : i1
      cf.cond_br %87, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %88 = llhd.prb %addr_scr : i10
      llhd.drv %waddr_scr_q, %88 after %0 : i10
      %89 = llhd.prb %wmask_i_4 : i39
      llhd.drv %wmask_q, %89 after %0 : i39
      %90 = llhd.prb %wdata_i_3 : i39
      llhd.drv %wdata_q, %90 after %0 : i39
      %91 = llhd.prb %intg_error_buf : i1
      llhd.drv %intg_error_w_q, %91 after %0 : i1
      cf.br ^bb9
    ^bb9:  // 2 preds: ^bb7, ^bb8
      %92 = llhd.prb %rw_collision : i1
      cf.cond_br %92, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      %93 = llhd.prb %wdata_scr_d : i39
      llhd.drv %wdata_scr_q, %93 after %0 : i39
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %addr_i_2, %addr_i after %1 : i10
    llhd.drv %wdata_i_3, %wdata_i after %1 : i39
    llhd.drv %wmask_i_4, %wmask_i after %1 : i39
    hw.output %10, %61, %62, %u_prim_ram_1p_adv.rerror_o, %46, %u_prim_ram_1p_adv.cfg_rsp_o, %42, %40, %70 : i1, i39, i1, i2, i10, !hw.array<1xstruct<done: i1>>, i1, i1, i1
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
    %u_err_en_sync.lc_en_o = hw.instance "u_err_en_sync" @prim_lc_sync_11(clk_i: %6: i1, rst_ni: %7: i1, lc_en_i: %8: i4) -> (lc_en_o: !hw.array<2xi4>) {sv.namehint = "err_en_buf"}
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
    %gen_lc_gating_muxes_0.u_prim_blanker_d2h.out_o = hw.instance "gen_lc_gating_muxes_0.u_prim_blanker_d2h" @prim_blanker_12(in_i: %20: i66, en_i: %18: i1) -> (out_o: i66)
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
    %gen_lc_gating_muxes_1.u_prim_blanker_d2h.out_o = hw.instance "gen_lc_gating_muxes_1.u_prim_blanker_d2h" @prim_blanker_12(in_i: %31: i66, en_i: %29: i1) -> (out_o: i66)
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
  hw.module private @sram_ctrl_regs_reg_top(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out reg2hw : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, status: !hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>, exec: !hw.struct<q: i4>, ctrl: !hw.struct<init: !hw.struct<q: i1, qe: i1>, renew_scr_key: !hw.struct<q: i1, qe: i1>>, readback: !hw.struct<q: i4>>, in %hw2reg : !hw.struct<status: !hw.struct<sram_alert: !hw.struct<d: i1, de: i1>, readback_error: !hw.struct<d: i1, de: i1>, init_done: !hw.struct<d: i1, de: i1>, scr_key_seed_valid: !hw.struct<d: i1, de: i1>, scr_key_valid: !hw.struct<d: i1, de: i1>, escalated: !hw.struct<d: i1, de: i1>, init_error: !hw.struct<d: i1, de: i1>, bus_integ_error: !hw.struct<d: i1, de: i1>>, scr_key_rotated: !hw.struct<d: i4, de: i1>>, in %racl_policies_i : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, out racl_error_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, out intg_err_o : i1) {
    %c7_i5 = hw.constant 7 : i5
    %c6_i5 = hw.constant 6 : i5
    %c5_i5 = hw.constant 5 : i5
    %c4_i5 = hw.constant 4 : i5
    %c3_i5 = hw.constant 3 : i5
    %c2_i5 = hw.constant 2 : i5
    %c1_i5 = hw.constant 1 : i5
    %c0_i5 = hw.constant 0 : i5
    %c0_i26 = hw.constant 0 : i26
    %c-8_i4 = hw.constant -8 : i4
    %c7_i4 = hw.constant 7 : i4
    %c6_i4 = hw.constant 6 : i4
    %c5_i4 = hw.constant 5 : i4
    %c4_i4 = hw.constant 4 : i4
    %c3_i4 = hw.constant 3 : i4
    %c2_i4 = hw.constant 2 : i4
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i2 = hw.constant -1 : i2
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [false, false, false, false, false, 0 : i32] : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %3 = hw.aggregate_constant [[0 : i2, 0 : i2]] : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    %4 = hw.aggregate_constant [[false, false], [[false], [false], [false], [false], [false], [false], [false]], [0 : i4], [[false, false], [false, false]], [0 : i4]] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, status: !hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>, exec: !hw.struct<q: i4>, ctrl: !hw.struct<init: !hw.struct<q: i1, qe: i1>, renew_scr_key: !hw.struct<q: i1, qe: i1>>, readback: !hw.struct<q: i4>>
    %c-1_i32 = hw.constant -1 : i32
    %c0_i32 = hw.constant 0 : i32
    %c1_i4 = hw.constant 1 : i4
    %false = hw.constant false {sv.namehint = "racl_role"}
    %c-32_i6 = hw.constant -32 : i6
    %c28_i6 = hw.constant 28 : i6
    %c24_i6 = hw.constant 24 : i6
    %c20_i6 = hw.constant 20 : i6
    %c16_i6 = hw.constant 16 : i6
    %c12_i6 = hw.constant 12 : i6
    %c8_i6 = hw.constant 8 : i6
    %c4_i6 = hw.constant 4 : i6
    %c0_i6 = hw.constant 0 : i6
    %c0_i9 = hw.constant 0 : i9
    %c0_i2 = hw.constant 0 : i2
    %true = hw.constant true
    %c0_i4 = hw.constant 0 : i4
    %c-7_i4 = hw.constant -7 : i4
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %5 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %6 = llhd.prb %rst_ni_1 : i1
    %reg2hw = llhd.sig %4 : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, status: !hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>, exec: !hw.struct<q: i4>, ctrl: !hw.struct<init: !hw.struct<q: i1, qe: i1>, renew_scr_key: !hw.struct<q: i1, qe: i1>>, readback: !hw.struct<q: i4>>
    %racl_policies_i_2 = llhd.sig name "racl_policies_i" %3 : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    %racl_error_o = llhd.sig %2 : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %reg_we = llhd.sig %false : i1
    %reg_addr = llhd.sig %c0_i6 : i6
    %reg_be = llhd.sig %c0_i4 : i4
    %wr_err = llhd.sig %false : i1
    %reg_rdata_next = llhd.sig %c0_i32 : i32
    %intg_err = llhd.sig %false : i1
    %reg_we_err = llhd.sig %false : i1
    %reg_we_check = llhd.sig %c0_i9 : i9
    %err_q = llhd.sig %false : i1
    %alert_test_we = llhd.sig %false : i1
    %status_bus_integ_error_qs = llhd.sig %false : i1
    %status_init_error_qs = llhd.sig %false : i1
    %status_escalated_qs = llhd.sig %false : i1
    %status_scr_key_valid_qs = llhd.sig %false : i1
    %status_scr_key_seed_valid_qs = llhd.sig %false : i1
    %status_init_done_qs = llhd.sig %false : i1
    %status_readback_error_qs = llhd.sig %false : i1
    %status_sram_alert_qs = llhd.sig %false : i1
    %exec_regwen_we = llhd.sig %false : i1
    %exec_regwen_qs = llhd.sig %false : i1
    %exec_qs = llhd.sig %c0_i4 : i4
    %ctrl_regwen_we = llhd.sig %false : i1
    %ctrl_regwen_qs = llhd.sig %false : i1
    %scr_key_rotated_we = llhd.sig %false : i1
    %scr_key_rotated_qs = llhd.sig %c0_i4 : i4
    %readback_regwen_we = llhd.sig %false : i1
    %readback_regwen_qs = llhd.sig %false : i1
    %readback_qs = llhd.sig %c0_i4 : i4
    %alert_test_flds_we = llhd.sig %false : i1
    %exec_gated_we = llhd.sig %false : i1
    %ctrl_flds_we = llhd.sig %c0_i2 : i2
    %ctrl_gated_we = llhd.sig %false : i1
    %readback_gated_we = llhd.sig %false : i1
    %addr_hit = llhd.sig %c0_i9 : i9
    %racl_role_vec = llhd.sig %c0_i2 : i2
    %racl_addr_hit_read = llhd.sig %c0_i9 : i9
    %racl_addr_hit_write = llhd.sig %c0_i9 : i9
    %u_chk.err_o = hw.instance "u_chk" @tlul_cmd_intg_chk(tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> (err_o: i1)
    llhd.drv %intg_err, %u_chk.err_o after %1 : i1
    %7 = llhd.prb %reg_we_check : i9
    %8 = llhd.prb %reg_we : i1
    %9 = comb.xor %76, %true : i1
    %10 = comb.and %8, %9 : i1
    %u_prim_reg_we_check.err_o = hw.instance "u_prim_reg_we_check" @prim_reg_we_check(clk_i: %5: i1, rst_ni: %6: i1, oh_i: %7: i9, en_i: %10: i1) -> (err_o: i1)
    llhd.drv %reg_we_err, %u_prim_reg_we_check.err_o after %1 : i1
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen(tl_i: %u_reg_if.tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
    %11 = llhd.prb %racl_error_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %u_reg_if.tl_o, %u_reg_if.intg_error_o, %u_reg_if.re_o, %u_reg_if.we_o, %u_reg_if.addr_o, %u_reg_if.wdata_o, %u_reg_if.be_o = hw.instance "u_reg_if" @tlul_adapter_reg(clk_i: %5: i1, rst_ni: %6: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, en_ifetch_i: %c-7_i4: i4, busy_i: %false: i1, rdata_i: %54: i32, error_i: %56: i1) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, intg_error_o: i1, re_o: i1, we_o: i1, addr_o: i6, wdata_o: i32, be_o: i4) {sv.namehint = "reg_re"}
    llhd.drv %reg_we, %u_reg_if.we_o after %1 : i1
    llhd.drv %reg_addr, %u_reg_if.addr_o after %1 : i6
    llhd.drv %reg_be, %u_reg_if.be_o after %1 : i4
    %12 = llhd.prb %alert_test_we : i1
    %13 = llhd.sig.struct_extract %reg2hw["alert_test"] : <!hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, status: !hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>, exec: !hw.struct<q: i4>, ctrl: !hw.struct<init: !hw.struct<q: i1, qe: i1>, renew_scr_key: !hw.struct<q: i1, qe: i1>>, readback: !hw.struct<q: i4>>>
    %14 = llhd.sig.struct_extract %13["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_alert_test.qe, %u_alert_test.qre, %u_alert_test.q, %u_alert_test.ds, %u_alert_test.qs = hw.instance "u_alert_test" @prim_subreg_ext(re: %false: i1, we: %12: i1, wd: %94: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %alert_test_flds_we, %u_alert_test.qe after %1 : i1
    llhd.drv %14, %u_alert_test.q after %1 : i1
    %status = hw.struct_extract %hw2reg["status"] : !hw.struct<status: !hw.struct<sram_alert: !hw.struct<d: i1, de: i1>, readback_error: !hw.struct<d: i1, de: i1>, init_done: !hw.struct<d: i1, de: i1>, scr_key_seed_valid: !hw.struct<d: i1, de: i1>, scr_key_valid: !hw.struct<d: i1, de: i1>, escalated: !hw.struct<d: i1, de: i1>, init_error: !hw.struct<d: i1, de: i1>, bus_integ_error: !hw.struct<d: i1, de: i1>>, scr_key_rotated: !hw.struct<d: i4, de: i1>>
    %bus_integ_error = hw.struct_extract %status["bus_integ_error"] : !hw.struct<sram_alert: !hw.struct<d: i1, de: i1>, readback_error: !hw.struct<d: i1, de: i1>, init_done: !hw.struct<d: i1, de: i1>, scr_key_seed_valid: !hw.struct<d: i1, de: i1>, scr_key_valid: !hw.struct<d: i1, de: i1>, escalated: !hw.struct<d: i1, de: i1>, init_error: !hw.struct<d: i1, de: i1>, bus_integ_error: !hw.struct<d: i1, de: i1>>
    %de = hw.struct_extract %bus_integ_error["de"] : !hw.struct<d: i1, de: i1>
    %d = hw.struct_extract %bus_integ_error["d"] : !hw.struct<d: i1, de: i1>
    %15 = llhd.sig.struct_extract %reg2hw["status"] : <!hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, status: !hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>, exec: !hw.struct<q: i4>, ctrl: !hw.struct<init: !hw.struct<q: i1, qe: i1>, renew_scr_key: !hw.struct<q: i1, qe: i1>>, readback: !hw.struct<q: i4>>>
    %16 = llhd.sig.struct_extract %15["bus_integ_error"] : <!hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>>
    %17 = llhd.sig.struct_extract %16["q"] : <!hw.struct<q: i1>>
    %u_status_bus_integ_error.qe, %u_status_bus_integ_error.q, %u_status_bus_integ_error.ds, %u_status_bus_integ_error.qs = hw.instance "u_status_bus_integ_error" @prim_subreg(clk_i: %5: i1, rst_ni: %6: i1, we: %false: i1, wd: %false: i1, de: %de: i1, d: %d: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %17, %u_status_bus_integ_error.q after %1 : i1
    llhd.drv %status_bus_integ_error_qs, %u_status_bus_integ_error.qs after %1 : i1
    %init_error = hw.struct_extract %status["init_error"] : !hw.struct<sram_alert: !hw.struct<d: i1, de: i1>, readback_error: !hw.struct<d: i1, de: i1>, init_done: !hw.struct<d: i1, de: i1>, scr_key_seed_valid: !hw.struct<d: i1, de: i1>, scr_key_valid: !hw.struct<d: i1, de: i1>, escalated: !hw.struct<d: i1, de: i1>, init_error: !hw.struct<d: i1, de: i1>, bus_integ_error: !hw.struct<d: i1, de: i1>>
    %de_3 = hw.struct_extract %init_error["de"] : !hw.struct<d: i1, de: i1>
    %d_4 = hw.struct_extract %init_error["d"] : !hw.struct<d: i1, de: i1>
    %18 = llhd.sig.struct_extract %15["init_error"] : <!hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>>
    %19 = llhd.sig.struct_extract %18["q"] : <!hw.struct<q: i1>>
    %u_status_init_error.qe, %u_status_init_error.q, %u_status_init_error.ds, %u_status_init_error.qs = hw.instance "u_status_init_error" @prim_subreg(clk_i: %5: i1, rst_ni: %6: i1, we: %false: i1, wd: %false: i1, de: %de_3: i1, d: %d_4: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %19, %u_status_init_error.q after %1 : i1
    llhd.drv %status_init_error_qs, %u_status_init_error.qs after %1 : i1
    %escalated = hw.struct_extract %status["escalated"] : !hw.struct<sram_alert: !hw.struct<d: i1, de: i1>, readback_error: !hw.struct<d: i1, de: i1>, init_done: !hw.struct<d: i1, de: i1>, scr_key_seed_valid: !hw.struct<d: i1, de: i1>, scr_key_valid: !hw.struct<d: i1, de: i1>, escalated: !hw.struct<d: i1, de: i1>, init_error: !hw.struct<d: i1, de: i1>, bus_integ_error: !hw.struct<d: i1, de: i1>>
    %de_5 = hw.struct_extract %escalated["de"] : !hw.struct<d: i1, de: i1>
    %d_6 = hw.struct_extract %escalated["d"] : !hw.struct<d: i1, de: i1>
    %20 = llhd.sig.struct_extract %15["escalated"] : <!hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>>
    %21 = llhd.sig.struct_extract %20["q"] : <!hw.struct<q: i1>>
    %u_status_escalated.qe, %u_status_escalated.q, %u_status_escalated.ds, %u_status_escalated.qs = hw.instance "u_status_escalated" @prim_subreg(clk_i: %5: i1, rst_ni: %6: i1, we: %false: i1, wd: %false: i1, de: %de_5: i1, d: %d_6: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %21, %u_status_escalated.q after %1 : i1
    llhd.drv %status_escalated_qs, %u_status_escalated.qs after %1 : i1
    %scr_key_valid = hw.struct_extract %status["scr_key_valid"] : !hw.struct<sram_alert: !hw.struct<d: i1, de: i1>, readback_error: !hw.struct<d: i1, de: i1>, init_done: !hw.struct<d: i1, de: i1>, scr_key_seed_valid: !hw.struct<d: i1, de: i1>, scr_key_valid: !hw.struct<d: i1, de: i1>, escalated: !hw.struct<d: i1, de: i1>, init_error: !hw.struct<d: i1, de: i1>, bus_integ_error: !hw.struct<d: i1, de: i1>>
    %de_7 = hw.struct_extract %scr_key_valid["de"] : !hw.struct<d: i1, de: i1>
    %d_8 = hw.struct_extract %scr_key_valid["d"] : !hw.struct<d: i1, de: i1>
    %u_status_scr_key_valid.qe, %u_status_scr_key_valid.q, %u_status_scr_key_valid.ds, %u_status_scr_key_valid.qs = hw.instance "u_status_scr_key_valid" @prim_subreg(clk_i: %5: i1, rst_ni: %6: i1, we: %false: i1, wd: %false: i1, de: %de_7: i1, d: %d_8: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_scr_key_valid_qs, %u_status_scr_key_valid.qs after %1 : i1
    %scr_key_seed_valid = hw.struct_extract %status["scr_key_seed_valid"] : !hw.struct<sram_alert: !hw.struct<d: i1, de: i1>, readback_error: !hw.struct<d: i1, de: i1>, init_done: !hw.struct<d: i1, de: i1>, scr_key_seed_valid: !hw.struct<d: i1, de: i1>, scr_key_valid: !hw.struct<d: i1, de: i1>, escalated: !hw.struct<d: i1, de: i1>, init_error: !hw.struct<d: i1, de: i1>, bus_integ_error: !hw.struct<d: i1, de: i1>>
    %de_9 = hw.struct_extract %scr_key_seed_valid["de"] : !hw.struct<d: i1, de: i1>
    %d_10 = hw.struct_extract %scr_key_seed_valid["d"] : !hw.struct<d: i1, de: i1>
    %22 = llhd.sig.struct_extract %15["scr_key_seed_valid"] : <!hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>>
    %23 = llhd.sig.struct_extract %22["q"] : <!hw.struct<q: i1>>
    %u_status_scr_key_seed_valid.qe, %u_status_scr_key_seed_valid.q, %u_status_scr_key_seed_valid.ds, %u_status_scr_key_seed_valid.qs = hw.instance "u_status_scr_key_seed_valid" @prim_subreg(clk_i: %5: i1, rst_ni: %6: i1, we: %false: i1, wd: %false: i1, de: %de_9: i1, d: %d_10: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %23, %u_status_scr_key_seed_valid.q after %1 : i1
    llhd.drv %status_scr_key_seed_valid_qs, %u_status_scr_key_seed_valid.qs after %1 : i1
    %init_done = hw.struct_extract %status["init_done"] : !hw.struct<sram_alert: !hw.struct<d: i1, de: i1>, readback_error: !hw.struct<d: i1, de: i1>, init_done: !hw.struct<d: i1, de: i1>, scr_key_seed_valid: !hw.struct<d: i1, de: i1>, scr_key_valid: !hw.struct<d: i1, de: i1>, escalated: !hw.struct<d: i1, de: i1>, init_error: !hw.struct<d: i1, de: i1>, bus_integ_error: !hw.struct<d: i1, de: i1>>
    %de_11 = hw.struct_extract %init_done["de"] : !hw.struct<d: i1, de: i1>
    %d_12 = hw.struct_extract %init_done["d"] : !hw.struct<d: i1, de: i1>
    %24 = llhd.sig.struct_extract %15["init_done"] : <!hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>>
    %25 = llhd.sig.struct_extract %24["q"] : <!hw.struct<q: i1>>
    %u_status_init_done.qe, %u_status_init_done.q, %u_status_init_done.ds, %u_status_init_done.qs = hw.instance "u_status_init_done" @prim_subreg(clk_i: %5: i1, rst_ni: %6: i1, we: %false: i1, wd: %false: i1, de: %de_11: i1, d: %d_12: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %25, %u_status_init_done.q after %1 : i1
    llhd.drv %status_init_done_qs, %u_status_init_done.qs after %1 : i1
    %readback_error = hw.struct_extract %status["readback_error"] : !hw.struct<sram_alert: !hw.struct<d: i1, de: i1>, readback_error: !hw.struct<d: i1, de: i1>, init_done: !hw.struct<d: i1, de: i1>, scr_key_seed_valid: !hw.struct<d: i1, de: i1>, scr_key_valid: !hw.struct<d: i1, de: i1>, escalated: !hw.struct<d: i1, de: i1>, init_error: !hw.struct<d: i1, de: i1>, bus_integ_error: !hw.struct<d: i1, de: i1>>
    %de_13 = hw.struct_extract %readback_error["de"] : !hw.struct<d: i1, de: i1>
    %d_14 = hw.struct_extract %readback_error["d"] : !hw.struct<d: i1, de: i1>
    %26 = llhd.sig.struct_extract %15["readback_error"] : <!hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>>
    %27 = llhd.sig.struct_extract %26["q"] : <!hw.struct<q: i1>>
    %u_status_readback_error.qe, %u_status_readback_error.q, %u_status_readback_error.ds, %u_status_readback_error.qs = hw.instance "u_status_readback_error" @prim_subreg(clk_i: %5: i1, rst_ni: %6: i1, we: %false: i1, wd: %false: i1, de: %de_13: i1, d: %d_14: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %27, %u_status_readback_error.q after %1 : i1
    llhd.drv %status_readback_error_qs, %u_status_readback_error.qs after %1 : i1
    %sram_alert = hw.struct_extract %status["sram_alert"] : !hw.struct<sram_alert: !hw.struct<d: i1, de: i1>, readback_error: !hw.struct<d: i1, de: i1>, init_done: !hw.struct<d: i1, de: i1>, scr_key_seed_valid: !hw.struct<d: i1, de: i1>, scr_key_valid: !hw.struct<d: i1, de: i1>, escalated: !hw.struct<d: i1, de: i1>, init_error: !hw.struct<d: i1, de: i1>, bus_integ_error: !hw.struct<d: i1, de: i1>>
    %de_15 = hw.struct_extract %sram_alert["de"] : !hw.struct<d: i1, de: i1>
    %d_16 = hw.struct_extract %sram_alert["d"] : !hw.struct<d: i1, de: i1>
    %28 = llhd.sig.struct_extract %15["sram_alert"] : <!hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>>
    %29 = llhd.sig.struct_extract %28["q"] : <!hw.struct<q: i1>>
    %u_status_sram_alert.qe, %u_status_sram_alert.q, %u_status_sram_alert.ds, %u_status_sram_alert.qs = hw.instance "u_status_sram_alert" @prim_subreg(clk_i: %5: i1, rst_ni: %6: i1, we: %false: i1, wd: %false: i1, de: %de_15: i1, d: %d_16: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %29, %u_status_sram_alert.q after %1 : i1
    llhd.drv %status_sram_alert_qs, %u_status_sram_alert.qs after %1 : i1
    %30 = llhd.prb %exec_regwen_we : i1
    %u_exec_regwen.qe, %u_exec_regwen.q, %u_exec_regwen.ds, %u_exec_regwen.qs = hw.instance "u_exec_regwen" @prim_subreg_1(clk_i: %5: i1, rst_ni: %6: i1, we: %30: i1, wd: %94: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %exec_regwen_qs, %u_exec_regwen.qs after %1 : i1
    %31 = llhd.prb %exec_gated_we : i1
    %32 = llhd.sig.struct_extract %reg2hw["exec"] : <!hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, status: !hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>, exec: !hw.struct<q: i4>, ctrl: !hw.struct<init: !hw.struct<q: i1, qe: i1>, renew_scr_key: !hw.struct<q: i1, qe: i1>>, readback: !hw.struct<q: i4>>>
    %33 = llhd.sig.struct_extract %32["q"] : <!hw.struct<q: i4>>
    %u_exec.qe, %u_exec.q, %u_exec.ds, %u_exec.qs = hw.instance "u_exec" @prim_subreg_2(clk_i: %5: i1, rst_ni: %6: i1, we: %31: i1, wd: %98: i4, de: %false: i1, d: %c0_i4: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %33, %u_exec.q after %1 : i4
    llhd.drv %exec_qs, %u_exec.qs after %1 : i4
    %34 = llhd.prb %ctrl_regwen_we : i1
    %u_ctrl_regwen.qe, %u_ctrl_regwen.q, %u_ctrl_regwen.ds, %u_ctrl_regwen.qs = hw.instance "u_ctrl_regwen" @prim_subreg_1(clk_i: %5: i1, rst_ni: %6: i1, we: %34: i1, wd: %94: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %ctrl_regwen_qs, %u_ctrl_regwen.qs after %1 : i1
    %35 = llhd.prb %ctrl_flds_we : i2
    %36 = comb.icmp eq %35, %c-1_i2 : i2
    %u_ctrl0_qe.q_o = hw.instance "u_ctrl0_qe" @prim_flop(clk_i: %5: i1, rst_ni: %6: i1, d_i: %36: i1) -> (q_o: i1) {sv.namehint = "ctrl_qe"}
    %37 = llhd.prb %ctrl_gated_we : i1
    %38 = llhd.sig.extract %ctrl_flds_we from %false : <i2> -> <i1>
    %39 = llhd.sig.struct_extract %reg2hw["ctrl"] : <!hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, status: !hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>, exec: !hw.struct<q: i4>, ctrl: !hw.struct<init: !hw.struct<q: i1, qe: i1>, renew_scr_key: !hw.struct<q: i1, qe: i1>>, readback: !hw.struct<q: i4>>>
    %40 = llhd.sig.struct_extract %39["renew_scr_key"] : <!hw.struct<init: !hw.struct<q: i1, qe: i1>, renew_scr_key: !hw.struct<q: i1, qe: i1>>>
    %41 = llhd.sig.struct_extract %40["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_ctrl_renew_scr_key.qe, %u_ctrl_renew_scr_key.q, %u_ctrl_renew_scr_key.ds, %u_ctrl_renew_scr_key.qs = hw.instance "u_ctrl_renew_scr_key" @prim_subreg_3(clk_i: %5: i1, rst_ni: %6: i1, we: %37: i1, wd: %94: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %38, %u_ctrl_renew_scr_key.qe after %1 : i1
    llhd.drv %41, %u_ctrl_renew_scr_key.q after %1 : i1
    %42 = llhd.sig.extract %ctrl_flds_we from %true : <i2> -> <i1>
    %43 = llhd.sig.struct_extract %39["init"] : <!hw.struct<init: !hw.struct<q: i1, qe: i1>, renew_scr_key: !hw.struct<q: i1, qe: i1>>>
    %44 = llhd.sig.struct_extract %43["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_ctrl_init.qe, %u_ctrl_init.q, %u_ctrl_init.ds, %u_ctrl_init.qs = hw.instance "u_ctrl_init" @prim_subreg_3(clk_i: %5: i1, rst_ni: %6: i1, we: %37: i1, wd: %102: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %42, %u_ctrl_init.qe after %1 : i1
    llhd.drv %44, %u_ctrl_init.q after %1 : i1
    %45 = llhd.prb %scr_key_rotated_we : i1
    %scr_key_rotated = hw.struct_extract %hw2reg["scr_key_rotated"] : !hw.struct<status: !hw.struct<sram_alert: !hw.struct<d: i1, de: i1>, readback_error: !hw.struct<d: i1, de: i1>, init_done: !hw.struct<d: i1, de: i1>, scr_key_seed_valid: !hw.struct<d: i1, de: i1>, scr_key_valid: !hw.struct<d: i1, de: i1>, escalated: !hw.struct<d: i1, de: i1>, init_error: !hw.struct<d: i1, de: i1>, bus_integ_error: !hw.struct<d: i1, de: i1>>, scr_key_rotated: !hw.struct<d: i4, de: i1>>
    %de_17 = hw.struct_extract %scr_key_rotated["de"] : !hw.struct<d: i4, de: i1>
    %d_18 = hw.struct_extract %scr_key_rotated["d"] : !hw.struct<d: i4, de: i1>
    %u_scr_key_rotated.qe, %u_scr_key_rotated.q, %u_scr_key_rotated.ds, %u_scr_key_rotated.qs = hw.instance "u_scr_key_rotated" @prim_subreg_4(clk_i: %5: i1, rst_ni: %6: i1, we: %45: i1, wd: %98: i4, de: %de_17: i1, d: %d_18: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %scr_key_rotated_qs, %u_scr_key_rotated.qs after %1 : i4
    %46 = llhd.prb %readback_regwen_we : i1
    %u_readback_regwen.qe, %u_readback_regwen.q, %u_readback_regwen.ds, %u_readback_regwen.qs = hw.instance "u_readback_regwen" @prim_subreg_1(clk_i: %5: i1, rst_ni: %6: i1, we: %46: i1, wd: %94: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %readback_regwen_qs, %u_readback_regwen.qs after %1 : i1
    %47 = llhd.prb %readback_gated_we : i1
    %48 = llhd.sig.struct_extract %reg2hw["readback"] : <!hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, status: !hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>, exec: !hw.struct<q: i4>, ctrl: !hw.struct<init: !hw.struct<q: i1, qe: i1>, renew_scr_key: !hw.struct<q: i1, qe: i1>>, readback: !hw.struct<q: i4>>>
    %49 = llhd.sig.struct_extract %48["q"] : <!hw.struct<q: i4>>
    %u_readback.qe, %u_readback.q, %u_readback.ds, %u_readback.qs = hw.instance "u_readback" @prim_subreg_2(clk_i: %5: i1, rst_ni: %6: i1, we: %47: i1, wd: %98: i4, de: %false: i1, d: %c0_i4: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %49, %u_readback.q after %1 : i4
    llhd.drv %readback_qs, %u_readback.qs after %1 : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %120 = llhd.prb %clk_i_0 : i1
      %121 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%5, %6 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %122 = llhd.prb %clk_i_0 : i1
      %123 = comb.xor bin %120, %true : i1
      %124 = comb.and bin %123, %122 : i1
      %125 = llhd.prb %rst_ni_1 : i1
      %126 = comb.xor bin %125, %true : i1
      %127 = comb.and bin %121, %126 : i1
      %128 = comb.or bin %124, %127 : i1
      cf.cond_br %128, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %129 = llhd.prb %rst_ni_1 : i1
      %130 = comb.xor %129, %true : i1
      cf.cond_br %130, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %err_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %131 = llhd.prb %intg_err : i1
      %132 = llhd.prb %reg_we_err : i1
      %133 = comb.or %131, %132 : i1
      cf.cond_br %133, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %err_q, %true after %0 : i1
      cf.br ^bb1
    }
    %50 = llhd.prb %err_q : i1
    %51 = llhd.prb %intg_err : i1
    %52 = llhd.prb %reg_we_err : i1
    %53 = comb.or %50, %51, %52 : i1
    %54 = llhd.prb %reg_rdata_next {sv.namehint = "reg_rdata"} : i32
    %55 = llhd.prb %wr_err : i1
    %56 = comb.or %76, %55, %51 {sv.namehint = "reg_error"} : i1
    %57 = llhd.prb %alert_test_flds_we {sv.namehint = "alert_test_qe"} : i1
    %58 = llhd.sig.struct_extract %13["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %58, %57 after %1 : i1
    %59 = llhd.prb %exec_regwen_qs : i1
    %60 = comb.and %97, %8, %92, %59 : i1
    llhd.drv %exec_gated_we, %60 after %1 : i1
    %61 = llhd.prb %ctrl_regwen_qs : i1
    %62 = comb.and %101, %8, %92, %61 : i1
    llhd.drv %ctrl_gated_we, %62 after %1 : i1
    %63 = llhd.sig.struct_extract %40["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %63, %u_ctrl0_qe.q_o after %1 : i1
    %64 = llhd.sig.struct_extract %43["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %64, %u_ctrl0_qe.q_o after %1 : i1
    %65 = llhd.prb %readback_regwen_qs : i1
    %66 = comb.and %107, %8, %92, %65 : i1
    llhd.drv %readback_gated_we, %66 after %1 : i1
    llhd.drv %racl_role_vec, %c0_i2 after %1 : i2
    %67 = llhd.prb %racl_addr_hit_read : i9
    %68 = llhd.prb %racl_addr_hit_write : i9
    %69 = llhd.prb %addr_hit : i9
    %70 = llhd.prb %reg_addr : i6
    %71 = llhd.prb %racl_policies_i_2 : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    %72 = llhd.prb %racl_role_vec : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %racl_addr_hit_read, %c0_i9 after %1 : i9
      llhd.drv %racl_addr_hit_write, %c0_i9 after %1 : i9
      %120 = llhd.sig.extract %addr_hit from %c0_i4 : <i9> -> <i1>
      %121 = llhd.prb %reg_addr : i6
      %122 = comb.icmp eq %121, %c0_i6 : i6
      llhd.drv %120, %122 after %1 : i1
      %123 = llhd.sig.extract %addr_hit from %c1_i4 : <i9> -> <i1>
      %124 = llhd.prb %reg_addr : i6
      %125 = comb.icmp eq %124, %c4_i6 : i6
      llhd.drv %123, %125 after %1 : i1
      %126 = llhd.sig.extract %addr_hit from %c2_i4 : <i9> -> <i1>
      %127 = llhd.prb %reg_addr : i6
      %128 = comb.icmp eq %127, %c8_i6 : i6
      llhd.drv %126, %128 after %1 : i1
      %129 = llhd.sig.extract %addr_hit from %c3_i4 : <i9> -> <i1>
      %130 = llhd.prb %reg_addr : i6
      %131 = comb.icmp eq %130, %c12_i6 : i6
      llhd.drv %129, %131 after %1 : i1
      %132 = llhd.sig.extract %addr_hit from %c4_i4 : <i9> -> <i1>
      %133 = llhd.prb %reg_addr : i6
      %134 = comb.icmp eq %133, %c16_i6 : i6
      llhd.drv %132, %134 after %1 : i1
      %135 = llhd.sig.extract %addr_hit from %c5_i4 : <i9> -> <i1>
      %136 = llhd.prb %reg_addr : i6
      %137 = comb.icmp eq %136, %c20_i6 : i6
      llhd.drv %135, %137 after %1 : i1
      %138 = llhd.sig.extract %addr_hit from %c6_i4 : <i9> -> <i1>
      %139 = llhd.prb %reg_addr : i6
      %140 = comb.icmp eq %139, %c24_i6 : i6
      llhd.drv %138, %140 after %1 : i1
      %141 = llhd.sig.extract %addr_hit from %c7_i4 : <i9> -> <i1>
      %142 = llhd.prb %reg_addr : i6
      %143 = comb.icmp eq %142, %c28_i6 : i6
      llhd.drv %141, %143 after %1 : i1
      %144 = llhd.sig.extract %addr_hit from %c-8_i4 : <i9> -> <i1>
      %145 = llhd.prb %reg_addr : i6
      %146 = comb.icmp eq %145, %c-32_i6 : i6
      llhd.drv %144, %146 after %1 : i1
      %147 = llhd.prb %addr_hit : i9
      llhd.drv %racl_addr_hit_read, %147 after %1 : i9
      %148 = llhd.prb %addr_hit : i9
      llhd.drv %racl_addr_hit_write, %148 after %1 : i9
      llhd.wait (%67, %68, %69, %70, %71, %72 : i9, i9, i9, i6, !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, i2), ^bb1
    }
    %73 = comb.or %u_reg_if.re_o, %8 : i1
    %74 = comb.icmp ne %69, %c0_i9 : i9
    %75 = comb.xor %74, %true : i1
    %76 = comb.and %73, %75 {sv.namehint = "addrmiss"} : i1
    %77 = llhd.sig.struct_extract %racl_error_o["valid"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    %78 = comb.icmp eq %67, %c0_i9 : i9
    %79 = comb.and %u_reg_if.re_o, %78 : i1
    %80 = comb.icmp eq %68, %c0_i9 : i9
    %81 = comb.and %8, %80 : i1
    %82 = comb.or %79, %81 : i1
    %83 = comb.and %74, %82 : i1
    llhd.drv %77, %83 after %1 : i1
    %84 = llhd.sig.struct_extract %racl_error_o["request_address"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    %85 = comb.concat %c0_i26, %70 : i26, i6
    llhd.drv %84, %85 after %1 : i32
    %86 = llhd.sig.struct_extract %racl_error_o["racl_role"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %86, %false after %1 : i1
    %87 = llhd.sig.struct_extract %racl_error_o["overflow"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %87, %false after %1 : i1
    %88 = llhd.sig.struct_extract %racl_error_o["ctn_uid"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %88, %false after %1 : i1
    %89 = llhd.sig.struct_extract %racl_error_o["read_access"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %89, %false after %1 : i1
    %90 = llhd.prb %reg_be : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %120 = llhd.prb %reg_we : i1
      %121 = llhd.prb %racl_addr_hit_write : i9
      %122 = comb.extract %121 from 0 : (i9) -> i1
      %123 = llhd.prb %reg_be : i4
      %124 = comb.extract %123 from 0 : (i4) -> i1
      %125 = comb.xor %124, %true : i1
      %126 = comb.and %122, %125 : i1
      %127 = comb.extract %121 from 1 : (i9) -> i1
      %128 = comb.and %127, %125 : i1
      %129 = comb.extract %121 from 2 : (i9) -> i1
      %130 = comb.and %129, %125 : i1
      %131 = comb.extract %121 from 3 : (i9) -> i1
      %132 = comb.and %131, %125 : i1
      %133 = comb.extract %121 from 4 : (i9) -> i1
      %134 = comb.and %133, %125 : i1
      %135 = comb.extract %121 from 5 : (i9) -> i1
      %136 = comb.and %135, %125 : i1
      %137 = comb.extract %121 from 6 : (i9) -> i1
      %138 = comb.and %137, %125 : i1
      %139 = comb.extract %121 from 7 : (i9) -> i1
      %140 = comb.and %139, %125 : i1
      %141 = comb.extract %121 from 8 : (i9) -> i1
      %142 = comb.and %141, %125 : i1
      %143 = comb.or %126, %128, %130, %132, %134, %136, %138, %140, %142 : i1
      %144 = comb.and %120, %143 : i1
      llhd.drv %wr_err, %144 after %1 : i1
      llhd.wait (%8, %68, %90, %55 : i1, i9, i4, i1), ^bb1
    }
    %91 = comb.extract %68 from 0 : (i9) -> i1
    %92 = comb.xor %56, %true : i1
    %93 = comb.and %91, %8, %92 : i1
    llhd.drv %alert_test_we, %93 after %1 : i1
    %94 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "alert_test_wd"} : (i32) -> i1
    %95 = comb.extract %68 from 2 : (i9) -> i1
    %96 = comb.and %95, %8, %92 : i1
    llhd.drv %exec_regwen_we, %96 after %1 : i1
    %97 = comb.extract %68 from 3 : (i9) -> i1
    %98 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "exec_wd"} : (i32) -> i4
    %99 = comb.extract %68 from 4 : (i9) -> i1
    %100 = comb.and %99, %8, %92 : i1
    llhd.drv %ctrl_regwen_we, %100 after %1 : i1
    %101 = comb.extract %68 from 5 : (i9) -> i1
    %102 = comb.extract %u_reg_if.wdata_o from 1 {sv.namehint = "ctrl_init_wd"} : (i32) -> i1
    %103 = comb.extract %68 from 6 : (i9) -> i1
    %104 = comb.and %103, %8, %92 : i1
    llhd.drv %scr_key_rotated_we, %104 after %1 : i1
    %105 = comb.extract %68 from 7 : (i9) -> i1
    %106 = comb.and %105, %8, %92 : i1
    llhd.drv %readback_regwen_we, %106 after %1 : i1
    %107 = comb.extract %68 from 8 : (i9) -> i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %120 = llhd.sig.extract %reg_we_check from %c0_i4 : <i9> -> <i1>
      %121 = llhd.prb %alert_test_we : i1
      llhd.drv %120, %121 after %1 : i1
      %122 = llhd.sig.extract %reg_we_check from %c1_i4 : <i9> -> <i1>
      llhd.drv %122, %false after %1 : i1
      %123 = llhd.sig.extract %reg_we_check from %c2_i4 : <i9> -> <i1>
      %124 = llhd.prb %exec_regwen_we : i1
      llhd.drv %123, %124 after %1 : i1
      %125 = llhd.sig.extract %reg_we_check from %c3_i4 : <i9> -> <i1>
      %126 = llhd.prb %exec_gated_we : i1
      llhd.drv %125, %126 after %1 : i1
      %127 = llhd.sig.extract %reg_we_check from %c4_i4 : <i9> -> <i1>
      %128 = llhd.prb %ctrl_regwen_we : i1
      llhd.drv %127, %128 after %1 : i1
      %129 = llhd.sig.extract %reg_we_check from %c5_i4 : <i9> -> <i1>
      %130 = llhd.prb %ctrl_gated_we : i1
      llhd.drv %129, %130 after %1 : i1
      %131 = llhd.sig.extract %reg_we_check from %c6_i4 : <i9> -> <i1>
      %132 = llhd.prb %scr_key_rotated_we : i1
      llhd.drv %131, %132 after %1 : i1
      %133 = llhd.sig.extract %reg_we_check from %c7_i4 : <i9> -> <i1>
      %134 = llhd.prb %readback_regwen_we : i1
      llhd.drv %133, %134 after %1 : i1
      %135 = llhd.sig.extract %reg_we_check from %c-8_i4 : <i9> -> <i1>
      %136 = llhd.prb %readback_gated_we : i1
      llhd.drv %135, %136 after %1 : i1
      llhd.wait (%7, %12, %30, %31, %34, %37, %45, %46, %47 : i9, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    %108 = llhd.prb %status_bus_integ_error_qs : i1
    %109 = llhd.prb %status_init_error_qs : i1
    %110 = llhd.prb %status_escalated_qs : i1
    %111 = llhd.prb %status_scr_key_valid_qs : i1
    %112 = llhd.prb %status_scr_key_seed_valid_qs : i1
    %113 = llhd.prb %status_init_done_qs : i1
    %114 = llhd.prb %status_readback_error_qs : i1
    %115 = llhd.prb %status_sram_alert_qs : i1
    %116 = llhd.prb %exec_qs : i4
    %117 = llhd.prb %scr_key_rotated_qs : i4
    %118 = llhd.prb %readback_qs : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb20
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      %120 = llhd.prb %racl_addr_hit_read : i9
      %121 = comb.extract %120 from 0 : (i9) -> i1
      %122 = comb.icmp ceq %121, %true : i1
      cf.cond_br %122, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %123 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      llhd.drv %123, %false after %1 : i1
      cf.br ^bb20
    ^bb3:  // pred: ^bb1
      %124 = llhd.prb %racl_addr_hit_read : i9
      %125 = comb.extract %124 from 1 : (i9) -> i1
      %126 = comb.icmp ceq %125, %true : i1
      cf.cond_br %126, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %127 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %128 = llhd.prb %status_bus_integ_error_qs : i1
      llhd.drv %127, %128 after %1 : i1
      %129 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %130 = llhd.prb %status_init_error_qs : i1
      llhd.drv %129, %130 after %1 : i1
      %131 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %132 = llhd.prb %status_escalated_qs : i1
      llhd.drv %131, %132 after %1 : i1
      %133 = llhd.sig.extract %reg_rdata_next from %c3_i5 : <i32> -> <i1>
      %134 = llhd.prb %status_scr_key_valid_qs : i1
      llhd.drv %133, %134 after %1 : i1
      %135 = llhd.sig.extract %reg_rdata_next from %c4_i5 : <i32> -> <i1>
      %136 = llhd.prb %status_scr_key_seed_valid_qs : i1
      llhd.drv %135, %136 after %1 : i1
      %137 = llhd.sig.extract %reg_rdata_next from %c5_i5 : <i32> -> <i1>
      %138 = llhd.prb %status_init_done_qs : i1
      llhd.drv %137, %138 after %1 : i1
      %139 = llhd.sig.extract %reg_rdata_next from %c6_i5 : <i32> -> <i1>
      %140 = llhd.prb %status_readback_error_qs : i1
      llhd.drv %139, %140 after %1 : i1
      %141 = llhd.sig.extract %reg_rdata_next from %c7_i5 : <i32> -> <i1>
      %142 = llhd.prb %status_sram_alert_qs : i1
      llhd.drv %141, %142 after %1 : i1
      cf.br ^bb20
    ^bb5:  // pred: ^bb3
      %143 = llhd.prb %racl_addr_hit_read : i9
      %144 = comb.extract %143 from 2 : (i9) -> i1
      %145 = comb.icmp ceq %144, %true : i1
      cf.cond_br %145, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %146 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %147 = llhd.prb %exec_regwen_qs : i1
      llhd.drv %146, %147 after %1 : i1
      cf.br ^bb20
    ^bb7:  // pred: ^bb5
      %148 = llhd.prb %racl_addr_hit_read : i9
      %149 = comb.extract %148 from 3 : (i9) -> i1
      %150 = comb.icmp ceq %149, %true : i1
      cf.cond_br %150, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %151 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i4>
      %152 = llhd.prb %exec_qs : i4
      llhd.drv %151, %152 after %1 : i4
      cf.br ^bb20
    ^bb9:  // pred: ^bb7
      %153 = llhd.prb %racl_addr_hit_read : i9
      %154 = comb.extract %153 from 4 : (i9) -> i1
      %155 = comb.icmp ceq %154, %true : i1
      cf.cond_br %155, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %156 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %157 = llhd.prb %ctrl_regwen_qs : i1
      llhd.drv %156, %157 after %1 : i1
      cf.br ^bb20
    ^bb11:  // pred: ^bb9
      %158 = llhd.prb %racl_addr_hit_read : i9
      %159 = comb.extract %158 from 5 : (i9) -> i1
      %160 = comb.icmp ceq %159, %true : i1
      cf.cond_br %160, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %161 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      llhd.drv %161, %false after %1 : i1
      %162 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      llhd.drv %162, %false after %1 : i1
      cf.br ^bb20
    ^bb13:  // pred: ^bb11
      %163 = llhd.prb %racl_addr_hit_read : i9
      %164 = comb.extract %163 from 6 : (i9) -> i1
      %165 = comb.icmp ceq %164, %true : i1
      cf.cond_br %165, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %166 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i4>
      %167 = llhd.prb %scr_key_rotated_qs : i4
      llhd.drv %166, %167 after %1 : i4
      cf.br ^bb20
    ^bb15:  // pred: ^bb13
      %168 = llhd.prb %racl_addr_hit_read : i9
      %169 = comb.extract %168 from 7 : (i9) -> i1
      %170 = comb.icmp ceq %169, %true : i1
      cf.cond_br %170, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      %171 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %172 = llhd.prb %readback_regwen_qs : i1
      llhd.drv %171, %172 after %1 : i1
      cf.br ^bb20
    ^bb17:  // pred: ^bb15
      %173 = llhd.prb %racl_addr_hit_read : i9
      %174 = comb.extract %173 from 8 : (i9) -> i1
      %175 = comb.icmp ceq %174, %true : i1
      cf.cond_br %175, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      %176 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i4>
      %177 = llhd.prb %readback_qs : i4
      llhd.drv %176, %177 after %1 : i4
      cf.br ^bb20
    ^bb19:  // pred: ^bb17
      llhd.drv %reg_rdata_next, %c-1_i32 after %1 : i32
      cf.br ^bb20
    ^bb20:  // 10 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb18, ^bb19
      llhd.wait (%54, %67, %108, %109, %110, %111, %112, %113, %114, %115, %59, %116, %61, %117, %65, %118 : i32, i9, i1, i1, i1, i1, i1, i1, i1, i1, i1, i4, i1, i4, i1, i4), ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    %119 = llhd.prb %reg2hw : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, status: !hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>, exec: !hw.struct<q: i4>, ctrl: !hw.struct<init: !hw.struct<q: i1, qe: i1>, renew_scr_key: !hw.struct<q: i1, qe: i1>>, readback: !hw.struct<q: i4>>
    llhd.drv %racl_policies_i_2, %racl_policies_i after %1 : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    hw.output %u_rsp_intg_gen.tl_o, %119, %11, %53 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, status: !hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>, exec: !hw.struct<q: i4>, ctrl: !hw.struct<init: !hw.struct<q: i1, qe: i1>, renew_scr_key: !hw.struct<q: i1, qe: i1>>, readback: !hw.struct<q: i4>>, !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, i1
  }
  hw.module @sram_ctrl(in %clk_i : i1, in %rst_ni : i1, in %clk_otp_i : i1, in %rst_otp_ni : i1, in %ram_tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out ram_tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %regs_tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out regs_tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %alert_rx_i : !hw.array<1xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, out alert_tx_o : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>, in %racl_policies_i : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, out racl_error_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, in %racl_policy_sel_ranges_ram_i : !hw.array<1xstruct<base: i32, limit: i32, policy_sel: i1, enable: i1>>, in %lc_escalate_en_i : i4, in %lc_hw_debug_en_i : i4, in %otp_en_sram_ifetch_i : i8, out sram_otp_key_o : !hw.struct<req: i1>, in %sram_otp_key_i : !hw.struct<ack: i1, key: i128, nonce: i128, seed_valid: i1>, in %cfg_i : !hw.array<1xstruct<ram_cfg: !hw.struct<test: i1, cfg_en: i1, cfg: i4>, rf_cfg: !hw.struct<test: i1, cfg_en: i1, cfg: i4>>>, out cfg_rsp_o : !hw.array<1xstruct<done: i1>>, out sram_rerror_o : !hw.struct<valid: i1, correctable: i1, address: i32>) {
    %0 = hw.aggregate_constant [false, false, 0 : i32] : !hw.struct<valid: i1, correctable: i1, address: i32>
    %c-1_i39 = hw.constant -1 : i39
    %c-1_i10 = hw.constant -1 : i10
    %1 = hw.aggregate_constant [false, false, false, false, false, 0 : i32] : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %c-29489338482610088529621666603445263003154697118141640604891279714348151071073_i256 = hw.constant -29489338482610088529621666603445263003154697118141640604891279714348151071073 : i256
    %2 = llhd.constant_time <0ns, 1d, 0e>
    %c1_i2 = hw.constant 1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c0_i0 = hw.constant 0 : i0
    %c0_i2 = hw.constant 0 : i2
    %3 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i39 = hw.constant 0 : i39
    %c0_i4 = hw.constant 0 : i4
    %4 = hw.aggregate_constant [[[false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false]], [0 : i4, false]] : !hw.struct<status: !hw.struct<sram_alert: !hw.struct<d: i1, de: i1>, readback_error: !hw.struct<d: i1, de: i1>, init_done: !hw.struct<d: i1, de: i1>, scr_key_seed_valid: !hw.struct<d: i1, de: i1>, scr_key_valid: !hw.struct<d: i1, de: i1>, escalated: !hw.struct<d: i1, de: i1>, init_error: !hw.struct<d: i1, de: i1>, bus_integ_error: !hw.struct<d: i1, de: i1>>, scr_key_rotated: !hw.struct<d: i4, de: i1>>
    %5 = hw.aggregate_constant [[false, false], [[false], [false], [false], [false], [false], [false], [false]], [0 : i4], [[false, false], [false, false]], [0 : i4]] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, status: !hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>, exec: !hw.struct<q: i4>, ctrl: !hw.struct<init: !hw.struct<q: i1, qe: i1>, renew_scr_key: !hw.struct<q: i1, qe: i1>>, readback: !hw.struct<q: i4>>
    %c0_i3 = hw.constant 0 : i3
    %c0_i128 = hw.constant 0 : i128
    %6 = hw.aggregate_constant [[false, false, false, false, false, 0 : i32], [false, false, false, false, false, 0 : i32]] : !hw.array<2xstruct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    %7 = hw.aggregate_constant [false] : !hw.struct<req: i1>
    %8 = hw.aggregate_constant [[false, false]] : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    %true = hw.constant true
    %c-7_i4 = hw.constant -7 : i4
    %c6_i4 = hw.constant 6 : i4
    %c0_i64 = hw.constant 0 : i64
    %c1_i10 = hw.constant 1 : i10
    %c0_i10 = hw.constant 0 : i10
    %false = hw.constant false
    %c46453349783654013486528997942361333407_i128 = hw.constant 46453349783654013486528997942361333407 : i128
    %c-86661376989486117430205222316559757455_i128 = hw.constant -86661376989486117430205222316559757455 : i128
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %9 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %10 = llhd.prb %rst_ni_1 : i1
    %alert_tx_o = llhd.sig %8 : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    %sram_otp_key_o = llhd.sig %7 : !hw.struct<req: i1>
    %racl_error = llhd.sig %6 : !hw.array<2xstruct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    %cnst_sram_key = llhd.sig %c0_i128 : i128
    %cnst_sram_nonce = llhd.sig %c0_i128 : i128
    %bus_integ_error = llhd.sig %c0_i3 : i3
    %reg2hw = llhd.sig %5 : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, status: !hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>, exec: !hw.struct<q: i4>, ctrl: !hw.struct<init: !hw.struct<q: i1, qe: i1>, renew_scr_key: !hw.struct<q: i1, qe: i1>>, readback: !hw.struct<q: i4>>
    %hw2reg = llhd.sig %4 : !hw.struct<status: !hw.struct<sram_alert: !hw.struct<d: i1, de: i1>, readback_error: !hw.struct<d: i1, de: i1>, init_done: !hw.struct<d: i1, de: i1>, scr_key_seed_valid: !hw.struct<d: i1, de: i1>, scr_key_valid: !hw.struct<d: i1, de: i1>, escalated: !hw.struct<d: i1, de: i1>, init_error: !hw.struct<d: i1, de: i1>, bus_integ_error: !hw.struct<d: i1, de: i1>>, scr_key_rotated: !hw.struct<d: i4, de: i1>>
    %key_d = llhd.sig %c0_i128 : i128
    %key_q = llhd.sig %c0_i128 : i128
    %nonce_d = llhd.sig %c0_i128 : i128
    %nonce_q = llhd.sig %c0_i128 : i128
    %local_esc = llhd.sig %false : i1
    %init_trig = llhd.sig %false : i1
    %init_q = llhd.sig %false : i1
    %init_d = llhd.sig %false : i1
    %init_cnt = llhd.sig %c0_i10 : i10
    %key_req_pending_d = llhd.sig %false : i1
    %key_req_pending_q = llhd.sig %false : i1
    %key_ack = llhd.sig %false : i1
    %gen_instr_ctrl.lc_ifetch_en = llhd.sig %c0_i4 : i4
    %gen_instr_ctrl.reg_ifetch_en = llhd.sig %c0_i4 : i4
    %lfsr_out_integ = llhd.sig %c0_i39 : i39
    %tl_gate_resp_pending = llhd.sig %false : i1
    %tlul_addr = llhd.sig %c0_i10 : i10
    %tlul_wdata = llhd.sig %c0_i39 : i39
    %tlul_wmask = llhd.sig %c0_i39 : i39
    %sram_compound_txn_in_progress = llhd.sig %false : i1
    %u_seed_anchor.out_o = hw.instance "u_seed_anchor" @prim_sec_anchor_buf(in_i: %c-29489338482610088529621666603445263003154697118141640604891279714348151071073_i256: i256) -> (out_o: i256)
    %11 = comb.extract %u_seed_anchor.out_o from 128 : (i256) -> i128
    llhd.drv %cnst_sram_key, %11 after %3 : i128
    %12 = comb.extract %u_seed_anchor.out_o from 0 : (i256) -> i128
    llhd.drv %cnst_sram_nonce, %12 after %3 : i128
    %13 = llhd.prb %hw2reg : !hw.struct<status: !hw.struct<sram_alert: !hw.struct<d: i1, de: i1>, readback_error: !hw.struct<d: i1, de: i1>, init_done: !hw.struct<d: i1, de: i1>, scr_key_seed_valid: !hw.struct<d: i1, de: i1>, scr_key_valid: !hw.struct<d: i1, de: i1>, escalated: !hw.struct<d: i1, de: i1>, init_error: !hw.struct<d: i1, de: i1>, bus_integ_error: !hw.struct<d: i1, de: i1>>, scr_key_rotated: !hw.struct<d: i4, de: i1>>
    %14 = llhd.sig.array_get %racl_error[%true] : <!hw.array<2xstruct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>>
    %15 = llhd.sig.extract %bus_integ_error from %c0_i2 : <i3> -> <i1>
    %u_reg_regs.tl_o, %u_reg_regs.reg2hw, %u_reg_regs.racl_error_o, %u_reg_regs.intg_err_o = hw.instance "u_reg_regs" @sram_ctrl_regs_reg_top(clk_i: %9: i1, rst_ni: %10: i1, tl_i: %regs_tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, hw2reg: %13: !hw.struct<status: !hw.struct<sram_alert: !hw.struct<d: i1, de: i1>, readback_error: !hw.struct<d: i1, de: i1>, init_done: !hw.struct<d: i1, de: i1>, scr_key_seed_valid: !hw.struct<d: i1, de: i1>, scr_key_valid: !hw.struct<d: i1, de: i1>, escalated: !hw.struct<d: i1, de: i1>, init_error: !hw.struct<d: i1, de: i1>, bus_integ_error: !hw.struct<d: i1, de: i1>>, scr_key_rotated: !hw.struct<d: i4, de: i1>>, racl_policies_i: %racl_policies_i: !hw.array<1xstruct<write_perm: i2, read_perm: i2>>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, reg2hw: !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, status: !hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>, exec: !hw.struct<q: i4>, ctrl: !hw.struct<init: !hw.struct<q: i1, qe: i1>, renew_scr_key: !hw.struct<q: i1, qe: i1>>, readback: !hw.struct<q: i4>>, racl_error_o: !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, intg_err_o: i1)
    llhd.drv %reg2hw, %u_reg_regs.reg2hw after %3 : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, status: !hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>, exec: !hw.struct<q: i4>, ctrl: !hw.struct<init: !hw.struct<q: i1, qe: i1>, renew_scr_key: !hw.struct<q: i1, qe: i1>>, readback: !hw.struct<q: i4>>
    llhd.drv %14, %u_reg_regs.racl_error_o after %3 : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    llhd.drv %15, %u_reg_regs.intg_err_o after %3 : i1
    %16 = hw.array_get %alert_rx_i[%c0_i0] : !hw.array<1xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, i0
    %17 = llhd.sig.array_get %alert_tx_o[%c0_i0] : <!hw.array<1xstruct<alert_p: i1, alert_n: i1>>>
    %u_prim_alert_sender_parity.alert_ack_o, %u_prim_alert_sender_parity.alert_state_o, %u_prim_alert_sender_parity.alert_tx_o = hw.instance "u_prim_alert_sender_parity" @prim_alert_sender(clk_i: %9: i1, rst_ni: %10: i1, alert_test_i: %35: i1, alert_req_i: %51: i1, alert_rx_i: %16: !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>) -> (alert_ack_o: i1, alert_state_o: i1, alert_tx_o: !hw.struct<alert_p: i1, alert_n: i1>)
    llhd.drv %17, %u_prim_alert_sender_parity.alert_tx_o after %3 : !hw.struct<alert_p: i1, alert_n: i1>
    %u_prim_lc_sync.lc_en_o = hw.instance "u_prim_lc_sync" @prim_lc_sync(clk_i: %9: i1, rst_ni: %10: i1, lc_en_i: %lc_escalate_en_i: i4) -> (lc_en_o: !hw.array<2xi4>) {sv.namehint = "escalate_en"}
    %18 = llhd.prb %init_trig : i1
    %u_prim_count.cnt_o, %u_prim_count.cnt_after_commit_o, %u_prim_count.err_o = hw.instance "u_prim_count" @prim_count(clk_i: %9: i1, rst_ni: %10: i1, clr_i: %18: i1, set_i: %false: i1, set_cnt_i: %c0_i10: i10, incr_en_i: %70: i1, decr_en_i: %false: i1, step_i: %c1_i10: i10, commit_i: %true: i1) -> (cnt_o: i10, cnt_after_commit_o: i10, err_o: i1) {sv.namehint = "init_error"}
    llhd.drv %init_cnt, %u_prim_count.cnt_o after %3 : i10
    %19 = llhd.prb %key_req_pending_q : i1
    %20 = llhd.sig.struct_extract %sram_otp_key_o["req"] : <!hw.struct<req: i1>>
    %ack = hw.struct_extract %sram_otp_key_i["ack"] : !hw.struct<ack: i1, key: i128, nonce: i128, seed_valid: i1>
    %key = hw.struct_extract %sram_otp_key_i["key"] : !hw.struct<ack: i1, key: i128, nonce: i128, seed_valid: i1>
    %nonce = hw.struct_extract %sram_otp_key_i["nonce"] : !hw.struct<ack: i1, key: i128, nonce: i128, seed_valid: i1>
    %seed_valid = hw.struct_extract %sram_otp_key_i["seed_valid"] : !hw.struct<ack: i1, key: i128, nonce: i128, seed_valid: i1>
    %21 = comb.concat %key, %nonce, %seed_valid : i128, i128, i1
    %u_prim_sync_reqack_data.src_ack_o, %u_prim_sync_reqack_data.dst_req_o, %u_prim_sync_reqack_data.data_o = hw.instance "u_prim_sync_reqack_data" @prim_sync_reqack_data(clk_src_i: %9: i1, rst_src_ni: %10: i1, clk_dst_i: %clk_otp_i: i1, rst_dst_ni: %rst_otp_ni: i1, req_chk_i: %true: i1, src_req_i: %19: i1, dst_ack_i: %ack: i1, data_i: %21: i257) -> (src_ack_o: i1, dst_req_o: i1, data_o: i257)
    llhd.drv %key_ack, %u_prim_sync_reqack_data.src_ack_o after %3 : i1
    llhd.drv %20, %u_prim_sync_reqack_data.dst_req_o after %3 : i1
    %22 = comb.extract %u_prim_sync_reqack_data.data_o from 129 : (i257) -> i128
    llhd.drv %key_d, %22 after %3 : i128
    %23 = comb.extract %u_prim_sync_reqack_data.data_o from 1 : (i257) -> i128
    llhd.drv %nonce_d, %23 after %3 : i128
    %24 = comb.extract %u_prim_sync_reqack_data.data_o from 0 {sv.namehint = "key_seed_valid"} : (i257) -> i1
    %gen_instr_ctrl.u_prim_lc_sync_hw_debug_en.lc_en_o = hw.instance "gen_instr_ctrl.u_prim_lc_sync_hw_debug_en" @prim_lc_sync_0(clk_i: %9: i1, rst_ni: %10: i1, lc_en_i: %lc_hw_debug_en_i: i4) -> (lc_en_o: !hw.array<1xi4>)
    %25 = hw.bitcast %gen_instr_ctrl.u_prim_lc_sync_hw_debug_en.lc_en_o {sv.namehint = "gen_instr_ctrl.lc_hw_debug_en"} : (!hw.array<1xi4>) -> i4
    %gen_instr_ctrl.u_prim_mubi8_sync_otp_en_sram_ifetch.mubi_o = hw.instance "gen_instr_ctrl.u_prim_mubi8_sync_otp_en_sram_ifetch" @prim_mubi8_sync(clk_i: %9: i1, rst_ni: %10: i1, mubi_i: %otp_en_sram_ifetch_i: i8) -> (mubi_o: !hw.array<1xi8>)
    %26 = hw.bitcast %gen_instr_ctrl.u_prim_mubi8_sync_otp_en_sram_ifetch.mubi_o {sv.namehint = "gen_instr_ctrl.otp_en_sram_ifetch"} : (!hw.array<1xi8>) -> i8
    %27 = llhd.prb %nonce_q : i128
    %28 = comb.extract %27 from 64 : (i128) -> i64
    %u_lfsr.state_o = hw.instance "u_lfsr" @prim_lfsr(clk_i: %9: i1, rst_ni: %10: i1, seed_en_i: %18: i1, seed_i: %28: i64, lfsr_en_i: %70: i1, entropy_i: %c0_i64: i64) -> (state_o: i32) {sv.namehint = "lfsr_out"}
    %u_tlul_data_integ_enc.data_intg_o = hw.instance "u_tlul_data_integ_enc" @tlul_data_integ_enc(data_i: %u_lfsr.state_o: i32) -> (data_intg_o: i39)
    llhd.drv %lfsr_out_integ, %u_tlul_data_integ_enc.data_intg_o after %3 : i39
    %29 = llhd.sig.extract %bus_integ_error from %c-2_i2 : <i3> -> <i1>
    %u_tlul_lc_gate.tl_d2h_o, %u_tlul_lc_gate.tl_h2d_o, %u_tlul_lc_gate.flush_ack_o, %u_tlul_lc_gate.resp_pending_o, %u_tlul_lc_gate.err_o = hw.instance "u_tlul_lc_gate" @tlul_lc_gate(clk_i: %9: i1, rst_ni: %10: i1, tl_h2d_i: %ram_tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, tl_d2h_i: %u_tlul_adapter_sram_racl.tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, flush_req_i: %false: i1, lc_en_i: %62: i4) -> (tl_d2h_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, tl_h2d_o: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, flush_ack_o: i1, resp_pending_o: i1, err_o: i1) {sv.namehint = "ram_tl_in_gated"}
    llhd.drv %tl_gate_resp_pending, %u_tlul_lc_gate.resp_pending_o after %3 : i1
    llhd.drv %29, %u_tlul_lc_gate.err_o after %3 : i1
    %30 = llhd.sig.extract %bus_integ_error from %c1_i2 : <i3> -> <i1>
    %31 = llhd.sig.array_get %racl_error[%false] : <!hw.array<2xstruct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>>
    %u_tlul_adapter_sram_racl.tl_o, %u_tlul_adapter_sram_racl.req_o, %u_tlul_adapter_sram_racl.req_type_o, %u_tlul_adapter_sram_racl.we_o, %u_tlul_adapter_sram_racl.addr_o, %u_tlul_adapter_sram_racl.wdata_o, %u_tlul_adapter_sram_racl.wmask_o, %u_tlul_adapter_sram_racl.intg_error_o, %u_tlul_adapter_sram_racl.user_rsvd_o, %u_tlul_adapter_sram_racl.compound_txn_in_progress_o, %u_tlul_adapter_sram_racl.readback_error_o, %u_tlul_adapter_sram_racl.racl_error_o = hw.instance "u_tlul_adapter_sram_racl" @tlul_adapter_sram_racl(clk_i: %9: i1, rst_ni: %10: i1, tl_i: %u_tlul_lc_gate.tl_h2d_o: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, en_ifetch_i: %107: i4, gnt_i: %110: i1, rdata_i: %u_prim_ram_1p_scr.rdata_o: i39, rvalid_i: %u_prim_ram_1p_scr.rvalid_o: i1, rerror_i: %u_prim_ram_1p_scr.rerror_o: i2, readback_en_i: %q_13: i4, wr_collision_i: %u_prim_ram_1p_scr.wr_collision_o: i1, write_pending_i: %u_prim_ram_1p_scr.write_pending_o: i1, racl_policies_i: %racl_policies_i: !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, racl_policy_sel_ranges_i: %racl_policy_sel_ranges_ram_i: !hw.array<1xstruct<base: i32, limit: i32, policy_sel: i1, enable: i1>>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, req_o: i1, req_type_o: i4, we_o: i1, addr_o: i10, wdata_o: i39, wmask_o: i39, intg_error_o: i1, user_rsvd_o: i5, compound_txn_in_progress_o: i1, readback_error_o: i1, racl_error_o: !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>) {sv.namehint = "tlul_we"}
    llhd.drv %tlul_addr, %u_tlul_adapter_sram_racl.addr_o after %3 : i10
    llhd.drv %tlul_wdata, %u_tlul_adapter_sram_racl.wdata_o after %3 : i39
    llhd.drv %tlul_wmask, %u_tlul_adapter_sram_racl.wmask_o after %3 : i39
    llhd.drv %30, %u_tlul_adapter_sram_racl.intg_error_o after %3 : i1
    llhd.drv %sram_compound_txn_in_progress, %u_tlul_adapter_sram_racl.compound_txn_in_progress_o after %3 : i1
    llhd.drv %31, %u_tlul_adapter_sram_racl.racl_error_o after %3 : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %32 = llhd.prb %key_q : i128
    %33 = comb.extract %27 from 0 : (i128) -> i64
    %u_prim_ram_1p_scr.gnt_o, %u_prim_ram_1p_scr.rdata_o, %u_prim_ram_1p_scr.rvalid_o, %u_prim_ram_1p_scr.rerror_o, %u_prim_ram_1p_scr.raddr_o, %u_prim_ram_1p_scr.cfg_rsp_o, %u_prim_ram_1p_scr.wr_collision_o, %u_prim_ram_1p_scr.write_pending_o, %u_prim_ram_1p_scr.alert_o = hw.instance "u_prim_ram_1p_scr" @prim_ram_1p_scr(clk_i: %9: i1, rst_ni: %10: i1, key_valid_i: %128: i1, key_i: %32: i128, nonce_i: %33: i64, req_i: %108: i1, write_i: %111: i1, addr_i: %116: i10, wdata_i: %119: i39, wmask_i: %121: i39, intg_error_i: %114: i1, cfg_i: %cfg_i: !hw.array<1xstruct<ram_cfg: !hw.struct<test: i1, cfg_en: i1, cfg: i4>, rf_cfg: !hw.struct<test: i1, cfg_en: i1, cfg: i4>>>) -> (gnt_o: i1, rdata_o: i39, rvalid_o: i1, rerror_o: i2, raddr_o: i10, cfg_rsp_o: !hw.array<1xstruct<done: i1>>, wr_collision_o: i1, write_pending_o: i1, alert_o: i1) {sv.namehint = "sram_gnt"}
    %34 = llhd.prb %reg2hw : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, status: !hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>, exec: !hw.struct<q: i4>, ctrl: !hw.struct<init: !hw.struct<q: i1, qe: i1>, renew_scr_key: !hw.struct<q: i1, qe: i1>>, readback: !hw.struct<q: i4>>
    %alert_test = hw.struct_extract %34["alert_test"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, status: !hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>, exec: !hw.struct<q: i4>, ctrl: !hw.struct<init: !hw.struct<q: i1, qe: i1>, renew_scr_key: !hw.struct<q: i1, qe: i1>>, readback: !hw.struct<q: i4>>
    %q = hw.struct_extract %alert_test["q"] : !hw.struct<q: i1, qe: i1>
    %qe = hw.struct_extract %alert_test["qe"] : !hw.struct<q: i1, qe: i1>
    %35 = comb.and %q, %qe {sv.namehint = "alert_test"} : i1
    %36 = llhd.sig.struct_extract %hw2reg["status"] : <!hw.struct<status: !hw.struct<sram_alert: !hw.struct<d: i1, de: i1>, readback_error: !hw.struct<d: i1, de: i1>, init_done: !hw.struct<d: i1, de: i1>, scr_key_seed_valid: !hw.struct<d: i1, de: i1>, scr_key_valid: !hw.struct<d: i1, de: i1>, escalated: !hw.struct<d: i1, de: i1>, init_error: !hw.struct<d: i1, de: i1>, bus_integ_error: !hw.struct<d: i1, de: i1>>, scr_key_rotated: !hw.struct<d: i4, de: i1>>>
    %37 = llhd.sig.struct_extract %36["bus_integ_error"] : <!hw.struct<sram_alert: !hw.struct<d: i1, de: i1>, readback_error: !hw.struct<d: i1, de: i1>, init_done: !hw.struct<d: i1, de: i1>, scr_key_seed_valid: !hw.struct<d: i1, de: i1>, scr_key_valid: !hw.struct<d: i1, de: i1>, escalated: !hw.struct<d: i1, de: i1>, init_error: !hw.struct<d: i1, de: i1>, bus_integ_error: !hw.struct<d: i1, de: i1>>>
    %38 = llhd.sig.struct_extract %37["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %38, %true after %3 : i1
    %39 = llhd.sig.struct_extract %37["de"] : <!hw.struct<d: i1, de: i1>>
    %40 = llhd.prb %bus_integ_error : i3
    %41 = comb.icmp ne %40, %c0_i3 : i3
    llhd.drv %39, %41 after %3 : i1
    %42 = llhd.sig.struct_extract %36["init_error"] : <!hw.struct<sram_alert: !hw.struct<d: i1, de: i1>, readback_error: !hw.struct<d: i1, de: i1>, init_done: !hw.struct<d: i1, de: i1>, scr_key_seed_valid: !hw.struct<d: i1, de: i1>, scr_key_valid: !hw.struct<d: i1, de: i1>, escalated: !hw.struct<d: i1, de: i1>, init_error: !hw.struct<d: i1, de: i1>, bus_integ_error: !hw.struct<d: i1, de: i1>>>
    %43 = llhd.sig.struct_extract %42["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %43, %true after %3 : i1
    %44 = llhd.sig.struct_extract %42["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %44, %u_prim_count.err_o after %3 : i1
    %45 = llhd.sig.struct_extract %36["readback_error"] : <!hw.struct<sram_alert: !hw.struct<d: i1, de: i1>, readback_error: !hw.struct<d: i1, de: i1>, init_done: !hw.struct<d: i1, de: i1>, scr_key_seed_valid: !hw.struct<d: i1, de: i1>, scr_key_valid: !hw.struct<d: i1, de: i1>, escalated: !hw.struct<d: i1, de: i1>, init_error: !hw.struct<d: i1, de: i1>, bus_integ_error: !hw.struct<d: i1, de: i1>>>
    %46 = llhd.sig.struct_extract %45["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %46, %true after %3 : i1
    %47 = llhd.sig.struct_extract %45["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %47, %u_tlul_adapter_sram_racl.readback_error_o after %3 : i1
    %48 = llhd.sig.struct_extract %36["sram_alert"] : <!hw.struct<sram_alert: !hw.struct<d: i1, de: i1>, readback_error: !hw.struct<d: i1, de: i1>, init_done: !hw.struct<d: i1, de: i1>, scr_key_seed_valid: !hw.struct<d: i1, de: i1>, scr_key_valid: !hw.struct<d: i1, de: i1>, escalated: !hw.struct<d: i1, de: i1>, init_error: !hw.struct<d: i1, de: i1>, bus_integ_error: !hw.struct<d: i1, de: i1>>>
    %49 = llhd.sig.struct_extract %48["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %49, %true after %3 : i1
    %50 = llhd.sig.struct_extract %48["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %50, %u_prim_ram_1p_scr.alert_o after %3 : i1
    %51 = comb.or %41, %u_prim_count.err_o, %u_tlul_adapter_sram_racl.readback_error_o, %u_prim_ram_1p_scr.alert_o {sv.namehint = "alert_req"} : i1
    %52 = hw.array_get %u_prim_lc_sync.lc_en_o[%false] : !hw.array<2xi4>, i1
    %53 = func.call @"lc_ctrl_pkg::lc_tx_test_true_loose"(%52) {sv.namehint = "escalate"} : (i4) -> i1
    %54 = llhd.sig.struct_extract %36["escalated"] : <!hw.struct<sram_alert: !hw.struct<d: i1, de: i1>, readback_error: !hw.struct<d: i1, de: i1>, init_done: !hw.struct<d: i1, de: i1>, scr_key_seed_valid: !hw.struct<d: i1, de: i1>, scr_key_valid: !hw.struct<d: i1, de: i1>, escalated: !hw.struct<d: i1, de: i1>, init_error: !hw.struct<d: i1, de: i1>, bus_integ_error: !hw.struct<d: i1, de: i1>>>
    %55 = llhd.sig.struct_extract %54["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %55, %true after %3 : i1
    %56 = llhd.sig.struct_extract %54["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %56, %53 after %3 : i1
    %status = hw.struct_extract %34["status"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, status: !hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>, exec: !hw.struct<q: i4>, ctrl: !hw.struct<init: !hw.struct<q: i1, qe: i1>, renew_scr_key: !hw.struct<q: i1, qe: i1>>, readback: !hw.struct<q: i4>>
    %escalated = hw.struct_extract %status["escalated"] : !hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>
    %q_2 = hw.struct_extract %escalated["q"] : !hw.struct<q: i1>
    %init_error = hw.struct_extract %status["init_error"] : !hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>
    %q_3 = hw.struct_extract %init_error["q"] : !hw.struct<q: i1>
    %bus_integ_error_4 = hw.struct_extract %status["bus_integ_error"] : !hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>
    %q_5 = hw.struct_extract %bus_integ_error_4["q"] : !hw.struct<q: i1>
    %sram_alert = hw.struct_extract %status["sram_alert"] : !hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>
    %q_6 = hw.struct_extract %sram_alert["q"] : !hw.struct<q: i1>
    %readback_error = hw.struct_extract %status["readback_error"] : !hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>
    %q_7 = hw.struct_extract %readback_error["q"] : !hw.struct<q: i1>
    %57 = comb.or %q_2, %q_3, %q_5, %q_6, %q_7 {sv.namehint = "local_esc_reg"} : i1
    %58 = comb.or %53, %u_prim_count.err_o, %41, %u_prim_ram_1p_scr.alert_o, %u_tlul_adapter_sram_racl.readback_error_o, %57 : i1
    llhd.drv %local_esc, %58 after %3 : i1
    %59 = hw.array_get %u_prim_lc_sync.lc_en_o[%true] : !hw.array<2xi4>, i1
    %60 = func.call @"lc_ctrl_pkg::lc_tx_bool_to_lc_tx"(%57) : (i1) -> i4
    %61 = func.call @"lc_ctrl_pkg::lc_tx_or_hi"(%59, %60) : (i4, i4) -> i4
    %62 = func.call @"lc_ctrl_pkg::lc_tx_inv"(%61) {sv.namehint = "lc_tlul_gate_en"} : (i4) -> i4
    %ctrl = hw.struct_extract %34["ctrl"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, status: !hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>, exec: !hw.struct<q: i4>, ctrl: !hw.struct<init: !hw.struct<q: i1, qe: i1>, renew_scr_key: !hw.struct<q: i1, qe: i1>>, readback: !hw.struct<q: i4>>
    %init = hw.struct_extract %ctrl["init"] : !hw.struct<init: !hw.struct<q: i1, qe: i1>, renew_scr_key: !hw.struct<q: i1, qe: i1>>
    %q_8 = hw.struct_extract %init["q"] : !hw.struct<q: i1, qe: i1>
    %qe_9 = hw.struct_extract %init["qe"] : !hw.struct<q: i1, qe: i1>
    %63 = llhd.prb %init_q : i1
    %64 = comb.xor %63, %true : i1
    %65 = comb.and %q_8, %qe_9, %64 : i1
    llhd.drv %init_trig, %65 after %3 : i1
    %66 = comb.or %18, %63 : i1
    %67 = comb.xor %73, %true : i1
    %68 = comb.and %67, %66 : i1
    llhd.drv %init_d, %68 after %3 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %131 = llhd.prb %clk_i_0 : i1
      %132 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%9, %10 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %133 = llhd.prb %clk_i_0 : i1
      %134 = comb.xor bin %131, %true : i1
      %135 = comb.and bin %134, %133 : i1
      %136 = llhd.prb %rst_ni_1 : i1
      %137 = comb.xor bin %136, %true : i1
      %138 = comb.and bin %132, %137 : i1
      %139 = comb.or bin %135, %138 : i1
      cf.cond_br %139, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %140 = llhd.prb %rst_ni_1 : i1
      %141 = comb.xor %140, %true : i1
      cf.cond_br %141, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %init_q, %false after %2 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %142 = llhd.prb %init_d : i1
      llhd.drv %init_q, %142 after %2 : i1
      cf.br ^bb1
    }
    %69 = comb.xor %19, %true : i1
    %70 = comb.and %63, %69 {sv.namehint = "init_req"} : i1
    %71 = llhd.prb %init_cnt : i10
    %72 = comb.icmp eq %71, %c-1_i10 : i10
    %73 = comb.and %72, %70 {sv.namehint = "init_done"} : i1
    %74 = llhd.sig.struct_extract %36["init_done"] : <!hw.struct<sram_alert: !hw.struct<d: i1, de: i1>, readback_error: !hw.struct<d: i1, de: i1>, init_done: !hw.struct<d: i1, de: i1>, scr_key_seed_valid: !hw.struct<d: i1, de: i1>, scr_key_valid: !hw.struct<d: i1, de: i1>, escalated: !hw.struct<d: i1, de: i1>, init_error: !hw.struct<d: i1, de: i1>, bus_integ_error: !hw.struct<d: i1, de: i1>>>
    %75 = llhd.sig.struct_extract %74["d"] : <!hw.struct<d: i1, de: i1>>
    %76 = comb.xor %18, %true : i1
    %77 = llhd.prb %local_esc : i1
    %78 = comb.xor %77, %true : i1
    %79 = comb.and %73, %76, %78 : i1
    llhd.drv %75, %79 after %3 : i1
    %80 = llhd.sig.struct_extract %74["de"] : <!hw.struct<d: i1, de: i1>>
    %81 = comb.or %73, %18, %77 : i1
    llhd.drv %80, %81 after %3 : i1
    %renew_scr_key = hw.struct_extract %ctrl["renew_scr_key"] : !hw.struct<init: !hw.struct<q: i1, qe: i1>, renew_scr_key: !hw.struct<q: i1, qe: i1>>
    %q_10 = hw.struct_extract %renew_scr_key["q"] : !hw.struct<q: i1, qe: i1>
    %qe_11 = hw.struct_extract %renew_scr_key["qe"] : !hw.struct<q: i1, qe: i1>
    %82 = comb.and %q_10, %qe_11, %69, %64 {sv.namehint = "key_req"} : i1
    %83 = llhd.prb %key_ack : i1
    %84 = comb.xor %83, %true : i1
    %85 = comb.and %84, %19 : i1
    %86 = comb.or %82, %85 : i1
    llhd.drv %key_req_pending_d, %86 after %3 : i1
    %87 = llhd.sig.struct_extract %36["scr_key_valid"] : <!hw.struct<sram_alert: !hw.struct<d: i1, de: i1>, readback_error: !hw.struct<d: i1, de: i1>, init_done: !hw.struct<d: i1, de: i1>, scr_key_seed_valid: !hw.struct<d: i1, de: i1>, scr_key_valid: !hw.struct<d: i1, de: i1>, escalated: !hw.struct<d: i1, de: i1>, init_error: !hw.struct<d: i1, de: i1>, bus_integ_error: !hw.struct<d: i1, de: i1>>>
    %88 = llhd.sig.struct_extract %87["d"] : <!hw.struct<d: i1, de: i1>>
    %89 = comb.xor %82, %true : i1
    %90 = comb.and %83, %89, %78 : i1
    llhd.drv %88, %90 after %3 : i1
    %91 = llhd.sig.struct_extract %87["de"] : <!hw.struct<d: i1, de: i1>>
    %92 = comb.or %82, %83, %77 : i1
    llhd.drv %91, %92 after %3 : i1
    %93 = llhd.sig.struct_extract %hw2reg["scr_key_rotated"] : <!hw.struct<status: !hw.struct<sram_alert: !hw.struct<d: i1, de: i1>, readback_error: !hw.struct<d: i1, de: i1>, init_done: !hw.struct<d: i1, de: i1>, scr_key_seed_valid: !hw.struct<d: i1, de: i1>, scr_key_valid: !hw.struct<d: i1, de: i1>, escalated: !hw.struct<d: i1, de: i1>, init_error: !hw.struct<d: i1, de: i1>, bus_integ_error: !hw.struct<d: i1, de: i1>>, scr_key_rotated: !hw.struct<d: i4, de: i1>>>
    %94 = llhd.sig.struct_extract %93["d"] : <!hw.struct<d: i4, de: i1>>
    %95 = comb.and %83, %78 : i1
    %96 = comb.mux %95, %c6_i4, %c-7_i4 : i4
    llhd.drv %94, %96 after %3 : i4
    %97 = llhd.sig.struct_extract %93["de"] : <!hw.struct<d: i4, de: i1>>
    %98 = comb.or %83, %77 : i1
    llhd.drv %97, %98 after %3 : i1
    %99 = llhd.sig.struct_extract %36["scr_key_seed_valid"] : <!hw.struct<sram_alert: !hw.struct<d: i1, de: i1>, readback_error: !hw.struct<d: i1, de: i1>, init_done: !hw.struct<d: i1, de: i1>, scr_key_seed_valid: !hw.struct<d: i1, de: i1>, scr_key_valid: !hw.struct<d: i1, de: i1>, escalated: !hw.struct<d: i1, de: i1>, init_error: !hw.struct<d: i1, de: i1>, bus_integ_error: !hw.struct<d: i1, de: i1>>>
    %100 = llhd.sig.struct_extract %99["d"] : <!hw.struct<d: i1, de: i1>>
    %101 = comb.and %24, %78 : i1
    llhd.drv %100, %101 after %3 : i1
    %102 = llhd.sig.struct_extract %99["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %102, %98 after %3 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb7, ^bb8
      %131 = llhd.prb %clk_i_0 : i1
      %132 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%9, %10 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %133 = llhd.prb %clk_i_0 : i1
      %134 = comb.xor bin %131, %true : i1
      %135 = comb.and bin %134, %133 : i1
      %136 = llhd.prb %rst_ni_1 : i1
      %137 = comb.xor bin %136, %true : i1
      %138 = comb.and bin %132, %137 : i1
      %139 = comb.or bin %135, %138 : i1
      cf.cond_br %139, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %140 = llhd.prb %rst_ni_1 : i1
      %141 = comb.xor %140, %true : i1
      cf.cond_br %141, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %key_req_pending_q, %false after %2 : i1
      llhd.drv %key_q, %c-86661376989486117430205222316559757455_i128 after %2 : i128
      llhd.drv %nonce_q, %c46453349783654013486528997942361333407_i128 after %2 : i128
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %142 = llhd.prb %key_req_pending_d : i1
      llhd.drv %key_req_pending_q, %142 after %2 : i1
      %143 = llhd.prb %key_ack : i1
      cf.cond_br %143, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %144 = llhd.prb %key_d : i128
      llhd.drv %key_q, %144 after %2 : i128
      %145 = llhd.prb %nonce_d : i128
      llhd.drv %nonce_q, %145 after %2 : i128
      cf.br ^bb7
    ^bb7:  // 2 preds: ^bb5, ^bb6
      %146 = llhd.prb %local_esc : i1
      cf.cond_br %146, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %147 = llhd.prb %cnst_sram_key : i128
      llhd.drv %key_q, %147 after %2 : i128
      %148 = llhd.prb %cnst_sram_nonce : i128
      llhd.drv %nonce_q, %148 after %2 : i128
      cf.br ^bb1
    }
    %103 = func.call @"lc_ctrl_pkg::lc_to_mubi4"(%25) : (i4) -> i4
    llhd.drv %gen_instr_ctrl.lc_ifetch_en, %103 after %3 : i4
    %exec = hw.struct_extract %34["exec"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, status: !hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>, exec: !hw.struct<q: i4>, ctrl: !hw.struct<init: !hw.struct<q: i1, qe: i1>, renew_scr_key: !hw.struct<q: i1, qe: i1>>, readback: !hw.struct<q: i4>>
    %q_12 = hw.struct_extract %exec["q"] : !hw.struct<q: i4>
    llhd.drv %gen_instr_ctrl.reg_ifetch_en, %q_12 after %3 : i4
    %104 = func.call @"prim_mubi_pkg::mubi8_test_true_strict"(%26) : (i8) -> i1
    %105 = llhd.prb %gen_instr_ctrl.reg_ifetch_en : i4
    %106 = llhd.prb %gen_instr_ctrl.lc_ifetch_en : i4
    %107 = comb.mux %104, %105, %106 {sv.namehint = "en_ifetch"} : i4
    %readback = hw.struct_extract %34["readback"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, status: !hw.struct<sram_alert: !hw.struct<q: i1>, readback_error: !hw.struct<q: i1>, init_done: !hw.struct<q: i1>, scr_key_seed_valid: !hw.struct<q: i1>, escalated: !hw.struct<q: i1>, init_error: !hw.struct<q: i1>, bus_integ_error: !hw.struct<q: i1>>, exec: !hw.struct<q: i4>, ctrl: !hw.struct<init: !hw.struct<q: i1, qe: i1>, renew_scr_key: !hw.struct<q: i1, qe: i1>>, readback: !hw.struct<q: i4>>
    %q_13 = hw.struct_extract %readback["q"] {sv.namehint = "reg_readback_en"} : !hw.struct<q: i4>
    %108 = comb.or %u_tlul_adapter_sram_racl.req_o, %70 {sv.namehint = "sram_req"} : i1
    %109 = comb.xor %70, %true : i1
    %110 = comb.and %128, %109 {sv.namehint = "tlul_gnt"} : i1
    %111 = comb.or %u_tlul_adapter_sram_racl.we_o, %70 {sv.namehint = "sram_we"} : i1
    %112 = comb.extract %40 from 1 : (i3) -> i2
    %113 = comb.icmp ne %112, %c0_i2 : i2
    %114 = comb.and %113, %109 {sv.namehint = "sram_intg_error"} : i1
    %115 = llhd.prb %tlul_addr : i10
    %116 = comb.mux %70, %71, %115 {sv.namehint = "sram_addr"} : i10
    %117 = llhd.prb %lfsr_out_integ : i39
    %118 = llhd.prb %tlul_wdata : i39
    %119 = comb.mux %70, %117, %118 {sv.namehint = "sram_wdata"} : i39
    %120 = llhd.prb %tlul_wmask : i39
    %121 = comb.mux %70, %c-1_i39, %120 {sv.namehint = "sram_wmask"} : i39
    %122 = llhd.prb %tl_gate_resp_pending : i1
    %123 = llhd.prb %sram_compound_txn_in_progress : i1
    %124 = comb.and %122, %123 : i1
    %125 = comb.xor %q_2, %true : i1
    %126 = comb.or %125, %124 : i1
    %127 = comb.xor %19, %true : i1
    %128 = comb.and %127, %126 {sv.namehint = "key_valid"} : i1
    llhd.drv %clk_i_0, %clk_i after %3 : i1
    llhd.drv %rst_ni_1, %rst_ni after %3 : i1
    %129 = llhd.prb %alert_tx_o : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    %130 = llhd.prb %sram_otp_key_o : !hw.struct<req: i1>
    hw.output %u_tlul_lc_gate.tl_d2h_o, %u_reg_regs.tl_o, %129, %1, %130, %u_prim_ram_1p_scr.cfg_rsp_o, %0 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.array<1xstruct<alert_p: i1, alert_n: i1>>, !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, !hw.struct<req: i1>, !hw.array<1xstruct<done: i1>>, !hw.struct<valid: i1, correctable: i1, address: i32>
  }
}
