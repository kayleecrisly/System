module {
  hw.module private @prim_buf(in %in_i : i12, out out_o : i12) {
    hw.output %in_i : i12
  }
  hw.module private @prim_buf_26(in %in_i : i2, out out_o : i2) {
    hw.output %in_i : i2
  }
  hw.module private @prim_buf_28(in %in_i : i1, out out_o : i1) {
    hw.output %in_i : i1
  }
  hw.module private @prim_flop_2sync(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %d_i_0 = llhd.sig name "d_i" %false : i1
    %d_o = llhd.sig %false : i1
    %1 = llhd.prb %d_o : i1
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_36(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i1) -> (q_o: i1) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_36(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i1) -> (q_o: i1)
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
    %false = hw.constant false
    %d_i_0 = llhd.sig name "d_i" %false : i1
    %d_o = llhd.sig %false : i1
    %1 = llhd.prb %d_o : i1
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_37(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i1) -> (q_o: i1) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_37(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i1) -> (q_o: i1)
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
  hw.module private @prim_flop_en(in %clk_i : i1, in %rst_ni : i1, in %en_i : i1, in %d_i : i1, out q_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %d_i_2 = llhd.sig name "d_i" %false : i1
    %q_o = llhd.sig %false : i1
    %en = llhd.sig %false : i1
    llhd.drv %en, %en_i after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
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
      llhd.drv %q_o, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %16 = llhd.prb %en : i1
      cf.cond_br %16, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %17 = llhd.prb %d_i_2 : i1
      llhd.drv %q_o, %17 after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %d_i_2, %d_i after %1 : i1
    %4 = llhd.prb %q_o : i1
    hw.output %4 : i1
  }
  hw.module private @prim_flop(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_o : i2) {
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
  hw.module private @prim_flop_36(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
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
  hw.module private @prim_flop_37(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
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
    %gen_async.i_sync_p.q_o = hw.instance "gen_async.i_sync_p" @prim_flop_2sync(clk_i: %2: i1, rst_ni: %3: i1, d_i: %diff_pi: i1) -> (q_o: i1)
    llhd.drv %gen_async.diff_pd, %gen_async.i_sync_p.q_o after %1 : i1
    %gen_async.i_sync_n.q_o = hw.instance "gen_async.i_sync_n" @prim_flop_2sync_27(clk_i: %2: i1, rst_ni: %3: i1, d_i: %diff_ni: i1) -> (q_o: i1)
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
  hw.module private @prim_fifo_sync_cnt(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %incr_wptr_i : i1, in %incr_rptr_i : i1, out wptr_o : i2, out rptr_o : i2, out full_o : i1, out empty_o : i1, out depth_o : i3, out err_o : i1) {
    %c1_i3 = hw.constant 1 : i3
    %c-1_i2 = hw.constant -1 : i2
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i3 = hw.constant 0 : i3
    %c0_i2 = hw.constant 0 : i2
    %false = hw.constant false
    %c-4_i3 = hw.constant -4 : i3
    %true = hw.constant true
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %clr_i_2 = llhd.sig name "clr_i" %false : i1
    %incr_wptr_i_3 = llhd.sig name "incr_wptr_i" %false : i1
    %incr_rptr_i_4 = llhd.sig name "incr_rptr_i" %false : i1
    %wptr_o = llhd.sig %c0_i2 : i2
    %rptr_o = llhd.sig %c0_i2 : i2
    %wptr_wrap_cnt_q = llhd.sig %c0_i3 : i3
    %wptr_wrap_set_cnt = llhd.sig %c0_i3 : i3
    %rptr_wrap_cnt_q = llhd.sig %c0_i3 : i3
    %rptr_wrap_set_cnt = llhd.sig %c0_i3 : i3
    %wptr_wrap_msb = llhd.sig %false : i1
    %rptr_wrap_msb = llhd.sig %false : i1
    %wptr_wrap_set = llhd.sig %false : i1
    %rptr_wrap_set = llhd.sig %false : i1
    %4 = llhd.prb %wptr_wrap_cnt_q : i3
    %5 = comb.extract %4 from 0 : (i3) -> i2
    llhd.drv %wptr_o, %5 after %1 : i2
    %6 = llhd.prb %rptr_wrap_cnt_q : i3
    %7 = comb.extract %6 from 0 : (i3) -> i2
    llhd.drv %rptr_o, %7 after %1 : i2
    %8 = comb.extract %4 from 2 : (i3) -> i1
    llhd.drv %wptr_wrap_msb, %8 after %1 : i1
    %9 = comb.extract %6 from 2 : (i3) -> i1
    llhd.drv %rptr_wrap_msb, %9 after %1 : i1
    %10 = llhd.prb %incr_wptr_i_3 : i1
    %11 = llhd.prb %wptr_o : i2
    %12 = comb.icmp eq %11, %c-1_i2 : i2
    %13 = comb.and %10, %12 : i1
    llhd.drv %wptr_wrap_set, %13 after %1 : i1
    %14 = llhd.prb %incr_rptr_i_4 : i1
    %15 = llhd.prb %rptr_o : i2
    %16 = comb.icmp eq %15, %c-1_i2 : i2
    %17 = comb.and %14, %16 : i1
    llhd.drv %rptr_wrap_set, %17 after %1 : i1
    %18 = llhd.prb %wptr_wrap_msb : i1
    %19 = comb.xor %18, %true : i1
    %20 = comb.concat %19, %c0_i2 : i1, i2
    llhd.drv %wptr_wrap_set_cnt, %20 after %1 : i3
    %21 = llhd.prb %rptr_wrap_msb : i1
    %22 = comb.xor %21, %true : i1
    %23 = comb.concat %22, %c0_i2 : i1, i2
    llhd.drv %rptr_wrap_set_cnt, %23 after %1 : i3
    %24 = comb.xor %6, %c-4_i3 : i3
    %25 = comb.icmp eq %4, %24 : i3
    %26 = comb.icmp eq %4, %6 : i3
    %27 = comb.icmp eq %18, %21 : i1
    %28 = comb.concat %false, %11 : i1, i2
    %29 = comb.concat %false, %15 : i1, i2
    %30 = comb.sub %28, %29 : i3
    %31 = comb.sub %c-4_i3, %29 : i3
    %32 = comb.add %31, %28 : i3
    %33 = comb.mux %27, %30, %32 : i3
    %34 = comb.mux %25, %c-4_i3, %33 : i3
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      %35 = llhd.prb %clk_i_0 : i1
      %36 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %wptr_wrap_cnt_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %46 = llhd.prb %clr_i_2 : i1
      cf.cond_br %46, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %wptr_wrap_cnt_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %47 = llhd.prb %wptr_wrap_set : i1
      cf.cond_br %47, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %48 = llhd.prb %wptr_wrap_set_cnt : i3
      llhd.drv %wptr_wrap_cnt_q, %48 after %0 : i3
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %49 = llhd.prb %incr_wptr_i_3 : i1
      cf.cond_br %49, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      %50 = llhd.prb %wptr_wrap_cnt_q : i3
      %51 = comb.add %50, %c1_i3 : i3
      llhd.drv %wptr_wrap_cnt_q, %51 after %0 : i3
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      %35 = llhd.prb %clk_i_0 : i1
      %36 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %rptr_wrap_cnt_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %46 = llhd.prb %clr_i_2 : i1
      cf.cond_br %46, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %rptr_wrap_cnt_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %47 = llhd.prb %rptr_wrap_set : i1
      cf.cond_br %47, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %48 = llhd.prb %rptr_wrap_set_cnt : i3
      llhd.drv %rptr_wrap_cnt_q, %48 after %0 : i3
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %49 = llhd.prb %incr_rptr_i_4 : i1
      cf.cond_br %49, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      %50 = llhd.prb %rptr_wrap_cnt_q : i3
      %51 = comb.add %50, %c1_i3 : i3
      llhd.drv %rptr_wrap_cnt_q, %51 after %0 : i3
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %clr_i_2, %clr_i after %1 : i1
    llhd.drv %incr_wptr_i_3, %incr_wptr_i after %1 : i1
    llhd.drv %incr_rptr_i_4, %incr_rptr_i after %1 : i1
    hw.output %11, %15, %25, %26, %34, %false : i2, i2, i1, i1, i3, i1
  }
  hw.module private @prim_fifo_sync_cnt_29(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %incr_wptr_i : i1, in %incr_rptr_i : i1, out wptr_o : i7, out rptr_o : i7, out full_o : i1, out empty_o : i1, out depth_o : i7, out err_o : i1) {
    %c1_i8 = hw.constant 1 : i8
    %c-128_i8 = hw.constant -128 : i8
    %c-57_i7 = hw.constant -57 : i7
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i8 = hw.constant 0 : i8
    %c0_i7 = hw.constant 0 : i7
    %false = hw.constant false
    %c-56_i7 = hw.constant -56 : i7
    %true = hw.constant true
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %clr_i_2 = llhd.sig name "clr_i" %false : i1
    %incr_wptr_i_3 = llhd.sig name "incr_wptr_i" %false : i1
    %incr_rptr_i_4 = llhd.sig name "incr_rptr_i" %false : i1
    %wptr_o = llhd.sig %c0_i7 : i7
    %rptr_o = llhd.sig %c0_i7 : i7
    %wptr_wrap_cnt_q = llhd.sig %c0_i8 : i8
    %wptr_wrap_set_cnt = llhd.sig %c0_i8 : i8
    %rptr_wrap_cnt_q = llhd.sig %c0_i8 : i8
    %rptr_wrap_set_cnt = llhd.sig %c0_i8 : i8
    %wptr_wrap_msb = llhd.sig %false : i1
    %rptr_wrap_msb = llhd.sig %false : i1
    %wptr_wrap_set = llhd.sig %false : i1
    %rptr_wrap_set = llhd.sig %false : i1
    %4 = llhd.prb %wptr_wrap_cnt_q : i8
    %5 = comb.extract %4 from 0 : (i8) -> i7
    llhd.drv %wptr_o, %5 after %1 : i7
    %6 = llhd.prb %rptr_wrap_cnt_q : i8
    %7 = comb.extract %6 from 0 : (i8) -> i7
    llhd.drv %rptr_o, %7 after %1 : i7
    %8 = comb.extract %4 from 7 : (i8) -> i1
    llhd.drv %wptr_wrap_msb, %8 after %1 : i1
    %9 = comb.extract %6 from 7 : (i8) -> i1
    llhd.drv %rptr_wrap_msb, %9 after %1 : i1
    %10 = llhd.prb %incr_wptr_i_3 : i1
    %11 = llhd.prb %wptr_o : i7
    %12 = comb.icmp eq %11, %c-57_i7 : i7
    %13 = comb.and %10, %12 : i1
    llhd.drv %wptr_wrap_set, %13 after %1 : i1
    %14 = llhd.prb %incr_rptr_i_4 : i1
    %15 = llhd.prb %rptr_o : i7
    %16 = comb.icmp eq %15, %c-57_i7 : i7
    %17 = comb.and %14, %16 : i1
    llhd.drv %rptr_wrap_set, %17 after %1 : i1
    %18 = llhd.prb %wptr_wrap_msb : i1
    %19 = comb.xor %18, %true : i1
    %20 = comb.concat %19, %c0_i7 : i1, i7
    llhd.drv %wptr_wrap_set_cnt, %20 after %1 : i8
    %21 = llhd.prb %rptr_wrap_msb : i1
    %22 = comb.xor %21, %true : i1
    %23 = comb.concat %22, %c0_i7 : i1, i7
    llhd.drv %rptr_wrap_set_cnt, %23 after %1 : i8
    %24 = comb.xor %6, %c-128_i8 : i8
    %25 = comb.icmp eq %4, %24 : i8
    %26 = comb.icmp eq %4, %6 : i8
    %27 = comb.icmp eq %18, %21 : i1
    %28 = comb.sub %11, %15 : i7
    %29 = comb.sub %c-56_i7, %15 : i7
    %30 = comb.add %29, %11 : i7
    %31 = comb.mux %27, %28, %30 : i7
    %32 = comb.mux %25, %c-56_i7, %31 : i7
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
      llhd.drv %wptr_wrap_cnt_q, %c0_i8 after %0 : i8
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %44 = llhd.prb %clr_i_2 : i1
      cf.cond_br %44, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %wptr_wrap_cnt_q, %c0_i8 after %0 : i8
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %45 = llhd.prb %wptr_wrap_set : i1
      cf.cond_br %45, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %46 = llhd.prb %wptr_wrap_set_cnt : i8
      llhd.drv %wptr_wrap_cnt_q, %46 after %0 : i8
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %47 = llhd.prb %incr_wptr_i_3 : i1
      cf.cond_br %47, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      %48 = llhd.prb %wptr_wrap_cnt_q : i8
      %49 = comb.add %48, %c1_i8 : i8
      llhd.drv %wptr_wrap_cnt_q, %49 after %0 : i8
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
      llhd.drv %rptr_wrap_cnt_q, %c0_i8 after %0 : i8
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %44 = llhd.prb %clr_i_2 : i1
      cf.cond_br %44, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %rptr_wrap_cnt_q, %c0_i8 after %0 : i8
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %45 = llhd.prb %rptr_wrap_set : i1
      cf.cond_br %45, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %46 = llhd.prb %rptr_wrap_set_cnt : i8
      llhd.drv %rptr_wrap_cnt_q, %46 after %0 : i8
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %47 = llhd.prb %incr_rptr_i_4 : i1
      cf.cond_br %47, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      %48 = llhd.prb %rptr_wrap_cnt_q : i8
      %49 = comb.add %48, %c1_i8 : i8
      llhd.drv %rptr_wrap_cnt_q, %49 after %0 : i8
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %clr_i_2, %clr_i after %1 : i1
    llhd.drv %incr_wptr_i_3, %incr_wptr_i after %1 : i1
    llhd.drv %incr_rptr_i_4, %incr_rptr_i after %1 : i1
    hw.output %11, %15, %25, %26, %32, %false : i7, i7, i1, i1, i7, i1
  }
  hw.module private @prim_fifo_sync_cnt_30(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %incr_wptr_i : i1, in %incr_rptr_i : i1, out wptr_o : i6, out rptr_o : i6, out full_o : i1, out empty_o : i1, out depth_o : i7, out err_o : i1) {
    %c1_i7 = hw.constant 1 : i7
    %c-1_i6 = hw.constant -1 : i6
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i7 = hw.constant 0 : i7
    %c0_i6 = hw.constant 0 : i6
    %false = hw.constant false
    %c-64_i7 = hw.constant -64 : i7
    %true = hw.constant true
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %clr_i_2 = llhd.sig name "clr_i" %false : i1
    %incr_wptr_i_3 = llhd.sig name "incr_wptr_i" %false : i1
    %incr_rptr_i_4 = llhd.sig name "incr_rptr_i" %false : i1
    %wptr_o = llhd.sig %c0_i6 : i6
    %rptr_o = llhd.sig %c0_i6 : i6
    %wptr_wrap_cnt_q = llhd.sig %c0_i7 : i7
    %wptr_wrap_set_cnt = llhd.sig %c0_i7 : i7
    %rptr_wrap_cnt_q = llhd.sig %c0_i7 : i7
    %rptr_wrap_set_cnt = llhd.sig %c0_i7 : i7
    %wptr_wrap_msb = llhd.sig %false : i1
    %rptr_wrap_msb = llhd.sig %false : i1
    %wptr_wrap_set = llhd.sig %false : i1
    %rptr_wrap_set = llhd.sig %false : i1
    %4 = llhd.prb %wptr_wrap_cnt_q : i7
    %5 = comb.extract %4 from 0 : (i7) -> i6
    llhd.drv %wptr_o, %5 after %1 : i6
    %6 = llhd.prb %rptr_wrap_cnt_q : i7
    %7 = comb.extract %6 from 0 : (i7) -> i6
    llhd.drv %rptr_o, %7 after %1 : i6
    %8 = comb.extract %4 from 6 : (i7) -> i1
    llhd.drv %wptr_wrap_msb, %8 after %1 : i1
    %9 = comb.extract %6 from 6 : (i7) -> i1
    llhd.drv %rptr_wrap_msb, %9 after %1 : i1
    %10 = llhd.prb %incr_wptr_i_3 : i1
    %11 = llhd.prb %wptr_o : i6
    %12 = comb.icmp eq %11, %c-1_i6 : i6
    %13 = comb.and %10, %12 : i1
    llhd.drv %wptr_wrap_set, %13 after %1 : i1
    %14 = llhd.prb %incr_rptr_i_4 : i1
    %15 = llhd.prb %rptr_o : i6
    %16 = comb.icmp eq %15, %c-1_i6 : i6
    %17 = comb.and %14, %16 : i1
    llhd.drv %rptr_wrap_set, %17 after %1 : i1
    %18 = llhd.prb %wptr_wrap_msb : i1
    %19 = comb.xor %18, %true : i1
    %20 = comb.concat %19, %c0_i6 : i1, i6
    llhd.drv %wptr_wrap_set_cnt, %20 after %1 : i7
    %21 = llhd.prb %rptr_wrap_msb : i1
    %22 = comb.xor %21, %true : i1
    %23 = comb.concat %22, %c0_i6 : i1, i6
    llhd.drv %rptr_wrap_set_cnt, %23 after %1 : i7
    %24 = comb.xor %6, %c-64_i7 : i7
    %25 = comb.icmp eq %4, %24 : i7
    %26 = comb.icmp eq %4, %6 : i7
    %27 = comb.icmp eq %18, %21 : i1
    %28 = comb.concat %false, %11 : i1, i6
    %29 = comb.concat %false, %15 : i1, i6
    %30 = comb.sub %28, %29 : i7
    %31 = comb.sub %c-64_i7, %29 : i7
    %32 = comb.add %31, %28 : i7
    %33 = comb.mux %27, %30, %32 : i7
    %34 = comb.mux %25, %c-64_i7, %33 : i7
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      %35 = llhd.prb %clk_i_0 : i1
      %36 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %wptr_wrap_cnt_q, %c0_i7 after %0 : i7
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %46 = llhd.prb %clr_i_2 : i1
      cf.cond_br %46, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %wptr_wrap_cnt_q, %c0_i7 after %0 : i7
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %47 = llhd.prb %wptr_wrap_set : i1
      cf.cond_br %47, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %48 = llhd.prb %wptr_wrap_set_cnt : i7
      llhd.drv %wptr_wrap_cnt_q, %48 after %0 : i7
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %49 = llhd.prb %incr_wptr_i_3 : i1
      cf.cond_br %49, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      %50 = llhd.prb %wptr_wrap_cnt_q : i7
      %51 = comb.add %50, %c1_i7 : i7
      llhd.drv %wptr_wrap_cnt_q, %51 after %0 : i7
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      %35 = llhd.prb %clk_i_0 : i1
      %36 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %rptr_wrap_cnt_q, %c0_i7 after %0 : i7
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %46 = llhd.prb %clr_i_2 : i1
      cf.cond_br %46, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %rptr_wrap_cnt_q, %c0_i7 after %0 : i7
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %47 = llhd.prb %rptr_wrap_set : i1
      cf.cond_br %47, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %48 = llhd.prb %rptr_wrap_set_cnt : i7
      llhd.drv %rptr_wrap_cnt_q, %48 after %0 : i7
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %49 = llhd.prb %incr_rptr_i_4 : i1
      cf.cond_br %49, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      %50 = llhd.prb %rptr_wrap_cnt_q : i7
      %51 = comb.add %50, %c1_i7 : i7
      llhd.drv %rptr_wrap_cnt_q, %51 after %0 : i7
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %clr_i_2, %clr_i after %1 : i1
    llhd.drv %incr_wptr_i_3, %incr_wptr_i after %1 : i1
    llhd.drv %incr_rptr_i_4, %incr_rptr_i after %1 : i1
    hw.output %11, %15, %25, %26, %34, %false : i6, i6, i1, i1, i7, i1
  }
  hw.module private @prim_fifo_sync(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, out wready_o : i1, in %wdata_i : i57, out rvalid_o : i1, in %rready_i : i1, out rdata_o : i57, out full_o : i1, out depth_o : i3, out err_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [0 : i57, 0 : i57, 0 : i57, 0 : i57] : !hw.array<4xi57>
    %c0_i2 = hw.constant 0 : i2
    %c0_i57 = hw.constant 0 : i57
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %wdata_i_2 = llhd.sig name "wdata_i" %c0_i57 : i57
    %gen_normal_fifo.fifo_wptr = llhd.sig %c0_i2 : i2
    %gen_normal_fifo.fifo_incr_wptr = llhd.sig %false : i1
    %gen_normal_fifo.under_rst = llhd.sig %false : i1
    %gen_normal_fifo.storage = llhd.sig %2 : !hw.array<4xi57>
    %gen_normal_fifo.rdata_int = llhd.sig %c0_i57 : i57
    %5 = llhd.prb %gen_normal_fifo.fifo_incr_wptr : i1
    %gen_normal_fifo.u_fifo_cnt.wptr_o, %gen_normal_fifo.u_fifo_cnt.rptr_o, %gen_normal_fifo.u_fifo_cnt.full_o, %gen_normal_fifo.u_fifo_cnt.empty_o, %gen_normal_fifo.u_fifo_cnt.depth_o, %gen_normal_fifo.u_fifo_cnt.err_o = hw.instance "gen_normal_fifo.u_fifo_cnt" @prim_fifo_sync_cnt(clk_i: %3: i1, rst_ni: %4: i1, clr_i: %clr_i: i1, incr_wptr_i: %5: i1, incr_rptr_i: %11: i1) -> (wptr_o: i2, rptr_o: i2, full_o: i1, empty_o: i1, depth_o: i3, err_o: i1) {sv.namehint = "gen_normal_fifo.empty"}
    llhd.drv %gen_normal_fifo.fifo_wptr, %gen_normal_fifo.u_fifo_cnt.wptr_o after %1 : i2
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
    %12 = llhd.prb %gen_normal_fifo.storage : !hw.array<4xi57>
    %13 = hw.array_get %12[%gen_normal_fifo.u_fifo_cnt.rptr_o] {sv.namehint = "gen_normal_fifo.storage_rdata"} : !hw.array<4xi57>, i2
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
      %22 = llhd.prb %gen_normal_fifo.fifo_wptr : i2
      %23 = llhd.sig.array_get %gen_normal_fifo.storage[%22] : <!hw.array<4xi57>>
      %24 = llhd.prb %wdata_i_2 : i57
      llhd.drv %23, %24 after %0 : i57
      cf.br ^bb1
    }
    llhd.drv %gen_normal_fifo.rdata_int, %13 after %1 : i57
    %14 = comb.xor %gen_normal_fifo.u_fifo_cnt.empty_o, %true : i1
    %15 = llhd.prb %gen_normal_fifo.rdata_int : i57
    %16 = comb.mux %gen_normal_fifo.u_fifo_cnt.empty_o, %c0_i57, %15 : i57
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %wdata_i_2, %wdata_i after %1 : i57
    hw.output %9, %14, %16, %gen_normal_fifo.u_fifo_cnt.full_o, %gen_normal_fifo.u_fifo_cnt.depth_o, %gen_normal_fifo.u_fifo_cnt.err_o : i1, i1, i57, i1, i3, i1
  }
  hw.module private @prim_fifo_sync_14(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, out wready_o : i1, in %wdata_i : i36, out rvalid_o : i1, in %rready_i : i1, out rdata_o : i36, out full_o : i1, out depth_o : i7, out err_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36, 0 : i36] : !hw.array<72xi36>
    %c0_i7 = hw.constant 0 : i7
    %c0_i36 = hw.constant 0 : i36
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %wdata_i_2 = llhd.sig name "wdata_i" %c0_i36 : i36
    %gen_normal_fifo.fifo_wptr = llhd.sig %c0_i7 : i7
    %gen_normal_fifo.fifo_incr_wptr = llhd.sig %false : i1
    %gen_normal_fifo.under_rst = llhd.sig %false : i1
    %gen_normal_fifo.storage = llhd.sig %2 : !hw.array<72xi36>
    %gen_normal_fifo.storage_rdata = llhd.sig %c0_i36 : i36
    %gen_normal_fifo.rdata_int = llhd.sig %c0_i36 : i36
    %5 = llhd.prb %gen_normal_fifo.fifo_incr_wptr : i1
    %gen_normal_fifo.u_fifo_cnt.wptr_o, %gen_normal_fifo.u_fifo_cnt.rptr_o, %gen_normal_fifo.u_fifo_cnt.full_o, %gen_normal_fifo.u_fifo_cnt.empty_o, %gen_normal_fifo.u_fifo_cnt.depth_o, %gen_normal_fifo.u_fifo_cnt.err_o = hw.instance "gen_normal_fifo.u_fifo_cnt" @prim_fifo_sync_cnt_29(clk_i: %3: i1, rst_ni: %4: i1, clr_i: %clr_i: i1, incr_wptr_i: %5: i1, incr_rptr_i: %11: i1) -> (wptr_o: i7, rptr_o: i7, full_o: i1, empty_o: i1, depth_o: i7, err_o: i1) {sv.namehint = "gen_normal_fifo.fifo_rptr"}
    llhd.drv %gen_normal_fifo.fifo_wptr, %gen_normal_fifo.u_fifo_cnt.wptr_o after %1 : i7
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
    %12 = llhd.prb %gen_normal_fifo.storage : !hw.array<72xi36>
    %13 = hw.array_get %12[%gen_normal_fifo.u_fifo_cnt.rptr_o] : !hw.array<72xi36>, i7
    llhd.drv %gen_normal_fifo.storage_rdata, %13 after %1 : i36
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
      %29 = llhd.prb %gen_normal_fifo.fifo_wptr : i7
      %30 = llhd.sig.array_get %gen_normal_fifo.storage[%29] : <!hw.array<72xi36>>
      %31 = llhd.prb %wdata_i_2 : i36
      llhd.drv %30, %31 after %0 : i36
      cf.br ^bb1
    }
    %14 = comb.and %gen_normal_fifo.u_fifo_cnt.empty_o, %wvalid_i : i1
    %15 = llhd.prb %wdata_i_2 : i36
    %16 = llhd.prb %gen_normal_fifo.storage_rdata : i36
    %17 = comb.mux %14, %15, %16 : i36
    llhd.drv %gen_normal_fifo.rdata_int, %17 after %1 : i36
    %18 = comb.xor %wvalid_i, %true : i1
    %19 = comb.and %gen_normal_fifo.u_fifo_cnt.empty_o, %18 {sv.namehint = "gen_normal_fifo.empty"} : i1
    %20 = comb.xor %19, %true : i1
    %21 = comb.and %20, %8 : i1
    %22 = llhd.prb %gen_normal_fifo.rdata_int : i36
    %23 = comb.mux %19, %c0_i36, %22 : i36
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %wdata_i_2, %wdata_i after %1 : i36
    hw.output %9, %21, %23, %gen_normal_fifo.u_fifo_cnt.full_o, %gen_normal_fifo.u_fifo_cnt.depth_o, %gen_normal_fifo.u_fifo_cnt.err_o : i1, i1, i36, i1, i7, i1
  }
  hw.module private @prim_fifo_sync_15(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, out wready_o : i1, in %wdata_i : i32, out rvalid_o : i1, in %rready_i : i1, out rdata_o : i32, out full_o : i1, out depth_o : i7, out err_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32, 0 : i32] : !hw.array<64xi32>
    %c0_i6 = hw.constant 0 : i6
    %c0_i32 = hw.constant 0 : i32
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %wdata_i_2 = llhd.sig name "wdata_i" %c0_i32 : i32
    %gen_normal_fifo.fifo_wptr = llhd.sig %c0_i6 : i6
    %gen_normal_fifo.fifo_incr_wptr = llhd.sig %false : i1
    %gen_normal_fifo.under_rst = llhd.sig %false : i1
    %gen_normal_fifo.storage = llhd.sig %2 : !hw.array<64xi32>
    %gen_normal_fifo.storage_rdata = llhd.sig %c0_i32 : i32
    %gen_normal_fifo.rdata_int = llhd.sig %c0_i32 : i32
    %5 = llhd.prb %gen_normal_fifo.fifo_incr_wptr : i1
    %gen_normal_fifo.u_fifo_cnt.wptr_o, %gen_normal_fifo.u_fifo_cnt.rptr_o, %gen_normal_fifo.u_fifo_cnt.full_o, %gen_normal_fifo.u_fifo_cnt.empty_o, %gen_normal_fifo.u_fifo_cnt.depth_o, %gen_normal_fifo.u_fifo_cnt.err_o = hw.instance "gen_normal_fifo.u_fifo_cnt" @prim_fifo_sync_cnt_30(clk_i: %3: i1, rst_ni: %4: i1, clr_i: %clr_i: i1, incr_wptr_i: %5: i1, incr_rptr_i: %11: i1) -> (wptr_o: i6, rptr_o: i6, full_o: i1, empty_o: i1, depth_o: i7, err_o: i1) {sv.namehint = "gen_normal_fifo.fifo_rptr"}
    llhd.drv %gen_normal_fifo.fifo_wptr, %gen_normal_fifo.u_fifo_cnt.wptr_o after %1 : i6
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
    %12 = llhd.prb %gen_normal_fifo.storage : !hw.array<64xi32>
    %13 = hw.array_get %12[%gen_normal_fifo.u_fifo_cnt.rptr_o] : !hw.array<64xi32>, i6
    llhd.drv %gen_normal_fifo.storage_rdata, %13 after %1 : i32
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
      %29 = llhd.prb %gen_normal_fifo.fifo_wptr : i6
      %30 = llhd.sig.array_get %gen_normal_fifo.storage[%29] : <!hw.array<64xi32>>
      %31 = llhd.prb %wdata_i_2 : i32
      llhd.drv %30, %31 after %0 : i32
      cf.br ^bb1
    }
    %14 = comb.and %gen_normal_fifo.u_fifo_cnt.empty_o, %wvalid_i : i1
    %15 = llhd.prb %wdata_i_2 : i32
    %16 = llhd.prb %gen_normal_fifo.storage_rdata : i32
    %17 = comb.mux %14, %15, %16 : i32
    llhd.drv %gen_normal_fifo.rdata_int, %17 after %1 : i32
    %18 = comb.xor %wvalid_i, %true : i1
    %19 = comb.and %gen_normal_fifo.u_fifo_cnt.empty_o, %18 {sv.namehint = "gen_normal_fifo.empty"} : i1
    %20 = comb.xor %19, %true : i1
    %21 = comb.and %20, %8 : i1
    %22 = llhd.prb %gen_normal_fifo.rdata_int : i32
    %23 = comb.mux %19, %c0_i32, %22 : i32
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %wdata_i_2, %wdata_i after %1 : i32
    hw.output %9, %21, %23, %gen_normal_fifo.u_fifo_cnt.full_o, %gen_normal_fifo.u_fifo_cnt.depth_o, %gen_normal_fifo.u_fifo_cnt.err_o : i1, i1, i32, i1, i7, i1
  }
  hw.module private @prim_fifo_sync_32(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, out wready_o : i1, in %wdata_i : i95, out rvalid_o : i1, in %rready_i : i1, out rdata_o : i95, out full_o : i1, out depth_o : i1, out err_o : i1) {
    %true = hw.constant true
    %false = hw.constant false
    hw.output %rready_i, %wvalid_i, %wdata_i, %true, %false, %false : i1, i1, i95, i1, i1, i1
  }
  hw.module private @prim_fifo_sync_33(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, out wready_o : i1, in %wdata_i : i14, out rvalid_o : i1, in %rready_i : i1, out rdata_o : i14, out full_o : i1, out depth_o : i1, out err_o : i1) {
    %true = hw.constant true
    %false = hw.constant false
    hw.output %rready_i, %wvalid_i, %wdata_i, %true, %false, %false : i1, i1, i14, i1, i1, i1
  }
  hw.module private @prim_fifo_sync_34(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, out wready_o : i1, in %wdata_i : i51, out rvalid_o : i1, in %rready_i : i1, out rdata_o : i51, out full_o : i1, out depth_o : i1, out err_o : i1) {
    %true = hw.constant true
    %false = hw.constant false
    hw.output %rready_i, %wvalid_i, %wdata_i, %true, %false, %false : i1, i1, i51, i1, i1, i1
  }
  hw.module private @prim_fifo_sync_35(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, out wready_o : i1, in %wdata_i : i94, out rvalid_o : i1, in %rready_i : i1, out rdata_o : i94, out full_o : i1, out depth_o : i1, out err_o : i1) {
    %true = hw.constant true
    %false = hw.constant false
    hw.output %rready_i, %wvalid_i, %wdata_i, %true, %false, %false : i1, i1, i94, i1, i1, i1
  }
  hw.module private @prim_fifo_sync_39(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, out wready_o : i1, in %wdata_i : i16, out rvalid_o : i1, in %rready_i : i1, out rdata_o : i16, out full_o : i1, out depth_o : i1, out err_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i16 = hw.constant 0 : i16
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %wvalid_i_2 = llhd.sig name "wvalid_i" %false : i1
    %wready_o = llhd.sig %false : i1
    %wdata_i_3 = llhd.sig name "wdata_i" %c0_i16 : i16
    %rready_i_4 = llhd.sig name "rready_i" %false : i1
    %gen_singleton_fifo.full_d = llhd.sig %false : i1
    %gen_singleton_fifo.full_q = llhd.sig %false : i1
    %gen_singleton_fifo.storage = llhd.sig %c0_i16 : i16
    %gen_singleton_fifo.rdata_int = llhd.sig %c0_i16 : i16
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
      llhd.drv %gen_singleton_fifo.full_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %28 = llhd.prb %gen_singleton_fifo.full_d : i1
      llhd.drv %gen_singleton_fifo.full_q, %28 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
      %17 = llhd.prb %clk_i_0 : i1
      llhd.wait (%2 : i1), ^bb2
    ^bb2:  // pred: ^bb1
      %18 = llhd.prb %clk_i_0 : i1
      %19 = comb.xor bin %17, %true : i1
      %20 = comb.and bin %19, %18 : i1
      cf.cond_br %20, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %21 = llhd.prb %wvalid_i_2 : i1
      %22 = llhd.prb %wready_o : i1
      %23 = comb.and %21, %22 : i1
      cf.cond_br %23, ^bb4, ^bb1
    ^bb4:  // pred: ^bb3
      %24 = llhd.prb %wdata_i_3 : i16
      llhd.drv %gen_singleton_fifo.storage, %24 after %0 : i16
      cf.br ^bb1
    }
    %12 = llhd.prb %gen_singleton_fifo.storage : i16
    llhd.drv %gen_singleton_fifo.rdata_int, %12 after %1 : i16
    %13 = comb.xor %4, %true : i1
    %14 = llhd.prb %gen_singleton_fifo.rdata_int : i16
    %15 = comb.mux %13, %c0_i16, %14 : i16
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %wvalid_i_2, %wvalid_i after %1 : i1
    %16 = llhd.prb %wready_o : i1
    llhd.drv %wdata_i_3, %wdata_i after %1 : i16
    llhd.drv %rready_i_4, %rready_i after %1 : i1
    hw.output %16, %4, %15, %4, %4, %false : i1, i1, i16, i1, i1, i1
  }
  hw.module private @prim_fifo_sync_40(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, out wready_o : i1, in %wdata_i : i5, out rvalid_o : i1, in %rready_i : i1, out rdata_o : i5, out full_o : i1, out depth_o : i1, out err_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i5 = hw.constant 0 : i5
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %wvalid_i_2 = llhd.sig name "wvalid_i" %false : i1
    %wready_o = llhd.sig %false : i1
    %wdata_i_3 = llhd.sig name "wdata_i" %c0_i5 : i5
    %rready_i_4 = llhd.sig name "rready_i" %false : i1
    %gen_singleton_fifo.full_d = llhd.sig %false : i1
    %gen_singleton_fifo.full_q = llhd.sig %false : i1
    %gen_singleton_fifo.storage = llhd.sig %c0_i5 : i5
    %gen_singleton_fifo.rdata_int = llhd.sig %c0_i5 : i5
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
      llhd.drv %gen_singleton_fifo.full_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %28 = llhd.prb %gen_singleton_fifo.full_d : i1
      llhd.drv %gen_singleton_fifo.full_q, %28 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
      %17 = llhd.prb %clk_i_0 : i1
      llhd.wait (%2 : i1), ^bb2
    ^bb2:  // pred: ^bb1
      %18 = llhd.prb %clk_i_0 : i1
      %19 = comb.xor bin %17, %true : i1
      %20 = comb.and bin %19, %18 : i1
      cf.cond_br %20, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %21 = llhd.prb %wvalid_i_2 : i1
      %22 = llhd.prb %wready_o : i1
      %23 = comb.and %21, %22 : i1
      cf.cond_br %23, ^bb4, ^bb1
    ^bb4:  // pred: ^bb3
      %24 = llhd.prb %wdata_i_3 : i5
      llhd.drv %gen_singleton_fifo.storage, %24 after %0 : i5
      cf.br ^bb1
    }
    %12 = llhd.prb %gen_singleton_fifo.storage : i5
    llhd.drv %gen_singleton_fifo.rdata_int, %12 after %1 : i5
    %13 = comb.xor %4, %true : i1
    %14 = llhd.prb %gen_singleton_fifo.rdata_int : i5
    %15 = comb.mux %13, %c0_i5, %14 : i5
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %wvalid_i_2, %wvalid_i after %1 : i1
    %16 = llhd.prb %wready_o : i1
    llhd.drv %wdata_i_3, %wdata_i after %1 : i5
    llhd.drv %rready_i_4, %rready_i after %1 : i1
    hw.output %16, %4, %15, %4, %4, %false : i1, i1, i5, i1, i1, i1
  }
  hw.module private @prim_fifo_sync_41(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, out wready_o : i1, in %wdata_i : i40, out rvalid_o : i1, in %rready_i : i1, out rdata_o : i40, out full_o : i1, out depth_o : i1, out err_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i40 = hw.constant 0 : i40
    %false = hw.constant false
    %true = hw.constant true
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %wvalid_i_2 = llhd.sig name "wvalid_i" %false : i1
    %wready_o = llhd.sig %false : i1
    %wdata_i_3 = llhd.sig name "wdata_i" %c0_i40 : i40
    %rready_i_4 = llhd.sig name "rready_i" %false : i1
    %gen_singleton_fifo.full_d = llhd.sig %false : i1
    %gen_singleton_fifo.full_q = llhd.sig %false : i1
    %gen_singleton_fifo.storage = llhd.sig %c0_i40 : i40
    %gen_singleton_fifo.rdata_int = llhd.sig %c0_i40 : i40
    %4 = llhd.prb %gen_singleton_fifo.full_q : i1
    %5 = comb.xor %4, %true : i1
    llhd.drv %wready_o, %5 after %1 : i1
    %6 = llhd.prb %wvalid_i_2 : i1
    %7 = comb.or %4, %6 : i1
    %8 = llhd.prb %rready_i_4 : i1
    %9 = comb.xor %8, %true : i1
    %10 = comb.mux %7, %9, %6 : i1
    %11 = comb.xor %clr_i, %true : i1
    %12 = comb.and %10, %11 : i1
    llhd.drv %gen_singleton_fifo.full_d, %12 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %20 = llhd.prb %clk_i_0 : i1
      %21 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %gen_singleton_fifo.full_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %31 = llhd.prb %gen_singleton_fifo.full_d : i1
      llhd.drv %gen_singleton_fifo.full_q, %31 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
      %20 = llhd.prb %clk_i_0 : i1
      llhd.wait (%2 : i1), ^bb2
    ^bb2:  // pred: ^bb1
      %21 = llhd.prb %clk_i_0 : i1
      %22 = comb.xor bin %20, %true : i1
      %23 = comb.and bin %22, %21 : i1
      cf.cond_br %23, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %24 = llhd.prb %wvalid_i_2 : i1
      %25 = llhd.prb %wready_o : i1
      %26 = comb.and %24, %25 : i1
      cf.cond_br %26, ^bb4, ^bb1
    ^bb4:  // pred: ^bb3
      %27 = llhd.prb %wdata_i_3 : i40
      llhd.drv %gen_singleton_fifo.storage, %27 after %0 : i40
      cf.br ^bb1
    }
    %13 = llhd.prb %gen_singleton_fifo.storage : i40
    %14 = llhd.prb %wdata_i_3 : i40
    %15 = comb.mux %4, %13, %14 : i40
    llhd.drv %gen_singleton_fifo.rdata_int, %15 after %1 : i40
    %16 = comb.xor %7, %true : i1
    %17 = llhd.prb %gen_singleton_fifo.rdata_int : i40
    %18 = comb.mux %16, %c0_i40, %17 : i40
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %wvalid_i_2, %wvalid_i after %1 : i1
    %19 = llhd.prb %wready_o : i1
    llhd.drv %wdata_i_3, %wdata_i after %1 : i40
    llhd.drv %rready_i_4, %rready_i after %1 : i1
    hw.output %19, %7, %18, %4, %4, %false : i1, i1, i40, i1, i1, i1
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
  hw.module private @prim_intr_hw_0(in %clk_i : i1, in %rst_ni : i1, in %event_intr_i : i1, in %reg2hw_intr_enable_q_i : i1, in %reg2hw_intr_test_q_i : i1, in %reg2hw_intr_test_qe_i : i1, in %reg2hw_intr_state_q_i : i1, out hw2reg_intr_state_de_o : i1, out hw2reg_intr_state_d_o : i1, out intr_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %reg2hw_intr_enable_q_i_2 = llhd.sig name "reg2hw_intr_enable_q_i" %false : i1
    %reg2hw_intr_test_q_i_3 = llhd.sig name "reg2hw_intr_test_q_i" %false : i1
    %reg2hw_intr_test_qe_i_4 = llhd.sig name "reg2hw_intr_test_qe_i" %false : i1
    %intr_o = llhd.sig %false : i1
    %status = llhd.sig %false : i1
    %g_intr_status.test_q = llhd.sig %false : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %7 = llhd.prb %clk_i_0 : i1
      %8 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %9 = llhd.prb %clk_i_0 : i1
      %10 = comb.xor bin %7, %true : i1
      %11 = comb.and bin %10, %9 : i1
      %12 = llhd.prb %rst_ni_1 : i1
      %13 = comb.xor bin %12, %true : i1
      %14 = comb.and bin %8, %13 : i1
      %15 = comb.or bin %11, %14 : i1
      cf.cond_br %15, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %16 = llhd.prb %rst_ni_1 : i1
      %17 = comb.xor %16, %true : i1
      cf.cond_br %17, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %g_intr_status.test_q, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %18 = llhd.prb %reg2hw_intr_test_qe_i_4 : i1
      cf.cond_br %18, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %19 = llhd.prb %reg2hw_intr_test_q_i_3 : i1
      llhd.drv %g_intr_status.test_q, %19 after %1 : i1
      cf.br ^bb1
    }
    %4 = llhd.prb %g_intr_status.test_q : i1
    %5 = comb.or %event_intr_i, %4 : i1
    llhd.drv %status, %5 after %0 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %7 = llhd.prb %clk_i_0 : i1
      %8 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %9 = llhd.prb %clk_i_0 : i1
      %10 = comb.xor bin %7, %true : i1
      %11 = comb.and bin %10, %9 : i1
      %12 = llhd.prb %rst_ni_1 : i1
      %13 = comb.xor bin %12, %true : i1
      %14 = comb.and bin %8, %13 : i1
      %15 = comb.or bin %11, %14 : i1
      cf.cond_br %15, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %16 = llhd.prb %rst_ni_1 : i1
      %17 = comb.xor %16, %true : i1
      cf.cond_br %17, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %intr_o, %false after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %18 = llhd.prb %status : i1
      %19 = llhd.prb %reg2hw_intr_enable_q_i_2 : i1
      %20 = comb.and %18, %19 : i1
      llhd.drv %intr_o, %20 after %1 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %reg2hw_intr_enable_q_i_2, %reg2hw_intr_enable_q_i after %0 : i1
    llhd.drv %reg2hw_intr_test_q_i_3, %reg2hw_intr_test_q_i after %0 : i1
    llhd.drv %reg2hw_intr_test_qe_i_4, %reg2hw_intr_test_qe_i after %0 : i1
    %6 = llhd.prb %intr_o : i1
    hw.output %true, %5, %6 : i1, i1, i1
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
  hw.module private @prim_onehot_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i12, in %addr_i : i4, in %en_i : i1, out err_o : i1) {
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
    %238 = comb.extract %oh_i from 0 : (i12) -> i1
    llhd.drv %237, %238 after %0 : i1
    %239 = llhd.sig.extract %and_tree from %c15_i5 : <i31> -> <i1>
    llhd.drv %239, %238 after %0 : i1
    %240 = llhd.sig.extract %err_tree from %c15_i5 : <i31> -> <i1>
    llhd.drv %240, %false after %0 : i1
    %241 = llhd.sig.extract %or_tree from %c-16_i5 : <i31> -> <i1>
    %242 = comb.extract %oh_i from 1 : (i12) -> i1
    llhd.drv %241, %242 after %0 : i1
    %243 = llhd.sig.extract %and_tree from %c-16_i5 : <i31> -> <i1>
    llhd.drv %243, %242 after %0 : i1
    %244 = llhd.sig.extract %err_tree from %c-16_i5 : <i31> -> <i1>
    llhd.drv %244, %false after %0 : i1
    %245 = llhd.sig.extract %or_tree from %c-15_i5 : <i31> -> <i1>
    %246 = comb.extract %oh_i from 2 : (i12) -> i1
    llhd.drv %245, %246 after %0 : i1
    %247 = llhd.sig.extract %and_tree from %c-15_i5 : <i31> -> <i1>
    llhd.drv %247, %246 after %0 : i1
    %248 = llhd.sig.extract %err_tree from %c-15_i5 : <i31> -> <i1>
    llhd.drv %248, %false after %0 : i1
    %249 = llhd.sig.extract %or_tree from %c-14_i5 : <i31> -> <i1>
    %250 = comb.extract %oh_i from 3 : (i12) -> i1
    llhd.drv %249, %250 after %0 : i1
    %251 = llhd.sig.extract %and_tree from %c-14_i5 : <i31> -> <i1>
    llhd.drv %251, %250 after %0 : i1
    %252 = llhd.sig.extract %err_tree from %c-14_i5 : <i31> -> <i1>
    llhd.drv %252, %false after %0 : i1
    %253 = llhd.sig.extract %or_tree from %c-13_i5 : <i31> -> <i1>
    %254 = comb.extract %oh_i from 4 : (i12) -> i1
    llhd.drv %253, %254 after %0 : i1
    %255 = llhd.sig.extract %and_tree from %c-13_i5 : <i31> -> <i1>
    llhd.drv %255, %254 after %0 : i1
    %256 = llhd.sig.extract %err_tree from %c-13_i5 : <i31> -> <i1>
    llhd.drv %256, %false after %0 : i1
    %257 = llhd.sig.extract %or_tree from %c-12_i5 : <i31> -> <i1>
    %258 = comb.extract %oh_i from 5 : (i12) -> i1
    llhd.drv %257, %258 after %0 : i1
    %259 = llhd.sig.extract %and_tree from %c-12_i5 : <i31> -> <i1>
    llhd.drv %259, %258 after %0 : i1
    %260 = llhd.sig.extract %err_tree from %c-12_i5 : <i31> -> <i1>
    llhd.drv %260, %false after %0 : i1
    %261 = llhd.sig.extract %or_tree from %c-11_i5 : <i31> -> <i1>
    %262 = comb.extract %oh_i from 6 : (i12) -> i1
    llhd.drv %261, %262 after %0 : i1
    %263 = llhd.sig.extract %and_tree from %c-11_i5 : <i31> -> <i1>
    llhd.drv %263, %262 after %0 : i1
    %264 = llhd.sig.extract %err_tree from %c-11_i5 : <i31> -> <i1>
    llhd.drv %264, %false after %0 : i1
    %265 = llhd.sig.extract %or_tree from %c-10_i5 : <i31> -> <i1>
    %266 = comb.extract %oh_i from 7 : (i12) -> i1
    llhd.drv %265, %266 after %0 : i1
    %267 = llhd.sig.extract %and_tree from %c-10_i5 : <i31> -> <i1>
    llhd.drv %267, %266 after %0 : i1
    %268 = llhd.sig.extract %err_tree from %c-10_i5 : <i31> -> <i1>
    llhd.drv %268, %false after %0 : i1
    %269 = llhd.sig.extract %or_tree from %c-9_i5 : <i31> -> <i1>
    %270 = comb.extract %oh_i from 8 : (i12) -> i1
    llhd.drv %269, %270 after %0 : i1
    %271 = llhd.sig.extract %and_tree from %c-9_i5 : <i31> -> <i1>
    llhd.drv %271, %270 after %0 : i1
    %272 = llhd.sig.extract %err_tree from %c-9_i5 : <i31> -> <i1>
    llhd.drv %272, %false after %0 : i1
    %273 = llhd.sig.extract %or_tree from %c-8_i5 : <i31> -> <i1>
    %274 = comb.extract %oh_i from 9 : (i12) -> i1
    llhd.drv %273, %274 after %0 : i1
    %275 = llhd.sig.extract %and_tree from %c-8_i5 : <i31> -> <i1>
    llhd.drv %275, %274 after %0 : i1
    %276 = llhd.sig.extract %err_tree from %c-8_i5 : <i31> -> <i1>
    llhd.drv %276, %false after %0 : i1
    %277 = llhd.sig.extract %or_tree from %c-7_i5 : <i31> -> <i1>
    %278 = comb.extract %oh_i from 10 : (i12) -> i1
    llhd.drv %277, %278 after %0 : i1
    %279 = llhd.sig.extract %and_tree from %c-7_i5 : <i31> -> <i1>
    llhd.drv %279, %278 after %0 : i1
    %280 = llhd.sig.extract %err_tree from %c-7_i5 : <i31> -> <i1>
    llhd.drv %280, %false after %0 : i1
    %281 = llhd.sig.extract %or_tree from %c-6_i5 : <i31> -> <i1>
    %282 = comb.extract %oh_i from 11 : (i12) -> i1
    llhd.drv %281, %282 after %0 : i1
    %283 = llhd.sig.extract %and_tree from %c-6_i5 : <i31> -> <i1>
    llhd.drv %283, %282 after %0 : i1
    %284 = llhd.sig.extract %err_tree from %c-6_i5 : <i31> -> <i1>
    llhd.drv %284, %false after %0 : i1
    %285 = llhd.sig.extract %or_tree from %c-5_i5 : <i31> -> <i1>
    llhd.drv %285, %false after %0 : i1
    %286 = llhd.sig.extract %and_tree from %c-5_i5 : <i31> -> <i1>
    llhd.drv %286, %false after %0 : i1
    %287 = llhd.sig.extract %err_tree from %c-5_i5 : <i31> -> <i1>
    llhd.drv %287, %false after %0 : i1
    %288 = llhd.sig.extract %or_tree from %c-4_i5 : <i31> -> <i1>
    llhd.drv %288, %false after %0 : i1
    %289 = llhd.sig.extract %and_tree from %c-4_i5 : <i31> -> <i1>
    llhd.drv %289, %false after %0 : i1
    %290 = llhd.sig.extract %err_tree from %c-4_i5 : <i31> -> <i1>
    llhd.drv %290, %false after %0 : i1
    %291 = llhd.sig.extract %or_tree from %c-3_i5 : <i31> -> <i1>
    llhd.drv %291, %false after %0 : i1
    %292 = llhd.sig.extract %and_tree from %c-3_i5 : <i31> -> <i1>
    llhd.drv %292, %false after %0 : i1
    %293 = llhd.sig.extract %err_tree from %c-3_i5 : <i31> -> <i1>
    llhd.drv %293, %false after %0 : i1
    %294 = llhd.sig.extract %or_tree from %c-2_i5 : <i31> -> <i1>
    llhd.drv %294, %false after %0 : i1
    %295 = llhd.sig.extract %and_tree from %c-2_i5 : <i31> -> <i1>
    llhd.drv %295, %false after %0 : i1
    %296 = llhd.sig.extract %err_tree from %c-2_i5 : <i31> -> <i1>
    llhd.drv %296, %false after %0 : i1
    %297 = comb.or %298, %301 : i1
    %298 = comb.extract %17 from 0 {sv.namehint = "oh0_err"} : (i31) -> i1
    %299 = comb.xor %en_i, %true : i1
    %300 = comb.extract %2 from 0 : (i31) -> i1
    %301 = comb.and %299, %300 {sv.namehint = "enable_err"} : i1
    hw.output %297 : i1
  }
  hw.module private @prim_packer_fifo(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, in %wdata_i : i8, out wready_o : i1, out rvalid_o : i1, out rdata_o : i32, in %rready_i : i1, out depth_o : i3) {
    %c0_i26 = hw.constant 0 : i26
    %c0_i24 = hw.constant 0 : i24
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %c-4_i3 = hw.constant -4 : i3
    %c1_i3 = hw.constant 1 : i3
    %false = hw.constant false
    %true = hw.constant true
    %c0_i32 = hw.constant 0 : i32
    %c0_i3 = hw.constant 0 : i3
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %load_data = llhd.sig %false : i1
    %depth_q = llhd.sig %c0_i3 : i3
    %depth_d = llhd.sig %c0_i3 : i3
    %data_q = llhd.sig %c0_i32 : i32
    %data_d = llhd.sig %c0_i32 : i32
    %clr_q = llhd.sig %false : i1
    %clr_d = llhd.sig %false : i1
    %gen_pack_mode.wdata_shifted = llhd.sig %c0_i32 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %28 = llhd.prb %clk_i_0 : i1
      %29 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
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
      llhd.drv %depth_q, %c0_i3 after %1 : i3
      llhd.drv %data_q, %c0_i32 after %1 : i32
      llhd.drv %clr_q, %true after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %39 = llhd.prb %depth_d : i3
      llhd.drv %depth_q, %39 after %1 : i3
      %40 = llhd.prb %data_d : i32
      llhd.drv %data_q, %40 after %1 : i32
      %41 = llhd.prb %clr_d : i1
      llhd.drv %clr_q, %41 after %1 : i1
      cf.br ^bb1
    }
    llhd.drv %clr_d, %clr_i after %0 : i1
    %4 = llhd.prb %depth_q : i3
    %5 = comb.concat %c0_i24, %wdata_i : i24, i8
    %6 = comb.concat %c0_i26, %4, %c0_i3 : i26, i3, i3
    %7 = comb.shl %5, %6 : i32
    llhd.drv %gen_pack_mode.wdata_shifted, %7 after %0 : i32
    %8 = comb.and %rready_i, %27 : i1
    %9 = llhd.prb %clr_q : i1
    %10 = comb.or %8, %9 {sv.namehint = "clear_status"} : i1
    %11 = comb.and %wvalid_i, %26 : i1
    llhd.drv %load_data, %11 after %0 : i1
    %12 = llhd.prb %load_data : i1
    %13 = comb.add %4, %c1_i3 : i3
    %14 = comb.mux %12, %13, %4 : i3
    %15 = comb.mux %10, %c0_i3, %14 : i3
    llhd.drv %depth_d, %15 after %0 : i3
    %16 = llhd.prb %gen_pack_mode.wdata_shifted : i32
    %17 = comb.icmp eq %4, %c0_i3 : i3
    %18 = llhd.prb %data_q : i32
    %19 = comb.mux %17, %c0_i32, %18 : i32
    %20 = comb.or %16, %19 : i32
    %21 = comb.mux %12, %20, %18 : i32
    %22 = comb.mux %10, %c0_i32, %21 : i32
    llhd.drv %data_d, %22 after %0 : i32
    %23 = comb.icmp eq %4, %c-4_i3 : i3
    %24 = comb.xor %23, %true : i1
    %25 = comb.xor %9, %true : i1
    %26 = comb.and %24, %25 : i1
    %27 = comb.and %23, %25 : i1
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    hw.output %26, %27, %18, %4 : i1, i1, i32, i3
  }
  hw.module private @prim_packer_fifo_31(in %clk_i : i1, in %rst_ni : i1, in %clr_i : i1, in %wvalid_i : i1, in %wdata_i : i36, out wready_o : i1, out rvalid_o : i1, out rdata_o : i9, in %rready_i : i1, out depth_o : i3) {
    %c-1_i3 = hw.constant -1 : i3
    %c0_i4 = hw.constant 0 : i4
    %c0_i29 = hw.constant 0 : i29
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = llhd.constant_time <0ns, 1d, 0e>
    %c1_i3 = hw.constant 1 : i3
    %c9_i32 = hw.constant 9 : i32
    %c-4_i3 = hw.constant -4 : i3
    %true = hw.constant true
    %false = hw.constant false
    %c0_i36 = hw.constant 0 : i36
    %c0_i3 = hw.constant 0 : i3
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %wdata_i_2 = llhd.sig name "wdata_i" %c0_i36 : i36
    %load_data = llhd.sig %false : i1
    %depth_q = llhd.sig %c0_i3 : i3
    %depth_d = llhd.sig %c0_i3 : i3
    %data_q = llhd.sig %c0_i36 : i36
    %data_d = llhd.sig %c0_i36 : i36
    %clr_q = llhd.sig %false : i1
    %clr_d = llhd.sig %false : i1
    %gen_unpack_mode.pull_data = llhd.sig %false : i1
    %gen_unpack_mode.ptr_q = llhd.sig %c0_i3 : i3
    %gen_unpack_mode.ptr_d = llhd.sig %c0_i3 : i3
    %gen_unpack_mode.max_value = llhd.sig %c0_i3 : i3
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %36 = llhd.prb %clk_i_0 : i1
      %37 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %38 = llhd.prb %clk_i_0 : i1
      %39 = comb.xor bin %36, %true : i1
      %40 = comb.and bin %39, %38 : i1
      %41 = llhd.prb %rst_ni_1 : i1
      %42 = comb.xor bin %41, %true : i1
      %43 = comb.and bin %37, %42 : i1
      %44 = comb.or bin %40, %43 : i1
      cf.cond_br %44, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %45 = llhd.prb %rst_ni_1 : i1
      %46 = comb.xor %45, %true : i1
      cf.cond_br %46, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %depth_q, %c0_i3 after %1 : i3
      llhd.drv %data_q, %c0_i36 after %1 : i36
      llhd.drv %clr_q, %true after %1 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %47 = llhd.prb %depth_d : i3
      llhd.drv %depth_q, %47 after %1 : i3
      %48 = llhd.prb %data_d : i36
      llhd.drv %data_q, %48 after %1 : i36
      %49 = llhd.prb %clr_d : i1
      llhd.drv %clr_q, %49 after %1 : i1
      cf.br ^bb1
    }
    llhd.drv %clr_d, %clr_i after %0 : i1
    %4 = llhd.prb %depth_q : i3
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %36 = llhd.prb %clk_i_0 : i1
      %37 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %38 = llhd.prb %clk_i_0 : i1
      %39 = comb.xor bin %36, %true : i1
      %40 = comb.and bin %39, %38 : i1
      %41 = llhd.prb %rst_ni_1 : i1
      %42 = comb.xor bin %41, %true : i1
      %43 = comb.and bin %37, %42 : i1
      %44 = comb.or bin %40, %43 : i1
      cf.cond_br %44, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %45 = llhd.prb %rst_ni_1 : i1
      %46 = comb.xor %45, %true : i1
      cf.cond_br %46, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %gen_unpack_mode.ptr_q, %c0_i3 after %1 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %47 = llhd.prb %gen_unpack_mode.ptr_d : i3
      llhd.drv %gen_unpack_mode.ptr_q, %47 after %1 : i3
      cf.br ^bb1
    }
    llhd.drv %gen_unpack_mode.max_value, %c-4_i3 after %0 : i3
    %5 = llhd.prb %data_q : i36
    %6 = llhd.prb %gen_unpack_mode.ptr_q : i3
    %7 = comb.concat %c0_i29, %6 : i29, i3
    %8 = comb.mul %7, %c9_i32 : i32
    %9 = comb.concat %c0_i4, %8 : i4, i32
    %10 = comb.shru %5, %9 {sv.namehint = "gen_unpack_mode.rdata_shifted"} : i36
    %11 = comb.icmp eq %4, %c1_i3 : i3
    %12 = comb.and %rready_i, %11 : i1
    %13 = llhd.prb %clr_q : i1
    %14 = comb.or %12, %13 {sv.namehint = "clear_status"} : i1
    %15 = comb.and %wvalid_i, %32 : i1
    llhd.drv %load_data, %15 after %0 : i1
    %16 = comb.and %35, %rready_i : i1
    llhd.drv %gen_unpack_mode.pull_data, %16 after %0 : i1
    %17 = llhd.prb %load_data : i1
    %18 = llhd.prb %gen_unpack_mode.max_value : i3
    %19 = llhd.prb %gen_unpack_mode.pull_data : i1
    %20 = comb.add %4, %c-1_i3 : i3
    %21 = comb.mux %19, %20, %4 : i3
    %22 = comb.mux %17, %18, %21 : i3
    %23 = comb.mux %14, %c0_i3, %22 : i3
    llhd.drv %depth_d, %23 after %0 : i3
    %24 = comb.add %6, %c1_i3 : i3
    %25 = comb.mux %19, %24, %6 : i3
    %26 = comb.mux %14, %c0_i3, %25 : i3
    llhd.drv %gen_unpack_mode.ptr_d, %26 after %0 : i3
    %27 = llhd.prb %wdata_i_2 : i36
    %28 = comb.mux %17, %27, %5 : i36
    %29 = comb.mux %14, %c0_i36, %28 : i36
    llhd.drv %data_d, %29 after %0 : i36
    %30 = comb.icmp eq %4, %c0_i3 : i3
    %31 = comb.xor %13, %true : i1
    %32 = comb.and %30, %31 : i1
    %33 = comb.extract %10 from 0 : (i36) -> i9
    %34 = comb.xor %30, %true : i1
    %35 = comb.and %34, %31 : i1
    llhd.drv %clk_i_0, %clk_i after %0 : i1
    llhd.drv %rst_ni_1, %rst_ni after %0 : i1
    llhd.drv %wdata_i_2, %wdata_i after %0 : i36
    hw.output %32, %35, %33, %4 : i1, i1, i9, i3
  }
  hw.module private @prim_reg_we_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i12, in %en_i : i1, out err_o : i1) {
    %c0_i4 = hw.constant 0 : i4
    %u_prim_buf.out_o = hw.instance "u_prim_buf" @prim_buf(in_i: %oh_i: i12) -> (out_o: i12) {sv.namehint = "oh_buf"}
    %u_prim_onehot_check.err_o = hw.instance "u_prim_onehot_check" @prim_onehot_check(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, oh_i: %u_prim_buf.out_o: i12, addr_i: %c0_i4: i4, en_i: %en_i: i1) -> (err_o: i1)
    hw.output %u_prim_onehot_check.err_o : i1
  }
  hw.module private @prim_sec_anchor_buf(in %in_i : i2, out out_o : i2) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf_26(in_i: %in_i: i2) -> (out_o: i2)
    hw.output %u_secure_anchor_buf.out_o : i2
  }
  hw.module private @prim_sec_anchor_buf_13(in %in_i : i1, out out_o : i1) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf_28(in_i: %in_i: i1) -> (out_o: i1)
    hw.output %u_secure_anchor_buf.out_o : i1
  }
  hw.module private @prim_sec_anchor_flop(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_o : i2) {
    %u_secure_anchor_flop.q_o = hw.instance "u_secure_anchor_flop" @prim_flop(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %d_i: i2) -> (q_o: i2)
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
  func.func private @"prim_secded_pkg::prim_secded_inv_64_57_enc"(%arg0: i57) -> i64 {
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
    %c6052837899185946624_i64 = hw.constant 6052837899185946624 : i64
    %c0_i64 = hw.constant 0 : i64
    %data_o = llhd.sig %c0_i64 : i64
    %1 = comb.concat %c0_i7, %arg0 : i7, i57
    llhd.drv %data_o, %1 after %0 : i64
    %2 = llhd.sig.extract %data_o from %c-7_i6 : <i64> -> <i1>
    %3 = llhd.prb %data_o : i64
    %4 = comb.extract %3 from 0 : (i64) -> i57
    %5 = comb.and %4, %c-70931728490790913_i57 : i57
    %6 = comb.parity %5 : i57
    llhd.drv %2, %6 after %0 : i1
    %7 = llhd.sig.extract %data_o from %c-6_i6 : <i64> -> <i1>
    %8 = llhd.prb %data_o : i64
    %9 = comb.extract %8 from 0 : (i64) -> i57
    %10 = comb.and %9, %c-37119546879934433_i57 : i57
    %11 = comb.parity %10 : i57
    llhd.drv %7, %11 after %0 : i1
    %12 = llhd.sig.extract %data_o from %c-5_i6 : <i64> -> <i1>
    %13 = llhd.prb %data_o : i64
    %14 = comb.extract %13 from 0 : (i64) -> i57
    %15 = comb.and %14, %c-18610366057053727_i57 : i57
    %16 = comb.parity %15 : i57
    llhd.drv %12, %16 after %0 : i1
    %17 = llhd.sig.extract %data_o from %c-4_i6 : <i64> -> <i1>
    %18 = llhd.prb %data_o : i64
    %19 = comb.extract %18 from 1 : (i64) -> i56
    %20 = comb.and %19, %c-4654104825805039_i56 : i56
    %21 = comb.concat %c0_i7, %20, %false : i7, i56, i1
    %22 = comb.parity %21 : i64
    llhd.drv %17, %22 after %0 : i1
    %23 = llhd.sig.extract %data_o from %c-3_i6 : <i64> -> <i1>
    %24 = llhd.prb %data_o : i64
    %25 = comb.extract %24 from 2 : (i64) -> i55
    %26 = comb.and %25, %c-1163612191044463_i55 : i55
    %27 = comb.concat %c0_i7, %26, %c0_i2 : i7, i55, i2
    %28 = comb.parity %27 : i64
    llhd.drv %23, %28 after %0 : i1
    %29 = llhd.sig.extract %data_o from %c-2_i6 : <i64> -> <i1>
    %30 = llhd.prb %data_o : i64
    %31 = comb.extract %30 from 3 : (i64) -> i54
    %32 = comb.and %31, %c-290911646233967_i54 : i54
    %33 = comb.concat %c0_i7, %32, %c0_i3 : i7, i54, i3
    %34 = comb.parity %33 : i64
    llhd.drv %29, %34 after %0 : i1
    %35 = llhd.sig.extract %data_o from %c-1_i6 : <i64> -> <i1>
    %36 = llhd.prb %data_o : i64
    %37 = comb.extract %36 from 4 : (i64) -> i53
    %38 = comb.and %37, %c-72728986368367_i53 : i53
    %39 = comb.concat %c0_i7, %38, %c0_i4 : i7, i53, i4
    %40 = comb.parity %39 : i64
    llhd.drv %35, %40 after %0 : i1
    %41 = llhd.prb %data_o : i64
    %42 = comb.xor %41, %c6052837899185946624_i64 : i64
    llhd.drv %data_o, %42 after %0 : i64
    %43 = llhd.prb %data_o : i64
    return %43 : i64
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
  hw.module private @prim_subreg_arb_18(in %we : i1, in %wd : i1, in %de : i1, in %d : i1, in %q : i1, out wr_en : i1, out wr_data : i1) {
    hw.output %de, %d : i1, i1
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
  hw.module private @prim_subreg_arb_20(in %we : i1, in %wd : i8, in %de : i1, in %d : i8, in %q : i8, out wr_en : i1, out wr_data : i8) {
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
  hw.module private @prim_subreg_arb_21(in %we : i1, in %wd : i8, in %de : i1, in %d : i8, in %q : i8, out wr_en : i1, out wr_data : i8) {
    hw.output %de, %d : i1, i8
  }
  hw.module private @prim_subreg_arb_22(in %we : i1, in %wd : i4, in %de : i1, in %d : i4, in %q : i4, out wr_en : i1, out wr_data : i4) {
    hw.output %de, %d : i1, i4
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
  hw.module private @prim_subreg_arb_24(in %we : i1, in %wd : i4, in %de : i1, in %d : i4, in %q : i4, out wr_en : i1, out wr_data : i4) {
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
  hw.module private @prim_subreg_arb_25(in %we : i1, in %wd : i32, in %de : i1, in %d : i32, in %q : i32, out wr_en : i1, out wr_data : i32) {
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
  hw.module private @prim_subreg_ext(in %re : i1, in %we : i1, in %wd : i1, in %d : i1, out qe : i1, out qre : i1, out q : i1, out ds : i1, out qs : i1) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i1, i1, i1
  }
  hw.module private @prim_subreg_ext_10(in %re : i1, in %we : i1, in %wd : i2, in %d : i2, out qe : i1, out qre : i1, out q : i2, out ds : i2, out qs : i2) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i2, i2, i2
  }
  hw.module private @prim_subreg_ext_11(in %re : i1, in %we : i1, in %wd : i20, in %d : i20, out qe : i1, out qre : i1, out q : i20, out ds : i20, out qs : i20) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i20, i20, i20
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
  hw.module private @prim_subreg_2(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i1, in %de : i1, in %d : i1, out qe : i1, out q : i1, out ds : i1, out qs : i1) {
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
  hw.module private @prim_subreg_3(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i8, in %de : i1, in %d : i8, out qe : i1, out q : i8, out ds : i8, out qs : i8) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i8 = hw.constant 0 : i8
    %c127_i8 = hw.constant 127 : i8
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_20(we: %we: i1, wd: %wd: i8, de: %de: i1, d: %d: i8, q: %4: i8) -> (wr_en: i1, wr_data: i8)
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
      llhd.drv %q, %c127_i8 after %0 : i8
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
  hw.module private @prim_subreg_4(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i8, in %de : i1, in %d : i8, out qe : i1, out q : i8, out ds : i8, out qs : i8) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i8 = hw.constant 0 : i8
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_20(we: %we: i1, wd: %wd: i8, de: %de: i1, d: %d: i8, q: %4: i8) -> (wr_en: i1, wr_data: i8)
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
      llhd.drv %q, %c0_i8 after %0 : i8
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
  hw.module private @prim_subreg_5(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i8, in %de : i1, in %d : i8, out qe : i1, out q : i8, out ds : i8, out qs : i8) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i8 = hw.constant 0 : i8
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_21(we: %we: i1, wd: %wd: i8, de: %de: i1, d: %d: i8, q: %4: i8) -> (wr_en: i1, wr_data: i8)
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
      llhd.drv %q, %c0_i8 after %0 : i8
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
  hw.module private @prim_subreg_6(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i4, in %de : i1, in %d : i4, out qe : i1, out q : i4, out ds : i4, out qs : i4) {
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
  hw.module private @prim_subreg_7(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i16, in %de : i1, in %d : i16, out qe : i1, out q : i16, out ds : i16, out qs : i16) {
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
  hw.module private @prim_subreg_8(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i4, in %de : i1, in %d : i4, out qe : i1, out q : i4, out ds : i4, out qs : i4) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_24(we: %we: i1, wd: %wd: i4, de: %de: i1, d: %d: i4, q: %4: i4) -> (wr_en: i1, wr_data: i4)
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
  hw.module private @prim_subreg_9(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_25(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
  hw.module private @tlul_adapter_racl(in %clk_i : i1, in %rst_ni : i1, in %tl_h2d_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_d2h_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_filtered_h2d_o : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, in %tl_filtered_d2h_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %racl_policies_i : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, out racl_error_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, in %racl_policy_sel_ranges_i : !hw.array<1xstruct<base: i32, limit: i32, policy_sel: i1, enable: i1>>) {
    %0 = hw.aggregate_constant [false, false, false, false, false, 0 : i32] : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    hw.output %tl_filtered_d2h_i, %tl_h2d_i, %0 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
  }
  hw.module private @tlul_adapter_reg_racl(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %en_ifetch_i : i4, out intg_error_o : i1, in %racl_policies_i : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, out racl_error_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, out re_o : i1, out we_o : i1, out addr_o : i6, out wdata_o : i32, out be_o : i4, in %busy_i : i1, in %rdata_i : i32, in %error_i : i1) {
    %0 = hw.aggregate_constant [false, false, false, false, false, 0 : i32] : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %tlul_adapter_reg.tl_o, %tlul_adapter_reg.intg_error_o, %tlul_adapter_reg.re_o, %tlul_adapter_reg.we_o, %tlul_adapter_reg.addr_o, %tlul_adapter_reg.wdata_o, %tlul_adapter_reg.be_o = hw.instance "tlul_adapter_reg" @tlul_adapter_reg(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, en_ifetch_i: %en_ifetch_i: i4, busy_i: %busy_i: i1, rdata_i: %rdata_i: i32, error_i: %error_i: i1) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, intg_error_o: i1, re_o: i1, we_o: i1, addr_o: i6, wdata_o: i32, be_o: i4) {sv.namehint = "tl_d2h_filtered"}
    hw.output %tlul_adapter_reg.tl_o, %tlul_adapter_reg.intg_error_o, %0, %tlul_adapter_reg.re_o, %tlul_adapter_reg.we_o, %tlul_adapter_reg.addr_o, %tlul_adapter_reg.wdata_o, %tlul_adapter_reg.be_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, i1, !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, i1, i1, i6, i32, i4
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
  hw.module private @tlul_adapter_sram_racl(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %en_ifetch_i : i4, out req_o : i1, out req_type_o : i4, in %gnt_i : i1, out we_o : i1, out addr_o : i6, out wdata_o : i32, out wmask_o : i32, out intg_error_o : i1, out user_rsvd_o : i5, in %rdata_i : i32, in %rvalid_i : i1, in %rerror_i : i2, out compound_txn_in_progress_o : i1, in %readback_en_i : i4, out readback_error_o : i1, in %wr_collision_i : i1, in %write_pending_i : i1, in %racl_policies_i : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, out racl_error_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, in %racl_policy_sel_ranges_i : !hw.array<1xstruct<base: i32, limit: i32, policy_sel: i1, enable: i1>>) {
    %tlul_adapter_racl.tl_d2h_o, %tlul_adapter_racl.tl_filtered_h2d_o, %tlul_adapter_racl.racl_error_o = hw.instance "tlul_adapter_racl" @tlul_adapter_racl(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, tl_h2d_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, tl_filtered_d2h_i: %tlul_adapter_sram.tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, racl_policies_i: %racl_policies_i: !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, racl_policy_sel_ranges_i: %racl_policy_sel_ranges_i: !hw.array<1xstruct<base: i32, limit: i32, policy_sel: i1, enable: i1>>) -> (tl_d2h_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, tl_filtered_h2d_o: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, racl_error_o: !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>) {sv.namehint = "tl_h2d_filtered"}
    %tlul_adapter_sram.tl_o, %tlul_adapter_sram.req_o, %tlul_adapter_sram.req_type_o, %tlul_adapter_sram.we_o, %tlul_adapter_sram.addr_o, %tlul_adapter_sram.wdata_o, %tlul_adapter_sram.wmask_o, %tlul_adapter_sram.intg_error_o, %tlul_adapter_sram.user_rsvd_o, %tlul_adapter_sram.compound_txn_in_progress_o, %tlul_adapter_sram.readback_error_o = hw.instance "tlul_adapter_sram" @tlul_adapter_sram(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, tl_i: %tlul_adapter_racl.tl_filtered_h2d_o: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, en_ifetch_i: %en_ifetch_i: i4, gnt_i: %gnt_i: i1, rdata_i: %rdata_i: i32, rvalid_i: %rvalid_i: i1, rerror_i: %rerror_i: i2, readback_en_i: %readback_en_i: i4, wr_collision_i: %wr_collision_i: i1, write_pending_i: %write_pending_i: i1) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, req_o: i1, req_type_o: i4, we_o: i1, addr_o: i6, wdata_o: i32, wmask_o: i32, intg_error_o: i1, user_rsvd_o: i5, compound_txn_in_progress_o: i1, readback_error_o: i1) {sv.namehint = "tl_d2h_filtered"}
    hw.output %tlul_adapter_racl.tl_d2h_o, %tlul_adapter_sram.req_o, %tlul_adapter_sram.req_type_o, %tlul_adapter_sram.we_o, %tlul_adapter_sram.addr_o, %tlul_adapter_sram.wdata_o, %tlul_adapter_sram.wmask_o, %tlul_adapter_sram.intg_error_o, %tlul_adapter_sram.user_rsvd_o, %tlul_adapter_sram.compound_txn_in_progress_o, %tlul_adapter_sram.readback_error_o, %tlul_adapter_racl.racl_error_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, i1, i4, i1, i6, i32, i32, i1, i5, i1, i1, !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
  }
  hw.module private @tlul_adapter_sram(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %en_ifetch_i : i4, out req_o : i1, out req_type_o : i4, in %gnt_i : i1, out we_o : i1, out addr_o : i6, out wdata_o : i32, out wmask_o : i32, out intg_error_o : i1, out user_rsvd_o : i5, in %rdata_i : i32, in %rvalid_i : i1, in %rerror_i : i2, out compound_txn_in_progress_o : i1, in %readback_en_i : i4, out readback_error_o : i1, in %wr_collision_i : i1, in %write_pending_i : i1) {
    %c-1_i7 = hw.constant -1 : i7
    %c0_i28 = hw.constant 0 : i28
    %c-1_i5 = hw.constant -1 : i5
    %c0_i27 = hw.constant 0 : i27
    %c0_i0 = hw.constant 0 : i0
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [0 : i7] : !hw.array<1xi7>
    %3 = hw.aggregate_constant [0 : i32] : !hw.array<1xi32>
    %4 = hw.aggregate_constant [0 : i32, 0 : i7, false] : !hw.struct<data: i32, data_intg: i7, error: i1>
    %5 = hw.aggregate_constant [0 : i4, false] : !hw.struct<mask: i4, woffset: i1>
    %6 = hw.aggregate_constant [false, false, 0 : i4, 0 : i2, 0 : i8] : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
    %7 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %c4_i32 = hw.constant 4 : i32
    %false = hw.constant false {sv.namehint = "readback_error"}
    %true = hw.constant true
    %c0_i5 = hw.constant 0 : i5
    %c0_i6 = hw.constant 0 : i6
    %c0_i7 = hw.constant 0 : i7
    %c0_i8 = hw.constant 0 : i8
    %c0_i2 = hw.constant 0 : i2
    %c42_i7 = hw.constant 42 : i7
    %c-4_i3 = hw.constant -4 : i3
    %c-1_i4 = hw.constant -1 : i4
    %c1_i3 = hw.constant 1 : i3
    %c0_i3 = hw.constant 0 : i3
    %c0_i32 = hw.constant 0 : i32
    %c1_i32 = hw.constant 1 : i32
    %c-1_i32 = hw.constant -1 : i32
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %8 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %9 = llhd.prb %rst_ni_1 : i1
    %we_o = llhd.sig %false : i1
    %rsp_fifo_error = llhd.sig %false : i1
    %sramreqfifo_error = llhd.sig %false : i1
    %reqfifo_error = llhd.sig %false : i1
    %intg_error = llhd.sig %false : i1
    %intg_error_q = llhd.sig %false : i1
    %tl_i_int = llhd.sig %7 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %reqfifo_rvalid = llhd.sig %false : i1
    %reqfifo_rdata = llhd.sig %6 : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
    %sram_req_rdata = llhd.sig %5 : !hw.struct<mask: i4, woffset: i1>
    %rspfifo_rvalid = llhd.sig %false : i1
    %rspfifo_rdata = llhd.sig %4 : !hw.struct<data: i32, data_intg: i7, error: i1>
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
    %wmask_combined = llhd.sig %3 : !hw.array<1xi32>
    %wdata_combined = llhd.sig %3 : !hw.array<1xi32>
    %wmask_int = llhd.sig %3 : !hw.array<1xi32>
    %wdata_int = llhd.sig %3 : !hw.array<1xi32>
    %wmask_intg = llhd.sig %2 : !hw.array<1xi7>
    %wdata_intg = llhd.sig %2 : !hw.array<1xi7>
    %rdata_tlword = llhd.sig %c0_i32 : i32
    %gen_rmask.rmask = llhd.sig %c0_i32 : i32
    %u_err.err_o = hw.instance "u_err" @tlul_err(clk_i: %8: i1, rst_ni: %9: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> (err_o: i1) {sv.namehint = "tlul_error"}
    %u_rsp_gen.tl_o = hw.instance "u_rsp_gen" @tlul_rsp_intg_gen_38(tl_i: %u_sram_byte.tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
    %u_sram_byte.tl_o, %u_sram_byte.tl_sram_o, %u_sram_byte.error_o, %u_sram_byte.alert_o, %u_sram_byte.compound_txn_in_progress_o = hw.instance "u_sram_byte" @tlul_sram_byte(clk_i: %8: i1, rst_ni: %9: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, tl_sram_i: %67: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, error_i: %27: i1, readback_en_i: %readback_en_i: i4, wr_collision_i: %wr_collision_i: i1, write_pending_i: %write_pending_i: i1) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, tl_sram_o: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, error_o: i1, alert_o: i1, compound_txn_in_progress_o: i1) {sv.namehint = "tl_out"}
    llhd.drv %tl_i_int, %u_sram_byte.tl_sram_o after %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %u_tlul_data_integ_enc_instr.data_intg_o = hw.instance "u_tlul_data_integ_enc_instr" @tlul_data_integ_enc(data_i: %c0_i32: i32) -> (data_intg_o: i39)
    %10 = comb.extract %u_tlul_data_integ_enc_instr.data_intg_o from 32 : (i39) -> i7
    llhd.drv %error_instr_integ, %10 after %1 : i7
    %u_tlul_data_integ_enc_data.data_intg_o = hw.instance "u_tlul_data_integ_enc_data" @tlul_data_integ_enc(data_i: %c-1_i32: i32) -> (data_intg_o: i39)
    %11 = comb.extract %u_tlul_data_integ_enc_data.data_intg_o from 32 : (i39) -> i7
    llhd.drv %error_data_integ, %11 after %1 : i7
    %12 = hw.bitcast %92 : (!hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>) -> i16
    %u_reqfifo.wready_o, %u_reqfifo.rvalid_o, %u_reqfifo.rdata_o, %u_reqfifo.full_o, %u_reqfifo.depth_o, %u_reqfifo.err_o = hw.instance "u_reqfifo" @prim_fifo_sync_39(clk_i: %8: i1, rst_ni: %9: i1, clr_i: %false: i1, wvalid_i: %31: i1, wdata_i: %12: i16, rready_i: %32: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i16, full_o: i1, depth_o: i1, err_o: i1) {sv.namehint = "reqfifo_wready"}
    llhd.drv %reqfifo_rvalid, %u_reqfifo.rvalid_o after %1 : i1
    %13 = hw.bitcast %u_reqfifo.rdata_o : (i16) -> !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
    llhd.drv %reqfifo_rdata, %13 after %1 : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
    llhd.drv %reqfifo_error, %u_reqfifo.err_o after %1 : i1
    %u_sramreqfifo.wready_o, %u_sramreqfifo.rvalid_o, %u_sramreqfifo.rdata_o, %u_sramreqfifo.full_o, %u_sramreqfifo.depth_o, %u_sramreqfifo.err_o = hw.instance "u_sramreqfifo" @prim_fifo_sync_40(clk_i: %8: i1, rst_ni: %9: i1, clr_i: %false: i1, wvalid_i: %95: i1, wdata_i: %29: i5, rready_i: %96: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i5, full_o: i1, depth_o: i1, err_o: i1) {sv.namehint = "sramreqfifo_rdata"}
    llhd.drv %sramreqfifo_error, %u_sramreqfifo.err_o after %1 : i1
    %14 = hw.bitcast %107 : (!hw.struct<data: i32, data_intg: i7, error: i1>) -> i40
    %u_rspfifo.wready_o, %u_rspfifo.rvalid_o, %u_rspfifo.rdata_o, %u_rspfifo.full_o, %u_rspfifo.depth_o, %u_rspfifo.err_o = hw.instance "u_rspfifo" @prim_fifo_sync_41(clk_i: %8: i1, rst_ni: %9: i1, clr_i: %false: i1, wvalid_i: %96: i1, wdata_i: %14: i40, rready_i: %109: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i40, full_o: i1, depth_o: i1, err_o: i1) {sv.namehint = "rspfifo_wready"}
    llhd.drv %rspfifo_rvalid, %u_rspfifo.rvalid_o after %1 : i1
    %15 = hw.bitcast %u_rspfifo.rdata_o : (i40) -> !hw.struct<data: i32, data_intg: i7, error: i1>
    llhd.drv %rspfifo_rdata, %15 after %1 : !hw.struct<data: i32, data_intg: i7, error: i1>
    llhd.drv %rsp_fifo_error, %u_rspfifo.err_o after %1 : i1
    llhd.drv %intg_error, %false after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %110 = llhd.prb %clk_i_0 : i1
      %111 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%8, %9 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %112 = llhd.prb %clk_i_0 : i1
      %113 = comb.xor bin %110, %true : i1
      %114 = comb.and bin %113, %112 : i1
      %115 = llhd.prb %rst_ni_1 : i1
      %116 = comb.xor bin %115, %true : i1
      %117 = comb.and bin %111, %116 : i1
      %118 = comb.or bin %114, %117 : i1
      cf.cond_br %118, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %119 = llhd.prb %rst_ni_1 : i1
      %120 = comb.xor %119, %true : i1
      cf.cond_br %120, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %intg_error_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %121 = llhd.prb %intg_error : i1
      %122 = llhd.prb %rsp_fifo_error : i1
      %123 = llhd.prb %sramreqfifo_error : i1
      %124 = llhd.prb %reqfifo_error : i1
      %125 = comb.or %121, %122, %123, %124 : i1
      cf.cond_br %125, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %intg_error_q, %true after %0 : i1
      cf.br ^bb1
    }
    %16 = llhd.prb %intg_error : i1
    %17 = llhd.prb %rsp_fifo_error : i1
    %18 = llhd.prb %sramreqfifo_error : i1
    %19 = llhd.prb %reqfifo_error : i1
    %20 = llhd.prb %intg_error_q : i1
    %21 = comb.or %16, %17, %18, %19, %20 : i1
    %a_opcode = hw.struct_extract %tl_i["a_opcode"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_user = hw.struct_extract %tl_i["a_user"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %instr_type = hw.struct_extract %a_user["instr_type"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %22 = func.call @"prim_mubi_pkg::mubi4_test_invalid"(%instr_type) : (i4) -> i1
    %23 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%instr_type) : (i4) -> i1
    %24 = func.call @"prim_mubi_pkg::mubi4_test_false_loose"(%en_ifetch_i) : (i4) -> i1
    %25 = comb.and %23, %24 : i1
    %26 = comb.icmp eq %a_opcode, %c-4_i3 {sv.namehint = "rd_vld_error"} : i3
    %27 = comb.or %26, %22, %25, %u_err.err_o, %16 {sv.namehint = "error_det"} : i1
    %28 = llhd.prb %tl_i_int : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %29 = hw.bitcast %93 {sv.namehint = "sramreqfifo_wdata"} : (!hw.struct<mask: i4, woffset: i1>) -> i5
    %30 = hw.bitcast %u_sramreqfifo.rdata_o : (i5) -> !hw.struct<mask: i4, woffset: i1>
    llhd.drv %sram_req_rdata, %30 after %1 : !hw.struct<mask: i4, woffset: i1>
    %a_valid = hw.struct_extract %28["a_valid"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %31 = comb.and %a_valid, %66 {sv.namehint = "a_ack"} : i1
    %d_ready = hw.struct_extract %28["d_ready"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %32 = comb.and %33, %d_ready {sv.namehint = "d_ack"} : i1
    %33 = llhd.prb %d_valid : i1
    %34 = llhd.prb %reqfifo_rvalid : i1
    %35 = llhd.prb %reqfifo_rdata : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
    %36 = llhd.prb %rspfifo_rvalid : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb8
      llhd.drv %d_valid, %false after %1 : i1
      %110 = llhd.prb %reqfifo_rvalid : i1
      cf.cond_br %110, ^bb2, ^bb7
    ^bb2:  // pred: ^bb1
      %111 = llhd.prb %reqfifo_rdata : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
      %error_7 = hw.struct_extract %111["error"] : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
      cf.cond_br %error_7, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %d_valid, %true after %1 : i1
      cf.br ^bb8
    ^bb4:  // pred: ^bb2
      %112 = llhd.prb %reqfifo_rdata : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
      %is_read_8 = hw.struct_extract %112["is_read"] : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
      cf.cond_br %is_read_8, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      %113 = llhd.prb %rspfifo_rvalid : i1
      llhd.drv %d_valid, %113 after %1 : i1
      cf.br ^bb8
    ^bb6:  // pred: ^bb4
      llhd.drv %d_valid, %true after %1 : i1
      cf.br ^bb8
    ^bb7:  // pred: ^bb1
      llhd.drv %d_valid, %false after %1 : i1
      cf.br ^bb8
    ^bb8:  // 4 preds: ^bb3, ^bb5, ^bb6, ^bb7
      llhd.wait (%33, %34, %35, %36 : i1, i1, !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>, i1), ^bb1
    }
    %37 = llhd.prb %d_error : i1
    %38 = llhd.prb %rspfifo_rdata : !hw.struct<data: i32, data_intg: i7, error: i1>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      llhd.drv %d_error, %false after %1 : i1
      %110 = llhd.prb %reqfifo_rvalid : i1
      cf.cond_br %110, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      %111 = llhd.prb %reqfifo_rdata : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
      %is_read_7 = hw.struct_extract %111["is_read"] : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
      cf.cond_br %is_read_7, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %112 = llhd.prb %rspfifo_rdata : !hw.struct<data: i32, data_intg: i7, error: i1>
      %error_8 = hw.struct_extract %112["error"] : !hw.struct<data: i32, data_intg: i7, error: i1>
      %113 = llhd.prb %reqfifo_rdata : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
      %error_9 = hw.struct_extract %113["error"] : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
      %114 = comb.or %error_8, %error_9 : i1
      llhd.drv %d_error, %114 after %1 : i1
      cf.br ^bb6
    ^bb4:  // pred: ^bb2
      %115 = llhd.prb %reqfifo_rdata : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
      %error_10 = hw.struct_extract %115["error"] : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
      llhd.drv %d_error, %error_10 after %1 : i1
      cf.br ^bb6
    ^bb5:  // pred: ^bb1
      llhd.drv %d_error, %false after %1 : i1
      cf.br ^bb6
    ^bb6:  // 3 preds: ^bb3, ^bb4, ^bb5
      llhd.wait (%37, %34, %35, %38 : i1, i1, !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>, !hw.struct<data: i32, data_intg: i7, error: i1>), ^bb1
    }
    %is_read = hw.struct_extract %35["is_read"] : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
    %39 = comb.and %33, %36, %is_read : i1
    llhd.drv %vld_rd_rsp, %39 after %1 : i1
    %instr_type_2 = hw.struct_extract %35["instr_type"] : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
    %40 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%instr_type_2) : (i4) -> i1
    %41 = comb.mux %40, %c0_i32, %c-1_i32 : i32
    llhd.drv %error_blanking_data, %41 after %1 : i32
    %42 = func.call @"prim_mubi_pkg::mubi4_test_true_strict"(%instr_type_2) : (i4) -> i1
    %43 = llhd.prb %error_instr_integ : i7
    %44 = llhd.prb %error_data_integ : i7
    %45 = comb.mux %42, %43, %44 : i7
    llhd.drv %error_blanking_integ, %45 after %1 : i7
    %46 = llhd.prb %vld_rd_rsp : i1
    %47 = comb.xor %37, %true : i1
    %48 = comb.and %46, %47 : i1
    %data = hw.struct_extract %38["data"] : !hw.struct<data: i32, data_intg: i7, error: i1>
    %49 = llhd.prb %error_blanking_data : i32
    %50 = comb.mux %48, %data, %49 {sv.namehint = "d_data"} : i32
    %error = hw.struct_extract %35["error"] : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
    %51 = llhd.prb %error_blanking_integ : i7
    %data_intg = hw.struct_extract %38["data_intg"] : !hw.struct<data: i32, data_intg: i7, error: i1>
    %52 = comb.mux %46, %data_intg, %c42_i7 : i7
    %53 = comb.mux %error, %51, %52 {sv.namehint = "data_intg"} : i7
    %54 = comb.xor %66, %true : i1
    %55 = comb.and %u_sram_byte.error_o, %a_valid, %54 : i1
    llhd.drv %missed_err_gnt_d, %55 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %110 = llhd.prb %clk_i_0 : i1
      %111 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%8, %9 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %112 = llhd.prb %clk_i_0 : i1
      %113 = comb.xor bin %110, %true : i1
      %114 = comb.and bin %113, %112 : i1
      %115 = llhd.prb %rst_ni_1 : i1
      %116 = comb.xor bin %115, %true : i1
      %117 = comb.and bin %111, %116 : i1
      %118 = comb.or bin %114, %117 : i1
      cf.cond_br %118, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %119 = llhd.prb %rst_ni_1 : i1
      %120 = comb.xor %119, %true : i1
      cf.cond_br %120, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %missed_err_gnt_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %121 = llhd.prb %missed_err_gnt_d : i1
      llhd.drv %missed_err_gnt_q, %121 after %0 : i1
      cf.br ^bb1
    }
    %56 = comb.xor %is_read, %true : i1
    %57 = comb.and %33, %56 : i1
    %58 = comb.xor %57, %true : i1
    %59 = comb.concat %c0_i2, %58 : i2, i1
    %size = hw.struct_extract %35["size"] : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
    %60 = comb.mux %33, %size, %c0_i2 : i2
    %source = hw.struct_extract %35["source"] : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
    %61 = comb.mux %33, %source, %c0_i8 : i8
    %62 = hw.struct_create (%c0_i7, %53) : !hw.struct<rsp_intg: i7, data_intg: i7>
    %63 = comb.and %33, %37 : i1
    %64 = llhd.prb %missed_err_gnt_q : i1
    %65 = comb.or %gnt_i, %64 : i1
    %66 = comb.and %65, %u_reqfifo.wready_o, %u_sramreqfifo.wready_o : i1
    %67 = hw.struct_create (%33, %59, %c0_i3, %60, %61, %false, %50, %62, %63, %66) {sv.namehint = "tl_o_int"} : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %68 = comb.xor %u_sram_byte.error_o, %true : i1
    %69 = comb.and %a_valid, %u_reqfifo.wready_o, %68 : i1
    %a_user_3 = hw.struct_extract %28["a_user"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %instr_type_4 = hw.struct_extract %a_user_3["instr_type"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %a_opcode_5 = hw.struct_extract %28["a_opcode"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %70 = comb.icmp weq %a_opcode_5, %c0_i3 : i3
    %71 = comb.icmp weq %a_opcode_5, %c1_i3 : i3
    %72 = comb.or %70, %71 : i1
    %73 = comb.and %a_valid, %72 : i1
    llhd.drv %we_o, %73 after %1 : i1
    %a_address = hw.struct_extract %28["a_address"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %74 = comb.extract %a_address from 2 : (i32) -> i6
    %75 = comb.mux %a_valid, %74, %c0_i6 : i6
    %rsvd = hw.struct_extract %a_user_3["rsvd"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %76 = comb.mux %a_valid, %rsvd, %c0_i5 : i5
    llhd.drv %woffset, %false after %1 : i1
    %77 = llhd.prb %wmask_int : !hw.array<1xi32>
    %78 = llhd.prb %wdata_int : !hw.array<1xi32>
    %79 = llhd.prb %woffset : i1
    %80 = llhd.prb %we_o : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb5
      llhd.drv %wmask_int, %3 after %1 : !hw.array<1xi32>
      llhd.drv %wdata_int, %3 after %1 : !hw.array<1xi32>
      %110 = llhd.prb %tl_i_int : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_valid_7 = hw.struct_extract %110["a_valid"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      cf.cond_br %a_valid_7, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      %i = llhd.sig %c0_i32 : i32
      llhd.drv %i, %c0_i32 after %1 : i32
      cf.br ^bb3
    ^bb3:  // 2 preds: ^bb2, ^bb4
      %111 = llhd.prb %i : i32
      %112 = comb.icmp slt %111, %c4_i32 : i32
      cf.cond_br %112, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %113 = llhd.prb %woffset : i1
      %114 = comb.xor %113, %true : i1
      %115 = comb.extract %113 from 0 : (i1) -> i0
      %116 = comb.mux %114, %115, %c0_i0 : i0
      %117 = llhd.sig.array_get %wmask_int[%116] : <!hw.array<1xi32>>
      %118 = llhd.prb %i : i32
      %119 = comb.extract %118 from 2 : (i32) -> i27
      %120 = comb.icmp eq %119, %c0_i27 : i27
      %121 = comb.extract %118 from 0 : (i32) -> i2
      %122 = comb.concat %121, %c0_i3 : i2, i3
      %123 = comb.mux %120, %122, %c-1_i5 : i5
      %124 = llhd.sig.extract %117 from %123 : <i32> -> <i8>
      %125 = llhd.prb %tl_i_int : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_mask_8 = hw.struct_extract %125["a_mask"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %126 = comb.extract %118 from 4 : (i32) -> i28
      %127 = comb.icmp eq %126, %c0_i28 : i28
      %128 = comb.extract %118 from 0 : (i32) -> i4
      %129 = comb.mux %127, %128, %c-1_i4 : i4
      %130 = comb.shru %a_mask_8, %129 : i4
      %131 = comb.extract %130 from 0 : (i4) -> i1
      %132 = comb.replicate %131 : (i1) -> i8
      llhd.drv %124, %132 after %1 : i8
      %133 = llhd.prb %woffset : i1
      %134 = comb.xor %133, %true : i1
      %135 = comb.extract %133 from 0 : (i1) -> i0
      %136 = comb.mux %134, %135, %c0_i0 : i0
      %137 = llhd.sig.array_get %wdata_int[%136] : <!hw.array<1xi32>>
      %138 = llhd.prb %i : i32
      %139 = comb.extract %138 from 0 : (i32) -> i29
      %140 = comb.concat %139, %c0_i3 : i29, i3
      %141 = comb.extract %138 from 2 : (i32) -> i27
      %142 = comb.icmp eq %141, %c0_i27 : i27
      %143 = comb.extract %138 from 0 : (i32) -> i2
      %144 = comb.concat %143, %c0_i3 : i2, i3
      %145 = comb.mux %142, %144, %c-1_i5 : i5
      %146 = llhd.sig.extract %137 from %145 : <i32> -> <i8>
      %147 = llhd.prb %tl_i_int : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_mask_9 = hw.struct_extract %147["a_mask"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %148 = comb.extract %138 from 4 : (i32) -> i28
      %149 = comb.icmp eq %148, %c0_i28 : i28
      %150 = comb.extract %138 from 0 : (i32) -> i4
      %151 = comb.mux %149, %150, %c-1_i4 : i4
      %152 = comb.shru %a_mask_9, %151 : i4
      %153 = comb.extract %152 from 0 : (i4) -> i1
      %154 = llhd.prb %we_o : i1
      %155 = comb.and %153, %154 : i1
      %a_data = hw.struct_extract %147["a_data"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %156 = comb.shru %a_data, %140 : i32
      %157 = comb.extract %156 from 0 : (i32) -> i8
      %158 = comb.mux %155, %157, %c0_i8 : i8
      llhd.drv %146, %158 after %1 : i8
      %159 = llhd.prb %i : i32
      %160 = comb.add %159, %c1_i32 : i32
      llhd.drv %i, %160 after %1 : i32
      cf.br ^bb3
    ^bb5:  // 2 preds: ^bb1, ^bb3
      llhd.wait (%77, %78, %28, %79, %80 : !hw.array<1xi32>, !hw.array<1xi32>, !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, i1, i1), ^bb1
    }
    %81 = llhd.prb %wmask_intg : !hw.array<1xi7>
    %82 = llhd.prb %wdata_intg : !hw.array<1xi7>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb3
      llhd.drv %wmask_intg, %2 after %1 : !hw.array<1xi7>
      llhd.drv %wdata_intg, %2 after %1 : !hw.array<1xi7>
      %110 = llhd.prb %tl_i_int : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_valid_7 = hw.struct_extract %110["a_valid"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      cf.cond_br %a_valid_7, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %111 = llhd.prb %woffset : i1
      %112 = comb.xor %111, %true : i1
      %113 = comb.extract %111 from 0 : (i1) -> i0
      %114 = comb.mux %112, %113, %c0_i0 : i0
      %115 = llhd.sig.array_get %wmask_intg[%114] : <!hw.array<1xi7>>
      llhd.drv %115, %c-1_i7 after %1 : i7
      %116 = llhd.prb %woffset : i1
      %117 = comb.xor %116, %true : i1
      %118 = comb.extract %116 from 0 : (i1) -> i0
      %119 = comb.mux %117, %118, %c0_i0 : i0
      %120 = llhd.sig.array_get %wdata_intg[%119] : <!hw.array<1xi7>>
      %121 = llhd.prb %tl_i_int : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_user_8 = hw.struct_extract %121["a_user"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %data_intg_9 = hw.struct_extract %a_user_8["data_intg"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
      llhd.drv %120, %data_intg_9 after %1 : i7
      cf.br ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      llhd.wait (%81, %82, %28, %79 : !hw.array<1xi7>, !hw.array<1xi7>, !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, i1), ^bb1
    }
    %83 = llhd.sig.array_get %wmask_combined[%c0_i0] : <!hw.array<1xi32>>
    %84 = hw.array_get %77[%c0_i0] : !hw.array<1xi32>, i0
    llhd.drv %83, %84 after %1 : i32
    %85 = llhd.sig.array_get %wdata_combined[%c0_i0] : <!hw.array<1xi32>>
    %86 = hw.array_get %78[%c0_i0] : !hw.array<1xi32>, i0
    llhd.drv %85, %86 after %1 : i32
    %87 = llhd.prb %wmask_combined : !hw.array<1xi32>
    %88 = hw.bitcast %87 : (!hw.array<1xi32>) -> i32
    %89 = llhd.prb %wdata_combined : !hw.array<1xi32>
    %90 = hw.bitcast %89 : (!hw.array<1xi32>) -> i32
    %91 = comb.icmp eq %a_opcode_5, %c-4_i3 : i3
    %a_size = hw.struct_extract %28["a_size"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_source = hw.struct_extract %28["a_source"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %92 = hw.struct_create (%91, %u_sram_byte.error_o, %instr_type_4, %a_size, %a_source) {sv.namehint = "reqfifo_wdata"} : !hw.struct<is_read: i1, error: i1, instr_type: i4, size: i2, source: i8>
    %a_mask = hw.struct_extract %28["a_mask"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %93 = hw.struct_create (%a_mask, %79) {sv.namehint = "sram_req_wdata"} : !hw.struct<mask: i4, woffset: i1>
    %94 = comb.xor %80, %true : i1
    %95 = comb.and %69, %gnt_i, %94 {sv.namehint = "sramreqfifo_wvalid"} : i1
    %96 = comb.and %rvalid_i, %34 {sv.namehint = "rspfifo_wvalid"} : i1
    %97 = hw.bitcast %rdata_i {sv.namehint = "rdata_reshaped"} : (i32) -> !hw.array<1xi32>
    %98 = llhd.prb %gen_rmask.rmask : i32
    %99 = llhd.prb %sram_req_rdata : !hw.struct<mask: i4, woffset: i1>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb4
      llhd.drv %gen_rmask.rmask, %c0_i32 after %1 : i32
      cf.br ^bb2(%c0_i32 : i32)
    ^bb2(%110: i32):  // 2 preds: ^bb1, ^bb3
      %111 = comb.icmp slt %110, %c4_i32 : i32
      cf.cond_br %111, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      %112 = comb.extract %110 from 2 : (i32) -> i27
      %113 = comb.icmp eq %112, %c0_i27 : i27
      %114 = comb.extract %110 from 0 : (i32) -> i2
      %115 = comb.concat %114, %c0_i3 : i2, i3
      %116 = comb.mux %113, %115, %c-1_i5 : i5
      %117 = llhd.sig.extract %gen_rmask.rmask from %116 : <i32> -> <i8>
      %118 = llhd.prb %sram_req_rdata : !hw.struct<mask: i4, woffset: i1>
      %mask = hw.struct_extract %118["mask"] : !hw.struct<mask: i4, woffset: i1>
      %119 = comb.extract %110 from 4 : (i32) -> i28
      %120 = comb.icmp eq %119, %c0_i28 : i28
      %121 = comb.extract %110 from 0 : (i32) -> i4
      %122 = comb.mux %120, %121, %c-1_i4 : i4
      %123 = comb.shru %mask, %122 : i4
      %124 = comb.extract %123 from 0 : (i4) -> i1
      %125 = comb.replicate %124 : (i1) -> i8
      llhd.drv %117, %125 after %1 : i8
      %126 = comb.add %110, %c1_i32 : i32
      cf.br ^bb2(%126 : i32)
    ^bb4:  // pred: ^bb2
      llhd.wait (%98, %99 : i32, !hw.struct<mask: i4, woffset: i1>), ^bb1
    }
    %woffset_6 = hw.struct_extract %99["woffset"] : !hw.struct<mask: i4, woffset: i1>
    %100 = comb.xor %woffset_6, %true : i1
    %101 = comb.extract %woffset_6 from 0 : (i1) -> i0
    %102 = comb.mux %100, %101, %c0_i0 : i0
    %103 = hw.array_get %97[%102] : !hw.array<1xi32>, i0
    %104 = comb.and %103, %98 : i32
    llhd.drv %rdata_tlword, %104 after %1 : i32
    %105 = llhd.prb %rdata_tlword : i32
    %106 = comb.extract %rerror_i from 1 : (i2) -> i1
    %107 = hw.struct_create (%105, %c0_i7, %106) {sv.namehint = "rspfifo_wdata"} : !hw.struct<data: i32, data_intg: i7, error: i1>
    %108 = comb.xor %error, %true : i1
    %109 = comb.and %is_read, %108, %32 {sv.namehint = "rspfifo_rready"} : i1
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    hw.output %u_rsp_gen.tl_o, %69, %instr_type_4, %80, %75, %90, %88, %21, %76, %u_sram_byte.compound_txn_in_progress_o, %false : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, i1, i4, i1, i6, i32, i32, i1, i5, i1, i1
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
  hw.module private @tlul_fifo_sync(in %clk_i : i1, in %rst_ni : i1, in %tl_h_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_h_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_d_o : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, in %tl_d_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %spare_req_i : i2, out spare_req_o : i2, in %spare_rsp_i : i1, out spare_rsp_o : i1) {
    %c0_i32 = hw.constant 0 : i32
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %false = hw.constant false
    %c1_i3 = hw.constant 1 : i3
    %2 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %tl_h_o = llhd.sig %2 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %tl_d_o = llhd.sig %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %tl_d_i_0 = llhd.sig name "tl_d_i" %2 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %a_valid = hw.struct_extract %tl_h_i["a_valid"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %3 = llhd.sig.struct_extract %tl_h_o["a_ready"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %a_opcode = hw.struct_extract %tl_h_i["a_opcode"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_param = hw.struct_extract %tl_h_i["a_param"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_size = hw.struct_extract %tl_h_i["a_size"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_source = hw.struct_extract %tl_h_i["a_source"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_address = hw.struct_extract %tl_h_i["a_address"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_mask = hw.struct_extract %tl_h_i["a_mask"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_data = hw.struct_extract %tl_h_i["a_data"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_user = hw.struct_extract %tl_h_i["a_user"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %rsvd = hw.struct_extract %a_user["rsvd"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %instr_type = hw.struct_extract %a_user["instr_type"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %4 = comb.concat %a_opcode, %a_param, %a_size, %a_source, %a_address, %a_mask, %a_data, %rsvd, %instr_type, %spare_req_i : i3, i3, i2, i8, i32, i4, i32, i5, i4, i2
    %5 = llhd.sig.struct_extract %tl_d_o["a_valid"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %6 = llhd.prb %tl_d_i_0 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %a_ready = hw.struct_extract %6["a_ready"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %7 = llhd.sig.struct_extract %tl_d_o["a_opcode"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %8 = llhd.sig.struct_extract %tl_d_o["a_param"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %9 = llhd.sig.struct_extract %tl_d_o["a_size"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %10 = llhd.sig.struct_extract %tl_d_o["a_source"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %11 = llhd.sig.struct_extract %tl_d_o["a_address"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %12 = llhd.sig.struct_extract %tl_d_o["a_mask"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %13 = llhd.sig.struct_extract %tl_d_o["a_data"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %14 = llhd.sig.struct_extract %tl_d_o["a_user"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %15 = llhd.sig.struct_extract %14["rsvd"] : <!hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>>
    %16 = llhd.sig.struct_extract %14["instr_type"] : <!hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>>
    %reqfifo.wready_o, %reqfifo.rvalid_o, %reqfifo.rdata_o, %reqfifo.full_o, %reqfifo.depth_o, %reqfifo.err_o = hw.instance "reqfifo" @prim_fifo_sync_32(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clr_i: %false: i1, wvalid_i: %a_valid: i1, wdata_i: %4: i95, rready_i: %a_ready: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i95, full_o: i1, depth_o: i1, err_o: i1)
    llhd.drv %3, %reqfifo.wready_o after %0 : i1
    llhd.drv %5, %reqfifo.rvalid_o after %0 : i1
    %17 = comb.extract %reqfifo.rdata_o from 92 : (i95) -> i3
    llhd.drv %7, %17 after %0 : i3
    %18 = comb.extract %reqfifo.rdata_o from 89 : (i95) -> i3
    llhd.drv %8, %18 after %0 : i3
    %19 = comb.extract %reqfifo.rdata_o from 87 : (i95) -> i2
    llhd.drv %9, %19 after %0 : i2
    %20 = comb.extract %reqfifo.rdata_o from 79 : (i95) -> i8
    llhd.drv %10, %20 after %0 : i8
    %21 = comb.extract %reqfifo.rdata_o from 47 : (i95) -> i32
    llhd.drv %11, %21 after %0 : i32
    %22 = comb.extract %reqfifo.rdata_o from 43 : (i95) -> i4
    llhd.drv %12, %22 after %0 : i4
    %23 = comb.extract %reqfifo.rdata_o from 11 : (i95) -> i32
    llhd.drv %13, %23 after %0 : i32
    %24 = comb.extract %reqfifo.rdata_o from 6 : (i95) -> i5
    llhd.drv %15, %24 after %0 : i5
    %25 = comb.extract %reqfifo.rdata_o from 2 : (i95) -> i4
    llhd.drv %16, %25 after %0 : i4
    %26 = comb.extract %reqfifo.rdata_o from 0 : (i95) -> i2
    %u_reqfifo_intg_prim_buf.out_o = hw.instance "u_reqfifo_intg_prim_buf" @prim_buf_26(in_i: %55: i2) -> (out_o: i2) {sv.namehint = "buf_reqfifo_intg_out"}
    %cmd_intg = hw.struct_extract %a_user["cmd_intg"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %data_intg = hw.struct_extract %a_user["data_intg"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %27 = comb.concat %cmd_intg, %data_intg : i7, i7
    %28 = llhd.sig.struct_extract %14["cmd_intg"] : <!hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>>
    %29 = llhd.sig.struct_extract %14["data_intg"] : <!hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>>
    %reqfifo_intg.wready_o, %reqfifo_intg.rvalid_o, %reqfifo_intg.rdata_o, %reqfifo_intg.full_o, %reqfifo_intg.depth_o, %reqfifo_intg.err_o = hw.instance "reqfifo_intg" @prim_fifo_sync_33(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clr_i: %false: i1, wvalid_i: %56: i1, wdata_i: %27: i14, rready_i: %57: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i14, full_o: i1, depth_o: i1, err_o: i1)
    %30 = comb.extract %reqfifo_intg.rdata_o from 7 : (i14) -> i7
    llhd.drv %28, %30 after %0 : i7
    %31 = comb.extract %reqfifo_intg.rdata_o from 0 : (i14) -> i7
    llhd.drv %29, %31 after %0 : i7
    %d_valid = hw.struct_extract %6["d_valid"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %32 = llhd.sig.struct_extract %tl_d_o["d_ready"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %d_opcode = hw.struct_extract %6["d_opcode"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %d_param = hw.struct_extract %6["d_param"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %d_size = hw.struct_extract %6["d_size"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %d_source = hw.struct_extract %6["d_source"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %d_sink = hw.struct_extract %6["d_sink"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %33 = comb.icmp eq %d_opcode, %c1_i3 : i3
    %d_data = hw.struct_extract %6["d_data"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %34 = comb.mux %33, %d_data, %c0_i32 : i32
    %d_error = hw.struct_extract %6["d_error"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %35 = comb.concat %d_opcode, %d_param, %d_size, %d_source, %d_sink, %34, %d_error, %spare_rsp_i : i3, i3, i2, i8, i1, i32, i1, i1
    %36 = llhd.sig.struct_extract %tl_h_o["d_valid"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %d_ready = hw.struct_extract %tl_h_i["d_ready"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %37 = llhd.sig.struct_extract %tl_h_o["d_opcode"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %38 = llhd.sig.struct_extract %tl_h_o["d_param"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %39 = llhd.sig.struct_extract %tl_h_o["d_size"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %40 = llhd.sig.struct_extract %tl_h_o["d_source"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %41 = llhd.sig.struct_extract %tl_h_o["d_sink"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %42 = llhd.sig.struct_extract %tl_h_o["d_data"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %43 = llhd.sig.struct_extract %tl_h_o["d_error"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %rspfifo.wready_o, %rspfifo.rvalid_o, %rspfifo.rdata_o, %rspfifo.full_o, %rspfifo.depth_o, %rspfifo.err_o = hw.instance "rspfifo" @prim_fifo_sync_34(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clr_i: %false: i1, wvalid_i: %d_valid: i1, wdata_i: %35: i51, rready_i: %d_ready: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i51, full_o: i1, depth_o: i1, err_o: i1)
    llhd.drv %32, %rspfifo.wready_o after %0 : i1
    llhd.drv %36, %rspfifo.rvalid_o after %0 : i1
    %44 = comb.extract %rspfifo.rdata_o from 48 : (i51) -> i3
    llhd.drv %37, %44 after %0 : i3
    %45 = comb.extract %rspfifo.rdata_o from 45 : (i51) -> i3
    llhd.drv %38, %45 after %0 : i3
    %46 = comb.extract %rspfifo.rdata_o from 43 : (i51) -> i2
    llhd.drv %39, %46 after %0 : i2
    %47 = comb.extract %rspfifo.rdata_o from 35 : (i51) -> i8
    llhd.drv %40, %47 after %0 : i8
    %48 = comb.extract %rspfifo.rdata_o from 34 : (i51) -> i1
    llhd.drv %41, %48 after %0 : i1
    %49 = comb.extract %rspfifo.rdata_o from 2 : (i51) -> i32
    llhd.drv %42, %49 after %0 : i32
    %50 = comb.extract %rspfifo.rdata_o from 1 : (i51) -> i1
    llhd.drv %43, %50 after %0 : i1
    %51 = comb.extract %rspfifo.rdata_o from 0 : (i51) -> i1
    %u_rspfifo_intg_prim_buf.out_o = hw.instance "u_rspfifo_intg_prim_buf" @prim_buf_26(in_i: %58: i2) -> (out_o: i2) {sv.namehint = "buf_rspfifo_intg_out"}
    %d_user = hw.struct_extract %6["d_user"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %52 = llhd.sig.struct_extract %tl_h_o["d_user"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %53 = hw.bitcast %d_user : (!hw.struct<rsp_intg: i7, data_intg: i7>) -> i14
    %rspfifo_intg.wready_o, %rspfifo_intg.rvalid_o, %rspfifo_intg.rdata_o, %rspfifo_intg.full_o, %rspfifo_intg.depth_o, %rspfifo_intg.err_o = hw.instance "rspfifo_intg" @prim_fifo_sync_33(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clr_i: %false: i1, wvalid_i: %59: i1, wdata_i: %53: i14, rready_i: %60: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i14, full_o: i1, depth_o: i1, err_o: i1)
    %54 = hw.bitcast %rspfifo_intg.rdata_o : (i14) -> !hw.struct<rsp_intg: i7, data_intg: i7>
    llhd.drv %52, %54 after %0 : !hw.struct<rsp_intg: i7, data_intg: i7>
    %55 = comb.concat %a_valid, %a_ready {sv.namehint = "buf_reqfifo_intg_in"} : i1, i1
    %56 = comb.extract %u_reqfifo_intg_prim_buf.out_o from 1 {sv.namehint = "reqfifo_intg_a_valid_buf"} : (i2) -> i1
    %57 = comb.extract %u_reqfifo_intg_prim_buf.out_o from 0 {sv.namehint = "reqfifo_intg_a_ready_buf"} : (i2) -> i1
    %58 = comb.concat %d_valid, %d_ready {sv.namehint = "buf_rspfifo_intg_in"} : i1, i1
    %59 = comb.extract %u_rspfifo_intg_prim_buf.out_o from 1 {sv.namehint = "rspfifo_intg_d_valid_buf"} : (i2) -> i1
    %60 = comb.extract %u_rspfifo_intg_prim_buf.out_o from 0 {sv.namehint = "rspfifo_intg_d_ready_buf"} : (i2) -> i1
    %61 = llhd.prb %tl_h_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %62 = llhd.prb %tl_d_o : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    llhd.drv %tl_d_i_0, %tl_d_i after %0 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    hw.output %61, %62, %26, %51 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, i2, i1
  }
  hw.module private @tlul_fifo_sync_16(in %clk_i : i1, in %rst_ni : i1, in %tl_h_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_h_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_d_o : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, in %tl_d_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %spare_req_i : i1, out spare_req_o : i1, in %spare_rsp_i : i1, out spare_rsp_o : i1) {
    %c0_i32 = hw.constant 0 : i32
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %false = hw.constant false
    %c1_i3 = hw.constant 1 : i3
    %2 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %tl_h_o = llhd.sig %2 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %tl_d_o = llhd.sig %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %tl_d_i_0 = llhd.sig name "tl_d_i" %2 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %a_valid = hw.struct_extract %tl_h_i["a_valid"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %3 = llhd.sig.struct_extract %tl_h_o["a_ready"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %a_opcode = hw.struct_extract %tl_h_i["a_opcode"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_param = hw.struct_extract %tl_h_i["a_param"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_size = hw.struct_extract %tl_h_i["a_size"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_source = hw.struct_extract %tl_h_i["a_source"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_address = hw.struct_extract %tl_h_i["a_address"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_mask = hw.struct_extract %tl_h_i["a_mask"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_data = hw.struct_extract %tl_h_i["a_data"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_user = hw.struct_extract %tl_h_i["a_user"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %rsvd = hw.struct_extract %a_user["rsvd"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %instr_type = hw.struct_extract %a_user["instr_type"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %4 = comb.concat %a_opcode, %a_param, %a_size, %a_source, %a_address, %a_mask, %a_data, %rsvd, %instr_type, %spare_req_i : i3, i3, i2, i8, i32, i4, i32, i5, i4, i1
    %5 = llhd.sig.struct_extract %tl_d_o["a_valid"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %6 = llhd.prb %tl_d_i_0 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %a_ready = hw.struct_extract %6["a_ready"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %7 = llhd.sig.struct_extract %tl_d_o["a_opcode"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %8 = llhd.sig.struct_extract %tl_d_o["a_param"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %9 = llhd.sig.struct_extract %tl_d_o["a_size"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %10 = llhd.sig.struct_extract %tl_d_o["a_source"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %11 = llhd.sig.struct_extract %tl_d_o["a_address"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %12 = llhd.sig.struct_extract %tl_d_o["a_mask"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %13 = llhd.sig.struct_extract %tl_d_o["a_data"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %14 = llhd.sig.struct_extract %tl_d_o["a_user"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %15 = llhd.sig.struct_extract %14["rsvd"] : <!hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>>
    %16 = llhd.sig.struct_extract %14["instr_type"] : <!hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>>
    %reqfifo.wready_o, %reqfifo.rvalid_o, %reqfifo.rdata_o, %reqfifo.full_o, %reqfifo.depth_o, %reqfifo.err_o = hw.instance "reqfifo" @prim_fifo_sync_35(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clr_i: %false: i1, wvalid_i: %a_valid: i1, wdata_i: %4: i94, rready_i: %a_ready: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i94, full_o: i1, depth_o: i1, err_o: i1)
    llhd.drv %3, %reqfifo.wready_o after %0 : i1
    llhd.drv %5, %reqfifo.rvalid_o after %0 : i1
    %17 = comb.extract %reqfifo.rdata_o from 91 : (i94) -> i3
    llhd.drv %7, %17 after %0 : i3
    %18 = comb.extract %reqfifo.rdata_o from 88 : (i94) -> i3
    llhd.drv %8, %18 after %0 : i3
    %19 = comb.extract %reqfifo.rdata_o from 86 : (i94) -> i2
    llhd.drv %9, %19 after %0 : i2
    %20 = comb.extract %reqfifo.rdata_o from 78 : (i94) -> i8
    llhd.drv %10, %20 after %0 : i8
    %21 = comb.extract %reqfifo.rdata_o from 46 : (i94) -> i32
    llhd.drv %11, %21 after %0 : i32
    %22 = comb.extract %reqfifo.rdata_o from 42 : (i94) -> i4
    llhd.drv %12, %22 after %0 : i4
    %23 = comb.extract %reqfifo.rdata_o from 10 : (i94) -> i32
    llhd.drv %13, %23 after %0 : i32
    %24 = comb.extract %reqfifo.rdata_o from 5 : (i94) -> i5
    llhd.drv %15, %24 after %0 : i5
    %25 = comb.extract %reqfifo.rdata_o from 1 : (i94) -> i4
    llhd.drv %16, %25 after %0 : i4
    %26 = comb.extract %reqfifo.rdata_o from 0 : (i94) -> i1
    %u_reqfifo_intg_prim_buf.out_o = hw.instance "u_reqfifo_intg_prim_buf" @prim_buf_26(in_i: %55: i2) -> (out_o: i2) {sv.namehint = "buf_reqfifo_intg_out"}
    %cmd_intg = hw.struct_extract %a_user["cmd_intg"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %data_intg = hw.struct_extract %a_user["data_intg"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %27 = comb.concat %cmd_intg, %data_intg : i7, i7
    %28 = llhd.sig.struct_extract %14["cmd_intg"] : <!hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>>
    %29 = llhd.sig.struct_extract %14["data_intg"] : <!hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>>
    %reqfifo_intg.wready_o, %reqfifo_intg.rvalid_o, %reqfifo_intg.rdata_o, %reqfifo_intg.full_o, %reqfifo_intg.depth_o, %reqfifo_intg.err_o = hw.instance "reqfifo_intg" @prim_fifo_sync_33(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clr_i: %false: i1, wvalid_i: %56: i1, wdata_i: %27: i14, rready_i: %57: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i14, full_o: i1, depth_o: i1, err_o: i1)
    %30 = comb.extract %reqfifo_intg.rdata_o from 7 : (i14) -> i7
    llhd.drv %28, %30 after %0 : i7
    %31 = comb.extract %reqfifo_intg.rdata_o from 0 : (i14) -> i7
    llhd.drv %29, %31 after %0 : i7
    %d_valid = hw.struct_extract %6["d_valid"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %32 = llhd.sig.struct_extract %tl_d_o["d_ready"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %d_opcode = hw.struct_extract %6["d_opcode"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %d_param = hw.struct_extract %6["d_param"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %d_size = hw.struct_extract %6["d_size"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %d_source = hw.struct_extract %6["d_source"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %d_sink = hw.struct_extract %6["d_sink"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %33 = comb.icmp eq %d_opcode, %c1_i3 : i3
    %d_data = hw.struct_extract %6["d_data"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %34 = comb.mux %33, %d_data, %c0_i32 : i32
    %d_error = hw.struct_extract %6["d_error"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %35 = comb.concat %d_opcode, %d_param, %d_size, %d_source, %d_sink, %34, %d_error, %spare_rsp_i : i3, i3, i2, i8, i1, i32, i1, i1
    %36 = llhd.sig.struct_extract %tl_h_o["d_valid"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %d_ready = hw.struct_extract %tl_h_i["d_ready"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %37 = llhd.sig.struct_extract %tl_h_o["d_opcode"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %38 = llhd.sig.struct_extract %tl_h_o["d_param"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %39 = llhd.sig.struct_extract %tl_h_o["d_size"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %40 = llhd.sig.struct_extract %tl_h_o["d_source"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %41 = llhd.sig.struct_extract %tl_h_o["d_sink"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %42 = llhd.sig.struct_extract %tl_h_o["d_data"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %43 = llhd.sig.struct_extract %tl_h_o["d_error"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %rspfifo.wready_o, %rspfifo.rvalid_o, %rspfifo.rdata_o, %rspfifo.full_o, %rspfifo.depth_o, %rspfifo.err_o = hw.instance "rspfifo" @prim_fifo_sync_34(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clr_i: %false: i1, wvalid_i: %d_valid: i1, wdata_i: %35: i51, rready_i: %d_ready: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i51, full_o: i1, depth_o: i1, err_o: i1)
    llhd.drv %32, %rspfifo.wready_o after %0 : i1
    llhd.drv %36, %rspfifo.rvalid_o after %0 : i1
    %44 = comb.extract %rspfifo.rdata_o from 48 : (i51) -> i3
    llhd.drv %37, %44 after %0 : i3
    %45 = comb.extract %rspfifo.rdata_o from 45 : (i51) -> i3
    llhd.drv %38, %45 after %0 : i3
    %46 = comb.extract %rspfifo.rdata_o from 43 : (i51) -> i2
    llhd.drv %39, %46 after %0 : i2
    %47 = comb.extract %rspfifo.rdata_o from 35 : (i51) -> i8
    llhd.drv %40, %47 after %0 : i8
    %48 = comb.extract %rspfifo.rdata_o from 34 : (i51) -> i1
    llhd.drv %41, %48 after %0 : i1
    %49 = comb.extract %rspfifo.rdata_o from 2 : (i51) -> i32
    llhd.drv %42, %49 after %0 : i32
    %50 = comb.extract %rspfifo.rdata_o from 1 : (i51) -> i1
    llhd.drv %43, %50 after %0 : i1
    %51 = comb.extract %rspfifo.rdata_o from 0 : (i51) -> i1
    %u_rspfifo_intg_prim_buf.out_o = hw.instance "u_rspfifo_intg_prim_buf" @prim_buf_26(in_i: %58: i2) -> (out_o: i2) {sv.namehint = "buf_rspfifo_intg_out"}
    %d_user = hw.struct_extract %6["d_user"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %52 = llhd.sig.struct_extract %tl_h_o["d_user"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %53 = hw.bitcast %d_user : (!hw.struct<rsp_intg: i7, data_intg: i7>) -> i14
    %rspfifo_intg.wready_o, %rspfifo_intg.rvalid_o, %rspfifo_intg.rdata_o, %rspfifo_intg.full_o, %rspfifo_intg.depth_o, %rspfifo_intg.err_o = hw.instance "rspfifo_intg" @prim_fifo_sync_33(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clr_i: %false: i1, wvalid_i: %59: i1, wdata_i: %53: i14, rready_i: %60: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i14, full_o: i1, depth_o: i1, err_o: i1)
    %54 = hw.bitcast %rspfifo_intg.rdata_o : (i14) -> !hw.struct<rsp_intg: i7, data_intg: i7>
    llhd.drv %52, %54 after %0 : !hw.struct<rsp_intg: i7, data_intg: i7>
    %55 = comb.concat %a_valid, %a_ready {sv.namehint = "buf_reqfifo_intg_in"} : i1, i1
    %56 = comb.extract %u_reqfifo_intg_prim_buf.out_o from 1 {sv.namehint = "reqfifo_intg_a_valid_buf"} : (i2) -> i1
    %57 = comb.extract %u_reqfifo_intg_prim_buf.out_o from 0 {sv.namehint = "reqfifo_intg_a_ready_buf"} : (i2) -> i1
    %58 = comb.concat %d_valid, %d_ready {sv.namehint = "buf_rspfifo_intg_in"} : i1, i1
    %59 = comb.extract %u_rspfifo_intg_prim_buf.out_o from 1 {sv.namehint = "rspfifo_intg_d_valid_buf"} : (i2) -> i1
    %60 = comb.extract %u_rspfifo_intg_prim_buf.out_o from 0 {sv.namehint = "rspfifo_intg_d_ready_buf"} : (i2) -> i1
    %61 = llhd.prb %tl_h_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %62 = llhd.prb %tl_d_o : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    llhd.drv %tl_d_i_0, %tl_d_i after %0 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    hw.output %61, %62, %26, %51 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, i1, i1
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
  func.func private @"tlul_pkg::get_cmd_intg"(%arg0: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> i7 {
    %c0_i14 = hw.constant 0 : i14
    %0 = call @"tlul_pkg::extract_h2d_cmd_intg"(%arg0) : (!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> !hw.struct<instr_type: i4, addr: i32, opcode: i3, mask: i4>
    %1 = hw.bitcast %0 : (!hw.struct<instr_type: i4, addr: i32, opcode: i3, mask: i4>) -> i43
    %2 = comb.concat %c0_i14, %1 : i14, i43
    %3 = call @"prim_secded_pkg::prim_secded_inv_64_57_enc"(%2) : (i57) -> i64
    %4 = comb.extract %3 from 57 : (i64) -> i7
    return %4 : i7
  }
  func.func private @"tlul_pkg::get_bad_cmd_intg"(%arg0: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> i7 {
    %c-1_i7 = hw.constant -1 : i7
    %0 = call @"tlul_pkg::get_cmd_intg"(%arg0) : (!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> i7
    %1 = comb.xor %0, %c-1_i7 : i7
    return %1 : i7
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
  hw.module private @tlul_rsp_intg_gen_38(in %tl_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i7 = hw.constant 0 : i7
    %1 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %tl_i_0 = llhd.sig name "tl_i" %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %tl_o = llhd.sig %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %rsp_intg = llhd.sig %c0_i7 : i7
    %data_intg = llhd.sig %c0_i7 : i7
    llhd.drv %rsp_intg, %c0_i7 after %0 : i7
    %2 = llhd.prb %tl_i_0 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %d_user = hw.struct_extract %2["d_user"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %data_intg_1 = hw.struct_extract %d_user["data_intg"] : !hw.struct<rsp_intg: i7, data_intg: i7>
    llhd.drv %data_intg, %data_intg_1 after %0 : i7
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
  hw.module private @tlul_socket_1n(in %clk_i : i1, in %rst_ni : i1, in %tl_h_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_h_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_d_o : !hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>, in %tl_d_i : !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, in %dev_select_i : i2) {
    %c-1_i9 = hw.constant -1 : i9
    %c0_i30 = hw.constant 0 : i30
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [0 : i5, 0 : i4, 0 : i7, 0 : i7] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %3 = hw.aggregate_constant [[false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false], [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false], [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false], [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false]] : !hw.array<4xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %4 = hw.aggregate_constant [[false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false], [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false], [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false], [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false]] : !hw.array<4xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %5 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %6 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %7 = hw.aggregate_constant [[false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false], [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false], [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false]] : !hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %c-1_i2 = hw.constant -1 : i2
    %c1_i32 = hw.constant 1 : i32
    %c3_i32 = hw.constant 3 : i32
    %c0_i32 = hw.constant 0 : i32
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %c-1_i32 = hw.constant -1 : i32
    %c-43_i7 = hw.constant -43 : i7
    %c1_i9 = hw.constant 1 : i9
    %c0_i2 = hw.constant 0 : i2
    %c0_i9 = hw.constant 0 : i9
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %8 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %9 = llhd.prb %rst_ni_1 : i1
    %tl_d_o = llhd.sig %7 : !hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %dev_select_t = llhd.sig %c0_i2 : i2
    %tl_t_o = llhd.sig %6 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %tl_t_i = llhd.sig %5 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %num_req_outstanding = llhd.sig %c0_i9 : i9
    %dev_select_outstanding = llhd.sig %c0_i2 : i2
    %hold_all_requests = llhd.sig %false : i1
    %accept_t_req = llhd.sig %false : i1
    %accept_t_rsp = llhd.sig %false : i1
    %tl_u_o = llhd.sig %4 : !hw.array<4xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %tl_u_i = llhd.sig %3 : !hw.array<4xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %blanked_auser = llhd.sig %2 : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %tl_t_p = llhd.sig %5 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %hfifo_reqready = llhd.sig %false : i1
    %10 = llhd.prb %tl_t_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %fifo_h.tl_h_o, %fifo_h.tl_d_o, %fifo_h.spare_req_o, %fifo_h.spare_rsp_o = hw.instance "fifo_h" @tlul_fifo_sync(clk_i: %8: i1, rst_ni: %9: i1, tl_h_i: %tl_h_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, tl_d_i: %10: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, spare_req_i: %dev_select_i: i2, spare_rsp_i: %false: i1) -> (tl_h_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, tl_d_o: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, spare_req_o: i2, spare_rsp_o: i1)
    llhd.drv %tl_t_o, %fifo_h.tl_d_o after %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    llhd.drv %dev_select_t, %fifo_h.spare_req_o after %1 : i2
    %11 = llhd.prb %tl_u_o : !hw.array<4xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %12 = hw.array_get %11[%c-1_i2] : !hw.array<4xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>, i2
    %13 = llhd.sig.array_get %tl_u_i[%c-1_i2] : <!hw.array<4xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>>
    %14 = llhd.sig.array_get %tl_d_o[%c-2_i2] : <!hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>>
    %15 = hw.array_get %tl_d_i[%c-2_i2] : !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, i2
    %gen_dfifo_0.fifo_d.tl_h_o, %gen_dfifo_0.fifo_d.tl_d_o, %gen_dfifo_0.fifo_d.spare_req_o, %gen_dfifo_0.fifo_d.spare_rsp_o = hw.instance "gen_dfifo_0.fifo_d" @tlul_fifo_sync_16(clk_i: %8: i1, rst_ni: %9: i1, tl_h_i: %12: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, tl_d_i: %15: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, spare_req_i: %false: i1, spare_rsp_i: %false: i1) -> (tl_h_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, tl_d_o: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, spare_req_o: i1, spare_rsp_o: i1)
    llhd.drv %13, %gen_dfifo_0.fifo_d.tl_h_o after %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %14, %gen_dfifo_0.fifo_d.tl_d_o after %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %16 = hw.array_get %11[%c-2_i2] : !hw.array<4xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>, i2
    %17 = llhd.sig.array_get %tl_u_i[%c-2_i2] : <!hw.array<4xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>>
    %18 = llhd.sig.array_get %tl_d_o[%c1_i2] : <!hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>>
    %19 = hw.array_get %tl_d_i[%c1_i2] : !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, i2
    %gen_dfifo_1.fifo_d.tl_h_o, %gen_dfifo_1.fifo_d.tl_d_o, %gen_dfifo_1.fifo_d.spare_req_o, %gen_dfifo_1.fifo_d.spare_rsp_o = hw.instance "gen_dfifo_1.fifo_d" @tlul_fifo_sync_16(clk_i: %8: i1, rst_ni: %9: i1, tl_h_i: %16: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, tl_d_i: %19: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, spare_req_i: %false: i1, spare_rsp_i: %false: i1) -> (tl_h_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, tl_d_o: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, spare_req_o: i1, spare_rsp_o: i1)
    llhd.drv %17, %gen_dfifo_1.fifo_d.tl_h_o after %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %18, %gen_dfifo_1.fifo_d.tl_d_o after %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %20 = hw.array_get %11[%c1_i2] : !hw.array<4xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>, i2
    %21 = llhd.sig.array_get %tl_u_i[%c1_i2] : <!hw.array<4xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>>
    %22 = llhd.sig.array_get %tl_d_o[%c0_i2] : <!hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>>
    %23 = hw.array_get %tl_d_i[%c0_i2] : !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, i2
    %gen_dfifo_2.fifo_d.tl_h_o, %gen_dfifo_2.fifo_d.tl_d_o, %gen_dfifo_2.fifo_d.spare_req_o, %gen_dfifo_2.fifo_d.spare_rsp_o = hw.instance "gen_dfifo_2.fifo_d" @tlul_fifo_sync_16(clk_i: %8: i1, rst_ni: %9: i1, tl_h_i: %20: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, tl_d_i: %23: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, spare_req_i: %false: i1, spare_rsp_i: %false: i1) -> (tl_h_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, tl_d_o: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, spare_req_o: i1, spare_rsp_o: i1)
    llhd.drv %21, %gen_dfifo_2.fifo_d.tl_h_o after %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %22, %gen_dfifo_2.fifo_d.tl_d_o after %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %24 = hw.array_get %11[%c0_i2] : !hw.array<4xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>, i2
    %25 = llhd.sig.array_get %tl_u_i[%c0_i2] : <!hw.array<4xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>>
    %gen_err_resp.err_resp.tl_h_o = hw.instance "gen_err_resp.err_resp" @tlul_err_resp(clk_i: %8: i1, rst_ni: %9: i1, tl_h_i: %24: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> (tl_h_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
    llhd.drv %25, %gen_err_resp.err_resp.tl_h_o after %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %26 = llhd.prb %tl_t_o : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_valid = hw.struct_extract %26["a_valid"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %a_ready = hw.struct_extract %10["a_ready"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %27 = comb.and %a_valid, %a_ready : i1
    llhd.drv %accept_t_req, %27 after %1 : i1
    %d_valid = hw.struct_extract %10["d_valid"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %d_ready = hw.struct_extract %26["d_ready"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %28 = comb.and %d_valid, %d_ready : i1
    llhd.drv %accept_t_rsp, %28 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb8, ^bb9, ^bb10
      %116 = llhd.prb %clk_i_0 : i1
      %117 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%8, %9 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %118 = llhd.prb %clk_i_0 : i1
      %119 = comb.xor bin %116, %true : i1
      %120 = comb.and bin %119, %118 : i1
      %121 = llhd.prb %rst_ni_1 : i1
      %122 = comb.xor bin %121, %true : i1
      %123 = comb.and bin %117, %122 : i1
      %124 = comb.or bin %120, %123 : i1
      cf.cond_br %124, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %125 = llhd.prb %rst_ni_1 : i1
      %126 = comb.xor %125, %true : i1
      cf.cond_br %126, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %num_req_outstanding, %c0_i9 after %0 : i9
      llhd.drv %dev_select_outstanding, %c0_i2 after %0 : i2
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %127 = llhd.prb %accept_t_req : i1
      cf.cond_br %127, ^bb6, ^bb9
    ^bb6:  // pred: ^bb5
      %128 = llhd.prb %accept_t_rsp : i1
      %129 = comb.xor %128, %true : i1
      cf.cond_br %129, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %130 = llhd.prb %num_req_outstanding : i9
      %131 = comb.add %130, %c1_i9 : i9
      llhd.drv %num_req_outstanding, %131 after %0 : i9
      cf.br ^bb8
    ^bb8:  // 2 preds: ^bb6, ^bb7
      %132 = llhd.prb %dev_select_t : i2
      llhd.drv %dev_select_outstanding, %132 after %0 : i2
      cf.br ^bb1
    ^bb9:  // pred: ^bb5
      %133 = llhd.prb %accept_t_rsp : i1
      cf.cond_br %133, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      %134 = llhd.prb %num_req_outstanding : i9
      %135 = comb.add %134, %c-1_i9 : i9
      llhd.drv %num_req_outstanding, %135 after %0 : i9
      cf.br ^bb1
    }
    %29 = llhd.prb %num_req_outstanding : i9
    %30 = comb.icmp ne %29, %c0_i9 : i9
    %31 = llhd.prb %dev_select_t : i2
    %32 = llhd.prb %dev_select_outstanding : i2
    %33 = comb.icmp ne %31, %32 : i2
    %34 = comb.and %30, %33 : i1
    llhd.drv %hold_all_requests, %34 after %1 : i1
    %a_user = hw.struct_extract %26["a_user"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %rsvd = hw.struct_extract %a_user["rsvd"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %instr_type = hw.struct_extract %a_user["instr_type"] : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %35 = func.call @"tlul_pkg::get_bad_cmd_intg"(%26) : (!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> i7
    %36 = hw.struct_create (%rsvd, %instr_type, %35, %c-43_i7) : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    llhd.drv %blanked_auser, %36 after %1 : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %37 = comb.icmp eq %31, %c0_i2 : i2
    %38 = llhd.prb %hold_all_requests : i1
    %39 = comb.xor %38, %true : i1
    %40 = comb.and %37, %39 {sv.namehint = "gen_u_o_0.dev_select"} : i1
    %41 = llhd.sig.array_get %tl_u_o[%c-1_i2] : <!hw.array<4xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>>
    %42 = llhd.sig.struct_extract %41["a_valid"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %43 = comb.and %a_valid, %40 : i1
    llhd.drv %42, %43 after %1 : i1
    %44 = llhd.sig.struct_extract %41["a_opcode"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %a_opcode = hw.struct_extract %26["a_opcode"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    llhd.drv %44, %a_opcode after %1 : i3
    %45 = llhd.sig.struct_extract %41["a_param"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %a_param = hw.struct_extract %26["a_param"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    llhd.drv %45, %a_param after %1 : i3
    %46 = llhd.sig.struct_extract %41["a_size"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %a_size = hw.struct_extract %26["a_size"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    llhd.drv %46, %a_size after %1 : i2
    %47 = llhd.sig.struct_extract %41["a_source"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %a_source = hw.struct_extract %26["a_source"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    llhd.drv %47, %a_source after %1 : i8
    %48 = llhd.sig.struct_extract %41["a_address"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %a_address = hw.struct_extract %26["a_address"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    llhd.drv %48, %a_address after %1 : i32
    %49 = llhd.sig.struct_extract %41["a_mask"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %a_mask = hw.struct_extract %26["a_mask"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    llhd.drv %49, %a_mask after %1 : i4
    %50 = llhd.sig.struct_extract %41["a_data"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %a_data = hw.struct_extract %26["a_data"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %51 = comb.mux %40, %a_data, %c-1_i32 : i32
    llhd.drv %50, %51 after %1 : i32
    %52 = llhd.sig.struct_extract %41["a_user"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %53 = llhd.prb %blanked_auser : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %54 = comb.mux %40, %a_user, %53 : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    llhd.drv %52, %54 after %1 : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %55 = llhd.sig.struct_extract %41["d_ready"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %55, %d_ready after %1 : i1
    %56 = comb.icmp eq %31, %c1_i2 : i2
    %57 = comb.and %56, %39 {sv.namehint = "gen_u_o_1.dev_select"} : i1
    %58 = llhd.sig.array_get %tl_u_o[%c-2_i2] : <!hw.array<4xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>>
    %59 = llhd.sig.struct_extract %58["a_valid"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %60 = comb.and %a_valid, %57 : i1
    llhd.drv %59, %60 after %1 : i1
    %61 = llhd.sig.struct_extract %58["a_opcode"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %61, %a_opcode after %1 : i3
    %62 = llhd.sig.struct_extract %58["a_param"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %62, %a_param after %1 : i3
    %63 = llhd.sig.struct_extract %58["a_size"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %63, %a_size after %1 : i2
    %64 = llhd.sig.struct_extract %58["a_source"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %64, %a_source after %1 : i8
    %65 = llhd.sig.struct_extract %58["a_address"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %65, %a_address after %1 : i32
    %66 = llhd.sig.struct_extract %58["a_mask"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %66, %a_mask after %1 : i4
    %67 = llhd.sig.struct_extract %58["a_data"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %68 = comb.mux %57, %a_data, %c-1_i32 : i32
    llhd.drv %67, %68 after %1 : i32
    %69 = llhd.sig.struct_extract %58["a_user"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %70 = comb.mux %57, %a_user, %53 : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    llhd.drv %69, %70 after %1 : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %71 = llhd.sig.struct_extract %58["d_ready"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %71, %d_ready after %1 : i1
    %72 = comb.icmp eq %31, %c-2_i2 : i2
    %73 = comb.and %72, %39 {sv.namehint = "gen_u_o_2.dev_select"} : i1
    %74 = llhd.sig.array_get %tl_u_o[%c1_i2] : <!hw.array<4xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>>
    %75 = llhd.sig.struct_extract %74["a_valid"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %76 = comb.and %a_valid, %73 : i1
    llhd.drv %75, %76 after %1 : i1
    %77 = llhd.sig.struct_extract %74["a_opcode"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %77, %a_opcode after %1 : i3
    %78 = llhd.sig.struct_extract %74["a_param"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %78, %a_param after %1 : i3
    %79 = llhd.sig.struct_extract %74["a_size"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %79, %a_size after %1 : i2
    %80 = llhd.sig.struct_extract %74["a_source"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %80, %a_source after %1 : i8
    %81 = llhd.sig.struct_extract %74["a_address"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %81, %a_address after %1 : i32
    %82 = llhd.sig.struct_extract %74["a_mask"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %82, %a_mask after %1 : i4
    %83 = llhd.sig.struct_extract %74["a_data"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %84 = comb.mux %73, %a_data, %c-1_i32 : i32
    llhd.drv %83, %84 after %1 : i32
    %85 = llhd.sig.struct_extract %74["a_user"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %86 = comb.mux %73, %a_user, %53 : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    llhd.drv %85, %86 after %1 : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    %87 = llhd.sig.struct_extract %74["d_ready"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %87, %d_ready after %1 : i1
    %88 = llhd.prb %tl_u_i : !hw.array<4xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %89 = llhd.prb %hfifo_reqready : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb8
      %116 = llhd.prb %tl_u_i : !hw.array<4xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
      %117 = hw.array_get %116[%c0_i2] : !hw.array<4xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, i2
      %a_ready_3 = hw.struct_extract %117["a_ready"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      llhd.drv %hfifo_reqready, %a_ready_3 after %1 : i1
      cf.br ^bb2(%c0_i32 : i32)
    ^bb2(%118: i32):  // 2 preds: ^bb1, ^bb5
      %119 = comb.icmp ult %118, %c3_i32 : i32
      cf.cond_br %119, ^bb3, ^bb6
    ^bb3:  // pred: ^bb2
      %120 = llhd.prb %dev_select_t : i2
      %121 = comb.extract %118 from 0 : (i32) -> i2
      %122 = comb.icmp eq %120, %121 : i2
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %123 = llhd.prb %tl_u_i : !hw.array<4xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
      %124 = comb.sub %c3_i32, %118 : i32
      %125 = comb.extract %124 from 2 : (i32) -> i30
      %126 = comb.icmp eq %125, %c0_i30 : i30
      %127 = comb.extract %124 from 0 : (i32) -> i2
      %128 = comb.mux %126, %127, %c-1_i2 : i2
      %129 = hw.array_get %123[%128] : !hw.array<4xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, i2
      %a_ready_4 = hw.struct_extract %129["a_ready"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      llhd.drv %hfifo_reqready, %a_ready_4 after %1 : i1
      cf.br ^bb5
    ^bb5:  // 2 preds: ^bb3, ^bb4
      %130 = comb.add %118, %c1_i32 : i32
      cf.br ^bb2(%130 : i32)
    ^bb6:  // pred: ^bb2
      %131 = llhd.prb %hold_all_requests : i1
      cf.cond_br %131, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      llhd.drv %hfifo_reqready, %false after %1 : i1
      cf.br ^bb8
    ^bb8:  // 2 preds: ^bb6, ^bb7
      llhd.wait (%88, %89, %31, %38 : !hw.array<4xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, i1, i2, i1), ^bb1
    }
    %90 = llhd.sig.struct_extract %tl_t_i["a_ready"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %91 = comb.and %a_valid, %89 : i1
    llhd.drv %90, %91 after %1 : i1
    %92 = llhd.prb %tl_t_p : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      %116 = llhd.prb %tl_u_i : !hw.array<4xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
      %117 = hw.array_get %116[%c0_i2] : !hw.array<4xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, i2
      llhd.drv %tl_t_p, %117 after %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      cf.br ^bb2(%c0_i32 : i32)
    ^bb2(%118: i32):  // 2 preds: ^bb1, ^bb5
      %119 = comb.icmp ult %118, %c3_i32 : i32
      cf.cond_br %119, ^bb3, ^bb6
    ^bb3:  // pred: ^bb2
      %120 = llhd.prb %dev_select_outstanding : i2
      %121 = comb.extract %118 from 0 : (i32) -> i2
      %122 = comb.icmp eq %120, %121 : i2
      cf.cond_br %122, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %123 = llhd.prb %tl_u_i : !hw.array<4xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
      %124 = comb.sub %c3_i32, %118 : i32
      %125 = comb.extract %124 from 2 : (i32) -> i30
      %126 = comb.icmp eq %125, %c0_i30 : i30
      %127 = comb.extract %124 from 0 : (i32) -> i2
      %128 = comb.mux %126, %127, %c-1_i2 : i2
      %129 = hw.array_get %123[%128] : !hw.array<4xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, i2
      llhd.drv %tl_t_p, %129 after %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
      cf.br ^bb5
    ^bb5:  // 2 preds: ^bb3, ^bb4
      %130 = comb.add %118, %c1_i32 : i32
      cf.br ^bb2(%130 : i32)
    ^bb6:  // pred: ^bb2
      llhd.wait (%88, %92, %32 : !hw.array<4xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, i2), ^bb1
    }
    %93 = llhd.sig.struct_extract %tl_t_i["d_valid"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %d_valid_2 = hw.struct_extract %92["d_valid"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %93, %d_valid_2 after %1 : i1
    %94 = llhd.sig.struct_extract %tl_t_i["d_opcode"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %d_opcode = hw.struct_extract %92["d_opcode"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %94, %d_opcode after %1 : i3
    %95 = llhd.sig.struct_extract %tl_t_i["d_param"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %d_param = hw.struct_extract %92["d_param"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %95, %d_param after %1 : i3
    %96 = llhd.sig.struct_extract %tl_t_i["d_size"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %d_size = hw.struct_extract %92["d_size"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %96, %d_size after %1 : i2
    %97 = llhd.sig.struct_extract %tl_t_i["d_source"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %d_source = hw.struct_extract %92["d_source"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %97, %d_source after %1 : i8
    %98 = llhd.sig.struct_extract %tl_t_i["d_sink"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %d_sink = hw.struct_extract %92["d_sink"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %98, %d_sink after %1 : i1
    %99 = llhd.sig.struct_extract %tl_t_i["d_data"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %d_data = hw.struct_extract %92["d_data"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %99, %d_data after %1 : i32
    %100 = llhd.sig.struct_extract %tl_t_i["d_user"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %d_user = hw.struct_extract %92["d_user"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %100, %d_user after %1 : !hw.struct<rsp_intg: i7, data_intg: i7>
    %101 = llhd.sig.struct_extract %tl_t_i["d_error"] : <!hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %d_error = hw.struct_extract %92["d_error"] : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %101, %d_error after %1 : i1
    %102 = llhd.sig.array_get %tl_u_o[%c0_i2] : <!hw.array<4xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>>
    %103 = llhd.sig.struct_extract %102["d_ready"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %103, %d_ready after %1 : i1
    %104 = llhd.sig.struct_extract %102["a_valid"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %105 = comb.icmp eq %31, %c-1_i2 : i2
    %106 = comb.and %a_valid, %105, %39 : i1
    llhd.drv %104, %106 after %1 : i1
    %107 = llhd.sig.struct_extract %102["a_opcode"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %107, %a_opcode after %1 : i3
    %108 = llhd.sig.struct_extract %102["a_param"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %108, %a_param after %1 : i3
    %109 = llhd.sig.struct_extract %102["a_size"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %109, %a_size after %1 : i2
    %110 = llhd.sig.struct_extract %102["a_source"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %110, %a_source after %1 : i8
    %111 = llhd.sig.struct_extract %102["a_address"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %111, %a_address after %1 : i32
    %112 = llhd.sig.struct_extract %102["a_mask"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %112, %a_mask after %1 : i4
    %113 = llhd.sig.struct_extract %102["a_data"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %113, %a_data after %1 : i32
    %114 = llhd.sig.struct_extract %102["a_user"] : <!hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    llhd.drv %114, %a_user after %1 : !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    %115 = llhd.prb %tl_d_o : !hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    hw.output %fifo_h.tl_h_o, %115 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
  }
  hw.module private @tlul_sram_byte(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_sram_o : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, in %tl_sram_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %error_i : i1, out error_o : i1, out alert_o : i1, out compound_txn_in_progress_o : i1, in %readback_en_i : i4, in %wr_collision_i : i1, in %write_pending_i : i1) {
    %false = hw.constant false
    hw.output %tl_sram_i, %tl_i, %error_i, %false, %false : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, i1, i1, i1
  }
  hw.module private @spi_host_reg_top(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_win_o : !hw.array<2xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>, in %tl_win_i : !hw.array<2xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, out reg2hw : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>, in %hw2reg : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<d: i1, de: i1>, error: !hw.struct<d: i1, de: i1>>, status: !hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>, error_status: !hw.struct<accessinval: !hw.struct<d: i1, de: i1>, csidinval: !hw.struct<d: i1, de: i1>, cmdinval: !hw.struct<d: i1, de: i1>, underflow: !hw.struct<d: i1, de: i1>, overflow: !hw.struct<d: i1, de: i1>, cmdbusy: !hw.struct<d: i1, de: i1>>>, in %racl_policies_i : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, out racl_error_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, out intg_err_o : i1) {
    %c44_i32 = hw.constant 44 : i32
    %c39_i32 = hw.constant 39 : i32
    %c40_i32 = hw.constant 40 : i32
    %c35_i32 = hw.constant 35 : i32
    %c4_i5 = hw.constant 4 : i5
    %c2_i5 = hw.constant 2 : i5
    %c5_i5 = hw.constant 5 : i5
    %c3_i5 = hw.constant 3 : i5
    %c-4_i5 = hw.constant -4 : i5
    %c-5_i5 = hw.constant -5 : i5
    %c-6_i5 = hw.constant -6 : i5
    %c-7_i5 = hw.constant -7 : i5
    %c-8_i5 = hw.constant -8 : i5
    %c-9_i5 = hw.constant -9 : i5
    %c-10_i5 = hw.constant -10 : i5
    %c-12_i5 = hw.constant -12 : i5
    %c-16_i5 = hw.constant -16 : i5
    %c-1_i5 = hw.constant -1 : i5
    %c-2_i5 = hw.constant -2 : i5
    %c-3_i5 = hw.constant -3 : i5
    %c8_i5 = hw.constant 8 : i5
    %c1_i5 = hw.constant 1 : i5
    %c0_i5 = hw.constant 0 : i5
    %c-5_i4 = hw.constant -5 : i4
    %c-6_i4 = hw.constant -6 : i4
    %c-8_i4 = hw.constant -8 : i4
    %c7_i4 = hw.constant 7 : i4
    %c6_i4 = hw.constant 6 : i4
    %c5_i4 = hw.constant 5 : i4
    %c4_i4 = hw.constant 4 : i4
    %c3_i4 = hw.constant 3 : i4
    %c2_i4 = hw.constant 2 : i4
    %c0_i26 = hw.constant 0 : i26
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i2 = hw.constant -1 : i2
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [[false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false], [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false], [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false]] : !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %3 = hw.aggregate_constant [false, false, false, false, false, 0 : i32] : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %4 = hw.aggregate_constant [[0 : i2, 0 : i2]] : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    %5 = hw.aggregate_constant [[[false], [false]], [[false], [false]], [[false, false], [false, false]], [false, false], [[false], [false], [false], [0 : i8], [0 : i8]], [[false], [false], [false], [0 : i4], [0 : i4], [0 : i4], [0 : i16]], [0 : i32], [[0 : i20, false], [0 : i2, false], [0 : i2, false], [false, false]], [[false], [false], [false], [false], [false]], [[false], [false], [false], [false], [false], [false]], [[false], [false], [false], [false], [false], [false]]] : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
    %6 = hw.aggregate_constant [[false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false], [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false]] : !hw.array<2xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %7 = hw.aggregate_constant [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, 0 : i32, 0 : i4, 0 : i32, [0 : i5, 0 : i4, 0 : i7, 0 : i7], false] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %c-1_i32 = hw.constant -1 : i32
    %c-1_i4 = hw.constant -1 : i4
    %c1_i4 = hw.constant 1 : i4
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false {sv.namehint = "racl_role"}
    %c-12_i6 = hw.constant -12 : i6
    %c-16_i6 = hw.constant -16 : i6
    %c-20_i6 = hw.constant -20 : i6
    %c-32_i6 = hw.constant -32 : i6
    %c28_i6 = hw.constant 28 : i6
    %c24_i6 = hw.constant 24 : i6
    %c20_i6 = hw.constant 20 : i6
    %c16_i6 = hw.constant 16 : i6
    %c12_i6 = hw.constant 12 : i6
    %c8_i6 = hw.constant 8 : i6
    %c4_i6 = hw.constant 4 : i6
    %c0_i6 = hw.constant 0 : i6
    %c0_i12 = hw.constant 0 : i12
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %true = hw.constant true
    %c0_i20 = hw.constant 0 : i20
    %c0_i2 = hw.constant 0 : i2
    %c0_i16 = hw.constant 0 : i16
    %c0_i4 = hw.constant 0 : i4
    %c0_i8 = hw.constant 0 : i8
    %c-7_i4 = hw.constant -7 : i4
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %8 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %9 = llhd.prb %rst_ni_1 : i1
    %tl_i_2 = llhd.sig name "tl_i" %7 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %tl_win_o = llhd.sig %6 : !hw.array<2xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %reg2hw = llhd.sig %5 : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
    %racl_policies_i_3 = llhd.sig name "racl_policies_i" %4 : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    %racl_error_o = llhd.sig %3 : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %reg_we = llhd.sig %false : i1
    %reg_addr = llhd.sig %c0_i6 : i6
    %reg_be = llhd.sig %c0_i4 : i4
    %wr_err = llhd.sig %false : i1
    %reg_rdata_next = llhd.sig %c0_i32 : i32
    %intg_err = llhd.sig %false : i1
    %reg_we_err = llhd.sig %false : i1
    %reg_we_check = llhd.sig %c0_i12 : i12
    %err_q = llhd.sig %false : i1
    %tl_socket_d2h = llhd.sig %2 : !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %reg_steer = llhd.sig %c0_i2 : i2
    %intr_state_we = llhd.sig %false : i1
    %intr_state_error_qs = llhd.sig %false : i1
    %intr_state_spi_event_qs = llhd.sig %false : i1
    %intr_enable_we = llhd.sig %false : i1
    %intr_enable_error_qs = llhd.sig %false : i1
    %intr_enable_spi_event_qs = llhd.sig %false : i1
    %intr_test_we = llhd.sig %false : i1
    %alert_test_we = llhd.sig %false : i1
    %control_we = llhd.sig %false : i1
    %control_rx_watermark_qs = llhd.sig %c0_i8 : i8
    %control_tx_watermark_qs = llhd.sig %c0_i8 : i8
    %control_output_en_qs = llhd.sig %false : i1
    %control_sw_rst_qs = llhd.sig %false : i1
    %control_spien_qs = llhd.sig %false : i1
    %status_txqd_qs = llhd.sig %c0_i8 : i8
    %status_rxqd_qs = llhd.sig %c0_i8 : i8
    %status_cmdqd_qs = llhd.sig %c0_i4 : i4
    %status_rxwm_qs = llhd.sig %false : i1
    %status_byteorder_qs = llhd.sig %false : i1
    %status_rxstall_qs = llhd.sig %false : i1
    %status_rxempty_qs = llhd.sig %false : i1
    %status_rxfull_qs = llhd.sig %false : i1
    %status_txwm_qs = llhd.sig %false : i1
    %status_txstall_qs = llhd.sig %false : i1
    %status_txempty_qs = llhd.sig %false : i1
    %status_txfull_qs = llhd.sig %false : i1
    %status_active_qs = llhd.sig %false : i1
    %status_ready_qs = llhd.sig %false : i1
    %configopts_we = llhd.sig %false : i1
    %configopts_clkdiv_qs = llhd.sig %c0_i16 : i16
    %configopts_csnidle_qs = llhd.sig %c0_i4 : i4
    %configopts_csntrail_qs = llhd.sig %c0_i4 : i4
    %configopts_csnlead_qs = llhd.sig %c0_i4 : i4
    %configopts_fullcyc_qs = llhd.sig %false : i1
    %configopts_cpha_qs = llhd.sig %false : i1
    %configopts_cpol_qs = llhd.sig %false : i1
    %csid_we = llhd.sig %false : i1
    %csid_qs = llhd.sig %c0_i32 : i32
    %command_we = llhd.sig %false : i1
    %error_enable_we = llhd.sig %false : i1
    %error_enable_cmdbusy_qs = llhd.sig %false : i1
    %error_enable_overflow_qs = llhd.sig %false : i1
    %error_enable_underflow_qs = llhd.sig %false : i1
    %error_enable_cmdinval_qs = llhd.sig %false : i1
    %error_enable_csidinval_qs = llhd.sig %false : i1
    %error_status_we = llhd.sig %false : i1
    %error_status_cmdbusy_qs = llhd.sig %false : i1
    %error_status_overflow_qs = llhd.sig %false : i1
    %error_status_underflow_qs = llhd.sig %false : i1
    %error_status_cmdinval_qs = llhd.sig %false : i1
    %error_status_csidinval_qs = llhd.sig %false : i1
    %error_status_accessinval_qs = llhd.sig %false : i1
    %event_enable_we = llhd.sig %false : i1
    %event_enable_rxfull_qs = llhd.sig %false : i1
    %event_enable_txempty_qs = llhd.sig %false : i1
    %event_enable_rxwm_qs = llhd.sig %false : i1
    %event_enable_txwm_qs = llhd.sig %false : i1
    %event_enable_ready_qs = llhd.sig %false : i1
    %event_enable_idle_qs = llhd.sig %false : i1
    %intr_test_flds_we = llhd.sig %c0_i2 : i2
    %alert_test_flds_we = llhd.sig %false : i1
    %command_flds_we = llhd.sig %c0_i4 : i4
    %addr_hit = llhd.sig %c0_i12 : i12
    %racl_role_vec = llhd.sig %c0_i2 : i2
    %racl_addr_hit_read = llhd.sig %c0_i12 : i12
    %racl_addr_hit_write = llhd.sig %c0_i12 : i12
    %10 = llhd.prb %tl_i_2 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %u_chk.err_o = hw.instance "u_chk" @tlul_cmd_intg_chk(tl_i: %10: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> (err_o: i1)
    llhd.drv %intg_err, %u_chk.err_o after %1 : i1
    %11 = llhd.prb %reg_we_check : i12
    %12 = llhd.prb %reg_we : i1
    %13 = comb.xor %164, %true : i1
    %14 = comb.and %12, %13 : i1
    %u_prim_reg_we_check.err_o = hw.instance "u_prim_reg_we_check" @prim_reg_we_check(clk_i: %8: i1, rst_ni: %9: i1, oh_i: %11: i12, en_i: %14: i1) -> (err_o: i1)
    llhd.drv %reg_we_err, %u_prim_reg_we_check.err_o after %1 : i1
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen(tl_i: %u_socket.tl_h_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
    %15 = llhd.prb %tl_socket_d2h : !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %16 = llhd.prb %reg_steer : i2
    %u_socket.tl_h_o, %u_socket.tl_d_o = hw.instance "u_socket" @tlul_socket_1n(clk_i: %8: i1, rst_ni: %9: i1, tl_h_i: %10: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, tl_d_i: %15: !hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, dev_select_i: %16: i2) -> (tl_h_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, tl_d_o: !hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>) {sv.namehint = "tl_o_pre"}
    %17 = llhd.prb %racl_error_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %u_reg_if.tl_o, %u_reg_if.intg_error_o, %u_reg_if.re_o, %u_reg_if.we_o, %u_reg_if.addr_o, %u_reg_if.wdata_o, %u_reg_if.be_o = hw.instance "u_reg_if" @tlul_adapter_reg(clk_i: %8: i1, rst_ni: %9: i1, tl_i: %130: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, en_ifetch_i: %c-7_i4: i4, busy_i: %false: i1, rdata_i: %140: i32, error_i: %142: i1) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, intg_error_o: i1, re_o: i1, we_o: i1, addr_o: i6, wdata_o: i32, be_o: i4) {sv.namehint = "reg_re"}
    llhd.drv %reg_we, %u_reg_if.we_o after %1 : i1
    llhd.drv %reg_addr, %u_reg_if.addr_o after %1 : i6
    llhd.drv %reg_be, %u_reg_if.be_o after %1 : i4
    %18 = llhd.prb %intr_state_we : i1
    %intr_state = hw.struct_extract %hw2reg["intr_state"] : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<d: i1, de: i1>, error: !hw.struct<d: i1, de: i1>>, status: !hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>, error_status: !hw.struct<accessinval: !hw.struct<d: i1, de: i1>, csidinval: !hw.struct<d: i1, de: i1>, cmdinval: !hw.struct<d: i1, de: i1>, underflow: !hw.struct<d: i1, de: i1>, overflow: !hw.struct<d: i1, de: i1>, cmdbusy: !hw.struct<d: i1, de: i1>>>
    %error = hw.struct_extract %intr_state["error"] : !hw.struct<spi_event: !hw.struct<d: i1, de: i1>, error: !hw.struct<d: i1, de: i1>>
    %de = hw.struct_extract %error["de"] : !hw.struct<d: i1, de: i1>
    %d = hw.struct_extract %error["d"] : !hw.struct<d: i1, de: i1>
    %19 = llhd.sig.struct_extract %reg2hw["intr_state"] : <!hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>>
    %20 = llhd.sig.struct_extract %19["error"] : <!hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>>
    %21 = llhd.sig.struct_extract %20["q"] : <!hw.struct<q: i1>>
    %u_intr_state_error.qe, %u_intr_state_error.q, %u_intr_state_error.ds, %u_intr_state_error.qs = hw.instance "u_intr_state_error" @prim_subreg(clk_i: %8: i1, rst_ni: %9: i1, we: %18: i1, wd: %182: i1, de: %de: i1, d: %d: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %21, %u_intr_state_error.q after %1 : i1
    llhd.drv %intr_state_error_qs, %u_intr_state_error.qs after %1 : i1
    %spi_event = hw.struct_extract %intr_state["spi_event"] : !hw.struct<spi_event: !hw.struct<d: i1, de: i1>, error: !hw.struct<d: i1, de: i1>>
    %de_4 = hw.struct_extract %spi_event["de"] : !hw.struct<d: i1, de: i1>
    %d_5 = hw.struct_extract %spi_event["d"] : !hw.struct<d: i1, de: i1>
    %22 = llhd.sig.struct_extract %19["spi_event"] : <!hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>>
    %23 = llhd.sig.struct_extract %22["q"] : <!hw.struct<q: i1>>
    %u_intr_state_spi_event.qe, %u_intr_state_spi_event.q, %u_intr_state_spi_event.ds, %u_intr_state_spi_event.qs = hw.instance "u_intr_state_spi_event" @prim_subreg_1(clk_i: %8: i1, rst_ni: %9: i1, we: %false: i1, wd: %false: i1, de: %de_4: i1, d: %d_5: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %23, %u_intr_state_spi_event.q after %1 : i1
    llhd.drv %intr_state_spi_event_qs, %u_intr_state_spi_event.qs after %1 : i1
    %24 = llhd.prb %intr_enable_we : i1
    %25 = llhd.sig.struct_extract %reg2hw["intr_enable"] : <!hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>>
    %26 = llhd.sig.struct_extract %25["error"] : <!hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>>
    %27 = llhd.sig.struct_extract %26["q"] : <!hw.struct<q: i1>>
    %u_intr_enable_error.qe, %u_intr_enable_error.q, %u_intr_enable_error.ds, %u_intr_enable_error.qs = hw.instance "u_intr_enable_error" @prim_subreg_2(clk_i: %8: i1, rst_ni: %9: i1, we: %24: i1, wd: %182: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %27, %u_intr_enable_error.q after %1 : i1
    llhd.drv %intr_enable_error_qs, %u_intr_enable_error.qs after %1 : i1
    %28 = llhd.sig.struct_extract %25["spi_event"] : <!hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>>
    %29 = llhd.sig.struct_extract %28["q"] : <!hw.struct<q: i1>>
    %u_intr_enable_spi_event.qe, %u_intr_enable_spi_event.q, %u_intr_enable_spi_event.ds, %u_intr_enable_spi_event.qs = hw.instance "u_intr_enable_spi_event" @prim_subreg_2(clk_i: %8: i1, rst_ni: %9: i1, we: %24: i1, wd: %185: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %29, %u_intr_enable_spi_event.q after %1 : i1
    llhd.drv %intr_enable_spi_event_qs, %u_intr_enable_spi_event.qs after %1 : i1
    %30 = llhd.prb %intr_test_we : i1
    %31 = llhd.sig.extract %intr_test_flds_we from %false : <i2> -> <i1>
    %32 = llhd.sig.struct_extract %reg2hw["intr_test"] : <!hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>>
    %33 = llhd.sig.struct_extract %32["error"] : <!hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>>
    %34 = llhd.sig.struct_extract %33["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_intr_test_error.qe, %u_intr_test_error.qre, %u_intr_test_error.q, %u_intr_test_error.ds, %u_intr_test_error.qs = hw.instance "u_intr_test_error" @prim_subreg_ext(re: %false: i1, we: %30: i1, wd: %182: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %31, %u_intr_test_error.qe after %1 : i1
    llhd.drv %34, %u_intr_test_error.q after %1 : i1
    %35 = llhd.sig.extract %intr_test_flds_we from %true : <i2> -> <i1>
    %36 = llhd.sig.struct_extract %32["spi_event"] : <!hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>>
    %37 = llhd.sig.struct_extract %36["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_intr_test_spi_event.qe, %u_intr_test_spi_event.qre, %u_intr_test_spi_event.q, %u_intr_test_spi_event.ds, %u_intr_test_spi_event.qs = hw.instance "u_intr_test_spi_event" @prim_subreg_ext(re: %false: i1, we: %30: i1, wd: %185: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %35, %u_intr_test_spi_event.qe after %1 : i1
    llhd.drv %37, %u_intr_test_spi_event.q after %1 : i1
    %38 = llhd.prb %alert_test_we : i1
    %39 = llhd.sig.struct_extract %reg2hw["alert_test"] : <!hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>>
    %40 = llhd.sig.struct_extract %39["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_alert_test.qe, %u_alert_test.qre, %u_alert_test.q, %u_alert_test.ds, %u_alert_test.qs = hw.instance "u_alert_test" @prim_subreg_ext(re: %false: i1, we: %38: i1, wd: %182: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %alert_test_flds_we, %u_alert_test.qe after %1 : i1
    llhd.drv %40, %u_alert_test.q after %1 : i1
    %41 = llhd.prb %control_we : i1
    %42 = llhd.sig.struct_extract %reg2hw["control"] : <!hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>>
    %43 = llhd.sig.struct_extract %42["rx_watermark"] : <!hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>>
    %44 = llhd.sig.struct_extract %43["q"] : <!hw.struct<q: i8>>
    %u_control_rx_watermark.qe, %u_control_rx_watermark.q, %u_control_rx_watermark.ds, %u_control_rx_watermark.qs = hw.instance "u_control_rx_watermark" @prim_subreg_3(clk_i: %8: i1, rst_ni: %9: i1, we: %41: i1, wd: %192: i8, de: %false: i1, d: %c0_i8: i8) -> (qe: i1, q: i8, ds: i8, qs: i8)
    llhd.drv %44, %u_control_rx_watermark.q after %1 : i8
    llhd.drv %control_rx_watermark_qs, %u_control_rx_watermark.qs after %1 : i8
    %45 = llhd.sig.struct_extract %42["tx_watermark"] : <!hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>>
    %46 = llhd.sig.struct_extract %45["q"] : <!hw.struct<q: i8>>
    %u_control_tx_watermark.qe, %u_control_tx_watermark.q, %u_control_tx_watermark.ds, %u_control_tx_watermark.qs = hw.instance "u_control_tx_watermark" @prim_subreg_4(clk_i: %8: i1, rst_ni: %9: i1, we: %41: i1, wd: %193: i8, de: %false: i1, d: %c0_i8: i8) -> (qe: i1, q: i8, ds: i8, qs: i8)
    llhd.drv %46, %u_control_tx_watermark.q after %1 : i8
    llhd.drv %control_tx_watermark_qs, %u_control_tx_watermark.qs after %1 : i8
    %47 = llhd.sig.struct_extract %42["output_en"] : <!hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>>
    %48 = llhd.sig.struct_extract %47["q"] : <!hw.struct<q: i1>>
    %u_control_output_en.qe, %u_control_output_en.q, %u_control_output_en.ds, %u_control_output_en.qs = hw.instance "u_control_output_en" @prim_subreg_2(clk_i: %8: i1, rst_ni: %9: i1, we: %41: i1, wd: %194: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %48, %u_control_output_en.q after %1 : i1
    llhd.drv %control_output_en_qs, %u_control_output_en.qs after %1 : i1
    %49 = llhd.sig.struct_extract %42["sw_rst"] : <!hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>>
    %50 = llhd.sig.struct_extract %49["q"] : <!hw.struct<q: i1>>
    %u_control_sw_rst.qe, %u_control_sw_rst.q, %u_control_sw_rst.ds, %u_control_sw_rst.qs = hw.instance "u_control_sw_rst" @prim_subreg_2(clk_i: %8: i1, rst_ni: %9: i1, we: %41: i1, wd: %195: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %50, %u_control_sw_rst.q after %1 : i1
    llhd.drv %control_sw_rst_qs, %u_control_sw_rst.qs after %1 : i1
    %51 = llhd.sig.struct_extract %42["spien"] : <!hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>>
    %52 = llhd.sig.struct_extract %51["q"] : <!hw.struct<q: i1>>
    %u_control_spien.qe, %u_control_spien.q, %u_control_spien.ds, %u_control_spien.qs = hw.instance "u_control_spien" @prim_subreg_2(clk_i: %8: i1, rst_ni: %9: i1, we: %41: i1, wd: %196: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %52, %u_control_spien.q after %1 : i1
    llhd.drv %control_spien_qs, %u_control_spien.qs after %1 : i1
    %status = hw.struct_extract %hw2reg["status"] : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<d: i1, de: i1>, error: !hw.struct<d: i1, de: i1>>, status: !hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>, error_status: !hw.struct<accessinval: !hw.struct<d: i1, de: i1>, csidinval: !hw.struct<d: i1, de: i1>, cmdinval: !hw.struct<d: i1, de: i1>, underflow: !hw.struct<d: i1, de: i1>, overflow: !hw.struct<d: i1, de: i1>, cmdbusy: !hw.struct<d: i1, de: i1>>>
    %txqd = hw.struct_extract %status["txqd"] : !hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>
    %de_6 = hw.struct_extract %txqd["de"] : !hw.struct<d: i8, de: i1>
    %d_7 = hw.struct_extract %txqd["d"] : !hw.struct<d: i8, de: i1>
    %u_status_txqd.qe, %u_status_txqd.q, %u_status_txqd.ds, %u_status_txqd.qs = hw.instance "u_status_txqd" @prim_subreg_5(clk_i: %8: i1, rst_ni: %9: i1, we: %false: i1, wd: %c0_i8: i8, de: %de_6: i1, d: %d_7: i8) -> (qe: i1, q: i8, ds: i8, qs: i8)
    llhd.drv %status_txqd_qs, %u_status_txqd.qs after %1 : i8
    %rxqd = hw.struct_extract %status["rxqd"] : !hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>
    %de_8 = hw.struct_extract %rxqd["de"] : !hw.struct<d: i8, de: i1>
    %d_9 = hw.struct_extract %rxqd["d"] : !hw.struct<d: i8, de: i1>
    %u_status_rxqd.qe, %u_status_rxqd.q, %u_status_rxqd.ds, %u_status_rxqd.qs = hw.instance "u_status_rxqd" @prim_subreg_5(clk_i: %8: i1, rst_ni: %9: i1, we: %false: i1, wd: %c0_i8: i8, de: %de_8: i1, d: %d_9: i8) -> (qe: i1, q: i8, ds: i8, qs: i8)
    llhd.drv %status_rxqd_qs, %u_status_rxqd.qs after %1 : i8
    %cmdqd = hw.struct_extract %status["cmdqd"] : !hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>
    %de_10 = hw.struct_extract %cmdqd["de"] : !hw.struct<d: i4, de: i1>
    %d_11 = hw.struct_extract %cmdqd["d"] : !hw.struct<d: i4, de: i1>
    %u_status_cmdqd.qe, %u_status_cmdqd.q, %u_status_cmdqd.ds, %u_status_cmdqd.qs = hw.instance "u_status_cmdqd" @prim_subreg_6(clk_i: %8: i1, rst_ni: %9: i1, we: %false: i1, wd: %c0_i4: i4, de: %de_10: i1, d: %d_11: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %status_cmdqd_qs, %u_status_cmdqd.qs after %1 : i4
    %rxwm = hw.struct_extract %status["rxwm"] : !hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>
    %de_12 = hw.struct_extract %rxwm["de"] : !hw.struct<d: i1, de: i1>
    %d_13 = hw.struct_extract %rxwm["d"] : !hw.struct<d: i1, de: i1>
    %u_status_rxwm.qe, %u_status_rxwm.q, %u_status_rxwm.ds, %u_status_rxwm.qs = hw.instance "u_status_rxwm" @prim_subreg_1(clk_i: %8: i1, rst_ni: %9: i1, we: %false: i1, wd: %false: i1, de: %de_12: i1, d: %d_13: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_rxwm_qs, %u_status_rxwm.qs after %1 : i1
    %byteorder = hw.struct_extract %status["byteorder"] : !hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>
    %de_14 = hw.struct_extract %byteorder["de"] : !hw.struct<d: i1, de: i1>
    %d_15 = hw.struct_extract %byteorder["d"] : !hw.struct<d: i1, de: i1>
    %u_status_byteorder.qe, %u_status_byteorder.q, %u_status_byteorder.ds, %u_status_byteorder.qs = hw.instance "u_status_byteorder" @prim_subreg_1(clk_i: %8: i1, rst_ni: %9: i1, we: %false: i1, wd: %false: i1, de: %de_14: i1, d: %d_15: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_byteorder_qs, %u_status_byteorder.qs after %1 : i1
    %rxstall = hw.struct_extract %status["rxstall"] : !hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>
    %de_16 = hw.struct_extract %rxstall["de"] : !hw.struct<d: i1, de: i1>
    %d_17 = hw.struct_extract %rxstall["d"] : !hw.struct<d: i1, de: i1>
    %u_status_rxstall.qe, %u_status_rxstall.q, %u_status_rxstall.ds, %u_status_rxstall.qs = hw.instance "u_status_rxstall" @prim_subreg_1(clk_i: %8: i1, rst_ni: %9: i1, we: %false: i1, wd: %false: i1, de: %de_16: i1, d: %d_17: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_rxstall_qs, %u_status_rxstall.qs after %1 : i1
    %rxempty = hw.struct_extract %status["rxempty"] : !hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>
    %de_18 = hw.struct_extract %rxempty["de"] : !hw.struct<d: i1, de: i1>
    %d_19 = hw.struct_extract %rxempty["d"] : !hw.struct<d: i1, de: i1>
    %u_status_rxempty.qe, %u_status_rxempty.q, %u_status_rxempty.ds, %u_status_rxempty.qs = hw.instance "u_status_rxempty" @prim_subreg_1(clk_i: %8: i1, rst_ni: %9: i1, we: %false: i1, wd: %false: i1, de: %de_18: i1, d: %d_19: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_rxempty_qs, %u_status_rxempty.qs after %1 : i1
    %rxfull = hw.struct_extract %status["rxfull"] : !hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>
    %de_20 = hw.struct_extract %rxfull["de"] : !hw.struct<d: i1, de: i1>
    %d_21 = hw.struct_extract %rxfull["d"] : !hw.struct<d: i1, de: i1>
    %u_status_rxfull.qe, %u_status_rxfull.q, %u_status_rxfull.ds, %u_status_rxfull.qs = hw.instance "u_status_rxfull" @prim_subreg_1(clk_i: %8: i1, rst_ni: %9: i1, we: %false: i1, wd: %false: i1, de: %de_20: i1, d: %d_21: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_rxfull_qs, %u_status_rxfull.qs after %1 : i1
    %txwm = hw.struct_extract %status["txwm"] : !hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>
    %de_22 = hw.struct_extract %txwm["de"] : !hw.struct<d: i1, de: i1>
    %d_23 = hw.struct_extract %txwm["d"] : !hw.struct<d: i1, de: i1>
    %u_status_txwm.qe, %u_status_txwm.q, %u_status_txwm.ds, %u_status_txwm.qs = hw.instance "u_status_txwm" @prim_subreg_1(clk_i: %8: i1, rst_ni: %9: i1, we: %false: i1, wd: %false: i1, de: %de_22: i1, d: %d_23: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_txwm_qs, %u_status_txwm.qs after %1 : i1
    %txstall = hw.struct_extract %status["txstall"] : !hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>
    %de_24 = hw.struct_extract %txstall["de"] : !hw.struct<d: i1, de: i1>
    %d_25 = hw.struct_extract %txstall["d"] : !hw.struct<d: i1, de: i1>
    %u_status_txstall.qe, %u_status_txstall.q, %u_status_txstall.ds, %u_status_txstall.qs = hw.instance "u_status_txstall" @prim_subreg_1(clk_i: %8: i1, rst_ni: %9: i1, we: %false: i1, wd: %false: i1, de: %de_24: i1, d: %d_25: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_txstall_qs, %u_status_txstall.qs after %1 : i1
    %txempty = hw.struct_extract %status["txempty"] : !hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>
    %de_26 = hw.struct_extract %txempty["de"] : !hw.struct<d: i1, de: i1>
    %d_27 = hw.struct_extract %txempty["d"] : !hw.struct<d: i1, de: i1>
    %u_status_txempty.qe, %u_status_txempty.q, %u_status_txempty.ds, %u_status_txempty.qs = hw.instance "u_status_txempty" @prim_subreg_1(clk_i: %8: i1, rst_ni: %9: i1, we: %false: i1, wd: %false: i1, de: %de_26: i1, d: %d_27: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_txempty_qs, %u_status_txempty.qs after %1 : i1
    %txfull = hw.struct_extract %status["txfull"] : !hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>
    %de_28 = hw.struct_extract %txfull["de"] : !hw.struct<d: i1, de: i1>
    %d_29 = hw.struct_extract %txfull["d"] : !hw.struct<d: i1, de: i1>
    %u_status_txfull.qe, %u_status_txfull.q, %u_status_txfull.ds, %u_status_txfull.qs = hw.instance "u_status_txfull" @prim_subreg_1(clk_i: %8: i1, rst_ni: %9: i1, we: %false: i1, wd: %false: i1, de: %de_28: i1, d: %d_29: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_txfull_qs, %u_status_txfull.qs after %1 : i1
    %active = hw.struct_extract %status["active"] : !hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>
    %de_30 = hw.struct_extract %active["de"] : !hw.struct<d: i1, de: i1>
    %d_31 = hw.struct_extract %active["d"] : !hw.struct<d: i1, de: i1>
    %u_status_active.qe, %u_status_active.q, %u_status_active.ds, %u_status_active.qs = hw.instance "u_status_active" @prim_subreg_1(clk_i: %8: i1, rst_ni: %9: i1, we: %false: i1, wd: %false: i1, de: %de_30: i1, d: %d_31: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_active_qs, %u_status_active.qs after %1 : i1
    %ready = hw.struct_extract %status["ready"] : !hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>
    %de_32 = hw.struct_extract %ready["de"] : !hw.struct<d: i1, de: i1>
    %d_33 = hw.struct_extract %ready["d"] : !hw.struct<d: i1, de: i1>
    %u_status_ready.qe, %u_status_ready.q, %u_status_ready.ds, %u_status_ready.qs = hw.instance "u_status_ready" @prim_subreg_1(clk_i: %8: i1, rst_ni: %9: i1, we: %false: i1, wd: %false: i1, de: %de_32: i1, d: %d_33: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %status_ready_qs, %u_status_ready.qs after %1 : i1
    %53 = llhd.prb %configopts_we : i1
    %54 = llhd.sig.struct_extract %reg2hw["configopts"] : <!hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>>
    %55 = llhd.sig.struct_extract %54["clkdiv"] : <!hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>>
    %56 = llhd.sig.struct_extract %55["q"] : <!hw.struct<q: i16>>
    %u_configopts_clkdiv.qe, %u_configopts_clkdiv.q, %u_configopts_clkdiv.ds, %u_configopts_clkdiv.qs = hw.instance "u_configopts_clkdiv" @prim_subreg_7(clk_i: %8: i1, rst_ni: %9: i1, we: %53: i1, wd: %199: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %56, %u_configopts_clkdiv.q after %1 : i16
    llhd.drv %configopts_clkdiv_qs, %u_configopts_clkdiv.qs after %1 : i16
    %57 = llhd.sig.struct_extract %54["csnidle"] : <!hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>>
    %58 = llhd.sig.struct_extract %57["q"] : <!hw.struct<q: i4>>
    %u_configopts_csnidle.qe, %u_configopts_csnidle.q, %u_configopts_csnidle.ds, %u_configopts_csnidle.qs = hw.instance "u_configopts_csnidle" @prim_subreg_8(clk_i: %8: i1, rst_ni: %9: i1, we: %53: i1, wd: %200: i4, de: %false: i1, d: %c0_i4: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %58, %u_configopts_csnidle.q after %1 : i4
    llhd.drv %configopts_csnidle_qs, %u_configopts_csnidle.qs after %1 : i4
    %59 = llhd.sig.struct_extract %54["csntrail"] : <!hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>>
    %60 = llhd.sig.struct_extract %59["q"] : <!hw.struct<q: i4>>
    %u_configopts_csntrail.qe, %u_configopts_csntrail.q, %u_configopts_csntrail.ds, %u_configopts_csntrail.qs = hw.instance "u_configopts_csntrail" @prim_subreg_8(clk_i: %8: i1, rst_ni: %9: i1, we: %53: i1, wd: %201: i4, de: %false: i1, d: %c0_i4: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %60, %u_configopts_csntrail.q after %1 : i4
    llhd.drv %configopts_csntrail_qs, %u_configopts_csntrail.qs after %1 : i4
    %61 = llhd.sig.struct_extract %54["csnlead"] : <!hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>>
    %62 = llhd.sig.struct_extract %61["q"] : <!hw.struct<q: i4>>
    %u_configopts_csnlead.qe, %u_configopts_csnlead.q, %u_configopts_csnlead.ds, %u_configopts_csnlead.qs = hw.instance "u_configopts_csnlead" @prim_subreg_8(clk_i: %8: i1, rst_ni: %9: i1, we: %53: i1, wd: %202: i4, de: %false: i1, d: %c0_i4: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %62, %u_configopts_csnlead.q after %1 : i4
    llhd.drv %configopts_csnlead_qs, %u_configopts_csnlead.qs after %1 : i4
    %63 = llhd.sig.struct_extract %54["fullcyc"] : <!hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>>
    %64 = llhd.sig.struct_extract %63["q"] : <!hw.struct<q: i1>>
    %u_configopts_fullcyc.qe, %u_configopts_fullcyc.q, %u_configopts_fullcyc.ds, %u_configopts_fullcyc.qs = hw.instance "u_configopts_fullcyc" @prim_subreg_2(clk_i: %8: i1, rst_ni: %9: i1, we: %53: i1, wd: %194: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %64, %u_configopts_fullcyc.q after %1 : i1
    llhd.drv %configopts_fullcyc_qs, %u_configopts_fullcyc.qs after %1 : i1
    %65 = llhd.sig.struct_extract %54["cpha"] : <!hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>>
    %66 = llhd.sig.struct_extract %65["q"] : <!hw.struct<q: i1>>
    %u_configopts_cpha.qe, %u_configopts_cpha.q, %u_configopts_cpha.ds, %u_configopts_cpha.qs = hw.instance "u_configopts_cpha" @prim_subreg_2(clk_i: %8: i1, rst_ni: %9: i1, we: %53: i1, wd: %195: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %66, %u_configopts_cpha.q after %1 : i1
    llhd.drv %configopts_cpha_qs, %u_configopts_cpha.qs after %1 : i1
    %67 = llhd.sig.struct_extract %54["cpol"] : <!hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>>
    %68 = llhd.sig.struct_extract %67["q"] : <!hw.struct<q: i1>>
    %u_configopts_cpol.qe, %u_configopts_cpol.q, %u_configopts_cpol.ds, %u_configopts_cpol.qs = hw.instance "u_configopts_cpol" @prim_subreg_2(clk_i: %8: i1, rst_ni: %9: i1, we: %53: i1, wd: %196: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %68, %u_configopts_cpol.q after %1 : i1
    llhd.drv %configopts_cpol_qs, %u_configopts_cpol.qs after %1 : i1
    %69 = llhd.prb %csid_we : i1
    %70 = llhd.sig.struct_extract %reg2hw["csid"] : <!hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>>
    %71 = llhd.sig.struct_extract %70["q"] : <!hw.struct<q: i32>>
    %u_csid.qe, %u_csid.q, %u_csid.ds, %u_csid.qs = hw.instance "u_csid" @prim_subreg_9(clk_i: %8: i1, rst_ni: %9: i1, we: %69: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %71, %u_csid.q after %1 : i32
    llhd.drv %csid_qs, %u_csid.qs after %1 : i32
    %72 = llhd.prb %command_we : i1
    %73 = llhd.sig.extract %command_flds_we from %c0_i2 : <i4> -> <i1>
    %74 = llhd.sig.struct_extract %reg2hw["command"] : <!hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>>
    %75 = llhd.sig.struct_extract %74["csaat"] : <!hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>>
    %76 = llhd.sig.struct_extract %75["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_command_csaat.qe, %u_command_csaat.qre, %u_command_csaat.q, %u_command_csaat.ds, %u_command_csaat.qs = hw.instance "u_command_csaat" @prim_subreg_ext(re: %false: i1, we: %72: i1, wd: %182: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %73, %u_command_csaat.qe after %1 : i1
    llhd.drv %76, %u_command_csaat.q after %1 : i1
    %77 = llhd.sig.extract %command_flds_we from %c1_i2 : <i4> -> <i1>
    %78 = llhd.sig.struct_extract %74["speed"] : <!hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>>
    %79 = llhd.sig.struct_extract %78["q"] : <!hw.struct<q: i2, qe: i1>>
    %u_command_speed.qe, %u_command_speed.qre, %u_command_speed.q, %u_command_speed.ds, %u_command_speed.qs = hw.instance "u_command_speed" @prim_subreg_ext_10(re: %false: i1, we: %72: i1, wd: %207: i2, d: %c0_i2: i2) -> (qe: i1, qre: i1, q: i2, ds: i2, qs: i2)
    llhd.drv %77, %u_command_speed.qe after %1 : i1
    llhd.drv %79, %u_command_speed.q after %1 : i2
    %80 = llhd.sig.extract %command_flds_we from %c-2_i2 : <i4> -> <i1>
    %81 = llhd.sig.struct_extract %74["direction"] : <!hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>>
    %82 = llhd.sig.struct_extract %81["q"] : <!hw.struct<q: i2, qe: i1>>
    %u_command_direction.qe, %u_command_direction.qre, %u_command_direction.q, %u_command_direction.ds, %u_command_direction.qs = hw.instance "u_command_direction" @prim_subreg_ext_10(re: %false: i1, we: %72: i1, wd: %208: i2, d: %c0_i2: i2) -> (qe: i1, qre: i1, q: i2, ds: i2, qs: i2)
    llhd.drv %80, %u_command_direction.qe after %1 : i1
    llhd.drv %82, %u_command_direction.q after %1 : i2
    %83 = llhd.sig.extract %command_flds_we from %c-1_i2 : <i4> -> <i1>
    %84 = llhd.sig.struct_extract %74["len"] : <!hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>>
    %85 = llhd.sig.struct_extract %84["q"] : <!hw.struct<q: i20, qe: i1>>
    %u_command_len.qe, %u_command_len.qre, %u_command_len.q, %u_command_len.ds, %u_command_len.qs = hw.instance "u_command_len" @prim_subreg_ext_11(re: %false: i1, we: %72: i1, wd: %209: i20, d: %c0_i20: i20) -> (qe: i1, qre: i1, q: i20, ds: i20, qs: i20)
    llhd.drv %83, %u_command_len.qe after %1 : i1
    llhd.drv %85, %u_command_len.q after %1 : i20
    %86 = llhd.prb %error_enable_we : i1
    %87 = llhd.sig.struct_extract %reg2hw["error_enable"] : <!hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>>
    %88 = llhd.sig.struct_extract %87["cmdbusy"] : <!hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>>
    %89 = llhd.sig.struct_extract %88["q"] : <!hw.struct<q: i1>>
    %u_error_enable_cmdbusy.qe, %u_error_enable_cmdbusy.q, %u_error_enable_cmdbusy.ds, %u_error_enable_cmdbusy.qs = hw.instance "u_error_enable_cmdbusy" @prim_subreg_12(clk_i: %8: i1, rst_ni: %9: i1, we: %86: i1, wd: %182: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %89, %u_error_enable_cmdbusy.q after %1 : i1
    llhd.drv %error_enable_cmdbusy_qs, %u_error_enable_cmdbusy.qs after %1 : i1
    %90 = llhd.sig.struct_extract %87["overflow"] : <!hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>>
    %91 = llhd.sig.struct_extract %90["q"] : <!hw.struct<q: i1>>
    %u_error_enable_overflow.qe, %u_error_enable_overflow.q, %u_error_enable_overflow.ds, %u_error_enable_overflow.qs = hw.instance "u_error_enable_overflow" @prim_subreg_12(clk_i: %8: i1, rst_ni: %9: i1, we: %86: i1, wd: %185: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %91, %u_error_enable_overflow.q after %1 : i1
    llhd.drv %error_enable_overflow_qs, %u_error_enable_overflow.qs after %1 : i1
    %92 = llhd.sig.struct_extract %87["underflow"] : <!hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>>
    %93 = llhd.sig.struct_extract %92["q"] : <!hw.struct<q: i1>>
    %u_error_enable_underflow.qe, %u_error_enable_underflow.q, %u_error_enable_underflow.ds, %u_error_enable_underflow.qs = hw.instance "u_error_enable_underflow" @prim_subreg_12(clk_i: %8: i1, rst_ni: %9: i1, we: %86: i1, wd: %212: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %93, %u_error_enable_underflow.q after %1 : i1
    llhd.drv %error_enable_underflow_qs, %u_error_enable_underflow.qs after %1 : i1
    %94 = llhd.sig.struct_extract %87["cmdinval"] : <!hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>>
    %95 = llhd.sig.struct_extract %94["q"] : <!hw.struct<q: i1>>
    %u_error_enable_cmdinval.qe, %u_error_enable_cmdinval.q, %u_error_enable_cmdinval.ds, %u_error_enable_cmdinval.qs = hw.instance "u_error_enable_cmdinval" @prim_subreg_12(clk_i: %8: i1, rst_ni: %9: i1, we: %86: i1, wd: %213: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %95, %u_error_enable_cmdinval.q after %1 : i1
    llhd.drv %error_enable_cmdinval_qs, %u_error_enable_cmdinval.qs after %1 : i1
    %96 = llhd.sig.struct_extract %87["csidinval"] : <!hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>>
    %97 = llhd.sig.struct_extract %96["q"] : <!hw.struct<q: i1>>
    %u_error_enable_csidinval.qe, %u_error_enable_csidinval.q, %u_error_enable_csidinval.ds, %u_error_enable_csidinval.qs = hw.instance "u_error_enable_csidinval" @prim_subreg_12(clk_i: %8: i1, rst_ni: %9: i1, we: %86: i1, wd: %214: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %97, %u_error_enable_csidinval.q after %1 : i1
    llhd.drv %error_enable_csidinval_qs, %u_error_enable_csidinval.qs after %1 : i1
    %98 = llhd.prb %error_status_we : i1
    %error_status = hw.struct_extract %hw2reg["error_status"] : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<d: i1, de: i1>, error: !hw.struct<d: i1, de: i1>>, status: !hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>, error_status: !hw.struct<accessinval: !hw.struct<d: i1, de: i1>, csidinval: !hw.struct<d: i1, de: i1>, cmdinval: !hw.struct<d: i1, de: i1>, underflow: !hw.struct<d: i1, de: i1>, overflow: !hw.struct<d: i1, de: i1>, cmdbusy: !hw.struct<d: i1, de: i1>>>
    %cmdbusy = hw.struct_extract %error_status["cmdbusy"] : !hw.struct<accessinval: !hw.struct<d: i1, de: i1>, csidinval: !hw.struct<d: i1, de: i1>, cmdinval: !hw.struct<d: i1, de: i1>, underflow: !hw.struct<d: i1, de: i1>, overflow: !hw.struct<d: i1, de: i1>, cmdbusy: !hw.struct<d: i1, de: i1>>
    %de_34 = hw.struct_extract %cmdbusy["de"] : !hw.struct<d: i1, de: i1>
    %d_35 = hw.struct_extract %cmdbusy["d"] : !hw.struct<d: i1, de: i1>
    %99 = llhd.sig.struct_extract %reg2hw["error_status"] : <!hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>>
    %100 = llhd.sig.struct_extract %99["cmdbusy"] : <!hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>>
    %101 = llhd.sig.struct_extract %100["q"] : <!hw.struct<q: i1>>
    %u_error_status_cmdbusy.qe, %u_error_status_cmdbusy.q, %u_error_status_cmdbusy.ds, %u_error_status_cmdbusy.qs = hw.instance "u_error_status_cmdbusy" @prim_subreg(clk_i: %8: i1, rst_ni: %9: i1, we: %98: i1, wd: %182: i1, de: %de_34: i1, d: %d_35: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %101, %u_error_status_cmdbusy.q after %1 : i1
    llhd.drv %error_status_cmdbusy_qs, %u_error_status_cmdbusy.qs after %1 : i1
    %overflow = hw.struct_extract %error_status["overflow"] : !hw.struct<accessinval: !hw.struct<d: i1, de: i1>, csidinval: !hw.struct<d: i1, de: i1>, cmdinval: !hw.struct<d: i1, de: i1>, underflow: !hw.struct<d: i1, de: i1>, overflow: !hw.struct<d: i1, de: i1>, cmdbusy: !hw.struct<d: i1, de: i1>>
    %de_36 = hw.struct_extract %overflow["de"] : !hw.struct<d: i1, de: i1>
    %d_37 = hw.struct_extract %overflow["d"] : !hw.struct<d: i1, de: i1>
    %102 = llhd.sig.struct_extract %99["overflow"] : <!hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>>
    %103 = llhd.sig.struct_extract %102["q"] : <!hw.struct<q: i1>>
    %u_error_status_overflow.qe, %u_error_status_overflow.q, %u_error_status_overflow.ds, %u_error_status_overflow.qs = hw.instance "u_error_status_overflow" @prim_subreg(clk_i: %8: i1, rst_ni: %9: i1, we: %98: i1, wd: %185: i1, de: %de_36: i1, d: %d_37: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %103, %u_error_status_overflow.q after %1 : i1
    llhd.drv %error_status_overflow_qs, %u_error_status_overflow.qs after %1 : i1
    %underflow = hw.struct_extract %error_status["underflow"] : !hw.struct<accessinval: !hw.struct<d: i1, de: i1>, csidinval: !hw.struct<d: i1, de: i1>, cmdinval: !hw.struct<d: i1, de: i1>, underflow: !hw.struct<d: i1, de: i1>, overflow: !hw.struct<d: i1, de: i1>, cmdbusy: !hw.struct<d: i1, de: i1>>
    %de_38 = hw.struct_extract %underflow["de"] : !hw.struct<d: i1, de: i1>
    %d_39 = hw.struct_extract %underflow["d"] : !hw.struct<d: i1, de: i1>
    %104 = llhd.sig.struct_extract %99["underflow"] : <!hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>>
    %105 = llhd.sig.struct_extract %104["q"] : <!hw.struct<q: i1>>
    %u_error_status_underflow.qe, %u_error_status_underflow.q, %u_error_status_underflow.ds, %u_error_status_underflow.qs = hw.instance "u_error_status_underflow" @prim_subreg(clk_i: %8: i1, rst_ni: %9: i1, we: %98: i1, wd: %212: i1, de: %de_38: i1, d: %d_39: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %105, %u_error_status_underflow.q after %1 : i1
    llhd.drv %error_status_underflow_qs, %u_error_status_underflow.qs after %1 : i1
    %cmdinval = hw.struct_extract %error_status["cmdinval"] : !hw.struct<accessinval: !hw.struct<d: i1, de: i1>, csidinval: !hw.struct<d: i1, de: i1>, cmdinval: !hw.struct<d: i1, de: i1>, underflow: !hw.struct<d: i1, de: i1>, overflow: !hw.struct<d: i1, de: i1>, cmdbusy: !hw.struct<d: i1, de: i1>>
    %de_40 = hw.struct_extract %cmdinval["de"] : !hw.struct<d: i1, de: i1>
    %d_41 = hw.struct_extract %cmdinval["d"] : !hw.struct<d: i1, de: i1>
    %106 = llhd.sig.struct_extract %99["cmdinval"] : <!hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>>
    %107 = llhd.sig.struct_extract %106["q"] : <!hw.struct<q: i1>>
    %u_error_status_cmdinval.qe, %u_error_status_cmdinval.q, %u_error_status_cmdinval.ds, %u_error_status_cmdinval.qs = hw.instance "u_error_status_cmdinval" @prim_subreg(clk_i: %8: i1, rst_ni: %9: i1, we: %98: i1, wd: %213: i1, de: %de_40: i1, d: %d_41: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %107, %u_error_status_cmdinval.q after %1 : i1
    llhd.drv %error_status_cmdinval_qs, %u_error_status_cmdinval.qs after %1 : i1
    %csidinval = hw.struct_extract %error_status["csidinval"] : !hw.struct<accessinval: !hw.struct<d: i1, de: i1>, csidinval: !hw.struct<d: i1, de: i1>, cmdinval: !hw.struct<d: i1, de: i1>, underflow: !hw.struct<d: i1, de: i1>, overflow: !hw.struct<d: i1, de: i1>, cmdbusy: !hw.struct<d: i1, de: i1>>
    %de_42 = hw.struct_extract %csidinval["de"] : !hw.struct<d: i1, de: i1>
    %d_43 = hw.struct_extract %csidinval["d"] : !hw.struct<d: i1, de: i1>
    %108 = llhd.sig.struct_extract %99["csidinval"] : <!hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>>
    %109 = llhd.sig.struct_extract %108["q"] : <!hw.struct<q: i1>>
    %u_error_status_csidinval.qe, %u_error_status_csidinval.q, %u_error_status_csidinval.ds, %u_error_status_csidinval.qs = hw.instance "u_error_status_csidinval" @prim_subreg(clk_i: %8: i1, rst_ni: %9: i1, we: %98: i1, wd: %214: i1, de: %de_42: i1, d: %d_43: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %109, %u_error_status_csidinval.q after %1 : i1
    llhd.drv %error_status_csidinval_qs, %u_error_status_csidinval.qs after %1 : i1
    %accessinval = hw.struct_extract %error_status["accessinval"] : !hw.struct<accessinval: !hw.struct<d: i1, de: i1>, csidinval: !hw.struct<d: i1, de: i1>, cmdinval: !hw.struct<d: i1, de: i1>, underflow: !hw.struct<d: i1, de: i1>, overflow: !hw.struct<d: i1, de: i1>, cmdbusy: !hw.struct<d: i1, de: i1>>
    %de_44 = hw.struct_extract %accessinval["de"] : !hw.struct<d: i1, de: i1>
    %d_45 = hw.struct_extract %accessinval["d"] : !hw.struct<d: i1, de: i1>
    %110 = llhd.sig.struct_extract %99["accessinval"] : <!hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>>
    %111 = llhd.sig.struct_extract %110["q"] : <!hw.struct<q: i1>>
    %u_error_status_accessinval.qe, %u_error_status_accessinval.q, %u_error_status_accessinval.ds, %u_error_status_accessinval.qs = hw.instance "u_error_status_accessinval" @prim_subreg(clk_i: %8: i1, rst_ni: %9: i1, we: %98: i1, wd: %217: i1, de: %de_44: i1, d: %d_45: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %111, %u_error_status_accessinval.q after %1 : i1
    llhd.drv %error_status_accessinval_qs, %u_error_status_accessinval.qs after %1 : i1
    %112 = llhd.prb %event_enable_we : i1
    %113 = llhd.sig.struct_extract %reg2hw["event_enable"] : <!hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>>
    %114 = llhd.sig.struct_extract %113["rxfull"] : <!hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
    %115 = llhd.sig.struct_extract %114["q"] : <!hw.struct<q: i1>>
    %u_event_enable_rxfull.qe, %u_event_enable_rxfull.q, %u_event_enable_rxfull.ds, %u_event_enable_rxfull.qs = hw.instance "u_event_enable_rxfull" @prim_subreg_2(clk_i: %8: i1, rst_ni: %9: i1, we: %112: i1, wd: %182: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %115, %u_event_enable_rxfull.q after %1 : i1
    llhd.drv %event_enable_rxfull_qs, %u_event_enable_rxfull.qs after %1 : i1
    %116 = llhd.sig.struct_extract %113["txempty"] : <!hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
    %117 = llhd.sig.struct_extract %116["q"] : <!hw.struct<q: i1>>
    %u_event_enable_txempty.qe, %u_event_enable_txempty.q, %u_event_enable_txempty.ds, %u_event_enable_txempty.qs = hw.instance "u_event_enable_txempty" @prim_subreg_2(clk_i: %8: i1, rst_ni: %9: i1, we: %112: i1, wd: %185: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %117, %u_event_enable_txempty.q after %1 : i1
    llhd.drv %event_enable_txempty_qs, %u_event_enable_txempty.qs after %1 : i1
    %118 = llhd.sig.struct_extract %113["rxwm"] : <!hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
    %119 = llhd.sig.struct_extract %118["q"] : <!hw.struct<q: i1>>
    %u_event_enable_rxwm.qe, %u_event_enable_rxwm.q, %u_event_enable_rxwm.ds, %u_event_enable_rxwm.qs = hw.instance "u_event_enable_rxwm" @prim_subreg_2(clk_i: %8: i1, rst_ni: %9: i1, we: %112: i1, wd: %212: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %119, %u_event_enable_rxwm.q after %1 : i1
    llhd.drv %event_enable_rxwm_qs, %u_event_enable_rxwm.qs after %1 : i1
    %120 = llhd.sig.struct_extract %113["txwm"] : <!hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
    %121 = llhd.sig.struct_extract %120["q"] : <!hw.struct<q: i1>>
    %u_event_enable_txwm.qe, %u_event_enable_txwm.q, %u_event_enable_txwm.ds, %u_event_enable_txwm.qs = hw.instance "u_event_enable_txwm" @prim_subreg_2(clk_i: %8: i1, rst_ni: %9: i1, we: %112: i1, wd: %213: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %121, %u_event_enable_txwm.q after %1 : i1
    llhd.drv %event_enable_txwm_qs, %u_event_enable_txwm.qs after %1 : i1
    %122 = llhd.sig.struct_extract %113["ready"] : <!hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
    %123 = llhd.sig.struct_extract %122["q"] : <!hw.struct<q: i1>>
    %u_event_enable_ready.qe, %u_event_enable_ready.q, %u_event_enable_ready.ds, %u_event_enable_ready.qs = hw.instance "u_event_enable_ready" @prim_subreg_2(clk_i: %8: i1, rst_ni: %9: i1, we: %112: i1, wd: %214: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %123, %u_event_enable_ready.q after %1 : i1
    llhd.drv %event_enable_ready_qs, %u_event_enable_ready.qs after %1 : i1
    %124 = llhd.sig.struct_extract %113["idle"] : <!hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
    %125 = llhd.sig.struct_extract %124["q"] : <!hw.struct<q: i1>>
    %u_event_enable_idle.qe, %u_event_enable_idle.q, %u_event_enable_idle.ds, %u_event_enable_idle.qs = hw.instance "u_event_enable_idle" @prim_subreg_2(clk_i: %8: i1, rst_ni: %9: i1, we: %112: i1, wd: %217: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %125, %u_event_enable_idle.q after %1 : i1
    llhd.drv %event_enable_idle_qs, %u_event_enable_idle.qs after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %270 = llhd.prb %clk_i_0 : i1
      %271 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%8, %9 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %272 = llhd.prb %clk_i_0 : i1
      %273 = comb.xor bin %270, %true : i1
      %274 = comb.and bin %273, %272 : i1
      %275 = llhd.prb %rst_ni_1 : i1
      %276 = comb.xor bin %275, %true : i1
      %277 = comb.and bin %271, %276 : i1
      %278 = comb.or bin %274, %277 : i1
      cf.cond_br %278, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %279 = llhd.prb %rst_ni_1 : i1
      %280 = comb.xor %279, %true : i1
      cf.cond_br %280, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %err_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %281 = llhd.prb %intg_err : i1
      %282 = llhd.prb %reg_we_err : i1
      %283 = comb.or %281, %282 : i1
      cf.cond_br %283, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %err_q, %true after %0 : i1
      cf.br ^bb1
    }
    %126 = llhd.prb %err_q : i1
    %127 = llhd.prb %intg_err : i1
    %128 = llhd.prb %reg_we_err : i1
    %129 = comb.or %126, %127, %128 : i1
    %130 = hw.array_get %u_socket.tl_d_o[%c0_i2] {sv.namehint = "tl_reg_h2d"} : !hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>, i2
    %131 = llhd.sig.array_get %tl_socket_d2h[%c0_i2] : <!hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>>
    llhd.drv %131, %u_reg_if.tl_o after %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %132 = llhd.sig.array_get %tl_win_o[%true] : <!hw.array<2xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>>
    %133 = hw.array_get %u_socket.tl_d_o[%c-2_i2] : !hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>, i2
    llhd.drv %132, %133 after %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %134 = llhd.sig.array_get %tl_socket_d2h[%c-2_i2] : <!hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>>
    %135 = hw.array_get %tl_win_i[%true] : !hw.array<2xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, i1
    llhd.drv %134, %135 after %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    %136 = llhd.sig.array_get %tl_win_o[%false] : <!hw.array<2xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>>
    %137 = hw.array_get %u_socket.tl_d_o[%c1_i2] : !hw.array<3xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>, i2
    llhd.drv %136, %137 after %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %138 = llhd.sig.array_get %tl_socket_d2h[%c1_i2] : <!hw.array<3xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>>
    %139 = hw.array_get %tl_win_i[%false] : !hw.array<2xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, i1
    llhd.drv %138, %139 after %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb3
      %270 = llhd.prb %tl_i_2 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %a_address = hw.struct_extract %270["a_address"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
      %271 = comb.extract %a_address from 0 : (i32) -> i6
      %272 = comb.concat %c0_i26, %271 : i26, i6
      %273 = comb.icmp ugt %272, %c35_i32 : i32
      %274 = comb.icmp ult %272, %c40_i32 : i32
      %275 = comb.and %273, %274 : i1
      %276 = comb.icmp ugt %272, %c39_i32 : i32
      %277 = comb.icmp ult %272, %c44_i32 : i32
      %278 = comb.and %276, %277 : i1
      %279 = comb.mux %278, %c1_i2, %c-2_i2 : i2
      %280 = comb.mux %275, %c0_i2, %279 : i2
      llhd.drv %reg_steer, %280 after %1 : i2
      %281 = llhd.prb %intg_err : i1
      cf.cond_br %281, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      llhd.drv %reg_steer, %c-2_i2 after %1 : i2
      cf.br ^bb3
    ^bb3:  // 2 preds: ^bb1, ^bb2
      llhd.wait (%10, %16, %127 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, i2, i1), ^bb1
    }
    %140 = llhd.prb %reg_rdata_next {sv.namehint = "reg_rdata"} : i32
    %141 = llhd.prb %wr_err : i1
    %142 = comb.or %164, %141, %127 {sv.namehint = "reg_error"} : i1
    %143 = llhd.prb %intr_test_flds_we : i2
    %144 = comb.icmp eq %143, %c-1_i2 {sv.namehint = "intr_test_qe"} : i2
    %145 = llhd.sig.struct_extract %33["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %145, %144 after %1 : i1
    %146 = llhd.sig.struct_extract %36["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %146, %144 after %1 : i1
    %147 = llhd.prb %alert_test_flds_we {sv.namehint = "alert_test_qe"} : i1
    %148 = llhd.sig.struct_extract %39["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %148, %147 after %1 : i1
    %149 = llhd.prb %command_flds_we : i4
    %150 = comb.icmp eq %149, %c-1_i4 {sv.namehint = "command_qe"} : i4
    %151 = llhd.sig.struct_extract %75["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %151, %150 after %1 : i1
    %152 = llhd.sig.struct_extract %78["qe"] : <!hw.struct<q: i2, qe: i1>>
    llhd.drv %152, %150 after %1 : i1
    %153 = llhd.sig.struct_extract %81["qe"] : <!hw.struct<q: i2, qe: i1>>
    llhd.drv %153, %150 after %1 : i1
    %154 = llhd.sig.struct_extract %84["qe"] : <!hw.struct<q: i20, qe: i1>>
    llhd.drv %154, %150 after %1 : i1
    llhd.drv %racl_role_vec, %c0_i2 after %1 : i2
    %155 = llhd.prb %racl_addr_hit_read : i12
    %156 = llhd.prb %racl_addr_hit_write : i12
    %157 = llhd.prb %addr_hit : i12
    %158 = llhd.prb %reg_addr : i6
    %159 = llhd.prb %racl_policies_i_3 : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    %160 = llhd.prb %racl_role_vec : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %racl_addr_hit_read, %c0_i12 after %1 : i12
      llhd.drv %racl_addr_hit_write, %c0_i12 after %1 : i12
      %270 = llhd.sig.extract %addr_hit from %c0_i4 : <i12> -> <i1>
      %271 = llhd.prb %reg_addr : i6
      %272 = comb.icmp eq %271, %c0_i6 : i6
      llhd.drv %270, %272 after %1 : i1
      %273 = llhd.sig.extract %addr_hit from %c1_i4 : <i12> -> <i1>
      %274 = llhd.prb %reg_addr : i6
      %275 = comb.icmp eq %274, %c4_i6 : i6
      llhd.drv %273, %275 after %1 : i1
      %276 = llhd.sig.extract %addr_hit from %c2_i4 : <i12> -> <i1>
      %277 = llhd.prb %reg_addr : i6
      %278 = comb.icmp eq %277, %c8_i6 : i6
      llhd.drv %276, %278 after %1 : i1
      %279 = llhd.sig.extract %addr_hit from %c3_i4 : <i12> -> <i1>
      %280 = llhd.prb %reg_addr : i6
      %281 = comb.icmp eq %280, %c12_i6 : i6
      llhd.drv %279, %281 after %1 : i1
      %282 = llhd.sig.extract %addr_hit from %c4_i4 : <i12> -> <i1>
      %283 = llhd.prb %reg_addr : i6
      %284 = comb.icmp eq %283, %c16_i6 : i6
      llhd.drv %282, %284 after %1 : i1
      %285 = llhd.sig.extract %addr_hit from %c5_i4 : <i12> -> <i1>
      %286 = llhd.prb %reg_addr : i6
      %287 = comb.icmp eq %286, %c20_i6 : i6
      llhd.drv %285, %287 after %1 : i1
      %288 = llhd.sig.extract %addr_hit from %c6_i4 : <i12> -> <i1>
      %289 = llhd.prb %reg_addr : i6
      %290 = comb.icmp eq %289, %c24_i6 : i6
      llhd.drv %288, %290 after %1 : i1
      %291 = llhd.sig.extract %addr_hit from %c7_i4 : <i12> -> <i1>
      %292 = llhd.prb %reg_addr : i6
      %293 = comb.icmp eq %292, %c28_i6 : i6
      llhd.drv %291, %293 after %1 : i1
      %294 = llhd.sig.extract %addr_hit from %c-8_i4 : <i12> -> <i1>
      %295 = llhd.prb %reg_addr : i6
      %296 = comb.icmp eq %295, %c-32_i6 : i6
      llhd.drv %294, %296 after %1 : i1
      %297 = llhd.sig.extract %addr_hit from %c-7_i4 : <i12> -> <i1>
      %298 = llhd.prb %reg_addr : i6
      %299 = comb.icmp eq %298, %c-20_i6 : i6
      llhd.drv %297, %299 after %1 : i1
      %300 = llhd.sig.extract %addr_hit from %c-6_i4 : <i12> -> <i1>
      %301 = llhd.prb %reg_addr : i6
      %302 = comb.icmp eq %301, %c-16_i6 : i6
      llhd.drv %300, %302 after %1 : i1
      %303 = llhd.sig.extract %addr_hit from %c-5_i4 : <i12> -> <i1>
      %304 = llhd.prb %reg_addr : i6
      %305 = comb.icmp eq %304, %c-12_i6 : i6
      llhd.drv %303, %305 after %1 : i1
      %306 = llhd.prb %addr_hit : i12
      llhd.drv %racl_addr_hit_read, %306 after %1 : i12
      %307 = llhd.prb %addr_hit : i12
      llhd.drv %racl_addr_hit_write, %307 after %1 : i12
      llhd.wait (%155, %156, %157, %158, %159, %160 : i12, i12, i12, i6, !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, i2), ^bb1
    }
    %161 = comb.or %u_reg_if.re_o, %12 : i1
    %162 = comb.icmp ne %157, %c0_i12 : i12
    %163 = comb.xor %162, %true : i1
    %164 = comb.and %161, %163 {sv.namehint = "addrmiss"} : i1
    %165 = llhd.sig.struct_extract %racl_error_o["valid"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    %166 = comb.icmp eq %155, %c0_i12 : i12
    %167 = comb.and %u_reg_if.re_o, %166 : i1
    %168 = comb.icmp eq %156, %c0_i12 : i12
    %169 = comb.and %12, %168 : i1
    %170 = comb.or %167, %169 : i1
    %171 = comb.and %162, %170 : i1
    llhd.drv %165, %171 after %1 : i1
    %172 = llhd.sig.struct_extract %racl_error_o["request_address"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    %173 = comb.concat %c0_i26, %158 : i26, i6
    llhd.drv %172, %173 after %1 : i32
    %174 = llhd.sig.struct_extract %racl_error_o["racl_role"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %174, %false after %1 : i1
    %175 = llhd.sig.struct_extract %racl_error_o["overflow"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %175, %false after %1 : i1
    %176 = llhd.sig.struct_extract %racl_error_o["ctn_uid"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %176, %false after %1 : i1
    %177 = llhd.sig.struct_extract %racl_error_o["read_access"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %177, %false after %1 : i1
    %178 = llhd.prb %reg_be : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %270 = llhd.prb %reg_we : i1
      %271 = llhd.prb %racl_addr_hit_write : i12
      %272 = comb.extract %271 from 0 : (i12) -> i1
      %273 = llhd.prb %reg_be : i4
      %274 = comb.extract %273 from 0 : (i4) -> i1
      %275 = comb.xor %274, %true : i1
      %276 = comb.and %272, %275 : i1
      %277 = comb.extract %271 from 1 : (i12) -> i1
      %278 = comb.and %277, %275 : i1
      %279 = comb.extract %271 from 2 : (i12) -> i1
      %280 = comb.and %279, %275 : i1
      %281 = comb.extract %271 from 3 : (i12) -> i1
      %282 = comb.and %281, %275 : i1
      %283 = comb.extract %271 from 4 : (i12) -> i1
      %284 = comb.icmp ne %273, %c-1_i4 : i4
      %285 = comb.and %283, %284 : i1
      %286 = comb.extract %271 from 5 : (i12) -> i1
      %287 = comb.icmp ne %273, %c-1_i4 : i4
      %288 = comb.and %286, %287 : i1
      %289 = comb.extract %271 from 6 : (i12) -> i1
      %290 = comb.icmp ne %273, %c-1_i4 : i4
      %291 = comb.and %289, %290 : i1
      %292 = comb.extract %271 from 7 : (i12) -> i1
      %293 = comb.icmp ne %273, %c-1_i4 : i4
      %294 = comb.and %292, %293 : i1
      %295 = comb.extract %271 from 8 : (i12) -> i1
      %296 = comb.icmp ne %273, %c-1_i4 : i4
      %297 = comb.and %295, %296 : i1
      %298 = comb.extract %271 from 9 : (i12) -> i1
      %299 = comb.and %298, %275 : i1
      %300 = comb.extract %271 from 10 : (i12) -> i1
      %301 = comb.and %300, %275 : i1
      %302 = comb.extract %271 from 11 : (i12) -> i1
      %303 = comb.and %302, %275 : i1
      %304 = comb.or %276, %278, %280, %282, %285, %288, %291, %294, %297, %299, %301, %303 : i1
      %305 = comb.and %270, %304 : i1
      llhd.drv %wr_err, %305 after %1 : i1
      llhd.wait (%12, %156, %178, %141 : i1, i12, i4, i1), ^bb1
    }
    %179 = comb.extract %156 from 0 : (i12) -> i1
    %180 = comb.xor %142, %true : i1
    %181 = comb.and %179, %12, %180 : i1
    llhd.drv %intr_state_we, %181 after %1 : i1
    %182 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "alert_test_wd"} : (i32) -> i1
    %183 = comb.extract %156 from 1 : (i12) -> i1
    %184 = comb.and %183, %12, %180 : i1
    llhd.drv %intr_enable_we, %184 after %1 : i1
    %185 = comb.extract %u_reg_if.wdata_o from 1 {sv.namehint = "event_enable_txempty_wd"} : (i32) -> i1
    %186 = comb.extract %156 from 2 : (i12) -> i1
    %187 = comb.and %186, %12, %180 : i1
    llhd.drv %intr_test_we, %187 after %1 : i1
    %188 = comb.extract %156 from 3 : (i12) -> i1
    %189 = comb.and %188, %12, %180 : i1
    llhd.drv %alert_test_we, %189 after %1 : i1
    %190 = comb.extract %156 from 4 : (i12) -> i1
    %191 = comb.and %190, %12, %180 : i1
    llhd.drv %control_we, %191 after %1 : i1
    %192 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "control_rx_watermark_wd"} : (i32) -> i8
    %193 = comb.extract %u_reg_if.wdata_o from 8 {sv.namehint = "control_tx_watermark_wd"} : (i32) -> i8
    %194 = comb.extract %u_reg_if.wdata_o from 29 {sv.namehint = "configopts_fullcyc_wd"} : (i32) -> i1
    %195 = comb.extract %u_reg_if.wdata_o from 30 {sv.namehint = "configopts_cpha_wd"} : (i32) -> i1
    %196 = comb.extract %u_reg_if.wdata_o from 31 {sv.namehint = "control_spien_wd"} : (i32) -> i1
    %197 = comb.extract %156 from 6 : (i12) -> i1
    %198 = comb.and %197, %12, %180 : i1
    llhd.drv %configopts_we, %198 after %1 : i1
    %199 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "configopts_clkdiv_wd"} : (i32) -> i16
    %200 = comb.extract %u_reg_if.wdata_o from 16 {sv.namehint = "configopts_csnidle_wd"} : (i32) -> i4
    %201 = comb.extract %u_reg_if.wdata_o from 20 {sv.namehint = "configopts_csntrail_wd"} : (i32) -> i4
    %202 = comb.extract %u_reg_if.wdata_o from 24 {sv.namehint = "configopts_csnlead_wd"} : (i32) -> i4
    %203 = comb.extract %156 from 7 : (i12) -> i1
    %204 = comb.and %203, %12, %180 : i1
    llhd.drv %csid_we, %204 after %1 : i1
    %205 = comb.extract %156 from 8 : (i12) -> i1
    %206 = comb.and %205, %12, %180 : i1
    llhd.drv %command_we, %206 after %1 : i1
    %207 = comb.extract %u_reg_if.wdata_o from 1 {sv.namehint = "command_speed_wd"} : (i32) -> i2
    %208 = comb.extract %u_reg_if.wdata_o from 3 {sv.namehint = "command_direction_wd"} : (i32) -> i2
    %209 = comb.extract %u_reg_if.wdata_o from 5 {sv.namehint = "command_len_wd"} : (i32) -> i20
    %210 = comb.extract %156 from 9 : (i12) -> i1
    %211 = comb.and %210, %12, %180 : i1
    llhd.drv %error_enable_we, %211 after %1 : i1
    %212 = comb.extract %u_reg_if.wdata_o from 2 {sv.namehint = "event_enable_rxwm_wd"} : (i32) -> i1
    %213 = comb.extract %u_reg_if.wdata_o from 3 {sv.namehint = "event_enable_txwm_wd"} : (i32) -> i1
    %214 = comb.extract %u_reg_if.wdata_o from 4 {sv.namehint = "event_enable_ready_wd"} : (i32) -> i1
    %215 = comb.extract %156 from 10 : (i12) -> i1
    %216 = comb.and %215, %12, %180 : i1
    llhd.drv %error_status_we, %216 after %1 : i1
    %217 = comb.extract %u_reg_if.wdata_o from 5 {sv.namehint = "event_enable_idle_wd"} : (i32) -> i1
    %218 = comb.extract %156 from 11 : (i12) -> i1
    %219 = comb.and %218, %12, %180 : i1
    llhd.drv %event_enable_we, %219 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %270 = llhd.sig.extract %reg_we_check from %c0_i4 : <i12> -> <i1>
      %271 = llhd.prb %intr_state_we : i1
      llhd.drv %270, %271 after %1 : i1
      %272 = llhd.sig.extract %reg_we_check from %c1_i4 : <i12> -> <i1>
      %273 = llhd.prb %intr_enable_we : i1
      llhd.drv %272, %273 after %1 : i1
      %274 = llhd.sig.extract %reg_we_check from %c2_i4 : <i12> -> <i1>
      %275 = llhd.prb %intr_test_we : i1
      llhd.drv %274, %275 after %1 : i1
      %276 = llhd.sig.extract %reg_we_check from %c3_i4 : <i12> -> <i1>
      %277 = llhd.prb %alert_test_we : i1
      llhd.drv %276, %277 after %1 : i1
      %278 = llhd.sig.extract %reg_we_check from %c4_i4 : <i12> -> <i1>
      %279 = llhd.prb %control_we : i1
      llhd.drv %278, %279 after %1 : i1
      %280 = llhd.sig.extract %reg_we_check from %c5_i4 : <i12> -> <i1>
      llhd.drv %280, %false after %1 : i1
      %281 = llhd.sig.extract %reg_we_check from %c6_i4 : <i12> -> <i1>
      %282 = llhd.prb %configopts_we : i1
      llhd.drv %281, %282 after %1 : i1
      %283 = llhd.sig.extract %reg_we_check from %c7_i4 : <i12> -> <i1>
      %284 = llhd.prb %csid_we : i1
      llhd.drv %283, %284 after %1 : i1
      %285 = llhd.sig.extract %reg_we_check from %c-8_i4 : <i12> -> <i1>
      %286 = llhd.prb %command_we : i1
      llhd.drv %285, %286 after %1 : i1
      %287 = llhd.sig.extract %reg_we_check from %c-7_i4 : <i12> -> <i1>
      %288 = llhd.prb %error_enable_we : i1
      llhd.drv %287, %288 after %1 : i1
      %289 = llhd.sig.extract %reg_we_check from %c-6_i4 : <i12> -> <i1>
      %290 = llhd.prb %error_status_we : i1
      llhd.drv %289, %290 after %1 : i1
      %291 = llhd.sig.extract %reg_we_check from %c-5_i4 : <i12> -> <i1>
      %292 = llhd.prb %event_enable_we : i1
      llhd.drv %291, %292 after %1 : i1
      llhd.wait (%11, %18, %24, %30, %38, %41, %53, %69, %72, %86, %98, %112 : i12, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    %220 = llhd.prb %intr_state_error_qs : i1
    %221 = llhd.prb %intr_state_spi_event_qs : i1
    %222 = llhd.prb %intr_enable_error_qs : i1
    %223 = llhd.prb %intr_enable_spi_event_qs : i1
    %224 = llhd.prb %control_rx_watermark_qs : i8
    %225 = llhd.prb %control_tx_watermark_qs : i8
    %226 = llhd.prb %control_output_en_qs : i1
    %227 = llhd.prb %control_sw_rst_qs : i1
    %228 = llhd.prb %control_spien_qs : i1
    %229 = llhd.prb %status_txqd_qs : i8
    %230 = llhd.prb %status_rxqd_qs : i8
    %231 = llhd.prb %status_cmdqd_qs : i4
    %232 = llhd.prb %status_rxwm_qs : i1
    %233 = llhd.prb %status_byteorder_qs : i1
    %234 = llhd.prb %status_rxstall_qs : i1
    %235 = llhd.prb %status_rxempty_qs : i1
    %236 = llhd.prb %status_rxfull_qs : i1
    %237 = llhd.prb %status_txwm_qs : i1
    %238 = llhd.prb %status_txstall_qs : i1
    %239 = llhd.prb %status_txempty_qs : i1
    %240 = llhd.prb %status_txfull_qs : i1
    %241 = llhd.prb %status_active_qs : i1
    %242 = llhd.prb %status_ready_qs : i1
    %243 = llhd.prb %configopts_clkdiv_qs : i16
    %244 = llhd.prb %configopts_csnidle_qs : i4
    %245 = llhd.prb %configopts_csntrail_qs : i4
    %246 = llhd.prb %configopts_csnlead_qs : i4
    %247 = llhd.prb %configopts_fullcyc_qs : i1
    %248 = llhd.prb %configopts_cpha_qs : i1
    %249 = llhd.prb %configopts_cpol_qs : i1
    %250 = llhd.prb %csid_qs : i32
    %251 = llhd.prb %error_enable_cmdbusy_qs : i1
    %252 = llhd.prb %error_enable_overflow_qs : i1
    %253 = llhd.prb %error_enable_underflow_qs : i1
    %254 = llhd.prb %error_enable_cmdinval_qs : i1
    %255 = llhd.prb %error_enable_csidinval_qs : i1
    %256 = llhd.prb %error_status_cmdbusy_qs : i1
    %257 = llhd.prb %error_status_overflow_qs : i1
    %258 = llhd.prb %error_status_underflow_qs : i1
    %259 = llhd.prb %error_status_cmdinval_qs : i1
    %260 = llhd.prb %error_status_csidinval_qs : i1
    %261 = llhd.prb %error_status_accessinval_qs : i1
    %262 = llhd.prb %event_enable_rxfull_qs : i1
    %263 = llhd.prb %event_enable_txempty_qs : i1
    %264 = llhd.prb %event_enable_rxwm_qs : i1
    %265 = llhd.prb %event_enable_txwm_qs : i1
    %266 = llhd.prb %event_enable_ready_qs : i1
    %267 = llhd.prb %event_enable_idle_qs : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb26
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      %270 = llhd.prb %racl_addr_hit_read : i12
      %271 = comb.extract %270 from 0 : (i12) -> i1
      %272 = comb.icmp ceq %271, %true : i1
      cf.cond_br %272, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %273 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %274 = llhd.prb %intr_state_error_qs : i1
      llhd.drv %273, %274 after %1 : i1
      %275 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %276 = llhd.prb %intr_state_spi_event_qs : i1
      llhd.drv %275, %276 after %1 : i1
      cf.br ^bb26
    ^bb3:  // pred: ^bb1
      %277 = llhd.prb %racl_addr_hit_read : i12
      %278 = comb.extract %277 from 1 : (i12) -> i1
      %279 = comb.icmp ceq %278, %true : i1
      cf.cond_br %279, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %280 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %281 = llhd.prb %intr_enable_error_qs : i1
      llhd.drv %280, %281 after %1 : i1
      %282 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %283 = llhd.prb %intr_enable_spi_event_qs : i1
      llhd.drv %282, %283 after %1 : i1
      cf.br ^bb26
    ^bb5:  // pred: ^bb3
      %284 = llhd.prb %racl_addr_hit_read : i12
      %285 = comb.extract %284 from 2 : (i12) -> i1
      %286 = comb.icmp ceq %285, %true : i1
      cf.cond_br %286, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %287 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      llhd.drv %287, %false after %1 : i1
      %288 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      llhd.drv %288, %false after %1 : i1
      cf.br ^bb26
    ^bb7:  // pred: ^bb5
      %289 = llhd.prb %racl_addr_hit_read : i12
      %290 = comb.extract %289 from 3 : (i12) -> i1
      %291 = comb.icmp ceq %290, %true : i1
      cf.cond_br %291, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %292 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      llhd.drv %292, %false after %1 : i1
      cf.br ^bb26
    ^bb9:  // pred: ^bb7
      %293 = llhd.prb %racl_addr_hit_read : i12
      %294 = comb.extract %293 from 4 : (i12) -> i1
      %295 = comb.icmp ceq %294, %true : i1
      cf.cond_br %295, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %296 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i8>
      %297 = llhd.prb %control_rx_watermark_qs : i8
      llhd.drv %296, %297 after %1 : i8
      %298 = llhd.sig.extract %reg_rdata_next from %c8_i5 : <i32> -> <i8>
      %299 = llhd.prb %control_tx_watermark_qs : i8
      llhd.drv %298, %299 after %1 : i8
      %300 = llhd.sig.extract %reg_rdata_next from %c-3_i5 : <i32> -> <i1>
      %301 = llhd.prb %control_output_en_qs : i1
      llhd.drv %300, %301 after %1 : i1
      %302 = llhd.sig.extract %reg_rdata_next from %c-2_i5 : <i32> -> <i1>
      %303 = llhd.prb %control_sw_rst_qs : i1
      llhd.drv %302, %303 after %1 : i1
      %304 = llhd.sig.extract %reg_rdata_next from %c-1_i5 : <i32> -> <i1>
      %305 = llhd.prb %control_spien_qs : i1
      llhd.drv %304, %305 after %1 : i1
      cf.br ^bb26
    ^bb11:  // pred: ^bb9
      %306 = llhd.prb %racl_addr_hit_read : i12
      %307 = comb.extract %306 from 5 : (i12) -> i1
      %308 = comb.icmp ceq %307, %true : i1
      cf.cond_br %308, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %309 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i8>
      %310 = llhd.prb %status_txqd_qs : i8
      llhd.drv %309, %310 after %1 : i8
      %311 = llhd.sig.extract %reg_rdata_next from %c8_i5 : <i32> -> <i8>
      %312 = llhd.prb %status_rxqd_qs : i8
      llhd.drv %311, %312 after %1 : i8
      %313 = llhd.sig.extract %reg_rdata_next from %c-16_i5 : <i32> -> <i4>
      %314 = llhd.prb %status_cmdqd_qs : i4
      llhd.drv %313, %314 after %1 : i4
      %315 = llhd.sig.extract %reg_rdata_next from %c-12_i5 : <i32> -> <i1>
      %316 = llhd.prb %status_rxwm_qs : i1
      llhd.drv %315, %316 after %1 : i1
      %317 = llhd.sig.extract %reg_rdata_next from %c-10_i5 : <i32> -> <i1>
      %318 = llhd.prb %status_byteorder_qs : i1
      llhd.drv %317, %318 after %1 : i1
      %319 = llhd.sig.extract %reg_rdata_next from %c-9_i5 : <i32> -> <i1>
      %320 = llhd.prb %status_rxstall_qs : i1
      llhd.drv %319, %320 after %1 : i1
      %321 = llhd.sig.extract %reg_rdata_next from %c-8_i5 : <i32> -> <i1>
      %322 = llhd.prb %status_rxempty_qs : i1
      llhd.drv %321, %322 after %1 : i1
      %323 = llhd.sig.extract %reg_rdata_next from %c-7_i5 : <i32> -> <i1>
      %324 = llhd.prb %status_rxfull_qs : i1
      llhd.drv %323, %324 after %1 : i1
      %325 = llhd.sig.extract %reg_rdata_next from %c-6_i5 : <i32> -> <i1>
      %326 = llhd.prb %status_txwm_qs : i1
      llhd.drv %325, %326 after %1 : i1
      %327 = llhd.sig.extract %reg_rdata_next from %c-5_i5 : <i32> -> <i1>
      %328 = llhd.prb %status_txstall_qs : i1
      llhd.drv %327, %328 after %1 : i1
      %329 = llhd.sig.extract %reg_rdata_next from %c-4_i5 : <i32> -> <i1>
      %330 = llhd.prb %status_txempty_qs : i1
      llhd.drv %329, %330 after %1 : i1
      %331 = llhd.sig.extract %reg_rdata_next from %c-3_i5 : <i32> -> <i1>
      %332 = llhd.prb %status_txfull_qs : i1
      llhd.drv %331, %332 after %1 : i1
      %333 = llhd.sig.extract %reg_rdata_next from %c-2_i5 : <i32> -> <i1>
      %334 = llhd.prb %status_active_qs : i1
      llhd.drv %333, %334 after %1 : i1
      %335 = llhd.sig.extract %reg_rdata_next from %c-1_i5 : <i32> -> <i1>
      %336 = llhd.prb %status_ready_qs : i1
      llhd.drv %335, %336 after %1 : i1
      cf.br ^bb26
    ^bb13:  // pred: ^bb11
      %337 = llhd.prb %racl_addr_hit_read : i12
      %338 = comb.extract %337 from 6 : (i12) -> i1
      %339 = comb.icmp ceq %338, %true : i1
      cf.cond_br %339, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %340 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i16>
      %341 = llhd.prb %configopts_clkdiv_qs : i16
      llhd.drv %340, %341 after %1 : i16
      %342 = llhd.sig.extract %reg_rdata_next from %c-16_i5 : <i32> -> <i4>
      %343 = llhd.prb %configopts_csnidle_qs : i4
      llhd.drv %342, %343 after %1 : i4
      %344 = llhd.sig.extract %reg_rdata_next from %c-12_i5 : <i32> -> <i4>
      %345 = llhd.prb %configopts_csntrail_qs : i4
      llhd.drv %344, %345 after %1 : i4
      %346 = llhd.sig.extract %reg_rdata_next from %c-8_i5 : <i32> -> <i4>
      %347 = llhd.prb %configopts_csnlead_qs : i4
      llhd.drv %346, %347 after %1 : i4
      %348 = llhd.sig.extract %reg_rdata_next from %c-3_i5 : <i32> -> <i1>
      %349 = llhd.prb %configopts_fullcyc_qs : i1
      llhd.drv %348, %349 after %1 : i1
      %350 = llhd.sig.extract %reg_rdata_next from %c-2_i5 : <i32> -> <i1>
      %351 = llhd.prb %configopts_cpha_qs : i1
      llhd.drv %350, %351 after %1 : i1
      %352 = llhd.sig.extract %reg_rdata_next from %c-1_i5 : <i32> -> <i1>
      %353 = llhd.prb %configopts_cpol_qs : i1
      llhd.drv %352, %353 after %1 : i1
      cf.br ^bb26
    ^bb15:  // pred: ^bb13
      %354 = llhd.prb %racl_addr_hit_read : i12
      %355 = comb.extract %354 from 7 : (i12) -> i1
      %356 = comb.icmp ceq %355, %true : i1
      cf.cond_br %356, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      %357 = llhd.prb %csid_qs : i32
      llhd.drv %reg_rdata_next, %357 after %1 : i32
      cf.br ^bb26
    ^bb17:  // pred: ^bb15
      %358 = llhd.prb %racl_addr_hit_read : i12
      %359 = comb.extract %358 from 8 : (i12) -> i1
      %360 = comb.icmp ceq %359, %true : i1
      cf.cond_br %360, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      %361 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      llhd.drv %361, %false after %1 : i1
      %362 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i2>
      llhd.drv %362, %c0_i2 after %1 : i2
      %363 = llhd.sig.extract %reg_rdata_next from %c3_i5 : <i32> -> <i2>
      llhd.drv %363, %c0_i2 after %1 : i2
      %364 = llhd.sig.extract %reg_rdata_next from %c5_i5 : <i32> -> <i20>
      llhd.drv %364, %c0_i20 after %1 : i20
      cf.br ^bb26
    ^bb19:  // pred: ^bb17
      %365 = llhd.prb %racl_addr_hit_read : i12
      %366 = comb.extract %365 from 9 : (i12) -> i1
      %367 = comb.icmp ceq %366, %true : i1
      cf.cond_br %367, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      %368 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %369 = llhd.prb %error_enable_cmdbusy_qs : i1
      llhd.drv %368, %369 after %1 : i1
      %370 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %371 = llhd.prb %error_enable_overflow_qs : i1
      llhd.drv %370, %371 after %1 : i1
      %372 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %373 = llhd.prb %error_enable_underflow_qs : i1
      llhd.drv %372, %373 after %1 : i1
      %374 = llhd.sig.extract %reg_rdata_next from %c3_i5 : <i32> -> <i1>
      %375 = llhd.prb %error_enable_cmdinval_qs : i1
      llhd.drv %374, %375 after %1 : i1
      %376 = llhd.sig.extract %reg_rdata_next from %c4_i5 : <i32> -> <i1>
      %377 = llhd.prb %error_enable_csidinval_qs : i1
      llhd.drv %376, %377 after %1 : i1
      cf.br ^bb26
    ^bb21:  // pred: ^bb19
      %378 = llhd.prb %racl_addr_hit_read : i12
      %379 = comb.extract %378 from 10 : (i12) -> i1
      %380 = comb.icmp ceq %379, %true : i1
      cf.cond_br %380, ^bb22, ^bb23
    ^bb22:  // pred: ^bb21
      %381 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %382 = llhd.prb %error_status_cmdbusy_qs : i1
      llhd.drv %381, %382 after %1 : i1
      %383 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %384 = llhd.prb %error_status_overflow_qs : i1
      llhd.drv %383, %384 after %1 : i1
      %385 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %386 = llhd.prb %error_status_underflow_qs : i1
      llhd.drv %385, %386 after %1 : i1
      %387 = llhd.sig.extract %reg_rdata_next from %c3_i5 : <i32> -> <i1>
      %388 = llhd.prb %error_status_cmdinval_qs : i1
      llhd.drv %387, %388 after %1 : i1
      %389 = llhd.sig.extract %reg_rdata_next from %c4_i5 : <i32> -> <i1>
      %390 = llhd.prb %error_status_csidinval_qs : i1
      llhd.drv %389, %390 after %1 : i1
      %391 = llhd.sig.extract %reg_rdata_next from %c5_i5 : <i32> -> <i1>
      %392 = llhd.prb %error_status_accessinval_qs : i1
      llhd.drv %391, %392 after %1 : i1
      cf.br ^bb26
    ^bb23:  // pred: ^bb21
      %393 = llhd.prb %racl_addr_hit_read : i12
      %394 = comb.extract %393 from 11 : (i12) -> i1
      %395 = comb.icmp ceq %394, %true : i1
      cf.cond_br %395, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      %396 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %397 = llhd.prb %event_enable_rxfull_qs : i1
      llhd.drv %396, %397 after %1 : i1
      %398 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %399 = llhd.prb %event_enable_txempty_qs : i1
      llhd.drv %398, %399 after %1 : i1
      %400 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %401 = llhd.prb %event_enable_rxwm_qs : i1
      llhd.drv %400, %401 after %1 : i1
      %402 = llhd.sig.extract %reg_rdata_next from %c3_i5 : <i32> -> <i1>
      %403 = llhd.prb %event_enable_txwm_qs : i1
      llhd.drv %402, %403 after %1 : i1
      %404 = llhd.sig.extract %reg_rdata_next from %c4_i5 : <i32> -> <i1>
      %405 = llhd.prb %event_enable_ready_qs : i1
      llhd.drv %404, %405 after %1 : i1
      %406 = llhd.sig.extract %reg_rdata_next from %c5_i5 : <i32> -> <i1>
      %407 = llhd.prb %event_enable_idle_qs : i1
      llhd.drv %406, %407 after %1 : i1
      cf.br ^bb26
    ^bb25:  // pred: ^bb23
      llhd.drv %reg_rdata_next, %c-1_i32 after %1 : i32
      cf.br ^bb26
    ^bb26:  // 13 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb18, ^bb20, ^bb22, ^bb24, ^bb25
      llhd.wait (%140, %155, %220, %221, %222, %223, %224, %225, %226, %227, %228, %229, %230, %231, %232, %233, %234, %235, %236, %237, %238, %239, %240, %241, %242, %243, %244, %245, %246, %247, %248, %249, %250, %251, %252, %253, %254, %255, %256, %257, %258, %259, %260, %261, %262, %263, %264, %265, %266, %267 : i32, i12, i1, i1, i1, i1, i8, i8, i1, i1, i1, i8, i8, i4, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i16, i4, i4, i4, i1, i1, i1, i32, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %tl_i_2, %tl_i after %1 : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %268 = llhd.prb %tl_win_o : !hw.array<2xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>
    %269 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
    llhd.drv %racl_policies_i_3, %racl_policies_i after %1 : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    hw.output %u_rsp_intg_gen.tl_o, %268, %269, %17, %129 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.array<2xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>, !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>, !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, i1
  }
  hw.module private @spi_host_byte_select(in %clk_i : i1, in %rst_ni : i1, in %word_i : i32, in %word_be_i : i4, in %word_valid_i : i1, out word_ready_o : i1, out byte_o : i8, out byte_valid_o : i1, in %byte_ready_i : i1, in %flush_i : i1, in %sw_rst_i : i1) {
    %c27_i6 = hw.constant 27 : i6
    %c18_i6 = hw.constant 18 : i6
    %c9_i6 = hw.constant 9 : i6
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i6 = hw.constant 0 : i6
    %true = hw.constant true
    %c0_i36 = hw.constant 0 : i36
    %wdata_be = llhd.sig %c0_i36 : i36
    %1 = llhd.prb %wdata_be : i36
    %u_packer.wready_o, %u_packer.rvalid_o, %u_packer.rdata_o, %u_packer.depth_o = hw.instance "u_packer" @prim_packer_fifo_31(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clr_i: %4: i1, wvalid_i: %word_valid_i: i1, wdata_i: %1: i36, rready_i: %8: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i9, depth_o: i3) {sv.namehint = "byte_valid"}
    %2 = comb.extract %u_packer.rdata_o from 8 {sv.namehint = "byte_en"} : (i9) -> i1
    %3 = comb.extract %u_packer.rdata_o from 0 : (i9) -> i8
    %4 = comb.or %flush_i, %sw_rst_i {sv.namehint = "clr"} : i1
    %5 = comb.and %u_packer.rvalid_o, %2 : i1
    %6 = comb.xor %2, %true : i1
    %7 = comb.and %u_packer.rvalid_o, %6 {sv.namehint = "do_drain"} : i1
    %8 = comb.or %byte_ready_i, %7 {sv.namehint = "byte_ready"} : i1
    %9 = llhd.sig.extract %wdata_be from %c0_i6 : <i36> -> <i9>
    %10 = comb.extract %word_be_i from 0 : (i4) -> i1
    %11 = comb.extract %word_i from 0 : (i32) -> i8
    %12 = comb.concat %10, %11 : i1, i8
    llhd.drv %9, %12 after %0 : i9
    %13 = llhd.sig.extract %wdata_be from %c9_i6 : <i36> -> <i9>
    %14 = comb.extract %word_be_i from 1 : (i4) -> i1
    %15 = comb.extract %word_i from 8 : (i32) -> i8
    %16 = comb.concat %14, %15 : i1, i8
    llhd.drv %13, %16 after %0 : i9
    %17 = llhd.sig.extract %wdata_be from %c18_i6 : <i36> -> <i9>
    %18 = comb.extract %word_be_i from 2 : (i4) -> i1
    %19 = comb.extract %word_i from 16 : (i32) -> i8
    %20 = comb.concat %18, %19 : i1, i8
    llhd.drv %17, %20 after %0 : i9
    %21 = llhd.sig.extract %wdata_be from %c27_i6 : <i36> -> <i9>
    %22 = comb.extract %word_be_i from 3 : (i4) -> i1
    %23 = comb.extract %word_i from 24 : (i32) -> i8
    %24 = comb.concat %22, %23 : i1, i8
    llhd.drv %21, %24 after %0 : i9
    hw.output %u_packer.wready_o, %3, %5 : i1, i8, i1
  }
  hw.module private @spi_host_byte_merge(in %clk_i : i1, in %rst_ni : i1, in %byte_i : i8, in %byte_last_i : i1, in %byte_valid_i : i1, out byte_ready_o : i1, out word_o : i32, out word_valid_o : i1, in %word_ready_i : i1, in %sw_rst_i : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %true = hw.constant true
    %false = hw.constant false
    %c0_i8 = hw.constant 0 : i8
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %byte_i_2 = llhd.sig name "byte_i" %c0_i8 : i8
    %byte_last_i_3 = llhd.sig name "byte_last_i" %false : i1
    %word_valid_o = llhd.sig %false : i1
    %last_q = llhd.sig %false : i1
    %last_d = llhd.sig %false : i1
    %byte_incoming = llhd.sig %false : i1
    %4 = llhd.prb %byte_i_2 : i8
    %5 = comb.mux %18, %c0_i8, %4 : i8
    %u_packer.wready_o, %u_packer.rvalid_o, %u_packer.rdata_o, %u_packer.depth_o = hw.instance "u_packer" @prim_packer_fifo(clk_i: %2: i1, rst_ni: %3: i1, clr_i: %sw_rst_i: i1, wvalid_i: %19: i1, wdata_i: %5: i8, rready_i: %word_ready_i: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i32, depth_o: i3) {sv.namehint = "byte_ready"}
    llhd.drv %word_valid_o, %u_packer.rvalid_o after %1 : i1
    %6 = comb.and %byte_valid_i, %21 : i1
    llhd.drv %byte_incoming, %6 after %1 : i1
    %7 = llhd.prb %byte_incoming : i1
    %8 = llhd.prb %byte_last_i_3 : i1
    %9 = comb.and %7, %8 : i1
    %10 = llhd.prb %word_valid_o : i1
    %11 = llhd.prb %last_q : i1
    %12 = comb.xor %10, %true : i1
    %13 = comb.and %12, %11 : i1
    %14 = comb.or %9, %13 : i1
    %15 = comb.xor %sw_rst_i, %true : i1
    %16 = comb.and %15, %14 : i1
    llhd.drv %last_d, %16 after %1 : i1
    %17 = comb.xor %10, %true : i1
    %18 = comb.and %11, %17 {sv.namehint = "do_fill"} : i1
    %19 = comb.or %18, %byte_valid_i {sv.namehint = "byte_valid"} : i1
    %20 = comb.xor %18, %true : i1
    %21 = comb.and %u_packer.wready_o, %20 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %22 = llhd.prb %clk_i_0 : i1
      %23 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %24 = llhd.prb %clk_i_0 : i1
      %25 = comb.xor bin %22, %true : i1
      %26 = comb.and bin %25, %24 : i1
      %27 = llhd.prb %rst_ni_1 : i1
      %28 = comb.xor bin %27, %true : i1
      %29 = comb.and bin %23, %28 : i1
      %30 = comb.or bin %26, %29 : i1
      cf.cond_br %30, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %31 = llhd.prb %rst_ni_1 : i1
      %32 = comb.xor %31, %true : i1
      cf.cond_br %32, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %last_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %33 = llhd.prb %last_d : i1
      llhd.drv %last_q, %33 after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %byte_i_2, %byte_i after %1 : i8
    llhd.drv %byte_last_i_3, %byte_last_i after %1 : i1
    hw.output %21, %u_packer.rdata_o, %10 : i1, i32, i1
  }
  hw.module private @spi_host_command_queue(in %clk_i : i1, in %rst_ni : i1, in %command_i : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>, in %command_csid_i : i1, in %command_valid_i : i1, out command_busy_o : i1, out core_command_o : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>, out core_command_csid_o : i1, out core_command_valid_o : i1, in %core_command_ready_i : i1, out qd_o : i4, out error_busy_o : i1, in %sw_rst_i : i1) {
    %false = hw.constant false
    %true = hw.constant true
    %0 = hw.bitcast %command_i : (!hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>) -> i56
    %1 = comb.concat %0, %command_csid_i : i56, i1
    %cmd_fifo.wready_o, %cmd_fifo.rvalid_o, %cmd_fifo.rdata_o, %cmd_fifo.full_o, %cmd_fifo.depth_o, %cmd_fifo.err_o = hw.instance "cmd_fifo" @prim_fifo_sync(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clr_i: %sw_rst_i: i1, wvalid_i: %command_valid_i: i1, wdata_i: %1: i57, rready_i: %core_command_ready_i: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i57, full_o: i1, depth_o: i3, err_o: i1) {sv.namehint = "cmd_depth"}
    %2 = comb.extract %cmd_fifo.rdata_o from 1 : (i57) -> i56
    %3 = hw.bitcast %2 : (i56) -> !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
    %4 = comb.extract %cmd_fifo.rdata_o from 0 : (i57) -> i1
    %5 = comb.xor %cmd_fifo.wready_o, %true : i1
    %6 = comb.and %command_valid_i, %5 : i1
    %7 = comb.concat %false, %cmd_fifo.depth_o : i1, i3
    hw.output %5, %3, %4, %cmd_fifo.rvalid_o, %7, %6 : i1, !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>, i1, i1, i4, i1
  }
  hw.module private @spi_host_data_fifos(in %clk_i : i1, in %rst_ni : i1, in %tx_data_i : i32, in %tx_be_i : i4, in %tx_valid_i : i1, out tx_ready_o : i1, in %tx_watermark_i : i8, out core_tx_data_o : i32, out core_tx_be_o : i4, out core_tx_valid_o : i1, in %core_tx_ready_i : i1, in %core_tx_byte_select_full_i : i1, in %core_rx_data_i : i32, in %core_rx_valid_i : i1, out core_rx_ready_o : i1, out rx_data_o : i32, out rx_valid_o : i1, in %rx_ready_i : i1, in %rx_watermark_i : i8, in %sw_rst_i : i1, out tx_empty_o : i1, out tx_full_o : i1, out tx_qd_o : i8, out tx_wm_o : i1, out rx_empty_o : i1, out rx_full_o : i1, out rx_qd_o : i8, out rx_wm_o : i1) {
    %c72_i32 = hw.constant 72 : i32
    %c0_i8 = hw.constant 0 : i8
    %c0_i24 = hw.constant 0 : i24
    %false = hw.constant false
    %c0_i7 = hw.constant 0 : i7
    %u_tx_fifo.wready_o, %u_tx_fifo.rvalid_o, %u_tx_fifo.rdata_o, %u_tx_fifo.full_o, %u_tx_fifo.depth_o, %u_tx_fifo.err_o = hw.instance "u_tx_fifo" @prim_fifo_sync_14(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clr_i: %sw_rst_i: i1, wvalid_i: %tx_valid_i: i1, wdata_i: %3: i36, rready_i: %core_tx_ready_i: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i36, full_o: i1, depth_o: i7, err_o: i1) {sv.namehint = "tx_depth"}
    %u_rx_fifo.wready_o, %u_rx_fifo.rvalid_o, %u_rx_fifo.rdata_o, %u_rx_fifo.full_o, %u_rx_fifo.depth_o, %u_rx_fifo.err_o = hw.instance "u_rx_fifo" @prim_fifo_sync_15(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clr_i: %sw_rst_i: i1, wvalid_i: %core_rx_valid_i: i1, wdata_i: %core_rx_data_i: i32, rready_i: %rx_ready_i: i1) -> (wready_o: i1, rvalid_o: i1, rdata_o: i32, full_o: i1, depth_o: i7, err_o: i1) {sv.namehint = "rx_depth"}
    %0 = comb.concat %false, %u_tx_fifo.depth_o : i1, i7
    %1 = comb.concat %c0_i7, %core_tx_byte_select_full_i : i7, i1
    %2 = comb.add %0, %1 : i8
    %3 = comb.concat %tx_data_i, %tx_be_i {sv.namehint = "tx_data_be"} : i32, i4
    %4 = comb.extract %u_tx_fifo.rdata_o from 4 : (i36) -> i32
    %5 = comb.extract %u_tx_fifo.rdata_o from 0 : (i36) -> i4
    %6 = comb.concat %false, %u_rx_fifo.depth_o : i1, i7
    %7 = comb.concat %c0_i24, %2 : i24, i8
    %8 = comb.icmp eq %2, %c0_i8 : i8
    %9 = comb.icmp eq %u_rx_fifo.depth_o, %c0_i7 : i7
    %10 = comb.icmp ugt %7, %c72_i32 : i32
    %11 = comb.extract %u_rx_fifo.depth_o from 6 : (i7) -> i1
    %12 = comb.icmp ult %2, %tx_watermark_i : i8
    %13 = comb.icmp uge %6, %rx_watermark_i : i8
    hw.output %u_tx_fifo.wready_o, %4, %5, %u_tx_fifo.rvalid_o, %u_rx_fifo.wready_o, %u_rx_fifo.rdata_o, %u_rx_fifo.rvalid_o, %8, %10, %2, %12, %9, %11, %6, %13 : i1, i32, i4, i1, i1, i32, i1, i1, i1, i8, i1, i1, i1, i8, i1
  }
  hw.module private @spi_host_fsm(in %clk_i : i1, in %rst_ni : i1, in %en_i : i1, in %command_i : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>, in %command_csid_i : i1, in %command_valid_i : i1, out command_ready_o : i1, out sck_o : i1, out csb_o : i1, out sd_en_o : i4, out last_read_o : i1, out last_write_o : i1, out wr_en_o : i1, in %sr_wr_ready_i : i1, out rd_en_o : i1, in %sr_rd_ready_i : i1, out sample_en_o : i1, out shift_en_o : i1, out speed_o : i2, out full_cyc_o : i1, out rx_stall_o : i1, out tx_stall_o : i1, out active_o : i1, in %sw_rst_i : i1) {
    %c-1_i4 = hw.constant -1 : i4
    %c-1_i20 = hw.constant -1 : i20
    %c-1_i16 = hw.constant -1 : i16
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [[0 : i2, false, false, 0 : i20, false], [0 : i16, 0 : i4, 0 : i4, 0 : i4, false, false, false]] : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %c-3_i3 = hw.constant -3 : i3
    %true = hw.constant true
    %c2_i3 = hw.constant 2 : i3
    %c3_i3 = hw.constant 3 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c1_i3 = hw.constant 1 : i3
    %c-2_i3 = hw.constant -2 : i3
    %c-1_i3 = hw.constant -1 : i3
    %c0_i3 = hw.constant 0 : i3
    %c0_i20 = hw.constant 0 : i20
    %c0_i2 = hw.constant 0 : i2
    %c0_i16 = hw.constant 0 : i16
    %c0_i4 = hw.constant 0 : i4
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %command_i_2 = llhd.sig name "command_i" %2 : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
    %command_csid_i_3 = llhd.sig name "command_csid_i" %false : i1
    %command_valid_i_4 = llhd.sig name "command_valid_i" %false : i1
    %csb_o = llhd.sig %false : i1
    %sd_en_o = llhd.sig %c0_i4 : i4
    %speed_o = llhd.sig %c0_i2 : i2
    %sw_rst_i_5 = llhd.sig name "sw_rst_i" %false : i1
    %is_idle = llhd.sig %false : i1
    %clkdiv = llhd.sig %c0_i16 : i16
    %clkdiv_q = llhd.sig %c0_i16 : i16
    %clk_cntr_q = llhd.sig %c0_i16 : i16
    %clk_cntr_d = llhd.sig %c0_i16 : i16
    %clk_cntr_en = llhd.sig %false : i1
    %csid = llhd.sig %false : i1
    %csid_q = llhd.sig %false : i1
    %csnidle = llhd.sig %c0_i4 : i4
    %csntrail = llhd.sig %c0_i4 : i4
    %csnlead = llhd.sig %c0_i4 : i4
    %csnidle_q = llhd.sig %c0_i4 : i4
    %csntrail_q = llhd.sig %c0_i4 : i4
    %csnlead_q = llhd.sig %c0_i4 : i4
    %full_cyc = llhd.sig %false : i1
    %cpha = llhd.sig %false : i1
    %cpol = llhd.sig %false : i1
    %full_cyc_q = llhd.sig %false : i1
    %cpha_q = llhd.sig %false : i1
    %cpol_q = llhd.sig %false : i1
    %cmd_speed_d = llhd.sig %c0_i2 : i2
    %cmd_speed_q = llhd.sig %c0_i2 : i2
    %cmd_wr_en_d = llhd.sig %false : i1
    %cmd_wr_en_q = llhd.sig %false : i1
    %cmd_rd_en_d = llhd.sig %false : i1
    %cmd_rd_en_q = llhd.sig %false : i1
    %cmd_len_d = llhd.sig %c0_i20 : i20
    %cmd_len_q = llhd.sig %c0_i20 : i20
    %csaat = llhd.sig %false : i1
    %csaat_q = llhd.sig %false : i1
    %bit_cntr_d = llhd.sig %c0_i3 : i3
    %bit_cntr_q = llhd.sig %c0_i3 : i3
    %byte_cntr_cpha0_d = llhd.sig %c0_i20 : i20
    %byte_cntr_cpha1_d = llhd.sig %c0_i20 : i20
    %byte_cntr_cpha0_q = llhd.sig %c0_i20 : i20
    %byte_cntr_cpha1_q = llhd.sig %c0_i20 : i20
    %wait_cntr_d = llhd.sig %c0_i4 : i4
    %wait_cntr_q = llhd.sig %c0_i4 : i4
    %last_bit = llhd.sig %false : i1
    %last_byte = llhd.sig %false : i1
    %state_changing = llhd.sig %false : i1
    %byte_starting = llhd.sig %false : i1
    %byte_starting_cpha0 = llhd.sig %false : i1
    %byte_starting_cpha1 = llhd.sig %false : i1
    %bit_shifting = llhd.sig %false : i1
    %bit_shifting_cpha0 = llhd.sig %false : i1
    %bit_shifting_cpha1 = llhd.sig %false : i1
    %byte_ending = llhd.sig %false : i1
    %byte_ending_cpha0 = llhd.sig %false : i1
    %byte_ending_cpha1 = llhd.sig %false : i1
    %sample_en_d = llhd.sig %false : i1
    %sample_en_q = llhd.sig %false : i1
    %sample_en_q2 = llhd.sig %false : i1
    %config_changed = llhd.sig %false : i1
    %fsm_en = llhd.sig %false : i1
    %new_command = llhd.sig %false : i1
    %csb_single_d = llhd.sig %false : i1
    %csb_q = llhd.sig %false : i1
    %stall = llhd.sig %false : i1
    %state_q = llhd.sig %c0_i3 : i3
    %state_d = llhd.sig %c0_i3 : i3
    %command_ready_int = llhd.sig %false : i1
    %next_state_after_idle = llhd.sig %c0_i3 : i3
    %next_state_after_idle_csb_active = llhd.sig %c0_i3 : i3
    %command_ready_idle_csb_active = llhd.sig %false : i1
    %segment_rd_en_cpha0 = llhd.sig %false : i1
    %segment_rd_en_cpha1 = llhd.sig %false : i1
    %shift_size = llhd.sig %c0_i3 : i3
    %start_bit = llhd.sig %c0_i3 : i3
    %cmd_wr_en_last_bit = llhd.sig %false : i1
    %5 = llhd.prb %stall : i1
    %6 = comb.xor %5, %true : i1
    %u_sck_flop.q_o = hw.instance "u_sck_flop" @prim_flop_en(clk_i: %3: i1, rst_ni: %4: i1, en_i: %6: i1, d_i: %160: i1) -> (q_o: i1) {sv.namehint = "sck_q"}
    %7 = comb.or %73, %71 : i1
    llhd.drv %stall, %7 after %1 : i1
    %8 = comb.and %147, %6 : i1
    %9 = comb.and %149, %6 : i1
    %10 = comb.and %157, %6 : i1
    %11 = comb.and %129, %6 : i1
    %12 = llhd.prb %command_ready_int : i1
    %13 = comb.and %12, %6 : i1
    %14 = llhd.prb %command_valid_i_4 : i1
    %15 = comb.and %14, %12 : i1
    llhd.drv %new_command, %15 after %1 : i1
    %16 = llhd.prb %command_i_2 : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
    %configopts = hw.struct_extract %16["configopts"] : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
    %cpol_6 = hw.struct_extract %configopts["cpol"] : !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>
    %17 = llhd.prb %cpol_q : i1
    %18 = comb.icmp ne %cpol_6, %17 : i1
    %cpha_7 = hw.struct_extract %configopts["cpha"] : !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>
    %19 = llhd.prb %cpha_q : i1
    %20 = comb.icmp ne %cpha_7, %19 : i1
    %full_cyc_8 = hw.struct_extract %configopts["full_cyc"] : !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>
    %21 = llhd.prb %full_cyc_q : i1
    %22 = comb.icmp ne %full_cyc_8, %21 : i1
    %csnidle_9 = hw.struct_extract %configopts["csnidle"] : !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>
    %23 = llhd.prb %csnidle_q : i4
    %24 = comb.icmp ne %csnidle_9, %23 : i4
    %csntrail_10 = hw.struct_extract %configopts["csntrail"] : !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>
    %25 = llhd.prb %csntrail_q : i4
    %26 = comb.icmp ne %csntrail_10, %25 : i4
    %csnlead_11 = hw.struct_extract %configopts["csnlead"] : !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>
    %27 = llhd.prb %csnlead_q : i4
    %28 = comb.icmp ne %csnlead_11, %27 : i4
    %clkdiv_12 = hw.struct_extract %configopts["clkdiv"] : !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>
    %29 = llhd.prb %clkdiv_q : i16
    %30 = comb.icmp ne %clkdiv_12, %29 : i16
    %31 = comb.or %18, %20, %22, %24, %26, %28, %30 : i1
    llhd.drv %config_changed, %31 after %1 : i1
    %32 = llhd.prb %new_command : i1
    %33 = llhd.prb %command_csid_i_3 : i1
    %34 = llhd.prb %csid_q : i1
    %35 = llhd.prb %csid : i1
    %36 = llhd.prb %cpol : i1
    %37 = llhd.prb %cpha : i1
    %38 = llhd.prb %full_cyc : i1
    %39 = llhd.prb %csnidle : i4
    %40 = llhd.prb %csnlead : i4
    %41 = llhd.prb %csntrail : i4
    %42 = llhd.prb %clkdiv : i16
    %43 = llhd.prb %csaat_q : i1
    %44 = llhd.prb %csaat : i1
    %45 = llhd.prb %cmd_len_q : i20
    %46 = llhd.prb %cmd_len_d : i20
    %47 = llhd.prb %cmd_wr_en_q : i1
    %48 = llhd.prb %cmd_wr_en_d : i1
    %49 = llhd.prb %cmd_rd_en_q : i1
    %50 = llhd.prb %cmd_rd_en_d : i1
    %51 = llhd.prb %cmd_speed_q : i2
    %52 = llhd.prb %cmd_speed_d : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %166 = llhd.prb %new_command : i1
      %167 = llhd.prb %command_csid_i_3 : i1
      %168 = llhd.prb %csid_q : i1
      %169 = comb.mux %166, %167, %168 : i1
      llhd.drv %csid, %169 after %1 : i1
      %170 = llhd.prb %new_command : i1
      %171 = llhd.prb %command_i_2 : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
      %configopts_13 = hw.struct_extract %171["configopts"] : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
      %cpol_14 = hw.struct_extract %configopts_13["cpol"] : !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>
      %172 = llhd.prb %cpol_q : i1
      %173 = comb.mux %170, %cpol_14, %172 : i1
      llhd.drv %cpol, %173 after %1 : i1
      %174 = llhd.prb %new_command : i1
      %175 = llhd.prb %command_i_2 : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
      %configopts_15 = hw.struct_extract %175["configopts"] : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
      %cpha_16 = hw.struct_extract %configopts_15["cpha"] : !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>
      %176 = llhd.prb %cpha_q : i1
      %177 = comb.mux %174, %cpha_16, %176 : i1
      llhd.drv %cpha, %177 after %1 : i1
      %178 = llhd.prb %new_command : i1
      %179 = llhd.prb %command_i_2 : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
      %configopts_17 = hw.struct_extract %179["configopts"] : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
      %full_cyc_18 = hw.struct_extract %configopts_17["full_cyc"] : !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>
      %180 = llhd.prb %full_cyc_q : i1
      %181 = comb.mux %178, %full_cyc_18, %180 : i1
      llhd.drv %full_cyc, %181 after %1 : i1
      %182 = llhd.prb %new_command : i1
      %183 = llhd.prb %command_i_2 : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
      %configopts_19 = hw.struct_extract %183["configopts"] : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
      %csnidle_20 = hw.struct_extract %configopts_19["csnidle"] : !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>
      %184 = llhd.prb %csnidle_q : i4
      %185 = comb.mux %182, %csnidle_20, %184 : i4
      llhd.drv %csnidle, %185 after %1 : i4
      %186 = llhd.prb %new_command : i1
      %187 = llhd.prb %command_i_2 : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
      %configopts_21 = hw.struct_extract %187["configopts"] : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
      %csnlead_22 = hw.struct_extract %configopts_21["csnlead"] : !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>
      %188 = llhd.prb %csnlead_q : i4
      %189 = comb.mux %186, %csnlead_22, %188 : i4
      llhd.drv %csnlead, %189 after %1 : i4
      %190 = llhd.prb %new_command : i1
      %191 = llhd.prb %command_i_2 : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
      %configopts_23 = hw.struct_extract %191["configopts"] : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
      %csntrail_24 = hw.struct_extract %configopts_23["csntrail"] : !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>
      %192 = llhd.prb %csntrail_q : i4
      %193 = comb.mux %190, %csntrail_24, %192 : i4
      llhd.drv %csntrail, %193 after %1 : i4
      %194 = llhd.prb %new_command : i1
      %195 = llhd.prb %command_i_2 : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
      %configopts_25 = hw.struct_extract %195["configopts"] : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
      %clkdiv_26 = hw.struct_extract %configopts_25["clkdiv"] : !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>
      %196 = llhd.prb %clkdiv_q : i16
      %197 = comb.mux %194, %clkdiv_26, %196 : i16
      llhd.drv %clkdiv, %197 after %1 : i16
      %198 = llhd.prb %new_command : i1
      %199 = llhd.prb %command_i_2 : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
      %segment = hw.struct_extract %199["segment"] : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
      %csaat_27 = hw.struct_extract %segment["csaat"] : !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>
      %200 = llhd.prb %csaat_q : i1
      %201 = comb.mux %198, %csaat_27, %200 : i1
      llhd.drv %csaat, %201 after %1 : i1
      %202 = llhd.prb %new_command : i1
      %203 = llhd.prb %command_i_2 : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
      %segment_28 = hw.struct_extract %203["segment"] : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
      %len = hw.struct_extract %segment_28["len"] : !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>
      %204 = llhd.prb %cmd_len_q : i20
      %205 = comb.mux %202, %len, %204 : i20
      llhd.drv %cmd_len_d, %205 after %1 : i20
      %206 = llhd.prb %new_command : i1
      %207 = llhd.prb %command_i_2 : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
      %segment_29 = hw.struct_extract %207["segment"] : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
      %cmd_wr_en = hw.struct_extract %segment_29["cmd_wr_en"] : !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>
      %208 = llhd.prb %cmd_wr_en_q : i1
      %209 = comb.mux %206, %cmd_wr_en, %208 : i1
      llhd.drv %cmd_wr_en_d, %209 after %1 : i1
      %210 = llhd.prb %new_command : i1
      %211 = llhd.prb %command_i_2 : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
      %segment_30 = hw.struct_extract %211["segment"] : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
      %cmd_rd_en = hw.struct_extract %segment_30["cmd_rd_en"] : !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>
      %212 = llhd.prb %cmd_rd_en_q : i1
      %213 = comb.mux %210, %cmd_rd_en, %212 : i1
      llhd.drv %cmd_rd_en_d, %213 after %1 : i1
      %214 = llhd.prb %new_command : i1
      %215 = llhd.prb %command_i_2 : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
      %segment_31 = hw.struct_extract %215["segment"] : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
      %speed = hw.struct_extract %segment_31["speed"] : !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>
      %216 = llhd.prb %cmd_speed_q : i2
      %217 = comb.mux %214, %speed, %216 : i2
      llhd.drv %cmd_speed_d, %217 after %1 : i2
      llhd.wait (%32, %33, %34, %35, %16, %17, %36, %19, %37, %21, %38, %23, %39, %27, %40, %25, %41, %29, %42, %43, %44, %45, %46, %47, %48, %49, %50, %51, %52 : i1, i1, i1, i1, !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>, i1, i1, i1, i1, i1, i1, i4, i4, i4, i4, i4, i4, i16, i16, i1, i1, i20, i20, i1, i1, i1, i1, i2, i2), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %166 = llhd.prb %clk_i_0 : i1
      %167 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %168 = llhd.prb %clk_i_0 : i1
      %169 = comb.xor bin %166, %true : i1
      %170 = comb.and bin %169, %168 : i1
      %171 = llhd.prb %rst_ni_1 : i1
      %172 = comb.xor bin %171, %true : i1
      %173 = comb.and bin %167, %172 : i1
      %174 = comb.or bin %170, %173 : i1
      cf.cond_br %174, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %175 = llhd.prb %rst_ni_1 : i1
      %176 = comb.xor %175, %true : i1
      cf.cond_br %176, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %csid_q, %false after %0 : i1
      llhd.drv %cpol_q, %false after %0 : i1
      llhd.drv %cpha_q, %false after %0 : i1
      llhd.drv %full_cyc_q, %false after %0 : i1
      llhd.drv %csnidle_q, %c0_i4 after %0 : i4
      llhd.drv %csnlead_q, %c0_i4 after %0 : i4
      llhd.drv %csntrail_q, %c0_i4 after %0 : i4
      llhd.drv %clkdiv_q, %c0_i16 after %0 : i16
      llhd.drv %csaat_q, %false after %0 : i1
      llhd.drv %cmd_rd_en_q, %false after %0 : i1
      llhd.drv %cmd_wr_en_q, %false after %0 : i1
      llhd.drv %cmd_speed_q, %c0_i2 after %0 : i2
      llhd.drv %cmd_len_q, %c0_i20 after %0 : i20
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %177 = llhd.prb %new_command : i1
      %178 = llhd.prb %stall : i1
      %179 = comb.xor %178, %true : i1
      %180 = comb.and %177, %179 : i1
      %181 = llhd.prb %csid : i1
      %182 = llhd.prb %csid_q : i1
      %183 = comb.mux %180, %181, %182 : i1
      llhd.drv %csid_q, %183 after %0 : i1
      %184 = llhd.prb %new_command : i1
      %185 = llhd.prb %stall : i1
      %186 = comb.xor %185, %true : i1
      %187 = comb.and %184, %186 : i1
      %188 = llhd.prb %cpol : i1
      %189 = llhd.prb %cpol_q : i1
      %190 = comb.mux %187, %188, %189 : i1
      llhd.drv %cpol_q, %190 after %0 : i1
      %191 = llhd.prb %new_command : i1
      %192 = llhd.prb %stall : i1
      %193 = comb.xor %192, %true : i1
      %194 = comb.and %191, %193 : i1
      %195 = llhd.prb %cpha : i1
      %196 = llhd.prb %cpha_q : i1
      %197 = comb.mux %194, %195, %196 : i1
      llhd.drv %cpha_q, %197 after %0 : i1
      %198 = llhd.prb %new_command : i1
      %199 = llhd.prb %stall : i1
      %200 = comb.xor %199, %true : i1
      %201 = comb.and %198, %200 : i1
      %202 = llhd.prb %full_cyc : i1
      %203 = llhd.prb %full_cyc_q : i1
      %204 = comb.mux %201, %202, %203 : i1
      llhd.drv %full_cyc_q, %204 after %0 : i1
      %205 = llhd.prb %new_command : i1
      %206 = llhd.prb %stall : i1
      %207 = comb.xor %206, %true : i1
      %208 = comb.and %205, %207 : i1
      %209 = llhd.prb %csnidle : i4
      %210 = llhd.prb %csnidle_q : i4
      %211 = comb.mux %208, %209, %210 : i4
      llhd.drv %csnidle_q, %211 after %0 : i4
      %212 = llhd.prb %new_command : i1
      %213 = llhd.prb %stall : i1
      %214 = comb.xor %213, %true : i1
      %215 = comb.and %212, %214 : i1
      %216 = llhd.prb %csnlead : i4
      %217 = llhd.prb %csnlead_q : i4
      %218 = comb.mux %215, %216, %217 : i4
      llhd.drv %csnlead_q, %218 after %0 : i4
      %219 = llhd.prb %new_command : i1
      %220 = llhd.prb %stall : i1
      %221 = comb.xor %220, %true : i1
      %222 = comb.and %219, %221 : i1
      %223 = llhd.prb %csntrail : i4
      %224 = llhd.prb %csntrail_q : i4
      %225 = comb.mux %222, %223, %224 : i4
      llhd.drv %csntrail_q, %225 after %0 : i4
      %226 = llhd.prb %new_command : i1
      %227 = llhd.prb %stall : i1
      %228 = comb.xor %227, %true : i1
      %229 = comb.and %226, %228 : i1
      %230 = llhd.prb %clkdiv : i16
      %231 = llhd.prb %clkdiv_q : i16
      %232 = comb.mux %229, %230, %231 : i16
      llhd.drv %clkdiv_q, %232 after %0 : i16
      %233 = llhd.prb %new_command : i1
      %234 = llhd.prb %stall : i1
      %235 = comb.xor %234, %true : i1
      %236 = comb.and %233, %235 : i1
      %237 = llhd.prb %csaat : i1
      %238 = llhd.prb %csaat_q : i1
      %239 = comb.mux %236, %237, %238 : i1
      llhd.drv %csaat_q, %239 after %0 : i1
      %240 = llhd.prb %new_command : i1
      %241 = llhd.prb %stall : i1
      %242 = comb.xor %241, %true : i1
      %243 = comb.and %240, %242 : i1
      %244 = llhd.prb %cmd_wr_en_d : i1
      %245 = llhd.prb %cmd_wr_en_q : i1
      %246 = comb.mux %243, %244, %245 : i1
      llhd.drv %cmd_wr_en_q, %246 after %0 : i1
      %247 = llhd.prb %new_command : i1
      %248 = llhd.prb %stall : i1
      %249 = comb.xor %248, %true : i1
      %250 = comb.and %247, %249 : i1
      %251 = llhd.prb %cmd_rd_en_d : i1
      %252 = llhd.prb %cmd_rd_en_q : i1
      %253 = comb.mux %250, %251, %252 : i1
      llhd.drv %cmd_rd_en_q, %253 after %0 : i1
      %254 = llhd.prb %new_command : i1
      %255 = llhd.prb %stall : i1
      %256 = comb.xor %255, %true : i1
      %257 = comb.and %254, %256 : i1
      %258 = llhd.prb %cmd_speed_d : i2
      %259 = llhd.prb %cmd_speed_q : i2
      %260 = comb.mux %257, %258, %259 : i2
      llhd.drv %cmd_speed_q, %260 after %0 : i2
      %261 = llhd.prb %new_command : i1
      %262 = llhd.prb %stall : i1
      %263 = comb.xor %262, %true : i1
      %264 = comb.and %261, %263 : i1
      %265 = llhd.prb %cmd_len_d : i20
      %266 = llhd.prb %cmd_len_q : i20
      %267 = comb.mux %264, %265, %266 : i20
      llhd.drv %cmd_len_q, %267 after %0 : i20
      cf.br ^bb1
    }
    %53 = llhd.prb %state_q : i3
    %54 = comb.icmp eq %53, %c0_i3 : i3
    %55 = comb.icmp eq %53, %c-1_i3 : i3
    %56 = comb.or %54, %55 : i1
    llhd.drv %is_idle, %56 after %1 : i1
    %57 = llhd.prb %is_idle : i1
    %58 = comb.xor %57, %true : i1
    %59 = llhd.prb %sw_rst_i_5 : i1
    %60 = llhd.prb %clk_cntr_en : i1
    %61 = comb.xor %60, %true : i1
    %62 = llhd.prb %clk_cntr_q : i16
    %63 = comb.icmp eq %62, %c0_i16 : i16
    %64 = comb.add %62, %c-1_i16 : i16
    %65 = comb.mux %63, %42, %64 : i16
    %66 = comb.mux %57, %62, %65 : i16
    %67 = comb.mux %32, %42, %66 : i16
    %68 = comb.mux %61, %62, %67 : i16
    %69 = comb.mux %59, %c0_i16, %68 : i16
    llhd.drv %clk_cntr_d, %69 after %1 : i16
    %70 = comb.xor %sr_wr_ready_i, %true : i1
    %71 = comb.and %147, %70 : i1
    %72 = comb.xor %sr_rd_ready_i, %true : i1
    %73 = comb.and %149, %72 : i1
    llhd.drv %clk_cntr_en, %en_i after %1 : i1
    %74 = comb.icmp eq %62, %c0_i16 : i16
    %75 = comb.or %74, %57 : i1
    %76 = comb.and %60, %75 : i1
    llhd.drv %fsm_en, %76 after %1 : i1
    %77 = llhd.prb %config_changed : i1
    %78 = llhd.prb %next_state_after_idle : i3
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      %166 = llhd.prb %command_valid_i_4 : i1
      cf.cond_br %166, ^bb2, ^bb5
    ^bb2:  // pred: ^bb1
      %167 = llhd.prb %config_changed : i1
      cf.cond_br %167, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %next_state_after_idle, %c-2_i3 after %1 : i3
      cf.br ^bb6
    ^bb4:  // pred: ^bb2
      llhd.drv %next_state_after_idle, %c1_i3 after %1 : i3
      cf.br ^bb6
    ^bb5:  // pred: ^bb1
      llhd.drv %next_state_after_idle, %c0_i3 after %1 : i3
      cf.br ^bb6
    ^bb6:  // 3 preds: ^bb3, ^bb4, ^bb5
      llhd.wait (%14, %77, %78 : i1, i1, i3), ^bb1
    }
    %79 = llhd.prb %next_state_after_idle_csb_active : i3
    %80 = llhd.prb %command_ready_idle_csb_active : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb9
      %166 = llhd.prb %command_valid_i_4 : i1
      cf.cond_br %166, ^bb2, ^bb8
    ^bb2:  // pred: ^bb1
      %167 = llhd.prb %command_csid_i_3 : i1
      %168 = llhd.prb %csid_q : i1
      %169 = comb.icmp ne %167, %168 : i1
      cf.cond_br %169, ^bb3, ^bb4
    ^bb3:  // pred: ^bb2
      llhd.drv %next_state_after_idle_csb_active, %c-4_i3 after %1 : i3
      llhd.drv %command_ready_idle_csb_active, %false after %1 : i1
      cf.br ^bb9
    ^bb4:  // pred: ^bb2
      %170 = llhd.prb %cpha_q : i1
      cf.cond_br %170, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      llhd.drv %next_state_after_idle_csb_active, %c3_i3 after %1 : i3
      cf.br ^bb7
    ^bb6:  // pred: ^bb4
      llhd.drv %next_state_after_idle_csb_active, %c2_i3 after %1 : i3
      cf.br ^bb7
    ^bb7:  // 2 preds: ^bb5, ^bb6
      llhd.drv %command_ready_idle_csb_active, %true after %1 : i1
      cf.br ^bb9
    ^bb8:  // pred: ^bb1
      llhd.drv %next_state_after_idle_csb_active, %c-1_i3 after %1 : i3
      llhd.drv %command_ready_idle_csb_active, %true after %1 : i1
      cf.br ^bb9
    ^bb9:  // 3 preds: ^bb3, ^bb7, ^bb8
      llhd.wait (%14, %33, %34, %79, %80, %19 : i1, i1, i1, i3, i1, i1), ^bb1
    }
    %81 = llhd.prb %state_d : i3
    %82 = llhd.prb %fsm_en : i1
    %83 = llhd.prb %wait_cntr_q : i4
    %84 = llhd.prb %last_bit : i1
    %85 = llhd.prb %last_byte : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb32
      %166 = llhd.prb %state_q : i3
      llhd.drv %state_d, %166 after %1 : i3
      llhd.drv %command_ready_int, %false after %1 : i1
      %167 = llhd.prb %sw_rst_i_5 : i1
      cf.cond_br %167, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      llhd.drv %state_d, %c0_i3 after %1 : i3
      cf.br ^bb32
    ^bb3:  // pred: ^bb1
      %168 = llhd.prb %fsm_en : i1
      cf.cond_br %168, ^bb4, ^bb32
    ^bb4:  // pred: ^bb3
      %169 = llhd.prb %state_q : i3
      %170 = comb.icmp ceq %169, %c0_i3 : i3
      cf.cond_br %170, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      llhd.drv %command_ready_int, %true after %1 : i1
      %171 = llhd.prb %next_state_after_idle : i3
      llhd.drv %state_d, %171 after %1 : i3
      cf.br ^bb32
    ^bb6:  // pred: ^bb4
      %172 = comb.icmp ceq %169, %c1_i3 : i3
      cf.cond_br %172, ^bb7, ^bb9
    ^bb7:  // pred: ^bb6
      %173 = llhd.prb %wait_cntr_q : i4
      %174 = comb.icmp eq %173, %c0_i4 : i4
      cf.cond_br %174, ^bb8, ^bb32
    ^bb8:  // pred: ^bb7
      llhd.drv %state_d, %c3_i3 after %1 : i3
      cf.br ^bb32
    ^bb9:  // pred: ^bb6
      %175 = comb.icmp ceq %169, %c2_i3 : i3
      cf.cond_br %175, ^bb10, ^bb15
    ^bb10:  // pred: ^bb9
      %176 = llhd.prb %last_bit : i1
      %177 = comb.xor %176, %true : i1
      %178 = llhd.prb %last_byte : i1
      %179 = comb.xor %178, %true : i1
      %180 = llhd.prb %cpha_q : i1
      %181 = comb.xor %180, %true : i1
      %182 = comb.or %177, %179, %181 : i1
      cf.cond_br %182, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      llhd.drv %state_d, %c3_i3 after %1 : i3
      cf.br ^bb32
    ^bb12:  // pred: ^bb10
      %183 = llhd.prb %csaat_q : i1
      %184 = comb.xor %183, %true : i1
      cf.cond_br %184, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      llhd.drv %state_d, %c-4_i3 after %1 : i3
      cf.br ^bb32
    ^bb14:  // pred: ^bb12
      %185 = llhd.prb %next_state_after_idle_csb_active : i3
      llhd.drv %state_d, %185 after %1 : i3
      %186 = llhd.prb %command_ready_idle_csb_active : i1
      llhd.drv %command_ready_int, %186 after %1 : i1
      cf.br ^bb32
    ^bb15:  // pred: ^bb9
      %187 = comb.icmp ceq %169, %c3_i3 : i3
      cf.cond_br %187, ^bb16, ^bb21
    ^bb16:  // pred: ^bb15
      %188 = llhd.prb %last_bit : i1
      %189 = comb.xor %188, %true : i1
      %190 = llhd.prb %last_byte : i1
      %191 = comb.xor %190, %true : i1
      %192 = llhd.prb %cpha_q : i1
      %193 = comb.or %189, %191, %192 : i1
      cf.cond_br %193, ^bb17, ^bb18
    ^bb17:  // pred: ^bb16
      llhd.drv %state_d, %c2_i3 after %1 : i3
      cf.br ^bb32
    ^bb18:  // pred: ^bb16
      %194 = llhd.prb %csaat_q : i1
      %195 = comb.xor %194, %true : i1
      cf.cond_br %195, ^bb19, ^bb20
    ^bb19:  // pred: ^bb18
      llhd.drv %state_d, %c-4_i3 after %1 : i3
      cf.br ^bb32
    ^bb20:  // pred: ^bb18
      %196 = llhd.prb %next_state_after_idle_csb_active : i3
      llhd.drv %state_d, %196 after %1 : i3
      %197 = llhd.prb %command_ready_idle_csb_active : i1
      llhd.drv %command_ready_int, %197 after %1 : i1
      cf.br ^bb32
    ^bb21:  // pred: ^bb15
      %198 = comb.icmp ceq %169, %c-4_i3 : i3
      cf.cond_br %198, ^bb22, ^bb24
    ^bb22:  // pred: ^bb21
      %199 = llhd.prb %wait_cntr_q : i4
      %200 = comb.icmp eq %199, %c0_i4 : i4
      cf.cond_br %200, ^bb23, ^bb32
    ^bb23:  // pred: ^bb22
      llhd.drv %state_d, %c-3_i3 after %1 : i3
      cf.br ^bb32
    ^bb24:  // pred: ^bb21
      %201 = comb.icmp ceq %169, %c-3_i3 : i3
      cf.cond_br %201, ^bb25, ^bb27
    ^bb25:  // pred: ^bb24
      %202 = llhd.prb %wait_cntr_q : i4
      %203 = comb.icmp eq %202, %c0_i4 : i4
      cf.cond_br %203, ^bb26, ^bb32
    ^bb26:  // pred: ^bb25
      llhd.drv %command_ready_int, %true after %1 : i1
      %204 = llhd.prb %next_state_after_idle : i3
      llhd.drv %state_d, %204 after %1 : i3
      cf.br ^bb32
    ^bb27:  // pred: ^bb24
      %205 = comb.icmp ceq %169, %c-2_i3 : i3
      cf.cond_br %205, ^bb28, ^bb31
    ^bb28:  // pred: ^bb27
      %206 = llhd.prb %wait_cntr_q : i4
      %207 = comb.icmp eq %206, %c0_i4 : i4
      cf.cond_br %207, ^bb29, ^bb30
    ^bb29:  // pred: ^bb28
      llhd.drv %state_d, %c1_i3 after %1 : i3
      cf.br ^bb32
    ^bb30:  // pred: ^bb28
      llhd.drv %state_d, %c-2_i3 after %1 : i3
      cf.br ^bb32
    ^bb31:  // pred: ^bb27
      %208 = llhd.prb %next_state_after_idle_csb_active : i3
      llhd.drv %state_d, %208 after %1 : i3
      %209 = llhd.prb %command_ready_idle_csb_active : i1
      llhd.drv %command_ready_int, %209 after %1 : i1
      cf.br ^bb32
    ^bb32:  // 18 preds: ^bb2, ^bb3, ^bb5, ^bb7, ^bb8, ^bb11, ^bb13, ^bb14, ^bb17, ^bb19, ^bb20, ^bb22, ^bb23, ^bb25, ^bb26, ^bb29, ^bb30, ^bb31
      llhd.wait (%53, %81, %12, %59, %82, %78, %83, %84, %85, %19, %43, %79, %80 : i3, i3, i1, i1, i1, i3, i4, i1, i1, i1, i1, i3, i1), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %166 = llhd.prb %clk_i_0 : i1
      %167 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %168 = llhd.prb %clk_i_0 : i1
      %169 = comb.xor bin %166, %true : i1
      %170 = comb.and bin %169, %168 : i1
      %171 = llhd.prb %rst_ni_1 : i1
      %172 = comb.xor bin %171, %true : i1
      %173 = comb.and bin %167, %172 : i1
      %174 = comb.or bin %170, %173 : i1
      cf.cond_br %174, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %175 = llhd.prb %rst_ni_1 : i1
      %176 = comb.xor %175, %true : i1
      cf.cond_br %176, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %state_q, %c0_i3 after %0 : i3
      llhd.drv %clk_cntr_q, %c0_i16 after %0 : i16
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %177 = llhd.prb %stall : i1
      %178 = llhd.prb %state_q : i3
      %179 = llhd.prb %state_d : i3
      %180 = comb.mux %177, %178, %179 : i3
      llhd.drv %state_q, %180 after %0 : i3
      %181 = llhd.prb %stall : i1
      %182 = llhd.prb %clk_cntr_q : i16
      %183 = llhd.prb %clk_cntr_d : i16
      %184 = comb.mux %181, %182, %183 : i16
      llhd.drv %clk_cntr_q, %184 after %0 : i16
      cf.br ^bb1
    }
    %86 = comb.icmp ne %53, %81 : i3
    llhd.drv %state_changing, %86 after %1 : i1
    %87 = comb.xor %59, %true : i1
    %88 = llhd.prb %state_changing : i1
    %89 = comb.and %87, %88 : i1
    %90 = comb.icmp eq %81, %c1_i3 : i3
    %91 = comb.icmp eq %81, %c2_i3 : i3
    %92 = llhd.prb %bit_cntr_q : i3
    %93 = comb.icmp eq %92, %c0_i3 : i3
    %94 = comb.and %91, %93 : i1
    %95 = comb.or %90, %94 : i1
    %96 = comb.and %89, %95 : i1
    llhd.drv %byte_starting_cpha0, %96 after %1 : i1
    %97 = comb.icmp ne %92, %c0_i3 : i3
    %98 = comb.and %89, %91, %97 : i1
    llhd.drv %bit_shifting_cpha0, %98 after %1 : i1
    %99 = comb.icmp eq %53, %c3_i3 : i3
    %100 = comb.and %89, %99, %93 : i1
    llhd.drv %byte_ending_cpha0, %100 after %1 : i1
    llhd.drv %segment_rd_en_cpha0, %49 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %166 = llhd.prb %clk_i_0 : i1
      %167 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %168 = llhd.prb %clk_i_0 : i1
      %169 = comb.xor bin %166, %true : i1
      %170 = comb.and bin %169, %168 : i1
      %171 = llhd.prb %rst_ni_1 : i1
      %172 = comb.xor bin %171, %true : i1
      %173 = comb.and bin %167, %172 : i1
      %174 = comb.or bin %170, %173 : i1
      cf.cond_br %174, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %175 = llhd.prb %rst_ni_1 : i1
      %176 = comb.xor %175, %true : i1
      cf.cond_br %176, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %segment_rd_en_cpha1, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %177 = llhd.prb %state_changing : i1
      %178 = llhd.prb %stall : i1
      %179 = comb.xor %178, %true : i1
      %180 = comb.and %177, %179 : i1
      cf.cond_br %180, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %181 = llhd.prb %segment_rd_en_cpha0 : i1
      llhd.drv %segment_rd_en_cpha1, %181 after %0 : i1
      cf.br ^bb1
    }
    %101 = comb.icmp eq %81, %c3_i3 : i3
    %102 = comb.and %89, %101, %93 : i1
    llhd.drv %byte_starting_cpha1, %102 after %1 : i1
    %103 = comb.and %89, %101, %97 : i1
    llhd.drv %bit_shifting_cpha1, %103 after %1 : i1
    %104 = comb.icmp eq %53, %c2_i3 : i3
    %105 = comb.and %89, %104, %93 : i1
    llhd.drv %byte_ending_cpha1, %105 after %1 : i1
    %106 = comb.xor %37, %true : i1
    %107 = llhd.prb %byte_starting_cpha0 : i1
    %108 = llhd.prb %byte_starting_cpha1 : i1
    %109 = comb.mux %106, %107, %108 : i1
    llhd.drv %byte_starting, %109 after %1 : i1
    %110 = llhd.prb %byte_ending_cpha0 : i1
    %111 = llhd.prb %byte_ending_cpha1 : i1
    %112 = comb.mux %106, %110, %111 : i1
    llhd.drv %byte_ending, %112 after %1 : i1
    %113 = llhd.prb %bit_shifting_cpha0 : i1
    %114 = llhd.prb %bit_shifting_cpha1 : i1
    %115 = comb.mux %106, %113, %114 : i1
    llhd.drv %bit_shifting, %115 after %1 : i1
    llhd.drv %speed_o, %51 after %1 : i2
    %116 = llhd.prb %segment_rd_en_cpha0 : i1
    %117 = llhd.prb %segment_rd_en_cpha1 : i1
    %118 = comb.mux %106, %116, %117 {sv.namehint = "segment_rd_en"} : i1
    %119 = llhd.prb %byte_cntr_cpha0_d : i20
    %120 = llhd.prb %byte_cntr_cpha1_d : i20
    %121 = comb.mux %106, %119, %120 {sv.namehint = "byte_cntr_early"} : i20
    %122 = llhd.prb %byte_cntr_cpha0_q : i20
    %123 = llhd.prb %byte_cntr_cpha1_q : i20
    %124 = comb.mux %106, %122, %123 {sv.namehint = "byte_cntr_late"} : i20
    %125 = llhd.prb %shift_size : i3
    %126 = llhd.prb %start_bit : i3
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb10
      %166 = llhd.prb %cmd_rd_en_d : i1
      %167 = comb.xor %166, %true : i1
      %168 = llhd.prb %cmd_wr_en_d : i1
      %169 = comb.xor %168, %true : i1
      %170 = comb.and %167, %169 : i1
      cf.cond_br %170, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      llhd.drv %shift_size, %c0_i3 after %1 : i3
      llhd.drv %start_bit, %c0_i3 after %1 : i3
      cf.br ^bb10
    ^bb3:  // pred: ^bb1
      %171 = llhd.prb %cmd_speed_d : i2
      %172 = comb.icmp ceq %171, %c0_i2 : i2
      cf.cond_br %172, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %shift_size, %c1_i3 after %1 : i3
      llhd.drv %start_bit, %c-1_i3 after %1 : i3
      cf.br ^bb10
    ^bb5:  // pred: ^bb3
      %173 = comb.icmp ceq %171, %c1_i2 : i2
      cf.cond_br %173, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %shift_size, %c2_i3 after %1 : i3
      llhd.drv %start_bit, %c-2_i3 after %1 : i3
      cf.br ^bb10
    ^bb7:  // pred: ^bb5
      %174 = comb.icmp ceq %171, %c-2_i2 : i2
      cf.cond_br %174, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %shift_size, %c-4_i3 after %1 : i3
      llhd.drv %start_bit, %c-4_i3 after %1 : i3
      cf.br ^bb10
    ^bb9:  // pred: ^bb7
      llhd.drv %shift_size, %c1_i3 after %1 : i3
      llhd.drv %start_bit, %c1_i3 after %1 : i3
      cf.br ^bb10
    ^bb10:  // 5 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb9
      llhd.wait (%50, %48, %125, %126, %52 : i1, i1, i3, i3, i2), ^bb1
    }
    %127 = comb.xor %82, %true : i1
    %128 = llhd.prb %byte_starting : i1
    %129 = llhd.prb %bit_shifting {sv.namehint = "shift_en_internal"} : i1
    %130 = comb.sub %92, %125 : i3
    %131 = comb.mux %129, %130, %92 : i3
    %132 = comb.mux %128, %126, %131 : i3
    %133 = comb.mux %127, %92, %132 : i3
    %134 = comb.mux %59, %c0_i3, %133 : i3
    llhd.drv %bit_cntr_d, %134 after %1 : i3
    %135 = comb.icmp eq %92, %c0_i3 : i3
    llhd.drv %last_bit, %135 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb4
      %166 = llhd.prb %cpha_q : i1
      cf.cond_br %166, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %167 = llhd.prb %byte_cntr_cpha1_q : i20
      %168 = comb.icmp eq %167, %c0_i20 : i20
      llhd.drv %last_byte, %168 after %1 : i1
      cf.br ^bb4
    ^bb3:  // pred: ^bb1
      %169 = llhd.prb %byte_cntr_cpha0_q : i20
      %170 = comb.icmp eq %169, %c0_i20 : i20
      llhd.drv %last_byte, %170 after %1 : i1
      cf.br ^bb4
    ^bb4:  // 2 preds: ^bb2, ^bb3
      llhd.wait (%19, %123, %85, %122 : i1, i20, i1, i20), ^bb1
    }
    %136 = comb.add %122, %c-1_i20 : i20
    %137 = comb.mux %110, %136, %122 : i20
    %138 = comb.mux %32, %46, %137 : i20
    %139 = comb.mux %127, %122, %138 : i20
    %140 = comb.mux %59, %c0_i20, %139 : i20
    llhd.drv %byte_cntr_cpha0_d, %140 after %1 : i20
    %141 = comb.add %123, %c-1_i20 : i20
    %142 = comb.mux %111, %141, %123 : i20
    %143 = comb.mux %32, %46, %142 : i20
    %144 = comb.mux %127, %123, %143 : i20
    %145 = comb.mux %59, %c0_i20, %144 : i20
    llhd.drv %byte_cntr_cpha1_d, %145 after %1 : i20
    %146 = llhd.prb %wait_cntr_d : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb18
      %166 = llhd.prb %sw_rst_i_5 : i1
      cf.cond_br %166, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      llhd.drv %wait_cntr_d, %c0_i4 after %1 : i4
      cf.br ^bb18
    ^bb3:  // pred: ^bb1
      %167 = llhd.prb %fsm_en : i1
      %168 = comb.xor %167, %true : i1
      cf.cond_br %168, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %169 = llhd.prb %wait_cntr_q : i4
      llhd.drv %wait_cntr_d, %169 after %1 : i4
      cf.br ^bb18
    ^bb5:  // pred: ^bb3
      %170 = llhd.prb %state_changing : i1
      cf.cond_br %170, ^bb6, ^bb15
    ^bb6:  // pred: ^bb5
      %171 = llhd.prb %state_d : i3
      %172 = comb.icmp ceq %171, %c1_i3 : i3
      cf.cond_br %172, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %173 = llhd.prb %csnlead : i4
      llhd.drv %wait_cntr_d, %173 after %1 : i4
      cf.br ^bb18
    ^bb8:  // pred: ^bb6
      %174 = comb.icmp ceq %171, %c-4_i3 : i3
      cf.cond_br %174, ^bb9, ^bb10
    ^bb9:  // pred: ^bb8
      %175 = llhd.prb %csntrail : i4
      llhd.drv %wait_cntr_d, %175 after %1 : i4
      cf.br ^bb18
    ^bb10:  // pred: ^bb8
      %176 = comb.icmp ceq %171, %c-3_i3 : i3
      cf.cond_br %176, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      %177 = llhd.prb %csnidle : i4
      llhd.drv %wait_cntr_d, %177 after %1 : i4
      cf.br ^bb18
    ^bb12:  // pred: ^bb10
      %178 = comb.icmp ceq %171, %c-2_i3 : i3
      cf.cond_br %178, ^bb13, ^bb14
    ^bb13:  // pred: ^bb12
      %179 = llhd.prb %csnidle : i4
      llhd.drv %wait_cntr_d, %179 after %1 : i4
      cf.br ^bb18
    ^bb14:  // pred: ^bb12
      llhd.drv %wait_cntr_d, %c0_i4 after %1 : i4
      cf.br ^bb18
    ^bb15:  // pred: ^bb5
      %180 = llhd.prb %wait_cntr_q : i4
      %181 = comb.icmp eq %180, %c0_i4 : i4
      cf.cond_br %181, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      llhd.drv %wait_cntr_d, %c0_i4 after %1 : i4
      cf.br ^bb18
    ^bb17:  // pred: ^bb15
      %182 = llhd.prb %wait_cntr_q : i4
      %183 = comb.add %182, %c-1_i4 : i4
      llhd.drv %wait_cntr_d, %183 after %1 : i4
      cf.br ^bb18
    ^bb18:  // 9 preds: ^bb2, ^bb4, ^bb7, ^bb9, ^bb11, ^bb13, ^bb14, ^bb16, ^bb17
      llhd.wait (%59, %146, %82, %83, %88, %81, %40, %41, %39 : i1, i4, i1, i4, i1, i3, i4, i4, i4), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %166 = llhd.prb %clk_i_0 : i1
      %167 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %168 = llhd.prb %clk_i_0 : i1
      %169 = comb.xor bin %166, %true : i1
      %170 = comb.and bin %169, %168 : i1
      %171 = llhd.prb %rst_ni_1 : i1
      %172 = comb.xor bin %171, %true : i1
      %173 = comb.and bin %167, %172 : i1
      %174 = comb.or bin %170, %173 : i1
      cf.cond_br %174, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %175 = llhd.prb %rst_ni_1 : i1
      %176 = comb.xor %175, %true : i1
      cf.cond_br %176, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %bit_cntr_q, %c0_i3 after %0 : i3
      llhd.drv %byte_cntr_cpha0_q, %c0_i20 after %0 : i20
      llhd.drv %byte_cntr_cpha1_q, %c0_i20 after %0 : i20
      llhd.drv %wait_cntr_q, %c0_i4 after %0 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %177 = llhd.prb %stall : i1
      %178 = llhd.prb %bit_cntr_q : i3
      %179 = llhd.prb %bit_cntr_d : i3
      %180 = comb.mux %177, %178, %179 : i3
      llhd.drv %bit_cntr_q, %180 after %0 : i3
      %181 = llhd.prb %stall : i1
      %182 = llhd.prb %byte_cntr_cpha0_q : i20
      %183 = llhd.prb %byte_cntr_cpha0_d : i20
      %184 = comb.mux %181, %182, %183 : i20
      llhd.drv %byte_cntr_cpha0_q, %184 after %0 : i20
      %185 = llhd.prb %stall : i1
      %186 = llhd.prb %byte_cntr_cpha1_q : i20
      %187 = llhd.prb %byte_cntr_cpha1_d : i20
      %188 = comb.mux %185, %186, %187 : i20
      llhd.drv %byte_cntr_cpha1_q, %188 after %0 : i20
      %189 = llhd.prb %stall : i1
      %190 = llhd.prb %wait_cntr_q : i4
      %191 = llhd.prb %wait_cntr_d : i4
      %192 = comb.mux %189, %190, %191 : i4
      llhd.drv %wait_cntr_q, %192 after %0 : i4
      cf.br ^bb1
    }
    %147 = comb.and %128, %48 {sv.namehint = "wr_en_internal"} : i1
    %148 = llhd.prb %byte_ending : i1
    %149 = comb.and %148, %118 {sv.namehint = "rd_en_internal"} : i1
    %150 = comb.or %128, %11 : i1
    llhd.drv %sample_en_d, %150 after %1 : i1
    %151 = comb.icmp eq %124, %c0_i20 : i20
    %152 = comb.and %151, %9, %sr_rd_ready_i : i1
    %153 = comb.icmp eq %121, %c0_i20 : i20
    %154 = comb.and %153, %8, %sr_wr_ready_i : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %166 = llhd.prb %clk_i_0 : i1
      %167 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %168 = llhd.prb %clk_i_0 : i1
      %169 = comb.xor bin %166, %true : i1
      %170 = comb.and bin %169, %168 : i1
      %171 = llhd.prb %rst_ni_1 : i1
      %172 = comb.xor bin %171, %true : i1
      %173 = comb.and bin %167, %172 : i1
      %174 = comb.or bin %170, %173 : i1
      cf.cond_br %174, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %175 = llhd.prb %rst_ni_1 : i1
      %176 = comb.xor %175, %true : i1
      cf.cond_br %176, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %sample_en_q, %false after %0 : i1
      llhd.drv %sample_en_q2, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %177 = llhd.prb %fsm_en : i1
      %178 = llhd.prb %stall : i1
      %179 = comb.xor %178, %true : i1
      %180 = comb.and %177, %179 : i1
      %181 = llhd.prb %sample_en_d : i1
      %182 = llhd.prb %sample_en_q : i1
      %183 = comb.mux %180, %181, %182 : i1
      llhd.drv %sample_en_q, %183 after %0 : i1
      %184 = llhd.prb %fsm_en : i1
      %185 = llhd.prb %stall : i1
      %186 = comb.xor %185, %true : i1
      %187 = comb.and %184, %186 : i1
      %188 = llhd.prb %sample_en_q : i1
      %189 = llhd.prb %sample_en_q2 : i1
      %190 = comb.mux %187, %188, %189 : i1
      llhd.drv %sample_en_q2, %190 after %0 : i1
      cf.br ^bb1
    }
    %155 = llhd.prb %sample_en_q2 : i1
    %156 = llhd.prb %sample_en_q : i1
    %157 = comb.mux %38, %155, %156 {sv.namehint = "sample_en_internal"} : i1
    %158 = llhd.prb %csb_single_d : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb8
      %166 = llhd.prb %state_d : i3
      %167 = comb.icmp ceq %166, %c1_i3 : i3
      cf.cond_br %167, ^bb6, ^bb2
    ^bb2:  // pred: ^bb1
      %168 = comb.icmp ceq %166, %c2_i3 : i3
      cf.cond_br %168, ^bb6, ^bb3
    ^bb3:  // pred: ^bb2
      %169 = comb.icmp ceq %166, %c3_i3 : i3
      cf.cond_br %169, ^bb6, ^bb4
    ^bb4:  // pred: ^bb3
      %170 = comb.icmp ceq %166, %c-1_i3 : i3
      cf.cond_br %170, ^bb6, ^bb5
    ^bb5:  // pred: ^bb4
      %171 = comb.icmp ceq %166, %c-4_i3 : i3
      cf.cond_br %171, ^bb6, ^bb7
    ^bb6:  // 5 preds: ^bb1, ^bb2, ^bb3, ^bb4, ^bb5
      llhd.drv %csb_single_d, %false after %1 : i1
      cf.br ^bb8
    ^bb7:  // pred: ^bb5
      llhd.drv %csb_single_d, %true after %1 : i1
      cf.br ^bb8
    ^bb8:  // 2 preds: ^bb6, ^bb7
      llhd.wait (%81, %158 : i3, i1), ^bb1
    }
    %159 = comb.icmp ne %81, %c3_i3 : i3
    %160 = comb.mux %36, %159, %101 {sv.namehint = "sck_d"} : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %166 = llhd.prb %clk_i_0 : i1
      %167 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %168 = llhd.prb %clk_i_0 : i1
      %169 = comb.xor bin %166, %true : i1
      %170 = comb.and bin %169, %168 : i1
      %171 = llhd.prb %rst_ni_1 : i1
      %172 = comb.xor bin %171, %true : i1
      %173 = comb.and bin %167, %172 : i1
      %174 = comb.or bin %170, %173 : i1
      cf.cond_br %174, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %175 = llhd.prb %rst_ni_1 : i1
      %176 = comb.xor %175, %true : i1
      cf.cond_br %176, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %csb_q, %true after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %177 = llhd.prb %csid : i1
      %178 = llhd.prb %stall : i1
      %179 = comb.xor %178, %true : i1
      %180 = llhd.prb %csb_single_d : i1
      %181 = llhd.prb %csb_q : i1
      %182 = comb.mux %179, %180, %181 : i1
      %183 = comb.or %177, %182 : i1
      llhd.drv %csb_q, %183 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9
      %166 = llhd.prb %clk_i_0 : i1
      %167 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %168 = llhd.prb %clk_i_0 : i1
      %169 = comb.xor bin %166, %true : i1
      %170 = comb.and bin %169, %168 : i1
      %171 = llhd.prb %rst_ni_1 : i1
      %172 = comb.xor bin %171, %true : i1
      %173 = comb.and bin %167, %172 : i1
      %174 = comb.or bin %170, %173 : i1
      cf.cond_br %174, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %175 = llhd.prb %rst_ni_1 : i1
      %176 = comb.xor %175, %true : i1
      cf.cond_br %176, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %cmd_wr_en_last_bit, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %177 = llhd.prb %cmd_wr_en_q : i1
      %178 = llhd.prb %last_bit : i1
      %179 = comb.and %177, %178 : i1
      cf.cond_br %179, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %cmd_wr_en_last_bit, %true after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %180 = llhd.prb %byte_ending : i1
      cf.cond_br %180, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      llhd.drv %cmd_wr_en_last_bit, %false after %0 : i1
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %181 = llhd.prb %cmd_wr_en_last_bit : i1
      llhd.drv %cmd_wr_en_last_bit, %181 after %0 : i1
      cf.br ^bb1
    }
    %161 = llhd.prb %csb_q : i1
    llhd.drv %csb_o, %161 after %1 : i1
    %162 = llhd.prb %csb_o : i1
    %163 = llhd.prb %sd_en_o : i4
    %164 = llhd.prb %speed_o : i2
    %165 = llhd.prb %cmd_wr_en_last_bit : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb10
      %166 = llhd.prb %csb_o : i1
      cf.cond_br %166, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      llhd.drv %sd_en_o, %c0_i4 after %1 : i4
      cf.br ^bb10
    ^bb3:  // pred: ^bb1
      %167 = llhd.prb %speed_o : i2
      %168 = comb.icmp ceq %167, %c0_i2 : i2
      cf.cond_br %168, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %169 = llhd.sig.extract %sd_en_o from %c0_i2 : <i4> -> <i1>
      %170 = llhd.prb %cmd_wr_en_q : i1
      %171 = llhd.prb %cmd_wr_en_last_bit : i1
      %172 = comb.or %170, %171 : i1
      llhd.drv %169, %172 after %1 : i1
      %173 = llhd.sig.extract %sd_en_o from %c1_i2 : <i4> -> <i1>
      llhd.drv %173, %false after %1 : i1
      %174 = llhd.sig.extract %sd_en_o from %c-2_i2 : <i4> -> <i2>
      llhd.drv %174, %c0_i2 after %1 : i2
      cf.br ^bb10
    ^bb5:  // pred: ^bb3
      %175 = comb.icmp ceq %167, %c1_i2 : i2
      cf.cond_br %175, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %176 = llhd.sig.extract %sd_en_o from %c0_i2 : <i4> -> <i2>
      %177 = llhd.prb %cmd_wr_en_q : i1
      %178 = comb.replicate %177 : (i1) -> i2
      llhd.drv %176, %178 after %1 : i2
      %179 = llhd.sig.extract %sd_en_o from %c-2_i2 : <i4> -> <i2>
      llhd.drv %179, %c0_i2 after %1 : i2
      cf.br ^bb10
    ^bb7:  // pred: ^bb5
      %180 = comb.icmp ceq %167, %c-2_i2 : i2
      cf.cond_br %180, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %181 = llhd.prb %cmd_wr_en_q : i1
      %182 = comb.replicate %181 : (i1) -> i4
      llhd.drv %sd_en_o, %182 after %1 : i4
      cf.br ^bb10
    ^bb9:  // pred: ^bb7
      llhd.drv %sd_en_o, %c0_i4 after %1 : i4
      cf.br ^bb10
    ^bb10:  // 5 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb9
      llhd.wait (%162, %163, %164, %47, %165 : i1, i4, i2, i1, i1), ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %command_i_2, %command_i after %1 : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
    llhd.drv %command_csid_i_3, %command_csid_i after %1 : i1
    llhd.drv %command_valid_i_4, %command_valid_i after %1 : i1
    llhd.drv %sw_rst_i_5, %sw_rst_i after %1 : i1
    hw.output %13, %u_sck_flop.q_o, %162, %163, %152, %154, %8, %9, %10, %11, %164, %38, %73, %71, %58 : i1, i1, i1, i4, i1, i1, i1, i1, i1, i1, i2, i1, i1, i1, i1
  }
  hw.module private @spi_host_shift_register(in %clk_i : i1, in %rst_ni : i1, in %wr_en_i : i1, out wr_ready_o : i1, in %rd_en_i : i1, out rd_ready_o : i1, in %speed_i : i2, in %shift_en_i : i1, in %sample_en_i : i1, in %full_cyc_i : i1, in %last_read_i : i1, in %last_write_i : i1, in %tx_data_i : i8, in %tx_valid_i : i1, out tx_ready_o : i1, out tx_flush_o : i1, out rx_data_o : i8, out rx_valid_o : i1, in %rx_ready_i : i1, out rx_last_o : i1, in %sd_i : i4, out sd_o : i4, in %sw_rst_i : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %true = hw.constant true
    %false = hw.constant false
    %c0_i9 = hw.constant 0 : i9
    %c0_i4 = hw.constant 0 : i4
    %c0_i2 = hw.constant 0 : i2
    %c0_i3 = hw.constant 0 : i3
    %c0_i8 = hw.constant 0 : i8
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %wr_en_i_2 = llhd.sig name "wr_en_i" %false : i1
    %wr_ready_o = llhd.sig %false : i1
    %rd_en_i_3 = llhd.sig name "rd_en_i" %false : i1
    %rd_ready_o = llhd.sig %false : i1
    %speed_i_4 = llhd.sig name "speed_i" %c0_i2 : i2
    %shift_en_i_5 = llhd.sig name "shift_en_i" %false : i1
    %sample_en_i_6 = llhd.sig name "sample_en_i" %false : i1
    %last_read_i_7 = llhd.sig name "last_read_i" %false : i1
    %tx_data_i_8 = llhd.sig name "tx_data_i" %c0_i8 : i8
    %rx_valid_o = llhd.sig %false : i1
    %rx_ready_i_9 = llhd.sig name "rx_ready_i" %false : i1
    %sd_i_10 = llhd.sig name "sd_i" %c0_i4 : i4
    %sr_q = llhd.sig %c0_i8 : i8
    %sr_d = llhd.sig %c0_i8 : i8
    %sd_i_q = llhd.sig %c0_i4 : i4
    %sd_i_d = llhd.sig %c0_i4 : i4
    %next_bits = llhd.sig %c0_i4 : i4
    %sr_shifted = llhd.sig %c0_i8 : i8
    %rx_buf_q = llhd.sig %c0_i9 : i9
    %rx_buf_d = llhd.sig %c0_i9 : i9
    %rx_buf_valid_q = llhd.sig %false : i1
    %rx_buf_valid_d = llhd.sig %false : i1
    %4 = llhd.prb %sd_i_10 : i4
    %5 = llhd.prb %sd_i_q : i4
    %6 = comb.mux %full_cyc_i, %4, %5 : i4
    llhd.drv %next_bits, %6 after %1 : i4
    %7 = llhd.prb %speed_i_4 : i2
    %8 = llhd.prb %sr_q : i8
    %9 = comb.extract %8 from 0 : (i8) -> i7
    %10 = llhd.prb %next_bits : i4
    %11 = comb.extract %10 from 1 : (i4) -> i1
    %12 = comb.concat %9, %11 : i7, i1
    %13 = comb.extract %8 from 0 : (i8) -> i6
    %14 = comb.extract %10 from 0 : (i4) -> i2
    %15 = comb.concat %13, %14 : i6, i2
    %16 = comb.extract %8 from 0 : (i8) -> i4
    %17 = comb.concat %16, %10 : i4, i4
    %18 = hw.array_create %c0_i8, %17, %15, %12 : i8
    %19 = hw.array_get %18[%7] : !hw.array<4xi8>, i2
    llhd.drv %sr_shifted, %19 after %1 : i8
    %20 = comb.extract %8 from 7 : (i8) -> i1
    %21 = comb.concat %c0_i3, %20 : i3, i1
    %22 = comb.extract %8 from 6 : (i8) -> i2
    %23 = comb.concat %c0_i2, %22 : i2, i2
    %24 = comb.extract %8 from 4 : (i8) -> i4
    %25 = hw.array_create %c0_i4, %24, %23, %21 : i4
    %26 = hw.array_get %25[%7] : !hw.array<4xi4>, i2
    %27 = llhd.prb %rx_buf_valid_q : i1
    %28 = comb.xor %27, %true : i1
    %29 = llhd.prb %rx_valid_o : i1
    %30 = llhd.prb %rx_ready_i_9 : i1
    %31 = comb.and %29, %30 : i1
    %32 = comb.or %28, %31 : i1
    llhd.drv %rd_ready_o, %32 after %1 : i1
    llhd.drv %rx_valid_o, %27 after %1 : i1
    %33 = llhd.prb %rd_en_i_3 : i1
    %34 = llhd.prb %rd_ready_o : i1
    %35 = comb.and %33, %34 : i1
    %36 = llhd.prb %last_read_i_7 : i1
    %37 = llhd.prb %sr_shifted : i8
    %38 = comb.concat %36, %37 : i1, i8
    %39 = llhd.prb %rx_buf_q : i9
    %40 = comb.mux %35, %38, %39 : i9
    %41 = comb.mux %sw_rst_i, %c0_i9, %40 : i9
    llhd.drv %rx_buf_d, %41 after %1 : i9
    %42 = comb.xor %31, %true : i1
    %43 = comb.and %42, %27 : i1
    %44 = comb.or %35, %43 : i1
    %45 = comb.xor %sw_rst_i, %true : i1
    %46 = comb.and %45, %44 : i1
    llhd.drv %rx_buf_valid_d, %46 after %1 : i1
    %47 = llhd.prb %sample_en_i_6 : i1
    %48 = comb.mux %47, %4, %5 : i4
    %49 = comb.mux %sw_rst_i, %c0_i4, %48 : i4
    llhd.drv %sd_i_d, %49 after %1 : i4
    %50 = comb.extract %39 from 8 : (i9) -> i1
    %51 = comb.extract %39 from 0 : (i9) -> i8
    llhd.drv %wr_ready_o, %tx_valid_i after %1 : i1
    %52 = llhd.prb %wr_en_i_2 : i1
    %53 = llhd.prb %wr_ready_o : i1
    %54 = comb.and %52, %53 : i1
    %55 = llhd.prb %tx_data_i_8 : i8
    %56 = llhd.prb %shift_en_i_5 : i1
    %57 = comb.mux %56, %37, %8 : i8
    %58 = comb.mux %54, %55, %57 : i8
    %59 = comb.mux %sw_rst_i, %c0_i8, %58 : i8
    llhd.drv %sr_d, %59 after %1 : i8
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %60 = llhd.prb %clk_i_0 : i1
      %61 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %62 = llhd.prb %clk_i_0 : i1
      %63 = comb.xor bin %60, %true : i1
      %64 = comb.and bin %63, %62 : i1
      %65 = llhd.prb %rst_ni_1 : i1
      %66 = comb.xor bin %65, %true : i1
      %67 = comb.and bin %61, %66 : i1
      %68 = comb.or bin %64, %67 : i1
      cf.cond_br %68, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %69 = llhd.prb %rst_ni_1 : i1
      %70 = comb.xor %69, %true : i1
      cf.cond_br %70, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %sd_i_q, %c0_i4 after %0 : i4
      llhd.drv %sr_q, %c0_i8 after %0 : i8
      llhd.drv %rx_buf_valid_q, %false after %0 : i1
      llhd.drv %rx_buf_q, %c0_i9 after %0 : i9
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %71 = llhd.prb %sd_i_d : i4
      llhd.drv %sd_i_q, %71 after %0 : i4
      %72 = llhd.prb %sr_d : i8
      llhd.drv %sr_q, %72 after %0 : i8
      %73 = llhd.prb %rx_buf_valid_d : i1
      llhd.drv %rx_buf_valid_q, %73 after %0 : i1
      %74 = llhd.prb %rx_buf_d : i9
      llhd.drv %rx_buf_q, %74 after %0 : i9
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %wr_en_i_2, %wr_en_i after %1 : i1
    llhd.drv %rd_en_i_3, %rd_en_i after %1 : i1
    llhd.drv %speed_i_4, %speed_i after %1 : i2
    llhd.drv %shift_en_i_5, %shift_en_i after %1 : i1
    llhd.drv %sample_en_i_6, %sample_en_i after %1 : i1
    llhd.drv %last_read_i_7, %last_read_i after %1 : i1
    llhd.drv %tx_data_i_8, %tx_data_i after %1 : i8
    llhd.drv %rx_ready_i_9, %rx_ready_i after %1 : i1
    llhd.drv %sd_i_10, %sd_i after %1 : i4
    hw.output %53, %34, %52, %last_write_i, %51, %29, %50, %26 : i1, i1, i1, i1, i8, i1, i1, i4
  }
  hw.module private @spi_host_window(in %clk_i : i1, in %rst_ni : i1, in %rx_win_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out rx_win_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %tx_win_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tx_win_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tx_data_o : i32, out tx_be_o : i4, out tx_valid_o : i1, in %rx_data_i : i32, out rx_ready_o : i1, in %racl_policies_i : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, out racl_error_tx_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, out racl_error_rx_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>) {
    %0 = hw.aggregate_constant [[0 : i32, -1 : i32, false, true]] : !hw.array<1xstruct<base: i32, limit: i32, policy_sel: i1, enable: i1>>
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i8 = hw.constant 0 : i8
    %c0_i2 = hw.constant 0 : i2
    %c0_i32 = hw.constant 0 : i32
    %true = hw.constant true
    %false = hw.constant false
    %c-7_i4 = hw.constant -7 : i4
    %c0_i4 = hw.constant 0 : i4
    %tx_be_o = llhd.sig %c0_i4 : i4
    %u_adapter_rx.tl_o, %u_adapter_rx.intg_error_o, %u_adapter_rx.racl_error_o, %u_adapter_rx.re_o, %u_adapter_rx.we_o, %u_adapter_rx.addr_o, %u_adapter_rx.wdata_o, %u_adapter_rx.be_o = hw.instance "u_adapter_rx" @tlul_adapter_reg_racl(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, tl_i: %rx_win_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, en_ifetch_i: %c-7_i4: i4, racl_policies_i: %racl_policies_i: !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, busy_i: %false: i1, rdata_i: %rx_data_i: i32, error_i: %u_adapter_rx.we_o: i1) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, intg_error_o: i1, racl_error_o: !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, re_o: i1, we_o: i1, addr_o: i6, wdata_o: i32, be_o: i4) {sv.namehint = "rx_we"}
    %u_adapter_tx.tl_o, %u_adapter_tx.req_o, %u_adapter_tx.req_type_o, %u_adapter_tx.we_o, %u_adapter_tx.addr_o, %u_adapter_tx.wdata_o, %u_adapter_tx.wmask_o, %u_adapter_tx.intg_error_o, %u_adapter_tx.user_rsvd_o, %u_adapter_tx.compound_txn_in_progress_o, %u_adapter_tx.readback_error_o, %u_adapter_tx.racl_error_o = hw.instance "u_adapter_tx" @tlul_adapter_sram_racl(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, tl_i: %tx_win_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, en_ifetch_i: %c-7_i4: i4, gnt_i: %true: i1, rdata_i: %c0_i32: i32, rvalid_i: %false: i1, rerror_i: %c0_i2: i2, readback_en_i: %c-7_i4: i4, wr_collision_i: %false: i1, write_pending_i: %false: i1, racl_policies_i: %racl_policies_i: !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, racl_policy_sel_ranges_i: %0: !hw.array<1xstruct<base: i32, limit: i32, policy_sel: i1, enable: i1>>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, req_o: i1, req_type_o: i4, we_o: i1, addr_o: i6, wdata_o: i32, wmask_o: i32, intg_error_o: i1, user_rsvd_o: i5, compound_txn_in_progress_o: i1, readback_error_o: i1, racl_error_o: !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>) {sv.namehint = "bit_mask"}
    %2 = llhd.sig.extract %tx_be_o from %c0_i2 : <i4> -> <i1>
    %3 = comb.extract %u_adapter_tx.wmask_o from 0 : (i32) -> i8
    %4 = comb.icmp ne %3, %c0_i8 : i8
    llhd.drv %2, %4 after %1 : i1
    %5 = llhd.sig.extract %tx_be_o from %c1_i2 : <i4> -> <i1>
    %6 = comb.extract %u_adapter_tx.wmask_o from 8 : (i32) -> i8
    %7 = comb.icmp ne %6, %c0_i8 : i8
    llhd.drv %5, %7 after %1 : i1
    %8 = llhd.sig.extract %tx_be_o from %c-2_i2 : <i4> -> <i1>
    %9 = comb.extract %u_adapter_tx.wmask_o from 16 : (i32) -> i8
    %10 = comb.icmp ne %9, %c0_i8 : i8
    llhd.drv %8, %10 after %1 : i1
    %11 = llhd.sig.extract %tx_be_o from %c-1_i2 : <i4> -> <i1>
    %12 = comb.extract %u_adapter_tx.wmask_o from 24 : (i32) -> i8
    %13 = comb.icmp ne %12, %c0_i8 : i8
    llhd.drv %11, %13 after %1 : i1
    %14 = llhd.prb %tx_be_o : i4
    hw.output %u_adapter_rx.tl_o, %u_adapter_tx.tl_o, %u_adapter_tx.wdata_o, %14, %u_adapter_tx.req_o, %u_adapter_rx.re_o, %u_adapter_tx.racl_error_o, %u_adapter_rx.racl_error_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, i32, i4, i1, i1, !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
  }
  hw.module private @spi_host_core(in %clk_i : i1, in %rst_ni : i1, in %command_i : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>, in %command_csid_i : i1, in %command_valid_i : i1, out command_ready_o : i1, in %en_i : i1, in %tx_data_i : i32, in %tx_be_i : i4, in %tx_valid_i : i1, out tx_ready_o : i1, out tx_byte_select_full_o : i1, out rx_data_o : i32, out rx_valid_o : i1, in %rx_ready_i : i1, in %sw_rst_i : i1, out sck_o : i1, out csb_o : i1, out sd_o : i4, out sd_en_o : i4, in %sd_i : i4, out rx_stall_o : i1, out tx_stall_o : i1, out active_o : i1) {
    %u_merge.byte_ready_o, %u_merge.word_o, %u_merge.word_valid_o = hw.instance "u_merge" @spi_host_byte_merge(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, byte_i: %u_shift_reg.rx_data_o: i8, byte_last_i: %u_shift_reg.rx_last_o: i1, byte_valid_i: %u_shift_reg.rx_valid_o: i1, word_ready_i: %rx_ready_i: i1, sw_rst_i: %sw_rst_i: i1) -> (byte_ready_o: i1, word_o: i32, word_valid_o: i1) {sv.namehint = "rx_ready_sr"}
    %u_select.word_ready_o, %u_select.byte_o, %u_select.byte_valid_o = hw.instance "u_select" @spi_host_byte_select(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, word_i: %tx_data_i: i32, word_be_i: %tx_be_i: i4, word_valid_i: %tx_valid_i: i1, byte_ready_i: %u_shift_reg.tx_ready_o: i1, flush_i: %u_shift_reg.tx_flush_o: i1, sw_rst_i: %sw_rst_i: i1) -> (word_ready_o: i1, byte_o: i8, byte_valid_o: i1) {sv.namehint = "tx_data_sr"}
    %u_shift_reg.wr_ready_o, %u_shift_reg.rd_ready_o, %u_shift_reg.tx_ready_o, %u_shift_reg.tx_flush_o, %u_shift_reg.rx_data_o, %u_shift_reg.rx_valid_o, %u_shift_reg.rx_last_o, %u_shift_reg.sd_o = hw.instance "u_shift_reg" @spi_host_shift_register(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, wr_en_i: %u_fsm.wr_en_o: i1, rd_en_i: %u_fsm.rd_en_o: i1, speed_i: %u_fsm.speed_o: i2, shift_en_i: %u_fsm.shift_en_o: i1, sample_en_i: %u_fsm.sample_en_o: i1, full_cyc_i: %u_fsm.full_cyc_o: i1, last_read_i: %u_fsm.last_read_o: i1, last_write_i: %u_fsm.last_write_o: i1, tx_data_i: %u_select.byte_o: i8, tx_valid_i: %u_select.byte_valid_o: i1, rx_ready_i: %u_merge.byte_ready_o: i1, sd_i: %sd_i: i4, sw_rst_i: %sw_rst_i: i1) -> (wr_ready_o: i1, rd_ready_o: i1, tx_ready_o: i1, tx_flush_o: i1, rx_data_o: i8, rx_valid_o: i1, rx_last_o: i1, sd_o: i4) {sv.namehint = "rd_ready"}
    %u_fsm.command_ready_o, %u_fsm.sck_o, %u_fsm.csb_o, %u_fsm.sd_en_o, %u_fsm.last_read_o, %u_fsm.last_write_o, %u_fsm.wr_en_o, %u_fsm.rd_en_o, %u_fsm.sample_en_o, %u_fsm.shift_en_o, %u_fsm.speed_o, %u_fsm.full_cyc_o, %u_fsm.rx_stall_o, %u_fsm.tx_stall_o, %u_fsm.active_o = hw.instance "u_fsm" @spi_host_fsm(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, en_i: %en_i: i1, command_i: %command_i: !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>, command_csid_i: %command_csid_i: i1, command_valid_i: %command_valid_i: i1, sr_wr_ready_i: %u_shift_reg.wr_ready_o: i1, sr_rd_ready_i: %u_shift_reg.rd_ready_o: i1, sw_rst_i: %sw_rst_i: i1) -> (command_ready_o: i1, sck_o: i1, csb_o: i1, sd_en_o: i4, last_read_o: i1, last_write_o: i1, wr_en_o: i1, rd_en_o: i1, sample_en_o: i1, shift_en_o: i1, speed_o: i2, full_cyc_o: i1, rx_stall_o: i1, tx_stall_o: i1, active_o: i1) {sv.namehint = "speed"}
    hw.output %u_fsm.command_ready_o, %u_select.word_ready_o, %u_select.byte_valid_o, %u_merge.word_o, %u_merge.word_valid_o, %u_fsm.sck_o, %u_fsm.csb_o, %u_shift_reg.sd_o, %u_fsm.sd_en_o, %u_fsm.rx_stall_o, %u_fsm.tx_stall_o, %u_fsm.active_o : i1, i1, i1, i32, i1, i1, i1, i4, i4, i1, i1, i1
  }
  hw.module @spi_host(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %alert_rx_i : !hw.array<1xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, out alert_tx_o : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>, in %racl_policies_i : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, out racl_error_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, out cio_sck_o : i1, out cio_sck_en_o : i1, out cio_csb_o : i1, out cio_csb_en_o : i1, out cio_sd_o : i4, out cio_sd_en_o : i4, in %cio_sd_i : i4, in %passthrough_i : !hw.struct<passthrough_en: i1, sck: i1, sck_en: i1, csb: i1, csb_en: i1, s: i4, s_en: i4>, out passthrough_o : !hw.struct<s: i4>, out lsio_trigger_o : i1, out intr_error_o : i1, out intr_spi_event_o : i1) {
    %c0_i32 = hw.constant 0 : i32
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c0_i3 = hw.constant 0 : i3
    %c1_i3 = hw.constant 1 : i3
    %c2_i3 = hw.constant 2 : i3
    %c3_i3 = hw.constant 3 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c-3_i3 = hw.constant -3 : i3
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i0 = hw.constant 0 : i0
    %c0_i6 = hw.constant 0 : i6
    %2 = hw.aggregate_constant [[0 : i2, false, false, 0 : i20, false], [0 : i16, 0 : i4, 0 : i4, 0 : i4, false, false, false]] : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
    %3 = hw.aggregate_constant [[false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false], [false, 0 : i3, 0 : i3, 0 : i2, 0 : i8, false, 0 : i32, [0 : i7, 0 : i7], false, false]] : !hw.array<2xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %4 = hw.aggregate_constant [[false, false, false, false, false, 0 : i32], [false, false, false, false, false, 0 : i32], [false, false, false, false, false, 0 : i32]] : !hw.array<3xstruct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    %5 = hw.aggregate_constant [[[false, false], [false, false]], [[false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [false, false], [0 : i4, false], [0 : i8, false], [0 : i8, false]], [[false, false], [false, false], [false, false], [false, false], [false, false], [false, false]]] : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<d: i1, de: i1>, error: !hw.struct<d: i1, de: i1>>, status: !hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>, error_status: !hw.struct<accessinval: !hw.struct<d: i1, de: i1>, csidinval: !hw.struct<d: i1, de: i1>, cmdinval: !hw.struct<d: i1, de: i1>, underflow: !hw.struct<d: i1, de: i1>, overflow: !hw.struct<d: i1, de: i1>, cmdbusy: !hw.struct<d: i1, de: i1>>>
    %6 = hw.aggregate_constant [[[false], [false]], [[false], [false]], [[false, false], [false, false]], [false, false], [[false], [false], [false], [0 : i8], [0 : i8]], [[false], [false], [false], [0 : i4], [0 : i4], [0 : i4], [0 : i16]], [0 : i32], [[0 : i20, false], [0 : i2, false], [0 : i2, false], [false, false]], [[false], [false], [false], [false], [false]], [[false], [false], [false], [false], [false], [false]], [[false], [false], [false], [false], [false], [false]]] : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
    %7 = hw.aggregate_constant [0 : i4] : !hw.struct<s: i4>
    %8 = hw.aggregate_constant [false, false, false, false, false, 0 : i32] : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %9 = hw.aggregate_constant [[false, false]] : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    %true = hw.constant true
    %c-1_i4 = hw.constant -1 : i4
    %c3_i4 = hw.constant 3 : i4
    %c6_i4 = hw.constant 6 : i4
    %c-4_i4 = hw.constant -4 : i4
    %c1_i4 = hw.constant 1 : i4
    %c2_i4 = hw.constant 2 : i4
    %c4_i4 = hw.constant 4 : i4
    %c-8_i4 = hw.constant -8 : i4
    %c-1_i2 = hw.constant -1 : i2
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %false = hw.constant false
    %c0_i2 = hw.constant 0 : i2
    %c0_i4 = hw.constant 0 : i4
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %10 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %11 = llhd.prb %rst_ni_1 : i1
    %alert_tx_o = llhd.sig %9 : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    %racl_error_o = llhd.sig %8 : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %passthrough_o = llhd.sig %7 : !hw.struct<s: i4>
    %lsio_trigger_o = llhd.sig %false : i1
    %reg2hw = llhd.sig %6 : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
    %hw2reg = llhd.sig %5 : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<d: i1, de: i1>, error: !hw.struct<d: i1, de: i1>>, status: !hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>, error_status: !hw.struct<accessinval: !hw.struct<d: i1, de: i1>, csidinval: !hw.struct<d: i1, de: i1>, cmdinval: !hw.struct<d: i1, de: i1>, underflow: !hw.struct<d: i1, de: i1>, overflow: !hw.struct<d: i1, de: i1>, cmdbusy: !hw.struct<d: i1, de: i1>>>
    %racl_error = llhd.sig %4 : !hw.array<3xstruct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    %gen_no_racl_error_arb.unused_signals = llhd.sig %false : i1
    %fifo_win_d2h = llhd.sig %3 : !hw.array<2xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %alerts = llhd.sig %false : i1
    %sck = llhd.sig %false : i1
    %csb = llhd.sig %false : i1
    %sd_out = llhd.sig %c0_i4 : i4
    %sd_en = llhd.sig %c0_i4 : i4
    %sd_en_core = llhd.sig %c0_i4 : i4
    %output_en = llhd.sig %false : i1
    %gen_passthrough_implementation.pt_sck = llhd.sig %false : i1
    %gen_passthrough_implementation.pt_sck_en = llhd.sig %false : i1
    %gen_passthrough_implementation.pt_csb = llhd.sig %false : i1
    %gen_passthrough_implementation.pt_csb_en = llhd.sig %false : i1
    %gen_passthrough_implementation.pt_sd_out = llhd.sig %c0_i4 : i4
    %gen_passthrough_implementation.pt_sd_en = llhd.sig %c0_i4 : i4
    %command = llhd.sig %2 : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
    %test_dir_inval = llhd.sig %false : i1
    %test_speed_inval = llhd.sig %false : i1
    %tx_be = llhd.sig %c0_i4 : i4
    %tx_wm = llhd.sig %false : i1
    %rx_wm = llhd.sig %false : i1
    %access_valid = llhd.sig %false : i1
    %sw_error_status = llhd.sig %c0_i6 : i6
    %12 = llhd.prb %fifo_win_d2h : !hw.array<2xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>
    %13 = llhd.prb %hw2reg : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<d: i1, de: i1>, error: !hw.struct<d: i1, de: i1>>, status: !hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>, error_status: !hw.struct<accessinval: !hw.struct<d: i1, de: i1>, csidinval: !hw.struct<d: i1, de: i1>, cmdinval: !hw.struct<d: i1, de: i1>, underflow: !hw.struct<d: i1, de: i1>, overflow: !hw.struct<d: i1, de: i1>, cmdbusy: !hw.struct<d: i1, de: i1>>>
    %14 = llhd.sig.array_get %racl_error[%c-2_i2] : <!hw.array<3xstruct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>>
    %u_reg.tl_o, %u_reg.tl_win_o, %u_reg.reg2hw, %u_reg.racl_error_o, %u_reg.intg_err_o = hw.instance "u_reg" @spi_host_reg_top(clk_i: %10: i1, rst_ni: %11: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, tl_win_i: %12: !hw.array<2xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>, hw2reg: %13: !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<d: i1, de: i1>, error: !hw.struct<d: i1, de: i1>>, status: !hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>, error_status: !hw.struct<accessinval: !hw.struct<d: i1, de: i1>, csidinval: !hw.struct<d: i1, de: i1>, cmdinval: !hw.struct<d: i1, de: i1>, underflow: !hw.struct<d: i1, de: i1>, overflow: !hw.struct<d: i1, de: i1>, cmdbusy: !hw.struct<d: i1, de: i1>>>, racl_policies_i: %racl_policies_i: !hw.array<1xstruct<write_perm: i2, read_perm: i2>>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, tl_win_o: !hw.array<2xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>, reg2hw: !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>, racl_error_o: !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, intg_err_o: i1) {sv.namehint = "fifo_win_h2d"}
    llhd.drv %reg2hw, %u_reg.reg2hw after %1 : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
    llhd.drv %14, %u_reg.racl_error_o after %1 : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    llhd.drv %alerts, %u_reg.intg_err_o after %1 : i1
    %15 = llhd.prb %alerts : i1
    %16 = hw.array_get %alert_rx_i[%c0_i0] : !hw.array<1xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, i0
    %17 = llhd.sig.array_get %alert_tx_o[%c0_i0] : <!hw.array<1xstruct<alert_p: i1, alert_n: i1>>>
    %gen_alert_tx_0.u_prim_alert_sender.alert_ack_o, %gen_alert_tx_0.u_prim_alert_sender.alert_state_o, %gen_alert_tx_0.u_prim_alert_sender.alert_tx_o = hw.instance "gen_alert_tx_0.u_prim_alert_sender" @prim_alert_sender(clk_i: %10: i1, rst_ni: %11: i1, alert_test_i: %37: i1, alert_req_i: %15: i1, alert_rx_i: %16: !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>) -> (alert_ack_o: i1, alert_state_o: i1, alert_tx_o: !hw.struct<alert_p: i1, alert_n: i1>)
    llhd.drv %17, %gen_alert_tx_0.u_prim_alert_sender.alert_tx_o after %1 : !hw.struct<alert_p: i1, alert_n: i1>
    %18 = llhd.prb %command : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
    %u_cmd_queue.command_busy_o, %u_cmd_queue.core_command_o, %u_cmd_queue.core_command_csid_o, %u_cmd_queue.core_command_valid_o, %u_cmd_queue.qd_o, %u_cmd_queue.error_busy_o = hw.instance "u_cmd_queue" @spi_host_command_queue(clk_i: %10: i1, rst_ni: %11: i1, command_i: %18: !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>, command_csid_i: %73: i1, command_valid_i: %87: i1, core_command_ready_i: %u_spi_core.command_ready_o: i1, sw_rst_i: %q_35: i1) -> (command_busy_o: i1, core_command_o: !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>, core_command_csid_o: i1, core_command_valid_o: i1, qd_o: i4, error_busy_o: i1) {sv.namehint = "cmd_qd"}
    %19 = hw.array_get %u_reg.tl_win_o[%true] : !hw.array<2xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>, i1
    %20 = llhd.sig.array_get %fifo_win_d2h[%true] : <!hw.array<2xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>>
    %21 = hw.array_get %u_reg.tl_win_o[%false] : !hw.array<2xstruct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>>, i1
    %22 = llhd.sig.array_get %fifo_win_d2h[%false] : <!hw.array<2xstruct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>>>
    %23 = llhd.sig.array_get %racl_error[%c1_i2] : <!hw.array<3xstruct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>>
    %24 = llhd.sig.array_get %racl_error[%c0_i2] : <!hw.array<3xstruct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>>
    %u_window.rx_win_o, %u_window.tx_win_o, %u_window.tx_data_o, %u_window.tx_be_o, %u_window.tx_valid_o, %u_window.rx_ready_o, %u_window.racl_error_tx_o, %u_window.racl_error_rx_o = hw.instance "u_window" @spi_host_window(clk_i: %10: i1, rst_ni: %11: i1, rx_win_i: %19: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, tx_win_i: %21: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, rx_data_i: %u_data_fifos.rx_data_o: i32, racl_policies_i: %racl_policies_i: !hw.array<1xstruct<write_perm: i2, read_perm: i2>>) -> (rx_win_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, tx_win_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, tx_data_o: i32, tx_be_o: i4, tx_valid_o: i1, rx_ready_o: i1, racl_error_tx_o: !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, racl_error_rx_o: !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>) {sv.namehint = "tx_data"}
    llhd.drv %20, %u_window.rx_win_o after %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %22, %u_window.tx_win_o after %1 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>
    llhd.drv %tx_be, %u_window.tx_be_o after %1 : i4
    llhd.drv %23, %u_window.racl_error_tx_o after %1 : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    llhd.drv %24, %u_window.racl_error_rx_o after %1 : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %25 = llhd.prb %tx_be : i4
    %u_data_fifos.tx_ready_o, %u_data_fifos.core_tx_data_o, %u_data_fifos.core_tx_be_o, %u_data_fifos.core_tx_valid_o, %u_data_fifos.core_rx_ready_o, %u_data_fifos.rx_data_o, %u_data_fifos.rx_valid_o, %u_data_fifos.tx_empty_o, %u_data_fifos.tx_full_o, %u_data_fifos.tx_qd_o, %u_data_fifos.tx_wm_o, %u_data_fifos.rx_empty_o, %u_data_fifos.rx_full_o, %u_data_fifos.rx_qd_o, %u_data_fifos.rx_wm_o = hw.instance "u_data_fifos" @spi_host_data_fifos(clk_i: %10: i1, rst_ni: %11: i1, tx_data_i: %u_window.tx_data_o: i32, tx_be_i: %25: i4, tx_valid_i: %138: i1, tx_watermark_i: %q_34: i8, core_tx_ready_i: %u_spi_core.tx_ready_o: i1, core_tx_byte_select_full_i: %u_spi_core.tx_byte_select_full_o: i1, core_rx_data_i: %u_spi_core.rx_data_o: i32, core_rx_valid_i: %u_spi_core.rx_valid_o: i1, rx_ready_i: %u_window.rx_ready_o: i1, rx_watermark_i: %q_33: i8, sw_rst_i: %q_35: i1) -> (tx_ready_o: i1, core_tx_data_o: i32, core_tx_be_o: i4, core_tx_valid_o: i1, core_rx_ready_o: i1, rx_data_o: i32, rx_valid_o: i1, tx_empty_o: i1, tx_full_o: i1, tx_qd_o: i8, tx_wm_o: i1, rx_empty_o: i1, rx_full_o: i1, rx_qd_o: i8, rx_wm_o: i1) {sv.namehint = "tx_qd"}
    llhd.drv %tx_wm, %u_data_fifos.tx_wm_o after %1 : i1
    llhd.drv %rx_wm, %u_data_fifos.rx_wm_o after %1 : i1
    %u_spi_core.command_ready_o, %u_spi_core.tx_ready_o, %u_spi_core.tx_byte_select_full_o, %u_spi_core.rx_data_o, %u_spi_core.rx_valid_o, %u_spi_core.sck_o, %u_spi_core.csb_o, %u_spi_core.sd_o, %u_spi_core.sd_en_o, %u_spi_core.rx_stall_o, %u_spi_core.tx_stall_o, %u_spi_core.active_o = hw.instance "u_spi_core" @spi_host_core(clk_i: %10: i1, rst_ni: %11: i1, command_i: %u_cmd_queue.core_command_o: !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>, command_csid_i: %u_cmd_queue.core_command_csid_o: i1, command_valid_i: %u_cmd_queue.core_command_valid_o: i1, en_i: %140: i1, tx_data_i: %u_data_fifos.core_tx_data_o: i32, tx_be_i: %u_data_fifos.core_tx_be_o: i4, tx_valid_i: %u_data_fifos.core_tx_valid_o: i1, rx_ready_i: %u_data_fifos.core_rx_ready_o: i1, sw_rst_i: %q_35: i1, sd_i: %cio_sd_i: i4) -> (command_ready_o: i1, tx_ready_o: i1, tx_byte_select_full_o: i1, rx_data_o: i32, rx_valid_o: i1, sck_o: i1, csb_o: i1, sd_o: i4, sd_en_o: i4, rx_stall_o: i1, tx_stall_o: i1, active_o: i1) {sv.namehint = "active"}
    llhd.drv %sck, %u_spi_core.sck_o after %1 : i1
    llhd.drv %csb, %u_spi_core.csb_o after %1 : i1
    llhd.drv %sd_out, %u_spi_core.sd_o after %1 : i4
    llhd.drv %sd_en_core, %u_spi_core.sd_en_o after %1 : i4
    %26 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
    %intr_enable = hw.struct_extract %26["intr_enable"] : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
    %error = hw.struct_extract %intr_enable["error"] : !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>
    %q = hw.struct_extract %error["q"] : !hw.struct<q: i1>
    %intr_test = hw.struct_extract %26["intr_test"] : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
    %error_2 = hw.struct_extract %intr_test["error"] : !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>
    %q_3 = hw.struct_extract %error_2["q"] : !hw.struct<q: i1, qe: i1>
    %qe = hw.struct_extract %error_2["qe"] : !hw.struct<q: i1, qe: i1>
    %intr_state = hw.struct_extract %26["intr_state"] : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
    %error_4 = hw.struct_extract %intr_state["error"] : !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>
    %q_5 = hw.struct_extract %error_4["q"] : !hw.struct<q: i1>
    %27 = llhd.sig.struct_extract %hw2reg["intr_state"] : <!hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<d: i1, de: i1>, error: !hw.struct<d: i1, de: i1>>, status: !hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>, error_status: !hw.struct<accessinval: !hw.struct<d: i1, de: i1>, csidinval: !hw.struct<d: i1, de: i1>, cmdinval: !hw.struct<d: i1, de: i1>, underflow: !hw.struct<d: i1, de: i1>, overflow: !hw.struct<d: i1, de: i1>, cmdbusy: !hw.struct<d: i1, de: i1>>>>
    %28 = llhd.sig.struct_extract %27["error"] : <!hw.struct<spi_event: !hw.struct<d: i1, de: i1>, error: !hw.struct<d: i1, de: i1>>>
    %29 = llhd.sig.struct_extract %28["de"] : <!hw.struct<d: i1, de: i1>>
    %30 = llhd.sig.struct_extract %28["d"] : <!hw.struct<d: i1, de: i1>>
    %intr_hw_error.hw2reg_intr_state_de_o, %intr_hw_error.hw2reg_intr_state_d_o, %intr_hw_error.intr_o = hw.instance "intr_hw_error" @prim_intr_hw(clk_i: %10: i1, rst_ni: %11: i1, event_intr_i: %169: i1, reg2hw_intr_enable_q_i: %q: i1, reg2hw_intr_test_q_i: %q_3: i1, reg2hw_intr_test_qe_i: %qe: i1, reg2hw_intr_state_q_i: %q_5: i1) -> (hw2reg_intr_state_de_o: i1, hw2reg_intr_state_d_o: i1, intr_o: i1)
    llhd.drv %29, %intr_hw_error.hw2reg_intr_state_de_o after %1 : i1
    llhd.drv %30, %intr_hw_error.hw2reg_intr_state_d_o after %1 : i1
    %spi_event = hw.struct_extract %intr_enable["spi_event"] : !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>
    %q_6 = hw.struct_extract %spi_event["q"] : !hw.struct<q: i1>
    %spi_event_7 = hw.struct_extract %intr_test["spi_event"] : !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>
    %q_8 = hw.struct_extract %spi_event_7["q"] : !hw.struct<q: i1, qe: i1>
    %qe_9 = hw.struct_extract %spi_event_7["qe"] : !hw.struct<q: i1, qe: i1>
    %spi_event_10 = hw.struct_extract %intr_state["spi_event"] : !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>
    %q_11 = hw.struct_extract %spi_event_10["q"] : !hw.struct<q: i1>
    %31 = llhd.sig.struct_extract %27["spi_event"] : <!hw.struct<spi_event: !hw.struct<d: i1, de: i1>, error: !hw.struct<d: i1, de: i1>>>
    %32 = llhd.sig.struct_extract %31["de"] : <!hw.struct<d: i1, de: i1>>
    %33 = llhd.sig.struct_extract %31["d"] : <!hw.struct<d: i1, de: i1>>
    %intr_hw_spi_event.hw2reg_intr_state_de_o, %intr_hw_spi_event.hw2reg_intr_state_d_o, %intr_hw_spi_event.intr_o = hw.instance "intr_hw_spi_event" @prim_intr_hw_0(clk_i: %10: i1, rst_ni: %11: i1, event_intr_i: %175: i1, reg2hw_intr_enable_q_i: %q_6: i1, reg2hw_intr_test_q_i: %q_8: i1, reg2hw_intr_test_qe_i: %qe_9: i1, reg2hw_intr_state_q_i: %q_11: i1) -> (hw2reg_intr_state_de_o: i1, hw2reg_intr_state_d_o: i1, intr_o: i1)
    llhd.drv %32, %intr_hw_spi_event.hw2reg_intr_state_de_o after %1 : i1
    llhd.drv %33, %intr_hw_spi_event.hw2reg_intr_state_d_o after %1 : i1
    %34 = llhd.prb %racl_error : !hw.array<3xstruct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    %35 = llhd.prb %gen_no_racl_error_arb.unused_signals : i1
    %36 = llhd.prb %racl_error_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %179 = llhd.prb %racl_error : !hw.array<3xstruct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
      %180 = hw.array_get %179[%c-2_i2] : !hw.array<3xstruct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>, i2
      %181 = hw.array_get %179[%c1_i2] : !hw.array<3xstruct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>, i2
      %182 = hw.bitcast %180 : (!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>) -> i37
      %183 = hw.bitcast %181 : (!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>) -> i37
      %184 = hw.array_get %179[%c0_i2] : !hw.array<3xstruct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>, i2
      %185 = hw.bitcast %184 : (!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>) -> i37
      %186 = comb.xor %182, %183, %185 : i37
      %187 = comb.parity %186 : i37
      llhd.drv %gen_no_racl_error_arb.unused_signals, %187 after %1 : i1
      llhd.drv %racl_error_o, %8 after %1 : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
      llhd.wait (%34, %35, %36 : !hw.array<3xstruct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>, i1, !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>), ^bb1
    }
    %alert_test = hw.struct_extract %26["alert_test"] : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
    %q_12 = hw.struct_extract %alert_test["q"] : !hw.struct<q: i1, qe: i1>
    %qe_13 = hw.struct_extract %alert_test["qe"] : !hw.struct<q: i1, qe: i1>
    %37 = comb.and %q_12, %qe_13 : i1
    %control = hw.struct_extract %26["control"] : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
    %output_en_14 = hw.struct_extract %control["output_en"] : !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>
    %38 = hw.bitcast %output_en_14 : (!hw.struct<q: i1>) -> i1
    llhd.drv %output_en, %38 after %1 : i1
    %39 = llhd.prb %output_en : i1
    %40 = llhd.prb %sd_en_core : i4
    %41 = comb.mux %39, %40, %c0_i4 : i4
    llhd.drv %sd_en, %41 after %1 : i4
    %passthrough_en = hw.struct_extract %passthrough_i["passthrough_en"] {sv.namehint = "gen_passthrough_implementation.passthrough_en"} : !hw.struct<passthrough_en: i1, sck: i1, sck_en: i1, csb: i1, csb_en: i1, s: i4, s_en: i4>
    %sck_15 = hw.struct_extract %passthrough_i["sck"] : !hw.struct<passthrough_en: i1, sck: i1, sck_en: i1, csb: i1, csb_en: i1, s: i4, s_en: i4>
    llhd.drv %gen_passthrough_implementation.pt_sck, %sck_15 after %1 : i1
    %sck_en = hw.struct_extract %passthrough_i["sck_en"] : !hw.struct<passthrough_en: i1, sck: i1, sck_en: i1, csb: i1, csb_en: i1, s: i4, s_en: i4>
    llhd.drv %gen_passthrough_implementation.pt_sck_en, %sck_en after %1 : i1
    %csb_16 = hw.struct_extract %passthrough_i["csb"] : !hw.struct<passthrough_en: i1, sck: i1, sck_en: i1, csb: i1, csb_en: i1, s: i4, s_en: i4>
    llhd.drv %gen_passthrough_implementation.pt_csb, %csb_16 after %1 : i1
    %csb_en = hw.struct_extract %passthrough_i["csb_en"] : !hw.struct<passthrough_en: i1, sck: i1, sck_en: i1, csb: i1, csb_en: i1, s: i4, s_en: i4>
    llhd.drv %gen_passthrough_implementation.pt_csb_en, %csb_en after %1 : i1
    %s = hw.struct_extract %passthrough_i["s"] : !hw.struct<passthrough_en: i1, sck: i1, sck_en: i1, csb: i1, csb_en: i1, s: i4, s_en: i4>
    llhd.drv %gen_passthrough_implementation.pt_sd_out, %s after %1 : i4
    %s_en = hw.struct_extract %passthrough_i["s_en"] : !hw.struct<passthrough_en: i1, sck: i1, sck_en: i1, csb: i1, csb_en: i1, s: i4, s_en: i4>
    llhd.drv %gen_passthrough_implementation.pt_sd_en, %s_en after %1 : i4
    %42 = llhd.prb %gen_passthrough_implementation.pt_sck : i1
    %43 = llhd.prb %sck : i1
    %44 = comb.mux %passthrough_en, %42, %43 : i1
    %45 = llhd.prb %gen_passthrough_implementation.pt_sck_en : i1
    %46 = comb.mux %passthrough_en, %45, %39 : i1
    %47 = llhd.prb %gen_passthrough_implementation.pt_csb : i1
    %48 = llhd.prb %csb : i1
    %49 = comb.mux %passthrough_en, %47, %48 : i1
    %50 = llhd.prb %gen_passthrough_implementation.pt_csb_en : i1
    %51 = comb.mux %passthrough_en, %50, %39 : i1
    %52 = llhd.prb %gen_passthrough_implementation.pt_sd_out : i4
    %53 = llhd.prb %sd_out : i4
    %54 = comb.mux %passthrough_en, %52, %53 : i4
    %55 = llhd.prb %gen_passthrough_implementation.pt_sd_en : i4
    %56 = llhd.prb %sd_en : i4
    %57 = comb.mux %passthrough_en, %55, %56 : i4
    %58 = llhd.sig.struct_extract %passthrough_o["s"] : <!hw.struct<s: i4>>
    llhd.drv %58, %cio_sd_i after %1 : i4
    %59 = llhd.sig.struct_extract %hw2reg["status"] : <!hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<d: i1, de: i1>, error: !hw.struct<d: i1, de: i1>>, status: !hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>, error_status: !hw.struct<accessinval: !hw.struct<d: i1, de: i1>, csidinval: !hw.struct<d: i1, de: i1>, cmdinval: !hw.struct<d: i1, de: i1>, underflow: !hw.struct<d: i1, de: i1>, overflow: !hw.struct<d: i1, de: i1>, cmdbusy: !hw.struct<d: i1, de: i1>>>>
    %60 = llhd.sig.struct_extract %59["byteorder"] : <!hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>>
    %61 = llhd.sig.struct_extract %60["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %61, %true after %1 : i1
    %62 = llhd.sig.struct_extract %60["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %62, %true after %1 : i1
    %csid = hw.struct_extract %26["csid"] : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
    %q_17 = hw.struct_extract %csid["q"] : !hw.struct<q: i32>
    %63 = comb.icmp ne %q_17, %c0_i32 {sv.namehint = "test_csid_inval"} : i32
    %64 = llhd.prb %test_speed_inval : i1
    %65 = llhd.prb %test_dir_inval : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      llhd.drv %test_speed_inval, %true after %1 : i1
      llhd.drv %test_dir_inval, %true after %1 : i1
      %179 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
      %command_59 = hw.struct_extract %179["command"] : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
      %speed_60 = hw.struct_extract %command_59["speed"] : !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>
      %q_61 = hw.struct_extract %speed_60["q"] : !hw.struct<q: i2, qe: i1>
      %180 = comb.icmp ceq %q_61, %c0_i2 : i2
      cf.cond_br %180, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      llhd.drv %test_dir_inval, %false after %1 : i1
      llhd.drv %test_speed_inval, %false after %1 : i1
      cf.br ^bb6
    ^bb3:  // pred: ^bb1
      %181 = comb.icmp ceq %q_61, %c1_i2 : i2
      cf.cond_br %181, ^bb5, ^bb4
    ^bb4:  // pred: ^bb3
      %182 = comb.icmp ceq %q_61, %c-2_i2 : i2
      cf.cond_br %182, ^bb5, ^bb6
    ^bb5:  // 2 preds: ^bb3, ^bb4
      %183 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
      %command_62 = hw.struct_extract %183["command"] : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
      %direction_63 = hw.struct_extract %command_62["direction"] : !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>
      %q_64 = hw.struct_extract %direction_63["q"] : !hw.struct<q: i2, qe: i1>
      %184 = comb.icmp eq %q_64, %c-1_i2 : i2
      llhd.drv %test_dir_inval, %184 after %1 : i1
      llhd.drv %test_speed_inval, %false after %1 : i1
      cf.br ^bb6
    ^bb6:  // 3 preds: ^bb2, ^bb4, ^bb5
      llhd.wait (%64, %65, %26 : i1, i1, !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb7
      %179 = llhd.sig.struct_extract %command["segment"] : <!hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>>
      %180 = llhd.sig.struct_extract %179["cmd_rd_en"] : <!hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>>
      llhd.drv %180, %false after %1 : i1
      %181 = llhd.sig.struct_extract %179["cmd_wr_en"] : <!hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>>
      llhd.drv %181, %false after %1 : i1
      %182 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
      %command_59 = hw.struct_extract %182["command"] : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
      %direction_60 = hw.struct_extract %command_59["direction"] : !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>
      %q_61 = hw.struct_extract %direction_60["q"] : !hw.struct<q: i2, qe: i1>
      %183 = comb.icmp ceq %q_61, %c1_i2 : i2
      cf.cond_br %183, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      llhd.drv %180, %true after %1 : i1
      cf.br ^bb7
    ^bb3:  // pred: ^bb1
      %184 = comb.icmp ceq %q_61, %c-2_i2 : i2
      cf.cond_br %184, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %181, %true after %1 : i1
      cf.br ^bb7
    ^bb5:  // pred: ^bb3
      %185 = comb.icmp ceq %q_61, %c-1_i2 : i2
      cf.cond_br %185, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %180, %true after %1 : i1
      llhd.drv %181, %true after %1 : i1
      cf.br ^bb7
    ^bb7:  // 4 preds: ^bb2, ^bb4, ^bb5, ^bb6
      llhd.wait (%18, %26 : !hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>, !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>), ^bb1
    }
    %66 = comb.xor %u_cmd_queue.command_busy_o, %true {sv.namehint = "status_ready"} : i1
    %67 = comb.and %87, %66 : i1
    %68 = comb.and %67, %63 {sv.namehint = "error_csid_inval"} : i1
    %69 = comb.or %64, %65 : i1
    %70 = comb.and %67, %69 {sv.namehint = "error_cmd_inval"} : i1
    %71 = comb.extract %q_17 from 0 : (i32) -> i1
    %72 = comb.xor %63, %true : i1
    %73 = comb.and %72, %71 {sv.namehint = "command_csid"} : i1
    %74 = llhd.sig.struct_extract %command["configopts"] : <!hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>>
    %75 = llhd.sig.struct_extract %74["clkdiv"] : <!hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
    %configopts = hw.struct_extract %26["configopts"] : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
    %clkdiv = hw.struct_extract %configopts["clkdiv"] : !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>
    %q_18 = hw.struct_extract %clkdiv["q"] : !hw.struct<q: i16>
    llhd.drv %75, %q_18 after %1 : i16
    %76 = llhd.sig.struct_extract %74["csnidle"] : <!hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
    %csnidle = hw.struct_extract %configopts["csnidle"] : !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>
    %q_19 = hw.struct_extract %csnidle["q"] : !hw.struct<q: i4>
    llhd.drv %76, %q_19 after %1 : i4
    %77 = llhd.sig.struct_extract %74["csnlead"] : <!hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
    %csnlead = hw.struct_extract %configopts["csnlead"] : !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>
    %q_20 = hw.struct_extract %csnlead["q"] : !hw.struct<q: i4>
    llhd.drv %77, %q_20 after %1 : i4
    %78 = llhd.sig.struct_extract %74["csntrail"] : <!hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
    %csntrail = hw.struct_extract %configopts["csntrail"] : !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>
    %q_21 = hw.struct_extract %csntrail["q"] : !hw.struct<q: i4>
    llhd.drv %78, %q_21 after %1 : i4
    %79 = llhd.sig.struct_extract %74["full_cyc"] : <!hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
    %fullcyc = hw.struct_extract %configopts["fullcyc"] : !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>
    %q_22 = hw.struct_extract %fullcyc["q"] : !hw.struct<q: i1>
    llhd.drv %79, %q_22 after %1 : i1
    %80 = llhd.sig.struct_extract %74["cpha"] : <!hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
    %cpha = hw.struct_extract %configopts["cpha"] : !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>
    %q_23 = hw.struct_extract %cpha["q"] : !hw.struct<q: i1>
    llhd.drv %80, %q_23 after %1 : i1
    %81 = llhd.sig.struct_extract %74["cpol"] : <!hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>
    %cpol = hw.struct_extract %configopts["cpol"] : !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>
    %q_24 = hw.struct_extract %cpol["q"] : !hw.struct<q: i1>
    llhd.drv %81, %q_24 after %1 : i1
    %82 = llhd.sig.struct_extract %command["segment"] : <!hw.struct<segment: !hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>, configopts: !hw.struct<clkdiv: i16, csnidle: i4, csnlead: i4, csntrail: i4, full_cyc: i1, cpha: i1, cpol: i1>>>
    %83 = llhd.sig.struct_extract %82["len"] : <!hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>>
    %command_25 = hw.struct_extract %26["command"] : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
    %len = hw.struct_extract %command_25["len"] : !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>
    %q_26 = hw.struct_extract %len["q"] : !hw.struct<q: i20, qe: i1>
    llhd.drv %83, %q_26 after %1 : i20
    %84 = llhd.sig.struct_extract %82["csaat"] : <!hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>>
    %csaat = hw.struct_extract %command_25["csaat"] : !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>
    %q_27 = hw.struct_extract %csaat["q"] : !hw.struct<q: i1, qe: i1>
    llhd.drv %84, %q_27 after %1 : i1
    %85 = llhd.sig.struct_extract %82["speed"] : <!hw.struct<speed: i2, cmd_wr_en: i1, cmd_rd_en: i1, len: i20, csaat: i1>>
    %speed = hw.struct_extract %command_25["speed"] : !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>
    %q_28 = hw.struct_extract %speed["q"] : !hw.struct<q: i2, qe: i1>
    llhd.drv %85, %q_28 after %1 : i2
    %qe_29 = hw.struct_extract %len["qe"] : !hw.struct<q: i20, qe: i1>
    %qe_30 = hw.struct_extract %speed["qe"] : !hw.struct<q: i2, qe: i1>
    %direction = hw.struct_extract %command_25["direction"] : !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>
    %qe_31 = hw.struct_extract %direction["qe"] : !hw.struct<q: i2, qe: i1>
    %qe_32 = hw.struct_extract %csaat["qe"] : !hw.struct<q: i1, qe: i1>
    %86 = comb.concat %qe_29, %qe_30, %qe_31, %qe_32 {sv.namehint = "cmd_qes"} : i1, i1, i1, i1
    %87 = comb.icmp ne %86, %c0_i4 {sv.namehint = "command_valid"} : i4
    %88 = llhd.sig.struct_extract %59["ready"] : <!hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>>
    %89 = llhd.sig.struct_extract %88["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %89, %66 after %1 : i1
    %90 = llhd.sig.struct_extract %59["active"] : <!hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>>
    %91 = llhd.sig.struct_extract %90["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %91, %u_spi_core.active_o after %1 : i1
    %92 = llhd.sig.struct_extract %59["rxstall"] : <!hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>>
    %93 = llhd.sig.struct_extract %92["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %93, %u_spi_core.rx_stall_o after %1 : i1
    %94 = llhd.sig.struct_extract %59["txstall"] : <!hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>>
    %95 = llhd.sig.struct_extract %94["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %95, %u_spi_core.tx_stall_o after %1 : i1
    %96 = llhd.sig.struct_extract %88["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %96, %true after %1 : i1
    %97 = llhd.sig.struct_extract %90["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %97, %true after %1 : i1
    %98 = llhd.sig.struct_extract %92["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %98, %true after %1 : i1
    %99 = llhd.sig.struct_extract %94["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %99, %true after %1 : i1
    %rx_watermark = hw.struct_extract %control["rx_watermark"] : !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>
    %q_33 = hw.struct_extract %rx_watermark["q"] {sv.namehint = "rx_watermark"} : !hw.struct<q: i8>
    %tx_watermark = hw.struct_extract %control["tx_watermark"] : !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>
    %q_34 = hw.struct_extract %tx_watermark["q"] {sv.namehint = "tx_watermark"} : !hw.struct<q: i8>
    %100 = llhd.sig.struct_extract %59["txqd"] : <!hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>>
    %101 = llhd.sig.struct_extract %100["d"] : <!hw.struct<d: i8, de: i1>>
    llhd.drv %101, %u_data_fifos.tx_qd_o after %1 : i8
    %102 = llhd.sig.struct_extract %59["rxqd"] : <!hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>>
    %103 = llhd.sig.struct_extract %102["d"] : <!hw.struct<d: i8, de: i1>>
    llhd.drv %103, %u_data_fifos.rx_qd_o after %1 : i8
    %104 = llhd.sig.struct_extract %59["cmdqd"] : <!hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>>
    %105 = llhd.sig.struct_extract %104["d"] : <!hw.struct<d: i4, de: i1>>
    llhd.drv %105, %u_cmd_queue.qd_o after %1 : i4
    %106 = llhd.sig.struct_extract %59["txwm"] : <!hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>>
    %107 = llhd.sig.struct_extract %106["d"] : <!hw.struct<d: i1, de: i1>>
    %108 = llhd.prb %tx_wm {sv.namehint = "status_tx_wm"} : i1
    llhd.drv %107, %108 after %1 : i1
    %109 = llhd.sig.struct_extract %59["rxwm"] : <!hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>>
    %110 = llhd.sig.struct_extract %109["d"] : <!hw.struct<d: i1, de: i1>>
    %111 = llhd.prb %rx_wm {sv.namehint = "status_rx_wm"} : i1
    llhd.drv %110, %111 after %1 : i1
    %112 = llhd.sig.struct_extract %59["rxempty"] : <!hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>>
    %113 = llhd.sig.struct_extract %112["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %113, %u_data_fifos.rx_empty_o after %1 : i1
    %114 = llhd.sig.struct_extract %59["txempty"] : <!hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>>
    %115 = llhd.sig.struct_extract %114["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %115, %u_data_fifos.tx_empty_o after %1 : i1
    %116 = llhd.sig.struct_extract %59["rxfull"] : <!hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>>
    %117 = llhd.sig.struct_extract %116["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %117, %u_data_fifos.rx_full_o after %1 : i1
    %118 = llhd.sig.struct_extract %59["txfull"] : <!hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>>
    %119 = llhd.sig.struct_extract %118["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %119, %u_data_fifos.tx_full_o after %1 : i1
    %120 = llhd.sig.struct_extract %100["de"] : <!hw.struct<d: i8, de: i1>>
    llhd.drv %120, %true after %1 : i1
    %121 = llhd.sig.struct_extract %102["de"] : <!hw.struct<d: i8, de: i1>>
    llhd.drv %121, %true after %1 : i1
    %122 = llhd.sig.struct_extract %104["de"] : <!hw.struct<d: i4, de: i1>>
    llhd.drv %122, %true after %1 : i1
    %123 = llhd.sig.struct_extract %106["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %123, %true after %1 : i1
    %124 = llhd.sig.struct_extract %109["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %124, %true after %1 : i1
    %125 = llhd.sig.struct_extract %112["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %125, %true after %1 : i1
    %126 = llhd.sig.struct_extract %114["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %126, %true after %1 : i1
    %127 = llhd.sig.struct_extract %116["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %127, %true after %1 : i1
    %128 = llhd.sig.struct_extract %118["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %128, %true after %1 : i1
    %129 = comb.xor %u_data_fifos.tx_ready_o, %true : i1
    %130 = comb.and %u_window.tx_valid_o, %129 {sv.namehint = "error_overflow"} : i1
    %131 = comb.xor %u_data_fifos.rx_valid_o, %true : i1
    %132 = comb.and %u_window.rx_ready_o, %131 {sv.namehint = "error_underflow"} : i1
    %133 = llhd.prb %access_valid : i1
    %134 = comb.xor %133, %true : i1
    %135 = comb.and %u_window.tx_valid_o, %134 {sv.namehint = "error_access_inval"} : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb11
      %179 = llhd.prb %tx_be : i4
      %180 = comb.icmp ceq %179, %c-8_i4 : i4
      cf.cond_br %180, ^bb9, ^bb2
    ^bb2:  // pred: ^bb1
      %181 = comb.icmp ceq %179, %c4_i4 : i4
      cf.cond_br %181, ^bb9, ^bb3
    ^bb3:  // pred: ^bb2
      %182 = comb.icmp ceq %179, %c2_i4 : i4
      cf.cond_br %182, ^bb9, ^bb4
    ^bb4:  // pred: ^bb3
      %183 = comb.icmp ceq %179, %c1_i4 : i4
      cf.cond_br %183, ^bb9, ^bb5
    ^bb5:  // pred: ^bb4
      %184 = comb.icmp ceq %179, %c-4_i4 : i4
      cf.cond_br %184, ^bb9, ^bb6
    ^bb6:  // pred: ^bb5
      %185 = comb.icmp ceq %179, %c6_i4 : i4
      cf.cond_br %185, ^bb9, ^bb7
    ^bb7:  // pred: ^bb6
      %186 = comb.icmp ceq %179, %c3_i4 : i4
      cf.cond_br %186, ^bb9, ^bb8
    ^bb8:  // pred: ^bb7
      %187 = comb.icmp ceq %179, %c-1_i4 : i4
      cf.cond_br %187, ^bb9, ^bb10
    ^bb9:  // 8 preds: ^bb1, ^bb2, ^bb3, ^bb4, ^bb5, ^bb6, ^bb7, ^bb8
      llhd.drv %access_valid, %true after %1 : i1
      cf.br ^bb11
    ^bb10:  // pred: ^bb8
      llhd.drv %access_valid, %false after %1 : i1
      cf.br ^bb11
    ^bb11:  // 2 preds: ^bb9, ^bb10
      llhd.wait (%25, %133 : i4, i1), ^bb1
    }
    %136 = comb.xor %130, %true : i1
    %137 = comb.xor %135, %true : i1
    %138 = comb.and %u_window.tx_valid_o, %136, %137 {sv.namehint = "tx_valid_checked"} : i1
    %139 = comb.icmp eq %170, %c0_i6 : i6
    %140 = comb.and %q_36, %139 {sv.namehint = "en"} : i1
    %sw_rst = hw.struct_extract %control["sw_rst"] : !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>
    %q_35 = hw.struct_extract %sw_rst["q"] {sv.namehint = "sw_rst"} : !hw.struct<q: i1>
    %spien = hw.struct_extract %control["spien"] : !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>
    %q_36 = hw.struct_extract %spien["q"] {sv.namehint = "en_sw"} : !hw.struct<q: i1>
    %141 = comb.concat %135, %68, %70, %132, %130, %u_cmd_queue.error_busy_o {sv.namehint = "error_vec"} : i1, i1, i1, i1, i1, i1
    %error_enable = hw.struct_extract %26["error_enable"] : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
    %csidinval = hw.struct_extract %error_enable["csidinval"] : !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>
    %q_37 = hw.struct_extract %csidinval["q"] : !hw.struct<q: i1>
    %cmdinval = hw.struct_extract %error_enable["cmdinval"] : !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>
    %q_38 = hw.struct_extract %cmdinval["q"] : !hw.struct<q: i1>
    %underflow = hw.struct_extract %error_enable["underflow"] : !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>
    %q_39 = hw.struct_extract %underflow["q"] : !hw.struct<q: i1>
    %overflow = hw.struct_extract %error_enable["overflow"] : !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>
    %q_40 = hw.struct_extract %overflow["q"] : !hw.struct<q: i1>
    %cmdbusy = hw.struct_extract %error_enable["cmdbusy"] : !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>
    %q_41 = hw.struct_extract %cmdbusy["q"] : !hw.struct<q: i1>
    %142 = comb.concat %true, %q_37, %q_38, %q_39, %q_40, %q_41 {sv.namehint = "error_mask"} : i1, i1, i1, i1, i1, i1
    %143 = llhd.sig.struct_extract %hw2reg["error_status"] : <!hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<d: i1, de: i1>, error: !hw.struct<d: i1, de: i1>>, status: !hw.struct<ready: !hw.struct<d: i1, de: i1>, active: !hw.struct<d: i1, de: i1>, txfull: !hw.struct<d: i1, de: i1>, txempty: !hw.struct<d: i1, de: i1>, txstall: !hw.struct<d: i1, de: i1>, txwm: !hw.struct<d: i1, de: i1>, rxfull: !hw.struct<d: i1, de: i1>, rxempty: !hw.struct<d: i1, de: i1>, rxstall: !hw.struct<d: i1, de: i1>, byteorder: !hw.struct<d: i1, de: i1>, rxwm: !hw.struct<d: i1, de: i1>, cmdqd: !hw.struct<d: i4, de: i1>, rxqd: !hw.struct<d: i8, de: i1>, txqd: !hw.struct<d: i8, de: i1>>, error_status: !hw.struct<accessinval: !hw.struct<d: i1, de: i1>, csidinval: !hw.struct<d: i1, de: i1>, cmdinval: !hw.struct<d: i1, de: i1>, underflow: !hw.struct<d: i1, de: i1>, overflow: !hw.struct<d: i1, de: i1>, cmdbusy: !hw.struct<d: i1, de: i1>>>>
    %144 = llhd.sig.struct_extract %143["accessinval"] : <!hw.struct<accessinval: !hw.struct<d: i1, de: i1>, csidinval: !hw.struct<d: i1, de: i1>, cmdinval: !hw.struct<d: i1, de: i1>, underflow: !hw.struct<d: i1, de: i1>, overflow: !hw.struct<d: i1, de: i1>, cmdbusy: !hw.struct<d: i1, de: i1>>>
    %145 = llhd.sig.struct_extract %144["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %145, %135 after %1 : i1
    %146 = llhd.sig.struct_extract %143["csidinval"] : <!hw.struct<accessinval: !hw.struct<d: i1, de: i1>, csidinval: !hw.struct<d: i1, de: i1>, cmdinval: !hw.struct<d: i1, de: i1>, underflow: !hw.struct<d: i1, de: i1>, overflow: !hw.struct<d: i1, de: i1>, cmdbusy: !hw.struct<d: i1, de: i1>>>
    %147 = llhd.sig.struct_extract %146["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %147, %68 after %1 : i1
    %148 = llhd.sig.struct_extract %143["cmdinval"] : <!hw.struct<accessinval: !hw.struct<d: i1, de: i1>, csidinval: !hw.struct<d: i1, de: i1>, cmdinval: !hw.struct<d: i1, de: i1>, underflow: !hw.struct<d: i1, de: i1>, overflow: !hw.struct<d: i1, de: i1>, cmdbusy: !hw.struct<d: i1, de: i1>>>
    %149 = llhd.sig.struct_extract %148["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %149, %70 after %1 : i1
    %150 = llhd.sig.struct_extract %143["underflow"] : <!hw.struct<accessinval: !hw.struct<d: i1, de: i1>, csidinval: !hw.struct<d: i1, de: i1>, cmdinval: !hw.struct<d: i1, de: i1>, underflow: !hw.struct<d: i1, de: i1>, overflow: !hw.struct<d: i1, de: i1>, cmdbusy: !hw.struct<d: i1, de: i1>>>
    %151 = llhd.sig.struct_extract %150["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %151, %132 after %1 : i1
    %152 = llhd.sig.struct_extract %143["overflow"] : <!hw.struct<accessinval: !hw.struct<d: i1, de: i1>, csidinval: !hw.struct<d: i1, de: i1>, cmdinval: !hw.struct<d: i1, de: i1>, underflow: !hw.struct<d: i1, de: i1>, overflow: !hw.struct<d: i1, de: i1>, cmdbusy: !hw.struct<d: i1, de: i1>>>
    %153 = llhd.sig.struct_extract %152["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %153, %130 after %1 : i1
    %154 = llhd.sig.struct_extract %143["cmdbusy"] : <!hw.struct<accessinval: !hw.struct<d: i1, de: i1>, csidinval: !hw.struct<d: i1, de: i1>, cmdinval: !hw.struct<d: i1, de: i1>, underflow: !hw.struct<d: i1, de: i1>, overflow: !hw.struct<d: i1, de: i1>, cmdbusy: !hw.struct<d: i1, de: i1>>>
    %155 = llhd.sig.struct_extract %154["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %155, %u_cmd_queue.error_busy_o after %1 : i1
    %156 = llhd.sig.struct_extract %144["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %156, %135 after %1 : i1
    %157 = llhd.sig.struct_extract %146["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %157, %68 after %1 : i1
    %158 = llhd.sig.struct_extract %148["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %158, %70 after %1 : i1
    %159 = llhd.sig.struct_extract %150["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %159, %132 after %1 : i1
    %160 = llhd.sig.struct_extract %152["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %160, %130 after %1 : i1
    %161 = llhd.sig.struct_extract %154["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %161, %u_cmd_queue.error_busy_o after %1 : i1
    %162 = llhd.sig.extract %sw_error_status from %c-3_i3 : <i6> -> <i1>
    %error_status = hw.struct_extract %26["error_status"] : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
    %accessinval = hw.struct_extract %error_status["accessinval"] : !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>
    %q_42 = hw.struct_extract %accessinval["q"] : !hw.struct<q: i1>
    llhd.drv %162, %q_42 after %1 : i1
    %163 = llhd.sig.extract %sw_error_status from %c-4_i3 : <i6> -> <i1>
    %csidinval_43 = hw.struct_extract %error_status["csidinval"] : !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>
    %q_44 = hw.struct_extract %csidinval_43["q"] : !hw.struct<q: i1>
    llhd.drv %163, %q_44 after %1 : i1
    %164 = llhd.sig.extract %sw_error_status from %c3_i3 : <i6> -> <i1>
    %cmdinval_45 = hw.struct_extract %error_status["cmdinval"] : !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>
    %q_46 = hw.struct_extract %cmdinval_45["q"] : !hw.struct<q: i1>
    llhd.drv %164, %q_46 after %1 : i1
    %165 = llhd.sig.extract %sw_error_status from %c2_i3 : <i6> -> <i1>
    %underflow_47 = hw.struct_extract %error_status["underflow"] : !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>
    %q_48 = hw.struct_extract %underflow_47["q"] : !hw.struct<q: i1>
    llhd.drv %165, %q_48 after %1 : i1
    %166 = llhd.sig.extract %sw_error_status from %c1_i3 : <i6> -> <i1>
    %overflow_49 = hw.struct_extract %error_status["overflow"] : !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>
    %q_50 = hw.struct_extract %overflow_49["q"] : !hw.struct<q: i1>
    llhd.drv %166, %q_50 after %1 : i1
    %167 = llhd.sig.extract %sw_error_status from %c0_i3 : <i6> -> <i1>
    %cmdbusy_51 = hw.struct_extract %error_status["cmdbusy"] : !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>
    %q_52 = hw.struct_extract %cmdbusy_51["q"] : !hw.struct<q: i1>
    llhd.drv %167, %q_52 after %1 : i1
    %168 = comb.and %141, %142 : i6
    %169 = comb.icmp ne %168, %c0_i6 {sv.namehint = "event_error"} : i6
    %170 = llhd.prb %sw_error_status : i6
    %171 = comb.xor %u_spi_core.active_o, %true {sv.namehint = "status_idle"} : i1
    %172 = comb.concat %171, %66, %108, %111, %u_data_fifos.tx_empty_o, %u_data_fifos.rx_full_o {sv.namehint = "event_vector"} : i1, i1, i1, i1, i1, i1
    %event_enable = hw.struct_extract %26["event_enable"] : !hw.struct<intr_state: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_enable: !hw.struct<spi_event: !hw.struct<q: i1>, error: !hw.struct<q: i1>>, intr_test: !hw.struct<spi_event: !hw.struct<q: i1, qe: i1>, error: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, control: !hw.struct<spien: !hw.struct<q: i1>, sw_rst: !hw.struct<q: i1>, output_en: !hw.struct<q: i1>, tx_watermark: !hw.struct<q: i8>, rx_watermark: !hw.struct<q: i8>>, configopts: !hw.struct<cpol: !hw.struct<q: i1>, cpha: !hw.struct<q: i1>, fullcyc: !hw.struct<q: i1>, csnlead: !hw.struct<q: i4>, csntrail: !hw.struct<q: i4>, csnidle: !hw.struct<q: i4>, clkdiv: !hw.struct<q: i16>>, csid: !hw.struct<q: i32>, command: !hw.struct<len: !hw.struct<q: i20, qe: i1>, direction: !hw.struct<q: i2, qe: i1>, speed: !hw.struct<q: i2, qe: i1>, csaat: !hw.struct<q: i1, qe: i1>>, error_enable: !hw.struct<csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, error_status: !hw.struct<accessinval: !hw.struct<q: i1>, csidinval: !hw.struct<q: i1>, cmdinval: !hw.struct<q: i1>, underflow: !hw.struct<q: i1>, overflow: !hw.struct<q: i1>, cmdbusy: !hw.struct<q: i1>>, event_enable: !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>>
    %idle = hw.struct_extract %event_enable["idle"] : !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>
    %q_53 = hw.struct_extract %idle["q"] : !hw.struct<q: i1>
    %ready = hw.struct_extract %event_enable["ready"] : !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>
    %q_54 = hw.struct_extract %ready["q"] : !hw.struct<q: i1>
    %txwm = hw.struct_extract %event_enable["txwm"] : !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>
    %q_55 = hw.struct_extract %txwm["q"] : !hw.struct<q: i1>
    %rxwm = hw.struct_extract %event_enable["rxwm"] : !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>
    %q_56 = hw.struct_extract %rxwm["q"] : !hw.struct<q: i1>
    %txempty = hw.struct_extract %event_enable["txempty"] : !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>
    %q_57 = hw.struct_extract %txempty["q"] : !hw.struct<q: i1>
    %rxfull = hw.struct_extract %event_enable["rxfull"] : !hw.struct<idle: !hw.struct<q: i1>, ready: !hw.struct<q: i1>, txwm: !hw.struct<q: i1>, rxwm: !hw.struct<q: i1>, txempty: !hw.struct<q: i1>, rxfull: !hw.struct<q: i1>>
    %q_58 = hw.struct_extract %rxfull["q"] : !hw.struct<q: i1>
    %173 = comb.concat %q_53, %q_54, %q_55, %q_56, %q_57, %q_58 {sv.namehint = "event_mask"} : i1, i1, i1, i1, i1, i1
    %174 = comb.and %172, %173 : i6
    %175 = comb.icmp ne %174, %c0_i6 {sv.namehint = "status_spi_event"} : i6
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %179 = llhd.prb %clk_i_0 : i1
      %180 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%10, %11 : i1, i1), ^bb2
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
      llhd.drv %lsio_trigger_o, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %190 = llhd.prb %tx_wm : i1
      %191 = llhd.prb %rx_wm : i1
      %192 = comb.or %190, %191 : i1
      llhd.drv %lsio_trigger_o, %192 after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    %176 = llhd.prb %alert_tx_o : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    %177 = llhd.prb %passthrough_o : !hw.struct<s: i4>
    %178 = llhd.prb %lsio_trigger_o : i1
    hw.output %u_reg.tl_o, %176, %36, %44, %46, %49, %51, %54, %57, %177, %178, %intr_hw_error.intr_o, %intr_hw_spi_event.intr_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.array<1xstruct<alert_p: i1, alert_n: i1>>, !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, i1, i1, i1, i1, i4, i4, !hw.struct<s: i4>, i1, i1, i1
  }
}
