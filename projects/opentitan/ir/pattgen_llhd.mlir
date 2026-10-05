module {
  hw.module private @prim_buf(in %in_i : i12, out out_o : i12) {
    hw.output %in_i : i12
  }
  hw.module private @prim_buf_10(in %in_i : i2, out out_o : i2) {
    hw.output %in_i : i2
  }
  hw.module private @prim_buf_12(in %in_i : i1, out out_o : i1) {
    hw.output %in_i : i1
  }
  hw.module private @prim_flop_2sync(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %false = hw.constant false
    %d_i_0 = llhd.sig name "d_i" %false : i1
    %d_o = llhd.sig %false : i1
    %1 = llhd.prb %d_o : i1
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_13(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i1) -> (q_o: i1) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_13(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i1) -> (q_o: i1)
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
  hw.module private @prim_flop_2sync_11(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
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
  hw.module private @prim_flop_13(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
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
    %u_prim_buf_in_req.out_o = hw.instance "u_prim_buf_in_req" @prim_sec_anchor_buf_4(in_i: %alert_req_i: i1) -> (out_o: i1) {sv.namehint = "alert_req"}
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
    %gen_async.i_sync_n.q_o = hw.instance "gen_async.i_sync_n" @prim_flop_2sync_11(clk_i: %2: i1, rst_ni: %3: i1, d_i: %diff_ni: i1) -> (q_o: i1)
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
  hw.module private @prim_reg_we_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i12, in %en_i : i1, out err_o : i1) {
    %c0_i4 = hw.constant 0 : i4
    %u_prim_buf.out_o = hw.instance "u_prim_buf" @prim_buf(in_i: %oh_i: i12) -> (out_o: i12) {sv.namehint = "oh_buf"}
    %u_prim_onehot_check.err_o = hw.instance "u_prim_onehot_check" @prim_onehot_check(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, oh_i: %u_prim_buf.out_o: i12, addr_i: %c0_i4: i4, en_i: %en_i: i1) -> (err_o: i1)
    hw.output %u_prim_onehot_check.err_o : i1
  }
  hw.module private @prim_sec_anchor_buf(in %in_i : i2, out out_o : i2) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf_10(in_i: %in_i: i2) -> (out_o: i2)
    hw.output %u_secure_anchor_buf.out_o : i2
  }
  hw.module private @prim_sec_anchor_buf_4(in %in_i : i1, out out_o : i1) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf_12(in_i: %in_i: i1) -> (out_o: i1)
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
  hw.module private @prim_subreg_arb_6(in %we : i1, in %wd : i1, in %de : i1, in %d : i1, in %q : i1, out wr_en : i1, out wr_data : i1) {
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
  hw.module private @prim_subreg_arb_7(in %we : i1, in %wd : i32, in %de : i1, in %d : i32, in %q : i32, out wr_en : i1, out wr_data : i32) {
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
  hw.module private @prim_subreg_arb_8(in %we : i1, in %wd : i6, in %de : i1, in %d : i6, in %q : i6, out wr_en : i1, out wr_data : i6) {
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
  hw.module private @prim_subreg_arb_9(in %we : i1, in %wd : i10, in %de : i1, in %d : i10, in %q : i10, out wr_en : i1, out wr_data : i10) {
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
  hw.module private @prim_subreg_0(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i1, in %de : i1, in %d : i1, out qe : i1, out q : i1, out ds : i1, out qs : i1) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_6(we: %we: i1, wd: %wd: i1, de: %de: i1, d: %d: i1, q: %4: i1) -> (wr_en: i1, wr_data: i1)
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_7(we: %we: i1, wd: %wd: i32, de: %de: i1, d: %d: i32, q: %4: i32) -> (wr_en: i1, wr_data: i32)
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
  hw.module private @prim_subreg_2(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i6, in %de : i1, in %d : i6, out qe : i1, out q : i6, out ds : i6, out qs : i6) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_8(we: %we: i1, wd: %wd: i6, de: %de: i1, d: %d: i6, q: %4: i6) -> (wr_en: i1, wr_data: i6)
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_9(we: %we: i1, wd: %wd: i10, de: %de: i1, d: %d: i10, q: %4: i10) -> (wr_en: i1, wr_data: i10)
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
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen_5(tl_i: %32: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
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
  hw.module private @tlul_rsp_intg_gen_5(in %tl_i : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) {
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
  hw.module private @pattgen_chan(in %clk_i : i1, in %rst_ni : i1, in %ctrl_i : !hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>, out pda_o : i1, out pcl_o : i1, out event_done_o : i1) {
    %c0_i58 = hw.constant 0 : i58
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %2 = hw.aggregate_constant [false, false, false, false, 0 : i32, 0, 0 : i6, 0 : i10] : !hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>
    %true = hw.constant true
    %c1_i10 = hw.constant 1 : i10
    %c1_i6 = hw.constant 1 : i6
    %c1_i32 = hw.constant 1 : i32
    %c0_i10 = hw.constant 0 : i10
    %c0_i6 = hw.constant 0 : i6
    %c0_i64 = hw.constant 0 : i64
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %ctrl_i_2 = llhd.sig name "ctrl_i" %2 : !hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>
    %pda_o = llhd.sig %false : i1
    %pcl_o = llhd.sig %false : i1
    %enable = llhd.sig %false : i1
    %polarity_q = llhd.sig %false : i1
    %inactive_level_pcl_q = llhd.sig %false : i1
    %inactive_level_pda_q = llhd.sig %false : i1
    %prediv_q = llhd.sig %c0_i32 : i32
    %data_q = llhd.sig %c0_i64 : i64
    %len_q = llhd.sig %c0_i6 : i6
    %reps_q = llhd.sig %c0_i10 : i10
    %clk_en = llhd.sig %false : i1
    %pcl_int_d = llhd.sig %false : i1
    %pcl_int_q = llhd.sig %false : i1
    %clk_cnt_d = llhd.sig %c0_i32 : i32
    %clk_cnt_q = llhd.sig %c0_i32 : i32
    %prediv_clk_rollover = llhd.sig %false : i1
    %bit_cnt_en = llhd.sig %false : i1
    %bit_cnt_d = llhd.sig %c0_i6 : i6
    %bit_cnt_q = llhd.sig %c0_i6 : i6
    %rep_cnt_en = llhd.sig %false : i1
    %rep_cnt_d = llhd.sig %c0_i10 : i10
    %rep_cnt_q = llhd.sig %c0_i10 : i10
    %complete_en = llhd.sig %false : i1
    %complete_d = llhd.sig %false : i1
    %complete_q = llhd.sig %false : i1
    %complete_q2 = llhd.sig %false : i1
    %active = llhd.sig %false : i1
    %active_d = llhd.sig %false : i1
    %active_q = llhd.sig %false : i1
    %5 = llhd.prb %ctrl_i_2 : !hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>
    %enable_3 = hw.struct_extract %5["enable"] : !hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>
    llhd.drv %enable, %enable_3 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %51 = llhd.prb %clk_i_0 : i1
      %52 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %53 = llhd.prb %clk_i_0 : i1
      %54 = comb.xor bin %51, %true : i1
      %55 = comb.and bin %54, %53 : i1
      %56 = llhd.prb %rst_ni_1 : i1
      %57 = comb.xor bin %56, %true : i1
      %58 = comb.and bin %52, %57 : i1
      %59 = comb.or bin %55, %58 : i1
      cf.cond_br %59, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %60 = llhd.prb %rst_ni_1 : i1
      %61 = comb.xor %60, %true : i1
      cf.cond_br %61, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %polarity_q, %false after %0 : i1
      llhd.drv %inactive_level_pcl_q, %false after %0 : i1
      llhd.drv %inactive_level_pda_q, %false after %0 : i1
      llhd.drv %prediv_q, %c0_i32 after %0 : i32
      llhd.drv %data_q, %c0_i64 after %0 : i64
      llhd.drv %len_q, %c0_i6 after %0 : i6
      llhd.drv %reps_q, %c0_i10 after %0 : i10
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %62 = llhd.prb %enable : i1
      %63 = llhd.prb %polarity_q : i1
      %64 = llhd.prb %ctrl_i_2 : !hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>
      %polarity = hw.struct_extract %64["polarity"] : !hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>
      %65 = comb.mux %62, %63, %polarity : i1
      llhd.drv %polarity_q, %65 after %0 : i1
      %66 = llhd.prb %enable : i1
      %67 = llhd.prb %inactive_level_pcl_q : i1
      %68 = llhd.prb %ctrl_i_2 : !hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>
      %inactive_level_pcl = hw.struct_extract %68["inactive_level_pcl"] : !hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>
      %69 = comb.mux %66, %67, %inactive_level_pcl : i1
      llhd.drv %inactive_level_pcl_q, %69 after %0 : i1
      %70 = llhd.prb %enable : i1
      %71 = llhd.prb %inactive_level_pda_q : i1
      %72 = llhd.prb %ctrl_i_2 : !hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>
      %inactive_level_pda = hw.struct_extract %72["inactive_level_pda"] : !hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>
      %73 = comb.mux %70, %71, %inactive_level_pda : i1
      llhd.drv %inactive_level_pda_q, %73 after %0 : i1
      %74 = llhd.prb %enable : i1
      %75 = llhd.prb %prediv_q : i32
      %76 = llhd.prb %ctrl_i_2 : !hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>
      %prediv = hw.struct_extract %76["prediv"] : !hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>
      %77 = comb.mux %74, %75, %prediv : i32
      llhd.drv %prediv_q, %77 after %0 : i32
      %78 = llhd.prb %enable : i1
      %79 = llhd.prb %data_q : i64
      %80 = llhd.prb %ctrl_i_2 : !hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>
      %data = hw.struct_extract %80["data"] : !hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>
      %81 = comb.mux %78, %79, %data : i64
      llhd.drv %data_q, %81 after %0 : i64
      %82 = llhd.prb %enable : i1
      %83 = llhd.prb %len_q : i6
      %84 = llhd.prb %ctrl_i_2 : !hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>
      %len = hw.struct_extract %84["len"] : !hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>
      %85 = comb.mux %82, %83, %len : i6
      llhd.drv %len_q, %85 after %0 : i6
      %86 = llhd.prb %enable : i1
      %87 = llhd.prb %reps_q : i10
      %88 = llhd.prb %ctrl_i_2 : !hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>
      %reps = hw.struct_extract %88["reps"] : !hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>
      %89 = comb.mux %86, %87, %reps : i10
      llhd.drv %reps_q, %89 after %0 : i10
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %51 = llhd.prb %clk_i_0 : i1
      %52 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %53 = llhd.prb %clk_i_0 : i1
      %54 = comb.xor bin %51, %true : i1
      %55 = comb.and bin %54, %53 : i1
      %56 = llhd.prb %rst_ni_1 : i1
      %57 = comb.xor bin %56, %true : i1
      %58 = comb.and bin %52, %57 : i1
      %59 = comb.or bin %55, %58 : i1
      cf.cond_br %59, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %60 = llhd.prb %rst_ni_1 : i1
      %61 = comb.xor %60, %true : i1
      cf.cond_br %61, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %pcl_o, %false after %0 : i1
      llhd.drv %pda_o, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %62 = llhd.prb %active : i1
      %63 = llhd.prb %polarity_q : i1
      %64 = llhd.prb %pcl_int_q : i1
      %65 = comb.xor %63, %64 : i1
      %66 = llhd.prb %inactive_level_pcl_q : i1
      %67 = comb.mux %62, %65, %66 : i1
      llhd.drv %pcl_o, %67 after %0 : i1
      %68 = llhd.prb %active : i1
      %69 = llhd.prb %data_q : i64
      %70 = llhd.prb %bit_cnt_q : i6
      %71 = comb.concat %c0_i58, %70 : i58, i6
      %72 = comb.shru %69, %71 : i64
      %73 = comb.extract %72 from 0 : (i64) -> i1
      %74 = llhd.prb %inactive_level_pda_q : i1
      %75 = comb.mux %68, %73, %74 : i1
      llhd.drv %pda_o, %75 after %0 : i1
      cf.br ^bb1
    }
    %6 = llhd.prb %complete_q : i1
    %7 = comb.xor %6, %true : i1
    llhd.drv %clk_en, %7 after %1 : i1
    %8 = llhd.prb %clk_cnt_q : i32
    %9 = llhd.prb %prediv_q : i32
    %10 = comb.icmp eq %8, %9 : i32
    llhd.drv %prediv_clk_rollover, %10 after %1 : i1
    %11 = llhd.prb %enable : i1
    %12 = comb.xor %11, %true : i1
    %13 = llhd.prb %prediv_clk_rollover : i1
    %14 = comb.add %8, %c1_i32 : i32
    %15 = comb.or %12, %13 : i1
    %16 = comb.mux %15, %c0_i32, %14 : i32
    llhd.drv %clk_cnt_d, %16 after %1 : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %51 = llhd.prb %clk_i_0 : i1
      %52 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %53 = llhd.prb %clk_i_0 : i1
      %54 = comb.xor bin %51, %true : i1
      %55 = comb.and bin %54, %53 : i1
      %56 = llhd.prb %rst_ni_1 : i1
      %57 = comb.xor bin %56, %true : i1
      %58 = comb.and bin %52, %57 : i1
      %59 = comb.or bin %55, %58 : i1
      cf.cond_br %59, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %60 = llhd.prb %rst_ni_1 : i1
      %61 = comb.xor %60, %true : i1
      cf.cond_br %61, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %clk_cnt_q, %c0_i32 after %0 : i32
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %62 = llhd.prb %clk_en : i1
      %63 = llhd.prb %clk_cnt_d : i32
      %64 = llhd.prb %clk_cnt_q : i32
      %65 = comb.mux %62, %63, %64 : i32
      llhd.drv %clk_cnt_q, %65 after %0 : i32
      cf.br ^bb1
    }
    %17 = llhd.prb %pcl_int_q : i1
    %18 = comb.xor %13, %17 : i1
    %19 = comb.and %11, %18 : i1
    llhd.drv %pcl_int_d, %19 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %51 = llhd.prb %clk_i_0 : i1
      %52 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %53 = llhd.prb %clk_i_0 : i1
      %54 = comb.xor bin %51, %true : i1
      %55 = comb.and bin %54, %53 : i1
      %56 = llhd.prb %rst_ni_1 : i1
      %57 = comb.xor bin %56, %true : i1
      %58 = comb.and bin %52, %57 : i1
      %59 = comb.or bin %55, %58 : i1
      cf.cond_br %59, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %60 = llhd.prb %rst_ni_1 : i1
      %61 = comb.xor %60, %true : i1
      cf.cond_br %61, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %pcl_int_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %62 = llhd.prb %clk_en : i1
      %63 = llhd.prb %pcl_int_d : i1
      %64 = llhd.prb %pcl_int_q : i1
      %65 = comb.mux %62, %63, %64 : i1
      llhd.drv %pcl_int_q, %65 after %0 : i1
      cf.br ^bb1
    }
    %20 = comb.and %17, %13 : i1
    %21 = comb.or %20, %12 : i1
    llhd.drv %bit_cnt_en, %21 after %1 : i1
    %22 = llhd.prb %bit_cnt_q : i6
    %23 = llhd.prb %len_q : i6
    %24 = comb.icmp eq %22, %23 : i6
    %25 = comb.add %22, %c1_i6 : i6
    %26 = comb.or %12, %24 : i1
    %27 = comb.mux %26, %c0_i6, %25 : i6
    llhd.drv %bit_cnt_d, %27 after %1 : i6
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %51 = llhd.prb %clk_i_0 : i1
      %52 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %53 = llhd.prb %clk_i_0 : i1
      %54 = comb.xor bin %51, %true : i1
      %55 = comb.and bin %54, %53 : i1
      %56 = llhd.prb %rst_ni_1 : i1
      %57 = comb.xor bin %56, %true : i1
      %58 = comb.and bin %52, %57 : i1
      %59 = comb.or bin %55, %58 : i1
      cf.cond_br %59, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %60 = llhd.prb %rst_ni_1 : i1
      %61 = comb.xor %60, %true : i1
      cf.cond_br %61, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %bit_cnt_q, %c0_i6 after %0 : i6
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %62 = llhd.prb %bit_cnt_en : i1
      %63 = llhd.prb %bit_cnt_d : i6
      %64 = llhd.prb %bit_cnt_q : i6
      %65 = comb.mux %62, %63, %64 : i6
      llhd.drv %bit_cnt_q, %65 after %0 : i6
      cf.br ^bb1
    }
    %28 = llhd.prb %bit_cnt_en : i1
    %29 = comb.and %28, %24 : i1
    %30 = comb.or %29, %12 : i1
    llhd.drv %rep_cnt_en, %30 after %1 : i1
    %31 = llhd.prb %rep_cnt_q : i10
    %32 = llhd.prb %reps_q : i10
    %33 = comb.icmp eq %31, %32 : i10
    %34 = comb.add %31, %c1_i10 : i10
    %35 = comb.or %12, %33 : i1
    %36 = comb.mux %35, %c0_i10, %34 : i10
    llhd.drv %rep_cnt_d, %36 after %1 : i10
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %51 = llhd.prb %clk_i_0 : i1
      %52 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %53 = llhd.prb %clk_i_0 : i1
      %54 = comb.xor bin %51, %true : i1
      %55 = comb.and bin %54, %53 : i1
      %56 = llhd.prb %rst_ni_1 : i1
      %57 = comb.xor bin %56, %true : i1
      %58 = comb.and bin %52, %57 : i1
      %59 = comb.or bin %55, %58 : i1
      cf.cond_br %59, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %60 = llhd.prb %rst_ni_1 : i1
      %61 = comb.xor %60, %true : i1
      cf.cond_br %61, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %rep_cnt_q, %c0_i10 after %0 : i10
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %62 = llhd.prb %rep_cnt_en : i1
      %63 = llhd.prb %rep_cnt_d : i10
      %64 = llhd.prb %rep_cnt_q : i10
      %65 = comb.mux %62, %63, %64 : i10
      llhd.drv %rep_cnt_q, %65 after %0 : i10
      cf.br ^bb1
    }
    %37 = llhd.prb %rep_cnt_en : i1
    %38 = comb.and %37, %33 : i1
    %39 = comb.or %38, %12 : i1
    llhd.drv %complete_en, %39 after %1 : i1
    llhd.drv %complete_d, %11 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %51 = llhd.prb %clk_i_0 : i1
      %52 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %53 = llhd.prb %clk_i_0 : i1
      %54 = comb.xor bin %51, %true : i1
      %55 = comb.and bin %54, %53 : i1
      %56 = llhd.prb %rst_ni_1 : i1
      %57 = comb.xor bin %56, %true : i1
      %58 = comb.and bin %52, %57 : i1
      %59 = comb.or bin %55, %58 : i1
      cf.cond_br %59, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %60 = llhd.prb %rst_ni_1 : i1
      %61 = comb.xor %60, %true : i1
      cf.cond_br %61, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %complete_q, %false after %0 : i1
      llhd.drv %complete_q2, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %62 = llhd.prb %complete_en : i1
      %63 = llhd.prb %complete_d : i1
      %64 = llhd.prb %complete_q : i1
      %65 = comb.mux %62, %63, %64 : i1
      llhd.drv %complete_q, %65 after %0 : i1
      %66 = llhd.prb %complete_q : i1
      llhd.drv %complete_q2, %66 after %0 : i1
      cf.br ^bb1
    }
    %40 = llhd.prb %complete_q2 : i1
    %41 = comb.xor %40, %true : i1
    %42 = comb.and %6, %41 : i1
    %43 = llhd.prb %active_q : i1
    %44 = comb.or %11, %43 : i1
    %45 = comb.xor %6, %true : i1
    %46 = comb.and %45, %44 : i1
    llhd.drv %active_d, %46 after %1 : i1
    %47 = llhd.prb %active_d : i1
    %48 = comb.mux %11, %47, %43 : i1
    llhd.drv %active, %48 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %51 = llhd.prb %clk_i_0 : i1
      %52 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %53 = llhd.prb %clk_i_0 : i1
      %54 = comb.xor bin %51, %true : i1
      %55 = comb.and bin %54, %53 : i1
      %56 = llhd.prb %rst_ni_1 : i1
      %57 = comb.xor bin %56, %true : i1
      %58 = comb.and bin %52, %57 : i1
      %59 = comb.or bin %55, %58 : i1
      cf.cond_br %59, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %60 = llhd.prb %rst_ni_1 : i1
      %61 = comb.xor %60, %true : i1
      cf.cond_br %61, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %active_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %62 = llhd.prb %active_d : i1
      llhd.drv %active_q, %62 after %0 : i1
      cf.br ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %ctrl_i_2, %ctrl_i after %1 : !hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>
    %49 = llhd.prb %pda_o : i1
    %50 = llhd.prb %pcl_o : i1
    hw.output %49, %50, %42 : i1, i1, i1
  }
  hw.module private @pattgen_core(in %clk_i : i1, in %rst_ni : i1, in %reg2hw : !hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>, out hw2reg : !hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<d: i1, de: i1>, done_ch0: !hw.struct<d: i1, de: i1>>>, out pda0_tx_o : i1, out pcl0_tx_o : i1, out pda1_tx_o : i1, out pcl1_tx_o : i1, out intr_done_ch0_o : i1, out intr_done_ch1_o : i1) {
    %false = hw.constant false
    %c0_i6 = hw.constant 0 : i6
    %true = hw.constant true
    %c-32_i6 = hw.constant -32 : i6
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %1 = hw.aggregate_constant [false, false, false, false, 0 : i32, 0, 0 : i6, 0 : i10] : !hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>
    %2 = hw.aggregate_constant [[[false, false], [false, false]]] : !hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<d: i1, de: i1>, done_ch0: !hw.struct<d: i1, de: i1>>>
    %hw2reg = llhd.sig %2 : !hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<d: i1, de: i1>, done_ch0: !hw.struct<d: i1, de: i1>>>
    %ch0_ctrl = llhd.sig %1 : !hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>
    %ch1_ctrl = llhd.sig %1 : !hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>
    %3 = llhd.prb %ch0_ctrl : !hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>
    %chan0.pda_o, %chan0.pcl_o, %chan0.event_done_o = hw.instance "chan0" @pattgen_chan(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, ctrl_i: %3: !hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>) -> (pda_o: i1, pcl_o: i1, event_done_o: i1) {sv.namehint = "event_done_ch0"}
    %4 = llhd.prb %ch1_ctrl : !hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>
    %chan1.pda_o, %chan1.pcl_o, %chan1.event_done_o = hw.instance "chan1" @pattgen_chan(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, ctrl_i: %4: !hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>) -> (pda_o: i1, pcl_o: i1, event_done_o: i1) {sv.namehint = "event_done_ch1"}
    %intr_enable = hw.struct_extract %reg2hw["intr_enable"] : !hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>
    %done_ch0 = hw.struct_extract %intr_enable["done_ch0"] : !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>
    %q = hw.struct_extract %done_ch0["q"] : !hw.struct<q: i1>
    %intr_test = hw.struct_extract %reg2hw["intr_test"] : !hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>
    %done_ch0_0 = hw.struct_extract %intr_test["done_ch0"] : !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>
    %q_1 = hw.struct_extract %done_ch0_0["q"] : !hw.struct<q: i1, qe: i1>
    %qe = hw.struct_extract %done_ch0_0["qe"] : !hw.struct<q: i1, qe: i1>
    %intr_state = hw.struct_extract %reg2hw["intr_state"] : !hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>
    %done_ch0_2 = hw.struct_extract %intr_state["done_ch0"] : !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>
    %q_3 = hw.struct_extract %done_ch0_2["q"] : !hw.struct<q: i1>
    %5 = llhd.sig.struct_extract %hw2reg["intr_state"] : <!hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<d: i1, de: i1>, done_ch0: !hw.struct<d: i1, de: i1>>>>
    %6 = llhd.sig.struct_extract %5["done_ch0"] : <!hw.struct<done_ch1: !hw.struct<d: i1, de: i1>, done_ch0: !hw.struct<d: i1, de: i1>>>
    %7 = llhd.sig.struct_extract %6["de"] : <!hw.struct<d: i1, de: i1>>
    %8 = llhd.sig.struct_extract %6["d"] : <!hw.struct<d: i1, de: i1>>
    %intr_hw_done_ch0.hw2reg_intr_state_de_o, %intr_hw_done_ch0.hw2reg_intr_state_d_o, %intr_hw_done_ch0.intr_o = hw.instance "intr_hw_done_ch0" @prim_intr_hw(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, event_intr_i: %chan0.event_done_o: i1, reg2hw_intr_enable_q_i: %q: i1, reg2hw_intr_test_q_i: %q_1: i1, reg2hw_intr_test_qe_i: %qe: i1, reg2hw_intr_state_q_i: %q_3: i1) -> (hw2reg_intr_state_de_o: i1, hw2reg_intr_state_d_o: i1, intr_o: i1)
    llhd.drv %7, %intr_hw_done_ch0.hw2reg_intr_state_de_o after %0 : i1
    llhd.drv %8, %intr_hw_done_ch0.hw2reg_intr_state_d_o after %0 : i1
    %done_ch1 = hw.struct_extract %intr_enable["done_ch1"] : !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>
    %q_4 = hw.struct_extract %done_ch1["q"] : !hw.struct<q: i1>
    %done_ch1_5 = hw.struct_extract %intr_test["done_ch1"] : !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>
    %q_6 = hw.struct_extract %done_ch1_5["q"] : !hw.struct<q: i1, qe: i1>
    %qe_7 = hw.struct_extract %done_ch1_5["qe"] : !hw.struct<q: i1, qe: i1>
    %done_ch1_8 = hw.struct_extract %intr_state["done_ch1"] : !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>
    %q_9 = hw.struct_extract %done_ch1_8["q"] : !hw.struct<q: i1>
    %9 = llhd.sig.struct_extract %5["done_ch1"] : <!hw.struct<done_ch1: !hw.struct<d: i1, de: i1>, done_ch0: !hw.struct<d: i1, de: i1>>>
    %10 = llhd.sig.struct_extract %9["de"] : <!hw.struct<d: i1, de: i1>>
    %11 = llhd.sig.struct_extract %9["d"] : <!hw.struct<d: i1, de: i1>>
    %intr_hw_done_ch1.hw2reg_intr_state_de_o, %intr_hw_done_ch1.hw2reg_intr_state_d_o, %intr_hw_done_ch1.intr_o = hw.instance "intr_hw_done_ch1" @prim_intr_hw(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, event_intr_i: %chan1.event_done_o: i1, reg2hw_intr_enable_q_i: %q_4: i1, reg2hw_intr_test_q_i: %q_6: i1, reg2hw_intr_test_qe_i: %qe_7: i1, reg2hw_intr_state_q_i: %q_9: i1) -> (hw2reg_intr_state_de_o: i1, hw2reg_intr_state_d_o: i1, intr_o: i1)
    llhd.drv %10, %intr_hw_done_ch1.hw2reg_intr_state_de_o after %0 : i1
    llhd.drv %11, %intr_hw_done_ch1.hw2reg_intr_state_d_o after %0 : i1
    %12 = llhd.sig.struct_extract %ch0_ctrl["enable"] : <!hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>>
    %ctrl = hw.struct_extract %reg2hw["ctrl"] : !hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>
    %enable_ch0 = hw.struct_extract %ctrl["enable_ch0"] : !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>
    %q_10 = hw.struct_extract %enable_ch0["q"] : !hw.struct<q: i1>
    llhd.drv %12, %q_10 after %0 : i1
    %13 = llhd.sig.struct_extract %ch0_ctrl["polarity"] : <!hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>>
    %polarity_ch0 = hw.struct_extract %ctrl["polarity_ch0"] : !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>
    %q_11 = hw.struct_extract %polarity_ch0["q"] : !hw.struct<q: i1>
    llhd.drv %13, %q_11 after %0 : i1
    %14 = llhd.sig.struct_extract %ch0_ctrl["inactive_level_pcl"] : <!hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>>
    %inactive_level_pcl_ch0 = hw.struct_extract %ctrl["inactive_level_pcl_ch0"] : !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>
    %q_12 = hw.struct_extract %inactive_level_pcl_ch0["q"] : !hw.struct<q: i1>
    llhd.drv %14, %q_12 after %0 : i1
    %15 = llhd.sig.struct_extract %ch0_ctrl["inactive_level_pda"] : <!hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>>
    %inactive_level_pda_ch0 = hw.struct_extract %ctrl["inactive_level_pda_ch0"] : !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>
    %q_13 = hw.struct_extract %inactive_level_pda_ch0["q"] : !hw.struct<q: i1>
    llhd.drv %15, %q_13 after %0 : i1
    %16 = llhd.sig.struct_extract %ch0_ctrl["data"] : <!hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>>
    %17 = llhd.sig.extract %16 from %c-32_i6 : <i64> -> <i32>
    %data_ch0 = hw.struct_extract %reg2hw["data_ch0"] : !hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>
    %18 = hw.array_get %data_ch0[%true] : !hw.array<2xstruct<q: i32>>, i1
    %q_14 = hw.struct_extract %18["q"] : !hw.struct<q: i32>
    llhd.drv %17, %q_14 after %0 : i32
    %19 = llhd.sig.extract %16 from %c0_i6 : <i64> -> <i32>
    %20 = hw.array_get %data_ch0[%false] : !hw.array<2xstruct<q: i32>>, i1
    %q_15 = hw.struct_extract %20["q"] : !hw.struct<q: i32>
    llhd.drv %19, %q_15 after %0 : i32
    %21 = llhd.sig.struct_extract %ch0_ctrl["prediv"] : <!hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>>
    %prediv_ch0 = hw.struct_extract %reg2hw["prediv_ch0"] : !hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>
    %q_16 = hw.struct_extract %prediv_ch0["q"] : !hw.struct<q: i32>
    llhd.drv %21, %q_16 after %0 : i32
    %22 = llhd.sig.struct_extract %ch0_ctrl["len"] : <!hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>>
    %size = hw.struct_extract %reg2hw["size"] : !hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>
    %len_ch0 = hw.struct_extract %size["len_ch0"] : !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>
    %q_17 = hw.struct_extract %len_ch0["q"] : !hw.struct<q: i6>
    llhd.drv %22, %q_17 after %0 : i6
    %23 = llhd.sig.struct_extract %ch0_ctrl["reps"] : <!hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>>
    %reps_ch0 = hw.struct_extract %size["reps_ch0"] : !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>
    %q_18 = hw.struct_extract %reps_ch0["q"] : !hw.struct<q: i10>
    llhd.drv %23, %q_18 after %0 : i10
    %24 = llhd.sig.struct_extract %ch1_ctrl["enable"] : <!hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>>
    %enable_ch1 = hw.struct_extract %ctrl["enable_ch1"] : !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>
    %q_19 = hw.struct_extract %enable_ch1["q"] : !hw.struct<q: i1>
    llhd.drv %24, %q_19 after %0 : i1
    %25 = llhd.sig.struct_extract %ch1_ctrl["polarity"] : <!hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>>
    %polarity_ch1 = hw.struct_extract %ctrl["polarity_ch1"] : !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>
    %q_20 = hw.struct_extract %polarity_ch1["q"] : !hw.struct<q: i1>
    llhd.drv %25, %q_20 after %0 : i1
    %26 = llhd.sig.struct_extract %ch1_ctrl["inactive_level_pcl"] : <!hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>>
    %inactive_level_pcl_ch1 = hw.struct_extract %ctrl["inactive_level_pcl_ch1"] : !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>
    %q_21 = hw.struct_extract %inactive_level_pcl_ch1["q"] : !hw.struct<q: i1>
    llhd.drv %26, %q_21 after %0 : i1
    %27 = llhd.sig.struct_extract %ch1_ctrl["inactive_level_pda"] : <!hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>>
    %inactive_level_pda_ch1 = hw.struct_extract %ctrl["inactive_level_pda_ch1"] : !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>
    %q_22 = hw.struct_extract %inactive_level_pda_ch1["q"] : !hw.struct<q: i1>
    llhd.drv %27, %q_22 after %0 : i1
    %28 = llhd.sig.struct_extract %ch1_ctrl["data"] : <!hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>>
    %29 = llhd.sig.extract %28 from %c-32_i6 : <i64> -> <i32>
    %data_ch1 = hw.struct_extract %reg2hw["data_ch1"] : !hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>
    %30 = hw.array_get %data_ch1[%true] : !hw.array<2xstruct<q: i32>>, i1
    %q_23 = hw.struct_extract %30["q"] : !hw.struct<q: i32>
    llhd.drv %29, %q_23 after %0 : i32
    %31 = llhd.sig.extract %28 from %c0_i6 : <i64> -> <i32>
    %32 = hw.array_get %data_ch1[%false] : !hw.array<2xstruct<q: i32>>, i1
    %q_24 = hw.struct_extract %32["q"] : !hw.struct<q: i32>
    llhd.drv %31, %q_24 after %0 : i32
    %33 = llhd.sig.struct_extract %ch1_ctrl["prediv"] : <!hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>>
    %prediv_ch1 = hw.struct_extract %reg2hw["prediv_ch1"] : !hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>
    %q_25 = hw.struct_extract %prediv_ch1["q"] : !hw.struct<q: i32>
    llhd.drv %33, %q_25 after %0 : i32
    %34 = llhd.sig.struct_extract %ch1_ctrl["len"] : <!hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>>
    %len_ch1 = hw.struct_extract %size["len_ch1"] : !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>
    %q_26 = hw.struct_extract %len_ch1["q"] : !hw.struct<q: i6>
    llhd.drv %34, %q_26 after %0 : i6
    %35 = llhd.sig.struct_extract %ch1_ctrl["reps"] : <!hw.struct<enable: i1, polarity: i1, inactive_level_pcl: i1, inactive_level_pda: i1, prediv: i32, data: i64, len: i6, reps: i10>>
    %reps_ch1 = hw.struct_extract %size["reps_ch1"] : !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>
    %q_27 = hw.struct_extract %reps_ch1["q"] : !hw.struct<q: i10>
    llhd.drv %35, %q_27 after %0 : i10
    %36 = llhd.prb %hw2reg : !hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<d: i1, de: i1>, done_ch0: !hw.struct<d: i1, de: i1>>>
    hw.output %36, %chan0.pda_o, %chan0.pcl_o, %chan1.pda_o, %chan1.pcl_o, %intr_hw_done_ch0.intr_o, %intr_hw_done_ch1.intr_o : !hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<d: i1, de: i1>, done_ch0: !hw.struct<d: i1, de: i1>>>, i1, i1, i1, i1, i1, i1
  }
  hw.module private @pattgen_reg_top(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out reg2hw : !hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>, in %hw2reg : !hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<d: i1, de: i1>, done_ch0: !hw.struct<d: i1, de: i1>>>, out intg_err_o : i1) {
    %c-1_i4 = hw.constant -1 : i4
    %c-10_i5 = hw.constant -10 : i5
    %c-16_i5 = hw.constant -16 : i5
    %c7_i5 = hw.constant 7 : i5
    %c6_i5 = hw.constant 6 : i5
    %c5_i5 = hw.constant 5 : i5
    %c4_i5 = hw.constant 4 : i5
    %c3_i5 = hw.constant 3 : i5
    %c2_i5 = hw.constant 2 : i5
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
    %c-1_i2 = hw.constant -1 : i2
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i2 = hw.constant 0 : i2
    %c0_i12 = hw.constant 0 : i12
    %c0_i4 = hw.constant 0 : i4
    %2 = hw.aggregate_constant [[[false], [false]], [[false], [false]], [[false, false], [false, false]], [false, false], [[false], [false], [false], [false], [false], [false], [false], [false]], [0 : i32], [0 : i32], [[0 : i32], [0 : i32]], [[0 : i32], [0 : i32]], [[0 : i10], [0 : i6], [0 : i10], [0 : i6]]] : !hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>
    %c-1_i32 = hw.constant -1 : i32
    %c1_i4 = hw.constant 1 : i4
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
    %true = hw.constant true
    %c0_i10 = hw.constant 0 : i10
    %c0_i6 = hw.constant 0 : i6
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false {sv.namehint = "shadow_busy"}
    %c-7_i4 = hw.constant -7 : i4
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %3 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %4 = llhd.prb %rst_ni_1 : i1
    %reg2hw = llhd.sig %2 : !hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>
    %reg_we = llhd.sig %false : i1
    %reg_addr = llhd.sig %c0_i6 : i6
    %reg_be = llhd.sig %c0_i4 : i4
    %wr_err = llhd.sig %false : i1
    %reg_rdata_next = llhd.sig %c0_i32 : i32
    %intg_err = llhd.sig %false : i1
    %reg_we_err = llhd.sig %false : i1
    %reg_we_check = llhd.sig %c0_i12 : i12
    %err_q = llhd.sig %false : i1
    %intr_state_we = llhd.sig %false : i1
    %intr_state_done_ch0_qs = llhd.sig %false : i1
    %intr_state_done_ch1_qs = llhd.sig %false : i1
    %intr_enable_we = llhd.sig %false : i1
    %intr_enable_done_ch0_qs = llhd.sig %false : i1
    %intr_enable_done_ch1_qs = llhd.sig %false : i1
    %intr_test_we = llhd.sig %false : i1
    %alert_test_we = llhd.sig %false : i1
    %ctrl_we = llhd.sig %false : i1
    %ctrl_enable_ch0_qs = llhd.sig %false : i1
    %ctrl_enable_ch1_qs = llhd.sig %false : i1
    %ctrl_polarity_ch0_qs = llhd.sig %false : i1
    %ctrl_polarity_ch1_qs = llhd.sig %false : i1
    %ctrl_inactive_level_pcl_ch0_qs = llhd.sig %false : i1
    %ctrl_inactive_level_pda_ch0_qs = llhd.sig %false : i1
    %ctrl_inactive_level_pcl_ch1_qs = llhd.sig %false : i1
    %ctrl_inactive_level_pda_ch1_qs = llhd.sig %false : i1
    %prediv_ch0_we = llhd.sig %false : i1
    %prediv_ch0_qs = llhd.sig %c0_i32 : i32
    %prediv_ch1_we = llhd.sig %false : i1
    %prediv_ch1_qs = llhd.sig %c0_i32 : i32
    %data_ch0_0_we = llhd.sig %false : i1
    %data_ch0_0_qs = llhd.sig %c0_i32 : i32
    %data_ch0_1_we = llhd.sig %false : i1
    %data_ch0_1_qs = llhd.sig %c0_i32 : i32
    %data_ch1_0_we = llhd.sig %false : i1
    %data_ch1_0_qs = llhd.sig %c0_i32 : i32
    %data_ch1_1_we = llhd.sig %false : i1
    %data_ch1_1_qs = llhd.sig %c0_i32 : i32
    %size_we = llhd.sig %false : i1
    %size_len_ch0_qs = llhd.sig %c0_i6 : i6
    %size_reps_ch0_qs = llhd.sig %c0_i10 : i10
    %size_len_ch1_qs = llhd.sig %c0_i6 : i6
    %size_reps_ch1_qs = llhd.sig %c0_i10 : i10
    %intr_test_flds_we = llhd.sig %c0_i2 : i2
    %alert_test_flds_we = llhd.sig %false : i1
    %addr_hit = llhd.sig %c0_i12 : i12
    %u_chk.err_o = hw.instance "u_chk" @tlul_cmd_intg_chk(tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> (err_o: i1)
    llhd.drv %intg_err, %u_chk.err_o after %1 : i1
    %5 = llhd.prb %reg_we_check : i12
    %6 = llhd.prb %reg_we : i1
    %7 = comb.xor %97, %true : i1
    %8 = comb.and %6, %7 : i1
    %u_prim_reg_we_check.err_o = hw.instance "u_prim_reg_we_check" @prim_reg_we_check(clk_i: %3: i1, rst_ni: %4: i1, oh_i: %5: i12, en_i: %8: i1) -> (err_o: i1)
    llhd.drv %reg_we_err, %u_prim_reg_we_check.err_o after %1 : i1
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen(tl_i: %u_reg_if.tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
    %u_reg_if.tl_o, %u_reg_if.intg_error_o, %u_reg_if.re_o, %u_reg_if.we_o, %u_reg_if.addr_o, %u_reg_if.wdata_o, %u_reg_if.be_o = hw.instance "u_reg_if" @tlul_adapter_reg(clk_i: %3: i1, rst_ni: %4: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, en_ifetch_i: %c-7_i4: i4, busy_i: %false: i1, rdata_i: %84: i32, error_i: %86: i1) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, intg_error_o: i1, re_o: i1, we_o: i1, addr_o: i6, wdata_o: i32, be_o: i4) {sv.namehint = "reg_re"}
    llhd.drv %reg_we, %u_reg_if.we_o after %1 : i1
    llhd.drv %reg_addr, %u_reg_if.addr_o after %1 : i6
    llhd.drv %reg_be, %u_reg_if.be_o after %1 : i4
    %9 = llhd.prb %intr_state_we : i1
    %intr_state = hw.struct_extract %hw2reg["intr_state"] : !hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<d: i1, de: i1>, done_ch0: !hw.struct<d: i1, de: i1>>>
    %done_ch0 = hw.struct_extract %intr_state["done_ch0"] : !hw.struct<done_ch1: !hw.struct<d: i1, de: i1>, done_ch0: !hw.struct<d: i1, de: i1>>
    %de = hw.struct_extract %done_ch0["de"] : !hw.struct<d: i1, de: i1>
    %d = hw.struct_extract %done_ch0["d"] : !hw.struct<d: i1, de: i1>
    %10 = llhd.sig.struct_extract %reg2hw["intr_state"] : <!hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>>
    %11 = llhd.sig.struct_extract %10["done_ch0"] : <!hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>>
    %12 = llhd.sig.struct_extract %11["q"] : <!hw.struct<q: i1>>
    %u_intr_state_done_ch0.qe, %u_intr_state_done_ch0.q, %u_intr_state_done_ch0.ds, %u_intr_state_done_ch0.qs = hw.instance "u_intr_state_done_ch0" @prim_subreg(clk_i: %3: i1, rst_ni: %4: i1, we: %9: i1, wd: %102: i1, de: %de: i1, d: %d: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %12, %u_intr_state_done_ch0.q after %1 : i1
    llhd.drv %intr_state_done_ch0_qs, %u_intr_state_done_ch0.qs after %1 : i1
    %done_ch1 = hw.struct_extract %intr_state["done_ch1"] : !hw.struct<done_ch1: !hw.struct<d: i1, de: i1>, done_ch0: !hw.struct<d: i1, de: i1>>
    %de_2 = hw.struct_extract %done_ch1["de"] : !hw.struct<d: i1, de: i1>
    %d_3 = hw.struct_extract %done_ch1["d"] : !hw.struct<d: i1, de: i1>
    %13 = llhd.sig.struct_extract %10["done_ch1"] : <!hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>>
    %14 = llhd.sig.struct_extract %13["q"] : <!hw.struct<q: i1>>
    %u_intr_state_done_ch1.qe, %u_intr_state_done_ch1.q, %u_intr_state_done_ch1.ds, %u_intr_state_done_ch1.qs = hw.instance "u_intr_state_done_ch1" @prim_subreg(clk_i: %3: i1, rst_ni: %4: i1, we: %9: i1, wd: %103: i1, de: %de_2: i1, d: %d_3: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %14, %u_intr_state_done_ch1.q after %1 : i1
    llhd.drv %intr_state_done_ch1_qs, %u_intr_state_done_ch1.qs after %1 : i1
    %15 = llhd.prb %intr_enable_we : i1
    %16 = llhd.sig.struct_extract %reg2hw["intr_enable"] : <!hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>>
    %17 = llhd.sig.struct_extract %16["done_ch0"] : <!hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>>
    %18 = llhd.sig.struct_extract %17["q"] : <!hw.struct<q: i1>>
    %u_intr_enable_done_ch0.qe, %u_intr_enable_done_ch0.q, %u_intr_enable_done_ch0.ds, %u_intr_enable_done_ch0.qs = hw.instance "u_intr_enable_done_ch0" @prim_subreg_0(clk_i: %3: i1, rst_ni: %4: i1, we: %15: i1, wd: %102: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %18, %u_intr_enable_done_ch0.q after %1 : i1
    llhd.drv %intr_enable_done_ch0_qs, %u_intr_enable_done_ch0.qs after %1 : i1
    %19 = llhd.sig.struct_extract %16["done_ch1"] : <!hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>>
    %20 = llhd.sig.struct_extract %19["q"] : <!hw.struct<q: i1>>
    %u_intr_enable_done_ch1.qe, %u_intr_enable_done_ch1.q, %u_intr_enable_done_ch1.ds, %u_intr_enable_done_ch1.qs = hw.instance "u_intr_enable_done_ch1" @prim_subreg_0(clk_i: %3: i1, rst_ni: %4: i1, we: %15: i1, wd: %103: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %20, %u_intr_enable_done_ch1.q after %1 : i1
    llhd.drv %intr_enable_done_ch1_qs, %u_intr_enable_done_ch1.qs after %1 : i1
    %21 = llhd.prb %intr_test_we : i1
    %22 = llhd.sig.extract %intr_test_flds_we from %false : <i2> -> <i1>
    %23 = llhd.sig.struct_extract %reg2hw["intr_test"] : <!hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>>
    %24 = llhd.sig.struct_extract %23["done_ch0"] : <!hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>>
    %25 = llhd.sig.struct_extract %24["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_intr_test_done_ch0.qe, %u_intr_test_done_ch0.qre, %u_intr_test_done_ch0.q, %u_intr_test_done_ch0.ds, %u_intr_test_done_ch0.qs = hw.instance "u_intr_test_done_ch0" @prim_subreg_ext(re: %false: i1, we: %21: i1, wd: %102: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %22, %u_intr_test_done_ch0.qe after %1 : i1
    llhd.drv %25, %u_intr_test_done_ch0.q after %1 : i1
    %26 = llhd.sig.extract %intr_test_flds_we from %true : <i2> -> <i1>
    %27 = llhd.sig.struct_extract %23["done_ch1"] : <!hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>>
    %28 = llhd.sig.struct_extract %27["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_intr_test_done_ch1.qe, %u_intr_test_done_ch1.qre, %u_intr_test_done_ch1.q, %u_intr_test_done_ch1.ds, %u_intr_test_done_ch1.qs = hw.instance "u_intr_test_done_ch1" @prim_subreg_ext(re: %false: i1, we: %21: i1, wd: %103: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %26, %u_intr_test_done_ch1.qe after %1 : i1
    llhd.drv %28, %u_intr_test_done_ch1.q after %1 : i1
    %29 = llhd.prb %alert_test_we : i1
    %30 = llhd.sig.struct_extract %reg2hw["alert_test"] : <!hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>>
    %31 = llhd.sig.struct_extract %30["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_alert_test.qe, %u_alert_test.qre, %u_alert_test.q, %u_alert_test.ds, %u_alert_test.qs = hw.instance "u_alert_test" @prim_subreg_ext(re: %false: i1, we: %29: i1, wd: %102: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %alert_test_flds_we, %u_alert_test.qe after %1 : i1
    llhd.drv %31, %u_alert_test.q after %1 : i1
    %32 = llhd.prb %ctrl_we : i1
    %33 = llhd.sig.struct_extract %reg2hw["ctrl"] : <!hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>>
    %34 = llhd.sig.struct_extract %33["enable_ch0"] : <!hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>>
    %35 = llhd.sig.struct_extract %34["q"] : <!hw.struct<q: i1>>
    %u_ctrl_enable_ch0.qe, %u_ctrl_enable_ch0.q, %u_ctrl_enable_ch0.ds, %u_ctrl_enable_ch0.qs = hw.instance "u_ctrl_enable_ch0" @prim_subreg_0(clk_i: %3: i1, rst_ni: %4: i1, we: %32: i1, wd: %102: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %35, %u_ctrl_enable_ch0.q after %1 : i1
    llhd.drv %ctrl_enable_ch0_qs, %u_ctrl_enable_ch0.qs after %1 : i1
    %36 = llhd.sig.struct_extract %33["enable_ch1"] : <!hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>>
    %37 = llhd.sig.struct_extract %36["q"] : <!hw.struct<q: i1>>
    %u_ctrl_enable_ch1.qe, %u_ctrl_enable_ch1.q, %u_ctrl_enable_ch1.ds, %u_ctrl_enable_ch1.qs = hw.instance "u_ctrl_enable_ch1" @prim_subreg_0(clk_i: %3: i1, rst_ni: %4: i1, we: %32: i1, wd: %103: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %37, %u_ctrl_enable_ch1.q after %1 : i1
    llhd.drv %ctrl_enable_ch1_qs, %u_ctrl_enable_ch1.qs after %1 : i1
    %38 = llhd.sig.struct_extract %33["polarity_ch0"] : <!hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>>
    %39 = llhd.sig.struct_extract %38["q"] : <!hw.struct<q: i1>>
    %u_ctrl_polarity_ch0.qe, %u_ctrl_polarity_ch0.q, %u_ctrl_polarity_ch0.ds, %u_ctrl_polarity_ch0.qs = hw.instance "u_ctrl_polarity_ch0" @prim_subreg_0(clk_i: %3: i1, rst_ni: %4: i1, we: %32: i1, wd: %112: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %39, %u_ctrl_polarity_ch0.q after %1 : i1
    llhd.drv %ctrl_polarity_ch0_qs, %u_ctrl_polarity_ch0.qs after %1 : i1
    %40 = llhd.sig.struct_extract %33["polarity_ch1"] : <!hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>>
    %41 = llhd.sig.struct_extract %40["q"] : <!hw.struct<q: i1>>
    %u_ctrl_polarity_ch1.qe, %u_ctrl_polarity_ch1.q, %u_ctrl_polarity_ch1.ds, %u_ctrl_polarity_ch1.qs = hw.instance "u_ctrl_polarity_ch1" @prim_subreg_0(clk_i: %3: i1, rst_ni: %4: i1, we: %32: i1, wd: %113: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %41, %u_ctrl_polarity_ch1.q after %1 : i1
    llhd.drv %ctrl_polarity_ch1_qs, %u_ctrl_polarity_ch1.qs after %1 : i1
    %42 = llhd.sig.struct_extract %33["inactive_level_pcl_ch0"] : <!hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>>
    %43 = llhd.sig.struct_extract %42["q"] : <!hw.struct<q: i1>>
    %u_ctrl_inactive_level_pcl_ch0.qe, %u_ctrl_inactive_level_pcl_ch0.q, %u_ctrl_inactive_level_pcl_ch0.ds, %u_ctrl_inactive_level_pcl_ch0.qs = hw.instance "u_ctrl_inactive_level_pcl_ch0" @prim_subreg_0(clk_i: %3: i1, rst_ni: %4: i1, we: %32: i1, wd: %114: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %43, %u_ctrl_inactive_level_pcl_ch0.q after %1 : i1
    llhd.drv %ctrl_inactive_level_pcl_ch0_qs, %u_ctrl_inactive_level_pcl_ch0.qs after %1 : i1
    %44 = llhd.sig.struct_extract %33["inactive_level_pda_ch0"] : <!hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>>
    %45 = llhd.sig.struct_extract %44["q"] : <!hw.struct<q: i1>>
    %u_ctrl_inactive_level_pda_ch0.qe, %u_ctrl_inactive_level_pda_ch0.q, %u_ctrl_inactive_level_pda_ch0.ds, %u_ctrl_inactive_level_pda_ch0.qs = hw.instance "u_ctrl_inactive_level_pda_ch0" @prim_subreg_0(clk_i: %3: i1, rst_ni: %4: i1, we: %32: i1, wd: %115: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %45, %u_ctrl_inactive_level_pda_ch0.q after %1 : i1
    llhd.drv %ctrl_inactive_level_pda_ch0_qs, %u_ctrl_inactive_level_pda_ch0.qs after %1 : i1
    %46 = llhd.sig.struct_extract %33["inactive_level_pcl_ch1"] : <!hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>>
    %47 = llhd.sig.struct_extract %46["q"] : <!hw.struct<q: i1>>
    %u_ctrl_inactive_level_pcl_ch1.qe, %u_ctrl_inactive_level_pcl_ch1.q, %u_ctrl_inactive_level_pcl_ch1.ds, %u_ctrl_inactive_level_pcl_ch1.qs = hw.instance "u_ctrl_inactive_level_pcl_ch1" @prim_subreg_0(clk_i: %3: i1, rst_ni: %4: i1, we: %32: i1, wd: %116: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %47, %u_ctrl_inactive_level_pcl_ch1.q after %1 : i1
    llhd.drv %ctrl_inactive_level_pcl_ch1_qs, %u_ctrl_inactive_level_pcl_ch1.qs after %1 : i1
    %48 = llhd.sig.struct_extract %33["inactive_level_pda_ch1"] : <!hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>>
    %49 = llhd.sig.struct_extract %48["q"] : <!hw.struct<q: i1>>
    %u_ctrl_inactive_level_pda_ch1.qe, %u_ctrl_inactive_level_pda_ch1.q, %u_ctrl_inactive_level_pda_ch1.ds, %u_ctrl_inactive_level_pda_ch1.qs = hw.instance "u_ctrl_inactive_level_pda_ch1" @prim_subreg_0(clk_i: %3: i1, rst_ni: %4: i1, we: %32: i1, wd: %117: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %49, %u_ctrl_inactive_level_pda_ch1.q after %1 : i1
    llhd.drv %ctrl_inactive_level_pda_ch1_qs, %u_ctrl_inactive_level_pda_ch1.qs after %1 : i1
    %50 = llhd.prb %prediv_ch0_we : i1
    %51 = llhd.sig.struct_extract %reg2hw["prediv_ch0"] : <!hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>>
    %52 = llhd.sig.struct_extract %51["q"] : <!hw.struct<q: i32>>
    %u_prediv_ch0.qe, %u_prediv_ch0.q, %u_prediv_ch0.ds, %u_prediv_ch0.qs = hw.instance "u_prediv_ch0" @prim_subreg_1(clk_i: %3: i1, rst_ni: %4: i1, we: %50: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %52, %u_prediv_ch0.q after %1 : i32
    llhd.drv %prediv_ch0_qs, %u_prediv_ch0.qs after %1 : i32
    %53 = llhd.prb %prediv_ch1_we : i1
    %54 = llhd.sig.struct_extract %reg2hw["prediv_ch1"] : <!hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>>
    %55 = llhd.sig.struct_extract %54["q"] : <!hw.struct<q: i32>>
    %u_prediv_ch1.qe, %u_prediv_ch1.q, %u_prediv_ch1.ds, %u_prediv_ch1.qs = hw.instance "u_prediv_ch1" @prim_subreg_1(clk_i: %3: i1, rst_ni: %4: i1, we: %53: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %55, %u_prediv_ch1.q after %1 : i32
    llhd.drv %prediv_ch1_qs, %u_prediv_ch1.qs after %1 : i32
    %56 = llhd.prb %data_ch0_0_we : i1
    %57 = llhd.sig.struct_extract %reg2hw["data_ch0"] : <!hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>>
    %58 = llhd.sig.array_get %57[%false] : <!hw.array<2xstruct<q: i32>>>
    %59 = llhd.sig.struct_extract %58["q"] : <!hw.struct<q: i32>>
    %u_data_ch0_0.qe, %u_data_ch0_0.q, %u_data_ch0_0.ds, %u_data_ch0_0.qs = hw.instance "u_data_ch0_0" @prim_subreg_1(clk_i: %3: i1, rst_ni: %4: i1, we: %56: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %59, %u_data_ch0_0.q after %1 : i32
    llhd.drv %data_ch0_0_qs, %u_data_ch0_0.qs after %1 : i32
    %60 = llhd.prb %data_ch0_1_we : i1
    %61 = llhd.sig.array_get %57[%true] : <!hw.array<2xstruct<q: i32>>>
    %62 = llhd.sig.struct_extract %61["q"] : <!hw.struct<q: i32>>
    %u_data_ch0_1.qe, %u_data_ch0_1.q, %u_data_ch0_1.ds, %u_data_ch0_1.qs = hw.instance "u_data_ch0_1" @prim_subreg_1(clk_i: %3: i1, rst_ni: %4: i1, we: %60: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %62, %u_data_ch0_1.q after %1 : i32
    llhd.drv %data_ch0_1_qs, %u_data_ch0_1.qs after %1 : i32
    %63 = llhd.prb %data_ch1_0_we : i1
    %64 = llhd.sig.struct_extract %reg2hw["data_ch1"] : <!hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>>
    %65 = llhd.sig.array_get %64[%false] : <!hw.array<2xstruct<q: i32>>>
    %66 = llhd.sig.struct_extract %65["q"] : <!hw.struct<q: i32>>
    %u_data_ch1_0.qe, %u_data_ch1_0.q, %u_data_ch1_0.ds, %u_data_ch1_0.qs = hw.instance "u_data_ch1_0" @prim_subreg_1(clk_i: %3: i1, rst_ni: %4: i1, we: %63: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %66, %u_data_ch1_0.q after %1 : i32
    llhd.drv %data_ch1_0_qs, %u_data_ch1_0.qs after %1 : i32
    %67 = llhd.prb %data_ch1_1_we : i1
    %68 = llhd.sig.array_get %64[%true] : <!hw.array<2xstruct<q: i32>>>
    %69 = llhd.sig.struct_extract %68["q"] : <!hw.struct<q: i32>>
    %u_data_ch1_1.qe, %u_data_ch1_1.q, %u_data_ch1_1.ds, %u_data_ch1_1.qs = hw.instance "u_data_ch1_1" @prim_subreg_1(clk_i: %3: i1, rst_ni: %4: i1, we: %67: i1, wd: %u_reg_if.wdata_o: i32, de: %false: i1, d: %c0_i32: i32) -> (qe: i1, q: i32, ds: i32, qs: i32)
    llhd.drv %69, %u_data_ch1_1.q after %1 : i32
    llhd.drv %data_ch1_1_qs, %u_data_ch1_1.qs after %1 : i32
    %70 = llhd.prb %size_we : i1
    %71 = llhd.sig.struct_extract %reg2hw["size"] : <!hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>>
    %72 = llhd.sig.struct_extract %71["len_ch0"] : <!hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>
    %73 = llhd.sig.struct_extract %72["q"] : <!hw.struct<q: i6>>
    %u_size_len_ch0.qe, %u_size_len_ch0.q, %u_size_len_ch0.ds, %u_size_len_ch0.qs = hw.instance "u_size_len_ch0" @prim_subreg_2(clk_i: %3: i1, rst_ni: %4: i1, we: %70: i1, wd: %132: i6, de: %false: i1, d: %c0_i6: i6) -> (qe: i1, q: i6, ds: i6, qs: i6)
    llhd.drv %73, %u_size_len_ch0.q after %1 : i6
    llhd.drv %size_len_ch0_qs, %u_size_len_ch0.qs after %1 : i6
    %74 = llhd.sig.struct_extract %71["reps_ch0"] : <!hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>
    %75 = llhd.sig.struct_extract %74["q"] : <!hw.struct<q: i10>>
    %u_size_reps_ch0.qe, %u_size_reps_ch0.q, %u_size_reps_ch0.ds, %u_size_reps_ch0.qs = hw.instance "u_size_reps_ch0" @prim_subreg_3(clk_i: %3: i1, rst_ni: %4: i1, we: %70: i1, wd: %133: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %75, %u_size_reps_ch0.q after %1 : i10
    llhd.drv %size_reps_ch0_qs, %u_size_reps_ch0.qs after %1 : i10
    %76 = llhd.sig.struct_extract %71["len_ch1"] : <!hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>
    %77 = llhd.sig.struct_extract %76["q"] : <!hw.struct<q: i6>>
    %u_size_len_ch1.qe, %u_size_len_ch1.q, %u_size_len_ch1.ds, %u_size_len_ch1.qs = hw.instance "u_size_len_ch1" @prim_subreg_2(clk_i: %3: i1, rst_ni: %4: i1, we: %70: i1, wd: %134: i6, de: %false: i1, d: %c0_i6: i6) -> (qe: i1, q: i6, ds: i6, qs: i6)
    llhd.drv %77, %u_size_len_ch1.q after %1 : i6
    llhd.drv %size_len_ch1_qs, %u_size_len_ch1.qs after %1 : i6
    %78 = llhd.sig.struct_extract %71["reps_ch1"] : <!hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>
    %79 = llhd.sig.struct_extract %78["q"] : <!hw.struct<q: i10>>
    %u_size_reps_ch1.qe, %u_size_reps_ch1.q, %u_size_reps_ch1.ds, %u_size_reps_ch1.qs = hw.instance "u_size_reps_ch1" @prim_subreg_3(clk_i: %3: i1, rst_ni: %4: i1, we: %70: i1, wd: %135: i10, de: %false: i1, d: %c0_i10: i10) -> (qe: i1, q: i10, ds: i10, qs: i10)
    llhd.drv %79, %u_size_reps_ch1.q after %1 : i10
    llhd.drv %size_reps_ch1_qs, %u_size_reps_ch1.qs after %1 : i10
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %159 = llhd.prb %clk_i_0 : i1
      %160 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %161 = llhd.prb %clk_i_0 : i1
      %162 = comb.xor bin %159, %true : i1
      %163 = comb.and bin %162, %161 : i1
      %164 = llhd.prb %rst_ni_1 : i1
      %165 = comb.xor bin %164, %true : i1
      %166 = comb.and bin %160, %165 : i1
      %167 = comb.or bin %163, %166 : i1
      cf.cond_br %167, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %168 = llhd.prb %rst_ni_1 : i1
      %169 = comb.xor %168, %true : i1
      cf.cond_br %169, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %err_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %170 = llhd.prb %intg_err : i1
      %171 = llhd.prb %reg_we_err : i1
      %172 = comb.or %170, %171 : i1
      cf.cond_br %172, ^bb6, ^bb1
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
    %86 = comb.or %97, %85, %81 {sv.namehint = "reg_error"} : i1
    %87 = llhd.prb %intr_test_flds_we : i2
    %88 = comb.icmp eq %87, %c-1_i2 {sv.namehint = "intr_test_qe"} : i2
    %89 = llhd.sig.struct_extract %24["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %89, %88 after %1 : i1
    %90 = llhd.sig.struct_extract %27["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %90, %88 after %1 : i1
    %91 = llhd.prb %alert_test_flds_we {sv.namehint = "alert_test_qe"} : i1
    %92 = llhd.sig.struct_extract %30["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %92, %91 after %1 : i1
    %93 = llhd.prb %addr_hit : i12
    %94 = llhd.prb %reg_addr : i6
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %159 = llhd.sig.extract %addr_hit from %c0_i4 : <i12> -> <i1>
      %160 = llhd.prb %reg_addr : i6
      %161 = comb.icmp eq %160, %c0_i6 : i6
      llhd.drv %159, %161 after %1 : i1
      %162 = llhd.sig.extract %addr_hit from %c1_i4 : <i12> -> <i1>
      %163 = llhd.prb %reg_addr : i6
      %164 = comb.icmp eq %163, %c4_i6 : i6
      llhd.drv %162, %164 after %1 : i1
      %165 = llhd.sig.extract %addr_hit from %c2_i4 : <i12> -> <i1>
      %166 = llhd.prb %reg_addr : i6
      %167 = comb.icmp eq %166, %c8_i6 : i6
      llhd.drv %165, %167 after %1 : i1
      %168 = llhd.sig.extract %addr_hit from %c3_i4 : <i12> -> <i1>
      %169 = llhd.prb %reg_addr : i6
      %170 = comb.icmp eq %169, %c12_i6 : i6
      llhd.drv %168, %170 after %1 : i1
      %171 = llhd.sig.extract %addr_hit from %c4_i4 : <i12> -> <i1>
      %172 = llhd.prb %reg_addr : i6
      %173 = comb.icmp eq %172, %c16_i6 : i6
      llhd.drv %171, %173 after %1 : i1
      %174 = llhd.sig.extract %addr_hit from %c5_i4 : <i12> -> <i1>
      %175 = llhd.prb %reg_addr : i6
      %176 = comb.icmp eq %175, %c20_i6 : i6
      llhd.drv %174, %176 after %1 : i1
      %177 = llhd.sig.extract %addr_hit from %c6_i4 : <i12> -> <i1>
      %178 = llhd.prb %reg_addr : i6
      %179 = comb.icmp eq %178, %c24_i6 : i6
      llhd.drv %177, %179 after %1 : i1
      %180 = llhd.sig.extract %addr_hit from %c7_i4 : <i12> -> <i1>
      %181 = llhd.prb %reg_addr : i6
      %182 = comb.icmp eq %181, %c28_i6 : i6
      llhd.drv %180, %182 after %1 : i1
      %183 = llhd.sig.extract %addr_hit from %c-8_i4 : <i12> -> <i1>
      %184 = llhd.prb %reg_addr : i6
      %185 = comb.icmp eq %184, %c-32_i6 : i6
      llhd.drv %183, %185 after %1 : i1
      %186 = llhd.sig.extract %addr_hit from %c-7_i4 : <i12> -> <i1>
      %187 = llhd.prb %reg_addr : i6
      %188 = comb.icmp eq %187, %c-28_i6 : i6
      llhd.drv %186, %188 after %1 : i1
      %189 = llhd.sig.extract %addr_hit from %c-6_i4 : <i12> -> <i1>
      %190 = llhd.prb %reg_addr : i6
      %191 = comb.icmp eq %190, %c-24_i6 : i6
      llhd.drv %189, %191 after %1 : i1
      %192 = llhd.sig.extract %addr_hit from %c-5_i4 : <i12> -> <i1>
      %193 = llhd.prb %reg_addr : i6
      %194 = comb.icmp eq %193, %c-20_i6 : i6
      llhd.drv %192, %194 after %1 : i1
      llhd.wait (%93, %94 : i12, i6), ^bb1
    }
    %95 = comb.or %u_reg_if.re_o, %6 : i1
    %96 = comb.icmp eq %93, %c0_i12 : i12
    %97 = comb.and %95, %96 {sv.namehint = "addrmiss"} : i1
    %98 = llhd.prb %reg_be : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %159 = llhd.prb %reg_we : i1
      %160 = llhd.prb %addr_hit : i12
      %161 = comb.extract %160 from 0 : (i12) -> i1
      %162 = llhd.prb %reg_be : i4
      %163 = comb.extract %162 from 0 : (i4) -> i1
      %164 = comb.xor %163, %true : i1
      %165 = comb.and %161, %164 : i1
      %166 = comb.extract %160 from 1 : (i12) -> i1
      %167 = comb.and %166, %164 : i1
      %168 = comb.extract %160 from 2 : (i12) -> i1
      %169 = comb.and %168, %164 : i1
      %170 = comb.extract %160 from 3 : (i12) -> i1
      %171 = comb.and %170, %164 : i1
      %172 = comb.extract %160 from 4 : (i12) -> i1
      %173 = comb.and %172, %164 : i1
      %174 = comb.extract %160 from 5 : (i12) -> i1
      %175 = comb.icmp ne %162, %c-1_i4 : i4
      %176 = comb.and %174, %175 : i1
      %177 = comb.extract %160 from 6 : (i12) -> i1
      %178 = comb.icmp ne %162, %c-1_i4 : i4
      %179 = comb.and %177, %178 : i1
      %180 = comb.extract %160 from 7 : (i12) -> i1
      %181 = comb.icmp ne %162, %c-1_i4 : i4
      %182 = comb.and %180, %181 : i1
      %183 = comb.extract %160 from 8 : (i12) -> i1
      %184 = comb.icmp ne %162, %c-1_i4 : i4
      %185 = comb.and %183, %184 : i1
      %186 = comb.extract %160 from 9 : (i12) -> i1
      %187 = comb.icmp ne %162, %c-1_i4 : i4
      %188 = comb.and %186, %187 : i1
      %189 = comb.extract %160 from 10 : (i12) -> i1
      %190 = comb.icmp ne %162, %c-1_i4 : i4
      %191 = comb.and %189, %190 : i1
      %192 = comb.extract %160 from 11 : (i12) -> i1
      %193 = comb.icmp ne %162, %c-1_i4 : i4
      %194 = comb.and %192, %193 : i1
      %195 = comb.or %165, %167, %169, %171, %173, %176, %179, %182, %185, %188, %191, %194 : i1
      %196 = comb.and %159, %195 : i1
      llhd.drv %wr_err, %196 after %1 : i1
      llhd.wait (%6, %93, %98, %85 : i1, i12, i4, i1), ^bb1
    }
    %99 = comb.extract %93 from 0 : (i12) -> i1
    %100 = comb.xor %86, %true : i1
    %101 = comb.and %99, %6, %100 : i1
    llhd.drv %intr_state_we, %101 after %1 : i1
    %102 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "alert_test_wd"} : (i32) -> i1
    %103 = comb.extract %u_reg_if.wdata_o from 1 {sv.namehint = "ctrl_enable_ch1_wd"} : (i32) -> i1
    %104 = comb.extract %93 from 1 : (i12) -> i1
    %105 = comb.and %104, %6, %100 : i1
    llhd.drv %intr_enable_we, %105 after %1 : i1
    %106 = comb.extract %93 from 2 : (i12) -> i1
    %107 = comb.and %106, %6, %100 : i1
    llhd.drv %intr_test_we, %107 after %1 : i1
    %108 = comb.extract %93 from 3 : (i12) -> i1
    %109 = comb.and %108, %6, %100 : i1
    llhd.drv %alert_test_we, %109 after %1 : i1
    %110 = comb.extract %93 from 4 : (i12) -> i1
    %111 = comb.and %110, %6, %100 : i1
    llhd.drv %ctrl_we, %111 after %1 : i1
    %112 = comb.extract %u_reg_if.wdata_o from 2 {sv.namehint = "ctrl_polarity_ch0_wd"} : (i32) -> i1
    %113 = comb.extract %u_reg_if.wdata_o from 3 {sv.namehint = "ctrl_polarity_ch1_wd"} : (i32) -> i1
    %114 = comb.extract %u_reg_if.wdata_o from 4 {sv.namehint = "ctrl_inactive_level_pcl_ch0_wd"} : (i32) -> i1
    %115 = comb.extract %u_reg_if.wdata_o from 5 {sv.namehint = "ctrl_inactive_level_pda_ch0_wd"} : (i32) -> i1
    %116 = comb.extract %u_reg_if.wdata_o from 6 {sv.namehint = "ctrl_inactive_level_pcl_ch1_wd"} : (i32) -> i1
    %117 = comb.extract %u_reg_if.wdata_o from 7 {sv.namehint = "ctrl_inactive_level_pda_ch1_wd"} : (i32) -> i1
    %118 = comb.extract %93 from 5 : (i12) -> i1
    %119 = comb.and %118, %6, %100 : i1
    llhd.drv %prediv_ch0_we, %119 after %1 : i1
    %120 = comb.extract %93 from 6 : (i12) -> i1
    %121 = comb.and %120, %6, %100 : i1
    llhd.drv %prediv_ch1_we, %121 after %1 : i1
    %122 = comb.extract %93 from 7 : (i12) -> i1
    %123 = comb.and %122, %6, %100 : i1
    llhd.drv %data_ch0_0_we, %123 after %1 : i1
    %124 = comb.extract %93 from 8 : (i12) -> i1
    %125 = comb.and %124, %6, %100 : i1
    llhd.drv %data_ch0_1_we, %125 after %1 : i1
    %126 = comb.extract %93 from 9 : (i12) -> i1
    %127 = comb.and %126, %6, %100 : i1
    llhd.drv %data_ch1_0_we, %127 after %1 : i1
    %128 = comb.extract %93 from 10 : (i12) -> i1
    %129 = comb.and %128, %6, %100 : i1
    llhd.drv %data_ch1_1_we, %129 after %1 : i1
    %130 = comb.extract %93 from 11 : (i12) -> i1
    %131 = comb.and %130, %6, %100 : i1
    llhd.drv %size_we, %131 after %1 : i1
    %132 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "size_len_ch0_wd"} : (i32) -> i6
    %133 = comb.extract %u_reg_if.wdata_o from 6 {sv.namehint = "size_reps_ch0_wd"} : (i32) -> i10
    %134 = comb.extract %u_reg_if.wdata_o from 16 {sv.namehint = "size_len_ch1_wd"} : (i32) -> i6
    %135 = comb.extract %u_reg_if.wdata_o from 22 {sv.namehint = "size_reps_ch1_wd"} : (i32) -> i10
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %159 = llhd.sig.extract %reg_we_check from %c0_i4 : <i12> -> <i1>
      %160 = llhd.prb %intr_state_we : i1
      llhd.drv %159, %160 after %1 : i1
      %161 = llhd.sig.extract %reg_we_check from %c1_i4 : <i12> -> <i1>
      %162 = llhd.prb %intr_enable_we : i1
      llhd.drv %161, %162 after %1 : i1
      %163 = llhd.sig.extract %reg_we_check from %c2_i4 : <i12> -> <i1>
      %164 = llhd.prb %intr_test_we : i1
      llhd.drv %163, %164 after %1 : i1
      %165 = llhd.sig.extract %reg_we_check from %c3_i4 : <i12> -> <i1>
      %166 = llhd.prb %alert_test_we : i1
      llhd.drv %165, %166 after %1 : i1
      %167 = llhd.sig.extract %reg_we_check from %c4_i4 : <i12> -> <i1>
      %168 = llhd.prb %ctrl_we : i1
      llhd.drv %167, %168 after %1 : i1
      %169 = llhd.sig.extract %reg_we_check from %c5_i4 : <i12> -> <i1>
      %170 = llhd.prb %prediv_ch0_we : i1
      llhd.drv %169, %170 after %1 : i1
      %171 = llhd.sig.extract %reg_we_check from %c6_i4 : <i12> -> <i1>
      %172 = llhd.prb %prediv_ch1_we : i1
      llhd.drv %171, %172 after %1 : i1
      %173 = llhd.sig.extract %reg_we_check from %c7_i4 : <i12> -> <i1>
      %174 = llhd.prb %data_ch0_0_we : i1
      llhd.drv %173, %174 after %1 : i1
      %175 = llhd.sig.extract %reg_we_check from %c-8_i4 : <i12> -> <i1>
      %176 = llhd.prb %data_ch0_1_we : i1
      llhd.drv %175, %176 after %1 : i1
      %177 = llhd.sig.extract %reg_we_check from %c-7_i4 : <i12> -> <i1>
      %178 = llhd.prb %data_ch1_0_we : i1
      llhd.drv %177, %178 after %1 : i1
      %179 = llhd.sig.extract %reg_we_check from %c-6_i4 : <i12> -> <i1>
      %180 = llhd.prb %data_ch1_1_we : i1
      llhd.drv %179, %180 after %1 : i1
      %181 = llhd.sig.extract %reg_we_check from %c-5_i4 : <i12> -> <i1>
      %182 = llhd.prb %size_we : i1
      llhd.drv %181, %182 after %1 : i1
      llhd.wait (%5, %9, %15, %21, %29, %32, %50, %53, %56, %60, %63, %67, %70 : i12, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    %136 = llhd.prb %intr_state_done_ch0_qs : i1
    %137 = llhd.prb %intr_state_done_ch1_qs : i1
    %138 = llhd.prb %intr_enable_done_ch0_qs : i1
    %139 = llhd.prb %intr_enable_done_ch1_qs : i1
    %140 = llhd.prb %ctrl_enable_ch0_qs : i1
    %141 = llhd.prb %ctrl_enable_ch1_qs : i1
    %142 = llhd.prb %ctrl_polarity_ch0_qs : i1
    %143 = llhd.prb %ctrl_polarity_ch1_qs : i1
    %144 = llhd.prb %ctrl_inactive_level_pcl_ch0_qs : i1
    %145 = llhd.prb %ctrl_inactive_level_pda_ch0_qs : i1
    %146 = llhd.prb %ctrl_inactive_level_pcl_ch1_qs : i1
    %147 = llhd.prb %ctrl_inactive_level_pda_ch1_qs : i1
    %148 = llhd.prb %prediv_ch0_qs : i32
    %149 = llhd.prb %prediv_ch1_qs : i32
    %150 = llhd.prb %data_ch0_0_qs : i32
    %151 = llhd.prb %data_ch0_1_qs : i32
    %152 = llhd.prb %data_ch1_0_qs : i32
    %153 = llhd.prb %data_ch1_1_qs : i32
    %154 = llhd.prb %size_len_ch0_qs : i6
    %155 = llhd.prb %size_reps_ch0_qs : i10
    %156 = llhd.prb %size_len_ch1_qs : i6
    %157 = llhd.prb %size_reps_ch1_qs : i10
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb26
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      %159 = llhd.prb %addr_hit : i12
      %160 = comb.extract %159 from 0 : (i12) -> i1
      %161 = comb.icmp ceq %160, %true : i1
      cf.cond_br %161, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %162 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %163 = llhd.prb %intr_state_done_ch0_qs : i1
      llhd.drv %162, %163 after %1 : i1
      %164 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %165 = llhd.prb %intr_state_done_ch1_qs : i1
      llhd.drv %164, %165 after %1 : i1
      cf.br ^bb26
    ^bb3:  // pred: ^bb1
      %166 = llhd.prb %addr_hit : i12
      %167 = comb.extract %166 from 1 : (i12) -> i1
      %168 = comb.icmp ceq %167, %true : i1
      cf.cond_br %168, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %169 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %170 = llhd.prb %intr_enable_done_ch0_qs : i1
      llhd.drv %169, %170 after %1 : i1
      %171 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %172 = llhd.prb %intr_enable_done_ch1_qs : i1
      llhd.drv %171, %172 after %1 : i1
      cf.br ^bb26
    ^bb5:  // pred: ^bb3
      %173 = llhd.prb %addr_hit : i12
      %174 = comb.extract %173 from 2 : (i12) -> i1
      %175 = comb.icmp ceq %174, %true : i1
      cf.cond_br %175, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %176 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      llhd.drv %176, %false after %1 : i1
      %177 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      llhd.drv %177, %false after %1 : i1
      cf.br ^bb26
    ^bb7:  // pred: ^bb5
      %178 = llhd.prb %addr_hit : i12
      %179 = comb.extract %178 from 3 : (i12) -> i1
      %180 = comb.icmp ceq %179, %true : i1
      cf.cond_br %180, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %181 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      llhd.drv %181, %false after %1 : i1
      cf.br ^bb26
    ^bb9:  // pred: ^bb7
      %182 = llhd.prb %addr_hit : i12
      %183 = comb.extract %182 from 4 : (i12) -> i1
      %184 = comb.icmp ceq %183, %true : i1
      cf.cond_br %184, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %185 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %186 = llhd.prb %ctrl_enable_ch0_qs : i1
      llhd.drv %185, %186 after %1 : i1
      %187 = llhd.sig.extract %reg_rdata_next from %c1_i5 : <i32> -> <i1>
      %188 = llhd.prb %ctrl_enable_ch1_qs : i1
      llhd.drv %187, %188 after %1 : i1
      %189 = llhd.sig.extract %reg_rdata_next from %c2_i5 : <i32> -> <i1>
      %190 = llhd.prb %ctrl_polarity_ch0_qs : i1
      llhd.drv %189, %190 after %1 : i1
      %191 = llhd.sig.extract %reg_rdata_next from %c3_i5 : <i32> -> <i1>
      %192 = llhd.prb %ctrl_polarity_ch1_qs : i1
      llhd.drv %191, %192 after %1 : i1
      %193 = llhd.sig.extract %reg_rdata_next from %c4_i5 : <i32> -> <i1>
      %194 = llhd.prb %ctrl_inactive_level_pcl_ch0_qs : i1
      llhd.drv %193, %194 after %1 : i1
      %195 = llhd.sig.extract %reg_rdata_next from %c5_i5 : <i32> -> <i1>
      %196 = llhd.prb %ctrl_inactive_level_pda_ch0_qs : i1
      llhd.drv %195, %196 after %1 : i1
      %197 = llhd.sig.extract %reg_rdata_next from %c6_i5 : <i32> -> <i1>
      %198 = llhd.prb %ctrl_inactive_level_pcl_ch1_qs : i1
      llhd.drv %197, %198 after %1 : i1
      %199 = llhd.sig.extract %reg_rdata_next from %c7_i5 : <i32> -> <i1>
      %200 = llhd.prb %ctrl_inactive_level_pda_ch1_qs : i1
      llhd.drv %199, %200 after %1 : i1
      cf.br ^bb26
    ^bb11:  // pred: ^bb9
      %201 = llhd.prb %addr_hit : i12
      %202 = comb.extract %201 from 5 : (i12) -> i1
      %203 = comb.icmp ceq %202, %true : i1
      cf.cond_br %203, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %204 = llhd.prb %prediv_ch0_qs : i32
      llhd.drv %reg_rdata_next, %204 after %1 : i32
      cf.br ^bb26
    ^bb13:  // pred: ^bb11
      %205 = llhd.prb %addr_hit : i12
      %206 = comb.extract %205 from 6 : (i12) -> i1
      %207 = comb.icmp ceq %206, %true : i1
      cf.cond_br %207, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %208 = llhd.prb %prediv_ch1_qs : i32
      llhd.drv %reg_rdata_next, %208 after %1 : i32
      cf.br ^bb26
    ^bb15:  // pred: ^bb13
      %209 = llhd.prb %addr_hit : i12
      %210 = comb.extract %209 from 7 : (i12) -> i1
      %211 = comb.icmp ceq %210, %true : i1
      cf.cond_br %211, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      %212 = llhd.prb %data_ch0_0_qs : i32
      llhd.drv %reg_rdata_next, %212 after %1 : i32
      cf.br ^bb26
    ^bb17:  // pred: ^bb15
      %213 = llhd.prb %addr_hit : i12
      %214 = comb.extract %213 from 8 : (i12) -> i1
      %215 = comb.icmp ceq %214, %true : i1
      cf.cond_br %215, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      %216 = llhd.prb %data_ch0_1_qs : i32
      llhd.drv %reg_rdata_next, %216 after %1 : i32
      cf.br ^bb26
    ^bb19:  // pred: ^bb17
      %217 = llhd.prb %addr_hit : i12
      %218 = comb.extract %217 from 9 : (i12) -> i1
      %219 = comb.icmp ceq %218, %true : i1
      cf.cond_br %219, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      %220 = llhd.prb %data_ch1_0_qs : i32
      llhd.drv %reg_rdata_next, %220 after %1 : i32
      cf.br ^bb26
    ^bb21:  // pred: ^bb19
      %221 = llhd.prb %addr_hit : i12
      %222 = comb.extract %221 from 10 : (i12) -> i1
      %223 = comb.icmp ceq %222, %true : i1
      cf.cond_br %223, ^bb22, ^bb23
    ^bb22:  // pred: ^bb21
      %224 = llhd.prb %data_ch1_1_qs : i32
      llhd.drv %reg_rdata_next, %224 after %1 : i32
      cf.br ^bb26
    ^bb23:  // pred: ^bb21
      %225 = llhd.prb %addr_hit : i12
      %226 = comb.extract %225 from 11 : (i12) -> i1
      %227 = comb.icmp ceq %226, %true : i1
      cf.cond_br %227, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      %228 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i6>
      %229 = llhd.prb %size_len_ch0_qs : i6
      llhd.drv %228, %229 after %1 : i6
      %230 = llhd.sig.extract %reg_rdata_next from %c6_i5 : <i32> -> <i10>
      %231 = llhd.prb %size_reps_ch0_qs : i10
      llhd.drv %230, %231 after %1 : i10
      %232 = llhd.sig.extract %reg_rdata_next from %c-16_i5 : <i32> -> <i6>
      %233 = llhd.prb %size_len_ch1_qs : i6
      llhd.drv %232, %233 after %1 : i6
      %234 = llhd.sig.extract %reg_rdata_next from %c-10_i5 : <i32> -> <i10>
      %235 = llhd.prb %size_reps_ch1_qs : i10
      llhd.drv %234, %235 after %1 : i10
      cf.br ^bb26
    ^bb25:  // pred: ^bb23
      llhd.drv %reg_rdata_next, %c-1_i32 after %1 : i32
      cf.br ^bb26
    ^bb26:  // 13 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb18, ^bb20, ^bb22, ^bb24, ^bb25
      llhd.wait (%84, %93, %136, %137, %138, %139, %140, %141, %142, %143, %144, %145, %146, %147, %148, %149, %150, %151, %152, %153, %154, %155, %156, %157 : i32, i12, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i32, i32, i32, i32, i32, i32, i6, i10, i6, i10), ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    %158 = llhd.prb %reg2hw : !hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>
    hw.output %u_rsp_intg_gen.tl_o, %158, %83 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>, i1
  }
  hw.module @pattgen(in %clk_i : i1, in %rst_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %alert_rx_i : !hw.array<1xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, out alert_tx_o : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>, out cio_pda0_tx_o : i1, out cio_pcl0_tx_o : i1, out cio_pda1_tx_o : i1, out cio_pcl1_tx_o : i1, out cio_pda0_tx_en_o : i1, out cio_pcl0_tx_en_o : i1, out cio_pda1_tx_en_o : i1, out cio_pcl1_tx_en_o : i1, out intr_done_ch0_o : i1, out intr_done_ch1_o : i1) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i0 = hw.constant 0 : i0
    %false = hw.constant false
    %true = hw.constant true
    %1 = hw.aggregate_constant [[false, false]] : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    %alert_tx_o = llhd.sig %1 : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    %alerts = llhd.sig %false : i1
    %u_reg.tl_o, %u_reg.reg2hw, %u_reg.intg_err_o = hw.instance "u_reg" @pattgen_reg_top(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, hw2reg: %u_pattgen_core.hw2reg: !hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<d: i1, de: i1>, done_ch0: !hw.struct<d: i1, de: i1>>>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, reg2hw: !hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>, intg_err_o: i1) {sv.namehint = "reg2hw"}
    llhd.drv %alerts, %u_reg.intg_err_o after %0 : i1
    %2 = llhd.prb %alerts : i1
    %3 = hw.array_get %alert_rx_i[%c0_i0] : !hw.array<1xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, i0
    %4 = llhd.sig.array_get %alert_tx_o[%c0_i0] : <!hw.array<1xstruct<alert_p: i1, alert_n: i1>>>
    %gen_alert_tx_0.u_prim_alert_sender.alert_ack_o, %gen_alert_tx_0.u_prim_alert_sender.alert_state_o, %gen_alert_tx_0.u_prim_alert_sender.alert_tx_o = hw.instance "gen_alert_tx_0.u_prim_alert_sender" @prim_alert_sender(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, alert_test_i: %5: i1, alert_req_i: %2: i1, alert_rx_i: %3: !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>) -> (alert_ack_o: i1, alert_state_o: i1, alert_tx_o: !hw.struct<alert_p: i1, alert_n: i1>)
    llhd.drv %4, %gen_alert_tx_0.u_prim_alert_sender.alert_tx_o after %0 : !hw.struct<alert_p: i1, alert_n: i1>
    %u_pattgen_core.hw2reg, %u_pattgen_core.pda0_tx_o, %u_pattgen_core.pcl0_tx_o, %u_pattgen_core.pda1_tx_o, %u_pattgen_core.pcl1_tx_o, %u_pattgen_core.intr_done_ch0_o, %u_pattgen_core.intr_done_ch1_o = hw.instance "u_pattgen_core" @pattgen_core(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, reg2hw: %u_reg.reg2hw: !hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>) -> (hw2reg: !hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<d: i1, de: i1>, done_ch0: !hw.struct<d: i1, de: i1>>>, pda0_tx_o: i1, pcl0_tx_o: i1, pda1_tx_o: i1, pcl1_tx_o: i1, intr_done_ch0_o: i1, intr_done_ch1_o: i1) {sv.namehint = "hw2reg"}
    %alert_test = hw.struct_extract %u_reg.reg2hw["alert_test"] : !hw.struct<intr_state: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_enable: !hw.struct<done_ch1: !hw.struct<q: i1>, done_ch0: !hw.struct<q: i1>>, intr_test: !hw.struct<done_ch1: !hw.struct<q: i1, qe: i1>, done_ch0: !hw.struct<q: i1, qe: i1>>, alert_test: !hw.struct<q: i1, qe: i1>, ctrl: !hw.struct<inactive_level_pda_ch1: !hw.struct<q: i1>, inactive_level_pcl_ch1: !hw.struct<q: i1>, inactive_level_pda_ch0: !hw.struct<q: i1>, inactive_level_pcl_ch0: !hw.struct<q: i1>, polarity_ch1: !hw.struct<q: i1>, polarity_ch0: !hw.struct<q: i1>, enable_ch1: !hw.struct<q: i1>, enable_ch0: !hw.struct<q: i1>>, prediv_ch0: !hw.struct<q: i32>, prediv_ch1: !hw.struct<q: i32>, data_ch0: !hw.array<2xstruct<q: i32>>, data_ch1: !hw.array<2xstruct<q: i32>>, size: !hw.struct<reps_ch1: !hw.struct<q: i10>, len_ch1: !hw.struct<q: i6>, reps_ch0: !hw.struct<q: i10>, len_ch0: !hw.struct<q: i6>>>
    %q = hw.struct_extract %alert_test["q"] : !hw.struct<q: i1, qe: i1>
    %qe = hw.struct_extract %alert_test["qe"] : !hw.struct<q: i1, qe: i1>
    %5 = comb.and %q, %qe : i1
    %6 = llhd.prb %alert_tx_o : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    hw.output %u_reg.tl_o, %6, %u_pattgen_core.pda0_tx_o, %u_pattgen_core.pcl0_tx_o, %u_pattgen_core.pda1_tx_o, %u_pattgen_core.pcl1_tx_o, %true, %true, %true, %true, %u_pattgen_core.intr_done_ch0_o, %u_pattgen_core.intr_done_ch1_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.array<1xstruct<alert_p: i1, alert_n: i1>>, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1
  }
}
