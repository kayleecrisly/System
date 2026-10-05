module {
  hw.module private @prim_buf(in %in_i : i2, out out_o : i2) {
    hw.output %in_i : i2
  }
  hw.module private @prim_buf_7(in %in_i : i1, out out_o : i1) {
    hw.output %in_i : i1
  }
  hw.module private @prim_buf_9(in %in_i : i18, out out_o : i18) {
    hw.output %in_i : i18
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
  hw.module private @prim_flop_2sync_6(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %d_i_0 = llhd.sig name "d_i" %false : i1
    %d_o = llhd.sig %false : i1
    %1 = llhd.prb %d_o : i1
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_14(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i1) -> (q_o: i1) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_14(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i1) -> (q_o: i1)
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
  hw.module private @prim_flop_8(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_o : i2) {
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
  hw.module private @prim_flop_14(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
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
    %u_prim_buf_in_req.out_o = hw.instance "u_prim_buf_in_req" @prim_sec_anchor_buf_0(in_i: %alert_req_i: i1) -> (out_o: i1) {sv.namehint = "alert_req"}
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
    %gen_async.i_sync_n.q_o = hw.instance "gen_async.i_sync_n" @prim_flop_2sync_6(clk_i: %2: i1, rst_ni: %3: i1, d_i: %diff_ni: i1) -> (q_o: i1)
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
  hw.module private @prim_filter_ctr(in %clk_i : i1, in %rst_ni : i1, in %enable_i : i1, in %filter_i : i1, in %thresh_i : i4, out filter_o : i1) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c1_i4 = hw.constant 1 : i4
    %c0_i4 = hw.constant 0 : i4
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %thresh_i_2 = llhd.sig name "thresh_i" %c0_i4 : i4
    %diff_ctr_q = llhd.sig %c0_i4 : i4
    %diff_ctr_d = llhd.sig %c0_i4 : i4
    %filter_q = llhd.sig %false : i1
    %stored_value_q = llhd.sig %false : i1
    %update_stored_value = llhd.sig %false : i1
    %filter_synced = llhd.sig %false : i1
    %gen_async.prim_flop_2sync.q_o = hw.instance "gen_async.prim_flop_2sync" @prim_flop_2sync(clk_i: %2: i1, rst_ni: %3: i1, d_i: %filter_i: i1) -> (q_o: i1)
    llhd.drv %filter_synced, %gen_async.prim_flop_2sync.q_o after %1 : i1
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
      llhd.drv %filter_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %28 = llhd.prb %filter_synced : i1
      llhd.drv %filter_q, %28 after %0 : i1
      cf.br ^bb1
    }
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
      llhd.drv %stored_value_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %28 = llhd.prb %update_stored_value : i1
      cf.cond_br %28, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %29 = llhd.prb %filter_synced : i1
      llhd.drv %stored_value_q, %29 after %0 : i1
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
      llhd.drv %diff_ctr_q, %c0_i4 after %0 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %28 = llhd.prb %diff_ctr_d : i4
      llhd.drv %diff_ctr_q, %28 after %0 : i4
      cf.br ^bb1
    }
    %4 = llhd.prb %diff_ctr_d : i4
    %5 = llhd.prb %thresh_i_2 : i4
    %6 = comb.icmp eq %4, %5 : i4
    llhd.drv %update_stored_value, %6 after %1 : i1
    %7 = llhd.prb %filter_synced : i1
    %8 = llhd.prb %filter_q : i1
    %9 = comb.icmp ne %7, %8 : i1
    %10 = llhd.prb %diff_ctr_q : i4
    %11 = comb.icmp uge %10, %5 : i4
    %12 = comb.add %10, %c1_i4 : i4
    %13 = comb.mux %11, %5, %12 : i4
    %14 = comb.mux %9, %c0_i4, %13 : i4
    llhd.drv %diff_ctr_d, %14 after %1 : i4
    %15 = llhd.prb %stored_value_q : i1
    %16 = comb.mux %enable_i, %15, %7 : i1
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %thresh_i_2, %thresh_i after %1 : i4
    hw.output %16 : i1
  }
  hw.module private @prim_intr_hw(in %clk_i : i1, in %rst_ni : i1, in %event_intr_i : i32, in %reg2hw_intr_enable_q_i : i32, in %reg2hw_intr_test_q_i : i32, in %reg2hw_intr_test_qe_i : i1, in %reg2hw_intr_state_q_i : i32, out hw2reg_intr_state_de_o : i1, out hw2reg_intr_state_d_o : i32, out intr_o : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %reg2hw_intr_enable_q_i_2 = llhd.sig name "reg2hw_intr_enable_q_i" %c0_i32 : i32
    %intr_o = llhd.sig %c0_i32 : i32
    %status = llhd.sig %c0_i32 : i32
    %4 = comb.replicate %reg2hw_intr_test_qe_i : (i1) -> i32
    %5 = comb.and %4, %reg2hw_intr_test_q_i : i32
    %6 = comb.or %5, %event_intr_i {sv.namehint = "g_intr_event.new_event"} : i32
    %7 = comb.icmp ne %6, %c0_i32 : i32
    %8 = comb.or %6, %reg2hw_intr_state_q_i : i32
    llhd.drv %status, %reg2hw_intr_state_q_i after %1 : i32
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
      llhd.drv %intr_o, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %21 = llhd.prb %status : i32
      %22 = llhd.prb %reg2hw_intr_enable_q_i_2 : i32
      %23 = comb.and %21, %22 : i32
      llhd.drv %intr_o, %23 after %0 : i32
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %reg2hw_intr_enable_q_i_2, %reg2hw_intr_enable_q_i after %1 : i32
    %9 = llhd.prb %intr_o : i32
    hw.output %7, %8, %9 : i1, i32, i32
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
  hw.module private @prim_reg_we_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i18, in %en_i : i1, out err_o : i1) {
    %c0_i5 = hw.constant 0 : i5
    %u_prim_buf.out_o = hw.instance "u_prim_buf" @prim_buf_9(in_i: %oh_i: i18) -> (out_o: i18) {sv.namehint = "oh_buf"}
    %u_prim_onehot_check.err_o = hw.instance "u_prim_onehot_check" @prim_onehot_check(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, oh_i: %u_prim_buf.out_o: i18, addr_i: %c0_i5: i5, en_i: %en_i: i1) -> (err_o: i1)
    hw.output %u_prim_onehot_check.err_o : i1
  }
  hw.module private @prim_sec_anchor_buf(in %in_i : i2, out out_o : i2) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf(in_i: %in_i: i2) -> (out_o: i2)
    hw.output %u_secure_anchor_buf.out_o : i2
  }
  hw.module private @prim_sec_anchor_buf_0(in %in_i : i1, out out_o : i1) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf_7(in_i: %in_i: i1) -> (out_o: i1)
    hw.output %u_secure_anchor_buf.out_o : i1
  }
  hw.module private @prim_sec_anchor_flop(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_o : i2) {
    %u_secure_anchor_flop.q_o = hw.instance "u_secure_anchor_flop" @prim_flop_8(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %d_i: i2) -> (q_o: i2)
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
  hw.module private @prim_subreg_arb(in %we : i1, in %wd : i32, in %de : i1, in %d : i32, in %q : i32, out wr_en : i1, out wr_data : i32) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c-1_i32 = hw.constant -1 : i32
    %c0_i32 = hw.constant 0 : i32
    %wd_0 = llhd.sig name "wd" %c0_i32 : i32
    %d_1 = llhd.sig name "d" %c0_i32 : i32
    %q_2 = llhd.sig name "q" %c0_i32 : i32
    %1 = comb.or %we, %de : i1
    %2 = llhd.prb %d_1 : i32
    %3 = llhd.prb %q_2 : i32
    %4 = comb.mux %de, %2, %3 : i32
    %5 = llhd.prb %wd_0 : i32
    %6 = comb.replicate %we : (i1) -> i32
    %7 = comb.and %6, %5 : i32
    %8 = comb.xor %7, %c-1_i32 : i32
    %9 = comb.and %4, %8 : i32
    llhd.drv %wd_0, %wd after %0 : i32
    llhd.drv %d_1, %d after %0 : i32
    llhd.drv %q_2, %q after %0 : i32
    hw.output %1, %9 : i1, i32
  }
  hw.module private @prim_subreg_arb_11(in %we : i1, in %wd : i32, in %de : i1, in %d : i32, in %q : i32, out wr_en : i1, out wr_data : i32) {
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
  hw.module private @prim_subreg_arb_12(in %we : i1, in %wd : i32, in %de : i1, in %d : i32, in %q : i32, out wr_en : i1, out wr_data : i32) {
    hw.output %de, %d : i1, i32
  }
  hw.module private @prim_subreg_arb_13(in %we : i1, in %wd : i1, in %de : i1, in %d : i1, in %q : i1, out wr_en : i1, out wr_data : i1) {
    hw.output %de, %d : i1, i1
  }
  hw.module private @prim_subreg_ext(in %re : i1, in %we : i1, in %wd : i32, in %d : i32, out qe : i1, out qre : i1, out q : i32, out ds : i32, out qs : i32) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i32, i32, i32
  }
  hw.module private @prim_subreg_ext_2(in %re : i1, in %we : i1, in %wd : i1, in %d : i1, out qe : i1, out qre : i1, out q : i1, out ds : i1, out qs : i1) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i1, i1, i1
  }
  hw.module private @prim_subreg_ext_4(in %re : i1, in %we : i1, in %wd : i16, in %d : i16, out qe : i1, out qre : i1, out q : i16, out ds : i16, out qs : i16) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i16, i16, i16
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
  hw.module private @prim_subreg_1(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_11(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
  hw.module private @prim_subreg_3(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i32, in %de : i1, in %d : i32, out qe : i1, out q : i32, out ds : i32, out qs : i32) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_12(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_13(we: %we: i1, wd: %wd: i1, de: %de: i1, d: %d: i1, q: %4: i1) -> (wr_en: i1, wr_data: i1)
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
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen_10(tl_i: %32: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
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
  hw.module private @tlul_rsp_intg_gen_10(in %tl_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) {
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
  hw.module private @gpio_reg_top(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out reg2hw : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>, in %hw2reg : !hw.struct<intr_state: !hw.struct<d: i32, de: i1>, data_in: !hw.struct<d: i32, de: i1>, direct_out: !hw.struct<d: i32>, masked_out_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_out_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, direct_oe: !hw.struct<d: i32>, masked_oe_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_oe_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, hw_straps_data_in_valid: !hw.struct<d: i1, de: i1>, hw_straps_data_in: !hw.struct<d: i32, de: i1>>, in %racl_policies_i : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, out racl_error_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, out intg_err_o : i1) {
    %c-1_i4 = hw.constant -1 : i4
    %c0_i25 = hw.constant 0 : i25
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
    %c-1_i2 = hw.constant -1 : i2
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %2 = hw.aggregate_constant [false, false, false, false, false, 0 : i32] : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %3 = hw.aggregate_constant [[0 : i2, 0 : i2]] : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    %4 = hw.aggregate_constant [[0 : i32], [0 : i32], [0 : i32, false], [false, false], [0 : i32, false], [[0 : i16, false], [0 : i16, false]], [[0 : i16, false], [0 : i16, false]], [0 : i32, false], [[0 : i16, false], [0 : i16, false]], [[0 : i16, false], [0 : i16, false]], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [false], [0 : i32]] : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
    %c-1_i32 = hw.constant -1 : i32
    %c0_i16 = hw.constant 0 : i16
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false {sv.namehint = "racl_role"}
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
    %c0_i18 = hw.constant 0 : i18
    %c0_i2 = hw.constant 0 : i2
    %true = hw.constant true
    %c-7_i4 = hw.constant -7 : i4
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %5 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %6 = llhd.prb %rst_ni_1 : i1
    %reg2hw = llhd.sig %4 : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
    %racl_policies_i_2 = llhd.sig name "racl_policies_i" %3 : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    %racl_error_o = llhd.sig %2 : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
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
    %intr_state_qs = llhd.sig %c0_i32 : i32
    %intr_enable_we = llhd.sig %false : i1
    %intr_enable_qs = llhd.sig %c0_i32 : i32
    %intr_test_we = llhd.sig %false : i1
    %alert_test_we = llhd.sig %false : i1
    %data_in_qs = llhd.sig %c0_i32 : i32
    %direct_out_we = llhd.sig %false : i1
    %direct_out_qs = llhd.sig %c0_i32 : i32
    %masked_out_lower_we = llhd.sig %false : i1
    %masked_out_lower_data_qs = llhd.sig %c0_i16 : i16
    %masked_out_upper_we = llhd.sig %false : i1
    %masked_out_upper_data_qs = llhd.sig %c0_i16 : i16
    %direct_oe_we = llhd.sig %false : i1
    %direct_oe_qs = llhd.sig %c0_i32 : i32
    %masked_oe_lower_we = llhd.sig %false : i1
    %masked_oe_lower_data_qs = llhd.sig %c0_i16 : i16
    %masked_oe_lower_mask_qs = llhd.sig %c0_i16 : i16
    %masked_oe_upper_we = llhd.sig %false : i1
    %masked_oe_upper_data_qs = llhd.sig %c0_i16 : i16
    %masked_oe_upper_mask_qs = llhd.sig %c0_i16 : i16
    %intr_ctrl_en_rising_we = llhd.sig %false : i1
    %intr_ctrl_en_rising_qs = llhd.sig %c0_i32 : i32
    %intr_ctrl_en_falling_we = llhd.sig %false : i1
    %intr_ctrl_en_falling_qs = llhd.sig %c0_i32 : i32
    %intr_ctrl_en_lvlhigh_we = llhd.sig %false : i1
    %intr_ctrl_en_lvlhigh_qs = llhd.sig %c0_i32 : i32
    %intr_ctrl_en_lvllow_we = llhd.sig %false : i1
    %intr_ctrl_en_lvllow_qs = llhd.sig %c0_i32 : i32
    %ctrl_en_input_filter_we = llhd.sig %false : i1
    %ctrl_en_input_filter_qs = llhd.sig %c0_i32 : i32
    %hw_straps_data_in_valid_qs = llhd.sig %false : i1
    %hw_straps_data_in_qs = llhd.sig %c0_i32 : i32
    %intr_test_flds_we = llhd.sig %false : i1
    %alert_test_flds_we = llhd.sig %false : i1
    %direct_out_flds_we = llhd.sig %false : i1
    %masked_out_lower_flds_we = llhd.sig %c0_i2 : i2
    %masked_out_upper_flds_we = llhd.sig %c0_i2 : i2
    %direct_oe_flds_we = llhd.sig %false : i1
    %masked_oe_lower_flds_we = llhd.sig %c0_i2 : i2
    %masked_oe_upper_flds_we = llhd.sig %c0_i2 : i2
    %addr_hit = llhd.sig %c0_i18 : i18
    %racl_role_vec = llhd.sig %c0_i2 : i2
    %racl_addr_hit_read = llhd.sig %c0_i18 : i18
    %racl_addr_hit_write = llhd.sig %c0_i18 : i18
    %u_chk.err_o = hw.instance "u_chk" @tlul_cmd_intg_chk(tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> (err_o: i1)
    llhd.drv %intg_err, %u_chk.err_o after %1 : i1
    %7 = llhd.prb %reg_we_check : i18
    %8 = llhd.prb %reg_we : i1
    %9 = comb.xor %122, %true : i1
    %10 = comb.and %8, %9 : i1
    %u_prim_reg_we_check.err_o = hw.instance "u_prim_reg_we_check" @prim_reg_we_check(clk_i: %5: i1, rst_ni: %6: i1, oh_i: %7: i18, en_i: %10: i1) -> (err_o: i1)
    llhd.drv %reg_we_err, %u_prim_reg_we_check.err_o after %1 : i1
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen(tl_i: %u_reg_if.tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
    %11 = llhd.prb %racl_error_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %valid = hw.struct_extract %11["valid"] : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %12 = comb.or %88, %valid : i1
    %u_reg_if.tl_o, %u_reg_if.intg_error_o, %u_reg_if.re_o, %u_reg_if.we_o, %u_reg_if.addr_o, %u_reg_if.wdata_o, %u_reg_if.be_o = hw.instance "u_reg_if" @tlul_adapter_reg(clk_i: %5: i1, rst_ni: %6: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, en_ifetch_i: %c-7_i4: i4, busy_i: %false: i1, rdata_i: %86: i32, error_i: %12: i1) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, intg_error_o: i1, re_o: i1, we_o: i1, addr_o: i7, wdata_o: i32, be_o: i4) {sv.namehint = "reg_re"}
    llhd.drv %reg_we, %u_reg_if.we_o after %1 : i1
    llhd.drv %reg_addr, %u_reg_if.addr_o after %1 : i7
    llhd.drv %reg_be, %u_reg_if.be_o after %1 : i4
    %13 = llhd.prb %intr_state_we : i1
    %intr_state = hw.struct_extract %hw2reg["intr_state"] : !hw.struct<intr_state: !hw.struct<d: i32, de: i1>, data_in: !hw.struct<d: i32, de: i1>, direct_out: !hw.struct<d: i32>, masked_out_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_out_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, direct_oe: !hw.struct<d: i32>, masked_oe_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_oe_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, hw_straps_data_in_valid: !hw.struct<d: i1, de: i1>, hw_straps_data_in: !hw.struct<d: i32, de: i1>>
    %de = hw.struct_extract %intr_state["de"] : !hw.struct<d: i32, de: i1>
    %d = hw.struct_extract %intr_state["d"] : !hw.struct<d: i32, de: i1>
    %14 = llhd.sig.struct_extract %reg2hw["intr_state"] : <!hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>>
    %15 = llhd.sig.struct_extract %14["q"] : <!hw.struct<q: i32>>
    %u_intr_state.qe, %u_intr_state.q, %u_intr_state.ds, %u_intr_state.qs = hw.instance "u_intr_state" @prim_subreg(clk_i: %5: i1, rst_ni: %6: i1, we: %13: i1, wd: %u_reg_if.wdata_o: i32, de: %de: i1, d: %d: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %15, %u_intr_state.q after %1 : i32
    llhd.drv %intr_state_qs, %u_intr_state.qs after %1 : i32
    %16 = llhd.prb %intr_enable_we : i1
    %17 = llhd.sig.struct_extract %reg2hw["intr_enable"] : <!hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>>
    %18 = llhd.sig.struct_extract %17["q"] : <!hw.struct<q: i32>>
    %u_intr_enable.qe, %u_intr_enable.q, %u_intr_enable.ds, %u_intr_enable.qs = hw.instance "u_intr_enable" @prim_subreg_1(clk_i: %5: i1, rst_ni: %6: i1, we: %16: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %18, %u_intr_enable.q after %1 : i32
    llhd.drv %intr_enable_qs, %u_intr_enable.qs after %1 : i32
    %19 = llhd.prb %intr_test_we : i1
    %20 = llhd.sig.struct_extract %reg2hw["intr_test"] : <!hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>>
    %21 = llhd.sig.struct_extract %20["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_intr_test.qe, %u_intr_test.qre, %u_intr_test.q, %u_intr_test.ds, %u_intr_test.qs = hw.instance "u_intr_test" @prim_subreg_ext(re: %false: i1, we: %19: i1, wd: %u_reg_if.wdata_o: i32, d: %c0_i32: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %intr_test_flds_we, %u_intr_test.qe after %1 : i1
    llhd.drv %21, %u_intr_test.q after %1 : i32
    %22 = llhd.prb %alert_test_we : i1
    %23 = llhd.sig.struct_extract %reg2hw["alert_test"] : <!hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>>
    %24 = llhd.sig.struct_extract %23["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_alert_test.qe, %u_alert_test.qre, %u_alert_test.q, %u_alert_test.ds, %u_alert_test.qs = hw.instance "u_alert_test" @prim_subreg_ext_2(re: %false: i1, we: %22: i1, wd: %146: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %alert_test_flds_we, %u_alert_test.qe after %1 : i1
    llhd.drv %24, %u_alert_test.q after %1 : i1
    %data_in = hw.struct_extract %hw2reg["data_in"] : !hw.struct<intr_state: !hw.struct<d: i32, de: i1>, data_in: !hw.struct<d: i32, de: i1>, direct_out: !hw.struct<d: i32>, masked_out_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_out_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, direct_oe: !hw.struct<d: i32>, masked_oe_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_oe_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, hw_straps_data_in_valid: !hw.struct<d: i1, de: i1>, hw_straps_data_in: !hw.struct<d: i32, de: i1>>
    %de_3 = hw.struct_extract %data_in["de"] : !hw.struct<d: i32, de: i1>
    %d_4 = hw.struct_extract %data_in["d"] : !hw.struct<d: i32, de: i1>
    %u_data_in.qe, %u_data_in.q, %u_data_in.ds, %u_data_in.qs = hw.instance "u_data_in" @prim_subreg_3(clk_i: %5: i1, rst_ni: %6: i1, we: %false: i1, wd: %c0_i32: i32, de: %de_3: i1, d: %d_4: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %data_in_qs, %u_data_in.qs after %1 : i32
    %25 = llhd.prb %direct_out_we : i1
    %direct_out = hw.struct_extract %hw2reg["direct_out"] : !hw.struct<intr_state: !hw.struct<d: i32, de: i1>, data_in: !hw.struct<d: i32, de: i1>, direct_out: !hw.struct<d: i32>, masked_out_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_out_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, direct_oe: !hw.struct<d: i32>, masked_oe_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_oe_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, hw_straps_data_in_valid: !hw.struct<d: i1, de: i1>, hw_straps_data_in: !hw.struct<d: i32, de: i1>>
    %d_5 = hw.struct_extract %direct_out["d"] : !hw.struct<d: i32>
    %26 = llhd.sig.struct_extract %reg2hw["direct_out"] : <!hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>>
    %27 = llhd.sig.struct_extract %26["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_direct_out.qe, %u_direct_out.qre, %u_direct_out.q, %u_direct_out.ds, %u_direct_out.qs = hw.instance "u_direct_out" @prim_subreg_ext(re: %148: i1, we: %25: i1, wd: %u_reg_if.wdata_o: i32, d: %d_5: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %direct_out_flds_we, %u_direct_out.qe after %1 : i1
    llhd.drv %27, %u_direct_out.q after %1 : i32
    llhd.drv %direct_out_qs, %u_direct_out.qs after %1 : i32
    %28 = llhd.prb %masked_out_lower_we : i1
    %masked_out_lower = hw.struct_extract %hw2reg["masked_out_lower"] : !hw.struct<intr_state: !hw.struct<d: i32, de: i1>, data_in: !hw.struct<d: i32, de: i1>, direct_out: !hw.struct<d: i32>, masked_out_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_out_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, direct_oe: !hw.struct<d: i32>, masked_oe_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_oe_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, hw_straps_data_in_valid: !hw.struct<d: i1, de: i1>, hw_straps_data_in: !hw.struct<d: i32, de: i1>>
    %data = hw.struct_extract %masked_out_lower["data"] : !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>
    %d_6 = hw.struct_extract %data["d"] : !hw.struct<d: i16>
    %29 = llhd.sig.extract %masked_out_lower_flds_we from %false : <i2> -> <i1>
    %30 = llhd.sig.struct_extract %reg2hw["masked_out_lower"] : <!hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>>
    %31 = llhd.sig.struct_extract %30["data"] : <!hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>>
    %32 = llhd.sig.struct_extract %31["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_masked_out_lower_data.qe, %u_masked_out_lower_data.qre, %u_masked_out_lower_data.q, %u_masked_out_lower_data.ds, %u_masked_out_lower_data.qs = hw.instance "u_masked_out_lower_data" @prim_subreg_ext_4(re: %152: i1, we: %28: i1, wd: %155: i16, d: %d_6: i16) -> (qe: i1, qre: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %29, %u_masked_out_lower_data.qe after %1 : i1
    llhd.drv %32, %u_masked_out_lower_data.q after %1 : i16
    llhd.drv %masked_out_lower_data_qs, %u_masked_out_lower_data.qs after %1 : i16
    %mask = hw.struct_extract %masked_out_lower["mask"] : !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>
    %d_7 = hw.struct_extract %mask["d"] : !hw.struct<d: i16>
    %33 = llhd.sig.extract %masked_out_lower_flds_we from %true : <i2> -> <i1>
    %34 = llhd.sig.struct_extract %30["mask"] : <!hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>>
    %35 = llhd.sig.struct_extract %34["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_masked_out_lower_mask.qe, %u_masked_out_lower_mask.qre, %u_masked_out_lower_mask.q, %u_masked_out_lower_mask.ds, %u_masked_out_lower_mask.qs = hw.instance "u_masked_out_lower_mask" @prim_subreg_ext_4(re: %false: i1, we: %28: i1, wd: %156: i16, d: %d_7: i16) -> (qe: i1, qre: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %33, %u_masked_out_lower_mask.qe after %1 : i1
    llhd.drv %35, %u_masked_out_lower_mask.q after %1 : i16
    %36 = llhd.prb %masked_out_upper_we : i1
    %masked_out_upper = hw.struct_extract %hw2reg["masked_out_upper"] : !hw.struct<intr_state: !hw.struct<d: i32, de: i1>, data_in: !hw.struct<d: i32, de: i1>, direct_out: !hw.struct<d: i32>, masked_out_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_out_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, direct_oe: !hw.struct<d: i32>, masked_oe_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_oe_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, hw_straps_data_in_valid: !hw.struct<d: i1, de: i1>, hw_straps_data_in: !hw.struct<d: i32, de: i1>>
    %data_8 = hw.struct_extract %masked_out_upper["data"] : !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>
    %d_9 = hw.struct_extract %data_8["d"] : !hw.struct<d: i16>
    %37 = llhd.sig.extract %masked_out_upper_flds_we from %false : <i2> -> <i1>
    %38 = llhd.sig.struct_extract %reg2hw["masked_out_upper"] : <!hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>>
    %39 = llhd.sig.struct_extract %38["data"] : <!hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>>
    %40 = llhd.sig.struct_extract %39["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_masked_out_upper_data.qe, %u_masked_out_upper_data.qre, %u_masked_out_upper_data.q, %u_masked_out_upper_data.ds, %u_masked_out_upper_data.qs = hw.instance "u_masked_out_upper_data" @prim_subreg_ext_4(re: %158: i1, we: %36: i1, wd: %155: i16, d: %d_9: i16) -> (qe: i1, qre: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %37, %u_masked_out_upper_data.qe after %1 : i1
    llhd.drv %40, %u_masked_out_upper_data.q after %1 : i16
    llhd.drv %masked_out_upper_data_qs, %u_masked_out_upper_data.qs after %1 : i16
    %mask_10 = hw.struct_extract %masked_out_upper["mask"] : !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>
    %d_11 = hw.struct_extract %mask_10["d"] : !hw.struct<d: i16>
    %41 = llhd.sig.extract %masked_out_upper_flds_we from %true : <i2> -> <i1>
    %42 = llhd.sig.struct_extract %38["mask"] : <!hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>>
    %43 = llhd.sig.struct_extract %42["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_masked_out_upper_mask.qe, %u_masked_out_upper_mask.qre, %u_masked_out_upper_mask.q, %u_masked_out_upper_mask.ds, %u_masked_out_upper_mask.qs = hw.instance "u_masked_out_upper_mask" @prim_subreg_ext_4(re: %false: i1, we: %36: i1, wd: %156: i16, d: %d_11: i16) -> (qe: i1, qre: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %41, %u_masked_out_upper_mask.qe after %1 : i1
    llhd.drv %43, %u_masked_out_upper_mask.q after %1 : i16
    %44 = llhd.prb %direct_oe_we : i1
    %direct_oe = hw.struct_extract %hw2reg["direct_oe"] : !hw.struct<intr_state: !hw.struct<d: i32, de: i1>, data_in: !hw.struct<d: i32, de: i1>, direct_out: !hw.struct<d: i32>, masked_out_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_out_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, direct_oe: !hw.struct<d: i32>, masked_oe_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_oe_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, hw_straps_data_in_valid: !hw.struct<d: i1, de: i1>, hw_straps_data_in: !hw.struct<d: i32, de: i1>>
    %d_12 = hw.struct_extract %direct_oe["d"] : !hw.struct<d: i32>
    %45 = llhd.sig.struct_extract %reg2hw["direct_oe"] : <!hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>>
    %46 = llhd.sig.struct_extract %45["q"] : <!hw.struct<q: i32, qe: i1>>
    %u_direct_oe.qe, %u_direct_oe.qre, %u_direct_oe.q, %u_direct_oe.ds, %u_direct_oe.qs = hw.instance "u_direct_oe" @prim_subreg_ext(re: %162: i1, we: %44: i1, wd: %u_reg_if.wdata_o: i32, d: %d_12: i32) -> (qe: i1, qre: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %direct_oe_flds_we, %u_direct_oe.qe after %1 : i1
    llhd.drv %46, %u_direct_oe.q after %1 : i32
    llhd.drv %direct_oe_qs, %u_direct_oe.qs after %1 : i32
    %47 = llhd.prb %masked_oe_lower_we : i1
    %masked_oe_lower = hw.struct_extract %hw2reg["masked_oe_lower"] : !hw.struct<intr_state: !hw.struct<d: i32, de: i1>, data_in: !hw.struct<d: i32, de: i1>, direct_out: !hw.struct<d: i32>, masked_out_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_out_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, direct_oe: !hw.struct<d: i32>, masked_oe_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_oe_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, hw_straps_data_in_valid: !hw.struct<d: i1, de: i1>, hw_straps_data_in: !hw.struct<d: i32, de: i1>>
    %data_13 = hw.struct_extract %masked_oe_lower["data"] : !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>
    %d_14 = hw.struct_extract %data_13["d"] : !hw.struct<d: i16>
    %48 = llhd.sig.extract %masked_oe_lower_flds_we from %false : <i2> -> <i1>
    %49 = llhd.sig.struct_extract %reg2hw["masked_oe_lower"] : <!hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>>
    %50 = llhd.sig.struct_extract %49["data"] : <!hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>>
    %51 = llhd.sig.struct_extract %50["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_masked_oe_lower_data.qe, %u_masked_oe_lower_data.qre, %u_masked_oe_lower_data.q, %u_masked_oe_lower_data.ds, %u_masked_oe_lower_data.qs = hw.instance "u_masked_oe_lower_data" @prim_subreg_ext_4(re: %166: i1, we: %47: i1, wd: %155: i16, d: %d_14: i16) -> (qe: i1, qre: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %48, %u_masked_oe_lower_data.qe after %1 : i1
    llhd.drv %51, %u_masked_oe_lower_data.q after %1 : i16
    llhd.drv %masked_oe_lower_data_qs, %u_masked_oe_lower_data.qs after %1 : i16
    %mask_15 = hw.struct_extract %masked_oe_lower["mask"] : !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>
    %d_16 = hw.struct_extract %mask_15["d"] : !hw.struct<d: i16>
    %52 = llhd.sig.extract %masked_oe_lower_flds_we from %true : <i2> -> <i1>
    %53 = llhd.sig.struct_extract %49["mask"] : <!hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>>
    %54 = llhd.sig.struct_extract %53["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_masked_oe_lower_mask.qe, %u_masked_oe_lower_mask.qre, %u_masked_oe_lower_mask.q, %u_masked_oe_lower_mask.ds, %u_masked_oe_lower_mask.qs = hw.instance "u_masked_oe_lower_mask" @prim_subreg_ext_4(re: %166: i1, we: %47: i1, wd: %156: i16, d: %d_16: i16) -> (qe: i1, qre: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %52, %u_masked_oe_lower_mask.qe after %1 : i1
    llhd.drv %54, %u_masked_oe_lower_mask.q after %1 : i16
    llhd.drv %masked_oe_lower_mask_qs, %u_masked_oe_lower_mask.qs after %1 : i16
    %55 = llhd.prb %masked_oe_upper_we : i1
    %masked_oe_upper = hw.struct_extract %hw2reg["masked_oe_upper"] : !hw.struct<intr_state: !hw.struct<d: i32, de: i1>, data_in: !hw.struct<d: i32, de: i1>, direct_out: !hw.struct<d: i32>, masked_out_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_out_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, direct_oe: !hw.struct<d: i32>, masked_oe_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_oe_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, hw_straps_data_in_valid: !hw.struct<d: i1, de: i1>, hw_straps_data_in: !hw.struct<d: i32, de: i1>>
    %data_17 = hw.struct_extract %masked_oe_upper["data"] : !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>
    %d_18 = hw.struct_extract %data_17["d"] : !hw.struct<d: i16>
    %56 = llhd.sig.extract %masked_oe_upper_flds_we from %false : <i2> -> <i1>
    %57 = llhd.sig.struct_extract %reg2hw["masked_oe_upper"] : <!hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>>
    %58 = llhd.sig.struct_extract %57["data"] : <!hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>>
    %59 = llhd.sig.struct_extract %58["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_masked_oe_upper_data.qe, %u_masked_oe_upper_data.qre, %u_masked_oe_upper_data.q, %u_masked_oe_upper_data.ds, %u_masked_oe_upper_data.qs = hw.instance "u_masked_oe_upper_data" @prim_subreg_ext_4(re: %170: i1, we: %55: i1, wd: %155: i16, d: %d_18: i16) -> (qe: i1, qre: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %56, %u_masked_oe_upper_data.qe after %1 : i1
    llhd.drv %59, %u_masked_oe_upper_data.q after %1 : i16
    llhd.drv %masked_oe_upper_data_qs, %u_masked_oe_upper_data.qs after %1 : i16
    %mask_19 = hw.struct_extract %masked_oe_upper["mask"] : !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>
    %d_20 = hw.struct_extract %mask_19["d"] : !hw.struct<d: i16>
    %60 = llhd.sig.extract %masked_oe_upper_flds_we from %true : <i2> -> <i1>
    %61 = llhd.sig.struct_extract %57["mask"] : <!hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>>
    %62 = llhd.sig.struct_extract %61["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_masked_oe_upper_mask.qe, %u_masked_oe_upper_mask.qre, %u_masked_oe_upper_mask.q, %u_masked_oe_upper_mask.ds, %u_masked_oe_upper_mask.qs = hw.instance "u_masked_oe_upper_mask" @prim_subreg_ext_4(re: %170: i1, we: %55: i1, wd: %156: i16, d: %d_20: i16) -> (qe: i1, qre: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %60, %u_masked_oe_upper_mask.qe after %1 : i1
    llhd.drv %62, %u_masked_oe_upper_mask.q after %1 : i16
    llhd.drv %masked_oe_upper_mask_qs, %u_masked_oe_upper_mask.qs after %1 : i16
    %63 = llhd.prb %intr_ctrl_en_rising_we : i1
    %64 = llhd.sig.struct_extract %reg2hw["intr_ctrl_en_rising"] : <!hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>>
    %65 = llhd.sig.struct_extract %64["q"] : <!hw.struct<q: i32>>
    %u_intr_ctrl_en_rising.qe, %u_intr_ctrl_en_rising.q, %u_intr_ctrl_en_rising.ds, %u_intr_ctrl_en_rising.qs = hw.instance "u_intr_ctrl_en_rising" @prim_subreg_1(clk_i: %5: i1, rst_ni: %6: i1, we: %63: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %65, %u_intr_ctrl_en_rising.q after %1 : i32
    llhd.drv %intr_ctrl_en_rising_qs, %u_intr_ctrl_en_rising.qs after %1 : i32
    %66 = llhd.prb %intr_ctrl_en_falling_we : i1
    %67 = llhd.sig.struct_extract %reg2hw["intr_ctrl_en_falling"] : <!hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>>
    %68 = llhd.sig.struct_extract %67["q"] : <!hw.struct<q: i32>>
    %u_intr_ctrl_en_falling.qe, %u_intr_ctrl_en_falling.q, %u_intr_ctrl_en_falling.ds, %u_intr_ctrl_en_falling.qs = hw.instance "u_intr_ctrl_en_falling" @prim_subreg_1(clk_i: %5: i1, rst_ni: %6: i1, we: %66: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %68, %u_intr_ctrl_en_falling.q after %1 : i32
    llhd.drv %intr_ctrl_en_falling_qs, %u_intr_ctrl_en_falling.qs after %1 : i32
    %69 = llhd.prb %intr_ctrl_en_lvlhigh_we : i1
    %70 = llhd.sig.struct_extract %reg2hw["intr_ctrl_en_lvlhigh"] : <!hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>>
    %71 = llhd.sig.struct_extract %70["q"] : <!hw.struct<q: i32>>
    %u_intr_ctrl_en_lvlhigh.qe, %u_intr_ctrl_en_lvlhigh.q, %u_intr_ctrl_en_lvlhigh.ds, %u_intr_ctrl_en_lvlhigh.qs = hw.instance "u_intr_ctrl_en_lvlhigh" @prim_subreg_1(clk_i: %5: i1, rst_ni: %6: i1, we: %69: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %71, %u_intr_ctrl_en_lvlhigh.q after %1 : i32
    llhd.drv %intr_ctrl_en_lvlhigh_qs, %u_intr_ctrl_en_lvlhigh.qs after %1 : i32
    %72 = llhd.prb %intr_ctrl_en_lvllow_we : i1
    %73 = llhd.sig.struct_extract %reg2hw["intr_ctrl_en_lvllow"] : <!hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>>
    %74 = llhd.sig.struct_extract %73["q"] : <!hw.struct<q: i32>>
    %u_intr_ctrl_en_lvllow.qe, %u_intr_ctrl_en_lvllow.q, %u_intr_ctrl_en_lvllow.ds, %u_intr_ctrl_en_lvllow.qs = hw.instance "u_intr_ctrl_en_lvllow" @prim_subreg_1(clk_i: %5: i1, rst_ni: %6: i1, we: %72: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %74, %u_intr_ctrl_en_lvllow.q after %1 : i32
    llhd.drv %intr_ctrl_en_lvllow_qs, %u_intr_ctrl_en_lvllow.qs after %1 : i32
    %75 = llhd.prb %ctrl_en_input_filter_we : i1
    %76 = llhd.sig.struct_extract %reg2hw["ctrl_en_input_filter"] : <!hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>>
    %77 = llhd.sig.struct_extract %76["q"] : <!hw.struct<q: i32>>
    %u_ctrl_en_input_filter.qe, %u_ctrl_en_input_filter.q, %u_ctrl_en_input_filter.ds, %u_ctrl_en_input_filter.qs = hw.instance "u_ctrl_en_input_filter" @prim_subreg_1(clk_i: %5: i1, rst_ni: %6: i1, we: %75: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %77, %u_ctrl_en_input_filter.q after %1 : i32
    llhd.drv %ctrl_en_input_filter_qs, %u_ctrl_en_input_filter.qs after %1 : i32
    %hw_straps_data_in_valid = hw.struct_extract %hw2reg["hw_straps_data_in_valid"] : !hw.struct<intr_state: !hw.struct<d: i32, de: i1>, data_in: !hw.struct<d: i32, de: i1>, direct_out: !hw.struct<d: i32>, masked_out_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_out_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, direct_oe: !hw.struct<d: i32>, masked_oe_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_oe_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, hw_straps_data_in_valid: !hw.struct<d: i1, de: i1>, hw_straps_data_in: !hw.struct<d: i32, de: i1>>
    %de_21 = hw.struct_extract %hw_straps_data_in_valid["de"] : !hw.struct<d: i1, de: i1>
    %d_22 = hw.struct_extract %hw_straps_data_in_valid["d"] : !hw.struct<d: i1, de: i1>
    %78 = llhd.sig.struct_extract %reg2hw["hw_straps_data_in_valid"] : <!hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>>
    %79 = llhd.sig.struct_extract %78["q"] : <!hw.struct<q: i1>>
    %u_hw_straps_data_in_valid.qe, %u_hw_straps_data_in_valid.q, %u_hw_straps_data_in_valid.ds, %u_hw_straps_data_in_valid.qs = hw.instance "u_hw_straps_data_in_valid" @prim_subreg_5(clk_i: %5: i1, rst_ni: %6: i1, we: %false: i1, wd: %false: i1, de: %de_21: i1, d: %d_22: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %79, %u_hw_straps_data_in_valid.q after %1 : i1
    llhd.drv %hw_straps_data_in_valid_qs, %u_hw_straps_data_in_valid.qs after %1 : i1
    %hw_straps_data_in = hw.struct_extract %hw2reg["hw_straps_data_in"] : !hw.struct<intr_state: !hw.struct<d: i32, de: i1>, data_in: !hw.struct<d: i32, de: i1>, direct_out: !hw.struct<d: i32>, masked_out_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_out_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, direct_oe: !hw.struct<d: i32>, masked_oe_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_oe_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, hw_straps_data_in_valid: !hw.struct<d: i1, de: i1>, hw_straps_data_in: !hw.struct<d: i32, de: i1>>
    %de_23 = hw.struct_extract %hw_straps_data_in["de"] : !hw.struct<d: i32, de: i1>
    %d_24 = hw.struct_extract %hw_straps_data_in["d"] : !hw.struct<d: i32, de: i1>
    %80 = llhd.sig.struct_extract %reg2hw["hw_straps_data_in"] : <!hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>>
    %81 = llhd.sig.struct_extract %80["q"] : <!hw.struct<q: i32>>
    %u_hw_straps_data_in.qe, %u_hw_straps_data_in.q, %u_hw_straps_data_in.ds, %u_hw_straps_data_in.qs = hw.instance "u_hw_straps_data_in" @prim_subreg_3(clk_i: %5: i1, rst_ni: %6: i1, we: %false: i1, wd: %c0_i32: i32, de: %de_23: i1, d: %d_24: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %81, %u_hw_straps_data_in.q after %1 : i32
    llhd.drv %hw_straps_data_in_qs, %u_hw_straps_data_in.qs after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %202 = llhd.prb %clk_i_0 : i1
      %203 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%5, %6 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %204 = llhd.prb %clk_i_0 : i1
      %205 = comb.xor bin %202, %true : i1
      %206 = comb.and bin %205, %204 : i1
      %207 = llhd.prb %rst_ni_1 : i1
      %208 = comb.xor bin %207, %true : i1
      %209 = comb.and bin %203, %208 : i1
      %210 = comb.or bin %206, %209 : i1
      cf.cond_br %210, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %211 = llhd.prb %rst_ni_1 : i1
      %212 = comb.xor %211, %true : i1
      cf.cond_br %212, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %err_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %213 = llhd.prb %intg_err : i1
      %214 = llhd.prb %reg_we_err : i1
      %215 = comb.or %213, %214 : i1
      cf.cond_br %215, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %err_q, %true after %0 : i1
      cf.br ^bb1
    }
    %82 = llhd.prb %err_q : i1
    %83 = llhd.prb %intg_err : i1
    %84 = llhd.prb %reg_we_err : i1
    %85 = comb.or %82, %83, %84 : i1
    %86 = llhd.prb %reg_rdata_next {sv.namehint = "reg_rdata"} : i32
    %87 = llhd.prb %wr_err : i1
    %88 = comb.or %122, %87, %83 {sv.namehint = "reg_error"} : i1
    %89 = llhd.prb %intr_test_flds_we {sv.namehint = "intr_test_qe"} : i1
    %90 = llhd.sig.struct_extract %20["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %90, %89 after %1 : i1
    %91 = llhd.prb %alert_test_flds_we {sv.namehint = "alert_test_qe"} : i1
    %92 = llhd.sig.struct_extract %23["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %92, %91 after %1 : i1
    %93 = llhd.prb %direct_out_flds_we {sv.namehint = "direct_out_qe"} : i1
    %94 = llhd.sig.struct_extract %26["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %94, %93 after %1 : i1
    %95 = llhd.prb %masked_out_lower_flds_we : i2
    %96 = comb.icmp eq %95, %c-1_i2 {sv.namehint = "masked_out_lower_qe"} : i2
    %97 = llhd.sig.struct_extract %31["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %97, %96 after %1 : i1
    %98 = llhd.sig.struct_extract %34["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %98, %96 after %1 : i1
    %99 = llhd.prb %masked_out_upper_flds_we : i2
    %100 = comb.icmp eq %99, %c-1_i2 {sv.namehint = "masked_out_upper_qe"} : i2
    %101 = llhd.sig.struct_extract %39["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %101, %100 after %1 : i1
    %102 = llhd.sig.struct_extract %42["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %102, %100 after %1 : i1
    %103 = llhd.prb %direct_oe_flds_we {sv.namehint = "direct_oe_qe"} : i1
    %104 = llhd.sig.struct_extract %45["qe"] : <!hw.struct<q: i32, qe: i1>>
    llhd.drv %104, %103 after %1 : i1
    %105 = llhd.prb %masked_oe_lower_flds_we : i2
    %106 = comb.icmp eq %105, %c-1_i2 {sv.namehint = "masked_oe_lower_qe"} : i2
    %107 = llhd.sig.struct_extract %50["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %107, %106 after %1 : i1
    %108 = llhd.sig.struct_extract %53["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %108, %106 after %1 : i1
    %109 = llhd.prb %masked_oe_upper_flds_we : i2
    %110 = comb.icmp eq %109, %c-1_i2 {sv.namehint = "masked_oe_upper_qe"} : i2
    %111 = llhd.sig.struct_extract %58["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %111, %110 after %1 : i1
    %112 = llhd.sig.struct_extract %61["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %112, %110 after %1 : i1
    llhd.drv %racl_role_vec, %c0_i2 after %1 : i2
    %113 = llhd.prb %racl_addr_hit_read : i18
    %114 = llhd.prb %racl_addr_hit_write : i18
    %115 = llhd.prb %addr_hit : i18
    %116 = llhd.prb %reg_addr : i7
    %117 = llhd.prb %racl_policies_i_2 : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    %118 = llhd.prb %racl_role_vec : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %racl_addr_hit_read, %c0_i18 after %1 : i18
      llhd.drv %racl_addr_hit_write, %c0_i18 after %1 : i18
      %202 = llhd.sig.extract %addr_hit from %c0_i5 : <i18> -> <i1>
      %203 = llhd.prb %reg_addr : i7
      %204 = comb.icmp eq %203, %c0_i7 : i7
      llhd.drv %202, %204 after %1 : i1
      %205 = llhd.sig.extract %addr_hit from %c1_i5 : <i18> -> <i1>
      %206 = llhd.prb %reg_addr : i7
      %207 = comb.icmp eq %206, %c4_i7 : i7
      llhd.drv %205, %207 after %1 : i1
      %208 = llhd.sig.extract %addr_hit from %c2_i5 : <i18> -> <i1>
      %209 = llhd.prb %reg_addr : i7
      %210 = comb.icmp eq %209, %c8_i7 : i7
      llhd.drv %208, %210 after %1 : i1
      %211 = llhd.sig.extract %addr_hit from %c3_i5 : <i18> -> <i1>
      %212 = llhd.prb %reg_addr : i7
      %213 = comb.icmp eq %212, %c12_i7 : i7
      llhd.drv %211, %213 after %1 : i1
      %214 = llhd.sig.extract %addr_hit from %c4_i5 : <i18> -> <i1>
      %215 = llhd.prb %reg_addr : i7
      %216 = comb.icmp eq %215, %c16_i7 : i7
      llhd.drv %214, %216 after %1 : i1
      %217 = llhd.sig.extract %addr_hit from %c5_i5 : <i18> -> <i1>
      %218 = llhd.prb %reg_addr : i7
      %219 = comb.icmp eq %218, %c20_i7 : i7
      llhd.drv %217, %219 after %1 : i1
      %220 = llhd.sig.extract %addr_hit from %c6_i5 : <i18> -> <i1>
      %221 = llhd.prb %reg_addr : i7
      %222 = comb.icmp eq %221, %c24_i7 : i7
      llhd.drv %220, %222 after %1 : i1
      %223 = llhd.sig.extract %addr_hit from %c7_i5 : <i18> -> <i1>
      %224 = llhd.prb %reg_addr : i7
      %225 = comb.icmp eq %224, %c28_i7 : i7
      llhd.drv %223, %225 after %1 : i1
      %226 = llhd.sig.extract %addr_hit from %c8_i5 : <i18> -> <i1>
      %227 = llhd.prb %reg_addr : i7
      %228 = comb.icmp eq %227, %c32_i7 : i7
      llhd.drv %226, %228 after %1 : i1
      %229 = llhd.sig.extract %addr_hit from %c9_i5 : <i18> -> <i1>
      %230 = llhd.prb %reg_addr : i7
      %231 = comb.icmp eq %230, %c36_i7 : i7
      llhd.drv %229, %231 after %1 : i1
      %232 = llhd.sig.extract %addr_hit from %c10_i5 : <i18> -> <i1>
      %233 = llhd.prb %reg_addr : i7
      %234 = comb.icmp eq %233, %c40_i7 : i7
      llhd.drv %232, %234 after %1 : i1
      %235 = llhd.sig.extract %addr_hit from %c11_i5 : <i18> -> <i1>
      %236 = llhd.prb %reg_addr : i7
      %237 = comb.icmp eq %236, %c44_i7 : i7
      llhd.drv %235, %237 after %1 : i1
      %238 = llhd.sig.extract %addr_hit from %c12_i5 : <i18> -> <i1>
      %239 = llhd.prb %reg_addr : i7
      %240 = comb.icmp eq %239, %c48_i7 : i7
      llhd.drv %238, %240 after %1 : i1
      %241 = llhd.sig.extract %addr_hit from %c13_i5 : <i18> -> <i1>
      %242 = llhd.prb %reg_addr : i7
      %243 = comb.icmp eq %242, %c52_i7 : i7
      llhd.drv %241, %243 after %1 : i1
      %244 = llhd.sig.extract %addr_hit from %c14_i5 : <i18> -> <i1>
      %245 = llhd.prb %reg_addr : i7
      %246 = comb.icmp eq %245, %c56_i7 : i7
      llhd.drv %244, %246 after %1 : i1
      %247 = llhd.sig.extract %addr_hit from %c15_i5 : <i18> -> <i1>
      %248 = llhd.prb %reg_addr : i7
      %249 = comb.icmp eq %248, %c60_i7 : i7
      llhd.drv %247, %249 after %1 : i1
      %250 = llhd.sig.extract %addr_hit from %c-16_i5 : <i18> -> <i1>
      %251 = llhd.prb %reg_addr : i7
      %252 = comb.icmp eq %251, %c-64_i7 : i7
      llhd.drv %250, %252 after %1 : i1
      %253 = llhd.sig.extract %addr_hit from %c-15_i5 : <i18> -> <i1>
      %254 = llhd.prb %reg_addr : i7
      %255 = comb.icmp eq %254, %c-60_i7 : i7
      llhd.drv %253, %255 after %1 : i1
      %256 = llhd.prb %addr_hit : i18
      llhd.drv %racl_addr_hit_read, %256 after %1 : i18
      %257 = llhd.prb %addr_hit : i18
      llhd.drv %racl_addr_hit_write, %257 after %1 : i18
      llhd.wait (%113, %114, %115, %116, %117, %118 : i18, i18, i18, i7, !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, i2), ^bb1
    }
    %119 = comb.or %u_reg_if.re_o, %8 : i1
    %120 = comb.icmp ne %115, %c0_i18 : i18
    %121 = comb.xor %120, %true : i1
    %122 = comb.and %119, %121 {sv.namehint = "addrmiss"} : i1
    %123 = llhd.sig.struct_extract %racl_error_o["valid"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    %124 = comb.icmp eq %113, %c0_i18 : i18
    %125 = comb.and %u_reg_if.re_o, %124 : i1
    %126 = comb.icmp eq %114, %c0_i18 : i18
    %127 = comb.and %8, %126 : i1
    %128 = comb.or %125, %127 : i1
    %129 = comb.and %120, %128 : i1
    llhd.drv %123, %129 after %1 : i1
    %130 = llhd.sig.struct_extract %racl_error_o["request_address"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    %131 = comb.concat %c0_i25, %116 : i25, i7
    llhd.drv %130, %131 after %1 : i32
    %132 = llhd.sig.struct_extract %racl_error_o["racl_role"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %132, %false after %1 : i1
    %133 = llhd.sig.struct_extract %racl_error_o["overflow"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %133, %false after %1 : i1
    %134 = llhd.sig.struct_extract %racl_error_o["ctn_uid"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %134, %false after %1 : i1
    %135 = llhd.sig.struct_extract %racl_error_o["read_access"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %135, %false after %1 : i1
    %136 = llhd.prb %reg_be : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %202 = llhd.prb %reg_we : i1
      %203 = llhd.prb %racl_addr_hit_write : i18
      %204 = comb.extract %203 from 0 : (i18) -> i1
      %205 = llhd.prb %reg_be : i4
      %206 = comb.extract %205 from 0 : (i4) -> i1
      %207 = comb.xor %206, %true : i1
      %208 = comb.icmp ne %205, %c-1_i4 : i4
      %209 = comb.and %204, %208 : i1
      %210 = comb.extract %203 from 1 : (i18) -> i1
      %211 = comb.icmp ne %205, %c-1_i4 : i4
      %212 = comb.and %210, %211 : i1
      %213 = comb.extract %203 from 2 : (i18) -> i1
      %214 = comb.icmp ne %205, %c-1_i4 : i4
      %215 = comb.and %213, %214 : i1
      %216 = comb.extract %203 from 3 : (i18) -> i1
      %217 = comb.and %216, %207 : i1
      %218 = comb.extract %203 from 4 : (i18) -> i1
      %219 = comb.icmp ne %205, %c-1_i4 : i4
      %220 = comb.and %218, %219 : i1
      %221 = comb.extract %203 from 5 : (i18) -> i1
      %222 = comb.icmp ne %205, %c-1_i4 : i4
      %223 = comb.and %221, %222 : i1
      %224 = comb.extract %203 from 6 : (i18) -> i1
      %225 = comb.icmp ne %205, %c-1_i4 : i4
      %226 = comb.and %224, %225 : i1
      %227 = comb.extract %203 from 7 : (i18) -> i1
      %228 = comb.icmp ne %205, %c-1_i4 : i4
      %229 = comb.and %227, %228 : i1
      %230 = comb.extract %203 from 8 : (i18) -> i1
      %231 = comb.icmp ne %205, %c-1_i4 : i4
      %232 = comb.and %230, %231 : i1
      %233 = comb.extract %203 from 9 : (i18) -> i1
      %234 = comb.icmp ne %205, %c-1_i4 : i4
      %235 = comb.and %233, %234 : i1
      %236 = comb.extract %203 from 10 : (i18) -> i1
      %237 = comb.icmp ne %205, %c-1_i4 : i4
      %238 = comb.and %236, %237 : i1
      %239 = comb.extract %203 from 11 : (i18) -> i1
      %240 = comb.icmp ne %205, %c-1_i4 : i4
      %241 = comb.and %239, %240 : i1
      %242 = comb.extract %203 from 12 : (i18) -> i1
      %243 = comb.icmp ne %205, %c-1_i4 : i4
      %244 = comb.and %242, %243 : i1
      %245 = comb.extract %203 from 13 : (i18) -> i1
      %246 = comb.icmp ne %205, %c-1_i4 : i4
      %247 = comb.and %245, %246 : i1
      %248 = comb.extract %203 from 14 : (i18) -> i1
      %249 = comb.icmp ne %205, %c-1_i4 : i4
      %250 = comb.and %248, %249 : i1
      %251 = comb.extract %203 from 15 : (i18) -> i1
      %252 = comb.icmp ne %205, %c-1_i4 : i4
      %253 = comb.and %251, %252 : i1
      %254 = comb.extract %203 from 16 : (i18) -> i1
      %255 = comb.and %254, %207 : i1
      %256 = comb.extract %203 from 17 : (i18) -> i1
      %257 = comb.icmp ne %205, %c-1_i4 : i4
      %258 = comb.and %256, %257 : i1
      %259 = comb.or %209, %212, %215, %217, %220, %223, %226, %229, %232, %235, %238, %241, %244, %247, %250, %253, %255, %258 : i1
      %260 = comb.and %202, %259 : i1
      llhd.drv %wr_err, %260 after %1 : i1
      llhd.wait (%8, %114, %136, %87 : i1, i18, i4, i1), ^bb1
    }
    %137 = comb.extract %114 from 0 : (i18) -> i1
    %138 = comb.xor %88, %true : i1
    %139 = comb.and %137, %8, %138 : i1
    llhd.drv %intr_state_we, %139 after %1 : i1
    %140 = comb.extract %114 from 1 : (i18) -> i1
    %141 = comb.and %140, %8, %138 : i1
    llhd.drv %intr_enable_we, %141 after %1 : i1
    %142 = comb.extract %114 from 2 : (i18) -> i1
    %143 = comb.and %142, %8, %138 : i1
    llhd.drv %intr_test_we, %143 after %1 : i1
    %144 = comb.extract %114 from 3 : (i18) -> i1
    %145 = comb.and %144, %8, %138 : i1
    llhd.drv %alert_test_we, %145 after %1 : i1
    %146 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "alert_test_wd"} : (i32) -> i1
    %147 = comb.extract %113 from 5 : (i18) -> i1
    %148 = comb.and %147, %u_reg_if.re_o, %138 {sv.namehint = "direct_out_re"} : i1
    %149 = comb.extract %114 from 5 : (i18) -> i1
    %150 = comb.and %149, %8, %138 : i1
    llhd.drv %direct_out_we, %150 after %1 : i1
    %151 = comb.extract %113 from 6 : (i18) -> i1
    %152 = comb.and %151, %u_reg_if.re_o, %138 {sv.namehint = "masked_out_lower_re"} : i1
    %153 = comb.extract %114 from 6 : (i18) -> i1
    %154 = comb.and %153, %8, %138 : i1
    llhd.drv %masked_out_lower_we, %154 after %1 : i1
    %155 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "masked_oe_upper_data_wd"} : (i32) -> i16
    %156 = comb.extract %u_reg_if.wdata_o from 16 {sv.namehint = "masked_oe_upper_mask_wd"} : (i32) -> i16
    %157 = comb.extract %113 from 7 : (i18) -> i1
    %158 = comb.and %157, %u_reg_if.re_o, %138 {sv.namehint = "masked_out_upper_re"} : i1
    %159 = comb.extract %114 from 7 : (i18) -> i1
    %160 = comb.and %159, %8, %138 : i1
    llhd.drv %masked_out_upper_we, %160 after %1 : i1
    %161 = comb.extract %113 from 8 : (i18) -> i1
    %162 = comb.and %161, %u_reg_if.re_o, %138 {sv.namehint = "direct_oe_re"} : i1
    %163 = comb.extract %114 from 8 : (i18) -> i1
    %164 = comb.and %163, %8, %138 : i1
    llhd.drv %direct_oe_we, %164 after %1 : i1
    %165 = comb.extract %113 from 9 : (i18) -> i1
    %166 = comb.and %165, %u_reg_if.re_o, %138 {sv.namehint = "masked_oe_lower_re"} : i1
    %167 = comb.extract %114 from 9 : (i18) -> i1
    %168 = comb.and %167, %8, %138 : i1
    llhd.drv %masked_oe_lower_we, %168 after %1 : i1
    %169 = comb.extract %113 from 10 : (i18) -> i1
    %170 = comb.and %169, %u_reg_if.re_o, %138 {sv.namehint = "masked_oe_upper_re"} : i1
    %171 = comb.extract %114 from 10 : (i18) -> i1
    %172 = comb.and %171, %8, %138 : i1
    llhd.drv %masked_oe_upper_we, %172 after %1 : i1
    %173 = comb.extract %114 from 11 : (i18) -> i1
    %174 = comb.and %173, %8, %138 : i1
    llhd.drv %intr_ctrl_en_rising_we, %174 after %1 : i1
    %175 = comb.extract %114 from 12 : (i18) -> i1
    %176 = comb.and %175, %8, %138 : i1
    llhd.drv %intr_ctrl_en_falling_we, %176 after %1 : i1
    %177 = comb.extract %114 from 13 : (i18) -> i1
    %178 = comb.and %177, %8, %138 : i1
    llhd.drv %intr_ctrl_en_lvlhigh_we, %178 after %1 : i1
    %179 = comb.extract %114 from 14 : (i18) -> i1
    %180 = comb.and %179, %8, %138 : i1
    llhd.drv %intr_ctrl_en_lvllow_we, %180 after %1 : i1
    %181 = comb.extract %114 from 15 : (i18) -> i1
    %182 = comb.and %181, %8, %138 : i1
    llhd.drv %ctrl_en_input_filter_we, %182 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %202 = llhd.sig.extract %reg_we_check from %c0_i5 : <i18> -> <i1>
      %203 = llhd.prb %intr_state_we : i1
      llhd.drv %202, %203 after %1 : i1
      %204 = llhd.sig.extract %reg_we_check from %c1_i5 : <i18> -> <i1>
      %205 = llhd.prb %intr_enable_we : i1
      llhd.drv %204, %205 after %1 : i1
      %206 = llhd.sig.extract %reg_we_check from %c2_i5 : <i18> -> <i1>
      %207 = llhd.prb %intr_test_we : i1
      llhd.drv %206, %207 after %1 : i1
      %208 = llhd.sig.extract %reg_we_check from %c3_i5 : <i18> -> <i1>
      %209 = llhd.prb %alert_test_we : i1
      llhd.drv %208, %209 after %1 : i1
      %210 = llhd.sig.extract %reg_we_check from %c4_i5 : <i18> -> <i1>
      llhd.drv %210, %false after %1 : i1
      %211 = llhd.sig.extract %reg_we_check from %c5_i5 : <i18> -> <i1>
      %212 = llhd.prb %direct_out_we : i1
      llhd.drv %211, %212 after %1 : i1
      %213 = llhd.sig.extract %reg_we_check from %c6_i5 : <i18> -> <i1>
      %214 = llhd.prb %masked_out_lower_we : i1
      llhd.drv %213, %214 after %1 : i1
      %215 = llhd.sig.extract %reg_we_check from %c7_i5 : <i18> -> <i1>
      %216 = llhd.prb %masked_out_upper_we : i1
      llhd.drv %215, %216 after %1 : i1
      %217 = llhd.sig.extract %reg_we_check from %c8_i5 : <i18> -> <i1>
      %218 = llhd.prb %direct_oe_we : i1
      llhd.drv %217, %218 after %1 : i1
      %219 = llhd.sig.extract %reg_we_check from %c9_i5 : <i18> -> <i1>
      %220 = llhd.prb %masked_oe_lower_we : i1
      llhd.drv %219, %220 after %1 : i1
      %221 = llhd.sig.extract %reg_we_check from %c10_i5 : <i18> -> <i1>
      %222 = llhd.prb %masked_oe_upper_we : i1
      llhd.drv %221, %222 after %1 : i1
      %223 = llhd.sig.extract %reg_we_check from %c11_i5 : <i18> -> <i1>
      %224 = llhd.prb %intr_ctrl_en_rising_we : i1
      llhd.drv %223, %224 after %1 : i1
      %225 = llhd.sig.extract %reg_we_check from %c12_i5 : <i18> -> <i1>
      %226 = llhd.prb %intr_ctrl_en_falling_we : i1
      llhd.drv %225, %226 after %1 : i1
      %227 = llhd.sig.extract %reg_we_check from %c13_i5 : <i18> -> <i1>
      %228 = llhd.prb %intr_ctrl_en_lvlhigh_we : i1
      llhd.drv %227, %228 after %1 : i1
      %229 = llhd.sig.extract %reg_we_check from %c14_i5 : <i18> -> <i1>
      %230 = llhd.prb %intr_ctrl_en_lvllow_we : i1
      llhd.drv %229, %230 after %1 : i1
      %231 = llhd.sig.extract %reg_we_check from %c15_i5 : <i18> -> <i1>
      %232 = llhd.prb %ctrl_en_input_filter_we : i1
      llhd.drv %231, %232 after %1 : i1
      %233 = llhd.sig.extract %reg_we_check from %c-16_i5 : <i18> -> <i1>
      llhd.drv %233, %false after %1 : i1
      %234 = llhd.sig.extract %reg_we_check from %c-15_i5 : <i18> -> <i1>
      llhd.drv %234, %false after %1 : i1
      llhd.wait (%7, %13, %16, %19, %22, %25, %28, %36, %44, %47, %55, %63, %66, %69, %72, %75 : i18, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    %183 = llhd.prb %intr_state_qs : i32
    %184 = llhd.prb %intr_enable_qs : i32
    %185 = llhd.prb %data_in_qs : i32
    %186 = llhd.prb %direct_out_qs : i32
    %187 = llhd.prb %masked_out_lower_data_qs : i16
    %188 = llhd.prb %masked_out_upper_data_qs : i16
    %189 = llhd.prb %direct_oe_qs : i32
    %190 = llhd.prb %masked_oe_lower_data_qs : i16
    %191 = llhd.prb %masked_oe_lower_mask_qs : i16
    %192 = llhd.prb %masked_oe_upper_data_qs : i16
    %193 = llhd.prb %masked_oe_upper_mask_qs : i16
    %194 = llhd.prb %intr_ctrl_en_rising_qs : i32
    %195 = llhd.prb %intr_ctrl_en_falling_qs : i32
    %196 = llhd.prb %intr_ctrl_en_lvlhigh_qs : i32
    %197 = llhd.prb %intr_ctrl_en_lvllow_qs : i32
    %198 = llhd.prb %ctrl_en_input_filter_qs : i32
    %199 = llhd.prb %hw_straps_data_in_valid_qs : i1
    %200 = llhd.prb %hw_straps_data_in_qs : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb38
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      %202 = llhd.prb %racl_addr_hit_read : i18
      %203 = comb.extract %202 from 0 : (i18) -> i1
      %204 = comb.icmp ceq %203, %true : i1
      cf.cond_br %204, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %205 = llhd.prb %intr_state_qs : i32
      llhd.drv %reg_rdata_next, %205 after %1 : i32
      cf.br ^bb38
    ^bb3:  // pred: ^bb1
      %206 = llhd.prb %racl_addr_hit_read : i18
      %207 = comb.extract %206 from 1 : (i18) -> i1
      %208 = comb.icmp ceq %207, %true : i1
      cf.cond_br %208, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %209 = llhd.prb %intr_enable_qs : i32
      llhd.drv %reg_rdata_next, %209 after %1 : i32
      cf.br ^bb38
    ^bb5:  // pred: ^bb3
      %210 = llhd.prb %racl_addr_hit_read : i18
      %211 = comb.extract %210 from 2 : (i18) -> i1
      %212 = comb.icmp ceq %211, %true : i1
      cf.cond_br %212, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      cf.br ^bb38
    ^bb7:  // pred: ^bb5
      %213 = llhd.prb %racl_addr_hit_read : i18
      %214 = comb.extract %213 from 3 : (i18) -> i1
      %215 = comb.icmp ceq %214, %true : i1
      cf.cond_br %215, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %216 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      llhd.drv %216, %false after %1 : i1
      cf.br ^bb38
    ^bb9:  // pred: ^bb7
      %217 = llhd.prb %racl_addr_hit_read : i18
      %218 = comb.extract %217 from 4 : (i18) -> i1
      %219 = comb.icmp ceq %218, %true : i1
      cf.cond_br %219, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %220 = llhd.prb %data_in_qs : i32
      llhd.drv %reg_rdata_next, %220 after %1 : i32
      cf.br ^bb38
    ^bb11:  // pred: ^bb9
      %221 = llhd.prb %racl_addr_hit_read : i18
      %222 = comb.extract %221 from 5 : (i18) -> i1
      %223 = comb.icmp ceq %222, %true : i1
      cf.cond_br %223, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %224 = llhd.prb %direct_out_qs : i32
      llhd.drv %reg_rdata_next, %224 after %1 : i32
      cf.br ^bb38
    ^bb13:  // pred: ^bb11
      %225 = llhd.prb %racl_addr_hit_read : i18
      %226 = comb.extract %225 from 6 : (i18) -> i1
      %227 = comb.icmp ceq %226, %true : i1
      cf.cond_br %227, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %228 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i16>
      %229 = llhd.prb %masked_out_lower_data_qs : i16
      llhd.drv %228, %229 after %1 : i16
      %230 = llhd.sig.extract %reg_rdata_next from %c-16_i5 : <i32> -> <i16>
      llhd.drv %230, %c0_i16 after %1 : i16
      cf.br ^bb38
    ^bb15:  // pred: ^bb13
      %231 = llhd.prb %racl_addr_hit_read : i18
      %232 = comb.extract %231 from 7 : (i18) -> i1
      %233 = comb.icmp ceq %232, %true : i1
      cf.cond_br %233, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      %234 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i16>
      %235 = llhd.prb %masked_out_upper_data_qs : i16
      llhd.drv %234, %235 after %1 : i16
      %236 = llhd.sig.extract %reg_rdata_next from %c-16_i5 : <i32> -> <i16>
      llhd.drv %236, %c0_i16 after %1 : i16
      cf.br ^bb38
    ^bb17:  // pred: ^bb15
      %237 = llhd.prb %racl_addr_hit_read : i18
      %238 = comb.extract %237 from 8 : (i18) -> i1
      %239 = comb.icmp ceq %238, %true : i1
      cf.cond_br %239, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      %240 = llhd.prb %direct_oe_qs : i32
      llhd.drv %reg_rdata_next, %240 after %1 : i32
      cf.br ^bb38
    ^bb19:  // pred: ^bb17
      %241 = llhd.prb %racl_addr_hit_read : i18
      %242 = comb.extract %241 from 9 : (i18) -> i1
      %243 = comb.icmp ceq %242, %true : i1
      cf.cond_br %243, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      %244 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i16>
      %245 = llhd.prb %masked_oe_lower_data_qs : i16
      llhd.drv %244, %245 after %1 : i16
      %246 = llhd.sig.extract %reg_rdata_next from %c-16_i5 : <i32> -> <i16>
      %247 = llhd.prb %masked_oe_lower_mask_qs : i16
      llhd.drv %246, %247 after %1 : i16
      cf.br ^bb38
    ^bb21:  // pred: ^bb19
      %248 = llhd.prb %racl_addr_hit_read : i18
      %249 = comb.extract %248 from 10 : (i18) -> i1
      %250 = comb.icmp ceq %249, %true : i1
      cf.cond_br %250, ^bb22, ^bb23
    ^bb22:  // pred: ^bb21
      %251 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i16>
      %252 = llhd.prb %masked_oe_upper_data_qs : i16
      llhd.drv %251, %252 after %1 : i16
      %253 = llhd.sig.extract %reg_rdata_next from %c-16_i5 : <i32> -> <i16>
      %254 = llhd.prb %masked_oe_upper_mask_qs : i16
      llhd.drv %253, %254 after %1 : i16
      cf.br ^bb38
    ^bb23:  // pred: ^bb21
      %255 = llhd.prb %racl_addr_hit_read : i18
      %256 = comb.extract %255 from 11 : (i18) -> i1
      %257 = comb.icmp ceq %256, %true : i1
      cf.cond_br %257, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      %258 = llhd.prb %intr_ctrl_en_rising_qs : i32
      llhd.drv %reg_rdata_next, %258 after %1 : i32
      cf.br ^bb38
    ^bb25:  // pred: ^bb23
      %259 = llhd.prb %racl_addr_hit_read : i18
      %260 = comb.extract %259 from 12 : (i18) -> i1
      %261 = comb.icmp ceq %260, %true : i1
      cf.cond_br %261, ^bb26, ^bb27
    ^bb26:  // pred: ^bb25
      %262 = llhd.prb %intr_ctrl_en_falling_qs : i32
      llhd.drv %reg_rdata_next, %262 after %1 : i32
      cf.br ^bb38
    ^bb27:  // pred: ^bb25
      %263 = llhd.prb %racl_addr_hit_read : i18
      %264 = comb.extract %263 from 13 : (i18) -> i1
      %265 = comb.icmp ceq %264, %true : i1
      cf.cond_br %265, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      %266 = llhd.prb %intr_ctrl_en_lvlhigh_qs : i32
      llhd.drv %reg_rdata_next, %266 after %1 : i32
      cf.br ^bb38
    ^bb29:  // pred: ^bb27
      %267 = llhd.prb %racl_addr_hit_read : i18
      %268 = comb.extract %267 from 14 : (i18) -> i1
      %269 = comb.icmp ceq %268, %true : i1
      cf.cond_br %269, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      %270 = llhd.prb %intr_ctrl_en_lvllow_qs : i32
      llhd.drv %reg_rdata_next, %270 after %1 : i32
      cf.br ^bb38
    ^bb31:  // pred: ^bb29
      %271 = llhd.prb %racl_addr_hit_read : i18
      %272 = comb.extract %271 from 15 : (i18) -> i1
      %273 = comb.icmp ceq %272, %true : i1
      cf.cond_br %273, ^bb32, ^bb33
    ^bb32:  // pred: ^bb31
      %274 = llhd.prb %ctrl_en_input_filter_qs : i32
      llhd.drv %reg_rdata_next, %274 after %1 : i32
      cf.br ^bb38
    ^bb33:  // pred: ^bb31
      %275 = llhd.prb %racl_addr_hit_read : i18
      %276 = comb.extract %275 from 16 : (i18) -> i1
      %277 = comb.icmp ceq %276, %true : i1
      cf.cond_br %277, ^bb34, ^bb35
    ^bb34:  // pred: ^bb33
      %278 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %279 = llhd.prb %hw_straps_data_in_valid_qs : i1
      llhd.drv %278, %279 after %1 : i1
      cf.br ^bb38
    ^bb35:  // pred: ^bb33
      %280 = llhd.prb %racl_addr_hit_read : i18
      %281 = comb.extract %280 from 17 : (i18) -> i1
      %282 = comb.icmp ceq %281, %true : i1
      cf.cond_br %282, ^bb36, ^bb37
    ^bb36:  // pred: ^bb35
      %283 = llhd.prb %hw_straps_data_in_qs : i32
      llhd.drv %reg_rdata_next, %283 after %1 : i32
      cf.br ^bb38
    ^bb37:  // pred: ^bb35
      llhd.drv %reg_rdata_next, %c-1_i32 after %1 : i32
      cf.br ^bb38
    ^bb38:  // 19 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb18, ^bb20, ^bb22, ^bb24, ^bb26, ^bb28, ^bb30, ^bb32, ^bb34, ^bb36, ^bb37
      llhd.wait (%86, %113, %183, %184, %185, %186, %187, %188, %189, %190, %191, %192, %193, %194, %195, %196, %197, %198, %199, %200 : i32, i18, i32, i32, i32, i32, i16, i16, i32, i16, i16, i16, i16, i32, i32, i32, i32, i32, i1, i32), ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    %201 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
    llhd.drv %racl_policies_i_2, %racl_policies_i after %1 : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    hw.output %u_rsp_intg_gen.tl_o, %201, %11, %85 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>, !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, i1
  }
  hw.module @gpio(in %clk_i : i1, in %rst_ni : i1, in %strap_en_i : i1, out sampled_straps_o : !hw.struct<valid: i1, data: i32>, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out intr_gpio_o : i32, in %alert_rx_i : !hw.array<1xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, out alert_tx_o : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>, in %racl_policies_i : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, out racl_error_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, in %cio_gpio_i : i32, out cio_gpio_o : i32, out cio_gpio_en_o : i32) {
    %c-1_i4 = hw.constant -1 : i4
    %c-1_i16 = hw.constant -1 : i16
    %c-1_i32 = hw.constant -1 : i32
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c0_i0 = hw.constant 0 : i0
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
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i5 = hw.constant 0 : i5
    %2 = hw.aggregate_constant [[0 : i32, false], [0 : i32, false], [0 : i32], [[0 : i16], [0 : i16]], [[0 : i16], [0 : i16]], [0 : i32], [[0 : i16], [0 : i16]], [[0 : i16], [0 : i16]], [false, false], [0 : i32, false]] : !hw.struct<intr_state: !hw.struct<d: i32, de: i1>, data_in: !hw.struct<d: i32, de: i1>, direct_out: !hw.struct<d: i32>, masked_out_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_out_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, direct_oe: !hw.struct<d: i32>, masked_oe_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_oe_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, hw_straps_data_in_valid: !hw.struct<d: i1, de: i1>, hw_straps_data_in: !hw.struct<d: i32, de: i1>>
    %3 = hw.aggregate_constant [[0 : i32], [0 : i32], [0 : i32, false], [false, false], [0 : i32, false], [[0 : i16, false], [0 : i16, false]], [[0 : i16, false], [0 : i16, false]], [0 : i32, false], [[0 : i16, false], [0 : i16, false]], [[0 : i16, false], [0 : i16, false]], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [0 : i32], [false], [0 : i32]] : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
    %4 = hw.aggregate_constant [[false, false]] : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    %5 = hw.aggregate_constant [false, 0 : i32] : !hw.struct<valid: i1, data: i32>
    %c0_i32 = hw.constant 0 : i32
    %c0_i16 = hw.constant 0 : i16
    %true = hw.constant true
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %6 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %7 = llhd.prb %rst_ni_1 : i1
    %sampled_straps_o = llhd.sig %5 : !hw.struct<valid: i1, data: i32>
    %alert_tx_o = llhd.sig %4 : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    %reg2hw = llhd.sig %3 : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
    %hw2reg = llhd.sig %2 : !hw.struct<intr_state: !hw.struct<d: i32, de: i1>, data_in: !hw.struct<d: i32, de: i1>, direct_out: !hw.struct<d: i32>, masked_out_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_out_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, direct_oe: !hw.struct<d: i32>, masked_oe_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_oe_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, hw_straps_data_in_valid: !hw.struct<d: i1, de: i1>, hw_straps_data_in: !hw.struct<d: i32, de: i1>>
    %cio_gpio_q = llhd.sig %c0_i32 : i32
    %cio_gpio_en_q = llhd.sig %c0_i32 : i32
    %data_in_d = llhd.sig %c0_i32 : i32
    %data_in_q = llhd.sig %c0_i32 : i32
    %alerts = llhd.sig %false : i1
    %8 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
    %ctrl_en_input_filter = hw.struct_extract %8["ctrl_en_input_filter"] : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
    %q = hw.struct_extract %ctrl_en_input_filter["q"] : !hw.struct<q: i32>
    %9 = comb.extract %q from 0 : (i32) -> i1
    %10 = comb.extract %cio_gpio_i from 0 : (i32) -> i1
    %11 = llhd.sig.extract %data_in_d from %c0_i5 : <i32> -> <i1>
    %gen_filter_0.u_filter.filter_o = hw.instance "gen_filter_0.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %9: i1, filter_i: %10: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %11, %gen_filter_0.u_filter.filter_o after %1 : i1
    %12 = comb.extract %q from 1 : (i32) -> i1
    %13 = comb.extract %cio_gpio_i from 1 : (i32) -> i1
    %14 = llhd.sig.extract %data_in_d from %c1_i5 : <i32> -> <i1>
    %gen_filter_1.u_filter.filter_o = hw.instance "gen_filter_1.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %12: i1, filter_i: %13: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %14, %gen_filter_1.u_filter.filter_o after %1 : i1
    %15 = comb.extract %q from 2 : (i32) -> i1
    %16 = comb.extract %cio_gpio_i from 2 : (i32) -> i1
    %17 = llhd.sig.extract %data_in_d from %c2_i5 : <i32> -> <i1>
    %gen_filter_2.u_filter.filter_o = hw.instance "gen_filter_2.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %15: i1, filter_i: %16: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %17, %gen_filter_2.u_filter.filter_o after %1 : i1
    %18 = comb.extract %q from 3 : (i32) -> i1
    %19 = comb.extract %cio_gpio_i from 3 : (i32) -> i1
    %20 = llhd.sig.extract %data_in_d from %c3_i5 : <i32> -> <i1>
    %gen_filter_3.u_filter.filter_o = hw.instance "gen_filter_3.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %18: i1, filter_i: %19: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %20, %gen_filter_3.u_filter.filter_o after %1 : i1
    %21 = comb.extract %q from 4 : (i32) -> i1
    %22 = comb.extract %cio_gpio_i from 4 : (i32) -> i1
    %23 = llhd.sig.extract %data_in_d from %c4_i5 : <i32> -> <i1>
    %gen_filter_4.u_filter.filter_o = hw.instance "gen_filter_4.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %21: i1, filter_i: %22: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %23, %gen_filter_4.u_filter.filter_o after %1 : i1
    %24 = comb.extract %q from 5 : (i32) -> i1
    %25 = comb.extract %cio_gpio_i from 5 : (i32) -> i1
    %26 = llhd.sig.extract %data_in_d from %c5_i5 : <i32> -> <i1>
    %gen_filter_5.u_filter.filter_o = hw.instance "gen_filter_5.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %24: i1, filter_i: %25: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %26, %gen_filter_5.u_filter.filter_o after %1 : i1
    %27 = comb.extract %q from 6 : (i32) -> i1
    %28 = comb.extract %cio_gpio_i from 6 : (i32) -> i1
    %29 = llhd.sig.extract %data_in_d from %c6_i5 : <i32> -> <i1>
    %gen_filter_6.u_filter.filter_o = hw.instance "gen_filter_6.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %27: i1, filter_i: %28: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %29, %gen_filter_6.u_filter.filter_o after %1 : i1
    %30 = comb.extract %q from 7 : (i32) -> i1
    %31 = comb.extract %cio_gpio_i from 7 : (i32) -> i1
    %32 = llhd.sig.extract %data_in_d from %c7_i5 : <i32> -> <i1>
    %gen_filter_7.u_filter.filter_o = hw.instance "gen_filter_7.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %30: i1, filter_i: %31: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %32, %gen_filter_7.u_filter.filter_o after %1 : i1
    %33 = comb.extract %q from 8 : (i32) -> i1
    %34 = comb.extract %cio_gpio_i from 8 : (i32) -> i1
    %35 = llhd.sig.extract %data_in_d from %c8_i5 : <i32> -> <i1>
    %gen_filter_8.u_filter.filter_o = hw.instance "gen_filter_8.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %33: i1, filter_i: %34: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %35, %gen_filter_8.u_filter.filter_o after %1 : i1
    %36 = comb.extract %q from 9 : (i32) -> i1
    %37 = comb.extract %cio_gpio_i from 9 : (i32) -> i1
    %38 = llhd.sig.extract %data_in_d from %c9_i5 : <i32> -> <i1>
    %gen_filter_9.u_filter.filter_o = hw.instance "gen_filter_9.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %36: i1, filter_i: %37: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %38, %gen_filter_9.u_filter.filter_o after %1 : i1
    %39 = comb.extract %q from 10 : (i32) -> i1
    %40 = comb.extract %cio_gpio_i from 10 : (i32) -> i1
    %41 = llhd.sig.extract %data_in_d from %c10_i5 : <i32> -> <i1>
    %gen_filter_10.u_filter.filter_o = hw.instance "gen_filter_10.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %39: i1, filter_i: %40: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %41, %gen_filter_10.u_filter.filter_o after %1 : i1
    %42 = comb.extract %q from 11 : (i32) -> i1
    %43 = comb.extract %cio_gpio_i from 11 : (i32) -> i1
    %44 = llhd.sig.extract %data_in_d from %c11_i5 : <i32> -> <i1>
    %gen_filter_11.u_filter.filter_o = hw.instance "gen_filter_11.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %42: i1, filter_i: %43: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %44, %gen_filter_11.u_filter.filter_o after %1 : i1
    %45 = comb.extract %q from 12 : (i32) -> i1
    %46 = comb.extract %cio_gpio_i from 12 : (i32) -> i1
    %47 = llhd.sig.extract %data_in_d from %c12_i5 : <i32> -> <i1>
    %gen_filter_12.u_filter.filter_o = hw.instance "gen_filter_12.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %45: i1, filter_i: %46: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %47, %gen_filter_12.u_filter.filter_o after %1 : i1
    %48 = comb.extract %q from 13 : (i32) -> i1
    %49 = comb.extract %cio_gpio_i from 13 : (i32) -> i1
    %50 = llhd.sig.extract %data_in_d from %c13_i5 : <i32> -> <i1>
    %gen_filter_13.u_filter.filter_o = hw.instance "gen_filter_13.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %48: i1, filter_i: %49: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %50, %gen_filter_13.u_filter.filter_o after %1 : i1
    %51 = comb.extract %q from 14 : (i32) -> i1
    %52 = comb.extract %cio_gpio_i from 14 : (i32) -> i1
    %53 = llhd.sig.extract %data_in_d from %c14_i5 : <i32> -> <i1>
    %gen_filter_14.u_filter.filter_o = hw.instance "gen_filter_14.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %51: i1, filter_i: %52: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %53, %gen_filter_14.u_filter.filter_o after %1 : i1
    %54 = comb.extract %q from 15 : (i32) -> i1
    %55 = comb.extract %cio_gpio_i from 15 : (i32) -> i1
    %56 = llhd.sig.extract %data_in_d from %c15_i5 : <i32> -> <i1>
    %gen_filter_15.u_filter.filter_o = hw.instance "gen_filter_15.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %54: i1, filter_i: %55: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %56, %gen_filter_15.u_filter.filter_o after %1 : i1
    %57 = comb.extract %q from 16 : (i32) -> i1
    %58 = comb.extract %cio_gpio_i from 16 : (i32) -> i1
    %59 = llhd.sig.extract %data_in_d from %c-16_i5 : <i32> -> <i1>
    %gen_filter_16.u_filter.filter_o = hw.instance "gen_filter_16.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %57: i1, filter_i: %58: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %59, %gen_filter_16.u_filter.filter_o after %1 : i1
    %60 = comb.extract %q from 17 : (i32) -> i1
    %61 = comb.extract %cio_gpio_i from 17 : (i32) -> i1
    %62 = llhd.sig.extract %data_in_d from %c-15_i5 : <i32> -> <i1>
    %gen_filter_17.u_filter.filter_o = hw.instance "gen_filter_17.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %60: i1, filter_i: %61: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %62, %gen_filter_17.u_filter.filter_o after %1 : i1
    %63 = comb.extract %q from 18 : (i32) -> i1
    %64 = comb.extract %cio_gpio_i from 18 : (i32) -> i1
    %65 = llhd.sig.extract %data_in_d from %c-14_i5 : <i32> -> <i1>
    %gen_filter_18.u_filter.filter_o = hw.instance "gen_filter_18.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %63: i1, filter_i: %64: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %65, %gen_filter_18.u_filter.filter_o after %1 : i1
    %66 = comb.extract %q from 19 : (i32) -> i1
    %67 = comb.extract %cio_gpio_i from 19 : (i32) -> i1
    %68 = llhd.sig.extract %data_in_d from %c-13_i5 : <i32> -> <i1>
    %gen_filter_19.u_filter.filter_o = hw.instance "gen_filter_19.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %66: i1, filter_i: %67: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %68, %gen_filter_19.u_filter.filter_o after %1 : i1
    %69 = comb.extract %q from 20 : (i32) -> i1
    %70 = comb.extract %cio_gpio_i from 20 : (i32) -> i1
    %71 = llhd.sig.extract %data_in_d from %c-12_i5 : <i32> -> <i1>
    %gen_filter_20.u_filter.filter_o = hw.instance "gen_filter_20.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %69: i1, filter_i: %70: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %71, %gen_filter_20.u_filter.filter_o after %1 : i1
    %72 = comb.extract %q from 21 : (i32) -> i1
    %73 = comb.extract %cio_gpio_i from 21 : (i32) -> i1
    %74 = llhd.sig.extract %data_in_d from %c-11_i5 : <i32> -> <i1>
    %gen_filter_21.u_filter.filter_o = hw.instance "gen_filter_21.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %72: i1, filter_i: %73: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %74, %gen_filter_21.u_filter.filter_o after %1 : i1
    %75 = comb.extract %q from 22 : (i32) -> i1
    %76 = comb.extract %cio_gpio_i from 22 : (i32) -> i1
    %77 = llhd.sig.extract %data_in_d from %c-10_i5 : <i32> -> <i1>
    %gen_filter_22.u_filter.filter_o = hw.instance "gen_filter_22.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %75: i1, filter_i: %76: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %77, %gen_filter_22.u_filter.filter_o after %1 : i1
    %78 = comb.extract %q from 23 : (i32) -> i1
    %79 = comb.extract %cio_gpio_i from 23 : (i32) -> i1
    %80 = llhd.sig.extract %data_in_d from %c-9_i5 : <i32> -> <i1>
    %gen_filter_23.u_filter.filter_o = hw.instance "gen_filter_23.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %78: i1, filter_i: %79: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %80, %gen_filter_23.u_filter.filter_o after %1 : i1
    %81 = comb.extract %q from 24 : (i32) -> i1
    %82 = comb.extract %cio_gpio_i from 24 : (i32) -> i1
    %83 = llhd.sig.extract %data_in_d from %c-8_i5 : <i32> -> <i1>
    %gen_filter_24.u_filter.filter_o = hw.instance "gen_filter_24.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %81: i1, filter_i: %82: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %83, %gen_filter_24.u_filter.filter_o after %1 : i1
    %84 = comb.extract %q from 25 : (i32) -> i1
    %85 = comb.extract %cio_gpio_i from 25 : (i32) -> i1
    %86 = llhd.sig.extract %data_in_d from %c-7_i5 : <i32> -> <i1>
    %gen_filter_25.u_filter.filter_o = hw.instance "gen_filter_25.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %84: i1, filter_i: %85: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %86, %gen_filter_25.u_filter.filter_o after %1 : i1
    %87 = comb.extract %q from 26 : (i32) -> i1
    %88 = comb.extract %cio_gpio_i from 26 : (i32) -> i1
    %89 = llhd.sig.extract %data_in_d from %c-6_i5 : <i32> -> <i1>
    %gen_filter_26.u_filter.filter_o = hw.instance "gen_filter_26.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %87: i1, filter_i: %88: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %89, %gen_filter_26.u_filter.filter_o after %1 : i1
    %90 = comb.extract %q from 27 : (i32) -> i1
    %91 = comb.extract %cio_gpio_i from 27 : (i32) -> i1
    %92 = llhd.sig.extract %data_in_d from %c-5_i5 : <i32> -> <i1>
    %gen_filter_27.u_filter.filter_o = hw.instance "gen_filter_27.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %90: i1, filter_i: %91: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %92, %gen_filter_27.u_filter.filter_o after %1 : i1
    %93 = comb.extract %q from 28 : (i32) -> i1
    %94 = comb.extract %cio_gpio_i from 28 : (i32) -> i1
    %95 = llhd.sig.extract %data_in_d from %c-4_i5 : <i32> -> <i1>
    %gen_filter_28.u_filter.filter_o = hw.instance "gen_filter_28.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %93: i1, filter_i: %94: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %95, %gen_filter_28.u_filter.filter_o after %1 : i1
    %96 = comb.extract %q from 29 : (i32) -> i1
    %97 = comb.extract %cio_gpio_i from 29 : (i32) -> i1
    %98 = llhd.sig.extract %data_in_d from %c-3_i5 : <i32> -> <i1>
    %gen_filter_29.u_filter.filter_o = hw.instance "gen_filter_29.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %96: i1, filter_i: %97: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %98, %gen_filter_29.u_filter.filter_o after %1 : i1
    %99 = comb.extract %q from 30 : (i32) -> i1
    %100 = comb.extract %cio_gpio_i from 30 : (i32) -> i1
    %101 = llhd.sig.extract %data_in_d from %c-2_i5 : <i32> -> <i1>
    %gen_filter_30.u_filter.filter_o = hw.instance "gen_filter_30.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %99: i1, filter_i: %100: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %101, %gen_filter_30.u_filter.filter_o after %1 : i1
    %102 = comb.extract %q from 31 : (i32) -> i1
    %103 = comb.extract %cio_gpio_i from 31 : (i32) -> i1
    %104 = llhd.sig.extract %data_in_d from %c-1_i5 : <i32> -> <i1>
    %gen_filter_31.u_filter.filter_o = hw.instance "gen_filter_31.u_filter" @prim_filter_ctr(clk_i: %6: i1, rst_ni: %7: i1, enable_i: %102: i1, filter_i: %103: i1, thresh_i: %c-1_i4: i4) -> (filter_o: i1)
    llhd.drv %104, %gen_filter_31.u_filter.filter_o after %1 : i1
    %intr_enable = hw.struct_extract %8["intr_enable"] : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
    %q_2 = hw.struct_extract %intr_enable["q"] : !hw.struct<q: i32>
    %intr_test = hw.struct_extract %8["intr_test"] : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
    %q_3 = hw.struct_extract %intr_test["q"] : !hw.struct<q: i32, qe: i1>
    %qe = hw.struct_extract %intr_test["qe"] : !hw.struct<q: i32, qe: i1>
    %intr_state = hw.struct_extract %8["intr_state"] : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
    %q_4 = hw.struct_extract %intr_state["q"] : !hw.struct<q: i32>
    %105 = llhd.sig.struct_extract %hw2reg["intr_state"] : <!hw.struct<intr_state: !hw.struct<d: i32, de: i1>, data_in: !hw.struct<d: i32, de: i1>, direct_out: !hw.struct<d: i32>, masked_out_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_out_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, direct_oe: !hw.struct<d: i32>, masked_oe_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_oe_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, hw_straps_data_in_valid: !hw.struct<d: i1, de: i1>, hw_straps_data_in: !hw.struct<d: i32, de: i1>>>
    %106 = llhd.sig.struct_extract %105["de"] : <!hw.struct<d: i32, de: i1>>
    %107 = llhd.sig.struct_extract %105["d"] : <!hw.struct<d: i32, de: i1>>
    %intr_hw.hw2reg_intr_state_de_o, %intr_hw.hw2reg_intr_state_d_o, %intr_hw.intr_o = hw.instance "intr_hw" @prim_intr_hw(clk_i: %6: i1, rst_ni: %7: i1, event_intr_i: %163: i32, reg2hw_intr_enable_q_i: %q_2: i32, reg2hw_intr_test_q_i: %q_3: i32, reg2hw_intr_test_qe_i: %qe: i1, reg2hw_intr_state_q_i: %q_4: i32) -> (hw2reg_intr_state_de_o: i1, hw2reg_intr_state_d_o: i32, intr_o: i32)
    llhd.drv %106, %intr_hw.hw2reg_intr_state_de_o after %1 : i1
    llhd.drv %107, %intr_hw.hw2reg_intr_state_d_o after %1 : i32
    %108 = llhd.prb %alerts : i1
    %109 = hw.array_get %alert_rx_i[%c0_i0] : !hw.array<1xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, i0
    %110 = llhd.sig.array_get %alert_tx_o[%c0_i0] : <!hw.array<1xstruct<alert_p: i1, alert_n: i1>>>
    %gen_alert_tx_0.u_prim_alert_sender.alert_ack_o, %gen_alert_tx_0.u_prim_alert_sender.alert_state_o, %gen_alert_tx_0.u_prim_alert_sender.alert_tx_o = hw.instance "gen_alert_tx_0.u_prim_alert_sender" @prim_alert_sender(clk_i: %6: i1, rst_ni: %7: i1, alert_test_i: %164: i1, alert_req_i: %108: i1, alert_rx_i: %109: !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>) -> (alert_ack_o: i1, alert_state_o: i1, alert_tx_o: !hw.struct<alert_p: i1, alert_n: i1>)
    llhd.drv %110, %gen_alert_tx_0.u_prim_alert_sender.alert_tx_o after %1 : !hw.struct<alert_p: i1, alert_n: i1>
    %111 = llhd.prb %hw2reg : !hw.struct<intr_state: !hw.struct<d: i32, de: i1>, data_in: !hw.struct<d: i32, de: i1>, direct_out: !hw.struct<d: i32>, masked_out_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_out_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, direct_oe: !hw.struct<d: i32>, masked_oe_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_oe_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, hw_straps_data_in_valid: !hw.struct<d: i1, de: i1>, hw_straps_data_in: !hw.struct<d: i32, de: i1>>
    %u_reg.tl_o, %u_reg.reg2hw, %u_reg.racl_error_o, %u_reg.intg_err_o = hw.instance "u_reg" @gpio_reg_top(clk_i: %6: i1, rst_ni: %7: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, hw2reg: %111: !hw.struct<intr_state: !hw.struct<d: i32, de: i1>, data_in: !hw.struct<d: i32, de: i1>, direct_out: !hw.struct<d: i32>, masked_out_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_out_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, direct_oe: !hw.struct<d: i32>, masked_oe_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_oe_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, hw_straps_data_in_valid: !hw.struct<d: i1, de: i1>, hw_straps_data_in: !hw.struct<d: i32, de: i1>>, racl_policies_i: %racl_policies_i: !hw.array<1xstruct<write_perm: i2, read_perm: i2>>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, reg2hw: !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>, racl_error_o: !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, intg_err_o: i1)
    llhd.drv %reg2hw, %u_reg.reg2hw after %1 : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
    llhd.drv %alerts, %u_reg.intg_err_o after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 3 preds: ^bb0, ^bb2, ^bb3
      %167 = llhd.prb %clk_i_0 : i1
      llhd.wait (%6 : i1), ^bb2
    ^bb2:  // pred: ^bb1
      %168 = llhd.prb %clk_i_0 : i1
      %169 = comb.xor bin %167, %true : i1
      %170 = comb.and bin %169, %168 : i1
      cf.cond_br %170, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %171 = llhd.prb %data_in_d : i32
      llhd.drv %data_in_q, %171 after %0 : i32
      cf.br ^bb1
    }
    %112 = llhd.prb %data_in_d : i32
    %113 = llhd.prb %data_in_q : i32
    %114 = comb.xor %113, %c-1_i32 : i32
    %115 = comb.xor %112, %c-1_i32 : i32
    %hw_straps_data_in_valid = hw.struct_extract %8["hw_straps_data_in_valid"] : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
    %q_5 = hw.struct_extract %hw_straps_data_in_valid["q"] : !hw.struct<q: i1>
    %116 = comb.xor %q_5, %true : i1
    %117 = comb.and %strap_en_i, %116 {sv.namehint = "gen_strap_sample.sample_trigger"} : i1
    %118 = llhd.sig.struct_extract %hw2reg["hw_straps_data_in_valid"] : <!hw.struct<intr_state: !hw.struct<d: i32, de: i1>, data_in: !hw.struct<d: i32, de: i1>, direct_out: !hw.struct<d: i32>, masked_out_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_out_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, direct_oe: !hw.struct<d: i32>, masked_oe_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_oe_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, hw_straps_data_in_valid: !hw.struct<d: i1, de: i1>, hw_straps_data_in: !hw.struct<d: i32, de: i1>>>
    %119 = llhd.sig.struct_extract %118["de"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %119, %117 after %1 : i1
    %120 = llhd.sig.struct_extract %118["d"] : <!hw.struct<d: i1, de: i1>>
    llhd.drv %120, %true after %1 : i1
    %121 = llhd.sig.struct_extract %hw2reg["hw_straps_data_in"] : <!hw.struct<intr_state: !hw.struct<d: i32, de: i1>, data_in: !hw.struct<d: i32, de: i1>, direct_out: !hw.struct<d: i32>, masked_out_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_out_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, direct_oe: !hw.struct<d: i32>, masked_oe_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_oe_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, hw_straps_data_in_valid: !hw.struct<d: i1, de: i1>, hw_straps_data_in: !hw.struct<d: i32, de: i1>>>
    %122 = llhd.sig.struct_extract %121["de"] : <!hw.struct<d: i32, de: i1>>
    llhd.drv %122, %117 after %1 : i1
    %123 = llhd.sig.struct_extract %121["d"] : <!hw.struct<d: i32, de: i1>>
    llhd.drv %123, %112 after %1 : i32
    %124 = llhd.sig.struct_extract %sampled_straps_o["data"] : <!hw.struct<valid: i1, data: i32>>
    %hw_straps_data_in = hw.struct_extract %8["hw_straps_data_in"] : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
    %q_6 = hw.struct_extract %hw_straps_data_in["q"] : !hw.struct<q: i32>
    llhd.drv %124, %q_6 after %1 : i32
    %125 = llhd.sig.struct_extract %sampled_straps_o["valid"] : <!hw.struct<valid: i1, data: i32>>
    llhd.drv %125, %q_5 after %1 : i1
    %126 = llhd.sig.struct_extract %hw2reg["data_in"] : <!hw.struct<intr_state: !hw.struct<d: i32, de: i1>, data_in: !hw.struct<d: i32, de: i1>, direct_out: !hw.struct<d: i32>, masked_out_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_out_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, direct_oe: !hw.struct<d: i32>, masked_oe_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_oe_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, hw_straps_data_in_valid: !hw.struct<d: i1, de: i1>, hw_straps_data_in: !hw.struct<d: i32, de: i1>>>
    %127 = llhd.sig.struct_extract %126["de"] : <!hw.struct<d: i32, de: i1>>
    llhd.drv %127, %true after %1 : i1
    %128 = llhd.sig.struct_extract %126["d"] : <!hw.struct<d: i32, de: i1>>
    llhd.drv %128, %112 after %1 : i32
    %129 = llhd.prb %cio_gpio_q : i32
    %130 = llhd.prb %cio_gpio_en_q : i32
    %131 = llhd.sig.struct_extract %hw2reg["direct_out"] : <!hw.struct<intr_state: !hw.struct<d: i32, de: i1>, data_in: !hw.struct<d: i32, de: i1>, direct_out: !hw.struct<d: i32>, masked_out_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_out_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, direct_oe: !hw.struct<d: i32>, masked_oe_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_oe_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, hw_straps_data_in_valid: !hw.struct<d: i1, de: i1>, hw_straps_data_in: !hw.struct<d: i32, de: i1>>>
    %132 = llhd.sig.struct_extract %131["d"] : <!hw.struct<d: i32>>
    llhd.drv %132, %129 after %1 : i32
    %133 = llhd.sig.struct_extract %hw2reg["masked_out_upper"] : <!hw.struct<intr_state: !hw.struct<d: i32, de: i1>, data_in: !hw.struct<d: i32, de: i1>, direct_out: !hw.struct<d: i32>, masked_out_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_out_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, direct_oe: !hw.struct<d: i32>, masked_oe_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_oe_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, hw_straps_data_in_valid: !hw.struct<d: i1, de: i1>, hw_straps_data_in: !hw.struct<d: i32, de: i1>>>
    %134 = llhd.sig.struct_extract %133["data"] : <!hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>>
    %135 = llhd.sig.struct_extract %134["d"] : <!hw.struct<d: i16>>
    %136 = comb.extract %129 from 16 : (i32) -> i16
    llhd.drv %135, %136 after %1 : i16
    %137 = llhd.sig.struct_extract %133["mask"] : <!hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>>
    %138 = llhd.sig.struct_extract %137["d"] : <!hw.struct<d: i16>>
    llhd.drv %138, %c0_i16 after %1 : i16
    %139 = llhd.sig.struct_extract %hw2reg["masked_out_lower"] : <!hw.struct<intr_state: !hw.struct<d: i32, de: i1>, data_in: !hw.struct<d: i32, de: i1>, direct_out: !hw.struct<d: i32>, masked_out_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_out_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, direct_oe: !hw.struct<d: i32>, masked_oe_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_oe_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, hw_straps_data_in_valid: !hw.struct<d: i1, de: i1>, hw_straps_data_in: !hw.struct<d: i32, de: i1>>>
    %140 = llhd.sig.struct_extract %139["data"] : <!hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>>
    %141 = llhd.sig.struct_extract %140["d"] : <!hw.struct<d: i16>>
    %142 = comb.extract %129 from 0 : (i32) -> i16
    llhd.drv %141, %142 after %1 : i16
    %143 = llhd.sig.struct_extract %139["mask"] : <!hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>>
    %144 = llhd.sig.struct_extract %143["d"] : <!hw.struct<d: i16>>
    llhd.drv %144, %c0_i16 after %1 : i16
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      %167 = llhd.prb %clk_i_0 : i1
      %168 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%6, %7 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %169 = llhd.prb %clk_i_0 : i1
      %170 = comb.xor bin %167, %true : i1
      %171 = comb.and bin %170, %169 : i1
      %172 = llhd.prb %rst_ni_1 : i1
      %173 = comb.xor bin %172, %true : i1
      %174 = comb.and bin %168, %173 : i1
      %175 = comb.or bin %171, %174 : i1
      cf.cond_br %175, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %176 = llhd.prb %rst_ni_1 : i1
      %177 = comb.xor %176, %true : i1
      cf.cond_br %177, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %cio_gpio_q, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %178 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
      %direct_out = hw.struct_extract %178["direct_out"] : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
      %qe_13 = hw.struct_extract %direct_out["qe"] : !hw.struct<q: i32, qe: i1>
      cf.cond_br %qe_13, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %179 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
      %direct_out_14 = hw.struct_extract %179["direct_out"] : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
      %q_15 = hw.struct_extract %direct_out_14["q"] : !hw.struct<q: i32, qe: i1>
      llhd.drv %cio_gpio_q, %q_15 after %0 : i32
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %180 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
      %masked_out_upper = hw.struct_extract %180["masked_out_upper"] : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
      %data = hw.struct_extract %masked_out_upper["data"] : !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>
      %qe_16 = hw.struct_extract %data["qe"] : !hw.struct<q: i16, qe: i1>
      cf.cond_br %qe_16, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %181 = llhd.sig.extract %cio_gpio_q from %c-16_i5 : <i32> -> <i16>
      %182 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
      %masked_out_upper_17 = hw.struct_extract %182["masked_out_upper"] : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
      %mask = hw.struct_extract %masked_out_upper_17["mask"] : !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>
      %q_18 = hw.struct_extract %mask["q"] : !hw.struct<q: i16, qe: i1>
      %data_19 = hw.struct_extract %masked_out_upper_17["data"] : !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>
      %q_20 = hw.struct_extract %data_19["q"] : !hw.struct<q: i16, qe: i1>
      %183 = comb.and %q_18, %q_20 : i16
      %184 = comb.xor %q_18, %c-1_i16 : i16
      %185 = llhd.prb %cio_gpio_q : i32
      %186 = comb.extract %185 from 16 : (i32) -> i16
      %187 = comb.and %184, %186 : i16
      %188 = comb.or %183, %187 : i16
      llhd.drv %181, %188 after %0 : i16
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %189 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
      %masked_out_lower = hw.struct_extract %189["masked_out_lower"] : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
      %data_21 = hw.struct_extract %masked_out_lower["data"] : !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>
      %qe_22 = hw.struct_extract %data_21["qe"] : !hw.struct<q: i16, qe: i1>
      cf.cond_br %qe_22, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      %190 = llhd.sig.extract %cio_gpio_q from %c0_i5 : <i32> -> <i16>
      %191 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
      %masked_out_lower_23 = hw.struct_extract %191["masked_out_lower"] : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
      %mask_24 = hw.struct_extract %masked_out_lower_23["mask"] : !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>
      %q_25 = hw.struct_extract %mask_24["q"] : !hw.struct<q: i16, qe: i1>
      %data_26 = hw.struct_extract %masked_out_lower_23["data"] : !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>
      %q_27 = hw.struct_extract %data_26["q"] : !hw.struct<q: i16, qe: i1>
      %192 = comb.and %q_25, %q_27 : i16
      %193 = comb.xor %q_25, %c-1_i16 : i16
      %194 = llhd.prb %cio_gpio_q : i32
      %195 = comb.extract %194 from 0 : (i32) -> i16
      %196 = comb.and %193, %195 : i16
      %197 = comb.or %192, %196 : i16
      llhd.drv %190, %197 after %0 : i16
      cf.br ^bb1
    }
    %145 = llhd.sig.struct_extract %hw2reg["direct_oe"] : <!hw.struct<intr_state: !hw.struct<d: i32, de: i1>, data_in: !hw.struct<d: i32, de: i1>, direct_out: !hw.struct<d: i32>, masked_out_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_out_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, direct_oe: !hw.struct<d: i32>, masked_oe_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_oe_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, hw_straps_data_in_valid: !hw.struct<d: i1, de: i1>, hw_straps_data_in: !hw.struct<d: i32, de: i1>>>
    %146 = llhd.sig.struct_extract %145["d"] : <!hw.struct<d: i32>>
    llhd.drv %146, %130 after %1 : i32
    %147 = llhd.sig.struct_extract %hw2reg["masked_oe_upper"] : <!hw.struct<intr_state: !hw.struct<d: i32, de: i1>, data_in: !hw.struct<d: i32, de: i1>, direct_out: !hw.struct<d: i32>, masked_out_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_out_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, direct_oe: !hw.struct<d: i32>, masked_oe_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_oe_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, hw_straps_data_in_valid: !hw.struct<d: i1, de: i1>, hw_straps_data_in: !hw.struct<d: i32, de: i1>>>
    %148 = llhd.sig.struct_extract %147["data"] : <!hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>>
    %149 = llhd.sig.struct_extract %148["d"] : <!hw.struct<d: i16>>
    %150 = comb.extract %130 from 16 : (i32) -> i16
    llhd.drv %149, %150 after %1 : i16
    %151 = llhd.sig.struct_extract %147["mask"] : <!hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>>
    %152 = llhd.sig.struct_extract %151["d"] : <!hw.struct<d: i16>>
    llhd.drv %152, %c0_i16 after %1 : i16
    %153 = llhd.sig.struct_extract %hw2reg["masked_oe_lower"] : <!hw.struct<intr_state: !hw.struct<d: i32, de: i1>, data_in: !hw.struct<d: i32, de: i1>, direct_out: !hw.struct<d: i32>, masked_out_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_out_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, direct_oe: !hw.struct<d: i32>, masked_oe_lower: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, masked_oe_upper: !hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>, hw_straps_data_in_valid: !hw.struct<d: i1, de: i1>, hw_straps_data_in: !hw.struct<d: i32, de: i1>>>
    %154 = llhd.sig.struct_extract %153["data"] : <!hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>>
    %155 = llhd.sig.struct_extract %154["d"] : <!hw.struct<d: i16>>
    %156 = comb.extract %130 from 0 : (i32) -> i16
    llhd.drv %155, %156 after %1 : i16
    %157 = llhd.sig.struct_extract %153["mask"] : <!hw.struct<mask: !hw.struct<d: i16>, data: !hw.struct<d: i16>>>
    %158 = llhd.sig.struct_extract %157["d"] : <!hw.struct<d: i16>>
    llhd.drv %158, %c0_i16 after %1 : i16
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 7 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb8, ^bb9, ^bb10
      %167 = llhd.prb %clk_i_0 : i1
      %168 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%6, %7 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %169 = llhd.prb %clk_i_0 : i1
      %170 = comb.xor bin %167, %true : i1
      %171 = comb.and bin %170, %169 : i1
      %172 = llhd.prb %rst_ni_1 : i1
      %173 = comb.xor bin %172, %true : i1
      %174 = comb.and bin %168, %173 : i1
      %175 = comb.or bin %171, %174 : i1
      cf.cond_br %175, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %176 = llhd.prb %rst_ni_1 : i1
      %177 = comb.xor %176, %true : i1
      cf.cond_br %177, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %cio_gpio_en_q, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %178 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
      %direct_oe = hw.struct_extract %178["direct_oe"] : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
      %qe_13 = hw.struct_extract %direct_oe["qe"] : !hw.struct<q: i32, qe: i1>
      cf.cond_br %qe_13, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %179 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
      %direct_oe_14 = hw.struct_extract %179["direct_oe"] : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
      %q_15 = hw.struct_extract %direct_oe_14["q"] : !hw.struct<q: i32, qe: i1>
      llhd.drv %cio_gpio_en_q, %q_15 after %0 : i32
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %180 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
      %masked_oe_upper = hw.struct_extract %180["masked_oe_upper"] : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
      %data = hw.struct_extract %masked_oe_upper["data"] : !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>
      %qe_16 = hw.struct_extract %data["qe"] : !hw.struct<q: i16, qe: i1>
      cf.cond_br %qe_16, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %181 = llhd.sig.extract %cio_gpio_en_q from %c-16_i5 : <i32> -> <i16>
      %182 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
      %masked_oe_upper_17 = hw.struct_extract %182["masked_oe_upper"] : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
      %mask = hw.struct_extract %masked_oe_upper_17["mask"] : !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>
      %q_18 = hw.struct_extract %mask["q"] : !hw.struct<q: i16, qe: i1>
      %data_19 = hw.struct_extract %masked_oe_upper_17["data"] : !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>
      %q_20 = hw.struct_extract %data_19["q"] : !hw.struct<q: i16, qe: i1>
      %183 = comb.and %q_18, %q_20 : i16
      %184 = comb.xor %q_18, %c-1_i16 : i16
      %185 = llhd.prb %cio_gpio_en_q : i32
      %186 = comb.extract %185 from 16 : (i32) -> i16
      %187 = comb.and %184, %186 : i16
      %188 = comb.or %183, %187 : i16
      llhd.drv %181, %188 after %0 : i16
      cf.br ^bb1
    ^bb9:  // pred: ^bb7
      %189 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
      %masked_oe_lower = hw.struct_extract %189["masked_oe_lower"] : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
      %data_21 = hw.struct_extract %masked_oe_lower["data"] : !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>
      %qe_22 = hw.struct_extract %data_21["qe"] : !hw.struct<q: i16, qe: i1>
      cf.cond_br %qe_22, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      %190 = llhd.sig.extract %cio_gpio_en_q from %c0_i5 : <i32> -> <i16>
      %191 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
      %masked_oe_lower_23 = hw.struct_extract %191["masked_oe_lower"] : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
      %mask_24 = hw.struct_extract %masked_oe_lower_23["mask"] : !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>
      %q_25 = hw.struct_extract %mask_24["q"] : !hw.struct<q: i16, qe: i1>
      %data_26 = hw.struct_extract %masked_oe_lower_23["data"] : !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>
      %q_27 = hw.struct_extract %data_26["q"] : !hw.struct<q: i16, qe: i1>
      %192 = comb.and %q_25, %q_27 : i16
      %193 = comb.xor %q_25, %c-1_i16 : i16
      %194 = llhd.prb %cio_gpio_en_q : i32
      %195 = comb.extract %194 from 0 : (i32) -> i16
      %196 = comb.and %193, %195 : i16
      %197 = comb.or %192, %196 : i16
      llhd.drv %190, %197 after %0 : i16
      cf.br ^bb1
    }
    %intr_ctrl_en_rising = hw.struct_extract %8["intr_ctrl_en_rising"] : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
    %q_7 = hw.struct_extract %intr_ctrl_en_rising["q"] : !hw.struct<q: i32>
    %159 = comb.and %112, %114, %q_7 {sv.namehint = "event_intr_rise"} : i32
    %intr_ctrl_en_falling = hw.struct_extract %8["intr_ctrl_en_falling"] : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
    %q_8 = hw.struct_extract %intr_ctrl_en_falling["q"] : !hw.struct<q: i32>
    %160 = comb.and %115, %113, %q_8 {sv.namehint = "event_intr_fall"} : i32
    %intr_ctrl_en_lvlhigh = hw.struct_extract %8["intr_ctrl_en_lvlhigh"] : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
    %q_9 = hw.struct_extract %intr_ctrl_en_lvlhigh["q"] : !hw.struct<q: i32>
    %161 = comb.and %112, %q_9 {sv.namehint = "event_intr_acthigh"} : i32
    %intr_ctrl_en_lvllow = hw.struct_extract %8["intr_ctrl_en_lvllow"] : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
    %q_10 = hw.struct_extract %intr_ctrl_en_lvllow["q"] : !hw.struct<q: i32>
    %162 = comb.and %115, %q_10 {sv.namehint = "event_intr_actlow"} : i32
    %163 = comb.or %159, %160, %162, %161 {sv.namehint = "event_intr_combined"} : i32
    %alert_test = hw.struct_extract %8["alert_test"] : !hw.struct<intr_state: !hw.struct<q: i32>, intr_enable: !hw.struct<q: i32>, intr_test: !hw.struct<q: i32, qe: i1>, alert_test: !hw.struct<q: i1, qe: i1>, direct_out: !hw.struct<q: i32, qe: i1>, masked_out_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_out_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, direct_oe: !hw.struct<q: i32, qe: i1>, masked_oe_lower: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, masked_oe_upper: !hw.struct<mask: !hw.struct<q: i16, qe: i1>, data: !hw.struct<q: i16, qe: i1>>, intr_ctrl_en_rising: !hw.struct<q: i32>, intr_ctrl_en_falling: !hw.struct<q: i32>, intr_ctrl_en_lvlhigh: !hw.struct<q: i32>, intr_ctrl_en_lvllow: !hw.struct<q: i32>, ctrl_en_input_filter: !hw.struct<q: i32>, hw_straps_data_in_valid: !hw.struct<q: i1>, hw_straps_data_in: !hw.struct<q: i32>>
    %q_11 = hw.struct_extract %alert_test["q"] : !hw.struct<q: i1, qe: i1>
    %qe_12 = hw.struct_extract %alert_test["qe"] : !hw.struct<q: i1, qe: i1>
    %164 = comb.and %q_11, %qe_12 : i1
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    %165 = llhd.prb %sampled_straps_o : !hw.struct<valid: i1, data: i32>
    %166 = llhd.prb %alert_tx_o : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    hw.output %165, %u_reg.tl_o, %intr_hw.intr_o, %166, %u_reg.racl_error_o, %129, %130 : !hw.struct<valid: i1, data: i32>, !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, i32, !hw.array<1xstruct<alert_p: i1, alert_n: i1>>, !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, i32, i32
  }
}
