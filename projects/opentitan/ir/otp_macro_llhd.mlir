module {
  hw.module private @prim_and2(in %in0_i : i109, in %in1_i : i109, out out_o : i109) {
    %0 = comb.and %in0_i, %in1_i : i109
    hw.output %0 : i109
  }
  hw.module private @prim_and2_16(in %in0_i : i66, in %in1_i : i66, out out_o : i66) {
    %0 = comb.and %in0_i, %in1_i : i66
    hw.output %0 : i66
  }
  hw.module private @prim_buf(in %in_i : i1, out out_o : i1) {
    hw.output %in_i : i1
  }
  hw.module private @prim_buf_18(in %in_i : i8, out out_o : i8) {
    hw.output %in_i : i8
  }
  hw.module private @prim_flop_2sync(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %d_i_0 = llhd.sig name "d_i" %c0_i4 : i4
    %d_o = llhd.sig %c0_i4 : i4
    %1 = llhd.prb %d_o : i4
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_15(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i4) -> (q_o: i4) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_15(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i4) -> (q_o: i4)
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
  hw.module private @prim_flop(in %clk_i : i1, in %rst_ni : i1, in %d_i : i11, out q_o : i11) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i11 = hw.constant 0 : i11
    %c-989_i11 = hw.constant -989 : i11
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
      llhd.drv %q_o, %c-989_i11 after %1 : i11
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
  hw.module private @prim_flop_15(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
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
  hw.module private @prim_flop_17(in %clk_i : i1, in %rst_ni : i1, in %d_i : i9, out q_o : i9) {
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
  hw.module private @prim_blanker(in %in_i : i109, in %en_i : i1, out out_o : i109) {
    %0 = comb.replicate %en_i : (i1) -> i109
    %u_blank_and.out_o = hw.instance "u_blank_and" @prim_and2(in0_i: %in_i: i109, in1_i: %0: i109) -> (out_o: i109)
    hw.output %u_blank_and.out_o : i109
  }
  hw.module private @prim_blanker_1(in %in_i : i66, in %en_i : i1, out out_o : i66) {
    %0 = comb.replicate %en_i : (i1) -> i66
    %u_blank_and.out_o = hw.instance "u_blank_and" @prim_and2_16(in0_i: %in_i: i66, in1_i: %0: i66) -> (out_o: i66)
    hw.output %u_blank_and.out_o : i66
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
  hw.module private @prim_onehot_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i8, in %addr_i : i3, in %en_i : i1, out err_o : i1) {
    %c-2_i4 = hw.constant -2 : i4
    %c-3_i4 = hw.constant -3 : i4
    %c-4_i4 = hw.constant -4 : i4
    %c-5_i4 = hw.constant -5 : i4
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
    %true = hw.constant true
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %false = hw.constant false {sv.namehint = "addr_err"}
    %c0_i15 = hw.constant 0 : i15
    %or_tree = llhd.sig %c0_i15 : i15
    %and_tree = llhd.sig %c0_i15 : i15
    %err_tree = llhd.sig %c0_i15 : i15
    %1 = llhd.sig.extract %or_tree from %c0_i4 : <i15> -> <i1>
    %2 = llhd.prb %or_tree : i15
    %3 = comb.extract %2 from 1 : (i15) -> i1
    %4 = comb.extract %2 from 2 : (i15) -> i1
    %5 = comb.or %3, %4 : i1
    llhd.drv %1, %5 after %0 : i1
    %6 = llhd.sig.extract %and_tree from %c0_i4 : <i15> -> <i1>
    %7 = comb.extract %addr_i from 2 : (i3) -> i1
    %8 = comb.xor %7, %true : i1
    %9 = llhd.prb %and_tree : i15
    %10 = comb.extract %9 from 1 : (i15) -> i1
    %11 = comb.and %8, %10 : i1
    %12 = comb.extract %9 from 2 : (i15) -> i1
    %13 = comb.and %7, %12 : i1
    %14 = comb.or %11, %13 : i1
    llhd.drv %6, %14 after %0 : i1
    %15 = llhd.sig.extract %err_tree from %c0_i4 : <i15> -> <i1>
    %16 = comb.and %3, %4 : i1
    %17 = llhd.prb %err_tree : i15
    %18 = comb.extract %17 from 1 : (i15) -> i1
    %19 = comb.extract %17 from 2 : (i15) -> i1
    %20 = comb.or %16, %18, %19 : i1
    llhd.drv %15, %20 after %0 : i1
    %21 = llhd.sig.extract %or_tree from %c1_i4 : <i15> -> <i1>
    %22 = comb.extract %2 from 3 : (i15) -> i1
    %23 = comb.extract %2 from 4 : (i15) -> i1
    %24 = comb.or %22, %23 : i1
    llhd.drv %21, %24 after %0 : i1
    %25 = llhd.sig.extract %and_tree from %c1_i4 : <i15> -> <i1>
    %26 = comb.extract %addr_i from 1 : (i3) -> i1
    %27 = comb.xor %26, %true : i1
    %28 = comb.extract %9 from 3 : (i15) -> i1
    %29 = comb.and %27, %28 : i1
    %30 = comb.extract %9 from 4 : (i15) -> i1
    %31 = comb.and %26, %30 : i1
    %32 = comb.or %29, %31 : i1
    llhd.drv %25, %32 after %0 : i1
    %33 = llhd.sig.extract %err_tree from %c1_i4 : <i15> -> <i1>
    %34 = comb.and %22, %23 : i1
    %35 = comb.extract %17 from 3 : (i15) -> i1
    %36 = comb.extract %17 from 4 : (i15) -> i1
    %37 = comb.or %34, %35, %36 : i1
    llhd.drv %33, %37 after %0 : i1
    %38 = llhd.sig.extract %or_tree from %c2_i4 : <i15> -> <i1>
    %39 = comb.extract %2 from 5 : (i15) -> i1
    %40 = comb.extract %2 from 6 : (i15) -> i1
    %41 = comb.or %39, %40 : i1
    llhd.drv %38, %41 after %0 : i1
    %42 = llhd.sig.extract %and_tree from %c2_i4 : <i15> -> <i1>
    %43 = comb.extract %9 from 5 : (i15) -> i1
    %44 = comb.and %27, %43 : i1
    %45 = comb.extract %9 from 6 : (i15) -> i1
    %46 = comb.and %26, %45 : i1
    %47 = comb.or %44, %46 : i1
    llhd.drv %42, %47 after %0 : i1
    %48 = llhd.sig.extract %err_tree from %c2_i4 : <i15> -> <i1>
    %49 = comb.and %39, %40 : i1
    %50 = comb.extract %17 from 5 : (i15) -> i1
    %51 = comb.extract %17 from 6 : (i15) -> i1
    %52 = comb.or %49, %50, %51 : i1
    llhd.drv %48, %52 after %0 : i1
    %53 = llhd.sig.extract %or_tree from %c3_i4 : <i15> -> <i1>
    %54 = comb.extract %2 from 7 : (i15) -> i1
    %55 = comb.extract %2 from 8 : (i15) -> i1
    %56 = comb.or %54, %55 : i1
    llhd.drv %53, %56 after %0 : i1
    %57 = llhd.sig.extract %and_tree from %c3_i4 : <i15> -> <i1>
    %58 = comb.extract %addr_i from 0 : (i3) -> i1
    %59 = comb.xor %58, %true : i1
    %60 = comb.extract %9 from 7 : (i15) -> i1
    %61 = comb.and %59, %60 : i1
    %62 = comb.extract %9 from 8 : (i15) -> i1
    %63 = comb.and %58, %62 : i1
    %64 = comb.or %61, %63 : i1
    llhd.drv %57, %64 after %0 : i1
    %65 = llhd.sig.extract %err_tree from %c3_i4 : <i15> -> <i1>
    %66 = comb.and %54, %55 : i1
    %67 = comb.extract %17 from 7 : (i15) -> i1
    %68 = comb.extract %17 from 8 : (i15) -> i1
    %69 = comb.or %66, %67, %68 : i1
    llhd.drv %65, %69 after %0 : i1
    %70 = llhd.sig.extract %or_tree from %c4_i4 : <i15> -> <i1>
    %71 = comb.extract %2 from 9 : (i15) -> i1
    %72 = comb.extract %2 from 10 : (i15) -> i1
    %73 = comb.or %71, %72 : i1
    llhd.drv %70, %73 after %0 : i1
    %74 = llhd.sig.extract %and_tree from %c4_i4 : <i15> -> <i1>
    %75 = comb.extract %9 from 9 : (i15) -> i1
    %76 = comb.and %59, %75 : i1
    %77 = comb.extract %9 from 10 : (i15) -> i1
    %78 = comb.and %58, %77 : i1
    %79 = comb.or %76, %78 : i1
    llhd.drv %74, %79 after %0 : i1
    %80 = llhd.sig.extract %err_tree from %c4_i4 : <i15> -> <i1>
    %81 = comb.and %71, %72 : i1
    %82 = comb.extract %17 from 9 : (i15) -> i1
    %83 = comb.extract %17 from 10 : (i15) -> i1
    %84 = comb.or %81, %82, %83 : i1
    llhd.drv %80, %84 after %0 : i1
    %85 = llhd.sig.extract %or_tree from %c5_i4 : <i15> -> <i1>
    %86 = comb.extract %2 from 11 : (i15) -> i1
    %87 = comb.extract %2 from 12 : (i15) -> i1
    %88 = comb.or %86, %87 : i1
    llhd.drv %85, %88 after %0 : i1
    %89 = llhd.sig.extract %and_tree from %c5_i4 : <i15> -> <i1>
    %90 = comb.extract %9 from 11 : (i15) -> i1
    %91 = comb.and %59, %90 : i1
    %92 = comb.extract %9 from 12 : (i15) -> i1
    %93 = comb.and %58, %92 : i1
    %94 = comb.or %91, %93 : i1
    llhd.drv %89, %94 after %0 : i1
    %95 = llhd.sig.extract %err_tree from %c5_i4 : <i15> -> <i1>
    %96 = comb.and %86, %87 : i1
    %97 = comb.extract %17 from 11 : (i15) -> i1
    %98 = comb.extract %17 from 12 : (i15) -> i1
    %99 = comb.or %96, %97, %98 : i1
    llhd.drv %95, %99 after %0 : i1
    %100 = llhd.sig.extract %or_tree from %c6_i4 : <i15> -> <i1>
    %101 = comb.extract %2 from 13 : (i15) -> i1
    %102 = comb.extract %2 from 14 : (i15) -> i1
    %103 = comb.or %101, %102 : i1
    llhd.drv %100, %103 after %0 : i1
    %104 = llhd.sig.extract %and_tree from %c6_i4 : <i15> -> <i1>
    %105 = comb.extract %9 from 13 : (i15) -> i1
    %106 = comb.and %59, %105 : i1
    %107 = comb.extract %9 from 14 : (i15) -> i1
    %108 = comb.and %58, %107 : i1
    %109 = comb.or %106, %108 : i1
    llhd.drv %104, %109 after %0 : i1
    %110 = llhd.sig.extract %err_tree from %c6_i4 : <i15> -> <i1>
    %111 = comb.and %101, %102 : i1
    %112 = comb.extract %17 from 13 : (i15) -> i1
    %113 = comb.extract %17 from 14 : (i15) -> i1
    %114 = comb.or %111, %112, %113 : i1
    llhd.drv %110, %114 after %0 : i1
    %115 = llhd.sig.extract %or_tree from %c7_i4 : <i15> -> <i1>
    %116 = comb.extract %oh_i from 0 : (i8) -> i1
    llhd.drv %115, %116 after %0 : i1
    %117 = llhd.sig.extract %and_tree from %c7_i4 : <i15> -> <i1>
    llhd.drv %117, %116 after %0 : i1
    %118 = llhd.sig.extract %err_tree from %c7_i4 : <i15> -> <i1>
    llhd.drv %118, %false after %0 : i1
    %119 = llhd.sig.extract %or_tree from %c-8_i4 : <i15> -> <i1>
    %120 = comb.extract %oh_i from 1 : (i8) -> i1
    llhd.drv %119, %120 after %0 : i1
    %121 = llhd.sig.extract %and_tree from %c-8_i4 : <i15> -> <i1>
    llhd.drv %121, %120 after %0 : i1
    %122 = llhd.sig.extract %err_tree from %c-8_i4 : <i15> -> <i1>
    llhd.drv %122, %false after %0 : i1
    %123 = llhd.sig.extract %or_tree from %c-7_i4 : <i15> -> <i1>
    %124 = comb.extract %oh_i from 2 : (i8) -> i1
    llhd.drv %123, %124 after %0 : i1
    %125 = llhd.sig.extract %and_tree from %c-7_i4 : <i15> -> <i1>
    llhd.drv %125, %124 after %0 : i1
    %126 = llhd.sig.extract %err_tree from %c-7_i4 : <i15> -> <i1>
    llhd.drv %126, %false after %0 : i1
    %127 = llhd.sig.extract %or_tree from %c-6_i4 : <i15> -> <i1>
    %128 = comb.extract %oh_i from 3 : (i8) -> i1
    llhd.drv %127, %128 after %0 : i1
    %129 = llhd.sig.extract %and_tree from %c-6_i4 : <i15> -> <i1>
    llhd.drv %129, %128 after %0 : i1
    %130 = llhd.sig.extract %err_tree from %c-6_i4 : <i15> -> <i1>
    llhd.drv %130, %false after %0 : i1
    %131 = llhd.sig.extract %or_tree from %c-5_i4 : <i15> -> <i1>
    %132 = comb.extract %oh_i from 4 : (i8) -> i1
    llhd.drv %131, %132 after %0 : i1
    %133 = llhd.sig.extract %and_tree from %c-5_i4 : <i15> -> <i1>
    llhd.drv %133, %132 after %0 : i1
    %134 = llhd.sig.extract %err_tree from %c-5_i4 : <i15> -> <i1>
    llhd.drv %134, %false after %0 : i1
    %135 = llhd.sig.extract %or_tree from %c-4_i4 : <i15> -> <i1>
    %136 = comb.extract %oh_i from 5 : (i8) -> i1
    llhd.drv %135, %136 after %0 : i1
    %137 = llhd.sig.extract %and_tree from %c-4_i4 : <i15> -> <i1>
    llhd.drv %137, %136 after %0 : i1
    %138 = llhd.sig.extract %err_tree from %c-4_i4 : <i15> -> <i1>
    llhd.drv %138, %false after %0 : i1
    %139 = llhd.sig.extract %or_tree from %c-3_i4 : <i15> -> <i1>
    %140 = comb.extract %oh_i from 6 : (i8) -> i1
    llhd.drv %139, %140 after %0 : i1
    %141 = llhd.sig.extract %and_tree from %c-3_i4 : <i15> -> <i1>
    llhd.drv %141, %140 after %0 : i1
    %142 = llhd.sig.extract %err_tree from %c-3_i4 : <i15> -> <i1>
    llhd.drv %142, %false after %0 : i1
    %143 = llhd.sig.extract %or_tree from %c-2_i4 : <i15> -> <i1>
    %144 = comb.extract %oh_i from 7 : (i8) -> i1
    llhd.drv %143, %144 after %0 : i1
    %145 = llhd.sig.extract %and_tree from %c-2_i4 : <i15> -> <i1>
    llhd.drv %145, %144 after %0 : i1
    %146 = llhd.sig.extract %err_tree from %c-2_i4 : <i15> -> <i1>
    llhd.drv %146, %false after %0 : i1
    %147 = comb.or %148, %151 : i1
    %148 = comb.extract %17 from 0 {sv.namehint = "oh0_err"} : (i15) -> i1
    %149 = comb.xor %en_i, %true : i1
    %150 = comb.extract %2 from 0 : (i15) -> i1
    %151 = comb.and %149, %150 {sv.namehint = "enable_err"} : i1
    hw.output %147 : i1
  }
  hw.module private @prim_reg_we_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i8, in %en_i : i1, out err_o : i1) {
    %c0_i3 = hw.constant 0 : i3
    %u_prim_buf.out_o = hw.instance "u_prim_buf" @prim_buf_18(in_i: %oh_i: i8) -> (out_o: i8) {sv.namehint = "oh_buf"}
    %u_prim_onehot_check.err_o = hw.instance "u_prim_onehot_check" @prim_onehot_check(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, oh_i: %u_prim_buf.out_o: i8, addr_i: %c0_i3: i3, en_i: %en_i: i1) -> (err_o: i1)
    hw.output %u_prim_onehot_check.err_o : i1
  }
  hw.module private @prim_sec_anchor_buf(in %in_i : i1, out out_o : i1) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf(in_i: %in_i: i1) -> (out_o: i1)
    hw.output %u_secure_anchor_buf.out_o : i1
  }
  hw.module private @prim_secded_hamming_22_16_dec(in %data_i : i22, out data_o : i16, out syndrome_o : i6, out err_o : i2) {
    %c0_i11 = hw.constant 0 : i11
    %c-481_i10 = hw.constant -481 : i10
    %c-32641_i16 = hw.constant -32641 : i16
    %c-105529_i18 = hw.constant -105529 : i18
    %c-117139_i18 = hw.constant -117139 : i18
    %c-21157_i17 = hw.constant -21157 : i17
    %c0_i5 = hw.constant 0 : i5
    %true = hw.constant true
    %false = hw.constant false
    %c-1_i4 = hw.constant -1 : i4
    %c-2_i4 = hw.constant -2 : i4
    %c-3_i4 = hw.constant -3 : i4
    %c-4_i4 = hw.constant -4 : i4
    %c-5_i4 = hw.constant -5 : i4
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
    %c0_i4 = hw.constant 0 : i4
    %c-3_i3 = hw.constant -3 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c3_i3 = hw.constant 3 : i3
    %c2_i3 = hw.constant 2 : i3
    %c1_i3 = hw.constant 1 : i3
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i3 = hw.constant 0 : i3
    %c0_i2 = hw.constant 0 : i2
    %c0_i6 = hw.constant 0 : i6
    %c0_i16 = hw.constant 0 : i16
    %c-11_i6 = hw.constant -11 : i6
    %c-12_i6 = hw.constant -12 : i6
    %c-13_i6 = hw.constant -13 : i6
    %c-14_i6 = hw.constant -14 : i6
    %c-15_i6 = hw.constant -15 : i6
    %c-17_i6 = hw.constant -17 : i6
    %c-18_i6 = hw.constant -18 : i6
    %c-19_i6 = hw.constant -19 : i6
    %c-20_i6 = hw.constant -20 : i6
    %c-21_i6 = hw.constant -21 : i6
    %c-22_i6 = hw.constant -22 : i6
    %c-23_i6 = hw.constant -23 : i6
    %c-25_i6 = hw.constant -25 : i6
    %c-26_i6 = hw.constant -26 : i6
    %c-27_i6 = hw.constant -27 : i6
    %c-29_i6 = hw.constant -29 : i6
    %c0_i22 = hw.constant 0 : i22
    %data_i_0 = llhd.sig name "data_i" %c0_i22 : i22
    %data_o = llhd.sig %c0_i16 : i16
    %syndrome_o = llhd.sig %c0_i6 : i6
    %err_o = llhd.sig %c0_i2 : i2
    %1 = llhd.prb %syndrome_o : i6
    %2 = llhd.prb %data_i_0 : i22
    %3 = llhd.prb %data_o : i16
    %4 = llhd.prb %err_o : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %5 = llhd.sig.extract %syndrome_o from %c0_i3 : <i6> -> <i1>
      %6 = llhd.prb %data_i_0 : i22
      %7 = comb.extract %6 from 0 : (i22) -> i17
      %8 = comb.and %7, %c-21157_i17 : i17
      %9 = comb.parity %8 : i17
      llhd.drv %5, %9 after %0 : i1
      %10 = llhd.sig.extract %syndrome_o from %c1_i3 : <i6> -> <i1>
      %11 = llhd.prb %data_i_0 : i22
      %12 = comb.extract %11 from 0 : (i22) -> i18
      %13 = comb.and %12, %c-117139_i18 : i18
      %14 = comb.parity %13 : i18
      llhd.drv %10, %14 after %0 : i1
      %15 = llhd.sig.extract %syndrome_o from %c2_i3 : <i6> -> <i1>
      %16 = llhd.prb %data_i_0 : i22
      %17 = comb.extract %16 from 1 : (i22) -> i18
      %18 = comb.and %17, %c-105529_i18 : i18
      %19 = comb.concat %c0_i3, %18, %false : i3, i18, i1
      %20 = comb.parity %19 : i22
      llhd.drv %15, %20 after %0 : i1
      %21 = llhd.sig.extract %syndrome_o from %c3_i3 : <i6> -> <i1>
      %22 = llhd.prb %data_i_0 : i22
      %23 = comb.extract %22 from 4 : (i22) -> i16
      %24 = comb.and %23, %c-32641_i16 : i16
      %25 = comb.concat %c0_i2, %24, %c0_i4 : i2, i16, i4
      %26 = comb.parity %25 : i22
      llhd.drv %21, %26 after %0 : i1
      %27 = llhd.sig.extract %syndrome_o from %c-4_i3 : <i6> -> <i1>
      %28 = llhd.prb %data_i_0 : i22
      %29 = comb.extract %28 from 11 : (i22) -> i10
      %30 = comb.and %29, %c-481_i10 : i10
      %31 = comb.concat %false, %30, %c0_i11 : i1, i10, i11
      %32 = comb.parity %31 : i22
      llhd.drv %27, %32 after %0 : i1
      %33 = llhd.sig.extract %syndrome_o from %c-3_i3 : <i6> -> <i1>
      %34 = llhd.prb %data_i_0 : i22
      %35 = comb.parity %34 : i22
      llhd.drv %33, %35 after %0 : i1
      %36 = llhd.sig.extract %data_o from %c0_i4 : <i16> -> <i1>
      %37 = llhd.prb %syndrome_o : i6
      %38 = comb.icmp eq %37, %c-29_i6 : i6
      %39 = llhd.prb %data_i_0 : i22
      %40 = comb.extract %39 from 0 : (i22) -> i1
      %41 = comb.xor %38, %40 : i1
      llhd.drv %36, %41 after %0 : i1
      %42 = llhd.sig.extract %data_o from %c1_i4 : <i16> -> <i1>
      %43 = llhd.prb %syndrome_o : i6
      %44 = comb.icmp eq %43, %c-27_i6 : i6
      %45 = llhd.prb %data_i_0 : i22
      %46 = comb.extract %45 from 1 : (i22) -> i1
      %47 = comb.xor %44, %46 : i1
      llhd.drv %42, %47 after %0 : i1
      %48 = llhd.sig.extract %data_o from %c2_i4 : <i16> -> <i1>
      %49 = llhd.prb %syndrome_o : i6
      %50 = comb.icmp eq %49, %c-26_i6 : i6
      %51 = llhd.prb %data_i_0 : i22
      %52 = comb.extract %51 from 2 : (i22) -> i1
      %53 = comb.xor %50, %52 : i1
      llhd.drv %48, %53 after %0 : i1
      %54 = llhd.sig.extract %data_o from %c3_i4 : <i16> -> <i1>
      %55 = llhd.prb %syndrome_o : i6
      %56 = comb.icmp eq %55, %c-25_i6 : i6
      %57 = llhd.prb %data_i_0 : i22
      %58 = comb.extract %57 from 3 : (i22) -> i1
      %59 = comb.xor %56, %58 : i1
      llhd.drv %54, %59 after %0 : i1
      %60 = llhd.sig.extract %data_o from %c4_i4 : <i16> -> <i1>
      %61 = llhd.prb %syndrome_o : i6
      %62 = comb.icmp eq %61, %c-23_i6 : i6
      %63 = llhd.prb %data_i_0 : i22
      %64 = comb.extract %63 from 4 : (i22) -> i1
      %65 = comb.xor %62, %64 : i1
      llhd.drv %60, %65 after %0 : i1
      %66 = llhd.sig.extract %data_o from %c5_i4 : <i16> -> <i1>
      %67 = llhd.prb %syndrome_o : i6
      %68 = comb.icmp eq %67, %c-22_i6 : i6
      %69 = llhd.prb %data_i_0 : i22
      %70 = comb.extract %69 from 5 : (i22) -> i1
      %71 = comb.xor %68, %70 : i1
      llhd.drv %66, %71 after %0 : i1
      %72 = llhd.sig.extract %data_o from %c6_i4 : <i16> -> <i1>
      %73 = llhd.prb %syndrome_o : i6
      %74 = comb.icmp eq %73, %c-21_i6 : i6
      %75 = llhd.prb %data_i_0 : i22
      %76 = comb.extract %75 from 6 : (i22) -> i1
      %77 = comb.xor %74, %76 : i1
      llhd.drv %72, %77 after %0 : i1
      %78 = llhd.sig.extract %data_o from %c7_i4 : <i16> -> <i1>
      %79 = llhd.prb %syndrome_o : i6
      %80 = comb.icmp eq %79, %c-20_i6 : i6
      %81 = llhd.prb %data_i_0 : i22
      %82 = comb.extract %81 from 7 : (i22) -> i1
      %83 = comb.xor %80, %82 : i1
      llhd.drv %78, %83 after %0 : i1
      %84 = llhd.sig.extract %data_o from %c-8_i4 : <i16> -> <i1>
      %85 = llhd.prb %syndrome_o : i6
      %86 = comb.icmp eq %85, %c-19_i6 : i6
      %87 = llhd.prb %data_i_0 : i22
      %88 = comb.extract %87 from 8 : (i22) -> i1
      %89 = comb.xor %86, %88 : i1
      llhd.drv %84, %89 after %0 : i1
      %90 = llhd.sig.extract %data_o from %c-7_i4 : <i16> -> <i1>
      %91 = llhd.prb %syndrome_o : i6
      %92 = comb.icmp eq %91, %c-18_i6 : i6
      %93 = llhd.prb %data_i_0 : i22
      %94 = comb.extract %93 from 9 : (i22) -> i1
      %95 = comb.xor %92, %94 : i1
      llhd.drv %90, %95 after %0 : i1
      %96 = llhd.sig.extract %data_o from %c-6_i4 : <i16> -> <i1>
      %97 = llhd.prb %syndrome_o : i6
      %98 = comb.icmp eq %97, %c-17_i6 : i6
      %99 = llhd.prb %data_i_0 : i22
      %100 = comb.extract %99 from 10 : (i22) -> i1
      %101 = comb.xor %98, %100 : i1
      llhd.drv %96, %101 after %0 : i1
      %102 = llhd.sig.extract %data_o from %c-5_i4 : <i16> -> <i1>
      %103 = llhd.prb %syndrome_o : i6
      %104 = comb.icmp eq %103, %c-15_i6 : i6
      %105 = llhd.prb %data_i_0 : i22
      %106 = comb.extract %105 from 11 : (i22) -> i1
      %107 = comb.xor %104, %106 : i1
      llhd.drv %102, %107 after %0 : i1
      %108 = llhd.sig.extract %data_o from %c-4_i4 : <i16> -> <i1>
      %109 = llhd.prb %syndrome_o : i6
      %110 = comb.icmp eq %109, %c-14_i6 : i6
      %111 = llhd.prb %data_i_0 : i22
      %112 = comb.extract %111 from 12 : (i22) -> i1
      %113 = comb.xor %110, %112 : i1
      llhd.drv %108, %113 after %0 : i1
      %114 = llhd.sig.extract %data_o from %c-3_i4 : <i16> -> <i1>
      %115 = llhd.prb %syndrome_o : i6
      %116 = comb.icmp eq %115, %c-13_i6 : i6
      %117 = llhd.prb %data_i_0 : i22
      %118 = comb.extract %117 from 13 : (i22) -> i1
      %119 = comb.xor %116, %118 : i1
      llhd.drv %114, %119 after %0 : i1
      %120 = llhd.sig.extract %data_o from %c-2_i4 : <i16> -> <i1>
      %121 = llhd.prb %syndrome_o : i6
      %122 = comb.icmp eq %121, %c-12_i6 : i6
      %123 = llhd.prb %data_i_0 : i22
      %124 = comb.extract %123 from 14 : (i22) -> i1
      %125 = comb.xor %122, %124 : i1
      llhd.drv %120, %125 after %0 : i1
      %126 = llhd.sig.extract %data_o from %c-1_i4 : <i16> -> <i1>
      %127 = llhd.prb %syndrome_o : i6
      %128 = comb.icmp eq %127, %c-11_i6 : i6
      %129 = llhd.prb %data_i_0 : i22
      %130 = comb.extract %129 from 15 : (i22) -> i1
      %131 = comb.xor %128, %130 : i1
      llhd.drv %126, %131 after %0 : i1
      %132 = llhd.sig.extract %err_o from %false : <i2> -> <i1>
      %133 = llhd.prb %syndrome_o : i6
      %134 = comb.extract %133 from 5 : (i6) -> i1
      llhd.drv %132, %134 after %0 : i1
      %135 = llhd.sig.extract %err_o from %true : <i2> -> <i1>
      %136 = llhd.prb %syndrome_o : i6
      %137 = comb.extract %136 from 0 : (i6) -> i5
      %138 = comb.icmp ne %137, %c0_i5 : i5
      %139 = comb.extract %136 from 5 : (i6) -> i1
      %140 = comb.xor %139, %true : i1
      %141 = comb.and %138, %140 : i1
      llhd.drv %135, %141 after %0 : i1
      llhd.wait (%1, %2, %3, %4 : i6, i22, i16, i2), ^bb1
    }
    llhd.drv %data_i_0, %data_i after %0 : i22
    hw.output %3, %1, %4 : i16, i6, i2
  }
  hw.module private @prim_secded_hamming_22_16_enc(in %data_i : i16, out data_o : i22) {
    %c0_i4 = hw.constant 0 : i4
    %c0_i11 = hw.constant 0 : i11
    %false = hw.constant false
    %c-7225_i15 = hw.constant -7225 : i15
    %c-2451_i14 = hw.constant -2451 : i14
    %c-21157_i16 = hw.constant -21157 : i16
    %c-11_i5 = hw.constant -11 : i5
    %c-12_i5 = hw.constant -12 : i5
    %c-13_i5 = hw.constant -13 : i5
    %c-14_i5 = hw.constant -14 : i5
    %c-15_i5 = hw.constant -15 : i5
    %c-16_i5 = hw.constant -16 : i5
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i6 = hw.constant 0 : i6
    %c0_i22 = hw.constant 0 : i22
    %c0_i16 = hw.constant 0 : i16
    %data_i_0 = llhd.sig name "data_i" %c0_i16 : i16
    %data_o = llhd.sig %c0_i22 : i22
    %1 = llhd.prb %data_i_0 : i16
    %2 = llhd.prb %data_o : i22
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %3 = llhd.prb %data_i_0 : i16
      %4 = comb.concat %c0_i6, %3 : i6, i16
      llhd.drv %data_o, %4 after %0 : i22
      %5 = llhd.sig.extract %data_o from %c-16_i5 : <i22> -> <i1>
      %6 = llhd.prb %data_o : i22
      %7 = comb.extract %6 from 0 : (i22) -> i16
      %8 = comb.and %7, %c-21157_i16 : i16
      %9 = comb.parity %8 : i16
      llhd.drv %5, %9 after %0 : i1
      %10 = llhd.sig.extract %data_o from %c-15_i5 : <i22> -> <i1>
      %11 = llhd.prb %data_o : i22
      %12 = comb.extract %11 from 0 : (i22) -> i14
      %13 = comb.and %12, %c-2451_i14 : i14
      %14 = comb.parity %13 : i14
      llhd.drv %10, %14 after %0 : i1
      %15 = llhd.sig.extract %data_o from %c-14_i5 : <i22> -> <i1>
      %16 = llhd.prb %data_o : i22
      %17 = comb.extract %16 from 1 : (i22) -> i15
      %18 = comb.and %17, %c-7225_i15 : i15
      %19 = comb.concat %c0_i6, %18, %false : i6, i15, i1
      %20 = comb.parity %19 : i22
      llhd.drv %15, %20 after %0 : i1
      %21 = llhd.sig.extract %data_o from %c-13_i5 : <i22> -> <i1>
      %22 = llhd.prb %data_o : i22
      %23 = comb.extract %22 from 4 : (i22) -> i7
      %24 = comb.concat %c0_i11, %23, %c0_i4 : i11, i7, i4
      %25 = comb.parity %24 : i22
      llhd.drv %21, %25 after %0 : i1
      %26 = llhd.sig.extract %data_o from %c-12_i5 : <i22> -> <i1>
      %27 = llhd.prb %data_o : i22
      %28 = comb.extract %27 from 11 : (i22) -> i5
      %29 = comb.concat %c0_i6, %28, %c0_i11 : i6, i5, i11
      %30 = comb.parity %29 : i22
      llhd.drv %26, %30 after %0 : i1
      %31 = llhd.sig.extract %data_o from %c-11_i5 : <i22> -> <i1>
      %32 = llhd.prb %data_o : i22
      %33 = comb.extract %32 from 0 : (i22) -> i21
      %34 = comb.parity %33 : i21
      llhd.drv %31, %34 after %0 : i1
      llhd.wait (%1, %2 : i16, i22), ^bb1
    }
    llhd.drv %data_i_0, %data_i after %0 : i16
    hw.output %2 : i22
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
  hw.module private @prim_sparse_fsm_flop(in %clk_i : i1, in %rst_ni : i1, in %state_i : i11, out state_o : i11) {
    %u_state_flop.q_o = hw.instance "u_state_flop" @prim_flop(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %state_i: i11) -> (q_o: i11) {sv.namehint = "state_raw"}
    hw.output %u_state_flop.q_o : i11
  }
  hw.module private @prim_sparse_fsm_flop_2(in %clk_i : i1, in %rst_ni : i1, in %state_i : i9, out state_o : i9) {
    %u_state_flop.q_o = hw.instance "u_state_flop" @prim_flop_17(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %state_i: i9) -> (q_o: i9) {sv.namehint = "state_raw"}
    hw.output %u_state_flop.q_o : i9
  }
  hw.module private @prim_subreg_arb(in %we : i1, in %wd : i1, in %de : i1, in %d : i1, in %q : i1, out wr_en : i1, out wr_data : i1) {
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
  hw.module private @prim_subreg_arb_20(in %we : i1, in %wd : i10, in %de : i1, in %d : i10, in %q : i10, out wr_en : i1, out wr_data : i10) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i10 = hw.constant 0 : i10
    %wd_0 = llhd.sig name "wd" %c0_i10 : i10
    %d_1 = llhd.sig name "d" %c0_i10 : i10
    %1 = comb.or %we, %de : i1
    %2 = llhd.prb %wd_0 : i10
    %3 = llhd.prb %d_1 : i10
    %4 = comb.mux %we, %2, %3 : i10
    llhd.drv %wd_0, %wd after %0 : i10
    llhd.drv %d_1, %d after %0 : i10
    hw.output %1, %4 : i1, i10
  }
  hw.module private @prim_subreg_arb_21(in %we : i1, in %wd : i11, in %de : i1, in %d : i11, in %q : i11, out wr_en : i1, out wr_data : i11) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i11 = hw.constant 0 : i11
    %wd_0 = llhd.sig name "wd" %c0_i11 : i11
    %d_1 = llhd.sig name "d" %c0_i11 : i11
    %1 = comb.or %we, %de : i1
    %2 = llhd.prb %wd_0 : i11
    %3 = llhd.prb %d_1 : i11
    %4 = comb.mux %we, %2, %3 : i11
    llhd.drv %wd_0, %wd after %0 : i11
    llhd.drv %d_1, %d after %0 : i11
    hw.output %1, %4 : i1, i11
  }
  hw.module private @prim_subreg_arb_22(in %we : i1, in %wd : i7, in %de : i1, in %d : i7, in %q : i7, out wr_en : i1, out wr_data : i7) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i7 = hw.constant 0 : i7
    %wd_0 = llhd.sig name "wd" %c0_i7 : i7
    %d_1 = llhd.sig name "d" %c0_i7 : i7
    %1 = comb.or %we, %de : i1
    %2 = llhd.prb %wd_0 : i7
    %3 = llhd.prb %d_1 : i7
    %4 = comb.mux %we, %2, %3 : i7
    llhd.drv %wd_0, %wd after %0 : i7
    llhd.drv %d_1, %d after %0 : i7
    hw.output %1, %4 : i1, i7
  }
  hw.module private @prim_subreg_arb_23(in %we : i1, in %wd : i16, in %de : i1, in %d : i16, in %q : i16, out wr_en : i1, out wr_data : i16) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i16 = hw.constant 0 : i16
    %wd_0 = llhd.sig name "wd" %c0_i16 : i16
    %d_1 = llhd.sig name "d" %c0_i16 : i16
    %1 = comb.or %we, %de : i1
    %2 = llhd.prb %wd_0 : i16
    %3 = llhd.prb %d_1 : i16
    %4 = comb.mux %we, %2, %3 : i16
    llhd.drv %wd_0, %wd after %0 : i16
    llhd.drv %d_1, %d after %0 : i16
    hw.output %1, %4 : i1, i16
  }
  hw.module private @prim_subreg_arb_24(in %we : i1, in %wd : i3, in %de : i1, in %d : i3, in %q : i3, out wr_en : i1, out wr_data : i3) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c-1_i3 = hw.constant -1 : i3
    %c0_i3 = hw.constant 0 : i3
    %wd_0 = llhd.sig name "wd" %c0_i3 : i3
    %d_1 = llhd.sig name "d" %c0_i3 : i3
    %q_2 = llhd.sig name "q" %c0_i3 : i3
    %1 = comb.or %we, %de : i1
    %2 = llhd.prb %d_1 : i3
    %3 = llhd.prb %q_2 : i3
    %4 = comb.mux %de, %2, %3 : i3
    %5 = llhd.prb %wd_0 : i3
    %6 = comb.replicate %we : (i1) -> i3
    %7 = comb.and %6, %5 : i3
    %8 = comb.xor %7, %c-1_i3 : i3
    %9 = comb.and %4, %8 : i3
    llhd.drv %wd_0, %wd after %0 : i3
    llhd.drv %d_1, %d after %0 : i3
    llhd.drv %q_2, %q after %0 : i3
    hw.output %1, %9 : i1, i3
  }
  hw.module private @prim_subreg_arb_25(in %we : i1, in %wd : i10, in %de : i1, in %d : i10, in %q : i10, out wr_en : i1, out wr_data : i10) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c-1_i10 = hw.constant -1 : i10
    %c0_i10 = hw.constant 0 : i10
    %wd_0 = llhd.sig name "wd" %c0_i10 : i10
    %d_1 = llhd.sig name "d" %c0_i10 : i10
    %q_2 = llhd.sig name "q" %c0_i10 : i10
    %1 = comb.or %we, %de : i1
    %2 = llhd.prb %d_1 : i10
    %3 = llhd.prb %q_2 : i10
    %4 = comb.mux %de, %2, %3 : i10
    %5 = llhd.prb %wd_0 : i10
    %6 = comb.replicate %we : (i1) -> i10
    %7 = comb.and %6, %5 : i10
    %8 = comb.xor %7, %c-1_i10 : i10
    %9 = comb.and %4, %8 : i10
    llhd.drv %wd_0, %wd after %0 : i10
    llhd.drv %d_1, %d after %0 : i10
    llhd.drv %q_2, %q after %0 : i10
    hw.output %1, %9 : i1, i10
  }
  hw.module private @prim_subreg_arb_26(in %we : i1, in %wd : i1, in %de : i1, in %d : i1, in %q : i1, out wr_en : i1, out wr_data : i1) {
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
  hw.module private @prim_subreg_arb_27(in %we : i1, in %wd : i1, in %de : i1, in %d : i1, in %q : i1, out wr_en : i1, out wr_data : i1) {
    hw.output %de, %d : i1, i1
  }
  hw.module private @prim_subreg_arb_28(in %we : i1, in %wd : i6, in %de : i1, in %d : i6, in %q : i6, out wr_en : i1, out wr_data : i6) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i6 = hw.constant 0 : i6
    %wd_0 = llhd.sig name "wd" %c0_i6 : i6
    %d_1 = llhd.sig name "d" %c0_i6 : i6
    %1 = comb.or %we, %de : i1
    %2 = llhd.prb %wd_0 : i6
    %3 = llhd.prb %d_1 : i6
    %4 = comb.mux %we, %2, %3 : i6
    llhd.drv %wd_0, %wd after %0 : i6
    llhd.drv %d_1, %d after %0 : i6
    hw.output %1, %4 : i1, i6
  }
  hw.module private @prim_subreg_arb_29(in %we : i1, in %wd : i2, in %de : i1, in %d : i2, in %q : i2, out wr_en : i1, out wr_data : i2) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %wd_0 = llhd.sig name "wd" %c0_i2 : i2
    %d_1 = llhd.sig name "d" %c0_i2 : i2
    %1 = comb.or %we, %de : i1
    %2 = llhd.prb %wd_0 : i2
    %3 = llhd.prb %d_1 : i2
    %4 = comb.mux %we, %2, %3 : i2
    llhd.drv %wd_0, %wd after %0 : i2
    llhd.drv %d_1, %d after %0 : i2
    hw.output %1, %4 : i1, i2
  }
  hw.module private @prim_subreg_arb_30(in %we : i1, in %wd : i3, in %de : i1, in %d : i3, in %q : i3, out wr_en : i1, out wr_data : i3) {
    hw.output %de, %d : i1, i3
  }
  hw.module private @prim_subreg_arb_31(in %we : i1, in %wd : i6, in %de : i1, in %d : i6, in %q : i6, out wr_en : i1, out wr_data : i6) {
    hw.output %de, %d : i1, i6
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
  hw.module private @prim_subreg_3(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i10, in %de : i1, in %d : i10, out qe : i1, out q : i10, out ds : i10, out qs : i10) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i10 = hw.constant 0 : i10
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %q = llhd.sig %c0_i10 : i10
    %qs = llhd.sig %c0_i10 : i10
    %wr_en = llhd.sig %false : i1
    %wr_data = llhd.sig %c0_i10 : i10
    %4 = llhd.prb %q : i10
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_20(we: %we: i1, wd: %wd: i10, de: %de: i1, d: %d: i10, q: %4: i10) -> (wr_en: i1, wr_data: i10)
    llhd.drv %wr_en, %wr_en_data_arb.wr_en after %1 : i1
    llhd.drv %wr_data, %wr_en_data_arb.wr_data after %1 : i10
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
      llhd.drv %q, %c0_i10 after %0 : i10
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %20 = llhd.prb %wr_en : i1
      cf.cond_br %20, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %21 = llhd.prb %wr_data : i10
      llhd.drv %q, %21 after %0 : i10
      cf.br ^bb1
    }
    %5 = llhd.prb %wr_en : i1
    %6 = llhd.prb %wr_data : i10
    %7 = llhd.prb %qs : i10
    %8 = comb.mux %5, %6, %7 : i10
    llhd.drv %qs, %4 after %1 : i10
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    hw.output %we, %4, %8, %7 : i1, i10, i10, i10
  }
  hw.module private @prim_subreg_4(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i11, in %de : i1, in %d : i11, out qe : i1, out q : i11, out ds : i11, out qs : i11) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i11 = hw.constant 0 : i11
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %q = llhd.sig %c0_i11 : i11
    %qs = llhd.sig %c0_i11 : i11
    %wr_en = llhd.sig %false : i1
    %wr_data = llhd.sig %c0_i11 : i11
    %4 = llhd.prb %q : i11
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_21(we: %we: i1, wd: %wd: i11, de: %de: i1, d: %d: i11, q: %4: i11) -> (wr_en: i1, wr_data: i11)
    llhd.drv %wr_en, %wr_en_data_arb.wr_en after %1 : i1
    llhd.drv %wr_data, %wr_en_data_arb.wr_data after %1 : i11
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
      llhd.drv %q, %c0_i11 after %0 : i11
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %20 = llhd.prb %wr_en : i1
      cf.cond_br %20, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %21 = llhd.prb %wr_data : i11
      llhd.drv %q, %21 after %0 : i11
      cf.br ^bb1
    }
    %5 = llhd.prb %wr_en : i1
    %6 = llhd.prb %wr_data : i11
    %7 = llhd.prb %qs : i11
    %8 = comb.mux %5, %6, %7 : i11
    llhd.drv %qs, %4 after %1 : i11
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    hw.output %we, %4, %8, %7 : i1, i11, i11, i11
  }
  hw.module private @prim_subreg_5(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i7, in %de : i1, in %d : i7, out qe : i1, out q : i7, out ds : i7, out qs : i7) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i7 = hw.constant 0 : i7
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %q = llhd.sig %c0_i7 : i7
    %qs = llhd.sig %c0_i7 : i7
    %wr_en = llhd.sig %false : i1
    %wr_data = llhd.sig %c0_i7 : i7
    %4 = llhd.prb %q : i7
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_22(we: %we: i1, wd: %wd: i7, de: %de: i1, d: %d: i7, q: %4: i7) -> (wr_en: i1, wr_data: i7)
    llhd.drv %wr_en, %wr_en_data_arb.wr_en after %1 : i1
    llhd.drv %wr_data, %wr_en_data_arb.wr_data after %1 : i7
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
      llhd.drv %q, %c0_i7 after %0 : i7
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %20 = llhd.prb %wr_en : i1
      cf.cond_br %20, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %21 = llhd.prb %wr_data : i7
      llhd.drv %q, %21 after %0 : i7
      cf.br ^bb1
    }
    %5 = llhd.prb %wr_en : i1
    %6 = llhd.prb %wr_data : i7
    %7 = llhd.prb %qs : i7
    %8 = comb.mux %5, %6, %7 : i7
    llhd.drv %qs, %4 after %1 : i7
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    hw.output %we, %4, %8, %7 : i1, i7, i7, i7
  }
  hw.module private @prim_subreg_6(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i16, in %de : i1, in %d : i16, out qe : i1, out q : i16, out ds : i16, out qs : i16) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i16 = hw.constant 0 : i16
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %q = llhd.sig %c0_i16 : i16
    %qs = llhd.sig %c0_i16 : i16
    %wr_en = llhd.sig %false : i1
    %wr_data = llhd.sig %c0_i16 : i16
    %4 = llhd.prb %q : i16
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_23(we: %we: i1, wd: %wd: i16, de: %de: i1, d: %d: i16, q: %4: i16) -> (wr_en: i1, wr_data: i16)
    llhd.drv %wr_en, %wr_en_data_arb.wr_en after %1 : i1
    llhd.drv %wr_data, %wr_en_data_arb.wr_data after %1 : i16
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
      llhd.drv %q, %c0_i16 after %0 : i16
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %20 = llhd.prb %wr_en : i1
      cf.cond_br %20, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %21 = llhd.prb %wr_data : i16
      llhd.drv %q, %21 after %0 : i16
      cf.br ^bb1
    }
    %5 = llhd.prb %wr_en : i1
    %6 = llhd.prb %wr_data : i16
    %7 = llhd.prb %qs : i16
    %8 = comb.mux %5, %6, %7 : i16
    llhd.drv %qs, %4 after %1 : i16
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    hw.output %we, %4, %8, %7 : i1, i16, i16, i16
  }
  hw.module private @prim_subreg_7(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i3, in %de : i1, in %d : i3, out qe : i1, out q : i3, out ds : i3, out qs : i3) {
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
  hw.module private @prim_subreg_8(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i10, in %de : i1, in %d : i10, out qe : i1, out q : i10, out ds : i10, out qs : i10) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i10 = hw.constant 0 : i10
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %q = llhd.sig %c0_i10 : i10
    %qs = llhd.sig %c0_i10 : i10
    %wr_en = llhd.sig %false : i1
    %wr_data = llhd.sig %c0_i10 : i10
    %4 = llhd.prb %q : i10
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_25(we: %we: i1, wd: %wd: i10, de: %de: i1, d: %d: i10, q: %4: i10) -> (wr_en: i1, wr_data: i10)
    llhd.drv %wr_en, %wr_en_data_arb.wr_en after %1 : i1
    llhd.drv %wr_data, %wr_en_data_arb.wr_data after %1 : i10
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
      llhd.drv %q, %c0_i10 after %0 : i10
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %20 = llhd.prb %wr_en : i1
      cf.cond_br %20, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %21 = llhd.prb %wr_data : i10
      llhd.drv %q, %21 after %0 : i10
      cf.br ^bb1
    }
    %5 = llhd.prb %wr_en : i1
    %6 = llhd.prb %wr_data : i10
    %7 = llhd.prb %qs : i10
    %8 = comb.mux %5, %6, %7 : i10
    llhd.drv %qs, %4 after %1 : i10
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    hw.output %we, %4, %8, %7 : i1, i10, i10, i10
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_26(we: %we: i1, wd: %wd: i1, de: %de: i1, d: %d: i1, q: %4: i1) -> (wr_en: i1, wr_data: i1)
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
  hw.module private @prim_subreg_10(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i1, in %de : i1, in %d : i1, out qe : i1, out q : i1, out ds : i1, out qs : i1) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_27(we: %we: i1, wd: %wd: i1, de: %de: i1, d: %d: i1, q: %4: i1) -> (wr_en: i1, wr_data: i1)
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
  hw.module private @prim_subreg_11(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i6, in %de : i1, in %d : i6, out qe : i1, out q : i6, out ds : i6, out qs : i6) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i6 = hw.constant 0 : i6
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %q = llhd.sig %c0_i6 : i6
    %qs = llhd.sig %c0_i6 : i6
    %wr_en = llhd.sig %false : i1
    %wr_data = llhd.sig %c0_i6 : i6
    %4 = llhd.prb %q : i6
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_28(we: %we: i1, wd: %wd: i6, de: %de: i1, d: %d: i6, q: %4: i6) -> (wr_en: i1, wr_data: i6)
    llhd.drv %wr_en, %wr_en_data_arb.wr_en after %1 : i1
    llhd.drv %wr_data, %wr_en_data_arb.wr_data after %1 : i6
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
      llhd.drv %q, %c0_i6 after %0 : i6
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %20 = llhd.prb %wr_en : i1
      cf.cond_br %20, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %21 = llhd.prb %wr_data : i6
      llhd.drv %q, %21 after %0 : i6
      cf.br ^bb1
    }
    %5 = llhd.prb %wr_en : i1
    %6 = llhd.prb %wr_data : i6
    %7 = llhd.prb %qs : i6
    %8 = comb.mux %5, %6, %7 : i6
    llhd.drv %qs, %4 after %1 : i6
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    hw.output %we, %4, %8, %7 : i1, i6, i6, i6
  }
  hw.module private @prim_subreg_12(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i2, in %de : i1, in %d : i2, out qe : i1, out q : i2, out ds : i2, out qs : i2) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_29(we: %we: i1, wd: %wd: i2, de: %de: i1, d: %d: i2, q: %4: i2) -> (wr_en: i1, wr_data: i2)
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
  hw.module private @prim_subreg_13(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i3, in %de : i1, in %d : i3, out qe : i1, out q : i3, out ds : i3, out qs : i3) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_30(we: %we: i1, wd: %wd: i3, de: %de: i1, d: %d: i3, q: %4: i3) -> (wr_en: i1, wr_data: i3)
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
  hw.module private @prim_subreg_14(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i6, in %de : i1, in %d : i6, out qe : i1, out q : i6, out ds : i6, out qs : i6) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i6 = hw.constant 0 : i6
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %q = llhd.sig %c0_i6 : i6
    %qs = llhd.sig %c0_i6 : i6
    %wr_en = llhd.sig %false : i1
    %wr_data = llhd.sig %c0_i6 : i6
    %4 = llhd.prb %q : i6
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_31(we: %we: i1, wd: %wd: i6, de: %de: i1, d: %d: i6, q: %4: i6) -> (wr_en: i1, wr_data: i6)
    llhd.drv %wr_en, %wr_en_data_arb.wr_en after %1 : i1
    llhd.drv %wr_data, %wr_en_data_arb.wr_data after %1 : i6
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
      llhd.drv %q, %c0_i6 after %0 : i6
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %20 = llhd.prb %wr_en : i1
      cf.cond_br %20, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %21 = llhd.prb %wr_data : i6
      llhd.drv %q, %21 after %0 : i6
      cf.br ^bb1
    }
    %5 = llhd.prb %wr_en : i1
    %6 = llhd.prb %wr_data : i6
    %7 = llhd.prb %qs : i6
    %8 = comb.mux %5, %6, %7 : i6
    llhd.drv %qs, %4 after %1 : i6
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    hw.output %we, %4, %8, %7 : i1, i6, i6, i6
  }
  hw.module private @tlul_adapter_reg(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %en_ifetch_i : i4, out intg_error_o : i1, out re_o : i1, out we_o : i1, out addr_o : i5, out wdata_o : i32, out be_o : i4, in %busy_i : i1, in %rdata_i : i32, in %error_i : i1) {
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
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen_19(tl_i: %32: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
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
    %22 = comb.extract %a_address from 2 : (i32) -> i3
    %23 = comb.concat %22, %c0_i2 : i3, i2
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
    hw.output %u_rsp_intg_gen.tl_o, %false, %21, %19, %23, %a_data, %a_mask : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, i1, i1, i1, i5, i32, i4
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
  hw.module private @tlul_rsp_intg_gen_19(in %tl_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) {
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
  hw.module private @prim_lc_sync(in %clk_i : i1, in %rst_ni : i1, in %lc_en_i : i4, out lc_en_o : !hw.array<3xi4>) {
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
    %gen_flops.u_prim_flop_2sync.q_o = hw.instance "gen_flops.u_prim_flop_2sync" @prim_flop_2sync(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %lc_en_i: i4) -> (q_o: i4) {sv.namehint = "lc_en"}
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
  hw.module private @prim_lc_sync_0(in %clk_i : i1, in %rst_ni : i1, in %lc_en_i : i4, out lc_en_o : !hw.array<2xi4>) {
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
    %u_err_en_sync.lc_en_o = hw.instance "u_err_en_sync" @prim_lc_sync_0(clk_i: %6: i1, rst_ni: %7: i1, lc_en_i: %8: i4) -> (lc_en_o: !hw.array<2xi4>) {sv.namehint = "err_en_buf"}
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
    %gen_lc_gating_muxes_0.u_prim_blanker_d2h.out_o = hw.instance "gen_lc_gating_muxes_0.u_prim_blanker_d2h" @prim_blanker_1(in_i: %20: i66, en_i: %18: i1) -> (out_o: i66)
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
    %gen_lc_gating_muxes_1.u_prim_blanker_d2h.out_o = hw.instance "gen_lc_gating_muxes_1.u_prim_blanker_d2h" @prim_blanker_1(in_i: %31: i66, en_i: %29: i1) -> (out_o: i66)
    %32 = hw.bitcast %gen_lc_gating_muxes_1.u_prim_blanker_d2h.out_o : (i66) -> !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %30, %32 after %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %33 = llhd.prb %state_d : i9
    %u_state_regs.state_o = hw.instance "u_state_regs" @prim_sparse_fsm_flop_2(clk_i: %6: i1, rst_ni: %7: i1, state_i: %33: i9) -> (state_o: i9)
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
  hw.module private @prim_ram_1p_adv(in %clk_i : i1, in %rst_ni : i1, in %req_i : i1, in %write_i : i1, in %addr_i : i10, in %wdata_i : i22, in %wmask_i : i22, out rdata_o : i22, out rvalid_o : i1, out rerror_o : i2, in %cfg_i : !hw.array<1xstruct<ram_cfg: !hw.struct<test: i1, cfg_en: i1, cfg: i4>, rf_cfg: !hw.struct<test: i1, cfg_en: i1, cfg: i4>>>, out cfg_rsp_o : !hw.array<1xstruct<done: i1>>, out alert_o : i1) {
    %0 = hw.aggregate_constant [[false]] : !hw.array<1xstruct<done: i1>>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c-1_i22 = hw.constant -1 : i22
    %2 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %3 = hw.aggregate_constant [0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22, 0 : i22] : !hw.array<1024xi22>
    %c0_i10 = hw.constant 0 : i10
    %c0_i2 = hw.constant 0 : i2
    %c-1_i10 = hw.constant -1 : i10
    %false = hw.constant false
    %c0_i22 = hw.constant 0 : i22
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %4 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %5 = llhd.prb %rst_ni_1 : i1
    %req_i_2 = llhd.sig name "req_i" %false : i1
    %write_i_3 = llhd.sig name "write_i" %false : i1
    %addr_i_4 = llhd.sig name "addr_i" %c0_i10 : i10
    %wdata_i_5 = llhd.sig name "wdata_i" %c0_i22 : i22
    %wmask_i_6 = llhd.sig name "wmask_i" %c0_i22 : i22
    %rdata_o = llhd.sig %c0_i22 : i22
    %rvalid_o = llhd.sig %false : i1
    %mem = llhd.sig %3 : !hw.array<1024xi22>
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
      llhd.drv %rdata_o, %c0_i22 after %2 : i22
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
      %27 = llhd.sig.array_get %mem[%26] : <!hw.array<1024xi22>>
      %28 = llhd.prb %mem : !hw.array<1024xi22>
      %29 = hw.array_get %28[%26] : !hw.array<1024xi22>, i10
      %30 = llhd.prb %wmask_i_6 : i22
      %31 = comb.xor %30, %c-1_i22 : i22
      %32 = comb.and %29, %31 : i22
      %33 = llhd.prb %wdata_i_5 : i22
      %34 = comb.and %33, %30 : i22
      %35 = comb.or %32, %34 : i22
      llhd.drv %27, %35 after %2 : i22
      cf.br ^bb1
    ^bb8:  // pred: ^bb6
      %36 = llhd.prb %mem : !hw.array<1024xi22>
      %37 = llhd.prb %addr_i_4 : i10
      %38 = comb.sub %c-1_i10, %37 : i10
      %39 = hw.array_get %36[%38] : !hw.array<1024xi22>, i10
      llhd.drv %rdata_o, %39 after %2 : i22
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %req_i_2, %req_i after %1 : i1
    llhd.drv %write_i_3, %write_i after %1 : i1
    llhd.drv %addr_i_4, %addr_i after %1 : i10
    llhd.drv %wdata_i_5, %wdata_i after %1 : i22
    llhd.drv %wmask_i_6, %wmask_i after %1 : i22
    %6 = llhd.prb %rdata_o : i22
    %7 = llhd.prb %rvalid_o : i1
    hw.output %6, %7, %c0_i2, %0, %false : i22, i1, i2, !hw.array<1xstruct<done: i1>>, i1
  }
  hw.module private @otp_macro_prim_reg_top(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out reg2hw : !hw.struct<csr0: !hw.struct<field4: !hw.struct<q: i11>, field3: !hw.struct<q: i10>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i1>>, csr1: !hw.struct<field4: !hw.struct<q: i16>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i7>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i7>>, csr2: !hw.struct<q: i1>, csr3: !hw.struct<field8: !hw.struct<q: i1>, field7: !hw.struct<q: i1>, field6: !hw.struct<q: i1>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i10>, field0: !hw.struct<q: i3>>, csr4: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr5: !hw.struct<field6: !hw.struct<q: i16>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i3>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i2>, field0: !hw.struct<q: i6>>, csr6: !hw.struct<field3: !hw.struct<q: i16>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr7: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i3>, field0: !hw.struct<q: i6>>>, in %hw2reg : !hw.struct<csr3: !hw.struct<field8: !hw.struct<d: i1, de: i1>, field7: !hw.struct<d: i1, de: i1>, field6: !hw.struct<d: i1, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i1, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i10, de: i1>, field0: !hw.struct<d: i3, de: i1>>, csr5: !hw.struct<field6: !hw.struct<d: i16, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i3, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i2, de: i1>, field0: !hw.struct<d: i6, de: i1>>, csr7: !hw.struct<field3: !hw.struct<d: i1, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i3, de: i1>, field0: !hw.struct<d: i6, de: i1>>>, in %racl_policies_i : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, out racl_error_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, out intg_err_o : i1) {
    %c-1_i2 = hw.constant -1 : i2
    %c11_i5 = hw.constant 11 : i5
    %c9_i5 = hw.constant 9 : i5
    %c6_i5 = hw.constant 6 : i5
    %c14_i5 = hw.constant 14 : i5
    %c13_i5 = hw.constant 13 : i5
    %c-10_i5 = hw.constant -10 : i5
    %c-11_i5 = hw.constant -11 : i5
    %c-13_i5 = hw.constant -13 : i5
    %c-14_i5 = hw.constant -14 : i5
    %c-15_i5 = hw.constant -15 : i5
    %c15_i5 = hw.constant 15 : i5
    %c7_i5 = hw.constant 7 : i5
    %c2_i5 = hw.constant 2 : i5
    %c1_i5 = hw.constant 1 : i5
    %c0_i27 = hw.constant 0 : i27
    %c-1_i3 = hw.constant -1 : i3
    %c-2_i3 = hw.constant -2 : i3
    %c-3_i3 = hw.constant -3 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c3_i3 = hw.constant 3 : i3
    %c2_i3 = hw.constant 2 : i3
    %c1_i3 = hw.constant 1 : i3
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %2 = hw.aggregate_constant [false, false, false, false, false, 0 : i32] : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %3 = hw.aggregate_constant [[0 : i2, 0 : i2]] : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    %4 = hw.aggregate_constant [[[0 : i11], [0 : i10], [false], [false], [false]], [[0 : i16], [false], [0 : i7], [false], [0 : i7]], [false], [[false], [false], [false], [false], [false], [false], [false], [0 : i10], [0 : i3]], [[false], [false], [false], [0 : i10]], [[0 : i16], [false], [false], [0 : i3], [false], [0 : i2], [0 : i6]], [[0 : i16], [false], [false], [0 : i10]], [[false], [false], [0 : i3], [0 : i6]]] : !hw.struct<csr0: !hw.struct<field4: !hw.struct<q: i11>, field3: !hw.struct<q: i10>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i1>>, csr1: !hw.struct<field4: !hw.struct<q: i16>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i7>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i7>>, csr2: !hw.struct<q: i1>, csr3: !hw.struct<field8: !hw.struct<q: i1>, field7: !hw.struct<q: i1>, field6: !hw.struct<q: i1>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i10>, field0: !hw.struct<q: i3>>, csr4: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr5: !hw.struct<field6: !hw.struct<q: i16>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i3>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i2>, field0: !hw.struct<q: i6>>, csr6: !hw.struct<field3: !hw.struct<q: i16>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr7: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i3>, field0: !hw.struct<q: i6>>>
    %c-1_i32 = hw.constant -1 : i32
    %c0_i32 = hw.constant 0 : i32
    %c-1_i4 = hw.constant -1 : i4
    %false = hw.constant false {sv.namehint = "racl_role"}
    %c-4_i5 = hw.constant -4 : i5
    %c-8_i5 = hw.constant -8 : i5
    %c-12_i5 = hw.constant -12 : i5
    %c-16_i5 = hw.constant -16 : i5
    %c12_i5 = hw.constant 12 : i5
    %c8_i5 = hw.constant 8 : i5
    %c4_i5 = hw.constant 4 : i5
    %c0_i5 = hw.constant 0 : i5
    %c0_i8 = hw.constant 0 : i8
    %c0_i2 = hw.constant 0 : i2
    %c0_i6 = hw.constant 0 : i6
    %c0_i3 = hw.constant 0 : i3
    %c0_i16 = hw.constant 0 : i16
    %c0_i7 = hw.constant 0 : i7
    %c0_i11 = hw.constant 0 : i11
    %c0_i10 = hw.constant 0 : i10
    %true = hw.constant true
    %c-7_i4 = hw.constant -7 : i4
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %5 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %6 = llhd.prb %rst_ni_1 : i1
    %reg2hw = llhd.sig %4 : !hw.struct<csr0: !hw.struct<field4: !hw.struct<q: i11>, field3: !hw.struct<q: i10>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i1>>, csr1: !hw.struct<field4: !hw.struct<q: i16>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i7>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i7>>, csr2: !hw.struct<q: i1>, csr3: !hw.struct<field8: !hw.struct<q: i1>, field7: !hw.struct<q: i1>, field6: !hw.struct<q: i1>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i10>, field0: !hw.struct<q: i3>>, csr4: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr5: !hw.struct<field6: !hw.struct<q: i16>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i3>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i2>, field0: !hw.struct<q: i6>>, csr6: !hw.struct<field3: !hw.struct<q: i16>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr7: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i3>, field0: !hw.struct<q: i6>>>
    %racl_policies_i_2 = llhd.sig name "racl_policies_i" %3 : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    %racl_error_o = llhd.sig %2 : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %reg_we = llhd.sig %false : i1
    %reg_addr = llhd.sig %c0_i5 : i5
    %reg_be = llhd.sig %c0_i4 : i4
    %wr_err = llhd.sig %false : i1
    %reg_rdata_next = llhd.sig %c0_i32 : i32
    %intg_err = llhd.sig %false : i1
    %reg_we_err = llhd.sig %false : i1
    %reg_we_check = llhd.sig %c0_i8 : i8
    %err_q = llhd.sig %false : i1
    %csr0_we = llhd.sig %false : i1
    %csr0_field0_qs = llhd.sig %false : i1
    %csr0_field1_qs = llhd.sig %false : i1
    %csr0_field2_qs = llhd.sig %false : i1
    %csr0_field3_qs = llhd.sig %c0_i10 : i10
    %csr0_field4_qs = llhd.sig %c0_i11 : i11
    %csr1_we = llhd.sig %false : i1
    %csr1_field0_qs = llhd.sig %c0_i7 : i7
    %csr1_field1_qs = llhd.sig %false : i1
    %csr1_field2_qs = llhd.sig %c0_i7 : i7
    %csr1_field3_qs = llhd.sig %false : i1
    %csr1_field4_qs = llhd.sig %c0_i16 : i16
    %csr2_we = llhd.sig %false : i1
    %csr2_qs = llhd.sig %false : i1
    %csr3_we = llhd.sig %false : i1
    %csr3_field0_qs = llhd.sig %c0_i3 : i3
    %csr3_field1_qs = llhd.sig %c0_i10 : i10
    %csr3_field2_qs = llhd.sig %false : i1
    %csr3_field3_qs = llhd.sig %false : i1
    %csr3_field4_qs = llhd.sig %false : i1
    %csr3_field5_qs = llhd.sig %false : i1
    %csr3_field6_qs = llhd.sig %false : i1
    %csr3_field7_qs = llhd.sig %false : i1
    %csr3_field8_qs = llhd.sig %false : i1
    %csr4_we = llhd.sig %false : i1
    %csr4_field0_qs = llhd.sig %c0_i10 : i10
    %csr4_field1_qs = llhd.sig %false : i1
    %csr4_field2_qs = llhd.sig %false : i1
    %csr4_field3_qs = llhd.sig %false : i1
    %csr5_we = llhd.sig %false : i1
    %csr5_field0_qs = llhd.sig %c0_i6 : i6
    %csr5_field1_qs = llhd.sig %c0_i2 : i2
    %csr5_field2_qs = llhd.sig %false : i1
    %csr5_field3_qs = llhd.sig %c0_i3 : i3
    %csr5_field4_qs = llhd.sig %false : i1
    %csr5_field5_qs = llhd.sig %false : i1
    %csr5_field6_qs = llhd.sig %c0_i16 : i16
    %csr6_we = llhd.sig %false : i1
    %csr6_field0_qs = llhd.sig %c0_i10 : i10
    %csr6_field1_qs = llhd.sig %false : i1
    %csr6_field2_qs = llhd.sig %false : i1
    %csr6_field3_qs = llhd.sig %c0_i16 : i16
    %csr7_field0_qs = llhd.sig %c0_i6 : i6
    %csr7_field1_qs = llhd.sig %c0_i3 : i3
    %csr7_field2_qs = llhd.sig %false : i1
    %csr7_field3_qs = llhd.sig %false : i1
    %addr_hit = llhd.sig %c0_i8 : i8
    %racl_role_vec = llhd.sig %c0_i2 : i2
    %racl_addr_hit_read = llhd.sig %c0_i8 : i8
    %racl_addr_hit_write = llhd.sig %c0_i8 : i8
    %u_chk.err_o = hw.instance "u_chk" @tlul_cmd_intg_chk(tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> (err_o: i1)
    llhd.drv %intg_err, %u_chk.err_o after %1 : i1
    %7 = llhd.prb %reg_we_check : i8
    %8 = llhd.prb %reg_we : i1
    %9 = comb.xor %121, %true : i1
    %10 = comb.and %8, %9 : i1
    %u_prim_reg_we_check.err_o = hw.instance "u_prim_reg_we_check" @prim_reg_we_check(clk_i: %5: i1, rst_ni: %6: i1, oh_i: %7: i8, en_i: %10: i1) -> (err_o: i1)
    llhd.drv %reg_we_err, %u_prim_reg_we_check.err_o after %1 : i1
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen(tl_i: %u_reg_if.tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
    %11 = llhd.prb %racl_error_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %valid = hw.struct_extract %11["valid"] : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %12 = comb.or %111, %valid : i1
    %u_reg_if.tl_o, %u_reg_if.intg_error_o, %u_reg_if.re_o, %u_reg_if.we_o, %u_reg_if.addr_o, %u_reg_if.wdata_o, %u_reg_if.be_o = hw.instance "u_reg_if" @tlul_adapter_reg(clk_i: %5: i1, rst_ni: %6: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, en_ifetch_i: %c-7_i4: i4, busy_i: %false: i1, rdata_i: %109: i32, error_i: %12: i1) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, intg_error_o: i1, re_o: i1, we_o: i1, addr_o: i5, wdata_o: i32, be_o: i4) {sv.namehint = "reg_re"}
    llhd.drv %reg_we, %u_reg_if.we_o after %1 : i1
    llhd.drv %reg_addr, %u_reg_if.addr_o after %1 : i5
    llhd.drv %reg_be, %u_reg_if.be_o after %1 : i4
    %13 = llhd.prb %csr0_we : i1
    %14 = llhd.sig.struct_extract %reg2hw["csr0"] : <!hw.struct<csr0: !hw.struct<field4: !hw.struct<q: i11>, field3: !hw.struct<q: i10>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i1>>, csr1: !hw.struct<field4: !hw.struct<q: i16>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i7>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i7>>, csr2: !hw.struct<q: i1>, csr3: !hw.struct<field8: !hw.struct<q: i1>, field7: !hw.struct<q: i1>, field6: !hw.struct<q: i1>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i10>, field0: !hw.struct<q: i3>>, csr4: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr5: !hw.struct<field6: !hw.struct<q: i16>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i3>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i2>, field0: !hw.struct<q: i6>>, csr6: !hw.struct<field3: !hw.struct<q: i16>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr7: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i3>, field0: !hw.struct<q: i6>>>>
    %15 = llhd.sig.struct_extract %14["field0"] : <!hw.struct<field4: !hw.struct<q: i11>, field3: !hw.struct<q: i10>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i1>>>
    %16 = llhd.sig.struct_extract %15["q"] : <!hw.struct<q: i1>>
    %u_csr0_field0.qe, %u_csr0_field0.q, %u_csr0_field0.ds, %u_csr0_field0.qs = hw.instance "u_csr0_field0" @prim_subreg(clk_i: %5: i1, rst_ni: %6: i1, we: %13: i1, wd: %139: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %16, %u_csr0_field0.q after %1 : i1
    llhd.drv %csr0_field0_qs, %u_csr0_field0.qs after %1 : i1
    %17 = llhd.sig.struct_extract %14["field1"] : <!hw.struct<field4: !hw.struct<q: i11>, field3: !hw.struct<q: i10>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i1>>>
    %18 = llhd.sig.struct_extract %17["q"] : <!hw.struct<q: i1>>
    %u_csr0_field1.qe, %u_csr0_field1.q, %u_csr0_field1.ds, %u_csr0_field1.qs = hw.instance "u_csr0_field1" @prim_subreg(clk_i: %5: i1, rst_ni: %6: i1, we: %13: i1, wd: %140: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %18, %u_csr0_field1.q after %1 : i1
    llhd.drv %csr0_field1_qs, %u_csr0_field1.qs after %1 : i1
    %19 = llhd.sig.struct_extract %14["field2"] : <!hw.struct<field4: !hw.struct<q: i11>, field3: !hw.struct<q: i10>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i1>>>
    %20 = llhd.sig.struct_extract %19["q"] : <!hw.struct<q: i1>>
    %u_csr0_field2.qe, %u_csr0_field2.q, %u_csr0_field2.ds, %u_csr0_field2.qs = hw.instance "u_csr0_field2" @prim_subreg(clk_i: %5: i1, rst_ni: %6: i1, we: %13: i1, wd: %141: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %20, %u_csr0_field2.q after %1 : i1
    llhd.drv %csr0_field2_qs, %u_csr0_field2.qs after %1 : i1
    %21 = llhd.sig.struct_extract %14["field3"] : <!hw.struct<field4: !hw.struct<q: i11>, field3: !hw.struct<q: i10>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i1>>>
    %22 = llhd.sig.struct_extract %21["q"] : <!hw.struct<q: i10>>
    %u_csr0_field3.qe, %u_csr0_field3.q, %u_csr0_field3.ds, %u_csr0_field3.qs = hw.instance "u_csr0_field3" @prim_subreg_3(clk_i: %5: i1, rst_ni: %6: i1, we: %13: i1, wd: %142: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %22, %u_csr0_field3.q after %1 : i10
    llhd.drv %csr0_field3_qs, %u_csr0_field3.qs after %1 : i10
    %23 = llhd.sig.struct_extract %14["field4"] : <!hw.struct<field4: !hw.struct<q: i11>, field3: !hw.struct<q: i10>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i1>>>
    %24 = llhd.sig.struct_extract %23["q"] : <!hw.struct<q: i11>>
    %u_csr0_field4.qe, %u_csr0_field4.q, %u_csr0_field4.ds, %u_csr0_field4.qs = hw.instance "u_csr0_field4" @prim_subreg_4(clk_i: %5: i1, rst_ni: %6: i1, we: %13: i1, wd: %143: i11, de: %false: i1, d: %c0_i11: i11) -> (qe: i1, q: i11, ds: i11, qs: i11)
    llhd.drv %24, %u_csr0_field4.q after %1 : i11
    llhd.drv %csr0_field4_qs, %u_csr0_field4.qs after %1 : i11
    %25 = llhd.prb %csr1_we : i1
    %26 = llhd.sig.struct_extract %reg2hw["csr1"] : <!hw.struct<csr0: !hw.struct<field4: !hw.struct<q: i11>, field3: !hw.struct<q: i10>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i1>>, csr1: !hw.struct<field4: !hw.struct<q: i16>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i7>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i7>>, csr2: !hw.struct<q: i1>, csr3: !hw.struct<field8: !hw.struct<q: i1>, field7: !hw.struct<q: i1>, field6: !hw.struct<q: i1>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i10>, field0: !hw.struct<q: i3>>, csr4: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr5: !hw.struct<field6: !hw.struct<q: i16>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i3>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i2>, field0: !hw.struct<q: i6>>, csr6: !hw.struct<field3: !hw.struct<q: i16>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr7: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i3>, field0: !hw.struct<q: i6>>>>
    %27 = llhd.sig.struct_extract %26["field0"] : <!hw.struct<field4: !hw.struct<q: i16>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i7>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i7>>>
    %28 = llhd.sig.struct_extract %27["q"] : <!hw.struct<q: i7>>
    %u_csr1_field0.qe, %u_csr1_field0.q, %u_csr1_field0.ds, %u_csr1_field0.qs = hw.instance "u_csr1_field0" @prim_subreg_5(clk_i: %5: i1, rst_ni: %6: i1, we: %25: i1, wd: %146: i7, de: %false: i1, d: %c0_i7: i7) -> (qe: i1, q: i7, ds: i7, qs: i7)
    llhd.drv %28, %u_csr1_field0.q after %1 : i7
    llhd.drv %csr1_field0_qs, %u_csr1_field0.qs after %1 : i7
    %29 = llhd.sig.struct_extract %26["field1"] : <!hw.struct<field4: !hw.struct<q: i16>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i7>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i7>>>
    %30 = llhd.sig.struct_extract %29["q"] : <!hw.struct<q: i1>>
    %u_csr1_field1.qe, %u_csr1_field1.q, %u_csr1_field1.ds, %u_csr1_field1.qs = hw.instance "u_csr1_field1" @prim_subreg(clk_i: %5: i1, rst_ni: %6: i1, we: %25: i1, wd: %147: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %30, %u_csr1_field1.q after %1 : i1
    llhd.drv %csr1_field1_qs, %u_csr1_field1.qs after %1 : i1
    %31 = llhd.sig.struct_extract %26["field2"] : <!hw.struct<field4: !hw.struct<q: i16>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i7>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i7>>>
    %32 = llhd.sig.struct_extract %31["q"] : <!hw.struct<q: i7>>
    %u_csr1_field2.qe, %u_csr1_field2.q, %u_csr1_field2.ds, %u_csr1_field2.qs = hw.instance "u_csr1_field2" @prim_subreg_5(clk_i: %5: i1, rst_ni: %6: i1, we: %25: i1, wd: %148: i7, de: %false: i1, d: %c0_i7: i7) -> (qe: i1, q: i7, ds: i7, qs: i7)
    llhd.drv %32, %u_csr1_field2.q after %1 : i7
    llhd.drv %csr1_field2_qs, %u_csr1_field2.qs after %1 : i7
    %33 = llhd.sig.struct_extract %26["field3"] : <!hw.struct<field4: !hw.struct<q: i16>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i7>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i7>>>
    %34 = llhd.sig.struct_extract %33["q"] : <!hw.struct<q: i1>>
    %u_csr1_field3.qe, %u_csr1_field3.q, %u_csr1_field3.ds, %u_csr1_field3.qs = hw.instance "u_csr1_field3" @prim_subreg(clk_i: %5: i1, rst_ni: %6: i1, we: %25: i1, wd: %149: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %34, %u_csr1_field3.q after %1 : i1
    llhd.drv %csr1_field3_qs, %u_csr1_field3.qs after %1 : i1
    %35 = llhd.sig.struct_extract %26["field4"] : <!hw.struct<field4: !hw.struct<q: i16>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i7>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i7>>>
    %36 = llhd.sig.struct_extract %35["q"] : <!hw.struct<q: i16>>
    %u_csr1_field4.qe, %u_csr1_field4.q, %u_csr1_field4.ds, %u_csr1_field4.qs = hw.instance "u_csr1_field4" @prim_subreg_6(clk_i: %5: i1, rst_ni: %6: i1, we: %25: i1, wd: %150: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %36, %u_csr1_field4.q after %1 : i16
    llhd.drv %csr1_field4_qs, %u_csr1_field4.qs after %1 : i16
    %37 = llhd.prb %csr2_we : i1
    %38 = llhd.sig.struct_extract %reg2hw["csr2"] : <!hw.struct<csr0: !hw.struct<field4: !hw.struct<q: i11>, field3: !hw.struct<q: i10>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i1>>, csr1: !hw.struct<field4: !hw.struct<q: i16>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i7>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i7>>, csr2: !hw.struct<q: i1>, csr3: !hw.struct<field8: !hw.struct<q: i1>, field7: !hw.struct<q: i1>, field6: !hw.struct<q: i1>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i10>, field0: !hw.struct<q: i3>>, csr4: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr5: !hw.struct<field6: !hw.struct<q: i16>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i3>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i2>, field0: !hw.struct<q: i6>>, csr6: !hw.struct<field3: !hw.struct<q: i16>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr7: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i3>, field0: !hw.struct<q: i6>>>>
    %39 = llhd.sig.struct_extract %38["q"] : <!hw.struct<q: i1>>
    %u_csr2.qe, %u_csr2.q, %u_csr2.ds, %u_csr2.qs = hw.instance "u_csr2" @prim_subreg(clk_i: %5: i1, rst_ni: %6: i1, we: %37: i1, wd: %139: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %39, %u_csr2.q after %1 : i1
    llhd.drv %csr2_qs, %u_csr2.qs after %1 : i1
    %40 = llhd.prb %csr3_we : i1
    %csr3 = hw.struct_extract %hw2reg["csr3"] : !hw.struct<csr3: !hw.struct<field8: !hw.struct<d: i1, de: i1>, field7: !hw.struct<d: i1, de: i1>, field6: !hw.struct<d: i1, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i1, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i10, de: i1>, field0: !hw.struct<d: i3, de: i1>>, csr5: !hw.struct<field6: !hw.struct<d: i16, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i3, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i2, de: i1>, field0: !hw.struct<d: i6, de: i1>>, csr7: !hw.struct<field3: !hw.struct<d: i1, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i3, de: i1>, field0: !hw.struct<d: i6, de: i1>>>
    %field0 = hw.struct_extract %csr3["field0"] : !hw.struct<field8: !hw.struct<d: i1, de: i1>, field7: !hw.struct<d: i1, de: i1>, field6: !hw.struct<d: i1, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i1, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i10, de: i1>, field0: !hw.struct<d: i3, de: i1>>
    %de = hw.struct_extract %field0["de"] : !hw.struct<d: i3, de: i1>
    %d = hw.struct_extract %field0["d"] : !hw.struct<d: i3, de: i1>
    %41 = llhd.sig.struct_extract %reg2hw["csr3"] : <!hw.struct<csr0: !hw.struct<field4: !hw.struct<q: i11>, field3: !hw.struct<q: i10>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i1>>, csr1: !hw.struct<field4: !hw.struct<q: i16>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i7>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i7>>, csr2: !hw.struct<q: i1>, csr3: !hw.struct<field8: !hw.struct<q: i1>, field7: !hw.struct<q: i1>, field6: !hw.struct<q: i1>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i10>, field0: !hw.struct<q: i3>>, csr4: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr5: !hw.struct<field6: !hw.struct<q: i16>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i3>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i2>, field0: !hw.struct<q: i6>>, csr6: !hw.struct<field3: !hw.struct<q: i16>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr7: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i3>, field0: !hw.struct<q: i6>>>>
    %42 = llhd.sig.struct_extract %41["field0"] : <!hw.struct<field8: !hw.struct<q: i1>, field7: !hw.struct<q: i1>, field6: !hw.struct<q: i1>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i10>, field0: !hw.struct<q: i3>>>
    %43 = llhd.sig.struct_extract %42["q"] : <!hw.struct<q: i3>>
    %u_csr3_field0.qe, %u_csr3_field0.q, %u_csr3_field0.ds, %u_csr3_field0.qs = hw.instance "u_csr3_field0" @prim_subreg_7(clk_i: %5: i1, rst_ni: %6: i1, we: %40: i1, wd: %155: i3, de: %de: i1, d: %d: i3) -> (qe: i1, q: i3, ds: i3, qs: i3)
    llhd.drv %43, %u_csr3_field0.q after %1 : i3
    llhd.drv %csr3_field0_qs, %u_csr3_field0.qs after %1 : i3
    %field1 = hw.struct_extract %csr3["field1"] : !hw.struct<field8: !hw.struct<d: i1, de: i1>, field7: !hw.struct<d: i1, de: i1>, field6: !hw.struct<d: i1, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i1, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i10, de: i1>, field0: !hw.struct<d: i3, de: i1>>
    %de_3 = hw.struct_extract %field1["de"] : !hw.struct<d: i10, de: i1>
    %d_4 = hw.struct_extract %field1["d"] : !hw.struct<d: i10, de: i1>
    %44 = llhd.sig.struct_extract %41["field1"] : <!hw.struct<field8: !hw.struct<q: i1>, field7: !hw.struct<q: i1>, field6: !hw.struct<q: i1>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i10>, field0: !hw.struct<q: i3>>>
    %45 = llhd.sig.struct_extract %44["q"] : <!hw.struct<q: i10>>
    %u_csr3_field1.qe, %u_csr3_field1.q, %u_csr3_field1.ds, %u_csr3_field1.qs = hw.instance "u_csr3_field1" @prim_subreg_8(clk_i: %5: i1, rst_ni: %6: i1, we: %40: i1, wd: %142: i10, de: %de_3: i1, d: %d_4: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %45, %u_csr3_field1.q after %1 : i10
    llhd.drv %csr3_field1_qs, %u_csr3_field1.qs after %1 : i10
    %field2 = hw.struct_extract %csr3["field2"] : !hw.struct<field8: !hw.struct<d: i1, de: i1>, field7: !hw.struct<d: i1, de: i1>, field6: !hw.struct<d: i1, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i1, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i10, de: i1>, field0: !hw.struct<d: i3, de: i1>>
    %de_5 = hw.struct_extract %field2["de"] : !hw.struct<d: i1, de: i1>
    %d_6 = hw.struct_extract %field2["d"] : !hw.struct<d: i1, de: i1>
    %46 = llhd.sig.struct_extract %41["field2"] : <!hw.struct<field8: !hw.struct<q: i1>, field7: !hw.struct<q: i1>, field6: !hw.struct<q: i1>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i10>, field0: !hw.struct<q: i3>>>
    %47 = llhd.sig.struct_extract %46["q"] : <!hw.struct<q: i1>>
    %u_csr3_field2.qe, %u_csr3_field2.q, %u_csr3_field2.ds, %u_csr3_field2.qs = hw.instance "u_csr3_field2" @prim_subreg_9(clk_i: %5: i1, rst_ni: %6: i1, we: %40: i1, wd: %156: i1, de: %de_5: i1, d: %d_6: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %47, %u_csr3_field2.q after %1 : i1
    llhd.drv %csr3_field2_qs, %u_csr3_field2.qs after %1 : i1
    %field3 = hw.struct_extract %csr3["field3"] : !hw.struct<field8: !hw.struct<d: i1, de: i1>, field7: !hw.struct<d: i1, de: i1>, field6: !hw.struct<d: i1, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i1, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i10, de: i1>, field0: !hw.struct<d: i3, de: i1>>
    %de_7 = hw.struct_extract %field3["de"] : !hw.struct<d: i1, de: i1>
    %d_8 = hw.struct_extract %field3["d"] : !hw.struct<d: i1, de: i1>
    %48 = llhd.sig.struct_extract %41["field3"] : <!hw.struct<field8: !hw.struct<q: i1>, field7: !hw.struct<q: i1>, field6: !hw.struct<q: i1>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i10>, field0: !hw.struct<q: i3>>>
    %49 = llhd.sig.struct_extract %48["q"] : <!hw.struct<q: i1>>
    %u_csr3_field3.qe, %u_csr3_field3.q, %u_csr3_field3.ds, %u_csr3_field3.qs = hw.instance "u_csr3_field3" @prim_subreg_10(clk_i: %5: i1, rst_ni: %6: i1, we: %false: i1, wd: %false: i1, de: %de_7: i1, d: %d_8: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %49, %u_csr3_field3.q after %1 : i1
    llhd.drv %csr3_field3_qs, %u_csr3_field3.qs after %1 : i1
    %field4 = hw.struct_extract %csr3["field4"] : !hw.struct<field8: !hw.struct<d: i1, de: i1>, field7: !hw.struct<d: i1, de: i1>, field6: !hw.struct<d: i1, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i1, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i10, de: i1>, field0: !hw.struct<d: i3, de: i1>>
    %de_9 = hw.struct_extract %field4["de"] : !hw.struct<d: i1, de: i1>
    %d_10 = hw.struct_extract %field4["d"] : !hw.struct<d: i1, de: i1>
    %50 = llhd.sig.struct_extract %41["field4"] : <!hw.struct<field8: !hw.struct<q: i1>, field7: !hw.struct<q: i1>, field6: !hw.struct<q: i1>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i10>, field0: !hw.struct<q: i3>>>
    %51 = llhd.sig.struct_extract %50["q"] : <!hw.struct<q: i1>>
    %u_csr3_field4.qe, %u_csr3_field4.q, %u_csr3_field4.ds, %u_csr3_field4.qs = hw.instance "u_csr3_field4" @prim_subreg_10(clk_i: %5: i1, rst_ni: %6: i1, we: %false: i1, wd: %false: i1, de: %de_9: i1, d: %d_10: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %51, %u_csr3_field4.q after %1 : i1
    llhd.drv %csr3_field4_qs, %u_csr3_field4.qs after %1 : i1
    %field5 = hw.struct_extract %csr3["field5"] : !hw.struct<field8: !hw.struct<d: i1, de: i1>, field7: !hw.struct<d: i1, de: i1>, field6: !hw.struct<d: i1, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i1, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i10, de: i1>, field0: !hw.struct<d: i3, de: i1>>
    %de_11 = hw.struct_extract %field5["de"] : !hw.struct<d: i1, de: i1>
    %d_12 = hw.struct_extract %field5["d"] : !hw.struct<d: i1, de: i1>
    %52 = llhd.sig.struct_extract %41["field5"] : <!hw.struct<field8: !hw.struct<q: i1>, field7: !hw.struct<q: i1>, field6: !hw.struct<q: i1>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i10>, field0: !hw.struct<q: i3>>>
    %53 = llhd.sig.struct_extract %52["q"] : <!hw.struct<q: i1>>
    %u_csr3_field5.qe, %u_csr3_field5.q, %u_csr3_field5.ds, %u_csr3_field5.qs = hw.instance "u_csr3_field5" @prim_subreg_10(clk_i: %5: i1, rst_ni: %6: i1, we: %false: i1, wd: %false: i1, de: %de_11: i1, d: %d_12: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %53, %u_csr3_field5.q after %1 : i1
    llhd.drv %csr3_field5_qs, %u_csr3_field5.qs after %1 : i1
    %field6 = hw.struct_extract %csr3["field6"] : !hw.struct<field8: !hw.struct<d: i1, de: i1>, field7: !hw.struct<d: i1, de: i1>, field6: !hw.struct<d: i1, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i1, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i10, de: i1>, field0: !hw.struct<d: i3, de: i1>>
    %de_13 = hw.struct_extract %field6["de"] : !hw.struct<d: i1, de: i1>
    %d_14 = hw.struct_extract %field6["d"] : !hw.struct<d: i1, de: i1>
    %54 = llhd.sig.struct_extract %41["field6"] : <!hw.struct<field8: !hw.struct<q: i1>, field7: !hw.struct<q: i1>, field6: !hw.struct<q: i1>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i10>, field0: !hw.struct<q: i3>>>
    %55 = llhd.sig.struct_extract %54["q"] : <!hw.struct<q: i1>>
    %u_csr3_field6.qe, %u_csr3_field6.q, %u_csr3_field6.ds, %u_csr3_field6.qs = hw.instance "u_csr3_field6" @prim_subreg_10(clk_i: %5: i1, rst_ni: %6: i1, we: %false: i1, wd: %false: i1, de: %de_13: i1, d: %d_14: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %55, %u_csr3_field6.q after %1 : i1
    llhd.drv %csr3_field6_qs, %u_csr3_field6.qs after %1 : i1
    %field7 = hw.struct_extract %csr3["field7"] : !hw.struct<field8: !hw.struct<d: i1, de: i1>, field7: !hw.struct<d: i1, de: i1>, field6: !hw.struct<d: i1, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i1, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i10, de: i1>, field0: !hw.struct<d: i3, de: i1>>
    %de_15 = hw.struct_extract %field7["de"] : !hw.struct<d: i1, de: i1>
    %d_16 = hw.struct_extract %field7["d"] : !hw.struct<d: i1, de: i1>
    %56 = llhd.sig.struct_extract %41["field7"] : <!hw.struct<field8: !hw.struct<q: i1>, field7: !hw.struct<q: i1>, field6: !hw.struct<q: i1>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i10>, field0: !hw.struct<q: i3>>>
    %57 = llhd.sig.struct_extract %56["q"] : <!hw.struct<q: i1>>
    %u_csr3_field7.qe, %u_csr3_field7.q, %u_csr3_field7.ds, %u_csr3_field7.qs = hw.instance "u_csr3_field7" @prim_subreg_10(clk_i: %5: i1, rst_ni: %6: i1, we: %false: i1, wd: %false: i1, de: %de_15: i1, d: %d_16: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %57, %u_csr3_field7.q after %1 : i1
    llhd.drv %csr3_field7_qs, %u_csr3_field7.qs after %1 : i1
    %field8 = hw.struct_extract %csr3["field8"] : !hw.struct<field8: !hw.struct<d: i1, de: i1>, field7: !hw.struct<d: i1, de: i1>, field6: !hw.struct<d: i1, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i1, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i10, de: i1>, field0: !hw.struct<d: i3, de: i1>>
    %de_17 = hw.struct_extract %field8["de"] : !hw.struct<d: i1, de: i1>
    %d_18 = hw.struct_extract %field8["d"] : !hw.struct<d: i1, de: i1>
    %58 = llhd.sig.struct_extract %41["field8"] : <!hw.struct<field8: !hw.struct<q: i1>, field7: !hw.struct<q: i1>, field6: !hw.struct<q: i1>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i10>, field0: !hw.struct<q: i3>>>
    %59 = llhd.sig.struct_extract %58["q"] : <!hw.struct<q: i1>>
    %u_csr3_field8.qe, %u_csr3_field8.q, %u_csr3_field8.ds, %u_csr3_field8.qs = hw.instance "u_csr3_field8" @prim_subreg_10(clk_i: %5: i1, rst_ni: %6: i1, we: %false: i1, wd: %false: i1, de: %de_17: i1, d: %d_18: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %59, %u_csr3_field8.q after %1 : i1
    llhd.drv %csr3_field8_qs, %u_csr3_field8.qs after %1 : i1
    %60 = llhd.prb %csr4_we : i1
    %61 = llhd.sig.struct_extract %reg2hw["csr4"] : <!hw.struct<csr0: !hw.struct<field4: !hw.struct<q: i11>, field3: !hw.struct<q: i10>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i1>>, csr1: !hw.struct<field4: !hw.struct<q: i16>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i7>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i7>>, csr2: !hw.struct<q: i1>, csr3: !hw.struct<field8: !hw.struct<q: i1>, field7: !hw.struct<q: i1>, field6: !hw.struct<q: i1>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i10>, field0: !hw.struct<q: i3>>, csr4: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr5: !hw.struct<field6: !hw.struct<q: i16>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i3>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i2>, field0: !hw.struct<q: i6>>, csr6: !hw.struct<field3: !hw.struct<q: i16>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr7: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i3>, field0: !hw.struct<q: i6>>>>
    %62 = llhd.sig.struct_extract %61["field0"] : <!hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>>
    %63 = llhd.sig.struct_extract %62["q"] : <!hw.struct<q: i10>>
    %u_csr4_field0.qe, %u_csr4_field0.q, %u_csr4_field0.ds, %u_csr4_field0.qs = hw.instance "u_csr4_field0" @prim_subreg_3(clk_i: %5: i1, rst_ni: %6: i1, we: %60: i1, wd: %159: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %63, %u_csr4_field0.q after %1 : i10
    llhd.drv %csr4_field0_qs, %u_csr4_field0.qs after %1 : i10
    %64 = llhd.sig.struct_extract %61["field1"] : <!hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>>
    %65 = llhd.sig.struct_extract %64["q"] : <!hw.struct<q: i1>>
    %u_csr4_field1.qe, %u_csr4_field1.q, %u_csr4_field1.ds, %u_csr4_field1.qs = hw.instance "u_csr4_field1" @prim_subreg(clk_i: %5: i1, rst_ni: %6: i1, we: %60: i1, wd: %160: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %65, %u_csr4_field1.q after %1 : i1
    llhd.drv %csr4_field1_qs, %u_csr4_field1.qs after %1 : i1
    %66 = llhd.sig.struct_extract %61["field2"] : <!hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>>
    %67 = llhd.sig.struct_extract %66["q"] : <!hw.struct<q: i1>>
    %u_csr4_field2.qe, %u_csr4_field2.q, %u_csr4_field2.ds, %u_csr4_field2.qs = hw.instance "u_csr4_field2" @prim_subreg(clk_i: %5: i1, rst_ni: %6: i1, we: %60: i1, wd: %161: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %67, %u_csr4_field2.q after %1 : i1
    llhd.drv %csr4_field2_qs, %u_csr4_field2.qs after %1 : i1
    %68 = llhd.sig.struct_extract %61["field3"] : <!hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>>
    %69 = llhd.sig.struct_extract %68["q"] : <!hw.struct<q: i1>>
    %u_csr4_field3.qe, %u_csr4_field3.q, %u_csr4_field3.ds, %u_csr4_field3.qs = hw.instance "u_csr4_field3" @prim_subreg(clk_i: %5: i1, rst_ni: %6: i1, we: %60: i1, wd: %162: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %69, %u_csr4_field3.q after %1 : i1
    llhd.drv %csr4_field3_qs, %u_csr4_field3.qs after %1 : i1
    %70 = llhd.prb %csr5_we : i1
    %csr5 = hw.struct_extract %hw2reg["csr5"] : !hw.struct<csr3: !hw.struct<field8: !hw.struct<d: i1, de: i1>, field7: !hw.struct<d: i1, de: i1>, field6: !hw.struct<d: i1, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i1, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i10, de: i1>, field0: !hw.struct<d: i3, de: i1>>, csr5: !hw.struct<field6: !hw.struct<d: i16, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i3, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i2, de: i1>, field0: !hw.struct<d: i6, de: i1>>, csr7: !hw.struct<field3: !hw.struct<d: i1, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i3, de: i1>, field0: !hw.struct<d: i6, de: i1>>>
    %field0_19 = hw.struct_extract %csr5["field0"] : !hw.struct<field6: !hw.struct<d: i16, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i3, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i2, de: i1>, field0: !hw.struct<d: i6, de: i1>>
    %de_20 = hw.struct_extract %field0_19["de"] : !hw.struct<d: i6, de: i1>
    %d_21 = hw.struct_extract %field0_19["d"] : !hw.struct<d: i6, de: i1>
    %71 = llhd.sig.struct_extract %reg2hw["csr5"] : <!hw.struct<csr0: !hw.struct<field4: !hw.struct<q: i11>, field3: !hw.struct<q: i10>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i1>>, csr1: !hw.struct<field4: !hw.struct<q: i16>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i7>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i7>>, csr2: !hw.struct<q: i1>, csr3: !hw.struct<field8: !hw.struct<q: i1>, field7: !hw.struct<q: i1>, field6: !hw.struct<q: i1>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i10>, field0: !hw.struct<q: i3>>, csr4: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr5: !hw.struct<field6: !hw.struct<q: i16>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i3>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i2>, field0: !hw.struct<q: i6>>, csr6: !hw.struct<field3: !hw.struct<q: i16>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr7: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i3>, field0: !hw.struct<q: i6>>>>
    %72 = llhd.sig.struct_extract %71["field0"] : <!hw.struct<field6: !hw.struct<q: i16>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i3>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i2>, field0: !hw.struct<q: i6>>>
    %73 = llhd.sig.struct_extract %72["q"] : <!hw.struct<q: i6>>
    %u_csr5_field0.qe, %u_csr5_field0.q, %u_csr5_field0.ds, %u_csr5_field0.qs = hw.instance "u_csr5_field0" @prim_subreg_11(clk_i: %5: i1, rst_ni: %6: i1, we: %70: i1, wd: %165: i6, de: %de_20: i1, d: %d_21: i6) -> (qe: i1, q: i6, ds: i6, qs: i6)
    llhd.drv %73, %u_csr5_field0.q after %1 : i6
    llhd.drv %csr5_field0_qs, %u_csr5_field0.qs after %1 : i6
    %field1_22 = hw.struct_extract %csr5["field1"] : !hw.struct<field6: !hw.struct<d: i16, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i3, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i2, de: i1>, field0: !hw.struct<d: i6, de: i1>>
    %de_23 = hw.struct_extract %field1_22["de"] : !hw.struct<d: i2, de: i1>
    %d_24 = hw.struct_extract %field1_22["d"] : !hw.struct<d: i2, de: i1>
    %74 = llhd.sig.struct_extract %71["field1"] : <!hw.struct<field6: !hw.struct<q: i16>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i3>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i2>, field0: !hw.struct<q: i6>>>
    %75 = llhd.sig.struct_extract %74["q"] : <!hw.struct<q: i2>>
    %u_csr5_field1.qe, %u_csr5_field1.q, %u_csr5_field1.ds, %u_csr5_field1.qs = hw.instance "u_csr5_field1" @prim_subreg_12(clk_i: %5: i1, rst_ni: %6: i1, we: %70: i1, wd: %166: i2, de: %de_23: i1, d: %d_24: i2) -> (qe: i1, q: i2, ds: i2, qs: i2)
    llhd.drv %75, %u_csr5_field1.q after %1 : i2
    llhd.drv %csr5_field1_qs, %u_csr5_field1.qs after %1 : i2
    %field2_25 = hw.struct_extract %csr5["field2"] : !hw.struct<field6: !hw.struct<d: i16, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i3, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i2, de: i1>, field0: !hw.struct<d: i6, de: i1>>
    %de_26 = hw.struct_extract %field2_25["de"] : !hw.struct<d: i1, de: i1>
    %d_27 = hw.struct_extract %field2_25["d"] : !hw.struct<d: i1, de: i1>
    %76 = llhd.sig.struct_extract %71["field2"] : <!hw.struct<field6: !hw.struct<q: i16>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i3>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i2>, field0: !hw.struct<q: i6>>>
    %77 = llhd.sig.struct_extract %76["q"] : <!hw.struct<q: i1>>
    %u_csr5_field2.qe, %u_csr5_field2.q, %u_csr5_field2.ds, %u_csr5_field2.qs = hw.instance "u_csr5_field2" @prim_subreg_10(clk_i: %5: i1, rst_ni: %6: i1, we: %false: i1, wd: %false: i1, de: %de_26: i1, d: %d_27: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %77, %u_csr5_field2.q after %1 : i1
    llhd.drv %csr5_field2_qs, %u_csr5_field2.qs after %1 : i1
    %field3_28 = hw.struct_extract %csr5["field3"] : !hw.struct<field6: !hw.struct<d: i16, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i3, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i2, de: i1>, field0: !hw.struct<d: i6, de: i1>>
    %de_29 = hw.struct_extract %field3_28["de"] : !hw.struct<d: i3, de: i1>
    %d_30 = hw.struct_extract %field3_28["d"] : !hw.struct<d: i3, de: i1>
    %78 = llhd.sig.struct_extract %71["field3"] : <!hw.struct<field6: !hw.struct<q: i16>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i3>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i2>, field0: !hw.struct<q: i6>>>
    %79 = llhd.sig.struct_extract %78["q"] : <!hw.struct<q: i3>>
    %u_csr5_field3.qe, %u_csr5_field3.q, %u_csr5_field3.ds, %u_csr5_field3.qs = hw.instance "u_csr5_field3" @prim_subreg_13(clk_i: %5: i1, rst_ni: %6: i1, we: %false: i1, wd: %c0_i3: i3, de: %de_29: i1, d: %d_30: i3) -> (qe: i1, q: i3, ds: i3, qs: i3)
    llhd.drv %79, %u_csr5_field3.q after %1 : i3
    llhd.drv %csr5_field3_qs, %u_csr5_field3.qs after %1 : i3
    %field4_31 = hw.struct_extract %csr5["field4"] : !hw.struct<field6: !hw.struct<d: i16, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i3, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i2, de: i1>, field0: !hw.struct<d: i6, de: i1>>
    %de_32 = hw.struct_extract %field4_31["de"] : !hw.struct<d: i1, de: i1>
    %d_33 = hw.struct_extract %field4_31["d"] : !hw.struct<d: i1, de: i1>
    %80 = llhd.sig.struct_extract %71["field4"] : <!hw.struct<field6: !hw.struct<q: i16>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i3>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i2>, field0: !hw.struct<q: i6>>>
    %81 = llhd.sig.struct_extract %80["q"] : <!hw.struct<q: i1>>
    %u_csr5_field4.qe, %u_csr5_field4.q, %u_csr5_field4.ds, %u_csr5_field4.qs = hw.instance "u_csr5_field4" @prim_subreg_10(clk_i: %5: i1, rst_ni: %6: i1, we: %false: i1, wd: %false: i1, de: %de_32: i1, d: %d_33: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %81, %u_csr5_field4.q after %1 : i1
    llhd.drv %csr5_field4_qs, %u_csr5_field4.qs after %1 : i1
    %field5_34 = hw.struct_extract %csr5["field5"] : !hw.struct<field6: !hw.struct<d: i16, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i3, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i2, de: i1>, field0: !hw.struct<d: i6, de: i1>>
    %de_35 = hw.struct_extract %field5_34["de"] : !hw.struct<d: i1, de: i1>
    %d_36 = hw.struct_extract %field5_34["d"] : !hw.struct<d: i1, de: i1>
    %82 = llhd.sig.struct_extract %71["field5"] : <!hw.struct<field6: !hw.struct<q: i16>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i3>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i2>, field0: !hw.struct<q: i6>>>
    %83 = llhd.sig.struct_extract %82["q"] : <!hw.struct<q: i1>>
    %u_csr5_field5.qe, %u_csr5_field5.q, %u_csr5_field5.ds, %u_csr5_field5.qs = hw.instance "u_csr5_field5" @prim_subreg_10(clk_i: %5: i1, rst_ni: %6: i1, we: %false: i1, wd: %false: i1, de: %de_35: i1, d: %d_36: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %83, %u_csr5_field5.q after %1 : i1
    llhd.drv %csr5_field5_qs, %u_csr5_field5.qs after %1 : i1
    %field6_37 = hw.struct_extract %csr5["field6"] : !hw.struct<field6: !hw.struct<d: i16, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i3, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i2, de: i1>, field0: !hw.struct<d: i6, de: i1>>
    %de_38 = hw.struct_extract %field6_37["de"] : !hw.struct<d: i16, de: i1>
    %d_39 = hw.struct_extract %field6_37["d"] : !hw.struct<d: i16, de: i1>
    %84 = llhd.sig.struct_extract %71["field6"] : <!hw.struct<field6: !hw.struct<q: i16>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i3>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i2>, field0: !hw.struct<q: i6>>>
    %85 = llhd.sig.struct_extract %84["q"] : <!hw.struct<q: i16>>
    %u_csr5_field6.qe, %u_csr5_field6.q, %u_csr5_field6.ds, %u_csr5_field6.qs = hw.instance "u_csr5_field6" @prim_subreg_6(clk_i: %5: i1, rst_ni: %6: i1, we: %70: i1, wd: %150: i16, de: %de_38: i1, d: %d_39: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %85, %u_csr5_field6.q after %1 : i16
    llhd.drv %csr5_field6_qs, %u_csr5_field6.qs after %1 : i16
    %86 = llhd.prb %csr6_we : i1
    %87 = llhd.sig.struct_extract %reg2hw["csr6"] : <!hw.struct<csr0: !hw.struct<field4: !hw.struct<q: i11>, field3: !hw.struct<q: i10>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i1>>, csr1: !hw.struct<field4: !hw.struct<q: i16>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i7>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i7>>, csr2: !hw.struct<q: i1>, csr3: !hw.struct<field8: !hw.struct<q: i1>, field7: !hw.struct<q: i1>, field6: !hw.struct<q: i1>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i10>, field0: !hw.struct<q: i3>>, csr4: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr5: !hw.struct<field6: !hw.struct<q: i16>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i3>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i2>, field0: !hw.struct<q: i6>>, csr6: !hw.struct<field3: !hw.struct<q: i16>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr7: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i3>, field0: !hw.struct<q: i6>>>>
    %88 = llhd.sig.struct_extract %87["field0"] : <!hw.struct<field3: !hw.struct<q: i16>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>>
    %89 = llhd.sig.struct_extract %88["q"] : <!hw.struct<q: i10>>
    %u_csr6_field0.qe, %u_csr6_field0.q, %u_csr6_field0.ds, %u_csr6_field0.qs = hw.instance "u_csr6_field0" @prim_subreg_3(clk_i: %5: i1, rst_ni: %6: i1, we: %86: i1, wd: %159: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %89, %u_csr6_field0.q after %1 : i10
    llhd.drv %csr6_field0_qs, %u_csr6_field0.qs after %1 : i10
    %90 = llhd.sig.struct_extract %87["field1"] : <!hw.struct<field3: !hw.struct<q: i16>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>>
    %91 = llhd.sig.struct_extract %90["q"] : <!hw.struct<q: i1>>
    %u_csr6_field1.qe, %u_csr6_field1.q, %u_csr6_field1.ds, %u_csr6_field1.qs = hw.instance "u_csr6_field1" @prim_subreg(clk_i: %5: i1, rst_ni: %6: i1, we: %86: i1, wd: %169: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %91, %u_csr6_field1.q after %1 : i1
    llhd.drv %csr6_field1_qs, %u_csr6_field1.qs after %1 : i1
    %92 = llhd.sig.struct_extract %87["field2"] : <!hw.struct<field3: !hw.struct<q: i16>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>>
    %93 = llhd.sig.struct_extract %92["q"] : <!hw.struct<q: i1>>
    %u_csr6_field2.qe, %u_csr6_field2.q, %u_csr6_field2.ds, %u_csr6_field2.qs = hw.instance "u_csr6_field2" @prim_subreg(clk_i: %5: i1, rst_ni: %6: i1, we: %86: i1, wd: %160: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %93, %u_csr6_field2.q after %1 : i1
    llhd.drv %csr6_field2_qs, %u_csr6_field2.qs after %1 : i1
    %94 = llhd.sig.struct_extract %87["field3"] : <!hw.struct<field3: !hw.struct<q: i16>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>>
    %95 = llhd.sig.struct_extract %94["q"] : <!hw.struct<q: i16>>
    %u_csr6_field3.qe, %u_csr6_field3.q, %u_csr6_field3.ds, %u_csr6_field3.qs = hw.instance "u_csr6_field3" @prim_subreg_6(clk_i: %5: i1, rst_ni: %6: i1, we: %86: i1, wd: %150: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %95, %u_csr6_field3.q after %1 : i16
    llhd.drv %csr6_field3_qs, %u_csr6_field3.qs after %1 : i16
    %csr7 = hw.struct_extract %hw2reg["csr7"] : !hw.struct<csr3: !hw.struct<field8: !hw.struct<d: i1, de: i1>, field7: !hw.struct<d: i1, de: i1>, field6: !hw.struct<d: i1, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i1, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i10, de: i1>, field0: !hw.struct<d: i3, de: i1>>, csr5: !hw.struct<field6: !hw.struct<d: i16, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i3, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i2, de: i1>, field0: !hw.struct<d: i6, de: i1>>, csr7: !hw.struct<field3: !hw.struct<d: i1, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i3, de: i1>, field0: !hw.struct<d: i6, de: i1>>>
    %field0_40 = hw.struct_extract %csr7["field0"] : !hw.struct<field3: !hw.struct<d: i1, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i3, de: i1>, field0: !hw.struct<d: i6, de: i1>>
    %de_41 = hw.struct_extract %field0_40["de"] : !hw.struct<d: i6, de: i1>
    %d_42 = hw.struct_extract %field0_40["d"] : !hw.struct<d: i6, de: i1>
    %96 = llhd.sig.struct_extract %reg2hw["csr7"] : <!hw.struct<csr0: !hw.struct<field4: !hw.struct<q: i11>, field3: !hw.struct<q: i10>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i1>>, csr1: !hw.struct<field4: !hw.struct<q: i16>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i7>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i7>>, csr2: !hw.struct<q: i1>, csr3: !hw.struct<field8: !hw.struct<q: i1>, field7: !hw.struct<q: i1>, field6: !hw.struct<q: i1>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i10>, field0: !hw.struct<q: i3>>, csr4: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr5: !hw.struct<field6: !hw.struct<q: i16>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i3>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i2>, field0: !hw.struct<q: i6>>, csr6: !hw.struct<field3: !hw.struct<q: i16>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr7: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i3>, field0: !hw.struct<q: i6>>>>
    %97 = llhd.sig.struct_extract %96["field0"] : <!hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i3>, field0: !hw.struct<q: i6>>>
    %98 = llhd.sig.struct_extract %97["q"] : <!hw.struct<q: i6>>
    %u_csr7_field0.qe, %u_csr7_field0.q, %u_csr7_field0.ds, %u_csr7_field0.qs = hw.instance "u_csr7_field0" @prim_subreg_14(clk_i: %5: i1, rst_ni: %6: i1, we: %false: i1, wd: %c0_i6: i6, de: %de_41: i1, d: %d_42: i6) -> (qe: i1, q: i6, ds: i6, qs: i6)
    llhd.drv %98, %u_csr7_field0.q after %1 : i6
    llhd.drv %csr7_field0_qs, %u_csr7_field0.qs after %1 : i6
    %field1_43 = hw.struct_extract %csr7["field1"] : !hw.struct<field3: !hw.struct<d: i1, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i3, de: i1>, field0: !hw.struct<d: i6, de: i1>>
    %de_44 = hw.struct_extract %field1_43["de"] : !hw.struct<d: i3, de: i1>
    %d_45 = hw.struct_extract %field1_43["d"] : !hw.struct<d: i3, de: i1>
    %99 = llhd.sig.struct_extract %96["field1"] : <!hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i3>, field0: !hw.struct<q: i6>>>
    %100 = llhd.sig.struct_extract %99["q"] : <!hw.struct<q: i3>>
    %u_csr7_field1.qe, %u_csr7_field1.q, %u_csr7_field1.ds, %u_csr7_field1.qs = hw.instance "u_csr7_field1" @prim_subreg_13(clk_i: %5: i1, rst_ni: %6: i1, we: %false: i1, wd: %c0_i3: i3, de: %de_44: i1, d: %d_45: i3) -> (qe: i1, q: i3, ds: i3, qs: i3)
    llhd.drv %100, %u_csr7_field1.q after %1 : i3
    llhd.drv %csr7_field1_qs, %u_csr7_field1.qs after %1 : i3
    %field2_46 = hw.struct_extract %csr7["field2"] : !hw.struct<field3: !hw.struct<d: i1, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i3, de: i1>, field0: !hw.struct<d: i6, de: i1>>
    %de_47 = hw.struct_extract %field2_46["de"] : !hw.struct<d: i1, de: i1>
    %d_48 = hw.struct_extract %field2_46["d"] : !hw.struct<d: i1, de: i1>
    %101 = llhd.sig.struct_extract %96["field2"] : <!hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i3>, field0: !hw.struct<q: i6>>>
    %102 = llhd.sig.struct_extract %101["q"] : <!hw.struct<q: i1>>
    %u_csr7_field2.qe, %u_csr7_field2.q, %u_csr7_field2.ds, %u_csr7_field2.qs = hw.instance "u_csr7_field2" @prim_subreg_10(clk_i: %5: i1, rst_ni: %6: i1, we: %false: i1, wd: %false: i1, de: %de_47: i1, d: %d_48: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %102, %u_csr7_field2.q after %1 : i1
    llhd.drv %csr7_field2_qs, %u_csr7_field2.qs after %1 : i1
    %field3_49 = hw.struct_extract %csr7["field3"] : !hw.struct<field3: !hw.struct<d: i1, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i3, de: i1>, field0: !hw.struct<d: i6, de: i1>>
    %de_50 = hw.struct_extract %field3_49["de"] : !hw.struct<d: i1, de: i1>
    %d_51 = hw.struct_extract %field3_49["d"] : !hw.struct<d: i1, de: i1>
    %103 = llhd.sig.struct_extract %96["field3"] : <!hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i3>, field0: !hw.struct<q: i6>>>
    %104 = llhd.sig.struct_extract %103["q"] : <!hw.struct<q: i1>>
    %u_csr7_field3.qe, %u_csr7_field3.q, %u_csr7_field3.ds, %u_csr7_field3.qs = hw.instance "u_csr7_field3" @prim_subreg_10(clk_i: %5: i1, rst_ni: %6: i1, we: %false: i1, wd: %false: i1, de: %de_50: i1, d: %d_51: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %104, %u_csr7_field3.q after %1 : i1
    llhd.drv %csr7_field3_qs, %u_csr7_field3.qs after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %210 = llhd.prb %clk_i_0 : i1
      %211 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%5, %6 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %212 = llhd.prb %clk_i_0 : i1
      %213 = comb.xor bin %210, %true : i1
      %214 = comb.and bin %213, %212 : i1
      %215 = llhd.prb %rst_ni_1 : i1
      %216 = comb.xor bin %215, %true : i1
      %217 = comb.and bin %211, %216 : i1
      %218 = comb.or bin %214, %217 : i1
      cf.cond_br %218, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %219 = llhd.prb %rst_ni_1 : i1
      %220 = comb.xor %219, %true : i1
      cf.cond_br %220, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %err_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %221 = llhd.prb %intg_err : i1
      %222 = llhd.prb %reg_we_err : i1
      %223 = comb.or %221, %222 : i1
      cf.cond_br %223, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %err_q, %true after %0 : i1
      cf.br ^bb1
    }
    %105 = llhd.prb %err_q : i1
    %106 = llhd.prb %intg_err : i1
    %107 = llhd.prb %reg_we_err : i1
    %108 = comb.or %105, %106, %107 : i1
    %109 = llhd.prb %reg_rdata_next {sv.namehint = "reg_rdata"} : i32
    %110 = llhd.prb %wr_err : i1
    %111 = comb.or %121, %110, %106 {sv.namehint = "reg_error"} : i1
    llhd.drv %racl_role_vec, %c0_i2 after %1 : i2
    %112 = llhd.prb %racl_addr_hit_read : i8
    %113 = llhd.prb %racl_addr_hit_write : i8
    %114 = llhd.prb %addr_hit : i8
    %115 = llhd.prb %reg_addr : i5
    %116 = llhd.prb %racl_policies_i_2 : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    %117 = llhd.prb %racl_role_vec : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %racl_addr_hit_read, %c0_i8 after %1 : i8
      llhd.drv %racl_addr_hit_write, %c0_i8 after %1 : i8
      %210 = llhd.sig.extract %addr_hit from %c0_i3 : <i8> -> <i1>
      %211 = llhd.prb %reg_addr : i5
      %212 = comb.icmp eq %211, %c0_i5 : i5
      llhd.drv %210, %212 after %1 : i1
      %213 = llhd.sig.extract %addr_hit from %c1_i3 : <i8> -> <i1>
      %214 = llhd.prb %reg_addr : i5
      %215 = comb.icmp eq %214, %c4_i5 : i5
      llhd.drv %213, %215 after %1 : i1
      %216 = llhd.sig.extract %addr_hit from %c2_i3 : <i8> -> <i1>
      %217 = llhd.prb %reg_addr : i5
      %218 = comb.icmp eq %217, %c8_i5 : i5
      llhd.drv %216, %218 after %1 : i1
      %219 = llhd.sig.extract %addr_hit from %c3_i3 : <i8> -> <i1>
      %220 = llhd.prb %reg_addr : i5
      %221 = comb.icmp eq %220, %c12_i5 : i5
      llhd.drv %219, %221 after %1 : i1
      %222 = llhd.sig.extract %addr_hit from %c-4_i3 : <i8> -> <i1>
      %223 = llhd.prb %reg_addr : i5
      %224 = comb.icmp eq %223, %c-16_i5 : i5
      llhd.drv %222, %224 after %1 : i1
      %225 = llhd.sig.extract %addr_hit from %c-3_i3 : <i8> -> <i1>
      %226 = llhd.prb %reg_addr : i5
      %227 = comb.icmp eq %226, %c-12_i5 : i5
      llhd.drv %225, %227 after %1 : i1
      %228 = llhd.sig.extract %addr_hit from %c-2_i3 : <i8> -> <i1>
      %229 = llhd.prb %reg_addr : i5
      %230 = comb.icmp eq %229, %c-8_i5 : i5
      llhd.drv %228, %230 after %1 : i1
      %231 = llhd.sig.extract %addr_hit from %c-1_i3 : <i8> -> <i1>
      %232 = llhd.prb %reg_addr : i5
      %233 = comb.icmp eq %232, %c-4_i5 : i5
      llhd.drv %231, %233 after %1 : i1
      %234 = llhd.prb %addr_hit : i8
      llhd.drv %racl_addr_hit_read, %234 after %1 : i8
      %235 = llhd.prb %addr_hit : i8
      llhd.drv %racl_addr_hit_write, %235 after %1 : i8
      llhd.wait (%112, %113, %114, %115, %116, %117 : i8, i8, i8, i5, !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, i2), ^bb1
    }
    %118 = comb.or %u_reg_if.re_o, %8 : i1
    %119 = comb.icmp ne %114, %c0_i8 : i8
    %120 = comb.xor %119, %true : i1
    %121 = comb.and %118, %120 {sv.namehint = "addrmiss"} : i1
    %122 = llhd.sig.struct_extract %racl_error_o["valid"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    %123 = comb.icmp eq %112, %c0_i8 : i8
    %124 = comb.and %u_reg_if.re_o, %123 : i1
    %125 = comb.icmp eq %113, %c0_i8 : i8
    %126 = comb.and %8, %125 : i1
    %127 = comb.or %124, %126 : i1
    %128 = comb.and %119, %127 : i1
    llhd.drv %122, %128 after %1 : i1
    %129 = llhd.sig.struct_extract %racl_error_o["request_address"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    %130 = comb.concat %c0_i27, %115 : i27, i5
    llhd.drv %129, %130 after %1 : i32
    %131 = llhd.sig.struct_extract %racl_error_o["racl_role"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %131, %false after %1 : i1
    %132 = llhd.sig.struct_extract %racl_error_o["overflow"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %132, %false after %1 : i1
    %133 = llhd.sig.struct_extract %racl_error_o["ctn_uid"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %133, %false after %1 : i1
    %134 = llhd.sig.struct_extract %racl_error_o["read_access"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %134, %false after %1 : i1
    %135 = llhd.prb %reg_be : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %210 = llhd.prb %reg_we : i1
      %211 = llhd.prb %racl_addr_hit_write : i8
      %212 = comb.extract %211 from 0 : (i8) -> i1
      %213 = llhd.prb %reg_be : i4
      %214 = comb.extract %213 from 0 : (i4) -> i3
      %215 = comb.extract %213 from 0 : (i4) -> i2
      %216 = comb.extract %213 from 0 : (i4) -> i1
      %217 = comb.xor %216, %true : i1
      %218 = comb.icmp ne %213, %c-1_i4 : i4
      %219 = comb.and %212, %218 : i1
      %220 = comb.extract %211 from 1 : (i8) -> i1
      %221 = comb.icmp ne %213, %c-1_i4 : i4
      %222 = comb.and %220, %221 : i1
      %223 = comb.extract %211 from 2 : (i8) -> i1
      %224 = comb.and %223, %217 : i1
      %225 = comb.extract %211 from 3 : (i8) -> i1
      %226 = comb.icmp ne %214, %c-1_i3 : i3
      %227 = comb.and %225, %226 : i1
      %228 = comb.extract %211 from 4 : (i8) -> i1
      %229 = comb.icmp ne %215, %c-1_i2 : i2
      %230 = comb.and %228, %229 : i1
      %231 = comb.extract %211 from 5 : (i8) -> i1
      %232 = comb.icmp ne %213, %c-1_i4 : i4
      %233 = comb.and %231, %232 : i1
      %234 = comb.extract %211 from 6 : (i8) -> i1
      %235 = comb.icmp ne %213, %c-1_i4 : i4
      %236 = comb.and %234, %235 : i1
      %237 = comb.extract %211 from 7 : (i8) -> i1
      %238 = comb.icmp ne %215, %c-1_i2 : i2
      %239 = comb.and %237, %238 : i1
      %240 = comb.or %219, %222, %224, %227, %230, %233, %236, %239 : i1
      %241 = comb.and %210, %240 : i1
      llhd.drv %wr_err, %241 after %1 : i1
      llhd.wait (%8, %113, %135, %110 : i1, i8, i4, i1), ^bb1
    }
    %136 = comb.extract %113 from 0 : (i8) -> i1
    %137 = comb.xor %111, %true : i1
    %138 = comb.and %136, %8, %137 : i1
    llhd.drv %csr0_we, %138 after %1 : i1
    %139 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "csr2_wd"} : (i32) -> i1
    %140 = comb.extract %u_reg_if.wdata_o from 1 {sv.namehint = "csr0_field1_wd"} : (i32) -> i1
    %141 = comb.extract %u_reg_if.wdata_o from 2 {sv.namehint = "csr0_field2_wd"} : (i32) -> i1
    %142 = comb.extract %u_reg_if.wdata_o from 4 {sv.namehint = "csr3_field1_wd"} : (i32) -> i10
    %143 = comb.extract %u_reg_if.wdata_o from 16 {sv.namehint = "csr0_field4_wd"} : (i32) -> i11
    %144 = comb.extract %113 from 1 : (i8) -> i1
    %145 = comb.and %144, %8, %137 : i1
    llhd.drv %csr1_we, %145 after %1 : i1
    %146 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "csr1_field0_wd"} : (i32) -> i7
    %147 = comb.extract %u_reg_if.wdata_o from 7 {sv.namehint = "csr1_field1_wd"} : (i32) -> i1
    %148 = comb.extract %u_reg_if.wdata_o from 8 {sv.namehint = "csr1_field2_wd"} : (i32) -> i7
    %149 = comb.extract %u_reg_if.wdata_o from 15 {sv.namehint = "csr1_field3_wd"} : (i32) -> i1
    %150 = comb.extract %u_reg_if.wdata_o from 16 {sv.namehint = "csr6_field3_wd"} : (i32) -> i16
    %151 = comb.extract %113 from 2 : (i8) -> i1
    %152 = comb.and %151, %8, %137 : i1
    llhd.drv %csr2_we, %152 after %1 : i1
    %153 = comb.extract %113 from 3 : (i8) -> i1
    %154 = comb.and %153, %8, %137 : i1
    llhd.drv %csr3_we, %154 after %1 : i1
    %155 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "csr3_field0_wd"} : (i32) -> i3
    %156 = comb.extract %u_reg_if.wdata_o from 16 {sv.namehint = "csr3_field2_wd"} : (i32) -> i1
    %157 = comb.extract %113 from 4 : (i8) -> i1
    %158 = comb.and %157, %8, %137 : i1
    llhd.drv %csr4_we, %158 after %1 : i1
    %159 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "csr6_field0_wd"} : (i32) -> i10
    %160 = comb.extract %u_reg_if.wdata_o from 12 {sv.namehint = "csr6_field2_wd"} : (i32) -> i1
    %161 = comb.extract %u_reg_if.wdata_o from 13 {sv.namehint = "csr4_field2_wd"} : (i32) -> i1
    %162 = comb.extract %u_reg_if.wdata_o from 14 {sv.namehint = "csr4_field3_wd"} : (i32) -> i1
    %163 = comb.extract %113 from 5 : (i8) -> i1
    %164 = comb.and %163, %8, %137 : i1
    llhd.drv %csr5_we, %164 after %1 : i1
    %165 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "csr5_field0_wd"} : (i32) -> i6
    %166 = comb.extract %u_reg_if.wdata_o from 6 {sv.namehint = "csr5_field1_wd"} : (i32) -> i2
    %167 = comb.extract %113 from 6 : (i8) -> i1
    %168 = comb.and %167, %8, %137 : i1
    llhd.drv %csr6_we, %168 after %1 : i1
    %169 = comb.extract %u_reg_if.wdata_o from 11 {sv.namehint = "csr6_field1_wd"} : (i32) -> i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %210 = llhd.sig.extract %reg_we_check from %c0_i3 : <i8> -> <i1>
      %211 = llhd.prb %csr0_we : i1
      llhd.drv %210, %211 after %1 : i1
      %212 = llhd.sig.extract %reg_we_check from %c1_i3 : <i8> -> <i1>
      %213 = llhd.prb %csr1_we : i1
      llhd.drv %212, %213 after %1 : i1
      %214 = llhd.sig.extract %reg_we_check from %c2_i3 : <i8> -> <i1>
      %215 = llhd.prb %csr2_we : i1
      llhd.drv %214, %215 after %1 : i1
      %216 = llhd.sig.extract %reg_we_check from %c3_i3 : <i8> -> <i1>
      %217 = llhd.prb %csr3_we : i1
      llhd.drv %216, %217 after %1 : i1
      %218 = llhd.sig.extract %reg_we_check from %c-4_i3 : <i8> -> <i1>
      %219 = llhd.prb %csr4_we : i1
      llhd.drv %218, %219 after %1 : i1
      %220 = llhd.sig.extract %reg_we_check from %c-3_i3 : <i8> -> <i1>
      %221 = llhd.prb %csr5_we : i1
      llhd.drv %220, %221 after %1 : i1
      %222 = llhd.sig.extract %reg_we_check from %c-2_i3 : <i8> -> <i1>
      %223 = llhd.prb %csr6_we : i1
      llhd.drv %222, %223 after %1 : i1
      %224 = llhd.sig.extract %reg_we_check from %c-1_i3 : <i8> -> <i1>
      llhd.drv %224, %false after %1 : i1
      llhd.wait (%7, %13, %25, %37, %40, %60, %70, %86 : i8, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    %170 = llhd.prb %csr0_field0_qs : i1
    %171 = llhd.prb %csr0_field1_qs : i1
    %172 = llhd.prb %csr0_field2_qs : i1
    %173 = llhd.prb %csr0_field3_qs : i10
    %174 = llhd.prb %csr0_field4_qs : i11
    %175 = llhd.prb %csr1_field0_qs : i7
    %176 = llhd.prb %csr1_field1_qs : i1
    %177 = llhd.prb %csr1_field2_qs : i7
    %178 = llhd.prb %csr1_field3_qs : i1
    %179 = llhd.prb %csr1_field4_qs : i16
    %180 = llhd.prb %csr2_qs : i1
    %181 = llhd.prb %csr3_field0_qs : i3
    %182 = llhd.prb %csr3_field1_qs : i10
    %183 = llhd.prb %csr3_field2_qs : i1
    %184 = llhd.prb %csr3_field3_qs : i1
    %185 = llhd.prb %csr3_field4_qs : i1
    %186 = llhd.prb %csr3_field5_qs : i1
    %187 = llhd.prb %csr3_field6_qs : i1
    %188 = llhd.prb %csr3_field7_qs : i1
    %189 = llhd.prb %csr3_field8_qs : i1
    %190 = llhd.prb %csr4_field0_qs : i10
    %191 = llhd.prb %csr4_field1_qs : i1
    %192 = llhd.prb %csr4_field2_qs : i1
    %193 = llhd.prb %csr4_field3_qs : i1
    %194 = llhd.prb %csr5_field0_qs : i6
    %195 = llhd.prb %csr5_field1_qs : i2
    %196 = llhd.prb %csr5_field2_qs : i1
    %197 = llhd.prb %csr5_field3_qs : i3
    %198 = llhd.prb %csr5_field4_qs : i1
    %199 = llhd.prb %csr5_field5_qs : i1
    %200 = llhd.prb %csr5_field6_qs : i16
    %201 = llhd.prb %csr6_field0_qs : i10
    %202 = llhd.prb %csr6_field1_qs : i1
    %203 = llhd.prb %csr6_field2_qs : i1
    %204 = llhd.prb %csr6_field3_qs : i16
    %205 = llhd.prb %csr7_field0_qs : i6
    %206 = llhd.prb %csr7_field1_qs : i3
    %207 = llhd.prb %csr7_field2_qs : i1
    %208 = llhd.prb %csr7_field3_qs : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb18
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      %210 = llhd.prb %racl_addr_hit_read : i8
      %211 = comb.extract %210 from 0 : (i8) -> i1
      %212 = comb.icmp ceq %211, %true : i1
      cf.cond_br %212, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %213 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %214 = llhd.prb %csr0_field0_qs : i1
      llhd.drv %213, %214 after %1 : i1
      %215 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %216 = llhd.prb %csr0_field1_qs : i1
      llhd.drv %215, %216 after %1 : i1
      %217 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %218 = llhd.prb %csr0_field2_qs : i1
      llhd.drv %217, %218 after %1 : i1
      %219 = llhd.sig.extract %reg_rdata_next from %c4_i5 : <i32> -> <i10>
      %220 = llhd.prb %csr0_field3_qs : i10
      llhd.drv %219, %220 after %1 : i10
      %221 = llhd.sig.extract %reg_rdata_next from %c-16_i5 : <i32> -> <i11>
      %222 = llhd.prb %csr0_field4_qs : i11
      llhd.drv %221, %222 after %1 : i11
      cf.br ^bb18
    ^bb3:  // pred: ^bb1
      %223 = llhd.prb %racl_addr_hit_read : i8
      %224 = comb.extract %223 from 1 : (i8) -> i1
      %225 = comb.icmp ceq %224, %true : i1
      cf.cond_br %225, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %226 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i7>
      %227 = llhd.prb %csr1_field0_qs : i7
      llhd.drv %226, %227 after %1 : i7
      %228 = llhd.sig.extract %reg_rdata_next from %c7_i5 : <i32> -> <i1>
      %229 = llhd.prb %csr1_field1_qs : i1
      llhd.drv %228, %229 after %1 : i1
      %230 = llhd.sig.extract %reg_rdata_next from %c8_i5 : <i32> -> <i7>
      %231 = llhd.prb %csr1_field2_qs : i7
      llhd.drv %230, %231 after %1 : i7
      %232 = llhd.sig.extract %reg_rdata_next from %c15_i5 : <i32> -> <i1>
      %233 = llhd.prb %csr1_field3_qs : i1
      llhd.drv %232, %233 after %1 : i1
      %234 = llhd.sig.extract %reg_rdata_next from %c-16_i5 : <i32> -> <i16>
      %235 = llhd.prb %csr1_field4_qs : i16
      llhd.drv %234, %235 after %1 : i16
      cf.br ^bb18
    ^bb5:  // pred: ^bb3
      %236 = llhd.prb %racl_addr_hit_read : i8
      %237 = comb.extract %236 from 2 : (i8) -> i1
      %238 = comb.icmp ceq %237, %true : i1
      cf.cond_br %238, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %239 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %240 = llhd.prb %csr2_qs : i1
      llhd.drv %239, %240 after %1 : i1
      cf.br ^bb18
    ^bb7:  // pred: ^bb5
      %241 = llhd.prb %racl_addr_hit_read : i8
      %242 = comb.extract %241 from 3 : (i8) -> i1
      %243 = comb.icmp ceq %242, %true : i1
      cf.cond_br %243, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %244 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i3>
      %245 = llhd.prb %csr3_field0_qs : i3
      llhd.drv %244, %245 after %1 : i3
      %246 = llhd.sig.extract %reg_rdata_next from %c4_i5 : <i32> -> <i10>
      %247 = llhd.prb %csr3_field1_qs : i10
      llhd.drv %246, %247 after %1 : i10
      %248 = llhd.sig.extract %reg_rdata_next from %c-16_i5 : <i32> -> <i1>
      %249 = llhd.prb %csr3_field2_qs : i1
      llhd.drv %248, %249 after %1 : i1
      %250 = llhd.sig.extract %reg_rdata_next from %c-15_i5 : <i32> -> <i1>
      %251 = llhd.prb %csr3_field3_qs : i1
      llhd.drv %250, %251 after %1 : i1
      %252 = llhd.sig.extract %reg_rdata_next from %c-14_i5 : <i32> -> <i1>
      %253 = llhd.prb %csr3_field4_qs : i1
      llhd.drv %252, %253 after %1 : i1
      %254 = llhd.sig.extract %reg_rdata_next from %c-13_i5 : <i32> -> <i1>
      %255 = llhd.prb %csr3_field5_qs : i1
      llhd.drv %254, %255 after %1 : i1
      %256 = llhd.sig.extract %reg_rdata_next from %c-12_i5 : <i32> -> <i1>
      %257 = llhd.prb %csr3_field6_qs : i1
      llhd.drv %256, %257 after %1 : i1
      %258 = llhd.sig.extract %reg_rdata_next from %c-11_i5 : <i32> -> <i1>
      %259 = llhd.prb %csr3_field7_qs : i1
      llhd.drv %258, %259 after %1 : i1
      %260 = llhd.sig.extract %reg_rdata_next from %c-10_i5 : <i32> -> <i1>
      %261 = llhd.prb %csr3_field8_qs : i1
      llhd.drv %260, %261 after %1 : i1
      cf.br ^bb18
    ^bb9:  // pred: ^bb7
      %262 = llhd.prb %racl_addr_hit_read : i8
      %263 = comb.extract %262 from 4 : (i8) -> i1
      %264 = comb.icmp ceq %263, %true : i1
      cf.cond_br %264, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %265 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i10>
      %266 = llhd.prb %csr4_field0_qs : i10
      llhd.drv %265, %266 after %1 : i10
      %267 = llhd.sig.extract %reg_rdata_next from %c12_i5 : <i32> -> <i1>
      %268 = llhd.prb %csr4_field1_qs : i1
      llhd.drv %267, %268 after %1 : i1
      %269 = llhd.sig.extract %reg_rdata_next from %c13_i5 : <i32> -> <i1>
      %270 = llhd.prb %csr4_field2_qs : i1
      llhd.drv %269, %270 after %1 : i1
      %271 = llhd.sig.extract %reg_rdata_next from %c14_i5 : <i32> -> <i1>
      %272 = llhd.prb %csr4_field3_qs : i1
      llhd.drv %271, %272 after %1 : i1
      cf.br ^bb18
    ^bb11:  // pred: ^bb9
      %273 = llhd.prb %racl_addr_hit_read : i8
      %274 = comb.extract %273 from 5 : (i8) -> i1
      %275 = comb.icmp ceq %274, %true : i1
      cf.cond_br %275, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %276 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i6>
      %277 = llhd.prb %csr5_field0_qs : i6
      llhd.drv %276, %277 after %1 : i6
      %278 = llhd.sig.extract %reg_rdata_next from %c6_i5 : <i32> -> <i2>
      %279 = llhd.prb %csr5_field1_qs : i2
      llhd.drv %278, %279 after %1 : i2
      %280 = llhd.sig.extract %reg_rdata_next from %c8_i5 : <i32> -> <i1>
      %281 = llhd.prb %csr5_field2_qs : i1
      llhd.drv %280, %281 after %1 : i1
      %282 = llhd.sig.extract %reg_rdata_next from %c9_i5 : <i32> -> <i3>
      %283 = llhd.prb %csr5_field3_qs : i3
      llhd.drv %282, %283 after %1 : i3
      %284 = llhd.sig.extract %reg_rdata_next from %c12_i5 : <i32> -> <i1>
      %285 = llhd.prb %csr5_field4_qs : i1
      llhd.drv %284, %285 after %1 : i1
      %286 = llhd.sig.extract %reg_rdata_next from %c13_i5 : <i32> -> <i1>
      %287 = llhd.prb %csr5_field5_qs : i1
      llhd.drv %286, %287 after %1 : i1
      %288 = llhd.sig.extract %reg_rdata_next from %c-16_i5 : <i32> -> <i16>
      %289 = llhd.prb %csr5_field6_qs : i16
      llhd.drv %288, %289 after %1 : i16
      cf.br ^bb18
    ^bb13:  // pred: ^bb11
      %290 = llhd.prb %racl_addr_hit_read : i8
      %291 = comb.extract %290 from 6 : (i8) -> i1
      %292 = comb.icmp ceq %291, %true : i1
      cf.cond_br %292, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %293 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i10>
      %294 = llhd.prb %csr6_field0_qs : i10
      llhd.drv %293, %294 after %1 : i10
      %295 = llhd.sig.extract %reg_rdata_next from %c11_i5 : <i32> -> <i1>
      %296 = llhd.prb %csr6_field1_qs : i1
      llhd.drv %295, %296 after %1 : i1
      %297 = llhd.sig.extract %reg_rdata_next from %c12_i5 : <i32> -> <i1>
      %298 = llhd.prb %csr6_field2_qs : i1
      llhd.drv %297, %298 after %1 : i1
      %299 = llhd.sig.extract %reg_rdata_next from %c-16_i5 : <i32> -> <i16>
      %300 = llhd.prb %csr6_field3_qs : i16
      llhd.drv %299, %300 after %1 : i16
      cf.br ^bb18
    ^bb15:  // pred: ^bb13
      %301 = llhd.prb %racl_addr_hit_read : i8
      %302 = comb.extract %301 from 7 : (i8) -> i1
      %303 = comb.icmp ceq %302, %true : i1
      cf.cond_br %303, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      %304 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i6>
      %305 = llhd.prb %csr7_field0_qs : i6
      llhd.drv %304, %305 after %1 : i6
      %306 = llhd.sig.extract %reg_rdata_next from %c8_i5 : <i32> -> <i3>
      %307 = llhd.prb %csr7_field1_qs : i3
      llhd.drv %306, %307 after %1 : i3
      %308 = llhd.sig.extract %reg_rdata_next from %c14_i5 : <i32> -> <i1>
      %309 = llhd.prb %csr7_field2_qs : i1
      llhd.drv %308, %309 after %1 : i1
      %310 = llhd.sig.extract %reg_rdata_next from %c15_i5 : <i32> -> <i1>
      %311 = llhd.prb %csr7_field3_qs : i1
      llhd.drv %310, %311 after %1 : i1
      cf.br ^bb18
    ^bb17:  // pred: ^bb15
      llhd.drv %reg_rdata_next, %c-1_i32 after %1 : i32
      cf.br ^bb18
    ^bb18:  // 9 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb17
      llhd.wait (%109, %112, %170, %171, %172, %173, %174, %175, %176, %177, %178, %179, %180, %181, %182, %183, %184, %185, %186, %187, %188, %189, %190, %191, %192, %193, %194, %195, %196, %197, %198, %199, %200, %201, %202, %203, %204, %205, %206, %207, %208 : i32, i8, i1, i1, i1, i10, i11, i7, i1, i7, i1, i16, i1, i3, i10, i1, i1, i1, i1, i1, i1, i1, i10, i1, i1, i1, i6, i2, i1, i3, i1, i1, i16, i10, i1, i1, i16, i6, i3, i1, i1), ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    %209 = llhd.prb %reg2hw : !hw.struct<csr0: !hw.struct<field4: !hw.struct<q: i11>, field3: !hw.struct<q: i10>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i1>>, csr1: !hw.struct<field4: !hw.struct<q: i16>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i7>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i7>>, csr2: !hw.struct<q: i1>, csr3: !hw.struct<field8: !hw.struct<q: i1>, field7: !hw.struct<q: i1>, field6: !hw.struct<q: i1>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i10>, field0: !hw.struct<q: i3>>, csr4: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr5: !hw.struct<field6: !hw.struct<q: i16>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i3>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i2>, field0: !hw.struct<q: i6>>, csr6: !hw.struct<field3: !hw.struct<q: i16>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr7: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i3>, field0: !hw.struct<q: i6>>>
    llhd.drv %racl_policies_i_2, %racl_policies_i after %1 : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    hw.output %u_rsp_intg_gen.tl_o, %209, %11, %108 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<csr0: !hw.struct<field4: !hw.struct<q: i11>, field3: !hw.struct<q: i10>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i1>>, csr1: !hw.struct<field4: !hw.struct<q: i16>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i7>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i7>>, csr2: !hw.struct<q: i1>, csr3: !hw.struct<field8: !hw.struct<q: i1>, field7: !hw.struct<q: i1>, field6: !hw.struct<q: i1>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i10>, field0: !hw.struct<q: i3>>, csr4: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr5: !hw.struct<field6: !hw.struct<q: i16>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i3>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i2>, field0: !hw.struct<q: i6>>, csr6: !hw.struct<field3: !hw.struct<q: i16>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr7: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i3>, field0: !hw.struct<q: i6>>>, !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, i1
  }
  hw.module @otp_macro(in %clk_i : i1, in %rst_ni : i1, in %prim_tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out prim_tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %lc_dft_en_i : i4, in %obs_ctrl_i : !hw.struct<obgsl: i4, obmsl: i4, obmen: i4>, out otp_obs_o : i8, out pwr_seq_o : i2, in %pwr_seq_h_i : i2, in %ext_voltage_h_io : !llhd.ref<i1>, in %test_i : !hw.struct<ctrl: i32>, out test_o : !hw.struct<status: i32>, out cio_test_o : i8, out cio_test_en_o : i8, in %scanmode_i : i4, in %scan_en_i : i1, in %scan_rst_ni : i1, in %otp_i : !hw.struct<valid: i1, cmd: i7, size: i2, addr: i10, wdata: i64>, out otp_o : !hw.struct<ready: i1, rvalid: i1, rdata: i64, err: i3, fatal_lc_fsm_err: i1, fatal_alert: i1, recov_alert: i1>, in %racl_policies_i : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, out racl_error_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, in %cfg_i : !hw.struct<test: i1>, out cfg_rsp_o : !hw.struct<done: i1>) {
    %c4_i32 = hw.constant 4 : i32
    %c0_i6 = hw.constant 0 : i6
    %0 = hw.aggregate_constant [[[false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [0 : i10, false], [0 : i3, false]], [[0 : i16, false], [false, false], [false, false], [0 : i3, false], [false, false], [0 : i2, false], [0 : i6, false]], [[false, false], [false, false], [0 : i3, false], [0 : i6, false]]] : !hw.struct<csr3: !hw.struct<field8: !hw.struct<d: i1, de: i1>, field7: !hw.struct<d: i1, de: i1>, field6: !hw.struct<d: i1, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i1, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i10, de: i1>, field0: !hw.struct<d: i3, de: i1>>, csr5: !hw.struct<field6: !hw.struct<d: i16, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i3, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i2, de: i1>, field0: !hw.struct<d: i6, de: i1>>, csr7: !hw.struct<field3: !hw.struct<d: i1, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i3, de: i1>, field0: !hw.struct<d: i6, de: i1>>>
    %1 = hw.aggregate_constant [false] : !hw.struct<done: i1>
    %2 = hw.aggregate_constant [[[false, false, 0 : i4], [false, false, 0 : i4]]] : !hw.array<1xstruct<ram_cfg: !hw.struct<test: i1, cfg_en: i1, cfg: i4>, rf_cfg: !hw.struct<test: i1, cfg_en: i1, cfg: i4>>>
    %3 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i2 = hw.constant -1 : i2
    %c0_i30 = hw.constant 0 : i30
    %c-2_i2 = hw.constant -2 : i2
    %4 = llhd.constant_time <0ns, 0d, 1e>
    %5 = hw.aggregate_constant [0 : i22, 0 : i22, 0 : i22, 0 : i22] : !hw.array<4xi22>
    %6 = hw.aggregate_constant [0 : i16, 0 : i16, 0 : i16, 0 : i16] : !hw.array<4xi16>
    %c0_i22 = hw.constant 0 : i22
    %c0_i16 = hw.constant 0 : i16
    %c0_i11 = hw.constant 0 : i11
    %7 = hw.aggregate_constant [false, false, 0, 0 : i3, false, false, false] : !hw.struct<ready: i1, rvalid: i1, rdata: i64, err: i3, fatal_lc_fsm_err: i1, fatal_alert: i1, recov_alert: i1>
    %8 = hw.aggregate_constant [false, 0 : i7, 0 : i2, 0 : i10, 0] : !hw.struct<valid: i1, cmd: i7, size: i2, addr: i10, wdata: i64>
    %9 = hw.aggregate_constant [0 : i32] : !hw.struct<status: i32>
    %c1_i32 = hw.constant 1 : i32
    %c0_i10 = hw.constant 0 : i10
    %c0_i32 = hw.constant 0 : i32
    %c-1_i22 = hw.constant -1 : i22
    %false = hw.constant false
    %c-137_i11 = hw.constant -137 : i11
    %c1003_i11 = hw.constant 1003 : i11
    %c125_i11 = hw.constant 125 : i11
    %c-4_i3 = hw.constant -4 : i3
    %c657_i11 = hw.constant 657 : i11
    %c406_i11 = hw.constant 406 : i11
    %c2_i3 = hw.constant 2 : i3
    %c3_i3 = hw.constant 3 : i3
    %c-571_i11 = hw.constant -571 : i11
    %c352_i11 = hw.constant 352 : i11
    %c61_i7 = hw.constant 61 : i7
    %c-25_i7 = hw.constant -25 : i7
    %c-44_i7 = hw.constant -44 : i7
    %c-318_i11 = hw.constant -318 : i11
    %c-55_i7 = hw.constant -55 : i7
    %c558_i11 = hw.constant 558 : i11
    %c-6_i7 = hw.constant -6 : i7
    %c-583_i11 = hw.constant -583 : i11
    %c-168_i11 = hw.constant -168 : i11
    %c32_i7 = hw.constant 32 : i7
    %c0_i3 = hw.constant 0 : i3
    %c-989_i11 = hw.constant -989 : i11
    %true = hw.constant true
    %c1_i2 = hw.constant 1 : i2
    %c0_i8 = hw.constant 0 : i8
    %c0_i2 = hw.constant 0 : i2
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %10 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %11 = llhd.prb %rst_ni_1 : i1
    %test_o = llhd.sig %9 : !hw.struct<status: i32>
    %otp_i_2 = llhd.sig name "otp_i" %8 : !hw.struct<valid: i1, cmd: i7, size: i2, addr: i10, wdata: i64>
    %otp_o = llhd.sig %7 : !hw.struct<ready: i1, rvalid: i1, rdata: i64, err: i3, fatal_lc_fsm_err: i1, fatal_alert: i1, recov_alert: i1>
    %fsm_err = llhd.sig %false : i1
    %test_vect = llhd.sig %c0_i8 : i8
    %state_d = llhd.sig %c0_i11 : i11
    %state_q = llhd.sig %c0_i11 : i11
    %err_d = llhd.sig %c0_i3 : i3
    %err_q = llhd.sig %c0_i3 : i3
    %valid_d = llhd.sig %false : i1
    %valid_q = llhd.sig %false : i1
    %integrity_en_d = llhd.sig %false : i1
    %integrity_en_q = llhd.sig %false : i1
    %req = llhd.sig %false : i1
    %wren = llhd.sig %false : i1
    %rvalid = llhd.sig %false : i1
    %rerror = llhd.sig %c0_i2 : i2
    %addr_q = llhd.sig %c0_i10 : i10
    %size_q = llhd.sig %c0_i2 : i2
    %cnt_d = llhd.sig %c0_i2 : i2
    %cnt_q = llhd.sig %c0_i2 : i2
    %cnt_clr = llhd.sig %false : i1
    %cnt_en = llhd.sig %false : i1
    %read_ecc_on = llhd.sig %false : i1
    %write_ecc_on = llhd.sig %false : i1
    %wdata_inconsistent = llhd.sig %false : i1
    %zer_en = llhd.sig %false : i1
    %rdata_corr = llhd.sig %c0_i16 : i16
    %rdata_d = llhd.sig %c0_i22 : i22
    %wdata_ecc = llhd.sig %c0_i22 : i22
    %rdata_ecc = llhd.sig %c0_i22 : i22
    %wdata_q = llhd.sig %6 : !hw.array<4xi16>
    %rdata_reshaped = llhd.sig %6 : !hw.array<4xi16>
    %rdata_q = llhd.sig %5 : !hw.array<4xi22>
    %u_prim_lc_sync_dft_en.lc_en_o = hw.instance "u_prim_lc_sync_dft_en" @prim_lc_sync(clk_i: %10: i1, rst_ni: %11: i1, lc_en_i: %lc_dft_en_i: i4) -> (lc_en_o: !hw.array<3xi4>) {sv.namehint = "lc_dft_en"}
    %12 = hw.array_get %u_prim_lc_sync_dft_en.lc_en_o[%c0_i2] : !hw.array<3xi4>, i2
    %u_tlul_lc_gate.tl_d2h_o, %u_tlul_lc_gate.tl_h2d_o, %u_tlul_lc_gate.flush_ack_o, %u_tlul_lc_gate.resp_pending_o, %u_tlul_lc_gate.err_o = hw.instance "u_tlul_lc_gate" @tlul_lc_gate(clk_i: %10: i1, rst_ni: %11: i1, tl_h2d_i: %prim_tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, tl_d2h_i: %u_reg_top.tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, flush_req_i: %false: i1, lc_en_i: %12: i4) -> (tl_d2h_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, tl_h2d_o: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, flush_ack_o: i1, resp_pending_o: i1, err_o: i1) {sv.namehint = "lc_fsm_err"}
    %u_reg_top.tl_o, %u_reg_top.reg2hw, %u_reg_top.racl_error_o, %u_reg_top.intg_err_o = hw.instance "u_reg_top" @otp_macro_prim_reg_top(clk_i: %10: i1, rst_ni: %11: i1, tl_i: %u_tlul_lc_gate.tl_h2d_o: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, hw2reg: %0: !hw.struct<csr3: !hw.struct<field8: !hw.struct<d: i1, de: i1>, field7: !hw.struct<d: i1, de: i1>, field6: !hw.struct<d: i1, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i1, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i10, de: i1>, field0: !hw.struct<d: i3, de: i1>>, csr5: !hw.struct<field6: !hw.struct<d: i16, de: i1>, field5: !hw.struct<d: i1, de: i1>, field4: !hw.struct<d: i1, de: i1>, field3: !hw.struct<d: i3, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i2, de: i1>, field0: !hw.struct<d: i6, de: i1>>, csr7: !hw.struct<field3: !hw.struct<d: i1, de: i1>, field2: !hw.struct<d: i1, de: i1>, field1: !hw.struct<d: i3, de: i1>, field0: !hw.struct<d: i6, de: i1>>>, racl_policies_i: %racl_policies_i: !hw.array<1xstruct<write_perm: i2, read_perm: i2>>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, reg2hw: !hw.struct<csr0: !hw.struct<field4: !hw.struct<q: i11>, field3: !hw.struct<q: i10>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i1>>, csr1: !hw.struct<field4: !hw.struct<q: i16>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i7>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i7>>, csr2: !hw.struct<q: i1>, csr3: !hw.struct<field8: !hw.struct<q: i1>, field7: !hw.struct<q: i1>, field6: !hw.struct<q: i1>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i10>, field0: !hw.struct<q: i3>>, csr4: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr5: !hw.struct<field6: !hw.struct<q: i16>, field5: !hw.struct<q: i1>, field4: !hw.struct<q: i1>, field3: !hw.struct<q: i3>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i2>, field0: !hw.struct<q: i6>>, csr6: !hw.struct<field3: !hw.struct<q: i16>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i1>, field0: !hw.struct<q: i10>>, csr7: !hw.struct<field3: !hw.struct<q: i1>, field2: !hw.struct<q: i1>, field1: !hw.struct<q: i3>, field0: !hw.struct<q: i6>>>, racl_error_o: !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, intg_err_o: i1) {sv.namehint = "reg2hw"}
    %13 = llhd.prb %wdata_q : !hw.array<4xi16>
    %14 = llhd.prb %cnt_q : i2
    %15 = hw.array_get %13[%14] : !hw.array<4xi16>, i2
    %gen_enc_hamming.gen_enc_hamming_16.u_enc.data_o = hw.instance "gen_enc_hamming.gen_enc_hamming_16.u_enc" @prim_secded_hamming_22_16_enc(data_i: %15: i16) -> (data_o: i22)
    llhd.drv %wdata_ecc, %gen_enc_hamming.gen_enc_hamming_16.u_enc.data_o after %4 : i22
    %16 = llhd.prb %rdata_ecc : i22
    %gen_dec_hamming.gen_dec_hamming_16.u_dec.data_o, %gen_dec_hamming.gen_dec_hamming_16.u_dec.syndrome_o, %gen_dec_hamming.gen_dec_hamming_16.u_dec.err_o = hw.instance "gen_dec_hamming.gen_dec_hamming_16.u_dec" @prim_secded_hamming_22_16_dec(data_i: %16: i22) -> (data_o: i16, syndrome_o: i6, err_o: i2)
    llhd.drv %rdata_corr, %gen_dec_hamming.gen_dec_hamming_16.u_dec.data_o after %4 : i16
    llhd.drv %rerror, %gen_dec_hamming.gen_dec_hamming_16.u_dec.err_o after %4 : i2
    %17 = llhd.prb %req : i1
    %18 = llhd.prb %wren : i1
    %u_prim_ram_1p_adv.rdata_o, %u_prim_ram_1p_adv.rvalid_o, %u_prim_ram_1p_adv.rerror_o, %u_prim_ram_1p_adv.cfg_rsp_o, %u_prim_ram_1p_adv.alert_o = hw.instance "u_prim_ram_1p_adv" @prim_ram_1p_adv(clk_i: %10: i1, rst_ni: %11: i1, req_i: %17: i1, write_i: %18: i1, addr_i: %58: i10, wdata_i: %69: i22, wmask_i: %c-1_i22: i22, cfg_i: %2: !hw.array<1xstruct<ram_cfg: !hw.struct<test: i1, cfg_en: i1, cfg: i4>, rf_cfg: !hw.struct<test: i1, cfg_en: i1, cfg: i4>>>) -> (rdata_o: i22, rvalid_o: i1, rerror_o: i2, cfg_rsp_o: !hw.array<1xstruct<done: i1>>, alert_o: i1)
    llhd.drv %rdata_ecc, %u_prim_ram_1p_adv.rdata_o after %4 : i22
    llhd.drv %rvalid, %u_prim_ram_1p_adv.rvalid_o after %4 : i1
    %19 = llhd.prb %state_d : i11
    %u_state_regs.state_o = hw.instance "u_state_regs" @prim_sparse_fsm_flop(clk_i: %10: i1, rst_ni: %11: i1, state_i: %19: i11) -> (state_o: i11)
    llhd.drv %state_q, %u_state_regs.state_o after %4 : i11
    %20 = llhd.sig.struct_extract %otp_o["fatal_lc_fsm_err"] : <!hw.struct<ready: i1, rvalid: i1, rdata: i64, err: i3, fatal_lc_fsm_err: i1, fatal_alert: i1, recov_alert: i1>>
    llhd.drv %20, %u_tlul_lc_gate.err_o after %4 : i1
    %21 = llhd.sig.struct_extract %otp_o["fatal_alert"] : <!hw.struct<ready: i1, rvalid: i1, rdata: i64, err: i3, fatal_lc_fsm_err: i1, fatal_alert: i1, recov_alert: i1>>
    %22 = llhd.prb %fsm_err : i1
    %23 = comb.or %u_reg_top.intg_err_o, %22 : i1
    llhd.drv %21, %23 after %4 : i1
    %24 = llhd.sig.struct_extract %otp_o["recov_alert"] : <!hw.struct<ready: i1, rvalid: i1, rdata: i64, err: i3, fatal_lc_fsm_err: i1, fatal_alert: i1, recov_alert: i1>>
    llhd.drv %24, %false after %4 : i1
    llhd.drv %test_vect, %c0_i8 after %4 : i8
    %25 = llhd.sig.struct_extract %test_o["status"] : <!hw.struct<status: i32>>
    llhd.drv %25, %c0_i32 after %4 : i32
    %26 = hw.array_get %u_prim_lc_sync_dft_en.lc_en_o[%c1_i2] : !hw.array<3xi4>, i2
    %27 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%26) : (i4) -> i1
    %28 = llhd.prb %test_vect : i8
    %29 = comb.mux %27, %28, %c0_i8 : i8
    %30 = hw.array_get %u_prim_lc_sync_dft_en.lc_en_o[%c-2_i2] : !hw.array<3xi4>, i2
    %31 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%30) : (i4) -> i1
    %32 = comb.replicate %31 : (i1) -> i8
    %33 = llhd.sig.struct_extract %otp_o["rvalid"] : <!hw.struct<ready: i1, rvalid: i1, rdata: i64, err: i3, fatal_lc_fsm_err: i1, fatal_alert: i1, recov_alert: i1>>
    %34 = llhd.prb %valid_q : i1
    llhd.drv %33, %34 after %4 : i1
    %35 = llhd.sig.struct_extract %otp_o["err"] : <!hw.struct<ready: i1, rvalid: i1, rdata: i64, err: i3, fatal_lc_fsm_err: i1, fatal_alert: i1, recov_alert: i1>>
    %36 = llhd.prb %err_q : i3
    llhd.drv %35, %36 after %4 : i3
    %37 = llhd.prb %cnt_clr : i1
    %38 = llhd.prb %cnt_en : i1
    %39 = comb.add %14, %c1_i2 : i2
    %40 = comb.mux %38, %39, %14 : i2
    %41 = comb.mux %37, %c0_i2, %40 : i2
    llhd.drv %cnt_d, %41 after %4 : i2
    %42 = llhd.prb %state_q : i11
    %43 = llhd.prb %otp_o : !hw.struct<ready: i1, rvalid: i1, rdata: i64, err: i3, fatal_lc_fsm_err: i1, fatal_alert: i1, recov_alert: i1>
    %44 = llhd.prb %valid_d : i1
    %45 = llhd.prb %err_d : i3
    %46 = llhd.prb %read_ecc_on : i1
    %47 = llhd.prb %write_ecc_on : i1
    %48 = llhd.prb %integrity_en_q : i1
    %49 = llhd.prb %integrity_en_d : i1
    %50 = llhd.prb %zer_en : i1
    %51 = llhd.prb %otp_i_2 : !hw.struct<valid: i1, cmd: i7, size: i2, addr: i10, wdata: i64>
    %52 = llhd.prb %rvalid : i1
    %53 = llhd.prb %rerror : i2
    %54 = llhd.prb %size_q : i2
    %55 = llhd.prb %wdata_inconsistent : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb55
      %74 = llhd.prb %state_q : i11
      llhd.drv %state_d, %74 after %4 : i11
      %75 = llhd.sig.struct_extract %otp_o["ready"] : <!hw.struct<ready: i1, rvalid: i1, rdata: i64, err: i3, fatal_lc_fsm_err: i1, fatal_alert: i1, recov_alert: i1>>
      llhd.drv %75, %false after %4 : i1
      llhd.drv %valid_d, %false after %4 : i1
      %76 = llhd.prb %err_q : i3
      llhd.drv %err_d, %76 after %4 : i3
      llhd.drv %req, %false after %4 : i1
      llhd.drv %wren, %false after %4 : i1
      llhd.drv %cnt_clr, %false after %4 : i1
      llhd.drv %cnt_en, %false after %4 : i1
      llhd.drv %read_ecc_on, %true after %4 : i1
      llhd.drv %write_ecc_on, %true after %4 : i1
      llhd.drv %fsm_err, %false after %4 : i1
      %77 = llhd.prb %integrity_en_q : i1
      llhd.drv %integrity_en_d, %77 after %4 : i1
      llhd.drv %zer_en, %false after %4 : i1
      %78 = llhd.prb %state_q : i11
      %79 = comb.icmp ceq %78, %c-989_i11 : i11
      cf.cond_br %79, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      llhd.drv %err_d, %c0_i3 after %4 : i3
      llhd.drv %75, %true after %4 : i1
      %80 = llhd.prb %otp_i_2 : !hw.struct<valid: i1, cmd: i7, size: i2, addr: i10, wdata: i64>
      %valid = hw.struct_extract %80["valid"] : !hw.struct<valid: i1, cmd: i7, size: i2, addr: i10, wdata: i64>
      cf.cond_br %valid, ^bb3, ^bb55
    ^bb3:  // pred: ^bb2
      %81 = llhd.prb %otp_i_2 : !hw.struct<valid: i1, cmd: i7, size: i2, addr: i10, wdata: i64>
      %cmd = hw.struct_extract %81["cmd"] : !hw.struct<valid: i1, cmd: i7, size: i2, addr: i10, wdata: i64>
      %82 = comb.icmp eq %cmd, %c32_i7 : i7
      cf.cond_br %82, ^bb4, ^bb55
    ^bb4:  // pred: ^bb3
      llhd.drv %state_d, %c-168_i11 after %4 : i11
      cf.br ^bb55
    ^bb5:  // pred: ^bb1
      %83 = comb.icmp ceq %78, %c-168_i11 : i11
      cf.cond_br %83, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %state_d, %c-583_i11 after %4 : i11
      llhd.drv %valid_d, %true after %4 : i1
      llhd.drv %err_d, %c0_i3 after %4 : i3
      cf.br ^bb55
    ^bb7:  // pred: ^bb5
      %84 = comb.icmp ceq %78, %c-583_i11 : i11
      cf.cond_br %84, ^bb8, ^bb19
    ^bb8:  // pred: ^bb7
      llhd.drv %75, %true after %4 : i1
      llhd.drv %err_d, %c0_i3 after %4 : i3
      %85 = llhd.prb %otp_i_2 : !hw.struct<valid: i1, cmd: i7, size: i2, addr: i10, wdata: i64>
      %valid_3 = hw.struct_extract %85["valid"] : !hw.struct<valid: i1, cmd: i7, size: i2, addr: i10, wdata: i64>
      cf.cond_br %valid_3, ^bb9, ^bb55
    ^bb9:  // pred: ^bb8
      llhd.drv %cnt_clr, %true after %4 : i1
      llhd.drv %err_d, %c0_i3 after %4 : i3
      %86 = llhd.prb %otp_i_2 : !hw.struct<valid: i1, cmd: i7, size: i2, addr: i10, wdata: i64>
      %cmd_4 = hw.struct_extract %86["cmd"] : !hw.struct<valid: i1, cmd: i7, size: i2, addr: i10, wdata: i64>
      %87 = comb.icmp ceq %cmd_4, %c-6_i7 : i7
      cf.cond_br %87, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      llhd.drv %state_d, %c558_i11 after %4 : i11
      llhd.drv %integrity_en_d, %true after %4 : i1
      cf.br ^bb55
    ^bb11:  // pred: ^bb9
      %88 = comb.icmp ceq %cmd_4, %c-55_i7 : i7
      cf.cond_br %88, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      llhd.drv %state_d, %c-318_i11 after %4 : i11
      llhd.drv %integrity_en_d, %true after %4 : i1
      cf.br ^bb55
    ^bb13:  // pred: ^bb11
      %89 = comb.icmp ceq %cmd_4, %c-44_i7 : i7
      cf.cond_br %89, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      llhd.drv %state_d, %c558_i11 after %4 : i11
      llhd.drv %integrity_en_d, %false after %4 : i1
      cf.br ^bb55
    ^bb15:  // pred: ^bb13
      %90 = comb.icmp ceq %cmd_4, %c-25_i7 : i7
      cf.cond_br %90, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      llhd.drv %state_d, %c-318_i11 after %4 : i11
      llhd.drv %integrity_en_d, %false after %4 : i1
      cf.br ^bb55
    ^bb17:  // pred: ^bb15
      %91 = comb.icmp ceq %cmd_4, %c61_i7 : i7
      cf.cond_br %91, ^bb18, ^bb55
    ^bb18:  // pred: ^bb17
      llhd.drv %state_d, %c352_i11 after %4 : i11
      llhd.drv %integrity_en_d, %false after %4 : i1
      cf.br ^bb55
    ^bb19:  // pred: ^bb7
      %92 = comb.icmp ceq %78, %c558_i11 : i11
      cf.cond_br %92, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      llhd.drv %state_d, %c-571_i11 after %4 : i11
      llhd.drv %req, %true after %4 : i1
      %93 = llhd.prb %integrity_en_q : i1
      llhd.drv %read_ecc_on, %93 after %4 : i1
      cf.br ^bb55
    ^bb21:  // pred: ^bb19
      %94 = comb.icmp ceq %78, %c-571_i11 : i11
      cf.cond_br %94, ^bb22, ^bb30
    ^bb22:  // pred: ^bb21
      %95 = llhd.prb %integrity_en_q : i1
      llhd.drv %read_ecc_on, %95 after %4 : i1
      %96 = llhd.prb %rvalid : i1
      cf.cond_br %96, ^bb23, ^bb55
    ^bb23:  // pred: ^bb22
      llhd.drv %cnt_en, %true after %4 : i1
      %97 = llhd.prb %rerror : i2
      %98 = comb.extract %97 from 1 : (i2) -> i1
      %99 = llhd.prb %integrity_en_q : i1
      %100 = comb.and %98, %99 : i1
      cf.cond_br %100, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      llhd.drv %state_d, %c-583_i11 after %4 : i11
      llhd.drv %valid_d, %true after %4 : i1
      llhd.drv %err_d, %c3_i3 after %4 : i3
      cf.br ^bb55
    ^bb25:  // pred: ^bb23
      %101 = llhd.prb %cnt_q : i2
      %102 = llhd.prb %size_q : i2
      %103 = comb.icmp eq %101, %102 : i2
      cf.cond_br %103, ^bb26, ^bb27
    ^bb26:  // pred: ^bb25
      llhd.drv %state_d, %c-583_i11 after %4 : i11
      llhd.drv %valid_d, %true after %4 : i1
      cf.br ^bb28
    ^bb27:  // pred: ^bb25
      llhd.drv %state_d, %c558_i11 after %4 : i11
      cf.br ^bb28
    ^bb28:  // 2 preds: ^bb26, ^bb27
      %104 = llhd.prb %rerror : i2
      %105 = comb.extract %104 from 0 : (i2) -> i1
      %106 = llhd.prb %integrity_en_q : i1
      %107 = comb.and %105, %106 : i1
      cf.cond_br %107, ^bb29, ^bb55
    ^bb29:  // pred: ^bb28
      llhd.drv %err_d, %c2_i3 after %4 : i3
      cf.br ^bb55
    ^bb30:  // pred: ^bb21
      %108 = comb.icmp ceq %78, %c-318_i11 : i11
      cf.cond_br %108, ^bb31, ^bb32
    ^bb31:  // pred: ^bb30
      llhd.drv %state_d, %c406_i11 after %4 : i11
      llhd.drv %req, %true after %4 : i1
      llhd.drv %read_ecc_on, %false after %4 : i1
      cf.br ^bb55
    ^bb32:  // pred: ^bb30
      %109 = comb.icmp ceq %78, %c406_i11 : i11
      cf.cond_br %109, ^bb33, ^bb37
    ^bb33:  // pred: ^bb32
      llhd.drv %read_ecc_on, %false after %4 : i1
      %110 = llhd.prb %rvalid : i1
      cf.cond_br %110, ^bb34, ^bb55
    ^bb34:  // pred: ^bb33
      llhd.drv %cnt_en, %true after %4 : i1
      %111 = llhd.prb %cnt_q : i2
      %112 = llhd.prb %size_q : i2
      %113 = comb.icmp eq %111, %112 : i2
      cf.cond_br %113, ^bb35, ^bb36
    ^bb35:  // pred: ^bb34
      llhd.drv %cnt_clr, %true after %4 : i1
      llhd.drv %state_d, %c657_i11 after %4 : i11
      cf.br ^bb55
    ^bb36:  // pred: ^bb34
      llhd.drv %state_d, %c-318_i11 after %4 : i11
      cf.br ^bb55
    ^bb37:  // pred: ^bb32
      %114 = comb.icmp ceq %78, %c657_i11 : i11
      cf.cond_br %114, ^bb38, ^bb42
    ^bb38:  // pred: ^bb37
      llhd.drv %req, %true after %4 : i1
      llhd.drv %wren, %true after %4 : i1
      llhd.drv %cnt_en, %true after %4 : i1
      %115 = llhd.prb %integrity_en_q : i1
      llhd.drv %write_ecc_on, %115 after %4 : i1
      %116 = llhd.prb %wdata_inconsistent : i1
      cf.cond_br %116, ^bb39, ^bb40
    ^bb39:  // pred: ^bb38
      llhd.drv %err_d, %c-4_i3 after %4 : i3
      cf.br ^bb40
    ^bb40:  // 2 preds: ^bb38, ^bb39
      %117 = llhd.prb %cnt_q : i2
      %118 = llhd.prb %size_q : i2
      %119 = comb.icmp eq %117, %118 : i2
      cf.cond_br %119, ^bb41, ^bb55
    ^bb41:  // pred: ^bb40
      llhd.drv %valid_d, %true after %4 : i1
      llhd.drv %state_d, %c-583_i11 after %4 : i11
      cf.br ^bb55
    ^bb42:  // pred: ^bb37
      %120 = comb.icmp ceq %78, %c352_i11 : i11
      cf.cond_br %120, ^bb43, ^bb45
    ^bb43:  // pred: ^bb42
      llhd.drv %req, %true after %4 : i1
      llhd.drv %wren, %true after %4 : i1
      llhd.drv %cnt_en, %true after %4 : i1
      llhd.drv %zer_en, %true after %4 : i1
      %121 = llhd.prb %cnt_q : i2
      %122 = llhd.prb %size_q : i2
      %123 = comb.icmp eq %121, %122 : i2
      cf.cond_br %123, ^bb44, ^bb55
    ^bb44:  // pred: ^bb43
      llhd.drv %state_d, %c125_i11 after %4 : i11
      llhd.drv %cnt_clr, %true after %4 : i1
      cf.br ^bb55
    ^bb45:  // pred: ^bb42
      %124 = comb.icmp ceq %78, %c125_i11 : i11
      cf.cond_br %124, ^bb46, ^bb47
    ^bb46:  // pred: ^bb45
      llhd.drv %state_d, %c1003_i11 after %4 : i11
      llhd.drv %req, %true after %4 : i1
      llhd.drv %read_ecc_on, %false after %4 : i1
      cf.br ^bb55
    ^bb47:  // pred: ^bb45
      %125 = comb.icmp ceq %78, %c1003_i11 : i11
      cf.cond_br %125, ^bb48, ^bb52
    ^bb48:  // pred: ^bb47
      llhd.drv %read_ecc_on, %false after %4 : i1
      %126 = llhd.prb %rvalid : i1
      cf.cond_br %126, ^bb49, ^bb55
    ^bb49:  // pred: ^bb48
      llhd.drv %cnt_en, %true after %4 : i1
      %127 = llhd.prb %cnt_q : i2
      %128 = llhd.prb %size_q : i2
      %129 = comb.icmp eq %127, %128 : i2
      cf.cond_br %129, ^bb50, ^bb51
    ^bb50:  // pred: ^bb49
      llhd.drv %state_d, %c-583_i11 after %4 : i11
      llhd.drv %valid_d, %true after %4 : i1
      cf.br ^bb55
    ^bb51:  // pred: ^bb49
      llhd.drv %state_d, %c125_i11 after %4 : i11
      cf.br ^bb55
    ^bb52:  // pred: ^bb47
      %130 = comb.icmp ceq %78, %c-137_i11 : i11
      cf.cond_br %130, ^bb53, ^bb54
    ^bb53:  // pred: ^bb52
      llhd.drv %fsm_err, %true after %4 : i1
      cf.br ^bb55
    ^bb54:  // pred: ^bb52
      llhd.drv %state_d, %c-137_i11 after %4 : i11
      llhd.drv %fsm_err, %true after %4 : i1
      cf.br ^bb55
    ^bb55:  // 30 preds: ^bb2, ^bb3, ^bb4, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb17, ^bb18, ^bb20, ^bb22, ^bb24, ^bb28, ^bb29, ^bb31, ^bb33, ^bb35, ^bb36, ^bb40, ^bb41, ^bb43, ^bb44, ^bb46, ^bb48, ^bb50, ^bb51, ^bb53, ^bb54
      llhd.wait (%42, %19, %43, %44, %36, %45, %17, %18, %37, %38, %46, %47, %22, %48, %49, %50, %51, %52, %53, %14, %54, %55 : i11, i11, !hw.struct<ready: i1, rvalid: i1, rdata: i64, err: i3, fatal_lc_fsm_err: i1, fatal_alert: i1, recov_alert: i1>, i1, i3, i3, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, !hw.struct<valid: i1, cmd: i7, size: i2, addr: i10, wdata: i64>, i1, i2, i2, i2, i1), ^bb1
    }
    %56 = llhd.prb %addr_q : i10
    %57 = comb.concat %c0_i8, %14 : i8, i2
    %58 = comb.add %56, %57 {sv.namehint = "addr"} : i10
    %59 = llhd.prb %rdata_corr : i16
    %60 = comb.concat %c0_i6, %59 : i6, i16
    %61 = comb.mux %46, %60, %16 : i22
    llhd.drv %rdata_d, %61 after %4 : i22
    %62 = llhd.prb %wdata_ecc : i22
    %63 = llhd.prb %rdata_q : !hw.array<4xi22>
    %64 = hw.array_get %63[%14] : !hw.array<4xi22>, i2
    %65 = comb.or %62, %64 : i22
    %66 = comb.concat %c0_i6, %15 : i6, i16
    %67 = comb.or %66, %64 : i22
    %68 = comb.mux %47, %65, %67 : i22
    %69 = comb.mux %50, %c-1_i22, %68 {sv.namehint = "wdata_rmw"} : i22
    %70 = comb.and %64, %62 : i22
    %71 = comb.icmp ne %70, %64 : i22
    llhd.drv %wdata_inconsistent, %71 after %4 : i1
    %72 = llhd.prb %rdata_reshaped : !hw.array<4xi16>
    llhd.process {
      cf.br ^bb2(%c0_i32 : i32)
    ^bb1:  // pred: ^bb4
      cf.br ^bb2(%c0_i32 : i32)
    ^bb2(%74: i32):  // 3 preds: ^bb0, ^bb1, ^bb3
      %75 = comb.icmp slt %74, %c4_i32 : i32
      cf.cond_br %75, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %76 = comb.extract %74 from 2 : (i32) -> i30
      %77 = comb.icmp eq %76, %c0_i30 : i30
      %78 = comb.extract %74 from 0 : (i32) -> i2
      %79 = comb.mux %77, %78, %c-1_i2 : i2
      %80 = llhd.sig.array_get %rdata_reshaped[%79] : <!hw.array<4xi16>>
      %81 = llhd.prb %rdata_q : !hw.array<4xi22>
      %82 = hw.array_get %81[%79] : !hw.array<4xi22>, i2
      %83 = comb.extract %82 from 0 : (i22) -> i16
      llhd.drv %80, %83 after %4 : i16
      %84 = comb.add %74, %c1_i32 : i32
      cf.br ^bb2(%84 : i32)
    ^bb4:  // pred: ^bb2
      %85 = llhd.sig.struct_extract %otp_o["rdata"] : <!hw.struct<ready: i1, rvalid: i1, rdata: i64, err: i3, fatal_lc_fsm_err: i1, fatal_alert: i1, recov_alert: i1>>
      %86 = llhd.prb %rdata_reshaped : !hw.array<4xi16>
      %87 = hw.bitcast %86 : (!hw.array<4xi16>) -> i64
      llhd.drv %85, %87 after %4 : i64
      llhd.wait (%72, %63, %43 : !hw.array<4xi16>, !hw.array<4xi22>, !hw.struct<ready: i1, rvalid: i1, rdata: i64, err: i3, fatal_lc_fsm_err: i1, fatal_alert: i1, recov_alert: i1>), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb7, ^bb8
      %74 = llhd.prb %clk_i_0 : i1
      %75 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%10, %11 : i1, i1), ^bb2
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
      llhd.drv %valid_q, %false after %3 : i1
      llhd.drv %err_q, %c0_i3 after %3 : i3
      llhd.drv %addr_q, %c0_i10 after %3 : i10
      llhd.drv %wdata_q, %6 after %3 : !hw.array<4xi16>
      llhd.drv %rdata_q, %5 after %3 : !hw.array<4xi22>
      llhd.drv %cnt_q, %c0_i2 after %3 : i2
      llhd.drv %size_q, %c0_i2 after %3 : i2
      llhd.drv %integrity_en_q, %false after %3 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %85 = llhd.prb %valid_d : i1
      llhd.drv %valid_q, %85 after %3 : i1
      %86 = llhd.prb %err_d : i3
      llhd.drv %err_q, %86 after %3 : i3
      %87 = llhd.prb %cnt_d : i2
      llhd.drv %cnt_q, %87 after %3 : i2
      %88 = llhd.prb %integrity_en_d : i1
      llhd.drv %integrity_en_q, %88 after %3 : i1
      %89 = llhd.prb %otp_o : !hw.struct<ready: i1, rvalid: i1, rdata: i64, err: i3, fatal_lc_fsm_err: i1, fatal_alert: i1, recov_alert: i1>
      %ready = hw.struct_extract %89["ready"] : !hw.struct<ready: i1, rvalid: i1, rdata: i64, err: i3, fatal_lc_fsm_err: i1, fatal_alert: i1, recov_alert: i1>
      %90 = llhd.prb %otp_i_2 : !hw.struct<valid: i1, cmd: i7, size: i2, addr: i10, wdata: i64>
      %valid = hw.struct_extract %90["valid"] : !hw.struct<valid: i1, cmd: i7, size: i2, addr: i10, wdata: i64>
      %91 = comb.and %ready, %valid : i1
      cf.cond_br %91, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %92 = llhd.prb %otp_i_2 : !hw.struct<valid: i1, cmd: i7, size: i2, addr: i10, wdata: i64>
      %addr = hw.struct_extract %92["addr"] : !hw.struct<valid: i1, cmd: i7, size: i2, addr: i10, wdata: i64>
      llhd.drv %addr_q, %addr after %3 : i10
      %93 = llhd.prb %otp_i_2 : !hw.struct<valid: i1, cmd: i7, size: i2, addr: i10, wdata: i64>
      %wdata = hw.struct_extract %93["wdata"] : !hw.struct<valid: i1, cmd: i7, size: i2, addr: i10, wdata: i64>
      %94 = hw.bitcast %wdata : (i64) -> !hw.array<4xi16>
      llhd.drv %wdata_q, %94 after %3 : !hw.array<4xi16>
      %95 = llhd.prb %otp_i_2 : !hw.struct<valid: i1, cmd: i7, size: i2, addr: i10, wdata: i64>
      %size = hw.struct_extract %95["size"] : !hw.struct<valid: i1, cmd: i7, size: i2, addr: i10, wdata: i64>
      llhd.drv %size_q, %size after %3 : i2
      cf.br ^bb7
    ^bb7:  // 2 preds: ^bb5, ^bb6
      %96 = llhd.prb %rvalid : i1
      cf.cond_br %96, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %97 = llhd.prb %cnt_q : i2
      %98 = llhd.sig.array_get %rdata_q[%97] : <!hw.array<4xi22>>
      %99 = llhd.prb %rdata_d : i22
      llhd.drv %98, %99 after %3 : i22
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %4 : i1
    llhd.drv %rst_ni_1, %rst_ni after %4 : i1
    %73 = llhd.prb %test_o : !hw.struct<status: i32>
    llhd.drv %otp_i_2, %otp_i after %4 : !hw.struct<valid: i1, cmd: i7, size: i2, addr: i10, wdata: i64>
    hw.output %u_tlul_lc_gate.tl_d2h_o, %c0_i8, %c0_i2, %73, %29, %32, %43, %u_reg_top.racl_error_o, %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, i8, i2, !hw.struct<status: i32>, i8, i8, !hw.struct<ready: i1, rvalid: i1, rdata: i64, err: i3, fatal_lc_fsm_err: i1, fatal_alert: i1, recov_alert: i1>, !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, !hw.struct<done: i1>
  }
}
