module {
  hw.module private @prim_buf(in %in_i : i18, out out_o : i18) {
    hw.output %in_i : i18
  }
  hw.module private @prim_buf_28(in %in_i : i1, out out_o : i1) {
    hw.output %in_i : i1
  }
  hw.module private @prim_buf_32(in %in_i : i2, out out_o : i2) {
    hw.output %in_i : i2
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
  hw.module private @prim_flop_2sync_33(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %d_i_0 = llhd.sig name "d_i" %false : i1
    %d_o = llhd.sig %false : i1
    %1 = llhd.prb %d_o : i1
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_38(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i1) -> (q_o: i1) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_38(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i1) -> (q_o: i1)
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
  hw.module private @prim_flop_29(in %clk_i : i1, in %rst_ni : i1, in %d_i : i32, out q_o : i32) {
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
  hw.module private @prim_flop_30(in %clk_i : i1, in %rst_ni : i1, in %d_i : i32, out q_o : i32) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i32 = hw.constant 0 : i32
    %c-1_i32 = hw.constant -1 : i32
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
      llhd.drv %q_o, %c-1_i32 after %1 : i32
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
  hw.module private @prim_flop_34(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_o : i2) {
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
  hw.module private @prim_flop_36(in %clk_i : i1, in %rst_ni : i1, in %d_i : i9, out q_o : i9) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i9 = hw.constant 0 : i9
    %c193_i9 = hw.constant 193 : i9
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
      llhd.drv %q_o, %c193_i9 after %1 : i9
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
  hw.module private @prim_flop_37(in %clk_i : i1, in %rst_ni : i1, in %d_i : i9, out q_o : i9) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i9 = hw.constant 0 : i9
    %c-206_i9 = hw.constant -206 : i9
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
      llhd.drv %q_o, %c-206_i9 after %1 : i9
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
  hw.module private @prim_flop_38(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
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
  hw.module private @prim_flop_39(in %clk_i : i1, in %rst_ni : i1, in %d_i : i5, out q_o : i5) {
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
  hw.module private @prim_flop_40(in %clk_i : i1, in %rst_ni : i1, in %d_i : i5, out q_o : i5) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i5 = hw.constant 0 : i5
    %c-1_i5 = hw.constant -1 : i5
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
      llhd.drv %q_o, %c-1_i5 after %1 : i5
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
    %u_prim_buf_in_req.out_o = hw.instance "u_prim_buf_in_req" @prim_sec_anchor_buf_17(in_i: %alert_req_i: i1) -> (out_o: i1) {sv.namehint = "alert_req"}
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
  hw.module private @prim_alert_sender_0(in %clk_i : i1, in %rst_ni : i1, in %alert_test_i : i1, in %alert_req_i : i1, out alert_ack_o : i1, out alert_state_o : i1, in %alert_rx_i : !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>, out alert_tx_o : !hw.struct<alert_p: i1, alert_n: i1>) {
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
    %u_prim_buf_in_req.out_o = hw.instance "u_prim_buf_in_req" @prim_sec_anchor_buf_17(in_i: %alert_req_i: i1) -> (out_o: i1) {sv.namehint = "alert_req"}
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
  hw.module private @prim_arbiter_ppc(in %clk_i : i1, in %rst_ni : i1, in %req_chk_i : i1, in %req_i : i8, in %data_i : !hw.array<8xi1>, out gnt_o : i8, out idx_o : i3, out valid_o : i1, out data_o : i1, in %ready_i : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %true = hw.constant true
    %false = hw.constant false
    %c0_i8 = hw.constant 0 : i8
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %req_i_2 = llhd.sig name "req_i" %c0_i8 : i8
    %valid_o = llhd.sig %false : i1
    %ready_i_3 = llhd.sig name "ready_i" %false : i1
    %gen_normal_case.masked_req = llhd.sig %c0_i8 : i8
    %gen_normal_case.ppc_out = llhd.sig %c0_i8 : i8
    %gen_normal_case.mask = llhd.sig %c0_i8 : i8
    %gen_normal_case.mask_next = llhd.sig %c0_i8 : i8
    %gen_normal_case.winner = llhd.sig %c0_i8 : i8
    %gen_normal_case.u_leading_one.leading_one_o, %gen_normal_case.u_leading_one.ppc_out_o, %gen_normal_case.u_leading_one.idx_o = hw.instance "gen_normal_case.u_leading_one" @prim_leading_one_ppc(in_i: %9: i8) -> (leading_one_o: i8, ppc_out_o: i8, idx_o: i3)
    llhd.drv %gen_normal_case.winner, %gen_normal_case.u_leading_one.leading_one_o after %1 : i8
    llhd.drv %gen_normal_case.ppc_out, %gen_normal_case.u_leading_one.ppc_out_o after %1 : i8
    %4 = llhd.prb %gen_normal_case.mask : i8
    %5 = llhd.prb %req_i_2 : i8
    %6 = comb.and %4, %5 : i8
    llhd.drv %gen_normal_case.masked_req, %6 after %1 : i8
    %7 = llhd.prb %gen_normal_case.masked_req : i8
    %8 = comb.icmp ne %7, %c0_i8 : i8
    %9 = comb.mux %8, %7, %5 {sv.namehint = "gen_normal_case.arb_req"} : i8
    %10 = llhd.prb %ready_i_3 : i1
    %11 = llhd.prb %gen_normal_case.winner : i8
    %12 = comb.mux %10, %11, %c0_i8 : i8
    %13 = comb.icmp ne %5, %c0_i8 : i8
    llhd.drv %valid_o, %13 after %1 : i1
    %14 = llhd.prb %gen_normal_case.ppc_out : i8
    %15 = comb.extract %14 from 0 : (i8) -> i7
    %16 = comb.concat %15, %false : i7, i1
    llhd.drv %gen_normal_case.mask_next, %16 after %1 : i8
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
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
      llhd.drv %gen_normal_case.mask, %c0_i8 after %0 : i8
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %29 = llhd.prb %valid_o : i1
      %30 = llhd.prb %ready_i_3 : i1
      %31 = comb.and %29, %30 : i1
      cf.cond_br %31, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %32 = llhd.prb %gen_normal_case.mask_next : i8
      llhd.drv %gen_normal_case.mask, %32 after %0 : i8
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %33 = llhd.prb %valid_o : i1
      %34 = llhd.prb %ready_i_3 : i1
      %35 = comb.xor %34, %true : i1
      %36 = comb.and %33, %35 : i1
      cf.cond_br %36, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %37 = llhd.prb %gen_normal_case.ppc_out : i8
      llhd.drv %gen_normal_case.mask, %37 after %0 : i8
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %req_i_2, %req_i after %1 : i8
    %17 = llhd.prb %valid_o : i1
    llhd.drv %ready_i_3, %ready_i after %1 : i1
    hw.output %12, %gen_normal_case.u_leading_one.idx_o, %17, %true : i8, i3, i1, i1
  }
  hw.module private @prim_count(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %set_i : i1, in %set_cnt_i : i32, in %incr_en_i : i1, in %decr_en_i : i1, in %step_i : i32, in %commit_i : i1, out cnt_o : i32, out cnt_after_commit_o : i32, out err_o : i1) {
    %c4294967295_i33 = hw.constant 4294967295 : i33
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i32 = hw.constant -1 : i32
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i33 = hw.constant 0 : i33
    %2 = hw.aggregate_constant [0 : i32, 0 : i32] : !hw.array<2xi32>
    %false = hw.constant false
    %true = hw.constant true
    %c0_i32 = hw.constant 0 : i32
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %set_i_2 = llhd.sig name "set_i" %false : i1
    %step_i_3 = llhd.sig name "step_i" %c0_i32 : i32
    %cnt_d = llhd.sig %2 : !hw.array<2xi32>
    %cnt_d_committed = llhd.sig %2 : !hw.array<2xi32>
    %cnt_q = llhd.sig %2 : !hw.array<2xi32>
    %gen_cnts_0.incr_en = llhd.sig %false : i1
    %gen_cnts_0.set_val = llhd.sig %c0_i32 : i32
    %gen_cnts_0.ext_cnt = llhd.sig %c0_i33 : i33
    %gen_cnts_0.oflow = llhd.sig %false : i1
    %gen_cnts_0.cnt_sat = llhd.sig %c0_i32 : i32
    %gen_cnts_0.cnt_en = llhd.sig %false : i1
    %gen_cnts_1.incr_en = llhd.sig %false : i1
    %gen_cnts_1.set_val = llhd.sig %c0_i32 : i32
    %gen_cnts_1.ext_cnt = llhd.sig %c0_i33 : i33
    %gen_cnts_1.oflow = llhd.sig %false : i1
    %gen_cnts_1.cnt_sat = llhd.sig %c0_i32 : i32
    %gen_cnts_1.cnt_en = llhd.sig %false : i1
    %err_d = llhd.sig %false : i1
    %err_q = llhd.sig %false : i1
    %5 = llhd.prb %cnt_d_committed : !hw.array<2xi32>
    %6 = hw.array_get %5[%false] : !hw.array<2xi32>, i1
    %gen_cnts_0.u_cnt_flop.q_o = hw.instance "gen_cnts_0.u_cnt_flop" @prim_flop_29(clk_i: %3: i1, rst_ni: %4: i1, d_i: %6: i32) -> (q_o: i32) {sv.namehint = "gen_cnts_0.cnt_unforced_q"}
    %7 = hw.array_get %5[%true] : !hw.array<2xi32>, i1
    %gen_cnts_1.u_cnt_flop.q_o = hw.instance "gen_cnts_1.u_cnt_flop" @prim_flop_30(clk_i: %3: i1, rst_ni: %4: i1, d_i: %7: i32) -> (q_o: i32) {sv.namehint = "gen_cnts_1.cnt_unforced_q"}
    llhd.drv %gen_cnts_0.incr_en, %incr_en_i after %1 : i1
    llhd.drv %gen_cnts_0.set_val, %set_cnt_i after %1 : i32
    %8 = llhd.prb %cnt_q : !hw.array<2xi32>
    %9 = hw.array_get %8[%false] : !hw.array<2xi32>, i1
    %10 = comb.concat %false, %9 : i1, i32
    %11 = llhd.prb %step_i_3 : i32
    %12 = comb.concat %false, %11 : i1, i32
    %13 = comb.sub %10, %12 : i33
    %14 = llhd.prb %gen_cnts_0.incr_en : i1
    %15 = comb.add %10, %12 : i33
    %16 = comb.mux %14, %15, %10 : i33
    %17 = comb.mux %decr_en_i, %13, %16 : i33
    llhd.drv %gen_cnts_0.ext_cnt, %17 after %1 : i33
    %18 = llhd.prb %gen_cnts_0.ext_cnt : i33
    %19 = comb.extract %18 from 32 : (i33) -> i1
    %20 = comb.and %14, %19 : i1
    llhd.drv %gen_cnts_0.oflow, %20 after %1 : i1
    %21 = comb.and %decr_en_i, %19 {sv.namehint = "gen_cnts_0.uflow"} : i1
    %22 = llhd.prb %gen_cnts_0.oflow : i1
    %23 = comb.extract %18 from 0 : (i33) -> i32
    %24 = comb.mux %22, %c-1_i32, %23 : i32
    %25 = comb.mux %21, %c0_i32, %24 : i32
    llhd.drv %gen_cnts_0.cnt_sat, %25 after %1 : i32
    %26 = comb.xor %14, %decr_en_i : i1
    %27 = comb.icmp ne %9, %c-1_i32 : i32
    %28 = comb.and %14, %27 : i1
    %29 = comb.icmp ne %9, %c0_i32 : i32
    %30 = comb.and %decr_en_i, %29 : i1
    %31 = comb.or %28, %30 : i1
    %32 = comb.and %26, %31 : i1
    llhd.drv %gen_cnts_0.cnt_en, %32 after %1 : i1
    %33 = llhd.sig.array_get %cnt_d[%false] : <!hw.array<2xi32>>
    %34 = llhd.prb %set_i_2 : i1
    %35 = llhd.prb %gen_cnts_0.set_val : i32
    %36 = llhd.prb %gen_cnts_0.cnt_en : i1
    %37 = llhd.prb %gen_cnts_0.cnt_sat : i32
    %38 = comb.mux %36, %37, %9 : i32
    %39 = comb.mux %34, %35, %38 : i32
    %40 = comb.mux %clr_i, %c0_i32, %39 : i32
    llhd.drv %33, %40 after %1 : i32
    %41 = llhd.sig.array_get %cnt_d_committed[%false] : <!hw.array<2xi32>>
    %42 = llhd.prb %cnt_d : !hw.array<2xi32>
    %43 = hw.array_get %42[%false] : !hw.array<2xi32>, i1
    %44 = comb.mux %commit_i, %43, %9 : i32
    llhd.drv %41, %44 after %1 : i32
    %45 = llhd.sig.array_get %cnt_q[%false] : <!hw.array<2xi32>>
    llhd.drv %45, %gen_cnts_0.u_cnt_flop.q_o after %1 : i32
    llhd.drv %gen_cnts_1.incr_en, %decr_en_i after %1 : i1
    %46 = comb.sub %c-1_i32, %set_cnt_i : i32
    llhd.drv %gen_cnts_1.set_val, %46 after %1 : i32
    %47 = hw.array_get %8[%true] : !hw.array<2xi32>, i1
    %48 = comb.concat %false, %47 : i1, i32
    %49 = comb.sub %48, %12 : i33
    %50 = llhd.prb %gen_cnts_1.incr_en : i1
    %51 = comb.add %48, %12 : i33
    %52 = comb.mux %50, %51, %48 : i33
    %53 = comb.mux %incr_en_i, %49, %52 : i33
    llhd.drv %gen_cnts_1.ext_cnt, %53 after %1 : i33
    %54 = llhd.prb %gen_cnts_1.ext_cnt : i33
    %55 = comb.extract %54 from 32 : (i33) -> i1
    %56 = comb.and %50, %55 : i1
    llhd.drv %gen_cnts_1.oflow, %56 after %1 : i1
    %57 = comb.and %incr_en_i, %55 {sv.namehint = "gen_cnts_1.uflow"} : i1
    %58 = llhd.prb %gen_cnts_1.oflow : i1
    %59 = comb.extract %54 from 0 : (i33) -> i32
    %60 = comb.mux %58, %c-1_i32, %59 : i32
    %61 = comb.mux %57, %c0_i32, %60 : i32
    llhd.drv %gen_cnts_1.cnt_sat, %61 after %1 : i32
    %62 = comb.xor %50, %incr_en_i : i1
    %63 = comb.icmp ne %47, %c-1_i32 : i32
    %64 = comb.and %50, %63 : i1
    %65 = comb.icmp ne %47, %c0_i32 : i32
    %66 = comb.and %incr_en_i, %65 : i1
    %67 = comb.or %64, %66 : i1
    %68 = comb.and %62, %67 : i1
    llhd.drv %gen_cnts_1.cnt_en, %68 after %1 : i1
    %69 = llhd.sig.array_get %cnt_d[%true] : <!hw.array<2xi32>>
    %70 = llhd.prb %gen_cnts_1.set_val : i32
    %71 = llhd.prb %gen_cnts_1.cnt_en : i1
    %72 = llhd.prb %gen_cnts_1.cnt_sat : i32
    %73 = comb.mux %71, %72, %47 : i32
    %74 = comb.mux %34, %70, %73 : i32
    %75 = comb.mux %clr_i, %c-1_i32, %74 : i32
    llhd.drv %69, %75 after %1 : i32
    %76 = llhd.sig.array_get %cnt_d_committed[%true] : <!hw.array<2xi32>>
    %77 = hw.array_get %42[%true] : !hw.array<2xi32>, i1
    %78 = comb.mux %commit_i, %77, %47 : i32
    llhd.drv %76, %78 after %1 : i32
    %79 = llhd.sig.array_get %cnt_q[%true] : <!hw.array<2xi32>>
    llhd.drv %79, %gen_cnts_1.u_cnt_flop.q_o after %1 : i32
    %80 = comb.add %10, %48 {sv.namehint = "sum"} : i33
    %81 = comb.icmp ne %80, %c4294967295_i33 : i33
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
    llhd.drv %step_i_3, %step_i after %1 : i32
    hw.output %9, %43, %82 : i32, i32, i1
  }
  hw.module private @prim_count_35(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %set_i : i1, in %set_cnt_i : i5, in %incr_en_i : i1, in %decr_en_i : i1, in %step_i : i5, in %commit_i : i1, out cnt_o : i5, out cnt_after_commit_o : i5, out err_o : i1) {
    %c31_i6 = hw.constant 31 : i6
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i5 = hw.constant -1 : i5
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i6 = hw.constant 0 : i6
    %2 = hw.aggregate_constant [0 : i5, 0 : i5] : !hw.array<2xi5>
    %false = hw.constant false
    %true = hw.constant true
    %c0_i5 = hw.constant 0 : i5
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %set_i_2 = llhd.sig name "set_i" %false : i1
    %step_i_3 = llhd.sig name "step_i" %c0_i5 : i5
    %cnt_d = llhd.sig %2 : !hw.array<2xi5>
    %cnt_d_committed = llhd.sig %2 : !hw.array<2xi5>
    %cnt_q = llhd.sig %2 : !hw.array<2xi5>
    %gen_cnts_0.incr_en = llhd.sig %false : i1
    %gen_cnts_0.set_val = llhd.sig %c0_i5 : i5
    %gen_cnts_0.ext_cnt = llhd.sig %c0_i6 : i6
    %gen_cnts_0.oflow = llhd.sig %false : i1
    %gen_cnts_0.cnt_sat = llhd.sig %c0_i5 : i5
    %gen_cnts_0.cnt_en = llhd.sig %false : i1
    %gen_cnts_1.incr_en = llhd.sig %false : i1
    %gen_cnts_1.set_val = llhd.sig %c0_i5 : i5
    %gen_cnts_1.ext_cnt = llhd.sig %c0_i6 : i6
    %gen_cnts_1.oflow = llhd.sig %false : i1
    %gen_cnts_1.cnt_sat = llhd.sig %c0_i5 : i5
    %gen_cnts_1.cnt_en = llhd.sig %false : i1
    %err_d = llhd.sig %false : i1
    %err_q = llhd.sig %false : i1
    %5 = llhd.prb %cnt_d_committed : !hw.array<2xi5>
    %6 = hw.array_get %5[%false] : !hw.array<2xi5>, i1
    %gen_cnts_0.u_cnt_flop.q_o = hw.instance "gen_cnts_0.u_cnt_flop" @prim_flop_39(clk_i: %3: i1, rst_ni: %4: i1, d_i: %6: i5) -> (q_o: i5) {sv.namehint = "gen_cnts_0.cnt_unforced_q"}
    %7 = hw.array_get %5[%true] : !hw.array<2xi5>, i1
    %gen_cnts_1.u_cnt_flop.q_o = hw.instance "gen_cnts_1.u_cnt_flop" @prim_flop_40(clk_i: %3: i1, rst_ni: %4: i1, d_i: %7: i5) -> (q_o: i5) {sv.namehint = "gen_cnts_1.cnt_unforced_q"}
    llhd.drv %gen_cnts_0.incr_en, %incr_en_i after %1 : i1
    llhd.drv %gen_cnts_0.set_val, %set_cnt_i after %1 : i5
    %8 = llhd.prb %cnt_q : !hw.array<2xi5>
    %9 = hw.array_get %8[%false] : !hw.array<2xi5>, i1
    %10 = comb.concat %false, %9 : i1, i5
    %11 = llhd.prb %step_i_3 : i5
    %12 = comb.concat %false, %11 : i1, i5
    %13 = comb.sub %10, %12 : i6
    %14 = llhd.prb %gen_cnts_0.incr_en : i1
    %15 = comb.add %10, %12 : i6
    %16 = comb.mux %14, %15, %10 : i6
    %17 = comb.mux %decr_en_i, %13, %16 : i6
    llhd.drv %gen_cnts_0.ext_cnt, %17 after %1 : i6
    %18 = llhd.prb %gen_cnts_0.ext_cnt : i6
    %19 = comb.extract %18 from 5 : (i6) -> i1
    %20 = comb.and %14, %19 : i1
    llhd.drv %gen_cnts_0.oflow, %20 after %1 : i1
    %21 = comb.and %decr_en_i, %19 {sv.namehint = "gen_cnts_0.uflow"} : i1
    %22 = llhd.prb %gen_cnts_0.oflow : i1
    %23 = comb.extract %18 from 0 : (i6) -> i5
    %24 = comb.mux %22, %c-1_i5, %23 : i5
    %25 = comb.mux %21, %c0_i5, %24 : i5
    llhd.drv %gen_cnts_0.cnt_sat, %25 after %1 : i5
    %26 = comb.xor %14, %decr_en_i : i1
    %27 = comb.icmp ne %9, %c-1_i5 : i5
    %28 = comb.and %14, %27 : i1
    %29 = comb.icmp ne %9, %c0_i5 : i5
    %30 = comb.and %decr_en_i, %29 : i1
    %31 = comb.or %28, %30 : i1
    %32 = comb.and %26, %31 : i1
    llhd.drv %gen_cnts_0.cnt_en, %32 after %1 : i1
    %33 = llhd.sig.array_get %cnt_d[%false] : <!hw.array<2xi5>>
    %34 = llhd.prb %set_i_2 : i1
    %35 = llhd.prb %gen_cnts_0.set_val : i5
    %36 = llhd.prb %gen_cnts_0.cnt_en : i1
    %37 = llhd.prb %gen_cnts_0.cnt_sat : i5
    %38 = comb.mux %36, %37, %9 : i5
    %39 = comb.mux %34, %35, %38 : i5
    %40 = comb.mux %clr_i, %c0_i5, %39 : i5
    llhd.drv %33, %40 after %1 : i5
    %41 = llhd.sig.array_get %cnt_d_committed[%false] : <!hw.array<2xi5>>
    %42 = llhd.prb %cnt_d : !hw.array<2xi5>
    %43 = hw.array_get %42[%false] : !hw.array<2xi5>, i1
    %44 = comb.mux %commit_i, %43, %9 : i5
    llhd.drv %41, %44 after %1 : i5
    %45 = llhd.sig.array_get %cnt_q[%false] : <!hw.array<2xi5>>
    llhd.drv %45, %gen_cnts_0.u_cnt_flop.q_o after %1 : i5
    llhd.drv %gen_cnts_1.incr_en, %decr_en_i after %1 : i1
    %46 = comb.sub %c-1_i5, %set_cnt_i : i5
    llhd.drv %gen_cnts_1.set_val, %46 after %1 : i5
    %47 = hw.array_get %8[%true] : !hw.array<2xi5>, i1
    %48 = comb.concat %false, %47 : i1, i5
    %49 = comb.sub %48, %12 : i6
    %50 = llhd.prb %gen_cnts_1.incr_en : i1
    %51 = comb.add %48, %12 : i6
    %52 = comb.mux %50, %51, %48 : i6
    %53 = comb.mux %incr_en_i, %49, %52 : i6
    llhd.drv %gen_cnts_1.ext_cnt, %53 after %1 : i6
    %54 = llhd.prb %gen_cnts_1.ext_cnt : i6
    %55 = comb.extract %54 from 5 : (i6) -> i1
    %56 = comb.and %50, %55 : i1
    llhd.drv %gen_cnts_1.oflow, %56 after %1 : i1
    %57 = comb.and %incr_en_i, %55 {sv.namehint = "gen_cnts_1.uflow"} : i1
    %58 = llhd.prb %gen_cnts_1.oflow : i1
    %59 = comb.extract %54 from 0 : (i6) -> i5
    %60 = comb.mux %58, %c-1_i5, %59 : i5
    %61 = comb.mux %57, %c0_i5, %60 : i5
    llhd.drv %gen_cnts_1.cnt_sat, %61 after %1 : i5
    %62 = comb.xor %50, %incr_en_i : i1
    %63 = comb.icmp ne %47, %c-1_i5 : i5
    %64 = comb.and %50, %63 : i1
    %65 = comb.icmp ne %47, %c0_i5 : i5
    %66 = comb.and %incr_en_i, %65 : i1
    %67 = comb.or %64, %66 : i1
    %68 = comb.and %62, %67 : i1
    llhd.drv %gen_cnts_1.cnt_en, %68 after %1 : i1
    %69 = llhd.sig.array_get %cnt_d[%true] : <!hw.array<2xi5>>
    %70 = llhd.prb %gen_cnts_1.set_val : i5
    %71 = llhd.prb %gen_cnts_1.cnt_en : i1
    %72 = llhd.prb %gen_cnts_1.cnt_sat : i5
    %73 = comb.mux %71, %72, %47 : i5
    %74 = comb.mux %34, %70, %73 : i5
    %75 = comb.mux %clr_i, %c-1_i5, %74 : i5
    llhd.drv %69, %75 after %1 : i5
    %76 = llhd.sig.array_get %cnt_d_committed[%true] : <!hw.array<2xi5>>
    %77 = hw.array_get %42[%true] : !hw.array<2xi5>, i1
    %78 = comb.mux %commit_i, %77, %47 : i5
    llhd.drv %76, %78 after %1 : i5
    %79 = llhd.sig.array_get %cnt_q[%true] : <!hw.array<2xi5>>
    llhd.drv %79, %gen_cnts_1.u_cnt_flop.q_o after %1 : i5
    %80 = comb.add %10, %48 {sv.namehint = "sum"} : i6
    %81 = comb.icmp ne %80, %c31_i6 : i6
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
    llhd.drv %step_i_3, %step_i after %1 : i5
    hw.output %9, %43, %82 : i5, i5, i1
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
    %gen_async.i_sync_p.q_o = hw.instance "gen_async.i_sync_p" @prim_flop_2sync(clk_i: %2: i1, rst_ni: %3: i1, d_i: %diff_pi: i1) -> (q_o: i1)
    llhd.drv %gen_async.diff_pd, %gen_async.i_sync_p.q_o after %1 : i1
    %gen_async.i_sync_n.q_o = hw.instance "gen_async.i_sync_n" @prim_flop_2sync_33(clk_i: %2: i1, rst_ni: %3: i1, d_i: %diff_ni: i1) -> (q_o: i1)
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
  hw.module private @prim_edge_detector(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_sync_o : i1, out q_posedge_pulse_o : i1, out q_negedge_pulse_o : i1) {
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
    llhd.drv %q_sync_d, %d_i after %1 : i1
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
  hw.module private @prim_fifo_sync_cnt(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %incr_wptr_i : i1, in %incr_rptr_i : i1, out wptr_o : i4, out rptr_o : i4, out full_o : i1, out empty_o : i1, out depth_o : i4, out err_o : i1) {
    %c-16_i5 = hw.constant -16 : i5
    %c-4_i4 = hw.constant -4 : i4
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c-3_i4 = hw.constant -3 : i4
    %true = hw.constant true
    %false = hw.constant false
    %c1_i5 = hw.constant 1 : i5
    %c0_i4 = hw.constant 0 : i4
    %wptr_o = llhd.sig %c0_i4 : i4
    %rptr_o = llhd.sig %c0_i4 : i4
    %wptr_wrap_msb = llhd.sig %false : i1
    %rptr_wrap_msb = llhd.sig %false : i1
    %gen_secure_ptrs.u_wptr.cnt_o, %gen_secure_ptrs.u_wptr.cnt_after_commit_o, %gen_secure_ptrs.u_wptr.err_o = hw.instance "gen_secure_ptrs.u_wptr" @prim_count_35(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clr_i: %clr_i: i1, set_i: %7: i1, set_cnt_i: %13: i5, incr_en_i: %incr_wptr_i: i1, decr_en_i: %false: i1, step_i: %c1_i5: i5, commit_i: %true: i1) -> (cnt_o: i5, cnt_after_commit_o: i5, err_o: i1) {sv.namehint = "wptr_wrap_cnt_q"}
    %gen_secure_ptrs.u_rptr.cnt_o, %gen_secure_ptrs.u_rptr.cnt_after_commit_o, %gen_secure_ptrs.u_rptr.err_o = hw.instance "gen_secure_ptrs.u_rptr" @prim_count_35(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clr_i: %clr_i: i1, set_i: %10: i1, set_cnt_i: %16: i5, incr_en_i: %incr_rptr_i: i1, decr_en_i: %false: i1, step_i: %c1_i5: i5, commit_i: %true: i1) -> (cnt_o: i5, cnt_after_commit_o: i5, err_o: i1) {sv.namehint = "rptr_wrap_cnt_q"}
    %1 = comb.extract %gen_secure_ptrs.u_wptr.cnt_o from 0 : (i5) -> i4
    llhd.drv %wptr_o, %1 after %0 : i4
    %2 = comb.extract %gen_secure_ptrs.u_rptr.cnt_o from 0 : (i5) -> i4
    llhd.drv %rptr_o, %2 after %0 : i4
    %3 = comb.extract %gen_secure_ptrs.u_wptr.cnt_o from 4 : (i5) -> i1
    llhd.drv %wptr_wrap_msb, %3 after %0 : i1
    %4 = comb.extract %gen_secure_ptrs.u_rptr.cnt_o from 4 : (i5) -> i1
    llhd.drv %rptr_wrap_msb, %4 after %0 : i1
    %5 = llhd.prb %wptr_o : i4
    %6 = comb.icmp eq %5, %c-4_i4 : i4
    %7 = comb.and %incr_wptr_i, %6 {sv.namehint = "wptr_wrap_set"} : i1
    %8 = llhd.prb %rptr_o : i4
    %9 = comb.icmp eq %8, %c-4_i4 : i4
    %10 = comb.and %incr_rptr_i, %9 {sv.namehint = "rptr_wrap_set"} : i1
    %11 = llhd.prb %wptr_wrap_msb : i1
    %12 = comb.xor %11, %true : i1
    %13 = comb.concat %12, %c0_i4 {sv.namehint = "wptr_wrap_set_cnt"} : i1, i4
    %14 = llhd.prb %rptr_wrap_msb : i1
    %15 = comb.xor %14, %true : i1
    %16 = comb.concat %15, %c0_i4 {sv.namehint = "rptr_wrap_set_cnt"} : i1, i4
    %17 = comb.xor %gen_secure_ptrs.u_rptr.cnt_o, %c-16_i5 : i5
    %18 = comb.icmp eq %gen_secure_ptrs.u_wptr.cnt_o, %17 : i5
    %19 = comb.icmp eq %gen_secure_ptrs.u_wptr.cnt_o, %gen_secure_ptrs.u_rptr.cnt_o : i5
    %20 = comb.icmp eq %11, %14 : i1
    %21 = comb.sub %5, %8 : i4
    %22 = comb.sub %c-3_i4, %8 : i4
    %23 = comb.add %22, %5 : i4
    %24 = comb.mux %20, %21, %23 : i4
    %25 = comb.mux %18, %c-3_i4, %24 : i4
    %26 = comb.or %gen_secure_ptrs.u_wptr.err_o, %gen_secure_ptrs.u_rptr.err_o : i1
    hw.output %5, %8, %18, %19, %25, %26 : i4, i4, i1, i1, i4, i1
  }
  hw.module private @prim_fifo_sync(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, out wready_o : i1, in %wdata_i : i32, out rvalid_o : i1, in %rready_i : i1, out rdata_o : i32, out full_o : i1, out depth_o : i4, out err_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32] : !hw.array<13xi32>
    %c0_i4 = hw.constant 0 : i4
    %c0_i32 = hw.constant 0 : i32
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %wdata_i_2 = llhd.sig name "wdata_i" %c0_i32 : i32
    %gen_normal_fifo.fifo_wptr = llhd.sig %c0_i4 : i4
    %gen_normal_fifo.fifo_incr_wptr = llhd.sig %false : i1
    %gen_normal_fifo.under_rst = llhd.sig %false : i1
    %gen_normal_fifo.storage = llhd.sig %2 : !hw.array<13xi32>
    %5 = llhd.prb %gen_normal_fifo.fifo_incr_wptr : i1
    %gen_normal_fifo.u_fifo_cnt.wptr_o, %gen_normal_fifo.u_fifo_cnt.rptr_o, %gen_normal_fifo.u_fifo_cnt.full_o, %gen_normal_fifo.u_fifo_cnt.empty_o, %gen_normal_fifo.u_fifo_cnt.depth_o, %gen_normal_fifo.u_fifo_cnt.err_o = hw.instance "gen_normal_fifo.u_fifo_cnt" @prim_fifo_sync_cnt(clk_i: %3: i1, rst_ni: %4: i1, clr_i: %clr_i: i1, incr_wptr_i: %5: i1, incr_rptr_i: %11: i1) -> (wptr_o: i4, rptr_o: i4, full_o: i1, empty_o: i1, depth_o: i4, err_o: i1) {sv.namehint = "gen_normal_fifo.empty"}
    llhd.drv %gen_normal_fifo.fifo_wptr, %gen_normal_fifo.u_fifo_cnt.wptr_o after %1 : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %15 = llhd.prb %clk_i_0 : i1
      %16 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
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
      llhd.drv %gen_normal_fifo.under_rst, %true after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %26 = llhd.prb %gen_normal_fifo.under_rst : i1
      cf.cond_br %26, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %27 = llhd.prb %gen_normal_fifo.under_rst : i1
      %28 = comb.xor %27, %true : i1
      llhd.drv %gen_normal_fifo.under_rst, %28 after %0 : i1
      cf.br ^bb1
    }
    %6 = comb.xor %gen_normal_fifo.u_fifo_cnt.full_o, %true : i1
    %7 = llhd.prb %gen_normal_fifo.under_rst : i1
    %8 = comb.xor %7, %true : i1
    %9 = comb.and %6, %8 : i1
    %10 = comb.and %wvalid_i, %9 : i1
    llhd.drv %gen_normal_fifo.fifo_incr_wptr, %10 after %1 : i1
    %11 = comb.and %14, %rready_i, %8 {sv.namehint = "gen_normal_fifo.fifo_incr_rptr"} : i1
    %12 = llhd.prb %gen_normal_fifo.storage : !hw.array<13xi32>
    %13 = hw.array_get %12[%gen_normal_fifo.u_fifo_cnt.rptr_o] {sv.namehint = "gen_normal_fifo.rdata_int"} : !hw.array<13xi32>, i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
      %15 = llhd.prb %clk_i_0 : i1
      llhd.wait (%3 : i1), ^bb2
    ^bb2:  // pred: ^bb1
      %16 = llhd.prb %clk_i_0 : i1
      %17 = comb.xor bin %15, %true : i1
      %18 = comb.and bin %17, %16 : i1
      cf.cond_br %18, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %19 = llhd.prb %gen_normal_fifo.fifo_incr_wptr : i1
      cf.cond_br %19, ^bb4, ^bb1
    ^bb4:  // pred: ^bb3
      %20 = llhd.prb %gen_normal_fifo.fifo_wptr : i4
      %21 = llhd.sig.array_get %gen_normal_fifo.storage[%20] : <!hw.array<13xi32>>
      %22 = llhd.prb %wdata_i_2 : i32
      llhd.drv %21, %22 after %0 : i32
      cf.br ^bb1
    }
    %14 = comb.xor %gen_normal_fifo.u_fifo_cnt.empty_o, %true : i1
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %wdata_i_2, %wdata_i after %1 : i32
    hw.output %9, %14, %13, %gen_normal_fifo.u_fifo_cnt.full_o, %gen_normal_fifo.u_fifo_cnt.depth_o, %gen_normal_fifo.u_fifo_cnt.err_o : i1, i1, i32, i1, i4, i1
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
  hw.module private @prim_leading_one_ppc(in %in_i : i8, out leading_one_o : i8, out ppc_out_o : i8, out idx_o : i3) {
    %c-1_i32 = hw.constant -1 : i32
    %c-1_i8 = hw.constant -1 : i8
    %c0_i24 = hw.constant 0 : i24
    %c-1_i3 = hw.constant -1 : i3
    %c0_i29 = hw.constant 0 : i29
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c0_i3 = hw.constant 0 : i3
    %false = hw.constant false
    %c8_i32 = hw.constant 8 : i32
    %c1_i32 = hw.constant 1 : i32
    %c0_i8 = hw.constant 0 : i8
    %in_i_0 = llhd.sig name "in_i" %c0_i8 : i8
    %leading_one_o = llhd.sig %c0_i8 : i8
    %idx_o = llhd.sig %c0_i3 : i3
    %ppc_out = llhd.sig %c0_i8 : i8
    %1 = llhd.prb %ppc_out : i8
    %2 = llhd.prb %in_i_0 : i8
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb4
      %8 = llhd.sig.extract %ppc_out from %c0_i3 : <i8> -> <i1>
      %9 = llhd.prb %in_i_0 : i8
      %10 = comb.extract %9 from 0 : (i8) -> i1
      llhd.drv %8, %10 after %0 : i1
      cf.br ^bb2(%c1_i32 : i32)
    ^bb2(%11: i32):  // 2 preds: ^bb1, ^bb3
      %12 = comb.icmp ult %11, %c8_i32 : i32
      cf.cond_br %12, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %13 = comb.extract %11 from 3 : (i32) -> i29
      %14 = comb.icmp eq %13, %c0_i29 : i29
      %15 = comb.extract %11 from 0 : (i32) -> i3
      %16 = comb.mux %14, %15, %c-1_i3 : i3
      %17 = llhd.sig.extract %ppc_out from %16 : <i8> -> <i1>
      %18 = llhd.prb %ppc_out : i8
      %19 = comb.add %11, %c-1_i32 : i32
      %20 = comb.extract %19 from 8 : (i32) -> i24
      %21 = comb.icmp eq %20, %c0_i24 : i24
      %22 = comb.extract %19 from 0 : (i32) -> i8
      %23 = comb.mux %21, %22, %c-1_i8 : i8
      %24 = comb.shru %18, %23 : i8
      %25 = comb.extract %24 from 0 : (i8) -> i1
      %26 = llhd.prb %in_i_0 : i8
      %27 = comb.extract %11 from 8 : (i32) -> i24
      %28 = comb.icmp eq %27, %c0_i24 : i24
      %29 = comb.extract %11 from 0 : (i32) -> i8
      %30 = comb.mux %28, %29, %c-1_i8 : i8
      %31 = comb.shru %26, %30 : i8
      %32 = comb.extract %31 from 0 : (i8) -> i1
      %33 = comb.or %25, %32 : i1
      llhd.drv %17, %33 after %0 : i1
      %34 = comb.add %11, %c1_i32 : i32
      cf.br ^bb2(%34 : i32)
    ^bb4:  // pred: ^bb2
      llhd.wait (%1, %2 : i8, i8), ^bb1
    }
    %3 = comb.extract %1 from 0 : (i8) -> i7
    %4 = comb.concat %3, %false : i7, i1
    %5 = comb.xor %1, %4 : i8
    llhd.drv %leading_one_o, %5 after %0 : i8
    %6 = llhd.prb %idx_o : i3
    %7 = llhd.prb %leading_one_o : i8
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      llhd.drv %idx_o, %c0_i3 after %0 : i3
      cf.br ^bb2(%c0_i32 : i32)
    ^bb2(%8: i32):  // 2 preds: ^bb1, ^bb5
      %9 = comb.icmp ult %8, %c8_i32 : i32
      cf.cond_br %9, ^bb3, ^bb6
    ^bb3:  // pred: ^bb2
      %10 = llhd.prb %leading_one_o : i8
      %11 = comb.extract %8 from 8 : (i32) -> i24
      %12 = comb.icmp eq %11, %c0_i24 : i24
      %13 = comb.extract %8 from 0 : (i32) -> i8
      %14 = comb.mux %12, %13, %c-1_i8 : i8
      %15 = comb.shru %10, %14 : i8
      %16 = comb.extract %15 from 0 : (i8) -> i1
      cf.cond_br %16, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %17 = comb.extract %8 from 0 : (i32) -> i3
      llhd.drv %idx_o, %17 after %0 : i3
      cf.br ^bb5
    ^bb5:  // 2 preds: ^bb3, ^bb4
      %18 = comb.add %8, %c1_i32 : i32
      cf.br ^bb2(%18 : i32)
    ^bb6:  // pred: ^bb2
      llhd.wait (%6, %7 : i3, i8), ^bb1
    }
    llhd.drv %in_i_0, %in_i after %0 : i8
    hw.output %7, %1, %6 : i8, i8, i3
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
  hw.module private @prim_onehot_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i18, in %addr_i : i5, in %en_i : i1, out err_o : i1) {
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
    %480 = comb.extract %oh_i from 0 : (i18) -> i1
    llhd.drv %479, %480 after %0 : i1
    %481 = llhd.sig.extract %and_tree from %c31_i6 : <i63> -> <i1>
    llhd.drv %481, %480 after %0 : i1
    %482 = llhd.sig.extract %err_tree from %c31_i6 : <i63> -> <i1>
    llhd.drv %482, %false after %0 : i1
    %483 = llhd.sig.extract %or_tree from %c-32_i6 : <i63> -> <i1>
    %484 = comb.extract %oh_i from 1 : (i18) -> i1
    llhd.drv %483, %484 after %0 : i1
    %485 = llhd.sig.extract %and_tree from %c-32_i6 : <i63> -> <i1>
    llhd.drv %485, %484 after %0 : i1
    %486 = llhd.sig.extract %err_tree from %c-32_i6 : <i63> -> <i1>
    llhd.drv %486, %false after %0 : i1
    %487 = llhd.sig.extract %or_tree from %c-31_i6 : <i63> -> <i1>
    %488 = comb.extract %oh_i from 2 : (i18) -> i1
    llhd.drv %487, %488 after %0 : i1
    %489 = llhd.sig.extract %and_tree from %c-31_i6 : <i63> -> <i1>
    llhd.drv %489, %488 after %0 : i1
    %490 = llhd.sig.extract %err_tree from %c-31_i6 : <i63> -> <i1>
    llhd.drv %490, %false after %0 : i1
    %491 = llhd.sig.extract %or_tree from %c-30_i6 : <i63> -> <i1>
    %492 = comb.extract %oh_i from 3 : (i18) -> i1
    llhd.drv %491, %492 after %0 : i1
    %493 = llhd.sig.extract %and_tree from %c-30_i6 : <i63> -> <i1>
    llhd.drv %493, %492 after %0 : i1
    %494 = llhd.sig.extract %err_tree from %c-30_i6 : <i63> -> <i1>
    llhd.drv %494, %false after %0 : i1
    %495 = llhd.sig.extract %or_tree from %c-29_i6 : <i63> -> <i1>
    %496 = comb.extract %oh_i from 4 : (i18) -> i1
    llhd.drv %495, %496 after %0 : i1
    %497 = llhd.sig.extract %and_tree from %c-29_i6 : <i63> -> <i1>
    llhd.drv %497, %496 after %0 : i1
    %498 = llhd.sig.extract %err_tree from %c-29_i6 : <i63> -> <i1>
    llhd.drv %498, %false after %0 : i1
    %499 = llhd.sig.extract %or_tree from %c-28_i6 : <i63> -> <i1>
    %500 = comb.extract %oh_i from 5 : (i18) -> i1
    llhd.drv %499, %500 after %0 : i1
    %501 = llhd.sig.extract %and_tree from %c-28_i6 : <i63> -> <i1>
    llhd.drv %501, %500 after %0 : i1
    %502 = llhd.sig.extract %err_tree from %c-28_i6 : <i63> -> <i1>
    llhd.drv %502, %false after %0 : i1
    %503 = llhd.sig.extract %or_tree from %c-27_i6 : <i63> -> <i1>
    %504 = comb.extract %oh_i from 6 : (i18) -> i1
    llhd.drv %503, %504 after %0 : i1
    %505 = llhd.sig.extract %and_tree from %c-27_i6 : <i63> -> <i1>
    llhd.drv %505, %504 after %0 : i1
    %506 = llhd.sig.extract %err_tree from %c-27_i6 : <i63> -> <i1>
    llhd.drv %506, %false after %0 : i1
    %507 = llhd.sig.extract %or_tree from %c-26_i6 : <i63> -> <i1>
    %508 = comb.extract %oh_i from 7 : (i18) -> i1
    llhd.drv %507, %508 after %0 : i1
    %509 = llhd.sig.extract %and_tree from %c-26_i6 : <i63> -> <i1>
    llhd.drv %509, %508 after %0 : i1
    %510 = llhd.sig.extract %err_tree from %c-26_i6 : <i63> -> <i1>
    llhd.drv %510, %false after %0 : i1
    %511 = llhd.sig.extract %or_tree from %c-25_i6 : <i63> -> <i1>
    %512 = comb.extract %oh_i from 8 : (i18) -> i1
    llhd.drv %511, %512 after %0 : i1
    %513 = llhd.sig.extract %and_tree from %c-25_i6 : <i63> -> <i1>
    llhd.drv %513, %512 after %0 : i1
    %514 = llhd.sig.extract %err_tree from %c-25_i6 : <i63> -> <i1>
    llhd.drv %514, %false after %0 : i1
    %515 = llhd.sig.extract %or_tree from %c-24_i6 : <i63> -> <i1>
    %516 = comb.extract %oh_i from 9 : (i18) -> i1
    llhd.drv %515, %516 after %0 : i1
    %517 = llhd.sig.extract %and_tree from %c-24_i6 : <i63> -> <i1>
    llhd.drv %517, %516 after %0 : i1
    %518 = llhd.sig.extract %err_tree from %c-24_i6 : <i63> -> <i1>
    llhd.drv %518, %false after %0 : i1
    %519 = llhd.sig.extract %or_tree from %c-23_i6 : <i63> -> <i1>
    %520 = comb.extract %oh_i from 10 : (i18) -> i1
    llhd.drv %519, %520 after %0 : i1
    %521 = llhd.sig.extract %and_tree from %c-23_i6 : <i63> -> <i1>
    llhd.drv %521, %520 after %0 : i1
    %522 = llhd.sig.extract %err_tree from %c-23_i6 : <i63> -> <i1>
    llhd.drv %522, %false after %0 : i1
    %523 = llhd.sig.extract %or_tree from %c-22_i6 : <i63> -> <i1>
    %524 = comb.extract %oh_i from 11 : (i18) -> i1
    llhd.drv %523, %524 after %0 : i1
    %525 = llhd.sig.extract %and_tree from %c-22_i6 : <i63> -> <i1>
    llhd.drv %525, %524 after %0 : i1
    %526 = llhd.sig.extract %err_tree from %c-22_i6 : <i63> -> <i1>
    llhd.drv %526, %false after %0 : i1
    %527 = llhd.sig.extract %or_tree from %c-21_i6 : <i63> -> <i1>
    %528 = comb.extract %oh_i from 12 : (i18) -> i1
    llhd.drv %527, %528 after %0 : i1
    %529 = llhd.sig.extract %and_tree from %c-21_i6 : <i63> -> <i1>
    llhd.drv %529, %528 after %0 : i1
    %530 = llhd.sig.extract %err_tree from %c-21_i6 : <i63> -> <i1>
    llhd.drv %530, %false after %0 : i1
    %531 = llhd.sig.extract %or_tree from %c-20_i6 : <i63> -> <i1>
    %532 = comb.extract %oh_i from 13 : (i18) -> i1
    llhd.drv %531, %532 after %0 : i1
    %533 = llhd.sig.extract %and_tree from %c-20_i6 : <i63> -> <i1>
    llhd.drv %533, %532 after %0 : i1
    %534 = llhd.sig.extract %err_tree from %c-20_i6 : <i63> -> <i1>
    llhd.drv %534, %false after %0 : i1
    %535 = llhd.sig.extract %or_tree from %c-19_i6 : <i63> -> <i1>
    %536 = comb.extract %oh_i from 14 : (i18) -> i1
    llhd.drv %535, %536 after %0 : i1
    %537 = llhd.sig.extract %and_tree from %c-19_i6 : <i63> -> <i1>
    llhd.drv %537, %536 after %0 : i1
    %538 = llhd.sig.extract %err_tree from %c-19_i6 : <i63> -> <i1>
    llhd.drv %538, %false after %0 : i1
    %539 = llhd.sig.extract %or_tree from %c-18_i6 : <i63> -> <i1>
    %540 = comb.extract %oh_i from 15 : (i18) -> i1
    llhd.drv %539, %540 after %0 : i1
    %541 = llhd.sig.extract %and_tree from %c-18_i6 : <i63> -> <i1>
    llhd.drv %541, %540 after %0 : i1
    %542 = llhd.sig.extract %err_tree from %c-18_i6 : <i63> -> <i1>
    llhd.drv %542, %false after %0 : i1
    %543 = llhd.sig.extract %or_tree from %c-17_i6 : <i63> -> <i1>
    %544 = comb.extract %oh_i from 16 : (i18) -> i1
    llhd.drv %543, %544 after %0 : i1
    %545 = llhd.sig.extract %and_tree from %c-17_i6 : <i63> -> <i1>
    llhd.drv %545, %544 after %0 : i1
    %546 = llhd.sig.extract %err_tree from %c-17_i6 : <i63> -> <i1>
    llhd.drv %546, %false after %0 : i1
    %547 = llhd.sig.extract %or_tree from %c-16_i6 : <i63> -> <i1>
    %548 = comb.extract %oh_i from 17 : (i18) -> i1
    llhd.drv %547, %548 after %0 : i1
    %549 = llhd.sig.extract %and_tree from %c-16_i6 : <i63> -> <i1>
    llhd.drv %549, %548 after %0 : i1
    %550 = llhd.sig.extract %err_tree from %c-16_i6 : <i63> -> <i1>
    llhd.drv %550, %false after %0 : i1
    %551 = llhd.sig.extract %or_tree from %c-15_i6 : <i63> -> <i1>
    llhd.drv %551, %false after %0 : i1
    %552 = llhd.sig.extract %and_tree from %c-15_i6 : <i63> -> <i1>
    llhd.drv %552, %false after %0 : i1
    %553 = llhd.sig.extract %err_tree from %c-15_i6 : <i63> -> <i1>
    llhd.drv %553, %false after %0 : i1
    %554 = llhd.sig.extract %or_tree from %c-14_i6 : <i63> -> <i1>
    llhd.drv %554, %false after %0 : i1
    %555 = llhd.sig.extract %and_tree from %c-14_i6 : <i63> -> <i1>
    llhd.drv %555, %false after %0 : i1
    %556 = llhd.sig.extract %err_tree from %c-14_i6 : <i63> -> <i1>
    llhd.drv %556, %false after %0 : i1
    %557 = llhd.sig.extract %or_tree from %c-13_i6 : <i63> -> <i1>
    llhd.drv %557, %false after %0 : i1
    %558 = llhd.sig.extract %and_tree from %c-13_i6 : <i63> -> <i1>
    llhd.drv %558, %false after %0 : i1
    %559 = llhd.sig.extract %err_tree from %c-13_i6 : <i63> -> <i1>
    llhd.drv %559, %false after %0 : i1
    %560 = llhd.sig.extract %or_tree from %c-12_i6 : <i63> -> <i1>
    llhd.drv %560, %false after %0 : i1
    %561 = llhd.sig.extract %and_tree from %c-12_i6 : <i63> -> <i1>
    llhd.drv %561, %false after %0 : i1
    %562 = llhd.sig.extract %err_tree from %c-12_i6 : <i63> -> <i1>
    llhd.drv %562, %false after %0 : i1
    %563 = llhd.sig.extract %or_tree from %c-11_i6 : <i63> -> <i1>
    llhd.drv %563, %false after %0 : i1
    %564 = llhd.sig.extract %and_tree from %c-11_i6 : <i63> -> <i1>
    llhd.drv %564, %false after %0 : i1
    %565 = llhd.sig.extract %err_tree from %c-11_i6 : <i63> -> <i1>
    llhd.drv %565, %false after %0 : i1
    %566 = llhd.sig.extract %or_tree from %c-10_i6 : <i63> -> <i1>
    llhd.drv %566, %false after %0 : i1
    %567 = llhd.sig.extract %and_tree from %c-10_i6 : <i63> -> <i1>
    llhd.drv %567, %false after %0 : i1
    %568 = llhd.sig.extract %err_tree from %c-10_i6 : <i63> -> <i1>
    llhd.drv %568, %false after %0 : i1
    %569 = llhd.sig.extract %or_tree from %c-9_i6 : <i63> -> <i1>
    llhd.drv %569, %false after %0 : i1
    %570 = llhd.sig.extract %and_tree from %c-9_i6 : <i63> -> <i1>
    llhd.drv %570, %false after %0 : i1
    %571 = llhd.sig.extract %err_tree from %c-9_i6 : <i63> -> <i1>
    llhd.drv %571, %false after %0 : i1
    %572 = llhd.sig.extract %or_tree from %c-8_i6 : <i63> -> <i1>
    llhd.drv %572, %false after %0 : i1
    %573 = llhd.sig.extract %and_tree from %c-8_i6 : <i63> -> <i1>
    llhd.drv %573, %false after %0 : i1
    %574 = llhd.sig.extract %err_tree from %c-8_i6 : <i63> -> <i1>
    llhd.drv %574, %false after %0 : i1
    %575 = llhd.sig.extract %or_tree from %c-7_i6 : <i63> -> <i1>
    llhd.drv %575, %false after %0 : i1
    %576 = llhd.sig.extract %and_tree from %c-7_i6 : <i63> -> <i1>
    llhd.drv %576, %false after %0 : i1
    %577 = llhd.sig.extract %err_tree from %c-7_i6 : <i63> -> <i1>
    llhd.drv %577, %false after %0 : i1
    %578 = llhd.sig.extract %or_tree from %c-6_i6 : <i63> -> <i1>
    llhd.drv %578, %false after %0 : i1
    %579 = llhd.sig.extract %and_tree from %c-6_i6 : <i63> -> <i1>
    llhd.drv %579, %false after %0 : i1
    %580 = llhd.sig.extract %err_tree from %c-6_i6 : <i63> -> <i1>
    llhd.drv %580, %false after %0 : i1
    %581 = llhd.sig.extract %or_tree from %c-5_i6 : <i63> -> <i1>
    llhd.drv %581, %false after %0 : i1
    %582 = llhd.sig.extract %and_tree from %c-5_i6 : <i63> -> <i1>
    llhd.drv %582, %false after %0 : i1
    %583 = llhd.sig.extract %err_tree from %c-5_i6 : <i63> -> <i1>
    llhd.drv %583, %false after %0 : i1
    %584 = llhd.sig.extract %or_tree from %c-4_i6 : <i63> -> <i1>
    llhd.drv %584, %false after %0 : i1
    %585 = llhd.sig.extract %and_tree from %c-4_i6 : <i63> -> <i1>
    llhd.drv %585, %false after %0 : i1
    %586 = llhd.sig.extract %err_tree from %c-4_i6 : <i63> -> <i1>
    llhd.drv %586, %false after %0 : i1
    %587 = llhd.sig.extract %or_tree from %c-3_i6 : <i63> -> <i1>
    llhd.drv %587, %false after %0 : i1
    %588 = llhd.sig.extract %and_tree from %c-3_i6 : <i63> -> <i1>
    llhd.drv %588, %false after %0 : i1
    %589 = llhd.sig.extract %err_tree from %c-3_i6 : <i63> -> <i1>
    llhd.drv %589, %false after %0 : i1
    %590 = llhd.sig.extract %or_tree from %c-2_i6 : <i63> -> <i1>
    llhd.drv %590, %false after %0 : i1
    %591 = llhd.sig.extract %and_tree from %c-2_i6 : <i63> -> <i1>
    llhd.drv %591, %false after %0 : i1
    %592 = llhd.sig.extract %err_tree from %c-2_i6 : <i63> -> <i1>
    llhd.drv %592, %false after %0 : i1
    %593 = comb.or %594, %597 : i1
    %594 = comb.extract %17 from 0 {sv.namehint = "oh0_err"} : (i63) -> i1
    %595 = comb.xor %en_i, %true : i1
    %596 = comb.extract %2 from 0 : (i63) -> i1
    %597 = comb.and %595, %596 {sv.namehint = "enable_err"} : i1
    hw.output %593 : i1
  }
  hw.module private @prim_packer_fifo(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, in %wdata_i : i128, out wready_o : i1, out rvalid_o : i1, out rdata_o : i128, in %rready_i : i1, out depth_o : i1) {
    %c0_i120 = hw.constant 0 : i120
    %c0_i7 = hw.constant 0 : i7
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i128 = hw.constant 0 : i128
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %wdata_i_2 = llhd.sig name "wdata_i" %c0_i128 : i128
    %load_data = llhd.sig %false : i1
    %depth_q = llhd.sig %false : i1
    %depth_d = llhd.sig %false : i1
    %data_q = llhd.sig %c0_i128 : i128
    %data_d = llhd.sig %c0_i128 : i128
    %clr_q = llhd.sig %false : i1
    %clr_d = llhd.sig %false : i1
    %gen_unpack_mode.pull_data = llhd.sig %false : i1
    %gen_unpack_mode.ptr_q = llhd.sig %false : i1
    %gen_unpack_mode.ptr_d = llhd.sig %false : i1
    %gen_unpack_mode.max_value = llhd.sig %false : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
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
      llhd.drv %depth_q, %false after %1 : i1
      llhd.drv %data_q, %c0_i128 after %1 : i128
      llhd.drv %clr_q, %true after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %44 = llhd.prb %depth_d : i1
      llhd.drv %depth_q, %44 after %1 : i1
      %45 = llhd.prb %data_d : i128
      llhd.drv %data_q, %45 after %1 : i128
      %46 = llhd.prb %clr_d : i1
      llhd.drv %clr_q, %46 after %1 : i1
      cf.br ^bb1
    }
    llhd.drv %clr_d, %clr_i after %0 : i1
    %4 = llhd.prb %depth_q : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
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
      llhd.drv %gen_unpack_mode.ptr_q, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %44 = llhd.prb %gen_unpack_mode.ptr_d : i1
      llhd.drv %gen_unpack_mode.ptr_q, %44 after %1 : i1
      cf.br ^bb1
    }
    llhd.drv %gen_unpack_mode.max_value, %true after %0 : i1
    %5 = llhd.prb %data_q : i128
    %6 = llhd.prb %gen_unpack_mode.ptr_q : i1
    %7 = comb.concat %c0_i120, %6, %c0_i7 : i120, i1, i7
    %8 = comb.shru %5, %7 {sv.namehint = "gen_unpack_mode.rdata_shifted"} : i128
    %9 = comb.and %rready_i, %4 : i1
    %10 = llhd.prb %clr_q : i1
    %11 = comb.or %9, %10 {sv.namehint = "clear_status"} : i1
    %12 = comb.and %wvalid_i, %31 : i1
    llhd.drv %load_data, %12 after %0 : i1
    %13 = comb.and %32, %rready_i : i1
    llhd.drv %gen_unpack_mode.pull_data, %13 after %0 : i1
    %14 = llhd.prb %load_data : i1
    %15 = llhd.prb %gen_unpack_mode.max_value : i1
    %16 = llhd.prb %gen_unpack_mode.pull_data : i1
    %17 = comb.add %4, %true : i1
    %18 = comb.mux %16, %17, %4 : i1
    %19 = comb.mux %14, %15, %18 : i1
    %20 = comb.xor %11, %true : i1
    %21 = comb.and %20, %19 : i1
    llhd.drv %depth_d, %21 after %0 : i1
    %22 = comb.add %6, %true : i1
    %23 = comb.mux %16, %22, %6 : i1
    %24 = comb.xor %11, %true : i1
    %25 = comb.and %24, %23 : i1
    llhd.drv %gen_unpack_mode.ptr_d, %25 after %0 : i1
    %26 = llhd.prb %wdata_i_2 : i128
    %27 = comb.mux %14, %26, %5 : i128
    %28 = comb.mux %10, %c0_i128, %27 : i128
    llhd.drv %data_d, %28 after %0 : i128
    %29 = comb.xor %4, %true : i1
    %30 = comb.xor %10, %true : i1
    %31 = comb.and %29, %30 : i1
    %32 = comb.and %4, %30 : i1
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %wdata_i_2, %wdata_i after %0 : i128
    hw.output %31, %32, %8, %4 : i1, i1, i128, i1
  }
  hw.module private @prim_packer_fifo_16(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, in %wdata_i : i128, out wready_o : i1, out rvalid_o : i1, out rdata_o : i32, in %rready_i : i1, out depth_o : i3) {
    %c-1_i3 = hw.constant -1 : i3
    %c0_i120 = hw.constant 0 : i120
    %c0_i5 = hw.constant 0 : i5
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %c1_i3 = hw.constant 1 : i3
    %false = hw.constant false
    %c-4_i3 = hw.constant -4 : i3
    %true = hw.constant true
    %c0_i128 = hw.constant 0 : i128
    %c0_i3 = hw.constant 0 : i3
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %wdata_i_2 = llhd.sig name "wdata_i" %c0_i128 : i128
    %load_data = llhd.sig %false : i1
    %depth_q = llhd.sig %c0_i3 : i3
    %depth_d = llhd.sig %c0_i3 : i3
    %data_q = llhd.sig %c0_i128 : i128
    %data_d = llhd.sig %c0_i128 : i128
    %clr_q = llhd.sig %false : i1
    %clr_d = llhd.sig %false : i1
    %gen_unpack_mode.pull_data = llhd.sig %false : i1
    %gen_unpack_mode.ptr_q = llhd.sig %c0_i3 : i3
    %gen_unpack_mode.ptr_d = llhd.sig %c0_i3 : i3
    %gen_unpack_mode.max_value = llhd.sig %c0_i3 : i3
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %34 = llhd.prb %clk_i_0 : i1
      %35 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %36 = llhd.prb %clk_i_0 : i1
      %37 = comb.xor bin %34, %true : i1
      %38 = comb.and bin %37, %36 : i1
      %39 = llhd.prb %rst_ni_1 : i1
      %40 = comb.xor bin %39, %true : i1
      %41 = comb.and bin %35, %40 : i1
      %42 = comb.or bin %38, %41 : i1
      cf.cond_br %42, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %43 = llhd.prb %rst_ni_1 : i1
      %44 = comb.xor %43, %true : i1
      cf.cond_br %44, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %depth_q, %c0_i3 after %1 : i3
      llhd.drv %data_q, %c0_i128 after %1 : i128
      llhd.drv %clr_q, %true after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %45 = llhd.prb %depth_d : i3
      llhd.drv %depth_q, %45 after %1 : i3
      %46 = llhd.prb %data_d : i128
      llhd.drv %data_q, %46 after %1 : i128
      %47 = llhd.prb %clr_d : i1
      llhd.drv %clr_q, %47 after %1 : i1
      cf.br ^bb1
    }
    llhd.drv %clr_d, %clr_i after %0 : i1
    %4 = llhd.prb %depth_q : i3
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %34 = llhd.prb %clk_i_0 : i1
      %35 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %36 = llhd.prb %clk_i_0 : i1
      %37 = comb.xor bin %34, %true : i1
      %38 = comb.and bin %37, %36 : i1
      %39 = llhd.prb %rst_ni_1 : i1
      %40 = comb.xor bin %39, %true : i1
      %41 = comb.and bin %35, %40 : i1
      %42 = comb.or bin %38, %41 : i1
      cf.cond_br %42, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %43 = llhd.prb %rst_ni_1 : i1
      %44 = comb.xor %43, %true : i1
      cf.cond_br %44, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_unpack_mode.ptr_q, %c0_i3 after %1 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %45 = llhd.prb %gen_unpack_mode.ptr_d : i3
      llhd.drv %gen_unpack_mode.ptr_q, %45 after %1 : i3
      cf.br ^bb1
    }
    llhd.drv %gen_unpack_mode.max_value, %c-4_i3 after %0 : i3
    %5 = llhd.prb %data_q : i128
    %6 = llhd.prb %gen_unpack_mode.ptr_q : i3
    %7 = comb.concat %c0_i120, %6, %c0_i5 : i120, i3, i5
    %8 = comb.shru %5, %7 {sv.namehint = "gen_unpack_mode.rdata_shifted"} : i128
    %9 = comb.icmp eq %4, %c1_i3 : i3
    %10 = comb.and %rready_i, %9 : i1
    %11 = llhd.prb %clr_q : i1
    %12 = comb.or %10, %11 {sv.namehint = "clear_status"} : i1
    %13 = comb.and %wvalid_i, %30 : i1
    llhd.drv %load_data, %13 after %0 : i1
    %14 = comb.and %33, %rready_i : i1
    llhd.drv %gen_unpack_mode.pull_data, %14 after %0 : i1
    %15 = llhd.prb %load_data : i1
    %16 = llhd.prb %gen_unpack_mode.max_value : i3
    %17 = llhd.prb %gen_unpack_mode.pull_data : i1
    %18 = comb.add %4, %c-1_i3 : i3
    %19 = comb.mux %17, %18, %4 : i3
    %20 = comb.mux %15, %16, %19 : i3
    %21 = comb.mux %12, %c0_i3, %20 : i3
    llhd.drv %depth_d, %21 after %0 : i3
    %22 = comb.add %6, %c1_i3 : i3
    %23 = comb.mux %17, %22, %6 : i3
    %24 = comb.mux %12, %c0_i3, %23 : i3
    llhd.drv %gen_unpack_mode.ptr_d, %24 after %0 : i3
    %25 = llhd.prb %wdata_i_2 : i128
    %26 = comb.mux %15, %25, %5 : i128
    %27 = comb.mux %11, %c0_i128, %26 : i128
    llhd.drv %data_d, %27 after %0 : i128
    %28 = comb.icmp eq %4, %c0_i3 : i3
    %29 = comb.xor %11, %true : i1
    %30 = comb.and %28, %29 : i1
    %31 = comb.extract %8 from 0 : (i128) -> i32
    %32 = comb.xor %28, %true : i1
    %33 = comb.and %32, %29 : i1
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %wdata_i_2, %wdata_i after %0 : i128
    hw.output %30, %33, %31, %4 : i1, i1, i32, i3
  }
  hw.module private @prim_reg_we_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i18, in %en_i : i1, out err_o : i1) {
    %c0_i5 = hw.constant 0 : i5
    %u_prim_buf.out_o = hw.instance "u_prim_buf" @prim_buf(in_i: %oh_i: i18) -> (out_o: i18) {sv.namehint = "oh_buf"}
    %u_prim_onehot_check.err_o = hw.instance "u_prim_onehot_check" @prim_onehot_check(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, oh_i: %u_prim_buf.out_o: i18, addr_i: %c0_i5: i5, en_i: %en_i: i1) -> (err_o: i1)
    hw.output %u_prim_onehot_check.err_o : i1
  }
  hw.module private @prim_sec_anchor_buf(in %in_i : i2, out out_o : i2) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf_32(in_i: %in_i: i2) -> (out_o: i2)
    hw.output %u_secure_anchor_buf.out_o : i2
  }
  hw.module private @prim_sec_anchor_buf_17(in %in_i : i1, out out_o : i1) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf_28(in_i: %in_i: i1) -> (out_o: i1)
    hw.output %u_secure_anchor_buf.out_o : i1
  }
  hw.module private @prim_sec_anchor_flop(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_o : i2) {
    %u_secure_anchor_flop.q_o = hw.instance "u_secure_anchor_flop" @prim_flop_34(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %d_i: i2) -> (q_o: i2)
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
    %u_state_flop.q_o = hw.instance "u_state_flop" @prim_flop_36(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %state_i: i9) -> (q_o: i9) {sv.namehint = "state_raw"}
    hw.output %u_state_flop.q_o : i9
  }
  hw.module private @prim_sparse_fsm_flop_31(in %clk_i : i1, in %rst_ni : i1, in %state_i : i9, out state_o : i9) {
    %u_state_flop.q_o = hw.instance "u_state_flop" @prim_flop_37(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %state_i: i9) -> (q_o: i9) {sv.namehint = "state_raw"}
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
  hw.module private @prim_subreg_arb_21(in %we : i1, in %wd : i4, in %de : i1, in %d : i4, in %q : i4, out wr_en : i1, out wr_data : i4) {
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
  hw.module private @prim_subreg_arb_22(in %we : i1, in %wd : i32, in %de : i1, in %d : i32, in %q : i32, out wr_en : i1, out wr_data : i32) {
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
  hw.module private @prim_subreg_arb_23(in %we : i1, in %wd : i1, in %de : i1, in %d : i1, in %q : i1, out wr_en : i1, out wr_data : i1) {
    hw.output %de, %d : i1, i1
  }
  hw.module private @prim_subreg_arb_24(in %we : i1, in %wd : i3, in %de : i1, in %d : i3, in %q : i3, out wr_en : i1, out wr_data : i3) {
    hw.output %de, %d : i1, i3
  }
  hw.module private @prim_subreg_arb_25(in %we : i1, in %wd : i4, in %de : i1, in %d : i4, in %q : i4, out wr_en : i1, out wr_data : i4) {
    hw.output %de, %d : i1, i4
  }
  hw.module private @prim_subreg_arb_26(in %we : i1, in %wd : i5, in %de : i1, in %d : i5, in %q : i5, out wr_en : i1, out wr_data : i5) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i5 = hw.constant 0 : i5
    %wd_0 = llhd.sig name "wd" %c0_i5 : i5
    %d_1 = llhd.sig name "d" %c0_i5 : i5
    %1 = comb.or %we, %de : i1
    %2 = llhd.prb %wd_0 : i5
    %3 = llhd.prb %d_1 : i5
    %4 = comb.mux %we, %2, %3 : i5
    llhd.drv %wd_0, %wd after %0 : i5
    llhd.drv %d_1, %d after %0 : i5
    hw.output %1, %4 : i1, i5
  }
  hw.module private @prim_subreg_arb_27(in %we : i1, in %wd : i9, in %de : i1, in %d : i9, in %q : i9, out wr_en : i1, out wr_data : i9) {
    hw.output %de, %d : i1, i9
  }
  hw.module private @prim_subreg_ext(in %re : i1, in %we : i1, in %wd : i1, in %d : i1, out qe : i1, out qre : i1, out q : i1, out ds : i1, out qs : i1) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i1, i1, i1
  }
  hw.module private @prim_subreg_ext_6(in %re : i1, in %we : i1, in %wd : i32, in %d : i32, out qe : i1, out qre : i1, out q : i32, out ds : i32, out qs : i32) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i32, i32, i32
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
  hw.module private @prim_subreg_3(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i4, in %de : i1, in %d : i4, out qe : i1, out q : i4, out ds : i4, out qs : i4) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_21(we: %we: i1, wd: %wd: i4, de: %de: i1, d: %d: i4, q: %4: i4) -> (wr_en: i1, wr_data: i4)
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
  hw.module private @prim_subreg_4(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c2305_i32 = hw.constant 2305 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_22(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c2305_i32 after %0 : i32
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
  hw.module private @prim_subreg_5(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c16773123_i32 = hw.constant 16773123 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_22(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c16773123_i32 after %0 : i32
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
  hw.module private @prim_subreg_7(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i1, in %de : i1, in %d : i1, out qe : i1, out q : i1, out ds : i1, out qs : i1) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_23(we: %we: i1, wd: %wd: i1, de: %de: i1, d: %d: i1, q: %4: i1) -> (wr_en: i1, wr_data: i1)
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
  hw.module private @prim_subreg_8(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i3, in %de : i1, in %d : i3, out qe : i1, out q : i3, out ds : i3, out qs : i3) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i3 = hw.constant 0 : i3
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %q = llhd.sig %c0_i3 : i3
    %qs = llhd.sig %c0_i3 : i3
    %wr_en = llhd.sig %false : i1
    %wr_data = llhd.sig %c0_i3 : i3
    %4 = llhd.prb %q : i3
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_24(we: %we: i1, wd: %wd: i3, de: %de: i1, d: %d: i3, q: %4: i3) -> (wr_en: i1, wr_data: i3)
    llhd.drv %wr_en, %wr_en_data_arb.wr_en after %1 : i1
    llhd.drv %wr_data, %wr_en_data_arb.wr_data after %1 : i3
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
      llhd.drv %q, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %20 = llhd.prb %wr_en : i1
      cf.cond_br %20, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %21 = llhd.prb %wr_data : i3
      llhd.drv %q, %21 after %0 : i3
      cf.br ^bb1
    }
    %5 = llhd.prb %wr_en : i1
    %6 = llhd.prb %wr_data : i3
    %7 = llhd.prb %qs : i3
    %8 = comb.mux %5, %6, %7 : i3
    llhd.drv %qs, %4 after %1 : i3
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    hw.output %we, %4, %8, %7 : i1, i3, i3, i3
  }
  hw.module private @prim_subreg_9(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i4, in %de : i1, in %d : i4, out qe : i1, out q : i4, out ds : i4, out qs : i4) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_25(we: %we: i1, wd: %wd: i4, de: %de: i1, d: %d: i4, q: %4: i4) -> (wr_en: i1, wr_data: i4)
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
      llhd.drv %q, %c0_i4 after %0 : i4
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
  hw.module private @prim_subreg_10(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_22(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c0_i32 after %0 : i32
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
  hw.module private @prim_subreg_11(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i1, in %de : i1, in %d : i1, out qe : i1, out q : i1, out ds : i1, out qs : i1) {
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
  hw.module private @prim_subreg_12(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i5, in %de : i1, in %d : i5, out qe : i1, out q : i5, out ds : i5, out qs : i5) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i5 = hw.constant 0 : i5
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %q = llhd.sig %c0_i5 : i5
    %qs = llhd.sig %c0_i5 : i5
    %wr_en = llhd.sig %false : i1
    %wr_data = llhd.sig %c0_i5 : i5
    %4 = llhd.prb %q : i5
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_26(we: %we: i1, wd: %wd: i5, de: %de: i1, d: %d: i5, q: %4: i5) -> (wr_en: i1, wr_data: i5)
    llhd.drv %wr_en, %wr_en_data_arb.wr_en after %1 : i1
    llhd.drv %wr_data, %wr_en_data_arb.wr_data after %1 : i5
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
      llhd.drv %q, %c0_i5 after %0 : i5
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %20 = llhd.prb %wr_en : i1
      cf.cond_br %20, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %21 = llhd.prb %wr_data : i5
      llhd.drv %q, %21 after %0 : i5
      cf.br ^bb1
    }
    %5 = llhd.prb %wr_en : i1
    %6 = llhd.prb %wr_data : i5
    %7 = llhd.prb %qs : i5
    %8 = comb.mux %5, %6, %7 : i5
    llhd.drv %qs, %4 after %1 : i5
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    hw.output %we, %4, %8, %7 : i1, i5, i5, i5
  }
  hw.module private @prim_subreg_13(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i9, in %de : i1, in %d : i9, out qe : i1, out q : i9, out ds : i9, out qs : i9) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i9 = hw.constant 0 : i9
    %c193_i9 = hw.constant 193 : i9
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %q = llhd.sig %c0_i9 : i9
    %qs = llhd.sig %c0_i9 : i9
    %wr_en = llhd.sig %false : i1
    %wr_data = llhd.sig %c0_i9 : i9
    %4 = llhd.prb %q : i9
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_27(we: %we: i1, wd: %wd: i9, de: %de: i1, d: %d: i9, q: %4: i9) -> (wr_en: i1, wr_data: i9)
    llhd.drv %wr_en, %wr_en_data_arb.wr_en after %1 : i1
    llhd.drv %wr_data, %wr_en_data_arb.wr_data after %1 : i9
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
      llhd.drv %q, %c193_i9 after %0 : i9
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %20 = llhd.prb %wr_en : i1
      cf.cond_br %20, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %21 = llhd.prb %wr_data : i9
      llhd.drv %q, %21 after %0 : i9
      cf.br ^bb1
    }
    %5 = llhd.prb %wr_en : i1
    %6 = llhd.prb %wr_data : i9
    %7 = llhd.prb %qs : i9
    %8 = comb.mux %5, %6, %7 : i9
    llhd.drv %qs, %4 after %1 : i9
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    hw.output %we, %4, %8, %7 : i1, i9, i9, i9
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
  hw.module private @prim_mubi4_sync(in %clk_i : i1, in %rst_ni : i1, in %mubi_i : i4, out mubi_o : !hw.array<20xi4>) {
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
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %2 = hw.aggregate_constant [0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4] : !hw.array<20xi4>
    %c0_i4 = hw.constant 0 : i4
    %c-7_i4 = hw.constant -7 : i4
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %mubi_i_2 = llhd.sig name "mubi_i" %c0_i4 : i4
    %mubi_o = llhd.sig %2 : !hw.array<20xi4>
    %gen_no_flops.unused_logic = llhd.sig %c0_i4 : i4
    %gen_buffs_0.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_1.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_2.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_3.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_4.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_5.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_6.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_7.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_8.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_9.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_10.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_11.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_12.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_13.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_14.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_15.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_16.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_17.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_18.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_19.mubi_out = llhd.sig %c0_i4 : i4
    %5 = comb.extract %89 from 0 : (i4) -> i1
    %6 = llhd.sig.extract %gen_buffs_0.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_0.u_prim_buf" @prim_buf_28(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %6, %gen_buffs_0.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %7 = comb.extract %89 from 1 : (i4) -> i1
    %8 = llhd.sig.extract %gen_buffs_0.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_1.u_prim_buf" @prim_buf_28(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %8, %gen_buffs_0.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %9 = comb.extract %89 from 2 : (i4) -> i1
    %10 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_2.u_prim_buf" @prim_buf_28(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %10, %gen_buffs_0.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %11 = comb.extract %89 from 3 : (i4) -> i1
    %12 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_3.u_prim_buf" @prim_buf_28(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %12, %gen_buffs_0.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %13 = llhd.sig.extract %gen_buffs_1.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_0.u_prim_buf" @prim_buf_28(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %13, %gen_buffs_1.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %14 = llhd.sig.extract %gen_buffs_1.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_1.u_prim_buf" @prim_buf_28(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %14, %gen_buffs_1.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %15 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_2.u_prim_buf" @prim_buf_28(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %15, %gen_buffs_1.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %16 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_3.u_prim_buf" @prim_buf_28(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %16, %gen_buffs_1.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %17 = llhd.sig.extract %gen_buffs_2.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_0.u_prim_buf" @prim_buf_28(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %17, %gen_buffs_2.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %18 = llhd.sig.extract %gen_buffs_2.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_1.u_prim_buf" @prim_buf_28(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %18, %gen_buffs_2.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %19 = llhd.sig.extract %gen_buffs_2.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_2.u_prim_buf" @prim_buf_28(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %19, %gen_buffs_2.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %20 = llhd.sig.extract %gen_buffs_2.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_3.u_prim_buf" @prim_buf_28(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %20, %gen_buffs_2.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %21 = llhd.sig.extract %gen_buffs_3.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_0.u_prim_buf" @prim_buf_28(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %21, %gen_buffs_3.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %22 = llhd.sig.extract %gen_buffs_3.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_1.u_prim_buf" @prim_buf_28(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %22, %gen_buffs_3.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %23 = llhd.sig.extract %gen_buffs_3.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_2.u_prim_buf" @prim_buf_28(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %23, %gen_buffs_3.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %24 = llhd.sig.extract %gen_buffs_3.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_3.u_prim_buf" @prim_buf_28(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %24, %gen_buffs_3.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %25 = llhd.sig.extract %gen_buffs_4.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_4.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_4.gen_bits_0.u_prim_buf" @prim_buf_28(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %25, %gen_buffs_4.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %26 = llhd.sig.extract %gen_buffs_4.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_4.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_4.gen_bits_1.u_prim_buf" @prim_buf_28(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %26, %gen_buffs_4.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %27 = llhd.sig.extract %gen_buffs_4.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_4.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_4.gen_bits_2.u_prim_buf" @prim_buf_28(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %27, %gen_buffs_4.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %28 = llhd.sig.extract %gen_buffs_4.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_4.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_4.gen_bits_3.u_prim_buf" @prim_buf_28(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %28, %gen_buffs_4.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %29 = llhd.sig.extract %gen_buffs_5.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_5.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_5.gen_bits_0.u_prim_buf" @prim_buf_28(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %29, %gen_buffs_5.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %30 = llhd.sig.extract %gen_buffs_5.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_5.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_5.gen_bits_1.u_prim_buf" @prim_buf_28(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %30, %gen_buffs_5.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %31 = llhd.sig.extract %gen_buffs_5.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_5.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_5.gen_bits_2.u_prim_buf" @prim_buf_28(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %31, %gen_buffs_5.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %32 = llhd.sig.extract %gen_buffs_5.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_5.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_5.gen_bits_3.u_prim_buf" @prim_buf_28(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %32, %gen_buffs_5.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %33 = llhd.sig.extract %gen_buffs_6.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_6.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_6.gen_bits_0.u_prim_buf" @prim_buf_28(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %33, %gen_buffs_6.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %34 = llhd.sig.extract %gen_buffs_6.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_6.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_6.gen_bits_1.u_prim_buf" @prim_buf_28(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %34, %gen_buffs_6.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %35 = llhd.sig.extract %gen_buffs_6.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_6.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_6.gen_bits_2.u_prim_buf" @prim_buf_28(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %35, %gen_buffs_6.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %36 = llhd.sig.extract %gen_buffs_6.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_6.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_6.gen_bits_3.u_prim_buf" @prim_buf_28(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %36, %gen_buffs_6.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %37 = llhd.sig.extract %gen_buffs_7.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_7.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_7.gen_bits_0.u_prim_buf" @prim_buf_28(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %37, %gen_buffs_7.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %38 = llhd.sig.extract %gen_buffs_7.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_7.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_7.gen_bits_1.u_prim_buf" @prim_buf_28(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %38, %gen_buffs_7.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %39 = llhd.sig.extract %gen_buffs_7.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_7.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_7.gen_bits_2.u_prim_buf" @prim_buf_28(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %39, %gen_buffs_7.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %40 = llhd.sig.extract %gen_buffs_7.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_7.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_7.gen_bits_3.u_prim_buf" @prim_buf_28(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %40, %gen_buffs_7.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %41 = llhd.sig.extract %gen_buffs_8.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_8.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_8.gen_bits_0.u_prim_buf" @prim_buf_28(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %41, %gen_buffs_8.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %42 = llhd.sig.extract %gen_buffs_8.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_8.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_8.gen_bits_1.u_prim_buf" @prim_buf_28(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %42, %gen_buffs_8.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %43 = llhd.sig.extract %gen_buffs_8.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_8.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_8.gen_bits_2.u_prim_buf" @prim_buf_28(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %43, %gen_buffs_8.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %44 = llhd.sig.extract %gen_buffs_8.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_8.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_8.gen_bits_3.u_prim_buf" @prim_buf_28(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %44, %gen_buffs_8.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %45 = llhd.sig.extract %gen_buffs_9.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_9.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_9.gen_bits_0.u_prim_buf" @prim_buf_28(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %45, %gen_buffs_9.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %46 = llhd.sig.extract %gen_buffs_9.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_9.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_9.gen_bits_1.u_prim_buf" @prim_buf_28(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %46, %gen_buffs_9.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %47 = llhd.sig.extract %gen_buffs_9.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_9.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_9.gen_bits_2.u_prim_buf" @prim_buf_28(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %47, %gen_buffs_9.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %48 = llhd.sig.extract %gen_buffs_9.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_9.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_9.gen_bits_3.u_prim_buf" @prim_buf_28(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %48, %gen_buffs_9.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %49 = llhd.sig.extract %gen_buffs_10.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_10.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_10.gen_bits_0.u_prim_buf" @prim_buf_28(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %49, %gen_buffs_10.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %50 = llhd.sig.extract %gen_buffs_10.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_10.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_10.gen_bits_1.u_prim_buf" @prim_buf_28(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %50, %gen_buffs_10.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %51 = llhd.sig.extract %gen_buffs_10.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_10.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_10.gen_bits_2.u_prim_buf" @prim_buf_28(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %51, %gen_buffs_10.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %52 = llhd.sig.extract %gen_buffs_10.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_10.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_10.gen_bits_3.u_prim_buf" @prim_buf_28(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %52, %gen_buffs_10.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %53 = llhd.sig.extract %gen_buffs_11.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_11.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_11.gen_bits_0.u_prim_buf" @prim_buf_28(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %53, %gen_buffs_11.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %54 = llhd.sig.extract %gen_buffs_11.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_11.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_11.gen_bits_1.u_prim_buf" @prim_buf_28(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %54, %gen_buffs_11.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %55 = llhd.sig.extract %gen_buffs_11.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_11.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_11.gen_bits_2.u_prim_buf" @prim_buf_28(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %55, %gen_buffs_11.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %56 = llhd.sig.extract %gen_buffs_11.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_11.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_11.gen_bits_3.u_prim_buf" @prim_buf_28(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %56, %gen_buffs_11.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %57 = llhd.sig.extract %gen_buffs_12.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_12.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_12.gen_bits_0.u_prim_buf" @prim_buf_28(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %57, %gen_buffs_12.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %58 = llhd.sig.extract %gen_buffs_12.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_12.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_12.gen_bits_1.u_prim_buf" @prim_buf_28(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %58, %gen_buffs_12.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %59 = llhd.sig.extract %gen_buffs_12.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_12.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_12.gen_bits_2.u_prim_buf" @prim_buf_28(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %59, %gen_buffs_12.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %60 = llhd.sig.extract %gen_buffs_12.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_12.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_12.gen_bits_3.u_prim_buf" @prim_buf_28(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %60, %gen_buffs_12.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %61 = llhd.sig.extract %gen_buffs_13.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_13.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_13.gen_bits_0.u_prim_buf" @prim_buf_28(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %61, %gen_buffs_13.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %62 = llhd.sig.extract %gen_buffs_13.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_13.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_13.gen_bits_1.u_prim_buf" @prim_buf_28(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %62, %gen_buffs_13.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %63 = llhd.sig.extract %gen_buffs_13.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_13.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_13.gen_bits_2.u_prim_buf" @prim_buf_28(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %63, %gen_buffs_13.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %64 = llhd.sig.extract %gen_buffs_13.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_13.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_13.gen_bits_3.u_prim_buf" @prim_buf_28(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %64, %gen_buffs_13.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %65 = llhd.sig.extract %gen_buffs_14.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_14.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_14.gen_bits_0.u_prim_buf" @prim_buf_28(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %65, %gen_buffs_14.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %66 = llhd.sig.extract %gen_buffs_14.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_14.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_14.gen_bits_1.u_prim_buf" @prim_buf_28(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %66, %gen_buffs_14.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %67 = llhd.sig.extract %gen_buffs_14.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_14.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_14.gen_bits_2.u_prim_buf" @prim_buf_28(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %67, %gen_buffs_14.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %68 = llhd.sig.extract %gen_buffs_14.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_14.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_14.gen_bits_3.u_prim_buf" @prim_buf_28(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %68, %gen_buffs_14.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %69 = llhd.sig.extract %gen_buffs_15.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_15.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_15.gen_bits_0.u_prim_buf" @prim_buf_28(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %69, %gen_buffs_15.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %70 = llhd.sig.extract %gen_buffs_15.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_15.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_15.gen_bits_1.u_prim_buf" @prim_buf_28(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %70, %gen_buffs_15.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %71 = llhd.sig.extract %gen_buffs_15.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_15.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_15.gen_bits_2.u_prim_buf" @prim_buf_28(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %71, %gen_buffs_15.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %72 = llhd.sig.extract %gen_buffs_15.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_15.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_15.gen_bits_3.u_prim_buf" @prim_buf_28(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %72, %gen_buffs_15.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %73 = llhd.sig.extract %gen_buffs_16.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_16.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_16.gen_bits_0.u_prim_buf" @prim_buf_28(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %73, %gen_buffs_16.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %74 = llhd.sig.extract %gen_buffs_16.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_16.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_16.gen_bits_1.u_prim_buf" @prim_buf_28(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %74, %gen_buffs_16.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %75 = llhd.sig.extract %gen_buffs_16.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_16.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_16.gen_bits_2.u_prim_buf" @prim_buf_28(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %75, %gen_buffs_16.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %76 = llhd.sig.extract %gen_buffs_16.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_16.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_16.gen_bits_3.u_prim_buf" @prim_buf_28(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %76, %gen_buffs_16.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %77 = llhd.sig.extract %gen_buffs_17.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_17.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_17.gen_bits_0.u_prim_buf" @prim_buf_28(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %77, %gen_buffs_17.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %78 = llhd.sig.extract %gen_buffs_17.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_17.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_17.gen_bits_1.u_prim_buf" @prim_buf_28(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %78, %gen_buffs_17.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %79 = llhd.sig.extract %gen_buffs_17.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_17.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_17.gen_bits_2.u_prim_buf" @prim_buf_28(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %79, %gen_buffs_17.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %80 = llhd.sig.extract %gen_buffs_17.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_17.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_17.gen_bits_3.u_prim_buf" @prim_buf_28(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %80, %gen_buffs_17.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %81 = llhd.sig.extract %gen_buffs_18.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_18.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_18.gen_bits_0.u_prim_buf" @prim_buf_28(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %81, %gen_buffs_18.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %82 = llhd.sig.extract %gen_buffs_18.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_18.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_18.gen_bits_1.u_prim_buf" @prim_buf_28(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %82, %gen_buffs_18.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %83 = llhd.sig.extract %gen_buffs_18.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_18.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_18.gen_bits_2.u_prim_buf" @prim_buf_28(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %83, %gen_buffs_18.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %84 = llhd.sig.extract %gen_buffs_18.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_18.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_18.gen_bits_3.u_prim_buf" @prim_buf_28(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %84, %gen_buffs_18.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %85 = llhd.sig.extract %gen_buffs_19.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_19.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_19.gen_bits_0.u_prim_buf" @prim_buf_28(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %85, %gen_buffs_19.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %86 = llhd.sig.extract %gen_buffs_19.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_19.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_19.gen_bits_1.u_prim_buf" @prim_buf_28(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %86, %gen_buffs_19.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %87 = llhd.sig.extract %gen_buffs_19.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_19.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_19.gen_bits_2.u_prim_buf" @prim_buf_28(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %87, %gen_buffs_19.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %88 = llhd.sig.extract %gen_buffs_19.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_19.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_19.gen_bits_3.u_prim_buf" @prim_buf_28(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %88, %gen_buffs_19.gen_bits_3.u_prim_buf.out_o after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %131 = llhd.prb %clk_i_0 : i1
      %132 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
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
      llhd.drv %gen_no_flops.unused_logic, %c-7_i4 after %0 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %142 = llhd.prb %mubi_i_2 : i4
      llhd.drv %gen_no_flops.unused_logic, %142 after %0 : i4
      cf.br ^bb1
    }
    %89 = llhd.prb %mubi_i_2 {sv.namehint = "mubi"} : i4
    %90 = llhd.sig.array_get %mubi_o[%c0_i5] : <!hw.array<20xi4>>
    %91 = llhd.prb %gen_buffs_0.mubi_out : i4
    llhd.drv %90, %91 after %1 : i4
    %92 = llhd.sig.array_get %mubi_o[%c1_i5] : <!hw.array<20xi4>>
    %93 = llhd.prb %gen_buffs_1.mubi_out : i4
    llhd.drv %92, %93 after %1 : i4
    %94 = llhd.sig.array_get %mubi_o[%c2_i5] : <!hw.array<20xi4>>
    %95 = llhd.prb %gen_buffs_2.mubi_out : i4
    llhd.drv %94, %95 after %1 : i4
    %96 = llhd.sig.array_get %mubi_o[%c3_i5] : <!hw.array<20xi4>>
    %97 = llhd.prb %gen_buffs_3.mubi_out : i4
    llhd.drv %96, %97 after %1 : i4
    %98 = llhd.sig.array_get %mubi_o[%c4_i5] : <!hw.array<20xi4>>
    %99 = llhd.prb %gen_buffs_4.mubi_out : i4
    llhd.drv %98, %99 after %1 : i4
    %100 = llhd.sig.array_get %mubi_o[%c5_i5] : <!hw.array<20xi4>>
    %101 = llhd.prb %gen_buffs_5.mubi_out : i4
    llhd.drv %100, %101 after %1 : i4
    %102 = llhd.sig.array_get %mubi_o[%c6_i5] : <!hw.array<20xi4>>
    %103 = llhd.prb %gen_buffs_6.mubi_out : i4
    llhd.drv %102, %103 after %1 : i4
    %104 = llhd.sig.array_get %mubi_o[%c7_i5] : <!hw.array<20xi4>>
    %105 = llhd.prb %gen_buffs_7.mubi_out : i4
    llhd.drv %104, %105 after %1 : i4
    %106 = llhd.sig.array_get %mubi_o[%c8_i5] : <!hw.array<20xi4>>
    %107 = llhd.prb %gen_buffs_8.mubi_out : i4
    llhd.drv %106, %107 after %1 : i4
    %108 = llhd.sig.array_get %mubi_o[%c9_i5] : <!hw.array<20xi4>>
    %109 = llhd.prb %gen_buffs_9.mubi_out : i4
    llhd.drv %108, %109 after %1 : i4
    %110 = llhd.sig.array_get %mubi_o[%c10_i5] : <!hw.array<20xi4>>
    %111 = llhd.prb %gen_buffs_10.mubi_out : i4
    llhd.drv %110, %111 after %1 : i4
    %112 = llhd.sig.array_get %mubi_o[%c11_i5] : <!hw.array<20xi4>>
    %113 = llhd.prb %gen_buffs_11.mubi_out : i4
    llhd.drv %112, %113 after %1 : i4
    %114 = llhd.sig.array_get %mubi_o[%c12_i5] : <!hw.array<20xi4>>
    %115 = llhd.prb %gen_buffs_12.mubi_out : i4
    llhd.drv %114, %115 after %1 : i4
    %116 = llhd.sig.array_get %mubi_o[%c13_i5] : <!hw.array<20xi4>>
    %117 = llhd.prb %gen_buffs_13.mubi_out : i4
    llhd.drv %116, %117 after %1 : i4
    %118 = llhd.sig.array_get %mubi_o[%c14_i5] : <!hw.array<20xi4>>
    %119 = llhd.prb %gen_buffs_14.mubi_out : i4
    llhd.drv %118, %119 after %1 : i4
    %120 = llhd.sig.array_get %mubi_o[%c15_i5] : <!hw.array<20xi4>>
    %121 = llhd.prb %gen_buffs_15.mubi_out : i4
    llhd.drv %120, %121 after %1 : i4
    %122 = llhd.sig.array_get %mubi_o[%c-16_i5] : <!hw.array<20xi4>>
    %123 = llhd.prb %gen_buffs_16.mubi_out : i4
    llhd.drv %122, %123 after %1 : i4
    %124 = llhd.sig.array_get %mubi_o[%c-15_i5] : <!hw.array<20xi4>>
    %125 = llhd.prb %gen_buffs_17.mubi_out : i4
    llhd.drv %124, %125 after %1 : i4
    %126 = llhd.sig.array_get %mubi_o[%c-14_i5] : <!hw.array<20xi4>>
    %127 = llhd.prb %gen_buffs_18.mubi_out : i4
    llhd.drv %126, %127 after %1 : i4
    %128 = llhd.sig.array_get %mubi_o[%c-13_i5] : <!hw.array<20xi4>>
    %129 = llhd.prb %gen_buffs_19.mubi_out : i4
    llhd.drv %128, %129 after %1 : i4
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %mubi_i_2, %mubi_i after %1 : i4
    %130 = llhd.prb %mubi_o : !hw.array<20xi4>
    hw.output %130 : !hw.array<20xi4>
  }
  hw.module private @prim_mubi4_sync_14(in %clk_i : i1, in %rst_ni : i1, in %mubi_i : i4, out mubi_o : !hw.array<4xi4>) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %2 = hw.aggregate_constant [0 : i4, 0 : i4, 0 : i4, 0 : i4] : !hw.array<4xi4>
    %c0_i4 = hw.constant 0 : i4
    %c-7_i4 = hw.constant -7 : i4
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %mubi_i_2 = llhd.sig name "mubi_i" %c0_i4 : i4
    %mubi_o = llhd.sig %2 : !hw.array<4xi4>
    %gen_no_flops.unused_logic = llhd.sig %c0_i4 : i4
    %gen_buffs_0.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_1.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_2.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_3.mubi_out = llhd.sig %c0_i4 : i4
    %5 = comb.extract %25 from 0 : (i4) -> i1
    %6 = llhd.sig.extract %gen_buffs_0.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_0.u_prim_buf" @prim_buf_28(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %6, %gen_buffs_0.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %7 = comb.extract %25 from 1 : (i4) -> i1
    %8 = llhd.sig.extract %gen_buffs_0.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_1.u_prim_buf" @prim_buf_28(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %8, %gen_buffs_0.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %9 = comb.extract %25 from 2 : (i4) -> i1
    %10 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_2.u_prim_buf" @prim_buf_28(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %10, %gen_buffs_0.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %11 = comb.extract %25 from 3 : (i4) -> i1
    %12 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_3.u_prim_buf" @prim_buf_28(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %12, %gen_buffs_0.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %13 = llhd.sig.extract %gen_buffs_1.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_0.u_prim_buf" @prim_buf_28(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %13, %gen_buffs_1.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %14 = llhd.sig.extract %gen_buffs_1.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_1.u_prim_buf" @prim_buf_28(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %14, %gen_buffs_1.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %15 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_2.u_prim_buf" @prim_buf_28(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %15, %gen_buffs_1.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %16 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_3.u_prim_buf" @prim_buf_28(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %16, %gen_buffs_1.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %17 = llhd.sig.extract %gen_buffs_2.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_0.u_prim_buf" @prim_buf_28(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %17, %gen_buffs_2.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %18 = llhd.sig.extract %gen_buffs_2.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_1.u_prim_buf" @prim_buf_28(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %18, %gen_buffs_2.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %19 = llhd.sig.extract %gen_buffs_2.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_2.u_prim_buf" @prim_buf_28(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %19, %gen_buffs_2.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %20 = llhd.sig.extract %gen_buffs_2.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_3.u_prim_buf" @prim_buf_28(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %20, %gen_buffs_2.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %21 = llhd.sig.extract %gen_buffs_3.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_0.u_prim_buf" @prim_buf_28(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %21, %gen_buffs_3.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %22 = llhd.sig.extract %gen_buffs_3.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_1.u_prim_buf" @prim_buf_28(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %22, %gen_buffs_3.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %23 = llhd.sig.extract %gen_buffs_3.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_2.u_prim_buf" @prim_buf_28(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %23, %gen_buffs_3.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %24 = llhd.sig.extract %gen_buffs_3.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_3.u_prim_buf" @prim_buf_28(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %24, %gen_buffs_3.gen_bits_3.u_prim_buf.out_o after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %35 = llhd.prb %clk_i_0 : i1
      %36 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %37 = llhd.prb %clk_i_0 : i1
      %38 = comb.xor bin %35, %true : i1
      %39 = comb.and bin %38, %37 : i1
      %40 = llhd.prb %rst_ni_1 : i1
      %41 = comb.xor bin %40, %true : i1
      %42 = comb.and bin %36, %41 : i1
      %43 = comb.or bin %39, %42 : i1
      cf.cond_br %43, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %44 = llhd.prb %rst_ni_1 : i1
      %45 = comb.xor %44, %true : i1
      cf.cond_br %45, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_no_flops.unused_logic, %c-7_i4 after %0 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %46 = llhd.prb %mubi_i_2 : i4
      llhd.drv %gen_no_flops.unused_logic, %46 after %0 : i4
      cf.br ^bb1
    }
    %25 = llhd.prb %mubi_i_2 {sv.namehint = "mubi"} : i4
    %26 = llhd.sig.array_get %mubi_o[%c0_i2] : <!hw.array<4xi4>>
    %27 = llhd.prb %gen_buffs_0.mubi_out : i4
    llhd.drv %26, %27 after %1 : i4
    %28 = llhd.sig.array_get %mubi_o[%c1_i2] : <!hw.array<4xi4>>
    %29 = llhd.prb %gen_buffs_1.mubi_out : i4
    llhd.drv %28, %29 after %1 : i4
    %30 = llhd.sig.array_get %mubi_o[%c-2_i2] : <!hw.array<4xi4>>
    %31 = llhd.prb %gen_buffs_2.mubi_out : i4
    llhd.drv %30, %31 after %1 : i4
    %32 = llhd.sig.array_get %mubi_o[%c-1_i2] : <!hw.array<4xi4>>
    %33 = llhd.prb %gen_buffs_3.mubi_out : i4
    llhd.drv %32, %33 after %1 : i4
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %mubi_i_2, %mubi_i after %1 : i4
    %34 = llhd.prb %mubi_o : !hw.array<4xi4>
    hw.output %34 : !hw.array<4xi4>
  }
  hw.module private @prim_mubi4_sync_15(in %clk_i : i1, in %rst_ni : i1, in %mubi_i : i4, out mubi_o : !hw.array<2xi4>) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %2 = hw.aggregate_constant [0 : i4, 0 : i4] : !hw.array<2xi4>
    %c0_i4 = hw.constant 0 : i4
    %c-7_i4 = hw.constant -7 : i4
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %mubi_i_2 = llhd.sig name "mubi_i" %c0_i4 : i4
    %mubi_o = llhd.sig %2 : !hw.array<2xi4>
    %gen_no_flops.unused_logic = llhd.sig %c0_i4 : i4
    %gen_buffs_0.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_1.mubi_out = llhd.sig %c0_i4 : i4
    %5 = comb.extract %17 from 0 : (i4) -> i1
    %6 = llhd.sig.extract %gen_buffs_0.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_0.u_prim_buf" @prim_buf_28(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %6, %gen_buffs_0.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %7 = comb.extract %17 from 1 : (i4) -> i1
    %8 = llhd.sig.extract %gen_buffs_0.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_1.u_prim_buf" @prim_buf_28(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %8, %gen_buffs_0.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %9 = comb.extract %17 from 2 : (i4) -> i1
    %10 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_2.u_prim_buf" @prim_buf_28(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %10, %gen_buffs_0.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %11 = comb.extract %17 from 3 : (i4) -> i1
    %12 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_3.u_prim_buf" @prim_buf_28(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %12, %gen_buffs_0.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %13 = llhd.sig.extract %gen_buffs_1.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_0.u_prim_buf" @prim_buf_28(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %13, %gen_buffs_1.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %14 = llhd.sig.extract %gen_buffs_1.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_1.u_prim_buf" @prim_buf_28(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %14, %gen_buffs_1.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %15 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_2.u_prim_buf" @prim_buf_28(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %15, %gen_buffs_1.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %16 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_3.u_prim_buf" @prim_buf_28(in_i: %11: i1) -> (out_o: i1)
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
      llhd.drv %gen_no_flops.unused_logic, %c-7_i4 after %0 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %34 = llhd.prb %mubi_i_2 : i4
      llhd.drv %gen_no_flops.unused_logic, %34 after %0 : i4
      cf.br ^bb1
    }
    %17 = llhd.prb %mubi_i_2 {sv.namehint = "mubi"} : i4
    %18 = llhd.sig.array_get %mubi_o[%false] : <!hw.array<2xi4>>
    %19 = llhd.prb %gen_buffs_0.mubi_out : i4
    llhd.drv %18, %19 after %1 : i4
    %20 = llhd.sig.array_get %mubi_o[%true] : <!hw.array<2xi4>>
    %21 = llhd.prb %gen_buffs_1.mubi_out : i4
    llhd.drv %20, %21 after %1 : i4
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %mubi_i_2, %mubi_i after %1 : i4
    %22 = llhd.prb %mubi_o : !hw.array<2xi4>
    hw.output %22 : !hw.array<2xi4>
  }
  hw.module private @edn_ack_sm(in %clk_i : i1, in %rst_ni : i1, in %enable_i : i1, in %req_i : i1, out ack_o : i1, in %local_escalate_i : i1, in %fifo_not_empty_i : i1, out fifo_pop_o : i1, out fifo_clr_o : i1, out ack_sm_err_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i9 = hw.constant 0 : i9
    %c-47_i9 = hw.constant -47 : i9
    %c37_i9 = hw.constant 37 : i9
    %c235_i9 = hw.constant 235 : i9
    %c92_i9 = hw.constant 92 : i9
    %true = hw.constant true
    %c-114_i9 = hw.constant -114 : i9
    %c-206_i9 = hw.constant -206 : i9
    %false = hw.constant false
    %enable_i_0 = llhd.sig name "enable_i" %false : i1
    %req_i_1 = llhd.sig name "req_i" %false : i1
    %ack_o = llhd.sig %false : i1
    %local_escalate_i_2 = llhd.sig name "local_escalate_i" %false : i1
    %fifo_not_empty_i_3 = llhd.sig name "fifo_not_empty_i" %false : i1
    %fifo_pop_o = llhd.sig %false : i1
    %fifo_clr_o = llhd.sig %false : i1
    %ack_sm_err_o = llhd.sig %false : i1
    %state_d = llhd.sig %c0_i9 : i9
    %state_q = llhd.sig %c0_i9 : i9
    %1 = llhd.prb %state_d : i9
    %u_state_regs.state_o = hw.instance "u_state_regs" @prim_sparse_fsm_flop_31(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, state_i: %1: i9) -> (state_o: i9)
    llhd.drv %state_q, %u_state_regs.state_o after %0 : i9
    %2 = llhd.prb %state_q : i9
    %3 = llhd.prb %ack_o : i1
    %4 = llhd.prb %fifo_clr_o : i1
    %5 = llhd.prb %fifo_pop_o : i1
    %6 = llhd.prb %ack_sm_err_o : i1
    %7 = llhd.prb %enable_i_0 : i1
    %8 = llhd.prb %local_escalate_i_2 : i1
    %9 = llhd.prb %req_i_1 : i1
    %10 = llhd.prb %fifo_not_empty_i_3 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb23
      %11 = llhd.prb %state_q : i9
      llhd.drv %state_d, %11 after %0 : i9
      llhd.drv %ack_o, %false after %0 : i1
      llhd.drv %fifo_clr_o, %false after %0 : i1
      llhd.drv %fifo_pop_o, %false after %0 : i1
      llhd.drv %ack_sm_err_o, %false after %0 : i1
      %12 = llhd.prb %state_q : i9
      %13 = comb.icmp ceq %12, %c-206_i9 : i9
      cf.cond_br %13, ^bb2, ^bb4
    ^bb2:  // pred: ^bb1
      %14 = llhd.prb %enable_i_0 : i1
      cf.cond_br %14, ^bb3, ^bb19
    ^bb3:  // pred: ^bb2
      llhd.drv %state_d, %c-114_i9 after %0 : i9
      llhd.drv %fifo_clr_o, %true after %0 : i1
      cf.br ^bb19
    ^bb4:  // pred: ^bb1
      %15 = comb.icmp ceq %12, %c-114_i9 : i9
      cf.cond_br %15, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      llhd.drv %state_d, %c92_i9 after %0 : i9
      cf.br ^bb19
    ^bb6:  // pred: ^bb4
      %16 = comb.icmp ceq %12, %c92_i9 : i9
      cf.cond_br %16, ^bb7, ^bb11
    ^bb7:  // pred: ^bb6
      %17 = llhd.prb %req_i_1 : i1
      cf.cond_br %17, ^bb8, ^bb19
    ^bb8:  // pred: ^bb7
      %18 = llhd.prb %fifo_not_empty_i_3 : i1
      cf.cond_br %18, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      llhd.drv %fifo_pop_o, %true after %0 : i1
      cf.br ^bb10
    ^bb10:  // 2 preds: ^bb8, ^bb9
      llhd.drv %state_d, %c235_i9 after %0 : i9
      cf.br ^bb19
    ^bb11:  // pred: ^bb6
      %19 = comb.icmp ceq %12, %c235_i9 : i9
      cf.cond_br %19, ^bb12, ^bb14
    ^bb12:  // pred: ^bb11
      %20 = llhd.prb %fifo_not_empty_i_3 : i1
      cf.cond_br %20, ^bb13, ^bb19
    ^bb13:  // pred: ^bb12
      llhd.drv %state_d, %c37_i9 after %0 : i9
      cf.br ^bb19
    ^bb14:  // pred: ^bb11
      %21 = comb.icmp ceq %12, %c37_i9 : i9
      cf.cond_br %21, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      llhd.drv %ack_o, %true after %0 : i1
      llhd.drv %state_d, %c92_i9 after %0 : i9
      cf.br ^bb19
    ^bb16:  // pred: ^bb14
      %22 = comb.icmp ceq %12, %c-47_i9 : i9
      cf.cond_br %22, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      llhd.drv %ack_sm_err_o, %true after %0 : i1
      cf.br ^bb19
    ^bb18:  // pred: ^bb16
      llhd.drv %ack_sm_err_o, %true after %0 : i1
      llhd.drv %state_d, %c-47_i9 after %0 : i9
      cf.br ^bb19
    ^bb19:  // 10 preds: ^bb2, ^bb3, ^bb5, ^bb7, ^bb10, ^bb12, ^bb13, ^bb15, ^bb17, ^bb18
      %23 = llhd.prb %local_escalate_i_2 : i1
      cf.cond_br %23, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      llhd.drv %state_d, %c-47_i9 after %0 : i9
      llhd.drv %ack_o, %false after %0 : i1
      llhd.drv %fifo_clr_o, %false after %0 : i1
      llhd.drv %fifo_pop_o, %false after %0 : i1
      cf.br ^bb23
    ^bb21:  // pred: ^bb19
      %24 = llhd.prb %enable_i_0 : i1
      %25 = comb.xor %24, %true : i1
      %26 = llhd.prb %state_q : i9
      %27 = comb.icmp weq %26, %c-114_i9 : i9
      %28 = comb.icmp weq %26, %c92_i9 : i9
      %29 = comb.icmp weq %26, %c235_i9 : i9
      %30 = comb.icmp weq %26, %c37_i9 : i9
      %31 = comb.or %27, %28, %29, %30 : i1
      %32 = comb.and %25, %31 : i1
      cf.cond_br %32, ^bb22, ^bb23
    ^bb22:  // pred: ^bb21
      llhd.drv %state_d, %c-206_i9 after %0 : i9
      llhd.drv %ack_o, %false after %0 : i1
      llhd.drv %fifo_pop_o, %false after %0 : i1
      llhd.drv %fifo_clr_o, %false after %0 : i1
      cf.br ^bb23
    ^bb23:  // 3 preds: ^bb20, ^bb21, ^bb22
      llhd.wait (%2, %1, %3, %4, %5, %6, %7, %8, %9, %10 : i9, i9, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    llhd.drv %enable_i_0, %enable_i after %0 : i1
    llhd.drv %req_i_1, %req_i after %0 : i1
    llhd.drv %local_escalate_i_2, %local_escalate_i after %0 : i1
    llhd.drv %fifo_not_empty_i_3, %fifo_not_empty_i after %0 : i1
    hw.output %3, %5, %4, %6 : i1, i1, i1, i1
  }
  hw.module private @edn_core(in %clk_i : i1, in %rst_ni : i1, in %reg2hw : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>, out hw2reg : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<d: i1, de: i1>, edn_cmd_req_done: !hw.struct<d: i1, de: i1>>, sw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>, hw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>, recov_alert_sts: !hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>, err_code: !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>, main_sm_state: !hw.struct<d: i9, de: i1>>, in %edn_i : !hw.array<8xstruct<edn_req: i1>>, out edn_o : !hw.array<8xstruct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>, out csrng_cmd_o : !hw.struct<csrng_req_valid: i1, csrng_req_bus: i32, genbits_ready: i1>, in %csrng_cmd_i : !hw.struct<csrng_req_ready: i1, csrng_rsp_ack: i1, csrng_rsp_sts: i3, genbits_valid: i1, genbits_fips: i1, genbits_bus: i128>, out recov_alert_test_o : i1, out fatal_alert_test_o : i1, out recov_alert_o : i1, out fatal_alert_o : i1, out intr_edn_cmd_req_done_o : i1, out intr_edn_fatal_err_o : i1) {
    %c-1_i4 = hw.constant -1 : i4
    %c5_i32 = hw.constant 5 : i32
    %0 = hw.aggregate_constant [false, false, false, false, false, false, false, false] : !hw.array<8xi1>
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %c0_i2 = hw.constant 0 : i2
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
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %c3_i3 = hw.constant 3 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c2_i3 = hw.constant 2 : i3
    %c-3_i3 = hw.constant -3 : i3
    %c1_i3 = hw.constant 1 : i3
    %c-2_i3 = hw.constant -2 : i3
    %c-1_i3 = hw.constant -1 : i3
    %2 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i31 = hw.constant 0 : i31
    %3 = hw.aggregate_constant [0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32] : !hw.array<8xi32>
    %4 = hw.aggregate_constant [0 : i128, 0 : i128, 0 : i128, 0 : i128, 0 : i128, 0 : i128, 0 : i128, 0 : i128] : !hw.array<8xi128>
    %c0_i128 = hw.constant 0 : i128
    %c0_i19 = hw.constant 0 : i19
    %5 = hw.aggregate_constant [false, false, 0 : i3, false, false, 0 : i128] : !hw.struct<csrng_req_ready: i1, csrng_rsp_ack: i1, csrng_rsp_sts: i3, genbits_valid: i1, genbits_fips: i1, genbits_bus: i128>
    %6 = hw.aggregate_constant [false, 0 : i32, false] : !hw.struct<csrng_req_valid: i1, csrng_req_bus: i32, genbits_ready: i1>
    %7 = hw.aggregate_constant [[false, false, 0 : i32], [false, false, 0 : i32], [false, false, 0 : i32], [false, false, 0 : i32], [false, false, 0 : i32], [false, false, 0 : i32], [false, false, 0 : i32], [false, false, 0 : i32]] : !hw.array<8xstruct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>
    %8 = hw.aggregate_constant [[[false, false], [false, false]], [[0 : i3, false], [false, false], [false, false], [false, false]], [[0 : i3, false], [false, false], [0 : i4, false], [false, false], [false, false]], [[false, false], [false, false], [false, false], [false, false], [false, false], [false, false]], [[false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false]], [0 : i9, false]] : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<d: i1, de: i1>, edn_cmd_req_done: !hw.struct<d: i1, de: i1>>, sw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>, hw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>, recov_alert_sts: !hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>, err_code: !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>, main_sm_state: !hw.struct<d: i9, de: i1>>
    %c1_i4 = hw.constant 1 : i4
    %c193_i9 = hw.constant 193 : i9
    %false = hw.constant false
    %c0_i3 = hw.constant 0 : i3
    %c0_i64 = hw.constant 0 : i64
    %c0_i8 = hw.constant 0 : i8
    %c0_i4 = hw.constant 0 : i4
    %c0_i32 = hw.constant 0 : i32
    %true = hw.constant true
    %c1_i32 = hw.constant 1 : i32
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %9 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %10 = llhd.prb %rst_ni_1 : i1
    %hw2reg = llhd.sig %8 : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<d: i1, de: i1>, edn_cmd_req_done: !hw.struct<d: i1, de: i1>>, sw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>, hw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>, recov_alert_sts: !hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>, err_code: !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>, main_sm_state: !hw.struct<d: i9, de: i1>>
    %edn_o = llhd.sig %7 : !hw.array<8xstruct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>
    %csrng_cmd_o = llhd.sig %6 : !hw.struct<csrng_req_valid: i1, csrng_req_bus: i32, genbits_ready: i1>
    %csrng_cmd_i_2 = llhd.sig name "csrng_cmd_i" %5 : !hw.struct<csrng_req_ready: i1, csrng_rsp_ack: i1, csrng_rsp_sts: i3, genbits_valid: i1, genbits_fips: i1, genbits_bus: i128>
    %edn_enable_fo = llhd.sig %c0_i19 : i19
    %cmd_fifo_rst_fo = llhd.sig %c0_i3 : i3
    %boot_req_mode_fo = llhd.sig %false : i1
    %packer_arb_req = llhd.sig %c0_i8 : i8
    %main_sm_done_pulse = llhd.sig %false : i1
    %capt_gencmd_fifo_cnt = llhd.sig %false : i1
    %capt_rescmd_fifo_cnt = llhd.sig %false : i1
    %send_rescmd = llhd.sig %false : i1
    %send_gencmd = llhd.sig %false : i1
    %cs_cmd_handshake = llhd.sig %false : i1
    %cs_hw_cmd_handshake = llhd.sig %false : i1
    %cs_hw_cmd_handshake_1st = llhd.sig %false : i1
    %cmd_sent = llhd.sig %false : i1
    %boot_wr_ins_cmd = llhd.sig %false : i1
    %boot_send_ins_cmd = llhd.sig %false : i1
    %boot_wr_gen_cmd = llhd.sig %false : i1
    %boot_wr_uni_cmd = llhd.sig %false : i1
    %sw_cmd_req_load = llhd.sig %false : i1
    %sw_cmd_mode = llhd.sig %false : i1
    %sw_cmd_req_bus = llhd.sig %c0_i32 : i32
    %reseed_cmd_load = llhd.sig %false : i1
    %reseed_cmd_bus = llhd.sig %c0_i32 : i32
    %generate_cmd_load = llhd.sig %false : i1
    %generate_cmd_bus = llhd.sig %c0_i32 : i32
    %packer_cs_push = llhd.sig %false : i1
    %packer_cs_wready = llhd.sig %false : i1
    %packer_cs_rdata = llhd.sig %c0_i128 : i128
    %auto_req_mode_busy = llhd.sig %false : i1
    %accept_sw_cmds_pulse = llhd.sig %false : i1
    %packer_ep_clr = llhd.sig %c0_i8 : i8
    %packer_ep_ack = llhd.sig %c0_i8 : i8
    %packer_ep_push = llhd.sig %c0_i8 : i8
    %packer_ep_wdata = llhd.sig %4 : !hw.array<8xi128>
    %packer_ep_wready = llhd.sig %c0_i8 : i8
    %packer_ep_rvalid = llhd.sig %c0_i8 : i8
    %packer_ep_rready = llhd.sig %c0_i8 : i8
    %edn_ack_sm_err = llhd.sig %c0_i8 : i8
    %packer_ep_rdata = llhd.sig %3 : !hw.array<8xi32>
    %sfifo_rescmd_depth = llhd.sig %c0_i4 : i4
    %sfifo_rescmd_rdata = llhd.sig %c0_i32 : i32
    %sfifo_rescmd_pop = llhd.sig %false : i1
    %sfifo_gencmd_rdata = llhd.sig %c0_i32 : i32
    %sfifo_gencmd_depth = llhd.sig %c0_i4 : i4
    %sfifo_gencmd_pop = llhd.sig %false : i1
    %reject_csrng_entropy = llhd.sig %false : i1
    %err_code_test_bit = llhd.sig %c0_i31 : i31
    %cs_rdata_capt_vld = llhd.sig %false : i1
    %boot_ins_cmd = llhd.sig %c0_i32 : i32
    %boot_gen_cmd = llhd.sig %c0_i32 : i32
    %cs_cmd_req_q = llhd.sig %c0_i32 : i32
    %cs_cmd_req_d = llhd.sig %c0_i32 : i32
    %cs_cmd_req_vld_q = llhd.sig %false : i1
    %cs_cmd_req_vld_d = llhd.sig %false : i1
    %cs_cmd_req_out_q = llhd.sig %c0_i32 : i32
    %cs_cmd_req_out_d = llhd.sig %c0_i32 : i32
    %cs_cmd_req_vld_out_q = llhd.sig %false : i1
    %cs_cmd_req_vld_out_d = llhd.sig %false : i1
    %cs_cmd_req_vld_hold_q = llhd.sig %false : i1
    %cs_cmd_req_vld_hold_d = llhd.sig %false : i1
    %cmd_fifo_cnt_q = llhd.sig %c0_i4 : i4
    %cmd_fifo_cnt_d = llhd.sig %c0_i4 : i4
    %csrng_fips_q = llhd.sig %false : i1
    %csrng_fips_d = llhd.sig %false : i1
    %edn_fips_q = llhd.sig %c0_i8 : i8
    %edn_fips_d = llhd.sig %c0_i8 : i8
    %cs_rdata_capt_q = llhd.sig %c0_i64 : i64
    %cs_rdata_capt_d = llhd.sig %c0_i64 : i64
    %cs_rdata_capt_vld_q = llhd.sig %false : i1
    %cs_rdata_capt_vld_d = llhd.sig %false : i1
    %cmd_rdy_q = llhd.sig %false : i1
    %cmd_rdy_d = llhd.sig %false : i1
    %csrng_cmd_sts_q = llhd.sig %c0_i3 : i3
    %csrng_cmd_sts_d = llhd.sig %c0_i3 : i3
    %csrng_sw_cmd_ack_q = llhd.sig %false : i1
    %csrng_sw_cmd_ack_d = llhd.sig %false : i1
    %csrng_hw_cmd_ack_q = llhd.sig %false : i1
    %csrng_hw_cmd_ack_d = llhd.sig %false : i1
    %csrng_hw_cmd_sts_q = llhd.sig %c0_i3 : i3
    %csrng_hw_cmd_sts_d = llhd.sig %c0_i3 : i3
    %boot_mode_q = llhd.sig %false : i1
    %boot_mode_d = llhd.sig %false : i1
    %auto_mode_q = llhd.sig %false : i1
    %auto_mode_d = llhd.sig %false : i1
    %cmd_type_q = llhd.sig %c0_i4 : i4
    %cmd_type_d = llhd.sig %c0_i4 : i4
    %cmd_reg_rdy_d = llhd.sig %false : i1
    %cmd_reg_rdy_q = llhd.sig %false : i1
    %cmd_hdr_busy_d = llhd.sig %false : i1
    %cmd_hdr_busy_q = llhd.sig %false : i1
    %intr_enable = hw.struct_extract %reg2hw["intr_enable"] : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>
    %edn_cmd_req_done = hw.struct_extract %intr_enable["edn_cmd_req_done"] : !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>
    %q = hw.struct_extract %edn_cmd_req_done["q"] : !hw.struct<q: i1>
    %intr_test = hw.struct_extract %reg2hw["intr_test"] : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>
    %edn_cmd_req_done_3 = hw.struct_extract %intr_test["edn_cmd_req_done"] : !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>
    %q_4 = hw.struct_extract %edn_cmd_req_done_3["q"] : !hw.struct<q: i1, qe: i1>
    %qe = hw.struct_extract %edn_cmd_req_done_3["qe"] : !hw.struct<q: i1, qe: i1>
    %intr_state = hw.struct_extract %reg2hw["intr_state"] : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>
    %edn_cmd_req_done_5 = hw.struct_extract %intr_state["edn_cmd_req_done"] : !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>
    %q_6 = hw.struct_extract %edn_cmd_req_done_5["q"] : !hw.struct<q: i1>
    %11 = llhd.sig.struct_extract %hw2reg["intr_state"] : <!hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<d: i1, de: i1>, edn_cmd_req_done: !hw.struct<d: i1, de: i1>>, sw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>, hw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>, recov_alert_sts: !hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>, err_code: !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>, main_sm_state: !hw.struct<d: i9, de: i1>>>
    %12 = llhd.sig.struct_extract %11["edn_cmd_req_done"] : <!hw.struct<edn_fatal_err: !hw.struct<d: i1, de: i1>, edn_cmd_req_done: !hw.struct<d: i1, de: i1>>>
    %13 = llhd.sig.struct_extract %12["de"] : <!hw.struct<d: i1, de: i1>>
    %14 = llhd.sig.struct_extract %12["d"] : <!hw.struct<d: i1, de: i1>>
    %u_intr_hw_edn_cmd_req_done.hw2reg_intr_state_de_o, %u_intr_hw_edn_cmd_req_done.hw2reg_intr_state_d_o, %u_intr_hw_edn_cmd_req_done.intr_o = hw.instance "u_intr_hw_edn_cmd_req_done" @prim_intr_hw(clk_i: %9: i1, rst_ni: %10: i1, event_intr_i: %141: i1, reg2hw_intr_enable_q_i: %q: i1, reg2hw_intr_test_q_i: %q_4: i1, reg2hw_intr_test_qe_i: %qe: i1, reg2hw_intr_state_q_i: %q_6: i1) -> (hw2reg_intr_state_de_o: i1, hw2reg_intr_state_d_o: i1, intr_o: i1)
    llhd.drv %13, %u_intr_hw_edn_cmd_req_done.hw2reg_intr_state_de_o after %2 : i1
    llhd.drv %14, %u_intr_hw_edn_cmd_req_done.hw2reg_intr_state_d_o after %2 : i1
    %edn_fatal_err = hw.struct_extract %intr_enable["edn_fatal_err"] : !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>
    %q_7 = hw.struct_extract %edn_fatal_err["q"] : !hw.struct<q: i1>
    %edn_fatal_err_8 = hw.struct_extract %intr_test["edn_fatal_err"] : !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>
    %q_9 = hw.struct_extract %edn_fatal_err_8["q"] : !hw.struct<q: i1, qe: i1>
    %qe_10 = hw.struct_extract %edn_fatal_err_8["qe"] : !hw.struct<q: i1, qe: i1>
    %edn_fatal_err_11 = hw.struct_extract %intr_state["edn_fatal_err"] : !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>
    %q_12 = hw.struct_extract %edn_fatal_err_11["q"] : !hw.struct<q: i1>
    %15 = llhd.sig.struct_extract %11["edn_fatal_err"] : <!hw.struct<edn_fatal_err: !hw.struct<d: i1, de: i1>, edn_cmd_req_done: !hw.struct<d: i1, de: i1>>>
    %16 = llhd.sig.struct_extract %15["de"] : <!hw.struct<d: i1, de: i1>>
    %17 = llhd.sig.struct_extract %15["d"] : <!hw.struct<d: i1, de: i1>>
    %u_intr_hw_edn_fatal_err.hw2reg_intr_state_de_o, %u_intr_hw_edn_fatal_err.hw2reg_intr_state_d_o, %u_intr_hw_edn_fatal_err.intr_o = hw.instance "u_intr_hw_edn_fatal_err" @prim_intr_hw(clk_i: %9: i1, rst_ni: %10: i1, event_intr_i: %146: i1, reg2hw_intr_enable_q_i: %q_7: i1, reg2hw_intr_test_q_i: %q_9: i1, reg2hw_intr_test_qe_i: %qe_10: i1, reg2hw_intr_state_q_i: %q_12: i1) -> (hw2reg_intr_state_de_o: i1, hw2reg_intr_state_d_o: i1, intr_o: i1)
    llhd.drv %16, %u_intr_hw_edn_fatal_err.hw2reg_intr_state_de_o after %2 : i1
    llhd.drv %17, %u_intr_hw_edn_fatal_err.hw2reg_intr_state_d_o after %2 : i1
    %u_prim_edge_detector_recov_alert.q_sync_o, %u_prim_edge_detector_recov_alert.q_posedge_pulse_o, %u_prim_edge_detector_recov_alert.q_negedge_pulse_o = hw.instance "u_prim_edge_detector_recov_alert" @prim_edge_detector(clk_i: %9: i1, rst_ni: %10: i1, d_i: %303: i1) -> (q_sync_o: i1, q_posedge_pulse_o: i1, q_negedge_pulse_o: i1)
    %u_prim_mubi4_sync_edn_enable.mubi_o = hw.instance "u_prim_mubi4_sync_edn_enable" @prim_mubi4_sync(clk_i: %9: i1, rst_ni: %10: i1, mubi_i: %q_30: i4) -> (mubi_o: !hw.array<20xi4>) {sv.namehint = "mubi_edn_enable_fanout"}
    %u_prim_mubi4_sync_cmd_fifo_rst.mubi_o = hw.instance "u_prim_mubi4_sync_cmd_fifo_rst" @prim_mubi4_sync_14(clk_i: %9: i1, rst_ni: %10: i1, mubi_i: %q_31: i4) -> (mubi_o: !hw.array<4xi4>) {sv.namehint = "mubi_cmd_fifo_rst_fanout"}
    %u_prim_mubi4_sync_auto_req_mode.mubi_o = hw.instance "u_prim_mubi4_sync_auto_req_mode" @prim_mubi4_sync_15(clk_i: %9: i1, rst_ni: %10: i1, mubi_i: %q_32: i4) -> (mubi_o: !hw.array<2xi4>) {sv.namehint = "mubi_auto_req_mode_fanout"}
    %18 = llhd.prb %sfifo_rescmd_pop : i1
    %u_prim_fifo_sync_rescmd.wready_o, %u_prim_fifo_sync_rescmd.rvalid_o, %u_prim_fifo_sync_rescmd.rdata_o, %u_prim_fifo_sync_rescmd.full_o, %u_prim_fifo_sync_rescmd.depth_o, %u_prim_fifo_sync_rescmd.err_o = hw.instance "u_prim_fifo_sync_rescmd" @prim_fifo_sync(clk_i: %9: i1, rst_ni: %10: i1, clr_i: %562: i1, wvalid_i: %554: i1, wdata_i: %556: i32, rready_i: %18: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i32, full_o: i1, depth_o: i4, err_o: i1) {sv.namehint = "sfifo_rescmd_full"}
    llhd.drv %sfifo_rescmd_rdata, %u_prim_fifo_sync_rescmd.rdata_o after %2 : i32
    llhd.drv %sfifo_rescmd_depth, %u_prim_fifo_sync_rescmd.depth_o after %2 : i4
    %19 = llhd.prb %sfifo_gencmd_pop : i1
    %u_prim_fifo_sync_gencmd.wready_o, %u_prim_fifo_sync_gencmd.rvalid_o, %u_prim_fifo_sync_gencmd.rdata_o, %u_prim_fifo_sync_gencmd.full_o, %u_prim_fifo_sync_gencmd.depth_o, %u_prim_fifo_sync_gencmd.err_o = hw.instance "u_prim_fifo_sync_gencmd" @prim_fifo_sync(clk_i: %9: i1, rst_ni: %10: i1, clr_i: %576: i1, wvalid_i: %570: i1, wdata_i: %572: i32, rready_i: %19: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i32, full_o: i1, depth_o: i4, err_o: i1) {sv.namehint = "sfifo_gencmd_full"}
    llhd.drv %sfifo_gencmd_rdata, %u_prim_fifo_sync_gencmd.rdata_o after %2 : i32
    llhd.drv %sfifo_gencmd_depth, %u_prim_fifo_sync_gencmd.depth_o after %2 : i4
    %20 = llhd.prb %edn_enable_fo : i19
    %21 = comb.extract %20 from 12 : (i19) -> i1
    %22 = llhd.prb %boot_req_mode_fo : i1
    %23 = llhd.prb %sw_cmd_req_load : i1
    %24 = llhd.prb %csrng_cmd_i_2 : !hw.struct<csrng_req_ready: i1, csrng_rsp_ack: i1, csrng_rsp_sts: i3, genbits_valid: i1, genbits_fips: i1, genbits_bus: i128>
    %csrng_rsp_ack = hw.struct_extract %24["csrng_rsp_ack"] : !hw.struct<csrng_req_ready: i1, csrng_rsp_ack: i1, csrng_rsp_sts: i3, genbits_valid: i1, genbits_fips: i1, genbits_bus: i128>
    %25 = llhd.prb %cmd_sent : i1
    %u_edn_main_sm.sw_cmd_mode_o, %u_edn_main_sm.boot_wr_ins_cmd_o, %u_edn_main_sm.boot_send_ins_cmd_o, %u_edn_main_sm.boot_wr_gen_cmd_o, %u_edn_main_sm.boot_wr_uni_cmd_o, %u_edn_main_sm.accept_sw_cmds_pulse_o, %u_edn_main_sm.main_sm_done_pulse_o, %u_edn_main_sm.capt_gencmd_fifo_cnt_o, %u_edn_main_sm.send_gencmd_o, %u_edn_main_sm.capt_rescmd_fifo_cnt_o, %u_edn_main_sm.send_rescmd_o, %u_edn_main_sm.auto_req_mode_busy_o, %u_edn_main_sm.main_sm_state_o, %u_edn_main_sm.reject_csrng_entropy_o, %u_edn_main_sm.main_sm_err_o = hw.instance "u_edn_main_sm" @edn_main_sm(clk_i: %9: i1, rst_ni: %10: i1, edn_enable_i: %21: i1, boot_req_mode_i: %22: i1, auto_req_mode_i: %383: i1, sw_cmd_req_load_i: %23: i1, csrng_cmd_ack_i: %csrng_rsp_ack: i1, max_reqs_cnt_zero_i: %585: i1, cmd_sent_i: %25: i1, csrng_ack_err_i: %298: i1, local_escalate_i: %142: i1) -> (sw_cmd_mode_o: i1, boot_wr_ins_cmd_o: i1, boot_send_ins_cmd_o: i1, boot_wr_gen_cmd_o: i1, boot_wr_uni_cmd_o: i1, accept_sw_cmds_pulse_o: i1, main_sm_done_pulse_o: i1, capt_gencmd_fifo_cnt_o: i1, send_gencmd_o: i1, capt_rescmd_fifo_cnt_o: i1, send_rescmd_o: i1, auto_req_mode_busy_o: i1, main_sm_state_o: i9, reject_csrng_entropy_o: i1, main_sm_err_o: i1) {sv.namehint = "edn_main_sm_err"}
    llhd.drv %sw_cmd_mode, %u_edn_main_sm.sw_cmd_mode_o after %2 : i1
    llhd.drv %boot_wr_ins_cmd, %u_edn_main_sm.boot_wr_ins_cmd_o after %2 : i1
    llhd.drv %boot_send_ins_cmd, %u_edn_main_sm.boot_send_ins_cmd_o after %2 : i1
    llhd.drv %boot_wr_gen_cmd, %u_edn_main_sm.boot_wr_gen_cmd_o after %2 : i1
    llhd.drv %boot_wr_uni_cmd, %u_edn_main_sm.boot_wr_uni_cmd_o after %2 : i1
    llhd.drv %accept_sw_cmds_pulse, %u_edn_main_sm.accept_sw_cmds_pulse_o after %2 : i1
    llhd.drv %main_sm_done_pulse, %u_edn_main_sm.main_sm_done_pulse_o after %2 : i1
    llhd.drv %capt_gencmd_fifo_cnt, %u_edn_main_sm.capt_gencmd_fifo_cnt_o after %2 : i1
    llhd.drv %send_gencmd, %u_edn_main_sm.send_gencmd_o after %2 : i1
    llhd.drv %capt_rescmd_fifo_cnt, %u_edn_main_sm.capt_rescmd_fifo_cnt_o after %2 : i1
    llhd.drv %send_rescmd, %u_edn_main_sm.send_rescmd_o after %2 : i1
    llhd.drv %auto_req_mode_busy, %u_edn_main_sm.auto_req_mode_busy_o after %2 : i1
    llhd.drv %reject_csrng_entropy, %u_edn_main_sm.reject_csrng_entropy_o after %2 : i1
    %26 = llhd.prb %send_gencmd : i1
    %27 = comb.and %26, %25 : i1
    %u_prim_count_max_reqs_cntr.cnt_o, %u_prim_count_max_reqs_cntr.cnt_after_commit_o, %u_prim_count_max_reqs_cntr.err_o = hw.instance "u_prim_count_max_reqs_cntr" @prim_count(clk_i: %9: i1, rst_ni: %10: i1, clr_i: %false: i1, set_i: %584: i1, set_cnt_i: %q_36: i32, incr_en_i: %false: i1, decr_en_i: %27: i1, step_i: %c1_i32: i32, commit_i: %true: i1) -> (cnt_o: i32, cnt_after_commit_o: i32, err_o: i1) {sv.namehint = "max_reqs_cnt"}
    %u_prim_mubi4_sync_boot_req_mode.mubi_o = hw.instance "u_prim_mubi4_sync_boot_req_mode" @prim_mubi4_sync_15(clk_i: %9: i1, rst_ni: %10: i1, mubi_i: %q_41: i4) -> (mubi_o: !hw.array<2xi4>) {sv.namehint = "mubi_boot_req_mode_fanout"}
    %28 = llhd.prb %packer_arb_req : i8
    %u_prim_arbiter_ppc_packer_arb.gnt_o, %u_prim_arbiter_ppc_packer_arb.idx_o, %u_prim_arbiter_ppc_packer_arb.valid_o, %u_prim_arbiter_ppc_packer_arb.data_o = hw.instance "u_prim_arbiter_ppc_packer_arb" @prim_arbiter_ppc(clk_i: %9: i1, rst_ni: %10: i1, req_chk_i: %true: i1, req_i: %28: i8, data_i: %0: !hw.array<8xi1>, ready_i: %u_prim_packer_fifo_cs.rvalid_o: i1) -> (gnt_o: i8, idx_o: i3, valid_o: i1, data_o: i1) {sv.namehint = "packer_arb_gnt"}
    %29 = llhd.prb %packer_cs_push : i1
    %u_prim_packer_fifo_cs.wready_o, %u_prim_packer_fifo_cs.rvalid_o, %u_prim_packer_fifo_cs.rdata_o, %u_prim_packer_fifo_cs.depth_o = hw.instance "u_prim_packer_fifo_cs" @prim_packer_fifo(clk_i: %9: i1, rst_ni: %10: i1, clr_i: %637: i1, wvalid_i: %29: i1, wdata_i: %genbits_bus: i128, rready_i: %u_prim_arbiter_ppc_packer_arb.valid_o: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i128, depth_o: i1) {sv.namehint = "packer_cs_rvalid"}
    llhd.drv %packer_cs_wready, %u_prim_packer_fifo_cs.wready_o after %2 : i1
    llhd.drv %packer_cs_rdata, %u_prim_packer_fifo_cs.rdata_o after %2 : i128
    %30 = llhd.prb %packer_ep_clr : i8
    %31 = comb.extract %30 from 0 : (i8) -> i1
    %32 = llhd.prb %packer_ep_push : i8
    %33 = comb.extract %32 from 0 : (i8) -> i1
    %34 = llhd.prb %packer_ep_wdata : !hw.array<8xi128>
    %35 = hw.array_get %34[%c-1_i3] : !hw.array<8xi128>, i3
    %36 = llhd.sig.extract %packer_ep_wready from %c0_i3 : <i8> -> <i1>
    %37 = llhd.sig.extract %packer_ep_rvalid from %c0_i3 : <i8> -> <i1>
    %38 = llhd.sig.array_get %packer_ep_rdata[%c-1_i3] : <!hw.array<8xi32>>
    %39 = llhd.prb %packer_ep_rready : i8
    %40 = comb.extract %39 from 0 : (i8) -> i1
    %gen_ep_blk_0.u_prim_packer_fifo_ep.wready_o, %gen_ep_blk_0.u_prim_packer_fifo_ep.rvalid_o, %gen_ep_blk_0.u_prim_packer_fifo_ep.rdata_o, %gen_ep_blk_0.u_prim_packer_fifo_ep.depth_o = hw.instance "gen_ep_blk_0.u_prim_packer_fifo_ep" @prim_packer_fifo_16(clk_i: %9: i1, rst_ni: %10: i1, clr_i: %31: i1, wvalid_i: %33: i1, wdata_i: %35: i128, rready_i: %40: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i32, depth_o: i3)
    llhd.drv %36, %gen_ep_blk_0.u_prim_packer_fifo_ep.wready_o after %2 : i1
    llhd.drv %37, %gen_ep_blk_0.u_prim_packer_fifo_ep.rvalid_o after %2 : i1
    llhd.drv %38, %gen_ep_blk_0.u_prim_packer_fifo_ep.rdata_o after %2 : i32
    %41 = comb.extract %20 from 18 : (i19) -> i1
    %42 = hw.array_get %edn_i[%c0_i3] : !hw.array<8xstruct<edn_req: i1>>, i3
    %edn_req = hw.struct_extract %42["edn_req"] : !hw.struct<edn_req: i1>
    %43 = llhd.sig.extract %packer_ep_ack from %c0_i3 : <i8> -> <i1>
    %44 = llhd.prb %packer_ep_rvalid : i8
    %45 = comb.extract %44 from 0 : (i8) -> i1
    %46 = llhd.sig.extract %packer_ep_rready from %c0_i3 : <i8> -> <i1>
    %47 = llhd.sig.extract %packer_ep_clr from %c0_i3 : <i8> -> <i1>
    %48 = llhd.sig.extract %edn_ack_sm_err from %c0_i3 : <i8> -> <i1>
    %gen_ep_blk_0.u_edn_ack_sm_ep.ack_o, %gen_ep_blk_0.u_edn_ack_sm_ep.fifo_pop_o, %gen_ep_blk_0.u_edn_ack_sm_ep.fifo_clr_o, %gen_ep_blk_0.u_edn_ack_sm_ep.ack_sm_err_o = hw.instance "gen_ep_blk_0.u_edn_ack_sm_ep" @edn_ack_sm(clk_i: %9: i1, rst_ni: %10: i1, enable_i: %41: i1, req_i: %edn_req: i1, local_escalate_i: %142: i1, fifo_not_empty_i: %45: i1) -> (ack_o: i1, fifo_pop_o: i1, fifo_clr_o: i1, ack_sm_err_o: i1)
    llhd.drv %43, %gen_ep_blk_0.u_edn_ack_sm_ep.ack_o after %2 : i1
    llhd.drv %46, %gen_ep_blk_0.u_edn_ack_sm_ep.fifo_pop_o after %2 : i1
    llhd.drv %47, %gen_ep_blk_0.u_edn_ack_sm_ep.fifo_clr_o after %2 : i1
    llhd.drv %48, %gen_ep_blk_0.u_edn_ack_sm_ep.ack_sm_err_o after %2 : i1
    %49 = comb.extract %30 from 1 : (i8) -> i1
    %50 = comb.extract %32 from 1 : (i8) -> i1
    %51 = hw.array_get %34[%c-2_i3] : !hw.array<8xi128>, i3
    %52 = llhd.sig.extract %packer_ep_wready from %c1_i3 : <i8> -> <i1>
    %53 = llhd.sig.extract %packer_ep_rvalid from %c1_i3 : <i8> -> <i1>
    %54 = llhd.sig.array_get %packer_ep_rdata[%c-2_i3] : <!hw.array<8xi32>>
    %55 = comb.extract %39 from 1 : (i8) -> i1
    %gen_ep_blk_1.u_prim_packer_fifo_ep.wready_o, %gen_ep_blk_1.u_prim_packer_fifo_ep.rvalid_o, %gen_ep_blk_1.u_prim_packer_fifo_ep.rdata_o, %gen_ep_blk_1.u_prim_packer_fifo_ep.depth_o = hw.instance "gen_ep_blk_1.u_prim_packer_fifo_ep" @prim_packer_fifo_16(clk_i: %9: i1, rst_ni: %10: i1, clr_i: %49: i1, wvalid_i: %50: i1, wdata_i: %51: i128, rready_i: %55: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i32, depth_o: i3)
    llhd.drv %52, %gen_ep_blk_1.u_prim_packer_fifo_ep.wready_o after %2 : i1
    llhd.drv %53, %gen_ep_blk_1.u_prim_packer_fifo_ep.rvalid_o after %2 : i1
    llhd.drv %54, %gen_ep_blk_1.u_prim_packer_fifo_ep.rdata_o after %2 : i32
    %56 = hw.array_get %edn_i[%c1_i3] : !hw.array<8xstruct<edn_req: i1>>, i3
    %edn_req_13 = hw.struct_extract %56["edn_req"] : !hw.struct<edn_req: i1>
    %57 = llhd.sig.extract %packer_ep_ack from %c1_i3 : <i8> -> <i1>
    %58 = comb.extract %44 from 1 : (i8) -> i1
    %59 = llhd.sig.extract %packer_ep_rready from %c1_i3 : <i8> -> <i1>
    %60 = llhd.sig.extract %packer_ep_clr from %c1_i3 : <i8> -> <i1>
    %61 = llhd.sig.extract %edn_ack_sm_err from %c1_i3 : <i8> -> <i1>
    %gen_ep_blk_1.u_edn_ack_sm_ep.ack_o, %gen_ep_blk_1.u_edn_ack_sm_ep.fifo_pop_o, %gen_ep_blk_1.u_edn_ack_sm_ep.fifo_clr_o, %gen_ep_blk_1.u_edn_ack_sm_ep.ack_sm_err_o = hw.instance "gen_ep_blk_1.u_edn_ack_sm_ep" @edn_ack_sm(clk_i: %9: i1, rst_ni: %10: i1, enable_i: %41: i1, req_i: %edn_req_13: i1, local_escalate_i: %142: i1, fifo_not_empty_i: %58: i1) -> (ack_o: i1, fifo_pop_o: i1, fifo_clr_o: i1, ack_sm_err_o: i1)
    llhd.drv %57, %gen_ep_blk_1.u_edn_ack_sm_ep.ack_o after %2 : i1
    llhd.drv %59, %gen_ep_blk_1.u_edn_ack_sm_ep.fifo_pop_o after %2 : i1
    llhd.drv %60, %gen_ep_blk_1.u_edn_ack_sm_ep.fifo_clr_o after %2 : i1
    llhd.drv %61, %gen_ep_blk_1.u_edn_ack_sm_ep.ack_sm_err_o after %2 : i1
    %62 = comb.extract %30 from 2 : (i8) -> i1
    %63 = comb.extract %32 from 2 : (i8) -> i1
    %64 = hw.array_get %34[%c-3_i3] : !hw.array<8xi128>, i3
    %65 = llhd.sig.extract %packer_ep_wready from %c2_i3 : <i8> -> <i1>
    %66 = llhd.sig.extract %packer_ep_rvalid from %c2_i3 : <i8> -> <i1>
    %67 = llhd.sig.array_get %packer_ep_rdata[%c-3_i3] : <!hw.array<8xi32>>
    %68 = comb.extract %39 from 2 : (i8) -> i1
    %gen_ep_blk_2.u_prim_packer_fifo_ep.wready_o, %gen_ep_blk_2.u_prim_packer_fifo_ep.rvalid_o, %gen_ep_blk_2.u_prim_packer_fifo_ep.rdata_o, %gen_ep_blk_2.u_prim_packer_fifo_ep.depth_o = hw.instance "gen_ep_blk_2.u_prim_packer_fifo_ep" @prim_packer_fifo_16(clk_i: %9: i1, rst_ni: %10: i1, clr_i: %62: i1, wvalid_i: %63: i1, wdata_i: %64: i128, rready_i: %68: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i32, depth_o: i3)
    llhd.drv %65, %gen_ep_blk_2.u_prim_packer_fifo_ep.wready_o after %2 : i1
    llhd.drv %66, %gen_ep_blk_2.u_prim_packer_fifo_ep.rvalid_o after %2 : i1
    llhd.drv %67, %gen_ep_blk_2.u_prim_packer_fifo_ep.rdata_o after %2 : i32
    %69 = hw.array_get %edn_i[%c2_i3] : !hw.array<8xstruct<edn_req: i1>>, i3
    %edn_req_14 = hw.struct_extract %69["edn_req"] : !hw.struct<edn_req: i1>
    %70 = llhd.sig.extract %packer_ep_ack from %c2_i3 : <i8> -> <i1>
    %71 = comb.extract %44 from 2 : (i8) -> i1
    %72 = llhd.sig.extract %packer_ep_rready from %c2_i3 : <i8> -> <i1>
    %73 = llhd.sig.extract %packer_ep_clr from %c2_i3 : <i8> -> <i1>
    %74 = llhd.sig.extract %edn_ack_sm_err from %c2_i3 : <i8> -> <i1>
    %gen_ep_blk_2.u_edn_ack_sm_ep.ack_o, %gen_ep_blk_2.u_edn_ack_sm_ep.fifo_pop_o, %gen_ep_blk_2.u_edn_ack_sm_ep.fifo_clr_o, %gen_ep_blk_2.u_edn_ack_sm_ep.ack_sm_err_o = hw.instance "gen_ep_blk_2.u_edn_ack_sm_ep" @edn_ack_sm(clk_i: %9: i1, rst_ni: %10: i1, enable_i: %41: i1, req_i: %edn_req_14: i1, local_escalate_i: %142: i1, fifo_not_empty_i: %71: i1) -> (ack_o: i1, fifo_pop_o: i1, fifo_clr_o: i1, ack_sm_err_o: i1)
    llhd.drv %70, %gen_ep_blk_2.u_edn_ack_sm_ep.ack_o after %2 : i1
    llhd.drv %72, %gen_ep_blk_2.u_edn_ack_sm_ep.fifo_pop_o after %2 : i1
    llhd.drv %73, %gen_ep_blk_2.u_edn_ack_sm_ep.fifo_clr_o after %2 : i1
    llhd.drv %74, %gen_ep_blk_2.u_edn_ack_sm_ep.ack_sm_err_o after %2 : i1
    %75 = comb.extract %30 from 3 : (i8) -> i1
    %76 = comb.extract %32 from 3 : (i8) -> i1
    %77 = hw.array_get %34[%c-4_i3] : !hw.array<8xi128>, i3
    %78 = llhd.sig.extract %packer_ep_wready from %c3_i3 : <i8> -> <i1>
    %79 = llhd.sig.extract %packer_ep_rvalid from %c3_i3 : <i8> -> <i1>
    %80 = llhd.sig.array_get %packer_ep_rdata[%c-4_i3] : <!hw.array<8xi32>>
    %81 = comb.extract %39 from 3 : (i8) -> i1
    %gen_ep_blk_3.u_prim_packer_fifo_ep.wready_o, %gen_ep_blk_3.u_prim_packer_fifo_ep.rvalid_o, %gen_ep_blk_3.u_prim_packer_fifo_ep.rdata_o, %gen_ep_blk_3.u_prim_packer_fifo_ep.depth_o = hw.instance "gen_ep_blk_3.u_prim_packer_fifo_ep" @prim_packer_fifo_16(clk_i: %9: i1, rst_ni: %10: i1, clr_i: %75: i1, wvalid_i: %76: i1, wdata_i: %77: i128, rready_i: %81: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i32, depth_o: i3)
    llhd.drv %78, %gen_ep_blk_3.u_prim_packer_fifo_ep.wready_o after %2 : i1
    llhd.drv %79, %gen_ep_blk_3.u_prim_packer_fifo_ep.rvalid_o after %2 : i1
    llhd.drv %80, %gen_ep_blk_3.u_prim_packer_fifo_ep.rdata_o after %2 : i32
    %82 = hw.array_get %edn_i[%c3_i3] : !hw.array<8xstruct<edn_req: i1>>, i3
    %edn_req_15 = hw.struct_extract %82["edn_req"] : !hw.struct<edn_req: i1>
    %83 = llhd.sig.extract %packer_ep_ack from %c3_i3 : <i8> -> <i1>
    %84 = comb.extract %44 from 3 : (i8) -> i1
    %85 = llhd.sig.extract %packer_ep_rready from %c3_i3 : <i8> -> <i1>
    %86 = llhd.sig.extract %packer_ep_clr from %c3_i3 : <i8> -> <i1>
    %87 = llhd.sig.extract %edn_ack_sm_err from %c3_i3 : <i8> -> <i1>
    %gen_ep_blk_3.u_edn_ack_sm_ep.ack_o, %gen_ep_blk_3.u_edn_ack_sm_ep.fifo_pop_o, %gen_ep_blk_3.u_edn_ack_sm_ep.fifo_clr_o, %gen_ep_blk_3.u_edn_ack_sm_ep.ack_sm_err_o = hw.instance "gen_ep_blk_3.u_edn_ack_sm_ep" @edn_ack_sm(clk_i: %9: i1, rst_ni: %10: i1, enable_i: %41: i1, req_i: %edn_req_15: i1, local_escalate_i: %142: i1, fifo_not_empty_i: %84: i1) -> (ack_o: i1, fifo_pop_o: i1, fifo_clr_o: i1, ack_sm_err_o: i1)
    llhd.drv %83, %gen_ep_blk_3.u_edn_ack_sm_ep.ack_o after %2 : i1
    llhd.drv %85, %gen_ep_blk_3.u_edn_ack_sm_ep.fifo_pop_o after %2 : i1
    llhd.drv %86, %gen_ep_blk_3.u_edn_ack_sm_ep.fifo_clr_o after %2 : i1
    llhd.drv %87, %gen_ep_blk_3.u_edn_ack_sm_ep.ack_sm_err_o after %2 : i1
    %88 = comb.extract %30 from 4 : (i8) -> i1
    %89 = comb.extract %32 from 4 : (i8) -> i1
    %90 = hw.array_get %34[%c3_i3] : !hw.array<8xi128>, i3
    %91 = llhd.sig.extract %packer_ep_wready from %c-4_i3 : <i8> -> <i1>
    %92 = llhd.sig.extract %packer_ep_rvalid from %c-4_i3 : <i8> -> <i1>
    %93 = llhd.sig.array_get %packer_ep_rdata[%c3_i3] : <!hw.array<8xi32>>
    %94 = comb.extract %39 from 4 : (i8) -> i1
    %gen_ep_blk_4.u_prim_packer_fifo_ep.wready_o, %gen_ep_blk_4.u_prim_packer_fifo_ep.rvalid_o, %gen_ep_blk_4.u_prim_packer_fifo_ep.rdata_o, %gen_ep_blk_4.u_prim_packer_fifo_ep.depth_o = hw.instance "gen_ep_blk_4.u_prim_packer_fifo_ep" @prim_packer_fifo_16(clk_i: %9: i1, rst_ni: %10: i1, clr_i: %88: i1, wvalid_i: %89: i1, wdata_i: %90: i128, rready_i: %94: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i32, depth_o: i3)
    llhd.drv %91, %gen_ep_blk_4.u_prim_packer_fifo_ep.wready_o after %2 : i1
    llhd.drv %92, %gen_ep_blk_4.u_prim_packer_fifo_ep.rvalid_o after %2 : i1
    llhd.drv %93, %gen_ep_blk_4.u_prim_packer_fifo_ep.rdata_o after %2 : i32
    %95 = hw.array_get %edn_i[%c-4_i3] : !hw.array<8xstruct<edn_req: i1>>, i3
    %edn_req_16 = hw.struct_extract %95["edn_req"] : !hw.struct<edn_req: i1>
    %96 = llhd.sig.extract %packer_ep_ack from %c-4_i3 : <i8> -> <i1>
    %97 = comb.extract %44 from 4 : (i8) -> i1
    %98 = llhd.sig.extract %packer_ep_rready from %c-4_i3 : <i8> -> <i1>
    %99 = llhd.sig.extract %packer_ep_clr from %c-4_i3 : <i8> -> <i1>
    %100 = llhd.sig.extract %edn_ack_sm_err from %c-4_i3 : <i8> -> <i1>
    %gen_ep_blk_4.u_edn_ack_sm_ep.ack_o, %gen_ep_blk_4.u_edn_ack_sm_ep.fifo_pop_o, %gen_ep_blk_4.u_edn_ack_sm_ep.fifo_clr_o, %gen_ep_blk_4.u_edn_ack_sm_ep.ack_sm_err_o = hw.instance "gen_ep_blk_4.u_edn_ack_sm_ep" @edn_ack_sm(clk_i: %9: i1, rst_ni: %10: i1, enable_i: %41: i1, req_i: %edn_req_16: i1, local_escalate_i: %142: i1, fifo_not_empty_i: %97: i1) -> (ack_o: i1, fifo_pop_o: i1, fifo_clr_o: i1, ack_sm_err_o: i1)
    llhd.drv %96, %gen_ep_blk_4.u_edn_ack_sm_ep.ack_o after %2 : i1
    llhd.drv %98, %gen_ep_blk_4.u_edn_ack_sm_ep.fifo_pop_o after %2 : i1
    llhd.drv %99, %gen_ep_blk_4.u_edn_ack_sm_ep.fifo_clr_o after %2 : i1
    llhd.drv %100, %gen_ep_blk_4.u_edn_ack_sm_ep.ack_sm_err_o after %2 : i1
    %101 = comb.extract %30 from 5 : (i8) -> i1
    %102 = comb.extract %32 from 5 : (i8) -> i1
    %103 = hw.array_get %34[%c2_i3] : !hw.array<8xi128>, i3
    %104 = llhd.sig.extract %packer_ep_wready from %c-3_i3 : <i8> -> <i1>
    %105 = llhd.sig.extract %packer_ep_rvalid from %c-3_i3 : <i8> -> <i1>
    %106 = llhd.sig.array_get %packer_ep_rdata[%c2_i3] : <!hw.array<8xi32>>
    %107 = comb.extract %39 from 5 : (i8) -> i1
    %gen_ep_blk_5.u_prim_packer_fifo_ep.wready_o, %gen_ep_blk_5.u_prim_packer_fifo_ep.rvalid_o, %gen_ep_blk_5.u_prim_packer_fifo_ep.rdata_o, %gen_ep_blk_5.u_prim_packer_fifo_ep.depth_o = hw.instance "gen_ep_blk_5.u_prim_packer_fifo_ep" @prim_packer_fifo_16(clk_i: %9: i1, rst_ni: %10: i1, clr_i: %101: i1, wvalid_i: %102: i1, wdata_i: %103: i128, rready_i: %107: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i32, depth_o: i3)
    llhd.drv %104, %gen_ep_blk_5.u_prim_packer_fifo_ep.wready_o after %2 : i1
    llhd.drv %105, %gen_ep_blk_5.u_prim_packer_fifo_ep.rvalid_o after %2 : i1
    llhd.drv %106, %gen_ep_blk_5.u_prim_packer_fifo_ep.rdata_o after %2 : i32
    %108 = hw.array_get %edn_i[%c-3_i3] : !hw.array<8xstruct<edn_req: i1>>, i3
    %edn_req_17 = hw.struct_extract %108["edn_req"] : !hw.struct<edn_req: i1>
    %109 = llhd.sig.extract %packer_ep_ack from %c-3_i3 : <i8> -> <i1>
    %110 = comb.extract %44 from 5 : (i8) -> i1
    %111 = llhd.sig.extract %packer_ep_rready from %c-3_i3 : <i8> -> <i1>
    %112 = llhd.sig.extract %packer_ep_clr from %c-3_i3 : <i8> -> <i1>
    %113 = llhd.sig.extract %edn_ack_sm_err from %c-3_i3 : <i8> -> <i1>
    %gen_ep_blk_5.u_edn_ack_sm_ep.ack_o, %gen_ep_blk_5.u_edn_ack_sm_ep.fifo_pop_o, %gen_ep_blk_5.u_edn_ack_sm_ep.fifo_clr_o, %gen_ep_blk_5.u_edn_ack_sm_ep.ack_sm_err_o = hw.instance "gen_ep_blk_5.u_edn_ack_sm_ep" @edn_ack_sm(clk_i: %9: i1, rst_ni: %10: i1, enable_i: %41: i1, req_i: %edn_req_17: i1, local_escalate_i: %142: i1, fifo_not_empty_i: %110: i1) -> (ack_o: i1, fifo_pop_o: i1, fifo_clr_o: i1, ack_sm_err_o: i1)
    llhd.drv %109, %gen_ep_blk_5.u_edn_ack_sm_ep.ack_o after %2 : i1
    llhd.drv %111, %gen_ep_blk_5.u_edn_ack_sm_ep.fifo_pop_o after %2 : i1
    llhd.drv %112, %gen_ep_blk_5.u_edn_ack_sm_ep.fifo_clr_o after %2 : i1
    llhd.drv %113, %gen_ep_blk_5.u_edn_ack_sm_ep.ack_sm_err_o after %2 : i1
    %114 = comb.extract %30 from 6 : (i8) -> i1
    %115 = comb.extract %32 from 6 : (i8) -> i1
    %116 = hw.array_get %34[%c1_i3] : !hw.array<8xi128>, i3
    %117 = llhd.sig.extract %packer_ep_wready from %c-2_i3 : <i8> -> <i1>
    %118 = llhd.sig.extract %packer_ep_rvalid from %c-2_i3 : <i8> -> <i1>
    %119 = llhd.sig.array_get %packer_ep_rdata[%c1_i3] : <!hw.array<8xi32>>
    %120 = comb.extract %39 from 6 : (i8) -> i1
    %gen_ep_blk_6.u_prim_packer_fifo_ep.wready_o, %gen_ep_blk_6.u_prim_packer_fifo_ep.rvalid_o, %gen_ep_blk_6.u_prim_packer_fifo_ep.rdata_o, %gen_ep_blk_6.u_prim_packer_fifo_ep.depth_o = hw.instance "gen_ep_blk_6.u_prim_packer_fifo_ep" @prim_packer_fifo_16(clk_i: %9: i1, rst_ni: %10: i1, clr_i: %114: i1, wvalid_i: %115: i1, wdata_i: %116: i128, rready_i: %120: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i32, depth_o: i3)
    llhd.drv %117, %gen_ep_blk_6.u_prim_packer_fifo_ep.wready_o after %2 : i1
    llhd.drv %118, %gen_ep_blk_6.u_prim_packer_fifo_ep.rvalid_o after %2 : i1
    llhd.drv %119, %gen_ep_blk_6.u_prim_packer_fifo_ep.rdata_o after %2 : i32
    %121 = hw.array_get %edn_i[%c-2_i3] : !hw.array<8xstruct<edn_req: i1>>, i3
    %edn_req_18 = hw.struct_extract %121["edn_req"] : !hw.struct<edn_req: i1>
    %122 = llhd.sig.extract %packer_ep_ack from %c-2_i3 : <i8> -> <i1>
    %123 = comb.extract %44 from 6 : (i8) -> i1
    %124 = llhd.sig.extract %packer_ep_rready from %c-2_i3 : <i8> -> <i1>
    %125 = llhd.sig.extract %packer_ep_clr from %c-2_i3 : <i8> -> <i1>
    %126 = llhd.sig.extract %edn_ack_sm_err from %c-2_i3 : <i8> -> <i1>
    %gen_ep_blk_6.u_edn_ack_sm_ep.ack_o, %gen_ep_blk_6.u_edn_ack_sm_ep.fifo_pop_o, %gen_ep_blk_6.u_edn_ack_sm_ep.fifo_clr_o, %gen_ep_blk_6.u_edn_ack_sm_ep.ack_sm_err_o = hw.instance "gen_ep_blk_6.u_edn_ack_sm_ep" @edn_ack_sm(clk_i: %9: i1, rst_ni: %10: i1, enable_i: %41: i1, req_i: %edn_req_18: i1, local_escalate_i: %142: i1, fifo_not_empty_i: %123: i1) -> (ack_o: i1, fifo_pop_o: i1, fifo_clr_o: i1, ack_sm_err_o: i1)
    llhd.drv %122, %gen_ep_blk_6.u_edn_ack_sm_ep.ack_o after %2 : i1
    llhd.drv %124, %gen_ep_blk_6.u_edn_ack_sm_ep.fifo_pop_o after %2 : i1
    llhd.drv %125, %gen_ep_blk_6.u_edn_ack_sm_ep.fifo_clr_o after %2 : i1
    llhd.drv %126, %gen_ep_blk_6.u_edn_ack_sm_ep.ack_sm_err_o after %2 : i1
    %127 = comb.extract %30 from 7 : (i8) -> i1
    %128 = comb.extract %32 from 7 : (i8) -> i1
    %129 = hw.array_get %34[%c0_i3] : !hw.array<8xi128>, i3
    %130 = llhd.sig.extract %packer_ep_wready from %c-1_i3 : <i8> -> <i1>
    %131 = llhd.sig.extract %packer_ep_rvalid from %c-1_i3 : <i8> -> <i1>
    %132 = llhd.sig.array_get %packer_ep_rdata[%c0_i3] : <!hw.array<8xi32>>
    %133 = comb.extract %39 from 7 : (i8) -> i1
    %gen_ep_blk_7.u_prim_packer_fifo_ep.wready_o, %gen_ep_blk_7.u_prim_packer_fifo_ep.rvalid_o, %gen_ep_blk_7.u_prim_packer_fifo_ep.rdata_o, %gen_ep_blk_7.u_prim_packer_fifo_ep.depth_o = hw.instance "gen_ep_blk_7.u_prim_packer_fifo_ep" @prim_packer_fifo_16(clk_i: %9: i1, rst_ni: %10: i1, clr_i: %127: i1, wvalid_i: %128: i1, wdata_i: %129: i128, rready_i: %133: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i32, depth_o: i3)
    llhd.drv %130, %gen_ep_blk_7.u_prim_packer_fifo_ep.wready_o after %2 : i1
    llhd.drv %131, %gen_ep_blk_7.u_prim_packer_fifo_ep.rvalid_o after %2 : i1
    llhd.drv %132, %gen_ep_blk_7.u_prim_packer_fifo_ep.rdata_o after %2 : i32
    %134 = hw.array_get %edn_i[%c-1_i3] : !hw.array<8xstruct<edn_req: i1>>, i3
    %edn_req_19 = hw.struct_extract %134["edn_req"] : !hw.struct<edn_req: i1>
    %135 = llhd.sig.extract %packer_ep_ack from %c-1_i3 : <i8> -> <i1>
    %136 = comb.extract %44 from 7 : (i8) -> i1
    %137 = llhd.sig.extract %packer_ep_rready from %c-1_i3 : <i8> -> <i1>
    %138 = llhd.sig.extract %packer_ep_clr from %c-1_i3 : <i8> -> <i1>
    %139 = llhd.sig.extract %edn_ack_sm_err from %c-1_i3 : <i8> -> <i1>
    %gen_ep_blk_7.u_edn_ack_sm_ep.ack_o, %gen_ep_blk_7.u_edn_ack_sm_ep.fifo_pop_o, %gen_ep_blk_7.u_edn_ack_sm_ep.fifo_clr_o, %gen_ep_blk_7.u_edn_ack_sm_ep.ack_sm_err_o = hw.instance "gen_ep_blk_7.u_edn_ack_sm_ep" @edn_ack_sm(clk_i: %9: i1, rst_ni: %10: i1, enable_i: %41: i1, req_i: %edn_req_19: i1, local_escalate_i: %142: i1, fifo_not_empty_i: %136: i1) -> (ack_o: i1, fifo_pop_o: i1, fifo_clr_o: i1, ack_sm_err_o: i1)
    llhd.drv %135, %gen_ep_blk_7.u_edn_ack_sm_ep.ack_o after %2 : i1
    llhd.drv %137, %gen_ep_blk_7.u_edn_ack_sm_ep.fifo_pop_o after %2 : i1
    llhd.drv %138, %gen_ep_blk_7.u_edn_ack_sm_ep.fifo_clr_o after %2 : i1
    llhd.drv %139, %gen_ep_blk_7.u_edn_ack_sm_ep.ack_sm_err_o after %2 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %809 = llhd.prb %clk_i_0 : i1
      %810 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%9, %10 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %811 = llhd.prb %clk_i_0 : i1
      %812 = comb.xor bin %809, %true : i1
      %813 = comb.and bin %812, %811 : i1
      %814 = llhd.prb %rst_ni_1 : i1
      %815 = comb.xor bin %814, %true : i1
      %816 = comb.and bin %810, %815 : i1
      %817 = comb.or bin %813, %816 : i1
      cf.cond_br %817, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %818 = llhd.prb %rst_ni_1 : i1
      %819 = comb.xor %818, %true : i1
      cf.cond_br %819, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %cs_cmd_req_q, %c0_i32 after %1 : i32
      llhd.drv %cs_cmd_req_vld_q, %false after %1 : i1
      llhd.drv %cs_cmd_req_out_q, %c0_i32 after %1 : i32
      llhd.drv %cs_cmd_req_vld_out_q, %false after %1 : i1
      llhd.drv %cs_cmd_req_vld_hold_q, %false after %1 : i1
      llhd.drv %cmd_fifo_cnt_q, %c0_i4 after %1 : i4
      llhd.drv %csrng_fips_q, %false after %1 : i1
      llhd.drv %edn_fips_q, %c0_i8 after %1 : i8
      llhd.drv %cs_rdata_capt_q, %c0_i64 after %1 : i64
      llhd.drv %cs_rdata_capt_vld_q, %false after %1 : i1
      llhd.drv %cmd_rdy_q, %false after %1 : i1
      llhd.drv %csrng_cmd_sts_q, %c0_i3 after %1 : i3
      llhd.drv %csrng_sw_cmd_ack_q, %false after %1 : i1
      llhd.drv %csrng_hw_cmd_sts_q, %c0_i3 after %1 : i3
      llhd.drv %boot_mode_q, %false after %1 : i1
      llhd.drv %auto_mode_q, %false after %1 : i1
      llhd.drv %cmd_type_q, %c0_i4 after %1 : i4
      llhd.drv %cmd_reg_rdy_q, %false after %1 : i1
      llhd.drv %cmd_hdr_busy_q, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %820 = llhd.prb %cs_cmd_req_d : i32
      llhd.drv %cs_cmd_req_q, %820 after %1 : i32
      %821 = llhd.prb %cs_cmd_req_vld_d : i1
      llhd.drv %cs_cmd_req_vld_q, %821 after %1 : i1
      %822 = llhd.prb %cs_cmd_req_out_d : i32
      llhd.drv %cs_cmd_req_out_q, %822 after %1 : i32
      %823 = llhd.prb %cs_cmd_req_vld_out_d : i1
      llhd.drv %cs_cmd_req_vld_out_q, %823 after %1 : i1
      %824 = llhd.prb %cs_cmd_req_vld_hold_d : i1
      llhd.drv %cs_cmd_req_vld_hold_q, %824 after %1 : i1
      %825 = llhd.prb %cmd_fifo_cnt_d : i4
      llhd.drv %cmd_fifo_cnt_q, %825 after %1 : i4
      %826 = llhd.prb %csrng_fips_d : i1
      llhd.drv %csrng_fips_q, %826 after %1 : i1
      %827 = llhd.prb %edn_fips_d : i8
      llhd.drv %edn_fips_q, %827 after %1 : i8
      %828 = llhd.prb %cs_rdata_capt_d : i64
      llhd.drv %cs_rdata_capt_q, %828 after %1 : i64
      %829 = llhd.prb %cs_rdata_capt_vld_d : i1
      llhd.drv %cs_rdata_capt_vld_q, %829 after %1 : i1
      %830 = llhd.prb %cmd_rdy_d : i1
      llhd.drv %cmd_rdy_q, %830 after %1 : i1
      %831 = llhd.prb %csrng_cmd_sts_d : i3
      llhd.drv %csrng_cmd_sts_q, %831 after %1 : i3
      %832 = llhd.prb %csrng_sw_cmd_ack_d : i1
      llhd.drv %csrng_sw_cmd_ack_q, %832 after %1 : i1
      %833 = llhd.prb %csrng_hw_cmd_ack_d : i1
      llhd.drv %csrng_hw_cmd_ack_q, %833 after %1 : i1
      %834 = llhd.prb %csrng_hw_cmd_sts_d : i3
      llhd.drv %csrng_hw_cmd_sts_q, %834 after %1 : i3
      %835 = llhd.prb %boot_mode_d : i1
      llhd.drv %boot_mode_q, %835 after %1 : i1
      %836 = llhd.prb %auto_mode_d : i1
      llhd.drv %auto_mode_q, %836 after %1 : i1
      %837 = llhd.prb %cmd_type_d : i4
      llhd.drv %cmd_type_q, %837 after %1 : i4
      %838 = llhd.prb %cmd_reg_rdy_d : i1
      llhd.drv %cmd_reg_rdy_q, %838 after %1 : i1
      %839 = llhd.prb %cmd_hdr_busy_d : i1
      llhd.drv %cmd_hdr_busy_q, %839 after %1 : i1
      cf.br ^bb1
    }
    %140 = llhd.prb %sw_cmd_mode : i1
    %141 = comb.and %csrng_rsp_ack, %140 {sv.namehint = "event_edn_cmd_req_done"} : i1
    %142 = comb.or %u_prim_fifo_sync_rescmd.err_o, %u_prim_fifo_sync_gencmd.err_o, %161, %159, %157 {sv.namehint = "fatal_loc_events"} : i1
    %143 = comb.extract %20 from 0 : (i19) -> i1
    %144 = comb.or %150, %153 : i1
    %145 = comb.and %143, %144 : i1
    %146 = comb.or %145, %142 {sv.namehint = "event_edn_fatal_err"} : i1
    %147 = comb.icmp ne %568, %c0_i3 : i3
    %148 = llhd.prb %err_code_test_bit : i31
    %149 = comb.extract %148 from 0 : (i31) -> i1
    %150 = comb.or %147, %149 {sv.namehint = "sfifo_rescmd_err_sum"} : i1
    %151 = comb.icmp ne %582, %c0_i3 : i3
    %152 = comb.extract %148 from 1 : (i31) -> i1
    %153 = comb.or %151, %152 {sv.namehint = "sfifo_gencmd_err_sum"} : i1
    %154 = llhd.prb %edn_ack_sm_err : i8
    %155 = comb.icmp ne %154, %c0_i8 : i8
    %156 = comb.extract %148 from 20 : (i31) -> i1
    %157 = comb.or %155, %156 {sv.namehint = "edn_ack_sm_err_sum"} : i1
    %158 = comb.extract %148 from 21 : (i31) -> i1
    %159 = comb.or %u_edn_main_sm.main_sm_err_o, %158 {sv.namehint = "edn_main_sm_err_sum"} : i1
    %160 = comb.extract %148 from 22 : (i31) -> i1
    %161 = comb.or %u_prim_count_max_reqs_cntr.err_o, %160 {sv.namehint = "edn_cntr_err_sum"} : i1
    %162 = comb.extract %148 from 28 : (i31) -> i1
    %163 = comb.or %563, %577, %162 {sv.namehint = "fifo_write_err_sum"} : i1
    %164 = comb.extract %148 from 29 : (i31) -> i1
    %165 = comb.or %565, %579, %164 {sv.namehint = "fifo_read_err_sum"} : i1
    %166 = comb.extract %148 from 30 : (i31) -> i1
    %167 = comb.or %567, %581, %166 {sv.namehint = "fifo_status_err_sum"} : i1
    %168 = llhd.sig.struct_extract %hw2reg["err_code"] : <!hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<d: i1, de: i1>, edn_cmd_req_done: !hw.struct<d: i1, de: i1>>, sw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>, hw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>, recov_alert_sts: !hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>, err_code: !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>, main_sm_state: !hw.struct<d: i9, de: i1>>>
    %169 = llhd.sig.struct_extract %168["sfifo_rescmd_err"] : <!hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>>
    %170 = llhd.sig.struct_extract %169["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %170, %true after %2 : i1
    %171 = llhd.sig.struct_extract %169["de"] : <!hw.struct<d: i1, de: i1>>
    %172 = comb.extract %20 from 1 : (i19) -> i1
    %173 = comb.and %172, %150 : i1
    llhd.drv %171, %173 after %2 : i1
    %174 = llhd.sig.struct_extract %168["sfifo_gencmd_err"] : <!hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>>
    %175 = llhd.sig.struct_extract %174["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %175, %true after %2 : i1
    %176 = llhd.sig.struct_extract %174["de"] : <!hw.struct<d: i1, de: i1>>
    %177 = comb.extract %20 from 2 : (i19) -> i1
    %178 = comb.and %177, %153 : i1
    llhd.drv %176, %178 after %2 : i1
    %179 = llhd.sig.struct_extract %168["edn_ack_sm_err"] : <!hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>>
    %180 = llhd.sig.struct_extract %179["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %180, %true after %2 : i1
    %181 = llhd.sig.struct_extract %179["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %181, %157 after %2 : i1
    %182 = llhd.sig.struct_extract %168["edn_main_sm_err"] : <!hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>>
    %183 = llhd.sig.struct_extract %182["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %183, %true after %2 : i1
    %184 = llhd.sig.struct_extract %182["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %184, %159 after %2 : i1
    %185 = llhd.sig.struct_extract %168["edn_cntr_err"] : <!hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>>
    %186 = llhd.sig.struct_extract %185["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %186, %true after %2 : i1
    %187 = llhd.sig.struct_extract %185["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %187, %161 after %2 : i1
    %boot_ins_cmd_20 = hw.struct_extract %reg2hw["boot_ins_cmd"] : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>
    %q_21 = hw.struct_extract %boot_ins_cmd_20["q"] : !hw.struct<q: i32>
    llhd.drv %boot_ins_cmd, %q_21 after %2 : i32
    %boot_gen_cmd_22 = hw.struct_extract %reg2hw["boot_gen_cmd"] : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>
    %q_23 = hw.struct_extract %boot_gen_cmd_22["q"] : !hw.struct<q: i32>
    llhd.drv %boot_gen_cmd, %q_23 after %2 : i32
    %188 = llhd.sig.struct_extract %168["fifo_write_err"] : <!hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>>
    %189 = llhd.sig.struct_extract %188["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %189, %true after %2 : i1
    %190 = llhd.sig.struct_extract %188["de"] : <!hw.struct<d: i1, de: i1>>
    %191 = comb.extract %20 from 3 : (i19) -> i1
    %192 = comb.and %191, %163 : i1
    llhd.drv %190, %192 after %2 : i1
    %193 = llhd.sig.struct_extract %168["fifo_read_err"] : <!hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>>
    %194 = llhd.sig.struct_extract %193["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %194, %true after %2 : i1
    %195 = llhd.sig.struct_extract %193["de"] : <!hw.struct<d: i1, de: i1>>
    %196 = comb.extract %20 from 4 : (i19) -> i1
    %197 = comb.and %196, %165 : i1
    llhd.drv %195, %197 after %2 : i1
    %198 = llhd.sig.struct_extract %168["fifo_state_err"] : <!hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>>
    %199 = llhd.sig.struct_extract %198["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %199, %true after %2 : i1
    %200 = llhd.sig.struct_extract %198["de"] : <!hw.struct<d: i1, de: i1>>
    %201 = comb.extract %20 from 5 : (i19) -> i1
    %202 = comb.and %201, %167 : i1
    llhd.drv %200, %202 after %2 : i1
    %203 = llhd.sig.extract %err_code_test_bit from %c0_i5 : <i31> -> <i1>
    %err_code_test = hw.struct_extract %reg2hw["err_code_test"] : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>
    %q_24 = hw.struct_extract %err_code_test["q"] : !hw.struct<q: i5, qe: i1>
    %204 = comb.icmp eq %q_24, %c0_i5 : i5
    %qe_25 = hw.struct_extract %err_code_test["qe"] : !hw.struct<q: i5, qe: i1>
    %205 = comb.and %204, %qe_25 : i1
    llhd.drv %203, %205 after %2 : i1
    %206 = llhd.sig.extract %err_code_test_bit from %c1_i5 : <i31> -> <i1>
    %207 = comb.icmp eq %q_24, %c1_i5 : i5
    %208 = comb.and %207, %qe_25 : i1
    llhd.drv %206, %208 after %2 : i1
    %209 = llhd.sig.extract %err_code_test_bit from %c2_i5 : <i31> -> <i1>
    %210 = comb.icmp eq %q_24, %c2_i5 : i5
    %211 = comb.and %210, %qe_25 : i1
    llhd.drv %209, %211 after %2 : i1
    %212 = llhd.sig.extract %err_code_test_bit from %c3_i5 : <i31> -> <i1>
    %213 = comb.icmp eq %q_24, %c3_i5 : i5
    %214 = comb.and %213, %qe_25 : i1
    llhd.drv %212, %214 after %2 : i1
    %215 = llhd.sig.extract %err_code_test_bit from %c4_i5 : <i31> -> <i1>
    %216 = comb.icmp eq %q_24, %c4_i5 : i5
    %217 = comb.and %216, %qe_25 : i1
    llhd.drv %215, %217 after %2 : i1
    %218 = llhd.sig.extract %err_code_test_bit from %c5_i5 : <i31> -> <i1>
    %219 = comb.icmp eq %q_24, %c5_i5 : i5
    %220 = comb.and %219, %qe_25 : i1
    llhd.drv %218, %220 after %2 : i1
    %221 = llhd.sig.extract %err_code_test_bit from %c6_i5 : <i31> -> <i1>
    %222 = comb.icmp eq %q_24, %c6_i5 : i5
    %223 = comb.and %222, %qe_25 : i1
    llhd.drv %221, %223 after %2 : i1
    %224 = llhd.sig.extract %err_code_test_bit from %c7_i5 : <i31> -> <i1>
    %225 = comb.icmp eq %q_24, %c7_i5 : i5
    %226 = comb.and %225, %qe_25 : i1
    llhd.drv %224, %226 after %2 : i1
    %227 = llhd.sig.extract %err_code_test_bit from %c8_i5 : <i31> -> <i1>
    %228 = comb.icmp eq %q_24, %c8_i5 : i5
    %229 = comb.and %228, %qe_25 : i1
    llhd.drv %227, %229 after %2 : i1
    %230 = llhd.sig.extract %err_code_test_bit from %c9_i5 : <i31> -> <i1>
    %231 = comb.icmp eq %q_24, %c9_i5 : i5
    %232 = comb.and %231, %qe_25 : i1
    llhd.drv %230, %232 after %2 : i1
    %233 = llhd.sig.extract %err_code_test_bit from %c10_i5 : <i31> -> <i1>
    %234 = comb.icmp eq %q_24, %c10_i5 : i5
    %235 = comb.and %234, %qe_25 : i1
    llhd.drv %233, %235 after %2 : i1
    %236 = llhd.sig.extract %err_code_test_bit from %c11_i5 : <i31> -> <i1>
    %237 = comb.icmp eq %q_24, %c11_i5 : i5
    %238 = comb.and %237, %qe_25 : i1
    llhd.drv %236, %238 after %2 : i1
    %239 = llhd.sig.extract %err_code_test_bit from %c12_i5 : <i31> -> <i1>
    %240 = comb.icmp eq %q_24, %c12_i5 : i5
    %241 = comb.and %240, %qe_25 : i1
    llhd.drv %239, %241 after %2 : i1
    %242 = llhd.sig.extract %err_code_test_bit from %c13_i5 : <i31> -> <i1>
    %243 = comb.icmp eq %q_24, %c13_i5 : i5
    %244 = comb.and %243, %qe_25 : i1
    llhd.drv %242, %244 after %2 : i1
    %245 = llhd.sig.extract %err_code_test_bit from %c14_i5 : <i31> -> <i1>
    %246 = comb.icmp eq %q_24, %c14_i5 : i5
    %247 = comb.and %246, %qe_25 : i1
    llhd.drv %245, %247 after %2 : i1
    %248 = llhd.sig.extract %err_code_test_bit from %c15_i5 : <i31> -> <i1>
    %249 = comb.icmp eq %q_24, %c15_i5 : i5
    %250 = comb.and %249, %qe_25 : i1
    llhd.drv %248, %250 after %2 : i1
    %251 = llhd.sig.extract %err_code_test_bit from %c-16_i5 : <i31> -> <i1>
    %252 = comb.icmp eq %q_24, %c-16_i5 : i5
    %253 = comb.and %252, %qe_25 : i1
    llhd.drv %251, %253 after %2 : i1
    %254 = llhd.sig.extract %err_code_test_bit from %c-15_i5 : <i31> -> <i1>
    %255 = comb.icmp eq %q_24, %c-15_i5 : i5
    %256 = comb.and %255, %qe_25 : i1
    llhd.drv %254, %256 after %2 : i1
    %257 = llhd.sig.extract %err_code_test_bit from %c-14_i5 : <i31> -> <i1>
    %258 = comb.icmp eq %q_24, %c-14_i5 : i5
    %259 = comb.and %258, %qe_25 : i1
    llhd.drv %257, %259 after %2 : i1
    %260 = llhd.sig.extract %err_code_test_bit from %c-13_i5 : <i31> -> <i1>
    %261 = comb.icmp eq %q_24, %c-13_i5 : i5
    %262 = comb.and %261, %qe_25 : i1
    llhd.drv %260, %262 after %2 : i1
    %263 = llhd.sig.extract %err_code_test_bit from %c-12_i5 : <i31> -> <i1>
    %264 = comb.icmp eq %q_24, %c-12_i5 : i5
    %265 = comb.and %264, %qe_25 : i1
    llhd.drv %263, %265 after %2 : i1
    %266 = llhd.sig.extract %err_code_test_bit from %c-11_i5 : <i31> -> <i1>
    %267 = comb.icmp eq %q_24, %c-11_i5 : i5
    %268 = comb.and %267, %qe_25 : i1
    llhd.drv %266, %268 after %2 : i1
    %269 = llhd.sig.extract %err_code_test_bit from %c-10_i5 : <i31> -> <i1>
    %270 = comb.icmp eq %q_24, %c-10_i5 : i5
    %271 = comb.and %270, %qe_25 : i1
    llhd.drv %269, %271 after %2 : i1
    %272 = llhd.sig.extract %err_code_test_bit from %c-9_i5 : <i31> -> <i1>
    %273 = comb.icmp eq %q_24, %c-9_i5 : i5
    %274 = comb.and %273, %qe_25 : i1
    llhd.drv %272, %274 after %2 : i1
    %275 = llhd.sig.extract %err_code_test_bit from %c-8_i5 : <i31> -> <i1>
    %276 = comb.icmp eq %q_24, %c-8_i5 : i5
    %277 = comb.and %276, %qe_25 : i1
    llhd.drv %275, %277 after %2 : i1
    %278 = llhd.sig.extract %err_code_test_bit from %c-7_i5 : <i31> -> <i1>
    %279 = comb.icmp eq %q_24, %c-7_i5 : i5
    %280 = comb.and %279, %qe_25 : i1
    llhd.drv %278, %280 after %2 : i1
    %281 = llhd.sig.extract %err_code_test_bit from %c-6_i5 : <i31> -> <i1>
    %282 = comb.icmp eq %q_24, %c-6_i5 : i5
    %283 = comb.and %282, %qe_25 : i1
    llhd.drv %281, %283 after %2 : i1
    %284 = llhd.sig.extract %err_code_test_bit from %c-5_i5 : <i31> -> <i1>
    %285 = comb.icmp eq %q_24, %c-5_i5 : i5
    %286 = comb.and %285, %qe_25 : i1
    llhd.drv %284, %286 after %2 : i1
    %287 = llhd.sig.extract %err_code_test_bit from %c-4_i5 : <i31> -> <i1>
    %288 = comb.icmp eq %q_24, %c-4_i5 : i5
    %289 = comb.and %288, %qe_25 : i1
    llhd.drv %287, %289 after %2 : i1
    %290 = llhd.sig.extract %err_code_test_bit from %c-3_i5 : <i31> -> <i1>
    %291 = comb.icmp eq %q_24, %c-3_i5 : i5
    %292 = comb.and %291, %qe_25 : i1
    llhd.drv %290, %292 after %2 : i1
    %293 = llhd.sig.extract %err_code_test_bit from %c-2_i5 : <i31> -> <i1>
    %294 = comb.icmp eq %q_24, %c-2_i5 : i5
    %295 = comb.and %294, %qe_25 : i1
    llhd.drv %293, %295 after %2 : i1
    %296 = comb.extract %20 from 17 : (i19) -> i1
    %csrng_rsp_sts = hw.struct_extract %24["csrng_rsp_sts"] : !hw.struct<csrng_req_ready: i1, csrng_rsp_ack: i1, csrng_rsp_sts: i3, genbits_valid: i1, genbits_fips: i1, genbits_bus: i128>
    %297 = comb.icmp ne %csrng_rsp_sts, %c0_i3 : i3
    %298 = comb.and %296, %csrng_rsp_ack, %297 {sv.namehint = "csrng_ack_err"} : i1
    %299 = llhd.sig.struct_extract %hw2reg["recov_alert_sts"] : <!hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<d: i1, de: i1>, edn_cmd_req_done: !hw.struct<d: i1, de: i1>>, sw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>, hw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>, recov_alert_sts: !hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>, err_code: !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>, main_sm_state: !hw.struct<d: i9, de: i1>>>
    %300 = llhd.sig.struct_extract %299["csrng_ack_err"] : <!hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>>
    %301 = llhd.sig.struct_extract %300["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %301, %298 after %2 : i1
    %302 = llhd.sig.struct_extract %300["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %302, %298 after %2 : i1
    %303 = comb.or %660, %369, %385, %606, %307, %298 {sv.namehint = "event_edn_recov_err"} : i1
    %alert_test = hw.struct_extract %reg2hw["alert_test"] : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>
    %recov_alert = hw.struct_extract %alert_test["recov_alert"] : !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>
    %q_26 = hw.struct_extract %recov_alert["q"] : !hw.struct<q: i1, qe: i1>
    %qe_27 = hw.struct_extract %recov_alert["qe"] : !hw.struct<q: i1, qe: i1>
    %304 = comb.and %q_26, %qe_27 : i1
    %fatal_alert = hw.struct_extract %alert_test["fatal_alert"] : !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>
    %q_28 = hw.struct_extract %fatal_alert["q"] : !hw.struct<q: i1, qe: i1>
    %qe_29 = hw.struct_extract %fatal_alert["qe"] : !hw.struct<q: i1, qe: i1>
    %305 = comb.and %q_28, %qe_29 : i1
    %ctrl = hw.struct_extract %reg2hw["ctrl"] : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>
    %edn_enable = hw.struct_extract %ctrl["edn_enable"] : !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>
    %q_30 = hw.struct_extract %edn_enable["q"] {sv.namehint = "mubi_edn_enable"} : !hw.struct<q: i4>
    %306 = hw.array_get %u_prim_mubi4_sync_edn_enable.mubi_o[%c0_i5] : !hw.array<20xi4>, i5
    %307 = func.call @"prim_mubi_pkg::mubi4_test_invalid"(%306) {sv.namehint = "edn_enable_pfa"} : (i4) -> i1
    %308 = llhd.sig.struct_extract %299["edn_enable_field_alert"] : <!hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>>
    %309 = llhd.sig.struct_extract %308["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %309, %307 after %2 : i1
    %310 = llhd.sig.struct_extract %308["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %310, %307 after %2 : i1
    %311 = llhd.sig.extract %edn_enable_fo from %c0_i5 : <i19> -> <i1>
    %312 = hw.array_get %u_prim_mubi4_sync_edn_enable.mubi_o[%c1_i5] : !hw.array<20xi4>, i5
    %313 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%312) : (i4) -> i1
    llhd.drv %311, %313 after %2 : i1
    %314 = llhd.sig.extract %edn_enable_fo from %c1_i5 : <i19> -> <i1>
    %315 = hw.array_get %u_prim_mubi4_sync_edn_enable.mubi_o[%c2_i5] : !hw.array<20xi4>, i5
    %316 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%315) : (i4) -> i1
    llhd.drv %314, %316 after %2 : i1
    %317 = llhd.sig.extract %edn_enable_fo from %c2_i5 : <i19> -> <i1>
    %318 = hw.array_get %u_prim_mubi4_sync_edn_enable.mubi_o[%c3_i5] : !hw.array<20xi4>, i5
    %319 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%318) : (i4) -> i1
    llhd.drv %317, %319 after %2 : i1
    %320 = llhd.sig.extract %edn_enable_fo from %c3_i5 : <i19> -> <i1>
    %321 = hw.array_get %u_prim_mubi4_sync_edn_enable.mubi_o[%c4_i5] : !hw.array<20xi4>, i5
    %322 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%321) : (i4) -> i1
    llhd.drv %320, %322 after %2 : i1
    %323 = llhd.sig.extract %edn_enable_fo from %c4_i5 : <i19> -> <i1>
    %324 = hw.array_get %u_prim_mubi4_sync_edn_enable.mubi_o[%c5_i5] : !hw.array<20xi4>, i5
    %325 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%324) : (i4) -> i1
    llhd.drv %323, %325 after %2 : i1
    %326 = llhd.sig.extract %edn_enable_fo from %c5_i5 : <i19> -> <i1>
    %327 = hw.array_get %u_prim_mubi4_sync_edn_enable.mubi_o[%c6_i5] : !hw.array<20xi4>, i5
    %328 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%327) : (i4) -> i1
    llhd.drv %326, %328 after %2 : i1
    %329 = llhd.sig.extract %edn_enable_fo from %c6_i5 : <i19> -> <i1>
    %330 = hw.array_get %u_prim_mubi4_sync_edn_enable.mubi_o[%c7_i5] : !hw.array<20xi4>, i5
    %331 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%330) : (i4) -> i1
    llhd.drv %329, %331 after %2 : i1
    %332 = llhd.sig.extract %edn_enable_fo from %c7_i5 : <i19> -> <i1>
    %333 = hw.array_get %u_prim_mubi4_sync_edn_enable.mubi_o[%c8_i5] : !hw.array<20xi4>, i5
    %334 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%333) : (i4) -> i1
    llhd.drv %332, %334 after %2 : i1
    %335 = llhd.sig.extract %edn_enable_fo from %c8_i5 : <i19> -> <i1>
    %336 = hw.array_get %u_prim_mubi4_sync_edn_enable.mubi_o[%c9_i5] : !hw.array<20xi4>, i5
    %337 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%336) : (i4) -> i1
    llhd.drv %335, %337 after %2 : i1
    %338 = llhd.sig.extract %edn_enable_fo from %c9_i5 : <i19> -> <i1>
    %339 = hw.array_get %u_prim_mubi4_sync_edn_enable.mubi_o[%c10_i5] : !hw.array<20xi4>, i5
    %340 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%339) : (i4) -> i1
    llhd.drv %338, %340 after %2 : i1
    %341 = llhd.sig.extract %edn_enable_fo from %c10_i5 : <i19> -> <i1>
    %342 = hw.array_get %u_prim_mubi4_sync_edn_enable.mubi_o[%c11_i5] : !hw.array<20xi4>, i5
    %343 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%342) : (i4) -> i1
    llhd.drv %341, %343 after %2 : i1
    %344 = llhd.sig.extract %edn_enable_fo from %c11_i5 : <i19> -> <i1>
    %345 = hw.array_get %u_prim_mubi4_sync_edn_enable.mubi_o[%c12_i5] : !hw.array<20xi4>, i5
    %346 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%345) : (i4) -> i1
    llhd.drv %344, %346 after %2 : i1
    %347 = llhd.sig.extract %edn_enable_fo from %c12_i5 : <i19> -> <i1>
    %348 = hw.array_get %u_prim_mubi4_sync_edn_enable.mubi_o[%c13_i5] : !hw.array<20xi4>, i5
    %349 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%348) : (i4) -> i1
    llhd.drv %347, %349 after %2 : i1
    %350 = llhd.sig.extract %edn_enable_fo from %c13_i5 : <i19> -> <i1>
    %351 = hw.array_get %u_prim_mubi4_sync_edn_enable.mubi_o[%c14_i5] : !hw.array<20xi4>, i5
    %352 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%351) : (i4) -> i1
    llhd.drv %350, %352 after %2 : i1
    %353 = llhd.sig.extract %edn_enable_fo from %c14_i5 : <i19> -> <i1>
    %354 = hw.array_get %u_prim_mubi4_sync_edn_enable.mubi_o[%c15_i5] : !hw.array<20xi4>, i5
    %355 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%354) : (i4) -> i1
    llhd.drv %353, %355 after %2 : i1
    %356 = llhd.sig.extract %edn_enable_fo from %c15_i5 : <i19> -> <i1>
    %357 = hw.array_get %u_prim_mubi4_sync_edn_enable.mubi_o[%c-16_i5] : !hw.array<20xi4>, i5
    %358 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%357) : (i4) -> i1
    llhd.drv %356, %358 after %2 : i1
    %359 = llhd.sig.extract %edn_enable_fo from %c-16_i5 : <i19> -> <i1>
    %360 = hw.array_get %u_prim_mubi4_sync_edn_enable.mubi_o[%c-15_i5] : !hw.array<20xi4>, i5
    %361 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%360) : (i4) -> i1
    llhd.drv %359, %361 after %2 : i1
    %362 = llhd.sig.extract %edn_enable_fo from %c-15_i5 : <i19> -> <i1>
    %363 = hw.array_get %u_prim_mubi4_sync_edn_enable.mubi_o[%c-14_i5] : !hw.array<20xi4>, i5
    %364 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%363) : (i4) -> i1
    llhd.drv %362, %364 after %2 : i1
    %365 = llhd.sig.extract %edn_enable_fo from %c-14_i5 : <i19> -> <i1>
    %366 = hw.array_get %u_prim_mubi4_sync_edn_enable.mubi_o[%c-13_i5] : !hw.array<20xi4>, i5
    %367 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%366) : (i4) -> i1
    llhd.drv %365, %367 after %2 : i1
    %cmd_fifo_rst = hw.struct_extract %ctrl["cmd_fifo_rst"] : !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>
    %q_31 = hw.struct_extract %cmd_fifo_rst["q"] {sv.namehint = "mubi_cmd_fifo_rst"} : !hw.struct<q: i4>
    %368 = hw.array_get %u_prim_mubi4_sync_cmd_fifo_rst.mubi_o[%c0_i2] : !hw.array<4xi4>, i2
    %369 = func.call @"prim_mubi_pkg::mubi4_test_invalid"(%368) {sv.namehint = "cmd_fifo_rst_pfa"} : (i4) -> i1
    %370 = llhd.sig.struct_extract %299["cmd_fifo_rst_field_alert"] : <!hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>>
    %371 = llhd.sig.struct_extract %370["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %371, %369 after %2 : i1
    %372 = llhd.sig.struct_extract %370["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %372, %369 after %2 : i1
    %373 = llhd.sig.extract %cmd_fifo_rst_fo from %c0_i2 : <i3> -> <i1>
    %374 = hw.array_get %u_prim_mubi4_sync_cmd_fifo_rst.mubi_o[%c1_i2] : !hw.array<4xi4>, i2
    %375 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%374) : (i4) -> i1
    llhd.drv %373, %375 after %2 : i1
    %376 = llhd.sig.extract %cmd_fifo_rst_fo from %c1_i2 : <i3> -> <i1>
    %377 = hw.array_get %u_prim_mubi4_sync_cmd_fifo_rst.mubi_o[%c-2_i2] : !hw.array<4xi4>, i2
    %378 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%377) : (i4) -> i1
    llhd.drv %376, %378 after %2 : i1
    %379 = llhd.sig.extract %cmd_fifo_rst_fo from %c-2_i2 : <i3> -> <i1>
    %380 = hw.array_get %u_prim_mubi4_sync_cmd_fifo_rst.mubi_o[%c-1_i2] : !hw.array<4xi4>, i2
    %381 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%380) : (i4) -> i1
    llhd.drv %379, %381 after %2 : i1
    %auto_req_mode = hw.struct_extract %ctrl["auto_req_mode"] : !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>
    %q_32 = hw.struct_extract %auto_req_mode["q"] {sv.namehint = "mubi_auto_req_mode"} : !hw.struct<q: i4>
    %382 = hw.array_get %u_prim_mubi4_sync_auto_req_mode.mubi_o[%false] : !hw.array<2xi4>, i1
    %383 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%382) {sv.namehint = "auto_req_mode_pfe"} : (i4) -> i1
    %384 = hw.array_get %u_prim_mubi4_sync_auto_req_mode.mubi_o[%true] : !hw.array<2xi4>, i1
    %385 = func.call @"prim_mubi_pkg::mubi4_test_invalid"(%384) {sv.namehint = "auto_req_mode_pfa"} : (i4) -> i1
    %386 = llhd.sig.struct_extract %299["auto_req_mode_field_alert"] : <!hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>>
    %387 = llhd.sig.struct_extract %386["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %387, %385 after %2 : i1
    %388 = llhd.sig.struct_extract %386["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %388, %385 after %2 : i1
    %sw_cmd_req = hw.struct_extract %reg2hw["sw_cmd_req"] : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>
    %qe_33 = hw.struct_extract %sw_cmd_req["qe"] : !hw.struct<q: i32, qe: i1>
    %389 = llhd.prb %cmd_reg_rdy_q : i1
    %390 = comb.and %qe_33, %389 : i1
    llhd.drv %sw_cmd_req_load, %390 after %2 : i1
    %q_34 = hw.struct_extract %sw_cmd_req["q"] : !hw.struct<q: i32, qe: i1>
    llhd.drv %sw_cmd_req_bus, %q_34 after %2 : i32
    %max_num_reqs_between_reseeds = hw.struct_extract %reg2hw["max_num_reqs_between_reseeds"] : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>
    %qe_35 = hw.struct_extract %max_num_reqs_between_reseeds["qe"] {sv.namehint = "max_reqs_between_reseed_load"} : !hw.struct<q: i32, qe: i1>
    %q_36 = hw.struct_extract %max_num_reqs_between_reseeds["q"] {sv.namehint = "max_reqs_between_reseed_bus"} : !hw.struct<q: i32, qe: i1>
    %reseed_cmd = hw.struct_extract %reg2hw["reseed_cmd"] : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>
    %qe_37 = hw.struct_extract %reseed_cmd["qe"] : !hw.struct<q: i32, qe: i1>
    llhd.drv %reseed_cmd_load, %qe_37 after %2 : i1
    %q_38 = hw.struct_extract %reseed_cmd["q"] : !hw.struct<q: i32, qe: i1>
    llhd.drv %reseed_cmd_bus, %q_38 after %2 : i32
    %generate_cmd = hw.struct_extract %reg2hw["generate_cmd"] : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>
    %qe_39 = hw.struct_extract %generate_cmd["qe"] : !hw.struct<q: i32, qe: i1>
    llhd.drv %generate_cmd_load, %qe_39 after %2 : i1
    %q_40 = hw.struct_extract %generate_cmd["q"] : !hw.struct<q: i32, qe: i1>
    llhd.drv %generate_cmd_bus, %q_40 after %2 : i32
    %391 = llhd.prb %cs_cmd_req_vld_out_q : i1
    %392 = comb.and %391, %411, %csrng_req_ready : i1
    llhd.drv %cs_cmd_handshake, %392 after %2 : i1
    %393 = comb.and %391, %424, %csrng_req_ready {sv.namehint = "gencmd_handshake"} : i1
    %394 = comb.and %391, %419, %csrng_req_ready {sv.namehint = "rescmd_handshake"} : i1
    %395 = comb.extract %20 from 6 : (i19) -> i1
    %396 = comb.xor %395, %true : i1
    %397 = llhd.prb %boot_wr_ins_cmd : i1
    %398 = llhd.prb %boot_ins_cmd : i32
    %399 = llhd.prb %boot_wr_gen_cmd : i1
    %400 = llhd.prb %boot_gen_cmd : i32
    %401 = llhd.prb %boot_wr_uni_cmd : i1
    %402 = llhd.prb %sw_cmd_req_bus : i32
    %403 = llhd.prb %cs_cmd_req_q : i32
    %404 = comb.mux %23, %402, %403 : i32
    %405 = comb.mux %401, %c5_i32, %404 : i32
    %406 = comb.mux %399, %400, %405 : i32
    %407 = comb.mux %397, %398, %406 : i32
    %408 = comb.mux %396, %c0_i32, %407 : i32
    llhd.drv %cs_cmd_req_d, %408 after %2 : i32
    %409 = comb.extract %20 from 7 : (i19) -> i1
    %410 = llhd.prb %cs_cmd_handshake : i1
    %411 = llhd.prb %cs_cmd_req_vld_q : i1
    %412 = comb.or %23, %397, %399, %401, %411 : i1
    %413 = comb.xor %410, %true : i1
    %414 = comb.and %409, %413, %412 : i1
    llhd.drv %cs_cmd_req_vld_d, %414 after %2 : i1
    %csrng_req_ready = hw.struct_extract %24["csrng_req_ready"] : !hw.struct<csrng_req_ready: i1, csrng_rsp_ack: i1, csrng_rsp_sts: i3, genbits_valid: i1, genbits_fips: i1, genbits_bus: i128>
    %415 = comb.extract %20 from 8 : (i19) -> i1
    %416 = comb.xor %415, %true : i1
    %417 = llhd.prb %send_rescmd : i1
    %418 = llhd.prb %capt_rescmd_fifo_cnt : i1
    %419 = comb.or %417, %418 : i1
    %420 = llhd.prb %sfifo_rescmd_rdata : i32
    %421 = llhd.prb %cs_cmd_req_out_q : i32
    %422 = comb.mux %18, %420, %421 : i32
    %423 = llhd.prb %capt_gencmd_fifo_cnt : i1
    %424 = comb.or %26, %423 : i1
    %425 = llhd.prb %sfifo_gencmd_rdata : i32
    %426 = comb.mux %19, %425, %421 : i32
    %427 = comb.xor %410, %true : i1
    %428 = comb.and %411, %427 : i1
    %429 = comb.mux %428, %403, %421 : i32
    %430 = comb.mux %424, %426, %429 : i32
    %431 = comb.mux %419, %422, %430 : i32
    %432 = comb.mux %416, %c0_i32, %431 : i32
    llhd.drv %cs_cmd_req_out_d, %432 after %2 : i32
    %433 = comb.extract %20 from 9 : (i19) -> i1
    %434 = llhd.prb %cs_cmd_req_vld_hold_q : i1
    %435 = comb.or %434, %391 : i1
    %436 = comb.xor %csrng_req_ready, %true : i1
    %437 = comb.and %433, %435, %436 : i1
    llhd.drv %cs_cmd_req_vld_hold_d, %437 after %2 : i1
    %438 = comb.or %419, %424, %428 : i1
    %439 = comb.xor %25, %true : i1
    %440 = comb.and %433, %439, %438 : i1
    llhd.drv %cs_cmd_req_vld_out_d, %440 after %2 : i1
    %441 = llhd.sig.struct_extract %csrng_cmd_o["csrng_req_valid"] : <!hw.struct<csrng_req_valid: i1, csrng_req_bus: i32, genbits_ready: i1>>
    %442 = llhd.prb %reject_csrng_entropy : i1
    %443 = comb.xor %442, %true : i1
    %444 = comb.and %391, %443 : i1
    %445 = comb.or %444, %434 : i1
    llhd.drv %441, %445 after %2 : i1
    %446 = llhd.sig.struct_extract %csrng_cmd_o["csrng_req_bus"] : <!hw.struct<csrng_req_valid: i1, csrng_req_bus: i32, genbits_ready: i1>>
    llhd.drv %446, %421 after %2 : i32
    %447 = llhd.sig.struct_extract %hw2reg["sw_cmd_sts"] : <!hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<d: i1, de: i1>, edn_cmd_req_done: !hw.struct<d: i1, de: i1>>, sw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>, hw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>, recov_alert_sts: !hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>, err_code: !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>, main_sm_state: !hw.struct<d: i9, de: i1>>>
    %448 = llhd.sig.struct_extract %447["cmd_rdy"] : <!hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>>
    %449 = llhd.sig.struct_extract %448["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %449, %true after %2 : i1
    %450 = llhd.sig.struct_extract %448["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %450, %454 after %2 : i1
    %451 = comb.xor %23, %true : i1
    %452 = llhd.prb %cmd_rdy_d : i1
    %453 = llhd.prb %cmd_reg_rdy_d : i1
    %454 = comb.and %451, %452, %453 {sv.namehint = "cmd_rdy"} : i1
    %455 = comb.extract %20 from 10 : (i19) -> i1
    %456 = comb.xor %455, %true : i1
    %457 = comb.xor %140, %true : i1
    %458 = llhd.prb %accept_sw_cmds_pulse : i1
    %459 = llhd.prb %cmd_rdy_q : i1
    %460 = comb.or %458, %csrng_rsp_ack, %459 : i1
    %461 = comb.xor %23, %true : i1
    %462 = comb.xor %442, %true : i1
    %463 = comb.and %455, %140, %462, %461, %460 : i1
    llhd.drv %cmd_rdy_d, %463 after %2 : i1
    %464 = llhd.sig.struct_extract %447["cmd_reg_rdy"] : <!hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>>
    %465 = llhd.sig.struct_extract %464["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %465, %true after %2 : i1
    %466 = llhd.sig.struct_extract %464["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %466, %453 after %2 : i1
    %467 = comb.or %458, %410, %389 : i1
    %468 = comb.xor %23, %true : i1
    %469 = comb.xor %442, %true : i1
    %470 = comb.and %455, %140, %469, %468, %467 : i1
    llhd.drv %cmd_reg_rdy_d, %470 after %2 : i1
    %471 = llhd.sig.struct_extract %447["cmd_sts"] : <!hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>>
    %472 = llhd.sig.struct_extract %471["de"] : <!hw.struct<d: i3, de: i1>>
    llhd.drv %472, %true after %2 : i1
    %473 = llhd.sig.struct_extract %471["d"] : <!hw.struct<d: i3, de: i1>>
    %474 = llhd.prb %csrng_cmd_sts_d : i3
    llhd.drv %473, %474 after %2 : i3
    %475 = comb.and %141, %443 : i1
    %476 = llhd.prb %csrng_cmd_sts_q : i3
    %477 = comb.mux %475, %csrng_rsp_sts, %476 : i3
    %478 = comb.mux %456, %c0_i3, %477 : i3
    llhd.drv %csrng_cmd_sts_d, %478 after %2 : i3
    %479 = llhd.sig.struct_extract %447["cmd_ack"] : <!hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>>
    %480 = llhd.sig.struct_extract %479["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %480, %true after %2 : i1
    %481 = llhd.sig.struct_extract %479["d"] : <!hw.struct<d: i1, de: i1>>
    %482 = llhd.prb %csrng_sw_cmd_ack_d : i1
    llhd.drv %481, %482 after %2 : i1
    %483 = llhd.prb %csrng_sw_cmd_ack_q : i1
    %484 = comb.or %475, %483 : i1
    %485 = comb.xor %23, %true : i1
    %486 = comb.and %455, %485, %484 : i1
    llhd.drv %csrng_sw_cmd_ack_d, %486 after %2 : i1
    %487 = comb.icmp eq %u_edn_main_sm.main_sm_state_o, %c193_i9 {sv.namehint = "main_sm_idle"} : i9
    %488 = llhd.prb %csrng_cmd_o : !hw.struct<csrng_req_valid: i1, csrng_req_bus: i32, genbits_ready: i1>
    %csrng_req_valid = hw.struct_extract %488["csrng_req_valid"] : !hw.struct<csrng_req_valid: i1, csrng_req_bus: i32, genbits_ready: i1>
    %489 = comb.and %457, %csrng_req_valid, %csrng_req_ready : i1
    llhd.drv %cs_hw_cmd_handshake, %489 after %2 : i1
    %490 = llhd.prb %cs_hw_cmd_handshake : i1
    %491 = comb.or %419, %26, %423 : i1
    %492 = llhd.prb %cmd_hdr_busy_q : i1
    %493 = comb.xor %491, %true : i1
    %494 = comb.or %493, %492 : i1
    %495 = comb.and %490, %494 : i1
    llhd.drv %cs_hw_cmd_handshake_1st, %495 after %2 : i1
    %496 = llhd.sig.struct_extract %hw2reg["hw_cmd_sts"] : <!hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<d: i1, de: i1>, edn_cmd_req_done: !hw.struct<d: i1, de: i1>>, sw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>, hw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>, recov_alert_sts: !hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>, err_code: !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>, main_sm_state: !hw.struct<d: i9, de: i1>>>
    %497 = llhd.sig.struct_extract %496["boot_mode"] : <!hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>>
    %498 = llhd.sig.struct_extract %497["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %498, %true after %2 : i1
    %499 = llhd.sig.struct_extract %497["d"] : <!hw.struct<d: i1, de: i1>>
    %500 = llhd.prb %boot_mode_d : i1
    llhd.drv %499, %500 after %2 : i1
    %501 = llhd.prb %main_sm_done_pulse : i1
    %502 = comb.or %501, %487 : i1
    %503 = llhd.prb %boot_send_ins_cmd : i1
    %504 = comb.and %503, %490 : i1
    %505 = llhd.prb %boot_mode_q : i1
    %506 = comb.or %504, %505 : i1
    %507 = comb.xor %502, %true : i1
    %508 = comb.and %507, %506 : i1
    llhd.drv %boot_mode_d, %508 after %2 : i1
    %509 = llhd.sig.struct_extract %496["auto_mode"] : <!hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>>
    %510 = llhd.sig.struct_extract %509["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %510, %true after %2 : i1
    %511 = llhd.sig.struct_extract %509["d"] : <!hw.struct<d: i1, de: i1>>
    %512 = llhd.prb %auto_mode_d : i1
    llhd.drv %511, %512 after %2 : i1
    %513 = llhd.prb %auto_req_mode_busy : i1
    %514 = comb.and %513, %490 : i1
    %515 = llhd.prb %auto_mode_q : i1
    %516 = comb.or %514, %515 : i1
    %517 = comb.xor %502, %true : i1
    %518 = comb.and %517, %516 : i1
    llhd.drv %auto_mode_d, %518 after %2 : i1
    %519 = llhd.sig.struct_extract %496["cmd_sts"] : <!hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>>
    %520 = llhd.sig.struct_extract %519["de"] : <!hw.struct<d: i3, de: i1>>
    llhd.drv %520, %true after %2 : i1
    %521 = llhd.sig.struct_extract %519["d"] : <!hw.struct<d: i3, de: i1>>
    %522 = llhd.prb %csrng_hw_cmd_sts_d : i3
    llhd.drv %521, %522 after %2 : i3
    %523 = comb.extract %20 from 11 : (i19) -> i1
    %524 = comb.xor %523, %true : i1
    %525 = comb.and %csrng_rsp_ack, %457, %443 : i1
    %526 = llhd.prb %csrng_hw_cmd_sts_q : i3
    %527 = comb.xor %490, %true : i1
    %528 = comb.or %442, %527 : i1
    %529 = comb.mux %528, %526, %c0_i3 : i3
    %530 = comb.mux %525, %csrng_rsp_sts, %529 : i3
    %531 = comb.mux %524, %c0_i3, %530 : i3
    llhd.drv %csrng_hw_cmd_sts_d, %531 after %2 : i3
    %532 = llhd.sig.struct_extract %496["cmd_ack"] : <!hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>>
    %533 = llhd.sig.struct_extract %532["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %533, %true after %2 : i1
    %534 = llhd.sig.struct_extract %532["d"] : <!hw.struct<d: i1, de: i1>>
    %535 = llhd.prb %csrng_hw_cmd_ack_d : i1
    llhd.drv %534, %535 after %2 : i1
    %536 = llhd.prb %csrng_hw_cmd_ack_q : i1
    %537 = comb.xor %490, %true : i1
    %538 = comb.or %442, %537 : i1
    %539 = comb.and %538, %536 : i1
    %540 = comb.or %525, %539 : i1
    %541 = comb.and %523, %540 : i1
    llhd.drv %csrng_hw_cmd_ack_d, %541 after %2 : i1
    %542 = llhd.sig.struct_extract %496["cmd_type"] : <!hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>>
    %543 = llhd.sig.struct_extract %542["de"] : <!hw.struct<d: i4, de: i1>>
    llhd.drv %543, %true after %2 : i1
    %544 = llhd.sig.struct_extract %542["d"] : <!hw.struct<d: i4, de: i1>>
    %545 = llhd.prb %cmd_type_d : i4
    llhd.drv %544, %545 after %2 : i4
    %546 = llhd.prb %cmd_type_q : i4
    %547 = llhd.prb %cs_hw_cmd_handshake_1st : i1
    %548 = comb.extract %421 from 0 : (i32) -> i4
    %549 = comb.xor %547, %true : i1
    %550 = comb.or %442, %549 : i1
    %551 = comb.mux %550, %546, %548 : i4
    %552 = comb.mux %524, %c0_i4, %551 : i4
    llhd.drv %cmd_type_d, %552 after %2 : i4
    %553 = llhd.prb %reseed_cmd_load : i1
    %554 = comb.or %394, %553 {sv.namehint = "sfifo_rescmd_push"} : i1
    %555 = llhd.prb %reseed_cmd_bus : i32
    %556 = comb.mux %513, %421, %555 {sv.namehint = "sfifo_rescmd_wdata"} : i32
    %557 = comb.xor %25, %true : i1
    %558 = comb.and %394, %557 : i1
    %559 = comb.or %558, %418 : i1
    llhd.drv %sfifo_rescmd_pop, %559 after %2 : i1
    %560 = llhd.prb %cmd_fifo_rst_fo : i3
    %561 = comb.extract %560 from 0 : (i3) -> i1
    %562 = comb.or %561, %501 {sv.namehint = "sfifo_rescmd_clr"} : i1
    %563 = comb.and %554, %u_prim_fifo_sync_rescmd.full_o : i1
    %564 = comb.xor %u_prim_fifo_sync_rescmd.rvalid_o, %true : i1
    %565 = comb.and %18, %564 : i1
    %566 = comb.and %u_prim_fifo_sync_rescmd.full_o, %564 : i1
    %567 = comb.or %566, %u_prim_fifo_sync_rescmd.err_o : i1
    %568 = comb.concat %563, %565, %567 {sv.namehint = "sfifo_rescmd_err"} : i1, i1, i1
    %569 = llhd.prb %generate_cmd_load : i1
    %570 = comb.or %393, %569 {sv.namehint = "sfifo_gencmd_push"} : i1
    %571 = llhd.prb %generate_cmd_bus : i32
    %572 = comb.mux %513, %421, %571 {sv.namehint = "sfifo_gencmd_wdata"} : i32
    %573 = comb.and %393, %557 : i1
    %574 = comb.or %573, %423 : i1
    llhd.drv %sfifo_gencmd_pop, %574 after %2 : i1
    %575 = comb.extract %560 from 1 : (i3) -> i1
    %576 = comb.or %575, %501 {sv.namehint = "sfifo_gencmd_clr"} : i1
    %577 = comb.and %570, %u_prim_fifo_sync_gencmd.full_o : i1
    %578 = comb.xor %u_prim_fifo_sync_gencmd.rvalid_o, %true : i1
    %579 = comb.and %19, %578 : i1
    %580 = comb.and %u_prim_fifo_sync_gencmd.full_o, %578 : i1
    %581 = comb.or %580, %u_prim_fifo_sync_gencmd.err_o : i1
    %582 = comb.concat %577, %579, %581 {sv.namehint = "sfifo_gencmd_err"} : i1, i1, i1
    %583 = comb.and %417, %25 : i1
    %584 = comb.or %qe_35, %583, %501 {sv.namehint = "max_reqs_cnt_load"} : i1
    %585 = comb.icmp eq %u_prim_count_max_reqs_cntr.cnt_o, %c0_i32 {sv.namehint = "max_reqs_cnt_zero"} : i32
    %586 = comb.extract %20 from 13 : (i19) -> i1
    %587 = comb.xor %586, %true : i1
    %588 = comb.extract %560 from 2 : (i3) -> i1
    %589 = llhd.prb %sfifo_gencmd_depth : i4
    %590 = llhd.prb %sfifo_rescmd_depth : i4
    %591 = comb.or %19, %18 : i1
    %592 = llhd.prb %cmd_fifo_cnt_q : i4
    %593 = comb.add %592, %c-1_i4 : i4
    %594 = comb.mux %591, %593, %592 : i4
    %595 = comb.mux %418, %590, %594 : i4
    %596 = comb.mux %423, %589, %595 : i4
    %597 = comb.or %587, %588, %501 : i1
    %598 = comb.mux %597, %c0_i4, %596 : i4
    llhd.drv %cmd_fifo_cnt_d, %598 after %2 : i4
    %599 = comb.icmp eq %592, %c1_i4 : i4
    %600 = comb.or %393, %394 : i1
    %601 = comb.and %599, %600 : i1
    llhd.drv %cmd_sent, %601 after %2 : i1
    %602 = comb.xor %490, %true : i1
    %603 = comb.and %602, %492 : i1
    %604 = comb.or %423, %418, %603 : i1
    llhd.drv %cmd_hdr_busy_d, %604 after %2 : i1
    %boot_req_mode = hw.struct_extract %ctrl["boot_req_mode"] : !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>
    %q_41 = hw.struct_extract %boot_req_mode["q"] {sv.namehint = "mubi_boot_req_mode"} : !hw.struct<q: i4>
    %605 = hw.array_get %u_prim_mubi4_sync_boot_req_mode.mubi_o[%false] : !hw.array<2xi4>, i1
    %606 = func.call @"prim_mubi_pkg::mubi4_test_invalid"(%605) {sv.namehint = "boot_req_mode_pfa"} : (i4) -> i1
    %607 = llhd.sig.struct_extract %299["boot_req_mode_field_alert"] : <!hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>>
    %608 = llhd.sig.struct_extract %607["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %608, %606 after %2 : i1
    %609 = llhd.sig.struct_extract %607["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %609, %606 after %2 : i1
    %610 = hw.array_get %u_prim_mubi4_sync_boot_req_mode.mubi_o[%true] : !hw.array<2xi4>, i1
    %611 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%610) : (i4) -> i1
    llhd.drv %boot_req_mode_fo, %611 after %2 : i1
    %612 = llhd.sig.extract %packer_arb_req from %c0_i3 : <i8> -> <i1>
    %613 = comb.xor %45, %true : i1
    %614 = comb.and %613, %edn_req : i1
    llhd.drv %612, %614 after %2 : i1
    %615 = llhd.sig.extract %packer_arb_req from %c1_i3 : <i8> -> <i1>
    %616 = comb.xor %58, %true : i1
    %617 = comb.and %616, %edn_req_13 : i1
    llhd.drv %615, %617 after %2 : i1
    %618 = llhd.sig.extract %packer_arb_req from %c2_i3 : <i8> -> <i1>
    %619 = comb.xor %71, %true : i1
    %620 = comb.and %619, %edn_req_14 : i1
    llhd.drv %618, %620 after %2 : i1
    %621 = llhd.sig.extract %packer_arb_req from %c3_i3 : <i8> -> <i1>
    %622 = comb.xor %84, %true : i1
    %623 = comb.and %622, %edn_req_15 : i1
    llhd.drv %621, %623 after %2 : i1
    %624 = llhd.sig.extract %packer_arb_req from %c-4_i3 : <i8> -> <i1>
    %625 = comb.xor %97, %true : i1
    %626 = comb.and %625, %edn_req_16 : i1
    llhd.drv %624, %626 after %2 : i1
    %627 = llhd.sig.extract %packer_arb_req from %c-3_i3 : <i8> -> <i1>
    %628 = comb.xor %110, %true : i1
    %629 = comb.and %628, %edn_req_17 : i1
    llhd.drv %627, %629 after %2 : i1
    %630 = llhd.sig.extract %packer_arb_req from %c-2_i3 : <i8> -> <i1>
    %631 = comb.xor %123, %true : i1
    %632 = comb.and %631, %edn_req_18 : i1
    llhd.drv %630, %632 after %2 : i1
    %633 = llhd.sig.extract %packer_arb_req from %c-1_i3 : <i8> -> <i1>
    %634 = comb.xor %136, %true : i1
    %635 = comb.and %634, %edn_req_19 : i1
    llhd.drv %633, %635 after %2 : i1
    %636 = comb.extract %20 from 14 : (i19) -> i1
    %637 = comb.xor %636, %true {sv.namehint = "packer_cs_clr"} : i1
    %genbits_valid = hw.struct_extract %24["genbits_valid"] : !hw.struct<csrng_req_ready: i1, csrng_rsp_ack: i1, csrng_rsp_sts: i3, genbits_valid: i1, genbits_fips: i1, genbits_bus: i128>
    %638 = comb.and %297, %csrng_rsp_ack : i1
    %639 = comb.xor %638, %true : i1
    %640 = comb.and %genbits_valid, %443, %639 : i1
    llhd.drv %packer_cs_push, %640 after %2 : i1
    %genbits_bus = hw.struct_extract %24["genbits_bus"] {sv.namehint = "packer_cs_wdata"} : !hw.struct<csrng_req_ready: i1, csrng_rsp_ack: i1, csrng_rsp_sts: i3, genbits_valid: i1, genbits_fips: i1, genbits_bus: i128>
    %641 = llhd.sig.struct_extract %csrng_cmd_o["genbits_ready"] : <!hw.struct<csrng_req_valid: i1, csrng_req_bus: i32, genbits_ready: i1>>
    %642 = llhd.prb %packer_cs_wready : i1
    %643 = comb.and %642, %443 : i1
    llhd.drv %641, %643 after %2 : i1
    %644 = comb.extract %20 from 15 : (i19) -> i1
    %645 = comb.and %29, %642 : i1
    %genbits_fips = hw.struct_extract %24["genbits_fips"] : !hw.struct<csrng_req_ready: i1, csrng_rsp_ack: i1, csrng_rsp_sts: i3, genbits_valid: i1, genbits_fips: i1, genbits_bus: i128>
    %646 = llhd.prb %csrng_fips_q : i1
    %647 = comb.mux %645, %genbits_fips, %646 : i1
    %648 = comb.and %644, %647 : i1
    llhd.drv %csrng_fips_d, %648 after %2 : i1
    %649 = comb.and %u_prim_packer_fifo_cs.rvalid_o, %u_prim_arbiter_ppc_packer_arb.valid_o : i1
    llhd.drv %cs_rdata_capt_vld, %649 after %2 : i1
    %650 = llhd.prb %cs_rdata_capt_vld : i1
    %651 = llhd.prb %packer_cs_rdata : i128
    %652 = comb.extract %651 from 0 : (i128) -> i64
    %653 = llhd.prb %cs_rdata_capt_q : i64
    %654 = comb.mux %650, %652, %653 : i64
    llhd.drv %cs_rdata_capt_d, %654 after %2 : i64
    %655 = comb.extract %20 from 16 : (i19) -> i1
    %656 = llhd.prb %cs_rdata_capt_vld_q : i1
    %657 = comb.or %650, %656 : i1
    %658 = comb.and %655, %657 : i1
    llhd.drv %cs_rdata_capt_vld_d, %658 after %2 : i1
    %659 = comb.icmp eq %653, %652 : i64
    %660 = comb.and %650, %656, %659 {sv.namehint = "edn_bus_cmp_alert"} : i1
    %661 = llhd.sig.struct_extract %299["edn_bus_cmp_alert"] : <!hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>>
    %662 = llhd.sig.struct_extract %661["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %662, %660 after %2 : i1
    %663 = llhd.sig.struct_extract %661["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %663, %660 after %2 : i1
    %664 = llhd.sig.extract %packer_ep_push from %c0_i3 : <i8> -> <i1>
    %665 = llhd.prb %packer_ep_wready : i8
    %666 = comb.extract %665 from 0 : (i8) -> i1
    %667 = comb.extract %u_prim_arbiter_ppc_packer_arb.gnt_o from 0 : (i8) -> i1
    %668 = comb.and %u_prim_arbiter_ppc_packer_arb.valid_o, %666, %667 : i1
    llhd.drv %664, %668 after %2 : i1
    %669 = llhd.sig.array_get %packer_ep_wdata[%c-1_i3] : <!hw.array<8xi128>>
    llhd.drv %669, %651 after %2 : i128
    %670 = llhd.sig.extract %edn_fips_d from %c0_i3 : <i8> -> <i1>
    %671 = comb.and %33, %666 : i1
    %672 = llhd.prb %edn_fips_q : i8
    %673 = comb.extract %672 from 0 : (i8) -> i1
    %674 = comb.mux %671, %646, %673 : i1
    %675 = comb.xor %31, %true : i1
    %676 = comb.and %675, %674 : i1
    llhd.drv %670, %676 after %2 : i1
    %677 = llhd.sig.array_get %edn_o[%c0_i3] : <!hw.array<8xstruct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>>
    %678 = llhd.sig.struct_extract %677["edn_fips"] : <!hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>
    llhd.drv %678, %673 after %2 : i1
    %679 = llhd.sig.struct_extract %677["edn_ack"] : <!hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>
    %680 = llhd.prb %packer_ep_ack : i8
    %681 = comb.extract %680 from 0 : (i8) -> i1
    llhd.drv %679, %681 after %2 : i1
    %682 = llhd.sig.struct_extract %677["edn_bus"] : <!hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>
    %683 = llhd.prb %packer_ep_rdata : !hw.array<8xi32>
    %684 = hw.array_get %683[%c-1_i3] : !hw.array<8xi32>, i3
    llhd.drv %682, %684 after %2 : i32
    %685 = llhd.sig.extract %packer_ep_push from %c1_i3 : <i8> -> <i1>
    %686 = comb.extract %665 from 1 : (i8) -> i1
    %687 = comb.extract %u_prim_arbiter_ppc_packer_arb.gnt_o from 1 : (i8) -> i1
    %688 = comb.and %u_prim_arbiter_ppc_packer_arb.valid_o, %686, %687 : i1
    llhd.drv %685, %688 after %2 : i1
    %689 = llhd.sig.array_get %packer_ep_wdata[%c-2_i3] : <!hw.array<8xi128>>
    llhd.drv %689, %651 after %2 : i128
    %690 = llhd.sig.extract %edn_fips_d from %c1_i3 : <i8> -> <i1>
    %691 = comb.and %50, %686 : i1
    %692 = comb.extract %672 from 1 : (i8) -> i1
    %693 = comb.mux %691, %646, %692 : i1
    %694 = comb.xor %49, %true : i1
    %695 = comb.and %694, %693 : i1
    llhd.drv %690, %695 after %2 : i1
    %696 = llhd.sig.array_get %edn_o[%c1_i3] : <!hw.array<8xstruct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>>
    %697 = llhd.sig.struct_extract %696["edn_fips"] : <!hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>
    llhd.drv %697, %692 after %2 : i1
    %698 = llhd.sig.struct_extract %696["edn_ack"] : <!hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>
    %699 = comb.extract %680 from 1 : (i8) -> i1
    llhd.drv %698, %699 after %2 : i1
    %700 = llhd.sig.struct_extract %696["edn_bus"] : <!hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>
    %701 = hw.array_get %683[%c-2_i3] : !hw.array<8xi32>, i3
    llhd.drv %700, %701 after %2 : i32
    %702 = llhd.sig.extract %packer_ep_push from %c2_i3 : <i8> -> <i1>
    %703 = comb.extract %665 from 2 : (i8) -> i1
    %704 = comb.extract %u_prim_arbiter_ppc_packer_arb.gnt_o from 2 : (i8) -> i1
    %705 = comb.and %u_prim_arbiter_ppc_packer_arb.valid_o, %703, %704 : i1
    llhd.drv %702, %705 after %2 : i1
    %706 = llhd.sig.array_get %packer_ep_wdata[%c-3_i3] : <!hw.array<8xi128>>
    llhd.drv %706, %651 after %2 : i128
    %707 = llhd.sig.extract %edn_fips_d from %c2_i3 : <i8> -> <i1>
    %708 = comb.and %63, %703 : i1
    %709 = comb.extract %672 from 2 : (i8) -> i1
    %710 = comb.mux %708, %646, %709 : i1
    %711 = comb.xor %62, %true : i1
    %712 = comb.and %711, %710 : i1
    llhd.drv %707, %712 after %2 : i1
    %713 = llhd.sig.array_get %edn_o[%c2_i3] : <!hw.array<8xstruct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>>
    %714 = llhd.sig.struct_extract %713["edn_fips"] : <!hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>
    llhd.drv %714, %709 after %2 : i1
    %715 = llhd.sig.struct_extract %713["edn_ack"] : <!hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>
    %716 = comb.extract %680 from 2 : (i8) -> i1
    llhd.drv %715, %716 after %2 : i1
    %717 = llhd.sig.struct_extract %713["edn_bus"] : <!hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>
    %718 = hw.array_get %683[%c-3_i3] : !hw.array<8xi32>, i3
    llhd.drv %717, %718 after %2 : i32
    %719 = llhd.sig.extract %packer_ep_push from %c3_i3 : <i8> -> <i1>
    %720 = comb.extract %665 from 3 : (i8) -> i1
    %721 = comb.extract %u_prim_arbiter_ppc_packer_arb.gnt_o from 3 : (i8) -> i1
    %722 = comb.and %u_prim_arbiter_ppc_packer_arb.valid_o, %720, %721 : i1
    llhd.drv %719, %722 after %2 : i1
    %723 = llhd.sig.array_get %packer_ep_wdata[%c-4_i3] : <!hw.array<8xi128>>
    llhd.drv %723, %651 after %2 : i128
    %724 = llhd.sig.extract %edn_fips_d from %c3_i3 : <i8> -> <i1>
    %725 = comb.and %76, %720 : i1
    %726 = comb.extract %672 from 3 : (i8) -> i1
    %727 = comb.mux %725, %646, %726 : i1
    %728 = comb.xor %75, %true : i1
    %729 = comb.and %728, %727 : i1
    llhd.drv %724, %729 after %2 : i1
    %730 = llhd.sig.array_get %edn_o[%c3_i3] : <!hw.array<8xstruct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>>
    %731 = llhd.sig.struct_extract %730["edn_fips"] : <!hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>
    llhd.drv %731, %726 after %2 : i1
    %732 = llhd.sig.struct_extract %730["edn_ack"] : <!hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>
    %733 = comb.extract %680 from 3 : (i8) -> i1
    llhd.drv %732, %733 after %2 : i1
    %734 = llhd.sig.struct_extract %730["edn_bus"] : <!hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>
    %735 = hw.array_get %683[%c-4_i3] : !hw.array<8xi32>, i3
    llhd.drv %734, %735 after %2 : i32
    %736 = llhd.sig.extract %packer_ep_push from %c-4_i3 : <i8> -> <i1>
    %737 = comb.extract %665 from 4 : (i8) -> i1
    %738 = comb.extract %u_prim_arbiter_ppc_packer_arb.gnt_o from 4 : (i8) -> i1
    %739 = comb.and %u_prim_arbiter_ppc_packer_arb.valid_o, %737, %738 : i1
    llhd.drv %736, %739 after %2 : i1
    %740 = llhd.sig.array_get %packer_ep_wdata[%c3_i3] : <!hw.array<8xi128>>
    llhd.drv %740, %651 after %2 : i128
    %741 = llhd.sig.extract %edn_fips_d from %c-4_i3 : <i8> -> <i1>
    %742 = comb.and %89, %737 : i1
    %743 = comb.extract %672 from 4 : (i8) -> i1
    %744 = comb.mux %742, %646, %743 : i1
    %745 = comb.xor %88, %true : i1
    %746 = comb.and %745, %744 : i1
    llhd.drv %741, %746 after %2 : i1
    %747 = llhd.sig.array_get %edn_o[%c-4_i3] : <!hw.array<8xstruct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>>
    %748 = llhd.sig.struct_extract %747["edn_fips"] : <!hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>
    llhd.drv %748, %743 after %2 : i1
    %749 = llhd.sig.struct_extract %747["edn_ack"] : <!hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>
    %750 = comb.extract %680 from 4 : (i8) -> i1
    llhd.drv %749, %750 after %2 : i1
    %751 = llhd.sig.struct_extract %747["edn_bus"] : <!hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>
    %752 = hw.array_get %683[%c3_i3] : !hw.array<8xi32>, i3
    llhd.drv %751, %752 after %2 : i32
    %753 = llhd.sig.extract %packer_ep_push from %c-3_i3 : <i8> -> <i1>
    %754 = comb.extract %665 from 5 : (i8) -> i1
    %755 = comb.extract %u_prim_arbiter_ppc_packer_arb.gnt_o from 5 : (i8) -> i1
    %756 = comb.and %u_prim_arbiter_ppc_packer_arb.valid_o, %754, %755 : i1
    llhd.drv %753, %756 after %2 : i1
    %757 = llhd.sig.array_get %packer_ep_wdata[%c2_i3] : <!hw.array<8xi128>>
    llhd.drv %757, %651 after %2 : i128
    %758 = llhd.sig.extract %edn_fips_d from %c-3_i3 : <i8> -> <i1>
    %759 = comb.and %102, %754 : i1
    %760 = comb.extract %672 from 5 : (i8) -> i1
    %761 = comb.mux %759, %646, %760 : i1
    %762 = comb.xor %101, %true : i1
    %763 = comb.and %762, %761 : i1
    llhd.drv %758, %763 after %2 : i1
    %764 = llhd.sig.array_get %edn_o[%c-3_i3] : <!hw.array<8xstruct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>>
    %765 = llhd.sig.struct_extract %764["edn_fips"] : <!hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>
    llhd.drv %765, %760 after %2 : i1
    %766 = llhd.sig.struct_extract %764["edn_ack"] : <!hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>
    %767 = comb.extract %680 from 5 : (i8) -> i1
    llhd.drv %766, %767 after %2 : i1
    %768 = llhd.sig.struct_extract %764["edn_bus"] : <!hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>
    %769 = hw.array_get %683[%c2_i3] : !hw.array<8xi32>, i3
    llhd.drv %768, %769 after %2 : i32
    %770 = llhd.sig.extract %packer_ep_push from %c-2_i3 : <i8> -> <i1>
    %771 = comb.extract %665 from 6 : (i8) -> i1
    %772 = comb.extract %u_prim_arbiter_ppc_packer_arb.gnt_o from 6 : (i8) -> i1
    %773 = comb.and %u_prim_arbiter_ppc_packer_arb.valid_o, %771, %772 : i1
    llhd.drv %770, %773 after %2 : i1
    %774 = llhd.sig.array_get %packer_ep_wdata[%c1_i3] : <!hw.array<8xi128>>
    llhd.drv %774, %651 after %2 : i128
    %775 = llhd.sig.extract %edn_fips_d from %c-2_i3 : <i8> -> <i1>
    %776 = comb.and %115, %771 : i1
    %777 = comb.extract %672 from 6 : (i8) -> i1
    %778 = comb.mux %776, %646, %777 : i1
    %779 = comb.xor %114, %true : i1
    %780 = comb.and %779, %778 : i1
    llhd.drv %775, %780 after %2 : i1
    %781 = llhd.sig.array_get %edn_o[%c-2_i3] : <!hw.array<8xstruct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>>
    %782 = llhd.sig.struct_extract %781["edn_fips"] : <!hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>
    llhd.drv %782, %777 after %2 : i1
    %783 = llhd.sig.struct_extract %781["edn_ack"] : <!hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>
    %784 = comb.extract %680 from 6 : (i8) -> i1
    llhd.drv %783, %784 after %2 : i1
    %785 = llhd.sig.struct_extract %781["edn_bus"] : <!hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>
    %786 = hw.array_get %683[%c1_i3] : !hw.array<8xi32>, i3
    llhd.drv %785, %786 after %2 : i32
    %787 = llhd.sig.extract %packer_ep_push from %c-1_i3 : <i8> -> <i1>
    %788 = comb.extract %665 from 7 : (i8) -> i1
    %789 = comb.extract %u_prim_arbiter_ppc_packer_arb.gnt_o from 7 : (i8) -> i1
    %790 = comb.and %u_prim_arbiter_ppc_packer_arb.valid_o, %788, %789 : i1
    llhd.drv %787, %790 after %2 : i1
    %791 = llhd.sig.array_get %packer_ep_wdata[%c0_i3] : <!hw.array<8xi128>>
    llhd.drv %791, %651 after %2 : i128
    %792 = llhd.sig.extract %edn_fips_d from %c-1_i3 : <i8> -> <i1>
    %793 = comb.and %128, %788 : i1
    %794 = comb.extract %672 from 7 : (i8) -> i1
    %795 = comb.mux %793, %646, %794 : i1
    %796 = comb.xor %127, %true : i1
    %797 = comb.and %796, %795 : i1
    llhd.drv %792, %797 after %2 : i1
    %798 = llhd.sig.array_get %edn_o[%c-1_i3] : <!hw.array<8xstruct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>>
    %799 = llhd.sig.struct_extract %798["edn_fips"] : <!hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>
    llhd.drv %799, %794 after %2 : i1
    %800 = llhd.sig.struct_extract %798["edn_ack"] : <!hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>
    %801 = comb.extract %680 from 7 : (i8) -> i1
    llhd.drv %800, %801 after %2 : i1
    %802 = llhd.sig.struct_extract %798["edn_bus"] : <!hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>
    %803 = hw.array_get %683[%c0_i3] : !hw.array<8xi32>, i3
    llhd.drv %802, %803 after %2 : i32
    %804 = llhd.sig.struct_extract %hw2reg["main_sm_state"] : <!hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<d: i1, de: i1>, edn_cmd_req_done: !hw.struct<d: i1, de: i1>>, sw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>, hw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>, recov_alert_sts: !hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>, err_code: !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>, main_sm_state: !hw.struct<d: i9, de: i1>>>
    %805 = llhd.sig.struct_extract %804["de"] : <!hw.struct<d: i9, de: i1>>
    llhd.drv %805, %true after %2 : i1
    %806 = llhd.sig.struct_extract %804["d"] : <!hw.struct<d: i9, de: i1>>
    llhd.drv %806, %u_edn_main_sm.main_sm_state_o after %2 : i9
    llhd.drv %clk_i_0, %clk_i after %2 : i1
    llhd.drv %rst_ni_1, %rst_ni after %2 : i1
    %807 = llhd.prb %hw2reg : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<d: i1, de: i1>, edn_cmd_req_done: !hw.struct<d: i1, de: i1>>, sw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>, hw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>, recov_alert_sts: !hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>, err_code: !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>, main_sm_state: !hw.struct<d: i9, de: i1>>
    %808 = llhd.prb %edn_o : !hw.array<8xstruct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>
    llhd.drv %csrng_cmd_i_2, %csrng_cmd_i after %2 : !hw.struct<csrng_req_ready: i1, csrng_rsp_ack: i1, csrng_rsp_sts: i3, genbits_valid: i1, genbits_fips: i1, genbits_bus: i128>
    hw.output %807, %808, %488, %304, %305, %u_prim_edge_detector_recov_alert.q_posedge_pulse_o, %146, %u_intr_hw_edn_cmd_req_done.intr_o, %u_intr_hw_edn_fatal_err.intr_o : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<d: i1, de: i1>, edn_cmd_req_done: !hw.struct<d: i1, de: i1>>, sw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>, hw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>, recov_alert_sts: !hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>, err_code: !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>, main_sm_state: !hw.struct<d: i9, de: i1>>, !hw.array<8xstruct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>, !hw.struct<csrng_req_valid: i1, csrng_req_bus: i32, genbits_ready: i1>, i1, i1, i1, i1, i1, i1
  }
  hw.module private @edn_main_sm(in %clk_i : i1, in %rst_ni : i1, in %edn_enable_i : i1, in %boot_req_mode_i : i1, in %auto_req_mode_i : i1, in %sw_cmd_req_load_i : i1, out sw_cmd_mode_o : i1, out boot_wr_ins_cmd_o : i1, out boot_send_ins_cmd_o : i1, out boot_wr_gen_cmd_o : i1, out boot_wr_uni_cmd_o : i1, out accept_sw_cmds_pulse_o : i1, out main_sm_done_pulse_o : i1, in %csrng_cmd_ack_i : i1, out capt_gencmd_fifo_cnt_o : i1, out send_gencmd_o : i1, in %max_reqs_cnt_zero_i : i1, out capt_rescmd_fifo_cnt_o : i1, out send_rescmd_o : i1, in %cmd_sent_i : i1, out auto_req_mode_busy_o : i1, out main_sm_state_o : i9, in %csrng_ack_err_i : i1, out reject_csrng_entropy_o : i1, in %local_escalate_i : i1, out main_sm_err_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i9 = hw.constant 0 : i9
    %c-130_i9 = hw.constant -130 : i9
    %c24_i9 = hw.constant 24 : i9
    %c106_i9 = hw.constant 106 : i9
    %c-35_i9 = hw.constant -35 : i9
    %c-242_i9 = hw.constant -242 : i9
    %c191_i9 = hw.constant 191 : i9
    %c146_i9 = hw.constant 146 : i9
    %c-159_i9 = hw.constant -159 : i9
    %c-93_i9 = hw.constant -93 : i9
    %c44_i9 = hw.constant 44 : i9
    %c-203_i9 = hw.constant -203 : i9
    %c240_i9 = hw.constant 240 : i9
    %c169_i9 = hw.constant 169 : i9
    %c119_i9 = hw.constant 119 : i9
    %c3_i9 = hw.constant 3 : i9
    %c121_i9 = hw.constant 121 : i9
    %c149_i9 = hw.constant 149 : i9
    %c-68_i9 = hw.constant -68 : i9
    %true = hw.constant true
    %c-57_i9 = hw.constant -57 : i9
    %c193_i9 = hw.constant 193 : i9
    %false = hw.constant false
    %edn_enable_i_0 = llhd.sig name "edn_enable_i" %false : i1
    %boot_req_mode_i_1 = llhd.sig name "boot_req_mode_i" %false : i1
    %auto_req_mode_i_2 = llhd.sig name "auto_req_mode_i" %false : i1
    %sw_cmd_req_load_i_3 = llhd.sig name "sw_cmd_req_load_i" %false : i1
    %sw_cmd_mode_o = llhd.sig %false : i1
    %boot_wr_ins_cmd_o = llhd.sig %false : i1
    %boot_send_ins_cmd_o = llhd.sig %false : i1
    %boot_wr_gen_cmd_o = llhd.sig %false : i1
    %boot_wr_uni_cmd_o = llhd.sig %false : i1
    %accept_sw_cmds_pulse_o = llhd.sig %false : i1
    %main_sm_done_pulse_o = llhd.sig %false : i1
    %csrng_cmd_ack_i_4 = llhd.sig name "csrng_cmd_ack_i" %false : i1
    %capt_gencmd_fifo_cnt_o = llhd.sig %false : i1
    %send_gencmd_o = llhd.sig %false : i1
    %max_reqs_cnt_zero_i_5 = llhd.sig name "max_reqs_cnt_zero_i" %false : i1
    %capt_rescmd_fifo_cnt_o = llhd.sig %false : i1
    %send_rescmd_o = llhd.sig %false : i1
    %cmd_sent_i_6 = llhd.sig name "cmd_sent_i" %false : i1
    %auto_req_mode_busy_o = llhd.sig %false : i1
    %csrng_ack_err_i_7 = llhd.sig name "csrng_ack_err_i" %false : i1
    %reject_csrng_entropy_o = llhd.sig %false : i1
    %local_escalate_i_8 = llhd.sig name "local_escalate_i" %false : i1
    %main_sm_err_o = llhd.sig %false : i1
    %state_d = llhd.sig %c0_i9 : i9
    %state_q = llhd.sig %c0_i9 : i9
    %1 = llhd.prb %state_d : i9
    %u_state_regs.state_o = hw.instance "u_state_regs" @prim_sparse_fsm_flop(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, state_i: %1: i9) -> (state_o: i9)
    llhd.drv %state_q, %u_state_regs.state_o after %0 : i9
    %2 = llhd.prb %state_q : i9
    %3 = llhd.prb %boot_wr_ins_cmd_o : i1
    %4 = llhd.prb %boot_send_ins_cmd_o : i1
    %5 = llhd.prb %boot_wr_gen_cmd_o : i1
    %6 = llhd.prb %boot_wr_uni_cmd_o : i1
    %7 = llhd.prb %accept_sw_cmds_pulse_o : i1
    %8 = llhd.prb %auto_req_mode_busy_o : i1
    %9 = llhd.prb %capt_gencmd_fifo_cnt_o : i1
    %10 = llhd.prb %send_gencmd_o : i1
    %11 = llhd.prb %capt_rescmd_fifo_cnt_o : i1
    %12 = llhd.prb %send_rescmd_o : i1
    %13 = llhd.prb %main_sm_done_pulse_o : i1
    %14 = llhd.prb %main_sm_err_o : i1
    %15 = llhd.prb %reject_csrng_entropy_o : i1
    %16 = llhd.prb %sw_cmd_mode_o : i1
    %17 = llhd.prb %boot_req_mode_i_1 : i1
    %18 = llhd.prb %edn_enable_i_0 : i1
    %19 = llhd.prb %local_escalate_i_8 : i1
    %20 = llhd.prb %csrng_ack_err_i_7 : i1
    %21 = llhd.prb %auto_req_mode_i_2 : i1
    %22 = llhd.prb %csrng_cmd_ack_i_4 : i1
    %23 = llhd.prb %sw_cmd_req_load_i_3 : i1
    %24 = llhd.prb %max_reqs_cnt_zero_i_5 : i1
    %25 = llhd.prb %cmd_sent_i_6 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb64
      %26 = llhd.prb %state_q : i9
      llhd.drv %state_d, %26 after %0 : i9
      llhd.drv %boot_wr_ins_cmd_o, %false after %0 : i1
      llhd.drv %boot_send_ins_cmd_o, %false after %0 : i1
      llhd.drv %boot_wr_gen_cmd_o, %false after %0 : i1
      llhd.drv %boot_wr_uni_cmd_o, %false after %0 : i1
      llhd.drv %accept_sw_cmds_pulse_o, %false after %0 : i1
      llhd.drv %auto_req_mode_busy_o, %false after %0 : i1
      llhd.drv %capt_gencmd_fifo_cnt_o, %false after %0 : i1
      llhd.drv %send_gencmd_o, %false after %0 : i1
      llhd.drv %capt_rescmd_fifo_cnt_o, %false after %0 : i1
      llhd.drv %send_rescmd_o, %false after %0 : i1
      llhd.drv %main_sm_done_pulse_o, %false after %0 : i1
      llhd.drv %main_sm_err_o, %false after %0 : i1
      llhd.drv %reject_csrng_entropy_o, %false after %0 : i1
      llhd.drv %sw_cmd_mode_o, %false after %0 : i1
      %27 = llhd.prb %state_q : i9
      %28 = comb.icmp ceq %27, %c193_i9 : i9
      cf.cond_br %28, ^bb2, ^bb8
    ^bb2:  // pred: ^bb1
      %29 = llhd.prb %boot_req_mode_i_1 : i1
      %30 = llhd.prb %edn_enable_i_0 : i1
      %31 = comb.and %29, %30 : i1
      cf.cond_br %31, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %state_d, %c-57_i9 after %0 : i9
      cf.br ^bb60
    ^bb4:  // pred: ^bb2
      %32 = llhd.prb %auto_req_mode_i_2 : i1
      %33 = llhd.prb %edn_enable_i_0 : i1
      %34 = comb.and %32, %33 : i1
      cf.cond_br %34, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      llhd.drv %accept_sw_cmds_pulse_o, %true after %0 : i1
      llhd.drv %sw_cmd_mode_o, %true after %0 : i1
      llhd.drv %state_d, %c-68_i9 after %0 : i9
      cf.br ^bb60
    ^bb6:  // pred: ^bb4
      %35 = llhd.prb %edn_enable_i_0 : i1
      cf.cond_br %35, ^bb7, ^bb60
    ^bb7:  // pred: ^bb6
      llhd.drv %main_sm_done_pulse_o, %true after %0 : i1
      llhd.drv %accept_sw_cmds_pulse_o, %true after %0 : i1
      llhd.drv %sw_cmd_mode_o, %true after %0 : i1
      llhd.drv %state_d, %c149_i9 after %0 : i9
      cf.br ^bb60
    ^bb8:  // pred: ^bb1
      %36 = comb.icmp ceq %27, %c-57_i9 : i9
      cf.cond_br %36, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      llhd.drv %boot_wr_ins_cmd_o, %true after %0 : i1
      llhd.drv %boot_send_ins_cmd_o, %true after %0 : i1
      llhd.drv %state_d, %c121_i9 after %0 : i9
      cf.br ^bb60
    ^bb10:  // pred: ^bb8
      %37 = comb.icmp ceq %27, %c121_i9 : i9
      cf.cond_br %37, ^bb11, ^bb13
    ^bb11:  // pred: ^bb10
      llhd.drv %boot_send_ins_cmd_o, %true after %0 : i1
      %38 = llhd.prb %csrng_cmd_ack_i_4 : i1
      cf.cond_br %38, ^bb12, ^bb60
    ^bb12:  // pred: ^bb11
      llhd.drv %state_d, %c3_i9 after %0 : i9
      cf.br ^bb60
    ^bb13:  // pred: ^bb10
      %39 = comb.icmp ceq %27, %c3_i9 : i9
      cf.cond_br %39, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      llhd.drv %boot_wr_gen_cmd_o, %true after %0 : i1
      llhd.drv %state_d, %c119_i9 after %0 : i9
      cf.br ^bb60
    ^bb15:  // pred: ^bb13
      %40 = comb.icmp ceq %27, %c119_i9 : i9
      cf.cond_br %40, ^bb16, ^bb18
    ^bb16:  // pred: ^bb15
      %41 = llhd.prb %csrng_cmd_ack_i_4 : i1
      cf.cond_br %41, ^bb17, ^bb60
    ^bb17:  // pred: ^bb16
      llhd.drv %state_d, %c169_i9 after %0 : i9
      cf.br ^bb60
    ^bb18:  // pred: ^bb15
      %42 = comb.icmp ceq %27, %c169_i9 : i9
      cf.cond_br %42, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      llhd.drv %state_d, %c240_i9 after %0 : i9
      cf.br ^bb60
    ^bb20:  // pred: ^bb18
      %43 = comb.icmp ceq %27, %c240_i9 : i9
      cf.cond_br %43, ^bb21, ^bb23
    ^bb21:  // pred: ^bb20
      %44 = llhd.prb %boot_req_mode_i_1 : i1
      %45 = comb.xor %44, %true : i1
      cf.cond_br %45, ^bb22, ^bb60
    ^bb22:  // pred: ^bb21
      llhd.drv %state_d, %c-203_i9 after %0 : i9
      cf.br ^bb60
    ^bb23:  // pred: ^bb20
      %46 = comb.icmp ceq %27, %c-203_i9 : i9
      cf.cond_br %46, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      llhd.drv %boot_wr_uni_cmd_o, %true after %0 : i1
      llhd.drv %state_d, %c44_i9 after %0 : i9
      cf.br ^bb60
    ^bb25:  // pred: ^bb23
      %47 = comb.icmp ceq %27, %c44_i9 : i9
      cf.cond_br %47, ^bb26, ^bb28
    ^bb26:  // pred: ^bb25
      %48 = llhd.prb %csrng_cmd_ack_i_4 : i1
      cf.cond_br %48, ^bb27, ^bb60
    ^bb27:  // pred: ^bb26
      llhd.drv %main_sm_done_pulse_o, %true after %0 : i1
      llhd.drv %state_d, %c193_i9 after %0 : i9
      cf.br ^bb60
    ^bb28:  // pred: ^bb25
      %49 = comb.icmp ceq %27, %c-68_i9 : i9
      cf.cond_br %49, ^bb29, ^bb31
    ^bb29:  // pred: ^bb28
      llhd.drv %sw_cmd_mode_o, %true after %0 : i1
      %50 = llhd.prb %sw_cmd_req_load_i_3 : i1
      cf.cond_br %50, ^bb30, ^bb60
    ^bb30:  // pred: ^bb29
      llhd.drv %state_d, %c-93_i9 after %0 : i9
      cf.br ^bb60
    ^bb31:  // pred: ^bb28
      %51 = comb.icmp ceq %27, %c-93_i9 : i9
      cf.cond_br %51, ^bb32, ^bb34
    ^bb32:  // pred: ^bb31
      llhd.drv %sw_cmd_mode_o, %true after %0 : i1
      %52 = llhd.prb %csrng_cmd_ack_i_4 : i1
      cf.cond_br %52, ^bb33, ^bb60
    ^bb33:  // pred: ^bb32
      llhd.drv %state_d, %c-159_i9 after %0 : i9
      cf.br ^bb60
    ^bb34:  // pred: ^bb31
      %53 = comb.icmp ceq %27, %c146_i9 : i9
      cf.cond_br %53, ^bb35, ^bb37
    ^bb35:  // pred: ^bb34
      llhd.drv %auto_req_mode_busy_o, %true after %0 : i1
      %54 = llhd.prb %csrng_cmd_ack_i_4 : i1
      cf.cond_br %54, ^bb36, ^bb60
    ^bb36:  // pred: ^bb35
      llhd.drv %state_d, %c-159_i9 after %0 : i9
      cf.br ^bb60
    ^bb37:  // pred: ^bb34
      %55 = comb.icmp ceq %27, %c-159_i9 : i9
      cf.cond_br %55, ^bb38, ^bb43
    ^bb38:  // pred: ^bb37
      llhd.drv %auto_req_mode_busy_o, %true after %0 : i1
      %56 = llhd.prb %auto_req_mode_i_2 : i1
      %57 = comb.xor %56, %true : i1
      cf.cond_br %57, ^bb39, ^bb40
    ^bb39:  // pred: ^bb38
      llhd.drv %main_sm_done_pulse_o, %true after %0 : i1
      llhd.drv %state_d, %c193_i9 after %0 : i9
      cf.br ^bb60
    ^bb40:  // pred: ^bb38
      %58 = llhd.prb %max_reqs_cnt_zero_i_5 : i1
      cf.cond_br %58, ^bb41, ^bb42
    ^bb41:  // pred: ^bb40
      llhd.drv %state_d, %c191_i9 after %0 : i9
      cf.br ^bb60
    ^bb42:  // pred: ^bb40
      llhd.drv %state_d, %c-242_i9 after %0 : i9
      cf.br ^bb60
    ^bb43:  // pred: ^bb37
      %59 = comb.icmp ceq %27, %c-242_i9 : i9
      cf.cond_br %59, ^bb44, ^bb45
    ^bb44:  // pred: ^bb43
      llhd.drv %auto_req_mode_busy_o, %true after %0 : i1
      llhd.drv %capt_gencmd_fifo_cnt_o, %true after %0 : i1
      llhd.drv %state_d, %c-35_i9 after %0 : i9
      cf.br ^bb60
    ^bb45:  // pred: ^bb43
      %60 = comb.icmp ceq %27, %c-35_i9 : i9
      cf.cond_br %60, ^bb46, ^bb48
    ^bb46:  // pred: ^bb45
      llhd.drv %auto_req_mode_busy_o, %true after %0 : i1
      llhd.drv %send_gencmd_o, %true after %0 : i1
      %61 = llhd.prb %cmd_sent_i_6 : i1
      cf.cond_br %61, ^bb47, ^bb60
    ^bb47:  // pred: ^bb46
      llhd.drv %state_d, %c146_i9 after %0 : i9
      cf.br ^bb60
    ^bb48:  // pred: ^bb45
      %62 = comb.icmp ceq %27, %c191_i9 : i9
      cf.cond_br %62, ^bb49, ^bb50
    ^bb49:  // pred: ^bb48
      llhd.drv %auto_req_mode_busy_o, %true after %0 : i1
      llhd.drv %capt_rescmd_fifo_cnt_o, %true after %0 : i1
      llhd.drv %state_d, %c106_i9 after %0 : i9
      cf.br ^bb60
    ^bb50:  // pred: ^bb48
      %63 = comb.icmp ceq %27, %c106_i9 : i9
      cf.cond_br %63, ^bb51, ^bb53
    ^bb51:  // pred: ^bb50
      llhd.drv %auto_req_mode_busy_o, %true after %0 : i1
      llhd.drv %send_rescmd_o, %true after %0 : i1
      %64 = llhd.prb %cmd_sent_i_6 : i1
      cf.cond_br %64, ^bb52, ^bb60
    ^bb52:  // pred: ^bb51
      llhd.drv %state_d, %c146_i9 after %0 : i9
      cf.br ^bb60
    ^bb53:  // pred: ^bb50
      %65 = comb.icmp ceq %27, %c149_i9 : i9
      cf.cond_br %65, ^bb54, ^bb55
    ^bb54:  // pred: ^bb53
      llhd.drv %sw_cmd_mode_o, %true after %0 : i1
      cf.br ^bb60
    ^bb55:  // pred: ^bb53
      %66 = comb.icmp ceq %27, %c24_i9 : i9
      cf.cond_br %66, ^bb56, ^bb57
    ^bb56:  // pred: ^bb55
      llhd.drv %reject_csrng_entropy_o, %true after %0 : i1
      cf.br ^bb60
    ^bb57:  // pred: ^bb55
      %67 = comb.icmp ceq %27, %c-130_i9 : i9
      cf.cond_br %67, ^bb58, ^bb59
    ^bb58:  // pred: ^bb57
      llhd.drv %main_sm_err_o, %true after %0 : i1
      cf.br ^bb60
    ^bb59:  // pred: ^bb57
      llhd.drv %state_d, %c-130_i9 after %0 : i9
      llhd.drv %main_sm_err_o, %true after %0 : i1
      cf.br ^bb60
    ^bb60:  // 35 preds: ^bb3, ^bb5, ^bb6, ^bb7, ^bb9, ^bb11, ^bb12, ^bb14, ^bb16, ^bb17, ^bb19, ^bb21, ^bb22, ^bb24, ^bb26, ^bb27, ^bb29, ^bb30, ^bb32, ^bb33, ^bb35, ^bb36, ^bb39, ^bb41, ^bb42, ^bb44, ^bb46, ^bb47, ^bb49, ^bb51, ^bb52, ^bb54, ^bb56, ^bb58, ^bb59
      %68 = llhd.prb %local_escalate_i_8 : i1
      %69 = llhd.prb %csrng_ack_err_i_7 : i1
      %70 = comb.or %68, %69 : i1
      cf.cond_br %70, ^bb61, ^bb62
    ^bb61:  // pred: ^bb60
      %71 = llhd.prb %local_escalate_i_8 : i1
      %72 = llhd.prb %state_q : i9
      %73 = comb.icmp eq %72, %c-130_i9 : i9
      %74 = comb.or %71, %73 : i1
      %75 = comb.mux %74, %c-130_i9, %c24_i9 : i9
      llhd.drv %state_d, %75 after %0 : i9
      llhd.drv %boot_wr_ins_cmd_o, %false after %0 : i1
      llhd.drv %boot_wr_gen_cmd_o, %false after %0 : i1
      llhd.drv %boot_wr_uni_cmd_o, %false after %0 : i1
      llhd.drv %accept_sw_cmds_pulse_o, %false after %0 : i1
      llhd.drv %capt_gencmd_fifo_cnt_o, %false after %0 : i1
      llhd.drv %send_gencmd_o, %false after %0 : i1
      llhd.drv %capt_rescmd_fifo_cnt_o, %false after %0 : i1
      llhd.drv %send_rescmd_o, %false after %0 : i1
      llhd.drv %main_sm_done_pulse_o, %false after %0 : i1
      cf.br ^bb64
    ^bb62:  // pred: ^bb60
      %76 = llhd.prb %edn_enable_i_0 : i1
      %77 = comb.xor %76, %true : i1
      %78 = llhd.prb %state_q : i9
      %79 = comb.icmp weq %78, %c-57_i9 : i9
      %80 = comb.icmp weq %78, %c121_i9 : i9
      %81 = comb.icmp weq %78, %c3_i9 : i9
      %82 = comb.icmp weq %78, %c119_i9 : i9
      %83 = comb.icmp weq %78, %c-203_i9 : i9
      %84 = comb.icmp weq %78, %c44_i9 : i9
      %85 = comb.icmp weq %78, %c169_i9 : i9
      %86 = comb.icmp weq %78, %c240_i9 : i9
      %87 = comb.icmp weq %78, %c-68_i9 : i9
      %88 = comb.icmp weq %78, %c-93_i9 : i9
      %89 = comb.icmp weq %78, %c146_i9 : i9
      %90 = comb.icmp weq %78, %c-159_i9 : i9
      %91 = comb.icmp weq %78, %c-242_i9 : i9
      %92 = comb.icmp weq %78, %c-35_i9 : i9
      %93 = comb.icmp weq %78, %c191_i9 : i9
      %94 = comb.icmp weq %78, %c106_i9 : i9
      %95 = comb.icmp weq %78, %c149_i9 : i9
      %96 = comb.icmp weq %78, %c24_i9 : i9
      %97 = comb.or %79, %80, %81, %82, %83, %84, %85, %86, %87, %88, %89, %90, %91, %92, %93, %94, %95, %96 : i1
      %98 = comb.and %77, %97 : i1
      cf.cond_br %98, ^bb63, ^bb64
    ^bb63:  // pred: ^bb62
      llhd.drv %state_d, %c193_i9 after %0 : i9
      llhd.drv %boot_wr_ins_cmd_o, %false after %0 : i1
      llhd.drv %boot_send_ins_cmd_o, %false after %0 : i1
      llhd.drv %boot_wr_gen_cmd_o, %false after %0 : i1
      llhd.drv %boot_wr_uni_cmd_o, %false after %0 : i1
      llhd.drv %accept_sw_cmds_pulse_o, %false after %0 : i1
      llhd.drv %auto_req_mode_busy_o, %false after %0 : i1
      llhd.drv %capt_gencmd_fifo_cnt_o, %false after %0 : i1
      llhd.drv %send_gencmd_o, %false after %0 : i1
      llhd.drv %capt_rescmd_fifo_cnt_o, %false after %0 : i1
      llhd.drv %send_rescmd_o, %false after %0 : i1
      llhd.drv %sw_cmd_mode_o, %false after %0 : i1
      llhd.drv %reject_csrng_entropy_o, %false after %0 : i1
      llhd.drv %main_sm_done_pulse_o, %true after %0 : i1
      cf.br ^bb64
    ^bb64:  // 3 preds: ^bb61, ^bb62, ^bb63
      llhd.wait (%2, %1, %3, %4, %5, %6, %7, %8, %9, %10, %11, %12, %13, %14, %15, %16, %17, %18, %19, %20, %21, %22, %23, %24, %25 : i9, i9, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    llhd.drv %edn_enable_i_0, %edn_enable_i after %0 : i1
    llhd.drv %boot_req_mode_i_1, %boot_req_mode_i after %0 : i1
    llhd.drv %auto_req_mode_i_2, %auto_req_mode_i after %0 : i1
    llhd.drv %sw_cmd_req_load_i_3, %sw_cmd_req_load_i after %0 : i1
    llhd.drv %csrng_cmd_ack_i_4, %csrng_cmd_ack_i after %0 : i1
    llhd.drv %max_reqs_cnt_zero_i_5, %max_reqs_cnt_zero_i after %0 : i1
    llhd.drv %cmd_sent_i_6, %cmd_sent_i after %0 : i1
    llhd.drv %csrng_ack_err_i_7, %csrng_ack_err_i after %0 : i1
    llhd.drv %local_escalate_i_8, %local_escalate_i after %0 : i1
    hw.output %16, %3, %4, %5, %6, %7, %13, %9, %10, %11, %12, %8, %2, %15, %14 : i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i9, i1, i1
  }
  hw.module private @edn_reg_top(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out reg2hw : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>, in %hw2reg : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<d: i1, de: i1>, edn_cmd_req_done: !hw.struct<d: i1, de: i1>>, sw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>, hw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>, recov_alert_sts: !hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>, err_code: !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>, main_sm_state: !hw.struct<d: i9, de: i1>>, out intg_err_o : i1) {
    %c-2_i5 = hw.constant -2 : i5
    %c-3_i5 = hw.constant -3 : i5
    %c-4_i5 = hw.constant -4 : i5
    %c-10_i5 = hw.constant -10 : i5
    %c-11_i5 = hw.constant -11 : i5
    %c-12_i5 = hw.constant -12 : i5
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
    %c-1_i2 = hw.constant -1 : i2
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %c0_i18 = hw.constant 0 : i18
    %2 = hw.aggregate_constant [[[false], [false]], [[false], [false]], [[false, false], [false, false]], [[false, false], [false, false]], [[0 : i4], [0 : i4], [0 : i4], [0 : i4]], [0 : i32], [0 : i32], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i5, false]] : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>
    %c-1_i32 = hw.constant -1 : i32
    %c-1_i4 = hw.constant -1 : i4
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
    %c0_i9 = hw.constant 0 : i9
    %c0_i5 = hw.constant 0 : i5
    %c0_i3 = hw.constant 0 : i3
    %c0_i32 = hw.constant 0 : i32
    %c0_i4 = hw.constant 0 : i4
    %false = hw.constant false {sv.namehint = "shadow_busy"}
    %c-7_i4 = hw.constant -7 : i4
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %reg2hw = llhd.sig %2 : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>
    %reg_we = llhd.sig %false : i1
    %reg_addr = llhd.sig %c0_i7 : i7
    %reg_be = llhd.sig %c0_i4 : i4
    %wr_err = llhd.sig %false : i1
    %reg_rdata_next = llhd.sig %c0_i32 : i32
    %intg_err = llhd.sig %false : i1
    %reg_we_err = llhd.sig %false : i1
    %reg_we_check = llhd.sig %c0_i18 : i18
    %err_q = llhd.sig %false : i1
    %intr_state_we = llhd.sig %false : i1
    %intr_state_edn_cmd_req_done_qs = llhd.sig %false : i1
    %intr_state_edn_fatal_err_qs = llhd.sig %false : i1
    %intr_enable_we = llhd.sig %false : i1
    %intr_enable_edn_cmd_req_done_qs = llhd.sig %false : i1
    %intr_enable_edn_fatal_err_qs = llhd.sig %false : i1
    %intr_test_we = llhd.sig %false : i1
    %alert_test_we = llhd.sig %false : i1
    %regwen_we = llhd.sig %false : i1
    %regwen_qs = llhd.sig %false : i1
    %ctrl_edn_enable_qs = llhd.sig %c0_i4 : i4
    %ctrl_boot_req_mode_qs = llhd.sig %c0_i4 : i4
    %ctrl_auto_req_mode_qs = llhd.sig %c0_i4 : i4
    %ctrl_cmd_fifo_rst_qs = llhd.sig %c0_i4 : i4
    %boot_ins_cmd_we = llhd.sig %false : i1
    %boot_ins_cmd_qs = llhd.sig %c0_i32 : i32
    %boot_gen_cmd_we = llhd.sig %false : i1
    %boot_gen_cmd_qs = llhd.sig %c0_i32 : i32
    %sw_cmd_req_we = llhd.sig %false : i1
    %sw_cmd_sts_cmd_reg_rdy_qs = llhd.sig %false : i1
    %sw_cmd_sts_cmd_rdy_qs = llhd.sig %false : i1
    %sw_cmd_sts_cmd_ack_qs = llhd.sig %false : i1
    %sw_cmd_sts_cmd_sts_qs = llhd.sig %c0_i3 : i3
    %hw_cmd_sts_boot_mode_qs = llhd.sig %false : i1
    %hw_cmd_sts_auto_mode_qs = llhd.sig %false : i1
    %hw_cmd_sts_cmd_type_qs = llhd.sig %c0_i4 : i4
    %hw_cmd_sts_cmd_ack_qs = llhd.sig %false : i1
    %hw_cmd_sts_cmd_sts_qs = llhd.sig %c0_i3 : i3
    %reseed_cmd_we = llhd.sig %false : i1
    %generate_cmd_we = llhd.sig %false : i1
    %max_num_reqs_between_reseeds_we = llhd.sig %false : i1
    %max_num_reqs_between_reseeds_qs = llhd.sig %c0_i32 : i32
    %recov_alert_sts_we = llhd.sig %false : i1
    %recov_alert_sts_edn_enable_field_alert_qs = llhd.sig %false : i1
    %recov_alert_sts_boot_req_mode_field_alert_qs = llhd.sig %false : i1
    %recov_alert_sts_auto_req_mode_field_alert_qs = llhd.sig %false : i1
    %recov_alert_sts_cmd_fifo_rst_field_alert_qs = llhd.sig %false : i1
    %recov_alert_sts_edn_bus_cmp_alert_qs = llhd.sig %false : i1
    %recov_alert_sts_csrng_ack_err_qs = llhd.sig %false : i1
    %err_code_sfifo_rescmd_err_qs = llhd.sig %false : i1
    %err_code_sfifo_gencmd_err_qs = llhd.sig %false : i1
    %err_code_edn_ack_sm_err_qs = llhd.sig %false : i1
    %err_code_edn_main_sm_err_qs = llhd.sig %false : i1
    %err_code_edn_cntr_err_qs = llhd.sig %false : i1
    %err_code_fifo_write_err_qs = llhd.sig %false : i1
    %err_code_fifo_read_err_qs = llhd.sig %false : i1
    %err_code_fifo_state_err_qs = llhd.sig %false : i1
    %err_code_test_we = llhd.sig %false : i1
    %err_code_test_qs = llhd.sig %c0_i5 : i5
    %main_sm_state_qs = llhd.sig %c0_i9 : i9
    %intr_test_flds_we = llhd.sig %c0_i2 : i2
    %alert_test_flds_we = llhd.sig %c0_i2 : i2
    %ctrl_gated_we = llhd.sig %false : i1
    %sw_cmd_req_flds_we = llhd.sig %false : i1
    %reseed_cmd_flds_we = llhd.sig %false : i1
    %generate_cmd_flds_we = llhd.sig %false : i1
    %max_num_reqs_between_reseeds_flds_we = llhd.sig %false : i1
    %err_code_test_flds_we = llhd.sig %false : i1
    %addr_hit = llhd.sig %c0_i18 : i18
    %u_chk.err_o = hw.instance "u_chk" @tlul_cmd_intg_chk(tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> (err_o: i1)
    llhd.drv %intg_err, %u_chk.err_o after %1 : i1
    %5 = llhd.prb %reg_we_check : i18
    %6 = llhd.prb %reg_we : i1
    %7 = comb.xor %101, %true : i1
    %8 = comb.and %6, %7 : i1
    %u_prim_reg_we_check.err_o = hw.instance "u_prim_reg_we_check" @prim_reg_we_check(clk_i: %3: i1, rst_ni: %4: i1, oh_i: %5: i18, en_i: %8: i1) -> (err_o: i1)
    llhd.drv %reg_we_err, %u_prim_reg_we_check.err_o after %1 : i1
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen(tl_i: %u_reg_if.tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
    %u_reg_if.tl_o, %u_reg_if.intg_error_o, %u_reg_if.re_o, %u_reg_if.we_o, %u_reg_if.addr_o, %u_reg_if.wdata_o, %u_reg_if.be_o = hw.instance "u_reg_if" @tlul_adapter_reg(clk_i: %3: i1, rst_ni: %4: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, en_ifetch_i: %c-7_i4: i4, busy_i: %false: i1, rdata_i: %76: i32, error_i: %78: i1) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, intg_error_o: i1, re_o: i1, we_o: i1, addr_o: i7, wdata_o: i32, be_o: i4) {sv.namehint = "reg_re"}
    llhd.drv %reg_we, %u_reg_if.we_o after %1 : i1
    llhd.drv %reg_addr, %u_reg_if.addr_o after %1 : i7
    llhd.drv %reg_be, %u_reg_if.be_o after %1 : i4
    %9 = llhd.prb %intr_state_we : i1
    %intr_state = hw.struct_extract %hw2reg["intr_state"] : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<d: i1, de: i1>, edn_cmd_req_done: !hw.struct<d: i1, de: i1>>, sw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>, hw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>, recov_alert_sts: !hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>, err_code: !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>, main_sm_state: !hw.struct<d: i9, de: i1>>
    %edn_cmd_req_done = hw.struct_extract %intr_state["edn_cmd_req_done"] : !hw.struct<edn_fatal_err: !hw.struct<d: i1, de: i1>, edn_cmd_req_done: !hw.struct<d: i1, de: i1>>
    %de = hw.struct_extract %edn_cmd_req_done["de"] : !hw.struct<d: i1, de: i1>
    %d = hw.struct_extract %edn_cmd_req_done["d"] : !hw.struct<d: i1, de: i1>
    %10 = llhd.sig.struct_extract %reg2hw["intr_state"] : <!hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>>
    %11 = llhd.sig.struct_extract %10["edn_cmd_req_done"] : <!hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>>
    %12 = llhd.sig.struct_extract %11["q"] : <!hw.struct<q: i1>>
    %u_intr_state_edn_cmd_req_done.qe, %u_intr_state_edn_cmd_req_done.q, %u_intr_state_edn_cmd_req_done.ds, %u_intr_state_edn_cmd_req_done.qs = hw.instance "u_intr_state_edn_cmd_req_done" @prim_subreg(clk_i: %3: i1, rst_ni: %4: i1, we: %9: i1, wd: %106: i1, de: %de: i1, d: %d: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %12, %u_intr_state_edn_cmd_req_done.q after %1 : i1
    llhd.drv %intr_state_edn_cmd_req_done_qs, %u_intr_state_edn_cmd_req_done.qs after %1 : i1
    %edn_fatal_err = hw.struct_extract %intr_state["edn_fatal_err"] : !hw.struct<edn_fatal_err: !hw.struct<d: i1, de: i1>, edn_cmd_req_done: !hw.struct<d: i1, de: i1>>
    %de_2 = hw.struct_extract %edn_fatal_err["de"] : !hw.struct<d: i1, de: i1>
    %d_3 = hw.struct_extract %edn_fatal_err["d"] : !hw.struct<d: i1, de: i1>
    %13 = llhd.sig.struct_extract %10["edn_fatal_err"] : <!hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>>
    %14 = llhd.sig.struct_extract %13["q"] : <!hw.struct<q: i1>>
    %u_intr_state_edn_fatal_err.qe, %u_intr_state_edn_fatal_err.q, %u_intr_state_edn_fatal_err.ds, %u_intr_state_edn_fatal_err.qs = hw.instance "u_intr_state_edn_fatal_err" @prim_subreg(clk_i: %3: i1, rst_ni: %4: i1, we: %9: i1, wd: %107: i1, de: %de_2: i1, d: %d_3: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %14, %u_intr_state_edn_fatal_err.q after %1 : i1
    llhd.drv %intr_state_edn_fatal_err_qs, %u_intr_state_edn_fatal_err.qs after %1 : i1
    %15 = llhd.prb %intr_enable_we : i1
    %16 = llhd.sig.struct_extract %reg2hw["intr_enable"] : <!hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>>
    %17 = llhd.sig.struct_extract %16["edn_cmd_req_done"] : <!hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>>
    %18 = llhd.sig.struct_extract %17["q"] : <!hw.struct<q: i1>>
    %u_intr_enable_edn_cmd_req_done.qe, %u_intr_enable_edn_cmd_req_done.q, %u_intr_enable_edn_cmd_req_done.ds, %u_intr_enable_edn_cmd_req_done.qs = hw.instance "u_intr_enable_edn_cmd_req_done" @prim_subreg_1(clk_i: %3: i1, rst_ni: %4: i1, we: %15: i1, wd: %106: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %18, %u_intr_enable_edn_cmd_req_done.q after %1 : i1
    llhd.drv %intr_enable_edn_cmd_req_done_qs, %u_intr_enable_edn_cmd_req_done.qs after %1 : i1
    %19 = llhd.sig.struct_extract %16["edn_fatal_err"] : <!hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>>
    %20 = llhd.sig.struct_extract %19["q"] : <!hw.struct<q: i1>>
    %u_intr_enable_edn_fatal_err.qe, %u_intr_enable_edn_fatal_err.q, %u_intr_enable_edn_fatal_err.ds, %u_intr_enable_edn_fatal_err.qs = hw.instance "u_intr_enable_edn_fatal_err" @prim_subreg_1(clk_i: %3: i1, rst_ni: %4: i1, we: %15: i1, wd: %107: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %20, %u_intr_enable_edn_fatal_err.q after %1 : i1
    llhd.drv %intr_enable_edn_fatal_err_qs, %u_intr_enable_edn_fatal_err.qs after %1 : i1
    %21 = llhd.prb %intr_test_we : i1
    %22 = llhd.sig.extract %intr_test_flds_we from %false : <i2> -> <i1>
    %23 = llhd.sig.struct_extract %reg2hw["intr_test"] : <!hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>>
    %24 = llhd.sig.struct_extract %23["edn_cmd_req_done"] : <!hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>>
    %25 = llhd.sig.struct_extract %24["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_intr_test_edn_cmd_req_done.qe, %u_intr_test_edn_cmd_req_done.qre, %u_intr_test_edn_cmd_req_done.q, %u_intr_test_edn_cmd_req_done.ds, %u_intr_test_edn_cmd_req_done.qs = hw.instance "u_intr_test_edn_cmd_req_done" @prim_subreg_ext(re: %false: i1, we: %21: i1, wd: %106: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %22, %u_intr_test_edn_cmd_req_done.qe after %1 : i1
    llhd.drv %25, %u_intr_test_edn_cmd_req_done.q after %1 : i1
    %26 = llhd.sig.extract %intr_test_flds_we from %true : <i2> -> <i1>
    %27 = llhd.sig.struct_extract %23["edn_fatal_err"] : <!hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>>
    %28 = llhd.sig.struct_extract %27["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_intr_test_edn_fatal_err.qe, %u_intr_test_edn_fatal_err.qre, %u_intr_test_edn_fatal_err.q, %u_intr_test_edn_fatal_err.ds, %u_intr_test_edn_fatal_err.qs = hw.instance "u_intr_test_edn_fatal_err" @prim_subreg_ext(re: %false: i1, we: %21: i1, wd: %107: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %26, %u_intr_test_edn_fatal_err.qe after %1 : i1
    llhd.drv %28, %u_intr_test_edn_fatal_err.q after %1 : i1
    %29 = llhd.prb %alert_test_we : i1
    %30 = llhd.sig.extract %alert_test_flds_we from %false : <i2> -> <i1>
    %31 = llhd.sig.struct_extract %reg2hw["alert_test"] : <!hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>>
    %32 = llhd.sig.struct_extract %31["recov_alert"] : <!hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>>
    %33 = llhd.sig.struct_extract %32["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_alert_test_recov_alert.qe, %u_alert_test_recov_alert.qre, %u_alert_test_recov_alert.q, %u_alert_test_recov_alert.ds, %u_alert_test_recov_alert.qs = hw.instance "u_alert_test_recov_alert" @prim_subreg_ext(re: %false: i1, we: %29: i1, wd: %106: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %30, %u_alert_test_recov_alert.qe after %1 : i1
    llhd.drv %33, %u_alert_test_recov_alert.q after %1 : i1
    %34 = llhd.sig.extract %alert_test_flds_we from %true : <i2> -> <i1>
    %35 = llhd.sig.struct_extract %31["fatal_alert"] : <!hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>>
    %36 = llhd.sig.struct_extract %35["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_alert_test_fatal_alert.qe, %u_alert_test_fatal_alert.qre, %u_alert_test_fatal_alert.q, %u_alert_test_fatal_alert.ds, %u_alert_test_fatal_alert.qs = hw.instance "u_alert_test_fatal_alert" @prim_subreg_ext(re: %false: i1, we: %29: i1, wd: %107: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %34, %u_alert_test_fatal_alert.qe after %1 : i1
    llhd.drv %36, %u_alert_test_fatal_alert.q after %1 : i1
    %37 = llhd.prb %regwen_we : i1
    %u_regwen.qe, %u_regwen.q, %u_regwen.ds, %u_regwen.qs = hw.instance "u_regwen" @prim_subreg_2(clk_i: %3: i1, rst_ni: %4: i1, we: %37: i1, wd: %106: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %regwen_qs, %u_regwen.qs after %1 : i1
    %38 = llhd.prb %ctrl_gated_we : i1
    %39 = llhd.sig.struct_extract %reg2hw["ctrl"] : <!hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>>
    %40 = llhd.sig.struct_extract %39["edn_enable"] : <!hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>>
    %41 = llhd.sig.struct_extract %40["q"] : <!hw.struct<q: i4>>
    %u_ctrl_edn_enable.qe, %u_ctrl_edn_enable.q, %u_ctrl_edn_enable.ds, %u_ctrl_edn_enable.qs = hw.instance "u_ctrl_edn_enable" @prim_subreg_3(clk_i: %3: i1, rst_ni: %4: i1, we: %38: i1, wd: %117: i4, de: %false: i1, d: %c0_i4: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %41, %u_ctrl_edn_enable.q after %1 : i4
    llhd.drv %ctrl_edn_enable_qs, %u_ctrl_edn_enable.qs after %1 : i4
    %42 = llhd.sig.struct_extract %39["boot_req_mode"] : <!hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>>
    %43 = llhd.sig.struct_extract %42["q"] : <!hw.struct<q: i4>>
    %u_ctrl_boot_req_mode.qe, %u_ctrl_boot_req_mode.q, %u_ctrl_boot_req_mode.ds, %u_ctrl_boot_req_mode.qs = hw.instance "u_ctrl_boot_req_mode" @prim_subreg_3(clk_i: %3: i1, rst_ni: %4: i1, we: %38: i1, wd: %118: i4, de: %false: i1, d: %c0_i4: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %43, %u_ctrl_boot_req_mode.q after %1 : i4
    llhd.drv %ctrl_boot_req_mode_qs, %u_ctrl_boot_req_mode.qs after %1 : i4
    %44 = llhd.sig.struct_extract %39["auto_req_mode"] : <!hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>>
    %45 = llhd.sig.struct_extract %44["q"] : <!hw.struct<q: i4>>
    %u_ctrl_auto_req_mode.qe, %u_ctrl_auto_req_mode.q, %u_ctrl_auto_req_mode.ds, %u_ctrl_auto_req_mode.qs = hw.instance "u_ctrl_auto_req_mode" @prim_subreg_3(clk_i: %3: i1, rst_ni: %4: i1, we: %38: i1, wd: %119: i4, de: %false: i1, d: %c0_i4: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %45, %u_ctrl_auto_req_mode.q after %1 : i4
    llhd.drv %ctrl_auto_req_mode_qs, %u_ctrl_auto_req_mode.qs after %1 : i4
    %46 = llhd.sig.struct_extract %39["cmd_fifo_rst"] : <!hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>>
    %47 = llhd.sig.struct_extract %46["q"] : <!hw.struct<q: i4>>
    %u_ctrl_cmd_fifo_rst.qe, %u_ctrl_cmd_fifo_rst.q, %u_ctrl_cmd_fifo_rst.ds, %u_ctrl_cmd_fifo_rst.qs = hw.instance "u_ctrl_cmd_fifo_rst" @prim_subreg_3(clk_i: %3: i1, rst_ni: %4: i1, we: %38: i1, wd: %120: i4, de: %false: i1, d: %c0_i4: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %47, %u_ctrl_cmd_fifo_rst.q after %1 : i4
    llhd.drv %ctrl_cmd_fifo_rst_qs, %u_ctrl_cmd_fifo_rst.qs after %1 : i4
    %48 = llhd.prb %boot_ins_cmd_we : i1
    %49 = llhd.sig.struct_extract %reg2hw["boot_ins_cmd"] : <!hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>>
    %50 = llhd.sig.struct_extract %49["q"] : <!hw.struct<q: i32>>
    %u_boot_ins_cmd.qe, %u_boot_ins_cmd.q, %u_boot_ins_cmd.ds, %u_boot_ins_cmd.qs = hw.instance "u_boot_ins_cmd" @prim_subreg_4(clk_i: %3: i1, rst_ni: %4: i1, we: %48: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %50, %u_boot_ins_cmd.q after %1 : i32
    llhd.drv %boot_ins_cmd_qs, %u_boot_ins_cmd.qs after %1 : i32
    %51 = llhd.prb %boot_gen_cmd_we : i1
    %52 = llhd.sig.struct_extract %reg2hw["boot_gen_cmd"] : <!hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>>
    %53 = llhd.sig.struct_extract %52["q"] : <!hw.struct<q: i32>>
    %u_boot_gen_cmd.qe, %u_boot_gen_cmd.q, %u_boot_gen_cmd.ds, %u_boot_gen_cmd.qs = hw.instance "u_boot_gen_cmd" @prim_subreg_5(clk_i: %3: i1, rst_ni: %4: i1, we: %51: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %53, %u_boot_gen_cmd.q after %1 : i32
    llhd.drv %boot_gen_cmd_qs, %u_boot_gen_cmd.qs after %1 : i32
    %54 = llhd.prb %sw_cmd_req_we : i1
    %55 = llhd.sig.struct_extract %reg2hw["sw_cmd_req"] : <!hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>>
    %56 = llhd.sig.struct_extract %55["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_sw_cmd_req.qe, %u_sw_cmd_req.qre, %u_sw_cmd_req.q, %u_sw_cmd_req.ds, %u_sw_cmd_req.qs = hw.instance "u_sw_cmd_req" @prim_subreg_ext_6(re: %false: i1, we: %54: i1, wd: %u_reg_if.wdata_o: i32, d: %c0_i32: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %sw_cmd_req_flds_we, %u_sw_cmd_req.qe after %1 : i1
    llhd.drv %56, %u_sw_cmd_req.q after %1 : i32
    %sw_cmd_sts = hw.struct_extract %hw2reg["sw_cmd_sts"] : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<d: i1, de: i1>, edn_cmd_req_done: !hw.struct<d: i1, de: i1>>, sw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>, hw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>, recov_alert_sts: !hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>, err_code: !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>, main_sm_state: !hw.struct<d: i9, de: i1>>
    %cmd_reg_rdy = hw.struct_extract %sw_cmd_sts["cmd_reg_rdy"] : !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>
    %de_4 = hw.struct_extract %cmd_reg_rdy["de"] : !hw.struct<d: i1, de: i1>
    %d_5 = hw.struct_extract %cmd_reg_rdy["d"] : !hw.struct<d: i1, de: i1>
    %u_sw_cmd_sts_cmd_reg_rdy.qe, %u_sw_cmd_sts_cmd_reg_rdy.q, %u_sw_cmd_sts_cmd_reg_rdy.ds, %u_sw_cmd_sts_cmd_reg_rdy.qs = hw.instance "u_sw_cmd_sts_cmd_reg_rdy" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_4: i1, d: %d_5: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %sw_cmd_sts_cmd_reg_rdy_qs, %u_sw_cmd_sts_cmd_reg_rdy.qs after %1 : i1
    %cmd_rdy = hw.struct_extract %sw_cmd_sts["cmd_rdy"] : !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>
    %de_6 = hw.struct_extract %cmd_rdy["de"] : !hw.struct<d: i1, de: i1>
    %d_7 = hw.struct_extract %cmd_rdy["d"] : !hw.struct<d: i1, de: i1>
    %u_sw_cmd_sts_cmd_rdy.qe, %u_sw_cmd_sts_cmd_rdy.q, %u_sw_cmd_sts_cmd_rdy.ds, %u_sw_cmd_sts_cmd_rdy.qs = hw.instance "u_sw_cmd_sts_cmd_rdy" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_6: i1, d: %d_7: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %sw_cmd_sts_cmd_rdy_qs, %u_sw_cmd_sts_cmd_rdy.qs after %1 : i1
    %cmd_ack = hw.struct_extract %sw_cmd_sts["cmd_ack"] : !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>
    %de_8 = hw.struct_extract %cmd_ack["de"] : !hw.struct<d: i1, de: i1>
    %d_9 = hw.struct_extract %cmd_ack["d"] : !hw.struct<d: i1, de: i1>
    %u_sw_cmd_sts_cmd_ack.qe, %u_sw_cmd_sts_cmd_ack.q, %u_sw_cmd_sts_cmd_ack.ds, %u_sw_cmd_sts_cmd_ack.qs = hw.instance "u_sw_cmd_sts_cmd_ack" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_8: i1, d: %d_9: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %sw_cmd_sts_cmd_ack_qs, %u_sw_cmd_sts_cmd_ack.qs after %1 : i1
    %cmd_sts = hw.struct_extract %sw_cmd_sts["cmd_sts"] : !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>
    %de_10 = hw.struct_extract %cmd_sts["de"] : !hw.struct<d: i3, de: i1>
    %d_11 = hw.struct_extract %cmd_sts["d"] : !hw.struct<d: i3, de: i1>
    %u_sw_cmd_sts_cmd_sts.qe, %u_sw_cmd_sts_cmd_sts.q, %u_sw_cmd_sts_cmd_sts.ds, %u_sw_cmd_sts_cmd_sts.qs = hw.instance "u_sw_cmd_sts_cmd_sts" @prim_subreg_8(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %c0_i3: i3, de: %de_10: i1, d: %d_11: i3) -> (qe: i1, q: i3, ds: i3, qs: i3)
    llhd.drv %sw_cmd_sts_cmd_sts_qs, %u_sw_cmd_sts_cmd_sts.qs after %1 : i3
    %hw_cmd_sts = hw.struct_extract %hw2reg["hw_cmd_sts"] : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<d: i1, de: i1>, edn_cmd_req_done: !hw.struct<d: i1, de: i1>>, sw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>, hw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>, recov_alert_sts: !hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>, err_code: !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>, main_sm_state: !hw.struct<d: i9, de: i1>>
    %boot_mode = hw.struct_extract %hw_cmd_sts["boot_mode"] : !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>
    %de_12 = hw.struct_extract %boot_mode["de"] : !hw.struct<d: i1, de: i1>
    %d_13 = hw.struct_extract %boot_mode["d"] : !hw.struct<d: i1, de: i1>
    %u_hw_cmd_sts_boot_mode.qe, %u_hw_cmd_sts_boot_mode.q, %u_hw_cmd_sts_boot_mode.ds, %u_hw_cmd_sts_boot_mode.qs = hw.instance "u_hw_cmd_sts_boot_mode" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_12: i1, d: %d_13: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %hw_cmd_sts_boot_mode_qs, %u_hw_cmd_sts_boot_mode.qs after %1 : i1
    %auto_mode = hw.struct_extract %hw_cmd_sts["auto_mode"] : !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>
    %de_14 = hw.struct_extract %auto_mode["de"] : !hw.struct<d: i1, de: i1>
    %d_15 = hw.struct_extract %auto_mode["d"] : !hw.struct<d: i1, de: i1>
    %u_hw_cmd_sts_auto_mode.qe, %u_hw_cmd_sts_auto_mode.q, %u_hw_cmd_sts_auto_mode.ds, %u_hw_cmd_sts_auto_mode.qs = hw.instance "u_hw_cmd_sts_auto_mode" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_14: i1, d: %d_15: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %hw_cmd_sts_auto_mode_qs, %u_hw_cmd_sts_auto_mode.qs after %1 : i1
    %cmd_type = hw.struct_extract %hw_cmd_sts["cmd_type"] : !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>
    %de_16 = hw.struct_extract %cmd_type["de"] : !hw.struct<d: i4, de: i1>
    %d_17 = hw.struct_extract %cmd_type["d"] : !hw.struct<d: i4, de: i1>
    %u_hw_cmd_sts_cmd_type.qe, %u_hw_cmd_sts_cmd_type.q, %u_hw_cmd_sts_cmd_type.ds, %u_hw_cmd_sts_cmd_type.qs = hw.instance "u_hw_cmd_sts_cmd_type" @prim_subreg_9(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %c0_i4: i4, de: %de_16: i1, d: %d_17: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %hw_cmd_sts_cmd_type_qs, %u_hw_cmd_sts_cmd_type.qs after %1 : i4
    %cmd_ack_18 = hw.struct_extract %hw_cmd_sts["cmd_ack"] : !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>
    %de_19 = hw.struct_extract %cmd_ack_18["de"] : !hw.struct<d: i1, de: i1>
    %d_20 = hw.struct_extract %cmd_ack_18["d"] : !hw.struct<d: i1, de: i1>
    %u_hw_cmd_sts_cmd_ack.qe, %u_hw_cmd_sts_cmd_ack.q, %u_hw_cmd_sts_cmd_ack.ds, %u_hw_cmd_sts_cmd_ack.qs = hw.instance "u_hw_cmd_sts_cmd_ack" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_19: i1, d: %d_20: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %hw_cmd_sts_cmd_ack_qs, %u_hw_cmd_sts_cmd_ack.qs after %1 : i1
    %cmd_sts_21 = hw.struct_extract %hw_cmd_sts["cmd_sts"] : !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>
    %de_22 = hw.struct_extract %cmd_sts_21["de"] : !hw.struct<d: i3, de: i1>
    %d_23 = hw.struct_extract %cmd_sts_21["d"] : !hw.struct<d: i3, de: i1>
    %u_hw_cmd_sts_cmd_sts.qe, %u_hw_cmd_sts_cmd_sts.q, %u_hw_cmd_sts_cmd_sts.ds, %u_hw_cmd_sts_cmd_sts.qs = hw.instance "u_hw_cmd_sts_cmd_sts" @prim_subreg_8(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %c0_i3: i3, de: %de_22: i1, d: %d_23: i3) -> (qe: i1, q: i3, ds: i3, qs: i3)
    llhd.drv %hw_cmd_sts_cmd_sts_qs, %u_hw_cmd_sts_cmd_sts.qs after %1 : i3
    %57 = llhd.prb %reseed_cmd_we : i1
    %58 = llhd.sig.struct_extract %reg2hw["reseed_cmd"] : <!hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>>
    %59 = llhd.sig.struct_extract %58["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_reseed_cmd.qe, %u_reseed_cmd.qre, %u_reseed_cmd.q, %u_reseed_cmd.ds, %u_reseed_cmd.qs = hw.instance "u_reseed_cmd" @prim_subreg_ext_6(re: %false: i1, we: %57: i1, wd: %u_reg_if.wdata_o: i32, d: %c0_i32: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %reseed_cmd_flds_we, %u_reseed_cmd.qe after %1 : i1
    llhd.drv %59, %u_reseed_cmd.q after %1 : i32
    %60 = llhd.prb %generate_cmd_we : i1
    %61 = llhd.sig.struct_extract %reg2hw["generate_cmd"] : <!hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>>
    %62 = llhd.sig.struct_extract %61["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_generate_cmd.qe, %u_generate_cmd.qre, %u_generate_cmd.q, %u_generate_cmd.ds, %u_generate_cmd.qs = hw.instance "u_generate_cmd" @prim_subreg_ext_6(re: %false: i1, we: %60: i1, wd: %u_reg_if.wdata_o: i32, d: %c0_i32: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %generate_cmd_flds_we, %u_generate_cmd.qe after %1 : i1
    llhd.drv %62, %u_generate_cmd.q after %1 : i32
    %63 = llhd.prb %max_num_reqs_between_reseeds_flds_we : i1
    %u_max_num_reqs_between_reseeds0_qe.q_o = hw.instance "u_max_num_reqs_between_reseeds0_qe" @prim_flop(clk_i: %3: i1, rst_ni: %4: i1, d_i: %63: i1) -> (q_o: i1) {sv.namehint = "max_num_reqs_between_reseeds_qe"}
    %64 = llhd.prb %max_num_reqs_between_reseeds_we : i1
    %65 = llhd.sig.struct_extract %reg2hw["max_num_reqs_between_reseeds"] : <!hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>>
    %66 = llhd.sig.struct_extract %65["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_max_num_reqs_between_reseeds.qe, %u_max_num_reqs_between_reseeds.q, %u_max_num_reqs_between_reseeds.ds, %u_max_num_reqs_between_reseeds.qs = hw.instance "u_max_num_reqs_between_reseeds" @prim_subreg_10(clk_i: %3: i1, rst_ni: %4: i1, we: %64: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %max_num_reqs_between_reseeds_flds_we, %u_max_num_reqs_between_reseeds.qe after %1 : i1
    llhd.drv %66, %u_max_num_reqs_between_reseeds.q after %1 : i32
    llhd.drv %max_num_reqs_between_reseeds_qs, %u_max_num_reqs_between_reseeds.qs after %1 : i32
    %67 = llhd.prb %recov_alert_sts_we : i1
    %recov_alert_sts = hw.struct_extract %hw2reg["recov_alert_sts"] : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<d: i1, de: i1>, edn_cmd_req_done: !hw.struct<d: i1, de: i1>>, sw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>, hw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>, recov_alert_sts: !hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>, err_code: !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>, main_sm_state: !hw.struct<d: i9, de: i1>>
    %edn_enable_field_alert = hw.struct_extract %recov_alert_sts["edn_enable_field_alert"] : !hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>
    %de_24 = hw.struct_extract %edn_enable_field_alert["de"] : !hw.struct<d: i1, de: i1>
    %d_25 = hw.struct_extract %edn_enable_field_alert["d"] : !hw.struct<d: i1, de: i1>
    %u_recov_alert_sts_edn_enable_field_alert.qe, %u_recov_alert_sts_edn_enable_field_alert.q, %u_recov_alert_sts_edn_enable_field_alert.ds, %u_recov_alert_sts_edn_enable_field_alert.qs = hw.instance "u_recov_alert_sts_edn_enable_field_alert" @prim_subreg_11(clk_i: %3: i1, rst_ni: %4: i1, we: %67: i1, wd: %106: i1, de: %de_24: i1, d: %d_25: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %recov_alert_sts_edn_enable_field_alert_qs, %u_recov_alert_sts_edn_enable_field_alert.qs after %1 : i1
    %boot_req_mode_field_alert = hw.struct_extract %recov_alert_sts["boot_req_mode_field_alert"] : !hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>
    %de_26 = hw.struct_extract %boot_req_mode_field_alert["de"] : !hw.struct<d: i1, de: i1>
    %d_27 = hw.struct_extract %boot_req_mode_field_alert["d"] : !hw.struct<d: i1, de: i1>
    %u_recov_alert_sts_boot_req_mode_field_alert.qe, %u_recov_alert_sts_boot_req_mode_field_alert.q, %u_recov_alert_sts_boot_req_mode_field_alert.ds, %u_recov_alert_sts_boot_req_mode_field_alert.qs = hw.instance "u_recov_alert_sts_boot_req_mode_field_alert" @prim_subreg_11(clk_i: %3: i1, rst_ni: %4: i1, we: %67: i1, wd: %107: i1, de: %de_26: i1, d: %d_27: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %recov_alert_sts_boot_req_mode_field_alert_qs, %u_recov_alert_sts_boot_req_mode_field_alert.qs after %1 : i1
    %auto_req_mode_field_alert = hw.struct_extract %recov_alert_sts["auto_req_mode_field_alert"] : !hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>
    %de_28 = hw.struct_extract %auto_req_mode_field_alert["de"] : !hw.struct<d: i1, de: i1>
    %d_29 = hw.struct_extract %auto_req_mode_field_alert["d"] : !hw.struct<d: i1, de: i1>
    %u_recov_alert_sts_auto_req_mode_field_alert.qe, %u_recov_alert_sts_auto_req_mode_field_alert.q, %u_recov_alert_sts_auto_req_mode_field_alert.ds, %u_recov_alert_sts_auto_req_mode_field_alert.qs = hw.instance "u_recov_alert_sts_auto_req_mode_field_alert" @prim_subreg_11(clk_i: %3: i1, rst_ni: %4: i1, we: %67: i1, wd: %135: i1, de: %de_28: i1, d: %d_29: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %recov_alert_sts_auto_req_mode_field_alert_qs, %u_recov_alert_sts_auto_req_mode_field_alert.qs after %1 : i1
    %cmd_fifo_rst_field_alert = hw.struct_extract %recov_alert_sts["cmd_fifo_rst_field_alert"] : !hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>
    %de_30 = hw.struct_extract %cmd_fifo_rst_field_alert["de"] : !hw.struct<d: i1, de: i1>
    %d_31 = hw.struct_extract %cmd_fifo_rst_field_alert["d"] : !hw.struct<d: i1, de: i1>
    %u_recov_alert_sts_cmd_fifo_rst_field_alert.qe, %u_recov_alert_sts_cmd_fifo_rst_field_alert.q, %u_recov_alert_sts_cmd_fifo_rst_field_alert.ds, %u_recov_alert_sts_cmd_fifo_rst_field_alert.qs = hw.instance "u_recov_alert_sts_cmd_fifo_rst_field_alert" @prim_subreg_11(clk_i: %3: i1, rst_ni: %4: i1, we: %67: i1, wd: %136: i1, de: %de_30: i1, d: %d_31: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %recov_alert_sts_cmd_fifo_rst_field_alert_qs, %u_recov_alert_sts_cmd_fifo_rst_field_alert.qs after %1 : i1
    %edn_bus_cmp_alert = hw.struct_extract %recov_alert_sts["edn_bus_cmp_alert"] : !hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>
    %de_32 = hw.struct_extract %edn_bus_cmp_alert["de"] : !hw.struct<d: i1, de: i1>
    %d_33 = hw.struct_extract %edn_bus_cmp_alert["d"] : !hw.struct<d: i1, de: i1>
    %u_recov_alert_sts_edn_bus_cmp_alert.qe, %u_recov_alert_sts_edn_bus_cmp_alert.q, %u_recov_alert_sts_edn_bus_cmp_alert.ds, %u_recov_alert_sts_edn_bus_cmp_alert.qs = hw.instance "u_recov_alert_sts_edn_bus_cmp_alert" @prim_subreg_11(clk_i: %3: i1, rst_ni: %4: i1, we: %67: i1, wd: %137: i1, de: %de_32: i1, d: %d_33: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %recov_alert_sts_edn_bus_cmp_alert_qs, %u_recov_alert_sts_edn_bus_cmp_alert.qs after %1 : i1
    %csrng_ack_err = hw.struct_extract %recov_alert_sts["csrng_ack_err"] : !hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>
    %de_34 = hw.struct_extract %csrng_ack_err["de"] : !hw.struct<d: i1, de: i1>
    %d_35 = hw.struct_extract %csrng_ack_err["d"] : !hw.struct<d: i1, de: i1>
    %u_recov_alert_sts_csrng_ack_err.qe, %u_recov_alert_sts_csrng_ack_err.q, %u_recov_alert_sts_csrng_ack_err.ds, %u_recov_alert_sts_csrng_ack_err.qs = hw.instance "u_recov_alert_sts_csrng_ack_err" @prim_subreg_11(clk_i: %3: i1, rst_ni: %4: i1, we: %67: i1, wd: %138: i1, de: %de_34: i1, d: %d_35: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %recov_alert_sts_csrng_ack_err_qs, %u_recov_alert_sts_csrng_ack_err.qs after %1 : i1
    %err_code = hw.struct_extract %hw2reg["err_code"] : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<d: i1, de: i1>, edn_cmd_req_done: !hw.struct<d: i1, de: i1>>, sw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>, hw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>, recov_alert_sts: !hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>, err_code: !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>, main_sm_state: !hw.struct<d: i9, de: i1>>
    %sfifo_rescmd_err = hw.struct_extract %err_code["sfifo_rescmd_err"] : !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>
    %de_36 = hw.struct_extract %sfifo_rescmd_err["de"] : !hw.struct<d: i1, de: i1>
    %d_37 = hw.struct_extract %sfifo_rescmd_err["d"] : !hw.struct<d: i1, de: i1>
    %u_err_code_sfifo_rescmd_err.qe, %u_err_code_sfifo_rescmd_err.q, %u_err_code_sfifo_rescmd_err.ds, %u_err_code_sfifo_rescmd_err.qs = hw.instance "u_err_code_sfifo_rescmd_err" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_36: i1, d: %d_37: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %err_code_sfifo_rescmd_err_qs, %u_err_code_sfifo_rescmd_err.qs after %1 : i1
    %sfifo_gencmd_err = hw.struct_extract %err_code["sfifo_gencmd_err"] : !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>
    %de_38 = hw.struct_extract %sfifo_gencmd_err["de"] : !hw.struct<d: i1, de: i1>
    %d_39 = hw.struct_extract %sfifo_gencmd_err["d"] : !hw.struct<d: i1, de: i1>
    %u_err_code_sfifo_gencmd_err.qe, %u_err_code_sfifo_gencmd_err.q, %u_err_code_sfifo_gencmd_err.ds, %u_err_code_sfifo_gencmd_err.qs = hw.instance "u_err_code_sfifo_gencmd_err" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_38: i1, d: %d_39: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %err_code_sfifo_gencmd_err_qs, %u_err_code_sfifo_gencmd_err.qs after %1 : i1
    %edn_ack_sm_err = hw.struct_extract %err_code["edn_ack_sm_err"] : !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>
    %de_40 = hw.struct_extract %edn_ack_sm_err["de"] : !hw.struct<d: i1, de: i1>
    %d_41 = hw.struct_extract %edn_ack_sm_err["d"] : !hw.struct<d: i1, de: i1>
    %u_err_code_edn_ack_sm_err.qe, %u_err_code_edn_ack_sm_err.q, %u_err_code_edn_ack_sm_err.ds, %u_err_code_edn_ack_sm_err.qs = hw.instance "u_err_code_edn_ack_sm_err" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_40: i1, d: %d_41: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %err_code_edn_ack_sm_err_qs, %u_err_code_edn_ack_sm_err.qs after %1 : i1
    %edn_main_sm_err = hw.struct_extract %err_code["edn_main_sm_err"] : !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>
    %de_42 = hw.struct_extract %edn_main_sm_err["de"] : !hw.struct<d: i1, de: i1>
    %d_43 = hw.struct_extract %edn_main_sm_err["d"] : !hw.struct<d: i1, de: i1>
    %u_err_code_edn_main_sm_err.qe, %u_err_code_edn_main_sm_err.q, %u_err_code_edn_main_sm_err.ds, %u_err_code_edn_main_sm_err.qs = hw.instance "u_err_code_edn_main_sm_err" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_42: i1, d: %d_43: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %err_code_edn_main_sm_err_qs, %u_err_code_edn_main_sm_err.qs after %1 : i1
    %edn_cntr_err = hw.struct_extract %err_code["edn_cntr_err"] : !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>
    %de_44 = hw.struct_extract %edn_cntr_err["de"] : !hw.struct<d: i1, de: i1>
    %d_45 = hw.struct_extract %edn_cntr_err["d"] : !hw.struct<d: i1, de: i1>
    %u_err_code_edn_cntr_err.qe, %u_err_code_edn_cntr_err.q, %u_err_code_edn_cntr_err.ds, %u_err_code_edn_cntr_err.qs = hw.instance "u_err_code_edn_cntr_err" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_44: i1, d: %d_45: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %err_code_edn_cntr_err_qs, %u_err_code_edn_cntr_err.qs after %1 : i1
    %fifo_write_err = hw.struct_extract %err_code["fifo_write_err"] : !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>
    %de_46 = hw.struct_extract %fifo_write_err["de"] : !hw.struct<d: i1, de: i1>
    %d_47 = hw.struct_extract %fifo_write_err["d"] : !hw.struct<d: i1, de: i1>
    %u_err_code_fifo_write_err.qe, %u_err_code_fifo_write_err.q, %u_err_code_fifo_write_err.ds, %u_err_code_fifo_write_err.qs = hw.instance "u_err_code_fifo_write_err" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_46: i1, d: %d_47: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %err_code_fifo_write_err_qs, %u_err_code_fifo_write_err.qs after %1 : i1
    %fifo_read_err = hw.struct_extract %err_code["fifo_read_err"] : !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>
    %de_48 = hw.struct_extract %fifo_read_err["de"] : !hw.struct<d: i1, de: i1>
    %d_49 = hw.struct_extract %fifo_read_err["d"] : !hw.struct<d: i1, de: i1>
    %u_err_code_fifo_read_err.qe, %u_err_code_fifo_read_err.q, %u_err_code_fifo_read_err.ds, %u_err_code_fifo_read_err.qs = hw.instance "u_err_code_fifo_read_err" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_48: i1, d: %d_49: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %err_code_fifo_read_err_qs, %u_err_code_fifo_read_err.qs after %1 : i1
    %fifo_state_err = hw.struct_extract %err_code["fifo_state_err"] : !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>
    %de_50 = hw.struct_extract %fifo_state_err["de"] : !hw.struct<d: i1, de: i1>
    %d_51 = hw.struct_extract %fifo_state_err["d"] : !hw.struct<d: i1, de: i1>
    %u_err_code_fifo_state_err.qe, %u_err_code_fifo_state_err.q, %u_err_code_fifo_state_err.ds, %u_err_code_fifo_state_err.qs = hw.instance "u_err_code_fifo_state_err" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_50: i1, d: %d_51: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %err_code_fifo_state_err_qs, %u_err_code_fifo_state_err.qs after %1 : i1
    %68 = llhd.prb %err_code_test_flds_we : i1
    %u_err_code_test0_qe.q_o = hw.instance "u_err_code_test0_qe" @prim_flop(clk_i: %3: i1, rst_ni: %4: i1, d_i: %68: i1) -> (q_o: i1) {sv.namehint = "err_code_test_qe"}
    %69 = llhd.prb %err_code_test_we : i1
    %70 = llhd.sig.struct_extract %reg2hw["err_code_test"] : <!hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>>
    %71 = llhd.sig.struct_extract %70["q"] : <!hw.struct<q: i5, qe: i1>>
    %u_err_code_test.qe, %u_err_code_test.q, %u_err_code_test.ds, %u_err_code_test.qs = hw.instance "u_err_code_test" @prim_subreg_12(clk_i: %3: i1, rst_ni: %4: i1, we: %69: i1, wd: %141: i5, de: %false: i1, d: %c0_i5: i5) -> (qe: i1, q: i5, ds: i5, qs: i5)
    llhd.drv %err_code_test_flds_we, %u_err_code_test.qe after %1 : i1
    llhd.drv %71, %u_err_code_test.q after %1 : i5
    llhd.drv %err_code_test_qs, %u_err_code_test.qs after %1 : i5
    %main_sm_state = hw.struct_extract %hw2reg["main_sm_state"] : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<d: i1, de: i1>, edn_cmd_req_done: !hw.struct<d: i1, de: i1>>, sw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>, hw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>, recov_alert_sts: !hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>, err_code: !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>, main_sm_state: !hw.struct<d: i9, de: i1>>
    %de_52 = hw.struct_extract %main_sm_state["de"] : !hw.struct<d: i9, de: i1>
    %d_53 = hw.struct_extract %main_sm_state["d"] : !hw.struct<d: i9, de: i1>
    %u_main_sm_state.qe, %u_main_sm_state.q, %u_main_sm_state.ds, %u_main_sm_state.qs = hw.instance "u_main_sm_state" @prim_subreg_13(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %c0_i9: i9, de: %de_52: i1, d: %d_53: i9) -> (qe: i1, q: i9, ds: i9, qs: i9)
    llhd.drv %main_sm_state_qs, %u_main_sm_state.qs after %1 : i9
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %179 = llhd.prb %clk_i_0 : i1
      %180 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %181 = llhd.prb %clk_i_0 : i1
      %182 = comb.xor bin %179, %true : i1
      %183 = comb.and bin %182, %181 : i1
      %184 = llhd.prb %rst_ni_1 : i1
      %185 = comb.xor bin %184, %true : i1
      %186 = comb.and bin %180, %185 : i1
      %187 = comb.or bin %183, %186 : i1
      cf.cond_br %187, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %188 = llhd.prb %rst_ni_1 : i1
      %189 = comb.xor %188, %true : i1
      cf.cond_br %189, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %err_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %190 = llhd.prb %intg_err : i1
      %191 = llhd.prb %reg_we_err : i1
      %192 = comb.or %190, %191 : i1
      cf.cond_br %192, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %err_q, %true after %0 : i1
      cf.br ^bb1
    }
    %72 = llhd.prb %err_q : i1
    %73 = llhd.prb %intg_err : i1
    %74 = llhd.prb %reg_we_err : i1
    %75 = comb.or %72, %73, %74 : i1
    %76 = llhd.prb %reg_rdata_next {sv.namehint = "reg_rdata"} : i32
    %77 = llhd.prb %wr_err : i1
    %78 = comb.or %101, %77, %73 {sv.namehint = "reg_error"} : i1
    %79 = llhd.prb %intr_test_flds_we : i2
    %80 = comb.icmp eq %79, %c-1_i2 {sv.namehint = "intr_test_qe"} : i2
    %81 = llhd.sig.struct_extract %24["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %81, %80 after %1 : i1
    %82 = llhd.sig.struct_extract %27["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %82, %80 after %1 : i1
    %83 = llhd.prb %alert_test_flds_we : i2
    %84 = comb.icmp eq %83, %c-1_i2 {sv.namehint = "alert_test_qe"} : i2
    %85 = llhd.sig.struct_extract %32["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %85, %84 after %1 : i1
    %86 = llhd.sig.struct_extract %35["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %86, %84 after %1 : i1
    %87 = llhd.prb %regwen_qs : i1
    %88 = comb.and %116, %6, %104, %87 : i1
    llhd.drv %ctrl_gated_we, %88 after %1 : i1
    %89 = llhd.prb %sw_cmd_req_flds_we {sv.namehint = "sw_cmd_req_qe"} : i1
    %90 = llhd.sig.struct_extract %55["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %90, %89 after %1 : i1
    %91 = llhd.prb %reseed_cmd_flds_we {sv.namehint = "reseed_cmd_qe"} : i1
    %92 = llhd.sig.struct_extract %58["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %92, %91 after %1 : i1
    %93 = llhd.prb %generate_cmd_flds_we {sv.namehint = "generate_cmd_qe"} : i1
    %94 = llhd.sig.struct_extract %61["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %94, %93 after %1 : i1
    %95 = llhd.sig.struct_extract %65["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %95, %u_max_num_reqs_between_reseeds0_qe.q_o after %1 : i1
    %96 = llhd.sig.struct_extract %70["qe"] : <!hw.struct<q: i5, qe: i1>>
    llhd.drv %96, %u_err_code_test0_qe.q_o after %1 : i1
    %97 = llhd.prb %addr_hit : i18
    %98 = llhd.prb %reg_addr : i7
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %179 = llhd.sig.extract %addr_hit from %c0_i5 : <i18> -> <i1>
      %180 = llhd.prb %reg_addr : i7
      %181 = comb.icmp eq %180, %c0_i7 : i7
      llhd.drv %179, %181 after %1 : i1
      %182 = llhd.sig.extract %addr_hit from %c1_i5 : <i18> -> <i1>
      %183 = llhd.prb %reg_addr : i7
      %184 = comb.icmp eq %183, %c4_i7 : i7
      llhd.drv %182, %184 after %1 : i1
      %185 = llhd.sig.extract %addr_hit from %c2_i5 : <i18> -> <i1>
      %186 = llhd.prb %reg_addr : i7
      %187 = comb.icmp eq %186, %c8_i7 : i7
      llhd.drv %185, %187 after %1 : i1
      %188 = llhd.sig.extract %addr_hit from %c3_i5 : <i18> -> <i1>
      %189 = llhd.prb %reg_addr : i7
      %190 = comb.icmp eq %189, %c12_i7 : i7
      llhd.drv %188, %190 after %1 : i1
      %191 = llhd.sig.extract %addr_hit from %c4_i5 : <i18> -> <i1>
      %192 = llhd.prb %reg_addr : i7
      %193 = comb.icmp eq %192, %c16_i7 : i7
      llhd.drv %191, %193 after %1 : i1
      %194 = llhd.sig.extract %addr_hit from %c5_i5 : <i18> -> <i1>
      %195 = llhd.prb %reg_addr : i7
      %196 = comb.icmp eq %195, %c20_i7 : i7
      llhd.drv %194, %196 after %1 : i1
      %197 = llhd.sig.extract %addr_hit from %c6_i5 : <i18> -> <i1>
      %198 = llhd.prb %reg_addr : i7
      %199 = comb.icmp eq %198, %c24_i7 : i7
      llhd.drv %197, %199 after %1 : i1
      %200 = llhd.sig.extract %addr_hit from %c7_i5 : <i18> -> <i1>
      %201 = llhd.prb %reg_addr : i7
      %202 = comb.icmp eq %201, %c28_i7 : i7
      llhd.drv %200, %202 after %1 : i1
      %203 = llhd.sig.extract %addr_hit from %c8_i5 : <i18> -> <i1>
      %204 = llhd.prb %reg_addr : i7
      %205 = comb.icmp eq %204, %c32_i7 : i7
      llhd.drv %203, %205 after %1 : i1
      %206 = llhd.sig.extract %addr_hit from %c9_i5 : <i18> -> <i1>
      %207 = llhd.prb %reg_addr : i7
      %208 = comb.icmp eq %207, %c36_i7 : i7
      llhd.drv %206, %208 after %1 : i1
      %209 = llhd.sig.extract %addr_hit from %c10_i5 : <i18> -> <i1>
      %210 = llhd.prb %reg_addr : i7
      %211 = comb.icmp eq %210, %c40_i7 : i7
      llhd.drv %209, %211 after %1 : i1
      %212 = llhd.sig.extract %addr_hit from %c11_i5 : <i18> -> <i1>
      %213 = llhd.prb %reg_addr : i7
      %214 = comb.icmp eq %213, %c44_i7 : i7
      llhd.drv %212, %214 after %1 : i1
      %215 = llhd.sig.extract %addr_hit from %c12_i5 : <i18> -> <i1>
      %216 = llhd.prb %reg_addr : i7
      %217 = comb.icmp eq %216, %c48_i7 : i7
      llhd.drv %215, %217 after %1 : i1
      %218 = llhd.sig.extract %addr_hit from %c13_i5 : <i18> -> <i1>
      %219 = llhd.prb %reg_addr : i7
      %220 = comb.icmp eq %219, %c52_i7 : i7
      llhd.drv %218, %220 after %1 : i1
      %221 = llhd.sig.extract %addr_hit from %c14_i5 : <i18> -> <i1>
      %222 = llhd.prb %reg_addr : i7
      %223 = comb.icmp eq %222, %c56_i7 : i7
      llhd.drv %221, %223 after %1 : i1
      %224 = llhd.sig.extract %addr_hit from %c15_i5 : <i18> -> <i1>
      %225 = llhd.prb %reg_addr : i7
      %226 = comb.icmp eq %225, %c60_i7 : i7
      llhd.drv %224, %226 after %1 : i1
      %227 = llhd.sig.extract %addr_hit from %c-16_i5 : <i18> -> <i1>
      %228 = llhd.prb %reg_addr : i7
      %229 = comb.icmp eq %228, %c-64_i7 : i7
      llhd.drv %227, %229 after %1 : i1
      %230 = llhd.sig.extract %addr_hit from %c-15_i5 : <i18> -> <i1>
      %231 = llhd.prb %reg_addr : i7
      %232 = comb.icmp eq %231, %c-60_i7 : i7
      llhd.drv %230, %232 after %1 : i1
      llhd.wait (%97, %98 : i18, i7), ^bb1
    }
    %99 = comb.or %u_reg_if.re_o, %6 : i1
    %100 = comb.icmp eq %97, %c0_i18 : i18
    %101 = comb.and %99, %100 {sv.namehint = "addrmiss"} : i1
    %102 = llhd.prb %reg_be : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %179 = llhd.prb %reg_we : i1
      %180 = llhd.prb %addr_hit : i18
      %181 = comb.extract %180 from 0 : (i18) -> i1
      %182 = llhd.prb %reg_be : i4
      %183 = comb.extract %182 from 0 : (i4) -> i2
      %184 = comb.extract %182 from 0 : (i4) -> i1
      %185 = comb.xor %184, %true : i1
      %186 = comb.and %181, %185 : i1
      %187 = comb.extract %180 from 1 : (i18) -> i1
      %188 = comb.and %187, %185 : i1
      %189 = comb.extract %180 from 2 : (i18) -> i1
      %190 = comb.and %189, %185 : i1
      %191 = comb.extract %180 from 3 : (i18) -> i1
      %192 = comb.and %191, %185 : i1
      %193 = comb.extract %180 from 4 : (i18) -> i1
      %194 = comb.and %193, %185 : i1
      %195 = comb.extract %180 from 5 : (i18) -> i1
      %196 = comb.icmp ne %183, %c-1_i2 : i2
      %197 = comb.and %195, %196 : i1
      %198 = comb.extract %180 from 6 : (i18) -> i1
      %199 = comb.icmp ne %182, %c-1_i4 : i4
      %200 = comb.and %198, %199 : i1
      %201 = comb.extract %180 from 7 : (i18) -> i1
      %202 = comb.icmp ne %182, %c-1_i4 : i4
      %203 = comb.and %201, %202 : i1
      %204 = comb.extract %180 from 8 : (i18) -> i1
      %205 = comb.icmp ne %182, %c-1_i4 : i4
      %206 = comb.and %204, %205 : i1
      %207 = comb.extract %180 from 9 : (i18) -> i1
      %208 = comb.and %207, %185 : i1
      %209 = comb.extract %180 from 10 : (i18) -> i1
      %210 = comb.icmp ne %183, %c-1_i2 : i2
      %211 = comb.and %209, %210 : i1
      %212 = comb.extract %180 from 11 : (i18) -> i1
      %213 = comb.icmp ne %182, %c-1_i4 : i4
      %214 = comb.and %212, %213 : i1
      %215 = comb.extract %180 from 12 : (i18) -> i1
      %216 = comb.icmp ne %182, %c-1_i4 : i4
      %217 = comb.and %215, %216 : i1
      %218 = comb.extract %180 from 13 : (i18) -> i1
      %219 = comb.icmp ne %182, %c-1_i4 : i4
      %220 = comb.and %218, %219 : i1
      %221 = comb.extract %180 from 14 : (i18) -> i1
      %222 = comb.icmp ne %183, %c-1_i2 : i2
      %223 = comb.and %221, %222 : i1
      %224 = comb.extract %180 from 15 : (i18) -> i1
      %225 = comb.icmp ne %182, %c-1_i4 : i4
      %226 = comb.and %224, %225 : i1
      %227 = comb.extract %180 from 16 : (i18) -> i1
      %228 = comb.and %227, %185 : i1
      %229 = comb.extract %180 from 17 : (i18) -> i1
      %230 = comb.icmp ne %183, %c-1_i2 : i2
      %231 = comb.and %229, %230 : i1
      %232 = comb.or %186, %188, %190, %192, %194, %197, %200, %203, %206, %208, %211, %214, %217, %220, %223, %226, %228, %231 : i1
      %233 = comb.and %179, %232 : i1
      llhd.drv %wr_err, %233 after %1 : i1
      llhd.wait (%6, %97, %102, %77 : i1, i18, i4, i1), ^bb1
    }
    %103 = comb.extract %97 from 0 : (i18) -> i1
    %104 = comb.xor %78, %true : i1
    %105 = comb.and %103, %6, %104 : i1
    llhd.drv %intr_state_we, %105 after %1 : i1
    %106 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "regwen_wd"} : (i32) -> i1
    %107 = comb.extract %u_reg_if.wdata_o from 1 {sv.namehint = "alert_test_fatal_alert_wd"} : (i32) -> i1
    %108 = comb.extract %97 from 1 : (i18) -> i1
    %109 = comb.and %108, %6, %104 : i1
    llhd.drv %intr_enable_we, %109 after %1 : i1
    %110 = comb.extract %97 from 2 : (i18) -> i1
    %111 = comb.and %110, %6, %104 : i1
    llhd.drv %intr_test_we, %111 after %1 : i1
    %112 = comb.extract %97 from 3 : (i18) -> i1
    %113 = comb.and %112, %6, %104 : i1
    llhd.drv %alert_test_we, %113 after %1 : i1
    %114 = comb.extract %97 from 4 : (i18) -> i1
    %115 = comb.and %114, %6, %104 : i1
    llhd.drv %regwen_we, %115 after %1 : i1
    %116 = comb.extract %97 from 5 : (i18) -> i1
    %117 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "ctrl_edn_enable_wd"} : (i32) -> i4
    %118 = comb.extract %u_reg_if.wdata_o from 4 {sv.namehint = "ctrl_boot_req_mode_wd"} : (i32) -> i4
    %119 = comb.extract %u_reg_if.wdata_o from 8 {sv.namehint = "ctrl_auto_req_mode_wd"} : (i32) -> i4
    %120 = comb.extract %u_reg_if.wdata_o from 12 {sv.namehint = "ctrl_cmd_fifo_rst_wd"} : (i32) -> i4
    %121 = comb.extract %97 from 6 : (i18) -> i1
    %122 = comb.and %121, %6, %104 : i1
    llhd.drv %boot_ins_cmd_we, %122 after %1 : i1
    %123 = comb.extract %97 from 7 : (i18) -> i1
    %124 = comb.and %123, %6, %104 : i1
    llhd.drv %boot_gen_cmd_we, %124 after %1 : i1
    %125 = comb.extract %97 from 8 : (i18) -> i1
    %126 = comb.and %125, %6, %104 : i1
    llhd.drv %sw_cmd_req_we, %126 after %1 : i1
    %127 = comb.extract %97 from 11 : (i18) -> i1
    %128 = comb.and %127, %6, %104 : i1
    llhd.drv %reseed_cmd_we, %128 after %1 : i1
    %129 = comb.extract %97 from 12 : (i18) -> i1
    %130 = comb.and %129, %6, %104 : i1
    llhd.drv %generate_cmd_we, %130 after %1 : i1
    %131 = comb.extract %97 from 13 : (i18) -> i1
    %132 = comb.and %131, %6, %104 : i1
    llhd.drv %max_num_reqs_between_reseeds_we, %132 after %1 : i1
    %133 = comb.extract %97 from 14 : (i18) -> i1
    %134 = comb.and %133, %6, %104 : i1
    llhd.drv %recov_alert_sts_we, %134 after %1 : i1
    %135 = comb.extract %u_reg_if.wdata_o from 2 {sv.namehint = "recov_alert_sts_auto_req_mode_field_alert_wd"} : (i32) -> i1
    %136 = comb.extract %u_reg_if.wdata_o from 3 {sv.namehint = "recov_alert_sts_cmd_fifo_rst_field_alert_wd"} : (i32) -> i1
    %137 = comb.extract %u_reg_if.wdata_o from 12 {sv.namehint = "recov_alert_sts_edn_bus_cmp_alert_wd"} : (i32) -> i1
    %138 = comb.extract %u_reg_if.wdata_o from 13 {sv.namehint = "recov_alert_sts_csrng_ack_err_wd"} : (i32) -> i1
    %139 = comb.extract %97 from 16 : (i18) -> i1
    %140 = comb.and %139, %6, %104 : i1
    llhd.drv %err_code_test_we, %140 after %1 : i1
    %141 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "err_code_test_wd"} : (i32) -> i5
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %179 = llhd.sig.extract %reg_we_check from %c0_i5 : <i18> -> <i1>
      %180 = llhd.prb %intr_state_we : i1
      llhd.drv %179, %180 after %1 : i1
      %181 = llhd.sig.extract %reg_we_check from %c1_i5 : <i18> -> <i1>
      %182 = llhd.prb %intr_enable_we : i1
      llhd.drv %181, %182 after %1 : i1
      %183 = llhd.sig.extract %reg_we_check from %c2_i5 : <i18> -> <i1>
      %184 = llhd.prb %intr_test_we : i1
      llhd.drv %183, %184 after %1 : i1
      %185 = llhd.sig.extract %reg_we_check from %c3_i5 : <i18> -> <i1>
      %186 = llhd.prb %alert_test_we : i1
      llhd.drv %185, %186 after %1 : i1
      %187 = llhd.sig.extract %reg_we_check from %c4_i5 : <i18> -> <i1>
      %188 = llhd.prb %regwen_we : i1
      llhd.drv %187, %188 after %1 : i1
      %189 = llhd.sig.extract %reg_we_check from %c5_i5 : <i18> -> <i1>
      %190 = llhd.prb %ctrl_gated_we : i1
      llhd.drv %189, %190 after %1 : i1
      %191 = llhd.sig.extract %reg_we_check from %c6_i5 : <i18> -> <i1>
      %192 = llhd.prb %boot_ins_cmd_we : i1
      llhd.drv %191, %192 after %1 : i1
      %193 = llhd.sig.extract %reg_we_check from %c7_i5 : <i18> -> <i1>
      %194 = llhd.prb %boot_gen_cmd_we : i1
      llhd.drv %193, %194 after %1 : i1
      %195 = llhd.sig.extract %reg_we_check from %c8_i5 : <i18> -> <i1>
      %196 = llhd.prb %sw_cmd_req_we : i1
      llhd.drv %195, %196 after %1 : i1
      %197 = llhd.sig.extract %reg_we_check from %c9_i5 : <i18> -> <i1>
      llhd.drv %197, %false after %1 : i1
      %198 = llhd.sig.extract %reg_we_check from %c10_i5 : <i18> -> <i1>
      llhd.drv %198, %false after %1 : i1
      %199 = llhd.sig.extract %reg_we_check from %c11_i5 : <i18> -> <i1>
      %200 = llhd.prb %reseed_cmd_we : i1
      llhd.drv %199, %200 after %1 : i1
      %201 = llhd.sig.extract %reg_we_check from %c12_i5 : <i18> -> <i1>
      %202 = llhd.prb %generate_cmd_we : i1
      llhd.drv %201, %202 after %1 : i1
      %203 = llhd.sig.extract %reg_we_check from %c13_i5 : <i18> -> <i1>
      %204 = llhd.prb %max_num_reqs_between_reseeds_we : i1
      llhd.drv %203, %204 after %1 : i1
      %205 = llhd.sig.extract %reg_we_check from %c14_i5 : <i18> -> <i1>
      %206 = llhd.prb %recov_alert_sts_we : i1
      llhd.drv %205, %206 after %1 : i1
      %207 = llhd.sig.extract %reg_we_check from %c15_i5 : <i18> -> <i1>
      llhd.drv %207, %false after %1 : i1
      %208 = llhd.sig.extract %reg_we_check from %c-16_i5 : <i18> -> <i1>
      %209 = llhd.prb %err_code_test_we : i1
      llhd.drv %208, %209 after %1 : i1
      %210 = llhd.sig.extract %reg_we_check from %c-15_i5 : <i18> -> <i1>
      llhd.drv %210, %false after %1 : i1
      llhd.wait (%5, %9, %15, %21, %29, %37, %38, %48, %51, %54, %57, %60, %64, %67, %69 : i18, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    %142 = llhd.prb %intr_state_edn_cmd_req_done_qs : i1
    %143 = llhd.prb %intr_state_edn_fatal_err_qs : i1
    %144 = llhd.prb %intr_enable_edn_cmd_req_done_qs : i1
    %145 = llhd.prb %intr_enable_edn_fatal_err_qs : i1
    %146 = llhd.prb %ctrl_edn_enable_qs : i4
    %147 = llhd.prb %ctrl_boot_req_mode_qs : i4
    %148 = llhd.prb %ctrl_auto_req_mode_qs : i4
    %149 = llhd.prb %ctrl_cmd_fifo_rst_qs : i4
    %150 = llhd.prb %boot_ins_cmd_qs : i32
    %151 = llhd.prb %boot_gen_cmd_qs : i32
    %152 = llhd.prb %sw_cmd_sts_cmd_reg_rdy_qs : i1
    %153 = llhd.prb %sw_cmd_sts_cmd_rdy_qs : i1
    %154 = llhd.prb %sw_cmd_sts_cmd_ack_qs : i1
    %155 = llhd.prb %sw_cmd_sts_cmd_sts_qs : i3
    %156 = llhd.prb %hw_cmd_sts_boot_mode_qs : i1
    %157 = llhd.prb %hw_cmd_sts_auto_mode_qs : i1
    %158 = llhd.prb %hw_cmd_sts_cmd_type_qs : i4
    %159 = llhd.prb %hw_cmd_sts_cmd_ack_qs : i1
    %160 = llhd.prb %hw_cmd_sts_cmd_sts_qs : i3
    %161 = llhd.prb %max_num_reqs_between_reseeds_qs : i32
    %162 = llhd.prb %recov_alert_sts_edn_enable_field_alert_qs : i1
    %163 = llhd.prb %recov_alert_sts_boot_req_mode_field_alert_qs : i1
    %164 = llhd.prb %recov_alert_sts_auto_req_mode_field_alert_qs : i1
    %165 = llhd.prb %recov_alert_sts_cmd_fifo_rst_field_alert_qs : i1
    %166 = llhd.prb %recov_alert_sts_edn_bus_cmp_alert_qs : i1
    %167 = llhd.prb %recov_alert_sts_csrng_ack_err_qs : i1
    %168 = llhd.prb %err_code_sfifo_rescmd_err_qs : i1
    %169 = llhd.prb %err_code_sfifo_gencmd_err_qs : i1
    %170 = llhd.prb %err_code_edn_ack_sm_err_qs : i1
    %171 = llhd.prb %err_code_edn_main_sm_err_qs : i1
    %172 = llhd.prb %err_code_edn_cntr_err_qs : i1
    %173 = llhd.prb %err_code_fifo_write_err_qs : i1
    %174 = llhd.prb %err_code_fifo_read_err_qs : i1
    %175 = llhd.prb %err_code_fifo_state_err_qs : i1
    %176 = llhd.prb %err_code_test_qs : i5
    %177 = llhd.prb %main_sm_state_qs : i9
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb38
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      %179 = llhd.prb %addr_hit : i18
      %180 = comb.extract %179 from 0 : (i18) -> i1
      %181 = comb.icmp ceq %180, %true : i1
      cf.cond_br %181, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %182 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %183 = llhd.prb %intr_state_edn_cmd_req_done_qs : i1
      llhd.drv %182, %183 after %1 : i1
      %184 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %185 = llhd.prb %intr_state_edn_fatal_err_qs : i1
      llhd.drv %184, %185 after %1 : i1
      cf.br ^bb38
    ^bb3:  // pred: ^bb1
      %186 = llhd.prb %addr_hit : i18
      %187 = comb.extract %186 from 1 : (i18) -> i1
      %188 = comb.icmp ceq %187, %true : i1
      cf.cond_br %188, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %189 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %190 = llhd.prb %intr_enable_edn_cmd_req_done_qs : i1
      llhd.drv %189, %190 after %1 : i1
      %191 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %192 = llhd.prb %intr_enable_edn_fatal_err_qs : i1
      llhd.drv %191, %192 after %1 : i1
      cf.br ^bb38
    ^bb5:  // pred: ^bb3
      %193 = llhd.prb %addr_hit : i18
      %194 = comb.extract %193 from 2 : (i18) -> i1
      %195 = comb.icmp ceq %194, %true : i1
      cf.cond_br %195, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %196 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      llhd.drv %196, %false after %1 : i1
      %197 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      llhd.drv %197, %false after %1 : i1
      cf.br ^bb38
    ^bb7:  // pred: ^bb5
      %198 = llhd.prb %addr_hit : i18
      %199 = comb.extract %198 from 3 : (i18) -> i1
      %200 = comb.icmp ceq %199, %true : i1
      cf.cond_br %200, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %201 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      llhd.drv %201, %false after %1 : i1
      %202 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      llhd.drv %202, %false after %1 : i1
      cf.br ^bb38
    ^bb9:  // pred: ^bb7
      %203 = llhd.prb %addr_hit : i18
      %204 = comb.extract %203 from 4 : (i18) -> i1
      %205 = comb.icmp ceq %204, %true : i1
      cf.cond_br %205, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %206 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %207 = llhd.prb %regwen_qs : i1
      llhd.drv %206, %207 after %1 : i1
      cf.br ^bb38
    ^bb11:  // pred: ^bb9
      %208 = llhd.prb %addr_hit : i18
      %209 = comb.extract %208 from 5 : (i18) -> i1
      %210 = comb.icmp ceq %209, %true : i1
      cf.cond_br %210, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %211 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i4>
      %212 = llhd.prb %ctrl_edn_enable_qs : i4
      llhd.drv %211, %212 after %1 : i4
      %213 = llhd.sig.extract %reg_rdata_next from %c4_i5 : <i32> -> <i4>
      %214 = llhd.prb %ctrl_boot_req_mode_qs : i4
      llhd.drv %213, %214 after %1 : i4
      %215 = llhd.sig.extract %reg_rdata_next from %c8_i5 : <i32> -> <i4>
      %216 = llhd.prb %ctrl_auto_req_mode_qs : i4
      llhd.drv %215, %216 after %1 : i4
      %217 = llhd.sig.extract %reg_rdata_next from %c12_i5 : <i32> -> <i4>
      %218 = llhd.prb %ctrl_cmd_fifo_rst_qs : i4
      llhd.drv %217, %218 after %1 : i4
      cf.br ^bb38
    ^bb13:  // pred: ^bb11
      %219 = llhd.prb %addr_hit : i18
      %220 = comb.extract %219 from 6 : (i18) -> i1
      %221 = comb.icmp ceq %220, %true : i1
      cf.cond_br %221, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %222 = llhd.prb %boot_ins_cmd_qs : i32
      llhd.drv %reg_rdata_next, %222 after %1 : i32
      cf.br ^bb38
    ^bb15:  // pred: ^bb13
      %223 = llhd.prb %addr_hit : i18
      %224 = comb.extract %223 from 7 : (i18) -> i1
      %225 = comb.icmp ceq %224, %true : i1
      cf.cond_br %225, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      %226 = llhd.prb %boot_gen_cmd_qs : i32
      llhd.drv %reg_rdata_next, %226 after %1 : i32
      cf.br ^bb38
    ^bb17:  // pred: ^bb15
      %227 = llhd.prb %addr_hit : i18
      %228 = comb.extract %227 from 8 : (i18) -> i1
      %229 = comb.icmp ceq %228, %true : i1
      cf.cond_br %229, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb38
    ^bb19:  // pred: ^bb17
      %230 = llhd.prb %addr_hit : i18
      %231 = comb.extract %230 from 9 : (i18) -> i1
      %232 = comb.icmp ceq %231, %true : i1
      cf.cond_br %232, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      %233 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %234 = llhd.prb %sw_cmd_sts_cmd_reg_rdy_qs : i1
      llhd.drv %233, %234 after %1 : i1
      %235 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %236 = llhd.prb %sw_cmd_sts_cmd_rdy_qs : i1
      llhd.drv %235, %236 after %1 : i1
      %237 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %238 = llhd.prb %sw_cmd_sts_cmd_ack_qs : i1
      llhd.drv %237, %238 after %1 : i1
      %239 = llhd.sig.extract %reg_rdata_next from %c3_i5 : <i32> -> <i3>
      %240 = llhd.prb %sw_cmd_sts_cmd_sts_qs : i3
      llhd.drv %239, %240 after %1 : i3
      cf.br ^bb38
    ^bb21:  // pred: ^bb19
      %241 = llhd.prb %addr_hit : i18
      %242 = comb.extract %241 from 10 : (i18) -> i1
      %243 = comb.icmp ceq %242, %true : i1
      cf.cond_br %243, ^bb22, ^bb23
    ^bb22:  // pred: ^bb21
      %244 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %245 = llhd.prb %hw_cmd_sts_boot_mode_qs : i1
      llhd.drv %244, %245 after %1 : i1
      %246 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %247 = llhd.prb %hw_cmd_sts_auto_mode_qs : i1
      llhd.drv %246, %247 after %1 : i1
      %248 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i4>
      %249 = llhd.prb %hw_cmd_sts_cmd_type_qs : i4
      llhd.drv %248, %249 after %1 : i4
      %250 = llhd.sig.extract %reg_rdata_next from %c6_i5 : <i32> -> <i1>
      %251 = llhd.prb %hw_cmd_sts_cmd_ack_qs : i1
      llhd.drv %250, %251 after %1 : i1
      %252 = llhd.sig.extract %reg_rdata_next from %c7_i5 : <i32> -> <i3>
      %253 = llhd.prb %hw_cmd_sts_cmd_sts_qs : i3
      llhd.drv %252, %253 after %1 : i3
      cf.br ^bb38
    ^bb23:  // pred: ^bb21
      %254 = llhd.prb %addr_hit : i18
      %255 = comb.extract %254 from 11 : (i18) -> i1
      %256 = comb.icmp ceq %255, %true : i1
      cf.cond_br %256, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb38
    ^bb25:  // pred: ^bb23
      %257 = llhd.prb %addr_hit : i18
      %258 = comb.extract %257 from 12 : (i18) -> i1
      %259 = comb.icmp ceq %258, %true : i1
      cf.cond_br %259, ^bb26, ^bb27
    ^bb26:  // pred: ^bb25
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb38
    ^bb27:  // pred: ^bb25
      %260 = llhd.prb %addr_hit : i18
      %261 = comb.extract %260 from 13 : (i18) -> i1
      %262 = comb.icmp ceq %261, %true : i1
      cf.cond_br %262, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      %263 = llhd.prb %max_num_reqs_between_reseeds_qs : i32
      llhd.drv %reg_rdata_next, %263 after %1 : i32
      cf.br ^bb38
    ^bb29:  // pred: ^bb27
      %264 = llhd.prb %addr_hit : i18
      %265 = comb.extract %264 from 14 : (i18) -> i1
      %266 = comb.icmp ceq %265, %true : i1
      cf.cond_br %266, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      %267 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %268 = llhd.prb %recov_alert_sts_edn_enable_field_alert_qs : i1
      llhd.drv %267, %268 after %1 : i1
      %269 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %270 = llhd.prb %recov_alert_sts_boot_req_mode_field_alert_qs : i1
      llhd.drv %269, %270 after %1 : i1
      %271 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %272 = llhd.prb %recov_alert_sts_auto_req_mode_field_alert_qs : i1
      llhd.drv %271, %272 after %1 : i1
      %273 = llhd.sig.extract %reg_rdata_next from %c3_i5 : <i32> -> <i1>
      %274 = llhd.prb %recov_alert_sts_cmd_fifo_rst_field_alert_qs : i1
      llhd.drv %273, %274 after %1 : i1
      %275 = llhd.sig.extract %reg_rdata_next from %c12_i5 : <i32> -> <i1>
      %276 = llhd.prb %recov_alert_sts_edn_bus_cmp_alert_qs : i1
      llhd.drv %275, %276 after %1 : i1
      %277 = llhd.sig.extract %reg_rdata_next from %c13_i5 : <i32> -> <i1>
      %278 = llhd.prb %recov_alert_sts_csrng_ack_err_qs : i1
      llhd.drv %277, %278 after %1 : i1
      cf.br ^bb38
    ^bb31:  // pred: ^bb29
      %279 = llhd.prb %addr_hit : i18
      %280 = comb.extract %279 from 15 : (i18) -> i1
      %281 = comb.icmp ceq %280, %true : i1
      cf.cond_br %281, ^bb32, ^bb33
    ^bb32:  // pred: ^bb31
      %282 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %283 = llhd.prb %err_code_sfifo_rescmd_err_qs : i1
      llhd.drv %282, %283 after %1 : i1
      %284 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %285 = llhd.prb %err_code_sfifo_gencmd_err_qs : i1
      llhd.drv %284, %285 after %1 : i1
      %286 = llhd.sig.extract %reg_rdata_next from %c-12_i5 : <i32> -> <i1>
      %287 = llhd.prb %err_code_edn_ack_sm_err_qs : i1
      llhd.drv %286, %287 after %1 : i1
      %288 = llhd.sig.extract %reg_rdata_next from %c-11_i5 : <i32> -> <i1>
      %289 = llhd.prb %err_code_edn_main_sm_err_qs : i1
      llhd.drv %288, %289 after %1 : i1
      %290 = llhd.sig.extract %reg_rdata_next from %c-10_i5 : <i32> -> <i1>
      %291 = llhd.prb %err_code_edn_cntr_err_qs : i1
      llhd.drv %290, %291 after %1 : i1
      %292 = llhd.sig.extract %reg_rdata_next from %c-4_i5 : <i32> -> <i1>
      %293 = llhd.prb %err_code_fifo_write_err_qs : i1
      llhd.drv %292, %293 after %1 : i1
      %294 = llhd.sig.extract %reg_rdata_next from %c-3_i5 : <i32> -> <i1>
      %295 = llhd.prb %err_code_fifo_read_err_qs : i1
      llhd.drv %294, %295 after %1 : i1
      %296 = llhd.sig.extract %reg_rdata_next from %c-2_i5 : <i32> -> <i1>
      %297 = llhd.prb %err_code_fifo_state_err_qs : i1
      llhd.drv %296, %297 after %1 : i1
      cf.br ^bb38
    ^bb33:  // pred: ^bb31
      %298 = llhd.prb %addr_hit : i18
      %299 = comb.extract %298 from 16 : (i18) -> i1
      %300 = comb.icmp ceq %299, %true : i1
      cf.cond_br %300, ^bb34, ^bb35
    ^bb34:  // pred: ^bb33
      %301 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i5>
      %302 = llhd.prb %err_code_test_qs : i5
      llhd.drv %301, %302 after %1 : i5
      cf.br ^bb38
    ^bb35:  // pred: ^bb33
      %303 = llhd.prb %addr_hit : i18
      %304 = comb.extract %303 from 17 : (i18) -> i1
      %305 = comb.icmp ceq %304, %true : i1
      cf.cond_br %305, ^bb36, ^bb37
    ^bb36:  // pred: ^bb35
      %306 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i9>
      %307 = llhd.prb %main_sm_state_qs : i9
      llhd.drv %306, %307 after %1 : i9
      cf.br ^bb38
    ^bb37:  // pred: ^bb35
      llhd.drv %reg_rdata_next, %c-1_i32 after %1 : i32
      cf.br ^bb38
    ^bb38:  // 19 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb18, ^bb20, ^bb22, ^bb24, ^bb26, ^bb28, ^bb30, ^bb32, ^bb34, ^bb36, ^bb37
      llhd.wait (%76, %97, %142, %143, %144, %145, %87, %146, %147, %148, %149, %150, %151, %152, %153, %154, %155, %156, %157, %158, %159, %160, %161, %162, %163, %164, %165, %166, %167, %168, %169, %170, %171, %172, %173, %174, %175, %176, %177 : i32, i18, i1, i1, i1, i1, i1, i4, i4, i4, i4, i32, i32, i1, i1, i1, i3, i1, i1, i4, i1, i3, i32, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i5, i9), ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    %178 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>
    hw.output %u_rsp_intg_gen.tl_o, %178, %75 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>, i1
  }
  hw.module @edn(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %edn_i : !hw.array<8xstruct<edn_req: i1>>, out edn_o : !hw.array<8xstruct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>, out csrng_cmd_o : !hw.struct<csrng_req_valid: i1, csrng_req_bus: i32, genbits_ready: i1>, in %csrng_cmd_i : !hw.struct<csrng_req_ready: i1, csrng_rsp_ack: i1, csrng_rsp_sts: i3, genbits_valid: i1, genbits_fips: i1, genbits_bus: i128>, in %alert_rx_i : !hw.array<2xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, out alert_tx_o : !hw.array<2xstruct<alert_p: i1, alert_n: i1>>, out intr_edn_cmd_req_done_o : i1, out intr_edn_fatal_err_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %true = hw.constant true
    %c0_i2 = hw.constant 0 : i2
    %false = hw.constant false
    %1 = hw.aggregate_constant [[false, false], [false, false]] : !hw.array<2xstruct<alert_p: i1, alert_n: i1>>
    %alert_tx_o = llhd.sig %1 : !hw.array<2xstruct<alert_p: i1, alert_n: i1>>
    %alert_test = llhd.sig %c0_i2 : i2
    %alert = llhd.sig %c0_i2 : i2
    %intg_err_alert = llhd.sig %c0_i2 : i2
    %2 = llhd.sig.extract %intg_err_alert from %true : <i2> -> <i1>
    %u_reg.tl_o, %u_reg.reg2hw, %u_reg.intg_err_o = hw.instance "u_reg" @edn_reg_top(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, hw2reg: %u_edn_core.hw2reg: !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<d: i1, de: i1>, edn_cmd_req_done: !hw.struct<d: i1, de: i1>>, sw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>, hw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>, recov_alert_sts: !hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>, err_code: !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>, main_sm_state: !hw.struct<d: i9, de: i1>>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, reg2hw: !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>, intg_err_o: i1) {sv.namehint = "reg2hw"}
    llhd.drv %2, %u_reg.intg_err_o after %0 : i1
    %3 = llhd.sig.extract %alert_test from %false : <i2> -> <i1>
    %4 = llhd.sig.extract %alert_test from %true : <i2> -> <i1>
    %5 = llhd.sig.extract %alert from %false : <i2> -> <i1>
    %6 = llhd.sig.extract %alert from %true : <i2> -> <i1>
    %u_edn_core.hw2reg, %u_edn_core.edn_o, %u_edn_core.csrng_cmd_o, %u_edn_core.recov_alert_test_o, %u_edn_core.fatal_alert_test_o, %u_edn_core.recov_alert_o, %u_edn_core.fatal_alert_o, %u_edn_core.intr_edn_cmd_req_done_o, %u_edn_core.intr_edn_fatal_err_o = hw.instance "u_edn_core" @edn_core(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, reg2hw: %u_reg.reg2hw: !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_enable: !hw.struct<edn_fatal_err: !hw.struct<q: i1>, edn_cmd_req_done: !hw.struct<q: i1>>, intr_test: !hw.struct<edn_fatal_err: !hw.struct<q: i1, qe: i1>, edn_cmd_req_done: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<fatal_alert: !hw.struct<q: i1, qe: i1>, recov_alert: !hw.struct<q: i1, qe: i1>>, ctrl: !hw.struct<cmd_fifo_rst: !hw.struct<q: i4>, auto_req_mode: !hw.struct<q: i4>, boot_req_mode: !hw.struct<q: i4>, edn_enable: !hw.struct<q: i4>>, boot_ins_cmd: !hw.struct<q: i32>, boot_gen_cmd: !hw.struct<q: i32>, sw_cmd_req: !hw.struct<q: i32, qe: i1>, reseed_cmd: !hw.struct<q: i32, qe: i1>, generate_cmd: !hw.struct<q: i32, qe: i1>, max_num_reqs_between_reseeds: !hw.struct<q: i32, qe: i1>, err_code_test: !hw.struct<q: i5, qe: i1>>, edn_i: %edn_i: !hw.array<8xstruct<edn_req: i1>>, csrng_cmd_i: %csrng_cmd_i: !hw.struct<csrng_req_ready: i1, csrng_rsp_ack: i1, csrng_rsp_sts: i3, genbits_valid: i1, genbits_fips: i1, genbits_bus: i128>) -> (hw2reg: !hw.struct<intr_state: !hw.struct<edn_fatal_err: !hw.struct<d: i1, de: i1>, edn_cmd_req_done: !hw.struct<d: i1, de: i1>>, sw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_rdy: !hw.struct<d: i1, de: i1>, cmd_reg_rdy: !hw.struct<d: i1, de: i1>>, hw_cmd_sts: !hw.struct<cmd_sts: !hw.struct<d: i3, de: i1>, cmd_ack: !hw.struct<d: i1, de: i1>, cmd_type: !hw.struct<d: i4, de: i1>, auto_mode: !hw.struct<d: i1, de: i1>, boot_mode: !hw.struct<d: i1, de: i1>>, recov_alert_sts: !hw.struct<csrng_ack_err: !hw.struct<d: i1, de: i1>, edn_bus_cmp_alert: !hw.struct<d: i1, de: i1>, cmd_fifo_rst_field_alert: !hw.struct<d: i1, de: i1>, auto_req_mode_field_alert: !hw.struct<d: i1, de: i1>, boot_req_mode_field_alert: !hw.struct<d: i1, de: i1>, edn_enable_field_alert: !hw.struct<d: i1, de: i1>>, err_code: !hw.struct<fifo_state_err: !hw.struct<d: i1, de: i1>, fifo_read_err: !hw.struct<d: i1, de: i1>, fifo_write_err: !hw.struct<d: i1, de: i1>, edn_cntr_err: !hw.struct<d: i1, de: i1>, edn_main_sm_err: !hw.struct<d: i1, de: i1>, edn_ack_sm_err: !hw.struct<d: i1, de: i1>, sfifo_gencmd_err: !hw.struct<d: i1, de: i1>, sfifo_rescmd_err: !hw.struct<d: i1, de: i1>>, main_sm_state: !hw.struct<d: i9, de: i1>>, edn_o: !hw.array<8xstruct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>, csrng_cmd_o: !hw.struct<csrng_req_valid: i1, csrng_req_bus: i32, genbits_ready: i1>, recov_alert_test_o: i1, fatal_alert_test_o: i1, recov_alert_o: i1, fatal_alert_o: i1, intr_edn_cmd_req_done_o: i1, intr_edn_fatal_err_o: i1) {sv.namehint = "hw2reg"}
    llhd.drv %3, %u_edn_core.recov_alert_test_o after %0 : i1
    llhd.drv %4, %u_edn_core.fatal_alert_test_o after %0 : i1
    llhd.drv %5, %u_edn_core.recov_alert_o after %0 : i1
    llhd.drv %6, %u_edn_core.fatal_alert_o after %0 : i1
    %7 = llhd.prb %alert_test : i2
    %8 = comb.extract %7 from 0 : (i2) -> i1
    %9 = llhd.prb %alert : i2
    %10 = comb.extract %9 from 0 : (i2) -> i1
    %11 = llhd.prb %intg_err_alert : i2
    %12 = comb.extract %11 from 0 : (i2) -> i1
    %13 = comb.or %10, %12 : i1
    %14 = hw.array_get %alert_rx_i[%false] : !hw.array<2xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, i1
    %15 = llhd.sig.array_get %alert_tx_o[%false] : <!hw.array<2xstruct<alert_p: i1, alert_n: i1>>>
    %gen_alert_tx_0.u_prim_alert_sender.alert_ack_o, %gen_alert_tx_0.u_prim_alert_sender.alert_state_o, %gen_alert_tx_0.u_prim_alert_sender.alert_tx_o = hw.instance "gen_alert_tx_0.u_prim_alert_sender" @prim_alert_sender(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, alert_test_i: %8: i1, alert_req_i: %13: i1, alert_rx_i: %14: !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>) -> (alert_ack_o: i1, alert_state_o: i1, alert_tx_o: !hw.struct<alert_p: i1, alert_n: i1>)
    llhd.drv %15, %gen_alert_tx_0.u_prim_alert_sender.alert_tx_o after %0 : !hw.struct<alert_p: i1, alert_n: i1>
    %16 = comb.extract %7 from 1 : (i2) -> i1
    %17 = comb.extract %9 from 1 : (i2) -> i1
    %18 = comb.extract %11 from 1 : (i2) -> i1
    %19 = comb.or %17, %18 : i1
    %20 = hw.array_get %alert_rx_i[%true] : !hw.array<2xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, i1
    %21 = llhd.sig.array_get %alert_tx_o[%true] : <!hw.array<2xstruct<alert_p: i1, alert_n: i1>>>
    %gen_alert_tx_1.u_prim_alert_sender.alert_ack_o, %gen_alert_tx_1.u_prim_alert_sender.alert_state_o, %gen_alert_tx_1.u_prim_alert_sender.alert_tx_o = hw.instance "gen_alert_tx_1.u_prim_alert_sender" @prim_alert_sender_0(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, alert_test_i: %16: i1, alert_req_i: %19: i1, alert_rx_i: %20: !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>) -> (alert_ack_o: i1, alert_state_o: i1, alert_tx_o: !hw.struct<alert_p: i1, alert_n: i1>)
    llhd.drv %21, %gen_alert_tx_1.u_prim_alert_sender.alert_tx_o after %0 : !hw.struct<alert_p: i1, alert_n: i1>
    %22 = llhd.sig.extract %intg_err_alert from %false : <i2> -> <i1>
    llhd.drv %22, %false after %0 : i1
    %23 = llhd.prb %alert_tx_o : !hw.array<2xstruct<alert_p: i1, alert_n: i1>>
    hw.output %u_reg.tl_o, %u_edn_core.edn_o, %u_edn_core.csrng_cmd_o, %23, %u_edn_core.intr_edn_cmd_req_done_o, %u_edn_core.intr_edn_fatal_err_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.array<8xstruct<edn_ack: i1, edn_fips: i1, edn_bus: i32>>, !hw.struct<csrng_req_valid: i1, csrng_req_bus: i32, genbits_ready: i1>, !hw.array<2xstruct<alert_p: i1, alert_n: i1>>, i1, i1
  }
}
