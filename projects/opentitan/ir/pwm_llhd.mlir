module {
  hw.module private @prim_buf(in %in_i : i23, out out_o : i23) {
    hw.output %in_i : i23
  }
  hw.module private @prim_buf_18(in %in_i : i2, out out_o : i2) {
    hw.output %in_i : i2
  }
  hw.module private @prim_buf_20(in %in_i : i1, out out_o : i1) {
    hw.output %in_i : i1
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
    %u_sync_1.q_o = hw.instance "u_sync_1" @prim_flop_22(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %1: i1) -> (q_o: i1) {sv.namehint = "intq"}
    %u_sync_2.q_o = hw.instance "u_sync_2" @prim_flop_22(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %u_sync_1.q_o: i1) -> (q_o: i1)
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
  hw.module private @prim_flop_21(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_o : i2) {
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
  hw.module private @prim_flop_22(in %clk_i : i1, in %rst_ni : i1, in %d_i : i1, out q_o : i1) {
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
    %u_prim_buf_in_req.out_o = hw.instance "u_prim_buf_in_req" @prim_sec_anchor_buf_9(in_i: %alert_req_i: i1) -> (out_o: i1) {sv.namehint = "alert_req"}
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
  hw.module private @prim_onehot_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i23, in %addr_i : i5, in %en_i : i1, out err_o : i1) {
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
    %480 = comb.extract %oh_i from 0 : (i23) -> i1
    llhd.drv %479, %480 after %0 : i1
    %481 = llhd.sig.extract %and_tree from %c31_i6 : <i63> -> <i1>
    llhd.drv %481, %480 after %0 : i1
    %482 = llhd.sig.extract %err_tree from %c31_i6 : <i63> -> <i1>
    llhd.drv %482, %false after %0 : i1
    %483 = llhd.sig.extract %or_tree from %c-32_i6 : <i63> -> <i1>
    %484 = comb.extract %oh_i from 1 : (i23) -> i1
    llhd.drv %483, %484 after %0 : i1
    %485 = llhd.sig.extract %and_tree from %c-32_i6 : <i63> -> <i1>
    llhd.drv %485, %484 after %0 : i1
    %486 = llhd.sig.extract %err_tree from %c-32_i6 : <i63> -> <i1>
    llhd.drv %486, %false after %0 : i1
    %487 = llhd.sig.extract %or_tree from %c-31_i6 : <i63> -> <i1>
    %488 = comb.extract %oh_i from 2 : (i23) -> i1
    llhd.drv %487, %488 after %0 : i1
    %489 = llhd.sig.extract %and_tree from %c-31_i6 : <i63> -> <i1>
    llhd.drv %489, %488 after %0 : i1
    %490 = llhd.sig.extract %err_tree from %c-31_i6 : <i63> -> <i1>
    llhd.drv %490, %false after %0 : i1
    %491 = llhd.sig.extract %or_tree from %c-30_i6 : <i63> -> <i1>
    %492 = comb.extract %oh_i from 3 : (i23) -> i1
    llhd.drv %491, %492 after %0 : i1
    %493 = llhd.sig.extract %and_tree from %c-30_i6 : <i63> -> <i1>
    llhd.drv %493, %492 after %0 : i1
    %494 = llhd.sig.extract %err_tree from %c-30_i6 : <i63> -> <i1>
    llhd.drv %494, %false after %0 : i1
    %495 = llhd.sig.extract %or_tree from %c-29_i6 : <i63> -> <i1>
    %496 = comb.extract %oh_i from 4 : (i23) -> i1
    llhd.drv %495, %496 after %0 : i1
    %497 = llhd.sig.extract %and_tree from %c-29_i6 : <i63> -> <i1>
    llhd.drv %497, %496 after %0 : i1
    %498 = llhd.sig.extract %err_tree from %c-29_i6 : <i63> -> <i1>
    llhd.drv %498, %false after %0 : i1
    %499 = llhd.sig.extract %or_tree from %c-28_i6 : <i63> -> <i1>
    %500 = comb.extract %oh_i from 5 : (i23) -> i1
    llhd.drv %499, %500 after %0 : i1
    %501 = llhd.sig.extract %and_tree from %c-28_i6 : <i63> -> <i1>
    llhd.drv %501, %500 after %0 : i1
    %502 = llhd.sig.extract %err_tree from %c-28_i6 : <i63> -> <i1>
    llhd.drv %502, %false after %0 : i1
    %503 = llhd.sig.extract %or_tree from %c-27_i6 : <i63> -> <i1>
    %504 = comb.extract %oh_i from 6 : (i23) -> i1
    llhd.drv %503, %504 after %0 : i1
    %505 = llhd.sig.extract %and_tree from %c-27_i6 : <i63> -> <i1>
    llhd.drv %505, %504 after %0 : i1
    %506 = llhd.sig.extract %err_tree from %c-27_i6 : <i63> -> <i1>
    llhd.drv %506, %false after %0 : i1
    %507 = llhd.sig.extract %or_tree from %c-26_i6 : <i63> -> <i1>
    %508 = comb.extract %oh_i from 7 : (i23) -> i1
    llhd.drv %507, %508 after %0 : i1
    %509 = llhd.sig.extract %and_tree from %c-26_i6 : <i63> -> <i1>
    llhd.drv %509, %508 after %0 : i1
    %510 = llhd.sig.extract %err_tree from %c-26_i6 : <i63> -> <i1>
    llhd.drv %510, %false after %0 : i1
    %511 = llhd.sig.extract %or_tree from %c-25_i6 : <i63> -> <i1>
    %512 = comb.extract %oh_i from 8 : (i23) -> i1
    llhd.drv %511, %512 after %0 : i1
    %513 = llhd.sig.extract %and_tree from %c-25_i6 : <i63> -> <i1>
    llhd.drv %513, %512 after %0 : i1
    %514 = llhd.sig.extract %err_tree from %c-25_i6 : <i63> -> <i1>
    llhd.drv %514, %false after %0 : i1
    %515 = llhd.sig.extract %or_tree from %c-24_i6 : <i63> -> <i1>
    %516 = comb.extract %oh_i from 9 : (i23) -> i1
    llhd.drv %515, %516 after %0 : i1
    %517 = llhd.sig.extract %and_tree from %c-24_i6 : <i63> -> <i1>
    llhd.drv %517, %516 after %0 : i1
    %518 = llhd.sig.extract %err_tree from %c-24_i6 : <i63> -> <i1>
    llhd.drv %518, %false after %0 : i1
    %519 = llhd.sig.extract %or_tree from %c-23_i6 : <i63> -> <i1>
    %520 = comb.extract %oh_i from 10 : (i23) -> i1
    llhd.drv %519, %520 after %0 : i1
    %521 = llhd.sig.extract %and_tree from %c-23_i6 : <i63> -> <i1>
    llhd.drv %521, %520 after %0 : i1
    %522 = llhd.sig.extract %err_tree from %c-23_i6 : <i63> -> <i1>
    llhd.drv %522, %false after %0 : i1
    %523 = llhd.sig.extract %or_tree from %c-22_i6 : <i63> -> <i1>
    %524 = comb.extract %oh_i from 11 : (i23) -> i1
    llhd.drv %523, %524 after %0 : i1
    %525 = llhd.sig.extract %and_tree from %c-22_i6 : <i63> -> <i1>
    llhd.drv %525, %524 after %0 : i1
    %526 = llhd.sig.extract %err_tree from %c-22_i6 : <i63> -> <i1>
    llhd.drv %526, %false after %0 : i1
    %527 = llhd.sig.extract %or_tree from %c-21_i6 : <i63> -> <i1>
    %528 = comb.extract %oh_i from 12 : (i23) -> i1
    llhd.drv %527, %528 after %0 : i1
    %529 = llhd.sig.extract %and_tree from %c-21_i6 : <i63> -> <i1>
    llhd.drv %529, %528 after %0 : i1
    %530 = llhd.sig.extract %err_tree from %c-21_i6 : <i63> -> <i1>
    llhd.drv %530, %false after %0 : i1
    %531 = llhd.sig.extract %or_tree from %c-20_i6 : <i63> -> <i1>
    %532 = comb.extract %oh_i from 13 : (i23) -> i1
    llhd.drv %531, %532 after %0 : i1
    %533 = llhd.sig.extract %and_tree from %c-20_i6 : <i63> -> <i1>
    llhd.drv %533, %532 after %0 : i1
    %534 = llhd.sig.extract %err_tree from %c-20_i6 : <i63> -> <i1>
    llhd.drv %534, %false after %0 : i1
    %535 = llhd.sig.extract %or_tree from %c-19_i6 : <i63> -> <i1>
    %536 = comb.extract %oh_i from 14 : (i23) -> i1
    llhd.drv %535, %536 after %0 : i1
    %537 = llhd.sig.extract %and_tree from %c-19_i6 : <i63> -> <i1>
    llhd.drv %537, %536 after %0 : i1
    %538 = llhd.sig.extract %err_tree from %c-19_i6 : <i63> -> <i1>
    llhd.drv %538, %false after %0 : i1
    %539 = llhd.sig.extract %or_tree from %c-18_i6 : <i63> -> <i1>
    %540 = comb.extract %oh_i from 15 : (i23) -> i1
    llhd.drv %539, %540 after %0 : i1
    %541 = llhd.sig.extract %and_tree from %c-18_i6 : <i63> -> <i1>
    llhd.drv %541, %540 after %0 : i1
    %542 = llhd.sig.extract %err_tree from %c-18_i6 : <i63> -> <i1>
    llhd.drv %542, %false after %0 : i1
    %543 = llhd.sig.extract %or_tree from %c-17_i6 : <i63> -> <i1>
    %544 = comb.extract %oh_i from 16 : (i23) -> i1
    llhd.drv %543, %544 after %0 : i1
    %545 = llhd.sig.extract %and_tree from %c-17_i6 : <i63> -> <i1>
    llhd.drv %545, %544 after %0 : i1
    %546 = llhd.sig.extract %err_tree from %c-17_i6 : <i63> -> <i1>
    llhd.drv %546, %false after %0 : i1
    %547 = llhd.sig.extract %or_tree from %c-16_i6 : <i63> -> <i1>
    %548 = comb.extract %oh_i from 17 : (i23) -> i1
    llhd.drv %547, %548 after %0 : i1
    %549 = llhd.sig.extract %and_tree from %c-16_i6 : <i63> -> <i1>
    llhd.drv %549, %548 after %0 : i1
    %550 = llhd.sig.extract %err_tree from %c-16_i6 : <i63> -> <i1>
    llhd.drv %550, %false after %0 : i1
    %551 = llhd.sig.extract %or_tree from %c-15_i6 : <i63> -> <i1>
    %552 = comb.extract %oh_i from 18 : (i23) -> i1
    llhd.drv %551, %552 after %0 : i1
    %553 = llhd.sig.extract %and_tree from %c-15_i6 : <i63> -> <i1>
    llhd.drv %553, %552 after %0 : i1
    %554 = llhd.sig.extract %err_tree from %c-15_i6 : <i63> -> <i1>
    llhd.drv %554, %false after %0 : i1
    %555 = llhd.sig.extract %or_tree from %c-14_i6 : <i63> -> <i1>
    %556 = comb.extract %oh_i from 19 : (i23) -> i1
    llhd.drv %555, %556 after %0 : i1
    %557 = llhd.sig.extract %and_tree from %c-14_i6 : <i63> -> <i1>
    llhd.drv %557, %556 after %0 : i1
    %558 = llhd.sig.extract %err_tree from %c-14_i6 : <i63> -> <i1>
    llhd.drv %558, %false after %0 : i1
    %559 = llhd.sig.extract %or_tree from %c-13_i6 : <i63> -> <i1>
    %560 = comb.extract %oh_i from 20 : (i23) -> i1
    llhd.drv %559, %560 after %0 : i1
    %561 = llhd.sig.extract %and_tree from %c-13_i6 : <i63> -> <i1>
    llhd.drv %561, %560 after %0 : i1
    %562 = llhd.sig.extract %err_tree from %c-13_i6 : <i63> -> <i1>
    llhd.drv %562, %false after %0 : i1
    %563 = llhd.sig.extract %or_tree from %c-12_i6 : <i63> -> <i1>
    %564 = comb.extract %oh_i from 21 : (i23) -> i1
    llhd.drv %563, %564 after %0 : i1
    %565 = llhd.sig.extract %and_tree from %c-12_i6 : <i63> -> <i1>
    llhd.drv %565, %564 after %0 : i1
    %566 = llhd.sig.extract %err_tree from %c-12_i6 : <i63> -> <i1>
    llhd.drv %566, %false after %0 : i1
    %567 = llhd.sig.extract %or_tree from %c-11_i6 : <i63> -> <i1>
    %568 = comb.extract %oh_i from 22 : (i23) -> i1
    llhd.drv %567, %568 after %0 : i1
    %569 = llhd.sig.extract %and_tree from %c-11_i6 : <i63> -> <i1>
    llhd.drv %569, %568 after %0 : i1
    %570 = llhd.sig.extract %err_tree from %c-11_i6 : <i63> -> <i1>
    llhd.drv %570, %false after %0 : i1
    %571 = llhd.sig.extract %or_tree from %c-10_i6 : <i63> -> <i1>
    llhd.drv %571, %false after %0 : i1
    %572 = llhd.sig.extract %and_tree from %c-10_i6 : <i63> -> <i1>
    llhd.drv %572, %false after %0 : i1
    %573 = llhd.sig.extract %err_tree from %c-10_i6 : <i63> -> <i1>
    llhd.drv %573, %false after %0 : i1
    %574 = llhd.sig.extract %or_tree from %c-9_i6 : <i63> -> <i1>
    llhd.drv %574, %false after %0 : i1
    %575 = llhd.sig.extract %and_tree from %c-9_i6 : <i63> -> <i1>
    llhd.drv %575, %false after %0 : i1
    %576 = llhd.sig.extract %err_tree from %c-9_i6 : <i63> -> <i1>
    llhd.drv %576, %false after %0 : i1
    %577 = llhd.sig.extract %or_tree from %c-8_i6 : <i63> -> <i1>
    llhd.drv %577, %false after %0 : i1
    %578 = llhd.sig.extract %and_tree from %c-8_i6 : <i63> -> <i1>
    llhd.drv %578, %false after %0 : i1
    %579 = llhd.sig.extract %err_tree from %c-8_i6 : <i63> -> <i1>
    llhd.drv %579, %false after %0 : i1
    %580 = llhd.sig.extract %or_tree from %c-7_i6 : <i63> -> <i1>
    llhd.drv %580, %false after %0 : i1
    %581 = llhd.sig.extract %and_tree from %c-7_i6 : <i63> -> <i1>
    llhd.drv %581, %false after %0 : i1
    %582 = llhd.sig.extract %err_tree from %c-7_i6 : <i63> -> <i1>
    llhd.drv %582, %false after %0 : i1
    %583 = llhd.sig.extract %or_tree from %c-6_i6 : <i63> -> <i1>
    llhd.drv %583, %false after %0 : i1
    %584 = llhd.sig.extract %and_tree from %c-6_i6 : <i63> -> <i1>
    llhd.drv %584, %false after %0 : i1
    %585 = llhd.sig.extract %err_tree from %c-6_i6 : <i63> -> <i1>
    llhd.drv %585, %false after %0 : i1
    %586 = llhd.sig.extract %or_tree from %c-5_i6 : <i63> -> <i1>
    llhd.drv %586, %false after %0 : i1
    %587 = llhd.sig.extract %and_tree from %c-5_i6 : <i63> -> <i1>
    llhd.drv %587, %false after %0 : i1
    %588 = llhd.sig.extract %err_tree from %c-5_i6 : <i63> -> <i1>
    llhd.drv %588, %false after %0 : i1
    %589 = llhd.sig.extract %or_tree from %c-4_i6 : <i63> -> <i1>
    llhd.drv %589, %false after %0 : i1
    %590 = llhd.sig.extract %and_tree from %c-4_i6 : <i63> -> <i1>
    llhd.drv %590, %false after %0 : i1
    %591 = llhd.sig.extract %err_tree from %c-4_i6 : <i63> -> <i1>
    llhd.drv %591, %false after %0 : i1
    %592 = llhd.sig.extract %or_tree from %c-3_i6 : <i63> -> <i1>
    llhd.drv %592, %false after %0 : i1
    %593 = llhd.sig.extract %and_tree from %c-3_i6 : <i63> -> <i1>
    llhd.drv %593, %false after %0 : i1
    %594 = llhd.sig.extract %err_tree from %c-3_i6 : <i63> -> <i1>
    llhd.drv %594, %false after %0 : i1
    %595 = llhd.sig.extract %or_tree from %c-2_i6 : <i63> -> <i1>
    llhd.drv %595, %false after %0 : i1
    %596 = llhd.sig.extract %and_tree from %c-2_i6 : <i63> -> <i1>
    llhd.drv %596, %false after %0 : i1
    %597 = llhd.sig.extract %err_tree from %c-2_i6 : <i63> -> <i1>
    llhd.drv %597, %false after %0 : i1
    %598 = comb.or %599, %602 : i1
    %599 = comb.extract %17 from 0 {sv.namehint = "oh0_err"} : (i63) -> i1
    %600 = comb.xor %en_i, %true : i1
    %601 = comb.extract %2 from 0 : (i63) -> i1
    %602 = comb.and %600, %601 {sv.namehint = "enable_err"} : i1
    hw.output %598 : i1
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
  hw.module private @prim_reg_cdc_arb(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, out src_ack_o : i1, out src_update_o : i1, in %dst_req_i : i1, out dst_req_o : i1, in %dst_update_i : i1, in %dst_ds_i : i32, in %dst_qs_i : i32, out dst_qs_o : i32) {
    %false = hw.constant false
    %gen_passthru.u_dst_to_src_ack.dst_pulse_o = hw.instance "gen_passthru.u_dst_to_src_ack" @prim_pulse_sync(clk_src_i: %clk_dst_i: i1, rst_src_ni: %rst_dst_ni: i1, src_pulse_i: %dst_req_i: i1, clk_dst_i: %clk_src_i: i1, rst_dst_ni: %rst_src_ni: i1) -> (dst_pulse_o: i1)
    hw.output %gen_passthru.u_dst_to_src_ack.dst_pulse_o, %false, %dst_req_i, %dst_qs_i : i1, i1, i1, i32
  }
  hw.module private @prim_reg_cdc_arb_11(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, out src_ack_o : i1, out src_update_o : i1, in %dst_req_i : i1, out dst_req_o : i1, in %dst_update_i : i1, in %dst_ds_i : i6, in %dst_qs_i : i6, out dst_qs_o : i6) {
    %false = hw.constant false
    %gen_passthru.u_dst_to_src_ack.dst_pulse_o = hw.instance "gen_passthru.u_dst_to_src_ack" @prim_pulse_sync(clk_src_i: %clk_dst_i: i1, rst_src_ni: %rst_dst_ni: i1, src_pulse_i: %dst_req_i: i1, clk_dst_i: %clk_src_i: i1, rst_dst_ni: %rst_src_ni: i1) -> (dst_pulse_o: i1)
    hw.output %gen_passthru.u_dst_to_src_ack.dst_pulse_o, %false, %dst_req_i, %dst_qs_i : i1, i1, i1, i6
  }
  hw.module private @prim_reg_cdc_arb_12(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, out src_ack_o : i1, out src_update_o : i1, in %dst_req_i : i1, out dst_req_o : i1, in %dst_update_i : i1, in %dst_ds_i : i32, in %dst_qs_i : i32, out dst_qs_o : i32) {
    %false = hw.constant false
    %gen_passthru.u_dst_to_src_ack.dst_pulse_o = hw.instance "gen_passthru.u_dst_to_src_ack" @prim_pulse_sync(clk_src_i: %clk_dst_i: i1, rst_src_ni: %rst_dst_ni: i1, src_pulse_i: %dst_req_i: i1, clk_dst_i: %clk_src_i: i1, rst_dst_ni: %rst_src_ni: i1) -> (dst_pulse_o: i1)
    hw.output %gen_passthru.u_dst_to_src_ack.dst_pulse_o, %false, %dst_req_i, %dst_qs_i : i1, i1, i1, i32
  }
  hw.module private @prim_reg_cdc_arb_13(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, out src_ack_o : i1, out src_update_o : i1, in %dst_req_i : i1, out dst_req_o : i1, in %dst_update_i : i1, in %dst_ds_i : i32, in %dst_qs_i : i32, out dst_qs_o : i32) {
    %false = hw.constant false
    %gen_passthru.u_dst_to_src_ack.dst_pulse_o = hw.instance "gen_passthru.u_dst_to_src_ack" @prim_pulse_sync(clk_src_i: %clk_dst_i: i1, rst_src_ni: %rst_dst_ni: i1, src_pulse_i: %dst_req_i: i1, clk_dst_i: %clk_src_i: i1, rst_dst_ni: %rst_src_ni: i1) -> (dst_pulse_o: i1)
    hw.output %gen_passthru.u_dst_to_src_ack.dst_pulse_o, %false, %dst_req_i, %dst_qs_i : i1, i1, i1, i32
  }
  hw.module private @prim_reg_cdc(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, in %src_regwen_i : i1, in %src_we_i : i1, in %src_re_i : i1, in %src_wd_i : i32, out src_busy_o : i1, out src_qs_o : i32, in %dst_ds_i : i32, in %dst_qs_i : i32, in %dst_update_i : i1, out dst_we_o : i1, out dst_re_o : i1, out dst_regwen_o : i1, out dst_wd_o : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i32 = hw.constant 0 : i32
    %c0_i3 = hw.constant 0 : i3
    %c939556864_i32 = hw.constant 939556864 : i32
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
    %u_arb.src_ack_o, %u_arb.src_update_o, %u_arb.dst_req_o, %u_arb.dst_qs_o = hw.instance "u_arb" @prim_reg_cdc_arb(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1, dst_req_i: %u_src_to_dst_req.dst_pulse_o: i1, dst_update_i: %dst_update_i: i1, dst_ds_i: %dst_ds_i: i32, dst_qs_i: %dst_qs_i: i32) -> (src_ack_o: i1, src_update_o: i1, dst_req_o: i1, dst_qs_o: i32) {sv.namehint = "dst_req"}
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
      llhd.drv %src_q, %c939556864_i32 after %0 : i32
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
  hw.module private @prim_reg_cdc_0(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, in %src_regwen_i : i1, in %src_we_i : i1, in %src_re_i : i1, in %src_wd_i : i6, out src_busy_o : i1, out src_qs_o : i6, in %dst_ds_i : i6, in %dst_qs_i : i6, in %dst_update_i : i1, out dst_we_o : i1, out dst_re_o : i1, out dst_regwen_o : i1, out dst_wd_o : i6) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i3 = hw.constant 0 : i3
    %c0_i6 = hw.constant 0 : i6
    %true = hw.constant true
    %false = hw.constant false
    %clk_src_i_0 = llhd.sig name "clk_src_i" %false : i1
    %2 = llhd.prb %clk_src_i_0 : i1
    %rst_src_ni_1 = llhd.sig name "rst_src_ni" %false : i1
    %3 = llhd.prb %rst_src_ni_1 : i1
    %src_regwen_i_2 = llhd.sig name "src_regwen_i" %false : i1
    %src_we_i_3 = llhd.sig name "src_we_i" %false : i1
    %src_re_i_4 = llhd.sig name "src_re_i" %false : i1
    %src_wd_i_5 = llhd.sig name "src_wd_i" %c0_i6 : i6
    %src_ack = llhd.sig %false : i1
    %src_busy_q = llhd.sig %false : i1
    %src_q = llhd.sig %c0_i6 : i6
    %txn_bits_q = llhd.sig %c0_i3 : i3
    %src_req = llhd.sig %false : i1
    %dst_qs = llhd.sig %c0_i6 : i6
    %dst_to_src = llhd.sig %false : i1
    %4 = llhd.prb %src_req : i1
    %u_src_to_dst_req.dst_pulse_o = hw.instance "u_src_to_dst_req" @prim_pulse_sync(clk_src_i: %2: i1, rst_src_ni: %3: i1, src_pulse_i: %4: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1) -> (dst_pulse_o: i1) {sv.namehint = "dst_req_from_src"}
    %u_arb.src_ack_o, %u_arb.src_update_o, %u_arb.dst_req_o, %u_arb.dst_qs_o = hw.instance "u_arb" @prim_reg_cdc_arb_11(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1, dst_req_i: %u_src_to_dst_req.dst_pulse_o: i1, dst_update_i: %dst_update_i: i1, dst_ds_i: %dst_ds_i: i6, dst_qs_i: %dst_qs_i: i6) -> (src_ack_o: i1, src_update_o: i1, dst_req_o: i1, dst_qs_o: i6) {sv.namehint = "dst_req"}
    llhd.drv %src_ack, %u_arb.src_ack_o after %1 : i1
    llhd.drv %dst_qs, %u_arb.dst_qs_o after %1 : i6
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
      llhd.drv %src_q, %c0_i6 after %0 : i6
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %29 = llhd.prb %src_req : i1
      cf.cond_br %29, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %30 = llhd.prb %src_wd_i_5 : i6
      llhd.drv %src_q, %30 after %0 : i6
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
      %36 = llhd.prb %dst_qs : i6
      llhd.drv %src_q, %36 after %0 : i6
      llhd.drv %txn_bits_q, %c0_i3 after %0 : i3
      cf.br ^bb1
    }
    %11 = llhd.prb %src_q : i6
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
    llhd.drv %src_wd_i_5, %src_wd_i after %1 : i6
    hw.output %8, %11, %15, %16, %17, %11 : i1, i6, i1, i1, i1, i6
  }
  hw.module private @prim_reg_cdc_1(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, in %src_regwen_i : i1, in %src_we_i : i1, in %src_re_i : i1, in %src_wd_i : i32, out src_busy_o : i1, out src_qs_o : i32, in %dst_ds_i : i32, in %dst_qs_i : i32, in %dst_update_i : i1, out dst_we_o : i1, out dst_re_o : i1, out dst_regwen_o : i1, out dst_wd_o : i32) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c-1073676289_i32 = hw.constant -1073676289 : i32
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
    %u_arb.src_ack_o, %u_arb.src_update_o, %u_arb.dst_req_o, %u_arb.dst_qs_o = hw.instance "u_arb" @prim_reg_cdc_arb_12(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1, dst_req_i: %u_src_to_dst_req.dst_pulse_o: i1, dst_update_i: %dst_update_i: i1, dst_ds_i: %dst_ds_i: i32, dst_qs_i: %dst_qs_i: i32) -> (src_ack_o: i1, src_update_o: i1, dst_req_o: i1, dst_qs_o: i32) {sv.namehint = "dst_req"}
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
      %31 = comb.and %30, %c-1073676289_i32 : i32
      llhd.drv %src_q, %31 after %0 : i32
      %32 = llhd.prb %src_we_i_3 : i1
      %33 = llhd.prb %src_re_i_4 : i1
      %34 = llhd.prb %src_regwen_i_2 : i1
      %35 = comb.concat %32, %33, %34 : i1, i1, i1
      llhd.drv %txn_bits_q, %35 after %0 : i3
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %36 = llhd.prb %dst_to_src : i1
      cf.cond_br %36, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %37 = llhd.prb %dst_qs : i32
      llhd.drv %src_q, %37 after %0 : i32
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
    %c0_i32 = hw.constant 0 : i32
    %c0_i3 = hw.constant 0 : i3
    %c2147450879_i32 = hw.constant 2147450879 : i32
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
    %u_arb.src_ack_o, %u_arb.src_update_o, %u_arb.dst_req_o, %u_arb.dst_qs_o = hw.instance "u_arb" @prim_reg_cdc_arb_13(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1, dst_req_i: %u_src_to_dst_req.dst_pulse_o: i1, dst_update_i: %dst_update_i: i1, dst_ds_i: %dst_ds_i: i32, dst_qs_i: %dst_qs_i: i32) -> (src_ack_o: i1, src_update_o: i1, dst_req_o: i1, dst_qs_o: i32) {sv.namehint = "dst_req"}
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
      llhd.drv %src_q, %c2147450879_i32 after %0 : i32
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
  hw.module private @prim_reg_cdc_3(in %clk_src_i : i1, in %rst_src_ni : i1, in %clk_dst_i : i1, in %rst_dst_ni : i1, in %src_regwen_i : i1, in %src_we_i : i1, in %src_re_i : i1, in %src_wd_i : i32, out src_busy_o : i1, out src_qs_o : i32, in %dst_ds_i : i32, in %dst_qs_i : i32, in %dst_update_i : i1, out dst_we_o : i1, out dst_re_o : i1, out dst_regwen_o : i1, out dst_wd_o : i32) {
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
    %u_arb.src_ack_o, %u_arb.src_update_o, %u_arb.dst_req_o, %u_arb.dst_qs_o = hw.instance "u_arb" @prim_reg_cdc_arb_12(clk_src_i: %2: i1, rst_src_ni: %3: i1, clk_dst_i: %clk_dst_i: i1, rst_dst_ni: %rst_dst_ni: i1, dst_req_i: %u_src_to_dst_req.dst_pulse_o: i1, dst_update_i: %dst_update_i: i1, dst_ds_i: %dst_ds_i: i32, dst_qs_i: %dst_qs_i: i32) -> (src_ack_o: i1, src_update_o: i1, dst_req_o: i1, dst_qs_o: i32) {sv.namehint = "dst_req"}
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
  hw.module private @prim_reg_we_check(in %clk_i : i1, in %rst_ni : i1, in %oh_i : i23, in %en_i : i1, out err_o : i1) {
    %c0_i5 = hw.constant 0 : i5
    %u_prim_buf.out_o = hw.instance "u_prim_buf" @prim_buf(in_i: %oh_i: i23) -> (out_o: i23) {sv.namehint = "oh_buf"}
    %u_prim_onehot_check.err_o = hw.instance "u_prim_onehot_check" @prim_onehot_check(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, oh_i: %u_prim_buf.out_o: i23, addr_i: %c0_i5: i5, en_i: %en_i: i1) -> (err_o: i1)
    hw.output %u_prim_onehot_check.err_o : i1
  }
  hw.module private @prim_sec_anchor_buf(in %in_i : i2, out out_o : i2) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf_18(in_i: %in_i: i2) -> (out_o: i2)
    hw.output %u_secure_anchor_buf.out_o : i2
  }
  hw.module private @prim_sec_anchor_buf_9(in %in_i : i1, out out_o : i1) {
    %u_secure_anchor_buf.out_o = hw.instance "u_secure_anchor_buf" @prim_buf_20(in_i: %in_i: i1) -> (out_o: i1)
    hw.output %u_secure_anchor_buf.out_o : i1
  }
  hw.module private @prim_sec_anchor_flop(in %clk_i : i1, in %rst_ni : i1, in %d_i : i2, out q_o : i2) {
    %u_secure_anchor_flop.q_o = hw.instance "u_secure_anchor_flop" @prim_flop_21(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, d_i: %d_i: i2) -> (q_o: i2)
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
    %6 = comb.xor %we, %true : i1
    %7 = comb.or %6, %5 : i1
    %8 = comb.and %4, %7 : i1
    llhd.drv %wd_0, %wd after %0 : i1
    llhd.drv %d_1, %d after %0 : i1
    llhd.drv %q_2, %q after %0 : i1
    hw.output %1, %8 : i1, i1
  }
  hw.module private @prim_subreg_arb_14(in %we : i1, in %wd : i27, in %de : i1, in %d : i27, in %q : i27, out wr_en : i1, out wr_data : i27) {
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i27 = hw.constant 0 : i27
    %wd_0 = llhd.sig name "wd" %c0_i27 : i27
    %d_1 = llhd.sig name "d" %c0_i27 : i27
    %1 = comb.or %we, %de : i1
    %2 = llhd.prb %wd_0 : i27
    %3 = llhd.prb %d_1 : i27
    %4 = comb.mux %we, %2, %3 : i27
    llhd.drv %wd_0, %wd after %0 : i27
    llhd.drv %d_1, %d after %0 : i27
    hw.output %1, %4 : i1, i27
  }
  hw.module private @prim_subreg_arb_15(in %we : i1, in %wd : i4, in %de : i1, in %d : i4, in %q : i4, out wr_en : i1, out wr_data : i4) {
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
  hw.module private @prim_subreg_arb_16(in %we : i1, in %wd : i1, in %de : i1, in %d : i1, in %q : i1, out wr_en : i1, out wr_data : i1) {
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
  hw.module private @prim_subreg_arb_17(in %we : i1, in %wd : i16, in %de : i1, in %d : i16, in %q : i16, out wr_en : i1, out wr_data : i16) {
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
  hw.module private @prim_subreg_ext(in %re : i1, in %we : i1, in %wd : i1, in %d : i1, out qe : i1, out qre : i1, out q : i1, out ds : i1, out qs : i1) {
    hw.output %we, %re, %wd, %d, %d : i1, i1, i1, i1, i1
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
  hw.module private @prim_subreg_4(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i27, in %de : i1, in %d : i27, out qe : i1, out q : i27, out ds : i27, out qs : i27) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i27 = hw.constant 0 : i27
    %c32768_i27 = hw.constant 32768 : i27
    %false = hw.constant false
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %q = llhd.sig %c0_i27 : i27
    %qs = llhd.sig %c0_i27 : i27
    %wr_en = llhd.sig %false : i1
    %wr_data = llhd.sig %c0_i27 : i27
    %4 = llhd.prb %q : i27
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_14(we: %we: i1, wd: %wd: i27, de: %de: i1, d: %d: i27, q: %4: i27) -> (wr_en: i1, wr_data: i27)
    llhd.drv %wr_en, %wr_en_data_arb.wr_en after %1 : i1
    llhd.drv %wr_data, %wr_en_data_arb.wr_data after %1 : i27
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
      llhd.drv %q, %c32768_i27 after %0 : i27
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %20 = llhd.prb %wr_en : i1
      cf.cond_br %20, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %21 = llhd.prb %wr_data : i27
      llhd.drv %q, %21 after %0 : i27
      cf.br ^bb1
    }
    %5 = llhd.prb %wr_en : i1
    %6 = llhd.prb %wr_data : i27
    %7 = llhd.prb %qs : i27
    %8 = comb.mux %5, %6, %7 : i27
    llhd.drv %qs, %4 after %1 : i27
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    hw.output %we, %4, %8, %7 : i1, i27, i27, i27
  }
  hw.module private @prim_subreg_5(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i4, in %de : i1, in %d : i4, out qe : i1, out q : i4, out ds : i4, out qs : i4) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i4 = hw.constant 0 : i4
    %c7_i4 = hw.constant 7 : i4
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_15(we: %we: i1, wd: %wd: i4, de: %de: i1, d: %d: i4, q: %4: i4) -> (wr_en: i1, wr_data: i4)
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
      llhd.drv %q, %c7_i4 after %0 : i4
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
  hw.module private @prim_subreg_6(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i1, in %de : i1, in %d : i1, out qe : i1, out q : i1, out ds : i1, out qs : i1) {
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_16(we: %we: i1, wd: %wd: i1, de: %de: i1, d: %d: i1, q: %4: i1) -> (wr_en: i1, wr_data: i1)
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_17(we: %we: i1, wd: %wd: i16, de: %de: i1, d: %d: i16, q: %4: i16) -> (wr_en: i1, wr_data: i16)
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
  hw.module private @prim_subreg_8(in %clk_i : i1, in %rst_ni : i1, in %we : i1, in %wd : i16, in %de : i1, in %d : i16, out qe : i1, out q : i16, out ds : i16, out qs : i16) {
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i16 = hw.constant 0 : i16
    %c32767_i16 = hw.constant 32767 : i16
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
    %wr_en_data_arb.wr_en, %wr_en_data_arb.wr_data = hw.instance "wr_en_data_arb" @prim_subreg_arb_17(we: %we: i1, wd: %wd: i16, de: %de: i1, d: %d: i16, q: %4: i16) -> (wr_en: i1, wr_data: i16)
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
      llhd.drv %q, %c32767_i16 after %0 : i16
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
  hw.module private @pwm_chan(in %clk_i : i1, in %rst_ni : i1, in %pwm_en_i : i1, in %invert_i : i1, in %blink_en_i : i1, in %htbt_en_i : i1, in %phase_delay_i : i16, in %duty_cycle_a_i : i16, in %duty_cycle_b_i : i16, in %blink_param_x_i : i16, in %blink_param_y_i : i16, in %phase_ctr_i : i16, in %phase_ctr_next_i : i16, in %cycle_end_i : i1, in %clr_chan_cntr_i : i1, in %dc_resn_i : i4, out pwm_o : i1) {
    %c32767_i16 = hw.constant 32767 : i16
    %c-1_i17 = hw.constant -1 : i17
    %c-1_i16 = hw.constant -1 : i16
    %c0_i12 = hw.constant 0 : i12
    %c0_i3 = hw.constant 0 : i3
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %true = hw.constant true
    %c1_i17 = hw.constant 1 : i17
    %false = hw.constant false
    %c0_i16 = hw.constant 0 : i16
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %2 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %3 = llhd.prb %rst_ni_1 : i1
    %pwm_en_i_2 = llhd.sig name "pwm_en_i" %false : i1
    %htbt_en_i_3 = llhd.sig name "htbt_en_i" %false : i1
    %duty_cycle_a_i_4 = llhd.sig name "duty_cycle_a_i" %c0_i16 : i16
    %duty_cycle_b_i_5 = llhd.sig name "duty_cycle_b_i" %c0_i16 : i16
    %blink_param_x_i_6 = llhd.sig name "blink_param_x_i" %c0_i16 : i16
    %blink_param_y_i_7 = llhd.sig name "blink_param_y_i" %c0_i16 : i16
    %cycle_end_i_8 = llhd.sig name "cycle_end_i" %false : i1
    %clr_chan_cntr_i_9 = llhd.sig name "clr_chan_cntr_i" %false : i1
    %blink_mode = llhd.sig %false : i1
    %dc_update_pending = llhd.sig %false : i1
    %set_dc_update = llhd.sig %false : i1
    %clr_dc_update = llhd.sig %false : i1
    %update = llhd.sig %false : i1
    %phase_wrap = llhd.sig %false : i1
    %pwm_int = llhd.sig %false : i1
    %blink_ctr_q = llhd.sig %c0_i16 : i16
    %blink_ctr_d = llhd.sig %c0_i16 : i16
    %duty_cycle_blink = llhd.sig %c0_i16 : i16
    %blink_y_phase_q = llhd.sig %false : i1
    %blink_y_phase_d = llhd.sig %false : i1
    %blink_end = llhd.sig %false : i1
    %duty_cycle_htbt = llhd.sig %c0_i16 : i16
    %dc_htbt_d = llhd.sig %c0_i16 : i16
    %dc_htbt_q = llhd.sig %c0_i16 : i16
    %dc_htbt_end = llhd.sig %false : i1
    %pattern_repeat = llhd.sig %false : i1
    %htbt_falling = llhd.sig %false : i1
    %dc_wrap = llhd.sig %false : i1
    %dc_wrap_q = llhd.sig %false : i1
    %pos_htbt = llhd.sig %false : i1
    %htbt_reverse = llhd.sig %false : i1
    %on_phase_started = llhd.sig %false : i1
    %off_phase_started = llhd.sig %false : i1
    %pwm_d = llhd.sig %false : i1
    %pwm_q = llhd.sig %false : i1
    %4 = llhd.prb %pwm_en_i_2 : i1
    %5 = comb.and %4, %blink_en_i : i1
    llhd.drv %blink_mode, %5 after %1 : i1
    %6 = llhd.prb %htbt_en_i_3 : i1
    %7 = comb.and %5, %6 {sv.namehint = "htbt_mode"} : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %80 = llhd.prb %clk_i_0 : i1
      %81 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %82 = llhd.prb %clk_i_0 : i1
      %83 = comb.xor bin %80, %true : i1
      %84 = comb.and bin %83, %82 : i1
      %85 = llhd.prb %rst_ni_1 : i1
      %86 = comb.xor bin %85, %true : i1
      %87 = comb.and bin %81, %86 : i1
      %88 = comb.or bin %84, %87 : i1
      cf.cond_br %88, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %89 = llhd.prb %rst_ni_1 : i1
      %90 = comb.xor %89, %true : i1
      cf.cond_br %90, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %dc_update_pending, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %91 = llhd.prb %clr_chan_cntr_i_9 : i1
      cf.cond_br %91, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %dc_update_pending, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %92 = llhd.prb %pwm_en_i_2 : i1
      cf.cond_br %92, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %93 = llhd.prb %dc_update_pending : i1
      %94 = llhd.prb %set_dc_update : i1
      %95 = comb.or %93, %94 : i1
      %96 = llhd.prb %clr_dc_update : i1
      %97 = comb.xor %96, %true : i1
      %98 = comb.and %95, %97 : i1
      llhd.drv %dc_update_pending, %98 after %0 : i1
      cf.br ^bb1
    }
    %8 = llhd.prb %cycle_end_i_8 : i1
    %9 = comb.icmp ne %60, %c0_i16 : i16
    %10 = comb.and %8, %9 : i1
    llhd.drv %set_dc_update, %10 after %1 : i1
    %11 = comb.icmp uge %phase_ctr_next_i, %60 : i16
    llhd.drv %clr_dc_update, %11 after %1 : i1
    %12 = llhd.prb %dc_update_pending : i1
    %13 = llhd.prb %clr_dc_update : i1
    %14 = comb.and %12, %13 : i1
    %15 = comb.mux %9, %14, %8 : i1
    %16 = comb.and %4, %15 : i1
    llhd.drv %update, %16 after %1 : i1
    %17 = llhd.prb %blink_ctr_q : i16
    %18 = comb.icmp eq %17, %c0_i16 : i16
    llhd.drv %blink_end, %18 after %1 : i1
    %19 = llhd.prb %blink_ctr_d : i16
    %20 = llhd.prb %blink_y_phase_q : i1
    %21 = llhd.prb %blink_y_phase_d : i1
    %22 = llhd.prb %clr_chan_cntr_i_9 : i1
    %23 = llhd.prb %blink_param_x_i_6 : i16
    %24 = llhd.prb %blink_mode : i1
    %25 = llhd.prb %update : i1
    %26 = llhd.prb %blink_end : i1
    %27 = llhd.prb %blink_param_y_i_7 : i16
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb7
      %80 = llhd.prb %blink_ctr_q : i16
      llhd.drv %blink_ctr_d, %80 after %1 : i16
      %81 = llhd.prb %blink_y_phase_q : i1
      llhd.drv %blink_y_phase_d, %81 after %1 : i1
      %82 = llhd.prb %clr_chan_cntr_i_9 : i1
      cf.cond_br %82, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %83 = llhd.prb %blink_param_x_i_6 : i16
      llhd.drv %blink_ctr_d, %83 after %1 : i16
      llhd.drv %blink_y_phase_d, %false after %1 : i1
      cf.br ^bb7
    ^bb3:  // pred: ^bb1
      %84 = llhd.prb %blink_mode : i1
      %85 = llhd.prb %update : i1
      %86 = comb.and %84, %85 : i1
      cf.cond_br %86, ^bb4, ^bb7
    ^bb4:  // pred: ^bb3
      %87 = llhd.prb %blink_end : i1
      cf.cond_br %87, ^bb5, ^bb6
    ^bb5:  // pred: ^bb4
      %88 = llhd.prb %blink_y_phase_q : i1
      %89 = llhd.prb %htbt_en_i_3 : i1
      %90 = comb.or %88, %89 : i1
      %91 = llhd.prb %blink_param_x_i_6 : i16
      %92 = llhd.prb %blink_param_y_i_7 : i16
      %93 = comb.mux %90, %91, %92 : i16
      llhd.drv %blink_ctr_d, %93 after %1 : i16
      %94 = llhd.prb %blink_y_phase_q : i1
      %95 = llhd.prb %htbt_en_i_3 : i1
      %96 = comb.or %94, %95 : i1
      %97 = comb.xor %96, %true : i1
      llhd.drv %blink_y_phase_d, %97 after %1 : i1
      cf.br ^bb7
    ^bb6:  // pred: ^bb4
      %98 = llhd.prb %blink_ctr_q : i16
      %99 = comb.add %98, %c-1_i16 : i16
      llhd.drv %blink_ctr_d, %99 after %1 : i16
      cf.br ^bb7
    ^bb7:  // 4 preds: ^bb2, ^bb3, ^bb5, ^bb6
      llhd.wait (%17, %19, %20, %21, %22, %23, %24, %25, %26, %6, %27 : i16, i16, i1, i1, i1, i16, i1, i1, i1, i1, i16), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %80 = llhd.prb %clk_i_0 : i1
      %81 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %82 = llhd.prb %clk_i_0 : i1
      %83 = comb.xor bin %80, %true : i1
      %84 = comb.and bin %83, %82 : i1
      %85 = llhd.prb %rst_ni_1 : i1
      %86 = comb.xor bin %85, %true : i1
      %87 = comb.and bin %81, %86 : i1
      %88 = comb.or bin %84, %87 : i1
      cf.cond_br %88, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %89 = llhd.prb %rst_ni_1 : i1
      %90 = comb.xor %89, %true : i1
      cf.cond_br %90, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %blink_ctr_q, %c0_i16 after %0 : i16
      llhd.drv %blink_y_phase_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %91 = llhd.prb %blink_ctr_d : i16
      llhd.drv %blink_ctr_q, %91 after %0 : i16
      %92 = llhd.prb %blink_y_phase_d : i1
      llhd.drv %blink_y_phase_q, %92 after %0 : i1
      cf.br ^bb1
    }
    %28 = comb.and %blink_en_i, %20 : i1
    %29 = llhd.prb %duty_cycle_b_i_5 : i16
    %30 = llhd.prb %duty_cycle_a_i_4 : i16
    %31 = comb.mux %28, %29, %30 : i16
    llhd.drv %duty_cycle_blink, %31 after %1 : i16
    %32 = comb.and %7, %25, %26 : i1
    llhd.drv %dc_htbt_end, %32 after %1 : i1
    %33 = comb.icmp ult %30, %29 : i16
    llhd.drv %pos_htbt, %33 after %1 : i1
    %34 = comb.icmp eq %30, %29 : i16
    llhd.drv %pattern_repeat, %34 after %1 : i1
    %35 = llhd.prb %pos_htbt : i1
    %36 = comb.mux %35, %29, %30 {sv.namehint = "dc_htbt_max"} : i16
    %37 = comb.mux %35, %30, %29 {sv.namehint = "dc_htbt_min"} : i16
    %38 = llhd.prb %htbt_falling : i1
    %39 = comb.xor %38, %true : i1
    %40 = llhd.prb %dc_htbt_q : i16
    %41 = comb.icmp uge %40, %36 : i16
    %42 = comb.and %39, %41 {sv.namehint = "htbt_too_high"} : i1
    %43 = comb.icmp ule %40, %37 : i16
    %44 = comb.and %38, %43 {sv.namehint = "htbt_too_low"} : i1
    %45 = llhd.prb %dc_wrap_q : i1
    %46 = comb.concat %42, %44, %45 : i1, i1, i1
    %47 = comb.icmp ne %46, %c0_i3 : i3
    llhd.drv %htbt_reverse, %47 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %80 = llhd.prb %clk_i_0 : i1
      %81 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %82 = llhd.prb %clk_i_0 : i1
      %83 = comb.xor bin %80, %true : i1
      %84 = comb.and bin %83, %82 : i1
      %85 = llhd.prb %rst_ni_1 : i1
      %86 = comb.xor bin %85, %true : i1
      %87 = comb.and bin %81, %86 : i1
      %88 = comb.or bin %84, %87 : i1
      cf.cond_br %88, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %89 = llhd.prb %rst_ni_1 : i1
      %90 = comb.xor %89, %true : i1
      cf.cond_br %90, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %htbt_falling, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %91 = llhd.prb %clr_chan_cntr_i_9 : i1
      cf.cond_br %91, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %92 = llhd.prb %pos_htbt : i1
      %93 = comb.xor %92, %true : i1
      llhd.drv %htbt_falling, %93 after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %94 = llhd.prb %dc_htbt_end : i1
      %95 = llhd.prb %htbt_reverse : i1
      %96 = comb.and %94, %95 : i1
      cf.cond_br %96, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %97 = llhd.prb %htbt_falling : i1
      %98 = comb.xor %97, %true : i1
      llhd.drv %htbt_falling, %98 after %0 : i1
      cf.br ^bb1
    }
    %48 = llhd.prb %pattern_repeat : i1
    %49 = llhd.prb %dc_wrap : i1
    %50 = llhd.prb %dc_htbt_d : i16
    %51 = llhd.prb %htbt_reverse : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb6
      %80 = llhd.prb %pattern_repeat : i1
      cf.cond_br %80, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %81 = llhd.prb %duty_cycle_a_i_4 : i16
      llhd.drv %dc_wrap, %false after %1 : i1
      llhd.drv %dc_htbt_d, %81 after %1 : i16
      cf.br ^bb6
    ^bb3:  // pred: ^bb1
      %82 = llhd.prb %htbt_falling : i1
      %83 = llhd.prb %htbt_reverse : i1
      %84 = comb.xor %82, %83 : i1
      cf.cond_br %84, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %85 = llhd.prb %dc_wrap_q : i1
      %86 = llhd.prb %dc_htbt_q : i16
      %87 = comb.concat %85, %86 : i1, i16
      %88 = llhd.prb %blink_param_y_i_7 : i16
      %89 = comb.concat %false, %88 : i1, i16
      %90 = comb.sub %87, %89 : i17
      %91 = comb.add %90, %c-1_i17 : i17
      %92 = comb.extract %91 from 16 : (i17) -> i1
      llhd.drv %dc_wrap, %92 after %1 : i1
      %93 = comb.extract %91 from 0 : (i17) -> i16
      llhd.drv %dc_htbt_d, %93 after %1 : i16
      cf.br ^bb6
    ^bb5:  // pred: ^bb3
      %94 = llhd.prb %dc_wrap_q : i1
      %95 = llhd.prb %dc_htbt_q : i16
      %96 = comb.concat %94, %95 : i1, i16
      %97 = llhd.prb %blink_param_y_i_7 : i16
      %98 = comb.concat %false, %97 : i1, i16
      %99 = comb.add %96, %98, %c1_i17 : i17
      %100 = comb.extract %99 from 16 : (i17) -> i1
      llhd.drv %dc_wrap, %100 after %1 : i1
      %101 = comb.extract %99 from 0 : (i17) -> i16
      llhd.drv %dc_htbt_d, %101 after %1 : i16
      cf.br ^bb6
    ^bb6:  // 3 preds: ^bb2, ^bb4, ^bb5
      llhd.wait (%48, %30, %49, %50, %38, %51, %45, %40, %27 : i1, i16, i1, i16, i1, i1, i1, i16, i16), ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %80 = llhd.prb %clk_i_0 : i1
      %81 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %82 = llhd.prb %clk_i_0 : i1
      %83 = comb.xor bin %80, %true : i1
      %84 = comb.and bin %83, %82 : i1
      %85 = llhd.prb %rst_ni_1 : i1
      %86 = comb.xor bin %85, %true : i1
      %87 = comb.and bin %81, %86 : i1
      %88 = comb.or bin %84, %87 : i1
      cf.cond_br %88, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %89 = llhd.prb %rst_ni_1 : i1
      %90 = comb.xor %89, %true : i1
      cf.cond_br %90, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %dc_wrap_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %91 = llhd.prb %clr_chan_cntr_i_9 : i1
      cf.cond_br %91, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      llhd.drv %dc_wrap_q, %false after %0 : i1
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %92 = llhd.prb %dc_htbt_end : i1
      cf.cond_br %92, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %93 = llhd.prb %dc_wrap : i1
      llhd.drv %dc_wrap_q, %93 after %0 : i1
      cf.br ^bb1
    }
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 6 preds: ^bb0, ^bb2, ^bb4, ^bb6, ^bb7, ^bb8
      %80 = llhd.prb %clk_i_0 : i1
      %81 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %82 = llhd.prb %clk_i_0 : i1
      %83 = comb.xor bin %80, %true : i1
      %84 = comb.and bin %83, %82 : i1
      %85 = llhd.prb %rst_ni_1 : i1
      %86 = comb.xor bin %85, %true : i1
      %87 = comb.and bin %81, %86 : i1
      %88 = comb.or bin %84, %87 : i1
      cf.cond_br %88, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %89 = llhd.prb %rst_ni_1 : i1
      %90 = comb.xor %89, %true : i1
      cf.cond_br %90, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %dc_htbt_q, %c0_i16 after %0 : i16
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %91 = llhd.prb %clr_chan_cntr_i_9 : i1
      cf.cond_br %91, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %92 = llhd.prb %duty_cycle_a_i_4 : i16
      llhd.drv %dc_htbt_q, %92 after %0 : i16
      cf.br ^bb1
    ^bb7:  // pred: ^bb5
      %93 = llhd.prb %dc_htbt_end : i1
      cf.cond_br %93, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %94 = llhd.prb %dc_htbt_d : i16
      llhd.drv %dc_htbt_q, %94 after %0 : i16
      cf.br ^bb1
    }
    %52 = comb.replicate %35 : (i1) -> i16
    %53 = comb.mux %45, %52, %40 : i16
    llhd.drv %duty_cycle_htbt, %53 after %1 : i16
    %54 = llhd.prb %duty_cycle_htbt : i16
    %55 = llhd.prb %duty_cycle_blink : i16
    %56 = comb.mux %7, %54, %55 {sv.namehint = "duty_cycle_actual"} : i16
    %57 = comb.concat %c0_i12, %dc_resn_i : i12, i4
    %58 = comb.shru %c32767_i16, %57 {sv.namehint = "dc_mask"} : i16
    %59 = comb.xor %58, %c-1_i16 : i16
    %60 = comb.and %phase_delay_i, %59 {sv.namehint = "on_phase"} : i16
    %61 = comb.and %56, %59 {sv.namehint = "duty_cycle_masked"} : i16
    %62 = comb.concat %false, %60 : i1, i16
    %63 = comb.concat %false, %61 : i1, i16
    %64 = comb.add %62, %63 : i17
    %65 = comb.extract %64 from 16 : (i17) -> i1
    llhd.drv %phase_wrap, %65 after %1 : i1
    %66 = comb.extract %64 from 0 {sv.namehint = "off_phase"} : (i17) -> i16
    %67 = comb.icmp uge %phase_ctr_i, %60 : i16
    llhd.drv %on_phase_started, %67 after %1 : i1
    %68 = comb.icmp uge %phase_ctr_i, %66 : i16
    llhd.drv %off_phase_started, %68 after %1 : i1
    %69 = llhd.prb %phase_wrap : i1
    %70 = llhd.prb %on_phase_started : i1
    %71 = llhd.prb %off_phase_started : i1
    %72 = comb.xor %71, %true : i1
    %73 = comb.or %70, %72 : i1
    %74 = comb.and %70, %72 : i1
    %75 = comb.mux %69, %73, %74 : i1
    %76 = comb.and %4, %75 : i1
    llhd.drv %pwm_int, %76 after %1 : i1
    %77 = llhd.prb %pwm_int : i1
    %78 = comb.xor %invert_i, %77 : i1
    llhd.drv %pwm_d, %78 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %80 = llhd.prb %clk_i_0 : i1
      %81 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%2, %3 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %82 = llhd.prb %clk_i_0 : i1
      %83 = comb.xor bin %80, %true : i1
      %84 = comb.and bin %83, %82 : i1
      %85 = llhd.prb %rst_ni_1 : i1
      %86 = comb.xor bin %85, %true : i1
      %87 = comb.and bin %81, %86 : i1
      %88 = comb.or bin %84, %87 : i1
      cf.cond_br %88, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %89 = llhd.prb %rst_ni_1 : i1
      %90 = comb.xor %89, %true : i1
      cf.cond_br %90, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %pwm_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %91 = llhd.prb %pwm_d : i1
      llhd.drv %pwm_q, %91 after %0 : i1
      cf.br ^bb1
    }
    %79 = llhd.prb %pwm_q : i1
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    llhd.drv %pwm_en_i_2, %pwm_en_i after %1 : i1
    llhd.drv %htbt_en_i_3, %htbt_en_i after %1 : i1
    llhd.drv %duty_cycle_a_i_4, %duty_cycle_a_i after %1 : i16
    llhd.drv %duty_cycle_b_i_5, %duty_cycle_b_i after %1 : i16
    llhd.drv %blink_param_x_i_6, %blink_param_x_i after %1 : i16
    llhd.drv %blink_param_y_i_7, %blink_param_y_i after %1 : i16
    llhd.drv %cycle_end_i_8, %cycle_end_i after %1 : i1
    llhd.drv %clr_chan_cntr_i_9, %clr_chan_cntr_i after %1 : i1
    hw.output %79 : i1
  }
  hw.module private @pwm_core(in %clk_core_i : i1, in %rst_core_ni : i1, in %reg2hw : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>, out pwm_o : i6) {
    %c-1_i4 = hw.constant -1 : i4
    %c0_i12 = hw.constant 0 : i12
    %c-1_i3 = hw.constant -1 : i3
    %c0_i29 = hw.constant 0 : i29
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %true = hw.constant true
    %c-3_i3 = hw.constant -3 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c3_i3 = hw.constant 3 : i3
    %c2_i3 = hw.constant 2 : i3
    %c1_i3 = hw.constant 1 : i3
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i3 = hw.constant 0 : i3
    %2 = hw.aggregate_constant [[false, false], [[false, false], [0 : i4, false], [0 : i27, false]], [[false, false], [false, false], [false, false], [false, false], [false, false], [false, false]], [[false, false], [false, false], [false, false], [false, false], [false, false], [false, false]], [[[false, false], [false, false], [0 : i16, false]], [[false, false], [false, false], [0 : i16, false]], [[false, false], [false, false], [0 : i16, false]], [[false, false], [false, false], [0 : i16, false]], [[false, false], [false, false], [0 : i16, false]], [[false, false], [false, false], [0 : i16, false]]], [[[0 : i16, false], [0 : i16, false]], [[0 : i16, false], [0 : i16, false]], [[0 : i16, false], [0 : i16, false]], [[0 : i16, false], [0 : i16, false]], [[0 : i16, false], [0 : i16, false]], [[0 : i16, false], [0 : i16, false]]], [[[0 : i16, false], [0 : i16, false]], [[0 : i16, false], [0 : i16, false]], [[0 : i16, false], [0 : i16, false]], [[0 : i16, false], [0 : i16, false]], [[0 : i16, false], [0 : i16, false]], [[0 : i16, false], [0 : i16, false]]]] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
    %c0_i16 = hw.constant 0 : i16
    %c1_i16 = hw.constant 1 : i16
    %c1_i27 = hw.constant 1 : i27
    %c0_i4 = hw.constant 0 : i4
    %c0_i27 = hw.constant 0 : i27
    %false = hw.constant false
    %c1_i32 = hw.constant 1 : i32
    %c6_i32 = hw.constant 6 : i32
    %c0_i32 = hw.constant 0 : i32
    %c0_i6 = hw.constant 0 : i6
    %clk_core_i_0 = llhd.sig name "clk_core_i" %false : i1
    %3 = llhd.prb %clk_core_i_0 : i1
    %rst_core_ni_1 = llhd.sig name "rst_core_ni" %false : i1
    %4 = llhd.prb %rst_core_ni_1 : i1
    %reg2hw_2 = llhd.sig name "reg2hw" %2 : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
    %pwm_o = llhd.sig %c0_i6 : i6
    %cntr_en_q = llhd.sig %false : i1
    %clk_div_q = llhd.sig %c0_i27 : i27
    %dc_resn_q = llhd.sig %c0_i4 : i4
    %clr_phase_cntr = llhd.sig %false : i1
    %clr_chan_cntr = llhd.sig %c0_i6 : i6
    %pwm_en_q = llhd.sig %c0_i6 : i6
    %invert_q = llhd.sig %c0_i6 : i6
    %cntr_en = llhd.sig %false : i1
    %clk_div = llhd.sig %c0_i27 : i27
    %beat_ctr_q = llhd.sig %c0_i27 : i27
    %beat_ctr_d = llhd.sig %c0_i27 : i27
    %phase_ctr_q = llhd.sig %c0_i16 : i16
    %phase_ctr_d = llhd.sig %c0_i16 : i16
    %phase_ctr_next = llhd.sig %c0_i16 : i16
    %phase_ctr_en = llhd.sig %false : i1
    %5 = llhd.prb %reg2hw_2 : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
    %pwm_en = hw.struct_extract %5["pwm_en"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
    %6 = hw.array_get %pwm_en[%c0_i3] : !hw.array<6xstruct<q: i1, qe: i1>>, i3
    %q = hw.struct_extract %6["q"] : !hw.struct<q: i1, qe: i1>
    %invert = hw.struct_extract %5["invert"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
    %7 = hw.array_get %invert[%c0_i3] : !hw.array<6xstruct<q: i1, qe: i1>>, i3
    %q_3 = hw.struct_extract %7["q"] : !hw.struct<q: i1, qe: i1>
    %pwm_param = hw.struct_extract %5["pwm_param"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
    %8 = hw.array_get %pwm_param[%c0_i3] : !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, i3
    %blink_en = hw.struct_extract %8["blink_en"] : !hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>
    %q_4 = hw.struct_extract %blink_en["q"] : !hw.struct<q: i1, qe: i1>
    %htbt_en = hw.struct_extract %8["htbt_en"] : !hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>
    %q_5 = hw.struct_extract %htbt_en["q"] : !hw.struct<q: i1, qe: i1>
    %phase_delay = hw.struct_extract %8["phase_delay"] : !hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>
    %q_6 = hw.struct_extract %phase_delay["q"] : !hw.struct<q: i16, qe: i1>
    %duty_cycle = hw.struct_extract %5["duty_cycle"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
    %9 = hw.array_get %duty_cycle[%c0_i3] : !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, i3
    %a = hw.struct_extract %9["a"] : !hw.struct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>
    %q_7 = hw.struct_extract %a["q"] : !hw.struct<q: i16, qe: i1>
    %b = hw.struct_extract %9["b"] : !hw.struct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>
    %q_8 = hw.struct_extract %b["q"] : !hw.struct<q: i16, qe: i1>
    %blink_param = hw.struct_extract %5["blink_param"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
    %10 = hw.array_get %blink_param[%c0_i3] : !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>, i3
    %x = hw.struct_extract %10["x"] : !hw.struct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>
    %q_9 = hw.struct_extract %x["q"] : !hw.struct<q: i16, qe: i1>
    %y = hw.struct_extract %10["y"] : !hw.struct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>
    %q_10 = hw.struct_extract %y["q"] : !hw.struct<q: i16, qe: i1>
    %11 = llhd.prb %phase_ctr_q : i16
    %12 = llhd.prb %phase_ctr_next : i16
    %13 = llhd.prb %clr_chan_cntr : i6
    %14 = comb.extract %13 from 0 : (i6) -> i1
    %15 = llhd.sig.extract %pwm_o from %c0_i3 : <i6> -> <i1>
    %gen_chan_insts_0.u_chan.pwm_o = hw.instance "gen_chan_insts_0.u_chan" @pwm_chan(clk_i: %3: i1, rst_ni: %4: i1, pwm_en_i: %q: i1, invert_i: %q_3: i1, blink_en_i: %q_4: i1, htbt_en_i: %q_5: i1, phase_delay_i: %q_6: i16, duty_cycle_a_i: %q_7: i16, duty_cycle_b_i: %q_8: i16, blink_param_x_i: %q_9: i16, blink_param_y_i: %q_10: i16, phase_ctr_i: %11: i16, phase_ctr_next_i: %12: i16, cycle_end_i: %128: i1, clr_chan_cntr_i: %14: i1, dc_resn_i: %107: i4) -> (pwm_o: i1)
    llhd.drv %15, %gen_chan_insts_0.u_chan.pwm_o after %1 : i1
    %16 = hw.array_get %pwm_en[%c1_i3] : !hw.array<6xstruct<q: i1, qe: i1>>, i3
    %q_11 = hw.struct_extract %16["q"] : !hw.struct<q: i1, qe: i1>
    %17 = hw.array_get %invert[%c1_i3] : !hw.array<6xstruct<q: i1, qe: i1>>, i3
    %q_12 = hw.struct_extract %17["q"] : !hw.struct<q: i1, qe: i1>
    %18 = hw.array_get %pwm_param[%c1_i3] : !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, i3
    %blink_en_13 = hw.struct_extract %18["blink_en"] : !hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>
    %q_14 = hw.struct_extract %blink_en_13["q"] : !hw.struct<q: i1, qe: i1>
    %htbt_en_15 = hw.struct_extract %18["htbt_en"] : !hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>
    %q_16 = hw.struct_extract %htbt_en_15["q"] : !hw.struct<q: i1, qe: i1>
    %phase_delay_17 = hw.struct_extract %18["phase_delay"] : !hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>
    %q_18 = hw.struct_extract %phase_delay_17["q"] : !hw.struct<q: i16, qe: i1>
    %19 = hw.array_get %duty_cycle[%c1_i3] : !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, i3
    %a_19 = hw.struct_extract %19["a"] : !hw.struct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>
    %q_20 = hw.struct_extract %a_19["q"] : !hw.struct<q: i16, qe: i1>
    %b_21 = hw.struct_extract %19["b"] : !hw.struct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>
    %q_22 = hw.struct_extract %b_21["q"] : !hw.struct<q: i16, qe: i1>
    %20 = hw.array_get %blink_param[%c1_i3] : !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>, i3
    %x_23 = hw.struct_extract %20["x"] : !hw.struct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>
    %q_24 = hw.struct_extract %x_23["q"] : !hw.struct<q: i16, qe: i1>
    %y_25 = hw.struct_extract %20["y"] : !hw.struct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>
    %q_26 = hw.struct_extract %y_25["q"] : !hw.struct<q: i16, qe: i1>
    %21 = comb.extract %13 from 1 : (i6) -> i1
    %22 = llhd.sig.extract %pwm_o from %c1_i3 : <i6> -> <i1>
    %gen_chan_insts_1.u_chan.pwm_o = hw.instance "gen_chan_insts_1.u_chan" @pwm_chan(clk_i: %3: i1, rst_ni: %4: i1, pwm_en_i: %q_11: i1, invert_i: %q_12: i1, blink_en_i: %q_14: i1, htbt_en_i: %q_16: i1, phase_delay_i: %q_18: i16, duty_cycle_a_i: %q_20: i16, duty_cycle_b_i: %q_22: i16, blink_param_x_i: %q_24: i16, blink_param_y_i: %q_26: i16, phase_ctr_i: %11: i16, phase_ctr_next_i: %12: i16, cycle_end_i: %128: i1, clr_chan_cntr_i: %21: i1, dc_resn_i: %107: i4) -> (pwm_o: i1)
    llhd.drv %22, %gen_chan_insts_1.u_chan.pwm_o after %1 : i1
    %23 = hw.array_get %pwm_en[%c2_i3] : !hw.array<6xstruct<q: i1, qe: i1>>, i3
    %q_27 = hw.struct_extract %23["q"] : !hw.struct<q: i1, qe: i1>
    %24 = hw.array_get %invert[%c2_i3] : !hw.array<6xstruct<q: i1, qe: i1>>, i3
    %q_28 = hw.struct_extract %24["q"] : !hw.struct<q: i1, qe: i1>
    %25 = hw.array_get %pwm_param[%c2_i3] : !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, i3
    %blink_en_29 = hw.struct_extract %25["blink_en"] : !hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>
    %q_30 = hw.struct_extract %blink_en_29["q"] : !hw.struct<q: i1, qe: i1>
    %htbt_en_31 = hw.struct_extract %25["htbt_en"] : !hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>
    %q_32 = hw.struct_extract %htbt_en_31["q"] : !hw.struct<q: i1, qe: i1>
    %phase_delay_33 = hw.struct_extract %25["phase_delay"] : !hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>
    %q_34 = hw.struct_extract %phase_delay_33["q"] : !hw.struct<q: i16, qe: i1>
    %26 = hw.array_get %duty_cycle[%c2_i3] : !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, i3
    %a_35 = hw.struct_extract %26["a"] : !hw.struct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>
    %q_36 = hw.struct_extract %a_35["q"] : !hw.struct<q: i16, qe: i1>
    %b_37 = hw.struct_extract %26["b"] : !hw.struct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>
    %q_38 = hw.struct_extract %b_37["q"] : !hw.struct<q: i16, qe: i1>
    %27 = hw.array_get %blink_param[%c2_i3] : !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>, i3
    %x_39 = hw.struct_extract %27["x"] : !hw.struct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>
    %q_40 = hw.struct_extract %x_39["q"] : !hw.struct<q: i16, qe: i1>
    %y_41 = hw.struct_extract %27["y"] : !hw.struct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>
    %q_42 = hw.struct_extract %y_41["q"] : !hw.struct<q: i16, qe: i1>
    %28 = comb.extract %13 from 2 : (i6) -> i1
    %29 = llhd.sig.extract %pwm_o from %c2_i3 : <i6> -> <i1>
    %gen_chan_insts_2.u_chan.pwm_o = hw.instance "gen_chan_insts_2.u_chan" @pwm_chan(clk_i: %3: i1, rst_ni: %4: i1, pwm_en_i: %q_27: i1, invert_i: %q_28: i1, blink_en_i: %q_30: i1, htbt_en_i: %q_32: i1, phase_delay_i: %q_34: i16, duty_cycle_a_i: %q_36: i16, duty_cycle_b_i: %q_38: i16, blink_param_x_i: %q_40: i16, blink_param_y_i: %q_42: i16, phase_ctr_i: %11: i16, phase_ctr_next_i: %12: i16, cycle_end_i: %128: i1, clr_chan_cntr_i: %28: i1, dc_resn_i: %107: i4) -> (pwm_o: i1)
    llhd.drv %29, %gen_chan_insts_2.u_chan.pwm_o after %1 : i1
    %30 = hw.array_get %pwm_en[%c3_i3] : !hw.array<6xstruct<q: i1, qe: i1>>, i3
    %q_43 = hw.struct_extract %30["q"] : !hw.struct<q: i1, qe: i1>
    %31 = hw.array_get %invert[%c3_i3] : !hw.array<6xstruct<q: i1, qe: i1>>, i3
    %q_44 = hw.struct_extract %31["q"] : !hw.struct<q: i1, qe: i1>
    %32 = hw.array_get %pwm_param[%c3_i3] : !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, i3
    %blink_en_45 = hw.struct_extract %32["blink_en"] : !hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>
    %q_46 = hw.struct_extract %blink_en_45["q"] : !hw.struct<q: i1, qe: i1>
    %htbt_en_47 = hw.struct_extract %32["htbt_en"] : !hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>
    %q_48 = hw.struct_extract %htbt_en_47["q"] : !hw.struct<q: i1, qe: i1>
    %phase_delay_49 = hw.struct_extract %32["phase_delay"] : !hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>
    %q_50 = hw.struct_extract %phase_delay_49["q"] : !hw.struct<q: i16, qe: i1>
    %33 = hw.array_get %duty_cycle[%c3_i3] : !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, i3
    %a_51 = hw.struct_extract %33["a"] : !hw.struct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>
    %q_52 = hw.struct_extract %a_51["q"] : !hw.struct<q: i16, qe: i1>
    %b_53 = hw.struct_extract %33["b"] : !hw.struct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>
    %q_54 = hw.struct_extract %b_53["q"] : !hw.struct<q: i16, qe: i1>
    %34 = hw.array_get %blink_param[%c3_i3] : !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>, i3
    %x_55 = hw.struct_extract %34["x"] : !hw.struct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>
    %q_56 = hw.struct_extract %x_55["q"] : !hw.struct<q: i16, qe: i1>
    %y_57 = hw.struct_extract %34["y"] : !hw.struct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>
    %q_58 = hw.struct_extract %y_57["q"] : !hw.struct<q: i16, qe: i1>
    %35 = comb.extract %13 from 3 : (i6) -> i1
    %36 = llhd.sig.extract %pwm_o from %c3_i3 : <i6> -> <i1>
    %gen_chan_insts_3.u_chan.pwm_o = hw.instance "gen_chan_insts_3.u_chan" @pwm_chan(clk_i: %3: i1, rst_ni: %4: i1, pwm_en_i: %q_43: i1, invert_i: %q_44: i1, blink_en_i: %q_46: i1, htbt_en_i: %q_48: i1, phase_delay_i: %q_50: i16, duty_cycle_a_i: %q_52: i16, duty_cycle_b_i: %q_54: i16, blink_param_x_i: %q_56: i16, blink_param_y_i: %q_58: i16, phase_ctr_i: %11: i16, phase_ctr_next_i: %12: i16, cycle_end_i: %128: i1, clr_chan_cntr_i: %35: i1, dc_resn_i: %107: i4) -> (pwm_o: i1)
    llhd.drv %36, %gen_chan_insts_3.u_chan.pwm_o after %1 : i1
    %37 = hw.array_get %pwm_en[%c-4_i3] : !hw.array<6xstruct<q: i1, qe: i1>>, i3
    %q_59 = hw.struct_extract %37["q"] : !hw.struct<q: i1, qe: i1>
    %38 = hw.array_get %invert[%c-4_i3] : !hw.array<6xstruct<q: i1, qe: i1>>, i3
    %q_60 = hw.struct_extract %38["q"] : !hw.struct<q: i1, qe: i1>
    %39 = hw.array_get %pwm_param[%c-4_i3] : !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, i3
    %blink_en_61 = hw.struct_extract %39["blink_en"] : !hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>
    %q_62 = hw.struct_extract %blink_en_61["q"] : !hw.struct<q: i1, qe: i1>
    %htbt_en_63 = hw.struct_extract %39["htbt_en"] : !hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>
    %q_64 = hw.struct_extract %htbt_en_63["q"] : !hw.struct<q: i1, qe: i1>
    %phase_delay_65 = hw.struct_extract %39["phase_delay"] : !hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>
    %q_66 = hw.struct_extract %phase_delay_65["q"] : !hw.struct<q: i16, qe: i1>
    %40 = hw.array_get %duty_cycle[%c-4_i3] : !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, i3
    %a_67 = hw.struct_extract %40["a"] : !hw.struct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>
    %q_68 = hw.struct_extract %a_67["q"] : !hw.struct<q: i16, qe: i1>
    %b_69 = hw.struct_extract %40["b"] : !hw.struct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>
    %q_70 = hw.struct_extract %b_69["q"] : !hw.struct<q: i16, qe: i1>
    %41 = hw.array_get %blink_param[%c-4_i3] : !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>, i3
    %x_71 = hw.struct_extract %41["x"] : !hw.struct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>
    %q_72 = hw.struct_extract %x_71["q"] : !hw.struct<q: i16, qe: i1>
    %y_73 = hw.struct_extract %41["y"] : !hw.struct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>
    %q_74 = hw.struct_extract %y_73["q"] : !hw.struct<q: i16, qe: i1>
    %42 = comb.extract %13 from 4 : (i6) -> i1
    %43 = llhd.sig.extract %pwm_o from %c-4_i3 : <i6> -> <i1>
    %gen_chan_insts_4.u_chan.pwm_o = hw.instance "gen_chan_insts_4.u_chan" @pwm_chan(clk_i: %3: i1, rst_ni: %4: i1, pwm_en_i: %q_59: i1, invert_i: %q_60: i1, blink_en_i: %q_62: i1, htbt_en_i: %q_64: i1, phase_delay_i: %q_66: i16, duty_cycle_a_i: %q_68: i16, duty_cycle_b_i: %q_70: i16, blink_param_x_i: %q_72: i16, blink_param_y_i: %q_74: i16, phase_ctr_i: %11: i16, phase_ctr_next_i: %12: i16, cycle_end_i: %128: i1, clr_chan_cntr_i: %42: i1, dc_resn_i: %107: i4) -> (pwm_o: i1)
    llhd.drv %43, %gen_chan_insts_4.u_chan.pwm_o after %1 : i1
    %44 = hw.array_get %pwm_en[%c-3_i3] : !hw.array<6xstruct<q: i1, qe: i1>>, i3
    %q_75 = hw.struct_extract %44["q"] : !hw.struct<q: i1, qe: i1>
    %45 = hw.array_get %invert[%c-3_i3] : !hw.array<6xstruct<q: i1, qe: i1>>, i3
    %q_76 = hw.struct_extract %45["q"] : !hw.struct<q: i1, qe: i1>
    %46 = hw.array_get %pwm_param[%c-3_i3] : !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, i3
    %blink_en_77 = hw.struct_extract %46["blink_en"] : !hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>
    %q_78 = hw.struct_extract %blink_en_77["q"] : !hw.struct<q: i1, qe: i1>
    %htbt_en_79 = hw.struct_extract %46["htbt_en"] : !hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>
    %q_80 = hw.struct_extract %htbt_en_79["q"] : !hw.struct<q: i1, qe: i1>
    %phase_delay_81 = hw.struct_extract %46["phase_delay"] : !hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>
    %q_82 = hw.struct_extract %phase_delay_81["q"] : !hw.struct<q: i16, qe: i1>
    %47 = hw.array_get %duty_cycle[%c-3_i3] : !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, i3
    %a_83 = hw.struct_extract %47["a"] : !hw.struct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>
    %q_84 = hw.struct_extract %a_83["q"] : !hw.struct<q: i16, qe: i1>
    %b_85 = hw.struct_extract %47["b"] : !hw.struct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>
    %q_86 = hw.struct_extract %b_85["q"] : !hw.struct<q: i16, qe: i1>
    %48 = hw.array_get %blink_param[%c-3_i3] : !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>, i3
    %x_87 = hw.struct_extract %48["x"] : !hw.struct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>
    %q_88 = hw.struct_extract %x_87["q"] : !hw.struct<q: i16, qe: i1>
    %y_89 = hw.struct_extract %48["y"] : !hw.struct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>
    %q_90 = hw.struct_extract %y_89["q"] : !hw.struct<q: i16, qe: i1>
    %49 = comb.extract %13 from 5 : (i6) -> i1
    %50 = llhd.sig.extract %pwm_o from %c-3_i3 : <i6> -> <i1>
    %gen_chan_insts_5.u_chan.pwm_o = hw.instance "gen_chan_insts_5.u_chan" @pwm_chan(clk_i: %3: i1, rst_ni: %4: i1, pwm_en_i: %q_75: i1, invert_i: %q_76: i1, blink_en_i: %q_78: i1, htbt_en_i: %q_80: i1, phase_delay_i: %q_82: i16, duty_cycle_a_i: %q_84: i16, duty_cycle_b_i: %q_86: i16, blink_param_x_i: %q_88: i16, blink_param_y_i: %q_90: i16, phase_ctr_i: %11: i16, phase_ctr_next_i: %12: i16, cycle_end_i: %128: i1, clr_chan_cntr_i: %49: i1, dc_resn_i: %107: i4) -> (pwm_o: i1)
    llhd.drv %50, %gen_chan_insts_5.u_chan.pwm_o after %1 : i1
    %cfg = hw.struct_extract %5["cfg"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
    %cntr_en_91 = hw.struct_extract %cfg["cntr_en"] : !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>
    %qe = hw.struct_extract %cntr_en_91["qe"] : !hw.struct<q: i1, qe: i1>
    %q_92 = hw.struct_extract %cntr_en_91["q"] : !hw.struct<q: i1, qe: i1>
    %51 = llhd.prb %cntr_en_q : i1
    %52 = comb.xor %51, %true : i1
    %53 = comb.and %qe, %q_92, %52 : i1
    llhd.drv %clr_phase_cntr, %53 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb9
      %130 = llhd.prb %clk_core_i_0 : i1
      %131 = llhd.prb %rst_core_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %132 = llhd.prb %clk_core_i_0 : i1
      %133 = comb.xor bin %130, %true : i1
      %134 = comb.and bin %133, %132 : i1
      %135 = llhd.prb %rst_core_ni_1 : i1
      %136 = comb.xor bin %135, %true : i1
      %137 = comb.and bin %131, %136 : i1
      %138 = comb.or bin %134, %137 : i1
      cf.cond_br %138, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %139 = llhd.prb %rst_core_ni_1 : i1
      %140 = comb.xor %139, %true : i1
      cf.cond_br %140, ^bb4, ^bb5(%c0_i32 : i32)
    ^bb4:  // pred: ^bb3
      llhd.drv %pwm_en_q, %c0_i6 after %0 : i6
      llhd.drv %invert_q, %c0_i6 after %0 : i6
      cf.br ^bb1
    ^bb5(%141: i32):  // 2 preds: ^bb3, ^bb8
      %142 = comb.icmp ult %141, %c6_i32 : i32
      cf.cond_br %142, ^bb6, ^bb9(%c0_i32 : i32)
    ^bb6:  // pred: ^bb5
      %143 = llhd.prb %reg2hw_2 : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
      %pwm_en_150 = hw.struct_extract %143["pwm_en"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
      %144 = comb.extract %141 from 3 : (i32) -> i29
      %145 = comb.icmp eq %144, %c0_i29 : i29
      %146 = comb.extract %141 from 0 : (i32) -> i3
      %147 = comb.mux %145, %146, %c-1_i3 : i3
      %148 = hw.array_get %pwm_en_150[%147] : !hw.array<6xstruct<q: i1, qe: i1>>, i3
      %qe_151 = hw.struct_extract %148["qe"] : !hw.struct<q: i1, qe: i1>
      cf.cond_br %qe_151, ^bb7, ^bb8
    ^bb7:  // pred: ^bb6
      %149 = llhd.sig.extract %pwm_en_q from %147 : <i6> -> <i1>
      %150 = llhd.prb %reg2hw_2 : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
      %pwm_en_152 = hw.struct_extract %150["pwm_en"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
      %151 = hw.array_get %pwm_en_152[%147] : !hw.array<6xstruct<q: i1, qe: i1>>, i3
      %q_153 = hw.struct_extract %151["q"] : !hw.struct<q: i1, qe: i1>
      llhd.drv %149, %q_153 after %0 : i1
      cf.br ^bb8
    ^bb8:  // 2 preds: ^bb6, ^bb7
      %152 = comb.add %141, %c1_i32 : i32
      cf.br ^bb5(%152 : i32)
    ^bb9(%153: i32):  // 2 preds: ^bb5, ^bb12
      %154 = comb.icmp ult %153, %c6_i32 : i32
      cf.cond_br %154, ^bb10, ^bb1
    ^bb10:  // pred: ^bb9
      %155 = llhd.prb %reg2hw_2 : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
      %invert_154 = hw.struct_extract %155["invert"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
      %156 = comb.extract %153 from 3 : (i32) -> i29
      %157 = comb.icmp eq %156, %c0_i29 : i29
      %158 = comb.extract %153 from 0 : (i32) -> i3
      %159 = comb.mux %157, %158, %c-1_i3 : i3
      %160 = hw.array_get %invert_154[%159] : !hw.array<6xstruct<q: i1, qe: i1>>, i3
      %qe_155 = hw.struct_extract %160["qe"] : !hw.struct<q: i1, qe: i1>
      cf.cond_br %qe_155, ^bb11, ^bb12
    ^bb11:  // pred: ^bb10
      %161 = llhd.sig.extract %invert_q from %159 : <i6> -> <i1>
      %162 = llhd.prb %reg2hw_2 : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
      %invert_156 = hw.struct_extract %162["invert"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
      %163 = hw.array_get %invert_156[%159] : !hw.array<6xstruct<q: i1, qe: i1>>, i3
      %q_157 = hw.struct_extract %163["q"] : !hw.struct<q: i1, qe: i1>
      llhd.drv %161, %q_157 after %0 : i1
      cf.br ^bb12
    ^bb12:  // 2 preds: ^bb10, ^bb11
      %164 = comb.add %153, %c1_i32 : i32
      cf.br ^bb9(%164 : i32)
    }
    %54 = llhd.sig.extract %clr_chan_cntr from %c0_i3 : <i6> -> <i1>
    %qe_93 = hw.struct_extract %6["qe"] : !hw.struct<q: i1, qe: i1>
    %55 = llhd.prb %pwm_en_q : i6
    %56 = comb.extract %55 from 0 : (i6) -> i1
    %57 = comb.xor %56, %true : i1
    %58 = comb.and %qe_93, %q, %57 : i1
    %qe_94 = hw.struct_extract %7["qe"] : !hw.struct<q: i1, qe: i1>
    %59 = llhd.prb %invert_q : i6
    %60 = comb.extract %59 from 0 : (i6) -> i1
    %61 = comb.xor %q_3, %60 : i1
    %62 = comb.and %qe_94, %61 : i1
    %qe_95 = hw.struct_extract %phase_delay["qe"] : !hw.struct<q: i16, qe: i1>
    %qe_96 = hw.struct_extract %htbt_en["qe"] : !hw.struct<q: i1, qe: i1>
    %qe_97 = hw.struct_extract %blink_en["qe"] : !hw.struct<q: i1, qe: i1>
    %qe_98 = hw.struct_extract %a["qe"] : !hw.struct<q: i16, qe: i1>
    %qe_99 = hw.struct_extract %b["qe"] : !hw.struct<q: i16, qe: i1>
    %qe_100 = hw.struct_extract %x["qe"] : !hw.struct<q: i16, qe: i1>
    %qe_101 = hw.struct_extract %y["qe"] : !hw.struct<q: i16, qe: i1>
    %63 = comb.or %58, %62, %qe_95, %qe_96, %qe_97, %qe_98, %qe_99, %qe_100, %qe_101 : i1
    llhd.drv %54, %63 after %1 : i1
    %64 = llhd.sig.extract %clr_chan_cntr from %c1_i3 : <i6> -> <i1>
    %qe_102 = hw.struct_extract %16["qe"] : !hw.struct<q: i1, qe: i1>
    %65 = comb.extract %55 from 1 : (i6) -> i1
    %66 = comb.xor %65, %true : i1
    %67 = comb.and %qe_102, %q_11, %66 : i1
    %qe_103 = hw.struct_extract %17["qe"] : !hw.struct<q: i1, qe: i1>
    %68 = comb.extract %59 from 1 : (i6) -> i1
    %69 = comb.xor %q_12, %68 : i1
    %70 = comb.and %qe_103, %69 : i1
    %qe_104 = hw.struct_extract %phase_delay_17["qe"] : !hw.struct<q: i16, qe: i1>
    %qe_105 = hw.struct_extract %htbt_en_15["qe"] : !hw.struct<q: i1, qe: i1>
    %qe_106 = hw.struct_extract %blink_en_13["qe"] : !hw.struct<q: i1, qe: i1>
    %qe_107 = hw.struct_extract %a_19["qe"] : !hw.struct<q: i16, qe: i1>
    %qe_108 = hw.struct_extract %b_21["qe"] : !hw.struct<q: i16, qe: i1>
    %qe_109 = hw.struct_extract %x_23["qe"] : !hw.struct<q: i16, qe: i1>
    %qe_110 = hw.struct_extract %y_25["qe"] : !hw.struct<q: i16, qe: i1>
    %71 = comb.or %67, %70, %qe_104, %qe_105, %qe_106, %qe_107, %qe_108, %qe_109, %qe_110 : i1
    llhd.drv %64, %71 after %1 : i1
    %72 = llhd.sig.extract %clr_chan_cntr from %c2_i3 : <i6> -> <i1>
    %qe_111 = hw.struct_extract %23["qe"] : !hw.struct<q: i1, qe: i1>
    %73 = comb.extract %55 from 2 : (i6) -> i1
    %74 = comb.xor %73, %true : i1
    %75 = comb.and %qe_111, %q_27, %74 : i1
    %qe_112 = hw.struct_extract %24["qe"] : !hw.struct<q: i1, qe: i1>
    %76 = comb.extract %59 from 2 : (i6) -> i1
    %77 = comb.xor %q_28, %76 : i1
    %78 = comb.and %qe_112, %77 : i1
    %qe_113 = hw.struct_extract %phase_delay_33["qe"] : !hw.struct<q: i16, qe: i1>
    %qe_114 = hw.struct_extract %htbt_en_31["qe"] : !hw.struct<q: i1, qe: i1>
    %qe_115 = hw.struct_extract %blink_en_29["qe"] : !hw.struct<q: i1, qe: i1>
    %qe_116 = hw.struct_extract %a_35["qe"] : !hw.struct<q: i16, qe: i1>
    %qe_117 = hw.struct_extract %b_37["qe"] : !hw.struct<q: i16, qe: i1>
    %qe_118 = hw.struct_extract %x_39["qe"] : !hw.struct<q: i16, qe: i1>
    %qe_119 = hw.struct_extract %y_41["qe"] : !hw.struct<q: i16, qe: i1>
    %79 = comb.or %75, %78, %qe_113, %qe_114, %qe_115, %qe_116, %qe_117, %qe_118, %qe_119 : i1
    llhd.drv %72, %79 after %1 : i1
    %80 = llhd.sig.extract %clr_chan_cntr from %c3_i3 : <i6> -> <i1>
    %qe_120 = hw.struct_extract %30["qe"] : !hw.struct<q: i1, qe: i1>
    %81 = comb.extract %55 from 3 : (i6) -> i1
    %82 = comb.xor %81, %true : i1
    %83 = comb.and %qe_120, %q_43, %82 : i1
    %qe_121 = hw.struct_extract %31["qe"] : !hw.struct<q: i1, qe: i1>
    %84 = comb.extract %59 from 3 : (i6) -> i1
    %85 = comb.xor %q_44, %84 : i1
    %86 = comb.and %qe_121, %85 : i1
    %qe_122 = hw.struct_extract %phase_delay_49["qe"] : !hw.struct<q: i16, qe: i1>
    %qe_123 = hw.struct_extract %htbt_en_47["qe"] : !hw.struct<q: i1, qe: i1>
    %qe_124 = hw.struct_extract %blink_en_45["qe"] : !hw.struct<q: i1, qe: i1>
    %qe_125 = hw.struct_extract %a_51["qe"] : !hw.struct<q: i16, qe: i1>
    %qe_126 = hw.struct_extract %b_53["qe"] : !hw.struct<q: i16, qe: i1>
    %qe_127 = hw.struct_extract %x_55["qe"] : !hw.struct<q: i16, qe: i1>
    %qe_128 = hw.struct_extract %y_57["qe"] : !hw.struct<q: i16, qe: i1>
    %87 = comb.or %83, %86, %qe_122, %qe_123, %qe_124, %qe_125, %qe_126, %qe_127, %qe_128 : i1
    llhd.drv %80, %87 after %1 : i1
    %88 = llhd.sig.extract %clr_chan_cntr from %c-4_i3 : <i6> -> <i1>
    %qe_129 = hw.struct_extract %37["qe"] : !hw.struct<q: i1, qe: i1>
    %89 = comb.extract %55 from 4 : (i6) -> i1
    %90 = comb.xor %89, %true : i1
    %91 = comb.and %qe_129, %q_59, %90 : i1
    %qe_130 = hw.struct_extract %38["qe"] : !hw.struct<q: i1, qe: i1>
    %92 = comb.extract %59 from 4 : (i6) -> i1
    %93 = comb.xor %q_60, %92 : i1
    %94 = comb.and %qe_130, %93 : i1
    %qe_131 = hw.struct_extract %phase_delay_65["qe"] : !hw.struct<q: i16, qe: i1>
    %qe_132 = hw.struct_extract %htbt_en_63["qe"] : !hw.struct<q: i1, qe: i1>
    %qe_133 = hw.struct_extract %blink_en_61["qe"] : !hw.struct<q: i1, qe: i1>
    %qe_134 = hw.struct_extract %a_67["qe"] : !hw.struct<q: i16, qe: i1>
    %qe_135 = hw.struct_extract %b_69["qe"] : !hw.struct<q: i16, qe: i1>
    %qe_136 = hw.struct_extract %x_71["qe"] : !hw.struct<q: i16, qe: i1>
    %qe_137 = hw.struct_extract %y_73["qe"] : !hw.struct<q: i16, qe: i1>
    %95 = comb.or %91, %94, %qe_131, %qe_132, %qe_133, %qe_134, %qe_135, %qe_136, %qe_137 : i1
    llhd.drv %88, %95 after %1 : i1
    %96 = llhd.sig.extract %clr_chan_cntr from %c-3_i3 : <i6> -> <i1>
    %qe_138 = hw.struct_extract %44["qe"] : !hw.struct<q: i1, qe: i1>
    %97 = comb.extract %55 from 5 : (i6) -> i1
    %98 = comb.xor %97, %true : i1
    %99 = comb.and %qe_138, %q_75, %98 : i1
    %qe_139 = hw.struct_extract %45["qe"] : !hw.struct<q: i1, qe: i1>
    %100 = comb.extract %59 from 5 : (i6) -> i1
    %101 = comb.xor %q_76, %100 : i1
    %102 = comb.and %qe_139, %101 : i1
    %qe_140 = hw.struct_extract %phase_delay_81["qe"] : !hw.struct<q: i16, qe: i1>
    %qe_141 = hw.struct_extract %htbt_en_79["qe"] : !hw.struct<q: i1, qe: i1>
    %qe_142 = hw.struct_extract %blink_en_77["qe"] : !hw.struct<q: i1, qe: i1>
    %qe_143 = hw.struct_extract %a_83["qe"] : !hw.struct<q: i16, qe: i1>
    %qe_144 = hw.struct_extract %b_85["qe"] : !hw.struct<q: i16, qe: i1>
    %qe_145 = hw.struct_extract %x_87["qe"] : !hw.struct<q: i16, qe: i1>
    %qe_146 = hw.struct_extract %y_89["qe"] : !hw.struct<q: i16, qe: i1>
    %103 = comb.or %99, %102, %qe_140, %qe_141, %qe_142, %qe_143, %qe_144, %qe_145, %qe_146 : i1
    llhd.drv %96, %103 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb7, ^bb8
      %130 = llhd.prb %clk_core_i_0 : i1
      %131 = llhd.prb %rst_core_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %132 = llhd.prb %clk_core_i_0 : i1
      %133 = comb.xor bin %130, %true : i1
      %134 = comb.and bin %133, %132 : i1
      %135 = llhd.prb %rst_core_ni_1 : i1
      %136 = comb.xor bin %135, %true : i1
      %137 = comb.and bin %131, %136 : i1
      %138 = comb.or bin %134, %137 : i1
      cf.cond_br %138, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %139 = llhd.prb %rst_core_ni_1 : i1
      %140 = comb.xor %139, %true : i1
      cf.cond_br %140, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %cntr_en_q, %false after %0 : i1
      llhd.drv %clk_div_q, %c0_i27 after %0 : i27
      llhd.drv %dc_resn_q, %c0_i4 after %0 : i4
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %141 = llhd.prb %reg2hw_2 : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
      %cfg_150 = hw.struct_extract %141["cfg"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
      %cntr_en_151 = hw.struct_extract %cfg_150["cntr_en"] : !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>
      %qe_152 = hw.struct_extract %cntr_en_151["qe"] : !hw.struct<q: i1, qe: i1>
      cf.cond_br %qe_152, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %142 = llhd.prb %reg2hw_2 : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
      %cfg_153 = hw.struct_extract %142["cfg"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
      %cntr_en_154 = hw.struct_extract %cfg_153["cntr_en"] : !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>
      %q_155 = hw.struct_extract %cntr_en_154["q"] : !hw.struct<q: i1, qe: i1>
      llhd.drv %cntr_en_q, %q_155 after %0 : i1
      cf.br ^bb7
    ^bb7:  // 2 preds: ^bb5, ^bb6
      %143 = llhd.prb %clr_phase_cntr : i1
      cf.cond_br %143, ^bb8, ^bb1
    ^bb8:  // pred: ^bb7
      %144 = llhd.prb %reg2hw_2 : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
      %cfg_156 = hw.struct_extract %144["cfg"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
      %clk_div_157 = hw.struct_extract %cfg_156["clk_div"] : !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>
      %q_158 = hw.struct_extract %clk_div_157["q"] : !hw.struct<q: i27, qe: i1>
      llhd.drv %clk_div_q, %q_158 after %0 : i27
      %145 = llhd.prb %reg2hw_2 : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
      %cfg_159 = hw.struct_extract %145["cfg"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
      %dc_resn_160 = hw.struct_extract %cfg_159["dc_resn"] : !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>
      %q_161 = hw.struct_extract %dc_resn_160["q"] : !hw.struct<q: i4, qe: i1>
      llhd.drv %dc_resn_q, %q_161 after %0 : i4
      cf.br ^bb1
    }
    %104 = comb.mux %qe, %q_92, %51 : i1
    llhd.drv %cntr_en, %104 after %1 : i1
    %105 = llhd.prb %clr_phase_cntr : i1
    %dc_resn = hw.struct_extract %cfg["dc_resn"] : !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>
    %q_147 = hw.struct_extract %dc_resn["q"] : !hw.struct<q: i4, qe: i1>
    %106 = llhd.prb %dc_resn_q : i4
    %107 = comb.mux %105, %q_147, %106 {sv.namehint = "dc_resn"} : i4
    %clk_div_148 = hw.struct_extract %cfg["clk_div"] : !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>
    %q_149 = hw.struct_extract %clk_div_148["q"] : !hw.struct<q: i27, qe: i1>
    %108 = llhd.prb %clk_div_q : i27
    %109 = comb.mux %105, %q_149, %108 : i27
    llhd.drv %clk_div, %109 after %1 : i27
    %110 = llhd.prb %beat_ctr_q : i27
    %111 = llhd.prb %clk_div : i27
    %112 = comb.icmp eq %110, %111 {sv.namehint = "beat_end"} : i27
    %113 = comb.add %110, %c1_i27 : i27
    %114 = comb.or %105, %112 : i1
    %115 = comb.mux %114, %c0_i27, %113 : i27
    llhd.drv %beat_ctr_d, %115 after %1 : i27
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %130 = llhd.prb %clk_core_i_0 : i1
      %131 = llhd.prb %rst_core_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %132 = llhd.prb %clk_core_i_0 : i1
      %133 = comb.xor bin %130, %true : i1
      %134 = comb.and bin %133, %132 : i1
      %135 = llhd.prb %rst_core_ni_1 : i1
      %136 = comb.xor bin %135, %true : i1
      %137 = comb.and bin %131, %136 : i1
      %138 = comb.or bin %134, %137 : i1
      cf.cond_br %138, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %139 = llhd.prb %rst_core_ni_1 : i1
      %140 = comb.xor %139, %true : i1
      cf.cond_br %140, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %beat_ctr_q, %c0_i27 after %0 : i27
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %141 = llhd.prb %cntr_en : i1
      cf.cond_br %141, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      %142 = llhd.prb %beat_ctr_d : i27
      llhd.drv %beat_ctr_q, %142 after %0 : i27
      cf.br ^bb1
    }
    %116 = comb.sub %c-1_i4, %107 {sv.namehint = "lshift"} : i4
    %117 = llhd.prb %cntr_en : i1
    %118 = comb.and %112, %117 : i1
    %119 = comb.or %105, %118 : i1
    llhd.drv %phase_ctr_en, %119 after %1 : i1
    %120 = comb.concat %c0_i12, %116 : i12, i4
    %121 = comb.shl %c1_i16, %120 {sv.namehint = "phase_ctr_incr"} : i16
    %122 = comb.concat %false, %11 : i1, i16
    %123 = comb.concat %false, %121 : i1, i16
    %124 = comb.add %122, %123 : i17
    %125 = comb.extract %124 from 16 {sv.namehint = "phase_ctr_overflow"} : (i17) -> i1
    %126 = comb.extract %124 from 0 : (i17) -> i16
    llhd.drv %phase_ctr_next, %126 after %1 : i16
    %127 = comb.mux %105, %c0_i16, %12 : i16
    llhd.drv %phase_ctr_d, %127 after %1 : i16
    %128 = comb.and %112, %125 {sv.namehint = "cycle_end"} : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 4 preds: ^bb0, ^bb2, ^bb4, ^bb5
      %130 = llhd.prb %clk_core_i_0 : i1
      %131 = llhd.prb %rst_core_ni_1 : i1
      llhd.wait (%3, %4 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %132 = llhd.prb %clk_core_i_0 : i1
      %133 = comb.xor bin %130, %true : i1
      %134 = comb.and bin %133, %132 : i1
      %135 = llhd.prb %rst_core_ni_1 : i1
      %136 = comb.xor bin %135, %true : i1
      %137 = comb.and bin %131, %136 : i1
      %138 = comb.or bin %134, %137 : i1
      cf.cond_br %138, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %139 = llhd.prb %rst_core_ni_1 : i1
      %140 = comb.xor %139, %true : i1
      cf.cond_br %140, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %phase_ctr_q, %c0_i16 after %0 : i16
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %141 = llhd.prb %phase_ctr_en : i1
      %142 = llhd.prb %phase_ctr_d : i16
      %143 = llhd.prb %phase_ctr_q : i16
      %144 = comb.mux %141, %142, %143 : i16
      llhd.drv %phase_ctr_q, %144 after %0 : i16
      cf.br ^bb1
    }
    llhd.drv %clk_core_i_0, %clk_core_i after %1 : i1
    llhd.drv %rst_core_ni_1, %rst_core_ni after %1 : i1
    llhd.drv %reg2hw_2, %reg2hw after %1 : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
    %129 = llhd.prb %pwm_o : i6
    hw.output %129 : i6
  }
  hw.module private @pwm_reg_top(in %clk_i : i1, in %rst_ni : i1, in %clk_core_i : i1, in %rst_core_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, out reg2hw : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>, in %racl_policies_i : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, out racl_error_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, out intg_err_o : i1) {
    %c-1_i4 = hw.constant -1 : i4
    %c0_i26 = hw.constant 0 : i26
    %c0_i25 = hw.constant 0 : i25
    %c-10_i5 = hw.constant -10 : i5
    %c-11_i5 = hw.constant -11 : i5
    %c-12_i5 = hw.constant -12 : i5
    %c-13_i5 = hw.constant -13 : i5
    %c-14_i5 = hw.constant -14 : i5
    %c-15_i5 = hw.constant -15 : i5
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
    %c-16_i5 = hw.constant -16 : i5
    %c-2_i5 = hw.constant -2 : i5
    %c-1_i5 = hw.constant -1 : i5
    %c-5_i5 = hw.constant -5 : i5
    %c0_i5 = hw.constant 0 : i5
    %0 = llhd.constant_time <0ns, 1d, 0e>
    %c-1_i2 = hw.constant -1 : i2
    %c-3_i3 = hw.constant -3 : i3
    %c-4_i3 = hw.constant -4 : i3
    %c3_i3 = hw.constant 3 : i3
    %c2_i3 = hw.constant 2 : i3
    %c1_i3 = hw.constant 1 : i3
    %c-1_i6 = hw.constant -1 : i6
    %c-2_i2 = hw.constant -2 : i2
    %c1_i2 = hw.constant 1 : i2
    %c-1_i3 = hw.constant -1 : i3
    %1 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i3 = hw.constant 0 : i3
    %2 = hw.aggregate_constant [false, false, false, false, false, 0 : i32] : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %3 = hw.aggregate_constant [[0 : i2, 0 : i2]] : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    %4 = hw.aggregate_constant [[false, false], [[false, false], [0 : i4, false], [0 : i27, false]], [[false, false], [false, false], [false, false], [false, false], [false, false], [false, false]], [[false, false], [false, false], [false, false], [false, false], [false, false], [false, false]], [[[false, false], [false, false], [0 : i16, false]], [[false, false], [false, false], [0 : i16, false]], [[false, false], [false, false], [0 : i16, false]], [[false, false], [false, false], [0 : i16, false]], [[false, false], [false, false], [0 : i16, false]], [[false, false], [false, false], [0 : i16, false]]], [[[0 : i16, false], [0 : i16, false]], [[0 : i16, false], [0 : i16, false]], [[0 : i16, false], [0 : i16, false]], [[0 : i16, false], [0 : i16, false]], [[0 : i16, false], [0 : i16, false]], [[0 : i16, false], [0 : i16, false]]], [[[0 : i16, false], [0 : i16, false]], [[0 : i16, false], [0 : i16, false]], [[0 : i16, false], [0 : i16, false]], [[0 : i16, false], [0 : i16, false]], [[0 : i16, false], [0 : i16, false]], [[0 : i16, false], [0 : i16, false]]]] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
    %c-1_i32 = hw.constant -1 : i32
    %c0_i32 = hw.constant 0 : i32
    %false = hw.constant false {sv.namehint = "racl_role"}
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
    %c0_i23 = hw.constant 0 : i23
    %c0_i2 = hw.constant 0 : i2
    %c2147450879_i32 = hw.constant 2147450879 : i32
    %c939556864_i32 = hw.constant 939556864 : i32
    %true = hw.constant true
    %c0_i16 = hw.constant 0 : i16
    %c0_i4 = hw.constant 0 : i4
    %c0_i27 = hw.constant 0 : i27
    %c0_i6 = hw.constant 0 : i6
    %c-7_i4 = hw.constant -7 : i4
    %clk_i_0 = llhd.sig name "clk_i" %false : i1
    %5 = llhd.prb %clk_i_0 : i1
    %rst_ni_1 = llhd.sig name "rst_ni" %false : i1
    %6 = llhd.prb %rst_ni_1 : i1
    %reg2hw = llhd.sig %4 : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
    %racl_policies_i_2 = llhd.sig name "racl_policies_i" %3 : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    %racl_error_o = llhd.sig %2 : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %reg_we = llhd.sig %false : i1
    %reg_addr = llhd.sig %c0_i7 : i7
    %reg_be = llhd.sig %c0_i4 : i4
    %wr_err = llhd.sig %false : i1
    %reg_rdata_next = llhd.sig %c0_i32 : i32
    %intg_err = llhd.sig %false : i1
    %reg_we_err = llhd.sig %false : i1
    %reg_we_check = llhd.sig %c0_i23 : i23
    %err_q = llhd.sig %false : i1
    %alert_test_we = llhd.sig %false : i1
    %regwen_we = llhd.sig %false : i1
    %regwen_qs = llhd.sig %false : i1
    %cfg_we = llhd.sig %false : i1
    %cfg_qs = llhd.sig %c0_i32 : i32
    %cfg_busy = llhd.sig %false : i1
    %pwm_en_we = llhd.sig %false : i1
    %pwm_en_qs = llhd.sig %c0_i6 : i6
    %pwm_en_busy = llhd.sig %false : i1
    %invert_we = llhd.sig %false : i1
    %invert_qs = llhd.sig %c0_i6 : i6
    %invert_busy = llhd.sig %false : i1
    %pwm_param_0_we = llhd.sig %false : i1
    %pwm_param_0_qs = llhd.sig %c0_i32 : i32
    %pwm_param_0_busy = llhd.sig %false : i1
    %pwm_param_1_we = llhd.sig %false : i1
    %pwm_param_1_qs = llhd.sig %c0_i32 : i32
    %pwm_param_1_busy = llhd.sig %false : i1
    %pwm_param_2_we = llhd.sig %false : i1
    %pwm_param_2_qs = llhd.sig %c0_i32 : i32
    %pwm_param_2_busy = llhd.sig %false : i1
    %pwm_param_3_we = llhd.sig %false : i1
    %pwm_param_3_qs = llhd.sig %c0_i32 : i32
    %pwm_param_3_busy = llhd.sig %false : i1
    %pwm_param_4_we = llhd.sig %false : i1
    %pwm_param_4_qs = llhd.sig %c0_i32 : i32
    %pwm_param_4_busy = llhd.sig %false : i1
    %pwm_param_5_we = llhd.sig %false : i1
    %pwm_param_5_qs = llhd.sig %c0_i32 : i32
    %pwm_param_5_busy = llhd.sig %false : i1
    %duty_cycle_0_we = llhd.sig %false : i1
    %duty_cycle_0_qs = llhd.sig %c0_i32 : i32
    %duty_cycle_0_busy = llhd.sig %false : i1
    %duty_cycle_1_we = llhd.sig %false : i1
    %duty_cycle_1_qs = llhd.sig %c0_i32 : i32
    %duty_cycle_1_busy = llhd.sig %false : i1
    %duty_cycle_2_we = llhd.sig %false : i1
    %duty_cycle_2_qs = llhd.sig %c0_i32 : i32
    %duty_cycle_2_busy = llhd.sig %false : i1
    %duty_cycle_3_we = llhd.sig %false : i1
    %duty_cycle_3_qs = llhd.sig %c0_i32 : i32
    %duty_cycle_3_busy = llhd.sig %false : i1
    %duty_cycle_4_we = llhd.sig %false : i1
    %duty_cycle_4_qs = llhd.sig %c0_i32 : i32
    %duty_cycle_4_busy = llhd.sig %false : i1
    %duty_cycle_5_we = llhd.sig %false : i1
    %duty_cycle_5_qs = llhd.sig %c0_i32 : i32
    %duty_cycle_5_busy = llhd.sig %false : i1
    %blink_param_0_we = llhd.sig %false : i1
    %blink_param_0_qs = llhd.sig %c0_i32 : i32
    %blink_param_0_busy = llhd.sig %false : i1
    %blink_param_1_we = llhd.sig %false : i1
    %blink_param_1_qs = llhd.sig %c0_i32 : i32
    %blink_param_1_busy = llhd.sig %false : i1
    %blink_param_2_we = llhd.sig %false : i1
    %blink_param_2_qs = llhd.sig %c0_i32 : i32
    %blink_param_2_busy = llhd.sig %false : i1
    %blink_param_3_we = llhd.sig %false : i1
    %blink_param_3_qs = llhd.sig %c0_i32 : i32
    %blink_param_3_busy = llhd.sig %false : i1
    %blink_param_4_we = llhd.sig %false : i1
    %blink_param_4_qs = llhd.sig %c0_i32 : i32
    %blink_param_4_busy = llhd.sig %false : i1
    %blink_param_5_we = llhd.sig %false : i1
    %blink_param_5_qs = llhd.sig %c0_i32 : i32
    %blink_param_5_busy = llhd.sig %false : i1
    %core_cfg_clk_div_qs_int = llhd.sig %c0_i27 : i27
    %core_cfg_dc_resn_qs_int = llhd.sig %c0_i4 : i4
    %core_cfg_cntr_en_qs_int = llhd.sig %false : i1
    %core_cfg_qs = llhd.sig %c0_i32 : i32
    %core_pwm_en_en_0_qs_int = llhd.sig %false : i1
    %core_pwm_en_en_1_qs_int = llhd.sig %false : i1
    %core_pwm_en_en_2_qs_int = llhd.sig %false : i1
    %core_pwm_en_en_3_qs_int = llhd.sig %false : i1
    %core_pwm_en_en_4_qs_int = llhd.sig %false : i1
    %core_pwm_en_en_5_qs_int = llhd.sig %false : i1
    %core_pwm_en_qs = llhd.sig %c0_i6 : i6
    %core_invert_invert_0_qs_int = llhd.sig %false : i1
    %core_invert_invert_1_qs_int = llhd.sig %false : i1
    %core_invert_invert_2_qs_int = llhd.sig %false : i1
    %core_invert_invert_3_qs_int = llhd.sig %false : i1
    %core_invert_invert_4_qs_int = llhd.sig %false : i1
    %core_invert_invert_5_qs_int = llhd.sig %false : i1
    %core_invert_qs = llhd.sig %c0_i6 : i6
    %core_pwm_param_0_phase_delay_0_qs_int = llhd.sig %c0_i16 : i16
    %core_pwm_param_0_htbt_en_0_qs_int = llhd.sig %false : i1
    %core_pwm_param_0_blink_en_0_qs_int = llhd.sig %false : i1
    %core_pwm_param_0_qs = llhd.sig %c0_i32 : i32
    %core_pwm_param_1_phase_delay_1_qs_int = llhd.sig %c0_i16 : i16
    %core_pwm_param_1_htbt_en_1_qs_int = llhd.sig %false : i1
    %core_pwm_param_1_blink_en_1_qs_int = llhd.sig %false : i1
    %core_pwm_param_1_qs = llhd.sig %c0_i32 : i32
    %core_pwm_param_2_phase_delay_2_qs_int = llhd.sig %c0_i16 : i16
    %core_pwm_param_2_htbt_en_2_qs_int = llhd.sig %false : i1
    %core_pwm_param_2_blink_en_2_qs_int = llhd.sig %false : i1
    %core_pwm_param_2_qs = llhd.sig %c0_i32 : i32
    %core_pwm_param_3_phase_delay_3_qs_int = llhd.sig %c0_i16 : i16
    %core_pwm_param_3_htbt_en_3_qs_int = llhd.sig %false : i1
    %core_pwm_param_3_blink_en_3_qs_int = llhd.sig %false : i1
    %core_pwm_param_3_qs = llhd.sig %c0_i32 : i32
    %core_pwm_param_4_phase_delay_4_qs_int = llhd.sig %c0_i16 : i16
    %core_pwm_param_4_htbt_en_4_qs_int = llhd.sig %false : i1
    %core_pwm_param_4_blink_en_4_qs_int = llhd.sig %false : i1
    %core_pwm_param_4_qs = llhd.sig %c0_i32 : i32
    %core_pwm_param_5_phase_delay_5_qs_int = llhd.sig %c0_i16 : i16
    %core_pwm_param_5_htbt_en_5_qs_int = llhd.sig %false : i1
    %core_pwm_param_5_blink_en_5_qs_int = llhd.sig %false : i1
    %core_pwm_param_5_qs = llhd.sig %c0_i32 : i32
    %core_duty_cycle_0_a_0_qs_int = llhd.sig %c0_i16 : i16
    %core_duty_cycle_0_b_0_qs_int = llhd.sig %c0_i16 : i16
    %core_duty_cycle_0_qs = llhd.sig %c0_i32 : i32
    %core_duty_cycle_1_a_1_qs_int = llhd.sig %c0_i16 : i16
    %core_duty_cycle_1_b_1_qs_int = llhd.sig %c0_i16 : i16
    %core_duty_cycle_1_qs = llhd.sig %c0_i32 : i32
    %core_duty_cycle_2_a_2_qs_int = llhd.sig %c0_i16 : i16
    %core_duty_cycle_2_b_2_qs_int = llhd.sig %c0_i16 : i16
    %core_duty_cycle_2_qs = llhd.sig %c0_i32 : i32
    %core_duty_cycle_3_a_3_qs_int = llhd.sig %c0_i16 : i16
    %core_duty_cycle_3_b_3_qs_int = llhd.sig %c0_i16 : i16
    %core_duty_cycle_3_qs = llhd.sig %c0_i32 : i32
    %core_duty_cycle_4_a_4_qs_int = llhd.sig %c0_i16 : i16
    %core_duty_cycle_4_b_4_qs_int = llhd.sig %c0_i16 : i16
    %core_duty_cycle_4_qs = llhd.sig %c0_i32 : i32
    %core_duty_cycle_5_a_5_qs_int = llhd.sig %c0_i16 : i16
    %core_duty_cycle_5_b_5_qs_int = llhd.sig %c0_i16 : i16
    %core_duty_cycle_5_qs = llhd.sig %c0_i32 : i32
    %core_blink_param_0_x_0_qs_int = llhd.sig %c0_i16 : i16
    %core_blink_param_0_y_0_qs_int = llhd.sig %c0_i16 : i16
    %core_blink_param_0_qs = llhd.sig %c0_i32 : i32
    %core_blink_param_1_x_1_qs_int = llhd.sig %c0_i16 : i16
    %core_blink_param_1_y_1_qs_int = llhd.sig %c0_i16 : i16
    %core_blink_param_1_qs = llhd.sig %c0_i32 : i32
    %core_blink_param_2_x_2_qs_int = llhd.sig %c0_i16 : i16
    %core_blink_param_2_y_2_qs_int = llhd.sig %c0_i16 : i16
    %core_blink_param_2_qs = llhd.sig %c0_i32 : i32
    %core_blink_param_3_x_3_qs_int = llhd.sig %c0_i16 : i16
    %core_blink_param_3_y_3_qs_int = llhd.sig %c0_i16 : i16
    %core_blink_param_3_qs = llhd.sig %c0_i32 : i32
    %core_blink_param_4_x_4_qs_int = llhd.sig %c0_i16 : i16
    %core_blink_param_4_y_4_qs_int = llhd.sig %c0_i16 : i16
    %core_blink_param_4_qs = llhd.sig %c0_i32 : i32
    %core_blink_param_5_x_5_qs_int = llhd.sig %c0_i16 : i16
    %core_blink_param_5_y_5_qs_int = llhd.sig %c0_i16 : i16
    %core_blink_param_5_qs = llhd.sig %c0_i32 : i32
    %alert_test_flds_we = llhd.sig %false : i1
    %cfg_flds_we = llhd.sig %c0_i3 : i3
    %pwm_en_flds_we = llhd.sig %c0_i6 : i6
    %invert_flds_we = llhd.sig %c0_i6 : i6
    %pwm_param_0_flds_we = llhd.sig %c0_i3 : i3
    %pwm_param_1_flds_we = llhd.sig %c0_i3 : i3
    %pwm_param_2_flds_we = llhd.sig %c0_i3 : i3
    %pwm_param_3_flds_we = llhd.sig %c0_i3 : i3
    %pwm_param_4_flds_we = llhd.sig %c0_i3 : i3
    %pwm_param_5_flds_we = llhd.sig %c0_i3 : i3
    %duty_cycle_0_flds_we = llhd.sig %c0_i2 : i2
    %duty_cycle_1_flds_we = llhd.sig %c0_i2 : i2
    %duty_cycle_2_flds_we = llhd.sig %c0_i2 : i2
    %duty_cycle_3_flds_we = llhd.sig %c0_i2 : i2
    %duty_cycle_4_flds_we = llhd.sig %c0_i2 : i2
    %duty_cycle_5_flds_we = llhd.sig %c0_i2 : i2
    %blink_param_0_flds_we = llhd.sig %c0_i2 : i2
    %blink_param_1_flds_we = llhd.sig %c0_i2 : i2
    %blink_param_2_flds_we = llhd.sig %c0_i2 : i2
    %blink_param_3_flds_we = llhd.sig %c0_i2 : i2
    %blink_param_4_flds_we = llhd.sig %c0_i2 : i2
    %blink_param_5_flds_we = llhd.sig %c0_i2 : i2
    %addr_hit = llhd.sig %c0_i23 : i23
    %racl_role_vec = llhd.sig %c0_i2 : i2
    %racl_addr_hit_read = llhd.sig %c0_i23 : i23
    %racl_addr_hit_write = llhd.sig %c0_i23 : i23
    %reg_busy_sel = llhd.sig %false : i1
    %u_chk.err_o = hw.instance "u_chk" @tlul_cmd_intg_chk(tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>) -> (err_o: i1)
    llhd.drv %intg_err, %u_chk.err_o after %1 : i1
    %7 = llhd.prb %reg_we_check : i23
    %8 = llhd.prb %reg_we : i1
    %9 = comb.xor %507, %true : i1
    %10 = comb.and %8, %9 : i1
    %u_prim_reg_we_check.err_o = hw.instance "u_prim_reg_we_check" @prim_reg_we_check(clk_i: %5: i1, rst_ni: %6: i1, oh_i: %7: i23, en_i: %10: i1) -> (err_o: i1)
    llhd.drv %reg_we_err, %u_prim_reg_we_check.err_o after %1 : i1
    %u_rsp_intg_gen.tl_o = hw.instance "u_rsp_intg_gen" @tlul_rsp_intg_gen(tl_i: %u_reg_if.tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>)
    %11 = llhd.prb %racl_error_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>
    %u_reg_if.tl_o, %u_reg_if.intg_error_o, %u_reg_if.re_o, %u_reg_if.we_o, %u_reg_if.addr_o, %u_reg_if.wdata_o, %u_reg_if.be_o = hw.instance "u_reg_if" @tlul_adapter_reg(clk_i: %5: i1, rst_ni: %6: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, en_ifetch_i: %c-7_i4: i4, busy_i: %592: i1, rdata_i: %358: i32, error_i: %360: i1) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, intg_error_o: i1, re_o: i1, we_o: i1, addr_o: i7, wdata_o: i32, be_o: i4) {sv.namehint = "reg_re"}
    llhd.drv %reg_we, %u_reg_if.we_o after %1 : i1
    llhd.drv %reg_addr, %u_reg_if.addr_o after %1 : i7
    llhd.drv %reg_be, %u_reg_if.be_o after %1 : i4
    %12 = llhd.prb %regwen_qs : i1
    %13 = llhd.prb %cfg_we : i1
    %14 = llhd.prb %core_cfg_qs : i32
    %u_cfg_cdc.src_busy_o, %u_cfg_cdc.src_qs_o, %u_cfg_cdc.dst_we_o, %u_cfg_cdc.dst_re_o, %u_cfg_cdc.dst_regwen_o, %u_cfg_cdc.dst_wd_o = hw.instance "u_cfg_cdc" @prim_reg_cdc(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_core_i: i1, rst_dst_ni: %rst_core_ni: i1, src_regwen_i: %12: i1, src_we_i: %13: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %14: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "core_cfg_we"}
    llhd.drv %cfg_busy, %u_cfg_cdc.src_busy_o after %1 : i1
    llhd.drv %cfg_qs, %u_cfg_cdc.src_qs_o after %1 : i32
    %15 = llhd.prb %pwm_en_we : i1
    %16 = comb.extract %u_reg_if.wdata_o from 0 : (i32) -> i6
    %17 = llhd.prb %core_pwm_en_qs : i6
    %u_pwm_en_cdc.src_busy_o, %u_pwm_en_cdc.src_qs_o, %u_pwm_en_cdc.dst_we_o, %u_pwm_en_cdc.dst_re_o, %u_pwm_en_cdc.dst_regwen_o, %u_pwm_en_cdc.dst_wd_o = hw.instance "u_pwm_en_cdc" @prim_reg_cdc_0(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_core_i: i1, rst_dst_ni: %rst_core_ni: i1, src_regwen_i: %12: i1, src_we_i: %15: i1, src_re_i: %false: i1, src_wd_i: %16: i6, dst_ds_i: %c0_i6: i6, dst_qs_i: %17: i6, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i6, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i6) {sv.namehint = "core_pwm_en_we"}
    llhd.drv %pwm_en_busy, %u_pwm_en_cdc.src_busy_o after %1 : i1
    llhd.drv %pwm_en_qs, %u_pwm_en_cdc.src_qs_o after %1 : i6
    %18 = llhd.prb %invert_we : i1
    %19 = llhd.prb %core_invert_qs : i6
    %u_invert_cdc.src_busy_o, %u_invert_cdc.src_qs_o, %u_invert_cdc.dst_we_o, %u_invert_cdc.dst_re_o, %u_invert_cdc.dst_regwen_o, %u_invert_cdc.dst_wd_o = hw.instance "u_invert_cdc" @prim_reg_cdc_0(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_core_i: i1, rst_dst_ni: %rst_core_ni: i1, src_regwen_i: %12: i1, src_we_i: %18: i1, src_re_i: %false: i1, src_wd_i: %16: i6, dst_ds_i: %c0_i6: i6, dst_qs_i: %19: i6, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i6, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i6) {sv.namehint = "core_invert_we"}
    llhd.drv %invert_busy, %u_invert_cdc.src_busy_o after %1 : i1
    llhd.drv %invert_qs, %u_invert_cdc.src_qs_o after %1 : i6
    %20 = llhd.prb %pwm_param_0_we : i1
    %21 = llhd.prb %core_pwm_param_0_qs : i32
    %u_pwm_param_0_cdc.src_busy_o, %u_pwm_param_0_cdc.src_qs_o, %u_pwm_param_0_cdc.dst_we_o, %u_pwm_param_0_cdc.dst_re_o, %u_pwm_param_0_cdc.dst_regwen_o, %u_pwm_param_0_cdc.dst_wd_o = hw.instance "u_pwm_param_0_cdc" @prim_reg_cdc_1(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_core_i: i1, rst_dst_ni: %rst_core_ni: i1, src_regwen_i: %12: i1, src_we_i: %20: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %21: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "core_pwm_param_0_we"}
    llhd.drv %pwm_param_0_busy, %u_pwm_param_0_cdc.src_busy_o after %1 : i1
    llhd.drv %pwm_param_0_qs, %u_pwm_param_0_cdc.src_qs_o after %1 : i32
    %22 = llhd.prb %pwm_param_1_we : i1
    %23 = llhd.prb %core_pwm_param_1_qs : i32
    %u_pwm_param_1_cdc.src_busy_o, %u_pwm_param_1_cdc.src_qs_o, %u_pwm_param_1_cdc.dst_we_o, %u_pwm_param_1_cdc.dst_re_o, %u_pwm_param_1_cdc.dst_regwen_o, %u_pwm_param_1_cdc.dst_wd_o = hw.instance "u_pwm_param_1_cdc" @prim_reg_cdc_1(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_core_i: i1, rst_dst_ni: %rst_core_ni: i1, src_regwen_i: %12: i1, src_we_i: %22: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %23: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "core_pwm_param_1_we"}
    llhd.drv %pwm_param_1_busy, %u_pwm_param_1_cdc.src_busy_o after %1 : i1
    llhd.drv %pwm_param_1_qs, %u_pwm_param_1_cdc.src_qs_o after %1 : i32
    %24 = llhd.prb %pwm_param_2_we : i1
    %25 = llhd.prb %core_pwm_param_2_qs : i32
    %u_pwm_param_2_cdc.src_busy_o, %u_pwm_param_2_cdc.src_qs_o, %u_pwm_param_2_cdc.dst_we_o, %u_pwm_param_2_cdc.dst_re_o, %u_pwm_param_2_cdc.dst_regwen_o, %u_pwm_param_2_cdc.dst_wd_o = hw.instance "u_pwm_param_2_cdc" @prim_reg_cdc_1(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_core_i: i1, rst_dst_ni: %rst_core_ni: i1, src_regwen_i: %12: i1, src_we_i: %24: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %25: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "core_pwm_param_2_we"}
    llhd.drv %pwm_param_2_busy, %u_pwm_param_2_cdc.src_busy_o after %1 : i1
    llhd.drv %pwm_param_2_qs, %u_pwm_param_2_cdc.src_qs_o after %1 : i32
    %26 = llhd.prb %pwm_param_3_we : i1
    %27 = llhd.prb %core_pwm_param_3_qs : i32
    %u_pwm_param_3_cdc.src_busy_o, %u_pwm_param_3_cdc.src_qs_o, %u_pwm_param_3_cdc.dst_we_o, %u_pwm_param_3_cdc.dst_re_o, %u_pwm_param_3_cdc.dst_regwen_o, %u_pwm_param_3_cdc.dst_wd_o = hw.instance "u_pwm_param_3_cdc" @prim_reg_cdc_1(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_core_i: i1, rst_dst_ni: %rst_core_ni: i1, src_regwen_i: %12: i1, src_we_i: %26: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %27: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "core_pwm_param_3_we"}
    llhd.drv %pwm_param_3_busy, %u_pwm_param_3_cdc.src_busy_o after %1 : i1
    llhd.drv %pwm_param_3_qs, %u_pwm_param_3_cdc.src_qs_o after %1 : i32
    %28 = llhd.prb %pwm_param_4_we : i1
    %29 = llhd.prb %core_pwm_param_4_qs : i32
    %u_pwm_param_4_cdc.src_busy_o, %u_pwm_param_4_cdc.src_qs_o, %u_pwm_param_4_cdc.dst_we_o, %u_pwm_param_4_cdc.dst_re_o, %u_pwm_param_4_cdc.dst_regwen_o, %u_pwm_param_4_cdc.dst_wd_o = hw.instance "u_pwm_param_4_cdc" @prim_reg_cdc_1(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_core_i: i1, rst_dst_ni: %rst_core_ni: i1, src_regwen_i: %12: i1, src_we_i: %28: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %29: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "core_pwm_param_4_we"}
    llhd.drv %pwm_param_4_busy, %u_pwm_param_4_cdc.src_busy_o after %1 : i1
    llhd.drv %pwm_param_4_qs, %u_pwm_param_4_cdc.src_qs_o after %1 : i32
    %30 = llhd.prb %pwm_param_5_we : i1
    %31 = llhd.prb %core_pwm_param_5_qs : i32
    %u_pwm_param_5_cdc.src_busy_o, %u_pwm_param_5_cdc.src_qs_o, %u_pwm_param_5_cdc.dst_we_o, %u_pwm_param_5_cdc.dst_re_o, %u_pwm_param_5_cdc.dst_regwen_o, %u_pwm_param_5_cdc.dst_wd_o = hw.instance "u_pwm_param_5_cdc" @prim_reg_cdc_1(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_core_i: i1, rst_dst_ni: %rst_core_ni: i1, src_regwen_i: %12: i1, src_we_i: %30: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %31: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "core_pwm_param_5_we"}
    llhd.drv %pwm_param_5_busy, %u_pwm_param_5_cdc.src_busy_o after %1 : i1
    llhd.drv %pwm_param_5_qs, %u_pwm_param_5_cdc.src_qs_o after %1 : i32
    %32 = llhd.prb %duty_cycle_0_we : i1
    %33 = llhd.prb %core_duty_cycle_0_qs : i32
    %u_duty_cycle_0_cdc.src_busy_o, %u_duty_cycle_0_cdc.src_qs_o, %u_duty_cycle_0_cdc.dst_we_o, %u_duty_cycle_0_cdc.dst_re_o, %u_duty_cycle_0_cdc.dst_regwen_o, %u_duty_cycle_0_cdc.dst_wd_o = hw.instance "u_duty_cycle_0_cdc" @prim_reg_cdc_2(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_core_i: i1, rst_dst_ni: %rst_core_ni: i1, src_regwen_i: %12: i1, src_we_i: %32: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %33: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "core_duty_cycle_0_we"}
    llhd.drv %duty_cycle_0_busy, %u_duty_cycle_0_cdc.src_busy_o after %1 : i1
    llhd.drv %duty_cycle_0_qs, %u_duty_cycle_0_cdc.src_qs_o after %1 : i32
    %34 = llhd.prb %duty_cycle_1_we : i1
    %35 = llhd.prb %core_duty_cycle_1_qs : i32
    %u_duty_cycle_1_cdc.src_busy_o, %u_duty_cycle_1_cdc.src_qs_o, %u_duty_cycle_1_cdc.dst_we_o, %u_duty_cycle_1_cdc.dst_re_o, %u_duty_cycle_1_cdc.dst_regwen_o, %u_duty_cycle_1_cdc.dst_wd_o = hw.instance "u_duty_cycle_1_cdc" @prim_reg_cdc_2(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_core_i: i1, rst_dst_ni: %rst_core_ni: i1, src_regwen_i: %12: i1, src_we_i: %34: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %35: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "core_duty_cycle_1_we"}
    llhd.drv %duty_cycle_1_busy, %u_duty_cycle_1_cdc.src_busy_o after %1 : i1
    llhd.drv %duty_cycle_1_qs, %u_duty_cycle_1_cdc.src_qs_o after %1 : i32
    %36 = llhd.prb %duty_cycle_2_we : i1
    %37 = llhd.prb %core_duty_cycle_2_qs : i32
    %u_duty_cycle_2_cdc.src_busy_o, %u_duty_cycle_2_cdc.src_qs_o, %u_duty_cycle_2_cdc.dst_we_o, %u_duty_cycle_2_cdc.dst_re_o, %u_duty_cycle_2_cdc.dst_regwen_o, %u_duty_cycle_2_cdc.dst_wd_o = hw.instance "u_duty_cycle_2_cdc" @prim_reg_cdc_2(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_core_i: i1, rst_dst_ni: %rst_core_ni: i1, src_regwen_i: %12: i1, src_we_i: %36: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %37: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "core_duty_cycle_2_we"}
    llhd.drv %duty_cycle_2_busy, %u_duty_cycle_2_cdc.src_busy_o after %1 : i1
    llhd.drv %duty_cycle_2_qs, %u_duty_cycle_2_cdc.src_qs_o after %1 : i32
    %38 = llhd.prb %duty_cycle_3_we : i1
    %39 = llhd.prb %core_duty_cycle_3_qs : i32
    %u_duty_cycle_3_cdc.src_busy_o, %u_duty_cycle_3_cdc.src_qs_o, %u_duty_cycle_3_cdc.dst_we_o, %u_duty_cycle_3_cdc.dst_re_o, %u_duty_cycle_3_cdc.dst_regwen_o, %u_duty_cycle_3_cdc.dst_wd_o = hw.instance "u_duty_cycle_3_cdc" @prim_reg_cdc_2(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_core_i: i1, rst_dst_ni: %rst_core_ni: i1, src_regwen_i: %12: i1, src_we_i: %38: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %39: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "core_duty_cycle_3_we"}
    llhd.drv %duty_cycle_3_busy, %u_duty_cycle_3_cdc.src_busy_o after %1 : i1
    llhd.drv %duty_cycle_3_qs, %u_duty_cycle_3_cdc.src_qs_o after %1 : i32
    %40 = llhd.prb %duty_cycle_4_we : i1
    %41 = llhd.prb %core_duty_cycle_4_qs : i32
    %u_duty_cycle_4_cdc.src_busy_o, %u_duty_cycle_4_cdc.src_qs_o, %u_duty_cycle_4_cdc.dst_we_o, %u_duty_cycle_4_cdc.dst_re_o, %u_duty_cycle_4_cdc.dst_regwen_o, %u_duty_cycle_4_cdc.dst_wd_o = hw.instance "u_duty_cycle_4_cdc" @prim_reg_cdc_2(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_core_i: i1, rst_dst_ni: %rst_core_ni: i1, src_regwen_i: %12: i1, src_we_i: %40: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %41: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "core_duty_cycle_4_we"}
    llhd.drv %duty_cycle_4_busy, %u_duty_cycle_4_cdc.src_busy_o after %1 : i1
    llhd.drv %duty_cycle_4_qs, %u_duty_cycle_4_cdc.src_qs_o after %1 : i32
    %42 = llhd.prb %duty_cycle_5_we : i1
    %43 = llhd.prb %core_duty_cycle_5_qs : i32
    %u_duty_cycle_5_cdc.src_busy_o, %u_duty_cycle_5_cdc.src_qs_o, %u_duty_cycle_5_cdc.dst_we_o, %u_duty_cycle_5_cdc.dst_re_o, %u_duty_cycle_5_cdc.dst_regwen_o, %u_duty_cycle_5_cdc.dst_wd_o = hw.instance "u_duty_cycle_5_cdc" @prim_reg_cdc_2(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_core_i: i1, rst_dst_ni: %rst_core_ni: i1, src_regwen_i: %12: i1, src_we_i: %42: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %43: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "core_duty_cycle_5_we"}
    llhd.drv %duty_cycle_5_busy, %u_duty_cycle_5_cdc.src_busy_o after %1 : i1
    llhd.drv %duty_cycle_5_qs, %u_duty_cycle_5_cdc.src_qs_o after %1 : i32
    %44 = llhd.prb %blink_param_0_we : i1
    %45 = llhd.prb %core_blink_param_0_qs : i32
    %u_blink_param_0_cdc.src_busy_o, %u_blink_param_0_cdc.src_qs_o, %u_blink_param_0_cdc.dst_we_o, %u_blink_param_0_cdc.dst_re_o, %u_blink_param_0_cdc.dst_regwen_o, %u_blink_param_0_cdc.dst_wd_o = hw.instance "u_blink_param_0_cdc" @prim_reg_cdc_3(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_core_i: i1, rst_dst_ni: %rst_core_ni: i1, src_regwen_i: %12: i1, src_we_i: %44: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %45: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "core_blink_param_0_we"}
    llhd.drv %blink_param_0_busy, %u_blink_param_0_cdc.src_busy_o after %1 : i1
    llhd.drv %blink_param_0_qs, %u_blink_param_0_cdc.src_qs_o after %1 : i32
    %46 = llhd.prb %blink_param_1_we : i1
    %47 = llhd.prb %core_blink_param_1_qs : i32
    %u_blink_param_1_cdc.src_busy_o, %u_blink_param_1_cdc.src_qs_o, %u_blink_param_1_cdc.dst_we_o, %u_blink_param_1_cdc.dst_re_o, %u_blink_param_1_cdc.dst_regwen_o, %u_blink_param_1_cdc.dst_wd_o = hw.instance "u_blink_param_1_cdc" @prim_reg_cdc_3(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_core_i: i1, rst_dst_ni: %rst_core_ni: i1, src_regwen_i: %12: i1, src_we_i: %46: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %47: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "core_blink_param_1_we"}
    llhd.drv %blink_param_1_busy, %u_blink_param_1_cdc.src_busy_o after %1 : i1
    llhd.drv %blink_param_1_qs, %u_blink_param_1_cdc.src_qs_o after %1 : i32
    %48 = llhd.prb %blink_param_2_we : i1
    %49 = llhd.prb %core_blink_param_2_qs : i32
    %u_blink_param_2_cdc.src_busy_o, %u_blink_param_2_cdc.src_qs_o, %u_blink_param_2_cdc.dst_we_o, %u_blink_param_2_cdc.dst_re_o, %u_blink_param_2_cdc.dst_regwen_o, %u_blink_param_2_cdc.dst_wd_o = hw.instance "u_blink_param_2_cdc" @prim_reg_cdc_3(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_core_i: i1, rst_dst_ni: %rst_core_ni: i1, src_regwen_i: %12: i1, src_we_i: %48: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %49: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "core_blink_param_2_we"}
    llhd.drv %blink_param_2_busy, %u_blink_param_2_cdc.src_busy_o after %1 : i1
    llhd.drv %blink_param_2_qs, %u_blink_param_2_cdc.src_qs_o after %1 : i32
    %50 = llhd.prb %blink_param_3_we : i1
    %51 = llhd.prb %core_blink_param_3_qs : i32
    %u_blink_param_3_cdc.src_busy_o, %u_blink_param_3_cdc.src_qs_o, %u_blink_param_3_cdc.dst_we_o, %u_blink_param_3_cdc.dst_re_o, %u_blink_param_3_cdc.dst_regwen_o, %u_blink_param_3_cdc.dst_wd_o = hw.instance "u_blink_param_3_cdc" @prim_reg_cdc_3(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_core_i: i1, rst_dst_ni: %rst_core_ni: i1, src_regwen_i: %12: i1, src_we_i: %50: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %51: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "core_blink_param_3_we"}
    llhd.drv %blink_param_3_busy, %u_blink_param_3_cdc.src_busy_o after %1 : i1
    llhd.drv %blink_param_3_qs, %u_blink_param_3_cdc.src_qs_o after %1 : i32
    %52 = llhd.prb %blink_param_4_we : i1
    %53 = llhd.prb %core_blink_param_4_qs : i32
    %u_blink_param_4_cdc.src_busy_o, %u_blink_param_4_cdc.src_qs_o, %u_blink_param_4_cdc.dst_we_o, %u_blink_param_4_cdc.dst_re_o, %u_blink_param_4_cdc.dst_regwen_o, %u_blink_param_4_cdc.dst_wd_o = hw.instance "u_blink_param_4_cdc" @prim_reg_cdc_3(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_core_i: i1, rst_dst_ni: %rst_core_ni: i1, src_regwen_i: %12: i1, src_we_i: %52: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %53: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "core_blink_param_4_we"}
    llhd.drv %blink_param_4_busy, %u_blink_param_4_cdc.src_busy_o after %1 : i1
    llhd.drv %blink_param_4_qs, %u_blink_param_4_cdc.src_qs_o after %1 : i32
    %54 = llhd.prb %blink_param_5_we : i1
    %55 = llhd.prb %core_blink_param_5_qs : i32
    %u_blink_param_5_cdc.src_busy_o, %u_blink_param_5_cdc.src_qs_o, %u_blink_param_5_cdc.dst_we_o, %u_blink_param_5_cdc.dst_re_o, %u_blink_param_5_cdc.dst_regwen_o, %u_blink_param_5_cdc.dst_wd_o = hw.instance "u_blink_param_5_cdc" @prim_reg_cdc_3(clk_src_i: %5: i1, rst_src_ni: %6: i1, clk_dst_i: %clk_core_i: i1, rst_dst_ni: %rst_core_ni: i1, src_regwen_i: %12: i1, src_we_i: %54: i1, src_re_i: %false: i1, src_wd_i: %u_reg_if.wdata_o: i32, dst_ds_i: %c0_i32: i32, dst_qs_i: %55: i32, dst_update_i: %false: i1) -> (src_busy_o: i1, src_qs_o: i32, dst_we_o: i1, dst_re_o: i1, dst_regwen_o: i1, dst_wd_o: i32) {sv.namehint = "core_blink_param_5_we"}
    llhd.drv %blink_param_5_busy, %u_blink_param_5_cdc.src_busy_o after %1 : i1
    llhd.drv %blink_param_5_qs, %u_blink_param_5_cdc.src_qs_o after %1 : i32
    %56 = llhd.prb %alert_test_we : i1
    %57 = llhd.sig.struct_extract %reg2hw["alert_test"] : <!hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>>
    %58 = llhd.sig.struct_extract %57["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_alert_test.qe, %u_alert_test.qre, %u_alert_test.q, %u_alert_test.ds, %u_alert_test.qs = hw.instance "u_alert_test" @prim_subreg_ext(re: %false: i1, we: %56: i1, wd: %525: i1, d: %false: i1) -> (qe: i1, qre: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %alert_test_flds_we, %u_alert_test.qe after %1 : i1
    llhd.drv %58, %u_alert_test.q after %1 : i1
    %59 = llhd.prb %regwen_we : i1
    %u_regwen.qe, %u_regwen.q, %u_regwen.ds, %u_regwen.qs = hw.instance "u_regwen" @prim_subreg(clk_i: %5: i1, rst_ni: %6: i1, we: %59: i1, wd: %525: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %regwen_qs, %u_regwen.qs after %1 : i1
    %60 = llhd.prb %cfg_flds_we : i3
    %61 = comb.icmp eq %60, %c-1_i3 : i3
    %u_cfg0_qe.q_o = hw.instance "u_cfg0_qe" @prim_flop(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, d_i: %61: i1) -> (q_o: i1) {sv.namehint = "cfg_qe"}
    %62 = comb.extract %u_cfg_cdc.dst_wd_o from 0 : (i32) -> i27
    %63 = llhd.sig.extract %cfg_flds_we from %c0_i2 : <i3> -> <i1>
    %64 = llhd.sig.struct_extract %reg2hw["cfg"] : <!hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>>
    %65 = llhd.sig.struct_extract %64["clk_div"] : <!hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>>
    %66 = llhd.sig.struct_extract %65["q"] : <!hw.struct<q: i27, qe: i1>>
    %u_cfg_clk_div.qe, %u_cfg_clk_div.q, %u_cfg_clk_div.ds, %u_cfg_clk_div.qs = hw.instance "u_cfg_clk_div" @prim_subreg_4(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %420: i1, wd: %62: i27, de: %false: i1, d: %c0_i27: i27) -> (qe: i1, q: i27, ds: i27, qs: i27)
    llhd.drv %63, %u_cfg_clk_div.qe after %1 : i1
    llhd.drv %66, %u_cfg_clk_div.q after %1 : i27
    llhd.drv %core_cfg_clk_div_qs_int, %u_cfg_clk_div.qs after %1 : i27
    %67 = comb.extract %u_cfg_cdc.dst_wd_o from 27 : (i32) -> i4
    %68 = llhd.sig.extract %cfg_flds_we from %c1_i2 : <i3> -> <i1>
    %69 = llhd.sig.struct_extract %64["dc_resn"] : <!hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>>
    %70 = llhd.sig.struct_extract %69["q"] : <!hw.struct<q: i4, qe: i1>>
    %u_cfg_dc_resn.qe, %u_cfg_dc_resn.q, %u_cfg_dc_resn.ds, %u_cfg_dc_resn.qs = hw.instance "u_cfg_dc_resn" @prim_subreg_5(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %420: i1, wd: %67: i4, de: %false: i1, d: %c0_i4: i4) -> (qe: i1, q: i4, ds: i4, qs: i4)
    llhd.drv %68, %u_cfg_dc_resn.qe after %1 : i1
    llhd.drv %70, %u_cfg_dc_resn.q after %1 : i4
    llhd.drv %core_cfg_dc_resn_qs_int, %u_cfg_dc_resn.qs after %1 : i4
    %71 = comb.extract %u_cfg_cdc.dst_wd_o from 31 : (i32) -> i1
    %72 = llhd.sig.extract %cfg_flds_we from %c-2_i2 : <i3> -> <i1>
    %73 = llhd.sig.struct_extract %64["cntr_en"] : <!hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>>
    %74 = llhd.sig.struct_extract %73["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_cfg_cntr_en.qe, %u_cfg_cntr_en.q, %u_cfg_cntr_en.ds, %u_cfg_cntr_en.qs = hw.instance "u_cfg_cntr_en" @prim_subreg_6(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %420: i1, wd: %71: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %72, %u_cfg_cntr_en.qe after %1 : i1
    llhd.drv %74, %u_cfg_cntr_en.q after %1 : i1
    llhd.drv %core_cfg_cntr_en_qs_int, %u_cfg_cntr_en.qs after %1 : i1
    %75 = llhd.prb %pwm_en_flds_we : i6
    %76 = comb.icmp eq %75, %c-1_i6 : i6
    %u_pwm_en0_qe.q_o = hw.instance "u_pwm_en0_qe" @prim_flop(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, d_i: %76: i1) -> (q_o: i1) {sv.namehint = "pwm_en_qe"}
    %77 = comb.extract %u_pwm_en_cdc.dst_wd_o from 0 : (i6) -> i1
    %78 = llhd.sig.extract %pwm_en_flds_we from %c0_i3 : <i6> -> <i1>
    %79 = llhd.sig.struct_extract %reg2hw["pwm_en"] : <!hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>>
    %80 = llhd.sig.array_get %79[%c0_i3] : <!hw.array<6xstruct<q: i1, qe: i1>>>
    %81 = llhd.sig.struct_extract %80["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_pwm_en_en_0.qe, %u_pwm_en_en_0.q, %u_pwm_en_en_0.ds, %u_pwm_en_en_0.qs = hw.instance "u_pwm_en_en_0" @prim_subreg_6(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %424: i1, wd: %77: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %78, %u_pwm_en_en_0.qe after %1 : i1
    llhd.drv %81, %u_pwm_en_en_0.q after %1 : i1
    llhd.drv %core_pwm_en_en_0_qs_int, %u_pwm_en_en_0.qs after %1 : i1
    %82 = comb.extract %u_pwm_en_cdc.dst_wd_o from 1 : (i6) -> i1
    %83 = llhd.sig.extract %pwm_en_flds_we from %c1_i3 : <i6> -> <i1>
    %84 = llhd.sig.array_get %79[%c1_i3] : <!hw.array<6xstruct<q: i1, qe: i1>>>
    %85 = llhd.sig.struct_extract %84["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_pwm_en_en_1.qe, %u_pwm_en_en_1.q, %u_pwm_en_en_1.ds, %u_pwm_en_en_1.qs = hw.instance "u_pwm_en_en_1" @prim_subreg_6(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %424: i1, wd: %82: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %83, %u_pwm_en_en_1.qe after %1 : i1
    llhd.drv %85, %u_pwm_en_en_1.q after %1 : i1
    llhd.drv %core_pwm_en_en_1_qs_int, %u_pwm_en_en_1.qs after %1 : i1
    %86 = comb.extract %u_pwm_en_cdc.dst_wd_o from 2 : (i6) -> i1
    %87 = llhd.sig.extract %pwm_en_flds_we from %c2_i3 : <i6> -> <i1>
    %88 = llhd.sig.array_get %79[%c2_i3] : <!hw.array<6xstruct<q: i1, qe: i1>>>
    %89 = llhd.sig.struct_extract %88["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_pwm_en_en_2.qe, %u_pwm_en_en_2.q, %u_pwm_en_en_2.ds, %u_pwm_en_en_2.qs = hw.instance "u_pwm_en_en_2" @prim_subreg_6(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %424: i1, wd: %86: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %87, %u_pwm_en_en_2.qe after %1 : i1
    llhd.drv %89, %u_pwm_en_en_2.q after %1 : i1
    llhd.drv %core_pwm_en_en_2_qs_int, %u_pwm_en_en_2.qs after %1 : i1
    %90 = comb.extract %u_pwm_en_cdc.dst_wd_o from 3 : (i6) -> i1
    %91 = llhd.sig.extract %pwm_en_flds_we from %c3_i3 : <i6> -> <i1>
    %92 = llhd.sig.array_get %79[%c3_i3] : <!hw.array<6xstruct<q: i1, qe: i1>>>
    %93 = llhd.sig.struct_extract %92["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_pwm_en_en_3.qe, %u_pwm_en_en_3.q, %u_pwm_en_en_3.ds, %u_pwm_en_en_3.qs = hw.instance "u_pwm_en_en_3" @prim_subreg_6(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %424: i1, wd: %90: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %91, %u_pwm_en_en_3.qe after %1 : i1
    llhd.drv %93, %u_pwm_en_en_3.q after %1 : i1
    llhd.drv %core_pwm_en_en_3_qs_int, %u_pwm_en_en_3.qs after %1 : i1
    %94 = comb.extract %u_pwm_en_cdc.dst_wd_o from 4 : (i6) -> i1
    %95 = llhd.sig.extract %pwm_en_flds_we from %c-4_i3 : <i6> -> <i1>
    %96 = llhd.sig.array_get %79[%c-4_i3] : <!hw.array<6xstruct<q: i1, qe: i1>>>
    %97 = llhd.sig.struct_extract %96["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_pwm_en_en_4.qe, %u_pwm_en_en_4.q, %u_pwm_en_en_4.ds, %u_pwm_en_en_4.qs = hw.instance "u_pwm_en_en_4" @prim_subreg_6(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %424: i1, wd: %94: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %95, %u_pwm_en_en_4.qe after %1 : i1
    llhd.drv %97, %u_pwm_en_en_4.q after %1 : i1
    llhd.drv %core_pwm_en_en_4_qs_int, %u_pwm_en_en_4.qs after %1 : i1
    %98 = comb.extract %u_pwm_en_cdc.dst_wd_o from 5 : (i6) -> i1
    %99 = llhd.sig.extract %pwm_en_flds_we from %c-3_i3 : <i6> -> <i1>
    %100 = llhd.sig.array_get %79[%c-3_i3] : <!hw.array<6xstruct<q: i1, qe: i1>>>
    %101 = llhd.sig.struct_extract %100["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_pwm_en_en_5.qe, %u_pwm_en_en_5.q, %u_pwm_en_en_5.ds, %u_pwm_en_en_5.qs = hw.instance "u_pwm_en_en_5" @prim_subreg_6(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %424: i1, wd: %98: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %99, %u_pwm_en_en_5.qe after %1 : i1
    llhd.drv %101, %u_pwm_en_en_5.q after %1 : i1
    llhd.drv %core_pwm_en_en_5_qs_int, %u_pwm_en_en_5.qs after %1 : i1
    %102 = llhd.prb %invert_flds_we : i6
    %103 = comb.icmp eq %102, %c-1_i6 : i6
    %u_invert0_qe.q_o = hw.instance "u_invert0_qe" @prim_flop(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, d_i: %103: i1) -> (q_o: i1) {sv.namehint = "invert_qe"}
    %104 = comb.extract %u_invert_cdc.dst_wd_o from 0 : (i6) -> i1
    %105 = llhd.sig.extract %invert_flds_we from %c0_i3 : <i6> -> <i1>
    %106 = llhd.sig.struct_extract %reg2hw["invert"] : <!hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>>
    %107 = llhd.sig.array_get %106[%c0_i3] : <!hw.array<6xstruct<q: i1, qe: i1>>>
    %108 = llhd.sig.struct_extract %107["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_invert_invert_0.qe, %u_invert_invert_0.q, %u_invert_invert_0.ds, %u_invert_invert_0.qs = hw.instance "u_invert_invert_0" @prim_subreg_6(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %431: i1, wd: %104: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %105, %u_invert_invert_0.qe after %1 : i1
    llhd.drv %108, %u_invert_invert_0.q after %1 : i1
    llhd.drv %core_invert_invert_0_qs_int, %u_invert_invert_0.qs after %1 : i1
    %109 = comb.extract %u_invert_cdc.dst_wd_o from 1 : (i6) -> i1
    %110 = llhd.sig.extract %invert_flds_we from %c1_i3 : <i6> -> <i1>
    %111 = llhd.sig.array_get %106[%c1_i3] : <!hw.array<6xstruct<q: i1, qe: i1>>>
    %112 = llhd.sig.struct_extract %111["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_invert_invert_1.qe, %u_invert_invert_1.q, %u_invert_invert_1.ds, %u_invert_invert_1.qs = hw.instance "u_invert_invert_1" @prim_subreg_6(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %431: i1, wd: %109: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %110, %u_invert_invert_1.qe after %1 : i1
    llhd.drv %112, %u_invert_invert_1.q after %1 : i1
    llhd.drv %core_invert_invert_1_qs_int, %u_invert_invert_1.qs after %1 : i1
    %113 = comb.extract %u_invert_cdc.dst_wd_o from 2 : (i6) -> i1
    %114 = llhd.sig.extract %invert_flds_we from %c2_i3 : <i6> -> <i1>
    %115 = llhd.sig.array_get %106[%c2_i3] : <!hw.array<6xstruct<q: i1, qe: i1>>>
    %116 = llhd.sig.struct_extract %115["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_invert_invert_2.qe, %u_invert_invert_2.q, %u_invert_invert_2.ds, %u_invert_invert_2.qs = hw.instance "u_invert_invert_2" @prim_subreg_6(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %431: i1, wd: %113: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %114, %u_invert_invert_2.qe after %1 : i1
    llhd.drv %116, %u_invert_invert_2.q after %1 : i1
    llhd.drv %core_invert_invert_2_qs_int, %u_invert_invert_2.qs after %1 : i1
    %117 = comb.extract %u_invert_cdc.dst_wd_o from 3 : (i6) -> i1
    %118 = llhd.sig.extract %invert_flds_we from %c3_i3 : <i6> -> <i1>
    %119 = llhd.sig.array_get %106[%c3_i3] : <!hw.array<6xstruct<q: i1, qe: i1>>>
    %120 = llhd.sig.struct_extract %119["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_invert_invert_3.qe, %u_invert_invert_3.q, %u_invert_invert_3.ds, %u_invert_invert_3.qs = hw.instance "u_invert_invert_3" @prim_subreg_6(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %431: i1, wd: %117: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %118, %u_invert_invert_3.qe after %1 : i1
    llhd.drv %120, %u_invert_invert_3.q after %1 : i1
    llhd.drv %core_invert_invert_3_qs_int, %u_invert_invert_3.qs after %1 : i1
    %121 = comb.extract %u_invert_cdc.dst_wd_o from 4 : (i6) -> i1
    %122 = llhd.sig.extract %invert_flds_we from %c-4_i3 : <i6> -> <i1>
    %123 = llhd.sig.array_get %106[%c-4_i3] : <!hw.array<6xstruct<q: i1, qe: i1>>>
    %124 = llhd.sig.struct_extract %123["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_invert_invert_4.qe, %u_invert_invert_4.q, %u_invert_invert_4.ds, %u_invert_invert_4.qs = hw.instance "u_invert_invert_4" @prim_subreg_6(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %431: i1, wd: %121: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %122, %u_invert_invert_4.qe after %1 : i1
    llhd.drv %124, %u_invert_invert_4.q after %1 : i1
    llhd.drv %core_invert_invert_4_qs_int, %u_invert_invert_4.qs after %1 : i1
    %125 = comb.extract %u_invert_cdc.dst_wd_o from 5 : (i6) -> i1
    %126 = llhd.sig.extract %invert_flds_we from %c-3_i3 : <i6> -> <i1>
    %127 = llhd.sig.array_get %106[%c-3_i3] : <!hw.array<6xstruct<q: i1, qe: i1>>>
    %128 = llhd.sig.struct_extract %127["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_invert_invert_5.qe, %u_invert_invert_5.q, %u_invert_invert_5.ds, %u_invert_invert_5.qs = hw.instance "u_invert_invert_5" @prim_subreg_6(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %431: i1, wd: %125: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %126, %u_invert_invert_5.qe after %1 : i1
    llhd.drv %128, %u_invert_invert_5.q after %1 : i1
    llhd.drv %core_invert_invert_5_qs_int, %u_invert_invert_5.qs after %1 : i1
    %129 = llhd.prb %pwm_param_0_flds_we : i3
    %130 = comb.icmp eq %129, %c-1_i3 : i3
    %u_pwm_param0_qe.q_o = hw.instance "u_pwm_param0_qe" @prim_flop(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, d_i: %130: i1) -> (q_o: i1) {sv.namehint = "pwm_param_0_qe"}
    %131 = comb.extract %u_pwm_param_0_cdc.dst_wd_o from 0 : (i32) -> i16
    %132 = llhd.sig.extract %pwm_param_0_flds_we from %c0_i2 : <i3> -> <i1>
    %133 = llhd.sig.struct_extract %reg2hw["pwm_param"] : <!hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>>
    %134 = llhd.sig.array_get %133[%c0_i3] : <!hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>>
    %135 = llhd.sig.struct_extract %134["phase_delay"] : <!hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>
    %136 = llhd.sig.struct_extract %135["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_pwm_param_0_phase_delay_0.qe, %u_pwm_param_0_phase_delay_0.q, %u_pwm_param_0_phase_delay_0.ds, %u_pwm_param_0_phase_delay_0.qs = hw.instance "u_pwm_param_0_phase_delay_0" @prim_subreg_7(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %438: i1, wd: %131: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %132, %u_pwm_param_0_phase_delay_0.qe after %1 : i1
    llhd.drv %136, %u_pwm_param_0_phase_delay_0.q after %1 : i16
    llhd.drv %core_pwm_param_0_phase_delay_0_qs_int, %u_pwm_param_0_phase_delay_0.qs after %1 : i16
    %137 = comb.extract %u_pwm_param_0_cdc.dst_wd_o from 30 : (i32) -> i1
    %138 = llhd.sig.extract %pwm_param_0_flds_we from %c1_i2 : <i3> -> <i1>
    %139 = llhd.sig.struct_extract %134["htbt_en"] : <!hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>
    %140 = llhd.sig.struct_extract %139["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_pwm_param_0_htbt_en_0.qe, %u_pwm_param_0_htbt_en_0.q, %u_pwm_param_0_htbt_en_0.ds, %u_pwm_param_0_htbt_en_0.qs = hw.instance "u_pwm_param_0_htbt_en_0" @prim_subreg_6(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %438: i1, wd: %137: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %138, %u_pwm_param_0_htbt_en_0.qe after %1 : i1
    llhd.drv %140, %u_pwm_param_0_htbt_en_0.q after %1 : i1
    llhd.drv %core_pwm_param_0_htbt_en_0_qs_int, %u_pwm_param_0_htbt_en_0.qs after %1 : i1
    %141 = comb.extract %u_pwm_param_0_cdc.dst_wd_o from 31 : (i32) -> i1
    %142 = llhd.sig.extract %pwm_param_0_flds_we from %c-2_i2 : <i3> -> <i1>
    %143 = llhd.sig.struct_extract %134["blink_en"] : <!hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>
    %144 = llhd.sig.struct_extract %143["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_pwm_param_0_blink_en_0.qe, %u_pwm_param_0_blink_en_0.q, %u_pwm_param_0_blink_en_0.ds, %u_pwm_param_0_blink_en_0.qs = hw.instance "u_pwm_param_0_blink_en_0" @prim_subreg_6(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %438: i1, wd: %141: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %142, %u_pwm_param_0_blink_en_0.qe after %1 : i1
    llhd.drv %144, %u_pwm_param_0_blink_en_0.q after %1 : i1
    llhd.drv %core_pwm_param_0_blink_en_0_qs_int, %u_pwm_param_0_blink_en_0.qs after %1 : i1
    %145 = llhd.prb %pwm_param_1_flds_we : i3
    %146 = comb.icmp eq %145, %c-1_i3 : i3
    %u_pwm_param1_qe.q_o = hw.instance "u_pwm_param1_qe" @prim_flop(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, d_i: %146: i1) -> (q_o: i1) {sv.namehint = "pwm_param_1_qe"}
    %147 = comb.extract %u_pwm_param_1_cdc.dst_wd_o from 0 : (i32) -> i16
    %148 = llhd.sig.extract %pwm_param_1_flds_we from %c0_i2 : <i3> -> <i1>
    %149 = llhd.sig.array_get %133[%c1_i3] : <!hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>>
    %150 = llhd.sig.struct_extract %149["phase_delay"] : <!hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>
    %151 = llhd.sig.struct_extract %150["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_pwm_param_1_phase_delay_1.qe, %u_pwm_param_1_phase_delay_1.q, %u_pwm_param_1_phase_delay_1.ds, %u_pwm_param_1_phase_delay_1.qs = hw.instance "u_pwm_param_1_phase_delay_1" @prim_subreg_7(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %442: i1, wd: %147: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %148, %u_pwm_param_1_phase_delay_1.qe after %1 : i1
    llhd.drv %151, %u_pwm_param_1_phase_delay_1.q after %1 : i16
    llhd.drv %core_pwm_param_1_phase_delay_1_qs_int, %u_pwm_param_1_phase_delay_1.qs after %1 : i16
    %152 = comb.extract %u_pwm_param_1_cdc.dst_wd_o from 30 : (i32) -> i1
    %153 = llhd.sig.extract %pwm_param_1_flds_we from %c1_i2 : <i3> -> <i1>
    %154 = llhd.sig.struct_extract %149["htbt_en"] : <!hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>
    %155 = llhd.sig.struct_extract %154["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_pwm_param_1_htbt_en_1.qe, %u_pwm_param_1_htbt_en_1.q, %u_pwm_param_1_htbt_en_1.ds, %u_pwm_param_1_htbt_en_1.qs = hw.instance "u_pwm_param_1_htbt_en_1" @prim_subreg_6(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %442: i1, wd: %152: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %153, %u_pwm_param_1_htbt_en_1.qe after %1 : i1
    llhd.drv %155, %u_pwm_param_1_htbt_en_1.q after %1 : i1
    llhd.drv %core_pwm_param_1_htbt_en_1_qs_int, %u_pwm_param_1_htbt_en_1.qs after %1 : i1
    %156 = comb.extract %u_pwm_param_1_cdc.dst_wd_o from 31 : (i32) -> i1
    %157 = llhd.sig.extract %pwm_param_1_flds_we from %c-2_i2 : <i3> -> <i1>
    %158 = llhd.sig.struct_extract %149["blink_en"] : <!hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>
    %159 = llhd.sig.struct_extract %158["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_pwm_param_1_blink_en_1.qe, %u_pwm_param_1_blink_en_1.q, %u_pwm_param_1_blink_en_1.ds, %u_pwm_param_1_blink_en_1.qs = hw.instance "u_pwm_param_1_blink_en_1" @prim_subreg_6(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %442: i1, wd: %156: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %157, %u_pwm_param_1_blink_en_1.qe after %1 : i1
    llhd.drv %159, %u_pwm_param_1_blink_en_1.q after %1 : i1
    llhd.drv %core_pwm_param_1_blink_en_1_qs_int, %u_pwm_param_1_blink_en_1.qs after %1 : i1
    %160 = llhd.prb %pwm_param_2_flds_we : i3
    %161 = comb.icmp eq %160, %c-1_i3 : i3
    %u_pwm_param2_qe.q_o = hw.instance "u_pwm_param2_qe" @prim_flop(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, d_i: %161: i1) -> (q_o: i1) {sv.namehint = "pwm_param_2_qe"}
    %162 = comb.extract %u_pwm_param_2_cdc.dst_wd_o from 0 : (i32) -> i16
    %163 = llhd.sig.extract %pwm_param_2_flds_we from %c0_i2 : <i3> -> <i1>
    %164 = llhd.sig.array_get %133[%c2_i3] : <!hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>>
    %165 = llhd.sig.struct_extract %164["phase_delay"] : <!hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>
    %166 = llhd.sig.struct_extract %165["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_pwm_param_2_phase_delay_2.qe, %u_pwm_param_2_phase_delay_2.q, %u_pwm_param_2_phase_delay_2.ds, %u_pwm_param_2_phase_delay_2.qs = hw.instance "u_pwm_param_2_phase_delay_2" @prim_subreg_7(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %446: i1, wd: %162: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %163, %u_pwm_param_2_phase_delay_2.qe after %1 : i1
    llhd.drv %166, %u_pwm_param_2_phase_delay_2.q after %1 : i16
    llhd.drv %core_pwm_param_2_phase_delay_2_qs_int, %u_pwm_param_2_phase_delay_2.qs after %1 : i16
    %167 = comb.extract %u_pwm_param_2_cdc.dst_wd_o from 30 : (i32) -> i1
    %168 = llhd.sig.extract %pwm_param_2_flds_we from %c1_i2 : <i3> -> <i1>
    %169 = llhd.sig.struct_extract %164["htbt_en"] : <!hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>
    %170 = llhd.sig.struct_extract %169["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_pwm_param_2_htbt_en_2.qe, %u_pwm_param_2_htbt_en_2.q, %u_pwm_param_2_htbt_en_2.ds, %u_pwm_param_2_htbt_en_2.qs = hw.instance "u_pwm_param_2_htbt_en_2" @prim_subreg_6(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %446: i1, wd: %167: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %168, %u_pwm_param_2_htbt_en_2.qe after %1 : i1
    llhd.drv %170, %u_pwm_param_2_htbt_en_2.q after %1 : i1
    llhd.drv %core_pwm_param_2_htbt_en_2_qs_int, %u_pwm_param_2_htbt_en_2.qs after %1 : i1
    %171 = comb.extract %u_pwm_param_2_cdc.dst_wd_o from 31 : (i32) -> i1
    %172 = llhd.sig.extract %pwm_param_2_flds_we from %c-2_i2 : <i3> -> <i1>
    %173 = llhd.sig.struct_extract %164["blink_en"] : <!hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>
    %174 = llhd.sig.struct_extract %173["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_pwm_param_2_blink_en_2.qe, %u_pwm_param_2_blink_en_2.q, %u_pwm_param_2_blink_en_2.ds, %u_pwm_param_2_blink_en_2.qs = hw.instance "u_pwm_param_2_blink_en_2" @prim_subreg_6(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %446: i1, wd: %171: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %172, %u_pwm_param_2_blink_en_2.qe after %1 : i1
    llhd.drv %174, %u_pwm_param_2_blink_en_2.q after %1 : i1
    llhd.drv %core_pwm_param_2_blink_en_2_qs_int, %u_pwm_param_2_blink_en_2.qs after %1 : i1
    %175 = llhd.prb %pwm_param_3_flds_we : i3
    %176 = comb.icmp eq %175, %c-1_i3 : i3
    %u_pwm_param3_qe.q_o = hw.instance "u_pwm_param3_qe" @prim_flop(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, d_i: %176: i1) -> (q_o: i1) {sv.namehint = "pwm_param_3_qe"}
    %177 = comb.extract %u_pwm_param_3_cdc.dst_wd_o from 0 : (i32) -> i16
    %178 = llhd.sig.extract %pwm_param_3_flds_we from %c0_i2 : <i3> -> <i1>
    %179 = llhd.sig.array_get %133[%c3_i3] : <!hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>>
    %180 = llhd.sig.struct_extract %179["phase_delay"] : <!hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>
    %181 = llhd.sig.struct_extract %180["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_pwm_param_3_phase_delay_3.qe, %u_pwm_param_3_phase_delay_3.q, %u_pwm_param_3_phase_delay_3.ds, %u_pwm_param_3_phase_delay_3.qs = hw.instance "u_pwm_param_3_phase_delay_3" @prim_subreg_7(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %450: i1, wd: %177: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %178, %u_pwm_param_3_phase_delay_3.qe after %1 : i1
    llhd.drv %181, %u_pwm_param_3_phase_delay_3.q after %1 : i16
    llhd.drv %core_pwm_param_3_phase_delay_3_qs_int, %u_pwm_param_3_phase_delay_3.qs after %1 : i16
    %182 = comb.extract %u_pwm_param_3_cdc.dst_wd_o from 30 : (i32) -> i1
    %183 = llhd.sig.extract %pwm_param_3_flds_we from %c1_i2 : <i3> -> <i1>
    %184 = llhd.sig.struct_extract %179["htbt_en"] : <!hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>
    %185 = llhd.sig.struct_extract %184["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_pwm_param_3_htbt_en_3.qe, %u_pwm_param_3_htbt_en_3.q, %u_pwm_param_3_htbt_en_3.ds, %u_pwm_param_3_htbt_en_3.qs = hw.instance "u_pwm_param_3_htbt_en_3" @prim_subreg_6(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %450: i1, wd: %182: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %183, %u_pwm_param_3_htbt_en_3.qe after %1 : i1
    llhd.drv %185, %u_pwm_param_3_htbt_en_3.q after %1 : i1
    llhd.drv %core_pwm_param_3_htbt_en_3_qs_int, %u_pwm_param_3_htbt_en_3.qs after %1 : i1
    %186 = comb.extract %u_pwm_param_3_cdc.dst_wd_o from 31 : (i32) -> i1
    %187 = llhd.sig.extract %pwm_param_3_flds_we from %c-2_i2 : <i3> -> <i1>
    %188 = llhd.sig.struct_extract %179["blink_en"] : <!hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>
    %189 = llhd.sig.struct_extract %188["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_pwm_param_3_blink_en_3.qe, %u_pwm_param_3_blink_en_3.q, %u_pwm_param_3_blink_en_3.ds, %u_pwm_param_3_blink_en_3.qs = hw.instance "u_pwm_param_3_blink_en_3" @prim_subreg_6(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %450: i1, wd: %186: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %187, %u_pwm_param_3_blink_en_3.qe after %1 : i1
    llhd.drv %189, %u_pwm_param_3_blink_en_3.q after %1 : i1
    llhd.drv %core_pwm_param_3_blink_en_3_qs_int, %u_pwm_param_3_blink_en_3.qs after %1 : i1
    %190 = llhd.prb %pwm_param_4_flds_we : i3
    %191 = comb.icmp eq %190, %c-1_i3 : i3
    %u_pwm_param4_qe.q_o = hw.instance "u_pwm_param4_qe" @prim_flop(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, d_i: %191: i1) -> (q_o: i1) {sv.namehint = "pwm_param_4_qe"}
    %192 = comb.extract %u_pwm_param_4_cdc.dst_wd_o from 0 : (i32) -> i16
    %193 = llhd.sig.extract %pwm_param_4_flds_we from %c0_i2 : <i3> -> <i1>
    %194 = llhd.sig.array_get %133[%c-4_i3] : <!hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>>
    %195 = llhd.sig.struct_extract %194["phase_delay"] : <!hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>
    %196 = llhd.sig.struct_extract %195["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_pwm_param_4_phase_delay_4.qe, %u_pwm_param_4_phase_delay_4.q, %u_pwm_param_4_phase_delay_4.ds, %u_pwm_param_4_phase_delay_4.qs = hw.instance "u_pwm_param_4_phase_delay_4" @prim_subreg_7(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %454: i1, wd: %192: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %193, %u_pwm_param_4_phase_delay_4.qe after %1 : i1
    llhd.drv %196, %u_pwm_param_4_phase_delay_4.q after %1 : i16
    llhd.drv %core_pwm_param_4_phase_delay_4_qs_int, %u_pwm_param_4_phase_delay_4.qs after %1 : i16
    %197 = comb.extract %u_pwm_param_4_cdc.dst_wd_o from 30 : (i32) -> i1
    %198 = llhd.sig.extract %pwm_param_4_flds_we from %c1_i2 : <i3> -> <i1>
    %199 = llhd.sig.struct_extract %194["htbt_en"] : <!hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>
    %200 = llhd.sig.struct_extract %199["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_pwm_param_4_htbt_en_4.qe, %u_pwm_param_4_htbt_en_4.q, %u_pwm_param_4_htbt_en_4.ds, %u_pwm_param_4_htbt_en_4.qs = hw.instance "u_pwm_param_4_htbt_en_4" @prim_subreg_6(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %454: i1, wd: %197: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %198, %u_pwm_param_4_htbt_en_4.qe after %1 : i1
    llhd.drv %200, %u_pwm_param_4_htbt_en_4.q after %1 : i1
    llhd.drv %core_pwm_param_4_htbt_en_4_qs_int, %u_pwm_param_4_htbt_en_4.qs after %1 : i1
    %201 = comb.extract %u_pwm_param_4_cdc.dst_wd_o from 31 : (i32) -> i1
    %202 = llhd.sig.extract %pwm_param_4_flds_we from %c-2_i2 : <i3> -> <i1>
    %203 = llhd.sig.struct_extract %194["blink_en"] : <!hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>
    %204 = llhd.sig.struct_extract %203["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_pwm_param_4_blink_en_4.qe, %u_pwm_param_4_blink_en_4.q, %u_pwm_param_4_blink_en_4.ds, %u_pwm_param_4_blink_en_4.qs = hw.instance "u_pwm_param_4_blink_en_4" @prim_subreg_6(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %454: i1, wd: %201: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %202, %u_pwm_param_4_blink_en_4.qe after %1 : i1
    llhd.drv %204, %u_pwm_param_4_blink_en_4.q after %1 : i1
    llhd.drv %core_pwm_param_4_blink_en_4_qs_int, %u_pwm_param_4_blink_en_4.qs after %1 : i1
    %205 = llhd.prb %pwm_param_5_flds_we : i3
    %206 = comb.icmp eq %205, %c-1_i3 : i3
    %u_pwm_param5_qe.q_o = hw.instance "u_pwm_param5_qe" @prim_flop(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, d_i: %206: i1) -> (q_o: i1) {sv.namehint = "pwm_param_5_qe"}
    %207 = comb.extract %u_pwm_param_5_cdc.dst_wd_o from 0 : (i32) -> i16
    %208 = llhd.sig.extract %pwm_param_5_flds_we from %c0_i2 : <i3> -> <i1>
    %209 = llhd.sig.array_get %133[%c-3_i3] : <!hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>>
    %210 = llhd.sig.struct_extract %209["phase_delay"] : <!hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>
    %211 = llhd.sig.struct_extract %210["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_pwm_param_5_phase_delay_5.qe, %u_pwm_param_5_phase_delay_5.q, %u_pwm_param_5_phase_delay_5.ds, %u_pwm_param_5_phase_delay_5.qs = hw.instance "u_pwm_param_5_phase_delay_5" @prim_subreg_7(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %458: i1, wd: %207: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %208, %u_pwm_param_5_phase_delay_5.qe after %1 : i1
    llhd.drv %211, %u_pwm_param_5_phase_delay_5.q after %1 : i16
    llhd.drv %core_pwm_param_5_phase_delay_5_qs_int, %u_pwm_param_5_phase_delay_5.qs after %1 : i16
    %212 = comb.extract %u_pwm_param_5_cdc.dst_wd_o from 30 : (i32) -> i1
    %213 = llhd.sig.extract %pwm_param_5_flds_we from %c1_i2 : <i3> -> <i1>
    %214 = llhd.sig.struct_extract %209["htbt_en"] : <!hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>
    %215 = llhd.sig.struct_extract %214["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_pwm_param_5_htbt_en_5.qe, %u_pwm_param_5_htbt_en_5.q, %u_pwm_param_5_htbt_en_5.ds, %u_pwm_param_5_htbt_en_5.qs = hw.instance "u_pwm_param_5_htbt_en_5" @prim_subreg_6(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %458: i1, wd: %212: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %213, %u_pwm_param_5_htbt_en_5.qe after %1 : i1
    llhd.drv %215, %u_pwm_param_5_htbt_en_5.q after %1 : i1
    llhd.drv %core_pwm_param_5_htbt_en_5_qs_int, %u_pwm_param_5_htbt_en_5.qs after %1 : i1
    %216 = comb.extract %u_pwm_param_5_cdc.dst_wd_o from 31 : (i32) -> i1
    %217 = llhd.sig.extract %pwm_param_5_flds_we from %c-2_i2 : <i3> -> <i1>
    %218 = llhd.sig.struct_extract %209["blink_en"] : <!hw.struct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>
    %219 = llhd.sig.struct_extract %218["q"] : <!hw.struct<q: i1, qe: i1>>
    %u_pwm_param_5_blink_en_5.qe, %u_pwm_param_5_blink_en_5.q, %u_pwm_param_5_blink_en_5.ds, %u_pwm_param_5_blink_en_5.qs = hw.instance "u_pwm_param_5_blink_en_5" @prim_subreg_6(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %458: i1, wd: %216: i1, de: %false: i1, d: %false: i1) -> (qe: i1, q: i1, ds: i1, qs: i1)
    llhd.drv %217, %u_pwm_param_5_blink_en_5.qe after %1 : i1
    llhd.drv %219, %u_pwm_param_5_blink_en_5.q after %1 : i1
    llhd.drv %core_pwm_param_5_blink_en_5_qs_int, %u_pwm_param_5_blink_en_5.qs after %1 : i1
    %220 = llhd.prb %duty_cycle_0_flds_we : i2
    %221 = comb.icmp eq %220, %c-1_i2 : i2
    %u_duty_cycle0_qe.q_o = hw.instance "u_duty_cycle0_qe" @prim_flop(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, d_i: %221: i1) -> (q_o: i1) {sv.namehint = "duty_cycle_0_qe"}
    %222 = comb.extract %u_duty_cycle_0_cdc.dst_wd_o from 0 : (i32) -> i16
    %223 = llhd.sig.extract %duty_cycle_0_flds_we from %false : <i2> -> <i1>
    %224 = llhd.sig.struct_extract %reg2hw["duty_cycle"] : <!hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>>
    %225 = llhd.sig.array_get %224[%c0_i3] : <!hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>>
    %226 = llhd.sig.struct_extract %225["a"] : <!hw.struct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>
    %227 = llhd.sig.struct_extract %226["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_duty_cycle_0_a_0.qe, %u_duty_cycle_0_a_0.q, %u_duty_cycle_0_a_0.ds, %u_duty_cycle_0_a_0.qs = hw.instance "u_duty_cycle_0_a_0" @prim_subreg_8(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %462: i1, wd: %222: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %223, %u_duty_cycle_0_a_0.qe after %1 : i1
    llhd.drv %227, %u_duty_cycle_0_a_0.q after %1 : i16
    llhd.drv %core_duty_cycle_0_a_0_qs_int, %u_duty_cycle_0_a_0.qs after %1 : i16
    %228 = comb.extract %u_duty_cycle_0_cdc.dst_wd_o from 16 : (i32) -> i16
    %229 = llhd.sig.extract %duty_cycle_0_flds_we from %true : <i2> -> <i1>
    %230 = llhd.sig.struct_extract %225["b"] : <!hw.struct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>
    %231 = llhd.sig.struct_extract %230["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_duty_cycle_0_b_0.qe, %u_duty_cycle_0_b_0.q, %u_duty_cycle_0_b_0.ds, %u_duty_cycle_0_b_0.qs = hw.instance "u_duty_cycle_0_b_0" @prim_subreg_8(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %462: i1, wd: %228: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %229, %u_duty_cycle_0_b_0.qe after %1 : i1
    llhd.drv %231, %u_duty_cycle_0_b_0.q after %1 : i16
    llhd.drv %core_duty_cycle_0_b_0_qs_int, %u_duty_cycle_0_b_0.qs after %1 : i16
    %232 = llhd.prb %duty_cycle_1_flds_we : i2
    %233 = comb.icmp eq %232, %c-1_i2 : i2
    %u_duty_cycle1_qe.q_o = hw.instance "u_duty_cycle1_qe" @prim_flop(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, d_i: %233: i1) -> (q_o: i1) {sv.namehint = "duty_cycle_1_qe"}
    %234 = comb.extract %u_duty_cycle_1_cdc.dst_wd_o from 0 : (i32) -> i16
    %235 = llhd.sig.extract %duty_cycle_1_flds_we from %false : <i2> -> <i1>
    %236 = llhd.sig.array_get %224[%c1_i3] : <!hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>>
    %237 = llhd.sig.struct_extract %236["a"] : <!hw.struct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>
    %238 = llhd.sig.struct_extract %237["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_duty_cycle_1_a_1.qe, %u_duty_cycle_1_a_1.q, %u_duty_cycle_1_a_1.ds, %u_duty_cycle_1_a_1.qs = hw.instance "u_duty_cycle_1_a_1" @prim_subreg_8(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %465: i1, wd: %234: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %235, %u_duty_cycle_1_a_1.qe after %1 : i1
    llhd.drv %238, %u_duty_cycle_1_a_1.q after %1 : i16
    llhd.drv %core_duty_cycle_1_a_1_qs_int, %u_duty_cycle_1_a_1.qs after %1 : i16
    %239 = comb.extract %u_duty_cycle_1_cdc.dst_wd_o from 16 : (i32) -> i16
    %240 = llhd.sig.extract %duty_cycle_1_flds_we from %true : <i2> -> <i1>
    %241 = llhd.sig.struct_extract %236["b"] : <!hw.struct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>
    %242 = llhd.sig.struct_extract %241["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_duty_cycle_1_b_1.qe, %u_duty_cycle_1_b_1.q, %u_duty_cycle_1_b_1.ds, %u_duty_cycle_1_b_1.qs = hw.instance "u_duty_cycle_1_b_1" @prim_subreg_8(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %465: i1, wd: %239: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %240, %u_duty_cycle_1_b_1.qe after %1 : i1
    llhd.drv %242, %u_duty_cycle_1_b_1.q after %1 : i16
    llhd.drv %core_duty_cycle_1_b_1_qs_int, %u_duty_cycle_1_b_1.qs after %1 : i16
    %243 = llhd.prb %duty_cycle_2_flds_we : i2
    %244 = comb.icmp eq %243, %c-1_i2 : i2
    %u_duty_cycle2_qe.q_o = hw.instance "u_duty_cycle2_qe" @prim_flop(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, d_i: %244: i1) -> (q_o: i1) {sv.namehint = "duty_cycle_2_qe"}
    %245 = comb.extract %u_duty_cycle_2_cdc.dst_wd_o from 0 : (i32) -> i16
    %246 = llhd.sig.extract %duty_cycle_2_flds_we from %false : <i2> -> <i1>
    %247 = llhd.sig.array_get %224[%c2_i3] : <!hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>>
    %248 = llhd.sig.struct_extract %247["a"] : <!hw.struct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>
    %249 = llhd.sig.struct_extract %248["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_duty_cycle_2_a_2.qe, %u_duty_cycle_2_a_2.q, %u_duty_cycle_2_a_2.ds, %u_duty_cycle_2_a_2.qs = hw.instance "u_duty_cycle_2_a_2" @prim_subreg_8(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %468: i1, wd: %245: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %246, %u_duty_cycle_2_a_2.qe after %1 : i1
    llhd.drv %249, %u_duty_cycle_2_a_2.q after %1 : i16
    llhd.drv %core_duty_cycle_2_a_2_qs_int, %u_duty_cycle_2_a_2.qs after %1 : i16
    %250 = comb.extract %u_duty_cycle_2_cdc.dst_wd_o from 16 : (i32) -> i16
    %251 = llhd.sig.extract %duty_cycle_2_flds_we from %true : <i2> -> <i1>
    %252 = llhd.sig.struct_extract %247["b"] : <!hw.struct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>
    %253 = llhd.sig.struct_extract %252["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_duty_cycle_2_b_2.qe, %u_duty_cycle_2_b_2.q, %u_duty_cycle_2_b_2.ds, %u_duty_cycle_2_b_2.qs = hw.instance "u_duty_cycle_2_b_2" @prim_subreg_8(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %468: i1, wd: %250: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %251, %u_duty_cycle_2_b_2.qe after %1 : i1
    llhd.drv %253, %u_duty_cycle_2_b_2.q after %1 : i16
    llhd.drv %core_duty_cycle_2_b_2_qs_int, %u_duty_cycle_2_b_2.qs after %1 : i16
    %254 = llhd.prb %duty_cycle_3_flds_we : i2
    %255 = comb.icmp eq %254, %c-1_i2 : i2
    %u_duty_cycle3_qe.q_o = hw.instance "u_duty_cycle3_qe" @prim_flop(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, d_i: %255: i1) -> (q_o: i1) {sv.namehint = "duty_cycle_3_qe"}
    %256 = comb.extract %u_duty_cycle_3_cdc.dst_wd_o from 0 : (i32) -> i16
    %257 = llhd.sig.extract %duty_cycle_3_flds_we from %false : <i2> -> <i1>
    %258 = llhd.sig.array_get %224[%c3_i3] : <!hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>>
    %259 = llhd.sig.struct_extract %258["a"] : <!hw.struct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>
    %260 = llhd.sig.struct_extract %259["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_duty_cycle_3_a_3.qe, %u_duty_cycle_3_a_3.q, %u_duty_cycle_3_a_3.ds, %u_duty_cycle_3_a_3.qs = hw.instance "u_duty_cycle_3_a_3" @prim_subreg_8(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %471: i1, wd: %256: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %257, %u_duty_cycle_3_a_3.qe after %1 : i1
    llhd.drv %260, %u_duty_cycle_3_a_3.q after %1 : i16
    llhd.drv %core_duty_cycle_3_a_3_qs_int, %u_duty_cycle_3_a_3.qs after %1 : i16
    %261 = comb.extract %u_duty_cycle_3_cdc.dst_wd_o from 16 : (i32) -> i16
    %262 = llhd.sig.extract %duty_cycle_3_flds_we from %true : <i2> -> <i1>
    %263 = llhd.sig.struct_extract %258["b"] : <!hw.struct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>
    %264 = llhd.sig.struct_extract %263["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_duty_cycle_3_b_3.qe, %u_duty_cycle_3_b_3.q, %u_duty_cycle_3_b_3.ds, %u_duty_cycle_3_b_3.qs = hw.instance "u_duty_cycle_3_b_3" @prim_subreg_8(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %471: i1, wd: %261: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %262, %u_duty_cycle_3_b_3.qe after %1 : i1
    llhd.drv %264, %u_duty_cycle_3_b_3.q after %1 : i16
    llhd.drv %core_duty_cycle_3_b_3_qs_int, %u_duty_cycle_3_b_3.qs after %1 : i16
    %265 = llhd.prb %duty_cycle_4_flds_we : i2
    %266 = comb.icmp eq %265, %c-1_i2 : i2
    %u_duty_cycle4_qe.q_o = hw.instance "u_duty_cycle4_qe" @prim_flop(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, d_i: %266: i1) -> (q_o: i1) {sv.namehint = "duty_cycle_4_qe"}
    %267 = comb.extract %u_duty_cycle_4_cdc.dst_wd_o from 0 : (i32) -> i16
    %268 = llhd.sig.extract %duty_cycle_4_flds_we from %false : <i2> -> <i1>
    %269 = llhd.sig.array_get %224[%c-4_i3] : <!hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>>
    %270 = llhd.sig.struct_extract %269["a"] : <!hw.struct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>
    %271 = llhd.sig.struct_extract %270["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_duty_cycle_4_a_4.qe, %u_duty_cycle_4_a_4.q, %u_duty_cycle_4_a_4.ds, %u_duty_cycle_4_a_4.qs = hw.instance "u_duty_cycle_4_a_4" @prim_subreg_8(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %474: i1, wd: %267: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %268, %u_duty_cycle_4_a_4.qe after %1 : i1
    llhd.drv %271, %u_duty_cycle_4_a_4.q after %1 : i16
    llhd.drv %core_duty_cycle_4_a_4_qs_int, %u_duty_cycle_4_a_4.qs after %1 : i16
    %272 = comb.extract %u_duty_cycle_4_cdc.dst_wd_o from 16 : (i32) -> i16
    %273 = llhd.sig.extract %duty_cycle_4_flds_we from %true : <i2> -> <i1>
    %274 = llhd.sig.struct_extract %269["b"] : <!hw.struct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>
    %275 = llhd.sig.struct_extract %274["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_duty_cycle_4_b_4.qe, %u_duty_cycle_4_b_4.q, %u_duty_cycle_4_b_4.ds, %u_duty_cycle_4_b_4.qs = hw.instance "u_duty_cycle_4_b_4" @prim_subreg_8(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %474: i1, wd: %272: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %273, %u_duty_cycle_4_b_4.qe after %1 : i1
    llhd.drv %275, %u_duty_cycle_4_b_4.q after %1 : i16
    llhd.drv %core_duty_cycle_4_b_4_qs_int, %u_duty_cycle_4_b_4.qs after %1 : i16
    %276 = llhd.prb %duty_cycle_5_flds_we : i2
    %277 = comb.icmp eq %276, %c-1_i2 : i2
    %u_duty_cycle5_qe.q_o = hw.instance "u_duty_cycle5_qe" @prim_flop(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, d_i: %277: i1) -> (q_o: i1) {sv.namehint = "duty_cycle_5_qe"}
    %278 = comb.extract %u_duty_cycle_5_cdc.dst_wd_o from 0 : (i32) -> i16
    %279 = llhd.sig.extract %duty_cycle_5_flds_we from %false : <i2> -> <i1>
    %280 = llhd.sig.array_get %224[%c-3_i3] : <!hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>>
    %281 = llhd.sig.struct_extract %280["a"] : <!hw.struct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>
    %282 = llhd.sig.struct_extract %281["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_duty_cycle_5_a_5.qe, %u_duty_cycle_5_a_5.q, %u_duty_cycle_5_a_5.ds, %u_duty_cycle_5_a_5.qs = hw.instance "u_duty_cycle_5_a_5" @prim_subreg_8(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %477: i1, wd: %278: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %279, %u_duty_cycle_5_a_5.qe after %1 : i1
    llhd.drv %282, %u_duty_cycle_5_a_5.q after %1 : i16
    llhd.drv %core_duty_cycle_5_a_5_qs_int, %u_duty_cycle_5_a_5.qs after %1 : i16
    %283 = comb.extract %u_duty_cycle_5_cdc.dst_wd_o from 16 : (i32) -> i16
    %284 = llhd.sig.extract %duty_cycle_5_flds_we from %true : <i2> -> <i1>
    %285 = llhd.sig.struct_extract %280["b"] : <!hw.struct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>
    %286 = llhd.sig.struct_extract %285["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_duty_cycle_5_b_5.qe, %u_duty_cycle_5_b_5.q, %u_duty_cycle_5_b_5.ds, %u_duty_cycle_5_b_5.qs = hw.instance "u_duty_cycle_5_b_5" @prim_subreg_8(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %477: i1, wd: %283: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %284, %u_duty_cycle_5_b_5.qe after %1 : i1
    llhd.drv %286, %u_duty_cycle_5_b_5.q after %1 : i16
    llhd.drv %core_duty_cycle_5_b_5_qs_int, %u_duty_cycle_5_b_5.qs after %1 : i16
    %287 = llhd.prb %blink_param_0_flds_we : i2
    %288 = comb.icmp eq %287, %c-1_i2 : i2
    %u_blink_param0_qe.q_o = hw.instance "u_blink_param0_qe" @prim_flop(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, d_i: %288: i1) -> (q_o: i1) {sv.namehint = "blink_param_0_qe"}
    %289 = comb.extract %u_blink_param_0_cdc.dst_wd_o from 0 : (i32) -> i16
    %290 = llhd.sig.extract %blink_param_0_flds_we from %false : <i2> -> <i1>
    %291 = llhd.sig.struct_extract %reg2hw["blink_param"] : <!hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>>
    %292 = llhd.sig.array_get %291[%c0_i3] : <!hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
    %293 = llhd.sig.struct_extract %292["x"] : <!hw.struct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>
    %294 = llhd.sig.struct_extract %293["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_blink_param_0_x_0.qe, %u_blink_param_0_x_0.q, %u_blink_param_0_x_0.ds, %u_blink_param_0_x_0.qs = hw.instance "u_blink_param_0_x_0" @prim_subreg_7(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %480: i1, wd: %289: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %290, %u_blink_param_0_x_0.qe after %1 : i1
    llhd.drv %294, %u_blink_param_0_x_0.q after %1 : i16
    llhd.drv %core_blink_param_0_x_0_qs_int, %u_blink_param_0_x_0.qs after %1 : i16
    %295 = comb.extract %u_blink_param_0_cdc.dst_wd_o from 16 : (i32) -> i16
    %296 = llhd.sig.extract %blink_param_0_flds_we from %true : <i2> -> <i1>
    %297 = llhd.sig.struct_extract %292["y"] : <!hw.struct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>
    %298 = llhd.sig.struct_extract %297["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_blink_param_0_y_0.qe, %u_blink_param_0_y_0.q, %u_blink_param_0_y_0.ds, %u_blink_param_0_y_0.qs = hw.instance "u_blink_param_0_y_0" @prim_subreg_7(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %480: i1, wd: %295: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %296, %u_blink_param_0_y_0.qe after %1 : i1
    llhd.drv %298, %u_blink_param_0_y_0.q after %1 : i16
    llhd.drv %core_blink_param_0_y_0_qs_int, %u_blink_param_0_y_0.qs after %1 : i16
    %299 = llhd.prb %blink_param_1_flds_we : i2
    %300 = comb.icmp eq %299, %c-1_i2 : i2
    %u_blink_param1_qe.q_o = hw.instance "u_blink_param1_qe" @prim_flop(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, d_i: %300: i1) -> (q_o: i1) {sv.namehint = "blink_param_1_qe"}
    %301 = comb.extract %u_blink_param_1_cdc.dst_wd_o from 0 : (i32) -> i16
    %302 = llhd.sig.extract %blink_param_1_flds_we from %false : <i2> -> <i1>
    %303 = llhd.sig.array_get %291[%c1_i3] : <!hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
    %304 = llhd.sig.struct_extract %303["x"] : <!hw.struct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>
    %305 = llhd.sig.struct_extract %304["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_blink_param_1_x_1.qe, %u_blink_param_1_x_1.q, %u_blink_param_1_x_1.ds, %u_blink_param_1_x_1.qs = hw.instance "u_blink_param_1_x_1" @prim_subreg_7(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %483: i1, wd: %301: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %302, %u_blink_param_1_x_1.qe after %1 : i1
    llhd.drv %305, %u_blink_param_1_x_1.q after %1 : i16
    llhd.drv %core_blink_param_1_x_1_qs_int, %u_blink_param_1_x_1.qs after %1 : i16
    %306 = comb.extract %u_blink_param_1_cdc.dst_wd_o from 16 : (i32) -> i16
    %307 = llhd.sig.extract %blink_param_1_flds_we from %true : <i2> -> <i1>
    %308 = llhd.sig.struct_extract %303["y"] : <!hw.struct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>
    %309 = llhd.sig.struct_extract %308["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_blink_param_1_y_1.qe, %u_blink_param_1_y_1.q, %u_blink_param_1_y_1.ds, %u_blink_param_1_y_1.qs = hw.instance "u_blink_param_1_y_1" @prim_subreg_7(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %483: i1, wd: %306: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %307, %u_blink_param_1_y_1.qe after %1 : i1
    llhd.drv %309, %u_blink_param_1_y_1.q after %1 : i16
    llhd.drv %core_blink_param_1_y_1_qs_int, %u_blink_param_1_y_1.qs after %1 : i16
    %310 = llhd.prb %blink_param_2_flds_we : i2
    %311 = comb.icmp eq %310, %c-1_i2 : i2
    %u_blink_param2_qe.q_o = hw.instance "u_blink_param2_qe" @prim_flop(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, d_i: %311: i1) -> (q_o: i1) {sv.namehint = "blink_param_2_qe"}
    %312 = comb.extract %u_blink_param_2_cdc.dst_wd_o from 0 : (i32) -> i16
    %313 = llhd.sig.extract %blink_param_2_flds_we from %false : <i2> -> <i1>
    %314 = llhd.sig.array_get %291[%c2_i3] : <!hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
    %315 = llhd.sig.struct_extract %314["x"] : <!hw.struct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>
    %316 = llhd.sig.struct_extract %315["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_blink_param_2_x_2.qe, %u_blink_param_2_x_2.q, %u_blink_param_2_x_2.ds, %u_blink_param_2_x_2.qs = hw.instance "u_blink_param_2_x_2" @prim_subreg_7(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %486: i1, wd: %312: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %313, %u_blink_param_2_x_2.qe after %1 : i1
    llhd.drv %316, %u_blink_param_2_x_2.q after %1 : i16
    llhd.drv %core_blink_param_2_x_2_qs_int, %u_blink_param_2_x_2.qs after %1 : i16
    %317 = comb.extract %u_blink_param_2_cdc.dst_wd_o from 16 : (i32) -> i16
    %318 = llhd.sig.extract %blink_param_2_flds_we from %true : <i2> -> <i1>
    %319 = llhd.sig.struct_extract %314["y"] : <!hw.struct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>
    %320 = llhd.sig.struct_extract %319["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_blink_param_2_y_2.qe, %u_blink_param_2_y_2.q, %u_blink_param_2_y_2.ds, %u_blink_param_2_y_2.qs = hw.instance "u_blink_param_2_y_2" @prim_subreg_7(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %486: i1, wd: %317: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %318, %u_blink_param_2_y_2.qe after %1 : i1
    llhd.drv %320, %u_blink_param_2_y_2.q after %1 : i16
    llhd.drv %core_blink_param_2_y_2_qs_int, %u_blink_param_2_y_2.qs after %1 : i16
    %321 = llhd.prb %blink_param_3_flds_we : i2
    %322 = comb.icmp eq %321, %c-1_i2 : i2
    %u_blink_param3_qe.q_o = hw.instance "u_blink_param3_qe" @prim_flop(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, d_i: %322: i1) -> (q_o: i1) {sv.namehint = "blink_param_3_qe"}
    %323 = comb.extract %u_blink_param_3_cdc.dst_wd_o from 0 : (i32) -> i16
    %324 = llhd.sig.extract %blink_param_3_flds_we from %false : <i2> -> <i1>
    %325 = llhd.sig.array_get %291[%c3_i3] : <!hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
    %326 = llhd.sig.struct_extract %325["x"] : <!hw.struct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>
    %327 = llhd.sig.struct_extract %326["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_blink_param_3_x_3.qe, %u_blink_param_3_x_3.q, %u_blink_param_3_x_3.ds, %u_blink_param_3_x_3.qs = hw.instance "u_blink_param_3_x_3" @prim_subreg_7(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %489: i1, wd: %323: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %324, %u_blink_param_3_x_3.qe after %1 : i1
    llhd.drv %327, %u_blink_param_3_x_3.q after %1 : i16
    llhd.drv %core_blink_param_3_x_3_qs_int, %u_blink_param_3_x_3.qs after %1 : i16
    %328 = comb.extract %u_blink_param_3_cdc.dst_wd_o from 16 : (i32) -> i16
    %329 = llhd.sig.extract %blink_param_3_flds_we from %true : <i2> -> <i1>
    %330 = llhd.sig.struct_extract %325["y"] : <!hw.struct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>
    %331 = llhd.sig.struct_extract %330["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_blink_param_3_y_3.qe, %u_blink_param_3_y_3.q, %u_blink_param_3_y_3.ds, %u_blink_param_3_y_3.qs = hw.instance "u_blink_param_3_y_3" @prim_subreg_7(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %489: i1, wd: %328: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %329, %u_blink_param_3_y_3.qe after %1 : i1
    llhd.drv %331, %u_blink_param_3_y_3.q after %1 : i16
    llhd.drv %core_blink_param_3_y_3_qs_int, %u_blink_param_3_y_3.qs after %1 : i16
    %332 = llhd.prb %blink_param_4_flds_we : i2
    %333 = comb.icmp eq %332, %c-1_i2 : i2
    %u_blink_param4_qe.q_o = hw.instance "u_blink_param4_qe" @prim_flop(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, d_i: %333: i1) -> (q_o: i1) {sv.namehint = "blink_param_4_qe"}
    %334 = comb.extract %u_blink_param_4_cdc.dst_wd_o from 0 : (i32) -> i16
    %335 = llhd.sig.extract %blink_param_4_flds_we from %false : <i2> -> <i1>
    %336 = llhd.sig.array_get %291[%c-4_i3] : <!hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
    %337 = llhd.sig.struct_extract %336["x"] : <!hw.struct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>
    %338 = llhd.sig.struct_extract %337["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_blink_param_4_x_4.qe, %u_blink_param_4_x_4.q, %u_blink_param_4_x_4.ds, %u_blink_param_4_x_4.qs = hw.instance "u_blink_param_4_x_4" @prim_subreg_7(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %492: i1, wd: %334: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %335, %u_blink_param_4_x_4.qe after %1 : i1
    llhd.drv %338, %u_blink_param_4_x_4.q after %1 : i16
    llhd.drv %core_blink_param_4_x_4_qs_int, %u_blink_param_4_x_4.qs after %1 : i16
    %339 = comb.extract %u_blink_param_4_cdc.dst_wd_o from 16 : (i32) -> i16
    %340 = llhd.sig.extract %blink_param_4_flds_we from %true : <i2> -> <i1>
    %341 = llhd.sig.struct_extract %336["y"] : <!hw.struct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>
    %342 = llhd.sig.struct_extract %341["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_blink_param_4_y_4.qe, %u_blink_param_4_y_4.q, %u_blink_param_4_y_4.ds, %u_blink_param_4_y_4.qs = hw.instance "u_blink_param_4_y_4" @prim_subreg_7(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %492: i1, wd: %339: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %340, %u_blink_param_4_y_4.qe after %1 : i1
    llhd.drv %342, %u_blink_param_4_y_4.q after %1 : i16
    llhd.drv %core_blink_param_4_y_4_qs_int, %u_blink_param_4_y_4.qs after %1 : i16
    %343 = llhd.prb %blink_param_5_flds_we : i2
    %344 = comb.icmp eq %343, %c-1_i2 : i2
    %u_blink_param5_qe.q_o = hw.instance "u_blink_param5_qe" @prim_flop(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, d_i: %344: i1) -> (q_o: i1) {sv.namehint = "blink_param_5_qe"}
    %345 = comb.extract %u_blink_param_5_cdc.dst_wd_o from 0 : (i32) -> i16
    %346 = llhd.sig.extract %blink_param_5_flds_we from %false : <i2> -> <i1>
    %347 = llhd.sig.array_get %291[%c-3_i3] : <!hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
    %348 = llhd.sig.struct_extract %347["x"] : <!hw.struct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>
    %349 = llhd.sig.struct_extract %348["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_blink_param_5_x_5.qe, %u_blink_param_5_x_5.q, %u_blink_param_5_x_5.ds, %u_blink_param_5_x_5.qs = hw.instance "u_blink_param_5_x_5" @prim_subreg_7(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %495: i1, wd: %345: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %346, %u_blink_param_5_x_5.qe after %1 : i1
    llhd.drv %349, %u_blink_param_5_x_5.q after %1 : i16
    llhd.drv %core_blink_param_5_x_5_qs_int, %u_blink_param_5_x_5.qs after %1 : i16
    %350 = comb.extract %u_blink_param_5_cdc.dst_wd_o from 16 : (i32) -> i16
    %351 = llhd.sig.extract %blink_param_5_flds_we from %true : <i2> -> <i1>
    %352 = llhd.sig.struct_extract %347["y"] : <!hw.struct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>
    %353 = llhd.sig.struct_extract %352["q"] : <!hw.struct<q: i16, qe: i1>>
    %u_blink_param_5_y_5.qe, %u_blink_param_5_y_5.q, %u_blink_param_5_y_5.ds, %u_blink_param_5_y_5.qs = hw.instance "u_blink_param_5_y_5" @prim_subreg_7(clk_i: %clk_core_i: i1, rst_ni: %rst_core_ni: i1, we: %495: i1, wd: %350: i16, de: %false: i1, d: %c0_i16: i16) -> (qe: i1, q: i16, ds: i16, qs: i16)
    llhd.drv %351, %u_blink_param_5_y_5.qe after %1 : i1
    llhd.drv %353, %u_blink_param_5_y_5.q after %1 : i16
    llhd.drv %core_blink_param_5_y_5_qs_int, %u_blink_param_5_y_5.qs after %1 : i16
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 5 preds: ^bb0, ^bb2, ^bb4, ^bb5, ^bb6
      %615 = llhd.prb %clk_i_0 : i1
      %616 = llhd.prb %rst_ni_1 : i1
      llhd.wait (%5, %6 : i1, i1), ^bb2
    ^bb2:  // pred: ^bb1
      %617 = llhd.prb %clk_i_0 : i1
      %618 = comb.xor bin %615, %true : i1
      %619 = comb.and bin %618, %617 : i1
      %620 = llhd.prb %rst_ni_1 : i1
      %621 = comb.xor bin %620, %true : i1
      %622 = comb.and bin %616, %621 : i1
      %623 = comb.or bin %619, %622 : i1
      cf.cond_br %623, ^bb3, ^bb1
    ^bb3:  // pred: ^bb2
      %624 = llhd.prb %rst_ni_1 : i1
      %625 = comb.xor %624, %true : i1
      cf.cond_br %625, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      llhd.drv %err_q, %false after %0 : i1
      cf.br ^bb1
    ^bb5:  // pred: ^bb3
      %626 = llhd.prb %intg_err : i1
      %627 = llhd.prb %reg_we_err : i1
      %628 = comb.or %626, %627 : i1
      cf.cond_br %628, ^bb6, ^bb1
    ^bb6:  // pred: ^bb5
      llhd.drv %err_q, %true after %0 : i1
      cf.br ^bb1
    }
    %354 = llhd.prb %err_q : i1
    %355 = llhd.prb %intg_err : i1
    %356 = llhd.prb %reg_we_err : i1
    %357 = comb.or %354, %355, %356 : i1
    %358 = llhd.prb %reg_rdata_next {sv.namehint = "reg_rdata"} : i32
    %359 = llhd.prb %wr_err : i1
    %360 = comb.or %507, %359, %355 {sv.namehint = "reg_error"} : i1
    %361 = llhd.prb %core_cfg_clk_div_qs_int : i27
    %362 = llhd.prb %core_cfg_dc_resn_qs_int : i4
    %363 = llhd.prb %core_cfg_cntr_en_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %core_cfg_qs, %c939556864_i32 after %1 : i32
      %615 = llhd.sig.extract %core_cfg_qs from %c0_i5 : <i32> -> <i27>
      %616 = llhd.prb %core_cfg_clk_div_qs_int : i27
      llhd.drv %615, %616 after %1 : i27
      %617 = llhd.sig.extract %core_cfg_qs from %c-5_i5 : <i32> -> <i4>
      %618 = llhd.prb %core_cfg_dc_resn_qs_int : i4
      llhd.drv %617, %618 after %1 : i4
      %619 = llhd.sig.extract %core_cfg_qs from %c-1_i5 : <i32> -> <i1>
      %620 = llhd.prb %core_cfg_cntr_en_qs_int : i1
      llhd.drv %619, %620 after %1 : i1
      llhd.wait (%14, %361, %362, %363 : i32, i27, i4, i1), ^bb1
    }
    %364 = llhd.prb %core_pwm_en_en_0_qs_int : i1
    %365 = llhd.prb %core_pwm_en_en_1_qs_int : i1
    %366 = llhd.prb %core_pwm_en_en_2_qs_int : i1
    %367 = llhd.prb %core_pwm_en_en_3_qs_int : i1
    %368 = llhd.prb %core_pwm_en_en_4_qs_int : i1
    %369 = llhd.prb %core_pwm_en_en_5_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %core_pwm_en_qs, %c0_i6 after %1 : i6
      %615 = llhd.sig.extract %core_pwm_en_qs from %c0_i3 : <i6> -> <i1>
      %616 = llhd.prb %core_pwm_en_en_0_qs_int : i1
      llhd.drv %615, %616 after %1 : i1
      %617 = llhd.sig.extract %core_pwm_en_qs from %c1_i3 : <i6> -> <i1>
      %618 = llhd.prb %core_pwm_en_en_1_qs_int : i1
      llhd.drv %617, %618 after %1 : i1
      %619 = llhd.sig.extract %core_pwm_en_qs from %c2_i3 : <i6> -> <i1>
      %620 = llhd.prb %core_pwm_en_en_2_qs_int : i1
      llhd.drv %619, %620 after %1 : i1
      %621 = llhd.sig.extract %core_pwm_en_qs from %c3_i3 : <i6> -> <i1>
      %622 = llhd.prb %core_pwm_en_en_3_qs_int : i1
      llhd.drv %621, %622 after %1 : i1
      %623 = llhd.sig.extract %core_pwm_en_qs from %c-4_i3 : <i6> -> <i1>
      %624 = llhd.prb %core_pwm_en_en_4_qs_int : i1
      llhd.drv %623, %624 after %1 : i1
      %625 = llhd.sig.extract %core_pwm_en_qs from %c-3_i3 : <i6> -> <i1>
      %626 = llhd.prb %core_pwm_en_en_5_qs_int : i1
      llhd.drv %625, %626 after %1 : i1
      llhd.wait (%17, %364, %365, %366, %367, %368, %369 : i6, i1, i1, i1, i1, i1, i1), ^bb1
    }
    %370 = llhd.prb %core_invert_invert_0_qs_int : i1
    %371 = llhd.prb %core_invert_invert_1_qs_int : i1
    %372 = llhd.prb %core_invert_invert_2_qs_int : i1
    %373 = llhd.prb %core_invert_invert_3_qs_int : i1
    %374 = llhd.prb %core_invert_invert_4_qs_int : i1
    %375 = llhd.prb %core_invert_invert_5_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %core_invert_qs, %c0_i6 after %1 : i6
      %615 = llhd.sig.extract %core_invert_qs from %c0_i3 : <i6> -> <i1>
      %616 = llhd.prb %core_invert_invert_0_qs_int : i1
      llhd.drv %615, %616 after %1 : i1
      %617 = llhd.sig.extract %core_invert_qs from %c1_i3 : <i6> -> <i1>
      %618 = llhd.prb %core_invert_invert_1_qs_int : i1
      llhd.drv %617, %618 after %1 : i1
      %619 = llhd.sig.extract %core_invert_qs from %c2_i3 : <i6> -> <i1>
      %620 = llhd.prb %core_invert_invert_2_qs_int : i1
      llhd.drv %619, %620 after %1 : i1
      %621 = llhd.sig.extract %core_invert_qs from %c3_i3 : <i6> -> <i1>
      %622 = llhd.prb %core_invert_invert_3_qs_int : i1
      llhd.drv %621, %622 after %1 : i1
      %623 = llhd.sig.extract %core_invert_qs from %c-4_i3 : <i6> -> <i1>
      %624 = llhd.prb %core_invert_invert_4_qs_int : i1
      llhd.drv %623, %624 after %1 : i1
      %625 = llhd.sig.extract %core_invert_qs from %c-3_i3 : <i6> -> <i1>
      %626 = llhd.prb %core_invert_invert_5_qs_int : i1
      llhd.drv %625, %626 after %1 : i1
      llhd.wait (%19, %370, %371, %372, %373, %374, %375 : i6, i1, i1, i1, i1, i1, i1), ^bb1
    }
    %376 = llhd.prb %core_pwm_param_0_phase_delay_0_qs_int : i16
    %377 = llhd.prb %core_pwm_param_0_htbt_en_0_qs_int : i1
    %378 = llhd.prb %core_pwm_param_0_blink_en_0_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %core_pwm_param_0_qs, %c0_i32 after %1 : i32
      %615 = llhd.sig.extract %core_pwm_param_0_qs from %c0_i5 : <i32> -> <i16>
      %616 = llhd.prb %core_pwm_param_0_phase_delay_0_qs_int : i16
      llhd.drv %615, %616 after %1 : i16
      %617 = llhd.sig.extract %core_pwm_param_0_qs from %c-2_i5 : <i32> -> <i1>
      %618 = llhd.prb %core_pwm_param_0_htbt_en_0_qs_int : i1
      llhd.drv %617, %618 after %1 : i1
      %619 = llhd.sig.extract %core_pwm_param_0_qs from %c-1_i5 : <i32> -> <i1>
      %620 = llhd.prb %core_pwm_param_0_blink_en_0_qs_int : i1
      llhd.drv %619, %620 after %1 : i1
      llhd.wait (%21, %376, %377, %378 : i32, i16, i1, i1), ^bb1
    }
    %379 = llhd.prb %core_pwm_param_1_phase_delay_1_qs_int : i16
    %380 = llhd.prb %core_pwm_param_1_htbt_en_1_qs_int : i1
    %381 = llhd.prb %core_pwm_param_1_blink_en_1_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %core_pwm_param_1_qs, %c0_i32 after %1 : i32
      %615 = llhd.sig.extract %core_pwm_param_1_qs from %c0_i5 : <i32> -> <i16>
      %616 = llhd.prb %core_pwm_param_1_phase_delay_1_qs_int : i16
      llhd.drv %615, %616 after %1 : i16
      %617 = llhd.sig.extract %core_pwm_param_1_qs from %c-2_i5 : <i32> -> <i1>
      %618 = llhd.prb %core_pwm_param_1_htbt_en_1_qs_int : i1
      llhd.drv %617, %618 after %1 : i1
      %619 = llhd.sig.extract %core_pwm_param_1_qs from %c-1_i5 : <i32> -> <i1>
      %620 = llhd.prb %core_pwm_param_1_blink_en_1_qs_int : i1
      llhd.drv %619, %620 after %1 : i1
      llhd.wait (%23, %379, %380, %381 : i32, i16, i1, i1), ^bb1
    }
    %382 = llhd.prb %core_pwm_param_2_phase_delay_2_qs_int : i16
    %383 = llhd.prb %core_pwm_param_2_htbt_en_2_qs_int : i1
    %384 = llhd.prb %core_pwm_param_2_blink_en_2_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %core_pwm_param_2_qs, %c0_i32 after %1 : i32
      %615 = llhd.sig.extract %core_pwm_param_2_qs from %c0_i5 : <i32> -> <i16>
      %616 = llhd.prb %core_pwm_param_2_phase_delay_2_qs_int : i16
      llhd.drv %615, %616 after %1 : i16
      %617 = llhd.sig.extract %core_pwm_param_2_qs from %c-2_i5 : <i32> -> <i1>
      %618 = llhd.prb %core_pwm_param_2_htbt_en_2_qs_int : i1
      llhd.drv %617, %618 after %1 : i1
      %619 = llhd.sig.extract %core_pwm_param_2_qs from %c-1_i5 : <i32> -> <i1>
      %620 = llhd.prb %core_pwm_param_2_blink_en_2_qs_int : i1
      llhd.drv %619, %620 after %1 : i1
      llhd.wait (%25, %382, %383, %384 : i32, i16, i1, i1), ^bb1
    }
    %385 = llhd.prb %core_pwm_param_3_phase_delay_3_qs_int : i16
    %386 = llhd.prb %core_pwm_param_3_htbt_en_3_qs_int : i1
    %387 = llhd.prb %core_pwm_param_3_blink_en_3_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %core_pwm_param_3_qs, %c0_i32 after %1 : i32
      %615 = llhd.sig.extract %core_pwm_param_3_qs from %c0_i5 : <i32> -> <i16>
      %616 = llhd.prb %core_pwm_param_3_phase_delay_3_qs_int : i16
      llhd.drv %615, %616 after %1 : i16
      %617 = llhd.sig.extract %core_pwm_param_3_qs from %c-2_i5 : <i32> -> <i1>
      %618 = llhd.prb %core_pwm_param_3_htbt_en_3_qs_int : i1
      llhd.drv %617, %618 after %1 : i1
      %619 = llhd.sig.extract %core_pwm_param_3_qs from %c-1_i5 : <i32> -> <i1>
      %620 = llhd.prb %core_pwm_param_3_blink_en_3_qs_int : i1
      llhd.drv %619, %620 after %1 : i1
      llhd.wait (%27, %385, %386, %387 : i32, i16, i1, i1), ^bb1
    }
    %388 = llhd.prb %core_pwm_param_4_phase_delay_4_qs_int : i16
    %389 = llhd.prb %core_pwm_param_4_htbt_en_4_qs_int : i1
    %390 = llhd.prb %core_pwm_param_4_blink_en_4_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %core_pwm_param_4_qs, %c0_i32 after %1 : i32
      %615 = llhd.sig.extract %core_pwm_param_4_qs from %c0_i5 : <i32> -> <i16>
      %616 = llhd.prb %core_pwm_param_4_phase_delay_4_qs_int : i16
      llhd.drv %615, %616 after %1 : i16
      %617 = llhd.sig.extract %core_pwm_param_4_qs from %c-2_i5 : <i32> -> <i1>
      %618 = llhd.prb %core_pwm_param_4_htbt_en_4_qs_int : i1
      llhd.drv %617, %618 after %1 : i1
      %619 = llhd.sig.extract %core_pwm_param_4_qs from %c-1_i5 : <i32> -> <i1>
      %620 = llhd.prb %core_pwm_param_4_blink_en_4_qs_int : i1
      llhd.drv %619, %620 after %1 : i1
      llhd.wait (%29, %388, %389, %390 : i32, i16, i1, i1), ^bb1
    }
    %391 = llhd.prb %core_pwm_param_5_phase_delay_5_qs_int : i16
    %392 = llhd.prb %core_pwm_param_5_htbt_en_5_qs_int : i1
    %393 = llhd.prb %core_pwm_param_5_blink_en_5_qs_int : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %core_pwm_param_5_qs, %c0_i32 after %1 : i32
      %615 = llhd.sig.extract %core_pwm_param_5_qs from %c0_i5 : <i32> -> <i16>
      %616 = llhd.prb %core_pwm_param_5_phase_delay_5_qs_int : i16
      llhd.drv %615, %616 after %1 : i16
      %617 = llhd.sig.extract %core_pwm_param_5_qs from %c-2_i5 : <i32> -> <i1>
      %618 = llhd.prb %core_pwm_param_5_htbt_en_5_qs_int : i1
      llhd.drv %617, %618 after %1 : i1
      %619 = llhd.sig.extract %core_pwm_param_5_qs from %c-1_i5 : <i32> -> <i1>
      %620 = llhd.prb %core_pwm_param_5_blink_en_5_qs_int : i1
      llhd.drv %619, %620 after %1 : i1
      llhd.wait (%31, %391, %392, %393 : i32, i16, i1, i1), ^bb1
    }
    %394 = llhd.prb %core_duty_cycle_0_a_0_qs_int : i16
    %395 = llhd.prb %core_duty_cycle_0_b_0_qs_int : i16
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %core_duty_cycle_0_qs, %c2147450879_i32 after %1 : i32
      %615 = llhd.sig.extract %core_duty_cycle_0_qs from %c0_i5 : <i32> -> <i16>
      %616 = llhd.prb %core_duty_cycle_0_a_0_qs_int : i16
      llhd.drv %615, %616 after %1 : i16
      %617 = llhd.sig.extract %core_duty_cycle_0_qs from %c-16_i5 : <i32> -> <i16>
      %618 = llhd.prb %core_duty_cycle_0_b_0_qs_int : i16
      llhd.drv %617, %618 after %1 : i16
      llhd.wait (%33, %394, %395 : i32, i16, i16), ^bb1
    }
    %396 = llhd.prb %core_duty_cycle_1_a_1_qs_int : i16
    %397 = llhd.prb %core_duty_cycle_1_b_1_qs_int : i16
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %core_duty_cycle_1_qs, %c2147450879_i32 after %1 : i32
      %615 = llhd.sig.extract %core_duty_cycle_1_qs from %c0_i5 : <i32> -> <i16>
      %616 = llhd.prb %core_duty_cycle_1_a_1_qs_int : i16
      llhd.drv %615, %616 after %1 : i16
      %617 = llhd.sig.extract %core_duty_cycle_1_qs from %c-16_i5 : <i32> -> <i16>
      %618 = llhd.prb %core_duty_cycle_1_b_1_qs_int : i16
      llhd.drv %617, %618 after %1 : i16
      llhd.wait (%35, %396, %397 : i32, i16, i16), ^bb1
    }
    %398 = llhd.prb %core_duty_cycle_2_a_2_qs_int : i16
    %399 = llhd.prb %core_duty_cycle_2_b_2_qs_int : i16
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %core_duty_cycle_2_qs, %c2147450879_i32 after %1 : i32
      %615 = llhd.sig.extract %core_duty_cycle_2_qs from %c0_i5 : <i32> -> <i16>
      %616 = llhd.prb %core_duty_cycle_2_a_2_qs_int : i16
      llhd.drv %615, %616 after %1 : i16
      %617 = llhd.sig.extract %core_duty_cycle_2_qs from %c-16_i5 : <i32> -> <i16>
      %618 = llhd.prb %core_duty_cycle_2_b_2_qs_int : i16
      llhd.drv %617, %618 after %1 : i16
      llhd.wait (%37, %398, %399 : i32, i16, i16), ^bb1
    }
    %400 = llhd.prb %core_duty_cycle_3_a_3_qs_int : i16
    %401 = llhd.prb %core_duty_cycle_3_b_3_qs_int : i16
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %core_duty_cycle_3_qs, %c2147450879_i32 after %1 : i32
      %615 = llhd.sig.extract %core_duty_cycle_3_qs from %c0_i5 : <i32> -> <i16>
      %616 = llhd.prb %core_duty_cycle_3_a_3_qs_int : i16
      llhd.drv %615, %616 after %1 : i16
      %617 = llhd.sig.extract %core_duty_cycle_3_qs from %c-16_i5 : <i32> -> <i16>
      %618 = llhd.prb %core_duty_cycle_3_b_3_qs_int : i16
      llhd.drv %617, %618 after %1 : i16
      llhd.wait (%39, %400, %401 : i32, i16, i16), ^bb1
    }
    %402 = llhd.prb %core_duty_cycle_4_a_4_qs_int : i16
    %403 = llhd.prb %core_duty_cycle_4_b_4_qs_int : i16
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %core_duty_cycle_4_qs, %c2147450879_i32 after %1 : i32
      %615 = llhd.sig.extract %core_duty_cycle_4_qs from %c0_i5 : <i32> -> <i16>
      %616 = llhd.prb %core_duty_cycle_4_a_4_qs_int : i16
      llhd.drv %615, %616 after %1 : i16
      %617 = llhd.sig.extract %core_duty_cycle_4_qs from %c-16_i5 : <i32> -> <i16>
      %618 = llhd.prb %core_duty_cycle_4_b_4_qs_int : i16
      llhd.drv %617, %618 after %1 : i16
      llhd.wait (%41, %402, %403 : i32, i16, i16), ^bb1
    }
    %404 = llhd.prb %core_duty_cycle_5_a_5_qs_int : i16
    %405 = llhd.prb %core_duty_cycle_5_b_5_qs_int : i16
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %core_duty_cycle_5_qs, %c2147450879_i32 after %1 : i32
      %615 = llhd.sig.extract %core_duty_cycle_5_qs from %c0_i5 : <i32> -> <i16>
      %616 = llhd.prb %core_duty_cycle_5_a_5_qs_int : i16
      llhd.drv %615, %616 after %1 : i16
      %617 = llhd.sig.extract %core_duty_cycle_5_qs from %c-16_i5 : <i32> -> <i16>
      %618 = llhd.prb %core_duty_cycle_5_b_5_qs_int : i16
      llhd.drv %617, %618 after %1 : i16
      llhd.wait (%43, %404, %405 : i32, i16, i16), ^bb1
    }
    %406 = llhd.prb %core_blink_param_0_x_0_qs_int : i16
    %407 = llhd.prb %core_blink_param_0_y_0_qs_int : i16
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %core_blink_param_0_qs, %c0_i32 after %1 : i32
      %615 = llhd.sig.extract %core_blink_param_0_qs from %c0_i5 : <i32> -> <i16>
      %616 = llhd.prb %core_blink_param_0_x_0_qs_int : i16
      llhd.drv %615, %616 after %1 : i16
      %617 = llhd.sig.extract %core_blink_param_0_qs from %c-16_i5 : <i32> -> <i16>
      %618 = llhd.prb %core_blink_param_0_y_0_qs_int : i16
      llhd.drv %617, %618 after %1 : i16
      llhd.wait (%45, %406, %407 : i32, i16, i16), ^bb1
    }
    %408 = llhd.prb %core_blink_param_1_x_1_qs_int : i16
    %409 = llhd.prb %core_blink_param_1_y_1_qs_int : i16
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %core_blink_param_1_qs, %c0_i32 after %1 : i32
      %615 = llhd.sig.extract %core_blink_param_1_qs from %c0_i5 : <i32> -> <i16>
      %616 = llhd.prb %core_blink_param_1_x_1_qs_int : i16
      llhd.drv %615, %616 after %1 : i16
      %617 = llhd.sig.extract %core_blink_param_1_qs from %c-16_i5 : <i32> -> <i16>
      %618 = llhd.prb %core_blink_param_1_y_1_qs_int : i16
      llhd.drv %617, %618 after %1 : i16
      llhd.wait (%47, %408, %409 : i32, i16, i16), ^bb1
    }
    %410 = llhd.prb %core_blink_param_2_x_2_qs_int : i16
    %411 = llhd.prb %core_blink_param_2_y_2_qs_int : i16
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %core_blink_param_2_qs, %c0_i32 after %1 : i32
      %615 = llhd.sig.extract %core_blink_param_2_qs from %c0_i5 : <i32> -> <i16>
      %616 = llhd.prb %core_blink_param_2_x_2_qs_int : i16
      llhd.drv %615, %616 after %1 : i16
      %617 = llhd.sig.extract %core_blink_param_2_qs from %c-16_i5 : <i32> -> <i16>
      %618 = llhd.prb %core_blink_param_2_y_2_qs_int : i16
      llhd.drv %617, %618 after %1 : i16
      llhd.wait (%49, %410, %411 : i32, i16, i16), ^bb1
    }
    %412 = llhd.prb %core_blink_param_3_x_3_qs_int : i16
    %413 = llhd.prb %core_blink_param_3_y_3_qs_int : i16
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %core_blink_param_3_qs, %c0_i32 after %1 : i32
      %615 = llhd.sig.extract %core_blink_param_3_qs from %c0_i5 : <i32> -> <i16>
      %616 = llhd.prb %core_blink_param_3_x_3_qs_int : i16
      llhd.drv %615, %616 after %1 : i16
      %617 = llhd.sig.extract %core_blink_param_3_qs from %c-16_i5 : <i32> -> <i16>
      %618 = llhd.prb %core_blink_param_3_y_3_qs_int : i16
      llhd.drv %617, %618 after %1 : i16
      llhd.wait (%51, %412, %413 : i32, i16, i16), ^bb1
    }
    %414 = llhd.prb %core_blink_param_4_x_4_qs_int : i16
    %415 = llhd.prb %core_blink_param_4_y_4_qs_int : i16
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %core_blink_param_4_qs, %c0_i32 after %1 : i32
      %615 = llhd.sig.extract %core_blink_param_4_qs from %c0_i5 : <i32> -> <i16>
      %616 = llhd.prb %core_blink_param_4_x_4_qs_int : i16
      llhd.drv %615, %616 after %1 : i16
      %617 = llhd.sig.extract %core_blink_param_4_qs from %c-16_i5 : <i32> -> <i16>
      %618 = llhd.prb %core_blink_param_4_y_4_qs_int : i16
      llhd.drv %617, %618 after %1 : i16
      llhd.wait (%53, %414, %415 : i32, i16, i16), ^bb1
    }
    %416 = llhd.prb %core_blink_param_5_x_5_qs_int : i16
    %417 = llhd.prb %core_blink_param_5_y_5_qs_int : i16
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %core_blink_param_5_qs, %c0_i32 after %1 : i32
      %615 = llhd.sig.extract %core_blink_param_5_qs from %c0_i5 : <i32> -> <i16>
      %616 = llhd.prb %core_blink_param_5_x_5_qs_int : i16
      llhd.drv %615, %616 after %1 : i16
      %617 = llhd.sig.extract %core_blink_param_5_qs from %c-16_i5 : <i32> -> <i16>
      %618 = llhd.prb %core_blink_param_5_y_5_qs_int : i16
      llhd.drv %617, %618 after %1 : i16
      llhd.wait (%55, %416, %417 : i32, i16, i16), ^bb1
    }
    %418 = llhd.prb %alert_test_flds_we {sv.namehint = "alert_test_qe"} : i1
    %419 = llhd.sig.struct_extract %57["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %419, %418 after %1 : i1
    %420 = comb.and %u_cfg_cdc.dst_we_o, %u_cfg_cdc.dst_regwen_o {sv.namehint = "core_cfg_gated_we"} : i1
    %421 = llhd.sig.struct_extract %65["qe"] : <!hw.struct<q: i27, qe: i1>>
    llhd.drv %421, %u_cfg0_qe.q_o after %1 : i1
    %422 = llhd.sig.struct_extract %69["qe"] : <!hw.struct<q: i4, qe: i1>>
    llhd.drv %422, %u_cfg0_qe.q_o after %1 : i1
    %423 = llhd.sig.struct_extract %73["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %423, %u_cfg0_qe.q_o after %1 : i1
    %424 = comb.and %u_pwm_en_cdc.dst_we_o, %u_pwm_en_cdc.dst_regwen_o {sv.namehint = "core_pwm_en_gated_we"} : i1
    %425 = llhd.sig.struct_extract %80["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %425, %u_pwm_en0_qe.q_o after %1 : i1
    %426 = llhd.sig.struct_extract %84["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %426, %u_pwm_en0_qe.q_o after %1 : i1
    %427 = llhd.sig.struct_extract %88["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %427, %u_pwm_en0_qe.q_o after %1 : i1
    %428 = llhd.sig.struct_extract %92["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %428, %u_pwm_en0_qe.q_o after %1 : i1
    %429 = llhd.sig.struct_extract %96["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %429, %u_pwm_en0_qe.q_o after %1 : i1
    %430 = llhd.sig.struct_extract %100["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %430, %u_pwm_en0_qe.q_o after %1 : i1
    %431 = comb.and %u_invert_cdc.dst_we_o, %u_invert_cdc.dst_regwen_o {sv.namehint = "core_invert_gated_we"} : i1
    %432 = llhd.sig.struct_extract %107["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %432, %u_invert0_qe.q_o after %1 : i1
    %433 = llhd.sig.struct_extract %111["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %433, %u_invert0_qe.q_o after %1 : i1
    %434 = llhd.sig.struct_extract %115["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %434, %u_invert0_qe.q_o after %1 : i1
    %435 = llhd.sig.struct_extract %119["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %435, %u_invert0_qe.q_o after %1 : i1
    %436 = llhd.sig.struct_extract %123["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %436, %u_invert0_qe.q_o after %1 : i1
    %437 = llhd.sig.struct_extract %127["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %437, %u_invert0_qe.q_o after %1 : i1
    %438 = comb.and %u_pwm_param_0_cdc.dst_we_o, %u_pwm_param_0_cdc.dst_regwen_o {sv.namehint = "core_pwm_param_0_gated_we"} : i1
    %439 = llhd.sig.struct_extract %135["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %439, %u_pwm_param0_qe.q_o after %1 : i1
    %440 = llhd.sig.struct_extract %139["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %440, %u_pwm_param0_qe.q_o after %1 : i1
    %441 = llhd.sig.struct_extract %143["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %441, %u_pwm_param0_qe.q_o after %1 : i1
    %442 = comb.and %u_pwm_param_1_cdc.dst_we_o, %u_pwm_param_1_cdc.dst_regwen_o {sv.namehint = "core_pwm_param_1_gated_we"} : i1
    %443 = llhd.sig.struct_extract %150["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %443, %u_pwm_param1_qe.q_o after %1 : i1
    %444 = llhd.sig.struct_extract %154["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %444, %u_pwm_param1_qe.q_o after %1 : i1
    %445 = llhd.sig.struct_extract %158["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %445, %u_pwm_param1_qe.q_o after %1 : i1
    %446 = comb.and %u_pwm_param_2_cdc.dst_we_o, %u_pwm_param_2_cdc.dst_regwen_o {sv.namehint = "core_pwm_param_2_gated_we"} : i1
    %447 = llhd.sig.struct_extract %165["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %447, %u_pwm_param2_qe.q_o after %1 : i1
    %448 = llhd.sig.struct_extract %169["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %448, %u_pwm_param2_qe.q_o after %1 : i1
    %449 = llhd.sig.struct_extract %173["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %449, %u_pwm_param2_qe.q_o after %1 : i1
    %450 = comb.and %u_pwm_param_3_cdc.dst_we_o, %u_pwm_param_3_cdc.dst_regwen_o {sv.namehint = "core_pwm_param_3_gated_we"} : i1
    %451 = llhd.sig.struct_extract %180["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %451, %u_pwm_param3_qe.q_o after %1 : i1
    %452 = llhd.sig.struct_extract %184["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %452, %u_pwm_param3_qe.q_o after %1 : i1
    %453 = llhd.sig.struct_extract %188["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %453, %u_pwm_param3_qe.q_o after %1 : i1
    %454 = comb.and %u_pwm_param_4_cdc.dst_we_o, %u_pwm_param_4_cdc.dst_regwen_o {sv.namehint = "core_pwm_param_4_gated_we"} : i1
    %455 = llhd.sig.struct_extract %195["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %455, %u_pwm_param4_qe.q_o after %1 : i1
    %456 = llhd.sig.struct_extract %199["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %456, %u_pwm_param4_qe.q_o after %1 : i1
    %457 = llhd.sig.struct_extract %203["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %457, %u_pwm_param4_qe.q_o after %1 : i1
    %458 = comb.and %u_pwm_param_5_cdc.dst_we_o, %u_pwm_param_5_cdc.dst_regwen_o {sv.namehint = "core_pwm_param_5_gated_we"} : i1
    %459 = llhd.sig.struct_extract %210["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %459, %u_pwm_param5_qe.q_o after %1 : i1
    %460 = llhd.sig.struct_extract %214["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %460, %u_pwm_param5_qe.q_o after %1 : i1
    %461 = llhd.sig.struct_extract %218["qe"] : <!hw.struct<q: i1, qe: i1>>
    llhd.drv %461, %u_pwm_param5_qe.q_o after %1 : i1
    %462 = comb.and %u_duty_cycle_0_cdc.dst_we_o, %u_duty_cycle_0_cdc.dst_regwen_o {sv.namehint = "core_duty_cycle_0_gated_we"} : i1
    %463 = llhd.sig.struct_extract %226["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %463, %u_duty_cycle0_qe.q_o after %1 : i1
    %464 = llhd.sig.struct_extract %230["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %464, %u_duty_cycle0_qe.q_o after %1 : i1
    %465 = comb.and %u_duty_cycle_1_cdc.dst_we_o, %u_duty_cycle_1_cdc.dst_regwen_o {sv.namehint = "core_duty_cycle_1_gated_we"} : i1
    %466 = llhd.sig.struct_extract %237["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %466, %u_duty_cycle1_qe.q_o after %1 : i1
    %467 = llhd.sig.struct_extract %241["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %467, %u_duty_cycle1_qe.q_o after %1 : i1
    %468 = comb.and %u_duty_cycle_2_cdc.dst_we_o, %u_duty_cycle_2_cdc.dst_regwen_o {sv.namehint = "core_duty_cycle_2_gated_we"} : i1
    %469 = llhd.sig.struct_extract %248["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %469, %u_duty_cycle2_qe.q_o after %1 : i1
    %470 = llhd.sig.struct_extract %252["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %470, %u_duty_cycle2_qe.q_o after %1 : i1
    %471 = comb.and %u_duty_cycle_3_cdc.dst_we_o, %u_duty_cycle_3_cdc.dst_regwen_o {sv.namehint = "core_duty_cycle_3_gated_we"} : i1
    %472 = llhd.sig.struct_extract %259["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %472, %u_duty_cycle3_qe.q_o after %1 : i1
    %473 = llhd.sig.struct_extract %263["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %473, %u_duty_cycle3_qe.q_o after %1 : i1
    %474 = comb.and %u_duty_cycle_4_cdc.dst_we_o, %u_duty_cycle_4_cdc.dst_regwen_o {sv.namehint = "core_duty_cycle_4_gated_we"} : i1
    %475 = llhd.sig.struct_extract %270["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %475, %u_duty_cycle4_qe.q_o after %1 : i1
    %476 = llhd.sig.struct_extract %274["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %476, %u_duty_cycle4_qe.q_o after %1 : i1
    %477 = comb.and %u_duty_cycle_5_cdc.dst_we_o, %u_duty_cycle_5_cdc.dst_regwen_o {sv.namehint = "core_duty_cycle_5_gated_we"} : i1
    %478 = llhd.sig.struct_extract %281["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %478, %u_duty_cycle5_qe.q_o after %1 : i1
    %479 = llhd.sig.struct_extract %285["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %479, %u_duty_cycle5_qe.q_o after %1 : i1
    %480 = comb.and %u_blink_param_0_cdc.dst_we_o, %u_blink_param_0_cdc.dst_regwen_o {sv.namehint = "core_blink_param_0_gated_we"} : i1
    %481 = llhd.sig.struct_extract %293["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %481, %u_blink_param0_qe.q_o after %1 : i1
    %482 = llhd.sig.struct_extract %297["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %482, %u_blink_param0_qe.q_o after %1 : i1
    %483 = comb.and %u_blink_param_1_cdc.dst_we_o, %u_blink_param_1_cdc.dst_regwen_o {sv.namehint = "core_blink_param_1_gated_we"} : i1
    %484 = llhd.sig.struct_extract %304["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %484, %u_blink_param1_qe.q_o after %1 : i1
    %485 = llhd.sig.struct_extract %308["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %485, %u_blink_param1_qe.q_o after %1 : i1
    %486 = comb.and %u_blink_param_2_cdc.dst_we_o, %u_blink_param_2_cdc.dst_regwen_o {sv.namehint = "core_blink_param_2_gated_we"} : i1
    %487 = llhd.sig.struct_extract %315["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %487, %u_blink_param2_qe.q_o after %1 : i1
    %488 = llhd.sig.struct_extract %319["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %488, %u_blink_param2_qe.q_o after %1 : i1
    %489 = comb.and %u_blink_param_3_cdc.dst_we_o, %u_blink_param_3_cdc.dst_regwen_o {sv.namehint = "core_blink_param_3_gated_we"} : i1
    %490 = llhd.sig.struct_extract %326["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %490, %u_blink_param3_qe.q_o after %1 : i1
    %491 = llhd.sig.struct_extract %330["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %491, %u_blink_param3_qe.q_o after %1 : i1
    %492 = comb.and %u_blink_param_4_cdc.dst_we_o, %u_blink_param_4_cdc.dst_regwen_o {sv.namehint = "core_blink_param_4_gated_we"} : i1
    %493 = llhd.sig.struct_extract %337["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %493, %u_blink_param4_qe.q_o after %1 : i1
    %494 = llhd.sig.struct_extract %341["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %494, %u_blink_param4_qe.q_o after %1 : i1
    %495 = comb.and %u_blink_param_5_cdc.dst_we_o, %u_blink_param_5_cdc.dst_regwen_o {sv.namehint = "core_blink_param_5_gated_we"} : i1
    %496 = llhd.sig.struct_extract %348["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %496, %u_blink_param5_qe.q_o after %1 : i1
    %497 = llhd.sig.struct_extract %352["qe"] : <!hw.struct<q: i16, qe: i1>>
    llhd.drv %497, %u_blink_param5_qe.q_o after %1 : i1
    llhd.drv %racl_role_vec, %c0_i2 after %1 : i2
    %498 = llhd.prb %racl_addr_hit_read : i23
    %499 = llhd.prb %racl_addr_hit_write : i23
    %500 = llhd.prb %addr_hit : i23
    %501 = llhd.prb %reg_addr : i7
    %502 = llhd.prb %racl_policies_i_2 : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    %503 = llhd.prb %racl_role_vec : i2
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      llhd.drv %racl_addr_hit_read, %c0_i23 after %1 : i23
      llhd.drv %racl_addr_hit_write, %c0_i23 after %1 : i23
      %615 = llhd.sig.extract %addr_hit from %c0_i5 : <i23> -> <i1>
      %616 = llhd.prb %reg_addr : i7
      %617 = comb.icmp eq %616, %c0_i7 : i7
      llhd.drv %615, %617 after %1 : i1
      %618 = llhd.sig.extract %addr_hit from %c1_i5 : <i23> -> <i1>
      %619 = llhd.prb %reg_addr : i7
      %620 = comb.icmp eq %619, %c4_i7 : i7
      llhd.drv %618, %620 after %1 : i1
      %621 = llhd.sig.extract %addr_hit from %c2_i5 : <i23> -> <i1>
      %622 = llhd.prb %reg_addr : i7
      %623 = comb.icmp eq %622, %c8_i7 : i7
      llhd.drv %621, %623 after %1 : i1
      %624 = llhd.sig.extract %addr_hit from %c3_i5 : <i23> -> <i1>
      %625 = llhd.prb %reg_addr : i7
      %626 = comb.icmp eq %625, %c12_i7 : i7
      llhd.drv %624, %626 after %1 : i1
      %627 = llhd.sig.extract %addr_hit from %c4_i5 : <i23> -> <i1>
      %628 = llhd.prb %reg_addr : i7
      %629 = comb.icmp eq %628, %c16_i7 : i7
      llhd.drv %627, %629 after %1 : i1
      %630 = llhd.sig.extract %addr_hit from %c5_i5 : <i23> -> <i1>
      %631 = llhd.prb %reg_addr : i7
      %632 = comb.icmp eq %631, %c20_i7 : i7
      llhd.drv %630, %632 after %1 : i1
      %633 = llhd.sig.extract %addr_hit from %c6_i5 : <i23> -> <i1>
      %634 = llhd.prb %reg_addr : i7
      %635 = comb.icmp eq %634, %c24_i7 : i7
      llhd.drv %633, %635 after %1 : i1
      %636 = llhd.sig.extract %addr_hit from %c7_i5 : <i23> -> <i1>
      %637 = llhd.prb %reg_addr : i7
      %638 = comb.icmp eq %637, %c28_i7 : i7
      llhd.drv %636, %638 after %1 : i1
      %639 = llhd.sig.extract %addr_hit from %c8_i5 : <i23> -> <i1>
      %640 = llhd.prb %reg_addr : i7
      %641 = comb.icmp eq %640, %c32_i7 : i7
      llhd.drv %639, %641 after %1 : i1
      %642 = llhd.sig.extract %addr_hit from %c9_i5 : <i23> -> <i1>
      %643 = llhd.prb %reg_addr : i7
      %644 = comb.icmp eq %643, %c36_i7 : i7
      llhd.drv %642, %644 after %1 : i1
      %645 = llhd.sig.extract %addr_hit from %c10_i5 : <i23> -> <i1>
      %646 = llhd.prb %reg_addr : i7
      %647 = comb.icmp eq %646, %c40_i7 : i7
      llhd.drv %645, %647 after %1 : i1
      %648 = llhd.sig.extract %addr_hit from %c11_i5 : <i23> -> <i1>
      %649 = llhd.prb %reg_addr : i7
      %650 = comb.icmp eq %649, %c44_i7 : i7
      llhd.drv %648, %650 after %1 : i1
      %651 = llhd.sig.extract %addr_hit from %c12_i5 : <i23> -> <i1>
      %652 = llhd.prb %reg_addr : i7
      %653 = comb.icmp eq %652, %c48_i7 : i7
      llhd.drv %651, %653 after %1 : i1
      %654 = llhd.sig.extract %addr_hit from %c13_i5 : <i23> -> <i1>
      %655 = llhd.prb %reg_addr : i7
      %656 = comb.icmp eq %655, %c52_i7 : i7
      llhd.drv %654, %656 after %1 : i1
      %657 = llhd.sig.extract %addr_hit from %c14_i5 : <i23> -> <i1>
      %658 = llhd.prb %reg_addr : i7
      %659 = comb.icmp eq %658, %c56_i7 : i7
      llhd.drv %657, %659 after %1 : i1
      %660 = llhd.sig.extract %addr_hit from %c15_i5 : <i23> -> <i1>
      %661 = llhd.prb %reg_addr : i7
      %662 = comb.icmp eq %661, %c60_i7 : i7
      llhd.drv %660, %662 after %1 : i1
      %663 = llhd.sig.extract %addr_hit from %c-16_i5 : <i23> -> <i1>
      %664 = llhd.prb %reg_addr : i7
      %665 = comb.icmp eq %664, %c-64_i7 : i7
      llhd.drv %663, %665 after %1 : i1
      %666 = llhd.sig.extract %addr_hit from %c-15_i5 : <i23> -> <i1>
      %667 = llhd.prb %reg_addr : i7
      %668 = comb.icmp eq %667, %c-60_i7 : i7
      llhd.drv %666, %668 after %1 : i1
      %669 = llhd.sig.extract %addr_hit from %c-14_i5 : <i23> -> <i1>
      %670 = llhd.prb %reg_addr : i7
      %671 = comb.icmp eq %670, %c-56_i7 : i7
      llhd.drv %669, %671 after %1 : i1
      %672 = llhd.sig.extract %addr_hit from %c-13_i5 : <i23> -> <i1>
      %673 = llhd.prb %reg_addr : i7
      %674 = comb.icmp eq %673, %c-52_i7 : i7
      llhd.drv %672, %674 after %1 : i1
      %675 = llhd.sig.extract %addr_hit from %c-12_i5 : <i23> -> <i1>
      %676 = llhd.prb %reg_addr : i7
      %677 = comb.icmp eq %676, %c-48_i7 : i7
      llhd.drv %675, %677 after %1 : i1
      %678 = llhd.sig.extract %addr_hit from %c-11_i5 : <i23> -> <i1>
      %679 = llhd.prb %reg_addr : i7
      %680 = comb.icmp eq %679, %c-44_i7 : i7
      llhd.drv %678, %680 after %1 : i1
      %681 = llhd.sig.extract %addr_hit from %c-10_i5 : <i23> -> <i1>
      %682 = llhd.prb %reg_addr : i7
      %683 = comb.icmp eq %682, %c-40_i7 : i7
      llhd.drv %681, %683 after %1 : i1
      %684 = llhd.prb %addr_hit : i23
      llhd.drv %racl_addr_hit_read, %684 after %1 : i23
      %685 = llhd.prb %addr_hit : i23
      llhd.drv %racl_addr_hit_write, %685 after %1 : i23
      llhd.wait (%498, %499, %500, %501, %502, %503 : i23, i23, i23, i7, !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, i2), ^bb1
    }
    %504 = comb.or %u_reg_if.re_o, %8 : i1
    %505 = comb.icmp ne %500, %c0_i23 : i23
    %506 = comb.xor %505, %true : i1
    %507 = comb.and %504, %506 {sv.namehint = "addrmiss"} : i1
    %508 = llhd.sig.struct_extract %racl_error_o["valid"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    %509 = comb.icmp eq %498, %c0_i23 : i23
    %510 = comb.and %u_reg_if.re_o, %509 : i1
    %511 = comb.icmp eq %499, %c0_i23 : i23
    %512 = comb.and %8, %511 : i1
    %513 = comb.or %510, %512 : i1
    %514 = comb.and %505, %513 : i1
    llhd.drv %508, %514 after %1 : i1
    %515 = llhd.sig.struct_extract %racl_error_o["request_address"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    %516 = comb.concat %c0_i25, %501 : i25, i7
    llhd.drv %515, %516 after %1 : i32
    %517 = llhd.sig.struct_extract %racl_error_o["racl_role"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %517, %false after %1 : i1
    %518 = llhd.sig.struct_extract %racl_error_o["overflow"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %518, %false after %1 : i1
    %519 = llhd.sig.struct_extract %racl_error_o["ctn_uid"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %519, %false after %1 : i1
    %520 = llhd.sig.struct_extract %racl_error_o["read_access"] : <!hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>>
    llhd.drv %520, %false after %1 : i1
    %521 = llhd.prb %reg_be : i4
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %615 = llhd.prb %reg_we : i1
      %616 = llhd.prb %racl_addr_hit_write : i23
      %617 = comb.extract %616 from 0 : (i23) -> i1
      %618 = llhd.prb %reg_be : i4
      %619 = comb.extract %618 from 0 : (i4) -> i1
      %620 = comb.xor %619, %true : i1
      %621 = comb.and %617, %620 : i1
      %622 = comb.extract %616 from 1 : (i23) -> i1
      %623 = comb.and %622, %620 : i1
      %624 = comb.extract %616 from 2 : (i23) -> i1
      %625 = comb.icmp ne %618, %c-1_i4 : i4
      %626 = comb.and %624, %625 : i1
      %627 = comb.extract %616 from 3 : (i23) -> i1
      %628 = comb.and %627, %620 : i1
      %629 = comb.extract %616 from 4 : (i23) -> i1
      %630 = comb.and %629, %620 : i1
      %631 = comb.extract %616 from 5 : (i23) -> i1
      %632 = comb.icmp ne %618, %c-1_i4 : i4
      %633 = comb.and %631, %632 : i1
      %634 = comb.extract %616 from 6 : (i23) -> i1
      %635 = comb.icmp ne %618, %c-1_i4 : i4
      %636 = comb.and %634, %635 : i1
      %637 = comb.extract %616 from 7 : (i23) -> i1
      %638 = comb.icmp ne %618, %c-1_i4 : i4
      %639 = comb.and %637, %638 : i1
      %640 = comb.extract %616 from 8 : (i23) -> i1
      %641 = comb.icmp ne %618, %c-1_i4 : i4
      %642 = comb.and %640, %641 : i1
      %643 = comb.extract %616 from 9 : (i23) -> i1
      %644 = comb.icmp ne %618, %c-1_i4 : i4
      %645 = comb.and %643, %644 : i1
      %646 = comb.extract %616 from 10 : (i23) -> i1
      %647 = comb.icmp ne %618, %c-1_i4 : i4
      %648 = comb.and %646, %647 : i1
      %649 = comb.extract %616 from 11 : (i23) -> i1
      %650 = comb.icmp ne %618, %c-1_i4 : i4
      %651 = comb.and %649, %650 : i1
      %652 = comb.extract %616 from 12 : (i23) -> i1
      %653 = comb.icmp ne %618, %c-1_i4 : i4
      %654 = comb.and %652, %653 : i1
      %655 = comb.extract %616 from 13 : (i23) -> i1
      %656 = comb.icmp ne %618, %c-1_i4 : i4
      %657 = comb.and %655, %656 : i1
      %658 = comb.extract %616 from 14 : (i23) -> i1
      %659 = comb.icmp ne %618, %c-1_i4 : i4
      %660 = comb.and %658, %659 : i1
      %661 = comb.extract %616 from 15 : (i23) -> i1
      %662 = comb.icmp ne %618, %c-1_i4 : i4
      %663 = comb.and %661, %662 : i1
      %664 = comb.extract %616 from 16 : (i23) -> i1
      %665 = comb.icmp ne %618, %c-1_i4 : i4
      %666 = comb.and %664, %665 : i1
      %667 = comb.extract %616 from 17 : (i23) -> i1
      %668 = comb.icmp ne %618, %c-1_i4 : i4
      %669 = comb.and %667, %668 : i1
      %670 = comb.extract %616 from 18 : (i23) -> i1
      %671 = comb.icmp ne %618, %c-1_i4 : i4
      %672 = comb.and %670, %671 : i1
      %673 = comb.extract %616 from 19 : (i23) -> i1
      %674 = comb.icmp ne %618, %c-1_i4 : i4
      %675 = comb.and %673, %674 : i1
      %676 = comb.extract %616 from 20 : (i23) -> i1
      %677 = comb.icmp ne %618, %c-1_i4 : i4
      %678 = comb.and %676, %677 : i1
      %679 = comb.extract %616 from 21 : (i23) -> i1
      %680 = comb.icmp ne %618, %c-1_i4 : i4
      %681 = comb.and %679, %680 : i1
      %682 = comb.extract %616 from 22 : (i23) -> i1
      %683 = comb.icmp ne %618, %c-1_i4 : i4
      %684 = comb.and %682, %683 : i1
      %685 = comb.or %621, %623, %626, %628, %630, %633, %636, %639, %642, %645, %648, %651, %654, %657, %660, %663, %666, %669, %672, %675, %678, %681, %684 : i1
      %686 = comb.and %615, %685 : i1
      llhd.drv %wr_err, %686 after %1 : i1
      llhd.wait (%8, %499, %521, %359 : i1, i23, i4, i1), ^bb1
    }
    %522 = comb.extract %499 from 0 : (i23) -> i1
    %523 = comb.xor %360, %true : i1
    %524 = comb.and %522, %8, %523 : i1
    llhd.drv %alert_test_we, %524 after %1 : i1
    %525 = comb.extract %u_reg_if.wdata_o from 0 {sv.namehint = "regwen_wd"} : (i32) -> i1
    %526 = comb.extract %499 from 1 : (i23) -> i1
    %527 = comb.and %526, %8, %523 : i1
    llhd.drv %regwen_we, %527 after %1 : i1
    %528 = comb.extract %499 from 2 : (i23) -> i1
    %529 = comb.and %528, %8, %523 : i1
    llhd.drv %cfg_we, %529 after %1 : i1
    %530 = comb.extract %499 from 3 : (i23) -> i1
    %531 = comb.and %530, %8, %523 : i1
    llhd.drv %pwm_en_we, %531 after %1 : i1
    %532 = comb.extract %499 from 4 : (i23) -> i1
    %533 = comb.and %532, %8, %523 : i1
    llhd.drv %invert_we, %533 after %1 : i1
    %534 = comb.extract %499 from 5 : (i23) -> i1
    %535 = comb.and %534, %8, %523 : i1
    llhd.drv %pwm_param_0_we, %535 after %1 : i1
    %536 = comb.extract %499 from 6 : (i23) -> i1
    %537 = comb.and %536, %8, %523 : i1
    llhd.drv %pwm_param_1_we, %537 after %1 : i1
    %538 = comb.extract %499 from 7 : (i23) -> i1
    %539 = comb.and %538, %8, %523 : i1
    llhd.drv %pwm_param_2_we, %539 after %1 : i1
    %540 = comb.extract %499 from 8 : (i23) -> i1
    %541 = comb.and %540, %8, %523 : i1
    llhd.drv %pwm_param_3_we, %541 after %1 : i1
    %542 = comb.extract %499 from 9 : (i23) -> i1
    %543 = comb.and %542, %8, %523 : i1
    llhd.drv %pwm_param_4_we, %543 after %1 : i1
    %544 = comb.extract %499 from 10 : (i23) -> i1
    %545 = comb.and %544, %8, %523 : i1
    llhd.drv %pwm_param_5_we, %545 after %1 : i1
    %546 = comb.extract %499 from 11 : (i23) -> i1
    %547 = comb.and %546, %8, %523 : i1
    llhd.drv %duty_cycle_0_we, %547 after %1 : i1
    %548 = comb.extract %499 from 12 : (i23) -> i1
    %549 = comb.and %548, %8, %523 : i1
    llhd.drv %duty_cycle_1_we, %549 after %1 : i1
    %550 = comb.extract %499 from 13 : (i23) -> i1
    %551 = comb.and %550, %8, %523 : i1
    llhd.drv %duty_cycle_2_we, %551 after %1 : i1
    %552 = comb.extract %499 from 14 : (i23) -> i1
    %553 = comb.and %552, %8, %523 : i1
    llhd.drv %duty_cycle_3_we, %553 after %1 : i1
    %554 = comb.extract %499 from 15 : (i23) -> i1
    %555 = comb.and %554, %8, %523 : i1
    llhd.drv %duty_cycle_4_we, %555 after %1 : i1
    %556 = comb.extract %499 from 16 : (i23) -> i1
    %557 = comb.and %556, %8, %523 : i1
    llhd.drv %duty_cycle_5_we, %557 after %1 : i1
    %558 = comb.extract %499 from 17 : (i23) -> i1
    %559 = comb.and %558, %8, %523 : i1
    llhd.drv %blink_param_0_we, %559 after %1 : i1
    %560 = comb.extract %499 from 18 : (i23) -> i1
    %561 = comb.and %560, %8, %523 : i1
    llhd.drv %blink_param_1_we, %561 after %1 : i1
    %562 = comb.extract %499 from 19 : (i23) -> i1
    %563 = comb.and %562, %8, %523 : i1
    llhd.drv %blink_param_2_we, %563 after %1 : i1
    %564 = comb.extract %499 from 20 : (i23) -> i1
    %565 = comb.and %564, %8, %523 : i1
    llhd.drv %blink_param_3_we, %565 after %1 : i1
    %566 = comb.extract %499 from 21 : (i23) -> i1
    %567 = comb.and %566, %8, %523 : i1
    llhd.drv %blink_param_4_we, %567 after %1 : i1
    %568 = comb.extract %499 from 22 : (i23) -> i1
    %569 = comb.and %568, %8, %523 : i1
    llhd.drv %blink_param_5_we, %569 after %1 : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb1
      %615 = llhd.sig.extract %reg_we_check from %c0_i5 : <i23> -> <i1>
      %616 = llhd.prb %alert_test_we : i1
      llhd.drv %615, %616 after %1 : i1
      %617 = llhd.sig.extract %reg_we_check from %c1_i5 : <i23> -> <i1>
      %618 = llhd.prb %regwen_we : i1
      llhd.drv %617, %618 after %1 : i1
      %619 = llhd.sig.extract %reg_we_check from %c2_i5 : <i23> -> <i1>
      %620 = llhd.prb %cfg_we : i1
      llhd.drv %619, %620 after %1 : i1
      %621 = llhd.sig.extract %reg_we_check from %c3_i5 : <i23> -> <i1>
      %622 = llhd.prb %pwm_en_we : i1
      llhd.drv %621, %622 after %1 : i1
      %623 = llhd.sig.extract %reg_we_check from %c4_i5 : <i23> -> <i1>
      %624 = llhd.prb %invert_we : i1
      llhd.drv %623, %624 after %1 : i1
      %625 = llhd.sig.extract %reg_we_check from %c5_i5 : <i23> -> <i1>
      %626 = llhd.prb %pwm_param_0_we : i1
      llhd.drv %625, %626 after %1 : i1
      %627 = llhd.sig.extract %reg_we_check from %c6_i5 : <i23> -> <i1>
      %628 = llhd.prb %pwm_param_1_we : i1
      llhd.drv %627, %628 after %1 : i1
      %629 = llhd.sig.extract %reg_we_check from %c7_i5 : <i23> -> <i1>
      %630 = llhd.prb %pwm_param_2_we : i1
      llhd.drv %629, %630 after %1 : i1
      %631 = llhd.sig.extract %reg_we_check from %c8_i5 : <i23> -> <i1>
      %632 = llhd.prb %pwm_param_3_we : i1
      llhd.drv %631, %632 after %1 : i1
      %633 = llhd.sig.extract %reg_we_check from %c9_i5 : <i23> -> <i1>
      %634 = llhd.prb %pwm_param_4_we : i1
      llhd.drv %633, %634 after %1 : i1
      %635 = llhd.sig.extract %reg_we_check from %c10_i5 : <i23> -> <i1>
      %636 = llhd.prb %pwm_param_5_we : i1
      llhd.drv %635, %636 after %1 : i1
      %637 = llhd.sig.extract %reg_we_check from %c11_i5 : <i23> -> <i1>
      %638 = llhd.prb %duty_cycle_0_we : i1
      llhd.drv %637, %638 after %1 : i1
      %639 = llhd.sig.extract %reg_we_check from %c12_i5 : <i23> -> <i1>
      %640 = llhd.prb %duty_cycle_1_we : i1
      llhd.drv %639, %640 after %1 : i1
      %641 = llhd.sig.extract %reg_we_check from %c13_i5 : <i23> -> <i1>
      %642 = llhd.prb %duty_cycle_2_we : i1
      llhd.drv %641, %642 after %1 : i1
      %643 = llhd.sig.extract %reg_we_check from %c14_i5 : <i23> -> <i1>
      %644 = llhd.prb %duty_cycle_3_we : i1
      llhd.drv %643, %644 after %1 : i1
      %645 = llhd.sig.extract %reg_we_check from %c15_i5 : <i23> -> <i1>
      %646 = llhd.prb %duty_cycle_4_we : i1
      llhd.drv %645, %646 after %1 : i1
      %647 = llhd.sig.extract %reg_we_check from %c-16_i5 : <i23> -> <i1>
      %648 = llhd.prb %duty_cycle_5_we : i1
      llhd.drv %647, %648 after %1 : i1
      %649 = llhd.sig.extract %reg_we_check from %c-15_i5 : <i23> -> <i1>
      %650 = llhd.prb %blink_param_0_we : i1
      llhd.drv %649, %650 after %1 : i1
      %651 = llhd.sig.extract %reg_we_check from %c-14_i5 : <i23> -> <i1>
      %652 = llhd.prb %blink_param_1_we : i1
      llhd.drv %651, %652 after %1 : i1
      %653 = llhd.sig.extract %reg_we_check from %c-13_i5 : <i23> -> <i1>
      %654 = llhd.prb %blink_param_2_we : i1
      llhd.drv %653, %654 after %1 : i1
      %655 = llhd.sig.extract %reg_we_check from %c-12_i5 : <i23> -> <i1>
      %656 = llhd.prb %blink_param_3_we : i1
      llhd.drv %655, %656 after %1 : i1
      %657 = llhd.sig.extract %reg_we_check from %c-11_i5 : <i23> -> <i1>
      %658 = llhd.prb %blink_param_4_we : i1
      llhd.drv %657, %658 after %1 : i1
      %659 = llhd.sig.extract %reg_we_check from %c-10_i5 : <i23> -> <i1>
      %660 = llhd.prb %blink_param_5_we : i1
      llhd.drv %659, %660 after %1 : i1
      llhd.wait (%7, %56, %59, %13, %15, %18, %20, %22, %24, %26, %28, %30, %32, %34, %36, %38, %40, %42, %44, %46, %48, %50, %52, %54 : i23, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    %570 = llhd.prb %cfg_qs : i32
    %571 = llhd.prb %pwm_en_qs : i6
    %572 = llhd.prb %invert_qs : i6
    %573 = llhd.prb %pwm_param_0_qs : i32
    %574 = llhd.prb %pwm_param_1_qs : i32
    %575 = llhd.prb %pwm_param_2_qs : i32
    %576 = llhd.prb %pwm_param_3_qs : i32
    %577 = llhd.prb %pwm_param_4_qs : i32
    %578 = llhd.prb %pwm_param_5_qs : i32
    %579 = llhd.prb %duty_cycle_0_qs : i32
    %580 = llhd.prb %duty_cycle_1_qs : i32
    %581 = llhd.prb %duty_cycle_2_qs : i32
    %582 = llhd.prb %duty_cycle_3_qs : i32
    %583 = llhd.prb %duty_cycle_4_qs : i32
    %584 = llhd.prb %duty_cycle_5_qs : i32
    %585 = llhd.prb %blink_param_0_qs : i32
    %586 = llhd.prb %blink_param_1_qs : i32
    %587 = llhd.prb %blink_param_2_qs : i32
    %588 = llhd.prb %blink_param_3_qs : i32
    %589 = llhd.prb %blink_param_4_qs : i32
    %590 = llhd.prb %blink_param_5_qs : i32
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb48
      llhd.drv %reg_rdata_next, %c0_i32 after %1 : i32
      %615 = llhd.prb %racl_addr_hit_read : i23
      %616 = comb.extract %615 from 0 : (i23) -> i1
      %617 = comb.icmp ceq %616, %true : i1
      cf.cond_br %617, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %618 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      llhd.drv %618, %false after %1 : i1
      cf.br ^bb48
    ^bb3:  // pred: ^bb1
      %619 = llhd.prb %racl_addr_hit_read : i23
      %620 = comb.extract %619 from 1 : (i23) -> i1
      %621 = comb.icmp ceq %620, %true : i1
      cf.cond_br %621, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %622 = llhd.sig.extract %reg_rdata_next from %c0_i5 : <i32> -> <i1>
      %623 = llhd.prb %regwen_qs : i1
      llhd.drv %622, %623 after %1 : i1
      cf.br ^bb48
    ^bb5:  // pred: ^bb3
      %624 = llhd.prb %racl_addr_hit_read : i23
      %625 = comb.extract %624 from 2 : (i23) -> i1
      %626 = comb.icmp ceq %625, %true : i1
      cf.cond_br %626, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %627 = llhd.prb %cfg_qs : i32
      llhd.drv %reg_rdata_next, %627 after %1 : i32
      cf.br ^bb48
    ^bb7:  // pred: ^bb5
      %628 = llhd.prb %racl_addr_hit_read : i23
      %629 = comb.extract %628 from 3 : (i23) -> i1
      %630 = comb.icmp ceq %629, %true : i1
      cf.cond_br %630, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %631 = llhd.prb %pwm_en_qs : i6
      %632 = comb.concat %c0_i26, %631 : i26, i6
      llhd.drv %reg_rdata_next, %632 after %1 : i32
      cf.br ^bb48
    ^bb9:  // pred: ^bb7
      %633 = llhd.prb %racl_addr_hit_read : i23
      %634 = comb.extract %633 from 4 : (i23) -> i1
      %635 = comb.icmp ceq %634, %true : i1
      cf.cond_br %635, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %636 = llhd.prb %invert_qs : i6
      %637 = comb.concat %c0_i26, %636 : i26, i6
      llhd.drv %reg_rdata_next, %637 after %1 : i32
      cf.br ^bb48
    ^bb11:  // pred: ^bb9
      %638 = llhd.prb %racl_addr_hit_read : i23
      %639 = comb.extract %638 from 5 : (i23) -> i1
      %640 = comb.icmp ceq %639, %true : i1
      cf.cond_br %640, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %641 = llhd.prb %pwm_param_0_qs : i32
      llhd.drv %reg_rdata_next, %641 after %1 : i32
      cf.br ^bb48
    ^bb13:  // pred: ^bb11
      %642 = llhd.prb %racl_addr_hit_read : i23
      %643 = comb.extract %642 from 6 : (i23) -> i1
      %644 = comb.icmp ceq %643, %true : i1
      cf.cond_br %644, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %645 = llhd.prb %pwm_param_1_qs : i32
      llhd.drv %reg_rdata_next, %645 after %1 : i32
      cf.br ^bb48
    ^bb15:  // pred: ^bb13
      %646 = llhd.prb %racl_addr_hit_read : i23
      %647 = comb.extract %646 from 7 : (i23) -> i1
      %648 = comb.icmp ceq %647, %true : i1
      cf.cond_br %648, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      %649 = llhd.prb %pwm_param_2_qs : i32
      llhd.drv %reg_rdata_next, %649 after %1 : i32
      cf.br ^bb48
    ^bb17:  // pred: ^bb15
      %650 = llhd.prb %racl_addr_hit_read : i23
      %651 = comb.extract %650 from 8 : (i23) -> i1
      %652 = comb.icmp ceq %651, %true : i1
      cf.cond_br %652, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      %653 = llhd.prb %pwm_param_3_qs : i32
      llhd.drv %reg_rdata_next, %653 after %1 : i32
      cf.br ^bb48
    ^bb19:  // pred: ^bb17
      %654 = llhd.prb %racl_addr_hit_read : i23
      %655 = comb.extract %654 from 9 : (i23) -> i1
      %656 = comb.icmp ceq %655, %true : i1
      cf.cond_br %656, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      %657 = llhd.prb %pwm_param_4_qs : i32
      llhd.drv %reg_rdata_next, %657 after %1 : i32
      cf.br ^bb48
    ^bb21:  // pred: ^bb19
      %658 = llhd.prb %racl_addr_hit_read : i23
      %659 = comb.extract %658 from 10 : (i23) -> i1
      %660 = comb.icmp ceq %659, %true : i1
      cf.cond_br %660, ^bb22, ^bb23
    ^bb22:  // pred: ^bb21
      %661 = llhd.prb %pwm_param_5_qs : i32
      llhd.drv %reg_rdata_next, %661 after %1 : i32
      cf.br ^bb48
    ^bb23:  // pred: ^bb21
      %662 = llhd.prb %racl_addr_hit_read : i23
      %663 = comb.extract %662 from 11 : (i23) -> i1
      %664 = comb.icmp ceq %663, %true : i1
      cf.cond_br %664, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      %665 = llhd.prb %duty_cycle_0_qs : i32
      llhd.drv %reg_rdata_next, %665 after %1 : i32
      cf.br ^bb48
    ^bb25:  // pred: ^bb23
      %666 = llhd.prb %racl_addr_hit_read : i23
      %667 = comb.extract %666 from 12 : (i23) -> i1
      %668 = comb.icmp ceq %667, %true : i1
      cf.cond_br %668, ^bb26, ^bb27
    ^bb26:  // pred: ^bb25
      %669 = llhd.prb %duty_cycle_1_qs : i32
      llhd.drv %reg_rdata_next, %669 after %1 : i32
      cf.br ^bb48
    ^bb27:  // pred: ^bb25
      %670 = llhd.prb %racl_addr_hit_read : i23
      %671 = comb.extract %670 from 13 : (i23) -> i1
      %672 = comb.icmp ceq %671, %true : i1
      cf.cond_br %672, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      %673 = llhd.prb %duty_cycle_2_qs : i32
      llhd.drv %reg_rdata_next, %673 after %1 : i32
      cf.br ^bb48
    ^bb29:  // pred: ^bb27
      %674 = llhd.prb %racl_addr_hit_read : i23
      %675 = comb.extract %674 from 14 : (i23) -> i1
      %676 = comb.icmp ceq %675, %true : i1
      cf.cond_br %676, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      %677 = llhd.prb %duty_cycle_3_qs : i32
      llhd.drv %reg_rdata_next, %677 after %1 : i32
      cf.br ^bb48
    ^bb31:  // pred: ^bb29
      %678 = llhd.prb %racl_addr_hit_read : i23
      %679 = comb.extract %678 from 15 : (i23) -> i1
      %680 = comb.icmp ceq %679, %true : i1
      cf.cond_br %680, ^bb32, ^bb33
    ^bb32:  // pred: ^bb31
      %681 = llhd.prb %duty_cycle_4_qs : i32
      llhd.drv %reg_rdata_next, %681 after %1 : i32
      cf.br ^bb48
    ^bb33:  // pred: ^bb31
      %682 = llhd.prb %racl_addr_hit_read : i23
      %683 = comb.extract %682 from 16 : (i23) -> i1
      %684 = comb.icmp ceq %683, %true : i1
      cf.cond_br %684, ^bb34, ^bb35
    ^bb34:  // pred: ^bb33
      %685 = llhd.prb %duty_cycle_5_qs : i32
      llhd.drv %reg_rdata_next, %685 after %1 : i32
      cf.br ^bb48
    ^bb35:  // pred: ^bb33
      %686 = llhd.prb %racl_addr_hit_read : i23
      %687 = comb.extract %686 from 17 : (i23) -> i1
      %688 = comb.icmp ceq %687, %true : i1
      cf.cond_br %688, ^bb36, ^bb37
    ^bb36:  // pred: ^bb35
      %689 = llhd.prb %blink_param_0_qs : i32
      llhd.drv %reg_rdata_next, %689 after %1 : i32
      cf.br ^bb48
    ^bb37:  // pred: ^bb35
      %690 = llhd.prb %racl_addr_hit_read : i23
      %691 = comb.extract %690 from 18 : (i23) -> i1
      %692 = comb.icmp ceq %691, %true : i1
      cf.cond_br %692, ^bb38, ^bb39
    ^bb38:  // pred: ^bb37
      %693 = llhd.prb %blink_param_1_qs : i32
      llhd.drv %reg_rdata_next, %693 after %1 : i32
      cf.br ^bb48
    ^bb39:  // pred: ^bb37
      %694 = llhd.prb %racl_addr_hit_read : i23
      %695 = comb.extract %694 from 19 : (i23) -> i1
      %696 = comb.icmp ceq %695, %true : i1
      cf.cond_br %696, ^bb40, ^bb41
    ^bb40:  // pred: ^bb39
      %697 = llhd.prb %blink_param_2_qs : i32
      llhd.drv %reg_rdata_next, %697 after %1 : i32
      cf.br ^bb48
    ^bb41:  // pred: ^bb39
      %698 = llhd.prb %racl_addr_hit_read : i23
      %699 = comb.extract %698 from 20 : (i23) -> i1
      %700 = comb.icmp ceq %699, %true : i1
      cf.cond_br %700, ^bb42, ^bb43
    ^bb42:  // pred: ^bb41
      %701 = llhd.prb %blink_param_3_qs : i32
      llhd.drv %reg_rdata_next, %701 after %1 : i32
      cf.br ^bb48
    ^bb43:  // pred: ^bb41
      %702 = llhd.prb %racl_addr_hit_read : i23
      %703 = comb.extract %702 from 21 : (i23) -> i1
      %704 = comb.icmp ceq %703, %true : i1
      cf.cond_br %704, ^bb44, ^bb45
    ^bb44:  // pred: ^bb43
      %705 = llhd.prb %blink_param_4_qs : i32
      llhd.drv %reg_rdata_next, %705 after %1 : i32
      cf.br ^bb48
    ^bb45:  // pred: ^bb43
      %706 = llhd.prb %racl_addr_hit_read : i23
      %707 = comb.extract %706 from 22 : (i23) -> i1
      %708 = comb.icmp ceq %707, %true : i1
      cf.cond_br %708, ^bb46, ^bb47
    ^bb46:  // pred: ^bb45
      %709 = llhd.prb %blink_param_5_qs : i32
      llhd.drv %reg_rdata_next, %709 after %1 : i32
      cf.br ^bb48
    ^bb47:  // pred: ^bb45
      llhd.drv %reg_rdata_next, %c-1_i32 after %1 : i32
      cf.br ^bb48
    ^bb48:  // 24 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb18, ^bb20, ^bb22, ^bb24, ^bb26, ^bb28, ^bb30, ^bb32, ^bb34, ^bb36, ^bb38, ^bb40, ^bb42, ^bb44, ^bb46, ^bb47
      llhd.wait (%358, %498, %12, %570, %571, %572, %573, %574, %575, %576, %577, %578, %579, %580, %581, %582, %583, %584, %585, %586, %587, %588, %589, %590 : i32, i23, i1, i32, i6, i6, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32), ^bb1
    }
    %591 = llhd.prb %reg_busy_sel : i1
    %a_valid = hw.struct_extract %tl_i["a_valid"] : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>
    %592 = comb.and %591, %a_valid {sv.namehint = "reg_busy"} : i1
    %593 = llhd.prb %cfg_busy : i1
    %594 = llhd.prb %pwm_en_busy : i1
    %595 = llhd.prb %invert_busy : i1
    %596 = llhd.prb %pwm_param_0_busy : i1
    %597 = llhd.prb %pwm_param_1_busy : i1
    %598 = llhd.prb %pwm_param_2_busy : i1
    %599 = llhd.prb %pwm_param_3_busy : i1
    %600 = llhd.prb %pwm_param_4_busy : i1
    %601 = llhd.prb %pwm_param_5_busy : i1
    %602 = llhd.prb %duty_cycle_0_busy : i1
    %603 = llhd.prb %duty_cycle_1_busy : i1
    %604 = llhd.prb %duty_cycle_2_busy : i1
    %605 = llhd.prb %duty_cycle_3_busy : i1
    %606 = llhd.prb %duty_cycle_4_busy : i1
    %607 = llhd.prb %duty_cycle_5_busy : i1
    %608 = llhd.prb %blink_param_0_busy : i1
    %609 = llhd.prb %blink_param_1_busy : i1
    %610 = llhd.prb %blink_param_2_busy : i1
    %611 = llhd.prb %blink_param_3_busy : i1
    %612 = llhd.prb %blink_param_4_busy : i1
    %613 = llhd.prb %blink_param_5_busy : i1
    llhd.process {
      cf.br ^bb1
    ^bb1:  // 2 preds: ^bb0, ^bb44
      llhd.drv %reg_busy_sel, %false after %1 : i1
      %615 = llhd.prb %addr_hit : i23
      %616 = comb.extract %615 from 2 : (i23) -> i1
      %617 = comb.icmp ceq %616, %true : i1
      cf.cond_br %617, ^bb2, ^bb3
    ^bb2:  // pred: ^bb1
      %618 = llhd.prb %cfg_busy : i1
      llhd.drv %reg_busy_sel, %618 after %1 : i1
      cf.br ^bb44
    ^bb3:  // pred: ^bb1
      %619 = llhd.prb %addr_hit : i23
      %620 = comb.extract %619 from 3 : (i23) -> i1
      %621 = comb.icmp ceq %620, %true : i1
      cf.cond_br %621, ^bb4, ^bb5
    ^bb4:  // pred: ^bb3
      %622 = llhd.prb %pwm_en_busy : i1
      llhd.drv %reg_busy_sel, %622 after %1 : i1
      cf.br ^bb44
    ^bb5:  // pred: ^bb3
      %623 = llhd.prb %addr_hit : i23
      %624 = comb.extract %623 from 4 : (i23) -> i1
      %625 = comb.icmp ceq %624, %true : i1
      cf.cond_br %625, ^bb6, ^bb7
    ^bb6:  // pred: ^bb5
      %626 = llhd.prb %invert_busy : i1
      llhd.drv %reg_busy_sel, %626 after %1 : i1
      cf.br ^bb44
    ^bb7:  // pred: ^bb5
      %627 = llhd.prb %addr_hit : i23
      %628 = comb.extract %627 from 5 : (i23) -> i1
      %629 = comb.icmp ceq %628, %true : i1
      cf.cond_br %629, ^bb8, ^bb9
    ^bb8:  // pred: ^bb7
      %630 = llhd.prb %pwm_param_0_busy : i1
      llhd.drv %reg_busy_sel, %630 after %1 : i1
      cf.br ^bb44
    ^bb9:  // pred: ^bb7
      %631 = llhd.prb %addr_hit : i23
      %632 = comb.extract %631 from 6 : (i23) -> i1
      %633 = comb.icmp ceq %632, %true : i1
      cf.cond_br %633, ^bb10, ^bb11
    ^bb10:  // pred: ^bb9
      %634 = llhd.prb %pwm_param_1_busy : i1
      llhd.drv %reg_busy_sel, %634 after %1 : i1
      cf.br ^bb44
    ^bb11:  // pred: ^bb9
      %635 = llhd.prb %addr_hit : i23
      %636 = comb.extract %635 from 7 : (i23) -> i1
      %637 = comb.icmp ceq %636, %true : i1
      cf.cond_br %637, ^bb12, ^bb13
    ^bb12:  // pred: ^bb11
      %638 = llhd.prb %pwm_param_2_busy : i1
      llhd.drv %reg_busy_sel, %638 after %1 : i1
      cf.br ^bb44
    ^bb13:  // pred: ^bb11
      %639 = llhd.prb %addr_hit : i23
      %640 = comb.extract %639 from 8 : (i23) -> i1
      %641 = comb.icmp ceq %640, %true : i1
      cf.cond_br %641, ^bb14, ^bb15
    ^bb14:  // pred: ^bb13
      %642 = llhd.prb %pwm_param_3_busy : i1
      llhd.drv %reg_busy_sel, %642 after %1 : i1
      cf.br ^bb44
    ^bb15:  // pred: ^bb13
      %643 = llhd.prb %addr_hit : i23
      %644 = comb.extract %643 from 9 : (i23) -> i1
      %645 = comb.icmp ceq %644, %true : i1
      cf.cond_br %645, ^bb16, ^bb17
    ^bb16:  // pred: ^bb15
      %646 = llhd.prb %pwm_param_4_busy : i1
      llhd.drv %reg_busy_sel, %646 after %1 : i1
      cf.br ^bb44
    ^bb17:  // pred: ^bb15
      %647 = llhd.prb %addr_hit : i23
      %648 = comb.extract %647 from 10 : (i23) -> i1
      %649 = comb.icmp ceq %648, %true : i1
      cf.cond_br %649, ^bb18, ^bb19
    ^bb18:  // pred: ^bb17
      %650 = llhd.prb %pwm_param_5_busy : i1
      llhd.drv %reg_busy_sel, %650 after %1 : i1
      cf.br ^bb44
    ^bb19:  // pred: ^bb17
      %651 = llhd.prb %addr_hit : i23
      %652 = comb.extract %651 from 11 : (i23) -> i1
      %653 = comb.icmp ceq %652, %true : i1
      cf.cond_br %653, ^bb20, ^bb21
    ^bb20:  // pred: ^bb19
      %654 = llhd.prb %duty_cycle_0_busy : i1
      llhd.drv %reg_busy_sel, %654 after %1 : i1
      cf.br ^bb44
    ^bb21:  // pred: ^bb19
      %655 = llhd.prb %addr_hit : i23
      %656 = comb.extract %655 from 12 : (i23) -> i1
      %657 = comb.icmp ceq %656, %true : i1
      cf.cond_br %657, ^bb22, ^bb23
    ^bb22:  // pred: ^bb21
      %658 = llhd.prb %duty_cycle_1_busy : i1
      llhd.drv %reg_busy_sel, %658 after %1 : i1
      cf.br ^bb44
    ^bb23:  // pred: ^bb21
      %659 = llhd.prb %addr_hit : i23
      %660 = comb.extract %659 from 13 : (i23) -> i1
      %661 = comb.icmp ceq %660, %true : i1
      cf.cond_br %661, ^bb24, ^bb25
    ^bb24:  // pred: ^bb23
      %662 = llhd.prb %duty_cycle_2_busy : i1
      llhd.drv %reg_busy_sel, %662 after %1 : i1
      cf.br ^bb44
    ^bb25:  // pred: ^bb23
      %663 = llhd.prb %addr_hit : i23
      %664 = comb.extract %663 from 14 : (i23) -> i1
      %665 = comb.icmp ceq %664, %true : i1
      cf.cond_br %665, ^bb26, ^bb27
    ^bb26:  // pred: ^bb25
      %666 = llhd.prb %duty_cycle_3_busy : i1
      llhd.drv %reg_busy_sel, %666 after %1 : i1
      cf.br ^bb44
    ^bb27:  // pred: ^bb25
      %667 = llhd.prb %addr_hit : i23
      %668 = comb.extract %667 from 15 : (i23) -> i1
      %669 = comb.icmp ceq %668, %true : i1
      cf.cond_br %669, ^bb28, ^bb29
    ^bb28:  // pred: ^bb27
      %670 = llhd.prb %duty_cycle_4_busy : i1
      llhd.drv %reg_busy_sel, %670 after %1 : i1
      cf.br ^bb44
    ^bb29:  // pred: ^bb27
      %671 = llhd.prb %addr_hit : i23
      %672 = comb.extract %671 from 16 : (i23) -> i1
      %673 = comb.icmp ceq %672, %true : i1
      cf.cond_br %673, ^bb30, ^bb31
    ^bb30:  // pred: ^bb29
      %674 = llhd.prb %duty_cycle_5_busy : i1
      llhd.drv %reg_busy_sel, %674 after %1 : i1
      cf.br ^bb44
    ^bb31:  // pred: ^bb29
      %675 = llhd.prb %addr_hit : i23
      %676 = comb.extract %675 from 17 : (i23) -> i1
      %677 = comb.icmp ceq %676, %true : i1
      cf.cond_br %677, ^bb32, ^bb33
    ^bb32:  // pred: ^bb31
      %678 = llhd.prb %blink_param_0_busy : i1
      llhd.drv %reg_busy_sel, %678 after %1 : i1
      cf.br ^bb44
    ^bb33:  // pred: ^bb31
      %679 = llhd.prb %addr_hit : i23
      %680 = comb.extract %679 from 18 : (i23) -> i1
      %681 = comb.icmp ceq %680, %true : i1
      cf.cond_br %681, ^bb34, ^bb35
    ^bb34:  // pred: ^bb33
      %682 = llhd.prb %blink_param_1_busy : i1
      llhd.drv %reg_busy_sel, %682 after %1 : i1
      cf.br ^bb44
    ^bb35:  // pred: ^bb33
      %683 = llhd.prb %addr_hit : i23
      %684 = comb.extract %683 from 19 : (i23) -> i1
      %685 = comb.icmp ceq %684, %true : i1
      cf.cond_br %685, ^bb36, ^bb37
    ^bb36:  // pred: ^bb35
      %686 = llhd.prb %blink_param_2_busy : i1
      llhd.drv %reg_busy_sel, %686 after %1 : i1
      cf.br ^bb44
    ^bb37:  // pred: ^bb35
      %687 = llhd.prb %addr_hit : i23
      %688 = comb.extract %687 from 20 : (i23) -> i1
      %689 = comb.icmp ceq %688, %true : i1
      cf.cond_br %689, ^bb38, ^bb39
    ^bb38:  // pred: ^bb37
      %690 = llhd.prb %blink_param_3_busy : i1
      llhd.drv %reg_busy_sel, %690 after %1 : i1
      cf.br ^bb44
    ^bb39:  // pred: ^bb37
      %691 = llhd.prb %addr_hit : i23
      %692 = comb.extract %691 from 21 : (i23) -> i1
      %693 = comb.icmp ceq %692, %true : i1
      cf.cond_br %693, ^bb40, ^bb41
    ^bb40:  // pred: ^bb39
      %694 = llhd.prb %blink_param_4_busy : i1
      llhd.drv %reg_busy_sel, %694 after %1 : i1
      cf.br ^bb44
    ^bb41:  // pred: ^bb39
      %695 = llhd.prb %addr_hit : i23
      %696 = comb.extract %695 from 22 : (i23) -> i1
      %697 = comb.icmp ceq %696, %true : i1
      cf.cond_br %697, ^bb42, ^bb43
    ^bb42:  // pred: ^bb41
      %698 = llhd.prb %blink_param_5_busy : i1
      llhd.drv %reg_busy_sel, %698 after %1 : i1
      cf.br ^bb44
    ^bb43:  // pred: ^bb41
      llhd.drv %reg_busy_sel, %false after %1 : i1
      cf.br ^bb44
    ^bb44:  // 22 preds: ^bb2, ^bb4, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb18, ^bb20, ^bb22, ^bb24, ^bb26, ^bb28, ^bb30, ^bb32, ^bb34, ^bb36, ^bb38, ^bb40, ^bb42, ^bb43
      llhd.wait (%591, %500, %593, %594, %595, %596, %597, %598, %599, %600, %601, %602, %603, %604, %605, %606, %607, %608, %609, %610, %611, %612, %613 : i1, i23, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1, i1), ^bb1
    }
    llhd.drv %clk_i_0, %clk_i after %1 : i1
    llhd.drv %rst_ni_1, %rst_ni after %1 : i1
    %614 = llhd.prb %reg2hw : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
    llhd.drv %racl_policies_i_2, %racl_policies_i after %1 : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>
    hw.output %u_rsp_intg_gen.tl_o, %614, %11, %357 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>, !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, i1
  }
  hw.module @pwm(in %clk_i : i1, in %rst_ni : i1, in %clk_core_i : i1, in %rst_core_ni : i1, in %tl_i : !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, out tl_o : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, in %alert_rx_i : !hw.array<1xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, out alert_tx_o : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>, in %racl_policies_i : !hw.array<1xstruct<write_perm: i2, read_perm: i2>>, out racl_error_o : !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, out cio_pwm_o : i6, out cio_pwm_en_o : i6) {
    %c-1_i6 = hw.constant -1 : i6
    %0 = llhd.constant_time <0ns, 0d, 1e>
    %c0_i0 = hw.constant 0 : i0
    %false = hw.constant false
    %1 = hw.aggregate_constant [[false, false]] : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    %alert_tx_o = llhd.sig %1 : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    %alerts = llhd.sig %false : i1
    %u_reg.tl_o, %u_reg.reg2hw, %u_reg.racl_error_o, %u_reg.intg_err_o = hw.instance "u_reg" @pwm_reg_top(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, clk_core_i: %clk_core_i: i1, rst_core_ni: %rst_core_ni: i1, tl_i: %tl_i: !hw.struct<a_valid: i1, a_opcode: i3, a_param: i3, a_size: i2, a_source: i8, a_address: i32, a_mask: i4, a_data: i32, a_user: !hw.struct<rsvd: i5, instr_type: i4, cmd_intg: i7, data_intg: i7>, d_ready: i1>, racl_policies_i: %racl_policies_i: !hw.array<1xstruct<write_perm: i2, read_perm: i2>>) -> (tl_o: !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, reg2hw: !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>, racl_error_o: !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, intg_err_o: i1) {sv.namehint = "reg2hw"}
    llhd.drv %alerts, %u_reg.intg_err_o after %0 : i1
    %2 = llhd.prb %alerts : i1
    %3 = hw.array_get %alert_rx_i[%c0_i0] : !hw.array<1xstruct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>>, i0
    %4 = llhd.sig.array_get %alert_tx_o[%c0_i0] : <!hw.array<1xstruct<alert_p: i1, alert_n: i1>>>
    %gen_alert_tx_0.u_prim_alert_sender.alert_ack_o, %gen_alert_tx_0.u_prim_alert_sender.alert_state_o, %gen_alert_tx_0.u_prim_alert_sender.alert_tx_o = hw.instance "gen_alert_tx_0.u_prim_alert_sender" @prim_alert_sender(clk_i: %clk_i: i1, rst_ni: %rst_ni: i1, alert_test_i: %5: i1, alert_req_i: %2: i1, alert_rx_i: %3: !hw.struct<ping_p: i1, ping_n: i1, ack_p: i1, ack_n: i1>) -> (alert_ack_o: i1, alert_state_o: i1, alert_tx_o: !hw.struct<alert_p: i1, alert_n: i1>)
    llhd.drv %4, %gen_alert_tx_0.u_prim_alert_sender.alert_tx_o after %0 : !hw.struct<alert_p: i1, alert_n: i1>
    %u_pwm_core.pwm_o = hw.instance "u_pwm_core" @pwm_core(clk_core_i: %clk_core_i: i1, rst_core_ni: %rst_core_ni: i1, reg2hw: %u_reg.reg2hw: !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>) -> (pwm_o: i6)
    %alert_test = hw.struct_extract %u_reg.reg2hw["alert_test"] : !hw.struct<alert_test: !hw.struct<q: i1, qe: i1>, cfg: !hw.struct<cntr_en: !hw.struct<q: i1, qe: i1>, dc_resn: !hw.struct<q: i4, qe: i1>, clk_div: !hw.struct<q: i27, qe: i1>>, pwm_en: !hw.array<6xstruct<q: i1, qe: i1>>, invert: !hw.array<6xstruct<q: i1, qe: i1>>, pwm_param: !hw.array<6xstruct<blink_en: !hw.struct<q: i1, qe: i1>, htbt_en: !hw.struct<q: i1, qe: i1>, phase_delay: !hw.struct<q: i16, qe: i1>>>, duty_cycle: !hw.array<6xstruct<b: !hw.struct<q: i16, qe: i1>, a: !hw.struct<q: i16, qe: i1>>>, blink_param: !hw.array<6xstruct<y: !hw.struct<q: i16, qe: i1>, x: !hw.struct<q: i16, qe: i1>>>>
    %q = hw.struct_extract %alert_test["q"] : !hw.struct<q: i1, qe: i1>
    %qe = hw.struct_extract %alert_test["qe"] : !hw.struct<q: i1, qe: i1>
    %5 = comb.and %q, %qe : i1
    %6 = llhd.prb %alert_tx_o : !hw.array<1xstruct<alert_p: i1, alert_n: i1>>
    hw.output %u_reg.tl_o, %6, %u_reg.racl_error_o, %u_pwm_core.pwm_o, %c-1_i6 : !hw.struct<d_valid: i1, d_opcode: i3, d_param: i3, d_size: i2, d_source: i8, d_sink: i1, d_data: i32, d_user: !hw.struct<rsp_intg: i7, data_intg: i7>, d_error: i1, a_ready: i1>, !hw.array<1xstruct<alert_p: i1, alert_n: i1>>, !hw.struct<valid: i1, overflow: i1, racl_role: i1, ctn_uid: i1, read_access: i1, request_address: i32>, i6, i6
  }
}
