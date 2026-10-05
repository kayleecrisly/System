module {
  hw.module private @prim_buf(in %in_i : i1, out out_o : i1) {
    hw.output %in_i : i1
  }
  hw.module private @prim_buf_38(in %in_i : i4, out out_o : i4) {
    hw.output %in_i : i4
  }
  hw.module private @prim_buf_39(in %in_i : i22, out out_o : i22) {
    hw.output %in_i : i22
  }
  hw.module private @prim_buf_59(in %in_i : i2, out out_o : i2) {
    hw.output %in_i : i2
  }
  hw.module private @prim_clock_buf(in %clk_i : i1, out clk_o : i1) {
    hw.output %clk_i : i1
  }
  hw.module private @prim_clock_buf_3(in %clk_i : i1, out clk_o : i1) {
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
    %gen_div2.u_div2.q_o = hw.instance "gen_div2.u_div2" @prim_flop_10(clk_i: %2: i1, rst_ni: %3: i1, d_i: %gen_div2.u_inv.clk_no: i1) -> (q_o: i1) {sv.namehint = "gen_div2.q_p"}
    %gen_div2.u_inv.clk_no = hw.instance "gen_div2.u_inv" @prim_clock_inv(clk_i: %gen_div2.u_div2.q_o: i1, scanmode_i: %false: i1) -> (clk_no: i1) {sv.namehint = "gen_div2.q_n"}
    %4 = llhd.prb %gen_div2.step_down_nq : i1
    %gen_div2.u_step_down_mux.clk_o = hw.instance "gen_div2.u_step_down_mux" @prim_clock_mux2(clk0_i: %gen_div2.u_div2.q_o: i1, clk1_i: %2: i1, sel_i: %4: i1) -> (clk_o: i1) {sv.namehint = "clk_int"}
    %u_clk_mux.clk_o = hw.instance "u_clk_mux" @prim_clock_mux2(clk0_i: %gen_div2.u_step_down_mux.clk_o: i1, clk1_i: %2: i1, sel_i: %false: i1) -> (clk_o: i1) {sv.namehint = "clk_muxed"}
    %u_clk_div_buf.clk_o = hw.instance "u_clk_div_buf" @prim_clock_buf_3(clk_i: %u_clk_mux.clk_o: i1) -> (clk_o: i1)
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
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %true = hw.constant true
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
    %gen_div.cnt = llhd.sig %false : i1
    %gen_div.limit = llhd.sig %false : i1
    %4 = llhd.prb %clk_int : i1
    %u_clk_mux.clk_o = hw.instance "u_clk_mux" @prim_clock_mux2(clk0_i: %4: i1, clk1_i: %2: i1, sel_i: %false: i1) -> (clk_o: i1)
    llhd.drv %clk_muxed, %u_clk_mux.clk_o after %1 : i1
    %5 = llhd.prb %clk_muxed : i1
    %u_clk_div_buf.clk_o = hw.instance "u_clk_div_buf" @prim_clock_buf_3(clk_i: %5: i1) -> (clk_o: i1)
    %6 = llhd.prb %step_down_req_i_2 : i1
    %7 = comb.xor %test_en_i, %true : i1
    %8 = comb.and %7, %6 : i1
    llhd.drv %step_down_req, %8 after %1 : i1
    %9 = llhd.prb %step_down_req : i1
    %10 = comb.xor %9, %true : i1
    llhd.drv %gen_div.limit, %10 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7
      %12 = llhd.prb %clk_i_0 : i1
      %13 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %gen_div.cnt, %false after %0 : i1
      llhd.drv %clk_int, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %23 = llhd.prb %gen_div.cnt : i1
      %24 = llhd.prb %gen_div.limit : i1
      %25 = comb.icmp uge %23, %24 : i1
      cf.cond_br %25, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %gen_div.cnt, %false after %0 : i1
      %26 = llhd.prb %clk_muxed : i1
      %27 = comb.xor %26, %true : i1
      llhd.drv %clk_int, %27 after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %28 = llhd.prb %gen_div.cnt : i1
      %29 = comb.add %28, %true : i1
      llhd.drv %gen_div.cnt, %29 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %12 = llhd.prb %clk_i_0 : i1
      %13 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %step_down_ack_o, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %23 = llhd.prb %step_down_req : i1
      llhd.drv %step_down_ack_o, %23 after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %step_down_req_i_2, %step_down_req_i after %1 : i1
    %11 = llhd.prb %step_down_ack_o : i1
    hw.output %11, %u_clk_div_buf.clk_o : i1, i1
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
  hw.module private @prim_clock_gating_37(in %clk_i : i1, in %en_i : i1, in %test_en_i : i1, out clk_o : i1) {
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
  hw.module private @prim_flop_2sync(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %d_i_0 = llhd.sig name "d_i" %false : i1
    %d_o = llhd.sig %false : i1
    %1 = llhd.prb %d_o : i1
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_10(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i1) -> (q_o: i1) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_10(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i1) -> (q_o: i1)
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
  hw.module private @prim_flop_2sync_9(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %d_i_0 = llhd.sig name "d_i" %c0_i4 : i4
    %d_o = llhd.sig %c0_i4 : i4
    %1 = llhd.prb %d_o : i4
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i4) -> (q_o: i4) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i4) -> (q_o: i4)
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
  hw.module private @prim_flop_2sync_32(in %clk_i : i1, in %rst_ni : i1, in %d_i : i3, out q_o : i3) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i3 = hw.constant 0 : i3
    %d_i_0 = llhd.sig name "d_i" %c0_i3 : i3
    %d_o = llhd.sig %c0_i3 : i3
    %1 = llhd.prb %d_o : i3
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_64(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i3) -> (q_o: i3) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_64(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i3) -> (q_o: i3)
    %2 = llhd.prb %d_i_0 : i3
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %3 = llhd.prb %d_i_0 : i3
      llhd.drv %d_o, %3 after %0 : i3
      llhd.wait (%2, %1 : i3, i3), ^bb1
    }
    llhd.drv %d_i_0, %d_i after %0 : i3
    hw.output %u_sync_2.q_o : i3
  }
  hw.module private @prim_flop_2sync_60(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %d_i_0 = llhd.sig name "d_i" %false : i1
    %d_o = llhd.sig %false : i1
    %1 = llhd.prb %d_o : i1
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_67(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i1) -> (q_o: i1) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_67(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i1) -> (q_o: i1)
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
  hw.module private @prim_flop_2sync_62(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %d_i_0 = llhd.sig name "d_i" %c0_i4 : i4
    %d_o = llhd.sig %c0_i4 : i4
    %1 = llhd.prb %d_o : i4
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_68(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i4) -> (q_o: i4) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_68(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i4) -> (q_o: i4)
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
  hw.module private @prim_flop(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
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
  hw.module private @prim_flop_10(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
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
  hw.module private @prim_flop_30(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_o : i2) {
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
  hw.module private @prim_flop_36(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i4 = hw.constant 0 : i4
    %c6_i4 = hw.constant 6 : i4
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
      llhd.drv %q_o, %c6_i4 after %1 : i4
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
  hw.module private @prim_flop_61(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_o : i2) {
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
  hw.module private @prim_flop_64(in %clk_i : i1, in %rst_ni : i1, in %d_i : i3, out q_o : i3) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i3 = hw.constant 0 : i3
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %d_i_2 = llhd.sig name "d_i" %c0_i3 : i3
    %q_o = llhd.sig %c0_i3 : i3
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
      llhd.drv %q_o, %c0_i3 after %1 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %16 = llhd.prb %d_i_2 : i3
      llhd.drv %q_o, %16 after %1 : i3
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %d_i_2, %d_i after %0 : i3
    %4 = llhd.prb %q_o : i3
    hw.output %4 : i3
  }
  hw.module private @prim_flop_65(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
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
  hw.module private @prim_flop_66(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i4 = hw.constant 0 : i4
    %c-1_i4 = hw.constant -1 : i4
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
      llhd.drv %q_o, %c-1_i4 after %1 : i4
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
  hw.module private @prim_flop_67(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
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
  hw.module private @prim_flop_68(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
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
    %alert_req_trigger = llhd.sig %false : i1
    %alert_test_trigger = llhd.sig %false : i1
    %ping_trigger = llhd.sig %false : i1
    %alert_trigger = llhd.sig %false : i1
    %ping_n = hw.struct_extract %alert_rx_i["ping_n"] : !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>
    %ping_p = hw.struct_extract %alert_rx_i["ping_p"] : !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>
    %5 = comb.concat %ping_n, %ping_p : i1, i1
    %u_prim_buf_ping.out_o = hw.instance "u_prim_buf_ping" @prim_sec_anchor_buf_27(in_i: %5: i2) -> (out_o: i2)
    %6 = comb.extract %u_prim_buf_ping.out_o from 1 {sv.namehint = "ping_n"} : (i2) -> i1
    %7 = comb.extract %u_prim_buf_ping.out_o from 0 {sv.namehint = "ping_p"} : (i2) -> i1
    %u_decode_ping.level_o, %u_decode_ping.rise_o, %u_decode_ping.fall_o, %u_decode_ping.event_o, %u_decode_ping.sigint_o = hw.instance "u_decode_ping" @prim_diff_decode(clk_i: %3: i1, rst_ni: %4: i1, diff_pi: %7: i1, diff_ni: %6: i1) -> (level_o: i1, rise_o: i1, fall_o: i1, event_o: i1, sigint_o: i1) {sv.namehint = "ping_event"}
    %ack_n = hw.struct_extract %alert_rx_i["ack_n"] : !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>
    %ack_p = hw.struct_extract %alert_rx_i["ack_p"] : !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>
    %8 = comb.concat %ack_n, %ack_p : i1, i1
    %u_prim_buf_ack.out_o = hw.instance "u_prim_buf_ack" @prim_sec_anchor_buf_27(in_i: %8: i2) -> (out_o: i2)
    %9 = comb.extract %u_prim_buf_ack.out_o from 1 {sv.namehint = "ack_n"} : (i2) -> i1
    %10 = comb.extract %u_prim_buf_ack.out_o from 0 {sv.namehint = "ack_p"} : (i2) -> i1
    %u_decode_ack.level_o, %u_decode_ack.rise_o, %u_decode_ack.fall_o, %u_decode_ack.event_o, %u_decode_ack.sigint_o = hw.instance "u_decode_ack" @prim_diff_decode(clk_i: %3: i1, rst_ni: %4: i1, diff_pi: %10: i1, diff_ni: %9: i1) -> (level_o: i1, rise_o: i1, fall_o: i1, event_o: i1, sigint_o: i1) {sv.namehint = "ack_sigint"}
    llhd.drv %ack_level, %u_decode_ack.level_o after %1 : i1
    %u_prim_buf_in_req.out_o = hw.instance "u_prim_buf_in_req" @prim_sec_anchor_buf_28(in_i: %alert_req_i: i1) -> (out_o: i1) {sv.namehint = "alert_req"}
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
  hw.module private @prim_alert_sender_2(in %clk_i : i1, in %rst_ni : i1, in %alert_test_i : i1, in %alert_req_i : i1, out alert_ack_o : i1, out alert_state_o : i1, in %alert_rx_i : !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>, out alert_tx_o : !hw.struct<alert_p: i1, alert_n: i1>) {
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
    %u_prim_buf_ping.out_o = hw.instance "u_prim_buf_ping" @prim_sec_anchor_buf_27(in_i: %5: i2) -> (out_o: i2)
    %6 = comb.extract %u_prim_buf_ping.out_o from 1 {sv.namehint = "ping_n"} : (i2) -> i1
    %7 = comb.extract %u_prim_buf_ping.out_o from 0 {sv.namehint = "ping_p"} : (i2) -> i1
    %u_decode_ping.level_o, %u_decode_ping.rise_o, %u_decode_ping.fall_o, %u_decode_ping.event_o, %u_decode_ping.sigint_o = hw.instance "u_decode_ping" @prim_diff_decode(clk_i: %3: i1, rst_ni: %4: i1, diff_pi: %7: i1, diff_ni: %6: i1) -> (level_o: i1, rise_o: i1, fall_o: i1, event_o: i1, sigint_o: i1) {sv.namehint = "ping_event"}
    %ack_n = hw.struct_extract %alert_rx_i["ack_n"] : !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>
    %ack_p = hw.struct_extract %alert_rx_i["ack_p"] : !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>
    %8 = comb.concat %ack_n, %ack_p : i1, i1
    %u_prim_buf_ack.out_o = hw.instance "u_prim_buf_ack" @prim_sec_anchor_buf_27(in_i: %8: i2) -> (out_o: i2)
    %9 = comb.extract %u_prim_buf_ack.out_o from 1 {sv.namehint = "ack_n"} : (i2) -> i1
    %10 = comb.extract %u_prim_buf_ack.out_o from 0 {sv.namehint = "ack_p"} : (i2) -> i1
    %u_decode_ack.level_o, %u_decode_ack.rise_o, %u_decode_ack.fall_o, %u_decode_ack.event_o, %u_decode_ack.sigint_o = hw.instance "u_decode_ack" @prim_diff_decode(clk_i: %3: i1, rst_ni: %4: i1, diff_pi: %10: i1, diff_ni: %9: i1) -> (level_o: i1, rise_o: i1, fall_o: i1, event_o: i1, sigint_o: i1) {sv.namehint = "ack_sigint"}
    llhd.drv %ack_level, %u_decode_ack.level_o after %1 : i1
    %u_prim_buf_in_req.out_o = hw.instance "u_prim_buf_in_req" @prim_sec_anchor_buf_28(in_i: %alert_req_i: i1) -> (out_o: i1) {sv.namehint = "alert_req"}
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
  hw.module private @prim_clock_gating_sync(in %clk_i : i1, in %rst_ni : i1, in %test_en_i : i1, in %async_en_i : i1, out en_o : i1, out clk_o : i1) {
    %i_sync.q_o = hw.instance "i_sync" @prim_flop_2sync(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %async_en_i: i1) -> (q_o: i1)
    %i_cg.clk_o = hw.instance "i_cg" @prim_clock_gating(clk_i: %clk_i: i1, en_i: %i_sync.q_o: i1, test_en_i: %test_en_i: i1) -> (clk_o: i1)
    hw.output %i_sync.q_o, %i_cg.clk_o : i1, i1
  }
  hw.module private @prim_clock_meas(in %clk_i : i1, in %rst_ni : i1, in %clk_ref_i : i1, in %rst_ref_ni : i1, in %en_i : i1, in %max_cnt : i10, in %min_cnt : i10, out valid_o : i1, out fast_o : i1, out slow_o : i1, out timeout_clk_ref_o : i1, out ref_timeout_clk_o : i1) {
    %c-1_i10 = hw.constant -1 : i10
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c1_i11 = hw.constant 1 : i11
    %c0_i10 = hw.constant 0 : i10
    %c-1_i2 = hw.constant -1 : i2
    %true = hw.constant true
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %false = hw.constant false
    %c0_i2 = hw.constant 0 : i2
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %en_i_2 = llhd.sig name "en_i" %false : i1
    %valid_o = llhd.sig %false : i1
    %en_ref_sync = llhd.sig %false : i1
    %state_d = llhd.sig %c0_i2 : i2
    %state_q = llhd.sig %c0_i2 : i2
    %cnt_en = llhd.sig %false : i1
    %cnt_ovfl = llhd.sig %false : i1
    %cnt = llhd.sig %c0_i10 : i10
    %4 = llhd.prb %en_i_2 : i1
    %u_ref_meas_en_sync.q_o = hw.instance "u_ref_meas_en_sync" @prim_flop_2sync(clk_i: %clk_ref_i: i1, rst_ni: %rst_ref_ni: i1, d_i: %4: i1) -> (q_o: i1) {sv.namehint = "ref_en"}
    %ack_sync.q_o = hw.instance "ack_sync" @prim_flop_2sync(clk_i: %2: i1, rst_ni: %3: i1, d_i: %u_ref_meas_en_sync.q_o: i1) -> (q_o: i1)
    llhd.drv %en_ref_sync, %ack_sync.q_o after %1 : i1
    %u_sync_ref.dst_pulse_o = hw.instance "u_sync_ref" @prim_pulse_sync(clk_src_i: %clk_ref_i: i1, rst_src_ni: %rst_ref_ni: i1, src_pulse_i: %u_ref_meas_en_sync.q_o: i1, clk_dst_i: %2: i1, rst_dst_ni: %3: i1) -> (dst_pulse_o: i1) {sv.namehint = "valid"}
    %gen_clk_timeout_chk.u_timeout_ref_to_clk.timeout_o = hw.instance "gen_clk_timeout_chk.u_timeout_ref_to_clk" @prim_clock_timeout(clk_chk_i: %2: i1, rst_chk_ni: %3: i1, clk_i: %clk_ref_i: i1, rst_ni: %rst_ref_ni: i1, en_i: %u_ref_meas_en_sync.q_o: i1) -> (timeout_o: i1)
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %19 = llhd.prb %clk_i_0 : i1
      %20 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %state_q, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %30 = llhd.prb %state_d : i2
      llhd.drv %state_q, %30 after %0 : i2
      cf.br ^bb1
    }
    %5 = llhd.prb %state_q : i2
    %6 = llhd.prb %state_d : i2
    %7 = llhd.prb %cnt_en : i1
    %8 = llhd.prb %en_ref_sync : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb12
      %19 = llhd.prb %state_q : i2
      llhd.drv %state_d, %19 after %1 : i2
      llhd.drv %cnt_en, %false after %1 : i1
      %20 = llhd.prb %state_q : i2
      %21 = comb.icmp ceq %20, %c0_i2 : i2
      cf.cond_br %21, ^bb2, ^bb4
    ^bb2:  // pred: ^bb1
      %22 = llhd.prb %en_i_2 : i1
      cf.cond_br %22, ^bb3, ^bb12
    ^bb3:  // pred: ^bb2
      llhd.drv %state_d, %c1_i2 after %1 : i2
      cf.br ^bb12
    ^bb4:  // pred: ^bb1
      %23 = comb.icmp ceq %20, %c1_i2 : i2
      cf.cond_br %23, ^bb5, ^bb7
    ^bb5:  // pred: ^bb4
      %24 = llhd.prb %en_ref_sync : i1
      cf.cond_br %24, ^bb6, ^bb12
    ^bb6:  // pred: ^bb5
      llhd.drv %state_d, %c-2_i2 after %1 : i2
      cf.br ^bb12
    ^bb7:  // pred: ^bb4
      %25 = comb.icmp ceq %20, %c-2_i2 : i2
      cf.cond_br %25, ^bb8, ^bb10
    ^bb8:  // pred: ^bb7
      llhd.drv %cnt_en, %true after %1 : i1
      %26 = llhd.prb %en_i_2 : i1
      %27 = comb.xor %26, %true : i1
      cf.cond_br %27, ^bb9, ^bb12
    ^bb9:  // pred: ^bb8
      llhd.drv %state_d, %c-1_i2 after %1 : i2
      cf.br ^bb12
    ^bb10:  // pred: ^bb7
      %28 = llhd.prb %en_ref_sync : i1
      %29 = comb.xor %28, %true : i1
      cf.cond_br %29, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      llhd.drv %state_d, %c0_i2 after %1 : i2
      cf.br ^bb12
    ^bb12:  // 8 preds: ^bb2, ^bb3, ^bb5, ^bb6, ^bb8, ^bb9, ^bb10, ^bb11
      llhd.wait (%5, %6, %7, %4, %8 : i2, i2, i1, i1, i1), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 8 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb11, ^bb12
      %19 = llhd.prb %clk_i_0 : i1
      %20 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %cnt, %c0_i10 after %0 : i10
      llhd.drv %cnt_ovfl, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %30 = llhd.prb %cnt_en : i1
      %31 = comb.xor %30, %true : i1
      %32 = llhd.prb %cnt : i10
      %33 = comb.icmp ne %32, %c0_i10 : i10
      %34 = comb.and %31, %33 : i1
      cf.cond_br %34, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %cnt, %c0_i10 after %0 : i10
      llhd.drv %cnt_ovfl, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %35 = llhd.prb %valid_o : i1
      cf.cond_br %35, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %cnt, %c0_i10 after %0 : i10
      llhd.drv %cnt_ovfl, %false after %0 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %36 = llhd.prb %cnt_ovfl : i1
      cf.cond_br %36, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      llhd.drv %cnt, %c-1_i10 after %0 : i10
      cf.br ^bb1
    ^bb11:  // pred: ^bb9
      %37 = llhd.prb %cnt_en : i1
      cf.cond_br %37, ^bb12, ^bb1
    ^bb12:  // pred: ^bb11
      %38 = llhd.prb %cnt : i10
      %39 = comb.concat %false, %38 : i1, i10
      %40 = comb.add %39, %c1_i11 : i11
      %41 = comb.extract %40 from 10 : (i11) -> i1
      llhd.drv %cnt_ovfl, %41 after %0 : i1
      %42 = comb.extract %40 from 0 : (i11) -> i10
      llhd.drv %cnt, %42 after %0 : i10
      cf.br ^bb1
    }
    %9 = llhd.prb %cnt : i10
    %10 = comb.icmp ne %9, %c0_i10 : i10
    %11 = comb.and %u_sync_ref.dst_pulse_o, %10 : i1
    llhd.drv %valid_o, %11 after %1 : i1
    %12 = llhd.prb %valid_o : i1
    %13 = comb.icmp ugt %9, %max_cnt : i10
    %14 = llhd.prb %cnt_ovfl : i1
    %15 = comb.or %13, %14 : i1
    %16 = comb.and %12, %15 : i1
    %17 = comb.icmp ult %9, %min_cnt : i10
    %18 = comb.and %12, %17 : i1
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %en_i_2, %en_i after %1 : i1
    hw.output %12, %16, %18, %false, %gen_clk_timeout_chk.u_timeout_ref_to_clk.timeout_o : i1, i1, i1, i1, i1
  }
  hw.module private @prim_clock_meas_34(in %clk_i : i1, in %rst_ni : i1, in %clk_ref_i : i1, in %rst_ref_ni : i1, in %en_i : i1, in %max_cnt : i9, in %min_cnt : i9, out valid_o : i1, out fast_o : i1, out slow_o : i1, out timeout_clk_ref_o : i1, out ref_timeout_clk_o : i1) {
    %c-1_i9 = hw.constant -1 : i9
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c1_i10 = hw.constant 1 : i10
    %c0_i9 = hw.constant 0 : i9
    %c-1_i2 = hw.constant -1 : i2
    %true = hw.constant true
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %false = hw.constant false
    %c0_i2 = hw.constant 0 : i2
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %en_i_2 = llhd.sig name "en_i" %false : i1
    %valid_o = llhd.sig %false : i1
    %en_ref_sync = llhd.sig %false : i1
    %state_d = llhd.sig %c0_i2 : i2
    %state_q = llhd.sig %c0_i2 : i2
    %cnt_en = llhd.sig %false : i1
    %cnt_ovfl = llhd.sig %false : i1
    %cnt = llhd.sig %c0_i9 : i9
    %4 = llhd.prb %en_i_2 : i1
    %u_ref_meas_en_sync.q_o = hw.instance "u_ref_meas_en_sync" @prim_flop_2sync(clk_i: %clk_ref_i: i1, rst_ni: %rst_ref_ni: i1, d_i: %4: i1) -> (q_o: i1) {sv.namehint = "ref_en"}
    %ack_sync.q_o = hw.instance "ack_sync" @prim_flop_2sync(clk_i: %2: i1, rst_ni: %3: i1, d_i: %u_ref_meas_en_sync.q_o: i1) -> (q_o: i1)
    llhd.drv %en_ref_sync, %ack_sync.q_o after %1 : i1
    %u_sync_ref.dst_pulse_o = hw.instance "u_sync_ref" @prim_pulse_sync(clk_src_i: %clk_ref_i: i1, rst_src_ni: %rst_ref_ni: i1, src_pulse_i: %u_ref_meas_en_sync.q_o: i1, clk_dst_i: %2: i1, rst_dst_ni: %3: i1) -> (dst_pulse_o: i1) {sv.namehint = "valid"}
    %gen_clk_timeout_chk.u_timeout_ref_to_clk.timeout_o = hw.instance "gen_clk_timeout_chk.u_timeout_ref_to_clk" @prim_clock_timeout(clk_chk_i: %2: i1, rst_chk_ni: %3: i1, clk_i: %clk_ref_i: i1, rst_ni: %rst_ref_ni: i1, en_i: %u_ref_meas_en_sync.q_o: i1) -> (timeout_o: i1)
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %19 = llhd.prb %clk_i_0 : i1
      %20 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %state_q, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %30 = llhd.prb %state_d : i2
      llhd.drv %state_q, %30 after %0 : i2
      cf.br ^bb1
    }
    %5 = llhd.prb %state_q : i2
    %6 = llhd.prb %state_d : i2
    %7 = llhd.prb %cnt_en : i1
    %8 = llhd.prb %en_ref_sync : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb12
      %19 = llhd.prb %state_q : i2
      llhd.drv %state_d, %19 after %1 : i2
      llhd.drv %cnt_en, %false after %1 : i1
      %20 = llhd.prb %state_q : i2
      %21 = comb.icmp ceq %20, %c0_i2 : i2
      cf.cond_br %21, ^bb2, ^bb4
    ^bb2:  // pred: ^bb1
      %22 = llhd.prb %en_i_2 : i1
      cf.cond_br %22, ^bb3, ^bb12
    ^bb3:  // pred: ^bb2
      llhd.drv %state_d, %c1_i2 after %1 : i2
      cf.br ^bb12
    ^bb4:  // pred: ^bb1
      %23 = comb.icmp ceq %20, %c1_i2 : i2
      cf.cond_br %23, ^bb5, ^bb7
    ^bb5:  // pred: ^bb4
      %24 = llhd.prb %en_ref_sync : i1
      cf.cond_br %24, ^bb6, ^bb12
    ^bb6:  // pred: ^bb5
      llhd.drv %state_d, %c-2_i2 after %1 : i2
      cf.br ^bb12
    ^bb7:  // pred: ^bb4
      %25 = comb.icmp ceq %20, %c-2_i2 : i2
      cf.cond_br %25, ^bb8, ^bb10
    ^bb8:  // pred: ^bb7
      llhd.drv %cnt_en, %true after %1 : i1
      %26 = llhd.prb %en_i_2 : i1
      %27 = comb.xor %26, %true : i1
      cf.cond_br %27, ^bb9, ^bb12
    ^bb9:  // pred: ^bb8
      llhd.drv %state_d, %c-1_i2 after %1 : i2
      cf.br ^bb12
    ^bb10:  // pred: ^bb7
      %28 = llhd.prb %en_ref_sync : i1
      %29 = comb.xor %28, %true : i1
      cf.cond_br %29, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      llhd.drv %state_d, %c0_i2 after %1 : i2
      cf.br ^bb12
    ^bb12:  // 8 preds: ^bb2, ^bb3, ^bb5, ^bb6, ^bb8, ^bb9, ^bb10, ^bb11
      llhd.wait (%5, %6, %7, %4, %8 : i2, i2, i1, i1, i1), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 8 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb11, ^bb12
      %19 = llhd.prb %clk_i_0 : i1
      %20 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %cnt, %c0_i9 after %0 : i9
      llhd.drv %cnt_ovfl, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %30 = llhd.prb %cnt_en : i1
      %31 = comb.xor %30, %true : i1
      %32 = llhd.prb %cnt : i9
      %33 = comb.icmp ne %32, %c0_i9 : i9
      %34 = comb.and %31, %33 : i1
      cf.cond_br %34, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %cnt, %c0_i9 after %0 : i9
      llhd.drv %cnt_ovfl, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %35 = llhd.prb %valid_o : i1
      cf.cond_br %35, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %cnt, %c0_i9 after %0 : i9
      llhd.drv %cnt_ovfl, %false after %0 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %36 = llhd.prb %cnt_ovfl : i1
      cf.cond_br %36, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      llhd.drv %cnt, %c-1_i9 after %0 : i9
      cf.br ^bb1
    ^bb11:  // pred: ^bb9
      %37 = llhd.prb %cnt_en : i1
      cf.cond_br %37, ^bb12, ^bb1
    ^bb12:  // pred: ^bb11
      %38 = llhd.prb %cnt : i9
      %39 = comb.concat %false, %38 : i1, i9
      %40 = comb.add %39, %c1_i10 : i10
      %41 = comb.extract %40 from 9 : (i10) -> i1
      llhd.drv %cnt_ovfl, %41 after %0 : i1
      %42 = comb.extract %40 from 0 : (i10) -> i9
      llhd.drv %cnt, %42 after %0 : i9
      cf.br ^bb1
    }
    %9 = llhd.prb %cnt : i9
    %10 = comb.icmp ne %9, %c0_i9 : i9
    %11 = comb.and %u_sync_ref.dst_pulse_o, %10 : i1
    llhd.drv %valid_o, %11 after %1 : i1
    %12 = llhd.prb %valid_o : i1
    %13 = comb.icmp ugt %9, %max_cnt : i9
    %14 = llhd.prb %cnt_ovfl : i1
    %15 = comb.or %13, %14 : i1
    %16 = comb.and %12, %15 : i1
    %17 = comb.icmp ult %9, %min_cnt : i9
    %18 = comb.and %12, %17 : i1
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %en_i_2, %en_i after %1 : i1
    hw.output %12, %16, %18, %false, %gen_clk_timeout_chk.u_timeout_ref_to_clk.timeout_o : i1, i1, i1, i1, i1
  }
  hw.module private @prim_clock_meas_35(in %clk_i : i1, in %rst_ni : i1, in %clk_ref_i : i1, in %rst_ref_ni : i1, in %en_i : i1, in %max_cnt : i8, in %min_cnt : i8, out valid_o : i1, out fast_o : i1, out slow_o : i1, out timeout_clk_ref_o : i1, out ref_timeout_clk_o : i1) {
    %c-1_i8 = hw.constant -1 : i8
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c1_i9 = hw.constant 1 : i9
    %c0_i8 = hw.constant 0 : i8
    %c-1_i2 = hw.constant -1 : i2
    %true = hw.constant true
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %false = hw.constant false
    %c0_i2 = hw.constant 0 : i2
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %en_i_2 = llhd.sig name "en_i" %false : i1
    %valid_o = llhd.sig %false : i1
    %en_ref_sync = llhd.sig %false : i1
    %state_d = llhd.sig %c0_i2 : i2
    %state_q = llhd.sig %c0_i2 : i2
    %cnt_en = llhd.sig %false : i1
    %cnt_ovfl = llhd.sig %false : i1
    %cnt = llhd.sig %c0_i8 : i8
    %4 = llhd.prb %en_i_2 : i1
    %u_ref_meas_en_sync.q_o = hw.instance "u_ref_meas_en_sync" @prim_flop_2sync(clk_i: %clk_ref_i: i1, rst_ni: %rst_ref_ni: i1, d_i: %4: i1) -> (q_o: i1) {sv.namehint = "ref_en"}
    %ack_sync.q_o = hw.instance "ack_sync" @prim_flop_2sync(clk_i: %2: i1, rst_ni: %3: i1, d_i: %u_ref_meas_en_sync.q_o: i1) -> (q_o: i1)
    llhd.drv %en_ref_sync, %ack_sync.q_o after %1 : i1
    %u_sync_ref.dst_pulse_o = hw.instance "u_sync_ref" @prim_pulse_sync(clk_src_i: %clk_ref_i: i1, rst_src_ni: %rst_ref_ni: i1, src_pulse_i: %u_ref_meas_en_sync.q_o: i1, clk_dst_i: %2: i1, rst_dst_ni: %3: i1) -> (dst_pulse_o: i1) {sv.namehint = "valid"}
    %gen_clk_timeout_chk.u_timeout_ref_to_clk.timeout_o = hw.instance "gen_clk_timeout_chk.u_timeout_ref_to_clk" @prim_clock_timeout(clk_chk_i: %2: i1, rst_chk_ni: %3: i1, clk_i: %clk_ref_i: i1, rst_ni: %rst_ref_ni: i1, en_i: %u_ref_meas_en_sync.q_o: i1) -> (timeout_o: i1)
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %19 = llhd.prb %clk_i_0 : i1
      %20 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %state_q, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %30 = llhd.prb %state_d : i2
      llhd.drv %state_q, %30 after %0 : i2
      cf.br ^bb1
    }
    %5 = llhd.prb %state_q : i2
    %6 = llhd.prb %state_d : i2
    %7 = llhd.prb %cnt_en : i1
    %8 = llhd.prb %en_ref_sync : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb12
      %19 = llhd.prb %state_q : i2
      llhd.drv %state_d, %19 after %1 : i2
      llhd.drv %cnt_en, %false after %1 : i1
      %20 = llhd.prb %state_q : i2
      %21 = comb.icmp ceq %20, %c0_i2 : i2
      cf.cond_br %21, ^bb2, ^bb4
    ^bb2:  // pred: ^bb1
      %22 = llhd.prb %en_i_2 : i1
      cf.cond_br %22, ^bb3, ^bb12
    ^bb3:  // pred: ^bb2
      llhd.drv %state_d, %c1_i2 after %1 : i2
      cf.br ^bb12
    ^bb4:  // pred: ^bb1
      %23 = comb.icmp ceq %20, %c1_i2 : i2
      cf.cond_br %23, ^bb5, ^bb7
    ^bb5:  // pred: ^bb4
      %24 = llhd.prb %en_ref_sync : i1
      cf.cond_br %24, ^bb6, ^bb12
    ^bb6:  // pred: ^bb5
      llhd.drv %state_d, %c-2_i2 after %1 : i2
      cf.br ^bb12
    ^bb7:  // pred: ^bb4
      %25 = comb.icmp ceq %20, %c-2_i2 : i2
      cf.cond_br %25, ^bb8, ^bb10
    ^bb8:  // pred: ^bb7
      llhd.drv %cnt_en, %true after %1 : i1
      %26 = llhd.prb %en_i_2 : i1
      %27 = comb.xor %26, %true : i1
      cf.cond_br %27, ^bb9, ^bb12
    ^bb9:  // pred: ^bb8
      llhd.drv %state_d, %c-1_i2 after %1 : i2
      cf.br ^bb12
    ^bb10:  // pred: ^bb7
      %28 = llhd.prb %en_ref_sync : i1
      %29 = comb.xor %28, %true : i1
      cf.cond_br %29, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      llhd.drv %state_d, %c0_i2 after %1 : i2
      cf.br ^bb12
    ^bb12:  // 8 preds: ^bb2, ^bb3, ^bb5, ^bb6, ^bb8, ^bb9, ^bb10, ^bb11
      llhd.wait (%5, %6, %7, %4, %8 : i2, i2, i1, i1, i1), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 8 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb11, ^bb12
      %19 = llhd.prb %clk_i_0 : i1
      %20 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %cnt, %c0_i8 after %0 : i8
      llhd.drv %cnt_ovfl, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %30 = llhd.prb %cnt_en : i1
      %31 = comb.xor %30, %true : i1
      %32 = llhd.prb %cnt : i8
      %33 = comb.icmp ne %32, %c0_i8 : i8
      %34 = comb.and %31, %33 : i1
      cf.cond_br %34, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %cnt, %c0_i8 after %0 : i8
      llhd.drv %cnt_ovfl, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %35 = llhd.prb %valid_o : i1
      cf.cond_br %35, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %cnt, %c0_i8 after %0 : i8
      llhd.drv %cnt_ovfl, %false after %0 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %36 = llhd.prb %cnt_ovfl : i1
      cf.cond_br %36, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      llhd.drv %cnt, %c-1_i8 after %0 : i8
      cf.br ^bb1
    ^bb11:  // pred: ^bb9
      %37 = llhd.prb %cnt_en : i1
      cf.cond_br %37, ^bb12, ^bb1
    ^bb12:  // pred: ^bb11
      %38 = llhd.prb %cnt : i8
      %39 = comb.concat %false, %38 : i1, i8
      %40 = comb.add %39, %c1_i9 : i9
      %41 = comb.extract %40 from 8 : (i9) -> i1
      llhd.drv %cnt_ovfl, %41 after %0 : i1
      %42 = comb.extract %40 from 0 : (i9) -> i8
      llhd.drv %cnt, %42 after %0 : i8
      cf.br ^bb1
    }
    %9 = llhd.prb %cnt : i8
    %10 = comb.icmp ne %9, %c0_i8 : i8
    %11 = comb.and %u_sync_ref.dst_pulse_o, %10 : i1
    llhd.drv %valid_o, %11 after %1 : i1
    %12 = llhd.prb %valid_o : i1
    %13 = comb.icmp ugt %9, %max_cnt : i8
    %14 = llhd.prb %cnt_ovfl : i1
    %15 = comb.or %13, %14 : i1
    %16 = comb.and %12, %15 : i1
    %17 = comb.icmp ult %9, %min_cnt : i8
    %18 = comb.and %12, %17 : i1
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %en_i_2, %en_i after %1 : i1
    hw.output %12, %16, %18, %false, %gen_clk_timeout_chk.u_timeout_ref_to_clk.timeout_o : i1, i1, i1, i1, i1
  }
  hw.module private @prim_clock_timeout(in %clk_chk_i : i1, in %rst_chk_ni : i1, in %clk_i : i1, in %rst_ni : i1, in %en_i : i1, out timeout_o : i1) {
    %c-1_i3 = hw.constant -1 : i3
    %c5_i32 = hw.constant 5 : i32
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c0_i29 = hw.constant 0 : i29
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c1_i3 = hw.constant 1 : i3
    %c0_i3 = hw.constant 0 : i3
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %en_i_2 = llhd.sig name "en_i" %false : i1
    %cnt = llhd.sig %c0_i3 : i3
    %ack = llhd.sig %false : i1
    %timeout = llhd.sig %false : i1
    %u_ref_timeout.src_ack_o, %u_ref_timeout.dst_req_o = hw.instance "u_ref_timeout" @prim_sync_reqack(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_chk_i: i1, rst_dst_ni: %rst_chk_ni: i1, req_chk_i: %false: i1, src_req_i: %true: i1, dst_ack_i: %u_ref_timeout.dst_req_o: i1) -> (src_ack_o: i1, dst_req_o: i1) {sv.namehint = "chk_req"}
    llhd.drv %ack, %u_ref_timeout.src_ack_o after %1 : i1
    %4 = llhd.prb %timeout : i1
    %u_out.q_o = hw.instance "u_out" @prim_flop_10(clk_i: %2: i1, rst_ni: %3: i1, d_i: %4: i1) -> (q_o: i1)
    %5 = llhd.prb %cnt : i3
    %6 = comb.concat %c0_i29, %5 : i29, i3
    %7 = comb.icmp sgt %6, %c5_i32 : i32
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
      llhd.drv %cnt, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %19 = llhd.prb %ack : i1
      %20 = llhd.prb %en_i_2 : i1
      %21 = comb.xor %20, %true : i1
      %22 = comb.or %19, %21 : i1
      cf.cond_br %22, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %cnt, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %23 = llhd.prb %timeout : i1
      cf.cond_br %23, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %cnt, %c-1_i3 after %0 : i3
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %24 = llhd.prb %en_i_2 : i1
      cf.cond_br %24, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      %25 = llhd.prb %cnt : i3
      %26 = comb.add %25, %c1_i3 : i3
      llhd.drv %cnt, %26 after %0 : i3
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %en_i_2, %en_i after %1 : i1
    hw.output %u_out.q_o : i1
  }
  hw.module private @prim_count(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %set_i : i1, in %set_cnt_i : i4, in %incr_en_i : i1, in %decr_en_i : i1, in %step_i : i4, in %commit_i : i1, out cnt_o : i4, out cnt_after_commit_o : i4, out err_o : i1) {
    %c15_i5 = hw.constant 15 : i5
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i4 = hw.constant -1 : i4
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i5 = hw.constant 0 : i5
    %2 = hw.aggregate_constant [0 : i4, 0 : i4] : !hw.array<2xi4>
    %false = hw.constant false
    %true = hw.constant true
    %c0_i4 = hw.constant 0 : i4
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %set_i_2 = llhd.sig name "set_i" %false : i1
    %step_i_3 = llhd.sig name "step_i" %c0_i4 : i4
    %cnt_d = llhd.sig %2 : !hw.array<2xi4>
    %cnt_d_committed = llhd.sig %2 : !hw.array<2xi4>
    %cnt_q = llhd.sig %2 : !hw.array<2xi4>
    %gen_cnts_0.incr_en = llhd.sig %false : i1
    %gen_cnts_0.set_val = llhd.sig %c0_i4 : i4
    %gen_cnts_0.ext_cnt = llhd.sig %c0_i5 : i5
    %gen_cnts_0.oflow = llhd.sig %false : i1
    %gen_cnts_0.cnt_sat = llhd.sig %c0_i4 : i4
    %gen_cnts_0.cnt_en = llhd.sig %false : i1
    %gen_cnts_1.incr_en = llhd.sig %false : i1
    %gen_cnts_1.set_val = llhd.sig %c0_i4 : i4
    %gen_cnts_1.ext_cnt = llhd.sig %c0_i5 : i5
    %gen_cnts_1.oflow = llhd.sig %false : i1
    %gen_cnts_1.cnt_sat = llhd.sig %c0_i4 : i4
    %gen_cnts_1.cnt_en = llhd.sig %false : i1
    %err_d = llhd.sig %false : i1
    %err_q = llhd.sig %false : i1
    %5 = llhd.prb %cnt_d_committed : !hw.array<2xi4>
    %6 = hw.array_get %5[%false] : !hw.array<2xi4>, i1
    %gen_cnts_0.u_cnt_flop.q_o = hw.instance "gen_cnts_0.u_cnt_flop" @prim_flop_65(clk_i: %3: i1, rst_ni: %4: i1, d_i: %6: i4) -> (q_o: i4) {sv.namehint = "gen_cnts_0.cnt_unforced_q"}
    %7 = hw.array_get %5[%true] : !hw.array<2xi4>, i1
    %gen_cnts_1.u_cnt_flop.q_o = hw.instance "gen_cnts_1.u_cnt_flop" @prim_flop_66(clk_i: %3: i1, rst_ni: %4: i1, d_i: %7: i4) -> (q_o: i4) {sv.namehint = "gen_cnts_1.cnt_unforced_q"}
    llhd.drv %gen_cnts_0.incr_en, %incr_en_i after %1 : i1
    llhd.drv %gen_cnts_0.set_val, %set_cnt_i after %1 : i4
    %8 = llhd.prb %cnt_q : !hw.array<2xi4>
    %9 = hw.array_get %8[%false] : !hw.array<2xi4>, i1
    %10 = comb.concat %false, %9 : i1, i4
    %11 = llhd.prb %step_i_3 : i4
    %12 = comb.concat %false, %11 : i1, i4
    %13 = comb.sub %10, %12 : i5
    %14 = llhd.prb %gen_cnts_0.incr_en : i1
    %15 = comb.add %10, %12 : i5
    %16 = comb.mux %14, %15, %10 : i5
    %17 = comb.mux %decr_en_i, %13, %16 : i5
    llhd.drv %gen_cnts_0.ext_cnt, %17 after %1 : i5
    %18 = llhd.prb %gen_cnts_0.ext_cnt : i5
    %19 = comb.extract %18 from 4 : (i5) -> i1
    %20 = comb.and %14, %19 : i1
    llhd.drv %gen_cnts_0.oflow, %20 after %1 : i1
    %21 = comb.and %decr_en_i, %19 {sv.namehint = "gen_cnts_0.uflow"} : i1
    %22 = llhd.prb %gen_cnts_0.oflow : i1
    %23 = comb.extract %18 from 0 : (i5) -> i4
    %24 = comb.mux %22, %c-1_i4, %23 : i4
    %25 = comb.mux %21, %c0_i4, %24 : i4
    llhd.drv %gen_cnts_0.cnt_sat, %25 after %1 : i4
    %26 = comb.xor %14, %decr_en_i : i1
    %27 = comb.icmp ne %9, %c-1_i4 : i4
    %28 = comb.and %14, %27 : i1
    %29 = comb.icmp ne %9, %c0_i4 : i4
    %30 = comb.and %decr_en_i, %29 : i1
    %31 = comb.or %28, %30 : i1
    %32 = comb.and %26, %31 : i1
    llhd.drv %gen_cnts_0.cnt_en, %32 after %1 : i1
    %33 = llhd.sig.array_get %cnt_d[%false] : <!hw.array<2xi4>>
    %34 = llhd.prb %set_i_2 : i1
    %35 = llhd.prb %gen_cnts_0.set_val : i4
    %36 = llhd.prb %gen_cnts_0.cnt_en : i1
    %37 = llhd.prb %gen_cnts_0.cnt_sat : i4
    %38 = comb.mux %36, %37, %9 : i4
    %39 = comb.mux %34, %35, %38 : i4
    %40 = comb.mux %clr_i, %c0_i4, %39 : i4
    llhd.drv %33, %40 after %1 : i4
    %41 = llhd.sig.array_get %cnt_d_committed[%false] : <!hw.array<2xi4>>
    %42 = llhd.prb %cnt_d : !hw.array<2xi4>
    %43 = hw.array_get %42[%false] : !hw.array<2xi4>, i1
    %44 = comb.mux %commit_i, %43, %9 : i4
    llhd.drv %41, %44 after %1 : i4
    %45 = llhd.sig.array_get %cnt_q[%false] : <!hw.array<2xi4>>
    llhd.drv %45, %gen_cnts_0.u_cnt_flop.q_o after %1 : i4
    llhd.drv %gen_cnts_1.incr_en, %decr_en_i after %1 : i1
    %46 = comb.sub %c-1_i4, %set_cnt_i : i4
    llhd.drv %gen_cnts_1.set_val, %46 after %1 : i4
    %47 = hw.array_get %8[%true] : !hw.array<2xi4>, i1
    %48 = comb.concat %false, %47 : i1, i4
    %49 = comb.sub %48, %12 : i5
    %50 = llhd.prb %gen_cnts_1.incr_en : i1
    %51 = comb.add %48, %12 : i5
    %52 = comb.mux %50, %51, %48 : i5
    %53 = comb.mux %incr_en_i, %49, %52 : i5
    llhd.drv %gen_cnts_1.ext_cnt, %53 after %1 : i5
    %54 = llhd.prb %gen_cnts_1.ext_cnt : i5
    %55 = comb.extract %54 from 4 : (i5) -> i1
    %56 = comb.and %50, %55 : i1
    llhd.drv %gen_cnts_1.oflow, %56 after %1 : i1
    %57 = comb.and %incr_en_i, %55 {sv.namehint = "gen_cnts_1.uflow"} : i1
    %58 = llhd.prb %gen_cnts_1.oflow : i1
    %59 = comb.extract %54 from 0 : (i5) -> i4
    %60 = comb.mux %58, %c-1_i4, %59 : i4
    %61 = comb.mux %57, %c0_i4, %60 : i4
    llhd.drv %gen_cnts_1.cnt_sat, %61 after %1 : i4
    %62 = comb.xor %50, %incr_en_i : i1
    %63 = comb.icmp ne %47, %c-1_i4 : i4
    %64 = comb.and %50, %63 : i1
    %65 = comb.icmp ne %47, %c0_i4 : i4
    %66 = comb.and %incr_en_i, %65 : i1
    %67 = comb.or %64, %66 : i1
    %68 = comb.and %62, %67 : i1
    llhd.drv %gen_cnts_1.cnt_en, %68 after %1 : i1
    %69 = llhd.sig.array_get %cnt_d[%true] : <!hw.array<2xi4>>
    %70 = llhd.prb %gen_cnts_1.set_val : i4
    %71 = llhd.prb %gen_cnts_1.cnt_en : i1
    %72 = llhd.prb %gen_cnts_1.cnt_sat : i4
    %73 = comb.mux %71, %72, %47 : i4
    %74 = comb.mux %34, %70, %73 : i4
    %75 = comb.mux %clr_i, %c-1_i4, %74 : i4
    llhd.drv %69, %75 after %1 : i4
    %76 = llhd.sig.array_get %cnt_d_committed[%true] : <!hw.array<2xi4>>
    %77 = hw.array_get %42[%true] : !hw.array<2xi4>, i1
    %78 = comb.mux %commit_i, %77, %47 : i4
    llhd.drv %76, %78 after %1 : i4
    %79 = llhd.sig.array_get %cnt_q[%true] : <!hw.array<2xi4>>
    llhd.drv %79, %gen_cnts_1.u_cnt_flop.q_o after %1 : i4
    %80 = comb.add %10, %48 {sv.namehint = "sum"} : i5
    %81 = comb.icmp ne %80, %c15_i5 : i5
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
    llhd.drv %step_i_3, %step_i after %1 : i4
    hw.output %9, %43, %82 : i4, i4, i1
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
    %gen_async.i_sync_n.q_o = hw.instance "gen_async.i_sync_n" @prim_flop_2sync_60(clk_i: %2: i1, rst_ni: %3: i1, d_i: %diff_ni: i1) -> (q_o: i1)
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
    %g_sync.u_sync.q_o = hw.instance "g_sync.u_sync" @prim_flop_2sync(clk_i: %2: i1, rst_ni: %3: i1, d_i: %d_i: i1) -> (q_o: i1)
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
  func.func private @"prim_mubi_pkg::mubi4_and_hi"(%arg0: i4, %arg1: i4) -> i4 {
    %c6_i4 = hw.constant 6 : i4
    %0 = call @"prim_mubi_pkg::mubi4_and"(%arg0, %arg1, %c6_i4) : (i4, i4, i4) -> i4
    return %0 : i4
  }
  hw.module private @prim_onehot_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i22, in %addr_i : i5, in %en_i : i1, out err_o : i1) {
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
    %480 = comb.extract %oh_i from 0 : (i22) -> i1
    llhd.drv %479, %480 after %0 : i1
    %481 = llhd.sig.extract %and_tree from %c31_i6 : <i63> -> <i1>
    llhd.drv %481, %480 after %0 : i1
    %482 = llhd.sig.extract %err_tree from %c31_i6 : <i63> -> <i1>
    llhd.drv %482, %false after %0 : i1
    %483 = llhd.sig.extract %or_tree from %c-32_i6 : <i63> -> <i1>
    %484 = comb.extract %oh_i from 1 : (i22) -> i1
    llhd.drv %483, %484 after %0 : i1
    %485 = llhd.sig.extract %and_tree from %c-32_i6 : <i63> -> <i1>
    llhd.drv %485, %484 after %0 : i1
    %486 = llhd.sig.extract %err_tree from %c-32_i6 : <i63> -> <i1>
    llhd.drv %486, %false after %0 : i1
    %487 = llhd.sig.extract %or_tree from %c-31_i6 : <i63> -> <i1>
    %488 = comb.extract %oh_i from 2 : (i22) -> i1
    llhd.drv %487, %488 after %0 : i1
    %489 = llhd.sig.extract %and_tree from %c-31_i6 : <i63> -> <i1>
    llhd.drv %489, %488 after %0 : i1
    %490 = llhd.sig.extract %err_tree from %c-31_i6 : <i63> -> <i1>
    llhd.drv %490, %false after %0 : i1
    %491 = llhd.sig.extract %or_tree from %c-30_i6 : <i63> -> <i1>
    %492 = comb.extract %oh_i from 3 : (i22) -> i1
    llhd.drv %491, %492 after %0 : i1
    %493 = llhd.sig.extract %and_tree from %c-30_i6 : <i63> -> <i1>
    llhd.drv %493, %492 after %0 : i1
    %494 = llhd.sig.extract %err_tree from %c-30_i6 : <i63> -> <i1>
    llhd.drv %494, %false after %0 : i1
    %495 = llhd.sig.extract %or_tree from %c-29_i6 : <i63> -> <i1>
    %496 = comb.extract %oh_i from 4 : (i22) -> i1
    llhd.drv %495, %496 after %0 : i1
    %497 = llhd.sig.extract %and_tree from %c-29_i6 : <i63> -> <i1>
    llhd.drv %497, %496 after %0 : i1
    %498 = llhd.sig.extract %err_tree from %c-29_i6 : <i63> -> <i1>
    llhd.drv %498, %false after %0 : i1
    %499 = llhd.sig.extract %or_tree from %c-28_i6 : <i63> -> <i1>
    %500 = comb.extract %oh_i from 5 : (i22) -> i1
    llhd.drv %499, %500 after %0 : i1
    %501 = llhd.sig.extract %and_tree from %c-28_i6 : <i63> -> <i1>
    llhd.drv %501, %500 after %0 : i1
    %502 = llhd.sig.extract %err_tree from %c-28_i6 : <i63> -> <i1>
    llhd.drv %502, %false after %0 : i1
    %503 = llhd.sig.extract %or_tree from %c-27_i6 : <i63> -> <i1>
    %504 = comb.extract %oh_i from 6 : (i22) -> i1
    llhd.drv %503, %504 after %0 : i1
    %505 = llhd.sig.extract %and_tree from %c-27_i6 : <i63> -> <i1>
    llhd.drv %505, %504 after %0 : i1
    %506 = llhd.sig.extract %err_tree from %c-27_i6 : <i63> -> <i1>
    llhd.drv %506, %false after %0 : i1
    %507 = llhd.sig.extract %or_tree from %c-26_i6 : <i63> -> <i1>
    %508 = comb.extract %oh_i from 7 : (i22) -> i1
    llhd.drv %507, %508 after %0 : i1
    %509 = llhd.sig.extract %and_tree from %c-26_i6 : <i63> -> <i1>
    llhd.drv %509, %508 after %0 : i1
    %510 = llhd.sig.extract %err_tree from %c-26_i6 : <i63> -> <i1>
    llhd.drv %510, %false after %0 : i1
    %511 = llhd.sig.extract %or_tree from %c-25_i6 : <i63> -> <i1>
    %512 = comb.extract %oh_i from 8 : (i22) -> i1
    llhd.drv %511, %512 after %0 : i1
    %513 = llhd.sig.extract %and_tree from %c-25_i6 : <i63> -> <i1>
    llhd.drv %513, %512 after %0 : i1
    %514 = llhd.sig.extract %err_tree from %c-25_i6 : <i63> -> <i1>
    llhd.drv %514, %false after %0 : i1
    %515 = llhd.sig.extract %or_tree from %c-24_i6 : <i63> -> <i1>
    %516 = comb.extract %oh_i from 9 : (i22) -> i1
    llhd.drv %515, %516 after %0 : i1
    %517 = llhd.sig.extract %and_tree from %c-24_i6 : <i63> -> <i1>
    llhd.drv %517, %516 after %0 : i1
    %518 = llhd.sig.extract %err_tree from %c-24_i6 : <i63> -> <i1>
    llhd.drv %518, %false after %0 : i1
    %519 = llhd.sig.extract %or_tree from %c-23_i6 : <i63> -> <i1>
    %520 = comb.extract %oh_i from 10 : (i22) -> i1
    llhd.drv %519, %520 after %0 : i1
    %521 = llhd.sig.extract %and_tree from %c-23_i6 : <i63> -> <i1>
    llhd.drv %521, %520 after %0 : i1
    %522 = llhd.sig.extract %err_tree from %c-23_i6 : <i63> -> <i1>
    llhd.drv %522, %false after %0 : i1
    %523 = llhd.sig.extract %or_tree from %c-22_i6 : <i63> -> <i1>
    %524 = comb.extract %oh_i from 11 : (i22) -> i1
    llhd.drv %523, %524 after %0 : i1
    %525 = llhd.sig.extract %and_tree from %c-22_i6 : <i63> -> <i1>
    llhd.drv %525, %524 after %0 : i1
    %526 = llhd.sig.extract %err_tree from %c-22_i6 : <i63> -> <i1>
    llhd.drv %526, %false after %0 : i1
    %527 = llhd.sig.extract %or_tree from %c-21_i6 : <i63> -> <i1>
    %528 = comb.extract %oh_i from 12 : (i22) -> i1
    llhd.drv %527, %528 after %0 : i1
    %529 = llhd.sig.extract %and_tree from %c-21_i6 : <i63> -> <i1>
    llhd.drv %529, %528 after %0 : i1
    %530 = llhd.sig.extract %err_tree from %c-21_i6 : <i63> -> <i1>
    llhd.drv %530, %false after %0 : i1
    %531 = llhd.sig.extract %or_tree from %c-20_i6 : <i63> -> <i1>
    %532 = comb.extract %oh_i from 13 : (i22) -> i1
    llhd.drv %531, %532 after %0 : i1
    %533 = llhd.sig.extract %and_tree from %c-20_i6 : <i63> -> <i1>
    llhd.drv %533, %532 after %0 : i1
    %534 = llhd.sig.extract %err_tree from %c-20_i6 : <i63> -> <i1>
    llhd.drv %534, %false after %0 : i1
    %535 = llhd.sig.extract %or_tree from %c-19_i6 : <i63> -> <i1>
    %536 = comb.extract %oh_i from 14 : (i22) -> i1
    llhd.drv %535, %536 after %0 : i1
    %537 = llhd.sig.extract %and_tree from %c-19_i6 : <i63> -> <i1>
    llhd.drv %537, %536 after %0 : i1
    %538 = llhd.sig.extract %err_tree from %c-19_i6 : <i63> -> <i1>
    llhd.drv %538, %false after %0 : i1
    %539 = llhd.sig.extract %or_tree from %c-18_i6 : <i63> -> <i1>
    %540 = comb.extract %oh_i from 15 : (i22) -> i1
    llhd.drv %539, %540 after %0 : i1
    %541 = llhd.sig.extract %and_tree from %c-18_i6 : <i63> -> <i1>
    llhd.drv %541, %540 after %0 : i1
    %542 = llhd.sig.extract %err_tree from %c-18_i6 : <i63> -> <i1>
    llhd.drv %542, %false after %0 : i1
    %543 = llhd.sig.extract %or_tree from %c-17_i6 : <i63> -> <i1>
    %544 = comb.extract %oh_i from 16 : (i22) -> i1
    llhd.drv %543, %544 after %0 : i1
    %545 = llhd.sig.extract %and_tree from %c-17_i6 : <i63> -> <i1>
    llhd.drv %545, %544 after %0 : i1
    %546 = llhd.sig.extract %err_tree from %c-17_i6 : <i63> -> <i1>
    llhd.drv %546, %false after %0 : i1
    %547 = llhd.sig.extract %or_tree from %c-16_i6 : <i63> -> <i1>
    %548 = comb.extract %oh_i from 17 : (i22) -> i1
    llhd.drv %547, %548 after %0 : i1
    %549 = llhd.sig.extract %and_tree from %c-16_i6 : <i63> -> <i1>
    llhd.drv %549, %548 after %0 : i1
    %550 = llhd.sig.extract %err_tree from %c-16_i6 : <i63> -> <i1>
    llhd.drv %550, %false after %0 : i1
    %551 = llhd.sig.extract %or_tree from %c-15_i6 : <i63> -> <i1>
    %552 = comb.extract %oh_i from 18 : (i22) -> i1
    llhd.drv %551, %552 after %0 : i1
    %553 = llhd.sig.extract %and_tree from %c-15_i6 : <i63> -> <i1>
    llhd.drv %553, %552 after %0 : i1
    %554 = llhd.sig.extract %err_tree from %c-15_i6 : <i63> -> <i1>
    llhd.drv %554, %false after %0 : i1
    %555 = llhd.sig.extract %or_tree from %c-14_i6 : <i63> -> <i1>
    %556 = comb.extract %oh_i from 19 : (i22) -> i1
    llhd.drv %555, %556 after %0 : i1
    %557 = llhd.sig.extract %and_tree from %c-14_i6 : <i63> -> <i1>
    llhd.drv %557, %556 after %0 : i1
    %558 = llhd.sig.extract %err_tree from %c-14_i6 : <i63> -> <i1>
    llhd.drv %558, %false after %0 : i1
    %559 = llhd.sig.extract %or_tree from %c-13_i6 : <i63> -> <i1>
    %560 = comb.extract %oh_i from 20 : (i22) -> i1
    llhd.drv %559, %560 after %0 : i1
    %561 = llhd.sig.extract %and_tree from %c-13_i6 : <i63> -> <i1>
    llhd.drv %561, %560 after %0 : i1
    %562 = llhd.sig.extract %err_tree from %c-13_i6 : <i63> -> <i1>
    llhd.drv %562, %false after %0 : i1
    %563 = llhd.sig.extract %or_tree from %c-12_i6 : <i63> -> <i1>
    %564 = comb.extract %oh_i from 21 : (i22) -> i1
    llhd.drv %563, %564 after %0 : i1
    %565 = llhd.sig.extract %and_tree from %c-12_i6 : <i63> -> <i1>
    llhd.drv %565, %564 after %0 : i1
    %566 = llhd.sig.extract %err_tree from %c-12_i6 : <i63> -> <i1>
    llhd.drv %566, %false after %0 : i1
    %567 = llhd.sig.extract %or_tree from %c-11_i6 : <i63> -> <i1>
    llhd.drv %567, %false after %0 : i1
    %568 = llhd.sig.extract %and_tree from %c-11_i6 : <i63> -> <i1>
    llhd.drv %568, %false after %0 : i1
    %569 = llhd.sig.extract %err_tree from %c-11_i6 : <i63> -> <i1>
    llhd.drv %569, %false after %0 : i1
    %570 = llhd.sig.extract %or_tree from %c-10_i6 : <i63> -> <i1>
    llhd.drv %570, %false after %0 : i1
    %571 = llhd.sig.extract %and_tree from %c-10_i6 : <i63> -> <i1>
    llhd.drv %571, %false after %0 : i1
    %572 = llhd.sig.extract %err_tree from %c-10_i6 : <i63> -> <i1>
    llhd.drv %572, %false after %0 : i1
    %573 = llhd.sig.extract %or_tree from %c-9_i6 : <i63> -> <i1>
    llhd.drv %573, %false after %0 : i1
    %574 = llhd.sig.extract %and_tree from %c-9_i6 : <i63> -> <i1>
    llhd.drv %574, %false after %0 : i1
    %575 = llhd.sig.extract %err_tree from %c-9_i6 : <i63> -> <i1>
    llhd.drv %575, %false after %0 : i1
    %576 = llhd.sig.extract %or_tree from %c-8_i6 : <i63> -> <i1>
    llhd.drv %576, %false after %0 : i1
    %577 = llhd.sig.extract %and_tree from %c-8_i6 : <i63> -> <i1>
    llhd.drv %577, %false after %0 : i1
    %578 = llhd.sig.extract %err_tree from %c-8_i6 : <i63> -> <i1>
    llhd.drv %578, %false after %0 : i1
    %579 = llhd.sig.extract %or_tree from %c-7_i6 : <i63> -> <i1>
    llhd.drv %579, %false after %0 : i1
    %580 = llhd.sig.extract %and_tree from %c-7_i6 : <i63> -> <i1>
    llhd.drv %580, %false after %0 : i1
    %581 = llhd.sig.extract %err_tree from %c-7_i6 : <i63> -> <i1>
    llhd.drv %581, %false after %0 : i1
    %582 = llhd.sig.extract %or_tree from %c-6_i6 : <i63> -> <i1>
    llhd.drv %582, %false after %0 : i1
    %583 = llhd.sig.extract %and_tree from %c-6_i6 : <i63> -> <i1>
    llhd.drv %583, %false after %0 : i1
    %584 = llhd.sig.extract %err_tree from %c-6_i6 : <i63> -> <i1>
    llhd.drv %584, %false after %0 : i1
    %585 = llhd.sig.extract %or_tree from %c-5_i6 : <i63> -> <i1>
    llhd.drv %585, %false after %0 : i1
    %586 = llhd.sig.extract %and_tree from %c-5_i6 : <i63> -> <i1>
    llhd.drv %586, %false after %0 : i1
    %587 = llhd.sig.extract %err_tree from %c-5_i6 : <i63> -> <i1>
    llhd.drv %587, %false after %0 : i1
    %588 = llhd.sig.extract %or_tree from %c-4_i6 : <i63> -> <i1>
    llhd.drv %588, %false after %0 : i1
    %589 = llhd.sig.extract %and_tree from %c-4_i6 : <i63> -> <i1>
    llhd.drv %589, %false after %0 : i1
    %590 = llhd.sig.extract %err_tree from %c-4_i6 : <i63> -> <i1>
    llhd.drv %590, %false after %0 : i1
    %591 = llhd.sig.extract %or_tree from %c-3_i6 : <i63> -> <i1>
    llhd.drv %591, %false after %0 : i1
    %592 = llhd.sig.extract %and_tree from %c-3_i6 : <i63> -> <i1>
    llhd.drv %592, %false after %0 : i1
    %593 = llhd.sig.extract %err_tree from %c-3_i6 : <i63> -> <i1>
    llhd.drv %593, %false after %0 : i1
    %594 = llhd.sig.extract %or_tree from %c-2_i6 : <i63> -> <i1>
    llhd.drv %594, %false after %0 : i1
    %595 = llhd.sig.extract %and_tree from %c-2_i6 : <i63> -> <i1>
    llhd.drv %595, %false after %0 : i1
    %596 = llhd.sig.extract %err_tree from %c-2_i6 : <i63> -> <i1>
    llhd.drv %596, %false after %0 : i1
    %597 = comb.or %598, %601 : i1
    %598 = comb.extract %17 from 0 {sv.namehint = "oh0_err"} : (i63) -> i1
    %599 = comb.xor %en_i, %true : i1
    %600 = comb.extract %2 from 0 : (i63) -> i1
    %601 = comb.and %599, %600 {sv.namehint = "enable_err"} : i1
    hw.output %597 : i1
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
  hw.module private @prim_reg_cdc_arb(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, out src_ack_o : i1, out src_update_o : i1, in %dst_req_i : i1, out dst_req_o : i1, in %dst_update_i : i1, in %dst_ds_i : i4, in %dst_qs_i : i4, out dst_qs_o : i4) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %c-7_i4 = hw.constant -7 : i4
    %false = hw.constant false
    %true = hw.constant true
    %clk_dst_i_0 = llhd.sig name "clk_dst_i" %false : i1
    %2 = llhd.prb %clk_dst_i_0 : i1
    %rst_dst_ni_1 = llhd.sig name "rst_dst_ni" %false : i1
    %3 = llhd.prb %rst_dst_ni_1 : i1
    %dst_req_i_2 = llhd.sig name "dst_req_i" %false : i1
    %dst_ds_i_3 = llhd.sig name "dst_ds_i" %c0_i4 : i4
    %dst_qs_i_4 = llhd.sig name "dst_qs_i" %c0_i4 : i4
    %dst_qs_o = llhd.sig %c0_i4 : i4
    %dst_update = llhd.sig %false : i1
    %gen_wr_req.dst_lat_q = llhd.sig %false : i1
    %gen_wr_req.dst_lat_d = llhd.sig %false : i1
    %gen_wr_req.dst_update_ack = llhd.sig %false : i1
    %gen_wr_req.id_q = llhd.sig %false : i1
    %gen_wr_req.idle_q = llhd.sig %false : i1
    %gen_wr_req.idle_d = llhd.sig %false : i1
    %gen_wr_req.dst_req_q = llhd.sig %false : i1
    %gen_wr_req.dst_req = llhd.sig %false : i1
    %gen_wr_req.dst_hold_req = llhd.sig %false : i1
    %gen_wr_req.u_dst_update_sync.src_ack_o, %gen_wr_req.u_dst_update_sync.dst_req_o = hw.instance "gen_wr_req.u_dst_update_sync" @prim_sync_reqack(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_src_i: i1, rst_dst_ni: %rst_src_ni: i1, req_chk_i: %true: i1, src_req_i: %21: i1, dst_ack_i: %gen_wr_req.u_dst_update_sync.dst_req_o: i1) -> (src_ack_o: i1, dst_req_o: i1) {sv.namehint = "gen_wr_req.src_req"}
    llhd.drv %gen_wr_req.dst_update_ack, %gen_wr_req.u_dst_update_sync.src_ack_o after %1 : i1
    %4 = llhd.prb %dst_qs_o : i4
    %5 = llhd.prb %dst_ds_i_3 : i4
    %6 = comb.icmp ne %4, %5 : i4
    %7 = comb.and %dst_update_i, %6 : i1
    llhd.drv %dst_update, %7 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %26 = llhd.prb %clk_dst_i_0 : i1
      %27 = llhd.prb %rst_dst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %28 = llhd.prb %clk_dst_i_0 : i1
      %29 = comb.xor bin %26, %true : i1
      %30 = comb.and bin %29, %28 : i1
      %31 = llhd.prb %rst_dst_ni_1 : i1
      %32 = comb.xor bin %31, %true : i1
      %33 = comb.and bin %27, %32 : i1
      %34 = comb.or bin %30, %33 : i1
      cf.cond_br %34, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %35 = llhd.prb %rst_dst_ni_1 : i1
      %36 = comb.xor %35, %true : i1
      cf.cond_br %36, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_wr_req.idle_q, %true after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %37 = llhd.prb %gen_wr_req.idle_d : i1
      llhd.drv %gen_wr_req.idle_q, %37 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %26 = llhd.prb %clk_dst_i_0 : i1
      %27 = llhd.prb %rst_dst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %28 = llhd.prb %clk_dst_i_0 : i1
      %29 = comb.xor bin %26, %true : i1
      %30 = comb.and bin %29, %28 : i1
      %31 = llhd.prb %rst_dst_ni_1 : i1
      %32 = comb.xor bin %31, %true : i1
      %33 = comb.and bin %27, %32 : i1
      %34 = comb.or bin %30, %33 : i1
      cf.cond_br %34, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %35 = llhd.prb %rst_dst_ni_1 : i1
      %36 = comb.xor %35, %true : i1
      cf.cond_br %36, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_wr_req.dst_req_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %37 = llhd.prb %gen_wr_req.dst_req_q : i1
      %38 = llhd.prb %gen_wr_req.dst_lat_d : i1
      %39 = comb.and %37, %38 : i1
      cf.cond_br %39, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %gen_wr_req.dst_req_q, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %40 = llhd.prb %dst_req_i_2 : i1
      %41 = llhd.prb %gen_wr_req.idle_q : i1
      %42 = comb.xor %41, %true : i1
      %43 = comb.and %40, %42 : i1
      cf.cond_br %43, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %gen_wr_req.dst_req_q, %true after %0 : i1
      cf.br ^bb1
    }
    %8 = llhd.prb %gen_wr_req.dst_req_q : i1
    %9 = llhd.prb %dst_req_i_2 : i1
    %10 = comb.or %8, %9 : i1
    llhd.drv %gen_wr_req.dst_req, %10 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %26 = llhd.prb %clk_dst_i_0 : i1
      %27 = llhd.prb %rst_dst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %28 = llhd.prb %clk_dst_i_0 : i1
      %29 = comb.xor bin %26, %true : i1
      %30 = comb.and bin %29, %28 : i1
      %31 = llhd.prb %rst_dst_ni_1 : i1
      %32 = comb.xor bin %31, %true : i1
      %33 = comb.and bin %27, %32 : i1
      %34 = comb.or bin %30, %33 : i1
      cf.cond_br %34, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %35 = llhd.prb %rst_dst_ni_1 : i1
      %36 = comb.xor %35, %true : i1
      cf.cond_br %36, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %dst_qs_o, %c-7_i4 after %0 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %37 = llhd.prb %gen_wr_req.dst_lat_d : i1
      cf.cond_br %37, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %38 = llhd.prb %dst_ds_i_3 : i4
      llhd.drv %dst_qs_o, %38 after %0 : i4
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %39 = llhd.prb %gen_wr_req.dst_lat_q : i1
      cf.cond_br %39, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %40 = llhd.prb %dst_qs_i_4 : i4
      llhd.drv %dst_qs_o, %40 after %0 : i4
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 8 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb11, ^bb12
      %26 = llhd.prb %clk_dst_i_0 : i1
      %27 = llhd.prb %rst_dst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %28 = llhd.prb %clk_dst_i_0 : i1
      %29 = comb.xor bin %26, %true : i1
      %30 = comb.and bin %29, %28 : i1
      %31 = llhd.prb %rst_dst_ni_1 : i1
      %32 = comb.xor bin %31, %true : i1
      %33 = comb.and bin %27, %32 : i1
      %34 = comb.or bin %30, %33 : i1
      cf.cond_br %34, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %35 = llhd.prb %rst_dst_ni_1 : i1
      %36 = comb.xor %35, %true : i1
      cf.cond_br %36, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_wr_req.id_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %37 = llhd.prb %gen_wr_req.dst_update_ack : i1
      cf.cond_br %37, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %gen_wr_req.id_q, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %38 = llhd.prb %gen_wr_req.dst_req : i1
      %39 = llhd.prb %gen_wr_req.dst_lat_d : i1
      %40 = comb.and %38, %39 : i1
      cf.cond_br %40, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %gen_wr_req.id_q, %false after %0 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %41 = llhd.prb %gen_wr_req.dst_req : i1
      %42 = comb.xor %41, %true : i1
      %43 = llhd.prb %gen_wr_req.dst_lat_d : i1
      %44 = comb.and %42, %43 : i1
      cf.cond_br %44, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      llhd.drv %gen_wr_req.id_q, %true after %0 : i1
      cf.br ^bb1
    ^bb11:  // pred: ^bb9
      %45 = llhd.prb %gen_wr_req.dst_lat_q : i1
      cf.cond_br %45, ^bb12, ^bb1
    ^bb12:  // pred: ^bb11
      llhd.drv %gen_wr_req.id_q, %true after %0 : i1
      cf.br ^bb1
    }
    %11 = llhd.prb %gen_wr_req.idle_q : i1
    %12 = llhd.prb %gen_wr_req.dst_req : i1
    %13 = comb.and %11, %12 : i1
    %14 = llhd.prb %gen_wr_req.idle_d : i1
    %15 = llhd.prb %gen_wr_req.dst_hold_req : i1
    %16 = llhd.prb %gen_wr_req.dst_lat_q : i1
    %17 = llhd.prb %gen_wr_req.dst_lat_d : i1
    %18 = llhd.prb %dst_update : i1
    %19 = llhd.prb %dst_qs_i_4 : i4
    %20 = llhd.prb %gen_wr_req.dst_update_ack : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb10
      %26 = llhd.prb %gen_wr_req.idle_q : i1
      llhd.drv %gen_wr_req.idle_d, %26 after %1 : i1
      llhd.drv %gen_wr_req.dst_hold_req, %false after %1 : i1
      llhd.drv %gen_wr_req.dst_lat_q, %false after %1 : i1
      llhd.drv %gen_wr_req.dst_lat_d, %false after %1 : i1
      %27 = llhd.prb %gen_wr_req.idle_q : i1
      cf.cond_br %27, ^bb2, ^bb8
    ^bb2:  // pred: ^bb1
      %28 = llhd.prb %gen_wr_req.dst_req : i1
      cf.cond_br %28, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %gen_wr_req.idle_d, %false after %1 : i1
      llhd.drv %gen_wr_req.dst_lat_d, %true after %1 : i1
      cf.br ^bb10
    ^bb4:  // pred: ^bb2
      %29 = llhd.prb %dst_update : i1
      cf.cond_br %29, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      llhd.drv %gen_wr_req.idle_d, %false after %1 : i1
      llhd.drv %gen_wr_req.dst_lat_d, %true after %1 : i1
      cf.br ^bb10
    ^bb6:  // pred: ^bb4
      %30 = llhd.prb %dst_qs_o : i4
      %31 = llhd.prb %dst_qs_i_4 : i4
      %32 = comb.icmp ne %30, %31 : i4
      cf.cond_br %32, ^bb7, ^bb10
    ^bb7:  // pred: ^bb6
      llhd.drv %gen_wr_req.idle_d, %false after %1 : i1
      llhd.drv %gen_wr_req.dst_lat_q, %true after %1 : i1
      cf.br ^bb10
    ^bb8:  // pred: ^bb1
      llhd.drv %gen_wr_req.dst_hold_req, %true after %1 : i1
      %33 = llhd.prb %gen_wr_req.dst_update_ack : i1
      cf.cond_br %33, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      llhd.drv %gen_wr_req.idle_d, %true after %1 : i1
      cf.br ^bb10
    ^bb10:  // 6 preds: ^bb3, ^bb5, ^bb6, ^bb7, ^bb8, ^bb9
      llhd.wait (%11, %14, %15, %16, %17, %12, %18, %4, %19, %20 : i1, i1, i1, i1, i1, i1, i1, i4, i4, i1), ^bb1
    }
    %21 = comb.or %15, %17, %16 {sv.namehint = "gen_wr_req.dst_update_req"} : i1
    %22 = llhd.prb %gen_wr_req.id_q : i1
    %23 = comb.xor %22, %true : i1
    %24 = comb.and %gen_wr_req.u_dst_update_sync.dst_req_o, %23 : i1
    %25 = comb.and %gen_wr_req.u_dst_update_sync.dst_req_o, %22 : i1
    llhd.drv %clk_dst_i_0, %clk_dst_i after %1 : i1
    llhd.drv %rst_dst_ni_1, %rst_dst_ni after %1 : i1
    llhd.drv %dst_req_i_2, %dst_req_i after %1 : i1
    llhd.drv %dst_ds_i_3, %dst_ds_i after %1 : i4
    llhd.drv %dst_qs_i_4, %dst_qs_i after %1 : i4
    hw.output %24, %25, %13, %4 : i1, i1, i1, i4
  }
  hw.module private @prim_reg_cdc_arb_41(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, out src_ack_o : i1, out src_update_o : i1, in %dst_req_i : i1, out dst_req_o : i1, in %dst_update_i : i1, in %dst_ds_i : i20, in %dst_qs_i : i20, out dst_qs_o : i20) {
    %false = hw.constant false
    %gen_passthru.u_dst_to_src_ack.dst_pulse_o = hw.instance "gen_passthru.u_dst_to_src_ack" @prim_pulse_sync(clk_src_i: %clk_dst_i: i1, rst_src_ni: %rst_dst_ni: i1, src_pulse_i: %dst_req_i: i1, clk_dst_i: %clk_src_i: i1, rst_dst_ni: %rst_src_ni: i1) -> (dst_pulse_o: i1)
    hw.output %gen_passthru.u_dst_to_src_ack.dst_pulse_o, %false, %dst_req_i, %dst_qs_i : i1, i1, i1, i20
  }
  hw.module private @prim_reg_cdc_arb_42(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, out src_ack_o : i1, out src_update_o : i1, in %dst_req_i : i1, out dst_req_o : i1, in %dst_update_i : i1, in %dst_ds_i : i18, in %dst_qs_i : i18, out dst_qs_o : i18) {
    %false = hw.constant false
    %gen_passthru.u_dst_to_src_ack.dst_pulse_o = hw.instance "gen_passthru.u_dst_to_src_ack" @prim_pulse_sync(clk_src_i: %clk_dst_i: i1, rst_src_ni: %rst_dst_ni: i1, src_pulse_i: %dst_req_i: i1, clk_dst_i: %clk_src_i: i1, rst_dst_ni: %rst_src_ni: i1) -> (dst_pulse_o: i1)
    hw.output %gen_passthru.u_dst_to_src_ack.dst_pulse_o, %false, %dst_req_i, %dst_qs_i : i1, i1, i1, i18
  }
  hw.module private @prim_reg_cdc_arb_43(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, out src_ack_o : i1, out src_update_o : i1, in %dst_req_i : i1, out dst_req_o : i1, in %dst_update_i : i1, in %dst_ds_i : i16, in %dst_qs_i : i16, out dst_qs_o : i16) {
    %false = hw.constant false
    %gen_passthru.u_dst_to_src_ack.dst_pulse_o = hw.instance "gen_passthru.u_dst_to_src_ack" @prim_pulse_sync(clk_src_i: %clk_dst_i: i1, rst_src_ni: %rst_dst_ni: i1, src_pulse_i: %dst_req_i: i1, clk_dst_i: %clk_src_i: i1, rst_dst_ni: %rst_src_ni: i1) -> (dst_pulse_o: i1)
    hw.output %gen_passthru.u_dst_to_src_ack.dst_pulse_o, %false, %dst_req_i, %dst_qs_i : i1, i1, i1, i16
  }
  hw.module private @prim_reg_cdc_arb_44(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, out src_ack_o : i1, out src_update_o : i1, in %dst_req_i : i1, out dst_req_o : i1, in %dst_update_i : i1, in %dst_ds_i : i20, in %dst_qs_i : i20, out dst_qs_o : i20) {
    %false = hw.constant false
    %gen_passthru.u_dst_to_src_ack.dst_pulse_o = hw.instance "gen_passthru.u_dst_to_src_ack" @prim_pulse_sync(clk_src_i: %clk_dst_i: i1, rst_src_ni: %rst_dst_ni: i1, src_pulse_i: %dst_req_i: i1, clk_dst_i: %clk_src_i: i1, rst_dst_ni: %rst_src_ni: i1) -> (dst_pulse_o: i1)
    hw.output %gen_passthru.u_dst_to_src_ack.dst_pulse_o, %false, %dst_req_i, %dst_qs_i : i1, i1, i1, i20
  }
  hw.module private @prim_reg_cdc(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, in %src_regwen_i : i1, in %src_we_i : i1, in %src_re_i : i1, in %src_wd_i : i4, out src_busy_o : i1, out src_qs_o : i4, in %dst_ds_i : i4, in %dst_qs_i : i4, in %dst_update_i : i1, out dst_we_o : i1, out dst_re_o : i1, out dst_regwen_o : i1, out dst_wd_o : i4) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %c0_i3 = hw.constant 0 : i3
    %c-7_i4 = hw.constant -7 : i4
    %true = hw.constant true
    %false = hw.constant false
    %clk_src_i_0 = llhd.sig name "clk_src_i" %false : i1
    %2 = llhd.prb %clk_src_i_0 : i1
    %rst_src_ni_1 = llhd.sig name "rst_src_ni" %false : i1
    %3 = llhd.prb %rst_src_ni_1 : i1
    %src_regwen_i_2 = llhd.sig name "src_regwen_i" %false : i1
    %src_we_i_3 = llhd.sig name "src_we_i" %false : i1
    %src_re_i_4 = llhd.sig name "src_re_i" %false : i1
    %src_wd_i_5 = llhd.sig name "src_wd_i" %c0_i4 : i4
    %src_ack = llhd.sig %false : i1
    %src_busy_q = llhd.sig %false : i1
    %src_q = llhd.sig %c0_i4 : i4
    %txn_bits_q = llhd.sig %c0_i3 : i3
    %src_req = llhd.sig %false : i1
    %dst_qs = llhd.sig %c0_i4 : i4
    %dst_to_src = llhd.sig %false : i1
    %4 = llhd.prb %src_req : i1
    %u_src_to_dst_req.dst_pulse_o = hw.instance "u_src_to_dst_req" @prim_pulse_sync(clk_src_i: %2: i1, rst_src_ni: %3: i1, src_pulse_i: %4: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1) -> (dst_pulse_o: i1) {sv.namehint = "dst_req_from_src"}
    %u_arb.src_ack_o, %u_arb.src_update_o, %u_arb.dst_req_o, %u_arb.dst_qs_o = hw.instance "u_arb" @prim_reg_cdc_arb(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1, dst_req_i: %u_src_to_dst_req.dst_pulse_o: i1, dst_update_i: %dst_update_i: i1, dst_ds_i: %dst_ds_i: i4, dst_qs_i: %dst_qs_i: i4) -> (src_ack_o: i1, src_update_o: i1, dst_req_o: i1, dst_qs_o: i4) {sv.namehint = "dst_req"}
    llhd.drv %src_ack, %u_arb.src_ack_o after %1 : i1
    llhd.drv %dst_qs, %u_arb.dst_qs_o after %1 : i4
    %5 = llhd.prb %src_we_i_3 : i1
    %6 = llhd.prb %src_re_i_4 : i1
    %7 = comb.or %5, %6 : i1
    llhd.drv %src_req, %7 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %23 = llhd.prb %clk_src_i_0 : i1
      %24 = llhd.prb %rst_src_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %25 = llhd.prb %clk_src_i_0 : i1
      %26 = comb.xor bin %23, %true : i1
      %27 = comb.and bin %26, %25 : i1
      %28 = llhd.prb %rst_src_ni_1 : i1
      %29 = comb.xor bin %28, %true : i1
      %30 = comb.and bin %24, %29 : i1
      %31 = comb.or bin %27, %30 : i1
      cf.cond_br %31, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %32 = llhd.prb %rst_src_ni_1 : i1
      %33 = comb.xor %32, %true : i1
      cf.cond_br %33, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %src_busy_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %34 = llhd.prb %src_req : i1
      cf.cond_br %34, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %src_busy_q, %true after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %35 = llhd.prb %src_ack : i1
      cf.cond_br %35, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %src_busy_q, %false after %0 : i1
      cf.br ^bb1
    }
    %8 = llhd.prb %src_busy_q : i1
    %9 = llhd.prb %src_ack : i1
    %10 = comb.xor %9, %true : i1
    %11 = comb.and %8, %10 {sv.namehint = "busy"} : i1
    %12 = comb.and %8, %9 : i1
    %13 = comb.xor %11, %true : i1
    %14 = comb.and %u_arb.src_update_o, %13 : i1
    %15 = comb.or %12, %14 : i1
    llhd.drv %dst_to_src, %15 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %23 = llhd.prb %clk_src_i_0 : i1
      %24 = llhd.prb %rst_src_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %25 = llhd.prb %clk_src_i_0 : i1
      %26 = comb.xor bin %23, %true : i1
      %27 = comb.and bin %26, %25 : i1
      %28 = llhd.prb %rst_src_ni_1 : i1
      %29 = comb.xor bin %28, %true : i1
      %30 = comb.and bin %24, %29 : i1
      %31 = comb.or bin %27, %30 : i1
      cf.cond_br %31, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %32 = llhd.prb %rst_src_ni_1 : i1
      %33 = comb.xor %32, %true : i1
      cf.cond_br %33, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %src_q, %c-7_i4 after %0 : i4
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %34 = llhd.prb %src_req : i1
      cf.cond_br %34, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %35 = llhd.prb %src_wd_i_5 : i4
      llhd.drv %src_q, %35 after %0 : i4
      %36 = llhd.prb %src_we_i_3 : i1
      %37 = llhd.prb %src_re_i_4 : i1
      %38 = llhd.prb %src_regwen_i_2 : i1
      %39 = comb.concat %36, %37, %38 : i1, i1, i1
      llhd.drv %txn_bits_q, %39 after %0 : i3
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %40 = llhd.prb %dst_to_src : i1
      cf.cond_br %40, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %41 = llhd.prb %dst_qs : i4
      llhd.drv %src_q, %41 after %0 : i4
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    }
    %16 = llhd.prb %src_q : i4
    %17 = llhd.prb %txn_bits_q : i3
    %18 = comb.replicate %u_arb.dst_req_o : (i1) -> i3
    %19 = comb.and %17, %18 : i3
    %20 = comb.extract %19 from 2 : (i3) -> i1
    %21 = comb.extract %19 from 1 : (i3) -> i1
    %22 = comb.extract %19 from 0 : (i3) -> i1
    llhd.drv %clk_src_i_0, %clk_src_i after %1 : i1
    llhd.drv %rst_src_ni_1, %rst_src_ni after %1 : i1
    llhd.drv %src_regwen_i_2, %src_regwen_i after %1 : i1
    llhd.drv %src_we_i_3, %src_we_i after %1 : i1
    llhd.drv %src_re_i_4, %src_re_i after %1 : i1
    llhd.drv %src_wd_i_5, %src_wd_i after %1 : i4
    hw.output %8, %16, %20, %21, %22, %16 : i1, i4, i1, i1, i1, i4
  }
  hw.module private @prim_reg_cdc_11(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, in %src_regwen_i : i1, in %src_we_i : i1, in %src_re_i : i1, in %src_wd_i : i20, out src_busy_o : i1, out src_qs_o : i20, in %dst_ds_i : i20, in %dst_qs_i : i20, in %dst_update_i : i1, out dst_we_o : i1, out dst_re_o : i1, out dst_regwen_o : i1, out dst_wd_o : i20) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i20 = hw.constant 0 : i20
    %c0_i3 = hw.constant 0 : i3
    %c481770_i20 = hw.constant 481770 : i20
    %true = hw.constant true
    %false = hw.constant false
    %clk_src_i_0 = llhd.sig name "clk_src_i" %false : i1
    %2 = llhd.prb %clk_src_i_0 : i1
    %rst_src_ni_1 = llhd.sig name "rst_src_ni" %false : i1
    %3 = llhd.prb %rst_src_ni_1 : i1
    %src_regwen_i_2 = llhd.sig name "src_regwen_i" %false : i1
    %src_we_i_3 = llhd.sig name "src_we_i" %false : i1
    %src_re_i_4 = llhd.sig name "src_re_i" %false : i1
    %src_wd_i_5 = llhd.sig name "src_wd_i" %c0_i20 : i20
    %src_ack = llhd.sig %false : i1
    %src_busy_q = llhd.sig %false : i1
    %src_q = llhd.sig %c0_i20 : i20
    %txn_bits_q = llhd.sig %c0_i3 : i3
    %src_req = llhd.sig %false : i1
    %dst_qs = llhd.sig %c0_i20 : i20
    %dst_to_src = llhd.sig %false : i1
    %4 = llhd.prb %src_req : i1
    %u_src_to_dst_req.dst_pulse_o = hw.instance "u_src_to_dst_req" @prim_pulse_sync(clk_src_i: %2: i1, rst_src_ni: %3: i1, src_pulse_i: %4: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1) -> (dst_pulse_o: i1) {sv.namehint = "dst_req_from_src"}
    %u_arb.src_ack_o, %u_arb.src_update_o, %u_arb.dst_req_o, %u_arb.dst_qs_o = hw.instance "u_arb" @prim_reg_cdc_arb_41(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1, dst_req_i: %u_src_to_dst_req.dst_pulse_o: i1, dst_update_i: %dst_update_i: i1, dst_ds_i: %dst_ds_i: i20, dst_qs_i: %dst_qs_i: i20) -> (src_ack_o: i1, src_update_o: i1, dst_req_o: i1, dst_qs_o: i20) {sv.namehint = "dst_req"}
    llhd.drv %src_ack, %u_arb.src_ack_o after %1 : i1
    llhd.drv %dst_qs, %u_arb.dst_qs_o after %1 : i20
    %5 = llhd.prb %src_we_i_3 : i1
    %6 = llhd.prb %src_re_i_4 : i1
    %7 = comb.or %5, %6 : i1
    llhd.drv %src_req, %7 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
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
      llhd.drv %src_busy_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %29 = llhd.prb %src_req : i1
      cf.cond_br %29, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %src_busy_q, %true after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %30 = llhd.prb %src_ack : i1
      cf.cond_br %30, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %src_busy_q, %false after %0 : i1
      cf.br ^bb1
    }
    %8 = llhd.prb %src_busy_q : i1
    %9 = llhd.prb %src_ack : i1
    %10 = comb.and %8, %9 : i1
    llhd.drv %dst_to_src, %10 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
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
      llhd.drv %src_q, %c481770_i20 after %0 : i20
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %29 = llhd.prb %src_req : i1
      cf.cond_br %29, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %30 = llhd.prb %src_wd_i_5 : i20
      llhd.drv %src_q, %30 after %0 : i20
      %31 = llhd.prb %src_we_i_3 : i1
      %32 = llhd.prb %src_re_i_4 : i1
      %33 = llhd.prb %src_regwen_i_2 : i1
      %34 = comb.concat %31, %32, %33 : i1, i1, i1
      llhd.drv %txn_bits_q, %34 after %0 : i3
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %35 = llhd.prb %dst_to_src : i1
      cf.cond_br %35, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %36 = llhd.prb %dst_qs : i20
      llhd.drv %src_q, %36 after %0 : i20
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    }
    %11 = llhd.prb %src_q : i20
    %12 = llhd.prb %txn_bits_q : i3
    %13 = comb.replicate %u_arb.dst_req_o : (i1) -> i3
    %14 = comb.and %12, %13 : i3
    %15 = comb.extract %14 from 2 : (i3) -> i1
    %16 = comb.extract %14 from 1 : (i3) -> i1
    %17 = comb.extract %14 from 0 : (i3) -> i1
    llhd.drv %clk_src_i_0, %clk_src_i after %1 : i1
    llhd.drv %rst_src_ni_1, %rst_src_ni after %1 : i1
    llhd.drv %src_regwen_i_2, %src_regwen_i after %1 : i1
    llhd.drv %src_we_i_3, %src_we_i after %1 : i1
    llhd.drv %src_re_i_4, %src_re_i after %1 : i1
    llhd.drv %src_wd_i_5, %src_wd_i after %1 : i20
    hw.output %8, %11, %15, %16, %17, %11 : i1, i20, i1, i1, i1, i20
  }
  hw.module private @prim_reg_cdc_12(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, in %src_regwen_i : i1, in %src_we_i : i1, in %src_re_i : i1, in %src_wd_i : i18, out src_busy_o : i1, out src_qs_o : i18, in %dst_ds_i : i18, in %dst_qs_i : i18, in %dst_update_i : i1, out dst_we_o : i1, out dst_re_o : i1, out dst_regwen_o : i1, out dst_wd_o : i18) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i18 = hw.constant 0 : i18
    %c0_i3 = hw.constant 0 : i3
    %c118010_i18 = hw.constant 118010 : i18
    %true = hw.constant true
    %false = hw.constant false
    %clk_src_i_0 = llhd.sig name "clk_src_i" %false : i1
    %2 = llhd.prb %clk_src_i_0 : i1
    %rst_src_ni_1 = llhd.sig name "rst_src_ni" %false : i1
    %3 = llhd.prb %rst_src_ni_1 : i1
    %src_regwen_i_2 = llhd.sig name "src_regwen_i" %false : i1
    %src_we_i_3 = llhd.sig name "src_we_i" %false : i1
    %src_re_i_4 = llhd.sig name "src_re_i" %false : i1
    %src_wd_i_5 = llhd.sig name "src_wd_i" %c0_i18 : i18
    %src_ack = llhd.sig %false : i1
    %src_busy_q = llhd.sig %false : i1
    %src_q = llhd.sig %c0_i18 : i18
    %txn_bits_q = llhd.sig %c0_i3 : i3
    %src_req = llhd.sig %false : i1
    %dst_qs = llhd.sig %c0_i18 : i18
    %dst_to_src = llhd.sig %false : i1
    %4 = llhd.prb %src_req : i1
    %u_src_to_dst_req.dst_pulse_o = hw.instance "u_src_to_dst_req" @prim_pulse_sync(clk_src_i: %2: i1, rst_src_ni: %3: i1, src_pulse_i: %4: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1) -> (dst_pulse_o: i1) {sv.namehint = "dst_req_from_src"}
    %u_arb.src_ack_o, %u_arb.src_update_o, %u_arb.dst_req_o, %u_arb.dst_qs_o = hw.instance "u_arb" @prim_reg_cdc_arb_42(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1, dst_req_i: %u_src_to_dst_req.dst_pulse_o: i1, dst_update_i: %dst_update_i: i1, dst_ds_i: %dst_ds_i: i18, dst_qs_i: %dst_qs_i: i18) -> (src_ack_o: i1, src_update_o: i1, dst_req_o: i1, dst_qs_o: i18) {sv.namehint = "dst_req"}
    llhd.drv %src_ack, %u_arb.src_ack_o after %1 : i1
    llhd.drv %dst_qs, %u_arb.dst_qs_o after %1 : i18
    %5 = llhd.prb %src_we_i_3 : i1
    %6 = llhd.prb %src_re_i_4 : i1
    %7 = comb.or %5, %6 : i1
    llhd.drv %src_req, %7 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
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
      llhd.drv %src_busy_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %29 = llhd.prb %src_req : i1
      cf.cond_br %29, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %src_busy_q, %true after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %30 = llhd.prb %src_ack : i1
      cf.cond_br %30, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %src_busy_q, %false after %0 : i1
      cf.br ^bb1
    }
    %8 = llhd.prb %src_busy_q : i1
    %9 = llhd.prb %src_ack : i1
    %10 = comb.and %8, %9 : i1
    llhd.drv %dst_to_src, %10 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
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
      llhd.drv %src_q, %c118010_i18 after %0 : i18
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %29 = llhd.prb %src_req : i1
      cf.cond_br %29, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %30 = llhd.prb %src_wd_i_5 : i18
      llhd.drv %src_q, %30 after %0 : i18
      %31 = llhd.prb %src_we_i_3 : i1
      %32 = llhd.prb %src_re_i_4 : i1
      %33 = llhd.prb %src_regwen_i_2 : i1
      %34 = comb.concat %31, %32, %33 : i1, i1, i1
      llhd.drv %txn_bits_q, %34 after %0 : i3
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %35 = llhd.prb %dst_to_src : i1
      cf.cond_br %35, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %36 = llhd.prb %dst_qs : i18
      llhd.drv %src_q, %36 after %0 : i18
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    }
    %11 = llhd.prb %src_q : i18
    %12 = llhd.prb %txn_bits_q : i3
    %13 = comb.replicate %u_arb.dst_req_o : (i1) -> i3
    %14 = comb.and %12, %13 : i3
    %15 = comb.extract %14 from 2 : (i3) -> i1
    %16 = comb.extract %14 from 1 : (i3) -> i1
    %17 = comb.extract %14 from 0 : (i3) -> i1
    llhd.drv %clk_src_i_0, %clk_src_i after %1 : i1
    llhd.drv %rst_src_ni_1, %rst_src_ni after %1 : i1
    llhd.drv %src_regwen_i_2, %src_regwen_i after %1 : i1
    llhd.drv %src_we_i_3, %src_we_i after %1 : i1
    llhd.drv %src_re_i_4, %src_re_i after %1 : i1
    llhd.drv %src_wd_i_5, %src_wd_i after %1 : i18
    hw.output %8, %11, %15, %16, %17, %11 : i1, i18, i1, i1, i1, i18
  }
  hw.module private @prim_reg_cdc_13(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, in %src_regwen_i : i1, in %src_we_i : i1, in %src_re_i : i1, in %src_wd_i : i16, out src_busy_o : i1, out src_qs_o : i16, in %dst_ds_i : i16, in %dst_qs_i : i16, in %dst_update_i : i1, out dst_we_o : i1, out dst_re_o : i1, out dst_regwen_o : i1, out dst_wd_o : i16) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i16 = hw.constant 0 : i16
    %c0_i3 = hw.constant 0 : i3
    %c28290_i16 = hw.constant 28290 : i16
    %true = hw.constant true
    %false = hw.constant false
    %clk_src_i_0 = llhd.sig name "clk_src_i" %false : i1
    %2 = llhd.prb %clk_src_i_0 : i1
    %rst_src_ni_1 = llhd.sig name "rst_src_ni" %false : i1
    %3 = llhd.prb %rst_src_ni_1 : i1
    %src_regwen_i_2 = llhd.sig name "src_regwen_i" %false : i1
    %src_we_i_3 = llhd.sig name "src_we_i" %false : i1
    %src_re_i_4 = llhd.sig name "src_re_i" %false : i1
    %src_wd_i_5 = llhd.sig name "src_wd_i" %c0_i16 : i16
    %src_ack = llhd.sig %false : i1
    %src_busy_q = llhd.sig %false : i1
    %src_q = llhd.sig %c0_i16 : i16
    %txn_bits_q = llhd.sig %c0_i3 : i3
    %src_req = llhd.sig %false : i1
    %dst_qs = llhd.sig %c0_i16 : i16
    %dst_to_src = llhd.sig %false : i1
    %4 = llhd.prb %src_req : i1
    %u_src_to_dst_req.dst_pulse_o = hw.instance "u_src_to_dst_req" @prim_pulse_sync(clk_src_i: %2: i1, rst_src_ni: %3: i1, src_pulse_i: %4: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1) -> (dst_pulse_o: i1) {sv.namehint = "dst_req_from_src"}
    %u_arb.src_ack_o, %u_arb.src_update_o, %u_arb.dst_req_o, %u_arb.dst_qs_o = hw.instance "u_arb" @prim_reg_cdc_arb_43(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1, dst_req_i: %u_src_to_dst_req.dst_pulse_o: i1, dst_update_i: %dst_update_i: i1, dst_ds_i: %dst_ds_i: i16, dst_qs_i: %dst_qs_i: i16) -> (src_ack_o: i1, src_update_o: i1, dst_req_o: i1, dst_qs_o: i16) {sv.namehint = "dst_req"}
    llhd.drv %src_ack, %u_arb.src_ack_o after %1 : i1
    llhd.drv %dst_qs, %u_arb.dst_qs_o after %1 : i16
    %5 = llhd.prb %src_we_i_3 : i1
    %6 = llhd.prb %src_re_i_4 : i1
    %7 = comb.or %5, %6 : i1
    llhd.drv %src_req, %7 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
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
      llhd.drv %src_busy_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %29 = llhd.prb %src_req : i1
      cf.cond_br %29, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %src_busy_q, %true after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %30 = llhd.prb %src_ack : i1
      cf.cond_br %30, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %src_busy_q, %false after %0 : i1
      cf.br ^bb1
    }
    %8 = llhd.prb %src_busy_q : i1
    %9 = llhd.prb %src_ack : i1
    %10 = comb.and %8, %9 : i1
    llhd.drv %dst_to_src, %10 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
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
      llhd.drv %src_q, %c28290_i16 after %0 : i16
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %29 = llhd.prb %src_req : i1
      cf.cond_br %29, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %30 = llhd.prb %src_wd_i_5 : i16
      llhd.drv %src_q, %30 after %0 : i16
      %31 = llhd.prb %src_we_i_3 : i1
      %32 = llhd.prb %src_re_i_4 : i1
      %33 = llhd.prb %src_regwen_i_2 : i1
      %34 = comb.concat %31, %32, %33 : i1, i1, i1
      llhd.drv %txn_bits_q, %34 after %0 : i3
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %35 = llhd.prb %dst_to_src : i1
      cf.cond_br %35, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %36 = llhd.prb %dst_qs : i16
      llhd.drv %src_q, %36 after %0 : i16
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    }
    %11 = llhd.prb %src_q : i16
    %12 = llhd.prb %txn_bits_q : i3
    %13 = comb.replicate %u_arb.dst_req_o : (i1) -> i3
    %14 = comb.and %12, %13 : i3
    %15 = comb.extract %14 from 2 : (i3) -> i1
    %16 = comb.extract %14 from 1 : (i3) -> i1
    %17 = comb.extract %14 from 0 : (i3) -> i1
    llhd.drv %clk_src_i_0, %clk_src_i after %1 : i1
    llhd.drv %rst_src_ni_1, %rst_src_ni after %1 : i1
    llhd.drv %src_regwen_i_2, %src_regwen_i after %1 : i1
    llhd.drv %src_we_i_3, %src_we_i after %1 : i1
    llhd.drv %src_re_i_4, %src_re_i after %1 : i1
    llhd.drv %src_wd_i_5, %src_wd_i after %1 : i16
    hw.output %8, %11, %15, %16, %17, %11 : i1, i16, i1, i1, i1, i16
  }
  hw.module private @prim_reg_cdc_14(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, in %src_regwen_i : i1, in %src_we_i : i1, in %src_re_i : i1, in %src_wd_i : i20, out src_busy_o : i1, out src_qs_o : i20, in %dst_ds_i : i20, in %dst_qs_i : i20, in %dst_update_i : i1, out dst_we_o : i1, out dst_re_o : i1, out dst_regwen_o : i1, out dst_wd_o : i20) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i20 = hw.constant 0 : i20
    %c0_i3 = hw.constant 0 : i3
    %c502270_i20 = hw.constant 502270 : i20
    %true = hw.constant true
    %false = hw.constant false
    %clk_src_i_0 = llhd.sig name "clk_src_i" %false : i1
    %2 = llhd.prb %clk_src_i_0 : i1
    %rst_src_ni_1 = llhd.sig name "rst_src_ni" %false : i1
    %3 = llhd.prb %rst_src_ni_1 : i1
    %src_regwen_i_2 = llhd.sig name "src_regwen_i" %false : i1
    %src_we_i_3 = llhd.sig name "src_we_i" %false : i1
    %src_re_i_4 = llhd.sig name "src_re_i" %false : i1
    %src_wd_i_5 = llhd.sig name "src_wd_i" %c0_i20 : i20
    %src_ack = llhd.sig %false : i1
    %src_busy_q = llhd.sig %false : i1
    %src_q = llhd.sig %c0_i20 : i20
    %txn_bits_q = llhd.sig %c0_i3 : i3
    %src_req = llhd.sig %false : i1
    %dst_qs = llhd.sig %c0_i20 : i20
    %dst_to_src = llhd.sig %false : i1
    %4 = llhd.prb %src_req : i1
    %u_src_to_dst_req.dst_pulse_o = hw.instance "u_src_to_dst_req" @prim_pulse_sync(clk_src_i: %2: i1, rst_src_ni: %3: i1, src_pulse_i: %4: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1) -> (dst_pulse_o: i1) {sv.namehint = "dst_req_from_src"}
    %u_arb.src_ack_o, %u_arb.src_update_o, %u_arb.dst_req_o, %u_arb.dst_qs_o = hw.instance "u_arb" @prim_reg_cdc_arb_44(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1, dst_req_i: %u_src_to_dst_req.dst_pulse_o: i1, dst_update_i: %dst_update_i: i1, dst_ds_i: %dst_ds_i: i20, dst_qs_i: %dst_qs_i: i20) -> (src_ack_o: i1, src_update_o: i1, dst_req_o: i1, dst_qs_o: i20) {sv.namehint = "dst_req"}
    llhd.drv %src_ack, %u_arb.src_ack_o after %1 : i1
    llhd.drv %dst_qs, %u_arb.dst_qs_o after %1 : i20
    %5 = llhd.prb %src_we_i_3 : i1
    %6 = llhd.prb %src_re_i_4 : i1
    %7 = comb.or %5, %6 : i1
    llhd.drv %src_req, %7 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
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
      llhd.drv %src_busy_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %29 = llhd.prb %src_req : i1
      cf.cond_br %29, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %src_busy_q, %true after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %30 = llhd.prb %src_ack : i1
      cf.cond_br %30, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %src_busy_q, %false after %0 : i1
      cf.br ^bb1
    }
    %8 = llhd.prb %src_busy_q : i1
    %9 = llhd.prb %src_ack : i1
    %10 = comb.and %8, %9 : i1
    llhd.drv %dst_to_src, %10 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
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
      llhd.drv %src_q, %c502270_i20 after %0 : i20
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %29 = llhd.prb %src_req : i1
      cf.cond_br %29, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %30 = llhd.prb %src_wd_i_5 : i20
      llhd.drv %src_q, %30 after %0 : i20
      %31 = llhd.prb %src_we_i_3 : i1
      %32 = llhd.prb %src_re_i_4 : i1
      %33 = llhd.prb %src_regwen_i_2 : i1
      %34 = comb.concat %31, %32, %33 : i1, i1, i1
      llhd.drv %txn_bits_q, %34 after %0 : i3
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %35 = llhd.prb %dst_to_src : i1
      cf.cond_br %35, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %36 = llhd.prb %dst_qs : i20
      llhd.drv %src_q, %36 after %0 : i20
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    }
    %11 = llhd.prb %src_q : i20
    %12 = llhd.prb %txn_bits_q : i3
    %13 = comb.replicate %u_arb.dst_req_o : (i1) -> i3
    %14 = comb.and %12, %13 : i3
    %15 = comb.extract %14 from 2 : (i3) -> i1
    %16 = comb.extract %14 from 1 : (i3) -> i1
    %17 = comb.extract %14 from 0 : (i3) -> i1
    llhd.drv %clk_src_i_0, %clk_src_i after %1 : i1
    llhd.drv %rst_src_ni_1, %rst_src_ni after %1 : i1
    llhd.drv %src_regwen_i_2, %src_regwen_i after %1 : i1
    llhd.drv %src_we_i_3, %src_we_i after %1 : i1
    llhd.drv %src_re_i_4, %src_re_i after %1 : i1
    llhd.drv %src_wd_i_5, %src_wd_i after %1 : i20
    hw.output %8, %11, %15, %16, %17, %11 : i1, i20, i1, i1, i1, i20
  }
  hw.module private @prim_reg_we_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i22, in %en_i : i1, out err_o : i1) {
    %c0_i5 = hw.constant 0 : i5
    %u_prim_buf.out_o = hw.instance "u_prim_buf" @prim_buf_39(in_i: %oh_i: i22) -> (out_o: i22) {sv.namehint = "oh_buf"}
    %u_prim_onehot_check.err_o = hw.instance "u_prim_onehot_check" @prim_onehot_check(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, oh_i: %u_prim_buf.out_o: i22, addr_i: %c0_i5: i5, en_i: %en_i: i1) -> (err_o: i1)
    hw.output %u_prim_onehot_check.err_o : i1
  }
  hw.module private @prim_sec_anchor_buf(in %in_i : i4, out out_o : i4) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf_38(in_i: %in_i: i4) -> (out_o: i4)
    hw.output %u_secure_anchor_buf.out_o : i4
  }
  hw.module private @prim_sec_anchor_buf_27(in %in_i : i2, out out_o : i2) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf_59(in_i: %in_i: i2) -> (out_o: i2)
    hw.output %u_secure_anchor_buf.out_o : i2
  }
  hw.module private @prim_sec_anchor_buf_28(in %in_i : i1, out out_o : i1) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf(in_i: %in_i: i1) -> (out_o: i1)
    hw.output %u_secure_anchor_buf.out_o : i1
  }
  hw.module private @prim_sec_anchor_flop(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_o : i2) {
    %u_secure_anchor_flop.q_o = hw.instance "u_secure_anchor_flop" @prim_flop_61(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %d_i: i2) -> (q_o: i2)
    hw.output %u_secure_anchor_flop.q_o : i2
  }
  hw.module private @prim_sec_anchor_flop_63(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
    %u_secure_anchor_flop.q_o = hw.instance "u_secure_anchor_flop" @prim_flop_68(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %d_i: i4) -> (q_o: i4)
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
  hw.module private @prim_subreg_arb_45(in %we : i1, in %wd : i4, in %de : i1, in %d : i4, in %q : i4, out wr_en : i1, out wr_data : i4) {
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
  hw.module private @prim_subreg_arb_46(in %we : i1, in %wd : i1, in %de : i1, in %d : i1, in %q : i1, out wr_en : i1, out wr_data : i1) {
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
  hw.module private @prim_subreg_arb_47(in %we : i1, in %wd : i1, in %de : i1, in %d : i1, in %q : i1, out wr_en : i1, out wr_data : i1) {
    hw.output %de, %d : i1, i1
  }
  hw.module private @prim_subreg_arb_48(in %we : i1, in %wd : i10, in %de : i1, in %d : i10, in %q : i10, out wr_en : i1, out wr_data : i10) {
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
  hw.module private @prim_subreg_arb_51(in %we : i1, in %wd : i9, in %de : i1, in %d : i9, in %q : i9, out wr_en : i1, out wr_data : i9) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i9 = hw.constant 0 : i9
    %wd_0 = llhd.sig name "wd" %c0_i9 : i9
    %d_1 = llhd.sig name "d" %c0_i9 : i9
    %1 = comb.or %we, %de : i1
    %2 = llhd.prb %wd_0 : i9
    %3 = llhd.prb %d_1 : i9
    %4 = comb.mux %we, %2, %3 : i9
    llhd.drv %wd_0, %wd after %0 : i9
    llhd.drv %d_1, %d after %0 : i9
    hw.output %1, %4 : i1, i9
  }
  hw.module private @prim_subreg_arb_54(in %we : i1, in %wd : i8, in %de : i1, in %d : i8, in %q : i8, out wr_en : i1, out wr_data : i8) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i8 = hw.constant 0 : i8
    %wd_0 = llhd.sig name "wd" %c0_i8 : i8
    %d_1 = llhd.sig name "d" %c0_i8 : i8
    %1 = comb.or %we, %de : i1
    %2 = llhd.prb %wd_0 : i8
    %3 = llhd.prb %d_1 : i8
    %4 = comb.mux %we, %2, %3 : i8
    llhd.drv %wd_0, %wd after %0 : i8
    llhd.drv %d_1, %d after %0 : i8
    hw.output %1, %4 : i1, i8
  }
  hw.module private @prim_subreg_arb_58(in %we : i1, in %wd : i1, in %de : i1, in %d : i1, in %q : i1, out wr_en : i1, out wr_data : i1) {
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
  hw.module private @prim_subreg_ext(in %re : i1, in %we : i1, in %wd : i1, in %d : i1, out qe : i1, out qre : i1, out q : i1, out ds : i1, out qs : i1) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i1, i1, i1
  }
  hw.module private @prim_subreg_ext_16(in %re : i1, in %we : i1, in %wd : i4, in %d : i4, out qe : i1, out qre : i1, out q : i4, out ds : i4, out qs : i4) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i4, i4, i4
  }
  hw.module private @prim_subreg_shadow(in %clk_i : i1, in %rst_ni : i1, in %rst_shadowed_ni : i1, in %re : i1, in %we : i1, in %wd : i10, in %de : i1, in %d : i10, out qe : i1, out q : i10, out ds : i10, out qs : i10, out phase : i1, out err_update : i1, out err_storage : i1) {
    %c-491_i10 = hw.constant -491 : i10
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i10 = hw.constant -1 : i10
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i10 = hw.constant 0 : i10
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %rst_shadowed_ni_2 = llhd.sig name "rst_shadowed_ni" %false : i1
    %4 = llhd.prb %rst_shadowed_ni_2 : i1
    %re_3 = llhd.sig name "re" %false : i1
    %err_update = llhd.sig %false : i1
    %err_storage = llhd.sig %false : i1
    %phase_clear = llhd.sig %false : i1
    %phase_q = llhd.sig %false : i1
    %shadow_we = llhd.sig %false : i1
    %shadow_wd = llhd.sig %c0_i10 : i10
    %shadow_q = llhd.sig %c0_i10 : i10
    %committed_q = llhd.sig %c0_i10 : i10
    %wr_en = llhd.sig %false : i1
    %gen_shadow_reg_std.shadow_wr_en = llhd.sig %false : i1
    %gen_shadow_reg_std.shadow_wr_data = llhd.sig %c0_i10 : i10
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_48(we: %we: i1, wd: %wd: i10, de: %de: i1, d: %d: i10, q: %15: i10) -> (wr_en: i1, wr_data: i10) {sv.namehint = "wr_data"}
    llhd.drv %wr_en, %wr_en_data_arb.wr_en after %1 : i1
    %5 = comb.xor %wr_en_data_arb.wr_data, %c-1_i10 : i10
    %6 = comb.xor %d, %c-1_i10 : i10
    %7 = llhd.prb %shadow_q : i10
    %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_en, %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_data = hw.instance "gen_shadow_reg_std.wr_en_data_arb_shadow" @prim_subreg_arb_48(we: %we: i1, wd: %5: i10, de: %de: i1, d: %6: i10, q: %7: i10) -> (wr_en: i1, wr_data: i10)
    llhd.drv %gen_shadow_reg_std.shadow_wr_en, %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_en after %1 : i1
    llhd.drv %gen_shadow_reg_std.shadow_wr_data, %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_data after %1 : i10
    %committed_reg.qe, %committed_reg.q, %committed_reg.ds, %committed_reg.qs = hw.instance "committed_reg" @prim_subreg_49(clk_i: %2: i1, rst_ni: %3: i1, we: %24: i1, wd: %wr_en_data_arb.wr_data: i10, de: %25: i1, d: %d: i10) -> (qe: i1, q: i10, ds: i10, qs: i10) {sv.namehint = "committed_qs"}
    llhd.drv %committed_q, %committed_reg.q after %1 : i10
    %8 = llhd.prb %re_3 : i1
    llhd.drv %phase_clear, %8 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %29 = llhd.prb %clk_i_0 : i1
      %30 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %phase_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %40 = llhd.prb %wr_en : i1
      %41 = llhd.prb %err_storage : i1
      %42 = comb.xor %41, %true : i1
      %43 = llhd.prb %err_update : i1
      %44 = comb.xor %43, %true : i1
      %45 = comb.and %40, %42, %44 : i1
      cf.cond_br %45, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %46 = llhd.prb %phase_q : i1
      %47 = comb.xor %46, %true : i1
      llhd.drv %phase_q, %47 after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %48 = llhd.prb %phase_clear : i1
      %49 = llhd.prb %err_storage : i1
      %50 = llhd.prb %err_update : i1
      %51 = comb.or %48, %49, %50 : i1
      cf.cond_br %51, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %phase_q, %false after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %29 = llhd.prb %clk_i_0 : i1
      %30 = llhd.prb %rst_shadowed_ni_2 : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %31 = llhd.prb %clk_i_0 : i1
      %32 = comb.xor bin %29, %true : i1
      %33 = comb.and bin %32, %31 : i1
      %34 = llhd.prb %rst_shadowed_ni_2 : i1
      %35 = comb.xor bin %34, %true : i1
      %36 = comb.and bin %30, %35 : i1
      %37 = comb.or bin %33, %36 : i1
      cf.cond_br %37, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %38 = llhd.prb %rst_shadowed_ni_2 : i1
      %39 = comb.xor %38, %true : i1
      cf.cond_br %39, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %shadow_q, %c-491_i10 after %0 : i10
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %40 = llhd.prb %shadow_we : i1
      cf.cond_br %40, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %41 = llhd.prb %shadow_wd : i10
      llhd.drv %shadow_q, %41 after %0 : i10
      cf.br ^bb1
    }
    %9 = llhd.prb %shadow_we : i1
    %10 = llhd.prb %gen_shadow_reg_std.shadow_wr_data : i10
    %11 = llhd.prb %shadow_wd : i10
    %12 = llhd.prb %err_storage : i1
    %13 = llhd.prb %err_update : i1
    %14 = llhd.prb %phase_clear : i1
    %15 = llhd.prb %committed_q : i10
    %16 = llhd.prb %phase_q : i1
    %17 = llhd.prb %gen_shadow_reg_std.shadow_wr_en : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      llhd.drv %shadow_we, %false after %1 : i1
      %29 = llhd.prb %gen_shadow_reg_std.shadow_wr_data : i10
      llhd.drv %shadow_wd, %29 after %1 : i10
      %30 = llhd.prb %err_storage : i1
      %31 = comb.xor %30, %true : i1
      cf.cond_br %31, ^bb2, ^bb6
    ^bb2:  // pred: ^bb1
      %32 = llhd.prb %err_update : i1
      %33 = llhd.prb %phase_clear : i1
      %34 = comb.or %32, %33 : i1
      cf.cond_br %34, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %shadow_we, %true after %1 : i1
      %35 = llhd.prb %committed_q : i10
      %36 = comb.xor %35, %c-1_i10 : i10
      llhd.drv %shadow_wd, %36 after %1 : i10
      cf.br ^bb6
    ^bb4:  // pred: ^bb2
      %37 = llhd.prb %phase_q : i1
      %38 = comb.xor %37, %true : i1
      %39 = llhd.prb %gen_shadow_reg_std.shadow_wr_en : i1
      %40 = comb.and %38, %39 : i1
      cf.cond_br %40, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      llhd.drv %shadow_we, %true after %1 : i1
      %41 = llhd.prb %gen_shadow_reg_std.shadow_wr_data : i10
      llhd.drv %shadow_wd, %41 after %1 : i10
      cf.br ^bb6
    ^bb6:  // 4 preds: ^bb1, ^bb3, ^bb4, ^bb5
      llhd.wait (%9, %10, %11, %12, %13, %14, %15, %16, %17 : i1, i10, i10, i1, i1, i1, i10, i1, i1), ^bb1
    }
    %18 = comb.xor %7, %c-1_i10 : i10
    %19 = comb.icmp ne %18, %wr_en_data_arb.wr_data : i10
    %20 = llhd.prb %wr_en : i1
    %21 = comb.and %19, %16, %20 : i1
    llhd.drv %err_update, %21 after %1 : i1
    %22 = comb.xor %13, %true : i1
    %23 = comb.xor %12, %true : i1
    %24 = comb.and %we, %16, %22, %23 {sv.namehint = "committed_we"} : i1
    %25 = comb.and %de, %16, %22, %23 {sv.namehint = "committed_de"} : i1
    %26 = comb.icmp ne %18, %15 : i10
    %27 = comb.xor %16, %true : i1
    %28 = comb.and %26, %27 : i1
    llhd.drv %err_storage, %28 after %1 : i1
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %rst_shadowed_ni_2, %rst_shadowed_ni after %1 : i1
    llhd.drv %re_3, %re after %1 : i1
    hw.output %committed_reg.qe, %15, %committed_reg.ds, %committed_reg.qs, %16, %13, %12 : i1, i10, i10, i10, i1, i1, i1
  }
  hw.module private @prim_subreg_shadow_19(in %clk_i : i1, in %rst_ni : i1, in %rst_shadowed_ni : i1, in %re : i1, in %we : i1, in %wd : i10, in %de : i1, in %d : i10, out qe : i1, out q : i10, out ds : i10, out qs : i10, out phase : i1, out err_update : i1, out err_storage : i1) {
    %c-471_i10 = hw.constant -471 : i10
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i10 = hw.constant -1 : i10
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i10 = hw.constant 0 : i10
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %rst_shadowed_ni_2 = llhd.sig name "rst_shadowed_ni" %false : i1
    %4 = llhd.prb %rst_shadowed_ni_2 : i1
    %re_3 = llhd.sig name "re" %false : i1
    %err_update = llhd.sig %false : i1
    %err_storage = llhd.sig %false : i1
    %phase_clear = llhd.sig %false : i1
    %phase_q = llhd.sig %false : i1
    %shadow_we = llhd.sig %false : i1
    %shadow_wd = llhd.sig %c0_i10 : i10
    %shadow_q = llhd.sig %c0_i10 : i10
    %committed_q = llhd.sig %c0_i10 : i10
    %wr_en = llhd.sig %false : i1
    %gen_shadow_reg_std.shadow_wr_en = llhd.sig %false : i1
    %gen_shadow_reg_std.shadow_wr_data = llhd.sig %c0_i10 : i10
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_48(we: %we: i1, wd: %wd: i10, de: %de: i1, d: %d: i10, q: %15: i10) -> (wr_en: i1, wr_data: i10) {sv.namehint = "wr_data"}
    llhd.drv %wr_en, %wr_en_data_arb.wr_en after %1 : i1
    %5 = comb.xor %wr_en_data_arb.wr_data, %c-1_i10 : i10
    %6 = comb.xor %d, %c-1_i10 : i10
    %7 = llhd.prb %shadow_q : i10
    %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_en, %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_data = hw.instance "gen_shadow_reg_std.wr_en_data_arb_shadow" @prim_subreg_arb_48(we: %we: i1, wd: %5: i10, de: %de: i1, d: %6: i10, q: %7: i10) -> (wr_en: i1, wr_data: i10)
    llhd.drv %gen_shadow_reg_std.shadow_wr_en, %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_en after %1 : i1
    llhd.drv %gen_shadow_reg_std.shadow_wr_data, %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_data after %1 : i10
    %committed_reg.qe, %committed_reg.q, %committed_reg.ds, %committed_reg.qs = hw.instance "committed_reg" @prim_subreg_50(clk_i: %2: i1, rst_ni: %3: i1, we: %24: i1, wd: %wr_en_data_arb.wr_data: i10, de: %25: i1, d: %d: i10) -> (qe: i1, q: i10, ds: i10, qs: i10) {sv.namehint = "committed_qs"}
    llhd.drv %committed_q, %committed_reg.q after %1 : i10
    %8 = llhd.prb %re_3 : i1
    llhd.drv %phase_clear, %8 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %29 = llhd.prb %clk_i_0 : i1
      %30 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %phase_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %40 = llhd.prb %wr_en : i1
      %41 = llhd.prb %err_storage : i1
      %42 = comb.xor %41, %true : i1
      %43 = llhd.prb %err_update : i1
      %44 = comb.xor %43, %true : i1
      %45 = comb.and %40, %42, %44 : i1
      cf.cond_br %45, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %46 = llhd.prb %phase_q : i1
      %47 = comb.xor %46, %true : i1
      llhd.drv %phase_q, %47 after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %48 = llhd.prb %phase_clear : i1
      %49 = llhd.prb %err_storage : i1
      %50 = llhd.prb %err_update : i1
      %51 = comb.or %48, %49, %50 : i1
      cf.cond_br %51, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %phase_q, %false after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %29 = llhd.prb %clk_i_0 : i1
      %30 = llhd.prb %rst_shadowed_ni_2 : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %31 = llhd.prb %clk_i_0 : i1
      %32 = comb.xor bin %29, %true : i1
      %33 = comb.and bin %32, %31 : i1
      %34 = llhd.prb %rst_shadowed_ni_2 : i1
      %35 = comb.xor bin %34, %true : i1
      %36 = comb.and bin %30, %35 : i1
      %37 = comb.or bin %33, %36 : i1
      cf.cond_br %37, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %38 = llhd.prb %rst_shadowed_ni_2 : i1
      %39 = comb.xor %38, %true : i1
      cf.cond_br %39, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %shadow_q, %c-471_i10 after %0 : i10
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %40 = llhd.prb %shadow_we : i1
      cf.cond_br %40, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %41 = llhd.prb %shadow_wd : i10
      llhd.drv %shadow_q, %41 after %0 : i10
      cf.br ^bb1
    }
    %9 = llhd.prb %shadow_we : i1
    %10 = llhd.prb %gen_shadow_reg_std.shadow_wr_data : i10
    %11 = llhd.prb %shadow_wd : i10
    %12 = llhd.prb %err_storage : i1
    %13 = llhd.prb %err_update : i1
    %14 = llhd.prb %phase_clear : i1
    %15 = llhd.prb %committed_q : i10
    %16 = llhd.prb %phase_q : i1
    %17 = llhd.prb %gen_shadow_reg_std.shadow_wr_en : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      llhd.drv %shadow_we, %false after %1 : i1
      %29 = llhd.prb %gen_shadow_reg_std.shadow_wr_data : i10
      llhd.drv %shadow_wd, %29 after %1 : i10
      %30 = llhd.prb %err_storage : i1
      %31 = comb.xor %30, %true : i1
      cf.cond_br %31, ^bb2, ^bb6
    ^bb2:  // pred: ^bb1
      %32 = llhd.prb %err_update : i1
      %33 = llhd.prb %phase_clear : i1
      %34 = comb.or %32, %33 : i1
      cf.cond_br %34, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %shadow_we, %true after %1 : i1
      %35 = llhd.prb %committed_q : i10
      %36 = comb.xor %35, %c-1_i10 : i10
      llhd.drv %shadow_wd, %36 after %1 : i10
      cf.br ^bb6
    ^bb4:  // pred: ^bb2
      %37 = llhd.prb %phase_q : i1
      %38 = comb.xor %37, %true : i1
      %39 = llhd.prb %gen_shadow_reg_std.shadow_wr_en : i1
      %40 = comb.and %38, %39 : i1
      cf.cond_br %40, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      llhd.drv %shadow_we, %true after %1 : i1
      %41 = llhd.prb %gen_shadow_reg_std.shadow_wr_data : i10
      llhd.drv %shadow_wd, %41 after %1 : i10
      cf.br ^bb6
    ^bb6:  // 4 preds: ^bb1, ^bb3, ^bb4, ^bb5
      llhd.wait (%9, %10, %11, %12, %13, %14, %15, %16, %17 : i1, i10, i10, i1, i1, i1, i10, i1, i1), ^bb1
    }
    %18 = comb.xor %7, %c-1_i10 : i10
    %19 = comb.icmp ne %18, %wr_en_data_arb.wr_data : i10
    %20 = llhd.prb %wr_en : i1
    %21 = comb.and %19, %16, %20 : i1
    llhd.drv %err_update, %21 after %1 : i1
    %22 = comb.xor %13, %true : i1
    %23 = comb.xor %12, %true : i1
    %24 = comb.and %we, %16, %22, %23 {sv.namehint = "committed_we"} : i1
    %25 = comb.and %de, %16, %22, %23 {sv.namehint = "committed_de"} : i1
    %26 = comb.icmp ne %18, %15 : i10
    %27 = comb.xor %16, %true : i1
    %28 = comb.and %26, %27 : i1
    llhd.drv %err_storage, %28 after %1 : i1
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %rst_shadowed_ni_2, %rst_shadowed_ni after %1 : i1
    llhd.drv %re_3, %re after %1 : i1
    hw.output %committed_reg.qe, %15, %committed_reg.ds, %committed_reg.qs, %16, %13, %12 : i1, i10, i10, i10, i1, i1, i1
  }
  hw.module private @prim_subreg_shadow_20(in %clk_i : i1, in %rst_ni : i1, in %rst_shadowed_ni : i1, in %re : i1, in %we : i1, in %wd : i9, in %de : i1, in %d : i9, out qe : i1, out q : i9, out ds : i9, out qs : i9, out phase : i1, out err_update : i1, out err_storage : i1) {
    %c-251_i9 = hw.constant -251 : i9
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i9 = hw.constant -1 : i9
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i9 = hw.constant 0 : i9
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %rst_shadowed_ni_2 = llhd.sig name "rst_shadowed_ni" %false : i1
    %4 = llhd.prb %rst_shadowed_ni_2 : i1
    %re_3 = llhd.sig name "re" %false : i1
    %err_update = llhd.sig %false : i1
    %err_storage = llhd.sig %false : i1
    %phase_clear = llhd.sig %false : i1
    %phase_q = llhd.sig %false : i1
    %shadow_we = llhd.sig %false : i1
    %shadow_wd = llhd.sig %c0_i9 : i9
    %shadow_q = llhd.sig %c0_i9 : i9
    %committed_q = llhd.sig %c0_i9 : i9
    %wr_en = llhd.sig %false : i1
    %gen_shadow_reg_std.shadow_wr_en = llhd.sig %false : i1
    %gen_shadow_reg_std.shadow_wr_data = llhd.sig %c0_i9 : i9
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_51(we: %we: i1, wd: %wd: i9, de: %de: i1, d: %d: i9, q: %15: i9) -> (wr_en: i1, wr_data: i9) {sv.namehint = "wr_data"}
    llhd.drv %wr_en, %wr_en_data_arb.wr_en after %1 : i1
    %5 = comb.xor %wr_en_data_arb.wr_data, %c-1_i9 : i9
    %6 = comb.xor %d, %c-1_i9 : i9
    %7 = llhd.prb %shadow_q : i9
    %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_en, %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_data = hw.instance "gen_shadow_reg_std.wr_en_data_arb_shadow" @prim_subreg_arb_51(we: %we: i1, wd: %5: i9, de: %de: i1, d: %6: i9, q: %7: i9) -> (wr_en: i1, wr_data: i9)
    llhd.drv %gen_shadow_reg_std.shadow_wr_en, %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_en after %1 : i1
    llhd.drv %gen_shadow_reg_std.shadow_wr_data, %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_data after %1 : i9
    %committed_reg.qe, %committed_reg.q, %committed_reg.ds, %committed_reg.qs = hw.instance "committed_reg" @prim_subreg_52(clk_i: %2: i1, rst_ni: %3: i1, we: %24: i1, wd: %wr_en_data_arb.wr_data: i9, de: %25: i1, d: %d: i9) -> (qe: i1, q: i9, ds: i9, qs: i9) {sv.namehint = "committed_qs"}
    llhd.drv %committed_q, %committed_reg.q after %1 : i9
    %8 = llhd.prb %re_3 : i1
    llhd.drv %phase_clear, %8 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %29 = llhd.prb %clk_i_0 : i1
      %30 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %phase_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %40 = llhd.prb %wr_en : i1
      %41 = llhd.prb %err_storage : i1
      %42 = comb.xor %41, %true : i1
      %43 = llhd.prb %err_update : i1
      %44 = comb.xor %43, %true : i1
      %45 = comb.and %40, %42, %44 : i1
      cf.cond_br %45, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %46 = llhd.prb %phase_q : i1
      %47 = comb.xor %46, %true : i1
      llhd.drv %phase_q, %47 after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %48 = llhd.prb %phase_clear : i1
      %49 = llhd.prb %err_storage : i1
      %50 = llhd.prb %err_update : i1
      %51 = comb.or %48, %49, %50 : i1
      cf.cond_br %51, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %phase_q, %false after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %29 = llhd.prb %clk_i_0 : i1
      %30 = llhd.prb %rst_shadowed_ni_2 : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %31 = llhd.prb %clk_i_0 : i1
      %32 = comb.xor bin %29, %true : i1
      %33 = comb.and bin %32, %31 : i1
      %34 = llhd.prb %rst_shadowed_ni_2 : i1
      %35 = comb.xor bin %34, %true : i1
      %36 = comb.and bin %30, %35 : i1
      %37 = comb.or bin %33, %36 : i1
      cf.cond_br %37, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %38 = llhd.prb %rst_shadowed_ni_2 : i1
      %39 = comb.xor %38, %true : i1
      cf.cond_br %39, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %shadow_q, %c-251_i9 after %0 : i9
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %40 = llhd.prb %shadow_we : i1
      cf.cond_br %40, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %41 = llhd.prb %shadow_wd : i9
      llhd.drv %shadow_q, %41 after %0 : i9
      cf.br ^bb1
    }
    %9 = llhd.prb %shadow_we : i1
    %10 = llhd.prb %gen_shadow_reg_std.shadow_wr_data : i9
    %11 = llhd.prb %shadow_wd : i9
    %12 = llhd.prb %err_storage : i1
    %13 = llhd.prb %err_update : i1
    %14 = llhd.prb %phase_clear : i1
    %15 = llhd.prb %committed_q : i9
    %16 = llhd.prb %phase_q : i1
    %17 = llhd.prb %gen_shadow_reg_std.shadow_wr_en : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      llhd.drv %shadow_we, %false after %1 : i1
      %29 = llhd.prb %gen_shadow_reg_std.shadow_wr_data : i9
      llhd.drv %shadow_wd, %29 after %1 : i9
      %30 = llhd.prb %err_storage : i1
      %31 = comb.xor %30, %true : i1
      cf.cond_br %31, ^bb2, ^bb6
    ^bb2:  // pred: ^bb1
      %32 = llhd.prb %err_update : i1
      %33 = llhd.prb %phase_clear : i1
      %34 = comb.or %32, %33 : i1
      cf.cond_br %34, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %shadow_we, %true after %1 : i1
      %35 = llhd.prb %committed_q : i9
      %36 = comb.xor %35, %c-1_i9 : i9
      llhd.drv %shadow_wd, %36 after %1 : i9
      cf.br ^bb6
    ^bb4:  // pred: ^bb2
      %37 = llhd.prb %phase_q : i1
      %38 = comb.xor %37, %true : i1
      %39 = llhd.prb %gen_shadow_reg_std.shadow_wr_en : i1
      %40 = comb.and %38, %39 : i1
      cf.cond_br %40, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      llhd.drv %shadow_we, %true after %1 : i1
      %41 = llhd.prb %gen_shadow_reg_std.shadow_wr_data : i9
      llhd.drv %shadow_wd, %41 after %1 : i9
      cf.br ^bb6
    ^bb6:  // 4 preds: ^bb1, ^bb3, ^bb4, ^bb5
      llhd.wait (%9, %10, %11, %12, %13, %14, %15, %16, %17 : i1, i9, i9, i1, i1, i1, i9, i1, i1), ^bb1
    }
    %18 = comb.xor %7, %c-1_i9 : i9
    %19 = comb.icmp ne %18, %wr_en_data_arb.wr_data : i9
    %20 = llhd.prb %wr_en : i1
    %21 = comb.and %19, %16, %20 : i1
    llhd.drv %err_update, %21 after %1 : i1
    %22 = comb.xor %13, %true : i1
    %23 = comb.xor %12, %true : i1
    %24 = comb.and %we, %16, %22, %23 {sv.namehint = "committed_we"} : i1
    %25 = comb.and %de, %16, %22, %23 {sv.namehint = "committed_de"} : i1
    %26 = comb.icmp ne %18, %15 : i9
    %27 = comb.xor %16, %true : i1
    %28 = comb.and %26, %27 : i1
    llhd.drv %err_storage, %28 after %1 : i1
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %rst_shadowed_ni_2, %rst_shadowed_ni after %1 : i1
    llhd.drv %re_3, %re after %1 : i1
    hw.output %committed_reg.qe, %15, %committed_reg.ds, %committed_reg.qs, %16, %13, %12 : i1, i9, i9, i9, i1, i1, i1
  }
  hw.module private @prim_subreg_shadow_21(in %clk_i : i1, in %rst_ni : i1, in %rst_shadowed_ni : i1, in %re : i1, in %we : i1, in %wd : i9, in %de : i1, in %d : i9, out qe : i1, out q : i9, out ds : i9, out qs : i9, out phase : i1, out err_update : i1, out err_storage : i1) {
    %c-231_i9 = hw.constant -231 : i9
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i9 = hw.constant -1 : i9
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i9 = hw.constant 0 : i9
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %rst_shadowed_ni_2 = llhd.sig name "rst_shadowed_ni" %false : i1
    %4 = llhd.prb %rst_shadowed_ni_2 : i1
    %re_3 = llhd.sig name "re" %false : i1
    %err_update = llhd.sig %false : i1
    %err_storage = llhd.sig %false : i1
    %phase_clear = llhd.sig %false : i1
    %phase_q = llhd.sig %false : i1
    %shadow_we = llhd.sig %false : i1
    %shadow_wd = llhd.sig %c0_i9 : i9
    %shadow_q = llhd.sig %c0_i9 : i9
    %committed_q = llhd.sig %c0_i9 : i9
    %wr_en = llhd.sig %false : i1
    %gen_shadow_reg_std.shadow_wr_en = llhd.sig %false : i1
    %gen_shadow_reg_std.shadow_wr_data = llhd.sig %c0_i9 : i9
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_51(we: %we: i1, wd: %wd: i9, de: %de: i1, d: %d: i9, q: %15: i9) -> (wr_en: i1, wr_data: i9) {sv.namehint = "wr_data"}
    llhd.drv %wr_en, %wr_en_data_arb.wr_en after %1 : i1
    %5 = comb.xor %wr_en_data_arb.wr_data, %c-1_i9 : i9
    %6 = comb.xor %d, %c-1_i9 : i9
    %7 = llhd.prb %shadow_q : i9
    %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_en, %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_data = hw.instance "gen_shadow_reg_std.wr_en_data_arb_shadow" @prim_subreg_arb_51(we: %we: i1, wd: %5: i9, de: %de: i1, d: %6: i9, q: %7: i9) -> (wr_en: i1, wr_data: i9)
    llhd.drv %gen_shadow_reg_std.shadow_wr_en, %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_en after %1 : i1
    llhd.drv %gen_shadow_reg_std.shadow_wr_data, %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_data after %1 : i9
    %committed_reg.qe, %committed_reg.q, %committed_reg.ds, %committed_reg.qs = hw.instance "committed_reg" @prim_subreg_53(clk_i: %2: i1, rst_ni: %3: i1, we: %24: i1, wd: %wr_en_data_arb.wr_data: i9, de: %25: i1, d: %d: i9) -> (qe: i1, q: i9, ds: i9, qs: i9) {sv.namehint = "committed_qs"}
    llhd.drv %committed_q, %committed_reg.q after %1 : i9
    %8 = llhd.prb %re_3 : i1
    llhd.drv %phase_clear, %8 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %29 = llhd.prb %clk_i_0 : i1
      %30 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %phase_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %40 = llhd.prb %wr_en : i1
      %41 = llhd.prb %err_storage : i1
      %42 = comb.xor %41, %true : i1
      %43 = llhd.prb %err_update : i1
      %44 = comb.xor %43, %true : i1
      %45 = comb.and %40, %42, %44 : i1
      cf.cond_br %45, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %46 = llhd.prb %phase_q : i1
      %47 = comb.xor %46, %true : i1
      llhd.drv %phase_q, %47 after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %48 = llhd.prb %phase_clear : i1
      %49 = llhd.prb %err_storage : i1
      %50 = llhd.prb %err_update : i1
      %51 = comb.or %48, %49, %50 : i1
      cf.cond_br %51, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %phase_q, %false after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %29 = llhd.prb %clk_i_0 : i1
      %30 = llhd.prb %rst_shadowed_ni_2 : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %31 = llhd.prb %clk_i_0 : i1
      %32 = comb.xor bin %29, %true : i1
      %33 = comb.and bin %32, %31 : i1
      %34 = llhd.prb %rst_shadowed_ni_2 : i1
      %35 = comb.xor bin %34, %true : i1
      %36 = comb.and bin %30, %35 : i1
      %37 = comb.or bin %33, %36 : i1
      cf.cond_br %37, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %38 = llhd.prb %rst_shadowed_ni_2 : i1
      %39 = comb.xor %38, %true : i1
      cf.cond_br %39, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %shadow_q, %c-231_i9 after %0 : i9
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %40 = llhd.prb %shadow_we : i1
      cf.cond_br %40, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %41 = llhd.prb %shadow_wd : i9
      llhd.drv %shadow_q, %41 after %0 : i9
      cf.br ^bb1
    }
    %9 = llhd.prb %shadow_we : i1
    %10 = llhd.prb %gen_shadow_reg_std.shadow_wr_data : i9
    %11 = llhd.prb %shadow_wd : i9
    %12 = llhd.prb %err_storage : i1
    %13 = llhd.prb %err_update : i1
    %14 = llhd.prb %phase_clear : i1
    %15 = llhd.prb %committed_q : i9
    %16 = llhd.prb %phase_q : i1
    %17 = llhd.prb %gen_shadow_reg_std.shadow_wr_en : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      llhd.drv %shadow_we, %false after %1 : i1
      %29 = llhd.prb %gen_shadow_reg_std.shadow_wr_data : i9
      llhd.drv %shadow_wd, %29 after %1 : i9
      %30 = llhd.prb %err_storage : i1
      %31 = comb.xor %30, %true : i1
      cf.cond_br %31, ^bb2, ^bb6
    ^bb2:  // pred: ^bb1
      %32 = llhd.prb %err_update : i1
      %33 = llhd.prb %phase_clear : i1
      %34 = comb.or %32, %33 : i1
      cf.cond_br %34, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %shadow_we, %true after %1 : i1
      %35 = llhd.prb %committed_q : i9
      %36 = comb.xor %35, %c-1_i9 : i9
      llhd.drv %shadow_wd, %36 after %1 : i9
      cf.br ^bb6
    ^bb4:  // pred: ^bb2
      %37 = llhd.prb %phase_q : i1
      %38 = comb.xor %37, %true : i1
      %39 = llhd.prb %gen_shadow_reg_std.shadow_wr_en : i1
      %40 = comb.and %38, %39 : i1
      cf.cond_br %40, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      llhd.drv %shadow_we, %true after %1 : i1
      %41 = llhd.prb %gen_shadow_reg_std.shadow_wr_data : i9
      llhd.drv %shadow_wd, %41 after %1 : i9
      cf.br ^bb6
    ^bb6:  // 4 preds: ^bb1, ^bb3, ^bb4, ^bb5
      llhd.wait (%9, %10, %11, %12, %13, %14, %15, %16, %17 : i1, i9, i9, i1, i1, i1, i9, i1, i1), ^bb1
    }
    %18 = comb.xor %7, %c-1_i9 : i9
    %19 = comb.icmp ne %18, %wr_en_data_arb.wr_data : i9
    %20 = llhd.prb %wr_en : i1
    %21 = comb.and %19, %16, %20 : i1
    llhd.drv %err_update, %21 after %1 : i1
    %22 = comb.xor %13, %true : i1
    %23 = comb.xor %12, %true : i1
    %24 = comb.and %we, %16, %22, %23 {sv.namehint = "committed_we"} : i1
    %25 = comb.and %de, %16, %22, %23 {sv.namehint = "committed_de"} : i1
    %26 = comb.icmp ne %18, %15 : i9
    %27 = comb.xor %16, %true : i1
    %28 = comb.and %26, %27 : i1
    llhd.drv %err_storage, %28 after %1 : i1
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %rst_shadowed_ni_2, %rst_shadowed_ni after %1 : i1
    llhd.drv %re_3, %re after %1 : i1
    hw.output %committed_reg.qe, %15, %committed_reg.ds, %committed_reg.qs, %16, %13, %12 : i1, i9, i9, i9, i1, i1, i1
  }
  hw.module private @prim_subreg_shadow_22(in %clk_i : i1, in %rst_ni : i1, in %rst_shadowed_ni : i1, in %re : i1, in %we : i1, in %wd : i8, in %de : i1, in %d : i8, out qe : i1, out q : i8, out ds : i8, out qs : i8, out phase : i1, out err_update : i1, out err_storage : i1) {
    %c125_i8 = hw.constant 125 : i8
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i8 = hw.constant -1 : i8
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i8 = hw.constant 0 : i8
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %rst_shadowed_ni_2 = llhd.sig name "rst_shadowed_ni" %false : i1
    %4 = llhd.prb %rst_shadowed_ni_2 : i1
    %re_3 = llhd.sig name "re" %false : i1
    %err_update = llhd.sig %false : i1
    %err_storage = llhd.sig %false : i1
    %phase_clear = llhd.sig %false : i1
    %phase_q = llhd.sig %false : i1
    %shadow_we = llhd.sig %false : i1
    %shadow_wd = llhd.sig %c0_i8 : i8
    %shadow_q = llhd.sig %c0_i8 : i8
    %committed_q = llhd.sig %c0_i8 : i8
    %wr_en = llhd.sig %false : i1
    %gen_shadow_reg_std.shadow_wr_en = llhd.sig %false : i1
    %gen_shadow_reg_std.shadow_wr_data = llhd.sig %c0_i8 : i8
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_54(we: %we: i1, wd: %wd: i8, de: %de: i1, d: %d: i8, q: %15: i8) -> (wr_en: i1, wr_data: i8) {sv.namehint = "wr_data"}
    llhd.drv %wr_en, %wr_en_data_arb.wr_en after %1 : i1
    %5 = comb.xor %wr_en_data_arb.wr_data, %c-1_i8 : i8
    %6 = comb.xor %d, %c-1_i8 : i8
    %7 = llhd.prb %shadow_q : i8
    %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_en, %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_data = hw.instance "gen_shadow_reg_std.wr_en_data_arb_shadow" @prim_subreg_arb_54(we: %we: i1, wd: %5: i8, de: %de: i1, d: %6: i8, q: %7: i8) -> (wr_en: i1, wr_data: i8)
    llhd.drv %gen_shadow_reg_std.shadow_wr_en, %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_en after %1 : i1
    llhd.drv %gen_shadow_reg_std.shadow_wr_data, %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_data after %1 : i8
    %committed_reg.qe, %committed_reg.q, %committed_reg.ds, %committed_reg.qs = hw.instance "committed_reg" @prim_subreg_55(clk_i: %2: i1, rst_ni: %3: i1, we: %24: i1, wd: %wr_en_data_arb.wr_data: i8, de: %25: i1, d: %d: i8) -> (qe: i1, q: i8, ds: i8, qs: i8) {sv.namehint = "committed_qs"}
    llhd.drv %committed_q, %committed_reg.q after %1 : i8
    %8 = llhd.prb %re_3 : i1
    llhd.drv %phase_clear, %8 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %29 = llhd.prb %clk_i_0 : i1
      %30 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %phase_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %40 = llhd.prb %wr_en : i1
      %41 = llhd.prb %err_storage : i1
      %42 = comb.xor %41, %true : i1
      %43 = llhd.prb %err_update : i1
      %44 = comb.xor %43, %true : i1
      %45 = comb.and %40, %42, %44 : i1
      cf.cond_br %45, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %46 = llhd.prb %phase_q : i1
      %47 = comb.xor %46, %true : i1
      llhd.drv %phase_q, %47 after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %48 = llhd.prb %phase_clear : i1
      %49 = llhd.prb %err_storage : i1
      %50 = llhd.prb %err_update : i1
      %51 = comb.or %48, %49, %50 : i1
      cf.cond_br %51, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %phase_q, %false after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %29 = llhd.prb %clk_i_0 : i1
      %30 = llhd.prb %rst_shadowed_ni_2 : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %31 = llhd.prb %clk_i_0 : i1
      %32 = comb.xor bin %29, %true : i1
      %33 = comb.and bin %32, %31 : i1
      %34 = llhd.prb %rst_shadowed_ni_2 : i1
      %35 = comb.xor bin %34, %true : i1
      %36 = comb.and bin %30, %35 : i1
      %37 = comb.or bin %33, %36 : i1
      cf.cond_br %37, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %38 = llhd.prb %rst_shadowed_ni_2 : i1
      %39 = comb.xor %38, %true : i1
      cf.cond_br %39, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %shadow_q, %c125_i8 after %0 : i8
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %40 = llhd.prb %shadow_we : i1
      cf.cond_br %40, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %41 = llhd.prb %shadow_wd : i8
      llhd.drv %shadow_q, %41 after %0 : i8
      cf.br ^bb1
    }
    %9 = llhd.prb %shadow_we : i1
    %10 = llhd.prb %gen_shadow_reg_std.shadow_wr_data : i8
    %11 = llhd.prb %shadow_wd : i8
    %12 = llhd.prb %err_storage : i1
    %13 = llhd.prb %err_update : i1
    %14 = llhd.prb %phase_clear : i1
    %15 = llhd.prb %committed_q : i8
    %16 = llhd.prb %phase_q : i1
    %17 = llhd.prb %gen_shadow_reg_std.shadow_wr_en : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      llhd.drv %shadow_we, %false after %1 : i1
      %29 = llhd.prb %gen_shadow_reg_std.shadow_wr_data : i8
      llhd.drv %shadow_wd, %29 after %1 : i8
      %30 = llhd.prb %err_storage : i1
      %31 = comb.xor %30, %true : i1
      cf.cond_br %31, ^bb2, ^bb6
    ^bb2:  // pred: ^bb1
      %32 = llhd.prb %err_update : i1
      %33 = llhd.prb %phase_clear : i1
      %34 = comb.or %32, %33 : i1
      cf.cond_br %34, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %shadow_we, %true after %1 : i1
      %35 = llhd.prb %committed_q : i8
      %36 = comb.xor %35, %c-1_i8 : i8
      llhd.drv %shadow_wd, %36 after %1 : i8
      cf.br ^bb6
    ^bb4:  // pred: ^bb2
      %37 = llhd.prb %phase_q : i1
      %38 = comb.xor %37, %true : i1
      %39 = llhd.prb %gen_shadow_reg_std.shadow_wr_en : i1
      %40 = comb.and %38, %39 : i1
      cf.cond_br %40, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      llhd.drv %shadow_we, %true after %1 : i1
      %41 = llhd.prb %gen_shadow_reg_std.shadow_wr_data : i8
      llhd.drv %shadow_wd, %41 after %1 : i8
      cf.br ^bb6
    ^bb6:  // 4 preds: ^bb1, ^bb3, ^bb4, ^bb5
      llhd.wait (%9, %10, %11, %12, %13, %14, %15, %16, %17 : i1, i8, i8, i1, i1, i1, i8, i1, i1), ^bb1
    }
    %18 = comb.xor %7, %c-1_i8 : i8
    %19 = comb.icmp ne %18, %wr_en_data_arb.wr_data : i8
    %20 = llhd.prb %wr_en : i1
    %21 = comb.and %19, %16, %20 : i1
    llhd.drv %err_update, %21 after %1 : i1
    %22 = comb.xor %13, %true : i1
    %23 = comb.xor %12, %true : i1
    %24 = comb.and %we, %16, %22, %23 {sv.namehint = "committed_we"} : i1
    %25 = comb.and %de, %16, %22, %23 {sv.namehint = "committed_de"} : i1
    %26 = comb.icmp ne %18, %15 : i8
    %27 = comb.xor %16, %true : i1
    %28 = comb.and %26, %27 : i1
    llhd.drv %err_storage, %28 after %1 : i1
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %rst_shadowed_ni_2, %rst_shadowed_ni after %1 : i1
    llhd.drv %re_3, %re after %1 : i1
    hw.output %committed_reg.qe, %15, %committed_reg.ds, %committed_reg.qs, %16, %13, %12 : i1, i8, i8, i8, i1, i1, i1
  }
  hw.module private @prim_subreg_shadow_23(in %clk_i : i1, in %rst_ni : i1, in %rst_shadowed_ni : i1, in %re : i1, in %we : i1, in %wd : i8, in %de : i1, in %d : i8, out qe : i1, out q : i8, out ds : i8, out qs : i8, out phase : i1, out err_update : i1, out err_storage : i1) {
    %c-111_i8 = hw.constant -111 : i8
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i8 = hw.constant -1 : i8
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i8 = hw.constant 0 : i8
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %rst_shadowed_ni_2 = llhd.sig name "rst_shadowed_ni" %false : i1
    %4 = llhd.prb %rst_shadowed_ni_2 : i1
    %re_3 = llhd.sig name "re" %false : i1
    %err_update = llhd.sig %false : i1
    %err_storage = llhd.sig %false : i1
    %phase_clear = llhd.sig %false : i1
    %phase_q = llhd.sig %false : i1
    %shadow_we = llhd.sig %false : i1
    %shadow_wd = llhd.sig %c0_i8 : i8
    %shadow_q = llhd.sig %c0_i8 : i8
    %committed_q = llhd.sig %c0_i8 : i8
    %wr_en = llhd.sig %false : i1
    %gen_shadow_reg_std.shadow_wr_en = llhd.sig %false : i1
    %gen_shadow_reg_std.shadow_wr_data = llhd.sig %c0_i8 : i8
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_54(we: %we: i1, wd: %wd: i8, de: %de: i1, d: %d: i8, q: %15: i8) -> (wr_en: i1, wr_data: i8) {sv.namehint = "wr_data"}
    llhd.drv %wr_en, %wr_en_data_arb.wr_en after %1 : i1
    %5 = comb.xor %wr_en_data_arb.wr_data, %c-1_i8 : i8
    %6 = comb.xor %d, %c-1_i8 : i8
    %7 = llhd.prb %shadow_q : i8
    %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_en, %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_data = hw.instance "gen_shadow_reg_std.wr_en_data_arb_shadow" @prim_subreg_arb_54(we: %we: i1, wd: %5: i8, de: %de: i1, d: %6: i8, q: %7: i8) -> (wr_en: i1, wr_data: i8)
    llhd.drv %gen_shadow_reg_std.shadow_wr_en, %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_en after %1 : i1
    llhd.drv %gen_shadow_reg_std.shadow_wr_data, %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_data after %1 : i8
    %committed_reg.qe, %committed_reg.q, %committed_reg.ds, %committed_reg.qs = hw.instance "committed_reg" @prim_subreg_56(clk_i: %2: i1, rst_ni: %3: i1, we: %24: i1, wd: %wr_en_data_arb.wr_data: i8, de: %25: i1, d: %d: i8) -> (qe: i1, q: i8, ds: i8, qs: i8) {sv.namehint = "committed_qs"}
    llhd.drv %committed_q, %committed_reg.q after %1 : i8
    %8 = llhd.prb %re_3 : i1
    llhd.drv %phase_clear, %8 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %29 = llhd.prb %clk_i_0 : i1
      %30 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %phase_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %40 = llhd.prb %wr_en : i1
      %41 = llhd.prb %err_storage : i1
      %42 = comb.xor %41, %true : i1
      %43 = llhd.prb %err_update : i1
      %44 = comb.xor %43, %true : i1
      %45 = comb.and %40, %42, %44 : i1
      cf.cond_br %45, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %46 = llhd.prb %phase_q : i1
      %47 = comb.xor %46, %true : i1
      llhd.drv %phase_q, %47 after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %48 = llhd.prb %phase_clear : i1
      %49 = llhd.prb %err_storage : i1
      %50 = llhd.prb %err_update : i1
      %51 = comb.or %48, %49, %50 : i1
      cf.cond_br %51, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %phase_q, %false after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %29 = llhd.prb %clk_i_0 : i1
      %30 = llhd.prb %rst_shadowed_ni_2 : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %31 = llhd.prb %clk_i_0 : i1
      %32 = comb.xor bin %29, %true : i1
      %33 = comb.and bin %32, %31 : i1
      %34 = llhd.prb %rst_shadowed_ni_2 : i1
      %35 = comb.xor bin %34, %true : i1
      %36 = comb.and bin %30, %35 : i1
      %37 = comb.or bin %33, %36 : i1
      cf.cond_br %37, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %38 = llhd.prb %rst_shadowed_ni_2 : i1
      %39 = comb.xor %38, %true : i1
      cf.cond_br %39, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %shadow_q, %c-111_i8 after %0 : i8
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %40 = llhd.prb %shadow_we : i1
      cf.cond_br %40, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %41 = llhd.prb %shadow_wd : i8
      llhd.drv %shadow_q, %41 after %0 : i8
      cf.br ^bb1
    }
    %9 = llhd.prb %shadow_we : i1
    %10 = llhd.prb %gen_shadow_reg_std.shadow_wr_data : i8
    %11 = llhd.prb %shadow_wd : i8
    %12 = llhd.prb %err_storage : i1
    %13 = llhd.prb %err_update : i1
    %14 = llhd.prb %phase_clear : i1
    %15 = llhd.prb %committed_q : i8
    %16 = llhd.prb %phase_q : i1
    %17 = llhd.prb %gen_shadow_reg_std.shadow_wr_en : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      llhd.drv %shadow_we, %false after %1 : i1
      %29 = llhd.prb %gen_shadow_reg_std.shadow_wr_data : i8
      llhd.drv %shadow_wd, %29 after %1 : i8
      %30 = llhd.prb %err_storage : i1
      %31 = comb.xor %30, %true : i1
      cf.cond_br %31, ^bb2, ^bb6
    ^bb2:  // pred: ^bb1
      %32 = llhd.prb %err_update : i1
      %33 = llhd.prb %phase_clear : i1
      %34 = comb.or %32, %33 : i1
      cf.cond_br %34, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %shadow_we, %true after %1 : i1
      %35 = llhd.prb %committed_q : i8
      %36 = comb.xor %35, %c-1_i8 : i8
      llhd.drv %shadow_wd, %36 after %1 : i8
      cf.br ^bb6
    ^bb4:  // pred: ^bb2
      %37 = llhd.prb %phase_q : i1
      %38 = comb.xor %37, %true : i1
      %39 = llhd.prb %gen_shadow_reg_std.shadow_wr_en : i1
      %40 = comb.and %38, %39 : i1
      cf.cond_br %40, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      llhd.drv %shadow_we, %true after %1 : i1
      %41 = llhd.prb %gen_shadow_reg_std.shadow_wr_data : i8
      llhd.drv %shadow_wd, %41 after %1 : i8
      cf.br ^bb6
    ^bb6:  // 4 preds: ^bb1, ^bb3, ^bb4, ^bb5
      llhd.wait (%9, %10, %11, %12, %13, %14, %15, %16, %17 : i1, i8, i8, i1, i1, i1, i8, i1, i1), ^bb1
    }
    %18 = comb.xor %7, %c-1_i8 : i8
    %19 = comb.icmp ne %18, %wr_en_data_arb.wr_data : i8
    %20 = llhd.prb %wr_en : i1
    %21 = comb.and %19, %16, %20 : i1
    llhd.drv %err_update, %21 after %1 : i1
    %22 = comb.xor %13, %true : i1
    %23 = comb.xor %12, %true : i1
    %24 = comb.and %we, %16, %22, %23 {sv.namehint = "committed_we"} : i1
    %25 = comb.and %de, %16, %22, %23 {sv.namehint = "committed_de"} : i1
    %26 = comb.icmp ne %18, %15 : i8
    %27 = comb.xor %16, %true : i1
    %28 = comb.and %26, %27 : i1
    llhd.drv %err_storage, %28 after %1 : i1
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %rst_shadowed_ni_2, %rst_shadowed_ni after %1 : i1
    llhd.drv %re_3, %re after %1 : i1
    hw.output %committed_reg.qe, %15, %committed_reg.ds, %committed_reg.qs, %16, %13, %12 : i1, i8, i8, i8, i1, i1, i1
  }
  hw.module private @prim_subreg_shadow_24(in %clk_i : i1, in %rst_ni : i1, in %rst_shadowed_ni : i1, in %re : i1, in %we : i1, in %wd : i10, in %de : i1, in %d : i10, out qe : i1, out q : i10, out ds : i10, out qs : i10, out phase : i1, out err_update : i1, out err_storage : i1) {
    %c-511_i10 = hw.constant -511 : i10
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i10 = hw.constant -1 : i10
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i10 = hw.constant 0 : i10
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %rst_shadowed_ni_2 = llhd.sig name "rst_shadowed_ni" %false : i1
    %4 = llhd.prb %rst_shadowed_ni_2 : i1
    %re_3 = llhd.sig name "re" %false : i1
    %err_update = llhd.sig %false : i1
    %err_storage = llhd.sig %false : i1
    %phase_clear = llhd.sig %false : i1
    %phase_q = llhd.sig %false : i1
    %shadow_we = llhd.sig %false : i1
    %shadow_wd = llhd.sig %c0_i10 : i10
    %shadow_q = llhd.sig %c0_i10 : i10
    %committed_q = llhd.sig %c0_i10 : i10
    %wr_en = llhd.sig %false : i1
    %gen_shadow_reg_std.shadow_wr_en = llhd.sig %false : i1
    %gen_shadow_reg_std.shadow_wr_data = llhd.sig %c0_i10 : i10
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_48(we: %we: i1, wd: %wd: i10, de: %de: i1, d: %d: i10, q: %15: i10) -> (wr_en: i1, wr_data: i10) {sv.namehint = "wr_data"}
    llhd.drv %wr_en, %wr_en_data_arb.wr_en after %1 : i1
    %5 = comb.xor %wr_en_data_arb.wr_data, %c-1_i10 : i10
    %6 = comb.xor %d, %c-1_i10 : i10
    %7 = llhd.prb %shadow_q : i10
    %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_en, %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_data = hw.instance "gen_shadow_reg_std.wr_en_data_arb_shadow" @prim_subreg_arb_48(we: %we: i1, wd: %5: i10, de: %de: i1, d: %6: i10, q: %7: i10) -> (wr_en: i1, wr_data: i10)
    llhd.drv %gen_shadow_reg_std.shadow_wr_en, %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_en after %1 : i1
    llhd.drv %gen_shadow_reg_std.shadow_wr_data, %gen_shadow_reg_std.wr_en_data_arb_shadow.wr_data after %1 : i10
    %committed_reg.qe, %committed_reg.q, %committed_reg.ds, %committed_reg.qs = hw.instance "committed_reg" @prim_subreg_57(clk_i: %2: i1, rst_ni: %3: i1, we: %24: i1, wd: %wr_en_data_arb.wr_data: i10, de: %25: i1, d: %d: i10) -> (qe: i1, q: i10, ds: i10, qs: i10) {sv.namehint = "committed_qs"}
    llhd.drv %committed_q, %committed_reg.q after %1 : i10
    %8 = llhd.prb %re_3 : i1
    llhd.drv %phase_clear, %8 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %29 = llhd.prb %clk_i_0 : i1
      %30 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %phase_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %40 = llhd.prb %wr_en : i1
      %41 = llhd.prb %err_storage : i1
      %42 = comb.xor %41, %true : i1
      %43 = llhd.prb %err_update : i1
      %44 = comb.xor %43, %true : i1
      %45 = comb.and %40, %42, %44 : i1
      cf.cond_br %45, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %46 = llhd.prb %phase_q : i1
      %47 = comb.xor %46, %true : i1
      llhd.drv %phase_q, %47 after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %48 = llhd.prb %phase_clear : i1
      %49 = llhd.prb %err_storage : i1
      %50 = llhd.prb %err_update : i1
      %51 = comb.or %48, %49, %50 : i1
      cf.cond_br %51, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %phase_q, %false after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %29 = llhd.prb %clk_i_0 : i1
      %30 = llhd.prb %rst_shadowed_ni_2 : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %31 = llhd.prb %clk_i_0 : i1
      %32 = comb.xor bin %29, %true : i1
      %33 = comb.and bin %32, %31 : i1
      %34 = llhd.prb %rst_shadowed_ni_2 : i1
      %35 = comb.xor bin %34, %true : i1
      %36 = comb.and bin %30, %35 : i1
      %37 = comb.or bin %33, %36 : i1
      cf.cond_br %37, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %38 = llhd.prb %rst_shadowed_ni_2 : i1
      %39 = comb.xor %38, %true : i1
      cf.cond_br %39, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %shadow_q, %c-511_i10 after %0 : i10
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %40 = llhd.prb %shadow_we : i1
      cf.cond_br %40, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %41 = llhd.prb %shadow_wd : i10
      llhd.drv %shadow_q, %41 after %0 : i10
      cf.br ^bb1
    }
    %9 = llhd.prb %shadow_we : i1
    %10 = llhd.prb %gen_shadow_reg_std.shadow_wr_data : i10
    %11 = llhd.prb %shadow_wd : i10
    %12 = llhd.prb %err_storage : i1
    %13 = llhd.prb %err_update : i1
    %14 = llhd.prb %phase_clear : i1
    %15 = llhd.prb %committed_q : i10
    %16 = llhd.prb %phase_q : i1
    %17 = llhd.prb %gen_shadow_reg_std.shadow_wr_en : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      llhd.drv %shadow_we, %false after %1 : i1
      %29 = llhd.prb %gen_shadow_reg_std.shadow_wr_data : i10
      llhd.drv %shadow_wd, %29 after %1 : i10
      %30 = llhd.prb %err_storage : i1
      %31 = comb.xor %30, %true : i1
      cf.cond_br %31, ^bb2, ^bb6
    ^bb2:  // pred: ^bb1
      %32 = llhd.prb %err_update : i1
      %33 = llhd.prb %phase_clear : i1
      %34 = comb.or %32, %33 : i1
      cf.cond_br %34, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %shadow_we, %true after %1 : i1
      %35 = llhd.prb %committed_q : i10
      %36 = comb.xor %35, %c-1_i10 : i10
      llhd.drv %shadow_wd, %36 after %1 : i10
      cf.br ^bb6
    ^bb4:  // pred: ^bb2
      %37 = llhd.prb %phase_q : i1
      %38 = comb.xor %37, %true : i1
      %39 = llhd.prb %gen_shadow_reg_std.shadow_wr_en : i1
      %40 = comb.and %38, %39 : i1
      cf.cond_br %40, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      llhd.drv %shadow_we, %true after %1 : i1
      %41 = llhd.prb %gen_shadow_reg_std.shadow_wr_data : i10
      llhd.drv %shadow_wd, %41 after %1 : i10
      cf.br ^bb6
    ^bb6:  // 4 preds: ^bb1, ^bb3, ^bb4, ^bb5
      llhd.wait (%9, %10, %11, %12, %13, %14, %15, %16, %17 : i1, i10, i10, i1, i1, i1, i10, i1, i1), ^bb1
    }
    %18 = comb.xor %7, %c-1_i10 : i10
    %19 = comb.icmp ne %18, %wr_en_data_arb.wr_data : i10
    %20 = llhd.prb %wr_en : i1
    %21 = comb.and %19, %16, %20 : i1
    llhd.drv %err_update, %21 after %1 : i1
    %22 = comb.xor %13, %true : i1
    %23 = comb.xor %12, %true : i1
    %24 = comb.and %we, %16, %22, %23 {sv.namehint = "committed_we"} : i1
    %25 = comb.and %de, %16, %22, %23 {sv.namehint = "committed_de"} : i1
    %26 = comb.icmp ne %18, %15 : i10
    %27 = comb.xor %16, %true : i1
    %28 = comb.and %26, %27 : i1
    llhd.drv %err_storage, %28 after %1 : i1
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %rst_shadowed_ni_2, %rst_shadowed_ni after %1 : i1
    llhd.drv %re_3, %re after %1 : i1
    hw.output %committed_reg.qe, %15, %committed_reg.ds, %committed_reg.qs, %16, %13, %12 : i1, i10, i10, i10, i1, i1, i1
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
  hw.module private @prim_subreg_15(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i4, in %de : i1, in %d : i4, out qe : i1, out q : i4, out ds : i4, out qs : i4) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_45(we: %we: i1, wd: %wd: i4, de: %de: i1, d: %d: i4, q: %4: i4) -> (wr_en: i1, wr_data: i4)
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
  hw.module private @prim_subreg_17(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i1, in %de : i1, in %d : i1, out qe : i1, out q : i1, out ds : i1, out qs : i1) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_46(we: %we: i1, wd: %wd: i1, de: %de: i1, d: %d: i1, q: %4: i1) -> (wr_en: i1, wr_data: i1)
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
  hw.module private @prim_subreg_18(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i1, in %de : i1, in %d : i1, out qe : i1, out q : i1, out ds : i1, out qs : i1) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_47(we: %we: i1, wd: %wd: i1, de: %de: i1, d: %d: i1, q: %4: i1) -> (wr_en: i1, wr_data: i1)
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
  hw.module private @prim_subreg_25(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i1, in %de : i1, in %d : i1, out qe : i1, out q : i1, out ds : i1, out qs : i1) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_58(we: %we: i1, wd: %wd: i1, de: %de: i1, d: %d: i1, q: %4: i1) -> (wr_en: i1, wr_data: i1)
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
  hw.module private @prim_subreg_26(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i1, in %de : i1, in %d : i1, out qe : i1, out q : i1, out ds : i1, out qs : i1) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_47(we: %we: i1, wd: %wd: i1, de: %de: i1, d: %d: i1, q: %4: i1) -> (wr_en: i1, wr_data: i1)
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
  hw.module private @prim_subreg_49(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i10, in %de : i1, in %d : i10, out qe : i1, out q : i10, out ds : i10, out qs : i10) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i10 = hw.constant 0 : i10
    %c490_i10 = hw.constant 490 : i10
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_48(we: %we: i1, wd: %wd: i10, de: %de: i1, d: %d: i10, q: %4: i10) -> (wr_en: i1, wr_data: i10)
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
      llhd.drv %q, %c490_i10 after %0 : i10
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
  hw.module private @prim_subreg_50(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i10, in %de : i1, in %d : i10, out qe : i1, out q : i10, out ds : i10, out qs : i10) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i10 = hw.constant 0 : i10
    %c470_i10 = hw.constant 470 : i10
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_48(we: %we: i1, wd: %wd: i10, de: %de: i1, d: %d: i10, q: %4: i10) -> (wr_en: i1, wr_data: i10)
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
      llhd.drv %q, %c470_i10 after %0 : i10
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
  hw.module private @prim_subreg_52(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i9, in %de : i1, in %d : i9, out qe : i1, out q : i9, out ds : i9, out qs : i9) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i9 = hw.constant 0 : i9
    %c250_i9 = hw.constant 250 : i9
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_51(we: %we: i1, wd: %wd: i9, de: %de: i1, d: %d: i9, q: %4: i9) -> (wr_en: i1, wr_data: i9)
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
      llhd.drv %q, %c250_i9 after %0 : i9
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
  hw.module private @prim_subreg_53(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i9, in %de : i1, in %d : i9, out qe : i1, out q : i9, out ds : i9, out qs : i9) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i9 = hw.constant 0 : i9
    %c230_i9 = hw.constant 230 : i9
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_51(we: %we: i1, wd: %wd: i9, de: %de: i1, d: %d: i9, q: %4: i9) -> (wr_en: i1, wr_data: i9)
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
      llhd.drv %q, %c230_i9 after %0 : i9
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
  hw.module private @prim_subreg_55(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i8, in %de : i1, in %d : i8, out qe : i1, out q : i8, out ds : i8, out qs : i8) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i8 = hw.constant 0 : i8
    %c-126_i8 = hw.constant -126 : i8
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %q = llhd.sig %c0_i8 : i8
    %qs = llhd.sig %c0_i8 : i8
    %wr_en = llhd.sig %false : i1
    %wr_data = llhd.sig %c0_i8 : i8
    %4 = llhd.prb %q : i8
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_54(we: %we: i1, wd: %wd: i8, de: %de: i1, d: %d: i8, q: %4: i8) -> (wr_en: i1, wr_data: i8)
    llhd.drv %wr_en, %wr_en_data_arb.wr_en after %1 : i1
    llhd.drv %wr_data, %wr_en_data_arb.wr_data after %1 : i8
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
      llhd.drv %q, %c-126_i8 after %0 : i8
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %20 = llhd.prb %wr_en : i1
      cf.cond_br %20, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %21 = llhd.prb %wr_data : i8
      llhd.drv %q, %21 after %0 : i8
      cf.br ^bb1
    }
    %5 = llhd.prb %wr_en : i1
    %6 = llhd.prb %wr_data : i8
    %7 = llhd.prb %qs : i8
    %8 = comb.mux %5, %6, %7 : i8
    llhd.drv %qs, %4 after %1 : i8
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    hw.output %we, %4, %8, %7 : i1, i8, i8, i8
  }
  hw.module private @prim_subreg_56(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i8, in %de : i1, in %d : i8, out qe : i1, out q : i8, out ds : i8, out qs : i8) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i8 = hw.constant 0 : i8
    %c110_i8 = hw.constant 110 : i8
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %q = llhd.sig %c0_i8 : i8
    %qs = llhd.sig %c0_i8 : i8
    %wr_en = llhd.sig %false : i1
    %wr_data = llhd.sig %c0_i8 : i8
    %4 = llhd.prb %q : i8
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_54(we: %we: i1, wd: %wd: i8, de: %de: i1, d: %d: i8, q: %4: i8) -> (wr_en: i1, wr_data: i8)
    llhd.drv %wr_en, %wr_en_data_arb.wr_en after %1 : i1
    llhd.drv %wr_data, %wr_en_data_arb.wr_data after %1 : i8
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
      llhd.drv %q, %c110_i8 after %0 : i8
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %20 = llhd.prb %wr_en : i1
      cf.cond_br %20, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %21 = llhd.prb %wr_data : i8
      llhd.drv %q, %21 after %0 : i8
      cf.br ^bb1
    }
    %5 = llhd.prb %wr_en : i1
    %6 = llhd.prb %wr_data : i8
    %7 = llhd.prb %qs : i8
    %8 = comb.mux %5, %6, %7 : i8
    llhd.drv %qs, %4 after %1 : i8
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    hw.output %we, %4, %8, %7 : i1, i8, i8, i8
  }
  hw.module private @prim_subreg_57(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i10, in %de : i1, in %d : i10, out qe : i1, out q : i10, out ds : i10, out qs : i10) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i10 = hw.constant 0 : i10
    %c510_i10 = hw.constant 510 : i10
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_48(we: %we: i1, wd: %wd: i10, de: %de: i1, d: %d: i10, q: %4: i10) -> (wr_en: i1, wr_data: i10)
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
      llhd.drv %q, %c510_i10 after %0 : i10
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
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen_40(tl_i: %32: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
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
  hw.module private @tlul_rsp_intg_gen_40(in %tl_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) {
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
    %gen_flops.u_prim_flop_2sync.q_o = hw.instance "gen_flops.u_prim_flop_2sync" @prim_flop_2sync_9(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %mubi_i: i4) -> (q_o: i4) {sv.namehint = "gen_flops.mubi_sync"}
    %gen_flops.gen_stable_chks.u_prim_flop_3rd_stage.q_o = hw.instance "gen_flops.gen_stable_chks.u_prim_flop_3rd_stage" @prim_flop(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %gen_flops.u_prim_flop_2sync.q_o: i4) -> (q_o: i4)
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
  hw.module private @prim_mubi4_sync_0(in %clk_i : i1, in %rst_ni : i1, in %mubi_i : i4, out mubi_o : !hw.array<1xi4>) {
    %c0_i0 = hw.constant 0 : i0
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %2 = hw.aggregate_constant [0 : i4] : !hw.array<1xi4>
    %c0_i4 = hw.constant 0 : i4
    %c-7_i4 = hw.constant -7 : i4
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %mubi_i_2 = llhd.sig name "mubi_i" %c0_i4 : i4
    %mubi_o = llhd.sig %2 : !hw.array<1xi4>
    %gen_no_flops.unused_logic = llhd.sig %c0_i4 : i4
    %gen_buffs_0.mubi_out = llhd.sig %c0_i4 : i4
    %5 = comb.extract %13 from 0 : (i4) -> i1
    %6 = llhd.sig.extract %gen_buffs_0.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_0.u_prim_buf" @prim_buf(in_i: %5: i1) -> (out_o: i1)
    llhd.drv %6, %gen_buffs_0.gen_bits_0.u_prim_buf.out_o after %1 : i1
    %7 = comb.extract %13 from 1 : (i4) -> i1
    %8 = llhd.sig.extract %gen_buffs_0.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_1.u_prim_buf" @prim_buf(in_i: %7: i1) -> (out_o: i1)
    llhd.drv %8, %gen_buffs_0.gen_bits_1.u_prim_buf.out_o after %1 : i1
    %9 = comb.extract %13 from 2 : (i4) -> i1
    %10 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_2.u_prim_buf" @prim_buf(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %10, %gen_buffs_0.gen_bits_2.u_prim_buf.out_o after %1 : i1
    %11 = comb.extract %13 from 3 : (i4) -> i1
    %12 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_3.u_prim_buf" @prim_buf(in_i: %11: i1) -> (out_o: i1)
    llhd.drv %12, %gen_buffs_0.gen_bits_3.u_prim_buf.out_o after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
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
      llhd.drv %gen_no_flops.unused_logic, %c-7_i4 after %0 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %28 = llhd.prb %mubi_i_2 : i4
      llhd.drv %gen_no_flops.unused_logic, %28 after %0 : i4
      cf.br ^bb1
    }
    %13 = llhd.prb %mubi_i_2 {sv.namehint = "mubi"} : i4
    %14 = llhd.sig.array_get %mubi_o[%c0_i0] : <!hw.array<1xi4>>
    %15 = llhd.prb %gen_buffs_0.mubi_out : i4
    llhd.drv %14, %15 after %1 : i4
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %mubi_i_2, %mubi_i after %1 : i4
    %16 = llhd.prb %mubi_o : !hw.array<1xi4>
    hw.output %16 : !hw.array<1xi4>
  }
  hw.module private @prim_mubi4_sync_5(in %clk_i : i1, in %rst_ni : i1, in %mubi_i : i4, out mubi_o : !hw.array<6xi4>) {
    %c-3_i3 = hw.constant -3 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c3_i3 = hw.constant 3 : i3
    %c2_i3 = hw.constant 2 : i3
    %c1_i3 = hw.constant 1 : i3
    %c0_i3 = hw.constant 0 : i3
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %c0_i4 = hw.constant 0 : i4
    %1 = hw.aggregate_constant [0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4] : !hw.array<6xi4>
    %mubi_o = llhd.sig %1 : !hw.array<6xi4>
    %gen_buffs_0.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_1.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_2.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_3.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_4.mubi_out = llhd.sig %c0_i4 : i4
    %gen_buffs_5.mubi_out = llhd.sig %c0_i4 : i4
    %gen_flops.u_prim_flop_2sync.q_o = hw.instance "gen_flops.u_prim_flop_2sync" @prim_flop_2sync_9(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %mubi_i: i4) -> (q_o: i4) {sv.namehint = "gen_flops.mubi_sync"}
    %2 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 0 : (i4) -> i1
    %3 = llhd.sig.extract %gen_buffs_0.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_0.u_prim_buf" @prim_buf(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %3, %gen_buffs_0.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %4 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 1 : (i4) -> i1
    %5 = llhd.sig.extract %gen_buffs_0.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_1.u_prim_buf" @prim_buf(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %5, %gen_buffs_0.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %6 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 2 : (i4) -> i1
    %7 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_2.u_prim_buf" @prim_buf(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %7, %gen_buffs_0.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %8 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 3 : (i4) -> i1
    %9 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_3.u_prim_buf" @prim_buf(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %9, %gen_buffs_0.gen_bits_3.u_prim_buf.out_o after %0 : i1
    %10 = llhd.sig.extract %gen_buffs_1.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_0.u_prim_buf" @prim_buf(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %10, %gen_buffs_1.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %11 = llhd.sig.extract %gen_buffs_1.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_1.u_prim_buf" @prim_buf(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %11, %gen_buffs_1.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %12 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_2.u_prim_buf" @prim_buf(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %12, %gen_buffs_1.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %13 = llhd.sig.extract %gen_buffs_1.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_3.u_prim_buf" @prim_buf(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %13, %gen_buffs_1.gen_bits_3.u_prim_buf.out_o after %0 : i1
    %14 = llhd.sig.extract %gen_buffs_2.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_0.u_prim_buf" @prim_buf(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %14, %gen_buffs_2.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %15 = llhd.sig.extract %gen_buffs_2.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_1.u_prim_buf" @prim_buf(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %15, %gen_buffs_2.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %16 = llhd.sig.extract %gen_buffs_2.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_2.u_prim_buf" @prim_buf(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %16, %gen_buffs_2.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %17 = llhd.sig.extract %gen_buffs_2.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_3.u_prim_buf" @prim_buf(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %17, %gen_buffs_2.gen_bits_3.u_prim_buf.out_o after %0 : i1
    %18 = llhd.sig.extract %gen_buffs_3.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_0.u_prim_buf" @prim_buf(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %18, %gen_buffs_3.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %19 = llhd.sig.extract %gen_buffs_3.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_1.u_prim_buf" @prim_buf(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %19, %gen_buffs_3.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %20 = llhd.sig.extract %gen_buffs_3.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_2.u_prim_buf" @prim_buf(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %20, %gen_buffs_3.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %21 = llhd.sig.extract %gen_buffs_3.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_3.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_3.gen_bits_3.u_prim_buf" @prim_buf(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %21, %gen_buffs_3.gen_bits_3.u_prim_buf.out_o after %0 : i1
    %22 = llhd.sig.extract %gen_buffs_4.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_4.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_4.gen_bits_0.u_prim_buf" @prim_buf(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %22, %gen_buffs_4.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %23 = llhd.sig.extract %gen_buffs_4.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_4.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_4.gen_bits_1.u_prim_buf" @prim_buf(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %23, %gen_buffs_4.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %24 = llhd.sig.extract %gen_buffs_4.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_4.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_4.gen_bits_2.u_prim_buf" @prim_buf(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %24, %gen_buffs_4.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %25 = llhd.sig.extract %gen_buffs_4.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_4.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_4.gen_bits_3.u_prim_buf" @prim_buf(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %25, %gen_buffs_4.gen_bits_3.u_prim_buf.out_o after %0 : i1
    %26 = llhd.sig.extract %gen_buffs_5.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_5.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_5.gen_bits_0.u_prim_buf" @prim_buf(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %26, %gen_buffs_5.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %27 = llhd.sig.extract %gen_buffs_5.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_5.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_5.gen_bits_1.u_prim_buf" @prim_buf(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %27, %gen_buffs_5.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %28 = llhd.sig.extract %gen_buffs_5.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_5.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_5.gen_bits_2.u_prim_buf" @prim_buf(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %28, %gen_buffs_5.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %29 = llhd.sig.extract %gen_buffs_5.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_5.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_5.gen_bits_3.u_prim_buf" @prim_buf(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %29, %gen_buffs_5.gen_bits_3.u_prim_buf.out_o after %0 : i1
    %30 = llhd.sig.array_get %mubi_o[%c0_i3] : <!hw.array<6xi4>>
    %31 = llhd.prb %gen_buffs_0.mubi_out : i4
    llhd.drv %30, %31 after %0 : i4
    %32 = llhd.sig.array_get %mubi_o[%c1_i3] : <!hw.array<6xi4>>
    %33 = llhd.prb %gen_buffs_1.mubi_out : i4
    llhd.drv %32, %33 after %0 : i4
    %34 = llhd.sig.array_get %mubi_o[%c2_i3] : <!hw.array<6xi4>>
    %35 = llhd.prb %gen_buffs_2.mubi_out : i4
    llhd.drv %34, %35 after %0 : i4
    %36 = llhd.sig.array_get %mubi_o[%c3_i3] : <!hw.array<6xi4>>
    %37 = llhd.prb %gen_buffs_3.mubi_out : i4
    llhd.drv %36, %37 after %0 : i4
    %38 = llhd.sig.array_get %mubi_o[%c-4_i3] : <!hw.array<6xi4>>
    %39 = llhd.prb %gen_buffs_4.mubi_out : i4
    llhd.drv %38, %39 after %0 : i4
    %40 = llhd.sig.array_get %mubi_o[%c-3_i3] : <!hw.array<6xi4>>
    %41 = llhd.prb %gen_buffs_5.mubi_out : i4
    llhd.drv %40, %41 after %0 : i4
    %42 = llhd.prb %mubi_o : !hw.array<6xi4>
    hw.output %42 : !hw.array<6xi4>
  }
  hw.module private @prim_mubi4_sync_33(in %clk_i : i1, in %rst_ni : i1, in %mubi_i : i4, out mubi_o : !hw.array<1xi4>) {
    %c0_i0 = hw.constant 0 : i0
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %c0_i4 = hw.constant 0 : i4
    %1 = hw.aggregate_constant [0 : i4] : !hw.array<1xi4>
    %mubi_o = llhd.sig %1 : !hw.array<1xi4>
    %gen_buffs_0.mubi_out = llhd.sig %c0_i4 : i4
    %gen_flops.u_prim_flop_2sync.q_o = hw.instance "gen_flops.u_prim_flop_2sync" @prim_flop_2sync_9(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %mubi_i: i4) -> (q_o: i4) {sv.namehint = "gen_flops.mubi_sync"}
    %2 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 0 : (i4) -> i1
    %3 = llhd.sig.extract %gen_buffs_0.mubi_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_0.u_prim_buf" @prim_buf(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %3, %gen_buffs_0.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %4 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 1 : (i4) -> i1
    %5 = llhd.sig.extract %gen_buffs_0.mubi_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_1.u_prim_buf" @prim_buf(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %5, %gen_buffs_0.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %6 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 2 : (i4) -> i1
    %7 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_2.u_prim_buf" @prim_buf(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %7, %gen_buffs_0.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %8 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 3 : (i4) -> i1
    %9 = llhd.sig.extract %gen_buffs_0.mubi_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_3.u_prim_buf" @prim_buf(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %9, %gen_buffs_0.gen_bits_3.u_prim_buf.out_o after %0 : i1
    %10 = llhd.sig.array_get %mubi_o[%c0_i0] : <!hw.array<1xi4>>
    %11 = llhd.prb %gen_buffs_0.mubi_out : i4
    llhd.drv %10, %11 after %0 : i4
    %12 = llhd.prb %mubi_o : !hw.array<1xi4>
    hw.output %12 : !hw.array<1xi4>
  }
  hw.module private @prim_mubi4_sender(in %clk_i : i1, in %rst_ni : i1, in %mubi_i : i4, out mubi_o : i4) {
    %gen_flops.u_prim_flop.q_o = hw.instance "gen_flops.u_prim_flop" @prim_flop_36(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %mubi_i: i4) -> (q_o: i4) {sv.namehint = "mubi_out"}
    hw.output %gen_flops.u_prim_flop.q_o : i4
  }
  hw.module private @prim_mubi4_sender_31(in %clk_i : i1, in %rst_ni : i1, in %mubi_i : i4, out mubi_o : i4) {
    %gen_flops.u_prim_flop.q_o = hw.instance "gen_flops.u_prim_flop" @prim_flop(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %mubi_i: i4) -> (q_o: i4) {sv.namehint = "mubi_int"}
    %gen_sec_buf.u_prim_sec_buf.out_o = hw.instance "gen_sec_buf.u_prim_sec_buf" @prim_sec_anchor_buf(in_i: %gen_flops.u_prim_flop.q_o: i4) -> (out_o: i4) {sv.namehint = "mubi_out"}
    hw.output %gen_sec_buf.u_prim_sec_buf.out_o : i4
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
    %gen_flops.u_prim_flop_2sync.q_o = hw.instance "gen_flops.u_prim_flop_2sync" @prim_flop_2sync_62(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %lc_en_i: i4) -> (q_o: i4) {sv.namehint = "lc_en"}
    %2 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 0 : (i4) -> i1
    %3 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf_28(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %3, %gen_buffs_0.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %4 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 1 : (i4) -> i1
    %5 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf_28(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %5, %gen_buffs_0.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %6 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 2 : (i4) -> i1
    %7 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf_28(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %7, %gen_buffs_0.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %8 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 3 : (i4) -> i1
    %9 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf_28(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %9, %gen_buffs_0.gen_bits_3.u_prim_buf.out_o after %0 : i1
    %10 = llhd.sig.array_get %lc_en_o[%c0_i0] : <!hw.array<1xi4>>
    %11 = llhd.prb %gen_buffs_0.lc_en_out : i4
    llhd.drv %10, %11 after %0 : i4
    %12 = llhd.prb %lc_en_o : !hw.array<1xi4>
    hw.output %12 : !hw.array<1xi4>
  }
  hw.module private @prim_lc_sync_29(in %clk_i : i1, in %rst_ni : i1, in %lc_en_i : i4, out lc_en_o : !hw.array<2xi4>) {
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
    %gen_flops.u_prim_flop_2sync.q_o = hw.instance "gen_flops.u_prim_flop_2sync" @prim_flop_2sync_62(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %lc_en_i: i4) -> (q_o: i4) {sv.namehint = "lc_en"}
    %2 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 0 : (i4) -> i1
    %3 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf_28(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %3, %gen_buffs_0.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %4 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 1 : (i4) -> i1
    %5 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf_28(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %5, %gen_buffs_0.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %6 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 2 : (i4) -> i1
    %7 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf_28(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %7, %gen_buffs_0.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %8 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 3 : (i4) -> i1
    %9 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf_28(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %9, %gen_buffs_0.gen_bits_3.u_prim_buf.out_o after %0 : i1
    %10 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf_28(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %10, %gen_buffs_1.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %11 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf_28(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %11, %gen_buffs_1.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %12 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf_28(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %12, %gen_buffs_1.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %13 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf_28(in_i: %8: i1) -> (out_o: i1)
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
  hw.module private @prim_lc_sender(in %clk_i : i1, in %rst_ni : i1, in %lc_en_i : i4, out lc_en_o : i4) {
    %gen_flops.u_prim_flop.q_o = hw.instance "gen_flops.u_prim_flop" @prim_sec_anchor_flop_63(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %lc_en_i: i4) -> (q_o: i4) {sv.namehint = "lc_en_out"}
    hw.output %gen_flops.u_prim_flop.q_o : i4
  }
  hw.module private @clkmgr_byp(in %clk_i : i1, in %rst_ni : i1, in %en_i : i4, in %lc_clk_byp_req_i : i4, out lc_clk_byp_ack_o : i4, in %byp_req_i : i4, out byp_ack_o : i4, in %hi_speed_sel_i : i4, out all_clk_byp_req_o : i4, in %all_clk_byp_ack_i : i4, out io_clk_byp_req_o : i4, in %io_clk_byp_ack_i : i4, out hi_speed_sel_o : i4, in %step_down_acks_i : i2) {
    %false = hw.constant false
    %true = hw.constant true
    %c-1_i2 = hw.constant -1 : i2
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = hw.aggregate_constant [0 : i4, 0 : i4] : !hw.array<2xi4>
    %c-7_i4 = hw.constant -7 : i4
    %c6_i4 = hw.constant 6 : i4
    %c-6_i4 = hw.constant -6 : i4
    %lc_clk_byp_req = llhd.sig %1 : !hw.array<2xi4>
    %u_en_sync.lc_en_o = hw.instance "u_en_sync" @prim_lc_sync(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, lc_en_i: %en_i: i4) -> (lc_en_o: !hw.array<1xi4>)
    %2 = hw.bitcast %u_en_sync.lc_en_o {sv.namehint = "en"} : (!hw.array<1xi4>) -> i4
    %u_lc_byp_req.lc_en_o = hw.instance "u_lc_byp_req" @prim_lc_sync_29(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, lc_en_i: %lc_clk_byp_req_i: i4) -> (lc_en_o: !hw.array<2xi4>)
    llhd.drv %lc_clk_byp_req, %u_lc_byp_req.lc_en_o after %0 : !hw.array<2xi4>
    %u_step_down_acks_sync.q_o = hw.instance "u_step_down_acks_sync" @prim_flop_30(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %step_down_acks_i: i2) -> (q_o: i2) {sv.namehint = "step_down_acks_sync"}
    %u_io_byp_req.mubi_o = hw.instance "u_io_byp_req" @prim_mubi4_sender_31(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, mubi_i: %14: i4) -> (mubi_o: i4)
    %3 = comb.icmp eq %u_step_down_acks_sync.q_o, %c-1_i2 : i2
    %4 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%9) : (i4) -> i1
    %5 = comb.and %3, %4 : i1
    %6 = llhd.prb %lc_clk_byp_req : !hw.array<2xi4>
    %7 = hw.array_get %6[%true] : !hw.array<2xi4>, i1
    %8 = comb.mux %5, %7, %c-6_i4 : i4
    %u_send.lc_en_o = hw.instance "u_send" @prim_lc_sender(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, lc_en_i: %8: i4) -> (lc_en_o: i4)
    %u_all_byp_req.mubi_o = hw.instance "u_all_byp_req" @prim_mubi4_sender_31(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, mubi_i: %16: i4) -> (mubi_o: i4)
    %u_io_ack_sync.mubi_o = hw.instance "u_io_ack_sync" @prim_mubi4_sync(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, mubi_i: %io_clk_byp_ack_i: i4) -> (mubi_o: !hw.array<1xi4>)
    %9 = hw.bitcast %u_io_ack_sync.mubi_o {sv.namehint = "io_clk_byp_ack"} : (!hw.array<1xi4>) -> i4
    %u_all_ack_sync.mubi_o = hw.instance "u_all_ack_sync" @prim_mubi4_sync(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, mubi_i: %all_clk_byp_ack_i: i4) -> (mubi_o: !hw.array<1xi4>)
    %10 = hw.bitcast %u_all_ack_sync.mubi_o : (!hw.array<1xi4>) -> i4
    %11 = func.call @"prim_mubi_pkg::mubi4_and_hi"(%16, %hi_speed_sel_i) : (i4, i4) -> i4
    %u_hi_speed_sel.mubi_o = hw.instance "u_hi_speed_sel" @prim_mubi4_sender(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, mubi_i: %11: i4) -> (mubi_o: i4)
    %12 = hw.array_get %6[%false] : !hw.array<2xi4>, i1
    %13 = func.call @"lc_ctrl_pkg::lc_tx_test_true_strict"(%12) : (i4) -> i1
    %14 = comb.mux %13, %c6_i4, %c-7_i4 {sv.namehint = "io_clk_byp_req_d"} : i4
    %15 = func.call @"lc_ctrl_pkg::lc_to_mubi4"(%2) {sv.namehint = "debug_en"} : (i4) -> i4
    %16 = func.call @"prim_mubi_pkg::mubi4_and_hi"(%byp_req_i, %15) {sv.namehint = "all_clk_byp_req_d"} : (i4, i4) -> i4
    hw.output %u_send.lc_en_o, %10, %u_all_byp_req.mubi_o, %u_io_byp_req.mubi_o, %u_hi_speed_sel.mubi_o : i4, i4, i4, i4, i4
  }
  hw.module private @clkmgr_clk_status(in %clk_i : i1, in %rst_ni : i1, in %ens_i : i1, out status_o : i1) {
    %c-1_i2 = hw.constant -1 : i2
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %true = hw.constant true
    %false = hw.constant false
    %c0_i2 = hw.constant 0 : i2
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %status_o = llhd.sig %false : i1
    %en_q = llhd.sig %c0_i2 : i2
    %dis_q = llhd.sig %c0_i2 : i2
    %en_d = llhd.sig %c0_i2 : i2
    %dis_d = llhd.sig %c0_i2 : i2
    %u_en_sync.q_o = hw.instance "u_en_sync" @prim_flop_2sync(clk_i: %2: i1, rst_ni: %3: i1, d_i: %ens_i: i1) -> (q_o: i1) {sv.namehint = "ens_sync"}
    %4 = llhd.prb %en_q : i2
    %5 = comb.extract %4 from 0 : (i2) -> i1
    %6 = comb.concat %5, %u_en_sync.q_o : i1, i1
    llhd.drv %en_d, %6 after %1 : i2
    %7 = llhd.prb %dis_q : i2
    %8 = comb.extract %7 from 0 : (i2) -> i1
    %9 = comb.xor %u_en_sync.q_o, %true : i1
    %10 = comb.concat %8, %9 : i1, i1
    llhd.drv %dis_d, %10 after %1 : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %12 = llhd.prb %clk_i_0 : i1
      %13 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %en_q, %c0_i2 after %0 : i2
      llhd.drv %dis_q, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %23 = llhd.prb %en_d : i2
      llhd.drv %en_q, %23 after %0 : i2
      %24 = llhd.prb %dis_d : i2
      llhd.drv %dis_q, %24 after %0 : i2
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %12 = llhd.prb %clk_i_0 : i1
      %13 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %status_o, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %23 = llhd.prb %en_q : i2
      %24 = comb.icmp eq %23, %c-1_i2 : i2
      cf.cond_br %24, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %status_o, %true after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %25 = llhd.prb %dis_q : i2
      %26 = comb.icmp eq %25, %c-1_i2 : i2
      cf.cond_br %26, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %status_o, %false after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    %11 = llhd.prb %status_o : i1
    hw.output %11 : i1
  }
  hw.module private @clkmgr_clk_status_4(in %clk_i : i1, in %rst_ni : i1, in %ens_i : i3, out status_o : i1) {
    %c-1_i2 = hw.constant -1 : i2
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c0_i3 = hw.constant 0 : i3
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c-1_i3 = hw.constant -1 : i3
    %true = hw.constant true
    %false = hw.constant false
    %c0_i2 = hw.constant 0 : i2
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %status_o = llhd.sig %false : i1
    %en_q = llhd.sig %c0_i2 : i2
    %dis_q = llhd.sig %c0_i2 : i2
    %en_d = llhd.sig %c0_i2 : i2
    %dis_d = llhd.sig %c0_i2 : i2
    %u_en_sync.q_o = hw.instance "u_en_sync" @prim_flop_2sync_32(clk_i: %2: i1, rst_ni: %3: i1, d_i: %ens_i: i3) -> (q_o: i3) {sv.namehint = "ens_sync"}
    %4 = llhd.prb %en_q : i2
    %5 = comb.extract %4 from 0 : (i2) -> i1
    %6 = comb.icmp eq %u_en_sync.q_o, %c-1_i3 : i3
    %7 = comb.concat %5, %6 : i1, i1
    llhd.drv %en_d, %7 after %1 : i2
    %8 = llhd.prb %dis_q : i2
    %9 = comb.extract %8 from 0 : (i2) -> i1
    %10 = comb.icmp eq %u_en_sync.q_o, %c0_i3 : i3
    %11 = comb.concat %9, %10 : i1, i1
    llhd.drv %dis_d, %11 after %1 : i2
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
      llhd.drv %en_q, %c0_i2 after %0 : i2
      llhd.drv %dis_q, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %24 = llhd.prb %en_d : i2
      llhd.drv %en_q, %24 after %0 : i2
      %25 = llhd.prb %dis_d : i2
      llhd.drv %dis_q, %25 after %0 : i2
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
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
      llhd.drv %status_o, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %24 = llhd.prb %en_q : i2
      %25 = comb.icmp eq %24, %c-1_i2 : i2
      cf.cond_br %25, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %status_o, %true after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %26 = llhd.prb %dis_q : i2
      %27 = comb.icmp eq %26, %c-1_i2 : i2
      cf.cond_br %27, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %status_o, %false after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    %12 = llhd.prb %status_o : i1
    hw.output %12 : i1
  }
  hw.module private @clkmgr_meas_chk(in %clk_i : i1, in %rst_ni : i1, in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_ref_i : i1, in %rst_ref_ni : i1, in %src_en_i : i1, in %src_max_cnt_i : i10, in %src_min_cnt_i : i10, in %src_cfg_meas_en_i : i4, out src_cfg_meas_en_valid_o : i1, out src_cfg_meas_en_o : i4, in %calib_rdy_i : i4, out meas_err_o : i1, out timeout_err_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %c-7_i4 = hw.constant -7 : i4
    %false = hw.constant false
    %true = hw.constant true
    %clk_src_i_0 = llhd.sig name "clk_src_i" %false : i1
    %2 = llhd.prb %clk_src_i_0 : i1
    %rst_src_ni_1 = llhd.sig name "rst_src_ni" %false : i1
    %3 = llhd.prb %rst_src_ni_1 : i1
    %src_cfg_meas_en_i_2 = llhd.sig name "src_cfg_meas_en_i" %c0_i4 : i4
    %src_cfg_meas_en_valid_o = llhd.sig %false : i1
    %src_cfg_meas_en_o = llhd.sig %c0_i4 : i4
    %src_fast_err = llhd.sig %false : i1
    %src_slow_err = llhd.sig %false : i1
    %src_calib_rdy = llhd.sig %c0_i4 : i4
    %src_err_req = llhd.sig %false : i1
    %src_err_ack = llhd.sig %false : i1
    %u_meas.valid_o, %u_meas.fast_o, %u_meas.slow_o, %u_meas.timeout_clk_ref_o, %u_meas.ref_timeout_clk_o = hw.instance "u_meas" @prim_clock_meas(clk_i: %2: i1, rst_ni: %3: i1, clk_ref_i: %clk_ref_i: i1, rst_ref_ni: %rst_ref_ni: i1, en_i: %src_en_i: i1, max_cnt: %src_max_cnt_i: i10, min_cnt: %src_min_cnt_i: i10) -> (valid_o: i1, fast_o: i1, slow_o: i1, timeout_clk_ref_o: i1, ref_timeout_clk_o: i1) {sv.namehint = "ref_timeout_err"}
    llhd.drv %src_fast_err, %u_meas.fast_o after %1 : i1
    llhd.drv %src_slow_err, %u_meas.slow_o after %1 : i1
    %u_calib_rdy_sync.mubi_o = hw.instance "u_calib_rdy_sync" @prim_mubi4_sync_33(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, mubi_i: %calib_rdy_i: i4) -> (mubi_o: !hw.array<1xi4>)
    %4 = hw.bitcast %u_calib_rdy_sync.mubi_o : (!hw.array<1xi4>) -> i4
    llhd.drv %src_calib_rdy, %4 after %1 : i4
    %5 = llhd.prb %src_err_req : i1
    %u_err_sync.src_ack_o, %u_err_sync.dst_req_o = hw.instance "u_err_sync" @prim_sync_reqack(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_i: i1, rst_dst_ni: %rst_ni: i1, req_chk_i: %true: i1, src_req_i: %5: i1, dst_ack_i: %u_err_sync.dst_req_o: i1) -> (src_ack_o: i1, dst_req_o: i1)
    llhd.drv %src_err_ack, %u_err_sync.src_ack_o after %1 : i1
    %u_timeout_err_sync.q_sync_o, %u_timeout_err_sync.q_posedge_pulse_o, %u_timeout_err_sync.q_negedge_pulse_o = hw.instance "u_timeout_err_sync" @prim_edge_detector(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_meas.ref_timeout_clk_o: i1) -> (q_sync_o: i1, q_posedge_pulse_o: i1, q_negedge_pulse_o: i1)
    %6 = llhd.prb %src_cfg_meas_en_valid_o : i1
    %7 = llhd.prb %src_cfg_meas_en_i_2 : i4
    %8 = llhd.prb %src_cfg_meas_en_o : i4
    %9 = llhd.prb %src_calib_rdy : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb3
      llhd.drv %src_cfg_meas_en_valid_o, %false after %1 : i1
      %10 = llhd.prb %src_cfg_meas_en_i_2 : i4
      llhd.drv %src_cfg_meas_en_o, %10 after %1 : i4
      %11 = llhd.prb %src_calib_rdy : i4
      %12 = func.call @"prim_mubi_pkg::mubi4_test_false_strict"(%11) : (i4) -> i1
      %13 = llhd.prb %src_cfg_meas_en_o : i4
      %14 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%13) : (i4) -> i1
      %15 = comb.and %12, %14 : i1
      cf.cond_br %15, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      llhd.drv %src_cfg_meas_en_valid_o, %true after %1 : i1
      llhd.drv %src_cfg_meas_en_o, %c-7_i4 after %1 : i4
      cf.br ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      llhd.wait (%6, %7, %8, %9 : i1, i4, i4, i4), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
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
      llhd.drv %src_err_req, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %21 = llhd.prb %src_fast_err : i1
      %22 = llhd.prb %src_slow_err : i1
      %23 = comb.or %21, %22 : i1
      cf.cond_br %23, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %src_err_req, %true after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %24 = llhd.prb %src_err_req : i1
      %25 = llhd.prb %src_err_ack : i1
      %26 = comb.and %24, %25 : i1
      cf.cond_br %26, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %src_err_req, %false after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_src_i_0, %clk_src_i after %1 : i1
    llhd.drv %rst_src_ni_1, %rst_src_ni after %1 : i1
    llhd.drv %src_cfg_meas_en_i_2, %src_cfg_meas_en_i after %1 : i4
    hw.output %6, %8, %u_err_sync.dst_req_o, %u_timeout_err_sync.q_posedge_pulse_o : i1, i4, i1, i1
  }
  hw.module private @clkmgr_meas_chk_6(in %clk_i : i1, in %rst_ni : i1, in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_ref_i : i1, in %rst_ref_ni : i1, in %src_en_i : i1, in %src_max_cnt_i : i9, in %src_min_cnt_i : i9, in %src_cfg_meas_en_i : i4, out src_cfg_meas_en_valid_o : i1, out src_cfg_meas_en_o : i4, in %calib_rdy_i : i4, out meas_err_o : i1, out timeout_err_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %c-7_i4 = hw.constant -7 : i4
    %false = hw.constant false
    %true = hw.constant true
    %clk_src_i_0 = llhd.sig name "clk_src_i" %false : i1
    %2 = llhd.prb %clk_src_i_0 : i1
    %rst_src_ni_1 = llhd.sig name "rst_src_ni" %false : i1
    %3 = llhd.prb %rst_src_ni_1 : i1
    %src_cfg_meas_en_i_2 = llhd.sig name "src_cfg_meas_en_i" %c0_i4 : i4
    %src_cfg_meas_en_valid_o = llhd.sig %false : i1
    %src_cfg_meas_en_o = llhd.sig %c0_i4 : i4
    %src_fast_err = llhd.sig %false : i1
    %src_slow_err = llhd.sig %false : i1
    %src_calib_rdy = llhd.sig %c0_i4 : i4
    %src_err_req = llhd.sig %false : i1
    %src_err_ack = llhd.sig %false : i1
    %u_meas.valid_o, %u_meas.fast_o, %u_meas.slow_o, %u_meas.timeout_clk_ref_o, %u_meas.ref_timeout_clk_o = hw.instance "u_meas" @prim_clock_meas_34(clk_i: %2: i1, rst_ni: %3: i1, clk_ref_i: %clk_ref_i: i1, rst_ref_ni: %rst_ref_ni: i1, en_i: %src_en_i: i1, max_cnt: %src_max_cnt_i: i9, min_cnt: %src_min_cnt_i: i9) -> (valid_o: i1, fast_o: i1, slow_o: i1, timeout_clk_ref_o: i1, ref_timeout_clk_o: i1) {sv.namehint = "ref_timeout_err"}
    llhd.drv %src_fast_err, %u_meas.fast_o after %1 : i1
    llhd.drv %src_slow_err, %u_meas.slow_o after %1 : i1
    %u_calib_rdy_sync.mubi_o = hw.instance "u_calib_rdy_sync" @prim_mubi4_sync_33(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, mubi_i: %calib_rdy_i: i4) -> (mubi_o: !hw.array<1xi4>)
    %4 = hw.bitcast %u_calib_rdy_sync.mubi_o : (!hw.array<1xi4>) -> i4
    llhd.drv %src_calib_rdy, %4 after %1 : i4
    %5 = llhd.prb %src_err_req : i1
    %u_err_sync.src_ack_o, %u_err_sync.dst_req_o = hw.instance "u_err_sync" @prim_sync_reqack(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_i: i1, rst_dst_ni: %rst_ni: i1, req_chk_i: %true: i1, src_req_i: %5: i1, dst_ack_i: %u_err_sync.dst_req_o: i1) -> (src_ack_o: i1, dst_req_o: i1)
    llhd.drv %src_err_ack, %u_err_sync.src_ack_o after %1 : i1
    %u_timeout_err_sync.q_sync_o, %u_timeout_err_sync.q_posedge_pulse_o, %u_timeout_err_sync.q_negedge_pulse_o = hw.instance "u_timeout_err_sync" @prim_edge_detector(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_meas.ref_timeout_clk_o: i1) -> (q_sync_o: i1, q_posedge_pulse_o: i1, q_negedge_pulse_o: i1)
    %6 = llhd.prb %src_cfg_meas_en_valid_o : i1
    %7 = llhd.prb %src_cfg_meas_en_i_2 : i4
    %8 = llhd.prb %src_cfg_meas_en_o : i4
    %9 = llhd.prb %src_calib_rdy : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb3
      llhd.drv %src_cfg_meas_en_valid_o, %false after %1 : i1
      %10 = llhd.prb %src_cfg_meas_en_i_2 : i4
      llhd.drv %src_cfg_meas_en_o, %10 after %1 : i4
      %11 = llhd.prb %src_calib_rdy : i4
      %12 = func.call @"prim_mubi_pkg::mubi4_test_false_strict"(%11) : (i4) -> i1
      %13 = llhd.prb %src_cfg_meas_en_o : i4
      %14 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%13) : (i4) -> i1
      %15 = comb.and %12, %14 : i1
      cf.cond_br %15, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      llhd.drv %src_cfg_meas_en_valid_o, %true after %1 : i1
      llhd.drv %src_cfg_meas_en_o, %c-7_i4 after %1 : i4
      cf.br ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      llhd.wait (%6, %7, %8, %9 : i1, i4, i4, i4), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
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
      llhd.drv %src_err_req, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %21 = llhd.prb %src_fast_err : i1
      %22 = llhd.prb %src_slow_err : i1
      %23 = comb.or %21, %22 : i1
      cf.cond_br %23, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %src_err_req, %true after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %24 = llhd.prb %src_err_req : i1
      %25 = llhd.prb %src_err_ack : i1
      %26 = comb.and %24, %25 : i1
      cf.cond_br %26, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %src_err_req, %false after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_src_i_0, %clk_src_i after %1 : i1
    llhd.drv %rst_src_ni_1, %rst_src_ni after %1 : i1
    llhd.drv %src_cfg_meas_en_i_2, %src_cfg_meas_en_i after %1 : i4
    hw.output %6, %8, %u_err_sync.dst_req_o, %u_timeout_err_sync.q_posedge_pulse_o : i1, i4, i1, i1
  }
  hw.module private @clkmgr_meas_chk_7(in %clk_i : i1, in %rst_ni : i1, in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_ref_i : i1, in %rst_ref_ni : i1, in %src_en_i : i1, in %src_max_cnt_i : i8, in %src_min_cnt_i : i8, in %src_cfg_meas_en_i : i4, out src_cfg_meas_en_valid_o : i1, out src_cfg_meas_en_o : i4, in %calib_rdy_i : i4, out meas_err_o : i1, out timeout_err_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %c-7_i4 = hw.constant -7 : i4
    %false = hw.constant false
    %true = hw.constant true
    %clk_src_i_0 = llhd.sig name "clk_src_i" %false : i1
    %2 = llhd.prb %clk_src_i_0 : i1
    %rst_src_ni_1 = llhd.sig name "rst_src_ni" %false : i1
    %3 = llhd.prb %rst_src_ni_1 : i1
    %src_cfg_meas_en_i_2 = llhd.sig name "src_cfg_meas_en_i" %c0_i4 : i4
    %src_cfg_meas_en_valid_o = llhd.sig %false : i1
    %src_cfg_meas_en_o = llhd.sig %c0_i4 : i4
    %src_fast_err = llhd.sig %false : i1
    %src_slow_err = llhd.sig %false : i1
    %src_calib_rdy = llhd.sig %c0_i4 : i4
    %src_err_req = llhd.sig %false : i1
    %src_err_ack = llhd.sig %false : i1
    %u_meas.valid_o, %u_meas.fast_o, %u_meas.slow_o, %u_meas.timeout_clk_ref_o, %u_meas.ref_timeout_clk_o = hw.instance "u_meas" @prim_clock_meas_35(clk_i: %2: i1, rst_ni: %3: i1, clk_ref_i: %clk_ref_i: i1, rst_ref_ni: %rst_ref_ni: i1, en_i: %src_en_i: i1, max_cnt: %src_max_cnt_i: i8, min_cnt: %src_min_cnt_i: i8) -> (valid_o: i1, fast_o: i1, slow_o: i1, timeout_clk_ref_o: i1, ref_timeout_clk_o: i1) {sv.namehint = "ref_timeout_err"}
    llhd.drv %src_fast_err, %u_meas.fast_o after %1 : i1
    llhd.drv %src_slow_err, %u_meas.slow_o after %1 : i1
    %u_calib_rdy_sync.mubi_o = hw.instance "u_calib_rdy_sync" @prim_mubi4_sync_33(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, mubi_i: %calib_rdy_i: i4) -> (mubi_o: !hw.array<1xi4>)
    %4 = hw.bitcast %u_calib_rdy_sync.mubi_o : (!hw.array<1xi4>) -> i4
    llhd.drv %src_calib_rdy, %4 after %1 : i4
    %5 = llhd.prb %src_err_req : i1
    %u_err_sync.src_ack_o, %u_err_sync.dst_req_o = hw.instance "u_err_sync" @prim_sync_reqack(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_i: i1, rst_dst_ni: %rst_ni: i1, req_chk_i: %true: i1, src_req_i: %5: i1, dst_ack_i: %u_err_sync.dst_req_o: i1) -> (src_ack_o: i1, dst_req_o: i1)
    llhd.drv %src_err_ack, %u_err_sync.src_ack_o after %1 : i1
    %u_timeout_err_sync.q_sync_o, %u_timeout_err_sync.q_posedge_pulse_o, %u_timeout_err_sync.q_negedge_pulse_o = hw.instance "u_timeout_err_sync" @prim_edge_detector(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_meas.ref_timeout_clk_o: i1) -> (q_sync_o: i1, q_posedge_pulse_o: i1, q_negedge_pulse_o: i1)
    %6 = llhd.prb %src_cfg_meas_en_valid_o : i1
    %7 = llhd.prb %src_cfg_meas_en_i_2 : i4
    %8 = llhd.prb %src_cfg_meas_en_o : i4
    %9 = llhd.prb %src_calib_rdy : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb3
      llhd.drv %src_cfg_meas_en_valid_o, %false after %1 : i1
      %10 = llhd.prb %src_cfg_meas_en_i_2 : i4
      llhd.drv %src_cfg_meas_en_o, %10 after %1 : i4
      %11 = llhd.prb %src_calib_rdy : i4
      %12 = func.call @"prim_mubi_pkg::mubi4_test_false_strict"(%11) : (i4) -> i1
      %13 = llhd.prb %src_cfg_meas_en_o : i4
      %14 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%13) : (i4) -> i1
      %15 = comb.and %12, %14 : i1
      cf.cond_br %15, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      llhd.drv %src_cfg_meas_en_valid_o, %true after %1 : i1
      llhd.drv %src_cfg_meas_en_o, %c-7_i4 after %1 : i4
      cf.br ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      llhd.wait (%6, %7, %8, %9 : i1, i4, i4, i4), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
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
      llhd.drv %src_err_req, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %21 = llhd.prb %src_fast_err : i1
      %22 = llhd.prb %src_slow_err : i1
      %23 = comb.or %21, %22 : i1
      cf.cond_br %23, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %src_err_req, %true after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %24 = llhd.prb %src_err_req : i1
      %25 = llhd.prb %src_err_ack : i1
      %26 = comb.and %24, %25 : i1
      cf.cond_br %26, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %src_err_req, %false after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_src_i_0, %clk_src_i after %1 : i1
    llhd.drv %rst_src_ni_1, %rst_src_ni after %1 : i1
    llhd.drv %src_cfg_meas_en_i_2, %src_cfg_meas_en_i after %1 : i4
    hw.output %6, %8, %u_err_sync.dst_req_o, %u_timeout_err_sync.q_posedge_pulse_o : i1, i4, i1, i1
  }
  hw.module private @clkmgr_reg_top(in %clk_i : i1, in %rst_ni : i1, in %rst_shadowed_ni : i1, in %clk_io_i : i1, in %rst_io_ni : i1, in %clk_io_div2_i : i1, in %rst_io_div2_ni : i1, in %clk_io_div4_i : i1, in %rst_io_div4_ni : i1, in %clk_main_i : i1, in %rst_main_ni : i1, in %clk_usb_i : i1, in %rst_usb_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out reg2hw : !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>, in %hw2reg : !hw.struct<extclk_status: !hw.struct<d: i4>, clk_hints_status: !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>, measure_ctrl_regwen: !hw.struct<d: i1, de: i1>, io_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div2_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div4_meas_ctrl_en: !hw.struct<d: i4, de: i1>, main_meas_ctrl_en: !hw.struct<d: i4, de: i1>, usb_meas_ctrl_en: !hw.struct<d: i4, de: i1>, recov_err_code: !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>, out shadowed_storage_err_o : i1, out shadowed_update_err_o : i1, out intg_err_o : i1) {
    %c-1_i3 = hw.constant -1 : i3
    %c0_i14 = hw.constant 0 : i14
    %c0_i12 = hw.constant 0 : i12
    %c0_i28 = hw.constant 0 : i28
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
    %c8_i5 = hw.constant 8 : i5
    %c7_i5 = hw.constant 7 : i5
    %c6_i5 = hw.constant 6 : i5
    %c5_i5 = hw.constant 5 : i5
    %c4_i5 = hw.constant 4 : i5
    %c3_i5 = hw.constant 3 : i5
    %c2_i5 = hw.constant 2 : i5
    %c1_i5 = hw.constant 1 : i5
    %c-1_i2 = hw.constant -1 : i2
    %c-8_i4 = hw.constant -8 : i4
    %c9_i5 = hw.constant 9 : i5
    %c10_i5 = hw.constant 10 : i5
    %c0_i5 = hw.constant 0 : i5
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %c0_i22 = hw.constant 0 : i22
    %2 = hw.aggregate_constant [[[false, false], [false, false]], [[0 : i4], [0 : i4]], [0 : i4], [[false], [false], [false], [false]], [[false], [false], [false], [false]], [false], [0 : i4], [[0 : i10], [0 : i10]], [0 : i4], [[0 : i9], [0 : i9]], [0 : i4], [[0 : i8], [0 : i8]], [0 : i4], [[0 : i10], [0 : i10]], [0 : i4], [[0 : i9], [0 : i9]], [[false], [false], [false]]] : !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
    %c-1_i32 = hw.constant -1 : i32
    %c0_i32 = hw.constant 0 : i32
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
    %c502270_i20 = hw.constant 502270 : i20
    %c28290_i16 = hw.constant 28290 : i16
    %c118010_i18 = hw.constant 118010 : i18
    %c481770_i20 = hw.constant 481770 : i20
    %true = hw.constant true
    %c0_i8 = hw.constant 0 : i8
    %c0_i9 = hw.constant 0 : i9
    %c0_i10 = hw.constant 0 : i10
    %c0_i4 = hw.constant 0 : i4
    %c0_i16 = hw.constant 0 : i16
    %c0_i18 = hw.constant 0 : i18
    %c0_i20 = hw.constant 0 : i20
    %false = hw.constant false
    %c-7_i4 = hw.constant -7 : i4
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %rst_shadowed_ni_2 = llhd.sig name "rst_shadowed_ni" %false : i1
    %5 = llhd.prb %rst_shadowed_ni_2 : i1
    %reg2hw = llhd.sig %2 : !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
    %reg_we = llhd.sig %false : i1
    %reg_addr = llhd.sig %c0_i7 : i7
    %reg_be = llhd.sig %c0_i4 : i4
    %wr_err = llhd.sig %false : i1
    %reg_rdata_next = llhd.sig %c0_i32 : i32
    %intg_err = llhd.sig %false : i1
    %reg_we_err = llhd.sig %false : i1
    %reg_we_check = llhd.sig %c0_i22 : i22
    %err_q = llhd.sig %false : i1
    %alert_test_we = llhd.sig %false : i1
    %extclk_ctrl_regwen_we = llhd.sig %false : i1
    %extclk_ctrl_regwen_qs = llhd.sig %false : i1
    %extclk_ctrl_sel_qs = llhd.sig %c0_i4 : i4
    %extclk_ctrl_hi_speed_sel_qs = llhd.sig %c0_i4 : i4
    %extclk_status_qs = llhd.sig %c0_i4 : i4
    %jitter_regwen_we = llhd.sig %false : i1
    %jitter_regwen_qs = llhd.sig %false : i1
    %jitter_enable_qs = llhd.sig %c0_i4 : i4
    %clk_enables_we = llhd.sig %false : i1
    %clk_enables_clk_io_div4_peri_en_qs = llhd.sig %false : i1
    %clk_enables_clk_io_div2_peri_en_qs = llhd.sig %false : i1
    %clk_enables_clk_io_peri_en_qs = llhd.sig %false : i1
    %clk_enables_clk_usb_peri_en_qs = llhd.sig %false : i1
    %clk_hints_we = llhd.sig %false : i1
    %clk_hints_clk_main_aes_hint_qs = llhd.sig %false : i1
    %clk_hints_clk_main_hmac_hint_qs = llhd.sig %false : i1
    %clk_hints_clk_main_kmac_hint_qs = llhd.sig %false : i1
    %clk_hints_clk_main_otbn_hint_qs = llhd.sig %false : i1
    %clk_hints_status_clk_main_aes_val_qs = llhd.sig %false : i1
    %clk_hints_status_clk_main_hmac_val_qs = llhd.sig %false : i1
    %clk_hints_status_clk_main_kmac_val_qs = llhd.sig %false : i1
    %clk_hints_status_clk_main_otbn_val_qs = llhd.sig %false : i1
    %measure_ctrl_regwen_we = llhd.sig %false : i1
    %measure_ctrl_regwen_qs = llhd.sig %false : i1
    %io_meas_ctrl_en_we = llhd.sig %false : i1
    %io_meas_ctrl_en_qs = llhd.sig %c0_i4 : i4
    %io_meas_ctrl_en_busy = llhd.sig %false : i1
    %io_meas_ctrl_shadowed_we = llhd.sig %false : i1
    %io_meas_ctrl_shadowed_qs = llhd.sig %c0_i20 : i20
    %io_meas_ctrl_shadowed_busy = llhd.sig %false : i1
    %io_div2_meas_ctrl_en_we = llhd.sig %false : i1
    %io_div2_meas_ctrl_en_qs = llhd.sig %c0_i4 : i4
    %io_div2_meas_ctrl_en_busy = llhd.sig %false : i1
    %io_div2_meas_ctrl_shadowed_we = llhd.sig %false : i1
    %io_div2_meas_ctrl_shadowed_qs = llhd.sig %c0_i18 : i18
    %io_div2_meas_ctrl_shadowed_busy = llhd.sig %false : i1
    %io_div4_meas_ctrl_en_we = llhd.sig %false : i1
    %io_div4_meas_ctrl_en_qs = llhd.sig %c0_i4 : i4
    %io_div4_meas_ctrl_en_busy = llhd.sig %false : i1
    %io_div4_meas_ctrl_shadowed_we = llhd.sig %false : i1
    %io_div4_meas_ctrl_shadowed_qs = llhd.sig %c0_i16 : i16
    %io_div4_meas_ctrl_shadowed_busy = llhd.sig %false : i1
    %main_meas_ctrl_en_we = llhd.sig %false : i1
    %main_meas_ctrl_en_qs = llhd.sig %c0_i4 : i4
    %main_meas_ctrl_en_busy = llhd.sig %false : i1
    %main_meas_ctrl_shadowed_we = llhd.sig %false : i1
    %main_meas_ctrl_shadowed_qs = llhd.sig %c0_i20 : i20
    %main_meas_ctrl_shadowed_busy = llhd.sig %false : i1
    %usb_meas_ctrl_en_we = llhd.sig %false : i1
    %usb_meas_ctrl_en_qs = llhd.sig %c0_i4 : i4
    %usb_meas_ctrl_en_busy = llhd.sig %false : i1
    %usb_meas_ctrl_shadowed_we = llhd.sig %false : i1
    %usb_meas_ctrl_shadowed_qs = llhd.sig %c0_i18 : i18
    %usb_meas_ctrl_shadowed_busy = llhd.sig %false : i1
    %recov_err_code_we = llhd.sig %false : i1
    %recov_err_code_shadow_update_err_qs = llhd.sig %false : i1
    %recov_err_code_io_measure_err_qs = llhd.sig %false : i1
    %recov_err_code_io_div2_measure_err_qs = llhd.sig %false : i1
    %recov_err_code_io_div4_measure_err_qs = llhd.sig %false : i1
    %recov_err_code_main_measure_err_qs = llhd.sig %false : i1
    %recov_err_code_usb_measure_err_qs = llhd.sig %false : i1
    %recov_err_code_io_timeout_err_qs = llhd.sig %false : i1
    %recov_err_code_io_div2_timeout_err_qs = llhd.sig %false : i1
    %recov_err_code_io_div4_timeout_err_qs = llhd.sig %false : i1
    %recov_err_code_main_timeout_err_qs = llhd.sig %false : i1
    %recov_err_code_usb_timeout_err_qs = llhd.sig %false : i1
    %fatal_err_code_reg_intg_qs = llhd.sig %false : i1
    %fatal_err_code_idle_cnt_qs = llhd.sig %false : i1
    %fatal_err_code_shadow_storage_err_qs = llhd.sig %false : i1
    %io_io_meas_ctrl_en_ds_int = llhd.sig %c0_i4 : i4
    %io_io_meas_ctrl_en_qs_int = llhd.sig %c0_i4 : i4
    %io_io_meas_ctrl_en_ds = llhd.sig %c0_i4 : i4
    %io_io_meas_ctrl_en_qs = llhd.sig %c0_i4 : i4
    %io_io_meas_ctrl_shadowed_hi_qs_int = llhd.sig %c0_i10 : i10
    %io_io_meas_ctrl_shadowed_lo_qs_int = llhd.sig %c0_i10 : i10
    %io_io_meas_ctrl_shadowed_qs = llhd.sig %c0_i20 : i20
    %io_div2_io_div2_meas_ctrl_en_ds_int = llhd.sig %c0_i4 : i4
    %io_div2_io_div2_meas_ctrl_en_qs_int = llhd.sig %c0_i4 : i4
    %io_div2_io_div2_meas_ctrl_en_ds = llhd.sig %c0_i4 : i4
    %io_div2_io_div2_meas_ctrl_en_qs = llhd.sig %c0_i4 : i4
    %io_div2_io_div2_meas_ctrl_shadowed_hi_qs_int = llhd.sig %c0_i9 : i9
    %io_div2_io_div2_meas_ctrl_shadowed_lo_qs_int = llhd.sig %c0_i9 : i9
    %io_div2_io_div2_meas_ctrl_shadowed_qs = llhd.sig %c0_i18 : i18
    %io_div4_io_div4_meas_ctrl_en_ds_int = llhd.sig %c0_i4 : i4
    %io_div4_io_div4_meas_ctrl_en_qs_int = llhd.sig %c0_i4 : i4
    %io_div4_io_div4_meas_ctrl_en_ds = llhd.sig %c0_i4 : i4
    %io_div4_io_div4_meas_ctrl_en_qs = llhd.sig %c0_i4 : i4
    %io_div4_io_div4_meas_ctrl_shadowed_hi_qs_int = llhd.sig %c0_i8 : i8
    %io_div4_io_div4_meas_ctrl_shadowed_lo_qs_int = llhd.sig %c0_i8 : i8
    %io_div4_io_div4_meas_ctrl_shadowed_qs = llhd.sig %c0_i16 : i16
    %main_main_meas_ctrl_en_ds_int = llhd.sig %c0_i4 : i4
    %main_main_meas_ctrl_en_qs_int = llhd.sig %c0_i4 : i4
    %main_main_meas_ctrl_en_ds = llhd.sig %c0_i4 : i4
    %main_main_meas_ctrl_en_qs = llhd.sig %c0_i4 : i4
    %main_main_meas_ctrl_shadowed_hi_qs_int = llhd.sig %c0_i10 : i10
    %main_main_meas_ctrl_shadowed_lo_qs_int = llhd.sig %c0_i10 : i10
    %main_main_meas_ctrl_shadowed_qs = llhd.sig %c0_i20 : i20
    %usb_usb_meas_ctrl_en_ds_int = llhd.sig %c0_i4 : i4
    %usb_usb_meas_ctrl_en_qs_int = llhd.sig %c0_i4 : i4
    %usb_usb_meas_ctrl_en_ds = llhd.sig %c0_i4 : i4
    %usb_usb_meas_ctrl_en_qs = llhd.sig %c0_i4 : i4
    %usb_usb_meas_ctrl_shadowed_hi_qs_int = llhd.sig %c0_i9 : i9
    %usb_usb_meas_ctrl_shadowed_lo_qs_int = llhd.sig %c0_i9 : i9
    %usb_usb_meas_ctrl_shadowed_qs = llhd.sig %c0_i18 : i18
    %alert_test_flds_we = llhd.sig %c0_i2 : i2
    %extclk_ctrl_gated_we = llhd.sig %false : i1
    %jitter_enable_gated_we = llhd.sig %false : i1
    %io_meas_ctrl_en_flds_we = llhd.sig %false : i1
    %io_div2_meas_ctrl_en_flds_we = llhd.sig %false : i1
    %io_div4_meas_ctrl_en_flds_we = llhd.sig %false : i1
    %main_meas_ctrl_en_flds_we = llhd.sig %false : i1
    %usb_meas_ctrl_en_flds_we = llhd.sig %false : i1
    %addr_hit = llhd.sig %c0_i22 : i22
    %rst_done = llhd.sig %false : i1
    %shadow_rst_done = llhd.sig %false : i1
    %reg_busy_sel = llhd.sig %false : i1
    %u_chk.err_o = hw.instance "u_chk" @tlul_cmd_intg_chk(tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> (err_o: i1)
    llhd.drv %intg_err, %u_chk.err_o after %1 : i1
    %6 = llhd.prb %reg_we_check : i22
    %7 = llhd.prb %reg_we : i1
    %8 = comb.xor %189, %true : i1
    %9 = comb.and %7, %8 : i1
    %u_prim_reg_we_check.err_o = hw.instance "u_prim_reg_we_check" @prim_reg_we_check(clk_i: %3: i1, rst_ni: %4: i1, oh_i: %6: i22, en_i: %9: i1) -> (err_o: i1)
    llhd.drv %reg_we_err, %u_prim_reg_we_check.err_o after %1 : i1
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen(tl_i: %u_reg_if.tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
    %u_reg_if.tl_o, %u_reg_if.intg_error_o, %u_reg_if.re_o, %u_reg_if.we_o, %u_reg_if.addr_o, %u_reg_if.wdata_o, %u_reg_if.be_o = hw.instance "u_reg_if" @tlul_adapter_reg(clk_i: %3: i1, rst_ni: %4: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, en_ifetch_i: %c-7_i4: i4, busy_i: %297: i1, rdata_i: %139: i32, error_i: %141: i1) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, intg_error_o: i1, re_o: i1, we_o: i1, addr_o: i7, wdata_o: i32, be_o: i4) {sv.namehint = "reg_re"}
    llhd.drv %reg_we, %u_reg_if.we_o after %1 : i1
    llhd.drv %reg_addr, %u_reg_if.addr_o after %1 : i7
    llhd.drv %reg_be, %u_reg_if.be_o after %1 : i4
    %10 = llhd.prb %measure_ctrl_regwen_qs : i1
    %11 = llhd.prb %io_meas_ctrl_en_we : i1
    %12 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "jitter_enable_wd"} : (i32) -> i4
    %13 = llhd.prb %io_io_meas_ctrl_en_ds : i4
    %14 = llhd.prb %io_io_meas_ctrl_en_qs : i4
    %u_io_meas_ctrl_en_cdc.src_busy_o, %u_io_meas_ctrl_en_cdc.src_qs_o, %u_io_meas_ctrl_en_cdc.dst_we_o, %u_io_meas_ctrl_en_cdc.dst_re_o, %u_io_meas_ctrl_en_cdc.dst_regwen_o, %u_io_meas_ctrl_en_cdc.dst_wd_o = hw.instance "u_io_meas_ctrl_en_cdc" @prim_reg_cdc(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_io_i: i1, rst_dst_ni: %rst_io_ni: i1, src_regwen_i: %10: i1, src_we_i: %11: i1, src_re_i: %false: i1, src_wd_i: %12: i4, dst_ds_i: %13: i4, dst_qs_i: %14: i4, dst_update_i: %170: i1) -> (src_busy_o: i1, src_qs_o: i4, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i4) {sv.namehint = "io_io_meas_ctrl_en_we"}
    llhd.drv %io_meas_ctrl_en_busy, %u_io_meas_ctrl_en_cdc.src_busy_o after %1 : i1
    llhd.drv %io_meas_ctrl_en_qs, %u_io_meas_ctrl_en_cdc.src_qs_o after %1 : i4
    %15 = llhd.prb %io_meas_ctrl_shadowed_we : i1
    %16 = comb.extract %u_reg_if.wdata_o from 0 : (i32) -> i20
    %17 = llhd.prb %io_io_meas_ctrl_shadowed_qs : i20
    %u_io_meas_ctrl_shadowed_cdc.src_busy_o, %u_io_meas_ctrl_shadowed_cdc.src_qs_o, %u_io_meas_ctrl_shadowed_cdc.dst_we_o, %u_io_meas_ctrl_shadowed_cdc.dst_re_o, %u_io_meas_ctrl_shadowed_cdc.dst_regwen_o, %u_io_meas_ctrl_shadowed_cdc.dst_wd_o = hw.instance "u_io_meas_ctrl_shadowed_cdc" @prim_reg_cdc_11(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_io_i: i1, rst_dst_ni: %rst_io_ni: i1, src_regwen_i: %10: i1, src_we_i: %15: i1, src_re_i: %216: i1, src_wd_i: %16: i20, dst_ds_i: %c0_i20: i20, dst_qs_i: %17: i20, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i20, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i20) {sv.namehint = "io_io_meas_ctrl_shadowed_re"}
    llhd.drv %io_meas_ctrl_shadowed_busy, %u_io_meas_ctrl_shadowed_cdc.src_busy_o after %1 : i1
    llhd.drv %io_meas_ctrl_shadowed_qs, %u_io_meas_ctrl_shadowed_cdc.src_qs_o after %1 : i20
    %18 = llhd.prb %io_div2_meas_ctrl_en_we : i1
    %19 = llhd.prb %io_div2_io_div2_meas_ctrl_en_ds : i4
    %20 = llhd.prb %io_div2_io_div2_meas_ctrl_en_qs : i4
    %u_io_div2_meas_ctrl_en_cdc.src_busy_o, %u_io_div2_meas_ctrl_en_cdc.src_qs_o, %u_io_div2_meas_ctrl_en_cdc.dst_we_o, %u_io_div2_meas_ctrl_en_cdc.dst_re_o, %u_io_div2_meas_ctrl_en_cdc.dst_regwen_o, %u_io_div2_meas_ctrl_en_cdc.dst_wd_o = hw.instance "u_io_div2_meas_ctrl_en_cdc" @prim_reg_cdc(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_io_div2_i: i1, rst_dst_ni: %rst_io_div2_ni: i1, src_regwen_i: %10: i1, src_we_i: %18: i1, src_re_i: %false: i1, src_wd_i: %12: i4, dst_ds_i: %19: i4, dst_qs_i: %20: i4, dst_update_i: %173: i1) -> (src_busy_o: i1, src_qs_o: i4, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i4) {sv.namehint = "io_div2_io_div2_meas_ctrl_en_we"}
    llhd.drv %io_div2_meas_ctrl_en_busy, %u_io_div2_meas_ctrl_en_cdc.src_busy_o after %1 : i1
    llhd.drv %io_div2_meas_ctrl_en_qs, %u_io_div2_meas_ctrl_en_cdc.src_qs_o after %1 : i4
    %21 = llhd.prb %io_div2_meas_ctrl_shadowed_we : i1
    %22 = comb.extract %u_reg_if.wdata_o from 0 : (i32) -> i18
    %23 = llhd.prb %io_div2_io_div2_meas_ctrl_shadowed_qs : i18
    %u_io_div2_meas_ctrl_shadowed_cdc.src_busy_o, %u_io_div2_meas_ctrl_shadowed_cdc.src_qs_o, %u_io_div2_meas_ctrl_shadowed_cdc.dst_we_o, %u_io_div2_meas_ctrl_shadowed_cdc.dst_re_o, %u_io_div2_meas_ctrl_shadowed_cdc.dst_regwen_o, %u_io_div2_meas_ctrl_shadowed_cdc.dst_wd_o = hw.instance "u_io_div2_meas_ctrl_shadowed_cdc" @prim_reg_cdc_12(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_io_div2_i: i1, rst_dst_ni: %rst_io_div2_ni: i1, src_regwen_i: %10: i1, src_we_i: %21: i1, src_re_i: %221: i1, src_wd_i: %22: i18, dst_ds_i: %c0_i18: i18, dst_qs_i: %23: i18, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i18, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i18) {sv.namehint = "io_div2_io_div2_meas_ctrl_shadowed_re"}
    llhd.drv %io_div2_meas_ctrl_shadowed_busy, %u_io_div2_meas_ctrl_shadowed_cdc.src_busy_o after %1 : i1
    llhd.drv %io_div2_meas_ctrl_shadowed_qs, %u_io_div2_meas_ctrl_shadowed_cdc.src_qs_o after %1 : i18
    %24 = llhd.prb %io_div4_meas_ctrl_en_we : i1
    %25 = llhd.prb %io_div4_io_div4_meas_ctrl_en_ds : i4
    %26 = llhd.prb %io_div4_io_div4_meas_ctrl_en_qs : i4
    %u_io_div4_meas_ctrl_en_cdc.src_busy_o, %u_io_div4_meas_ctrl_en_cdc.src_qs_o, %u_io_div4_meas_ctrl_en_cdc.dst_we_o, %u_io_div4_meas_ctrl_en_cdc.dst_re_o, %u_io_div4_meas_ctrl_en_cdc.dst_regwen_o, %u_io_div4_meas_ctrl_en_cdc.dst_wd_o = hw.instance "u_io_div4_meas_ctrl_en_cdc" @prim_reg_cdc(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_io_div4_i: i1, rst_dst_ni: %rst_io_div4_ni: i1, src_regwen_i: %10: i1, src_we_i: %24: i1, src_re_i: %false: i1, src_wd_i: %12: i4, dst_ds_i: %25: i4, dst_qs_i: %26: i4, dst_update_i: %176: i1) -> (src_busy_o: i1, src_qs_o: i4, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i4) {sv.namehint = "io_div4_io_div4_meas_ctrl_en_we"}
    llhd.drv %io_div4_meas_ctrl_en_busy, %u_io_div4_meas_ctrl_en_cdc.src_busy_o after %1 : i1
    llhd.drv %io_div4_meas_ctrl_en_qs, %u_io_div4_meas_ctrl_en_cdc.src_qs_o after %1 : i4
    %27 = llhd.prb %io_div4_meas_ctrl_shadowed_we : i1
    %28 = comb.extract %u_reg_if.wdata_o from 0 : (i32) -> i16
    %29 = llhd.prb %io_div4_io_div4_meas_ctrl_shadowed_qs : i16
    %u_io_div4_meas_ctrl_shadowed_cdc.src_busy_o, %u_io_div4_meas_ctrl_shadowed_cdc.src_qs_o, %u_io_div4_meas_ctrl_shadowed_cdc.dst_we_o, %u_io_div4_meas_ctrl_shadowed_cdc.dst_re_o, %u_io_div4_meas_ctrl_shadowed_cdc.dst_regwen_o, %u_io_div4_meas_ctrl_shadowed_cdc.dst_wd_o = hw.instance "u_io_div4_meas_ctrl_shadowed_cdc" @prim_reg_cdc_13(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_io_div4_i: i1, rst_dst_ni: %rst_io_div4_ni: i1, src_regwen_i: %10: i1, src_we_i: %27: i1, src_re_i: %226: i1, src_wd_i: %28: i16, dst_ds_i: %c0_i16: i16, dst_qs_i: %29: i16, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i16, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i16) {sv.namehint = "io_div4_io_div4_meas_ctrl_shadowed_re"}
    llhd.drv %io_div4_meas_ctrl_shadowed_busy, %u_io_div4_meas_ctrl_shadowed_cdc.src_busy_o after %1 : i1
    llhd.drv %io_div4_meas_ctrl_shadowed_qs, %u_io_div4_meas_ctrl_shadowed_cdc.src_qs_o after %1 : i16
    %30 = llhd.prb %main_meas_ctrl_en_we : i1
    %31 = llhd.prb %main_main_meas_ctrl_en_ds : i4
    %32 = llhd.prb %main_main_meas_ctrl_en_qs : i4
    %u_main_meas_ctrl_en_cdc.src_busy_o, %u_main_meas_ctrl_en_cdc.src_qs_o, %u_main_meas_ctrl_en_cdc.dst_we_o, %u_main_meas_ctrl_en_cdc.dst_re_o, %u_main_meas_ctrl_en_cdc.dst_regwen_o, %u_main_meas_ctrl_en_cdc.dst_wd_o = hw.instance "u_main_meas_ctrl_en_cdc" @prim_reg_cdc(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_main_i: i1, rst_dst_ni: %rst_main_ni: i1, src_regwen_i: %10: i1, src_we_i: %30: i1, src_re_i: %false: i1, src_wd_i: %12: i4, dst_ds_i: %31: i4, dst_qs_i: %32: i4, dst_update_i: %179: i1) -> (src_busy_o: i1, src_qs_o: i4, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i4) {sv.namehint = "main_main_meas_ctrl_en_we"}
    llhd.drv %main_meas_ctrl_en_busy, %u_main_meas_ctrl_en_cdc.src_busy_o after %1 : i1
    llhd.drv %main_meas_ctrl_en_qs, %u_main_meas_ctrl_en_cdc.src_qs_o after %1 : i4
    %33 = llhd.prb %main_meas_ctrl_shadowed_we : i1
    %34 = llhd.prb %main_main_meas_ctrl_shadowed_qs : i20
    %u_main_meas_ctrl_shadowed_cdc.src_busy_o, %u_main_meas_ctrl_shadowed_cdc.src_qs_o, %u_main_meas_ctrl_shadowed_cdc.dst_we_o, %u_main_meas_ctrl_shadowed_cdc.dst_re_o, %u_main_meas_ctrl_shadowed_cdc.dst_regwen_o, %u_main_meas_ctrl_shadowed_cdc.dst_wd_o = hw.instance "u_main_meas_ctrl_shadowed_cdc" @prim_reg_cdc_14(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_main_i: i1, rst_dst_ni: %rst_main_ni: i1, src_regwen_i: %10: i1, src_we_i: %33: i1, src_re_i: %231: i1, src_wd_i: %16: i20, dst_ds_i: %c0_i20: i20, dst_qs_i: %34: i20, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i20, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i20) {sv.namehint = "main_main_meas_ctrl_shadowed_re"}
    llhd.drv %main_meas_ctrl_shadowed_busy, %u_main_meas_ctrl_shadowed_cdc.src_busy_o after %1 : i1
    llhd.drv %main_meas_ctrl_shadowed_qs, %u_main_meas_ctrl_shadowed_cdc.src_qs_o after %1 : i20
    %35 = llhd.prb %usb_meas_ctrl_en_we : i1
    %36 = llhd.prb %usb_usb_meas_ctrl_en_ds : i4
    %37 = llhd.prb %usb_usb_meas_ctrl_en_qs : i4
    %u_usb_meas_ctrl_en_cdc.src_busy_o, %u_usb_meas_ctrl_en_cdc.src_qs_o, %u_usb_meas_ctrl_en_cdc.dst_we_o, %u_usb_meas_ctrl_en_cdc.dst_re_o, %u_usb_meas_ctrl_en_cdc.dst_regwen_o, %u_usb_meas_ctrl_en_cdc.dst_wd_o = hw.instance "u_usb_meas_ctrl_en_cdc" @prim_reg_cdc(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_usb_i: i1, rst_dst_ni: %rst_usb_ni: i1, src_regwen_i: %10: i1, src_we_i: %35: i1, src_re_i: %false: i1, src_wd_i: %12: i4, dst_ds_i: %36: i4, dst_qs_i: %37: i4, dst_update_i: %182: i1) -> (src_busy_o: i1, src_qs_o: i4, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i4) {sv.namehint = "usb_usb_meas_ctrl_en_we"}
    llhd.drv %usb_meas_ctrl_en_busy, %u_usb_meas_ctrl_en_cdc.src_busy_o after %1 : i1
    llhd.drv %usb_meas_ctrl_en_qs, %u_usb_meas_ctrl_en_cdc.src_qs_o after %1 : i4
    %38 = llhd.prb %usb_meas_ctrl_shadowed_we : i1
    %39 = llhd.prb %usb_usb_meas_ctrl_shadowed_qs : i18
    %u_usb_meas_ctrl_shadowed_cdc.src_busy_o, %u_usb_meas_ctrl_shadowed_cdc.src_qs_o, %u_usb_meas_ctrl_shadowed_cdc.dst_we_o, %u_usb_meas_ctrl_shadowed_cdc.dst_re_o, %u_usb_meas_ctrl_shadowed_cdc.dst_regwen_o, %u_usb_meas_ctrl_shadowed_cdc.dst_wd_o = hw.instance "u_usb_meas_ctrl_shadowed_cdc" @prim_reg_cdc_12(clk_src_i: %3: i1, rst_src_ni: %4: i1, clk_dst_i: %clk_usb_i: i1, rst_dst_ni: %rst_usb_ni: i1, src_regwen_i: %10: i1, src_we_i: %38: i1, src_re_i: %236: i1, src_wd_i: %22: i18, dst_ds_i: %c0_i18: i18, dst_qs_i: %39: i18, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i18, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i18) {sv.namehint = "usb_usb_meas_ctrl_shadowed_re"}
    llhd.drv %usb_meas_ctrl_shadowed_busy, %u_usb_meas_ctrl_shadowed_cdc.src_busy_o after %1 : i1
    llhd.drv %usb_meas_ctrl_shadowed_qs, %u_usb_meas_ctrl_shadowed_cdc.src_qs_o after %1 : i18
    %40 = llhd.prb %alert_test_we : i1
    %41 = llhd.sig.extract %alert_test_flds_we from %false : <i2> -> <i1>
    %42 = llhd.sig.struct_extract %reg2hw["alert_test"] : <!hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>>
    %43 = llhd.sig.struct_extract %42["recov_fault"] : <!hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>>
    %44 = llhd.sig.struct_extract %43["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_alert_test_recov_fault.qe, %u_alert_test_recov_fault.qre, %u_alert_test_recov_fault.q, %u_alert_test_recov_fault.ds, %u_alert_test_recov_fault.qs = hw.instance "u_alert_test_recov_fault" @prim_subreg_ext(re: %false: i1, we: %40: i1, wd: %194: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %41, %u_alert_test_recov_fault.qe after %1 : i1
    llhd.drv %44, %u_alert_test_recov_fault.q after %1 : i1
    %45 = llhd.sig.extract %alert_test_flds_we from %true : <i2> -> <i1>
    %46 = llhd.sig.struct_extract %42["fatal_fault"] : <!hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>>
    %47 = llhd.sig.struct_extract %46["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_alert_test_fatal_fault.qe, %u_alert_test_fatal_fault.qre, %u_alert_test_fatal_fault.q, %u_alert_test_fatal_fault.ds, %u_alert_test_fatal_fault.qs = hw.instance "u_alert_test_fatal_fault" @prim_subreg_ext(re: %false: i1, we: %40: i1, wd: %195: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %45, %u_alert_test_fatal_fault.qe after %1 : i1
    llhd.drv %47, %u_alert_test_fatal_fault.q after %1 : i1
    %48 = llhd.prb %extclk_ctrl_regwen_we : i1
    %u_extclk_ctrl_regwen.qe, %u_extclk_ctrl_regwen.q, %u_extclk_ctrl_regwen.ds, %u_extclk_ctrl_regwen.qs = hw.instance "u_extclk_ctrl_regwen" @prim_subreg(clk_i: %3: i1, rst_ni: %4: i1, we: %48: i1, wd: %194: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %extclk_ctrl_regwen_qs, %u_extclk_ctrl_regwen.qs after %1 : i1
    %49 = llhd.prb %extclk_ctrl_gated_we : i1
    %50 = llhd.sig.struct_extract %reg2hw["extclk_ctrl"] : <!hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>>
    %51 = llhd.sig.struct_extract %50["sel"] : <!hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>>
    %52 = llhd.sig.struct_extract %51["q"] : <!hw.struct<q: i4>>
    %u_extclk_ctrl_sel.qe, %u_extclk_ctrl_sel.q, %u_extclk_ctrl_sel.ds, %u_extclk_ctrl_sel.qs = hw.instance "u_extclk_ctrl_sel" @prim_subreg_15(clk_i: %3: i1, rst_ni: %4: i1, we: %49: i1, wd: %12: i4, de: %false: i1, d: %c0_i4: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %52, %u_extclk_ctrl_sel.q after %1 : i4
    llhd.drv %extclk_ctrl_sel_qs, %u_extclk_ctrl_sel.qs after %1 : i4
    %53 = llhd.sig.struct_extract %50["hi_speed_sel"] : <!hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>>
    %54 = llhd.sig.struct_extract %53["q"] : <!hw.struct<q: i4>>
    %u_extclk_ctrl_hi_speed_sel.qe, %u_extclk_ctrl_hi_speed_sel.q, %u_extclk_ctrl_hi_speed_sel.ds, %u_extclk_ctrl_hi_speed_sel.qs = hw.instance "u_extclk_ctrl_hi_speed_sel" @prim_subreg_15(clk_i: %3: i1, rst_ni: %4: i1, we: %49: i1, wd: %199: i4, de: %false: i1, d: %c0_i4: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %54, %u_extclk_ctrl_hi_speed_sel.q after %1 : i4
    llhd.drv %extclk_ctrl_hi_speed_sel_qs, %u_extclk_ctrl_hi_speed_sel.qs after %1 : i4
    %extclk_status = hw.struct_extract %hw2reg["extclk_status"] : !hw.struct<extclk_status: !hw.struct<d: i4>, clk_hints_status: !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>, measure_ctrl_regwen: !hw.struct<d: i1, de: i1>, io_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div2_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div4_meas_ctrl_en: !hw.struct<d: i4, de: i1>, main_meas_ctrl_en: !hw.struct<d: i4, de: i1>, usb_meas_ctrl_en: !hw.struct<d: i4, de: i1>, recov_err_code: !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>
    %d = hw.struct_extract %extclk_status["d"] : !hw.struct<d: i4>
    %u_extclk_status.qe, %u_extclk_status.qre, %u_extclk_status.q, %u_extclk_status.ds, %u_extclk_status.qs = hw.instance "u_extclk_status" @prim_subreg_ext_16(re: %201: i1, we: %false: i1, wd: %c0_i4: i4, d: %d: i4) -> (qe: i1, qre: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %extclk_status_qs, %u_extclk_status.qs after %1 : i4
    %55 = llhd.prb %jitter_regwen_we : i1
    %u_jitter_regwen.qe, %u_jitter_regwen.q, %u_jitter_regwen.ds, %u_jitter_regwen.qs = hw.instance "u_jitter_regwen" @prim_subreg(clk_i: %3: i1, rst_ni: %4: i1, we: %55: i1, wd: %194: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %jitter_regwen_qs, %u_jitter_regwen.qs after %1 : i1
    %56 = llhd.prb %jitter_enable_gated_we : i1
    %57 = llhd.sig.struct_extract %reg2hw["jitter_enable"] : <!hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>>
    %58 = llhd.sig.struct_extract %57["q"] : <!hw.struct<q: i4>>
    %u_jitter_enable.qe, %u_jitter_enable.q, %u_jitter_enable.ds, %u_jitter_enable.qs = hw.instance "u_jitter_enable" @prim_subreg_15(clk_i: %3: i1, rst_ni: %4: i1, we: %56: i1, wd: %12: i4, de: %false: i1, d: %c0_i4: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %58, %u_jitter_enable.q after %1 : i4
    llhd.drv %jitter_enable_qs, %u_jitter_enable.qs after %1 : i4
    %59 = llhd.prb %clk_enables_we : i1
    %60 = llhd.sig.struct_extract %reg2hw["clk_enables"] : <!hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>>
    %61 = llhd.sig.struct_extract %60["clk_io_div4_peri_en"] : <!hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>>
    %62 = llhd.sig.struct_extract %61["q"] : <!hw.struct<q: i1>>
    %u_clk_enables_clk_io_div4_peri_en.qe, %u_clk_enables_clk_io_div4_peri_en.q, %u_clk_enables_clk_io_div4_peri_en.ds, %u_clk_enables_clk_io_div4_peri_en.qs = hw.instance "u_clk_enables_clk_io_div4_peri_en" @prim_subreg_17(clk_i: %3: i1, rst_ni: %4: i1, we: %59: i1, wd: %194: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %62, %u_clk_enables_clk_io_div4_peri_en.q after %1 : i1
    llhd.drv %clk_enables_clk_io_div4_peri_en_qs, %u_clk_enables_clk_io_div4_peri_en.qs after %1 : i1
    %63 = llhd.sig.struct_extract %60["clk_io_div2_peri_en"] : <!hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>>
    %64 = llhd.sig.struct_extract %63["q"] : <!hw.struct<q: i1>>
    %u_clk_enables_clk_io_div2_peri_en.qe, %u_clk_enables_clk_io_div2_peri_en.q, %u_clk_enables_clk_io_div2_peri_en.ds, %u_clk_enables_clk_io_div2_peri_en.qs = hw.instance "u_clk_enables_clk_io_div2_peri_en" @prim_subreg_17(clk_i: %3: i1, rst_ni: %4: i1, we: %59: i1, wd: %195: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %64, %u_clk_enables_clk_io_div2_peri_en.q after %1 : i1
    llhd.drv %clk_enables_clk_io_div2_peri_en_qs, %u_clk_enables_clk_io_div2_peri_en.qs after %1 : i1
    %65 = llhd.sig.struct_extract %60["clk_io_peri_en"] : <!hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>>
    %66 = llhd.sig.struct_extract %65["q"] : <!hw.struct<q: i1>>
    %u_clk_enables_clk_io_peri_en.qe, %u_clk_enables_clk_io_peri_en.q, %u_clk_enables_clk_io_peri_en.ds, %u_clk_enables_clk_io_peri_en.qs = hw.instance "u_clk_enables_clk_io_peri_en" @prim_subreg_17(clk_i: %3: i1, rst_ni: %4: i1, we: %59: i1, wd: %207: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %66, %u_clk_enables_clk_io_peri_en.q after %1 : i1
    llhd.drv %clk_enables_clk_io_peri_en_qs, %u_clk_enables_clk_io_peri_en.qs after %1 : i1
    %67 = llhd.sig.struct_extract %60["clk_usb_peri_en"] : <!hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>>
    %68 = llhd.sig.struct_extract %67["q"] : <!hw.struct<q: i1>>
    %u_clk_enables_clk_usb_peri_en.qe, %u_clk_enables_clk_usb_peri_en.q, %u_clk_enables_clk_usb_peri_en.ds, %u_clk_enables_clk_usb_peri_en.qs = hw.instance "u_clk_enables_clk_usb_peri_en" @prim_subreg_17(clk_i: %3: i1, rst_ni: %4: i1, we: %59: i1, wd: %208: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %68, %u_clk_enables_clk_usb_peri_en.q after %1 : i1
    llhd.drv %clk_enables_clk_usb_peri_en_qs, %u_clk_enables_clk_usb_peri_en.qs after %1 : i1
    %69 = llhd.prb %clk_hints_we : i1
    %70 = llhd.sig.struct_extract %reg2hw["clk_hints"] : <!hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>>
    %71 = llhd.sig.struct_extract %70["clk_main_aes_hint"] : <!hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>>
    %72 = llhd.sig.struct_extract %71["q"] : <!hw.struct<q: i1>>
    %u_clk_hints_clk_main_aes_hint.qe, %u_clk_hints_clk_main_aes_hint.q, %u_clk_hints_clk_main_aes_hint.ds, %u_clk_hints_clk_main_aes_hint.qs = hw.instance "u_clk_hints_clk_main_aes_hint" @prim_subreg_17(clk_i: %3: i1, rst_ni: %4: i1, we: %69: i1, wd: %194: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %72, %u_clk_hints_clk_main_aes_hint.q after %1 : i1
    llhd.drv %clk_hints_clk_main_aes_hint_qs, %u_clk_hints_clk_main_aes_hint.qs after %1 : i1
    %73 = llhd.sig.struct_extract %70["clk_main_hmac_hint"] : <!hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>>
    %74 = llhd.sig.struct_extract %73["q"] : <!hw.struct<q: i1>>
    %u_clk_hints_clk_main_hmac_hint.qe, %u_clk_hints_clk_main_hmac_hint.q, %u_clk_hints_clk_main_hmac_hint.ds, %u_clk_hints_clk_main_hmac_hint.qs = hw.instance "u_clk_hints_clk_main_hmac_hint" @prim_subreg_17(clk_i: %3: i1, rst_ni: %4: i1, we: %69: i1, wd: %195: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %74, %u_clk_hints_clk_main_hmac_hint.q after %1 : i1
    llhd.drv %clk_hints_clk_main_hmac_hint_qs, %u_clk_hints_clk_main_hmac_hint.qs after %1 : i1
    %75 = llhd.sig.struct_extract %70["clk_main_kmac_hint"] : <!hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>>
    %76 = llhd.sig.struct_extract %75["q"] : <!hw.struct<q: i1>>
    %u_clk_hints_clk_main_kmac_hint.qe, %u_clk_hints_clk_main_kmac_hint.q, %u_clk_hints_clk_main_kmac_hint.ds, %u_clk_hints_clk_main_kmac_hint.qs = hw.instance "u_clk_hints_clk_main_kmac_hint" @prim_subreg_17(clk_i: %3: i1, rst_ni: %4: i1, we: %69: i1, wd: %207: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %76, %u_clk_hints_clk_main_kmac_hint.q after %1 : i1
    llhd.drv %clk_hints_clk_main_kmac_hint_qs, %u_clk_hints_clk_main_kmac_hint.qs after %1 : i1
    %77 = llhd.sig.struct_extract %70["clk_main_otbn_hint"] : <!hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>>
    %78 = llhd.sig.struct_extract %77["q"] : <!hw.struct<q: i1>>
    %u_clk_hints_clk_main_otbn_hint.qe, %u_clk_hints_clk_main_otbn_hint.q, %u_clk_hints_clk_main_otbn_hint.ds, %u_clk_hints_clk_main_otbn_hint.qs = hw.instance "u_clk_hints_clk_main_otbn_hint" @prim_subreg_17(clk_i: %3: i1, rst_ni: %4: i1, we: %69: i1, wd: %208: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %78, %u_clk_hints_clk_main_otbn_hint.q after %1 : i1
    llhd.drv %clk_hints_clk_main_otbn_hint_qs, %u_clk_hints_clk_main_otbn_hint.qs after %1 : i1
    %clk_hints_status = hw.struct_extract %hw2reg["clk_hints_status"] : !hw.struct<extclk_status: !hw.struct<d: i4>, clk_hints_status: !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>, measure_ctrl_regwen: !hw.struct<d: i1, de: i1>, io_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div2_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div4_meas_ctrl_en: !hw.struct<d: i4, de: i1>, main_meas_ctrl_en: !hw.struct<d: i4, de: i1>, usb_meas_ctrl_en: !hw.struct<d: i4, de: i1>, recov_err_code: !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>
    %clk_main_aes_val = hw.struct_extract %clk_hints_status["clk_main_aes_val"] : !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>
    %de = hw.struct_extract %clk_main_aes_val["de"] : !hw.struct<d: i1, de: i1>
    %d_3 = hw.struct_extract %clk_main_aes_val["d"] : !hw.struct<d: i1, de: i1>
    %u_clk_hints_status_clk_main_aes_val.qe, %u_clk_hints_status_clk_main_aes_val.q, %u_clk_hints_status_clk_main_aes_val.ds, %u_clk_hints_status_clk_main_aes_val.qs = hw.instance "u_clk_hints_status_clk_main_aes_val" @prim_subreg_18(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de: i1, d: %d_3: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %clk_hints_status_clk_main_aes_val_qs, %u_clk_hints_status_clk_main_aes_val.qs after %1 : i1
    %clk_main_hmac_val = hw.struct_extract %clk_hints_status["clk_main_hmac_val"] : !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>
    %de_4 = hw.struct_extract %clk_main_hmac_val["de"] : !hw.struct<d: i1, de: i1>
    %d_5 = hw.struct_extract %clk_main_hmac_val["d"] : !hw.struct<d: i1, de: i1>
    %u_clk_hints_status_clk_main_hmac_val.qe, %u_clk_hints_status_clk_main_hmac_val.q, %u_clk_hints_status_clk_main_hmac_val.ds, %u_clk_hints_status_clk_main_hmac_val.qs = hw.instance "u_clk_hints_status_clk_main_hmac_val" @prim_subreg_18(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_4: i1, d: %d_5: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %clk_hints_status_clk_main_hmac_val_qs, %u_clk_hints_status_clk_main_hmac_val.qs after %1 : i1
    %clk_main_kmac_val = hw.struct_extract %clk_hints_status["clk_main_kmac_val"] : !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>
    %de_6 = hw.struct_extract %clk_main_kmac_val["de"] : !hw.struct<d: i1, de: i1>
    %d_7 = hw.struct_extract %clk_main_kmac_val["d"] : !hw.struct<d: i1, de: i1>
    %u_clk_hints_status_clk_main_kmac_val.qe, %u_clk_hints_status_clk_main_kmac_val.q, %u_clk_hints_status_clk_main_kmac_val.ds, %u_clk_hints_status_clk_main_kmac_val.qs = hw.instance "u_clk_hints_status_clk_main_kmac_val" @prim_subreg_18(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_6: i1, d: %d_7: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %clk_hints_status_clk_main_kmac_val_qs, %u_clk_hints_status_clk_main_kmac_val.qs after %1 : i1
    %clk_main_otbn_val = hw.struct_extract %clk_hints_status["clk_main_otbn_val"] : !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>
    %de_8 = hw.struct_extract %clk_main_otbn_val["de"] : !hw.struct<d: i1, de: i1>
    %d_9 = hw.struct_extract %clk_main_otbn_val["d"] : !hw.struct<d: i1, de: i1>
    %u_clk_hints_status_clk_main_otbn_val.qe, %u_clk_hints_status_clk_main_otbn_val.q, %u_clk_hints_status_clk_main_otbn_val.ds, %u_clk_hints_status_clk_main_otbn_val.qs = hw.instance "u_clk_hints_status_clk_main_otbn_val" @prim_subreg_18(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_8: i1, d: %d_9: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %clk_hints_status_clk_main_otbn_val_qs, %u_clk_hints_status_clk_main_otbn_val.qs after %1 : i1
    %79 = llhd.prb %measure_ctrl_regwen_we : i1
    %measure_ctrl_regwen = hw.struct_extract %hw2reg["measure_ctrl_regwen"] : !hw.struct<extclk_status: !hw.struct<d: i4>, clk_hints_status: !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>, measure_ctrl_regwen: !hw.struct<d: i1, de: i1>, io_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div2_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div4_meas_ctrl_en: !hw.struct<d: i4, de: i1>, main_meas_ctrl_en: !hw.struct<d: i4, de: i1>, usb_meas_ctrl_en: !hw.struct<d: i4, de: i1>, recov_err_code: !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>
    %de_10 = hw.struct_extract %measure_ctrl_regwen["de"] : !hw.struct<d: i1, de: i1>
    %d_11 = hw.struct_extract %measure_ctrl_regwen["d"] : !hw.struct<d: i1, de: i1>
    %80 = llhd.sig.struct_extract %reg2hw["measure_ctrl_regwen"] : <!hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>>
    %81 = llhd.sig.struct_extract %80["q"] : <!hw.struct<q: i1>>
    %u_measure_ctrl_regwen.qe, %u_measure_ctrl_regwen.q, %u_measure_ctrl_regwen.ds, %u_measure_ctrl_regwen.qs = hw.instance "u_measure_ctrl_regwen" @prim_subreg(clk_i: %3: i1, rst_ni: %4: i1, we: %79: i1, wd: %194: i1, de: %de_10: i1, d: %d_11: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %81, %u_measure_ctrl_regwen.q after %1 : i1
    llhd.drv %measure_ctrl_regwen_qs, %u_measure_ctrl_regwen.qs after %1 : i1
    %io_meas_ctrl_en = hw.struct_extract %hw2reg["io_meas_ctrl_en"] : !hw.struct<extclk_status: !hw.struct<d: i4>, clk_hints_status: !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>, measure_ctrl_regwen: !hw.struct<d: i1, de: i1>, io_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div2_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div4_meas_ctrl_en: !hw.struct<d: i4, de: i1>, main_meas_ctrl_en: !hw.struct<d: i4, de: i1>, usb_meas_ctrl_en: !hw.struct<d: i4, de: i1>, recov_err_code: !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>
    %de_12 = hw.struct_extract %io_meas_ctrl_en["de"] : !hw.struct<d: i4, de: i1>
    %d_13 = hw.struct_extract %io_meas_ctrl_en["d"] : !hw.struct<d: i4, de: i1>
    %82 = llhd.sig.struct_extract %reg2hw["io_meas_ctrl_en"] : <!hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>>
    %83 = llhd.sig.struct_extract %82["q"] : <!hw.struct<q: i4>>
    %u_io_meas_ctrl_en.qe, %u_io_meas_ctrl_en.q, %u_io_meas_ctrl_en.ds, %u_io_meas_ctrl_en.qs = hw.instance "u_io_meas_ctrl_en" @prim_subreg_15(clk_i: %clk_io_i: i1, rst_ni: %rst_io_ni: i1, we: %171: i1, wd: %u_io_meas_ctrl_en_cdc.dst_wd_o: i4, de: %de_12: i1, d: %d_13: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %io_meas_ctrl_en_flds_we, %u_io_meas_ctrl_en.qe after %1 : i1
    llhd.drv %83, %u_io_meas_ctrl_en.q after %1 : i4
    llhd.drv %io_io_meas_ctrl_en_ds_int, %u_io_meas_ctrl_en.ds after %1 : i4
    llhd.drv %io_io_meas_ctrl_en_qs_int, %u_io_meas_ctrl_en.qs after %1 : i4
    %u_io_meas_ctrl_shadowed_hi_err_storage_sync.q_o = hw.instance "u_io_meas_ctrl_shadowed_hi_err_storage_sync" @prim_flop_2sync(clk_i: %3: i1, rst_ni: %4: i1, d_i: %u_io_meas_ctrl_shadowed_hi.err_storage: i1) -> (q_o: i1) {sv.namehint = "io_meas_ctrl_shadowed_hi_storage_err"}
    %u_io_meas_ctrl_shadowed_hi_err_update_sync.dst_pulse_o = hw.instance "u_io_meas_ctrl_shadowed_hi_err_update_sync" @prim_pulse_sync(clk_src_i: %clk_io_i: i1, rst_src_ni: %rst_io_ni: i1, src_pulse_i: %u_io_meas_ctrl_shadowed_hi.err_update: i1, clk_dst_i: %3: i1, rst_dst_ni: %4: i1) -> (dst_pulse_o: i1) {sv.namehint = "io_meas_ctrl_shadowed_hi_update_err"}
    %84 = comb.extract %u_io_meas_ctrl_shadowed_cdc.dst_wd_o from 0 : (i20) -> i10
    %85 = llhd.sig.struct_extract %reg2hw["io_meas_ctrl_shadowed"] : <!hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>>
    %86 = llhd.sig.struct_extract %85["hi"] : <!hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>>
    %87 = llhd.sig.struct_extract %86["q"] : <!hw.struct<q: i10>>
    %u_io_meas_ctrl_shadowed_hi.qe, %u_io_meas_ctrl_shadowed_hi.q, %u_io_meas_ctrl_shadowed_hi.ds, %u_io_meas_ctrl_shadowed_hi.qs, %u_io_meas_ctrl_shadowed_hi.phase, %u_io_meas_ctrl_shadowed_hi.err_update, %u_io_meas_ctrl_shadowed_hi.err_storage = hw.instance "u_io_meas_ctrl_shadowed_hi" @prim_subreg_shadow(clk_i: %clk_io_i: i1, rst_ni: %rst_io_ni: i1, rst_shadowed_ni: %5: i1, re: %u_io_meas_ctrl_shadowed_cdc.dst_re_o: i1, we: %172: i1, wd: %84: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10, phase: i1, err_update: i1, err_storage: i1) {sv.namehint = "async_io_meas_ctrl_shadowed_hi_err_update"}
    llhd.drv %87, %u_io_meas_ctrl_shadowed_hi.q after %1 : i10
    llhd.drv %io_io_meas_ctrl_shadowed_hi_qs_int, %u_io_meas_ctrl_shadowed_hi.qs after %1 : i10
    %u_io_meas_ctrl_shadowed_lo_err_storage_sync.q_o = hw.instance "u_io_meas_ctrl_shadowed_lo_err_storage_sync" @prim_flop_2sync(clk_i: %3: i1, rst_ni: %4: i1, d_i: %u_io_meas_ctrl_shadowed_lo.err_storage: i1) -> (q_o: i1) {sv.namehint = "io_meas_ctrl_shadowed_lo_storage_err"}
    %u_io_meas_ctrl_shadowed_lo_err_update_sync.dst_pulse_o = hw.instance "u_io_meas_ctrl_shadowed_lo_err_update_sync" @prim_pulse_sync(clk_src_i: %clk_io_i: i1, rst_src_ni: %rst_io_ni: i1, src_pulse_i: %u_io_meas_ctrl_shadowed_lo.err_update: i1, clk_dst_i: %3: i1, rst_dst_ni: %4: i1) -> (dst_pulse_o: i1) {sv.namehint = "io_meas_ctrl_shadowed_lo_update_err"}
    %88 = comb.extract %u_io_meas_ctrl_shadowed_cdc.dst_wd_o from 10 : (i20) -> i10
    %89 = llhd.sig.struct_extract %85["lo"] : <!hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>>
    %90 = llhd.sig.struct_extract %89["q"] : <!hw.struct<q: i10>>
    %u_io_meas_ctrl_shadowed_lo.qe, %u_io_meas_ctrl_shadowed_lo.q, %u_io_meas_ctrl_shadowed_lo.ds, %u_io_meas_ctrl_shadowed_lo.qs, %u_io_meas_ctrl_shadowed_lo.phase, %u_io_meas_ctrl_shadowed_lo.err_update, %u_io_meas_ctrl_shadowed_lo.err_storage = hw.instance "u_io_meas_ctrl_shadowed_lo" @prim_subreg_shadow_19(clk_i: %clk_io_i: i1, rst_ni: %rst_io_ni: i1, rst_shadowed_ni: %5: i1, re: %u_io_meas_ctrl_shadowed_cdc.dst_re_o: i1, we: %172: i1, wd: %88: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10, phase: i1, err_update: i1, err_storage: i1) {sv.namehint = "async_io_meas_ctrl_shadowed_lo_err_update"}
    llhd.drv %90, %u_io_meas_ctrl_shadowed_lo.q after %1 : i10
    llhd.drv %io_io_meas_ctrl_shadowed_lo_qs_int, %u_io_meas_ctrl_shadowed_lo.qs after %1 : i10
    %io_div2_meas_ctrl_en = hw.struct_extract %hw2reg["io_div2_meas_ctrl_en"] : !hw.struct<extclk_status: !hw.struct<d: i4>, clk_hints_status: !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>, measure_ctrl_regwen: !hw.struct<d: i1, de: i1>, io_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div2_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div4_meas_ctrl_en: !hw.struct<d: i4, de: i1>, main_meas_ctrl_en: !hw.struct<d: i4, de: i1>, usb_meas_ctrl_en: !hw.struct<d: i4, de: i1>, recov_err_code: !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>
    %de_14 = hw.struct_extract %io_div2_meas_ctrl_en["de"] : !hw.struct<d: i4, de: i1>
    %d_15 = hw.struct_extract %io_div2_meas_ctrl_en["d"] : !hw.struct<d: i4, de: i1>
    %91 = llhd.sig.struct_extract %reg2hw["io_div2_meas_ctrl_en"] : <!hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>>
    %92 = llhd.sig.struct_extract %91["q"] : <!hw.struct<q: i4>>
    %u_io_div2_meas_ctrl_en.qe, %u_io_div2_meas_ctrl_en.q, %u_io_div2_meas_ctrl_en.ds, %u_io_div2_meas_ctrl_en.qs = hw.instance "u_io_div2_meas_ctrl_en" @prim_subreg_15(clk_i: %clk_io_div2_i: i1, rst_ni: %rst_io_div2_ni: i1, we: %174: i1, wd: %u_io_div2_meas_ctrl_en_cdc.dst_wd_o: i4, de: %de_14: i1, d: %d_15: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %io_div2_meas_ctrl_en_flds_we, %u_io_div2_meas_ctrl_en.qe after %1 : i1
    llhd.drv %92, %u_io_div2_meas_ctrl_en.q after %1 : i4
    llhd.drv %io_div2_io_div2_meas_ctrl_en_ds_int, %u_io_div2_meas_ctrl_en.ds after %1 : i4
    llhd.drv %io_div2_io_div2_meas_ctrl_en_qs_int, %u_io_div2_meas_ctrl_en.qs after %1 : i4
    %u_io_div2_meas_ctrl_shadowed_hi_err_storage_sync.q_o = hw.instance "u_io_div2_meas_ctrl_shadowed_hi_err_storage_sync" @prim_flop_2sync(clk_i: %3: i1, rst_ni: %4: i1, d_i: %u_io_div2_meas_ctrl_shadowed_hi.err_storage: i1) -> (q_o: i1) {sv.namehint = "io_div2_meas_ctrl_shadowed_hi_storage_err"}
    %u_io_div2_meas_ctrl_shadowed_hi_err_update_sync.dst_pulse_o = hw.instance "u_io_div2_meas_ctrl_shadowed_hi_err_update_sync" @prim_pulse_sync(clk_src_i: %clk_io_div2_i: i1, rst_src_ni: %rst_io_div2_ni: i1, src_pulse_i: %u_io_div2_meas_ctrl_shadowed_hi.err_update: i1, clk_dst_i: %3: i1, rst_dst_ni: %4: i1) -> (dst_pulse_o: i1) {sv.namehint = "io_div2_meas_ctrl_shadowed_hi_update_err"}
    %93 = comb.extract %u_io_div2_meas_ctrl_shadowed_cdc.dst_wd_o from 0 : (i18) -> i9
    %94 = llhd.sig.struct_extract %reg2hw["io_div2_meas_ctrl_shadowed"] : <!hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>>
    %95 = llhd.sig.struct_extract %94["hi"] : <!hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>>
    %96 = llhd.sig.struct_extract %95["q"] : <!hw.struct<q: i9>>
    %u_io_div2_meas_ctrl_shadowed_hi.qe, %u_io_div2_meas_ctrl_shadowed_hi.q, %u_io_div2_meas_ctrl_shadowed_hi.ds, %u_io_div2_meas_ctrl_shadowed_hi.qs, %u_io_div2_meas_ctrl_shadowed_hi.phase, %u_io_div2_meas_ctrl_shadowed_hi.err_update, %u_io_div2_meas_ctrl_shadowed_hi.err_storage = hw.instance "u_io_div2_meas_ctrl_shadowed_hi" @prim_subreg_shadow_20(clk_i: %clk_io_div2_i: i1, rst_ni: %rst_io_div2_ni: i1, rst_shadowed_ni: %5: i1, re: %u_io_div2_meas_ctrl_shadowed_cdc.dst_re_o: i1, we: %175: i1, wd: %93: i9, de: %false: i1, d: %c0_i9: i9) -> (qe: i1, q: i9, ds: i9, qs: i9, phase: i1, err_update: i1, err_storage: i1) {sv.namehint = "async_io_div2_meas_ctrl_shadowed_hi_err_update"}
    llhd.drv %96, %u_io_div2_meas_ctrl_shadowed_hi.q after %1 : i9
    llhd.drv %io_div2_io_div2_meas_ctrl_shadowed_hi_qs_int, %u_io_div2_meas_ctrl_shadowed_hi.qs after %1 : i9
    %u_io_div2_meas_ctrl_shadowed_lo_err_storage_sync.q_o = hw.instance "u_io_div2_meas_ctrl_shadowed_lo_err_storage_sync" @prim_flop_2sync(clk_i: %3: i1, rst_ni: %4: i1, d_i: %u_io_div2_meas_ctrl_shadowed_lo.err_storage: i1) -> (q_o: i1) {sv.namehint = "io_div2_meas_ctrl_shadowed_lo_storage_err"}
    %u_io_div2_meas_ctrl_shadowed_lo_err_update_sync.dst_pulse_o = hw.instance "u_io_div2_meas_ctrl_shadowed_lo_err_update_sync" @prim_pulse_sync(clk_src_i: %clk_io_div2_i: i1, rst_src_ni: %rst_io_div2_ni: i1, src_pulse_i: %u_io_div2_meas_ctrl_shadowed_lo.err_update: i1, clk_dst_i: %3: i1, rst_dst_ni: %4: i1) -> (dst_pulse_o: i1) {sv.namehint = "io_div2_meas_ctrl_shadowed_lo_update_err"}
    %97 = comb.extract %u_io_div2_meas_ctrl_shadowed_cdc.dst_wd_o from 9 : (i18) -> i9
    %98 = llhd.sig.struct_extract %94["lo"] : <!hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>>
    %99 = llhd.sig.struct_extract %98["q"] : <!hw.struct<q: i9>>
    %u_io_div2_meas_ctrl_shadowed_lo.qe, %u_io_div2_meas_ctrl_shadowed_lo.q, %u_io_div2_meas_ctrl_shadowed_lo.ds, %u_io_div2_meas_ctrl_shadowed_lo.qs, %u_io_div2_meas_ctrl_shadowed_lo.phase, %u_io_div2_meas_ctrl_shadowed_lo.err_update, %u_io_div2_meas_ctrl_shadowed_lo.err_storage = hw.instance "u_io_div2_meas_ctrl_shadowed_lo" @prim_subreg_shadow_21(clk_i: %clk_io_div2_i: i1, rst_ni: %rst_io_div2_ni: i1, rst_shadowed_ni: %5: i1, re: %u_io_div2_meas_ctrl_shadowed_cdc.dst_re_o: i1, we: %175: i1, wd: %97: i9, de: %false: i1, d: %c0_i9: i9) -> (qe: i1, q: i9, ds: i9, qs: i9, phase: i1, err_update: i1, err_storage: i1) {sv.namehint = "async_io_div2_meas_ctrl_shadowed_lo_err_update"}
    llhd.drv %99, %u_io_div2_meas_ctrl_shadowed_lo.q after %1 : i9
    llhd.drv %io_div2_io_div2_meas_ctrl_shadowed_lo_qs_int, %u_io_div2_meas_ctrl_shadowed_lo.qs after %1 : i9
    %io_div4_meas_ctrl_en = hw.struct_extract %hw2reg["io_div4_meas_ctrl_en"] : !hw.struct<extclk_status: !hw.struct<d: i4>, clk_hints_status: !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>, measure_ctrl_regwen: !hw.struct<d: i1, de: i1>, io_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div2_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div4_meas_ctrl_en: !hw.struct<d: i4, de: i1>, main_meas_ctrl_en: !hw.struct<d: i4, de: i1>, usb_meas_ctrl_en: !hw.struct<d: i4, de: i1>, recov_err_code: !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>
    %de_16 = hw.struct_extract %io_div4_meas_ctrl_en["de"] : !hw.struct<d: i4, de: i1>
    %d_17 = hw.struct_extract %io_div4_meas_ctrl_en["d"] : !hw.struct<d: i4, de: i1>
    %100 = llhd.sig.struct_extract %reg2hw["io_div4_meas_ctrl_en"] : <!hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>>
    %101 = llhd.sig.struct_extract %100["q"] : <!hw.struct<q: i4>>
    %u_io_div4_meas_ctrl_en.qe, %u_io_div4_meas_ctrl_en.q, %u_io_div4_meas_ctrl_en.ds, %u_io_div4_meas_ctrl_en.qs = hw.instance "u_io_div4_meas_ctrl_en" @prim_subreg_15(clk_i: %clk_io_div4_i: i1, rst_ni: %rst_io_div4_ni: i1, we: %177: i1, wd: %u_io_div4_meas_ctrl_en_cdc.dst_wd_o: i4, de: %de_16: i1, d: %d_17: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %io_div4_meas_ctrl_en_flds_we, %u_io_div4_meas_ctrl_en.qe after %1 : i1
    llhd.drv %101, %u_io_div4_meas_ctrl_en.q after %1 : i4
    llhd.drv %io_div4_io_div4_meas_ctrl_en_ds_int, %u_io_div4_meas_ctrl_en.ds after %1 : i4
    llhd.drv %io_div4_io_div4_meas_ctrl_en_qs_int, %u_io_div4_meas_ctrl_en.qs after %1 : i4
    %u_io_div4_meas_ctrl_shadowed_hi_err_storage_sync.q_o = hw.instance "u_io_div4_meas_ctrl_shadowed_hi_err_storage_sync" @prim_flop_2sync(clk_i: %3: i1, rst_ni: %4: i1, d_i: %u_io_div4_meas_ctrl_shadowed_hi.err_storage: i1) -> (q_o: i1) {sv.namehint = "io_div4_meas_ctrl_shadowed_hi_storage_err"}
    %u_io_div4_meas_ctrl_shadowed_hi_err_update_sync.dst_pulse_o = hw.instance "u_io_div4_meas_ctrl_shadowed_hi_err_update_sync" @prim_pulse_sync(clk_src_i: %clk_io_div4_i: i1, rst_src_ni: %rst_io_div4_ni: i1, src_pulse_i: %u_io_div4_meas_ctrl_shadowed_hi.err_update: i1, clk_dst_i: %3: i1, rst_dst_ni: %4: i1) -> (dst_pulse_o: i1) {sv.namehint = "io_div4_meas_ctrl_shadowed_hi_update_err"}
    %102 = comb.extract %u_io_div4_meas_ctrl_shadowed_cdc.dst_wd_o from 0 : (i16) -> i8
    %103 = llhd.sig.struct_extract %reg2hw["io_div4_meas_ctrl_shadowed"] : <!hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>>
    %104 = llhd.sig.struct_extract %103["hi"] : <!hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>>
    %105 = llhd.sig.struct_extract %104["q"] : <!hw.struct<q: i8>>
    %u_io_div4_meas_ctrl_shadowed_hi.qe, %u_io_div4_meas_ctrl_shadowed_hi.q, %u_io_div4_meas_ctrl_shadowed_hi.ds, %u_io_div4_meas_ctrl_shadowed_hi.qs, %u_io_div4_meas_ctrl_shadowed_hi.phase, %u_io_div4_meas_ctrl_shadowed_hi.err_update, %u_io_div4_meas_ctrl_shadowed_hi.err_storage = hw.instance "u_io_div4_meas_ctrl_shadowed_hi" @prim_subreg_shadow_22(clk_i: %clk_io_div4_i: i1, rst_ni: %rst_io_div4_ni: i1, rst_shadowed_ni: %5: i1, re: %u_io_div4_meas_ctrl_shadowed_cdc.dst_re_o: i1, we: %178: i1, wd: %102: i8, de: %false: i1, d: %c0_i8: i8) -> (qe: i1, q: i8, ds: i8, qs: i8, phase: i1, err_update: i1, err_storage: i1) {sv.namehint = "async_io_div4_meas_ctrl_shadowed_hi_err_update"}
    llhd.drv %105, %u_io_div4_meas_ctrl_shadowed_hi.q after %1 : i8
    llhd.drv %io_div4_io_div4_meas_ctrl_shadowed_hi_qs_int, %u_io_div4_meas_ctrl_shadowed_hi.qs after %1 : i8
    %u_io_div4_meas_ctrl_shadowed_lo_err_storage_sync.q_o = hw.instance "u_io_div4_meas_ctrl_shadowed_lo_err_storage_sync" @prim_flop_2sync(clk_i: %3: i1, rst_ni: %4: i1, d_i: %u_io_div4_meas_ctrl_shadowed_lo.err_storage: i1) -> (q_o: i1) {sv.namehint = "io_div4_meas_ctrl_shadowed_lo_storage_err"}
    %u_io_div4_meas_ctrl_shadowed_lo_err_update_sync.dst_pulse_o = hw.instance "u_io_div4_meas_ctrl_shadowed_lo_err_update_sync" @prim_pulse_sync(clk_src_i: %clk_io_div4_i: i1, rst_src_ni: %rst_io_div4_ni: i1, src_pulse_i: %u_io_div4_meas_ctrl_shadowed_lo.err_update: i1, clk_dst_i: %3: i1, rst_dst_ni: %4: i1) -> (dst_pulse_o: i1) {sv.namehint = "io_div4_meas_ctrl_shadowed_lo_update_err"}
    %106 = comb.extract %u_io_div4_meas_ctrl_shadowed_cdc.dst_wd_o from 8 : (i16) -> i8
    %107 = llhd.sig.struct_extract %103["lo"] : <!hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>>
    %108 = llhd.sig.struct_extract %107["q"] : <!hw.struct<q: i8>>
    %u_io_div4_meas_ctrl_shadowed_lo.qe, %u_io_div4_meas_ctrl_shadowed_lo.q, %u_io_div4_meas_ctrl_shadowed_lo.ds, %u_io_div4_meas_ctrl_shadowed_lo.qs, %u_io_div4_meas_ctrl_shadowed_lo.phase, %u_io_div4_meas_ctrl_shadowed_lo.err_update, %u_io_div4_meas_ctrl_shadowed_lo.err_storage = hw.instance "u_io_div4_meas_ctrl_shadowed_lo" @prim_subreg_shadow_23(clk_i: %clk_io_div4_i: i1, rst_ni: %rst_io_div4_ni: i1, rst_shadowed_ni: %5: i1, re: %u_io_div4_meas_ctrl_shadowed_cdc.dst_re_o: i1, we: %178: i1, wd: %106: i8, de: %false: i1, d: %c0_i8: i8) -> (qe: i1, q: i8, ds: i8, qs: i8, phase: i1, err_update: i1, err_storage: i1) {sv.namehint = "async_io_div4_meas_ctrl_shadowed_lo_err_update"}
    llhd.drv %108, %u_io_div4_meas_ctrl_shadowed_lo.q after %1 : i8
    llhd.drv %io_div4_io_div4_meas_ctrl_shadowed_lo_qs_int, %u_io_div4_meas_ctrl_shadowed_lo.qs after %1 : i8
    %main_meas_ctrl_en = hw.struct_extract %hw2reg["main_meas_ctrl_en"] : !hw.struct<extclk_status: !hw.struct<d: i4>, clk_hints_status: !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>, measure_ctrl_regwen: !hw.struct<d: i1, de: i1>, io_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div2_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div4_meas_ctrl_en: !hw.struct<d: i4, de: i1>, main_meas_ctrl_en: !hw.struct<d: i4, de: i1>, usb_meas_ctrl_en: !hw.struct<d: i4, de: i1>, recov_err_code: !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>
    %de_18 = hw.struct_extract %main_meas_ctrl_en["de"] : !hw.struct<d: i4, de: i1>
    %d_19 = hw.struct_extract %main_meas_ctrl_en["d"] : !hw.struct<d: i4, de: i1>
    %109 = llhd.sig.struct_extract %reg2hw["main_meas_ctrl_en"] : <!hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>>
    %110 = llhd.sig.struct_extract %109["q"] : <!hw.struct<q: i4>>
    %u_main_meas_ctrl_en.qe, %u_main_meas_ctrl_en.q, %u_main_meas_ctrl_en.ds, %u_main_meas_ctrl_en.qs = hw.instance "u_main_meas_ctrl_en" @prim_subreg_15(clk_i: %clk_main_i: i1, rst_ni: %rst_main_ni: i1, we: %180: i1, wd: %u_main_meas_ctrl_en_cdc.dst_wd_o: i4, de: %de_18: i1, d: %d_19: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %main_meas_ctrl_en_flds_we, %u_main_meas_ctrl_en.qe after %1 : i1
    llhd.drv %110, %u_main_meas_ctrl_en.q after %1 : i4
    llhd.drv %main_main_meas_ctrl_en_ds_int, %u_main_meas_ctrl_en.ds after %1 : i4
    llhd.drv %main_main_meas_ctrl_en_qs_int, %u_main_meas_ctrl_en.qs after %1 : i4
    %u_main_meas_ctrl_shadowed_hi_err_storage_sync.q_o = hw.instance "u_main_meas_ctrl_shadowed_hi_err_storage_sync" @prim_flop_2sync(clk_i: %3: i1, rst_ni: %4: i1, d_i: %u_main_meas_ctrl_shadowed_hi.err_storage: i1) -> (q_o: i1) {sv.namehint = "main_meas_ctrl_shadowed_hi_storage_err"}
    %u_main_meas_ctrl_shadowed_hi_err_update_sync.dst_pulse_o = hw.instance "u_main_meas_ctrl_shadowed_hi_err_update_sync" @prim_pulse_sync(clk_src_i: %clk_main_i: i1, rst_src_ni: %rst_main_ni: i1, src_pulse_i: %u_main_meas_ctrl_shadowed_hi.err_update: i1, clk_dst_i: %3: i1, rst_dst_ni: %4: i1) -> (dst_pulse_o: i1) {sv.namehint = "main_meas_ctrl_shadowed_hi_update_err"}
    %111 = comb.extract %u_main_meas_ctrl_shadowed_cdc.dst_wd_o from 0 : (i20) -> i10
    %112 = llhd.sig.struct_extract %reg2hw["main_meas_ctrl_shadowed"] : <!hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>>
    %113 = llhd.sig.struct_extract %112["hi"] : <!hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>>
    %114 = llhd.sig.struct_extract %113["q"] : <!hw.struct<q: i10>>
    %u_main_meas_ctrl_shadowed_hi.qe, %u_main_meas_ctrl_shadowed_hi.q, %u_main_meas_ctrl_shadowed_hi.ds, %u_main_meas_ctrl_shadowed_hi.qs, %u_main_meas_ctrl_shadowed_hi.phase, %u_main_meas_ctrl_shadowed_hi.err_update, %u_main_meas_ctrl_shadowed_hi.err_storage = hw.instance "u_main_meas_ctrl_shadowed_hi" @prim_subreg_shadow_24(clk_i: %clk_main_i: i1, rst_ni: %rst_main_ni: i1, rst_shadowed_ni: %5: i1, re: %u_main_meas_ctrl_shadowed_cdc.dst_re_o: i1, we: %181: i1, wd: %111: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10, phase: i1, err_update: i1, err_storage: i1) {sv.namehint = "async_main_meas_ctrl_shadowed_hi_err_update"}
    llhd.drv %114, %u_main_meas_ctrl_shadowed_hi.q after %1 : i10
    llhd.drv %main_main_meas_ctrl_shadowed_hi_qs_int, %u_main_meas_ctrl_shadowed_hi.qs after %1 : i10
    %u_main_meas_ctrl_shadowed_lo_err_storage_sync.q_o = hw.instance "u_main_meas_ctrl_shadowed_lo_err_storage_sync" @prim_flop_2sync(clk_i: %3: i1, rst_ni: %4: i1, d_i: %u_main_meas_ctrl_shadowed_lo.err_storage: i1) -> (q_o: i1) {sv.namehint = "main_meas_ctrl_shadowed_lo_storage_err"}
    %u_main_meas_ctrl_shadowed_lo_err_update_sync.dst_pulse_o = hw.instance "u_main_meas_ctrl_shadowed_lo_err_update_sync" @prim_pulse_sync(clk_src_i: %clk_main_i: i1, rst_src_ni: %rst_main_ni: i1, src_pulse_i: %u_main_meas_ctrl_shadowed_lo.err_update: i1, clk_dst_i: %3: i1, rst_dst_ni: %4: i1) -> (dst_pulse_o: i1) {sv.namehint = "main_meas_ctrl_shadowed_lo_update_err"}
    %115 = comb.extract %u_main_meas_ctrl_shadowed_cdc.dst_wd_o from 10 : (i20) -> i10
    %116 = llhd.sig.struct_extract %112["lo"] : <!hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>>
    %117 = llhd.sig.struct_extract %116["q"] : <!hw.struct<q: i10>>
    %u_main_meas_ctrl_shadowed_lo.qe, %u_main_meas_ctrl_shadowed_lo.q, %u_main_meas_ctrl_shadowed_lo.ds, %u_main_meas_ctrl_shadowed_lo.qs, %u_main_meas_ctrl_shadowed_lo.phase, %u_main_meas_ctrl_shadowed_lo.err_update, %u_main_meas_ctrl_shadowed_lo.err_storage = hw.instance "u_main_meas_ctrl_shadowed_lo" @prim_subreg_shadow(clk_i: %clk_main_i: i1, rst_ni: %rst_main_ni: i1, rst_shadowed_ni: %5: i1, re: %u_main_meas_ctrl_shadowed_cdc.dst_re_o: i1, we: %181: i1, wd: %115: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10, phase: i1, err_update: i1, err_storage: i1) {sv.namehint = "async_main_meas_ctrl_shadowed_lo_err_update"}
    llhd.drv %117, %u_main_meas_ctrl_shadowed_lo.q after %1 : i10
    llhd.drv %main_main_meas_ctrl_shadowed_lo_qs_int, %u_main_meas_ctrl_shadowed_lo.qs after %1 : i10
    %usb_meas_ctrl_en = hw.struct_extract %hw2reg["usb_meas_ctrl_en"] : !hw.struct<extclk_status: !hw.struct<d: i4>, clk_hints_status: !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>, measure_ctrl_regwen: !hw.struct<d: i1, de: i1>, io_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div2_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div4_meas_ctrl_en: !hw.struct<d: i4, de: i1>, main_meas_ctrl_en: !hw.struct<d: i4, de: i1>, usb_meas_ctrl_en: !hw.struct<d: i4, de: i1>, recov_err_code: !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>
    %de_20 = hw.struct_extract %usb_meas_ctrl_en["de"] : !hw.struct<d: i4, de: i1>
    %d_21 = hw.struct_extract %usb_meas_ctrl_en["d"] : !hw.struct<d: i4, de: i1>
    %118 = llhd.sig.struct_extract %reg2hw["usb_meas_ctrl_en"] : <!hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>>
    %119 = llhd.sig.struct_extract %118["q"] : <!hw.struct<q: i4>>
    %u_usb_meas_ctrl_en.qe, %u_usb_meas_ctrl_en.q, %u_usb_meas_ctrl_en.ds, %u_usb_meas_ctrl_en.qs = hw.instance "u_usb_meas_ctrl_en" @prim_subreg_15(clk_i: %clk_usb_i: i1, rst_ni: %rst_usb_ni: i1, we: %183: i1, wd: %u_usb_meas_ctrl_en_cdc.dst_wd_o: i4, de: %de_20: i1, d: %d_21: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %usb_meas_ctrl_en_flds_we, %u_usb_meas_ctrl_en.qe after %1 : i1
    llhd.drv %119, %u_usb_meas_ctrl_en.q after %1 : i4
    llhd.drv %usb_usb_meas_ctrl_en_ds_int, %u_usb_meas_ctrl_en.ds after %1 : i4
    llhd.drv %usb_usb_meas_ctrl_en_qs_int, %u_usb_meas_ctrl_en.qs after %1 : i4
    %u_usb_meas_ctrl_shadowed_hi_err_storage_sync.q_o = hw.instance "u_usb_meas_ctrl_shadowed_hi_err_storage_sync" @prim_flop_2sync(clk_i: %3: i1, rst_ni: %4: i1, d_i: %u_usb_meas_ctrl_shadowed_hi.err_storage: i1) -> (q_o: i1) {sv.namehint = "usb_meas_ctrl_shadowed_hi_storage_err"}
    %u_usb_meas_ctrl_shadowed_hi_err_update_sync.dst_pulse_o = hw.instance "u_usb_meas_ctrl_shadowed_hi_err_update_sync" @prim_pulse_sync(clk_src_i: %clk_usb_i: i1, rst_src_ni: %rst_usb_ni: i1, src_pulse_i: %u_usb_meas_ctrl_shadowed_hi.err_update: i1, clk_dst_i: %3: i1, rst_dst_ni: %4: i1) -> (dst_pulse_o: i1) {sv.namehint = "usb_meas_ctrl_shadowed_hi_update_err"}
    %120 = comb.extract %u_usb_meas_ctrl_shadowed_cdc.dst_wd_o from 0 : (i18) -> i9
    %121 = llhd.sig.struct_extract %reg2hw["usb_meas_ctrl_shadowed"] : <!hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>>
    %122 = llhd.sig.struct_extract %121["hi"] : <!hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>>
    %123 = llhd.sig.struct_extract %122["q"] : <!hw.struct<q: i9>>
    %u_usb_meas_ctrl_shadowed_hi.qe, %u_usb_meas_ctrl_shadowed_hi.q, %u_usb_meas_ctrl_shadowed_hi.ds, %u_usb_meas_ctrl_shadowed_hi.qs, %u_usb_meas_ctrl_shadowed_hi.phase, %u_usb_meas_ctrl_shadowed_hi.err_update, %u_usb_meas_ctrl_shadowed_hi.err_storage = hw.instance "u_usb_meas_ctrl_shadowed_hi" @prim_subreg_shadow_20(clk_i: %clk_usb_i: i1, rst_ni: %rst_usb_ni: i1, rst_shadowed_ni: %5: i1, re: %u_usb_meas_ctrl_shadowed_cdc.dst_re_o: i1, we: %184: i1, wd: %120: i9, de: %false: i1, d: %c0_i9: i9) -> (qe: i1, q: i9, ds: i9, qs: i9, phase: i1, err_update: i1, err_storage: i1) {sv.namehint = "async_usb_meas_ctrl_shadowed_hi_err_update"}
    llhd.drv %123, %u_usb_meas_ctrl_shadowed_hi.q after %1 : i9
    llhd.drv %usb_usb_meas_ctrl_shadowed_hi_qs_int, %u_usb_meas_ctrl_shadowed_hi.qs after %1 : i9
    %u_usb_meas_ctrl_shadowed_lo_err_storage_sync.q_o = hw.instance "u_usb_meas_ctrl_shadowed_lo_err_storage_sync" @prim_flop_2sync(clk_i: %3: i1, rst_ni: %4: i1, d_i: %u_usb_meas_ctrl_shadowed_lo.err_storage: i1) -> (q_o: i1) {sv.namehint = "usb_meas_ctrl_shadowed_lo_storage_err"}
    %u_usb_meas_ctrl_shadowed_lo_err_update_sync.dst_pulse_o = hw.instance "u_usb_meas_ctrl_shadowed_lo_err_update_sync" @prim_pulse_sync(clk_src_i: %clk_usb_i: i1, rst_src_ni: %rst_usb_ni: i1, src_pulse_i: %u_usb_meas_ctrl_shadowed_lo.err_update: i1, clk_dst_i: %3: i1, rst_dst_ni: %4: i1) -> (dst_pulse_o: i1) {sv.namehint = "usb_meas_ctrl_shadowed_lo_update_err"}
    %124 = comb.extract %u_usb_meas_ctrl_shadowed_cdc.dst_wd_o from 9 : (i18) -> i9
    %125 = llhd.sig.struct_extract %121["lo"] : <!hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>>
    %126 = llhd.sig.struct_extract %125["q"] : <!hw.struct<q: i9>>
    %u_usb_meas_ctrl_shadowed_lo.qe, %u_usb_meas_ctrl_shadowed_lo.q, %u_usb_meas_ctrl_shadowed_lo.ds, %u_usb_meas_ctrl_shadowed_lo.qs, %u_usb_meas_ctrl_shadowed_lo.phase, %u_usb_meas_ctrl_shadowed_lo.err_update, %u_usb_meas_ctrl_shadowed_lo.err_storage = hw.instance "u_usb_meas_ctrl_shadowed_lo" @prim_subreg_shadow_21(clk_i: %clk_usb_i: i1, rst_ni: %rst_usb_ni: i1, rst_shadowed_ni: %5: i1, re: %u_usb_meas_ctrl_shadowed_cdc.dst_re_o: i1, we: %184: i1, wd: %124: i9, de: %false: i1, d: %c0_i9: i9) -> (qe: i1, q: i9, ds: i9, qs: i9, phase: i1, err_update: i1, err_storage: i1) {sv.namehint = "async_usb_meas_ctrl_shadowed_lo_err_update"}
    llhd.drv %126, %u_usb_meas_ctrl_shadowed_lo.q after %1 : i9
    llhd.drv %usb_usb_meas_ctrl_shadowed_lo_qs_int, %u_usb_meas_ctrl_shadowed_lo.qs after %1 : i9
    %127 = llhd.prb %recov_err_code_we : i1
    %recov_err_code = hw.struct_extract %hw2reg["recov_err_code"] : !hw.struct<extclk_status: !hw.struct<d: i4>, clk_hints_status: !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>, measure_ctrl_regwen: !hw.struct<d: i1, de: i1>, io_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div2_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div4_meas_ctrl_en: !hw.struct<d: i4, de: i1>, main_meas_ctrl_en: !hw.struct<d: i4, de: i1>, usb_meas_ctrl_en: !hw.struct<d: i4, de: i1>, recov_err_code: !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>
    %shadow_update_err = hw.struct_extract %recov_err_code["shadow_update_err"] : !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>
    %de_22 = hw.struct_extract %shadow_update_err["de"] : !hw.struct<d: i1, de: i1>
    %d_23 = hw.struct_extract %shadow_update_err["d"] : !hw.struct<d: i1, de: i1>
    %u_recov_err_code_shadow_update_err.qe, %u_recov_err_code_shadow_update_err.q, %u_recov_err_code_shadow_update_err.ds, %u_recov_err_code_shadow_update_err.qs = hw.instance "u_recov_err_code_shadow_update_err" @prim_subreg_25(clk_i: %3: i1, rst_ni: %4: i1, we: %127: i1, wd: %194: i1, de: %de_22: i1, d: %d_23: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %recov_err_code_shadow_update_err_qs, %u_recov_err_code_shadow_update_err.qs after %1 : i1
    %io_measure_err = hw.struct_extract %recov_err_code["io_measure_err"] : !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>
    %de_24 = hw.struct_extract %io_measure_err["de"] : !hw.struct<d: i1, de: i1>
    %d_25 = hw.struct_extract %io_measure_err["d"] : !hw.struct<d: i1, de: i1>
    %u_recov_err_code_io_measure_err.qe, %u_recov_err_code_io_measure_err.q, %u_recov_err_code_io_measure_err.ds, %u_recov_err_code_io_measure_err.qs = hw.instance "u_recov_err_code_io_measure_err" @prim_subreg_25(clk_i: %3: i1, rst_ni: %4: i1, we: %127: i1, wd: %195: i1, de: %de_24: i1, d: %d_25: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %recov_err_code_io_measure_err_qs, %u_recov_err_code_io_measure_err.qs after %1 : i1
    %io_div2_measure_err = hw.struct_extract %recov_err_code["io_div2_measure_err"] : !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>
    %de_26 = hw.struct_extract %io_div2_measure_err["de"] : !hw.struct<d: i1, de: i1>
    %d_27 = hw.struct_extract %io_div2_measure_err["d"] : !hw.struct<d: i1, de: i1>
    %u_recov_err_code_io_div2_measure_err.qe, %u_recov_err_code_io_div2_measure_err.q, %u_recov_err_code_io_div2_measure_err.ds, %u_recov_err_code_io_div2_measure_err.qs = hw.instance "u_recov_err_code_io_div2_measure_err" @prim_subreg_25(clk_i: %3: i1, rst_ni: %4: i1, we: %127: i1, wd: %207: i1, de: %de_26: i1, d: %d_27: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %recov_err_code_io_div2_measure_err_qs, %u_recov_err_code_io_div2_measure_err.qs after %1 : i1
    %io_div4_measure_err = hw.struct_extract %recov_err_code["io_div4_measure_err"] : !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>
    %de_28 = hw.struct_extract %io_div4_measure_err["de"] : !hw.struct<d: i1, de: i1>
    %d_29 = hw.struct_extract %io_div4_measure_err["d"] : !hw.struct<d: i1, de: i1>
    %u_recov_err_code_io_div4_measure_err.qe, %u_recov_err_code_io_div4_measure_err.q, %u_recov_err_code_io_div4_measure_err.ds, %u_recov_err_code_io_div4_measure_err.qs = hw.instance "u_recov_err_code_io_div4_measure_err" @prim_subreg_25(clk_i: %3: i1, rst_ni: %4: i1, we: %127: i1, wd: %208: i1, de: %de_28: i1, d: %d_29: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %recov_err_code_io_div4_measure_err_qs, %u_recov_err_code_io_div4_measure_err.qs after %1 : i1
    %main_measure_err = hw.struct_extract %recov_err_code["main_measure_err"] : !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>
    %de_30 = hw.struct_extract %main_measure_err["de"] : !hw.struct<d: i1, de: i1>
    %d_31 = hw.struct_extract %main_measure_err["d"] : !hw.struct<d: i1, de: i1>
    %u_recov_err_code_main_measure_err.qe, %u_recov_err_code_main_measure_err.q, %u_recov_err_code_main_measure_err.ds, %u_recov_err_code_main_measure_err.qs = hw.instance "u_recov_err_code_main_measure_err" @prim_subreg_25(clk_i: %3: i1, rst_ni: %4: i1, we: %127: i1, wd: %240: i1, de: %de_30: i1, d: %d_31: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %recov_err_code_main_measure_err_qs, %u_recov_err_code_main_measure_err.qs after %1 : i1
    %usb_measure_err = hw.struct_extract %recov_err_code["usb_measure_err"] : !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>
    %de_32 = hw.struct_extract %usb_measure_err["de"] : !hw.struct<d: i1, de: i1>
    %d_33 = hw.struct_extract %usb_measure_err["d"] : !hw.struct<d: i1, de: i1>
    %u_recov_err_code_usb_measure_err.qe, %u_recov_err_code_usb_measure_err.q, %u_recov_err_code_usb_measure_err.ds, %u_recov_err_code_usb_measure_err.qs = hw.instance "u_recov_err_code_usb_measure_err" @prim_subreg_25(clk_i: %3: i1, rst_ni: %4: i1, we: %127: i1, wd: %241: i1, de: %de_32: i1, d: %d_33: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %recov_err_code_usb_measure_err_qs, %u_recov_err_code_usb_measure_err.qs after %1 : i1
    %io_timeout_err = hw.struct_extract %recov_err_code["io_timeout_err"] : !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>
    %de_34 = hw.struct_extract %io_timeout_err["de"] : !hw.struct<d: i1, de: i1>
    %d_35 = hw.struct_extract %io_timeout_err["d"] : !hw.struct<d: i1, de: i1>
    %u_recov_err_code_io_timeout_err.qe, %u_recov_err_code_io_timeout_err.q, %u_recov_err_code_io_timeout_err.ds, %u_recov_err_code_io_timeout_err.qs = hw.instance "u_recov_err_code_io_timeout_err" @prim_subreg_25(clk_i: %3: i1, rst_ni: %4: i1, we: %127: i1, wd: %242: i1, de: %de_34: i1, d: %d_35: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %recov_err_code_io_timeout_err_qs, %u_recov_err_code_io_timeout_err.qs after %1 : i1
    %io_div2_timeout_err = hw.struct_extract %recov_err_code["io_div2_timeout_err"] : !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>
    %de_36 = hw.struct_extract %io_div2_timeout_err["de"] : !hw.struct<d: i1, de: i1>
    %d_37 = hw.struct_extract %io_div2_timeout_err["d"] : !hw.struct<d: i1, de: i1>
    %u_recov_err_code_io_div2_timeout_err.qe, %u_recov_err_code_io_div2_timeout_err.q, %u_recov_err_code_io_div2_timeout_err.ds, %u_recov_err_code_io_div2_timeout_err.qs = hw.instance "u_recov_err_code_io_div2_timeout_err" @prim_subreg_25(clk_i: %3: i1, rst_ni: %4: i1, we: %127: i1, wd: %243: i1, de: %de_36: i1, d: %d_37: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %recov_err_code_io_div2_timeout_err_qs, %u_recov_err_code_io_div2_timeout_err.qs after %1 : i1
    %io_div4_timeout_err = hw.struct_extract %recov_err_code["io_div4_timeout_err"] : !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>
    %de_38 = hw.struct_extract %io_div4_timeout_err["de"] : !hw.struct<d: i1, de: i1>
    %d_39 = hw.struct_extract %io_div4_timeout_err["d"] : !hw.struct<d: i1, de: i1>
    %u_recov_err_code_io_div4_timeout_err.qe, %u_recov_err_code_io_div4_timeout_err.q, %u_recov_err_code_io_div4_timeout_err.ds, %u_recov_err_code_io_div4_timeout_err.qs = hw.instance "u_recov_err_code_io_div4_timeout_err" @prim_subreg_25(clk_i: %3: i1, rst_ni: %4: i1, we: %127: i1, wd: %244: i1, de: %de_38: i1, d: %d_39: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %recov_err_code_io_div4_timeout_err_qs, %u_recov_err_code_io_div4_timeout_err.qs after %1 : i1
    %main_timeout_err = hw.struct_extract %recov_err_code["main_timeout_err"] : !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>
    %de_40 = hw.struct_extract %main_timeout_err["de"] : !hw.struct<d: i1, de: i1>
    %d_41 = hw.struct_extract %main_timeout_err["d"] : !hw.struct<d: i1, de: i1>
    %u_recov_err_code_main_timeout_err.qe, %u_recov_err_code_main_timeout_err.q, %u_recov_err_code_main_timeout_err.ds, %u_recov_err_code_main_timeout_err.qs = hw.instance "u_recov_err_code_main_timeout_err" @prim_subreg_25(clk_i: %3: i1, rst_ni: %4: i1, we: %127: i1, wd: %245: i1, de: %de_40: i1, d: %d_41: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %recov_err_code_main_timeout_err_qs, %u_recov_err_code_main_timeout_err.qs after %1 : i1
    %usb_timeout_err = hw.struct_extract %recov_err_code["usb_timeout_err"] : !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>
    %de_42 = hw.struct_extract %usb_timeout_err["de"] : !hw.struct<d: i1, de: i1>
    %d_43 = hw.struct_extract %usb_timeout_err["d"] : !hw.struct<d: i1, de: i1>
    %u_recov_err_code_usb_timeout_err.qe, %u_recov_err_code_usb_timeout_err.q, %u_recov_err_code_usb_timeout_err.ds, %u_recov_err_code_usb_timeout_err.qs = hw.instance "u_recov_err_code_usb_timeout_err" @prim_subreg_25(clk_i: %3: i1, rst_ni: %4: i1, we: %127: i1, wd: %246: i1, de: %de_42: i1, d: %d_43: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %recov_err_code_usb_timeout_err_qs, %u_recov_err_code_usb_timeout_err.qs after %1 : i1
    %fatal_err_code = hw.struct_extract %hw2reg["fatal_err_code"] : !hw.struct<extclk_status: !hw.struct<d: i4>, clk_hints_status: !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>, measure_ctrl_regwen: !hw.struct<d: i1, de: i1>, io_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div2_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div4_meas_ctrl_en: !hw.struct<d: i4, de: i1>, main_meas_ctrl_en: !hw.struct<d: i4, de: i1>, usb_meas_ctrl_en: !hw.struct<d: i4, de: i1>, recov_err_code: !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>
    %reg_intg = hw.struct_extract %fatal_err_code["reg_intg"] : !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>
    %de_44 = hw.struct_extract %reg_intg["de"] : !hw.struct<d: i1, de: i1>
    %d_45 = hw.struct_extract %reg_intg["d"] : !hw.struct<d: i1, de: i1>
    %128 = llhd.sig.struct_extract %reg2hw["fatal_err_code"] : <!hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>>
    %129 = llhd.sig.struct_extract %128["reg_intg"] : <!hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
    %130 = llhd.sig.struct_extract %129["q"] : <!hw.struct<q: i1>>
    %u_fatal_err_code_reg_intg.qe, %u_fatal_err_code_reg_intg.q, %u_fatal_err_code_reg_intg.ds, %u_fatal_err_code_reg_intg.qs = hw.instance "u_fatal_err_code_reg_intg" @prim_subreg_26(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_44: i1, d: %d_45: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %130, %u_fatal_err_code_reg_intg.q after %1 : i1
    llhd.drv %fatal_err_code_reg_intg_qs, %u_fatal_err_code_reg_intg.qs after %1 : i1
    %idle_cnt = hw.struct_extract %fatal_err_code["idle_cnt"] : !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>
    %de_46 = hw.struct_extract %idle_cnt["de"] : !hw.struct<d: i1, de: i1>
    %d_47 = hw.struct_extract %idle_cnt["d"] : !hw.struct<d: i1, de: i1>
    %131 = llhd.sig.struct_extract %128["idle_cnt"] : <!hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
    %132 = llhd.sig.struct_extract %131["q"] : <!hw.struct<q: i1>>
    %u_fatal_err_code_idle_cnt.qe, %u_fatal_err_code_idle_cnt.q, %u_fatal_err_code_idle_cnt.ds, %u_fatal_err_code_idle_cnt.qs = hw.instance "u_fatal_err_code_idle_cnt" @prim_subreg_26(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_46: i1, d: %d_47: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %132, %u_fatal_err_code_idle_cnt.q after %1 : i1
    llhd.drv %fatal_err_code_idle_cnt_qs, %u_fatal_err_code_idle_cnt.qs after %1 : i1
    %shadow_storage_err = hw.struct_extract %fatal_err_code["shadow_storage_err"] : !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>
    %de_48 = hw.struct_extract %shadow_storage_err["de"] : !hw.struct<d: i1, de: i1>
    %d_49 = hw.struct_extract %shadow_storage_err["d"] : !hw.struct<d: i1, de: i1>
    %133 = llhd.sig.struct_extract %128["shadow_storage_err"] : <!hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
    %134 = llhd.sig.struct_extract %133["q"] : <!hw.struct<q: i1>>
    %u_fatal_err_code_shadow_storage_err.qe, %u_fatal_err_code_shadow_storage_err.q, %u_fatal_err_code_shadow_storage_err.ds, %u_fatal_err_code_shadow_storage_err.qs = hw.instance "u_fatal_err_code_shadow_storage_err" @prim_subreg_26(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_48: i1, d: %d_49: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %134, %u_fatal_err_code_shadow_storage_err.q after %1 : i1
    llhd.drv %fatal_err_code_shadow_storage_err_qs, %u_fatal_err_code_shadow_storage_err.qs after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %309 = llhd.prb %clk_i_0 : i1
      %310 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %311 = llhd.prb %clk_i_0 : i1
      %312 = comb.xor bin %309, %true : i1
      %313 = comb.and bin %312, %311 : i1
      %314 = llhd.prb %rst_ni_1 : i1
      %315 = comb.xor bin %314, %true : i1
      %316 = comb.and bin %310, %315 : i1
      %317 = comb.or bin %313, %316 : i1
      cf.cond_br %317, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %318 = llhd.prb %rst_ni_1 : i1
      %319 = comb.xor %318, %true : i1
      cf.cond_br %319, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %err_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %320 = llhd.prb %intg_err : i1
      %321 = llhd.prb %reg_we_err : i1
      %322 = comb.or %320, %321 : i1
      cf.cond_br %322, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %err_q, %true after %0 : i1
      cf.br ^bb1
    }
    %135 = llhd.prb %err_q : i1
    %136 = llhd.prb %intg_err : i1
    %137 = llhd.prb %reg_we_err : i1
    %138 = comb.or %135, %136, %137 : i1
    %139 = llhd.prb %reg_rdata_next {sv.namehint = "reg_rdata"} : i32
    %140 = llhd.prb %wr_err : i1
    %141 = comb.or %189, %140, %136 {sv.namehint = "reg_error"} : i1
    %142 = llhd.prb %io_io_meas_ctrl_en_ds_int : i4
    %143 = llhd.prb %io_io_meas_ctrl_en_qs_int : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %io_io_meas_ctrl_en_qs, %c-7_i4 after %1 : i4
      llhd.drv %io_io_meas_ctrl_en_ds, %c-7_i4 after %1 : i4
      %309 = llhd.prb %io_io_meas_ctrl_en_ds_int : i4
      llhd.drv %io_io_meas_ctrl_en_ds, %309 after %1 : i4
      %310 = llhd.prb %io_io_meas_ctrl_en_qs_int : i4
      llhd.drv %io_io_meas_ctrl_en_qs, %310 after %1 : i4
      llhd.wait (%14, %13, %142, %143 : i4, i4, i4, i4), ^bb1
    }
    %144 = llhd.prb %io_io_meas_ctrl_shadowed_hi_qs_int : i10
    %145 = llhd.prb %io_io_meas_ctrl_shadowed_lo_qs_int : i10
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %io_io_meas_ctrl_shadowed_qs, %c481770_i20 after %1 : i20
      %309 = llhd.sig.extract %io_io_meas_ctrl_shadowed_qs from %c0_i5 : <i20> -> <i10>
      %310 = llhd.prb %io_io_meas_ctrl_shadowed_hi_qs_int : i10
      llhd.drv %309, %310 after %1 : i10
      %311 = llhd.sig.extract %io_io_meas_ctrl_shadowed_qs from %c10_i5 : <i20> -> <i10>
      %312 = llhd.prb %io_io_meas_ctrl_shadowed_lo_qs_int : i10
      llhd.drv %311, %312 after %1 : i10
      llhd.wait (%17, %144, %145 : i20, i10, i10), ^bb1
    }
    %146 = llhd.prb %io_div2_io_div2_meas_ctrl_en_ds_int : i4
    %147 = llhd.prb %io_div2_io_div2_meas_ctrl_en_qs_int : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %io_div2_io_div2_meas_ctrl_en_qs, %c-7_i4 after %1 : i4
      llhd.drv %io_div2_io_div2_meas_ctrl_en_ds, %c-7_i4 after %1 : i4
      %309 = llhd.prb %io_div2_io_div2_meas_ctrl_en_ds_int : i4
      llhd.drv %io_div2_io_div2_meas_ctrl_en_ds, %309 after %1 : i4
      %310 = llhd.prb %io_div2_io_div2_meas_ctrl_en_qs_int : i4
      llhd.drv %io_div2_io_div2_meas_ctrl_en_qs, %310 after %1 : i4
      llhd.wait (%20, %19, %146, %147 : i4, i4, i4, i4), ^bb1
    }
    %148 = llhd.prb %io_div2_io_div2_meas_ctrl_shadowed_hi_qs_int : i9
    %149 = llhd.prb %io_div2_io_div2_meas_ctrl_shadowed_lo_qs_int : i9
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %io_div2_io_div2_meas_ctrl_shadowed_qs, %c118010_i18 after %1 : i18
      %309 = llhd.sig.extract %io_div2_io_div2_meas_ctrl_shadowed_qs from %c0_i5 : <i18> -> <i9>
      %310 = llhd.prb %io_div2_io_div2_meas_ctrl_shadowed_hi_qs_int : i9
      llhd.drv %309, %310 after %1 : i9
      %311 = llhd.sig.extract %io_div2_io_div2_meas_ctrl_shadowed_qs from %c9_i5 : <i18> -> <i9>
      %312 = llhd.prb %io_div2_io_div2_meas_ctrl_shadowed_lo_qs_int : i9
      llhd.drv %311, %312 after %1 : i9
      llhd.wait (%23, %148, %149 : i18, i9, i9), ^bb1
    }
    %150 = llhd.prb %io_div4_io_div4_meas_ctrl_en_ds_int : i4
    %151 = llhd.prb %io_div4_io_div4_meas_ctrl_en_qs_int : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %io_div4_io_div4_meas_ctrl_en_qs, %c-7_i4 after %1 : i4
      llhd.drv %io_div4_io_div4_meas_ctrl_en_ds, %c-7_i4 after %1 : i4
      %309 = llhd.prb %io_div4_io_div4_meas_ctrl_en_ds_int : i4
      llhd.drv %io_div4_io_div4_meas_ctrl_en_ds, %309 after %1 : i4
      %310 = llhd.prb %io_div4_io_div4_meas_ctrl_en_qs_int : i4
      llhd.drv %io_div4_io_div4_meas_ctrl_en_qs, %310 after %1 : i4
      llhd.wait (%26, %25, %150, %151 : i4, i4, i4, i4), ^bb1
    }
    %152 = llhd.prb %io_div4_io_div4_meas_ctrl_shadowed_hi_qs_int : i8
    %153 = llhd.prb %io_div4_io_div4_meas_ctrl_shadowed_lo_qs_int : i8
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %io_div4_io_div4_meas_ctrl_shadowed_qs, %c28290_i16 after %1 : i16
      %309 = llhd.sig.extract %io_div4_io_div4_meas_ctrl_shadowed_qs from %c0_i4 : <i16> -> <i8>
      %310 = llhd.prb %io_div4_io_div4_meas_ctrl_shadowed_hi_qs_int : i8
      llhd.drv %309, %310 after %1 : i8
      %311 = llhd.sig.extract %io_div4_io_div4_meas_ctrl_shadowed_qs from %c-8_i4 : <i16> -> <i8>
      %312 = llhd.prb %io_div4_io_div4_meas_ctrl_shadowed_lo_qs_int : i8
      llhd.drv %311, %312 after %1 : i8
      llhd.wait (%29, %152, %153 : i16, i8, i8), ^bb1
    }
    %154 = llhd.prb %main_main_meas_ctrl_en_ds_int : i4
    %155 = llhd.prb %main_main_meas_ctrl_en_qs_int : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %main_main_meas_ctrl_en_qs, %c-7_i4 after %1 : i4
      llhd.drv %main_main_meas_ctrl_en_ds, %c-7_i4 after %1 : i4
      %309 = llhd.prb %main_main_meas_ctrl_en_ds_int : i4
      llhd.drv %main_main_meas_ctrl_en_ds, %309 after %1 : i4
      %310 = llhd.prb %main_main_meas_ctrl_en_qs_int : i4
      llhd.drv %main_main_meas_ctrl_en_qs, %310 after %1 : i4
      llhd.wait (%32, %31, %154, %155 : i4, i4, i4, i4), ^bb1
    }
    %156 = llhd.prb %main_main_meas_ctrl_shadowed_hi_qs_int : i10
    %157 = llhd.prb %main_main_meas_ctrl_shadowed_lo_qs_int : i10
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %main_main_meas_ctrl_shadowed_qs, %c502270_i20 after %1 : i20
      %309 = llhd.sig.extract %main_main_meas_ctrl_shadowed_qs from %c0_i5 : <i20> -> <i10>
      %310 = llhd.prb %main_main_meas_ctrl_shadowed_hi_qs_int : i10
      llhd.drv %309, %310 after %1 : i10
      %311 = llhd.sig.extract %main_main_meas_ctrl_shadowed_qs from %c10_i5 : <i20> -> <i10>
      %312 = llhd.prb %main_main_meas_ctrl_shadowed_lo_qs_int : i10
      llhd.drv %311, %312 after %1 : i10
      llhd.wait (%34, %156, %157 : i20, i10, i10), ^bb1
    }
    %158 = llhd.prb %usb_usb_meas_ctrl_en_ds_int : i4
    %159 = llhd.prb %usb_usb_meas_ctrl_en_qs_int : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %usb_usb_meas_ctrl_en_qs, %c-7_i4 after %1 : i4
      llhd.drv %usb_usb_meas_ctrl_en_ds, %c-7_i4 after %1 : i4
      %309 = llhd.prb %usb_usb_meas_ctrl_en_ds_int : i4
      llhd.drv %usb_usb_meas_ctrl_en_ds, %309 after %1 : i4
      %310 = llhd.prb %usb_usb_meas_ctrl_en_qs_int : i4
      llhd.drv %usb_usb_meas_ctrl_en_qs, %310 after %1 : i4
      llhd.wait (%37, %36, %158, %159 : i4, i4, i4, i4), ^bb1
    }
    %160 = llhd.prb %usb_usb_meas_ctrl_shadowed_hi_qs_int : i9
    %161 = llhd.prb %usb_usb_meas_ctrl_shadowed_lo_qs_int : i9
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %usb_usb_meas_ctrl_shadowed_qs, %c118010_i18 after %1 : i18
      %309 = llhd.sig.extract %usb_usb_meas_ctrl_shadowed_qs from %c0_i5 : <i18> -> <i9>
      %310 = llhd.prb %usb_usb_meas_ctrl_shadowed_hi_qs_int : i9
      llhd.drv %309, %310 after %1 : i9
      %311 = llhd.sig.extract %usb_usb_meas_ctrl_shadowed_qs from %c9_i5 : <i18> -> <i9>
      %312 = llhd.prb %usb_usb_meas_ctrl_shadowed_lo_qs_int : i9
      llhd.drv %311, %312 after %1 : i9
      llhd.wait (%39, %160, %161 : i18, i9, i9), ^bb1
    }
    %162 = llhd.prb %alert_test_flds_we : i2
    %163 = comb.icmp eq %162, %c-1_i2 {sv.namehint = "alert_test_qe"} : i2
    %164 = llhd.sig.struct_extract %43["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %164, %163 after %1 : i1
    %165 = llhd.sig.struct_extract %46["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %165, %163 after %1 : i1
    %166 = llhd.prb %extclk_ctrl_regwen_qs : i1
    %167 = comb.and %198, %7, %192, %166 : i1
    llhd.drv %extclk_ctrl_gated_we, %167 after %1 : i1
    %168 = llhd.prb %jitter_regwen_qs : i1
    %169 = comb.and %204, %7, %192, %168 : i1
    llhd.drv %jitter_enable_gated_we, %169 after %1 : i1
    %170 = llhd.prb %io_meas_ctrl_en_flds_we {sv.namehint = "io_io_meas_ctrl_en_qe"} : i1
    %171 = comb.and %u_io_meas_ctrl_en_cdc.dst_we_o, %u_io_meas_ctrl_en_cdc.dst_regwen_o {sv.namehint = "io_io_meas_ctrl_en_gated_we"} : i1
    %172 = comb.and %u_io_meas_ctrl_shadowed_cdc.dst_we_o, %u_io_meas_ctrl_shadowed_cdc.dst_regwen_o {sv.namehint = "io_io_meas_ctrl_shadowed_gated_we"} : i1
    %173 = llhd.prb %io_div2_meas_ctrl_en_flds_we {sv.namehint = "io_div2_io_div2_meas_ctrl_en_qe"} : i1
    %174 = comb.and %u_io_div2_meas_ctrl_en_cdc.dst_we_o, %u_io_div2_meas_ctrl_en_cdc.dst_regwen_o {sv.namehint = "io_div2_io_div2_meas_ctrl_en_gated_we"} : i1
    %175 = comb.and %u_io_div2_meas_ctrl_shadowed_cdc.dst_we_o, %u_io_div2_meas_ctrl_shadowed_cdc.dst_regwen_o {sv.namehint = "io_div2_io_div2_meas_ctrl_shadowed_gated_we"} : i1
    %176 = llhd.prb %io_div4_meas_ctrl_en_flds_we {sv.namehint = "io_div4_io_div4_meas_ctrl_en_qe"} : i1
    %177 = comb.and %u_io_div4_meas_ctrl_en_cdc.dst_we_o, %u_io_div4_meas_ctrl_en_cdc.dst_regwen_o {sv.namehint = "io_div4_io_div4_meas_ctrl_en_gated_we"} : i1
    %178 = comb.and %u_io_div4_meas_ctrl_shadowed_cdc.dst_we_o, %u_io_div4_meas_ctrl_shadowed_cdc.dst_regwen_o {sv.namehint = "io_div4_io_div4_meas_ctrl_shadowed_gated_we"} : i1
    %179 = llhd.prb %main_meas_ctrl_en_flds_we {sv.namehint = "main_main_meas_ctrl_en_qe"} : i1
    %180 = comb.and %u_main_meas_ctrl_en_cdc.dst_we_o, %u_main_meas_ctrl_en_cdc.dst_regwen_o {sv.namehint = "main_main_meas_ctrl_en_gated_we"} : i1
    %181 = comb.and %u_main_meas_ctrl_shadowed_cdc.dst_we_o, %u_main_meas_ctrl_shadowed_cdc.dst_regwen_o {sv.namehint = "main_main_meas_ctrl_shadowed_gated_we"} : i1
    %182 = llhd.prb %usb_meas_ctrl_en_flds_we {sv.namehint = "usb_usb_meas_ctrl_en_qe"} : i1
    %183 = comb.and %u_usb_meas_ctrl_en_cdc.dst_we_o, %u_usb_meas_ctrl_en_cdc.dst_regwen_o {sv.namehint = "usb_usb_meas_ctrl_en_gated_we"} : i1
    %184 = comb.and %u_usb_meas_ctrl_shadowed_cdc.dst_we_o, %u_usb_meas_ctrl_shadowed_cdc.dst_regwen_o {sv.namehint = "usb_usb_meas_ctrl_shadowed_gated_we"} : i1
    %185 = llhd.prb %addr_hit : i22
    %186 = llhd.prb %reg_addr : i7
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %309 = llhd.sig.extract %addr_hit from %c0_i5 : <i22> -> <i1>
      %310 = llhd.prb %reg_addr : i7
      %311 = comb.icmp eq %310, %c0_i7 : i7
      llhd.drv %309, %311 after %1 : i1
      %312 = llhd.sig.extract %addr_hit from %c1_i5 : <i22> -> <i1>
      %313 = llhd.prb %reg_addr : i7
      %314 = comb.icmp eq %313, %c4_i7 : i7
      llhd.drv %312, %314 after %1 : i1
      %315 = llhd.sig.extract %addr_hit from %c2_i5 : <i22> -> <i1>
      %316 = llhd.prb %reg_addr : i7
      %317 = comb.icmp eq %316, %c8_i7 : i7
      llhd.drv %315, %317 after %1 : i1
      %318 = llhd.sig.extract %addr_hit from %c3_i5 : <i22> -> <i1>
      %319 = llhd.prb %reg_addr : i7
      %320 = comb.icmp eq %319, %c12_i7 : i7
      llhd.drv %318, %320 after %1 : i1
      %321 = llhd.sig.extract %addr_hit from %c4_i5 : <i22> -> <i1>
      %322 = llhd.prb %reg_addr : i7
      %323 = comb.icmp eq %322, %c16_i7 : i7
      llhd.drv %321, %323 after %1 : i1
      %324 = llhd.sig.extract %addr_hit from %c5_i5 : <i22> -> <i1>
      %325 = llhd.prb %reg_addr : i7
      %326 = comb.icmp eq %325, %c20_i7 : i7
      llhd.drv %324, %326 after %1 : i1
      %327 = llhd.sig.extract %addr_hit from %c6_i5 : <i22> -> <i1>
      %328 = llhd.prb %reg_addr : i7
      %329 = comb.icmp eq %328, %c24_i7 : i7
      llhd.drv %327, %329 after %1 : i1
      %330 = llhd.sig.extract %addr_hit from %c7_i5 : <i22> -> <i1>
      %331 = llhd.prb %reg_addr : i7
      %332 = comb.icmp eq %331, %c28_i7 : i7
      llhd.drv %330, %332 after %1 : i1
      %333 = llhd.sig.extract %addr_hit from %c8_i5 : <i22> -> <i1>
      %334 = llhd.prb %reg_addr : i7
      %335 = comb.icmp eq %334, %c32_i7 : i7
      llhd.drv %333, %335 after %1 : i1
      %336 = llhd.sig.extract %addr_hit from %c9_i5 : <i22> -> <i1>
      %337 = llhd.prb %reg_addr : i7
      %338 = comb.icmp eq %337, %c36_i7 : i7
      llhd.drv %336, %338 after %1 : i1
      %339 = llhd.sig.extract %addr_hit from %c10_i5 : <i22> -> <i1>
      %340 = llhd.prb %reg_addr : i7
      %341 = comb.icmp eq %340, %c40_i7 : i7
      llhd.drv %339, %341 after %1 : i1
      %342 = llhd.sig.extract %addr_hit from %c11_i5 : <i22> -> <i1>
      %343 = llhd.prb %reg_addr : i7
      %344 = comb.icmp eq %343, %c44_i7 : i7
      llhd.drv %342, %344 after %1 : i1
      %345 = llhd.sig.extract %addr_hit from %c12_i5 : <i22> -> <i1>
      %346 = llhd.prb %reg_addr : i7
      %347 = comb.icmp eq %346, %c48_i7 : i7
      llhd.drv %345, %347 after %1 : i1
      %348 = llhd.sig.extract %addr_hit from %c13_i5 : <i22> -> <i1>
      %349 = llhd.prb %reg_addr : i7
      %350 = comb.icmp eq %349, %c52_i7 : i7
      llhd.drv %348, %350 after %1 : i1
      %351 = llhd.sig.extract %addr_hit from %c14_i5 : <i22> -> <i1>
      %352 = llhd.prb %reg_addr : i7
      %353 = comb.icmp eq %352, %c56_i7 : i7
      llhd.drv %351, %353 after %1 : i1
      %354 = llhd.sig.extract %addr_hit from %c15_i5 : <i22> -> <i1>
      %355 = llhd.prb %reg_addr : i7
      %356 = comb.icmp eq %355, %c60_i7 : i7
      llhd.drv %354, %356 after %1 : i1
      %357 = llhd.sig.extract %addr_hit from %c-16_i5 : <i22> -> <i1>
      %358 = llhd.prb %reg_addr : i7
      %359 = comb.icmp eq %358, %c-64_i7 : i7
      llhd.drv %357, %359 after %1 : i1
      %360 = llhd.sig.extract %addr_hit from %c-15_i5 : <i22> -> <i1>
      %361 = llhd.prb %reg_addr : i7
      %362 = comb.icmp eq %361, %c-60_i7 : i7
      llhd.drv %360, %362 after %1 : i1
      %363 = llhd.sig.extract %addr_hit from %c-14_i5 : <i22> -> <i1>
      %364 = llhd.prb %reg_addr : i7
      %365 = comb.icmp eq %364, %c-56_i7 : i7
      llhd.drv %363, %365 after %1 : i1
      %366 = llhd.sig.extract %addr_hit from %c-13_i5 : <i22> -> <i1>
      %367 = llhd.prb %reg_addr : i7
      %368 = comb.icmp eq %367, %c-52_i7 : i7
      llhd.drv %366, %368 after %1 : i1
      %369 = llhd.sig.extract %addr_hit from %c-12_i5 : <i22> -> <i1>
      %370 = llhd.prb %reg_addr : i7
      %371 = comb.icmp eq %370, %c-48_i7 : i7
      llhd.drv %369, %371 after %1 : i1
      %372 = llhd.sig.extract %addr_hit from %c-11_i5 : <i22> -> <i1>
      %373 = llhd.prb %reg_addr : i7
      %374 = comb.icmp eq %373, %c-44_i7 : i7
      llhd.drv %372, %374 after %1 : i1
      llhd.wait (%185, %186 : i22, i7), ^bb1
    }
    %187 = comb.or %u_reg_if.re_o, %7 : i1
    %188 = comb.icmp eq %185, %c0_i22 : i22
    %189 = comb.and %187, %188 {sv.namehint = "addrmiss"} : i1
    %190 = llhd.prb %reg_be : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %309 = llhd.prb %reg_we : i1
      %310 = llhd.prb %addr_hit : i22
      %311 = comb.extract %310 from 0 : (i22) -> i1
      %312 = llhd.prb %reg_be : i4
      %313 = comb.extract %312 from 0 : (i4) -> i3
      %314 = comb.extract %312 from 0 : (i4) -> i2
      %315 = comb.extract %312 from 0 : (i4) -> i1
      %316 = comb.xor %315, %true : i1
      %317 = comb.and %311, %316 : i1
      %318 = comb.extract %310 from 1 : (i22) -> i1
      %319 = comb.and %318, %316 : i1
      %320 = comb.extract %310 from 2 : (i22) -> i1
      %321 = comb.and %320, %316 : i1
      %322 = comb.extract %310 from 3 : (i22) -> i1
      %323 = comb.and %322, %316 : i1
      %324 = comb.extract %310 from 4 : (i22) -> i1
      %325 = comb.and %324, %316 : i1
      %326 = comb.extract %310 from 5 : (i22) -> i1
      %327 = comb.and %326, %316 : i1
      %328 = comb.extract %310 from 6 : (i22) -> i1
      %329 = comb.and %328, %316 : i1
      %330 = comb.extract %310 from 7 : (i22) -> i1
      %331 = comb.and %330, %316 : i1
      %332 = comb.extract %310 from 8 : (i22) -> i1
      %333 = comb.and %332, %316 : i1
      %334 = comb.extract %310 from 9 : (i22) -> i1
      %335 = comb.and %334, %316 : i1
      %336 = comb.extract %310 from 10 : (i22) -> i1
      %337 = comb.and %336, %316 : i1
      %338 = comb.extract %310 from 11 : (i22) -> i1
      %339 = comb.icmp ne %313, %c-1_i3 : i3
      %340 = comb.and %338, %339 : i1
      %341 = comb.extract %310 from 12 : (i22) -> i1
      %342 = comb.and %341, %316 : i1
      %343 = comb.extract %310 from 13 : (i22) -> i1
      %344 = comb.icmp ne %313, %c-1_i3 : i3
      %345 = comb.and %343, %344 : i1
      %346 = comb.extract %310 from 14 : (i22) -> i1
      %347 = comb.and %346, %316 : i1
      %348 = comb.extract %310 from 15 : (i22) -> i1
      %349 = comb.icmp ne %314, %c-1_i2 : i2
      %350 = comb.and %348, %349 : i1
      %351 = comb.extract %310 from 16 : (i22) -> i1
      %352 = comb.and %351, %316 : i1
      %353 = comb.extract %310 from 17 : (i22) -> i1
      %354 = comb.icmp ne %313, %c-1_i3 : i3
      %355 = comb.and %353, %354 : i1
      %356 = comb.extract %310 from 18 : (i22) -> i1
      %357 = comb.and %356, %316 : i1
      %358 = comb.extract %310 from 19 : (i22) -> i1
      %359 = comb.icmp ne %313, %c-1_i3 : i3
      %360 = comb.and %358, %359 : i1
      %361 = comb.extract %310 from 20 : (i22) -> i1
      %362 = comb.icmp ne %314, %c-1_i2 : i2
      %363 = comb.and %361, %362 : i1
      %364 = comb.extract %310 from 21 : (i22) -> i1
      %365 = comb.and %364, %316 : i1
      %366 = comb.or %317, %319, %321, %323, %325, %327, %329, %331, %333, %335, %337, %340, %342, %345, %347, %350, %352, %355, %357, %360, %363, %365 : i1
      %367 = comb.and %309, %366 : i1
      llhd.drv %wr_err, %367 after %1 : i1
      llhd.wait (%7, %185, %190, %140 : i1, i22, i4, i1), ^bb1
    }
    %191 = comb.extract %185 from 0 : (i22) -> i1
    %192 = comb.xor %141, %true : i1
    %193 = comb.and %191, %7, %192 : i1
    llhd.drv %alert_test_we, %193 after %1 : i1
    %194 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "jitter_regwen_wd"} : (i32) -> i1
    %195 = comb.extract %u_reg_if.wdata_o from 1 {sv.namehint = "alert_test_fatal_fault_wd"} : (i32) -> i1
    %196 = comb.extract %185 from 1 : (i22) -> i1
    %197 = comb.and %196, %7, %192 : i1
    llhd.drv %extclk_ctrl_regwen_we, %197 after %1 : i1
    %198 = comb.extract %185 from 2 : (i22) -> i1
    %199 = comb.extract %u_reg_if.wdata_o from 4 {sv.namehint = "extclk_ctrl_hi_speed_sel_wd"} : (i32) -> i4
    %200 = comb.extract %185 from 3 : (i22) -> i1
    %201 = comb.and %200, %u_reg_if.re_o, %192 {sv.namehint = "extclk_status_re"} : i1
    %202 = comb.extract %185 from 4 : (i22) -> i1
    %203 = comb.and %202, %7, %192 : i1
    llhd.drv %jitter_regwen_we, %203 after %1 : i1
    %204 = comb.extract %185 from 5 : (i22) -> i1
    %205 = comb.extract %185 from 6 : (i22) -> i1
    %206 = comb.and %205, %7, %192 : i1
    llhd.drv %clk_enables_we, %206 after %1 : i1
    %207 = comb.extract %u_reg_if.wdata_o from 2 {sv.namehint = "clk_enables_clk_io_peri_en_wd"} : (i32) -> i1
    %208 = comb.extract %u_reg_if.wdata_o from 3 {sv.namehint = "clk_enables_clk_usb_peri_en_wd"} : (i32) -> i1
    %209 = comb.extract %185 from 7 : (i22) -> i1
    %210 = comb.and %209, %7, %192 : i1
    llhd.drv %clk_hints_we, %210 after %1 : i1
    %211 = comb.extract %185 from 9 : (i22) -> i1
    %212 = comb.and %211, %7, %192 : i1
    llhd.drv %measure_ctrl_regwen_we, %212 after %1 : i1
    %213 = comb.extract %185 from 10 : (i22) -> i1
    %214 = comb.and %213, %7, %192 : i1
    llhd.drv %io_meas_ctrl_en_we, %214 after %1 : i1
    %215 = comb.extract %185 from 11 : (i22) -> i1
    %216 = comb.and %215, %u_reg_if.re_o, %192 {sv.namehint = "io_meas_ctrl_shadowed_re"} : i1
    %217 = comb.and %215, %7, %192 : i1
    llhd.drv %io_meas_ctrl_shadowed_we, %217 after %1 : i1
    %218 = comb.extract %185 from 12 : (i22) -> i1
    %219 = comb.and %218, %7, %192 : i1
    llhd.drv %io_div2_meas_ctrl_en_we, %219 after %1 : i1
    %220 = comb.extract %185 from 13 : (i22) -> i1
    %221 = comb.and %220, %u_reg_if.re_o, %192 {sv.namehint = "io_div2_meas_ctrl_shadowed_re"} : i1
    %222 = comb.and %220, %7, %192 : i1
    llhd.drv %io_div2_meas_ctrl_shadowed_we, %222 after %1 : i1
    %223 = comb.extract %185 from 14 : (i22) -> i1
    %224 = comb.and %223, %7, %192 : i1
    llhd.drv %io_div4_meas_ctrl_en_we, %224 after %1 : i1
    %225 = comb.extract %185 from 15 : (i22) -> i1
    %226 = comb.and %225, %u_reg_if.re_o, %192 {sv.namehint = "io_div4_meas_ctrl_shadowed_re"} : i1
    %227 = comb.and %225, %7, %192 : i1
    llhd.drv %io_div4_meas_ctrl_shadowed_we, %227 after %1 : i1
    %228 = comb.extract %185 from 16 : (i22) -> i1
    %229 = comb.and %228, %7, %192 : i1
    llhd.drv %main_meas_ctrl_en_we, %229 after %1 : i1
    %230 = comb.extract %185 from 17 : (i22) -> i1
    %231 = comb.and %230, %u_reg_if.re_o, %192 {sv.namehint = "main_meas_ctrl_shadowed_re"} : i1
    %232 = comb.and %230, %7, %192 : i1
    llhd.drv %main_meas_ctrl_shadowed_we, %232 after %1 : i1
    %233 = comb.extract %185 from 18 : (i22) -> i1
    %234 = comb.and %233, %7, %192 : i1
    llhd.drv %usb_meas_ctrl_en_we, %234 after %1 : i1
    %235 = comb.extract %185 from 19 : (i22) -> i1
    %236 = comb.and %235, %u_reg_if.re_o, %192 {sv.namehint = "usb_meas_ctrl_shadowed_re"} : i1
    %237 = comb.and %235, %7, %192 : i1
    llhd.drv %usb_meas_ctrl_shadowed_we, %237 after %1 : i1
    %238 = comb.extract %185 from 20 : (i22) -> i1
    %239 = comb.and %238, %7, %192 : i1
    llhd.drv %recov_err_code_we, %239 after %1 : i1
    %240 = comb.extract %u_reg_if.wdata_o from 4 {sv.namehint = "recov_err_code_main_measure_err_wd"} : (i32) -> i1
    %241 = comb.extract %u_reg_if.wdata_o from 5 {sv.namehint = "recov_err_code_usb_measure_err_wd"} : (i32) -> i1
    %242 = comb.extract %u_reg_if.wdata_o from 6 {sv.namehint = "recov_err_code_io_timeout_err_wd"} : (i32) -> i1
    %243 = comb.extract %u_reg_if.wdata_o from 7 {sv.namehint = "recov_err_code_io_div2_timeout_err_wd"} : (i32) -> i1
    %244 = comb.extract %u_reg_if.wdata_o from 8 {sv.namehint = "recov_err_code_io_div4_timeout_err_wd"} : (i32) -> i1
    %245 = comb.extract %u_reg_if.wdata_o from 9 {sv.namehint = "recov_err_code_main_timeout_err_wd"} : (i32) -> i1
    %246 = comb.extract %u_reg_if.wdata_o from 10 {sv.namehint = "recov_err_code_usb_timeout_err_wd"} : (i32) -> i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %309 = llhd.sig.extract %reg_we_check from %c0_i5 : <i22> -> <i1>
      %310 = llhd.prb %alert_test_we : i1
      llhd.drv %309, %310 after %1 : i1
      %311 = llhd.sig.extract %reg_we_check from %c1_i5 : <i22> -> <i1>
      %312 = llhd.prb %extclk_ctrl_regwen_we : i1
      llhd.drv %311, %312 after %1 : i1
      %313 = llhd.sig.extract %reg_we_check from %c2_i5 : <i22> -> <i1>
      %314 = llhd.prb %extclk_ctrl_gated_we : i1
      llhd.drv %313, %314 after %1 : i1
      %315 = llhd.sig.extract %reg_we_check from %c3_i5 : <i22> -> <i1>
      llhd.drv %315, %false after %1 : i1
      %316 = llhd.sig.extract %reg_we_check from %c4_i5 : <i22> -> <i1>
      %317 = llhd.prb %jitter_regwen_we : i1
      llhd.drv %316, %317 after %1 : i1
      %318 = llhd.sig.extract %reg_we_check from %c5_i5 : <i22> -> <i1>
      %319 = llhd.prb %jitter_enable_gated_we : i1
      llhd.drv %318, %319 after %1 : i1
      %320 = llhd.sig.extract %reg_we_check from %c6_i5 : <i22> -> <i1>
      %321 = llhd.prb %clk_enables_we : i1
      llhd.drv %320, %321 after %1 : i1
      %322 = llhd.sig.extract %reg_we_check from %c7_i5 : <i22> -> <i1>
      %323 = llhd.prb %clk_hints_we : i1
      llhd.drv %322, %323 after %1 : i1
      %324 = llhd.sig.extract %reg_we_check from %c8_i5 : <i22> -> <i1>
      llhd.drv %324, %false after %1 : i1
      %325 = llhd.sig.extract %reg_we_check from %c9_i5 : <i22> -> <i1>
      %326 = llhd.prb %measure_ctrl_regwen_we : i1
      llhd.drv %325, %326 after %1 : i1
      %327 = llhd.sig.extract %reg_we_check from %c10_i5 : <i22> -> <i1>
      %328 = llhd.prb %io_meas_ctrl_en_we : i1
      llhd.drv %327, %328 after %1 : i1
      %329 = llhd.sig.extract %reg_we_check from %c11_i5 : <i22> -> <i1>
      %330 = llhd.prb %io_meas_ctrl_shadowed_we : i1
      llhd.drv %329, %330 after %1 : i1
      %331 = llhd.sig.extract %reg_we_check from %c12_i5 : <i22> -> <i1>
      %332 = llhd.prb %io_div2_meas_ctrl_en_we : i1
      llhd.drv %331, %332 after %1 : i1
      %333 = llhd.sig.extract %reg_we_check from %c13_i5 : <i22> -> <i1>
      %334 = llhd.prb %io_div2_meas_ctrl_shadowed_we : i1
      llhd.drv %333, %334 after %1 : i1
      %335 = llhd.sig.extract %reg_we_check from %c14_i5 : <i22> -> <i1>
      %336 = llhd.prb %io_div4_meas_ctrl_en_we : i1
      llhd.drv %335, %336 after %1 : i1
      %337 = llhd.sig.extract %reg_we_check from %c15_i5 : <i22> -> <i1>
      %338 = llhd.prb %io_div4_meas_ctrl_shadowed_we : i1
      llhd.drv %337, %338 after %1 : i1
      %339 = llhd.sig.extract %reg_we_check from %c-16_i5 : <i22> -> <i1>
      %340 = llhd.prb %main_meas_ctrl_en_we : i1
      llhd.drv %339, %340 after %1 : i1
      %341 = llhd.sig.extract %reg_we_check from %c-15_i5 : <i22> -> <i1>
      %342 = llhd.prb %main_meas_ctrl_shadowed_we : i1
      llhd.drv %341, %342 after %1 : i1
      %343 = llhd.sig.extract %reg_we_check from %c-14_i5 : <i22> -> <i1>
      %344 = llhd.prb %usb_meas_ctrl_en_we : i1
      llhd.drv %343, %344 after %1 : i1
      %345 = llhd.sig.extract %reg_we_check from %c-13_i5 : <i22> -> <i1>
      %346 = llhd.prb %usb_meas_ctrl_shadowed_we : i1
      llhd.drv %345, %346 after %1 : i1
      %347 = llhd.sig.extract %reg_we_check from %c-12_i5 : <i22> -> <i1>
      %348 = llhd.prb %recov_err_code_we : i1
      llhd.drv %347, %348 after %1 : i1
      %349 = llhd.sig.extract %reg_we_check from %c-11_i5 : <i22> -> <i1>
      llhd.drv %349, %false after %1 : i1
      llhd.wait (%6, %40, %48, %49, %55, %56, %59, %69, %79, %11, %15, %18, %21, %24, %27, %30, %33, %35, %38, %127 : i22, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    %247 = llhd.prb %extclk_ctrl_sel_qs : i4
    %248 = llhd.prb %extclk_ctrl_hi_speed_sel_qs : i4
    %249 = llhd.prb %extclk_status_qs : i4
    %250 = llhd.prb %jitter_enable_qs : i4
    %251 = llhd.prb %clk_enables_clk_io_div4_peri_en_qs : i1
    %252 = llhd.prb %clk_enables_clk_io_div2_peri_en_qs : i1
    %253 = llhd.prb %clk_enables_clk_io_peri_en_qs : i1
    %254 = llhd.prb %clk_enables_clk_usb_peri_en_qs : i1
    %255 = llhd.prb %clk_hints_clk_main_aes_hint_qs : i1
    %256 = llhd.prb %clk_hints_clk_main_hmac_hint_qs : i1
    %257 = llhd.prb %clk_hints_clk_main_kmac_hint_qs : i1
    %258 = llhd.prb %clk_hints_clk_main_otbn_hint_qs : i1
    %259 = llhd.prb %clk_hints_status_clk_main_aes_val_qs : i1
    %260 = llhd.prb %clk_hints_status_clk_main_hmac_val_qs : i1
    %261 = llhd.prb %clk_hints_status_clk_main_kmac_val_qs : i1
    %262 = llhd.prb %clk_hints_status_clk_main_otbn_val_qs : i1
    %263 = llhd.prb %io_meas_ctrl_en_qs : i4
    %264 = llhd.prb %io_meas_ctrl_shadowed_qs : i20
    %265 = llhd.prb %io_div2_meas_ctrl_en_qs : i4
    %266 = llhd.prb %io_div2_meas_ctrl_shadowed_qs : i18
    %267 = llhd.prb %io_div4_meas_ctrl_en_qs : i4
    %268 = llhd.prb %io_div4_meas_ctrl_shadowed_qs : i16
    %269 = llhd.prb %main_meas_ctrl_en_qs : i4
    %270 = llhd.prb %main_meas_ctrl_shadowed_qs : i20
    %271 = llhd.prb %usb_meas_ctrl_en_qs : i4
    %272 = llhd.prb %usb_meas_ctrl_shadowed_qs : i18
    %273 = llhd.prb %recov_err_code_shadow_update_err_qs : i1
    %274 = llhd.prb %recov_err_code_io_measure_err_qs : i1
    %275 = llhd.prb %recov_err_code_io_div2_measure_err_qs : i1
    %276 = llhd.prb %recov_err_code_io_div4_measure_err_qs : i1
    %277 = llhd.prb %recov_err_code_main_measure_err_qs : i1
    %278 = llhd.prb %recov_err_code_usb_measure_err_qs : i1
    %279 = llhd.prb %recov_err_code_io_timeout_err_qs : i1
    %280 = llhd.prb %recov_err_code_io_div2_timeout_err_qs : i1
    %281 = llhd.prb %recov_err_code_io_div4_timeout_err_qs : i1
    %282 = llhd.prb %recov_err_code_main_timeout_err_qs : i1
    %283 = llhd.prb %recov_err_code_usb_timeout_err_qs : i1
    %284 = llhd.prb %fatal_err_code_reg_intg_qs : i1
    %285 = llhd.prb %fatal_err_code_idle_cnt_qs : i1
    %286 = llhd.prb %fatal_err_code_shadow_storage_err_qs : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb46
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      %309 = llhd.prb %addr_hit : i22
      %310 = comb.extract %309 from 0 : (i22) -> i1
      %311 = comb.icmp ceq %310, %true : i1
      cf.cond_br %311, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %312 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      llhd.drv %312, %false after %1 : i1
      %313 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      llhd.drv %313, %false after %1 : i1
      cf.br ^bb46
    ^bb3:  // pred: ^bb1
      %314 = llhd.prb %addr_hit : i22
      %315 = comb.extract %314 from 1 : (i22) -> i1
      %316 = comb.icmp ceq %315, %true : i1
      cf.cond_br %316, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %317 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %318 = llhd.prb %extclk_ctrl_regwen_qs : i1
      llhd.drv %317, %318 after %1 : i1
      cf.br ^bb46
    ^bb5:  // pred: ^bb3
      %319 = llhd.prb %addr_hit : i22
      %320 = comb.extract %319 from 2 : (i22) -> i1
      %321 = comb.icmp ceq %320, %true : i1
      cf.cond_br %321, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %322 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i4>
      %323 = llhd.prb %extclk_ctrl_sel_qs : i4
      llhd.drv %322, %323 after %1 : i4
      %324 = llhd.sig.extract %reg_rdata_next from %c4_i5 : <i32> -> <i4>
      %325 = llhd.prb %extclk_ctrl_hi_speed_sel_qs : i4
      llhd.drv %324, %325 after %1 : i4
      cf.br ^bb46
    ^bb7:  // pred: ^bb5
      %326 = llhd.prb %addr_hit : i22
      %327 = comb.extract %326 from 3 : (i22) -> i1
      %328 = comb.icmp ceq %327, %true : i1
      cf.cond_br %328, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %329 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i4>
      %330 = llhd.prb %extclk_status_qs : i4
      llhd.drv %329, %330 after %1 : i4
      cf.br ^bb46
    ^bb9:  // pred: ^bb7
      %331 = llhd.prb %addr_hit : i22
      %332 = comb.extract %331 from 4 : (i22) -> i1
      %333 = comb.icmp ceq %332, %true : i1
      cf.cond_br %333, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %334 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %335 = llhd.prb %jitter_regwen_qs : i1
      llhd.drv %334, %335 after %1 : i1
      cf.br ^bb46
    ^bb11:  // pred: ^bb9
      %336 = llhd.prb %addr_hit : i22
      %337 = comb.extract %336 from 5 : (i22) -> i1
      %338 = comb.icmp ceq %337, %true : i1
      cf.cond_br %338, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %339 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i4>
      %340 = llhd.prb %jitter_enable_qs : i4
      llhd.drv %339, %340 after %1 : i4
      cf.br ^bb46
    ^bb13:  // pred: ^bb11
      %341 = llhd.prb %addr_hit : i22
      %342 = comb.extract %341 from 6 : (i22) -> i1
      %343 = comb.icmp ceq %342, %true : i1
      cf.cond_br %343, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %344 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %345 = llhd.prb %clk_enables_clk_io_div4_peri_en_qs : i1
      llhd.drv %344, %345 after %1 : i1
      %346 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %347 = llhd.prb %clk_enables_clk_io_div2_peri_en_qs : i1
      llhd.drv %346, %347 after %1 : i1
      %348 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %349 = llhd.prb %clk_enables_clk_io_peri_en_qs : i1
      llhd.drv %348, %349 after %1 : i1
      %350 = llhd.sig.extract %reg_rdata_next from %c3_i5 : <i32> -> <i1>
      %351 = llhd.prb %clk_enables_clk_usb_peri_en_qs : i1
      llhd.drv %350, %351 after %1 : i1
      cf.br ^bb46
    ^bb15:  // pred: ^bb13
      %352 = llhd.prb %addr_hit : i22
      %353 = comb.extract %352 from 7 : (i22) -> i1
      %354 = comb.icmp ceq %353, %true : i1
      cf.cond_br %354, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      %355 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %356 = llhd.prb %clk_hints_clk_main_aes_hint_qs : i1
      llhd.drv %355, %356 after %1 : i1
      %357 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %358 = llhd.prb %clk_hints_clk_main_hmac_hint_qs : i1
      llhd.drv %357, %358 after %1 : i1
      %359 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %360 = llhd.prb %clk_hints_clk_main_kmac_hint_qs : i1
      llhd.drv %359, %360 after %1 : i1
      %361 = llhd.sig.extract %reg_rdata_next from %c3_i5 : <i32> -> <i1>
      %362 = llhd.prb %clk_hints_clk_main_otbn_hint_qs : i1
      llhd.drv %361, %362 after %1 : i1
      cf.br ^bb46
    ^bb17:  // pred: ^bb15
      %363 = llhd.prb %addr_hit : i22
      %364 = comb.extract %363 from 8 : (i22) -> i1
      %365 = comb.icmp ceq %364, %true : i1
      cf.cond_br %365, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      %366 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %367 = llhd.prb %clk_hints_status_clk_main_aes_val_qs : i1
      llhd.drv %366, %367 after %1 : i1
      %368 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %369 = llhd.prb %clk_hints_status_clk_main_hmac_val_qs : i1
      llhd.drv %368, %369 after %1 : i1
      %370 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %371 = llhd.prb %clk_hints_status_clk_main_kmac_val_qs : i1
      llhd.drv %370, %371 after %1 : i1
      %372 = llhd.sig.extract %reg_rdata_next from %c3_i5 : <i32> -> <i1>
      %373 = llhd.prb %clk_hints_status_clk_main_otbn_val_qs : i1
      llhd.drv %372, %373 after %1 : i1
      cf.br ^bb46
    ^bb19:  // pred: ^bb17
      %374 = llhd.prb %addr_hit : i22
      %375 = comb.extract %374 from 9 : (i22) -> i1
      %376 = comb.icmp ceq %375, %true : i1
      cf.cond_br %376, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      %377 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %378 = llhd.prb %measure_ctrl_regwen_qs : i1
      llhd.drv %377, %378 after %1 : i1
      cf.br ^bb46
    ^bb21:  // pred: ^bb19
      %379 = llhd.prb %addr_hit : i22
      %380 = comb.extract %379 from 10 : (i22) -> i1
      %381 = comb.icmp ceq %380, %true : i1
      cf.cond_br %381, ^bb22, ^bb23
    ^bb22:  // pred: ^bb21
      %382 = llhd.prb %io_meas_ctrl_en_qs : i4
      %383 = comb.concat %c0_i28, %382 : i28, i4
      llhd.drv %reg_rdata_next, %383 after %1 : i32
      cf.br ^bb46
    ^bb23:  // pred: ^bb21
      %384 = llhd.prb %addr_hit : i22
      %385 = comb.extract %384 from 11 : (i22) -> i1
      %386 = comb.icmp ceq %385, %true : i1
      cf.cond_br %386, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      %387 = llhd.prb %io_meas_ctrl_shadowed_qs : i20
      %388 = comb.concat %c0_i12, %387 : i12, i20
      llhd.drv %reg_rdata_next, %388 after %1 : i32
      cf.br ^bb46
    ^bb25:  // pred: ^bb23
      %389 = llhd.prb %addr_hit : i22
      %390 = comb.extract %389 from 12 : (i22) -> i1
      %391 = comb.icmp ceq %390, %true : i1
      cf.cond_br %391, ^bb26, ^bb27
    ^bb26:  // pred: ^bb25
      %392 = llhd.prb %io_div2_meas_ctrl_en_qs : i4
      %393 = comb.concat %c0_i28, %392 : i28, i4
      llhd.drv %reg_rdata_next, %393 after %1 : i32
      cf.br ^bb46
    ^bb27:  // pred: ^bb25
      %394 = llhd.prb %addr_hit : i22
      %395 = comb.extract %394 from 13 : (i22) -> i1
      %396 = comb.icmp ceq %395, %true : i1
      cf.cond_br %396, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      %397 = llhd.prb %io_div2_meas_ctrl_shadowed_qs : i18
      %398 = comb.concat %c0_i14, %397 : i14, i18
      llhd.drv %reg_rdata_next, %398 after %1 : i32
      cf.br ^bb46
    ^bb29:  // pred: ^bb27
      %399 = llhd.prb %addr_hit : i22
      %400 = comb.extract %399 from 14 : (i22) -> i1
      %401 = comb.icmp ceq %400, %true : i1
      cf.cond_br %401, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      %402 = llhd.prb %io_div4_meas_ctrl_en_qs : i4
      %403 = comb.concat %c0_i28, %402 : i28, i4
      llhd.drv %reg_rdata_next, %403 after %1 : i32
      cf.br ^bb46
    ^bb31:  // pred: ^bb29
      %404 = llhd.prb %addr_hit : i22
      %405 = comb.extract %404 from 15 : (i22) -> i1
      %406 = comb.icmp ceq %405, %true : i1
      cf.cond_br %406, ^bb32, ^bb33
    ^bb32:  // pred: ^bb31
      %407 = llhd.prb %io_div4_meas_ctrl_shadowed_qs : i16
      %408 = comb.concat %c0_i16, %407 : i16, i16
      llhd.drv %reg_rdata_next, %408 after %1 : i32
      cf.br ^bb46
    ^bb33:  // pred: ^bb31
      %409 = llhd.prb %addr_hit : i22
      %410 = comb.extract %409 from 16 : (i22) -> i1
      %411 = comb.icmp ceq %410, %true : i1
      cf.cond_br %411, ^bb34, ^bb35
    ^bb34:  // pred: ^bb33
      %412 = llhd.prb %main_meas_ctrl_en_qs : i4
      %413 = comb.concat %c0_i28, %412 : i28, i4
      llhd.drv %reg_rdata_next, %413 after %1 : i32
      cf.br ^bb46
    ^bb35:  // pred: ^bb33
      %414 = llhd.prb %addr_hit : i22
      %415 = comb.extract %414 from 17 : (i22) -> i1
      %416 = comb.icmp ceq %415, %true : i1
      cf.cond_br %416, ^bb36, ^bb37
    ^bb36:  // pred: ^bb35
      %417 = llhd.prb %main_meas_ctrl_shadowed_qs : i20
      %418 = comb.concat %c0_i12, %417 : i12, i20
      llhd.drv %reg_rdata_next, %418 after %1 : i32
      cf.br ^bb46
    ^bb37:  // pred: ^bb35
      %419 = llhd.prb %addr_hit : i22
      %420 = comb.extract %419 from 18 : (i22) -> i1
      %421 = comb.icmp ceq %420, %true : i1
      cf.cond_br %421, ^bb38, ^bb39
    ^bb38:  // pred: ^bb37
      %422 = llhd.prb %usb_meas_ctrl_en_qs : i4
      %423 = comb.concat %c0_i28, %422 : i28, i4
      llhd.drv %reg_rdata_next, %423 after %1 : i32
      cf.br ^bb46
    ^bb39:  // pred: ^bb37
      %424 = llhd.prb %addr_hit : i22
      %425 = comb.extract %424 from 19 : (i22) -> i1
      %426 = comb.icmp ceq %425, %true : i1
      cf.cond_br %426, ^bb40, ^bb41
    ^bb40:  // pred: ^bb39
      %427 = llhd.prb %usb_meas_ctrl_shadowed_qs : i18
      %428 = comb.concat %c0_i14, %427 : i14, i18
      llhd.drv %reg_rdata_next, %428 after %1 : i32
      cf.br ^bb46
    ^bb41:  // pred: ^bb39
      %429 = llhd.prb %addr_hit : i22
      %430 = comb.extract %429 from 20 : (i22) -> i1
      %431 = comb.icmp ceq %430, %true : i1
      cf.cond_br %431, ^bb42, ^bb43
    ^bb42:  // pred: ^bb41
      %432 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %433 = llhd.prb %recov_err_code_shadow_update_err_qs : i1
      llhd.drv %432, %433 after %1 : i1
      %434 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %435 = llhd.prb %recov_err_code_io_measure_err_qs : i1
      llhd.drv %434, %435 after %1 : i1
      %436 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %437 = llhd.prb %recov_err_code_io_div2_measure_err_qs : i1
      llhd.drv %436, %437 after %1 : i1
      %438 = llhd.sig.extract %reg_rdata_next from %c3_i5 : <i32> -> <i1>
      %439 = llhd.prb %recov_err_code_io_div4_measure_err_qs : i1
      llhd.drv %438, %439 after %1 : i1
      %440 = llhd.sig.extract %reg_rdata_next from %c4_i5 : <i32> -> <i1>
      %441 = llhd.prb %recov_err_code_main_measure_err_qs : i1
      llhd.drv %440, %441 after %1 : i1
      %442 = llhd.sig.extract %reg_rdata_next from %c5_i5 : <i32> -> <i1>
      %443 = llhd.prb %recov_err_code_usb_measure_err_qs : i1
      llhd.drv %442, %443 after %1 : i1
      %444 = llhd.sig.extract %reg_rdata_next from %c6_i5 : <i32> -> <i1>
      %445 = llhd.prb %recov_err_code_io_timeout_err_qs : i1
      llhd.drv %444, %445 after %1 : i1
      %446 = llhd.sig.extract %reg_rdata_next from %c7_i5 : <i32> -> <i1>
      %447 = llhd.prb %recov_err_code_io_div2_timeout_err_qs : i1
      llhd.drv %446, %447 after %1 : i1
      %448 = llhd.sig.extract %reg_rdata_next from %c8_i5 : <i32> -> <i1>
      %449 = llhd.prb %recov_err_code_io_div4_timeout_err_qs : i1
      llhd.drv %448, %449 after %1 : i1
      %450 = llhd.sig.extract %reg_rdata_next from %c9_i5 : <i32> -> <i1>
      %451 = llhd.prb %recov_err_code_main_timeout_err_qs : i1
      llhd.drv %450, %451 after %1 : i1
      %452 = llhd.sig.extract %reg_rdata_next from %c10_i5 : <i32> -> <i1>
      %453 = llhd.prb %recov_err_code_usb_timeout_err_qs : i1
      llhd.drv %452, %453 after %1 : i1
      cf.br ^bb46
    ^bb43:  // pred: ^bb41
      %454 = llhd.prb %addr_hit : i22
      %455 = comb.extract %454 from 21 : (i22) -> i1
      %456 = comb.icmp ceq %455, %true : i1
      cf.cond_br %456, ^bb44, ^bb45
    ^bb44:  // pred: ^bb43
      %457 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %458 = llhd.prb %fatal_err_code_reg_intg_qs : i1
      llhd.drv %457, %458 after %1 : i1
      %459 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %460 = llhd.prb %fatal_err_code_idle_cnt_qs : i1
      llhd.drv %459, %460 after %1 : i1
      %461 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %462 = llhd.prb %fatal_err_code_shadow_storage_err_qs : i1
      llhd.drv %461, %462 after %1 : i1
      cf.br ^bb46
    ^bb45:  // pred: ^bb43
      llhd.drv %reg_rdata_next, %c-1_i32 after %1 : i32
      cf.br ^bb46
    ^bb46:  // 23 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb18, ^bb20, ^bb22, ^bb24, ^bb26, ^bb28, ^bb30, ^bb32, ^bb34, ^bb36, ^bb38, ^bb40, ^bb42, ^bb44, ^bb45
      llhd.wait (%139, %185, %166, %247, %248, %249, %168, %250, %251, %252, %253, %254, %255, %256, %257, %258, %259, %260, %261, %262, %10, %263, %264, %265, %266, %267, %268, %269, %270, %271, %272, %273, %274, %275, %276, %277, %278, %279, %280, %281, %282, %283, %284, %285, %286 : i32, i22, i1, i4, i4, i4, i1, i4, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i4, i20, i4, i18, i4, i16, i4, i20, i4, i18, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %309 = llhd.prb %clk_i_0 : i1
      %310 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %311 = llhd.prb %clk_i_0 : i1
      %312 = comb.xor bin %309, %true : i1
      %313 = comb.and bin %312, %311 : i1
      %314 = llhd.prb %rst_ni_1 : i1
      %315 = comb.xor bin %314, %true : i1
      %316 = comb.and bin %310, %315 : i1
      %317 = comb.or bin %313, %316 : i1
      cf.cond_br %317, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %318 = llhd.prb %rst_ni_1 : i1
      %319 = comb.xor %318, %true : i1
      cf.cond_br %319, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %rst_done, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      llhd.drv %rst_done, %true after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %309 = llhd.prb %clk_i_0 : i1
      %310 = llhd.prb %rst_shadowed_ni_2 : i1
      llhd.wait (%3, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %311 = llhd.prb %clk_i_0 : i1
      %312 = comb.xor bin %309, %true : i1
      %313 = comb.and bin %312, %311 : i1
      %314 = llhd.prb %rst_shadowed_ni_2 : i1
      %315 = comb.xor bin %314, %true : i1
      %316 = comb.and bin %310, %315 : i1
      %317 = comb.or bin %313, %316 : i1
      cf.cond_br %317, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %318 = llhd.prb %rst_shadowed_ni_2 : i1
      %319 = comb.xor %318, %true : i1
      cf.cond_br %319, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %shadow_rst_done, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      llhd.drv %shadow_rst_done, %true after %0 : i1
      cf.br ^bb1
    }
    %287 = llhd.prb %rst_done : i1
    %288 = llhd.prb %shadow_rst_done : i1
    %289 = comb.and %287, %288 : i1
    %290 = comb.xor %289, %true {sv.namehint = "shadow_busy"} : i1
    %291 = comb.concat %u_io_meas_ctrl_shadowed_hi_err_storage_sync.q_o, %u_io_meas_ctrl_shadowed_lo_err_storage_sync.q_o, %u_io_div2_meas_ctrl_shadowed_hi_err_storage_sync.q_o, %u_io_div2_meas_ctrl_shadowed_lo_err_storage_sync.q_o, %u_io_div4_meas_ctrl_shadowed_hi_err_storage_sync.q_o, %u_io_div4_meas_ctrl_shadowed_lo_err_storage_sync.q_o, %u_main_meas_ctrl_shadowed_hi_err_storage_sync.q_o, %u_main_meas_ctrl_shadowed_lo_err_storage_sync.q_o, %u_usb_meas_ctrl_shadowed_hi_err_storage_sync.q_o, %u_usb_meas_ctrl_shadowed_lo_err_storage_sync.q_o : i1, i1, i1, i1, i1, i1, i1, i1, i1, i1
    %292 = comb.icmp ne %291, %c0_i10 : i10
    %293 = comb.concat %u_io_meas_ctrl_shadowed_hi_err_update_sync.dst_pulse_o, %u_io_meas_ctrl_shadowed_lo_err_update_sync.dst_pulse_o, %u_io_div2_meas_ctrl_shadowed_hi_err_update_sync.dst_pulse_o, %u_io_div2_meas_ctrl_shadowed_lo_err_update_sync.dst_pulse_o, %u_io_div4_meas_ctrl_shadowed_hi_err_update_sync.dst_pulse_o, %u_io_div4_meas_ctrl_shadowed_lo_err_update_sync.dst_pulse_o, %u_main_meas_ctrl_shadowed_hi_err_update_sync.dst_pulse_o, %u_main_meas_ctrl_shadowed_lo_err_update_sync.dst_pulse_o, %u_usb_meas_ctrl_shadowed_hi_err_update_sync.dst_pulse_o, %u_usb_meas_ctrl_shadowed_lo_err_update_sync.dst_pulse_o : i1, i1, i1, i1, i1, i1, i1, i1, i1, i1
    %294 = comb.icmp ne %293, %c0_i10 : i10
    %295 = llhd.prb %reg_busy_sel : i1
    %296 = comb.or %295, %290 : i1
    %a_valid = hw.struct_extract %tl_i["a_valid"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %297 = comb.and %296, %a_valid {sv.namehint = "reg_busy"} : i1
    %298 = llhd.prb %io_meas_ctrl_en_busy : i1
    %299 = llhd.prb %io_meas_ctrl_shadowed_busy : i1
    %300 = llhd.prb %io_div2_meas_ctrl_en_busy : i1
    %301 = llhd.prb %io_div2_meas_ctrl_shadowed_busy : i1
    %302 = llhd.prb %io_div4_meas_ctrl_en_busy : i1
    %303 = llhd.prb %io_div4_meas_ctrl_shadowed_busy : i1
    %304 = llhd.prb %main_meas_ctrl_en_busy : i1
    %305 = llhd.prb %main_meas_ctrl_shadowed_busy : i1
    %306 = llhd.prb %usb_meas_ctrl_en_busy : i1
    %307 = llhd.prb %usb_meas_ctrl_shadowed_busy : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb22
      llhd.drv %reg_busy_sel, %false after %1 : i1
      %309 = llhd.prb %addr_hit : i22
      %310 = comb.extract %309 from 10 : (i22) -> i1
      %311 = comb.icmp ceq %310, %true : i1
      cf.cond_br %311, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %312 = llhd.prb %io_meas_ctrl_en_busy : i1
      llhd.drv %reg_busy_sel, %312 after %1 : i1
      cf.br ^bb22
    ^bb3:  // pred: ^bb1
      %313 = llhd.prb %addr_hit : i22
      %314 = comb.extract %313 from 11 : (i22) -> i1
      %315 = comb.icmp ceq %314, %true : i1
      cf.cond_br %315, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %316 = llhd.prb %io_meas_ctrl_shadowed_busy : i1
      llhd.drv %reg_busy_sel, %316 after %1 : i1
      cf.br ^bb22
    ^bb5:  // pred: ^bb3
      %317 = llhd.prb %addr_hit : i22
      %318 = comb.extract %317 from 12 : (i22) -> i1
      %319 = comb.icmp ceq %318, %true : i1
      cf.cond_br %319, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %320 = llhd.prb %io_div2_meas_ctrl_en_busy : i1
      llhd.drv %reg_busy_sel, %320 after %1 : i1
      cf.br ^bb22
    ^bb7:  // pred: ^bb5
      %321 = llhd.prb %addr_hit : i22
      %322 = comb.extract %321 from 13 : (i22) -> i1
      %323 = comb.icmp ceq %322, %true : i1
      cf.cond_br %323, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %324 = llhd.prb %io_div2_meas_ctrl_shadowed_busy : i1
      llhd.drv %reg_busy_sel, %324 after %1 : i1
      cf.br ^bb22
    ^bb9:  // pred: ^bb7
      %325 = llhd.prb %addr_hit : i22
      %326 = comb.extract %325 from 14 : (i22) -> i1
      %327 = comb.icmp ceq %326, %true : i1
      cf.cond_br %327, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %328 = llhd.prb %io_div4_meas_ctrl_en_busy : i1
      llhd.drv %reg_busy_sel, %328 after %1 : i1
      cf.br ^bb22
    ^bb11:  // pred: ^bb9
      %329 = llhd.prb %addr_hit : i22
      %330 = comb.extract %329 from 15 : (i22) -> i1
      %331 = comb.icmp ceq %330, %true : i1
      cf.cond_br %331, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %332 = llhd.prb %io_div4_meas_ctrl_shadowed_busy : i1
      llhd.drv %reg_busy_sel, %332 after %1 : i1
      cf.br ^bb22
    ^bb13:  // pred: ^bb11
      %333 = llhd.prb %addr_hit : i22
      %334 = comb.extract %333 from 16 : (i22) -> i1
      %335 = comb.icmp ceq %334, %true : i1
      cf.cond_br %335, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %336 = llhd.prb %main_meas_ctrl_en_busy : i1
      llhd.drv %reg_busy_sel, %336 after %1 : i1
      cf.br ^bb22
    ^bb15:  // pred: ^bb13
      %337 = llhd.prb %addr_hit : i22
      %338 = comb.extract %337 from 17 : (i22) -> i1
      %339 = comb.icmp ceq %338, %true : i1
      cf.cond_br %339, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      %340 = llhd.prb %main_meas_ctrl_shadowed_busy : i1
      llhd.drv %reg_busy_sel, %340 after %1 : i1
      cf.br ^bb22
    ^bb17:  // pred: ^bb15
      %341 = llhd.prb %addr_hit : i22
      %342 = comb.extract %341 from 18 : (i22) -> i1
      %343 = comb.icmp ceq %342, %true : i1
      cf.cond_br %343, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      %344 = llhd.prb %usb_meas_ctrl_en_busy : i1
      llhd.drv %reg_busy_sel, %344 after %1 : i1
      cf.br ^bb22
    ^bb19:  // pred: ^bb17
      %345 = llhd.prb %addr_hit : i22
      %346 = comb.extract %345 from 19 : (i22) -> i1
      %347 = comb.icmp ceq %346, %true : i1
      cf.cond_br %347, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      %348 = llhd.prb %usb_meas_ctrl_shadowed_busy : i1
      llhd.drv %reg_busy_sel, %348 after %1 : i1
      cf.br ^bb22
    ^bb21:  // pred: ^bb19
      llhd.drv %reg_busy_sel, %false after %1 : i1
      cf.br ^bb22
    ^bb22:  // 11 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb18, ^bb20, ^bb21
      llhd.wait (%295, %185, %298, %299, %300, %301, %302, %303, %304, %305, %306, %307 : i1, i22, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %rst_shadowed_ni_2, %rst_shadowed_ni after %1 : i1
    %308 = llhd.prb %reg2hw : !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
    hw.output %u_rsp_intg_gen.tl_o, %308, %292, %294, %138 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>, i1, i1, i1
  }
  hw.module private @clkmgr_root_ctrl(in %clk_i : i1, in %rst_ni : i1, in %scanmode_i : i4, in %async_en_i : i1, out en_o : i1, out clk_o : i1) {
    %u_scanmode_sync.mubi_o = hw.instance "u_scanmode_sync" @prim_mubi4_sync_0(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, mubi_i: %scanmode_i: i4) -> (mubi_o: !hw.array<1xi4>)
    %0 = hw.bitcast %u_scanmode_sync.mubi_o {sv.namehint = "scanmode"} : (!hw.array<1xi4>) -> i4
    %1 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%0) : (i4) -> i1
    %u_cg.en_o, %u_cg.clk_o = hw.instance "u_cg" @prim_clock_gating_sync(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, test_en_i: %1: i1, async_en_i: %async_en_i: i1) -> (en_o: i1, clk_o: i1)
    hw.output %u_cg.en_o, %u_cg.clk_o : i1, i1
  }
  hw.module @clkmgr(in %clk_i : i1, in %rst_ni : i1, in %rst_shadowed_ni : i1, in %clk_main_i : i1, in %rst_main_ni : i1, in %clk_io_i : i1, in %rst_io_ni : i1, in %clk_usb_i : i1, in %rst_usb_ni : i1, in %clk_aon_i : i1, in %rst_aon_ni : i1, in %rst_io_div2_ni : i1, in %rst_io_div4_ni : i1, in %rst_root_ni : i1, in %rst_root_main_ni : i1, in %rst_root_io_ni : i1, in %rst_root_io_div2_ni : i1, in %rst_root_io_div4_ni : i1, in %rst_root_usb_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %alert_rx_i : !hw.array<2xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, out alert_tx_o : !hw.array<2xstruct<alert_p: i1, alert_n: i1>>, in %pwr_i : !hw.struct<main_ip_clk_en: i1, io_ip_clk_en: i1, usb_ip_clk_en: i1>, out pwr_o : !hw.struct<main_status: i1, io_status: i1, usb_status: i1>, in %scanmode_i : i4, in %idle_i : !hw.array<4xi4>, in %lc_hw_debug_en_i : i4, in %lc_clk_byp_req_i : i4, out lc_clk_byp_ack_o : i4, out io_clk_byp_req_o : i4, in %io_clk_byp_ack_i : i4, out all_clk_byp_req_o : i4, in %all_clk_byp_ack_i : i4, out hi_speed_sel_o : i4, in %div_step_down_req_i : i4, in %calib_rdy_i : i4, out jitter_en_o : i4, out cg_en_o : !hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>, out clocks_o : !hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>) {
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %c-3_i3 = hw.constant -3 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c3_i3 = hw.constant 3 : i3
    %c2_i3 = hw.constant 2 : i3
    %c1_i3 = hw.constant 1 : i3
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i0 = hw.constant 0 : i0
    %c0_i4 = hw.constant 0 : i4
    %1 = hw.aggregate_constant [0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4] : !hw.array<6xi4>
    %c0_i3 = hw.constant 0 : i3
    %2 = hw.aggregate_constant [[0 : i4], [[false, false], [false, false], [false, false], [false, false]], [false, false], [0 : i4, false], [0 : i4, false], [0 : i4, false], [0 : i4, false], [0 : i4, false], [[false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false]], [[false, false], [false, false], [false, false]]] : !hw.struct<extclk_status: !hw.struct<d: i4>, clk_hints_status: !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>, measure_ctrl_regwen: !hw.struct<d: i1, de: i1>, io_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div2_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div4_meas_ctrl_en: !hw.struct<d: i4, de: i1>, main_meas_ctrl_en: !hw.struct<d: i4, de: i1>, usb_meas_ctrl_en: !hw.struct<d: i4, de: i1>, recov_err_code: !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>
    %3 = hw.aggregate_constant [[[false, false], [false, false]], [[0 : i4], [0 : i4]], [0 : i4], [[false], [false], [false], [false]], [[false], [false], [false], [false]], [false], [0 : i4], [[0 : i10], [0 : i10]], [0 : i4], [[0 : i9], [0 : i9]], [0 : i4], [[0 : i8], [0 : i8]], [0 : i4], [[0 : i10], [0 : i10]], [0 : i4], [[0 : i9], [0 : i9]], [[false], [false], [false]]] : !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
    %c0_i2 = hw.constant 0 : i2
    %4 = hw.aggregate_constant [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false] : !hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>
    %5 = hw.aggregate_constant [0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4, 0 : i4] : !hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>
    %6 = hw.aggregate_constant [false, false, false] : !hw.struct<main_status: i1, io_status: i1, usb_status: i1>
    %false = hw.constant false
    %true = hw.constant true
    %c6_i4 = hw.constant 6 : i4
    %c-7_i4 = hw.constant -7 : i4
    %7 = hw.aggregate_constant [[false, false], [false, false]] : !hw.array<2xstruct<alert_p: i1, alert_n: i1>>
    %alert_tx_o = llhd.sig %7 : !hw.array<2xstruct<alert_p: i1, alert_n: i1>>
    %pwr_o = llhd.sig %6 : !hw.struct<main_status: i1, io_status: i1, usb_status: i1>
    %cg_en_o = llhd.sig %5 : !hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>
    %clocks_o = llhd.sig %4 : !hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>
    %step_down_acks = llhd.sig %c0_i2 : i2
    %reg2hw = llhd.sig %3 : !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
    %hw2reg = llhd.sig %2 : !hw.struct<extclk_status: !hw.struct<d: i4>, clk_hints_status: !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>, measure_ctrl_regwen: !hw.struct<d: i1, de: i1>, io_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div2_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div4_meas_ctrl_en: !hw.struct<d: i4, de: i1>, main_meas_ctrl_en: !hw.struct<d: i4, de: i1>, usb_meas_ctrl_en: !hw.struct<d: i4, de: i1>, recov_err_code: !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>
    %main_ens = llhd.sig %false : i1
    %io_ens = llhd.sig %c0_i3 : i3
    %usb_ens = llhd.sig %false : i1
    %calib_rdy = llhd.sig %1 : !hw.array<6xi4>
    %idle_cnt_err = llhd.sig %c0_i4 : i4
    %u_clk_main_buf.clk_o = hw.instance "u_clk_main_buf" @prim_clock_buf(clk_i: %clk_main_i: i1) -> (clk_o: i1) {sv.namehint = "clk_main"}
    %u_clk_io_buf.clk_o = hw.instance "u_clk_io_buf" @prim_clock_buf(clk_i: %clk_io_i: i1) -> (clk_o: i1) {sv.namehint = "clk_io"}
    %u_clk_usb_buf.clk_o = hw.instance "u_clk_usb_buf" @prim_clock_buf(clk_i: %clk_usb_i: i1) -> (clk_o: i1) {sv.namehint = "clk_usb"}
    %u_clk_aon_buf.clk_o = hw.instance "u_clk_aon_buf" @prim_clock_buf(clk_i: %clk_aon_i: i1) -> (clk_o: i1) {sv.namehint = "clk_aon"}
    %u_io_step_down_req_sync.mubi_o = hw.instance "u_io_step_down_req_sync" @prim_mubi4_sync(clk_i: %u_clk_io_buf.clk_o: i1, rst_ni: %rst_io_ni: i1, mubi_i: %div_step_down_req_i: i4) -> (mubi_o: !hw.array<1xi4>)
    %8 = hw.bitcast %u_io_step_down_req_sync.mubi_o {sv.namehint = "io_step_down_req"} : (!hw.array<1xi4>) -> i4
    %u_io_div2_div_scanmode_sync.mubi_o = hw.instance "u_io_div2_div_scanmode_sync" @prim_mubi4_sync_0(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, mubi_i: %scanmode_i: i4) -> (mubi_o: !hw.array<1xi4>)
    %9 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%8) : (i4) -> i1
    %10 = llhd.sig.extract %step_down_acks from %false : <i2> -> <i1>
    %11 = hw.array_get %u_io_div2_div_scanmode_sync.mubi_o[%c0_i0] : !hw.array<1xi4>, i0
    %12 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%11) : (i4) -> i1
    %u_no_scan_io_div2_div.step_down_ack_o, %u_no_scan_io_div2_div.clk_o = hw.instance "u_no_scan_io_div2_div" @prim_clock_div(clk_i: %clk_io_i: i1, rst_ni: %rst_root_io_ni: i1, step_down_req_i: %9: i1, test_en_i: %12: i1) -> (step_down_ack_o: i1, clk_o: i1) {sv.namehint = "clk_io_div2"}
    llhd.drv %10, %u_no_scan_io_div2_div.step_down_ack_o after %0 : i1
    %u_io_div4_div_scanmode_sync.mubi_o = hw.instance "u_io_div4_div_scanmode_sync" @prim_mubi4_sync_0(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, mubi_i: %scanmode_i: i4) -> (mubi_o: !hw.array<1xi4>)
    %13 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%8) : (i4) -> i1
    %14 = llhd.sig.extract %step_down_acks from %true : <i2> -> <i1>
    %15 = hw.array_get %u_io_div4_div_scanmode_sync.mubi_o[%c0_i0] : !hw.array<1xi4>, i0
    %16 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%15) : (i4) -> i1
    %u_no_scan_io_div4_div.step_down_ack_o, %u_no_scan_io_div4_div.clk_o = hw.instance "u_no_scan_io_div4_div" @prim_clock_div_1(clk_i: %clk_io_i: i1, rst_ni: %rst_root_io_ni: i1, step_down_req_i: %13: i1, test_en_i: %16: i1) -> (step_down_ack_o: i1, clk_o: i1) {sv.namehint = "clk_io_div4"}
    llhd.drv %14, %u_no_scan_io_div4_div.step_down_ack_o after %0 : i1
    %17 = llhd.prb %hw2reg : !hw.struct<extclk_status: !hw.struct<d: i4>, clk_hints_status: !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>, measure_ctrl_regwen: !hw.struct<d: i1, de: i1>, io_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div2_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div4_meas_ctrl_en: !hw.struct<d: i4, de: i1>, main_meas_ctrl_en: !hw.struct<d: i4, de: i1>, usb_meas_ctrl_en: !hw.struct<d: i4, de: i1>, recov_err_code: !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>
    %18 = llhd.sig.struct_extract %hw2reg["fatal_err_code"] : <!hw.struct<extclk_status: !hw.struct<d: i4>, clk_hints_status: !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>, measure_ctrl_regwen: !hw.struct<d: i1, de: i1>, io_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div2_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div4_meas_ctrl_en: !hw.struct<d: i4, de: i1>, main_meas_ctrl_en: !hw.struct<d: i4, de: i1>, usb_meas_ctrl_en: !hw.struct<d: i4, de: i1>, recov_err_code: !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>>
    %19 = llhd.sig.struct_extract %18["shadow_storage_err"] : <!hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>
    %20 = llhd.sig.struct_extract %19["de"] : <!hw.struct<d: i1, de: i1>>
    %21 = llhd.sig.struct_extract %hw2reg["recov_err_code"] : <!hw.struct<extclk_status: !hw.struct<d: i4>, clk_hints_status: !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>, measure_ctrl_regwen: !hw.struct<d: i1, de: i1>, io_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div2_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div4_meas_ctrl_en: !hw.struct<d: i4, de: i1>, main_meas_ctrl_en: !hw.struct<d: i4, de: i1>, usb_meas_ctrl_en: !hw.struct<d: i4, de: i1>, recov_err_code: !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>>
    %22 = llhd.sig.struct_extract %21["shadow_update_err"] : <!hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>>
    %23 = llhd.sig.struct_extract %22["de"] : <!hw.struct<d: i1, de: i1>>
    %24 = llhd.sig.struct_extract %18["reg_intg"] : <!hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>
    %25 = llhd.sig.struct_extract %24["de"] : <!hw.struct<d: i1, de: i1>>
    %u_reg.tl_o, %u_reg.reg2hw, %u_reg.shadowed_storage_err_o, %u_reg.shadowed_update_err_o, %u_reg.intg_err_o = hw.instance "u_reg" @clkmgr_reg_top(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, rst_shadowed_ni: %rst_shadowed_ni: i1, clk_io_i: %u_clk_io_buf.clk_o: i1, rst_io_ni: %rst_io_ni: i1, clk_io_div2_i: %u_no_scan_io_div2_div.clk_o: i1, rst_io_div2_ni: %rst_io_div2_ni: i1, clk_io_div4_i: %u_no_scan_io_div4_div.clk_o: i1, rst_io_div4_ni: %rst_io_div4_ni: i1, clk_main_i: %u_clk_main_buf.clk_o: i1, rst_main_ni: %rst_main_ni: i1, clk_usb_i: %u_clk_usb_buf.clk_o: i1, rst_usb_ni: %rst_usb_ni: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, hw2reg: %17: !hw.struct<extclk_status: !hw.struct<d: i4>, clk_hints_status: !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>, measure_ctrl_regwen: !hw.struct<d: i1, de: i1>, io_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div2_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div4_meas_ctrl_en: !hw.struct<d: i4, de: i1>, main_meas_ctrl_en: !hw.struct<d: i4, de: i1>, usb_meas_ctrl_en: !hw.struct<d: i4, de: i1>, recov_err_code: !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, reg2hw: !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>, shadowed_storage_err_o: i1, shadowed_update_err_o: i1, intg_err_o: i1)
    llhd.drv %reg2hw, %u_reg.reg2hw after %0 : !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
    llhd.drv %20, %u_reg.shadowed_storage_err_o after %0 : i1
    llhd.drv %23, %u_reg.shadowed_update_err_o after %0 : i1
    llhd.drv %25, %u_reg.intg_err_o after %0 : i1
    %26 = hw.array_get %alert_rx_i[%false] : !hw.array<2xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, i1
    %27 = llhd.sig.array_get %alert_tx_o[%false] : <!hw.array<2xstruct<alert_p: i1, alert_n: i1>>>
    %gen_alert_tx_0.u_prim_alert_sender.alert_ack_o, %gen_alert_tx_0.u_prim_alert_sender.alert_state_o, %gen_alert_tx_0.u_prim_alert_sender.alert_tx_o = hw.instance "gen_alert_tx_0.u_prim_alert_sender" @prim_alert_sender(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, alert_test_i: %167: i1, alert_req_i: %168: i1, alert_rx_i: %26: !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>) -> (alert_ack_o: i1, alert_state_o: i1, alert_tx_o: !hw.struct<alert_p: i1, alert_n: i1>)
    llhd.drv %27, %gen_alert_tx_0.u_prim_alert_sender.alert_tx_o after %0 : !hw.struct<alert_p: i1, alert_n: i1>
    %28 = hw.array_get %alert_rx_i[%true] : !hw.array<2xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, i1
    %29 = llhd.sig.array_get %alert_tx_o[%true] : <!hw.array<2xstruct<alert_p: i1, alert_n: i1>>>
    %gen_alert_tx_1.u_prim_alert_sender.alert_ack_o, %gen_alert_tx_1.u_prim_alert_sender.alert_state_o, %gen_alert_tx_1.u_prim_alert_sender.alert_tx_o = hw.instance "gen_alert_tx_1.u_prim_alert_sender" @prim_alert_sender_2(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, alert_test_i: %166: i1, alert_req_i: %170: i1, alert_rx_i: %28: !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>) -> (alert_ack_o: i1, alert_state_o: i1, alert_tx_o: !hw.struct<alert_p: i1, alert_n: i1>)
    llhd.drv %29, %gen_alert_tx_1.u_prim_alert_sender.alert_tx_o after %0 : !hw.struct<alert_p: i1, alert_n: i1>
    %30 = llhd.sig.struct_extract %hw2reg["extclk_status"] : <!hw.struct<extclk_status: !hw.struct<d: i4>, clk_hints_status: !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>, measure_ctrl_regwen: !hw.struct<d: i1, de: i1>, io_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div2_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div4_meas_ctrl_en: !hw.struct<d: i4, de: i1>, main_meas_ctrl_en: !hw.struct<d: i4, de: i1>, usb_meas_ctrl_en: !hw.struct<d: i4, de: i1>, recov_err_code: !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>>
    %31 = llhd.sig.struct_extract %30["d"] : <!hw.struct<d: i4>>
    %32 = llhd.prb %step_down_acks : i2
    %u_clkmgr_byp.lc_clk_byp_ack_o, %u_clkmgr_byp.byp_ack_o, %u_clkmgr_byp.all_clk_byp_req_o, %u_clkmgr_byp.io_clk_byp_req_o, %u_clkmgr_byp.hi_speed_sel_o = hw.instance "u_clkmgr_byp" @clkmgr_byp(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, en_i: %lc_hw_debug_en_i: i4, lc_clk_byp_req_i: %lc_clk_byp_req_i: i4, byp_req_i: %q_43: i4, hi_speed_sel_i: %q_44: i4, all_clk_byp_ack_i: %all_clk_byp_ack_i: i4, io_clk_byp_ack_i: %io_clk_byp_ack_i: i4, step_down_acks_i: %32: i2) -> (lc_clk_byp_ack_o: i4, byp_ack_o: i4, all_clk_byp_req_o: i4, io_clk_byp_req_o: i4, hi_speed_sel_o: i4)
    llhd.drv %31, %u_clkmgr_byp.byp_ack_o after %0 : i4
    %33 = llhd.sig.struct_extract %clocks_o["clk_io_div4_powerup"] : <!hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>>
    %u_clk_io_div4_powerup_buf.clk_o = hw.instance "u_clk_io_div4_powerup_buf" @prim_clock_buf_3(clk_i: %u_no_scan_io_div4_div.clk_o: i1) -> (clk_o: i1)
    llhd.drv %33, %u_clk_io_div4_powerup_buf.clk_o after %0 : i1
    %34 = llhd.sig.struct_extract %clocks_o["clk_aon_powerup"] : <!hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>>
    %u_clk_aon_powerup_buf.clk_o = hw.instance "u_clk_aon_powerup_buf" @prim_clock_buf_3(clk_i: %u_clk_aon_buf.clk_o: i1) -> (clk_o: i1)
    llhd.drv %34, %u_clk_aon_powerup_buf.clk_o after %0 : i1
    %35 = llhd.sig.struct_extract %clocks_o["clk_main_powerup"] : <!hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>>
    %u_clk_main_powerup_buf.clk_o = hw.instance "u_clk_main_powerup_buf" @prim_clock_buf_3(clk_i: %u_clk_main_buf.clk_o: i1) -> (clk_o: i1)
    llhd.drv %35, %u_clk_main_powerup_buf.clk_o after %0 : i1
    %36 = llhd.sig.struct_extract %clocks_o["clk_io_powerup"] : <!hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>>
    %u_clk_io_powerup_buf.clk_o = hw.instance "u_clk_io_powerup_buf" @prim_clock_buf_3(clk_i: %u_clk_io_buf.clk_o: i1) -> (clk_o: i1)
    llhd.drv %36, %u_clk_io_powerup_buf.clk_o after %0 : i1
    %37 = llhd.sig.struct_extract %clocks_o["clk_usb_powerup"] : <!hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>>
    %u_clk_usb_powerup_buf.clk_o = hw.instance "u_clk_usb_powerup_buf" @prim_clock_buf_3(clk_i: %u_clk_usb_buf.clk_o: i1) -> (clk_o: i1)
    llhd.drv %37, %u_clk_usb_powerup_buf.clk_o after %0 : i1
    %38 = llhd.sig.struct_extract %clocks_o["clk_io_div2_powerup"] : <!hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>>
    %u_clk_io_div2_powerup_buf.clk_o = hw.instance "u_clk_io_div2_powerup_buf" @prim_clock_buf_3(clk_i: %u_no_scan_io_div2_div.clk_o: i1) -> (clk_o: i1)
    llhd.drv %38, %u_clk_io_div2_powerup_buf.clk_o after %0 : i1
    %39 = llhd.sig.struct_extract %clocks_o["clk_aon_secure"] : <!hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>>
    %u_clk_aon_secure_buf.clk_o = hw.instance "u_clk_aon_secure_buf" @prim_clock_buf_3(clk_i: %u_clk_aon_buf.clk_o: i1) -> (clk_o: i1)
    llhd.drv %39, %u_clk_aon_secure_buf.clk_o after %0 : i1
    %40 = llhd.sig.struct_extract %clocks_o["clk_aon_peri"] : <!hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>>
    %u_clk_aon_peri_buf.clk_o = hw.instance "u_clk_aon_peri_buf" @prim_clock_buf_3(clk_i: %u_clk_aon_buf.clk_o: i1) -> (clk_o: i1)
    llhd.drv %40, %u_clk_aon_peri_buf.clk_o after %0 : i1
    %41 = llhd.sig.struct_extract %clocks_o["clk_aon_timers"] : <!hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>>
    %u_clk_aon_timers_buf.clk_o = hw.instance "u_clk_aon_timers_buf" @prim_clock_buf_3(clk_i: %u_clk_aon_buf.clk_o: i1) -> (clk_o: i1)
    llhd.drv %41, %u_clk_aon_timers_buf.clk_o after %0 : i1
    %u_main_root_ctrl.en_o, %u_main_root_ctrl.clk_o = hw.instance "u_main_root_ctrl" @clkmgr_root_ctrl(clk_i: %u_clk_main_buf.clk_o: i1, rst_ni: %rst_root_main_ni: i1, scanmode_i: %scanmode_i: i4, async_en_i: %main_ip_clk_en: i1) -> (en_o: i1, clk_o: i1) {sv.namehint = "clk_main_en"}
    %42 = llhd.prb %main_ens : i1
    %43 = llhd.sig.struct_extract %pwr_o["main_status"] : <!hw.struct<main_status: i1, io_status: i1, usb_status: i1>>
    %u_main_status.status_o = hw.instance "u_main_status" @clkmgr_clk_status(clk_i: %clk_i: i1, rst_ni: %rst_root_ni: i1, ens_i: %42: i1) -> (status_o: i1)
    llhd.drv %43, %u_main_status.status_o after %0 : i1
    %u_io_root_ctrl.en_o, %u_io_root_ctrl.clk_o = hw.instance "u_io_root_ctrl" @clkmgr_root_ctrl(clk_i: %u_clk_io_buf.clk_o: i1, rst_ni: %rst_root_io_ni: i1, scanmode_i: %scanmode_i: i4, async_en_i: %io_ip_clk_en: i1) -> (en_o: i1, clk_o: i1) {sv.namehint = "clk_io_en"}
    %u_io_div2_root_ctrl.en_o, %u_io_div2_root_ctrl.clk_o = hw.instance "u_io_div2_root_ctrl" @clkmgr_root_ctrl(clk_i: %u_no_scan_io_div2_div.clk_o: i1, rst_ni: %rst_root_io_div2_ni: i1, scanmode_i: %scanmode_i: i4, async_en_i: %io_ip_clk_en: i1) -> (en_o: i1, clk_o: i1) {sv.namehint = "clk_io_div2_en"}
    %u_io_div4_root_ctrl.en_o, %u_io_div4_root_ctrl.clk_o = hw.instance "u_io_div4_root_ctrl" @clkmgr_root_ctrl(clk_i: %u_no_scan_io_div4_div.clk_o: i1, rst_ni: %rst_root_io_div4_ni: i1, scanmode_i: %scanmode_i: i4, async_en_i: %io_ip_clk_en: i1) -> (en_o: i1, clk_o: i1) {sv.namehint = "clk_io_div4_en"}
    %44 = llhd.prb %io_ens : i3
    %45 = llhd.sig.struct_extract %pwr_o["io_status"] : <!hw.struct<main_status: i1, io_status: i1, usb_status: i1>>
    %u_io_status.status_o = hw.instance "u_io_status" @clkmgr_clk_status_4(clk_i: %clk_i: i1, rst_ni: %rst_root_ni: i1, ens_i: %44: i3) -> (status_o: i1)
    llhd.drv %45, %u_io_status.status_o after %0 : i1
    %u_usb_root_ctrl.en_o, %u_usb_root_ctrl.clk_o = hw.instance "u_usb_root_ctrl" @clkmgr_root_ctrl(clk_i: %u_clk_usb_buf.clk_o: i1, rst_ni: %rst_root_usb_ni: i1, scanmode_i: %scanmode_i: i4, async_en_i: %usb_ip_clk_en: i1) -> (en_o: i1, clk_o: i1) {sv.namehint = "clk_usb_en"}
    %46 = llhd.prb %usb_ens : i1
    %47 = llhd.sig.struct_extract %pwr_o["usb_status"] : <!hw.struct<main_status: i1, io_status: i1, usb_status: i1>>
    %u_usb_status.status_o = hw.instance "u_usb_status" @clkmgr_clk_status(clk_i: %clk_i: i1, rst_ni: %rst_root_ni: i1, ens_i: %46: i1) -> (status_o: i1)
    llhd.drv %47, %u_usb_status.status_o after %0 : i1
    %u_calib_rdy_sync.mubi_o = hw.instance "u_calib_rdy_sync" @prim_mubi4_sync_5(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, mubi_i: %calib_rdy_i: i4) -> (mubi_o: !hw.array<6xi4>)
    llhd.drv %calib_rdy, %u_calib_rdy_sync.mubi_o after %0 : !hw.array<6xi4>
    %48 = llhd.prb %reg2hw : !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
    %io_meas_ctrl_en = hw.struct_extract %48["io_meas_ctrl_en"] : !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
    %49 = hw.bitcast %io_meas_ctrl_en : (!hw.struct<q: i4>) -> i4
    %50 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%49) : (i4) -> i1
    %51 = comb.and %u_io_root_ctrl.en_o, %50 : i1
    %io_meas_ctrl_shadowed = hw.struct_extract %48["io_meas_ctrl_shadowed"] : !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
    %hi = hw.struct_extract %io_meas_ctrl_shadowed["hi"] : !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>
    %q = hw.struct_extract %hi["q"] : !hw.struct<q: i10>
    %lo = hw.struct_extract %io_meas_ctrl_shadowed["lo"] : !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>
    %q_0 = hw.struct_extract %lo["q"] : !hw.struct<q: i10>
    %q_1 = hw.struct_extract %io_meas_ctrl_en["q"] : !hw.struct<q: i4>
    %52 = llhd.sig.struct_extract %hw2reg["io_meas_ctrl_en"] : <!hw.struct<extclk_status: !hw.struct<d: i4>, clk_hints_status: !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>, measure_ctrl_regwen: !hw.struct<d: i1, de: i1>, io_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div2_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div4_meas_ctrl_en: !hw.struct<d: i4, de: i1>, main_meas_ctrl_en: !hw.struct<d: i4, de: i1>, usb_meas_ctrl_en: !hw.struct<d: i4, de: i1>, recov_err_code: !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>>
    %53 = llhd.sig.struct_extract %52["de"] : <!hw.struct<d: i4, de: i1>>
    %54 = llhd.sig.struct_extract %52["d"] : <!hw.struct<d: i4, de: i1>>
    %55 = llhd.prb %calib_rdy : !hw.array<6xi4>
    %56 = hw.array_get %55[%c1_i3] : !hw.array<6xi4>, i3
    %57 = llhd.sig.struct_extract %21["io_measure_err"] : <!hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>>
    %58 = llhd.sig.struct_extract %57["de"] : <!hw.struct<d: i1, de: i1>>
    %59 = llhd.sig.struct_extract %21["io_timeout_err"] : <!hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>>
    %60 = llhd.sig.struct_extract %59["de"] : <!hw.struct<d: i1, de: i1>>
    %u_io_meas.src_cfg_meas_en_valid_o, %u_io_meas.src_cfg_meas_en_o, %u_io_meas.meas_err_o, %u_io_meas.timeout_err_o = hw.instance "u_io_meas" @clkmgr_meas_chk(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clk_src_i: %u_clk_io_buf.clk_o: i1, rst_src_ni: %rst_io_ni: i1, clk_ref_i: %u_clk_aon_buf.clk_o: i1, rst_ref_ni: %rst_aon_ni: i1, src_en_i: %51: i1, src_max_cnt_i: %q: i10, src_min_cnt_i: %q_0: i10, src_cfg_meas_en_i: %q_1: i4, calib_rdy_i: %56: i4) -> (src_cfg_meas_en_valid_o: i1, src_cfg_meas_en_o: i4, meas_err_o: i1, timeout_err_o: i1)
    llhd.drv %53, %u_io_meas.src_cfg_meas_en_valid_o after %0 : i1
    llhd.drv %54, %u_io_meas.src_cfg_meas_en_o after %0 : i4
    llhd.drv %58, %u_io_meas.meas_err_o after %0 : i1
    llhd.drv %60, %u_io_meas.timeout_err_o after %0 : i1
    %io_div2_meas_ctrl_en = hw.struct_extract %48["io_div2_meas_ctrl_en"] : !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
    %61 = hw.bitcast %io_div2_meas_ctrl_en : (!hw.struct<q: i4>) -> i4
    %62 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%61) : (i4) -> i1
    %63 = comb.and %u_io_div2_root_ctrl.en_o, %62 : i1
    %io_div2_meas_ctrl_shadowed = hw.struct_extract %48["io_div2_meas_ctrl_shadowed"] : !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
    %hi_2 = hw.struct_extract %io_div2_meas_ctrl_shadowed["hi"] : !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>
    %q_3 = hw.struct_extract %hi_2["q"] : !hw.struct<q: i9>
    %lo_4 = hw.struct_extract %io_div2_meas_ctrl_shadowed["lo"] : !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>
    %q_5 = hw.struct_extract %lo_4["q"] : !hw.struct<q: i9>
    %q_6 = hw.struct_extract %io_div2_meas_ctrl_en["q"] : !hw.struct<q: i4>
    %64 = llhd.sig.struct_extract %hw2reg["io_div2_meas_ctrl_en"] : <!hw.struct<extclk_status: !hw.struct<d: i4>, clk_hints_status: !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>, measure_ctrl_regwen: !hw.struct<d: i1, de: i1>, io_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div2_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div4_meas_ctrl_en: !hw.struct<d: i4, de: i1>, main_meas_ctrl_en: !hw.struct<d: i4, de: i1>, usb_meas_ctrl_en: !hw.struct<d: i4, de: i1>, recov_err_code: !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>>
    %65 = llhd.sig.struct_extract %64["de"] : <!hw.struct<d: i4, de: i1>>
    %66 = llhd.sig.struct_extract %64["d"] : <!hw.struct<d: i4, de: i1>>
    %67 = hw.array_get %55[%c2_i3] : !hw.array<6xi4>, i3
    %68 = llhd.sig.struct_extract %21["io_div2_measure_err"] : <!hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>>
    %69 = llhd.sig.struct_extract %68["de"] : <!hw.struct<d: i1, de: i1>>
    %70 = llhd.sig.struct_extract %21["io_div2_timeout_err"] : <!hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>>
    %71 = llhd.sig.struct_extract %70["de"] : <!hw.struct<d: i1, de: i1>>
    %u_io_div2_meas.src_cfg_meas_en_valid_o, %u_io_div2_meas.src_cfg_meas_en_o, %u_io_div2_meas.meas_err_o, %u_io_div2_meas.timeout_err_o = hw.instance "u_io_div2_meas" @clkmgr_meas_chk_6(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clk_src_i: %u_no_scan_io_div2_div.clk_o: i1, rst_src_ni: %rst_io_div2_ni: i1, clk_ref_i: %u_clk_aon_buf.clk_o: i1, rst_ref_ni: %rst_aon_ni: i1, src_en_i: %63: i1, src_max_cnt_i: %q_3: i9, src_min_cnt_i: %q_5: i9, src_cfg_meas_en_i: %q_6: i4, calib_rdy_i: %67: i4) -> (src_cfg_meas_en_valid_o: i1, src_cfg_meas_en_o: i4, meas_err_o: i1, timeout_err_o: i1)
    llhd.drv %65, %u_io_div2_meas.src_cfg_meas_en_valid_o after %0 : i1
    llhd.drv %66, %u_io_div2_meas.src_cfg_meas_en_o after %0 : i4
    llhd.drv %69, %u_io_div2_meas.meas_err_o after %0 : i1
    llhd.drv %71, %u_io_div2_meas.timeout_err_o after %0 : i1
    %io_div4_meas_ctrl_en = hw.struct_extract %48["io_div4_meas_ctrl_en"] : !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
    %72 = hw.bitcast %io_div4_meas_ctrl_en : (!hw.struct<q: i4>) -> i4
    %73 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%72) : (i4) -> i1
    %74 = comb.and %u_io_div4_root_ctrl.en_o, %73 : i1
    %io_div4_meas_ctrl_shadowed = hw.struct_extract %48["io_div4_meas_ctrl_shadowed"] : !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
    %hi_7 = hw.struct_extract %io_div4_meas_ctrl_shadowed["hi"] : !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>
    %q_8 = hw.struct_extract %hi_7["q"] : !hw.struct<q: i8>
    %lo_9 = hw.struct_extract %io_div4_meas_ctrl_shadowed["lo"] : !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>
    %q_10 = hw.struct_extract %lo_9["q"] : !hw.struct<q: i8>
    %q_11 = hw.struct_extract %io_div4_meas_ctrl_en["q"] : !hw.struct<q: i4>
    %75 = llhd.sig.struct_extract %hw2reg["io_div4_meas_ctrl_en"] : <!hw.struct<extclk_status: !hw.struct<d: i4>, clk_hints_status: !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>, measure_ctrl_regwen: !hw.struct<d: i1, de: i1>, io_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div2_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div4_meas_ctrl_en: !hw.struct<d: i4, de: i1>, main_meas_ctrl_en: !hw.struct<d: i4, de: i1>, usb_meas_ctrl_en: !hw.struct<d: i4, de: i1>, recov_err_code: !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>>
    %76 = llhd.sig.struct_extract %75["de"] : <!hw.struct<d: i4, de: i1>>
    %77 = llhd.sig.struct_extract %75["d"] : <!hw.struct<d: i4, de: i1>>
    %78 = hw.array_get %55[%c3_i3] : !hw.array<6xi4>, i3
    %79 = llhd.sig.struct_extract %21["io_div4_measure_err"] : <!hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>>
    %80 = llhd.sig.struct_extract %79["de"] : <!hw.struct<d: i1, de: i1>>
    %81 = llhd.sig.struct_extract %21["io_div4_timeout_err"] : <!hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>>
    %82 = llhd.sig.struct_extract %81["de"] : <!hw.struct<d: i1, de: i1>>
    %u_io_div4_meas.src_cfg_meas_en_valid_o, %u_io_div4_meas.src_cfg_meas_en_o, %u_io_div4_meas.meas_err_o, %u_io_div4_meas.timeout_err_o = hw.instance "u_io_div4_meas" @clkmgr_meas_chk_7(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clk_src_i: %u_no_scan_io_div4_div.clk_o: i1, rst_src_ni: %rst_io_div4_ni: i1, clk_ref_i: %u_clk_aon_buf.clk_o: i1, rst_ref_ni: %rst_aon_ni: i1, src_en_i: %74: i1, src_max_cnt_i: %q_8: i8, src_min_cnt_i: %q_10: i8, src_cfg_meas_en_i: %q_11: i4, calib_rdy_i: %78: i4) -> (src_cfg_meas_en_valid_o: i1, src_cfg_meas_en_o: i4, meas_err_o: i1, timeout_err_o: i1)
    llhd.drv %76, %u_io_div4_meas.src_cfg_meas_en_valid_o after %0 : i1
    llhd.drv %77, %u_io_div4_meas.src_cfg_meas_en_o after %0 : i4
    llhd.drv %80, %u_io_div4_meas.meas_err_o after %0 : i1
    llhd.drv %82, %u_io_div4_meas.timeout_err_o after %0 : i1
    %main_meas_ctrl_en = hw.struct_extract %48["main_meas_ctrl_en"] : !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
    %83 = hw.bitcast %main_meas_ctrl_en : (!hw.struct<q: i4>) -> i4
    %84 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%83) : (i4) -> i1
    %85 = comb.and %u_main_root_ctrl.en_o, %84 : i1
    %main_meas_ctrl_shadowed = hw.struct_extract %48["main_meas_ctrl_shadowed"] : !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
    %hi_12 = hw.struct_extract %main_meas_ctrl_shadowed["hi"] : !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>
    %q_13 = hw.struct_extract %hi_12["q"] : !hw.struct<q: i10>
    %lo_14 = hw.struct_extract %main_meas_ctrl_shadowed["lo"] : !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>
    %q_15 = hw.struct_extract %lo_14["q"] : !hw.struct<q: i10>
    %q_16 = hw.struct_extract %main_meas_ctrl_en["q"] : !hw.struct<q: i4>
    %86 = llhd.sig.struct_extract %hw2reg["main_meas_ctrl_en"] : <!hw.struct<extclk_status: !hw.struct<d: i4>, clk_hints_status: !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>, measure_ctrl_regwen: !hw.struct<d: i1, de: i1>, io_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div2_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div4_meas_ctrl_en: !hw.struct<d: i4, de: i1>, main_meas_ctrl_en: !hw.struct<d: i4, de: i1>, usb_meas_ctrl_en: !hw.struct<d: i4, de: i1>, recov_err_code: !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>>
    %87 = llhd.sig.struct_extract %86["de"] : <!hw.struct<d: i4, de: i1>>
    %88 = llhd.sig.struct_extract %86["d"] : <!hw.struct<d: i4, de: i1>>
    %89 = hw.array_get %55[%c-4_i3] : !hw.array<6xi4>, i3
    %90 = llhd.sig.struct_extract %21["main_measure_err"] : <!hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>>
    %91 = llhd.sig.struct_extract %90["de"] : <!hw.struct<d: i1, de: i1>>
    %92 = llhd.sig.struct_extract %21["main_timeout_err"] : <!hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>>
    %93 = llhd.sig.struct_extract %92["de"] : <!hw.struct<d: i1, de: i1>>
    %u_main_meas.src_cfg_meas_en_valid_o, %u_main_meas.src_cfg_meas_en_o, %u_main_meas.meas_err_o, %u_main_meas.timeout_err_o = hw.instance "u_main_meas" @clkmgr_meas_chk(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clk_src_i: %u_clk_main_buf.clk_o: i1, rst_src_ni: %rst_main_ni: i1, clk_ref_i: %u_clk_aon_buf.clk_o: i1, rst_ref_ni: %rst_aon_ni: i1, src_en_i: %85: i1, src_max_cnt_i: %q_13: i10, src_min_cnt_i: %q_15: i10, src_cfg_meas_en_i: %q_16: i4, calib_rdy_i: %89: i4) -> (src_cfg_meas_en_valid_o: i1, src_cfg_meas_en_o: i4, meas_err_o: i1, timeout_err_o: i1)
    llhd.drv %87, %u_main_meas.src_cfg_meas_en_valid_o after %0 : i1
    llhd.drv %88, %u_main_meas.src_cfg_meas_en_o after %0 : i4
    llhd.drv %91, %u_main_meas.meas_err_o after %0 : i1
    llhd.drv %93, %u_main_meas.timeout_err_o after %0 : i1
    %usb_meas_ctrl_en = hw.struct_extract %48["usb_meas_ctrl_en"] : !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
    %94 = hw.bitcast %usb_meas_ctrl_en : (!hw.struct<q: i4>) -> i4
    %95 = func.call @"prim_mubi_pkg::mubi4_test_true_loose"(%94) : (i4) -> i1
    %96 = comb.and %u_usb_root_ctrl.en_o, %95 : i1
    %usb_meas_ctrl_shadowed = hw.struct_extract %48["usb_meas_ctrl_shadowed"] : !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
    %hi_17 = hw.struct_extract %usb_meas_ctrl_shadowed["hi"] : !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>
    %q_18 = hw.struct_extract %hi_17["q"] : !hw.struct<q: i9>
    %lo_19 = hw.struct_extract %usb_meas_ctrl_shadowed["lo"] : !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>
    %q_20 = hw.struct_extract %lo_19["q"] : !hw.struct<q: i9>
    %q_21 = hw.struct_extract %usb_meas_ctrl_en["q"] : !hw.struct<q: i4>
    %97 = llhd.sig.struct_extract %hw2reg["usb_meas_ctrl_en"] : <!hw.struct<extclk_status: !hw.struct<d: i4>, clk_hints_status: !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>, measure_ctrl_regwen: !hw.struct<d: i1, de: i1>, io_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div2_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div4_meas_ctrl_en: !hw.struct<d: i4, de: i1>, main_meas_ctrl_en: !hw.struct<d: i4, de: i1>, usb_meas_ctrl_en: !hw.struct<d: i4, de: i1>, recov_err_code: !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>>
    %98 = llhd.sig.struct_extract %97["de"] : <!hw.struct<d: i4, de: i1>>
    %99 = llhd.sig.struct_extract %97["d"] : <!hw.struct<d: i4, de: i1>>
    %100 = hw.array_get %55[%c-3_i3] : !hw.array<6xi4>, i3
    %101 = llhd.sig.struct_extract %21["usb_measure_err"] : <!hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>>
    %102 = llhd.sig.struct_extract %101["de"] : <!hw.struct<d: i1, de: i1>>
    %103 = llhd.sig.struct_extract %21["usb_timeout_err"] : <!hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>>
    %104 = llhd.sig.struct_extract %103["de"] : <!hw.struct<d: i1, de: i1>>
    %u_usb_meas.src_cfg_meas_en_valid_o, %u_usb_meas.src_cfg_meas_en_o, %u_usb_meas.meas_err_o, %u_usb_meas.timeout_err_o = hw.instance "u_usb_meas" @clkmgr_meas_chk_6(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clk_src_i: %u_clk_usb_buf.clk_o: i1, rst_src_ni: %rst_usb_ni: i1, clk_ref_i: %u_clk_aon_buf.clk_o: i1, rst_ref_ni: %rst_aon_ni: i1, src_en_i: %96: i1, src_max_cnt_i: %q_18: i9, src_min_cnt_i: %q_20: i9, src_cfg_meas_en_i: %q_21: i4, calib_rdy_i: %100: i4) -> (src_cfg_meas_en_valid_o: i1, src_cfg_meas_en_o: i4, meas_err_o: i1, timeout_err_o: i1)
    llhd.drv %98, %u_usb_meas.src_cfg_meas_en_valid_o after %0 : i1
    llhd.drv %99, %u_usb_meas.src_cfg_meas_en_o after %0 : i4
    llhd.drv %102, %u_usb_meas.meas_err_o after %0 : i1
    llhd.drv %104, %u_usb_meas.timeout_err_o after %0 : i1
    %105 = comb.mux %u_io_div4_root_ctrl.en_o, %c-7_i4, %c6_i4 : i4
    %106 = llhd.sig.struct_extract %cg_en_o["io_div4_infra"] : <!hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>>
    %u_prim_mubi4_sender_clk_io_div4_infra.mubi_o = hw.instance "u_prim_mubi4_sender_clk_io_div4_infra" @prim_mubi4_sender(clk_i: %u_no_scan_io_div4_div.clk_o: i1, rst_ni: %rst_io_div4_ni: i1, mubi_i: %105: i4) -> (mubi_o: i4)
    llhd.drv %106, %u_prim_mubi4_sender_clk_io_div4_infra.mubi_o after %0 : i4
    %107 = comb.mux %u_main_root_ctrl.en_o, %c-7_i4, %c6_i4 : i4
    %108 = llhd.sig.struct_extract %cg_en_o["main_infra"] : <!hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>>
    %u_prim_mubi4_sender_clk_main_infra.mubi_o = hw.instance "u_prim_mubi4_sender_clk_main_infra" @prim_mubi4_sender(clk_i: %u_clk_main_buf.clk_o: i1, rst_ni: %rst_main_ni: i1, mubi_i: %107: i4) -> (mubi_o: i4)
    llhd.drv %108, %u_prim_mubi4_sender_clk_main_infra.mubi_o after %0 : i4
    %109 = comb.mux %u_usb_root_ctrl.en_o, %c-7_i4, %c6_i4 : i4
    %110 = llhd.sig.struct_extract %cg_en_o["usb_infra"] : <!hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>>
    %u_prim_mubi4_sender_clk_usb_infra.mubi_o = hw.instance "u_prim_mubi4_sender_clk_usb_infra" @prim_mubi4_sender(clk_i: %u_clk_usb_buf.clk_o: i1, rst_ni: %rst_usb_ni: i1, mubi_i: %109: i4) -> (mubi_o: i4)
    llhd.drv %110, %u_prim_mubi4_sender_clk_usb_infra.mubi_o after %0 : i4
    %111 = comb.mux %u_io_root_ctrl.en_o, %c-7_i4, %c6_i4 : i4
    %112 = llhd.sig.struct_extract %cg_en_o["io_infra"] : <!hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>>
    %u_prim_mubi4_sender_clk_io_infra.mubi_o = hw.instance "u_prim_mubi4_sender_clk_io_infra" @prim_mubi4_sender(clk_i: %u_clk_io_buf.clk_o: i1, rst_ni: %rst_io_ni: i1, mubi_i: %111: i4) -> (mubi_o: i4)
    llhd.drv %112, %u_prim_mubi4_sender_clk_io_infra.mubi_o after %0 : i4
    %113 = comb.mux %u_io_div2_root_ctrl.en_o, %c-7_i4, %c6_i4 : i4
    %114 = llhd.sig.struct_extract %cg_en_o["io_div2_infra"] : <!hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>>
    %u_prim_mubi4_sender_clk_io_div2_infra.mubi_o = hw.instance "u_prim_mubi4_sender_clk_io_div2_infra" @prim_mubi4_sender(clk_i: %u_no_scan_io_div2_div.clk_o: i1, rst_ni: %rst_io_div2_ni: i1, mubi_i: %113: i4) -> (mubi_o: i4)
    llhd.drv %114, %u_prim_mubi4_sender_clk_io_div2_infra.mubi_o after %0 : i4
    %115 = llhd.sig.struct_extract %cg_en_o["io_div4_secure"] : <!hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>>
    %u_prim_mubi4_sender_clk_io_div4_secure.mubi_o = hw.instance "u_prim_mubi4_sender_clk_io_div4_secure" @prim_mubi4_sender(clk_i: %u_no_scan_io_div4_div.clk_o: i1, rst_ni: %rst_io_div4_ni: i1, mubi_i: %105: i4) -> (mubi_o: i4)
    llhd.drv %115, %u_prim_mubi4_sender_clk_io_div4_secure.mubi_o after %0 : i4
    %116 = llhd.sig.struct_extract %cg_en_o["main_secure"] : <!hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>>
    %u_prim_mubi4_sender_clk_main_secure.mubi_o = hw.instance "u_prim_mubi4_sender_clk_main_secure" @prim_mubi4_sender(clk_i: %u_clk_main_buf.clk_o: i1, rst_ni: %rst_main_ni: i1, mubi_i: %107: i4) -> (mubi_o: i4)
    llhd.drv %116, %u_prim_mubi4_sender_clk_main_secure.mubi_o after %0 : i4
    %117 = llhd.sig.struct_extract %cg_en_o["io_div4_timers"] : <!hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>>
    %u_prim_mubi4_sender_clk_io_div4_timers.mubi_o = hw.instance "u_prim_mubi4_sender_clk_io_div4_timers" @prim_mubi4_sender(clk_i: %u_no_scan_io_div4_div.clk_o: i1, rst_ni: %rst_io_div4_ni: i1, mubi_i: %105: i4) -> (mubi_o: i4)
    llhd.drv %117, %u_prim_mubi4_sender_clk_io_div4_timers.mubi_o after %0 : i4
    %clk_enables = hw.struct_extract %48["clk_enables"] : !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
    %clk_io_div4_peri_en = hw.struct_extract %clk_enables["clk_io_div4_peri_en"] : !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>
    %q_22 = hw.struct_extract %clk_io_div4_peri_en["q"] : !hw.struct<q: i1>
    %u_clk_io_div4_peri_sw_en_sync.q_o = hw.instance "u_clk_io_div4_peri_sw_en_sync" @prim_flop_2sync(clk_i: %u_no_scan_io_div4_div.clk_o: i1, rst_ni: %rst_io_div4_ni: i1, d_i: %q_22: i1) -> (q_o: i1) {sv.namehint = "clk_io_div4_peri_sw_en"}
    %u_clk_io_div4_peri_scanmode_sync.mubi_o = hw.instance "u_clk_io_div4_peri_scanmode_sync" @prim_mubi4_sync_0(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, mubi_i: %scanmode_i: i4) -> (mubi_o: !hw.array<1xi4>) {sv.namehint = "clk_io_div4_peri_scanmode"}
    %118 = hw.array_get %u_clk_io_div4_peri_scanmode_sync.mubi_o[%c0_i0] : !hw.array<1xi4>, i0
    %119 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%118) : (i4) -> i1
    %120 = llhd.sig.struct_extract %clocks_o["clk_io_div4_peri"] : <!hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>>
    %u_clk_io_div4_peri_cg.clk_o = hw.instance "u_clk_io_div4_peri_cg" @prim_clock_gating(clk_i: %u_no_scan_io_div4_div.clk_o: i1, en_i: %201: i1, test_en_i: %119: i1) -> (clk_o: i1)
    llhd.drv %120, %u_clk_io_div4_peri_cg.clk_o after %0 : i1
    %121 = comb.mux %201, %c-7_i4, %c6_i4 : i4
    %122 = llhd.sig.struct_extract %cg_en_o["io_div4_peri"] : <!hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>>
    %u_prim_mubi4_sender_clk_io_div4_peri.mubi_o = hw.instance "u_prim_mubi4_sender_clk_io_div4_peri" @prim_mubi4_sender(clk_i: %u_no_scan_io_div4_div.clk_o: i1, rst_ni: %rst_io_div4_ni: i1, mubi_i: %121: i4) -> (mubi_o: i4)
    llhd.drv %122, %u_prim_mubi4_sender_clk_io_div4_peri.mubi_o after %0 : i4
    %clk_io_div2_peri_en = hw.struct_extract %clk_enables["clk_io_div2_peri_en"] : !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>
    %q_23 = hw.struct_extract %clk_io_div2_peri_en["q"] : !hw.struct<q: i1>
    %u_clk_io_div2_peri_sw_en_sync.q_o = hw.instance "u_clk_io_div2_peri_sw_en_sync" @prim_flop_2sync(clk_i: %u_no_scan_io_div2_div.clk_o: i1, rst_ni: %rst_io_div2_ni: i1, d_i: %q_23: i1) -> (q_o: i1) {sv.namehint = "clk_io_div2_peri_sw_en"}
    %u_clk_io_div2_peri_scanmode_sync.mubi_o = hw.instance "u_clk_io_div2_peri_scanmode_sync" @prim_mubi4_sync_0(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, mubi_i: %scanmode_i: i4) -> (mubi_o: !hw.array<1xi4>) {sv.namehint = "clk_io_div2_peri_scanmode"}
    %123 = hw.array_get %u_clk_io_div2_peri_scanmode_sync.mubi_o[%c0_i0] : !hw.array<1xi4>, i0
    %124 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%123) : (i4) -> i1
    %125 = llhd.sig.struct_extract %clocks_o["clk_io_div2_peri"] : <!hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>>
    %u_clk_io_div2_peri_cg.clk_o = hw.instance "u_clk_io_div2_peri_cg" @prim_clock_gating(clk_i: %u_no_scan_io_div2_div.clk_o: i1, en_i: %202: i1, test_en_i: %124: i1) -> (clk_o: i1)
    llhd.drv %125, %u_clk_io_div2_peri_cg.clk_o after %0 : i1
    %126 = comb.mux %202, %c-7_i4, %c6_i4 : i4
    %127 = llhd.sig.struct_extract %cg_en_o["io_div2_peri"] : <!hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>>
    %u_prim_mubi4_sender_clk_io_div2_peri.mubi_o = hw.instance "u_prim_mubi4_sender_clk_io_div2_peri" @prim_mubi4_sender(clk_i: %u_no_scan_io_div2_div.clk_o: i1, rst_ni: %rst_io_div2_ni: i1, mubi_i: %126: i4) -> (mubi_o: i4)
    llhd.drv %127, %u_prim_mubi4_sender_clk_io_div2_peri.mubi_o after %0 : i4
    %clk_io_peri_en = hw.struct_extract %clk_enables["clk_io_peri_en"] : !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>
    %q_24 = hw.struct_extract %clk_io_peri_en["q"] : !hw.struct<q: i1>
    %u_clk_io_peri_sw_en_sync.q_o = hw.instance "u_clk_io_peri_sw_en_sync" @prim_flop_2sync(clk_i: %u_clk_io_buf.clk_o: i1, rst_ni: %rst_io_ni: i1, d_i: %q_24: i1) -> (q_o: i1) {sv.namehint = "clk_io_peri_sw_en"}
    %u_clk_io_peri_scanmode_sync.mubi_o = hw.instance "u_clk_io_peri_scanmode_sync" @prim_mubi4_sync_0(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, mubi_i: %scanmode_i: i4) -> (mubi_o: !hw.array<1xi4>) {sv.namehint = "clk_io_peri_scanmode"}
    %128 = hw.array_get %u_clk_io_peri_scanmode_sync.mubi_o[%c0_i0] : !hw.array<1xi4>, i0
    %129 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%128) : (i4) -> i1
    %130 = llhd.sig.struct_extract %clocks_o["clk_io_peri"] : <!hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>>
    %u_clk_io_peri_cg.clk_o = hw.instance "u_clk_io_peri_cg" @prim_clock_gating(clk_i: %u_clk_io_buf.clk_o: i1, en_i: %203: i1, test_en_i: %129: i1) -> (clk_o: i1)
    llhd.drv %130, %u_clk_io_peri_cg.clk_o after %0 : i1
    %131 = comb.mux %203, %c-7_i4, %c6_i4 : i4
    %132 = llhd.sig.struct_extract %cg_en_o["io_peri"] : <!hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>>
    %u_prim_mubi4_sender_clk_io_peri.mubi_o = hw.instance "u_prim_mubi4_sender_clk_io_peri" @prim_mubi4_sender(clk_i: %u_clk_io_buf.clk_o: i1, rst_ni: %rst_io_ni: i1, mubi_i: %131: i4) -> (mubi_o: i4)
    llhd.drv %132, %u_prim_mubi4_sender_clk_io_peri.mubi_o after %0 : i4
    %clk_usb_peri_en = hw.struct_extract %clk_enables["clk_usb_peri_en"] : !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>
    %q_25 = hw.struct_extract %clk_usb_peri_en["q"] : !hw.struct<q: i1>
    %u_clk_usb_peri_sw_en_sync.q_o = hw.instance "u_clk_usb_peri_sw_en_sync" @prim_flop_2sync(clk_i: %u_clk_usb_buf.clk_o: i1, rst_ni: %rst_usb_ni: i1, d_i: %q_25: i1) -> (q_o: i1) {sv.namehint = "clk_usb_peri_sw_en"}
    %u_clk_usb_peri_scanmode_sync.mubi_o = hw.instance "u_clk_usb_peri_scanmode_sync" @prim_mubi4_sync_0(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, mubi_i: %scanmode_i: i4) -> (mubi_o: !hw.array<1xi4>) {sv.namehint = "clk_usb_peri_scanmode"}
    %133 = hw.array_get %u_clk_usb_peri_scanmode_sync.mubi_o[%c0_i0] : !hw.array<1xi4>, i0
    %134 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%133) : (i4) -> i1
    %135 = llhd.sig.struct_extract %clocks_o["clk_usb_peri"] : <!hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>>
    %u_clk_usb_peri_cg.clk_o = hw.instance "u_clk_usb_peri_cg" @prim_clock_gating(clk_i: %u_clk_usb_buf.clk_o: i1, en_i: %204: i1, test_en_i: %134: i1) -> (clk_o: i1)
    llhd.drv %135, %u_clk_usb_peri_cg.clk_o after %0 : i1
    %136 = comb.mux %204, %c-7_i4, %c6_i4 : i4
    %137 = llhd.sig.struct_extract %cg_en_o["usb_peri"] : <!hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>>
    %u_prim_mubi4_sender_clk_usb_peri.mubi_o = hw.instance "u_prim_mubi4_sender_clk_usb_peri" @prim_mubi4_sender(clk_i: %u_clk_usb_buf.clk_o: i1, rst_ni: %rst_usb_ni: i1, mubi_i: %136: i4) -> (mubi_o: i4)
    llhd.drv %137, %u_prim_mubi4_sender_clk_usb_peri.mubi_o after %0 : i4
    %138 = hw.array_get %idle_i[%c0_i2] : !hw.array<4xi4>, i2
    %clk_hints = hw.struct_extract %48["clk_hints"] : !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
    %clk_main_aes_hint = hw.struct_extract %clk_hints["clk_main_aes_hint"] : !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>
    %q_26 = hw.struct_extract %clk_main_aes_hint["q"] : !hw.struct<q: i1>
    %139 = llhd.sig.struct_extract %cg_en_o["main_aes"] : <!hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>>
    %140 = llhd.sig.struct_extract %clocks_o["clk_main_aes"] : <!hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>>
    %141 = llhd.sig.struct_extract %hw2reg["clk_hints_status"] : <!hw.struct<extclk_status: !hw.struct<d: i4>, clk_hints_status: !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>, measure_ctrl_regwen: !hw.struct<d: i1, de: i1>, io_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div2_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div4_meas_ctrl_en: !hw.struct<d: i4, de: i1>, main_meas_ctrl_en: !hw.struct<d: i4, de: i1>, usb_meas_ctrl_en: !hw.struct<d: i4, de: i1>, recov_err_code: !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>>
    %142 = llhd.sig.struct_extract %141["clk_main_aes_val"] : <!hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>>
    %143 = llhd.sig.struct_extract %142["d"] : <!hw.struct<d: i1, de: i1>>
    %144 = llhd.sig.extract %idle_cnt_err from %c0_i2 : <i4> -> <i1>
    %u_clk_main_aes_trans.alert_cg_en_o, %u_clk_main_aes_trans.clk_o, %u_clk_main_aes_trans.reg_en_o, %u_clk_main_aes_trans.reg_cnt_err_o = hw.instance "u_clk_main_aes_trans" @clkmgr_trans(clk_i: %u_clk_main_buf.clk_o: i1, clk_gated_i: %u_main_root_ctrl.clk_o: i1, rst_ni: %rst_main_ni: i1, en_i: %u_main_root_ctrl.en_o: i1, idle_i: %138: i4, sw_hint_i: %q_26: i1, scanmode_i: %scanmode_i: i4, clk_reg_i: %clk_i: i1, rst_reg_ni: %rst_ni: i1) -> (alert_cg_en_o: i4, clk_o: i1, reg_en_o: i1, reg_cnt_err_o: i1)
    llhd.drv %139, %u_clk_main_aes_trans.alert_cg_en_o after %0 : i4
    llhd.drv %140, %u_clk_main_aes_trans.clk_o after %0 : i1
    llhd.drv %143, %u_clk_main_aes_trans.reg_en_o after %0 : i1
    llhd.drv %144, %u_clk_main_aes_trans.reg_cnt_err_o after %0 : i1
    %145 = hw.array_get %idle_i[%c1_i2] : !hw.array<4xi4>, i2
    %clk_main_hmac_hint = hw.struct_extract %clk_hints["clk_main_hmac_hint"] : !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>
    %q_27 = hw.struct_extract %clk_main_hmac_hint["q"] : !hw.struct<q: i1>
    %146 = llhd.sig.struct_extract %cg_en_o["main_hmac"] : <!hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>>
    %147 = llhd.sig.struct_extract %clocks_o["clk_main_hmac"] : <!hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>>
    %148 = llhd.sig.struct_extract %141["clk_main_hmac_val"] : <!hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>>
    %149 = llhd.sig.struct_extract %148["d"] : <!hw.struct<d: i1, de: i1>>
    %150 = llhd.sig.extract %idle_cnt_err from %c1_i2 : <i4> -> <i1>
    %u_clk_main_hmac_trans.alert_cg_en_o, %u_clk_main_hmac_trans.clk_o, %u_clk_main_hmac_trans.reg_en_o, %u_clk_main_hmac_trans.reg_cnt_err_o = hw.instance "u_clk_main_hmac_trans" @clkmgr_trans(clk_i: %u_clk_main_buf.clk_o: i1, clk_gated_i: %u_main_root_ctrl.clk_o: i1, rst_ni: %rst_main_ni: i1, en_i: %u_main_root_ctrl.en_o: i1, idle_i: %145: i4, sw_hint_i: %q_27: i1, scanmode_i: %scanmode_i: i4, clk_reg_i: %clk_i: i1, rst_reg_ni: %rst_ni: i1) -> (alert_cg_en_o: i4, clk_o: i1, reg_en_o: i1, reg_cnt_err_o: i1)
    llhd.drv %146, %u_clk_main_hmac_trans.alert_cg_en_o after %0 : i4
    llhd.drv %147, %u_clk_main_hmac_trans.clk_o after %0 : i1
    llhd.drv %149, %u_clk_main_hmac_trans.reg_en_o after %0 : i1
    llhd.drv %150, %u_clk_main_hmac_trans.reg_cnt_err_o after %0 : i1
    %151 = hw.array_get %idle_i[%c-2_i2] : !hw.array<4xi4>, i2
    %clk_main_kmac_hint = hw.struct_extract %clk_hints["clk_main_kmac_hint"] : !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>
    %q_28 = hw.struct_extract %clk_main_kmac_hint["q"] : !hw.struct<q: i1>
    %152 = llhd.sig.struct_extract %cg_en_o["main_kmac"] : <!hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>>
    %153 = llhd.sig.struct_extract %clocks_o["clk_main_kmac"] : <!hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>>
    %154 = llhd.sig.struct_extract %141["clk_main_kmac_val"] : <!hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>>
    %155 = llhd.sig.struct_extract %154["d"] : <!hw.struct<d: i1, de: i1>>
    %156 = llhd.sig.extract %idle_cnt_err from %c-2_i2 : <i4> -> <i1>
    %u_clk_main_kmac_trans.alert_cg_en_o, %u_clk_main_kmac_trans.clk_o, %u_clk_main_kmac_trans.reg_en_o, %u_clk_main_kmac_trans.reg_cnt_err_o = hw.instance "u_clk_main_kmac_trans" @clkmgr_trans_8(clk_i: %u_clk_main_buf.clk_o: i1, clk_gated_i: %u_main_root_ctrl.clk_o: i1, rst_ni: %rst_main_ni: i1, en_i: %u_main_root_ctrl.en_o: i1, idle_i: %151: i4, sw_hint_i: %q_28: i1, scanmode_i: %scanmode_i: i4, clk_reg_i: %clk_i: i1, rst_reg_ni: %rst_ni: i1) -> (alert_cg_en_o: i4, clk_o: i1, reg_en_o: i1, reg_cnt_err_o: i1)
    llhd.drv %152, %u_clk_main_kmac_trans.alert_cg_en_o after %0 : i4
    llhd.drv %153, %u_clk_main_kmac_trans.clk_o after %0 : i1
    llhd.drv %155, %u_clk_main_kmac_trans.reg_en_o after %0 : i1
    llhd.drv %156, %u_clk_main_kmac_trans.reg_cnt_err_o after %0 : i1
    %157 = hw.array_get %idle_i[%c-1_i2] : !hw.array<4xi4>, i2
    %clk_main_otbn_hint = hw.struct_extract %clk_hints["clk_main_otbn_hint"] : !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>
    %q_29 = hw.struct_extract %clk_main_otbn_hint["q"] : !hw.struct<q: i1>
    %158 = llhd.sig.struct_extract %cg_en_o["main_otbn"] : <!hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>>
    %159 = llhd.sig.struct_extract %clocks_o["clk_main_otbn"] : <!hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>>
    %160 = llhd.sig.struct_extract %141["clk_main_otbn_val"] : <!hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>>
    %161 = llhd.sig.struct_extract %160["d"] : <!hw.struct<d: i1, de: i1>>
    %162 = llhd.sig.extract %idle_cnt_err from %c-1_i2 : <i4> -> <i1>
    %u_clk_main_otbn_trans.alert_cg_en_o, %u_clk_main_otbn_trans.clk_o, %u_clk_main_otbn_trans.reg_en_o, %u_clk_main_otbn_trans.reg_cnt_err_o = hw.instance "u_clk_main_otbn_trans" @clkmgr_trans(clk_i: %u_clk_main_buf.clk_o: i1, clk_gated_i: %u_main_root_ctrl.clk_o: i1, rst_ni: %rst_main_ni: i1, en_i: %u_main_root_ctrl.en_o: i1, idle_i: %157: i4, sw_hint_i: %q_29: i1, scanmode_i: %scanmode_i: i4, clk_reg_i: %clk_i: i1, rst_reg_ni: %rst_ni: i1) -> (alert_cg_en_o: i4, clk_o: i1, reg_en_o: i1, reg_cnt_err_o: i1)
    llhd.drv %158, %u_clk_main_otbn_trans.alert_cg_en_o after %0 : i4
    llhd.drv %159, %u_clk_main_otbn_trans.clk_o after %0 : i1
    llhd.drv %161, %u_clk_main_otbn_trans.reg_en_o after %0 : i1
    llhd.drv %162, %u_clk_main_otbn_trans.reg_cnt_err_o after %0 : i1
    %163 = llhd.sig.struct_extract %24["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %163, %true after %0 : i1
    %164 = llhd.sig.struct_extract %22["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %164, %true after %0 : i1
    %165 = llhd.sig.struct_extract %19["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %165, %true after %0 : i1
    %alert_test = hw.struct_extract %48["alert_test"] : !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
    %fatal_fault = hw.struct_extract %alert_test["fatal_fault"] : !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>
    %q_30 = hw.struct_extract %fatal_fault["q"] : !hw.struct<q: i1, qe: i1>
    %qe = hw.struct_extract %fatal_fault["qe"] : !hw.struct<q: i1, qe: i1>
    %166 = comb.and %q_30, %qe : i1
    %recov_fault = hw.struct_extract %alert_test["recov_fault"] : !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>
    %q_31 = hw.struct_extract %recov_fault["q"] : !hw.struct<q: i1, qe: i1>
    %qe_32 = hw.struct_extract %recov_fault["qe"] : !hw.struct<q: i1, qe: i1>
    %167 = comb.and %q_31, %qe_32 : i1
    %recov_err_code = hw.struct_extract %17["recov_err_code"] : !hw.struct<extclk_status: !hw.struct<d: i4>, clk_hints_status: !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>, measure_ctrl_regwen: !hw.struct<d: i1, de: i1>, io_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div2_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div4_meas_ctrl_en: !hw.struct<d: i4, de: i1>, main_meas_ctrl_en: !hw.struct<d: i4, de: i1>, usb_meas_ctrl_en: !hw.struct<d: i4, de: i1>, recov_err_code: !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>
    %io_measure_err = hw.struct_extract %recov_err_code["io_measure_err"] : !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>
    %de = hw.struct_extract %io_measure_err["de"] : !hw.struct<d: i1, de: i1>
    %io_timeout_err = hw.struct_extract %recov_err_code["io_timeout_err"] : !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>
    %de_33 = hw.struct_extract %io_timeout_err["de"] : !hw.struct<d: i1, de: i1>
    %io_div2_measure_err = hw.struct_extract %recov_err_code["io_div2_measure_err"] : !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>
    %de_34 = hw.struct_extract %io_div2_measure_err["de"] : !hw.struct<d: i1, de: i1>
    %io_div2_timeout_err = hw.struct_extract %recov_err_code["io_div2_timeout_err"] : !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>
    %de_35 = hw.struct_extract %io_div2_timeout_err["de"] : !hw.struct<d: i1, de: i1>
    %io_div4_measure_err = hw.struct_extract %recov_err_code["io_div4_measure_err"] : !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>
    %de_36 = hw.struct_extract %io_div4_measure_err["de"] : !hw.struct<d: i1, de: i1>
    %io_div4_timeout_err = hw.struct_extract %recov_err_code["io_div4_timeout_err"] : !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>
    %de_37 = hw.struct_extract %io_div4_timeout_err["de"] : !hw.struct<d: i1, de: i1>
    %main_measure_err = hw.struct_extract %recov_err_code["main_measure_err"] : !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>
    %de_38 = hw.struct_extract %main_measure_err["de"] : !hw.struct<d: i1, de: i1>
    %main_timeout_err = hw.struct_extract %recov_err_code["main_timeout_err"] : !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>
    %de_39 = hw.struct_extract %main_timeout_err["de"] : !hw.struct<d: i1, de: i1>
    %usb_measure_err = hw.struct_extract %recov_err_code["usb_measure_err"] : !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>
    %de_40 = hw.struct_extract %usb_measure_err["de"] : !hw.struct<d: i1, de: i1>
    %usb_timeout_err = hw.struct_extract %recov_err_code["usb_timeout_err"] : !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>
    %de_41 = hw.struct_extract %usb_timeout_err["de"] : !hw.struct<d: i1, de: i1>
    %shadow_update_err = hw.struct_extract %recov_err_code["shadow_update_err"] : !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>
    %de_42 = hw.struct_extract %shadow_update_err["de"] : !hw.struct<d: i1, de: i1>
    %168 = comb.or %de, %de_33, %de_34, %de_35, %de_36, %de_37, %de_38, %de_39, %de_40, %de_41, %de_42 {sv.namehint = "recov_alert"} : i1
    %fatal_err_code = hw.struct_extract %48["fatal_err_code"] : !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
    %169 = hw.bitcast %fatal_err_code : (!hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>) -> i3
    %170 = comb.icmp ne %169, %c0_i3 : i3
    %extclk_ctrl = hw.struct_extract %48["extclk_ctrl"] : !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
    %sel = hw.struct_extract %extclk_ctrl["sel"] : !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>
    %q_43 = hw.struct_extract %sel["q"] {sv.namehint = "extclk_ctrl_sel"} : !hw.struct<q: i4>
    %hi_speed_sel = hw.struct_extract %extclk_ctrl["hi_speed_sel"] : !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>
    %q_44 = hw.struct_extract %hi_speed_sel["q"] {sv.namehint = "extclk_ctrl_hi_speed_sel"} : !hw.struct<q: i4>
    %171 = llhd.sig.struct_extract %cg_en_o["io_div4_powerup"] : <!hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>>
    llhd.drv %171, %c-7_i4 after %0 : i4
    %172 = llhd.sig.struct_extract %cg_en_o["aon_powerup"] : <!hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>>
    llhd.drv %172, %c-7_i4 after %0 : i4
    %173 = llhd.sig.struct_extract %cg_en_o["main_powerup"] : <!hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>>
    llhd.drv %173, %c-7_i4 after %0 : i4
    %174 = llhd.sig.struct_extract %cg_en_o["io_powerup"] : <!hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>>
    llhd.drv %174, %c-7_i4 after %0 : i4
    %175 = llhd.sig.struct_extract %cg_en_o["usb_powerup"] : <!hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>>
    llhd.drv %175, %c-7_i4 after %0 : i4
    %176 = llhd.sig.struct_extract %cg_en_o["io_div2_powerup"] : <!hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>>
    llhd.drv %176, %c-7_i4 after %0 : i4
    %177 = llhd.sig.struct_extract %cg_en_o["aon_secure"] : <!hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>>
    llhd.drv %177, %c-7_i4 after %0 : i4
    %178 = llhd.sig.struct_extract %cg_en_o["aon_peri"] : <!hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>>
    llhd.drv %178, %c-7_i4 after %0 : i4
    %179 = llhd.sig.struct_extract %cg_en_o["aon_timers"] : <!hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>>
    llhd.drv %179, %c-7_i4 after %0 : i4
    %main_ip_clk_en = hw.struct_extract %pwr_i["main_ip_clk_en"] {sv.namehint = "pwrmgr_main_en"} : !hw.struct<main_ip_clk_en: i1, io_ip_clk_en: i1, usb_ip_clk_en: i1>
    %io_ip_clk_en = hw.struct_extract %pwr_i["io_ip_clk_en"] {sv.namehint = "pwrmgr_io_en"} : !hw.struct<main_ip_clk_en: i1, io_ip_clk_en: i1, usb_ip_clk_en: i1>
    %usb_ip_clk_en = hw.struct_extract %pwr_i["usb_ip_clk_en"] {sv.namehint = "pwrmgr_usb_en"} : !hw.struct<main_ip_clk_en: i1, io_ip_clk_en: i1, usb_ip_clk_en: i1>
    llhd.drv %main_ens, %u_main_root_ctrl.en_o after %0 : i1
    %180 = llhd.sig.extract %io_ens from %c0_i2 : <i3> -> <i1>
    llhd.drv %180, %u_io_root_ctrl.en_o after %0 : i1
    %181 = llhd.sig.extract %io_ens from %c1_i2 : <i3> -> <i1>
    llhd.drv %181, %u_io_div2_root_ctrl.en_o after %0 : i1
    %182 = llhd.sig.extract %io_ens from %c-2_i2 : <i3> -> <i1>
    llhd.drv %182, %u_io_div4_root_ctrl.en_o after %0 : i1
    llhd.drv %usb_ens, %u_usb_root_ctrl.en_o after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb3
      %218 = llhd.sig.struct_extract %hw2reg["measure_ctrl_regwen"] : <!hw.struct<extclk_status: !hw.struct<d: i4>, clk_hints_status: !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>, measure_ctrl_regwen: !hw.struct<d: i1, de: i1>, io_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div2_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div4_meas_ctrl_en: !hw.struct<d: i4, de: i1>, main_meas_ctrl_en: !hw.struct<d: i4, de: i1>, usb_meas_ctrl_en: !hw.struct<d: i4, de: i1>, recov_err_code: !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>>
      %219 = llhd.sig.struct_extract %218["de"] : <!hw.struct<d: i1, de: i1>>
      llhd.drv %219, %false after %0 : i1
      %220 = llhd.sig.struct_extract %218["d"] : <!hw.struct<d: i1, de: i1>>
      %221 = llhd.prb %reg2hw : !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
      %measure_ctrl_regwen = hw.struct_extract %221["measure_ctrl_regwen"] : !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
      %222 = hw.bitcast %measure_ctrl_regwen : (!hw.struct<q: i1>) -> i1
      llhd.drv %220, %222 after %0 : i1
      %223 = llhd.prb %calib_rdy : !hw.array<6xi4>
      %224 = hw.array_get %223[%c0_i3] : !hw.array<6xi4>, i3
      %225 = func.call @"prim_mubi_pkg::mubi4_test_false_strict"(%224) : (i4) -> i1
      cf.cond_br %225, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      llhd.drv %219, %true after %0 : i1
      llhd.drv %220, %true after %0 : i1
      cf.br ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      llhd.wait (%17, %48, %55 : !hw.struct<extclk_status: !hw.struct<d: i4>, clk_hints_status: !hw.struct<clk_main_otbn_val: !hw.struct<d: i1, de: i1>, clk_main_kmac_val: !hw.struct<d: i1, de: i1>, clk_main_hmac_val: !hw.struct<d: i1, de: i1>, clk_main_aes_val: !hw.struct<d: i1, de: i1>>, measure_ctrl_regwen: !hw.struct<d: i1, de: i1>, io_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div2_meas_ctrl_en: !hw.struct<d: i4, de: i1>, io_div4_meas_ctrl_en: !hw.struct<d: i4, de: i1>, main_meas_ctrl_en: !hw.struct<d: i4, de: i1>, usb_meas_ctrl_en: !hw.struct<d: i4, de: i1>, recov_err_code: !hw.struct<usb_timeout_err: !hw.struct<d: i1, de: i1>, main_timeout_err: !hw.struct<d: i1, de: i1>, io_div4_timeout_err: !hw.struct<d: i1, de: i1>, io_div2_timeout_err: !hw.struct<d: i1, de: i1>, io_timeout_err: !hw.struct<d: i1, de: i1>, usb_measure_err: !hw.struct<d: i1, de: i1>, main_measure_err: !hw.struct<d: i1, de: i1>, io_div4_measure_err: !hw.struct<d: i1, de: i1>, io_div2_measure_err: !hw.struct<d: i1, de: i1>, io_measure_err: !hw.struct<d: i1, de: i1>, shadow_update_err: !hw.struct<d: i1, de: i1>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>, !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>, !hw.array<6xi4>), ^bb1
    }
    %183 = llhd.sig.struct_extract %57["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %183, %true after %0 : i1
    %184 = llhd.sig.struct_extract %59["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %184, %true after %0 : i1
    %185 = llhd.sig.struct_extract %68["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %185, %true after %0 : i1
    %186 = llhd.sig.struct_extract %70["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %186, %true after %0 : i1
    %187 = llhd.sig.struct_extract %79["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %187, %true after %0 : i1
    %188 = llhd.sig.struct_extract %81["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %188, %true after %0 : i1
    %189 = llhd.sig.struct_extract %90["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %189, %true after %0 : i1
    %190 = llhd.sig.struct_extract %92["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %190, %true after %0 : i1
    %191 = llhd.sig.struct_extract %101["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %191, %true after %0 : i1
    %192 = llhd.sig.struct_extract %103["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %192, %true after %0 : i1
    %193 = llhd.sig.struct_extract %clocks_o["clk_io_div4_infra"] : <!hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>>
    llhd.drv %193, %u_io_div4_root_ctrl.clk_o after %0 : i1
    %194 = llhd.sig.struct_extract %clocks_o["clk_main_infra"] : <!hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>>
    llhd.drv %194, %u_main_root_ctrl.clk_o after %0 : i1
    %195 = llhd.sig.struct_extract %clocks_o["clk_usb_infra"] : <!hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>>
    llhd.drv %195, %u_usb_root_ctrl.clk_o after %0 : i1
    %196 = llhd.sig.struct_extract %clocks_o["clk_io_infra"] : <!hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>>
    llhd.drv %196, %u_io_root_ctrl.clk_o after %0 : i1
    %197 = llhd.sig.struct_extract %clocks_o["clk_io_div2_infra"] : <!hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>>
    llhd.drv %197, %u_io_div2_root_ctrl.clk_o after %0 : i1
    %198 = llhd.sig.struct_extract %clocks_o["clk_io_div4_secure"] : <!hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>>
    llhd.drv %198, %u_io_div4_root_ctrl.clk_o after %0 : i1
    %199 = llhd.sig.struct_extract %clocks_o["clk_main_secure"] : <!hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>>
    llhd.drv %199, %u_main_root_ctrl.clk_o after %0 : i1
    %200 = llhd.sig.struct_extract %clocks_o["clk_io_div4_timers"] : <!hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>>
    llhd.drv %200, %u_io_div4_root_ctrl.clk_o after %0 : i1
    %201 = comb.and %u_clk_io_div4_peri_sw_en_sync.q_o, %u_io_div4_root_ctrl.en_o {sv.namehint = "clk_io_div4_peri_combined_en"} : i1
    %202 = comb.and %u_clk_io_div2_peri_sw_en_sync.q_o, %u_io_div2_root_ctrl.en_o {sv.namehint = "clk_io_div2_peri_combined_en"} : i1
    %203 = comb.and %u_clk_io_peri_sw_en_sync.q_o, %u_io_root_ctrl.en_o {sv.namehint = "clk_io_peri_combined_en"} : i1
    %204 = comb.and %u_clk_usb_peri_sw_en_sync.q_o, %u_usb_root_ctrl.en_o {sv.namehint = "clk_usb_peri_combined_en"} : i1
    %205 = llhd.sig.struct_extract %18["idle_cnt"] : <!hw.struct<shadow_storage_err: !hw.struct<d: i1, de: i1>, idle_cnt: !hw.struct<d: i1, de: i1>, reg_intg: !hw.struct<d: i1, de: i1>>>
    %206 = llhd.sig.struct_extract %205["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %206, %true after %0 : i1
    %207 = llhd.sig.struct_extract %205["de"] : <!hw.struct<d: i1, de: i1>>
    %208 = llhd.prb %idle_cnt_err : i4
    %209 = comb.icmp ne %208, %c0_i4 : i4
    llhd.drv %207, %209 after %0 : i1
    %210 = llhd.sig.struct_extract %142["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %210, %true after %0 : i1
    %211 = llhd.sig.struct_extract %148["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %211, %true after %0 : i1
    %212 = llhd.sig.struct_extract %154["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %212, %true after %0 : i1
    %213 = llhd.sig.struct_extract %160["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %213, %true after %0 : i1
    %jitter_enable = hw.struct_extract %48["jitter_enable"] : !hw.struct<alert_test: !hw.struct<fatal_fault: !hw.struct<q: i1, qe: i1>, recov_fault: !hw.struct<q: i1, qe: i1>>, extclk_ctrl: !hw.struct<hi_speed_sel: !hw.struct<q: i4>, sel: !hw.struct<q: i4>>, jitter_enable: !hw.struct<q: i4>, clk_enables: !hw.struct<clk_usb_peri_en: !hw.struct<q: i1>, clk_io_peri_en: !hw.struct<q: i1>, clk_io_div2_peri_en: !hw.struct<q: i1>, clk_io_div4_peri_en: !hw.struct<q: i1>>, clk_hints: !hw.struct<clk_main_otbn_hint: !hw.struct<q: i1>, clk_main_kmac_hint: !hw.struct<q: i1>, clk_main_hmac_hint: !hw.struct<q: i1>, clk_main_aes_hint: !hw.struct<q: i1>>, measure_ctrl_regwen: !hw.struct<q: i1>, io_meas_ctrl_en: !hw.struct<q: i4>, io_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, io_div2_meas_ctrl_en: !hw.struct<q: i4>, io_div2_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, io_div4_meas_ctrl_en: !hw.struct<q: i4>, io_div4_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i8>, hi: !hw.struct<q: i8>>, main_meas_ctrl_en: !hw.struct<q: i4>, main_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i10>, hi: !hw.struct<q: i10>>, usb_meas_ctrl_en: !hw.struct<q: i4>, usb_meas_ctrl_shadowed: !hw.struct<lo: !hw.struct<q: i9>, hi: !hw.struct<q: i9>>, fatal_err_code: !hw.struct<shadow_storage_err: !hw.struct<q: i1>, idle_cnt: !hw.struct<q: i1>, reg_intg: !hw.struct<q: i1>>>
    %q_45 = hw.struct_extract %jitter_enable["q"] : !hw.struct<q: i4>
    %214 = llhd.prb %alert_tx_o : !hw.array<2xstruct<alert_p: i1, alert_n: i1>>
    %215 = llhd.prb %pwr_o : !hw.struct<main_status: i1, io_status: i1, usb_status: i1>
    %216 = llhd.prb %cg_en_o : !hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>
    %217 = llhd.prb %clocks_o : !hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>
    hw.output %u_reg.tl_o, %214, %215, %u_clkmgr_byp.lc_clk_byp_ack_o, %u_clkmgr_byp.io_clk_byp_req_o, %u_clkmgr_byp.all_clk_byp_req_o, %u_clkmgr_byp.hi_speed_sel_o, %q_45, %216, %217 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.array<2xstruct<alert_p: i1, alert_n: i1>>, !hw.struct<main_status: i1, io_status: i1, usb_status: i1>, i4, i4, i4, i4, i4, !hw.struct<io_div4_powerup: i4, aon_powerup: i4, main_powerup: i4, io_powerup: i4, usb_powerup: i4, io_div2_powerup: i4, aon_secure: i4, aon_peri: i4, aon_timers: i4, main_aes: i4, main_hmac: i4, main_kmac: i4, main_otbn: i4, io_div4_infra: i4, main_infra: i4, usb_infra: i4, io_infra: i4, io_div2_infra: i4, io_div4_secure: i4, main_secure: i4, io_div4_timers: i4, io_div4_peri: i4, io_div2_peri: i4, io_peri: i4, usb_peri: i4>, !hw.struct<clk_io_div4_powerup: i1, clk_aon_powerup: i1, clk_main_powerup: i1, clk_io_powerup: i1, clk_usb_powerup: i1, clk_io_div2_powerup: i1, clk_aon_secure: i1, clk_aon_peri: i1, clk_aon_timers: i1, clk_main_aes: i1, clk_main_hmac: i1, clk_main_kmac: i1, clk_main_otbn: i1, clk_io_div4_infra: i1, clk_main_infra: i1, clk_usb_infra: i1, clk_io_infra: i1, clk_io_div2_infra: i1, clk_io_div4_secure: i1, clk_main_secure: i1, clk_io_div4_timers: i1, clk_io_div4_peri: i1, clk_io_div2_peri: i1, clk_io_peri: i1, clk_usb_peri: i1>
  }
  hw.module private @clkmgr_trans(in %clk_i : i1, in %clk_gated_i : i1, in %rst_ni : i1, in %en_i : i1, in %idle_i : i4, in %sw_hint_i : i1, in %scanmode_i : i4, out alert_cg_en_o : i4, out clk_o : i1, in %clk_reg_i : i1, in %rst_reg_ni : i1, out reg_en_o : i1, out reg_cnt_err_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i0 = hw.constant 0 : i0
    %c-6_i4 = hw.constant -6 : i4
    %c6_i4 = hw.constant 6 : i4
    %c-7_i4 = hw.constant -7 : i4
    %true = hw.constant true
    %c1_i4 = hw.constant 1 : i4
    %c0_i4 = hw.constant 0 : i4
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %cnt_err = llhd.sig %false : i1
    %combined_en_d = llhd.sig %false : i1
    %combined_en_q = llhd.sig %false : i1
    %hold_err = llhd.sig %false : i1
    %u_hint_sync.q_o = hw.instance "u_hint_sync" @prim_flop_2sync(clk_i: %2: i1, rst_ni: %3: i1, d_i: %sw_hint_i: i1) -> (q_o: i1) {sv.namehint = "sw_hint_synced"}
    %u_idle_sync.mubi_o = hw.instance "u_idle_sync" @prim_mubi4_sync(clk_i: %2: i1, rst_ni: %3: i1, mubi_i: %idle_i: i4) -> (mubi_o: !hw.array<1xi4>) {sv.namehint = "idle"}
    %4 = hw.array_get %u_idle_sync.mubi_o[%c0_i0] : !hw.array<1xi4>, i0
    %5 = func.call @"prim_mubi_pkg::mubi4_test_false_loose"(%4) : (i4) -> i1
    %6 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%4) : (i4) -> i1
    %7 = comb.icmp ne %u_idle_cnt.cnt_o, %c-6_i4 : i4
    %8 = comb.and %6, %7 : i1
    %u_idle_cnt.cnt_o, %u_idle_cnt.cnt_after_commit_o, %u_idle_cnt.err_o = hw.instance "u_idle_cnt" @prim_count(clk_i: %2: i1, rst_ni: %3: i1, clr_i: %5: i1, set_i: %false: i1, set_cnt_i: %c0_i4: i4, incr_en_i: %8: i1, decr_en_i: %false: i1, step_i: %c1_i4: i4, commit_i: %true: i1) -> (cnt_o: i4, cnt_after_commit_o: i4, err_o: i1) {sv.namehint = "idle_cnt"}
    llhd.drv %cnt_err, %u_idle_cnt.err_o after %1 : i1
    %u_scanmode_sync.mubi_o = hw.instance "u_scanmode_sync" @prim_mubi4_sync_0(clk_i: %2: i1, rst_ni: %3: i1, mubi_i: %scanmode_i: i4) -> (mubi_o: !hw.array<1xi4>) {sv.namehint = "scanmode"}
    %9 = comb.and %16, %en_i : i1
    %u_prim_buf_en.out_o = hw.instance "u_prim_buf_en" @prim_buf(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %combined_en_d, %u_prim_buf_en.out_o after %1 : i1
    %10 = hw.array_get %u_scanmode_sync.mubi_o[%c0_i0] : !hw.array<1xi4>, i0
    %11 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%10) : (i4) -> i1
    %u_cg.clk_o = hw.instance "u_cg" @prim_clock_gating_37(clk_i: %clk_gated_i: i1, en_i: %16: i1, test_en_i: %11: i1) -> (clk_o: i1)
    %12 = llhd.prb %combined_en_d : i1
    %13 = comb.mux %12, %c-7_i4, %c6_i4 : i4
    %u_prim_mubi4_sender.mubi_o = hw.instance "u_prim_mubi4_sender" @prim_mubi4_sender(clk_i: %2: i1, rst_ni: %3: i1, mubi_i: %13: i4) -> (mubi_o: i4)
    %14 = llhd.prb %hold_err : i1
    %u_err_sync.q_o = hw.instance "u_err_sync" @prim_flop_2sync(clk_i: %clk_reg_i: i1, rst_ni: %rst_reg_ni: i1, d_i: %14: i1) -> (q_o: i1)
    %15 = llhd.prb %combined_en_q : i1
    %u_en_sync.q_o = hw.instance "u_en_sync" @prim_flop_2sync(clk_i: %clk_reg_i: i1, rst_ni: %rst_reg_ni: i1, d_i: %15: i1) -> (q_o: i1)
    %16 = comb.or %u_hint_sync.q_o, %7 {sv.namehint = "local_en"} : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %17 = llhd.prb %clk_i_0 : i1
      %18 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %hold_err, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %28 = llhd.prb %cnt_err : i1
      cf.cond_br %28, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %hold_err, %true after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %17 = llhd.prb %clk_i_0 : i1
      %18 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %combined_en_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %28 = llhd.prb %combined_en_d : i1
      llhd.drv %combined_en_q, %28 after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    hw.output %u_prim_mubi4_sender.mubi_o, %u_cg.clk_o, %u_en_sync.q_o, %u_err_sync.q_o : i4, i1, i1, i1
  }
  hw.module private @clkmgr_trans_8(in %clk_i : i1, in %clk_gated_i : i1, in %rst_ni : i1, in %en_i : i1, in %idle_i : i4, in %sw_hint_i : i1, in %scanmode_i : i4, out alert_cg_en_o : i4, out clk_o : i1, in %clk_reg_i : i1, in %rst_reg_ni : i1, out reg_en_o : i1, out reg_cnt_err_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i0 = hw.constant 0 : i0
    %c-6_i4 = hw.constant -6 : i4
    %c6_i4 = hw.constant 6 : i4
    %c-7_i4 = hw.constant -7 : i4
    %true = hw.constant true
    %c1_i4 = hw.constant 1 : i4
    %c0_i4 = hw.constant 0 : i4
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %cnt_err = llhd.sig %false : i1
    %combined_en_d = llhd.sig %false : i1
    %combined_en_q = llhd.sig %false : i1
    %hold_err = llhd.sig %false : i1
    %u_hint_sync.q_o = hw.instance "u_hint_sync" @prim_flop_2sync(clk_i: %2: i1, rst_ni: %3: i1, d_i: %sw_hint_i: i1) -> (q_o: i1) {sv.namehint = "sw_hint_synced"}
    %u_idle_sync.mubi_o = hw.instance "u_idle_sync" @prim_mubi4_sync(clk_i: %2: i1, rst_ni: %3: i1, mubi_i: %idle_i: i4) -> (mubi_o: !hw.array<1xi4>) {sv.namehint = "idle"}
    %4 = hw.array_get %u_idle_sync.mubi_o[%c0_i0] : !hw.array<1xi4>, i0
    %5 = func.call @"prim_mubi_pkg::mubi4_test_false_loose"(%4) : (i4) -> i1
    %6 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%4) : (i4) -> i1
    %7 = comb.icmp ne %u_idle_cnt.cnt_o, %c-6_i4 : i4
    %8 = comb.and %6, %7 : i1
    %u_idle_cnt.cnt_o, %u_idle_cnt.cnt_after_commit_o, %u_idle_cnt.err_o = hw.instance "u_idle_cnt" @prim_count(clk_i: %2: i1, rst_ni: %3: i1, clr_i: %5: i1, set_i: %false: i1, set_cnt_i: %c0_i4: i4, incr_en_i: %8: i1, decr_en_i: %false: i1, step_i: %c1_i4: i4, commit_i: %true: i1) -> (cnt_o: i4, cnt_after_commit_o: i4, err_o: i1) {sv.namehint = "idle_cnt"}
    llhd.drv %cnt_err, %u_idle_cnt.err_o after %1 : i1
    %u_scanmode_sync.mubi_o = hw.instance "u_scanmode_sync" @prim_mubi4_sync_0(clk_i: %2: i1, rst_ni: %3: i1, mubi_i: %scanmode_i: i4) -> (mubi_o: !hw.array<1xi4>) {sv.namehint = "scanmode"}
    %9 = comb.and %16, %en_i : i1
    %u_prim_buf_en.out_o = hw.instance "u_prim_buf_en" @prim_buf(in_i: %9: i1) -> (out_o: i1)
    llhd.drv %combined_en_d, %u_prim_buf_en.out_o after %1 : i1
    %10 = hw.array_get %u_scanmode_sync.mubi_o[%c0_i0] : !hw.array<1xi4>, i0
    %11 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%10) : (i4) -> i1
    %u_cg.clk_o = hw.instance "u_cg" @prim_clock_gating(clk_i: %clk_gated_i: i1, en_i: %16: i1, test_en_i: %11: i1) -> (clk_o: i1)
    %12 = llhd.prb %combined_en_d : i1
    %13 = comb.mux %12, %c-7_i4, %c6_i4 : i4
    %u_prim_mubi4_sender.mubi_o = hw.instance "u_prim_mubi4_sender" @prim_mubi4_sender(clk_i: %2: i1, rst_ni: %3: i1, mubi_i: %13: i4) -> (mubi_o: i4)
    %14 = llhd.prb %hold_err : i1
    %u_err_sync.q_o = hw.instance "u_err_sync" @prim_flop_2sync(clk_i: %clk_reg_i: i1, rst_ni: %rst_reg_ni: i1, d_i: %14: i1) -> (q_o: i1)
    %15 = llhd.prb %combined_en_q : i1
    %u_en_sync.q_o = hw.instance "u_en_sync" @prim_flop_2sync(clk_i: %clk_reg_i: i1, rst_ni: %rst_reg_ni: i1, d_i: %15: i1) -> (q_o: i1)
    %16 = comb.or %u_hint_sync.q_o, %7 {sv.namehint = "local_en"} : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %17 = llhd.prb %clk_i_0 : i1
      %18 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %hold_err, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %28 = llhd.prb %cnt_err : i1
      cf.cond_br %28, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %hold_err, %true after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %17 = llhd.prb %clk_i_0 : i1
      %18 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %combined_en_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %28 = llhd.prb %combined_en_d : i1
      llhd.drv %combined_en_q, %28 after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    hw.output %u_prim_mubi4_sender.mubi_o, %u_cg.clk_o, %u_en_sync.q_o, %u_err_sync.q_o : i4, i1, i1, i1
  }
}
