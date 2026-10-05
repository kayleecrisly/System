module {
  hw.module private @prim_buf(in %in_i : i1, out out_o : i1) {
    hw.output %in_i : i1
  }
  hw.module private @prim_buf_16(in %in_i : i28, out out_o : i28) {
    hw.output %in_i : i28
  }
  hw.module private @prim_buf_24(in %in_i : i2, out out_o : i2) {
    hw.output %in_i : i2
  }
  hw.module private @prim_clock_buf(in %clk_i : i1, out clk_o : i1) {
    hw.output %clk_i : i1
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
  hw.module private @prim_flop_2sync_25(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %d_i_0 = llhd.sig name "d_i" %false : i1
    %d_o = llhd.sig %false : i1
    %1 = llhd.prb %d_o : i1
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_29(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i1) -> (q_o: i1) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_29(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i1) -> (q_o: i1)
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
  hw.module private @prim_flop_2sync_27(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false {sv.namehint = "unused_sig"}
    %d_i_0 = llhd.sig name "d_i" %false : i1
    %d_o = llhd.sig %false : i1
    %1 = llhd.prb %d_o : i1
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_29(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i1) -> (q_o: i1) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_29(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i1) -> (q_o: i1)
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
  hw.module private @prim_flop_3(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
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
  hw.module private @prim_flop_29(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
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
  hw.module private @prim_flop_30(in %clk_i : i1, in %rst_ni : i1, in %d_i : i6, out q_o : i6) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i6 = hw.constant 0 : i6
    %c17_i6 = hw.constant 17 : i6
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %d_i_2 = llhd.sig name "d_i" %c0_i6 : i6
    %q_o = llhd.sig %c0_i6 : i6
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
      llhd.drv %q_o, %c17_i6 after %1 : i6
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %16 = llhd.prb %d_i_2 : i6
      llhd.drv %q_o, %16 after %1 : i6
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %d_i_2, %d_i after %0 : i6
    %4 = llhd.prb %q_o : i6
    hw.output %4 : i6
  }
  hw.module private @prim_rst_sync(in %clk_i : i1, in %d_i : i1, out q_o : i1, in %scan_rst_ni : i1, in %scanmode_i : i4) {
    %true = hw.constant true
    %u_sync.q_o = hw.instance "u_sync" @prim_flop_2sync(clk_i: %clk_i: i1, rst_ni: %d_i: i1, d_i: %true: i1) -> (q_o: i1) {sv.namehint = "rst_sync"}
    %0 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%scanmode_i) : (i4) -> i1
    %g_scan_mux.u_scan_mux.clk_o = hw.instance "g_scan_mux.u_scan_mux" @prim_clock_mux2(clk0_i: %u_sync.q_o: i1, clk1_i: %scan_rst_ni: i1, sel_i: %0: i1) -> (clk_o: i1)
    hw.output %g_scan_mux.u_scan_mux.clk_o : i1
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
    %u_prim_buf_in_req.out_o = hw.instance "u_prim_buf_in_req" @prim_sec_anchor_buf_14(in_i: %alert_req_i: i1) -> (out_o: i1) {sv.namehint = "alert_req"}
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
    %gen_async.i_sync_p.q_o = hw.instance "gen_async.i_sync_p" @prim_flop_2sync(clk_i: %2: i1, rst_ni: %3: i1, d_i: %diff_pi: i1) -> (q_o: i1)
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
  hw.module private @prim_onehot_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i28, in %addr_i : i5, in %en_i : i1, out err_o : i1) {
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
    %480 = comb.extract %oh_i from 0 : (i28) -> i1
    llhd.drv %479, %480 after %0 : i1
    %481 = llhd.sig.extract %and_tree from %c31_i6 : <i63> -> <i1>
    llhd.drv %481, %480 after %0 : i1
    %482 = llhd.sig.extract %err_tree from %c31_i6 : <i63> -> <i1>
    llhd.drv %482, %false after %0 : i1
    %483 = llhd.sig.extract %or_tree from %c-32_i6 : <i63> -> <i1>
    %484 = comb.extract %oh_i from 1 : (i28) -> i1
    llhd.drv %483, %484 after %0 : i1
    %485 = llhd.sig.extract %and_tree from %c-32_i6 : <i63> -> <i1>
    llhd.drv %485, %484 after %0 : i1
    %486 = llhd.sig.extract %err_tree from %c-32_i6 : <i63> -> <i1>
    llhd.drv %486, %false after %0 : i1
    %487 = llhd.sig.extract %or_tree from %c-31_i6 : <i63> -> <i1>
    %488 = comb.extract %oh_i from 2 : (i28) -> i1
    llhd.drv %487, %488 after %0 : i1
    %489 = llhd.sig.extract %and_tree from %c-31_i6 : <i63> -> <i1>
    llhd.drv %489, %488 after %0 : i1
    %490 = llhd.sig.extract %err_tree from %c-31_i6 : <i63> -> <i1>
    llhd.drv %490, %false after %0 : i1
    %491 = llhd.sig.extract %or_tree from %c-30_i6 : <i63> -> <i1>
    %492 = comb.extract %oh_i from 3 : (i28) -> i1
    llhd.drv %491, %492 after %0 : i1
    %493 = llhd.sig.extract %and_tree from %c-30_i6 : <i63> -> <i1>
    llhd.drv %493, %492 after %0 : i1
    %494 = llhd.sig.extract %err_tree from %c-30_i6 : <i63> -> <i1>
    llhd.drv %494, %false after %0 : i1
    %495 = llhd.sig.extract %or_tree from %c-29_i6 : <i63> -> <i1>
    %496 = comb.extract %oh_i from 4 : (i28) -> i1
    llhd.drv %495, %496 after %0 : i1
    %497 = llhd.sig.extract %and_tree from %c-29_i6 : <i63> -> <i1>
    llhd.drv %497, %496 after %0 : i1
    %498 = llhd.sig.extract %err_tree from %c-29_i6 : <i63> -> <i1>
    llhd.drv %498, %false after %0 : i1
    %499 = llhd.sig.extract %or_tree from %c-28_i6 : <i63> -> <i1>
    %500 = comb.extract %oh_i from 5 : (i28) -> i1
    llhd.drv %499, %500 after %0 : i1
    %501 = llhd.sig.extract %and_tree from %c-28_i6 : <i63> -> <i1>
    llhd.drv %501, %500 after %0 : i1
    %502 = llhd.sig.extract %err_tree from %c-28_i6 : <i63> -> <i1>
    llhd.drv %502, %false after %0 : i1
    %503 = llhd.sig.extract %or_tree from %c-27_i6 : <i63> -> <i1>
    %504 = comb.extract %oh_i from 6 : (i28) -> i1
    llhd.drv %503, %504 after %0 : i1
    %505 = llhd.sig.extract %and_tree from %c-27_i6 : <i63> -> <i1>
    llhd.drv %505, %504 after %0 : i1
    %506 = llhd.sig.extract %err_tree from %c-27_i6 : <i63> -> <i1>
    llhd.drv %506, %false after %0 : i1
    %507 = llhd.sig.extract %or_tree from %c-26_i6 : <i63> -> <i1>
    %508 = comb.extract %oh_i from 7 : (i28) -> i1
    llhd.drv %507, %508 after %0 : i1
    %509 = llhd.sig.extract %and_tree from %c-26_i6 : <i63> -> <i1>
    llhd.drv %509, %508 after %0 : i1
    %510 = llhd.sig.extract %err_tree from %c-26_i6 : <i63> -> <i1>
    llhd.drv %510, %false after %0 : i1
    %511 = llhd.sig.extract %or_tree from %c-25_i6 : <i63> -> <i1>
    %512 = comb.extract %oh_i from 8 : (i28) -> i1
    llhd.drv %511, %512 after %0 : i1
    %513 = llhd.sig.extract %and_tree from %c-25_i6 : <i63> -> <i1>
    llhd.drv %513, %512 after %0 : i1
    %514 = llhd.sig.extract %err_tree from %c-25_i6 : <i63> -> <i1>
    llhd.drv %514, %false after %0 : i1
    %515 = llhd.sig.extract %or_tree from %c-24_i6 : <i63> -> <i1>
    %516 = comb.extract %oh_i from 9 : (i28) -> i1
    llhd.drv %515, %516 after %0 : i1
    %517 = llhd.sig.extract %and_tree from %c-24_i6 : <i63> -> <i1>
    llhd.drv %517, %516 after %0 : i1
    %518 = llhd.sig.extract %err_tree from %c-24_i6 : <i63> -> <i1>
    llhd.drv %518, %false after %0 : i1
    %519 = llhd.sig.extract %or_tree from %c-23_i6 : <i63> -> <i1>
    %520 = comb.extract %oh_i from 10 : (i28) -> i1
    llhd.drv %519, %520 after %0 : i1
    %521 = llhd.sig.extract %and_tree from %c-23_i6 : <i63> -> <i1>
    llhd.drv %521, %520 after %0 : i1
    %522 = llhd.sig.extract %err_tree from %c-23_i6 : <i63> -> <i1>
    llhd.drv %522, %false after %0 : i1
    %523 = llhd.sig.extract %or_tree from %c-22_i6 : <i63> -> <i1>
    %524 = comb.extract %oh_i from 11 : (i28) -> i1
    llhd.drv %523, %524 after %0 : i1
    %525 = llhd.sig.extract %and_tree from %c-22_i6 : <i63> -> <i1>
    llhd.drv %525, %524 after %0 : i1
    %526 = llhd.sig.extract %err_tree from %c-22_i6 : <i63> -> <i1>
    llhd.drv %526, %false after %0 : i1
    %527 = llhd.sig.extract %or_tree from %c-21_i6 : <i63> -> <i1>
    %528 = comb.extract %oh_i from 12 : (i28) -> i1
    llhd.drv %527, %528 after %0 : i1
    %529 = llhd.sig.extract %and_tree from %c-21_i6 : <i63> -> <i1>
    llhd.drv %529, %528 after %0 : i1
    %530 = llhd.sig.extract %err_tree from %c-21_i6 : <i63> -> <i1>
    llhd.drv %530, %false after %0 : i1
    %531 = llhd.sig.extract %or_tree from %c-20_i6 : <i63> -> <i1>
    %532 = comb.extract %oh_i from 13 : (i28) -> i1
    llhd.drv %531, %532 after %0 : i1
    %533 = llhd.sig.extract %and_tree from %c-20_i6 : <i63> -> <i1>
    llhd.drv %533, %532 after %0 : i1
    %534 = llhd.sig.extract %err_tree from %c-20_i6 : <i63> -> <i1>
    llhd.drv %534, %false after %0 : i1
    %535 = llhd.sig.extract %or_tree from %c-19_i6 : <i63> -> <i1>
    %536 = comb.extract %oh_i from 14 : (i28) -> i1
    llhd.drv %535, %536 after %0 : i1
    %537 = llhd.sig.extract %and_tree from %c-19_i6 : <i63> -> <i1>
    llhd.drv %537, %536 after %0 : i1
    %538 = llhd.sig.extract %err_tree from %c-19_i6 : <i63> -> <i1>
    llhd.drv %538, %false after %0 : i1
    %539 = llhd.sig.extract %or_tree from %c-18_i6 : <i63> -> <i1>
    %540 = comb.extract %oh_i from 15 : (i28) -> i1
    llhd.drv %539, %540 after %0 : i1
    %541 = llhd.sig.extract %and_tree from %c-18_i6 : <i63> -> <i1>
    llhd.drv %541, %540 after %0 : i1
    %542 = llhd.sig.extract %err_tree from %c-18_i6 : <i63> -> <i1>
    llhd.drv %542, %false after %0 : i1
    %543 = llhd.sig.extract %or_tree from %c-17_i6 : <i63> -> <i1>
    %544 = comb.extract %oh_i from 16 : (i28) -> i1
    llhd.drv %543, %544 after %0 : i1
    %545 = llhd.sig.extract %and_tree from %c-17_i6 : <i63> -> <i1>
    llhd.drv %545, %544 after %0 : i1
    %546 = llhd.sig.extract %err_tree from %c-17_i6 : <i63> -> <i1>
    llhd.drv %546, %false after %0 : i1
    %547 = llhd.sig.extract %or_tree from %c-16_i6 : <i63> -> <i1>
    %548 = comb.extract %oh_i from 17 : (i28) -> i1
    llhd.drv %547, %548 after %0 : i1
    %549 = llhd.sig.extract %and_tree from %c-16_i6 : <i63> -> <i1>
    llhd.drv %549, %548 after %0 : i1
    %550 = llhd.sig.extract %err_tree from %c-16_i6 : <i63> -> <i1>
    llhd.drv %550, %false after %0 : i1
    %551 = llhd.sig.extract %or_tree from %c-15_i6 : <i63> -> <i1>
    %552 = comb.extract %oh_i from 18 : (i28) -> i1
    llhd.drv %551, %552 after %0 : i1
    %553 = llhd.sig.extract %and_tree from %c-15_i6 : <i63> -> <i1>
    llhd.drv %553, %552 after %0 : i1
    %554 = llhd.sig.extract %err_tree from %c-15_i6 : <i63> -> <i1>
    llhd.drv %554, %false after %0 : i1
    %555 = llhd.sig.extract %or_tree from %c-14_i6 : <i63> -> <i1>
    %556 = comb.extract %oh_i from 19 : (i28) -> i1
    llhd.drv %555, %556 after %0 : i1
    %557 = llhd.sig.extract %and_tree from %c-14_i6 : <i63> -> <i1>
    llhd.drv %557, %556 after %0 : i1
    %558 = llhd.sig.extract %err_tree from %c-14_i6 : <i63> -> <i1>
    llhd.drv %558, %false after %0 : i1
    %559 = llhd.sig.extract %or_tree from %c-13_i6 : <i63> -> <i1>
    %560 = comb.extract %oh_i from 20 : (i28) -> i1
    llhd.drv %559, %560 after %0 : i1
    %561 = llhd.sig.extract %and_tree from %c-13_i6 : <i63> -> <i1>
    llhd.drv %561, %560 after %0 : i1
    %562 = llhd.sig.extract %err_tree from %c-13_i6 : <i63> -> <i1>
    llhd.drv %562, %false after %0 : i1
    %563 = llhd.sig.extract %or_tree from %c-12_i6 : <i63> -> <i1>
    %564 = comb.extract %oh_i from 21 : (i28) -> i1
    llhd.drv %563, %564 after %0 : i1
    %565 = llhd.sig.extract %and_tree from %c-12_i6 : <i63> -> <i1>
    llhd.drv %565, %564 after %0 : i1
    %566 = llhd.sig.extract %err_tree from %c-12_i6 : <i63> -> <i1>
    llhd.drv %566, %false after %0 : i1
    %567 = llhd.sig.extract %or_tree from %c-11_i6 : <i63> -> <i1>
    %568 = comb.extract %oh_i from 22 : (i28) -> i1
    llhd.drv %567, %568 after %0 : i1
    %569 = llhd.sig.extract %and_tree from %c-11_i6 : <i63> -> <i1>
    llhd.drv %569, %568 after %0 : i1
    %570 = llhd.sig.extract %err_tree from %c-11_i6 : <i63> -> <i1>
    llhd.drv %570, %false after %0 : i1
    %571 = llhd.sig.extract %or_tree from %c-10_i6 : <i63> -> <i1>
    %572 = comb.extract %oh_i from 23 : (i28) -> i1
    llhd.drv %571, %572 after %0 : i1
    %573 = llhd.sig.extract %and_tree from %c-10_i6 : <i63> -> <i1>
    llhd.drv %573, %572 after %0 : i1
    %574 = llhd.sig.extract %err_tree from %c-10_i6 : <i63> -> <i1>
    llhd.drv %574, %false after %0 : i1
    %575 = llhd.sig.extract %or_tree from %c-9_i6 : <i63> -> <i1>
    %576 = comb.extract %oh_i from 24 : (i28) -> i1
    llhd.drv %575, %576 after %0 : i1
    %577 = llhd.sig.extract %and_tree from %c-9_i6 : <i63> -> <i1>
    llhd.drv %577, %576 after %0 : i1
    %578 = llhd.sig.extract %err_tree from %c-9_i6 : <i63> -> <i1>
    llhd.drv %578, %false after %0 : i1
    %579 = llhd.sig.extract %or_tree from %c-8_i6 : <i63> -> <i1>
    %580 = comb.extract %oh_i from 25 : (i28) -> i1
    llhd.drv %579, %580 after %0 : i1
    %581 = llhd.sig.extract %and_tree from %c-8_i6 : <i63> -> <i1>
    llhd.drv %581, %580 after %0 : i1
    %582 = llhd.sig.extract %err_tree from %c-8_i6 : <i63> -> <i1>
    llhd.drv %582, %false after %0 : i1
    %583 = llhd.sig.extract %or_tree from %c-7_i6 : <i63> -> <i1>
    %584 = comb.extract %oh_i from 26 : (i28) -> i1
    llhd.drv %583, %584 after %0 : i1
    %585 = llhd.sig.extract %and_tree from %c-7_i6 : <i63> -> <i1>
    llhd.drv %585, %584 after %0 : i1
    %586 = llhd.sig.extract %err_tree from %c-7_i6 : <i63> -> <i1>
    llhd.drv %586, %false after %0 : i1
    %587 = llhd.sig.extract %or_tree from %c-6_i6 : <i63> -> <i1>
    %588 = comb.extract %oh_i from 27 : (i28) -> i1
    llhd.drv %587, %588 after %0 : i1
    %589 = llhd.sig.extract %and_tree from %c-6_i6 : <i63> -> <i1>
    llhd.drv %589, %588 after %0 : i1
    %590 = llhd.sig.extract %err_tree from %c-6_i6 : <i63> -> <i1>
    llhd.drv %590, %false after %0 : i1
    %591 = llhd.sig.extract %or_tree from %c-5_i6 : <i63> -> <i1>
    llhd.drv %591, %false after %0 : i1
    %592 = llhd.sig.extract %and_tree from %c-5_i6 : <i63> -> <i1>
    llhd.drv %592, %false after %0 : i1
    %593 = llhd.sig.extract %err_tree from %c-5_i6 : <i63> -> <i1>
    llhd.drv %593, %false after %0 : i1
    %594 = llhd.sig.extract %or_tree from %c-4_i6 : <i63> -> <i1>
    llhd.drv %594, %false after %0 : i1
    %595 = llhd.sig.extract %and_tree from %c-4_i6 : <i63> -> <i1>
    llhd.drv %595, %false after %0 : i1
    %596 = llhd.sig.extract %err_tree from %c-4_i6 : <i63> -> <i1>
    llhd.drv %596, %false after %0 : i1
    %597 = llhd.sig.extract %or_tree from %c-3_i6 : <i63> -> <i1>
    llhd.drv %597, %false after %0 : i1
    %598 = llhd.sig.extract %and_tree from %c-3_i6 : <i63> -> <i1>
    llhd.drv %598, %false after %0 : i1
    %599 = llhd.sig.extract %err_tree from %c-3_i6 : <i63> -> <i1>
    llhd.drv %599, %false after %0 : i1
    %600 = llhd.sig.extract %or_tree from %c-2_i6 : <i63> -> <i1>
    llhd.drv %600, %false after %0 : i1
    %601 = llhd.sig.extract %and_tree from %c-2_i6 : <i63> -> <i1>
    llhd.drv %601, %false after %0 : i1
    %602 = llhd.sig.extract %err_tree from %c-2_i6 : <i63> -> <i1>
    llhd.drv %602, %false after %0 : i1
    %603 = comb.or %604, %607 : i1
    %604 = comb.extract %17 from 0 {sv.namehint = "oh0_err"} : (i63) -> i1
    %605 = comb.xor %en_i, %true : i1
    %606 = comb.extract %2 from 0 : (i63) -> i1
    %607 = comb.and %605, %606 {sv.namehint = "enable_err"} : i1
    hw.output %603 : i1
  }
  hw.module private @prim_reg_we_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i28, in %en_i : i1, out err_o : i1) {
    %c0_i5 = hw.constant 0 : i5
    %u_prim_buf.out_o = hw.instance "u_prim_buf" @prim_buf_16(in_i: %oh_i: i28) -> (out_o: i28) {sv.namehint = "oh_buf"}
    %u_prim_onehot_check.err_o = hw.instance "u_prim_onehot_check" @prim_onehot_check(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, oh_i: %u_prim_buf.out_o: i28, addr_i: %c0_i5: i5, en_i: %en_i: i1) -> (err_o: i1)
    hw.output %u_prim_onehot_check.err_o : i1
  }
  hw.module private @prim_sec_anchor_buf(in %in_i : i2, out out_o : i2) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf_24(in_i: %in_i: i2) -> (out_o: i2)
    hw.output %u_secure_anchor_buf.out_o : i2
  }
  hw.module private @prim_sec_anchor_buf_14(in %in_i : i1, out out_o : i1) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf(in_i: %in_i: i1) -> (out_o: i1)
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
  hw.module private @prim_sparse_fsm_flop(in %clk_i : i1, in %rst_ni : i1, in %state_i : i6, out state_o : i6) {
    %u_state_flop.q_o = hw.instance "u_state_flop" @prim_flop_30(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %state_i: i6) -> (q_o: i6) {sv.namehint = "state_raw"}
    hw.output %u_state_flop.q_o : i6
  }
  hw.module private @prim_sparse_fsm_flop_28(in %clk_i : i1, in %rst_ni : i1, in %state_i : i6, out state_o : i6) {
    %u_state_flop.q_o = hw.instance "u_state_flop" @prim_flop_30(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %state_i: i6) -> (q_o: i6) {sv.namehint = "state_raw"}
    hw.output %u_state_flop.q_o : i6
  }
  hw.module private @prim_subreg_arb(in %we : i1, in %wd : i4, in %de : i1, in %d : i4, in %q : i4, out wr_en : i1, out wr_data : i4) {
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
    %6 = comb.xor %5, %true : i1
    %7 = comb.xor %we, %true : i1
    %8 = comb.or %7, %6 : i1
    %9 = comb.and %4, %8 : i1
    llhd.drv %wd_0, %wd after %0 : i1
    llhd.drv %d_1, %d after %0 : i1
    llhd.drv %q_2, %q after %0 : i1
    hw.output %1, %9 : i1, i1
  }
  hw.module private @prim_subreg_arb_19(in %we : i1, in %wd : i5, in %de : i1, in %d : i5, in %q : i5, out wr_en : i1, out wr_data : i5) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c-1_i5 = hw.constant -1 : i5
    %c0_i5 = hw.constant 0 : i5
    %wd_0 = llhd.sig name "wd" %c0_i5 : i5
    %d_1 = llhd.sig name "d" %c0_i5 : i5
    %q_2 = llhd.sig name "q" %c0_i5 : i5
    %1 = comb.or %we, %de : i1
    %2 = llhd.prb %d_1 : i5
    %3 = llhd.prb %q_2 : i5
    %4 = comb.mux %de, %2, %3 : i5
    %5 = llhd.prb %wd_0 : i5
    %6 = comb.replicate %we : (i1) -> i5
    %7 = comb.and %6, %5 : i5
    %8 = comb.xor %7, %c-1_i5 : i5
    %9 = comb.and %4, %8 : i5
    llhd.drv %wd_0, %wd after %0 : i5
    llhd.drv %d_1, %d after %0 : i5
    llhd.drv %q_2, %q after %0 : i5
    hw.output %1, %9 : i1, i5
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
  hw.module private @prim_subreg_arb_23(in %we : i1, in %wd : i1, in %de : i1, in %d : i1, in %q : i1, out wr_en : i1, out wr_data : i1) {
    hw.output %de, %d : i1, i1
  }
  hw.module private @prim_subreg_ext(in %re : i1, in %we : i1, in %wd : i1, in %d : i1, out qe : i1, out qre : i1, out q : i1, out ds : i1, out qs : i1) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i1, i1, i1
  }
  hw.module private @prim_subreg_ext_10(in %re : i1, in %we : i1, in %wd : i4, in %d : i4, out qe : i1, out qre : i1, out q : i4, out ds : i4, out qs : i4) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i4, i4, i4
  }
  hw.module private @prim_subreg_ext_11(in %re : i1, in %we : i1, in %wd : i32, in %d : i32, out qe : i1, out qre : i1, out q : i32, out ds : i32, out qs : i32) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i32, i32, i32
  }
  hw.module private @prim_subreg(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i4, in %de : i1, in %d : i4, out qe : i1, out q : i4, out ds : i4, out qs : i4) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb(we: %we: i1, wd: %wd: i4, de: %de: i1, d: %d: i4, q: %4: i4) -> (wr_en: i1, wr_data: i4)
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
  hw.module private @prim_subreg_4(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i1, in %de : i1, in %d : i1, out qe : i1, out q : i1, out ds : i1, out qs : i1) {
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
  hw.module private @prim_subreg_5(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i1, in %de : i1, in %d : i1, out qe : i1, out q : i1, out ds : i1, out qs : i1) {
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
  hw.module private @prim_subreg_6(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i5, in %de : i1, in %d : i5, out qe : i1, out q : i5, out ds : i5, out qs : i5) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_19(we: %we: i1, wd: %wd: i5, de: %de: i1, d: %d: i5, q: %4: i5) -> (wr_en: i1, wr_data: i5)
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
  hw.module private @prim_subreg_8(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i1, in %de : i1, in %d : i1, out qe : i1, out q : i1, out ds : i1, out qs : i1) {
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
  hw.module private @prim_subreg_12(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i1, in %de : i1, in %d : i1, out qe : i1, out q : i1, out ds : i1, out qs : i1) {
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
  hw.module private @prim_subreg_13(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i1, in %de : i1, in %d : i1, out qe : i1, out q : i1, out ds : i1, out qs : i1) {
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
  hw.module private @prim_mubi4_sync(in %clk_i : i1, in %rst_ni : i1, in %mubi_i : i4, out mubi_o : !hw.array<1xi4>) {
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
  hw.module private @prim_mubi4_sender(in %clk_i : i1, in %rst_ni : i1, in %mubi_i : i4, out mubi_o : i4) {
    %gen_flops.u_prim_flop.q_o = hw.instance "gen_flops.u_prim_flop" @prim_flop_3(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %mubi_i: i4) -> (q_o: i4) {sv.namehint = "mubi_out"}
    hw.output %gen_flops.u_prim_flop.q_o : i4
  }
  hw.module private @rstmgr_cnsty_chk(in %clk_i : i1, in %rst_ni : i1, in %child_clk_i : i1, in %child_rst_ni : i1, in %child_chk_rst_ni : i1, in %parent_rst_ni : i1, in %sw_rst_req_i : i1, out sw_rst_req_clr_o : i1, out err_o : i1, out fsm_err_o : i1) {
    %c0_i30 = hw.constant 0 : i30
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i6 = hw.constant 0 : i6
    %c8_i6 = hw.constant 8 : i6
    %c-6_i6 = hw.constant -6 : i6
    %c22_i6 = hw.constant 22 : i6
    %c15_i6 = hw.constant 15 : i6
    %c-3_i6 = hw.constant -3 : i6
    %c-28_i6 = hw.constant -28 : i6
    %c-29_i6 = hw.constant -29 : i6
    %c17_i6 = hw.constant 17 : i6
    %c1_i2 = hw.constant 1 : i2
    %c0_i2 = hw.constant 0 : i2
    %c2_i32 = hw.constant 2 : i32
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %child_rst_ni_2 = llhd.sig name "child_rst_ni" %false : i1
    %4 = llhd.prb %child_rst_ni_2 : i1
    %parent_rst_ni_3 = llhd.sig name "parent_rst_ni" %false : i1
    %5 = llhd.prb %parent_rst_ni_3 : i1
    %sw_rst_req_clr_o = llhd.sig %false : i1
    %err_o = llhd.sig %false : i1
    %fsm_err_o = llhd.sig %false : i1
    %parent_rst_asserted = llhd.sig %false : i1
    %child_rst_asserted = llhd.sig %false : i1
    %sync_parent_rst = llhd.sig %false : i1
    %sync_child_rst = llhd.sig %false : i1
    %state_q = llhd.sig %c0_i6 : i6
    %state_d = llhd.sig %c0_i6 : i6
    %timeout = llhd.sig %false : i1
    %cnt_inc = llhd.sig %false : i1
    %cnt_clr = llhd.sig %false : i1
    %cnt = llhd.sig %c0_i2 : i2
    %src_valid = llhd.sig %false : i1
    %sync_child_ack = llhd.sig %false : i1
    %6 = llhd.prb %parent_rst_asserted : i1
    %u_parent_sync.q_o = hw.instance "u_parent_sync" @prim_flop_2sync_27(clk_i: %2: i1, rst_ni: %3: i1, d_i: %6: i1) -> (q_o: i1)
    llhd.drv %sync_parent_rst, %u_parent_sync.q_o after %1 : i1
    %7 = llhd.prb %child_rst_asserted : i1
    %u_child_sync.q_o = hw.instance "u_child_sync" @prim_flop_2sync_25(clk_i: %2: i1, rst_ni: %3: i1, d_i: %7: i1) -> (q_o: i1)
    llhd.drv %sync_child_rst, %u_child_sync.q_o after %1 : i1
    %8 = llhd.prb %state_d : i6
    %u_state_regs.state_o = hw.instance "u_state_regs" @prim_sparse_fsm_flop(clk_i: %2: i1, rst_ni: %3: i1, state_i: %8: i6) -> (state_o: i6)
    llhd.drv %state_q, %u_state_regs.state_o after %1 : i6
    %u_child_handshake.src_ack_o, %u_child_handshake.dst_req_o = hw.instance "u_child_handshake" @prim_sync_reqack(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %child_clk_i: i1, rst_dst_ni: %child_chk_rst_ni: i1, req_chk_i: %false: i1, src_req_i: %true: i1, dst_ack_i: %u_child_handshake.dst_req_o: i1) -> (src_ack_o: i1, dst_req_o: i1) {sv.namehint = "child_ack"}
    llhd.drv %sync_child_ack, %u_child_handshake.src_ack_o after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %23 = llhd.prb %clk_i_0 : i1
      %24 = llhd.prb %parent_rst_ni_3 : i1
      llhd.wait (%2, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %25 = llhd.prb %clk_i_0 : i1
      %26 = comb.xor bin %23, %true : i1
      %27 = comb.and bin %26, %25 : i1
      %28 = llhd.prb %parent_rst_ni_3 : i1
      %29 = comb.xor bin %28, %true : i1
      %30 = comb.and bin %24, %29 : i1
      %31 = comb.or bin %27, %30 : i1
      cf.cond_br %31, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %32 = llhd.prb %parent_rst_ni_3 : i1
      %33 = comb.xor %32, %true : i1
      cf.cond_br %33, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %parent_rst_asserted, %true after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      llhd.drv %parent_rst_asserted, %false after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %23 = llhd.prb %clk_i_0 : i1
      %24 = llhd.prb %child_rst_ni_2 : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %25 = llhd.prb %clk_i_0 : i1
      %26 = comb.xor bin %23, %true : i1
      %27 = comb.and bin %26, %25 : i1
      %28 = llhd.prb %child_rst_ni_2 : i1
      %29 = comb.xor bin %28, %true : i1
      %30 = comb.and bin %24, %29 : i1
      %31 = comb.or bin %27, %30 : i1
      cf.cond_br %31, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %32 = llhd.prb %child_rst_ni_2 : i1
      %33 = comb.xor %32, %true : i1
      cf.cond_br %33, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %child_rst_asserted, %true after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      llhd.drv %child_rst_asserted, %false after %0 : i1
      cf.br ^bb1
    }
    %9 = llhd.prb %cnt : i2
    %10 = comb.concat %c0_i30, %9 : i30, i2
    %11 = comb.icmp sgt %10, %c2_i32 : i32
    llhd.drv %timeout, %11 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %23 = llhd.prb %clk_i_0 : i1
      %24 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %cnt, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %34 = llhd.prb %cnt_clr : i1
      cf.cond_br %34, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %cnt, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %35 = llhd.prb %cnt_inc : i1
      %36 = llhd.prb %timeout : i1
      %37 = comb.xor %36, %true : i1
      %38 = comb.and %35, %37 : i1
      cf.cond_br %38, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %39 = llhd.prb %cnt : i2
      %40 = comb.add %39, %c1_i2 : i2
      llhd.drv %cnt, %40 after %0 : i2
      cf.br ^bb1
    }
    %12 = llhd.prb %sync_parent_rst : i1
    llhd.drv %src_valid, %12 after %1 : i1
    %13 = llhd.prb %state_q : i6
    %14 = llhd.prb %err_o : i1
    %15 = llhd.prb %fsm_err_o : i1
    %16 = llhd.prb %cnt_inc : i1
    %17 = llhd.prb %cnt_clr : i1
    %18 = llhd.prb %sw_rst_req_clr_o : i1
    %19 = llhd.prb %sync_child_rst : i1
    %20 = llhd.prb %src_valid : i1
    %21 = llhd.prb %timeout : i1
    %22 = llhd.prb %sync_child_ack : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb38
      %23 = llhd.prb %state_q : i6
      llhd.drv %state_d, %23 after %1 : i6
      llhd.drv %err_o, %false after %1 : i1
      llhd.drv %fsm_err_o, %false after %1 : i1
      llhd.drv %cnt_inc, %false after %1 : i1
      llhd.drv %cnt_clr, %false after %1 : i1
      llhd.drv %sw_rst_req_clr_o, %false after %1 : i1
      %24 = llhd.prb %state_q : i6
      %25 = comb.icmp ceq %24, %c17_i6 : i6
      cf.cond_br %25, ^bb2, ^bb4
    ^bb2:  // pred: ^bb1
      %26 = llhd.prb %sync_child_rst : i1
      %27 = comb.xor %26, %true : i1
      %28 = llhd.prb %sync_parent_rst : i1
      %29 = comb.xor %28, %true : i1
      %30 = comb.and %27, %29 : i1
      cf.cond_br %30, ^bb3, ^bb38
    ^bb3:  // pred: ^bb2
      llhd.drv %state_d, %c-29_i6 after %1 : i6
      cf.br ^bb38
    ^bb4:  // pred: ^bb1
      %31 = comb.icmp ceq %24, %c-29_i6 : i6
      cf.cond_br %31, ^bb5, ^bb11
    ^bb5:  // pred: ^bb4
      %32 = llhd.prb %sync_child_rst : i1
      %33 = llhd.prb %src_valid : i1
      %34 = comb.and %32, %33 : i1
      cf.cond_br %34, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %state_d, %c-28_i6 after %1 : i6
      cf.br ^bb38
    ^bb7:  // pred: ^bb5
      %35 = llhd.prb %sync_child_rst : i1
      %36 = llhd.prb %sync_parent_rst : i1
      %37 = comb.xor %36, %true : i1
      %38 = comb.and %35, %37 : i1
      cf.cond_br %38, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %state_d, %c-3_i6 after %1 : i6
      cf.br ^bb38
    ^bb9:  // pred: ^bb7
      %39 = llhd.prb %sync_parent_rst : i1
      %40 = llhd.prb %sync_child_rst : i1
      %41 = comb.xor %40, %true : i1
      %42 = comb.and %39, %41 : i1
      cf.cond_br %42, ^bb10, ^bb38
    ^bb10:  // pred: ^bb9
      llhd.drv %state_d, %c15_i6 after %1 : i6
      cf.br ^bb38
    ^bb11:  // pred: ^bb4
      %43 = comb.icmp ceq %24, %c-3_i6 : i6
      cf.cond_br %43, ^bb12, ^bb16
    ^bb12:  // pred: ^bb11
      llhd.drv %cnt_inc, %true after %1 : i1
      %44 = llhd.prb %timeout : i1
      %45 = llhd.prb %sync_parent_rst : i1
      %46 = comb.xor %45, %true : i1
      %47 = comb.and %44, %46 : i1
      cf.cond_br %47, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      llhd.drv %state_d, %c22_i6 after %1 : i6
      cf.br ^bb38
    ^bb14:  // pred: ^bb12
      %48 = llhd.prb %sync_parent_rst : i1
      cf.cond_br %48, ^bb15, ^bb38
    ^bb15:  // pred: ^bb14
      llhd.drv %state_d, %c-28_i6 after %1 : i6
      llhd.drv %cnt_clr, %true after %1 : i1
      cf.br ^bb38
    ^bb16:  // pred: ^bb11
      %49 = comb.icmp ceq %24, %c15_i6 : i6
      cf.cond_br %49, ^bb17, ^bb21
    ^bb17:  // pred: ^bb16
      llhd.drv %cnt_inc, %true after %1 : i1
      %50 = llhd.prb %timeout : i1
      %51 = llhd.prb %sync_child_rst : i1
      %52 = comb.xor %51, %true : i1
      %53 = comb.and %50, %52 : i1
      cf.cond_br %53, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      llhd.drv %state_d, %c22_i6 after %1 : i6
      cf.br ^bb38
    ^bb19:  // pred: ^bb17
      %54 = llhd.prb %sync_child_rst : i1
      cf.cond_br %54, ^bb20, ^bb38
    ^bb20:  // pred: ^bb19
      llhd.drv %state_d, %c-28_i6 after %1 : i6
      llhd.drv %cnt_clr, %true after %1 : i1
      cf.br ^bb38
    ^bb21:  // pred: ^bb16
      %55 = comb.icmp ceq %24, %c-28_i6 : i6
      cf.cond_br %55, ^bb22, ^bb26
    ^bb22:  // pred: ^bb21
      llhd.drv %sw_rst_req_clr_o, %true after %1 : i1
      %56 = llhd.prb %sync_child_rst : i1
      %57 = comb.xor %56, %true : i1
      %58 = llhd.prb %src_valid : i1
      %59 = comb.and %57, %58 : i1
      cf.cond_br %59, ^bb23, ^bb24
    ^bb23:  // pred: ^bb22
      llhd.drv %state_d, %c22_i6 after %1 : i6
      cf.br ^bb38
    ^bb24:  // pred: ^bb22
      %60 = llhd.prb %src_valid : i1
      %61 = comb.xor %60, %true : i1
      cf.cond_br %61, ^bb25, ^bb38
    ^bb25:  // pred: ^bb24
      llhd.drv %cnt_clr, %true after %1 : i1
      llhd.drv %state_d, %c-6_i6 after %1 : i6
      cf.br ^bb38
    ^bb26:  // pred: ^bb21
      %62 = comb.icmp ceq %24, %c-6_i6 : i6
      cf.cond_br %62, ^bb27, ^bb33
    ^bb27:  // pred: ^bb26
      %63 = llhd.prb %sync_child_ack : i1
      llhd.drv %cnt_inc, %63 after %1 : i1
      %64 = llhd.prb %sync_child_rst : i1
      %65 = llhd.prb %src_valid : i1
      %66 = comb.and %64, %65 : i1
      cf.cond_br %66, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      llhd.drv %state_d, %c-28_i6 after %1 : i6
      llhd.drv %cnt_clr, %true after %1 : i1
      cf.br ^bb38
    ^bb29:  // pred: ^bb27
      %67 = llhd.prb %sync_child_rst : i1
      %68 = llhd.prb %timeout : i1
      %69 = comb.and %67, %68 : i1
      cf.cond_br %69, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      llhd.drv %state_d, %c22_i6 after %1 : i6
      cf.br ^bb38
    ^bb31:  // pred: ^bb29
      %70 = llhd.prb %sync_child_rst : i1
      %71 = comb.xor %70, %true : i1
      cf.cond_br %71, ^bb32, ^bb38
    ^bb32:  // pred: ^bb31
      llhd.drv %state_d, %c-29_i6 after %1 : i6
      llhd.drv %cnt_clr, %true after %1 : i1
      cf.br ^bb38
    ^bb33:  // pred: ^bb26
      %72 = comb.icmp ceq %24, %c22_i6 : i6
      cf.cond_br %72, ^bb34, ^bb35
    ^bb34:  // pred: ^bb33
      llhd.drv %err_o, %true after %1 : i1
      cf.br ^bb38
    ^bb35:  // pred: ^bb33
      %73 = comb.icmp ceq %24, %c8_i6 : i6
      cf.cond_br %73, ^bb36, ^bb37
    ^bb36:  // pred: ^bb35
      llhd.drv %fsm_err_o, %true after %1 : i1
      cf.br ^bb38
    ^bb37:  // pred: ^bb35
      llhd.drv %state_d, %c8_i6 after %1 : i6
      llhd.drv %fsm_err_o, %true after %1 : i1
      cf.br ^bb38
    ^bb38:  // 22 preds: ^bb2, ^bb3, ^bb6, ^bb8, ^bb9, ^bb10, ^bb13, ^bb14, ^bb15, ^bb18, ^bb19, ^bb20, ^bb23, ^bb24, ^bb25, ^bb28, ^bb30, ^bb31, ^bb32, ^bb34, ^bb36, ^bb37
      llhd.wait (%13, %8, %14, %15, %16, %17, %18, %19, %12, %20, %21, %22 : i6, i6, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %child_rst_ni_2, %child_rst_ni after %1 : i1
    llhd.drv %parent_rst_ni_3, %parent_rst_ni after %1 : i1
    hw.output %18, %14, %15 : i1, i1, i1
  }
  hw.module private @rstmgr_cnsty_chk_15(in %clk_i : i1, in %rst_ni : i1, in %child_clk_i : i1, in %child_rst_ni : i1, in %child_chk_rst_ni : i1, in %parent_rst_ni : i1, in %sw_rst_req_i : i1, out sw_rst_req_clr_o : i1, out err_o : i1, out fsm_err_o : i1) {
    %c0_i30 = hw.constant 0 : i30
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i6 = hw.constant 0 : i6
    %c8_i6 = hw.constant 8 : i6
    %c-6_i6 = hw.constant -6 : i6
    %c22_i6 = hw.constant 22 : i6
    %c15_i6 = hw.constant 15 : i6
    %c-3_i6 = hw.constant -3 : i6
    %c-28_i6 = hw.constant -28 : i6
    %c-29_i6 = hw.constant -29 : i6
    %c17_i6 = hw.constant 17 : i6
    %c1_i2 = hw.constant 1 : i2
    %c0_i2 = hw.constant 0 : i2
    %c2_i32 = hw.constant 2 : i32
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %child_rst_ni_2 = llhd.sig name "child_rst_ni" %false : i1
    %4 = llhd.prb %child_rst_ni_2 : i1
    %parent_rst_ni_3 = llhd.sig name "parent_rst_ni" %false : i1
    %5 = llhd.prb %parent_rst_ni_3 : i1
    %sw_rst_req_clr_o = llhd.sig %false : i1
    %err_o = llhd.sig %false : i1
    %fsm_err_o = llhd.sig %false : i1
    %parent_rst_asserted = llhd.sig %false : i1
    %child_rst_asserted = llhd.sig %false : i1
    %sync_parent_rst = llhd.sig %false : i1
    %sync_child_rst = llhd.sig %false : i1
    %state_q = llhd.sig %c0_i6 : i6
    %state_d = llhd.sig %c0_i6 : i6
    %timeout = llhd.sig %false : i1
    %cnt_inc = llhd.sig %false : i1
    %cnt_clr = llhd.sig %false : i1
    %cnt = llhd.sig %c0_i2 : i2
    %src_valid = llhd.sig %false : i1
    %sync_child_ack = llhd.sig %false : i1
    %6 = llhd.prb %parent_rst_asserted : i1
    %u_parent_sync.q_o = hw.instance "u_parent_sync" @prim_flop_2sync_27(clk_i: %2: i1, rst_ni: %3: i1, d_i: %6: i1) -> (q_o: i1)
    llhd.drv %sync_parent_rst, %u_parent_sync.q_o after %1 : i1
    %7 = llhd.prb %child_rst_asserted : i1
    %u_child_sync.q_o = hw.instance "u_child_sync" @prim_flop_2sync_25(clk_i: %2: i1, rst_ni: %3: i1, d_i: %7: i1) -> (q_o: i1)
    llhd.drv %sync_child_rst, %u_child_sync.q_o after %1 : i1
    %8 = llhd.prb %state_d : i6
    %u_state_regs.state_o = hw.instance "u_state_regs" @prim_sparse_fsm_flop_28(clk_i: %2: i1, rst_ni: %3: i1, state_i: %8: i6) -> (state_o: i6)
    llhd.drv %state_q, %u_state_regs.state_o after %1 : i6
    %u_child_handshake.src_ack_o, %u_child_handshake.dst_req_o = hw.instance "u_child_handshake" @prim_sync_reqack(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %child_clk_i: i1, rst_dst_ni: %child_chk_rst_ni: i1, req_chk_i: %false: i1, src_req_i: %true: i1, dst_ack_i: %u_child_handshake.dst_req_o: i1) -> (src_ack_o: i1, dst_req_o: i1) {sv.namehint = "child_ack"}
    llhd.drv %sync_child_ack, %u_child_handshake.src_ack_o after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %24 = llhd.prb %clk_i_0 : i1
      %25 = llhd.prb %parent_rst_ni_3 : i1
      llhd.wait (%2, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %26 = llhd.prb %clk_i_0 : i1
      %27 = comb.xor bin %24, %true : i1
      %28 = comb.and bin %27, %26 : i1
      %29 = llhd.prb %parent_rst_ni_3 : i1
      %30 = comb.xor bin %29, %true : i1
      %31 = comb.and bin %25, %30 : i1
      %32 = comb.or bin %28, %31 : i1
      cf.cond_br %32, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %33 = llhd.prb %parent_rst_ni_3 : i1
      %34 = comb.xor %33, %true : i1
      cf.cond_br %34, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %parent_rst_asserted, %true after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      llhd.drv %parent_rst_asserted, %false after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %24 = llhd.prb %clk_i_0 : i1
      %25 = llhd.prb %child_rst_ni_2 : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %26 = llhd.prb %clk_i_0 : i1
      %27 = comb.xor bin %24, %true : i1
      %28 = comb.and bin %27, %26 : i1
      %29 = llhd.prb %child_rst_ni_2 : i1
      %30 = comb.xor bin %29, %true : i1
      %31 = comb.and bin %25, %30 : i1
      %32 = comb.or bin %28, %31 : i1
      cf.cond_br %32, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %33 = llhd.prb %child_rst_ni_2 : i1
      %34 = comb.xor %33, %true : i1
      cf.cond_br %34, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %child_rst_asserted, %true after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      llhd.drv %child_rst_asserted, %false after %0 : i1
      cf.br ^bb1
    }
    %9 = llhd.prb %cnt : i2
    %10 = comb.concat %c0_i30, %9 : i30, i2
    %11 = comb.icmp sgt %10, %c2_i32 : i32
    llhd.drv %timeout, %11 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %24 = llhd.prb %clk_i_0 : i1
      %25 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %cnt, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %35 = llhd.prb %cnt_clr : i1
      cf.cond_br %35, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %cnt, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %36 = llhd.prb %cnt_inc : i1
      %37 = llhd.prb %timeout : i1
      %38 = comb.xor %37, %true : i1
      %39 = comb.and %36, %38 : i1
      cf.cond_br %39, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %40 = llhd.prb %cnt : i2
      %41 = comb.add %40, %c1_i2 : i2
      llhd.drv %cnt, %41 after %0 : i2
      cf.br ^bb1
    }
    %12 = llhd.prb %sync_parent_rst : i1
    %13 = comb.or %12, %sw_rst_req_i : i1
    llhd.drv %src_valid, %13 after %1 : i1
    %14 = llhd.prb %state_q : i6
    %15 = llhd.prb %err_o : i1
    %16 = llhd.prb %fsm_err_o : i1
    %17 = llhd.prb %cnt_inc : i1
    %18 = llhd.prb %cnt_clr : i1
    %19 = llhd.prb %sw_rst_req_clr_o : i1
    %20 = llhd.prb %sync_child_rst : i1
    %21 = llhd.prb %src_valid : i1
    %22 = llhd.prb %timeout : i1
    %23 = llhd.prb %sync_child_ack : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb38
      %24 = llhd.prb %state_q : i6
      llhd.drv %state_d, %24 after %1 : i6
      llhd.drv %err_o, %false after %1 : i1
      llhd.drv %fsm_err_o, %false after %1 : i1
      llhd.drv %cnt_inc, %false after %1 : i1
      llhd.drv %cnt_clr, %false after %1 : i1
      llhd.drv %sw_rst_req_clr_o, %false after %1 : i1
      %25 = llhd.prb %state_q : i6
      %26 = comb.icmp ceq %25, %c17_i6 : i6
      cf.cond_br %26, ^bb2, ^bb4
    ^bb2:  // pred: ^bb1
      %27 = llhd.prb %sync_child_rst : i1
      %28 = comb.xor %27, %true : i1
      %29 = llhd.prb %sync_parent_rst : i1
      %30 = comb.xor %29, %true : i1
      %31 = comb.and %28, %30 : i1
      cf.cond_br %31, ^bb3, ^bb38
    ^bb3:  // pred: ^bb2
      llhd.drv %state_d, %c-29_i6 after %1 : i6
      cf.br ^bb38
    ^bb4:  // pred: ^bb1
      %32 = comb.icmp ceq %25, %c-29_i6 : i6
      cf.cond_br %32, ^bb5, ^bb11
    ^bb5:  // pred: ^bb4
      %33 = llhd.prb %sync_child_rst : i1
      %34 = llhd.prb %src_valid : i1
      %35 = comb.and %33, %34 : i1
      cf.cond_br %35, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %state_d, %c-28_i6 after %1 : i6
      cf.br ^bb38
    ^bb7:  // pred: ^bb5
      %36 = llhd.prb %sync_child_rst : i1
      %37 = llhd.prb %sync_parent_rst : i1
      %38 = comb.xor %37, %true : i1
      %39 = comb.and %36, %38 : i1
      cf.cond_br %39, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %state_d, %c-3_i6 after %1 : i6
      cf.br ^bb38
    ^bb9:  // pred: ^bb7
      %40 = llhd.prb %sync_parent_rst : i1
      %41 = llhd.prb %sync_child_rst : i1
      %42 = comb.xor %41, %true : i1
      %43 = comb.and %40, %42 : i1
      cf.cond_br %43, ^bb10, ^bb38
    ^bb10:  // pred: ^bb9
      llhd.drv %state_d, %c15_i6 after %1 : i6
      cf.br ^bb38
    ^bb11:  // pred: ^bb4
      %44 = comb.icmp ceq %25, %c-3_i6 : i6
      cf.cond_br %44, ^bb12, ^bb16
    ^bb12:  // pred: ^bb11
      llhd.drv %cnt_inc, %true after %1 : i1
      %45 = llhd.prb %timeout : i1
      %46 = llhd.prb %sync_parent_rst : i1
      %47 = comb.xor %46, %true : i1
      %48 = comb.and %45, %47 : i1
      cf.cond_br %48, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      llhd.drv %state_d, %c22_i6 after %1 : i6
      cf.br ^bb38
    ^bb14:  // pred: ^bb12
      %49 = llhd.prb %sync_parent_rst : i1
      cf.cond_br %49, ^bb15, ^bb38
    ^bb15:  // pred: ^bb14
      llhd.drv %state_d, %c-28_i6 after %1 : i6
      llhd.drv %cnt_clr, %true after %1 : i1
      cf.br ^bb38
    ^bb16:  // pred: ^bb11
      %50 = comb.icmp ceq %25, %c15_i6 : i6
      cf.cond_br %50, ^bb17, ^bb21
    ^bb17:  // pred: ^bb16
      llhd.drv %cnt_inc, %true after %1 : i1
      %51 = llhd.prb %timeout : i1
      %52 = llhd.prb %sync_child_rst : i1
      %53 = comb.xor %52, %true : i1
      %54 = comb.and %51, %53 : i1
      cf.cond_br %54, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      llhd.drv %state_d, %c22_i6 after %1 : i6
      cf.br ^bb38
    ^bb19:  // pred: ^bb17
      %55 = llhd.prb %sync_child_rst : i1
      cf.cond_br %55, ^bb20, ^bb38
    ^bb20:  // pred: ^bb19
      llhd.drv %state_d, %c-28_i6 after %1 : i6
      llhd.drv %cnt_clr, %true after %1 : i1
      cf.br ^bb38
    ^bb21:  // pred: ^bb16
      %56 = comb.icmp ceq %25, %c-28_i6 : i6
      cf.cond_br %56, ^bb22, ^bb26
    ^bb22:  // pred: ^bb21
      llhd.drv %sw_rst_req_clr_o, %true after %1 : i1
      %57 = llhd.prb %sync_child_rst : i1
      %58 = comb.xor %57, %true : i1
      %59 = llhd.prb %src_valid : i1
      %60 = comb.and %58, %59 : i1
      cf.cond_br %60, ^bb23, ^bb24
    ^bb23:  // pred: ^bb22
      llhd.drv %state_d, %c22_i6 after %1 : i6
      cf.br ^bb38
    ^bb24:  // pred: ^bb22
      %61 = llhd.prb %src_valid : i1
      %62 = comb.xor %61, %true : i1
      cf.cond_br %62, ^bb25, ^bb38
    ^bb25:  // pred: ^bb24
      llhd.drv %cnt_clr, %true after %1 : i1
      llhd.drv %state_d, %c-6_i6 after %1 : i6
      cf.br ^bb38
    ^bb26:  // pred: ^bb21
      %63 = comb.icmp ceq %25, %c-6_i6 : i6
      cf.cond_br %63, ^bb27, ^bb33
    ^bb27:  // pred: ^bb26
      %64 = llhd.prb %sync_child_ack : i1
      llhd.drv %cnt_inc, %64 after %1 : i1
      %65 = llhd.prb %sync_child_rst : i1
      %66 = llhd.prb %src_valid : i1
      %67 = comb.and %65, %66 : i1
      cf.cond_br %67, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      llhd.drv %state_d, %c-28_i6 after %1 : i6
      llhd.drv %cnt_clr, %true after %1 : i1
      cf.br ^bb38
    ^bb29:  // pred: ^bb27
      %68 = llhd.prb %sync_child_rst : i1
      %69 = llhd.prb %timeout : i1
      %70 = comb.and %68, %69 : i1
      cf.cond_br %70, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      llhd.drv %state_d, %c22_i6 after %1 : i6
      cf.br ^bb38
    ^bb31:  // pred: ^bb29
      %71 = llhd.prb %sync_child_rst : i1
      %72 = comb.xor %71, %true : i1
      cf.cond_br %72, ^bb32, ^bb38
    ^bb32:  // pred: ^bb31
      llhd.drv %state_d, %c-29_i6 after %1 : i6
      llhd.drv %cnt_clr, %true after %1 : i1
      cf.br ^bb38
    ^bb33:  // pred: ^bb26
      %73 = comb.icmp ceq %25, %c22_i6 : i6
      cf.cond_br %73, ^bb34, ^bb35
    ^bb34:  // pred: ^bb33
      llhd.drv %err_o, %true after %1 : i1
      cf.br ^bb38
    ^bb35:  // pred: ^bb33
      %74 = comb.icmp ceq %25, %c8_i6 : i6
      cf.cond_br %74, ^bb36, ^bb37
    ^bb36:  // pred: ^bb35
      llhd.drv %fsm_err_o, %true after %1 : i1
      cf.br ^bb38
    ^bb37:  // pred: ^bb35
      llhd.drv %state_d, %c8_i6 after %1 : i6
      llhd.drv %fsm_err_o, %true after %1 : i1
      cf.br ^bb38
    ^bb38:  // 22 preds: ^bb2, ^bb3, ^bb6, ^bb8, ^bb9, ^bb10, ^bb13, ^bb14, ^bb15, ^bb18, ^bb19, ^bb20, ^bb23, ^bb24, ^bb25, ^bb28, ^bb30, ^bb31, ^bb32, ^bb34, ^bb36, ^bb37
      llhd.wait (%14, %8, %15, %16, %17, %18, %19, %20, %12, %21, %22, %23 : i6, i6, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %child_rst_ni_2, %child_rst_ni after %1 : i1
    llhd.drv %parent_rst_ni_3, %parent_rst_ni after %1 : i1
    hw.output %19, %15, %16 : i1, i1, i1
  }
  hw.module private @rstmgr_crash_info(in %clk_i : i1, in %rst_ni : i1, in %dump_i : i276, in %dump_capture_i : i1, in %slot_sel_i : i4, out slots_cnt_o : i4, out slot_o : i32) {
    %c-7_i4 = hw.constant -7 : i4
    %c0_i4 = hw.constant 0 : i4
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i12 = hw.constant 0 : i12
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %2 = hw.aggregate_constant [0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32] : !hw.array<9xi32>
    %3 = hw.aggregate_constant [0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32] : !hw.array<16xi32>
    %c0_i276 = hw.constant 0 : i276
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %4 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %5 = llhd.prb %rst_ni_1 : i1
    %dump_i_2 = llhd.sig name "dump_i" %c0_i276 : i276
    %dump_capture_i_3 = llhd.sig name "dump_capture_i" %false : i1
    %slots = llhd.sig %3 : !hw.array<16xi32>
    %slots_q = llhd.sig %2 : !hw.array<9xi32>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %9 = llhd.prb %clk_i_0 : i1
      %10 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
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
      llhd.drv %slots_q, %2 after %1 : !hw.array<9xi32>
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %20 = llhd.prb %dump_capture_i_3 : i1
      cf.cond_br %20, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %21 = llhd.prb %dump_i_2 : i276
      %22 = comb.concat %c0_i12, %21 : i12, i276
      %23 = hw.bitcast %22 : (i288) -> !hw.array<9xi32>
      llhd.drv %slots_q, %23 after %1 : !hw.array<9xi32>
      cf.br ^bb1
    }
    %6 = llhd.prb %slots : !hw.array<16xi32>
    %7 = llhd.prb %slots_q : !hw.array<9xi32>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %slots, %3 after %0 : !hw.array<16xi32>
      %9 = llhd.sig.array_slice %slots at %c0_i4 : <!hw.array<16xi32>> -> <!hw.array<9xi32>>
      %10 = llhd.prb %slots_q : !hw.array<9xi32>
      llhd.drv %9, %10 after %0 : !hw.array<9xi32>
      llhd.wait (%6, %7 : !hw.array<16xi32>, !hw.array<9xi32>), ^bb1
    }
    %8 = hw.array_get %6[%slot_sel_i] : !hw.array<16xi32>, i4
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %dump_i_2, %dump_i after %0 : i276
    llhd.drv %dump_capture_i_3, %dump_capture_i after %0 : i1
    hw.output %c-7_i4, %8 : i4, i32
  }
  hw.module private @rstmgr_crash_info_2(in %clk_i : i1, in %rst_ni : i1, in %dump_i : i225, in %dump_capture_i : i1, in %slot_sel_i : i4, out slots_cnt_o : i4, out slot_o : i32) {
    %c-8_i4 = hw.constant -8 : i4
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i31 = hw.constant 0 : i31
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %2 = hw.aggregate_constant [0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32] : !hw.array<8xi32>
    %c0_i225 = hw.constant 0 : i225
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %dump_i_2 = llhd.sig name "dump_i" %c0_i225 : i225
    %dump_capture_i_3 = llhd.sig name "dump_capture_i" %false : i1
    %slots = llhd.sig %2 : !hw.array<8xi32>
    %slots_q = llhd.sig %2 : !hw.array<8xi32>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %9 = llhd.prb %clk_i_0 : i1
      %10 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
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
      llhd.drv %slots_q, %2 after %1 : !hw.array<8xi32>
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %20 = llhd.prb %dump_capture_i_3 : i1
      cf.cond_br %20, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %21 = llhd.prb %dump_i_2 : i225
      %22 = comb.concat %c0_i31, %21 : i31, i225
      %23 = hw.bitcast %22 : (i256) -> !hw.array<8xi32>
      llhd.drv %slots_q, %23 after %1 : !hw.array<8xi32>
      cf.br ^bb1
    }
    %5 = llhd.prb %slots : !hw.array<8xi32>
    %6 = llhd.prb %slots_q : !hw.array<8xi32>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %slots, %2 after %0 : !hw.array<8xi32>
      %9 = llhd.prb %slots_q : !hw.array<8xi32>
      llhd.drv %slots, %9 after %0 : !hw.array<8xi32>
      llhd.wait (%5, %6 : !hw.array<8xi32>, !hw.array<8xi32>), ^bb1
    }
    %7 = comb.extract %slot_sel_i from 0 : (i4) -> i3
    %8 = hw.array_get %5[%7] : !hw.array<8xi32>, i3
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %dump_i_2, %dump_i after %0 : i225
    llhd.drv %dump_capture_i_3, %dump_capture_i after %0 : i1
    hw.output %c-8_i4, %8 : i4, i32
  }
  hw.module private @rstmgr_ctrl(in %clk_i : i1, in %rst_req_i : i2, in %rst_parent_ni : i2, out rst_no : i2, in %scanmode_i : i1, in %scan_rst_ni : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %true = hw.constant true
    %false = hw.constant false
    %c0_i2 = hw.constant 0 : i2
    %rst_no = llhd.sig %c0_i2 : i2
    %rst_pd_nq = llhd.sig %false : i1
    %1 = comb.extract %rst_parent_ni from 0 : (i2) -> i1
    %2 = comb.extract %rst_req_i from 0 : (i2) -> i1
    %3 = comb.xor %2, %true : i1
    %u_aon_rst.q_o = hw.instance "u_aon_rst" @prim_flop_2sync(clk_i: %clk_i: i1, rst_ni: %1: i1, d_i: %3: i1) -> (q_o: i1) {sv.namehint = "rst_aon_n_premux"}
    %u_rst_aon_mux.clk_o = hw.instance "u_rst_aon_mux" @prim_clock_mux2(clk0_i: %u_aon_rst.q_o: i1, clk1_i: %scan_rst_ni: i1, sel_i: %scanmode_i: i1) -> (clk_o: i1) {sv.namehint = "rst_aon_n"}
    %4 = comb.extract %rst_parent_ni from 1 : (i2) -> i1
    %5 = comb.and %u_rst_aon_mux.clk_o, %4 : i1
    %gen_rst_pd_n_0.u_pd_rst.q_o = hw.instance "gen_rst_pd_n_0.u_pd_rst" @prim_flop_2sync(clk_i: %clk_i: i1, rst_ni: %5: i1, d_i: %10: i1) -> (q_o: i1)
    llhd.drv %rst_pd_nq, %gen_rst_pd_n_0.u_pd_rst.q_o after %0 : i1
    %6 = llhd.prb %rst_pd_nq : i1
    %7 = llhd.sig.extract %rst_no from %true : <i2> -> <i1>
    %gen_rst_pd_n_0.u_rst_pd_mux.clk_o = hw.instance "gen_rst_pd_n_0.u_rst_pd_mux" @prim_clock_mux2(clk0_i: %6: i1, clk1_i: %scan_rst_ni: i1, sel_i: %scanmode_i: i1) -> (clk_o: i1)
    llhd.drv %7, %gen_rst_pd_n_0.u_rst_pd_mux.clk_o after %0 : i1
    %8 = llhd.sig.extract %rst_no from %false : <i2> -> <i1>
    llhd.drv %8, %u_rst_aon_mux.clk_o after %0 : i1
    %9 = comb.extract %rst_req_i from 1 : (i2) -> i1
    %10 = comb.xor %9, %true {sv.namehint = "rst_pd_nd"} : i1
    %11 = llhd.prb %rst_no : i2
    hw.output %11 : i2
  }
  hw.module private @rstmgr_leaf_rst(in %clk_i : i1, in %rst_ni : i1, in %leaf_clk_i : i1, in %parent_rst_ni : i1, in %sw_rst_req_ni : i1, in %scanmode_i : i4, in %scan_rst_ni : i1, out rst_en_o : i4, out leaf_rst_o : i1, out err_o : i1, out fsm_err_o : i1) {
    %true = hw.constant true
    %c-7_i4 = hw.constant -7 : i4
    %u_scanmode_sync.mubi_o = hw.instance "u_scanmode_sync" @prim_mubi4_sync(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, mubi_i: %scanmode_i: i4) -> (mubi_o: !hw.array<1xi4>)
    %0 = hw.bitcast %u_scanmode_sync.mubi_o {sv.namehint = "scanmode"} : (!hw.array<1xi4>) -> i4
    %u_rst_sync.q_o = hw.instance "u_rst_sync" @prim_flop_2sync(clk_i: %leaf_clk_i: i1, rst_ni: %parent_rst_ni: i1, d_i: %sw_rst_req_ni: i1) -> (q_o: i1) {sv.namehint = "leaf_rst_sync"}
    %1 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%0) : (i4) -> i1
    %u_rst_mux.clk_o = hw.instance "u_rst_mux" @prim_clock_mux2(clk0_i: %u_rst_sync.q_o: i1, clk1_i: %scan_rst_ni: i1, sel_i: %1: i1) -> (clk_o: i1)
    %gen_rst_chk.u_prim_rst_sync.q_o = hw.instance "gen_rst_chk.u_prim_rst_sync" @prim_rst_sync(clk_i: %leaf_clk_i: i1, d_i: %rst_ni: i1, scan_rst_ni: %scan_rst_ni: i1, scanmode_i: %scanmode_i: i4) -> (q_o: i1) {sv.namehint = "gen_rst_chk.leaf_chk_rst_n"}
    %2 = comb.xor %sw_rst_req_ni, %true : i1
    %gen_rst_chk.u_rst_chk.sw_rst_req_clr_o, %gen_rst_chk.u_rst_chk.err_o, %gen_rst_chk.u_rst_chk.fsm_err_o = hw.instance "gen_rst_chk.u_rst_chk" @rstmgr_cnsty_chk(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, child_clk_i: %leaf_clk_i: i1, child_rst_ni: %u_rst_mux.clk_o: i1, child_chk_rst_ni: %gen_rst_chk.u_prim_rst_sync.q_o: i1, parent_rst_ni: %parent_rst_ni: i1, sw_rst_req_i: %2: i1) -> (sw_rst_req_clr_o: i1, err_o: i1, fsm_err_o: i1) {sv.namehint = "clr_sw_rst_req"}
    %u_prim_mubi4_sender.mubi_o = hw.instance "u_prim_mubi4_sender" @prim_mubi4_sender(clk_i: %leaf_clk_i: i1, rst_ni: %u_rst_mux.clk_o: i1, mubi_i: %c-7_i4: i4) -> (mubi_o: i4)
    hw.output %u_prim_mubi4_sender.mubi_o, %u_rst_mux.clk_o, %gen_rst_chk.u_rst_chk.err_o, %gen_rst_chk.u_rst_chk.fsm_err_o : i4, i1, i1, i1
  }
  hw.module private @rstmgr_leaf_rst_0(in %clk_i : i1, in %rst_ni : i1, in %leaf_clk_i : i1, in %parent_rst_ni : i1, in %sw_rst_req_ni : i1, in %scanmode_i : i4, in %scan_rst_ni : i1, out rst_en_o : i4, out leaf_rst_o : i1, out err_o : i1, out fsm_err_o : i1) {
    %false = hw.constant false {sv.namehint = "sw_rst_req_q"}
    %c-7_i4 = hw.constant -7 : i4
    %u_scanmode_sync.mubi_o = hw.instance "u_scanmode_sync" @prim_mubi4_sync(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, mubi_i: %scanmode_i: i4) -> (mubi_o: !hw.array<1xi4>)
    %0 = hw.bitcast %u_scanmode_sync.mubi_o {sv.namehint = "scanmode"} : (!hw.array<1xi4>) -> i4
    %u_rst_sync.q_o = hw.instance "u_rst_sync" @prim_flop_2sync(clk_i: %leaf_clk_i: i1, rst_ni: %parent_rst_ni: i1, d_i: %sw_rst_req_ni: i1) -> (q_o: i1) {sv.namehint = "leaf_rst_sync"}
    %1 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%0) : (i4) -> i1
    %u_rst_mux.clk_o = hw.instance "u_rst_mux" @prim_clock_mux2(clk0_i: %u_rst_sync.q_o: i1, clk1_i: %scan_rst_ni: i1, sel_i: %1: i1) -> (clk_o: i1)
    %u_prim_mubi4_sender.mubi_o = hw.instance "u_prim_mubi4_sender" @prim_mubi4_sender(clk_i: %leaf_clk_i: i1, rst_ni: %u_rst_mux.clk_o: i1, mubi_i: %c-7_i4: i4) -> (mubi_o: i4)
    hw.output %u_prim_mubi4_sender.mubi_o, %u_rst_mux.clk_o, %false, %false : i4, i1, i1, i1
  }
  hw.module private @rstmgr_leaf_rst_1(in %clk_i : i1, in %rst_ni : i1, in %leaf_clk_i : i1, in %parent_rst_ni : i1, in %sw_rst_req_ni : i1, in %scanmode_i : i4, in %scan_rst_ni : i1, out rst_en_o : i4, out leaf_rst_o : i1, out err_o : i1, out fsm_err_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %true = hw.constant true
    %false = hw.constant false
    %c-7_i4 = hw.constant -7 : i4
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %sw_rst_req_ni_2 = llhd.sig name "sw_rst_req_ni" %false : i1
    %sw_rst_req_q = llhd.sig %false : i1
    %clr_sw_rst_req = llhd.sig %false : i1
    %u_scanmode_sync.mubi_o = hw.instance "u_scanmode_sync" @prim_mubi4_sync(clk_i: %2: i1, rst_ni: %3: i1, mubi_i: %scanmode_i: i4) -> (mubi_o: !hw.array<1xi4>)
    %4 = hw.bitcast %u_scanmode_sync.mubi_o {sv.namehint = "scanmode"} : (!hw.array<1xi4>) -> i4
    %5 = llhd.prb %sw_rst_req_ni_2 : i1
    %u_rst_sync.q_o = hw.instance "u_rst_sync" @prim_flop_2sync(clk_i: %leaf_clk_i: i1, rst_ni: %parent_rst_ni: i1, d_i: %5: i1) -> (q_o: i1) {sv.namehint = "leaf_rst_sync"}
    %6 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%4) : (i4) -> i1
    %u_rst_mux.clk_o = hw.instance "u_rst_mux" @prim_clock_mux2(clk0_i: %u_rst_sync.q_o: i1, clk1_i: %scan_rst_ni: i1, sel_i: %6: i1) -> (clk_o: i1)
    %gen_rst_chk.u_prim_rst_sync.q_o = hw.instance "gen_rst_chk.u_prim_rst_sync" @prim_rst_sync(clk_i: %leaf_clk_i: i1, d_i: %3: i1, scan_rst_ni: %scan_rst_ni: i1, scanmode_i: %scanmode_i: i4) -> (q_o: i1) {sv.namehint = "gen_rst_chk.leaf_chk_rst_n"}
    %7 = llhd.prb %sw_rst_req_q : i1
    %8 = comb.xor %5, %true : i1
    %9 = comb.or %7, %8 : i1
    %gen_rst_chk.u_rst_chk.sw_rst_req_clr_o, %gen_rst_chk.u_rst_chk.err_o, %gen_rst_chk.u_rst_chk.fsm_err_o = hw.instance "gen_rst_chk.u_rst_chk" @rstmgr_cnsty_chk_15(clk_i: %2: i1, rst_ni: %3: i1, child_clk_i: %leaf_clk_i: i1, child_rst_ni: %u_rst_mux.clk_o: i1, child_chk_rst_ni: %gen_rst_chk.u_prim_rst_sync.q_o: i1, parent_rst_ni: %parent_rst_ni: i1, sw_rst_req_i: %9: i1) -> (sw_rst_req_clr_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %clr_sw_rst_req, %gen_rst_chk.u_rst_chk.sw_rst_req_clr_o after %1 : i1
    %u_prim_mubi4_sender.mubi_o = hw.instance "u_prim_mubi4_sender" @prim_mubi4_sender(clk_i: %leaf_clk_i: i1, rst_ni: %u_rst_mux.clk_o: i1, mubi_i: %c-7_i4: i4) -> (mubi_o: i4)
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
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
      llhd.drv %sw_rst_req_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %21 = llhd.prb %sw_rst_req_q : i1
      %22 = llhd.prb %clr_sw_rst_req : i1
      %23 = comb.and %21, %22 : i1
      cf.cond_br %23, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %sw_rst_req_q, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %24 = llhd.prb %sw_rst_req_q : i1
      %25 = comb.xor %24, %true : i1
      %26 = llhd.prb %sw_rst_req_ni_2 : i1
      %27 = comb.xor %26, %true : i1
      %28 = llhd.prb %clr_sw_rst_req : i1
      %29 = comb.xor %28, %true : i1
      %30 = comb.and %25, %27, %29 : i1
      cf.cond_br %30, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      llhd.drv %sw_rst_req_q, %true after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %sw_rst_req_ni_2, %sw_rst_req_ni after %1 : i1
    hw.output %u_prim_mubi4_sender.mubi_o, %u_rst_mux.clk_o, %gen_rst_chk.u_rst_chk.err_o, %gen_rst_chk.u_rst_chk.fsm_err_o : i4, i1, i1, i1
  }
  hw.module private @rstmgr_por(in %clk_i : i1, in %rst_ni : i1, in %scan_rst_ni : i1, in %scanmode_i : i1, out rst_no : i1) {
    %c-32_i6 = hw.constant -32 : i6
    %c-1_i3 = hw.constant -1 : i3
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c1_i6 = hw.constant 1 : i6
    %c0_i6 = hw.constant 0 : i6
    %false = hw.constant false
    %true = hw.constant true
    %c0_i3 = hw.constant 0 : i3
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_root_n = llhd.sig %false : i1
    %3 = llhd.prb %rst_root_n : i1
    %rst_filter_n = llhd.sig %c0_i3 : i3
    %rst_stable = llhd.sig %false : i1
    %rst_clean_n = llhd.sig %false : i1
    %4 = llhd.prb %rst_clean_n : i1
    %cnt = llhd.sig %c0_i6 : i6
    %cnt_en = llhd.sig %false : i1
    %rst_nq = llhd.sig %false : i1
    %u_rst_sync.q_o = hw.instance "u_rst_sync" @prim_flop_2sync(clk_i: %2: i1, rst_ni: %rst_ni: i1, d_i: %true: i1) -> (q_o: i1) {sv.namehint = "rst_root_n_pre_mux"}
    %u_rst_root_mux.clk_o = hw.instance "u_rst_root_mux" @prim_clock_mux2(clk0_i: %u_rst_sync.q_o: i1, clk1_i: %scan_rst_ni: i1, sel_i: %scanmode_i: i1) -> (clk_o: i1)
    llhd.drv %rst_root_n, %u_rst_root_mux.clk_o after %1 : i1
    %5 = llhd.prb %rst_filter_n : i3
    %6 = comb.extract %5 from 2 : (i3) -> i1
    %u_rst_clean_mux.clk_o = hw.instance "u_rst_clean_mux" @prim_clock_mux2(clk0_i: %6: i1, clk1_i: %scan_rst_ni: i1, sel_i: %scanmode_i: i1) -> (clk_o: i1)
    llhd.drv %rst_clean_n, %u_rst_clean_mux.clk_o after %1 : i1
    %u_rst_flop.q_o = hw.instance "u_rst_flop" @prim_flop(clk_i: %2: i1, rst_ni: %4: i1, d_i: %17: i1) -> (q_o: i1)
    llhd.drv %rst_nq, %u_rst_flop.q_o after %1 : i1
    %7 = llhd.prb %rst_nq : i1
    %u_rst_out_mux.clk_o = hw.instance "u_rst_out_mux" @prim_clock_mux2(clk0_i: %7: i1, clk1_i: %scan_rst_ni: i1, sel_i: %scanmode_i: i1) -> (clk_o: i1)
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %18 = llhd.prb %clk_i_0 : i1
      %19 = llhd.prb %rst_root_n : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %20 = llhd.prb %clk_i_0 : i1
      %21 = comb.xor bin %18, %true : i1
      %22 = comb.and bin %21, %20 : i1
      %23 = llhd.prb %rst_root_n : i1
      %24 = comb.xor bin %23, %true : i1
      %25 = comb.and bin %19, %24 : i1
      %26 = comb.or bin %22, %25 : i1
      cf.cond_br %26, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %27 = llhd.prb %rst_root_n : i1
      %28 = comb.xor %27, %true : i1
      cf.cond_br %28, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %rst_filter_n, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %29 = llhd.prb %rst_filter_n : i3
      %30 = comb.extract %29 from 0 : (i3) -> i2
      %31 = comb.concat %30, %true : i2, i1
      llhd.drv %rst_filter_n, %31 after %0 : i3
      cf.br ^bb1
    }
    %8 = comb.icmp eq %5, %c-1_i3 : i3
    llhd.drv %rst_stable, %8 after %1 : i1
    %9 = llhd.prb %rst_stable : i1
    %10 = comb.xor %u_rst_out_mux.clk_o, %true : i1
    %11 = comb.and %9, %10 : i1
    llhd.drv %cnt_en, %11 after %1 : i1
    %12 = llhd.prb %cnt_en : i1
    %13 = llhd.prb %cnt : i6
    %14 = comb.icmp eq %13, %c-32_i6 : i6
    %15 = comb.and %12, %14 : i1
    %16 = comb.or %15, %7 : i1
    %17 = comb.and %9, %16 {sv.namehint = "rst_nd"} : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %18 = llhd.prb %clk_i_0 : i1
      %19 = llhd.prb %rst_clean_n : i1
      llhd.wait (%2, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %20 = llhd.prb %clk_i_0 : i1
      %21 = comb.xor bin %18, %true : i1
      %22 = comb.and bin %21, %20 : i1
      %23 = llhd.prb %rst_clean_n : i1
      %24 = comb.xor bin %23, %true : i1
      %25 = comb.and bin %19, %24 : i1
      %26 = comb.or bin %22, %25 : i1
      cf.cond_br %26, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %27 = llhd.prb %rst_clean_n : i1
      %28 = comb.xor %27, %true : i1
      cf.cond_br %28, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %cnt, %c0_i6 after %0 : i6
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %29 = llhd.prb %rst_stable : i1
      %30 = comb.xor %29, %true : i1
      cf.cond_br %30, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %cnt, %c0_i6 after %0 : i6
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %31 = llhd.prb %cnt_en : i1
      cf.cond_br %31, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %32 = llhd.prb %cnt : i6
      %33 = comb.add %32, %c1_i6 : i6
      llhd.drv %cnt, %33 after %0 : i6
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    hw.output %u_rst_out_mux.clk_o : i1
  }
  hw.module private @rstmgr_reg_top(in %clk_i : i1, in %rst_ni : i1, in %clk_por_i : i1, in %rst_por_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out reg2hw : !hw.struct<alert_test: !hw.struct<fatal_cnsty_fault: !hw.struct<q: i1, qe: i1>, fatal_fault: !hw.struct<q: i1, qe: i1>>, reset_req: !hw.struct<q: i4>, reset_info: !hw.struct<hw_req: !hw.struct<q: i5>, sw_reset: !hw.struct<q: i1>>, alert_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, cpu_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, sw_rst_ctrl_n: !hw.array<8xstruct<q: i1>>, err_code: !hw.struct<fsm_err: !hw.struct<q: i1>, reset_consistency_err: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>, in %hw2reg : !hw.struct<reset_req: !hw.struct<d: i4, de: i1>, reset_info: !hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>, alert_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, alert_info_attr: !hw.struct<d: i4>, alert_info: !hw.struct<d: i32>, cpu_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, cpu_info_attr: !hw.struct<d: i4>, cpu_info: !hw.struct<d: i32>, err_code: !hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>, out intg_err_o : i1) {
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
    %c-1_i2 = hw.constant -1 : i2
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i3 = hw.constant -1 : i3
    %c-2_i3 = hw.constant -2 : i3
    %c-3_i3 = hw.constant -3 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c3_i3 = hw.constant 3 : i3
    %c2_i3 = hw.constant 2 : i3
    %c1_i3 = hw.constant 1 : i3
    %c0_i3 = hw.constant 0 : i3
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %c0_i5 = hw.constant 0 : i5
    %c0_i28 = hw.constant 0 : i28
    %2 = hw.aggregate_constant [[[false, false], [false, false]], [0 : i4], [[0 : i5], [false]], [[0 : i4], [false]], [[0 : i4], [false]], [[false], [false], [false], [false], [false], [false], [false], [false]], [[false], [false], [false]]] : !hw.struct<alert_test: !hw.struct<fatal_cnsty_fault: !hw.struct<q: i1, qe: i1>, fatal_fault: !hw.struct<q: i1, qe: i1>>, reset_req: !hw.struct<q: i4>, reset_info: !hw.struct<hw_req: !hw.struct<q: i5>, sw_reset: !hw.struct<q: i1>>, alert_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, cpu_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, sw_rst_ctrl_n: !hw.array<8xstruct<q: i1>>, err_code: !hw.struct<fsm_err: !hw.struct<q: i1>, reset_consistency_err: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %c-1_i32 = hw.constant -1 : i32
    %c-1_i4 = hw.constant -1 : i4
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
    %c0_i32 = hw.constant 0 : i32
    %c0_i4 = hw.constant 0 : i4
    %false = hw.constant false {sv.namehint = "shadow_busy"}
    %c-7_i4 = hw.constant -7 : i4
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %reg2hw = llhd.sig %2 : !hw.struct<alert_test: !hw.struct<fatal_cnsty_fault: !hw.struct<q: i1, qe: i1>, fatal_fault: !hw.struct<q: i1, qe: i1>>, reset_req: !hw.struct<q: i4>, reset_info: !hw.struct<hw_req: !hw.struct<q: i5>, sw_reset: !hw.struct<q: i1>>, alert_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, cpu_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, sw_rst_ctrl_n: !hw.array<8xstruct<q: i1>>, err_code: !hw.struct<fsm_err: !hw.struct<q: i1>, reset_consistency_err: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %reg_we = llhd.sig %false : i1
    %reg_addr = llhd.sig %c0_i7 : i7
    %reg_be = llhd.sig %c0_i4 : i4
    %wr_err = llhd.sig %false : i1
    %reg_rdata_next = llhd.sig %c0_i32 : i32
    %intg_err = llhd.sig %false : i1
    %reg_we_err = llhd.sig %false : i1
    %reg_we_check = llhd.sig %c0_i28 : i28
    %err_q = llhd.sig %false : i1
    %alert_test_we = llhd.sig %false : i1
    %reset_req_we = llhd.sig %false : i1
    %reset_req_qs = llhd.sig %c0_i4 : i4
    %reset_info_we = llhd.sig %false : i1
    %reset_info_por_qs = llhd.sig %false : i1
    %reset_info_low_power_exit_qs = llhd.sig %false : i1
    %reset_info_sw_reset_qs = llhd.sig %false : i1
    %reset_info_hw_req_qs = llhd.sig %c0_i5 : i5
    %alert_regwen_we = llhd.sig %false : i1
    %alert_regwen_qs = llhd.sig %false : i1
    %alert_info_ctrl_en_qs = llhd.sig %false : i1
    %alert_info_ctrl_index_qs = llhd.sig %c0_i4 : i4
    %alert_info_attr_qs = llhd.sig %c0_i4 : i4
    %alert_info_qs = llhd.sig %c0_i32 : i32
    %cpu_regwen_we = llhd.sig %false : i1
    %cpu_regwen_qs = llhd.sig %false : i1
    %cpu_info_ctrl_en_qs = llhd.sig %false : i1
    %cpu_info_ctrl_index_qs = llhd.sig %c0_i4 : i4
    %cpu_info_attr_qs = llhd.sig %c0_i4 : i4
    %cpu_info_qs = llhd.sig %c0_i32 : i32
    %sw_rst_regwen_0_we = llhd.sig %false : i1
    %sw_rst_regwen_0_qs = llhd.sig %false : i1
    %sw_rst_regwen_1_we = llhd.sig %false : i1
    %sw_rst_regwen_1_qs = llhd.sig %false : i1
    %sw_rst_regwen_2_we = llhd.sig %false : i1
    %sw_rst_regwen_2_qs = llhd.sig %false : i1
    %sw_rst_regwen_3_we = llhd.sig %false : i1
    %sw_rst_regwen_3_qs = llhd.sig %false : i1
    %sw_rst_regwen_4_we = llhd.sig %false : i1
    %sw_rst_regwen_4_qs = llhd.sig %false : i1
    %sw_rst_regwen_5_we = llhd.sig %false : i1
    %sw_rst_regwen_5_qs = llhd.sig %false : i1
    %sw_rst_regwen_6_we = llhd.sig %false : i1
    %sw_rst_regwen_6_qs = llhd.sig %false : i1
    %sw_rst_regwen_7_we = llhd.sig %false : i1
    %sw_rst_regwen_7_qs = llhd.sig %false : i1
    %sw_rst_ctrl_n_0_qs = llhd.sig %false : i1
    %sw_rst_ctrl_n_1_qs = llhd.sig %false : i1
    %sw_rst_ctrl_n_2_qs = llhd.sig %false : i1
    %sw_rst_ctrl_n_3_qs = llhd.sig %false : i1
    %sw_rst_ctrl_n_4_qs = llhd.sig %false : i1
    %sw_rst_ctrl_n_5_qs = llhd.sig %false : i1
    %sw_rst_ctrl_n_6_qs = llhd.sig %false : i1
    %sw_rst_ctrl_n_7_qs = llhd.sig %false : i1
    %err_code_reg_intg_err_qs = llhd.sig %false : i1
    %err_code_reset_consistency_err_qs = llhd.sig %false : i1
    %err_code_fsm_err_qs = llhd.sig %false : i1
    %alert_test_flds_we = llhd.sig %c0_i2 : i2
    %alert_info_ctrl_gated_we = llhd.sig %false : i1
    %cpu_info_ctrl_gated_we = llhd.sig %false : i1
    %sw_rst_ctrl_n_0_gated_we = llhd.sig %false : i1
    %sw_rst_ctrl_n_1_gated_we = llhd.sig %false : i1
    %sw_rst_ctrl_n_2_gated_we = llhd.sig %false : i1
    %sw_rst_ctrl_n_3_gated_we = llhd.sig %false : i1
    %sw_rst_ctrl_n_4_gated_we = llhd.sig %false : i1
    %sw_rst_ctrl_n_5_gated_we = llhd.sig %false : i1
    %sw_rst_ctrl_n_6_gated_we = llhd.sig %false : i1
    %sw_rst_ctrl_n_7_gated_we = llhd.sig %false : i1
    %addr_hit = llhd.sig %c0_i28 : i28
    %u_chk.err_o = hw.instance "u_chk" @tlul_cmd_intg_chk(tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> (err_o: i1)
    llhd.drv %intg_err, %u_chk.err_o after %1 : i1
    %5 = llhd.prb %reg_we_check : i28
    %6 = llhd.prb %reg_we : i1
    %7 = comb.xor %115, %true : i1
    %8 = comb.and %6, %7 : i1
    %u_prim_reg_we_check.err_o = hw.instance "u_prim_reg_we_check" @prim_reg_we_check(clk_i: %3: i1, rst_ni: %4: i1, oh_i: %5: i28, en_i: %8: i1) -> (err_o: i1)
    llhd.drv %reg_we_err, %u_prim_reg_we_check.err_o after %1 : i1
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen(tl_i: %u_reg_if.tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
    %u_reg_if.tl_o, %u_reg_if.intg_error_o, %u_reg_if.re_o, %u_reg_if.we_o, %u_reg_if.addr_o, %u_reg_if.wdata_o, %u_reg_if.be_o = hw.instance "u_reg_if" @tlul_adapter_reg(clk_i: %3: i1, rst_ni: %4: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, en_ifetch_i: %c-7_i4: i4, busy_i: %false: i1, rdata_i: %84: i32, error_i: %86: i1) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, intg_error_o: i1, re_o: i1, we_o: i1, addr_o: i7, wdata_o: i32, be_o: i4) {sv.namehint = "reg_re"}
    llhd.drv %reg_we, %u_reg_if.we_o after %1 : i1
    llhd.drv %reg_addr, %u_reg_if.addr_o after %1 : i7
    llhd.drv %reg_be, %u_reg_if.be_o after %1 : i4
    %9 = llhd.prb %alert_test_we : i1
    %10 = llhd.sig.extract %alert_test_flds_we from %false : <i2> -> <i1>
    %11 = llhd.sig.struct_extract %reg2hw["alert_test"] : <!hw.struct<alert_test: !hw.struct<fatal_cnsty_fault: !hw.struct<q: i1, qe: i1>, fatal_fault: !hw.struct<q: i1, qe: i1>>, reset_req: !hw.struct<q: i4>, reset_info: !hw.struct<hw_req: !hw.struct<q: i5>, sw_reset: !hw.struct<q: i1>>, alert_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, cpu_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, sw_rst_ctrl_n: !hw.array<8xstruct<q: i1>>, err_code: !hw.struct<fsm_err: !hw.struct<q: i1>, reset_consistency_err: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>>
    %12 = llhd.sig.struct_extract %11["fatal_fault"] : <!hw.struct<fatal_cnsty_fault: !hw.struct<q: i1, qe: i1>, fatal_fault: !hw.struct<q: i1, qe: i1>>>
    %13 = llhd.sig.struct_extract %12["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_alert_test_fatal_fault.qe, %u_alert_test_fatal_fault.qre, %u_alert_test_fatal_fault.q, %u_alert_test_fatal_fault.ds, %u_alert_test_fatal_fault.qs = hw.instance "u_alert_test_fatal_fault" @prim_subreg_ext(re: %false: i1, we: %9: i1, wd: %120: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %10, %u_alert_test_fatal_fault.qe after %1 : i1
    llhd.drv %13, %u_alert_test_fatal_fault.q after %1 : i1
    %14 = llhd.sig.extract %alert_test_flds_we from %true : <i2> -> <i1>
    %15 = llhd.sig.struct_extract %11["fatal_cnsty_fault"] : <!hw.struct<fatal_cnsty_fault: !hw.struct<q: i1, qe: i1>, fatal_fault: !hw.struct<q: i1, qe: i1>>>
    %16 = llhd.sig.struct_extract %15["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_alert_test_fatal_cnsty_fault.qe, %u_alert_test_fatal_cnsty_fault.qre, %u_alert_test_fatal_cnsty_fault.q, %u_alert_test_fatal_cnsty_fault.ds, %u_alert_test_fatal_cnsty_fault.qs = hw.instance "u_alert_test_fatal_cnsty_fault" @prim_subreg_ext(re: %false: i1, we: %9: i1, wd: %121: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %14, %u_alert_test_fatal_cnsty_fault.qe after %1 : i1
    llhd.drv %16, %u_alert_test_fatal_cnsty_fault.q after %1 : i1
    %17 = llhd.prb %reset_req_we : i1
    %reset_req = hw.struct_extract %hw2reg["reset_req"] : !hw.struct<reset_req: !hw.struct<d: i4, de: i1>, reset_info: !hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>, alert_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, alert_info_attr: !hw.struct<d: i4>, alert_info: !hw.struct<d: i32>, cpu_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, cpu_info_attr: !hw.struct<d: i4>, cpu_info: !hw.struct<d: i32>, err_code: !hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %de = hw.struct_extract %reset_req["de"] : !hw.struct<d: i4, de: i1>
    %d = hw.struct_extract %reset_req["d"] : !hw.struct<d: i4, de: i1>
    %18 = llhd.sig.struct_extract %reg2hw["reset_req"] : <!hw.struct<alert_test: !hw.struct<fatal_cnsty_fault: !hw.struct<q: i1, qe: i1>, fatal_fault: !hw.struct<q: i1, qe: i1>>, reset_req: !hw.struct<q: i4>, reset_info: !hw.struct<hw_req: !hw.struct<q: i5>, sw_reset: !hw.struct<q: i1>>, alert_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, cpu_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, sw_rst_ctrl_n: !hw.array<8xstruct<q: i1>>, err_code: !hw.struct<fsm_err: !hw.struct<q: i1>, reset_consistency_err: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>>
    %19 = llhd.sig.struct_extract %18["q"] : <!hw.struct<q: i4>>
    %u_reset_req.qe, %u_reset_req.q, %u_reset_req.ds, %u_reset_req.qs = hw.instance "u_reset_req" @prim_subreg(clk_i: %3: i1, rst_ni: %4: i1, we: %17: i1, wd: %124: i4, de: %de: i1, d: %d: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %19, %u_reset_req.q after %1 : i4
    llhd.drv %reset_req_qs, %u_reset_req.qs after %1 : i4
    %20 = llhd.prb %reset_info_we : i1
    %u_reset_info_por.qe, %u_reset_info_por.q, %u_reset_info_por.ds, %u_reset_info_por.qs = hw.instance "u_reset_info_por" @prim_subreg_4(clk_i: %clk_por_i: i1, rst_ni: %rst_por_ni: i1, we: %20: i1, wd: %120: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %reset_info_por_qs, %u_reset_info_por.qs after %1 : i1
    %reset_info = hw.struct_extract %hw2reg["reset_info"] : !hw.struct<reset_req: !hw.struct<d: i4, de: i1>, reset_info: !hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>, alert_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, alert_info_attr: !hw.struct<d: i4>, alert_info: !hw.struct<d: i32>, cpu_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, cpu_info_attr: !hw.struct<d: i4>, cpu_info: !hw.struct<d: i32>, err_code: !hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %low_power_exit = hw.struct_extract %reset_info["low_power_exit"] : !hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>
    %de_2 = hw.struct_extract %low_power_exit["de"] : !hw.struct<d: i1, de: i1>
    %d_3 = hw.struct_extract %low_power_exit["d"] : !hw.struct<d: i1, de: i1>
    %u_reset_info_low_power_exit.qe, %u_reset_info_low_power_exit.q, %u_reset_info_low_power_exit.ds, %u_reset_info_low_power_exit.qs = hw.instance "u_reset_info_low_power_exit" @prim_subreg_5(clk_i: %clk_por_i: i1, rst_ni: %rst_por_ni: i1, we: %20: i1, wd: %121: i1, de: %de_2: i1, d: %d_3: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %reset_info_low_power_exit_qs, %u_reset_info_low_power_exit.qs after %1 : i1
    %sw_reset = hw.struct_extract %reset_info["sw_reset"] : !hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>
    %de_4 = hw.struct_extract %sw_reset["de"] : !hw.struct<d: i1, de: i1>
    %d_5 = hw.struct_extract %sw_reset["d"] : !hw.struct<d: i1, de: i1>
    %21 = llhd.sig.struct_extract %reg2hw["reset_info"] : <!hw.struct<alert_test: !hw.struct<fatal_cnsty_fault: !hw.struct<q: i1, qe: i1>, fatal_fault: !hw.struct<q: i1, qe: i1>>, reset_req: !hw.struct<q: i4>, reset_info: !hw.struct<hw_req: !hw.struct<q: i5>, sw_reset: !hw.struct<q: i1>>, alert_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, cpu_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, sw_rst_ctrl_n: !hw.array<8xstruct<q: i1>>, err_code: !hw.struct<fsm_err: !hw.struct<q: i1>, reset_consistency_err: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>>
    %22 = llhd.sig.struct_extract %21["sw_reset"] : <!hw.struct<hw_req: !hw.struct<q: i5>, sw_reset: !hw.struct<q: i1>>>
    %23 = llhd.sig.struct_extract %22["q"] : <!hw.struct<q: i1>>
    %u_reset_info_sw_reset.qe, %u_reset_info_sw_reset.q, %u_reset_info_sw_reset.ds, %u_reset_info_sw_reset.qs = hw.instance "u_reset_info_sw_reset" @prim_subreg_5(clk_i: %clk_por_i: i1, rst_ni: %rst_por_ni: i1, we: %20: i1, wd: %127: i1, de: %de_4: i1, d: %d_5: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %23, %u_reset_info_sw_reset.q after %1 : i1
    llhd.drv %reset_info_sw_reset_qs, %u_reset_info_sw_reset.qs after %1 : i1
    %hw_req = hw.struct_extract %reset_info["hw_req"] : !hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>
    %de_6 = hw.struct_extract %hw_req["de"] : !hw.struct<d: i5, de: i1>
    %d_7 = hw.struct_extract %hw_req["d"] : !hw.struct<d: i5, de: i1>
    %24 = llhd.sig.struct_extract %21["hw_req"] : <!hw.struct<hw_req: !hw.struct<q: i5>, sw_reset: !hw.struct<q: i1>>>
    %25 = llhd.sig.struct_extract %24["q"] : <!hw.struct<q: i5>>
    %u_reset_info_hw_req.qe, %u_reset_info_hw_req.q, %u_reset_info_hw_req.ds, %u_reset_info_hw_req.qs = hw.instance "u_reset_info_hw_req" @prim_subreg_6(clk_i: %clk_por_i: i1, rst_ni: %rst_por_ni: i1, we: %20: i1, wd: %128: i5, de: %de_6: i1, d: %d_7: i5) -> (qe: i1, q: i5, ds: i5, qs: i5)
    llhd.drv %25, %u_reset_info_hw_req.q after %1 : i5
    llhd.drv %reset_info_hw_req_qs, %u_reset_info_hw_req.qs after %1 : i5
    %26 = llhd.prb %alert_regwen_we : i1
    %u_alert_regwen.qe, %u_alert_regwen.q, %u_alert_regwen.ds, %u_alert_regwen.qs = hw.instance "u_alert_regwen" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %26: i1, wd: %120: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %alert_regwen_qs, %u_alert_regwen.qs after %1 : i1
    %27 = llhd.prb %alert_info_ctrl_gated_we : i1
    %alert_info_ctrl = hw.struct_extract %hw2reg["alert_info_ctrl"] : !hw.struct<reset_req: !hw.struct<d: i4, de: i1>, reset_info: !hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>, alert_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, alert_info_attr: !hw.struct<d: i4>, alert_info: !hw.struct<d: i32>, cpu_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, cpu_info_attr: !hw.struct<d: i4>, cpu_info: !hw.struct<d: i32>, err_code: !hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %en = hw.struct_extract %alert_info_ctrl["en"] : !hw.struct<en: !hw.struct<d: i1, de: i1>>
    %de_8 = hw.struct_extract %en["de"] : !hw.struct<d: i1, de: i1>
    %d_9 = hw.struct_extract %en["d"] : !hw.struct<d: i1, de: i1>
    %28 = llhd.sig.struct_extract %reg2hw["alert_info_ctrl"] : <!hw.struct<alert_test: !hw.struct<fatal_cnsty_fault: !hw.struct<q: i1, qe: i1>, fatal_fault: !hw.struct<q: i1, qe: i1>>, reset_req: !hw.struct<q: i4>, reset_info: !hw.struct<hw_req: !hw.struct<q: i5>, sw_reset: !hw.struct<q: i1>>, alert_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, cpu_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, sw_rst_ctrl_n: !hw.array<8xstruct<q: i1>>, err_code: !hw.struct<fsm_err: !hw.struct<q: i1>, reset_consistency_err: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>>
    %29 = llhd.sig.struct_extract %28["en"] : <!hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>>
    %30 = llhd.sig.struct_extract %29["q"] : <!hw.struct<q: i1>>
    %u_alert_info_ctrl_en.qe, %u_alert_info_ctrl_en.q, %u_alert_info_ctrl_en.ds, %u_alert_info_ctrl_en.qs = hw.instance "u_alert_info_ctrl_en" @prim_subreg_8(clk_i: %clk_por_i: i1, rst_ni: %rst_por_ni: i1, we: %27: i1, wd: %120: i1, de: %de_8: i1, d: %d_9: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %30, %u_alert_info_ctrl_en.q after %1 : i1
    llhd.drv %alert_info_ctrl_en_qs, %u_alert_info_ctrl_en.qs after %1 : i1
    %31 = llhd.sig.struct_extract %28["index"] : <!hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>>
    %32 = llhd.sig.struct_extract %31["q"] : <!hw.struct<q: i4>>
    %u_alert_info_ctrl_index.qe, %u_alert_info_ctrl_index.q, %u_alert_info_ctrl_index.ds, %u_alert_info_ctrl_index.qs = hw.instance "u_alert_info_ctrl_index" @prim_subreg_9(clk_i: %clk_por_i: i1, rst_ni: %rst_por_ni: i1, we: %27: i1, wd: %132: i4, de: %false: i1, d: %c0_i4: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %32, %u_alert_info_ctrl_index.q after %1 : i4
    llhd.drv %alert_info_ctrl_index_qs, %u_alert_info_ctrl_index.qs after %1 : i4
    %alert_info_attr = hw.struct_extract %hw2reg["alert_info_attr"] : !hw.struct<reset_req: !hw.struct<d: i4, de: i1>, reset_info: !hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>, alert_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, alert_info_attr: !hw.struct<d: i4>, alert_info: !hw.struct<d: i32>, cpu_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, cpu_info_attr: !hw.struct<d: i4>, cpu_info: !hw.struct<d: i32>, err_code: !hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %d_10 = hw.struct_extract %alert_info_attr["d"] : !hw.struct<d: i4>
    %u_alert_info_attr.qe, %u_alert_info_attr.qre, %u_alert_info_attr.q, %u_alert_info_attr.ds, %u_alert_info_attr.qs = hw.instance "u_alert_info_attr" @prim_subreg_ext_10(re: %134: i1, we: %false: i1, wd: %c0_i4: i4, d: %d_10: i4) -> (qe: i1, qre: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %alert_info_attr_qs, %u_alert_info_attr.qs after %1 : i4
    %alert_info = hw.struct_extract %hw2reg["alert_info"] : !hw.struct<reset_req: !hw.struct<d: i4, de: i1>, reset_info: !hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>, alert_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, alert_info_attr: !hw.struct<d: i4>, alert_info: !hw.struct<d: i32>, cpu_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, cpu_info_attr: !hw.struct<d: i4>, cpu_info: !hw.struct<d: i32>, err_code: !hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %d_11 = hw.struct_extract %alert_info["d"] : !hw.struct<d: i32>
    %u_alert_info.qe, %u_alert_info.qre, %u_alert_info.q, %u_alert_info.ds, %u_alert_info.qs = hw.instance "u_alert_info" @prim_subreg_ext_11(re: %136: i1, we: %false: i1, wd: %c0_i32: i32, d: %d_11: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %alert_info_qs, %u_alert_info.qs after %1 : i32
    %33 = llhd.prb %cpu_regwen_we : i1
    %u_cpu_regwen.qe, %u_cpu_regwen.q, %u_cpu_regwen.ds, %u_cpu_regwen.qs = hw.instance "u_cpu_regwen" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %33: i1, wd: %120: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %cpu_regwen_qs, %u_cpu_regwen.qs after %1 : i1
    %34 = llhd.prb %cpu_info_ctrl_gated_we : i1
    %cpu_info_ctrl = hw.struct_extract %hw2reg["cpu_info_ctrl"] : !hw.struct<reset_req: !hw.struct<d: i4, de: i1>, reset_info: !hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>, alert_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, alert_info_attr: !hw.struct<d: i4>, alert_info: !hw.struct<d: i32>, cpu_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, cpu_info_attr: !hw.struct<d: i4>, cpu_info: !hw.struct<d: i32>, err_code: !hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %en_12 = hw.struct_extract %cpu_info_ctrl["en"] : !hw.struct<en: !hw.struct<d: i1, de: i1>>
    %de_13 = hw.struct_extract %en_12["de"] : !hw.struct<d: i1, de: i1>
    %d_14 = hw.struct_extract %en_12["d"] : !hw.struct<d: i1, de: i1>
    %35 = llhd.sig.struct_extract %reg2hw["cpu_info_ctrl"] : <!hw.struct<alert_test: !hw.struct<fatal_cnsty_fault: !hw.struct<q: i1, qe: i1>, fatal_fault: !hw.struct<q: i1, qe: i1>>, reset_req: !hw.struct<q: i4>, reset_info: !hw.struct<hw_req: !hw.struct<q: i5>, sw_reset: !hw.struct<q: i1>>, alert_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, cpu_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, sw_rst_ctrl_n: !hw.array<8xstruct<q: i1>>, err_code: !hw.struct<fsm_err: !hw.struct<q: i1>, reset_consistency_err: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>>
    %36 = llhd.sig.struct_extract %35["en"] : <!hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>>
    %37 = llhd.sig.struct_extract %36["q"] : <!hw.struct<q: i1>>
    %u_cpu_info_ctrl_en.qe, %u_cpu_info_ctrl_en.q, %u_cpu_info_ctrl_en.ds, %u_cpu_info_ctrl_en.qs = hw.instance "u_cpu_info_ctrl_en" @prim_subreg_8(clk_i: %clk_por_i: i1, rst_ni: %rst_por_ni: i1, we: %34: i1, wd: %120: i1, de: %de_13: i1, d: %d_14: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %37, %u_cpu_info_ctrl_en.q after %1 : i1
    llhd.drv %cpu_info_ctrl_en_qs, %u_cpu_info_ctrl_en.qs after %1 : i1
    %38 = llhd.sig.struct_extract %35["index"] : <!hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>>
    %39 = llhd.sig.struct_extract %38["q"] : <!hw.struct<q: i4>>
    %u_cpu_info_ctrl_index.qe, %u_cpu_info_ctrl_index.q, %u_cpu_info_ctrl_index.ds, %u_cpu_info_ctrl_index.qs = hw.instance "u_cpu_info_ctrl_index" @prim_subreg_9(clk_i: %clk_por_i: i1, rst_ni: %rst_por_ni: i1, we: %34: i1, wd: %132: i4, de: %false: i1, d: %c0_i4: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %39, %u_cpu_info_ctrl_index.q after %1 : i4
    llhd.drv %cpu_info_ctrl_index_qs, %u_cpu_info_ctrl_index.qs after %1 : i4
    %cpu_info_attr = hw.struct_extract %hw2reg["cpu_info_attr"] : !hw.struct<reset_req: !hw.struct<d: i4, de: i1>, reset_info: !hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>, alert_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, alert_info_attr: !hw.struct<d: i4>, alert_info: !hw.struct<d: i32>, cpu_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, cpu_info_attr: !hw.struct<d: i4>, cpu_info: !hw.struct<d: i32>, err_code: !hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %d_15 = hw.struct_extract %cpu_info_attr["d"] : !hw.struct<d: i4>
    %u_cpu_info_attr.qe, %u_cpu_info_attr.qre, %u_cpu_info_attr.q, %u_cpu_info_attr.ds, %u_cpu_info_attr.qs = hw.instance "u_cpu_info_attr" @prim_subreg_ext_10(re: %141: i1, we: %false: i1, wd: %c0_i4: i4, d: %d_15: i4) -> (qe: i1, qre: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %cpu_info_attr_qs, %u_cpu_info_attr.qs after %1 : i4
    %cpu_info = hw.struct_extract %hw2reg["cpu_info"] : !hw.struct<reset_req: !hw.struct<d: i4, de: i1>, reset_info: !hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>, alert_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, alert_info_attr: !hw.struct<d: i4>, alert_info: !hw.struct<d: i32>, cpu_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, cpu_info_attr: !hw.struct<d: i4>, cpu_info: !hw.struct<d: i32>, err_code: !hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %d_16 = hw.struct_extract %cpu_info["d"] : !hw.struct<d: i32>
    %u_cpu_info.qe, %u_cpu_info.qre, %u_cpu_info.q, %u_cpu_info.ds, %u_cpu_info.qs = hw.instance "u_cpu_info" @prim_subreg_ext_11(re: %143: i1, we: %false: i1, wd: %c0_i32: i32, d: %d_16: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %cpu_info_qs, %u_cpu_info.qs after %1 : i32
    %40 = llhd.prb %sw_rst_regwen_0_we : i1
    %u_sw_rst_regwen_0.qe, %u_sw_rst_regwen_0.q, %u_sw_rst_regwen_0.ds, %u_sw_rst_regwen_0.qs = hw.instance "u_sw_rst_regwen_0" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %40: i1, wd: %120: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %sw_rst_regwen_0_qs, %u_sw_rst_regwen_0.qs after %1 : i1
    %41 = llhd.prb %sw_rst_regwen_1_we : i1
    %u_sw_rst_regwen_1.qe, %u_sw_rst_regwen_1.q, %u_sw_rst_regwen_1.ds, %u_sw_rst_regwen_1.qs = hw.instance "u_sw_rst_regwen_1" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %41: i1, wd: %120: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %sw_rst_regwen_1_qs, %u_sw_rst_regwen_1.qs after %1 : i1
    %42 = llhd.prb %sw_rst_regwen_2_we : i1
    %u_sw_rst_regwen_2.qe, %u_sw_rst_regwen_2.q, %u_sw_rst_regwen_2.ds, %u_sw_rst_regwen_2.qs = hw.instance "u_sw_rst_regwen_2" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %42: i1, wd: %120: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %sw_rst_regwen_2_qs, %u_sw_rst_regwen_2.qs after %1 : i1
    %43 = llhd.prb %sw_rst_regwen_3_we : i1
    %u_sw_rst_regwen_3.qe, %u_sw_rst_regwen_3.q, %u_sw_rst_regwen_3.ds, %u_sw_rst_regwen_3.qs = hw.instance "u_sw_rst_regwen_3" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %43: i1, wd: %120: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %sw_rst_regwen_3_qs, %u_sw_rst_regwen_3.qs after %1 : i1
    %44 = llhd.prb %sw_rst_regwen_4_we : i1
    %u_sw_rst_regwen_4.qe, %u_sw_rst_regwen_4.q, %u_sw_rst_regwen_4.ds, %u_sw_rst_regwen_4.qs = hw.instance "u_sw_rst_regwen_4" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %44: i1, wd: %120: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %sw_rst_regwen_4_qs, %u_sw_rst_regwen_4.qs after %1 : i1
    %45 = llhd.prb %sw_rst_regwen_5_we : i1
    %u_sw_rst_regwen_5.qe, %u_sw_rst_regwen_5.q, %u_sw_rst_regwen_5.ds, %u_sw_rst_regwen_5.qs = hw.instance "u_sw_rst_regwen_5" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %45: i1, wd: %120: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %sw_rst_regwen_5_qs, %u_sw_rst_regwen_5.qs after %1 : i1
    %46 = llhd.prb %sw_rst_regwen_6_we : i1
    %u_sw_rst_regwen_6.qe, %u_sw_rst_regwen_6.q, %u_sw_rst_regwen_6.ds, %u_sw_rst_regwen_6.qs = hw.instance "u_sw_rst_regwen_6" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %46: i1, wd: %120: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %sw_rst_regwen_6_qs, %u_sw_rst_regwen_6.qs after %1 : i1
    %47 = llhd.prb %sw_rst_regwen_7_we : i1
    %u_sw_rst_regwen_7.qe, %u_sw_rst_regwen_7.q, %u_sw_rst_regwen_7.ds, %u_sw_rst_regwen_7.qs = hw.instance "u_sw_rst_regwen_7" @prim_subreg_7(clk_i: %3: i1, rst_ni: %4: i1, we: %47: i1, wd: %120: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %sw_rst_regwen_7_qs, %u_sw_rst_regwen_7.qs after %1 : i1
    %48 = llhd.prb %sw_rst_ctrl_n_0_gated_we : i1
    %49 = llhd.sig.struct_extract %reg2hw["sw_rst_ctrl_n"] : <!hw.struct<alert_test: !hw.struct<fatal_cnsty_fault: !hw.struct<q: i1, qe: i1>, fatal_fault: !hw.struct<q: i1, qe: i1>>, reset_req: !hw.struct<q: i4>, reset_info: !hw.struct<hw_req: !hw.struct<q: i5>, sw_reset: !hw.struct<q: i1>>, alert_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, cpu_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, sw_rst_ctrl_n: !hw.array<8xstruct<q: i1>>, err_code: !hw.struct<fsm_err: !hw.struct<q: i1>, reset_consistency_err: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>>
    %50 = llhd.sig.array_get %49[%c0_i3] : <!hw.array<8xstruct<q: i1>>>
    %51 = llhd.sig.struct_extract %50["q"] : <!hw.struct<q: i1>>
    %u_sw_rst_ctrl_n_0.qe, %u_sw_rst_ctrl_n_0.q, %u_sw_rst_ctrl_n_0.ds, %u_sw_rst_ctrl_n_0.qs = hw.instance "u_sw_rst_ctrl_n_0" @prim_subreg_12(clk_i: %3: i1, rst_ni: %4: i1, we: %48: i1, wd: %120: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %51, %u_sw_rst_ctrl_n_0.q after %1 : i1
    llhd.drv %sw_rst_ctrl_n_0_qs, %u_sw_rst_ctrl_n_0.qs after %1 : i1
    %52 = llhd.prb %sw_rst_ctrl_n_1_gated_we : i1
    %53 = llhd.sig.array_get %49[%c1_i3] : <!hw.array<8xstruct<q: i1>>>
    %54 = llhd.sig.struct_extract %53["q"] : <!hw.struct<q: i1>>
    %u_sw_rst_ctrl_n_1.qe, %u_sw_rst_ctrl_n_1.q, %u_sw_rst_ctrl_n_1.ds, %u_sw_rst_ctrl_n_1.qs = hw.instance "u_sw_rst_ctrl_n_1" @prim_subreg_12(clk_i: %3: i1, rst_ni: %4: i1, we: %52: i1, wd: %120: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %54, %u_sw_rst_ctrl_n_1.q after %1 : i1
    llhd.drv %sw_rst_ctrl_n_1_qs, %u_sw_rst_ctrl_n_1.qs after %1 : i1
    %55 = llhd.prb %sw_rst_ctrl_n_2_gated_we : i1
    %56 = llhd.sig.array_get %49[%c2_i3] : <!hw.array<8xstruct<q: i1>>>
    %57 = llhd.sig.struct_extract %56["q"] : <!hw.struct<q: i1>>
    %u_sw_rst_ctrl_n_2.qe, %u_sw_rst_ctrl_n_2.q, %u_sw_rst_ctrl_n_2.ds, %u_sw_rst_ctrl_n_2.qs = hw.instance "u_sw_rst_ctrl_n_2" @prim_subreg_12(clk_i: %3: i1, rst_ni: %4: i1, we: %55: i1, wd: %120: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %57, %u_sw_rst_ctrl_n_2.q after %1 : i1
    llhd.drv %sw_rst_ctrl_n_2_qs, %u_sw_rst_ctrl_n_2.qs after %1 : i1
    %58 = llhd.prb %sw_rst_ctrl_n_3_gated_we : i1
    %59 = llhd.sig.array_get %49[%c3_i3] : <!hw.array<8xstruct<q: i1>>>
    %60 = llhd.sig.struct_extract %59["q"] : <!hw.struct<q: i1>>
    %u_sw_rst_ctrl_n_3.qe, %u_sw_rst_ctrl_n_3.q, %u_sw_rst_ctrl_n_3.ds, %u_sw_rst_ctrl_n_3.qs = hw.instance "u_sw_rst_ctrl_n_3" @prim_subreg_12(clk_i: %3: i1, rst_ni: %4: i1, we: %58: i1, wd: %120: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %60, %u_sw_rst_ctrl_n_3.q after %1 : i1
    llhd.drv %sw_rst_ctrl_n_3_qs, %u_sw_rst_ctrl_n_3.qs after %1 : i1
    %61 = llhd.prb %sw_rst_ctrl_n_4_gated_we : i1
    %62 = llhd.sig.array_get %49[%c-4_i3] : <!hw.array<8xstruct<q: i1>>>
    %63 = llhd.sig.struct_extract %62["q"] : <!hw.struct<q: i1>>
    %u_sw_rst_ctrl_n_4.qe, %u_sw_rst_ctrl_n_4.q, %u_sw_rst_ctrl_n_4.ds, %u_sw_rst_ctrl_n_4.qs = hw.instance "u_sw_rst_ctrl_n_4" @prim_subreg_12(clk_i: %3: i1, rst_ni: %4: i1, we: %61: i1, wd: %120: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %63, %u_sw_rst_ctrl_n_4.q after %1 : i1
    llhd.drv %sw_rst_ctrl_n_4_qs, %u_sw_rst_ctrl_n_4.qs after %1 : i1
    %64 = llhd.prb %sw_rst_ctrl_n_5_gated_we : i1
    %65 = llhd.sig.array_get %49[%c-3_i3] : <!hw.array<8xstruct<q: i1>>>
    %66 = llhd.sig.struct_extract %65["q"] : <!hw.struct<q: i1>>
    %u_sw_rst_ctrl_n_5.qe, %u_sw_rst_ctrl_n_5.q, %u_sw_rst_ctrl_n_5.ds, %u_sw_rst_ctrl_n_5.qs = hw.instance "u_sw_rst_ctrl_n_5" @prim_subreg_12(clk_i: %3: i1, rst_ni: %4: i1, we: %64: i1, wd: %120: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %66, %u_sw_rst_ctrl_n_5.q after %1 : i1
    llhd.drv %sw_rst_ctrl_n_5_qs, %u_sw_rst_ctrl_n_5.qs after %1 : i1
    %67 = llhd.prb %sw_rst_ctrl_n_6_gated_we : i1
    %68 = llhd.sig.array_get %49[%c-2_i3] : <!hw.array<8xstruct<q: i1>>>
    %69 = llhd.sig.struct_extract %68["q"] : <!hw.struct<q: i1>>
    %u_sw_rst_ctrl_n_6.qe, %u_sw_rst_ctrl_n_6.q, %u_sw_rst_ctrl_n_6.ds, %u_sw_rst_ctrl_n_6.qs = hw.instance "u_sw_rst_ctrl_n_6" @prim_subreg_12(clk_i: %3: i1, rst_ni: %4: i1, we: %67: i1, wd: %120: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %69, %u_sw_rst_ctrl_n_6.q after %1 : i1
    llhd.drv %sw_rst_ctrl_n_6_qs, %u_sw_rst_ctrl_n_6.qs after %1 : i1
    %70 = llhd.prb %sw_rst_ctrl_n_7_gated_we : i1
    %71 = llhd.sig.array_get %49[%c-1_i3] : <!hw.array<8xstruct<q: i1>>>
    %72 = llhd.sig.struct_extract %71["q"] : <!hw.struct<q: i1>>
    %u_sw_rst_ctrl_n_7.qe, %u_sw_rst_ctrl_n_7.q, %u_sw_rst_ctrl_n_7.ds, %u_sw_rst_ctrl_n_7.qs = hw.instance "u_sw_rst_ctrl_n_7" @prim_subreg_12(clk_i: %3: i1, rst_ni: %4: i1, we: %70: i1, wd: %120: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %72, %u_sw_rst_ctrl_n_7.q after %1 : i1
    llhd.drv %sw_rst_ctrl_n_7_qs, %u_sw_rst_ctrl_n_7.qs after %1 : i1
    %err_code = hw.struct_extract %hw2reg["err_code"] : !hw.struct<reset_req: !hw.struct<d: i4, de: i1>, reset_info: !hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>, alert_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, alert_info_attr: !hw.struct<d: i4>, alert_info: !hw.struct<d: i32>, cpu_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, cpu_info_attr: !hw.struct<d: i4>, cpu_info: !hw.struct<d: i32>, err_code: !hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %reg_intg_err = hw.struct_extract %err_code["reg_intg_err"] : !hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>
    %de_17 = hw.struct_extract %reg_intg_err["de"] : !hw.struct<d: i1, de: i1>
    %d_18 = hw.struct_extract %reg_intg_err["d"] : !hw.struct<d: i1, de: i1>
    %73 = llhd.sig.struct_extract %reg2hw["err_code"] : <!hw.struct<alert_test: !hw.struct<fatal_cnsty_fault: !hw.struct<q: i1, qe: i1>, fatal_fault: !hw.struct<q: i1, qe: i1>>, reset_req: !hw.struct<q: i4>, reset_info: !hw.struct<hw_req: !hw.struct<q: i5>, sw_reset: !hw.struct<q: i1>>, alert_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, cpu_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, sw_rst_ctrl_n: !hw.array<8xstruct<q: i1>>, err_code: !hw.struct<fsm_err: !hw.struct<q: i1>, reset_consistency_err: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>>
    %74 = llhd.sig.struct_extract %73["reg_intg_err"] : <!hw.struct<fsm_err: !hw.struct<q: i1>, reset_consistency_err: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %75 = llhd.sig.struct_extract %74["q"] : <!hw.struct<q: i1>>
    %u_err_code_reg_intg_err.qe, %u_err_code_reg_intg_err.q, %u_err_code_reg_intg_err.ds, %u_err_code_reg_intg_err.qs = hw.instance "u_err_code_reg_intg_err" @prim_subreg_13(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_17: i1, d: %d_18: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %75, %u_err_code_reg_intg_err.q after %1 : i1
    llhd.drv %err_code_reg_intg_err_qs, %u_err_code_reg_intg_err.qs after %1 : i1
    %reset_consistency_err = hw.struct_extract %err_code["reset_consistency_err"] : !hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>
    %de_19 = hw.struct_extract %reset_consistency_err["de"] : !hw.struct<d: i1, de: i1>
    %d_20 = hw.struct_extract %reset_consistency_err["d"] : !hw.struct<d: i1, de: i1>
    %76 = llhd.sig.struct_extract %73["reset_consistency_err"] : <!hw.struct<fsm_err: !hw.struct<q: i1>, reset_consistency_err: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %77 = llhd.sig.struct_extract %76["q"] : <!hw.struct<q: i1>>
    %u_err_code_reset_consistency_err.qe, %u_err_code_reset_consistency_err.q, %u_err_code_reset_consistency_err.ds, %u_err_code_reset_consistency_err.qs = hw.instance "u_err_code_reset_consistency_err" @prim_subreg_13(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_19: i1, d: %d_20: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %77, %u_err_code_reset_consistency_err.q after %1 : i1
    llhd.drv %err_code_reset_consistency_err_qs, %u_err_code_reset_consistency_err.qs after %1 : i1
    %fsm_err = hw.struct_extract %err_code["fsm_err"] : !hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>
    %de_21 = hw.struct_extract %fsm_err["de"] : !hw.struct<d: i1, de: i1>
    %d_22 = hw.struct_extract %fsm_err["d"] : !hw.struct<d: i1, de: i1>
    %78 = llhd.sig.struct_extract %73["fsm_err"] : <!hw.struct<fsm_err: !hw.struct<q: i1>, reset_consistency_err: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %79 = llhd.sig.struct_extract %78["q"] : <!hw.struct<q: i1>>
    %u_err_code_fsm_err.qe, %u_err_code_fsm_err.q, %u_err_code_fsm_err.ds, %u_err_code_fsm_err.qs = hw.instance "u_err_code_fsm_err" @prim_subreg_13(clk_i: %3: i1, rst_ni: %4: i1, we: %false: i1, wd: %false: i1, de: %de_21: i1, d: %d_22: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %79, %u_err_code_fsm_err.q after %1 : i1
    llhd.drv %err_code_fsm_err_qs, %u_err_code_fsm_err.qs after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %193 = llhd.prb %clk_i_0 : i1
      %194 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %195 = llhd.prb %clk_i_0 : i1
      %196 = comb.xor bin %193, %true : i1
      %197 = comb.and bin %196, %195 : i1
      %198 = llhd.prb %rst_ni_1 : i1
      %199 = comb.xor bin %198, %true : i1
      %200 = comb.and bin %194, %199 : i1
      %201 = comb.or bin %197, %200 : i1
      cf.cond_br %201, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %202 = llhd.prb %rst_ni_1 : i1
      %203 = comb.xor %202, %true : i1
      cf.cond_br %203, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %err_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %204 = llhd.prb %intg_err : i1
      %205 = llhd.prb %reg_we_err : i1
      %206 = comb.or %204, %205 : i1
      cf.cond_br %206, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %err_q, %true after %0 : i1
      cf.br ^bb1
    }
    %80 = llhd.prb %err_q : i1
    %81 = llhd.prb %intg_err : i1
    %82 = llhd.prb %reg_we_err : i1
    %83 = comb.or %80, %81, %82 : i1
    %84 = llhd.prb %reg_rdata_next {sv.namehint = "reg_rdata"} : i32
    %85 = llhd.prb %wr_err : i1
    %86 = comb.or %115, %85, %81 {sv.namehint = "reg_error"} : i1
    %87 = llhd.prb %alert_test_flds_we : i2
    %88 = comb.icmp eq %87, %c-1_i2 {sv.namehint = "alert_test_qe"} : i2
    %89 = llhd.sig.struct_extract %12["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %89, %88 after %1 : i1
    %90 = llhd.sig.struct_extract %15["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %90, %88 after %1 : i1
    %91 = llhd.prb %alert_regwen_qs : i1
    %92 = comb.and %131, %6, %118, %91 : i1
    llhd.drv %alert_info_ctrl_gated_we, %92 after %1 : i1
    %93 = llhd.prb %cpu_regwen_qs : i1
    %94 = comb.and %139, %6, %118, %93 : i1
    llhd.drv %cpu_info_ctrl_gated_we, %94 after %1 : i1
    %95 = llhd.prb %sw_rst_regwen_0_qs : i1
    %96 = comb.and %160, %6, %118, %95 : i1
    llhd.drv %sw_rst_ctrl_n_0_gated_we, %96 after %1 : i1
    %97 = llhd.prb %sw_rst_regwen_1_qs : i1
    %98 = comb.and %161, %6, %118, %97 : i1
    llhd.drv %sw_rst_ctrl_n_1_gated_we, %98 after %1 : i1
    %99 = llhd.prb %sw_rst_regwen_2_qs : i1
    %100 = comb.and %162, %6, %118, %99 : i1
    llhd.drv %sw_rst_ctrl_n_2_gated_we, %100 after %1 : i1
    %101 = llhd.prb %sw_rst_regwen_3_qs : i1
    %102 = comb.and %163, %6, %118, %101 : i1
    llhd.drv %sw_rst_ctrl_n_3_gated_we, %102 after %1 : i1
    %103 = llhd.prb %sw_rst_regwen_4_qs : i1
    %104 = comb.and %164, %6, %118, %103 : i1
    llhd.drv %sw_rst_ctrl_n_4_gated_we, %104 after %1 : i1
    %105 = llhd.prb %sw_rst_regwen_5_qs : i1
    %106 = comb.and %165, %6, %118, %105 : i1
    llhd.drv %sw_rst_ctrl_n_5_gated_we, %106 after %1 : i1
    %107 = llhd.prb %sw_rst_regwen_6_qs : i1
    %108 = comb.and %166, %6, %118, %107 : i1
    llhd.drv %sw_rst_ctrl_n_6_gated_we, %108 after %1 : i1
    %109 = llhd.prb %sw_rst_regwen_7_qs : i1
    %110 = comb.and %167, %6, %118, %109 : i1
    llhd.drv %sw_rst_ctrl_n_7_gated_we, %110 after %1 : i1
    %111 = llhd.prb %addr_hit : i28
    %112 = llhd.prb %reg_addr : i7
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %193 = llhd.sig.extract %addr_hit from %c0_i5 : <i28> -> <i1>
      %194 = llhd.prb %reg_addr : i7
      %195 = comb.icmp eq %194, %c0_i7 : i7
      llhd.drv %193, %195 after %1 : i1
      %196 = llhd.sig.extract %addr_hit from %c1_i5 : <i28> -> <i1>
      %197 = llhd.prb %reg_addr : i7
      %198 = comb.icmp eq %197, %c4_i7 : i7
      llhd.drv %196, %198 after %1 : i1
      %199 = llhd.sig.extract %addr_hit from %c2_i5 : <i28> -> <i1>
      %200 = llhd.prb %reg_addr : i7
      %201 = comb.icmp eq %200, %c8_i7 : i7
      llhd.drv %199, %201 after %1 : i1
      %202 = llhd.sig.extract %addr_hit from %c3_i5 : <i28> -> <i1>
      %203 = llhd.prb %reg_addr : i7
      %204 = comb.icmp eq %203, %c12_i7 : i7
      llhd.drv %202, %204 after %1 : i1
      %205 = llhd.sig.extract %addr_hit from %c4_i5 : <i28> -> <i1>
      %206 = llhd.prb %reg_addr : i7
      %207 = comb.icmp eq %206, %c16_i7 : i7
      llhd.drv %205, %207 after %1 : i1
      %208 = llhd.sig.extract %addr_hit from %c5_i5 : <i28> -> <i1>
      %209 = llhd.prb %reg_addr : i7
      %210 = comb.icmp eq %209, %c20_i7 : i7
      llhd.drv %208, %210 after %1 : i1
      %211 = llhd.sig.extract %addr_hit from %c6_i5 : <i28> -> <i1>
      %212 = llhd.prb %reg_addr : i7
      %213 = comb.icmp eq %212, %c24_i7 : i7
      llhd.drv %211, %213 after %1 : i1
      %214 = llhd.sig.extract %addr_hit from %c7_i5 : <i28> -> <i1>
      %215 = llhd.prb %reg_addr : i7
      %216 = comb.icmp eq %215, %c28_i7 : i7
      llhd.drv %214, %216 after %1 : i1
      %217 = llhd.sig.extract %addr_hit from %c8_i5 : <i28> -> <i1>
      %218 = llhd.prb %reg_addr : i7
      %219 = comb.icmp eq %218, %c32_i7 : i7
      llhd.drv %217, %219 after %1 : i1
      %220 = llhd.sig.extract %addr_hit from %c9_i5 : <i28> -> <i1>
      %221 = llhd.prb %reg_addr : i7
      %222 = comb.icmp eq %221, %c36_i7 : i7
      llhd.drv %220, %222 after %1 : i1
      %223 = llhd.sig.extract %addr_hit from %c10_i5 : <i28> -> <i1>
      %224 = llhd.prb %reg_addr : i7
      %225 = comb.icmp eq %224, %c40_i7 : i7
      llhd.drv %223, %225 after %1 : i1
      %226 = llhd.sig.extract %addr_hit from %c11_i5 : <i28> -> <i1>
      %227 = llhd.prb %reg_addr : i7
      %228 = comb.icmp eq %227, %c44_i7 : i7
      llhd.drv %226, %228 after %1 : i1
      %229 = llhd.sig.extract %addr_hit from %c12_i5 : <i28> -> <i1>
      %230 = llhd.prb %reg_addr : i7
      %231 = comb.icmp eq %230, %c48_i7 : i7
      llhd.drv %229, %231 after %1 : i1
      %232 = llhd.sig.extract %addr_hit from %c13_i5 : <i28> -> <i1>
      %233 = llhd.prb %reg_addr : i7
      %234 = comb.icmp eq %233, %c52_i7 : i7
      llhd.drv %232, %234 after %1 : i1
      %235 = llhd.sig.extract %addr_hit from %c14_i5 : <i28> -> <i1>
      %236 = llhd.prb %reg_addr : i7
      %237 = comb.icmp eq %236, %c56_i7 : i7
      llhd.drv %235, %237 after %1 : i1
      %238 = llhd.sig.extract %addr_hit from %c15_i5 : <i28> -> <i1>
      %239 = llhd.prb %reg_addr : i7
      %240 = comb.icmp eq %239, %c60_i7 : i7
      llhd.drv %238, %240 after %1 : i1
      %241 = llhd.sig.extract %addr_hit from %c-16_i5 : <i28> -> <i1>
      %242 = llhd.prb %reg_addr : i7
      %243 = comb.icmp eq %242, %c-64_i7 : i7
      llhd.drv %241, %243 after %1 : i1
      %244 = llhd.sig.extract %addr_hit from %c-15_i5 : <i28> -> <i1>
      %245 = llhd.prb %reg_addr : i7
      %246 = comb.icmp eq %245, %c-60_i7 : i7
      llhd.drv %244, %246 after %1 : i1
      %247 = llhd.sig.extract %addr_hit from %c-14_i5 : <i28> -> <i1>
      %248 = llhd.prb %reg_addr : i7
      %249 = comb.icmp eq %248, %c-56_i7 : i7
      llhd.drv %247, %249 after %1 : i1
      %250 = llhd.sig.extract %addr_hit from %c-13_i5 : <i28> -> <i1>
      %251 = llhd.prb %reg_addr : i7
      %252 = comb.icmp eq %251, %c-52_i7 : i7
      llhd.drv %250, %252 after %1 : i1
      %253 = llhd.sig.extract %addr_hit from %c-12_i5 : <i28> -> <i1>
      %254 = llhd.prb %reg_addr : i7
      %255 = comb.icmp eq %254, %c-48_i7 : i7
      llhd.drv %253, %255 after %1 : i1
      %256 = llhd.sig.extract %addr_hit from %c-11_i5 : <i28> -> <i1>
      %257 = llhd.prb %reg_addr : i7
      %258 = comb.icmp eq %257, %c-44_i7 : i7
      llhd.drv %256, %258 after %1 : i1
      %259 = llhd.sig.extract %addr_hit from %c-10_i5 : <i28> -> <i1>
      %260 = llhd.prb %reg_addr : i7
      %261 = comb.icmp eq %260, %c-40_i7 : i7
      llhd.drv %259, %261 after %1 : i1
      %262 = llhd.sig.extract %addr_hit from %c-9_i5 : <i28> -> <i1>
      %263 = llhd.prb %reg_addr : i7
      %264 = comb.icmp eq %263, %c-36_i7 : i7
      llhd.drv %262, %264 after %1 : i1
      %265 = llhd.sig.extract %addr_hit from %c-8_i5 : <i28> -> <i1>
      %266 = llhd.prb %reg_addr : i7
      %267 = comb.icmp eq %266, %c-32_i7 : i7
      llhd.drv %265, %267 after %1 : i1
      %268 = llhd.sig.extract %addr_hit from %c-7_i5 : <i28> -> <i1>
      %269 = llhd.prb %reg_addr : i7
      %270 = comb.icmp eq %269, %c-28_i7 : i7
      llhd.drv %268, %270 after %1 : i1
      %271 = llhd.sig.extract %addr_hit from %c-6_i5 : <i28> -> <i1>
      %272 = llhd.prb %reg_addr : i7
      %273 = comb.icmp eq %272, %c-24_i7 : i7
      llhd.drv %271, %273 after %1 : i1
      %274 = llhd.sig.extract %addr_hit from %c-5_i5 : <i28> -> <i1>
      %275 = llhd.prb %reg_addr : i7
      %276 = comb.icmp eq %275, %c-20_i7 : i7
      llhd.drv %274, %276 after %1 : i1
      llhd.wait (%111, %112 : i28, i7), ^bb1
    }
    %113 = comb.or %u_reg_if.re_o, %6 : i1
    %114 = comb.icmp eq %111, %c0_i28 : i28
    %115 = comb.and %113, %114 {sv.namehint = "addrmiss"} : i1
    %116 = llhd.prb %reg_be : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %193 = llhd.prb %reg_we : i1
      %194 = llhd.prb %addr_hit : i28
      %195 = comb.extract %194 from 0 : (i28) -> i1
      %196 = llhd.prb %reg_be : i4
      %197 = comb.extract %196 from 0 : (i4) -> i1
      %198 = comb.xor %197, %true : i1
      %199 = comb.and %195, %198 : i1
      %200 = comb.extract %194 from 1 : (i28) -> i1
      %201 = comb.and %200, %198 : i1
      %202 = comb.extract %194 from 2 : (i28) -> i1
      %203 = comb.and %202, %198 : i1
      %204 = comb.extract %194 from 3 : (i28) -> i1
      %205 = comb.and %204, %198 : i1
      %206 = comb.extract %194 from 4 : (i28) -> i1
      %207 = comb.and %206, %198 : i1
      %208 = comb.extract %194 from 5 : (i28) -> i1
      %209 = comb.and %208, %198 : i1
      %210 = comb.extract %194 from 6 : (i28) -> i1
      %211 = comb.icmp ne %196, %c-1_i4 : i4
      %212 = comb.and %210, %211 : i1
      %213 = comb.extract %194 from 7 : (i28) -> i1
      %214 = comb.and %213, %198 : i1
      %215 = comb.extract %194 from 8 : (i28) -> i1
      %216 = comb.and %215, %198 : i1
      %217 = comb.extract %194 from 9 : (i28) -> i1
      %218 = comb.and %217, %198 : i1
      %219 = comb.extract %194 from 10 : (i28) -> i1
      %220 = comb.icmp ne %196, %c-1_i4 : i4
      %221 = comb.and %219, %220 : i1
      %222 = comb.extract %194 from 11 : (i28) -> i1
      %223 = comb.and %222, %198 : i1
      %224 = comb.extract %194 from 12 : (i28) -> i1
      %225 = comb.and %224, %198 : i1
      %226 = comb.extract %194 from 13 : (i28) -> i1
      %227 = comb.and %226, %198 : i1
      %228 = comb.extract %194 from 14 : (i28) -> i1
      %229 = comb.and %228, %198 : i1
      %230 = comb.extract %194 from 15 : (i28) -> i1
      %231 = comb.and %230, %198 : i1
      %232 = comb.extract %194 from 16 : (i28) -> i1
      %233 = comb.and %232, %198 : i1
      %234 = comb.extract %194 from 17 : (i28) -> i1
      %235 = comb.and %234, %198 : i1
      %236 = comb.extract %194 from 18 : (i28) -> i1
      %237 = comb.and %236, %198 : i1
      %238 = comb.extract %194 from 19 : (i28) -> i1
      %239 = comb.and %238, %198 : i1
      %240 = comb.extract %194 from 20 : (i28) -> i1
      %241 = comb.and %240, %198 : i1
      %242 = comb.extract %194 from 21 : (i28) -> i1
      %243 = comb.and %242, %198 : i1
      %244 = comb.extract %194 from 22 : (i28) -> i1
      %245 = comb.and %244, %198 : i1
      %246 = comb.extract %194 from 23 : (i28) -> i1
      %247 = comb.and %246, %198 : i1
      %248 = comb.extract %194 from 24 : (i28) -> i1
      %249 = comb.and %248, %198 : i1
      %250 = comb.extract %194 from 25 : (i28) -> i1
      %251 = comb.and %250, %198 : i1
      %252 = comb.extract %194 from 26 : (i28) -> i1
      %253 = comb.and %252, %198 : i1
      %254 = comb.extract %194 from 27 : (i28) -> i1
      %255 = comb.and %254, %198 : i1
      %256 = comb.or %199, %201, %203, %205, %207, %209, %212, %214, %216, %218, %221, %223, %225, %227, %229, %231, %233, %235, %237, %239, %241, %243, %245, %247, %249, %251, %253, %255 : i1
      %257 = comb.and %193, %256 : i1
      llhd.drv %wr_err, %257 after %1 : i1
      llhd.wait (%6, %111, %116, %85 : i1, i28, i4, i1), ^bb1
    }
    %117 = comb.extract %111 from 0 : (i28) -> i1
    %118 = comb.xor %86, %true : i1
    %119 = comb.and %117, %6, %118 : i1
    llhd.drv %alert_test_we, %119 after %1 : i1
    %120 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "cpu_regwen_wd"} : (i32) -> i1
    %121 = comb.extract %u_reg_if.wdata_o from 1 {sv.namehint = "reset_info_low_power_exit_wd"} : (i32) -> i1
    %122 = comb.extract %111 from 1 : (i28) -> i1
    %123 = comb.and %122, %6, %118 : i1
    llhd.drv %reset_req_we, %123 after %1 : i1
    %124 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "reset_req_wd"} : (i32) -> i4
    %125 = comb.extract %111 from 2 : (i28) -> i1
    %126 = comb.and %125, %6, %118 : i1
    llhd.drv %reset_info_we, %126 after %1 : i1
    %127 = comb.extract %u_reg_if.wdata_o from 2 {sv.namehint = "reset_info_sw_reset_wd"} : (i32) -> i1
    %128 = comb.extract %u_reg_if.wdata_o from 3 {sv.namehint = "reset_info_hw_req_wd"} : (i32) -> i5
    %129 = comb.extract %111 from 3 : (i28) -> i1
    %130 = comb.and %129, %6, %118 : i1
    llhd.drv %alert_regwen_we, %130 after %1 : i1
    %131 = comb.extract %111 from 4 : (i28) -> i1
    %132 = comb.extract %u_reg_if.wdata_o from 4 {sv.namehint = "cpu_info_ctrl_index_wd"} : (i32) -> i4
    %133 = comb.extract %111 from 5 : (i28) -> i1
    %134 = comb.and %133, %u_reg_if.re_o, %118 {sv.namehint = "alert_info_attr_re"} : i1
    %135 = comb.extract %111 from 6 : (i28) -> i1
    %136 = comb.and %135, %u_reg_if.re_o, %118 {sv.namehint = "alert_info_re"} : i1
    %137 = comb.extract %111 from 7 : (i28) -> i1
    %138 = comb.and %137, %6, %118 : i1
    llhd.drv %cpu_regwen_we, %138 after %1 : i1
    %139 = comb.extract %111 from 8 : (i28) -> i1
    %140 = comb.extract %111 from 9 : (i28) -> i1
    %141 = comb.and %140, %u_reg_if.re_o, %118 {sv.namehint = "cpu_info_attr_re"} : i1
    %142 = comb.extract %111 from 10 : (i28) -> i1
    %143 = comb.and %142, %u_reg_if.re_o, %118 {sv.namehint = "cpu_info_re"} : i1
    %144 = comb.extract %111 from 11 : (i28) -> i1
    %145 = comb.and %144, %6, %118 : i1
    llhd.drv %sw_rst_regwen_0_we, %145 after %1 : i1
    %146 = comb.extract %111 from 12 : (i28) -> i1
    %147 = comb.and %146, %6, %118 : i1
    llhd.drv %sw_rst_regwen_1_we, %147 after %1 : i1
    %148 = comb.extract %111 from 13 : (i28) -> i1
    %149 = comb.and %148, %6, %118 : i1
    llhd.drv %sw_rst_regwen_2_we, %149 after %1 : i1
    %150 = comb.extract %111 from 14 : (i28) -> i1
    %151 = comb.and %150, %6, %118 : i1
    llhd.drv %sw_rst_regwen_3_we, %151 after %1 : i1
    %152 = comb.extract %111 from 15 : (i28) -> i1
    %153 = comb.and %152, %6, %118 : i1
    llhd.drv %sw_rst_regwen_4_we, %153 after %1 : i1
    %154 = comb.extract %111 from 16 : (i28) -> i1
    %155 = comb.and %154, %6, %118 : i1
    llhd.drv %sw_rst_regwen_5_we, %155 after %1 : i1
    %156 = comb.extract %111 from 17 : (i28) -> i1
    %157 = comb.and %156, %6, %118 : i1
    llhd.drv %sw_rst_regwen_6_we, %157 after %1 : i1
    %158 = comb.extract %111 from 18 : (i28) -> i1
    %159 = comb.and %158, %6, %118 : i1
    llhd.drv %sw_rst_regwen_7_we, %159 after %1 : i1
    %160 = comb.extract %111 from 19 : (i28) -> i1
    %161 = comb.extract %111 from 20 : (i28) -> i1
    %162 = comb.extract %111 from 21 : (i28) -> i1
    %163 = comb.extract %111 from 22 : (i28) -> i1
    %164 = comb.extract %111 from 23 : (i28) -> i1
    %165 = comb.extract %111 from 24 : (i28) -> i1
    %166 = comb.extract %111 from 25 : (i28) -> i1
    %167 = comb.extract %111 from 26 : (i28) -> i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %193 = llhd.sig.extract %reg_we_check from %c0_i5 : <i28> -> <i1>
      %194 = llhd.prb %alert_test_we : i1
      llhd.drv %193, %194 after %1 : i1
      %195 = llhd.sig.extract %reg_we_check from %c1_i5 : <i28> -> <i1>
      %196 = llhd.prb %reset_req_we : i1
      llhd.drv %195, %196 after %1 : i1
      %197 = llhd.sig.extract %reg_we_check from %c2_i5 : <i28> -> <i1>
      %198 = llhd.prb %reset_info_we : i1
      llhd.drv %197, %198 after %1 : i1
      %199 = llhd.sig.extract %reg_we_check from %c3_i5 : <i28> -> <i1>
      %200 = llhd.prb %alert_regwen_we : i1
      llhd.drv %199, %200 after %1 : i1
      %201 = llhd.sig.extract %reg_we_check from %c4_i5 : <i28> -> <i1>
      %202 = llhd.prb %alert_info_ctrl_gated_we : i1
      llhd.drv %201, %202 after %1 : i1
      %203 = llhd.sig.extract %reg_we_check from %c5_i5 : <i28> -> <i1>
      llhd.drv %203, %false after %1 : i1
      %204 = llhd.sig.extract %reg_we_check from %c6_i5 : <i28> -> <i1>
      llhd.drv %204, %false after %1 : i1
      %205 = llhd.sig.extract %reg_we_check from %c7_i5 : <i28> -> <i1>
      %206 = llhd.prb %cpu_regwen_we : i1
      llhd.drv %205, %206 after %1 : i1
      %207 = llhd.sig.extract %reg_we_check from %c8_i5 : <i28> -> <i1>
      %208 = llhd.prb %cpu_info_ctrl_gated_we : i1
      llhd.drv %207, %208 after %1 : i1
      %209 = llhd.sig.extract %reg_we_check from %c9_i5 : <i28> -> <i1>
      llhd.drv %209, %false after %1 : i1
      %210 = llhd.sig.extract %reg_we_check from %c10_i5 : <i28> -> <i1>
      llhd.drv %210, %false after %1 : i1
      %211 = llhd.sig.extract %reg_we_check from %c11_i5 : <i28> -> <i1>
      %212 = llhd.prb %sw_rst_regwen_0_we : i1
      llhd.drv %211, %212 after %1 : i1
      %213 = llhd.sig.extract %reg_we_check from %c12_i5 : <i28> -> <i1>
      %214 = llhd.prb %sw_rst_regwen_1_we : i1
      llhd.drv %213, %214 after %1 : i1
      %215 = llhd.sig.extract %reg_we_check from %c13_i5 : <i28> -> <i1>
      %216 = llhd.prb %sw_rst_regwen_2_we : i1
      llhd.drv %215, %216 after %1 : i1
      %217 = llhd.sig.extract %reg_we_check from %c14_i5 : <i28> -> <i1>
      %218 = llhd.prb %sw_rst_regwen_3_we : i1
      llhd.drv %217, %218 after %1 : i1
      %219 = llhd.sig.extract %reg_we_check from %c15_i5 : <i28> -> <i1>
      %220 = llhd.prb %sw_rst_regwen_4_we : i1
      llhd.drv %219, %220 after %1 : i1
      %221 = llhd.sig.extract %reg_we_check from %c-16_i5 : <i28> -> <i1>
      %222 = llhd.prb %sw_rst_regwen_5_we : i1
      llhd.drv %221, %222 after %1 : i1
      %223 = llhd.sig.extract %reg_we_check from %c-15_i5 : <i28> -> <i1>
      %224 = llhd.prb %sw_rst_regwen_6_we : i1
      llhd.drv %223, %224 after %1 : i1
      %225 = llhd.sig.extract %reg_we_check from %c-14_i5 : <i28> -> <i1>
      %226 = llhd.prb %sw_rst_regwen_7_we : i1
      llhd.drv %225, %226 after %1 : i1
      %227 = llhd.sig.extract %reg_we_check from %c-13_i5 : <i28> -> <i1>
      %228 = llhd.prb %sw_rst_ctrl_n_0_gated_we : i1
      llhd.drv %227, %228 after %1 : i1
      %229 = llhd.sig.extract %reg_we_check from %c-12_i5 : <i28> -> <i1>
      %230 = llhd.prb %sw_rst_ctrl_n_1_gated_we : i1
      llhd.drv %229, %230 after %1 : i1
      %231 = llhd.sig.extract %reg_we_check from %c-11_i5 : <i28> -> <i1>
      %232 = llhd.prb %sw_rst_ctrl_n_2_gated_we : i1
      llhd.drv %231, %232 after %1 : i1
      %233 = llhd.sig.extract %reg_we_check from %c-10_i5 : <i28> -> <i1>
      %234 = llhd.prb %sw_rst_ctrl_n_3_gated_we : i1
      llhd.drv %233, %234 after %1 : i1
      %235 = llhd.sig.extract %reg_we_check from %c-9_i5 : <i28> -> <i1>
      %236 = llhd.prb %sw_rst_ctrl_n_4_gated_we : i1
      llhd.drv %235, %236 after %1 : i1
      %237 = llhd.sig.extract %reg_we_check from %c-8_i5 : <i28> -> <i1>
      %238 = llhd.prb %sw_rst_ctrl_n_5_gated_we : i1
      llhd.drv %237, %238 after %1 : i1
      %239 = llhd.sig.extract %reg_we_check from %c-7_i5 : <i28> -> <i1>
      %240 = llhd.prb %sw_rst_ctrl_n_6_gated_we : i1
      llhd.drv %239, %240 after %1 : i1
      %241 = llhd.sig.extract %reg_we_check from %c-6_i5 : <i28> -> <i1>
      %242 = llhd.prb %sw_rst_ctrl_n_7_gated_we : i1
      llhd.drv %241, %242 after %1 : i1
      %243 = llhd.sig.extract %reg_we_check from %c-5_i5 : <i28> -> <i1>
      llhd.drv %243, %false after %1 : i1
      llhd.wait (%5, %9, %17, %20, %26, %27, %33, %34, %40, %41, %42, %43, %44, %45, %46, %47, %48, %52, %55, %58, %61, %64, %67, %70 : i28, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    %168 = llhd.prb %reset_req_qs : i4
    %169 = llhd.prb %reset_info_por_qs : i1
    %170 = llhd.prb %reset_info_low_power_exit_qs : i1
    %171 = llhd.prb %reset_info_sw_reset_qs : i1
    %172 = llhd.prb %reset_info_hw_req_qs : i5
    %173 = llhd.prb %alert_info_ctrl_en_qs : i1
    %174 = llhd.prb %alert_info_ctrl_index_qs : i4
    %175 = llhd.prb %alert_info_attr_qs : i4
    %176 = llhd.prb %alert_info_qs : i32
    %177 = llhd.prb %cpu_info_ctrl_en_qs : i1
    %178 = llhd.prb %cpu_info_ctrl_index_qs : i4
    %179 = llhd.prb %cpu_info_attr_qs : i4
    %180 = llhd.prb %cpu_info_qs : i32
    %181 = llhd.prb %sw_rst_ctrl_n_0_qs : i1
    %182 = llhd.prb %sw_rst_ctrl_n_1_qs : i1
    %183 = llhd.prb %sw_rst_ctrl_n_2_qs : i1
    %184 = llhd.prb %sw_rst_ctrl_n_3_qs : i1
    %185 = llhd.prb %sw_rst_ctrl_n_4_qs : i1
    %186 = llhd.prb %sw_rst_ctrl_n_5_qs : i1
    %187 = llhd.prb %sw_rst_ctrl_n_6_qs : i1
    %188 = llhd.prb %sw_rst_ctrl_n_7_qs : i1
    %189 = llhd.prb %err_code_reg_intg_err_qs : i1
    %190 = llhd.prb %err_code_reset_consistency_err_qs : i1
    %191 = llhd.prb %err_code_fsm_err_qs : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb58
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      %193 = llhd.prb %addr_hit : i28
      %194 = comb.extract %193 from 0 : (i28) -> i1
      %195 = comb.icmp ceq %194, %true : i1
      cf.cond_br %195, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %196 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      llhd.drv %196, %false after %1 : i1
      %197 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      llhd.drv %197, %false after %1 : i1
      cf.br ^bb58
    ^bb3:  // pred: ^bb1
      %198 = llhd.prb %addr_hit : i28
      %199 = comb.extract %198 from 1 : (i28) -> i1
      %200 = comb.icmp ceq %199, %true : i1
      cf.cond_br %200, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %201 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i4>
      %202 = llhd.prb %reset_req_qs : i4
      llhd.drv %201, %202 after %1 : i4
      cf.br ^bb58
    ^bb5:  // pred: ^bb3
      %203 = llhd.prb %addr_hit : i28
      %204 = comb.extract %203 from 2 : (i28) -> i1
      %205 = comb.icmp ceq %204, %true : i1
      cf.cond_br %205, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %206 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %207 = llhd.prb %reset_info_por_qs : i1
      llhd.drv %206, %207 after %1 : i1
      %208 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %209 = llhd.prb %reset_info_low_power_exit_qs : i1
      llhd.drv %208, %209 after %1 : i1
      %210 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %211 = llhd.prb %reset_info_sw_reset_qs : i1
      llhd.drv %210, %211 after %1 : i1
      %212 = llhd.sig.extract %reg_rdata_next from %c3_i5 : <i32> -> <i5>
      %213 = llhd.prb %reset_info_hw_req_qs : i5
      llhd.drv %212, %213 after %1 : i5
      cf.br ^bb58
    ^bb7:  // pred: ^bb5
      %214 = llhd.prb %addr_hit : i28
      %215 = comb.extract %214 from 3 : (i28) -> i1
      %216 = comb.icmp ceq %215, %true : i1
      cf.cond_br %216, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %217 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %218 = llhd.prb %alert_regwen_qs : i1
      llhd.drv %217, %218 after %1 : i1
      cf.br ^bb58
    ^bb9:  // pred: ^bb7
      %219 = llhd.prb %addr_hit : i28
      %220 = comb.extract %219 from 4 : (i28) -> i1
      %221 = comb.icmp ceq %220, %true : i1
      cf.cond_br %221, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %222 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %223 = llhd.prb %alert_info_ctrl_en_qs : i1
      llhd.drv %222, %223 after %1 : i1
      %224 = llhd.sig.extract %reg_rdata_next from %c4_i5 : <i32> -> <i4>
      %225 = llhd.prb %alert_info_ctrl_index_qs : i4
      llhd.drv %224, %225 after %1 : i4
      cf.br ^bb58
    ^bb11:  // pred: ^bb9
      %226 = llhd.prb %addr_hit : i28
      %227 = comb.extract %226 from 5 : (i28) -> i1
      %228 = comb.icmp ceq %227, %true : i1
      cf.cond_br %228, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %229 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i4>
      %230 = llhd.prb %alert_info_attr_qs : i4
      llhd.drv %229, %230 after %1 : i4
      cf.br ^bb58
    ^bb13:  // pred: ^bb11
      %231 = llhd.prb %addr_hit : i28
      %232 = comb.extract %231 from 6 : (i28) -> i1
      %233 = comb.icmp ceq %232, %true : i1
      cf.cond_br %233, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %234 = llhd.prb %alert_info_qs : i32
      llhd.drv %reg_rdata_next, %234 after %1 : i32
      cf.br ^bb58
    ^bb15:  // pred: ^bb13
      %235 = llhd.prb %addr_hit : i28
      %236 = comb.extract %235 from 7 : (i28) -> i1
      %237 = comb.icmp ceq %236, %true : i1
      cf.cond_br %237, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      %238 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %239 = llhd.prb %cpu_regwen_qs : i1
      llhd.drv %238, %239 after %1 : i1
      cf.br ^bb58
    ^bb17:  // pred: ^bb15
      %240 = llhd.prb %addr_hit : i28
      %241 = comb.extract %240 from 8 : (i28) -> i1
      %242 = comb.icmp ceq %241, %true : i1
      cf.cond_br %242, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      %243 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %244 = llhd.prb %cpu_info_ctrl_en_qs : i1
      llhd.drv %243, %244 after %1 : i1
      %245 = llhd.sig.extract %reg_rdata_next from %c4_i5 : <i32> -> <i4>
      %246 = llhd.prb %cpu_info_ctrl_index_qs : i4
      llhd.drv %245, %246 after %1 : i4
      cf.br ^bb58
    ^bb19:  // pred: ^bb17
      %247 = llhd.prb %addr_hit : i28
      %248 = comb.extract %247 from 9 : (i28) -> i1
      %249 = comb.icmp ceq %248, %true : i1
      cf.cond_br %249, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      %250 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i4>
      %251 = llhd.prb %cpu_info_attr_qs : i4
      llhd.drv %250, %251 after %1 : i4
      cf.br ^bb58
    ^bb21:  // pred: ^bb19
      %252 = llhd.prb %addr_hit : i28
      %253 = comb.extract %252 from 10 : (i28) -> i1
      %254 = comb.icmp ceq %253, %true : i1
      cf.cond_br %254, ^bb22, ^bb23
    ^bb22:  // pred: ^bb21
      %255 = llhd.prb %cpu_info_qs : i32
      llhd.drv %reg_rdata_next, %255 after %1 : i32
      cf.br ^bb58
    ^bb23:  // pred: ^bb21
      %256 = llhd.prb %addr_hit : i28
      %257 = comb.extract %256 from 11 : (i28) -> i1
      %258 = comb.icmp ceq %257, %true : i1
      cf.cond_br %258, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      %259 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %260 = llhd.prb %sw_rst_regwen_0_qs : i1
      llhd.drv %259, %260 after %1 : i1
      cf.br ^bb58
    ^bb25:  // pred: ^bb23
      %261 = llhd.prb %addr_hit : i28
      %262 = comb.extract %261 from 12 : (i28) -> i1
      %263 = comb.icmp ceq %262, %true : i1
      cf.cond_br %263, ^bb26, ^bb27
    ^bb26:  // pred: ^bb25
      %264 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %265 = llhd.prb %sw_rst_regwen_1_qs : i1
      llhd.drv %264, %265 after %1 : i1
      cf.br ^bb58
    ^bb27:  // pred: ^bb25
      %266 = llhd.prb %addr_hit : i28
      %267 = comb.extract %266 from 13 : (i28) -> i1
      %268 = comb.icmp ceq %267, %true : i1
      cf.cond_br %268, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      %269 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %270 = llhd.prb %sw_rst_regwen_2_qs : i1
      llhd.drv %269, %270 after %1 : i1
      cf.br ^bb58
    ^bb29:  // pred: ^bb27
      %271 = llhd.prb %addr_hit : i28
      %272 = comb.extract %271 from 14 : (i28) -> i1
      %273 = comb.icmp ceq %272, %true : i1
      cf.cond_br %273, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      %274 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %275 = llhd.prb %sw_rst_regwen_3_qs : i1
      llhd.drv %274, %275 after %1 : i1
      cf.br ^bb58
    ^bb31:  // pred: ^bb29
      %276 = llhd.prb %addr_hit : i28
      %277 = comb.extract %276 from 15 : (i28) -> i1
      %278 = comb.icmp ceq %277, %true : i1
      cf.cond_br %278, ^bb32, ^bb33
    ^bb32:  // pred: ^bb31
      %279 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %280 = llhd.prb %sw_rst_regwen_4_qs : i1
      llhd.drv %279, %280 after %1 : i1
      cf.br ^bb58
    ^bb33:  // pred: ^bb31
      %281 = llhd.prb %addr_hit : i28
      %282 = comb.extract %281 from 16 : (i28) -> i1
      %283 = comb.icmp ceq %282, %true : i1
      cf.cond_br %283, ^bb34, ^bb35
    ^bb34:  // pred: ^bb33
      %284 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %285 = llhd.prb %sw_rst_regwen_5_qs : i1
      llhd.drv %284, %285 after %1 : i1
      cf.br ^bb58
    ^bb35:  // pred: ^bb33
      %286 = llhd.prb %addr_hit : i28
      %287 = comb.extract %286 from 17 : (i28) -> i1
      %288 = comb.icmp ceq %287, %true : i1
      cf.cond_br %288, ^bb36, ^bb37
    ^bb36:  // pred: ^bb35
      %289 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %290 = llhd.prb %sw_rst_regwen_6_qs : i1
      llhd.drv %289, %290 after %1 : i1
      cf.br ^bb58
    ^bb37:  // pred: ^bb35
      %291 = llhd.prb %addr_hit : i28
      %292 = comb.extract %291 from 18 : (i28) -> i1
      %293 = comb.icmp ceq %292, %true : i1
      cf.cond_br %293, ^bb38, ^bb39
    ^bb38:  // pred: ^bb37
      %294 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %295 = llhd.prb %sw_rst_regwen_7_qs : i1
      llhd.drv %294, %295 after %1 : i1
      cf.br ^bb58
    ^bb39:  // pred: ^bb37
      %296 = llhd.prb %addr_hit : i28
      %297 = comb.extract %296 from 19 : (i28) -> i1
      %298 = comb.icmp ceq %297, %true : i1
      cf.cond_br %298, ^bb40, ^bb41
    ^bb40:  // pred: ^bb39
      %299 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %300 = llhd.prb %sw_rst_ctrl_n_0_qs : i1
      llhd.drv %299, %300 after %1 : i1
      cf.br ^bb58
    ^bb41:  // pred: ^bb39
      %301 = llhd.prb %addr_hit : i28
      %302 = comb.extract %301 from 20 : (i28) -> i1
      %303 = comb.icmp ceq %302, %true : i1
      cf.cond_br %303, ^bb42, ^bb43
    ^bb42:  // pred: ^bb41
      %304 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %305 = llhd.prb %sw_rst_ctrl_n_1_qs : i1
      llhd.drv %304, %305 after %1 : i1
      cf.br ^bb58
    ^bb43:  // pred: ^bb41
      %306 = llhd.prb %addr_hit : i28
      %307 = comb.extract %306 from 21 : (i28) -> i1
      %308 = comb.icmp ceq %307, %true : i1
      cf.cond_br %308, ^bb44, ^bb45
    ^bb44:  // pred: ^bb43
      %309 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %310 = llhd.prb %sw_rst_ctrl_n_2_qs : i1
      llhd.drv %309, %310 after %1 : i1
      cf.br ^bb58
    ^bb45:  // pred: ^bb43
      %311 = llhd.prb %addr_hit : i28
      %312 = comb.extract %311 from 22 : (i28) -> i1
      %313 = comb.icmp ceq %312, %true : i1
      cf.cond_br %313, ^bb46, ^bb47
    ^bb46:  // pred: ^bb45
      %314 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %315 = llhd.prb %sw_rst_ctrl_n_3_qs : i1
      llhd.drv %314, %315 after %1 : i1
      cf.br ^bb58
    ^bb47:  // pred: ^bb45
      %316 = llhd.prb %addr_hit : i28
      %317 = comb.extract %316 from 23 : (i28) -> i1
      %318 = comb.icmp ceq %317, %true : i1
      cf.cond_br %318, ^bb48, ^bb49
    ^bb48:  // pred: ^bb47
      %319 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %320 = llhd.prb %sw_rst_ctrl_n_4_qs : i1
      llhd.drv %319, %320 after %1 : i1
      cf.br ^bb58
    ^bb49:  // pred: ^bb47
      %321 = llhd.prb %addr_hit : i28
      %322 = comb.extract %321 from 24 : (i28) -> i1
      %323 = comb.icmp ceq %322, %true : i1
      cf.cond_br %323, ^bb50, ^bb51
    ^bb50:  // pred: ^bb49
      %324 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %325 = llhd.prb %sw_rst_ctrl_n_5_qs : i1
      llhd.drv %324, %325 after %1 : i1
      cf.br ^bb58
    ^bb51:  // pred: ^bb49
      %326 = llhd.prb %addr_hit : i28
      %327 = comb.extract %326 from 25 : (i28) -> i1
      %328 = comb.icmp ceq %327, %true : i1
      cf.cond_br %328, ^bb52, ^bb53
    ^bb52:  // pred: ^bb51
      %329 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %330 = llhd.prb %sw_rst_ctrl_n_6_qs : i1
      llhd.drv %329, %330 after %1 : i1
      cf.br ^bb58
    ^bb53:  // pred: ^bb51
      %331 = llhd.prb %addr_hit : i28
      %332 = comb.extract %331 from 26 : (i28) -> i1
      %333 = comb.icmp ceq %332, %true : i1
      cf.cond_br %333, ^bb54, ^bb55
    ^bb54:  // pred: ^bb53
      %334 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %335 = llhd.prb %sw_rst_ctrl_n_7_qs : i1
      llhd.drv %334, %335 after %1 : i1
      cf.br ^bb58
    ^bb55:  // pred: ^bb53
      %336 = llhd.prb %addr_hit : i28
      %337 = comb.extract %336 from 27 : (i28) -> i1
      %338 = comb.icmp ceq %337, %true : i1
      cf.cond_br %338, ^bb56, ^bb57
    ^bb56:  // pred: ^bb55
      %339 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %340 = llhd.prb %err_code_reg_intg_err_qs : i1
      llhd.drv %339, %340 after %1 : i1
      %341 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %342 = llhd.prb %err_code_reset_consistency_err_qs : i1
      llhd.drv %341, %342 after %1 : i1
      %343 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %344 = llhd.prb %err_code_fsm_err_qs : i1
      llhd.drv %343, %344 after %1 : i1
      cf.br ^bb58
    ^bb57:  // pred: ^bb55
      llhd.drv %reg_rdata_next, %c-1_i32 after %1 : i32
      cf.br ^bb58
    ^bb58:  // 29 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb18, ^bb20, ^bb22, ^bb24, ^bb26, ^bb28, ^bb30, ^bb32, ^bb34, ^bb36, ^bb38, ^bb40, ^bb42, ^bb44, ^bb46, ^bb48, ^bb50, ^bb52, ^bb54, ^bb56, ^bb57
      llhd.wait (%84, %111, %168, %169, %170, %171, %172, %91, %173, %174, %175, %176, %93, %177, %178, %179, %180, %95, %97, %99, %101, %103, %105, %107, %109, %181, %182, %183, %184, %185, %186, %187, %188, %189, %190, %191 : i32, i28, i4, i1, i1, i1, i5, i1, i1, i4, i4, i32, i1, i1, i4, i4, i32, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    %192 = llhd.prb %reg2hw : !hw.struct<alert_test: !hw.struct<fatal_cnsty_fault: !hw.struct<q: i1, qe: i1>, fatal_fault: !hw.struct<q: i1, qe: i1>>, reset_req: !hw.struct<q: i4>, reset_info: !hw.struct<hw_req: !hw.struct<q: i5>, sw_reset: !hw.struct<q: i1>>, alert_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, cpu_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, sw_rst_ctrl_n: !hw.array<8xstruct<q: i1>>, err_code: !hw.struct<fsm_err: !hw.struct<q: i1>, reset_consistency_err: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    hw.output %u_rsp_intg_gen.tl_o, %192, %83 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<alert_test: !hw.struct<fatal_cnsty_fault: !hw.struct<q: i1, qe: i1>, fatal_fault: !hw.struct<q: i1, qe: i1>>, reset_req: !hw.struct<q: i4>, reset_info: !hw.struct<hw_req: !hw.struct<q: i5>, sw_reset: !hw.struct<q: i1>>, alert_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, cpu_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, sw_rst_ctrl_n: !hw.array<8xstruct<q: i1>>, err_code: !hw.struct<fsm_err: !hw.struct<q: i1>, reset_consistency_err: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>, i1
  }
  hw.module @rstmgr(in %clk_i : i1, in %rst_ni : i1, in %clk_aon_i : i1, in %clk_io_div4_i : i1, in %clk_main_i : i1, in %clk_io_i : i1, in %clk_io_div2_i : i1, in %clk_usb_i : i1, in %clk_por_i : i1, in %rst_por_ni : i1, in %por_n_i : i2, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %alert_rx_i : !hw.array<2xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, out alert_tx_o : !hw.array<2xstruct<alert_p: i1, alert_n: i1>>, in %pwr_i : !hw.struct<rst_lc_req: i2, rst_sys_req: i2, rstreqs: i5, reset_cause: i2>, out pwr_o : !hw.struct<rst_lc_src_n: i2, rst_sys_src_n: i2>, out sw_rst_req_o : i4, in %alert_dump_i : !hw.struct<alert_cause: i65, loc_alert_cause: i7, class_accum_cnt: !hw.array<4xi16>, class_esc_cnt: !hw.array<4xi32>, class_esc_state: !hw.array<4xi3>>, in %cpu_dump_i : !hw.struct<prev_valid: i1, prev_exception_pc: i32, prev_exception_addr: i32, current: !hw.struct<current_pc: i32, next_pc: i32, last_data_addr: i32, exception_pc: i32, exception_addr: i32>>, in %scan_rst_ni : i1, in %scanmode_i : i4, out rst_en_o : !hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>, out resets_o : !hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>) {
    %c0_i42 = hw.constant 0 : i42
    %c-12_i5 = hw.constant -12 : i5
    %c-1_i3 = hw.constant -1 : i3
    %c-13_i5 = hw.constant -13 : i5
    %c-2_i3 = hw.constant -2 : i3
    %c-14_i5 = hw.constant -14 : i5
    %c-3_i3 = hw.constant -3 : i3
    %c-15_i5 = hw.constant -15 : i5
    %c-4_i3 = hw.constant -4 : i3
    %c-16_i5 = hw.constant -16 : i5
    %c3_i3 = hw.constant 3 : i3
    %c15_i5 = hw.constant 15 : i5
    %c2_i3 = hw.constant 2 : i3
    %c14_i5 = hw.constant 14 : i5
    %c1_i3 = hw.constant 1 : i3
    %c13_i5 = hw.constant 13 : i5
    %c0_i3 = hw.constant 0 : i3
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
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i0 = hw.constant 0 : i0
    %1 = hw.aggregate_constant [0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2] : !hw.array<21xi2>
    %2 = hw.aggregate_constant [[0 : i4, false], [[0 : i5, false], [false, false], [false, false]], [[false, false]], [0 : i4], [0 : i32], [[false, false]], [0 : i4], [0 : i32], [[false, false], [false, false], [false, false]]] : !hw.struct<reset_req: !hw.struct<d: i4, de: i1>, reset_info: !hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>, alert_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, alert_info_attr: !hw.struct<d: i4>, alert_info: !hw.struct<d: i32>, cpu_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, cpu_info_attr: !hw.struct<d: i4>, cpu_info: !hw.struct<d: i32>, err_code: !hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %3 = hw.aggregate_constant [0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2, 0 : i2] : !hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>
    %4 = hw.aggregate_constant [[0 : i4, 0 : i4], [0 : i4, 0 : i4], [0 : i4, 0 : i4], [0 : i4, 0 : i4], [0 : i4, 0 : i4], [0 : i4, 0 : i4], [0 : i4, 0 : i4], [0 : i4, 0 : i4], [0 : i4, 0 : i4], [0 : i4, 0 : i4], [0 : i4, 0 : i4], [0 : i4, 0 : i4], [0 : i4, 0 : i4], [0 : i4, 0 : i4], [0 : i4, 0 : i4], [0 : i4, 0 : i4], [0 : i4, 0 : i4], [0 : i4, 0 : i4], [0 : i4, 0 : i4], [0 : i4, 0 : i4], [0 : i4, 0 : i4], [0 : i4, 0 : i4], [0 : i4, 0 : i4], [0 : i4, 0 : i4]] : !hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>
    %5 = hw.aggregate_constant [0 : i2, 0 : i2] : !hw.struct<rst_lc_src_n: i2, rst_sys_src_n: i2>
    %c1_i2 = hw.constant 1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c0_i2 = hw.constant 0 : i2
    %c6_i4 = hw.constant 6 : i4
    %false = hw.constant false
    %true = hw.constant true
    %c-7_i4 = hw.constant -7 : i4
    %6 = hw.aggregate_constant [[false, false], [false, false]] : !hw.array<2xstruct<alert_p: i1, alert_n: i1>>
    %alert_tx_o = llhd.sig %6 : !hw.array<2xstruct<alert_p: i1, alert_n: i1>>
    %pwr_o = llhd.sig %5 : !hw.struct<rst_lc_src_n: i2, rst_sys_src_n: i2>
    %rst_en_o = llhd.sig %4 : !hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>
    %resets_o = llhd.sig %3 : !hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>
    %rst_por_aon_n = llhd.sig %c0_i2 : i2
    %hw2reg = llhd.sig %2 : !hw.struct<reset_req: !hw.struct<d: i4, de: i1>, reset_info: !hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>, alert_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, alert_info_attr: !hw.struct<d: i4>, alert_info: !hw.struct<d: i32>, cpu_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, cpu_info_attr: !hw.struct<d: i4>, cpu_info: !hw.struct<d: i32>, err_code: !hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %cnsty_chk_errs = llhd.sig %1 : !hw.array<21xi2>
    %shadow_cnsty_chk_errs = llhd.sig %1 : !hw.array<21xi2>
    %fsm_errs = llhd.sig %1 : !hw.array<21xi2>
    %shadow_fsm_errs = llhd.sig %1 : !hw.array<21xi2>
    %alerts = llhd.sig %c0_i2 : i2
    %gen_rst_por_aon_0.u_por_scanmode_sync.mubi_o = hw.instance "gen_rst_por_aon_0.u_por_scanmode_sync" @prim_mubi4_sync(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, mubi_i: %scanmode_i: i4) -> (mubi_o: !hw.array<1xi4>) {sv.namehint = "gen_rst_por_aon_0.por_scanmode"}
    %7 = comb.extract %por_n_i from 0 : (i2) -> i1
    %8 = hw.array_get %gen_rst_por_aon_0.u_por_scanmode_sync.mubi_o[%c0_i0] : !hw.array<1xi4>, i0
    %9 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%8) : (i4) -> i1
    %10 = llhd.sig.extract %rst_por_aon_n from %false : <i2> -> <i1>
    %gen_rst_por_aon_0.gen_rst_por_aon_normal.u_rst_por_aon.rst_no = hw.instance "gen_rst_por_aon_0.gen_rst_por_aon_normal.u_rst_por_aon" @rstmgr_por(clk_i: %clk_aon_i: i1, rst_ni: %7: i1, scan_rst_ni: %scan_rst_ni: i1, scanmode_i: %9: i1) -> (rst_no: i1)
    llhd.drv %10, %gen_rst_por_aon_0.gen_rst_por_aon_normal.u_rst_por_aon.rst_no after %0 : i1
    %11 = llhd.prb %rst_por_aon_n : i2
    %12 = comb.extract %11 from 0 : (i2) -> i1
    %13 = llhd.sig.struct_extract %rst_en_o["por_aon"] : <!hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>>
    %14 = llhd.sig.array_get %13[%false] : <!hw.array<2xi4>>
    %gen_rst_por_aon_0.gen_rst_por_aon_normal.u_prim_mubi4_sender.mubi_o = hw.instance "gen_rst_por_aon_0.gen_rst_por_aon_normal.u_prim_mubi4_sender" @prim_mubi4_sender(clk_i: %clk_aon_i: i1, rst_ni: %12: i1, mubi_i: %c-7_i4: i4) -> (mubi_o: i4)
    llhd.drv %14, %gen_rst_por_aon_0.gen_rst_por_aon_normal.u_prim_mubi4_sender.mubi_o after %0 : i4
    %gen_rst_por_aon_1.u_por_scanmode_sync.mubi_o = hw.instance "gen_rst_por_aon_1.u_por_scanmode_sync" @prim_mubi4_sync(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, mubi_i: %scanmode_i: i4) -> (mubi_o: !hw.array<1xi4>) {sv.namehint = "gen_rst_por_aon_1.por_scanmode"}
    %15 = comb.extract %por_n_i from 1 : (i2) -> i1
    %16 = comb.and %12, %15 : i1
    %gen_rst_por_aon_1.gen_rst_por_domain.u_por_domain_sync.q_o = hw.instance "gen_rst_por_aon_1.gen_rst_por_domain.u_por_domain_sync" @prim_flop_2sync(clk_i: %clk_aon_i: i1, rst_ni: %16: i1, d_i: %true: i1) -> (q_o: i1) {sv.namehint = "gen_rst_por_aon_1.gen_rst_por_domain.rst_por_aon_premux"}
    %17 = hw.array_get %gen_rst_por_aon_1.u_por_scanmode_sync.mubi_o[%c0_i0] : !hw.array<1xi4>, i0
    %18 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%17) : (i4) -> i1
    %19 = llhd.sig.extract %rst_por_aon_n from %true : <i2> -> <i1>
    %gen_rst_por_aon_1.gen_rst_por_domain.u_por_domain_mux.clk_o = hw.instance "gen_rst_por_aon_1.gen_rst_por_domain.u_por_domain_mux" @prim_clock_mux2(clk0_i: %gen_rst_por_aon_1.gen_rst_por_domain.u_por_domain_sync.q_o: i1, clk1_i: %scan_rst_ni: i1, sel_i: %18: i1) -> (clk_o: i1)
    llhd.drv %19, %gen_rst_por_aon_1.gen_rst_por_domain.u_por_domain_mux.clk_o after %0 : i1
    %20 = comb.extract %11 from 1 : (i2) -> i1
    %21 = llhd.sig.array_get %13[%true] : <!hw.array<2xi4>>
    %gen_rst_por_aon_1.gen_rst_por_domain.u_prim_mubi4_sender.mubi_o = hw.instance "gen_rst_por_aon_1.gen_rst_por_domain.u_prim_mubi4_sender" @prim_mubi4_sender(clk_i: %clk_aon_i: i1, rst_ni: %20: i1, mubi_i: %c-7_i4: i4) -> (mubi_o: i4)
    llhd.drv %21, %gen_rst_por_aon_1.gen_rst_por_domain.u_prim_mubi4_sender.mubi_o after %0 : i4
    %u_por_clk_buf.clk_o = hw.instance "u_por_clk_buf" @prim_clock_buf(clk_i: %clk_por_i: i1) -> (clk_o: i1) {sv.namehint = "clk_por"}
    %u_por_rst_buf.clk_o = hw.instance "u_por_rst_buf" @prim_clock_buf(clk_i: %rst_por_ni: i1) -> (clk_o: i1) {sv.namehint = "rst_por_n"}
    %22 = llhd.prb %hw2reg : !hw.struct<reset_req: !hw.struct<d: i4, de: i1>, reset_info: !hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>, alert_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, alert_info_attr: !hw.struct<d: i4>, alert_info: !hw.struct<d: i32>, cpu_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, cpu_info_attr: !hw.struct<d: i4>, cpu_info: !hw.struct<d: i32>, err_code: !hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %u_reg.tl_o, %u_reg.reg2hw, %u_reg.intg_err_o = hw.instance "u_reg" @rstmgr_reg_top(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clk_por_i: %u_por_clk_buf.clk_o: i1, rst_por_ni: %u_por_rst_buf.clk_o: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, hw2reg: %22: !hw.struct<reset_req: !hw.struct<d: i4, de: i1>, reset_info: !hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>, alert_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, alert_info_attr: !hw.struct<d: i4>, alert_info: !hw.struct<d: i32>, cpu_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, cpu_info_attr: !hw.struct<d: i4>, cpu_info: !hw.struct<d: i32>, err_code: !hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, reg2hw: !hw.struct<alert_test: !hw.struct<fatal_cnsty_fault: !hw.struct<q: i1, qe: i1>, fatal_fault: !hw.struct<q: i1, qe: i1>>, reset_req: !hw.struct<q: i4>, reset_info: !hw.struct<hw_req: !hw.struct<q: i5>, sw_reset: !hw.struct<q: i1>>, alert_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, cpu_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, sw_rst_ctrl_n: !hw.array<8xstruct<q: i1>>, err_code: !hw.struct<fsm_err: !hw.struct<q: i1>, reset_consistency_err: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>, intg_err_o: i1) {sv.namehint = "reg2hw"}
    %23 = llhd.prb %alerts : i2
    %24 = comb.extract %23 from 0 : (i2) -> i1
    %25 = hw.array_get %alert_rx_i[%false] : !hw.array<2xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, i1
    %26 = llhd.sig.array_get %alert_tx_o[%false] : <!hw.array<2xstruct<alert_p: i1, alert_n: i1>>>
    %gen_alert_tx_0.u_prim_alert_sender.alert_ack_o, %gen_alert_tx_0.u_prim_alert_sender.alert_state_o, %gen_alert_tx_0.u_prim_alert_sender.alert_tx_o = hw.instance "gen_alert_tx_0.u_prim_alert_sender" @prim_alert_sender(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, alert_test_i: %298: i1, alert_req_i: %24: i1, alert_rx_i: %25: !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>) -> (alert_ack_o: i1, alert_state_o: i1, alert_tx_o: !hw.struct<alert_p: i1, alert_n: i1>)
    llhd.drv %26, %gen_alert_tx_0.u_prim_alert_sender.alert_tx_o after %0 : !hw.struct<alert_p: i1, alert_n: i1>
    %27 = comb.extract %23 from 1 : (i2) -> i1
    %28 = hw.array_get %alert_rx_i[%true] : !hw.array<2xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, i1
    %29 = llhd.sig.array_get %alert_tx_o[%true] : <!hw.array<2xstruct<alert_p: i1, alert_n: i1>>>
    %gen_alert_tx_1.u_prim_alert_sender.alert_ack_o, %gen_alert_tx_1.u_prim_alert_sender.alert_state_o, %gen_alert_tx_1.u_prim_alert_sender.alert_tx_o = hw.instance "gen_alert_tx_1.u_prim_alert_sender" @prim_alert_sender(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, alert_test_i: %297: i1, alert_req_i: %27: i1, alert_rx_i: %28: !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>) -> (alert_ack_o: i1, alert_state_o: i1, alert_tx_o: !hw.struct<alert_p: i1, alert_n: i1>)
    llhd.drv %29, %gen_alert_tx_1.u_prim_alert_sender.alert_tx_o after %0 : !hw.struct<alert_p: i1, alert_n: i1>
    %u_ctrl_scanmode_sync.mubi_o = hw.instance "u_ctrl_scanmode_sync" @prim_mubi4_sync(clk_i: %u_por_clk_buf.clk_o: i1, rst_ni: %u_por_rst_buf.clk_o: i1, mubi_i: %scanmode_i: i4) -> (mubi_o: !hw.array<1xi4>) {sv.namehint = "rst_ctrl_scanmode"}
    %rst_lc_req = hw.struct_extract %pwr_i["rst_lc_req"] : !hw.struct<rst_lc_req: i2, rst_sys_req: i2, rstreqs: i5, reset_cause: i2>
    %30 = hw.array_get %u_ctrl_scanmode_sync.mubi_o[%c0_i0] : !hw.array<1xi4>, i0
    %31 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%30) : (i4) -> i1
    %u_lc_src.rst_no = hw.instance "u_lc_src" @rstmgr_ctrl(clk_i: %u_por_clk_buf.clk_o: i1, rst_req_i: %rst_lc_req: i2, rst_parent_ni: %11: i2, scanmode_i: %31: i1, scan_rst_ni: %scan_rst_ni: i1) -> (rst_no: i2) {sv.namehint = "rst_lc_src_n"}
    %rst_sys_req = hw.struct_extract %pwr_i["rst_sys_req"] : !hw.struct<rst_lc_req: i2, rst_sys_req: i2, rstreqs: i5, reset_cause: i2>
    %32 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%30) : (i4) -> i1
    %u_sys_src.rst_no = hw.instance "u_sys_src" @rstmgr_ctrl(clk_i: %u_por_clk_buf.clk_o: i1, rst_req_i: %rst_sys_req: i2, rst_parent_ni: %11: i2, scanmode_i: %32: i1, scan_rst_ni: %scan_rst_ni: i1) -> (rst_no: i2) {sv.namehint = "rst_sys_src_n"}
    %33 = llhd.sig.struct_extract %rst_en_o["por"] : <!hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>>
    %34 = llhd.sig.array_get %33[%false] : <!hw.array<2xi4>>
    %35 = llhd.sig.struct_extract %resets_o["rst_por_n"] : <!hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>>
    %36 = llhd.sig.extract %35 from %false : <i2> -> <i1>
    %37 = llhd.sig.array_get %cnsty_chk_errs[%c0_i5] : <!hw.array<21xi2>>
    %38 = llhd.sig.extract %37 from %false : <i2> -> <i1>
    %39 = llhd.sig.array_get %fsm_errs[%c0_i5] : <!hw.array<21xi2>>
    %40 = llhd.sig.extract %39 from %false : <i2> -> <i1>
    %u_daon_por.rst_en_o, %u_daon_por.leaf_rst_o, %u_daon_por.err_o, %u_daon_por.fsm_err_o = hw.instance "u_daon_por" @rstmgr_leaf_rst(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_main_i: i1, parent_rst_ni: %12: i1, sw_rst_req_ni: %true: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %34, %u_daon_por.rst_en_o after %0 : i4
    llhd.drv %36, %u_daon_por.leaf_rst_o after %0 : i1
    llhd.drv %38, %u_daon_por.err_o after %0 : i1
    llhd.drv %40, %u_daon_por.fsm_err_o after %0 : i1
    %41 = llhd.sig.struct_extract %rst_en_o["por_io"] : <!hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>>
    %42 = llhd.sig.array_get %41[%false] : <!hw.array<2xi4>>
    %43 = llhd.sig.struct_extract %resets_o["rst_por_io_n"] : <!hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>>
    %44 = llhd.sig.extract %43 from %false : <i2> -> <i1>
    %45 = llhd.sig.array_get %cnsty_chk_errs[%c1_i5] : <!hw.array<21xi2>>
    %46 = llhd.sig.extract %45 from %false : <i2> -> <i1>
    %47 = llhd.sig.array_get %fsm_errs[%c1_i5] : <!hw.array<21xi2>>
    %48 = llhd.sig.extract %47 from %false : <i2> -> <i1>
    %u_daon_por_io.rst_en_o, %u_daon_por_io.leaf_rst_o, %u_daon_por_io.err_o, %u_daon_por_io.fsm_err_o = hw.instance "u_daon_por_io" @rstmgr_leaf_rst(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_io_i: i1, parent_rst_ni: %12: i1, sw_rst_req_ni: %true: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %42, %u_daon_por_io.rst_en_o after %0 : i4
    llhd.drv %44, %u_daon_por_io.leaf_rst_o after %0 : i1
    llhd.drv %46, %u_daon_por_io.err_o after %0 : i1
    llhd.drv %48, %u_daon_por_io.fsm_err_o after %0 : i1
    %49 = llhd.sig.struct_extract %rst_en_o["por_io_div2"] : <!hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>>
    %50 = llhd.sig.array_get %49[%false] : <!hw.array<2xi4>>
    %51 = llhd.sig.struct_extract %resets_o["rst_por_io_div2_n"] : <!hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>>
    %52 = llhd.sig.extract %51 from %false : <i2> -> <i1>
    %53 = llhd.sig.array_get %cnsty_chk_errs[%c2_i5] : <!hw.array<21xi2>>
    %54 = llhd.sig.extract %53 from %false : <i2> -> <i1>
    %55 = llhd.sig.array_get %fsm_errs[%c2_i5] : <!hw.array<21xi2>>
    %56 = llhd.sig.extract %55 from %false : <i2> -> <i1>
    %u_daon_por_io_div2.rst_en_o, %u_daon_por_io_div2.leaf_rst_o, %u_daon_por_io_div2.err_o, %u_daon_por_io_div2.fsm_err_o = hw.instance "u_daon_por_io_div2" @rstmgr_leaf_rst(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_io_div2_i: i1, parent_rst_ni: %12: i1, sw_rst_req_ni: %true: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %50, %u_daon_por_io_div2.rst_en_o after %0 : i4
    llhd.drv %52, %u_daon_por_io_div2.leaf_rst_o after %0 : i1
    llhd.drv %54, %u_daon_por_io_div2.err_o after %0 : i1
    llhd.drv %56, %u_daon_por_io_div2.fsm_err_o after %0 : i1
    %57 = llhd.sig.struct_extract %rst_en_o["por_io_div4"] : <!hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>>
    %58 = llhd.sig.array_get %57[%false] : <!hw.array<2xi4>>
    %59 = llhd.sig.struct_extract %resets_o["rst_por_io_div4_n"] : <!hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>>
    %60 = llhd.sig.extract %59 from %false : <i2> -> <i1>
    %61 = llhd.sig.array_get %cnsty_chk_errs[%c3_i5] : <!hw.array<21xi2>>
    %62 = llhd.sig.extract %61 from %false : <i2> -> <i1>
    %63 = llhd.sig.array_get %fsm_errs[%c3_i5] : <!hw.array<21xi2>>
    %64 = llhd.sig.extract %63 from %false : <i2> -> <i1>
    %u_daon_por_io_div4.rst_en_o, %u_daon_por_io_div4.leaf_rst_o, %u_daon_por_io_div4.err_o, %u_daon_por_io_div4.fsm_err_o = hw.instance "u_daon_por_io_div4" @rstmgr_leaf_rst(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_io_div4_i: i1, parent_rst_ni: %12: i1, sw_rst_req_ni: %true: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %58, %u_daon_por_io_div4.rst_en_o after %0 : i4
    llhd.drv %60, %u_daon_por_io_div4.leaf_rst_o after %0 : i1
    llhd.drv %62, %u_daon_por_io_div4.err_o after %0 : i1
    llhd.drv %64, %u_daon_por_io_div4.fsm_err_o after %0 : i1
    %65 = llhd.sig.struct_extract %rst_en_o["por_usb"] : <!hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>>
    %66 = llhd.sig.array_get %65[%false] : <!hw.array<2xi4>>
    %67 = llhd.sig.struct_extract %resets_o["rst_por_usb_n"] : <!hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>>
    %68 = llhd.sig.extract %67 from %false : <i2> -> <i1>
    %69 = llhd.sig.array_get %cnsty_chk_errs[%c4_i5] : <!hw.array<21xi2>>
    %70 = llhd.sig.extract %69 from %false : <i2> -> <i1>
    %71 = llhd.sig.array_get %fsm_errs[%c4_i5] : <!hw.array<21xi2>>
    %72 = llhd.sig.extract %71 from %false : <i2> -> <i1>
    %u_daon_por_usb.rst_en_o, %u_daon_por_usb.leaf_rst_o, %u_daon_por_usb.err_o, %u_daon_por_usb.fsm_err_o = hw.instance "u_daon_por_usb" @rstmgr_leaf_rst(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_usb_i: i1, parent_rst_ni: %12: i1, sw_rst_req_ni: %true: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %66, %u_daon_por_usb.rst_en_o after %0 : i4
    llhd.drv %68, %u_daon_por_usb.leaf_rst_o after %0 : i1
    llhd.drv %70, %u_daon_por_usb.err_o after %0 : i1
    llhd.drv %72, %u_daon_por_usb.fsm_err_o after %0 : i1
    %73 = comb.extract %u_lc_src.rst_no from 0 : (i2) -> i1
    %74 = llhd.sig.struct_extract %rst_en_o["lc"] : <!hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>>
    %75 = llhd.sig.array_get %74[%false] : <!hw.array<2xi4>>
    %76 = llhd.sig.struct_extract %resets_o["rst_lc_n"] : <!hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>>
    %77 = llhd.sig.extract %76 from %false : <i2> -> <i1>
    %78 = llhd.sig.array_get %cnsty_chk_errs[%c5_i5] : <!hw.array<21xi2>>
    %79 = llhd.sig.extract %78 from %false : <i2> -> <i1>
    %80 = llhd.sig.array_get %fsm_errs[%c5_i5] : <!hw.array<21xi2>>
    %81 = llhd.sig.extract %80 from %false : <i2> -> <i1>
    %u_daon_lc.rst_en_o, %u_daon_lc.leaf_rst_o, %u_daon_lc.err_o, %u_daon_lc.fsm_err_o = hw.instance "u_daon_lc" @rstmgr_leaf_rst(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_main_i: i1, parent_rst_ni: %73: i1, sw_rst_req_ni: %true: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %75, %u_daon_lc.rst_en_o after %0 : i4
    llhd.drv %77, %u_daon_lc.leaf_rst_o after %0 : i1
    llhd.drv %79, %u_daon_lc.err_o after %0 : i1
    llhd.drv %81, %u_daon_lc.fsm_err_o after %0 : i1
    %82 = comb.extract %u_lc_src.rst_no from 1 : (i2) -> i1
    %83 = llhd.sig.array_get %74[%true] : <!hw.array<2xi4>>
    %84 = llhd.sig.extract %76 from %true : <i2> -> <i1>
    %85 = llhd.sig.extract %78 from %true : <i2> -> <i1>
    %86 = llhd.sig.extract %80 from %true : <i2> -> <i1>
    %u_d0_lc.rst_en_o, %u_d0_lc.leaf_rst_o, %u_d0_lc.err_o, %u_d0_lc.fsm_err_o = hw.instance "u_d0_lc" @rstmgr_leaf_rst(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_main_i: i1, parent_rst_ni: %82: i1, sw_rst_req_ni: %true: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %83, %u_d0_lc.rst_en_o after %0 : i4
    llhd.drv %84, %u_d0_lc.leaf_rst_o after %0 : i1
    llhd.drv %85, %u_d0_lc.err_o after %0 : i1
    llhd.drv %86, %u_d0_lc.fsm_err_o after %0 : i1
    %87 = llhd.sig.struct_extract %rst_en_o["lc_shadowed"] : <!hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>>
    %88 = llhd.sig.array_get %87[%false] : <!hw.array<2xi4>>
    %89 = llhd.sig.struct_extract %resets_o["rst_lc_shadowed_n"] : <!hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>>
    %90 = llhd.sig.extract %89 from %false : <i2> -> <i1>
    %91 = llhd.sig.array_get %shadow_cnsty_chk_errs[%c5_i5] : <!hw.array<21xi2>>
    %92 = llhd.sig.extract %91 from %false : <i2> -> <i1>
    %93 = llhd.sig.array_get %shadow_fsm_errs[%c5_i5] : <!hw.array<21xi2>>
    %94 = llhd.sig.extract %93 from %false : <i2> -> <i1>
    %u_daon_lc_shadowed.rst_en_o, %u_daon_lc_shadowed.leaf_rst_o, %u_daon_lc_shadowed.err_o, %u_daon_lc_shadowed.fsm_err_o = hw.instance "u_daon_lc_shadowed" @rstmgr_leaf_rst(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_main_i: i1, parent_rst_ni: %73: i1, sw_rst_req_ni: %true: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %88, %u_daon_lc_shadowed.rst_en_o after %0 : i4
    llhd.drv %90, %u_daon_lc_shadowed.leaf_rst_o after %0 : i1
    llhd.drv %92, %u_daon_lc_shadowed.err_o after %0 : i1
    llhd.drv %94, %u_daon_lc_shadowed.fsm_err_o after %0 : i1
    %95 = llhd.sig.array_get %87[%true] : <!hw.array<2xi4>>
    %96 = llhd.sig.extract %89 from %true : <i2> -> <i1>
    %97 = llhd.sig.extract %91 from %true : <i2> -> <i1>
    %98 = llhd.sig.extract %93 from %true : <i2> -> <i1>
    %u_d0_lc_shadowed.rst_en_o, %u_d0_lc_shadowed.leaf_rst_o, %u_d0_lc_shadowed.err_o, %u_d0_lc_shadowed.fsm_err_o = hw.instance "u_d0_lc_shadowed" @rstmgr_leaf_rst(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_main_i: i1, parent_rst_ni: %82: i1, sw_rst_req_ni: %true: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %95, %u_d0_lc_shadowed.rst_en_o after %0 : i4
    llhd.drv %96, %u_d0_lc_shadowed.leaf_rst_o after %0 : i1
    llhd.drv %97, %u_d0_lc_shadowed.err_o after %0 : i1
    llhd.drv %98, %u_d0_lc_shadowed.fsm_err_o after %0 : i1
    %99 = llhd.sig.struct_extract %rst_en_o["lc_aon"] : <!hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>>
    %100 = llhd.sig.array_get %99[%false] : <!hw.array<2xi4>>
    %101 = llhd.sig.struct_extract %resets_o["rst_lc_aon_n"] : <!hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>>
    %102 = llhd.sig.extract %101 from %false : <i2> -> <i1>
    %103 = llhd.sig.array_get %cnsty_chk_errs[%c6_i5] : <!hw.array<21xi2>>
    %104 = llhd.sig.extract %103 from %false : <i2> -> <i1>
    %105 = llhd.sig.array_get %fsm_errs[%c6_i5] : <!hw.array<21xi2>>
    %106 = llhd.sig.extract %105 from %false : <i2> -> <i1>
    %u_daon_lc_aon.rst_en_o, %u_daon_lc_aon.leaf_rst_o, %u_daon_lc_aon.err_o, %u_daon_lc_aon.fsm_err_o = hw.instance "u_daon_lc_aon" @rstmgr_leaf_rst(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_aon_i: i1, parent_rst_ni: %73: i1, sw_rst_req_ni: %true: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %100, %u_daon_lc_aon.rst_en_o after %0 : i4
    llhd.drv %102, %u_daon_lc_aon.leaf_rst_o after %0 : i1
    llhd.drv %104, %u_daon_lc_aon.err_o after %0 : i1
    llhd.drv %106, %u_daon_lc_aon.fsm_err_o after %0 : i1
    %107 = llhd.sig.struct_extract %rst_en_o["lc_io"] : <!hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>>
    %108 = llhd.sig.array_get %107[%false] : <!hw.array<2xi4>>
    %109 = llhd.sig.struct_extract %resets_o["rst_lc_io_n"] : <!hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>>
    %110 = llhd.sig.extract %109 from %false : <i2> -> <i1>
    %111 = llhd.sig.array_get %cnsty_chk_errs[%c7_i5] : <!hw.array<21xi2>>
    %112 = llhd.sig.extract %111 from %false : <i2> -> <i1>
    %113 = llhd.sig.array_get %fsm_errs[%c7_i5] : <!hw.array<21xi2>>
    %114 = llhd.sig.extract %113 from %false : <i2> -> <i1>
    %u_daon_lc_io.rst_en_o, %u_daon_lc_io.leaf_rst_o, %u_daon_lc_io.err_o, %u_daon_lc_io.fsm_err_o = hw.instance "u_daon_lc_io" @rstmgr_leaf_rst(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_io_i: i1, parent_rst_ni: %73: i1, sw_rst_req_ni: %true: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %108, %u_daon_lc_io.rst_en_o after %0 : i4
    llhd.drv %110, %u_daon_lc_io.leaf_rst_o after %0 : i1
    llhd.drv %112, %u_daon_lc_io.err_o after %0 : i1
    llhd.drv %114, %u_daon_lc_io.fsm_err_o after %0 : i1
    %115 = llhd.sig.array_get %107[%true] : <!hw.array<2xi4>>
    %116 = llhd.sig.extract %109 from %true : <i2> -> <i1>
    %117 = llhd.sig.extract %111 from %true : <i2> -> <i1>
    %118 = llhd.sig.extract %113 from %true : <i2> -> <i1>
    %u_d0_lc_io.rst_en_o, %u_d0_lc_io.leaf_rst_o, %u_d0_lc_io.err_o, %u_d0_lc_io.fsm_err_o = hw.instance "u_d0_lc_io" @rstmgr_leaf_rst(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_io_i: i1, parent_rst_ni: %82: i1, sw_rst_req_ni: %true: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %115, %u_d0_lc_io.rst_en_o after %0 : i4
    llhd.drv %116, %u_d0_lc_io.leaf_rst_o after %0 : i1
    llhd.drv %117, %u_d0_lc_io.err_o after %0 : i1
    llhd.drv %118, %u_d0_lc_io.fsm_err_o after %0 : i1
    %119 = llhd.sig.struct_extract %rst_en_o["lc_io_div2"] : <!hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>>
    %120 = llhd.sig.array_get %119[%false] : <!hw.array<2xi4>>
    %121 = llhd.sig.struct_extract %resets_o["rst_lc_io_div2_n"] : <!hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>>
    %122 = llhd.sig.extract %121 from %false : <i2> -> <i1>
    %123 = llhd.sig.array_get %cnsty_chk_errs[%c8_i5] : <!hw.array<21xi2>>
    %124 = llhd.sig.extract %123 from %false : <i2> -> <i1>
    %125 = llhd.sig.array_get %fsm_errs[%c8_i5] : <!hw.array<21xi2>>
    %126 = llhd.sig.extract %125 from %false : <i2> -> <i1>
    %u_daon_lc_io_div2.rst_en_o, %u_daon_lc_io_div2.leaf_rst_o, %u_daon_lc_io_div2.err_o, %u_daon_lc_io_div2.fsm_err_o = hw.instance "u_daon_lc_io_div2" @rstmgr_leaf_rst(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_io_div2_i: i1, parent_rst_ni: %73: i1, sw_rst_req_ni: %true: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %120, %u_daon_lc_io_div2.rst_en_o after %0 : i4
    llhd.drv %122, %u_daon_lc_io_div2.leaf_rst_o after %0 : i1
    llhd.drv %124, %u_daon_lc_io_div2.err_o after %0 : i1
    llhd.drv %126, %u_daon_lc_io_div2.fsm_err_o after %0 : i1
    %127 = llhd.sig.array_get %119[%true] : <!hw.array<2xi4>>
    %128 = llhd.sig.extract %121 from %true : <i2> -> <i1>
    %129 = llhd.sig.extract %123 from %true : <i2> -> <i1>
    %130 = llhd.sig.extract %125 from %true : <i2> -> <i1>
    %u_d0_lc_io_div2.rst_en_o, %u_d0_lc_io_div2.leaf_rst_o, %u_d0_lc_io_div2.err_o, %u_d0_lc_io_div2.fsm_err_o = hw.instance "u_d0_lc_io_div2" @rstmgr_leaf_rst(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_io_div2_i: i1, parent_rst_ni: %82: i1, sw_rst_req_ni: %true: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %127, %u_d0_lc_io_div2.rst_en_o after %0 : i4
    llhd.drv %128, %u_d0_lc_io_div2.leaf_rst_o after %0 : i1
    llhd.drv %129, %u_d0_lc_io_div2.err_o after %0 : i1
    llhd.drv %130, %u_d0_lc_io_div2.fsm_err_o after %0 : i1
    %131 = llhd.sig.struct_extract %rst_en_o["lc_io_div4"] : <!hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>>
    %132 = llhd.sig.array_get %131[%false] : <!hw.array<2xi4>>
    %133 = llhd.sig.struct_extract %resets_o["rst_lc_io_div4_n"] : <!hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>>
    %134 = llhd.sig.extract %133 from %false : <i2> -> <i1>
    %135 = llhd.sig.array_get %cnsty_chk_errs[%c9_i5] : <!hw.array<21xi2>>
    %136 = llhd.sig.extract %135 from %false : <i2> -> <i1>
    %137 = llhd.sig.array_get %fsm_errs[%c9_i5] : <!hw.array<21xi2>>
    %138 = llhd.sig.extract %137 from %false : <i2> -> <i1>
    %u_daon_lc_io_div4.rst_en_o, %u_daon_lc_io_div4.leaf_rst_o, %u_daon_lc_io_div4.err_o, %u_daon_lc_io_div4.fsm_err_o = hw.instance "u_daon_lc_io_div4" @rstmgr_leaf_rst_0(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_io_div4_i: i1, parent_rst_ni: %73: i1, sw_rst_req_ni: %true: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %132, %u_daon_lc_io_div4.rst_en_o after %0 : i4
    llhd.drv %134, %u_daon_lc_io_div4.leaf_rst_o after %0 : i1
    llhd.drv %136, %u_daon_lc_io_div4.err_o after %0 : i1
    llhd.drv %138, %u_daon_lc_io_div4.fsm_err_o after %0 : i1
    %139 = llhd.sig.array_get %131[%true] : <!hw.array<2xi4>>
    %140 = llhd.sig.extract %133 from %true : <i2> -> <i1>
    %141 = llhd.sig.extract %135 from %true : <i2> -> <i1>
    %142 = llhd.sig.extract %137 from %true : <i2> -> <i1>
    %u_d0_lc_io_div4.rst_en_o, %u_d0_lc_io_div4.leaf_rst_o, %u_d0_lc_io_div4.err_o, %u_d0_lc_io_div4.fsm_err_o = hw.instance "u_d0_lc_io_div4" @rstmgr_leaf_rst_0(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_io_div4_i: i1, parent_rst_ni: %82: i1, sw_rst_req_ni: %true: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %139, %u_d0_lc_io_div4.rst_en_o after %0 : i4
    llhd.drv %140, %u_d0_lc_io_div4.leaf_rst_o after %0 : i1
    llhd.drv %141, %u_d0_lc_io_div4.err_o after %0 : i1
    llhd.drv %142, %u_d0_lc_io_div4.fsm_err_o after %0 : i1
    %143 = llhd.sig.struct_extract %rst_en_o["lc_io_div4_shadowed"] : <!hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>>
    %144 = llhd.sig.array_get %143[%false] : <!hw.array<2xi4>>
    %145 = llhd.sig.struct_extract %resets_o["rst_lc_io_div4_shadowed_n"] : <!hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>>
    %146 = llhd.sig.extract %145 from %false : <i2> -> <i1>
    %147 = llhd.sig.array_get %shadow_cnsty_chk_errs[%c9_i5] : <!hw.array<21xi2>>
    %148 = llhd.sig.extract %147 from %false : <i2> -> <i1>
    %149 = llhd.sig.array_get %shadow_fsm_errs[%c9_i5] : <!hw.array<21xi2>>
    %150 = llhd.sig.extract %149 from %false : <i2> -> <i1>
    %u_daon_lc_io_div4_shadowed.rst_en_o, %u_daon_lc_io_div4_shadowed.leaf_rst_o, %u_daon_lc_io_div4_shadowed.err_o, %u_daon_lc_io_div4_shadowed.fsm_err_o = hw.instance "u_daon_lc_io_div4_shadowed" @rstmgr_leaf_rst_0(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_io_div4_i: i1, parent_rst_ni: %73: i1, sw_rst_req_ni: %true: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %144, %u_daon_lc_io_div4_shadowed.rst_en_o after %0 : i4
    llhd.drv %146, %u_daon_lc_io_div4_shadowed.leaf_rst_o after %0 : i1
    llhd.drv %148, %u_daon_lc_io_div4_shadowed.err_o after %0 : i1
    llhd.drv %150, %u_daon_lc_io_div4_shadowed.fsm_err_o after %0 : i1
    %151 = llhd.sig.array_get %143[%true] : <!hw.array<2xi4>>
    %152 = llhd.sig.extract %145 from %true : <i2> -> <i1>
    %153 = llhd.sig.extract %147 from %true : <i2> -> <i1>
    %154 = llhd.sig.extract %149 from %true : <i2> -> <i1>
    %u_d0_lc_io_div4_shadowed.rst_en_o, %u_d0_lc_io_div4_shadowed.leaf_rst_o, %u_d0_lc_io_div4_shadowed.err_o, %u_d0_lc_io_div4_shadowed.fsm_err_o = hw.instance "u_d0_lc_io_div4_shadowed" @rstmgr_leaf_rst_0(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_io_div4_i: i1, parent_rst_ni: %82: i1, sw_rst_req_ni: %true: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %151, %u_d0_lc_io_div4_shadowed.rst_en_o after %0 : i4
    llhd.drv %152, %u_d0_lc_io_div4_shadowed.leaf_rst_o after %0 : i1
    llhd.drv %153, %u_d0_lc_io_div4_shadowed.err_o after %0 : i1
    llhd.drv %154, %u_d0_lc_io_div4_shadowed.fsm_err_o after %0 : i1
    %155 = llhd.sig.struct_extract %rst_en_o["lc_usb"] : <!hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>>
    %156 = llhd.sig.array_get %155[%false] : <!hw.array<2xi4>>
    %157 = llhd.sig.struct_extract %resets_o["rst_lc_usb_n"] : <!hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>>
    %158 = llhd.sig.extract %157 from %false : <i2> -> <i1>
    %159 = llhd.sig.array_get %cnsty_chk_errs[%c10_i5] : <!hw.array<21xi2>>
    %160 = llhd.sig.extract %159 from %false : <i2> -> <i1>
    %161 = llhd.sig.array_get %fsm_errs[%c10_i5] : <!hw.array<21xi2>>
    %162 = llhd.sig.extract %161 from %false : <i2> -> <i1>
    %u_daon_lc_usb.rst_en_o, %u_daon_lc_usb.leaf_rst_o, %u_daon_lc_usb.err_o, %u_daon_lc_usb.fsm_err_o = hw.instance "u_daon_lc_usb" @rstmgr_leaf_rst(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_usb_i: i1, parent_rst_ni: %73: i1, sw_rst_req_ni: %true: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %156, %u_daon_lc_usb.rst_en_o after %0 : i4
    llhd.drv %158, %u_daon_lc_usb.leaf_rst_o after %0 : i1
    llhd.drv %160, %u_daon_lc_usb.err_o after %0 : i1
    llhd.drv %162, %u_daon_lc_usb.fsm_err_o after %0 : i1
    %163 = llhd.sig.array_get %155[%true] : <!hw.array<2xi4>>
    %164 = llhd.sig.extract %157 from %true : <i2> -> <i1>
    %165 = llhd.sig.extract %159 from %true : <i2> -> <i1>
    %166 = llhd.sig.extract %161 from %true : <i2> -> <i1>
    %u_d0_lc_usb.rst_en_o, %u_d0_lc_usb.leaf_rst_o, %u_d0_lc_usb.err_o, %u_d0_lc_usb.fsm_err_o = hw.instance "u_d0_lc_usb" @rstmgr_leaf_rst(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_usb_i: i1, parent_rst_ni: %82: i1, sw_rst_req_ni: %true: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %163, %u_d0_lc_usb.rst_en_o after %0 : i4
    llhd.drv %164, %u_d0_lc_usb.leaf_rst_o after %0 : i1
    llhd.drv %165, %u_d0_lc_usb.err_o after %0 : i1
    llhd.drv %166, %u_d0_lc_usb.fsm_err_o after %0 : i1
    %167 = comb.extract %u_sys_src.rst_no from 1 : (i2) -> i1
    %168 = llhd.sig.struct_extract %rst_en_o["sys"] : <!hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>>
    %169 = llhd.sig.array_get %168[%true] : <!hw.array<2xi4>>
    %170 = llhd.sig.struct_extract %resets_o["rst_sys_n"] : <!hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>>
    %171 = llhd.sig.extract %170 from %true : <i2> -> <i1>
    %172 = llhd.sig.array_get %cnsty_chk_errs[%c11_i5] : <!hw.array<21xi2>>
    %173 = llhd.sig.extract %172 from %true : <i2> -> <i1>
    %174 = llhd.sig.array_get %fsm_errs[%c11_i5] : <!hw.array<21xi2>>
    %175 = llhd.sig.extract %174 from %true : <i2> -> <i1>
    %u_d0_sys.rst_en_o, %u_d0_sys.leaf_rst_o, %u_d0_sys.err_o, %u_d0_sys.fsm_err_o = hw.instance "u_d0_sys" @rstmgr_leaf_rst(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_main_i: i1, parent_rst_ni: %167: i1, sw_rst_req_ni: %true: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %169, %u_d0_sys.rst_en_o after %0 : i4
    llhd.drv %171, %u_d0_sys.leaf_rst_o after %0 : i1
    llhd.drv %173, %u_d0_sys.err_o after %0 : i1
    llhd.drv %175, %u_d0_sys.fsm_err_o after %0 : i1
    %176 = comb.extract %u_sys_src.rst_no from 0 : (i2) -> i1
    %177 = llhd.sig.struct_extract %rst_en_o["sys_io_div4"] : <!hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>>
    %178 = llhd.sig.array_get %177[%false] : <!hw.array<2xi4>>
    %179 = llhd.sig.struct_extract %resets_o["rst_sys_io_div4_n"] : <!hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>>
    %180 = llhd.sig.extract %179 from %false : <i2> -> <i1>
    %181 = llhd.sig.array_get %cnsty_chk_errs[%c12_i5] : <!hw.array<21xi2>>
    %182 = llhd.sig.extract %181 from %false : <i2> -> <i1>
    %183 = llhd.sig.array_get %fsm_errs[%c12_i5] : <!hw.array<21xi2>>
    %184 = llhd.sig.extract %183 from %false : <i2> -> <i1>
    %u_daon_sys_io_div4.rst_en_o, %u_daon_sys_io_div4.leaf_rst_o, %u_daon_sys_io_div4.err_o, %u_daon_sys_io_div4.fsm_err_o = hw.instance "u_daon_sys_io_div4" @rstmgr_leaf_rst(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_io_div4_i: i1, parent_rst_ni: %176: i1, sw_rst_req_ni: %true: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %178, %u_daon_sys_io_div4.rst_en_o after %0 : i4
    llhd.drv %180, %u_daon_sys_io_div4.leaf_rst_o after %0 : i1
    llhd.drv %182, %u_daon_sys_io_div4.err_o after %0 : i1
    llhd.drv %184, %u_daon_sys_io_div4.fsm_err_o after %0 : i1
    %sw_rst_ctrl_n = hw.struct_extract %u_reg.reg2hw["sw_rst_ctrl_n"] : !hw.struct<alert_test: !hw.struct<fatal_cnsty_fault: !hw.struct<q: i1, qe: i1>, fatal_fault: !hw.struct<q: i1, qe: i1>>, reset_req: !hw.struct<q: i4>, reset_info: !hw.struct<hw_req: !hw.struct<q: i5>, sw_reset: !hw.struct<q: i1>>, alert_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, cpu_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, sw_rst_ctrl_n: !hw.array<8xstruct<q: i1>>, err_code: !hw.struct<fsm_err: !hw.struct<q: i1>, reset_consistency_err: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %185 = hw.array_get %sw_rst_ctrl_n[%c0_i3] : !hw.array<8xstruct<q: i1>>, i3
    %q = hw.struct_extract %185["q"] : !hw.struct<q: i1>
    %186 = llhd.sig.struct_extract %rst_en_o["spi_device"] : <!hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>>
    %187 = llhd.sig.array_get %186[%true] : <!hw.array<2xi4>>
    %188 = llhd.sig.struct_extract %resets_o["rst_spi_device_n"] : <!hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>>
    %189 = llhd.sig.extract %188 from %true : <i2> -> <i1>
    %190 = llhd.sig.array_get %cnsty_chk_errs[%c13_i5] : <!hw.array<21xi2>>
    %191 = llhd.sig.extract %190 from %true : <i2> -> <i1>
    %192 = llhd.sig.array_get %fsm_errs[%c13_i5] : <!hw.array<21xi2>>
    %193 = llhd.sig.extract %192 from %true : <i2> -> <i1>
    %u_d0_spi_device.rst_en_o, %u_d0_spi_device.leaf_rst_o, %u_d0_spi_device.err_o, %u_d0_spi_device.fsm_err_o = hw.instance "u_d0_spi_device" @rstmgr_leaf_rst_1(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_io_div4_i: i1, parent_rst_ni: %82: i1, sw_rst_req_ni: %q: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %187, %u_d0_spi_device.rst_en_o after %0 : i4
    llhd.drv %189, %u_d0_spi_device.leaf_rst_o after %0 : i1
    llhd.drv %191, %u_d0_spi_device.err_o after %0 : i1
    llhd.drv %193, %u_d0_spi_device.fsm_err_o after %0 : i1
    %194 = hw.array_get %sw_rst_ctrl_n[%c1_i3] : !hw.array<8xstruct<q: i1>>, i3
    %q_0 = hw.struct_extract %194["q"] : !hw.struct<q: i1>
    %195 = llhd.sig.struct_extract %rst_en_o["spi_host0"] : <!hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>>
    %196 = llhd.sig.array_get %195[%true] : <!hw.array<2xi4>>
    %197 = llhd.sig.struct_extract %resets_o["rst_spi_host0_n"] : <!hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>>
    %198 = llhd.sig.extract %197 from %true : <i2> -> <i1>
    %199 = llhd.sig.array_get %cnsty_chk_errs[%c14_i5] : <!hw.array<21xi2>>
    %200 = llhd.sig.extract %199 from %true : <i2> -> <i1>
    %201 = llhd.sig.array_get %fsm_errs[%c14_i5] : <!hw.array<21xi2>>
    %202 = llhd.sig.extract %201 from %true : <i2> -> <i1>
    %u_d0_spi_host0.rst_en_o, %u_d0_spi_host0.leaf_rst_o, %u_d0_spi_host0.err_o, %u_d0_spi_host0.fsm_err_o = hw.instance "u_d0_spi_host0" @rstmgr_leaf_rst_1(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_io_i: i1, parent_rst_ni: %82: i1, sw_rst_req_ni: %q_0: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %196, %u_d0_spi_host0.rst_en_o after %0 : i4
    llhd.drv %198, %u_d0_spi_host0.leaf_rst_o after %0 : i1
    llhd.drv %200, %u_d0_spi_host0.err_o after %0 : i1
    llhd.drv %202, %u_d0_spi_host0.fsm_err_o after %0 : i1
    %203 = hw.array_get %sw_rst_ctrl_n[%c2_i3] : !hw.array<8xstruct<q: i1>>, i3
    %q_1 = hw.struct_extract %203["q"] : !hw.struct<q: i1>
    %204 = llhd.sig.struct_extract %rst_en_o["spi_host1"] : <!hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>>
    %205 = llhd.sig.array_get %204[%true] : <!hw.array<2xi4>>
    %206 = llhd.sig.struct_extract %resets_o["rst_spi_host1_n"] : <!hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>>
    %207 = llhd.sig.extract %206 from %true : <i2> -> <i1>
    %208 = llhd.sig.array_get %cnsty_chk_errs[%c15_i5] : <!hw.array<21xi2>>
    %209 = llhd.sig.extract %208 from %true : <i2> -> <i1>
    %210 = llhd.sig.array_get %fsm_errs[%c15_i5] : <!hw.array<21xi2>>
    %211 = llhd.sig.extract %210 from %true : <i2> -> <i1>
    %u_d0_spi_host1.rst_en_o, %u_d0_spi_host1.leaf_rst_o, %u_d0_spi_host1.err_o, %u_d0_spi_host1.fsm_err_o = hw.instance "u_d0_spi_host1" @rstmgr_leaf_rst_1(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_io_div2_i: i1, parent_rst_ni: %82: i1, sw_rst_req_ni: %q_1: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %205, %u_d0_spi_host1.rst_en_o after %0 : i4
    llhd.drv %207, %u_d0_spi_host1.leaf_rst_o after %0 : i1
    llhd.drv %209, %u_d0_spi_host1.err_o after %0 : i1
    llhd.drv %211, %u_d0_spi_host1.fsm_err_o after %0 : i1
    %212 = hw.array_get %sw_rst_ctrl_n[%c3_i3] : !hw.array<8xstruct<q: i1>>, i3
    %q_2 = hw.struct_extract %212["q"] : !hw.struct<q: i1>
    %213 = llhd.sig.struct_extract %rst_en_o["usb"] : <!hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>>
    %214 = llhd.sig.array_get %213[%true] : <!hw.array<2xi4>>
    %215 = llhd.sig.struct_extract %resets_o["rst_usb_n"] : <!hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>>
    %216 = llhd.sig.extract %215 from %true : <i2> -> <i1>
    %217 = llhd.sig.array_get %cnsty_chk_errs[%c-16_i5] : <!hw.array<21xi2>>
    %218 = llhd.sig.extract %217 from %true : <i2> -> <i1>
    %219 = llhd.sig.array_get %fsm_errs[%c-16_i5] : <!hw.array<21xi2>>
    %220 = llhd.sig.extract %219 from %true : <i2> -> <i1>
    %u_d0_usb.rst_en_o, %u_d0_usb.leaf_rst_o, %u_d0_usb.err_o, %u_d0_usb.fsm_err_o = hw.instance "u_d0_usb" @rstmgr_leaf_rst_1(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_usb_i: i1, parent_rst_ni: %82: i1, sw_rst_req_ni: %q_2: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %214, %u_d0_usb.rst_en_o after %0 : i4
    llhd.drv %216, %u_d0_usb.leaf_rst_o after %0 : i1
    llhd.drv %218, %u_d0_usb.err_o after %0 : i1
    llhd.drv %220, %u_d0_usb.fsm_err_o after %0 : i1
    %221 = hw.array_get %sw_rst_ctrl_n[%c-4_i3] : !hw.array<8xstruct<q: i1>>, i3
    %q_3 = hw.struct_extract %221["q"] : !hw.struct<q: i1>
    %222 = llhd.sig.struct_extract %rst_en_o["usb_aon"] : <!hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>>
    %223 = llhd.sig.array_get %222[%true] : <!hw.array<2xi4>>
    %224 = llhd.sig.struct_extract %resets_o["rst_usb_aon_n"] : <!hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>>
    %225 = llhd.sig.extract %224 from %true : <i2> -> <i1>
    %226 = llhd.sig.array_get %cnsty_chk_errs[%c-15_i5] : <!hw.array<21xi2>>
    %227 = llhd.sig.extract %226 from %true : <i2> -> <i1>
    %228 = llhd.sig.array_get %fsm_errs[%c-15_i5] : <!hw.array<21xi2>>
    %229 = llhd.sig.extract %228 from %true : <i2> -> <i1>
    %u_d0_usb_aon.rst_en_o, %u_d0_usb_aon.leaf_rst_o, %u_d0_usb_aon.err_o, %u_d0_usb_aon.fsm_err_o = hw.instance "u_d0_usb_aon" @rstmgr_leaf_rst_1(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_aon_i: i1, parent_rst_ni: %82: i1, sw_rst_req_ni: %q_3: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %223, %u_d0_usb_aon.rst_en_o after %0 : i4
    llhd.drv %225, %u_d0_usb_aon.leaf_rst_o after %0 : i1
    llhd.drv %227, %u_d0_usb_aon.err_o after %0 : i1
    llhd.drv %229, %u_d0_usb_aon.fsm_err_o after %0 : i1
    %230 = hw.array_get %sw_rst_ctrl_n[%c-3_i3] : !hw.array<8xstruct<q: i1>>, i3
    %q_4 = hw.struct_extract %230["q"] : !hw.struct<q: i1>
    %231 = llhd.sig.struct_extract %rst_en_o["i2c0"] : <!hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>>
    %232 = llhd.sig.array_get %231[%true] : <!hw.array<2xi4>>
    %233 = llhd.sig.struct_extract %resets_o["rst_i2c0_n"] : <!hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>>
    %234 = llhd.sig.extract %233 from %true : <i2> -> <i1>
    %235 = llhd.sig.array_get %cnsty_chk_errs[%c-14_i5] : <!hw.array<21xi2>>
    %236 = llhd.sig.extract %235 from %true : <i2> -> <i1>
    %237 = llhd.sig.array_get %fsm_errs[%c-14_i5] : <!hw.array<21xi2>>
    %238 = llhd.sig.extract %237 from %true : <i2> -> <i1>
    %u_d0_i2c0.rst_en_o, %u_d0_i2c0.leaf_rst_o, %u_d0_i2c0.err_o, %u_d0_i2c0.fsm_err_o = hw.instance "u_d0_i2c0" @rstmgr_leaf_rst_1(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_io_div4_i: i1, parent_rst_ni: %82: i1, sw_rst_req_ni: %q_4: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %232, %u_d0_i2c0.rst_en_o after %0 : i4
    llhd.drv %234, %u_d0_i2c0.leaf_rst_o after %0 : i1
    llhd.drv %236, %u_d0_i2c0.err_o after %0 : i1
    llhd.drv %238, %u_d0_i2c0.fsm_err_o after %0 : i1
    %239 = hw.array_get %sw_rst_ctrl_n[%c-2_i3] : !hw.array<8xstruct<q: i1>>, i3
    %q_5 = hw.struct_extract %239["q"] : !hw.struct<q: i1>
    %240 = llhd.sig.struct_extract %rst_en_o["i2c1"] : <!hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>>
    %241 = llhd.sig.array_get %240[%true] : <!hw.array<2xi4>>
    %242 = llhd.sig.struct_extract %resets_o["rst_i2c1_n"] : <!hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>>
    %243 = llhd.sig.extract %242 from %true : <i2> -> <i1>
    %244 = llhd.sig.array_get %cnsty_chk_errs[%c-13_i5] : <!hw.array<21xi2>>
    %245 = llhd.sig.extract %244 from %true : <i2> -> <i1>
    %246 = llhd.sig.array_get %fsm_errs[%c-13_i5] : <!hw.array<21xi2>>
    %247 = llhd.sig.extract %246 from %true : <i2> -> <i1>
    %u_d0_i2c1.rst_en_o, %u_d0_i2c1.leaf_rst_o, %u_d0_i2c1.err_o, %u_d0_i2c1.fsm_err_o = hw.instance "u_d0_i2c1" @rstmgr_leaf_rst_1(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_io_div4_i: i1, parent_rst_ni: %82: i1, sw_rst_req_ni: %q_5: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %241, %u_d0_i2c1.rst_en_o after %0 : i4
    llhd.drv %243, %u_d0_i2c1.leaf_rst_o after %0 : i1
    llhd.drv %245, %u_d0_i2c1.err_o after %0 : i1
    llhd.drv %247, %u_d0_i2c1.fsm_err_o after %0 : i1
    %248 = hw.array_get %sw_rst_ctrl_n[%c-1_i3] : !hw.array<8xstruct<q: i1>>, i3
    %q_6 = hw.struct_extract %248["q"] : !hw.struct<q: i1>
    %249 = llhd.sig.struct_extract %rst_en_o["i2c2"] : <!hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>>
    %250 = llhd.sig.array_get %249[%true] : <!hw.array<2xi4>>
    %251 = llhd.sig.struct_extract %resets_o["rst_i2c2_n"] : <!hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>>
    %252 = llhd.sig.extract %251 from %true : <i2> -> <i1>
    %253 = llhd.sig.array_get %cnsty_chk_errs[%c-12_i5] : <!hw.array<21xi2>>
    %254 = llhd.sig.extract %253 from %true : <i2> -> <i1>
    %255 = llhd.sig.array_get %fsm_errs[%c-12_i5] : <!hw.array<21xi2>>
    %256 = llhd.sig.extract %255 from %true : <i2> -> <i1>
    %u_d0_i2c2.rst_en_o, %u_d0_i2c2.leaf_rst_o, %u_d0_i2c2.err_o, %u_d0_i2c2.fsm_err_o = hw.instance "u_d0_i2c2" @rstmgr_leaf_rst_1(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, leaf_clk_i: %clk_io_div4_i: i1, parent_rst_ni: %82: i1, sw_rst_req_ni: %q_6: i1, scanmode_i: %scanmode_i: i4, scan_rst_ni: %scan_rst_ni: i1) -> (rst_en_o: i4, leaf_rst_o: i1, err_o: i1, fsm_err_o: i1)
    llhd.drv %250, %u_d0_i2c2.rst_en_o after %0 : i4
    llhd.drv %252, %u_d0_i2c2.leaf_rst_o after %0 : i1
    llhd.drv %254, %u_d0_i2c2.err_o after %0 : i1
    llhd.drv %256, %u_d0_i2c2.fsm_err_o after %0 : i1
    %alert_info_ctrl = hw.struct_extract %u_reg.reg2hw["alert_info_ctrl"] : !hw.struct<alert_test: !hw.struct<fatal_cnsty_fault: !hw.struct<q: i1, qe: i1>, fatal_fault: !hw.struct<q: i1, qe: i1>>, reset_req: !hw.struct<q: i4>, reset_info: !hw.struct<hw_req: !hw.struct<q: i5>, sw_reset: !hw.struct<q: i1>>, alert_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, cpu_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, sw_rst_ctrl_n: !hw.array<8xstruct<q: i1>>, err_code: !hw.struct<fsm_err: !hw.struct<q: i1>, reset_consistency_err: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %en = hw.struct_extract %alert_info_ctrl["en"] : !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>
    %q_7 = hw.struct_extract %en["q"] : !hw.struct<q: i1>
    %257 = comb.and %426, %q_7 : i1
    %index = hw.struct_extract %alert_info_ctrl["index"] : !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>
    %q_8 = hw.struct_extract %index["q"] : !hw.struct<q: i4>
    %258 = llhd.sig.struct_extract %hw2reg["alert_info_attr"] : <!hw.struct<reset_req: !hw.struct<d: i4, de: i1>, reset_info: !hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>, alert_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, alert_info_attr: !hw.struct<d: i4>, alert_info: !hw.struct<d: i32>, cpu_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, cpu_info_attr: !hw.struct<d: i4>, cpu_info: !hw.struct<d: i32>, err_code: !hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>>
    %259 = llhd.sig.struct_extract %258["d"] : <!hw.struct<d: i4>>
    %260 = llhd.sig.struct_extract %hw2reg["alert_info"] : <!hw.struct<reset_req: !hw.struct<d: i4, de: i1>, reset_info: !hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>, alert_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, alert_info_attr: !hw.struct<d: i4>, alert_info: !hw.struct<d: i32>, cpu_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, cpu_info_attr: !hw.struct<d: i4>, cpu_info: !hw.struct<d: i32>, err_code: !hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>>
    %261 = llhd.sig.struct_extract %260["d"] : <!hw.struct<d: i32>>
    %262 = hw.bitcast %alert_dump_i : (!hw.struct<alert_cause: i65, loc_alert_cause: i7, class_accum_cnt: !hw.array<4xi16>, class_esc_cnt: !hw.array<4xi32>, class_esc_state: !hw.array<4xi3>>) -> i276
    %u_alert_info.slots_cnt_o, %u_alert_info.slot_o = hw.instance "u_alert_info" @rstmgr_crash_info(clk_i: %clk_por_i: i1, rst_ni: %rst_por_ni: i1, dump_i: %262: i276, dump_capture_i: %257: i1, slot_sel_i: %q_8: i4) -> (slots_cnt_o: i4, slot_o: i32)
    llhd.drv %259, %u_alert_info.slots_cnt_o after %0 : i4
    llhd.drv %261, %u_alert_info.slot_o after %0 : i32
    %cpu_info_ctrl = hw.struct_extract %u_reg.reg2hw["cpu_info_ctrl"] : !hw.struct<alert_test: !hw.struct<fatal_cnsty_fault: !hw.struct<q: i1, qe: i1>, fatal_fault: !hw.struct<q: i1, qe: i1>>, reset_req: !hw.struct<q: i4>, reset_info: !hw.struct<hw_req: !hw.struct<q: i5>, sw_reset: !hw.struct<q: i1>>, alert_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, cpu_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, sw_rst_ctrl_n: !hw.array<8xstruct<q: i1>>, err_code: !hw.struct<fsm_err: !hw.struct<q: i1>, reset_consistency_err: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %en_9 = hw.struct_extract %cpu_info_ctrl["en"] : !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>
    %q_10 = hw.struct_extract %en_9["q"] : !hw.struct<q: i1>
    %263 = comb.and %426, %q_10 : i1
    %index_11 = hw.struct_extract %cpu_info_ctrl["index"] : !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>
    %q_12 = hw.struct_extract %index_11["q"] : !hw.struct<q: i4>
    %264 = llhd.sig.struct_extract %hw2reg["cpu_info_attr"] : <!hw.struct<reset_req: !hw.struct<d: i4, de: i1>, reset_info: !hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>, alert_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, alert_info_attr: !hw.struct<d: i4>, alert_info: !hw.struct<d: i32>, cpu_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, cpu_info_attr: !hw.struct<d: i4>, cpu_info: !hw.struct<d: i32>, err_code: !hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>>
    %265 = llhd.sig.struct_extract %264["d"] : <!hw.struct<d: i4>>
    %266 = llhd.sig.struct_extract %hw2reg["cpu_info"] : <!hw.struct<reset_req: !hw.struct<d: i4, de: i1>, reset_info: !hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>, alert_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, alert_info_attr: !hw.struct<d: i4>, alert_info: !hw.struct<d: i32>, cpu_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, cpu_info_attr: !hw.struct<d: i4>, cpu_info: !hw.struct<d: i32>, err_code: !hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>>
    %267 = llhd.sig.struct_extract %266["d"] : <!hw.struct<d: i32>>
    %268 = hw.bitcast %cpu_dump_i : (!hw.struct<prev_valid: i1, prev_exception_pc: i32, prev_exception_addr: i32, current: !hw.struct<current_pc: i32, next_pc: i32, last_data_addr: i32, exception_pc: i32, exception_addr: i32>>) -> i225
    %u_cpu_info.slots_cnt_o, %u_cpu_info.slot_o = hw.instance "u_cpu_info" @rstmgr_crash_info_2(clk_i: %clk_por_i: i1, rst_ni: %rst_por_ni: i1, dump_i: %268: i225, dump_capture_i: %263: i1, slot_sel_i: %q_12: i4) -> (slots_cnt_o: i4, slot_o: i32)
    llhd.drv %265, %u_cpu_info.slots_cnt_o after %0 : i4
    llhd.drv %267, %u_cpu_info.slot_o after %0 : i32
    %269 = llhd.sig.struct_extract %resets_o["rst_por_aon_n"] : <!hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>>
    llhd.drv %269, %11 after %0 : i2
    %270 = llhd.sig.struct_extract %hw2reg["err_code"] : <!hw.struct<reset_req: !hw.struct<d: i4, de: i1>, reset_info: !hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>, alert_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, alert_info_attr: !hw.struct<d: i4>, alert_info: !hw.struct<d: i32>, cpu_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, cpu_info_attr: !hw.struct<d: i4>, cpu_info: !hw.struct<d: i32>, err_code: !hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>>
    %271 = llhd.sig.struct_extract %270["reg_intg_err"] : <!hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %272 = llhd.sig.struct_extract %271["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %272, %true after %0 : i1
    %273 = llhd.sig.struct_extract %271["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %273, %u_reg.intg_err_o after %0 : i1
    %274 = llhd.sig.struct_extract %270["reset_consistency_err"] : <!hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %275 = llhd.sig.struct_extract %274["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %275, %true after %0 : i1
    %276 = llhd.sig.struct_extract %274["de"] : <!hw.struct<d: i1, de: i1>>
    %277 = llhd.prb %cnsty_chk_errs : !hw.array<21xi2>
    %278 = hw.bitcast %277 : (!hw.array<21xi2>) -> i42
    %279 = comb.icmp ne %278, %c0_i42 : i42
    %280 = llhd.prb %shadow_cnsty_chk_errs : !hw.array<21xi2>
    %281 = hw.bitcast %280 : (!hw.array<21xi2>) -> i42
    %282 = comb.icmp ne %281, %c0_i42 : i42
    %283 = comb.or %279, %282 : i1
    llhd.drv %276, %283 after %0 : i1
    %284 = llhd.sig.struct_extract %270["fsm_err"] : <!hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>
    %285 = llhd.sig.struct_extract %284["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %285, %true after %0 : i1
    %286 = llhd.sig.struct_extract %284["de"] : <!hw.struct<d: i1, de: i1>>
    %287 = llhd.prb %fsm_errs : !hw.array<21xi2>
    %288 = hw.bitcast %287 : (!hw.array<21xi2>) -> i42
    %289 = comb.icmp ne %288, %c0_i42 : i42
    %290 = llhd.prb %shadow_fsm_errs : !hw.array<21xi2>
    %291 = hw.bitcast %290 : (!hw.array<21xi2>) -> i42
    %292 = comb.icmp ne %291, %c0_i42 : i42
    %293 = comb.or %289, %292 : i1
    llhd.drv %286, %293 after %0 : i1
    %294 = llhd.sig.extract %alerts from %false : <i2> -> <i1>
    %err_code = hw.struct_extract %u_reg.reg2hw["err_code"] : !hw.struct<alert_test: !hw.struct<fatal_cnsty_fault: !hw.struct<q: i1, qe: i1>, fatal_fault: !hw.struct<q: i1, qe: i1>>, reset_req: !hw.struct<q: i4>, reset_info: !hw.struct<hw_req: !hw.struct<q: i5>, sw_reset: !hw.struct<q: i1>>, alert_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, cpu_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, sw_rst_ctrl_n: !hw.array<8xstruct<q: i1>>, err_code: !hw.struct<fsm_err: !hw.struct<q: i1>, reset_consistency_err: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %reg_intg_err = hw.struct_extract %err_code["reg_intg_err"] : !hw.struct<fsm_err: !hw.struct<q: i1>, reset_consistency_err: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>
    %q_13 = hw.struct_extract %reg_intg_err["q"] : !hw.struct<q: i1>
    %fsm_err = hw.struct_extract %err_code["fsm_err"] : !hw.struct<fsm_err: !hw.struct<q: i1>, reset_consistency_err: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>
    %q_14 = hw.struct_extract %fsm_err["q"] : !hw.struct<q: i1>
    %295 = comb.or %q_13, %q_14 : i1
    llhd.drv %294, %295 after %0 : i1
    %296 = llhd.sig.extract %alerts from %true : <i2> -> <i1>
    %reset_consistency_err = hw.struct_extract %err_code["reset_consistency_err"] : !hw.struct<fsm_err: !hw.struct<q: i1>, reset_consistency_err: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>
    %q_15 = hw.struct_extract %reset_consistency_err["q"] : !hw.struct<q: i1>
    llhd.drv %296, %q_15 after %0 : i1
    %alert_test = hw.struct_extract %u_reg.reg2hw["alert_test"] : !hw.struct<alert_test: !hw.struct<fatal_cnsty_fault: !hw.struct<q: i1, qe: i1>, fatal_fault: !hw.struct<q: i1, qe: i1>>, reset_req: !hw.struct<q: i4>, reset_info: !hw.struct<hw_req: !hw.struct<q: i5>, sw_reset: !hw.struct<q: i1>>, alert_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, cpu_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, sw_rst_ctrl_n: !hw.array<8xstruct<q: i1>>, err_code: !hw.struct<fsm_err: !hw.struct<q: i1>, reset_consistency_err: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %fatal_cnsty_fault = hw.struct_extract %alert_test["fatal_cnsty_fault"] : !hw.struct<fatal_cnsty_fault: !hw.struct<q: i1, qe: i1>, fatal_fault: !hw.struct<q: i1, qe: i1>>
    %q_16 = hw.struct_extract %fatal_cnsty_fault["q"] : !hw.struct<q: i1, qe: i1>
    %qe = hw.struct_extract %fatal_cnsty_fault["qe"] : !hw.struct<q: i1, qe: i1>
    %297 = comb.and %q_16, %qe : i1
    %fatal_fault = hw.struct_extract %alert_test["fatal_fault"] : !hw.struct<fatal_cnsty_fault: !hw.struct<q: i1, qe: i1>, fatal_fault: !hw.struct<q: i1, qe: i1>>
    %q_17 = hw.struct_extract %fatal_fault["q"] : !hw.struct<q: i1, qe: i1>
    %qe_18 = hw.struct_extract %fatal_fault["qe"] : !hw.struct<q: i1, qe: i1>
    %298 = comb.and %q_17, %qe_18 : i1
    %299 = llhd.sig.struct_extract %pwr_o["rst_lc_src_n"] : <!hw.struct<rst_lc_src_n: i2, rst_sys_src_n: i2>>
    llhd.drv %299, %u_lc_src.rst_no after %0 : i2
    %300 = llhd.sig.struct_extract %pwr_o["rst_sys_src_n"] : <!hw.struct<rst_lc_src_n: i2, rst_sys_src_n: i2>>
    llhd.drv %300, %u_sys_src.rst_no after %0 : i2
    %301 = llhd.sig.extract %35 from %true : <i2> -> <i1>
    llhd.drv %301, %false after %0 : i1
    %302 = llhd.sig.extract %37 from %true : <i2> -> <i1>
    llhd.drv %302, %false after %0 : i1
    %303 = llhd.sig.extract %39 from %true : <i2> -> <i1>
    llhd.drv %303, %false after %0 : i1
    %304 = llhd.sig.array_get %33[%true] : <!hw.array<2xi4>>
    llhd.drv %304, %c6_i4 after %0 : i4
    %305 = llhd.sig.array_get %shadow_cnsty_chk_errs[%c0_i5] : <!hw.array<21xi2>>
    llhd.drv %305, %c0_i2 after %0 : i2
    %306 = llhd.sig.array_get %shadow_fsm_errs[%c0_i5] : <!hw.array<21xi2>>
    llhd.drv %306, %c0_i2 after %0 : i2
    %307 = llhd.sig.extract %43 from %true : <i2> -> <i1>
    llhd.drv %307, %false after %0 : i1
    %308 = llhd.sig.extract %45 from %true : <i2> -> <i1>
    llhd.drv %308, %false after %0 : i1
    %309 = llhd.sig.extract %47 from %true : <i2> -> <i1>
    llhd.drv %309, %false after %0 : i1
    %310 = llhd.sig.array_get %41[%true] : <!hw.array<2xi4>>
    llhd.drv %310, %c6_i4 after %0 : i4
    %311 = llhd.sig.array_get %shadow_cnsty_chk_errs[%c1_i5] : <!hw.array<21xi2>>
    llhd.drv %311, %c0_i2 after %0 : i2
    %312 = llhd.sig.array_get %shadow_fsm_errs[%c1_i5] : <!hw.array<21xi2>>
    llhd.drv %312, %c0_i2 after %0 : i2
    %313 = llhd.sig.extract %51 from %true : <i2> -> <i1>
    llhd.drv %313, %false after %0 : i1
    %314 = llhd.sig.extract %53 from %true : <i2> -> <i1>
    llhd.drv %314, %false after %0 : i1
    %315 = llhd.sig.extract %55 from %true : <i2> -> <i1>
    llhd.drv %315, %false after %0 : i1
    %316 = llhd.sig.array_get %49[%true] : <!hw.array<2xi4>>
    llhd.drv %316, %c6_i4 after %0 : i4
    %317 = llhd.sig.array_get %shadow_cnsty_chk_errs[%c2_i5] : <!hw.array<21xi2>>
    llhd.drv %317, %c0_i2 after %0 : i2
    %318 = llhd.sig.array_get %shadow_fsm_errs[%c2_i5] : <!hw.array<21xi2>>
    llhd.drv %318, %c0_i2 after %0 : i2
    %319 = llhd.sig.extract %59 from %true : <i2> -> <i1>
    llhd.drv %319, %false after %0 : i1
    %320 = llhd.sig.extract %61 from %true : <i2> -> <i1>
    llhd.drv %320, %false after %0 : i1
    %321 = llhd.sig.extract %63 from %true : <i2> -> <i1>
    llhd.drv %321, %false after %0 : i1
    %322 = llhd.sig.array_get %57[%true] : <!hw.array<2xi4>>
    llhd.drv %322, %c6_i4 after %0 : i4
    %323 = llhd.sig.array_get %shadow_cnsty_chk_errs[%c3_i5] : <!hw.array<21xi2>>
    llhd.drv %323, %c0_i2 after %0 : i2
    %324 = llhd.sig.array_get %shadow_fsm_errs[%c3_i5] : <!hw.array<21xi2>>
    llhd.drv %324, %c0_i2 after %0 : i2
    %325 = llhd.sig.extract %67 from %true : <i2> -> <i1>
    llhd.drv %325, %false after %0 : i1
    %326 = llhd.sig.extract %69 from %true : <i2> -> <i1>
    llhd.drv %326, %false after %0 : i1
    %327 = llhd.sig.extract %71 from %true : <i2> -> <i1>
    llhd.drv %327, %false after %0 : i1
    %328 = llhd.sig.array_get %65[%true] : <!hw.array<2xi4>>
    llhd.drv %328, %c6_i4 after %0 : i4
    %329 = llhd.sig.array_get %shadow_cnsty_chk_errs[%c4_i5] : <!hw.array<21xi2>>
    llhd.drv %329, %c0_i2 after %0 : i2
    %330 = llhd.sig.array_get %shadow_fsm_errs[%c4_i5] : <!hw.array<21xi2>>
    llhd.drv %330, %c0_i2 after %0 : i2
    %331 = llhd.sig.extract %101 from %true : <i2> -> <i1>
    llhd.drv %331, %false after %0 : i1
    %332 = llhd.sig.extract %103 from %true : <i2> -> <i1>
    llhd.drv %332, %false after %0 : i1
    %333 = llhd.sig.extract %105 from %true : <i2> -> <i1>
    llhd.drv %333, %false after %0 : i1
    %334 = llhd.sig.array_get %99[%true] : <!hw.array<2xi4>>
    llhd.drv %334, %c6_i4 after %0 : i4
    %335 = llhd.sig.array_get %shadow_cnsty_chk_errs[%c6_i5] : <!hw.array<21xi2>>
    llhd.drv %335, %c0_i2 after %0 : i2
    %336 = llhd.sig.array_get %shadow_fsm_errs[%c6_i5] : <!hw.array<21xi2>>
    llhd.drv %336, %c0_i2 after %0 : i2
    %337 = llhd.sig.array_get %shadow_cnsty_chk_errs[%c7_i5] : <!hw.array<21xi2>>
    llhd.drv %337, %c0_i2 after %0 : i2
    %338 = llhd.sig.array_get %shadow_fsm_errs[%c7_i5] : <!hw.array<21xi2>>
    llhd.drv %338, %c0_i2 after %0 : i2
    %339 = llhd.sig.array_get %shadow_cnsty_chk_errs[%c8_i5] : <!hw.array<21xi2>>
    llhd.drv %339, %c0_i2 after %0 : i2
    %340 = llhd.sig.array_get %shadow_fsm_errs[%c8_i5] : <!hw.array<21xi2>>
    llhd.drv %340, %c0_i2 after %0 : i2
    %341 = llhd.sig.array_get %shadow_cnsty_chk_errs[%c10_i5] : <!hw.array<21xi2>>
    llhd.drv %341, %c0_i2 after %0 : i2
    %342 = llhd.sig.array_get %shadow_fsm_errs[%c10_i5] : <!hw.array<21xi2>>
    llhd.drv %342, %c0_i2 after %0 : i2
    %343 = llhd.sig.extract %170 from %false : <i2> -> <i1>
    llhd.drv %343, %false after %0 : i1
    %344 = llhd.sig.extract %172 from %false : <i2> -> <i1>
    llhd.drv %344, %false after %0 : i1
    %345 = llhd.sig.extract %174 from %false : <i2> -> <i1>
    llhd.drv %345, %false after %0 : i1
    %346 = llhd.sig.array_get %168[%false] : <!hw.array<2xi4>>
    llhd.drv %346, %c6_i4 after %0 : i4
    %347 = llhd.sig.array_get %shadow_cnsty_chk_errs[%c11_i5] : <!hw.array<21xi2>>
    llhd.drv %347, %c0_i2 after %0 : i2
    %348 = llhd.sig.array_get %shadow_fsm_errs[%c11_i5] : <!hw.array<21xi2>>
    llhd.drv %348, %c0_i2 after %0 : i2
    %349 = llhd.sig.extract %179 from %true : <i2> -> <i1>
    llhd.drv %349, %false after %0 : i1
    %350 = llhd.sig.extract %181 from %true : <i2> -> <i1>
    llhd.drv %350, %false after %0 : i1
    %351 = llhd.sig.extract %183 from %true : <i2> -> <i1>
    llhd.drv %351, %false after %0 : i1
    %352 = llhd.sig.array_get %177[%true] : <!hw.array<2xi4>>
    llhd.drv %352, %c6_i4 after %0 : i4
    %353 = llhd.sig.array_get %shadow_cnsty_chk_errs[%c12_i5] : <!hw.array<21xi2>>
    llhd.drv %353, %c0_i2 after %0 : i2
    %354 = llhd.sig.array_get %shadow_fsm_errs[%c12_i5] : <!hw.array<21xi2>>
    llhd.drv %354, %c0_i2 after %0 : i2
    %355 = llhd.sig.extract %188 from %false : <i2> -> <i1>
    llhd.drv %355, %false after %0 : i1
    %356 = llhd.sig.extract %190 from %false : <i2> -> <i1>
    llhd.drv %356, %false after %0 : i1
    %357 = llhd.sig.extract %192 from %false : <i2> -> <i1>
    llhd.drv %357, %false after %0 : i1
    %358 = llhd.sig.array_get %186[%false] : <!hw.array<2xi4>>
    llhd.drv %358, %c6_i4 after %0 : i4
    %359 = llhd.sig.array_get %shadow_cnsty_chk_errs[%c13_i5] : <!hw.array<21xi2>>
    llhd.drv %359, %c0_i2 after %0 : i2
    %360 = llhd.sig.array_get %shadow_fsm_errs[%c13_i5] : <!hw.array<21xi2>>
    llhd.drv %360, %c0_i2 after %0 : i2
    %361 = llhd.sig.extract %197 from %false : <i2> -> <i1>
    llhd.drv %361, %false after %0 : i1
    %362 = llhd.sig.extract %199 from %false : <i2> -> <i1>
    llhd.drv %362, %false after %0 : i1
    %363 = llhd.sig.extract %201 from %false : <i2> -> <i1>
    llhd.drv %363, %false after %0 : i1
    %364 = llhd.sig.array_get %195[%false] : <!hw.array<2xi4>>
    llhd.drv %364, %c6_i4 after %0 : i4
    %365 = llhd.sig.array_get %shadow_cnsty_chk_errs[%c14_i5] : <!hw.array<21xi2>>
    llhd.drv %365, %c0_i2 after %0 : i2
    %366 = llhd.sig.array_get %shadow_fsm_errs[%c14_i5] : <!hw.array<21xi2>>
    llhd.drv %366, %c0_i2 after %0 : i2
    %367 = llhd.sig.extract %206 from %false : <i2> -> <i1>
    llhd.drv %367, %false after %0 : i1
    %368 = llhd.sig.extract %208 from %false : <i2> -> <i1>
    llhd.drv %368, %false after %0 : i1
    %369 = llhd.sig.extract %210 from %false : <i2> -> <i1>
    llhd.drv %369, %false after %0 : i1
    %370 = llhd.sig.array_get %204[%false] : <!hw.array<2xi4>>
    llhd.drv %370, %c6_i4 after %0 : i4
    %371 = llhd.sig.array_get %shadow_cnsty_chk_errs[%c15_i5] : <!hw.array<21xi2>>
    llhd.drv %371, %c0_i2 after %0 : i2
    %372 = llhd.sig.array_get %shadow_fsm_errs[%c15_i5] : <!hw.array<21xi2>>
    llhd.drv %372, %c0_i2 after %0 : i2
    %373 = llhd.sig.extract %215 from %false : <i2> -> <i1>
    llhd.drv %373, %false after %0 : i1
    %374 = llhd.sig.extract %217 from %false : <i2> -> <i1>
    llhd.drv %374, %false after %0 : i1
    %375 = llhd.sig.extract %219 from %false : <i2> -> <i1>
    llhd.drv %375, %false after %0 : i1
    %376 = llhd.sig.array_get %213[%false] : <!hw.array<2xi4>>
    llhd.drv %376, %c6_i4 after %0 : i4
    %377 = llhd.sig.array_get %shadow_cnsty_chk_errs[%c-16_i5] : <!hw.array<21xi2>>
    llhd.drv %377, %c0_i2 after %0 : i2
    %378 = llhd.sig.array_get %shadow_fsm_errs[%c-16_i5] : <!hw.array<21xi2>>
    llhd.drv %378, %c0_i2 after %0 : i2
    %379 = llhd.sig.extract %224 from %false : <i2> -> <i1>
    llhd.drv %379, %false after %0 : i1
    %380 = llhd.sig.extract %226 from %false : <i2> -> <i1>
    llhd.drv %380, %false after %0 : i1
    %381 = llhd.sig.extract %228 from %false : <i2> -> <i1>
    llhd.drv %381, %false after %0 : i1
    %382 = llhd.sig.array_get %222[%false] : <!hw.array<2xi4>>
    llhd.drv %382, %c6_i4 after %0 : i4
    %383 = llhd.sig.array_get %shadow_cnsty_chk_errs[%c-15_i5] : <!hw.array<21xi2>>
    llhd.drv %383, %c0_i2 after %0 : i2
    %384 = llhd.sig.array_get %shadow_fsm_errs[%c-15_i5] : <!hw.array<21xi2>>
    llhd.drv %384, %c0_i2 after %0 : i2
    %385 = llhd.sig.extract %233 from %false : <i2> -> <i1>
    llhd.drv %385, %false after %0 : i1
    %386 = llhd.sig.extract %235 from %false : <i2> -> <i1>
    llhd.drv %386, %false after %0 : i1
    %387 = llhd.sig.extract %237 from %false : <i2> -> <i1>
    llhd.drv %387, %false after %0 : i1
    %388 = llhd.sig.array_get %231[%false] : <!hw.array<2xi4>>
    llhd.drv %388, %c6_i4 after %0 : i4
    %389 = llhd.sig.array_get %shadow_cnsty_chk_errs[%c-14_i5] : <!hw.array<21xi2>>
    llhd.drv %389, %c0_i2 after %0 : i2
    %390 = llhd.sig.array_get %shadow_fsm_errs[%c-14_i5] : <!hw.array<21xi2>>
    llhd.drv %390, %c0_i2 after %0 : i2
    %391 = llhd.sig.extract %242 from %false : <i2> -> <i1>
    llhd.drv %391, %false after %0 : i1
    %392 = llhd.sig.extract %244 from %false : <i2> -> <i1>
    llhd.drv %392, %false after %0 : i1
    %393 = llhd.sig.extract %246 from %false : <i2> -> <i1>
    llhd.drv %393, %false after %0 : i1
    %394 = llhd.sig.array_get %240[%false] : <!hw.array<2xi4>>
    llhd.drv %394, %c6_i4 after %0 : i4
    %395 = llhd.sig.array_get %shadow_cnsty_chk_errs[%c-13_i5] : <!hw.array<21xi2>>
    llhd.drv %395, %c0_i2 after %0 : i2
    %396 = llhd.sig.array_get %shadow_fsm_errs[%c-13_i5] : <!hw.array<21xi2>>
    llhd.drv %396, %c0_i2 after %0 : i2
    %397 = llhd.sig.extract %251 from %false : <i2> -> <i1>
    llhd.drv %397, %false after %0 : i1
    %398 = llhd.sig.extract %253 from %false : <i2> -> <i1>
    llhd.drv %398, %false after %0 : i1
    %399 = llhd.sig.extract %255 from %false : <i2> -> <i1>
    llhd.drv %399, %false after %0 : i1
    %400 = llhd.sig.array_get %249[%false] : <!hw.array<2xi4>>
    llhd.drv %400, %c6_i4 after %0 : i4
    %401 = llhd.sig.array_get %shadow_cnsty_chk_errs[%c-12_i5] : <!hw.array<21xi2>>
    llhd.drv %401, %c0_i2 after %0 : i2
    %402 = llhd.sig.array_get %shadow_fsm_errs[%c-12_i5] : <!hw.array<21xi2>>
    llhd.drv %402, %c0_i2 after %0 : i2
    %403 = comb.icmp ne %rst_lc_req, %c0_i2 : i2
    %404 = comb.icmp ne %rst_sys_req, %c0_i2 : i2
    %405 = comb.or %403, %404 {sv.namehint = "pwrmgr_rst_req"} : i1
    %reset_cause = hw.struct_extract %pwr_i["reset_cause"] : !hw.struct<rst_lc_req: i2, rst_sys_req: i2, rstreqs: i5, reset_cause: i2>
    %406 = comb.icmp eq %reset_cause, %c-2_i2 : i2
    %407 = comb.and %405, %406 {sv.namehint = "rst_hw_req"} : i1
    %408 = comb.icmp eq %reset_cause, %c1_i2 : i2
    %409 = comb.and %405, %408 {sv.namehint = "rst_low_power"} : i1
    %reset_req = hw.struct_extract %u_reg.reg2hw["reset_req"] : !hw.struct<alert_test: !hw.struct<fatal_cnsty_fault: !hw.struct<q: i1, qe: i1>, fatal_fault: !hw.struct<q: i1, qe: i1>>, reset_req: !hw.struct<q: i4>, reset_info: !hw.struct<hw_req: !hw.struct<q: i5>, sw_reset: !hw.struct<q: i1>>, alert_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, cpu_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, sw_rst_ctrl_n: !hw.array<8xstruct<q: i1>>, err_code: !hw.struct<fsm_err: !hw.struct<q: i1>, reset_consistency_err: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %q_19 = hw.struct_extract %reset_req["q"] : !hw.struct<q: i4>
    %410 = llhd.sig.struct_extract %hw2reg["reset_req"] : <!hw.struct<reset_req: !hw.struct<d: i4, de: i1>, reset_info: !hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>, alert_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, alert_info_attr: !hw.struct<d: i4>, alert_info: !hw.struct<d: i32>, cpu_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, cpu_info_attr: !hw.struct<d: i4>, cpu_info: !hw.struct<d: i32>, err_code: !hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>>
    %411 = llhd.sig.struct_extract %410["de"] : <!hw.struct<d: i4, de: i1>>
    llhd.drv %411, %405 after %0 : i1
    %412 = llhd.sig.struct_extract %410["d"] : <!hw.struct<d: i4, de: i1>>
    llhd.drv %412, %c-7_i4 after %0 : i4
    %413 = llhd.sig.struct_extract %hw2reg["reset_info"] : <!hw.struct<reset_req: !hw.struct<d: i4, de: i1>, reset_info: !hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>, alert_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, alert_info_attr: !hw.struct<d: i4>, alert_info: !hw.struct<d: i32>, cpu_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, cpu_info_attr: !hw.struct<d: i4>, cpu_info: !hw.struct<d: i32>, err_code: !hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>>
    %414 = llhd.sig.struct_extract %413["low_power_exit"] : <!hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>>
    %415 = llhd.sig.struct_extract %414["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %415, %true after %0 : i1
    %416 = llhd.sig.struct_extract %414["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %416, %409 after %0 : i1
    %417 = llhd.sig.struct_extract %413["sw_reset"] : <!hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>>
    %418 = llhd.sig.struct_extract %417["d"] : <!hw.struct<d: i1, de: i1>>
    %419 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%q_19) : (i4) -> i1
    %reset_info = hw.struct_extract %u_reg.reg2hw["reset_info"] : !hw.struct<alert_test: !hw.struct<fatal_cnsty_fault: !hw.struct<q: i1, qe: i1>, fatal_fault: !hw.struct<q: i1, qe: i1>>, reset_req: !hw.struct<q: i4>, reset_info: !hw.struct<hw_req: !hw.struct<q: i5>, sw_reset: !hw.struct<q: i1>>, alert_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, cpu_info_ctrl: !hw.struct<index: !hw.struct<q: i4>, en: !hw.struct<q: i1>>, sw_rst_ctrl_n: !hw.array<8xstruct<q: i1>>, err_code: !hw.struct<fsm_err: !hw.struct<q: i1>, reset_consistency_err: !hw.struct<q: i1>, reg_intg_err: !hw.struct<q: i1>>>
    %sw_reset = hw.struct_extract %reset_info["sw_reset"] : !hw.struct<hw_req: !hw.struct<q: i5>, sw_reset: !hw.struct<q: i1>>
    %q_20 = hw.struct_extract %sw_reset["q"] : !hw.struct<q: i1>
    %420 = comb.or %419, %q_20 : i1
    llhd.drv %418, %420 after %0 : i1
    %421 = llhd.sig.struct_extract %417["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %421, %407 after %0 : i1
    %422 = llhd.sig.struct_extract %413["hw_req"] : <!hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>>
    %423 = llhd.sig.struct_extract %422["d"] : <!hw.struct<d: i5, de: i1>>
    %rstreqs = hw.struct_extract %pwr_i["rstreqs"] : !hw.struct<rst_lc_req: i2, rst_sys_req: i2, rstreqs: i5, reset_cause: i2>
    %hw_req = hw.struct_extract %reset_info["hw_req"] : !hw.struct<hw_req: !hw.struct<q: i5>, sw_reset: !hw.struct<q: i1>>
    %q_21 = hw.struct_extract %hw_req["q"] : !hw.struct<q: i5>
    %424 = comb.or %rstreqs, %q_21 : i5
    llhd.drv %423, %424 after %0 : i5
    %425 = llhd.sig.struct_extract %422["de"] : <!hw.struct<d: i5, de: i1>>
    llhd.drv %425, %407 after %0 : i1
    %426 = comb.or %407, %409 {sv.namehint = "dump_capture"} : i1
    %427 = llhd.sig.struct_extract %hw2reg["alert_info_ctrl"] : <!hw.struct<reset_req: !hw.struct<d: i4, de: i1>, reset_info: !hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>, alert_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, alert_info_attr: !hw.struct<d: i4>, alert_info: !hw.struct<d: i32>, cpu_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, cpu_info_attr: !hw.struct<d: i4>, cpu_info: !hw.struct<d: i32>, err_code: !hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>>
    %428 = llhd.sig.struct_extract %427["en"] : <!hw.struct<en: !hw.struct<d: i1, de: i1>>>
    %429 = llhd.sig.struct_extract %428["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %429, %false after %0 : i1
    %430 = llhd.sig.struct_extract %428["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %430, %407 after %0 : i1
    %431 = llhd.sig.struct_extract %hw2reg["cpu_info_ctrl"] : <!hw.struct<reset_req: !hw.struct<d: i4, de: i1>, reset_info: !hw.struct<hw_req: !hw.struct<d: i5, de: i1>, sw_reset: !hw.struct<d: i1, de: i1>, low_power_exit: !hw.struct<d: i1, de: i1>>, alert_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, alert_info_attr: !hw.struct<d: i4>, alert_info: !hw.struct<d: i32>, cpu_info_ctrl: !hw.struct<en: !hw.struct<d: i1, de: i1>>, cpu_info_attr: !hw.struct<d: i4>, cpu_info: !hw.struct<d: i32>, err_code: !hw.struct<fsm_err: !hw.struct<d: i1, de: i1>, reset_consistency_err: !hw.struct<d: i1, de: i1>, reg_intg_err: !hw.struct<d: i1, de: i1>>>>
    %432 = llhd.sig.struct_extract %431["en"] : <!hw.struct<en: !hw.struct<d: i1, de: i1>>>
    %433 = llhd.sig.struct_extract %432["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %433, %false after %0 : i1
    %434 = llhd.sig.struct_extract %432["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %434, %407 after %0 : i1
    %435 = llhd.prb %alert_tx_o : !hw.array<2xstruct<alert_p: i1, alert_n: i1>>
    %436 = llhd.prb %pwr_o : !hw.struct<rst_lc_src_n: i2, rst_sys_src_n: i2>
    %437 = llhd.prb %rst_en_o : !hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>
    %438 = llhd.prb %resets_o : !hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>
    hw.output %u_reg.tl_o, %435, %436, %q_19, %437, %438 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.array<2xstruct<alert_p: i1, alert_n: i1>>, !hw.struct<rst_lc_src_n: i2, rst_sys_src_n: i2>, i4, !hw.struct<por_aon: !hw.array<2xi4>, por: !hw.array<2xi4>, por_io: !hw.array<2xi4>, por_io_div2: !hw.array<2xi4>, por_io_div4: !hw.array<2xi4>, por_usb: !hw.array<2xi4>, lc_shadowed: !hw.array<2xi4>, lc: !hw.array<2xi4>, lc_aon: !hw.array<2xi4>, lc_io: !hw.array<2xi4>, lc_io_div2: !hw.array<2xi4>, lc_io_div4_shadowed: !hw.array<2xi4>, lc_io_div4: !hw.array<2xi4>, lc_usb: !hw.array<2xi4>, sys: !hw.array<2xi4>, sys_io_div4: !hw.array<2xi4>, spi_device: !hw.array<2xi4>, spi_host0: !hw.array<2xi4>, spi_host1: !hw.array<2xi4>, usb: !hw.array<2xi4>, usb_aon: !hw.array<2xi4>, i2c0: !hw.array<2xi4>, i2c1: !hw.array<2xi4>, i2c2: !hw.array<2xi4>>, !hw.struct<rst_por_aon_n: i2, rst_por_n: i2, rst_por_io_n: i2, rst_por_io_div2_n: i2, rst_por_io_div4_n: i2, rst_por_usb_n: i2, rst_lc_shadowed_n: i2, rst_lc_n: i2, rst_lc_aon_n: i2, rst_lc_io_n: i2, rst_lc_io_div2_n: i2, rst_lc_io_div4_shadowed_n: i2, rst_lc_io_div4_n: i2, rst_lc_usb_n: i2, rst_sys_n: i2, rst_sys_io_div4_n: i2, rst_spi_device_n: i2, rst_spi_host0_n: i2, rst_spi_host1_n: i2, rst_usb_n: i2, rst_usb_aon_n: i2, rst_i2c0_n: i2, rst_i2c1_n: i2, rst_i2c2_n: i2>
  }
}
