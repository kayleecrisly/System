module {
  hw.module private @prim_buf(in %in_i : i2, out out_o : i2) {
    hw.output %in_i : i2
  }
  hw.module private @prim_buf_16(in %in_i : i35, out out_o : i35) {
    hw.output %in_i : i35
  }
  hw.module private @prim_buf_18(in %in_i : i1, out out_o : i1) {
    hw.output %in_i : i1
  }
  hw.module private @prim_buf_33(in %in_i : i30, out out_o : i30) {
    hw.output %in_i : i30
  }
  hw.module private @prim_const(out out_o : i64) {
    %c-1_i6 = hw.constant -1 : i6
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
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i6 = hw.constant 0 : i6
    %false = hw.constant false
    %c0_i64 = hw.constant 0 : i64
    %out_o = llhd.sig %c0_i64 : i64
    %1 = llhd.sig.extract %out_o from %c0_i6 : <i64> -> <i1>
    llhd.drv %1, %false after %0 : i1
    %2 = llhd.sig.extract %out_o from %c1_i6 : <i64> -> <i1>
    llhd.drv %2, %false after %0 : i1
    %3 = llhd.sig.extract %out_o from %c2_i6 : <i64> -> <i1>
    llhd.drv %3, %false after %0 : i1
    %4 = llhd.sig.extract %out_o from %c3_i6 : <i64> -> <i1>
    llhd.drv %4, %false after %0 : i1
    %5 = llhd.sig.extract %out_o from %c4_i6 : <i64> -> <i1>
    llhd.drv %5, %false after %0 : i1
    %6 = llhd.sig.extract %out_o from %c5_i6 : <i64> -> <i1>
    llhd.drv %6, %false after %0 : i1
    %7 = llhd.sig.extract %out_o from %c6_i6 : <i64> -> <i1>
    llhd.drv %7, %false after %0 : i1
    %8 = llhd.sig.extract %out_o from %c7_i6 : <i64> -> <i1>
    llhd.drv %8, %false after %0 : i1
    %9 = llhd.sig.extract %out_o from %c8_i6 : <i64> -> <i1>
    llhd.drv %9, %false after %0 : i1
    %10 = llhd.sig.extract %out_o from %c9_i6 : <i64> -> <i1>
    llhd.drv %10, %false after %0 : i1
    %11 = llhd.sig.extract %out_o from %c10_i6 : <i64> -> <i1>
    llhd.drv %11, %false after %0 : i1
    %12 = llhd.sig.extract %out_o from %c11_i6 : <i64> -> <i1>
    llhd.drv %12, %false after %0 : i1
    %13 = llhd.sig.extract %out_o from %c12_i6 : <i64> -> <i1>
    llhd.drv %13, %false after %0 : i1
    %14 = llhd.sig.extract %out_o from %c13_i6 : <i64> -> <i1>
    llhd.drv %14, %false after %0 : i1
    %15 = llhd.sig.extract %out_o from %c14_i6 : <i64> -> <i1>
    llhd.drv %15, %false after %0 : i1
    %16 = llhd.sig.extract %out_o from %c15_i6 : <i64> -> <i1>
    llhd.drv %16, %false after %0 : i1
    %17 = llhd.sig.extract %out_o from %c16_i6 : <i64> -> <i1>
    llhd.drv %17, %false after %0 : i1
    %18 = llhd.sig.extract %out_o from %c17_i6 : <i64> -> <i1>
    llhd.drv %18, %false after %0 : i1
    %19 = llhd.sig.extract %out_o from %c18_i6 : <i64> -> <i1>
    llhd.drv %19, %false after %0 : i1
    %20 = llhd.sig.extract %out_o from %c19_i6 : <i64> -> <i1>
    llhd.drv %20, %false after %0 : i1
    %21 = llhd.sig.extract %out_o from %c20_i6 : <i64> -> <i1>
    llhd.drv %21, %false after %0 : i1
    %22 = llhd.sig.extract %out_o from %c21_i6 : <i64> -> <i1>
    llhd.drv %22, %false after %0 : i1
    %23 = llhd.sig.extract %out_o from %c22_i6 : <i64> -> <i1>
    llhd.drv %23, %false after %0 : i1
    %24 = llhd.sig.extract %out_o from %c23_i6 : <i64> -> <i1>
    llhd.drv %24, %false after %0 : i1
    %25 = llhd.sig.extract %out_o from %c24_i6 : <i64> -> <i1>
    llhd.drv %25, %false after %0 : i1
    %26 = llhd.sig.extract %out_o from %c25_i6 : <i64> -> <i1>
    llhd.drv %26, %false after %0 : i1
    %27 = llhd.sig.extract %out_o from %c26_i6 : <i64> -> <i1>
    llhd.drv %27, %false after %0 : i1
    %28 = llhd.sig.extract %out_o from %c27_i6 : <i64> -> <i1>
    llhd.drv %28, %false after %0 : i1
    %29 = llhd.sig.extract %out_o from %c28_i6 : <i64> -> <i1>
    llhd.drv %29, %false after %0 : i1
    %30 = llhd.sig.extract %out_o from %c29_i6 : <i64> -> <i1>
    llhd.drv %30, %false after %0 : i1
    %31 = llhd.sig.extract %out_o from %c30_i6 : <i64> -> <i1>
    llhd.drv %31, %false after %0 : i1
    %32 = llhd.sig.extract %out_o from %c31_i6 : <i64> -> <i1>
    llhd.drv %32, %false after %0 : i1
    %33 = llhd.sig.extract %out_o from %c-32_i6 : <i64> -> <i1>
    llhd.drv %33, %false after %0 : i1
    %34 = llhd.sig.extract %out_o from %c-31_i6 : <i64> -> <i1>
    llhd.drv %34, %false after %0 : i1
    %35 = llhd.sig.extract %out_o from %c-30_i6 : <i64> -> <i1>
    llhd.drv %35, %false after %0 : i1
    %36 = llhd.sig.extract %out_o from %c-29_i6 : <i64> -> <i1>
    llhd.drv %36, %false after %0 : i1
    %37 = llhd.sig.extract %out_o from %c-28_i6 : <i64> -> <i1>
    llhd.drv %37, %false after %0 : i1
    %38 = llhd.sig.extract %out_o from %c-27_i6 : <i64> -> <i1>
    llhd.drv %38, %false after %0 : i1
    %39 = llhd.sig.extract %out_o from %c-26_i6 : <i64> -> <i1>
    llhd.drv %39, %false after %0 : i1
    %40 = llhd.sig.extract %out_o from %c-25_i6 : <i64> -> <i1>
    llhd.drv %40, %false after %0 : i1
    %41 = llhd.sig.extract %out_o from %c-24_i6 : <i64> -> <i1>
    llhd.drv %41, %false after %0 : i1
    %42 = llhd.sig.extract %out_o from %c-23_i6 : <i64> -> <i1>
    llhd.drv %42, %false after %0 : i1
    %43 = llhd.sig.extract %out_o from %c-22_i6 : <i64> -> <i1>
    llhd.drv %43, %false after %0 : i1
    %44 = llhd.sig.extract %out_o from %c-21_i6 : <i64> -> <i1>
    llhd.drv %44, %false after %0 : i1
    %45 = llhd.sig.extract %out_o from %c-20_i6 : <i64> -> <i1>
    llhd.drv %45, %false after %0 : i1
    %46 = llhd.sig.extract %out_o from %c-19_i6 : <i64> -> <i1>
    llhd.drv %46, %false after %0 : i1
    %47 = llhd.sig.extract %out_o from %c-18_i6 : <i64> -> <i1>
    llhd.drv %47, %false after %0 : i1
    %48 = llhd.sig.extract %out_o from %c-17_i6 : <i64> -> <i1>
    llhd.drv %48, %false after %0 : i1
    %49 = llhd.sig.extract %out_o from %c-16_i6 : <i64> -> <i1>
    llhd.drv %49, %false after %0 : i1
    %50 = llhd.sig.extract %out_o from %c-15_i6 : <i64> -> <i1>
    llhd.drv %50, %false after %0 : i1
    %51 = llhd.sig.extract %out_o from %c-14_i6 : <i64> -> <i1>
    llhd.drv %51, %false after %0 : i1
    %52 = llhd.sig.extract %out_o from %c-13_i6 : <i64> -> <i1>
    llhd.drv %52, %false after %0 : i1
    %53 = llhd.sig.extract %out_o from %c-12_i6 : <i64> -> <i1>
    llhd.drv %53, %false after %0 : i1
    %54 = llhd.sig.extract %out_o from %c-11_i6 : <i64> -> <i1>
    llhd.drv %54, %false after %0 : i1
    %55 = llhd.sig.extract %out_o from %c-10_i6 : <i64> -> <i1>
    llhd.drv %55, %false after %0 : i1
    %56 = llhd.sig.extract %out_o from %c-9_i6 : <i64> -> <i1>
    llhd.drv %56, %false after %0 : i1
    %57 = llhd.sig.extract %out_o from %c-8_i6 : <i64> -> <i1>
    llhd.drv %57, %false after %0 : i1
    %58 = llhd.sig.extract %out_o from %c-7_i6 : <i64> -> <i1>
    llhd.drv %58, %false after %0 : i1
    %59 = llhd.sig.extract %out_o from %c-6_i6 : <i64> -> <i1>
    llhd.drv %59, %false after %0 : i1
    %60 = llhd.sig.extract %out_o from %c-5_i6 : <i64> -> <i1>
    llhd.drv %60, %false after %0 : i1
    %61 = llhd.sig.extract %out_o from %c-4_i6 : <i64> -> <i1>
    llhd.drv %61, %false after %0 : i1
    %62 = llhd.sig.extract %out_o from %c-3_i6 : <i64> -> <i1>
    llhd.drv %62, %false after %0 : i1
    %63 = llhd.sig.extract %out_o from %c-2_i6 : <i64> -> <i1>
    llhd.drv %63, %false after %0 : i1
    %64 = llhd.sig.extract %out_o from %c-1_i6 : <i64> -> <i1>
    llhd.drv %64, %false after %0 : i1
    %65 = llhd.prb %out_o : i64
    hw.output %65 : i64
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
  hw.module private @prim_flop_2sync_19(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %d_i_0 = llhd.sig name "d_i" %false : i1
    %d_o = llhd.sig %false : i1
    %1 = llhd.prb %d_o : i1
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_31(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i1) -> (q_o: i1) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_31(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i1) -> (q_o: i1)
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
  hw.module private @prim_flop_2sync_24(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %d_i_0 = llhd.sig name "d_i" %c0_i4 : i4
    %d_o = llhd.sig %c0_i4 : i4
    %1 = llhd.prb %d_o : i4
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_32(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i4) -> (q_o: i4) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_32(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i4) -> (q_o: i4)
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
  hw.module private @prim_flop_20(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_o : i2) {
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
  hw.module private @prim_flop_21(in %clk_i : i1, in %rst_ni : i1, in %d_i : i22, out q_o : i22) {
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
  hw.module private @prim_flop_22(in %clk_i : i1, in %rst_ni : i1, in %d_i : i22, out q_o : i22) {
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
  hw.module private @prim_flop_23(in %clk_i : i1, in %rst_ni : i1, in %d_i : i8, out q_o : i8) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i8 = hw.constant 0 : i8
    %c91_i8 = hw.constant 91 : i8
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
      llhd.drv %q_o, %c91_i8 after %1 : i8
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
  hw.module private @prim_flop_25(in %clk_i : i1, in %rst_ni : i1, in %d_i : i16, out q_o : i16) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i16 = hw.constant 0 : i16
    %c-2372_i16 = hw.constant -2372 : i16
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %d_i_2 = llhd.sig name "d_i" %c0_i16 : i16
    %q_o = llhd.sig %c0_i16 : i16
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
      llhd.drv %q_o, %c-2372_i16 after %1 : i16
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %16 = llhd.prb %d_i_2 : i16
      llhd.drv %q_o, %16 after %1 : i16
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %d_i_2, %d_i after %0 : i16
    %4 = llhd.prb %q_o : i16
    hw.output %4 : i16
  }
  hw.module private @prim_flop_26(in %clk_i : i1, in %rst_ni : i1, in %d_i : i320, out q_o : i320) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i320 = hw.constant 0 : i320
    %c-54303400856460749330691294731318814168796966260574554854209901008302709731210395309844007373990_i320 = hw.constant -54303400856460749330691294731318814168796966260574554854209901008302709731210395309844007373990 : i320
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %d_i_2 = llhd.sig name "d_i" %c0_i320 : i320
    %q_o = llhd.sig %c0_i320 : i320
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
      llhd.drv %q_o, %c-54303400856460749330691294731318814168796966260574554854209901008302709731210395309844007373990_i320 after %1 : i320
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %16 = llhd.prb %d_i_2 : i320
      llhd.drv %q_o, %16 after %1 : i320
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %d_i_2, %d_i after %0 : i320
    %4 = llhd.prb %q_o : i320
    hw.output %4 : i320
  }
  hw.module private @prim_flop_27(in %clk_i : i1, in %rst_ni : i1, in %d_i : i384, out q_o : i384) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i384 = hw.constant 0 : i384
    %c14775406613987005597957056839273030327923486421408010299430716062456368040795107685578447338622277126328287499351035_i384 = hw.constant 14775406613987005597957056839273030327923486421408010299430716062456368040795107685578447338622277126328287499351035 : i384
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %d_i_2 = llhd.sig name "d_i" %c0_i384 : i384
    %q_o = llhd.sig %c0_i384 : i384
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
      llhd.drv %q_o, %c14775406613987005597957056839273030327923486421408010299430716062456368040795107685578447338622277126328287499351035_i384 after %1 : i384
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %16 = llhd.prb %d_i_2 : i384
      llhd.drv %q_o, %16 after %1 : i384
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %d_i_2, %d_i after %0 : i384
    %4 = llhd.prb %q_o : i384
    hw.output %4 : i384
  }
  hw.module private @prim_flop_29(in %clk_i : i1, in %rst_ni : i1, in %d_i : i128, out q_o : i128) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i128 = hw.constant 0 : i128
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %d_i_2 = llhd.sig name "d_i" %c0_i128 : i128
    %q_o = llhd.sig %c0_i128 : i128
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
      llhd.drv %q_o, %c0_i128 after %1 : i128
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %16 = llhd.prb %d_i_2 : i128
      llhd.drv %q_o, %16 after %1 : i128
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %d_i_2, %d_i after %0 : i128
    %4 = llhd.prb %q_o : i128
    hw.output %4 : i128
  }
  hw.module private @prim_flop_31(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
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
  hw.module private @prim_flop_32(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
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
  hw.module private @prim_xnor2(in %in0_i : i1, in %in1_i : i1, out out_o : i1) {
    %true = hw.constant true
    %0 = comb.xor %in0_i, %in1_i, %true : i1
    hw.output %0 : i1
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
    %u_decode_ping.level_o, %u_decode_ping.rise_o, %u_decode_ping.fall_o, %u_decode_ping.event_o, %u_decode_ping.sigint_o = hw.instance "u_decode_ping" @prim_diff_decode(clk_i: %3: i1, rst_ni: %4: i1, diff_pi: %7: i1, diff_ni: %6: i1) -> (level_o: i1, rise_o: i1, fall_o: i1, event_o: i1, sigint_o: i1) {sv.namehint = "ping_event"}
    %ack_n = hw.struct_extract %alert_rx_i["ack_n"] : !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>
    %ack_p = hw.struct_extract %alert_rx_i["ack_p"] : !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>
    %8 = comb.concat %ack_n, %ack_p : i1, i1
    %u_prim_buf_ack.out_o = hw.instance "u_prim_buf_ack" @prim_sec_anchor_buf_6(in_i: %8: i2) -> (out_o: i2)
    %9 = comb.extract %u_prim_buf_ack.out_o from 1 {sv.namehint = "ack_n"} : (i2) -> i1
    %10 = comb.extract %u_prim_buf_ack.out_o from 0 {sv.namehint = "ack_p"} : (i2) -> i1
    %u_decode_ack.level_o, %u_decode_ack.rise_o, %u_decode_ack.fall_o, %u_decode_ack.event_o, %u_decode_ack.sigint_o = hw.instance "u_decode_ack" @prim_diff_decode(clk_i: %3: i1, rst_ni: %4: i1, diff_pi: %10: i1, diff_ni: %9: i1) -> (level_o: i1, rise_o: i1, fall_o: i1, event_o: i1, sigint_o: i1) {sv.namehint = "ack_sigint"}
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
    %gen_cnts_0.u_cnt_flop.q_o = hw.instance "gen_cnts_0.u_cnt_flop" @prim_flop_21(clk_i: %3: i1, rst_ni: %4: i1, d_i: %6: i22) -> (q_o: i22) {sv.namehint = "gen_cnts_0.cnt_unforced_q"}
    %7 = hw.array_get %5[%true] : !hw.array<2xi22>, i1
    %gen_cnts_1.u_cnt_flop.q_o = hw.instance "gen_cnts_1.u_cnt_flop" @prim_flop_22(clk_i: %3: i1, rst_ni: %4: i1, d_i: %7: i22) -> (q_o: i22) {sv.namehint = "gen_cnts_1.cnt_unforced_q"}
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
    %gen_async.i_sync_n.q_o = hw.instance "gen_async.i_sync_n" @prim_flop_2sync_19(clk_i: %2: i1, rst_ni: %3: i1, d_i: %diff_ni: i1) -> (q_o: i1)
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
  hw.module private @prim_diff_decode_7(in %clk_i : i1, in %rst_ni : i1, in %diff_pi : i1, in %diff_ni : i1, out level_o : i1, out rise_o : i1, out fall_o : i1, out event_o : i1, out sigint_o : i1) {
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
    %u_prim_buf_esc.out_o = hw.instance "u_prim_buf_esc" @prim_buf(in_i: %5: i2) -> (out_o: i2)
    %6 = comb.extract %u_prim_buf_esc.out_o from 1 {sv.namehint = "esc_n"} : (i2) -> i1
    %7 = comb.extract %u_prim_buf_esc.out_o from 0 {sv.namehint = "esc_p"} : (i2) -> i1
    %u_decode_esc.level_o, %u_decode_esc.rise_o, %u_decode_esc.fall_o, %u_decode_esc.event_o, %u_decode_esc.sigint_o = hw.instance "u_decode_esc" @prim_diff_decode_7(clk_i: %3: i1, rst_ni: %4: i1, diff_pi: %7: i1, diff_ni: %6: i1) -> (level_o: i1, rise_o: i1, fall_o: i1, event_o: i1, sigint_o: i1)
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
  func.func private @"prim_mubi_pkg::mubi8_test_false_loose"(%arg0: i8) -> i1 {
    %c-106_i8 = hw.constant -106 : i8
    %0 = comb.icmp ne %arg0, %c-106_i8 : i8
    return %0 : i1
  }
  hw.module private @prim_onehot_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i35, in %addr_i : i6, in %en_i : i1, out err_o : i1) {
    %c-2_i7 = hw.constant -2 : i7
    %c-3_i7 = hw.constant -3 : i7
    %c-4_i7 = hw.constant -4 : i7
    %c-5_i7 = hw.constant -5 : i7
    %c-6_i7 = hw.constant -6 : i7
    %c-7_i7 = hw.constant -7 : i7
    %c-8_i7 = hw.constant -8 : i7
    %c-9_i7 = hw.constant -9 : i7
    %c-10_i7 = hw.constant -10 : i7
    %c-11_i7 = hw.constant -11 : i7
    %c-12_i7 = hw.constant -12 : i7
    %c-13_i7 = hw.constant -13 : i7
    %c-14_i7 = hw.constant -14 : i7
    %c-15_i7 = hw.constant -15 : i7
    %c-16_i7 = hw.constant -16 : i7
    %c-17_i7 = hw.constant -17 : i7
    %c-18_i7 = hw.constant -18 : i7
    %c-19_i7 = hw.constant -19 : i7
    %c-20_i7 = hw.constant -20 : i7
    %c-21_i7 = hw.constant -21 : i7
    %c-22_i7 = hw.constant -22 : i7
    %c-23_i7 = hw.constant -23 : i7
    %c-24_i7 = hw.constant -24 : i7
    %c-25_i7 = hw.constant -25 : i7
    %c-26_i7 = hw.constant -26 : i7
    %c-27_i7 = hw.constant -27 : i7
    %c-28_i7 = hw.constant -28 : i7
    %c-29_i7 = hw.constant -29 : i7
    %c-30_i7 = hw.constant -30 : i7
    %c-31_i7 = hw.constant -31 : i7
    %c-32_i7 = hw.constant -32 : i7
    %c-33_i7 = hw.constant -33 : i7
    %c-34_i7 = hw.constant -34 : i7
    %c-35_i7 = hw.constant -35 : i7
    %c-36_i7 = hw.constant -36 : i7
    %c-37_i7 = hw.constant -37 : i7
    %c-38_i7 = hw.constant -38 : i7
    %c-39_i7 = hw.constant -39 : i7
    %c-40_i7 = hw.constant -40 : i7
    %c-41_i7 = hw.constant -41 : i7
    %c-42_i7 = hw.constant -42 : i7
    %c-43_i7 = hw.constant -43 : i7
    %c-44_i7 = hw.constant -44 : i7
    %c-45_i7 = hw.constant -45 : i7
    %c-46_i7 = hw.constant -46 : i7
    %c-47_i7 = hw.constant -47 : i7
    %c-48_i7 = hw.constant -48 : i7
    %c-49_i7 = hw.constant -49 : i7
    %c-50_i7 = hw.constant -50 : i7
    %c-51_i7 = hw.constant -51 : i7
    %c-52_i7 = hw.constant -52 : i7
    %c-53_i7 = hw.constant -53 : i7
    %c-54_i7 = hw.constant -54 : i7
    %c-55_i7 = hw.constant -55 : i7
    %c-56_i7 = hw.constant -56 : i7
    %c-57_i7 = hw.constant -57 : i7
    %c-58_i7 = hw.constant -58 : i7
    %c-59_i7 = hw.constant -59 : i7
    %c-60_i7 = hw.constant -60 : i7
    %c-61_i7 = hw.constant -61 : i7
    %c-62_i7 = hw.constant -62 : i7
    %c-63_i7 = hw.constant -63 : i7
    %c-64_i7 = hw.constant -64 : i7
    %c63_i7 = hw.constant 63 : i7
    %c62_i7 = hw.constant 62 : i7
    %c61_i7 = hw.constant 61 : i7
    %c60_i7 = hw.constant 60 : i7
    %c59_i7 = hw.constant 59 : i7
    %c58_i7 = hw.constant 58 : i7
    %c57_i7 = hw.constant 57 : i7
    %c56_i7 = hw.constant 56 : i7
    %c55_i7 = hw.constant 55 : i7
    %c54_i7 = hw.constant 54 : i7
    %c53_i7 = hw.constant 53 : i7
    %c52_i7 = hw.constant 52 : i7
    %c51_i7 = hw.constant 51 : i7
    %c50_i7 = hw.constant 50 : i7
    %c49_i7 = hw.constant 49 : i7
    %c48_i7 = hw.constant 48 : i7
    %c47_i7 = hw.constant 47 : i7
    %c46_i7 = hw.constant 46 : i7
    %c45_i7 = hw.constant 45 : i7
    %c44_i7 = hw.constant 44 : i7
    %c43_i7 = hw.constant 43 : i7
    %c42_i7 = hw.constant 42 : i7
    %c41_i7 = hw.constant 41 : i7
    %c40_i7 = hw.constant 40 : i7
    %c39_i7 = hw.constant 39 : i7
    %c38_i7 = hw.constant 38 : i7
    %c37_i7 = hw.constant 37 : i7
    %c36_i7 = hw.constant 36 : i7
    %c35_i7 = hw.constant 35 : i7
    %c34_i7 = hw.constant 34 : i7
    %c33_i7 = hw.constant 33 : i7
    %c32_i7 = hw.constant 32 : i7
    %c31_i7 = hw.constant 31 : i7
    %c30_i7 = hw.constant 30 : i7
    %c29_i7 = hw.constant 29 : i7
    %c28_i7 = hw.constant 28 : i7
    %c27_i7 = hw.constant 27 : i7
    %c26_i7 = hw.constant 26 : i7
    %c25_i7 = hw.constant 25 : i7
    %c24_i7 = hw.constant 24 : i7
    %c23_i7 = hw.constant 23 : i7
    %c22_i7 = hw.constant 22 : i7
    %c21_i7 = hw.constant 21 : i7
    %c20_i7 = hw.constant 20 : i7
    %c19_i7 = hw.constant 19 : i7
    %c18_i7 = hw.constant 18 : i7
    %c17_i7 = hw.constant 17 : i7
    %c16_i7 = hw.constant 16 : i7
    %c15_i7 = hw.constant 15 : i7
    %c14_i7 = hw.constant 14 : i7
    %c13_i7 = hw.constant 13 : i7
    %c12_i7 = hw.constant 12 : i7
    %c11_i7 = hw.constant 11 : i7
    %c10_i7 = hw.constant 10 : i7
    %c9_i7 = hw.constant 9 : i7
    %c8_i7 = hw.constant 8 : i7
    %c7_i7 = hw.constant 7 : i7
    %c6_i7 = hw.constant 6 : i7
    %c5_i7 = hw.constant 5 : i7
    %c4_i7 = hw.constant 4 : i7
    %c3_i7 = hw.constant 3 : i7
    %c2_i7 = hw.constant 2 : i7
    %c1_i7 = hw.constant 1 : i7
    %true = hw.constant true
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i7 = hw.constant 0 : i7
    %false = hw.constant false {sv.namehint = "addr_err"}
    %c0_i127 = hw.constant 0 : i127
    %or_tree = llhd.sig %c0_i127 : i127
    %and_tree = llhd.sig %c0_i127 : i127
    %err_tree = llhd.sig %c0_i127 : i127
    %1 = llhd.sig.extract %or_tree from %c0_i7 : <i127> -> <i1>
    %2 = llhd.prb %or_tree : i127
    %3 = comb.extract %2 from 1 : (i127) -> i1
    %4 = comb.extract %2 from 2 : (i127) -> i1
    %5 = comb.or %3, %4 : i1
    llhd.drv %1, %5 after %0 : i1
    %6 = llhd.sig.extract %and_tree from %c0_i7 : <i127> -> <i1>
    %7 = comb.extract %addr_i from 5 : (i6) -> i1
    %8 = comb.xor %7, %true : i1
    %9 = llhd.prb %and_tree : i127
    %10 = comb.extract %9 from 1 : (i127) -> i1
    %11 = comb.and %8, %10 : i1
    %12 = comb.extract %9 from 2 : (i127) -> i1
    %13 = comb.and %7, %12 : i1
    %14 = comb.or %11, %13 : i1
    llhd.drv %6, %14 after %0 : i1
    %15 = llhd.sig.extract %err_tree from %c0_i7 : <i127> -> <i1>
    %16 = comb.and %3, %4 : i1
    %17 = llhd.prb %err_tree : i127
    %18 = comb.extract %17 from 1 : (i127) -> i1
    %19 = comb.extract %17 from 2 : (i127) -> i1
    %20 = comb.or %16, %18, %19 : i1
    llhd.drv %15, %20 after %0 : i1
    %21 = llhd.sig.extract %or_tree from %c1_i7 : <i127> -> <i1>
    %22 = comb.extract %2 from 3 : (i127) -> i1
    %23 = comb.extract %2 from 4 : (i127) -> i1
    %24 = comb.or %22, %23 : i1
    llhd.drv %21, %24 after %0 : i1
    %25 = llhd.sig.extract %and_tree from %c1_i7 : <i127> -> <i1>
    %26 = comb.extract %addr_i from 4 : (i6) -> i1
    %27 = comb.xor %26, %true : i1
    %28 = comb.extract %9 from 3 : (i127) -> i1
    %29 = comb.and %27, %28 : i1
    %30 = comb.extract %9 from 4 : (i127) -> i1
    %31 = comb.and %26, %30 : i1
    %32 = comb.or %29, %31 : i1
    llhd.drv %25, %32 after %0 : i1
    %33 = llhd.sig.extract %err_tree from %c1_i7 : <i127> -> <i1>
    %34 = comb.and %22, %23 : i1
    %35 = comb.extract %17 from 3 : (i127) -> i1
    %36 = comb.extract %17 from 4 : (i127) -> i1
    %37 = comb.or %34, %35, %36 : i1
    llhd.drv %33, %37 after %0 : i1
    %38 = llhd.sig.extract %or_tree from %c2_i7 : <i127> -> <i1>
    %39 = comb.extract %2 from 5 : (i127) -> i1
    %40 = comb.extract %2 from 6 : (i127) -> i1
    %41 = comb.or %39, %40 : i1
    llhd.drv %38, %41 after %0 : i1
    %42 = llhd.sig.extract %and_tree from %c2_i7 : <i127> -> <i1>
    %43 = comb.extract %9 from 5 : (i127) -> i1
    %44 = comb.and %27, %43 : i1
    %45 = comb.extract %9 from 6 : (i127) -> i1
    %46 = comb.and %26, %45 : i1
    %47 = comb.or %44, %46 : i1
    llhd.drv %42, %47 after %0 : i1
    %48 = llhd.sig.extract %err_tree from %c2_i7 : <i127> -> <i1>
    %49 = comb.and %39, %40 : i1
    %50 = comb.extract %17 from 5 : (i127) -> i1
    %51 = comb.extract %17 from 6 : (i127) -> i1
    %52 = comb.or %49, %50, %51 : i1
    llhd.drv %48, %52 after %0 : i1
    %53 = llhd.sig.extract %or_tree from %c3_i7 : <i127> -> <i1>
    %54 = comb.extract %2 from 7 : (i127) -> i1
    %55 = comb.extract %2 from 8 : (i127) -> i1
    %56 = comb.or %54, %55 : i1
    llhd.drv %53, %56 after %0 : i1
    %57 = llhd.sig.extract %and_tree from %c3_i7 : <i127> -> <i1>
    %58 = comb.extract %addr_i from 3 : (i6) -> i1
    %59 = comb.xor %58, %true : i1
    %60 = comb.extract %9 from 7 : (i127) -> i1
    %61 = comb.and %59, %60 : i1
    %62 = comb.extract %9 from 8 : (i127) -> i1
    %63 = comb.and %58, %62 : i1
    %64 = comb.or %61, %63 : i1
    llhd.drv %57, %64 after %0 : i1
    %65 = llhd.sig.extract %err_tree from %c3_i7 : <i127> -> <i1>
    %66 = comb.and %54, %55 : i1
    %67 = comb.extract %17 from 7 : (i127) -> i1
    %68 = comb.extract %17 from 8 : (i127) -> i1
    %69 = comb.or %66, %67, %68 : i1
    llhd.drv %65, %69 after %0 : i1
    %70 = llhd.sig.extract %or_tree from %c4_i7 : <i127> -> <i1>
    %71 = comb.extract %2 from 9 : (i127) -> i1
    %72 = comb.extract %2 from 10 : (i127) -> i1
    %73 = comb.or %71, %72 : i1
    llhd.drv %70, %73 after %0 : i1
    %74 = llhd.sig.extract %and_tree from %c4_i7 : <i127> -> <i1>
    %75 = comb.extract %9 from 9 : (i127) -> i1
    %76 = comb.and %59, %75 : i1
    %77 = comb.extract %9 from 10 : (i127) -> i1
    %78 = comb.and %58, %77 : i1
    %79 = comb.or %76, %78 : i1
    llhd.drv %74, %79 after %0 : i1
    %80 = llhd.sig.extract %err_tree from %c4_i7 : <i127> -> <i1>
    %81 = comb.and %71, %72 : i1
    %82 = comb.extract %17 from 9 : (i127) -> i1
    %83 = comb.extract %17 from 10 : (i127) -> i1
    %84 = comb.or %81, %82, %83 : i1
    llhd.drv %80, %84 after %0 : i1
    %85 = llhd.sig.extract %or_tree from %c5_i7 : <i127> -> <i1>
    %86 = comb.extract %2 from 11 : (i127) -> i1
    %87 = comb.extract %2 from 12 : (i127) -> i1
    %88 = comb.or %86, %87 : i1
    llhd.drv %85, %88 after %0 : i1
    %89 = llhd.sig.extract %and_tree from %c5_i7 : <i127> -> <i1>
    %90 = comb.extract %9 from 11 : (i127) -> i1
    %91 = comb.and %59, %90 : i1
    %92 = comb.extract %9 from 12 : (i127) -> i1
    %93 = comb.and %58, %92 : i1
    %94 = comb.or %91, %93 : i1
    llhd.drv %89, %94 after %0 : i1
    %95 = llhd.sig.extract %err_tree from %c5_i7 : <i127> -> <i1>
    %96 = comb.and %86, %87 : i1
    %97 = comb.extract %17 from 11 : (i127) -> i1
    %98 = comb.extract %17 from 12 : (i127) -> i1
    %99 = comb.or %96, %97, %98 : i1
    llhd.drv %95, %99 after %0 : i1
    %100 = llhd.sig.extract %or_tree from %c6_i7 : <i127> -> <i1>
    %101 = comb.extract %2 from 13 : (i127) -> i1
    %102 = comb.extract %2 from 14 : (i127) -> i1
    %103 = comb.or %101, %102 : i1
    llhd.drv %100, %103 after %0 : i1
    %104 = llhd.sig.extract %and_tree from %c6_i7 : <i127> -> <i1>
    %105 = comb.extract %9 from 13 : (i127) -> i1
    %106 = comb.and %59, %105 : i1
    %107 = comb.extract %9 from 14 : (i127) -> i1
    %108 = comb.and %58, %107 : i1
    %109 = comb.or %106, %108 : i1
    llhd.drv %104, %109 after %0 : i1
    %110 = llhd.sig.extract %err_tree from %c6_i7 : <i127> -> <i1>
    %111 = comb.and %101, %102 : i1
    %112 = comb.extract %17 from 13 : (i127) -> i1
    %113 = comb.extract %17 from 14 : (i127) -> i1
    %114 = comb.or %111, %112, %113 : i1
    llhd.drv %110, %114 after %0 : i1
    %115 = llhd.sig.extract %or_tree from %c7_i7 : <i127> -> <i1>
    %116 = comb.extract %2 from 15 : (i127) -> i1
    %117 = comb.extract %2 from 16 : (i127) -> i1
    %118 = comb.or %116, %117 : i1
    llhd.drv %115, %118 after %0 : i1
    %119 = llhd.sig.extract %and_tree from %c7_i7 : <i127> -> <i1>
    %120 = comb.extract %addr_i from 2 : (i6) -> i1
    %121 = comb.xor %120, %true : i1
    %122 = comb.extract %9 from 15 : (i127) -> i1
    %123 = comb.and %121, %122 : i1
    %124 = comb.extract %9 from 16 : (i127) -> i1
    %125 = comb.and %120, %124 : i1
    %126 = comb.or %123, %125 : i1
    llhd.drv %119, %126 after %0 : i1
    %127 = llhd.sig.extract %err_tree from %c7_i7 : <i127> -> <i1>
    %128 = comb.and %116, %117 : i1
    %129 = comb.extract %17 from 15 : (i127) -> i1
    %130 = comb.extract %17 from 16 : (i127) -> i1
    %131 = comb.or %128, %129, %130 : i1
    llhd.drv %127, %131 after %0 : i1
    %132 = llhd.sig.extract %or_tree from %c8_i7 : <i127> -> <i1>
    %133 = comb.extract %2 from 17 : (i127) -> i1
    %134 = comb.extract %2 from 18 : (i127) -> i1
    %135 = comb.or %133, %134 : i1
    llhd.drv %132, %135 after %0 : i1
    %136 = llhd.sig.extract %and_tree from %c8_i7 : <i127> -> <i1>
    %137 = comb.extract %9 from 17 : (i127) -> i1
    %138 = comb.and %121, %137 : i1
    %139 = comb.extract %9 from 18 : (i127) -> i1
    %140 = comb.and %120, %139 : i1
    %141 = comb.or %138, %140 : i1
    llhd.drv %136, %141 after %0 : i1
    %142 = llhd.sig.extract %err_tree from %c8_i7 : <i127> -> <i1>
    %143 = comb.and %133, %134 : i1
    %144 = comb.extract %17 from 17 : (i127) -> i1
    %145 = comb.extract %17 from 18 : (i127) -> i1
    %146 = comb.or %143, %144, %145 : i1
    llhd.drv %142, %146 after %0 : i1
    %147 = llhd.sig.extract %or_tree from %c9_i7 : <i127> -> <i1>
    %148 = comb.extract %2 from 19 : (i127) -> i1
    %149 = comb.extract %2 from 20 : (i127) -> i1
    %150 = comb.or %148, %149 : i1
    llhd.drv %147, %150 after %0 : i1
    %151 = llhd.sig.extract %and_tree from %c9_i7 : <i127> -> <i1>
    %152 = comb.extract %9 from 19 : (i127) -> i1
    %153 = comb.and %121, %152 : i1
    %154 = comb.extract %9 from 20 : (i127) -> i1
    %155 = comb.and %120, %154 : i1
    %156 = comb.or %153, %155 : i1
    llhd.drv %151, %156 after %0 : i1
    %157 = llhd.sig.extract %err_tree from %c9_i7 : <i127> -> <i1>
    %158 = comb.and %148, %149 : i1
    %159 = comb.extract %17 from 19 : (i127) -> i1
    %160 = comb.extract %17 from 20 : (i127) -> i1
    %161 = comb.or %158, %159, %160 : i1
    llhd.drv %157, %161 after %0 : i1
    %162 = llhd.sig.extract %or_tree from %c10_i7 : <i127> -> <i1>
    %163 = comb.extract %2 from 21 : (i127) -> i1
    %164 = comb.extract %2 from 22 : (i127) -> i1
    %165 = comb.or %163, %164 : i1
    llhd.drv %162, %165 after %0 : i1
    %166 = llhd.sig.extract %and_tree from %c10_i7 : <i127> -> <i1>
    %167 = comb.extract %9 from 21 : (i127) -> i1
    %168 = comb.and %121, %167 : i1
    %169 = comb.extract %9 from 22 : (i127) -> i1
    %170 = comb.and %120, %169 : i1
    %171 = comb.or %168, %170 : i1
    llhd.drv %166, %171 after %0 : i1
    %172 = llhd.sig.extract %err_tree from %c10_i7 : <i127> -> <i1>
    %173 = comb.and %163, %164 : i1
    %174 = comb.extract %17 from 21 : (i127) -> i1
    %175 = comb.extract %17 from 22 : (i127) -> i1
    %176 = comb.or %173, %174, %175 : i1
    llhd.drv %172, %176 after %0 : i1
    %177 = llhd.sig.extract %or_tree from %c11_i7 : <i127> -> <i1>
    %178 = comb.extract %2 from 23 : (i127) -> i1
    %179 = comb.extract %2 from 24 : (i127) -> i1
    %180 = comb.or %178, %179 : i1
    llhd.drv %177, %180 after %0 : i1
    %181 = llhd.sig.extract %and_tree from %c11_i7 : <i127> -> <i1>
    %182 = comb.extract %9 from 23 : (i127) -> i1
    %183 = comb.and %121, %182 : i1
    %184 = comb.extract %9 from 24 : (i127) -> i1
    %185 = comb.and %120, %184 : i1
    %186 = comb.or %183, %185 : i1
    llhd.drv %181, %186 after %0 : i1
    %187 = llhd.sig.extract %err_tree from %c11_i7 : <i127> -> <i1>
    %188 = comb.and %178, %179 : i1
    %189 = comb.extract %17 from 23 : (i127) -> i1
    %190 = comb.extract %17 from 24 : (i127) -> i1
    %191 = comb.or %188, %189, %190 : i1
    llhd.drv %187, %191 after %0 : i1
    %192 = llhd.sig.extract %or_tree from %c12_i7 : <i127> -> <i1>
    %193 = comb.extract %2 from 25 : (i127) -> i1
    %194 = comb.extract %2 from 26 : (i127) -> i1
    %195 = comb.or %193, %194 : i1
    llhd.drv %192, %195 after %0 : i1
    %196 = llhd.sig.extract %and_tree from %c12_i7 : <i127> -> <i1>
    %197 = comb.extract %9 from 25 : (i127) -> i1
    %198 = comb.and %121, %197 : i1
    %199 = comb.extract %9 from 26 : (i127) -> i1
    %200 = comb.and %120, %199 : i1
    %201 = comb.or %198, %200 : i1
    llhd.drv %196, %201 after %0 : i1
    %202 = llhd.sig.extract %err_tree from %c12_i7 : <i127> -> <i1>
    %203 = comb.and %193, %194 : i1
    %204 = comb.extract %17 from 25 : (i127) -> i1
    %205 = comb.extract %17 from 26 : (i127) -> i1
    %206 = comb.or %203, %204, %205 : i1
    llhd.drv %202, %206 after %0 : i1
    %207 = llhd.sig.extract %or_tree from %c13_i7 : <i127> -> <i1>
    %208 = comb.extract %2 from 27 : (i127) -> i1
    %209 = comb.extract %2 from 28 : (i127) -> i1
    %210 = comb.or %208, %209 : i1
    llhd.drv %207, %210 after %0 : i1
    %211 = llhd.sig.extract %and_tree from %c13_i7 : <i127> -> <i1>
    %212 = comb.extract %9 from 27 : (i127) -> i1
    %213 = comb.and %121, %212 : i1
    %214 = comb.extract %9 from 28 : (i127) -> i1
    %215 = comb.and %120, %214 : i1
    %216 = comb.or %213, %215 : i1
    llhd.drv %211, %216 after %0 : i1
    %217 = llhd.sig.extract %err_tree from %c13_i7 : <i127> -> <i1>
    %218 = comb.and %208, %209 : i1
    %219 = comb.extract %17 from 27 : (i127) -> i1
    %220 = comb.extract %17 from 28 : (i127) -> i1
    %221 = comb.or %218, %219, %220 : i1
    llhd.drv %217, %221 after %0 : i1
    %222 = llhd.sig.extract %or_tree from %c14_i7 : <i127> -> <i1>
    %223 = comb.extract %2 from 29 : (i127) -> i1
    %224 = comb.extract %2 from 30 : (i127) -> i1
    %225 = comb.or %223, %224 : i1
    llhd.drv %222, %225 after %0 : i1
    %226 = llhd.sig.extract %and_tree from %c14_i7 : <i127> -> <i1>
    %227 = comb.extract %9 from 29 : (i127) -> i1
    %228 = comb.and %121, %227 : i1
    %229 = comb.extract %9 from 30 : (i127) -> i1
    %230 = comb.and %120, %229 : i1
    %231 = comb.or %228, %230 : i1
    llhd.drv %226, %231 after %0 : i1
    %232 = llhd.sig.extract %err_tree from %c14_i7 : <i127> -> <i1>
    %233 = comb.and %223, %224 : i1
    %234 = comb.extract %17 from 29 : (i127) -> i1
    %235 = comb.extract %17 from 30 : (i127) -> i1
    %236 = comb.or %233, %234, %235 : i1
    llhd.drv %232, %236 after %0 : i1
    %237 = llhd.sig.extract %or_tree from %c15_i7 : <i127> -> <i1>
    %238 = comb.extract %2 from 31 : (i127) -> i1
    %239 = comb.extract %2 from 32 : (i127) -> i1
    %240 = comb.or %238, %239 : i1
    llhd.drv %237, %240 after %0 : i1
    %241 = llhd.sig.extract %and_tree from %c15_i7 : <i127> -> <i1>
    %242 = comb.extract %addr_i from 1 : (i6) -> i1
    %243 = comb.xor %242, %true : i1
    %244 = comb.extract %9 from 31 : (i127) -> i1
    %245 = comb.and %243, %244 : i1
    %246 = comb.extract %9 from 32 : (i127) -> i1
    %247 = comb.and %242, %246 : i1
    %248 = comb.or %245, %247 : i1
    llhd.drv %241, %248 after %0 : i1
    %249 = llhd.sig.extract %err_tree from %c15_i7 : <i127> -> <i1>
    %250 = comb.and %238, %239 : i1
    %251 = comb.extract %17 from 31 : (i127) -> i1
    %252 = comb.extract %17 from 32 : (i127) -> i1
    %253 = comb.or %250, %251, %252 : i1
    llhd.drv %249, %253 after %0 : i1
    %254 = llhd.sig.extract %or_tree from %c16_i7 : <i127> -> <i1>
    %255 = comb.extract %2 from 33 : (i127) -> i1
    %256 = comb.extract %2 from 34 : (i127) -> i1
    %257 = comb.or %255, %256 : i1
    llhd.drv %254, %257 after %0 : i1
    %258 = llhd.sig.extract %and_tree from %c16_i7 : <i127> -> <i1>
    %259 = comb.extract %9 from 33 : (i127) -> i1
    %260 = comb.and %243, %259 : i1
    %261 = comb.extract %9 from 34 : (i127) -> i1
    %262 = comb.and %242, %261 : i1
    %263 = comb.or %260, %262 : i1
    llhd.drv %258, %263 after %0 : i1
    %264 = llhd.sig.extract %err_tree from %c16_i7 : <i127> -> <i1>
    %265 = comb.and %255, %256 : i1
    %266 = comb.extract %17 from 33 : (i127) -> i1
    %267 = comb.extract %17 from 34 : (i127) -> i1
    %268 = comb.or %265, %266, %267 : i1
    llhd.drv %264, %268 after %0 : i1
    %269 = llhd.sig.extract %or_tree from %c17_i7 : <i127> -> <i1>
    %270 = comb.extract %2 from 35 : (i127) -> i1
    %271 = comb.extract %2 from 36 : (i127) -> i1
    %272 = comb.or %270, %271 : i1
    llhd.drv %269, %272 after %0 : i1
    %273 = llhd.sig.extract %and_tree from %c17_i7 : <i127> -> <i1>
    %274 = comb.extract %9 from 35 : (i127) -> i1
    %275 = comb.and %243, %274 : i1
    %276 = comb.extract %9 from 36 : (i127) -> i1
    %277 = comb.and %242, %276 : i1
    %278 = comb.or %275, %277 : i1
    llhd.drv %273, %278 after %0 : i1
    %279 = llhd.sig.extract %err_tree from %c17_i7 : <i127> -> <i1>
    %280 = comb.and %270, %271 : i1
    %281 = comb.extract %17 from 35 : (i127) -> i1
    %282 = comb.extract %17 from 36 : (i127) -> i1
    %283 = comb.or %280, %281, %282 : i1
    llhd.drv %279, %283 after %0 : i1
    %284 = llhd.sig.extract %or_tree from %c18_i7 : <i127> -> <i1>
    %285 = comb.extract %2 from 37 : (i127) -> i1
    %286 = comb.extract %2 from 38 : (i127) -> i1
    %287 = comb.or %285, %286 : i1
    llhd.drv %284, %287 after %0 : i1
    %288 = llhd.sig.extract %and_tree from %c18_i7 : <i127> -> <i1>
    %289 = comb.extract %9 from 37 : (i127) -> i1
    %290 = comb.and %243, %289 : i1
    %291 = comb.extract %9 from 38 : (i127) -> i1
    %292 = comb.and %242, %291 : i1
    %293 = comb.or %290, %292 : i1
    llhd.drv %288, %293 after %0 : i1
    %294 = llhd.sig.extract %err_tree from %c18_i7 : <i127> -> <i1>
    %295 = comb.and %285, %286 : i1
    %296 = comb.extract %17 from 37 : (i127) -> i1
    %297 = comb.extract %17 from 38 : (i127) -> i1
    %298 = comb.or %295, %296, %297 : i1
    llhd.drv %294, %298 after %0 : i1
    %299 = llhd.sig.extract %or_tree from %c19_i7 : <i127> -> <i1>
    %300 = comb.extract %2 from 39 : (i127) -> i1
    %301 = comb.extract %2 from 40 : (i127) -> i1
    %302 = comb.or %300, %301 : i1
    llhd.drv %299, %302 after %0 : i1
    %303 = llhd.sig.extract %and_tree from %c19_i7 : <i127> -> <i1>
    %304 = comb.extract %9 from 39 : (i127) -> i1
    %305 = comb.and %243, %304 : i1
    %306 = comb.extract %9 from 40 : (i127) -> i1
    %307 = comb.and %242, %306 : i1
    %308 = comb.or %305, %307 : i1
    llhd.drv %303, %308 after %0 : i1
    %309 = llhd.sig.extract %err_tree from %c19_i7 : <i127> -> <i1>
    %310 = comb.and %300, %301 : i1
    %311 = comb.extract %17 from 39 : (i127) -> i1
    %312 = comb.extract %17 from 40 : (i127) -> i1
    %313 = comb.or %310, %311, %312 : i1
    llhd.drv %309, %313 after %0 : i1
    %314 = llhd.sig.extract %or_tree from %c20_i7 : <i127> -> <i1>
    %315 = comb.extract %2 from 41 : (i127) -> i1
    %316 = comb.extract %2 from 42 : (i127) -> i1
    %317 = comb.or %315, %316 : i1
    llhd.drv %314, %317 after %0 : i1
    %318 = llhd.sig.extract %and_tree from %c20_i7 : <i127> -> <i1>
    %319 = comb.extract %9 from 41 : (i127) -> i1
    %320 = comb.and %243, %319 : i1
    %321 = comb.extract %9 from 42 : (i127) -> i1
    %322 = comb.and %242, %321 : i1
    %323 = comb.or %320, %322 : i1
    llhd.drv %318, %323 after %0 : i1
    %324 = llhd.sig.extract %err_tree from %c20_i7 : <i127> -> <i1>
    %325 = comb.and %315, %316 : i1
    %326 = comb.extract %17 from 41 : (i127) -> i1
    %327 = comb.extract %17 from 42 : (i127) -> i1
    %328 = comb.or %325, %326, %327 : i1
    llhd.drv %324, %328 after %0 : i1
    %329 = llhd.sig.extract %or_tree from %c21_i7 : <i127> -> <i1>
    %330 = comb.extract %2 from 43 : (i127) -> i1
    %331 = comb.extract %2 from 44 : (i127) -> i1
    %332 = comb.or %330, %331 : i1
    llhd.drv %329, %332 after %0 : i1
    %333 = llhd.sig.extract %and_tree from %c21_i7 : <i127> -> <i1>
    %334 = comb.extract %9 from 43 : (i127) -> i1
    %335 = comb.and %243, %334 : i1
    %336 = comb.extract %9 from 44 : (i127) -> i1
    %337 = comb.and %242, %336 : i1
    %338 = comb.or %335, %337 : i1
    llhd.drv %333, %338 after %0 : i1
    %339 = llhd.sig.extract %err_tree from %c21_i7 : <i127> -> <i1>
    %340 = comb.and %330, %331 : i1
    %341 = comb.extract %17 from 43 : (i127) -> i1
    %342 = comb.extract %17 from 44 : (i127) -> i1
    %343 = comb.or %340, %341, %342 : i1
    llhd.drv %339, %343 after %0 : i1
    %344 = llhd.sig.extract %or_tree from %c22_i7 : <i127> -> <i1>
    %345 = comb.extract %2 from 45 : (i127) -> i1
    %346 = comb.extract %2 from 46 : (i127) -> i1
    %347 = comb.or %345, %346 : i1
    llhd.drv %344, %347 after %0 : i1
    %348 = llhd.sig.extract %and_tree from %c22_i7 : <i127> -> <i1>
    %349 = comb.extract %9 from 45 : (i127) -> i1
    %350 = comb.and %243, %349 : i1
    %351 = comb.extract %9 from 46 : (i127) -> i1
    %352 = comb.and %242, %351 : i1
    %353 = comb.or %350, %352 : i1
    llhd.drv %348, %353 after %0 : i1
    %354 = llhd.sig.extract %err_tree from %c22_i7 : <i127> -> <i1>
    %355 = comb.and %345, %346 : i1
    %356 = comb.extract %17 from 45 : (i127) -> i1
    %357 = comb.extract %17 from 46 : (i127) -> i1
    %358 = comb.or %355, %356, %357 : i1
    llhd.drv %354, %358 after %0 : i1
    %359 = llhd.sig.extract %or_tree from %c23_i7 : <i127> -> <i1>
    %360 = comb.extract %2 from 47 : (i127) -> i1
    %361 = comb.extract %2 from 48 : (i127) -> i1
    %362 = comb.or %360, %361 : i1
    llhd.drv %359, %362 after %0 : i1
    %363 = llhd.sig.extract %and_tree from %c23_i7 : <i127> -> <i1>
    %364 = comb.extract %9 from 47 : (i127) -> i1
    %365 = comb.and %243, %364 : i1
    %366 = comb.extract %9 from 48 : (i127) -> i1
    %367 = comb.and %242, %366 : i1
    %368 = comb.or %365, %367 : i1
    llhd.drv %363, %368 after %0 : i1
    %369 = llhd.sig.extract %err_tree from %c23_i7 : <i127> -> <i1>
    %370 = comb.and %360, %361 : i1
    %371 = comb.extract %17 from 47 : (i127) -> i1
    %372 = comb.extract %17 from 48 : (i127) -> i1
    %373 = comb.or %370, %371, %372 : i1
    llhd.drv %369, %373 after %0 : i1
    %374 = llhd.sig.extract %or_tree from %c24_i7 : <i127> -> <i1>
    %375 = comb.extract %2 from 49 : (i127) -> i1
    %376 = comb.extract %2 from 50 : (i127) -> i1
    %377 = comb.or %375, %376 : i1
    llhd.drv %374, %377 after %0 : i1
    %378 = llhd.sig.extract %and_tree from %c24_i7 : <i127> -> <i1>
    %379 = comb.extract %9 from 49 : (i127) -> i1
    %380 = comb.and %243, %379 : i1
    %381 = comb.extract %9 from 50 : (i127) -> i1
    %382 = comb.and %242, %381 : i1
    %383 = comb.or %380, %382 : i1
    llhd.drv %378, %383 after %0 : i1
    %384 = llhd.sig.extract %err_tree from %c24_i7 : <i127> -> <i1>
    %385 = comb.and %375, %376 : i1
    %386 = comb.extract %17 from 49 : (i127) -> i1
    %387 = comb.extract %17 from 50 : (i127) -> i1
    %388 = comb.or %385, %386, %387 : i1
    llhd.drv %384, %388 after %0 : i1
    %389 = llhd.sig.extract %or_tree from %c25_i7 : <i127> -> <i1>
    %390 = comb.extract %2 from 51 : (i127) -> i1
    %391 = comb.extract %2 from 52 : (i127) -> i1
    %392 = comb.or %390, %391 : i1
    llhd.drv %389, %392 after %0 : i1
    %393 = llhd.sig.extract %and_tree from %c25_i7 : <i127> -> <i1>
    %394 = comb.extract %9 from 51 : (i127) -> i1
    %395 = comb.and %243, %394 : i1
    %396 = comb.extract %9 from 52 : (i127) -> i1
    %397 = comb.and %242, %396 : i1
    %398 = comb.or %395, %397 : i1
    llhd.drv %393, %398 after %0 : i1
    %399 = llhd.sig.extract %err_tree from %c25_i7 : <i127> -> <i1>
    %400 = comb.and %390, %391 : i1
    %401 = comb.extract %17 from 51 : (i127) -> i1
    %402 = comb.extract %17 from 52 : (i127) -> i1
    %403 = comb.or %400, %401, %402 : i1
    llhd.drv %399, %403 after %0 : i1
    %404 = llhd.sig.extract %or_tree from %c26_i7 : <i127> -> <i1>
    %405 = comb.extract %2 from 53 : (i127) -> i1
    %406 = comb.extract %2 from 54 : (i127) -> i1
    %407 = comb.or %405, %406 : i1
    llhd.drv %404, %407 after %0 : i1
    %408 = llhd.sig.extract %and_tree from %c26_i7 : <i127> -> <i1>
    %409 = comb.extract %9 from 53 : (i127) -> i1
    %410 = comb.and %243, %409 : i1
    %411 = comb.extract %9 from 54 : (i127) -> i1
    %412 = comb.and %242, %411 : i1
    %413 = comb.or %410, %412 : i1
    llhd.drv %408, %413 after %0 : i1
    %414 = llhd.sig.extract %err_tree from %c26_i7 : <i127> -> <i1>
    %415 = comb.and %405, %406 : i1
    %416 = comb.extract %17 from 53 : (i127) -> i1
    %417 = comb.extract %17 from 54 : (i127) -> i1
    %418 = comb.or %415, %416, %417 : i1
    llhd.drv %414, %418 after %0 : i1
    %419 = llhd.sig.extract %or_tree from %c27_i7 : <i127> -> <i1>
    %420 = comb.extract %2 from 55 : (i127) -> i1
    %421 = comb.extract %2 from 56 : (i127) -> i1
    %422 = comb.or %420, %421 : i1
    llhd.drv %419, %422 after %0 : i1
    %423 = llhd.sig.extract %and_tree from %c27_i7 : <i127> -> <i1>
    %424 = comb.extract %9 from 55 : (i127) -> i1
    %425 = comb.and %243, %424 : i1
    %426 = comb.extract %9 from 56 : (i127) -> i1
    %427 = comb.and %242, %426 : i1
    %428 = comb.or %425, %427 : i1
    llhd.drv %423, %428 after %0 : i1
    %429 = llhd.sig.extract %err_tree from %c27_i7 : <i127> -> <i1>
    %430 = comb.and %420, %421 : i1
    %431 = comb.extract %17 from 55 : (i127) -> i1
    %432 = comb.extract %17 from 56 : (i127) -> i1
    %433 = comb.or %430, %431, %432 : i1
    llhd.drv %429, %433 after %0 : i1
    %434 = llhd.sig.extract %or_tree from %c28_i7 : <i127> -> <i1>
    %435 = comb.extract %2 from 57 : (i127) -> i1
    %436 = comb.extract %2 from 58 : (i127) -> i1
    %437 = comb.or %435, %436 : i1
    llhd.drv %434, %437 after %0 : i1
    %438 = llhd.sig.extract %and_tree from %c28_i7 : <i127> -> <i1>
    %439 = comb.extract %9 from 57 : (i127) -> i1
    %440 = comb.and %243, %439 : i1
    %441 = comb.extract %9 from 58 : (i127) -> i1
    %442 = comb.and %242, %441 : i1
    %443 = comb.or %440, %442 : i1
    llhd.drv %438, %443 after %0 : i1
    %444 = llhd.sig.extract %err_tree from %c28_i7 : <i127> -> <i1>
    %445 = comb.and %435, %436 : i1
    %446 = comb.extract %17 from 57 : (i127) -> i1
    %447 = comb.extract %17 from 58 : (i127) -> i1
    %448 = comb.or %445, %446, %447 : i1
    llhd.drv %444, %448 after %0 : i1
    %449 = llhd.sig.extract %or_tree from %c29_i7 : <i127> -> <i1>
    %450 = comb.extract %2 from 59 : (i127) -> i1
    %451 = comb.extract %2 from 60 : (i127) -> i1
    %452 = comb.or %450, %451 : i1
    llhd.drv %449, %452 after %0 : i1
    %453 = llhd.sig.extract %and_tree from %c29_i7 : <i127> -> <i1>
    %454 = comb.extract %9 from 59 : (i127) -> i1
    %455 = comb.and %243, %454 : i1
    %456 = comb.extract %9 from 60 : (i127) -> i1
    %457 = comb.and %242, %456 : i1
    %458 = comb.or %455, %457 : i1
    llhd.drv %453, %458 after %0 : i1
    %459 = llhd.sig.extract %err_tree from %c29_i7 : <i127> -> <i1>
    %460 = comb.and %450, %451 : i1
    %461 = comb.extract %17 from 59 : (i127) -> i1
    %462 = comb.extract %17 from 60 : (i127) -> i1
    %463 = comb.or %460, %461, %462 : i1
    llhd.drv %459, %463 after %0 : i1
    %464 = llhd.sig.extract %or_tree from %c30_i7 : <i127> -> <i1>
    %465 = comb.extract %2 from 61 : (i127) -> i1
    %466 = comb.extract %2 from 62 : (i127) -> i1
    %467 = comb.or %465, %466 : i1
    llhd.drv %464, %467 after %0 : i1
    %468 = llhd.sig.extract %and_tree from %c30_i7 : <i127> -> <i1>
    %469 = comb.extract %9 from 61 : (i127) -> i1
    %470 = comb.and %243, %469 : i1
    %471 = comb.extract %9 from 62 : (i127) -> i1
    %472 = comb.and %242, %471 : i1
    %473 = comb.or %470, %472 : i1
    llhd.drv %468, %473 after %0 : i1
    %474 = llhd.sig.extract %err_tree from %c30_i7 : <i127> -> <i1>
    %475 = comb.and %465, %466 : i1
    %476 = comb.extract %17 from 61 : (i127) -> i1
    %477 = comb.extract %17 from 62 : (i127) -> i1
    %478 = comb.or %475, %476, %477 : i1
    llhd.drv %474, %478 after %0 : i1
    %479 = llhd.sig.extract %or_tree from %c31_i7 : <i127> -> <i1>
    %480 = comb.extract %2 from 63 : (i127) -> i1
    %481 = comb.extract %2 from 64 : (i127) -> i1
    %482 = comb.or %480, %481 : i1
    llhd.drv %479, %482 after %0 : i1
    %483 = llhd.sig.extract %and_tree from %c31_i7 : <i127> -> <i1>
    %484 = comb.extract %addr_i from 0 : (i6) -> i1
    %485 = comb.xor %484, %true : i1
    %486 = comb.extract %9 from 63 : (i127) -> i1
    %487 = comb.and %485, %486 : i1
    %488 = comb.extract %9 from 64 : (i127) -> i1
    %489 = comb.and %484, %488 : i1
    %490 = comb.or %487, %489 : i1
    llhd.drv %483, %490 after %0 : i1
    %491 = llhd.sig.extract %err_tree from %c31_i7 : <i127> -> <i1>
    %492 = comb.and %480, %481 : i1
    %493 = comb.extract %17 from 63 : (i127) -> i1
    %494 = comb.extract %17 from 64 : (i127) -> i1
    %495 = comb.or %492, %493, %494 : i1
    llhd.drv %491, %495 after %0 : i1
    %496 = llhd.sig.extract %or_tree from %c32_i7 : <i127> -> <i1>
    %497 = comb.extract %2 from 65 : (i127) -> i1
    %498 = comb.extract %2 from 66 : (i127) -> i1
    %499 = comb.or %497, %498 : i1
    llhd.drv %496, %499 after %0 : i1
    %500 = llhd.sig.extract %and_tree from %c32_i7 : <i127> -> <i1>
    %501 = comb.extract %9 from 65 : (i127) -> i1
    %502 = comb.and %485, %501 : i1
    %503 = comb.extract %9 from 66 : (i127) -> i1
    %504 = comb.and %484, %503 : i1
    %505 = comb.or %502, %504 : i1
    llhd.drv %500, %505 after %0 : i1
    %506 = llhd.sig.extract %err_tree from %c32_i7 : <i127> -> <i1>
    %507 = comb.and %497, %498 : i1
    %508 = comb.extract %17 from 65 : (i127) -> i1
    %509 = comb.extract %17 from 66 : (i127) -> i1
    %510 = comb.or %507, %508, %509 : i1
    llhd.drv %506, %510 after %0 : i1
    %511 = llhd.sig.extract %or_tree from %c33_i7 : <i127> -> <i1>
    %512 = comb.extract %2 from 67 : (i127) -> i1
    %513 = comb.extract %2 from 68 : (i127) -> i1
    %514 = comb.or %512, %513 : i1
    llhd.drv %511, %514 after %0 : i1
    %515 = llhd.sig.extract %and_tree from %c33_i7 : <i127> -> <i1>
    %516 = comb.extract %9 from 67 : (i127) -> i1
    %517 = comb.and %485, %516 : i1
    %518 = comb.extract %9 from 68 : (i127) -> i1
    %519 = comb.and %484, %518 : i1
    %520 = comb.or %517, %519 : i1
    llhd.drv %515, %520 after %0 : i1
    %521 = llhd.sig.extract %err_tree from %c33_i7 : <i127> -> <i1>
    %522 = comb.and %512, %513 : i1
    %523 = comb.extract %17 from 67 : (i127) -> i1
    %524 = comb.extract %17 from 68 : (i127) -> i1
    %525 = comb.or %522, %523, %524 : i1
    llhd.drv %521, %525 after %0 : i1
    %526 = llhd.sig.extract %or_tree from %c34_i7 : <i127> -> <i1>
    %527 = comb.extract %2 from 69 : (i127) -> i1
    %528 = comb.extract %2 from 70 : (i127) -> i1
    %529 = comb.or %527, %528 : i1
    llhd.drv %526, %529 after %0 : i1
    %530 = llhd.sig.extract %and_tree from %c34_i7 : <i127> -> <i1>
    %531 = comb.extract %9 from 69 : (i127) -> i1
    %532 = comb.and %485, %531 : i1
    %533 = comb.extract %9 from 70 : (i127) -> i1
    %534 = comb.and %484, %533 : i1
    %535 = comb.or %532, %534 : i1
    llhd.drv %530, %535 after %0 : i1
    %536 = llhd.sig.extract %err_tree from %c34_i7 : <i127> -> <i1>
    %537 = comb.and %527, %528 : i1
    %538 = comb.extract %17 from 69 : (i127) -> i1
    %539 = comb.extract %17 from 70 : (i127) -> i1
    %540 = comb.or %537, %538, %539 : i1
    llhd.drv %536, %540 after %0 : i1
    %541 = llhd.sig.extract %or_tree from %c35_i7 : <i127> -> <i1>
    %542 = comb.extract %2 from 71 : (i127) -> i1
    %543 = comb.extract %2 from 72 : (i127) -> i1
    %544 = comb.or %542, %543 : i1
    llhd.drv %541, %544 after %0 : i1
    %545 = llhd.sig.extract %and_tree from %c35_i7 : <i127> -> <i1>
    %546 = comb.extract %9 from 71 : (i127) -> i1
    %547 = comb.and %485, %546 : i1
    %548 = comb.extract %9 from 72 : (i127) -> i1
    %549 = comb.and %484, %548 : i1
    %550 = comb.or %547, %549 : i1
    llhd.drv %545, %550 after %0 : i1
    %551 = llhd.sig.extract %err_tree from %c35_i7 : <i127> -> <i1>
    %552 = comb.and %542, %543 : i1
    %553 = comb.extract %17 from 71 : (i127) -> i1
    %554 = comb.extract %17 from 72 : (i127) -> i1
    %555 = comb.or %552, %553, %554 : i1
    llhd.drv %551, %555 after %0 : i1
    %556 = llhd.sig.extract %or_tree from %c36_i7 : <i127> -> <i1>
    %557 = comb.extract %2 from 73 : (i127) -> i1
    %558 = comb.extract %2 from 74 : (i127) -> i1
    %559 = comb.or %557, %558 : i1
    llhd.drv %556, %559 after %0 : i1
    %560 = llhd.sig.extract %and_tree from %c36_i7 : <i127> -> <i1>
    %561 = comb.extract %9 from 73 : (i127) -> i1
    %562 = comb.and %485, %561 : i1
    %563 = comb.extract %9 from 74 : (i127) -> i1
    %564 = comb.and %484, %563 : i1
    %565 = comb.or %562, %564 : i1
    llhd.drv %560, %565 after %0 : i1
    %566 = llhd.sig.extract %err_tree from %c36_i7 : <i127> -> <i1>
    %567 = comb.and %557, %558 : i1
    %568 = comb.extract %17 from 73 : (i127) -> i1
    %569 = comb.extract %17 from 74 : (i127) -> i1
    %570 = comb.or %567, %568, %569 : i1
    llhd.drv %566, %570 after %0 : i1
    %571 = llhd.sig.extract %or_tree from %c37_i7 : <i127> -> <i1>
    %572 = comb.extract %2 from 75 : (i127) -> i1
    %573 = comb.extract %2 from 76 : (i127) -> i1
    %574 = comb.or %572, %573 : i1
    llhd.drv %571, %574 after %0 : i1
    %575 = llhd.sig.extract %and_tree from %c37_i7 : <i127> -> <i1>
    %576 = comb.extract %9 from 75 : (i127) -> i1
    %577 = comb.and %485, %576 : i1
    %578 = comb.extract %9 from 76 : (i127) -> i1
    %579 = comb.and %484, %578 : i1
    %580 = comb.or %577, %579 : i1
    llhd.drv %575, %580 after %0 : i1
    %581 = llhd.sig.extract %err_tree from %c37_i7 : <i127> -> <i1>
    %582 = comb.and %572, %573 : i1
    %583 = comb.extract %17 from 75 : (i127) -> i1
    %584 = comb.extract %17 from 76 : (i127) -> i1
    %585 = comb.or %582, %583, %584 : i1
    llhd.drv %581, %585 after %0 : i1
    %586 = llhd.sig.extract %or_tree from %c38_i7 : <i127> -> <i1>
    %587 = comb.extract %2 from 77 : (i127) -> i1
    %588 = comb.extract %2 from 78 : (i127) -> i1
    %589 = comb.or %587, %588 : i1
    llhd.drv %586, %589 after %0 : i1
    %590 = llhd.sig.extract %and_tree from %c38_i7 : <i127> -> <i1>
    %591 = comb.extract %9 from 77 : (i127) -> i1
    %592 = comb.and %485, %591 : i1
    %593 = comb.extract %9 from 78 : (i127) -> i1
    %594 = comb.and %484, %593 : i1
    %595 = comb.or %592, %594 : i1
    llhd.drv %590, %595 after %0 : i1
    %596 = llhd.sig.extract %err_tree from %c38_i7 : <i127> -> <i1>
    %597 = comb.and %587, %588 : i1
    %598 = comb.extract %17 from 77 : (i127) -> i1
    %599 = comb.extract %17 from 78 : (i127) -> i1
    %600 = comb.or %597, %598, %599 : i1
    llhd.drv %596, %600 after %0 : i1
    %601 = llhd.sig.extract %or_tree from %c39_i7 : <i127> -> <i1>
    %602 = comb.extract %2 from 79 : (i127) -> i1
    %603 = comb.extract %2 from 80 : (i127) -> i1
    %604 = comb.or %602, %603 : i1
    llhd.drv %601, %604 after %0 : i1
    %605 = llhd.sig.extract %and_tree from %c39_i7 : <i127> -> <i1>
    %606 = comb.extract %9 from 79 : (i127) -> i1
    %607 = comb.and %485, %606 : i1
    %608 = comb.extract %9 from 80 : (i127) -> i1
    %609 = comb.and %484, %608 : i1
    %610 = comb.or %607, %609 : i1
    llhd.drv %605, %610 after %0 : i1
    %611 = llhd.sig.extract %err_tree from %c39_i7 : <i127> -> <i1>
    %612 = comb.and %602, %603 : i1
    %613 = comb.extract %17 from 79 : (i127) -> i1
    %614 = comb.extract %17 from 80 : (i127) -> i1
    %615 = comb.or %612, %613, %614 : i1
    llhd.drv %611, %615 after %0 : i1
    %616 = llhd.sig.extract %or_tree from %c40_i7 : <i127> -> <i1>
    %617 = comb.extract %2 from 81 : (i127) -> i1
    %618 = comb.extract %2 from 82 : (i127) -> i1
    %619 = comb.or %617, %618 : i1
    llhd.drv %616, %619 after %0 : i1
    %620 = llhd.sig.extract %and_tree from %c40_i7 : <i127> -> <i1>
    %621 = comb.extract %9 from 81 : (i127) -> i1
    %622 = comb.and %485, %621 : i1
    %623 = comb.extract %9 from 82 : (i127) -> i1
    %624 = comb.and %484, %623 : i1
    %625 = comb.or %622, %624 : i1
    llhd.drv %620, %625 after %0 : i1
    %626 = llhd.sig.extract %err_tree from %c40_i7 : <i127> -> <i1>
    %627 = comb.and %617, %618 : i1
    %628 = comb.extract %17 from 81 : (i127) -> i1
    %629 = comb.extract %17 from 82 : (i127) -> i1
    %630 = comb.or %627, %628, %629 : i1
    llhd.drv %626, %630 after %0 : i1
    %631 = llhd.sig.extract %or_tree from %c41_i7 : <i127> -> <i1>
    %632 = comb.extract %2 from 83 : (i127) -> i1
    %633 = comb.extract %2 from 84 : (i127) -> i1
    %634 = comb.or %632, %633 : i1
    llhd.drv %631, %634 after %0 : i1
    %635 = llhd.sig.extract %and_tree from %c41_i7 : <i127> -> <i1>
    %636 = comb.extract %9 from 83 : (i127) -> i1
    %637 = comb.and %485, %636 : i1
    %638 = comb.extract %9 from 84 : (i127) -> i1
    %639 = comb.and %484, %638 : i1
    %640 = comb.or %637, %639 : i1
    llhd.drv %635, %640 after %0 : i1
    %641 = llhd.sig.extract %err_tree from %c41_i7 : <i127> -> <i1>
    %642 = comb.and %632, %633 : i1
    %643 = comb.extract %17 from 83 : (i127) -> i1
    %644 = comb.extract %17 from 84 : (i127) -> i1
    %645 = comb.or %642, %643, %644 : i1
    llhd.drv %641, %645 after %0 : i1
    %646 = llhd.sig.extract %or_tree from %c42_i7 : <i127> -> <i1>
    %647 = comb.extract %2 from 85 : (i127) -> i1
    %648 = comb.extract %2 from 86 : (i127) -> i1
    %649 = comb.or %647, %648 : i1
    llhd.drv %646, %649 after %0 : i1
    %650 = llhd.sig.extract %and_tree from %c42_i7 : <i127> -> <i1>
    %651 = comb.extract %9 from 85 : (i127) -> i1
    %652 = comb.and %485, %651 : i1
    %653 = comb.extract %9 from 86 : (i127) -> i1
    %654 = comb.and %484, %653 : i1
    %655 = comb.or %652, %654 : i1
    llhd.drv %650, %655 after %0 : i1
    %656 = llhd.sig.extract %err_tree from %c42_i7 : <i127> -> <i1>
    %657 = comb.and %647, %648 : i1
    %658 = comb.extract %17 from 85 : (i127) -> i1
    %659 = comb.extract %17 from 86 : (i127) -> i1
    %660 = comb.or %657, %658, %659 : i1
    llhd.drv %656, %660 after %0 : i1
    %661 = llhd.sig.extract %or_tree from %c43_i7 : <i127> -> <i1>
    %662 = comb.extract %2 from 87 : (i127) -> i1
    %663 = comb.extract %2 from 88 : (i127) -> i1
    %664 = comb.or %662, %663 : i1
    llhd.drv %661, %664 after %0 : i1
    %665 = llhd.sig.extract %and_tree from %c43_i7 : <i127> -> <i1>
    %666 = comb.extract %9 from 87 : (i127) -> i1
    %667 = comb.and %485, %666 : i1
    %668 = comb.extract %9 from 88 : (i127) -> i1
    %669 = comb.and %484, %668 : i1
    %670 = comb.or %667, %669 : i1
    llhd.drv %665, %670 after %0 : i1
    %671 = llhd.sig.extract %err_tree from %c43_i7 : <i127> -> <i1>
    %672 = comb.and %662, %663 : i1
    %673 = comb.extract %17 from 87 : (i127) -> i1
    %674 = comb.extract %17 from 88 : (i127) -> i1
    %675 = comb.or %672, %673, %674 : i1
    llhd.drv %671, %675 after %0 : i1
    %676 = llhd.sig.extract %or_tree from %c44_i7 : <i127> -> <i1>
    %677 = comb.extract %2 from 89 : (i127) -> i1
    %678 = comb.extract %2 from 90 : (i127) -> i1
    %679 = comb.or %677, %678 : i1
    llhd.drv %676, %679 after %0 : i1
    %680 = llhd.sig.extract %and_tree from %c44_i7 : <i127> -> <i1>
    %681 = comb.extract %9 from 89 : (i127) -> i1
    %682 = comb.and %485, %681 : i1
    %683 = comb.extract %9 from 90 : (i127) -> i1
    %684 = comb.and %484, %683 : i1
    %685 = comb.or %682, %684 : i1
    llhd.drv %680, %685 after %0 : i1
    %686 = llhd.sig.extract %err_tree from %c44_i7 : <i127> -> <i1>
    %687 = comb.and %677, %678 : i1
    %688 = comb.extract %17 from 89 : (i127) -> i1
    %689 = comb.extract %17 from 90 : (i127) -> i1
    %690 = comb.or %687, %688, %689 : i1
    llhd.drv %686, %690 after %0 : i1
    %691 = llhd.sig.extract %or_tree from %c45_i7 : <i127> -> <i1>
    %692 = comb.extract %2 from 91 : (i127) -> i1
    %693 = comb.extract %2 from 92 : (i127) -> i1
    %694 = comb.or %692, %693 : i1
    llhd.drv %691, %694 after %0 : i1
    %695 = llhd.sig.extract %and_tree from %c45_i7 : <i127> -> <i1>
    %696 = comb.extract %9 from 91 : (i127) -> i1
    %697 = comb.and %485, %696 : i1
    %698 = comb.extract %9 from 92 : (i127) -> i1
    %699 = comb.and %484, %698 : i1
    %700 = comb.or %697, %699 : i1
    llhd.drv %695, %700 after %0 : i1
    %701 = llhd.sig.extract %err_tree from %c45_i7 : <i127> -> <i1>
    %702 = comb.and %692, %693 : i1
    %703 = comb.extract %17 from 91 : (i127) -> i1
    %704 = comb.extract %17 from 92 : (i127) -> i1
    %705 = comb.or %702, %703, %704 : i1
    llhd.drv %701, %705 after %0 : i1
    %706 = llhd.sig.extract %or_tree from %c46_i7 : <i127> -> <i1>
    %707 = comb.extract %2 from 93 : (i127) -> i1
    %708 = comb.extract %2 from 94 : (i127) -> i1
    %709 = comb.or %707, %708 : i1
    llhd.drv %706, %709 after %0 : i1
    %710 = llhd.sig.extract %and_tree from %c46_i7 : <i127> -> <i1>
    %711 = comb.extract %9 from 93 : (i127) -> i1
    %712 = comb.and %485, %711 : i1
    %713 = comb.extract %9 from 94 : (i127) -> i1
    %714 = comb.and %484, %713 : i1
    %715 = comb.or %712, %714 : i1
    llhd.drv %710, %715 after %0 : i1
    %716 = llhd.sig.extract %err_tree from %c46_i7 : <i127> -> <i1>
    %717 = comb.and %707, %708 : i1
    %718 = comb.extract %17 from 93 : (i127) -> i1
    %719 = comb.extract %17 from 94 : (i127) -> i1
    %720 = comb.or %717, %718, %719 : i1
    llhd.drv %716, %720 after %0 : i1
    %721 = llhd.sig.extract %or_tree from %c47_i7 : <i127> -> <i1>
    %722 = comb.extract %2 from 95 : (i127) -> i1
    %723 = comb.extract %2 from 96 : (i127) -> i1
    %724 = comb.or %722, %723 : i1
    llhd.drv %721, %724 after %0 : i1
    %725 = llhd.sig.extract %and_tree from %c47_i7 : <i127> -> <i1>
    %726 = comb.extract %9 from 95 : (i127) -> i1
    %727 = comb.and %485, %726 : i1
    %728 = comb.extract %9 from 96 : (i127) -> i1
    %729 = comb.and %484, %728 : i1
    %730 = comb.or %727, %729 : i1
    llhd.drv %725, %730 after %0 : i1
    %731 = llhd.sig.extract %err_tree from %c47_i7 : <i127> -> <i1>
    %732 = comb.and %722, %723 : i1
    %733 = comb.extract %17 from 95 : (i127) -> i1
    %734 = comb.extract %17 from 96 : (i127) -> i1
    %735 = comb.or %732, %733, %734 : i1
    llhd.drv %731, %735 after %0 : i1
    %736 = llhd.sig.extract %or_tree from %c48_i7 : <i127> -> <i1>
    %737 = comb.extract %2 from 97 : (i127) -> i1
    %738 = comb.extract %2 from 98 : (i127) -> i1
    %739 = comb.or %737, %738 : i1
    llhd.drv %736, %739 after %0 : i1
    %740 = llhd.sig.extract %and_tree from %c48_i7 : <i127> -> <i1>
    %741 = comb.extract %9 from 97 : (i127) -> i1
    %742 = comb.and %485, %741 : i1
    %743 = comb.extract %9 from 98 : (i127) -> i1
    %744 = comb.and %484, %743 : i1
    %745 = comb.or %742, %744 : i1
    llhd.drv %740, %745 after %0 : i1
    %746 = llhd.sig.extract %err_tree from %c48_i7 : <i127> -> <i1>
    %747 = comb.and %737, %738 : i1
    %748 = comb.extract %17 from 97 : (i127) -> i1
    %749 = comb.extract %17 from 98 : (i127) -> i1
    %750 = comb.or %747, %748, %749 : i1
    llhd.drv %746, %750 after %0 : i1
    %751 = llhd.sig.extract %or_tree from %c49_i7 : <i127> -> <i1>
    %752 = comb.extract %2 from 99 : (i127) -> i1
    %753 = comb.extract %2 from 100 : (i127) -> i1
    %754 = comb.or %752, %753 : i1
    llhd.drv %751, %754 after %0 : i1
    %755 = llhd.sig.extract %and_tree from %c49_i7 : <i127> -> <i1>
    %756 = comb.extract %9 from 99 : (i127) -> i1
    %757 = comb.and %485, %756 : i1
    %758 = comb.extract %9 from 100 : (i127) -> i1
    %759 = comb.and %484, %758 : i1
    %760 = comb.or %757, %759 : i1
    llhd.drv %755, %760 after %0 : i1
    %761 = llhd.sig.extract %err_tree from %c49_i7 : <i127> -> <i1>
    %762 = comb.and %752, %753 : i1
    %763 = comb.extract %17 from 99 : (i127) -> i1
    %764 = comb.extract %17 from 100 : (i127) -> i1
    %765 = comb.or %762, %763, %764 : i1
    llhd.drv %761, %765 after %0 : i1
    %766 = llhd.sig.extract %or_tree from %c50_i7 : <i127> -> <i1>
    %767 = comb.extract %2 from 101 : (i127) -> i1
    %768 = comb.extract %2 from 102 : (i127) -> i1
    %769 = comb.or %767, %768 : i1
    llhd.drv %766, %769 after %0 : i1
    %770 = llhd.sig.extract %and_tree from %c50_i7 : <i127> -> <i1>
    %771 = comb.extract %9 from 101 : (i127) -> i1
    %772 = comb.and %485, %771 : i1
    %773 = comb.extract %9 from 102 : (i127) -> i1
    %774 = comb.and %484, %773 : i1
    %775 = comb.or %772, %774 : i1
    llhd.drv %770, %775 after %0 : i1
    %776 = llhd.sig.extract %err_tree from %c50_i7 : <i127> -> <i1>
    %777 = comb.and %767, %768 : i1
    %778 = comb.extract %17 from 101 : (i127) -> i1
    %779 = comb.extract %17 from 102 : (i127) -> i1
    %780 = comb.or %777, %778, %779 : i1
    llhd.drv %776, %780 after %0 : i1
    %781 = llhd.sig.extract %or_tree from %c51_i7 : <i127> -> <i1>
    %782 = comb.extract %2 from 103 : (i127) -> i1
    %783 = comb.extract %2 from 104 : (i127) -> i1
    %784 = comb.or %782, %783 : i1
    llhd.drv %781, %784 after %0 : i1
    %785 = llhd.sig.extract %and_tree from %c51_i7 : <i127> -> <i1>
    %786 = comb.extract %9 from 103 : (i127) -> i1
    %787 = comb.and %485, %786 : i1
    %788 = comb.extract %9 from 104 : (i127) -> i1
    %789 = comb.and %484, %788 : i1
    %790 = comb.or %787, %789 : i1
    llhd.drv %785, %790 after %0 : i1
    %791 = llhd.sig.extract %err_tree from %c51_i7 : <i127> -> <i1>
    %792 = comb.and %782, %783 : i1
    %793 = comb.extract %17 from 103 : (i127) -> i1
    %794 = comb.extract %17 from 104 : (i127) -> i1
    %795 = comb.or %792, %793, %794 : i1
    llhd.drv %791, %795 after %0 : i1
    %796 = llhd.sig.extract %or_tree from %c52_i7 : <i127> -> <i1>
    %797 = comb.extract %2 from 105 : (i127) -> i1
    %798 = comb.extract %2 from 106 : (i127) -> i1
    %799 = comb.or %797, %798 : i1
    llhd.drv %796, %799 after %0 : i1
    %800 = llhd.sig.extract %and_tree from %c52_i7 : <i127> -> <i1>
    %801 = comb.extract %9 from 105 : (i127) -> i1
    %802 = comb.and %485, %801 : i1
    %803 = comb.extract %9 from 106 : (i127) -> i1
    %804 = comb.and %484, %803 : i1
    %805 = comb.or %802, %804 : i1
    llhd.drv %800, %805 after %0 : i1
    %806 = llhd.sig.extract %err_tree from %c52_i7 : <i127> -> <i1>
    %807 = comb.and %797, %798 : i1
    %808 = comb.extract %17 from 105 : (i127) -> i1
    %809 = comb.extract %17 from 106 : (i127) -> i1
    %810 = comb.or %807, %808, %809 : i1
    llhd.drv %806, %810 after %0 : i1
    %811 = llhd.sig.extract %or_tree from %c53_i7 : <i127> -> <i1>
    %812 = comb.extract %2 from 107 : (i127) -> i1
    %813 = comb.extract %2 from 108 : (i127) -> i1
    %814 = comb.or %812, %813 : i1
    llhd.drv %811, %814 after %0 : i1
    %815 = llhd.sig.extract %and_tree from %c53_i7 : <i127> -> <i1>
    %816 = comb.extract %9 from 107 : (i127) -> i1
    %817 = comb.and %485, %816 : i1
    %818 = comb.extract %9 from 108 : (i127) -> i1
    %819 = comb.and %484, %818 : i1
    %820 = comb.or %817, %819 : i1
    llhd.drv %815, %820 after %0 : i1
    %821 = llhd.sig.extract %err_tree from %c53_i7 : <i127> -> <i1>
    %822 = comb.and %812, %813 : i1
    %823 = comb.extract %17 from 107 : (i127) -> i1
    %824 = comb.extract %17 from 108 : (i127) -> i1
    %825 = comb.or %822, %823, %824 : i1
    llhd.drv %821, %825 after %0 : i1
    %826 = llhd.sig.extract %or_tree from %c54_i7 : <i127> -> <i1>
    %827 = comb.extract %2 from 109 : (i127) -> i1
    %828 = comb.extract %2 from 110 : (i127) -> i1
    %829 = comb.or %827, %828 : i1
    llhd.drv %826, %829 after %0 : i1
    %830 = llhd.sig.extract %and_tree from %c54_i7 : <i127> -> <i1>
    %831 = comb.extract %9 from 109 : (i127) -> i1
    %832 = comb.and %485, %831 : i1
    %833 = comb.extract %9 from 110 : (i127) -> i1
    %834 = comb.and %484, %833 : i1
    %835 = comb.or %832, %834 : i1
    llhd.drv %830, %835 after %0 : i1
    %836 = llhd.sig.extract %err_tree from %c54_i7 : <i127> -> <i1>
    %837 = comb.and %827, %828 : i1
    %838 = comb.extract %17 from 109 : (i127) -> i1
    %839 = comb.extract %17 from 110 : (i127) -> i1
    %840 = comb.or %837, %838, %839 : i1
    llhd.drv %836, %840 after %0 : i1
    %841 = llhd.sig.extract %or_tree from %c55_i7 : <i127> -> <i1>
    %842 = comb.extract %2 from 111 : (i127) -> i1
    %843 = comb.extract %2 from 112 : (i127) -> i1
    %844 = comb.or %842, %843 : i1
    llhd.drv %841, %844 after %0 : i1
    %845 = llhd.sig.extract %and_tree from %c55_i7 : <i127> -> <i1>
    %846 = comb.extract %9 from 111 : (i127) -> i1
    %847 = comb.and %485, %846 : i1
    %848 = comb.extract %9 from 112 : (i127) -> i1
    %849 = comb.and %484, %848 : i1
    %850 = comb.or %847, %849 : i1
    llhd.drv %845, %850 after %0 : i1
    %851 = llhd.sig.extract %err_tree from %c55_i7 : <i127> -> <i1>
    %852 = comb.and %842, %843 : i1
    %853 = comb.extract %17 from 111 : (i127) -> i1
    %854 = comb.extract %17 from 112 : (i127) -> i1
    %855 = comb.or %852, %853, %854 : i1
    llhd.drv %851, %855 after %0 : i1
    %856 = llhd.sig.extract %or_tree from %c56_i7 : <i127> -> <i1>
    %857 = comb.extract %2 from 113 : (i127) -> i1
    %858 = comb.extract %2 from 114 : (i127) -> i1
    %859 = comb.or %857, %858 : i1
    llhd.drv %856, %859 after %0 : i1
    %860 = llhd.sig.extract %and_tree from %c56_i7 : <i127> -> <i1>
    %861 = comb.extract %9 from 113 : (i127) -> i1
    %862 = comb.and %485, %861 : i1
    %863 = comb.extract %9 from 114 : (i127) -> i1
    %864 = comb.and %484, %863 : i1
    %865 = comb.or %862, %864 : i1
    llhd.drv %860, %865 after %0 : i1
    %866 = llhd.sig.extract %err_tree from %c56_i7 : <i127> -> <i1>
    %867 = comb.and %857, %858 : i1
    %868 = comb.extract %17 from 113 : (i127) -> i1
    %869 = comb.extract %17 from 114 : (i127) -> i1
    %870 = comb.or %867, %868, %869 : i1
    llhd.drv %866, %870 after %0 : i1
    %871 = llhd.sig.extract %or_tree from %c57_i7 : <i127> -> <i1>
    %872 = comb.extract %2 from 115 : (i127) -> i1
    %873 = comb.extract %2 from 116 : (i127) -> i1
    %874 = comb.or %872, %873 : i1
    llhd.drv %871, %874 after %0 : i1
    %875 = llhd.sig.extract %and_tree from %c57_i7 : <i127> -> <i1>
    %876 = comb.extract %9 from 115 : (i127) -> i1
    %877 = comb.and %485, %876 : i1
    %878 = comb.extract %9 from 116 : (i127) -> i1
    %879 = comb.and %484, %878 : i1
    %880 = comb.or %877, %879 : i1
    llhd.drv %875, %880 after %0 : i1
    %881 = llhd.sig.extract %err_tree from %c57_i7 : <i127> -> <i1>
    %882 = comb.and %872, %873 : i1
    %883 = comb.extract %17 from 115 : (i127) -> i1
    %884 = comb.extract %17 from 116 : (i127) -> i1
    %885 = comb.or %882, %883, %884 : i1
    llhd.drv %881, %885 after %0 : i1
    %886 = llhd.sig.extract %or_tree from %c58_i7 : <i127> -> <i1>
    %887 = comb.extract %2 from 117 : (i127) -> i1
    %888 = comb.extract %2 from 118 : (i127) -> i1
    %889 = comb.or %887, %888 : i1
    llhd.drv %886, %889 after %0 : i1
    %890 = llhd.sig.extract %and_tree from %c58_i7 : <i127> -> <i1>
    %891 = comb.extract %9 from 117 : (i127) -> i1
    %892 = comb.and %485, %891 : i1
    %893 = comb.extract %9 from 118 : (i127) -> i1
    %894 = comb.and %484, %893 : i1
    %895 = comb.or %892, %894 : i1
    llhd.drv %890, %895 after %0 : i1
    %896 = llhd.sig.extract %err_tree from %c58_i7 : <i127> -> <i1>
    %897 = comb.and %887, %888 : i1
    %898 = comb.extract %17 from 117 : (i127) -> i1
    %899 = comb.extract %17 from 118 : (i127) -> i1
    %900 = comb.or %897, %898, %899 : i1
    llhd.drv %896, %900 after %0 : i1
    %901 = llhd.sig.extract %or_tree from %c59_i7 : <i127> -> <i1>
    %902 = comb.extract %2 from 119 : (i127) -> i1
    %903 = comb.extract %2 from 120 : (i127) -> i1
    %904 = comb.or %902, %903 : i1
    llhd.drv %901, %904 after %0 : i1
    %905 = llhd.sig.extract %and_tree from %c59_i7 : <i127> -> <i1>
    %906 = comb.extract %9 from 119 : (i127) -> i1
    %907 = comb.and %485, %906 : i1
    %908 = comb.extract %9 from 120 : (i127) -> i1
    %909 = comb.and %484, %908 : i1
    %910 = comb.or %907, %909 : i1
    llhd.drv %905, %910 after %0 : i1
    %911 = llhd.sig.extract %err_tree from %c59_i7 : <i127> -> <i1>
    %912 = comb.and %902, %903 : i1
    %913 = comb.extract %17 from 119 : (i127) -> i1
    %914 = comb.extract %17 from 120 : (i127) -> i1
    %915 = comb.or %912, %913, %914 : i1
    llhd.drv %911, %915 after %0 : i1
    %916 = llhd.sig.extract %or_tree from %c60_i7 : <i127> -> <i1>
    %917 = comb.extract %2 from 121 : (i127) -> i1
    %918 = comb.extract %2 from 122 : (i127) -> i1
    %919 = comb.or %917, %918 : i1
    llhd.drv %916, %919 after %0 : i1
    %920 = llhd.sig.extract %and_tree from %c60_i7 : <i127> -> <i1>
    %921 = comb.extract %9 from 121 : (i127) -> i1
    %922 = comb.and %485, %921 : i1
    %923 = comb.extract %9 from 122 : (i127) -> i1
    %924 = comb.and %484, %923 : i1
    %925 = comb.or %922, %924 : i1
    llhd.drv %920, %925 after %0 : i1
    %926 = llhd.sig.extract %err_tree from %c60_i7 : <i127> -> <i1>
    %927 = comb.and %917, %918 : i1
    %928 = comb.extract %17 from 121 : (i127) -> i1
    %929 = comb.extract %17 from 122 : (i127) -> i1
    %930 = comb.or %927, %928, %929 : i1
    llhd.drv %926, %930 after %0 : i1
    %931 = llhd.sig.extract %or_tree from %c61_i7 : <i127> -> <i1>
    %932 = comb.extract %2 from 123 : (i127) -> i1
    %933 = comb.extract %2 from 124 : (i127) -> i1
    %934 = comb.or %932, %933 : i1
    llhd.drv %931, %934 after %0 : i1
    %935 = llhd.sig.extract %and_tree from %c61_i7 : <i127> -> <i1>
    %936 = comb.extract %9 from 123 : (i127) -> i1
    %937 = comb.and %485, %936 : i1
    %938 = comb.extract %9 from 124 : (i127) -> i1
    %939 = comb.and %484, %938 : i1
    %940 = comb.or %937, %939 : i1
    llhd.drv %935, %940 after %0 : i1
    %941 = llhd.sig.extract %err_tree from %c61_i7 : <i127> -> <i1>
    %942 = comb.and %932, %933 : i1
    %943 = comb.extract %17 from 123 : (i127) -> i1
    %944 = comb.extract %17 from 124 : (i127) -> i1
    %945 = comb.or %942, %943, %944 : i1
    llhd.drv %941, %945 after %0 : i1
    %946 = llhd.sig.extract %or_tree from %c62_i7 : <i127> -> <i1>
    %947 = comb.extract %2 from 125 : (i127) -> i1
    %948 = comb.extract %2 from 126 : (i127) -> i1
    %949 = comb.or %947, %948 : i1
    llhd.drv %946, %949 after %0 : i1
    %950 = llhd.sig.extract %and_tree from %c62_i7 : <i127> -> <i1>
    %951 = comb.extract %9 from 125 : (i127) -> i1
    %952 = comb.and %485, %951 : i1
    %953 = comb.extract %9 from 126 : (i127) -> i1
    %954 = comb.and %484, %953 : i1
    %955 = comb.or %952, %954 : i1
    llhd.drv %950, %955 after %0 : i1
    %956 = llhd.sig.extract %err_tree from %c62_i7 : <i127> -> <i1>
    %957 = comb.and %947, %948 : i1
    %958 = comb.extract %17 from 125 : (i127) -> i1
    %959 = comb.extract %17 from 126 : (i127) -> i1
    %960 = comb.or %957, %958, %959 : i1
    llhd.drv %956, %960 after %0 : i1
    %961 = llhd.sig.extract %or_tree from %c63_i7 : <i127> -> <i1>
    %962 = comb.extract %oh_i from 0 : (i35) -> i1
    llhd.drv %961, %962 after %0 : i1
    %963 = llhd.sig.extract %and_tree from %c63_i7 : <i127> -> <i1>
    llhd.drv %963, %962 after %0 : i1
    %964 = llhd.sig.extract %err_tree from %c63_i7 : <i127> -> <i1>
    llhd.drv %964, %false after %0 : i1
    %965 = llhd.sig.extract %or_tree from %c-64_i7 : <i127> -> <i1>
    %966 = comb.extract %oh_i from 1 : (i35) -> i1
    llhd.drv %965, %966 after %0 : i1
    %967 = llhd.sig.extract %and_tree from %c-64_i7 : <i127> -> <i1>
    llhd.drv %967, %966 after %0 : i1
    %968 = llhd.sig.extract %err_tree from %c-64_i7 : <i127> -> <i1>
    llhd.drv %968, %false after %0 : i1
    %969 = llhd.sig.extract %or_tree from %c-63_i7 : <i127> -> <i1>
    %970 = comb.extract %oh_i from 2 : (i35) -> i1
    llhd.drv %969, %970 after %0 : i1
    %971 = llhd.sig.extract %and_tree from %c-63_i7 : <i127> -> <i1>
    llhd.drv %971, %970 after %0 : i1
    %972 = llhd.sig.extract %err_tree from %c-63_i7 : <i127> -> <i1>
    llhd.drv %972, %false after %0 : i1
    %973 = llhd.sig.extract %or_tree from %c-62_i7 : <i127> -> <i1>
    %974 = comb.extract %oh_i from 3 : (i35) -> i1
    llhd.drv %973, %974 after %0 : i1
    %975 = llhd.sig.extract %and_tree from %c-62_i7 : <i127> -> <i1>
    llhd.drv %975, %974 after %0 : i1
    %976 = llhd.sig.extract %err_tree from %c-62_i7 : <i127> -> <i1>
    llhd.drv %976, %false after %0 : i1
    %977 = llhd.sig.extract %or_tree from %c-61_i7 : <i127> -> <i1>
    %978 = comb.extract %oh_i from 4 : (i35) -> i1
    llhd.drv %977, %978 after %0 : i1
    %979 = llhd.sig.extract %and_tree from %c-61_i7 : <i127> -> <i1>
    llhd.drv %979, %978 after %0 : i1
    %980 = llhd.sig.extract %err_tree from %c-61_i7 : <i127> -> <i1>
    llhd.drv %980, %false after %0 : i1
    %981 = llhd.sig.extract %or_tree from %c-60_i7 : <i127> -> <i1>
    %982 = comb.extract %oh_i from 5 : (i35) -> i1
    llhd.drv %981, %982 after %0 : i1
    %983 = llhd.sig.extract %and_tree from %c-60_i7 : <i127> -> <i1>
    llhd.drv %983, %982 after %0 : i1
    %984 = llhd.sig.extract %err_tree from %c-60_i7 : <i127> -> <i1>
    llhd.drv %984, %false after %0 : i1
    %985 = llhd.sig.extract %or_tree from %c-59_i7 : <i127> -> <i1>
    %986 = comb.extract %oh_i from 6 : (i35) -> i1
    llhd.drv %985, %986 after %0 : i1
    %987 = llhd.sig.extract %and_tree from %c-59_i7 : <i127> -> <i1>
    llhd.drv %987, %986 after %0 : i1
    %988 = llhd.sig.extract %err_tree from %c-59_i7 : <i127> -> <i1>
    llhd.drv %988, %false after %0 : i1
    %989 = llhd.sig.extract %or_tree from %c-58_i7 : <i127> -> <i1>
    %990 = comb.extract %oh_i from 7 : (i35) -> i1
    llhd.drv %989, %990 after %0 : i1
    %991 = llhd.sig.extract %and_tree from %c-58_i7 : <i127> -> <i1>
    llhd.drv %991, %990 after %0 : i1
    %992 = llhd.sig.extract %err_tree from %c-58_i7 : <i127> -> <i1>
    llhd.drv %992, %false after %0 : i1
    %993 = llhd.sig.extract %or_tree from %c-57_i7 : <i127> -> <i1>
    %994 = comb.extract %oh_i from 8 : (i35) -> i1
    llhd.drv %993, %994 after %0 : i1
    %995 = llhd.sig.extract %and_tree from %c-57_i7 : <i127> -> <i1>
    llhd.drv %995, %994 after %0 : i1
    %996 = llhd.sig.extract %err_tree from %c-57_i7 : <i127> -> <i1>
    llhd.drv %996, %false after %0 : i1
    %997 = llhd.sig.extract %or_tree from %c-56_i7 : <i127> -> <i1>
    %998 = comb.extract %oh_i from 9 : (i35) -> i1
    llhd.drv %997, %998 after %0 : i1
    %999 = llhd.sig.extract %and_tree from %c-56_i7 : <i127> -> <i1>
    llhd.drv %999, %998 after %0 : i1
    %1000 = llhd.sig.extract %err_tree from %c-56_i7 : <i127> -> <i1>
    llhd.drv %1000, %false after %0 : i1
    %1001 = llhd.sig.extract %or_tree from %c-55_i7 : <i127> -> <i1>
    %1002 = comb.extract %oh_i from 10 : (i35) -> i1
    llhd.drv %1001, %1002 after %0 : i1
    %1003 = llhd.sig.extract %and_tree from %c-55_i7 : <i127> -> <i1>
    llhd.drv %1003, %1002 after %0 : i1
    %1004 = llhd.sig.extract %err_tree from %c-55_i7 : <i127> -> <i1>
    llhd.drv %1004, %false after %0 : i1
    %1005 = llhd.sig.extract %or_tree from %c-54_i7 : <i127> -> <i1>
    %1006 = comb.extract %oh_i from 11 : (i35) -> i1
    llhd.drv %1005, %1006 after %0 : i1
    %1007 = llhd.sig.extract %and_tree from %c-54_i7 : <i127> -> <i1>
    llhd.drv %1007, %1006 after %0 : i1
    %1008 = llhd.sig.extract %err_tree from %c-54_i7 : <i127> -> <i1>
    llhd.drv %1008, %false after %0 : i1
    %1009 = llhd.sig.extract %or_tree from %c-53_i7 : <i127> -> <i1>
    %1010 = comb.extract %oh_i from 12 : (i35) -> i1
    llhd.drv %1009, %1010 after %0 : i1
    %1011 = llhd.sig.extract %and_tree from %c-53_i7 : <i127> -> <i1>
    llhd.drv %1011, %1010 after %0 : i1
    %1012 = llhd.sig.extract %err_tree from %c-53_i7 : <i127> -> <i1>
    llhd.drv %1012, %false after %0 : i1
    %1013 = llhd.sig.extract %or_tree from %c-52_i7 : <i127> -> <i1>
    %1014 = comb.extract %oh_i from 13 : (i35) -> i1
    llhd.drv %1013, %1014 after %0 : i1
    %1015 = llhd.sig.extract %and_tree from %c-52_i7 : <i127> -> <i1>
    llhd.drv %1015, %1014 after %0 : i1
    %1016 = llhd.sig.extract %err_tree from %c-52_i7 : <i127> -> <i1>
    llhd.drv %1016, %false after %0 : i1
    %1017 = llhd.sig.extract %or_tree from %c-51_i7 : <i127> -> <i1>
    %1018 = comb.extract %oh_i from 14 : (i35) -> i1
    llhd.drv %1017, %1018 after %0 : i1
    %1019 = llhd.sig.extract %and_tree from %c-51_i7 : <i127> -> <i1>
    llhd.drv %1019, %1018 after %0 : i1
    %1020 = llhd.sig.extract %err_tree from %c-51_i7 : <i127> -> <i1>
    llhd.drv %1020, %false after %0 : i1
    %1021 = llhd.sig.extract %or_tree from %c-50_i7 : <i127> -> <i1>
    %1022 = comb.extract %oh_i from 15 : (i35) -> i1
    llhd.drv %1021, %1022 after %0 : i1
    %1023 = llhd.sig.extract %and_tree from %c-50_i7 : <i127> -> <i1>
    llhd.drv %1023, %1022 after %0 : i1
    %1024 = llhd.sig.extract %err_tree from %c-50_i7 : <i127> -> <i1>
    llhd.drv %1024, %false after %0 : i1
    %1025 = llhd.sig.extract %or_tree from %c-49_i7 : <i127> -> <i1>
    %1026 = comb.extract %oh_i from 16 : (i35) -> i1
    llhd.drv %1025, %1026 after %0 : i1
    %1027 = llhd.sig.extract %and_tree from %c-49_i7 : <i127> -> <i1>
    llhd.drv %1027, %1026 after %0 : i1
    %1028 = llhd.sig.extract %err_tree from %c-49_i7 : <i127> -> <i1>
    llhd.drv %1028, %false after %0 : i1
    %1029 = llhd.sig.extract %or_tree from %c-48_i7 : <i127> -> <i1>
    %1030 = comb.extract %oh_i from 17 : (i35) -> i1
    llhd.drv %1029, %1030 after %0 : i1
    %1031 = llhd.sig.extract %and_tree from %c-48_i7 : <i127> -> <i1>
    llhd.drv %1031, %1030 after %0 : i1
    %1032 = llhd.sig.extract %err_tree from %c-48_i7 : <i127> -> <i1>
    llhd.drv %1032, %false after %0 : i1
    %1033 = llhd.sig.extract %or_tree from %c-47_i7 : <i127> -> <i1>
    %1034 = comb.extract %oh_i from 18 : (i35) -> i1
    llhd.drv %1033, %1034 after %0 : i1
    %1035 = llhd.sig.extract %and_tree from %c-47_i7 : <i127> -> <i1>
    llhd.drv %1035, %1034 after %0 : i1
    %1036 = llhd.sig.extract %err_tree from %c-47_i7 : <i127> -> <i1>
    llhd.drv %1036, %false after %0 : i1
    %1037 = llhd.sig.extract %or_tree from %c-46_i7 : <i127> -> <i1>
    %1038 = comb.extract %oh_i from 19 : (i35) -> i1
    llhd.drv %1037, %1038 after %0 : i1
    %1039 = llhd.sig.extract %and_tree from %c-46_i7 : <i127> -> <i1>
    llhd.drv %1039, %1038 after %0 : i1
    %1040 = llhd.sig.extract %err_tree from %c-46_i7 : <i127> -> <i1>
    llhd.drv %1040, %false after %0 : i1
    %1041 = llhd.sig.extract %or_tree from %c-45_i7 : <i127> -> <i1>
    %1042 = comb.extract %oh_i from 20 : (i35) -> i1
    llhd.drv %1041, %1042 after %0 : i1
    %1043 = llhd.sig.extract %and_tree from %c-45_i7 : <i127> -> <i1>
    llhd.drv %1043, %1042 after %0 : i1
    %1044 = llhd.sig.extract %err_tree from %c-45_i7 : <i127> -> <i1>
    llhd.drv %1044, %false after %0 : i1
    %1045 = llhd.sig.extract %or_tree from %c-44_i7 : <i127> -> <i1>
    %1046 = comb.extract %oh_i from 21 : (i35) -> i1
    llhd.drv %1045, %1046 after %0 : i1
    %1047 = llhd.sig.extract %and_tree from %c-44_i7 : <i127> -> <i1>
    llhd.drv %1047, %1046 after %0 : i1
    %1048 = llhd.sig.extract %err_tree from %c-44_i7 : <i127> -> <i1>
    llhd.drv %1048, %false after %0 : i1
    %1049 = llhd.sig.extract %or_tree from %c-43_i7 : <i127> -> <i1>
    %1050 = comb.extract %oh_i from 22 : (i35) -> i1
    llhd.drv %1049, %1050 after %0 : i1
    %1051 = llhd.sig.extract %and_tree from %c-43_i7 : <i127> -> <i1>
    llhd.drv %1051, %1050 after %0 : i1
    %1052 = llhd.sig.extract %err_tree from %c-43_i7 : <i127> -> <i1>
    llhd.drv %1052, %false after %0 : i1
    %1053 = llhd.sig.extract %or_tree from %c-42_i7 : <i127> -> <i1>
    %1054 = comb.extract %oh_i from 23 : (i35) -> i1
    llhd.drv %1053, %1054 after %0 : i1
    %1055 = llhd.sig.extract %and_tree from %c-42_i7 : <i127> -> <i1>
    llhd.drv %1055, %1054 after %0 : i1
    %1056 = llhd.sig.extract %err_tree from %c-42_i7 : <i127> -> <i1>
    llhd.drv %1056, %false after %0 : i1
    %1057 = llhd.sig.extract %or_tree from %c-41_i7 : <i127> -> <i1>
    %1058 = comb.extract %oh_i from 24 : (i35) -> i1
    llhd.drv %1057, %1058 after %0 : i1
    %1059 = llhd.sig.extract %and_tree from %c-41_i7 : <i127> -> <i1>
    llhd.drv %1059, %1058 after %0 : i1
    %1060 = llhd.sig.extract %err_tree from %c-41_i7 : <i127> -> <i1>
    llhd.drv %1060, %false after %0 : i1
    %1061 = llhd.sig.extract %or_tree from %c-40_i7 : <i127> -> <i1>
    %1062 = comb.extract %oh_i from 25 : (i35) -> i1
    llhd.drv %1061, %1062 after %0 : i1
    %1063 = llhd.sig.extract %and_tree from %c-40_i7 : <i127> -> <i1>
    llhd.drv %1063, %1062 after %0 : i1
    %1064 = llhd.sig.extract %err_tree from %c-40_i7 : <i127> -> <i1>
    llhd.drv %1064, %false after %0 : i1
    %1065 = llhd.sig.extract %or_tree from %c-39_i7 : <i127> -> <i1>
    %1066 = comb.extract %oh_i from 26 : (i35) -> i1
    llhd.drv %1065, %1066 after %0 : i1
    %1067 = llhd.sig.extract %and_tree from %c-39_i7 : <i127> -> <i1>
    llhd.drv %1067, %1066 after %0 : i1
    %1068 = llhd.sig.extract %err_tree from %c-39_i7 : <i127> -> <i1>
    llhd.drv %1068, %false after %0 : i1
    %1069 = llhd.sig.extract %or_tree from %c-38_i7 : <i127> -> <i1>
    %1070 = comb.extract %oh_i from 27 : (i35) -> i1
    llhd.drv %1069, %1070 after %0 : i1
    %1071 = llhd.sig.extract %and_tree from %c-38_i7 : <i127> -> <i1>
    llhd.drv %1071, %1070 after %0 : i1
    %1072 = llhd.sig.extract %err_tree from %c-38_i7 : <i127> -> <i1>
    llhd.drv %1072, %false after %0 : i1
    %1073 = llhd.sig.extract %or_tree from %c-37_i7 : <i127> -> <i1>
    %1074 = comb.extract %oh_i from 28 : (i35) -> i1
    llhd.drv %1073, %1074 after %0 : i1
    %1075 = llhd.sig.extract %and_tree from %c-37_i7 : <i127> -> <i1>
    llhd.drv %1075, %1074 after %0 : i1
    %1076 = llhd.sig.extract %err_tree from %c-37_i7 : <i127> -> <i1>
    llhd.drv %1076, %false after %0 : i1
    %1077 = llhd.sig.extract %or_tree from %c-36_i7 : <i127> -> <i1>
    %1078 = comb.extract %oh_i from 29 : (i35) -> i1
    llhd.drv %1077, %1078 after %0 : i1
    %1079 = llhd.sig.extract %and_tree from %c-36_i7 : <i127> -> <i1>
    llhd.drv %1079, %1078 after %0 : i1
    %1080 = llhd.sig.extract %err_tree from %c-36_i7 : <i127> -> <i1>
    llhd.drv %1080, %false after %0 : i1
    %1081 = llhd.sig.extract %or_tree from %c-35_i7 : <i127> -> <i1>
    %1082 = comb.extract %oh_i from 30 : (i35) -> i1
    llhd.drv %1081, %1082 after %0 : i1
    %1083 = llhd.sig.extract %and_tree from %c-35_i7 : <i127> -> <i1>
    llhd.drv %1083, %1082 after %0 : i1
    %1084 = llhd.sig.extract %err_tree from %c-35_i7 : <i127> -> <i1>
    llhd.drv %1084, %false after %0 : i1
    %1085 = llhd.sig.extract %or_tree from %c-34_i7 : <i127> -> <i1>
    %1086 = comb.extract %oh_i from 31 : (i35) -> i1
    llhd.drv %1085, %1086 after %0 : i1
    %1087 = llhd.sig.extract %and_tree from %c-34_i7 : <i127> -> <i1>
    llhd.drv %1087, %1086 after %0 : i1
    %1088 = llhd.sig.extract %err_tree from %c-34_i7 : <i127> -> <i1>
    llhd.drv %1088, %false after %0 : i1
    %1089 = llhd.sig.extract %or_tree from %c-33_i7 : <i127> -> <i1>
    %1090 = comb.extract %oh_i from 32 : (i35) -> i1
    llhd.drv %1089, %1090 after %0 : i1
    %1091 = llhd.sig.extract %and_tree from %c-33_i7 : <i127> -> <i1>
    llhd.drv %1091, %1090 after %0 : i1
    %1092 = llhd.sig.extract %err_tree from %c-33_i7 : <i127> -> <i1>
    llhd.drv %1092, %false after %0 : i1
    %1093 = llhd.sig.extract %or_tree from %c-32_i7 : <i127> -> <i1>
    %1094 = comb.extract %oh_i from 33 : (i35) -> i1
    llhd.drv %1093, %1094 after %0 : i1
    %1095 = llhd.sig.extract %and_tree from %c-32_i7 : <i127> -> <i1>
    llhd.drv %1095, %1094 after %0 : i1
    %1096 = llhd.sig.extract %err_tree from %c-32_i7 : <i127> -> <i1>
    llhd.drv %1096, %false after %0 : i1
    %1097 = llhd.sig.extract %or_tree from %c-31_i7 : <i127> -> <i1>
    %1098 = comb.extract %oh_i from 34 : (i35) -> i1
    llhd.drv %1097, %1098 after %0 : i1
    %1099 = llhd.sig.extract %and_tree from %c-31_i7 : <i127> -> <i1>
    llhd.drv %1099, %1098 after %0 : i1
    %1100 = llhd.sig.extract %err_tree from %c-31_i7 : <i127> -> <i1>
    llhd.drv %1100, %false after %0 : i1
    %1101 = llhd.sig.extract %or_tree from %c-30_i7 : <i127> -> <i1>
    llhd.drv %1101, %false after %0 : i1
    %1102 = llhd.sig.extract %and_tree from %c-30_i7 : <i127> -> <i1>
    llhd.drv %1102, %false after %0 : i1
    %1103 = llhd.sig.extract %err_tree from %c-30_i7 : <i127> -> <i1>
    llhd.drv %1103, %false after %0 : i1
    %1104 = llhd.sig.extract %or_tree from %c-29_i7 : <i127> -> <i1>
    llhd.drv %1104, %false after %0 : i1
    %1105 = llhd.sig.extract %and_tree from %c-29_i7 : <i127> -> <i1>
    llhd.drv %1105, %false after %0 : i1
    %1106 = llhd.sig.extract %err_tree from %c-29_i7 : <i127> -> <i1>
    llhd.drv %1106, %false after %0 : i1
    %1107 = llhd.sig.extract %or_tree from %c-28_i7 : <i127> -> <i1>
    llhd.drv %1107, %false after %0 : i1
    %1108 = llhd.sig.extract %and_tree from %c-28_i7 : <i127> -> <i1>
    llhd.drv %1108, %false after %0 : i1
    %1109 = llhd.sig.extract %err_tree from %c-28_i7 : <i127> -> <i1>
    llhd.drv %1109, %false after %0 : i1
    %1110 = llhd.sig.extract %or_tree from %c-27_i7 : <i127> -> <i1>
    llhd.drv %1110, %false after %0 : i1
    %1111 = llhd.sig.extract %and_tree from %c-27_i7 : <i127> -> <i1>
    llhd.drv %1111, %false after %0 : i1
    %1112 = llhd.sig.extract %err_tree from %c-27_i7 : <i127> -> <i1>
    llhd.drv %1112, %false after %0 : i1
    %1113 = llhd.sig.extract %or_tree from %c-26_i7 : <i127> -> <i1>
    llhd.drv %1113, %false after %0 : i1
    %1114 = llhd.sig.extract %and_tree from %c-26_i7 : <i127> -> <i1>
    llhd.drv %1114, %false after %0 : i1
    %1115 = llhd.sig.extract %err_tree from %c-26_i7 : <i127> -> <i1>
    llhd.drv %1115, %false after %0 : i1
    %1116 = llhd.sig.extract %or_tree from %c-25_i7 : <i127> -> <i1>
    llhd.drv %1116, %false after %0 : i1
    %1117 = llhd.sig.extract %and_tree from %c-25_i7 : <i127> -> <i1>
    llhd.drv %1117, %false after %0 : i1
    %1118 = llhd.sig.extract %err_tree from %c-25_i7 : <i127> -> <i1>
    llhd.drv %1118, %false after %0 : i1
    %1119 = llhd.sig.extract %or_tree from %c-24_i7 : <i127> -> <i1>
    llhd.drv %1119, %false after %0 : i1
    %1120 = llhd.sig.extract %and_tree from %c-24_i7 : <i127> -> <i1>
    llhd.drv %1120, %false after %0 : i1
    %1121 = llhd.sig.extract %err_tree from %c-24_i7 : <i127> -> <i1>
    llhd.drv %1121, %false after %0 : i1
    %1122 = llhd.sig.extract %or_tree from %c-23_i7 : <i127> -> <i1>
    llhd.drv %1122, %false after %0 : i1
    %1123 = llhd.sig.extract %and_tree from %c-23_i7 : <i127> -> <i1>
    llhd.drv %1123, %false after %0 : i1
    %1124 = llhd.sig.extract %err_tree from %c-23_i7 : <i127> -> <i1>
    llhd.drv %1124, %false after %0 : i1
    %1125 = llhd.sig.extract %or_tree from %c-22_i7 : <i127> -> <i1>
    llhd.drv %1125, %false after %0 : i1
    %1126 = llhd.sig.extract %and_tree from %c-22_i7 : <i127> -> <i1>
    llhd.drv %1126, %false after %0 : i1
    %1127 = llhd.sig.extract %err_tree from %c-22_i7 : <i127> -> <i1>
    llhd.drv %1127, %false after %0 : i1
    %1128 = llhd.sig.extract %or_tree from %c-21_i7 : <i127> -> <i1>
    llhd.drv %1128, %false after %0 : i1
    %1129 = llhd.sig.extract %and_tree from %c-21_i7 : <i127> -> <i1>
    llhd.drv %1129, %false after %0 : i1
    %1130 = llhd.sig.extract %err_tree from %c-21_i7 : <i127> -> <i1>
    llhd.drv %1130, %false after %0 : i1
    %1131 = llhd.sig.extract %or_tree from %c-20_i7 : <i127> -> <i1>
    llhd.drv %1131, %false after %0 : i1
    %1132 = llhd.sig.extract %and_tree from %c-20_i7 : <i127> -> <i1>
    llhd.drv %1132, %false after %0 : i1
    %1133 = llhd.sig.extract %err_tree from %c-20_i7 : <i127> -> <i1>
    llhd.drv %1133, %false after %0 : i1
    %1134 = llhd.sig.extract %or_tree from %c-19_i7 : <i127> -> <i1>
    llhd.drv %1134, %false after %0 : i1
    %1135 = llhd.sig.extract %and_tree from %c-19_i7 : <i127> -> <i1>
    llhd.drv %1135, %false after %0 : i1
    %1136 = llhd.sig.extract %err_tree from %c-19_i7 : <i127> -> <i1>
    llhd.drv %1136, %false after %0 : i1
    %1137 = llhd.sig.extract %or_tree from %c-18_i7 : <i127> -> <i1>
    llhd.drv %1137, %false after %0 : i1
    %1138 = llhd.sig.extract %and_tree from %c-18_i7 : <i127> -> <i1>
    llhd.drv %1138, %false after %0 : i1
    %1139 = llhd.sig.extract %err_tree from %c-18_i7 : <i127> -> <i1>
    llhd.drv %1139, %false after %0 : i1
    %1140 = llhd.sig.extract %or_tree from %c-17_i7 : <i127> -> <i1>
    llhd.drv %1140, %false after %0 : i1
    %1141 = llhd.sig.extract %and_tree from %c-17_i7 : <i127> -> <i1>
    llhd.drv %1141, %false after %0 : i1
    %1142 = llhd.sig.extract %err_tree from %c-17_i7 : <i127> -> <i1>
    llhd.drv %1142, %false after %0 : i1
    %1143 = llhd.sig.extract %or_tree from %c-16_i7 : <i127> -> <i1>
    llhd.drv %1143, %false after %0 : i1
    %1144 = llhd.sig.extract %and_tree from %c-16_i7 : <i127> -> <i1>
    llhd.drv %1144, %false after %0 : i1
    %1145 = llhd.sig.extract %err_tree from %c-16_i7 : <i127> -> <i1>
    llhd.drv %1145, %false after %0 : i1
    %1146 = llhd.sig.extract %or_tree from %c-15_i7 : <i127> -> <i1>
    llhd.drv %1146, %false after %0 : i1
    %1147 = llhd.sig.extract %and_tree from %c-15_i7 : <i127> -> <i1>
    llhd.drv %1147, %false after %0 : i1
    %1148 = llhd.sig.extract %err_tree from %c-15_i7 : <i127> -> <i1>
    llhd.drv %1148, %false after %0 : i1
    %1149 = llhd.sig.extract %or_tree from %c-14_i7 : <i127> -> <i1>
    llhd.drv %1149, %false after %0 : i1
    %1150 = llhd.sig.extract %and_tree from %c-14_i7 : <i127> -> <i1>
    llhd.drv %1150, %false after %0 : i1
    %1151 = llhd.sig.extract %err_tree from %c-14_i7 : <i127> -> <i1>
    llhd.drv %1151, %false after %0 : i1
    %1152 = llhd.sig.extract %or_tree from %c-13_i7 : <i127> -> <i1>
    llhd.drv %1152, %false after %0 : i1
    %1153 = llhd.sig.extract %and_tree from %c-13_i7 : <i127> -> <i1>
    llhd.drv %1153, %false after %0 : i1
    %1154 = llhd.sig.extract %err_tree from %c-13_i7 : <i127> -> <i1>
    llhd.drv %1154, %false after %0 : i1
    %1155 = llhd.sig.extract %or_tree from %c-12_i7 : <i127> -> <i1>
    llhd.drv %1155, %false after %0 : i1
    %1156 = llhd.sig.extract %and_tree from %c-12_i7 : <i127> -> <i1>
    llhd.drv %1156, %false after %0 : i1
    %1157 = llhd.sig.extract %err_tree from %c-12_i7 : <i127> -> <i1>
    llhd.drv %1157, %false after %0 : i1
    %1158 = llhd.sig.extract %or_tree from %c-11_i7 : <i127> -> <i1>
    llhd.drv %1158, %false after %0 : i1
    %1159 = llhd.sig.extract %and_tree from %c-11_i7 : <i127> -> <i1>
    llhd.drv %1159, %false after %0 : i1
    %1160 = llhd.sig.extract %err_tree from %c-11_i7 : <i127> -> <i1>
    llhd.drv %1160, %false after %0 : i1
    %1161 = llhd.sig.extract %or_tree from %c-10_i7 : <i127> -> <i1>
    llhd.drv %1161, %false after %0 : i1
    %1162 = llhd.sig.extract %and_tree from %c-10_i7 : <i127> -> <i1>
    llhd.drv %1162, %false after %0 : i1
    %1163 = llhd.sig.extract %err_tree from %c-10_i7 : <i127> -> <i1>
    llhd.drv %1163, %false after %0 : i1
    %1164 = llhd.sig.extract %or_tree from %c-9_i7 : <i127> -> <i1>
    llhd.drv %1164, %false after %0 : i1
    %1165 = llhd.sig.extract %and_tree from %c-9_i7 : <i127> -> <i1>
    llhd.drv %1165, %false after %0 : i1
    %1166 = llhd.sig.extract %err_tree from %c-9_i7 : <i127> -> <i1>
    llhd.drv %1166, %false after %0 : i1
    %1167 = llhd.sig.extract %or_tree from %c-8_i7 : <i127> -> <i1>
    llhd.drv %1167, %false after %0 : i1
    %1168 = llhd.sig.extract %and_tree from %c-8_i7 : <i127> -> <i1>
    llhd.drv %1168, %false after %0 : i1
    %1169 = llhd.sig.extract %err_tree from %c-8_i7 : <i127> -> <i1>
    llhd.drv %1169, %false after %0 : i1
    %1170 = llhd.sig.extract %or_tree from %c-7_i7 : <i127> -> <i1>
    llhd.drv %1170, %false after %0 : i1
    %1171 = llhd.sig.extract %and_tree from %c-7_i7 : <i127> -> <i1>
    llhd.drv %1171, %false after %0 : i1
    %1172 = llhd.sig.extract %err_tree from %c-7_i7 : <i127> -> <i1>
    llhd.drv %1172, %false after %0 : i1
    %1173 = llhd.sig.extract %or_tree from %c-6_i7 : <i127> -> <i1>
    llhd.drv %1173, %false after %0 : i1
    %1174 = llhd.sig.extract %and_tree from %c-6_i7 : <i127> -> <i1>
    llhd.drv %1174, %false after %0 : i1
    %1175 = llhd.sig.extract %err_tree from %c-6_i7 : <i127> -> <i1>
    llhd.drv %1175, %false after %0 : i1
    %1176 = llhd.sig.extract %or_tree from %c-5_i7 : <i127> -> <i1>
    llhd.drv %1176, %false after %0 : i1
    %1177 = llhd.sig.extract %and_tree from %c-5_i7 : <i127> -> <i1>
    llhd.drv %1177, %false after %0 : i1
    %1178 = llhd.sig.extract %err_tree from %c-5_i7 : <i127> -> <i1>
    llhd.drv %1178, %false after %0 : i1
    %1179 = llhd.sig.extract %or_tree from %c-4_i7 : <i127> -> <i1>
    llhd.drv %1179, %false after %0 : i1
    %1180 = llhd.sig.extract %and_tree from %c-4_i7 : <i127> -> <i1>
    llhd.drv %1180, %false after %0 : i1
    %1181 = llhd.sig.extract %err_tree from %c-4_i7 : <i127> -> <i1>
    llhd.drv %1181, %false after %0 : i1
    %1182 = llhd.sig.extract %or_tree from %c-3_i7 : <i127> -> <i1>
    llhd.drv %1182, %false after %0 : i1
    %1183 = llhd.sig.extract %and_tree from %c-3_i7 : <i127> -> <i1>
    llhd.drv %1183, %false after %0 : i1
    %1184 = llhd.sig.extract %err_tree from %c-3_i7 : <i127> -> <i1>
    llhd.drv %1184, %false after %0 : i1
    %1185 = llhd.sig.extract %or_tree from %c-2_i7 : <i127> -> <i1>
    llhd.drv %1185, %false after %0 : i1
    %1186 = llhd.sig.extract %and_tree from %c-2_i7 : <i127> -> <i1>
    llhd.drv %1186, %false after %0 : i1
    %1187 = llhd.sig.extract %err_tree from %c-2_i7 : <i127> -> <i1>
    llhd.drv %1187, %false after %0 : i1
    %1188 = comb.or %1189, %1192 : i1
    %1189 = comb.extract %17 from 0 {sv.namehint = "oh0_err"} : (i127) -> i1
    %1190 = comb.xor %en_i, %true : i1
    %1191 = comb.extract %2 from 0 : (i127) -> i1
    %1192 = comb.and %1190, %1191 {sv.namehint = "enable_err"} : i1
    hw.output %1188 : i1
  }
  hw.module private @prim_reg_we_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i35, in %en_i : i1, out err_o : i1) {
    %c0_i6 = hw.constant 0 : i6
    %u_prim_buf.out_o = hw.instance "u_prim_buf" @prim_buf_16(in_i: %oh_i: i35) -> (out_o: i35) {sv.namehint = "oh_buf"}
    %u_prim_onehot_check.err_o = hw.instance "u_prim_onehot_check" @prim_onehot_check(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, oh_i: %u_prim_buf.out_o: i35, addr_i: %c0_i6: i6, en_i: %en_i: i1) -> (err_o: i1)
    hw.output %u_prim_onehot_check.err_o : i1
  }
  hw.module private @prim_sec_anchor_buf(in %in_i : i1, out out_o : i1) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf_18(in_i: %in_i: i1) -> (out_o: i1)
    hw.output %u_secure_anchor_buf.out_o : i1
  }
  hw.module private @prim_sec_anchor_buf_6(in %in_i : i2, out out_o : i2) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf(in_i: %in_i: i2) -> (out_o: i2)
    hw.output %u_secure_anchor_buf.out_o : i2
  }
  hw.module private @prim_sec_anchor_buf_28(in %in_i : i30, out out_o : i30) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf_33(in_i: %in_i: i30) -> (out_o: i30)
    hw.output %u_secure_anchor_buf.out_o : i30
  }
  hw.module private @prim_sec_anchor_flop(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_o : i2) {
    %u_secure_anchor_flop.q_o = hw.instance "u_secure_anchor_flop" @prim_flop_20(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %d_i: i2) -> (q_o: i2)
    hw.output %u_secure_anchor_flop.q_o : i2
  }
  hw.module private @prim_sec_anchor_flop_30(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
    %u_secure_anchor_flop.q_o = hw.instance "u_secure_anchor_flop" @prim_flop_32(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %d_i: i4) -> (q_o: i4)
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
  hw.module private @prim_sparse_fsm_flop(in %clk_i : i1, in %rst_ni : i1, in %state_i : i8, out state_o : i8) {
    %u_state_flop.q_o = hw.instance "u_state_flop" @prim_flop_23(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %state_i: i8) -> (q_o: i8) {sv.namehint = "state_raw"}
    hw.output %u_state_flop.q_o : i8
  }
  hw.module private @prim_sparse_fsm_flop_11(in %clk_i : i1, in %rst_ni : i1, in %state_i : i16, out state_o : i16) {
    %u_state_flop.q_o = hw.instance "u_state_flop" @prim_flop_25(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %state_i: i16) -> (q_o: i16) {sv.namehint = "state_raw"}
    hw.output %u_state_flop.q_o : i16
  }
  hw.module private @prim_sparse_fsm_flop_12(in %clk_i : i1, in %rst_ni : i1, in %state_i : i320, out state_o : i320) {
    %u_state_flop.q_o = hw.instance "u_state_flop" @prim_flop_26(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %state_i: i320) -> (q_o: i320) {sv.namehint = "state_raw"}
    hw.output %u_state_flop.q_o : i320
  }
  hw.module private @prim_sparse_fsm_flop_13(in %clk_i : i1, in %rst_ni : i1, in %state_i : i384, out state_o : i384) {
    %u_state_flop.q_o = hw.instance "u_state_flop" @prim_flop_27(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %state_i: i384) -> (q_o: i384) {sv.namehint = "state_raw"}
    hw.output %u_state_flop.q_o : i384
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
  hw.module private @prim_subreg_ext(in %re : i1, in %we : i1, in %wd : i1, in %d : i1, out qe : i1, out qre : i1, out q : i1, out ds : i1, out qs : i1) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i1, i1, i1
  }
  hw.module private @prim_subreg_ext_0(in %re : i1, in %we : i1, in %wd : i8, in %d : i8, out qe : i1, out qre : i1, out q : i8, out ds : i8, out qs : i8) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i8, i8, i8
  }
  hw.module private @prim_subreg_ext_1(in %re : i1, in %we : i1, in %wd : i32, in %d : i32, out qe : i1, out qre : i1, out q : i32, out ds : i32, out qs : i32) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i32, i32, i32
  }
  hw.module private @prim_subreg_ext_2(in %re : i1, in %we : i1, in %wd : i30, in %d : i30, out qe : i1, out qre : i1, out q : i30, out ds : i30, out qs : i30) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i30, i30, i30
  }
  hw.module private @prim_subreg_ext_3(in %re : i1, in %we : i1, in %wd : i5, in %d : i5, out qe : i1, out qre : i1, out q : i5, out ds : i5, out qs : i5) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i5, i5, i5
  }
  hw.module private @prim_subreg_ext_4(in %re : i1, in %we : i1, in %wd : i16, in %d : i16, out qe : i1, out qre : i1, out q : i16, out ds : i16, out qs : i16) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i16, i16, i16
  }
  hw.module private @prim_subreg_ext_5(in %re : i1, in %we : i1, in %wd : i24, in %d : i24, out qe : i1, out qre : i1, out q : i24, out ds : i24, out qs : i24) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i24, i24, i24
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
  hw.module private @prim_sync_reqack_data(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, in %req_chk_i : i1, in %src_req_i : i1, out src_ack_o : i1, out dst_req_o : i1, in %dst_ack_i : i1, in %data_i : i129, out data_o : i129) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i129 = hw.constant 0 : i129
    %false = hw.constant false
    %clk_dst_i_0 = llhd.sig name "clk_dst_i" %false : i1
    %2 = llhd.prb %clk_dst_i_0 : i1
    %rst_dst_ni_1 = llhd.sig name "rst_dst_ni" %false : i1
    %3 = llhd.prb %rst_dst_ni_1 : i1
    %gen_data_reg.data_we = llhd.sig %false : i1
    %gen_data_reg.data_d = llhd.sig %c0_i129 : i129
    %gen_data_reg.data_q = llhd.sig %c0_i129 : i129
    %u_prim_sync_reqack.src_ack_o, %u_prim_sync_reqack.dst_req_o = hw.instance "u_prim_sync_reqack" @prim_sync_reqack(clk_src_i: %clk_src_i: i1, rst_src_ni: %rst_src_ni: i1, clk_dst_i: %2: i1, rst_dst_ni: %3: i1, req_chk_i: %req_chk_i: i1, src_req_i: %src_req_i: i1, dst_ack_i: %dst_ack_i: i1) -> (src_ack_o: i1, dst_req_o: i1)
    %4 = comb.and %u_prim_sync_reqack.dst_req_o, %dst_ack_i : i1
    llhd.drv %gen_data_reg.data_we, %4 after %1 : i1
    llhd.drv %gen_data_reg.data_d, %data_i after %1 : i129
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %6 = llhd.prb %clk_dst_i_0 : i1
      %7 = llhd.prb %rst_dst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %8 = llhd.prb %clk_dst_i_0 : i1
      %9 = comb.xor bin %6, %true : i1
      %10 = comb.and bin %9, %8 : i1
      %11 = llhd.prb %rst_dst_ni_1 : i1
      %12 = comb.xor bin %11, %true : i1
      %13 = comb.and bin %7, %12 : i1
      %14 = comb.or bin %10, %13 : i1
      cf.cond_br %14, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %15 = llhd.prb %rst_dst_ni_1 : i1
      %16 = comb.xor %15, %true : i1
      cf.cond_br %16, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_data_reg.data_q, %c0_i129 after %0 : i129
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %17 = llhd.prb %gen_data_reg.data_we : i1
      cf.cond_br %17, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %18 = llhd.prb %gen_data_reg.data_d : i129
      llhd.drv %gen_data_reg.data_q, %18 after %0 : i129
      cf.br ^bb1
    }
    %5 = llhd.prb %gen_data_reg.data_q : i129
    llhd.drv %clk_dst_i_0, %clk_dst_i after %1 : i1
    llhd.drv %rst_dst_ni_1, %rst_dst_ni after %1 : i1
    hw.output %u_prim_sync_reqack.src_ack_o, %u_prim_sync_reqack.dst_req_o, %5 : i1, i1, i129
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
  hw.module private @tlul_adapter_reg(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %en_ifetch_i : i4, out intg_error_o : i1, out re_o : i1, out we_o : i1, out addr_o : i8, out wdata_o : i32, out be_o : i4, in %busy_i : i1, in %rdata_i : i32, in %error_i : i1) {
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
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen_17(tl_i: %32: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
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
    %22 = comb.extract %a_address from 2 : (i32) -> i6
    %23 = comb.concat %22, %c0_i2 : i6, i2
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
    hw.output %u_rsp_intg_gen.tl_o, %false, %21, %19, %23, %a_data, %a_mask : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, i1, i1, i1, i8, i32, i4
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
  hw.module private @tlul_rsp_intg_gen_17(in %tl_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) {
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
  hw.module private @prim_lc_sender(in %clk_i : i1, in %rst_ni : i1, in %lc_en_i : i4, out lc_en_o : i4) {
    %gen_flops.u_prim_flop.q_o = hw.instance "gen_flops.u_prim_flop" @prim_sec_anchor_flop_30(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %lc_en_i: i4) -> (q_o: i4) {sv.namehint = "lc_en_out"}
    hw.output %gen_flops.u_prim_flop.q_o : i4
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
  func.func private @"lc_ctrl_pkg::lc_tx_or_hi"(%arg0: i4, %arg1: i4) -> i4 {
    %c5_i4 = hw.constant 5 : i4
    %0 = call @"lc_ctrl_pkg::lc_tx_or"(%arg0, %arg1, %c5_i4) : (i4, i4, i4) -> i4
    return %0 : i4
  }
  func.func private @"lc_ctrl_pkg::lc_tx_and_hi"(%arg0: i4, %arg1: i4) -> i4 {
    %c5_i4 = hw.constant 5 : i4
    %0 = call @"lc_ctrl_pkg::lc_tx_and"(%arg0, %arg1, %c5_i4) : (i4, i4, i4) -> i4
    return %0 : i4
  }
  hw.module private @prim_lc_sync(in %clk_i : i1, in %rst_ni : i1, in %lc_en_i : i4, out lc_en_o : !hw.array<2xi4>) {
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
    %gen_buffs_0.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %6, %gen_buffs_0.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %7 = comb.extract %17 from 1 : (i4) -> i1
    %8 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %8, %gen_buffs_0.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %9 = comb.extract %17 from 2 : (i4) -> i1
    %10 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %10, %gen_buffs_0.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %11 = comb.extract %17 from 3 : (i4) -> i1
    %12 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %12, %gen_buffs_0.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %13 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %13, %gen_buffs_1.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %14 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %14, %gen_buffs_1.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %15 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %15, %gen_buffs_1.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %16 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf(in_i: %11: i1) -> (out_o: i1)
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
  hw.module private @prim_lc_sync_8(in %clk_i : i1, in %rst_ni : i1, in %lc_en_i : i4, out lc_en_o : !hw.array<4xi4>) {
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %c0_i4 = hw.constant 0 : i4
    %1 = hw.aggregate_constant [0 : i4, 0 : i4, 0 : i4, 0 : i4] : !hw.array<4xi4>
    %lc_en_o = llhd.sig %1 : !hw.array<4xi4>
    %gen_buffs_0.lc_en_out = llhd.sig %c0_i4 : i4
    %gen_buffs_1.lc_en_out = llhd.sig %c0_i4 : i4
    %gen_buffs_2.lc_en_out = llhd.sig %c0_i4 : i4
    %gen_buffs_3.lc_en_out = llhd.sig %c0_i4 : i4
    %gen_flops.u_prim_flop_2sync.q_o = hw.instance "gen_flops.u_prim_flop_2sync" @prim_flop_2sync_24(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %lc_en_i: i4) -> (q_o: i4) {sv.namehint = "lc_en"}
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
    %10 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %10, %gen_buffs_1.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %11 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %11, %gen_buffs_1.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %12 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %12, %gen_buffs_1.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %13 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %13, %gen_buffs_1.gen_bits_3.u_prim_buf.out_o after %0 : i1
    %14 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %14, %gen_buffs_2.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %15 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %15, %gen_buffs_2.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %16 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %16, %gen_buffs_2.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %17 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %17, %gen_buffs_2.gen_bits_3.u_prim_buf.out_o after %0 : i1
    %18 = llhd.sig.extract %gen_buffs_3.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %18, %gen_buffs_3.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %19 = llhd.sig.extract %gen_buffs_3.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %19, %gen_buffs_3.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %20 = llhd.sig.extract %gen_buffs_3.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %20, %gen_buffs_3.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %21 = llhd.sig.extract %gen_buffs_3.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %21, %gen_buffs_3.gen_bits_3.u_prim_buf.out_o after %0 : i1
    %22 = llhd.sig.array_get %lc_en_o[%c0_i2] : <!hw.array<4xi4>>
    %23 = llhd.prb %gen_buffs_0.lc_en_out : i4
    llhd.drv %22, %23 after %0 : i4
    %24 = llhd.sig.array_get %lc_en_o[%c1_i2] : <!hw.array<4xi4>>
    %25 = llhd.prb %gen_buffs_1.lc_en_out : i4
    llhd.drv %24, %25 after %0 : i4
    %26 = llhd.sig.array_get %lc_en_o[%c-2_i2] : <!hw.array<4xi4>>
    %27 = llhd.prb %gen_buffs_2.lc_en_out : i4
    llhd.drv %26, %27 after %0 : i4
    %28 = llhd.sig.array_get %lc_en_o[%c-1_i2] : <!hw.array<4xi4>>
    %29 = llhd.prb %gen_buffs_3.lc_en_out : i4
    llhd.drv %28, %29 after %0 : i4
    %30 = llhd.prb %lc_en_o : !hw.array<4xi4>
    hw.output %30 : !hw.array<4xi4>
  }
  hw.module private @prim_lc_sync_9(in %clk_i : i1, in %rst_ni : i1, in %lc_en_i : i4, out lc_en_o : !hw.array<1xi4>) {
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
    %gen_flops.u_prim_flop_2sync.q_o = hw.instance "gen_flops.u_prim_flop_2sync" @prim_flop_2sync_24(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %lc_en_i: i4) -> (q_o: i4) {sv.namehint = "lc_en"}
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
  hw.module private @prim_lc_sync_10(in %clk_i : i1, in %rst_ni : i1, in %lc_en_i : i4, out lc_en_o : !hw.array<3xi4>) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %2 = hw.aggregate_constant [0 : i4, 0 : i4, 0 : i4] : !hw.array<3xi4>
    %c0_i4 = hw.constant 0 : i4
    %c-6_i4 = hw.constant -6 : i4
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %lc_en_i_2 = llhd.sig name "lc_en_i" %c0_i4 : i4
    %lc_en_o = llhd.sig %2 : !hw.array<3xi4>
    %gen_no_flops.unused_logic = llhd.sig %c0_i4 : i4
    %gen_buffs_0.lc_en_out = llhd.sig %c0_i4 : i4
    %gen_buffs_1.lc_en_out = llhd.sig %c0_i4 : i4
    %gen_buffs_2.lc_en_out = llhd.sig %c0_i4 : i4
    %5 = comb.extract %21 from 0 : (i4) -> i1
    %6 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %6, %gen_buffs_0.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %7 = comb.extract %21 from 1 : (i4) -> i1
    %8 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %8, %gen_buffs_0.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %9 = comb.extract %21 from 2 : (i4) -> i1
    %10 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %10, %gen_buffs_0.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %11 = comb.extract %21 from 3 : (i4) -> i1
    %12 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %12, %gen_buffs_0.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %13 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %13, %gen_buffs_1.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %14 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %14, %gen_buffs_1.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %15 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %15, %gen_buffs_1.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %16 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %16, %gen_buffs_1.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %17 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %17, %gen_buffs_2.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %18 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %18, %gen_buffs_2.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %19 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %19, %gen_buffs_2.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %20 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %20, %gen_buffs_2.gen_bits_3.u_prim_buf.out_o after %1 : i1
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
      llhd.drv %gen_no_flops.unused_logic, %c-6_i4 after %0 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %40 = llhd.prb %lc_en_i_2 : i4
      llhd.drv %gen_no_flops.unused_logic, %40 after %0 : i4
      cf.br ^bb1
    }
    %21 = llhd.prb %lc_en_i_2 {sv.namehint = "lc_en"} : i4
    %22 = llhd.sig.array_get %lc_en_o[%c0_i2] : <!hw.array<3xi4>>
    %23 = llhd.prb %gen_buffs_0.lc_en_out : i4
    llhd.drv %22, %23 after %1 : i4
    %24 = llhd.sig.array_get %lc_en_o[%c1_i2] : <!hw.array<3xi4>>
    %25 = llhd.prb %gen_buffs_1.lc_en_out : i4
    llhd.drv %24, %25 after %1 : i4
    %26 = llhd.sig.array_get %lc_en_o[%c-2_i2] : <!hw.array<3xi4>>
    %27 = llhd.prb %gen_buffs_2.lc_en_out : i4
    llhd.drv %26, %27 after %1 : i4
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %lc_en_i_2, %lc_en_i after %1 : i4
    %28 = llhd.prb %lc_en_o : !hw.array<3xi4>
    hw.output %28 : !hw.array<3xi4>
  }
  hw.module private @prim_lc_sync_14(in %clk_i : i1, in %rst_ni : i1, in %lc_en_i : i4, out lc_en_o : !hw.array<4xi4>) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %2 = hw.aggregate_constant [0 : i4, 0 : i4, 0 : i4, 0 : i4] : !hw.array<4xi4>
    %c0_i4 = hw.constant 0 : i4
    %c-6_i4 = hw.constant -6 : i4
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %lc_en_i_2 = llhd.sig name "lc_en_i" %c0_i4 : i4
    %lc_en_o = llhd.sig %2 : !hw.array<4xi4>
    %gen_no_flops.unused_logic = llhd.sig %c0_i4 : i4
    %gen_buffs_0.lc_en_out = llhd.sig %c0_i4 : i4
    %gen_buffs_1.lc_en_out = llhd.sig %c0_i4 : i4
    %gen_buffs_2.lc_en_out = llhd.sig %c0_i4 : i4
    %gen_buffs_3.lc_en_out = llhd.sig %c0_i4 : i4
    %5 = comb.extract %25 from 0 : (i4) -> i1
    %6 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %6, %gen_buffs_0.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %7 = comb.extract %25 from 1 : (i4) -> i1
    %8 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %8, %gen_buffs_0.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %9 = comb.extract %25 from 2 : (i4) -> i1
    %10 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %10, %gen_buffs_0.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %11 = comb.extract %25 from 3 : (i4) -> i1
    %12 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %12, %gen_buffs_0.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %13 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %13, %gen_buffs_1.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %14 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %14, %gen_buffs_1.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %15 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %15, %gen_buffs_1.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %16 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %16, %gen_buffs_1.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %17 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %17, %gen_buffs_2.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %18 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %18, %gen_buffs_2.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %19 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %19, %gen_buffs_2.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %20 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %20, %gen_buffs_2.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %21 = llhd.sig.extract %gen_buffs_3.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %21, %gen_buffs_3.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %22 = llhd.sig.extract %gen_buffs_3.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %22, %gen_buffs_3.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %23 = llhd.sig.extract %gen_buffs_3.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %23, %gen_buffs_3.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %24 = llhd.sig.extract %gen_buffs_3.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf(in_i: %11: i1) -> (out_o: i1)
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
      llhd.drv %gen_no_flops.unused_logic, %c-6_i4 after %0 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %46 = llhd.prb %lc_en_i_2 : i4
      llhd.drv %gen_no_flops.unused_logic, %46 after %0 : i4
      cf.br ^bb1
    }
    %25 = llhd.prb %lc_en_i_2 {sv.namehint = "lc_en"} : i4
    %26 = llhd.sig.array_get %lc_en_o[%c0_i2] : <!hw.array<4xi4>>
    %27 = llhd.prb %gen_buffs_0.lc_en_out : i4
    llhd.drv %26, %27 after %1 : i4
    %28 = llhd.sig.array_get %lc_en_o[%c1_i2] : <!hw.array<4xi4>>
    %29 = llhd.prb %gen_buffs_1.lc_en_out : i4
    llhd.drv %28, %29 after %1 : i4
    %30 = llhd.sig.array_get %lc_en_o[%c-2_i2] : <!hw.array<4xi4>>
    %31 = llhd.prb %gen_buffs_2.lc_en_out : i4
    llhd.drv %30, %31 after %1 : i4
    %32 = llhd.sig.array_get %lc_en_o[%c-1_i2] : <!hw.array<4xi4>>
    %33 = llhd.prb %gen_buffs_3.lc_en_out : i4
    llhd.drv %32, %33 after %1 : i4
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %lc_en_i_2, %lc_en_i after %1 : i4
    %34 = llhd.prb %lc_en_o : !hw.array<4xi4>
    hw.output %34 : !hw.array<4xi4>
  }
  hw.module private @prim_lc_sync_15(in %clk_i : i1, in %rst_ni : i1, in %lc_en_i : i4, out lc_en_o : !hw.array<8xi4>) {
    %c-1_i3 = hw.constant -1 : i3
    %c-2_i3 = hw.constant -2 : i3
    %c-3_i3 = hw.constant -3 : i3
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
    %2 = hw.aggregate_constant [0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4] : !hw.array<8xi4>
    %c0_i4 = hw.constant 0 : i4
    %c-6_i4 = hw.constant -6 : i4
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %lc_en_i_2 = llhd.sig name "lc_en_i" %c0_i4 : i4
    %lc_en_o = llhd.sig %2 : !hw.array<8xi4>
    %gen_no_flops.unused_logic = llhd.sig %c0_i4 : i4
    %gen_buffs_0.lc_en_out = llhd.sig %c0_i4 : i4
    %gen_buffs_1.lc_en_out = llhd.sig %c0_i4 : i4
    %gen_buffs_2.lc_en_out = llhd.sig %c0_i4 : i4
    %gen_buffs_3.lc_en_out = llhd.sig %c0_i4 : i4
    %gen_buffs_4.lc_en_out = llhd.sig %c0_i4 : i4
    %gen_buffs_5.lc_en_out = llhd.sig %c0_i4 : i4
    %gen_buffs_6.lc_en_out = llhd.sig %c0_i4 : i4
    %gen_buffs_7.lc_en_out = llhd.sig %c0_i4 : i4
    %5 = comb.extract %41 from 0 : (i4) -> i1
    %6 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %6, %gen_buffs_0.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %7 = comb.extract %41 from 1 : (i4) -> i1
    %8 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %8, %gen_buffs_0.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %9 = comb.extract %41 from 2 : (i4) -> i1
    %10 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %10, %gen_buffs_0.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %11 = comb.extract %41 from 3 : (i4) -> i1
    %12 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %12, %gen_buffs_0.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %13 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %13, %gen_buffs_1.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %14 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %14, %gen_buffs_1.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %15 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %15, %gen_buffs_1.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %16 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %16, %gen_buffs_1.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %17 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %17, %gen_buffs_2.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %18 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %18, %gen_buffs_2.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %19 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %19, %gen_buffs_2.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %20 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %20, %gen_buffs_2.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %21 = llhd.sig.extract %gen_buffs_3.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %21, %gen_buffs_3.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %22 = llhd.sig.extract %gen_buffs_3.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %22, %gen_buffs_3.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %23 = llhd.sig.extract %gen_buffs_3.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %23, %gen_buffs_3.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %24 = llhd.sig.extract %gen_buffs_3.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %24, %gen_buffs_3.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %25 = llhd.sig.extract %gen_buffs_4.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_4.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_4.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %25, %gen_buffs_4.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %26 = llhd.sig.extract %gen_buffs_4.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_4.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_4.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %26, %gen_buffs_4.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %27 = llhd.sig.extract %gen_buffs_4.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_4.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_4.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %27, %gen_buffs_4.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %28 = llhd.sig.extract %gen_buffs_4.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_4.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_4.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %28, %gen_buffs_4.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %29 = llhd.sig.extract %gen_buffs_5.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_5.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_5.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %29, %gen_buffs_5.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %30 = llhd.sig.extract %gen_buffs_5.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_5.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_5.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %30, %gen_buffs_5.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %31 = llhd.sig.extract %gen_buffs_5.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_5.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_5.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %31, %gen_buffs_5.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %32 = llhd.sig.extract %gen_buffs_5.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_5.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_5.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %32, %gen_buffs_5.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %33 = llhd.sig.extract %gen_buffs_6.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_6.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_6.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %33, %gen_buffs_6.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %34 = llhd.sig.extract %gen_buffs_6.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_6.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_6.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %34, %gen_buffs_6.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %35 = llhd.sig.extract %gen_buffs_6.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_6.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_6.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %35, %gen_buffs_6.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %36 = llhd.sig.extract %gen_buffs_6.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_6.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_6.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %36, %gen_buffs_6.gen_bits_3.u_prim_buf.out_o after %1 : i1
    %37 = llhd.sig.extract %gen_buffs_7.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_7.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_7.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %37, %gen_buffs_7.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %38 = llhd.sig.extract %gen_buffs_7.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_7.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_7.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %38, %gen_buffs_7.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %39 = llhd.sig.extract %gen_buffs_7.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_7.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_7.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %39, %gen_buffs_7.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %40 = llhd.sig.extract %gen_buffs_7.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_7.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_7.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %40, %gen_buffs_7.gen_bits_3.u_prim_buf.out_o after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %59 = llhd.prb %clk_i_0 : i1
      %60 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %61 = llhd.prb %clk_i_0 : i1
      %62 = comb.xor bin %59, %true : i1
      %63 = comb.and bin %62, %61 : i1
      %64 = llhd.prb %rst_ni_1 : i1
      %65 = comb.xor bin %64, %true : i1
      %66 = comb.and bin %60, %65 : i1
      %67 = comb.or bin %63, %66 : i1
      cf.cond_br %67, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %68 = llhd.prb %rst_ni_1 : i1
      %69 = comb.xor %68, %true : i1
      cf.cond_br %69, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_no_flops.unused_logic, %c-6_i4 after %0 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %70 = llhd.prb %lc_en_i_2 : i4
      llhd.drv %gen_no_flops.unused_logic, %70 after %0 : i4
      cf.br ^bb1
    }
    %41 = llhd.prb %lc_en_i_2 {sv.namehint = "lc_en"} : i4
    %42 = llhd.sig.array_get %lc_en_o[%c0_i3] : <!hw.array<8xi4>>
    %43 = llhd.prb %gen_buffs_0.lc_en_out : i4
    llhd.drv %42, %43 after %1 : i4
    %44 = llhd.sig.array_get %lc_en_o[%c1_i3] : <!hw.array<8xi4>>
    %45 = llhd.prb %gen_buffs_1.lc_en_out : i4
    llhd.drv %44, %45 after %1 : i4
    %46 = llhd.sig.array_get %lc_en_o[%c2_i3] : <!hw.array<8xi4>>
    %47 = llhd.prb %gen_buffs_2.lc_en_out : i4
    llhd.drv %46, %47 after %1 : i4
    %48 = llhd.sig.array_get %lc_en_o[%c3_i3] : <!hw.array<8xi4>>
    %49 = llhd.prb %gen_buffs_3.lc_en_out : i4
    llhd.drv %48, %49 after %1 : i4
    %50 = llhd.sig.array_get %lc_en_o[%c-4_i3] : <!hw.array<8xi4>>
    %51 = llhd.prb %gen_buffs_4.lc_en_out : i4
    llhd.drv %50, %51 after %1 : i4
    %52 = llhd.sig.array_get %lc_en_o[%c-3_i3] : <!hw.array<8xi4>>
    %53 = llhd.prb %gen_buffs_5.lc_en_out : i4
    llhd.drv %52, %53 after %1 : i4
    %54 = llhd.sig.array_get %lc_en_o[%c-2_i3] : <!hw.array<8xi4>>
    %55 = llhd.prb %gen_buffs_6.lc_en_out : i4
    llhd.drv %54, %55 after %1 : i4
    %56 = llhd.sig.array_get %lc_en_o[%c-1_i3] : <!hw.array<8xi4>>
    %57 = llhd.prb %gen_buffs_7.lc_en_out : i4
    llhd.drv %56, %57 after %1 : i4
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %lc_en_i_2, %lc_en_i after %1 : i4
    %58 = llhd.prb %lc_en_o : !hw.array<8xi4>
    hw.output %58 : !hw.array<8xi4>
  }
  hw.module private @lc_ctrl_fsm(in %clk_i : i1, in %rst_ni : i1, in %init_req_i : i1, out init_done_o : i1, out idle_o : i1, in %esc_scrap_state0_i : i1, in %esc_scrap_state1_i : i1, in %lc_state_valid_i : i1, in %lc_state_i : i320, in %lc_cnt_i : i384, in %secrets_valid_i : i4, in %use_ext_clock_i : i1, out ext_clock_switched_o : i1, in %volatile_raw_unlock_i : i1, out strap_en_override_o : i1, in %test_unlock_token_i : i128, in %test_exit_token_i : i128, in %test_tokens_valid_i : i4, in %rma_token_i : i128, in %rma_token_valid_i : i4, in %trans_cmd_i : i1, in %trans_target_i : !hw.array<6xi5>, out dec_lc_state_o : !hw.array<6xi5>, out dec_lc_cnt_o : i5, out dec_lc_id_state_o : i2, out token_hash_req_o : i1, out token_hash_req_chk_o : i1, in %token_hash_ack_i : i1, in %token_hash_err_i : i1, in %token_if_fsm_err_i : i1, in %hashed_token_i : i128, in %unhashed_token_i : i128, out otp_prog_req_o : i1, out otp_prog_lc_state_o : i320, out otp_prog_lc_cnt_o : i384, in %otp_prog_ack_i : i1, in %otp_prog_err_i : i1, out trans_success_o : i1, out trans_cnt_oflw_error_o : i1, out trans_invalid_error_o : i1, out token_invalid_error_o : i1, out nvm_rma_error_o : i1, out otp_prog_error_o : i1, out state_invalid_error_o : i1, out lc_raw_test_rma_o : i4, out lc_init_done_o : i4, out lc_dft_en_o : i4, out lc_nvm_debug_en_o : i4, out lc_hw_debug_clr_o : i4, out lc_hw_debug_en_o : i4, out lc_cpu_en_o : i4, out lc_creator_seed_sw_rw_en_o : i4, out lc_owner_seed_sw_rw_en_o : i4, out lc_iso_part_sw_rd_en_o : i4, out lc_iso_part_sw_wr_en_o : i4, out lc_seed_hw_rd_en_o : i4, out lc_rma_state_o : i4, out lc_keymgr_en_o : i4, out lc_escalate_en_o : i4, out lc_check_byp_en_o : i4, out lc_clk_byp_req_o : i4, in %lc_clk_byp_ack_i : i4, out lc_nvm_rma_req_o : i4, in %lc_nvm_rma_ack_i : !hw.array<2xi4>, out lc_keymgr_div_o : i128) {
    %0 = hw.aggregate_constant [[-3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, -4 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, -4 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, 0 : i3, 3 : i3, 3 : i3, 3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, -3 : i3, 3 : i3, 3 : i3, 3 : i3, 2 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, 0 : i3, 3 : i3, 3 : i3, 3 : i3, -3 : i3, 0 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, -3 : i3, 3 : i3, 3 : i3, 3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, 0 : i3, 3 : i3, 3 : i3, 3 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, -3 : i3, 3 : i3, 3 : i3, 3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, 0 : i3, 3 : i3, 3 : i3, 3 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, -3 : i3, 3 : i3, 3 : i3, 3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, 0 : i3, 3 : i3, 3 : i3, 3 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, -3 : i3, 3 : i3, 3 : i3, 3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, 0 : i3, 3 : i3, 3 : i3, 3 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, -3 : i3, 3 : i3, 3 : i3, 3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, 0 : i3, 3 : i3, 3 : i3, 3 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, -3 : i3, 3 : i3, 3 : i3, 3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, 0 : i3, 3 : i3, 3 : i3, 3 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, -3 : i3], [0 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, 1 : i3, -3 : i3, 1 : i3, -3 : i3, 1 : i3, -3 : i3, 1 : i3, -3 : i3, 1 : i3, -3 : i3, 1 : i3, -3 : i3, 1 : i3, -3 : i3, 1 : i3, -3 : i3]] : !hw.array<21xarray<21xi3>>
    %c-415641997_i30 = hw.constant -415641997 : i30
    %c0_i5 = hw.constant 0 : i5
    %c0_i27 = hw.constant 0 : i27
    %c-1_i3 = hw.constant -1 : i3
    %c-2_i3 = hw.constant -2 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c3_i3 = hw.constant 3 : i3
    %c2_i3 = hw.constant 2 : i3
    %c-6485808182601801875_i64 = hw.constant -6485808182601801875 : i64
    %c-784579923872994594_i64 = hw.constant -784579923872994594 : i64
    %c1_i3 = hw.constant 1 : i3
    %c-3043920565821176435_i64 = hw.constant -3043920565821176435 : i64
    %c4058359384547221489_i64 = hw.constant 4058359384547221489 : i64
    %c0_i3 = hw.constant 0 : i3
    %1 = hw.aggregate_constant [-1, -1, -1, -1, -1, -1, -1, -1] : !hw.array<8xi64>
    %2 = llhd.constant_time <0ns, 1d, 0e>
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %c0_i31 = hw.constant 0 : i31
    %c-1_i2 = hw.constant -1 : i2
    %3 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i64 = hw.constant 0 : i64
    %4 = hw.aggregate_constant [0, 0, 0, 0, 0, 0, 0, 0] : !hw.array<8xi64>
    %5 = hw.aggregate_constant [0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4] : !hw.array<8xi4>
    %c0_i6 = hw.constant 0 : i6
    %c0_i2 = hw.constant 0 : i2
    %c0_i16 = hw.constant 0 : i16
    %6 = hw.aggregate_constant [0 : i4, 0 : i4, 0 : i4] : !hw.array<3xi4>
    %7 = hw.aggregate_constant [0 : i4, 0 : i4] : !hw.array<2xi4>
    %8 = hw.aggregate_constant [0 : i4, 0 : i4, 0 : i4, 0 : i4] : !hw.array<4xi4>
    %c0_i4 = hw.constant 0 : i4
    %c0_i128 = hw.constant 0 : i128
    %9 = hw.aggregate_constant [0 : i5, 0 : i5, 0 : i5, 0 : i5, 0 : i5, 0 : i5] : !hw.array<6xi5>
    %c-3_i3 = hw.constant -3 : i3
    %c21_i32 = hw.constant 21 : i32
    %c0_i8 = hw.constant 0 : i8
    %c105_i8 = hw.constant 105 : i8
    %c12620_i16 = hw.constant 12620 : i16
    %c-16997_i16 = hw.constant -16997 : i16
    %c-32341_i16 = hw.constant -32341 : i16
    %c-10897_i16 = hw.constant -10897 : i16
    %c8384_i16 = hw.constant 8384 : i16
    %c-6001_i16 = hw.constant -6001 : i16
    %c-11713_i16 = hw.constant -11713 : i16
    %c28336_i16 = hw.constant 28336 : i16
    %c3156_i16 = hw.constant 3156 : i16
    %c13255_i16 = hw.constant 13255 : i16
    %c-54303400873254211277939491738915568855517463684010673349609841479124041226336157744059344899238_i320 = hw.constant -54303400873254211277939491738915568855517463684010673349609841479124041226336157744059344899238 : i320
    %c-456496308219428725069991543908571176442958431069049577004747167567363169282951950587742548544678_i320 = hw.constant -456496308219428725069991543908571176442958431069049577004747167567363169282951950587742548544678 : i320
    %c-456496308219428725069992223747441649870271937183805899370984814561761337221678801031624232160422_i320 = hw.constant -456496308219428725069992223747441649870271937183805899370984814561761337221678801031624232160422 : i320
    %c-456496308219428725069992223747441655294669495732793985256939044880764090660545683627503784971430_i320 = hw.constant -456496308219428725069992223747441655294669495732793985256939044880764090660545683627503784971430 : i320
    %c-456496308219428725069992223747441655294669496142203554028875401662036066712056987236735610932390_i320 = hw.constant -456496308219428725069992223747441655294669496142203554028875401662036066712056987236735610932390 : i320
    %c-456496308219428725069992223747441655294669496142203568053958862625652945713376621513158249303206_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958862625652945713376621513158249303206 : i320
    %c-456496308219428725069992223747441655294669496142203568053958864591903156752666814128945401580710_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958864591903156752666814128945401580710 : i320
    %c-456496308219428725069992223747441655294669496142203568053958864591903157416196240118574526385318_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958864591903157416196240118574526385318 : i320
    %c-456496308219428725069992223730586335313491493392502011291754234001596928066027634096378592775334_i320 = hw.constant -456496308219428725069992223730586335313491493392502011291754234001596928066027634096378592775334 : i320
    %c-456496308219428725069992223747441655293687836557898079325106876213185120734113905048550051302566_i320 = hw.constant -456496308219428725069992223747441655293687836557898079325106876213185120734113905048550051302566 : i320
    %c-456496308219428725069992223747441655294669496142014443709591861977795843821104929131164897004710_i320 = hw.constant -456496308219428725069992223747441655294669496142014443709591861977795843821104929131164897004710 : i320
    %c-456496308219428725069992223747441655294669496142203568053953436675435776818504807144494214302886_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053953436675435776818504807144494214302886 : i320
    %c-456496308219428725069992223747441655294669496142203568053958864591858254829874687572138464791718_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958864591858254829874687572138464791718 : i320
    %c-456496308219428725069992223747441655294669496142203568053958864591903157416196198460277973208230_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958864591903157416196198460277973208230 : i320
    %c-456496308219428725069992223747441655294669496142203568053958864591903157416196240123045587340454_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958864591903157416196240123045587340454 : i320
    %c-12599_i16 = hw.constant -12599 : i16
    %c27948_i16 = hw.constant 27948 : i16
    %c0_i320 = hw.constant 0 : i320
    %c-22447_i16 = hw.constant -22447 : i16
    %c-54303400856460749330691294731318814168796966260574554854209901008302709731210395309844007373990_i320 = hw.constant -54303400856460749330691294731318814168796966260574554854209901008302709731210395309844007373990 : i320
    %c0_i384 = hw.constant 0 : i384
    %c-456496308219428725069992223747441655294669496142203568053958864591903157416196240123047907839142_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958864591903157416196240123047907839142 : i320
    %c1965_i16 = hw.constant 1965 : i16
    %c-6_i4 = hw.constant -6 : i4
    %c-2372_i16 = hw.constant -2372 : i16
    %true = hw.constant true
    %false = hw.constant false
    %c1_i32 = hw.constant 1 : i32
    %c2_i32 = hw.constant 2 : i32
    %c0_i32 = hw.constant 0 : i32
    %c5_i4 = hw.constant 5 : i4
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %10 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %11 = llhd.prb %rst_ni_1 : i1
    %init_req_i_2 = llhd.sig name "init_req_i" %false : i1
    %init_done_o = llhd.sig %false : i1
    %idle_o = llhd.sig %false : i1
    %esc_scrap_state0_i_3 = llhd.sig name "esc_scrap_state0_i" %false : i1
    %esc_scrap_state1_i_4 = llhd.sig name "esc_scrap_state1_i" %false : i1
    %lc_state_i_5 = llhd.sig name "lc_state_i" %c0_i320 : i320
    %lc_cnt_i_6 = llhd.sig name "lc_cnt_i" %c0_i384 : i384
    %use_ext_clock_i_7 = llhd.sig name "use_ext_clock_i" %false : i1
    %volatile_raw_unlock_i_8 = llhd.sig name "volatile_raw_unlock_i" %false : i1
    %trans_cmd_i_9 = llhd.sig name "trans_cmd_i" %false : i1
    %trans_target_i_10 = llhd.sig name "trans_target_i" %9 : !hw.array<6xi5>
    %dec_lc_state_o = llhd.sig %9 : !hw.array<6xi5>
    %token_hash_req_o = llhd.sig %false : i1
    %token_hash_req_chk_o = llhd.sig %false : i1
    %token_hash_ack_i_11 = llhd.sig name "token_hash_ack_i" %false : i1
    %token_hash_err_i_12 = llhd.sig name "token_hash_err_i" %false : i1
    %token_if_fsm_err_i_13 = llhd.sig name "token_if_fsm_err_i" %false : i1
    %hashed_token_i_14 = llhd.sig name "hashed_token_i" %c0_i128 : i128
    %unhashed_token_i_15 = llhd.sig name "unhashed_token_i" %c0_i128 : i128
    %otp_prog_req_o = llhd.sig %false : i1
    %otp_prog_ack_i_16 = llhd.sig name "otp_prog_ack_i" %false : i1
    %otp_prog_err_i_17 = llhd.sig name "otp_prog_err_i" %false : i1
    %trans_success_o = llhd.sig %false : i1
    %trans_cnt_oflw_error_o = llhd.sig %false : i1
    %trans_invalid_error_o = llhd.sig %false : i1
    %token_invalid_error_o = llhd.sig %false : i1
    %nvm_rma_error_o = llhd.sig %false : i1
    %otp_prog_error_o = llhd.sig %false : i1
    %state_invalid_error_o = llhd.sig %false : i1
    %lc_check_byp_en_o = llhd.sig %c0_i4 : i4
    %lc_clk_byp_req_o = llhd.sig %c0_i4 : i4
    %lc_nvm_rma_req_o = llhd.sig %c0_i4 : i4
    %lc_clk_byp_ack = llhd.sig %8 : !hw.array<4xi4>
    %lc_nvm_rma_ack = llhd.sig %7 : !hw.array<2xi4>
    %lc_nvm_rma_ack_combined = llhd.sig %c0_i4 : i4
    %lc_nvm_rma_ack_buf = llhd.sig %6 : !hw.array<3xi4>
    %fsm_state_d = llhd.sig %c0_i16 : i16
    %fsm_state_q = llhd.sig %c0_i16 : i16
    %lc_state_valid_d = llhd.sig %false : i1
    %lc_state_valid_q = llhd.sig %false : i1
    %lc_state_d = llhd.sig %c0_i320 : i320
    %lc_state_q = llhd.sig %c0_i320 : i320
    %lc_cnt_d = llhd.sig %c0_i384 : i384
    %lc_cnt_q = llhd.sig %c0_i384 : i384
    %lc_clk_byp_req = llhd.sig %c0_i4 : i4
    %lc_nvm_rma_req = llhd.sig %c0_i4 : i4
    %lc_check_byp_en = llhd.sig %c0_i4 : i4
    %hashed_token_valid_mux = llhd.sig %c0_i2 : i2
    %hashed_token_mux = llhd.sig %c0_i128 : i128
    %state_invalid_error = llhd.sig %c0_i6 : i6
    %set_strap_en_override = llhd.sig %false : i1
    %volatile_raw_unlock_success_d = llhd.sig %c0_i8 : i8
    %volatile_raw_unlock_success_q = llhd.sig %c0_i8 : i8
    %rma_token_valid = llhd.sig %8 : !hw.array<4xi4>
    %test_tokens_valid = llhd.sig %5 : !hw.array<8xi4>
    %hashed_tokens_lower = llhd.sig %4 : !hw.array<8xi64>
    %hashed_tokens_upper = llhd.sig %4 : !hw.array<8xi64>
    %test_unlock_token_lower = llhd.sig %c0_i64 : i64
    %test_unlock_token_upper = llhd.sig %c0_i64 : i64
    %test_exit_token_lower = llhd.sig %c0_i64 : i64
    %test_exit_token_upper = llhd.sig %c0_i64 : i64
    %rma_token_lower = llhd.sig %c0_i64 : i64
    %rma_token_upper = llhd.sig %c0_i64 : i64
    %hashed_tokens_valid0 = llhd.sig %c0_i8 : i8
    %hashed_tokens_valid1 = llhd.sig %c0_i8 : i8
    %u_prim_lc_sync_clk_byp_ack.lc_en_o = hw.instance "u_prim_lc_sync_clk_byp_ack" @prim_lc_sync_8(clk_i: %10: i1, rst_ni: %11: i1, lc_en_i: %lc_clk_byp_ack_i: i4) -> (lc_en_o: !hw.array<4xi4>)
    llhd.drv %lc_clk_byp_ack, %u_prim_lc_sync_clk_byp_ack.lc_en_o after %3 : !hw.array<4xi4>
    %12 = hw.array_get %lc_nvm_rma_ack_i[%false] : !hw.array<2xi4>, i1
    %13 = llhd.sig.array_get %lc_nvm_rma_ack[%false] : <!hw.array<2xi4>>
    %gen_syncs_0.u_prim_lc_sync_nvm_rma_ack.lc_en_o = hw.instance "gen_syncs_0.u_prim_lc_sync_nvm_rma_ack" @prim_lc_sync_9(clk_i: %10: i1, rst_ni: %11: i1, lc_en_i: %12: i4) -> (lc_en_o: !hw.array<1xi4>)
    %14 = hw.bitcast %gen_syncs_0.u_prim_lc_sync_nvm_rma_ack.lc_en_o : (!hw.array<1xi4>) -> i4
    llhd.drv %13, %14 after %3 : i4
    %15 = hw.array_get %lc_nvm_rma_ack_i[%true] : !hw.array<2xi4>, i1
    %16 = llhd.sig.array_get %lc_nvm_rma_ack[%true] : <!hw.array<2xi4>>
    %gen_syncs_1.u_prim_lc_sync_nvm_rma_ack.lc_en_o = hw.instance "gen_syncs_1.u_prim_lc_sync_nvm_rma_ack" @prim_lc_sync_9(clk_i: %10: i1, rst_ni: %11: i1, lc_en_i: %15: i4) -> (lc_en_o: !hw.array<1xi4>)
    %17 = hw.bitcast %gen_syncs_1.u_prim_lc_sync_nvm_rma_ack.lc_en_o : (!hw.array<1xi4>) -> i4
    llhd.drv %16, %17 after %3 : i4
    %18 = llhd.prb %lc_nvm_rma_ack_combined : i4
    %u_prim_lc_sync_nvm_rma_ack_buf.lc_en_o = hw.instance "u_prim_lc_sync_nvm_rma_ack_buf" @prim_lc_sync_10(clk_i: %10: i1, rst_ni: %11: i1, lc_en_i: %18: i4) -> (lc_en_o: !hw.array<3xi4>)
    llhd.drv %lc_nvm_rma_ack_buf, %u_prim_lc_sync_nvm_rma_ack_buf.lc_en_o after %3 : !hw.array<3xi4>
    %19 = llhd.prb %fsm_state_d : i16
    %u_fsm_state_regs.state_o = hw.instance "u_fsm_state_regs" @prim_sparse_fsm_flop_11(clk_i: %10: i1, rst_ni: %11: i1, state_i: %19: i16) -> (state_o: i16)
    llhd.drv %fsm_state_q, %u_fsm_state_regs.state_o after %3 : i16
    %20 = llhd.prb %lc_state_d : i320
    %u_state_regs.state_o = hw.instance "u_state_regs" @prim_sparse_fsm_flop_12(clk_i: %10: i1, rst_ni: %11: i1, state_i: %20: i320) -> (state_o: i320)
    llhd.drv %lc_state_q, %u_state_regs.state_o after %3 : i320
    %21 = llhd.prb %lc_cnt_d : i384
    %u_cnt_regs.state_o = hw.instance "u_cnt_regs" @prim_sparse_fsm_flop_13(clk_i: %10: i1, rst_ni: %11: i1, state_i: %21: i384) -> (state_o: i384)
    llhd.drv %lc_cnt_q, %u_cnt_regs.state_o after %3 : i384
    %u_prim_lc_sync_rma_token_valid.lc_en_o = hw.instance "u_prim_lc_sync_rma_token_valid" @prim_lc_sync_14(clk_i: %10: i1, rst_ni: %11: i1, lc_en_i: %rma_token_valid_i: i4) -> (lc_en_o: !hw.array<4xi4>)
    llhd.drv %rma_token_valid, %u_prim_lc_sync_rma_token_valid.lc_en_o after %3 : !hw.array<4xi4>
    %u_prim_lc_sync_test_token_valid.lc_en_o = hw.instance "u_prim_lc_sync_test_token_valid" @prim_lc_sync_15(clk_i: %10: i1, rst_ni: %11: i1, lc_en_i: %test_tokens_valid_i: i4) -> (lc_en_o: !hw.array<8xi4>)
    llhd.drv %test_tokens_valid, %u_prim_lc_sync_test_token_valid.lc_en_o after %3 : !hw.array<8xi4>
    %22 = llhd.prb %lc_state_valid_q : i1
    %23 = llhd.prb %lc_state_q : i320
    %24 = llhd.prb %lc_cnt_q : i384
    %25 = llhd.prb %fsm_state_q : i16
    %u_lc_ctrl_state_decode.dec_lc_state_o, %u_lc_ctrl_state_decode.dec_lc_id_state_o, %u_lc_ctrl_state_decode.dec_lc_cnt_o, %u_lc_ctrl_state_decode.state_invalid_error_o = hw.instance "u_lc_ctrl_state_decode" @lc_ctrl_state_decode(lc_state_valid_i: %22: i1, lc_state_i: %23: i320, lc_cnt_i: %24: i384, secrets_valid_i: %secrets_valid_i: i4, fsm_state_i: %25: i16) -> (dec_lc_state_o: !hw.array<6xi5>, dec_lc_id_state_o: i2, dec_lc_cnt_o: i5, state_invalid_error_o: i6)
    llhd.drv %dec_lc_state_o, %u_lc_ctrl_state_decode.dec_lc_state_o after %3 : !hw.array<6xi5>
    llhd.drv %state_invalid_error, %u_lc_ctrl_state_decode.state_invalid_error_o after %3 : i6
    %26 = llhd.prb %dec_lc_state_o : !hw.array<6xi5>
    %27 = llhd.prb %trans_target_i_10 : !hw.array<6xi5>
    %28 = llhd.prb %volatile_raw_unlock_i_8 : i1
    %29 = llhd.prb %trans_cmd_i_9 : i1
    %u_lc_ctrl_state_transition.next_lc_state_o, %u_lc_ctrl_state_transition.next_lc_cnt_o, %u_lc_ctrl_state_transition.trans_cnt_oflw_error_o, %u_lc_ctrl_state_transition.trans_invalid_error_o = hw.instance "u_lc_ctrl_state_transition" @lc_ctrl_state_transition(lc_state_i: %23: i320, lc_cnt_i: %24: i384, fsm_state_i: %25: i16, dec_lc_state_i: %26: !hw.array<6xi5>, trans_target_i: %27: !hw.array<6xi5>, volatile_raw_unlock_i: %28: i1, trans_cmd_i: %29: i1) -> (next_lc_state_o: i320, next_lc_cnt_o: i384, trans_cnt_oflw_error_o: i1, trans_invalid_error_o: i1) {sv.namehint = "next_lc_cnt"}
    llhd.drv %trans_cnt_oflw_error_o, %u_lc_ctrl_state_transition.trans_cnt_oflw_error_o after %3 : i1
    %u_lc_ctrl_signal_decode.lc_raw_test_rma_o, %u_lc_ctrl_signal_decode.lc_init_done_o, %u_lc_ctrl_signal_decode.lc_dft_en_o, %u_lc_ctrl_signal_decode.lc_nvm_debug_en_o, %u_lc_ctrl_signal_decode.lc_hw_debug_clr_o, %u_lc_ctrl_signal_decode.lc_hw_debug_en_o, %u_lc_ctrl_signal_decode.lc_cpu_en_o, %u_lc_ctrl_signal_decode.lc_creator_seed_sw_rw_en_o, %u_lc_ctrl_signal_decode.lc_owner_seed_sw_rw_en_o, %u_lc_ctrl_signal_decode.lc_iso_part_sw_rd_en_o, %u_lc_ctrl_signal_decode.lc_iso_part_sw_wr_en_o, %u_lc_ctrl_signal_decode.lc_seed_hw_rd_en_o, %u_lc_ctrl_signal_decode.lc_rma_state_o, %u_lc_ctrl_signal_decode.lc_keymgr_en_o, %u_lc_ctrl_signal_decode.lc_escalate_en_o, %u_lc_ctrl_signal_decode.lc_keymgr_div_o = hw.instance "u_lc_ctrl_signal_decode" @lc_ctrl_signal_decode(clk_i: %10: i1, rst_ni: %11: i1, lc_state_valid_i: %22: i1, lc_state_i: %23: i320, fsm_state_i: %25: i16, secrets_valid_i: %secrets_valid_i: i4) -> (lc_raw_test_rma_o: i4, lc_init_done_o: i4, lc_dft_en_o: i4, lc_nvm_debug_en_o: i4, lc_hw_debug_clr_o: i4, lc_hw_debug_en_o: i4, lc_cpu_en_o: i4, lc_creator_seed_sw_rw_en_o: i4, lc_owner_seed_sw_rw_en_o: i4, lc_iso_part_sw_rd_en_o: i4, lc_iso_part_sw_wr_en_o: i4, lc_seed_hw_rd_en_o: i4, lc_rma_state_o: i4, lc_keymgr_en_o: i4, lc_escalate_en_o: i4, lc_keymgr_div_o: i128)
    %30 = llhd.prb %lc_clk_byp_req : i4
    %u_prim_lc_sender_clk_byp_req.lc_en_o = hw.instance "u_prim_lc_sender_clk_byp_req" @prim_lc_sender(clk_i: %10: i1, rst_ni: %11: i1, lc_en_i: %30: i4) -> (lc_en_o: i4)
    llhd.drv %lc_clk_byp_req_o, %u_prim_lc_sender_clk_byp_req.lc_en_o after %3 : i4
    %31 = llhd.prb %lc_nvm_rma_req : i4
    %u_prim_lc_sender_nvm_rma_req.lc_en_o = hw.instance "u_prim_lc_sender_nvm_rma_req" @prim_lc_sender(clk_i: %10: i1, rst_ni: %11: i1, lc_en_i: %31: i4) -> (lc_en_o: i4)
    llhd.drv %lc_nvm_rma_req_o, %u_prim_lc_sender_nvm_rma_req.lc_en_o after %3 : i4
    %32 = llhd.prb %lc_check_byp_en : i4
    %u_prim_lc_sender_check_byp_en.lc_en_o = hw.instance "u_prim_lc_sender_check_byp_en" @prim_lc_sender(clk_i: %10: i1, rst_ni: %11: i1, lc_en_i: %32: i4) -> (lc_en_o: i4)
    llhd.drv %lc_check_byp_en_o, %u_prim_lc_sender_check_byp_en.lc_en_o after %3 : i4
    %33 = llhd.prb %lc_clk_byp_ack : !hw.array<4xi4>
    %34 = hw.array_get %33[%c-1_i2] : !hw.array<4xi4>, i2
    %35 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%34) : (i4) -> i1
    %36 = llhd.prb %lc_nvm_rma_ack : !hw.array<2xi4>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb4
      llhd.drv %lc_nvm_rma_ack_combined, %c5_i4 after %3 : i4
      cf.br ^bb2(%c0_i32 : i32)
    ^bb2(%122: i32):  // 2 preds: ^bb1, ^bb3
      %123 = comb.icmp ult %122, %c2_i32 : i32
      cf.cond_br %123, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %124 = llhd.prb %lc_nvm_rma_ack_combined : i4
      %125 = llhd.prb %lc_nvm_rma_ack : !hw.array<2xi4>
      %126 = comb.extract %122 from 1 : (i32) -> i31
      %127 = comb.extract %122 from 0 : (i32) -> i1
      %128 = comb.icmp ne %126, %c0_i31 : i31
      %129 = comb.or %128, %127 : i1
      %130 = hw.array_get %125[%129] : !hw.array<2xi4>, i1
      %131 = func.call @"lc_ctrl_pkg::lc_tx_and_hi"(%124, %130) : (i4, i4) -> i4
      llhd.drv %lc_nvm_rma_ack_combined, %131 after %3 : i4
      %132 = comb.add %122, %c1_i32 : i32
      cf.br ^bb2(%132 : i32)
    ^bb4:  // pred: ^bb2
      llhd.wait (%18, %36 : i4, !hw.array<2xi4>), ^bb1
    }
    llhd.drv %lc_state_valid_d, %lc_state_valid_i after %3 : i1
    %37 = llhd.prb %token_hash_req_o : i1
    %38 = llhd.prb %token_hash_req_chk_o : i1
    %39 = llhd.prb %otp_prog_req_o : i1
    %40 = llhd.prb %token_invalid_error_o : i1
    %41 = llhd.prb %otp_prog_error_o : i1
    %42 = llhd.prb %nvm_rma_error_o : i1
    %43 = llhd.prb %trans_success_o : i1
    %44 = llhd.prb %state_invalid_error_o : i1
    %45 = llhd.prb %init_done_o : i1
    %46 = llhd.prb %idle_o : i1
    %47 = llhd.prb %set_strap_en_override : i1
    %48 = llhd.prb %volatile_raw_unlock_success_q : i8
    %49 = llhd.prb %volatile_raw_unlock_success_d : i8
    %50 = llhd.prb %lc_clk_byp_req_o : i4
    %51 = llhd.prb %lc_nvm_rma_req_o : i4
    %52 = llhd.prb %lc_check_byp_en_o : i4
    %53 = llhd.prb %init_req_i_2 : i1
    %54 = llhd.prb %lc_state_i_5 : i320
    %55 = llhd.prb %lc_cnt_i_6 : i384
    %56 = llhd.prb %esc_scrap_state0_i_3 : i1
    %57 = llhd.prb %esc_scrap_state1_i_4 : i1
    %58 = llhd.prb %state_invalid_error : i6
    %59 = llhd.prb %token_if_fsm_err_i_13 : i1
    %60 = llhd.prb %use_ext_clock_i_7 : i1
    %61 = llhd.prb %trans_invalid_error_o : i1
    %62 = llhd.prb %unhashed_token_i_15 : i128
    %63 = llhd.prb %trans_cnt_oflw_error_o : i1
    %64 = llhd.prb %otp_prog_ack_i_16 : i1
    %65 = llhd.prb %otp_prog_err_i_17 : i1
    %66 = llhd.prb %token_hash_ack_i_11 : i1
    %67 = llhd.prb %hashed_token_i_14 : i128
    %68 = llhd.prb %hashed_token_mux : i128
    %69 = llhd.prb %token_hash_err_i_12 : i1
    %70 = llhd.prb %hashed_token_valid_mux : i2
    %71 = llhd.prb %lc_nvm_rma_ack_buf : !hw.array<3xi4>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb73
      %122 = llhd.prb %fsm_state_q : i16
      llhd.drv %fsm_state_d, %122 after %3 : i16
      %123 = llhd.prb %lc_state_q : i320
      llhd.drv %lc_state_d, %123 after %3 : i320
      %124 = llhd.prb %lc_cnt_q : i384
      llhd.drv %lc_cnt_d, %124 after %3 : i384
      llhd.drv %token_hash_req_o, %false after %3 : i1
      llhd.drv %token_hash_req_chk_o, %true after %3 : i1
      llhd.drv %otp_prog_req_o, %false after %3 : i1
      llhd.drv %token_invalid_error_o, %false after %3 : i1
      llhd.drv %otp_prog_error_o, %false after %3 : i1
      llhd.drv %nvm_rma_error_o, %false after %3 : i1
      llhd.drv %trans_success_o, %false after %3 : i1
      llhd.drv %state_invalid_error_o, %false after %3 : i1
      llhd.drv %init_done_o, %true after %3 : i1
      llhd.drv %idle_o, %false after %3 : i1
      llhd.drv %set_strap_en_override, %false after %3 : i1
      %125 = llhd.prb %volatile_raw_unlock_success_q : i8
      llhd.drv %volatile_raw_unlock_success_d, %125 after %3 : i8
      %126 = llhd.prb %lc_clk_byp_req_o : i4
      llhd.drv %lc_clk_byp_req, %126 after %3 : i4
      %127 = llhd.prb %lc_nvm_rma_req_o : i4
      llhd.drv %lc_nvm_rma_req, %127 after %3 : i4
      %128 = llhd.prb %lc_check_byp_en_o : i4
      llhd.drv %lc_check_byp_en, %128 after %3 : i4
      %129 = llhd.prb %fsm_state_q : i16
      %130 = comb.icmp ceq %129, %c-2372_i16 : i16
      cf.cond_br %130, ^bb2, ^bb4
    ^bb2:  // pred: ^bb1
      llhd.drv %init_done_o, %false after %3 : i1
      llhd.drv %lc_clk_byp_req, %c-6_i4 after %3 : i4
      llhd.drv %lc_nvm_rma_req, %c-6_i4 after %3 : i4
      llhd.drv %lc_check_byp_en, %c-6_i4 after %3 : i4
      %131 = llhd.prb %init_req_i_2 : i1
      %132 = llhd.prb %lc_state_valid_q : i1
      %133 = comb.and %131, %132 : i1
      cf.cond_br %133, ^bb3, ^bb69
    ^bb3:  // pred: ^bb2
      llhd.drv %fsm_state_d, %c1965_i16 after %3 : i16
      %134 = llhd.prb %lc_state_i_5 : i320
      llhd.drv %lc_state_d, %134 after %3 : i320
      %135 = llhd.prb %lc_cnt_i_6 : i384
      llhd.drv %lc_cnt_d, %135 after %3 : i384
      cf.br ^bb69
    ^bb4:  // pred: ^bb1
      %136 = comb.icmp ceq %129, %c1965_i16 : i16
      cf.cond_br %136, ^bb5, ^bb12
    ^bb5:  // pred: ^bb4
      llhd.drv %idle_o, %true after %3 : i1
      %137 = llhd.prb %volatile_raw_unlock_success_q : i8
      %138 = func.call @"prim_mubi_pkg::mubi8_test_false_loose"(%137) : (i8) -> i1
      %139 = llhd.prb %lc_state_i_5 : i320
      llhd.drv %lc_state_d, %139 after %3 : i320
      %140 = llhd.prb %lc_cnt_i_6 : i384
      llhd.drv %lc_cnt_d, %140 after %3 : i384
      %141 = llhd.prb %lc_state_q : i320
      %142 = comb.icmp eq %141, %c-54303400856460749330691294731318814168796966260574554854209901008302709731210395309844007373990_i320 : i320
      cf.cond_br %142, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %fsm_state_d, %c-22447_i16 after %3 : i16
      cf.br ^bb9
    ^bb7:  // pred: ^bb5
      %143 = llhd.prb %trans_cmd_i_9 : i1
      cf.cond_br %143, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %fsm_state_d, %c-12599_i16 after %3 : i16
      cf.br ^bb9
    ^bb9:  // 3 preds: ^bb6, ^bb7, ^bb8
      %144 = llhd.prb %lc_state_q : i320
      %145 = comb.icmp weq %144, %c0_i320 : i320
      %146 = comb.icmp weq %144, %c-456496308219428725069992223747441655294669496142203568053958864591903157416196240123045587340454_i320 : i320
      %147 = comb.icmp weq %144, %c-456496308219428725069992223747441655294669496142203568053958864591903157416196198460277973208230_i320 : i320
      %148 = comb.icmp weq %144, %c-456496308219428725069992223747441655294669496142203568053958864591858254829874687572138464791718_i320 : i320
      %149 = comb.icmp weq %144, %c-456496308219428725069992223747441655294669496142203568053953436675435776818504807144494214302886_i320 : i320
      %150 = comb.icmp weq %144, %c-456496308219428725069992223747441655294669496142014443709591861977795843821104929131164897004710_i320 : i320
      %151 = comb.icmp weq %144, %c-456496308219428725069992223747441655293687836557898079325106876213185120734113905048550051302566_i320 : i320
      %152 = comb.icmp weq %144, %c-456496308219428725069992223730586335313491493392502011291754234001596928066027634096378592775334_i320 : i320
      %153 = comb.icmp weq %144, %c-456496308219428725069992223747441655294669496142203568053958864591903157416196240123047907839142_i320 : i320
      %154 = comb.icmp weq %144, %c-456496308219428725069992223747441655294669496142203568053958864591903157416196240118574526385318_i320 : i320
      %155 = comb.icmp weq %144, %c-456496308219428725069992223747441655294669496142203568053958864591903156752666814128945401580710_i320 : i320
      %156 = comb.icmp weq %144, %c-456496308219428725069992223747441655294669496142203568053958862625652945713376621513158249303206_i320 : i320
      %157 = comb.icmp weq %144, %c-456496308219428725069992223747441655294669496142203554028875401662036066712056987236735610932390_i320 : i320
      %158 = comb.icmp weq %144, %c-456496308219428725069992223747441655294669495732793985256939044880764090660545683627503784971430_i320 : i320
      %159 = comb.icmp weq %144, %c-456496308219428725069992223747441649870271937183805899370984814561761337221678801031624232160422_i320 : i320
      %160 = comb.icmp weq %144, %c-456496308219428725069991543908571176442958431069049577004747167567363169282951950587742548544678_i320 : i320
      %161 = comb.icmp weq %144, %c-54303400873254211277939491738915568855517463684010673349609841479124041226336157744059344899238_i320 : i320
      %162 = comb.or %145, %146, %147, %148, %149, %150, %151, %152, %153, %154, %155, %156, %157, %158, %159, %160, %161 : i1
      cf.cond_br %162, ^bb10, ^bb69
    ^bb10:  // pred: ^bb9
      %163 = llhd.prb %use_ext_clock_i_7 : i1
      cf.cond_br %163, ^bb11, ^bb69
    ^bb11:  // pred: ^bb10
      llhd.drv %lc_clk_byp_req, %c5_i4 after %3 : i4
      cf.br ^bb69
    ^bb12:  // pred: ^bb4
      %164 = comb.icmp ceq %129, %c-12599_i16 : i16
      cf.cond_br %164, ^bb13, ^bb19
    ^bb13:  // pred: ^bb12
      llhd.drv %lc_check_byp_en, %c5_i4 after %3 : i4
      %165 = llhd.prb %lc_state_q : i320
      %166 = comb.icmp weq %165, %c0_i320 : i320
      %167 = comb.icmp weq %165, %c-456496308219428725069992223747441655294669496142203568053958864591903157416196240123045587340454_i320 : i320
      %168 = comb.icmp weq %165, %c-456496308219428725069992223747441655294669496142203568053958864591903157416196198460277973208230_i320 : i320
      %169 = comb.icmp weq %165, %c-456496308219428725069992223747441655294669496142203568053958864591858254829874687572138464791718_i320 : i320
      %170 = comb.icmp weq %165, %c-456496308219428725069992223747441655294669496142203568053953436675435776818504807144494214302886_i320 : i320
      %171 = comb.icmp weq %165, %c-456496308219428725069992223747441655294669496142014443709591861977795843821104929131164897004710_i320 : i320
      %172 = comb.icmp weq %165, %c-456496308219428725069992223747441655293687836557898079325106876213185120734113905048550051302566_i320 : i320
      %173 = comb.icmp weq %165, %c-456496308219428725069992223730586335313491493392502011291754234001596928066027634096378592775334_i320 : i320
      %174 = comb.icmp weq %165, %c-456496308219428725069992223747441655294669496142203568053958864591903157416196240123047907839142_i320 : i320
      %175 = comb.icmp weq %165, %c-456496308219428725069992223747441655294669496142203568053958864591903157416196240118574526385318_i320 : i320
      %176 = comb.icmp weq %165, %c-456496308219428725069992223747441655294669496142203568053958864591903156752666814128945401580710_i320 : i320
      %177 = comb.icmp weq %165, %c-456496308219428725069992223747441655294669496142203568053958862625652945713376621513158249303206_i320 : i320
      %178 = comb.icmp weq %165, %c-456496308219428725069992223747441655294669496142203554028875401662036066712056987236735610932390_i320 : i320
      %179 = comb.icmp weq %165, %c-456496308219428725069992223747441655294669495732793985256939044880764090660545683627503784971430_i320 : i320
      %180 = comb.icmp weq %165, %c-456496308219428725069992223747441649870271937183805899370984814561761337221678801031624232160422_i320 : i320
      %181 = comb.icmp weq %165, %c-456496308219428725069991543908571176442958431069049577004747167567363169282951950587742548544678_i320 : i320
      %182 = comb.icmp weq %165, %c-54303400873254211277939491738915568855517463684010673349609841479124041226336157744059344899238_i320 : i320
      %183 = comb.or %166, %167, %168, %169, %170, %171, %172, %173, %174, %175, %176, %177, %178, %179, %180, %181, %182 : i1
      cf.cond_br %183, ^bb14, ^bb18
    ^bb14:  // pred: ^bb13
      %184 = llhd.prb %use_ext_clock_i_7 : i1
      cf.cond_br %184, ^bb15, ^bb17
    ^bb15:  // pred: ^bb14
      llhd.drv %lc_clk_byp_req, %c5_i4 after %3 : i4
      %185 = llhd.prb %lc_clk_byp_ack : !hw.array<4xi4>
      %186 = hw.array_get %185[%c0_i2] : !hw.array<4xi4>, i2
      %187 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%186) : (i4) -> i1
      cf.cond_br %187, ^bb16, ^bb69
    ^bb16:  // pred: ^bb15
      llhd.drv %fsm_state_d, %c13255_i16 after %3 : i16
      cf.br ^bb69
    ^bb17:  // pred: ^bb14
      llhd.drv %fsm_state_d, %c13255_i16 after %3 : i16
      cf.br ^bb69
    ^bb18:  // pred: ^bb13
      llhd.drv %fsm_state_d, %c13255_i16 after %3 : i16
      cf.br ^bb69
    ^bb19:  // pred: ^bb12
      %188 = comb.icmp ceq %129, %c13255_i16 : i16
      cf.cond_br %188, ^bb20, ^bb23
    ^bb20:  // pred: ^bb19
      %189 = llhd.prb %trans_cnt_oflw_error_o : i1
      cf.cond_br %189, ^bb21, ^bb22
    ^bb21:  // pred: ^bb20
      llhd.drv %fsm_state_d, %c27948_i16 after %3 : i16
      cf.br ^bb69
    ^bb22:  // pred: ^bb20
      llhd.drv %fsm_state_d, %c3156_i16 after %3 : i16
      cf.br ^bb69
    ^bb23:  // pred: ^bb19
      %190 = comb.icmp ceq %129, %c3156_i16 : i16
      cf.cond_br %190, ^bb24, ^bb30
    ^bb24:  // pred: ^bb23
      llhd.drv %otp_prog_req_o, %true after %3 : i1
      %191 = llhd.prb %lc_clk_byp_req_o : i4
      %192 = llhd.prb %lc_clk_byp_ack : !hw.array<4xi4>
      %193 = hw.array_get %192[%c1_i2] : !hw.array<4xi4>, i2
      %194 = comb.icmp ne %191, %193 : i4
      cf.cond_br %194, ^bb25, ^bb26
    ^bb25:  // pred: ^bb24
      llhd.drv %fsm_state_d, %c27948_i16 after %3 : i16
      llhd.drv %otp_prog_error_o, %true after %3 : i1
      cf.br ^bb26
    ^bb26:  // 2 preds: ^bb24, ^bb25
      %195 = llhd.prb %otp_prog_ack_i_16 : i1
      cf.cond_br %195, ^bb27, ^bb69
    ^bb27:  // pred: ^bb26
      %196 = llhd.prb %otp_prog_err_i_17 : i1
      cf.cond_br %196, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      llhd.drv %fsm_state_d, %c27948_i16 after %3 : i16
      llhd.drv %otp_prog_error_o, %true after %3 : i1
      cf.br ^bb69
    ^bb29:  // pred: ^bb27
      llhd.drv %fsm_state_d, %c28336_i16 after %3 : i16
      cf.br ^bb69
    ^bb30:  // pred: ^bb23
      %197 = comb.icmp ceq %129, %c28336_i16 : i16
      cf.cond_br %197, ^bb31, ^bb34
    ^bb31:  // pred: ^bb30
      %198 = llhd.prb %trans_invalid_error_o : i1
      cf.cond_br %198, ^bb32, ^bb33
    ^bb32:  // pred: ^bb31
      llhd.drv %fsm_state_d, %c27948_i16 after %3 : i16
      cf.br ^bb69
    ^bb33:  // pred: ^bb31
      llhd.drv %fsm_state_d, %c-11713_i16 after %3 : i16
      cf.br ^bb69
    ^bb34:  // pred: ^bb30
      %199 = comb.icmp ceq %129, %c-11713_i16 : i16
      cf.cond_br %199, ^bb35, ^bb39
    ^bb35:  // pred: ^bb34
      llhd.drv %token_hash_req_o, %true after %3 : i1
      %200 = llhd.prb %token_hash_ack_i_11 : i1
      cf.cond_br %200, ^bb36, ^bb69
    ^bb36:  // pred: ^bb35
      %201 = llhd.prb %hashed_token_i_14 : i128
      %202 = llhd.prb %hashed_token_mux : i128
      %203 = comb.icmp eq %201, %202 : i128
      %204 = llhd.prb %token_hash_err_i_12 : i1
      %205 = comb.xor %204, %true : i1
      %206 = llhd.prb %hashed_token_valid_mux : i2
      %207 = comb.icmp eq %206, %c-1_i2 : i2
      %208 = comb.and %203, %205, %207 : i1
      cf.cond_br %208, ^bb37, ^bb38
    ^bb37:  // pred: ^bb36
      llhd.drv %fsm_state_d, %c-6001_i16 after %3 : i16
      cf.br ^bb69
    ^bb38:  // pred: ^bb36
      llhd.drv %fsm_state_d, %c27948_i16 after %3 : i16
      llhd.drv %token_invalid_error_o, %true after %3 : i1
      cf.br ^bb69
    ^bb39:  // pred: ^bb34
      %209 = comb.icmp ceq %129, %c-6001_i16 : i16
      cf.cond_br %209, ^bb40, ^bb44
    ^bb40:  // pred: ^bb39
      %210 = llhd.prb %trans_target_i_10 : !hw.array<6xi5>
      %211 = hw.bitcast %210 : (!hw.array<6xi5>) -> i30
      %212 = comb.icmp eq %211, %c-415641997_i30 : i30
      cf.cond_br %212, ^bb41, ^bb43
    ^bb41:  // pred: ^bb40
      llhd.drv %lc_nvm_rma_req, %c5_i4 after %3 : i4
      %213 = llhd.prb %lc_nvm_rma_ack_buf : !hw.array<3xi4>
      %214 = hw.array_get %213[%c0_i2] : !hw.array<3xi4>, i2
      %215 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%214) : (i4) -> i1
      cf.cond_br %215, ^bb42, ^bb69
    ^bb42:  // pred: ^bb41
      llhd.drv %fsm_state_d, %c8384_i16 after %3 : i16
      cf.br ^bb69
    ^bb43:  // pred: ^bb40
      llhd.drv %fsm_state_d, %c8384_i16 after %3 : i16
      cf.br ^bb69
    ^bb44:  // pred: ^bb39
      %216 = comb.icmp ceq %129, %c8384_i16 : i16
      cf.cond_br %216, ^bb46, ^bb45
    ^bb45:  // pred: ^bb44
      %217 = comb.icmp ceq %129, %c-10897_i16 : i16
      cf.cond_br %217, ^bb46, ^bb55
    ^bb46:  // 2 preds: ^bb44, ^bb45
      %218 = llhd.prb %trans_invalid_error_o : i1
      cf.cond_br %218, ^bb47, ^bb48
    ^bb47:  // pred: ^bb46
      llhd.drv %fsm_state_d, %c27948_i16 after %3 : i16
      cf.br ^bb69
    ^bb48:  // pred: ^bb46
      %219 = llhd.prb %trans_target_i_10 : !hw.array<6xi5>
      %220 = hw.bitcast %219 : (!hw.array<6xi5>) -> i30
      %221 = comb.icmp ne %220, %c-415641997_i30 : i30
      %222 = llhd.prb %lc_nvm_rma_req_o : i4
      %223 = func.call @"lc_ctrl_pkg::lc_tx_test_false_strict"(%222) : (i4) -> i1
      %224 = llhd.prb %lc_nvm_rma_ack_buf : !hw.array<3xi4>
      %225 = hw.array_get %224[%c1_i2] : !hw.array<3xi4>, i2
      %226 = func.call @"lc_ctrl_pkg::lc_tx_test_false_strict"(%225) : (i4) -> i1
      %227 = comb.and %221, %223, %226 : i1
      %228 = llhd.prb %trans_target_i_10 : !hw.array<6xi5>
      %229 = hw.bitcast %228 : (!hw.array<6xi5>) -> i30
      %230 = comb.icmp eq %229, %c-415641997_i30 : i30
      %231 = llhd.prb %lc_nvm_rma_req_o : i4
      %232 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%231) : (i4) -> i1
      %233 = llhd.prb %lc_nvm_rma_ack_buf : !hw.array<3xi4>
      %234 = hw.array_get %233[%c1_i2] : !hw.array<3xi4>, i2
      %235 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%234) : (i4) -> i1
      %236 = comb.and %230, %232, %235 : i1
      %237 = comb.or %227, %236 : i1
      cf.cond_br %237, ^bb49, ^bb54
    ^bb49:  // pred: ^bb48
      %238 = llhd.prb %hashed_token_i_14 : i128
      %239 = llhd.prb %hashed_token_mux : i128
      %240 = comb.icmp eq %238, %239 : i128
      %241 = llhd.prb %token_hash_err_i_12 : i1
      %242 = comb.xor %241, %true : i1
      %243 = llhd.prb %hashed_token_valid_mux : i2
      %244 = comb.icmp eq %243, %c-1_i2 : i2
      %245 = comb.and %240, %242, %244 : i1
      cf.cond_br %245, ^bb50, ^bb53
    ^bb50:  // pred: ^bb49
      %246 = llhd.prb %fsm_state_q : i16
      %247 = comb.icmp eq %246, %c-10897_i16 : i16
      cf.cond_br %247, ^bb51, ^bb52
    ^bb51:  // pred: ^bb50
      llhd.drv %fsm_state_d, %c-32341_i16 after %3 : i16
      cf.br ^bb69
    ^bb52:  // pred: ^bb50
      llhd.drv %fsm_state_d, %c-10897_i16 after %3 : i16
      cf.br ^bb69
    ^bb53:  // pred: ^bb49
      llhd.drv %fsm_state_d, %c27948_i16 after %3 : i16
      llhd.drv %token_invalid_error_o, %true after %3 : i1
      cf.br ^bb69
    ^bb54:  // pred: ^bb48
      llhd.drv %fsm_state_d, %c27948_i16 after %3 : i16
      llhd.drv %nvm_rma_error_o, %true after %3 : i1
      cf.br ^bb69
    ^bb55:  // pred: ^bb45
      %248 = comb.icmp ceq %129, %c-32341_i16 : i16
      cf.cond_br %248, ^bb56, ^bb62
    ^bb56:  // pred: ^bb55
      llhd.drv %otp_prog_req_o, %true after %3 : i1
      %249 = llhd.prb %lc_clk_byp_req_o : i4
      %250 = llhd.prb %lc_clk_byp_ack : !hw.array<4xi4>
      %251 = hw.array_get %250[%c-2_i2] : !hw.array<4xi4>, i2
      %252 = comb.icmp ne %249, %251 : i4
      cf.cond_br %252, ^bb57, ^bb58
    ^bb57:  // pred: ^bb56
      llhd.drv %fsm_state_d, %c27948_i16 after %3 : i16
      llhd.drv %otp_prog_error_o, %true after %3 : i1
      cf.br ^bb69
    ^bb58:  // pred: ^bb56
      %253 = llhd.prb %trans_target_i_10 : !hw.array<6xi5>
      %254 = hw.bitcast %253 : (!hw.array<6xi5>) -> i30
      %255 = comb.icmp ne %254, %c-415641997_i30 : i30
      %256 = llhd.prb %lc_nvm_rma_req_o : i4
      %257 = comb.icmp ne %256, %c-6_i4 : i4
      %258 = llhd.prb %lc_nvm_rma_ack_buf : !hw.array<3xi4>
      %259 = hw.array_get %258[%c-2_i2] : !hw.array<3xi4>, i2
      %260 = comb.icmp ne %259, %c-6_i4 : i4
      %261 = comb.or %257, %260 : i1
      %262 = comb.and %255, %261 : i1
      %263 = comb.icmp eq %254, %c-415641997_i30 : i30
      %264 = comb.icmp ne %256, %c5_i4 : i4
      %265 = comb.icmp ne %259, %c5_i4 : i4
      %266 = comb.or %264, %265 : i1
      %267 = comb.and %263, %266 : i1
      %268 = comb.or %262, %267 : i1
      cf.cond_br %268, ^bb59, ^bb60
    ^bb59:  // pred: ^bb58
      llhd.drv %fsm_state_d, %c27948_i16 after %3 : i16
      llhd.drv %nvm_rma_error_o, %true after %3 : i1
      cf.br ^bb69
    ^bb60:  // pred: ^bb58
      %269 = llhd.prb %otp_prog_ack_i_16 : i1
      cf.cond_br %269, ^bb61, ^bb69
    ^bb61:  // pred: ^bb60
      llhd.drv %fsm_state_d, %c27948_i16 after %3 : i16
      %270 = llhd.prb %otp_prog_err_i_17 : i1
      llhd.drv %otp_prog_error_o, %270 after %3 : i1
      %271 = llhd.prb %otp_prog_err_i_17 : i1
      %272 = comb.xor %271, %true : i1
      llhd.drv %trans_success_o, %272 after %3 : i1
      cf.br ^bb69
    ^bb62:  // pred: ^bb55
      %273 = comb.icmp ceq %129, %c-22447_i16 : i16
      cf.cond_br %273, ^bb69, ^bb63
    ^bb63:  // pred: ^bb62
      %274 = comb.icmp ceq %129, %c27948_i16 : i16
      cf.cond_br %274, ^bb69, ^bb64
    ^bb64:  // pred: ^bb63
      %275 = comb.icmp ceq %129, %c-16997_i16 : i16
      cf.cond_br %275, ^bb65, ^bb66
    ^bb65:  // pred: ^bb64
      llhd.drv %token_hash_req_chk_o, %false after %3 : i1
      cf.br ^bb69
    ^bb66:  // pred: ^bb64
      %276 = comb.icmp ceq %129, %c12620_i16 : i16
      cf.cond_br %276, ^bb67, ^bb68
    ^bb67:  // pred: ^bb66
      llhd.drv %token_hash_req_chk_o, %false after %3 : i1
      llhd.drv %state_invalid_error_o, %true after %3 : i1
      cf.br ^bb69
    ^bb68:  // pred: ^bb66
      llhd.drv %fsm_state_d, %c12620_i16 after %3 : i16
      llhd.drv %state_invalid_error_o, %true after %3 : i1
      cf.br ^bb69
    ^bb69:  // 36 preds: ^bb2, ^bb3, ^bb9, ^bb10, ^bb11, ^bb15, ^bb16, ^bb17, ^bb18, ^bb21, ^bb22, ^bb26, ^bb28, ^bb29, ^bb32, ^bb33, ^bb35, ^bb37, ^bb38, ^bb41, ^bb42, ^bb43, ^bb47, ^bb51, ^bb52, ^bb53, ^bb54, ^bb57, ^bb59, ^bb60, ^bb61, ^bb62, ^bb63, ^bb65, ^bb67, ^bb68
      %277 = llhd.prb %esc_scrap_state0_i_3 : i1
      %278 = llhd.prb %esc_scrap_state1_i_4 : i1
      %279 = comb.or %277, %278 : i1
      cf.cond_br %279, ^bb70, ^bb71
    ^bb70:  // pred: ^bb69
      llhd.drv %fsm_state_d, %c-16997_i16 after %3 : i16
      cf.br ^bb73
    ^bb71:  // pred: ^bb69
      %280 = llhd.prb %state_invalid_error : i6
      %281 = comb.icmp ne %280, %c0_i6 : i6
      %282 = llhd.prb %token_if_fsm_err_i_13 : i1
      %283 = comb.or %281, %282 : i1
      %284 = llhd.prb %fsm_state_q : i16
      %285 = comb.icmp ne %284, %c-16997_i16 : i16
      %286 = comb.and %283, %285 : i1
      cf.cond_br %286, ^bb72, ^bb73
    ^bb72:  // pred: ^bb71
      llhd.drv %fsm_state_d, %c12620_i16 after %3 : i16
      llhd.drv %state_invalid_error_o, %true after %3 : i1
      cf.br ^bb73
    ^bb73:  // 3 preds: ^bb70, ^bb71, ^bb72
      llhd.wait (%25, %19, %23, %20, %24, %21, %37, %38, %39, %40, %41, %42, %43, %44, %45, %46, %47, %48, %49, %50, %30, %51, %31, %52, %32, %53, %22, %54, %55, %56, %57, %58, %59, %60, %28, %29, %27, %61, %62, %33, %63, %64, %65, %66, %67, %68, %69, %70, %71 : i16, i16, i320, i320, i384, i384, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i8, i8, i4, i4, i4, i4, i4, i4, i1, i1, i320, i384, i1, i1, i6, i1, i1, i1, i1, !hw.array<6xi5>, i1, i128, !hw.array<4xi4>, i1, i1, i1, i1, i128, i128, i1, i2, !hw.array<3xi4>), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %122 = llhd.prb %clk_i_0 : i1
      %123 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%10, %11 : i1, i1), ^bb2
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
      llhd.drv %lc_state_valid_q, %false after %2 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %133 = llhd.prb %lc_state_valid_d : i1
      llhd.drv %lc_state_valid_q, %133 after %2 : i1
      cf.br ^bb1
    }
    llhd.drv %volatile_raw_unlock_success_q, %c105_i8 after %3 : i8
    %72 = comb.extract %test_unlock_token_i from 64 : (i128) -> i64
    llhd.drv %test_unlock_token_lower, %72 after %3 : i64
    %73 = comb.extract %test_unlock_token_i from 0 : (i128) -> i64
    llhd.drv %test_unlock_token_upper, %73 after %3 : i64
    %74 = comb.extract %test_exit_token_i from 64 : (i128) -> i64
    llhd.drv %test_exit_token_lower, %74 after %3 : i64
    %75 = comb.extract %test_exit_token_i from 0 : (i128) -> i64
    llhd.drv %test_exit_token_upper, %75 after %3 : i64
    %76 = comb.extract %rma_token_i from 64 : (i128) -> i64
    llhd.drv %rma_token_lower, %76 after %3 : i64
    %77 = comb.extract %rma_token_i from 0 : (i128) -> i64
    llhd.drv %rma_token_upper, %77 after %3 : i64
    %78 = llhd.prb %hashed_tokens_lower : !hw.array<8xi64>
    %79 = llhd.prb %hashed_tokens_upper : !hw.array<8xi64>
    %80 = llhd.prb %test_tokens_valid : !hw.array<8xi4>
    %81 = llhd.prb %test_unlock_token_lower : i64
    %82 = llhd.prb %test_unlock_token_upper : i64
    %83 = llhd.prb %test_exit_token_lower : i64
    %84 = llhd.prb %test_exit_token_upper : i64
    %85 = llhd.prb %rma_token_valid : !hw.array<4xi4>
    %86 = llhd.prb %rma_token_lower : i64
    %87 = llhd.prb %rma_token_upper : i64
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb13
      llhd.drv %hashed_tokens_lower, %1 after %3 : !hw.array<8xi64>
      llhd.drv %hashed_tokens_upper, %1 after %3 : !hw.array<8xi64>
      %122 = llhd.sig.array_get %hashed_tokens_lower[%c0_i3] : <!hw.array<8xi64>>
      %123 = llhd.sig.array_get %hashed_tokens_upper[%c0_i3] : <!hw.array<8xi64>>
      llhd.drv %122, %c4058359384547221489_i64 after %3 : i64
      llhd.drv %123, %c-3043920565821176435_i64 after %3 : i64
      %124 = llhd.sig.array_get %hashed_tokens_lower[%c1_i3] : <!hw.array<8xi64>>
      %125 = llhd.sig.array_get %hashed_tokens_upper[%c1_i3] : <!hw.array<8xi64>>
      llhd.drv %124, %c-784579923872994594_i64 after %3 : i64
      llhd.drv %125, %c-6485808182601801875_i64 after %3 : i64
      %126 = llhd.prb %test_tokens_valid : !hw.array<8xi4>
      %127 = hw.array_get %126[%c0_i3] : !hw.array<8xi4>, i3
      %128 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%127) : (i4) -> i1
      cf.cond_br %128, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %129 = llhd.sig.array_get %hashed_tokens_lower[%c2_i3] : <!hw.array<8xi64>>
      %130 = llhd.prb %test_unlock_token_lower : i64
      llhd.drv %129, %130 after %3 : i64
      cf.br ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      %131 = llhd.prb %test_tokens_valid : !hw.array<8xi4>
      %132 = hw.array_get %131[%c1_i3] : !hw.array<8xi4>, i3
      %133 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%132) : (i4) -> i1
      cf.cond_br %133, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %134 = llhd.sig.array_get %hashed_tokens_upper[%c2_i3] : <!hw.array<8xi64>>
      %135 = llhd.prb %test_unlock_token_upper : i64
      llhd.drv %134, %135 after %3 : i64
      cf.br ^bb5
    ^bb5:  // 2 preds: ^bb3, ^bb4
      %136 = llhd.prb %test_tokens_valid : !hw.array<8xi4>
      %137 = hw.array_get %136[%c2_i3] : !hw.array<8xi4>, i3
      %138 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%137) : (i4) -> i1
      cf.cond_br %138, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %139 = llhd.sig.array_get %hashed_tokens_lower[%c3_i3] : <!hw.array<8xi64>>
      %140 = llhd.prb %test_exit_token_lower : i64
      llhd.drv %139, %140 after %3 : i64
      cf.br ^bb7
    ^bb7:  // 2 preds: ^bb5, ^bb6
      %141 = llhd.prb %test_tokens_valid : !hw.array<8xi4>
      %142 = hw.array_get %141[%c3_i3] : !hw.array<8xi4>, i3
      %143 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%142) : (i4) -> i1
      cf.cond_br %143, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %144 = llhd.sig.array_get %hashed_tokens_upper[%c3_i3] : <!hw.array<8xi64>>
      %145 = llhd.prb %test_exit_token_upper : i64
      llhd.drv %144, %145 after %3 : i64
      cf.br ^bb9
    ^bb9:  // 2 preds: ^bb7, ^bb8
      %146 = llhd.prb %rma_token_valid : !hw.array<4xi4>
      %147 = hw.array_get %146[%c0_i2] : !hw.array<4xi4>, i2
      %148 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%147) : (i4) -> i1
      cf.cond_br %148, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %149 = llhd.sig.array_get %hashed_tokens_lower[%c-4_i3] : <!hw.array<8xi64>>
      %150 = llhd.prb %rma_token_lower : i64
      llhd.drv %149, %150 after %3 : i64
      cf.br ^bb11
    ^bb11:  // 2 preds: ^bb9, ^bb10
      %151 = llhd.prb %rma_token_valid : !hw.array<4xi4>
      %152 = hw.array_get %151[%c1_i2] : !hw.array<4xi4>, i2
      %153 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%152) : (i4) -> i1
      cf.cond_br %153, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %154 = llhd.sig.array_get %hashed_tokens_upper[%c-4_i3] : <!hw.array<8xi64>>
      %155 = llhd.prb %rma_token_upper : i64
      llhd.drv %154, %155 after %3 : i64
      cf.br ^bb13
    ^bb13:  // 2 preds: ^bb11, ^bb12
      llhd.wait (%78, %79, %80, %81, %82, %83, %84, %85, %86, %87 : !hw.array<8xi64>, !hw.array<8xi64>, !hw.array<8xi4>, i64, i64, i64, i64, !hw.array<4xi4>, i64, i64), ^bb1
    }
    %88 = llhd.prb %hashed_tokens_valid0 : i8
    %89 = llhd.prb %hashed_tokens_valid1 : i8
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %hashed_tokens_valid0, %c0_i8 after %3 : i8
      %122 = llhd.sig.extract %hashed_tokens_valid0 from %c0_i3 : <i8> -> <i1>
      llhd.drv %122, %true after %3 : i1
      %123 = llhd.sig.extract %hashed_tokens_valid0 from %c1_i3 : <i8> -> <i1>
      llhd.drv %123, %true after %3 : i1
      %124 = llhd.sig.extract %hashed_tokens_valid0 from %c2_i3 : <i8> -> <i1>
      %125 = llhd.prb %test_tokens_valid : !hw.array<8xi4>
      %126 = hw.array_get %125[%c-4_i3] : !hw.array<8xi4>, i3
      %127 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%126) : (i4) -> i1
      llhd.drv %124, %127 after %3 : i1
      %128 = llhd.sig.extract %hashed_tokens_valid0 from %c3_i3 : <i8> -> <i1>
      %129 = llhd.prb %test_tokens_valid : !hw.array<8xi4>
      %130 = hw.array_get %129[%c-3_i3] : !hw.array<8xi4>, i3
      %131 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%130) : (i4) -> i1
      llhd.drv %128, %131 after %3 : i1
      %132 = llhd.sig.extract %hashed_tokens_valid0 from %c-4_i3 : <i8> -> <i1>
      %133 = llhd.prb %rma_token_valid : !hw.array<4xi4>
      %134 = hw.array_get %133[%c-2_i2] : !hw.array<4xi4>, i2
      %135 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%134) : (i4) -> i1
      llhd.drv %132, %135 after %3 : i1
      %136 = llhd.sig.extract %hashed_tokens_valid0 from %c-3_i3 : <i8> -> <i1>
      llhd.drv %136, %false after %3 : i1
      llhd.drv %hashed_tokens_valid1, %c0_i8 after %3 : i8
      %137 = llhd.sig.extract %hashed_tokens_valid1 from %c0_i3 : <i8> -> <i1>
      llhd.drv %137, %true after %3 : i1
      %138 = llhd.sig.extract %hashed_tokens_valid1 from %c1_i3 : <i8> -> <i1>
      llhd.drv %138, %true after %3 : i1
      %139 = llhd.sig.extract %hashed_tokens_valid1 from %c2_i3 : <i8> -> <i1>
      %140 = llhd.prb %test_tokens_valid : !hw.array<8xi4>
      %141 = hw.array_get %140[%c-2_i3] : !hw.array<8xi4>, i3
      %142 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%141) : (i4) -> i1
      llhd.drv %139, %142 after %3 : i1
      %143 = llhd.sig.extract %hashed_tokens_valid1 from %c3_i3 : <i8> -> <i1>
      %144 = llhd.prb %test_tokens_valid : !hw.array<8xi4>
      %145 = hw.array_get %144[%c-1_i3] : !hw.array<8xi4>, i3
      %146 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%145) : (i4) -> i1
      llhd.drv %143, %146 after %3 : i1
      %147 = llhd.sig.extract %hashed_tokens_valid1 from %c-4_i3 : <i8> -> <i1>
      %148 = llhd.prb %rma_token_valid : !hw.array<4xi4>
      %149 = hw.array_get %148[%c-1_i2] : !hw.array<4xi4>, i2
      %150 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%149) : (i4) -> i1
      llhd.drv %147, %150 after %3 : i1
      %151 = llhd.sig.extract %hashed_tokens_valid1 from %c-3_i3 : <i8> -> <i1>
      llhd.drv %151, %false after %3 : i1
      llhd.wait (%88, %80, %85, %89 : i8, !hw.array<8xi4>, !hw.array<4xi4>, i8), ^bb1
    }
    %90 = hw.array_get %26[%c0_i3] : !hw.array<6xi5>, i3
    %91 = comb.concat %c0_i27, %90 : i27, i5
    %92 = comb.icmp slt %91, %c21_i32 : i32
    %93 = hw.array_get %27[%c0_i3] : !hw.array<6xi5>, i3
    %94 = comb.concat %c0_i27, %93 : i27, i5
    %95 = comb.icmp slt %94, %c21_i32 : i32
    %96 = comb.and %92, %95 : i1
    %97 = hw.array_get %0[%90] : !hw.array<21xarray<21xi3>>, i5
    %98 = hw.array_get %97[%93] : !hw.array<21xi3>, i5
    %99 = comb.mux %96, %98, %c-3_i3 {sv.namehint = "token_idx0"} : i3
    %100 = hw.array_get %26[%c1_i3] : !hw.array<6xi5>, i3
    %101 = comb.concat %c0_i27, %100 : i27, i5
    %102 = comb.icmp slt %101, %c21_i32 : i32
    %103 = hw.array_get %27[%c1_i3] : !hw.array<6xi5>, i3
    %104 = comb.concat %c0_i27, %103 : i27, i5
    %105 = comb.icmp slt %104, %c21_i32 : i32
    %106 = comb.and %102, %105 : i1
    %107 = hw.array_get %0[%100] : !hw.array<21xarray<21xi3>>, i5
    %108 = hw.array_get %107[%103] : !hw.array<21xi3>, i5
    %109 = comb.mux %106, %108, %c-3_i3 {sv.namehint = "token_idx1"} : i3
    %110 = hw.array_get %78[%99] : !hw.array<8xi64>, i3
    %111 = hw.array_get %79[%109] : !hw.array<8xi64>, i3
    %112 = comb.concat %110, %111 : i64, i64
    llhd.drv %hashed_token_mux, %112 after %3 : i128
    %113 = comb.concat %c0_i5, %99 : i5, i3
    %114 = comb.shru %88, %113 : i8
    %115 = comb.extract %114 from 0 : (i8) -> i1
    %116 = comb.concat %c0_i5, %109 : i5, i3
    %117 = comb.shru %89, %116 : i8
    %118 = comb.extract %117 from 0 : (i8) -> i1
    %119 = comb.concat %115, %118 : i1, i1
    llhd.drv %hashed_token_valid_mux, %119 after %3 : i2
    %120 = comb.icmp ne %99, %109 : i3
    %121 = comb.or %u_lc_ctrl_state_transition.trans_invalid_error_o, %120 : i1
    llhd.drv %trans_invalid_error_o, %121 after %3 : i1
    llhd.drv %clk_i_0, %clk_i after %3 : i1
    llhd.drv %rst_ni_1, %rst_ni after %3 : i1
    llhd.drv %init_req_i_2, %init_req_i after %3 : i1
    llhd.drv %esc_scrap_state0_i_3, %esc_scrap_state0_i after %3 : i1
    llhd.drv %esc_scrap_state1_i_4, %esc_scrap_state1_i after %3 : i1
    llhd.drv %lc_state_i_5, %lc_state_i after %3 : i320
    llhd.drv %lc_cnt_i_6, %lc_cnt_i after %3 : i384
    llhd.drv %use_ext_clock_i_7, %use_ext_clock_i after %3 : i1
    llhd.drv %volatile_raw_unlock_i_8, %volatile_raw_unlock_i after %3 : i1
    llhd.drv %trans_cmd_i_9, %trans_cmd_i after %3 : i1
    llhd.drv %trans_target_i_10, %trans_target_i after %3 : !hw.array<6xi5>
    llhd.drv %token_hash_ack_i_11, %token_hash_ack_i after %3 : i1
    llhd.drv %token_hash_err_i_12, %token_hash_err_i after %3 : i1
    llhd.drv %token_if_fsm_err_i_13, %token_if_fsm_err_i after %3 : i1
    llhd.drv %hashed_token_i_14, %hashed_token_i after %3 : i128
    llhd.drv %unhashed_token_i_15, %unhashed_token_i after %3 : i128
    llhd.drv %otp_prog_ack_i_16, %otp_prog_ack_i after %3 : i1
    llhd.drv %otp_prog_err_i_17, %otp_prog_err_i after %3 : i1
    hw.output %45, %46, %35, %false, %26, %u_lc_ctrl_state_decode.dec_lc_cnt_o, %u_lc_ctrl_state_decode.dec_lc_id_state_o, %37, %38, %39, %u_lc_ctrl_state_transition.next_lc_state_o, %u_lc_ctrl_state_transition.next_lc_cnt_o, %43, %63, %61, %40, %42, %41, %44, %u_lc_ctrl_signal_decode.lc_raw_test_rma_o, %u_lc_ctrl_signal_decode.lc_init_done_o, %u_lc_ctrl_signal_decode.lc_dft_en_o, %u_lc_ctrl_signal_decode.lc_nvm_debug_en_o, %u_lc_ctrl_signal_decode.lc_hw_debug_clr_o, %u_lc_ctrl_signal_decode.lc_hw_debug_en_o, %u_lc_ctrl_signal_decode.lc_cpu_en_o, %u_lc_ctrl_signal_decode.lc_creator_seed_sw_rw_en_o, %u_lc_ctrl_signal_decode.lc_owner_seed_sw_rw_en_o, %u_lc_ctrl_signal_decode.lc_iso_part_sw_rd_en_o, %u_lc_ctrl_signal_decode.lc_iso_part_sw_wr_en_o, %u_lc_ctrl_signal_decode.lc_seed_hw_rd_en_o, %u_lc_ctrl_signal_decode.lc_rma_state_o, %u_lc_ctrl_signal_decode.lc_keymgr_en_o, %u_lc_ctrl_signal_decode.lc_escalate_en_o, %52, %50, %51, %u_lc_ctrl_signal_decode.lc_keymgr_div_o : i1, i1, i1, i1, !hw.array<6xi5>, i5, i2, i1, i1, i1, i320, i384, i1, i1, i1, i1, i1, i1, i1, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i128
  }
  hw.module private @lc_ctrl_kmac_if(in %clk_i : i1, in %rst_ni : i1, in %clk_kmac_i : i1, in %rst_kmac_ni : i1, in %kmac_data_i : !hw.struct<ready: i1, done: i1, digest_share0: i384, digest_share1: i384, error: i1>, out kmac_data_o : !hw.struct<valid: i1, data: i64, strb: i8, last: i1>, in %transition_token_i : i128, in %token_hash_req_i : i1, in %token_hash_req_chk_i : i1, out token_hash_ack_o : i1, out token_hash_err_o : i1, out token_if_fsm_err_o : i1, out hashed_token_o : i128) {
    %c-1_i128 = hw.constant -1 : i128
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i8 = hw.constant 0 : i8
    %c0_i128 = hw.constant 0 : i128
    %2 = hw.aggregate_constant [false, 0, 0 : i8, false] : !hw.struct<valid: i1, data: i64, strb: i8, last: i1>
    %3 = hw.aggregate_constant [false, false, 0 : i384, 0 : i384, false] : !hw.struct<ready: i1, done: i1, digest_share0: i384, digest_share1: i384, error: i1>
    %c40_i8 = hw.constant 40 : i8
    %c-25_i8 = hw.constant -25 : i8
    %c-108_i8 = hw.constant -108 : i8
    %c-1_i8 = hw.constant -1 : i8
    %true = hw.constant true
    %c91_i8 = hw.constant 91 : i8
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %4 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %5 = llhd.prb %rst_ni_1 : i1
    %clk_kmac_i_2 = llhd.sig name "clk_kmac_i" %false : i1
    %6 = llhd.prb %clk_kmac_i_2 : i1
    %rst_kmac_ni_3 = llhd.sig name "rst_kmac_ni" %false : i1
    %7 = llhd.prb %rst_kmac_ni_3 : i1
    %kmac_data_i_4 = llhd.sig name "kmac_data_i" %3 : !hw.struct<ready: i1, done: i1, digest_share0: i384, digest_share1: i384, error: i1>
    %kmac_data_o = llhd.sig %2 : !hw.struct<valid: i1, data: i64, strb: i8, last: i1>
    %token_hash_req_i_5 = llhd.sig name "token_hash_req_i" %false : i1
    %kmac_transition_token = llhd.sig %c0_i128 : i128
    %kmac_req = llhd.sig %false : i1
    %kmac_ack = llhd.sig %false : i1
    %token_hash_ack_d = llhd.sig %false : i1
    %token_hash_ack_q = llhd.sig %false : i1
    %token_hash_err_q = llhd.sig %false : i1
    %token_hash_err_d = llhd.sig %false : i1
    %hashed_token_q = llhd.sig %c0_i128 : i128
    %hashed_token_d = llhd.sig %c0_i128 : i128
    %kmac_fsm_err_d = llhd.sig %false : i1
    %kmac_fsm_err_q = llhd.sig %false : i1
    %state_d = llhd.sig %c0_i8 : i8
    %state_q = llhd.sig %c0_i8 : i8
    %8 = llhd.prb %kmac_ack : i1
    %9 = llhd.prb %kmac_data_i_4 : !hw.struct<ready: i1, done: i1, digest_share0: i384, digest_share1: i384, error: i1>
    %error = hw.struct_extract %9["error"] : !hw.struct<ready: i1, done: i1, digest_share0: i384, digest_share1: i384, error: i1>
    %digest_share0 = hw.struct_extract %9["digest_share0"] : !hw.struct<ready: i1, done: i1, digest_share0: i384, digest_share1: i384, error: i1>
    %10 = comb.extract %digest_share0 from 0 : (i384) -> i128
    %digest_share1 = hw.struct_extract %9["digest_share1"] : !hw.struct<ready: i1, done: i1, digest_share0: i384, digest_share1: i384, error: i1>
    %11 = comb.extract %digest_share1 from 0 : (i384) -> i128
    %12 = comb.xor %10, %11 : i128
    %13 = comb.concat %error, %12 : i1, i128
    %u_prim_sync_reqack_data_in.src_ack_o, %u_prim_sync_reqack_data_in.dst_req_o, %u_prim_sync_reqack_data_in.data_o = hw.instance "u_prim_sync_reqack_data_in" @prim_sync_reqack_data(clk_src_i: %4: i1, rst_src_ni: %5: i1, clk_dst_i: %6: i1, rst_dst_ni: %7: i1, req_chk_i: %token_hash_req_chk_i: i1, src_req_i: %23: i1, dst_ack_i: %8: i1, data_i: %13: i129) -> (src_ack_o: i1, dst_req_o: i1, data_o: i129)
    llhd.drv %token_hash_ack_d, %u_prim_sync_reqack_data_in.src_ack_o after %1 : i1
    llhd.drv %kmac_req, %u_prim_sync_reqack_data_in.dst_req_o after %1 : i1
    %14 = comb.extract %u_prim_sync_reqack_data_in.data_o from 128 : (i129) -> i1
    llhd.drv %token_hash_err_d, %14 after %1 : i1
    %15 = comb.extract %u_prim_sync_reqack_data_in.data_o from 0 : (i129) -> i128
    llhd.drv %hashed_token_d, %15 after %1 : i128
    %16 = llhd.prb %kmac_fsm_err_q : i1
    %u_prim_flop_2sync.q_o = hw.instance "u_prim_flop_2sync" @prim_flop_2sync(clk_i: %4: i1, rst_ni: %5: i1, d_i: %16: i1) -> (q_o: i1)
    %17 = llhd.prb %state_d : i8
    %u_state_regs.state_o = hw.instance "u_state_regs" @prim_sparse_fsm_flop(clk_i: %6: i1, rst_ni: %7: i1, state_i: %17: i8) -> (state_o: i8)
    llhd.drv %state_q, %u_state_regs.state_o after %1 : i8
    llhd.drv %kmac_transition_token, %transition_token_i after %1 : i128
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %29 = llhd.prb %clk_i_0 : i1
      %30 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
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
      llhd.drv %token_hash_ack_q, %false after %0 : i1
      llhd.drv %token_hash_err_q, %false after %0 : i1
      llhd.drv %hashed_token_q, %c-1_i128 after %0 : i128
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %40 = llhd.prb %token_hash_ack_d : i1
      llhd.drv %token_hash_ack_q, %40 after %0 : i1
      %41 = llhd.prb %token_hash_req_i_5 : i1
      %42 = llhd.prb %token_hash_ack_d : i1
      %43 = comb.and %41, %42 : i1
      cf.cond_br %43, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %44 = llhd.prb %token_hash_err_d : i1
      llhd.drv %token_hash_err_q, %44 after %0 : i1
      %45 = llhd.prb %hashed_token_d : i128
      llhd.drv %hashed_token_q, %45 after %0 : i128
      cf.br ^bb1
    }
    %18 = llhd.prb %token_hash_ack_q : i1
    %19 = llhd.prb %token_hash_err_q : i1
    %20 = llhd.prb %hashed_token_q : i128
    %21 = llhd.prb %token_hash_req_i_5 : i1
    %22 = comb.xor %18, %true : i1
    %23 = comb.and %21, %22 {sv.namehint = "token_hash_req"} : i1
    %24 = llhd.prb %state_q : i8
    %25 = llhd.prb %kmac_data_o : !hw.struct<valid: i1, data: i64, strb: i8, last: i1>
    %26 = llhd.prb %kmac_fsm_err_d : i1
    %27 = llhd.prb %kmac_req : i1
    %28 = llhd.prb %kmac_transition_token : i128
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb13
      %29 = llhd.prb %state_q : i8
      llhd.drv %state_d, %29 after %1 : i8
      llhd.drv %kmac_data_o, %2 after %1 : !hw.struct<valid: i1, data: i64, strb: i8, last: i1>
      llhd.drv %kmac_ack, %false after %1 : i1
      llhd.drv %kmac_fsm_err_d, %false after %1 : i1
      %30 = llhd.prb %state_q : i8
      %31 = comb.icmp ceq %30, %c91_i8 : i8
      cf.cond_br %31, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      %32 = llhd.prb %kmac_req : i1
      cf.cond_br %32, ^bb3, ^bb13
    ^bb3:  // pred: ^bb2
      %33 = llhd.sig.struct_extract %kmac_data_o["valid"] : <!hw.struct<valid: i1, data: i64, strb: i8, last: i1>>
      llhd.drv %33, %true after %1 : i1
      %34 = llhd.sig.struct_extract %kmac_data_o["strb"] : <!hw.struct<valid: i1, data: i64, strb: i8, last: i1>>
      llhd.drv %34, %c-1_i8 after %1 : i8
      %35 = llhd.sig.struct_extract %kmac_data_o["data"] : <!hw.struct<valid: i1, data: i64, strb: i8, last: i1>>
      %36 = llhd.prb %kmac_transition_token : i128
      %37 = comb.extract %36 from 0 : (i128) -> i64
      llhd.drv %35, %37 after %1 : i64
      %38 = llhd.prb %kmac_data_i_4 : !hw.struct<ready: i1, done: i1, digest_share0: i384, digest_share1: i384, error: i1>
      %ready = hw.struct_extract %38["ready"] : !hw.struct<ready: i1, done: i1, digest_share0: i384, digest_share1: i384, error: i1>
      cf.cond_br %ready, ^bb4, ^bb13
    ^bb4:  // pred: ^bb3
      llhd.drv %state_d, %c-108_i8 after %1 : i8
      cf.br ^bb13
    ^bb5:  // pred: ^bb1
      %39 = comb.icmp ceq %30, %c-108_i8 : i8
      cf.cond_br %39, ^bb6, ^bb8
    ^bb6:  // pred: ^bb5
      %40 = llhd.sig.struct_extract %kmac_data_o["valid"] : <!hw.struct<valid: i1, data: i64, strb: i8, last: i1>>
      llhd.drv %40, %true after %1 : i1
      %41 = llhd.sig.struct_extract %kmac_data_o["strb"] : <!hw.struct<valid: i1, data: i64, strb: i8, last: i1>>
      llhd.drv %41, %c-1_i8 after %1 : i8
      %42 = llhd.sig.struct_extract %kmac_data_o["last"] : <!hw.struct<valid: i1, data: i64, strb: i8, last: i1>>
      llhd.drv %42, %true after %1 : i1
      %43 = llhd.sig.struct_extract %kmac_data_o["data"] : <!hw.struct<valid: i1, data: i64, strb: i8, last: i1>>
      %44 = llhd.prb %kmac_transition_token : i128
      %45 = comb.extract %44 from 64 : (i128) -> i64
      llhd.drv %43, %45 after %1 : i64
      %46 = llhd.prb %kmac_data_i_4 : !hw.struct<ready: i1, done: i1, digest_share0: i384, digest_share1: i384, error: i1>
      %ready_6 = hw.struct_extract %46["ready"] : !hw.struct<ready: i1, done: i1, digest_share0: i384, digest_share1: i384, error: i1>
      cf.cond_br %ready_6, ^bb7, ^bb13
    ^bb7:  // pred: ^bb6
      llhd.drv %state_d, %c-25_i8 after %1 : i8
      cf.br ^bb13
    ^bb8:  // pred: ^bb5
      %47 = comb.icmp ceq %30, %c-25_i8 : i8
      cf.cond_br %47, ^bb9, ^bb11
    ^bb9:  // pred: ^bb8
      %48 = llhd.prb %kmac_data_i_4 : !hw.struct<ready: i1, done: i1, digest_share0: i384, digest_share1: i384, error: i1>
      %done = hw.struct_extract %48["done"] : !hw.struct<ready: i1, done: i1, digest_share0: i384, digest_share1: i384, error: i1>
      cf.cond_br %done, ^bb10, ^bb13
    ^bb10:  // pred: ^bb9
      llhd.drv %kmac_ack, %true after %1 : i1
      llhd.drv %state_d, %c40_i8 after %1 : i8
      cf.br ^bb13
    ^bb11:  // pred: ^bb8
      %49 = comb.icmp ceq %30, %c40_i8 : i8
      cf.cond_br %49, ^bb13, ^bb12
    ^bb12:  // pred: ^bb11
      llhd.drv %kmac_fsm_err_d, %true after %1 : i1
      cf.br ^bb13
    ^bb13:  // 9 preds: ^bb2, ^bb3, ^bb4, ^bb6, ^bb7, ^bb9, ^bb10, ^bb11, ^bb12
      llhd.wait (%24, %17, %25, %8, %26, %27, %28, %9 : i8, i8, !hw.struct<valid: i1, data: i64, strb: i8, last: i1>, i1, i1, i1, i128, !hw.struct<ready: i1, done: i1, digest_share0: i384, digest_share1: i384, error: i1>), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %29 = llhd.prb %clk_kmac_i_2 : i1
      %30 = llhd.prb %rst_kmac_ni_3 : i1
      llhd.wait (%6, %7 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %31 = llhd.prb %clk_kmac_i_2 : i1
      %32 = comb.xor bin %29, %true : i1
      %33 = comb.and bin %32, %31 : i1
      %34 = llhd.prb %rst_kmac_ni_3 : i1
      %35 = comb.xor bin %34, %true : i1
      %36 = comb.and bin %30, %35 : i1
      %37 = comb.or bin %33, %36 : i1
      cf.cond_br %37, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %38 = llhd.prb %rst_kmac_ni_3 : i1
      %39 = comb.xor %38, %true : i1
      cf.cond_br %39, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %kmac_fsm_err_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %40 = llhd.prb %kmac_fsm_err_d : i1
      llhd.drv %kmac_fsm_err_q, %40 after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %clk_kmac_i_2, %clk_kmac_i after %1 : i1
    llhd.drv %rst_kmac_ni_3, %rst_kmac_ni after %1 : i1
    llhd.drv %kmac_data_i_4, %kmac_data_i after %1 : !hw.struct<ready: i1, done: i1, digest_share0: i384, digest_share1: i384, error: i1>
    llhd.drv %token_hash_req_i_5, %token_hash_req_i after %1 : i1
    hw.output %25, %18, %19, %u_prim_flop_2sync.q_o, %20 : !hw.struct<valid: i1, data: i64, strb: i8, last: i1>, i1, i1, i1, i128
  }
  hw.module private @lc_ctrl_regs_reg_top(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>, in %hw2reg : !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>, out intg_err_o : i1) {
    %c-1_i4 = hw.constant -1 : i4
    %c-16_i5 = hw.constant -16 : i5
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
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i3 = hw.constant -1 : i3
    %c-2_i3 = hw.constant -2 : i3
    %c-3_i3 = hw.constant -3 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c3_i3 = hw.constant 3 : i3
    %c2_i3 = hw.constant 2 : i3
    %c1_i3 = hw.constant 1 : i3
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %c0_i3 = hw.constant 0 : i3
    %c0_i35 = hw.constant 0 : i35
    %c0_i4 = hw.constant 0 : i4
    %2 = hw.aggregate_constant [[[false, false], [false, false], [false, false]], [0 : i8, false], [false, false], [[false, false], [false, false]], [[0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false]], [0 : i30, false], [0 : i32, false]] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
    %c-1_i32 = hw.constant -1 : i32
    %c-120_i8 = hw.constant -120 : i8
    %c-124_i8 = hw.constant -124 : i8
    %c-128_i8 = hw.constant -128 : i8
    %c124_i8 = hw.constant 124 : i8
    %c120_i8 = hw.constant 120 : i8
    %c116_i8 = hw.constant 116 : i8
    %c112_i8 = hw.constant 112 : i8
    %c108_i8 = hw.constant 108 : i8
    %c104_i8 = hw.constant 104 : i8
    %c100_i8 = hw.constant 100 : i8
    %c96_i8 = hw.constant 96 : i8
    %c92_i8 = hw.constant 92 : i8
    %c88_i8 = hw.constant 88 : i8
    %c84_i8 = hw.constant 84 : i8
    %c80_i8 = hw.constant 80 : i8
    %c76_i8 = hw.constant 76 : i8
    %c72_i8 = hw.constant 72 : i8
    %c68_i8 = hw.constant 68 : i8
    %c64_i8 = hw.constant 64 : i8
    %c60_i8 = hw.constant 60 : i8
    %c56_i8 = hw.constant 56 : i8
    %c52_i8 = hw.constant 52 : i8
    %c48_i8 = hw.constant 48 : i8
    %c44_i8 = hw.constant 44 : i8
    %c40_i8 = hw.constant 40 : i8
    %c36_i8 = hw.constant 36 : i8
    %c32_i8 = hw.constant 32 : i8
    %c28_i8 = hw.constant 28 : i8
    %c24_i8 = hw.constant 24 : i8
    %c20_i8 = hw.constant 20 : i8
    %c16_i8 = hw.constant 16 : i8
    %c12_i8 = hw.constant 12 : i8
    %c8_i8 = hw.constant 8 : i8
    %c4_i8 = hw.constant 4 : i8
    %true = hw.constant true
    %c0_i24 = hw.constant 0 : i24
    %c0_i8 = hw.constant 0 : i8
    %c0_i16 = hw.constant 0 : i16
    %c0_i5 = hw.constant 0 : i5
    %c0_i30 = hw.constant 0 : i30
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false {sv.namehint = "shadow_busy"}
    %c-7_i4 = hw.constant -7 : i4
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %reg2hw = llhd.sig %2 : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
    %reg_we = llhd.sig %false : i1
    %reg_addr = llhd.sig %c0_i8 : i8
    %reg_be = llhd.sig %c0_i4 : i4
    %wr_err = llhd.sig %false : i1
    %reg_rdata_next = llhd.sig %c0_i32 : i32
    %intg_err = llhd.sig %false : i1
    %reg_we_err = llhd.sig %false : i1
    %reg_we_check = llhd.sig %c0_i35 : i35
    %err_q = llhd.sig %false : i1
    %alert_test_we = llhd.sig %false : i1
    %status_initialized_qs = llhd.sig %false : i1
    %status_ready_qs = llhd.sig %false : i1
    %status_ext_clock_switched_qs = llhd.sig %false : i1
    %status_transition_successful_qs = llhd.sig %false : i1
    %status_transition_count_error_qs = llhd.sig %false : i1
    %status_transition_error_qs = llhd.sig %false : i1
    %status_token_error_qs = llhd.sig %false : i1
    %status_nvm_rma_error_qs = llhd.sig %false : i1
    %status_otp_error_qs = llhd.sig %false : i1
    %status_state_error_qs = llhd.sig %false : i1
    %status_bus_integ_error_qs = llhd.sig %false : i1
    %status_otp_partition_error_qs = llhd.sig %false : i1
    %claim_transition_if_regwen_we = llhd.sig %false : i1
    %claim_transition_if_regwen_qs = llhd.sig %false : i1
    %claim_transition_if_qs = llhd.sig %c0_i8 : i8
    %transition_regwen_qs = llhd.sig %false : i1
    %transition_ctrl_ext_clock_en_qs = llhd.sig %false : i1
    %transition_ctrl_volatile_raw_unlock_qs = llhd.sig %false : i1
    %transition_token_0_qs = llhd.sig %c0_i32 : i32
    %transition_token_1_qs = llhd.sig %c0_i32 : i32
    %transition_token_2_qs = llhd.sig %c0_i32 : i32
    %transition_token_3_qs = llhd.sig %c0_i32 : i32
    %transition_target_qs = llhd.sig %c0_i30 : i30
    %otp_vendor_test_ctrl_qs = llhd.sig %c0_i32 : i32
    %otp_vendor_test_status_qs = llhd.sig %c0_i32 : i32
    %lc_state_qs = llhd.sig %c0_i30 : i30
    %lc_transition_cnt_qs = llhd.sig %c0_i5 : i5
    %lc_id_state_qs = llhd.sig %c0_i32 : i32
    %hw_revision0_product_id_qs = llhd.sig %c0_i16 : i16
    %hw_revision0_silicon_creator_id_qs = llhd.sig %c0_i16 : i16
    %hw_revision1_revision_id_qs = llhd.sig %c0_i8 : i8
    %hw_revision1_reserved_qs = llhd.sig %c0_i24 : i24
    %device_id_0_qs = llhd.sig %c0_i32 : i32
    %device_id_1_qs = llhd.sig %c0_i32 : i32
    %device_id_2_qs = llhd.sig %c0_i32 : i32
    %device_id_3_qs = llhd.sig %c0_i32 : i32
    %device_id_4_qs = llhd.sig %c0_i32 : i32
    %device_id_5_qs = llhd.sig %c0_i32 : i32
    %device_id_6_qs = llhd.sig %c0_i32 : i32
    %device_id_7_qs = llhd.sig %c0_i32 : i32
    %manuf_state_0_qs = llhd.sig %c0_i32 : i32
    %manuf_state_1_qs = llhd.sig %c0_i32 : i32
    %manuf_state_2_qs = llhd.sig %c0_i32 : i32
    %manuf_state_3_qs = llhd.sig %c0_i32 : i32
    %manuf_state_4_qs = llhd.sig %c0_i32 : i32
    %manuf_state_5_qs = llhd.sig %c0_i32 : i32
    %manuf_state_6_qs = llhd.sig %c0_i32 : i32
    %manuf_state_7_qs = llhd.sig %c0_i32 : i32
    %alert_test_flds_we = llhd.sig %c0_i3 : i3
    %claim_transition_if_flds_we = llhd.sig %false : i1
    %claim_transition_if_gated_we = llhd.sig %false : i1
    %transition_cmd_flds_we = llhd.sig %false : i1
    %transition_cmd_gated_we = llhd.sig %false : i1
    %transition_ctrl_flds_we = llhd.sig %c0_i2 : i2
    %transition_ctrl_gated_we = llhd.sig %false : i1
    %transition_token_0_flds_we = llhd.sig %false : i1
    %transition_token_0_gated_we = llhd.sig %false : i1
    %transition_token_1_flds_we = llhd.sig %false : i1
    %transition_token_1_gated_we = llhd.sig %false : i1
    %transition_token_2_flds_we = llhd.sig %false : i1
    %transition_token_2_gated_we = llhd.sig %false : i1
    %transition_token_3_flds_we = llhd.sig %false : i1
    %transition_token_3_gated_we = llhd.sig %false : i1
    %transition_target_flds_we = llhd.sig %false : i1
    %transition_target_gated_we = llhd.sig %false : i1
    %otp_vendor_test_ctrl_flds_we = llhd.sig %false : i1
    %otp_vendor_test_ctrl_gated_we = llhd.sig %false : i1
    %addr_hit = llhd.sig %c0_i35 : i35
    %u_chk.err_o = hw.instance "u_chk" @tlul_cmd_intg_chk(tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> (err_o: i1)
    llhd.drv %intg_err, %u_chk.err_o after %1 : i1
    %5 = llhd.prb %reg_we_check : i35
    %6 = llhd.prb %reg_we : i1
    %7 = comb.xor %121, %true : i1
    %8 = comb.and %6, %7 : i1
    %u_prim_reg_we_check.err_o = hw.instance "u_prim_reg_we_check" @prim_reg_we_check(clk_i: %3: i1, rst_ni: %4: i1, oh_i: %5: i35, en_i: %8: i1) -> (err_o: i1)
    llhd.drv %reg_we_err, %u_prim_reg_we_check.err_o after %1 : i1
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen(tl_i: %u_reg_if.tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
    %u_reg_if.tl_o, %u_reg_if.intg_error_o, %u_reg_if.re_o, %u_reg_if.we_o, %u_reg_if.addr_o, %u_reg_if.wdata_o, %u_reg_if.be_o = hw.instance "u_reg_if" @tlul_adapter_reg(clk_i: %3: i1, rst_ni: %4: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, en_ifetch_i: %c-7_i4: i4, busy_i: %false: i1, rdata_i: %78: i32, error_i: %80: i1) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, intg_error_o: i1, re_o: i1, we_o: i1, addr_o: i8, wdata_o: i32, be_o: i4) {sv.namehint = "reg_re"}
    llhd.drv %reg_we, %u_reg_if.we_o after %1 : i1
    llhd.drv %reg_addr, %u_reg_if.addr_o after %1 : i8
    llhd.drv %reg_be, %u_reg_if.be_o after %1 : i4
    %9 = llhd.prb %alert_test_we : i1
    %10 = llhd.sig.extract %alert_test_flds_we from %c0_i2 : <i3> -> <i1>
    %11 = llhd.sig.struct_extract %reg2hw["alert_test"] : <!hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>>
    %12 = llhd.sig.struct_extract %11["fatal_prog_error"] : <!hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>>
    %13 = llhd.sig.struct_extract %12["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_alert_test_fatal_prog_error.qe, %u_alert_test_fatal_prog_error.qre, %u_alert_test_fatal_prog_error.q, %u_alert_test_fatal_prog_error.ds, %u_alert_test_fatal_prog_error.qs = hw.instance "u_alert_test_fatal_prog_error" @prim_subreg_ext(re: %false: i1, we: %9: i1, wd: %126: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %10, %u_alert_test_fatal_prog_error.qe after %1 : i1
    llhd.drv %13, %u_alert_test_fatal_prog_error.q after %1 : i1
    %14 = llhd.sig.extract %alert_test_flds_we from %c1_i2 : <i3> -> <i1>
    %15 = llhd.sig.struct_extract %11["fatal_state_error"] : <!hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>>
    %16 = llhd.sig.struct_extract %15["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_alert_test_fatal_state_error.qe, %u_alert_test_fatal_state_error.qre, %u_alert_test_fatal_state_error.q, %u_alert_test_fatal_state_error.ds, %u_alert_test_fatal_state_error.qs = hw.instance "u_alert_test_fatal_state_error" @prim_subreg_ext(re: %false: i1, we: %9: i1, wd: %127: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %14, %u_alert_test_fatal_state_error.qe after %1 : i1
    llhd.drv %16, %u_alert_test_fatal_state_error.q after %1 : i1
    %17 = llhd.sig.extract %alert_test_flds_we from %c-2_i2 : <i3> -> <i1>
    %18 = llhd.sig.struct_extract %11["fatal_bus_integ_error"] : <!hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>>
    %19 = llhd.sig.struct_extract %18["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_alert_test_fatal_bus_integ_error.qe, %u_alert_test_fatal_bus_integ_error.qre, %u_alert_test_fatal_bus_integ_error.q, %u_alert_test_fatal_bus_integ_error.ds, %u_alert_test_fatal_bus_integ_error.qs = hw.instance "u_alert_test_fatal_bus_integ_error" @prim_subreg_ext(re: %false: i1, we: %9: i1, wd: %128: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %17, %u_alert_test_fatal_bus_integ_error.qe after %1 : i1
    llhd.drv %19, %u_alert_test_fatal_bus_integ_error.q after %1 : i1
    %status = hw.struct_extract %hw2reg["status"] : !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>
    %initialized = hw.struct_extract %status["initialized"] : !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>
    %d = hw.struct_extract %initialized["d"] : !hw.struct<d: i1>
    %u_status_initialized.qe, %u_status_initialized.qre, %u_status_initialized.q, %u_status_initialized.ds, %u_status_initialized.qs = hw.instance "u_status_initialized" @prim_subreg_ext(re: %130: i1, we: %false: i1, wd: %false: i1, d: %d: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_initialized_qs, %u_status_initialized.qs after %1 : i1
    %ready = hw.struct_extract %status["ready"] : !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>
    %d_2 = hw.struct_extract %ready["d"] : !hw.struct<d: i1>
    %u_status_ready.qe, %u_status_ready.qre, %u_status_ready.q, %u_status_ready.ds, %u_status_ready.qs = hw.instance "u_status_ready" @prim_subreg_ext(re: %130: i1, we: %false: i1, wd: %false: i1, d: %d_2: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_ready_qs, %u_status_ready.qs after %1 : i1
    %ext_clock_switched = hw.struct_extract %status["ext_clock_switched"] : !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>
    %d_3 = hw.struct_extract %ext_clock_switched["d"] : !hw.struct<d: i1>
    %u_status_ext_clock_switched.qe, %u_status_ext_clock_switched.qre, %u_status_ext_clock_switched.q, %u_status_ext_clock_switched.ds, %u_status_ext_clock_switched.qs = hw.instance "u_status_ext_clock_switched" @prim_subreg_ext(re: %130: i1, we: %false: i1, wd: %false: i1, d: %d_3: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_ext_clock_switched_qs, %u_status_ext_clock_switched.qs after %1 : i1
    %transition_successful = hw.struct_extract %status["transition_successful"] : !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>
    %d_4 = hw.struct_extract %transition_successful["d"] : !hw.struct<d: i1>
    %u_status_transition_successful.qe, %u_status_transition_successful.qre, %u_status_transition_successful.q, %u_status_transition_successful.ds, %u_status_transition_successful.qs = hw.instance "u_status_transition_successful" @prim_subreg_ext(re: %130: i1, we: %false: i1, wd: %false: i1, d: %d_4: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_transition_successful_qs, %u_status_transition_successful.qs after %1 : i1
    %transition_count_error = hw.struct_extract %status["transition_count_error"] : !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>
    %d_5 = hw.struct_extract %transition_count_error["d"] : !hw.struct<d: i1>
    %u_status_transition_count_error.qe, %u_status_transition_count_error.qre, %u_status_transition_count_error.q, %u_status_transition_count_error.ds, %u_status_transition_count_error.qs = hw.instance "u_status_transition_count_error" @prim_subreg_ext(re: %130: i1, we: %false: i1, wd: %false: i1, d: %d_5: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_transition_count_error_qs, %u_status_transition_count_error.qs after %1 : i1
    %transition_error = hw.struct_extract %status["transition_error"] : !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>
    %d_6 = hw.struct_extract %transition_error["d"] : !hw.struct<d: i1>
    %u_status_transition_error.qe, %u_status_transition_error.qre, %u_status_transition_error.q, %u_status_transition_error.ds, %u_status_transition_error.qs = hw.instance "u_status_transition_error" @prim_subreg_ext(re: %130: i1, we: %false: i1, wd: %false: i1, d: %d_6: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_transition_error_qs, %u_status_transition_error.qs after %1 : i1
    %token_error = hw.struct_extract %status["token_error"] : !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>
    %d_7 = hw.struct_extract %token_error["d"] : !hw.struct<d: i1>
    %u_status_token_error.qe, %u_status_token_error.qre, %u_status_token_error.q, %u_status_token_error.ds, %u_status_token_error.qs = hw.instance "u_status_token_error" @prim_subreg_ext(re: %130: i1, we: %false: i1, wd: %false: i1, d: %d_7: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_token_error_qs, %u_status_token_error.qs after %1 : i1
    %nvm_rma_error = hw.struct_extract %status["nvm_rma_error"] : !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>
    %d_8 = hw.struct_extract %nvm_rma_error["d"] : !hw.struct<d: i1>
    %u_status_nvm_rma_error.qe, %u_status_nvm_rma_error.qre, %u_status_nvm_rma_error.q, %u_status_nvm_rma_error.ds, %u_status_nvm_rma_error.qs = hw.instance "u_status_nvm_rma_error" @prim_subreg_ext(re: %130: i1, we: %false: i1, wd: %false: i1, d: %d_8: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_nvm_rma_error_qs, %u_status_nvm_rma_error.qs after %1 : i1
    %otp_error = hw.struct_extract %status["otp_error"] : !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>
    %d_9 = hw.struct_extract %otp_error["d"] : !hw.struct<d: i1>
    %u_status_otp_error.qe, %u_status_otp_error.qre, %u_status_otp_error.q, %u_status_otp_error.ds, %u_status_otp_error.qs = hw.instance "u_status_otp_error" @prim_subreg_ext(re: %130: i1, we: %false: i1, wd: %false: i1, d: %d_9: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_otp_error_qs, %u_status_otp_error.qs after %1 : i1
    %state_error = hw.struct_extract %status["state_error"] : !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>
    %d_10 = hw.struct_extract %state_error["d"] : !hw.struct<d: i1>
    %u_status_state_error.qe, %u_status_state_error.qre, %u_status_state_error.q, %u_status_state_error.ds, %u_status_state_error.qs = hw.instance "u_status_state_error" @prim_subreg_ext(re: %130: i1, we: %false: i1, wd: %false: i1, d: %d_10: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_state_error_qs, %u_status_state_error.qs after %1 : i1
    %bus_integ_error = hw.struct_extract %status["bus_integ_error"] : !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>
    %d_11 = hw.struct_extract %bus_integ_error["d"] : !hw.struct<d: i1>
    %u_status_bus_integ_error.qe, %u_status_bus_integ_error.qre, %u_status_bus_integ_error.q, %u_status_bus_integ_error.ds, %u_status_bus_integ_error.qs = hw.instance "u_status_bus_integ_error" @prim_subreg_ext(re: %130: i1, we: %false: i1, wd: %false: i1, d: %d_11: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_bus_integ_error_qs, %u_status_bus_integ_error.qs after %1 : i1
    %otp_partition_error = hw.struct_extract %status["otp_partition_error"] : !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>
    %d_12 = hw.struct_extract %otp_partition_error["d"] : !hw.struct<d: i1>
    %u_status_otp_partition_error.qe, %u_status_otp_partition_error.qre, %u_status_otp_partition_error.q, %u_status_otp_partition_error.ds, %u_status_otp_partition_error.qs = hw.instance "u_status_otp_partition_error" @prim_subreg_ext(re: %130: i1, we: %false: i1, wd: %false: i1, d: %d_12: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_otp_partition_error_qs, %u_status_otp_partition_error.qs after %1 : i1
    %20 = llhd.prb %claim_transition_if_regwen_we : i1
    %u_claim_transition_if_regwen.qe, %u_claim_transition_if_regwen.q, %u_claim_transition_if_regwen.ds, %u_claim_transition_if_regwen.qs = hw.instance "u_claim_transition_if_regwen" @prim_subreg(clk_i: %3: i1, rst_ni: %4: i1, we: %20: i1, wd: %126: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %claim_transition_if_regwen_qs, %u_claim_transition_if_regwen.qs after %1 : i1
    %21 = llhd.prb %claim_transition_if_gated_we : i1
    %claim_transition_if = hw.struct_extract %hw2reg["claim_transition_if"] : !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>
    %d_13 = hw.struct_extract %claim_transition_if["d"] : !hw.struct<d: i8>
    %22 = llhd.sig.struct_extract %reg2hw["claim_transition_if"] : <!hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>>
    %23 = llhd.sig.struct_extract %22["q"] : <!hw.struct<q: i8, qe: i1>>
    %u_claim_transition_if.qe, %u_claim_transition_if.qre, %u_claim_transition_if.q, %u_claim_transition_if.ds, %u_claim_transition_if.qs = hw.instance "u_claim_transition_if" @prim_subreg_ext_0(re: %134: i1, we: %21: i1, wd: %135: i8, d: %d_13: i8) -> (qe: i1, qre: i1, q: i8, ds: i8, qs: i8)
    llhd.drv %claim_transition_if_flds_we, %u_claim_transition_if.qe after %1 : i1
    llhd.drv %23, %u_claim_transition_if.q after %1 : i8
    llhd.drv %claim_transition_if_qs, %u_claim_transition_if.qs after %1 : i8
    %transition_regwen = hw.struct_extract %hw2reg["transition_regwen"] : !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>
    %d_14 = hw.struct_extract %transition_regwen["d"] : !hw.struct<d: i1>
    %u_transition_regwen.qe, %u_transition_regwen.qre, %u_transition_regwen.q, %u_transition_regwen.ds, %u_transition_regwen.qs = hw.instance "u_transition_regwen" @prim_subreg_ext(re: %137: i1, we: %false: i1, wd: %false: i1, d: %d_14: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %transition_regwen_qs, %u_transition_regwen.qs after %1 : i1
    %24 = llhd.prb %transition_cmd_gated_we : i1
    %25 = llhd.sig.struct_extract %reg2hw["transition_cmd"] : <!hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>>
    %26 = llhd.sig.struct_extract %25["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_transition_cmd.qe, %u_transition_cmd.qre, %u_transition_cmd.q, %u_transition_cmd.ds, %u_transition_cmd.qs = hw.instance "u_transition_cmd" @prim_subreg_ext(re: %false: i1, we: %24: i1, wd: %126: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %transition_cmd_flds_we, %u_transition_cmd.qe after %1 : i1
    llhd.drv %26, %u_transition_cmd.q after %1 : i1
    %27 = llhd.prb %transition_ctrl_gated_we : i1
    %transition_ctrl = hw.struct_extract %hw2reg["transition_ctrl"] : !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>
    %ext_clock_en = hw.struct_extract %transition_ctrl["ext_clock_en"] : !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>
    %d_15 = hw.struct_extract %ext_clock_en["d"] : !hw.struct<d: i1>
    %28 = llhd.sig.extract %transition_ctrl_flds_we from %false : <i2> -> <i1>
    %29 = llhd.sig.struct_extract %reg2hw["transition_ctrl"] : <!hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>>
    %30 = llhd.sig.struct_extract %29["ext_clock_en"] : <!hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>>
    %31 = llhd.sig.struct_extract %30["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_transition_ctrl_ext_clock_en.qe, %u_transition_ctrl_ext_clock_en.qre, %u_transition_ctrl_ext_clock_en.q, %u_transition_ctrl_ext_clock_en.ds, %u_transition_ctrl_ext_clock_en.qs = hw.instance "u_transition_ctrl_ext_clock_en" @prim_subreg_ext(re: %140: i1, we: %27: i1, wd: %126: i1, d: %d_15: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %28, %u_transition_ctrl_ext_clock_en.qe after %1 : i1
    llhd.drv %31, %u_transition_ctrl_ext_clock_en.q after %1 : i1
    llhd.drv %transition_ctrl_ext_clock_en_qs, %u_transition_ctrl_ext_clock_en.qs after %1 : i1
    %volatile_raw_unlock = hw.struct_extract %transition_ctrl["volatile_raw_unlock"] : !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>
    %d_16 = hw.struct_extract %volatile_raw_unlock["d"] : !hw.struct<d: i1>
    %32 = llhd.sig.extract %transition_ctrl_flds_we from %true : <i2> -> <i1>
    %33 = llhd.sig.struct_extract %29["volatile_raw_unlock"] : <!hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>>
    %34 = llhd.sig.struct_extract %33["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_transition_ctrl_volatile_raw_unlock.qe, %u_transition_ctrl_volatile_raw_unlock.qre, %u_transition_ctrl_volatile_raw_unlock.q, %u_transition_ctrl_volatile_raw_unlock.ds, %u_transition_ctrl_volatile_raw_unlock.qs = hw.instance "u_transition_ctrl_volatile_raw_unlock" @prim_subreg_ext(re: %140: i1, we: %27: i1, wd: %127: i1, d: %d_16: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %32, %u_transition_ctrl_volatile_raw_unlock.qe after %1 : i1
    llhd.drv %34, %u_transition_ctrl_volatile_raw_unlock.q after %1 : i1
    llhd.drv %transition_ctrl_volatile_raw_unlock_qs, %u_transition_ctrl_volatile_raw_unlock.qs after %1 : i1
    %35 = llhd.prb %transition_token_0_gated_we : i1
    %transition_token = hw.struct_extract %hw2reg["transition_token"] : !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>
    %36 = hw.array_get %transition_token[%c0_i2] : !hw.array<4xstruct<d: i32>>, i2
    %d_17 = hw.struct_extract %36["d"] : !hw.struct<d: i32>
    %37 = llhd.sig.struct_extract %reg2hw["transition_token"] : <!hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>>
    %38 = llhd.sig.array_get %37[%c0_i2] : <!hw.array<4xstruct<q: i32, qe: i1>>>
    %39 = llhd.sig.struct_extract %38["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_transition_token_0.qe, %u_transition_token_0.qre, %u_transition_token_0.q, %u_transition_token_0.ds, %u_transition_token_0.qs = hw.instance "u_transition_token_0" @prim_subreg_ext_1(re: %142: i1, we: %35: i1, wd: %u_reg_if.wdata_o: i32, d: %d_17: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %transition_token_0_flds_we, %u_transition_token_0.qe after %1 : i1
    llhd.drv %39, %u_transition_token_0.q after %1 : i32
    llhd.drv %transition_token_0_qs, %u_transition_token_0.qs after %1 : i32
    %40 = llhd.prb %transition_token_1_gated_we : i1
    %41 = hw.array_get %transition_token[%c1_i2] : !hw.array<4xstruct<d: i32>>, i2
    %d_18 = hw.struct_extract %41["d"] : !hw.struct<d: i32>
    %42 = llhd.sig.array_get %37[%c1_i2] : <!hw.array<4xstruct<q: i32, qe: i1>>>
    %43 = llhd.sig.struct_extract %42["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_transition_token_1.qe, %u_transition_token_1.qre, %u_transition_token_1.q, %u_transition_token_1.ds, %u_transition_token_1.qs = hw.instance "u_transition_token_1" @prim_subreg_ext_1(re: %144: i1, we: %40: i1, wd: %u_reg_if.wdata_o: i32, d: %d_18: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %transition_token_1_flds_we, %u_transition_token_1.qe after %1 : i1
    llhd.drv %43, %u_transition_token_1.q after %1 : i32
    llhd.drv %transition_token_1_qs, %u_transition_token_1.qs after %1 : i32
    %44 = llhd.prb %transition_token_2_gated_we : i1
    %45 = hw.array_get %transition_token[%c-2_i2] : !hw.array<4xstruct<d: i32>>, i2
    %d_19 = hw.struct_extract %45["d"] : !hw.struct<d: i32>
    %46 = llhd.sig.array_get %37[%c-2_i2] : <!hw.array<4xstruct<q: i32, qe: i1>>>
    %47 = llhd.sig.struct_extract %46["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_transition_token_2.qe, %u_transition_token_2.qre, %u_transition_token_2.q, %u_transition_token_2.ds, %u_transition_token_2.qs = hw.instance "u_transition_token_2" @prim_subreg_ext_1(re: %146: i1, we: %44: i1, wd: %u_reg_if.wdata_o: i32, d: %d_19: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %transition_token_2_flds_we, %u_transition_token_2.qe after %1 : i1
    llhd.drv %47, %u_transition_token_2.q after %1 : i32
    llhd.drv %transition_token_2_qs, %u_transition_token_2.qs after %1 : i32
    %48 = llhd.prb %transition_token_3_gated_we : i1
    %49 = hw.array_get %transition_token[%c-1_i2] : !hw.array<4xstruct<d: i32>>, i2
    %d_20 = hw.struct_extract %49["d"] : !hw.struct<d: i32>
    %50 = llhd.sig.array_get %37[%c-1_i2] : <!hw.array<4xstruct<q: i32, qe: i1>>>
    %51 = llhd.sig.struct_extract %50["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_transition_token_3.qe, %u_transition_token_3.qre, %u_transition_token_3.q, %u_transition_token_3.ds, %u_transition_token_3.qs = hw.instance "u_transition_token_3" @prim_subreg_ext_1(re: %148: i1, we: %48: i1, wd: %u_reg_if.wdata_o: i32, d: %d_20: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %transition_token_3_flds_we, %u_transition_token_3.qe after %1 : i1
    llhd.drv %51, %u_transition_token_3.q after %1 : i32
    llhd.drv %transition_token_3_qs, %u_transition_token_3.qs after %1 : i32
    %52 = llhd.prb %transition_target_gated_we : i1
    %transition_target = hw.struct_extract %hw2reg["transition_target"] : !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>
    %d_21 = hw.struct_extract %transition_target["d"] : !hw.struct<d: i30>
    %53 = llhd.sig.struct_extract %reg2hw["transition_target"] : <!hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>>
    %54 = llhd.sig.struct_extract %53["q"] : <!hw.struct<q: i30, qe: i1>>
    %u_transition_target.qe, %u_transition_target.qre, %u_transition_target.q, %u_transition_target.ds, %u_transition_target.qs = hw.instance "u_transition_target" @prim_subreg_ext_2(re: %150: i1, we: %52: i1, wd: %151: i30, d: %d_21: i30) -> (qe: i1, qre: i1, q: i30, ds: i30, qs: i30)
    llhd.drv %transition_target_flds_we, %u_transition_target.qe after %1 : i1
    llhd.drv %54, %u_transition_target.q after %1 : i30
    llhd.drv %transition_target_qs, %u_transition_target.qs after %1 : i30
    %55 = llhd.prb %otp_vendor_test_ctrl_gated_we : i1
    %otp_vendor_test_ctrl = hw.struct_extract %hw2reg["otp_vendor_test_ctrl"] : !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>
    %d_22 = hw.struct_extract %otp_vendor_test_ctrl["d"] : !hw.struct<d: i32>
    %56 = llhd.sig.struct_extract %reg2hw["otp_vendor_test_ctrl"] : <!hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>>
    %57 = llhd.sig.struct_extract %56["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_otp_vendor_test_ctrl.qe, %u_otp_vendor_test_ctrl.qre, %u_otp_vendor_test_ctrl.q, %u_otp_vendor_test_ctrl.ds, %u_otp_vendor_test_ctrl.qs = hw.instance "u_otp_vendor_test_ctrl" @prim_subreg_ext_1(re: %153: i1, we: %55: i1, wd: %u_reg_if.wdata_o: i32, d: %d_22: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %otp_vendor_test_ctrl_flds_we, %u_otp_vendor_test_ctrl.qe after %1 : i1
    llhd.drv %57, %u_otp_vendor_test_ctrl.q after %1 : i32
    llhd.drv %otp_vendor_test_ctrl_qs, %u_otp_vendor_test_ctrl.qs after %1 : i32
    %otp_vendor_test_status = hw.struct_extract %hw2reg["otp_vendor_test_status"] : !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>
    %d_23 = hw.struct_extract %otp_vendor_test_status["d"] : !hw.struct<d: i32>
    %u_otp_vendor_test_status.qe, %u_otp_vendor_test_status.qre, %u_otp_vendor_test_status.q, %u_otp_vendor_test_status.ds, %u_otp_vendor_test_status.qs = hw.instance "u_otp_vendor_test_status" @prim_subreg_ext_1(re: %155: i1, we: %false: i1, wd: %c0_i32: i32, d: %d_23: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %otp_vendor_test_status_qs, %u_otp_vendor_test_status.qs after %1 : i32
    %lc_state = hw.struct_extract %hw2reg["lc_state"] : !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>
    %d_24 = hw.struct_extract %lc_state["d"] : !hw.struct<d: i30>
    %u_lc_state.qe, %u_lc_state.qre, %u_lc_state.q, %u_lc_state.ds, %u_lc_state.qs = hw.instance "u_lc_state" @prim_subreg_ext_2(re: %157: i1, we: %false: i1, wd: %c0_i30: i30, d: %d_24: i30) -> (qe: i1, qre: i1, q: i30, ds: i30, qs: i30)
    llhd.drv %lc_state_qs, %u_lc_state.qs after %1 : i30
    %lc_transition_cnt = hw.struct_extract %hw2reg["lc_transition_cnt"] : !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>
    %d_25 = hw.struct_extract %lc_transition_cnt["d"] : !hw.struct<d: i5>
    %u_lc_transition_cnt.qe, %u_lc_transition_cnt.qre, %u_lc_transition_cnt.q, %u_lc_transition_cnt.ds, %u_lc_transition_cnt.qs = hw.instance "u_lc_transition_cnt" @prim_subreg_ext_3(re: %159: i1, we: %false: i1, wd: %c0_i5: i5, d: %d_25: i5) -> (qe: i1, qre: i1, q: i5, ds: i5, qs: i5)
    llhd.drv %lc_transition_cnt_qs, %u_lc_transition_cnt.qs after %1 : i5
    %lc_id_state = hw.struct_extract %hw2reg["lc_id_state"] : !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>
    %d_26 = hw.struct_extract %lc_id_state["d"] : !hw.struct<d: i32>
    %u_lc_id_state.qe, %u_lc_id_state.qre, %u_lc_id_state.q, %u_lc_id_state.ds, %u_lc_id_state.qs = hw.instance "u_lc_id_state" @prim_subreg_ext_1(re: %161: i1, we: %false: i1, wd: %c0_i32: i32, d: %d_26: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %lc_id_state_qs, %u_lc_id_state.qs after %1 : i32
    %hw_revision0 = hw.struct_extract %hw2reg["hw_revision0"] : !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>
    %product_id = hw.struct_extract %hw_revision0["product_id"] : !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>
    %d_27 = hw.struct_extract %product_id["d"] : !hw.struct<d: i16>
    %u_hw_revision0_product_id.qe, %u_hw_revision0_product_id.qre, %u_hw_revision0_product_id.q, %u_hw_revision0_product_id.ds, %u_hw_revision0_product_id.qs = hw.instance "u_hw_revision0_product_id" @prim_subreg_ext_4(re: %163: i1, we: %false: i1, wd: %c0_i16: i16, d: %d_27: i16) -> (qe: i1, qre: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %hw_revision0_product_id_qs, %u_hw_revision0_product_id.qs after %1 : i16
    %silicon_creator_id = hw.struct_extract %hw_revision0["silicon_creator_id"] : !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>
    %d_28 = hw.struct_extract %silicon_creator_id["d"] : !hw.struct<d: i16>
    %u_hw_revision0_silicon_creator_id.qe, %u_hw_revision0_silicon_creator_id.qre, %u_hw_revision0_silicon_creator_id.q, %u_hw_revision0_silicon_creator_id.ds, %u_hw_revision0_silicon_creator_id.qs = hw.instance "u_hw_revision0_silicon_creator_id" @prim_subreg_ext_4(re: %163: i1, we: %false: i1, wd: %c0_i16: i16, d: %d_28: i16) -> (qe: i1, qre: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %hw_revision0_silicon_creator_id_qs, %u_hw_revision0_silicon_creator_id.qs after %1 : i16
    %hw_revision1 = hw.struct_extract %hw2reg["hw_revision1"] : !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>
    %revision_id = hw.struct_extract %hw_revision1["revision_id"] : !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>
    %d_29 = hw.struct_extract %revision_id["d"] : !hw.struct<d: i8>
    %u_hw_revision1_revision_id.qe, %u_hw_revision1_revision_id.qre, %u_hw_revision1_revision_id.q, %u_hw_revision1_revision_id.ds, %u_hw_revision1_revision_id.qs = hw.instance "u_hw_revision1_revision_id" @prim_subreg_ext_0(re: %165: i1, we: %false: i1, wd: %c0_i8: i8, d: %d_29: i8) -> (qe: i1, qre: i1, q: i8, ds: i8, qs: i8)
    llhd.drv %hw_revision1_revision_id_qs, %u_hw_revision1_revision_id.qs after %1 : i8
    %reserved = hw.struct_extract %hw_revision1["reserved"] : !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>
    %d_30 = hw.struct_extract %reserved["d"] : !hw.struct<d: i24>
    %u_hw_revision1_reserved.qe, %u_hw_revision1_reserved.qre, %u_hw_revision1_reserved.q, %u_hw_revision1_reserved.ds, %u_hw_revision1_reserved.qs = hw.instance "u_hw_revision1_reserved" @prim_subreg_ext_5(re: %165: i1, we: %false: i1, wd: %c0_i24: i24, d: %d_30: i24) -> (qe: i1, qre: i1, q: i24, ds: i24, qs: i24)
    llhd.drv %hw_revision1_reserved_qs, %u_hw_revision1_reserved.qs after %1 : i24
    %device_id = hw.struct_extract %hw2reg["device_id"] : !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>
    %58 = hw.array_get %device_id[%c0_i3] : !hw.array<8xstruct<d: i32>>, i3
    %d_31 = hw.struct_extract %58["d"] : !hw.struct<d: i32>
    %u_device_id_0.qe, %u_device_id_0.qre, %u_device_id_0.q, %u_device_id_0.ds, %u_device_id_0.qs = hw.instance "u_device_id_0" @prim_subreg_ext_1(re: %167: i1, we: %false: i1, wd: %c0_i32: i32, d: %d_31: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %device_id_0_qs, %u_device_id_0.qs after %1 : i32
    %59 = hw.array_get %device_id[%c1_i3] : !hw.array<8xstruct<d: i32>>, i3
    %d_32 = hw.struct_extract %59["d"] : !hw.struct<d: i32>
    %u_device_id_1.qe, %u_device_id_1.qre, %u_device_id_1.q, %u_device_id_1.ds, %u_device_id_1.qs = hw.instance "u_device_id_1" @prim_subreg_ext_1(re: %169: i1, we: %false: i1, wd: %c0_i32: i32, d: %d_32: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %device_id_1_qs, %u_device_id_1.qs after %1 : i32
    %60 = hw.array_get %device_id[%c2_i3] : !hw.array<8xstruct<d: i32>>, i3
    %d_33 = hw.struct_extract %60["d"] : !hw.struct<d: i32>
    %u_device_id_2.qe, %u_device_id_2.qre, %u_device_id_2.q, %u_device_id_2.ds, %u_device_id_2.qs = hw.instance "u_device_id_2" @prim_subreg_ext_1(re: %171: i1, we: %false: i1, wd: %c0_i32: i32, d: %d_33: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %device_id_2_qs, %u_device_id_2.qs after %1 : i32
    %61 = hw.array_get %device_id[%c3_i3] : !hw.array<8xstruct<d: i32>>, i3
    %d_34 = hw.struct_extract %61["d"] : !hw.struct<d: i32>
    %u_device_id_3.qe, %u_device_id_3.qre, %u_device_id_3.q, %u_device_id_3.ds, %u_device_id_3.qs = hw.instance "u_device_id_3" @prim_subreg_ext_1(re: %173: i1, we: %false: i1, wd: %c0_i32: i32, d: %d_34: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %device_id_3_qs, %u_device_id_3.qs after %1 : i32
    %62 = hw.array_get %device_id[%c-4_i3] : !hw.array<8xstruct<d: i32>>, i3
    %d_35 = hw.struct_extract %62["d"] : !hw.struct<d: i32>
    %u_device_id_4.qe, %u_device_id_4.qre, %u_device_id_4.q, %u_device_id_4.ds, %u_device_id_4.qs = hw.instance "u_device_id_4" @prim_subreg_ext_1(re: %175: i1, we: %false: i1, wd: %c0_i32: i32, d: %d_35: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %device_id_4_qs, %u_device_id_4.qs after %1 : i32
    %63 = hw.array_get %device_id[%c-3_i3] : !hw.array<8xstruct<d: i32>>, i3
    %d_36 = hw.struct_extract %63["d"] : !hw.struct<d: i32>
    %u_device_id_5.qe, %u_device_id_5.qre, %u_device_id_5.q, %u_device_id_5.ds, %u_device_id_5.qs = hw.instance "u_device_id_5" @prim_subreg_ext_1(re: %177: i1, we: %false: i1, wd: %c0_i32: i32, d: %d_36: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %device_id_5_qs, %u_device_id_5.qs after %1 : i32
    %64 = hw.array_get %device_id[%c-2_i3] : !hw.array<8xstruct<d: i32>>, i3
    %d_37 = hw.struct_extract %64["d"] : !hw.struct<d: i32>
    %u_device_id_6.qe, %u_device_id_6.qre, %u_device_id_6.q, %u_device_id_6.ds, %u_device_id_6.qs = hw.instance "u_device_id_6" @prim_subreg_ext_1(re: %179: i1, we: %false: i1, wd: %c0_i32: i32, d: %d_37: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %device_id_6_qs, %u_device_id_6.qs after %1 : i32
    %65 = hw.array_get %device_id[%c-1_i3] : !hw.array<8xstruct<d: i32>>, i3
    %d_38 = hw.struct_extract %65["d"] : !hw.struct<d: i32>
    %u_device_id_7.qe, %u_device_id_7.qre, %u_device_id_7.q, %u_device_id_7.ds, %u_device_id_7.qs = hw.instance "u_device_id_7" @prim_subreg_ext_1(re: %181: i1, we: %false: i1, wd: %c0_i32: i32, d: %d_38: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %device_id_7_qs, %u_device_id_7.qs after %1 : i32
    %manuf_state = hw.struct_extract %hw2reg["manuf_state"] : !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>
    %66 = hw.array_get %manuf_state[%c0_i3] : !hw.array<8xstruct<d: i32>>, i3
    %d_39 = hw.struct_extract %66["d"] : !hw.struct<d: i32>
    %u_manuf_state_0.qe, %u_manuf_state_0.qre, %u_manuf_state_0.q, %u_manuf_state_0.ds, %u_manuf_state_0.qs = hw.instance "u_manuf_state_0" @prim_subreg_ext_1(re: %183: i1, we: %false: i1, wd: %c0_i32: i32, d: %d_39: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %manuf_state_0_qs, %u_manuf_state_0.qs after %1 : i32
    %67 = hw.array_get %manuf_state[%c1_i3] : !hw.array<8xstruct<d: i32>>, i3
    %d_40 = hw.struct_extract %67["d"] : !hw.struct<d: i32>
    %u_manuf_state_1.qe, %u_manuf_state_1.qre, %u_manuf_state_1.q, %u_manuf_state_1.ds, %u_manuf_state_1.qs = hw.instance "u_manuf_state_1" @prim_subreg_ext_1(re: %185: i1, we: %false: i1, wd: %c0_i32: i32, d: %d_40: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %manuf_state_1_qs, %u_manuf_state_1.qs after %1 : i32
    %68 = hw.array_get %manuf_state[%c2_i3] : !hw.array<8xstruct<d: i32>>, i3
    %d_41 = hw.struct_extract %68["d"] : !hw.struct<d: i32>
    %u_manuf_state_2.qe, %u_manuf_state_2.qre, %u_manuf_state_2.q, %u_manuf_state_2.ds, %u_manuf_state_2.qs = hw.instance "u_manuf_state_2" @prim_subreg_ext_1(re: %187: i1, we: %false: i1, wd: %c0_i32: i32, d: %d_41: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %manuf_state_2_qs, %u_manuf_state_2.qs after %1 : i32
    %69 = hw.array_get %manuf_state[%c3_i3] : !hw.array<8xstruct<d: i32>>, i3
    %d_42 = hw.struct_extract %69["d"] : !hw.struct<d: i32>
    %u_manuf_state_3.qe, %u_manuf_state_3.qre, %u_manuf_state_3.q, %u_manuf_state_3.ds, %u_manuf_state_3.qs = hw.instance "u_manuf_state_3" @prim_subreg_ext_1(re: %189: i1, we: %false: i1, wd: %c0_i32: i32, d: %d_42: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %manuf_state_3_qs, %u_manuf_state_3.qs after %1 : i32
    %70 = hw.array_get %manuf_state[%c-4_i3] : !hw.array<8xstruct<d: i32>>, i3
    %d_43 = hw.struct_extract %70["d"] : !hw.struct<d: i32>
    %u_manuf_state_4.qe, %u_manuf_state_4.qre, %u_manuf_state_4.q, %u_manuf_state_4.ds, %u_manuf_state_4.qs = hw.instance "u_manuf_state_4" @prim_subreg_ext_1(re: %191: i1, we: %false: i1, wd: %c0_i32: i32, d: %d_43: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %manuf_state_4_qs, %u_manuf_state_4.qs after %1 : i32
    %71 = hw.array_get %manuf_state[%c-3_i3] : !hw.array<8xstruct<d: i32>>, i3
    %d_44 = hw.struct_extract %71["d"] : !hw.struct<d: i32>
    %u_manuf_state_5.qe, %u_manuf_state_5.qre, %u_manuf_state_5.q, %u_manuf_state_5.ds, %u_manuf_state_5.qs = hw.instance "u_manuf_state_5" @prim_subreg_ext_1(re: %193: i1, we: %false: i1, wd: %c0_i32: i32, d: %d_44: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %manuf_state_5_qs, %u_manuf_state_5.qs after %1 : i32
    %72 = hw.array_get %manuf_state[%c-2_i3] : !hw.array<8xstruct<d: i32>>, i3
    %d_45 = hw.struct_extract %72["d"] : !hw.struct<d: i32>
    %u_manuf_state_6.qe, %u_manuf_state_6.qre, %u_manuf_state_6.q, %u_manuf_state_6.ds, %u_manuf_state_6.qs = hw.instance "u_manuf_state_6" @prim_subreg_ext_1(re: %195: i1, we: %false: i1, wd: %c0_i32: i32, d: %d_45: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %manuf_state_6_qs, %u_manuf_state_6.qs after %1 : i32
    %73 = hw.array_get %manuf_state[%c-1_i3] : !hw.array<8xstruct<d: i32>>, i3
    %d_46 = hw.struct_extract %73["d"] : !hw.struct<d: i32>
    %u_manuf_state_7.qe, %u_manuf_state_7.qre, %u_manuf_state_7.q, %u_manuf_state_7.ds, %u_manuf_state_7.qs = hw.instance "u_manuf_state_7" @prim_subreg_ext_1(re: %197: i1, we: %false: i1, wd: %c0_i32: i32, d: %d_46: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %manuf_state_7_qs, %u_manuf_state_7.qs after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %244 = llhd.prb %clk_i_0 : i1
      %245 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %246 = llhd.prb %clk_i_0 : i1
      %247 = comb.xor bin %244, %true : i1
      %248 = comb.and bin %247, %246 : i1
      %249 = llhd.prb %rst_ni_1 : i1
      %250 = comb.xor bin %249, %true : i1
      %251 = comb.and bin %245, %250 : i1
      %252 = comb.or bin %248, %251 : i1
      cf.cond_br %252, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %253 = llhd.prb %rst_ni_1 : i1
      %254 = comb.xor %253, %true : i1
      cf.cond_br %254, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %err_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %255 = llhd.prb %intg_err : i1
      %256 = llhd.prb %reg_we_err : i1
      %257 = comb.or %255, %256 : i1
      cf.cond_br %257, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %err_q, %true after %0 : i1
      cf.br ^bb1
    }
    %74 = llhd.prb %err_q : i1
    %75 = llhd.prb %intg_err : i1
    %76 = llhd.prb %reg_we_err : i1
    %77 = comb.or %74, %75, %76 : i1
    %78 = llhd.prb %reg_rdata_next {sv.namehint = "reg_rdata"} : i32
    %79 = llhd.prb %wr_err : i1
    %80 = comb.or %121, %79, %75 {sv.namehint = "reg_error"} : i1
    %81 = llhd.prb %alert_test_flds_we : i3
    %82 = comb.icmp eq %81, %c-1_i3 {sv.namehint = "alert_test_qe"} : i3
    %83 = llhd.sig.struct_extract %12["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %83, %82 after %1 : i1
    %84 = llhd.sig.struct_extract %15["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %84, %82 after %1 : i1
    %85 = llhd.sig.struct_extract %18["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %85, %82 after %1 : i1
    %86 = llhd.prb %claim_transition_if_flds_we {sv.namehint = "claim_transition_if_qe"} : i1
    %87 = llhd.prb %claim_transition_if_regwen_qs : i1
    %88 = comb.and %133, %6, %124, %87 : i1
    llhd.drv %claim_transition_if_gated_we, %88 after %1 : i1
    %89 = llhd.sig.struct_extract %22["qe"] : <!hw.struct<q: i8, qe: i1>>
    llhd.drv %89, %86 after %1 : i1
    %90 = llhd.prb %transition_cmd_flds_we {sv.namehint = "transition_cmd_qe"} : i1
    %91 = llhd.prb %transition_regwen_qs : i1
    %92 = comb.and %138, %6, %124, %91 : i1
    llhd.drv %transition_cmd_gated_we, %92 after %1 : i1
    %93 = llhd.sig.struct_extract %25["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %93, %90 after %1 : i1
    %94 = llhd.prb %transition_ctrl_flds_we : i2
    %95 = comb.icmp eq %94, %c-1_i2 {sv.namehint = "transition_ctrl_qe"} : i2
    %96 = comb.and %139, %6, %124, %91 : i1
    llhd.drv %transition_ctrl_gated_we, %96 after %1 : i1
    %97 = llhd.sig.struct_extract %30["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %97, %95 after %1 : i1
    %98 = llhd.sig.struct_extract %33["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %98, %95 after %1 : i1
    %99 = llhd.prb %transition_token_0_flds_we {sv.namehint = "transition_token_0_qe"} : i1
    %100 = comb.and %141, %6, %124, %91 : i1
    llhd.drv %transition_token_0_gated_we, %100 after %1 : i1
    %101 = llhd.sig.struct_extract %38["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %101, %99 after %1 : i1
    %102 = llhd.prb %transition_token_1_flds_we {sv.namehint = "transition_token_1_qe"} : i1
    %103 = comb.and %143, %6, %124, %91 : i1
    llhd.drv %transition_token_1_gated_we, %103 after %1 : i1
    %104 = llhd.sig.struct_extract %42["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %104, %102 after %1 : i1
    %105 = llhd.prb %transition_token_2_flds_we {sv.namehint = "transition_token_2_qe"} : i1
    %106 = comb.and %145, %6, %124, %91 : i1
    llhd.drv %transition_token_2_gated_we, %106 after %1 : i1
    %107 = llhd.sig.struct_extract %46["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %107, %105 after %1 : i1
    %108 = llhd.prb %transition_token_3_flds_we {sv.namehint = "transition_token_3_qe"} : i1
    %109 = comb.and %147, %6, %124, %91 : i1
    llhd.drv %transition_token_3_gated_we, %109 after %1 : i1
    %110 = llhd.sig.struct_extract %50["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %110, %108 after %1 : i1
    %111 = llhd.prb %transition_target_flds_we {sv.namehint = "transition_target_qe"} : i1
    %112 = comb.and %149, %6, %124, %91 : i1
    llhd.drv %transition_target_gated_we, %112 after %1 : i1
    %113 = llhd.sig.struct_extract %53["qe"] : <!hw.struct<q: i30, qe: i1>>
    llhd.drv %113, %111 after %1 : i1
    %114 = llhd.prb %otp_vendor_test_ctrl_flds_we {sv.namehint = "otp_vendor_test_ctrl_qe"} : i1
    %115 = comb.and %152, %6, %124, %91 : i1
    llhd.drv %otp_vendor_test_ctrl_gated_we, %115 after %1 : i1
    %116 = llhd.sig.struct_extract %56["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %116, %114 after %1 : i1
    %117 = llhd.prb %addr_hit : i35
    %118 = llhd.prb %reg_addr : i8
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %244 = llhd.sig.extract %addr_hit from %c0_i6 : <i35> -> <i1>
      %245 = llhd.prb %reg_addr : i8
      %246 = comb.icmp eq %245, %c0_i8 : i8
      llhd.drv %244, %246 after %1 : i1
      %247 = llhd.sig.extract %addr_hit from %c1_i6 : <i35> -> <i1>
      %248 = llhd.prb %reg_addr : i8
      %249 = comb.icmp eq %248, %c4_i8 : i8
      llhd.drv %247, %249 after %1 : i1
      %250 = llhd.sig.extract %addr_hit from %c2_i6 : <i35> -> <i1>
      %251 = llhd.prb %reg_addr : i8
      %252 = comb.icmp eq %251, %c8_i8 : i8
      llhd.drv %250, %252 after %1 : i1
      %253 = llhd.sig.extract %addr_hit from %c3_i6 : <i35> -> <i1>
      %254 = llhd.prb %reg_addr : i8
      %255 = comb.icmp eq %254, %c12_i8 : i8
      llhd.drv %253, %255 after %1 : i1
      %256 = llhd.sig.extract %addr_hit from %c4_i6 : <i35> -> <i1>
      %257 = llhd.prb %reg_addr : i8
      %258 = comb.icmp eq %257, %c16_i8 : i8
      llhd.drv %256, %258 after %1 : i1
      %259 = llhd.sig.extract %addr_hit from %c5_i6 : <i35> -> <i1>
      %260 = llhd.prb %reg_addr : i8
      %261 = comb.icmp eq %260, %c20_i8 : i8
      llhd.drv %259, %261 after %1 : i1
      %262 = llhd.sig.extract %addr_hit from %c6_i6 : <i35> -> <i1>
      %263 = llhd.prb %reg_addr : i8
      %264 = comb.icmp eq %263, %c24_i8 : i8
      llhd.drv %262, %264 after %1 : i1
      %265 = llhd.sig.extract %addr_hit from %c7_i6 : <i35> -> <i1>
      %266 = llhd.prb %reg_addr : i8
      %267 = comb.icmp eq %266, %c28_i8 : i8
      llhd.drv %265, %267 after %1 : i1
      %268 = llhd.sig.extract %addr_hit from %c8_i6 : <i35> -> <i1>
      %269 = llhd.prb %reg_addr : i8
      %270 = comb.icmp eq %269, %c32_i8 : i8
      llhd.drv %268, %270 after %1 : i1
      %271 = llhd.sig.extract %addr_hit from %c9_i6 : <i35> -> <i1>
      %272 = llhd.prb %reg_addr : i8
      %273 = comb.icmp eq %272, %c36_i8 : i8
      llhd.drv %271, %273 after %1 : i1
      %274 = llhd.sig.extract %addr_hit from %c10_i6 : <i35> -> <i1>
      %275 = llhd.prb %reg_addr : i8
      %276 = comb.icmp eq %275, %c40_i8 : i8
      llhd.drv %274, %276 after %1 : i1
      %277 = llhd.sig.extract %addr_hit from %c11_i6 : <i35> -> <i1>
      %278 = llhd.prb %reg_addr : i8
      %279 = comb.icmp eq %278, %c44_i8 : i8
      llhd.drv %277, %279 after %1 : i1
      %280 = llhd.sig.extract %addr_hit from %c12_i6 : <i35> -> <i1>
      %281 = llhd.prb %reg_addr : i8
      %282 = comb.icmp eq %281, %c48_i8 : i8
      llhd.drv %280, %282 after %1 : i1
      %283 = llhd.sig.extract %addr_hit from %c13_i6 : <i35> -> <i1>
      %284 = llhd.prb %reg_addr : i8
      %285 = comb.icmp eq %284, %c52_i8 : i8
      llhd.drv %283, %285 after %1 : i1
      %286 = llhd.sig.extract %addr_hit from %c14_i6 : <i35> -> <i1>
      %287 = llhd.prb %reg_addr : i8
      %288 = comb.icmp eq %287, %c56_i8 : i8
      llhd.drv %286, %288 after %1 : i1
      %289 = llhd.sig.extract %addr_hit from %c15_i6 : <i35> -> <i1>
      %290 = llhd.prb %reg_addr : i8
      %291 = comb.icmp eq %290, %c60_i8 : i8
      llhd.drv %289, %291 after %1 : i1
      %292 = llhd.sig.extract %addr_hit from %c16_i6 : <i35> -> <i1>
      %293 = llhd.prb %reg_addr : i8
      %294 = comb.icmp eq %293, %c64_i8 : i8
      llhd.drv %292, %294 after %1 : i1
      %295 = llhd.sig.extract %addr_hit from %c17_i6 : <i35> -> <i1>
      %296 = llhd.prb %reg_addr : i8
      %297 = comb.icmp eq %296, %c68_i8 : i8
      llhd.drv %295, %297 after %1 : i1
      %298 = llhd.sig.extract %addr_hit from %c18_i6 : <i35> -> <i1>
      %299 = llhd.prb %reg_addr : i8
      %300 = comb.icmp eq %299, %c72_i8 : i8
      llhd.drv %298, %300 after %1 : i1
      %301 = llhd.sig.extract %addr_hit from %c19_i6 : <i35> -> <i1>
      %302 = llhd.prb %reg_addr : i8
      %303 = comb.icmp eq %302, %c76_i8 : i8
      llhd.drv %301, %303 after %1 : i1
      %304 = llhd.sig.extract %addr_hit from %c20_i6 : <i35> -> <i1>
      %305 = llhd.prb %reg_addr : i8
      %306 = comb.icmp eq %305, %c80_i8 : i8
      llhd.drv %304, %306 after %1 : i1
      %307 = llhd.sig.extract %addr_hit from %c21_i6 : <i35> -> <i1>
      %308 = llhd.prb %reg_addr : i8
      %309 = comb.icmp eq %308, %c84_i8 : i8
      llhd.drv %307, %309 after %1 : i1
      %310 = llhd.sig.extract %addr_hit from %c22_i6 : <i35> -> <i1>
      %311 = llhd.prb %reg_addr : i8
      %312 = comb.icmp eq %311, %c88_i8 : i8
      llhd.drv %310, %312 after %1 : i1
      %313 = llhd.sig.extract %addr_hit from %c23_i6 : <i35> -> <i1>
      %314 = llhd.prb %reg_addr : i8
      %315 = comb.icmp eq %314, %c92_i8 : i8
      llhd.drv %313, %315 after %1 : i1
      %316 = llhd.sig.extract %addr_hit from %c24_i6 : <i35> -> <i1>
      %317 = llhd.prb %reg_addr : i8
      %318 = comb.icmp eq %317, %c96_i8 : i8
      llhd.drv %316, %318 after %1 : i1
      %319 = llhd.sig.extract %addr_hit from %c25_i6 : <i35> -> <i1>
      %320 = llhd.prb %reg_addr : i8
      %321 = comb.icmp eq %320, %c100_i8 : i8
      llhd.drv %319, %321 after %1 : i1
      %322 = llhd.sig.extract %addr_hit from %c26_i6 : <i35> -> <i1>
      %323 = llhd.prb %reg_addr : i8
      %324 = comb.icmp eq %323, %c104_i8 : i8
      llhd.drv %322, %324 after %1 : i1
      %325 = llhd.sig.extract %addr_hit from %c27_i6 : <i35> -> <i1>
      %326 = llhd.prb %reg_addr : i8
      %327 = comb.icmp eq %326, %c108_i8 : i8
      llhd.drv %325, %327 after %1 : i1
      %328 = llhd.sig.extract %addr_hit from %c28_i6 : <i35> -> <i1>
      %329 = llhd.prb %reg_addr : i8
      %330 = comb.icmp eq %329, %c112_i8 : i8
      llhd.drv %328, %330 after %1 : i1
      %331 = llhd.sig.extract %addr_hit from %c29_i6 : <i35> -> <i1>
      %332 = llhd.prb %reg_addr : i8
      %333 = comb.icmp eq %332, %c116_i8 : i8
      llhd.drv %331, %333 after %1 : i1
      %334 = llhd.sig.extract %addr_hit from %c30_i6 : <i35> -> <i1>
      %335 = llhd.prb %reg_addr : i8
      %336 = comb.icmp eq %335, %c120_i8 : i8
      llhd.drv %334, %336 after %1 : i1
      %337 = llhd.sig.extract %addr_hit from %c31_i6 : <i35> -> <i1>
      %338 = llhd.prb %reg_addr : i8
      %339 = comb.icmp eq %338, %c124_i8 : i8
      llhd.drv %337, %339 after %1 : i1
      %340 = llhd.sig.extract %addr_hit from %c-32_i6 : <i35> -> <i1>
      %341 = llhd.prb %reg_addr : i8
      %342 = comb.icmp eq %341, %c-128_i8 : i8
      llhd.drv %340, %342 after %1 : i1
      %343 = llhd.sig.extract %addr_hit from %c-31_i6 : <i35> -> <i1>
      %344 = llhd.prb %reg_addr : i8
      %345 = comb.icmp eq %344, %c-124_i8 : i8
      llhd.drv %343, %345 after %1 : i1
      %346 = llhd.sig.extract %addr_hit from %c-30_i6 : <i35> -> <i1>
      %347 = llhd.prb %reg_addr : i8
      %348 = comb.icmp eq %347, %c-120_i8 : i8
      llhd.drv %346, %348 after %1 : i1
      llhd.wait (%117, %118 : i35, i8), ^bb1
    }
    %119 = comb.or %u_reg_if.re_o, %6 : i1
    %120 = comb.icmp eq %117, %c0_i35 : i35
    %121 = comb.and %119, %120 {sv.namehint = "addrmiss"} : i1
    %122 = llhd.prb %reg_be : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %244 = llhd.prb %reg_we : i1
      %245 = llhd.prb %addr_hit : i35
      %246 = comb.extract %245 from 0 : (i35) -> i1
      %247 = llhd.prb %reg_be : i4
      %248 = comb.extract %247 from 0 : (i4) -> i2
      %249 = comb.extract %247 from 0 : (i4) -> i1
      %250 = comb.xor %249, %true : i1
      %251 = comb.and %246, %250 : i1
      %252 = comb.extract %245 from 1 : (i35) -> i1
      %253 = comb.icmp ne %248, %c-1_i2 : i2
      %254 = comb.and %252, %253 : i1
      %255 = comb.extract %245 from 2 : (i35) -> i1
      %256 = comb.and %255, %250 : i1
      %257 = comb.extract %245 from 3 : (i35) -> i1
      %258 = comb.and %257, %250 : i1
      %259 = comb.extract %245 from 4 : (i35) -> i1
      %260 = comb.and %259, %250 : i1
      %261 = comb.extract %245 from 5 : (i35) -> i1
      %262 = comb.and %261, %250 : i1
      %263 = comb.extract %245 from 6 : (i35) -> i1
      %264 = comb.and %263, %250 : i1
      %265 = comb.extract %245 from 7 : (i35) -> i1
      %266 = comb.icmp ne %247, %c-1_i4 : i4
      %267 = comb.and %265, %266 : i1
      %268 = comb.extract %245 from 8 : (i35) -> i1
      %269 = comb.icmp ne %247, %c-1_i4 : i4
      %270 = comb.and %268, %269 : i1
      %271 = comb.extract %245 from 9 : (i35) -> i1
      %272 = comb.icmp ne %247, %c-1_i4 : i4
      %273 = comb.and %271, %272 : i1
      %274 = comb.extract %245 from 10 : (i35) -> i1
      %275 = comb.icmp ne %247, %c-1_i4 : i4
      %276 = comb.and %274, %275 : i1
      %277 = comb.extract %245 from 11 : (i35) -> i1
      %278 = comb.icmp ne %247, %c-1_i4 : i4
      %279 = comb.and %277, %278 : i1
      %280 = comb.extract %245 from 12 : (i35) -> i1
      %281 = comb.icmp ne %247, %c-1_i4 : i4
      %282 = comb.and %280, %281 : i1
      %283 = comb.extract %245 from 13 : (i35) -> i1
      %284 = comb.icmp ne %247, %c-1_i4 : i4
      %285 = comb.and %283, %284 : i1
      %286 = comb.extract %245 from 14 : (i35) -> i1
      %287 = comb.icmp ne %247, %c-1_i4 : i4
      %288 = comb.and %286, %287 : i1
      %289 = comb.extract %245 from 15 : (i35) -> i1
      %290 = comb.and %289, %250 : i1
      %291 = comb.extract %245 from 16 : (i35) -> i1
      %292 = comb.icmp ne %247, %c-1_i4 : i4
      %293 = comb.and %291, %292 : i1
      %294 = comb.extract %245 from 17 : (i35) -> i1
      %295 = comb.icmp ne %247, %c-1_i4 : i4
      %296 = comb.and %294, %295 : i1
      %297 = comb.extract %245 from 18 : (i35) -> i1
      %298 = comb.icmp ne %247, %c-1_i4 : i4
      %299 = comb.and %297, %298 : i1
      %300 = comb.extract %245 from 19 : (i35) -> i1
      %301 = comb.icmp ne %247, %c-1_i4 : i4
      %302 = comb.and %300, %301 : i1
      %303 = comb.extract %245 from 20 : (i35) -> i1
      %304 = comb.icmp ne %247, %c-1_i4 : i4
      %305 = comb.and %303, %304 : i1
      %306 = comb.extract %245 from 21 : (i35) -> i1
      %307 = comb.icmp ne %247, %c-1_i4 : i4
      %308 = comb.and %306, %307 : i1
      %309 = comb.extract %245 from 22 : (i35) -> i1
      %310 = comb.icmp ne %247, %c-1_i4 : i4
      %311 = comb.and %309, %310 : i1
      %312 = comb.extract %245 from 23 : (i35) -> i1
      %313 = comb.icmp ne %247, %c-1_i4 : i4
      %314 = comb.and %312, %313 : i1
      %315 = comb.extract %245 from 24 : (i35) -> i1
      %316 = comb.icmp ne %247, %c-1_i4 : i4
      %317 = comb.and %315, %316 : i1
      %318 = comb.extract %245 from 25 : (i35) -> i1
      %319 = comb.icmp ne %247, %c-1_i4 : i4
      %320 = comb.and %318, %319 : i1
      %321 = comb.extract %245 from 26 : (i35) -> i1
      %322 = comb.icmp ne %247, %c-1_i4 : i4
      %323 = comb.and %321, %322 : i1
      %324 = comb.extract %245 from 27 : (i35) -> i1
      %325 = comb.icmp ne %247, %c-1_i4 : i4
      %326 = comb.and %324, %325 : i1
      %327 = comb.extract %245 from 28 : (i35) -> i1
      %328 = comb.icmp ne %247, %c-1_i4 : i4
      %329 = comb.and %327, %328 : i1
      %330 = comb.extract %245 from 29 : (i35) -> i1
      %331 = comb.icmp ne %247, %c-1_i4 : i4
      %332 = comb.and %330, %331 : i1
      %333 = comb.extract %245 from 30 : (i35) -> i1
      %334 = comb.icmp ne %247, %c-1_i4 : i4
      %335 = comb.and %333, %334 : i1
      %336 = comb.extract %245 from 31 : (i35) -> i1
      %337 = comb.icmp ne %247, %c-1_i4 : i4
      %338 = comb.and %336, %337 : i1
      %339 = comb.extract %245 from 32 : (i35) -> i1
      %340 = comb.icmp ne %247, %c-1_i4 : i4
      %341 = comb.and %339, %340 : i1
      %342 = comb.extract %245 from 33 : (i35) -> i1
      %343 = comb.icmp ne %247, %c-1_i4 : i4
      %344 = comb.and %342, %343 : i1
      %345 = comb.extract %245 from 34 : (i35) -> i1
      %346 = comb.icmp ne %247, %c-1_i4 : i4
      %347 = comb.and %345, %346 : i1
      %348 = comb.or %251, %254, %256, %258, %260, %262, %264, %267, %270, %273, %276, %279, %282, %285, %288, %290, %293, %296, %299, %302, %305, %308, %311, %314, %317, %320, %323, %326, %329, %332, %335, %338, %341, %344, %347 : i1
      %349 = comb.and %244, %348 : i1
      llhd.drv %wr_err, %349 after %1 : i1
      llhd.wait (%6, %117, %122, %79 : i1, i35, i4, i1), ^bb1
    }
    %123 = comb.extract %117 from 0 : (i35) -> i1
    %124 = comb.xor %80, %true : i1
    %125 = comb.and %123, %6, %124 : i1
    llhd.drv %alert_test_we, %125 after %1 : i1
    %126 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "transition_cmd_wd"} : (i32) -> i1
    %127 = comb.extract %u_reg_if.wdata_o from 1 {sv.namehint = "alert_test_fatal_state_error_wd"} : (i32) -> i1
    %128 = comb.extract %u_reg_if.wdata_o from 2 {sv.namehint = "alert_test_fatal_bus_integ_error_wd"} : (i32) -> i1
    %129 = comb.extract %117 from 1 : (i35) -> i1
    %130 = comb.and %129, %u_reg_if.re_o, %124 {sv.namehint = "status_re"} : i1
    %131 = comb.extract %117 from 2 : (i35) -> i1
    %132 = comb.and %131, %6, %124 : i1
    llhd.drv %claim_transition_if_regwen_we, %132 after %1 : i1
    %133 = comb.extract %117 from 3 : (i35) -> i1
    %134 = comb.and %133, %u_reg_if.re_o, %124 {sv.namehint = "claim_transition_if_re"} : i1
    %135 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "claim_transition_if_wd"} : (i32) -> i8
    %136 = comb.extract %117 from 4 : (i35) -> i1
    %137 = comb.and %136, %u_reg_if.re_o, %124 {sv.namehint = "transition_regwen_re"} : i1
    %138 = comb.extract %117 from 5 : (i35) -> i1
    %139 = comb.extract %117 from 6 : (i35) -> i1
    %140 = comb.and %139, %u_reg_if.re_o, %124 {sv.namehint = "transition_ctrl_re"} : i1
    %141 = comb.extract %117 from 7 : (i35) -> i1
    %142 = comb.and %141, %u_reg_if.re_o, %124 {sv.namehint = "transition_token_0_re"} : i1
    %143 = comb.extract %117 from 8 : (i35) -> i1
    %144 = comb.and %143, %u_reg_if.re_o, %124 {sv.namehint = "transition_token_1_re"} : i1
    %145 = comb.extract %117 from 9 : (i35) -> i1
    %146 = comb.and %145, %u_reg_if.re_o, %124 {sv.namehint = "transition_token_2_re"} : i1
    %147 = comb.extract %117 from 10 : (i35) -> i1
    %148 = comb.and %147, %u_reg_if.re_o, %124 {sv.namehint = "transition_token_3_re"} : i1
    %149 = comb.extract %117 from 11 : (i35) -> i1
    %150 = comb.and %149, %u_reg_if.re_o, %124 {sv.namehint = "transition_target_re"} : i1
    %151 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "transition_target_wd"} : (i32) -> i30
    %152 = comb.extract %117 from 12 : (i35) -> i1
    %153 = comb.and %152, %u_reg_if.re_o, %124 {sv.namehint = "otp_vendor_test_ctrl_re"} : i1
    %154 = comb.extract %117 from 13 : (i35) -> i1
    %155 = comb.and %154, %u_reg_if.re_o, %124 {sv.namehint = "otp_vendor_test_status_re"} : i1
    %156 = comb.extract %117 from 14 : (i35) -> i1
    %157 = comb.and %156, %u_reg_if.re_o, %124 {sv.namehint = "lc_state_re"} : i1
    %158 = comb.extract %117 from 15 : (i35) -> i1
    %159 = comb.and %158, %u_reg_if.re_o, %124 {sv.namehint = "lc_transition_cnt_re"} : i1
    %160 = comb.extract %117 from 16 : (i35) -> i1
    %161 = comb.and %160, %u_reg_if.re_o, %124 {sv.namehint = "lc_id_state_re"} : i1
    %162 = comb.extract %117 from 17 : (i35) -> i1
    %163 = comb.and %162, %u_reg_if.re_o, %124 {sv.namehint = "hw_revision0_re"} : i1
    %164 = comb.extract %117 from 18 : (i35) -> i1
    %165 = comb.and %164, %u_reg_if.re_o, %124 {sv.namehint = "hw_revision1_re"} : i1
    %166 = comb.extract %117 from 19 : (i35) -> i1
    %167 = comb.and %166, %u_reg_if.re_o, %124 {sv.namehint = "device_id_0_re"} : i1
    %168 = comb.extract %117 from 20 : (i35) -> i1
    %169 = comb.and %168, %u_reg_if.re_o, %124 {sv.namehint = "device_id_1_re"} : i1
    %170 = comb.extract %117 from 21 : (i35) -> i1
    %171 = comb.and %170, %u_reg_if.re_o, %124 {sv.namehint = "device_id_2_re"} : i1
    %172 = comb.extract %117 from 22 : (i35) -> i1
    %173 = comb.and %172, %u_reg_if.re_o, %124 {sv.namehint = "device_id_3_re"} : i1
    %174 = comb.extract %117 from 23 : (i35) -> i1
    %175 = comb.and %174, %u_reg_if.re_o, %124 {sv.namehint = "device_id_4_re"} : i1
    %176 = comb.extract %117 from 24 : (i35) -> i1
    %177 = comb.and %176, %u_reg_if.re_o, %124 {sv.namehint = "device_id_5_re"} : i1
    %178 = comb.extract %117 from 25 : (i35) -> i1
    %179 = comb.and %178, %u_reg_if.re_o, %124 {sv.namehint = "device_id_6_re"} : i1
    %180 = comb.extract %117 from 26 : (i35) -> i1
    %181 = comb.and %180, %u_reg_if.re_o, %124 {sv.namehint = "device_id_7_re"} : i1
    %182 = comb.extract %117 from 27 : (i35) -> i1
    %183 = comb.and %182, %u_reg_if.re_o, %124 {sv.namehint = "manuf_state_0_re"} : i1
    %184 = comb.extract %117 from 28 : (i35) -> i1
    %185 = comb.and %184, %u_reg_if.re_o, %124 {sv.namehint = "manuf_state_1_re"} : i1
    %186 = comb.extract %117 from 29 : (i35) -> i1
    %187 = comb.and %186, %u_reg_if.re_o, %124 {sv.namehint = "manuf_state_2_re"} : i1
    %188 = comb.extract %117 from 30 : (i35) -> i1
    %189 = comb.and %188, %u_reg_if.re_o, %124 {sv.namehint = "manuf_state_3_re"} : i1
    %190 = comb.extract %117 from 31 : (i35) -> i1
    %191 = comb.and %190, %u_reg_if.re_o, %124 {sv.namehint = "manuf_state_4_re"} : i1
    %192 = comb.extract %117 from 32 : (i35) -> i1
    %193 = comb.and %192, %u_reg_if.re_o, %124 {sv.namehint = "manuf_state_5_re"} : i1
    %194 = comb.extract %117 from 33 : (i35) -> i1
    %195 = comb.and %194, %u_reg_if.re_o, %124 {sv.namehint = "manuf_state_6_re"} : i1
    %196 = comb.extract %117 from 34 : (i35) -> i1
    %197 = comb.and %196, %u_reg_if.re_o, %124 {sv.namehint = "manuf_state_7_re"} : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %244 = llhd.sig.extract %reg_we_check from %c0_i6 : <i35> -> <i1>
      %245 = llhd.prb %alert_test_we : i1
      llhd.drv %244, %245 after %1 : i1
      %246 = llhd.sig.extract %reg_we_check from %c1_i6 : <i35> -> <i1>
      llhd.drv %246, %false after %1 : i1
      %247 = llhd.sig.extract %reg_we_check from %c2_i6 : <i35> -> <i1>
      %248 = llhd.prb %claim_transition_if_regwen_we : i1
      llhd.drv %247, %248 after %1 : i1
      %249 = llhd.sig.extract %reg_we_check from %c3_i6 : <i35> -> <i1>
      %250 = llhd.prb %claim_transition_if_gated_we : i1
      llhd.drv %249, %250 after %1 : i1
      %251 = llhd.sig.extract %reg_we_check from %c4_i6 : <i35> -> <i1>
      llhd.drv %251, %false after %1 : i1
      %252 = llhd.sig.extract %reg_we_check from %c5_i6 : <i35> -> <i1>
      %253 = llhd.prb %transition_cmd_gated_we : i1
      llhd.drv %252, %253 after %1 : i1
      %254 = llhd.sig.extract %reg_we_check from %c6_i6 : <i35> -> <i1>
      %255 = llhd.prb %transition_ctrl_gated_we : i1
      llhd.drv %254, %255 after %1 : i1
      %256 = llhd.sig.extract %reg_we_check from %c7_i6 : <i35> -> <i1>
      %257 = llhd.prb %transition_token_0_gated_we : i1
      llhd.drv %256, %257 after %1 : i1
      %258 = llhd.sig.extract %reg_we_check from %c8_i6 : <i35> -> <i1>
      %259 = llhd.prb %transition_token_1_gated_we : i1
      llhd.drv %258, %259 after %1 : i1
      %260 = llhd.sig.extract %reg_we_check from %c9_i6 : <i35> -> <i1>
      %261 = llhd.prb %transition_token_2_gated_we : i1
      llhd.drv %260, %261 after %1 : i1
      %262 = llhd.sig.extract %reg_we_check from %c10_i6 : <i35> -> <i1>
      %263 = llhd.prb %transition_token_3_gated_we : i1
      llhd.drv %262, %263 after %1 : i1
      %264 = llhd.sig.extract %reg_we_check from %c11_i6 : <i35> -> <i1>
      %265 = llhd.prb %transition_target_gated_we : i1
      llhd.drv %264, %265 after %1 : i1
      %266 = llhd.sig.extract %reg_we_check from %c12_i6 : <i35> -> <i1>
      %267 = llhd.prb %otp_vendor_test_ctrl_gated_we : i1
      llhd.drv %266, %267 after %1 : i1
      %268 = llhd.sig.extract %reg_we_check from %c13_i6 : <i35> -> <i1>
      llhd.drv %268, %false after %1 : i1
      %269 = llhd.sig.extract %reg_we_check from %c14_i6 : <i35> -> <i1>
      llhd.drv %269, %false after %1 : i1
      %270 = llhd.sig.extract %reg_we_check from %c15_i6 : <i35> -> <i1>
      llhd.drv %270, %false after %1 : i1
      %271 = llhd.sig.extract %reg_we_check from %c16_i6 : <i35> -> <i1>
      llhd.drv %271, %false after %1 : i1
      %272 = llhd.sig.extract %reg_we_check from %c17_i6 : <i35> -> <i1>
      llhd.drv %272, %false after %1 : i1
      %273 = llhd.sig.extract %reg_we_check from %c18_i6 : <i35> -> <i1>
      llhd.drv %273, %false after %1 : i1
      %274 = llhd.sig.extract %reg_we_check from %c19_i6 : <i35> -> <i1>
      llhd.drv %274, %false after %1 : i1
      %275 = llhd.sig.extract %reg_we_check from %c20_i6 : <i35> -> <i1>
      llhd.drv %275, %false after %1 : i1
      %276 = llhd.sig.extract %reg_we_check from %c21_i6 : <i35> -> <i1>
      llhd.drv %276, %false after %1 : i1
      %277 = llhd.sig.extract %reg_we_check from %c22_i6 : <i35> -> <i1>
      llhd.drv %277, %false after %1 : i1
      %278 = llhd.sig.extract %reg_we_check from %c23_i6 : <i35> -> <i1>
      llhd.drv %278, %false after %1 : i1
      %279 = llhd.sig.extract %reg_we_check from %c24_i6 : <i35> -> <i1>
      llhd.drv %279, %false after %1 : i1
      %280 = llhd.sig.extract %reg_we_check from %c25_i6 : <i35> -> <i1>
      llhd.drv %280, %false after %1 : i1
      %281 = llhd.sig.extract %reg_we_check from %c26_i6 : <i35> -> <i1>
      llhd.drv %281, %false after %1 : i1
      %282 = llhd.sig.extract %reg_we_check from %c27_i6 : <i35> -> <i1>
      llhd.drv %282, %false after %1 : i1
      %283 = llhd.sig.extract %reg_we_check from %c28_i6 : <i35> -> <i1>
      llhd.drv %283, %false after %1 : i1
      %284 = llhd.sig.extract %reg_we_check from %c29_i6 : <i35> -> <i1>
      llhd.drv %284, %false after %1 : i1
      %285 = llhd.sig.extract %reg_we_check from %c30_i6 : <i35> -> <i1>
      llhd.drv %285, %false after %1 : i1
      %286 = llhd.sig.extract %reg_we_check from %c31_i6 : <i35> -> <i1>
      llhd.drv %286, %false after %1 : i1
      %287 = llhd.sig.extract %reg_we_check from %c-32_i6 : <i35> -> <i1>
      llhd.drv %287, %false after %1 : i1
      %288 = llhd.sig.extract %reg_we_check from %c-31_i6 : <i35> -> <i1>
      llhd.drv %288, %false after %1 : i1
      %289 = llhd.sig.extract %reg_we_check from %c-30_i6 : <i35> -> <i1>
      llhd.drv %289, %false after %1 : i1
      llhd.wait (%5, %9, %20, %21, %24, %27, %35, %40, %44, %48, %52, %55 : i35, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    %198 = llhd.prb %status_initialized_qs : i1
    %199 = llhd.prb %status_ready_qs : i1
    %200 = llhd.prb %status_ext_clock_switched_qs : i1
    %201 = llhd.prb %status_transition_successful_qs : i1
    %202 = llhd.prb %status_transition_count_error_qs : i1
    %203 = llhd.prb %status_transition_error_qs : i1
    %204 = llhd.prb %status_token_error_qs : i1
    %205 = llhd.prb %status_nvm_rma_error_qs : i1
    %206 = llhd.prb %status_otp_error_qs : i1
    %207 = llhd.prb %status_state_error_qs : i1
    %208 = llhd.prb %status_bus_integ_error_qs : i1
    %209 = llhd.prb %status_otp_partition_error_qs : i1
    %210 = llhd.prb %claim_transition_if_qs : i8
    %211 = llhd.prb %transition_ctrl_ext_clock_en_qs : i1
    %212 = llhd.prb %transition_ctrl_volatile_raw_unlock_qs : i1
    %213 = llhd.prb %transition_token_0_qs : i32
    %214 = llhd.prb %transition_token_1_qs : i32
    %215 = llhd.prb %transition_token_2_qs : i32
    %216 = llhd.prb %transition_token_3_qs : i32
    %217 = llhd.prb %transition_target_qs : i30
    %218 = llhd.prb %otp_vendor_test_ctrl_qs : i32
    %219 = llhd.prb %otp_vendor_test_status_qs : i32
    %220 = llhd.prb %lc_state_qs : i30
    %221 = llhd.prb %lc_transition_cnt_qs : i5
    %222 = llhd.prb %lc_id_state_qs : i32
    %223 = llhd.prb %hw_revision0_product_id_qs : i16
    %224 = llhd.prb %hw_revision0_silicon_creator_id_qs : i16
    %225 = llhd.prb %hw_revision1_revision_id_qs : i8
    %226 = llhd.prb %hw_revision1_reserved_qs : i24
    %227 = llhd.prb %device_id_0_qs : i32
    %228 = llhd.prb %device_id_1_qs : i32
    %229 = llhd.prb %device_id_2_qs : i32
    %230 = llhd.prb %device_id_3_qs : i32
    %231 = llhd.prb %device_id_4_qs : i32
    %232 = llhd.prb %device_id_5_qs : i32
    %233 = llhd.prb %device_id_6_qs : i32
    %234 = llhd.prb %device_id_7_qs : i32
    %235 = llhd.prb %manuf_state_0_qs : i32
    %236 = llhd.prb %manuf_state_1_qs : i32
    %237 = llhd.prb %manuf_state_2_qs : i32
    %238 = llhd.prb %manuf_state_3_qs : i32
    %239 = llhd.prb %manuf_state_4_qs : i32
    %240 = llhd.prb %manuf_state_5_qs : i32
    %241 = llhd.prb %manuf_state_6_qs : i32
    %242 = llhd.prb %manuf_state_7_qs : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb72
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      %244 = llhd.prb %addr_hit : i35
      %245 = comb.extract %244 from 0 : (i35) -> i1
      %246 = comb.icmp ceq %245, %true : i1
      cf.cond_br %246, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %247 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      llhd.drv %247, %false after %1 : i1
      %248 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      llhd.drv %248, %false after %1 : i1
      %249 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      llhd.drv %249, %false after %1 : i1
      cf.br ^bb72
    ^bb3:  // pred: ^bb1
      %250 = llhd.prb %addr_hit : i35
      %251 = comb.extract %250 from 1 : (i35) -> i1
      %252 = comb.icmp ceq %251, %true : i1
      cf.cond_br %252, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %253 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %254 = llhd.prb %status_initialized_qs : i1
      llhd.drv %253, %254 after %1 : i1
      %255 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %256 = llhd.prb %status_ready_qs : i1
      llhd.drv %255, %256 after %1 : i1
      %257 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %258 = llhd.prb %status_ext_clock_switched_qs : i1
      llhd.drv %257, %258 after %1 : i1
      %259 = llhd.sig.extract %reg_rdata_next from %c3_i5 : <i32> -> <i1>
      %260 = llhd.prb %status_transition_successful_qs : i1
      llhd.drv %259, %260 after %1 : i1
      %261 = llhd.sig.extract %reg_rdata_next from %c4_i5 : <i32> -> <i1>
      %262 = llhd.prb %status_transition_count_error_qs : i1
      llhd.drv %261, %262 after %1 : i1
      %263 = llhd.sig.extract %reg_rdata_next from %c5_i5 : <i32> -> <i1>
      %264 = llhd.prb %status_transition_error_qs : i1
      llhd.drv %263, %264 after %1 : i1
      %265 = llhd.sig.extract %reg_rdata_next from %c6_i5 : <i32> -> <i1>
      %266 = llhd.prb %status_token_error_qs : i1
      llhd.drv %265, %266 after %1 : i1
      %267 = llhd.sig.extract %reg_rdata_next from %c7_i5 : <i32> -> <i1>
      %268 = llhd.prb %status_nvm_rma_error_qs : i1
      llhd.drv %267, %268 after %1 : i1
      %269 = llhd.sig.extract %reg_rdata_next from %c8_i5 : <i32> -> <i1>
      %270 = llhd.prb %status_otp_error_qs : i1
      llhd.drv %269, %270 after %1 : i1
      %271 = llhd.sig.extract %reg_rdata_next from %c9_i5 : <i32> -> <i1>
      %272 = llhd.prb %status_state_error_qs : i1
      llhd.drv %271, %272 after %1 : i1
      %273 = llhd.sig.extract %reg_rdata_next from %c10_i5 : <i32> -> <i1>
      %274 = llhd.prb %status_bus_integ_error_qs : i1
      llhd.drv %273, %274 after %1 : i1
      %275 = llhd.sig.extract %reg_rdata_next from %c11_i5 : <i32> -> <i1>
      %276 = llhd.prb %status_otp_partition_error_qs : i1
      llhd.drv %275, %276 after %1 : i1
      cf.br ^bb72
    ^bb5:  // pred: ^bb3
      %277 = llhd.prb %addr_hit : i35
      %278 = comb.extract %277 from 2 : (i35) -> i1
      %279 = comb.icmp ceq %278, %true : i1
      cf.cond_br %279, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %280 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %281 = llhd.prb %claim_transition_if_regwen_qs : i1
      llhd.drv %280, %281 after %1 : i1
      cf.br ^bb72
    ^bb7:  // pred: ^bb5
      %282 = llhd.prb %addr_hit : i35
      %283 = comb.extract %282 from 3 : (i35) -> i1
      %284 = comb.icmp ceq %283, %true : i1
      cf.cond_br %284, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %285 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i8>
      %286 = llhd.prb %claim_transition_if_qs : i8
      llhd.drv %285, %286 after %1 : i8
      cf.br ^bb72
    ^bb9:  // pred: ^bb7
      %287 = llhd.prb %addr_hit : i35
      %288 = comb.extract %287 from 4 : (i35) -> i1
      %289 = comb.icmp ceq %288, %true : i1
      cf.cond_br %289, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %290 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %291 = llhd.prb %transition_regwen_qs : i1
      llhd.drv %290, %291 after %1 : i1
      cf.br ^bb72
    ^bb11:  // pred: ^bb9
      %292 = llhd.prb %addr_hit : i35
      %293 = comb.extract %292 from 5 : (i35) -> i1
      %294 = comb.icmp ceq %293, %true : i1
      cf.cond_br %294, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %295 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      llhd.drv %295, %false after %1 : i1
      cf.br ^bb72
    ^bb13:  // pred: ^bb11
      %296 = llhd.prb %addr_hit : i35
      %297 = comb.extract %296 from 6 : (i35) -> i1
      %298 = comb.icmp ceq %297, %true : i1
      cf.cond_br %298, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %299 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %300 = llhd.prb %transition_ctrl_ext_clock_en_qs : i1
      llhd.drv %299, %300 after %1 : i1
      %301 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %302 = llhd.prb %transition_ctrl_volatile_raw_unlock_qs : i1
      llhd.drv %301, %302 after %1 : i1
      cf.br ^bb72
    ^bb15:  // pred: ^bb13
      %303 = llhd.prb %addr_hit : i35
      %304 = comb.extract %303 from 7 : (i35) -> i1
      %305 = comb.icmp ceq %304, %true : i1
      cf.cond_br %305, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      %306 = llhd.prb %transition_token_0_qs : i32
      llhd.drv %reg_rdata_next, %306 after %1 : i32
      cf.br ^bb72
    ^bb17:  // pred: ^bb15
      %307 = llhd.prb %addr_hit : i35
      %308 = comb.extract %307 from 8 : (i35) -> i1
      %309 = comb.icmp ceq %308, %true : i1
      cf.cond_br %309, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      %310 = llhd.prb %transition_token_1_qs : i32
      llhd.drv %reg_rdata_next, %310 after %1 : i32
      cf.br ^bb72
    ^bb19:  // pred: ^bb17
      %311 = llhd.prb %addr_hit : i35
      %312 = comb.extract %311 from 9 : (i35) -> i1
      %313 = comb.icmp ceq %312, %true : i1
      cf.cond_br %313, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      %314 = llhd.prb %transition_token_2_qs : i32
      llhd.drv %reg_rdata_next, %314 after %1 : i32
      cf.br ^bb72
    ^bb21:  // pred: ^bb19
      %315 = llhd.prb %addr_hit : i35
      %316 = comb.extract %315 from 10 : (i35) -> i1
      %317 = comb.icmp ceq %316, %true : i1
      cf.cond_br %317, ^bb22, ^bb23
    ^bb22:  // pred: ^bb21
      %318 = llhd.prb %transition_token_3_qs : i32
      llhd.drv %reg_rdata_next, %318 after %1 : i32
      cf.br ^bb72
    ^bb23:  // pred: ^bb21
      %319 = llhd.prb %addr_hit : i35
      %320 = comb.extract %319 from 11 : (i35) -> i1
      %321 = comb.icmp ceq %320, %true : i1
      cf.cond_br %321, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      %322 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i30>
      %323 = llhd.prb %transition_target_qs : i30
      llhd.drv %322, %323 after %1 : i30
      cf.br ^bb72
    ^bb25:  // pred: ^bb23
      %324 = llhd.prb %addr_hit : i35
      %325 = comb.extract %324 from 12 : (i35) -> i1
      %326 = comb.icmp ceq %325, %true : i1
      cf.cond_br %326, ^bb26, ^bb27
    ^bb26:  // pred: ^bb25
      %327 = llhd.prb %otp_vendor_test_ctrl_qs : i32
      llhd.drv %reg_rdata_next, %327 after %1 : i32
      cf.br ^bb72
    ^bb27:  // pred: ^bb25
      %328 = llhd.prb %addr_hit : i35
      %329 = comb.extract %328 from 13 : (i35) -> i1
      %330 = comb.icmp ceq %329, %true : i1
      cf.cond_br %330, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      %331 = llhd.prb %otp_vendor_test_status_qs : i32
      llhd.drv %reg_rdata_next, %331 after %1 : i32
      cf.br ^bb72
    ^bb29:  // pred: ^bb27
      %332 = llhd.prb %addr_hit : i35
      %333 = comb.extract %332 from 14 : (i35) -> i1
      %334 = comb.icmp ceq %333, %true : i1
      cf.cond_br %334, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      %335 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i30>
      %336 = llhd.prb %lc_state_qs : i30
      llhd.drv %335, %336 after %1 : i30
      cf.br ^bb72
    ^bb31:  // pred: ^bb29
      %337 = llhd.prb %addr_hit : i35
      %338 = comb.extract %337 from 15 : (i35) -> i1
      %339 = comb.icmp ceq %338, %true : i1
      cf.cond_br %339, ^bb32, ^bb33
    ^bb32:  // pred: ^bb31
      %340 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i5>
      %341 = llhd.prb %lc_transition_cnt_qs : i5
      llhd.drv %340, %341 after %1 : i5
      cf.br ^bb72
    ^bb33:  // pred: ^bb31
      %342 = llhd.prb %addr_hit : i35
      %343 = comb.extract %342 from 16 : (i35) -> i1
      %344 = comb.icmp ceq %343, %true : i1
      cf.cond_br %344, ^bb34, ^bb35
    ^bb34:  // pred: ^bb33
      %345 = llhd.prb %lc_id_state_qs : i32
      llhd.drv %reg_rdata_next, %345 after %1 : i32
      cf.br ^bb72
    ^bb35:  // pred: ^bb33
      %346 = llhd.prb %addr_hit : i35
      %347 = comb.extract %346 from 17 : (i35) -> i1
      %348 = comb.icmp ceq %347, %true : i1
      cf.cond_br %348, ^bb36, ^bb37
    ^bb36:  // pred: ^bb35
      %349 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i16>
      %350 = llhd.prb %hw_revision0_product_id_qs : i16
      llhd.drv %349, %350 after %1 : i16
      %351 = llhd.sig.extract %reg_rdata_next from %c-16_i5 : <i32> -> <i16>
      %352 = llhd.prb %hw_revision0_silicon_creator_id_qs : i16
      llhd.drv %351, %352 after %1 : i16
      cf.br ^bb72
    ^bb37:  // pred: ^bb35
      %353 = llhd.prb %addr_hit : i35
      %354 = comb.extract %353 from 18 : (i35) -> i1
      %355 = comb.icmp ceq %354, %true : i1
      cf.cond_br %355, ^bb38, ^bb39
    ^bb38:  // pred: ^bb37
      %356 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i8>
      %357 = llhd.prb %hw_revision1_revision_id_qs : i8
      llhd.drv %356, %357 after %1 : i8
      %358 = llhd.sig.extract %reg_rdata_next from %c8_i5 : <i32> -> <i24>
      %359 = llhd.prb %hw_revision1_reserved_qs : i24
      llhd.drv %358, %359 after %1 : i24
      cf.br ^bb72
    ^bb39:  // pred: ^bb37
      %360 = llhd.prb %addr_hit : i35
      %361 = comb.extract %360 from 19 : (i35) -> i1
      %362 = comb.icmp ceq %361, %true : i1
      cf.cond_br %362, ^bb40, ^bb41
    ^bb40:  // pred: ^bb39
      %363 = llhd.prb %device_id_0_qs : i32
      llhd.drv %reg_rdata_next, %363 after %1 : i32
      cf.br ^bb72
    ^bb41:  // pred: ^bb39
      %364 = llhd.prb %addr_hit : i35
      %365 = comb.extract %364 from 20 : (i35) -> i1
      %366 = comb.icmp ceq %365, %true : i1
      cf.cond_br %366, ^bb42, ^bb43
    ^bb42:  // pred: ^bb41
      %367 = llhd.prb %device_id_1_qs : i32
      llhd.drv %reg_rdata_next, %367 after %1 : i32
      cf.br ^bb72
    ^bb43:  // pred: ^bb41
      %368 = llhd.prb %addr_hit : i35
      %369 = comb.extract %368 from 21 : (i35) -> i1
      %370 = comb.icmp ceq %369, %true : i1
      cf.cond_br %370, ^bb44, ^bb45
    ^bb44:  // pred: ^bb43
      %371 = llhd.prb %device_id_2_qs : i32
      llhd.drv %reg_rdata_next, %371 after %1 : i32
      cf.br ^bb72
    ^bb45:  // pred: ^bb43
      %372 = llhd.prb %addr_hit : i35
      %373 = comb.extract %372 from 22 : (i35) -> i1
      %374 = comb.icmp ceq %373, %true : i1
      cf.cond_br %374, ^bb46, ^bb47
    ^bb46:  // pred: ^bb45
      %375 = llhd.prb %device_id_3_qs : i32
      llhd.drv %reg_rdata_next, %375 after %1 : i32
      cf.br ^bb72
    ^bb47:  // pred: ^bb45
      %376 = llhd.prb %addr_hit : i35
      %377 = comb.extract %376 from 23 : (i35) -> i1
      %378 = comb.icmp ceq %377, %true : i1
      cf.cond_br %378, ^bb48, ^bb49
    ^bb48:  // pred: ^bb47
      %379 = llhd.prb %device_id_4_qs : i32
      llhd.drv %reg_rdata_next, %379 after %1 : i32
      cf.br ^bb72
    ^bb49:  // pred: ^bb47
      %380 = llhd.prb %addr_hit : i35
      %381 = comb.extract %380 from 24 : (i35) -> i1
      %382 = comb.icmp ceq %381, %true : i1
      cf.cond_br %382, ^bb50, ^bb51
    ^bb50:  // pred: ^bb49
      %383 = llhd.prb %device_id_5_qs : i32
      llhd.drv %reg_rdata_next, %383 after %1 : i32
      cf.br ^bb72
    ^bb51:  // pred: ^bb49
      %384 = llhd.prb %addr_hit : i35
      %385 = comb.extract %384 from 25 : (i35) -> i1
      %386 = comb.icmp ceq %385, %true : i1
      cf.cond_br %386, ^bb52, ^bb53
    ^bb52:  // pred: ^bb51
      %387 = llhd.prb %device_id_6_qs : i32
      llhd.drv %reg_rdata_next, %387 after %1 : i32
      cf.br ^bb72
    ^bb53:  // pred: ^bb51
      %388 = llhd.prb %addr_hit : i35
      %389 = comb.extract %388 from 26 : (i35) -> i1
      %390 = comb.icmp ceq %389, %true : i1
      cf.cond_br %390, ^bb54, ^bb55
    ^bb54:  // pred: ^bb53
      %391 = llhd.prb %device_id_7_qs : i32
      llhd.drv %reg_rdata_next, %391 after %1 : i32
      cf.br ^bb72
    ^bb55:  // pred: ^bb53
      %392 = llhd.prb %addr_hit : i35
      %393 = comb.extract %392 from 27 : (i35) -> i1
      %394 = comb.icmp ceq %393, %true : i1
      cf.cond_br %394, ^bb56, ^bb57
    ^bb56:  // pred: ^bb55
      %395 = llhd.prb %manuf_state_0_qs : i32
      llhd.drv %reg_rdata_next, %395 after %1 : i32
      cf.br ^bb72
    ^bb57:  // pred: ^bb55
      %396 = llhd.prb %addr_hit : i35
      %397 = comb.extract %396 from 28 : (i35) -> i1
      %398 = comb.icmp ceq %397, %true : i1
      cf.cond_br %398, ^bb58, ^bb59
    ^bb58:  // pred: ^bb57
      %399 = llhd.prb %manuf_state_1_qs : i32
      llhd.drv %reg_rdata_next, %399 after %1 : i32
      cf.br ^bb72
    ^bb59:  // pred: ^bb57
      %400 = llhd.prb %addr_hit : i35
      %401 = comb.extract %400 from 29 : (i35) -> i1
      %402 = comb.icmp ceq %401, %true : i1
      cf.cond_br %402, ^bb60, ^bb61
    ^bb60:  // pred: ^bb59
      %403 = llhd.prb %manuf_state_2_qs : i32
      llhd.drv %reg_rdata_next, %403 after %1 : i32
      cf.br ^bb72
    ^bb61:  // pred: ^bb59
      %404 = llhd.prb %addr_hit : i35
      %405 = comb.extract %404 from 30 : (i35) -> i1
      %406 = comb.icmp ceq %405, %true : i1
      cf.cond_br %406, ^bb62, ^bb63
    ^bb62:  // pred: ^bb61
      %407 = llhd.prb %manuf_state_3_qs : i32
      llhd.drv %reg_rdata_next, %407 after %1 : i32
      cf.br ^bb72
    ^bb63:  // pred: ^bb61
      %408 = llhd.prb %addr_hit : i35
      %409 = comb.extract %408 from 31 : (i35) -> i1
      %410 = comb.icmp ceq %409, %true : i1
      cf.cond_br %410, ^bb64, ^bb65
    ^bb64:  // pred: ^bb63
      %411 = llhd.prb %manuf_state_4_qs : i32
      llhd.drv %reg_rdata_next, %411 after %1 : i32
      cf.br ^bb72
    ^bb65:  // pred: ^bb63
      %412 = llhd.prb %addr_hit : i35
      %413 = comb.extract %412 from 32 : (i35) -> i1
      %414 = comb.icmp ceq %413, %true : i1
      cf.cond_br %414, ^bb66, ^bb67
    ^bb66:  // pred: ^bb65
      %415 = llhd.prb %manuf_state_5_qs : i32
      llhd.drv %reg_rdata_next, %415 after %1 : i32
      cf.br ^bb72
    ^bb67:  // pred: ^bb65
      %416 = llhd.prb %addr_hit : i35
      %417 = comb.extract %416 from 33 : (i35) -> i1
      %418 = comb.icmp ceq %417, %true : i1
      cf.cond_br %418, ^bb68, ^bb69
    ^bb68:  // pred: ^bb67
      %419 = llhd.prb %manuf_state_6_qs : i32
      llhd.drv %reg_rdata_next, %419 after %1 : i32
      cf.br ^bb72
    ^bb69:  // pred: ^bb67
      %420 = llhd.prb %addr_hit : i35
      %421 = comb.extract %420 from 34 : (i35) -> i1
      %422 = comb.icmp ceq %421, %true : i1
      cf.cond_br %422, ^bb70, ^bb71
    ^bb70:  // pred: ^bb69
      %423 = llhd.prb %manuf_state_7_qs : i32
      llhd.drv %reg_rdata_next, %423 after %1 : i32
      cf.br ^bb72
    ^bb71:  // pred: ^bb69
      llhd.drv %reg_rdata_next, %c-1_i32 after %1 : i32
      cf.br ^bb72
    ^bb72:  // 36 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb18, ^bb20, ^bb22, ^bb24, ^bb26, ^bb28, ^bb30, ^bb32, ^bb34, ^bb36, ^bb38, ^bb40, ^bb42, ^bb44, ^bb46, ^bb48, ^bb50, ^bb52, ^bb54, ^bb56, ^bb58, ^bb60, ^bb62, ^bb64, ^bb66, ^bb68, ^bb70, ^bb71
      llhd.wait (%78, %117, %198, %199, %200, %201, %202, %203, %204, %205, %206, %207, %208, %209, %87, %210, %91, %211, %212, %213, %214, %215, %216, %217, %218, %219, %220, %221, %222, %223, %224, %225, %226, %227, %228, %229, %230, %231, %232, %233, %234, %235, %236, %237, %238, %239, %240, %241, %242 : i32, i35, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i8, i1, i1, i1, i32, i32, i32, i32, i30, i32, i32, i30, i5, i32, i16, i16, i8, i24, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32), ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    %243 = llhd.prb %reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
    hw.output %u_rsp_intg_gen.tl_o, %243, %77 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>, i1
  }
  hw.module private @lc_ctrl_signal_decode(in %clk_i : i1, in %rst_ni : i1, in %lc_state_valid_i : i1, in %lc_state_i : i320, in %fsm_state_i : i16, in %secrets_valid_i : i4, out lc_raw_test_rma_o : i4, out lc_init_done_o : i4, out lc_dft_en_o : i4, out lc_nvm_debug_en_o : i4, out lc_hw_debug_clr_o : i4, out lc_hw_debug_en_o : i4, out lc_cpu_en_o : i4, out lc_creator_seed_sw_rw_en_o : i4, out lc_owner_seed_sw_rw_en_o : i4, out lc_iso_part_sw_rd_en_o : i4, out lc_iso_part_sw_wr_en_o : i4, out lc_seed_hw_rd_en_o : i4, out lc_rma_state_o : i4, out lc_keymgr_en_o : i4, out lc_escalate_en_o : i4, out lc_keymgr_div_o : i128) {
    %c-1_i4 = hw.constant -1 : i4
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %c0_i16 = hw.constant 0 : i16
    %c12620_i16 = hw.constant 12620 : i16
    %c-16997_i16 = hw.constant -16997 : i16
    %c-22447_i16 = hw.constant -22447 : i16
    %c27948_i16 = hw.constant 27948 : i16
    %c4_i128 = hw.constant 4 : i128
    %c-54303400873254211277939491738915568855517463684010673349609841479124041226336157744059344899238_i320 = hw.constant -54303400873254211277939491738915568855517463684010673349609841479124041226336157744059344899238 : i320
    %c2_i128 = hw.constant 2 : i128
    %c-456496308219428725067595699288731687292043479658042179497285099403199829975739052578789756128422_i320 = hw.constant -456496308219428725067595699288731687292043479658042179497285099403199829975739052578789756128422 : i320
    %c3_i128 = hw.constant 3 : i128
    %c-456496308202635263122743346900974421756237933645613458509347227096541837787826188153527211019430_i320 = hw.constant -456496308202635263122743346900974421756237933645613458509347227096541837787826188153527211019430 : i320
    %c-456496308219426320068298084851192228873599800621203464587165662212848069748932106232039927073958_i320 = hw.constant -456496308219426320068298084851192228873599800621203464587165662212848069748932106232039927073958 : i320
    %c-456496308219428725069991543908571176442958431069049577004747167567363169282951950587742548544678_i320 = hw.constant -456496308219428725069991543908571176442958431069049577004747167567363169282951950587742548544678 : i320
    %c1_i128 = hw.constant 1 : i128
    %c-456496308219428725069992223747441649870271937183805899370984814561761337221678801031624232160422_i320 = hw.constant -456496308219428725069992223747441649870271937183805899370984814561761337221678801031624232160422 : i320
    %c-456496308219428725069992223747441655294669495732793985256939044880764090660545683627503784971430_i320 = hw.constant -456496308219428725069992223747441655294669495732793985256939044880764090660545683627503784971430 : i320
    %c-456496308219428725069992223747441655294669496142203554028875401662036066712056987236735610932390_i320 = hw.constant -456496308219428725069992223747441655294669496142203554028875401662036066712056987236735610932390 : i320
    %c-456496308219428725069992223747441655294669496142203568053958862625652945713376621513158249303206_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958862625652945713376621513158249303206 : i320
    %c-456496308219428725069992223747441655294669496142203568053958864591903156752666814128945401580710_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958864591903156752666814128945401580710 : i320
    %c-456496308219428725069992223747441655294669496142203568053958864591903157416196240118574526385318_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958864591903157416196240118574526385318 : i320
    %c-456496308219428725069992223747441655294669496142203568053958864591903157416196240123047907839142_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958864591903157416196240123047907839142 : i320
    %c-456496308219428725069992223730586335313491493392502011291754234001596928066027634096378592775334_i320 = hw.constant -456496308219428725069992223730586335313491493392502011291754234001596928066027634096378592775334 : i320
    %c-456496308219428725069992223747441655293687836557898079325106876213185120734113905048550051302566_i320 = hw.constant -456496308219428725069992223747441655293687836557898079325106876213185120734113905048550051302566 : i320
    %c-456496308219428725069992223747441655294669496142014443709591861977795843821104929131164897004710_i320 = hw.constant -456496308219428725069992223747441655294669496142014443709591861977795843821104929131164897004710 : i320
    %c-456496308219428725069992223747441655294669496142203568053953436675435776818504807144494214302886_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053953436675435776818504807144494214302886 : i320
    %c-456496308219428725069992223747441655294669496142203568053958864591858254829874687572138464791718_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958864591858254829874687572138464791718 : i320
    %c-456496308219428725069992223747441655294669496142203568053958864591903157416196198460277973208230_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958864591903157416196198460277973208230 : i320
    %c-456496308219428725069992223747441655294669496142203568053958864591903157416196240123045587340454_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958864591903157416196240123045587340454 : i320
    %c0_i320 = hw.constant 0 : i320
    %c5_i4 = hw.constant 5 : i4
    %c-32341_i16 = hw.constant -32341 : i16
    %c-10897_i16 = hw.constant -10897 : i16
    %c8384_i16 = hw.constant 8384 : i16
    %c-11713_i16 = hw.constant -11713 : i16
    %c-6001_i16 = hw.constant -6001 : i16
    %c28336_i16 = hw.constant 28336 : i16
    %c3156_i16 = hw.constant 3156 : i16
    %c13255_i16 = hw.constant 13255 : i16
    %c-12599_i16 = hw.constant -12599 : i16
    %c1965_i16 = hw.constant 1965 : i16
    %c-2372_i16 = hw.constant -2372 : i16
    %c0_i128 = hw.constant 0 : i128
    %c-6_i4 = hw.constant -6 : i4
    %false = hw.constant false
    %lc_state_valid_i_0 = llhd.sig name "lc_state_valid_i" %false : i1
    %lc_state_i_1 = llhd.sig name "lc_state_i" %c0_i320 : i320
    %fsm_state_i_2 = llhd.sig name "fsm_state_i" %c0_i16 : i16
    %secrets_valid_i_3 = llhd.sig name "secrets_valid_i" %c0_i4 : i4
    %lc_escalate_en_o = llhd.sig %c0_i4 : i4
    %lc_init_done = llhd.sig %c0_i4 : i4
    %lc_raw_test_rma = llhd.sig %c0_i4 : i4
    %lc_dft_en = llhd.sig %c0_i4 : i4
    %lc_nvm_debug_en = llhd.sig %c0_i4 : i4
    %lc_hw_debug_clr = llhd.sig %c0_i4 : i4
    %lc_hw_debug_en = llhd.sig %c0_i4 : i4
    %lc_cpu_en = llhd.sig %c0_i4 : i4
    %lc_keymgr_en = llhd.sig %c0_i4 : i4
    %lc_escalate_en = llhd.sig %c0_i4 : i4
    %lc_creator_seed_sw_rw_en = llhd.sig %c0_i4 : i4
    %lc_owner_seed_sw_rw_en = llhd.sig %c0_i4 : i4
    %lc_iso_part_sw_rd_en = llhd.sig %c0_i4 : i4
    %lc_iso_part_sw_wr_en = llhd.sig %c0_i4 : i4
    %lc_seed_hw_rd_en = llhd.sig %c0_i4 : i4
    %lc_rma_state = llhd.sig %c0_i4 : i4
    %lc_keymgr_div_d = llhd.sig %c0_i128 : i128
    %1 = llhd.prb %lc_init_done : i4
    %u_prim_lc_sender_init_done.lc_en_o = hw.instance "u_prim_lc_sender_init_done" @prim_lc_sender(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, lc_en_i: %1: i4) -> (lc_en_o: i4)
    %2 = llhd.prb %lc_raw_test_rma : i4
    %u_prim_lc_sender_raw_test_rma.lc_en_o = hw.instance "u_prim_lc_sender_raw_test_rma" @prim_lc_sender(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, lc_en_i: %2: i4) -> (lc_en_o: i4)
    %3 = llhd.prb %lc_dft_en : i4
    %u_prim_lc_sender_dft_en.lc_en_o = hw.instance "u_prim_lc_sender_dft_en" @prim_lc_sender(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, lc_en_i: %3: i4) -> (lc_en_o: i4)
    %4 = llhd.prb %lc_nvm_debug_en : i4
    %u_prim_lc_sender_nvm_debug_en.lc_en_o = hw.instance "u_prim_lc_sender_nvm_debug_en" @prim_lc_sender(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, lc_en_i: %4: i4) -> (lc_en_o: i4)
    %5 = llhd.prb %lc_hw_debug_clr : i4
    %u_prim_lc_sender_hw_debug_clr.lc_en_o = hw.instance "u_prim_lc_sender_hw_debug_clr" @prim_lc_sender(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, lc_en_i: %5: i4) -> (lc_en_o: i4)
    %6 = llhd.prb %lc_hw_debug_en : i4
    %u_prim_lc_sender_hw_debug_en.lc_en_o = hw.instance "u_prim_lc_sender_hw_debug_en" @prim_lc_sender(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, lc_en_i: %6: i4) -> (lc_en_o: i4)
    %7 = llhd.prb %lc_cpu_en : i4
    %u_prim_lc_sender_cpu_en.lc_en_o = hw.instance "u_prim_lc_sender_cpu_en" @prim_lc_sender(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, lc_en_i: %7: i4) -> (lc_en_o: i4)
    %8 = llhd.prb %lc_creator_seed_sw_rw_en : i4
    %u_prim_lc_sender_creator_seed_sw_rw_en.lc_en_o = hw.instance "u_prim_lc_sender_creator_seed_sw_rw_en" @prim_lc_sender(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, lc_en_i: %8: i4) -> (lc_en_o: i4)
    %9 = llhd.prb %lc_owner_seed_sw_rw_en : i4
    %u_prim_lc_sender_owner_seed_sw_rw_en.lc_en_o = hw.instance "u_prim_lc_sender_owner_seed_sw_rw_en" @prim_lc_sender(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, lc_en_i: %9: i4) -> (lc_en_o: i4)
    %10 = llhd.prb %lc_iso_part_sw_rd_en : i4
    %u_prim_lc_sender_iso_part_sw_rd_en.lc_en_o = hw.instance "u_prim_lc_sender_iso_part_sw_rd_en" @prim_lc_sender(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, lc_en_i: %10: i4) -> (lc_en_o: i4)
    %11 = llhd.prb %lc_iso_part_sw_wr_en : i4
    %u_prim_lc_sender_iso_part_sw_wr_en.lc_en_o = hw.instance "u_prim_lc_sender_iso_part_sw_wr_en" @prim_lc_sender(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, lc_en_i: %11: i4) -> (lc_en_o: i4)
    %12 = llhd.prb %lc_seed_hw_rd_en : i4
    %u_prim_lc_sender_seed_hw_rd_en.lc_en_o = hw.instance "u_prim_lc_sender_seed_hw_rd_en" @prim_lc_sender(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, lc_en_i: %12: i4) -> (lc_en_o: i4)
    %13 = llhd.prb %lc_rma_state : i4
    %u_prim_lc_sender_rma_state.lc_en_o = hw.instance "u_prim_lc_sender_rma_state" @prim_lc_sender(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, lc_en_i: %13: i4) -> (lc_en_o: i4)
    %14 = llhd.prb %lc_keymgr_en : i4
    %u_prim_lc_sender_keymgr_en.lc_en_o = hw.instance "u_prim_lc_sender_keymgr_en" @prim_lc_sender(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, lc_en_i: %14: i4) -> (lc_en_o: i4)
    %15 = llhd.prb %lc_escalate_en : i4
    %u_prim_lc_sender_escalate_en.lc_en_o = hw.instance "u_prim_lc_sender_escalate_en" @prim_lc_sender(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, lc_en_i: %15: i4) -> (lc_en_o: i4)
    llhd.drv %lc_escalate_en_o, %u_prim_lc_sender_escalate_en.lc_en_o after %0 : i4
    %16 = llhd.prb %lc_keymgr_div_d : i128
    %u_prim_flop_keymgr_div.q_o = hw.instance "u_prim_flop_keymgr_div" @prim_flop_29(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %16: i128) -> (q_o: i128) {sv.namehint = "lc_keymgr_div_q"}
    %17 = llhd.prb %lc_escalate_en_o : i4
    %18 = llhd.prb %fsm_state_i_2 : i16
    %19 = llhd.prb %lc_state_valid_i_0 : i1
    %20 = llhd.prb %lc_state_i_1 : i320
    %21 = llhd.prb %secrets_valid_i_3 : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb48
      llhd.drv %lc_init_done, %c-6_i4 after %0 : i4
      llhd.drv %lc_raw_test_rma, %c-6_i4 after %0 : i4
      llhd.drv %lc_dft_en, %c-6_i4 after %0 : i4
      llhd.drv %lc_nvm_debug_en, %c-6_i4 after %0 : i4
      llhd.drv %lc_hw_debug_clr, %c-6_i4 after %0 : i4
      llhd.drv %lc_hw_debug_en, %c-6_i4 after %0 : i4
      llhd.drv %lc_cpu_en, %c-6_i4 after %0 : i4
      llhd.drv %lc_creator_seed_sw_rw_en, %c-6_i4 after %0 : i4
      llhd.drv %lc_owner_seed_sw_rw_en, %c-6_i4 after %0 : i4
      llhd.drv %lc_iso_part_sw_rd_en, %c-6_i4 after %0 : i4
      llhd.drv %lc_iso_part_sw_wr_en, %c-6_i4 after %0 : i4
      llhd.drv %lc_seed_hw_rd_en, %c-6_i4 after %0 : i4
      llhd.drv %lc_rma_state, %c-6_i4 after %0 : i4
      llhd.drv %lc_keymgr_en, %c-6_i4 after %0 : i4
      %22 = llhd.prb %lc_escalate_en_o : i4
      %23 = func.call @"lc_ctrl_pkg::lc_tx_or_hi"(%c-6_i4, %22) : (i4, i4) -> i4
      llhd.drv %lc_escalate_en, %23 after %0 : i4
      llhd.drv %lc_keymgr_div_d, %c0_i128 after %0 : i128
      %24 = llhd.prb %fsm_state_i_2 : i16
      %25 = comb.icmp ceq %24, %c-2372_i16 : i16
      cf.cond_br %25, ^bb48, ^bb2
    ^bb2:  // pred: ^bb1
      %26 = comb.icmp ceq %24, %c1965_i16 : i16
      cf.cond_br %26, ^bb12, ^bb3
    ^bb3:  // pred: ^bb2
      %27 = comb.icmp ceq %24, %c-12599_i16 : i16
      cf.cond_br %27, ^bb12, ^bb4
    ^bb4:  // pred: ^bb3
      %28 = comb.icmp ceq %24, %c13255_i16 : i16
      cf.cond_br %28, ^bb12, ^bb5
    ^bb5:  // pred: ^bb4
      %29 = comb.icmp ceq %24, %c3156_i16 : i16
      cf.cond_br %29, ^bb12, ^bb6
    ^bb6:  // pred: ^bb5
      %30 = comb.icmp ceq %24, %c28336_i16 : i16
      cf.cond_br %30, ^bb12, ^bb7
    ^bb7:  // pred: ^bb6
      %31 = comb.icmp ceq %24, %c-6001_i16 : i16
      cf.cond_br %31, ^bb12, ^bb8
    ^bb8:  // pred: ^bb7
      %32 = comb.icmp ceq %24, %c-11713_i16 : i16
      cf.cond_br %32, ^bb12, ^bb9
    ^bb9:  // pred: ^bb8
      %33 = comb.icmp ceq %24, %c8384_i16 : i16
      cf.cond_br %33, ^bb12, ^bb10
    ^bb10:  // pred: ^bb9
      %34 = comb.icmp ceq %24, %c-10897_i16 : i16
      cf.cond_br %34, ^bb12, ^bb11
    ^bb11:  // pred: ^bb10
      %35 = comb.icmp ceq %24, %c-32341_i16 : i16
      cf.cond_br %35, ^bb12, ^bb41
    ^bb12:  // 10 preds: ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7, ^bb8, ^bb9, ^bb10, ^bb11
      %36 = llhd.prb %lc_state_valid_i_0 : i1
      cf.cond_br %36, ^bb13, ^bb40
    ^bb13:  // pred: ^bb12
      llhd.drv %lc_init_done, %c5_i4 after %0 : i4
      %37 = llhd.prb %lc_state_i_1 : i320
      %38 = comb.icmp ceq %37, %c0_i320 : i320
      cf.cond_br %38, ^bb21, ^bb14
    ^bb14:  // pred: ^bb13
      %39 = comb.icmp ceq %37, %c-456496308219428725069992223747441655294669496142203568053958864591903157416196240123045587340454_i320 : i320
      cf.cond_br %39, ^bb21, ^bb15
    ^bb15:  // pred: ^bb14
      %40 = comb.icmp ceq %37, %c-456496308219428725069992223747441655294669496142203568053958864591903157416196198460277973208230_i320 : i320
      cf.cond_br %40, ^bb21, ^bb16
    ^bb16:  // pred: ^bb15
      %41 = comb.icmp ceq %37, %c-456496308219428725069992223747441655294669496142203568053958864591858254829874687572138464791718_i320 : i320
      cf.cond_br %41, ^bb21, ^bb17
    ^bb17:  // pred: ^bb16
      %42 = comb.icmp ceq %37, %c-456496308219428725069992223747441655294669496142203568053953436675435776818504807144494214302886_i320 : i320
      cf.cond_br %42, ^bb21, ^bb18
    ^bb18:  // pred: ^bb17
      %43 = comb.icmp ceq %37, %c-456496308219428725069992223747441655294669496142014443709591861977795843821104929131164897004710_i320 : i320
      cf.cond_br %43, ^bb21, ^bb19
    ^bb19:  // pred: ^bb18
      %44 = comb.icmp ceq %37, %c-456496308219428725069992223747441655293687836557898079325106876213185120734113905048550051302566_i320 : i320
      cf.cond_br %44, ^bb21, ^bb20
    ^bb20:  // pred: ^bb19
      %45 = comb.icmp ceq %37, %c-456496308219428725069992223730586335313491493392502011291754234001596928066027634096378592775334_i320 : i320
      cf.cond_br %45, ^bb21, ^bb22
    ^bb21:  // 8 preds: ^bb13, ^bb14, ^bb15, ^bb16, ^bb17, ^bb18, ^bb19, ^bb20
      llhd.drv %lc_raw_test_rma, %c5_i4 after %0 : i4
      cf.br ^bb48
    ^bb22:  // pred: ^bb20
      %46 = comb.icmp ceq %37, %c-456496308219428725069992223747441655294669496142203568053958864591903157416196240123047907839142_i320 : i320
      cf.cond_br %46, ^bb29, ^bb23
    ^bb23:  // pred: ^bb22
      %47 = comb.icmp ceq %37, %c-456496308219428725069992223747441655294669496142203568053958864591903157416196240118574526385318_i320 : i320
      cf.cond_br %47, ^bb29, ^bb24
    ^bb24:  // pred: ^bb23
      %48 = comb.icmp ceq %37, %c-456496308219428725069992223747441655294669496142203568053958864591903156752666814128945401580710_i320 : i320
      cf.cond_br %48, ^bb29, ^bb25
    ^bb25:  // pred: ^bb24
      %49 = comb.icmp ceq %37, %c-456496308219428725069992223747441655294669496142203568053958862625652945713376621513158249303206_i320 : i320
      cf.cond_br %49, ^bb29, ^bb26
    ^bb26:  // pred: ^bb25
      %50 = comb.icmp ceq %37, %c-456496308219428725069992223747441655294669496142203554028875401662036066712056987236735610932390_i320 : i320
      cf.cond_br %50, ^bb29, ^bb27
    ^bb27:  // pred: ^bb26
      %51 = comb.icmp ceq %37, %c-456496308219428725069992223747441655294669495732793985256939044880764090660545683627503784971430_i320 : i320
      cf.cond_br %51, ^bb29, ^bb28
    ^bb28:  // pred: ^bb27
      %52 = comb.icmp ceq %37, %c-456496308219428725069992223747441649870271937183805899370984814561761337221678801031624232160422_i320 : i320
      cf.cond_br %52, ^bb29, ^bb30
    ^bb29:  // 7 preds: ^bb22, ^bb23, ^bb24, ^bb25, ^bb26, ^bb27, ^bb28
      llhd.drv %lc_raw_test_rma, %c5_i4 after %0 : i4
      llhd.drv %lc_dft_en, %c5_i4 after %0 : i4
      llhd.drv %lc_nvm_debug_en, %c5_i4 after %0 : i4
      llhd.drv %lc_hw_debug_en, %c5_i4 after %0 : i4
      llhd.drv %lc_cpu_en, %c5_i4 after %0 : i4
      llhd.drv %lc_iso_part_sw_wr_en, %c5_i4 after %0 : i4
      llhd.drv %lc_keymgr_div_d, %c1_i128 after %0 : i128
      cf.br ^bb48
    ^bb30:  // pred: ^bb28
      %53 = comb.icmp ceq %37, %c-456496308219428725069991543908571176442958431069049577004747167567363169282951950587742548544678_i320 : i320
      cf.cond_br %53, ^bb31, ^bb32
    ^bb31:  // pred: ^bb30
      llhd.drv %lc_raw_test_rma, %c5_i4 after %0 : i4
      llhd.drv %lc_dft_en, %c5_i4 after %0 : i4
      llhd.drv %lc_hw_debug_en, %c5_i4 after %0 : i4
      llhd.drv %lc_cpu_en, %c5_i4 after %0 : i4
      llhd.drv %lc_iso_part_sw_wr_en, %c5_i4 after %0 : i4
      llhd.drv %lc_keymgr_div_d, %c1_i128 after %0 : i128
      cf.br ^bb48
    ^bb32:  // pred: ^bb30
      %54 = comb.icmp ceq %37, %c-456496308219426320068298084851192228873599800621203464587165662212848069748932106232039927073958_i320 : i320
      cf.cond_br %54, ^bb34, ^bb33
    ^bb33:  // pred: ^bb32
      %55 = comb.icmp ceq %37, %c-456496308202635263122743346900974421756237933645613458509347227096541837787826188153527211019430_i320 : i320
      cf.cond_br %55, ^bb34, ^bb35
    ^bb34:  // 2 preds: ^bb32, ^bb33
      llhd.drv %lc_cpu_en, %c5_i4 after %0 : i4
      llhd.drv %lc_keymgr_en, %c5_i4 after %0 : i4
      llhd.drv %lc_owner_seed_sw_rw_en, %c5_i4 after %0 : i4
      llhd.drv %lc_iso_part_sw_wr_en, %c5_i4 after %0 : i4
      llhd.drv %lc_iso_part_sw_rd_en, %c5_i4 after %0 : i4
      llhd.drv %lc_keymgr_div_d, %c3_i128 after %0 : i128
      %56 = llhd.prb %secrets_valid_i_3 : i4
      %57 = comb.xor %56, %c-1_i4 : i4
      llhd.drv %lc_creator_seed_sw_rw_en, %57 after %0 : i4
      %58 = llhd.prb %secrets_valid_i_3 : i4
      llhd.drv %lc_seed_hw_rd_en, %58 after %0 : i4
      cf.br ^bb48
    ^bb35:  // pred: ^bb33
      %59 = comb.icmp ceq %37, %c-456496308219428725067595699288731687292043479658042179497285099403199829975739052578789756128422_i320 : i320
      cf.cond_br %59, ^bb36, ^bb37
    ^bb36:  // pred: ^bb35
      llhd.drv %lc_hw_debug_en, %c5_i4 after %0 : i4
      llhd.drv %lc_cpu_en, %c5_i4 after %0 : i4
      llhd.drv %lc_keymgr_en, %c5_i4 after %0 : i4
      llhd.drv %lc_owner_seed_sw_rw_en, %c5_i4 after %0 : i4
      llhd.drv %lc_iso_part_sw_wr_en, %c5_i4 after %0 : i4
      llhd.drv %lc_keymgr_div_d, %c2_i128 after %0 : i128
      %60 = llhd.prb %secrets_valid_i_3 : i4
      %61 = comb.xor %60, %c-1_i4 : i4
      llhd.drv %lc_creator_seed_sw_rw_en, %61 after %0 : i4
      %62 = llhd.prb %secrets_valid_i_3 : i4
      llhd.drv %lc_seed_hw_rd_en, %62 after %0 : i4
      cf.br ^bb48
    ^bb37:  // pred: ^bb35
      %63 = comb.icmp ceq %37, %c-54303400873254211277939491738915568855517463684010673349609841479124041226336157744059344899238_i320 : i320
      cf.cond_br %63, ^bb38, ^bb39
    ^bb38:  // pred: ^bb37
      llhd.drv %lc_raw_test_rma, %c5_i4 after %0 : i4
      llhd.drv %lc_dft_en, %c5_i4 after %0 : i4
      llhd.drv %lc_nvm_debug_en, %c5_i4 after %0 : i4
      llhd.drv %lc_hw_debug_en, %c5_i4 after %0 : i4
      llhd.drv %lc_cpu_en, %c5_i4 after %0 : i4
      llhd.drv %lc_keymgr_en, %c5_i4 after %0 : i4
      llhd.drv %lc_creator_seed_sw_rw_en, %c5_i4 after %0 : i4
      llhd.drv %lc_owner_seed_sw_rw_en, %c5_i4 after %0 : i4
      llhd.drv %lc_iso_part_sw_wr_en, %c5_i4 after %0 : i4
      llhd.drv %lc_iso_part_sw_rd_en, %c5_i4 after %0 : i4
      llhd.drv %lc_seed_hw_rd_en, %c5_i4 after %0 : i4
      llhd.drv %lc_rma_state, %c5_i4 after %0 : i4
      llhd.drv %lc_keymgr_div_d, %c4_i128 after %0 : i128
      cf.br ^bb48
    ^bb39:  // pred: ^bb37
      llhd.drv %lc_escalate_en, %c5_i4 after %0 : i4
      llhd.drv %lc_hw_debug_clr, %c5_i4 after %0 : i4
      cf.br ^bb48
    ^bb40:  // pred: ^bb12
      llhd.drv %lc_escalate_en, %c5_i4 after %0 : i4
      llhd.drv %lc_hw_debug_clr, %c5_i4 after %0 : i4
      cf.br ^bb48
    ^bb41:  // pred: ^bb11
      %64 = comb.icmp ceq %24, %c27948_i16 : i16
      cf.cond_br %64, ^bb42, ^bb43
    ^bb42:  // pred: ^bb41
      llhd.drv %lc_init_done, %c5_i4 after %0 : i4
      llhd.drv %lc_hw_debug_clr, %c5_i4 after %0 : i4
      cf.br ^bb48
    ^bb43:  // pred: ^bb41
      %65 = comb.icmp ceq %24, %c-22447_i16 : i16
      cf.cond_br %65, ^bb46, ^bb44
    ^bb44:  // pred: ^bb43
      %66 = comb.icmp ceq %24, %c-16997_i16 : i16
      cf.cond_br %66, ^bb46, ^bb45
    ^bb45:  // pred: ^bb44
      %67 = comb.icmp ceq %24, %c12620_i16 : i16
      cf.cond_br %67, ^bb46, ^bb47
    ^bb46:  // 3 preds: ^bb43, ^bb44, ^bb45
      llhd.drv %lc_init_done, %c5_i4 after %0 : i4
      llhd.drv %lc_escalate_en, %c5_i4 after %0 : i4
      llhd.drv %lc_hw_debug_clr, %c5_i4 after %0 : i4
      cf.br ^bb48
    ^bb47:  // pred: ^bb45
      llhd.drv %lc_escalate_en, %c5_i4 after %0 : i4
      llhd.drv %lc_hw_debug_clr, %c5_i4 after %0 : i4
      cf.br ^bb48
    ^bb48:  // 12 preds: ^bb1, ^bb21, ^bb29, ^bb31, ^bb34, ^bb36, ^bb38, ^bb39, ^bb40, ^bb42, ^bb46, ^bb47
      llhd.wait (%1, %2, %3, %4, %5, %6, %7, %8, %9, %10, %11, %12, %13, %14, %17, %15, %16, %18, %19, %20, %21 : i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i128, i16, i1, i320, i4), ^bb1
    }
    llhd.drv %lc_state_valid_i_0, %lc_state_valid_i after %0 : i1
    llhd.drv %lc_state_i_1, %lc_state_i after %0 : i320
    llhd.drv %fsm_state_i_2, %fsm_state_i after %0 : i16
    llhd.drv %secrets_valid_i_3, %secrets_valid_i after %0 : i4
    hw.output %u_prim_lc_sender_raw_test_rma.lc_en_o, %u_prim_lc_sender_init_done.lc_en_o, %u_prim_lc_sender_dft_en.lc_en_o, %u_prim_lc_sender_nvm_debug_en.lc_en_o, %u_prim_lc_sender_hw_debug_clr.lc_en_o, %u_prim_lc_sender_hw_debug_en.lc_en_o, %u_prim_lc_sender_cpu_en.lc_en_o, %u_prim_lc_sender_creator_seed_sw_rw_en.lc_en_o, %u_prim_lc_sender_owner_seed_sw_rw_en.lc_en_o, %u_prim_lc_sender_iso_part_sw_rd_en.lc_en_o, %u_prim_lc_sender_iso_part_sw_wr_en.lc_en_o, %u_prim_lc_sender_seed_hw_rd_en.lc_en_o, %u_prim_lc_sender_rma_state.lc_en_o, %u_prim_lc_sender_keymgr_en.lc_en_o, %17, %u_prim_flop_keymgr_div.q_o : i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i128
  }
  hw.module private @lc_ctrl_state_decode(in %lc_state_valid_i : i1, in %lc_state_i : i320, in %lc_cnt_i : i384, in %secrets_valid_i : i4, in %fsm_state_i : i16, out dec_lc_state_o : !hw.array<6xi5>, out dec_lc_id_state_o : i2, out dec_lc_cnt_o : i5, out state_invalid_error_o : i6) {
    %0 = hw.aggregate_constant [-13 : i5, -13 : i5, -13 : i5, -13 : i5, -13 : i5, -13 : i5] : !hw.array<6xi5>
    %1 = hw.aggregate_constant [-14 : i5, -14 : i5, -14 : i5, -14 : i5, -14 : i5, -14 : i5] : !hw.array<6xi5>
    %2 = hw.aggregate_constant [-15 : i5, -15 : i5, -15 : i5, -15 : i5, -15 : i5, -15 : i5] : !hw.array<6xi5>
    %3 = hw.aggregate_constant [-16 : i5, -16 : i5, -16 : i5, -16 : i5, -16 : i5, -16 : i5] : !hw.array<6xi5>
    %4 = hw.aggregate_constant [15 : i5, 15 : i5, 15 : i5, 15 : i5, 15 : i5, 15 : i5] : !hw.array<6xi5>
    %5 = hw.aggregate_constant [14 : i5, 14 : i5, 14 : i5, 14 : i5, 14 : i5, 14 : i5] : !hw.array<6xi5>
    %6 = hw.aggregate_constant [13 : i5, 13 : i5, 13 : i5, 13 : i5, 13 : i5, 13 : i5] : !hw.array<6xi5>
    %7 = hw.aggregate_constant [12 : i5, 12 : i5, 12 : i5, 12 : i5, 12 : i5, 12 : i5] : !hw.array<6xi5>
    %8 = hw.aggregate_constant [11 : i5, 11 : i5, 11 : i5, 11 : i5, 11 : i5, 11 : i5] : !hw.array<6xi5>
    %9 = hw.aggregate_constant [10 : i5, 10 : i5, 10 : i5, 10 : i5, 10 : i5, 10 : i5] : !hw.array<6xi5>
    %10 = hw.aggregate_constant [9 : i5, 9 : i5, 9 : i5, 9 : i5, 9 : i5, 9 : i5] : !hw.array<6xi5>
    %11 = hw.aggregate_constant [8 : i5, 8 : i5, 8 : i5, 8 : i5, 8 : i5, 8 : i5] : !hw.array<6xi5>
    %12 = hw.aggregate_constant [7 : i5, 7 : i5, 7 : i5, 7 : i5, 7 : i5, 7 : i5] : !hw.array<6xi5>
    %13 = hw.aggregate_constant [6 : i5, 6 : i5, 6 : i5, 6 : i5, 6 : i5, 6 : i5] : !hw.array<6xi5>
    %14 = hw.aggregate_constant [5 : i5, 5 : i5, 5 : i5, 5 : i5, 5 : i5, 5 : i5] : !hw.array<6xi5>
    %15 = hw.aggregate_constant [4 : i5, 4 : i5, 4 : i5, 4 : i5, 4 : i5, 4 : i5] : !hw.array<6xi5>
    %16 = hw.aggregate_constant [3 : i5, 3 : i5, 3 : i5, 3 : i5, 3 : i5, 3 : i5] : !hw.array<6xi5>
    %17 = hw.aggregate_constant [2 : i5, 2 : i5, 2 : i5, 2 : i5, 2 : i5, 2 : i5] : !hw.array<6xi5>
    %18 = hw.aggregate_constant [1 : i5, 1 : i5, 1 : i5, 1 : i5, 1 : i5, 1 : i5] : !hw.array<6xi5>
    %19 = hw.aggregate_constant [-12 : i5, -12 : i5, -12 : i5, -12 : i5, -12 : i5, -12 : i5] : !hw.array<6xi5>
    %20 = hw.aggregate_constant [-11 : i5, -11 : i5, -11 : i5, -11 : i5, -11 : i5, -11 : i5] : !hw.array<6xi5>
    %21 = hw.aggregate_constant [-10 : i5, -10 : i5, -10 : i5, -10 : i5, -10 : i5, -10 : i5] : !hw.array<6xi5>
    %c-1_i5 = hw.constant -1 : i5
    %22 = hw.aggregate_constant [-9 : i5, -9 : i5, -9 : i5, -9 : i5, -9 : i5, -9 : i5] : !hw.array<6xi5>
    %c-3_i3 = hw.constant -3 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c3_i3 = hw.constant 3 : i3
    %c2_i3 = hw.constant 2 : i3
    %c1_i3 = hw.constant 1 : i3
    %23 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i3 = hw.constant 0 : i3
    %24 = hw.aggregate_constant [0 : i5, 0 : i5, 0 : i5, 0 : i5, 0 : i5, 0 : i5] : !hw.array<6xi5>
    %c0_i16 = hw.constant 0 : i16
    %c0_i4 = hw.constant 0 : i4
    %c1_i2 = hw.constant 1 : i2
    %c5_i4 = hw.constant 5 : i4
    %c0_i2 = hw.constant 0 : i2
    %c-6_i4 = hw.constant -6 : i4
    %c-8_i5 = hw.constant -8 : i5
    %c14775406613987005597957056839273030327923486421408010299430716062456368040795107685578447338622277126328287499351035_i384 = hw.constant 14775406613987005597957056839273030327923486421408010299430716062456368040795107685578447338622277126328287499351035 : i384
    %c3064709032606212353072243254821777433402258981373129162371742995319249988652427810561249491444414778128343956943867_i384 = hw.constant 3064709032606212353072243254821777433402258981373129162371742995319249988652427810561249491444414778128343956943867 : i384
    %c3064632631580316491810048475156113130282087166200209988590949048759832331477579550955323062986373573621473449309179_i384 = hw.constant 3064632631580316491810048475156113130282087166200209988590949048759832331477579550955323062986373573621473449309179 : i384
    %c3064632628712743301590528521826787810441800851367590737912711816108190035649874770884973252603418858017168963892219_i384 = hw.constant 3064632628712743301590528521826787810441800851367590737912711816108190035649874770884973252603418858017168963892219 : i384
    %c3064632628712731261031607035656653349704443173602320722467319291656525844176331477032379027132638378579884902413307_i384 = hw.constant 3064632628712731261031607035656653349704443173602320722467319291656525844176331477032379027132638378579884902413307 : i384
    %c3064632628712731260981349284048528908984028081577884544477857463447999865000636619865907731704877335364928122352635_i384 = hw.constant 3064632628712731260981349284048528908984028081577884544477857463447999865000636619865907731704877335364928122352635 : i384
    %c3064632628712731260981348856350545596567515827949151138211934977055710179281599621066887603587709904586225163924475_i384 = hw.constant 3064632628712731260981348856350545596567515827949151138211934977055710179281599621066887603587709904586225163924475 : i384
    %c3064632628712731260981348856085098104965734566618046538599877588952775057289240869295839173538229936240607221478395_i384 = hw.constant 3064632628712731260981348856085098104965734566618046538599877588952775057289240869295839173538229936240607221478395 : i384
    %c3064632628712731260981348856085097786305904985523876732932526845043652645090243069453006936950958746463674452374523_i384 = hw.constant 3064632628712731260981348856085097786305904985523876732932526845043652645090243069453006936950958746463674452374523 : i384
    %c3064632628712731260981348856085097786305747736135111456727193931566086525342334423386185006863685923511759409214459_i384 = hw.constant 3064632628712731260981348856085097786305747736135111456727193931566086525342334423386185006863685923511759409214459 : i384
    %c3064632628712731260981348856085097786305746617566924236647148850831630564897857774181062915655333682522970169242619_i384 = hw.constant 3064632628712731260981348856085097786305746617566924236647148850831630564897857774181062915655333682522970169242619 : i384
    %c3064632628712731260981348856085097786305746617566259041429851753289089418605808965239423644681651307863211494044667_i384 = hw.constant 3064632628712731260981348856085097786305746617566259041429851753289089418605808965239423644681651307863211494044667 : i384
    %c3064632628712731260981348856085097786305746617566258731039725141888499008453693566466734701252379290005632900363259_i384 = hw.constant 3064632628712731260981348856085097786305746617566258731039725141888499008453693566466734701252379290005632900363259 : i384
    %c3064632628712731260981348856085097786305746617566258731034918948529429668639720847999523740969578995604879714513915_i384 = hw.constant 3064632628712731260981348856085097786305746617566258731034918948529429668639720847999523740969578995604879714513915 : i384
    %c3064632628712731260981348856085097786305746617566258731034918946927623874125051249648285164312532806061977647412219_i384 = hw.constant 3064632628712731260981348856085097786305746617566258731034918946927623874125051249648285164312532806061977647412219 : i384
    %c3064632628712731260981348856085097786305746617566258731034918946927484360663089242069911716859019117912396233929723_i384 = hw.constant 3064632628712731260981348856085097786305746617566258731034918946927484360663089242069911716859019117912396233929723 : i384
    %c3064632628712731260981348856085097786305746617566258731034918946927484343173936711801358448695417794349237237937147_i384 = hw.constant 3064632628712731260981348856085097786305746617566258731034918946927484343173936711801358448695417794349237237937147 : i384
    %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198872949949827817808624876317012987_i384 = hw.constant 3064632628712731260981348856085097786305746617566258731034918946927484343173681198872949949827817808624876317012987 : i384
    %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525613685365282952614779638739963_i384 = hw.constant 3064632628712731260981348856085097786305746617566258731034918946927484343173681198525613685365282952614779638739963 : i384
    %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564013021206626731249311380475_i384 = hw.constant 3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564013021206626731249311380475 : i384
    %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673243073319481078779_i384 = hw.constant 3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673243073319481078779 : i384
    %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673237162344970155003_i384 = hw.constant 3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673237162344970155003 : i384
    %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673236985289238344699_i384 = hw.constant 3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673236985289238344699 : i384
    %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673236985287067661307_i384 = hw.constant 3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673236985287067661307 : i384
    %c0_i384 = hw.constant 0 : i384
    %true = hw.constant true
    %c-54303400856460749330691294731318814168796966260574554854209901008302709731210395309844007373990_i320 = hw.constant -54303400856460749330691294731318814168796966260574554854209901008302709731210395309844007373990 : i320
    %c-13_i5 = hw.constant -13 : i5
    %c-54303400873254211277939491738915568855517463684010673349609841479124041226336157744059344899238_i320 = hw.constant -54303400873254211277939491738915568855517463684010673349609841479124041226336157744059344899238 : i320
    %c-14_i5 = hw.constant -14 : i5
    %c-456496308202635263122743346900974421756237933645613458509347227096541837787826188153527211019430_i320 = hw.constant -456496308202635263122743346900974421756237933645613458509347227096541837787826188153527211019430 : i320
    %c-15_i5 = hw.constant -15 : i5
    %c-456496308219426320068298084851192228873599800621203464587165662212848069748932106232039927073958_i320 = hw.constant -456496308219426320068298084851192228873599800621203464587165662212848069748932106232039927073958 : i320
    %c-16_i5 = hw.constant -16 : i5
    %c-456496308219428725067595699288731687292043479658042179497285099403199829975739052578789756128422_i320 = hw.constant -456496308219428725067595699288731687292043479658042179497285099403199829975739052578789756128422 : i320
    %c15_i5 = hw.constant 15 : i5
    %c-456496308219428725069991543908571176442958431069049577004747167567363169282951950587742548544678_i320 = hw.constant -456496308219428725069991543908571176442958431069049577004747167567363169282951950587742548544678 : i320
    %c14_i5 = hw.constant 14 : i5
    %c-456496308219428725069992223730586335313491493392502011291754234001596928066027634096378592775334_i320 = hw.constant -456496308219428725069992223730586335313491493392502011291754234001596928066027634096378592775334 : i320
    %c13_i5 = hw.constant 13 : i5
    %c-456496308219428725069992223747441649870271937183805899370984814561761337221678801031624232160422_i320 = hw.constant -456496308219428725069992223747441649870271937183805899370984814561761337221678801031624232160422 : i320
    %c12_i5 = hw.constant 12 : i5
    %c-456496308219428725069992223747441655293687836557898079325106876213185120734113905048550051302566_i320 = hw.constant -456496308219428725069992223747441655293687836557898079325106876213185120734113905048550051302566 : i320
    %c11_i5 = hw.constant 11 : i5
    %c-456496308219428725069992223747441655294669495732793985256939044880764090660545683627503784971430_i320 = hw.constant -456496308219428725069992223747441655294669495732793985256939044880764090660545683627503784971430 : i320
    %c10_i5 = hw.constant 10 : i5
    %c-456496308219428725069992223747441655294669496142014443709591861977795843821104929131164897004710_i320 = hw.constant -456496308219428725069992223747441655294669496142014443709591861977795843821104929131164897004710 : i320
    %c9_i5 = hw.constant 9 : i5
    %c-456496308219428725069992223747441655294669496142203554028875401662036066712056987236735610932390_i320 = hw.constant -456496308219428725069992223747441655294669496142203554028875401662036066712056987236735610932390 : i320
    %c8_i5 = hw.constant 8 : i5
    %c-456496308219428725069992223747441655294669496142203568053953436675435776818504807144494214302886_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053953436675435776818504807144494214302886 : i320
    %c7_i5 = hw.constant 7 : i5
    %c-456496308219428725069992223747441655294669496142203568053958862625652945713376621513158249303206_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958862625652945713376621513158249303206 : i320
    %c6_i5 = hw.constant 6 : i5
    %c-456496308219428725069992223747441655294669496142203568053958864591858254829874687572138464791718_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958864591858254829874687572138464791718 : i320
    %c5_i5 = hw.constant 5 : i5
    %c-456496308219428725069992223747441655294669496142203568053958864591903156752666814128945401580710_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958864591903156752666814128945401580710 : i320
    %c4_i5 = hw.constant 4 : i5
    %c-456496308219428725069992223747441655294669496142203568053958864591903157416196198460277973208230_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958864591903157416196198460277973208230 : i320
    %c3_i5 = hw.constant 3 : i5
    %c-456496308219428725069992223747441655294669496142203568053958864591903157416196240118574526385318_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958864591903157416196240118574526385318 : i320
    %c2_i5 = hw.constant 2 : i5
    %c-456496308219428725069992223747441655294669496142203568053958864591903157416196240123045587340454_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958864591903157416196240123045587340454 : i320
    %c1_i5 = hw.constant 1 : i5
    %c-456496308219428725069992223747441655294669496142203568053958864591903157416196240123047907839142_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958864591903157416196240123047907839142 : i320
    %c0_i5 = hw.constant 0 : i5
    %c0_i320 = hw.constant 0 : i320
    %c-12_i5 = hw.constant -12 : i5
    %c-22447_i16 = hw.constant -22447 : i16
    %c12620_i16 = hw.constant 12620 : i16
    %c-11_i5 = hw.constant -11 : i5
    %c27948_i16 = hw.constant 27948 : i16
    %c-10_i5 = hw.constant -10 : i5
    %c-16997_i16 = hw.constant -16997 : i16
    %c-2372_i16 = hw.constant -2372 : i16
    %c0_i6 = hw.constant 0 : i6
    %c-2_i2 = hw.constant -2 : i2
    %c-9_i5 = hw.constant -9 : i5
    %false = hw.constant false
    %lc_state_valid_i_0 = llhd.sig name "lc_state_valid_i" %false : i1
    %lc_state_i_1 = llhd.sig name "lc_state_i" %c0_i320 : i320
    %lc_cnt_i_2 = llhd.sig name "lc_cnt_i" %c0_i384 : i384
    %secrets_valid_i_3 = llhd.sig name "secrets_valid_i" %c0_i4 : i4
    %fsm_state_i_4 = llhd.sig name "fsm_state_i" %c0_i16 : i16
    %dec_lc_state_o = llhd.sig %24 : !hw.array<6xi5>
    %dec_lc_id_state_o = llhd.sig %c0_i2 : i2
    %dec_lc_cnt_o = llhd.sig %c0_i5 : i5
    %state_invalid_error_o = llhd.sig %c0_i6 : i6
    %dec_lc_state = llhd.sig %24 : !hw.array<6xi5>
    %25 = llhd.prb %dec_lc_state : !hw.array<6xi5>
    %26 = hw.bitcast %25 : (!hw.array<6xi5>) -> i30
    %u_prim_sec_anchor_buf.out_o = hw.instance "u_prim_sec_anchor_buf" @prim_sec_anchor_buf_28(in_i: %26: i30) -> (out_o: i30) {sv.namehint = "dec_lc_state_buf"}
    %27 = llhd.sig.array_get %dec_lc_state_o[%c0_i3] : <!hw.array<6xi5>>
    %28 = comb.extract %u_prim_sec_anchor_buf.out_o from 0 : (i30) -> i5
    llhd.drv %27, %28 after %23 : i5
    %29 = llhd.sig.array_get %dec_lc_state_o[%c1_i3] : <!hw.array<6xi5>>
    %30 = comb.extract %u_prim_sec_anchor_buf.out_o from 5 : (i30) -> i5
    llhd.drv %29, %30 after %23 : i5
    %31 = llhd.sig.array_get %dec_lc_state_o[%c2_i3] : <!hw.array<6xi5>>
    %32 = comb.extract %u_prim_sec_anchor_buf.out_o from 10 : (i30) -> i5
    llhd.drv %31, %32 after %23 : i5
    %33 = llhd.sig.array_get %dec_lc_state_o[%c3_i3] : <!hw.array<6xi5>>
    %34 = comb.extract %u_prim_sec_anchor_buf.out_o from 15 : (i30) -> i5
    llhd.drv %33, %34 after %23 : i5
    %35 = llhd.sig.array_get %dec_lc_state_o[%c-4_i3] : <!hw.array<6xi5>>
    %36 = comb.extract %u_prim_sec_anchor_buf.out_o from 20 : (i30) -> i5
    llhd.drv %35, %36 after %23 : i5
    %37 = llhd.sig.array_get %dec_lc_state_o[%c-3_i3] : <!hw.array<6xi5>>
    %38 = comb.extract %u_prim_sec_anchor_buf.out_o from 25 : (i30) -> i5
    llhd.drv %37, %38 after %23 : i5
    %39 = llhd.prb %dec_lc_cnt_o : i5
    %40 = llhd.prb %dec_lc_id_state_o : i2
    %41 = llhd.prb %state_invalid_error_o : i6
    %42 = llhd.prb %fsm_state_i_4 : i16
    %43 = llhd.prb %lc_state_valid_i_0 : i1
    %44 = llhd.prb %lc_state_i_1 : i320
    %45 = llhd.prb %lc_cnt_i_2 : i384
    %46 = llhd.prb %secrets_valid_i_3 : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb113
      llhd.drv %dec_lc_state, %22 after %23 : !hw.array<6xi5>
      llhd.drv %dec_lc_cnt_o, %c-1_i5 after %23 : i5
      llhd.drv %dec_lc_id_state_o, %c-2_i2 after %23 : i2
      llhd.drv %state_invalid_error_o, %c0_i6 after %23 : i6
      %48 = llhd.prb %fsm_state_i_4 : i16
      %49 = comb.icmp ceq %48, %c-2372_i16 : i16
      cf.cond_br %49, ^bb113, ^bb2
    ^bb2:  // pred: ^bb1
      %50 = comb.icmp ceq %48, %c-16997_i16 : i16
      cf.cond_br %50, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %dec_lc_state, %21 after %23 : !hw.array<6xi5>
      cf.br ^bb113
    ^bb4:  // pred: ^bb2
      %51 = comb.icmp ceq %48, %c27948_i16 : i16
      cf.cond_br %51, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      llhd.drv %dec_lc_state, %20 after %23 : !hw.array<6xi5>
      cf.br ^bb113
    ^bb6:  // pred: ^bb4
      %52 = comb.icmp ceq %48, %c12620_i16 : i16
      cf.cond_br %52, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      llhd.drv %dec_lc_state, %22 after %23 : !hw.array<6xi5>
      cf.br ^bb113
    ^bb8:  // pred: ^bb6
      %53 = comb.icmp ceq %48, %c-22447_i16 : i16
      cf.cond_br %53, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      llhd.drv %dec_lc_state, %19 after %23 : !hw.array<6xi5>
      cf.br ^bb113
    ^bb10:  // pred: ^bb8
      %54 = llhd.sig.extract %state_invalid_error_o from %c0_i3 : <i6> -> <i1>
      %55 = llhd.prb %lc_state_valid_i_0 : i1
      %56 = comb.xor %55, %true : i1
      llhd.drv %54, %56 after %23 : i1
      %57 = llhd.prb %lc_state_i_1 : i320
      %58 = comb.icmp ceq %57, %c0_i320 : i320
      cf.cond_br %58, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      llhd.drv %dec_lc_state, %24 after %23 : !hw.array<6xi5>
      cf.br ^bb53
    ^bb12:  // pred: ^bb10
      %59 = comb.icmp ceq %57, %c-456496308219428725069992223747441655294669496142203568053958864591903157416196240123047907839142_i320 : i320
      cf.cond_br %59, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      llhd.drv %dec_lc_state, %18 after %23 : !hw.array<6xi5>
      cf.br ^bb53
    ^bb14:  // pred: ^bb12
      %60 = comb.icmp ceq %57, %c-456496308219428725069992223747441655294669496142203568053958864591903157416196240123045587340454_i320 : i320
      cf.cond_br %60, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      llhd.drv %dec_lc_state, %17 after %23 : !hw.array<6xi5>
      cf.br ^bb53
    ^bb16:  // pred: ^bb14
      %61 = comb.icmp ceq %57, %c-456496308219428725069992223747441655294669496142203568053958864591903157416196240118574526385318_i320 : i320
      cf.cond_br %61, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      llhd.drv %dec_lc_state, %16 after %23 : !hw.array<6xi5>
      cf.br ^bb53
    ^bb18:  // pred: ^bb16
      %62 = comb.icmp ceq %57, %c-456496308219428725069992223747441655294669496142203568053958864591903157416196198460277973208230_i320 : i320
      cf.cond_br %62, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      llhd.drv %dec_lc_state, %15 after %23 : !hw.array<6xi5>
      cf.br ^bb53
    ^bb20:  // pred: ^bb18
      %63 = comb.icmp ceq %57, %c-456496308219428725069992223747441655294669496142203568053958864591903156752666814128945401580710_i320 : i320
      cf.cond_br %63, ^bb21, ^bb22
    ^bb21:  // pred: ^bb20
      llhd.drv %dec_lc_state, %14 after %23 : !hw.array<6xi5>
      cf.br ^bb53
    ^bb22:  // pred: ^bb20
      %64 = comb.icmp ceq %57, %c-456496308219428725069992223747441655294669496142203568053958864591858254829874687572138464791718_i320 : i320
      cf.cond_br %64, ^bb23, ^bb24
    ^bb23:  // pred: ^bb22
      llhd.drv %dec_lc_state, %13 after %23 : !hw.array<6xi5>
      cf.br ^bb53
    ^bb24:  // pred: ^bb22
      %65 = comb.icmp ceq %57, %c-456496308219428725069992223747441655294669496142203568053958862625652945713376621513158249303206_i320 : i320
      cf.cond_br %65, ^bb25, ^bb26
    ^bb25:  // pred: ^bb24
      llhd.drv %dec_lc_state, %12 after %23 : !hw.array<6xi5>
      cf.br ^bb53
    ^bb26:  // pred: ^bb24
      %66 = comb.icmp ceq %57, %c-456496308219428725069992223747441655294669496142203568053953436675435776818504807144494214302886_i320 : i320
      cf.cond_br %66, ^bb27, ^bb28
    ^bb27:  // pred: ^bb26
      llhd.drv %dec_lc_state, %11 after %23 : !hw.array<6xi5>
      cf.br ^bb53
    ^bb28:  // pred: ^bb26
      %67 = comb.icmp ceq %57, %c-456496308219428725069992223747441655294669496142203554028875401662036066712056987236735610932390_i320 : i320
      cf.cond_br %67, ^bb29, ^bb30
    ^bb29:  // pred: ^bb28
      llhd.drv %dec_lc_state, %10 after %23 : !hw.array<6xi5>
      cf.br ^bb53
    ^bb30:  // pred: ^bb28
      %68 = comb.icmp ceq %57, %c-456496308219428725069992223747441655294669496142014443709591861977795843821104929131164897004710_i320 : i320
      cf.cond_br %68, ^bb31, ^bb32
    ^bb31:  // pred: ^bb30
      llhd.drv %dec_lc_state, %9 after %23 : !hw.array<6xi5>
      cf.br ^bb53
    ^bb32:  // pred: ^bb30
      %69 = comb.icmp ceq %57, %c-456496308219428725069992223747441655294669495732793985256939044880764090660545683627503784971430_i320 : i320
      cf.cond_br %69, ^bb33, ^bb34
    ^bb33:  // pred: ^bb32
      llhd.drv %dec_lc_state, %8 after %23 : !hw.array<6xi5>
      cf.br ^bb53
    ^bb34:  // pred: ^bb32
      %70 = comb.icmp ceq %57, %c-456496308219428725069992223747441655293687836557898079325106876213185120734113905048550051302566_i320 : i320
      cf.cond_br %70, ^bb35, ^bb36
    ^bb35:  // pred: ^bb34
      llhd.drv %dec_lc_state, %7 after %23 : !hw.array<6xi5>
      cf.br ^bb53
    ^bb36:  // pred: ^bb34
      %71 = comb.icmp ceq %57, %c-456496308219428725069992223747441649870271937183805899370984814561761337221678801031624232160422_i320 : i320
      cf.cond_br %71, ^bb37, ^bb38
    ^bb37:  // pred: ^bb36
      llhd.drv %dec_lc_state, %6 after %23 : !hw.array<6xi5>
      cf.br ^bb53
    ^bb38:  // pred: ^bb36
      %72 = comb.icmp ceq %57, %c-456496308219428725069992223730586335313491493392502011291754234001596928066027634096378592775334_i320 : i320
      cf.cond_br %72, ^bb39, ^bb40
    ^bb39:  // pred: ^bb38
      llhd.drv %dec_lc_state, %5 after %23 : !hw.array<6xi5>
      cf.br ^bb53
    ^bb40:  // pred: ^bb38
      %73 = comb.icmp ceq %57, %c-456496308219428725069991543908571176442958431069049577004747167567363169282951950587742548544678_i320 : i320
      cf.cond_br %73, ^bb41, ^bb42
    ^bb41:  // pred: ^bb40
      llhd.drv %dec_lc_state, %4 after %23 : !hw.array<6xi5>
      cf.br ^bb53
    ^bb42:  // pred: ^bb40
      %74 = comb.icmp ceq %57, %c-456496308219428725067595699288731687292043479658042179497285099403199829975739052578789756128422_i320 : i320
      cf.cond_br %74, ^bb43, ^bb44
    ^bb43:  // pred: ^bb42
      llhd.drv %dec_lc_state, %3 after %23 : !hw.array<6xi5>
      cf.br ^bb53
    ^bb44:  // pred: ^bb42
      %75 = comb.icmp ceq %57, %c-456496308219426320068298084851192228873599800621203464587165662212848069748932106232039927073958_i320 : i320
      cf.cond_br %75, ^bb45, ^bb46
    ^bb45:  // pred: ^bb44
      llhd.drv %dec_lc_state, %2 after %23 : !hw.array<6xi5>
      cf.br ^bb53
    ^bb46:  // pred: ^bb44
      %76 = comb.icmp ceq %57, %c-456496308202635263122743346900974421756237933645613458509347227096541837787826188153527211019430_i320 : i320
      cf.cond_br %76, ^bb47, ^bb48
    ^bb47:  // pred: ^bb46
      llhd.drv %dec_lc_state, %1 after %23 : !hw.array<6xi5>
      cf.br ^bb53
    ^bb48:  // pred: ^bb46
      %77 = comb.icmp ceq %57, %c-54303400873254211277939491738915568855517463684010673349609841479124041226336157744059344899238_i320 : i320
      cf.cond_br %77, ^bb49, ^bb50
    ^bb49:  // pred: ^bb48
      llhd.drv %dec_lc_state, %0 after %23 : !hw.array<6xi5>
      cf.br ^bb53
    ^bb50:  // pred: ^bb48
      %78 = comb.icmp ceq %57, %c-54303400856460749330691294731318814168796966260574554854209901008302709731210395309844007373990_i320 : i320
      cf.cond_br %78, ^bb51, ^bb52
    ^bb51:  // pred: ^bb50
      llhd.drv %dec_lc_state, %19 after %23 : !hw.array<6xi5>
      cf.br ^bb53
    ^bb52:  // pred: ^bb50
      %79 = llhd.sig.extract %state_invalid_error_o from %c1_i3 : <i6> -> <i1>
      llhd.drv %79, %true after %23 : i1
      cf.br ^bb53
    ^bb53:  // 22 preds: ^bb11, ^bb13, ^bb15, ^bb17, ^bb19, ^bb21, ^bb23, ^bb25, ^bb27, ^bb29, ^bb31, ^bb33, ^bb35, ^bb37, ^bb39, ^bb41, ^bb43, ^bb45, ^bb47, ^bb49, ^bb51, ^bb52
      %80 = llhd.prb %lc_cnt_i_2 : i384
      %81 = comb.icmp ceq %80, %c0_i384 : i384
      cf.cond_br %81, ^bb54, ^bb55
    ^bb54:  // pred: ^bb53
      llhd.drv %dec_lc_cnt_o, %c0_i5 after %23 : i5
      cf.br ^bb104
    ^bb55:  // pred: ^bb53
      %82 = comb.icmp ceq %80, %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673236985287067661307_i384 : i384
      cf.cond_br %82, ^bb56, ^bb57
    ^bb56:  // pred: ^bb55
      llhd.drv %dec_lc_cnt_o, %c1_i5 after %23 : i5
      cf.br ^bb104
    ^bb57:  // pred: ^bb55
      %83 = comb.icmp ceq %80, %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673236985289238344699_i384 : i384
      cf.cond_br %83, ^bb58, ^bb59
    ^bb58:  // pred: ^bb57
      llhd.drv %dec_lc_cnt_o, %c2_i5 after %23 : i5
      cf.br ^bb104
    ^bb59:  // pred: ^bb57
      %84 = comb.icmp ceq %80, %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673237162344970155003_i384 : i384
      cf.cond_br %84, ^bb60, ^bb61
    ^bb60:  // pred: ^bb59
      llhd.drv %dec_lc_cnt_o, %c3_i5 after %23 : i5
      cf.br ^bb104
    ^bb61:  // pred: ^bb59
      %85 = comb.icmp ceq %80, %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673243073319481078779_i384 : i384
      cf.cond_br %85, ^bb62, ^bb63
    ^bb62:  // pred: ^bb61
      llhd.drv %dec_lc_cnt_o, %c4_i5 after %23 : i5
      cf.br ^bb104
    ^bb63:  // pred: ^bb61
      %86 = comb.icmp ceq %80, %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564013021206626731249311380475_i384 : i384
      cf.cond_br %86, ^bb64, ^bb65
    ^bb64:  // pred: ^bb63
      llhd.drv %dec_lc_cnt_o, %c5_i5 after %23 : i5
      cf.br ^bb104
    ^bb65:  // pred: ^bb63
      %87 = comb.icmp ceq %80, %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525613685365282952614779638739963_i384 : i384
      cf.cond_br %87, ^bb66, ^bb67
    ^bb66:  // pred: ^bb65
      llhd.drv %dec_lc_cnt_o, %c6_i5 after %23 : i5
      cf.br ^bb104
    ^bb67:  // pred: ^bb65
      %88 = comb.icmp ceq %80, %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198872949949827817808624876317012987_i384 : i384
      cf.cond_br %88, ^bb68, ^bb69
    ^bb68:  // pred: ^bb67
      llhd.drv %dec_lc_cnt_o, %c7_i5 after %23 : i5
      cf.br ^bb104
    ^bb69:  // pred: ^bb67
      %89 = comb.icmp ceq %80, %c3064632628712731260981348856085097786305746617566258731034918946927484343173936711801358448695417794349237237937147_i384 : i384
      cf.cond_br %89, ^bb70, ^bb71
    ^bb70:  // pred: ^bb69
      llhd.drv %dec_lc_cnt_o, %c8_i5 after %23 : i5
      cf.br ^bb104
    ^bb71:  // pred: ^bb69
      %90 = comb.icmp ceq %80, %c3064632628712731260981348856085097786305746617566258731034918946927484360663089242069911716859019117912396233929723_i384 : i384
      cf.cond_br %90, ^bb72, ^bb73
    ^bb72:  // pred: ^bb71
      llhd.drv %dec_lc_cnt_o, %c9_i5 after %23 : i5
      cf.br ^bb104
    ^bb73:  // pred: ^bb71
      %91 = comb.icmp ceq %80, %c3064632628712731260981348856085097786305746617566258731034918946927623874125051249648285164312532806061977647412219_i384 : i384
      cf.cond_br %91, ^bb74, ^bb75
    ^bb74:  // pred: ^bb73
      llhd.drv %dec_lc_cnt_o, %c10_i5 after %23 : i5
      cf.br ^bb104
    ^bb75:  // pred: ^bb73
      %92 = comb.icmp ceq %80, %c3064632628712731260981348856085097786305746617566258731034918948529429668639720847999523740969578995604879714513915_i384 : i384
      cf.cond_br %92, ^bb76, ^bb77
    ^bb76:  // pred: ^bb75
      llhd.drv %dec_lc_cnt_o, %c11_i5 after %23 : i5
      cf.br ^bb104
    ^bb77:  // pred: ^bb75
      %93 = comb.icmp ceq %80, %c3064632628712731260981348856085097786305746617566258731039725141888499008453693566466734701252379290005632900363259_i384 : i384
      cf.cond_br %93, ^bb78, ^bb79
    ^bb78:  // pred: ^bb77
      llhd.drv %dec_lc_cnt_o, %c12_i5 after %23 : i5
      cf.br ^bb104
    ^bb79:  // pred: ^bb77
      %94 = comb.icmp ceq %80, %c3064632628712731260981348856085097786305746617566259041429851753289089418605808965239423644681651307863211494044667_i384 : i384
      cf.cond_br %94, ^bb80, ^bb81
    ^bb80:  // pred: ^bb79
      llhd.drv %dec_lc_cnt_o, %c13_i5 after %23 : i5
      cf.br ^bb104
    ^bb81:  // pred: ^bb79
      %95 = comb.icmp ceq %80, %c3064632628712731260981348856085097786305746617566924236647148850831630564897857774181062915655333682522970169242619_i384 : i384
      cf.cond_br %95, ^bb82, ^bb83
    ^bb82:  // pred: ^bb81
      llhd.drv %dec_lc_cnt_o, %c14_i5 after %23 : i5
      cf.br ^bb104
    ^bb83:  // pred: ^bb81
      %96 = comb.icmp ceq %80, %c3064632628712731260981348856085097786305747736135111456727193931566086525342334423386185006863685923511759409214459_i384 : i384
      cf.cond_br %96, ^bb84, ^bb85
    ^bb84:  // pred: ^bb83
      llhd.drv %dec_lc_cnt_o, %c15_i5 after %23 : i5
      cf.br ^bb104
    ^bb85:  // pred: ^bb83
      %97 = comb.icmp ceq %80, %c3064632628712731260981348856085097786305904985523876732932526845043652645090243069453006936950958746463674452374523_i384 : i384
      cf.cond_br %97, ^bb86, ^bb87
    ^bb86:  // pred: ^bb85
      llhd.drv %dec_lc_cnt_o, %c-16_i5 after %23 : i5
      cf.br ^bb104
    ^bb87:  // pred: ^bb85
      %98 = comb.icmp ceq %80, %c3064632628712731260981348856085098104965734566618046538599877588952775057289240869295839173538229936240607221478395_i384 : i384
      cf.cond_br %98, ^bb88, ^bb89
    ^bb88:  // pred: ^bb87
      llhd.drv %dec_lc_cnt_o, %c-15_i5 after %23 : i5
      cf.br ^bb104
    ^bb89:  // pred: ^bb87
      %99 = comb.icmp ceq %80, %c3064632628712731260981348856350545596567515827949151138211934977055710179281599621066887603587709904586225163924475_i384 : i384
      cf.cond_br %99, ^bb90, ^bb91
    ^bb90:  // pred: ^bb89
      llhd.drv %dec_lc_cnt_o, %c-14_i5 after %23 : i5
      cf.br ^bb104
    ^bb91:  // pred: ^bb89
      %100 = comb.icmp ceq %80, %c3064632628712731260981349284048528908984028081577884544477857463447999865000636619865907731704877335364928122352635_i384 : i384
      cf.cond_br %100, ^bb92, ^bb93
    ^bb92:  // pred: ^bb91
      llhd.drv %dec_lc_cnt_o, %c-13_i5 after %23 : i5
      cf.br ^bb104
    ^bb93:  // pred: ^bb91
      %101 = comb.icmp ceq %80, %c3064632628712731261031607035656653349704443173602320722467319291656525844176331477032379027132638378579884902413307_i384 : i384
      cf.cond_br %101, ^bb94, ^bb95
    ^bb94:  // pred: ^bb93
      llhd.drv %dec_lc_cnt_o, %c-12_i5 after %23 : i5
      cf.br ^bb104
    ^bb95:  // pred: ^bb93
      %102 = comb.icmp ceq %80, %c3064632628712743301590528521826787810441800851367590737912711816108190035649874770884973252603418858017168963892219_i384 : i384
      cf.cond_br %102, ^bb96, ^bb97
    ^bb96:  // pred: ^bb95
      llhd.drv %dec_lc_cnt_o, %c-11_i5 after %23 : i5
      cf.br ^bb104
    ^bb97:  // pred: ^bb95
      %103 = comb.icmp ceq %80, %c3064632631580316491810048475156113130282087166200209988590949048759832331477579550955323062986373573621473449309179_i384 : i384
      cf.cond_br %103, ^bb98, ^bb99
    ^bb98:  // pred: ^bb97
      llhd.drv %dec_lc_cnt_o, %c-10_i5 after %23 : i5
      cf.br ^bb104
    ^bb99:  // pred: ^bb97
      %104 = comb.icmp ceq %80, %c3064709032606212353072243254821777433402258981373129162371742995319249988652427810561249491444414778128343956943867_i384 : i384
      cf.cond_br %104, ^bb100, ^bb101
    ^bb100:  // pred: ^bb99
      llhd.drv %dec_lc_cnt_o, %c-9_i5 after %23 : i5
      cf.br ^bb104
    ^bb101:  // pred: ^bb99
      %105 = comb.icmp ceq %80, %c14775406613987005597957056839273030327923486421408010299430716062456368040795107685578447338622277126328287499351035_i384 : i384
      cf.cond_br %105, ^bb102, ^bb103
    ^bb102:  // pred: ^bb101
      llhd.drv %dec_lc_cnt_o, %c-8_i5 after %23 : i5
      cf.br ^bb104
    ^bb103:  // pred: ^bb101
      %106 = llhd.sig.extract %state_invalid_error_o from %c2_i3 : <i6> -> <i1>
      llhd.drv %106, %true after %23 : i1
      cf.br ^bb104
    ^bb104:  // 26 preds: ^bb54, ^bb56, ^bb58, ^bb60, ^bb62, ^bb64, ^bb66, ^bb68, ^bb70, ^bb72, ^bb74, ^bb76, ^bb78, ^bb80, ^bb82, ^bb84, ^bb86, ^bb88, ^bb90, ^bb92, ^bb94, ^bb96, ^bb98, ^bb100, ^bb102, ^bb103
      %107 = llhd.prb %secrets_valid_i_3 : i4
      %108 = comb.icmp ceq %107, %c-6_i4 : i4
      cf.cond_br %108, ^bb105, ^bb106
    ^bb105:  // pred: ^bb104
      llhd.drv %dec_lc_id_state_o, %c0_i2 after %23 : i2
      cf.br ^bb109
    ^bb106:  // pred: ^bb104
      %109 = comb.icmp ceq %107, %c5_i4 : i4
      cf.cond_br %109, ^bb107, ^bb108
    ^bb107:  // pred: ^bb106
      llhd.drv %dec_lc_id_state_o, %c1_i2 after %23 : i2
      cf.br ^bb109
    ^bb108:  // pred: ^bb106
      %110 = llhd.sig.extract %state_invalid_error_o from %c3_i3 : <i6> -> <i1>
      llhd.drv %110, %true after %23 : i1
      cf.br ^bb109
    ^bb109:  // 3 preds: ^bb105, ^bb107, ^bb108
      %111 = llhd.prb %lc_state_i_1 : i320
      %112 = comb.icmp ne %111, %c0_i320 : i320
      %113 = llhd.prb %lc_cnt_i_2 : i384
      %114 = comb.icmp eq %113, %c0_i384 : i384
      %115 = comb.and %112, %114 : i1
      cf.cond_br %115, ^bb110, ^bb111
    ^bb110:  // pred: ^bb109
      %116 = llhd.sig.extract %state_invalid_error_o from %c-4_i3 : <i6> -> <i1>
      llhd.drv %116, %true after %23 : i1
      cf.br ^bb111
    ^bb111:  // 2 preds: ^bb109, ^bb110
      %117 = llhd.prb %secrets_valid_i_3 : i4
      %118 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%117) : (i4) -> i1
      %119 = llhd.prb %lc_state_i_1 : i320
      %120 = comb.icmp weq %119, %c-456496308219428725067595699288731687292043479658042179497285099403199829975739052578789756128422_i320 : i320
      %121 = comb.icmp weq %119, %c-456496308219426320068298084851192228873599800621203464587165662212848069748932106232039927073958_i320 : i320
      %122 = comb.icmp weq %119, %c-456496308202635263122743346900974421756237933645613458509347227096541837787826188153527211019430_i320 : i320
      %123 = comb.icmp weq %119, %c-54303400873254211277939491738915568855517463684010673349609841479124041226336157744059344899238_i320 : i320
      %124 = comb.icmp weq %119, %c-54303400856460749330691294731318814168796966260574554854209901008302709731210395309844007373990_i320 : i320
      %125 = comb.or %120, %121, %122, %123, %124 : i1
      %126 = comb.xor %125, %true : i1
      %127 = comb.and %118, %126 : i1
      cf.cond_br %127, ^bb112, ^bb113
    ^bb112:  // pred: ^bb111
      %128 = llhd.sig.extract %state_invalid_error_o from %c-3_i3 : <i6> -> <i1>
      llhd.drv %128, %true after %23 : i1
      cf.br ^bb113
    ^bb113:  // 7 preds: ^bb1, ^bb3, ^bb5, ^bb7, ^bb9, ^bb111, ^bb112
      llhd.wait (%25, %39, %40, %41, %42, %43, %44, %45, %46 : !hw.array<6xi5>, i5, i2, i6, i16, i1, i320, i384, i4), ^bb1
    }
    llhd.drv %lc_state_valid_i_0, %lc_state_valid_i after %23 : i1
    llhd.drv %lc_state_i_1, %lc_state_i after %23 : i320
    llhd.drv %lc_cnt_i_2, %lc_cnt_i after %23 : i384
    llhd.drv %secrets_valid_i_3, %secrets_valid_i after %23 : i4
    llhd.drv %fsm_state_i_4, %fsm_state_i after %23 : i16
    %47 = llhd.prb %dec_lc_state_o : !hw.array<6xi5>
    hw.output %47, %40, %39, %41 : !hw.array<6xi5>, i2, i5, i6
  }
  hw.module private @lc_ctrl_state_transition(in %lc_state_i : i320, in %lc_cnt_i : i384, in %fsm_state_i : i16, in %dec_lc_state_i : !hw.array<6xi5>, in %trans_target_i : !hw.array<6xi5>, in %volatile_raw_unlock_i : i1, in %trans_cmd_i : i1, out next_lc_state_o : i320, out next_lc_cnt_o : i384, out trans_cnt_oflw_error_o : i1, out trans_invalid_error_o : i1) {
    %0 = hw.aggregate_constant [[-3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, -4 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, -4 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, 0 : i3, 3 : i3, 3 : i3, 3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, -3 : i3, 3 : i3, 3 : i3, 3 : i3, 2 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, 0 : i3, 3 : i3, 3 : i3, 3 : i3, -3 : i3, 0 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, -3 : i3, 3 : i3, 3 : i3, 3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, 0 : i3, 3 : i3, 3 : i3, 3 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, -3 : i3, 3 : i3, 3 : i3, 3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, 0 : i3, 3 : i3, 3 : i3, 3 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, -3 : i3, 3 : i3, 3 : i3, 3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, 0 : i3, 3 : i3, 3 : i3, 3 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, -3 : i3, 3 : i3, 3 : i3, 3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, 0 : i3, 3 : i3, 3 : i3, 3 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, -3 : i3, 3 : i3, 3 : i3, 3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, 0 : i3, 3 : i3, 3 : i3, 3 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, -3 : i3, 3 : i3, 3 : i3, 3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, 2 : i3, -3 : i3, -3 : i3, -3 : i3], [0 : i3, 0 : i3, 3 : i3, 3 : i3, 3 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, 0 : i3, -3 : i3, -3 : i3], [0 : i3, -3 : i3, -3 : i3, -3 : i3, -3 : i3, 1 : i3, -3 : i3, 1 : i3, -3 : i3, 1 : i3, -3 : i3, 1 : i3, -3 : i3, 1 : i3, -3 : i3, 1 : i3, -3 : i3, 1 : i3, -3 : i3, 1 : i3, -3 : i3]] : !hw.array<21xarray<21xi3>>
    %c-11_i5 = hw.constant -11 : i5
    %c1_i3 = hw.constant 1 : i3
    %c0_i3 = hw.constant 0 : i3
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [0 : i5, 0 : i5, 0 : i5, 0 : i5, 0 : i5, 0 : i5] : !hw.array<6xi5>
    %c0_i16 = hw.constant 0 : i16
    %c-54303400873254211277939491738915568855517463684010673349609841479124041226336157744059344899238_i320 = hw.constant -54303400873254211277939491738915568855517463684010673349609841479124041226336157744059344899238 : i320
    %c-13_i5 = hw.constant -13 : i5
    %c-456496308202635263122743346900974421756237933645613458509347227096541837787826188153527211019430_i320 = hw.constant -456496308202635263122743346900974421756237933645613458509347227096541837787826188153527211019430 : i320
    %c-14_i5 = hw.constant -14 : i5
    %c-456496308219426320068298084851192228873599800621203464587165662212848069748932106232039927073958_i320 = hw.constant -456496308219426320068298084851192228873599800621203464587165662212848069748932106232039927073958 : i320
    %c-15_i5 = hw.constant -15 : i5
    %c-456496308219428725067595699288731687292043479658042179497285099403199829975739052578789756128422_i320 = hw.constant -456496308219428725067595699288731687292043479658042179497285099403199829975739052578789756128422 : i320
    %c-16_i5 = hw.constant -16 : i5
    %c-456496308219428725069991543908571176442958431069049577004747167567363169282951950587742548544678_i320 = hw.constant -456496308219428725069991543908571176442958431069049577004747167567363169282951950587742548544678 : i320
    %c15_i5 = hw.constant 15 : i5
    %c-456496308219428725069992223730586335313491493392502011291754234001596928066027634096378592775334_i320 = hw.constant -456496308219428725069992223730586335313491493392502011291754234001596928066027634096378592775334 : i320
    %c14_i5 = hw.constant 14 : i5
    %c-456496308219428725069992223747441649870271937183805899370984814561761337221678801031624232160422_i320 = hw.constant -456496308219428725069992223747441649870271937183805899370984814561761337221678801031624232160422 : i320
    %c13_i5 = hw.constant 13 : i5
    %c-456496308219428725069992223747441655293687836557898079325106876213185120734113905048550051302566_i320 = hw.constant -456496308219428725069992223747441655293687836557898079325106876213185120734113905048550051302566 : i320
    %c12_i5 = hw.constant 12 : i5
    %c-456496308219428725069992223747441655294669495732793985256939044880764090660545683627503784971430_i320 = hw.constant -456496308219428725069992223747441655294669495732793985256939044880764090660545683627503784971430 : i320
    %c11_i5 = hw.constant 11 : i5
    %c-456496308219428725069992223747441655294669496142014443709591861977795843821104929131164897004710_i320 = hw.constant -456496308219428725069992223747441655294669496142014443709591861977795843821104929131164897004710 : i320
    %c10_i5 = hw.constant 10 : i5
    %c-456496308219428725069992223747441655294669496142203554028875401662036066712056987236735610932390_i320 = hw.constant -456496308219428725069992223747441655294669496142203554028875401662036066712056987236735610932390 : i320
    %c9_i5 = hw.constant 9 : i5
    %c-456496308219428725069992223747441655294669496142203568053953436675435776818504807144494214302886_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053953436675435776818504807144494214302886 : i320
    %c8_i5 = hw.constant 8 : i5
    %c-456496308219428725069992223747441655294669496142203568053958862625652945713376621513158249303206_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958862625652945713376621513158249303206 : i320
    %c7_i5 = hw.constant 7 : i5
    %c-456496308219428725069992223747441655294669496142203568053958864591858254829874687572138464791718_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958864591858254829874687572138464791718 : i320
    %c6_i5 = hw.constant 6 : i5
    %c-456496308219428725069992223747441655294669496142203568053958864591903156752666814128945401580710_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958864591903156752666814128945401580710 : i320
    %c5_i5 = hw.constant 5 : i5
    %c-456496308219428725069992223747441655294669496142203568053958864591903157416196198460277973208230_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958864591903157416196198460277973208230 : i320
    %c4_i5 = hw.constant 4 : i5
    %c-456496308219428725069992223747441655294669496142203568053958864591903157416196240118574526385318_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958864591903157416196240118574526385318 : i320
    %c3_i5 = hw.constant 3 : i5
    %c-456496308219428725069992223747441655294669496142203568053958864591903157416196240123045587340454_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958864591903157416196240123045587340454 : i320
    %c2_i5 = hw.constant 2 : i5
    %c-456496308219428725069992223747441655294669496142203568053958864591903157416196240123047907839142_i320 = hw.constant -456496308219428725069992223747441655294669496142203568053958864591903157416196240123047907839142 : i320
    %c1_i5 = hw.constant 1 : i5
    %c0_i320 = hw.constant 0 : i320
    %c0_i5 = hw.constant 0 : i5
    %c-3_i3 = hw.constant -3 : i3
    %c-12_i5 = hw.constant -12 : i5
    %c-54303400856460749330691294731318814168796966260574554854209901008302709731210395309844007373990_i320 = hw.constant -54303400856460749330691294731318814168796966260574554854209901008302709731210395309844007373990 : i320
    %c20_i30 = hw.constant 20 : i30
    %c14775406613987005597957056839273030327923486421408010299430716062456368040795107685578447338622277126328287499351035_i384 = hw.constant 14775406613987005597957056839273030327923486421408010299430716062456368040795107685578447338622277126328287499351035 : i384
    %c3064709032606212353072243254821777433402258981373129162371742995319249988652427810561249491444414778128343956943867_i384 = hw.constant 3064709032606212353072243254821777433402258981373129162371742995319249988652427810561249491444414778128343956943867 : i384
    %c3064632631580316491810048475156113130282087166200209988590949048759832331477579550955323062986373573621473449309179_i384 = hw.constant 3064632631580316491810048475156113130282087166200209988590949048759832331477579550955323062986373573621473449309179 : i384
    %c3064632628712743301590528521826787810441800851367590737912711816108190035649874770884973252603418858017168963892219_i384 = hw.constant 3064632628712743301590528521826787810441800851367590737912711816108190035649874770884973252603418858017168963892219 : i384
    %c3064632628712731261031607035656653349704443173602320722467319291656525844176331477032379027132638378579884902413307_i384 = hw.constant 3064632628712731261031607035656653349704443173602320722467319291656525844176331477032379027132638378579884902413307 : i384
    %c3064632628712731260981349284048528908984028081577884544477857463447999865000636619865907731704877335364928122352635_i384 = hw.constant 3064632628712731260981349284048528908984028081577884544477857463447999865000636619865907731704877335364928122352635 : i384
    %c3064632628712731260981348856350545596567515827949151138211934977055710179281599621066887603587709904586225163924475_i384 = hw.constant 3064632628712731260981348856350545596567515827949151138211934977055710179281599621066887603587709904586225163924475 : i384
    %c3064632628712731260981348856085098104965734566618046538599877588952775057289240869295839173538229936240607221478395_i384 = hw.constant 3064632628712731260981348856085098104965734566618046538599877588952775057289240869295839173538229936240607221478395 : i384
    %c3064632628712731260981348856085097786305904985523876732932526845043652645090243069453006936950958746463674452374523_i384 = hw.constant 3064632628712731260981348856085097786305904985523876732932526845043652645090243069453006936950958746463674452374523 : i384
    %c3064632628712731260981348856085097786305747736135111456727193931566086525342334423386185006863685923511759409214459_i384 = hw.constant 3064632628712731260981348856085097786305747736135111456727193931566086525342334423386185006863685923511759409214459 : i384
    %c3064632628712731260981348856085097786305746617566924236647148850831630564897857774181062915655333682522970169242619_i384 = hw.constant 3064632628712731260981348856085097786305746617566924236647148850831630564897857774181062915655333682522970169242619 : i384
    %c3064632628712731260981348856085097786305746617566259041429851753289089418605808965239423644681651307863211494044667_i384 = hw.constant 3064632628712731260981348856085097786305746617566259041429851753289089418605808965239423644681651307863211494044667 : i384
    %c3064632628712731260981348856085097786305746617566258731039725141888499008453693566466734701252379290005632900363259_i384 = hw.constant 3064632628712731260981348856085097786305746617566258731039725141888499008453693566466734701252379290005632900363259 : i384
    %c3064632628712731260981348856085097786305746617566258731034918948529429668639720847999523740969578995604879714513915_i384 = hw.constant 3064632628712731260981348856085097786305746617566258731034918948529429668639720847999523740969578995604879714513915 : i384
    %c3064632628712731260981348856085097786305746617566258731034918946927623874125051249648285164312532806061977647412219_i384 = hw.constant 3064632628712731260981348856085097786305746617566258731034918946927623874125051249648285164312532806061977647412219 : i384
    %c3064632628712731260981348856085097786305746617566258731034918946927484360663089242069911716859019117912396233929723_i384 = hw.constant 3064632628712731260981348856085097786305746617566258731034918946927484360663089242069911716859019117912396233929723 : i384
    %c3064632628712731260981348856085097786305746617566258731034918946927484343173936711801358448695417794349237237937147_i384 = hw.constant 3064632628712731260981348856085097786305746617566258731034918946927484343173936711801358448695417794349237237937147 : i384
    %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198872949949827817808624876317012987_i384 = hw.constant 3064632628712731260981348856085097786305746617566258731034918946927484343173681198872949949827817808624876317012987 : i384
    %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525613685365282952614779638739963_i384 = hw.constant 3064632628712731260981348856085097786305746617566258731034918946927484343173681198525613685365282952614779638739963 : i384
    %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564013021206626731249311380475_i384 = hw.constant 3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564013021206626731249311380475 : i384
    %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673243073319481078779_i384 = hw.constant 3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673243073319481078779 : i384
    %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673237162344970155003_i384 = hw.constant 3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673237162344970155003 : i384
    %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673236985289238344699_i384 = hw.constant 3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673236985289238344699 : i384
    %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673236985287067661307_i384 = hw.constant 3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673236985287067661307 : i384
    %c0_i384 = hw.constant 0 : i384
    %c-32341_i16 = hw.constant -32341 : i16
    %c-10897_i16 = hw.constant -10897 : i16
    %c8384_i16 = hw.constant 8384 : i16
    %c28336_i16 = hw.constant 28336 : i16
    %c3156_i16 = hw.constant 3156 : i16
    %c13255_i16 = hw.constant 13255 : i16
    %true = hw.constant true
    %false = hw.constant false
    %lc_state_i_0 = llhd.sig name "lc_state_i" %c0_i320 : i320
    %lc_cnt_i_1 = llhd.sig name "lc_cnt_i" %c0_i384 : i384
    %fsm_state_i_2 = llhd.sig name "fsm_state_i" %c0_i16 : i16
    %dec_lc_state_i_3 = llhd.sig name "dec_lc_state_i" %2 : !hw.array<6xi5>
    %trans_target_i_4 = llhd.sig name "trans_target_i" %2 : !hw.array<6xi5>
    %volatile_raw_unlock_i_5 = llhd.sig name "volatile_raw_unlock_i" %false : i1
    %trans_cmd_i_6 = llhd.sig name "trans_cmd_i" %false : i1
    %next_lc_state_o = llhd.sig %c0_i320 : i320
    %next_lc_cnt_o = llhd.sig %c0_i384 : i384
    %trans_cnt_oflw_error_o = llhd.sig %false : i1
    %trans_invalid_error_o = llhd.sig %false : i1
    %3 = llhd.prb %trans_cmd_i_6 {sv.namehint = "gen_no_volatile_unlock.unused_trans_cmd"} : i1
    %4 = llhd.prb %lc_cnt_i_1 : i384
    %5 = llhd.prb %next_lc_cnt_o : i384
    %6 = llhd.prb %lc_state_i_0 : i320
    %7 = llhd.prb %next_lc_state_o : i320
    %8 = llhd.prb %trans_cnt_oflw_error_o : i1
    %9 = llhd.prb %trans_invalid_error_o : i1
    %10 = llhd.prb %volatile_raw_unlock_i_5 : i1
    %11 = llhd.prb %fsm_state_i_2 : i16
    %12 = llhd.prb %dec_lc_state_i_3 : !hw.array<6xi5>
    %13 = llhd.prb %trans_target_i_4 : !hw.array<6xi5>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb125
      %14 = llhd.prb %lc_cnt_i_1 : i384
      llhd.drv %next_lc_cnt_o, %14 after %1 : i384
      %15 = llhd.prb %lc_state_i_0 : i320
      llhd.drv %next_lc_state_o, %15 after %1 : i320
      llhd.drv %trans_cnt_oflw_error_o, %false after %1 : i1
      llhd.drv %trans_invalid_error_o, %false after %1 : i1
      %16 = llhd.prb %fsm_state_i_2 : i16
      %17 = comb.icmp weq %16, %c13255_i16 : i16
      %18 = comb.icmp weq %16, %c3156_i16 : i16
      %19 = comb.icmp weq %16, %c28336_i16 : i16
      %20 = comb.icmp weq %16, %c8384_i16 : i16
      %21 = comb.icmp weq %16, %c-10897_i16 : i16
      %22 = comb.icmp weq %16, %c-32341_i16 : i16
      %23 = comb.or %17, %18, %19, %20, %21, %22 : i1
      cf.cond_br %23, ^bb2, ^bb55
    ^bb2:  // pred: ^bb1
      %24 = llhd.prb %lc_cnt_i_1 : i384
      %25 = comb.icmp ceq %24, %c0_i384 : i384
      cf.cond_br %25, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %next_lc_cnt_o, %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673236985287067661307_i384 after %1 : i384
      cf.br ^bb53
    ^bb4:  // pred: ^bb2
      %26 = comb.icmp ceq %24, %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673236985287067661307_i384 : i384
      cf.cond_br %26, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      llhd.drv %next_lc_cnt_o, %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673236985289238344699_i384 after %1 : i384
      cf.br ^bb53
    ^bb6:  // pred: ^bb4
      %27 = comb.icmp ceq %24, %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673236985289238344699_i384 : i384
      cf.cond_br %27, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      llhd.drv %next_lc_cnt_o, %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673237162344970155003_i384 after %1 : i384
      cf.br ^bb53
    ^bb8:  // pred: ^bb6
      %28 = comb.icmp ceq %24, %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673237162344970155003_i384 : i384
      cf.cond_br %28, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      llhd.drv %next_lc_cnt_o, %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673243073319481078779_i384 after %1 : i384
      cf.br ^bb53
    ^bb10:  // pred: ^bb8
      %29 = comb.icmp ceq %24, %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564012972673243073319481078779_i384 : i384
      cf.cond_br %29, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      llhd.drv %next_lc_cnt_o, %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564013021206626731249311380475_i384 after %1 : i384
      cf.br ^bb53
    ^bb12:  // pred: ^bb10
      %30 = comb.icmp ceq %24, %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525564013021206626731249311380475_i384 : i384
      cf.cond_br %30, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      llhd.drv %next_lc_cnt_o, %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525613685365282952614779638739963_i384 after %1 : i384
      cf.br ^bb53
    ^bb14:  // pred: ^bb12
      %31 = comb.icmp ceq %24, %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198525613685365282952614779638739963_i384 : i384
      cf.cond_br %31, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      llhd.drv %next_lc_cnt_o, %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198872949949827817808624876317012987_i384 after %1 : i384
      cf.br ^bb53
    ^bb16:  // pred: ^bb14
      %32 = comb.icmp ceq %24, %c3064632628712731260981348856085097786305746617566258731034918946927484343173681198872949949827817808624876317012987_i384 : i384
      cf.cond_br %32, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      llhd.drv %next_lc_cnt_o, %c3064632628712731260981348856085097786305746617566258731034918946927484343173936711801358448695417794349237237937147_i384 after %1 : i384
      cf.br ^bb53
    ^bb18:  // pred: ^bb16
      %33 = comb.icmp ceq %24, %c3064632628712731260981348856085097786305746617566258731034918946927484343173936711801358448695417794349237237937147_i384 : i384
      cf.cond_br %33, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      llhd.drv %next_lc_cnt_o, %c3064632628712731260981348856085097786305746617566258731034918946927484360663089242069911716859019117912396233929723_i384 after %1 : i384
      cf.br ^bb53
    ^bb20:  // pred: ^bb18
      %34 = comb.icmp ceq %24, %c3064632628712731260981348856085097786305746617566258731034918946927484360663089242069911716859019117912396233929723_i384 : i384
      cf.cond_br %34, ^bb21, ^bb22
    ^bb21:  // pred: ^bb20
      llhd.drv %next_lc_cnt_o, %c3064632628712731260981348856085097786305746617566258731034918946927623874125051249648285164312532806061977647412219_i384 after %1 : i384
      cf.br ^bb53
    ^bb22:  // pred: ^bb20
      %35 = comb.icmp ceq %24, %c3064632628712731260981348856085097786305746617566258731034918946927623874125051249648285164312532806061977647412219_i384 : i384
      cf.cond_br %35, ^bb23, ^bb24
    ^bb23:  // pred: ^bb22
      llhd.drv %next_lc_cnt_o, %c3064632628712731260981348856085097786305746617566258731034918948529429668639720847999523740969578995604879714513915_i384 after %1 : i384
      cf.br ^bb53
    ^bb24:  // pred: ^bb22
      %36 = comb.icmp ceq %24, %c3064632628712731260981348856085097786305746617566258731034918948529429668639720847999523740969578995604879714513915_i384 : i384
      cf.cond_br %36, ^bb25, ^bb26
    ^bb25:  // pred: ^bb24
      llhd.drv %next_lc_cnt_o, %c3064632628712731260981348856085097786305746617566258731039725141888499008453693566466734701252379290005632900363259_i384 after %1 : i384
      cf.br ^bb53
    ^bb26:  // pred: ^bb24
      %37 = comb.icmp ceq %24, %c3064632628712731260981348856085097786305746617566258731039725141888499008453693566466734701252379290005632900363259_i384 : i384
      cf.cond_br %37, ^bb27, ^bb28
    ^bb27:  // pred: ^bb26
      llhd.drv %next_lc_cnt_o, %c3064632628712731260981348856085097786305746617566259041429851753289089418605808965239423644681651307863211494044667_i384 after %1 : i384
      cf.br ^bb53
    ^bb28:  // pred: ^bb26
      %38 = comb.icmp ceq %24, %c3064632628712731260981348856085097786305746617566259041429851753289089418605808965239423644681651307863211494044667_i384 : i384
      cf.cond_br %38, ^bb29, ^bb30
    ^bb29:  // pred: ^bb28
      llhd.drv %next_lc_cnt_o, %c3064632628712731260981348856085097786305746617566924236647148850831630564897857774181062915655333682522970169242619_i384 after %1 : i384
      cf.br ^bb53
    ^bb30:  // pred: ^bb28
      %39 = comb.icmp ceq %24, %c3064632628712731260981348856085097786305746617566924236647148850831630564897857774181062915655333682522970169242619_i384 : i384
      cf.cond_br %39, ^bb31, ^bb32
    ^bb31:  // pred: ^bb30
      llhd.drv %next_lc_cnt_o, %c3064632628712731260981348856085097786305747736135111456727193931566086525342334423386185006863685923511759409214459_i384 after %1 : i384
      cf.br ^bb53
    ^bb32:  // pred: ^bb30
      %40 = comb.icmp ceq %24, %c3064632628712731260981348856085097786305747736135111456727193931566086525342334423386185006863685923511759409214459_i384 : i384
      cf.cond_br %40, ^bb33, ^bb34
    ^bb33:  // pred: ^bb32
      llhd.drv %next_lc_cnt_o, %c3064632628712731260981348856085097786305904985523876732932526845043652645090243069453006936950958746463674452374523_i384 after %1 : i384
      cf.br ^bb53
    ^bb34:  // pred: ^bb32
      %41 = comb.icmp ceq %24, %c3064632628712731260981348856085097786305904985523876732932526845043652645090243069453006936950958746463674452374523_i384 : i384
      cf.cond_br %41, ^bb35, ^bb36
    ^bb35:  // pred: ^bb34
      llhd.drv %next_lc_cnt_o, %c3064632628712731260981348856085098104965734566618046538599877588952775057289240869295839173538229936240607221478395_i384 after %1 : i384
      cf.br ^bb53
    ^bb36:  // pred: ^bb34
      %42 = comb.icmp ceq %24, %c3064632628712731260981348856085098104965734566618046538599877588952775057289240869295839173538229936240607221478395_i384 : i384
      cf.cond_br %42, ^bb37, ^bb38
    ^bb37:  // pred: ^bb36
      llhd.drv %next_lc_cnt_o, %c3064632628712731260981348856350545596567515827949151138211934977055710179281599621066887603587709904586225163924475_i384 after %1 : i384
      cf.br ^bb53
    ^bb38:  // pred: ^bb36
      %43 = comb.icmp ceq %24, %c3064632628712731260981348856350545596567515827949151138211934977055710179281599621066887603587709904586225163924475_i384 : i384
      cf.cond_br %43, ^bb39, ^bb40
    ^bb39:  // pred: ^bb38
      llhd.drv %next_lc_cnt_o, %c3064632628712731260981349284048528908984028081577884544477857463447999865000636619865907731704877335364928122352635_i384 after %1 : i384
      cf.br ^bb53
    ^bb40:  // pred: ^bb38
      %44 = comb.icmp ceq %24, %c3064632628712731260981349284048528908984028081577884544477857463447999865000636619865907731704877335364928122352635_i384 : i384
      cf.cond_br %44, ^bb41, ^bb42
    ^bb41:  // pred: ^bb40
      llhd.drv %next_lc_cnt_o, %c3064632628712731261031607035656653349704443173602320722467319291656525844176331477032379027132638378579884902413307_i384 after %1 : i384
      cf.br ^bb53
    ^bb42:  // pred: ^bb40
      %45 = comb.icmp ceq %24, %c3064632628712731261031607035656653349704443173602320722467319291656525844176331477032379027132638378579884902413307_i384 : i384
      cf.cond_br %45, ^bb43, ^bb44
    ^bb43:  // pred: ^bb42
      llhd.drv %next_lc_cnt_o, %c3064632628712743301590528521826787810441800851367590737912711816108190035649874770884973252603418858017168963892219_i384 after %1 : i384
      cf.br ^bb53
    ^bb44:  // pred: ^bb42
      %46 = comb.icmp ceq %24, %c3064632628712743301590528521826787810441800851367590737912711816108190035649874770884973252603418858017168963892219_i384 : i384
      cf.cond_br %46, ^bb45, ^bb46
    ^bb45:  // pred: ^bb44
      llhd.drv %next_lc_cnt_o, %c3064632631580316491810048475156113130282087166200209988590949048759832331477579550955323062986373573621473449309179_i384 after %1 : i384
      cf.br ^bb53
    ^bb46:  // pred: ^bb44
      %47 = comb.icmp ceq %24, %c3064632631580316491810048475156113130282087166200209988590949048759832331477579550955323062986373573621473449309179_i384 : i384
      cf.cond_br %47, ^bb47, ^bb48
    ^bb47:  // pred: ^bb46
      llhd.drv %next_lc_cnt_o, %c3064709032606212353072243254821777433402258981373129162371742995319249988652427810561249491444414778128343956943867_i384 after %1 : i384
      cf.br ^bb53
    ^bb48:  // pred: ^bb46
      %48 = comb.icmp ceq %24, %c3064709032606212353072243254821777433402258981373129162371742995319249988652427810561249491444414778128343956943867_i384 : i384
      cf.cond_br %48, ^bb49, ^bb50
    ^bb49:  // pred: ^bb48
      llhd.drv %next_lc_cnt_o, %c14775406613987005597957056839273030327923486421408010299430716062456368040795107685578447338622277126328287499351035_i384 after %1 : i384
      cf.br ^bb53
    ^bb50:  // pred: ^bb48
      %49 = comb.icmp ceq %24, %c14775406613987005597957056839273030327923486421408010299430716062456368040795107685578447338622277126328287499351035_i384 : i384
      cf.cond_br %49, ^bb51, ^bb52
    ^bb51:  // pred: ^bb50
      llhd.drv %trans_cnt_oflw_error_o, %true after %1 : i1
      cf.br ^bb53
    ^bb52:  // pred: ^bb50
      llhd.drv %trans_cnt_oflw_error_o, %true after %1 : i1
      cf.br ^bb53
    ^bb53:  // 26 preds: ^bb3, ^bb5, ^bb7, ^bb9, ^bb11, ^bb13, ^bb15, ^bb17, ^bb19, ^bb21, ^bb23, ^bb25, ^bb27, ^bb29, ^bb31, ^bb33, ^bb35, ^bb37, ^bb39, ^bb41, ^bb43, ^bb45, ^bb47, ^bb49, ^bb51, ^bb52
      %50 = llhd.prb %trans_target_i_4 : !hw.array<6xi5>
      %51 = hw.bitcast %50 : (!hw.array<6xi5>) -> i30
      %52 = comb.icmp eq %51, %c20_i30 : i30
      cf.cond_br %52, ^bb54, ^bb55
    ^bb54:  // pred: ^bb53
      llhd.drv %next_lc_cnt_o, %c14775406613987005597957056839273030327923486421408010299430716062456368040795107685578447338622277126328287499351035_i384 after %1 : i384
      llhd.drv %next_lc_state_o, %c-54303400856460749330691294731318814168796966260574554854209901008302709731210395309844007373990_i320 after %1 : i320
      llhd.drv %trans_cnt_oflw_error_o, %false after %1 : i1
      cf.br ^bb55
    ^bb55:  // 3 preds: ^bb1, ^bb53, ^bb54
      %53 = llhd.prb %fsm_state_i_2 : i16
      %54 = comb.icmp weq %53, %c28336_i16 : i16
      %55 = comb.icmp weq %53, %c8384_i16 : i16
      %56 = comb.icmp weq %53, %c-10897_i16 : i16
      %57 = comb.icmp weq %53, %c-32341_i16 : i16
      %58 = comb.or %54, %55, %56, %57 : i1
      cf.cond_br %58, ^bb56, ^bb125
    ^bb56:  // pred: ^bb55
      %59 = llhd.prb %dec_lc_state_i_3 : !hw.array<6xi5>
      %60 = hw.array_get %59[%c0_i3] : !hw.array<6xi5>, i3
      %61 = comb.icmp ult %60, %c-11_i5 : i5
      %62 = llhd.prb %trans_target_i_4 : !hw.array<6xi5>
      %63 = hw.array_get %62[%c0_i3] : !hw.array<6xi5>, i3
      %64 = comb.icmp ult %63, %c-11_i5 : i5
      %65 = hw.array_get %59[%c1_i3] : !hw.array<6xi5>, i3
      %66 = comb.icmp ult %65, %c-11_i5 : i5
      %67 = hw.array_get %62[%c1_i3] : !hw.array<6xi5>, i3
      %68 = comb.icmp ult %67, %c-11_i5 : i5
      %69 = comb.and %61, %64, %66, %68 : i1
      cf.cond_br %69, ^bb57, ^bb102
    ^bb57:  // pred: ^bb56
      %70 = llhd.prb %dec_lc_state_i_3 : !hw.array<6xi5>
      %71 = hw.array_get %70[%c0_i3] : !hw.array<6xi5>, i3
      %72 = hw.array_get %0[%71] : !hw.array<21xarray<21xi3>>, i5
      %73 = llhd.prb %trans_target_i_4 : !hw.array<6xi5>
      %74 = hw.array_get %73[%c0_i3] : !hw.array<6xi5>, i3
      %75 = hw.array_get %72[%74] : !hw.array<21xi3>, i5
      %76 = comb.icmp ne %75, %c-3_i3 : i3
      %77 = hw.array_get %70[%c1_i3] : !hw.array<6xi5>, i3
      %78 = hw.array_get %0[%77] : !hw.array<21xarray<21xi3>>, i5
      %79 = hw.array_get %73[%c1_i3] : !hw.array<6xi5>, i3
      %80 = hw.array_get %78[%79] : !hw.array<21xi3>, i5
      %81 = comb.icmp ne %80, %c-3_i3 : i3
      %82 = comb.or %76, %81 : i1
      cf.cond_br %82, ^bb58, ^bb101
    ^bb58:  // pred: ^bb57
      %83 = llhd.prb %trans_target_i_4 : !hw.array<6xi5>
      %84 = hw.array_get %83[%c0_i3] : !hw.array<6xi5>, i3
      %85 = comb.icmp ceq %84, %c0_i5 : i5
      cf.cond_br %85, ^bb59, ^bb60
    ^bb59:  // pred: ^bb58
      llhd.drv %next_lc_state_o, %c0_i320 after %1 : i320
      cf.br ^bb103
    ^bb60:  // pred: ^bb58
      %86 = comb.icmp ceq %84, %c1_i5 : i5
      cf.cond_br %86, ^bb61, ^bb62
    ^bb61:  // pred: ^bb60
      llhd.drv %next_lc_state_o, %c-456496308219428725069992223747441655294669496142203568053958864591903157416196240123047907839142_i320 after %1 : i320
      cf.br ^bb103
    ^bb62:  // pred: ^bb60
      %87 = comb.icmp ceq %84, %c2_i5 : i5
      cf.cond_br %87, ^bb63, ^bb64
    ^bb63:  // pred: ^bb62
      llhd.drv %next_lc_state_o, %c-456496308219428725069992223747441655294669496142203568053958864591903157416196240123045587340454_i320 after %1 : i320
      cf.br ^bb103
    ^bb64:  // pred: ^bb62
      %88 = comb.icmp ceq %84, %c3_i5 : i5
      cf.cond_br %88, ^bb65, ^bb66
    ^bb65:  // pred: ^bb64
      llhd.drv %next_lc_state_o, %c-456496308219428725069992223747441655294669496142203568053958864591903157416196240118574526385318_i320 after %1 : i320
      cf.br ^bb103
    ^bb66:  // pred: ^bb64
      %89 = comb.icmp ceq %84, %c4_i5 : i5
      cf.cond_br %89, ^bb67, ^bb68
    ^bb67:  // pred: ^bb66
      llhd.drv %next_lc_state_o, %c-456496308219428725069992223747441655294669496142203568053958864591903157416196198460277973208230_i320 after %1 : i320
      cf.br ^bb103
    ^bb68:  // pred: ^bb66
      %90 = comb.icmp ceq %84, %c5_i5 : i5
      cf.cond_br %90, ^bb69, ^bb70
    ^bb69:  // pred: ^bb68
      llhd.drv %next_lc_state_o, %c-456496308219428725069992223747441655294669496142203568053958864591903156752666814128945401580710_i320 after %1 : i320
      cf.br ^bb103
    ^bb70:  // pred: ^bb68
      %91 = comb.icmp ceq %84, %c6_i5 : i5
      cf.cond_br %91, ^bb71, ^bb72
    ^bb71:  // pred: ^bb70
      llhd.drv %next_lc_state_o, %c-456496308219428725069992223747441655294669496142203568053958864591858254829874687572138464791718_i320 after %1 : i320
      cf.br ^bb103
    ^bb72:  // pred: ^bb70
      %92 = comb.icmp ceq %84, %c7_i5 : i5
      cf.cond_br %92, ^bb73, ^bb74
    ^bb73:  // pred: ^bb72
      llhd.drv %next_lc_state_o, %c-456496308219428725069992223747441655294669496142203568053958862625652945713376621513158249303206_i320 after %1 : i320
      cf.br ^bb103
    ^bb74:  // pred: ^bb72
      %93 = comb.icmp ceq %84, %c8_i5 : i5
      cf.cond_br %93, ^bb75, ^bb76
    ^bb75:  // pred: ^bb74
      llhd.drv %next_lc_state_o, %c-456496308219428725069992223747441655294669496142203568053953436675435776818504807144494214302886_i320 after %1 : i320
      cf.br ^bb103
    ^bb76:  // pred: ^bb74
      %94 = comb.icmp ceq %84, %c9_i5 : i5
      cf.cond_br %94, ^bb77, ^bb78
    ^bb77:  // pred: ^bb76
      llhd.drv %next_lc_state_o, %c-456496308219428725069992223747441655294669496142203554028875401662036066712056987236735610932390_i320 after %1 : i320
      cf.br ^bb103
    ^bb78:  // pred: ^bb76
      %95 = comb.icmp ceq %84, %c10_i5 : i5
      cf.cond_br %95, ^bb79, ^bb80
    ^bb79:  // pred: ^bb78
      llhd.drv %next_lc_state_o, %c-456496308219428725069992223747441655294669496142014443709591861977795843821104929131164897004710_i320 after %1 : i320
      cf.br ^bb103
    ^bb80:  // pred: ^bb78
      %96 = comb.icmp ceq %84, %c11_i5 : i5
      cf.cond_br %96, ^bb81, ^bb82
    ^bb81:  // pred: ^bb80
      llhd.drv %next_lc_state_o, %c-456496308219428725069992223747441655294669495732793985256939044880764090660545683627503784971430_i320 after %1 : i320
      cf.br ^bb103
    ^bb82:  // pred: ^bb80
      %97 = comb.icmp ceq %84, %c12_i5 : i5
      cf.cond_br %97, ^bb83, ^bb84
    ^bb83:  // pred: ^bb82
      llhd.drv %next_lc_state_o, %c-456496308219428725069992223747441655293687836557898079325106876213185120734113905048550051302566_i320 after %1 : i320
      cf.br ^bb103
    ^bb84:  // pred: ^bb82
      %98 = comb.icmp ceq %84, %c13_i5 : i5
      cf.cond_br %98, ^bb85, ^bb86
    ^bb85:  // pred: ^bb84
      llhd.drv %next_lc_state_o, %c-456496308219428725069992223747441649870271937183805899370984814561761337221678801031624232160422_i320 after %1 : i320
      cf.br ^bb103
    ^bb86:  // pred: ^bb84
      %99 = comb.icmp ceq %84, %c14_i5 : i5
      cf.cond_br %99, ^bb87, ^bb88
    ^bb87:  // pred: ^bb86
      llhd.drv %next_lc_state_o, %c-456496308219428725069992223730586335313491493392502011291754234001596928066027634096378592775334_i320 after %1 : i320
      cf.br ^bb103
    ^bb88:  // pred: ^bb86
      %100 = comb.icmp ceq %84, %c15_i5 : i5
      cf.cond_br %100, ^bb89, ^bb90
    ^bb89:  // pred: ^bb88
      llhd.drv %next_lc_state_o, %c-456496308219428725069991543908571176442958431069049577004747167567363169282951950587742548544678_i320 after %1 : i320
      cf.br ^bb103
    ^bb90:  // pred: ^bb88
      %101 = comb.icmp ceq %84, %c-16_i5 : i5
      cf.cond_br %101, ^bb91, ^bb92
    ^bb91:  // pred: ^bb90
      llhd.drv %next_lc_state_o, %c-456496308219428725067595699288731687292043479658042179497285099403199829975739052578789756128422_i320 after %1 : i320
      cf.br ^bb103
    ^bb92:  // pred: ^bb90
      %102 = comb.icmp ceq %84, %c-15_i5 : i5
      cf.cond_br %102, ^bb93, ^bb94
    ^bb93:  // pred: ^bb92
      llhd.drv %next_lc_state_o, %c-456496308219426320068298084851192228873599800621203464587165662212848069748932106232039927073958_i320 after %1 : i320
      cf.br ^bb103
    ^bb94:  // pred: ^bb92
      %103 = comb.icmp ceq %84, %c-14_i5 : i5
      cf.cond_br %103, ^bb95, ^bb96
    ^bb95:  // pred: ^bb94
      llhd.drv %next_lc_state_o, %c-456496308202635263122743346900974421756237933645613458509347227096541837787826188153527211019430_i320 after %1 : i320
      cf.br ^bb103
    ^bb96:  // pred: ^bb94
      %104 = comb.icmp ceq %84, %c-13_i5 : i5
      cf.cond_br %104, ^bb97, ^bb98
    ^bb97:  // pred: ^bb96
      llhd.drv %next_lc_state_o, %c-54303400873254211277939491738915568855517463684010673349609841479124041226336157744059344899238_i320 after %1 : i320
      cf.br ^bb103
    ^bb98:  // pred: ^bb96
      %105 = comb.icmp ceq %84, %c-12_i5 : i5
      cf.cond_br %105, ^bb99, ^bb100
    ^bb99:  // pred: ^bb98
      llhd.drv %next_lc_state_o, %c-54303400856460749330691294731318814168796966260574554854209901008302709731210395309844007373990_i320 after %1 : i320
      cf.br ^bb103
    ^bb100:  // pred: ^bb98
      llhd.drv %trans_invalid_error_o, %true after %1 : i1
      cf.br ^bb103
    ^bb101:  // pred: ^bb57
      llhd.drv %trans_invalid_error_o, %true after %1 : i1
      cf.br ^bb103
    ^bb102:  // pred: ^bb56
      llhd.drv %trans_invalid_error_o, %true after %1 : i1
      cf.br ^bb103
    ^bb103:  // 24 preds: ^bb59, ^bb61, ^bb63, ^bb65, ^bb67, ^bb69, ^bb71, ^bb73, ^bb75, ^bb77, ^bb79, ^bb81, ^bb83, ^bb85, ^bb87, ^bb89, ^bb91, ^bb93, ^bb95, ^bb97, ^bb99, ^bb100, ^bb101, ^bb102
      %106 = llhd.prb %dec_lc_state_i_3 : !hw.array<6xi5>
      %107 = hw.array_get %106[%c0_i3] : !hw.array<6xi5>, i3
      %108 = comb.icmp ceq %107, %c0_i5 : i5
      cf.cond_br %108, ^bb125, ^bb104
    ^bb104:  // pred: ^bb103
      %109 = comb.icmp ceq %107, %c1_i5 : i5
      cf.cond_br %109, ^bb125, ^bb105
    ^bb105:  // pred: ^bb104
      %110 = comb.icmp ceq %107, %c2_i5 : i5
      cf.cond_br %110, ^bb125, ^bb106
    ^bb106:  // pred: ^bb105
      %111 = comb.icmp ceq %107, %c3_i5 : i5
      cf.cond_br %111, ^bb125, ^bb107
    ^bb107:  // pred: ^bb106
      %112 = comb.icmp ceq %107, %c4_i5 : i5
      cf.cond_br %112, ^bb125, ^bb108
    ^bb108:  // pred: ^bb107
      %113 = comb.icmp ceq %107, %c5_i5 : i5
      cf.cond_br %113, ^bb125, ^bb109
    ^bb109:  // pred: ^bb108
      %114 = comb.icmp ceq %107, %c6_i5 : i5
      cf.cond_br %114, ^bb125, ^bb110
    ^bb110:  // pred: ^bb109
      %115 = comb.icmp ceq %107, %c7_i5 : i5
      cf.cond_br %115, ^bb125, ^bb111
    ^bb111:  // pred: ^bb110
      %116 = comb.icmp ceq %107, %c8_i5 : i5
      cf.cond_br %116, ^bb125, ^bb112
    ^bb112:  // pred: ^bb111
      %117 = comb.icmp ceq %107, %c9_i5 : i5
      cf.cond_br %117, ^bb125, ^bb113
    ^bb113:  // pred: ^bb112
      %118 = comb.icmp ceq %107, %c10_i5 : i5
      cf.cond_br %118, ^bb125, ^bb114
    ^bb114:  // pred: ^bb113
      %119 = comb.icmp ceq %107, %c11_i5 : i5
      cf.cond_br %119, ^bb125, ^bb115
    ^bb115:  // pred: ^bb114
      %120 = comb.icmp ceq %107, %c12_i5 : i5
      cf.cond_br %120, ^bb125, ^bb116
    ^bb116:  // pred: ^bb115
      %121 = comb.icmp ceq %107, %c13_i5 : i5
      cf.cond_br %121, ^bb125, ^bb117
    ^bb117:  // pred: ^bb116
      %122 = comb.icmp ceq %107, %c14_i5 : i5
      cf.cond_br %122, ^bb125, ^bb118
    ^bb118:  // pred: ^bb117
      %123 = comb.icmp ceq %107, %c15_i5 : i5
      cf.cond_br %123, ^bb125, ^bb119
    ^bb119:  // pred: ^bb118
      %124 = comb.icmp ceq %107, %c-16_i5 : i5
      cf.cond_br %124, ^bb125, ^bb120
    ^bb120:  // pred: ^bb119
      %125 = comb.icmp ceq %107, %c-15_i5 : i5
      cf.cond_br %125, ^bb125, ^bb121
    ^bb121:  // pred: ^bb120
      %126 = comb.icmp ceq %107, %c-14_i5 : i5
      cf.cond_br %126, ^bb125, ^bb122
    ^bb122:  // pred: ^bb121
      %127 = comb.icmp ceq %107, %c-13_i5 : i5
      cf.cond_br %127, ^bb125, ^bb123
    ^bb123:  // pred: ^bb122
      %128 = comb.icmp ceq %107, %c-12_i5 : i5
      cf.cond_br %128, ^bb125, ^bb124
    ^bb124:  // pred: ^bb123
      llhd.drv %trans_invalid_error_o, %true after %1 : i1
      cf.br ^bb125
    ^bb125:  // 23 preds: ^bb55, ^bb103, ^bb104, ^bb105, ^bb106, ^bb107, ^bb108, ^bb109, ^bb110, ^bb111, ^bb112, ^bb113, ^bb114, ^bb115, ^bb116, ^bb117, ^bb118, ^bb119, ^bb120, ^bb121, ^bb122, ^bb123, ^bb124
      llhd.wait (%4, %5, %6, %7, %8, %9, %10, %3, %11, %12, %13 : i384, i384, i320, i320, i1, i1, i1, i1, i16, !hw.array<6xi5>, !hw.array<6xi5>), ^bb1
    }
    llhd.drv %lc_state_i_0, %lc_state_i after %1 : i320
    llhd.drv %lc_cnt_i_1, %lc_cnt_i after %1 : i384
    llhd.drv %fsm_state_i_2, %fsm_state_i after %1 : i16
    llhd.drv %dec_lc_state_i_3, %dec_lc_state_i after %1 : !hw.array<6xi5>
    llhd.drv %trans_target_i_4, %trans_target_i after %1 : !hw.array<6xi5>
    llhd.drv %volatile_raw_unlock_i_5, %volatile_raw_unlock_i after %1 : i1
    llhd.drv %trans_cmd_i_6, %trans_cmd_i after %1 : i1
    hw.output %7, %5, %8, %9 : i320, i384, i1, i1
  }
  hw.module @lc_ctrl(in %clk_i : i1, in %rst_ni : i1, in %clk_kmac_i : i1, in %rst_kmac_ni : i1, in %regs_tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out regs_tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %dmi_tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out dmi_tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %jtag_i : !hw.struct<tck: i1, tms: i1, trst_n: i1, tdi: i1>, out jtag_o : !hw.struct<tdo: i1, tdo_oe: i1>, in %scan_rst_ni : i1, in %scanmode_i : i4, in %alert_rx_i : !hw.array<3xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, out alert_tx_o : !hw.array<3xstruct<alert_p: i1, alert_n: i1>>, in %esc_scrap_state0_tx_i : !hw.struct<resp_p: i1, resp_n: i1>, out esc_scrap_state0_rx_o : !hw.struct<esc_p: i1, esc_n: i1>, in %esc_scrap_state1_tx_i : !hw.struct<resp_p: i1, resp_n: i1>, out esc_scrap_state1_rx_o : !hw.struct<esc_p: i1, esc_n: i1>, in %pwr_lc_i : !hw.struct<lc_init: i1>, out pwr_lc_o : !hw.struct<lc_done: i1, lc_idle: i1>, out strap_en_override_o : i1, out lc_otp_vendor_test_o : !hw.struct<ctrl: i32>, in %lc_otp_vendor_test_i : !hw.struct<status: i32>, out lc_otp_program_o : !hw.struct<req: i1, state: i320, count: i384>, in %lc_otp_program_i : !hw.struct<err: i1, ack: i1>, in %kmac_data_i : !hw.struct<ready: i1, done: i1, digest_share0: i384, digest_share1: i384, error: i1>, out kmac_data_o : !hw.struct<valid: i1, data: i64, strb: i8, last: i1>, in %otp_lc_data_i : !hw.struct<valid: i1, error: i1, state: i320, count: i384, secrets_valid: i4, test_tokens_valid: i4, test_unlock_token: i128, test_exit_token: i128, rma_token_valid: i4, rma_token: i128>, out lc_init_done_o : i4, out lc_dft_en_o : i4, out lc_raw_test_rma_o : i4, out lc_nvm_debug_en_o : i4, out lc_hw_debug_clr_o : i4, out lc_hw_debug_en_o : i4, out lc_cpu_en_o : i4, out lc_creator_seed_sw_rw_en_o : i4, out lc_owner_seed_sw_rw_en_o : i4, out lc_iso_part_sw_rd_en_o : i4, out lc_iso_part_sw_wr_en_o : i4, out lc_seed_hw_rd_en_o : i4, out lc_rma_state_o : i4, out lc_keymgr_en_o : i4, out lc_escalate_en_o : i4, out lc_check_byp_en_o : i4, out lc_clk_byp_req_o : i4, in %lc_clk_byp_ack_i : i4, out lc_nvm_rma_seed_o : i32, out lc_nvm_rma_req_o : i4, in %lc_nvm_rma_ack_i : !hw.array<2xi4>, out lc_keymgr_div_o : i128, in %otp_device_id_i : i256, in %otp_manuf_state_i : i256, out hw_rev_o : !hw.struct<silicon_creator_id: i16, product_id: i16, revision_id: i8, reserved: i24>) {
    %0 = hw.aggregate_constant [0 : i24] : !hw.struct<d: i24>
    %1 = hw.aggregate_constant [false, false] : !hw.struct<tdo: i1, tdo_oe: i1>
    %2 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c-1_i30 = hw.constant -1 : i30
    %c-1_i3 = hw.constant -1 : i3
    %c0_i29 = hw.constant 0 : i29
    %c-1_i7 = hw.constant -1 : i7
    %c0_i25 = hw.constant 0 : i25
    %c-1_i2 = hw.constant -1 : i2
    %c0_i30 = hw.constant 0 : i30
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %3 = llhd.constant_time <0ns, 0d, 1e>
    %4 = hw.aggregate_constant [0 : i5, 0 : i5, 0 : i5, 0 : i5, 0 : i5, 0 : i5] : !hw.array<6xi5>
    %c0_i8 = hw.constant 0 : i8
    %5 = hw.aggregate_constant [[[false], [false], [false], [false], [false], [false], [false], [false], [false], [false], [false], [false]], [0 : i8], [false], [[false], [false]], [[0 : i32], [0 : i32], [0 : i32], [0 : i32]], [0 : i30], [0 : i32], [0 : i32], [0 : i30], [0 : i5], [0 : i32], [[0 : i16], [0 : i16]], [[0 : i24], [0 : i8]], [[0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32]], [[0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32]]] : !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>
    %6 = hw.aggregate_constant [[[false, false], [false, false], [false, false]], [0 : i8, false], [false, false], [[false, false], [false, false]], [[0 : i32, false], [0 : i32, false], [0 : i32, false], [0 : i32, false]], [0 : i30, false], [0 : i32, false]] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
    %7 = hw.aggregate_constant [0 : i16, 0 : i16, 0 : i8, 0 : i24] : !hw.struct<silicon_creator_id: i16, product_id: i16, revision_id: i8, reserved: i24>
    %c0_i256 = hw.constant 0 : i256
    %8 = hw.aggregate_constant [false, false, 0 : i320, 0 : i384, 0 : i4, 0 : i4, 0 : i128, 0 : i128, 0 : i4, 0 : i128] : !hw.struct<valid: i1, error: i1, state: i320, count: i384, secrets_valid: i4, test_tokens_valid: i4, test_unlock_token: i128, test_exit_token: i128, rma_token_valid: i4, rma_token: i128>
    %9 = hw.aggregate_constant [false, 0 : i320, 0 : i384] : !hw.struct<req: i1, state: i320, count: i384>
    %10 = hw.aggregate_constant [0 : i32] : !hw.struct<status: i32>
    %11 = hw.aggregate_constant [0 : i32] : !hw.struct<ctrl: i32>
    %12 = hw.aggregate_constant [false, false] : !hw.struct<lc_done: i1, lc_idle: i1>
    %13 = hw.aggregate_constant [[false, false], [false, false], [false, false]] : !hw.array<3xstruct<alert_p: i1, alert_n: i1>>
    %c4_i32 = hw.constant 4 : i32
    %c0_i32 = hw.constant 0 : i32
    %c0_i5 = hw.constant 0 : i5
    %c0_i128 = hw.constant 0 : i128
    %c105_i8 = hw.constant 105 : i8
    %c5_i32 = hw.constant 5 : i32
    %c6_i32 = hw.constant 6 : i32
    %c1_i32 = hw.constant 1 : i32
    %false = hw.constant false
    %c0_i2 = hw.constant 0 : i2
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %14 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %15 = llhd.prb %rst_ni_1 : i1
    %alert_tx_o = llhd.sig %13 : !hw.array<3xstruct<alert_p: i1, alert_n: i1>>
    %pwr_lc_o = llhd.sig %12 : !hw.struct<lc_done: i1, lc_idle: i1>
    %lc_otp_vendor_test_o = llhd.sig %11 : !hw.struct<ctrl: i32>
    %lc_otp_vendor_test_i_2 = llhd.sig name "lc_otp_vendor_test_i" %10 : !hw.struct<status: i32>
    %lc_otp_program_o = llhd.sig %9 : !hw.struct<req: i1, state: i320, count: i384>
    %otp_lc_data_i_3 = llhd.sig name "otp_lc_data_i" %8 : !hw.struct<valid: i1, error: i1, state: i320, count: i384, secrets_valid: i4, test_tokens_valid: i4, test_unlock_token: i128, test_exit_token: i128, rma_token_valid: i4, rma_token: i128>
    %otp_device_id_i_4 = llhd.sig name "otp_device_id_i" %c0_i256 : i256
    %otp_manuf_state_i_5 = llhd.sig name "otp_manuf_state_i" %c0_i256 : i256
    %hw_rev_o = llhd.sig %7 : !hw.struct<silicon_creator_id: i16, product_id: i16, revision_id: i8, reserved: i24>
    %reg2hw = llhd.sig %6 : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
    %hw2reg = llhd.sig %5 : !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>
    %fatal_bus_integ_error_q = llhd.sig %false : i1
    %fatal_bus_integ_error_csr_d = llhd.sig %false : i1
    %fatal_bus_integ_error_tap_dmi_d = llhd.sig %false : i1
    %tap_dmi_reg2hw = llhd.sig %6 : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
    %tap_dmi_hw2reg = llhd.sig %5 : !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>
    %trans_success_d = llhd.sig %false : i1
    %trans_success_q = llhd.sig %false : i1
    %trans_cnt_oflw_error_d = llhd.sig %false : i1
    %trans_cnt_oflw_error_q = llhd.sig %false : i1
    %trans_invalid_error_d = llhd.sig %false : i1
    %trans_invalid_error_q = llhd.sig %false : i1
    %token_invalid_error_d = llhd.sig %false : i1
    %token_invalid_error_q = llhd.sig %false : i1
    %nvm_rma_error_d = llhd.sig %false : i1
    %nvm_rma_error_q = llhd.sig %false : i1
    %otp_prog_error_d = llhd.sig %false : i1
    %fatal_prog_error_q = llhd.sig %false : i1
    %state_invalid_error_d = llhd.sig %false : i1
    %fatal_state_error_q = llhd.sig %false : i1
    %otp_part_error_q = llhd.sig %false : i1
    %sw_claim_transition_if_d = llhd.sig %c0_i8 : i8
    %sw_claim_transition_if_q = llhd.sig %c0_i8 : i8
    %tap_dmi_claim_transition_if_d = llhd.sig %c0_i8 : i8
    %tap_dmi_claim_transition_if_q = llhd.sig %c0_i8 : i8
    %transition_cmd = llhd.sig %false : i1
    %transition_token_d = llhd.sig %c0_i128 : i128
    %transition_token_q = llhd.sig %c0_i128 : i128
    %transition_target_d = llhd.sig %4 : !hw.array<6xi5>
    %transition_target_q = llhd.sig %4 : !hw.array<6xi5>
    %dec_lc_state = llhd.sig %4 : !hw.array<6xi5>
    %dec_lc_cnt = llhd.sig %c0_i5 : i5
    %dec_lc_id_state = llhd.sig %c0_i2 : i2
    %lc_idle_d = llhd.sig %false : i1
    %lc_done_d = llhd.sig %false : i1
    %ext_clock_switched = llhd.sig %false : i1
    %use_ext_clock_d = llhd.sig %false : i1
    %use_ext_clock_q = llhd.sig %false : i1
    %volatile_raw_unlock_d = llhd.sig %false : i1
    %volatile_raw_unlock_q = llhd.sig %false : i1
    %otp_vendor_test_ctrl_d = llhd.sig %c0_i32 : i32
    %otp_vendor_test_ctrl_q = llhd.sig %c0_i32 : i32
    %otp_vendor_test_status = llhd.sig %c0_i32 : i32
    %lc_done_q = llhd.sig %false : i1
    %lc_idle_q = llhd.sig %false : i1
    %16 = llhd.prb %hw2reg : !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>
    %u_reg_regs.tl_o, %u_reg_regs.reg2hw, %u_reg_regs.intg_err_o = hw.instance "u_reg_regs" @lc_ctrl_regs_reg_top(clk_i: %14: i1, rst_ni: %15: i1, tl_i: %regs_tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, hw2reg: %16: !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, reg2hw: !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>, intg_err_o: i1)
    llhd.drv %reg2hw, %u_reg_regs.reg2hw after %3 : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
    llhd.drv %fatal_bus_integ_error_csr_d, %u_reg_regs.intg_err_o after %3 : i1
    %17 = llhd.prb %tap_dmi_hw2reg : !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>
    %u_reg_tap_dmi.tl_o, %u_reg_tap_dmi.reg2hw, %u_reg_tap_dmi.intg_err_o = hw.instance "u_reg_tap_dmi" @lc_ctrl_regs_reg_top(clk_i: %14: i1, rst_ni: %15: i1, tl_i: %dmi_tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, hw2reg: %17: !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, reg2hw: !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>, intg_err_o: i1) {sv.namehint = "tap_dmi_tl_d2h"}
    llhd.drv %tap_dmi_reg2hw, %u_reg_tap_dmi.reg2hw after %3 : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
    llhd.drv %fatal_bus_integ_error_tap_dmi_d, %u_reg_tap_dmi.intg_err_o after %3 : i1
    %u_hw_rev_const.out_o = hw.instance "u_hw_rev_const" @prim_const() -> (out_o: i64) {sv.namehint = "hw_rev_raw"}
    %u_prim_lc_sync.lc_en_o = hw.instance "u_prim_lc_sync" @prim_lc_sync(clk_i: %14: i1, rst_ni: %15: i1, lc_en_i: %u_lc_ctrl_fsm.lc_raw_test_rma_o: i4) -> (lc_en_o: !hw.array<2xi4>) {sv.namehint = "lc_raw_test_rma_buf"}
    %18 = comb.or %83, %86 : i1
    %19 = hw.array_get %alert_rx_i[%c0_i2] : !hw.array<3xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, i2
    %20 = llhd.sig.array_get %alert_tx_o[%c0_i2] : <!hw.array<3xstruct<alert_p: i1, alert_n: i1>>>
    %gen_alert_tx_0.u_prim_alert_sender.alert_ack_o, %gen_alert_tx_0.u_prim_alert_sender.alert_state_o, %gen_alert_tx_0.u_prim_alert_sender.alert_tx_o = hw.instance "gen_alert_tx_0.u_prim_alert_sender" @prim_alert_sender(clk_i: %14: i1, rst_ni: %15: i1, alert_test_i: %18: i1, alert_req_i: %49: i1, alert_rx_i: %19: !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>) -> (alert_ack_o: i1, alert_state_o: i1, alert_tx_o: !hw.struct<alert_p: i1, alert_n: i1>)
    llhd.drv %20, %gen_alert_tx_0.u_prim_alert_sender.alert_tx_o after %3 : !hw.struct<alert_p: i1, alert_n: i1>
    %21 = comb.or %82, %85 : i1
    %22 = hw.array_get %alert_rx_i[%c1_i2] : !hw.array<3xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, i2
    %23 = llhd.sig.array_get %alert_tx_o[%c1_i2] : <!hw.array<3xstruct<alert_p: i1, alert_n: i1>>>
    %gen_alert_tx_1.u_prim_alert_sender.alert_ack_o, %gen_alert_tx_1.u_prim_alert_sender.alert_state_o, %gen_alert_tx_1.u_prim_alert_sender.alert_tx_o = hw.instance "gen_alert_tx_1.u_prim_alert_sender" @prim_alert_sender(clk_i: %14: i1, rst_ni: %15: i1, alert_test_i: %21: i1, alert_req_i: %50: i1, alert_rx_i: %22: !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>) -> (alert_ack_o: i1, alert_state_o: i1, alert_tx_o: !hw.struct<alert_p: i1, alert_n: i1>)
    llhd.drv %23, %gen_alert_tx_1.u_prim_alert_sender.alert_tx_o after %3 : !hw.struct<alert_p: i1, alert_n: i1>
    %24 = comb.or %81, %84 : i1
    %25 = hw.array_get %alert_rx_i[%c-2_i2] : !hw.array<3xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, i2
    %26 = llhd.sig.array_get %alert_tx_o[%c-2_i2] : <!hw.array<3xstruct<alert_p: i1, alert_n: i1>>>
    %gen_alert_tx_2.u_prim_alert_sender.alert_ack_o, %gen_alert_tx_2.u_prim_alert_sender.alert_state_o, %gen_alert_tx_2.u_prim_alert_sender.alert_tx_o = hw.instance "gen_alert_tx_2.u_prim_alert_sender" @prim_alert_sender(clk_i: %14: i1, rst_ni: %15: i1, alert_test_i: %24: i1, alert_req_i: %52: i1, alert_rx_i: %25: !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>) -> (alert_ack_o: i1, alert_state_o: i1, alert_tx_o: !hw.struct<alert_p: i1, alert_n: i1>)
    llhd.drv %26, %gen_alert_tx_2.u_prim_alert_sender.alert_tx_o after %3 : !hw.struct<alert_p: i1, alert_n: i1>
    %27 = hw.bitcast %esc_scrap_state0_tx_i : (!hw.struct<resp_p: i1, resp_n: i1>) -> !hw.struct<esc_p: i1, esc_n: i1>
    %u_prim_esc_receiver0.esc_req_o, %u_prim_esc_receiver0.esc_rx_o = hw.instance "u_prim_esc_receiver0" @prim_esc_receiver(clk_i: %14: i1, rst_ni: %15: i1, esc_tx_i: %27: !hw.struct<esc_p: i1, esc_n: i1>) -> (esc_req_o: i1, esc_rx_o: !hw.struct<resp_p: i1, resp_n: i1>) {sv.namehint = "esc_scrap_state0"}
    %28 = hw.bitcast %u_prim_esc_receiver0.esc_rx_o : (!hw.struct<resp_p: i1, resp_n: i1>) -> !hw.struct<esc_p: i1, esc_n: i1>
    %29 = hw.bitcast %esc_scrap_state1_tx_i : (!hw.struct<resp_p: i1, resp_n: i1>) -> !hw.struct<esc_p: i1, esc_n: i1>
    %u_prim_esc_receiver1.esc_req_o, %u_prim_esc_receiver1.esc_rx_o = hw.instance "u_prim_esc_receiver1" @prim_esc_receiver(clk_i: %14: i1, rst_ni: %15: i1, esc_tx_i: %29: !hw.struct<esc_p: i1, esc_n: i1>) -> (esc_req_o: i1, esc_rx_o: !hw.struct<resp_p: i1, resp_n: i1>) {sv.namehint = "esc_scrap_state1"}
    %30 = hw.bitcast %u_prim_esc_receiver1.esc_rx_o : (!hw.struct<resp_p: i1, resp_n: i1>) -> !hw.struct<esc_p: i1, esc_n: i1>
    %lc_init = hw.struct_extract %pwr_lc_i["lc_init"] : !hw.struct<lc_init: i1>
    %u_prim_flop_2sync_init.q_o = hw.instance "u_prim_flop_2sync_init" @prim_flop_2sync(clk_i: %14: i1, rst_ni: %15: i1, d_i: %lc_init: i1) -> (q_o: i1) {sv.namehint = "lc_init"}
    %31 = llhd.prb %transition_token_q : i128
    %u_lc_ctrl_kmac_if.kmac_data_o, %u_lc_ctrl_kmac_if.token_hash_ack_o, %u_lc_ctrl_kmac_if.token_hash_err_o, %u_lc_ctrl_kmac_if.token_if_fsm_err_o, %u_lc_ctrl_kmac_if.hashed_token_o = hw.instance "u_lc_ctrl_kmac_if" @lc_ctrl_kmac_if(clk_i: %14: i1, rst_ni: %15: i1, clk_kmac_i: %clk_kmac_i: i1, rst_kmac_ni: %rst_kmac_ni: i1, kmac_data_i: %kmac_data_i: !hw.struct<ready: i1, done: i1, digest_share0: i384, digest_share1: i384, error: i1>, transition_token_i: %31: i128, token_hash_req_i: %u_lc_ctrl_fsm.token_hash_req_o: i1, token_hash_req_chk_i: %u_lc_ctrl_fsm.token_hash_req_chk_o: i1) -> (kmac_data_o: !hw.struct<valid: i1, data: i64, strb: i8, last: i1>, token_hash_ack_o: i1, token_hash_err_o: i1, token_if_fsm_err_o: i1, hashed_token_o: i128) {sv.namehint = "hashed_token"}
    %32 = llhd.prb %otp_lc_data_i_3 : !hw.struct<valid: i1, error: i1, state: i320, count: i384, secrets_valid: i4, test_tokens_valid: i4, test_unlock_token: i128, test_exit_token: i128, rma_token_valid: i4, rma_token: i128>
    %valid = hw.struct_extract %32["valid"] : !hw.struct<valid: i1, error: i1, state: i320, count: i384, secrets_valid: i4, test_tokens_valid: i4, test_unlock_token: i128, test_exit_token: i128, rma_token_valid: i4, rma_token: i128>
    %state = hw.struct_extract %32["state"] : !hw.struct<valid: i1, error: i1, state: i320, count: i384, secrets_valid: i4, test_tokens_valid: i4, test_unlock_token: i128, test_exit_token: i128, rma_token_valid: i4, rma_token: i128>
    %count = hw.struct_extract %32["count"] : !hw.struct<valid: i1, error: i1, state: i320, count: i384, secrets_valid: i4, test_tokens_valid: i4, test_unlock_token: i128, test_exit_token: i128, rma_token_valid: i4, rma_token: i128>
    %secrets_valid = hw.struct_extract %32["secrets_valid"] : !hw.struct<valid: i1, error: i1, state: i320, count: i384, secrets_valid: i4, test_tokens_valid: i4, test_unlock_token: i128, test_exit_token: i128, rma_token_valid: i4, rma_token: i128>
    %33 = llhd.prb %use_ext_clock_q : i1
    %34 = llhd.prb %volatile_raw_unlock_q : i1
    %test_unlock_token = hw.struct_extract %32["test_unlock_token"] : !hw.struct<valid: i1, error: i1, state: i320, count: i384, secrets_valid: i4, test_tokens_valid: i4, test_unlock_token: i128, test_exit_token: i128, rma_token_valid: i4, rma_token: i128>
    %test_exit_token = hw.struct_extract %32["test_exit_token"] : !hw.struct<valid: i1, error: i1, state: i320, count: i384, secrets_valid: i4, test_tokens_valid: i4, test_unlock_token: i128, test_exit_token: i128, rma_token_valid: i4, rma_token: i128>
    %test_tokens_valid = hw.struct_extract %32["test_tokens_valid"] : !hw.struct<valid: i1, error: i1, state: i320, count: i384, secrets_valid: i4, test_tokens_valid: i4, test_unlock_token: i128, test_exit_token: i128, rma_token_valid: i4, rma_token: i128>
    %rma_token = hw.struct_extract %32["rma_token"] : !hw.struct<valid: i1, error: i1, state: i320, count: i384, secrets_valid: i4, test_tokens_valid: i4, test_unlock_token: i128, test_exit_token: i128, rma_token_valid: i4, rma_token: i128>
    %rma_token_valid = hw.struct_extract %32["rma_token_valid"] : !hw.struct<valid: i1, error: i1, state: i320, count: i384, secrets_valid: i4, test_tokens_valid: i4, test_unlock_token: i128, test_exit_token: i128, rma_token_valid: i4, rma_token: i128>
    %35 = llhd.prb %transition_cmd : i1
    %36 = llhd.prb %transition_target_q : !hw.array<6xi5>
    %37 = llhd.sig.struct_extract %lc_otp_program_o["req"] : <!hw.struct<req: i1, state: i320, count: i384>>
    %38 = llhd.sig.struct_extract %lc_otp_program_o["state"] : <!hw.struct<req: i1, state: i320, count: i384>>
    %39 = llhd.sig.struct_extract %lc_otp_program_o["count"] : <!hw.struct<req: i1, state: i320, count: i384>>
    %ack = hw.struct_extract %lc_otp_program_i["ack"] : !hw.struct<err: i1, ack: i1>
    %err = hw.struct_extract %lc_otp_program_i["err"] : !hw.struct<err: i1, ack: i1>
    %u_lc_ctrl_fsm.init_done_o, %u_lc_ctrl_fsm.idle_o, %u_lc_ctrl_fsm.ext_clock_switched_o, %u_lc_ctrl_fsm.strap_en_override_o, %u_lc_ctrl_fsm.dec_lc_state_o, %u_lc_ctrl_fsm.dec_lc_cnt_o, %u_lc_ctrl_fsm.dec_lc_id_state_o, %u_lc_ctrl_fsm.token_hash_req_o, %u_lc_ctrl_fsm.token_hash_req_chk_o, %u_lc_ctrl_fsm.otp_prog_req_o, %u_lc_ctrl_fsm.otp_prog_lc_state_o, %u_lc_ctrl_fsm.otp_prog_lc_cnt_o, %u_lc_ctrl_fsm.trans_success_o, %u_lc_ctrl_fsm.trans_cnt_oflw_error_o, %u_lc_ctrl_fsm.trans_invalid_error_o, %u_lc_ctrl_fsm.token_invalid_error_o, %u_lc_ctrl_fsm.nvm_rma_error_o, %u_lc_ctrl_fsm.otp_prog_error_o, %u_lc_ctrl_fsm.state_invalid_error_o, %u_lc_ctrl_fsm.lc_raw_test_rma_o, %u_lc_ctrl_fsm.lc_init_done_o, %u_lc_ctrl_fsm.lc_dft_en_o, %u_lc_ctrl_fsm.lc_nvm_debug_en_o, %u_lc_ctrl_fsm.lc_hw_debug_clr_o, %u_lc_ctrl_fsm.lc_hw_debug_en_o, %u_lc_ctrl_fsm.lc_cpu_en_o, %u_lc_ctrl_fsm.lc_creator_seed_sw_rw_en_o, %u_lc_ctrl_fsm.lc_owner_seed_sw_rw_en_o, %u_lc_ctrl_fsm.lc_iso_part_sw_rd_en_o, %u_lc_ctrl_fsm.lc_iso_part_sw_wr_en_o, %u_lc_ctrl_fsm.lc_seed_hw_rd_en_o, %u_lc_ctrl_fsm.lc_rma_state_o, %u_lc_ctrl_fsm.lc_keymgr_en_o, %u_lc_ctrl_fsm.lc_escalate_en_o, %u_lc_ctrl_fsm.lc_check_byp_en_o, %u_lc_ctrl_fsm.lc_clk_byp_req_o, %u_lc_ctrl_fsm.lc_nvm_rma_req_o, %u_lc_ctrl_fsm.lc_keymgr_div_o = hw.instance "u_lc_ctrl_fsm" @lc_ctrl_fsm(clk_i: %14: i1, rst_ni: %15: i1, init_req_i: %u_prim_flop_2sync_init.q_o: i1, esc_scrap_state0_i: %u_prim_esc_receiver0.esc_req_o: i1, esc_scrap_state1_i: %u_prim_esc_receiver1.esc_req_o: i1, lc_state_valid_i: %valid: i1, lc_state_i: %state: i320, lc_cnt_i: %count: i384, secrets_valid_i: %secrets_valid: i4, use_ext_clock_i: %33: i1, volatile_raw_unlock_i: %34: i1, test_unlock_token_i: %test_unlock_token: i128, test_exit_token_i: %test_exit_token: i128, test_tokens_valid_i: %test_tokens_valid: i4, rma_token_i: %rma_token: i128, rma_token_valid_i: %rma_token_valid: i4, trans_cmd_i: %35: i1, trans_target_i: %36: !hw.array<6xi5>, token_hash_ack_i: %u_lc_ctrl_kmac_if.token_hash_ack_o: i1, token_hash_err_i: %u_lc_ctrl_kmac_if.token_hash_err_o: i1, token_if_fsm_err_i: %u_lc_ctrl_kmac_if.token_if_fsm_err_o: i1, hashed_token_i: %u_lc_ctrl_kmac_if.hashed_token_o: i128, unhashed_token_i: %31: i128, otp_prog_ack_i: %ack: i1, otp_prog_err_i: %err: i1, lc_clk_byp_ack_i: %lc_clk_byp_ack_i: i4, lc_nvm_rma_ack_i: %lc_nvm_rma_ack_i: !hw.array<2xi4>) -> (init_done_o: i1, idle_o: i1, ext_clock_switched_o: i1, strap_en_override_o: i1, dec_lc_state_o: !hw.array<6xi5>, dec_lc_cnt_o: i5, dec_lc_id_state_o: i2, token_hash_req_o: i1, token_hash_req_chk_o: i1, otp_prog_req_o: i1, otp_prog_lc_state_o: i320, otp_prog_lc_cnt_o: i384, trans_success_o: i1, trans_cnt_oflw_error_o: i1, trans_invalid_error_o: i1, token_invalid_error_o: i1, nvm_rma_error_o: i1, otp_prog_error_o: i1, state_invalid_error_o: i1, lc_raw_test_rma_o: i4, lc_init_done_o: i4, lc_dft_en_o: i4, lc_nvm_debug_en_o: i4, lc_hw_debug_clr_o: i4, lc_hw_debug_en_o: i4, lc_cpu_en_o: i4, lc_creator_seed_sw_rw_en_o: i4, lc_owner_seed_sw_rw_en_o: i4, lc_iso_part_sw_rd_en_o: i4, lc_iso_part_sw_wr_en_o: i4, lc_seed_hw_rd_en_o: i4, lc_rma_state_o: i4, lc_keymgr_en_o: i4, lc_escalate_en_o: i4, lc_check_byp_en_o: i4, lc_clk_byp_req_o: i4, lc_nvm_rma_req_o: i4, lc_keymgr_div_o: i128) {sv.namehint = "token_hash_req"}
    llhd.drv %lc_done_d, %u_lc_ctrl_fsm.init_done_o after %3 : i1
    llhd.drv %lc_idle_d, %u_lc_ctrl_fsm.idle_o after %3 : i1
    llhd.drv %ext_clock_switched, %u_lc_ctrl_fsm.ext_clock_switched_o after %3 : i1
    llhd.drv %dec_lc_state, %u_lc_ctrl_fsm.dec_lc_state_o after %3 : !hw.array<6xi5>
    llhd.drv %dec_lc_cnt, %u_lc_ctrl_fsm.dec_lc_cnt_o after %3 : i5
    llhd.drv %dec_lc_id_state, %u_lc_ctrl_fsm.dec_lc_id_state_o after %3 : i2
    llhd.drv %37, %u_lc_ctrl_fsm.otp_prog_req_o after %3 : i1
    llhd.drv %38, %u_lc_ctrl_fsm.otp_prog_lc_state_o after %3 : i320
    llhd.drv %39, %u_lc_ctrl_fsm.otp_prog_lc_cnt_o after %3 : i384
    llhd.drv %trans_success_d, %u_lc_ctrl_fsm.trans_success_o after %3 : i1
    llhd.drv %trans_cnt_oflw_error_d, %u_lc_ctrl_fsm.trans_cnt_oflw_error_o after %3 : i1
    llhd.drv %trans_invalid_error_d, %u_lc_ctrl_fsm.trans_invalid_error_o after %3 : i1
    llhd.drv %token_invalid_error_d, %u_lc_ctrl_fsm.token_invalid_error_o after %3 : i1
    llhd.drv %nvm_rma_error_d, %u_lc_ctrl_fsm.nvm_rma_error_o after %3 : i1
    llhd.drv %otp_prog_error_d, %u_lc_ctrl_fsm.otp_prog_error_o after %3 : i1
    llhd.drv %state_invalid_error_d, %u_lc_ctrl_fsm.state_invalid_error_o after %3 : i1
    %40 = hw.bitcast %u_hw_rev_const.out_o : (i64) -> !hw.struct<silicon_creator_id: i16, product_id: i16, revision_id: i8, reserved: i24>
    llhd.drv %hw_rev_o, %40 after %3 : !hw.struct<silicon_creator_id: i16, product_id: i16, revision_id: i8, reserved: i24>
    %41 = llhd.prb %lc_done_d : i1
    %42 = llhd.prb %lc_idle_d : i1
    %43 = llhd.prb %ext_clock_switched : i1
    %44 = llhd.prb %trans_success_q : i1
    %45 = llhd.prb %trans_cnt_oflw_error_q : i1
    %46 = llhd.prb %trans_invalid_error_q : i1
    %47 = llhd.prb %token_invalid_error_q : i1
    %48 = llhd.prb %nvm_rma_error_q : i1
    %49 = llhd.prb %fatal_prog_error_q : i1
    %50 = llhd.prb %fatal_state_error_q : i1
    %51 = llhd.prb %otp_part_error_q : i1
    %52 = llhd.prb %fatal_bus_integ_error_q : i1
    %53 = llhd.prb %dec_lc_state : !hw.array<6xi5>
    %54 = llhd.prb %dec_lc_cnt : i5
    %55 = llhd.prb %dec_lc_id_state : i2
    %56 = llhd.prb %otp_device_id_i_4 : i256
    %57 = llhd.prb %otp_manuf_state_i_5 : i256
    %58 = llhd.prb %hw_rev_o : !hw.struct<silicon_creator_id: i16, product_id: i16, revision_id: i8, reserved: i24>
    %59 = llhd.prb %tap_dmi_claim_transition_if_q : i8
    %60 = llhd.prb %sw_claim_transition_if_q : i8
    %61 = llhd.prb %otp_vendor_test_ctrl_q : i32
    %62 = llhd.prb %otp_vendor_test_status : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb5
      llhd.drv %hw2reg, %5 after %3 : !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>
      %95 = llhd.sig.struct_extract %hw2reg["status"] : <!hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>>
      %96 = llhd.sig.struct_extract %95["initialized"] : <!hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>>
      %97 = llhd.prb %lc_done_d : i1
      %98 = hw.bitcast %97 : (i1) -> !hw.struct<d: i1>
      llhd.drv %96, %98 after %3 : !hw.struct<d: i1>
      %99 = llhd.sig.struct_extract %95["ready"] : <!hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>>
      %100 = llhd.prb %lc_idle_d : i1
      %101 = hw.bitcast %100 : (i1) -> !hw.struct<d: i1>
      llhd.drv %99, %101 after %3 : !hw.struct<d: i1>
      %102 = llhd.sig.struct_extract %95["ext_clock_switched"] : <!hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>>
      %103 = llhd.prb %ext_clock_switched : i1
      %104 = hw.bitcast %103 : (i1) -> !hw.struct<d: i1>
      llhd.drv %102, %104 after %3 : !hw.struct<d: i1>
      %105 = llhd.sig.struct_extract %95["transition_successful"] : <!hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>>
      %106 = llhd.prb %trans_success_q : i1
      %107 = hw.bitcast %106 : (i1) -> !hw.struct<d: i1>
      llhd.drv %105, %107 after %3 : !hw.struct<d: i1>
      %108 = llhd.sig.struct_extract %95["transition_count_error"] : <!hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>>
      %109 = llhd.prb %trans_cnt_oflw_error_q : i1
      %110 = hw.bitcast %109 : (i1) -> !hw.struct<d: i1>
      llhd.drv %108, %110 after %3 : !hw.struct<d: i1>
      %111 = llhd.sig.struct_extract %95["transition_error"] : <!hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>>
      %112 = llhd.prb %trans_invalid_error_q : i1
      %113 = hw.bitcast %112 : (i1) -> !hw.struct<d: i1>
      llhd.drv %111, %113 after %3 : !hw.struct<d: i1>
      %114 = llhd.sig.struct_extract %95["token_error"] : <!hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>>
      %115 = llhd.prb %token_invalid_error_q : i1
      %116 = hw.bitcast %115 : (i1) -> !hw.struct<d: i1>
      llhd.drv %114, %116 after %3 : !hw.struct<d: i1>
      %117 = llhd.sig.struct_extract %95["nvm_rma_error"] : <!hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>>
      %118 = llhd.prb %nvm_rma_error_q : i1
      %119 = hw.bitcast %118 : (i1) -> !hw.struct<d: i1>
      llhd.drv %117, %119 after %3 : !hw.struct<d: i1>
      %120 = llhd.sig.struct_extract %95["otp_error"] : <!hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>>
      %121 = llhd.prb %fatal_prog_error_q : i1
      %122 = hw.bitcast %121 : (i1) -> !hw.struct<d: i1>
      llhd.drv %120, %122 after %3 : !hw.struct<d: i1>
      %123 = llhd.sig.struct_extract %95["state_error"] : <!hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>>
      %124 = llhd.prb %fatal_state_error_q : i1
      %125 = hw.bitcast %124 : (i1) -> !hw.struct<d: i1>
      llhd.drv %123, %125 after %3 : !hw.struct<d: i1>
      %126 = llhd.sig.struct_extract %95["otp_partition_error"] : <!hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>>
      %127 = llhd.prb %otp_part_error_q : i1
      %128 = hw.bitcast %127 : (i1) -> !hw.struct<d: i1>
      llhd.drv %126, %128 after %3 : !hw.struct<d: i1>
      %129 = llhd.sig.struct_extract %95["bus_integ_error"] : <!hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>>
      %130 = llhd.prb %fatal_bus_integ_error_q : i1
      %131 = hw.bitcast %130 : (i1) -> !hw.struct<d: i1>
      llhd.drv %129, %131 after %3 : !hw.struct<d: i1>
      %132 = llhd.sig.struct_extract %hw2reg["lc_state"] : <!hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>>
      %133 = llhd.prb %dec_lc_state : !hw.array<6xi5>
      %134 = hw.bitcast %133 : (!hw.array<6xi5>) -> !hw.struct<d: i30>
      llhd.drv %132, %134 after %3 : !hw.struct<d: i30>
      %135 = llhd.sig.struct_extract %hw2reg["lc_transition_cnt"] : <!hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>>
      %136 = llhd.prb %dec_lc_cnt : i5
      %137 = hw.bitcast %136 : (i5) -> !hw.struct<d: i5>
      llhd.drv %135, %137 after %3 : !hw.struct<d: i5>
      %138 = llhd.sig.struct_extract %hw2reg["lc_id_state"] : <!hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>>
      %139 = llhd.prb %dec_lc_id_state : i2
      %140 = comb.replicate %139 : (i2) -> i32
      %141 = hw.bitcast %140 : (i32) -> !hw.struct<d: i32>
      llhd.drv %138, %141 after %3 : !hw.struct<d: i32>
      %142 = llhd.sig.struct_extract %hw2reg["device_id"] : <!hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>>
      %143 = llhd.prb %otp_device_id_i_4 : i256
      %144 = hw.bitcast %143 : (i256) -> !hw.array<8xstruct<d: i32>>
      llhd.drv %142, %144 after %3 : !hw.array<8xstruct<d: i32>>
      %145 = llhd.sig.struct_extract %hw2reg["manuf_state"] : <!hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>>
      %146 = llhd.prb %otp_manuf_state_i_5 : i256
      %147 = hw.bitcast %146 : (i256) -> !hw.array<8xstruct<d: i32>>
      llhd.drv %145, %147 after %3 : !hw.array<8xstruct<d: i32>>
      %148 = llhd.sig.struct_extract %hw2reg["hw_revision0"] : <!hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>>
      %149 = llhd.sig.struct_extract %148["silicon_creator_id"] : <!hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>>
      %150 = llhd.prb %hw_rev_o : !hw.struct<silicon_creator_id: i16, product_id: i16, revision_id: i8, reserved: i24>
      %silicon_creator_id = hw.struct_extract %150["silicon_creator_id"] : !hw.struct<silicon_creator_id: i16, product_id: i16, revision_id: i8, reserved: i24>
      %151 = hw.bitcast %silicon_creator_id : (i16) -> !hw.struct<d: i16>
      llhd.drv %149, %151 after %3 : !hw.struct<d: i16>
      %152 = llhd.sig.struct_extract %148["product_id"] : <!hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>>
      %153 = llhd.prb %hw_rev_o : !hw.struct<silicon_creator_id: i16, product_id: i16, revision_id: i8, reserved: i24>
      %product_id = hw.struct_extract %153["product_id"] : !hw.struct<silicon_creator_id: i16, product_id: i16, revision_id: i8, reserved: i24>
      %154 = hw.bitcast %product_id : (i16) -> !hw.struct<d: i16>
      llhd.drv %152, %154 after %3 : !hw.struct<d: i16>
      %155 = llhd.sig.struct_extract %hw2reg["hw_revision1"] : <!hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>>
      %156 = llhd.sig.struct_extract %155["revision_id"] : <!hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>>
      %157 = llhd.prb %hw_rev_o : !hw.struct<silicon_creator_id: i16, product_id: i16, revision_id: i8, reserved: i24>
      %revision_id = hw.struct_extract %157["revision_id"] : !hw.struct<silicon_creator_id: i16, product_id: i16, revision_id: i8, reserved: i24>
      %158 = hw.bitcast %revision_id : (i8) -> !hw.struct<d: i8>
      llhd.drv %156, %158 after %3 : !hw.struct<d: i8>
      %159 = llhd.sig.struct_extract %155["reserved"] : <!hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>>
      llhd.drv %159, %0 after %3 : !hw.struct<d: i24>
      %160 = llhd.prb %hw2reg : !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>
      llhd.drv %tap_dmi_hw2reg, %160 after %3 : !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>
      %161 = llhd.sig.struct_extract %tap_dmi_hw2reg["claim_transition_if"] : <!hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>>
      %162 = llhd.prb %tap_dmi_claim_transition_if_q : i8
      %163 = hw.bitcast %162 : (i8) -> !hw.struct<d: i8>
      llhd.drv %161, %163 after %3 : !hw.struct<d: i8>
      %164 = llhd.sig.struct_extract %hw2reg["claim_transition_if"] : <!hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>>
      %165 = llhd.prb %sw_claim_transition_if_q : i8
      %166 = hw.bitcast %165 : (i8) -> !hw.struct<d: i8>
      llhd.drv %164, %166 after %3 : !hw.struct<d: i8>
      %167 = llhd.prb %tap_dmi_claim_transition_if_q : i8
      %168 = func.call @"prim_mubi_pkg::mubi8_test_true_strict"(%167) : (i8) -> i1
      cf.cond_br %168, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %169 = llhd.sig.struct_extract %tap_dmi_hw2reg["transition_ctrl"] : <!hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>>
      %170 = llhd.sig.struct_extract %169["ext_clock_en"] : <!hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>>
      %171 = llhd.prb %use_ext_clock_q : i1
      %172 = hw.bitcast %171 : (i1) -> !hw.struct<d: i1>
      llhd.drv %170, %172 after %3 : !hw.struct<d: i1>
      %173 = llhd.sig.struct_extract %169["volatile_raw_unlock"] : <!hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>>
      %174 = llhd.prb %volatile_raw_unlock_q : i1
      %175 = hw.bitcast %174 : (i1) -> !hw.struct<d: i1>
      llhd.drv %173, %175 after %3 : !hw.struct<d: i1>
      %176 = llhd.sig.struct_extract %tap_dmi_hw2reg["transition_token"] : <!hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>>
      %177 = llhd.prb %transition_token_q : i128
      %178 = hw.bitcast %177 : (i128) -> !hw.array<4xstruct<d: i32>>
      llhd.drv %176, %178 after %3 : !hw.array<4xstruct<d: i32>>
      %179 = llhd.sig.struct_extract %tap_dmi_hw2reg["transition_target"] : <!hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>>
      %180 = llhd.prb %transition_target_q : !hw.array<6xi5>
      %181 = hw.bitcast %180 : (!hw.array<6xi5>) -> !hw.struct<d: i30>
      llhd.drv %179, %181 after %3 : !hw.struct<d: i30>
      %182 = llhd.sig.struct_extract %tap_dmi_hw2reg["transition_regwen"] : <!hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>>
      %183 = llhd.prb %lc_idle_d : i1
      %184 = hw.bitcast %183 : (i1) -> !hw.struct<d: i1>
      llhd.drv %182, %184 after %3 : !hw.struct<d: i1>
      %185 = llhd.sig.struct_extract %tap_dmi_hw2reg["otp_vendor_test_ctrl"] : <!hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>>
      %186 = llhd.prb %otp_vendor_test_ctrl_q : i32
      %187 = hw.bitcast %186 : (i32) -> !hw.struct<d: i32>
      llhd.drv %185, %187 after %3 : !hw.struct<d: i32>
      %188 = llhd.sig.struct_extract %tap_dmi_hw2reg["otp_vendor_test_status"] : <!hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>>
      %189 = llhd.prb %otp_vendor_test_status : i32
      %190 = hw.bitcast %189 : (i32) -> !hw.struct<d: i32>
      llhd.drv %188, %190 after %3 : !hw.struct<d: i32>
      cf.br ^bb5
    ^bb3:  // pred: ^bb1
      %191 = llhd.prb %sw_claim_transition_if_q : i8
      %192 = func.call @"prim_mubi_pkg::mubi8_test_true_strict"(%191) : (i8) -> i1
      cf.cond_br %192, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %193 = llhd.sig.struct_extract %hw2reg["transition_ctrl"] : <!hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>>
      %194 = llhd.sig.struct_extract %193["ext_clock_en"] : <!hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>>
      %195 = llhd.prb %use_ext_clock_q : i1
      %196 = hw.bitcast %195 : (i1) -> !hw.struct<d: i1>
      llhd.drv %194, %196 after %3 : !hw.struct<d: i1>
      %197 = llhd.sig.struct_extract %193["volatile_raw_unlock"] : <!hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>>
      %198 = llhd.prb %volatile_raw_unlock_q : i1
      %199 = hw.bitcast %198 : (i1) -> !hw.struct<d: i1>
      llhd.drv %197, %199 after %3 : !hw.struct<d: i1>
      %200 = llhd.sig.struct_extract %hw2reg["transition_token"] : <!hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>>
      %201 = llhd.prb %transition_token_q : i128
      %202 = hw.bitcast %201 : (i128) -> !hw.array<4xstruct<d: i32>>
      llhd.drv %200, %202 after %3 : !hw.array<4xstruct<d: i32>>
      %203 = llhd.sig.struct_extract %hw2reg["transition_target"] : <!hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>>
      %204 = llhd.prb %transition_target_q : !hw.array<6xi5>
      %205 = hw.bitcast %204 : (!hw.array<6xi5>) -> !hw.struct<d: i30>
      llhd.drv %203, %205 after %3 : !hw.struct<d: i30>
      %206 = llhd.sig.struct_extract %hw2reg["transition_regwen"] : <!hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>>
      %207 = llhd.prb %lc_idle_d : i1
      %208 = hw.bitcast %207 : (i1) -> !hw.struct<d: i1>
      llhd.drv %206, %208 after %3 : !hw.struct<d: i1>
      %209 = llhd.sig.struct_extract %hw2reg["otp_vendor_test_ctrl"] : <!hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>>
      %210 = llhd.prb %otp_vendor_test_ctrl_q : i32
      %211 = hw.bitcast %210 : (i32) -> !hw.struct<d: i32>
      llhd.drv %209, %211 after %3 : !hw.struct<d: i32>
      %212 = llhd.sig.struct_extract %hw2reg["otp_vendor_test_status"] : <!hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>>
      %213 = llhd.prb %otp_vendor_test_status : i32
      %214 = hw.bitcast %213 : (i32) -> !hw.struct<d: i32>
      llhd.drv %212, %214 after %3 : !hw.struct<d: i32>
      cf.br ^bb5
    ^bb5:  // 3 preds: ^bb2, ^bb3, ^bb4
      llhd.wait (%16, %41, %42, %43, %44, %45, %46, %47, %48, %49, %50, %51, %52, %53, %54, %55, %56, %57, %58, %17, %59, %60, %33, %34, %31, %36, %61, %62 : !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, !hw.array<6xi5>, i5, i2, i256, i256, !hw.struct<silicon_creator_id: i16, product_id: i16, revision_id: i8, reserved: i24>, !hw.struct<status: !hw.struct<otp_partition_error: !hw.struct<d: i1>, bus_integ_error: !hw.struct<d: i1>, state_error: !hw.struct<d: i1>, otp_error: !hw.struct<d: i1>, nvm_rma_error: !hw.struct<d: i1>, token_error: !hw.struct<d: i1>, transition_error: !hw.struct<d: i1>, transition_count_error: !hw.struct<d: i1>, transition_successful: !hw.struct<d: i1>, ext_clock_switched: !hw.struct<d: i1>, ready: !hw.struct<d: i1>, initialized: !hw.struct<d: i1>>, claim_transition_if: !hw.struct<d: i8>, transition_regwen: !hw.struct<d: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<d: i1>, ext_clock_en: !hw.struct<d: i1>>, transition_token: !hw.array<4xstruct<d: i32>>, transition_target: !hw.struct<d: i30>, otp_vendor_test_ctrl: !hw.struct<d: i32>, otp_vendor_test_status: !hw.struct<d: i32>, lc_state: !hw.struct<d: i30>, lc_transition_cnt: !hw.struct<d: i5>, lc_id_state: !hw.struct<d: i32>, hw_revision0: !hw.struct<silicon_creator_id: !hw.struct<d: i16>, product_id: !hw.struct<d: i16>>, hw_revision1: !hw.struct<reserved: !hw.struct<d: i24>, revision_id: !hw.struct<d: i8>>, device_id: !hw.array<8xstruct<d: i32>>, manuf_state: !hw.array<8xstruct<d: i32>>>, i8, i8, i1, i1, i128, !hw.array<6xi5>, i32, i32), ^bb1
    }
    %63 = llhd.prb %sw_claim_transition_if_d : i8
    %64 = llhd.prb %tap_dmi_claim_transition_if_d : i8
    %65 = llhd.prb %transition_token_d : i128
    %66 = llhd.prb %transition_target_d : !hw.array<6xi5>
    %67 = llhd.prb %otp_vendor_test_ctrl_d : i32
    %68 = llhd.prb %use_ext_clock_d : i1
    %69 = llhd.prb %volatile_raw_unlock_d : i1
    %70 = llhd.prb %tap_dmi_reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
    %71 = llhd.prb %reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb34
      %95 = llhd.prb %sw_claim_transition_if_q : i8
      llhd.drv %sw_claim_transition_if_d, %95 after %3 : i8
      %96 = llhd.prb %tap_dmi_claim_transition_if_q : i8
      llhd.drv %tap_dmi_claim_transition_if_d, %96 after %3 : i8
      %97 = llhd.prb %transition_token_q : i128
      llhd.drv %transition_token_d, %97 after %3 : i128
      %98 = llhd.prb %transition_target_q : !hw.array<6xi5>
      llhd.drv %transition_target_d, %98 after %3 : !hw.array<6xi5>
      llhd.drv %transition_cmd, %false after %3 : i1
      %99 = llhd.prb %otp_vendor_test_ctrl_q : i32
      llhd.drv %otp_vendor_test_ctrl_d, %99 after %3 : i32
      %100 = llhd.prb %use_ext_clock_q : i1
      llhd.drv %use_ext_clock_d, %100 after %3 : i1
      %101 = llhd.prb %volatile_raw_unlock_q : i1
      llhd.drv %volatile_raw_unlock_d, %101 after %3 : i1
      %102 = llhd.prb %sw_claim_transition_if_q : i8
      %103 = func.call @"prim_mubi_pkg::mubi8_test_false_loose"(%102) : (i8) -> i1
      %104 = llhd.prb %tap_dmi_reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %claim_transition_if = hw.struct_extract %104["claim_transition_if"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %qe_20 = hw.struct_extract %claim_transition_if["qe"] : !hw.struct<q: i8, qe: i1>
      %105 = comb.and %103, %qe_20 : i1
      cf.cond_br %105, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %106 = llhd.prb %tap_dmi_reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %claim_transition_if_21 = hw.struct_extract %106["claim_transition_if"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %q_22 = hw.struct_extract %claim_transition_if_21["q"] : !hw.struct<q: i8, qe: i1>
      llhd.drv %tap_dmi_claim_transition_if_d, %q_22 after %3 : i8
      cf.br ^bb5
    ^bb3:  // pred: ^bb1
      %107 = llhd.prb %tap_dmi_claim_transition_if_q : i8
      %108 = func.call @"prim_mubi_pkg::mubi8_test_false_loose"(%107) : (i8) -> i1
      %109 = llhd.prb %reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %claim_transition_if_23 = hw.struct_extract %109["claim_transition_if"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %qe_24 = hw.struct_extract %claim_transition_if_23["qe"] : !hw.struct<q: i8, qe: i1>
      %110 = comb.and %108, %qe_24 : i1
      cf.cond_br %110, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %111 = llhd.prb %reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %claim_transition_if_25 = hw.struct_extract %111["claim_transition_if"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %q_26 = hw.struct_extract %claim_transition_if_25["q"] : !hw.struct<q: i8, qe: i1>
      llhd.drv %sw_claim_transition_if_d, %q_26 after %3 : i8
      cf.br ^bb5
    ^bb5:  // 3 preds: ^bb2, ^bb3, ^bb4
      %112 = llhd.prb %lc_idle_d : i1
      cf.cond_br %112, ^bb6, ^bb34
    ^bb6:  // pred: ^bb5
      %113 = llhd.prb %tap_dmi_claim_transition_if_q : i8
      %114 = func.call @"prim_mubi_pkg::mubi8_test_true_strict"(%113) : (i8) -> i1
      cf.cond_br %114, ^bb7, ^bb20
    ^bb7:  // pred: ^bb6
      %115 = llhd.prb %tap_dmi_reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %transition_cmd_27 = hw.struct_extract %115["transition_cmd"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %q_28 = hw.struct_extract %transition_cmd_27["q"] : !hw.struct<q: i1, qe: i1>
      %qe_29 = hw.struct_extract %transition_cmd_27["qe"] : !hw.struct<q: i1, qe: i1>
      %116 = comb.and %q_28, %qe_29 : i1
      llhd.drv %transition_cmd, %116 after %3 : i1
      %117 = llhd.prb %tap_dmi_reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %transition_ctrl = hw.struct_extract %117["transition_ctrl"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %ext_clock_en = hw.struct_extract %transition_ctrl["ext_clock_en"] : !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>
      %qe_30 = hw.struct_extract %ext_clock_en["qe"] : !hw.struct<q: i1, qe: i1>
      cf.cond_br %qe_30, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %118 = llhd.prb %use_ext_clock_d : i1
      %119 = llhd.prb %tap_dmi_reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %transition_ctrl_31 = hw.struct_extract %119["transition_ctrl"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %ext_clock_en_32 = hw.struct_extract %transition_ctrl_31["ext_clock_en"] : !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>
      %q_33 = hw.struct_extract %ext_clock_en_32["q"] : !hw.struct<q: i1, qe: i1>
      %120 = comb.or %118, %q_33 : i1
      llhd.drv %use_ext_clock_d, %120 after %3 : i1
      cf.br ^bb9
    ^bb9:  // 2 preds: ^bb7, ^bb8
      %121 = llhd.prb %tap_dmi_reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %transition_ctrl_34 = hw.struct_extract %121["transition_ctrl"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %volatile_raw_unlock = hw.struct_extract %transition_ctrl_34["volatile_raw_unlock"] : !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>
      %qe_35 = hw.struct_extract %volatile_raw_unlock["qe"] : !hw.struct<q: i1, qe: i1>
      cf.cond_br %qe_35, ^bb10, ^bb11(%c0_i32 : i32)
    ^bb10:  // pred: ^bb9
      %122 = llhd.prb %tap_dmi_reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %transition_ctrl_36 = hw.struct_extract %122["transition_ctrl"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %volatile_raw_unlock_37 = hw.struct_extract %transition_ctrl_36["volatile_raw_unlock"] : !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>
      %q_38 = hw.struct_extract %volatile_raw_unlock_37["q"] : !hw.struct<q: i1, qe: i1>
      llhd.drv %volatile_raw_unlock_d, %q_38 after %3 : i1
      cf.br ^bb11(%c0_i32 : i32)
    ^bb11(%123: i32):  // 3 preds: ^bb9, ^bb10, ^bb14
      %124 = comb.icmp slt %123, %c4_i32 : i32
      cf.cond_br %124, ^bb12, ^bb15
    ^bb12:  // pred: ^bb11
      %125 = llhd.prb %tap_dmi_reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %transition_token = hw.struct_extract %125["transition_token"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %126 = comb.extract %123 from 2 : (i32) -> i30
      %127 = comb.icmp eq %126, %c0_i30 : i30
      %128 = comb.extract %123 from 0 : (i32) -> i2
      %129 = comb.mux %127, %128, %c-1_i2 : i2
      %130 = hw.array_get %transition_token[%129] : !hw.array<4xstruct<q: i32, qe: i1>>, i2
      %qe_39 = hw.struct_extract %130["qe"] : !hw.struct<q: i32, qe: i1>
      cf.cond_br %qe_39, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      %131 = comb.extract %123 from 2 : (i32) -> i25
      %132 = comb.icmp eq %131, %c0_i25 : i25
      %133 = comb.extract %123 from 0 : (i32) -> i2
      %134 = comb.concat %133, %c0_i5 : i2, i5
      %135 = comb.mux %132, %134, %c-1_i7 : i7
      %136 = llhd.sig.extract %transition_token_d from %135 : <i128> -> <i32>
      %137 = llhd.prb %tap_dmi_reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %transition_token_40 = hw.struct_extract %137["transition_token"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %138 = hw.array_get %transition_token_40[%129] : !hw.array<4xstruct<q: i32, qe: i1>>, i2
      %q_41 = hw.struct_extract %138["q"] : !hw.struct<q: i32, qe: i1>
      llhd.drv %136, %q_41 after %3 : i32
      cf.br ^bb14
    ^bb14:  // 2 preds: ^bb12, ^bb13
      %139 = comb.add %123, %c1_i32 : i32
      cf.br ^bb11(%139 : i32)
    ^bb15:  // pred: ^bb11
      %140 = llhd.prb %tap_dmi_reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %transition_target = hw.struct_extract %140["transition_target"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %qe_42 = hw.struct_extract %transition_target["qe"] : !hw.struct<q: i30, qe: i1>
      cf.cond_br %qe_42, ^bb16(%c0_i32 : i32), ^bb18
    ^bb16(%141: i32):  // 2 preds: ^bb15, ^bb17
      %142 = comb.icmp slt %141, %c6_i32 : i32
      cf.cond_br %142, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      %143 = comb.extract %141 from 3 : (i32) -> i29
      %144 = comb.icmp eq %143, %c0_i29 : i29
      %145 = comb.extract %141 from 0 : (i32) -> i3
      %146 = comb.mux %144, %145, %c-1_i3 : i3
      %147 = llhd.sig.array_get %transition_target_d[%146] : <!hw.array<6xi5>>
      %148 = llhd.prb %tap_dmi_reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %transition_target_43 = hw.struct_extract %148["transition_target"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %q_44 = hw.struct_extract %transition_target_43["q"] : !hw.struct<q: i30, qe: i1>
      %149 = comb.mul %141, %c5_i32 : i32
      %150 = comb.extract %149 from 30 : (i32) -> i2
      %151 = comb.icmp eq %150, %c0_i2 : i2
      %152 = comb.extract %149 from 0 : (i32) -> i30
      %153 = comb.mux %151, %152, %c-1_i30 : i30
      %154 = comb.shru %q_44, %153 : i30
      %155 = comb.extract %154 from 0 : (i30) -> i5
      llhd.drv %147, %155 after %3 : i5
      %156 = comb.add %141, %c1_i32 : i32
      cf.br ^bb16(%156 : i32)
    ^bb18:  // 2 preds: ^bb15, ^bb16
      %157 = llhd.prb %tap_dmi_reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %otp_vendor_test_ctrl = hw.struct_extract %157["otp_vendor_test_ctrl"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %qe_45 = hw.struct_extract %otp_vendor_test_ctrl["qe"] : !hw.struct<q: i32, qe: i1>
      cf.cond_br %qe_45, ^bb19, ^bb34
    ^bb19:  // pred: ^bb18
      %158 = llhd.prb %tap_dmi_reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %otp_vendor_test_ctrl_46 = hw.struct_extract %158["otp_vendor_test_ctrl"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %q_47 = hw.struct_extract %otp_vendor_test_ctrl_46["q"] : !hw.struct<q: i32, qe: i1>
      llhd.drv %otp_vendor_test_ctrl_d, %q_47 after %3 : i32
      cf.br ^bb34
    ^bb20:  // pred: ^bb6
      %159 = llhd.prb %sw_claim_transition_if_q : i8
      %160 = func.call @"prim_mubi_pkg::mubi8_test_true_strict"(%159) : (i8) -> i1
      cf.cond_br %160, ^bb21, ^bb34
    ^bb21:  // pred: ^bb20
      %161 = llhd.prb %reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %transition_cmd_48 = hw.struct_extract %161["transition_cmd"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %q_49 = hw.struct_extract %transition_cmd_48["q"] : !hw.struct<q: i1, qe: i1>
      %qe_50 = hw.struct_extract %transition_cmd_48["qe"] : !hw.struct<q: i1, qe: i1>
      %162 = comb.and %q_49, %qe_50 : i1
      llhd.drv %transition_cmd, %162 after %3 : i1
      %163 = llhd.prb %reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %transition_ctrl_51 = hw.struct_extract %163["transition_ctrl"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %ext_clock_en_52 = hw.struct_extract %transition_ctrl_51["ext_clock_en"] : !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>
      %qe_53 = hw.struct_extract %ext_clock_en_52["qe"] : !hw.struct<q: i1, qe: i1>
      cf.cond_br %qe_53, ^bb22, ^bb23
    ^bb22:  // pred: ^bb21
      %164 = llhd.prb %use_ext_clock_d : i1
      %165 = llhd.prb %reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %transition_ctrl_54 = hw.struct_extract %165["transition_ctrl"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %ext_clock_en_55 = hw.struct_extract %transition_ctrl_54["ext_clock_en"] : !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>
      %q_56 = hw.struct_extract %ext_clock_en_55["q"] : !hw.struct<q: i1, qe: i1>
      %166 = comb.or %164, %q_56 : i1
      llhd.drv %use_ext_clock_d, %166 after %3 : i1
      cf.br ^bb23
    ^bb23:  // 2 preds: ^bb21, ^bb22
      %167 = llhd.prb %reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %transition_ctrl_57 = hw.struct_extract %167["transition_ctrl"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %volatile_raw_unlock_58 = hw.struct_extract %transition_ctrl_57["volatile_raw_unlock"] : !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>
      %qe_59 = hw.struct_extract %volatile_raw_unlock_58["qe"] : !hw.struct<q: i1, qe: i1>
      cf.cond_br %qe_59, ^bb24, ^bb25(%c0_i32 : i32)
    ^bb24:  // pred: ^bb23
      %168 = llhd.prb %reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %transition_ctrl_60 = hw.struct_extract %168["transition_ctrl"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %volatile_raw_unlock_61 = hw.struct_extract %transition_ctrl_60["volatile_raw_unlock"] : !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>
      %q_62 = hw.struct_extract %volatile_raw_unlock_61["q"] : !hw.struct<q: i1, qe: i1>
      llhd.drv %volatile_raw_unlock_d, %q_62 after %3 : i1
      cf.br ^bb25(%c0_i32 : i32)
    ^bb25(%169: i32):  // 3 preds: ^bb23, ^bb24, ^bb28
      %170 = comb.icmp slt %169, %c4_i32 : i32
      cf.cond_br %170, ^bb26, ^bb29
    ^bb26:  // pred: ^bb25
      %171 = llhd.prb %reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %transition_token_63 = hw.struct_extract %171["transition_token"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %172 = comb.extract %169 from 2 : (i32) -> i30
      %173 = comb.icmp eq %172, %c0_i30 : i30
      %174 = comb.extract %169 from 0 : (i32) -> i2
      %175 = comb.mux %173, %174, %c-1_i2 : i2
      %176 = hw.array_get %transition_token_63[%175] : !hw.array<4xstruct<q: i32, qe: i1>>, i2
      %qe_64 = hw.struct_extract %176["qe"] : !hw.struct<q: i32, qe: i1>
      cf.cond_br %qe_64, ^bb27, ^bb28
    ^bb27:  // pred: ^bb26
      %177 = comb.extract %169 from 2 : (i32) -> i25
      %178 = comb.icmp eq %177, %c0_i25 : i25
      %179 = comb.extract %169 from 0 : (i32) -> i2
      %180 = comb.concat %179, %c0_i5 : i2, i5
      %181 = comb.mux %178, %180, %c-1_i7 : i7
      %182 = llhd.sig.extract %transition_token_d from %181 : <i128> -> <i32>
      %183 = llhd.prb %reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %transition_token_65 = hw.struct_extract %183["transition_token"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %184 = hw.array_get %transition_token_65[%175] : !hw.array<4xstruct<q: i32, qe: i1>>, i2
      %q_66 = hw.struct_extract %184["q"] : !hw.struct<q: i32, qe: i1>
      llhd.drv %182, %q_66 after %3 : i32
      cf.br ^bb28
    ^bb28:  // 2 preds: ^bb26, ^bb27
      %185 = comb.add %169, %c1_i32 : i32
      cf.br ^bb25(%185 : i32)
    ^bb29:  // pred: ^bb25
      %186 = llhd.prb %reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %transition_target_67 = hw.struct_extract %186["transition_target"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %qe_68 = hw.struct_extract %transition_target_67["qe"] : !hw.struct<q: i30, qe: i1>
      cf.cond_br %qe_68, ^bb30(%c0_i32 : i32), ^bb32
    ^bb30(%187: i32):  // 2 preds: ^bb29, ^bb31
      %188 = comb.icmp slt %187, %c6_i32 : i32
      cf.cond_br %188, ^bb31, ^bb32
    ^bb31:  // pred: ^bb30
      %189 = comb.extract %187 from 3 : (i32) -> i29
      %190 = comb.icmp eq %189, %c0_i29 : i29
      %191 = comb.extract %187 from 0 : (i32) -> i3
      %192 = comb.mux %190, %191, %c-1_i3 : i3
      %193 = llhd.sig.array_get %transition_target_d[%192] : <!hw.array<6xi5>>
      %194 = llhd.prb %reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %transition_target_69 = hw.struct_extract %194["transition_target"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %q_70 = hw.struct_extract %transition_target_69["q"] : !hw.struct<q: i30, qe: i1>
      %195 = comb.mul %187, %c5_i32 : i32
      %196 = comb.extract %195 from 30 : (i32) -> i2
      %197 = comb.icmp eq %196, %c0_i2 : i2
      %198 = comb.extract %195 from 0 : (i32) -> i30
      %199 = comb.mux %197, %198, %c-1_i30 : i30
      %200 = comb.shru %q_70, %199 : i30
      %201 = comb.extract %200 from 0 : (i30) -> i5
      llhd.drv %193, %201 after %3 : i5
      %202 = comb.add %187, %c1_i32 : i32
      cf.br ^bb30(%202 : i32)
    ^bb32:  // 2 preds: ^bb29, ^bb30
      %203 = llhd.prb %reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %otp_vendor_test_ctrl_71 = hw.struct_extract %203["otp_vendor_test_ctrl"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %qe_72 = hw.struct_extract %otp_vendor_test_ctrl_71["qe"] : !hw.struct<q: i32, qe: i1>
      cf.cond_br %qe_72, ^bb33, ^bb34
    ^bb33:  // pred: ^bb32
      %204 = llhd.prb %reg2hw : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %otp_vendor_test_ctrl_73 = hw.struct_extract %204["otp_vendor_test_ctrl"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
      %q_74 = hw.struct_extract %otp_vendor_test_ctrl_73["q"] : !hw.struct<q: i32, qe: i1>
      llhd.drv %otp_vendor_test_ctrl_d, %q_74 after %3 : i32
      cf.br ^bb34
    ^bb34:  // 6 preds: ^bb5, ^bb18, ^bb19, ^bb20, ^bb32, ^bb33
      llhd.wait (%60, %63, %59, %64, %31, %65, %36, %66, %35, %61, %67, %33, %68, %34, %69, %70, %42, %71 : i8, i8, i8, i8, i128, i128, !hw.array<6xi5>, !hw.array<6xi5>, i1, i32, i32, i1, i1, i1, i1, !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>, i1, !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %95 = llhd.prb %clk_i_0 : i1
      %96 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%14, %15 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %97 = llhd.prb %clk_i_0 : i1
      %98 = comb.xor bin %95, %true : i1
      %99 = comb.and bin %98, %97 : i1
      %100 = llhd.prb %rst_ni_1 : i1
      %101 = comb.xor bin %100, %true : i1
      %102 = comb.and bin %96, %101 : i1
      %103 = comb.or bin %99, %102 : i1
      cf.cond_br %103, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %104 = llhd.prb %rst_ni_1 : i1
      %105 = comb.xor %104, %true : i1
      cf.cond_br %105, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %trans_success_q, %false after %2 : i1
      llhd.drv %trans_cnt_oflw_error_q, %false after %2 : i1
      llhd.drv %trans_invalid_error_q, %false after %2 : i1
      llhd.drv %token_invalid_error_q, %false after %2 : i1
      llhd.drv %nvm_rma_error_q, %false after %2 : i1
      llhd.drv %fatal_prog_error_q, %false after %2 : i1
      llhd.drv %fatal_state_error_q, %false after %2 : i1
      llhd.drv %sw_claim_transition_if_q, %c105_i8 after %2 : i8
      llhd.drv %tap_dmi_claim_transition_if_q, %c105_i8 after %2 : i8
      llhd.drv %transition_token_q, %c0_i128 after %2 : i128
      llhd.drv %transition_target_q, %4 after %2 : !hw.array<6xi5>
      llhd.drv %otp_part_error_q, %false after %2 : i1
      llhd.drv %fatal_bus_integ_error_q, %false after %2 : i1
      llhd.drv %otp_vendor_test_ctrl_q, %c0_i32 after %2 : i32
      llhd.drv %use_ext_clock_q, %false after %2 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %106 = llhd.prb %trans_success_d : i1
      %107 = llhd.prb %trans_success_q : i1
      %108 = comb.or %106, %107 : i1
      llhd.drv %trans_success_q, %108 after %2 : i1
      %109 = llhd.prb %trans_cnt_oflw_error_d : i1
      %110 = llhd.prb %trans_cnt_oflw_error_q : i1
      %111 = comb.or %109, %110 : i1
      llhd.drv %trans_cnt_oflw_error_q, %111 after %2 : i1
      %112 = llhd.prb %trans_invalid_error_d : i1
      %113 = llhd.prb %trans_invalid_error_q : i1
      %114 = comb.or %112, %113 : i1
      llhd.drv %trans_invalid_error_q, %114 after %2 : i1
      %115 = llhd.prb %token_invalid_error_d : i1
      %116 = llhd.prb %token_invalid_error_q : i1
      %117 = comb.or %115, %116 : i1
      llhd.drv %token_invalid_error_q, %117 after %2 : i1
      %118 = llhd.prb %nvm_rma_error_d : i1
      %119 = llhd.prb %nvm_rma_error_q : i1
      %120 = comb.or %118, %119 : i1
      llhd.drv %nvm_rma_error_q, %120 after %2 : i1
      %121 = llhd.prb %otp_prog_error_d : i1
      %122 = llhd.prb %fatal_prog_error_q : i1
      %123 = comb.or %121, %122 : i1
      llhd.drv %fatal_prog_error_q, %123 after %2 : i1
      %124 = llhd.prb %state_invalid_error_d : i1
      %125 = llhd.prb %fatal_state_error_q : i1
      %126 = comb.or %124, %125 : i1
      llhd.drv %fatal_state_error_q, %126 after %2 : i1
      %127 = llhd.prb %otp_lc_data_i_3 : !hw.struct<valid: i1, error: i1, state: i320, count: i384, secrets_valid: i4, test_tokens_valid: i4, test_unlock_token: i128, test_exit_token: i128, rma_token_valid: i4, rma_token: i128>
      %error = hw.struct_extract %127["error"] : !hw.struct<valid: i1, error: i1, state: i320, count: i384, secrets_valid: i4, test_tokens_valid: i4, test_unlock_token: i128, test_exit_token: i128, rma_token_valid: i4, rma_token: i128>
      %128 = llhd.prb %otp_part_error_q : i1
      %129 = comb.or %error, %128 : i1
      llhd.drv %otp_part_error_q, %129 after %2 : i1
      %130 = llhd.prb %fatal_bus_integ_error_csr_d : i1
      %131 = llhd.prb %fatal_bus_integ_error_tap_dmi_d : i1
      %132 = llhd.prb %fatal_bus_integ_error_q : i1
      %133 = comb.or %130, %131, %132 : i1
      llhd.drv %fatal_bus_integ_error_q, %133 after %2 : i1
      %134 = llhd.prb %sw_claim_transition_if_d : i8
      llhd.drv %sw_claim_transition_if_q, %134 after %2 : i8
      %135 = llhd.prb %tap_dmi_claim_transition_if_d : i8
      llhd.drv %tap_dmi_claim_transition_if_q, %135 after %2 : i8
      %136 = llhd.prb %transition_token_d : i128
      llhd.drv %transition_token_q, %136 after %2 : i128
      %137 = llhd.prb %transition_target_d : !hw.array<6xi5>
      llhd.drv %transition_target_q, %137 after %2 : !hw.array<6xi5>
      %138 = llhd.prb %otp_vendor_test_ctrl_d : i32
      llhd.drv %otp_vendor_test_ctrl_q, %138 after %2 : i32
      %139 = llhd.prb %use_ext_clock_d : i1
      llhd.drv %use_ext_clock_q, %139 after %2 : i1
      cf.br ^bb1
    }
    llhd.drv %volatile_raw_unlock_q, %false after %3 : i1
    %72 = comb.extract %31 from 0 : (i128) -> i32
    %73 = llhd.sig.struct_extract %lc_otp_vendor_test_o["ctrl"] : <!hw.struct<ctrl: i32>>
    %74 = hw.array_get %u_prim_lc_sync.lc_en_o[%false] : !hw.array<2xi4>, i1
    %75 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%74) : (i4) -> i1
    %76 = comb.mux %75, %61, %c0_i32 : i32
    llhd.drv %73, %76 after %3 : i32
    %77 = hw.array_get %u_prim_lc_sync.lc_en_o[%true] : !hw.array<2xi4>, i1
    %78 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%77) : (i4) -> i1
    %79 = llhd.prb %lc_otp_vendor_test_i_2 : !hw.struct<status: i32>
    %status = hw.struct_extract %79["status"] : !hw.struct<status: i32>
    %80 = comb.mux %78, %status, %c0_i32 : i32
    llhd.drv %otp_vendor_test_status, %80 after %3 : i32
    %alert_test = hw.struct_extract %71["alert_test"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
    %fatal_bus_integ_error = hw.struct_extract %alert_test["fatal_bus_integ_error"] : !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>
    %q = hw.struct_extract %fatal_bus_integ_error["q"] : !hw.struct<q: i1, qe: i1>
    %qe = hw.struct_extract %fatal_bus_integ_error["qe"] : !hw.struct<q: i1, qe: i1>
    %81 = comb.and %q, %qe : i1
    %fatal_state_error = hw.struct_extract %alert_test["fatal_state_error"] : !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>
    %q_6 = hw.struct_extract %fatal_state_error["q"] : !hw.struct<q: i1, qe: i1>
    %qe_7 = hw.struct_extract %fatal_state_error["qe"] : !hw.struct<q: i1, qe: i1>
    %82 = comb.and %q_6, %qe_7 : i1
    %fatal_prog_error = hw.struct_extract %alert_test["fatal_prog_error"] : !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>
    %q_8 = hw.struct_extract %fatal_prog_error["q"] : !hw.struct<q: i1, qe: i1>
    %qe_9 = hw.struct_extract %fatal_prog_error["qe"] : !hw.struct<q: i1, qe: i1>
    %83 = comb.and %q_8, %qe_9 : i1
    %alert_test_10 = hw.struct_extract %70["alert_test"] : !hw.struct<alert_test: !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>, claim_transition_if: !hw.struct<q: i8, qe: i1>, transition_cmd: !hw.struct<q: i1, qe: i1>, transition_ctrl: !hw.struct<volatile_raw_unlock: !hw.struct<q: i1, qe: i1>, ext_clock_en: !hw.struct<q: i1, qe: i1>>, transition_token: !hw.array<4xstruct<q: i32, qe: i1>>, transition_target: !hw.struct<q: i30, qe: i1>, otp_vendor_test_ctrl: !hw.struct<q: i32, qe: i1>>
    %fatal_bus_integ_error_11 = hw.struct_extract %alert_test_10["fatal_bus_integ_error"] : !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>
    %q_12 = hw.struct_extract %fatal_bus_integ_error_11["q"] : !hw.struct<q: i1, qe: i1>
    %qe_13 = hw.struct_extract %fatal_bus_integ_error_11["qe"] : !hw.struct<q: i1, qe: i1>
    %84 = comb.and %q_12, %qe_13 : i1
    %fatal_state_error_14 = hw.struct_extract %alert_test_10["fatal_state_error"] : !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>
    %q_15 = hw.struct_extract %fatal_state_error_14["q"] : !hw.struct<q: i1, qe: i1>
    %qe_16 = hw.struct_extract %fatal_state_error_14["qe"] : !hw.struct<q: i1, qe: i1>
    %85 = comb.and %q_15, %qe_16 : i1
    %fatal_prog_error_17 = hw.struct_extract %alert_test_10["fatal_prog_error"] : !hw.struct<fatal_bus_integ_error: !hw.struct<q: i1, qe: i1>, fatal_state_error: !hw.struct<q: i1, qe: i1>, fatal_prog_error: !hw.struct<q: i1, qe: i1>>
    %q_18 = hw.struct_extract %fatal_prog_error_17["q"] : !hw.struct<q: i1, qe: i1>
    %qe_19 = hw.struct_extract %fatal_prog_error_17["qe"] : !hw.struct<q: i1, qe: i1>
    %86 = comb.and %q_18, %qe_19 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %95 = llhd.prb %clk_i_0 : i1
      %96 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%14, %15 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %97 = llhd.prb %clk_i_0 : i1
      %98 = comb.xor bin %95, %true : i1
      %99 = comb.and bin %98, %97 : i1
      %100 = llhd.prb %rst_ni_1 : i1
      %101 = comb.xor bin %100, %true : i1
      %102 = comb.and bin %96, %101 : i1
      %103 = comb.or bin %99, %102 : i1
      cf.cond_br %103, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %104 = llhd.prb %rst_ni_1 : i1
      %105 = comb.xor %104, %true : i1
      cf.cond_br %105, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %lc_done_q, %false after %2 : i1
      llhd.drv %lc_idle_q, %false after %2 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %106 = llhd.prb %lc_done_d : i1
      llhd.drv %lc_done_q, %106 after %2 : i1
      %107 = llhd.prb %lc_idle_d : i1
      llhd.drv %lc_idle_q, %107 after %2 : i1
      cf.br ^bb1
    }
    %87 = llhd.sig.struct_extract %pwr_lc_o["lc_done"] : <!hw.struct<lc_done: i1, lc_idle: i1>>
    %88 = llhd.prb %lc_done_q : i1
    llhd.drv %87, %88 after %3 : i1
    %89 = llhd.sig.struct_extract %pwr_lc_o["lc_idle"] : <!hw.struct<lc_done: i1, lc_idle: i1>>
    %90 = llhd.prb %lc_idle_q : i1
    llhd.drv %89, %90 after %3 : i1
    llhd.drv %clk_i_0, %clk_i after %3 : i1
    llhd.drv %rst_ni_1, %rst_ni after %3 : i1
    %91 = llhd.prb %alert_tx_o : !hw.array<3xstruct<alert_p: i1, alert_n: i1>>
    %92 = llhd.prb %pwr_lc_o : !hw.struct<lc_done: i1, lc_idle: i1>
    %93 = llhd.prb %lc_otp_vendor_test_o : !hw.struct<ctrl: i32>
    llhd.drv %lc_otp_vendor_test_i_2, %lc_otp_vendor_test_i after %3 : !hw.struct<status: i32>
    %94 = llhd.prb %lc_otp_program_o : !hw.struct<req: i1, state: i320, count: i384>
    llhd.drv %otp_lc_data_i_3, %otp_lc_data_i after %3 : !hw.struct<valid: i1, error: i1, state: i320, count: i384, secrets_valid: i4, test_tokens_valid: i4, test_unlock_token: i128, test_exit_token: i128, rma_token_valid: i4, rma_token: i128>
    llhd.drv %otp_device_id_i_4, %otp_device_id_i after %3 : i256
    llhd.drv %otp_manuf_state_i_5, %otp_manuf_state_i after %3 : i256
    hw.output %u_reg_regs.tl_o, %u_reg_tap_dmi.tl_o, %1, %91, %28, %30, %92, %u_lc_ctrl_fsm.strap_en_override_o, %93, %94, %u_lc_ctrl_kmac_if.kmac_data_o, %u_lc_ctrl_fsm.lc_init_done_o, %u_lc_ctrl_fsm.lc_dft_en_o, %u_lc_ctrl_fsm.lc_raw_test_rma_o, %u_lc_ctrl_fsm.lc_nvm_debug_en_o, %u_lc_ctrl_fsm.lc_hw_debug_clr_o, %u_lc_ctrl_fsm.lc_hw_debug_en_o, %u_lc_ctrl_fsm.lc_cpu_en_o, %u_lc_ctrl_fsm.lc_creator_seed_sw_rw_en_o, %u_lc_ctrl_fsm.lc_owner_seed_sw_rw_en_o, %u_lc_ctrl_fsm.lc_iso_part_sw_rd_en_o, %u_lc_ctrl_fsm.lc_iso_part_sw_wr_en_o, %u_lc_ctrl_fsm.lc_seed_hw_rd_en_o, %u_lc_ctrl_fsm.lc_rma_state_o, %u_lc_ctrl_fsm.lc_keymgr_en_o, %u_lc_ctrl_fsm.lc_escalate_en_o, %u_lc_ctrl_fsm.lc_check_byp_en_o, %u_lc_ctrl_fsm.lc_clk_byp_req_o, %72, %u_lc_ctrl_fsm.lc_nvm_rma_req_o, %u_lc_ctrl_fsm.lc_keymgr_div_o, %58 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<tdo: i1, tdo_oe: i1>, !hw.array<3xstruct<alert_p: i1, alert_n: i1>>, !hw.struct<esc_p: i1, esc_n: i1>, !hw.struct<esc_p: i1, esc_n: i1>, !hw.struct<lc_done: i1, lc_idle: i1>, i1, !hw.struct<ctrl: i32>, !hw.struct<req: i1, state: i320, count: i384>, !hw.struct<valid: i1, data: i64, strb: i8, last: i1>, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i4, i32, i4, i128, !hw.struct<silicon_creator_id: i16, product_id: i16, revision_id: i8, reserved: i24>
  }
}
