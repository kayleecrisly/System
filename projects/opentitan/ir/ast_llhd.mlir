module {
  hw.module private @prim_buf(in %in_i : i1, out out_o : i1) {
    hw.output %in_i : i1
  }
  hw.module private @prim_buf_46(in %in_i : i4, out out_o : i4) {
    hw.output %in_i : i4
  }
  hw.module private @prim_buf_47(in %in_i : i44, out out_o : i44) {
    hw.output %in_i : i44
  }
  hw.module private @prim_clock_buf(in %clk_i : i1, out clk_o : i1) {
    hw.output %clk_i : i1
  }
  hw.module private @prim_clock_buf_45(in %clk_i : i1, out clk_o : i1) {
    hw.output %clk_i : i1
  }
  hw.module private @prim_clock_div(in %clk_i : i1, in %rst_ni : i1, in %step_down_req_i : i1, out step_down_ack_o : i1, in %test_en_i : i1, out clk_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %step_down_req_i_2 = llhd.sig name "step_down_req_i" %false : i1
    %step_down_req = llhd.sig %false : i1
    %gen_div2.step_down_nq = llhd.sig %false : i1
    %gen_div2.u_div2.q_o = hw.instance "gen_div2.u_div2" @prim_flop(clk_i: %2: i1, rst_ni: %3: i1, d_i: %gen_div2.u_inv.clk_no: i1) -> (q_o: i1) {sv.namehint = "gen_div2.q_p"}
    %gen_div2.u_inv.clk_no = hw.instance "gen_div2.u_inv" @prim_clock_inv_43(clk_i: %gen_div2.u_div2.q_o: i1, scanmode_i: %false: i1) -> (clk_no: i1) {sv.namehint = "gen_div2.q_n"}
    %4 = llhd.prb %gen_div2.step_down_nq : i1
    %gen_div2.u_step_down_mux.clk_o = hw.instance "gen_div2.u_step_down_mux" @prim_clock_mux2_44(clk0_i: %gen_div2.u_div2.q_o: i1, clk1_i: %2: i1, sel_i: %4: i1) -> (clk_o: i1) {sv.namehint = "clk_int"}
    %u_clk_mux.clk_o = hw.instance "u_clk_mux" @prim_clock_mux2_44(clk0_i: %gen_div2.u_step_down_mux.clk_o: i1, clk1_i: %2: i1, sel_i: %false: i1) -> (clk_o: i1) {sv.namehint = "clk_muxed"}
    %u_clk_div_buf.clk_o = hw.instance "u_clk_div_buf" @prim_clock_buf_45(clk_i: %u_clk_mux.clk_o: i1) -> (clk_o: i1)
    %5 = llhd.prb %step_down_req_i_2 : i1
    %6 = comb.xor %test_en_i, %true : i1
    %7 = comb.and %6, %5 : i1
    llhd.drv %step_down_req, %7 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %8 = llhd.prb %clk_i_0 : i1
      %9 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %10 = llhd.prb %clk_i_0 : i1
      %11 = comb.xor bin %10, %true : i1
      %12 = comb.and bin %8, %11 : i1
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
      llhd.drv %gen_div2.step_down_nq, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %19 = llhd.prb %step_down_req : i1
      llhd.drv %gen_div2.step_down_nq, %19 after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %step_down_req_i_2, %step_down_req_i after %1 : i1
    hw.output %4, %u_clk_div_buf.clk_o : i1, i1
  }
  hw.module private @prim_clock_div_1(in %clk_i : i1, in %rst_ni : i1, in %step_down_req_i : i1, out step_down_ack_o : i1, in %test_en_i : i1, out clk_o : i1) {
    %c59_i7 = hw.constant 59 : i7
    %c-9_i7 = hw.constant -9 : i7
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c1_i7 = hw.constant 1 : i7
    %c0_i7 = hw.constant 0 : i7
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %step_down_req_i_2 = llhd.sig name "step_down_req_i" %false : i1
    %step_down_ack_o = llhd.sig %false : i1
    %step_down_req = llhd.sig %false : i1
    %clk_int = llhd.sig %false : i1
    %clk_muxed = llhd.sig %false : i1
    %gen_div.cnt = llhd.sig %c0_i7 : i7
    %gen_div.limit = llhd.sig %c0_i7 : i7
    %4 = llhd.prb %clk_int : i1
    %u_clk_mux.clk_o = hw.instance "u_clk_mux" @prim_clock_mux2_44(clk0_i: %4: i1, clk1_i: %2: i1, sel_i: %false: i1) -> (clk_o: i1)
    llhd.drv %clk_muxed, %u_clk_mux.clk_o after %1 : i1
    %5 = llhd.prb %clk_muxed : i1
    %u_clk_div_buf.clk_o = hw.instance "u_clk_div_buf" @prim_clock_buf_45(clk_i: %5: i1) -> (clk_o: i1)
    %6 = llhd.prb %step_down_req_i_2 : i1
    %7 = comb.xor %test_en_i, %true : i1
    %8 = comb.and %7, %6 : i1
    llhd.drv %step_down_req, %8 after %1 : i1
    %9 = llhd.prb %step_down_req : i1
    %10 = comb.xor %9, %true : i1
    %11 = comb.mux %10, %c-9_i7, %c59_i7 : i7
    llhd.drv %gen_div.limit, %11 after %1 : i7
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %13 = llhd.prb %clk_i_0 : i1
      %14 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %15 = llhd.prb %clk_i_0 : i1
      %16 = comb.xor bin %13, %true : i1
      %17 = comb.and bin %16, %15 : i1
      %18 = llhd.prb %rst_ni_1 : i1
      %19 = comb.xor bin %18, %true : i1
      %20 = comb.and bin %14, %19 : i1
      %21 = comb.or bin %17, %20 : i1
      cf.cond_br %21, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %22 = llhd.prb %rst_ni_1 : i1
      %23 = comb.xor %22, %true : i1
      cf.cond_br %23, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_div.cnt, %c0_i7 after %0 : i7
      llhd.drv %clk_int, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %24 = llhd.prb %gen_div.cnt : i7
      %25 = llhd.prb %gen_div.limit : i7
      %26 = comb.icmp uge %24, %25 : i7
      cf.cond_br %26, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %gen_div.cnt, %c0_i7 after %0 : i7
      %27 = llhd.prb %clk_muxed : i1
      %28 = comb.xor %27, %true : i1
      llhd.drv %clk_int, %28 after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %29 = llhd.prb %gen_div.cnt : i7
      %30 = comb.add %29, %c1_i7 : i7
      llhd.drv %gen_div.cnt, %30 after %0 : i7
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %13 = llhd.prb %clk_i_0 : i1
      %14 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %15 = llhd.prb %clk_i_0 : i1
      %16 = comb.xor bin %13, %true : i1
      %17 = comb.and bin %16, %15 : i1
      %18 = llhd.prb %rst_ni_1 : i1
      %19 = comb.xor bin %18, %true : i1
      %20 = comb.and bin %14, %19 : i1
      %21 = comb.or bin %17, %20 : i1
      cf.cond_br %21, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %22 = llhd.prb %rst_ni_1 : i1
      %23 = comb.xor %22, %true : i1
      cf.cond_br %23, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %step_down_ack_o, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %24 = llhd.prb %step_down_req : i1
      llhd.drv %step_down_ack_o, %24 after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %step_down_req_i_2, %step_down_req_i after %1 : i1
    %12 = llhd.prb %step_down_ack_o : i1
    hw.output %12, %u_clk_div_buf.clk_o : i1, i1
  }
  hw.module private @prim_clock_gating(in %clk_i : i1, in %en_i : i1, in %test_en_i : i1, out clk_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %en_i_1 = llhd.sig name "en_i" %false : i1
    %test_en_i_2 = llhd.sig name "test_en_i" %false : i1
    %en_latch = llhd.sig %false : i1
    %1 = llhd.prb %clk_i_0 : i1
    %2 = llhd.prb %en_i_1 : i1
    %3 = llhd.prb %test_en_i_2 : i1
    %4 = llhd.prb %en_latch : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb3
      %6 = llhd.prb %clk_i_0 : i1
      %7 = comb.xor %6, %true : i1
      cf.cond_br %7, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %8 = llhd.prb %en_i_1 : i1
      %9 = llhd.prb %test_en_i_2 : i1
      %10 = comb.or %8, %9 : i1
      llhd.drv %en_latch, %10 after %0 : i1
      cf.br ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      llhd.wait (%1, %2, %3, %4 : i1, i1, i1, i1), ^bb1
    }
    %5 = comb.and %4, %1 : i1
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %en_i_1, %en_i after %0 : i1
    llhd.drv %test_en_i_2, %test_en_i after %0 : i1
    hw.output %5 : i1
  }
  hw.module private @prim_clock_inv(in %clk_i : i1, in %scanmode_i : i1, out clk_no : i1) {
    %true = hw.constant true
    %0 = comb.xor %clk_i, %true : i1
    %gen_scan.i_dft_tck_mux.clk_o = hw.instance "gen_scan.i_dft_tck_mux" @prim_clock_mux2(clk0_i: %0: i1, clk1_i: %clk_i: i1, sel_i: %scanmode_i: i1) -> (clk_o: i1)
    hw.output %gen_scan.i_dft_tck_mux.clk_o : i1
  }
  hw.module private @prim_clock_inv_43(in %clk_i : i1, in %scanmode_i : i1, out clk_no : i1) {
    %true = hw.constant true
    %0 = comb.xor %clk_i, %true : i1
    hw.output %0 : i1
  }
  hw.module private @prim_clock_mux2(in %clk0_i : i1, in %clk1_i : i1, in %sel_i : i1, out clk_o : i1) {
    %true = hw.constant true
    %0 = comb.and %sel_i, %clk1_i : i1
    %1 = comb.xor %sel_i, %true : i1
    %2 = comb.and %1, %clk0_i : i1
    %3 = comb.or %0, %2 : i1
    hw.output %3 : i1
  }
  hw.module private @prim_clock_mux2_44(in %clk0_i : i1, in %clk1_i : i1, in %sel_i : i1, out clk_o : i1) {
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
  hw.module private @prim_flop_2sync_0(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %d_i_0 = llhd.sig name "d_i" %false : i1
    %d_o = llhd.sig %false : i1
    %1 = llhd.prb %d_o : i1
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_42(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i1) -> (q_o: i1) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_42(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i1) -> (q_o: i1)
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
  hw.module private @prim_flop_2sync_2(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %d_i_0 = llhd.sig name "d_i" %c0_i4 : i4
    %d_o = llhd.sig %c0_i4 : i4
    %1 = llhd.prb %d_o : i4
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_3(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i4) -> (q_o: i4) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_3(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i4) -> (q_o: i4)
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
  hw.module private @prim_flop_2sync_50(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %d_i_0 = llhd.sig name "d_i" %c0_i4 : i4
    %d_o = llhd.sig %c0_i4 : i4
    %1 = llhd.prb %d_o : i4
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_51(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i4) -> (q_o: i4) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_51(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i4) -> (q_o: i4)
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
  hw.module private @prim_flop_3(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
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
  hw.module private @prim_flop_42(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
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
  hw.module private @prim_flop_51(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i4 = hw.constant 0 : i4
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
      llhd.drv %q_o, %c0_i4 after %1 : i4
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
  hw.module private @prim_xor2(in %in0_i : i4, in %in1_i : i4, out out_o : i4) {
    %0 = comb.xor %in0_i, %in1_i : i4
    hw.output %0 : i4
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
  hw.module private @prim_multibit_sync(in %clk_i : i1, in %rst_ni : i1, in %data_i : i4, out data_o : i4) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [0 : i4] : !hw.array<1xi4>
    %3 = hw.aggregate_constant [0 : i4, 0 : i4] : !hw.array<2xi4>
    %c0_i4 = hw.constant 0 : i4
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %4 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %5 = llhd.prb %rst_ni_1 : i1
    %data_check_d = llhd.sig %3 : !hw.array<2xi4>
    %data_check_q = llhd.sig %2 : !hw.array<1xi4>
    %checks = llhd.sig %false : i1
    %data_synced_d = llhd.sig %c0_i4 : i4
    %data_synced_q = llhd.sig %c0_i4 : i4
    %6 = llhd.sig.array_get %data_check_d[%false] : <!hw.array<2xi4>>
    %i_prim_flop_2sync.q_o = hw.instance "i_prim_flop_2sync" @prim_flop_2sync_50(clk_i: %4: i1, rst_ni: %5: i1, d_i: %data_i: i4) -> (q_o: i4)
    llhd.drv %6, %i_prim_flop_2sync.q_o after %1 : i4
    %7 = llhd.sig.array_slice %data_check_d at %true : <!hw.array<2xi4>> -> <!hw.array<1xi4>>
    %8 = llhd.prb %data_check_q : !hw.array<1xi4>
    llhd.drv %7, %8 after %1 : !hw.array<1xi4>
    %9 = llhd.prb %data_check_d : !hw.array<2xi4>
    %10 = hw.array_get %9[%false] : !hw.array<2xi4>, i1
    %11 = hw.array_get %9[%true] : !hw.array<2xi4>, i1
    %12 = comb.icmp eq %10, %11 : i4
    llhd.drv %checks, %12 after %1 : i1
    %13 = llhd.prb %checks : i1
    %14 = llhd.prb %data_synced_q : i4
    %15 = comb.mux %13, %11, %14 : i4
    llhd.drv %data_synced_d, %15 after %1 : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %16 = llhd.prb %clk_i_0 : i1
      %17 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %18 = llhd.prb %clk_i_0 : i1
      %19 = comb.xor bin %16, %true : i1
      %20 = comb.and bin %19, %18 : i1
      %21 = llhd.prb %rst_ni_1 : i1
      %22 = comb.xor bin %21, %true : i1
      %23 = comb.and bin %17, %22 : i1
      %24 = comb.or bin %20, %23 : i1
      cf.cond_br %24, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %25 = llhd.prb %rst_ni_1 : i1
      %26 = comb.xor %25, %true : i1
      cf.cond_br %26, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %data_synced_q, %c0_i4 after %0 : i4
      llhd.drv %data_check_q, %2 after %0 : !hw.array<1xi4>
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %27 = llhd.prb %data_synced_d : i4
      llhd.drv %data_synced_q, %27 after %0 : i4
      %28 = llhd.prb %data_check_d : !hw.array<2xi4>
      %29 = hw.array_get %28[%false] : !hw.array<2xi4>, i1
      %30 = hw.array_create %29 : i4
      llhd.drv %data_check_q, %30 after %0 : !hw.array<1xi4>
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    hw.output %14 : i4
  }
  hw.module private @prim_onehot_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i44, in %addr_i : i6, in %en_i : i1, out err_o : i1) {
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
    %962 = comb.extract %oh_i from 0 : (i44) -> i1
    llhd.drv %961, %962 after %0 : i1
    %963 = llhd.sig.extract %and_tree from %c63_i7 : <i127> -> <i1>
    llhd.drv %963, %962 after %0 : i1
    %964 = llhd.sig.extract %err_tree from %c63_i7 : <i127> -> <i1>
    llhd.drv %964, %false after %0 : i1
    %965 = llhd.sig.extract %or_tree from %c-64_i7 : <i127> -> <i1>
    %966 = comb.extract %oh_i from 1 : (i44) -> i1
    llhd.drv %965, %966 after %0 : i1
    %967 = llhd.sig.extract %and_tree from %c-64_i7 : <i127> -> <i1>
    llhd.drv %967, %966 after %0 : i1
    %968 = llhd.sig.extract %err_tree from %c-64_i7 : <i127> -> <i1>
    llhd.drv %968, %false after %0 : i1
    %969 = llhd.sig.extract %or_tree from %c-63_i7 : <i127> -> <i1>
    %970 = comb.extract %oh_i from 2 : (i44) -> i1
    llhd.drv %969, %970 after %0 : i1
    %971 = llhd.sig.extract %and_tree from %c-63_i7 : <i127> -> <i1>
    llhd.drv %971, %970 after %0 : i1
    %972 = llhd.sig.extract %err_tree from %c-63_i7 : <i127> -> <i1>
    llhd.drv %972, %false after %0 : i1
    %973 = llhd.sig.extract %or_tree from %c-62_i7 : <i127> -> <i1>
    %974 = comb.extract %oh_i from 3 : (i44) -> i1
    llhd.drv %973, %974 after %0 : i1
    %975 = llhd.sig.extract %and_tree from %c-62_i7 : <i127> -> <i1>
    llhd.drv %975, %974 after %0 : i1
    %976 = llhd.sig.extract %err_tree from %c-62_i7 : <i127> -> <i1>
    llhd.drv %976, %false after %0 : i1
    %977 = llhd.sig.extract %or_tree from %c-61_i7 : <i127> -> <i1>
    %978 = comb.extract %oh_i from 4 : (i44) -> i1
    llhd.drv %977, %978 after %0 : i1
    %979 = llhd.sig.extract %and_tree from %c-61_i7 : <i127> -> <i1>
    llhd.drv %979, %978 after %0 : i1
    %980 = llhd.sig.extract %err_tree from %c-61_i7 : <i127> -> <i1>
    llhd.drv %980, %false after %0 : i1
    %981 = llhd.sig.extract %or_tree from %c-60_i7 : <i127> -> <i1>
    %982 = comb.extract %oh_i from 5 : (i44) -> i1
    llhd.drv %981, %982 after %0 : i1
    %983 = llhd.sig.extract %and_tree from %c-60_i7 : <i127> -> <i1>
    llhd.drv %983, %982 after %0 : i1
    %984 = llhd.sig.extract %err_tree from %c-60_i7 : <i127> -> <i1>
    llhd.drv %984, %false after %0 : i1
    %985 = llhd.sig.extract %or_tree from %c-59_i7 : <i127> -> <i1>
    %986 = comb.extract %oh_i from 6 : (i44) -> i1
    llhd.drv %985, %986 after %0 : i1
    %987 = llhd.sig.extract %and_tree from %c-59_i7 : <i127> -> <i1>
    llhd.drv %987, %986 after %0 : i1
    %988 = llhd.sig.extract %err_tree from %c-59_i7 : <i127> -> <i1>
    llhd.drv %988, %false after %0 : i1
    %989 = llhd.sig.extract %or_tree from %c-58_i7 : <i127> -> <i1>
    %990 = comb.extract %oh_i from 7 : (i44) -> i1
    llhd.drv %989, %990 after %0 : i1
    %991 = llhd.sig.extract %and_tree from %c-58_i7 : <i127> -> <i1>
    llhd.drv %991, %990 after %0 : i1
    %992 = llhd.sig.extract %err_tree from %c-58_i7 : <i127> -> <i1>
    llhd.drv %992, %false after %0 : i1
    %993 = llhd.sig.extract %or_tree from %c-57_i7 : <i127> -> <i1>
    %994 = comb.extract %oh_i from 8 : (i44) -> i1
    llhd.drv %993, %994 after %0 : i1
    %995 = llhd.sig.extract %and_tree from %c-57_i7 : <i127> -> <i1>
    llhd.drv %995, %994 after %0 : i1
    %996 = llhd.sig.extract %err_tree from %c-57_i7 : <i127> -> <i1>
    llhd.drv %996, %false after %0 : i1
    %997 = llhd.sig.extract %or_tree from %c-56_i7 : <i127> -> <i1>
    %998 = comb.extract %oh_i from 9 : (i44) -> i1
    llhd.drv %997, %998 after %0 : i1
    %999 = llhd.sig.extract %and_tree from %c-56_i7 : <i127> -> <i1>
    llhd.drv %999, %998 after %0 : i1
    %1000 = llhd.sig.extract %err_tree from %c-56_i7 : <i127> -> <i1>
    llhd.drv %1000, %false after %0 : i1
    %1001 = llhd.sig.extract %or_tree from %c-55_i7 : <i127> -> <i1>
    %1002 = comb.extract %oh_i from 10 : (i44) -> i1
    llhd.drv %1001, %1002 after %0 : i1
    %1003 = llhd.sig.extract %and_tree from %c-55_i7 : <i127> -> <i1>
    llhd.drv %1003, %1002 after %0 : i1
    %1004 = llhd.sig.extract %err_tree from %c-55_i7 : <i127> -> <i1>
    llhd.drv %1004, %false after %0 : i1
    %1005 = llhd.sig.extract %or_tree from %c-54_i7 : <i127> -> <i1>
    %1006 = comb.extract %oh_i from 11 : (i44) -> i1
    llhd.drv %1005, %1006 after %0 : i1
    %1007 = llhd.sig.extract %and_tree from %c-54_i7 : <i127> -> <i1>
    llhd.drv %1007, %1006 after %0 : i1
    %1008 = llhd.sig.extract %err_tree from %c-54_i7 : <i127> -> <i1>
    llhd.drv %1008, %false after %0 : i1
    %1009 = llhd.sig.extract %or_tree from %c-53_i7 : <i127> -> <i1>
    %1010 = comb.extract %oh_i from 12 : (i44) -> i1
    llhd.drv %1009, %1010 after %0 : i1
    %1011 = llhd.sig.extract %and_tree from %c-53_i7 : <i127> -> <i1>
    llhd.drv %1011, %1010 after %0 : i1
    %1012 = llhd.sig.extract %err_tree from %c-53_i7 : <i127> -> <i1>
    llhd.drv %1012, %false after %0 : i1
    %1013 = llhd.sig.extract %or_tree from %c-52_i7 : <i127> -> <i1>
    %1014 = comb.extract %oh_i from 13 : (i44) -> i1
    llhd.drv %1013, %1014 after %0 : i1
    %1015 = llhd.sig.extract %and_tree from %c-52_i7 : <i127> -> <i1>
    llhd.drv %1015, %1014 after %0 : i1
    %1016 = llhd.sig.extract %err_tree from %c-52_i7 : <i127> -> <i1>
    llhd.drv %1016, %false after %0 : i1
    %1017 = llhd.sig.extract %or_tree from %c-51_i7 : <i127> -> <i1>
    %1018 = comb.extract %oh_i from 14 : (i44) -> i1
    llhd.drv %1017, %1018 after %0 : i1
    %1019 = llhd.sig.extract %and_tree from %c-51_i7 : <i127> -> <i1>
    llhd.drv %1019, %1018 after %0 : i1
    %1020 = llhd.sig.extract %err_tree from %c-51_i7 : <i127> -> <i1>
    llhd.drv %1020, %false after %0 : i1
    %1021 = llhd.sig.extract %or_tree from %c-50_i7 : <i127> -> <i1>
    %1022 = comb.extract %oh_i from 15 : (i44) -> i1
    llhd.drv %1021, %1022 after %0 : i1
    %1023 = llhd.sig.extract %and_tree from %c-50_i7 : <i127> -> <i1>
    llhd.drv %1023, %1022 after %0 : i1
    %1024 = llhd.sig.extract %err_tree from %c-50_i7 : <i127> -> <i1>
    llhd.drv %1024, %false after %0 : i1
    %1025 = llhd.sig.extract %or_tree from %c-49_i7 : <i127> -> <i1>
    %1026 = comb.extract %oh_i from 16 : (i44) -> i1
    llhd.drv %1025, %1026 after %0 : i1
    %1027 = llhd.sig.extract %and_tree from %c-49_i7 : <i127> -> <i1>
    llhd.drv %1027, %1026 after %0 : i1
    %1028 = llhd.sig.extract %err_tree from %c-49_i7 : <i127> -> <i1>
    llhd.drv %1028, %false after %0 : i1
    %1029 = llhd.sig.extract %or_tree from %c-48_i7 : <i127> -> <i1>
    %1030 = comb.extract %oh_i from 17 : (i44) -> i1
    llhd.drv %1029, %1030 after %0 : i1
    %1031 = llhd.sig.extract %and_tree from %c-48_i7 : <i127> -> <i1>
    llhd.drv %1031, %1030 after %0 : i1
    %1032 = llhd.sig.extract %err_tree from %c-48_i7 : <i127> -> <i1>
    llhd.drv %1032, %false after %0 : i1
    %1033 = llhd.sig.extract %or_tree from %c-47_i7 : <i127> -> <i1>
    %1034 = comb.extract %oh_i from 18 : (i44) -> i1
    llhd.drv %1033, %1034 after %0 : i1
    %1035 = llhd.sig.extract %and_tree from %c-47_i7 : <i127> -> <i1>
    llhd.drv %1035, %1034 after %0 : i1
    %1036 = llhd.sig.extract %err_tree from %c-47_i7 : <i127> -> <i1>
    llhd.drv %1036, %false after %0 : i1
    %1037 = llhd.sig.extract %or_tree from %c-46_i7 : <i127> -> <i1>
    %1038 = comb.extract %oh_i from 19 : (i44) -> i1
    llhd.drv %1037, %1038 after %0 : i1
    %1039 = llhd.sig.extract %and_tree from %c-46_i7 : <i127> -> <i1>
    llhd.drv %1039, %1038 after %0 : i1
    %1040 = llhd.sig.extract %err_tree from %c-46_i7 : <i127> -> <i1>
    llhd.drv %1040, %false after %0 : i1
    %1041 = llhd.sig.extract %or_tree from %c-45_i7 : <i127> -> <i1>
    %1042 = comb.extract %oh_i from 20 : (i44) -> i1
    llhd.drv %1041, %1042 after %0 : i1
    %1043 = llhd.sig.extract %and_tree from %c-45_i7 : <i127> -> <i1>
    llhd.drv %1043, %1042 after %0 : i1
    %1044 = llhd.sig.extract %err_tree from %c-45_i7 : <i127> -> <i1>
    llhd.drv %1044, %false after %0 : i1
    %1045 = llhd.sig.extract %or_tree from %c-44_i7 : <i127> -> <i1>
    %1046 = comb.extract %oh_i from 21 : (i44) -> i1
    llhd.drv %1045, %1046 after %0 : i1
    %1047 = llhd.sig.extract %and_tree from %c-44_i7 : <i127> -> <i1>
    llhd.drv %1047, %1046 after %0 : i1
    %1048 = llhd.sig.extract %err_tree from %c-44_i7 : <i127> -> <i1>
    llhd.drv %1048, %false after %0 : i1
    %1049 = llhd.sig.extract %or_tree from %c-43_i7 : <i127> -> <i1>
    %1050 = comb.extract %oh_i from 22 : (i44) -> i1
    llhd.drv %1049, %1050 after %0 : i1
    %1051 = llhd.sig.extract %and_tree from %c-43_i7 : <i127> -> <i1>
    llhd.drv %1051, %1050 after %0 : i1
    %1052 = llhd.sig.extract %err_tree from %c-43_i7 : <i127> -> <i1>
    llhd.drv %1052, %false after %0 : i1
    %1053 = llhd.sig.extract %or_tree from %c-42_i7 : <i127> -> <i1>
    %1054 = comb.extract %oh_i from 23 : (i44) -> i1
    llhd.drv %1053, %1054 after %0 : i1
    %1055 = llhd.sig.extract %and_tree from %c-42_i7 : <i127> -> <i1>
    llhd.drv %1055, %1054 after %0 : i1
    %1056 = llhd.sig.extract %err_tree from %c-42_i7 : <i127> -> <i1>
    llhd.drv %1056, %false after %0 : i1
    %1057 = llhd.sig.extract %or_tree from %c-41_i7 : <i127> -> <i1>
    %1058 = comb.extract %oh_i from 24 : (i44) -> i1
    llhd.drv %1057, %1058 after %0 : i1
    %1059 = llhd.sig.extract %and_tree from %c-41_i7 : <i127> -> <i1>
    llhd.drv %1059, %1058 after %0 : i1
    %1060 = llhd.sig.extract %err_tree from %c-41_i7 : <i127> -> <i1>
    llhd.drv %1060, %false after %0 : i1
    %1061 = llhd.sig.extract %or_tree from %c-40_i7 : <i127> -> <i1>
    %1062 = comb.extract %oh_i from 25 : (i44) -> i1
    llhd.drv %1061, %1062 after %0 : i1
    %1063 = llhd.sig.extract %and_tree from %c-40_i7 : <i127> -> <i1>
    llhd.drv %1063, %1062 after %0 : i1
    %1064 = llhd.sig.extract %err_tree from %c-40_i7 : <i127> -> <i1>
    llhd.drv %1064, %false after %0 : i1
    %1065 = llhd.sig.extract %or_tree from %c-39_i7 : <i127> -> <i1>
    %1066 = comb.extract %oh_i from 26 : (i44) -> i1
    llhd.drv %1065, %1066 after %0 : i1
    %1067 = llhd.sig.extract %and_tree from %c-39_i7 : <i127> -> <i1>
    llhd.drv %1067, %1066 after %0 : i1
    %1068 = llhd.sig.extract %err_tree from %c-39_i7 : <i127> -> <i1>
    llhd.drv %1068, %false after %0 : i1
    %1069 = llhd.sig.extract %or_tree from %c-38_i7 : <i127> -> <i1>
    %1070 = comb.extract %oh_i from 27 : (i44) -> i1
    llhd.drv %1069, %1070 after %0 : i1
    %1071 = llhd.sig.extract %and_tree from %c-38_i7 : <i127> -> <i1>
    llhd.drv %1071, %1070 after %0 : i1
    %1072 = llhd.sig.extract %err_tree from %c-38_i7 : <i127> -> <i1>
    llhd.drv %1072, %false after %0 : i1
    %1073 = llhd.sig.extract %or_tree from %c-37_i7 : <i127> -> <i1>
    %1074 = comb.extract %oh_i from 28 : (i44) -> i1
    llhd.drv %1073, %1074 after %0 : i1
    %1075 = llhd.sig.extract %and_tree from %c-37_i7 : <i127> -> <i1>
    llhd.drv %1075, %1074 after %0 : i1
    %1076 = llhd.sig.extract %err_tree from %c-37_i7 : <i127> -> <i1>
    llhd.drv %1076, %false after %0 : i1
    %1077 = llhd.sig.extract %or_tree from %c-36_i7 : <i127> -> <i1>
    %1078 = comb.extract %oh_i from 29 : (i44) -> i1
    llhd.drv %1077, %1078 after %0 : i1
    %1079 = llhd.sig.extract %and_tree from %c-36_i7 : <i127> -> <i1>
    llhd.drv %1079, %1078 after %0 : i1
    %1080 = llhd.sig.extract %err_tree from %c-36_i7 : <i127> -> <i1>
    llhd.drv %1080, %false after %0 : i1
    %1081 = llhd.sig.extract %or_tree from %c-35_i7 : <i127> -> <i1>
    %1082 = comb.extract %oh_i from 30 : (i44) -> i1
    llhd.drv %1081, %1082 after %0 : i1
    %1083 = llhd.sig.extract %and_tree from %c-35_i7 : <i127> -> <i1>
    llhd.drv %1083, %1082 after %0 : i1
    %1084 = llhd.sig.extract %err_tree from %c-35_i7 : <i127> -> <i1>
    llhd.drv %1084, %false after %0 : i1
    %1085 = llhd.sig.extract %or_tree from %c-34_i7 : <i127> -> <i1>
    %1086 = comb.extract %oh_i from 31 : (i44) -> i1
    llhd.drv %1085, %1086 after %0 : i1
    %1087 = llhd.sig.extract %and_tree from %c-34_i7 : <i127> -> <i1>
    llhd.drv %1087, %1086 after %0 : i1
    %1088 = llhd.sig.extract %err_tree from %c-34_i7 : <i127> -> <i1>
    llhd.drv %1088, %false after %0 : i1
    %1089 = llhd.sig.extract %or_tree from %c-33_i7 : <i127> -> <i1>
    %1090 = comb.extract %oh_i from 32 : (i44) -> i1
    llhd.drv %1089, %1090 after %0 : i1
    %1091 = llhd.sig.extract %and_tree from %c-33_i7 : <i127> -> <i1>
    llhd.drv %1091, %1090 after %0 : i1
    %1092 = llhd.sig.extract %err_tree from %c-33_i7 : <i127> -> <i1>
    llhd.drv %1092, %false after %0 : i1
    %1093 = llhd.sig.extract %or_tree from %c-32_i7 : <i127> -> <i1>
    %1094 = comb.extract %oh_i from 33 : (i44) -> i1
    llhd.drv %1093, %1094 after %0 : i1
    %1095 = llhd.sig.extract %and_tree from %c-32_i7 : <i127> -> <i1>
    llhd.drv %1095, %1094 after %0 : i1
    %1096 = llhd.sig.extract %err_tree from %c-32_i7 : <i127> -> <i1>
    llhd.drv %1096, %false after %0 : i1
    %1097 = llhd.sig.extract %or_tree from %c-31_i7 : <i127> -> <i1>
    %1098 = comb.extract %oh_i from 34 : (i44) -> i1
    llhd.drv %1097, %1098 after %0 : i1
    %1099 = llhd.sig.extract %and_tree from %c-31_i7 : <i127> -> <i1>
    llhd.drv %1099, %1098 after %0 : i1
    %1100 = llhd.sig.extract %err_tree from %c-31_i7 : <i127> -> <i1>
    llhd.drv %1100, %false after %0 : i1
    %1101 = llhd.sig.extract %or_tree from %c-30_i7 : <i127> -> <i1>
    %1102 = comb.extract %oh_i from 35 : (i44) -> i1
    llhd.drv %1101, %1102 after %0 : i1
    %1103 = llhd.sig.extract %and_tree from %c-30_i7 : <i127> -> <i1>
    llhd.drv %1103, %1102 after %0 : i1
    %1104 = llhd.sig.extract %err_tree from %c-30_i7 : <i127> -> <i1>
    llhd.drv %1104, %false after %0 : i1
    %1105 = llhd.sig.extract %or_tree from %c-29_i7 : <i127> -> <i1>
    %1106 = comb.extract %oh_i from 36 : (i44) -> i1
    llhd.drv %1105, %1106 after %0 : i1
    %1107 = llhd.sig.extract %and_tree from %c-29_i7 : <i127> -> <i1>
    llhd.drv %1107, %1106 after %0 : i1
    %1108 = llhd.sig.extract %err_tree from %c-29_i7 : <i127> -> <i1>
    llhd.drv %1108, %false after %0 : i1
    %1109 = llhd.sig.extract %or_tree from %c-28_i7 : <i127> -> <i1>
    %1110 = comb.extract %oh_i from 37 : (i44) -> i1
    llhd.drv %1109, %1110 after %0 : i1
    %1111 = llhd.sig.extract %and_tree from %c-28_i7 : <i127> -> <i1>
    llhd.drv %1111, %1110 after %0 : i1
    %1112 = llhd.sig.extract %err_tree from %c-28_i7 : <i127> -> <i1>
    llhd.drv %1112, %false after %0 : i1
    %1113 = llhd.sig.extract %or_tree from %c-27_i7 : <i127> -> <i1>
    %1114 = comb.extract %oh_i from 38 : (i44) -> i1
    llhd.drv %1113, %1114 after %0 : i1
    %1115 = llhd.sig.extract %and_tree from %c-27_i7 : <i127> -> <i1>
    llhd.drv %1115, %1114 after %0 : i1
    %1116 = llhd.sig.extract %err_tree from %c-27_i7 : <i127> -> <i1>
    llhd.drv %1116, %false after %0 : i1
    %1117 = llhd.sig.extract %or_tree from %c-26_i7 : <i127> -> <i1>
    %1118 = comb.extract %oh_i from 39 : (i44) -> i1
    llhd.drv %1117, %1118 after %0 : i1
    %1119 = llhd.sig.extract %and_tree from %c-26_i7 : <i127> -> <i1>
    llhd.drv %1119, %1118 after %0 : i1
    %1120 = llhd.sig.extract %err_tree from %c-26_i7 : <i127> -> <i1>
    llhd.drv %1120, %false after %0 : i1
    %1121 = llhd.sig.extract %or_tree from %c-25_i7 : <i127> -> <i1>
    %1122 = comb.extract %oh_i from 40 : (i44) -> i1
    llhd.drv %1121, %1122 after %0 : i1
    %1123 = llhd.sig.extract %and_tree from %c-25_i7 : <i127> -> <i1>
    llhd.drv %1123, %1122 after %0 : i1
    %1124 = llhd.sig.extract %err_tree from %c-25_i7 : <i127> -> <i1>
    llhd.drv %1124, %false after %0 : i1
    %1125 = llhd.sig.extract %or_tree from %c-24_i7 : <i127> -> <i1>
    %1126 = comb.extract %oh_i from 41 : (i44) -> i1
    llhd.drv %1125, %1126 after %0 : i1
    %1127 = llhd.sig.extract %and_tree from %c-24_i7 : <i127> -> <i1>
    llhd.drv %1127, %1126 after %0 : i1
    %1128 = llhd.sig.extract %err_tree from %c-24_i7 : <i127> -> <i1>
    llhd.drv %1128, %false after %0 : i1
    %1129 = llhd.sig.extract %or_tree from %c-23_i7 : <i127> -> <i1>
    %1130 = comb.extract %oh_i from 42 : (i44) -> i1
    llhd.drv %1129, %1130 after %0 : i1
    %1131 = llhd.sig.extract %and_tree from %c-23_i7 : <i127> -> <i1>
    llhd.drv %1131, %1130 after %0 : i1
    %1132 = llhd.sig.extract %err_tree from %c-23_i7 : <i127> -> <i1>
    llhd.drv %1132, %false after %0 : i1
    %1133 = llhd.sig.extract %or_tree from %c-22_i7 : <i127> -> <i1>
    %1134 = comb.extract %oh_i from 43 : (i44) -> i1
    llhd.drv %1133, %1134 after %0 : i1
    %1135 = llhd.sig.extract %and_tree from %c-22_i7 : <i127> -> <i1>
    llhd.drv %1135, %1134 after %0 : i1
    %1136 = llhd.sig.extract %err_tree from %c-22_i7 : <i127> -> <i1>
    llhd.drv %1136, %false after %0 : i1
    %1137 = llhd.sig.extract %or_tree from %c-21_i7 : <i127> -> <i1>
    llhd.drv %1137, %false after %0 : i1
    %1138 = llhd.sig.extract %and_tree from %c-21_i7 : <i127> -> <i1>
    llhd.drv %1138, %false after %0 : i1
    %1139 = llhd.sig.extract %err_tree from %c-21_i7 : <i127> -> <i1>
    llhd.drv %1139, %false after %0 : i1
    %1140 = llhd.sig.extract %or_tree from %c-20_i7 : <i127> -> <i1>
    llhd.drv %1140, %false after %0 : i1
    %1141 = llhd.sig.extract %and_tree from %c-20_i7 : <i127> -> <i1>
    llhd.drv %1141, %false after %0 : i1
    %1142 = llhd.sig.extract %err_tree from %c-20_i7 : <i127> -> <i1>
    llhd.drv %1142, %false after %0 : i1
    %1143 = llhd.sig.extract %or_tree from %c-19_i7 : <i127> -> <i1>
    llhd.drv %1143, %false after %0 : i1
    %1144 = llhd.sig.extract %and_tree from %c-19_i7 : <i127> -> <i1>
    llhd.drv %1144, %false after %0 : i1
    %1145 = llhd.sig.extract %err_tree from %c-19_i7 : <i127> -> <i1>
    llhd.drv %1145, %false after %0 : i1
    %1146 = llhd.sig.extract %or_tree from %c-18_i7 : <i127> -> <i1>
    llhd.drv %1146, %false after %0 : i1
    %1147 = llhd.sig.extract %and_tree from %c-18_i7 : <i127> -> <i1>
    llhd.drv %1147, %false after %0 : i1
    %1148 = llhd.sig.extract %err_tree from %c-18_i7 : <i127> -> <i1>
    llhd.drv %1148, %false after %0 : i1
    %1149 = llhd.sig.extract %or_tree from %c-17_i7 : <i127> -> <i1>
    llhd.drv %1149, %false after %0 : i1
    %1150 = llhd.sig.extract %and_tree from %c-17_i7 : <i127> -> <i1>
    llhd.drv %1150, %false after %0 : i1
    %1151 = llhd.sig.extract %err_tree from %c-17_i7 : <i127> -> <i1>
    llhd.drv %1151, %false after %0 : i1
    %1152 = llhd.sig.extract %or_tree from %c-16_i7 : <i127> -> <i1>
    llhd.drv %1152, %false after %0 : i1
    %1153 = llhd.sig.extract %and_tree from %c-16_i7 : <i127> -> <i1>
    llhd.drv %1153, %false after %0 : i1
    %1154 = llhd.sig.extract %err_tree from %c-16_i7 : <i127> -> <i1>
    llhd.drv %1154, %false after %0 : i1
    %1155 = llhd.sig.extract %or_tree from %c-15_i7 : <i127> -> <i1>
    llhd.drv %1155, %false after %0 : i1
    %1156 = llhd.sig.extract %and_tree from %c-15_i7 : <i127> -> <i1>
    llhd.drv %1156, %false after %0 : i1
    %1157 = llhd.sig.extract %err_tree from %c-15_i7 : <i127> -> <i1>
    llhd.drv %1157, %false after %0 : i1
    %1158 = llhd.sig.extract %or_tree from %c-14_i7 : <i127> -> <i1>
    llhd.drv %1158, %false after %0 : i1
    %1159 = llhd.sig.extract %and_tree from %c-14_i7 : <i127> -> <i1>
    llhd.drv %1159, %false after %0 : i1
    %1160 = llhd.sig.extract %err_tree from %c-14_i7 : <i127> -> <i1>
    llhd.drv %1160, %false after %0 : i1
    %1161 = llhd.sig.extract %or_tree from %c-13_i7 : <i127> -> <i1>
    llhd.drv %1161, %false after %0 : i1
    %1162 = llhd.sig.extract %and_tree from %c-13_i7 : <i127> -> <i1>
    llhd.drv %1162, %false after %0 : i1
    %1163 = llhd.sig.extract %err_tree from %c-13_i7 : <i127> -> <i1>
    llhd.drv %1163, %false after %0 : i1
    %1164 = llhd.sig.extract %or_tree from %c-12_i7 : <i127> -> <i1>
    llhd.drv %1164, %false after %0 : i1
    %1165 = llhd.sig.extract %and_tree from %c-12_i7 : <i127> -> <i1>
    llhd.drv %1165, %false after %0 : i1
    %1166 = llhd.sig.extract %err_tree from %c-12_i7 : <i127> -> <i1>
    llhd.drv %1166, %false after %0 : i1
    %1167 = llhd.sig.extract %or_tree from %c-11_i7 : <i127> -> <i1>
    llhd.drv %1167, %false after %0 : i1
    %1168 = llhd.sig.extract %and_tree from %c-11_i7 : <i127> -> <i1>
    llhd.drv %1168, %false after %0 : i1
    %1169 = llhd.sig.extract %err_tree from %c-11_i7 : <i127> -> <i1>
    llhd.drv %1169, %false after %0 : i1
    %1170 = llhd.sig.extract %or_tree from %c-10_i7 : <i127> -> <i1>
    llhd.drv %1170, %false after %0 : i1
    %1171 = llhd.sig.extract %and_tree from %c-10_i7 : <i127> -> <i1>
    llhd.drv %1171, %false after %0 : i1
    %1172 = llhd.sig.extract %err_tree from %c-10_i7 : <i127> -> <i1>
    llhd.drv %1172, %false after %0 : i1
    %1173 = llhd.sig.extract %or_tree from %c-9_i7 : <i127> -> <i1>
    llhd.drv %1173, %false after %0 : i1
    %1174 = llhd.sig.extract %and_tree from %c-9_i7 : <i127> -> <i1>
    llhd.drv %1174, %false after %0 : i1
    %1175 = llhd.sig.extract %err_tree from %c-9_i7 : <i127> -> <i1>
    llhd.drv %1175, %false after %0 : i1
    %1176 = llhd.sig.extract %or_tree from %c-8_i7 : <i127> -> <i1>
    llhd.drv %1176, %false after %0 : i1
    %1177 = llhd.sig.extract %and_tree from %c-8_i7 : <i127> -> <i1>
    llhd.drv %1177, %false after %0 : i1
    %1178 = llhd.sig.extract %err_tree from %c-8_i7 : <i127> -> <i1>
    llhd.drv %1178, %false after %0 : i1
    %1179 = llhd.sig.extract %or_tree from %c-7_i7 : <i127> -> <i1>
    llhd.drv %1179, %false after %0 : i1
    %1180 = llhd.sig.extract %and_tree from %c-7_i7 : <i127> -> <i1>
    llhd.drv %1180, %false after %0 : i1
    %1181 = llhd.sig.extract %err_tree from %c-7_i7 : <i127> -> <i1>
    llhd.drv %1181, %false after %0 : i1
    %1182 = llhd.sig.extract %or_tree from %c-6_i7 : <i127> -> <i1>
    llhd.drv %1182, %false after %0 : i1
    %1183 = llhd.sig.extract %and_tree from %c-6_i7 : <i127> -> <i1>
    llhd.drv %1183, %false after %0 : i1
    %1184 = llhd.sig.extract %err_tree from %c-6_i7 : <i127> -> <i1>
    llhd.drv %1184, %false after %0 : i1
    %1185 = llhd.sig.extract %or_tree from %c-5_i7 : <i127> -> <i1>
    llhd.drv %1185, %false after %0 : i1
    %1186 = llhd.sig.extract %and_tree from %c-5_i7 : <i127> -> <i1>
    llhd.drv %1186, %false after %0 : i1
    %1187 = llhd.sig.extract %err_tree from %c-5_i7 : <i127> -> <i1>
    llhd.drv %1187, %false after %0 : i1
    %1188 = llhd.sig.extract %or_tree from %c-4_i7 : <i127> -> <i1>
    llhd.drv %1188, %false after %0 : i1
    %1189 = llhd.sig.extract %and_tree from %c-4_i7 : <i127> -> <i1>
    llhd.drv %1189, %false after %0 : i1
    %1190 = llhd.sig.extract %err_tree from %c-4_i7 : <i127> -> <i1>
    llhd.drv %1190, %false after %0 : i1
    %1191 = llhd.sig.extract %or_tree from %c-3_i7 : <i127> -> <i1>
    llhd.drv %1191, %false after %0 : i1
    %1192 = llhd.sig.extract %and_tree from %c-3_i7 : <i127> -> <i1>
    llhd.drv %1192, %false after %0 : i1
    %1193 = llhd.sig.extract %err_tree from %c-3_i7 : <i127> -> <i1>
    llhd.drv %1193, %false after %0 : i1
    %1194 = llhd.sig.extract %or_tree from %c-2_i7 : <i127> -> <i1>
    llhd.drv %1194, %false after %0 : i1
    %1195 = llhd.sig.extract %and_tree from %c-2_i7 : <i127> -> <i1>
    llhd.drv %1195, %false after %0 : i1
    %1196 = llhd.sig.extract %err_tree from %c-2_i7 : <i127> -> <i1>
    llhd.drv %1196, %false after %0 : i1
    %1197 = comb.or %1198, %1201 : i1
    %1198 = comb.extract %17 from 0 {sv.namehint = "oh0_err"} : (i127) -> i1
    %1199 = comb.xor %en_i, %true : i1
    %1200 = comb.extract %2 from 0 : (i127) -> i1
    %1201 = comb.and %1199, %1200 {sv.namehint = "enable_err"} : i1
    hw.output %1197 : i1
  }
  hw.module private @prim_packer_fifo(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, in %wdata_i : i32, out wready_o : i1, out rvalid_o : i1, out rdata_o : i1, in %rready_i : i1, out depth_o : i6) {
    %c-1_i6 = hw.constant -1 : i6
    %c0_i26 = hw.constant 0 : i26
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %c1_i6 = hw.constant 1 : i6
    %c-32_i6 = hw.constant -32 : i6
    %true = hw.constant true
    %false = hw.constant false
    %c0_i32 = hw.constant 0 : i32
    %c0_i6 = hw.constant 0 : i6
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %wdata_i_2 = llhd.sig name "wdata_i" %c0_i32 : i32
    %load_data = llhd.sig %false : i1
    %depth_q = llhd.sig %c0_i6 : i6
    %depth_d = llhd.sig %c0_i6 : i6
    %data_q = llhd.sig %c0_i32 : i32
    %data_d = llhd.sig %c0_i32 : i32
    %clr_q = llhd.sig %false : i1
    %clr_d = llhd.sig %false : i1
    %gen_unpack_mode.pull_data = llhd.sig %false : i1
    %gen_unpack_mode.ptr_q = llhd.sig %c0_i6 : i6
    %gen_unpack_mode.ptr_d = llhd.sig %c0_i6 : i6
    %gen_unpack_mode.max_value = llhd.sig %c0_i6 : i6
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
      llhd.drv %depth_q, %c0_i6 after %1 : i6
      llhd.drv %data_q, %c0_i32 after %1 : i32
      llhd.drv %clr_q, %true after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %45 = llhd.prb %depth_d : i6
      llhd.drv %depth_q, %45 after %1 : i6
      %46 = llhd.prb %data_d : i32
      llhd.drv %data_q, %46 after %1 : i32
      %47 = llhd.prb %clr_d : i1
      llhd.drv %clr_q, %47 after %1 : i1
      cf.br ^bb1
    }
    llhd.drv %clr_d, %clr_i after %0 : i1
    %4 = llhd.prb %depth_q : i6
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
      llhd.drv %gen_unpack_mode.ptr_q, %c0_i6 after %1 : i6
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %45 = llhd.prb %gen_unpack_mode.ptr_d : i6
      llhd.drv %gen_unpack_mode.ptr_q, %45 after %1 : i6
      cf.br ^bb1
    }
    llhd.drv %gen_unpack_mode.max_value, %c-32_i6 after %0 : i6
    %5 = llhd.prb %data_q : i32
    %6 = llhd.prb %gen_unpack_mode.ptr_q : i6
    %7 = comb.concat %c0_i26, %6 : i26, i6
    %8 = comb.shru %5, %7 {sv.namehint = "gen_unpack_mode.rdata_shifted"} : i32
    %9 = comb.icmp eq %4, %c1_i6 : i6
    %10 = comb.and %rready_i, %9 : i1
    %11 = llhd.prb %clr_q : i1
    %12 = comb.or %10, %11 {sv.namehint = "clear_status"} : i1
    %13 = comb.and %wvalid_i, %30 : i1
    llhd.drv %load_data, %13 after %0 : i1
    %14 = comb.and %33, %rready_i : i1
    llhd.drv %gen_unpack_mode.pull_data, %14 after %0 : i1
    %15 = llhd.prb %load_data : i1
    %16 = llhd.prb %gen_unpack_mode.max_value : i6
    %17 = llhd.prb %gen_unpack_mode.pull_data : i1
    %18 = comb.add %4, %c-1_i6 : i6
    %19 = comb.mux %17, %18, %4 : i6
    %20 = comb.mux %15, %16, %19 : i6
    %21 = comb.mux %12, %c0_i6, %20 : i6
    llhd.drv %depth_d, %21 after %0 : i6
    %22 = comb.add %6, %c1_i6 : i6
    %23 = comb.mux %17, %22, %6 : i6
    %24 = comb.mux %12, %c0_i6, %23 : i6
    llhd.drv %gen_unpack_mode.ptr_d, %24 after %0 : i6
    %25 = llhd.prb %wdata_i_2 : i32
    %26 = comb.mux %15, %25, %5 : i32
    %27 = comb.mux %12, %c0_i32, %26 : i32
    llhd.drv %data_d, %27 after %0 : i32
    %28 = comb.icmp eq %4, %c0_i6 : i6
    %29 = comb.xor %11, %true : i1
    %30 = comb.and %28, %29 : i1
    %31 = comb.extract %8 from 0 : (i32) -> i1
    %32 = comb.xor %28, %true : i1
    %33 = comb.and %32, %29 : i1
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %wdata_i_2, %wdata_i after %0 : i32
    hw.output %30, %33, %31, %4 : i1, i1, i1, i6
  }
  hw.module private @prim_reg_we_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i44, in %en_i : i1, out err_o : i1) {
    %c0_i6 = hw.constant 0 : i6
    %u_prim_buf.out_o = hw.instance "u_prim_buf" @prim_buf_47(in_i: %oh_i: i44) -> (out_o: i44) {sv.namehint = "oh_buf"}
    %u_prim_onehot_check.err_o = hw.instance "u_prim_onehot_check" @prim_onehot_check(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, oh_i: %u_prim_buf.out_o: i44, addr_i: %c0_i6: i6, en_i: %en_i: i1) -> (err_o: i1)
    hw.output %u_prim_onehot_check.err_o : i1
  }
  hw.module private @prim_sec_anchor_buf(in %in_i : i4, out out_o : i4) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf_46(in_i: %in_i: i4) -> (out_o: i4)
    hw.output %u_secure_anchor_buf.out_o : i4
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
  hw.module private @prim_subreg_arb(in %we : i1, in %wd : i32, in %de : i1, in %d : i32, in %q : i32, out wr_en : i1, out wr_data : i32) {
    hw.output %de, %d : i1, i32
  }
  hw.module private @prim_subreg_arb_49(in %we : i1, in %wd : i32, in %de : i1, in %d : i32, in %q : i32, out wr_en : i1, out wr_data : i32) {
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
  hw.module private @prim_subreg_ext(in %re : i1, in %we : i1, in %wd : i32, in %d : i32, out qe : i1, out qre : i1, out q : i32, out ds : i32, out qs : i32) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i32, i32, i32
  }
  hw.module private @prim_subreg(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
  hw.module private @prim_subreg_4(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c1_i32 = hw.constant 1 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c1_i32 after %0 : i32
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
    %c2_i32 = hw.constant 2 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c2_i32 after %0 : i32
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
  hw.module private @prim_subreg_6(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c3_i32 = hw.constant 3 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c3_i32 after %0 : i32
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
  hw.module private @prim_subreg_7(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c4_i32 = hw.constant 4 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c4_i32 after %0 : i32
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
  hw.module private @prim_subreg_8(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c5_i32 = hw.constant 5 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c5_i32 after %0 : i32
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
  hw.module private @prim_subreg_9(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c6_i32 = hw.constant 6 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c6_i32 after %0 : i32
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
  hw.module private @prim_subreg_10(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c7_i32 = hw.constant 7 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c7_i32 after %0 : i32
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
  hw.module private @prim_subreg_11(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c8_i32 = hw.constant 8 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c8_i32 after %0 : i32
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
  hw.module private @prim_subreg_12(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c9_i32 = hw.constant 9 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c9_i32 after %0 : i32
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
  hw.module private @prim_subreg_13(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c10_i32 = hw.constant 10 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c10_i32 after %0 : i32
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
  hw.module private @prim_subreg_14(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c11_i32 = hw.constant 11 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c11_i32 after %0 : i32
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
  hw.module private @prim_subreg_15(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c12_i32 = hw.constant 12 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c12_i32 after %0 : i32
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
  hw.module private @prim_subreg_16(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c13_i32 = hw.constant 13 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c13_i32 after %0 : i32
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
  hw.module private @prim_subreg_17(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c14_i32 = hw.constant 14 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c14_i32 after %0 : i32
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
  hw.module private @prim_subreg_18(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c15_i32 = hw.constant 15 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c15_i32 after %0 : i32
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
  hw.module private @prim_subreg_19(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c16_i32 = hw.constant 16 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c16_i32 after %0 : i32
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
  hw.module private @prim_subreg_20(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c17_i32 = hw.constant 17 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c17_i32 after %0 : i32
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
  hw.module private @prim_subreg_21(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c18_i32 = hw.constant 18 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c18_i32 after %0 : i32
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
  hw.module private @prim_subreg_22(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c19_i32 = hw.constant 19 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c19_i32 after %0 : i32
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
  hw.module private @prim_subreg_23(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c20_i32 = hw.constant 20 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c20_i32 after %0 : i32
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
  hw.module private @prim_subreg_24(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c21_i32 = hw.constant 21 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c21_i32 after %0 : i32
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
  hw.module private @prim_subreg_25(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c22_i32 = hw.constant 22 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c22_i32 after %0 : i32
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
  hw.module private @prim_subreg_26(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c23_i32 = hw.constant 23 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c23_i32 after %0 : i32
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
  hw.module private @prim_subreg_27(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c24_i32 = hw.constant 24 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c24_i32 after %0 : i32
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
  hw.module private @prim_subreg_28(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c25_i32 = hw.constant 25 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c25_i32 after %0 : i32
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
  hw.module private @prim_subreg_29(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c26_i32 = hw.constant 26 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c26_i32 after %0 : i32
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
  hw.module private @prim_subreg_30(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c27_i32 = hw.constant 27 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c27_i32 after %0 : i32
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
  hw.module private @prim_subreg_31(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c28_i32 = hw.constant 28 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c28_i32 after %0 : i32
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
  hw.module private @prim_subreg_32(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c29_i32 = hw.constant 29 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c29_i32 after %0 : i32
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
  hw.module private @prim_subreg_33(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c30_i32 = hw.constant 30 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c30_i32 after %0 : i32
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
  hw.module private @prim_subreg_34(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c31_i32 = hw.constant 31 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c31_i32 after %0 : i32
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
  hw.module private @prim_subreg_35(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c32_i32 = hw.constant 32 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c32_i32 after %0 : i32
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
  hw.module private @prim_subreg_36(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c33_i32 = hw.constant 33 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c33_i32 after %0 : i32
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
  hw.module private @prim_subreg_37(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c34_i32 = hw.constant 34 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c34_i32 after %0 : i32
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
  hw.module private @prim_subreg_38(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c35_i32 = hw.constant 35 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c35_i32 after %0 : i32
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
  hw.module private @prim_subreg_39(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c36_i32 = hw.constant 36 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c36_i32 after %0 : i32
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
  hw.module private @prim_subreg_40(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c37_i32 = hw.constant 37 : i32
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
      llhd.drv %q, %c37_i32 after %0 : i32
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
  hw.module private @prim_subreg_41(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_49(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
  hw.module private @tlul_adapter_reg(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %en_ifetch_i : i4, out intg_error_o : i1, out re_o : i1, out we_o : i1, out addr_o : i10, out wdata_o : i32, out be_o : i4, in %busy_i : i1, in %rdata_i : i32, in %error_i : i1) {
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
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen_48(tl_i: %32: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
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
    %22 = comb.extract %a_address from 2 : (i32) -> i8
    %23 = comb.concat %22, %c0_i2 : i8, i2
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
    hw.output %u_rsp_intg_gen.tl_o, %false, %21, %19, %23, %a_data, %a_mask : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, i1, i1, i1, i10, i32, i4
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
  hw.module private @tlul_rsp_intg_gen_48(in %tl_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) {
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
    %gen_flops.u_prim_flop_2sync.q_o = hw.instance "gen_flops.u_prim_flop_2sync" @prim_flop_2sync_2(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %mubi_i: i4) -> (q_o: i4) {sv.namehint = "gen_flops.mubi_sync"}
    %gen_flops.gen_stable_chks.u_prim_flop_3rd_stage.q_o = hw.instance "gen_flops.gen_stable_chks.u_prim_flop_3rd_stage" @prim_flop_3(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %gen_flops.u_prim_flop_2sync.q_o: i4) -> (q_o: i4)
    llhd.drv %gen_flops.gen_stable_chks.mubi_q, %gen_flops.gen_stable_chks.u_prim_flop_3rd_stage.q_o after %0 : i4
    %2 = llhd.prb %gen_flops.gen_stable_chks.mubi_q : i4
    %gen_flops.gen_stable_chks.u_mubi_xor.out_o = hw.instance "gen_flops.gen_stable_chks.u_mubi_xor" @prim_xor2(in0_i: %gen_flops.u_prim_flop_2sync.q_o: i4, in1_i: %2: i4) -> (out_o: i4) {sv.namehint = "gen_flops.gen_stable_chks.sig_unstable"}
    %gen_flops.gen_stable_chks.gen_bufs_muxes_0.u_sig_unstable_buf.out_o = hw.instance "gen_flops.gen_stable_chks.gen_bufs_muxes_0.u_sig_unstable_buf" @prim_sec_anchor_buf(in_i: %gen_flops.gen_stable_chks.u_mubi_xor.out_o: i4) -> (out_o: i4) {sv.namehint = "gen_flops.gen_stable_chks.gen_bufs_muxes_0.sig_unstable_buf"}
    %gen_flops.gen_stable_chks.gen_bufs_muxes_1.u_sig_unstable_buf.out_o = hw.instance "gen_flops.gen_stable_chks.gen_bufs_muxes_1.u_sig_unstable_buf" @prim_sec_anchor_buf(in_i: %gen_flops.gen_stable_chks.u_mubi_xor.out_o: i4) -> (out_o: i4) {sv.namehint = "gen_flops.gen_stable_chks.gen_bufs_muxes_1.sig_unstable_buf"}
    %gen_flops.gen_stable_chks.gen_bufs_muxes_2.u_sig_unstable_buf.out_o = hw.instance "gen_flops.gen_stable_chks.gen_bufs_muxes_2.u_sig_unstable_buf" @prim_sec_anchor_buf(in_i: %gen_flops.gen_stable_chks.u_mubi_xor.out_o: i4) -> (out_o: i4) {sv.namehint = "gen_flops.gen_stable_chks.gen_bufs_muxes_2.sig_unstable_buf"}
    %gen_flops.gen_stable_chks.gen_bufs_muxes_3.u_sig_unstable_buf.out_o = hw.instance "gen_flops.gen_stable_chks.gen_bufs_muxes_3.u_sig_unstable_buf" @prim_sec_anchor_buf(in_i: %gen_flops.gen_stable_chks.u_mubi_xor.out_o: i4) -> (out_o: i4) {sv.namehint = "gen_flops.gen_stable_chks.gen_bufs_muxes_3.sig_unstable_buf"}
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
  hw.module private @prim_mubi4_sender(in %clk_i : i1, in %rst_ni : i1, in %mubi_i : i4, out mubi_o : i4) {
    %gen_flops.u_prim_flop.q_o = hw.instance "gen_flops.u_prim_flop" @prim_flop_3(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %mubi_i: i4) -> (q_o: i4) {sv.namehint = "mubi_out"}
    hw.output %gen_flops.u_prim_flop.q_o : i4
  }
  hw.module private @prim_mubi4_dec(in %mubi_i : i4, out mubi_dec_o : i1) {
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %c0_i4 = hw.constant 0 : i4
    %mubi_out = llhd.sig %c0_i4 : i4
    %1 = comb.extract %mubi_i from 0 : (i4) -> i1
    %2 = llhd.sig.extract %mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_bits_0.u_prim_buf.out_o = hw.instance "gen_bits_0.u_prim_buf" @prim_buf(in_i: %1: i1) -> (out_o: i1)
    llhd.drv %2, %gen_bits_0.u_prim_buf.out_o after %0 : i1
    %3 = comb.extract %mubi_i from 1 : (i4) -> i1
    %4 = llhd.sig.extract %mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_bits_1.u_prim_buf.out_o = hw.instance "gen_bits_1.u_prim_buf" @prim_buf(in_i: %3: i1) -> (out_o: i1)
    llhd.drv %4, %gen_bits_1.u_prim_buf.out_o after %0 : i1
    %5 = comb.extract %mubi_i from 2 : (i4) -> i1
    %6 = llhd.sig.extract %mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_bits_2.u_prim_buf.out_o = hw.instance "gen_bits_2.u_prim_buf" @prim_buf(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %6, %gen_bits_2.u_prim_buf.out_o after %0 : i1
    %7 = comb.extract %mubi_i from 3 : (i4) -> i1
    %8 = llhd.sig.extract %mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_bits_3.u_prim_buf.out_o = hw.instance "gen_bits_3.u_prim_buf" @prim_buf(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %8, %gen_bits_3.u_prim_buf.out_o after %0 : i1
    %9 = llhd.prb %mubi_out : i4
    %10 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%9) : (i4) -> i1
    hw.output %10 : i1
  }
  hw.module private @prim_lfsr(in %clk_i : i1, in %rst_ni : i1, in %seed_en_i : i1, in %seed_i : i64, in %lfsr_en_i : i1, in %entropy_i : i1, out state_o : i4) {
    %c0_i59 = hw.constant 0 : i59
    %c-5_i5 = hw.constant -5 : i5
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %c0_i2 = hw.constant 0 : i2
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i63 = hw.constant 0 : i63
    %c0_i4 = hw.constant 0 : i4
    %c0_i64 = hw.constant 0 : i64
    %c130661366480321300_i64 = hw.constant 130661366480321300 : i64
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %seed_i_2 = llhd.sig name "seed_i" %c0_i64 : i64
    %lfsr_en_i_3 = llhd.sig name "lfsr_en_i" %false : i1
    %state_o = llhd.sig %c0_i4 : i4
    %lockup = llhd.sig %false : i1
    %lfsr_d = llhd.sig %c0_i64 : i64
    %lfsr_q = llhd.sig %c0_i64 : i64
    %next_lfsr_state = llhd.sig %c0_i64 : i64
    %4 = comb.concat %c0_i63, %entropy_i : i63, i1
    %5 = llhd.prb %lfsr_q {sv.namehint = "sbox_out"} : i64
    %6 = comb.extract %5 from 0 : (i64) -> i1
    %7 = comb.replicate %6 : (i1) -> i5
    %8 = comb.and %7, %c-5_i5 : i5
    %9 = comb.concat %8, %c0_i59 : i5, i59
    %10 = comb.extract %5 from 1 : (i64) -> i63
    %11 = comb.concat %false, %10 : i1, i63
    %12 = comb.xor %4, %9, %11 : i64
    llhd.drv %next_lfsr_state, %12 after %1 : i64
    %13 = comb.icmp eq %5, %c0_i64 : i64
    llhd.drv %lockup, %13 after %1 : i1
    %14 = llhd.prb %seed_i_2 : i64
    %15 = llhd.prb %lfsr_en_i_3 : i1
    %16 = llhd.prb %lockup : i1
    %17 = comb.and %15, %16 : i1
    %18 = llhd.prb %next_lfsr_state : i64
    %19 = comb.mux %15, %18, %5 : i64
    %20 = comb.mux %17, %c130661366480321300_i64, %19 : i64
    %21 = comb.mux %seed_en_i, %14, %20 : i64
    llhd.drv %lfsr_d, %21 after %1 : i64
    %22 = llhd.sig.extract %state_o from %c0_i2 : <i4> -> <i1>
    %23 = comb.extract %5 from 15 : (i64) -> i1
    llhd.drv %22, %23 after %1 : i1
    %24 = llhd.sig.extract %state_o from %c1_i2 : <i4> -> <i1>
    %25 = comb.extract %5 from 20 : (i64) -> i1
    llhd.drv %24, %25 after %1 : i1
    %26 = llhd.sig.extract %state_o from %c-2_i2 : <i4> -> <i1>
    %27 = comb.extract %5 from 5 : (i64) -> i1
    llhd.drv %26, %27 after %1 : i1
    %28 = llhd.sig.extract %state_o from %c-1_i2 : <i4> -> <i1>
    %29 = comb.extract %5 from 10 : (i64) -> i1
    llhd.drv %28, %29 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %31 = llhd.prb %clk_i_0 : i1
      %32 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %33 = llhd.prb %clk_i_0 : i1
      %34 = comb.xor bin %31, %true : i1
      %35 = comb.and bin %34, %33 : i1
      %36 = llhd.prb %rst_ni_1 : i1
      %37 = comb.xor bin %36, %true : i1
      %38 = comb.and bin %32, %37 : i1
      %39 = comb.or bin %35, %38 : i1
      cf.cond_br %39, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %40 = llhd.prb %rst_ni_1 : i1
      %41 = comb.xor %40, %true : i1
      cf.cond_br %41, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %lfsr_q, %c130661366480321300_i64 after %0 : i64
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %42 = llhd.prb %lfsr_d : i64
      llhd.drv %lfsr_q, %42 after %0 : i64
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %seed_i_2, %seed_i after %1 : i64
    llhd.drv %lfsr_en_i_3, %lfsr_en_i after %1 : i1
    %30 = llhd.prb %state_o : i4
    hw.output %30 : i4
  }
  hw.module private @adc_ana(in %adc_a0_ai : i1, in %adc_a1_ai : i1, out adc_d_ch0_o : i10, out adc_d_ch1_o : i10) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i10 = hw.constant 0 : i10
    %c-342_i10 = hw.constant -342 : i10
    %c341_i10 = hw.constant 341 : i10
    %adc_d_vi0_hook = llhd.sig %c0_i10 : i10
    %adc_d_vi1_hook = llhd.sig %c0_i10 : i10
    llhd.drv %adc_d_vi0_hook, %c341_i10 after %0 : i10
    llhd.drv %adc_d_vi1_hook, %c-342_i10 after %0 : i10
    %1 = llhd.prb %adc_d_vi0_hook : i10
    %2 = comb.mux %adc_a0_ai, %1, %c0_i10 : i10
    %3 = llhd.prb %adc_d_vi1_hook : i10
    %4 = comb.mux %adc_a1_ai, %3, %c0_i10 : i10
    hw.output %2, %4 : i10, i10
  }
  hw.module private @adc(in %adc_a0_ai : i1, in %adc_a1_ai : i1, in %adc_chnsel_i : i2, in %adc_pd_i : i1, in %clk_adc_i : i1, in %rst_adc_ni : i1, out adc_d_o : i10, out adc_d_val_o : i1) {
    %c-1_i10 = hw.constant -1 : i10
    %c-1_i8 = hw.constant -1 : i8
    %c19_i8 = hw.constant 19 : i8
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i10 = hw.constant 0 : i10
    %true = hw.constant true
    %c0_i2 = hw.constant 0 : i2
    %false = hw.constant false
    %c0_i8 = hw.constant 0 : i8
    %adc_chnsel_i_0 = llhd.sig name "adc_chnsel_i" %c0_i2 : i2
    %adc_pd_i_1 = llhd.sig name "adc_pd_i" %false : i1
    %clk_adc_i_2 = llhd.sig name "clk_adc_i" %false : i1
    %2 = llhd.prb %clk_adc_i_2 : i1
    %rst_adc_ni_3 = llhd.sig name "rst_adc_ni" %false : i1
    %3 = llhd.prb %rst_adc_ni_3 : i1
    %adc_d_o = llhd.sig %c0_i10 : i10
    %adc_d_val_o = llhd.sig %false : i1
    %adc_en = llhd.sig %false : i1
    %chn_selected = llhd.sig %false : i1
    %chn_selected_d = llhd.sig %false : i1
    %new_convert = llhd.sig %false : i1
    %adc_busy = llhd.sig %false : i1
    %adc_d_ch0 = llhd.sig %c0_i10 : i10
    %adc_d_ch1 = llhd.sig %c0_i10 : i10
    %cnv_cyc = llhd.sig %c0_i8 : i8
    %ConvertCount = llhd.sig %c0_i8 : i8
    %u_adc_ana.adc_d_ch0_o, %u_adc_ana.adc_d_ch1_o = hw.instance "u_adc_ana" @adc_ana(adc_a0_ai: %adc_a0_ai: i1, adc_a1_ai: %adc_a1_ai: i1) -> (adc_d_ch0_o: i10, adc_d_ch1_o: i10)
    llhd.drv %adc_d_ch0, %u_adc_ana.adc_d_ch0_o after %1 : i10
    llhd.drv %adc_d_ch1, %u_adc_ana.adc_d_ch1_o after %1 : i10
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %14 = llhd.prb %clk_adc_i_2 : i1
      %15 = llhd.prb %rst_adc_ni_3 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %16 = llhd.prb %clk_adc_i_2 : i1
      %17 = comb.xor bin %14, %true : i1
      %18 = comb.and bin %17, %16 : i1
      %19 = llhd.prb %rst_adc_ni_3 : i1
      %20 = comb.xor bin %19, %true : i1
      %21 = comb.and bin %15, %20 : i1
      %22 = comb.or bin %18, %21 : i1
      cf.cond_br %22, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %23 = llhd.prb %rst_adc_ni_3 : i1
      %24 = comb.xor %23, %true : i1
      cf.cond_br %24, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %adc_en, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %25 = llhd.prb %adc_pd_i_1 : i1
      %26 = comb.xor %25, %true : i1
      llhd.drv %adc_en, %26 after %0 : i1
      cf.br ^bb1
    }
    %4 = llhd.prb %adc_chnsel_i_0 : i2
    %5 = comb.icmp ne %4, %c0_i2 : i2
    llhd.drv %chn_selected, %5 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %14 = llhd.prb %clk_adc_i_2 : i1
      %15 = llhd.prb %rst_adc_ni_3 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %16 = llhd.prb %clk_adc_i_2 : i1
      %17 = comb.xor bin %14, %true : i1
      %18 = comb.and bin %17, %16 : i1
      %19 = llhd.prb %rst_adc_ni_3 : i1
      %20 = comb.xor bin %19, %true : i1
      %21 = comb.and bin %15, %20 : i1
      %22 = comb.or bin %18, %21 : i1
      cf.cond_br %22, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %23 = llhd.prb %rst_adc_ni_3 : i1
      %24 = comb.xor %23, %true : i1
      cf.cond_br %24, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %chn_selected_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %25 = llhd.prb %chn_selected : i1
      llhd.drv %chn_selected_d, %25 after %0 : i1
      cf.br ^bb1
    }
    %6 = llhd.prb %chn_selected : i1
    %7 = llhd.prb %chn_selected_d : i1
    %8 = comb.xor %7, %true : i1
    %9 = llhd.prb %adc_busy : i1
    %10 = comb.xor %9, %true : i1
    %11 = comb.and %6, %8, %10 : i1
    llhd.drv %new_convert, %11 after %1 : i1
    llhd.drv %ConvertCount, %c19_i8 after %1 : i8
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 8 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb11, ^bb12
      %14 = llhd.prb %clk_adc_i_2 : i1
      %15 = llhd.prb %rst_adc_ni_3 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %16 = llhd.prb %clk_adc_i_2 : i1
      %17 = comb.xor bin %14, %true : i1
      %18 = comb.and bin %17, %16 : i1
      %19 = llhd.prb %rst_adc_ni_3 : i1
      %20 = comb.xor bin %19, %true : i1
      %21 = comb.and bin %15, %20 : i1
      %22 = comb.or bin %18, %21 : i1
      cf.cond_br %22, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %23 = llhd.prb %rst_adc_ni_3 : i1
      %24 = comb.xor %23, %true : i1
      cf.cond_br %24, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %cnv_cyc, %c0_i8 after %0 : i8
      llhd.drv %adc_busy, %false after %0 : i1
      llhd.drv %adc_d_val_o, %false after %0 : i1
      llhd.drv %adc_d_o, %c0_i10 after %0 : i10
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %25 = llhd.prb %adc_en : i1
      %26 = llhd.prb %chn_selected : i1
      %27 = comb.and %25, %26 : i1
      %28 = comb.xor %27, %true : i1
      cf.cond_br %28, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %cnv_cyc, %c0_i8 after %0 : i8
      llhd.drv %adc_busy, %false after %0 : i1
      llhd.drv %adc_d_val_o, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %29 = llhd.prb %new_convert : i1
      cf.cond_br %29, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %30 = llhd.prb %ConvertCount : i8
      llhd.drv %cnv_cyc, %30 after %0 : i8
      llhd.drv %adc_busy, %true after %0 : i1
      llhd.drv %adc_d_val_o, %false after %0 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %31 = llhd.prb %adc_busy : i1
      %32 = llhd.prb %cnv_cyc : i8
      %33 = comb.icmp ne %32, %c0_i8 : i8
      %34 = comb.and %31, %33 : i1
      cf.cond_br %34, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %35 = llhd.prb %cnv_cyc : i8
      %36 = comb.add %35, %c-1_i8 : i8
      llhd.drv %cnv_cyc, %36 after %0 : i8
      llhd.drv %adc_busy, %true after %0 : i1
      llhd.drv %adc_d_val_o, %false after %0 : i1
      cf.br ^bb1
    ^bb11:  // pred: ^bb9
      %37 = llhd.prb %adc_busy : i1
      cf.cond_br %37, ^bb12, ^bb1
    ^bb12:  // pred: ^bb11
      llhd.drv %adc_busy, %false after %0 : i1
      llhd.drv %adc_d_val_o, %true after %0 : i1
      %38 = llhd.prb %adc_chnsel_i_0 : i2
      %39 = llhd.prb %adc_d_o : i10
      %40 = llhd.prb %adc_d_ch0 : i10
      %41 = llhd.prb %adc_d_ch1 : i10
      %42 = hw.array_create %c-1_i10, %41, %40, %39 : i10
      %43 = hw.array_get %42[%38] : !hw.array<4xi10>, i2
      llhd.drv %adc_d_o, %43 after %0 : i10
      cf.br ^bb1
    }
    llhd.drv %adc_chnsel_i_0, %adc_chnsel_i after %1 : i2
    llhd.drv %adc_pd_i_1, %adc_pd_i after %1 : i1
    llhd.drv %clk_adc_i_2, %clk_adc_i after %1 : i1
    llhd.drv %rst_adc_ni_3, %rst_adc_ni after %1 : i1
    %12 = llhd.prb %adc_d_o : i10
    %13 = llhd.prb %adc_d_val_o : i1
    hw.output %12, %13 : i10, i1
  }
  hw.module private @aon_clk(in %vcore_pok_h_i : i1, in %clk_aon_pd_ni : i1, in %rst_aon_clk_ni : i1, in %clk_src_aon_en_i : i1, in %scan_mode_i : i1, in %aon_osc_cal_i : i1, out clk_src_aon_o : i1, out clk_src_aon_val_o : i1) {
    %true = hw.constant true
    %u_aon_osc.aon_clk_o = hw.instance "u_aon_osc" @aon_osc(vcore_pok_h_i: %vcore_pok_h_i: i1, aon_en_i: %1: i1, aon_osc_cal_i: %aon_osc_cal_i: i1) -> (aon_clk_o: i1) {sv.namehint = "clk"}
    %u_clk_aon_buf.clk_o = hw.instance "u_clk_aon_buf" @prim_clock_buf(clk_i: %u_aon_osc.aon_clk_o: i1) -> (clk_o: i1)
    %u_no_scan_val_sync.q_o = hw.instance "u_no_scan_val_sync" @prim_flop_2sync(clk_i: %u_clk_aon_buf.clk_o: i1, rst_ni: %1: i1, d_i: %true: i1) -> (q_o: i1)
    %0 = comb.and %clk_src_aon_en_i, %clk_aon_pd_ni, %rst_aon_clk_ni {sv.namehint = "osc_en"} : i1
    %1 = comb.or %scan_mode_i, %0 {sv.namehint = "rst_val_n"} : i1
    hw.output %u_clk_aon_buf.clk_o, %u_no_scan_val_sync.q_o : i1, i1
  }
  hw.module private @aon_osc(in %vcore_pok_h_i : i1, in %aon_en_i : i1, in %aon_osc_cal_i : i1, out aon_clk_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %vcore_pok_h_i_0 = llhd.sig name "vcore_pok_h_i" %false : i1
    %2 = llhd.prb %vcore_pok_h_i_0 : i1
    %clk = llhd.sig %false : i1
    %3 = llhd.prb %clk : i1
    %en_osc_re = llhd.sig %false : i1
    %en_osc_fe = llhd.sig %false : i1
    %u_buf.clk_o = hw.instance "u_buf" @prim_clock_buf(clk_i: %3: i1) -> (clk_o: i1)
    llhd.drv %clk, %false after %1 : i1
    %4 = comb.and %2, %aon_en_i : i1
    llhd.drv %en_osc_re, %4 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %5 = llhd.prb %clk : i1
      %6 = llhd.prb %vcore_pok_h_i_0 : i1
      llhd.wait (%3, %2 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %7 = llhd.prb %clk : i1
      %8 = comb.xor bin %7, %true : i1
      %9 = comb.and bin %5, %8 : i1
      %10 = llhd.prb %vcore_pok_h_i_0 : i1
      %11 = comb.xor bin %10, %true : i1
      %12 = comb.and bin %6, %11 : i1
      %13 = comb.or bin %9, %12 : i1
      cf.cond_br %13, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %14 = llhd.prb %vcore_pok_h_i_0 : i1
      %15 = comb.xor %14, %true : i1
      cf.cond_br %15, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %en_osc_fe, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %16 = llhd.prb %en_osc_re : i1
      llhd.drv %en_osc_fe, %16 after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %vcore_pok_h_i_0, %vcore_pok_h_i after %1 : i1
    hw.output %u_buf.clk_o : i1
  }
  hw.module private @ast_alert(in %clk_i : i1, in %rst_ni : i1, in %alert_src_i : !hw.struct<p: i1, n: i1>, in %alert_ack_i : !hw.struct<p: i1, n: i1>, in %alert_trig_i : !hw.struct<p: i1, n: i1>, out alert_req_o : !hw.struct<p: i1, n: i1>) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [false, false] : !hw.struct<p: i1, n: i1>
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %alert_req_o = llhd.sig %2 : !hw.struct<p: i1, n: i1>
    %p_alert = llhd.sig %false : i1
    %set_p_alert = llhd.sig %false : i1
    %clr_p_alert = llhd.sig %false : i1
    %n_alert = llhd.sig %false : i1
    %set_n_alert = llhd.sig %false : i1
    %clr_n_alert = llhd.sig %false : i1
    %p = hw.struct_extract %alert_src_i["p"] {sv.namehint = "p_alert_src"} : !hw.struct<p: i1, n: i1>
    %n = hw.struct_extract %alert_src_i["n"] {sv.namehint = "n_alert_src"} : !hw.struct<p: i1, n: i1>
    %p_2 = hw.struct_extract %alert_ack_i["p"] {sv.namehint = "p_alert_ack"} : !hw.struct<p: i1, n: i1>
    %n_3 = hw.struct_extract %alert_ack_i["n"] {sv.namehint = "n_alert_ack"} : !hw.struct<p: i1, n: i1>
    %p_4 = hw.struct_extract %alert_trig_i["p"] {sv.namehint = "p_alert_trig"} : !hw.struct<p: i1, n: i1>
    %n_5 = hw.struct_extract %alert_trig_i["n"] {sv.namehint = "n_alert_trig"} : !hw.struct<p: i1, n: i1>
    %5 = llhd.sig.struct_extract %alert_req_o["p"] : <!hw.struct<p: i1, n: i1>>
    llhd.drv %5, %11 after %1 : i1
    %6 = llhd.sig.struct_extract %alert_req_o["n"] : <!hw.struct<p: i1, n: i1>>
    llhd.drv %6, %17 after %1 : i1
    %7 = comb.or %p, %p_4 : i1
    llhd.drv %set_p_alert, %7 after %1 : i1
    %8 = llhd.prb %set_p_alert : i1
    %9 = comb.xor %8, %true : i1
    %10 = comb.and %9, %p_2 : i1
    llhd.drv %clr_p_alert, %10 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %19 = llhd.prb %clk_i_0 : i1
      %20 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %21 = llhd.prb %clk_i_0 : i1
      %22 = comb.xor bin %19, %true : i1
      %23 = comb.and bin %22, %21 : i1
      %24 = llhd.prb %rst_ni_1 : i1
      %25 = comb.xor bin %24, %true : i1
      %26 = comb.and bin %20, %25 : i1
      %27 = comb.or bin %23, %26 : i1
      cf.cond_br %27, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %28 = llhd.prb %rst_ni_1 : i1
      %29 = comb.xor %28, %true : i1
      cf.cond_br %29, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %p_alert, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %30 = llhd.prb %set_p_alert : i1
      cf.cond_br %30, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %p_alert, %true after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %31 = llhd.prb %clr_p_alert : i1
      cf.cond_br %31, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %p_alert, %false after %0 : i1
      cf.br ^bb1
    }
    %11 = llhd.prb %p_alert {sv.namehint = "p_alert_req"} : i1
    %12 = comb.and %n, %n_5 : i1
    %13 = comb.xor %12, %true : i1
    llhd.drv %set_n_alert, %13 after %1 : i1
    %14 = llhd.prb %set_n_alert : i1
    %15 = comb.or %14, %n_3 : i1
    %16 = comb.xor %15, %true : i1
    llhd.drv %clr_n_alert, %16 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %19 = llhd.prb %clk_i_0 : i1
      %20 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %21 = llhd.prb %clk_i_0 : i1
      %22 = comb.xor bin %19, %true : i1
      %23 = comb.and bin %22, %21 : i1
      %24 = llhd.prb %rst_ni_1 : i1
      %25 = comb.xor bin %24, %true : i1
      %26 = comb.and bin %20, %25 : i1
      %27 = comb.or bin %23, %26 : i1
      cf.cond_br %27, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %28 = llhd.prb %rst_ni_1 : i1
      %29 = comb.xor %28, %true : i1
      cf.cond_br %29, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %n_alert, %true after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %30 = llhd.prb %set_n_alert : i1
      cf.cond_br %30, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %n_alert, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %31 = llhd.prb %clr_n_alert : i1
      cf.cond_br %31, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %n_alert, %true after %0 : i1
      cf.br ^bb1
    }
    %17 = llhd.prb %n_alert {sv.namehint = "n_alert_req"} : i1
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    %18 = llhd.prb %alert_req_o : !hw.struct<p: i1, n: i1>
    hw.output %18 : !hw.struct<p: i1, n: i1>
  }
  hw.module private @ast_clks_byp(in %vcaon_pok_i : i1, in %vcaon_pok_por_i : i1, in %deep_sleep_i : i1, in %clk_src_sys_en_i : i1, in %clk_osc_sys_i : i1, in %clk_osc_sys_val_i : i1, in %clk_src_io_en_i : i1, in %clk_osc_io_i : i1, in %clk_osc_io_val_i : i1, in %clk_src_usb_en_i : i1, in %clk_osc_usb_i : i1, in %clk_osc_usb_val_i : i1, in %clk_osc_aon_i : i1, in %clk_osc_aon_val_i : i1, in %clk_ast_ext_i : i1, in %io_clk_byp_req_i : i4, in %all_clk_byp_req_i : i4, in %ext_freq_is_96m_i : i4, out io_clk_byp_ack_o : i4, out all_clk_byp_ack_o : i4, out clk_src_sys_o : i1, out clk_src_sys_val_o : i1, out clk_src_io_o : i1, out clk_src_io_val_o : i1, out clk_src_io_48m_o : i4, out clk_src_usb_o : i1, out clk_src_usb_val_o : i1, out clk_src_aon_o : i1, out clk_src_aon_val_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %true = hw.constant true {sv.namehint = "clk_ext_aon_val"}
    %clk_osc_sys_i_0 = llhd.sig name "clk_osc_sys_i" %false : i1
    %clk_ast_ext_i_1 = llhd.sig name "clk_ast_ext_i" %false : i1
    %scan_mode_i = llhd.sig %false : i1
    %scan_reset_ni = llhd.sig %false : i1
    %clk_aon = llhd.sig %false : i1
    %2 = llhd.prb %clk_aon : i1
    %rst_aon_n = llhd.sig %false : i1
    %3 = llhd.prb %rst_aon_n : i1
    %vcaon_pok = llhd.sig %false : i1
    %rst_sw_clk_byp_en = llhd.sig %false : i1
    %sw_all_clk_byp = llhd.sig %false : i1
    %sw_io_clk_byp = llhd.sig %false : i1
    %clk_ast_ext_scn = llhd.sig %false : i1
    %4 = llhd.prb %clk_ast_ext_scn : i1
    %sw_ckbpe_sync_n = llhd.sig %false : i1
    %rst_sw_ckbpe_syn_n = llhd.sig %false : i1
    %5 = llhd.prb %rst_sw_ckbpe_syn_n : i1
    %sw_clk_byp_en = llhd.sig %false : i1
    %clk_ext_en = llhd.sig %false : i1
    %rst_aon_n_exda = llhd.sig %false : i1
    %ext_freq_is_96m = llhd.sig %false : i1
    %sys_clk_byp = llhd.sig %false : i1
    %io_clk_byp = llhd.sig %false : i1
    %usb_clk_byp = llhd.sig %false : i1
    %aon_clk_byp = llhd.sig %false : i1
    %extfreq_is_96m = llhd.sig %false : i1
    %sys_clk_byp_sel = llhd.sig %false : i1
    %io_clk_byp_sel = llhd.sig %false : i1
    %usb_clk_byp_sel = llhd.sig %false : i1
    %aon_clk_byp_sel = llhd.sig %false : i1
    %sys_clk_byp_en = llhd.sig %false : i1
    %io_clk_byp_en = llhd.sig %false : i1
    %usb_clk_byp_en = llhd.sig %false : i1
    %aon_clk_byp_en = llhd.sig %false : i1
    %rst_aon_n_ioda = llhd.sig %false : i1
    %all_clks_byp_en_src = llhd.sig %false : i1
    %only_io_clk_byp_en_src = llhd.sig %false : i1
    %io_clk_byp_is_48m_src = llhd.sig %false : i1
    %u_clk_aon_buf.clk_o = hw.instance "u_clk_aon_buf" @prim_clock_buf(clk_i: %u_clk_src_aon_sel.clk_o: i1) -> (clk_o: i1)
    llhd.drv %clk_aon, %u_clk_aon_buf.clk_o after %1 : i1
    %u_no_scan_rst_sw_ckbpe_dasrt.q_o = hw.instance "u_no_scan_rst_sw_ckbpe_dasrt" @prim_flop_2sync(clk_i: %4: i1, rst_ni: %29: i1, d_i: %true: i1) -> (q_o: i1)
    llhd.drv %sw_ckbpe_sync_n, %u_no_scan_rst_sw_ckbpe_dasrt.q_o after %1 : i1
    %u_clk_ext_buf.clk_o = hw.instance "u_clk_ext_buf" @prim_clock_buf(clk_i: %37: i1) -> (clk_o: i1) {sv.namehint = "clk_ext"}
    %u_rst_aon_n_exda_sync.q_o = hw.instance "u_rst_aon_n_exda_sync" @prim_flop_2sync(clk_i: %u_clk_ext_buf.clk_o: i1, rst_ni: %3: i1, d_i: %true: i1) -> (q_o: i1)
    llhd.drv %rst_aon_n_exda, %u_rst_aon_n_exda_sync.q_o after %1 : i1
    %6 = llhd.prb %ext_freq_is_96m : i1
    %u_no_scan_ext_freq_is_96m_sync.q_o = hw.instance "u_no_scan_ext_freq_is_96m_sync" @prim_flop_2sync_0(clk_i: %u_clk_ext_buf.clk_o: i1, rst_ni: %39: i1, d_i: %6: i1) -> (q_o: i1) {sv.namehint = "ext_freq_is_96m_sync"}
    %7 = comb.xor %u_no_scan_ext_freq_is_96m_sync.q_o, %true : i1
    %8 = llhd.prb %scan_mode_i : i1
    %u_no_scan_clk_ext_d1ord2.step_down_ack_o, %u_no_scan_clk_ext_d1ord2.clk_o = hw.instance "u_no_scan_clk_ext_d1ord2" @prim_clock_div(clk_i: %u_clk_ext_buf.clk_o: i1, rst_ni: %39: i1, step_down_req_i: %7: i1, test_en_i: %8: i1) -> (step_down_ack_o: i1, clk_o: i1) {sv.namehint = "clk_src_ext_usb"}
    %u_no_scan_clk_usb_div240_div.step_down_ack_o, %u_no_scan_clk_usb_div240_div.clk_o = hw.instance "u_no_scan_clk_usb_div240_div" @prim_clock_div_1(clk_i: %u_no_scan_clk_ext_d1ord2.clk_o: i1, rst_ni: %39: i1, step_down_req_i: %false: i1, test_en_i: %8: i1) -> (step_down_ack_o: i1, clk_o: i1) {sv.namehint = "clk_ext_aon"}
    %u_deep_sleep_sync.q_o = hw.instance "u_deep_sleep_sync" @prim_flop_2sync(clk_i: %u_clk_ext_buf.clk_o: i1, rst_ni: %39: i1, d_i: %deep_sleep_i: i1) -> (q_o: i1) {sv.namehint = "deep_sleep"}
    %u_no_scan_clk_src_sys_en_sync.q_o = hw.instance "u_no_scan_clk_src_sys_en_sync" @prim_flop_2sync(clk_i: %u_clk_ext_buf.clk_o: i1, rst_ni: %39: i1, d_i: %clk_src_sys_en_i: i1) -> (q_o: i1) {sv.namehint = "clk_src_sys_en"}
    %u_clk_ext_sys_ckgt.clk_o = hw.instance "u_clk_ext_sys_ckgt" @prim_clock_gating(clk_i: %u_clk_ext_buf.clk_o: i1, en_i: %41: i1, test_en_i: %8: i1) -> (clk_o: i1) {sv.namehint = "clk_ext_sys"}
    %u_no_scan_clk_src_io_en_sync.q_o = hw.instance "u_no_scan_clk_src_io_en_sync" @prim_flop_2sync(clk_i: %u_clk_ext_buf.clk_o: i1, rst_ni: %39: i1, d_i: %clk_src_io_en_i: i1) -> (q_o: i1) {sv.namehint = "clk_src_io_en"}
    %u_clk_ext_io_ckgt.clk_o = hw.instance "u_clk_ext_io_ckgt" @prim_clock_gating(clk_i: %u_clk_ext_buf.clk_o: i1, en_i: %42: i1, test_en_i: %8: i1) -> (clk_o: i1) {sv.namehint = "clk_ext_io"}
    %u_no_scan_clk_src_usb_en_sync.q_o = hw.instance "u_no_scan_clk_src_usb_en_sync" @prim_flop_2sync(clk_i: %43: i1, rst_ni: %39: i1, d_i: %clk_src_usb_en_i: i1) -> (q_o: i1) {sv.namehint = "clk_src_usb_en"}
    %u_clk_ext_usb_ckgt.clk_o = hw.instance "u_clk_ext_usb_ckgt" @prim_clock_gating(clk_i: %u_no_scan_clk_ext_d1ord2.clk_o: i1, en_i: %44: i1, test_en_i: %8: i1) -> (clk_o: i1) {sv.namehint = "clk_ext_usb"}
    %u_io_clk_byp_req.mubi_o = hw.instance "u_io_clk_byp_req" @prim_mubi4_sync(clk_i: %2: i1, rst_ni: %3: i1, mubi_i: %io_clk_byp_req_i: i4) -> (mubi_o: !hw.array<1xi4>)
    %9 = hw.bitcast %u_io_clk_byp_req.mubi_o {sv.namehint = "ot_io_clk_byp_req"} : (!hw.array<1xi4>) -> i4
    %u_all_clk_byp_req.mubi_o = hw.instance "u_all_clk_byp_req" @prim_mubi4_sync(clk_i: %2: i1, rst_ni: %3: i1, mubi_i: %all_clk_byp_req_i: i4) -> (mubi_o: !hw.array<1xi4>)
    %10 = hw.bitcast %u_all_clk_byp_req.mubi_o {sv.namehint = "ot_all_clk_byp_req"} : (!hw.array<1xi4>) -> i4
    %u_ext_freq_is_96m.mubi_o = hw.instance "u_ext_freq_is_96m" @prim_mubi4_sync(clk_i: %2: i1, rst_ni: %3: i1, mubi_i: %ext_freq_is_96m_i: i4) -> (mubi_o: !hw.array<1xi4>)
    %11 = hw.bitcast %u_ext_freq_is_96m.mubi_o {sv.namehint = "ot_ext_freq_is_96m"} : (!hw.array<1xi4>) -> i4
    %u_all_byp_sel.mubi_dec_o = hw.instance "u_all_byp_sel" @prim_mubi4_dec(mubi_i: %10: i4) -> (mubi_dec_o: i1) {sv.namehint = "ot_all_clk_byp"}
    %u_sys_byp_sel.mubi_dec_o = hw.instance "u_sys_byp_sel" @prim_mubi4_dec(mubi_i: %10: i4) -> (mubi_dec_o: i1) {sv.namehint = "ot_sys_clk_byp"}
    %u_io_byp_sel.mubi_dec_o = hw.instance "u_io_byp_sel" @prim_mubi4_dec(mubi_i: %9: i4) -> (mubi_dec_o: i1) {sv.namehint = "ot_io_clk_byp"}
    %u_usb_byp_sel.mubi_dec_o = hw.instance "u_usb_byp_sel" @prim_mubi4_dec(mubi_i: %10: i4) -> (mubi_dec_o: i1) {sv.namehint = "ot_usb_clk_byp"}
    %u_aon_byp_sel.mubi_dec_o = hw.instance "u_aon_byp_sel" @prim_mubi4_dec(mubi_i: %10: i4) -> (mubi_dec_o: i1) {sv.namehint = "ot_aon_clk_byp"}
    %u_sw_all_clk_byp_dgl.q_o = hw.instance "u_sw_all_clk_byp_dgl" @prim_flop(clk_i: %2: i1, rst_ni: %3: i1, d_i: %u_all_byp_sel.mubi_dec_o: i1) -> (q_o: i1)
    llhd.drv %sw_all_clk_byp, %u_sw_all_clk_byp_dgl.q_o after %1 : i1
    %u_sw_sys_clk_byp_dgl.q_o = hw.instance "u_sw_sys_clk_byp_dgl" @prim_flop(clk_i: %2: i1, rst_ni: %3: i1, d_i: %u_sys_byp_sel.mubi_dec_o: i1) -> (q_o: i1) {sv.namehint = "sw_sys_clk_byp"}
    %u_sw_io_clk_byp_dgl.q_o = hw.instance "u_sw_io_clk_byp_dgl" @prim_flop(clk_i: %2: i1, rst_ni: %3: i1, d_i: %u_io_byp_sel.mubi_dec_o: i1) -> (q_o: i1)
    llhd.drv %sw_io_clk_byp, %u_sw_io_clk_byp_dgl.q_o after %1 : i1
    %u_sw_usb_clk_byp_dgl.q_o = hw.instance "u_sw_usb_clk_byp_dgl" @prim_flop(clk_i: %2: i1, rst_ni: %3: i1, d_i: %u_usb_byp_sel.mubi_dec_o: i1) -> (q_o: i1) {sv.namehint = "sw_usb_clk_byp"}
    %u_sw_aon_clk_byp_dgl.q_o = hw.instance "u_sw_aon_clk_byp_dgl" @prim_flop(clk_i: %2: i1, rst_ni: %3: i1, d_i: %u_aon_byp_sel.mubi_dec_o: i1) -> (q_o: i1) {sv.namehint = "sw_aon_clk_byp"}
    %12 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%11) : (i4) -> i1
    %u_sw_exfr_is_96m_dgl.q_o = hw.instance "u_sw_exfr_is_96m_dgl" @prim_flop(clk_i: %2: i1, rst_ni: %3: i1, d_i: %12: i1) -> (q_o: i1) {sv.namehint = "sw_exfr_is_96m"}
    %u_io_clk_byp_dgl.q_o = hw.instance "u_io_clk_byp_dgl" @prim_flop(clk_i: %2: i1, rst_ni: %3: i1, d_i: %47: i1) -> (q_o: i1)
    llhd.drv %io_clk_byp, %u_io_clk_byp_dgl.q_o after %1 : i1
    %u_io_clk_byp_sel.out_o = hw.instance "u_io_clk_byp_sel" @prim_buf(in_i: %16: i1) -> (out_o: i1) {sv.namehint = "io_clk_byp_sel_buf"}
    %u_io_clk_osc_en.out_o = hw.instance "u_io_clk_osc_en" @prim_buf(in_i: %u_clk_src_io_sel.clk_osc_en_o: i1) -> (out_o: i1) {sv.namehint = "io_clk_osc_en_buf"}
    %13 = llhd.prb %io_clk_byp_en : i1
    %u_io_clk_byp_en.out_o = hw.instance "u_io_clk_byp_en" @prim_buf(in_i: %13: i1) -> (out_o: i1) {sv.namehint = "io_clk_byp_en_buf"}
    %u_rst_clk_osc_sys.out_o = hw.instance "u_rst_clk_osc_sys" @prim_buf(in_i: %26: i1) -> (out_o: i1) {sv.namehint = "rst_clk_osc_sys_n"}
    %u_rst_clk_ext_sys.out_o = hw.instance "u_rst_clk_ext_sys" @prim_buf(in_i: %vcaon_pok_por_i: i1) -> (out_o: i1) {sv.namehint = "rst_clk_ext_sys_n"}
    %u_rst_clk_osc_io.out_o = hw.instance "u_rst_clk_osc_io" @prim_buf(in_i: %26: i1) -> (out_o: i1) {sv.namehint = "rst_clk_osc_io_n"}
    %u_rst_clk_ext_io.out_o = hw.instance "u_rst_clk_ext_io" @prim_buf(in_i: %vcaon_pok_por_i: i1) -> (out_o: i1) {sv.namehint = "rst_clk_ext_io_n"}
    %u_rst_clk_osc_usb.out_o = hw.instance "u_rst_clk_osc_usb" @prim_buf(in_i: %26: i1) -> (out_o: i1) {sv.namehint = "rst_clk_osc_usb_n"}
    %u_rst_clk_ext_usb.out_o = hw.instance "u_rst_clk_ext_usb" @prim_buf(in_i: %vcaon_pok_por_i: i1) -> (out_o: i1) {sv.namehint = "rst_clk_ext_usb_n"}
    %u_rst_clk_osc_aon.out_o = hw.instance "u_rst_clk_osc_aon" @prim_buf(in_i: %26: i1) -> (out_o: i1) {sv.namehint = "rst_clk_osc_aon_n"}
    %u_rst_clk_ext_aon.out_o = hw.instance "u_rst_clk_ext_aon" @prim_buf(in_i: %26: i1) -> (out_o: i1) {sv.namehint = "rst_clk_ext_aon_n"}
    %u_rst_aon_n_ioda_sync.q_o = hw.instance "u_rst_aon_n_ioda_sync" @prim_flop_2sync(clk_i: %u_clk_src_io_sel.clk_o: i1, rst_ni: %3: i1, d_i: %true: i1) -> (q_o: i1)
    llhd.drv %rst_aon_n_ioda, %u_rst_aon_n_ioda_sync.q_o after %1 : i1
    %14 = llhd.prb %clk_osc_sys_i_0 : i1
    %15 = llhd.prb %sys_clk_byp_sel : i1
    %u_clk_src_sys_sel.clk_osc_en_o, %u_clk_src_sys_sel.clk_ext_en_o, %u_clk_src_sys_sel.clk_val_o, %u_clk_src_sys_sel.clk_o = hw.instance "u_clk_src_sys_sel" @gfr_clk_mux2(clk_osc_i: %14: i1, clk_osc_val_i: %clk_osc_sys_val_i: i1, rst_clk_osc_ni: %u_rst_clk_osc_sys.out_o: i1, clk_ext_i: %u_clk_ext_sys_ckgt.clk_o: i1, clk_ext_val_i: %41: i1, rst_clk_ext_ni: %u_rst_clk_ext_sys.out_o: i1, ext_sel_i: %15: i1) -> (clk_osc_en_o: i1, clk_ext_en_o: i1, clk_val_o: i1, clk_o: i1) {sv.namehint = "sys_clk_osc_en"}
    llhd.drv %sys_clk_byp_en, %u_clk_src_sys_sel.clk_ext_en_o after %1 : i1
    %16 = llhd.prb %io_clk_byp_sel {sv.namehint = "io_clk_byp_select"} : i1
    %u_clk_src_io_sel.clk_osc_en_o, %u_clk_src_io_sel.clk_ext_en_o, %u_clk_src_io_sel.clk_val_o, %u_clk_src_io_sel.clk_o = hw.instance "u_clk_src_io_sel" @gfr_clk_mux2(clk_osc_i: %clk_osc_io_i: i1, clk_osc_val_i: %clk_osc_io_val_i: i1, rst_clk_osc_ni: %u_rst_clk_osc_io.out_o: i1, clk_ext_i: %u_clk_ext_io_ckgt.clk_o: i1, clk_ext_val_i: %42: i1, rst_clk_ext_ni: %u_rst_clk_ext_io.out_o: i1, ext_sel_i: %16: i1) -> (clk_osc_en_o: i1, clk_ext_en_o: i1, clk_val_o: i1, clk_o: i1) {sv.namehint = "clk_src_io"}
    llhd.drv %io_clk_byp_en, %u_clk_src_io_sel.clk_ext_en_o after %1 : i1
    %17 = llhd.prb %usb_clk_byp_sel : i1
    %u_clk_src_usb_sel.clk_osc_en_o, %u_clk_src_usb_sel.clk_ext_en_o, %u_clk_src_usb_sel.clk_val_o, %u_clk_src_usb_sel.clk_o = hw.instance "u_clk_src_usb_sel" @gfr_clk_mux2(clk_osc_i: %clk_osc_usb_i: i1, clk_osc_val_i: %clk_osc_usb_val_i: i1, rst_clk_osc_ni: %u_rst_clk_osc_usb.out_o: i1, clk_ext_i: %u_clk_ext_usb_ckgt.clk_o: i1, clk_ext_val_i: %44: i1, rst_clk_ext_ni: %u_rst_clk_ext_usb.out_o: i1, ext_sel_i: %17: i1) -> (clk_osc_en_o: i1, clk_ext_en_o: i1, clk_val_o: i1, clk_o: i1) {sv.namehint = "usb_clk_osc_en"}
    llhd.drv %usb_clk_byp_en, %u_clk_src_usb_sel.clk_ext_en_o after %1 : i1
    %18 = llhd.prb %aon_clk_byp_sel : i1
    %u_clk_src_aon_sel.clk_osc_en_o, %u_clk_src_aon_sel.clk_ext_en_o, %u_clk_src_aon_sel.clk_val_o, %u_clk_src_aon_sel.clk_o = hw.instance "u_clk_src_aon_sel" @gfr_clk_mux2(clk_osc_i: %clk_osc_aon_i: i1, clk_osc_val_i: %clk_osc_aon_val_i: i1, rst_clk_osc_ni: %u_rst_clk_osc_aon.out_o: i1, clk_ext_i: %u_no_scan_clk_usb_div240_div.clk_o: i1, clk_ext_val_i: %true: i1, rst_clk_ext_ni: %u_rst_clk_ext_aon.out_o: i1, ext_sel_i: %18: i1) -> (clk_osc_en_o: i1, clk_ext_en_o: i1, clk_val_o: i1, clk_o: i1) {sv.namehint = "aon_clk_osc_en"}
    llhd.drv %aon_clk_byp_en, %u_clk_src_aon_sel.clk_ext_en_o after %1 : i1
    %19 = llhd.prb %all_clks_byp_en_src : i1
    %u_all_clks_byp_en_sync.q_o = hw.instance "u_all_clks_byp_en_sync" @prim_flop_2sync(clk_i: %u_clk_src_io_sel.clk_o: i1, rst_ni: %54: i1, d_i: %19: i1) -> (q_o: i1) {sv.namehint = "all_clks_byp_en"}
    %20 = func.call @"prim_mubi_pkg::mubi4_bool_to_mubi"(%u_all_clks_byp_en_sync.q_o) : (i1) -> i4
    %u_all_clk_byp_ack.mubi_o = hw.instance "u_all_clk_byp_ack" @prim_mubi4_sender(clk_i: %u_clk_src_io_sel.clk_o: i1, rst_ni: %54: i1, mubi_i: %20: i4) -> (mubi_o: i4)
    %21 = llhd.prb %only_io_clk_byp_en_src : i1
    %u_only_io_clk_byp_en_sync.q_o = hw.instance "u_only_io_clk_byp_en_sync" @prim_flop_2sync(clk_i: %u_clk_src_io_sel.clk_o: i1, rst_ni: %54: i1, d_i: %21: i1) -> (q_o: i1) {sv.namehint = "only_io_clk_byp_en"}
    %22 = func.call @"prim_mubi_pkg::mubi4_bool_to_mubi"(%u_only_io_clk_byp_en_sync.q_o) : (i1) -> i4
    %u_io_clk_byp_ack.mubi_o = hw.instance "u_io_clk_byp_ack" @prim_mubi4_sender(clk_i: %u_clk_src_io_sel.clk_o: i1, rst_ni: %54: i1, mubi_i: %22: i4) -> (mubi_o: i4)
    %23 = llhd.prb %io_clk_byp_is_48m_src : i1
    %u_io_clk_byp_is_48m_sync.q_o = hw.instance "u_io_clk_byp_is_48m_sync" @prim_flop_2sync(clk_i: %u_clk_src_io_sel.clk_o: i1, rst_ni: %54: i1, d_i: %23: i1) -> (q_o: i1) {sv.namehint = "io_clk_byp_is_48m"}
    %24 = func.call @"prim_mubi_pkg::mubi4_bool_to_mubi"(%u_io_clk_byp_is_48m_sync.q_o) : (i1) -> i4
    %u_clk_src_io_48m_sync.mubi_o = hw.instance "u_clk_src_io_48m_sync" @prim_mubi4_sender(clk_i: %u_clk_src_io_sel.clk_o: i1, rst_ni: %54: i1, mubi_i: %24: i4) -> (mubi_o: i4)
    llhd.drv %scan_mode_i, %false after %1 : i1
    llhd.drv %scan_reset_ni, %true after %1 : i1
    llhd.drv %vcaon_pok, %vcaon_pok_i after %1 : i1
    %25 = llhd.prb %scan_reset_ni : i1
    %26 = llhd.prb %vcaon_pok {sv.namehint = "rst_clk_osc_n"} : i1
    %27 = comb.mux %8, %25, %26 : i1
    llhd.drv %rst_aon_n, %27 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %55 = llhd.prb %clk_aon : i1
      %56 = llhd.prb %rst_aon_n : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %57 = llhd.prb %clk_aon : i1
      %58 = comb.xor bin %55, %true : i1
      %59 = comb.and bin %58, %57 : i1
      %60 = llhd.prb %rst_aon_n : i1
      %61 = comb.xor bin %60, %true : i1
      %62 = comb.and bin %56, %61 : i1
      %63 = comb.or bin %59, %62 : i1
      cf.cond_br %63, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %64 = llhd.prb %rst_aon_n : i1
      %65 = comb.xor %64, %true : i1
      cf.cond_br %65, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %rst_sw_clk_byp_en, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %66 = llhd.prb %sw_all_clk_byp : i1
      %67 = llhd.prb %sw_io_clk_byp : i1
      %68 = comb.or %66, %67 : i1
      cf.cond_br %68, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %rst_sw_clk_byp_en, %true after %0 : i1
      cf.br ^bb1
    }
    %28 = llhd.prb %rst_sw_clk_byp_en : i1
    %29 = comb.mux %8, %25, %28 {sv.namehint = "rst_sw_ckbpe_n"} : i1
    %30 = llhd.prb %clk_ast_ext_i_1 : i1
    %31 = comb.mux %8, %14, %30 : i1
    llhd.drv %clk_ast_ext_scn, %31 after %1 : i1
    %32 = llhd.prb %sw_ckbpe_sync_n : i1
    %33 = comb.mux %8, %25, %32 : i1
    llhd.drv %rst_sw_ckbpe_syn_n, %33 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %55 = llhd.prb %clk_ast_ext_scn : i1
      %56 = llhd.prb %rst_sw_ckbpe_syn_n : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %57 = llhd.prb %clk_ast_ext_scn : i1
      %58 = comb.xor bin %57, %true : i1
      %59 = comb.and bin %55, %58 : i1
      %60 = llhd.prb %rst_sw_ckbpe_syn_n : i1
      %61 = comb.xor bin %60, %true : i1
      %62 = comb.and bin %56, %61 : i1
      %63 = comb.or bin %59, %62 : i1
      cf.cond_br %63, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %64 = llhd.prb %rst_sw_ckbpe_syn_n : i1
      %65 = comb.xor %64, %true : i1
      cf.cond_br %65, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %sw_clk_byp_en, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      llhd.drv %sw_clk_byp_en, %true after %0 : i1
      cf.br ^bb1
    }
    %34 = llhd.prb %sw_clk_byp_en : i1
    llhd.drv %clk_ext_en, %34 after %1 : i1
    %35 = llhd.prb %clk_ext_en : i1
    %36 = comb.and %30, %35 : i1
    %37 = comb.mux %8, %14, %36 {sv.namehint = "clk_ext_scn"} : i1
    %38 = llhd.prb %rst_aon_n_exda : i1
    %39 = comb.mux %8, %25, %38 {sv.namehint = "rst_aon_exda_n"} : i1
    %40 = comb.xor %u_deep_sleep_sync.q_o, %true {sv.namehint = "deep_sleep_n"} : i1
    %41 = comb.and %40, %u_no_scan_clk_src_sys_en_sync.q_o {sv.namehint = "clk_ext_sys_en"} : i1
    %42 = comb.and %40, %u_no_scan_clk_src_io_en_sync.q_o {sv.namehint = "clk_ext_io_en"} : i1
    %43 = comb.xor %u_no_scan_clk_ext_d1ord2.clk_o, %true {sv.namehint = "clk_src_ext_usb_n"} : i1
    %44 = comb.and %40, %u_no_scan_clk_src_usb_en_sync.q_o {sv.namehint = "clk_ext_usb_en"} : i1
    llhd.drv %sys_clk_byp, %u_sw_sys_clk_byp_dgl.q_o after %1 : i1
    %45 = llhd.prb %sw_io_clk_byp : i1
    %46 = llhd.prb %sw_all_clk_byp : i1
    %47 = comb.or %45, %46 {sv.namehint = "sel_io_clk_byp"} : i1
    llhd.drv %usb_clk_byp, %u_sw_usb_clk_byp_dgl.q_o after %1 : i1
    llhd.drv %aon_clk_byp, %u_sw_aon_clk_byp_dgl.q_o after %1 : i1
    llhd.drv %extfreq_is_96m, %u_sw_exfr_is_96m_dgl.q_o after %1 : i1
    %48 = llhd.prb %sys_clk_byp : i1
    %49 = llhd.prb %io_clk_byp : i1
    %50 = llhd.prb %usb_clk_byp : i1
    %51 = llhd.prb %aon_clk_byp : i1
    %52 = llhd.prb %extfreq_is_96m : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb3
      %55 = llhd.prb %scan_mode_i : i1
      %56 = comb.xor %55, %true : i1
      cf.cond_br %56, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %57 = llhd.prb %sys_clk_byp : i1
      llhd.drv %sys_clk_byp_sel, %57 after %1 : i1
      %58 = llhd.prb %io_clk_byp : i1
      llhd.drv %io_clk_byp_sel, %58 after %1 : i1
      %59 = llhd.prb %usb_clk_byp : i1
      llhd.drv %usb_clk_byp_sel, %59 after %1 : i1
      %60 = llhd.prb %aon_clk_byp : i1
      llhd.drv %aon_clk_byp_sel, %60 after %1 : i1
      %61 = llhd.prb %extfreq_is_96m : i1
      llhd.drv %ext_freq_is_96m, %61 after %1 : i1
      cf.br ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      llhd.wait (%8, %48, %15, %49, %16, %50, %17, %51, %18, %52, %6 : i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    %53 = llhd.prb %rst_aon_n_ioda : i1
    %54 = comb.mux %8, %25, %53 {sv.namehint = "rst_aon_ioda_n"} : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %55 = llhd.prb %clk_aon : i1
      %56 = llhd.prb %rst_aon_n : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %57 = llhd.prb %clk_aon : i1
      %58 = comb.xor bin %55, %true : i1
      %59 = comb.and bin %58, %57 : i1
      %60 = llhd.prb %rst_aon_n : i1
      %61 = comb.xor bin %60, %true : i1
      %62 = comb.and bin %56, %61 : i1
      %63 = comb.or bin %59, %62 : i1
      cf.cond_br %63, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %64 = llhd.prb %rst_aon_n : i1
      %65 = comb.xor %64, %true : i1
      cf.cond_br %65, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %all_clks_byp_en_src, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %66 = llhd.prb %sw_all_clk_byp : i1
      %67 = llhd.prb %sys_clk_byp_en : i1
      %68 = llhd.prb %io_clk_byp_en : i1
      %69 = llhd.prb %usb_clk_byp_en : i1
      %70 = llhd.prb %aon_clk_byp_en : i1
      %71 = comb.and %66, %67, %68, %69, %70 : i1
      llhd.drv %all_clks_byp_en_src, %71 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %55 = llhd.prb %clk_aon : i1
      %56 = llhd.prb %rst_aon_n : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %57 = llhd.prb %clk_aon : i1
      %58 = comb.xor bin %55, %true : i1
      %59 = comb.and bin %58, %57 : i1
      %60 = llhd.prb %rst_aon_n : i1
      %61 = comb.xor bin %60, %true : i1
      %62 = comb.and bin %56, %61 : i1
      %63 = comb.or bin %59, %62 : i1
      cf.cond_br %63, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %64 = llhd.prb %rst_aon_n : i1
      %65 = comb.xor %64, %true : i1
      cf.cond_br %65, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %only_io_clk_byp_en_src, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %66 = llhd.prb %sw_io_clk_byp : i1
      %67 = llhd.prb %io_clk_byp_en : i1
      %68 = comb.and %66, %67 : i1
      llhd.drv %only_io_clk_byp_en_src, %68 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %55 = llhd.prb %clk_aon : i1
      %56 = llhd.prb %rst_aon_n : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %57 = llhd.prb %clk_aon : i1
      %58 = comb.xor bin %55, %true : i1
      %59 = comb.and bin %58, %57 : i1
      %60 = llhd.prb %rst_aon_n : i1
      %61 = comb.xor bin %60, %true : i1
      %62 = comb.and bin %56, %61 : i1
      %63 = comb.or bin %59, %62 : i1
      cf.cond_br %63, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %64 = llhd.prb %rst_aon_n : i1
      %65 = comb.xor %64, %true : i1
      cf.cond_br %65, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %io_clk_byp_is_48m_src, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %66 = llhd.prb %io_clk_byp_en : i1
      %67 = llhd.prb %ext_freq_is_96m : i1
      %68 = comb.xor %67, %true : i1
      %69 = comb.and %66, %68 : i1
      llhd.drv %io_clk_byp_is_48m_src, %69 after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_osc_sys_i_0, %clk_osc_sys_i after %1 : i1
    llhd.drv %clk_ast_ext_i_1, %clk_ast_ext_i after %1 : i1
    hw.output %u_io_clk_byp_ack.mubi_o, %u_all_clk_byp_ack.mubi_o, %u_clk_src_sys_sel.clk_o, %u_clk_src_sys_sel.clk_val_o, %u_clk_src_io_sel.clk_o, %u_clk_src_io_sel.clk_val_o, %u_clk_src_io_48m_sync.mubi_o, %u_clk_src_usb_sel.clk_o, %u_clk_src_usb_sel.clk_val_o, %u_clk_src_aon_sel.clk_o, %u_clk_src_aon_sel.clk_val_o : i4, i4, i1, i1, i1, i1, i4, i1, i1, i1, i1
  }
  hw.module private @ast_dft(out obs_ctrl_o : !hw.struct<obgsl: i4, obmsl: i4, obmen: i4>, out ast2padmux_o : i9, out dpram_rmf_o : !hw.struct<test_a: i1, marg_en_a: i1, marg_a: i4, test_b: i1, marg_en_b: i1, marg_b: i4>, out dpram_rml_o : !hw.struct<test_a: i1, marg_en_a: i1, marg_a: i4, test_b: i1, marg_en_b: i1, marg_b: i4>, out spram_rm_o : !hw.struct<test: i1, marg_en: i1, marg: i4>, out sprgf_rm_o : !hw.struct<test: i1, marg_en: i1, marg: i4>, out sprom_rm_o : !hw.struct<test: i1, marg_en: i1, marg: i4>) {
    %c0_i9 = hw.constant 0 : i9
    %0 = hw.aggregate_constant [0 : i4, 0 : i4, -7 : i4] : !hw.struct<obgsl: i4, obmsl: i4, obmen: i4>
    %1 = hw.aggregate_constant [false, false, 0 : i4, false, false, 0 : i4] : !hw.struct<test_a: i1, marg_en_a: i1, marg_a: i4, test_b: i1, marg_en_b: i1, marg_b: i4>
    %2 = hw.aggregate_constant [false, false, 0 : i4] : !hw.struct<test: i1, marg_en: i1, marg: i4>
    hw.output %0, %c0_i9, %1, %1, %2, %2, %2 : !hw.struct<obgsl: i4, obmsl: i4, obmen: i4>, i9, !hw.struct<test_a: i1, marg_en_a: i1, marg_a: i4, test_b: i1, marg_en_b: i1, marg_b: i4>, !hw.struct<test_a: i1, marg_en_a: i1, marg_a: i4, test_b: i1, marg_en_b: i1, marg_b: i4>, !hw.struct<test: i1, marg_en: i1, marg: i4>, !hw.struct<test: i1, marg_en: i1, marg: i4>, !hw.struct<test: i1, marg_en: i1, marg: i4>
  }
  hw.module private @ast_entropy(in %entropy_rsp_i : !hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>, in %entropy_rate_i : i4, in %clk_ast_es_i : i1, in %rst_ast_es_ni : i1, in %clk_src_sys_i : i1, in %rst_src_sys_ni : i1, in %clk_src_sys_val_i : i1, in %clk_src_sys_jen_i : i1, out entropy_req_o : !hw.struct<edn_req: i1>) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [false] : !hw.struct<edn_req: i1>
    %c-1_i2 = hw.constant -1 : i2
    %c1_i2 = hw.constant 1 : i2
    %true = hw.constant true
    %c0_i2 = hw.constant 0 : i2
    %false = hw.constant false
    %clk_ast_es_i_0 = llhd.sig name "clk_ast_es_i" %false : i1
    %3 = llhd.prb %clk_ast_es_i_0 : i1
    %rst_ast_es_ni_1 = llhd.sig name "rst_ast_es_ni" %false : i1
    %4 = llhd.prb %rst_ast_es_ni_1 : i1
    %entropy_req_o = llhd.sig %2 : !hw.struct<edn_req: i1>
    %erq_sm = llhd.sig %c0_i2 : i2
    %dev0_wready = llhd.sig %false : i1
    %edn_ack = llhd.sig %false : i1
    %edn_req = llhd.sig %false : i1
    %u_dev0_entropy.dev_wready_o, %u_dev0_entropy.dev_data_o = hw.instance "u_dev0_entropy" @dev_entropy(clk_i: %3: i1, rst_ni: %4: i1, clk_dev_i: %clk_src_sys_i: i1, rst_dev_ni: %rst_src_sys_ni: i1, dev_en_i: %13: i1, dev_rate_i: %entropy_rate_i: i4, dev_ack_i: %12: i1, dev_data_i: %edn_bus: i32) -> (dev_wready_o: i1, dev_data_o: i1) {sv.namehint = "dev0_entropy"}
    llhd.drv %dev0_wready, %u_dev0_entropy.dev_wready_o after %1 : i1
    %5 = llhd.sig.struct_extract %entropy_req_o["edn_req"] : <!hw.struct<edn_req: i1>>
    %6 = llhd.prb %edn_req : i1
    llhd.drv %5, %6 after %1 : i1
    %edn_ack_2 = hw.struct_extract %entropy_rsp_i["edn_ack"] : !hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>
    llhd.drv %edn_ack, %edn_ack_2 after %1 : i1
    %edn_bus = hw.struct_extract %entropy_rsp_i["edn_bus"] {sv.namehint = "edn_bus"} : !hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 10 preds: ^bb0, ^bb2, ^bb4, ^bb7, ^bb8, ^bb11, ^bb12, ^bb15, ^bb16, ^bb17
      %15 = llhd.prb %clk_ast_es_i_0 : i1
      %16 = llhd.prb %rst_ast_es_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %17 = llhd.prb %clk_ast_es_i_0 : i1
      %18 = comb.xor bin %15, %true : i1
      %19 = comb.and bin %18, %17 : i1
      %20 = llhd.prb %rst_ast_es_ni_1 : i1
      %21 = comb.xor bin %20, %true : i1
      %22 = comb.and bin %16, %21 : i1
      %23 = comb.or bin %19, %22 : i1
      cf.cond_br %23, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %24 = llhd.prb %rst_ast_es_ni_1 : i1
      %25 = comb.xor %24, %true : i1
      cf.cond_br %25, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %edn_req, %false after %0 : i1
      llhd.drv %erq_sm, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %26 = llhd.prb %erq_sm : i2
      %27 = comb.icmp ceq %26, %c0_i2 : i2
      cf.cond_br %27, ^bb6, ^bb9
    ^bb6:  // pred: ^bb5
      %28 = llhd.prb %dev0_wready : i1
      cf.cond_br %28, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      llhd.drv %edn_req, %true after %0 : i1
      llhd.drv %erq_sm, %c1_i2 after %0 : i2
      cf.br ^bb1
    ^bb8:  // pred: ^bb6
      llhd.drv %edn_req, %false after %0 : i1
      llhd.drv %erq_sm, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb9:  // pred: ^bb5
      %29 = comb.icmp ceq %26, %c1_i2 : i2
      cf.cond_br %29, ^bb10, ^bb13
    ^bb10:  // pred: ^bb9
      %30 = llhd.prb %edn_ack : i1
      cf.cond_br %30, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      llhd.drv %edn_req, %false after %0 : i1
      llhd.drv %erq_sm, %c-1_i2 after %0 : i2
      cf.br ^bb1
    ^bb12:  // pred: ^bb10
      llhd.drv %edn_req, %true after %0 : i1
      llhd.drv %erq_sm, %c1_i2 after %0 : i2
      cf.br ^bb1
    ^bb13:  // pred: ^bb9
      %31 = comb.icmp ceq %26, %c-1_i2 : i2
      cf.cond_br %31, ^bb14, ^bb17
    ^bb14:  // pred: ^bb13
      %32 = llhd.prb %dev0_wready : i1
      cf.cond_br %32, ^bb15, ^bb16
    ^bb15:  // pred: ^bb14
      llhd.drv %edn_req, %true after %0 : i1
      llhd.drv %erq_sm, %c1_i2 after %0 : i2
      cf.br ^bb1
    ^bb16:  // pred: ^bb14
      llhd.drv %edn_req, %false after %0 : i1
      llhd.drv %erq_sm, %c-1_i2 after %0 : i2
      cf.br ^bb1
    ^bb17:  // pred: ^bb13
      llhd.drv %edn_req, %false after %0 : i1
      llhd.drv %erq_sm, %c0_i2 after %0 : i2
      cf.br ^bb1
    }
    %7 = llhd.prb %edn_ack : i1
    %8 = llhd.prb %erq_sm : i2
    %9 = comb.icmp eq %8, %c1_i2 : i2
    %10 = comb.icmp eq %8, %c-1_i2 : i2
    %11 = comb.or %9, %10 : i1
    %12 = comb.and %7, %11 {sv.namehint = "dev0_ack"} : i1
    %13 = comb.and %clk_src_sys_val_i, %clk_src_sys_jen_i {sv.namehint = "dev0_en"} : i1
    llhd.drv %clk_ast_es_i_0, %clk_ast_es_i after %1 : i1
    llhd.drv %rst_ast_es_ni_1, %rst_ast_es_ni after %1 : i1
    %14 = llhd.prb %entropy_req_o : !hw.struct<edn_req: i1>
    hw.output %14 : !hw.struct<edn_req: i1>
  }
  hw.module private @ast_pulse_sync(in %scan_mode_i : i1, in %clk_src_i : i1, in %rst_src_ni : i1, in %src_pulse_i : i1, out src_pulse_en_o : i1, out src_busy_o : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, out dst_pulse_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %true = hw.constant true
    %clk_src_i_0 = llhd.sig name "clk_src_i" %false : i1
    %2 = llhd.prb %clk_src_i_0 : i1
    %rst_src_ni_1 = llhd.sig name "rst_src_ni" %false : i1
    %src_pulse_i_2 = llhd.sig name "src_pulse_i" %false : i1
    %src_pulse_en_o = llhd.sig %false : i1
    %clk_dst_i_3 = llhd.sig name "clk_dst_i" %false : i1
    %3 = llhd.prb %clk_dst_i_3 : i1
    %rst_dst_ni_4 = llhd.sig name "rst_dst_ni" %false : i1
    %rst_src_n = llhd.sig %false : i1
    %4 = llhd.prb %rst_src_n : i1
    %rst_dst_da_n = llhd.sig %false : i1
    %rst_dst_n = llhd.sig %false : i1
    %5 = llhd.prb %rst_dst_n : i1
    %rst_src_da_n = llhd.sig %false : i1
    %src_pulse_d = llhd.sig %false : i1
    %src_req = llhd.sig %false : i1
    %dst_req = llhd.sig %false : i1
    %dst_req_d = llhd.sig %false : i1
    %6 = llhd.prb %rst_dst_ni_4 : i1
    %u_rst_dst_da.q_o = hw.instance "u_rst_dst_da" @prim_flop_2sync(clk_i: %2: i1, rst_ni: %6: i1, d_i: %true: i1) -> (q_o: i1)
    llhd.drv %rst_dst_da_n, %u_rst_dst_da.q_o after %1 : i1
    %7 = llhd.prb %rst_src_ni_1 : i1
    %u_rst_src_da.q_o = hw.instance "u_rst_src_da" @prim_flop_2sync(clk_i: %3: i1, rst_ni: %7: i1, d_i: %true: i1) -> (q_o: i1)
    llhd.drv %rst_src_da_n, %u_rst_src_da.q_o after %1 : i1
    %8 = llhd.prb %src_req : i1
    %u_dst_req.q_o = hw.instance "u_dst_req" @prim_flop_2sync(clk_i: %3: i1, rst_ni: %5: i1, d_i: %8: i1) -> (q_o: i1)
    llhd.drv %dst_req, %u_dst_req.q_o after %1 : i1
    %9 = llhd.prb %dst_req : i1
    %u_sync2_ack.q_o = hw.instance "u_sync2_ack" @prim_flop_2sync(clk_i: %2: i1, rst_ni: %4: i1, d_i: %9: i1) -> (q_o: i1) {sv.namehint = "src_ack"}
    %10 = llhd.prb %rst_dst_da_n : i1
    %11 = comb.or %scan_mode_i, %10 : i1
    %12 = comb.and %11, %7 : i1
    llhd.drv %rst_src_n, %12 after %1 : i1
    %13 = llhd.prb %rst_src_da_n : i1
    %14 = comb.or %scan_mode_i, %13 : i1
    %15 = comb.and %14, %6 : i1
    llhd.drv %rst_dst_n, %15 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %25 = llhd.prb %clk_src_i_0 : i1
      %26 = llhd.prb %rst_src_n : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %27 = llhd.prb %clk_src_i_0 : i1
      %28 = comb.xor bin %25, %true : i1
      %29 = comb.and bin %28, %27 : i1
      %30 = llhd.prb %rst_src_n : i1
      %31 = comb.xor bin %30, %true : i1
      %32 = comb.and bin %26, %31 : i1
      %33 = comb.or bin %29, %32 : i1
      cf.cond_br %33, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %34 = llhd.prb %rst_src_n : i1
      %35 = comb.xor %34, %true : i1
      cf.cond_br %35, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %src_pulse_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %36 = llhd.prb %src_pulse_i_2 : i1
      llhd.drv %src_pulse_d, %36 after %0 : i1
      cf.br ^bb1
    }
    %16 = llhd.prb %src_pulse_i_2 : i1
    %17 = llhd.prb %src_pulse_d : i1
    %18 = comb.xor %17, %true : i1
    %19 = comb.xor %21, %true : i1
    %20 = comb.and %16, %18, %19 : i1
    llhd.drv %src_pulse_en_o, %20 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %25 = llhd.prb %clk_src_i_0 : i1
      %26 = llhd.prb %rst_src_n : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %27 = llhd.prb %clk_src_i_0 : i1
      %28 = comb.xor bin %25, %true : i1
      %29 = comb.and bin %28, %27 : i1
      %30 = llhd.prb %rst_src_n : i1
      %31 = comb.xor bin %30, %true : i1
      %32 = comb.and bin %26, %31 : i1
      %33 = comb.or bin %29, %32 : i1
      cf.cond_br %33, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %34 = llhd.prb %rst_src_n : i1
      %35 = comb.xor %34, %true : i1
      cf.cond_br %35, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %src_req, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %36 = llhd.prb %src_pulse_en_o : i1
      %37 = llhd.prb %src_req : i1
      %38 = comb.xor %36, %37 : i1
      llhd.drv %src_req, %38 after %0 : i1
      cf.br ^bb1
    }
    %21 = comb.xor %8, %u_sync2_ack.q_o : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %25 = llhd.prb %clk_dst_i_3 : i1
      %26 = llhd.prb %rst_dst_n : i1
      llhd.wait (%3, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %27 = llhd.prb %clk_dst_i_3 : i1
      %28 = comb.xor bin %25, %true : i1
      %29 = comb.and bin %28, %27 : i1
      %30 = llhd.prb %rst_dst_n : i1
      %31 = comb.xor bin %30, %true : i1
      %32 = comb.and bin %26, %31 : i1
      %33 = comb.or bin %29, %32 : i1
      cf.cond_br %33, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %34 = llhd.prb %rst_dst_n : i1
      %35 = comb.xor %34, %true : i1
      cf.cond_br %35, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %dst_req_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %36 = llhd.prb %dst_req : i1
      llhd.drv %dst_req_d, %36 after %0 : i1
      cf.br ^bb1
    }
    %22 = llhd.prb %dst_req_d : i1
    %23 = comb.xor %9, %22 : i1
    llhd.drv %clk_src_i_0, %clk_src_i after %1 : i1
    llhd.drv %rst_src_ni_1, %rst_src_ni after %1 : i1
    llhd.drv %src_pulse_i_2, %src_pulse_i after %1 : i1
    %24 = llhd.prb %src_pulse_en_o : i1
    llhd.drv %clk_dst_i_3, %clk_dst_i after %1 : i1
    llhd.drv %rst_dst_ni_4, %rst_dst_ni after %1 : i1
    hw.output %24, %21, %23 : i1, i1, i1
  }
  hw.module private @ast_reg_top(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out reg2hw : !hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>, in %hw2reg : !hw.struct<regal: !hw.struct<d: i32>>, out intg_err_o : i1) {
    %c-1_i4 = hw.constant -1 : i4
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
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-4_i3 = hw.constant -4 : i3
    %c3_i3 = hw.constant 3 : i3
    %c2_i3 = hw.constant 2 : i3
    %c1_i3 = hw.constant 1 : i3
    %c0_i3 = hw.constant 0 : i3
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i44 = hw.constant 0 : i44
    %c0_i4 = hw.constant 0 : i4
    %2 = hw.aggregate_constant [[0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32, false], [[0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32]]] : !hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>
    %c-1_i32 = hw.constant -1 : i32
    %c-496_i10 = hw.constant -496 : i10
    %c-500_i10 = hw.constant -500 : i10
    %c-504_i10 = hw.constant -504 : i10
    %c-508_i10 = hw.constant -508 : i10
    %c-512_i10 = hw.constant -512 : i10
    %c152_i10 = hw.constant 152 : i10
    %c148_i10 = hw.constant 148 : i10
    %c144_i10 = hw.constant 144 : i10
    %c140_i10 = hw.constant 140 : i10
    %c136_i10 = hw.constant 136 : i10
    %c132_i10 = hw.constant 132 : i10
    %c128_i10 = hw.constant 128 : i10
    %c124_i10 = hw.constant 124 : i10
    %c120_i10 = hw.constant 120 : i10
    %c116_i10 = hw.constant 116 : i10
    %c112_i10 = hw.constant 112 : i10
    %c108_i10 = hw.constant 108 : i10
    %c104_i10 = hw.constant 104 : i10
    %c100_i10 = hw.constant 100 : i10
    %c96_i10 = hw.constant 96 : i10
    %c92_i10 = hw.constant 92 : i10
    %c88_i10 = hw.constant 88 : i10
    %c84_i10 = hw.constant 84 : i10
    %c80_i10 = hw.constant 80 : i10
    %c76_i10 = hw.constant 76 : i10
    %c72_i10 = hw.constant 72 : i10
    %c68_i10 = hw.constant 68 : i10
    %c64_i10 = hw.constant 64 : i10
    %c60_i10 = hw.constant 60 : i10
    %c56_i10 = hw.constant 56 : i10
    %c52_i10 = hw.constant 52 : i10
    %c48_i10 = hw.constant 48 : i10
    %c44_i10 = hw.constant 44 : i10
    %c40_i10 = hw.constant 40 : i10
    %c36_i10 = hw.constant 36 : i10
    %c32_i10 = hw.constant 32 : i10
    %c28_i10 = hw.constant 28 : i10
    %c24_i10 = hw.constant 24 : i10
    %c20_i10 = hw.constant 20 : i10
    %c16_i10 = hw.constant 16 : i10
    %c12_i10 = hw.constant 12 : i10
    %c8_i10 = hw.constant 8 : i10
    %c4_i10 = hw.constant 4 : i10
    %c0_i10 = hw.constant 0 : i10
    %true = hw.constant true
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false {sv.namehint = "shadow_busy"}
    %c-7_i4 = hw.constant -7 : i4
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %reg2hw = llhd.sig %2 : !hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>
    %reg_we = llhd.sig %false : i1
    %reg_addr = llhd.sig %c0_i10 : i10
    %reg_be = llhd.sig %c0_i4 : i4
    %wr_err = llhd.sig %false : i1
    %reg_rdata_next = llhd.sig %c0_i32 : i32
    %intg_err = llhd.sig %false : i1
    %reg_we_err = llhd.sig %false : i1
    %reg_we_check = llhd.sig %c0_i44 : i44
    %err_q = llhd.sig %false : i1
    %rega0_qs = llhd.sig %c0_i32 : i32
    %rega1_qs = llhd.sig %c0_i32 : i32
    %rega2_we = llhd.sig %false : i1
    %rega2_qs = llhd.sig %c0_i32 : i32
    %rega3_we = llhd.sig %false : i1
    %rega3_qs = llhd.sig %c0_i32 : i32
    %rega4_we = llhd.sig %false : i1
    %rega4_qs = llhd.sig %c0_i32 : i32
    %rega5_we = llhd.sig %false : i1
    %rega5_qs = llhd.sig %c0_i32 : i32
    %rega6_we = llhd.sig %false : i1
    %rega6_qs = llhd.sig %c0_i32 : i32
    %rega7_we = llhd.sig %false : i1
    %rega7_qs = llhd.sig %c0_i32 : i32
    %rega8_we = llhd.sig %false : i1
    %rega8_qs = llhd.sig %c0_i32 : i32
    %rega9_we = llhd.sig %false : i1
    %rega9_qs = llhd.sig %c0_i32 : i32
    %rega10_we = llhd.sig %false : i1
    %rega10_qs = llhd.sig %c0_i32 : i32
    %rega11_we = llhd.sig %false : i1
    %rega11_qs = llhd.sig %c0_i32 : i32
    %rega12_we = llhd.sig %false : i1
    %rega12_qs = llhd.sig %c0_i32 : i32
    %rega13_we = llhd.sig %false : i1
    %rega13_qs = llhd.sig %c0_i32 : i32
    %rega14_we = llhd.sig %false : i1
    %rega14_qs = llhd.sig %c0_i32 : i32
    %rega15_we = llhd.sig %false : i1
    %rega15_qs = llhd.sig %c0_i32 : i32
    %rega16_we = llhd.sig %false : i1
    %rega16_qs = llhd.sig %c0_i32 : i32
    %rega17_we = llhd.sig %false : i1
    %rega17_qs = llhd.sig %c0_i32 : i32
    %rega18_we = llhd.sig %false : i1
    %rega18_qs = llhd.sig %c0_i32 : i32
    %rega19_we = llhd.sig %false : i1
    %rega19_qs = llhd.sig %c0_i32 : i32
    %rega20_we = llhd.sig %false : i1
    %rega20_qs = llhd.sig %c0_i32 : i32
    %rega21_we = llhd.sig %false : i1
    %rega21_qs = llhd.sig %c0_i32 : i32
    %rega22_we = llhd.sig %false : i1
    %rega22_qs = llhd.sig %c0_i32 : i32
    %rega23_we = llhd.sig %false : i1
    %rega23_qs = llhd.sig %c0_i32 : i32
    %rega24_we = llhd.sig %false : i1
    %rega24_qs = llhd.sig %c0_i32 : i32
    %rega25_we = llhd.sig %false : i1
    %rega25_qs = llhd.sig %c0_i32 : i32
    %rega26_we = llhd.sig %false : i1
    %rega26_qs = llhd.sig %c0_i32 : i32
    %rega27_we = llhd.sig %false : i1
    %rega27_qs = llhd.sig %c0_i32 : i32
    %rega28_qs = llhd.sig %c0_i32 : i32
    %rega29_we = llhd.sig %false : i1
    %rega29_qs = llhd.sig %c0_i32 : i32
    %rega30_we = llhd.sig %false : i1
    %rega30_qs = llhd.sig %c0_i32 : i32
    %rega31_we = llhd.sig %false : i1
    %rega31_qs = llhd.sig %c0_i32 : i32
    %rega32_we = llhd.sig %false : i1
    %rega32_qs = llhd.sig %c0_i32 : i32
    %rega33_we = llhd.sig %false : i1
    %rega33_qs = llhd.sig %c0_i32 : i32
    %rega34_we = llhd.sig %false : i1
    %rega34_qs = llhd.sig %c0_i32 : i32
    %rega35_we = llhd.sig %false : i1
    %rega35_qs = llhd.sig %c0_i32 : i32
    %rega36_we = llhd.sig %false : i1
    %rega36_qs = llhd.sig %c0_i32 : i32
    %rega37_we = llhd.sig %false : i1
    %rega37_qs = llhd.sig %c0_i32 : i32
    %regal_we = llhd.sig %false : i1
    %regb_0_we = llhd.sig %false : i1
    %regb_0_qs = llhd.sig %c0_i32 : i32
    %regb_1_we = llhd.sig %false : i1
    %regb_1_qs = llhd.sig %c0_i32 : i32
    %regb_2_we = llhd.sig %false : i1
    %regb_2_qs = llhd.sig %c0_i32 : i32
    %regb_3_we = llhd.sig %false : i1
    %regb_3_qs = llhd.sig %c0_i32 : i32
    %regb_4_we = llhd.sig %false : i1
    %regb_4_qs = llhd.sig %c0_i32 : i32
    %regal_flds_we = llhd.sig %false : i1
    %addr_hit = llhd.sig %c0_i44 : i44
    %u_chk.err_o = hw.instance "u_chk" @tlul_cmd_intg_chk(tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> (err_o: i1)
    llhd.drv %intg_err, %u_chk.err_o after %1 : i1
    %5 = llhd.prb %reg_we_check : i44
    %6 = llhd.prb %reg_we : i1
    %7 = comb.xor %152, %true : i1
    %8 = comb.and %6, %7 : i1
    %u_prim_reg_we_check.err_o = hw.instance "u_prim_reg_we_check" @prim_reg_we_check(clk_i: %3: i1, rst_ni: %4: i1, oh_i: %5: i44, en_i: %8: i1) -> (err_o: i1)
    llhd.drv %reg_we_err, %u_prim_reg_we_check.err_o after %1 : i1
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen(tl_i: %u_reg_if.tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
    %u_reg_if.tl_o, %u_reg_if.intg_error_o, %u_reg_if.re_o, %u_reg_if.we_o, %u_reg_if.addr_o, %u_reg_if.wdata_o, %u_reg_if.be_o = hw.instance "u_reg_if" @tlul_adapter_reg(clk_i: %3: i1, rst_ni: %4: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, en_ifetch_i: %c-7_i4: i4, busy_i: %false: i1, rdata_i: %143: i32, error_i: %145: i1) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, intg_error_o: i1, re_o: i1, we_o: i1, addr_o: i10, wdata_o: i32, be_o: i4) {sv.namehint = "reg_re"}
    llhd.drv %reg_we, %u_reg_if.we_o after %1 : i1
    llhd.drv %reg_addr, %u_reg_if.addr_o after %1 : i10
    llhd.drv %reg_be, %u_reg_if.be_o after %1 : i4
    %9 = llhd.sig.struct_extract %reg2hw["rega0"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %10 = llhd.sig.struct_extract %9["q"] : <!hw.struct<q: i32>>
    %u_rega0.qe, %u_rega0.q, %u_rega0.ds, %u_rega0.qs = hw.instance "u_rega0" @prim_subreg(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %c0_i32: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %10, %u_rega0.q after %1 : i32
    llhd.drv %rega0_qs, %u_rega0.qs after %1 : i32
    %11 = llhd.sig.struct_extract %reg2hw["rega1"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %12 = llhd.sig.struct_extract %11["q"] : <!hw.struct<q: i32>>
    %u_rega1.qe, %u_rega1.q, %u_rega1.ds, %u_rega1.qs = hw.instance "u_rega1" @prim_subreg_4(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %c0_i32: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %12, %u_rega1.q after %1 : i32
    llhd.drv %rega1_qs, %u_rega1.qs after %1 : i32
    %13 = llhd.prb %rega2_we : i1
    %14 = llhd.sig.struct_extract %reg2hw["rega2"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %15 = llhd.sig.struct_extract %14["q"] : <!hw.struct<q: i32>>
    %u_rega2.qe, %u_rega2.q, %u_rega2.ds, %u_rega2.qs = hw.instance "u_rega2" @prim_subreg_5(clk_i: %3: i1, rst_ni: %4: i1, we: %13: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %15, %u_rega2.q after %1 : i32
    llhd.drv %rega2_qs, %u_rega2.qs after %1 : i32
    %16 = llhd.prb %rega3_we : i1
    %17 = llhd.sig.struct_extract %reg2hw["rega3"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %18 = llhd.sig.struct_extract %17["q"] : <!hw.struct<q: i32>>
    %u_rega3.qe, %u_rega3.q, %u_rega3.ds, %u_rega3.qs = hw.instance "u_rega3" @prim_subreg_6(clk_i: %3: i1, rst_ni: %4: i1, we: %16: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %18, %u_rega3.q after %1 : i32
    llhd.drv %rega3_qs, %u_rega3.qs after %1 : i32
    %19 = llhd.prb %rega4_we : i1
    %20 = llhd.sig.struct_extract %reg2hw["rega4"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %21 = llhd.sig.struct_extract %20["q"] : <!hw.struct<q: i32>>
    %u_rega4.qe, %u_rega4.q, %u_rega4.ds, %u_rega4.qs = hw.instance "u_rega4" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %19: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %21, %u_rega4.q after %1 : i32
    llhd.drv %rega4_qs, %u_rega4.qs after %1 : i32
    %22 = llhd.prb %rega5_we : i1
    %23 = llhd.sig.struct_extract %reg2hw["rega5"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %24 = llhd.sig.struct_extract %23["q"] : <!hw.struct<q: i32>>
    %u_rega5.qe, %u_rega5.q, %u_rega5.ds, %u_rega5.qs = hw.instance "u_rega5" @prim_subreg_8(clk_i: %3: i1, rst_ni: %4: i1, we: %22: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %24, %u_rega5.q after %1 : i32
    llhd.drv %rega5_qs, %u_rega5.qs after %1 : i32
    %25 = llhd.prb %rega6_we : i1
    %26 = llhd.sig.struct_extract %reg2hw["rega6"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %27 = llhd.sig.struct_extract %26["q"] : <!hw.struct<q: i32>>
    %u_rega6.qe, %u_rega6.q, %u_rega6.ds, %u_rega6.qs = hw.instance "u_rega6" @prim_subreg_9(clk_i: %3: i1, rst_ni: %4: i1, we: %25: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %27, %u_rega6.q after %1 : i32
    llhd.drv %rega6_qs, %u_rega6.qs after %1 : i32
    %28 = llhd.prb %rega7_we : i1
    %29 = llhd.sig.struct_extract %reg2hw["rega7"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %30 = llhd.sig.struct_extract %29["q"] : <!hw.struct<q: i32>>
    %u_rega7.qe, %u_rega7.q, %u_rega7.ds, %u_rega7.qs = hw.instance "u_rega7" @prim_subreg_10(clk_i: %3: i1, rst_ni: %4: i1, we: %28: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %30, %u_rega7.q after %1 : i32
    llhd.drv %rega7_qs, %u_rega7.qs after %1 : i32
    %31 = llhd.prb %rega8_we : i1
    %32 = llhd.sig.struct_extract %reg2hw["rega8"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %33 = llhd.sig.struct_extract %32["q"] : <!hw.struct<q: i32>>
    %u_rega8.qe, %u_rega8.q, %u_rega8.ds, %u_rega8.qs = hw.instance "u_rega8" @prim_subreg_11(clk_i: %3: i1, rst_ni: %4: i1, we: %31: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %33, %u_rega8.q after %1 : i32
    llhd.drv %rega8_qs, %u_rega8.qs after %1 : i32
    %34 = llhd.prb %rega9_we : i1
    %35 = llhd.sig.struct_extract %reg2hw["rega9"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %36 = llhd.sig.struct_extract %35["q"] : <!hw.struct<q: i32>>
    %u_rega9.qe, %u_rega9.q, %u_rega9.ds, %u_rega9.qs = hw.instance "u_rega9" @prim_subreg_12(clk_i: %3: i1, rst_ni: %4: i1, we: %34: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %36, %u_rega9.q after %1 : i32
    llhd.drv %rega9_qs, %u_rega9.qs after %1 : i32
    %37 = llhd.prb %rega10_we : i1
    %38 = llhd.sig.struct_extract %reg2hw["rega10"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %39 = llhd.sig.struct_extract %38["q"] : <!hw.struct<q: i32>>
    %u_rega10.qe, %u_rega10.q, %u_rega10.ds, %u_rega10.qs = hw.instance "u_rega10" @prim_subreg_13(clk_i: %3: i1, rst_ni: %4: i1, we: %37: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %39, %u_rega10.q after %1 : i32
    llhd.drv %rega10_qs, %u_rega10.qs after %1 : i32
    %40 = llhd.prb %rega11_we : i1
    %41 = llhd.sig.struct_extract %reg2hw["rega11"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %42 = llhd.sig.struct_extract %41["q"] : <!hw.struct<q: i32>>
    %u_rega11.qe, %u_rega11.q, %u_rega11.ds, %u_rega11.qs = hw.instance "u_rega11" @prim_subreg_14(clk_i: %3: i1, rst_ni: %4: i1, we: %40: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %42, %u_rega11.q after %1 : i32
    llhd.drv %rega11_qs, %u_rega11.qs after %1 : i32
    %43 = llhd.prb %rega12_we : i1
    %44 = llhd.sig.struct_extract %reg2hw["rega12"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %45 = llhd.sig.struct_extract %44["q"] : <!hw.struct<q: i32>>
    %u_rega12.qe, %u_rega12.q, %u_rega12.ds, %u_rega12.qs = hw.instance "u_rega12" @prim_subreg_15(clk_i: %3: i1, rst_ni: %4: i1, we: %43: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %45, %u_rega12.q after %1 : i32
    llhd.drv %rega12_qs, %u_rega12.qs after %1 : i32
    %46 = llhd.prb %rega13_we : i1
    %47 = llhd.sig.struct_extract %reg2hw["rega13"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %48 = llhd.sig.struct_extract %47["q"] : <!hw.struct<q: i32>>
    %u_rega13.qe, %u_rega13.q, %u_rega13.ds, %u_rega13.qs = hw.instance "u_rega13" @prim_subreg_16(clk_i: %3: i1, rst_ni: %4: i1, we: %46: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %48, %u_rega13.q after %1 : i32
    llhd.drv %rega13_qs, %u_rega13.qs after %1 : i32
    %49 = llhd.prb %rega14_we : i1
    %50 = llhd.sig.struct_extract %reg2hw["rega14"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %51 = llhd.sig.struct_extract %50["q"] : <!hw.struct<q: i32>>
    %u_rega14.qe, %u_rega14.q, %u_rega14.ds, %u_rega14.qs = hw.instance "u_rega14" @prim_subreg_17(clk_i: %3: i1, rst_ni: %4: i1, we: %49: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %51, %u_rega14.q after %1 : i32
    llhd.drv %rega14_qs, %u_rega14.qs after %1 : i32
    %52 = llhd.prb %rega15_we : i1
    %53 = llhd.sig.struct_extract %reg2hw["rega15"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %54 = llhd.sig.struct_extract %53["q"] : <!hw.struct<q: i32>>
    %u_rega15.qe, %u_rega15.q, %u_rega15.ds, %u_rega15.qs = hw.instance "u_rega15" @prim_subreg_18(clk_i: %3: i1, rst_ni: %4: i1, we: %52: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %54, %u_rega15.q after %1 : i32
    llhd.drv %rega15_qs, %u_rega15.qs after %1 : i32
    %55 = llhd.prb %rega16_we : i1
    %56 = llhd.sig.struct_extract %reg2hw["rega16"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %57 = llhd.sig.struct_extract %56["q"] : <!hw.struct<q: i32>>
    %u_rega16.qe, %u_rega16.q, %u_rega16.ds, %u_rega16.qs = hw.instance "u_rega16" @prim_subreg_19(clk_i: %3: i1, rst_ni: %4: i1, we: %55: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %57, %u_rega16.q after %1 : i32
    llhd.drv %rega16_qs, %u_rega16.qs after %1 : i32
    %58 = llhd.prb %rega17_we : i1
    %59 = llhd.sig.struct_extract %reg2hw["rega17"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %60 = llhd.sig.struct_extract %59["q"] : <!hw.struct<q: i32>>
    %u_rega17.qe, %u_rega17.q, %u_rega17.ds, %u_rega17.qs = hw.instance "u_rega17" @prim_subreg_20(clk_i: %3: i1, rst_ni: %4: i1, we: %58: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %60, %u_rega17.q after %1 : i32
    llhd.drv %rega17_qs, %u_rega17.qs after %1 : i32
    %61 = llhd.prb %rega18_we : i1
    %62 = llhd.sig.struct_extract %reg2hw["rega18"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %63 = llhd.sig.struct_extract %62["q"] : <!hw.struct<q: i32>>
    %u_rega18.qe, %u_rega18.q, %u_rega18.ds, %u_rega18.qs = hw.instance "u_rega18" @prim_subreg_21(clk_i: %3: i1, rst_ni: %4: i1, we: %61: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %63, %u_rega18.q after %1 : i32
    llhd.drv %rega18_qs, %u_rega18.qs after %1 : i32
    %64 = llhd.prb %rega19_we : i1
    %65 = llhd.sig.struct_extract %reg2hw["rega19"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %66 = llhd.sig.struct_extract %65["q"] : <!hw.struct<q: i32>>
    %u_rega19.qe, %u_rega19.q, %u_rega19.ds, %u_rega19.qs = hw.instance "u_rega19" @prim_subreg_22(clk_i: %3: i1, rst_ni: %4: i1, we: %64: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %66, %u_rega19.q after %1 : i32
    llhd.drv %rega19_qs, %u_rega19.qs after %1 : i32
    %67 = llhd.prb %rega20_we : i1
    %68 = llhd.sig.struct_extract %reg2hw["rega20"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %69 = llhd.sig.struct_extract %68["q"] : <!hw.struct<q: i32>>
    %u_rega20.qe, %u_rega20.q, %u_rega20.ds, %u_rega20.qs = hw.instance "u_rega20" @prim_subreg_23(clk_i: %3: i1, rst_ni: %4: i1, we: %67: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %69, %u_rega20.q after %1 : i32
    llhd.drv %rega20_qs, %u_rega20.qs after %1 : i32
    %70 = llhd.prb %rega21_we : i1
    %71 = llhd.sig.struct_extract %reg2hw["rega21"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %72 = llhd.sig.struct_extract %71["q"] : <!hw.struct<q: i32>>
    %u_rega21.qe, %u_rega21.q, %u_rega21.ds, %u_rega21.qs = hw.instance "u_rega21" @prim_subreg_24(clk_i: %3: i1, rst_ni: %4: i1, we: %70: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %72, %u_rega21.q after %1 : i32
    llhd.drv %rega21_qs, %u_rega21.qs after %1 : i32
    %73 = llhd.prb %rega22_we : i1
    %74 = llhd.sig.struct_extract %reg2hw["rega22"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %75 = llhd.sig.struct_extract %74["q"] : <!hw.struct<q: i32>>
    %u_rega22.qe, %u_rega22.q, %u_rega22.ds, %u_rega22.qs = hw.instance "u_rega22" @prim_subreg_25(clk_i: %3: i1, rst_ni: %4: i1, we: %73: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %75, %u_rega22.q after %1 : i32
    llhd.drv %rega22_qs, %u_rega22.qs after %1 : i32
    %76 = llhd.prb %rega23_we : i1
    %77 = llhd.sig.struct_extract %reg2hw["rega23"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %78 = llhd.sig.struct_extract %77["q"] : <!hw.struct<q: i32>>
    %u_rega23.qe, %u_rega23.q, %u_rega23.ds, %u_rega23.qs = hw.instance "u_rega23" @prim_subreg_26(clk_i: %3: i1, rst_ni: %4: i1, we: %76: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %78, %u_rega23.q after %1 : i32
    llhd.drv %rega23_qs, %u_rega23.qs after %1 : i32
    %79 = llhd.prb %rega24_we : i1
    %80 = llhd.sig.struct_extract %reg2hw["rega24"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %81 = llhd.sig.struct_extract %80["q"] : <!hw.struct<q: i32>>
    %u_rega24.qe, %u_rega24.q, %u_rega24.ds, %u_rega24.qs = hw.instance "u_rega24" @prim_subreg_27(clk_i: %3: i1, rst_ni: %4: i1, we: %79: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %81, %u_rega24.q after %1 : i32
    llhd.drv %rega24_qs, %u_rega24.qs after %1 : i32
    %82 = llhd.prb %rega25_we : i1
    %83 = llhd.sig.struct_extract %reg2hw["rega25"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %84 = llhd.sig.struct_extract %83["q"] : <!hw.struct<q: i32>>
    %u_rega25.qe, %u_rega25.q, %u_rega25.ds, %u_rega25.qs = hw.instance "u_rega25" @prim_subreg_28(clk_i: %3: i1, rst_ni: %4: i1, we: %82: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %84, %u_rega25.q after %1 : i32
    llhd.drv %rega25_qs, %u_rega25.qs after %1 : i32
    %85 = llhd.prb %rega26_we : i1
    %86 = llhd.sig.struct_extract %reg2hw["rega26"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %87 = llhd.sig.struct_extract %86["q"] : <!hw.struct<q: i32>>
    %u_rega26.qe, %u_rega26.q, %u_rega26.ds, %u_rega26.qs = hw.instance "u_rega26" @prim_subreg_29(clk_i: %3: i1, rst_ni: %4: i1, we: %85: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %87, %u_rega26.q after %1 : i32
    llhd.drv %rega26_qs, %u_rega26.qs after %1 : i32
    %88 = llhd.prb %rega27_we : i1
    %89 = llhd.sig.struct_extract %reg2hw["rega27"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %90 = llhd.sig.struct_extract %89["q"] : <!hw.struct<q: i32>>
    %u_rega27.qe, %u_rega27.q, %u_rega27.ds, %u_rega27.qs = hw.instance "u_rega27" @prim_subreg_30(clk_i: %3: i1, rst_ni: %4: i1, we: %88: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %90, %u_rega27.q after %1 : i32
    llhd.drv %rega27_qs, %u_rega27.qs after %1 : i32
    %91 = llhd.sig.struct_extract %reg2hw["rega28"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %92 = llhd.sig.struct_extract %91["q"] : <!hw.struct<q: i32>>
    %u_rega28.qe, %u_rega28.q, %u_rega28.ds, %u_rega28.qs = hw.instance "u_rega28" @prim_subreg_31(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %c0_i32: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %92, %u_rega28.q after %1 : i32
    llhd.drv %rega28_qs, %u_rega28.qs after %1 : i32
    %93 = llhd.prb %rega29_we : i1
    %94 = llhd.sig.struct_extract %reg2hw["rega29"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %95 = llhd.sig.struct_extract %94["q"] : <!hw.struct<q: i32>>
    %u_rega29.qe, %u_rega29.q, %u_rega29.ds, %u_rega29.qs = hw.instance "u_rega29" @prim_subreg_32(clk_i: %3: i1, rst_ni: %4: i1, we: %93: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %95, %u_rega29.q after %1 : i32
    llhd.drv %rega29_qs, %u_rega29.qs after %1 : i32
    %96 = llhd.prb %rega30_we : i1
    %97 = llhd.sig.struct_extract %reg2hw["rega30"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %98 = llhd.sig.struct_extract %97["q"] : <!hw.struct<q: i32>>
    %u_rega30.qe, %u_rega30.q, %u_rega30.ds, %u_rega30.qs = hw.instance "u_rega30" @prim_subreg_33(clk_i: %3: i1, rst_ni: %4: i1, we: %96: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %98, %u_rega30.q after %1 : i32
    llhd.drv %rega30_qs, %u_rega30.qs after %1 : i32
    %99 = llhd.prb %rega31_we : i1
    %100 = llhd.sig.struct_extract %reg2hw["rega31"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %101 = llhd.sig.struct_extract %100["q"] : <!hw.struct<q: i32>>
    %u_rega31.qe, %u_rega31.q, %u_rega31.ds, %u_rega31.qs = hw.instance "u_rega31" @prim_subreg_34(clk_i: %3: i1, rst_ni: %4: i1, we: %99: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %101, %u_rega31.q after %1 : i32
    llhd.drv %rega31_qs, %u_rega31.qs after %1 : i32
    %102 = llhd.prb %rega32_we : i1
    %103 = llhd.sig.struct_extract %reg2hw["rega32"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %104 = llhd.sig.struct_extract %103["q"] : <!hw.struct<q: i32>>
    %u_rega32.qe, %u_rega32.q, %u_rega32.ds, %u_rega32.qs = hw.instance "u_rega32" @prim_subreg_35(clk_i: %3: i1, rst_ni: %4: i1, we: %102: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %104, %u_rega32.q after %1 : i32
    llhd.drv %rega32_qs, %u_rega32.qs after %1 : i32
    %105 = llhd.prb %rega33_we : i1
    %106 = llhd.sig.struct_extract %reg2hw["rega33"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %107 = llhd.sig.struct_extract %106["q"] : <!hw.struct<q: i32>>
    %u_rega33.qe, %u_rega33.q, %u_rega33.ds, %u_rega33.qs = hw.instance "u_rega33" @prim_subreg_36(clk_i: %3: i1, rst_ni: %4: i1, we: %105: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %107, %u_rega33.q after %1 : i32
    llhd.drv %rega33_qs, %u_rega33.qs after %1 : i32
    %108 = llhd.prb %rega34_we : i1
    %109 = llhd.sig.struct_extract %reg2hw["rega34"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %110 = llhd.sig.struct_extract %109["q"] : <!hw.struct<q: i32>>
    %u_rega34.qe, %u_rega34.q, %u_rega34.ds, %u_rega34.qs = hw.instance "u_rega34" @prim_subreg_37(clk_i: %3: i1, rst_ni: %4: i1, we: %108: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %110, %u_rega34.q after %1 : i32
    llhd.drv %rega34_qs, %u_rega34.qs after %1 : i32
    %111 = llhd.prb %rega35_we : i1
    %112 = llhd.sig.struct_extract %reg2hw["rega35"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %113 = llhd.sig.struct_extract %112["q"] : <!hw.struct<q: i32>>
    %u_rega35.qe, %u_rega35.q, %u_rega35.ds, %u_rega35.qs = hw.instance "u_rega35" @prim_subreg_38(clk_i: %3: i1, rst_ni: %4: i1, we: %111: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %113, %u_rega35.q after %1 : i32
    llhd.drv %rega35_qs, %u_rega35.qs after %1 : i32
    %114 = llhd.prb %rega36_we : i1
    %115 = llhd.sig.struct_extract %reg2hw["rega36"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %116 = llhd.sig.struct_extract %115["q"] : <!hw.struct<q: i32>>
    %u_rega36.qe, %u_rega36.q, %u_rega36.ds, %u_rega36.qs = hw.instance "u_rega36" @prim_subreg_39(clk_i: %3: i1, rst_ni: %4: i1, we: %114: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %116, %u_rega36.q after %1 : i32
    llhd.drv %rega36_qs, %u_rega36.qs after %1 : i32
    %117 = llhd.prb %rega37_we : i1
    %118 = llhd.sig.struct_extract %reg2hw["rega37"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %119 = llhd.sig.struct_extract %118["q"] : <!hw.struct<q: i32>>
    %u_rega37.qe, %u_rega37.q, %u_rega37.ds, %u_rega37.qs = hw.instance "u_rega37" @prim_subreg_40(clk_i: %3: i1, rst_ni: %4: i1, we: %117: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %119, %u_rega37.q after %1 : i32
    llhd.drv %rega37_qs, %u_rega37.qs after %1 : i32
    %120 = llhd.prb %regal_we : i1
    %regal = hw.struct_extract %hw2reg["regal"] : !hw.struct<regal: !hw.struct<d: i32>>
    %d = hw.struct_extract %regal["d"] : !hw.struct<d: i32>
    %121 = llhd.sig.struct_extract %reg2hw["regal"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %122 = llhd.sig.struct_extract %121["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_regal.qe, %u_regal.qre, %u_regal.q, %u_regal.ds, %u_regal.qs = hw.instance "u_regal" @prim_subreg_ext(re: %false: i1, we: %120: i1, wd: %u_reg_if.wdata_o: i32, d: %d: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %regal_flds_we, %u_regal.qe after %1 : i1
    llhd.drv %122, %u_regal.q after %1 : i32
    %123 = llhd.prb %regb_0_we : i1
    %124 = llhd.sig.struct_extract %reg2hw["regb"] : <!hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>>
    %125 = llhd.sig.array_get %124[%c0_i3] : <!hw.array<5xstruct<q: i32>>>
    %126 = llhd.sig.struct_extract %125["q"] : <!hw.struct<q: i32>>
    %u_regb_0.qe, %u_regb_0.q, %u_regb_0.ds, %u_regb_0.qs = hw.instance "u_regb_0" @prim_subreg_41(clk_i: %3: i1, rst_ni: %4: i1, we: %123: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %126, %u_regb_0.q after %1 : i32
    llhd.drv %regb_0_qs, %u_regb_0.qs after %1 : i32
    %127 = llhd.prb %regb_1_we : i1
    %128 = llhd.sig.array_get %124[%c1_i3] : <!hw.array<5xstruct<q: i32>>>
    %129 = llhd.sig.struct_extract %128["q"] : <!hw.struct<q: i32>>
    %u_regb_1.qe, %u_regb_1.q, %u_regb_1.ds, %u_regb_1.qs = hw.instance "u_regb_1" @prim_subreg_41(clk_i: %3: i1, rst_ni: %4: i1, we: %127: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %129, %u_regb_1.q after %1 : i32
    llhd.drv %regb_1_qs, %u_regb_1.qs after %1 : i32
    %130 = llhd.prb %regb_2_we : i1
    %131 = llhd.sig.array_get %124[%c2_i3] : <!hw.array<5xstruct<q: i32>>>
    %132 = llhd.sig.struct_extract %131["q"] : <!hw.struct<q: i32>>
    %u_regb_2.qe, %u_regb_2.q, %u_regb_2.ds, %u_regb_2.qs = hw.instance "u_regb_2" @prim_subreg_41(clk_i: %3: i1, rst_ni: %4: i1, we: %130: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %132, %u_regb_2.q after %1 : i32
    llhd.drv %regb_2_qs, %u_regb_2.qs after %1 : i32
    %133 = llhd.prb %regb_3_we : i1
    %134 = llhd.sig.array_get %124[%c3_i3] : <!hw.array<5xstruct<q: i32>>>
    %135 = llhd.sig.struct_extract %134["q"] : <!hw.struct<q: i32>>
    %u_regb_3.qe, %u_regb_3.q, %u_regb_3.ds, %u_regb_3.qs = hw.instance "u_regb_3" @prim_subreg_41(clk_i: %3: i1, rst_ni: %4: i1, we: %133: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %135, %u_regb_3.q after %1 : i32
    llhd.drv %regb_3_qs, %u_regb_3.qs after %1 : i32
    %136 = llhd.prb %regb_4_we : i1
    %137 = llhd.sig.array_get %124[%c-4_i3] : <!hw.array<5xstruct<q: i32>>>
    %138 = llhd.sig.struct_extract %137["q"] : <!hw.struct<q: i32>>
    %u_regb_4.qe, %u_regb_4.q, %u_regb_4.ds, %u_regb_4.qs = hw.instance "u_regb_4" @prim_subreg_41(clk_i: %3: i1, rst_ni: %4: i1, we: %136: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %138, %u_regb_4.q after %1 : i32
    llhd.drv %regb_4_qs, %u_regb_4.qs after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %281 = llhd.prb %clk_i_0 : i1
      %282 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %283 = llhd.prb %clk_i_0 : i1
      %284 = comb.xor bin %281, %true : i1
      %285 = comb.and bin %284, %283 : i1
      %286 = llhd.prb %rst_ni_1 : i1
      %287 = comb.xor bin %286, %true : i1
      %288 = comb.and bin %282, %287 : i1
      %289 = comb.or bin %285, %288 : i1
      cf.cond_br %289, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %290 = llhd.prb %rst_ni_1 : i1
      %291 = comb.xor %290, %true : i1
      cf.cond_br %291, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %err_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %292 = llhd.prb %intg_err : i1
      %293 = llhd.prb %reg_we_err : i1
      %294 = comb.or %292, %293 : i1
      cf.cond_br %294, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %err_q, %true after %0 : i1
      cf.br ^bb1
    }
    %139 = llhd.prb %err_q : i1
    %140 = llhd.prb %intg_err : i1
    %141 = llhd.prb %reg_we_err : i1
    %142 = comb.or %139, %140, %141 : i1
    %143 = llhd.prb %reg_rdata_next {sv.namehint = "reg_rdata"} : i32
    %144 = llhd.prb %wr_err : i1
    %145 = comb.or %152, %144, %140 {sv.namehint = "reg_error"} : i1
    %146 = llhd.prb %regal_flds_we {sv.namehint = "regal_qe"} : i1
    %147 = llhd.sig.struct_extract %121["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %147, %146 after %1 : i1
    %148 = llhd.prb %addr_hit : i44
    %149 = llhd.prb %reg_addr : i10
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %281 = llhd.sig.extract %addr_hit from %c0_i6 : <i44> -> <i1>
      %282 = llhd.prb %reg_addr : i10
      %283 = comb.icmp eq %282, %c0_i10 : i10
      llhd.drv %281, %283 after %1 : i1
      %284 = llhd.sig.extract %addr_hit from %c1_i6 : <i44> -> <i1>
      %285 = llhd.prb %reg_addr : i10
      %286 = comb.icmp eq %285, %c4_i10 : i10
      llhd.drv %284, %286 after %1 : i1
      %287 = llhd.sig.extract %addr_hit from %c2_i6 : <i44> -> <i1>
      %288 = llhd.prb %reg_addr : i10
      %289 = comb.icmp eq %288, %c8_i10 : i10
      llhd.drv %287, %289 after %1 : i1
      %290 = llhd.sig.extract %addr_hit from %c3_i6 : <i44> -> <i1>
      %291 = llhd.prb %reg_addr : i10
      %292 = comb.icmp eq %291, %c12_i10 : i10
      llhd.drv %290, %292 after %1 : i1
      %293 = llhd.sig.extract %addr_hit from %c4_i6 : <i44> -> <i1>
      %294 = llhd.prb %reg_addr : i10
      %295 = comb.icmp eq %294, %c16_i10 : i10
      llhd.drv %293, %295 after %1 : i1
      %296 = llhd.sig.extract %addr_hit from %c5_i6 : <i44> -> <i1>
      %297 = llhd.prb %reg_addr : i10
      %298 = comb.icmp eq %297, %c20_i10 : i10
      llhd.drv %296, %298 after %1 : i1
      %299 = llhd.sig.extract %addr_hit from %c6_i6 : <i44> -> <i1>
      %300 = llhd.prb %reg_addr : i10
      %301 = comb.icmp eq %300, %c24_i10 : i10
      llhd.drv %299, %301 after %1 : i1
      %302 = llhd.sig.extract %addr_hit from %c7_i6 : <i44> -> <i1>
      %303 = llhd.prb %reg_addr : i10
      %304 = comb.icmp eq %303, %c28_i10 : i10
      llhd.drv %302, %304 after %1 : i1
      %305 = llhd.sig.extract %addr_hit from %c8_i6 : <i44> -> <i1>
      %306 = llhd.prb %reg_addr : i10
      %307 = comb.icmp eq %306, %c32_i10 : i10
      llhd.drv %305, %307 after %1 : i1
      %308 = llhd.sig.extract %addr_hit from %c9_i6 : <i44> -> <i1>
      %309 = llhd.prb %reg_addr : i10
      %310 = comb.icmp eq %309, %c36_i10 : i10
      llhd.drv %308, %310 after %1 : i1
      %311 = llhd.sig.extract %addr_hit from %c10_i6 : <i44> -> <i1>
      %312 = llhd.prb %reg_addr : i10
      %313 = comb.icmp eq %312, %c40_i10 : i10
      llhd.drv %311, %313 after %1 : i1
      %314 = llhd.sig.extract %addr_hit from %c11_i6 : <i44> -> <i1>
      %315 = llhd.prb %reg_addr : i10
      %316 = comb.icmp eq %315, %c44_i10 : i10
      llhd.drv %314, %316 after %1 : i1
      %317 = llhd.sig.extract %addr_hit from %c12_i6 : <i44> -> <i1>
      %318 = llhd.prb %reg_addr : i10
      %319 = comb.icmp eq %318, %c48_i10 : i10
      llhd.drv %317, %319 after %1 : i1
      %320 = llhd.sig.extract %addr_hit from %c13_i6 : <i44> -> <i1>
      %321 = llhd.prb %reg_addr : i10
      %322 = comb.icmp eq %321, %c52_i10 : i10
      llhd.drv %320, %322 after %1 : i1
      %323 = llhd.sig.extract %addr_hit from %c14_i6 : <i44> -> <i1>
      %324 = llhd.prb %reg_addr : i10
      %325 = comb.icmp eq %324, %c56_i10 : i10
      llhd.drv %323, %325 after %1 : i1
      %326 = llhd.sig.extract %addr_hit from %c15_i6 : <i44> -> <i1>
      %327 = llhd.prb %reg_addr : i10
      %328 = comb.icmp eq %327, %c60_i10 : i10
      llhd.drv %326, %328 after %1 : i1
      %329 = llhd.sig.extract %addr_hit from %c16_i6 : <i44> -> <i1>
      %330 = llhd.prb %reg_addr : i10
      %331 = comb.icmp eq %330, %c64_i10 : i10
      llhd.drv %329, %331 after %1 : i1
      %332 = llhd.sig.extract %addr_hit from %c17_i6 : <i44> -> <i1>
      %333 = llhd.prb %reg_addr : i10
      %334 = comb.icmp eq %333, %c68_i10 : i10
      llhd.drv %332, %334 after %1 : i1
      %335 = llhd.sig.extract %addr_hit from %c18_i6 : <i44> -> <i1>
      %336 = llhd.prb %reg_addr : i10
      %337 = comb.icmp eq %336, %c72_i10 : i10
      llhd.drv %335, %337 after %1 : i1
      %338 = llhd.sig.extract %addr_hit from %c19_i6 : <i44> -> <i1>
      %339 = llhd.prb %reg_addr : i10
      %340 = comb.icmp eq %339, %c76_i10 : i10
      llhd.drv %338, %340 after %1 : i1
      %341 = llhd.sig.extract %addr_hit from %c20_i6 : <i44> -> <i1>
      %342 = llhd.prb %reg_addr : i10
      %343 = comb.icmp eq %342, %c80_i10 : i10
      llhd.drv %341, %343 after %1 : i1
      %344 = llhd.sig.extract %addr_hit from %c21_i6 : <i44> -> <i1>
      %345 = llhd.prb %reg_addr : i10
      %346 = comb.icmp eq %345, %c84_i10 : i10
      llhd.drv %344, %346 after %1 : i1
      %347 = llhd.sig.extract %addr_hit from %c22_i6 : <i44> -> <i1>
      %348 = llhd.prb %reg_addr : i10
      %349 = comb.icmp eq %348, %c88_i10 : i10
      llhd.drv %347, %349 after %1 : i1
      %350 = llhd.sig.extract %addr_hit from %c23_i6 : <i44> -> <i1>
      %351 = llhd.prb %reg_addr : i10
      %352 = comb.icmp eq %351, %c92_i10 : i10
      llhd.drv %350, %352 after %1 : i1
      %353 = llhd.sig.extract %addr_hit from %c24_i6 : <i44> -> <i1>
      %354 = llhd.prb %reg_addr : i10
      %355 = comb.icmp eq %354, %c96_i10 : i10
      llhd.drv %353, %355 after %1 : i1
      %356 = llhd.sig.extract %addr_hit from %c25_i6 : <i44> -> <i1>
      %357 = llhd.prb %reg_addr : i10
      %358 = comb.icmp eq %357, %c100_i10 : i10
      llhd.drv %356, %358 after %1 : i1
      %359 = llhd.sig.extract %addr_hit from %c26_i6 : <i44> -> <i1>
      %360 = llhd.prb %reg_addr : i10
      %361 = comb.icmp eq %360, %c104_i10 : i10
      llhd.drv %359, %361 after %1 : i1
      %362 = llhd.sig.extract %addr_hit from %c27_i6 : <i44> -> <i1>
      %363 = llhd.prb %reg_addr : i10
      %364 = comb.icmp eq %363, %c108_i10 : i10
      llhd.drv %362, %364 after %1 : i1
      %365 = llhd.sig.extract %addr_hit from %c28_i6 : <i44> -> <i1>
      %366 = llhd.prb %reg_addr : i10
      %367 = comb.icmp eq %366, %c112_i10 : i10
      llhd.drv %365, %367 after %1 : i1
      %368 = llhd.sig.extract %addr_hit from %c29_i6 : <i44> -> <i1>
      %369 = llhd.prb %reg_addr : i10
      %370 = comb.icmp eq %369, %c116_i10 : i10
      llhd.drv %368, %370 after %1 : i1
      %371 = llhd.sig.extract %addr_hit from %c30_i6 : <i44> -> <i1>
      %372 = llhd.prb %reg_addr : i10
      %373 = comb.icmp eq %372, %c120_i10 : i10
      llhd.drv %371, %373 after %1 : i1
      %374 = llhd.sig.extract %addr_hit from %c31_i6 : <i44> -> <i1>
      %375 = llhd.prb %reg_addr : i10
      %376 = comb.icmp eq %375, %c124_i10 : i10
      llhd.drv %374, %376 after %1 : i1
      %377 = llhd.sig.extract %addr_hit from %c-32_i6 : <i44> -> <i1>
      %378 = llhd.prb %reg_addr : i10
      %379 = comb.icmp eq %378, %c128_i10 : i10
      llhd.drv %377, %379 after %1 : i1
      %380 = llhd.sig.extract %addr_hit from %c-31_i6 : <i44> -> <i1>
      %381 = llhd.prb %reg_addr : i10
      %382 = comb.icmp eq %381, %c132_i10 : i10
      llhd.drv %380, %382 after %1 : i1
      %383 = llhd.sig.extract %addr_hit from %c-30_i6 : <i44> -> <i1>
      %384 = llhd.prb %reg_addr : i10
      %385 = comb.icmp eq %384, %c136_i10 : i10
      llhd.drv %383, %385 after %1 : i1
      %386 = llhd.sig.extract %addr_hit from %c-29_i6 : <i44> -> <i1>
      %387 = llhd.prb %reg_addr : i10
      %388 = comb.icmp eq %387, %c140_i10 : i10
      llhd.drv %386, %388 after %1 : i1
      %389 = llhd.sig.extract %addr_hit from %c-28_i6 : <i44> -> <i1>
      %390 = llhd.prb %reg_addr : i10
      %391 = comb.icmp eq %390, %c144_i10 : i10
      llhd.drv %389, %391 after %1 : i1
      %392 = llhd.sig.extract %addr_hit from %c-27_i6 : <i44> -> <i1>
      %393 = llhd.prb %reg_addr : i10
      %394 = comb.icmp eq %393, %c148_i10 : i10
      llhd.drv %392, %394 after %1 : i1
      %395 = llhd.sig.extract %addr_hit from %c-26_i6 : <i44> -> <i1>
      %396 = llhd.prb %reg_addr : i10
      %397 = comb.icmp eq %396, %c152_i10 : i10
      llhd.drv %395, %397 after %1 : i1
      %398 = llhd.sig.extract %addr_hit from %c-25_i6 : <i44> -> <i1>
      %399 = llhd.prb %reg_addr : i10
      %400 = comb.icmp eq %399, %c-512_i10 : i10
      llhd.drv %398, %400 after %1 : i1
      %401 = llhd.sig.extract %addr_hit from %c-24_i6 : <i44> -> <i1>
      %402 = llhd.prb %reg_addr : i10
      %403 = comb.icmp eq %402, %c-508_i10 : i10
      llhd.drv %401, %403 after %1 : i1
      %404 = llhd.sig.extract %addr_hit from %c-23_i6 : <i44> -> <i1>
      %405 = llhd.prb %reg_addr : i10
      %406 = comb.icmp eq %405, %c-504_i10 : i10
      llhd.drv %404, %406 after %1 : i1
      %407 = llhd.sig.extract %addr_hit from %c-22_i6 : <i44> -> <i1>
      %408 = llhd.prb %reg_addr : i10
      %409 = comb.icmp eq %408, %c-500_i10 : i10
      llhd.drv %407, %409 after %1 : i1
      %410 = llhd.sig.extract %addr_hit from %c-21_i6 : <i44> -> <i1>
      %411 = llhd.prb %reg_addr : i10
      %412 = comb.icmp eq %411, %c-496_i10 : i10
      llhd.drv %410, %412 after %1 : i1
      llhd.wait (%148, %149 : i44, i10), ^bb1
    }
    %150 = comb.or %u_reg_if.re_o, %6 : i1
    %151 = comb.icmp eq %148, %c0_i44 : i44
    %152 = comb.and %150, %151 {sv.namehint = "addrmiss"} : i1
    %153 = llhd.prb %reg_be : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %281 = llhd.prb %reg_we : i1
      %282 = llhd.prb %addr_hit : i44
      %283 = comb.extract %282 from 0 : (i44) -> i1
      %284 = llhd.prb %reg_be : i4
      %285 = comb.icmp ne %284, %c-1_i4 : i4
      %286 = comb.and %283, %285 : i1
      %287 = comb.extract %282 from 1 : (i44) -> i1
      %288 = comb.icmp ne %284, %c-1_i4 : i4
      %289 = comb.and %287, %288 : i1
      %290 = comb.extract %282 from 2 : (i44) -> i1
      %291 = comb.icmp ne %284, %c-1_i4 : i4
      %292 = comb.and %290, %291 : i1
      %293 = comb.extract %282 from 3 : (i44) -> i1
      %294 = comb.icmp ne %284, %c-1_i4 : i4
      %295 = comb.and %293, %294 : i1
      %296 = comb.extract %282 from 4 : (i44) -> i1
      %297 = comb.icmp ne %284, %c-1_i4 : i4
      %298 = comb.and %296, %297 : i1
      %299 = comb.extract %282 from 5 : (i44) -> i1
      %300 = comb.icmp ne %284, %c-1_i4 : i4
      %301 = comb.and %299, %300 : i1
      %302 = comb.extract %282 from 6 : (i44) -> i1
      %303 = comb.icmp ne %284, %c-1_i4 : i4
      %304 = comb.and %302, %303 : i1
      %305 = comb.extract %282 from 7 : (i44) -> i1
      %306 = comb.icmp ne %284, %c-1_i4 : i4
      %307 = comb.and %305, %306 : i1
      %308 = comb.extract %282 from 8 : (i44) -> i1
      %309 = comb.icmp ne %284, %c-1_i4 : i4
      %310 = comb.and %308, %309 : i1
      %311 = comb.extract %282 from 9 : (i44) -> i1
      %312 = comb.icmp ne %284, %c-1_i4 : i4
      %313 = comb.and %311, %312 : i1
      %314 = comb.extract %282 from 10 : (i44) -> i1
      %315 = comb.icmp ne %284, %c-1_i4 : i4
      %316 = comb.and %314, %315 : i1
      %317 = comb.extract %282 from 11 : (i44) -> i1
      %318 = comb.icmp ne %284, %c-1_i4 : i4
      %319 = comb.and %317, %318 : i1
      %320 = comb.extract %282 from 12 : (i44) -> i1
      %321 = comb.icmp ne %284, %c-1_i4 : i4
      %322 = comb.and %320, %321 : i1
      %323 = comb.extract %282 from 13 : (i44) -> i1
      %324 = comb.icmp ne %284, %c-1_i4 : i4
      %325 = comb.and %323, %324 : i1
      %326 = comb.extract %282 from 14 : (i44) -> i1
      %327 = comb.icmp ne %284, %c-1_i4 : i4
      %328 = comb.and %326, %327 : i1
      %329 = comb.extract %282 from 15 : (i44) -> i1
      %330 = comb.icmp ne %284, %c-1_i4 : i4
      %331 = comb.and %329, %330 : i1
      %332 = comb.extract %282 from 16 : (i44) -> i1
      %333 = comb.icmp ne %284, %c-1_i4 : i4
      %334 = comb.and %332, %333 : i1
      %335 = comb.extract %282 from 17 : (i44) -> i1
      %336 = comb.icmp ne %284, %c-1_i4 : i4
      %337 = comb.and %335, %336 : i1
      %338 = comb.extract %282 from 18 : (i44) -> i1
      %339 = comb.icmp ne %284, %c-1_i4 : i4
      %340 = comb.and %338, %339 : i1
      %341 = comb.extract %282 from 19 : (i44) -> i1
      %342 = comb.icmp ne %284, %c-1_i4 : i4
      %343 = comb.and %341, %342 : i1
      %344 = comb.extract %282 from 20 : (i44) -> i1
      %345 = comb.icmp ne %284, %c-1_i4 : i4
      %346 = comb.and %344, %345 : i1
      %347 = comb.extract %282 from 21 : (i44) -> i1
      %348 = comb.icmp ne %284, %c-1_i4 : i4
      %349 = comb.and %347, %348 : i1
      %350 = comb.extract %282 from 22 : (i44) -> i1
      %351 = comb.icmp ne %284, %c-1_i4 : i4
      %352 = comb.and %350, %351 : i1
      %353 = comb.extract %282 from 23 : (i44) -> i1
      %354 = comb.icmp ne %284, %c-1_i4 : i4
      %355 = comb.and %353, %354 : i1
      %356 = comb.extract %282 from 24 : (i44) -> i1
      %357 = comb.icmp ne %284, %c-1_i4 : i4
      %358 = comb.and %356, %357 : i1
      %359 = comb.extract %282 from 25 : (i44) -> i1
      %360 = comb.icmp ne %284, %c-1_i4 : i4
      %361 = comb.and %359, %360 : i1
      %362 = comb.extract %282 from 26 : (i44) -> i1
      %363 = comb.icmp ne %284, %c-1_i4 : i4
      %364 = comb.and %362, %363 : i1
      %365 = comb.extract %282 from 27 : (i44) -> i1
      %366 = comb.icmp ne %284, %c-1_i4 : i4
      %367 = comb.and %365, %366 : i1
      %368 = comb.extract %282 from 28 : (i44) -> i1
      %369 = comb.icmp ne %284, %c-1_i4 : i4
      %370 = comb.and %368, %369 : i1
      %371 = comb.extract %282 from 29 : (i44) -> i1
      %372 = comb.icmp ne %284, %c-1_i4 : i4
      %373 = comb.and %371, %372 : i1
      %374 = comb.extract %282 from 30 : (i44) -> i1
      %375 = comb.icmp ne %284, %c-1_i4 : i4
      %376 = comb.and %374, %375 : i1
      %377 = comb.extract %282 from 31 : (i44) -> i1
      %378 = comb.icmp ne %284, %c-1_i4 : i4
      %379 = comb.and %377, %378 : i1
      %380 = comb.extract %282 from 32 : (i44) -> i1
      %381 = comb.icmp ne %284, %c-1_i4 : i4
      %382 = comb.and %380, %381 : i1
      %383 = comb.extract %282 from 33 : (i44) -> i1
      %384 = comb.icmp ne %284, %c-1_i4 : i4
      %385 = comb.and %383, %384 : i1
      %386 = comb.extract %282 from 34 : (i44) -> i1
      %387 = comb.icmp ne %284, %c-1_i4 : i4
      %388 = comb.and %386, %387 : i1
      %389 = comb.extract %282 from 35 : (i44) -> i1
      %390 = comb.icmp ne %284, %c-1_i4 : i4
      %391 = comb.and %389, %390 : i1
      %392 = comb.extract %282 from 36 : (i44) -> i1
      %393 = comb.icmp ne %284, %c-1_i4 : i4
      %394 = comb.and %392, %393 : i1
      %395 = comb.extract %282 from 37 : (i44) -> i1
      %396 = comb.icmp ne %284, %c-1_i4 : i4
      %397 = comb.and %395, %396 : i1
      %398 = comb.extract %282 from 38 : (i44) -> i1
      %399 = comb.icmp ne %284, %c-1_i4 : i4
      %400 = comb.and %398, %399 : i1
      %401 = comb.extract %282 from 39 : (i44) -> i1
      %402 = comb.icmp ne %284, %c-1_i4 : i4
      %403 = comb.and %401, %402 : i1
      %404 = comb.extract %282 from 40 : (i44) -> i1
      %405 = comb.icmp ne %284, %c-1_i4 : i4
      %406 = comb.and %404, %405 : i1
      %407 = comb.extract %282 from 41 : (i44) -> i1
      %408 = comb.icmp ne %284, %c-1_i4 : i4
      %409 = comb.and %407, %408 : i1
      %410 = comb.extract %282 from 42 : (i44) -> i1
      %411 = comb.icmp ne %284, %c-1_i4 : i4
      %412 = comb.and %410, %411 : i1
      %413 = comb.extract %282 from 43 : (i44) -> i1
      %414 = comb.icmp ne %284, %c-1_i4 : i4
      %415 = comb.and %413, %414 : i1
      %416 = comb.or %286, %289, %292, %295, %298, %301, %304, %307, %310, %313, %316, %319, %322, %325, %328, %331, %334, %337, %340, %343, %346, %349, %352, %355, %358, %361, %364, %367, %370, %373, %376, %379, %382, %385, %388, %391, %394, %397, %400, %403, %406, %409, %412, %415 : i1
      %417 = comb.and %281, %416 : i1
      llhd.drv %wr_err, %417 after %1 : i1
      llhd.wait (%6, %148, %153, %144 : i1, i44, i4, i1), ^bb1
    }
    %154 = comb.extract %148 from 2 : (i44) -> i1
    %155 = comb.xor %145, %true : i1
    %156 = comb.and %154, %6, %155 : i1
    llhd.drv %rega2_we, %156 after %1 : i1
    %157 = comb.extract %148 from 3 : (i44) -> i1
    %158 = comb.and %157, %6, %155 : i1
    llhd.drv %rega3_we, %158 after %1 : i1
    %159 = comb.extract %148 from 4 : (i44) -> i1
    %160 = comb.and %159, %6, %155 : i1
    llhd.drv %rega4_we, %160 after %1 : i1
    %161 = comb.extract %148 from 5 : (i44) -> i1
    %162 = comb.and %161, %6, %155 : i1
    llhd.drv %rega5_we, %162 after %1 : i1
    %163 = comb.extract %148 from 6 : (i44) -> i1
    %164 = comb.and %163, %6, %155 : i1
    llhd.drv %rega6_we, %164 after %1 : i1
    %165 = comb.extract %148 from 7 : (i44) -> i1
    %166 = comb.and %165, %6, %155 : i1
    llhd.drv %rega7_we, %166 after %1 : i1
    %167 = comb.extract %148 from 8 : (i44) -> i1
    %168 = comb.and %167, %6, %155 : i1
    llhd.drv %rega8_we, %168 after %1 : i1
    %169 = comb.extract %148 from 9 : (i44) -> i1
    %170 = comb.and %169, %6, %155 : i1
    llhd.drv %rega9_we, %170 after %1 : i1
    %171 = comb.extract %148 from 10 : (i44) -> i1
    %172 = comb.and %171, %6, %155 : i1
    llhd.drv %rega10_we, %172 after %1 : i1
    %173 = comb.extract %148 from 11 : (i44) -> i1
    %174 = comb.and %173, %6, %155 : i1
    llhd.drv %rega11_we, %174 after %1 : i1
    %175 = comb.extract %148 from 12 : (i44) -> i1
    %176 = comb.and %175, %6, %155 : i1
    llhd.drv %rega12_we, %176 after %1 : i1
    %177 = comb.extract %148 from 13 : (i44) -> i1
    %178 = comb.and %177, %6, %155 : i1
    llhd.drv %rega13_we, %178 after %1 : i1
    %179 = comb.extract %148 from 14 : (i44) -> i1
    %180 = comb.and %179, %6, %155 : i1
    llhd.drv %rega14_we, %180 after %1 : i1
    %181 = comb.extract %148 from 15 : (i44) -> i1
    %182 = comb.and %181, %6, %155 : i1
    llhd.drv %rega15_we, %182 after %1 : i1
    %183 = comb.extract %148 from 16 : (i44) -> i1
    %184 = comb.and %183, %6, %155 : i1
    llhd.drv %rega16_we, %184 after %1 : i1
    %185 = comb.extract %148 from 17 : (i44) -> i1
    %186 = comb.and %185, %6, %155 : i1
    llhd.drv %rega17_we, %186 after %1 : i1
    %187 = comb.extract %148 from 18 : (i44) -> i1
    %188 = comb.and %187, %6, %155 : i1
    llhd.drv %rega18_we, %188 after %1 : i1
    %189 = comb.extract %148 from 19 : (i44) -> i1
    %190 = comb.and %189, %6, %155 : i1
    llhd.drv %rega19_we, %190 after %1 : i1
    %191 = comb.extract %148 from 20 : (i44) -> i1
    %192 = comb.and %191, %6, %155 : i1
    llhd.drv %rega20_we, %192 after %1 : i1
    %193 = comb.extract %148 from 21 : (i44) -> i1
    %194 = comb.and %193, %6, %155 : i1
    llhd.drv %rega21_we, %194 after %1 : i1
    %195 = comb.extract %148 from 22 : (i44) -> i1
    %196 = comb.and %195, %6, %155 : i1
    llhd.drv %rega22_we, %196 after %1 : i1
    %197 = comb.extract %148 from 23 : (i44) -> i1
    %198 = comb.and %197, %6, %155 : i1
    llhd.drv %rega23_we, %198 after %1 : i1
    %199 = comb.extract %148 from 24 : (i44) -> i1
    %200 = comb.and %199, %6, %155 : i1
    llhd.drv %rega24_we, %200 after %1 : i1
    %201 = comb.extract %148 from 25 : (i44) -> i1
    %202 = comb.and %201, %6, %155 : i1
    llhd.drv %rega25_we, %202 after %1 : i1
    %203 = comb.extract %148 from 26 : (i44) -> i1
    %204 = comb.and %203, %6, %155 : i1
    llhd.drv %rega26_we, %204 after %1 : i1
    %205 = comb.extract %148 from 27 : (i44) -> i1
    %206 = comb.and %205, %6, %155 : i1
    llhd.drv %rega27_we, %206 after %1 : i1
    %207 = comb.extract %148 from 29 : (i44) -> i1
    %208 = comb.and %207, %6, %155 : i1
    llhd.drv %rega29_we, %208 after %1 : i1
    %209 = comb.extract %148 from 30 : (i44) -> i1
    %210 = comb.and %209, %6, %155 : i1
    llhd.drv %rega30_we, %210 after %1 : i1
    %211 = comb.extract %148 from 31 : (i44) -> i1
    %212 = comb.and %211, %6, %155 : i1
    llhd.drv %rega31_we, %212 after %1 : i1
    %213 = comb.extract %148 from 32 : (i44) -> i1
    %214 = comb.and %213, %6, %155 : i1
    llhd.drv %rega32_we, %214 after %1 : i1
    %215 = comb.extract %148 from 33 : (i44) -> i1
    %216 = comb.and %215, %6, %155 : i1
    llhd.drv %rega33_we, %216 after %1 : i1
    %217 = comb.extract %148 from 34 : (i44) -> i1
    %218 = comb.and %217, %6, %155 : i1
    llhd.drv %rega34_we, %218 after %1 : i1
    %219 = comb.extract %148 from 35 : (i44) -> i1
    %220 = comb.and %219, %6, %155 : i1
    llhd.drv %rega35_we, %220 after %1 : i1
    %221 = comb.extract %148 from 36 : (i44) -> i1
    %222 = comb.and %221, %6, %155 : i1
    llhd.drv %rega36_we, %222 after %1 : i1
    %223 = comb.extract %148 from 37 : (i44) -> i1
    %224 = comb.and %223, %6, %155 : i1
    llhd.drv %rega37_we, %224 after %1 : i1
    %225 = comb.extract %148 from 38 : (i44) -> i1
    %226 = comb.and %225, %6, %155 : i1
    llhd.drv %regal_we, %226 after %1 : i1
    %227 = comb.extract %148 from 39 : (i44) -> i1
    %228 = comb.and %227, %6, %155 : i1
    llhd.drv %regb_0_we, %228 after %1 : i1
    %229 = comb.extract %148 from 40 : (i44) -> i1
    %230 = comb.and %229, %6, %155 : i1
    llhd.drv %regb_1_we, %230 after %1 : i1
    %231 = comb.extract %148 from 41 : (i44) -> i1
    %232 = comb.and %231, %6, %155 : i1
    llhd.drv %regb_2_we, %232 after %1 : i1
    %233 = comb.extract %148 from 42 : (i44) -> i1
    %234 = comb.and %233, %6, %155 : i1
    llhd.drv %regb_3_we, %234 after %1 : i1
    %235 = comb.extract %148 from 43 : (i44) -> i1
    %236 = comb.and %235, %6, %155 : i1
    llhd.drv %regb_4_we, %236 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %281 = llhd.sig.extract %reg_we_check from %c0_i6 : <i44> -> <i1>
      llhd.drv %281, %false after %1 : i1
      %282 = llhd.sig.extract %reg_we_check from %c1_i6 : <i44> -> <i1>
      llhd.drv %282, %false after %1 : i1
      %283 = llhd.sig.extract %reg_we_check from %c2_i6 : <i44> -> <i1>
      %284 = llhd.prb %rega2_we : i1
      llhd.drv %283, %284 after %1 : i1
      %285 = llhd.sig.extract %reg_we_check from %c3_i6 : <i44> -> <i1>
      %286 = llhd.prb %rega3_we : i1
      llhd.drv %285, %286 after %1 : i1
      %287 = llhd.sig.extract %reg_we_check from %c4_i6 : <i44> -> <i1>
      %288 = llhd.prb %rega4_we : i1
      llhd.drv %287, %288 after %1 : i1
      %289 = llhd.sig.extract %reg_we_check from %c5_i6 : <i44> -> <i1>
      %290 = llhd.prb %rega5_we : i1
      llhd.drv %289, %290 after %1 : i1
      %291 = llhd.sig.extract %reg_we_check from %c6_i6 : <i44> -> <i1>
      %292 = llhd.prb %rega6_we : i1
      llhd.drv %291, %292 after %1 : i1
      %293 = llhd.sig.extract %reg_we_check from %c7_i6 : <i44> -> <i1>
      %294 = llhd.prb %rega7_we : i1
      llhd.drv %293, %294 after %1 : i1
      %295 = llhd.sig.extract %reg_we_check from %c8_i6 : <i44> -> <i1>
      %296 = llhd.prb %rega8_we : i1
      llhd.drv %295, %296 after %1 : i1
      %297 = llhd.sig.extract %reg_we_check from %c9_i6 : <i44> -> <i1>
      %298 = llhd.prb %rega9_we : i1
      llhd.drv %297, %298 after %1 : i1
      %299 = llhd.sig.extract %reg_we_check from %c10_i6 : <i44> -> <i1>
      %300 = llhd.prb %rega10_we : i1
      llhd.drv %299, %300 after %1 : i1
      %301 = llhd.sig.extract %reg_we_check from %c11_i6 : <i44> -> <i1>
      %302 = llhd.prb %rega11_we : i1
      llhd.drv %301, %302 after %1 : i1
      %303 = llhd.sig.extract %reg_we_check from %c12_i6 : <i44> -> <i1>
      %304 = llhd.prb %rega12_we : i1
      llhd.drv %303, %304 after %1 : i1
      %305 = llhd.sig.extract %reg_we_check from %c13_i6 : <i44> -> <i1>
      %306 = llhd.prb %rega13_we : i1
      llhd.drv %305, %306 after %1 : i1
      %307 = llhd.sig.extract %reg_we_check from %c14_i6 : <i44> -> <i1>
      %308 = llhd.prb %rega14_we : i1
      llhd.drv %307, %308 after %1 : i1
      %309 = llhd.sig.extract %reg_we_check from %c15_i6 : <i44> -> <i1>
      %310 = llhd.prb %rega15_we : i1
      llhd.drv %309, %310 after %1 : i1
      %311 = llhd.sig.extract %reg_we_check from %c16_i6 : <i44> -> <i1>
      %312 = llhd.prb %rega16_we : i1
      llhd.drv %311, %312 after %1 : i1
      %313 = llhd.sig.extract %reg_we_check from %c17_i6 : <i44> -> <i1>
      %314 = llhd.prb %rega17_we : i1
      llhd.drv %313, %314 after %1 : i1
      %315 = llhd.sig.extract %reg_we_check from %c18_i6 : <i44> -> <i1>
      %316 = llhd.prb %rega18_we : i1
      llhd.drv %315, %316 after %1 : i1
      %317 = llhd.sig.extract %reg_we_check from %c19_i6 : <i44> -> <i1>
      %318 = llhd.prb %rega19_we : i1
      llhd.drv %317, %318 after %1 : i1
      %319 = llhd.sig.extract %reg_we_check from %c20_i6 : <i44> -> <i1>
      %320 = llhd.prb %rega20_we : i1
      llhd.drv %319, %320 after %1 : i1
      %321 = llhd.sig.extract %reg_we_check from %c21_i6 : <i44> -> <i1>
      %322 = llhd.prb %rega21_we : i1
      llhd.drv %321, %322 after %1 : i1
      %323 = llhd.sig.extract %reg_we_check from %c22_i6 : <i44> -> <i1>
      %324 = llhd.prb %rega22_we : i1
      llhd.drv %323, %324 after %1 : i1
      %325 = llhd.sig.extract %reg_we_check from %c23_i6 : <i44> -> <i1>
      %326 = llhd.prb %rega23_we : i1
      llhd.drv %325, %326 after %1 : i1
      %327 = llhd.sig.extract %reg_we_check from %c24_i6 : <i44> -> <i1>
      %328 = llhd.prb %rega24_we : i1
      llhd.drv %327, %328 after %1 : i1
      %329 = llhd.sig.extract %reg_we_check from %c25_i6 : <i44> -> <i1>
      %330 = llhd.prb %rega25_we : i1
      llhd.drv %329, %330 after %1 : i1
      %331 = llhd.sig.extract %reg_we_check from %c26_i6 : <i44> -> <i1>
      %332 = llhd.prb %rega26_we : i1
      llhd.drv %331, %332 after %1 : i1
      %333 = llhd.sig.extract %reg_we_check from %c27_i6 : <i44> -> <i1>
      %334 = llhd.prb %rega27_we : i1
      llhd.drv %333, %334 after %1 : i1
      %335 = llhd.sig.extract %reg_we_check from %c28_i6 : <i44> -> <i1>
      llhd.drv %335, %false after %1 : i1
      %336 = llhd.sig.extract %reg_we_check from %c29_i6 : <i44> -> <i1>
      %337 = llhd.prb %rega29_we : i1
      llhd.drv %336, %337 after %1 : i1
      %338 = llhd.sig.extract %reg_we_check from %c30_i6 : <i44> -> <i1>
      %339 = llhd.prb %rega30_we : i1
      llhd.drv %338, %339 after %1 : i1
      %340 = llhd.sig.extract %reg_we_check from %c31_i6 : <i44> -> <i1>
      %341 = llhd.prb %rega31_we : i1
      llhd.drv %340, %341 after %1 : i1
      %342 = llhd.sig.extract %reg_we_check from %c-32_i6 : <i44> -> <i1>
      %343 = llhd.prb %rega32_we : i1
      llhd.drv %342, %343 after %1 : i1
      %344 = llhd.sig.extract %reg_we_check from %c-31_i6 : <i44> -> <i1>
      %345 = llhd.prb %rega33_we : i1
      llhd.drv %344, %345 after %1 : i1
      %346 = llhd.sig.extract %reg_we_check from %c-30_i6 : <i44> -> <i1>
      %347 = llhd.prb %rega34_we : i1
      llhd.drv %346, %347 after %1 : i1
      %348 = llhd.sig.extract %reg_we_check from %c-29_i6 : <i44> -> <i1>
      %349 = llhd.prb %rega35_we : i1
      llhd.drv %348, %349 after %1 : i1
      %350 = llhd.sig.extract %reg_we_check from %c-28_i6 : <i44> -> <i1>
      %351 = llhd.prb %rega36_we : i1
      llhd.drv %350, %351 after %1 : i1
      %352 = llhd.sig.extract %reg_we_check from %c-27_i6 : <i44> -> <i1>
      %353 = llhd.prb %rega37_we : i1
      llhd.drv %352, %353 after %1 : i1
      %354 = llhd.sig.extract %reg_we_check from %c-26_i6 : <i44> -> <i1>
      %355 = llhd.prb %regal_we : i1
      llhd.drv %354, %355 after %1 : i1
      %356 = llhd.sig.extract %reg_we_check from %c-25_i6 : <i44> -> <i1>
      %357 = llhd.prb %regb_0_we : i1
      llhd.drv %356, %357 after %1 : i1
      %358 = llhd.sig.extract %reg_we_check from %c-24_i6 : <i44> -> <i1>
      %359 = llhd.prb %regb_1_we : i1
      llhd.drv %358, %359 after %1 : i1
      %360 = llhd.sig.extract %reg_we_check from %c-23_i6 : <i44> -> <i1>
      %361 = llhd.prb %regb_2_we : i1
      llhd.drv %360, %361 after %1 : i1
      %362 = llhd.sig.extract %reg_we_check from %c-22_i6 : <i44> -> <i1>
      %363 = llhd.prb %regb_3_we : i1
      llhd.drv %362, %363 after %1 : i1
      %364 = llhd.sig.extract %reg_we_check from %c-21_i6 : <i44> -> <i1>
      %365 = llhd.prb %regb_4_we : i1
      llhd.drv %364, %365 after %1 : i1
      llhd.wait (%5, %13, %16, %19, %22, %25, %28, %31, %34, %37, %40, %43, %46, %49, %52, %55, %58, %61, %64, %67, %70, %73, %76, %79, %82, %85, %88, %93, %96, %99, %102, %105, %108, %111, %114, %117, %120, %123, %127, %130, %133, %136 : i44, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    %237 = llhd.prb %rega0_qs : i32
    %238 = llhd.prb %rega1_qs : i32
    %239 = llhd.prb %rega2_qs : i32
    %240 = llhd.prb %rega3_qs : i32
    %241 = llhd.prb %rega4_qs : i32
    %242 = llhd.prb %rega5_qs : i32
    %243 = llhd.prb %rega6_qs : i32
    %244 = llhd.prb %rega7_qs : i32
    %245 = llhd.prb %rega8_qs : i32
    %246 = llhd.prb %rega9_qs : i32
    %247 = llhd.prb %rega10_qs : i32
    %248 = llhd.prb %rega11_qs : i32
    %249 = llhd.prb %rega12_qs : i32
    %250 = llhd.prb %rega13_qs : i32
    %251 = llhd.prb %rega14_qs : i32
    %252 = llhd.prb %rega15_qs : i32
    %253 = llhd.prb %rega16_qs : i32
    %254 = llhd.prb %rega17_qs : i32
    %255 = llhd.prb %rega18_qs : i32
    %256 = llhd.prb %rega19_qs : i32
    %257 = llhd.prb %rega20_qs : i32
    %258 = llhd.prb %rega21_qs : i32
    %259 = llhd.prb %rega22_qs : i32
    %260 = llhd.prb %rega23_qs : i32
    %261 = llhd.prb %rega24_qs : i32
    %262 = llhd.prb %rega25_qs : i32
    %263 = llhd.prb %rega26_qs : i32
    %264 = llhd.prb %rega27_qs : i32
    %265 = llhd.prb %rega28_qs : i32
    %266 = llhd.prb %rega29_qs : i32
    %267 = llhd.prb %rega30_qs : i32
    %268 = llhd.prb %rega31_qs : i32
    %269 = llhd.prb %rega32_qs : i32
    %270 = llhd.prb %rega33_qs : i32
    %271 = llhd.prb %rega34_qs : i32
    %272 = llhd.prb %rega35_qs : i32
    %273 = llhd.prb %rega36_qs : i32
    %274 = llhd.prb %rega37_qs : i32
    %275 = llhd.prb %regb_0_qs : i32
    %276 = llhd.prb %regb_1_qs : i32
    %277 = llhd.prb %regb_2_qs : i32
    %278 = llhd.prb %regb_3_qs : i32
    %279 = llhd.prb %regb_4_qs : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb90
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      %281 = llhd.prb %addr_hit : i44
      %282 = comb.extract %281 from 0 : (i44) -> i1
      %283 = comb.icmp ceq %282, %true : i1
      cf.cond_br %283, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %284 = llhd.prb %rega0_qs : i32
      llhd.drv %reg_rdata_next, %284 after %1 : i32
      cf.br ^bb90
    ^bb3:  // pred: ^bb1
      %285 = llhd.prb %addr_hit : i44
      %286 = comb.extract %285 from 1 : (i44) -> i1
      %287 = comb.icmp ceq %286, %true : i1
      cf.cond_br %287, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %288 = llhd.prb %rega1_qs : i32
      llhd.drv %reg_rdata_next, %288 after %1 : i32
      cf.br ^bb90
    ^bb5:  // pred: ^bb3
      %289 = llhd.prb %addr_hit : i44
      %290 = comb.extract %289 from 2 : (i44) -> i1
      %291 = comb.icmp ceq %290, %true : i1
      cf.cond_br %291, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %292 = llhd.prb %rega2_qs : i32
      llhd.drv %reg_rdata_next, %292 after %1 : i32
      cf.br ^bb90
    ^bb7:  // pred: ^bb5
      %293 = llhd.prb %addr_hit : i44
      %294 = comb.extract %293 from 3 : (i44) -> i1
      %295 = comb.icmp ceq %294, %true : i1
      cf.cond_br %295, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %296 = llhd.prb %rega3_qs : i32
      llhd.drv %reg_rdata_next, %296 after %1 : i32
      cf.br ^bb90
    ^bb9:  // pred: ^bb7
      %297 = llhd.prb %addr_hit : i44
      %298 = comb.extract %297 from 4 : (i44) -> i1
      %299 = comb.icmp ceq %298, %true : i1
      cf.cond_br %299, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %300 = llhd.prb %rega4_qs : i32
      llhd.drv %reg_rdata_next, %300 after %1 : i32
      cf.br ^bb90
    ^bb11:  // pred: ^bb9
      %301 = llhd.prb %addr_hit : i44
      %302 = comb.extract %301 from 5 : (i44) -> i1
      %303 = comb.icmp ceq %302, %true : i1
      cf.cond_br %303, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %304 = llhd.prb %rega5_qs : i32
      llhd.drv %reg_rdata_next, %304 after %1 : i32
      cf.br ^bb90
    ^bb13:  // pred: ^bb11
      %305 = llhd.prb %addr_hit : i44
      %306 = comb.extract %305 from 6 : (i44) -> i1
      %307 = comb.icmp ceq %306, %true : i1
      cf.cond_br %307, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %308 = llhd.prb %rega6_qs : i32
      llhd.drv %reg_rdata_next, %308 after %1 : i32
      cf.br ^bb90
    ^bb15:  // pred: ^bb13
      %309 = llhd.prb %addr_hit : i44
      %310 = comb.extract %309 from 7 : (i44) -> i1
      %311 = comb.icmp ceq %310, %true : i1
      cf.cond_br %311, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      %312 = llhd.prb %rega7_qs : i32
      llhd.drv %reg_rdata_next, %312 after %1 : i32
      cf.br ^bb90
    ^bb17:  // pred: ^bb15
      %313 = llhd.prb %addr_hit : i44
      %314 = comb.extract %313 from 8 : (i44) -> i1
      %315 = comb.icmp ceq %314, %true : i1
      cf.cond_br %315, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      %316 = llhd.prb %rega8_qs : i32
      llhd.drv %reg_rdata_next, %316 after %1 : i32
      cf.br ^bb90
    ^bb19:  // pred: ^bb17
      %317 = llhd.prb %addr_hit : i44
      %318 = comb.extract %317 from 9 : (i44) -> i1
      %319 = comb.icmp ceq %318, %true : i1
      cf.cond_br %319, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      %320 = llhd.prb %rega9_qs : i32
      llhd.drv %reg_rdata_next, %320 after %1 : i32
      cf.br ^bb90
    ^bb21:  // pred: ^bb19
      %321 = llhd.prb %addr_hit : i44
      %322 = comb.extract %321 from 10 : (i44) -> i1
      %323 = comb.icmp ceq %322, %true : i1
      cf.cond_br %323, ^bb22, ^bb23
    ^bb22:  // pred: ^bb21
      %324 = llhd.prb %rega10_qs : i32
      llhd.drv %reg_rdata_next, %324 after %1 : i32
      cf.br ^bb90
    ^bb23:  // pred: ^bb21
      %325 = llhd.prb %addr_hit : i44
      %326 = comb.extract %325 from 11 : (i44) -> i1
      %327 = comb.icmp ceq %326, %true : i1
      cf.cond_br %327, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      %328 = llhd.prb %rega11_qs : i32
      llhd.drv %reg_rdata_next, %328 after %1 : i32
      cf.br ^bb90
    ^bb25:  // pred: ^bb23
      %329 = llhd.prb %addr_hit : i44
      %330 = comb.extract %329 from 12 : (i44) -> i1
      %331 = comb.icmp ceq %330, %true : i1
      cf.cond_br %331, ^bb26, ^bb27
    ^bb26:  // pred: ^bb25
      %332 = llhd.prb %rega12_qs : i32
      llhd.drv %reg_rdata_next, %332 after %1 : i32
      cf.br ^bb90
    ^bb27:  // pred: ^bb25
      %333 = llhd.prb %addr_hit : i44
      %334 = comb.extract %333 from 13 : (i44) -> i1
      %335 = comb.icmp ceq %334, %true : i1
      cf.cond_br %335, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      %336 = llhd.prb %rega13_qs : i32
      llhd.drv %reg_rdata_next, %336 after %1 : i32
      cf.br ^bb90
    ^bb29:  // pred: ^bb27
      %337 = llhd.prb %addr_hit : i44
      %338 = comb.extract %337 from 14 : (i44) -> i1
      %339 = comb.icmp ceq %338, %true : i1
      cf.cond_br %339, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      %340 = llhd.prb %rega14_qs : i32
      llhd.drv %reg_rdata_next, %340 after %1 : i32
      cf.br ^bb90
    ^bb31:  // pred: ^bb29
      %341 = llhd.prb %addr_hit : i44
      %342 = comb.extract %341 from 15 : (i44) -> i1
      %343 = comb.icmp ceq %342, %true : i1
      cf.cond_br %343, ^bb32, ^bb33
    ^bb32:  // pred: ^bb31
      %344 = llhd.prb %rega15_qs : i32
      llhd.drv %reg_rdata_next, %344 after %1 : i32
      cf.br ^bb90
    ^bb33:  // pred: ^bb31
      %345 = llhd.prb %addr_hit : i44
      %346 = comb.extract %345 from 16 : (i44) -> i1
      %347 = comb.icmp ceq %346, %true : i1
      cf.cond_br %347, ^bb34, ^bb35
    ^bb34:  // pred: ^bb33
      %348 = llhd.prb %rega16_qs : i32
      llhd.drv %reg_rdata_next, %348 after %1 : i32
      cf.br ^bb90
    ^bb35:  // pred: ^bb33
      %349 = llhd.prb %addr_hit : i44
      %350 = comb.extract %349 from 17 : (i44) -> i1
      %351 = comb.icmp ceq %350, %true : i1
      cf.cond_br %351, ^bb36, ^bb37
    ^bb36:  // pred: ^bb35
      %352 = llhd.prb %rega17_qs : i32
      llhd.drv %reg_rdata_next, %352 after %1 : i32
      cf.br ^bb90
    ^bb37:  // pred: ^bb35
      %353 = llhd.prb %addr_hit : i44
      %354 = comb.extract %353 from 18 : (i44) -> i1
      %355 = comb.icmp ceq %354, %true : i1
      cf.cond_br %355, ^bb38, ^bb39
    ^bb38:  // pred: ^bb37
      %356 = llhd.prb %rega18_qs : i32
      llhd.drv %reg_rdata_next, %356 after %1 : i32
      cf.br ^bb90
    ^bb39:  // pred: ^bb37
      %357 = llhd.prb %addr_hit : i44
      %358 = comb.extract %357 from 19 : (i44) -> i1
      %359 = comb.icmp ceq %358, %true : i1
      cf.cond_br %359, ^bb40, ^bb41
    ^bb40:  // pred: ^bb39
      %360 = llhd.prb %rega19_qs : i32
      llhd.drv %reg_rdata_next, %360 after %1 : i32
      cf.br ^bb90
    ^bb41:  // pred: ^bb39
      %361 = llhd.prb %addr_hit : i44
      %362 = comb.extract %361 from 20 : (i44) -> i1
      %363 = comb.icmp ceq %362, %true : i1
      cf.cond_br %363, ^bb42, ^bb43
    ^bb42:  // pred: ^bb41
      %364 = llhd.prb %rega20_qs : i32
      llhd.drv %reg_rdata_next, %364 after %1 : i32
      cf.br ^bb90
    ^bb43:  // pred: ^bb41
      %365 = llhd.prb %addr_hit : i44
      %366 = comb.extract %365 from 21 : (i44) -> i1
      %367 = comb.icmp ceq %366, %true : i1
      cf.cond_br %367, ^bb44, ^bb45
    ^bb44:  // pred: ^bb43
      %368 = llhd.prb %rega21_qs : i32
      llhd.drv %reg_rdata_next, %368 after %1 : i32
      cf.br ^bb90
    ^bb45:  // pred: ^bb43
      %369 = llhd.prb %addr_hit : i44
      %370 = comb.extract %369 from 22 : (i44) -> i1
      %371 = comb.icmp ceq %370, %true : i1
      cf.cond_br %371, ^bb46, ^bb47
    ^bb46:  // pred: ^bb45
      %372 = llhd.prb %rega22_qs : i32
      llhd.drv %reg_rdata_next, %372 after %1 : i32
      cf.br ^bb90
    ^bb47:  // pred: ^bb45
      %373 = llhd.prb %addr_hit : i44
      %374 = comb.extract %373 from 23 : (i44) -> i1
      %375 = comb.icmp ceq %374, %true : i1
      cf.cond_br %375, ^bb48, ^bb49
    ^bb48:  // pred: ^bb47
      %376 = llhd.prb %rega23_qs : i32
      llhd.drv %reg_rdata_next, %376 after %1 : i32
      cf.br ^bb90
    ^bb49:  // pred: ^bb47
      %377 = llhd.prb %addr_hit : i44
      %378 = comb.extract %377 from 24 : (i44) -> i1
      %379 = comb.icmp ceq %378, %true : i1
      cf.cond_br %379, ^bb50, ^bb51
    ^bb50:  // pred: ^bb49
      %380 = llhd.prb %rega24_qs : i32
      llhd.drv %reg_rdata_next, %380 after %1 : i32
      cf.br ^bb90
    ^bb51:  // pred: ^bb49
      %381 = llhd.prb %addr_hit : i44
      %382 = comb.extract %381 from 25 : (i44) -> i1
      %383 = comb.icmp ceq %382, %true : i1
      cf.cond_br %383, ^bb52, ^bb53
    ^bb52:  // pred: ^bb51
      %384 = llhd.prb %rega25_qs : i32
      llhd.drv %reg_rdata_next, %384 after %1 : i32
      cf.br ^bb90
    ^bb53:  // pred: ^bb51
      %385 = llhd.prb %addr_hit : i44
      %386 = comb.extract %385 from 26 : (i44) -> i1
      %387 = comb.icmp ceq %386, %true : i1
      cf.cond_br %387, ^bb54, ^bb55
    ^bb54:  // pred: ^bb53
      %388 = llhd.prb %rega26_qs : i32
      llhd.drv %reg_rdata_next, %388 after %1 : i32
      cf.br ^bb90
    ^bb55:  // pred: ^bb53
      %389 = llhd.prb %addr_hit : i44
      %390 = comb.extract %389 from 27 : (i44) -> i1
      %391 = comb.icmp ceq %390, %true : i1
      cf.cond_br %391, ^bb56, ^bb57
    ^bb56:  // pred: ^bb55
      %392 = llhd.prb %rega27_qs : i32
      llhd.drv %reg_rdata_next, %392 after %1 : i32
      cf.br ^bb90
    ^bb57:  // pred: ^bb55
      %393 = llhd.prb %addr_hit : i44
      %394 = comb.extract %393 from 28 : (i44) -> i1
      %395 = comb.icmp ceq %394, %true : i1
      cf.cond_br %395, ^bb58, ^bb59
    ^bb58:  // pred: ^bb57
      %396 = llhd.prb %rega28_qs : i32
      llhd.drv %reg_rdata_next, %396 after %1 : i32
      cf.br ^bb90
    ^bb59:  // pred: ^bb57
      %397 = llhd.prb %addr_hit : i44
      %398 = comb.extract %397 from 29 : (i44) -> i1
      %399 = comb.icmp ceq %398, %true : i1
      cf.cond_br %399, ^bb60, ^bb61
    ^bb60:  // pred: ^bb59
      %400 = llhd.prb %rega29_qs : i32
      llhd.drv %reg_rdata_next, %400 after %1 : i32
      cf.br ^bb90
    ^bb61:  // pred: ^bb59
      %401 = llhd.prb %addr_hit : i44
      %402 = comb.extract %401 from 30 : (i44) -> i1
      %403 = comb.icmp ceq %402, %true : i1
      cf.cond_br %403, ^bb62, ^bb63
    ^bb62:  // pred: ^bb61
      %404 = llhd.prb %rega30_qs : i32
      llhd.drv %reg_rdata_next, %404 after %1 : i32
      cf.br ^bb90
    ^bb63:  // pred: ^bb61
      %405 = llhd.prb %addr_hit : i44
      %406 = comb.extract %405 from 31 : (i44) -> i1
      %407 = comb.icmp ceq %406, %true : i1
      cf.cond_br %407, ^bb64, ^bb65
    ^bb64:  // pred: ^bb63
      %408 = llhd.prb %rega31_qs : i32
      llhd.drv %reg_rdata_next, %408 after %1 : i32
      cf.br ^bb90
    ^bb65:  // pred: ^bb63
      %409 = llhd.prb %addr_hit : i44
      %410 = comb.extract %409 from 32 : (i44) -> i1
      %411 = comb.icmp ceq %410, %true : i1
      cf.cond_br %411, ^bb66, ^bb67
    ^bb66:  // pred: ^bb65
      %412 = llhd.prb %rega32_qs : i32
      llhd.drv %reg_rdata_next, %412 after %1 : i32
      cf.br ^bb90
    ^bb67:  // pred: ^bb65
      %413 = llhd.prb %addr_hit : i44
      %414 = comb.extract %413 from 33 : (i44) -> i1
      %415 = comb.icmp ceq %414, %true : i1
      cf.cond_br %415, ^bb68, ^bb69
    ^bb68:  // pred: ^bb67
      %416 = llhd.prb %rega33_qs : i32
      llhd.drv %reg_rdata_next, %416 after %1 : i32
      cf.br ^bb90
    ^bb69:  // pred: ^bb67
      %417 = llhd.prb %addr_hit : i44
      %418 = comb.extract %417 from 34 : (i44) -> i1
      %419 = comb.icmp ceq %418, %true : i1
      cf.cond_br %419, ^bb70, ^bb71
    ^bb70:  // pred: ^bb69
      %420 = llhd.prb %rega34_qs : i32
      llhd.drv %reg_rdata_next, %420 after %1 : i32
      cf.br ^bb90
    ^bb71:  // pred: ^bb69
      %421 = llhd.prb %addr_hit : i44
      %422 = comb.extract %421 from 35 : (i44) -> i1
      %423 = comb.icmp ceq %422, %true : i1
      cf.cond_br %423, ^bb72, ^bb73
    ^bb72:  // pred: ^bb71
      %424 = llhd.prb %rega35_qs : i32
      llhd.drv %reg_rdata_next, %424 after %1 : i32
      cf.br ^bb90
    ^bb73:  // pred: ^bb71
      %425 = llhd.prb %addr_hit : i44
      %426 = comb.extract %425 from 36 : (i44) -> i1
      %427 = comb.icmp ceq %426, %true : i1
      cf.cond_br %427, ^bb74, ^bb75
    ^bb74:  // pred: ^bb73
      %428 = llhd.prb %rega36_qs : i32
      llhd.drv %reg_rdata_next, %428 after %1 : i32
      cf.br ^bb90
    ^bb75:  // pred: ^bb73
      %429 = llhd.prb %addr_hit : i44
      %430 = comb.extract %429 from 37 : (i44) -> i1
      %431 = comb.icmp ceq %430, %true : i1
      cf.cond_br %431, ^bb76, ^bb77
    ^bb76:  // pred: ^bb75
      %432 = llhd.prb %rega37_qs : i32
      llhd.drv %reg_rdata_next, %432 after %1 : i32
      cf.br ^bb90
    ^bb77:  // pred: ^bb75
      %433 = llhd.prb %addr_hit : i44
      %434 = comb.extract %433 from 38 : (i44) -> i1
      %435 = comb.icmp ceq %434, %true : i1
      cf.cond_br %435, ^bb78, ^bb79
    ^bb78:  // pred: ^bb77
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb90
    ^bb79:  // pred: ^bb77
      %436 = llhd.prb %addr_hit : i44
      %437 = comb.extract %436 from 39 : (i44) -> i1
      %438 = comb.icmp ceq %437, %true : i1
      cf.cond_br %438, ^bb80, ^bb81
    ^bb80:  // pred: ^bb79
      %439 = llhd.prb %regb_0_qs : i32
      llhd.drv %reg_rdata_next, %439 after %1 : i32
      cf.br ^bb90
    ^bb81:  // pred: ^bb79
      %440 = llhd.prb %addr_hit : i44
      %441 = comb.extract %440 from 40 : (i44) -> i1
      %442 = comb.icmp ceq %441, %true : i1
      cf.cond_br %442, ^bb82, ^bb83
    ^bb82:  // pred: ^bb81
      %443 = llhd.prb %regb_1_qs : i32
      llhd.drv %reg_rdata_next, %443 after %1 : i32
      cf.br ^bb90
    ^bb83:  // pred: ^bb81
      %444 = llhd.prb %addr_hit : i44
      %445 = comb.extract %444 from 41 : (i44) -> i1
      %446 = comb.icmp ceq %445, %true : i1
      cf.cond_br %446, ^bb84, ^bb85
    ^bb84:  // pred: ^bb83
      %447 = llhd.prb %regb_2_qs : i32
      llhd.drv %reg_rdata_next, %447 after %1 : i32
      cf.br ^bb90
    ^bb85:  // pred: ^bb83
      %448 = llhd.prb %addr_hit : i44
      %449 = comb.extract %448 from 42 : (i44) -> i1
      %450 = comb.icmp ceq %449, %true : i1
      cf.cond_br %450, ^bb86, ^bb87
    ^bb86:  // pred: ^bb85
      %451 = llhd.prb %regb_3_qs : i32
      llhd.drv %reg_rdata_next, %451 after %1 : i32
      cf.br ^bb90
    ^bb87:  // pred: ^bb85
      %452 = llhd.prb %addr_hit : i44
      %453 = comb.extract %452 from 43 : (i44) -> i1
      %454 = comb.icmp ceq %453, %true : i1
      cf.cond_br %454, ^bb88, ^bb89
    ^bb88:  // pred: ^bb87
      %455 = llhd.prb %regb_4_qs : i32
      llhd.drv %reg_rdata_next, %455 after %1 : i32
      cf.br ^bb90
    ^bb89:  // pred: ^bb87
      llhd.drv %reg_rdata_next, %c-1_i32 after %1 : i32
      cf.br ^bb90
    ^bb90:  // 45 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb18, ^bb20, ^bb22, ^bb24, ^bb26, ^bb28, ^bb30, ^bb32, ^bb34, ^bb36, ^bb38, ^bb40, ^bb42, ^bb44, ^bb46, ^bb48, ^bb50, ^bb52, ^bb54, ^bb56, ^bb58, ^bb60, ^bb62, ^bb64, ^bb66, ^bb68, ^bb70, ^bb72, ^bb74, ^bb76, ^bb78, ^bb80, ^bb82, ^bb84, ^bb86, ^bb88, ^bb89
      llhd.wait (%143, %148, %237, %238, %239, %240, %241, %242, %243, %244, %245, %246, %247, %248, %249, %250, %251, %252, %253, %254, %255, %256, %257, %258, %259, %260, %261, %262, %263, %264, %265, %266, %267, %268, %269, %270, %271, %272, %273, %274, %275, %276, %277, %278, %279 : i32, i44, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32), ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    %280 = llhd.prb %reg2hw : !hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>
    hw.output %u_rsp_intg_gen.tl_o, %280, %142 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>, i1
  }
  hw.module @ast(in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out ast_init_done_o : i4, in %clk_ast_adc_i : i1, in %rst_ast_adc_ni : i1, in %clk_ast_alert_i : i1, in %rst_ast_alert_ni : i1, in %clk_ast_es_i : i1, in %rst_ast_es_ni : i1, in %clk_ast_rng_i : i1, in %rst_ast_rng_ni : i1, in %clk_ast_tlul_i : i1, in %rst_ast_tlul_ni : i1, in %clk_ast_usb_i : i1, in %rst_ast_usb_ni : i1, in %clk_ast_ext_i : i1, in %por_ni : i1, in %sns_clks_i : !hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>, in %sns_rsts_i : !hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>, in %sns_spi_ext_clk_i : i1, in %vcc_supp_i : i1, in %vcaon_supp_i : i1, in %vcmain_supp_i : i1, in %vioa_supp_i : i1, in %viob_supp_i : i1, out ast_pwst_o : !hw.struct<aon_pok: i1, vcc_pok: i1, main_pok: i1, io_pok: i2>, out ast_pwst_h_o : !hw.struct<aon_pok: i1, vcc_pok: i1, main_pok: i1, io_pok: i2>, in %main_pd_ni : i1, in %main_env_iso_en_i : i1, out flash_power_down_h_o : i1, out flash_power_ready_h_o : i1, in %otp_power_seq_i : i2, out otp_power_seq_h_o : i2, in %clk_src_sys_en_i : i1, in %clk_src_sys_jen_i : i4, out clk_src_sys_o : i1, out clk_src_sys_val_o : i1, out clk_src_aon_o : i1, out clk_src_aon_val_o : i1, in %clk_src_io_en_i : i1, out clk_src_io_o : i1, out clk_src_io_val_o : i1, out clk_src_io_48m_o : i4, in %usb_ref_pulse_i : i1, in %usb_ref_val_i : i1, in %clk_src_usb_en_i : i1, out clk_src_usb_o : i1, out clk_src_usb_val_o : i1, out usb_io_pu_cal_o : i20, in %adc_pd_i : i1, in %adc_a0_ai : i1, in %adc_a1_ai : i1, in %adc_chnsel_i : i2, out adc_d_o : i10, out adc_d_val_o : i1, in %rng_en_i : i1, in %rng_fips_i : i1, out rng_val_o : i1, out rng_b_o : i4, in %entropy_rsp_i : !hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>, out entropy_req_o : !hw.struct<edn_req: i1>, in %alert_rsp_i : !hw.struct<alerts_ack: !hw.array<11xstruct<p: i1, n: i1>>, alerts_trig: !hw.array<11xstruct<p: i1, n: i1>>>, out alert_req_o : !hw.struct<alerts: !hw.array<11xstruct<p: i1, n: i1>>>, in %dft_strap_test_i : !hw.struct<valid: i1, straps: i2>, in %lc_dft_en_i : i4, in %fla_obs_i : i8, in %otp_obs_i : i8, in %otm_obs_i : i8, in %usb_obs_i : i1, out obs_ctrl_o : !hw.struct<obgsl: i4, obmsl: i4, obmen: i4>, in %padmux2ast_i : i8, out ast2padmux_o : i9, out mux_iob_sel_o : i4, out ast2pad_t0_ao : i1, out ast2pad_t1_ao : i1, in %ext_freq_is_96m_i : i4, in %all_clk_byp_req_i : i4, out all_clk_byp_ack_o : i4, in %io_clk_byp_req_i : i4, out io_clk_byp_ack_o : i4, out flash_bist_en_o : i4, out dpram_rmf_o : !hw.struct<test_a: i1, marg_en_a: i1, marg_a: i4, test_b: i1, marg_en_b: i1, marg_b: i4>, out dpram_rml_o : !hw.struct<test_a: i1, marg_en_a: i1, marg_a: i4, test_b: i1, marg_en_b: i1, marg_b: i4>, out spram_rm_o : !hw.struct<test: i1, marg_en: i1, marg: i4>, out sprgf_rm_o : !hw.struct<test: i1, marg_en: i1, marg: i4>, out sprom_rm_o : !hw.struct<test: i1, marg_en: i1, marg: i4>, out dft_scan_md_o : i4, out scan_shift_en_o : i1, out scan_reset_no : i1) {
    %c1024_i20 = hw.constant 1024 : i20
    %0 = hw.aggregate_constant [false, true] : !hw.struct<p: i1, n: i1>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %c-6_i4 = hw.constant -6 : i4
    %c-8_i4 = hw.constant -8 : i4
    %c7_i4 = hw.constant 7 : i4
    %c4_i4 = hw.constant 4 : i4
    %c3_i4 = hw.constant 3 : i4
    %c2_i4 = hw.constant 2 : i4
    %c1_i4 = hw.constant 1 : i4
    %2 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %3 = hw.aggregate_constant [[0 : i32]] : !hw.struct<regal: !hw.struct<d: i32>>
    %c0_i9 = hw.constant 0 : i9
    %4 = hw.aggregate_constant [[[false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false]]] : !hw.struct<alerts: !hw.array<11xstruct<p: i1, n: i1>>>
    %c0_i10 = hw.constant 0 : i10
    %c0_i2 = hw.constant 0 : i2
    %5 = hw.aggregate_constant [false, false, false, 0 : i2] : !hw.struct<aon_pok: i1, vcc_pok: i1, main_pok: i1, io_pok: i2>
    %false = hw.constant false {sv.namehint = "shift_en"}
    %c6_i4 = hw.constant 6 : i4
    %c38_i32 = hw.constant 38 : i32
    %c5_i4 = hw.constant 5 : i4 {sv.namehint = "entropy_rate"}
    %c0_i4 = hw.constant 0 : i4
    %c-7_i4 = hw.constant -7 : i4
    %true = hw.constant true {sv.namehint = "clk_src_aon_en"}
    %ast_init_done_o = llhd.sig %c0_i4 : i4
    %clk_ast_tlul_i_0 = llhd.sig name "clk_ast_tlul_i" %false : i1
    %6 = llhd.prb %clk_ast_tlul_i_0 : i1
    %rst_ast_tlul_ni_1 = llhd.sig name "rst_ast_tlul_ni" %false : i1
    %7 = llhd.prb %rst_ast_tlul_ni_1 : i1
    %ast_pwst_o = llhd.sig %5 : !hw.struct<aon_pok: i1, vcc_pok: i1, main_pok: i1, io_pok: i2>
    %ast_pwst_h_o = llhd.sig %5 : !hw.struct<aon_pok: i1, vcc_pok: i1, main_pok: i1, io_pok: i2>
    %otp_power_seq_h_o = llhd.sig %c0_i2 : i2
    %adc_d_o = llhd.sig %c0_i10 : i10
    %rng_b_o = llhd.sig %c0_i4 : i4
    %alert_req_o = llhd.sig %4 : !hw.struct<alerts: !hw.array<11xstruct<p: i1, n: i1>>>
    %ast2padmux_o = llhd.sig %c0_i9 : i9
    %scan_reset_n = llhd.sig %false : i1
    %vcaon_pok = llhd.sig %false : i1
    %8 = llhd.prb %vcaon_pok : i1
    %vcaon_pok_por = llhd.sig %false : i1
    %9 = llhd.prb %vcaon_pok_por : i1
    %vcaon_pok_por_lat = llhd.sig %false : i1
    %vcmain_pok_por_src = llhd.sig %false : i1
    %sys_io_osc_cal = llhd.sig %false : i1
    %usb_osc_cal = llhd.sig %false : i1
    %aon_osc_cal = llhd.sig %false : i1
    %vcmpp_aon_sync_n = llhd.sig %false : i1
    %vcmain_pok_por_sys = llhd.sig %false : i1
    %hw2reg = llhd.sig %3 : !hw.struct<regal: !hw.struct<d: i32>>
    %regal_rst_n = llhd.sig %false : i1
    %10 = llhd.prb %regal_rst_n : i1
    %regal_we = llhd.sig %false : i1
    %regal = llhd.sig %c0_i32 : i32
    %regal_di = llhd.sig %c0_i32 : i32
    %u_clk_sys_buf.clk_o = hw.instance "u_clk_sys_buf" @prim_clock_buf(clk_i: %u_clk_src_sys_buf.clk_o: i1) -> (clk_o: i1) {sv.namehint = "clk_sys"}
    %u_clk_aon_buf.clk_o = hw.instance "u_clk_aon_buf" @prim_clock_buf(clk_i: %u_clk_src_aon_buf.clk_o: i1) -> (clk_o: i1) {sv.namehint = "clk_aon"}
    %u_vcc_pok.vcc_pok_o = hw.instance "u_vcc_pok" @vcc_pgd() -> (vcc_pok_o: i1) {sv.namehint = "vcc_pok_int"}
    %u_no_scan_poks_por_dasrt.q_o = hw.instance "u_no_scan_poks_por_dasrt" @prim_flop_2sync(clk_i: %u_clk_aon_buf.clk_o: i1, rst_ni: %60: i1, d_i: %61: i1) -> (q_o: i1) {sv.namehint = "vcaon_pok_por_src"}
    %u_clk_aon_inv.clk_no = hw.instance "u_clk_aon_inv" @prim_clock_inv(clk_i: %u_clk_aon_buf.clk_o: i1, scanmode_i: %false: i1) -> (clk_no: i1) {sv.namehint = "clk_aon_n"}
    %u_no_scan_por_sync_n.q_o = hw.instance "u_no_scan_por_sync_n" @prim_flop(clk_i: %u_clk_aon_inv.clk_no: i1, rst_ni: %59: i1, d_i: %u_no_scan_poks_por_dasrt.q_o: i1) -> (q_o: i1) {sv.namehint = "por_sync_n"}
    %u_vioa_pok.vio_pok_o = hw.instance "u_vioa_pok" @vio_pgd() -> (vio_pok_o: i1) {sv.namehint = "vioa_pok_int"}
    %u_viob_pok.vio_pok_o = hw.instance "u_viob_pok" @vio_pgd() -> (vio_pok_o: i1) {sv.namehint = "viob_pok_int"}
    %11 = llhd.prb %vcmain_pok_por_src : i1
    %12 = llhd.prb %ast_pwst_o : !hw.struct<aon_pok: i1, vcc_pok: i1, main_pok: i1, io_pok: i2>
    %io_pok = hw.struct_extract %12["io_pok"] : !hw.struct<aon_pok: i1, vcc_pok: i1, main_pok: i1, io_pok: i2>
    %13 = llhd.sig.struct_extract %ast_pwst_h_o["main_pok"] : <!hw.struct<aon_pok: i1, vcc_pok: i1, main_pok: i1, io_pok: i2>>
    %14 = llhd.sig.struct_extract %ast_pwst_h_o["aon_pok"] : <!hw.struct<aon_pok: i1, vcc_pok: i1, main_pok: i1, io_pok: i2>>
    %15 = llhd.sig.struct_extract %ast_pwst_h_o["io_pok"] : <!hw.struct<aon_pok: i1, vcc_pok: i1, main_pok: i1, io_pok: i2>>
    %16 = llhd.sig.struct_extract %ast_pwst_h_o["vcc_pok"] : <!hw.struct<aon_pok: i1, vcc_pok: i1, main_pok: i1, io_pok: i2>>
    %u_rglts_pdm_3p3v.rglssm_vmppr_h_o, %u_rglts_pdm_3p3v.rglssm_vcmon_h_o, %u_rglts_pdm_3p3v.rglssm_brout_h_o, %u_rglts_pdm_3p3v.vcmain_pok_h_o, %u_rglts_pdm_3p3v.vcmain_pok_por_h_o, %u_rglts_pdm_3p3v.vcaon_pok_h_o, %u_rglts_pdm_3p3v.vcaon_pok_1p1_h_o, %u_rglts_pdm_3p3v.vcaon_pok_por_h_o, %u_rglts_pdm_3p3v.vio_pok_h_o, %u_rglts_pdm_3p3v.vcc_pok_str_h_o, %u_rglts_pdm_3p3v.vcc_pok_str_1p1_h_o, %u_rglts_pdm_3p3v.deep_sleep_h_o, %u_rglts_pdm_3p3v.flash_power_down_h_o, %u_rglts_pdm_3p3v.flash_power_ready_h_o, %u_rglts_pdm_3p3v.otp_power_seq_h_o = hw.instance "u_rglts_pdm_3p3v" @rglts_pdm_3p3v(vcc_pok_h_i: %58: i1, vcaon_pok_por_h_i: %u_no_scan_poks_por_dasrt.q_o: i1, vcmain_pok_por_h_i: %11: i1, vio_pok_h_i: %io_pok: i2, clk_src_aon_h_i: %u_clk_aon_buf.clk_o: i1, main_pd_h_i: %73: i1, por_sync_h_i: %74: i1, scan_mode_h_i: %false: i1, otp_power_seq_h_i: %otp_power_seq_i: i2, vcaon_supp_i: %vcaon_supp_i: i1, vcmain_supp_i: %vcmain_supp_i: i1) -> (rglssm_vmppr_h_o: i1, rglssm_vcmon_h_o: i1, rglssm_brout_h_o: i1, vcmain_pok_h_o: i1, vcmain_pok_por_h_o: i1, vcaon_pok_h_o: i1, vcaon_pok_1p1_h_o: i1, vcaon_pok_por_h_o: i1, vio_pok_h_o: i2, vcc_pok_str_h_o: i1, vcc_pok_str_1p1_h_o: i1, deep_sleep_h_o: i1, flash_power_down_h_o: i1, flash_power_ready_h_o: i1, otp_power_seq_h_o: i2) {sv.namehint = "deep_sleep"}
    llhd.drv %13, %u_rglts_pdm_3p3v.vcmain_pok_por_h_o after %2 : i1
    llhd.drv %vcaon_pok, %u_rglts_pdm_3p3v.vcaon_pok_1p1_h_o after %2 : i1
    llhd.drv %14, %u_rglts_pdm_3p3v.vcaon_pok_por_h_o after %2 : i1
    llhd.drv %15, %u_rglts_pdm_3p3v.vio_pok_h_o after %2 : i2
    llhd.drv %16, %u_rglts_pdm_3p3v.vcc_pok_str_h_o after %2 : i1
    llhd.drv %otp_power_seq_h_o, %u_rglts_pdm_3p3v.otp_power_seq_h_o after %2 : i2
    %17 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%21) : (i4) -> i1
    %18 = llhd.prb %sys_io_osc_cal : i1
    %u_sys_clk.clk_src_sys_o, %u_sys_clk.clk_src_sys_val_o = hw.instance "u_sys_clk" @sys_clk(clk_src_sys_jen_i: %17: i1, clk_src_sys_en_i: %clk_src_sys_en_i: i1, clk_sys_pd_ni: %77: i1, rst_sys_clk_ni: %76: i1, vcore_pok_h_i: %u_rglts_pdm_3p3v.vcaon_pok_h_o: i1, scan_mode_i: %false: i1, sys_osc_cal_i: %18: i1) -> (clk_src_sys_o: i1, clk_src_sys_val_o: i1) {sv.namehint = "clk_osc_sys"}
    %19 = llhd.prb %usb_osc_cal : i1
    %u_usb_clk.clk_src_usb_o, %u_usb_clk.clk_src_usb_val_o = hw.instance "u_usb_clk" @usb_clk(vcore_pok_h_i: %u_rglts_pdm_3p3v.vcaon_pok_h_o: i1, clk_usb_pd_ni: %77: i1, rst_usb_clk_ni: %76: i1, clk_src_usb_en_i: %clk_src_usb_en_i: i1, usb_ref_val_i: %usb_ref_val_i: i1, usb_ref_pulse_i: %usb_ref_pulse_i: i1, clk_ast_usb_i: %clk_ast_usb_i: i1, rst_ast_usb_ni: %rst_ast_usb_ni: i1, scan_mode_i: %false: i1, usb_osc_cal_i: %19: i1) -> (clk_src_usb_o: i1, clk_src_usb_val_o: i1) {sv.namehint = "clk_osc_usb"}
    %20 = llhd.prb %aon_osc_cal : i1
    %u_aon_clk.clk_src_aon_o, %u_aon_clk.clk_src_aon_val_o = hw.instance "u_aon_clk" @aon_clk(vcore_pok_h_i: %u_rglts_pdm_3p3v.vcaon_pok_h_o: i1, clk_aon_pd_ni: %true: i1, rst_aon_clk_ni: %59: i1, clk_src_aon_en_i: %true: i1, scan_mode_i: %false: i1, aon_osc_cal_i: %20: i1) -> (clk_src_aon_o: i1, clk_src_aon_val_o: i1) {sv.namehint = "clk_osc_aon"}
    %u_rst_vcmpp_aon_dasrt.q_o = hw.instance "u_rst_vcmpp_aon_dasrt" @prim_flop_2sync(clk_i: %u_clk_aon_buf.clk_o: i1, rst_ni: %11: i1, d_i: %true: i1) -> (q_o: i1)
    llhd.drv %vcmpp_aon_sync_n, %u_rst_vcmpp_aon_dasrt.q_o after %2 : i1
    %u_io_clk.clk_src_io_o, %u_io_clk.clk_src_io_val_o = hw.instance "u_io_clk" @io_clk(vcore_pok_h_i: %u_rglts_pdm_3p3v.vcaon_pok_h_o: i1, clk_io_pd_ni: %77: i1, rst_io_clk_ni: %76: i1, clk_src_io_en_i: %clk_src_io_en_i: i1, scan_mode_i: %false: i1, io_osc_cal_i: %18: i1) -> (clk_src_io_o: i1, clk_src_io_val_o: i1) {sv.namehint = "clk_osc_io"}
    %u_ast_clks_byp.io_clk_byp_ack_o, %u_ast_clks_byp.all_clk_byp_ack_o, %u_ast_clks_byp.clk_src_sys_o, %u_ast_clks_byp.clk_src_sys_val_o, %u_ast_clks_byp.clk_src_io_o, %u_ast_clks_byp.clk_src_io_val_o, %u_ast_clks_byp.clk_src_io_48m_o, %u_ast_clks_byp.clk_src_usb_o, %u_ast_clks_byp.clk_src_usb_val_o, %u_ast_clks_byp.clk_src_aon_o, %u_ast_clks_byp.clk_src_aon_val_o = hw.instance "u_ast_clks_byp" @ast_clks_byp(vcaon_pok_i: %8: i1, vcaon_pok_por_i: %9: i1, deep_sleep_i: %u_rglts_pdm_3p3v.deep_sleep_h_o: i1, clk_src_sys_en_i: %clk_src_sys_en_i: i1, clk_osc_sys_i: %u_sys_clk.clk_src_sys_o: i1, clk_osc_sys_val_i: %u_sys_clk.clk_src_sys_val_o: i1, clk_src_io_en_i: %clk_src_io_en_i: i1, clk_osc_io_i: %u_io_clk.clk_src_io_o: i1, clk_osc_io_val_i: %u_io_clk.clk_src_io_val_o: i1, clk_src_usb_en_i: %clk_src_usb_en_i: i1, clk_osc_usb_i: %u_usb_clk.clk_src_usb_o: i1, clk_osc_usb_val_i: %u_usb_clk.clk_src_usb_val_o: i1, clk_osc_aon_i: %u_aon_clk.clk_src_aon_o: i1, clk_osc_aon_val_i: %u_aon_clk.clk_src_aon_val_o: i1, clk_ast_ext_i: %clk_ast_ext_i: i1, io_clk_byp_req_i: %io_clk_byp_req_i: i4, all_clk_byp_req_i: %all_clk_byp_req_i: i4, ext_freq_is_96m_i: %ext_freq_is_96m_i: i4) -> (io_clk_byp_ack_o: i4, all_clk_byp_ack_o: i4, clk_src_sys_o: i1, clk_src_sys_val_o: i1, clk_src_io_o: i1, clk_src_io_val_o: i1, clk_src_io_48m_o: i4, clk_src_usb_o: i1, clk_src_usb_val_o: i1, clk_src_aon_o: i1, clk_src_aon_val_o: i1) {sv.namehint = "clk_src_io"}
    %u_clk_src_sys_buf.clk_o = hw.instance "u_clk_src_sys_buf" @prim_clock_buf(clk_i: %u_ast_clks_byp.clk_src_sys_o: i1) -> (clk_o: i1)
    %u_clk_src_io_buf.clk_o = hw.instance "u_clk_src_io_buf" @prim_clock_buf(clk_i: %u_ast_clks_byp.clk_src_io_o: i1) -> (clk_o: i1)
    %u_clk_src_usb_buf.clk_o = hw.instance "u_clk_src_usb_buf" @prim_clock_buf(clk_i: %u_ast_clks_byp.clk_src_usb_o: i1) -> (clk_o: i1)
    %u_clk_src_aon_buf.clk_o = hw.instance "u_clk_src_aon_buf" @prim_clock_buf(clk_i: %u_ast_clks_byp.clk_src_aon_o: i1) -> (clk_o: i1)
    %u_adc.adc_d_o, %u_adc.adc_d_val_o = hw.instance "u_adc" @adc(adc_a0_ai: %adc_a0_ai: i1, adc_a1_ai: %adc_a1_ai: i1, adc_chnsel_i: %adc_chnsel_i: i2, adc_pd_i: %adc_pd_i: i1, clk_adc_i: %clk_ast_adc_i: i1, rst_adc_ni: %rst_ast_adc_ni: i1) -> (adc_d_o: i10, adc_d_val_o: i1)
    llhd.drv %adc_d_o, %u_adc.adc_d_o after %2 : i10
    %u_jitter_en_sync.mubi_o = hw.instance "u_jitter_en_sync" @prim_mubi4_sync(clk_i: %u_clk_sys_buf.clk_o: i1, rst_ni: %78: i1, mubi_i: %clk_src_sys_jen_i: i4) -> (mubi_o: !hw.array<1xi4>)
    %21 = hw.bitcast %u_jitter_en_sync.mubi_o {sv.namehint = "clk_src_sys_jen"} : (!hw.array<1xi4>) -> i4
    %u_rst_sys_dasrt.q_o = hw.instance "u_rst_sys_dasrt" @prim_flop_2sync(clk_i: %u_clk_sys_buf.clk_o: i1, rst_ni: %11: i1, d_i: %true: i1) -> (q_o: i1)
    llhd.drv %vcmain_pok_por_sys, %u_rst_sys_dasrt.q_o after %2 : i1
    %22 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%21) : (i4) -> i1
    %u_entropy.entropy_req_o = hw.instance "u_entropy" @ast_entropy(entropy_rsp_i: %entropy_rsp_i: !hw.struct<edn_ack: i1, edn_fips: i1, edn_bus: i32>, entropy_rate_i: %c5_i4: i4, clk_ast_es_i: %clk_ast_es_i: i1, rst_ast_es_ni: %rst_ast_es_ni: i1, clk_src_sys_i: %u_clk_sys_buf.clk_o: i1, rst_src_sys_ni: %78: i1, clk_src_sys_val_i: %u_ast_clks_byp.clk_src_sys_val_o: i1, clk_src_sys_jen_i: %22: i1) -> (entropy_req_o: !hw.struct<edn_req: i1>)
    %u_rng.rng_b_o, %u_rng.rng_val_o = hw.instance "u_rng" @rng(clk_i: %6: i1, rst_ni: %7: i1, clk_ast_rng_i: %clk_ast_rng_i: i1, rst_ast_rng_ni: %rst_ast_rng_ni: i1, rng_en_i: %rng_en_i: i1, rng_fips_i: %rng_fips_i: i1, scan_mode_i: %false: i1) -> (rng_b_o: i4, rng_val_o: i1)
    llhd.drv %rng_b_o, %u_rng.rng_b_o after %2 : i4
    %alerts_ack = hw.struct_extract %alert_rsp_i["alerts_ack"] : !hw.struct<alerts_ack: !hw.array<11xstruct<p: i1, n: i1>>, alerts_trig: !hw.array<11xstruct<p: i1, n: i1>>>
    %23 = hw.array_get %alerts_ack[%c0_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %alerts_trig = hw.struct_extract %alert_rsp_i["alerts_trig"] : !hw.struct<alerts_ack: !hw.array<11xstruct<p: i1, n: i1>>, alerts_trig: !hw.array<11xstruct<p: i1, n: i1>>>
    %24 = hw.array_get %alerts_trig[%c0_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %25 = llhd.sig.struct_extract %alert_req_o["alerts"] : <!hw.struct<alerts: !hw.array<11xstruct<p: i1, n: i1>>>>
    %26 = llhd.sig.array_get %25[%c0_i4] : <!hw.array<11xstruct<p: i1, n: i1>>>
    %u_alert_as.alert_req_o = hw.instance "u_alert_as" @ast_alert(clk_i: %clk_ast_alert_i: i1, rst_ni: %rst_ast_alert_ni: i1, alert_src_i: %0: !hw.struct<p: i1, n: i1>, alert_ack_i: %23: !hw.struct<p: i1, n: i1>, alert_trig_i: %24: !hw.struct<p: i1, n: i1>) -> (alert_req_o: !hw.struct<p: i1, n: i1>)
    llhd.drv %26, %u_alert_as.alert_req_o after %2 : !hw.struct<p: i1, n: i1>
    %27 = hw.array_get %alerts_ack[%c1_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %28 = hw.array_get %alerts_trig[%c1_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %29 = llhd.sig.array_get %25[%c1_i4] : <!hw.array<11xstruct<p: i1, n: i1>>>
    %u_alert_cg.alert_req_o = hw.instance "u_alert_cg" @ast_alert(clk_i: %clk_ast_alert_i: i1, rst_ni: %rst_ast_alert_ni: i1, alert_src_i: %0: !hw.struct<p: i1, n: i1>, alert_ack_i: %27: !hw.struct<p: i1, n: i1>, alert_trig_i: %28: !hw.struct<p: i1, n: i1>) -> (alert_req_o: !hw.struct<p: i1, n: i1>)
    llhd.drv %29, %u_alert_cg.alert_req_o after %2 : !hw.struct<p: i1, n: i1>
    %30 = hw.array_get %alerts_ack[%c2_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %31 = hw.array_get %alerts_trig[%c2_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %32 = llhd.sig.array_get %25[%c2_i4] : <!hw.array<11xstruct<p: i1, n: i1>>>
    %u_alert_gd.alert_req_o = hw.instance "u_alert_gd" @ast_alert(clk_i: %clk_ast_alert_i: i1, rst_ni: %rst_ast_alert_ni: i1, alert_src_i: %0: !hw.struct<p: i1, n: i1>, alert_ack_i: %30: !hw.struct<p: i1, n: i1>, alert_trig_i: %31: !hw.struct<p: i1, n: i1>) -> (alert_req_o: !hw.struct<p: i1, n: i1>)
    llhd.drv %32, %u_alert_gd.alert_req_o after %2 : !hw.struct<p: i1, n: i1>
    %33 = hw.array_get %alerts_ack[%c3_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %34 = hw.array_get %alerts_trig[%c3_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %35 = llhd.sig.array_get %25[%c3_i4] : <!hw.array<11xstruct<p: i1, n: i1>>>
    %u_alert_ts_hi.alert_req_o = hw.instance "u_alert_ts_hi" @ast_alert(clk_i: %clk_ast_alert_i: i1, rst_ni: %rst_ast_alert_ni: i1, alert_src_i: %0: !hw.struct<p: i1, n: i1>, alert_ack_i: %33: !hw.struct<p: i1, n: i1>, alert_trig_i: %34: !hw.struct<p: i1, n: i1>) -> (alert_req_o: !hw.struct<p: i1, n: i1>)
    llhd.drv %35, %u_alert_ts_hi.alert_req_o after %2 : !hw.struct<p: i1, n: i1>
    %36 = hw.array_get %alerts_ack[%c4_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %37 = hw.array_get %alerts_trig[%c4_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %38 = llhd.sig.array_get %25[%c4_i4] : <!hw.array<11xstruct<p: i1, n: i1>>>
    %u_alert_ts_lo.alert_req_o = hw.instance "u_alert_ts_lo" @ast_alert(clk_i: %clk_ast_alert_i: i1, rst_ni: %rst_ast_alert_ni: i1, alert_src_i: %0: !hw.struct<p: i1, n: i1>, alert_ack_i: %36: !hw.struct<p: i1, n: i1>, alert_trig_i: %37: !hw.struct<p: i1, n: i1>) -> (alert_req_o: !hw.struct<p: i1, n: i1>)
    llhd.drv %38, %u_alert_ts_lo.alert_req_o after %2 : !hw.struct<p: i1, n: i1>
    %39 = hw.array_get %alerts_ack[%c5_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %40 = hw.array_get %alerts_trig[%c5_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %41 = llhd.sig.array_get %25[%c5_i4] : <!hw.array<11xstruct<p: i1, n: i1>>>
    %u_alert_ot0.alert_req_o = hw.instance "u_alert_ot0" @ast_alert(clk_i: %clk_ast_alert_i: i1, rst_ni: %rst_ast_alert_ni: i1, alert_src_i: %83: !hw.struct<p: i1, n: i1>, alert_ack_i: %39: !hw.struct<p: i1, n: i1>, alert_trig_i: %40: !hw.struct<p: i1, n: i1>) -> (alert_req_o: !hw.struct<p: i1, n: i1>)
    llhd.drv %41, %u_alert_ot0.alert_req_o after %2 : !hw.struct<p: i1, n: i1>
    %42 = hw.array_get %alerts_ack[%c6_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %43 = hw.array_get %alerts_trig[%c6_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %44 = llhd.sig.array_get %25[%c6_i4] : <!hw.array<11xstruct<p: i1, n: i1>>>
    %u_alert_ot1.alert_req_o = hw.instance "u_alert_ot1" @ast_alert(clk_i: %clk_ast_alert_i: i1, rst_ni: %rst_ast_alert_ni: i1, alert_src_i: %0: !hw.struct<p: i1, n: i1>, alert_ack_i: %42: !hw.struct<p: i1, n: i1>, alert_trig_i: %43: !hw.struct<p: i1, n: i1>) -> (alert_req_o: !hw.struct<p: i1, n: i1>)
    llhd.drv %44, %u_alert_ot1.alert_req_o after %2 : !hw.struct<p: i1, n: i1>
    %45 = hw.array_get %alerts_ack[%c7_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %46 = hw.array_get %alerts_trig[%c7_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %47 = llhd.sig.array_get %25[%c7_i4] : <!hw.array<11xstruct<p: i1, n: i1>>>
    %u_alert_ot2.alert_req_o = hw.instance "u_alert_ot2" @ast_alert(clk_i: %clk_ast_alert_i: i1, rst_ni: %rst_ast_alert_ni: i1, alert_src_i: %0: !hw.struct<p: i1, n: i1>, alert_ack_i: %45: !hw.struct<p: i1, n: i1>, alert_trig_i: %46: !hw.struct<p: i1, n: i1>) -> (alert_req_o: !hw.struct<p: i1, n: i1>)
    llhd.drv %47, %u_alert_ot2.alert_req_o after %2 : !hw.struct<p: i1, n: i1>
    %48 = hw.array_get %alerts_ack[%c-8_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %49 = hw.array_get %alerts_trig[%c-8_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %50 = llhd.sig.array_get %25[%c-8_i4] : <!hw.array<11xstruct<p: i1, n: i1>>>
    %u_alert_ot3.alert_req_o = hw.instance "u_alert_ot3" @ast_alert(clk_i: %clk_ast_alert_i: i1, rst_ni: %rst_ast_alert_ni: i1, alert_src_i: %0: !hw.struct<p: i1, n: i1>, alert_ack_i: %48: !hw.struct<p: i1, n: i1>, alert_trig_i: %49: !hw.struct<p: i1, n: i1>) -> (alert_req_o: !hw.struct<p: i1, n: i1>)
    llhd.drv %50, %u_alert_ot3.alert_req_o after %2 : !hw.struct<p: i1, n: i1>
    %51 = hw.array_get %alerts_ack[%c-7_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %52 = hw.array_get %alerts_trig[%c-7_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %53 = llhd.sig.array_get %25[%c-7_i4] : <!hw.array<11xstruct<p: i1, n: i1>>>
    %u_alert_ot4.alert_req_o = hw.instance "u_alert_ot4" @ast_alert(clk_i: %clk_ast_alert_i: i1, rst_ni: %rst_ast_alert_ni: i1, alert_src_i: %0: !hw.struct<p: i1, n: i1>, alert_ack_i: %51: !hw.struct<p: i1, n: i1>, alert_trig_i: %52: !hw.struct<p: i1, n: i1>) -> (alert_req_o: !hw.struct<p: i1, n: i1>)
    llhd.drv %53, %u_alert_ot4.alert_req_o after %2 : !hw.struct<p: i1, n: i1>
    %54 = hw.array_get %alerts_ack[%c-6_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %55 = hw.array_get %alerts_trig[%c-6_i4] : !hw.array<11xstruct<p: i1, n: i1>>, i4
    %56 = llhd.sig.array_get %25[%c-6_i4] : <!hw.array<11xstruct<p: i1, n: i1>>>
    %u_alert_ot5.alert_req_o = hw.instance "u_alert_ot5" @ast_alert(clk_i: %clk_ast_alert_i: i1, rst_ni: %rst_ast_alert_ni: i1, alert_src_i: %0: !hw.struct<p: i1, n: i1>, alert_ack_i: %54: !hw.struct<p: i1, n: i1>, alert_trig_i: %55: !hw.struct<p: i1, n: i1>) -> (alert_req_o: !hw.struct<p: i1, n: i1>)
    llhd.drv %56, %u_alert_ot5.alert_req_o after %2 : !hw.struct<p: i1, n: i1>
    %57 = llhd.prb %hw2reg : !hw.struct<regal: !hw.struct<d: i32>>
    %u_reg.tl_o, %u_reg.reg2hw, %u_reg.intg_err_o = hw.instance "u_reg" @ast_reg_top(clk_i: %6: i1, rst_ni: %7: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, hw2reg: %57: !hw.struct<regal: !hw.struct<d: i32>>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, reg2hw: !hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>, intg_err_o: i1) {sv.namehint = "reg2hw"}
    %u_ast_dft.obs_ctrl_o, %u_ast_dft.ast2padmux_o, %u_ast_dft.dpram_rmf_o, %u_ast_dft.dpram_rml_o, %u_ast_dft.spram_rm_o, %u_ast_dft.sprgf_rm_o, %u_ast_dft.sprom_rm_o = hw.instance "u_ast_dft" @ast_dft() -> (obs_ctrl_o: !hw.struct<obgsl: i4, obmsl: i4, obmen: i4>, ast2padmux_o: i9, dpram_rmf_o: !hw.struct<test_a: i1, marg_en_a: i1, marg_a: i4, test_b: i1, marg_en_b: i1, marg_b: i4>, dpram_rml_o: !hw.struct<test_a: i1, marg_en_a: i1, marg_a: i4, test_b: i1, marg_en_b: i1, marg_b: i4>, spram_rm_o: !hw.struct<test: i1, marg_en: i1, marg: i4>, sprgf_rm_o: !hw.struct<test: i1, marg_en: i1, marg: i4>, sprom_rm_o: !hw.struct<test: i1, marg_en: i1, marg: i4>)
    llhd.drv %ast2padmux_o, %u_ast_dft.ast2padmux_o after %2 : i9
    llhd.drv %scan_reset_n, %true after %2 : i1
    %58 = comb.and %u_vcc_pok.vcc_pok_o, %vcc_supp_i {sv.namehint = "vcc_pok"} : i1
    %59 = comb.and %u_rglts_pdm_3p3v.vcc_pok_str_1p1_h_o, %8 {sv.namehint = "rst_poks_n"} : i1
    %60 = comb.and %59, %por_ni {sv.namehint = "rst_poks_por_n"} : i1
    %61 = comb.or %u_no_scan_poks_por_dasrt.q_o, %u_rglts_pdm_3p3v.rglssm_vcmon_h_o {sv.namehint = "poks_por_ack"} : i1
    %62 = comb.or %u_rglts_pdm_3p3v.rglssm_brout_h_o, %u_no_scan_por_sync_n.q_o : i1
    llhd.drv %vcaon_pok_por_lat, %62 after %2 : i1
    %63 = llhd.prb %vcaon_pok_por_lat : i1
    llhd.drv %vcaon_pok_por, %63 after %2 : i1
    %64 = llhd.sig.struct_extract %ast_pwst_o["aon_pok"] : <!hw.struct<aon_pok: i1, vcc_pok: i1, main_pok: i1, io_pok: i2>>
    llhd.drv %64, %9 after %2 : i1
    %65 = comb.xor %u_rglts_pdm_3p3v.rglssm_vmppr_h_o, %true : i1
    %66 = comb.and %63, %u_rglts_pdm_3p3v.vcmain_pok_h_o, %65 : i1
    llhd.drv %vcmain_pok_por_src, %66 after %2 : i1
    %67 = llhd.sig.struct_extract %ast_pwst_o["main_pok"] : <!hw.struct<aon_pok: i1, vcc_pok: i1, main_pok: i1, io_pok: i2>>
    llhd.drv %67, %11 after %2 : i1
    %68 = llhd.sig.struct_extract %ast_pwst_o["io_pok"] : <!hw.struct<aon_pok: i1, vcc_pok: i1, main_pok: i1, io_pok: i2>>
    %69 = llhd.sig.extract %68 from %false : <i2> -> <i1>
    %70 = comb.and %8, %u_vioa_pok.vio_pok_o, %vioa_supp_i : i1
    llhd.drv %69, %70 after %2 : i1
    %71 = llhd.sig.extract %68 from %true : <i2> -> <i1>
    %72 = comb.and %8, %u_viob_pok.vio_pok_o, %viob_supp_i : i1
    llhd.drv %71, %72 after %2 : i1
    %73 = comb.xor %main_pd_ni, %true {sv.namehint = "main_pd"} : i1
    %74 = comb.xor %u_no_scan_por_sync_n.q_o, %true {sv.namehint = "por_sync"} : i1
    %75 = llhd.sig.struct_extract %ast_pwst_o["vcc_pok"] : <!hw.struct<aon_pok: i1, vcc_pok: i1, main_pok: i1, io_pok: i2>>
    llhd.drv %75, %u_rglts_pdm_3p3v.vcc_pok_str_1p1_h_o after %2 : i1
    %76 = comb.and %11, %58 {sv.namehint = "rst_io_clk_n"} : i1
    %77 = comb.xor %u_rglts_pdm_3p3v.deep_sleep_h_o, %true : i1
    %78 = llhd.prb %vcmain_pok_por_sys : i1
    llhd.drv %regal_rst_n, %7 after %2 : i1
    %regal_2 = hw.struct_extract %u_reg.reg2hw["regal"] : !hw.struct<rega0: !hw.struct<q: i32>, rega1: !hw.struct<q: i32>, rega2: !hw.struct<q: i32>, rega3: !hw.struct<q: i32>, rega4: !hw.struct<q: i32>, rega5: !hw.struct<q: i32>, rega6: !hw.struct<q: i32>, rega7: !hw.struct<q: i32>, rega8: !hw.struct<q: i32>, rega9: !hw.struct<q: i32>, rega10: !hw.struct<q: i32>, rega11: !hw.struct<q: i32>, rega12: !hw.struct<q: i32>, rega13: !hw.struct<q: i32>, rega14: !hw.struct<q: i32>, rega15: !hw.struct<q: i32>, rega16: !hw.struct<q: i32>, rega17: !hw.struct<q: i32>, rega18: !hw.struct<q: i32>, rega19: !hw.struct<q: i32>, rega20: !hw.struct<q: i32>, rega21: !hw.struct<q: i32>, rega22: !hw.struct<q: i32>, rega23: !hw.struct<q: i32>, rega24: !hw.struct<q: i32>, rega25: !hw.struct<q: i32>, rega26: !hw.struct<q: i32>, rega27: !hw.struct<q: i32>, rega28: !hw.struct<q: i32>, rega29: !hw.struct<q: i32>, rega30: !hw.struct<q: i32>, rega31: !hw.struct<q: i32>, rega32: !hw.struct<q: i32>, rega33: !hw.struct<q: i32>, rega34: !hw.struct<q: i32>, rega35: !hw.struct<q: i32>, rega36: !hw.struct<q: i32>, rega37: !hw.struct<q: i32>, regal: !hw.struct<q: i32, qe: i1>, regb: !hw.array<5xstruct<q: i32>>>
    %qe = hw.struct_extract %regal_2["qe"] : !hw.struct<q: i32, qe: i1>
    llhd.drv %regal_we, %qe after %2 : i1
    %q = hw.struct_extract %regal_2["q"] : !hw.struct<q: i32, qe: i1>
    llhd.drv %regal_di, %q after %2 : i32
    %79 = llhd.sig.struct_extract %hw2reg["regal"] : <!hw.struct<regal: !hw.struct<d: i32>>>
    %80 = llhd.sig.struct_extract %79["d"] : <!hw.struct<d: i32>>
    %81 = llhd.prb %regal : i32
    llhd.drv %80, %81 after %2 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %91 = llhd.prb %clk_ast_tlul_i_0 : i1
      %92 = llhd.prb %regal_rst_n : i1
      llhd.wait (%6, %10 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %93 = llhd.prb %clk_ast_tlul_i_0 : i1
      %94 = comb.xor bin %91, %true : i1
      %95 = comb.and bin %94, %93 : i1
      %96 = llhd.prb %regal_rst_n : i1
      %97 = comb.xor bin %96, %true : i1
      %98 = comb.and bin %92, %97 : i1
      %99 = comb.or bin %95, %98 : i1
      cf.cond_br %99, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %100 = llhd.prb %regal_rst_n : i1
      %101 = comb.xor %100, %true : i1
      cf.cond_br %101, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %regal, %c38_i32 after %1 : i32
      llhd.drv %ast_init_done_o, %c-7_i4 after %1 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %102 = llhd.prb %regal_we : i1
      cf.cond_br %102, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %103 = llhd.prb %regal_di : i32
      llhd.drv %regal, %103 after %1 : i32
      llhd.drv %ast_init_done_o, %c6_i4 after %1 : i4
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %91 = llhd.prb %clk_ast_tlul_i_0 : i1
      %92 = llhd.prb %rst_ast_tlul_ni_1 : i1
      llhd.wait (%6, %7 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %93 = llhd.prb %clk_ast_tlul_i_0 : i1
      %94 = comb.xor bin %91, %true : i1
      %95 = comb.and bin %94, %93 : i1
      %96 = llhd.prb %rst_ast_tlul_ni_1 : i1
      %97 = comb.xor bin %96, %true : i1
      %98 = comb.and bin %92, %97 : i1
      %99 = comb.or bin %95, %98 : i1
      cf.cond_br %99, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %100 = llhd.prb %rst_ast_tlul_ni_1 : i1
      %101 = comb.xor %100, %true : i1
      cf.cond_br %101, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %sys_io_osc_cal, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %102 = llhd.prb %regal_we : i1
      cf.cond_br %102, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %sys_io_osc_cal, %true after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %91 = llhd.prb %clk_ast_tlul_i_0 : i1
      %92 = llhd.prb %vcaon_pok_por : i1
      llhd.wait (%6, %9 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %93 = llhd.prb %clk_ast_tlul_i_0 : i1
      %94 = comb.xor bin %91, %true : i1
      %95 = comb.and bin %94, %93 : i1
      %96 = llhd.prb %vcaon_pok_por : i1
      %97 = comb.xor bin %96, %true : i1
      %98 = comb.and bin %92, %97 : i1
      %99 = comb.or bin %95, %98 : i1
      cf.cond_br %99, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %100 = llhd.prb %vcaon_pok_por : i1
      %101 = comb.xor %100, %true : i1
      cf.cond_br %101, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %usb_osc_cal, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %102 = llhd.prb %regal_we : i1
      cf.cond_br %102, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %usb_osc_cal, %true after %1 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %91 = llhd.prb %clk_ast_tlul_i_0 : i1
      %92 = llhd.prb %vcaon_pok : i1
      llhd.wait (%6, %8 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %93 = llhd.prb %clk_ast_tlul_i_0 : i1
      %94 = comb.xor bin %91, %true : i1
      %95 = comb.and bin %94, %93 : i1
      %96 = llhd.prb %vcaon_pok : i1
      %97 = comb.xor bin %96, %true : i1
      %98 = comb.and bin %92, %97 : i1
      %99 = comb.or bin %95, %98 : i1
      cf.cond_br %99, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %100 = llhd.prb %vcaon_pok : i1
      %101 = comb.xor %100, %true : i1
      cf.cond_br %101, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %aon_osc_cal, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %102 = llhd.prb %regal_we : i1
      cf.cond_br %102, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %aon_osc_cal, %true after %1 : i1
      cf.br ^bb1
    }
    %82 = comb.xor %u_reg.intg_err_o, %true : i1
    %83 = hw.struct_create (%u_reg.intg_err_o, %82) {sv.namehint = "ot0_alert_src"} : !hw.struct<p: i1, n: i1>
    %84 = llhd.prb %ast_init_done_o : i4
    llhd.drv %clk_ast_tlul_i_0, %clk_ast_tlul_i after %2 : i1
    llhd.drv %rst_ast_tlul_ni_1, %rst_ast_tlul_ni after %2 : i1
    %85 = llhd.prb %ast_pwst_h_o : !hw.struct<aon_pok: i1, vcc_pok: i1, main_pok: i1, io_pok: i2>
    %86 = llhd.prb %otp_power_seq_h_o : i2
    %87 = llhd.prb %adc_d_o : i10
    %88 = llhd.prb %rng_b_o : i4
    %89 = llhd.prb %alert_req_o : !hw.struct<alerts: !hw.array<11xstruct<p: i1, n: i1>>>
    %90 = llhd.prb %ast2padmux_o : i9
    hw.output %u_reg.tl_o, %84, %12, %85, %u_rglts_pdm_3p3v.flash_power_down_h_o, %u_rglts_pdm_3p3v.flash_power_ready_h_o, %86, %u_clk_src_sys_buf.clk_o, %u_ast_clks_byp.clk_src_sys_val_o, %u_clk_src_aon_buf.clk_o, %u_ast_clks_byp.clk_src_aon_val_o, %u_clk_src_io_buf.clk_o, %u_ast_clks_byp.clk_src_io_val_o, %u_ast_clks_byp.clk_src_io_48m_o, %u_clk_src_usb_buf.clk_o, %u_ast_clks_byp.clk_src_usb_val_o, %c1024_i20, %87, %u_adc.adc_d_val_o, %u_rng.rng_val_o, %88, %u_entropy.entropy_req_o, %89, %u_ast_dft.obs_ctrl_o, %90, %c0_i4, %false, %false, %u_ast_clks_byp.all_clk_byp_ack_o, %u_ast_clks_byp.io_clk_byp_ack_o, %c-7_i4, %u_ast_dft.dpram_rmf_o, %u_ast_dft.dpram_rml_o, %u_ast_dft.spram_rm_o, %u_ast_dft.sprgf_rm_o, %u_ast_dft.sprom_rm_o, %c-7_i4, %false, %true : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, i4, !hw.struct<aon_pok: i1, vcc_pok: i1, main_pok: i1, io_pok: i2>, !hw.struct<aon_pok: i1, vcc_pok: i1, main_pok: i1, io_pok: i2>, i1, i1, i2, i1, i1, i1, i1, i1, i1, i4, i1, i1, i20, i10, i1, i1, i4, !hw.struct<edn_req: i1>, !hw.struct<alerts: !hw.array<11xstruct<p: i1, n: i1>>>, !hw.struct<obgsl: i4, obmsl: i4, obmen: i4>, i9, i4, i1, i1, i4, i4, i4, !hw.struct<test_a: i1, marg_en_a: i1, marg_a: i4, test_b: i1, marg_en_b: i1, marg_b: i4>, !hw.struct<test_a: i1, marg_en_a: i1, marg_a: i4, test_b: i1, marg_en_b: i1, marg_b: i4>, !hw.struct<test: i1, marg_en: i1, marg: i4>, !hw.struct<test: i1, marg_en: i1, marg: i4>, !hw.struct<test: i1, marg_en: i1, marg: i4>, i4, i1, i1
  }
  hw.module private @dev_entropy(in %clk_i : i1, in %rst_ni : i1, in %clk_dev_i : i1, in %rst_dev_ni : i1, in %dev_en_i : i1, in %dev_rate_i : i4, in %dev_ack_i : i1, in %dev_data_i : i32, out dev_wready_o : i1, out dev_data_o : i1) {
    %c-1_i16 = hw.constant -1 : i16
    %c0_i28 = hw.constant 0 : i28
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i6 = hw.constant 0 : i6
    %c0_i4 = hw.constant 0 : i4
    %c0_i16 = hw.constant 0 : i16
    %c1_i32 = hw.constant 1 : i32
    %c0_i32 = hw.constant 0 : i32
    %c1_i7 = hw.constant 1 : i7
    %c-64_i7 = hw.constant -64 : i7
    %c0_i7 = hw.constant 0 : i7
    %false = hw.constant false
    %true = hw.constant true
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %clk_dev_i_2 = llhd.sig name "clk_dev_i" %false : i1
    %4 = llhd.prb %clk_dev_i_2 : i1
    %rst_dev_ni_3 = llhd.sig name "rst_dev_ni" %false : i1
    %5 = llhd.prb %rst_dev_ni_3 : i1
    %dev_ack_i_4 = llhd.sig name "dev_ack_i" %false : i1
    %dev_data_i_5 = llhd.sig name "dev_data_i" %c0_i32 : i32
    %fast_start = llhd.sig %false : i1
    %rate_pulse = llhd.sig %false : i1
    %rready = llhd.sig %false : i1
    %fast_cnt = llhd.sig %c0_i7 : i7
    %erate_cnt = llhd.sig %c0_i16 : i16
    %dev_rate = llhd.sig %c0_i16 : i16
    %dev_rate_sync = llhd.sig %c0_i4 : i4
    %wdata = llhd.sig %c0_i32 : i32
    %wready_dev = llhd.sig %false : i1
    %wready_es = llhd.sig %false : i1
    %wready_es_d = llhd.sig %false : i1
    %wdata_val = llhd.sig %false : i1
    %set_wdata_val = llhd.sig %false : i1
    %clr_wdata_val = llhd.sig %false : i1
    %rst_es_dev_n = llhd.sig %false : i1
    %6 = llhd.prb %rst_es_dev_n : i1
    %set_wready_dev = llhd.sig %false : i1
    %clr_wready_dev = llhd.sig %false : i1
    %wvalid = llhd.sig %false : i1
    %set_wvalid = llhd.sig %false : i1
    %clr_wvalid = llhd.sig %false : i1
    %depth = llhd.sig %c0_i6 : i6
    %u_dev_en_dev_sync.q_o = hw.instance "u_dev_en_dev_sync" @prim_flop_2sync(clk_i: %4: i1, rst_ni: %5: i1, d_i: %dev_en_i: i1) -> (q_o: i1) {sv.namehint = "dev_en_dev"}
    %u_erate_sync.data_o = hw.instance "u_erate_sync" @prim_multibit_sync(clk_i: %4: i1, rst_ni: %5: i1, data_i: %dev_rate_i: i4) -> (data_o: i4)
    llhd.drv %dev_rate_sync, %u_erate_sync.data_o after %1 : i4
    %7 = llhd.prb %wready_dev : i1
    %u_wvalid_es_sync.q_o = hw.instance "u_wvalid_es_sync" @prim_flop_2sync(clk_i: %2: i1, rst_ni: %3: i1, d_i: %7: i1) -> (q_o: i1)
    llhd.drv %wready_es, %u_wvalid_es_sync.q_o after %1 : i1
    %u_rst_es_n_da.q_o = hw.instance "u_rst_es_n_da" @prim_flop_2sync(clk_i: %4: i1, rst_ni: %29: i1, d_i: %true: i1) -> (q_o: i1) {sv.namehint = "rst_es_dev_da_n"}
    %8 = llhd.prb %wready_es : i1
    %u_wready_es_dev_sync.q_o = hw.instance "u_wready_es_dev_sync" @prim_flop_2sync(clk_i: %4: i1, rst_ni: %6: i1, d_i: %8: i1) -> (q_o: i1) {sv.namehint = "wready_es_dev"}
    %9 = llhd.prb %wdata_val : i1
    %u_wvalid_dev_sync.q_o = hw.instance "u_wvalid_dev_sync" @prim_flop_2sync(clk_i: %4: i1, rst_ni: %6: i1, d_i: %9: i1) -> (q_o: i1) {sv.namehint = "wdata_val_dev"}
    %10 = llhd.prb %wvalid : i1
    %11 = llhd.prb %wdata : i32
    %12 = llhd.prb %rready : i1
    %u_dev_fifo.wready_o, %u_dev_fifo.rvalid_o, %u_dev_fifo.rdata_o, %u_dev_fifo.depth_o = hw.instance "u_dev_fifo" @prim_packer_fifo(clk_i: %4: i1, rst_ni: %5: i1, clr_i: %false: i1, wvalid_i: %10: i1, wdata_i: %11: i32, rready_i: %12: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i1, depth_o: i6) {sv.namehint = "rdata"}
    llhd.drv %depth, %u_dev_fifo.depth_o after %1 : i6
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %39 = llhd.prb %clk_dev_i_2 : i1
      %40 = llhd.prb %rst_dev_ni_3 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %41 = llhd.prb %clk_dev_i_2 : i1
      %42 = comb.xor bin %39, %true : i1
      %43 = comb.and bin %42, %41 : i1
      %44 = llhd.prb %rst_dev_ni_3 : i1
      %45 = comb.xor bin %44, %true : i1
      %46 = comb.and bin %40, %45 : i1
      %47 = comb.or bin %43, %46 : i1
      cf.cond_br %47, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %48 = llhd.prb %rst_dev_ni_3 : i1
      %49 = comb.xor %48, %true : i1
      cf.cond_br %49, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %fast_start, %true after %0 : i1
      llhd.drv %fast_cnt, %c0_i7 after %0 : i7
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %50 = llhd.prb %fast_cnt : i7
      %51 = comb.icmp eq %50, %c-64_i7 : i7
      cf.cond_br %51, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %fast_start, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %52 = llhd.prb %fast_start : i1
      %53 = llhd.prb %rready : i1
      %54 = comb.and %52, %53 : i1
      cf.cond_br %54, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %55 = llhd.prb %fast_cnt : i7
      %56 = comb.add %55, %c1_i7 : i7
      llhd.drv %fast_cnt, %56 after %0 : i7
      cf.br ^bb1
    }
    %13 = llhd.prb %fast_start : i1
    %14 = llhd.prb %dev_rate_sync : i4
    %15 = comb.concat %c0_i28, %14 : i28, i4
    %16 = comb.shl %c1_i32, %15 : i32
    %17 = comb.extract %16 from 0 : (i32) -> i16
    %18 = comb.add %17, %c-1_i16 : i16
    %19 = comb.mux %13, %c0_i16, %18 : i16
    llhd.drv %dev_rate, %19 after %1 : i16
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %39 = llhd.prb %clk_dev_i_2 : i1
      %40 = llhd.prb %rst_dev_ni_3 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %41 = llhd.prb %clk_dev_i_2 : i1
      %42 = comb.xor bin %39, %true : i1
      %43 = comb.and bin %42, %41 : i1
      %44 = llhd.prb %rst_dev_ni_3 : i1
      %45 = comb.xor bin %44, %true : i1
      %46 = comb.and bin %40, %45 : i1
      %47 = comb.or bin %43, %46 : i1
      cf.cond_br %47, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %48 = llhd.prb %rst_dev_ni_3 : i1
      %49 = comb.xor %48, %true : i1
      cf.cond_br %49, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %erate_cnt, %c0_i16 after %0 : i16
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %50 = llhd.prb %rate_pulse : i1
      cf.cond_br %50, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %51 = llhd.prb %dev_rate : i16
      llhd.drv %erate_cnt, %51 after %0 : i16
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %52 = llhd.prb %erate_cnt : i16
      %53 = comb.icmp ne %52, %c0_i16 : i16
      cf.cond_br %53, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %54 = llhd.prb %erate_cnt : i16
      %55 = comb.add %54, %c-1_i16 : i16
      llhd.drv %erate_cnt, %55 after %0 : i16
      cf.br ^bb1
    }
    %20 = llhd.prb %erate_cnt : i16
    %21 = comb.icmp eq %20, %c0_i16 : i16
    %22 = comb.and %21, %u_dev_en_dev_sync.q_o : i1
    llhd.drv %rate_pulse, %22 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
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
      llhd.drv %wdata, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %50 = llhd.prb %dev_ack_i_4 : i1
      cf.cond_br %50, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %51 = llhd.prb %dev_data_i_5 : i32
      llhd.drv %wdata, %51 after %0 : i32
      cf.br ^bb1
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
      llhd.drv %wready_es_d, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %50 = llhd.prb %wready_es : i1
      llhd.drv %wready_es_d, %50 after %0 : i1
      cf.br ^bb1
    }
    %23 = comb.xor %8, %true : i1
    %24 = llhd.prb %wready_es_d : i1
    %25 = comb.xor %9, %true : i1
    %26 = llhd.prb %dev_ack_i_4 : i1
    %27 = comb.and %25, %26 : i1
    llhd.drv %set_wdata_val, %27 after %1 : i1
    %28 = comb.and %9, %23, %24 : i1
    llhd.drv %clr_wdata_val, %28 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
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
      llhd.drv %wdata_val, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %50 = llhd.prb %set_wdata_val : i1
      cf.cond_br %50, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %wdata_val, %true after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %51 = llhd.prb %clr_wdata_val : i1
      cf.cond_br %51, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %wdata_val, %false after %0 : i1
      cf.br ^bb1
    }
    %29 = comb.and %3, %5 {sv.namehint = "rst_es_dev_in_n"} : i1
    llhd.drv %rst_es_dev_n, %u_rst_es_n_da.q_o after %1 : i1
    %30 = comb.xor %7, %true : i1
    %31 = comb.and %30, %u_dev_fifo.wready_o : i1
    llhd.drv %set_wready_dev, %31 after %1 : i1
    %32 = comb.xor %u_dev_fifo.wready_o, %true : i1
    %33 = comb.and %7, %32, %u_wready_es_dev_sync.q_o : i1
    llhd.drv %clr_wready_dev, %33 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %39 = llhd.prb %clk_dev_i_2 : i1
      %40 = llhd.prb %rst_es_dev_n : i1
      llhd.wait (%4, %6 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %41 = llhd.prb %clk_dev_i_2 : i1
      %42 = comb.xor bin %39, %true : i1
      %43 = comb.and bin %42, %41 : i1
      %44 = llhd.prb %rst_es_dev_n : i1
      %45 = comb.xor bin %44, %true : i1
      %46 = comb.and bin %40, %45 : i1
      %47 = comb.or bin %43, %46 : i1
      cf.cond_br %47, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %48 = llhd.prb %rst_es_dev_n : i1
      %49 = comb.xor %48, %true : i1
      cf.cond_br %49, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %wready_dev, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %50 = llhd.prb %set_wready_dev : i1
      cf.cond_br %50, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %wready_dev, %true after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %51 = llhd.prb %clr_wready_dev : i1
      cf.cond_br %51, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %wready_dev, %false after %0 : i1
      cf.br ^bb1
    }
    %34 = comb.xor %10, %true : i1
    %35 = comb.and %34, %u_dev_fifo.wready_o, %u_wvalid_dev_sync.q_o : i1
    llhd.drv %set_wvalid, %35 after %1 : i1
    llhd.drv %clr_wvalid, %10 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %39 = llhd.prb %clk_dev_i_2 : i1
      %40 = llhd.prb %rst_es_dev_n : i1
      llhd.wait (%4, %6 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %41 = llhd.prb %clk_dev_i_2 : i1
      %42 = comb.xor bin %39, %true : i1
      %43 = comb.and bin %42, %41 : i1
      %44 = llhd.prb %rst_es_dev_n : i1
      %45 = comb.xor bin %44, %true : i1
      %46 = comb.and bin %40, %45 : i1
      %47 = comb.or bin %43, %46 : i1
      cf.cond_br %47, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %48 = llhd.prb %rst_es_dev_n : i1
      %49 = comb.xor %48, %true : i1
      cf.cond_br %49, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %wvalid, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %50 = llhd.prb %set_wvalid : i1
      cf.cond_br %50, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %wvalid, %true after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %51 = llhd.prb %clr_wvalid : i1
      cf.cond_br %51, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %wvalid, %false after %0 : i1
      cf.br ^bb1
    }
    %36 = llhd.prb %rate_pulse : i1
    %37 = comb.and %u_dev_fifo.rvalid_o, %36 : i1
    llhd.drv %rready, %37 after %1 : i1
    %38 = comb.and %u_dev_fifo.rdata_o, %36 : i1
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %clk_dev_i_2, %clk_dev_i after %1 : i1
    llhd.drv %rst_dev_ni_3, %rst_dev_ni after %1 : i1
    llhd.drv %dev_ack_i_4, %dev_ack_i after %1 : i1
    llhd.drv %dev_data_i_5, %dev_data_i after %1 : i32
    hw.output %25, %38 : i1, i1
  }
  hw.module private @gfr_clk_mux2(in %clk_osc_i : i1, in %clk_osc_val_i : i1, in %rst_clk_osc_ni : i1, in %clk_ext_i : i1, in %clk_ext_val_i : i1, in %rst_clk_ext_ni : i1, in %ext_sel_i : i1, out clk_osc_en_o : i1, out clk_ext_en_o : i1, out clk_val_o : i1, out clk_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %true = hw.constant true
    %false = hw.constant false
    %clk_osc_i_0 = llhd.sig name "clk_osc_i" %false : i1
    %2 = llhd.prb %clk_osc_i_0 : i1
    %clk_osc_val_i_1 = llhd.sig name "clk_osc_val_i" %false : i1
    %rst_clk_osc_ni_2 = llhd.sig name "rst_clk_osc_ni" %false : i1
    %3 = llhd.prb %rst_clk_osc_ni_2 : i1
    %clk_ext_i_3 = llhd.sig name "clk_ext_i" %false : i1
    %4 = llhd.prb %clk_ext_i_3 : i1
    %clk_ext_val_i_4 = llhd.sig name "clk_ext_val_i" %false : i1
    %rst_clk_ext_ni_5 = llhd.sig name "rst_clk_ext_ni" %false : i1
    %5 = llhd.prb %rst_clk_ext_ni_5 : i1
    %ext_sel_i_6 = llhd.sig name "ext_sel_i" %false : i1
    %clk_ext_en_o = llhd.sig %false : i1
    %clks_aoff = llhd.sig %false : i1
    %clk_osc_en_q = llhd.sig %false : i1
    %clk_ext_en_q = llhd.sig %false : i1
    %clk_osc_sel = llhd.sig %false : i1
    %clk_osc_aoff = llhd.sig %false : i1
    %clk_ext_sel = llhd.sig %false : i1
    %clk_ext_aoff = llhd.sig %false : i1
    %u_clk_osc_ckgt.clk_o = hw.instance "u_clk_osc_ckgt" @prim_clock_gating(clk_i: %2: i1, en_i: %14: i1, test_en_i: %false: i1) -> (clk_o: i1) {sv.namehint = "clk_osc"}
    %6 = llhd.prb %clk_ext_en_o : i1
    %u_clk_byp_ckgt.clk_o = hw.instance "u_clk_byp_ckgt" @prim_clock_gating(clk_i: %4: i1, en_i: %6: i1, test_en_i: %false: i1) -> (clk_o: i1) {sv.namehint = "clk_ext"}
    %7 = llhd.prb %clk_osc_en_q : i1
    %8 = llhd.prb %clk_ext_en_q : i1
    %9 = comb.or %7, %8 : i1
    %10 = comb.xor %9, %true : i1
    llhd.drv %clks_aoff, %10 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %24 = llhd.prb %clk_osc_i_0 : i1
      %25 = llhd.prb %rst_clk_osc_ni_2 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %26 = llhd.prb %clk_osc_i_0 : i1
      %27 = comb.xor bin %24, %true : i1
      %28 = comb.and bin %27, %26 : i1
      %29 = llhd.prb %rst_clk_osc_ni_2 : i1
      %30 = comb.xor bin %29, %true : i1
      %31 = comb.and bin %25, %30 : i1
      %32 = comb.or bin %28, %31 : i1
      cf.cond_br %32, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %33 = llhd.prb %rst_clk_osc_ni_2 : i1
      %34 = comb.xor %33, %true : i1
      cf.cond_br %34, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %clk_osc_sel, %false after %0 : i1
      llhd.drv %clk_osc_aoff, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %35 = llhd.prb %ext_sel_i_6 : i1
      %36 = comb.xor %35, %true : i1
      llhd.drv %clk_osc_sel, %36 after %0 : i1
      %37 = llhd.prb %clks_aoff : i1
      llhd.drv %clk_osc_aoff, %37 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %24 = llhd.prb %clk_osc_i_0 : i1
      %25 = llhd.prb %rst_clk_osc_ni_2 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %26 = llhd.prb %clk_osc_i_0 : i1
      %27 = comb.xor bin %24, %true : i1
      %28 = comb.and bin %27, %26 : i1
      %29 = llhd.prb %rst_clk_osc_ni_2 : i1
      %30 = comb.xor bin %29, %true : i1
      %31 = comb.and bin %25, %30 : i1
      %32 = comb.or bin %28, %31 : i1
      cf.cond_br %32, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %33 = llhd.prb %rst_clk_osc_ni_2 : i1
      %34 = comb.xor %33, %true : i1
      cf.cond_br %34, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %clk_osc_en_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %35 = llhd.prb %clk_osc_sel : i1
      %36 = comb.xor %35, %true : i1
      cf.cond_br %36, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %clk_osc_en_q, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %37 = llhd.prb %clk_osc_sel : i1
      %38 = llhd.prb %clk_osc_aoff : i1
      %39 = comb.and %37, %38 : i1
      cf.cond_br %39, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %clk_osc_en_q, %true after %0 : i1
      cf.br ^bb1
    }
    %11 = llhd.prb %clk_osc_sel : i1
    %12 = llhd.prb %clk_osc_aoff : i1
    %13 = comb.or %7, %12 : i1
    %14 = comb.and %11, %13 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %24 = llhd.prb %clk_ext_i_3 : i1
      %25 = llhd.prb %rst_clk_ext_ni_5 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %26 = llhd.prb %clk_ext_i_3 : i1
      %27 = comb.xor bin %24, %true : i1
      %28 = comb.and bin %27, %26 : i1
      %29 = llhd.prb %rst_clk_ext_ni_5 : i1
      %30 = comb.xor bin %29, %true : i1
      %31 = comb.and bin %25, %30 : i1
      %32 = comb.or bin %28, %31 : i1
      cf.cond_br %32, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %33 = llhd.prb %rst_clk_ext_ni_5 : i1
      %34 = comb.xor %33, %true : i1
      cf.cond_br %34, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %clk_ext_sel, %false after %0 : i1
      llhd.drv %clk_ext_aoff, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %35 = llhd.prb %ext_sel_i_6 : i1
      llhd.drv %clk_ext_sel, %35 after %0 : i1
      %36 = llhd.prb %clks_aoff : i1
      llhd.drv %clk_ext_aoff, %36 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %24 = llhd.prb %clk_ext_i_3 : i1
      %25 = llhd.prb %rst_clk_ext_ni_5 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %26 = llhd.prb %clk_ext_i_3 : i1
      %27 = comb.xor bin %24, %true : i1
      %28 = comb.and bin %27, %26 : i1
      %29 = llhd.prb %rst_clk_ext_ni_5 : i1
      %30 = comb.xor bin %29, %true : i1
      %31 = comb.and bin %25, %30 : i1
      %32 = comb.or bin %28, %31 : i1
      cf.cond_br %32, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %33 = llhd.prb %rst_clk_ext_ni_5 : i1
      %34 = comb.xor %33, %true : i1
      cf.cond_br %34, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %clk_ext_en_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %35 = llhd.prb %clk_ext_sel : i1
      %36 = comb.xor %35, %true : i1
      cf.cond_br %36, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %clk_ext_en_q, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %37 = llhd.prb %clk_ext_sel : i1
      %38 = llhd.prb %clk_ext_aoff : i1
      %39 = comb.and %37, %38 : i1
      cf.cond_br %39, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %clk_ext_en_q, %true after %0 : i1
      cf.br ^bb1
    }
    %15 = llhd.prb %clk_ext_sel : i1
    %16 = llhd.prb %clk_ext_aoff : i1
    %17 = comb.or %8, %16 : i1
    %18 = comb.and %15, %17 : i1
    llhd.drv %clk_ext_en_o, %18 after %1 : i1
    %19 = comb.or %u_clk_osc_ckgt.clk_o, %u_clk_byp_ckgt.clk_o : i1
    %20 = llhd.prb %clk_osc_val_i_1 : i1
    %21 = llhd.prb %clk_ext_val_i_4 : i1
    %22 = comb.and %6, %21 : i1
    %23 = comb.mux %14, %20, %22 : i1
    llhd.drv %clk_osc_i_0, %clk_osc_i after %1 : i1
    llhd.drv %clk_osc_val_i_1, %clk_osc_val_i after %1 : i1
    llhd.drv %rst_clk_osc_ni_2, %rst_clk_osc_ni after %1 : i1
    llhd.drv %clk_ext_i_3, %clk_ext_i after %1 : i1
    llhd.drv %clk_ext_val_i_4, %clk_ext_val_i after %1 : i1
    llhd.drv %rst_clk_ext_ni_5, %rst_clk_ext_ni after %1 : i1
    llhd.drv %ext_sel_i_6, %ext_sel_i after %1 : i1
    hw.output %14, %6, %23, %19 : i1, i1, i1, i1
  }
  hw.module private @io_clk(in %vcore_pok_h_i : i1, in %clk_io_pd_ni : i1, in %rst_io_clk_ni : i1, in %clk_src_io_en_i : i1, in %scan_mode_i : i1, in %io_osc_cal_i : i1, out clk_src_io_o : i1, out clk_src_io_val_o : i1) {
    %true = hw.constant true
    %u_io_osc.io_clk_o = hw.instance "u_io_osc" @io_osc(vcore_pok_h_i: %vcore_pok_h_i: i1, io_en_i: %1: i1, io_osc_cal_i: %io_osc_cal_i: i1) -> (io_clk_o: i1) {sv.namehint = "clk"}
    %u_clk_io_buf.clk_o = hw.instance "u_clk_io_buf" @prim_clock_buf(clk_i: %u_io_osc.io_clk_o: i1) -> (clk_o: i1)
    %u_no_scan_val_sync.q_o = hw.instance "u_no_scan_val_sync" @prim_flop_2sync(clk_i: %u_clk_io_buf.clk_o: i1, rst_ni: %1: i1, d_i: %true: i1) -> (q_o: i1)
    %0 = comb.and %clk_src_io_en_i, %clk_io_pd_ni, %rst_io_clk_ni {sv.namehint = "osc_en"} : i1
    %1 = comb.or %scan_mode_i, %0 {sv.namehint = "rst_val_n"} : i1
    hw.output %u_clk_io_buf.clk_o, %u_no_scan_val_sync.q_o : i1, i1
  }
  hw.module private @io_osc(in %vcore_pok_h_i : i1, in %io_en_i : i1, in %io_osc_cal_i : i1, out io_clk_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %vcore_pok_h_i_0 = llhd.sig name "vcore_pok_h_i" %false : i1
    %2 = llhd.prb %vcore_pok_h_i_0 : i1
    %en_osc_re = llhd.sig %false : i1
    %clk = llhd.sig %false : i1
    %3 = llhd.prb %clk : i1
    %en_osc_fe = llhd.sig %false : i1
    %u_buf.clk_o = hw.instance "u_buf" @prim_clock_buf(clk_i: %3: i1) -> (clk_o: i1)
    %4 = comb.and %2, %io_en_i : i1
    llhd.drv %en_osc_re, %4 after %1 : i1
    llhd.drv %clk, %false after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %5 = llhd.prb %clk : i1
      %6 = llhd.prb %vcore_pok_h_i_0 : i1
      llhd.wait (%3, %2 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %7 = llhd.prb %clk : i1
      %8 = comb.xor bin %7, %true : i1
      %9 = comb.and bin %5, %8 : i1
      %10 = llhd.prb %vcore_pok_h_i_0 : i1
      %11 = comb.xor bin %10, %true : i1
      %12 = comb.and bin %6, %11 : i1
      %13 = comb.or bin %9, %12 : i1
      cf.cond_br %13, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %14 = llhd.prb %vcore_pok_h_i_0 : i1
      %15 = comb.xor %14, %true : i1
      cf.cond_br %15, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %en_osc_fe, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %16 = llhd.prb %en_osc_re : i1
      llhd.drv %en_osc_fe, %16 after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %vcore_pok_h_i_0, %vcore_pok_h_i after %1 : i1
    hw.output %u_buf.clk_o : i1
  }
  hw.module private @rglts_pdm_3p3v(in %vcc_pok_h_i : i1, in %vcaon_pok_por_h_i : i1, in %vcmain_pok_por_h_i : i1, in %vio_pok_h_i : i2, in %clk_src_aon_h_i : i1, in %main_pd_h_i : i1, in %por_sync_h_i : i1, in %scan_mode_h_i : i1, in %otp_power_seq_h_i : i2, in %vcaon_supp_i : i1, in %vcmain_supp_i : i1, out rglssm_vmppr_h_o : i1, out rglssm_vcmon_h_o : i1, out rglssm_brout_h_o : i1, out vcmain_pok_h_o : i1, out vcmain_pok_por_h_o : i1, out vcaon_pok_h_o : i1, out vcaon_pok_1p1_h_o : i1, out vcaon_pok_por_h_o : i1, out vio_pok_h_o : i2, out vcc_pok_str_h_o : i1, out vcc_pok_str_1p1_h_o : i1, out deep_sleep_h_o : i1, out flash_power_down_h_o : i1, out flash_power_ready_h_o : i1, out otp_power_seq_h_o : i2) {
    %c-1_i9 = hw.constant -1 : i9
    %0 = hw.aggregate_constant [12 : i32, 6 : i32, 224 : i32, 112 : i32] : !hw.array<4xi32>
    %1 = hw.aggregate_constant [4 : i32, 2 : i32, 284 : i32, 142 : i32] : !hw.array<4xi32>
    %c1_i2 = hw.constant 1 : i2
    %2 = llhd.constant_time <0ns, 1d, 0e>
    %c112_i9 = hw.constant 112 : i9
    %3 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %c-3_i3 = hw.constant -3 : i3
    %c-1_i3 = hw.constant -1 : i3
    %c3_i3 = hw.constant 3 : i3
    %c-2_i3 = hw.constant -2 : i3
    %c1_i3 = hw.constant 1 : i3
    %c0_i9 = hw.constant 0 : i9
    %c0_i3 = hw.constant 0 : i3
    %true = hw.constant true
    %false = hw.constant false
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c0_i2 = hw.constant 0 : i2 {sv.namehint = "dv_hook"}
    %vcc_pok_h_i_0 = llhd.sig name "vcc_pok_h_i" %false : i1
    %clk_src_aon_h_i_1 = llhd.sig name "clk_src_aon_h_i" %false : i1
    %4 = llhd.prb %clk_src_aon_h_i_1 : i1
    %main_pd_h_i_2 = llhd.sig name "main_pd_h_i" %false : i1
    %por_sync_h_i_3 = llhd.sig name "por_sync_h_i" %false : i1
    %rglssm_vmppr_h_o = llhd.sig %false : i1
    %rglssm_vcmon_h_o = llhd.sig %false : i1
    %rglssm_brout_h_o = llhd.sig %false : i1
    %vio_pok_h_o = llhd.sig %c0_i2 : i2
    %deep_sleep_h_o = llhd.sig %false : i1
    %otp_power_seq_h_o = llhd.sig %c0_i2 : i2
    %fla_pdm_h = llhd.sig %false : i1
    %dly_cnt = llhd.sig %c0_i9 : i9
    %hc2lc_val = llhd.sig %c0_i9 : i9
    %lc2hc_val = llhd.sig %c0_i9 : i9
    %dft_sel = llhd.sig %c0_i2 : i2
    %cld_pu_val = llhd.sig %c0_i9 : i9
    %rgls_sm = llhd.sig %c0_i3 : i3
    %vcmain_pok_h = llhd.sig %false : i1
    %vcaon_pok_h = llhd.sig %false : i1
    %main_pd_str_h = llhd.sig %false : i1
    %rgls_rst_h_n = llhd.sig %false : i1
    %5 = llhd.prb %rgls_rst_h_n : i1
    %vcc_pok_fe_h = llhd.sig %false : i1
    %vcc_pok_s_h = llhd.sig %false : i1
    %clk_src_aon_h_n = llhd.sig %false : i1
    %6 = llhd.prb %clk_src_aon_h_n : i1
    %vcc_pok_set_h = llhd.sig %false : i1
    %7 = llhd.prb %vcc_pok_set_h : i1
    %vcc_pok_rst_h_n = llhd.sig %false : i1
    %8 = llhd.prb %vcc_pok_rst_h_n : i1
    %vcc_pok_str_no_scan_h = llhd.sig %c0_i4 : i4
    llhd.drv %vio_pok_h_o, %vio_pok_h_i after %3 : i2
    llhd.drv %cld_pu_val, %c112_i9 after %3 : i9
    llhd.drv %dft_sel, %c0_i2 after %3 : i2
    %9 = llhd.prb %dft_sel : i2
    %10 = hw.array_get %1[%9] : !hw.array<4xi32>, i2
    %11 = comb.extract %10 from 0 : (i32) -> i9
    llhd.drv %hc2lc_val, %11 after %3 : i9
    %12 = hw.array_get %0[%9] : !hw.array<4xi32>, i2
    %13 = comb.extract %12 from 0 : (i32) -> i9
    llhd.drv %lc2hc_val, %13 after %3 : i9
    llhd.drv %rgls_rst_h_n, %21 after %3 : i1
    %14 = comb.xor %scan_mode_h_i, %4, %true : i1
    llhd.drv %clk_src_aon_h_n, %14 after %3 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %38 = llhd.prb %clk_src_aon_h_n : i1
      %39 = llhd.prb %rgls_rst_h_n : i1
      llhd.wait (%6, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %40 = llhd.prb %clk_src_aon_h_n : i1
      %41 = comb.xor bin %38, %true : i1
      %42 = comb.and bin %41, %40 : i1
      %43 = llhd.prb %rgls_rst_h_n : i1
      %44 = comb.xor bin %43, %true : i1
      %45 = comb.and bin %39, %44 : i1
      %46 = comb.or bin %42, %45 : i1
      cf.cond_br %46, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %47 = llhd.prb %rgls_rst_h_n : i1
      %48 = comb.xor %47, %true : i1
      cf.cond_br %48, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %vcc_pok_fe_h, %false after %2 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %49 = llhd.prb %vcc_pok_h_i_0 : i1
      llhd.drv %vcc_pok_fe_h, %49 after %2 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %38 = llhd.prb %clk_src_aon_h_i_1 : i1
      %39 = llhd.prb %rgls_rst_h_n : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %40 = llhd.prb %clk_src_aon_h_i_1 : i1
      %41 = comb.xor bin %38, %true : i1
      %42 = comb.and bin %41, %40 : i1
      %43 = llhd.prb %rgls_rst_h_n : i1
      %44 = comb.xor bin %43, %true : i1
      %45 = comb.and bin %39, %44 : i1
      %46 = comb.or bin %42, %45 : i1
      cf.cond_br %46, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %47 = llhd.prb %rgls_rst_h_n : i1
      %48 = comb.xor %47, %true : i1
      cf.cond_br %48, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %vcc_pok_s_h, %false after %2 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %49 = llhd.prb %vcc_pok_fe_h : i1
      llhd.drv %vcc_pok_s_h, %49 after %2 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 17 preds: ^bb0, ^bb2, ^bb4, ^bb7, ^bb8, ^bb11, ^bb13, ^bb14, ^bb17, ^bb19, ^bb20, ^bb23, ^bb24, ^bb27, ^bb28, ^bb30, ^bb31
      %38 = llhd.prb %clk_src_aon_h_i_1 : i1
      %39 = llhd.prb %rgls_rst_h_n : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %40 = llhd.prb %clk_src_aon_h_i_1 : i1
      %41 = comb.xor bin %38, %true : i1
      %42 = comb.and bin %41, %40 : i1
      %43 = llhd.prb %rgls_rst_h_n : i1
      %44 = comb.xor bin %43, %true : i1
      %45 = comb.and bin %39, %44 : i1
      %46 = comb.or bin %42, %45 : i1
      cf.cond_br %46, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %47 = llhd.prb %rgls_rst_h_n : i1
      %48 = comb.xor %47, %true : i1
      cf.cond_br %48, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %vcmain_pok_h, %false after %2 : i1
      llhd.drv %vcaon_pok_h, %false after %2 : i1
      llhd.drv %main_pd_str_h, %false after %2 : i1
      llhd.drv %rglssm_vcmon_h_o, %false after %2 : i1
      llhd.drv %rglssm_vmppr_h_o, %true after %2 : i1
      llhd.drv %rglssm_brout_h_o, %false after %2 : i1
      llhd.drv %fla_pdm_h, %true after %2 : i1
      %49 = llhd.prb %cld_pu_val : i9
      llhd.drv %dly_cnt, %49 after %2 : i9
      llhd.drv %rgls_sm, %c0_i3 after %2 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %50 = llhd.prb %rgls_sm : i3
      %51 = comb.icmp ceq %50, %c0_i3 : i3
      cf.cond_br %51, ^bb6, ^bb9
    ^bb6:  // pred: ^bb5
      llhd.drv %vcmain_pok_h, %false after %2 : i1
      llhd.drv %vcaon_pok_h, %false after %2 : i1
      llhd.drv %main_pd_str_h, %false after %2 : i1
      llhd.drv %rglssm_vcmon_h_o, %false after %2 : i1
      llhd.drv %rglssm_vmppr_h_o, %true after %2 : i1
      llhd.drv %rglssm_brout_h_o, %false after %2 : i1
      llhd.drv %fla_pdm_h, %true after %2 : i1
      %52 = llhd.prb %dly_cnt : i9
      %53 = comb.add %52, %c-1_i9 : i9
      llhd.drv %dly_cnt, %53 after %2 : i9
      %54 = llhd.prb %dly_cnt : i9
      %55 = comb.icmp eq %54, %c0_i9 : i9
      cf.cond_br %55, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      llhd.drv %vcmain_pok_h, %true after %2 : i1
      llhd.drv %vcaon_pok_h, %true after %2 : i1
      llhd.drv %rglssm_vcmon_h_o, %true after %2 : i1
      llhd.drv %rglssm_vmppr_h_o, %false after %2 : i1
      llhd.drv %fla_pdm_h, %false after %2 : i1
      llhd.drv %rgls_sm, %c1_i3 after %2 : i3
      cf.br ^bb1
    ^bb8:  // pred: ^bb6
      llhd.drv %rgls_sm, %c0_i3 after %2 : i3
      cf.br ^bb1
    ^bb9:  // pred: ^bb5
      %56 = comb.icmp ceq %50, %c1_i3 : i3
      cf.cond_br %56, ^bb10, ^bb15
    ^bb10:  // pred: ^bb9
      llhd.drv %vcmain_pok_h, %true after %2 : i1
      llhd.drv %vcaon_pok_h, %true after %2 : i1
      llhd.drv %main_pd_str_h, %false after %2 : i1
      llhd.drv %rglssm_vcmon_h_o, %true after %2 : i1
      llhd.drv %rglssm_vmppr_h_o, %false after %2 : i1
      llhd.drv %rglssm_brout_h_o, %false after %2 : i1
      llhd.drv %fla_pdm_h, %false after %2 : i1
      %57 = llhd.prb %hc2lc_val : i9
      llhd.drv %dly_cnt, %57 after %2 : i9
      %58 = llhd.prb %vcc_pok_s_h : i1
      %59 = comb.xor %58, %true : i1
      cf.cond_br %59, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      llhd.drv %rglssm_vcmon_h_o, %false after %2 : i1
      llhd.drv %rglssm_vmppr_h_o, %false after %2 : i1
      llhd.drv %rglssm_brout_h_o, %true after %2 : i1
      llhd.drv %fla_pdm_h, %false after %2 : i1
      llhd.drv %rgls_sm, %c-2_i3 after %2 : i3
      cf.br ^bb1
    ^bb12:  // pred: ^bb10
      %60 = llhd.prb %main_pd_h_i_2 : i1
      %61 = llhd.prb %por_sync_h_i_3 : i1
      %62 = comb.xor %61, %true : i1
      %63 = comb.and %60, %62 : i1
      cf.cond_br %63, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      llhd.drv %main_pd_str_h, %true after %2 : i1
      llhd.drv %rglssm_vcmon_h_o, %false after %2 : i1
      llhd.drv %rglssm_vmppr_h_o, %false after %2 : i1
      llhd.drv %fla_pdm_h, %true after %2 : i1
      llhd.drv %rgls_sm, %c3_i3 after %2 : i3
      cf.br ^bb1
    ^bb14:  // pred: ^bb12
      llhd.drv %rgls_sm, %c1_i3 after %2 : i3
      cf.br ^bb1
    ^bb15:  // pred: ^bb9
      %64 = comb.icmp ceq %50, %c3_i3 : i3
      cf.cond_br %64, ^bb16, ^bb21
    ^bb16:  // pred: ^bb15
      llhd.drv %vcmain_pok_h, %true after %2 : i1
      llhd.drv %vcaon_pok_h, %true after %2 : i1
      llhd.drv %main_pd_str_h, %true after %2 : i1
      llhd.drv %rglssm_vcmon_h_o, %false after %2 : i1
      llhd.drv %rglssm_vmppr_h_o, %false after %2 : i1
      llhd.drv %rglssm_brout_h_o, %false after %2 : i1
      llhd.drv %fla_pdm_h, %true after %2 : i1
      %65 = llhd.prb %dly_cnt : i9
      %66 = comb.add %65, %c-1_i9 : i9
      llhd.drv %dly_cnt, %66 after %2 : i9
      %67 = llhd.prb %por_sync_h_i_3 : i1
      cf.cond_br %67, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      llhd.drv %vcmain_pok_h, %true after %2 : i1
      llhd.drv %vcaon_pok_h, %true after %2 : i1
      llhd.drv %rglssm_vcmon_h_o, %true after %2 : i1
      llhd.drv %rglssm_vmppr_h_o, %false after %2 : i1
      llhd.drv %fla_pdm_h, %false after %2 : i1
      llhd.drv %rgls_sm, %c1_i3 after %2 : i3
      cf.br ^bb1
    ^bb18:  // pred: ^bb16
      %68 = llhd.prb %dly_cnt : i9
      %69 = comb.icmp eq %68, %c0_i9 : i9
      cf.cond_br %69, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      llhd.drv %rglssm_vmppr_h_o, %true after %2 : i1
      llhd.drv %rgls_sm, %c-1_i3 after %2 : i3
      cf.br ^bb1
    ^bb20:  // pred: ^bb18
      llhd.drv %rgls_sm, %c3_i3 after %2 : i3
      cf.br ^bb1
    ^bb21:  // pred: ^bb15
      %70 = comb.icmp ceq %50, %c-1_i3 : i3
      cf.cond_br %70, ^bb22, ^bb25
    ^bb22:  // pred: ^bb21
      llhd.drv %vcmain_pok_h, %false after %2 : i1
      llhd.drv %vcaon_pok_h, %true after %2 : i1
      llhd.drv %main_pd_str_h, %true after %2 : i1
      llhd.drv %rglssm_vcmon_h_o, %false after %2 : i1
      llhd.drv %rglssm_vmppr_h_o, %true after %2 : i1
      llhd.drv %rglssm_brout_h_o, %false after %2 : i1
      llhd.drv %fla_pdm_h, %true after %2 : i1
      %71 = llhd.prb %lc2hc_val : i9
      llhd.drv %dly_cnt, %71 after %2 : i9
      %72 = llhd.prb %main_pd_h_i_2 : i1
      %73 = comb.xor %72, %true : i1
      %74 = llhd.prb %por_sync_h_i_3 : i1
      %75 = comb.or %73, %74 : i1
      cf.cond_br %75, ^bb23, ^bb24
    ^bb23:  // pred: ^bb22
      llhd.drv %rglssm_vmppr_h_o, %true after %2 : i1
      llhd.drv %rgls_sm, %c-3_i3 after %2 : i3
      cf.br ^bb1
    ^bb24:  // pred: ^bb22
      llhd.drv %rgls_sm, %c-1_i3 after %2 : i3
      cf.br ^bb1
    ^bb25:  // pred: ^bb21
      %76 = comb.icmp ceq %50, %c-3_i3 : i3
      cf.cond_br %76, ^bb26, ^bb29
    ^bb26:  // pred: ^bb25
      llhd.drv %vcmain_pok_h, %false after %2 : i1
      llhd.drv %vcaon_pok_h, %true after %2 : i1
      llhd.drv %main_pd_str_h, %false after %2 : i1
      llhd.drv %rglssm_vcmon_h_o, %false after %2 : i1
      llhd.drv %rglssm_vmppr_h_o, %true after %2 : i1
      llhd.drv %rglssm_brout_h_o, %false after %2 : i1
      llhd.drv %fla_pdm_h, %true after %2 : i1
      %77 = llhd.prb %dly_cnt : i9
      %78 = comb.add %77, %c-1_i9 : i9
      llhd.drv %dly_cnt, %78 after %2 : i9
      %79 = llhd.prb %dly_cnt : i9
      %80 = comb.icmp eq %79, %c0_i9 : i9
      cf.cond_br %80, ^bb27, ^bb28
    ^bb27:  // pred: ^bb26
      llhd.drv %vcmain_pok_h, %true after %2 : i1
      llhd.drv %vcaon_pok_h, %true after %2 : i1
      llhd.drv %rglssm_vcmon_h_o, %true after %2 : i1
      llhd.drv %rglssm_vmppr_h_o, %false after %2 : i1
      llhd.drv %fla_pdm_h, %false after %2 : i1
      llhd.drv %rgls_sm, %c1_i3 after %2 : i3
      cf.br ^bb1
    ^bb28:  // pred: ^bb26
      llhd.drv %rgls_sm, %c-3_i3 after %2 : i3
      cf.br ^bb1
    ^bb29:  // pred: ^bb25
      %81 = comb.icmp ceq %50, %c-2_i3 : i3
      cf.cond_br %81, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      llhd.drv %vcmain_pok_h, %true after %2 : i1
      llhd.drv %vcaon_pok_h, %true after %2 : i1
      llhd.drv %main_pd_str_h, %false after %2 : i1
      llhd.drv %rglssm_vcmon_h_o, %false after %2 : i1
      llhd.drv %rglssm_vmppr_h_o, %false after %2 : i1
      llhd.drv %rglssm_brout_h_o, %true after %2 : i1
      llhd.drv %fla_pdm_h, %false after %2 : i1
      %82 = llhd.prb %lc2hc_val : i9
      llhd.drv %dly_cnt, %82 after %2 : i9
      llhd.drv %rgls_sm, %c-2_i3 after %2 : i3
      cf.br ^bb1
    ^bb31:  // pred: ^bb29
      llhd.drv %vcmain_pok_h, %false after %2 : i1
      llhd.drv %vcaon_pok_h, %false after %2 : i1
      llhd.drv %main_pd_str_h, %false after %2 : i1
      llhd.drv %rglssm_vcmon_h_o, %false after %2 : i1
      llhd.drv %rglssm_vmppr_h_o, %true after %2 : i1
      llhd.drv %rglssm_brout_h_o, %false after %2 : i1
      llhd.drv %fla_pdm_h, %true after %2 : i1
      %83 = llhd.prb %lc2hc_val : i9
      llhd.drv %dly_cnt, %83 after %2 : i9
      llhd.drv %rgls_sm, %c0_i3 after %2 : i3
      cf.br ^bb1
    }
    %15 = llhd.prb %vcmain_pok_h : i1
    %16 = comb.and %15, %vcmain_supp_i : i1
    %17 = llhd.prb %vcc_pok_h_i_0 : i1
    %18 = comb.and %17, %vcaon_supp_i : i1
    %19 = comb.or %17, %18 : i1
    llhd.drv %vcc_pok_rst_h_n, %19 after %3 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %38 = llhd.prb %vcc_pok_rst_h_n : i1
      %39 = llhd.prb %vcc_pok_h_i_0 : i1
      %40 = comb.and %38, %39 : i1
      llhd.drv %vcc_pok_set_h, %40 after %3 : i1
      llhd.wait (%8, %17, %7 : i1, i1, i1), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %38 = llhd.prb %clk_src_aon_h_i_1 : i1
      %39 = llhd.prb %vcc_pok_rst_h_n : i1
      %40 = llhd.prb %vcc_pok_set_h : i1
      llhd.wait (%4, %8, %7 : i1, i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %41 = llhd.prb %clk_src_aon_h_i_1 : i1
      %42 = comb.xor bin %38, %true : i1
      %43 = comb.and bin %42, %41 : i1
      %44 = llhd.prb %vcc_pok_rst_h_n : i1
      %45 = comb.xor bin %44, %true : i1
      %46 = comb.and bin %39, %45 : i1
      %47 = llhd.prb %vcc_pok_set_h : i1
      %48 = comb.xor bin %40, %true : i1
      %49 = comb.and bin %48, %47 : i1
      %50 = comb.or bin %43, %46, %49 : i1
      cf.cond_br %50, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %51 = llhd.prb %vcc_pok_rst_h_n : i1
      %52 = comb.xor %51, %true : i1
      cf.cond_br %52, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %53 = llhd.sig.extract %vcc_pok_str_no_scan_h from %c0_i2 : <i4> -> <i1>
      llhd.drv %53, %false after %2 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %54 = llhd.prb %vcc_pok_set_h : i1
      cf.cond_br %54, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %55 = llhd.sig.extract %vcc_pok_str_no_scan_h from %c0_i2 : <i4> -> <i1>
      llhd.drv %55, %true after %2 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %56 = llhd.sig.extract %vcc_pok_str_no_scan_h from %c0_i2 : <i4> -> <i1>
      llhd.drv %56, %false after %2 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %38 = llhd.prb %clk_src_aon_h_i_1 : i1
      %39 = llhd.prb %vcc_pok_rst_h_n : i1
      %40 = llhd.prb %vcc_pok_set_h : i1
      llhd.wait (%4, %8, %7 : i1, i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %41 = llhd.prb %clk_src_aon_h_i_1 : i1
      %42 = comb.xor bin %38, %true : i1
      %43 = comb.and bin %42, %41 : i1
      %44 = llhd.prb %vcc_pok_rst_h_n : i1
      %45 = comb.xor bin %44, %true : i1
      %46 = comb.and bin %39, %45 : i1
      %47 = llhd.prb %vcc_pok_set_h : i1
      %48 = comb.xor bin %40, %true : i1
      %49 = comb.and bin %48, %47 : i1
      %50 = comb.or bin %43, %46, %49 : i1
      cf.cond_br %50, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %51 = llhd.prb %vcc_pok_rst_h_n : i1
      %52 = comb.xor %51, %true : i1
      cf.cond_br %52, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %53 = llhd.sig.extract %vcc_pok_str_no_scan_h from %c1_i2 : <i4> -> <i1>
      llhd.drv %53, %false after %2 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %54 = llhd.prb %vcc_pok_set_h : i1
      cf.cond_br %54, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %55 = llhd.sig.extract %vcc_pok_str_no_scan_h from %c1_i2 : <i4> -> <i1>
      llhd.drv %55, %true after %2 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %56 = llhd.sig.extract %vcc_pok_str_no_scan_h from %c1_i2 : <i4> -> <i1>
      %57 = llhd.prb %vcc_pok_str_no_scan_h : i4
      %58 = comb.extract %57 from 0 : (i4) -> i1
      llhd.drv %56, %58 after %2 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %38 = llhd.prb %clk_src_aon_h_i_1 : i1
      %39 = llhd.prb %vcc_pok_rst_h_n : i1
      %40 = llhd.prb %vcc_pok_set_h : i1
      llhd.wait (%4, %8, %7 : i1, i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %41 = llhd.prb %clk_src_aon_h_i_1 : i1
      %42 = comb.xor bin %38, %true : i1
      %43 = comb.and bin %42, %41 : i1
      %44 = llhd.prb %vcc_pok_rst_h_n : i1
      %45 = comb.xor bin %44, %true : i1
      %46 = comb.and bin %39, %45 : i1
      %47 = llhd.prb %vcc_pok_set_h : i1
      %48 = comb.xor bin %40, %true : i1
      %49 = comb.and bin %48, %47 : i1
      %50 = comb.or bin %43, %46, %49 : i1
      cf.cond_br %50, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %51 = llhd.prb %vcc_pok_rst_h_n : i1
      %52 = comb.xor %51, %true : i1
      cf.cond_br %52, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %53 = llhd.sig.extract %vcc_pok_str_no_scan_h from %c-2_i2 : <i4> -> <i1>
      llhd.drv %53, %false after %2 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %54 = llhd.prb %vcc_pok_set_h : i1
      cf.cond_br %54, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %55 = llhd.sig.extract %vcc_pok_str_no_scan_h from %c-2_i2 : <i4> -> <i1>
      llhd.drv %55, %true after %2 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %56 = llhd.sig.extract %vcc_pok_str_no_scan_h from %c-2_i2 : <i4> -> <i1>
      %57 = llhd.prb %vcc_pok_str_no_scan_h : i4
      %58 = comb.extract %57 from 1 : (i4) -> i1
      llhd.drv %56, %58 after %2 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %38 = llhd.prb %clk_src_aon_h_i_1 : i1
      %39 = llhd.prb %vcc_pok_rst_h_n : i1
      %40 = llhd.prb %vcc_pok_set_h : i1
      llhd.wait (%4, %8, %7 : i1, i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %41 = llhd.prb %clk_src_aon_h_i_1 : i1
      %42 = comb.xor bin %38, %true : i1
      %43 = comb.and bin %42, %41 : i1
      %44 = llhd.prb %vcc_pok_rst_h_n : i1
      %45 = comb.xor bin %44, %true : i1
      %46 = comb.and bin %39, %45 : i1
      %47 = llhd.prb %vcc_pok_set_h : i1
      %48 = comb.xor bin %40, %true : i1
      %49 = comb.and bin %48, %47 : i1
      %50 = comb.or bin %43, %46, %49 : i1
      cf.cond_br %50, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %51 = llhd.prb %vcc_pok_rst_h_n : i1
      %52 = comb.xor %51, %true : i1
      cf.cond_br %52, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %53 = llhd.sig.extract %vcc_pok_str_no_scan_h from %c-1_i2 : <i4> -> <i1>
      llhd.drv %53, %false after %2 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %54 = llhd.prb %vcc_pok_set_h : i1
      cf.cond_br %54, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %55 = llhd.sig.extract %vcc_pok_str_no_scan_h from %c-1_i2 : <i4> -> <i1>
      llhd.drv %55, %true after %2 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %56 = llhd.sig.extract %vcc_pok_str_no_scan_h from %c-1_i2 : <i4> -> <i1>
      %57 = llhd.prb %vcc_pok_str_no_scan_h : i4
      %58 = comb.extract %57 from 2 : (i4) -> i1
      llhd.drv %56, %58 after %2 : i1
      cf.br ^bb1
    }
    %20 = llhd.prb %vcc_pok_str_no_scan_h : i4
    %21 = comb.extract %20 from 3 : (i4) -> i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %38 = llhd.prb %clk_src_aon_h_i_1 : i1
      %39 = llhd.prb %rgls_rst_h_n : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %40 = llhd.prb %clk_src_aon_h_i_1 : i1
      %41 = comb.xor bin %38, %true : i1
      %42 = comb.and bin %41, %40 : i1
      %43 = llhd.prb %rgls_rst_h_n : i1
      %44 = comb.xor bin %43, %true : i1
      %45 = comb.and bin %39, %44 : i1
      %46 = comb.or bin %42, %45 : i1
      cf.cond_br %46, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %47 = llhd.prb %rgls_rst_h_n : i1
      %48 = comb.xor %47, %true : i1
      cf.cond_br %48, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %deep_sleep_h_o, %false after %2 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %49 = llhd.prb %main_pd_h_i_2 : i1
      %50 = llhd.prb %main_pd_str_h : i1
      %51 = comb.or %49, %50 : i1
      llhd.drv %deep_sleep_h_o, %51 after %2 : i1
      cf.br ^bb1
    }
    %22 = llhd.prb %fla_pdm_h : i1
    %23 = comb.or %scan_mode_h_i, %22 : i1
    %24 = llhd.prb %rglssm_vcmon_h_o : i1
    %25 = comb.xor %24, %true {sv.namehint = "otp_pdm_h"} : i1
    %26 = llhd.sig.extract %otp_power_seq_h_o from %false : <i2> -> <i1>
    %27 = comb.xor %scan_mode_h_i, %true : i1
    %28 = comb.extract %otp_power_seq_h_i from 0 : (i2) -> i1
    %29 = comb.and %27, %24, %28 : i1
    llhd.drv %26, %29 after %3 : i1
    %30 = llhd.sig.extract %otp_power_seq_h_o from %true : <i2> -> <i1>
    %31 = comb.extract %otp_power_seq_h_i from 1 : (i2) -> i1
    %32 = comb.or %scan_mode_h_i, %25, %31 : i1
    llhd.drv %30, %32 after %3 : i1
    llhd.drv %vcc_pok_h_i_0, %vcc_pok_h_i after %3 : i1
    llhd.drv %clk_src_aon_h_i_1, %clk_src_aon_h_i after %3 : i1
    llhd.drv %main_pd_h_i_2, %main_pd_h_i after %3 : i1
    llhd.drv %por_sync_h_i_3, %por_sync_h_i after %3 : i1
    %33 = llhd.prb %rglssm_vmppr_h_o : i1
    %34 = llhd.prb %rglssm_brout_h_o : i1
    %35 = llhd.prb %vio_pok_h_o : i2
    %36 = llhd.prb %deep_sleep_h_o : i1
    %37 = llhd.prb %otp_power_seq_h_o : i2
    hw.output %33, %24, %34, %16, %vcmain_pok_por_h_i, %18, %18, %vcaon_pok_por_h_i, %35, %21, %21, %36, %23, %17, %37 : i1, i1, i1, i1, i1, i1, i1, i1, i2, i1, i1, i1, i1, i1, i2
  }
  hw.module private @rng(in %clk_i : i1, in %rst_ni : i1, in %clk_ast_rng_i : i1, in %rst_ast_rng_ni : i1, in %rng_en_i : i1, in %rng_fips_i : i1, in %scan_mode_i : i1, out rng_b_o : i4, out rng_val_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %false = hw.constant false
    %c1_i12 = hw.constant 1 : i12
    %true = hw.constant true
    %c0_i12 = hw.constant 0 : i12
    %c120_i12 = hw.constant 120 : i12
    %c0_i64 = hw.constant 0 : i64
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %clk_ast_rng_i_2 = llhd.sig name "clk_ast_rng_i" %false : i1
    %3 = llhd.prb %clk_ast_rng_i_2 : i1
    %rst_ast_rng_ni_3 = llhd.sig name "rst_ast_rng_ni" %false : i1
    %4 = llhd.prb %rst_ast_rng_ni_3 : i1
    %rng_en_i_4 = llhd.sig name "rng_en_i" %false : i1
    %rng_b_o = llhd.sig %c0_i4 : i4
    %rng_val_o = llhd.sig %false : i1
    %rst_n = llhd.sig %false : i1
    %5 = llhd.prb %rst_n : i1
    %lfsr_val = llhd.sig %c0_i4 : i4
    %srate_rng_val = llhd.sig %false : i1
    %srate_cnt = llhd.sig %c0_i12 : i12
    %srate_value = llhd.sig %c0_i12 : i12
    %rng_b = llhd.sig %c0_i4 : i4
    %src_busy = llhd.sig %false : i1
    %sync_rng_val = llhd.sig %false : i1
    %srate_rng_val_en = llhd.sig %false : i1
    %6 = llhd.prb %rng_en_i_4 : i1
    %u_rng_lfsr.state_o = hw.instance "u_rng_lfsr" @prim_lfsr(clk_i: %2: i1, rst_ni: %5: i1, seed_en_i: %false: i1, seed_i: %c0_i64: i64, lfsr_en_i: %6: i1, entropy_i: %false: i1) -> (state_o: i4)
    llhd.drv %lfsr_val, %u_rng_lfsr.state_o after %1 : i4
    %7 = llhd.prb %srate_rng_val : i1
    %u_rng_val_pulse_sync.src_pulse_en_o, %u_rng_val_pulse_sync.src_busy_o, %u_rng_val_pulse_sync.dst_pulse_o = hw.instance "u_rng_val_pulse_sync" @ast_pulse_sync(scan_mode_i: %scan_mode_i: i1, clk_src_i: %2: i1, rst_src_ni: %5: i1, src_pulse_i: %7: i1, clk_dst_i: %3: i1, rst_dst_ni: %4: i1) -> (src_pulse_en_o: i1, src_busy_o: i1, dst_pulse_o: i1)
    llhd.drv %srate_rng_val_en, %u_rng_val_pulse_sync.src_pulse_en_o after %1 : i1
    llhd.drv %src_busy, %u_rng_val_pulse_sync.src_busy_o after %1 : i1
    llhd.drv %sync_rng_val, %u_rng_val_pulse_sync.dst_pulse_o after %1 : i1
    %8 = llhd.prb %rst_ni_1 : i1
    %9 = comb.or %scan_mode_i, %6 : i1
    %10 = comb.and %9, %8 : i1
    llhd.drv %rst_n, %10 after %1 : i1
    llhd.drv %srate_value, %c120_i12 after %1 : i12
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9
      %13 = llhd.prb %clk_i_0 : i1
      %14 = llhd.prb %rst_n : i1
      llhd.wait (%2, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %15 = llhd.prb %clk_i_0 : i1
      %16 = comb.xor bin %13, %true : i1
      %17 = comb.and bin %16, %15 : i1
      %18 = llhd.prb %rst_n : i1
      %19 = comb.xor bin %18, %true : i1
      %20 = comb.and bin %14, %19 : i1
      %21 = comb.or bin %17, %20 : i1
      cf.cond_br %21, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %22 = llhd.prb %rst_n : i1
      %23 = comb.xor %22, %true : i1
      cf.cond_br %23, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %srate_cnt, %c0_i12 after %0 : i12
      llhd.drv %srate_rng_val, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %24 = llhd.prb %srate_cnt : i12
      %25 = llhd.prb %srate_value : i12
      %26 = comb.icmp eq %24, %25 : i12
      %27 = llhd.prb %src_busy : i1
      %28 = comb.and %26, %27 : i1
      cf.cond_br %28, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %srate_rng_val, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %29 = llhd.prb %srate_cnt : i12
      %30 = llhd.prb %srate_value : i12
      %31 = comb.icmp eq %29, %30 : i12
      cf.cond_br %31, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %srate_cnt, %c0_i12 after %0 : i12
      llhd.drv %srate_rng_val, %true after %0 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %32 = llhd.prb %srate_cnt : i12
      %33 = comb.add %32, %c1_i12 : i12
      llhd.drv %srate_cnt, %33 after %0 : i12
      llhd.drv %srate_rng_val, %false after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %13 = llhd.prb %clk_i_0 : i1
      %14 = llhd.prb %rst_n : i1
      llhd.wait (%2, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %15 = llhd.prb %clk_i_0 : i1
      %16 = comb.xor bin %13, %true : i1
      %17 = comb.and bin %16, %15 : i1
      %18 = llhd.prb %rst_n : i1
      %19 = comb.xor bin %18, %true : i1
      %20 = comb.and bin %14, %19 : i1
      %21 = comb.or bin %17, %20 : i1
      cf.cond_br %21, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %22 = llhd.prb %rst_n : i1
      %23 = comb.xor %22, %true : i1
      cf.cond_br %23, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %rng_b, %c0_i4 after %0 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %24 = llhd.prb %srate_rng_val_en : i1
      cf.cond_br %24, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %25 = llhd.prb %lfsr_val : i4
      llhd.drv %rng_b, %25 after %0 : i4
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %13 = llhd.prb %clk_ast_rng_i_2 : i1
      %14 = llhd.prb %rst_ast_rng_ni_3 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %15 = llhd.prb %clk_ast_rng_i_2 : i1
      %16 = comb.xor bin %13, %true : i1
      %17 = comb.and bin %16, %15 : i1
      %18 = llhd.prb %rst_ast_rng_ni_3 : i1
      %19 = comb.xor bin %18, %true : i1
      %20 = comb.and bin %14, %19 : i1
      %21 = comb.or bin %17, %20 : i1
      cf.cond_br %21, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %22 = llhd.prb %rst_ast_rng_ni_3 : i1
      %23 = comb.xor %22, %true : i1
      cf.cond_br %23, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %rng_b_o, %c0_i4 after %0 : i4
      llhd.drv %rng_val_o, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %24 = llhd.prb %sync_rng_val : i1
      cf.cond_br %24, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %25 = llhd.prb %rng_b : i4
      llhd.drv %rng_b_o, %25 after %0 : i4
      llhd.drv %rng_val_o, %true after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      llhd.drv %rng_val_o, %false after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %clk_ast_rng_i_2, %clk_ast_rng_i after %1 : i1
    llhd.drv %rst_ast_rng_ni_3, %rst_ast_rng_ni after %1 : i1
    llhd.drv %rng_en_i_4, %rng_en_i after %1 : i1
    %11 = llhd.prb %rng_b_o : i4
    %12 = llhd.prb %rng_val_o : i1
    hw.output %11, %12 : i4, i1
  }
  hw.module private @sys_clk(in %clk_src_sys_jen_i : i1, in %clk_src_sys_en_i : i1, in %clk_sys_pd_ni : i1, in %rst_sys_clk_ni : i1, in %vcore_pok_h_i : i1, in %scan_mode_i : i1, in %sys_osc_cal_i : i1, out clk_src_sys_o : i1, out clk_src_sys_val_o : i1) {
    %true = hw.constant true
    %u_sys_osc.sys_clk_o = hw.instance "u_sys_osc" @sys_osc(vcore_pok_h_i: %vcore_pok_h_i: i1, sys_en_i: %1: i1, sys_jen_i: %clk_src_sys_jen_i: i1, sys_osc_cal_i: %sys_osc_cal_i: i1) -> (sys_clk_o: i1) {sv.namehint = "clk"}
    %u_clk_sys_buf.clk_o = hw.instance "u_clk_sys_buf" @prim_clock_buf(clk_i: %u_sys_osc.sys_clk_o: i1) -> (clk_o: i1)
    %u_no_scan_val_sync.q_o = hw.instance "u_no_scan_val_sync" @prim_flop_2sync(clk_i: %u_clk_sys_buf.clk_o: i1, rst_ni: %1: i1, d_i: %true: i1) -> (q_o: i1)
    %0 = comb.and %clk_src_sys_en_i, %clk_sys_pd_ni, %rst_sys_clk_ni {sv.namehint = "osc_en"} : i1
    %1 = comb.or %scan_mode_i, %0 {sv.namehint = "rst_val_n"} : i1
    hw.output %u_clk_sys_buf.clk_o, %u_no_scan_val_sync.q_o : i1, i1
  }
  hw.module private @sys_osc(in %vcore_pok_h_i : i1, in %sys_en_i : i1, in %sys_jen_i : i1, in %sys_osc_cal_i : i1, out sys_clk_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %vcore_pok_h_i_0 = llhd.sig name "vcore_pok_h_i" %false : i1
    %2 = llhd.prb %vcore_pok_h_i_0 : i1
    %en_osc_re = llhd.sig %false : i1
    %clk = llhd.sig %false : i1
    %3 = llhd.prb %clk : i1
    %en_osc_fe = llhd.sig %false : i1
    %u_buf.clk_o = hw.instance "u_buf" @prim_clock_buf(clk_i: %3: i1) -> (clk_o: i1)
    %4 = comb.and %2, %sys_en_i : i1
    llhd.drv %en_osc_re, %4 after %1 : i1
    llhd.drv %clk, %false after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %5 = llhd.prb %clk : i1
      %6 = llhd.prb %vcore_pok_h_i_0 : i1
      llhd.wait (%3, %2 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %7 = llhd.prb %clk : i1
      %8 = comb.xor bin %7, %true : i1
      %9 = comb.and bin %5, %8 : i1
      %10 = llhd.prb %vcore_pok_h_i_0 : i1
      %11 = comb.xor bin %10, %true : i1
      %12 = comb.and bin %6, %11 : i1
      %13 = comb.or bin %9, %12 : i1
      cf.cond_br %13, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %14 = llhd.prb %vcore_pok_h_i_0 : i1
      %15 = comb.xor %14, %true : i1
      cf.cond_br %15, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %en_osc_fe, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %16 = llhd.prb %en_osc_re : i1
      llhd.drv %en_osc_fe, %16 after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %vcore_pok_h_i_0, %vcore_pok_h_i after %1 : i1
    hw.output %u_buf.clk_o : i1
  }
  hw.module private @usb_clk(in %vcore_pok_h_i : i1, in %clk_usb_pd_ni : i1, in %rst_usb_clk_ni : i1, in %clk_src_usb_en_i : i1, in %usb_ref_val_i : i1, in %usb_ref_pulse_i : i1, in %clk_ast_usb_i : i1, in %rst_ast_usb_ni : i1, in %scan_mode_i : i1, in %usb_osc_cal_i : i1, out clk_src_usb_o : i1, out clk_src_usb_val_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %true = hw.constant true
    %false = hw.constant false
    %rst_ast_usb_ni_0 = llhd.sig name "rst_ast_usb_ni" %false : i1
    %rst_da_n = llhd.sig %false : i1
    %u_rst_da.q_o = hw.instance "u_rst_da" @prim_flop_2sync(clk_i: %u_clk_usb_buf.clk_o: i1, rst_ni: %rst_usb_clk_ni: i1, d_i: %true: i1) -> (q_o: i1)
    llhd.drv %rst_da_n, %u_rst_da.q_o after %0 : i1
    %1 = llhd.prb %rst_ast_usb_ni_0 : i1
    %u_ref_pulse_sync.src_pulse_en_o, %u_ref_pulse_sync.src_busy_o, %u_ref_pulse_sync.dst_pulse_o = hw.instance "u_ref_pulse_sync" @ast_pulse_sync(scan_mode_i: %scan_mode_i: i1, clk_src_i: %clk_ast_usb_i: i1, rst_src_ni: %1: i1, src_pulse_i: %6: i1, clk_dst_i: %u_usb_osc.usb_clk_o: i1, rst_dst_ni: %5: i1) -> (src_pulse_en_o: i1, src_busy_o: i1, dst_pulse_o: i1) {sv.namehint = "src_busy"}
    %u_rst_ast_usb_da.q_o = hw.instance "u_rst_ast_usb_da" @prim_flop_2sync(clk_i: %u_usb_osc.usb_clk_o: i1, rst_ni: %1: i1, d_i: %true: i1) -> (q_o: i1) {sv.namehint = "rst_usb_n"}
    %u_ref_val_sync.q_o = hw.instance "u_ref_val_sync" @prim_flop_2sync(clk_i: %u_usb_osc.usb_clk_o: i1, rst_ni: %u_rst_ast_usb_da.q_o: i1, d_i: %usb_ref_val_i: i1) -> (q_o: i1) {sv.namehint = "usb_ref_val"}
    %u_usb_osc.usb_clk_o = hw.instance "u_usb_osc" @usb_osc(vcore_pok_h_i: %vcore_pok_h_i: i1, usb_en_i: %3: i1, usb_ref_pulse_i: %u_ref_pulse_sync.dst_pulse_o: i1, usb_ref_val_i: %u_ref_val_sync.q_o: i1, usb_osc_cal_i: %usb_osc_cal_i: i1) -> (usb_clk_o: i1) {sv.namehint = "clk"}
    %u_clk_usb_buf.clk_o = hw.instance "u_clk_usb_buf" @prim_clock_buf(clk_i: %u_usb_osc.usb_clk_o: i1) -> (clk_o: i1)
    %u_no_scan_val_sync.q_o = hw.instance "u_no_scan_val_sync" @prim_flop_2sync(clk_i: %u_clk_usb_buf.clk_o: i1, rst_ni: %3: i1, d_i: %true: i1) -> (q_o: i1)
    %2 = comb.and %clk_src_usb_en_i, %clk_usb_pd_ni, %rst_usb_clk_ni {sv.namehint = "osc_en"} : i1
    %3 = comb.or %scan_mode_i, %2 {sv.namehint = "rst_val_n"} : i1
    %4 = llhd.prb %rst_da_n : i1
    %5 = comb.mux %scan_mode_i, %1, %4 {sv.namehint = "rst_n"} : i1
    %6 = comb.and %usb_ref_pulse_i, %usb_ref_val_i {sv.namehint = "ref_pulse_in"} : i1
    llhd.drv %rst_ast_usb_ni_0, %rst_ast_usb_ni after %0 : i1
    hw.output %u_clk_usb_buf.clk_o, %u_no_scan_val_sync.q_o : i1, i1
  }
  hw.module private @usb_osc(in %vcore_pok_h_i : i1, in %usb_en_i : i1, in %usb_ref_pulse_i : i1, in %usb_ref_val_i : i1, in %usb_osc_cal_i : i1, out usb_clk_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %vcore_pok_h_i_0 = llhd.sig name "vcore_pok_h_i" %false : i1
    %2 = llhd.prb %vcore_pok_h_i_0 : i1
    %en_osc_re = llhd.sig %false : i1
    %clk = llhd.sig %false : i1
    %3 = llhd.prb %clk : i1
    %en_osc_fe = llhd.sig %false : i1
    %u_buf.clk_o = hw.instance "u_buf" @prim_clock_buf(clk_i: %3: i1) -> (clk_o: i1)
    %4 = comb.and %2, %usb_en_i : i1
    llhd.drv %en_osc_re, %4 after %1 : i1
    llhd.drv %clk, %false after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %5 = llhd.prb %clk : i1
      %6 = llhd.prb %vcore_pok_h_i_0 : i1
      llhd.wait (%3, %2 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %7 = llhd.prb %clk : i1
      %8 = comb.xor bin %7, %true : i1
      %9 = comb.and bin %5, %8 : i1
      %10 = llhd.prb %vcore_pok_h_i_0 : i1
      %11 = comb.xor bin %10, %true : i1
      %12 = comb.and bin %6, %11 : i1
      %13 = comb.or bin %9, %12 : i1
      cf.cond_br %13, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %14 = llhd.prb %vcore_pok_h_i_0 : i1
      %15 = comb.xor %14, %true : i1
      cf.cond_br %15, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %en_osc_fe, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %16 = llhd.prb %en_osc_re : i1
      llhd.drv %en_osc_fe, %16 after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %vcore_pok_h_i_0, %vcore_pok_h_i after %1 : i1
    hw.output %u_buf.clk_o : i1
  }
  hw.module private @vcc_pgd(out vcc_pok_o : i1) {
    %true = hw.constant true {sv.namehint = "gen_supp_a"}
    hw.output %true : i1
  }
  hw.module private @vio_pgd(out vio_pok_o : i1) {
    %true = hw.constant true {sv.namehint = "gen_supp_a"}
    hw.output %true : i1
  }
}
