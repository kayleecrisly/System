module {
  hw.module private @prim_buf(in %in_i : i14, out out_o : i14) {
    hw.output %in_i : i14
  }
  hw.module private @prim_buf_22(in %in_i : i2, out out_o : i2) {
    hw.output %in_i : i2
  }
  hw.module private @prim_buf_24(in %in_i : i1, out out_o : i1) {
    hw.output %in_i : i1
  }
  hw.module private @prim_flop_2sync(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %d_i_0 = llhd.sig name "d_i" %false : i1
    %d_o = llhd.sig %false : i1
    %1 = llhd.prb %d_o : i1
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_0(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i1) -> (q_o: i1) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_0(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i1) -> (q_o: i1)
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
  hw.module private @prim_flop_2sync_11(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %d_i_0 = llhd.sig name "d_i" %c0_i4 : i4
    %d_o = llhd.sig %c0_i4 : i4
    %1 = llhd.prb %d_o : i4
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_26(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i4) -> (q_o: i4) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_26(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i4) -> (q_o: i4)
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
  hw.module private @prim_flop_2sync_12(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_o : i2) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %d_i_0 = llhd.sig name "d_i" %c0_i2 : i2
    %d_o = llhd.sig %c0_i2 : i2
    %1 = llhd.prb %d_o : i2
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i2) -> (q_o: i2) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i2) -> (q_o: i2)
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
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_27(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i1) -> (q_o: i1) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_27(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i1) -> (q_o: i1)
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
  hw.module private @prim_flop(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_o : i2) {
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
  hw.module private @prim_flop_0(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
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
  hw.module private @prim_flop_26(in %clk_i : i1, in %rst_ni : i1, in %d_i : i4, out q_o : i4) {
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
  hw.module private @prim_flop_27(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
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
    %u_prim_buf_in_req.out_o = hw.instance "u_prim_buf_in_req" @prim_sec_anchor_buf_10(in_i: %alert_req_i: i1) -> (out_o: i1) {sv.namehint = "alert_req"}
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
    %g_sync.u_sync.q_o = hw.instance "g_sync.u_sync" @prim_flop_2sync_12(clk_i: %2: i1, rst_ni: %3: i1, d_i: %d_i: i2) -> (q_o: i2)
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
  hw.module private @prim_intr_hw(in %clk_i : i1, in %rst_ni : i1, in %event_intr_i : i2, in %reg2hw_intr_enable_q_i : i2, in %reg2hw_intr_test_q_i : i2, in %reg2hw_intr_test_qe_i : i1, in %reg2hw_intr_state_q_i : i2, out hw2reg_intr_state_de_o : i1, out hw2reg_intr_state_d_o : i2, out intr_o : i2) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %reg2hw_intr_enable_q_i_2 = llhd.sig name "reg2hw_intr_enable_q_i" %c0_i2 : i2
    %intr_o = llhd.sig %c0_i2 : i2
    %status = llhd.sig %c0_i2 : i2
    %4 = comb.replicate %reg2hw_intr_test_qe_i : (i1) -> i2
    %5 = comb.and %4, %reg2hw_intr_test_q_i : i2
    %6 = comb.or %5, %event_intr_i {sv.namehint = "g_intr_event.new_event"} : i2
    %7 = comb.icmp ne %6, %c0_i2 : i2
    %8 = comb.or %6, %reg2hw_intr_state_q_i : i2
    llhd.drv %status, %reg2hw_intr_state_q_i after %1 : i2
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
      llhd.drv %intr_o, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %21 = llhd.prb %status : i2
      %22 = llhd.prb %reg2hw_intr_enable_q_i_2 : i2
      %23 = comb.and %21, %22 : i2
      llhd.drv %intr_o, %23 after %0 : i2
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %reg2hw_intr_enable_q_i_2, %reg2hw_intr_enable_q_i after %1 : i2
    %9 = llhd.prb %intr_o : i2
    hw.output %7, %8, %9 : i1, i2, i2
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
  hw.module private @prim_onehot_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i14, in %addr_i : i4, in %en_i : i1, out err_o : i1) {
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
    %238 = comb.extract %oh_i from 0 : (i14) -> i1
    llhd.drv %237, %238 after %0 : i1
    %239 = llhd.sig.extract %and_tree from %c15_i5 : <i31> -> <i1>
    llhd.drv %239, %238 after %0 : i1
    %240 = llhd.sig.extract %err_tree from %c15_i5 : <i31> -> <i1>
    llhd.drv %240, %false after %0 : i1
    %241 = llhd.sig.extract %or_tree from %c-16_i5 : <i31> -> <i1>
    %242 = comb.extract %oh_i from 1 : (i14) -> i1
    llhd.drv %241, %242 after %0 : i1
    %243 = llhd.sig.extract %and_tree from %c-16_i5 : <i31> -> <i1>
    llhd.drv %243, %242 after %0 : i1
    %244 = llhd.sig.extract %err_tree from %c-16_i5 : <i31> -> <i1>
    llhd.drv %244, %false after %0 : i1
    %245 = llhd.sig.extract %or_tree from %c-15_i5 : <i31> -> <i1>
    %246 = comb.extract %oh_i from 2 : (i14) -> i1
    llhd.drv %245, %246 after %0 : i1
    %247 = llhd.sig.extract %and_tree from %c-15_i5 : <i31> -> <i1>
    llhd.drv %247, %246 after %0 : i1
    %248 = llhd.sig.extract %err_tree from %c-15_i5 : <i31> -> <i1>
    llhd.drv %248, %false after %0 : i1
    %249 = llhd.sig.extract %or_tree from %c-14_i5 : <i31> -> <i1>
    %250 = comb.extract %oh_i from 3 : (i14) -> i1
    llhd.drv %249, %250 after %0 : i1
    %251 = llhd.sig.extract %and_tree from %c-14_i5 : <i31> -> <i1>
    llhd.drv %251, %250 after %0 : i1
    %252 = llhd.sig.extract %err_tree from %c-14_i5 : <i31> -> <i1>
    llhd.drv %252, %false after %0 : i1
    %253 = llhd.sig.extract %or_tree from %c-13_i5 : <i31> -> <i1>
    %254 = comb.extract %oh_i from 4 : (i14) -> i1
    llhd.drv %253, %254 after %0 : i1
    %255 = llhd.sig.extract %and_tree from %c-13_i5 : <i31> -> <i1>
    llhd.drv %255, %254 after %0 : i1
    %256 = llhd.sig.extract %err_tree from %c-13_i5 : <i31> -> <i1>
    llhd.drv %256, %false after %0 : i1
    %257 = llhd.sig.extract %or_tree from %c-12_i5 : <i31> -> <i1>
    %258 = comb.extract %oh_i from 5 : (i14) -> i1
    llhd.drv %257, %258 after %0 : i1
    %259 = llhd.sig.extract %and_tree from %c-12_i5 : <i31> -> <i1>
    llhd.drv %259, %258 after %0 : i1
    %260 = llhd.sig.extract %err_tree from %c-12_i5 : <i31> -> <i1>
    llhd.drv %260, %false after %0 : i1
    %261 = llhd.sig.extract %or_tree from %c-11_i5 : <i31> -> <i1>
    %262 = comb.extract %oh_i from 6 : (i14) -> i1
    llhd.drv %261, %262 after %0 : i1
    %263 = llhd.sig.extract %and_tree from %c-11_i5 : <i31> -> <i1>
    llhd.drv %263, %262 after %0 : i1
    %264 = llhd.sig.extract %err_tree from %c-11_i5 : <i31> -> <i1>
    llhd.drv %264, %false after %0 : i1
    %265 = llhd.sig.extract %or_tree from %c-10_i5 : <i31> -> <i1>
    %266 = comb.extract %oh_i from 7 : (i14) -> i1
    llhd.drv %265, %266 after %0 : i1
    %267 = llhd.sig.extract %and_tree from %c-10_i5 : <i31> -> <i1>
    llhd.drv %267, %266 after %0 : i1
    %268 = llhd.sig.extract %err_tree from %c-10_i5 : <i31> -> <i1>
    llhd.drv %268, %false after %0 : i1
    %269 = llhd.sig.extract %or_tree from %c-9_i5 : <i31> -> <i1>
    %270 = comb.extract %oh_i from 8 : (i14) -> i1
    llhd.drv %269, %270 after %0 : i1
    %271 = llhd.sig.extract %and_tree from %c-9_i5 : <i31> -> <i1>
    llhd.drv %271, %270 after %0 : i1
    %272 = llhd.sig.extract %err_tree from %c-9_i5 : <i31> -> <i1>
    llhd.drv %272, %false after %0 : i1
    %273 = llhd.sig.extract %or_tree from %c-8_i5 : <i31> -> <i1>
    %274 = comb.extract %oh_i from 9 : (i14) -> i1
    llhd.drv %273, %274 after %0 : i1
    %275 = llhd.sig.extract %and_tree from %c-8_i5 : <i31> -> <i1>
    llhd.drv %275, %274 after %0 : i1
    %276 = llhd.sig.extract %err_tree from %c-8_i5 : <i31> -> <i1>
    llhd.drv %276, %false after %0 : i1
    %277 = llhd.sig.extract %or_tree from %c-7_i5 : <i31> -> <i1>
    %278 = comb.extract %oh_i from 10 : (i14) -> i1
    llhd.drv %277, %278 after %0 : i1
    %279 = llhd.sig.extract %and_tree from %c-7_i5 : <i31> -> <i1>
    llhd.drv %279, %278 after %0 : i1
    %280 = llhd.sig.extract %err_tree from %c-7_i5 : <i31> -> <i1>
    llhd.drv %280, %false after %0 : i1
    %281 = llhd.sig.extract %or_tree from %c-6_i5 : <i31> -> <i1>
    %282 = comb.extract %oh_i from 11 : (i14) -> i1
    llhd.drv %281, %282 after %0 : i1
    %283 = llhd.sig.extract %and_tree from %c-6_i5 : <i31> -> <i1>
    llhd.drv %283, %282 after %0 : i1
    %284 = llhd.sig.extract %err_tree from %c-6_i5 : <i31> -> <i1>
    llhd.drv %284, %false after %0 : i1
    %285 = llhd.sig.extract %or_tree from %c-5_i5 : <i31> -> <i1>
    %286 = comb.extract %oh_i from 12 : (i14) -> i1
    llhd.drv %285, %286 after %0 : i1
    %287 = llhd.sig.extract %and_tree from %c-5_i5 : <i31> -> <i1>
    llhd.drv %287, %286 after %0 : i1
    %288 = llhd.sig.extract %err_tree from %c-5_i5 : <i31> -> <i1>
    llhd.drv %288, %false after %0 : i1
    %289 = llhd.sig.extract %or_tree from %c-4_i5 : <i31> -> <i1>
    %290 = comb.extract %oh_i from 13 : (i14) -> i1
    llhd.drv %289, %290 after %0 : i1
    %291 = llhd.sig.extract %and_tree from %c-4_i5 : <i31> -> <i1>
    llhd.drv %291, %290 after %0 : i1
    %292 = llhd.sig.extract %err_tree from %c-4_i5 : <i31> -> <i1>
    llhd.drv %292, %false after %0 : i1
    %293 = llhd.sig.extract %or_tree from %c-3_i5 : <i31> -> <i1>
    llhd.drv %293, %false after %0 : i1
    %294 = llhd.sig.extract %and_tree from %c-3_i5 : <i31> -> <i1>
    llhd.drv %294, %false after %0 : i1
    %295 = llhd.sig.extract %err_tree from %c-3_i5 : <i31> -> <i1>
    llhd.drv %295, %false after %0 : i1
    %296 = llhd.sig.extract %or_tree from %c-2_i5 : <i31> -> <i1>
    llhd.drv %296, %false after %0 : i1
    %297 = llhd.sig.extract %and_tree from %c-2_i5 : <i31> -> <i1>
    llhd.drv %297, %false after %0 : i1
    %298 = llhd.sig.extract %err_tree from %c-2_i5 : <i31> -> <i1>
    llhd.drv %298, %false after %0 : i1
    %299 = comb.or %300, %303 : i1
    %300 = comb.extract %17 from 0 {sv.namehint = "oh0_err"} : (i31) -> i1
    %301 = comb.xor %en_i, %true : i1
    %302 = comb.extract %2 from 0 : (i31) -> i1
    %303 = comb.and %301, %302 {sv.namehint = "enable_err"} : i1
    hw.output %299 : i1
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
  hw.module private @prim_reg_cdc_arb(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, out src_ack_o : i1, out src_update_o : i1, in %dst_req_i : i1, out dst_req_o : i1, in %dst_update_i : i1, in %dst_ds_i : i13, in %dst_qs_i : i13, out dst_qs_o : i13) {
    %false = hw.constant false
    %gen_passthru.u_dst_to_src_ack.dst_pulse_o = hw.instance "gen_passthru.u_dst_to_src_ack" @prim_pulse_sync(clk_src_i: %clk_dst_i: i1, rst_src_ni: %rst_dst_ni: i1, src_pulse_i: %dst_req_i: i1, clk_dst_i: %clk_src_i: i1, rst_dst_ni: %rst_src_ni: i1) -> (dst_pulse_o: i1)
    hw.output %gen_passthru.u_dst_to_src_ack.dst_pulse_o, %false, %dst_req_i, %dst_qs_i : i1, i1, i1, i13
  }
  hw.module private @prim_reg_cdc_arb_14(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, out src_ack_o : i1, out src_update_o : i1, in %dst_req_i : i1, out dst_req_o : i1, in %dst_update_i : i1, in %dst_ds_i : i32, in %dst_qs_i : i32, out dst_qs_o : i32) {
    %false = hw.constant false
    %gen_passthru.u_dst_to_src_ack.dst_pulse_o = hw.instance "gen_passthru.u_dst_to_src_ack" @prim_pulse_sync(clk_src_i: %clk_dst_i: i1, rst_src_ni: %rst_dst_ni: i1, src_pulse_i: %dst_req_i: i1, clk_dst_i: %clk_src_i: i1, rst_dst_ni: %rst_src_ni: i1) -> (dst_pulse_o: i1)
    hw.output %gen_passthru.u_dst_to_src_ack.dst_pulse_o, %false, %dst_req_i, %dst_qs_i : i1, i1, i1, i32
  }
  hw.module private @prim_reg_cdc_arb_15(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, out src_ack_o : i1, out src_update_o : i1, in %dst_req_i : i1, out dst_req_o : i1, in %dst_update_i : i1, in %dst_ds_i : i32, in %dst_qs_i : i32, out dst_qs_o : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false
    %true = hw.constant true
    %clk_dst_i_0 = llhd.sig name "clk_dst_i" %false : i1
    %2 = llhd.prb %clk_dst_i_0 : i1
    %rst_dst_ni_1 = llhd.sig name "rst_dst_ni" %false : i1
    %3 = llhd.prb %rst_dst_ni_1 : i1
    %dst_req_i_2 = llhd.sig name "dst_req_i" %false : i1
    %dst_ds_i_3 = llhd.sig name "dst_ds_i" %c0_i32 : i32
    %dst_qs_i_4 = llhd.sig name "dst_qs_i" %c0_i32 : i32
    %dst_qs_o = llhd.sig %c0_i32 : i32
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
    %4 = llhd.prb %dst_qs_o : i32
    %5 = llhd.prb %dst_ds_i_3 : i32
    %6 = comb.icmp ne %4, %5 : i32
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
      llhd.drv %dst_qs_o, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %37 = llhd.prb %gen_wr_req.dst_lat_d : i1
      cf.cond_br %37, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %38 = llhd.prb %dst_ds_i_3 : i32
      llhd.drv %dst_qs_o, %38 after %0 : i32
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %39 = llhd.prb %gen_wr_req.dst_lat_q : i1
      cf.cond_br %39, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %40 = llhd.prb %dst_qs_i_4 : i32
      llhd.drv %dst_qs_o, %40 after %0 : i32
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
    %19 = llhd.prb %dst_qs_i_4 : i32
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
      %30 = llhd.prb %dst_qs_o : i32
      %31 = llhd.prb %dst_qs_i_4 : i32
      %32 = comb.icmp ne %30, %31 : i32
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
      llhd.wait (%11, %14, %15, %16, %17, %12, %18, %4, %19, %20 : i1, i1, i1, i1, i1, i1, i1, i32, i32, i1), ^bb1
    }
    %21 = comb.or %15, %17, %16 {sv.namehint = "gen_wr_req.dst_update_req"} : i1
    %22 = llhd.prb %gen_wr_req.id_q : i1
    %23 = comb.xor %22, %true : i1
    %24 = comb.and %gen_wr_req.u_dst_update_sync.dst_req_o, %23 : i1
    %25 = comb.and %gen_wr_req.u_dst_update_sync.dst_req_o, %22 : i1
    llhd.drv %clk_dst_i_0, %clk_dst_i after %1 : i1
    llhd.drv %rst_dst_ni_1, %rst_dst_ni after %1 : i1
    llhd.drv %dst_req_i_2, %dst_req_i after %1 : i1
    llhd.drv %dst_ds_i_3, %dst_ds_i after %1 : i32
    llhd.drv %dst_qs_i_4, %dst_qs_i after %1 : i32
    hw.output %24, %25, %13, %4 : i1, i1, i1, i32
  }
  hw.module private @prim_reg_cdc_arb_16(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, out src_ack_o : i1, out src_update_o : i1, in %dst_req_i : i1, out dst_req_o : i1, in %dst_update_i : i1, in %dst_ds_i : i2, in %dst_qs_i : i2, out dst_qs_o : i2) {
    %false = hw.constant false
    %gen_passthru.u_dst_to_src_ack.dst_pulse_o = hw.instance "gen_passthru.u_dst_to_src_ack" @prim_pulse_sync(clk_src_i: %clk_dst_i: i1, rst_src_ni: %rst_dst_ni: i1, src_pulse_i: %dst_req_i: i1, clk_dst_i: %clk_src_i: i1, rst_dst_ni: %rst_src_ni: i1) -> (dst_pulse_o: i1)
    hw.output %gen_passthru.u_dst_to_src_ack.dst_pulse_o, %false, %dst_req_i, %dst_qs_i : i1, i1, i1, i2
  }
  hw.module private @prim_reg_cdc_arb_17(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, out src_ack_o : i1, out src_update_o : i1, in %dst_req_i : i1, out dst_req_o : i1, in %dst_update_i : i1, in %dst_ds_i : i1, in %dst_qs_i : i1, out dst_qs_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %true = hw.constant true
    %clk_dst_i_0 = llhd.sig name "clk_dst_i" %false : i1
    %2 = llhd.prb %clk_dst_i_0 : i1
    %rst_dst_ni_1 = llhd.sig name "rst_dst_ni" %false : i1
    %3 = llhd.prb %rst_dst_ni_1 : i1
    %dst_req_i_2 = llhd.sig name "dst_req_i" %false : i1
    %dst_ds_i_3 = llhd.sig name "dst_ds_i" %false : i1
    %dst_qs_i_4 = llhd.sig name "dst_qs_i" %false : i1
    %dst_qs_o = llhd.sig %false : i1
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
    %4 = llhd.prb %dst_qs_o : i1
    %5 = llhd.prb %dst_ds_i_3 : i1
    %6 = comb.icmp ne %4, %5 : i1
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
      llhd.drv %dst_qs_o, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %37 = llhd.prb %gen_wr_req.dst_lat_d : i1
      cf.cond_br %37, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %38 = llhd.prb %dst_ds_i_3 : i1
      llhd.drv %dst_qs_o, %38 after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %39 = llhd.prb %gen_wr_req.dst_lat_q : i1
      cf.cond_br %39, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %40 = llhd.prb %dst_qs_i_4 : i1
      llhd.drv %dst_qs_o, %40 after %0 : i1
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
    %19 = llhd.prb %dst_qs_i_4 : i1
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
      %30 = llhd.prb %dst_qs_o : i1
      %31 = llhd.prb %dst_qs_i_4 : i1
      %32 = comb.icmp ne %30, %31 : i1
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
      llhd.wait (%11, %14, %15, %16, %17, %12, %18, %4, %19, %20 : i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    %21 = comb.or %15, %17, %16 {sv.namehint = "gen_wr_req.dst_update_req"} : i1
    %22 = llhd.prb %gen_wr_req.id_q : i1
    %23 = comb.xor %22, %true : i1
    %24 = comb.and %gen_wr_req.u_dst_update_sync.dst_req_o, %23 : i1
    %25 = comb.and %gen_wr_req.u_dst_update_sync.dst_req_o, %22 : i1
    llhd.drv %clk_dst_i_0, %clk_dst_i after %1 : i1
    llhd.drv %rst_dst_ni_1, %rst_dst_ni after %1 : i1
    llhd.drv %dst_req_i_2, %dst_req_i after %1 : i1
    llhd.drv %dst_ds_i_3, %dst_ds_i after %1 : i1
    llhd.drv %dst_qs_i_4, %dst_qs_i after %1 : i1
    hw.output %24, %25, %13, %4 : i1, i1, i1, i1
  }
  hw.module private @prim_reg_cdc(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, in %src_regwen_i : i1, in %src_we_i : i1, in %src_re_i : i1, in %src_wd_i : i13, out src_busy_o : i1, out src_qs_o : i13, in %dst_ds_i : i13, in %dst_qs_i : i13, in %dst_update_i : i1, out dst_we_o : i1, out dst_re_o : i1, out dst_regwen_o : i1, out dst_wd_o : i13) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i3 = hw.constant 0 : i3
    %c0_i13 = hw.constant 0 : i13
    %true = hw.constant true
    %false = hw.constant false
    %clk_src_i_0 = llhd.sig name "clk_src_i" %false : i1
    %2 = llhd.prb %clk_src_i_0 : i1
    %rst_src_ni_1 = llhd.sig name "rst_src_ni" %false : i1
    %3 = llhd.prb %rst_src_ni_1 : i1
    %src_regwen_i_2 = llhd.sig name "src_regwen_i" %false : i1
    %src_we_i_3 = llhd.sig name "src_we_i" %false : i1
    %src_re_i_4 = llhd.sig name "src_re_i" %false : i1
    %src_wd_i_5 = llhd.sig name "src_wd_i" %c0_i13 : i13
    %src_ack = llhd.sig %false : i1
    %src_busy_q = llhd.sig %false : i1
    %src_q = llhd.sig %c0_i13 : i13
    %txn_bits_q = llhd.sig %c0_i3 : i3
    %src_req = llhd.sig %false : i1
    %dst_qs = llhd.sig %c0_i13 : i13
    %dst_to_src = llhd.sig %false : i1
    %4 = llhd.prb %src_req : i1
    %u_src_to_dst_req.dst_pulse_o = hw.instance "u_src_to_dst_req" @prim_pulse_sync(clk_src_i: %2: i1, rst_src_ni: %3: i1, src_pulse_i: %4: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1) -> (dst_pulse_o: i1) {sv.namehint = "dst_req_from_src"}
    %u_arb.src_ack_o, %u_arb.src_update_o, %u_arb.dst_req_o, %u_arb.dst_qs_o = hw.instance "u_arb" @prim_reg_cdc_arb(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1, dst_req_i: %u_src_to_dst_req.dst_pulse_o: i1, dst_update_i: %dst_update_i: i1, dst_ds_i: %dst_ds_i: i13, dst_qs_i: %dst_qs_i: i13) -> (src_ack_o: i1, src_update_o: i1, dst_req_o: i1, dst_qs_o: i13) {sv.namehint = "dst_req"}
    llhd.drv %src_ack, %u_arb.src_ack_o after %1 : i1
    llhd.drv %dst_qs, %u_arb.dst_qs_o after %1 : i13
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
      llhd.drv %src_q, %c0_i13 after %0 : i13
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %29 = llhd.prb %src_req : i1
      cf.cond_br %29, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %30 = llhd.prb %src_wd_i_5 : i13
      llhd.drv %src_q, %30 after %0 : i13
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
      %36 = llhd.prb %dst_qs : i13
      llhd.drv %src_q, %36 after %0 : i13
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    }
    %11 = llhd.prb %src_q : i13
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
    llhd.drv %src_wd_i_5, %src_wd_i after %1 : i13
    hw.output %8, %11, %15, %16, %17, %11 : i1, i13, i1, i1, i1, i13
  }
  hw.module private @prim_reg_cdc_1(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, in %src_regwen_i : i1, in %src_we_i : i1, in %src_re_i : i1, in %src_wd_i : i32, out src_busy_o : i1, out src_qs_o : i32, in %dst_ds_i : i32, in %dst_qs_i : i32, in %dst_update_i : i1, out dst_we_o : i1, out dst_re_o : i1, out dst_regwen_o : i1, out dst_wd_o : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i3 = hw.constant 0 : i3
    %c0_i32 = hw.constant 0 : i32
    %true = hw.constant true
    %false = hw.constant false
    %clk_src_i_0 = llhd.sig name "clk_src_i" %false : i1
    %2 = llhd.prb %clk_src_i_0 : i1
    %rst_src_ni_1 = llhd.sig name "rst_src_ni" %false : i1
    %3 = llhd.prb %rst_src_ni_1 : i1
    %src_regwen_i_2 = llhd.sig name "src_regwen_i" %false : i1
    %src_we_i_3 = llhd.sig name "src_we_i" %false : i1
    %src_re_i_4 = llhd.sig name "src_re_i" %false : i1
    %src_wd_i_5 = llhd.sig name "src_wd_i" %c0_i32 : i32
    %src_ack = llhd.sig %false : i1
    %src_busy_q = llhd.sig %false : i1
    %src_q = llhd.sig %c0_i32 : i32
    %txn_bits_q = llhd.sig %c0_i3 : i3
    %src_req = llhd.sig %false : i1
    %dst_qs = llhd.sig %c0_i32 : i32
    %dst_to_src = llhd.sig %false : i1
    %4 = llhd.prb %src_req : i1
    %u_src_to_dst_req.dst_pulse_o = hw.instance "u_src_to_dst_req" @prim_pulse_sync(clk_src_i: %2: i1, rst_src_ni: %3: i1, src_pulse_i: %4: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1) -> (dst_pulse_o: i1) {sv.namehint = "dst_req_from_src"}
    %u_arb.src_ack_o, %u_arb.src_update_o, %u_arb.dst_req_o, %u_arb.dst_qs_o = hw.instance "u_arb" @prim_reg_cdc_arb_14(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1, dst_req_i: %u_src_to_dst_req.dst_pulse_o: i1, dst_update_i: %dst_update_i: i1, dst_ds_i: %dst_ds_i: i32, dst_qs_i: %dst_qs_i: i32) -> (src_ack_o: i1, src_update_o: i1, dst_req_o: i1, dst_qs_o: i32) {sv.namehint = "dst_req"}
    llhd.drv %src_ack, %u_arb.src_ack_o after %1 : i1
    llhd.drv %dst_qs, %u_arb.dst_qs_o after %1 : i32
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
      llhd.drv %src_q, %c0_i32 after %0 : i32
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %29 = llhd.prb %src_req : i1
      cf.cond_br %29, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %30 = llhd.prb %src_wd_i_5 : i32
      llhd.drv %src_q, %30 after %0 : i32
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
      %36 = llhd.prb %dst_qs : i32
      llhd.drv %src_q, %36 after %0 : i32
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    }
    %11 = llhd.prb %src_q : i32
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
    llhd.drv %src_wd_i_5, %src_wd_i after %1 : i32
    hw.output %8, %11, %15, %16, %17, %11 : i1, i32, i1, i1, i1, i32
  }
  hw.module private @prim_reg_cdc_2(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, in %src_regwen_i : i1, in %src_we_i : i1, in %src_re_i : i1, in %src_wd_i : i32, out src_busy_o : i1, out src_qs_o : i32, in %dst_ds_i : i32, in %dst_qs_i : i32, in %dst_update_i : i1, out dst_we_o : i1, out dst_re_o : i1, out dst_regwen_o : i1, out dst_wd_o : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i3 = hw.constant 0 : i3
    %c0_i32 = hw.constant 0 : i32
    %true = hw.constant true
    %false = hw.constant false
    %clk_src_i_0 = llhd.sig name "clk_src_i" %false : i1
    %2 = llhd.prb %clk_src_i_0 : i1
    %rst_src_ni_1 = llhd.sig name "rst_src_ni" %false : i1
    %3 = llhd.prb %rst_src_ni_1 : i1
    %src_regwen_i_2 = llhd.sig name "src_regwen_i" %false : i1
    %src_we_i_3 = llhd.sig name "src_we_i" %false : i1
    %src_re_i_4 = llhd.sig name "src_re_i" %false : i1
    %src_wd_i_5 = llhd.sig name "src_wd_i" %c0_i32 : i32
    %src_ack = llhd.sig %false : i1
    %src_busy_q = llhd.sig %false : i1
    %src_q = llhd.sig %c0_i32 : i32
    %txn_bits_q = llhd.sig %c0_i3 : i3
    %src_req = llhd.sig %false : i1
    %dst_qs = llhd.sig %c0_i32 : i32
    %dst_to_src = llhd.sig %false : i1
    %4 = llhd.prb %src_req : i1
    %u_src_to_dst_req.dst_pulse_o = hw.instance "u_src_to_dst_req" @prim_pulse_sync(clk_src_i: %2: i1, rst_src_ni: %3: i1, src_pulse_i: %4: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1) -> (dst_pulse_o: i1) {sv.namehint = "dst_req_from_src"}
    %u_arb.src_ack_o, %u_arb.src_update_o, %u_arb.dst_req_o, %u_arb.dst_qs_o = hw.instance "u_arb" @prim_reg_cdc_arb_15(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1, dst_req_i: %u_src_to_dst_req.dst_pulse_o: i1, dst_update_i: %dst_update_i: i1, dst_ds_i: %dst_ds_i: i32, dst_qs_i: %dst_qs_i: i32) -> (src_ack_o: i1, src_update_o: i1, dst_req_o: i1, dst_qs_o: i32) {sv.namehint = "dst_req"}
    llhd.drv %src_ack, %u_arb.src_ack_o after %1 : i1
    llhd.drv %dst_qs, %u_arb.dst_qs_o after %1 : i32
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
      llhd.drv %src_q, %c0_i32 after %0 : i32
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %34 = llhd.prb %src_req : i1
      cf.cond_br %34, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %35 = llhd.prb %src_wd_i_5 : i32
      llhd.drv %src_q, %35 after %0 : i32
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
      %41 = llhd.prb %dst_qs : i32
      llhd.drv %src_q, %41 after %0 : i32
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    }
    %16 = llhd.prb %src_q : i32
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
    llhd.drv %src_wd_i_5, %src_wd_i after %1 : i32
    hw.output %8, %16, %20, %21, %22, %16 : i1, i32, i1, i1, i1, i32
  }
  hw.module private @prim_reg_cdc_3(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, in %src_regwen_i : i1, in %src_we_i : i1, in %src_re_i : i1, in %src_wd_i : i2, out src_busy_o : i1, out src_qs_o : i2, in %dst_ds_i : i2, in %dst_qs_i : i2, in %dst_update_i : i1, out dst_we_o : i1, out dst_re_o : i1, out dst_regwen_o : i1, out dst_wd_o : i2) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i3 = hw.constant 0 : i3
    %c0_i2 = hw.constant 0 : i2
    %true = hw.constant true
    %false = hw.constant false
    %clk_src_i_0 = llhd.sig name "clk_src_i" %false : i1
    %2 = llhd.prb %clk_src_i_0 : i1
    %rst_src_ni_1 = llhd.sig name "rst_src_ni" %false : i1
    %3 = llhd.prb %rst_src_ni_1 : i1
    %src_regwen_i_2 = llhd.sig name "src_regwen_i" %false : i1
    %src_we_i_3 = llhd.sig name "src_we_i" %false : i1
    %src_re_i_4 = llhd.sig name "src_re_i" %false : i1
    %src_wd_i_5 = llhd.sig name "src_wd_i" %c0_i2 : i2
    %src_ack = llhd.sig %false : i1
    %src_busy_q = llhd.sig %false : i1
    %src_q = llhd.sig %c0_i2 : i2
    %txn_bits_q = llhd.sig %c0_i3 : i3
    %src_req = llhd.sig %false : i1
    %dst_qs = llhd.sig %c0_i2 : i2
    %dst_to_src = llhd.sig %false : i1
    %4 = llhd.prb %src_req : i1
    %u_src_to_dst_req.dst_pulse_o = hw.instance "u_src_to_dst_req" @prim_pulse_sync(clk_src_i: %2: i1, rst_src_ni: %3: i1, src_pulse_i: %4: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1) -> (dst_pulse_o: i1) {sv.namehint = "dst_req_from_src"}
    %u_arb.src_ack_o, %u_arb.src_update_o, %u_arb.dst_req_o, %u_arb.dst_qs_o = hw.instance "u_arb" @prim_reg_cdc_arb_16(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1, dst_req_i: %u_src_to_dst_req.dst_pulse_o: i1, dst_update_i: %dst_update_i: i1, dst_ds_i: %dst_ds_i: i2, dst_qs_i: %dst_qs_i: i2) -> (src_ack_o: i1, src_update_o: i1, dst_req_o: i1, dst_qs_o: i2) {sv.namehint = "dst_req"}
    llhd.drv %src_ack, %u_arb.src_ack_o after %1 : i1
    llhd.drv %dst_qs, %u_arb.dst_qs_o after %1 : i2
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
      llhd.drv %src_q, %c0_i2 after %0 : i2
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %29 = llhd.prb %src_req : i1
      cf.cond_br %29, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %30 = llhd.prb %src_wd_i_5 : i2
      llhd.drv %src_q, %30 after %0 : i2
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
      %36 = llhd.prb %dst_qs : i2
      llhd.drv %src_q, %36 after %0 : i2
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    }
    %11 = llhd.prb %src_q : i2
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
    llhd.drv %src_wd_i_5, %src_wd_i after %1 : i2
    hw.output %8, %11, %15, %16, %17, %11 : i1, i2, i1, i1, i1, i2
  }
  hw.module private @prim_reg_cdc_4(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, in %src_regwen_i : i1, in %src_we_i : i1, in %src_re_i : i1, in %src_wd_i : i1, out src_busy_o : i1, out src_qs_o : i1, in %dst_ds_i : i1, in %dst_qs_i : i1, in %dst_update_i : i1, out dst_we_o : i1, out dst_re_o : i1, out dst_regwen_o : i1, out dst_wd_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i3 = hw.constant 0 : i3
    %true = hw.constant true
    %false = hw.constant false
    %clk_src_i_0 = llhd.sig name "clk_src_i" %false : i1
    %2 = llhd.prb %clk_src_i_0 : i1
    %rst_src_ni_1 = llhd.sig name "rst_src_ni" %false : i1
    %3 = llhd.prb %rst_src_ni_1 : i1
    %src_regwen_i_2 = llhd.sig name "src_regwen_i" %false : i1
    %src_we_i_3 = llhd.sig name "src_we_i" %false : i1
    %src_re_i_4 = llhd.sig name "src_re_i" %false : i1
    %src_wd_i_5 = llhd.sig name "src_wd_i" %false : i1
    %src_ack = llhd.sig %false : i1
    %src_busy_q = llhd.sig %false : i1
    %src_q = llhd.sig %false : i1
    %txn_bits_q = llhd.sig %c0_i3 : i3
    %src_req = llhd.sig %false : i1
    %dst_qs = llhd.sig %false : i1
    %dst_to_src = llhd.sig %false : i1
    %4 = llhd.prb %src_req : i1
    %u_src_to_dst_req.dst_pulse_o = hw.instance "u_src_to_dst_req" @prim_pulse_sync(clk_src_i: %2: i1, rst_src_ni: %3: i1, src_pulse_i: %4: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1) -> (dst_pulse_o: i1) {sv.namehint = "dst_req_from_src"}
    %u_arb.src_ack_o, %u_arb.src_update_o, %u_arb.dst_req_o, %u_arb.dst_qs_o = hw.instance "u_arb" @prim_reg_cdc_arb_17(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1, dst_req_i: %u_src_to_dst_req.dst_pulse_o: i1, dst_update_i: %dst_update_i: i1, dst_ds_i: %dst_ds_i: i1, dst_qs_i: %dst_qs_i: i1) -> (src_ack_o: i1, src_update_o: i1, dst_req_o: i1, dst_qs_o: i1) {sv.namehint = "dst_req"}
    llhd.drv %src_ack, %u_arb.src_ack_o after %1 : i1
    llhd.drv %dst_qs, %u_arb.dst_qs_o after %1 : i1
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
      llhd.drv %src_q, %false after %0 : i1
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %34 = llhd.prb %src_req : i1
      cf.cond_br %34, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %35 = llhd.prb %src_wd_i_5 : i1
      llhd.drv %src_q, %35 after %0 : i1
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
      %41 = llhd.prb %dst_qs : i1
      llhd.drv %src_q, %41 after %0 : i1
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    }
    %16 = llhd.prb %src_q : i1
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
    llhd.drv %src_wd_i_5, %src_wd_i after %1 : i1
    hw.output %8, %16, %20, %21, %22, %16 : i1, i1, i1, i1, i1, i1
  }
  hw.module private @prim_reg_we_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i14, in %en_i : i1, out err_o : i1) {
    %c0_i4 = hw.constant 0 : i4
    %u_prim_buf.out_o = hw.instance "u_prim_buf" @prim_buf(in_i: %oh_i: i14) -> (out_o: i14) {sv.namehint = "oh_buf"}
    %u_prim_onehot_check.err_o = hw.instance "u_prim_onehot_check" @prim_onehot_check(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, oh_i: %u_prim_buf.out_o: i14, addr_i: %c0_i4: i4, en_i: %en_i: i1) -> (err_o: i1)
    hw.output %u_prim_onehot_check.err_o : i1
  }
  hw.module private @prim_sec_anchor_buf(in %in_i : i2, out out_o : i2) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf_22(in_i: %in_i: i2) -> (out_o: i2)
    hw.output %u_secure_anchor_buf.out_o : i2
  }
  hw.module private @prim_sec_anchor_buf_10(in %in_i : i1, out out_o : i1) {
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
  hw.module private @prim_subreg_arb_18(in %we : i1, in %wd : i12, in %de : i1, in %d : i12, in %q : i12, out wr_en : i1, out wr_data : i12) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i12 = hw.constant 0 : i12
    %wd_0 = llhd.sig name "wd" %c0_i12 : i12
    %d_1 = llhd.sig name "d" %c0_i12 : i12
    %1 = comb.or %we, %de : i1
    %2 = llhd.prb %wd_0 : i12
    %3 = llhd.prb %d_1 : i12
    %4 = comb.mux %we, %2, %3 : i12
    llhd.drv %wd_0, %wd after %0 : i12
    llhd.drv %d_1, %d after %0 : i12
    hw.output %1, %4 : i1, i12
  }
  hw.module private @prim_subreg_arb_19(in %we : i1, in %wd : i32, in %de : i1, in %d : i32, in %q : i32, out wr_en : i1, out wr_data : i32) {
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
  hw.module private @prim_subreg_5(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i12, in %de : i1, in %d : i12, out qe : i1, out q : i12, out ds : i12, out qs : i12) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i12 = hw.constant 0 : i12
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %q = llhd.sig %c0_i12 : i12
    %qs = llhd.sig %c0_i12 : i12
    %wr_en = llhd.sig %false : i1
    %wr_data = llhd.sig %c0_i12 : i12
    %4 = llhd.prb %q : i12
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_18(we: %we: i1, wd: %wd: i12, de: %de: i1, d: %d: i12, q: %4: i12) -> (wr_en: i1, wr_data: i12)
    llhd.drv %wr_en, %wr_en_data_arb.wr_en after %1 : i1
    llhd.drv %wr_data, %wr_en_data_arb.wr_data after %1 : i12
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
      llhd.drv %q, %c0_i12 after %0 : i12
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %20 = llhd.prb %wr_en : i1
      cf.cond_br %20, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %21 = llhd.prb %wr_data : i12
      llhd.drv %q, %21 after %0 : i12
      cf.br ^bb1
    }
    %5 = llhd.prb %wr_en : i1
    %6 = llhd.prb %wr_data : i12
    %7 = llhd.prb %qs : i12
    %8 = comb.mux %5, %6, %7 : i12
    llhd.drv %qs, %4 after %1 : i12
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    hw.output %we, %4, %8, %7 : i1, i12, i12, i12
  }
  hw.module private @prim_subreg_6(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_19(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
  func.func private @"lc_ctrl_pkg::lc_tx_test_false_strict"(%arg0: i4) -> i1 {
    %c-6_i4 = hw.constant -6 : i4
    %0 = comb.icmp eq %arg0, %c-6_i4 : i4
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
    %gen_flops.u_prim_flop_2sync.q_o = hw.instance "gen_flops.u_prim_flop_2sync" @prim_flop_2sync_11(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %lc_en_i: i4) -> (q_o: i4) {sv.namehint = "lc_en"}
    %2 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 0 : (i4) -> i1
    %3 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf_10(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %3, %gen_buffs_0.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %4 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 1 : (i4) -> i1
    %5 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf_10(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %5, %gen_buffs_0.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %6 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 2 : (i4) -> i1
    %7 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf_10(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %7, %gen_buffs_0.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %8 = comb.extract %gen_flops.u_prim_flop_2sync.q_o from 3 : (i4) -> i1
    %9 = llhd.sig.extract %gen_buffs_0.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_0.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_0.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf_10(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %9, %gen_buffs_0.gen_bits_3.u_prim_buf.out_o after %0 : i1
    %10 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf_10(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %10, %gen_buffs_1.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %11 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf_10(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %11, %gen_buffs_1.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %12 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf_10(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %12, %gen_buffs_1.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %13 = llhd.sig.extract %gen_buffs_1.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_1.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_1.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf_10(in_i: %8: i1) -> (out_o: i1)
    llhd.drv %13, %gen_buffs_1.gen_bits_3.u_prim_buf.out_o after %0 : i1
    %14 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c0_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_0.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_0.u_prim_buf" @prim_sec_anchor_buf_10(in_i: %2: i1) -> (out_o: i1)
    llhd.drv %14, %gen_buffs_2.gen_bits_0.u_prim_buf.out_o after %0 : i1
    %15 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c1_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_1.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_1.u_prim_buf" @prim_sec_anchor_buf_10(in_i: %4: i1) -> (out_o: i1)
    llhd.drv %15, %gen_buffs_2.gen_bits_1.u_prim_buf.out_o after %0 : i1
    %16 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c-2_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_2.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_2.u_prim_buf" @prim_sec_anchor_buf_10(in_i: %6: i1) -> (out_o: i1)
    llhd.drv %16, %gen_buffs_2.gen_bits_2.u_prim_buf.out_o after %0 : i1
    %17 = llhd.sig.extract %gen_buffs_2.lc_en_out from %c-1_i2 : <i4> -> <i1>
    %gen_buffs_2.gen_bits_3.u_prim_buf.out_o = hw.instance "gen_buffs_2.gen_bits_3.u_prim_buf" @prim_sec_anchor_buf_10(in_i: %8: i1) -> (out_o: i1)
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
  hw.module private @aon_timer_reg_top(in %clk_i : i1, in %rst_ni : i1, in %clk_aon_i : i1, in %rst_aon_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out reg2hw : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>, in %hw2reg : !hw.struct<wkup_count_hi: !hw.struct<d: i32, de: i1>, wkup_count_lo: !hw.struct<d: i32, de: i1>, wdog_count: !hw.struct<d: i32, de: i1>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<d: i1, de: i1>, wkup_timer_expired: !hw.struct<d: i1, de: i1>>, wkup_cause: !hw.struct<d: i1, de: i1>>, in %racl_policies_i : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, out racl_error_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, out intg_err_o : i1) {
    %c0_i31 = hw.constant 0 : i31
    %c1_i5 = hw.constant 1 : i5
    %c0_i30 = hw.constant 0 : i30
    %c0_i19 = hw.constant 0 : i19
    %c0_i5 = hw.constant 0 : i5
    %c0_i26 = hw.constant 0 : i26
    %c-3_i4 = hw.constant -3 : i4
    %c-4_i4 = hw.constant -4 : i4
    %c-5_i4 = hw.constant -5 : i4
    %c-6_i4 = hw.constant -6 : i4
    %c-8_i4 = hw.constant -8 : i4
    %c7_i4 = hw.constant 7 : i4
    %c6_i4 = hw.constant 6 : i4
    %c5_i4 = hw.constant 5 : i4
    %c4_i4 = hw.constant 4 : i4
    %c2_i4 = hw.constant 2 : i4
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i2 = hw.constant -1 : i2
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %2 = hw.aggregate_constant [false, false, false, false, false, 0 : i32] : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %3 = hw.aggregate_constant [[0 : i2, 0 : i2]] : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    %4 = hw.aggregate_constant [[false, false], [[0 : i12, false], [false]], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [[false], [false]], [0 : i32], [0 : i32], [0 : i32], [[false], [false]], [[false, false], [false, false]], [false]] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>
    %c-1_i32 = hw.constant -1 : i32
    %c-1_i4 = hw.constant -1 : i4
    %c3_i4 = hw.constant 3 : i4
    %c1_i4 = hw.constant 1 : i4
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false {sv.namehint = "racl_role"}
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
    %c0_i6 = hw.constant 0 : i6
    %c0_i14 = hw.constant 0 : i14
    %true = hw.constant true
    %c0_i12 = hw.constant 0 : i12
    %c0_i2 = hw.constant 0 : i2
    %c0_i13 = hw.constant 0 : i13
    %c-7_i4 = hw.constant -7 : i4
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %5 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %6 = llhd.prb %rst_ni_1 : i1
    %reg2hw = llhd.sig %4 : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>
    %racl_policies_i_2 = llhd.sig name "racl_policies_i" %3 : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    %racl_error_o = llhd.sig %2 : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %reg_we = llhd.sig %false : i1
    %reg_addr = llhd.sig %c0_i6 : i6
    %reg_be = llhd.sig %c0_i4 : i4
    %wr_err = llhd.sig %false : i1
    %reg_rdata_next = llhd.sig %c0_i32 : i32
    %intg_err = llhd.sig %false : i1
    %reg_we_err = llhd.sig %false : i1
    %reg_we_check = llhd.sig %c0_i14 : i14
    %err_q = llhd.sig %false : i1
    %alert_test_we = llhd.sig %false : i1
    %wkup_ctrl_we = llhd.sig %false : i1
    %wkup_ctrl_qs = llhd.sig %c0_i13 : i13
    %wkup_ctrl_busy = llhd.sig %false : i1
    %wkup_thold_hi_we = llhd.sig %false : i1
    %wkup_thold_hi_qs = llhd.sig %c0_i32 : i32
    %wkup_thold_hi_busy = llhd.sig %false : i1
    %wkup_thold_lo_we = llhd.sig %false : i1
    %wkup_thold_lo_qs = llhd.sig %c0_i32 : i32
    %wkup_thold_lo_busy = llhd.sig %false : i1
    %wkup_count_hi_we = llhd.sig %false : i1
    %wkup_count_hi_qs = llhd.sig %c0_i32 : i32
    %wkup_count_hi_busy = llhd.sig %false : i1
    %wkup_count_lo_we = llhd.sig %false : i1
    %wkup_count_lo_qs = llhd.sig %c0_i32 : i32
    %wkup_count_lo_busy = llhd.sig %false : i1
    %wdog_regwen_we = llhd.sig %false : i1
    %wdog_regwen_qs = llhd.sig %false : i1
    %wdog_ctrl_we = llhd.sig %false : i1
    %wdog_ctrl_qs = llhd.sig %c0_i2 : i2
    %wdog_ctrl_busy = llhd.sig %false : i1
    %wdog_bark_thold_we = llhd.sig %false : i1
    %wdog_bark_thold_qs = llhd.sig %c0_i32 : i32
    %wdog_bark_thold_busy = llhd.sig %false : i1
    %wdog_bite_thold_we = llhd.sig %false : i1
    %wdog_bite_thold_qs = llhd.sig %c0_i32 : i32
    %wdog_bite_thold_busy = llhd.sig %false : i1
    %wdog_count_we = llhd.sig %false : i1
    %wdog_count_qs = llhd.sig %c0_i32 : i32
    %wdog_count_busy = llhd.sig %false : i1
    %intr_state_we = llhd.sig %false : i1
    %intr_state_wkup_timer_expired_qs = llhd.sig %false : i1
    %intr_state_wdog_timer_bark_qs = llhd.sig %false : i1
    %intr_test_we = llhd.sig %false : i1
    %wkup_cause_we = llhd.sig %false : i1
    %wkup_cause_qs = llhd.sig %false : i1
    %wkup_cause_busy = llhd.sig %false : i1
    %aon_wkup_ctrl_enable_qs_int = llhd.sig %false : i1
    %aon_wkup_ctrl_prescaler_qs_int = llhd.sig %c0_i12 : i12
    %aon_wkup_ctrl_qs = llhd.sig %c0_i13 : i13
    %aon_wkup_thold_hi_qs_int = llhd.sig %c0_i32 : i32
    %aon_wkup_thold_hi_qs = llhd.sig %c0_i32 : i32
    %aon_wkup_thold_lo_qs_int = llhd.sig %c0_i32 : i32
    %aon_wkup_thold_lo_qs = llhd.sig %c0_i32 : i32
    %aon_wkup_count_hi_ds_int = llhd.sig %c0_i32 : i32
    %aon_wkup_count_hi_qs_int = llhd.sig %c0_i32 : i32
    %aon_wkup_count_hi_ds = llhd.sig %c0_i32 : i32
    %aon_wkup_count_hi_qs = llhd.sig %c0_i32 : i32
    %aon_wkup_count_lo_ds_int = llhd.sig %c0_i32 : i32
    %aon_wkup_count_lo_qs_int = llhd.sig %c0_i32 : i32
    %aon_wkup_count_lo_ds = llhd.sig %c0_i32 : i32
    %aon_wkup_count_lo_qs = llhd.sig %c0_i32 : i32
    %aon_wdog_ctrl_enable_qs_int = llhd.sig %false : i1
    %aon_wdog_ctrl_pause_in_sleep_qs_int = llhd.sig %false : i1
    %aon_wdog_ctrl_qs = llhd.sig %c0_i2 : i2
    %aon_wdog_bark_thold_qs_int = llhd.sig %c0_i32 : i32
    %aon_wdog_bark_thold_qs = llhd.sig %c0_i32 : i32
    %aon_wdog_bite_thold_qs_int = llhd.sig %c0_i32 : i32
    %aon_wdog_bite_thold_qs = llhd.sig %c0_i32 : i32
    %aon_wdog_count_ds_int = llhd.sig %c0_i32 : i32
    %aon_wdog_count_qs_int = llhd.sig %c0_i32 : i32
    %aon_wdog_count_ds = llhd.sig %c0_i32 : i32
    %aon_wdog_count_qs = llhd.sig %c0_i32 : i32
    %aon_wkup_cause_ds_int = llhd.sig %false : i1
    %aon_wkup_cause_qs_int = llhd.sig %false : i1
    %aon_wkup_cause_ds = llhd.sig %false : i1
    %aon_wkup_cause_qs = llhd.sig %false : i1
    %alert_test_flds_we = llhd.sig %false : i1
    %wkup_ctrl_flds_we = llhd.sig %c0_i2 : i2
    %wkup_count_hi_flds_we = llhd.sig %false : i1
    %wkup_count_lo_flds_we = llhd.sig %false : i1
    %wdog_count_flds_we = llhd.sig %false : i1
    %intr_test_flds_we = llhd.sig %c0_i2 : i2
    %wkup_cause_flds_we = llhd.sig %false : i1
    %addr_hit = llhd.sig %c0_i14 : i14
    %racl_role_vec = llhd.sig %c0_i2 : i2
    %racl_addr_hit_read = llhd.sig %c0_i14 : i14
    %racl_addr_hit_write = llhd.sig %c0_i14 : i14
    %reg_busy_sel = llhd.sig %false : i1
    %u_chk.err_o = hw.instance "u_chk" @tlul_cmd_intg_chk(tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> (err_o: i1)
    llhd.drv %intg_err, %u_chk.err_o after %1 : i1
    %7 = llhd.prb %reg_we_check : i14
    %8 = llhd.prb %reg_we : i1
    %9 = comb.xor %138, %true : i1
    %10 = comb.and %8, %9 : i1
    %u_prim_reg_we_check.err_o = hw.instance "u_prim_reg_we_check" @prim_reg_we_check(clk_i: %5: i1, rst_ni: %6: i1, oh_i: %7: i14, en_i: %10: i1) -> (err_o: i1)
    llhd.drv %reg_we_err, %u_prim_reg_we_check.err_o after %1 : i1
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen(tl_i: %u_reg_if.tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
    %11 = llhd.prb %racl_error_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %u_reg_if.tl_o, %u_reg_if.intg_error_o, %u_reg_if.re_o, %u_reg_if.we_o, %u_reg_if.addr_o, %u_reg_if.wdata_o, %u_reg_if.be_o = hw.instance "u_reg_if" @tlul_adapter_reg(clk_i: %5: i1, rst_ni: %6: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, en_ifetch_i: %c-7_i4: i4, busy_i: %196: i1, rdata_i: %96: i32, error_i: %98: i1) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, intg_error_o: i1, re_o: i1, we_o: i1, addr_o: i6, wdata_o: i32, be_o: i4) {sv.namehint = "reg_re"}
    llhd.drv %reg_we, %u_reg_if.we_o after %1 : i1
    llhd.drv %reg_addr, %u_reg_if.addr_o after %1 : i6
    llhd.drv %reg_be, %u_reg_if.be_o after %1 : i4
    %12 = llhd.prb %wkup_ctrl_we : i1
    %13 = comb.extract %u_reg_if.wdata_o from 0 : (i32) -> i13
    %14 = llhd.prb %aon_wkup_ctrl_qs : i13
    %u_wkup_ctrl_cdc.src_busy_o, %u_wkup_ctrl_cdc.src_qs_o, %u_wkup_ctrl_cdc.dst_we_o, %u_wkup_ctrl_cdc.dst_re_o, %u_wkup_ctrl_cdc.dst_regwen_o, %u_wkup_ctrl_cdc.dst_wd_o = hw.instance "u_wkup_ctrl_cdc" @prim_reg_cdc(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %12: i1, src_re_i: %false: i1, src_wd_i: %13: i13, dst_ds_i: %c0_i13: i13, dst_qs_i: %14: i13, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i13, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i13) {sv.namehint = "aon_wkup_ctrl_we"}
    llhd.drv %wkup_ctrl_busy, %u_wkup_ctrl_cdc.src_busy_o after %1 : i1
    llhd.drv %wkup_ctrl_qs, %u_wkup_ctrl_cdc.src_qs_o after %1 : i13
    %15 = llhd.prb %wkup_thold_hi_we : i1
    %16 = llhd.prb %aon_wkup_thold_hi_qs : i32
    %u_wkup_thold_hi_cdc.src_busy_o, %u_wkup_thold_hi_cdc.src_qs_o, %u_wkup_thold_hi_cdc.dst_we_o, %u_wkup_thold_hi_cdc.dst_re_o, %u_wkup_thold_hi_cdc.dst_regwen_o, %u_wkup_thold_hi_cdc.dst_wd_o = hw.instance "u_wkup_thold_hi_cdc" @prim_reg_cdc_1(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %15: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %16: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "aon_wkup_thold_hi_we"}
    llhd.drv %wkup_thold_hi_busy, %u_wkup_thold_hi_cdc.src_busy_o after %1 : i1
    llhd.drv %wkup_thold_hi_qs, %u_wkup_thold_hi_cdc.src_qs_o after %1 : i32
    %17 = llhd.prb %wkup_thold_lo_we : i1
    %18 = llhd.prb %aon_wkup_thold_lo_qs : i32
    %u_wkup_thold_lo_cdc.src_busy_o, %u_wkup_thold_lo_cdc.src_qs_o, %u_wkup_thold_lo_cdc.dst_we_o, %u_wkup_thold_lo_cdc.dst_re_o, %u_wkup_thold_lo_cdc.dst_regwen_o, %u_wkup_thold_lo_cdc.dst_wd_o = hw.instance "u_wkup_thold_lo_cdc" @prim_reg_cdc_1(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %17: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %18: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "aon_wkup_thold_lo_we"}
    llhd.drv %wkup_thold_lo_busy, %u_wkup_thold_lo_cdc.src_busy_o after %1 : i1
    llhd.drv %wkup_thold_lo_qs, %u_wkup_thold_lo_cdc.src_qs_o after %1 : i32
    %19 = llhd.prb %wkup_count_hi_we : i1
    %20 = llhd.prb %aon_wkup_count_hi_ds : i32
    %21 = llhd.prb %aon_wkup_count_hi_qs : i32
    %u_wkup_count_hi_cdc.src_busy_o, %u_wkup_count_hi_cdc.src_qs_o, %u_wkup_count_hi_cdc.dst_we_o, %u_wkup_count_hi_cdc.dst_re_o, %u_wkup_count_hi_cdc.dst_regwen_o, %u_wkup_count_hi_cdc.dst_wd_o = hw.instance "u_wkup_count_hi_cdc" @prim_reg_cdc_2(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %19: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %20: i32, dst_qs_i: %21: i32, dst_update_i: %118: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "aon_wkup_count_hi_we"}
    llhd.drv %wkup_count_hi_busy, %u_wkup_count_hi_cdc.src_busy_o after %1 : i1
    llhd.drv %wkup_count_hi_qs, %u_wkup_count_hi_cdc.src_qs_o after %1 : i32
    %22 = llhd.prb %wkup_count_lo_we : i1
    %23 = llhd.prb %aon_wkup_count_lo_ds : i32
    %24 = llhd.prb %aon_wkup_count_lo_qs : i32
    %u_wkup_count_lo_cdc.src_busy_o, %u_wkup_count_lo_cdc.src_qs_o, %u_wkup_count_lo_cdc.dst_we_o, %u_wkup_count_lo_cdc.dst_re_o, %u_wkup_count_lo_cdc.dst_regwen_o, %u_wkup_count_lo_cdc.dst_wd_o = hw.instance "u_wkup_count_lo_cdc" @prim_reg_cdc_2(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %22: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %23: i32, dst_qs_i: %24: i32, dst_update_i: %119: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "aon_wkup_count_lo_we"}
    llhd.drv %wkup_count_lo_busy, %u_wkup_count_lo_cdc.src_busy_o after %1 : i1
    llhd.drv %wkup_count_lo_qs, %u_wkup_count_lo_cdc.src_qs_o after %1 : i32
    %25 = llhd.prb %wdog_regwen_qs : i1
    %26 = llhd.prb %wdog_ctrl_we : i1
    %27 = comb.extract %u_reg_if.wdata_o from 0 : (i32) -> i2
    %28 = llhd.prb %aon_wdog_ctrl_qs : i2
    %u_wdog_ctrl_cdc.src_busy_o, %u_wdog_ctrl_cdc.src_qs_o, %u_wdog_ctrl_cdc.dst_we_o, %u_wdog_ctrl_cdc.dst_re_o, %u_wdog_ctrl_cdc.dst_regwen_o, %u_wdog_ctrl_cdc.dst_wd_o = hw.instance "u_wdog_ctrl_cdc" @prim_reg_cdc_3(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %25: i1, src_we_i: %26: i1, src_re_i: %false: i1, src_wd_i: %27: i2, dst_ds_i: %c0_i2: i2, dst_qs_i: %28: i2, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i2, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i2) {sv.namehint = "aon_wdog_ctrl_we"}
    llhd.drv %wdog_ctrl_busy, %u_wdog_ctrl_cdc.src_busy_o after %1 : i1
    llhd.drv %wdog_ctrl_qs, %u_wdog_ctrl_cdc.src_qs_o after %1 : i2
    %29 = llhd.prb %wdog_bark_thold_we : i1
    %30 = llhd.prb %aon_wdog_bark_thold_qs : i32
    %u_wdog_bark_thold_cdc.src_busy_o, %u_wdog_bark_thold_cdc.src_qs_o, %u_wdog_bark_thold_cdc.dst_we_o, %u_wdog_bark_thold_cdc.dst_re_o, %u_wdog_bark_thold_cdc.dst_regwen_o, %u_wdog_bark_thold_cdc.dst_wd_o = hw.instance "u_wdog_bark_thold_cdc" @prim_reg_cdc_1(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %25: i1, src_we_i: %29: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %30: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "aon_wdog_bark_thold_we"}
    llhd.drv %wdog_bark_thold_busy, %u_wdog_bark_thold_cdc.src_busy_o after %1 : i1
    llhd.drv %wdog_bark_thold_qs, %u_wdog_bark_thold_cdc.src_qs_o after %1 : i32
    %31 = llhd.prb %wdog_bite_thold_we : i1
    %32 = llhd.prb %aon_wdog_bite_thold_qs : i32
    %u_wdog_bite_thold_cdc.src_busy_o, %u_wdog_bite_thold_cdc.src_qs_o, %u_wdog_bite_thold_cdc.dst_we_o, %u_wdog_bite_thold_cdc.dst_re_o, %u_wdog_bite_thold_cdc.dst_regwen_o, %u_wdog_bite_thold_cdc.dst_wd_o = hw.instance "u_wdog_bite_thold_cdc" @prim_reg_cdc_1(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %25: i1, src_we_i: %31: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %32: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "aon_wdog_bite_thold_we"}
    llhd.drv %wdog_bite_thold_busy, %u_wdog_bite_thold_cdc.src_busy_o after %1 : i1
    llhd.drv %wdog_bite_thold_qs, %u_wdog_bite_thold_cdc.src_qs_o after %1 : i32
    %33 = llhd.prb %wdog_count_we : i1
    %34 = llhd.prb %aon_wdog_count_ds : i32
    %35 = llhd.prb %aon_wdog_count_qs : i32
    %u_wdog_count_cdc.src_busy_o, %u_wdog_count_cdc.src_qs_o, %u_wdog_count_cdc.dst_we_o, %u_wdog_count_cdc.dst_re_o, %u_wdog_count_cdc.dst_regwen_o, %u_wdog_count_cdc.dst_wd_o = hw.instance "u_wdog_count_cdc" @prim_reg_cdc_2(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %33: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %34: i32, dst_qs_i: %35: i32, dst_update_i: %123: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "aon_wdog_count_we"}
    llhd.drv %wdog_count_busy, %u_wdog_count_cdc.src_busy_o after %1 : i1
    llhd.drv %wdog_count_qs, %u_wdog_count_cdc.src_qs_o after %1 : i32
    %36 = llhd.prb %wkup_cause_we : i1
    %37 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "alert_test_wd"} : (i32) -> i1
    %38 = llhd.prb %aon_wkup_cause_ds : i1
    %39 = llhd.prb %aon_wkup_cause_qs : i1
    %u_wkup_cause_cdc.src_busy_o, %u_wkup_cause_cdc.src_qs_o, %u_wkup_cause_cdc.dst_we_o, %u_wkup_cause_cdc.dst_re_o, %u_wkup_cause_cdc.dst_regwen_o, %u_wkup_cause_cdc.dst_wd_o = hw.instance "u_wkup_cause_cdc" @prim_reg_cdc_4(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_aon_i: i1, rst_dst_ni: %rst_aon_ni: i1, src_regwen_i: %false: i1, src_we_i: %36: i1, src_re_i: %false: i1, src_wd_i: %37: i1, dst_ds_i: %38: i1, dst_qs_i: %39: i1, dst_update_i: %128: i1) -> (src_busy_o: i1, src_qs_o: i1, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i1) {sv.namehint = "aon_wkup_cause_we"}
    llhd.drv %wkup_cause_busy, %u_wkup_cause_cdc.src_busy_o after %1 : i1
    llhd.drv %wkup_cause_qs, %u_wkup_cause_cdc.src_qs_o after %1 : i1
    %40 = llhd.prb %alert_test_we : i1
    %41 = llhd.sig.struct_extract %reg2hw["alert_test"] : <!hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>>
    %42 = llhd.sig.struct_extract %41["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_alert_test.qe, %u_alert_test.qre, %u_alert_test.q, %u_alert_test.ds, %u_alert_test.qs = hw.instance "u_alert_test" @prim_subreg_ext(re: %false: i1, we: %40: i1, wd: %37: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %alert_test_flds_we, %u_alert_test.qe after %1 : i1
    llhd.drv %42, %u_alert_test.q after %1 : i1
    %43 = llhd.prb %wkup_ctrl_flds_we : i2
    %44 = comb.icmp eq %43, %c-1_i2 : i2
    %u_wkup_ctrl0_qe.q_o = hw.instance "u_wkup_ctrl0_qe" @prim_flop_0(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, d_i: %44: i1) -> (q_o: i1) {sv.namehint = "wkup_ctrl_qe"}
    %45 = comb.extract %u_wkup_ctrl_cdc.dst_wd_o from 0 : (i13) -> i1
    %46 = llhd.sig.extract %wkup_ctrl_flds_we from %false : <i2> -> <i1>
    %47 = llhd.sig.struct_extract %reg2hw["wkup_ctrl"] : <!hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>>
    %48 = llhd.sig.struct_extract %47["enable"] : <!hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>>
    %49 = llhd.sig.struct_extract %48["q"] : <!hw.struct<q: i1>>
    %u_wkup_ctrl_enable.qe, %u_wkup_ctrl_enable.q, %u_wkup_ctrl_enable.ds, %u_wkup_ctrl_enable.qs = hw.instance "u_wkup_ctrl_enable" @prim_subreg(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_wkup_ctrl_cdc.dst_we_o: i1, wd: %45: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %46, %u_wkup_ctrl_enable.qe after %1 : i1
    llhd.drv %49, %u_wkup_ctrl_enable.q after %1 : i1
    llhd.drv %aon_wkup_ctrl_enable_qs_int, %u_wkup_ctrl_enable.qs after %1 : i1
    %50 = comb.extract %u_wkup_ctrl_cdc.dst_wd_o from 1 : (i13) -> i12
    %51 = llhd.sig.extract %wkup_ctrl_flds_we from %true : <i2> -> <i1>
    %52 = llhd.sig.struct_extract %47["prescaler"] : <!hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>>
    %53 = llhd.sig.struct_extract %52["q"] : <!hw.struct<q: i12, qe: i1>>
    %u_wkup_ctrl_prescaler.qe, %u_wkup_ctrl_prescaler.q, %u_wkup_ctrl_prescaler.ds, %u_wkup_ctrl_prescaler.qs = hw.instance "u_wkup_ctrl_prescaler" @prim_subreg_5(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_wkup_ctrl_cdc.dst_we_o: i1, wd: %50: i12, de: %false: i1, d: %c0_i12: i12) -> (qe: i1, q: i12, ds: i12, qs: i12)
    llhd.drv %51, %u_wkup_ctrl_prescaler.qe after %1 : i1
    llhd.drv %53, %u_wkup_ctrl_prescaler.q after %1 : i12
    llhd.drv %aon_wkup_ctrl_prescaler_qs_int, %u_wkup_ctrl_prescaler.qs after %1 : i12
    %54 = llhd.sig.struct_extract %reg2hw["wkup_thold_hi"] : <!hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>>
    %55 = llhd.sig.struct_extract %54["q"] : <!hw.struct<q: i32>>
    %u_wkup_thold_hi.qe, %u_wkup_thold_hi.q, %u_wkup_thold_hi.ds, %u_wkup_thold_hi.qs = hw.instance "u_wkup_thold_hi" @prim_subreg_6(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_wkup_thold_hi_cdc.dst_we_o: i1, wd: %u_wkup_thold_hi_cdc.dst_wd_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %55, %u_wkup_thold_hi.q after %1 : i32
    llhd.drv %aon_wkup_thold_hi_qs_int, %u_wkup_thold_hi.qs after %1 : i32
    %56 = llhd.sig.struct_extract %reg2hw["wkup_thold_lo"] : <!hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>>
    %57 = llhd.sig.struct_extract %56["q"] : <!hw.struct<q: i32>>
    %u_wkup_thold_lo.qe, %u_wkup_thold_lo.q, %u_wkup_thold_lo.ds, %u_wkup_thold_lo.qs = hw.instance "u_wkup_thold_lo" @prim_subreg_6(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_wkup_thold_lo_cdc.dst_we_o: i1, wd: %u_wkup_thold_lo_cdc.dst_wd_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %57, %u_wkup_thold_lo.q after %1 : i32
    llhd.drv %aon_wkup_thold_lo_qs_int, %u_wkup_thold_lo.qs after %1 : i32
    %wkup_count_hi = hw.struct_extract %hw2reg["wkup_count_hi"] : !hw.struct<wkup_count_hi: !hw.struct<d: i32, de: i1>, wkup_count_lo: !hw.struct<d: i32, de: i1>, wdog_count: !hw.struct<d: i32, de: i1>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<d: i1, de: i1>, wkup_timer_expired: !hw.struct<d: i1, de: i1>>, wkup_cause: !hw.struct<d: i1, de: i1>>
    %de = hw.struct_extract %wkup_count_hi["de"] : !hw.struct<d: i32, de: i1>
    %d = hw.struct_extract %wkup_count_hi["d"] : !hw.struct<d: i32, de: i1>
    %58 = llhd.sig.struct_extract %reg2hw["wkup_count_hi"] : <!hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>>
    %59 = llhd.sig.struct_extract %58["q"] : <!hw.struct<q: i32>>
    %u_wkup_count_hi.qe, %u_wkup_count_hi.q, %u_wkup_count_hi.ds, %u_wkup_count_hi.qs = hw.instance "u_wkup_count_hi" @prim_subreg_6(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_wkup_count_hi_cdc.dst_we_o: i1, wd: %u_wkup_count_hi_cdc.dst_wd_o: i32, de: %de: i1, d: %d: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %wkup_count_hi_flds_we, %u_wkup_count_hi.qe after %1 : i1
    llhd.drv %59, %u_wkup_count_hi.q after %1 : i32
    llhd.drv %aon_wkup_count_hi_ds_int, %u_wkup_count_hi.ds after %1 : i32
    llhd.drv %aon_wkup_count_hi_qs_int, %u_wkup_count_hi.qs after %1 : i32
    %wkup_count_lo = hw.struct_extract %hw2reg["wkup_count_lo"] : !hw.struct<wkup_count_hi: !hw.struct<d: i32, de: i1>, wkup_count_lo: !hw.struct<d: i32, de: i1>, wdog_count: !hw.struct<d: i32, de: i1>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<d: i1, de: i1>, wkup_timer_expired: !hw.struct<d: i1, de: i1>>, wkup_cause: !hw.struct<d: i1, de: i1>>
    %de_3 = hw.struct_extract %wkup_count_lo["de"] : !hw.struct<d: i32, de: i1>
    %d_4 = hw.struct_extract %wkup_count_lo["d"] : !hw.struct<d: i32, de: i1>
    %60 = llhd.sig.struct_extract %reg2hw["wkup_count_lo"] : <!hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>>
    %61 = llhd.sig.struct_extract %60["q"] : <!hw.struct<q: i32>>
    %u_wkup_count_lo.qe, %u_wkup_count_lo.q, %u_wkup_count_lo.ds, %u_wkup_count_lo.qs = hw.instance "u_wkup_count_lo" @prim_subreg_6(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_wkup_count_lo_cdc.dst_we_o: i1, wd: %u_wkup_count_lo_cdc.dst_wd_o: i32, de: %de_3: i1, d: %d_4: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %wkup_count_lo_flds_we, %u_wkup_count_lo.qe after %1 : i1
    llhd.drv %61, %u_wkup_count_lo.q after %1 : i32
    llhd.drv %aon_wkup_count_lo_ds_int, %u_wkup_count_lo.ds after %1 : i32
    llhd.drv %aon_wkup_count_lo_qs_int, %u_wkup_count_lo.qs after %1 : i32
    %62 = llhd.prb %wdog_regwen_we : i1
    %u_wdog_regwen.qe, %u_wdog_regwen.q, %u_wdog_regwen.ds, %u_wdog_regwen.qs = hw.instance "u_wdog_regwen" @prim_subreg_7(clk_i: %5: i1, rst_ni: %6: i1, we: %62: i1, wd: %37: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %wdog_regwen_qs, %u_wdog_regwen.qs after %1 : i1
    %63 = comb.extract %u_wdog_ctrl_cdc.dst_wd_o from 0 : (i2) -> i1
    %64 = llhd.sig.struct_extract %reg2hw["wdog_ctrl"] : <!hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>>
    %65 = llhd.sig.struct_extract %64["enable"] : <!hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>>
    %66 = llhd.sig.struct_extract %65["q"] : <!hw.struct<q: i1>>
    %u_wdog_ctrl_enable.qe, %u_wdog_ctrl_enable.q, %u_wdog_ctrl_enable.ds, %u_wdog_ctrl_enable.qs = hw.instance "u_wdog_ctrl_enable" @prim_subreg(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %120: i1, wd: %63: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %66, %u_wdog_ctrl_enable.q after %1 : i1
    llhd.drv %aon_wdog_ctrl_enable_qs_int, %u_wdog_ctrl_enable.qs after %1 : i1
    %67 = comb.extract %u_wdog_ctrl_cdc.dst_wd_o from 1 : (i2) -> i1
    %68 = llhd.sig.struct_extract %64["pause_in_sleep"] : <!hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>>
    %69 = llhd.sig.struct_extract %68["q"] : <!hw.struct<q: i1>>
    %u_wdog_ctrl_pause_in_sleep.qe, %u_wdog_ctrl_pause_in_sleep.q, %u_wdog_ctrl_pause_in_sleep.ds, %u_wdog_ctrl_pause_in_sleep.qs = hw.instance "u_wdog_ctrl_pause_in_sleep" @prim_subreg(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %120: i1, wd: %67: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %69, %u_wdog_ctrl_pause_in_sleep.q after %1 : i1
    llhd.drv %aon_wdog_ctrl_pause_in_sleep_qs_int, %u_wdog_ctrl_pause_in_sleep.qs after %1 : i1
    %70 = llhd.sig.struct_extract %reg2hw["wdog_bark_thold"] : <!hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>>
    %71 = llhd.sig.struct_extract %70["q"] : <!hw.struct<q: i32>>
    %u_wdog_bark_thold.qe, %u_wdog_bark_thold.q, %u_wdog_bark_thold.ds, %u_wdog_bark_thold.qs = hw.instance "u_wdog_bark_thold" @prim_subreg_6(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %121: i1, wd: %u_wdog_bark_thold_cdc.dst_wd_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %71, %u_wdog_bark_thold.q after %1 : i32
    llhd.drv %aon_wdog_bark_thold_qs_int, %u_wdog_bark_thold.qs after %1 : i32
    %72 = llhd.sig.struct_extract %reg2hw["wdog_bite_thold"] : <!hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>>
    %73 = llhd.sig.struct_extract %72["q"] : <!hw.struct<q: i32>>
    %u_wdog_bite_thold.qe, %u_wdog_bite_thold.q, %u_wdog_bite_thold.ds, %u_wdog_bite_thold.qs = hw.instance "u_wdog_bite_thold" @prim_subreg_6(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %122: i1, wd: %u_wdog_bite_thold_cdc.dst_wd_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %73, %u_wdog_bite_thold.q after %1 : i32
    llhd.drv %aon_wdog_bite_thold_qs_int, %u_wdog_bite_thold.qs after %1 : i32
    %wdog_count = hw.struct_extract %hw2reg["wdog_count"] : !hw.struct<wkup_count_hi: !hw.struct<d: i32, de: i1>, wkup_count_lo: !hw.struct<d: i32, de: i1>, wdog_count: !hw.struct<d: i32, de: i1>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<d: i1, de: i1>, wkup_timer_expired: !hw.struct<d: i1, de: i1>>, wkup_cause: !hw.struct<d: i1, de: i1>>
    %de_5 = hw.struct_extract %wdog_count["de"] : !hw.struct<d: i32, de: i1>
    %d_6 = hw.struct_extract %wdog_count["d"] : !hw.struct<d: i32, de: i1>
    %74 = llhd.sig.struct_extract %reg2hw["wdog_count"] : <!hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>>
    %75 = llhd.sig.struct_extract %74["q"] : <!hw.struct<q: i32>>
    %u_wdog_count.qe, %u_wdog_count.q, %u_wdog_count.ds, %u_wdog_count.qs = hw.instance "u_wdog_count" @prim_subreg_6(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_wdog_count_cdc.dst_we_o: i1, wd: %u_wdog_count_cdc.dst_wd_o: i32, de: %de_5: i1, d: %d_6: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %wdog_count_flds_we, %u_wdog_count.qe after %1 : i1
    llhd.drv %75, %u_wdog_count.q after %1 : i32
    llhd.drv %aon_wdog_count_ds_int, %u_wdog_count.ds after %1 : i32
    llhd.drv %aon_wdog_count_qs_int, %u_wdog_count.qs after %1 : i32
    %76 = llhd.prb %intr_state_we : i1
    %intr_state = hw.struct_extract %hw2reg["intr_state"] : !hw.struct<wkup_count_hi: !hw.struct<d: i32, de: i1>, wkup_count_lo: !hw.struct<d: i32, de: i1>, wdog_count: !hw.struct<d: i32, de: i1>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<d: i1, de: i1>, wkup_timer_expired: !hw.struct<d: i1, de: i1>>, wkup_cause: !hw.struct<d: i1, de: i1>>
    %wkup_timer_expired = hw.struct_extract %intr_state["wkup_timer_expired"] : !hw.struct<wdog_timer_bark: !hw.struct<d: i1, de: i1>, wkup_timer_expired: !hw.struct<d: i1, de: i1>>
    %de_7 = hw.struct_extract %wkup_timer_expired["de"] : !hw.struct<d: i1, de: i1>
    %d_8 = hw.struct_extract %wkup_timer_expired["d"] : !hw.struct<d: i1, de: i1>
    %77 = llhd.sig.struct_extract %reg2hw["intr_state"] : <!hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>>
    %78 = llhd.sig.struct_extract %77["wkup_timer_expired"] : <!hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>>
    %79 = llhd.sig.struct_extract %78["q"] : <!hw.struct<q: i1>>
    %u_intr_state_wkup_timer_expired.qe, %u_intr_state_wkup_timer_expired.q, %u_intr_state_wkup_timer_expired.ds, %u_intr_state_wkup_timer_expired.qs = hw.instance "u_intr_state_wkup_timer_expired" @prim_subreg_8(clk_i: %5: i1, rst_ni: %6: i1, we: %76: i1, wd: %37: i1, de: %de_7: i1, d: %d_8: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %79, %u_intr_state_wkup_timer_expired.q after %1 : i1
    llhd.drv %intr_state_wkup_timer_expired_qs, %u_intr_state_wkup_timer_expired.qs after %1 : i1
    %wdog_timer_bark = hw.struct_extract %intr_state["wdog_timer_bark"] : !hw.struct<wdog_timer_bark: !hw.struct<d: i1, de: i1>, wkup_timer_expired: !hw.struct<d: i1, de: i1>>
    %de_9 = hw.struct_extract %wdog_timer_bark["de"] : !hw.struct<d: i1, de: i1>
    %d_10 = hw.struct_extract %wdog_timer_bark["d"] : !hw.struct<d: i1, de: i1>
    %80 = llhd.sig.struct_extract %77["wdog_timer_bark"] : <!hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>>
    %81 = llhd.sig.struct_extract %80["q"] : <!hw.struct<q: i1>>
    %u_intr_state_wdog_timer_bark.qe, %u_intr_state_wdog_timer_bark.q, %u_intr_state_wdog_timer_bark.ds, %u_intr_state_wdog_timer_bark.qs = hw.instance "u_intr_state_wdog_timer_bark" @prim_subreg_8(clk_i: %5: i1, rst_ni: %6: i1, we: %76: i1, wd: %178: i1, de: %de_9: i1, d: %d_10: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %81, %u_intr_state_wdog_timer_bark.q after %1 : i1
    llhd.drv %intr_state_wdog_timer_bark_qs, %u_intr_state_wdog_timer_bark.qs after %1 : i1
    %82 = llhd.prb %intr_test_we : i1
    %83 = llhd.sig.extract %intr_test_flds_we from %false : <i2> -> <i1>
    %84 = llhd.sig.struct_extract %reg2hw["intr_test"] : <!hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>>
    %85 = llhd.sig.struct_extract %84["wkup_timer_expired"] : <!hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>>
    %86 = llhd.sig.struct_extract %85["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_intr_test_wkup_timer_expired.qe, %u_intr_test_wkup_timer_expired.qre, %u_intr_test_wkup_timer_expired.q, %u_intr_test_wkup_timer_expired.ds, %u_intr_test_wkup_timer_expired.qs = hw.instance "u_intr_test_wkup_timer_expired" @prim_subreg_ext(re: %false: i1, we: %82: i1, wd: %37: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %83, %u_intr_test_wkup_timer_expired.qe after %1 : i1
    llhd.drv %86, %u_intr_test_wkup_timer_expired.q after %1 : i1
    %87 = llhd.sig.extract %intr_test_flds_we from %true : <i2> -> <i1>
    %88 = llhd.sig.struct_extract %84["wdog_timer_bark"] : <!hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>>
    %89 = llhd.sig.struct_extract %88["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_intr_test_wdog_timer_bark.qe, %u_intr_test_wdog_timer_bark.qre, %u_intr_test_wdog_timer_bark.q, %u_intr_test_wdog_timer_bark.ds, %u_intr_test_wdog_timer_bark.qs = hw.instance "u_intr_test_wdog_timer_bark" @prim_subreg_ext(re: %false: i1, we: %82: i1, wd: %178: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %87, %u_intr_test_wdog_timer_bark.qe after %1 : i1
    llhd.drv %89, %u_intr_test_wdog_timer_bark.q after %1 : i1
    %wkup_cause = hw.struct_extract %hw2reg["wkup_cause"] : !hw.struct<wkup_count_hi: !hw.struct<d: i32, de: i1>, wkup_count_lo: !hw.struct<d: i32, de: i1>, wdog_count: !hw.struct<d: i32, de: i1>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<d: i1, de: i1>, wkup_timer_expired: !hw.struct<d: i1, de: i1>>, wkup_cause: !hw.struct<d: i1, de: i1>>
    %de_11 = hw.struct_extract %wkup_cause["de"] : !hw.struct<d: i1, de: i1>
    %d_12 = hw.struct_extract %wkup_cause["d"] : !hw.struct<d: i1, de: i1>
    %90 = llhd.sig.struct_extract %reg2hw["wkup_cause"] : <!hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>>
    %91 = llhd.sig.struct_extract %90["q"] : <!hw.struct<q: i1>>
    %u_wkup_cause.qe, %u_wkup_cause.q, %u_wkup_cause.ds, %u_wkup_cause.qs = hw.instance "u_wkup_cause" @prim_subreg_9(clk_i: %clk_aon_i: i1, rst_ni: %rst_aon_ni: i1, we: %u_wkup_cause_cdc.dst_we_o: i1, wd: %u_wkup_cause_cdc.dst_wd_o: i1, de: %de_11: i1, d: %d_12: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %wkup_cause_flds_we, %u_wkup_cause.qe after %1 : i1
    llhd.drv %91, %u_wkup_cause.q after %1 : i1
    llhd.drv %aon_wkup_cause_ds_int, %u_wkup_cause.ds after %1 : i1
    llhd.drv %aon_wkup_cause_qs_int, %u_wkup_cause.qs after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %208 = llhd.prb %clk_i_0 : i1
      %209 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%5, %6 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %210 = llhd.prb %clk_i_0 : i1
      %211 = comb.xor bin %208, %true : i1
      %212 = comb.and bin %211, %210 : i1
      %213 = llhd.prb %rst_ni_1 : i1
      %214 = comb.xor bin %213, %true : i1
      %215 = comb.and bin %209, %214 : i1
      %216 = comb.or bin %212, %215 : i1
      cf.cond_br %216, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %217 = llhd.prb %rst_ni_1 : i1
      %218 = comb.xor %217, %true : i1
      cf.cond_br %218, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %err_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %219 = llhd.prb %intg_err : i1
      %220 = llhd.prb %reg_we_err : i1
      %221 = comb.or %219, %220 : i1
      cf.cond_br %221, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %err_q, %true after %0 : i1
      cf.br ^bb1
    }
    %92 = llhd.prb %err_q : i1
    %93 = llhd.prb %intg_err : i1
    %94 = llhd.prb %reg_we_err : i1
    %95 = comb.or %92, %93, %94 : i1
    %96 = llhd.prb %reg_rdata_next {sv.namehint = "reg_rdata"} : i32
    %97 = llhd.prb %wr_err : i1
    %98 = comb.or %138, %97, %93 {sv.namehint = "reg_error"} : i1
    %99 = llhd.prb %aon_wkup_ctrl_enable_qs_int : i1
    %100 = llhd.prb %aon_wkup_ctrl_prescaler_qs_int : i12
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_wkup_ctrl_qs, %c0_i13 after %1 : i13
      %208 = llhd.sig.extract %aon_wkup_ctrl_qs from %c0_i4 : <i13> -> <i1>
      %209 = llhd.prb %aon_wkup_ctrl_enable_qs_int : i1
      llhd.drv %208, %209 after %1 : i1
      %210 = llhd.sig.extract %aon_wkup_ctrl_qs from %c1_i4 : <i13> -> <i12>
      %211 = llhd.prb %aon_wkup_ctrl_prescaler_qs_int : i12
      llhd.drv %210, %211 after %1 : i12
      llhd.wait (%14, %99, %100 : i13, i1, i12), ^bb1
    }
    %101 = llhd.prb %aon_wkup_thold_hi_qs_int : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_wkup_thold_hi_qs, %c0_i32 after %1 : i32
      %208 = llhd.prb %aon_wkup_thold_hi_qs_int : i32
      llhd.drv %aon_wkup_thold_hi_qs, %208 after %1 : i32
      llhd.wait (%16, %101 : i32, i32), ^bb1
    }
    %102 = llhd.prb %aon_wkup_thold_lo_qs_int : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_wkup_thold_lo_qs, %c0_i32 after %1 : i32
      %208 = llhd.prb %aon_wkup_thold_lo_qs_int : i32
      llhd.drv %aon_wkup_thold_lo_qs, %208 after %1 : i32
      llhd.wait (%18, %102 : i32, i32), ^bb1
    }
    %103 = llhd.prb %aon_wkup_count_hi_ds_int : i32
    %104 = llhd.prb %aon_wkup_count_hi_qs_int : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_wkup_count_hi_qs, %c0_i32 after %1 : i32
      llhd.drv %aon_wkup_count_hi_ds, %c0_i32 after %1 : i32
      %208 = llhd.prb %aon_wkup_count_hi_ds_int : i32
      llhd.drv %aon_wkup_count_hi_ds, %208 after %1 : i32
      %209 = llhd.prb %aon_wkup_count_hi_qs_int : i32
      llhd.drv %aon_wkup_count_hi_qs, %209 after %1 : i32
      llhd.wait (%21, %20, %103, %104 : i32, i32, i32, i32), ^bb1
    }
    %105 = llhd.prb %aon_wkup_count_lo_ds_int : i32
    %106 = llhd.prb %aon_wkup_count_lo_qs_int : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_wkup_count_lo_qs, %c0_i32 after %1 : i32
      llhd.drv %aon_wkup_count_lo_ds, %c0_i32 after %1 : i32
      %208 = llhd.prb %aon_wkup_count_lo_ds_int : i32
      llhd.drv %aon_wkup_count_lo_ds, %208 after %1 : i32
      %209 = llhd.prb %aon_wkup_count_lo_qs_int : i32
      llhd.drv %aon_wkup_count_lo_qs, %209 after %1 : i32
      llhd.wait (%24, %23, %105, %106 : i32, i32, i32, i32), ^bb1
    }
    %107 = llhd.prb %aon_wdog_ctrl_enable_qs_int : i1
    %108 = llhd.prb %aon_wdog_ctrl_pause_in_sleep_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_wdog_ctrl_qs, %c0_i2 after %1 : i2
      %208 = llhd.sig.extract %aon_wdog_ctrl_qs from %false : <i2> -> <i1>
      %209 = llhd.prb %aon_wdog_ctrl_enable_qs_int : i1
      llhd.drv %208, %209 after %1 : i1
      %210 = llhd.sig.extract %aon_wdog_ctrl_qs from %true : <i2> -> <i1>
      %211 = llhd.prb %aon_wdog_ctrl_pause_in_sleep_qs_int : i1
      llhd.drv %210, %211 after %1 : i1
      llhd.wait (%28, %107, %108 : i2, i1, i1), ^bb1
    }
    %109 = llhd.prb %aon_wdog_bark_thold_qs_int : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_wdog_bark_thold_qs, %c0_i32 after %1 : i32
      %208 = llhd.prb %aon_wdog_bark_thold_qs_int : i32
      llhd.drv %aon_wdog_bark_thold_qs, %208 after %1 : i32
      llhd.wait (%30, %109 : i32, i32), ^bb1
    }
    %110 = llhd.prb %aon_wdog_bite_thold_qs_int : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_wdog_bite_thold_qs, %c0_i32 after %1 : i32
      %208 = llhd.prb %aon_wdog_bite_thold_qs_int : i32
      llhd.drv %aon_wdog_bite_thold_qs, %208 after %1 : i32
      llhd.wait (%32, %110 : i32, i32), ^bb1
    }
    %111 = llhd.prb %aon_wdog_count_ds_int : i32
    %112 = llhd.prb %aon_wdog_count_qs_int : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_wdog_count_qs, %c0_i32 after %1 : i32
      llhd.drv %aon_wdog_count_ds, %c0_i32 after %1 : i32
      %208 = llhd.prb %aon_wdog_count_ds_int : i32
      llhd.drv %aon_wdog_count_ds, %208 after %1 : i32
      %209 = llhd.prb %aon_wdog_count_qs_int : i32
      llhd.drv %aon_wdog_count_qs, %209 after %1 : i32
      llhd.wait (%35, %34, %111, %112 : i32, i32, i32, i32), ^bb1
    }
    %113 = llhd.prb %aon_wkup_cause_ds_int : i1
    %114 = llhd.prb %aon_wkup_cause_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %aon_wkup_cause_qs, %false after %1 : i1
      llhd.drv %aon_wkup_cause_ds, %false after %1 : i1
      %208 = llhd.prb %aon_wkup_cause_ds_int : i1
      llhd.drv %aon_wkup_cause_ds, %208 after %1 : i1
      %209 = llhd.prb %aon_wkup_cause_qs_int : i1
      llhd.drv %aon_wkup_cause_qs, %209 after %1 : i1
      llhd.wait (%39, %38, %113, %114 : i1, i1, i1, i1), ^bb1
    }
    %115 = llhd.prb %alert_test_flds_we {sv.namehint = "alert_test_qe"} : i1
    %116 = llhd.sig.struct_extract %41["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %116, %115 after %1 : i1
    %117 = llhd.sig.struct_extract %52["qe"] : <!hw.struct<q: i12, qe: i1>>
    llhd.drv %117, %u_wkup_ctrl0_qe.q_o after %1 : i1
    %118 = llhd.prb %wkup_count_hi_flds_we {sv.namehint = "aon_wkup_count_hi_qe"} : i1
    %119 = llhd.prb %wkup_count_lo_flds_we {sv.namehint = "aon_wkup_count_lo_qe"} : i1
    %120 = comb.and %u_wdog_ctrl_cdc.dst_we_o, %u_wdog_ctrl_cdc.dst_regwen_o {sv.namehint = "aon_wdog_ctrl_gated_we"} : i1
    %121 = comb.and %u_wdog_bark_thold_cdc.dst_we_o, %u_wdog_bark_thold_cdc.dst_regwen_o {sv.namehint = "aon_wdog_bark_thold_gated_we"} : i1
    %122 = comb.and %u_wdog_bite_thold_cdc.dst_we_o, %u_wdog_bite_thold_cdc.dst_regwen_o {sv.namehint = "aon_wdog_bite_thold_gated_we"} : i1
    %123 = llhd.prb %wdog_count_flds_we {sv.namehint = "aon_wdog_count_qe"} : i1
    %124 = llhd.prb %intr_test_flds_we : i2
    %125 = comb.icmp eq %124, %c-1_i2 {sv.namehint = "intr_test_qe"} : i2
    %126 = llhd.sig.struct_extract %85["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %126, %125 after %1 : i1
    %127 = llhd.sig.struct_extract %88["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %127, %125 after %1 : i1
    %128 = llhd.prb %wkup_cause_flds_we {sv.namehint = "aon_wkup_cause_qe"} : i1
    llhd.drv %racl_role_vec, %c0_i2 after %1 : i2
    %129 = llhd.prb %racl_addr_hit_read : i14
    %130 = llhd.prb %racl_addr_hit_write : i14
    %131 = llhd.prb %addr_hit : i14
    %132 = llhd.prb %reg_addr : i6
    %133 = llhd.prb %racl_policies_i_2 : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    %134 = llhd.prb %racl_role_vec : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %racl_addr_hit_read, %c0_i14 after %1 : i14
      llhd.drv %racl_addr_hit_write, %c0_i14 after %1 : i14
      %208 = llhd.sig.extract %addr_hit from %c0_i4 : <i14> -> <i1>
      %209 = llhd.prb %reg_addr : i6
      %210 = comb.icmp eq %209, %c0_i6 : i6
      llhd.drv %208, %210 after %1 : i1
      %211 = llhd.sig.extract %addr_hit from %c1_i4 : <i14> -> <i1>
      %212 = llhd.prb %reg_addr : i6
      %213 = comb.icmp eq %212, %c4_i6 : i6
      llhd.drv %211, %213 after %1 : i1
      %214 = llhd.sig.extract %addr_hit from %c2_i4 : <i14> -> <i1>
      %215 = llhd.prb %reg_addr : i6
      %216 = comb.icmp eq %215, %c8_i6 : i6
      llhd.drv %214, %216 after %1 : i1
      %217 = llhd.sig.extract %addr_hit from %c3_i4 : <i14> -> <i1>
      %218 = llhd.prb %reg_addr : i6
      %219 = comb.icmp eq %218, %c12_i6 : i6
      llhd.drv %217, %219 after %1 : i1
      %220 = llhd.sig.extract %addr_hit from %c4_i4 : <i14> -> <i1>
      %221 = llhd.prb %reg_addr : i6
      %222 = comb.icmp eq %221, %c16_i6 : i6
      llhd.drv %220, %222 after %1 : i1
      %223 = llhd.sig.extract %addr_hit from %c5_i4 : <i14> -> <i1>
      %224 = llhd.prb %reg_addr : i6
      %225 = comb.icmp eq %224, %c20_i6 : i6
      llhd.drv %223, %225 after %1 : i1
      %226 = llhd.sig.extract %addr_hit from %c6_i4 : <i14> -> <i1>
      %227 = llhd.prb %reg_addr : i6
      %228 = comb.icmp eq %227, %c24_i6 : i6
      llhd.drv %226, %228 after %1 : i1
      %229 = llhd.sig.extract %addr_hit from %c7_i4 : <i14> -> <i1>
      %230 = llhd.prb %reg_addr : i6
      %231 = comb.icmp eq %230, %c28_i6 : i6
      llhd.drv %229, %231 after %1 : i1
      %232 = llhd.sig.extract %addr_hit from %c-8_i4 : <i14> -> <i1>
      %233 = llhd.prb %reg_addr : i6
      %234 = comb.icmp eq %233, %c-32_i6 : i6
      llhd.drv %232, %234 after %1 : i1
      %235 = llhd.sig.extract %addr_hit from %c-7_i4 : <i14> -> <i1>
      %236 = llhd.prb %reg_addr : i6
      %237 = comb.icmp eq %236, %c-28_i6 : i6
      llhd.drv %235, %237 after %1 : i1
      %238 = llhd.sig.extract %addr_hit from %c-6_i4 : <i14> -> <i1>
      %239 = llhd.prb %reg_addr : i6
      %240 = comb.icmp eq %239, %c-24_i6 : i6
      llhd.drv %238, %240 after %1 : i1
      %241 = llhd.sig.extract %addr_hit from %c-5_i4 : <i14> -> <i1>
      %242 = llhd.prb %reg_addr : i6
      %243 = comb.icmp eq %242, %c-20_i6 : i6
      llhd.drv %241, %243 after %1 : i1
      %244 = llhd.sig.extract %addr_hit from %c-4_i4 : <i14> -> <i1>
      %245 = llhd.prb %reg_addr : i6
      %246 = comb.icmp eq %245, %c-16_i6 : i6
      llhd.drv %244, %246 after %1 : i1
      %247 = llhd.sig.extract %addr_hit from %c-3_i4 : <i14> -> <i1>
      %248 = llhd.prb %reg_addr : i6
      %249 = comb.icmp eq %248, %c-12_i6 : i6
      llhd.drv %247, %249 after %1 : i1
      %250 = llhd.prb %addr_hit : i14
      llhd.drv %racl_addr_hit_read, %250 after %1 : i14
      %251 = llhd.prb %addr_hit : i14
      llhd.drv %racl_addr_hit_write, %251 after %1 : i14
      llhd.wait (%129, %130, %131, %132, %133, %134 : i14, i14, i14, i6, !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, i2), ^bb1
    }
    %135 = comb.or %u_reg_if.re_o, %8 : i1
    %136 = comb.icmp ne %131, %c0_i14 : i14
    %137 = comb.xor %136, %true : i1
    %138 = comb.and %135, %137 {sv.namehint = "addrmiss"} : i1
    %139 = llhd.sig.struct_extract %racl_error_o["valid"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    %140 = comb.icmp eq %129, %c0_i14 : i14
    %141 = comb.and %u_reg_if.re_o, %140 : i1
    %142 = comb.icmp eq %130, %c0_i14 : i14
    %143 = comb.and %8, %142 : i1
    %144 = comb.or %141, %143 : i1
    %145 = comb.and %136, %144 : i1
    llhd.drv %139, %145 after %1 : i1
    %146 = llhd.sig.struct_extract %racl_error_o["request_address"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    %147 = comb.concat %c0_i26, %132 : i26, i6
    llhd.drv %146, %147 after %1 : i32
    %148 = llhd.sig.struct_extract %racl_error_o["racl_role"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %148, %false after %1 : i1
    %149 = llhd.sig.struct_extract %racl_error_o["overflow"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %149, %false after %1 : i1
    %150 = llhd.sig.struct_extract %racl_error_o["ctn_uid"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %150, %false after %1 : i1
    %151 = llhd.sig.struct_extract %racl_error_o["read_access"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %151, %false after %1 : i1
    %152 = llhd.prb %reg_be : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %208 = llhd.prb %reg_we : i1
      %209 = llhd.prb %racl_addr_hit_write : i14
      %210 = comb.extract %209 from 0 : (i14) -> i1
      %211 = llhd.prb %reg_be : i4
      %212 = comb.extract %211 from 0 : (i4) -> i2
      %213 = comb.extract %211 from 0 : (i4) -> i1
      %214 = comb.xor %213, %true : i1
      %215 = comb.and %210, %214 : i1
      %216 = comb.extract %209 from 1 : (i14) -> i1
      %217 = comb.icmp ne %212, %c-1_i2 : i2
      %218 = comb.and %216, %217 : i1
      %219 = comb.extract %209 from 2 : (i14) -> i1
      %220 = comb.icmp ne %211, %c-1_i4 : i4
      %221 = comb.and %219, %220 : i1
      %222 = comb.extract %209 from 3 : (i14) -> i1
      %223 = comb.icmp ne %211, %c-1_i4 : i4
      %224 = comb.and %222, %223 : i1
      %225 = comb.extract %209 from 4 : (i14) -> i1
      %226 = comb.icmp ne %211, %c-1_i4 : i4
      %227 = comb.and %225, %226 : i1
      %228 = comb.extract %209 from 5 : (i14) -> i1
      %229 = comb.icmp ne %211, %c-1_i4 : i4
      %230 = comb.and %228, %229 : i1
      %231 = comb.extract %209 from 6 : (i14) -> i1
      %232 = comb.and %231, %214 : i1
      %233 = comb.extract %209 from 7 : (i14) -> i1
      %234 = comb.and %233, %214 : i1
      %235 = comb.extract %209 from 8 : (i14) -> i1
      %236 = comb.icmp ne %211, %c-1_i4 : i4
      %237 = comb.and %235, %236 : i1
      %238 = comb.extract %209 from 9 : (i14) -> i1
      %239 = comb.icmp ne %211, %c-1_i4 : i4
      %240 = comb.and %238, %239 : i1
      %241 = comb.extract %209 from 10 : (i14) -> i1
      %242 = comb.icmp ne %211, %c-1_i4 : i4
      %243 = comb.and %241, %242 : i1
      %244 = comb.extract %209 from 11 : (i14) -> i1
      %245 = comb.and %244, %214 : i1
      %246 = comb.extract %209 from 12 : (i14) -> i1
      %247 = comb.and %246, %214 : i1
      %248 = comb.extract %209 from 13 : (i14) -> i1
      %249 = comb.and %248, %214 : i1
      %250 = comb.or %215, %218, %221, %224, %227, %230, %232, %234, %237, %240, %243, %245, %247, %249 : i1
      %251 = comb.and %208, %250 : i1
      llhd.drv %wr_err, %251 after %1 : i1
      llhd.wait (%8, %130, %152, %97 : i1, i14, i4, i1), ^bb1
    }
    %153 = comb.extract %130 from 0 : (i14) -> i1
    %154 = comb.xor %98, %true : i1
    %155 = comb.and %153, %8, %154 : i1
    llhd.drv %alert_test_we, %155 after %1 : i1
    %156 = comb.extract %130 from 1 : (i14) -> i1
    %157 = comb.and %156, %8, %154 : i1
    llhd.drv %wkup_ctrl_we, %157 after %1 : i1
    %158 = comb.extract %130 from 2 : (i14) -> i1
    %159 = comb.and %158, %8, %154 : i1
    llhd.drv %wkup_thold_hi_we, %159 after %1 : i1
    %160 = comb.extract %130 from 3 : (i14) -> i1
    %161 = comb.and %160, %8, %154 : i1
    llhd.drv %wkup_thold_lo_we, %161 after %1 : i1
    %162 = comb.extract %130 from 4 : (i14) -> i1
    %163 = comb.and %162, %8, %154 : i1
    llhd.drv %wkup_count_hi_we, %163 after %1 : i1
    %164 = comb.extract %130 from 5 : (i14) -> i1
    %165 = comb.and %164, %8, %154 : i1
    llhd.drv %wkup_count_lo_we, %165 after %1 : i1
    %166 = comb.extract %130 from 6 : (i14) -> i1
    %167 = comb.and %166, %8, %154 : i1
    llhd.drv %wdog_regwen_we, %167 after %1 : i1
    %168 = comb.extract %130 from 7 : (i14) -> i1
    %169 = comb.and %168, %8, %154 : i1
    llhd.drv %wdog_ctrl_we, %169 after %1 : i1
    %170 = comb.extract %130 from 8 : (i14) -> i1
    %171 = comb.and %170, %8, %154 : i1
    llhd.drv %wdog_bark_thold_we, %171 after %1 : i1
    %172 = comb.extract %130 from 9 : (i14) -> i1
    %173 = comb.and %172, %8, %154 : i1
    llhd.drv %wdog_bite_thold_we, %173 after %1 : i1
    %174 = comb.extract %130 from 10 : (i14) -> i1
    %175 = comb.and %174, %8, %154 : i1
    llhd.drv %wdog_count_we, %175 after %1 : i1
    %176 = comb.extract %130 from 11 : (i14) -> i1
    %177 = comb.and %176, %8, %154 : i1
    llhd.drv %intr_state_we, %177 after %1 : i1
    %178 = comb.extract %u_reg_if.wdata_o from 1 {sv.namehint = "intr_test_wdog_timer_bark_wd"} : (i32) -> i1
    %179 = comb.extract %130 from 12 : (i14) -> i1
    %180 = comb.and %179, %8, %154 : i1
    llhd.drv %intr_test_we, %180 after %1 : i1
    %181 = comb.extract %130 from 13 : (i14) -> i1
    %182 = comb.and %181, %8, %154 : i1
    llhd.drv %wkup_cause_we, %182 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %208 = llhd.sig.extract %reg_we_check from %c0_i4 : <i14> -> <i1>
      %209 = llhd.prb %alert_test_we : i1
      llhd.drv %208, %209 after %1 : i1
      %210 = llhd.sig.extract %reg_we_check from %c1_i4 : <i14> -> <i1>
      %211 = llhd.prb %wkup_ctrl_we : i1
      llhd.drv %210, %211 after %1 : i1
      %212 = llhd.sig.extract %reg_we_check from %c2_i4 : <i14> -> <i1>
      %213 = llhd.prb %wkup_thold_hi_we : i1
      llhd.drv %212, %213 after %1 : i1
      %214 = llhd.sig.extract %reg_we_check from %c3_i4 : <i14> -> <i1>
      %215 = llhd.prb %wkup_thold_lo_we : i1
      llhd.drv %214, %215 after %1 : i1
      %216 = llhd.sig.extract %reg_we_check from %c4_i4 : <i14> -> <i1>
      %217 = llhd.prb %wkup_count_hi_we : i1
      llhd.drv %216, %217 after %1 : i1
      %218 = llhd.sig.extract %reg_we_check from %c5_i4 : <i14> -> <i1>
      %219 = llhd.prb %wkup_count_lo_we : i1
      llhd.drv %218, %219 after %1 : i1
      %220 = llhd.sig.extract %reg_we_check from %c6_i4 : <i14> -> <i1>
      %221 = llhd.prb %wdog_regwen_we : i1
      llhd.drv %220, %221 after %1 : i1
      %222 = llhd.sig.extract %reg_we_check from %c7_i4 : <i14> -> <i1>
      %223 = llhd.prb %wdog_ctrl_we : i1
      llhd.drv %222, %223 after %1 : i1
      %224 = llhd.sig.extract %reg_we_check from %c-8_i4 : <i14> -> <i1>
      %225 = llhd.prb %wdog_bark_thold_we : i1
      llhd.drv %224, %225 after %1 : i1
      %226 = llhd.sig.extract %reg_we_check from %c-7_i4 : <i14> -> <i1>
      %227 = llhd.prb %wdog_bite_thold_we : i1
      llhd.drv %226, %227 after %1 : i1
      %228 = llhd.sig.extract %reg_we_check from %c-6_i4 : <i14> -> <i1>
      %229 = llhd.prb %wdog_count_we : i1
      llhd.drv %228, %229 after %1 : i1
      %230 = llhd.sig.extract %reg_we_check from %c-5_i4 : <i14> -> <i1>
      %231 = llhd.prb %intr_state_we : i1
      llhd.drv %230, %231 after %1 : i1
      %232 = llhd.sig.extract %reg_we_check from %c-4_i4 : <i14> -> <i1>
      %233 = llhd.prb %intr_test_we : i1
      llhd.drv %232, %233 after %1 : i1
      %234 = llhd.sig.extract %reg_we_check from %c-3_i4 : <i14> -> <i1>
      %235 = llhd.prb %wkup_cause_we : i1
      llhd.drv %234, %235 after %1 : i1
      llhd.wait (%7, %40, %12, %15, %17, %19, %22, %62, %26, %29, %31, %33, %76, %82, %36 : i14, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    %183 = llhd.prb %wkup_ctrl_qs : i13
    %184 = llhd.prb %wkup_thold_hi_qs : i32
    %185 = llhd.prb %wkup_thold_lo_qs : i32
    %186 = llhd.prb %wkup_count_hi_qs : i32
    %187 = llhd.prb %wkup_count_lo_qs : i32
    %188 = llhd.prb %wdog_ctrl_qs : i2
    %189 = llhd.prb %wdog_bark_thold_qs : i32
    %190 = llhd.prb %wdog_bite_thold_qs : i32
    %191 = llhd.prb %wdog_count_qs : i32
    %192 = llhd.prb %intr_state_wkup_timer_expired_qs : i1
    %193 = llhd.prb %intr_state_wdog_timer_bark_qs : i1
    %194 = llhd.prb %wkup_cause_qs : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb30
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      %208 = llhd.prb %racl_addr_hit_read : i14
      %209 = comb.extract %208 from 0 : (i14) -> i1
      %210 = comb.icmp ceq %209, %true : i1
      cf.cond_br %210, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %211 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      llhd.drv %211, %false after %1 : i1
      cf.br ^bb30
    ^bb3:  // pred: ^bb1
      %212 = llhd.prb %racl_addr_hit_read : i14
      %213 = comb.extract %212 from 1 : (i14) -> i1
      %214 = comb.icmp ceq %213, %true : i1
      cf.cond_br %214, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %215 = llhd.prb %wkup_ctrl_qs : i13
      %216 = comb.concat %c0_i19, %215 : i19, i13
      llhd.drv %reg_rdata_next, %216 after %1 : i32
      cf.br ^bb30
    ^bb5:  // pred: ^bb3
      %217 = llhd.prb %racl_addr_hit_read : i14
      %218 = comb.extract %217 from 2 : (i14) -> i1
      %219 = comb.icmp ceq %218, %true : i1
      cf.cond_br %219, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %220 = llhd.prb %wkup_thold_hi_qs : i32
      llhd.drv %reg_rdata_next, %220 after %1 : i32
      cf.br ^bb30
    ^bb7:  // pred: ^bb5
      %221 = llhd.prb %racl_addr_hit_read : i14
      %222 = comb.extract %221 from 3 : (i14) -> i1
      %223 = comb.icmp ceq %222, %true : i1
      cf.cond_br %223, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %224 = llhd.prb %wkup_thold_lo_qs : i32
      llhd.drv %reg_rdata_next, %224 after %1 : i32
      cf.br ^bb30
    ^bb9:  // pred: ^bb7
      %225 = llhd.prb %racl_addr_hit_read : i14
      %226 = comb.extract %225 from 4 : (i14) -> i1
      %227 = comb.icmp ceq %226, %true : i1
      cf.cond_br %227, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %228 = llhd.prb %wkup_count_hi_qs : i32
      llhd.drv %reg_rdata_next, %228 after %1 : i32
      cf.br ^bb30
    ^bb11:  // pred: ^bb9
      %229 = llhd.prb %racl_addr_hit_read : i14
      %230 = comb.extract %229 from 5 : (i14) -> i1
      %231 = comb.icmp ceq %230, %true : i1
      cf.cond_br %231, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %232 = llhd.prb %wkup_count_lo_qs : i32
      llhd.drv %reg_rdata_next, %232 after %1 : i32
      cf.br ^bb30
    ^bb13:  // pred: ^bb11
      %233 = llhd.prb %racl_addr_hit_read : i14
      %234 = comb.extract %233 from 6 : (i14) -> i1
      %235 = comb.icmp ceq %234, %true : i1
      cf.cond_br %235, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %236 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %237 = llhd.prb %wdog_regwen_qs : i1
      llhd.drv %236, %237 after %1 : i1
      cf.br ^bb30
    ^bb15:  // pred: ^bb13
      %238 = llhd.prb %racl_addr_hit_read : i14
      %239 = comb.extract %238 from 7 : (i14) -> i1
      %240 = comb.icmp ceq %239, %true : i1
      cf.cond_br %240, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      %241 = llhd.prb %wdog_ctrl_qs : i2
      %242 = comb.concat %c0_i30, %241 : i30, i2
      llhd.drv %reg_rdata_next, %242 after %1 : i32
      cf.br ^bb30
    ^bb17:  // pred: ^bb15
      %243 = llhd.prb %racl_addr_hit_read : i14
      %244 = comb.extract %243 from 8 : (i14) -> i1
      %245 = comb.icmp ceq %244, %true : i1
      cf.cond_br %245, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      %246 = llhd.prb %wdog_bark_thold_qs : i32
      llhd.drv %reg_rdata_next, %246 after %1 : i32
      cf.br ^bb30
    ^bb19:  // pred: ^bb17
      %247 = llhd.prb %racl_addr_hit_read : i14
      %248 = comb.extract %247 from 9 : (i14) -> i1
      %249 = comb.icmp ceq %248, %true : i1
      cf.cond_br %249, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      %250 = llhd.prb %wdog_bite_thold_qs : i32
      llhd.drv %reg_rdata_next, %250 after %1 : i32
      cf.br ^bb30
    ^bb21:  // pred: ^bb19
      %251 = llhd.prb %racl_addr_hit_read : i14
      %252 = comb.extract %251 from 10 : (i14) -> i1
      %253 = comb.icmp ceq %252, %true : i1
      cf.cond_br %253, ^bb22, ^bb23
    ^bb22:  // pred: ^bb21
      %254 = llhd.prb %wdog_count_qs : i32
      llhd.drv %reg_rdata_next, %254 after %1 : i32
      cf.br ^bb30
    ^bb23:  // pred: ^bb21
      %255 = llhd.prb %racl_addr_hit_read : i14
      %256 = comb.extract %255 from 11 : (i14) -> i1
      %257 = comb.icmp ceq %256, %true : i1
      cf.cond_br %257, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      %258 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %259 = llhd.prb %intr_state_wkup_timer_expired_qs : i1
      llhd.drv %258, %259 after %1 : i1
      %260 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %261 = llhd.prb %intr_state_wdog_timer_bark_qs : i1
      llhd.drv %260, %261 after %1 : i1
      cf.br ^bb30
    ^bb25:  // pred: ^bb23
      %262 = llhd.prb %racl_addr_hit_read : i14
      %263 = comb.extract %262 from 12 : (i14) -> i1
      %264 = comb.icmp ceq %263, %true : i1
      cf.cond_br %264, ^bb26, ^bb27
    ^bb26:  // pred: ^bb25
      %265 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      llhd.drv %265, %false after %1 : i1
      %266 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      llhd.drv %266, %false after %1 : i1
      cf.br ^bb30
    ^bb27:  // pred: ^bb25
      %267 = llhd.prb %racl_addr_hit_read : i14
      %268 = comb.extract %267 from 13 : (i14) -> i1
      %269 = comb.icmp ceq %268, %true : i1
      cf.cond_br %269, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      %270 = llhd.prb %wkup_cause_qs : i1
      %271 = comb.concat %c0_i31, %270 : i31, i1
      llhd.drv %reg_rdata_next, %271 after %1 : i32
      cf.br ^bb30
    ^bb29:  // pred: ^bb27
      llhd.drv %reg_rdata_next, %c-1_i32 after %1 : i32
      cf.br ^bb30
    ^bb30:  // 15 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb18, ^bb20, ^bb22, ^bb24, ^bb26, ^bb28, ^bb29
      llhd.wait (%96, %129, %183, %184, %185, %186, %187, %25, %188, %189, %190, %191, %192, %193, %194 : i32, i14, i13, i32, i32, i32, i32, i1, i2, i32, i32, i32, i1, i1, i1), ^bb1
    }
    %195 = llhd.prb %reg_busy_sel : i1
    %a_valid = hw.struct_extract %tl_i["a_valid"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %196 = comb.and %195, %a_valid {sv.namehint = "reg_busy"} : i1
    %197 = llhd.prb %wkup_ctrl_busy : i1
    %198 = llhd.prb %wkup_thold_hi_busy : i1
    %199 = llhd.prb %wkup_thold_lo_busy : i1
    %200 = llhd.prb %wkup_count_hi_busy : i1
    %201 = llhd.prb %wkup_count_lo_busy : i1
    %202 = llhd.prb %wdog_ctrl_busy : i1
    %203 = llhd.prb %wdog_bark_thold_busy : i1
    %204 = llhd.prb %wdog_bite_thold_busy : i1
    %205 = llhd.prb %wdog_count_busy : i1
    %206 = llhd.prb %wkup_cause_busy : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb22
      llhd.drv %reg_busy_sel, %false after %1 : i1
      %208 = llhd.prb %addr_hit : i14
      %209 = comb.extract %208 from 1 : (i14) -> i1
      %210 = comb.icmp ceq %209, %true : i1
      cf.cond_br %210, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %211 = llhd.prb %wkup_ctrl_busy : i1
      llhd.drv %reg_busy_sel, %211 after %1 : i1
      cf.br ^bb22
    ^bb3:  // pred: ^bb1
      %212 = llhd.prb %addr_hit : i14
      %213 = comb.extract %212 from 2 : (i14) -> i1
      %214 = comb.icmp ceq %213, %true : i1
      cf.cond_br %214, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %215 = llhd.prb %wkup_thold_hi_busy : i1
      llhd.drv %reg_busy_sel, %215 after %1 : i1
      cf.br ^bb22
    ^bb5:  // pred: ^bb3
      %216 = llhd.prb %addr_hit : i14
      %217 = comb.extract %216 from 3 : (i14) -> i1
      %218 = comb.icmp ceq %217, %true : i1
      cf.cond_br %218, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %219 = llhd.prb %wkup_thold_lo_busy : i1
      llhd.drv %reg_busy_sel, %219 after %1 : i1
      cf.br ^bb22
    ^bb7:  // pred: ^bb5
      %220 = llhd.prb %addr_hit : i14
      %221 = comb.extract %220 from 4 : (i14) -> i1
      %222 = comb.icmp ceq %221, %true : i1
      cf.cond_br %222, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %223 = llhd.prb %wkup_count_hi_busy : i1
      llhd.drv %reg_busy_sel, %223 after %1 : i1
      cf.br ^bb22
    ^bb9:  // pred: ^bb7
      %224 = llhd.prb %addr_hit : i14
      %225 = comb.extract %224 from 5 : (i14) -> i1
      %226 = comb.icmp ceq %225, %true : i1
      cf.cond_br %226, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %227 = llhd.prb %wkup_count_lo_busy : i1
      llhd.drv %reg_busy_sel, %227 after %1 : i1
      cf.br ^bb22
    ^bb11:  // pred: ^bb9
      %228 = llhd.prb %addr_hit : i14
      %229 = comb.extract %228 from 7 : (i14) -> i1
      %230 = comb.icmp ceq %229, %true : i1
      cf.cond_br %230, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %231 = llhd.prb %wdog_ctrl_busy : i1
      llhd.drv %reg_busy_sel, %231 after %1 : i1
      cf.br ^bb22
    ^bb13:  // pred: ^bb11
      %232 = llhd.prb %addr_hit : i14
      %233 = comb.extract %232 from 8 : (i14) -> i1
      %234 = comb.icmp ceq %233, %true : i1
      cf.cond_br %234, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %235 = llhd.prb %wdog_bark_thold_busy : i1
      llhd.drv %reg_busy_sel, %235 after %1 : i1
      cf.br ^bb22
    ^bb15:  // pred: ^bb13
      %236 = llhd.prb %addr_hit : i14
      %237 = comb.extract %236 from 9 : (i14) -> i1
      %238 = comb.icmp ceq %237, %true : i1
      cf.cond_br %238, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      %239 = llhd.prb %wdog_bite_thold_busy : i1
      llhd.drv %reg_busy_sel, %239 after %1 : i1
      cf.br ^bb22
    ^bb17:  // pred: ^bb15
      %240 = llhd.prb %addr_hit : i14
      %241 = comb.extract %240 from 10 : (i14) -> i1
      %242 = comb.icmp ceq %241, %true : i1
      cf.cond_br %242, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      %243 = llhd.prb %wdog_count_busy : i1
      llhd.drv %reg_busy_sel, %243 after %1 : i1
      cf.br ^bb22
    ^bb19:  // pred: ^bb17
      %244 = llhd.prb %addr_hit : i14
      %245 = comb.extract %244 from 13 : (i14) -> i1
      %246 = comb.icmp ceq %245, %true : i1
      cf.cond_br %246, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      %247 = llhd.prb %wkup_cause_busy : i1
      llhd.drv %reg_busy_sel, %247 after %1 : i1
      cf.br ^bb22
    ^bb21:  // pred: ^bb19
      llhd.drv %reg_busy_sel, %false after %1 : i1
      cf.br ^bb22
    ^bb22:  // 11 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb18, ^bb20, ^bb21
      llhd.wait (%195, %131, %197, %198, %199, %200, %201, %202, %203, %204, %205, %206 : i1, i14, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    %207 = llhd.prb %reg2hw : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>
    llhd.drv %racl_policies_i_2, %racl_policies_i after %1 : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    hw.output %u_rsp_intg_gen.tl_o, %207, %11, %95 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>, !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, i1
  }
  hw.module private @aon_timer_core(in %clk_aon_i : i1, in %rst_aon_ni : i1, in %lc_escalate_en_i : !hw.array<3xi4>, in %sleep_mode_i : i1, in %reg2hw_i : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>, out wkup_count_reg_wr_o : i1, out wkup_count_wr_data_o : i64, out wdog_count_reg_wr_o : i1, out wdog_count_wr_data_o : i32, out wkup_intr_o : i1, out wdog_intr_o : i1, out wdog_reset_req_o : i1) {
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c0_i2 = hw.constant 0 : i2
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [[false, false], [[0 : i12, false], [false]], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [[false], [false]], [0 : i32], [0 : i32], [0 : i32], [[false], [false]], [[false, false], [false, false]], [false]] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>
    %c1_i32 = hw.constant 1 : i32
    %c1_i64 = hw.constant 1 : i64
    %c1_i12 = hw.constant 1 : i12
    %c0_i12 = hw.constant 0 : i12
    %false = hw.constant false
    %clk_aon_i_0 = llhd.sig name "clk_aon_i" %false : i1
    %3 = llhd.prb %clk_aon_i_0 : i1
    %rst_aon_ni_1 = llhd.sig name "rst_aon_ni" %false : i1
    %4 = llhd.prb %rst_aon_ni_1 : i1
    %reg2hw_i_2 = llhd.sig name "reg2hw_i" %2 : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>
    %prescale_count_d = llhd.sig %c0_i12 : i12
    %prescale_count_q = llhd.sig %c0_i12 : i12
    %prescale_en = llhd.sig %false : i1
    %5 = llhd.prb %prescale_count_q : i12
    %6 = comb.add %5, %c1_i12 : i12
    %7 = comb.mux %17, %c0_i12, %6 : i12
    llhd.drv %prescale_count_d, %7 after %1 : i12
    %8 = llhd.prb %reg2hw_i_2 : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>
    %wkup_ctrl = hw.struct_extract %8["wkup_ctrl"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>
    %enable = hw.struct_extract %wkup_ctrl["enable"] : !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>
    %q = hw.struct_extract %enable["q"] : !hw.struct<q: i1>
    %9 = hw.array_get %lc_escalate_en_i[%c0_i2] : !hw.array<3xi4>, i2
    %10 = func.call @"lc_ctrl_pkg::lc_tx_test_false_strict"(%9) : (i4) -> i1
    %11 = comb.and %q, %10 : i1
    llhd.drv %prescale_en, %11 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %31 = llhd.prb %clk_aon_i_0 : i1
      %32 = llhd.prb %rst_aon_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %33 = llhd.prb %clk_aon_i_0 : i1
      %34 = comb.xor bin %31, %true : i1
      %35 = comb.and bin %34, %33 : i1
      %36 = llhd.prb %rst_aon_ni_1 : i1
      %37 = comb.xor bin %36, %true : i1
      %38 = comb.and bin %32, %37 : i1
      %39 = comb.or bin %35, %38 : i1
      cf.cond_br %39, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %40 = llhd.prb %rst_aon_ni_1 : i1
      %41 = comb.xor %40, %true : i1
      cf.cond_br %41, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %prescale_count_q, %c0_i12 after %0 : i12
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %42 = llhd.prb %reg2hw_i_2 : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>
      %wkup_ctrl_14 = hw.struct_extract %42["wkup_ctrl"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>
      %prescaler_15 = hw.struct_extract %wkup_ctrl_14["prescaler"] : !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>
      %qe = hw.struct_extract %prescaler_15["qe"] : !hw.struct<q: i12, qe: i1>
      cf.cond_br %qe, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %prescale_count_q, %c0_i12 after %0 : i12
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %43 = llhd.prb %prescale_en : i1
      cf.cond_br %43, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %44 = llhd.prb %prescale_count_d : i12
      llhd.drv %prescale_count_q, %44 after %0 : i12
      cf.br ^bb1
    }
    %wkup_count_hi = hw.struct_extract %8["wkup_count_hi"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>
    %q_3 = hw.struct_extract %wkup_count_hi["q"] : !hw.struct<q: i32>
    %wkup_count_lo = hw.struct_extract %8["wkup_count_lo"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>
    %q_4 = hw.struct_extract %wkup_count_lo["q"] : !hw.struct<q: i32>
    %12 = comb.concat %q_3, %q_4 {sv.namehint = "wkup_count"} : i32, i32
    %wkup_thold_hi = hw.struct_extract %8["wkup_thold_hi"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>
    %q_5 = hw.struct_extract %wkup_thold_hi["q"] : !hw.struct<q: i32>
    %wkup_thold_lo = hw.struct_extract %8["wkup_thold_lo"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>
    %q_6 = hw.struct_extract %wkup_thold_lo["q"] : !hw.struct<q: i32>
    %13 = comb.concat %q_5, %q_6 {sv.namehint = "wkup_thold"} : i32, i32
    %14 = hw.array_get %lc_escalate_en_i[%c1_i2] : !hw.array<3xi4>, i2
    %15 = func.call @"lc_ctrl_pkg::lc_tx_test_false_strict"(%14) : (i4) -> i1
    %prescaler = hw.struct_extract %wkup_ctrl["prescaler"] : !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>
    %q_7 = hw.struct_extract %prescaler["q"] : !hw.struct<q: i12, qe: i1>
    %16 = comb.icmp eq %5, %q_7 : i12
    %17 = comb.and %15, %q, %16 {sv.namehint = "wkup_incr"} : i1
    %18 = comb.add %12, %c1_i64 : i64
    %19 = comb.icmp uge %12, %13 : i64
    %20 = comb.and %17, %19 : i1
    %wdog_ctrl = hw.struct_extract %8["wdog_ctrl"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>
    %enable_8 = hw.struct_extract %wdog_ctrl["enable"] : !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>
    %q_9 = hw.struct_extract %enable_8["q"] : !hw.struct<q: i1>
    %21 = hw.array_get %lc_escalate_en_i[%c-2_i2] : !hw.array<3xi4>, i2
    %22 = func.call @"lc_ctrl_pkg::lc_tx_test_false_strict"(%21) : (i4) -> i1
    %pause_in_sleep = hw.struct_extract %wdog_ctrl["pause_in_sleep"] : !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>
    %q_10 = hw.struct_extract %pause_in_sleep["q"] : !hw.struct<q: i1>
    %23 = comb.and %sleep_mode_i, %q_10 : i1
    %24 = comb.xor %23, %true : i1
    %25 = comb.and %q_9, %22, %24 {sv.namehint = "wdog_incr"} : i1
    %wdog_count = hw.struct_extract %8["wdog_count"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>
    %q_11 = hw.struct_extract %wdog_count["q"] : !hw.struct<q: i32>
    %26 = comb.add %q_11, %c1_i32 : i32
    %wdog_bark_thold = hw.struct_extract %8["wdog_bark_thold"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>
    %q_12 = hw.struct_extract %wdog_bark_thold["q"] : !hw.struct<q: i32>
    %27 = comb.icmp uge %q_11, %q_12 : i32
    %28 = comb.and %25, %27 : i1
    %wdog_bite_thold = hw.struct_extract %8["wdog_bite_thold"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>
    %q_13 = hw.struct_extract %wdog_bite_thold["q"] : !hw.struct<q: i32>
    %29 = comb.icmp uge %q_11, %q_13 : i32
    %30 = comb.and %25, %29 : i1
    llhd.drv %clk_aon_i_0, %clk_aon_i after %1 : i1
    llhd.drv %rst_aon_ni_1, %rst_aon_ni after %1 : i1
    llhd.drv %reg2hw_i_2, %reg2hw_i after %1 : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>
    hw.output %17, %18, %25, %26, %20, %28, %30 : i1, i64, i1, i32, i1, i1, i1
  }
  hw.module @aon_timer(in %clk_i : i1, in %clk_aon_i : i1, in %rst_ni : i1, in %rst_aon_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %alert_rx_i : !hw.array<1xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, out alert_tx_o : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>, in %racl_policies_i : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, out racl_error_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, in %lc_escalate_en_i : i4, out intr_wkup_timer_expired_o : i1, out intr_wdog_timer_bark_o : i1, out nmi_wdog_timer_bark_o : i1, out wkup_req_o : i1, out aon_timer_rst_req_o : i1, in %sleep_mode_i : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i0 = hw.constant 0 : i0
    %c0_i2 = hw.constant 0 : i2
    %2 = hw.aggregate_constant [[0 : i32, false], [0 : i32, false], [0 : i32, false], [[false, false], [false, false]], [false, false]] : !hw.struct<wkup_count_hi: !hw.struct<d: i32, de: i1>, wkup_count_lo: !hw.struct<d: i32, de: i1>, wdog_count: !hw.struct<d: i32, de: i1>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<d: i1, de: i1>, wkup_timer_expired: !hw.struct<d: i1, de: i1>>, wkup_cause: !hw.struct<d: i1, de: i1>>
    %3 = hw.aggregate_constant [[false, false]] : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    %false = hw.constant false
    %true = hw.constant true
    %c-1_i2 = hw.constant -1 : i2
    %clk_aon_i_0 = llhd.sig name "clk_aon_i" %false : i1
    %4 = llhd.prb %clk_aon_i_0 : i1
    %rst_aon_ni_1 = llhd.sig name "rst_aon_ni" %false : i1
    %5 = llhd.prb %rst_aon_ni_1 : i1
    %alert_tx_o = llhd.sig %3 : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    %hw2reg = llhd.sig %2 : !hw.struct<wkup_count_hi: !hw.struct<d: i32, de: i1>, wkup_count_lo: !hw.struct<d: i32, de: i1>, wdog_count: !hw.struct<d: i32, de: i1>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<d: i1, de: i1>, wkup_timer_expired: !hw.struct<d: i1, de: i1>>, wkup_cause: !hw.struct<d: i1, de: i1>>
    %intr_test_q = llhd.sig %c0_i2 : i2
    %intr_state_q = llhd.sig %c0_i2 : i2
    %aon_rst_req_d = llhd.sig %false : i1
    %aon_rst_req_q = llhd.sig %false : i1
    %alerts = llhd.sig %false : i1
    %u_sync_sleep_mode.q_o = hw.instance "u_sync_sleep_mode" @prim_flop_2sync(clk_i: %4: i1, rst_ni: %5: i1, d_i: %sleep_mode_i: i1) -> (q_o: i1) {sv.namehint = "aon_sleep_mode"}
    %6 = llhd.prb %hw2reg : !hw.struct<wkup_count_hi: !hw.struct<d: i32, de: i1>, wkup_count_lo: !hw.struct<d: i32, de: i1>, wdog_count: !hw.struct<d: i32, de: i1>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<d: i1, de: i1>, wkup_timer_expired: !hw.struct<d: i1, de: i1>>, wkup_cause: !hw.struct<d: i1, de: i1>>
    %u_reg.tl_o, %u_reg.reg2hw, %u_reg.racl_error_o, %u_reg.intg_err_o = hw.instance "u_reg" @aon_timer_reg_top(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clk_aon_i: %4: i1, rst_aon_ni: %5: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, hw2reg: %6: !hw.struct<wkup_count_hi: !hw.struct<d: i32, de: i1>, wkup_count_lo: !hw.struct<d: i32, de: i1>, wdog_count: !hw.struct<d: i32, de: i1>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<d: i1, de: i1>, wkup_timer_expired: !hw.struct<d: i1, de: i1>>, wkup_cause: !hw.struct<d: i1, de: i1>>, racl_policies_i: %racl_policies_i: !hw.array<1xstruct<write_perm: i2, read_perm: i2>>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, reg2hw: !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>, racl_error_o: !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, intg_err_o: i1) {sv.namehint = "reg2hw"}
    llhd.drv %alerts, %u_reg.intg_err_o after %1 : i1
    %7 = llhd.prb %alerts : i1
    %8 = hw.array_get %alert_rx_i[%c0_i0] : !hw.array<1xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, i0
    %9 = llhd.sig.array_get %alert_tx_o[%c0_i0] : <!hw.array<1xstruct<alert_p: i1, alert_n: i1>>>
    %gen_alert_tx_0.u_prim_alert_sender.alert_ack_o, %gen_alert_tx_0.u_prim_alert_sender.alert_state_o, %gen_alert_tx_0.u_prim_alert_sender.alert_tx_o = hw.instance "gen_alert_tx_0.u_prim_alert_sender" @prim_alert_sender(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, alert_test_i: %24: i1, alert_req_i: %7: i1, alert_rx_i: %8: !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>) -> (alert_ack_o: i1, alert_state_o: i1, alert_tx_o: !hw.struct<alert_p: i1, alert_n: i1>)
    llhd.drv %9, %gen_alert_tx_0.u_prim_alert_sender.alert_tx_o after %1 : !hw.struct<alert_p: i1, alert_n: i1>
    %u_lc_sync_escalate_en.lc_en_o = hw.instance "u_lc_sync_escalate_en" @prim_lc_sync(clk_i: %4: i1, rst_ni: %5: i1, lc_en_i: %lc_escalate_en_i: i4) -> (lc_en_o: !hw.array<3xi4>) {sv.namehint = "lc_escalate_en"}
    %u_core.wkup_count_reg_wr_o, %u_core.wkup_count_wr_data_o, %u_core.wdog_count_reg_wr_o, %u_core.wdog_count_wr_data_o, %u_core.wkup_intr_o, %u_core.wdog_intr_o, %u_core.wdog_reset_req_o = hw.instance "u_core" @aon_timer_core(clk_aon_i: %4: i1, rst_aon_ni: %5: i1, lc_escalate_en_i: %u_lc_sync_escalate_en.lc_en_o: !hw.array<3xi4>, sleep_mode_i: %u_sync_sleep_mode.q_o: i1, reg2hw_i: %u_reg.reg2hw: !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>) -> (wkup_count_reg_wr_o: i1, wkup_count_wr_data_o: i64, wdog_count_reg_wr_o: i1, wdog_count_wr_data_o: i32, wkup_intr_o: i1, wdog_intr_o: i1, wdog_reset_req_o: i1) {sv.namehint = "aon_rst_req_set"}
    %10 = comb.concat %u_core.wdog_intr_o, %u_core.wkup_intr_o : i1, i1
    %u_aon_intr_flop.q_o = hw.instance "u_aon_intr_flop" @prim_flop(clk_i: %4: i1, rst_ni: %5: i1, d_i: %10: i2) -> (q_o: i2) {sv.namehint = "aon_intr_set"}
    %u_intr_sync.q_sync_o, %u_intr_sync.q_posedge_pulse_o, %u_intr_sync.q_negedge_pulse_o = hw.instance "u_intr_sync" @prim_edge_detector(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_aon_intr_flop.q_o: i2) -> (q_sync_o: i2, q_posedge_pulse_o: i2, q_negedge_pulse_o: i2) {sv.namehint = "intr_set"}
    %11 = llhd.prb %intr_test_q : i2
    %12 = llhd.prb %intr_state_q : i2
    %u_intr_hw.hw2reg_intr_state_de_o, %u_intr_hw.hw2reg_intr_state_d_o, %u_intr_hw.intr_o = hw.instance "u_intr_hw" @prim_intr_hw(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, event_intr_i: %u_intr_sync.q_posedge_pulse_o: i2, reg2hw_intr_enable_q_i: %c-1_i2: i2, reg2hw_intr_test_q_i: %11: i2, reg2hw_intr_test_qe_i: %qe_3: i1, reg2hw_intr_state_q_i: %12: i2) -> (hw2reg_intr_state_de_o: i1, hw2reg_intr_state_d_o: i2, intr_o: i2) {sv.namehint = "intr_out"}
    %13 = llhd.sig.struct_extract %hw2reg["wkup_count_lo"] : <!hw.struct<wkup_count_hi: !hw.struct<d: i32, de: i1>, wkup_count_lo: !hw.struct<d: i32, de: i1>, wdog_count: !hw.struct<d: i32, de: i1>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<d: i1, de: i1>, wkup_timer_expired: !hw.struct<d: i1, de: i1>>, wkup_cause: !hw.struct<d: i1, de: i1>>>
    %14 = llhd.sig.struct_extract %13["de"] : <!hw.struct<d: i32, de: i1>>
    llhd.drv %14, %u_core.wkup_count_reg_wr_o after %1 : i1
    %15 = llhd.sig.struct_extract %hw2reg["wkup_count_hi"] : <!hw.struct<wkup_count_hi: !hw.struct<d: i32, de: i1>, wkup_count_lo: !hw.struct<d: i32, de: i1>, wdog_count: !hw.struct<d: i32, de: i1>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<d: i1, de: i1>, wkup_timer_expired: !hw.struct<d: i1, de: i1>>, wkup_cause: !hw.struct<d: i1, de: i1>>>
    %16 = llhd.sig.struct_extract %15["de"] : <!hw.struct<d: i32, de: i1>>
    llhd.drv %16, %u_core.wkup_count_reg_wr_o after %1 : i1
    %17 = llhd.sig.struct_extract %13["d"] : <!hw.struct<d: i32, de: i1>>
    %18 = comb.extract %u_core.wkup_count_wr_data_o from 0 : (i64) -> i32
    llhd.drv %17, %18 after %1 : i32
    %19 = llhd.sig.struct_extract %15["d"] : <!hw.struct<d: i32, de: i1>>
    %20 = comb.extract %u_core.wkup_count_wr_data_o from 32 : (i64) -> i32
    llhd.drv %19, %20 after %1 : i32
    %21 = llhd.sig.struct_extract %hw2reg["wdog_count"] : <!hw.struct<wkup_count_hi: !hw.struct<d: i32, de: i1>, wkup_count_lo: !hw.struct<d: i32, de: i1>, wdog_count: !hw.struct<d: i32, de: i1>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<d: i1, de: i1>, wkup_timer_expired: !hw.struct<d: i1, de: i1>>, wkup_cause: !hw.struct<d: i1, de: i1>>>
    %22 = llhd.sig.struct_extract %21["de"] : <!hw.struct<d: i32, de: i1>>
    llhd.drv %22, %u_core.wdog_count_reg_wr_o after %1 : i1
    %23 = llhd.sig.struct_extract %21["d"] : <!hw.struct<d: i32, de: i1>>
    llhd.drv %23, %u_core.wdog_count_wr_data_o after %1 : i32
    %alert_test = hw.struct_extract %u_reg.reg2hw["alert_test"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>
    %q = hw.struct_extract %alert_test["q"] : !hw.struct<q: i1, qe: i1>
    %qe = hw.struct_extract %alert_test["qe"] : !hw.struct<q: i1, qe: i1>
    %24 = comb.and %q, %qe : i1
    %25 = llhd.sig.struct_extract %hw2reg["wkup_cause"] : <!hw.struct<wkup_count_hi: !hw.struct<d: i32, de: i1>, wkup_count_lo: !hw.struct<d: i32, de: i1>, wdog_count: !hw.struct<d: i32, de: i1>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<d: i1, de: i1>, wkup_timer_expired: !hw.struct<d: i1, de: i1>>, wkup_cause: !hw.struct<d: i1, de: i1>>>
    %26 = llhd.sig.struct_extract %25["de"] : <!hw.struct<d: i1, de: i1>>
    %27 = comb.or %u_core.wkup_intr_o, %u_core.wdog_intr_o : i1
    llhd.drv %26, %27 after %1 : i1
    %28 = llhd.sig.struct_extract %25["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %28, %true after %1 : i1
    %wkup_cause = hw.struct_extract %u_reg.reg2hw["wkup_cause"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>
    %q_2 = hw.struct_extract %wkup_cause["q"] : !hw.struct<q: i1>
    %intr_test = hw.struct_extract %u_reg.reg2hw["intr_test"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>
    %wkup_timer_expired = hw.struct_extract %intr_test["wkup_timer_expired"] : !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>
    %qe_3 = hw.struct_extract %wkup_timer_expired["qe"] {sv.namehint = "intr_test_qe"} : !hw.struct<q: i1, qe: i1>
    %wdog_timer_bark = hw.struct_extract %intr_test["wdog_timer_bark"] : !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>
    %29 = llhd.sig.extract %intr_test_q from %false : <i2> -> <i1>
    %q_4 = hw.struct_extract %wkup_timer_expired["q"] : !hw.struct<q: i1, qe: i1>
    llhd.drv %29, %q_4 after %1 : i1
    %30 = llhd.sig.extract %intr_state_q from %false : <i2> -> <i1>
    %intr_state = hw.struct_extract %u_reg.reg2hw["intr_state"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, wkup_ctrl: !hw.struct<prescaler: !hw.struct<q: i12, qe: i1>, enable: !hw.struct<q: i1>>, wkup_thold_hi: !hw.struct<q: i32>, wkup_thold_lo: !hw.struct<q: i32>, wkup_count_hi: !hw.struct<q: i32>, wkup_count_lo: !hw.struct<q: i32>, wdog_ctrl: !hw.struct<pause_in_sleep: !hw.struct<q: i1>, enable: !hw.struct<q: i1>>, wdog_bark_thold: !hw.struct<q: i32>, wdog_bite_thold: !hw.struct<q: i32>, wdog_count: !hw.struct<q: i32>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>, intr_test: !hw.struct<wdog_timer_bark: !hw.struct<q: i1, qe: i1>, wkup_timer_expired: !hw.struct<q: i1, qe: i1>>, wkup_cause: !hw.struct<q: i1>>
    %wkup_timer_expired_5 = hw.struct_extract %intr_state["wkup_timer_expired"] : !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>
    %q_6 = hw.struct_extract %wkup_timer_expired_5["q"] : !hw.struct<q: i1>
    llhd.drv %30, %q_6 after %1 : i1
    %31 = llhd.sig.extract %intr_test_q from %true : <i2> -> <i1>
    %q_7 = hw.struct_extract %wdog_timer_bark["q"] : !hw.struct<q: i1, qe: i1>
    llhd.drv %31, %q_7 after %1 : i1
    %32 = llhd.sig.extract %intr_state_q from %true : <i2> -> <i1>
    %wdog_timer_bark_8 = hw.struct_extract %intr_state["wdog_timer_bark"] : !hw.struct<wdog_timer_bark: !hw.struct<q: i1>, wkup_timer_expired: !hw.struct<q: i1>>
    %q_9 = hw.struct_extract %wdog_timer_bark_8["q"] : !hw.struct<q: i1>
    llhd.drv %32, %q_9 after %1 : i1
    %33 = llhd.sig.struct_extract %hw2reg["intr_state"] : <!hw.struct<wkup_count_hi: !hw.struct<d: i32, de: i1>, wkup_count_lo: !hw.struct<d: i32, de: i1>, wdog_count: !hw.struct<d: i32, de: i1>, intr_state: !hw.struct<wdog_timer_bark: !hw.struct<d: i1, de: i1>, wkup_timer_expired: !hw.struct<d: i1, de: i1>>, wkup_cause: !hw.struct<d: i1, de: i1>>>
    %34 = llhd.sig.struct_extract %33["wkup_timer_expired"] : <!hw.struct<wdog_timer_bark: !hw.struct<d: i1, de: i1>, wkup_timer_expired: !hw.struct<d: i1, de: i1>>>
    %35 = llhd.sig.struct_extract %34["d"] : <!hw.struct<d: i1, de: i1>>
    %36 = comb.extract %u_intr_hw.hw2reg_intr_state_d_o from 0 : (i2) -> i1
    llhd.drv %35, %36 after %1 : i1
    %37 = llhd.sig.struct_extract %34["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %37, %u_intr_hw.hw2reg_intr_state_de_o after %1 : i1
    %38 = llhd.sig.struct_extract %33["wdog_timer_bark"] : <!hw.struct<wdog_timer_bark: !hw.struct<d: i1, de: i1>, wkup_timer_expired: !hw.struct<d: i1, de: i1>>>
    %39 = llhd.sig.struct_extract %38["d"] : <!hw.struct<d: i1, de: i1>>
    %40 = comb.extract %u_intr_hw.hw2reg_intr_state_d_o from 1 : (i2) -> i1
    llhd.drv %39, %40 after %1 : i1
    %41 = llhd.sig.struct_extract %38["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %41, %u_intr_hw.hw2reg_intr_state_de_o after %1 : i1
    %42 = comb.extract %u_intr_hw.intr_o from 0 : (i2) -> i1
    %43 = comb.extract %u_intr_hw.intr_o from 1 : (i2) -> i1
    %44 = llhd.prb %aon_rst_req_q : i1
    %45 = comb.or %u_core.wdog_reset_req_o, %44 : i1
    llhd.drv %aon_rst_req_d, %45 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %47 = llhd.prb %clk_aon_i_0 : i1
      %48 = llhd.prb %rst_aon_ni_1 : i1
      llhd.wait (%4, %5 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %49 = llhd.prb %clk_aon_i_0 : i1
      %50 = comb.xor bin %47, %true : i1
      %51 = comb.and bin %50, %49 : i1
      %52 = llhd.prb %rst_aon_ni_1 : i1
      %53 = comb.xor bin %52, %true : i1
      %54 = comb.and bin %48, %53 : i1
      %55 = comb.or bin %51, %54 : i1
      cf.cond_br %55, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %56 = llhd.prb %rst_aon_ni_1 : i1
      %57 = comb.xor %56, %true : i1
      cf.cond_br %57, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %aon_rst_req_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %58 = llhd.prb %aon_rst_req_d : i1
      llhd.drv %aon_rst_req_q, %58 after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_aon_i_0, %clk_aon_i after %1 : i1
    llhd.drv %rst_aon_ni_1, %rst_aon_ni after %1 : i1
    %46 = llhd.prb %alert_tx_o : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    hw.output %u_reg.tl_o, %46, %u_reg.racl_error_o, %42, %43, %43, %q_2, %44 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.array<1xstruct<alert_p: i1, alert_n: i1>>, !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, i1, i1, i1, i1, i1
  }
}
